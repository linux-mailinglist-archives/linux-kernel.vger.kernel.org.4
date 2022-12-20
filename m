Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B4965270B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbiLTTab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbiLTTaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:30:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A1F1C929
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671564554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V5KZ03q3brjFsVr9luBNPSoT3RCcLRC1btSeHOj/mAg=;
        b=dHcNRi/IfwtCMEsXy2IhB8zhM7cQv4cNBoO7u0cJbpkXt+G5Yc04vlkTIDaOdVkeIkKDik
        6muVHcvY50Sw9XzY4QequTMMEmiyTl/2hV0Kz9mdJsNbfPLn0NImuRyOIePZHzu/8usqYq
        W9O2M03QI3QvGVjIT9KB2Ba4/4OVnVI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-470-3LzyJTMXPj6uev_Rv80pCg-1; Tue, 20 Dec 2022 14:29:12 -0500
X-MC-Unique: 3LzyJTMXPj6uev_Rv80pCg-1
Received: by mail-qt1-f199.google.com with SMTP id d12-20020ac851cc000000b003a8118f79daso5962161qtn.19
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:29:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5KZ03q3brjFsVr9luBNPSoT3RCcLRC1btSeHOj/mAg=;
        b=APoVtfJuOwuhT06spMC4NsIaOECh4InN+pp4UGaY78L2W7Pmaq8lBgrtGZEXfMKRhS
         EEbgx5Pj3LgrXL24F3mnGN51xjMejZL9IG2YXtVHDFumtUTfYMQWTnPuNFwWFFrRs9p2
         PvyMwKlh22NVOjgSqRjx/VE7R6uHbmEUNW13LoZm6p3CnkQlpRkW8laHVHWKsemqeHf6
         bFntX34CiotQRHspWDjUOFjqpO3MBjw1kk68ZPJx1uqH7k2NYS+L3vfvCIp6rOmZAVT0
         NPD3Qp7I2SGjZ068qr5AEPJRz86BZEOQs3Q4Z0VlR362y2dsXwtjOB0SZIvgWu4UcPVo
         Z++A==
X-Gm-Message-State: ANoB5pm3II5HnoKgBybn+7tmOWcBR482/yXmjQbXtqfQY8HUlVUTfkNl
        6dTqcN+eTtlKCCZy6uU3a2h8EZh3WqKx8gVsg/8Dbf/sie3sVtOUo65DMN7tJqy7kG0uPA1AifM
        0viKyySNXoSt45WEArEQFzBSe
X-Received: by 2002:ac8:4a11:0:b0:3a7:f599:1d2c with SMTP id x17-20020ac84a11000000b003a7f5991d2cmr65766013qtq.63.1671564552297;
        Tue, 20 Dec 2022 11:29:12 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6EkY/kXeoI45tp7hj7xhL4ZcXIBj2t0hPwm2/PbZBdmcDUTtoiaLLREk8avANnAadBJ5NlHA==
X-Received: by 2002:ac8:4a11:0:b0:3a7:f599:1d2c with SMTP id x17-20020ac84a11000000b003a7f5991d2cmr65765989qtq.63.1671564552040;
        Tue, 20 Dec 2022 11:29:12 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id gd15-20020a05622a5c0f00b003a82ca4e81csm744348qtb.80.2022.12.20.11.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 11:29:11 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: [PATCH v3 6/7] arm64: dts: qcom: sa8540p-ride: add i2c nodes
Date:   Tue, 20 Dec 2022 14:28:53 -0500
Message-Id: <20221220192854.521647-7-bmasney@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221220192854.521647-1-bmasney@redhat.com>
References: <20221220192854.521647-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
Changes from v2 to v3
- Added Konrad's R-b and Shazad's T-b

Changes from v1 to v2
- Dropped qupX_ prefix from labels. (Johan)
- Reordered nodes based on new name.
- Added i2c buses 0, 1, and 12 (Shazad)
- Drop mux/config-pins and have the pin properties live directly
  under the i2cX-default-state node. (Konrad)
- Use decimal notation for drive strength (Johan)

 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 83 +++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index b6e0db5508c7..ccd2ea3c9d04 100644
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
2.38.1

