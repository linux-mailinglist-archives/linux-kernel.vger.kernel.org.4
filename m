Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16C865BE7F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbjACK44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbjACK4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:56:54 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E879E096
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1672743403; bh=oNYF4pzEaAnYnEpzvzjLME7qGqVRc2/8UlmMC64c5Jg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=eyFY5Of7InJ/X3RnIWhI6rtfOeGmAM+D27h+U03rwAkGd5luBQ9nMhX/VTiq4FAyY
         Bv8gVUGk4fkjT8s2VCeIhqkOT6ceV60uL85Sn+s//90fb5nSj6YXw+86mk0mRbOe06
         6GrU6ogsxCUYu4Au/YI+KYGqX9d09xBueG8NDIEs=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue,  3 Jan 2023 11:56:43 +0100 (CET)
X-EA-Auth: rdJ5S1EG72eSCgTZuI9ynn+6BkPv/y5JmmNxDwmqIicELpIhZGvO4XFp6KW03WAhZL/vghevtD3SkgaYJc9kQsFk9KB2Axsg
Date:   Tue, 3 Jan 2023 16:26:38 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH v3] ARM/dma-mapping: use kvcalloc for fallback memory
 allocation need
Message-ID: <Y7QJ5rahtDBz2WNO@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current conditional determination of whether to use kzalloc or vzalloc
has known issues such as "indefinite retry" when less than PAGE_SIZE
memory is needed, but is unavailable. This LWN article [1] describes
these issues in greater detail. Use helper function kvcalloc() instead
which is more efficient in terms of performance and security.

 	[1] https://lwn.net/Articles/711653/

This patch proposal is based on following Coccinelle warning using the
kvmalloc.cocci semantic patch.
	arch/arm/mm/dma-mapping.c:858:28-29: WARNING opportunity for kvmalloc

The semantic patch suggests using kvzalloc() helper function, however,
this patch proposes to use kvcalloc instead. kvcalloc() helper function
uses 2-factor argument form which is better from a security perspective
as described in the following KSPP project commit.

	Commit 4e3fd7217105 ("wireguard: ratelimiter: use kvcalloc() instead of kvzalloc()")

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Changes in v3:
   1. Use updated maintainer list to send the patch.
      Suggested by "Russell King (Oracle)" <linux@armlinux.org.uk>

Changes in v2:
   1. Update patch subject to use kvcalloc
   2. Use kvcalloc instead of kvzalloc helper function. Revise the patch
      proposal and the patch description accordingly.

 arch/arm/mm/dma-mapping.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c135f6e37a00..35092ecd30e1 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -851,14 +851,10 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 {
 	struct page **pages;
 	int count = size >> PAGE_SHIFT;
-	int array_size = count * sizeof(struct page *);
 	int i = 0;
 	int order_idx = 0;

-	if (array_size <= PAGE_SIZE)
-		pages = kzalloc(array_size, GFP_KERNEL);
-	else
-		pages = vzalloc(array_size);
+	pages = kvcalloc(count, sizeof(struct page *), GFP_KERNEL);
 	if (!pages)
 		return NULL;

--
2.34.1



