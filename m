Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC2472B227
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbjFKOD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjFKODs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:03:48 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7296E77
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:46 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f7378a75c0so24277615e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492225; x=1689084225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqu6zhlo3BumjjZSy0hWitrlF9vYczNuvBx4wGI2+u4=;
        b=ICfogWFj59zkdRMyVt7Ekmk8RsNiI8AFO+uUfDsCVEO2pasuegangeqiwkOH1LRNN+
         nCM6Ji6gPEWtLFRvRo/rpTvt7LzZPugM7eyK2njepZoXfEGDRac0rBicTmQV1PzfE4Wf
         m1F5WqD3vnyR7hGRHGC+9aM6MBijP5O5W6EVqlZmAFnEdC4Z0nuQbgum0fGirYdTMZsn
         JQ2EfxA7751uYK7xscXvNcyU+PQIk4EGzvoRqymlDjfEDfymA/Pw5GA+6+lbeMnlyaOj
         Jpk6Mxnbkk/Fpg62a+NtxBaT07lSVHHTo3SYOvg+dNLaH66PEHyMDqg60TSVC/xKa2xQ
         QkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492225; x=1689084225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqu6zhlo3BumjjZSy0hWitrlF9vYczNuvBx4wGI2+u4=;
        b=EQOJToyV5HkrxGYsK6VUSMjjCIdc7fWeWtrN+8azAth/nVKpVu0HManvA75rCYC/wf
         XPXRg4XOmu8+Z1GgOaWhNmLDRDwwMaw6AMcTe8SC4kKdJQ8NK4Rv9DOLF8EFGvYWyxGA
         nHWW1gbVu76NuyPUyWENGfsj5XSsXRBlifoMx89Qkpmxt6iSWG8HkQGHQMt2MCB+/Tyr
         vCTXU9VNaPR4QjYkn6SGojE2UTlAvgunNYkpg6xcgkjcGagPIlUG/2/Uo/PiT7P46vMQ
         Mu8EXFd4BUlyT5gq12j5n/DE7z5sAKJZTMaLtveqbWjY/LHhA8zWjNn/M29le+M0x1Js
         k4Tw==
X-Gm-Message-State: AC+VfDwMy+Wc9dsD9CEHTzKSSlpIRtsQFfMw0s82j3/6sohZGSIEW+nP
        APlwtxhWLEKROW7ROU4cIC6LszI5r8f0HrykmFU=
X-Google-Smtp-Source: ACHHUZ7TdYtD+zVewjIOT2sGaCk7+PbnnMLXaZudQ+mEk/0hTUmTJwN8LBhq2z8rb+zxieE2tZ7DVg==
X-Received: by 2002:a05:600c:b54:b0:3f6:2ee:6993 with SMTP id k20-20020a05600c0b5400b003f602ee6993mr4796841wmr.4.1686492225188;
        Sun, 11 Jun 2023 07:03:45 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:03:44 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/26] nvmem: imx-ocotp: Reverse MAC addresses on all i.MX derivates
Date:   Sun, 11 Jun 2023 15:03:06 +0100
Message-Id: <20230611140330.154222-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Stein <alexander.stein@ew.tq-group.com>

Not just i.MX8M, but all i.MX6/7 (and subtypes) need to reverse the
MAC address read from fuses. Exceptions are i.MX6SLL and i.MX7ULP which
do not support ethernet at all.

Fixes: d0221a780cbc ("nvmem: imx-ocotp: add support for post processing")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Tested-by: Richard Leitner <richard.leitner@skidata.com> # imx6q
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index fcea9c04be96..ab556c011f3e 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -97,7 +97,6 @@ struct ocotp_params {
 	unsigned int bank_address_words;
 	void (*set_timing)(struct ocotp_priv *priv);
 	struct ocotp_ctrl_reg ctrl;
-	bool reverse_mac_address;
 };
 
 static int imx_ocotp_wait_for_busy(struct ocotp_priv *priv, u32 flags)
@@ -545,7 +544,6 @@ static const struct ocotp_params imx8mq_params = {
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
-	.reverse_mac_address = true,
 };
 
 static const struct ocotp_params imx8mm_params = {
@@ -553,7 +551,6 @@ static const struct ocotp_params imx8mm_params = {
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
-	.reverse_mac_address = true,
 };
 
 static const struct ocotp_params imx8mn_params = {
@@ -561,7 +558,6 @@ static const struct ocotp_params imx8mn_params = {
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
-	.reverse_mac_address = true,
 };
 
 static const struct ocotp_params imx8mp_params = {
@@ -569,7 +565,6 @@ static const struct ocotp_params imx8mp_params = {
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_8MP,
-	.reverse_mac_address = true,
 };
 
 static const struct of_device_id imx_ocotp_dt_ids[] = {
@@ -624,8 +619,7 @@ static int imx_ocotp_probe(struct platform_device *pdev)
 	imx_ocotp_nvmem_config.size = 4 * priv->params->nregs;
 	imx_ocotp_nvmem_config.dev = dev;
 	imx_ocotp_nvmem_config.priv = priv;
-	if (priv->params->reverse_mac_address)
-		imx_ocotp_nvmem_config.layout = &imx_ocotp_layout;
+	imx_ocotp_nvmem_config.layout = &imx_ocotp_layout;
 
 	priv->config = &imx_ocotp_nvmem_config;
 
-- 
2.25.1

