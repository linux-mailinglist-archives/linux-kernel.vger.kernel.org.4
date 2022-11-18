Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D00562F4B2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbiKRM12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbiKRM0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:26:32 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048559AC8C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:26:16 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v1so8963756wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WB27jhF4DCx/Ah98HAn4Zt+8vZMKTVFmQpCWXcHg7GM=;
        b=Hv4j2/dPaM9EBDU7n724L6eQsr4DNXdBQjGvzrtzZDn429adWSeIfWvr+e7+Mjbgfp
         3NqMO0rr+HQIQsWTe0RTQiVILKK9vcb549WGRP+cGKonal19zGGv1Alpm8bIh/5R+0Qx
         cmEgAbVp47aUAPBQ9KyV+jYDb8GBGDTlHuhjGoG2bCMdjDAQPThWMPAsyiNiQKPsXH1e
         ViA7Y5Os/+LZ5VG6GxXLwsooznyMtBZ6aUVhvCJkYCiN+ehm1J0ehhTMxdBOyeIUV+yE
         uTUeMjURKolrFZr6a24URF5pNbnymttJUzfMWu0gmdhKQndYGm2GqegJmBr9Nb+ks9/J
         +cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WB27jhF4DCx/Ah98HAn4Zt+8vZMKTVFmQpCWXcHg7GM=;
        b=xuiO2Xi23NBzmCvvaVNY0Hnl5YIWgx9hDaHBQTsd7C0A0Pc58V7g2W4lIklmPqwbgh
         7zZv8hSOmce6X7rzueCwPH6NqFYhl2hS0D8Db47sDGBdKkdH3t0uxls9HO5dB/fxo4j0
         fKhD8O2DmNvXCaxEPrx060TWSkCQ50MMsorwA6aSSb81Fm7FDWy34mYSLoVmWQglBPzE
         lTCe2E1xdT/JxfO/iA5dWwyeMe8eG4emFp1IkAYxOqPi1VPUlnLp/XOi33vvvRoJ7VK4
         aOUGbf1Lx0+Rn4PszUWtZ9IvUY0Ep6OR8t2ndsHoexfqAGHYPdNw8eZ7mDtRFyw/lFsz
         I+9Q==
X-Gm-Message-State: ANoB5pn6Mi/GO8SpNJbNtTVD186/x2O5XNwj3da1YCtcJ867Xd+tBRLx
        Mr2d9iU5Pbo0HqVWMp8aknW33A==
X-Google-Smtp-Source: AA0mqf5RPSNmKNYUH2/qrCXqX9bGdjEIkUCG//ScGngr0QgwxAVFX2JzCF6xdpSKvgMJWLHkf5jG+A==
X-Received: by 2002:a5d:6a46:0:b0:241:c2d5:7407 with SMTP id t6-20020a5d6a46000000b00241c2d57407mr1285401wrw.623.1668774375543;
        Fri, 18 Nov 2022 04:26:15 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b10c:1279:a704:75d4])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b003c6f3e5ba42sm9873958wmg.46.2022.11.18.04.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:26:15 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 14/15] soc: qcom-geni-se: add more symbol definitions
Date:   Fri, 18 Nov 2022 13:25:38 +0100
Message-Id: <20221118122539.384993-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221118122539.384993-1-brgl@bgdev.pl>
References: <20221118122539.384993-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The following symbols will be used when adding support for SE DMA in
the qcom geni serial driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/qcom-geni-se.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index f5672785c0c4..400213daa461 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -103,6 +103,7 @@ struct geni_se {
 #define SE_DMA_TX_FSM_RST		0xc58
 #define SE_DMA_RX_IRQ_STAT		0xd40
 #define SE_DMA_RX_IRQ_CLR		0xd44
+#define SE_DMA_RX_LEN_IN		0xd54
 #define SE_DMA_RX_FSM_RST		0xd58
 #define SE_HW_PARAM_0			0xe24
 #define SE_HW_PARAM_1			0xe28
@@ -235,6 +236,8 @@ struct geni_se {
 #define RX_SBE				BIT(2)
 #define RX_RESET_DONE			BIT(3)
 #define RX_FLUSH_DONE			BIT(4)
+#define RX_DMA_PARITY_ERR		BIT(5)
+#define RX_DMA_BREAK			GENMASK(8, 7)
 #define RX_GENI_GP_IRQ			GENMASK(10, 5)
 #define RX_GENI_CANCEL_IRQ		BIT(11)
 #define RX_GENI_GP_IRQ_EXT		GENMASK(13, 12)
-- 
2.37.2

