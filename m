Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6396EBF78
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 14:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjDWMih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 08:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWMig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 08:38:36 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A36210E2;
        Sun, 23 Apr 2023 05:38:35 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-760f8ffb27fso78792539f.2;
        Sun, 23 Apr 2023 05:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682253514; x=1684845514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=omxlpIKXp/6w9A8kSumpgR4tKNK9oDvDPvxcZqTnkYA=;
        b=K/0OStf1AOLqMh4auNrV50Msgv/QyxlPG2TLzBqbRXPCUfpPOw5xbqGJWIfGF81YcS
         Z3Oi+kk/pquajapZJP6Oabu/eUkPRHfi1+boSiHZ7r+XkDa3KvQzywIEhStm30Ketd89
         gUszwtJfNyCE4fIlLwG0cCWgF8idwPzB1XqMMBBZWzp4ddWfmPLyerGv22WtpPxsx2fH
         oXBWt1jjGcaAzqysyH58AaUVuJnMK1h1z2w1iE2GQCP0TfCg297VTdLYUS1EeJ+A7p1/
         aBzHCFDClNfjoV+H50JKVhBeq4/0Ttdhg/kkTnq8wsi3DuqK+FOclZ3MZsZtw4LfFFCf
         kYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682253514; x=1684845514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omxlpIKXp/6w9A8kSumpgR4tKNK9oDvDPvxcZqTnkYA=;
        b=RqXmoza6CyTjiAH6owkvl/C2F02lbIi3q8wG6dUFn2Cj9yNsq9cgcN0+2MgqCnyhg9
         NnSOazWbze1x2QCY/XfBfoSHZflKoiarkJIY/HbHvGT35cx4RQT+YgVMdh+H1K3gcCDJ
         rnPCt62b9WyEvrkJhYEura9K/ZgKcD0KYJxwSpzWVXqyKF//z8JQ/02WbaPihdkjBOT5
         f0pSFhKTmonia53ifPMUimOCjAUxYVMz8+Fetmgwot7ug7c4oHaKry+YGb6VdX1uGuFV
         zILzOPjk1P+gmtwYbXhioXoAldWFHpBz6UnpdExR3A5q6VlkXA2tqGIzXTZ0nRk3PKqw
         h0ZQ==
X-Gm-Message-State: AAQBX9dCJVtmQctWH7i+ru01FhvkAgYJF5kDapioXUzodt0pQVNl89s1
        MkM8LHd/rL9V+hlTPfjPolCnpANi5PWrTQ==
X-Google-Smtp-Source: AKy350YblNmFz+w1ZkW2Qy/dIQ1OMGstG9Gdcjsw4961EqNKt4mOnibsgcI87XwgHiv17i/dcAvbGg==
X-Received: by 2002:a6b:6507:0:b0:760:f887:7553 with SMTP id z7-20020a6b6507000000b00760f8877553mr4196958iob.2.1682253513943;
        Sun, 23 Apr 2023 05:38:33 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:b473:5d7c:4c2:75d7])
        by smtp.gmail.com with ESMTPSA id i25-20020a056638381900b0040f8b6933f0sm2532203jav.74.2023.04.23.05.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 05:38:33 -0700 (PDT)
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
Subject: [PATCH] Revert "clk: imx: composite-8m: Add support to determine_rate"
Date:   Sun, 23 Apr 2023 07:38:27 -0500
Message-Id: <20230423123828.1346511-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 156e96ff2172518b6f83e97d8f11f677bc668e22.

This patch was found to cause some division issues on the i.MX8MP
which causes the video clocks to not properly divide when division
was greate than 8.  This causes video failures on disp1_pix and
disp2_pix clocks.

Until a better solution is found, we'll have to revert this.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 6883a8199b6c..cbf0d7955a00 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -119,17 +119,10 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
 	return ret;
 }
 
-static int imx8m_clk_divider_determine_rate(struct clk_hw *hw,
-				      struct clk_rate_request *req)
-{
-	return clk_divider_ops.determine_rate(hw, req);
-}
-
 static const struct clk_ops imx8m_clk_composite_divider_ops = {
 	.recalc_rate = imx8m_clk_composite_divider_recalc_rate,
 	.round_rate = imx8m_clk_composite_divider_round_rate,
 	.set_rate = imx8m_clk_composite_divider_set_rate,
-	.determine_rate = imx8m_clk_divider_determine_rate,
 };
 
 static u8 imx8m_clk_composite_mux_get_parent(struct clk_hw *hw)
-- 
2.39.2

