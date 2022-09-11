Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA6F5B4E28
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiIKLP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiIKLON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:14:13 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FFE3DBF5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z25so10392933lfr.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=VVRMe5K9zQktuETEV7D34ZSBEU0mHzUqiBeP7TQimRg=;
        b=TPRQYWyFaIE2NL91c/UGueEkDW+rrjJMXDWHFp3TrW0bEJZUszkyyLiQmYzzLZvmmw
         U1XLWPKZV6bgbcsX2kD8DFzB7Tlvp3okZ5qRN0cigKsRKnD1GBoJag3BUmIZJRGXJbhd
         LZiaSAVKs6/j7UhQ7uATMq64MWXHqaG8zfqCtNuau6c85ZJkESg53zXuEj3/yS80lFWc
         korb9iy5j8zNONCMdBNacqFphfPMkxxJJG/JjzAAkOUIgG+/jMgdtjcdEhnJl39Gctd9
         m8Hndvu9g8QEweuTC8OsvHtqcB8gQxEOemjE780WBtyNZlGfC/SeZE7qd8O8upE43KGx
         kd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VVRMe5K9zQktuETEV7D34ZSBEU0mHzUqiBeP7TQimRg=;
        b=YMsOCD9hfs4BGeiX13tTSgEKgy7NBqw8/JJU2AeBdMXLhybpd6Pv2lZDTS0kUBfRgM
         empG3/XNu5JTFX4ca3xZ2PYWwJ1TbaZBlkAkrEDOZVGgVPvtu5dRPcQKWXC142ZfME20
         mrSbbss1ccaTsi14uczwtyXfZlInKmnVe4IdrO6zZtnv2hPHO1oMK0EtHJl21zPg1rf2
         x6jFGcidUpkaFYmaByGMcLVwJemQcQRuPueNmFP2l/3QMOwn+IZ4xrLFVrXx3d2RaMea
         Z+dQQsYgSzO3TPW7btYEVBJ7WD4MIwy9EYlIRWUIQ2OUxAUDU6TNXJ5nJJHdTdjnlCbw
         fazA==
X-Gm-Message-State: ACgBeo13AIGMCzehq7v3VUM91Eq+afgfthtwLYh7Yg4K4Ksa6kqIEWsp
        GOEXpQL2u2OkdpEvXWjJ1yNZDA==
X-Google-Smtp-Source: AA6agR44IqbVtkDkNkeYN3N9BRB2ZKYL9EtrOXYqnVwp98NIzDUbDtydQjTlzVwyacE/DG3gHC7ayA==
X-Received: by 2002:a05:6512:c1c:b0:499:acb9:5788 with SMTP id z28-20020a0565120c1c00b00499acb95788mr2203332lfu.347.1662894776682;
        Sun, 11 Sep 2022 04:12:56 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025dfd8c9287sm607365ljc.69.2022.09.11.04.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 04:12:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 40/40] arm64: dts: qcom: sc7280-herobrine: correct TLMM gpio-line-names
Date:   Sun, 11 Sep 2022 13:12:00 +0200
Message-Id: <20220911111200.199182-41-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
References: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
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

There are 174 GPIOs in SC7280.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
index bc795c480352..3448e9ed8b03 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
@@ -371,7 +371,5 @@ &tlmm {
 			  "",				/* 170 */
 			  "MOS_BLE_UART_TX",
 			  "MOS_BLE_UART_RX",
-			  "",
-			  "",
 			  "";
 };
-- 
2.34.1

