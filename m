Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4942C6C0201
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 14:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjCSNVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 09:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjCSNVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 09:21:34 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE1F222CE;
        Sun, 19 Mar 2023 06:21:34 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h5so5247731ile.13;
        Sun, 19 Mar 2023 06:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679232093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8K00mhrFcQs9Z7odhdrKSasE5j1cIS7BmQWAR2zLjA=;
        b=N3LiLEhbiW97PwGOJH/Wbl7pLxJaNt0oR2gwkupf8el4rgsLamm/hKm/UGWfsnnYxA
         P84TQXwzCNOpJ1xGBy5zzyI1Fx2nWdJOkgLhTQy0fEgkGlj8EfPBdZRR2UqDVtV8tFuk
         ewv8kPrR6PD49urM9a9UCDAAIizBrmzEscmHHMRJo+oezAZnXto2hWhGaryW6iEt2Q/P
         ipCRf/CFYw5/9whB9Yi9lL0lyxAmaNDrCEIls8SvZm9EBoJmOg/Sii2DKKssMyoB0b1b
         uTIYE0VsISwmDXAbXVNyfMUuoKr8Kq7FOZpGtgyaLcEblvT0jU7JVEl4H/QHVJlxpaPQ
         2uMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679232093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8K00mhrFcQs9Z7odhdrKSasE5j1cIS7BmQWAR2zLjA=;
        b=OimvPLOM7RrhIHvyuTL5jQ9U5VyKpm3SFRv7E5LaFVhTrSfP5xFhAtOVTd/eGacN1S
         gJPwWIYyB8K8gVlGzVYuuRp6s8JM0HzQ5wSY+v3aun8r5BeBlI5IIxcJH5ktWLtDuozo
         iKD7/QfoTl5H9gFzh+qmo/7CZIvJTmMtmmDolwQLLH5JGRq6cwUKZFuWZiHZMPjoyZt2
         hstLauQd2xQjYIW18tAkJAk69PN7bwHIvEKSao5Tc76qV8L1oGG00ydkbMobEJ3XkMtO
         Y8TeVDrHfpbzDsEI0fuebKcNFUXjvfLiPjn+wwQqm9hix7yC1fP1BEtxbPXLwDCxaQIS
         pqkA==
X-Gm-Message-State: AO0yUKV9SPZekqKG/rE4iasnF8LihL3m1tDTTl2dVgTp4kvKcN3mc9v2
        Tx69l5l6mCcmpzgphcXestWGzQU/YVs=
X-Google-Smtp-Source: AK7set8u5TAbtClNj4mHrUK2nLeJif8QArEGoDDl2cMxGZGRibszXccwl7TqKPfruuxZlaWvflMUuw==
X-Received: by 2002:a92:ce85:0:b0:323:338:cc36 with SMTP id r5-20020a92ce85000000b003230338cc36mr3355844ilo.8.1679232093044;
        Sun, 19 Mar 2023 06:21:33 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id a23-20020a027357000000b00406227162fesm2363460jae.32.2023.03.19.06.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 06:21:32 -0700 (PDT)
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
Subject: [PATCH 1/3] clk: imx: composite-8m: Add support to determine_rate
Date:   Sun, 19 Mar 2023 08:21:18 -0500
Message-Id: <20230319132120.6347-2-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230319132120.6347-1-aford173@gmail.com>
References: <20230319132120.6347-1-aford173@gmail.com>
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

