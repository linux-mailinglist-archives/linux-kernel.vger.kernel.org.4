Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDB164CEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 18:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbiLNROn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 12:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbiLNROK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 12:14:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6C529361
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671037928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=exdEpbp2sw0OgZfqs83IQrs+qTbCCjPaqrx3NldGQYU=;
        b=OycHjcFQUeMfkNhllpKhAyQBy1itEevxIyy4xGZxx5iWv+Uf1DR/cU77LHBb0I31thr+Vo
        sIruOXnoLF8DYaz71n+/vAsek2X4345uChDfLgRuXj9L7KteAzpDHW4muCF/7mkTb5U6UD
        IPm61VEb0FoDdbT+2WvLHL4zV7VKerY=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-12zsr--dO6W8TQmsdacOmw-1; Wed, 14 Dec 2022 12:12:07 -0500
X-MC-Unique: 12zsr--dO6W8TQmsdacOmw-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-39afd53dcdbso4689367b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exdEpbp2sw0OgZfqs83IQrs+qTbCCjPaqrx3NldGQYU=;
        b=6u4KpQ9KvZhWkF6wXFN1Qfe1Rd76CnuK9UEC5hnIfuL+M+P+MonZYD7K+s3QnH5PXT
         fmQXMpaxH+Pq6SpCX9ZVDlHoq4wXlP6V0awU2SD8eHatUyZq1djpXz+WrB76ywUK2bmf
         53vjKaho7Qs1kSlCB0HnjKdjgDfhlxtbC4yYA7BZl6kl5VDd6XMZ83GdTg4NLma1BfIz
         YTHkc9aONCMc3ZkC4LUbDFTg+MJsIzLyYyNY4hP5Mj6gqOE7y72G3jYOr6GowywhOsPZ
         uNqp2PdwDmm7cgNn9ZSTvD1j228TzmMZ/jgpIjUGf9vw2CDL22cuUWNNTfpQuuTbEwL6
         9p0Q==
X-Gm-Message-State: ANoB5plBs623cFIxWV+9v/7Oa2nl5R9VskGL1qQyhQDih+7IRDGiTmkq
        h3RWoKBUTwKD0K1dytgO2FcbH7El2x8/7rP9hAYAGn+WiROTcc47qvK4ilry4v9IBGWZWFta82U
        7luGLL/h09pMhZCk2Uij0eIsM
X-Received: by 2002:a05:7500:1612:b0:ea:6410:dd10 with SMTP id p18-20020a057500161200b000ea6410dd10mr2858258gac.33.1671037926014;
        Wed, 14 Dec 2022 09:12:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6wJW2fT9ZbKO4fRncd+RDc7xyf+paIRLlNbE+sVJSqJeFBQyfa3m3lHGJaTiorUYBr7kf7FQ==
X-Received: by 2002:a05:7500:1612:b0:ea:6410:dd10 with SMTP id p18-20020a057500161200b000ea6410dd10mr2858229gac.33.1671037925610;
        Wed, 14 Dec 2022 09:12:05 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id t30-20020a37ea1e000000b006eef13ef4c8sm10305477qkj.94.2022.12.14.09.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 09:12:05 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: [PATCH v2 6/7] arm64: dts: qcom: sa8540p-ride: add i2c nodes
Date:   Wed, 14 Dec 2022 12:11:44 -0500
Message-Id: <20221214171145.2913557-7-bmasney@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214171145.2913557-1-bmasney@redhat.com>
References: <20221214171145.2913557-1-bmasney@redhat.com>
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
---
Changes since v1:
- Dropped qupX_ prefix from labels. (Johan)
- Reordered nodes based on new name.
- Added i2c buses 0, 1, and 12 (Shazad)
- Drop mux/config-pins and have the pin properties live directly
  under the i2cX-default-state node. (Konrad)
- Use decimal notation for drive strength (Johan)

A few things to note with this series applied on top of linux-next:
- Reading from i2c-0 using 'i2cdetect -y -a 0' gives the following error
  when reading from the ranges 0x30-0x37 and 0x50-0x5F.
      geni_i2c 980000.i2c: Timeout abort_m_cmd
- i2c-1 and i2c-2 successfully read using i2cdetect, however it takes
  several seconds.
- i2cdetect runs fast within a small fraction of a second for i2c-15
  and i2c18.
- 'i2cdetect -y -a $BUSNUM' shows the same address ranges 0x30-0x37
  and 0x50-0x5F in use on all 5 buses.

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

