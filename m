Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77676FD671
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbjEJGEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjEJGE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:04:28 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E581640F8
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 23:04:26 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaf7067647so47333765ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 23:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1683698666; x=1686290666;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gu0Ww4Btm3ZJWmUm54OXSmR11HegrPdHhOCTMAKgm2g=;
        b=h8djJvjR8ebEG6ImUF1nkveTqSFqxQK3NuyugJ0rvCgfuk3n7bOjbRYxjtXbDIo41c
         9hkL5I3sSZAH4LWpU5Hz4rzaimszZBnNgQOeLWbHtCSvV7WE23HlCEltuB97H+lsxDhi
         T0Nr9HX8Syru1uaPiRtTS46v2moIsJGkvq2fkvbS9avnh5cZYPI/gMly6X4IibbUV9Ex
         V/dQFKHhfVsUE9F4bjL0+Da5GeBHVH47z3e2nCnG8iqSQwDFB78EZK5iy9Znzu0czH/C
         bkc9CPb8uKkFm5Hp+RwIdrNE6RB3gLGj+3o9CVYLr6Psz0nv+LzShMjkAsT7kk0uGH+m
         OjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683698666; x=1686290666;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gu0Ww4Btm3ZJWmUm54OXSmR11HegrPdHhOCTMAKgm2g=;
        b=cNsVWq/QyfBc6yjl7fXehFZDInbFkrL59euXpqjq5TsTOqooLB0stWZ74KSt6z1TuN
         VYu6P5xLHFaXb1GYxgJul3remqwQLLh2t9CU8E4LlBi848GMLf0/QTrI0d8EApUlp45/
         0IRTk83cAtV381ln/rIsvSTO4oKjh6aNYFPqCs5e4wGx06DgB/MFt032HKT6VNP4K50T
         HV+1oI/dZDRDxXKTru2zeC4RIxWAjyqVo0yLWjJ8ihpRRuHt3eeL9Rj7DMAlSgR9iuQb
         uPsBboQBIAq8l9UzUCTqdQ7o0wewM+3CVtw0O1V0oTpqF9sIDYdMZ5TTEn7CBG1C0dqn
         va7A==
X-Gm-Message-State: AC+VfDzyH66tqKsU6c2pyYeiwL0/8JhXDZGJ3QuBsjdl0mba28soF87m
        pHYEslBWyMtVDiCowJNoEtmoLA==
X-Google-Smtp-Source: ACHHUZ58wm9Z0W6YIYZ1v9zc9DcTUNNZ2qDA21or5nSqrykEbxFIclL0qerbXr6/V4brO+GwwybdGA==
X-Received: by 2002:a17:902:c40a:b0:1ab:28ec:bf10 with SMTP id k10-20020a170902c40a00b001ab28ecbf10mr23310293plk.51.1683698666262;
        Tue, 09 May 2023 23:04:26 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id io20-20020a17090312d400b001ab0a30c895sm2751424plb.202.2023.05.09.23.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 23:04:25 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     vkoul@kernel.org, palmer@dabbelt.com, radhey.shyam.pandey@amd.com,
        dmaengine@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2] dmaengine: xilinx: dma: remove arch dependency
Date:   Wed, 10 May 2023 06:04:21 +0000
Message-Id: <20230510060421.30982-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As following patches, xilinx dma is also now architecture agnostic,
and it can be compiled for several architectures. We have verified the
CDMA on RISC-V platform, let's remove the ARCH dependency list instead
of adding new ARCH.

'e8b6c54f6d57 ("net: xilinx: temac: Relax Kconfig dependencies")'
'd7eaf962a90b ("net: axienet: In kconfig remove arch dependency for axi_emac")'

Signed-off-by: Zong Li <zong.li@sifive.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Suggested-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---

 Changes in v2:
 - Remove ARCH dependency list instead of adding new ARCH

 drivers/dma/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index f5f422f9b850..daf20600a167 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -696,7 +696,6 @@ config XGENE_DMA
 
 config XILINX_DMA
 	tristate "Xilinx AXI DMAS Engine"
-	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64)
 	select DMA_ENGINE
 	help
 	  Enable support for Xilinx AXI VDMA Soft IP.
-- 
2.17.1

