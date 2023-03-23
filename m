Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDC46C73CE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 00:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCWXBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 19:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjCWXBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 19:01:33 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CF4B464;
        Thu, 23 Mar 2023 16:01:32 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id i19so99035ila.10;
        Thu, 23 Mar 2023 16:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679612491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoCYglyZRXBAsXij28ODxM/pUlkw5MAovi/FF2CLHQ8=;
        b=EuLUTSOXPcNUYVeKnTB4g9KwdaJWobchhRiVJyyhfD91KWS+b0MlS4OMpooyKBAgdV
         xzItG1xrsWtlkihU9MEE62fZDbxXLWsB1oyAZ9l81RR09vJtVXDgKzfNUfItxVgzgEER
         KkH1kc77ClORzJv+QgH0phBb8q1NHPyuTQPTdjiUg8DiHZdDgl4uuudjhHPPxK1tUqT7
         Bto8XS+HZJogUJF/gclufOTDTb8E3lCnvPY40uH/UjHICTRruzl6NXH9LGXfEQz8iDvy
         DDDfQhNRw83hx23TMXfD9o9aWYobLjqDkO6EYD3g32v5cuEfY8Nw+hiyMC3N0sYaBkq4
         npiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679612491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoCYglyZRXBAsXij28ODxM/pUlkw5MAovi/FF2CLHQ8=;
        b=YXpYZL5xUmokQ/npIKG8eIRVySs90/eNWSdDlLKV+lKt8+yq/N250sKoFiPH258UMl
         /Fn9Sg0bPEIaz7s4KzTozMOZqwC7vGREMN0PqJF7nCJ0rMztzcHEgsMWpPchfNgiH8sn
         ZxvsRyLBwirR13V725m2c1Ru1ujg3fB/5LscOnSlrTYaiZ3VNCIQmC7xG8kmuuT+WtY5
         0AVPb6w1xPbsd2W5F99o7HPDhmF0pPPsMjlZEk4AwEhU31KBRQCs5bJDeWMco5qzSBlV
         UrTedQuY/xzIJ/UDjaPQBr387dcYq4CZ2By7jeqzrh15ne8Ux5kK1l+HAJqF+b6q+fcP
         vyXw==
X-Gm-Message-State: AAQBX9cyK09JuLDbgaILw69tvoQduH2/tMBPgvuYB2DaLDGF2TF9qZ5b
        oBv9xUsZRyas2Yt0p8ZBDRxOhihwU4E=
X-Google-Smtp-Source: AKy350aB8mG/RWYSizA0hQrtNJ+VzeQIYF95T4UM+86HtnAts5iISqBLXr56ECHs23F+T51U/wzZWw==
X-Received: by 2002:a92:cb47:0:b0:325:da54:ae8b with SMTP id f7-20020a92cb47000000b00325da54ae8bmr703358ilq.9.1679612491131;
        Thu, 23 Mar 2023 16:01:31 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:897f:f38d:f05d:4666:1249])
        by smtp.gmail.com with ESMTPSA id w20-20020a056e0213f400b00314201bcbdfsm5405492ilj.3.2023.03.23.16.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 16:01:30 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/4] clk: imx: composite-8m: Add support to determine_rate
Date:   Thu, 23 Mar 2023 18:01:24 -0500
Message-Id: <20230323230127.120883-2-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323230127.120883-1-aford173@gmail.com>
References: <20230323230127.120883-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
V4:  Sorry for the noise.  I forgot to 'git ammend'
     What V3 was supposed to be.
V3:  Change name clk_divider_determine_rate to
     imx8m_clk_divider_determine_rate to match naming convention

V2:  No Change

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index cbf0d7955a00..6883a8199b6c 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -119,10 +119,17 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
 	return ret;
 }
 
+static int imx8m_clk_divider_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
+{
+	return clk_divider_ops.determine_rate(hw, req);
+}
+
 static const struct clk_ops imx8m_clk_composite_divider_ops = {
 	.recalc_rate = imx8m_clk_composite_divider_recalc_rate,
 	.round_rate = imx8m_clk_composite_divider_round_rate,
 	.set_rate = imx8m_clk_composite_divider_set_rate,
+	.determine_rate = imx8m_clk_divider_determine_rate,
 };
 
 static u8 imx8m_clk_composite_mux_get_parent(struct clk_hw *hw)
-- 
2.34.1

