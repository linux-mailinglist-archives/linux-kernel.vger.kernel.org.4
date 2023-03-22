Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E776B6C49FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjCVMK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCVMK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705CA5DEC4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679487009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hZCSBOFZs4bkOWaMU96a/OIFoJth3tDCdyrQdmx4OyE=;
        b=LNzpgXJmwWdukL53k7yQ9TthOFenOUUSIwUrZR4ofSTyurEJAAg6fMUJGs/7ZrkwZFGrIU
        dZtQ0lX8v+hOrpEHrDujNFaLpLorQQgYLhcvs/4Tj7Acviny1FYyz8NBzHDhd9ZFTT2nQo
        vRJe1BsDp2FQC1OBzKwEccsmOLZPos8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-eLky3mCcPRiZQO49o4SD-A-1; Wed, 22 Mar 2023 08:10:06 -0400
X-MC-Unique: eLky3mCcPRiZQO49o4SD-A-1
Received: by mail-qv1-f69.google.com with SMTP id w2-20020a0cc242000000b00583d8e55181so9175557qvh.23
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679487006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZCSBOFZs4bkOWaMU96a/OIFoJth3tDCdyrQdmx4OyE=;
        b=n4WRGqjwbzpe+dVJ/yk7ysmQPqn/6YC7Ckq9pnF47jNBxp1o+rFuIZN+/81TgDG0+S
         /I1j+GwzAyKYiEXwy416dIqTmdx3OEbOuQLRgE37J2KcHuHBKXzZjgzk13hzNeNMVRU2
         02LgHNcoD+UyvmH/Bhyc+kZZA3Jyw/KHInQThKlTOw7+ukhQWzgLwzPfL+bmjOQqTTel
         rXz53V5ghZV2ICbQemuUXxempNYut19U46wd50SOD3F7ioUf/6cNiw8K3a9pTGpV3ITB
         dc2uKac5aX/m7IgQTmgTIQMYje3WNd0ngB/szIsi2m2PHS8Nzl592okKYxh1LVR0TCWH
         717w==
X-Gm-Message-State: AO0yUKWlJCcEYOZjldfvqRu7/p0MYMwrZIb/My5TvRiBHEMfqr6p28cs
        afRlmlYRpchIvoL/0ntnPAOi3GoCoo96p640zO/GTKmh0IIUYvmKCk3+YUuyLlmRKKLTyX3AqEs
        sGc5gXCdAtcdtWlyAOBVq9bjD
X-Received: by 2002:a05:622a:1354:b0:3bf:dc7d:2221 with SMTP id w20-20020a05622a135400b003bfdc7d2221mr5538829qtk.47.1679487006004;
        Wed, 22 Mar 2023 05:10:06 -0700 (PDT)
X-Google-Smtp-Source: AK7set9kJIiglNnHWmwnAgvPqP7BHrdzvpjmZvpPWl/1axq5Z7bYHV045R+cDjo20tgQiJGFKa42Xw==
X-Received: by 2002:a05:622a:1354:b0:3bf:dc7d:2221 with SMTP id w20-20020a05622a135400b003bfdc7d2221mr5538790qtk.47.1679487005680;
        Wed, 22 Mar 2023 05:10:05 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b17-20020ac86791000000b003b9bb59543fsm9757855qtp.61.2023.03.22.05.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 05:10:05 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     ldewangan@nvidia.com, jonathanh@nvidia.com, vkoul@kernel.org,
        thierry.reding@gmail.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] dmaengine: tegra-apb: remove unused tdma_read function
Date:   Wed, 22 Mar 2023 08:10:01 -0400
Message-Id: <20230322121001.2569909-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/dma/tegra20-apb-dma.c:236:19: error: unused function
  'tdma_read' [-Werror,-Wunused-function]
static inline u32 tdma_read(struct tegra_dma *tdma, u32 reg)
                  ^
This function is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/dma/tegra20-apb-dma.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index eaafcbe4ca94..cc6b91f48979 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -233,11 +233,6 @@ static inline void tdma_write(struct tegra_dma *tdma, u32 reg, u32 val)
 	writel(val, tdma->base_addr + reg);
 }
 
-static inline u32 tdma_read(struct tegra_dma *tdma, u32 reg)
-{
-	return readl(tdma->base_addr + reg);
-}
-
 static inline void tdc_write(struct tegra_dma_channel *tdc,
 			     u32 reg, u32 val)
 {
-- 
2.27.0

