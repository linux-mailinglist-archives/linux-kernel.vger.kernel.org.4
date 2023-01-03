Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5E065C62C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbjACSZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238899AbjACSZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:25:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2011A13EB4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672770178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=avG5o+d+WafGuIANh+snkCOFuGEerUfVooHGU6nig9g=;
        b=BrOwO/xJUyh0AS53onMHomGrED2lwUia/7+pwTgH66q16RfX9WtCgvMHWXZ+AddE+xDZ35
        SO17+XywEJUi3I7CKEYBeF76nkYxM9q8Polz9eKjm0a8CLp4PL6R6Ep21cUM0OkkT6P6ck
        0LkxZRUyKHingRLJgH8jpYt3vZ33sGs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-541-jYIcaiPMMfKGAX4RSvsVGQ-1; Tue, 03 Jan 2023 13:22:57 -0500
X-MC-Unique: jYIcaiPMMfKGAX4RSvsVGQ-1
Received: by mail-qt1-f200.google.com with SMTP id fg11-20020a05622a580b00b003a7eaa5cb47so10701747qtb.15
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 10:22:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avG5o+d+WafGuIANh+snkCOFuGEerUfVooHGU6nig9g=;
        b=K5uPPc9m1CYXF+GIBX6rv/HNkB7m26qtbQKS/ml69d88oA8ksXxLqrfnJvcHJdbg8C
         UfEKYN3oKx1LUjHxFdfgevtOXQGuvZ4yT4XIv0H5sDXUkJkhUZXq087dIoBTlJLwA16c
         ulNO9gvNeMS3/oPkrDQOOps3AzXNvo8Op02LQsqkuLD2viLgVpHl+R92rxKV8jiYvIOy
         DP2HPdAKvPR84VWM53Et9o2ErvAYlpQbSUmhjAEuoD49XxcI5jlnVDxADtI4Q0seiU6/
         ZFRLtlEBXbslJbf9bXMuA1Qj/62aKu2wm3BrxEje+clHhpfJHVHESJcxC3kcDF2ZwYN4
         qQmA==
X-Gm-Message-State: AFqh2kqZdX37vlWdSqRr5Ip1ZotVBBUP6LKEaHp3mWjV45dL2bzKIqkx
        2I6zpQy/mab/u9RXsmDCO+9EnMXo4IZHCgyzKJWmXfgQqetB7NPrL3RzR9SsJRrvNHCSmBcGkNi
        df/i8Px5+/Gy1TS9i5qtA5KYy
X-Received: by 2002:a05:6214:9a7:b0:531:aafe:70f7 with SMTP id du7-20020a05621409a700b00531aafe70f7mr25359042qvb.22.1672770176802;
        Tue, 03 Jan 2023 10:22:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXty9FI5MyWj0yHPT7qJeR+dxDagNklaONvXOucRNkEly7Mb6iG/7tt1cjWkc57kNkSC5GBFmw==
X-Received: by 2002:a05:6214:9a7:b0:531:aafe:70f7 with SMTP id du7-20020a05621409a700b00531aafe70f7mr25359022qvb.22.1672770176580;
        Tue, 03 Jan 2023 10:22:56 -0800 (PST)
Received: from x1.. (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id t13-20020a05620a450d00b006fba0a389a4sm22819675qkp.88.2023.01.03.10.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 10:22:55 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.co
Subject: [PATCH v4 08/10] arm64: dts: qcom: sa8540p-ride: add i2c nodes
Date:   Tue,  3 Jan 2023 13:22:27 -0500
Message-Id: <20230103182229.37169-9-bmasney@redhat.com>
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

Add the necessary nodes in order to get i2c0, i2c1, i2c12, i2c15, and
i2c18 functioning on the automotive board and exposed to userspace.

This work was derived from various patches that Qualcomm delivered
to Red Hat in a downstream kernel. This change was validated by using
i2c-tools 4.3.3 on CentOS Stream 9:

[root@localhost ~]# i2cdetect -l
i2c-0  i2c             Geni-I2C                                I2C adapter
i2c-1  i2c             Geni-I2C                                I2C adapter
i2c-12 i2c             Geni-I2C                                I2C adapter
i2c-15 i2c             Geni-I2C                                I2C adapter
i2c-18 i2c             Geni-I2C                                I2C adapter

[root@localhost ~]# i2cdetect -a -y 15
Warning: Can't use SMBus Quick Write command, will skip some addresses
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:
10:
20:
30: -- -- -- -- -- -- -- --
40:
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60:
70:

Signed-off-by: Brian Masney <bmasney@redhat.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Shazad Hussain <quic_shazhuss@quicinc.com>
---
No changes in v4

 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 83 +++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index d19af74f5057..e4badf6f7a52 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -17,6 +17,11 @@ / {
 	compatible = "qcom,sa8540p-ride", "qcom,sa8540p";
 
 	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c12 = &i2c12;
+		i2c15 = &i2c15;
+		i2c18 = &i2c18;
 		serial0 = &uart17;
 	};
 
@@ -146,6 +151,41 @@ vreg_l8g: ldo8 {
 	};
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_default>;
+
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_default>;
+
+	status = "okay";
+};
+
+&i2c12 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c12_default>;
+
+	status = "okay";
+};
+
+&i2c15 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c15_default>;
+
+	status = "okay";
+};
+
+&i2c18 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c18_default>;
+
+	status = "okay";
+};
+
 &pcie2a {
 	ranges = <0x01000000 0x0 0x3c200000 0x0 0x3c200000 0x0 0x100000>,
 		 <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>,
@@ -188,6 +228,14 @@ &pcie3a_phy {
 	status = "okay";
 };
 
+&qup0 {
+	status = "okay";
+};
+
+&qup1 {
+	status = "okay";
+};
+
 &qup2 {
 	status = "okay";
 };
@@ -268,6 +316,41 @@ &xo_board_clk {
 /* PINCTRL */
 
 &tlmm {
+	i2c0_default: i2c0-default-state {
+		pins = "gpio135", "gpio136";
+		function = "qup15";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	i2c1_default: i2c1-default-state {
+		pins = "gpio158", "gpio159";
+		function = "qup15";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	i2c12_default: i2c12-default-state {
+		pins = "gpio0", "gpio1";
+		function = "qup15";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	i2c15_default: i2c15-default-state {
+		pins = "gpio36", "gpio37";
+		function = "qup15";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	i2c18_default: i2c18-default-state {
+		pins = "gpio66", "gpio67";
+		function = "qup18";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
 	pcie2a_default: pcie2a-default-state {
 		perst-pins {
 			pins = "gpio143";
-- 
2.39.0

