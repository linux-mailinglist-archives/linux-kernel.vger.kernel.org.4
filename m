Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34455712D16
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243814AbjEZTJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243481AbjEZTJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:09:02 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D0B187;
        Fri, 26 May 2023 12:09:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-510f525e06cso1860846a12.2;
        Fri, 26 May 2023 12:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685128138; x=1687720138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aVzy92SBUMkeNgqTWxtWDoFkJg92aZ4R1TOIJLd57RQ=;
        b=iHtKIRTeumWIXEMU5r1wOj/WWNzofk21Ob8ZqpeIm+F4yNhfk4nRShLBkTbXwhwekF
         fxtKu5Lg1/SSMuqu3pl8wvQooqugsQ5ED/VIFbbW/KDCn5JYf3CEl9ZGiHd5jmTv4ZGE
         SxNfDO5lKW1u6eJBrQTvdYyZxM4O14gQFeNFY+lWTqBsGyGaxkW78bNgvZqCqMN2wHx8
         kyvgfVd8W1Au+qh4Khhkm1Oh/+1Jp9XAeQ5t4ND9krC7/5C1CNaBWyvbrM9+Qw8VRscs
         yCfxtKwpslqJuXytEyLSWSfJYeupzBWTaXqUTUGb8LieKIuPzyFgjyMQUgB+oVsb19LT
         xKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685128138; x=1687720138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aVzy92SBUMkeNgqTWxtWDoFkJg92aZ4R1TOIJLd57RQ=;
        b=idtiJ7Be+/N4QYKUDWFOQrQnG2w0nYPIXdOeqvHhIKLTBV5M8YdE6eodTFs0HYUJww
         RH+0JNcvLIL61gTnp09Zd90OipX/pY111QW2x9JigrCYhoMVHLfeujOt0TwKjeJguBNU
         Yh4s9UI1EdqRwS75uOJry52OJy0JHmEJQ1rXlKRKhekJinrOGBom2AgrQUqyxSfKBi3c
         78OLKs/ztogxnq2Av/AAif/oLn7zuDFIDkPu0eXfYzSBvxGOwrXNXkdNKJSUPDwQ4hko
         5FINVUmcXSQr+6ouGBE1EZjJ3+7jQ5dY4wvS/AKjIYqFX43rfP9pz59Xn21DUML7e3jT
         y6xw==
X-Gm-Message-State: AC+VfDxjPxPb6BeZcp/tFI1lftoOzxNpcADdXURrBTg21nChlzpVmEN/
        rhkTsb8rKcBxs7xK9ZkP/Lg=
X-Google-Smtp-Source: ACHHUZ5XSk2ILjGdLZteuicFA2+l9lIwrFaWtw5//Xo/jHy35YGqdGcVs/Mh1riYll17Z1eu+usSwg==
X-Received: by 2002:a17:907:26c3:b0:969:e9ec:9a0 with SMTP id bp3-20020a17090726c300b00969e9ec09a0mr2656362ejc.77.1685128137481;
        Fri, 26 May 2023 12:08:57 -0700 (PDT)
Received: from fedora.. (dh207-98-6.xnet.hr. [88.207.98.6])
        by smtp.googlemail.com with ESMTPSA id q18-20020a170906b29200b0095844605bb8sm2507439ejz.10.2023.05.26.12.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 12:08:56 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/2] clk: qcom: gcc-ipq6018: update UBI32 PLL
Date:   Fri, 26 May 2023 21:08:54 +0200
Message-Id: <20230526190855.2941291-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Update the UBI32 alpha PLL config to the latest values from the downstream
QCA 5.4 kernel.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/gcc-ipq6018.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
index 350ead66914ca..abd97b939850f 100644
--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -4149,15 +4149,20 @@ static struct clk_branch gcc_dcc_clk = {
 
 static const struct alpha_pll_config ubi32_pll_config = {
 	.l = 0x3e,
-	.alpha = 0x57,
+	.alpha = 0x6667,
 	.config_ctl_val = 0x240d6aa8,
 	.config_ctl_hi_val = 0x3c2,
+	.config_ctl_val = 0x240d4828,
+	.config_ctl_hi_val = 0x6,
 	.main_output_mask = BIT(0),
 	.aux_output_mask = BIT(1),
 	.pre_div_val = 0x0,
 	.pre_div_mask = BIT(12),
 	.post_div_val = 0x0,
 	.post_div_mask = GENMASK(9, 8),
+	.alpha_en_mask = BIT(24),
+	.test_ctl_val = 0x1C0000C0,
+	.test_ctl_hi_val = 0x4000,
 };
 
 static const struct alpha_pll_config nss_crypto_pll_config = {
-- 
2.40.1

