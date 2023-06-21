Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C259B7380EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjFUKFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjFUKDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:03:09 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9E41BC5;
        Wed, 21 Jun 2023 03:03:02 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-668711086f4so2576755b3a.1;
        Wed, 21 Jun 2023 03:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687341782; x=1689933782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdHaClVof4GmSU4l73qlCxIHJWw+8E7saO7uCcnoUi8=;
        b=BJnWoLVs2UhPnW/dTt2lEOz67aY6Plth+VkdieANu/qZ75XAL8bpFyl4pMuZHUmIch
         oNN+n1z3QcNj9xABtEbgxmtCo9U/9RPLFexVyJjMd91JB5VtXqtu4lVRWVh/rkEJ9fcY
         ln5+yUV8nfZCll+0RbnqK/+K4Iq0vq6B7sLKrupAJ2SbIaS88J8UQh1R7Rk7kLEHrYU2
         4mjmFuhx9ohkYbhEf9vmr9uhYGOTFsaOy/cAmbPrEIja7MdOqsYZ4M0G5zX77z0JiHuG
         u5zYWtn4q1lIJe8HAJ2J/vGNZCCIQcGoNWTLLzcj1DMEphDFfPJytt9nACijDQwMUdEB
         g2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687341782; x=1689933782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdHaClVof4GmSU4l73qlCxIHJWw+8E7saO7uCcnoUi8=;
        b=du8Y/4Dxl/hjaibvyk3h0vPfRKBx2uavwCDcIu6JsON+4y5gYQb16bOjD+6aD54qbM
         j+28LJf0ajfHA0GfPogu5M778J6UXSy2iFs5w2Ju0f/v03LryGV5ZUcQXq4tcG7tAiog
         tyxL5EUKsaxPAZCl+xeuhc0nxwTSrE3azzOFSi2kQpbpFNcf/K4GlCaYHxqdHA7b9do/
         fzyJV4w+qFzrRV9hh1iqJtitGUmSDG2v2yeiqTgDMlQwUFU7zkSVwmjxZEqC6gO+cn5w
         ARz5Af77DI6Y2VwPE7gb5bs7ZcK8zM7/Xwib+SCfbxEeX2OU6dZZTB2IDW2KURcJr0M8
         +r0w==
X-Gm-Message-State: AC+VfDwlWD0+orVXqMk+uHmrXAxA0RKLMIZBiZCuuddAVIHxR2UL4ka/
        NljC4jxec+H9beD+gfm54fM=
X-Google-Smtp-Source: ACHHUZ6wHcIIc+43kAN69xZH7dmcCI57idvvortx2hu9xoTUGromqdjIIdgugmOQKtgTI9AhEwkkoQ==
X-Received: by 2002:a05:6a00:1914:b0:668:7494:384a with SMTP id y20-20020a056a00191400b006687494384amr11410245pfi.12.1687341781413;
        Wed, 21 Jun 2023 03:03:01 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e254-4eda-2716-05ea-20f5-b048.emome-ip6.hinet.net. [2001:b400:e254:4eda:2716:5ea:20f5:b048])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78742000000b0064f46570bb7sm2611196pfo.167.2023.06.21.03.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:03:01 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V8 21/23] mmc: sdhci-uhs2: add pre-detect_init hook
Date:   Wed, 21 Jun 2023 18:01:49 +0800
Message-Id: <20230621100151.6329-22-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230621100151.6329-1-victorshihgli@gmail.com>
References: <20230621100151.6329-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Shih <Victor.Shih@genesyslogic.com.tw>

This "pre" hook for detect_init(), uhs2_pre_detect_init, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 3 +++
 drivers/mmc/host/sdhci.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 0adc3e9ca1b0..1191ce67e9f0 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -1269,6 +1269,9 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 
 	DBG("Begin do uhs2 detect init.\n");
 
+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));
 		return -EIO;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f660d5040f6a..2678687d6ddf 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -724,6 +724,7 @@ struct sdhci_ops {
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

