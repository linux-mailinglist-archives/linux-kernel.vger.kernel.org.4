Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEBA600188
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJPRBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJPRBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:01:19 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EAD31EC4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:01:17 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id y10so6239082qvo.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHCjDmNzA6ce+e/MAOdHluOTeKhVdn9kfCUAVEme8Xs=;
        b=IvHlPO09EpgN/kOC1qqRiUz5J2tq+IovGny1uj+nS01Hi6XmohUFmKfuGXxkTW4+nT
         fiYPRdIKlp5vsyp7dOv+GjOV3wi2GlEOZPHwk55KahXhCupwlG/2gwSDFRFW+piYExHA
         mBy1TxgKbGcDRjOzgRnGAqNjWsdNm/Fu2PB9c7rr5tV7dt0EXy7keRmxeDf0W+5GTDkj
         AaY3rb/xIl2XJUH2tY5Tt2Kh6RPNYuBfk3OsFdj16FO3PGzyCinCFzfvauAzPgXyTnd1
         KYne8T8Nyuptm1gt30LLzDPMwSK/LxJh6BNdF2TxAtjWAuKbdWW23B7OO+YLCVXPNkDR
         dbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHCjDmNzA6ce+e/MAOdHluOTeKhVdn9kfCUAVEme8Xs=;
        b=o4R3T4LzF877/FQwNRXuYY6WUpmBkHIDlTHSAp1Yot/4FuaHa21MmX5RJUt00hBn9c
         r01s3aZXQm9eO4sa/5g/UMAhUywDPDzHm5VvRSQN+TIy1GdG52NiCZHJplE3o9p+T9cT
         zgRzm/vqiXTbXpvpZuYcLwjIrBfn/Jkm9XG9sxdpreeSG6DXkMrAHlZ3rtyKQ5Q2+is4
         A5UxFsYeppkXt+FZ7l2I3yrd49+I//PShebc3xntbhd1GGZBzoRSeTK9kviOKwm4ojUY
         4nh5xQUStQOSPXz/GGfcwMhuOwq105+nUF77YflyBw5vMaKAx7KDxCljiR8ZJGQqHFv8
         EKRg==
X-Gm-Message-State: ACrzQf0vw4/vGqEDIm3qA6aJ3ATNwClEzJVpiq/vyWXGZnkSNm4oZL1j
        vxca6j3nbByCSt/4qqnSUBgjig==
X-Google-Smtp-Source: AMsMyM6coVoNFBBEgZ1+xr4BUyAl3YksMO5aIhZspwjIEscmBhVEGzp3qCV91vZuhA3u9oKBa+3VrA==
X-Received: by 2002:a05:6214:2346:b0:496:ba45:bdb0 with SMTP id hu6-20020a056214234600b00496ba45bdb0mr5755707qvb.47.1665939677074;
        Sun, 16 Oct 2022 10:01:17 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006ce7bb8518bsm7539967qkl.5.2022.10.16.10.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:01:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 01/34] arm64: dts: qcom: ipq6018-cp01-c1: use BLSPI1 pins
Date:   Sun, 16 Oct 2022 13:00:02 -0400
Message-Id: <20221016170035.35014-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When BLSPI1 (originally SPI0, later renamed in commit f82c48d46852
("arm64: dts: qcom: ipq6018: correct QUP peripheral labels")) was added,
the device node lacked respective pin configuration assignment.

Fixes: 5bf635621245 ("arm64: dts: ipq6018: Add a few device nodes")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

---

Changes since v2:
1. Do not switch to blsp1 (Robert)
---
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
index 1ba2eca33c7b..6a716c83e5f1 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
+++ b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
@@ -37,6 +37,8 @@ &blsp1_i2c3 {
 
 &blsp1_spi1 {
 	cs-select = <0>;
+	pinctrl-0 = <&spi_0_pins>;
+	pinctrl-names = "default";
 	status = "okay";
 
 	flash@0 {
-- 
2.34.1

