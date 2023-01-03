Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E1D65C612
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbjACSYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238678AbjACSYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:24:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B89F13D4C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672770166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vx6A6akq7PHwtGIgnM37bxxUZE5A9NMlryyMeUUiRQg=;
        b=NcxWnUq11/ywUCbcGRDr27ik7V12Gc/RiZZ1dgfBOrCLUlDCLhAzpuLA1Yu+KuNqrUOmsq
        TafS3dWIxuqZp+QZJR4lC9zEdExdZ4miQoKmQuee+ojjVChJ+ctONwlIBsoA8aTfdSgrZB
        z77HLETuECjMhK6X57ck5hVuufIoUwY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-73-Y_KaFxsfOuqemveCs7s2-A-1; Tue, 03 Jan 2023 13:22:44 -0500
X-MC-Unique: Y_KaFxsfOuqemveCs7s2-A-1
Received: by mail-qk1-f199.google.com with SMTP id bl3-20020a05620a1a8300b0070240ff36a0so21481728qkb.19
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 10:22:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vx6A6akq7PHwtGIgnM37bxxUZE5A9NMlryyMeUUiRQg=;
        b=SeANX/3yig4Eus6Fqa8XLwuAev2X3AX1WDywn95xzH/UXTJB/Dc5DELkJZrlBQV8eV
         IGV6iSC4y3XcWuodcYalPyxlswTUEB96hfxbI6HekBovYq2fIuqwXP+oQBAOnPu+8z0Q
         Mx5ksy0DgN0FQ8XQuPNtnNYr+Q1YJ/qx02KSe3ZccD8m/FZsb76ij+CgCittnnnD6Lku
         TOMYA+ow/jStniJGyHLcbH7XwCMUoc5ZK89g49DWqCTBYUEy3rIoANMUb+RoysOx6jem
         D0E6VL6fVsKmYEG/FbZ30BQhuMaLA8pCG2s7keCQ1+Wt6yiTGYBwE7gUf/jjJtL8TYoZ
         mKEw==
X-Gm-Message-State: AFqh2kqVIbAHQouO84Kx6pUf1PSuVGWGU/oSLlQOXgsMfDEUj+/bB+RQ
        lr6kcqmxI+z7bkh/DHsoLvrwVLsZY8HGYaS3Mi5Aq8aYS1eyzPf2SEJ9dGXgNQ0LCuCF+33Ei2T
        0w3pnzinW5ZsdC7x0St/rpQUX
X-Received: by 2002:a05:622a:2285:b0:3ab:a047:58ee with SMTP id ay5-20020a05622a228500b003aba04758eemr27528904qtb.25.1672770164260;
        Tue, 03 Jan 2023 10:22:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv7Llv18LO+qijYEiKVGA4UKRoXdwOr8M1+mjaVuvd7HZH2bN5CoQYsutbIg3zGeRexygPf3Q==
X-Received: by 2002:a05:622a:2285:b0:3ab:a047:58ee with SMTP id ay5-20020a05622a228500b003aba04758eemr27528886qtb.25.1672770164035;
        Tue, 03 Jan 2023 10:22:44 -0800 (PST)
Received: from x1.. (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id t13-20020a05620a450d00b006fba0a389a4sm22819675qkp.88.2023.01.03.10.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 10:22:42 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.co
Subject: [PATCH v4 02/10] arm64: dts: qcom: sc8280xp: move #{address,size}-cells on i2c nodes
Date:   Tue,  3 Jan 2023 13:22:21 -0500
Message-Id: <20230103182229.37169-3-bmasney@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103182229.37169-1-bmasney@redhat.com>
References: <20230103182229.37169-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the #address-cells and #size-cells properties on the existing
i2c nodes below the reg property so that all of the address-related
properties are grouped together.

Signed-off-by: Brian Masney <bmasney@redhat.com>
Link: https://lore.kernel.org/lkml/Y6Wnh+tXPhF6aC1b@hovoldconsulting.com/
---
New patch introduced in v4

 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 109c9d2b684d..c0ffca9c9ddb 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -830,11 +830,11 @@ qup2_uart17: serial@884000 {
 			qup2_i2c5: i2c@894000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00894000 0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
 				interrupts = <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 				power-domains = <&rpmhpd SC8280XP_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
@@ -861,11 +861,11 @@ qup0: geniqup@9c0000 {
 			qup0_i2c4: i2c@990000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00990000 0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 				power-domains = <&rpmhpd SC8280XP_CX>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
-- 
2.39.0

