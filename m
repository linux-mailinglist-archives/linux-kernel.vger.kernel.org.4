Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B073168CEFB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjBGF26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjBGF2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:28:41 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A592B2BC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 21:28:38 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1685cf2003aso17741131fac.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 21:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H11wObvkOaUJX39N+56q2fg5DEIQXRIgLuTf5I11IXU=;
        b=gbUBeLUQMlppUL/iY3joGWqE8IUp1jOEPkJbR9CPJlNzk+o5rLonHNAK3PY5ydCgb4
         SgWT7rovewn3LxuZIZ6N6uB6+REGUm6roRnxvnvkL8oN0DjuAJajP43A1EBkKaPl1Nis
         be7V9PEmptKu36gaV4Gigt4BX1n6BseP6GAtlHbh/ipGDEhgFJFxYTDl4CvL2aNEKJYn
         lsOe0WXYLqsNl2SMJZ5S60DSsy8/awLEk42sCh2CYj75dfP6c5GHwbK1GM4u3lZKVftM
         3kP5BV2KBY4h3/lj+81Es+J/KhwNpSLRZplIsEwD3SyMnRAXjtFKmWOaS9chaX6dnDmp
         V6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H11wObvkOaUJX39N+56q2fg5DEIQXRIgLuTf5I11IXU=;
        b=ME6OmgplJ/PpajMPL7cJJtWmiGyfVeoKgg4/XXMp6x7eZF8HW8K4cO9SDrv8X7SY6p
         nR4gFA4VlNO33wV+aLAqr50CE3c66ikR2r1hadwi4l+oxUq+ZaWHxxyyDzpimVd9nxUh
         MEDL6jaT0ZjvZsJKmkSLfmJDdjaQVDhMUklgYE4PBlr7/FB88jYH9ukPg5RDTPgi8Lpd
         C7C90mef6f7MWg+1yIgiFh3aOHaCLxJVuMYP3d0WK5UXBG6p7b/Il1vy96b2+r1BPkjS
         vQObZaaXqP+TbjtJzAxLE3ZyqRAeBzaLy4ZOAD197JFzvYfDnPDBzg5zc0vdlTiL8tEm
         jkHQ==
X-Gm-Message-State: AO0yUKWgwODUgFMYOMedN/3b2yFLZbnJL+ruLPQjI0AdEzxJSxhP793V
        O3EyXEfscEgAZuN/AobaeMcHfw==
X-Google-Smtp-Source: AK7set/ykWk5mIT+VEMqd96Np3mbn9xtuSGh9EPfZ8kGfxE8RJeH4egJim836yeL/xaBlmzuLwIIvw==
X-Received: by 2002:a05:6870:5b82:b0:163:def0:60b9 with SMTP id em2-20020a0568705b8200b00163def060b9mr866764oab.5.1675747717393;
        Mon, 06 Feb 2023 21:28:37 -0800 (PST)
Received: from localhost (23-118-233-243.lightspeed.snantx.sbcglobal.net. [23.118.233.243])
        by smtp.gmail.com with ESMTPSA id n4-20020a056870880400b0014866eb34cesm4979617oam.48.2023.02.06.21.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 21:28:36 -0800 (PST)
From:   Steev Klimaszewski <steev@kali.org>
To:     Steev Klimaszewski <steev@kali.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sven Peter <sven@svenpeter.dev>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        Brian Masney <bmasney@redhat.com>
Subject: [PATCH v4 3/4] arm64: dts: qcom: sc8280xp: Define uart2
Date:   Mon,  6 Feb 2023 23:28:28 -0600
Message-Id: <20230207052829.3996-4-steev@kali.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230207052829.3996-1-steev@kali.org>
References: <20230207052829.3996-1-steev@kali.org>
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

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Steev Klimaszewski <steev@kali.org>
Reviewed-by: Brian Masney <bmasney@redhat.com>

---

Changes since v3:
 * Fix commit message changelog

Changes since v2:
 * No changes since v2

Changes since v1:
 * change subject line, move node, and add my s-o-b
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index fa2d0d7d1367..eab54aab3b76 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1207,6 +1207,20 @@ spi2: spi@988000 {
 				status = "disabled";
 			};
 
+			uart2: serial@988000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00988000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+				power-domains = <&rpmhpd SC8280XP_CX>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
 			i2c3: i2c@98c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x0098c000 0 0x4000>;
-- 
2.39.0

