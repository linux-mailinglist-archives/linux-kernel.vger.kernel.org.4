Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112A7742FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjF2VwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjF2VwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:52:07 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE4D30D1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1688075522; bh=zk8RNtYdPSPBv7E+7W/pedrI7qf8NuNNmYmsN5VZIDs=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
        b=XRJ6RXTGWMzmNmFQPq6/3+6nTNCsgdDbGCtgIUBkpBLTTHSPoohOMaJwJ2j5xRlFp
         wJ5Vde45Sx+Jf2LjWEssmIj/ALt7Ks1UuCaoC8ebXUreJZPe2FXRYVnkFcO4CirQIQ
         mI7ftE1KkbmoXHL8hjukzCbjA8jyQHdAg9Brlsf8=
Received: by b221-5.in.mailobj.net [192.168.90.25] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Thu, 29 Jun 2023 23:52:02 +0200 (CEST)
X-EA-Auth: IotyenF4/umU0ZnNEfNRYcA4iNvIyKfnNgylSBABxKCWziWNjq5HJWJd2DAbytP60ExoGcmb2zoNuRUeth0oMxjaLd/N/tX+
Date:   Fri, 30 Jun 2023 03:21:53 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH v3 5/6] gfs2: Replace kmap() by kmap_local_page() in
 gfs2_read_super
Message-ID: <7ad72f9d1a97d673483c206d8ac9a88f2e32d3b9.1688073459.git.drv@mailo.com>
References: <cover.1688073459.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1688073459.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Therefore, replace kmap() with kmap_local_page() in gfs2_read_super().

Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Changes in v3:
   - Patch included in patch set

Changes in v2:
   - None

 fs/gfs2/ops_fstype.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 8a27957dbfee..80fe61662412 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -264,9 +264,9 @@ static int gfs2_read_super(struct gfs2_sbd *sdp, sector_t sector, int silent)
 		__free_page(page);
 		return -EIO;
 	}
-	p = kmap(page);
+	p = kmap_local_page(page);
 	gfs2_sb_in(sdp, p);
-	kunmap(page);
+	kunmap_local(p);
 	__free_page(page);
 	return gfs2_check_sb(sdp, silent);
 }
-- 
2.34.1



