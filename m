Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD266EFBA9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 22:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbjDZUdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 16:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZUdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 16:33:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FBF212E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 13:33:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f8a3f1961so68092617b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 13:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682541179; x=1685133179;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MsgPsrUA7pZr2poVzmEsLw5CPMy5beCZQnaEI4bsMpM=;
        b=7ktCRMMXoavpPo+oNTHeDKKUE2nqiLnaUL0Jez61kvhTdEzPAgY8c1dYCLPFVJtNRi
         o1DulXO9gD+Xp0GRoZUnkFK0T7HZ/WfLMpHP3P54mLE7Zmh7a7IjFshrDUqbWrHPC4UY
         cYKUojkhCq07wF45ihjARmMr2sp+yrq/CgxnZsU9rBoHVGmbia8wHhq+W7NxaIbTxd7T
         ARNxmVD2aVEJm4OQJG3ycIGd/vDp965VXtQPCWTR/5urg1B6JByEbdsUctVLFB906sri
         RZofaQPIYN0eZo9ETpL5eBauFErEy5zTs/eji8Edo2r/ykhhSUtXqr8tKcAAa5p6yEcK
         Cl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682541179; x=1685133179;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MsgPsrUA7pZr2poVzmEsLw5CPMy5beCZQnaEI4bsMpM=;
        b=OMA/6GTYArsI0IE3SI3KR2cyAxHvrUUKVabp+XEpC59Q0LpdSyIGqeoLqxxfz+DYUw
         YiB6r6lEqr5+VnBPu0sLni9SkCLAXFrgjDicvk8ckBuFloZfh4z0PMmho5oToDc2X4fa
         AIHGWx+QJ3s7Aq1P2drl+UsftwUFBrjmERNLTV+kou7R+7yCGvhFqJu0bY9Cw04VnljZ
         eecwJ9iCWiOusidHKP8J+956qMnVCGgWXPuMsLJVTGMlKwQ2MvulUp+qTftgwNJeN1DW
         Cdmx0G5ej9I3LKkUJKzyQ137NCSbRhpMbcgXLJJasJtWWmZY+vCC8wIJF7V+zUad11Jt
         8Xyg==
X-Gm-Message-State: AAQBX9d7JRGXvIveKR/7EGlInRrUEp2NHlWvMTZb6IpmikgsnWlcTL3W
        0XyRINq/WazSYX4f6+2A8iUSJ4IXqBI=
X-Google-Smtp-Source: AKy350aDwcz+0RCf2miA99jakkRJFi3cWpYYZ10pS+QEGUbpo1c7VFj4UdHoxewp/Jy2APK3HEbhinMt4+s=
X-Received: from pandoh.svl.corp.google.com ([2620:15c:2c5:11:cf46:dfd0:d5c4:864c])
 (user=pandoh job=sendgmr) by 2002:a81:450c:0:b0:545:883a:544d with SMTP id
 s12-20020a81450c000000b00545883a544dmr10795000ywa.9.1682541179541; Wed, 26
 Apr 2023 13:32:59 -0700 (PDT)
Date:   Wed, 26 Apr 2023 13:32:56 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230426203256.237116-1-pandoh@google.com>
Subject: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
From:   Jon Pan-Doh <pandoh@google.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Nadav Amit <namit@vmware.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
        Sudheer Dantuluri <dantuluris@google.com>,
        Gary Zibrat <gzibrat@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running on an AMD vIOMMU, we observed multiple invalidations (of
decreasing power of 2 aligned sizes) when unmapping a single page.

Domain flush takes gather bounds (end-start) as size param. However,
gather->end is defined as the last inclusive address (start + size - 1).
This leads to an off by 1 error.

With this patch, verified that 1 invalidation occurs when unmapping a
single page.

Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a VM")
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Tested-by: Sudheer Dantuluri <dantuluris@google.com>
Suggested-by: Gary Zibrat <gzibrat@google.com>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5a505ba5467e..da45b1ab042d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2378,7 +2378,7 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
 	unsigned long flags;
 
 	spin_lock_irqsave(&dom->lock, flags);
-	domain_flush_pages(dom, gather->start, gather->end - gather->start, 1);
+	domain_flush_pages(dom, gather->start, gather->end - gather->start + 1, 1);
 	amd_iommu_domain_flush_complete(dom);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
-- 
2.40.0.634.g4ca3ef3211-goog

