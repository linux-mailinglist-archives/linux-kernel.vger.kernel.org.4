Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1840270DBD7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjEWL50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjEWL5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:57:23 -0400
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79022118;
        Tue, 23 May 2023 04:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=3uKJdpdHvGb7u2eKUE
        FYmCgJiT6WLkcLPzktaTRRs/8=; b=pr+9zbuDv9tkRtXAygM2MdVbRcr3s6FIJE
        2fFOn6iQo89avdcvqE1pWgMJhrwFxbZc9hZDNJjI6x2sxTnzRONQ9GnnuCSxaPzQ
        WUQUW5hjn8HLuUFS0bIUbVSX6acUcCGU8nmbNG8oFQ3JnqtZIR4/jMRsnrGPsxi8
        PeW5eR5i0=
Received: from wh-chevronli-w10.bayhubtech.com (unknown [58.48.115.170])
        by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wBn3Vlon2xkD_MDAQ--.2819S2;
        Tue, 23 May 2023 19:11:37 +0800 (CST)
From:   Chevron Li <chevron_li@126.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shirley.her@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        shaper.liu@bayhubtech.com, justin.wang@bayhubtech.com,
        Chevron Li <chevron.li@bayhubtech.com>
Subject: [PATCH V1 1/1] mmc: sdhci: fix DMA configure compatibility issue when 64bit DMA mode is used.
Date:   Tue, 23 May 2023 19:11:14 +0800
Message-Id: <20230523111114.18124-1-chevron_li@126.com>
X-Mailer: git-send-email 2.18.0.windows.1
X-CM-TRANSID: _____wBn3Vlon2xkD_MDAQ--.2819S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryrJw4fuF1ktry7AFWrZrb_yoW8Zw17pF
        W5WrW5tFyUtF4YqF4DWaya9Fy5JFWkta9F9FyrGwsIvr45Zry7AanFka47t3WUXFyxXa15
        ZF4j9F1UuFZ8AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UnqXLUUUUU=
X-Originating-IP: [58.48.115.170]
X-CM-SenderInfo: hfkh42xrqbzxa6rslhhfrp/1tbiFwl4AVpEGVxAxwAAs7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chevron Li <chevron.li@bayhubtech.com>

Bayhub SD host has hardware limitation:
1.The upper 32bit address is inhibited to be written at SD Host Register
  [03E][13]=0 (32bits addressing) mode, is admitted to be written only at
  SD Host Register [03E][13]=1 (64bits addressing) mode.
2.Because of above item#1, need to configure SD Host Register [03E][13] to
  1(64bits addressing mode) before set 64bit ADMA system address's higher
  32bits SD Host Register [05F~05C] if 64 bits addressing mode is used.

The hardware limitation is reasonable for below reasons:
1.Normal flow should set DMA working mode first, then do
  DMA-transfer-related configuration, such as system address.
2.The hardware limitation may avoid the software to configure wrong higher
  32bit address at 32bits addressing mode although it is redundant.

The change that set 32bits/64bits addressing mode before set ADMA address,
  has no side-effect to other host IPs for below reason:
The setting order is reasonable and standard: DMA Mode setting first and
  then DMA address setting. It meets all DMA setting sequence.

Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>
---
Change in V1:
Set dma mode configure before set dma address
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3241916141d7..ff41aa56564e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1167,6 +1167,8 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 		}
 	}
 
+	sdhci_config_dma(host);
+
 	if (host->flags & SDHCI_REQ_USE_DMA) {
 		int sg_cnt = sdhci_pre_dma_transfer(host, data, COOKIE_MAPPED);
 
@@ -1186,8 +1188,6 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 		}
 	}
 
-	sdhci_config_dma(host);
-
 	if (!(host->flags & SDHCI_REQ_USE_DMA)) {
 		int flags;
 

base-commit: cc3c44c9fda264c6d401be04e95449a57c1231c6
-- 
2.25.1

