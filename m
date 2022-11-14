Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5CE627B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbiKNLDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbiKNLDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:03:44 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C550111A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:03:43 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so13413066pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wulaqFmz/16KbqnxhxcVgelYxnEambXsRQ1dqrt/q5w=;
        b=LrdXKb/jllsa3/8C9UROuiSf25VBPlOrjTAqiK+seBx9Gh4tMhNNgmUhbdwrUhX5s6
         coS6SKNfn1yAu9EO+xHyOBJkZbug2wb/7/0feFzOTnISHWYWb1dFj11Aq8olGsBLbSIw
         Lasw0Jx54i9hcnZMCpNR2ommOUtheoKrcAHsyTsZNUOKazAqobN3G+MNhC8RRxm+OD+c
         oGQsnPXH+1l7SjJ0/kvn5EIHhkkZJMJnXt8gExdyfru/QkaRH2/CuOnXAAfG36Njsska
         KJwLOLWW5RcUbUEzsJDahWlJI1JKZnFyXrY63sz6DQw91RBUPYKqvgQsTdMOgzRViW8Y
         EvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wulaqFmz/16KbqnxhxcVgelYxnEambXsRQ1dqrt/q5w=;
        b=1G9JYbtjKOpgi1tcf/SBjD/54lbVN6JOd0AXIJ/C9rhjCeU5WoTA40BMXq8mQ0mvUu
         lrWd6Npfj8Gm2H7OfVqLaKMLhhgPw+H4npcn2eLEbeU6+rwthVllLsR42CLqqjufnn2P
         lRp0x3UJMGph6NUNR90+OFQcc+EMBZBrhADSITq7+Vd2e8IoJLlkX6eb0wphnNxSUJkv
         iP4/CDCItUjBX6TsdyC7WcznXJKZwDz2SRlOcembEKiToAhIzLGBad6WNeSXPcyq++g9
         RGE4KmahZ5cxOrXlHWb7jjOujFwooiwlIyDgLVFKqZ1isCIeXM6Bgksnhn44ATqpUCP7
         sjVw==
X-Gm-Message-State: ANoB5plUUEPt4m7h6uM71/pqUxXkzjeN7kpZQRI3FXPr/zTWAL2g99hZ
        a8iJP/AeGAi322iafjAEbijn
X-Google-Smtp-Source: AA0mqf4z5klKDNd7D8HapU+aoGS9gKR/21Ze7VupYI4H3pbyQVbPjgNOxv7/N+wYbbxFruOLFSMKuw==
X-Received: by 2002:a17:902:ef50:b0:17f:799b:297d with SMTP id e16-20020a170902ef5000b0017f799b297dmr13107125plx.72.1668423822795;
        Mon, 14 Nov 2022 03:03:42 -0800 (PST)
Received: from localhost.localdomain ([117.248.0.54])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903244c00b0017f592a7eccsm7128773pls.298.2022.11.14.03.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 03:03:41 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     robin.murphy@arm.com, amit.pundir@linaro.org, andersson@kernel.org,
        quic_sibis@quicinc.com, sumit.semwal@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] Revert "arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()"
Date:   Mon, 14 Nov 2022 16:33:29 +0530
Message-Id: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c44094eee32f32f175aadc0efcac449d99b1bbf7.

As reported by Amit [1], dropping cache invalidation from
arch_dma_prep_coherent() triggers a crash on the Qualcomm SM8250 platform
(most probably on other Qcom platforms too). The reason is, Qcom
qcom_q6v5_mss driver copies the firmware metadata and shares it with modem
for validation. The modem has a secure block (XPU) that will trigger a
whole system crash if the shared memory is accessed by the CPU while modem
is poking at it.

To avoid this issue, the qcom_q6v5_mss driver allocates a chunk of memory
with no kernel mapping, vmap's it, copies the firmware metadata and
unvmap's it. Finally the address is then shared with modem for metadata
validation [2].

Now because of the removal of cache invalidation from
arch_dma_prep_coherent(), there will be cache lines associated with this
memory even after sharing with modem. So when the CPU accesses it, the XPU
violation gets triggered.

So let's revert this commit to get remoteproc's working (thereby avoiding
full system crash) on Qcom platforms.

[1] https://lore.kernel.org/linux-arm-kernel/CAMi1Hd1VBCFhf7+EXWHQWcGy4k=tcyLa7RGiFdprtRnegSG0Mw@mail.gmail.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/remoteproc/qcom_q6v5_mss.c#n933

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Will, Catalin: Please share if you have any other suggestions to handle the
resource sharing in the remoteproc driver that could avoid this revert.

 arch/arm64/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 3cb101e8cb29..7d7e9a046305 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -36,7 +36,7 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 {
 	unsigned long start = (unsigned long)page_address(page);
 
-	dcache_clean_poc(start, start + size);
+	dcache_clean_inval_poc(start, start + size);
 }
 
 #ifdef CONFIG_IOMMU_DMA
-- 
2.25.1

