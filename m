Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0887E6C283C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCUCcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCUCcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:32:11 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB92A36FE2;
        Mon, 20 Mar 2023 19:31:49 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id f14so6361614iow.5;
        Mon, 20 Mar 2023 19:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679365909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTo3F/m/SxPHAqEXuebTGyXW2LKYPQRkLUm8e3SciVw=;
        b=jtWm45HrEd24L4clToDHgC5saIGxP00MYJ3iEBnl+HmrGuNeaWFNY0Y2ArHLweqAAy
         Xuspfga6nrYvqO1IUmUGeUeolYCixybPy7ejgqDex647tY9G6Ys1q41Uvbjcr4c37yGv
         WxiZld+rhzzulzvvPFOQwqyiOmQzEt1TCQSo26UTMk7G4SwpU1Ds2iH9FKJU4L9FUFu2
         EsHlNqd++9PdTtCKOp0Jw9WI5hdVvQ26NKHKRmCwnEugnoZ/KdzdQXQqxKH813DH2vgI
         VE4qUcT4HUVoS/ifDGZ5ZLoss+RCVWrONgBPipOJOT6PQwGoeb7y2cIYoTYBTIhiczSM
         WFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679365909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTo3F/m/SxPHAqEXuebTGyXW2LKYPQRkLUm8e3SciVw=;
        b=Nf4X6MFCD8ZkiWotau4qrop44lNkN1vvfA3t20zVI9lkz/NRKG56aLfSW2Nh7yg/f3
         O8WQR/zps0+tY+DVugiOXfEIpelCJ74Un/kmjxmYNDZDYVKPIrwND5o6H+AuK/kprIqQ
         3XNpYeFI6nSGkD6VkPMrxQQMc8RAl4P/5YeXGUVHa2yi++dr2uyV9a3eQLKUYazDkFnw
         EhaXij6HDHjjtlD3Z2n6fiYxqHYKNmK89wGD3HASBG5iwH66hiJzhuUicUcFcyczqZ8h
         nSCw0dUThapssUdGNGjp1+4C8KN3sSVCJjFLHmk/vJIUbRha+UlKoHTjoLbQc8d36FJp
         0dEg==
X-Gm-Message-State: AO0yUKVehGuSlKVtKPzgGGvBBKQ6ZNDA8Svmrc35WoKgV/VvwekOIBgt
        s00KVBYqM+7UvDC4FRhJlGWoOOw/sh0=
X-Google-Smtp-Source: AK7set+Ibe5aCthxCU51+MZKk4ghN93jB6Jsfgn9wVamJsAh+oHNdRypAPnQ3pM47QAflwju4EDD1Q==
X-Received: by 2002:a5d:895a:0:b0:74c:e456:629d with SMTP id b26-20020a5d895a000000b0074ce456629dmr699641iot.7.1679365908946;
        Mon, 20 Mar 2023 19:31:48 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:897f:1387:3268:b209:f4ec])
        by smtp.gmail.com with ESMTPSA id a28-20020a027a1c000000b004065ad317fdsm2241200jac.151.2023.03.20.19.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 19:31:48 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/4] clk: imx: composite-8m: Add support to determine_rate
Date:   Mon, 20 Mar 2023 21:31:33 -0500
Message-Id: <20230321023136.57986-2-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321023136.57986-1-aford173@gmail.com>
References: <20230321023136.57986-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to imx/clk-composite-93 and imx/clk-divider-gate, the
imx8m_clk_composite_divider_ops can support determine_rate.
Without this the parent clocks are set to a fixed value, and
if a consumer needs a slower reate, the clock is divided, but
the division is only as good as the parent clock rate.

With this added, the system can attempt to adjust the parent rate
if the proper flags are set which can lead to a more precise clock
value.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  No Change

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index cbf0d7955a00..3b63e47f088f 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -119,10 +119,17 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
 	return ret;
 }
 
+static int clk_divider_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
+{
+	return clk_divider_ops.determine_rate(hw, req);
+}
+
 static const struct clk_ops imx8m_clk_composite_divider_ops = {
 	.recalc_rate = imx8m_clk_composite_divider_recalc_rate,
 	.round_rate = imx8m_clk_composite_divider_round_rate,
 	.set_rate = imx8m_clk_composite_divider_set_rate,
+	.determine_rate = clk_divider_determine_rate,
 };
 
 static u8 imx8m_clk_composite_mux_get_parent(struct clk_hw *hw)
-- 
2.34.1

