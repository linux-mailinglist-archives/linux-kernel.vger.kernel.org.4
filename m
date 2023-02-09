Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9E568FCEE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjBICJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjBICJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:09:31 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680E826864
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:09:23 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id i1so474174qvo.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 18:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0Kv4X6lak5DdzB8VDtgoIDsMjj+8WEhFUSFDMt/p4c=;
        b=NWtw/K095wUlwzsXi3OLyilezsTbOrZ9eFy4EpsxxDT6lx8OFpCNBwoog7Ey4fc1BN
         bXXPONkdvUbK1Q5C3ACw6uFfYQzA3FgjDiuKFDSV8yjAn5T+mNJBrMn8gWb3Eac8Zx1m
         B33OJcVDgBdXoKuHknSXJzRIoRr9APbrA2D7Jbjl0maKuLUJFfVg7YUMIZqCuSD2VZO1
         2XL6DkXn1KLBPaybSssyb9khGmRm+naMqb27BTIKD2Ot32Tsqp3MkS9pTOmcu4FHdSIn
         jQfBlbz5+Tp9fKELCUTKqEUrarPE6RbcuPqjKLw4AyYlwYlbeXJ1bIteR0BS06MwcGMx
         6h0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0Kv4X6lak5DdzB8VDtgoIDsMjj+8WEhFUSFDMt/p4c=;
        b=5juvPKGHpMonM35/yIHJe4/I3dfLXk+iQsCu+Cxa2LHYvCw6ipw+CyUef+WcMcx0z2
         aWU32zv3BFDwYpth2rKq2p4xSCt/zhSFmc2do3HNGhF92cwtNWxVLi1KOhz0a+GSOTZK
         LFsKdaGoFjnTyh9YB7DyziuU/2dg2AoCv2z2NBlrddi66PgVdp/NspjEiVxG+ETZMSzh
         A0lJBTHTHYX3IedSKCdt+XOhPShPzC2u6q4ZSNVdwaRX9E5CZFWdFK0EGIqzykl1xDXI
         hnaTvXiiyLFvTznbgklV1jhwio6y6vbdsq/3bBIeGShtI8tKZJdnwRVExEkbzhImLewH
         ECGw==
X-Gm-Message-State: AO0yUKXjcnLIM9+NX44gLkThKXrzscb1qId3A8BR9vc4HDpesSd71ZTi
        rsq3bTasS5rUlf98Uyr2BzBQY8UtUA4yfHutspw=
X-Google-Smtp-Source: AK7set+CUoNhTzLLRmmU7/Ef/us0Ss4xkGFHu0oL7/h7QJE6lrxUWrxnC4wifjd3JdOqBpBjU13/7Q==
X-Received: by 2002:a05:6214:d43:b0:56b:f096:c85 with SMTP id 3-20020a0562140d4300b0056bf0960c85mr17218459qvr.4.1675908562533;
        Wed, 08 Feb 2023 18:09:22 -0800 (PST)
Received: from localhost (23-118-233-243.lightspeed.snantx.sbcglobal.net. [23.118.233.243])
        by smtp.gmail.com with ESMTPSA id u64-20020ae9d843000000b0071b368cf074sm332913qkf.118.2023.02.08.18.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 18:09:22 -0800 (PST)
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
Subject: [PATCH v5 3/4] arm64: dts: qcom: sc8280xp: Define uart2
Date:   Wed,  8 Feb 2023 20:09:15 -0600
Message-Id: <20230209020916.6475-4-steev@kali.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209020916.6475-1-steev@kali.org>
References: <20230209020916.6475-1-steev@kali.org>
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes since v4:
 * None

Changes since v3:
 * Fix commit message changelog

Changes since v2:
 * No changes since v2

Changes since v1:
 * change subject line, move node, and add my s-o-b

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
2.39.1

