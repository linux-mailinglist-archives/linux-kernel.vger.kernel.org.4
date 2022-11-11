Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7322B625589
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbiKKImk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbiKKImd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:42:33 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1787C8E0;
        Fri, 11 Nov 2022 00:42:31 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id f63so3912165pgc.2;
        Fri, 11 Nov 2022 00:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ufORKQiDl3My/Sxu75qdEz6doPHgCGMva2vtUdxxbeA=;
        b=W3r+pgs2MlYxwca0+X2vjtRr3xGo9WWBLk66EM4nZszDGwA9k3X4Cx5zV0JMtCtK/x
         gKDp3ly99dd94fdpuNOQlwX789Sdd/Vu4gYV+dt7zvYOW6det3p5Tfiw893I8ra/YFQ1
         rAbstYYE7TBuIFQjT+uKfW988qXRPCLoTUv1NG7j/1tmCX5RO8Ruqexf4zvLHD1N7j44
         pYysl+s90nMEnpIZixCgj1isKAPP/EhDvrLd417NOo3p8PXrOxFl0T6nNAT1DOvk8SWV
         niuKCVWbB3xCUW03Sel2Vsaovs9YoksX63BCG6EaLRUiwyJdO/Z9YwPIsFA5swZGqrVt
         z2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufORKQiDl3My/Sxu75qdEz6doPHgCGMva2vtUdxxbeA=;
        b=dsoykX853ya+nsgWVVF8KzCCJkk144FLl38fDeUjHkhhGScUeI0F1qJD+/wgcF4tYH
         nAzgJpa6Rfiny7Hez0os8KC91L3c/YdNGQ5WJOEE5yBW1Wh4VSIIrHHFqQBBRlXuEA1b
         HLFiohmf7TNq5WbAy0+X7qky9FemCVavvkJRkmX829rzzjBoVnGCRt6hy5teLA/68uIR
         Y3h6xxOEMPczd1WoLeQlPOpbb0Bsj+uFnHPPRYCAoIU+EVeQlzmlL5eaodRDX0wwS8Gm
         ljLbZKrm/VLMhLd/ACF8MfXV4lL4Y8toNmJ5hYDKpBhfcIXGkzz5/3isZ6839O/aGDf7
         uYmA==
X-Gm-Message-State: ANoB5pnde3Vhdx3GceEa+WFXimAFJvBgiB1VCHQB0YtxkkNF38TeZk86
        2T9Po7U62gG22hdRTybKO9g=
X-Google-Smtp-Source: AA0mqf6nD3e0rQEbmdBh/bIQ6DoIgNmLGa42XXbGZQUPUjZYWzTm7LJF0MGUK116zFrlLtyngC3bIw==
X-Received: by 2002:aa7:970d:0:b0:56b:823d:e3b5 with SMTP id a13-20020aa7970d000000b0056b823de3b5mr1544074pfg.81.1668156151494;
        Fri, 11 Nov 2022 00:42:31 -0800 (PST)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903244500b00186f81a074fsm1088731pls.290.2022.11.11.00.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 00:42:31 -0800 (PST)
From:   Wenchao Chen <wenchao.chen666@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        megoo.tang@gmail.com, lzx.stg@gmail.com
Subject: [PATCH 1/1] mmc: sdhci: Fixed too many logs being printed during tuning
Date:   Fri, 11 Nov 2022 16:42:14 +0800
Message-Id: <20221111084214.14822-2-wenchao.chen666@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221111084214.14822-1-wenchao.chen666@gmail.com>
References: <20221111084214.14822-1-wenchao.chen666@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenchao Chen <wenchao.chen@unisoc.com>

During the HS200 tuning process, too many tuning errors are printed in
the log.

Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
 drivers/mmc/host/sdhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fef03de85b99..a503b54305eb 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3401,6 +3401,10 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		if (host->pending_reset)
 			return;
 
+		command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
+		if (command == MMC_SEND_TUNING_BLOCK || command == MMC_SEND_TUNING_BLOCK_HS200)
+			return;
+
 		pr_err("%s: Got data interrupt 0x%08x even though no data operation was in progress.\n",
 		       mmc_hostname(host->mmc), (unsigned)intmask);
 		sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
-- 
2.17.1

