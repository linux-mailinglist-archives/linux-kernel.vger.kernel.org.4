Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FD35F25E9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 00:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJBWUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 18:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiJBWUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 18:20:45 -0400
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [IPv6:2a0c:5a00:149::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082072D754
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 15:20:43 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <m.v.b@runbox.com>)
        id 1of7KD-009oki-Jk; Mon, 03 Oct 2022 00:20:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
         s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
        :Message-Id:Date:Subject:Cc:To:From;
        bh=+Vie5gCZlh7QnEM5LNxxIlolyHehCAwhUeGnQuCZCG0=; b=EZXHAHDS8IVNmG694ijMXgA1Pt
        1z/7+aVAN/itRJpFoSIC1u6kfGApGr8EWO7gKXvlilauTHt8gJvXSoVojZorlGNOLBmmTYB6BR/tW
        bDOFIOzeONac7Aat1QAEb6uflXvMkZs2qsGHdQsheYhXgcLlnm9jsMvQ0n6RKZq3RZ7RlGeDr+n3I
        ldeKPtVtebOfP/clRJBtegyCYcJ0hS+mSHfHcaVYxhKFppc5JjN2B4uT3UkPqnaQJw/1ELMlotkdm
        F+PEI/rQqnLpIwla60ZblaUxAlUf0uBBW3eG8SeYyeS4/4A+AAIdcPGdBuogG28RH46gSbE8mXdX2
        +PTE01qA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <m.v.b@runbox.com>)
        id 1of7K7-0006iK-RD; Mon, 03 Oct 2022 00:20:35 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (536975)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1of7Jy-00061b-Dp; Mon, 03 Oct 2022 00:20:26 +0200
From:   "M. Vefa Bicakci" <m.v.b@runbox.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     m.v.b@runbox.com, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 1/2] xen/gntdev: Prevent leaking grants
Date:   Sun,  2 Oct 2022 18:20:05 -0400
Message-Id: <20221002222006.2077-2-m.v.b@runbox.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221002222006.2077-1-m.v.b@runbox.com>
References: <20221002222006.2077-1-m.v.b@runbox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to this commit, if a grant mapping operation failed partially,
some of the entries in the map_ops array would be invalid, whereas all
of the entries in the kmap_ops array would be valid. This in turn would
cause the following logic in gntdev_map_grant_pages to become invalid:

  for (i = 0; i < map->count; i++) {
    if (map->map_ops[i].status == GNTST_okay) {
      map->unmap_ops[i].handle = map->map_ops[i].handle;
      if (!use_ptemod)
        alloced++;
    }
    if (use_ptemod) {
      if (map->kmap_ops[i].status == GNTST_okay) {
        if (map->map_ops[i].status == GNTST_okay)
          alloced++;
        map->kunmap_ops[i].handle = map->kmap_ops[i].handle;
      }
    }
  }
  ...
  atomic_add(alloced, &map->live_grants);

Assume that use_ptemod is true (i.e., the domain mapping the granted
pages is a paravirtualized domain). In the code excerpt above, note that
the "alloced" variable is only incremented when both kmap_ops[i].status
and map_ops[i].status are set to GNTST_okay (i.e., both mapping
operations are successful).  However, as also noted above, there are
cases where a grant mapping operation fails partially, breaking the
assumption of the code excerpt above.

The aforementioned causes map->live_grants to be incorrectly set. In
some cases, all of the map_ops mappings fail, but all of the kmap_ops
mappings succeed, meaning that live_grants may remain zero. This in turn
makes it impossible to unmap the successfully grant-mapped pages pointed
to by kmap_ops, because unmap_grant_pages has the following snippet of
code at its beginning:

  if (atomic_read(&map->live_grants) == 0)
    return; /* Nothing to do */

In other cases where only some of the map_ops mappings fail but all
kmap_ops mappings succeed, live_grants is made positive, but when the
user requests unmapping the grant-mapped pages, __unmap_grant_pages_done
will then make map->live_grants negative, because the latter function
does not check if all of the pages that were requested to be unmapped
were actually unmapped, and the same function unconditionally subtracts
"data->count" (i.e., a value that can be greater than map->live_grants)
from map->live_grants. The side effects of a negative live_grants value
have not been studied.

The net effect of all of this is that grant references are leaked in one
of the above conditions. In Qubes OS v4.1 (which uses Xen's grant
mechanism extensively for X11 GUI isolation), this issue manifests
itself with warning messages like the following to be printed out by the
Linux kernel in the VM that had granted pages (that contain X11 GUI
window data) to dom0: "g.e. 0x1234 still pending", especially after the
user rapidly resizes GUI VM windows (causing some grant-mapping
operations to partially or completely fail, due to the fact that the VM
unshares some of the pages as part of the window resizing, making the
pages impossible to grant-map from dom0).

