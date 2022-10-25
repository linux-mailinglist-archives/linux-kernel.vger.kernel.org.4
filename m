Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56C960D207
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiJYQyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJYQyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:54:40 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF2C1EAC9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:54:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k8so13493834wrh.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3Fgy6ar1zYHVJgyinsGrfKVrX6mZaQbt8q/dXIx19k=;
        b=KxaheGRKnwqkzce0a2Zgx3U/pr8SwK/9NCPKKP5oFz0u5wQGk3AnnzyNdNH1vzKhNt
         aS38eOd7IygJ3U6NfjWm/4uSFbulrRqvzT66xYqDXJ1C2kaZH/65eWYUyeq5/VoJk2er
         I8ZYKO4NQ2QVVFvqc3WEE7Cg2xbbCQ/j/kMoyQre2PvipucNkplMtMdibxfa+uN7z36i
         /rOnVYYfwtclXaARGXp04ftjtb/U8N9lmTzZB4B3hHLUQvFH+YlrGcmgvRZjgKk/wNLX
         Y5ezx5boqZGMzV/tVSb8P9hlXVS/CphlLNvdyHdjOh/7KSz3pBv32zfQCxzVrkWZzlnB
         B7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3Fgy6ar1zYHVJgyinsGrfKVrX6mZaQbt8q/dXIx19k=;
        b=r+GeozudndzFkb5Cn8UbkkrETZlOkpDl5LKydfOIbowEMteO3lsvIpBXSjjb/sKB1p
         GaZGrDcNjzhKg8KxFVD75iG0vClKjAkmqc+h6ZmAReLrDEzRQNOxsQ813NRC4oLVKrEI
         l7sbn1bAXdzzh1sz0Dx9BpXG0KYQD2wswi1CtgItalEi2Tsen1WrGbJox7eu+yTAqEvQ
         Mf8vEQcLMoMwjRJX36Zgtne8JMu1zz9G+tEe7S78Qbqb1MYGr7ZsCdjHY31/MIJJ9O6o
         kBGB6WZPXeslEyHvQxHzaRd7aQRscO7OQGdgllCd4+Mzz2MK6ujobFQVSclV8VO9Rp5Z
         MzEg==
X-Gm-Message-State: ACrzQf1MjCaTTleZsuz4mAEWzM18xaVuBXQHTvpfknycCE4TokGceGKn
        a7WGuSPpKserYHj09dm7ME8=
X-Google-Smtp-Source: AMsMyM4mnIoUAmW2Rq4/080WHIpzCDO/JXtDEmGAjFfYXWF/GvrKNswK4DUiHI4n8ZHXPJLxCkaG+Q==
X-Received: by 2002:adf:e484:0:b0:236:6a2e:154e with SMTP id i4-20020adfe484000000b002366a2e154emr9844814wrm.664.1666716876981;
        Tue, 25 Oct 2022 09:54:36 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c349400b003a6a3595edasm3023989wmq.27.2022.10.25.09.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 09:54:36 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     maxime@cerno.tech, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com
Cc:     wens@csie.org, samuel@sholland.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 3/5] iommu/sun50i: Fix R/W permission check
Date:   Tue, 25 Oct 2022 18:54:13 +0200
Message-Id: <20221025165415.307591-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025165415.307591-1-jernej.skrabec@gmail.com>
References: <20221025165415.307591-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because driver has enum type permissions and iommu subsystem has bitmap
type, we have to be careful how check for combined read and write
permissions is done. In such case, we have to mask both permissions and
check that both are set at the same time.

Current code just masks both flags but doesn't check that both are set.
In short, it always sets R/W permission, regardles if requested
permissions were RO, WO or RW. Fix that.

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index bbc269500800..df871af04bcb 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -271,7 +271,7 @@ static u32 sun50i_mk_pte(phys_addr_t page, int prot)
 	enum sun50i_iommu_aci aci;
 	u32 flags = 0;
 
-	if (prot & (IOMMU_READ | IOMMU_WRITE))
+	if ((prot & (IOMMU_READ | IOMMU_WRITE)) == (IOMMU_READ | IOMMU_WRITE))
 		aci = SUN50I_IOMMU_ACI_RD_WR;
 	else if (prot & IOMMU_READ)
 		aci = SUN50I_IOMMU_ACI_RD;
-- 
2.38.1

