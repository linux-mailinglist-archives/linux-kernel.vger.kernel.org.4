Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA0E73C23D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjFWVPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjFWVPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:15:13 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669CC189;
        Fri, 23 Jun 2023 14:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jd3h5W+nQqo5i0Obf5JwrqgVHs0D/GmiD6Eb1h7EYkk=;
  b=o2bPTbjyvGhNakcmvltIzFi/S0dJfu9Nh1VS5e0zg/1JS++mceceIzEZ
   O7PNODtaLw2mJg4i9aMMzB7XRGoym9HrXS1pKqYtQ7Vsg2bbwPMfmlTgt
   dxCKI7WizKNgfJ8IyzurReMpwe4ujwBPvCygX56mzwX70LBSaRsT9N9j4
   I=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,153,1684792800"; 
   d="scan'208";a="59686159"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 23:15:10 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 01/26] lib/test_vmalloc.c: use array_size
Date:   Fri, 23 Jun 2023 23:14:32 +0200
Message-Id: <20230623211457.102544-2-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230623211457.102544-1-Julia.Lawall@inria.fr>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use array_size to protect against multiplication overflows.

The changes were done using the following Coccinelle semantic patch:

// <smpl>
@@
    size_t e1,e2;
    expression COUNT;
    identifier alloc = {vmalloc,vzalloc,kvmalloc,kvzalloc};
@@

(
      alloc(
-           (e1) * (e2)
+           array_size(e1, e2)
      ,...)
|
      alloc(
-           (e1) * (COUNT)
+           array_size(COUNT, e1)
      ,...)
)

@@
    expression E1, E2;
    constant C1, C2;
    identifier alloc = {vmalloc,vzalloc};
@@
    
(
      alloc(C1 * C2,...)
|
      alloc(
-           (E1) * (E2)
+           array_size(E1, E2)
      ,...)
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 lib/test_vmalloc.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 3718d9886407..d02a47e0a72b 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -156,7 +156,7 @@ static int random_size_alloc_test(void)
 
 	for (i = 0; i < test_loop_count; i++) {
 		n = get_random_u32_inclusive(1, 100);
-		p = vmalloc(n * PAGE_SIZE);
+		p = vmalloc(array_size(n, PAGE_SIZE));
 
 		if (!p)
 			return -1;
@@ -175,7 +175,7 @@ static int long_busy_list_alloc_test(void)
 	int rv = -1;
 	int i;
 
-	ptr = vmalloc(sizeof(void *) * 15000);
+	ptr = vmalloc(array_size(15000, sizeof(void *)));
 	if (!ptr)
 		return rv;
 
@@ -221,11 +221,11 @@ static int full_fit_alloc_test(void)
 	junk_length = fls(num_online_cpus());
 	junk_length *= (32 * 1024 * 1024 / PAGE_SIZE);
 
-	ptr = vmalloc(sizeof(void *) * junk_length);
+	ptr = vmalloc(array_size(junk_length, sizeof(void *)));
 	if (!ptr)
 		return rv;
 
-	junk_ptr = vmalloc(sizeof(void *) * junk_length);
+	junk_ptr = vmalloc(array_size(junk_length, sizeof(void *)));
 	if (!junk_ptr) {
 		vfree(ptr);
 		return rv;
@@ -271,7 +271,7 @@ static int fix_size_alloc_test(void)
 		if (use_huge)
 			ptr = vmalloc_huge((nr_pages > 0 ? nr_pages:1) * PAGE_SIZE, GFP_KERNEL);
 		else
-			ptr = vmalloc((nr_pages > 0 ? nr_pages:1) * PAGE_SIZE);
+			ptr = vmalloc(array_size(nr_pages > 0 ? nr_pages : 1, PAGE_SIZE));
 
 		if (!ptr)
 			return -1;
@@ -293,7 +293,7 @@ pcpu_alloc_test(void)
 	size_t size, align;
 	int i;
 
-	pcpu = vmalloc(sizeof(void __percpu *) * 35000);
+	pcpu = vmalloc(array_size(35000, sizeof(void __percpu *)));
 	if (!pcpu)
 		return -1;
 