The fix for this issue involves counting all successful map_ops and
kmap_ops mappings separately, and then adding the sum to live_grants.
During unmapping, only the number of successfully unmapped grants is
subtracted from live_grants. The code is also modified to check for
negative live_grants values after the subtraction and warn the user.

Link: https://github.com/QubesOS/qubes-issues/issues/7631
Fixes: dbe97cff7dd9 ("xen/gntdev: Avoid blocking in unmap_grant_pages()")
Cc: stable@vger.kernel.org
Signed-off-by: M. Vefa Bicakci <m.v.b@runbox.com>
---

Changes since v1:
- To determine which unmap operations were successful, the previous
  version of this patch set the "unmap_ops[i].status" and
  "kunmap_ops[i].status" fields to the value "1" prior to passing these
  data structures to the hypervisor. Instead of doing that, the code now
  checks whether the "handle" fields in the same data structures were
  *not* set to "INVALID_GRANT_HANDLE". (Suggested by Juergen Gross.)
---
 drivers/xen/gntdev.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 84b143eef395..eb0586b9767d 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -367,8 +367,7 @@ int gntdev_map_grant_pages(struct gntdev_grant_map *map)
 	for (i = 0; i < map->count; i++) {
 		if (map->map_ops[i].status == GNTST_okay) {
 			map->unmap_ops[i].handle = map->map_ops[i].handle;
-			if (!use_ptemod)
-				alloced++;
+			alloced++;
 		} else if (!err)
 			err = -EINVAL;
 
@@ -377,8 +376,7 @@ int gntdev_map_grant_pages(struct gntdev_grant_map *map)
 
 		if (use_ptemod) {
 			if (map->kmap_ops[i].status == GNTST_okay) {
-				if (map->map_ops[i].status == GNTST_okay)
-					alloced++;
+				alloced++;
 				map->kunmap_ops[i].handle = map->kmap_ops[i].handle;
 			} else if (!err)
 				err = -EINVAL;
@@ -394,8 +392,14 @@ static void __unmap_grant_pages_done(int result,
 	unsigned int i;
 	struct gntdev_grant_map *map = data->data;
 	unsigned int offset = data->unmap_ops - map->unmap_ops;
+	int successful_unmaps = 0;
+	int live_grants;
 
 	for (i = 0; i < data->count; i++) {
+		if (map->unmap_ops[offset + i].status == GNTST_okay &&
+		    map->unmap_ops[offset + i].handle != INVALID_GRANT_HANDLE)
+			successful_unmaps++;
+
 		WARN_ON(map->unmap_ops[offset + i].status != GNTST_okay &&
 			map->unmap_ops[offset + i].handle != INVALID_GRANT_HANDLE);
 		pr_debug("unmap handle=%d st=%d\n",
@@ -403,6 +407,10 @@ static void __unmap_grant_pages_done(int result,
 			map->unmap_ops[offset+i].status);
 		map->unmap_ops[offset+i].handle = INVALID_GRANT_HANDLE;
 		if (use_ptemod) {
+			if (map->kunmap_ops[offset + i].status == GNTST_okay &&
+			    map->kunmap_ops[offset + i].handle != INVALID_GRANT_HANDLE)
+				successful_unmaps++;
+
 			WARN_ON(map->kunmap_ops[offset + i].status != GNTST_okay &&
 				map->kunmap_ops[offset + i].handle != INVALID_GRANT_HANDLE);
 			pr_debug("kunmap handle=%u st=%d\n",
@@ -411,11 +419,15 @@ static void __unmap_grant_pages_done(int result,
 			map->kunmap_ops[offset+i].handle = INVALID_GRANT_HANDLE;
 		}
 	}
+
 	/*
 	 * Decrease the live-grant counter.  This must happen after the loop to
 	 * prevent premature reuse of the grants by gnttab_mmap().
 	 */
-	atomic_sub(data->count, &map->live_grants);
+	live_grants = atomic_sub_return(successful_unmaps, &map->live_grants);
+	if (WARN_ON(live_grants < 0))
+		pr_err("%s: live_grants became negative (%d) after unmapping %d pages!\n",
+		       __func__, live_grants, successful_unmaps);
 
 	/* Release reference taken by __unmap_grant_pages */
 	gntdev_put_map(NULL, map);
-- 
2.37.3

