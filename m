Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B4164A712
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiLLSZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiLLSZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:25:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0084C10561
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670869409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RNRWKbvSrCXZ9TypSYBFGXfCQmVHCCSFxdSjpbnG1lo=;
        b=AiST9yNyra27RLPQ0zFESco8CjE5IPBu394tP7LzLi9Yy1N6Q+LPFtgeTXnkowUM67kRd2
        znaYmHwNS2TJoZ3EYfIqzt8BT8uQLNtgBa5GmTdgde0bJeE8GuU+tWfDMcGlpBKCwzx+4F
        KlWU1t9eO0VJgDUb0XqT7z+H/8MXDlo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-306-A75TLJANPG-X9xdZLppgWQ-1; Mon, 12 Dec 2022 13:23:28 -0500
X-MC-Unique: A75TLJANPG-X9xdZLppgWQ-1
Received: by mail-qv1-f70.google.com with SMTP id q17-20020a056214019100b004b1d3c9f3acso12341061qvr.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:23:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNRWKbvSrCXZ9TypSYBFGXfCQmVHCCSFxdSjpbnG1lo=;
        b=4vjc4WMkywyqYj8/tjUJ8o1OzSNE5El9XIIsCKRKqUoSP55l8howF3zOpOPNp5G+cn
         3Qv8uZown2uHFNxxw+SX2DQ6Nz3XMP+evbcHoY+YXgRS1jXnfm/TwfxkJ/j4H7Yg82Bf
         CoSUR2fEKlcLIeXIfazCQPw8EOqn4oJEQ2rlcYCIHmZa81xLaDbKFUOXfgNy1zYPZyn+
         AxNr51n+KR+XgX2zfAT7uLAGP5QabpyrL+Qi53Ns7G0I9XELVJilAu+p49Gk82/BYrbl
         Cnop/GuNTiNdgWoVIWQJ0LPY4hfx6B11eDIHKJlbqIo3DA8xTnnp+eHdwTWXxpdCszlS
         XqKA==
X-Gm-Message-State: ANoB5pmQVhp6jvZVFud4p2DfnUn7HcETTEamPJXR2AYNaRvvq+zNrO5U
        stqsdaT2BwPjYQkr9IT0PpDzNZDFMyEHo6y6xjP3k5a1fbyPsZoshhsrZfSiky1LVCj7F7bUv20
        IimaApuchIBycB+5TAGZ22++o
X-Received: by 2002:a05:622a:1002:b0:3a5:4e34:fafe with SMTP id d2-20020a05622a100200b003a54e34fafemr31500858qte.68.1670869406500;
        Mon, 12 Dec 2022 10:23:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4HBiTstXeYxhuHfnbAyBQx9WQlcLgo2NvTrwin0TtsiHxqIxmtIb7g4OADwFQ1eShhvPKZ8w==
X-Received: by 2002:a05:622a:1002:b0:3a5:4e34:fafe with SMTP id d2-20020a05622a100200b003a54e34fafemr31500828qte.68.1670869406248;
        Mon, 12 Dec 2022 10:23:26 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id 3-20020ac85643000000b003a816011d51sm1998185qtt.38.2022.12.12.10.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:23:25 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com, quic_shazhuss@quicinc.com
Subject: [PATCH 3/4] arm64: dts: qcom: sa8540p-ride: add qup1_i2c15 and qup2_i2c18 nodes
Date:   Mon, 12 Dec 2022 13:23:13 -0500
Message-Id: <20221212182314.1902632-4-bmasney@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212182314.1902632-1-bmasney@redhat.com>
References: <20221212182314.1902632-1-bmasney@redhat.com>
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

Add the necessary nodes in order to get qup1_i2c15 and qup2_i2c18
functioning on the automotive board and exposed to userspace.

This work was derived from various patches that Qualcomm delivered
to Red Hat in a downstream kernel. This change was validated by using
i2c-tools 4.3.3 on CentOS Stream 9:

[root@localhost ~]# i2cdetect -l
i2c-15  i2c             Geni-I2C                                I2C adapter
i2c-18  i2c             Geni-I2C                                I2C adapter

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

Bus 18 has the same output. I validated that we get the same output on
the downstream kernel.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 46 +++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index d70859803fbd..6dc3f3ff8ece 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -17,6 +17,8 @@ / {
 	compatible = "qcom,sa8540p-ride", "qcom,sa8540p";
 
 	aliases {
+		i2c15 = &qup1_i2c15;
+		i2c18 = &qup2_i2c18;
 		serial0 = &qup2_uart17;
 	};
 
@@ -188,10 +190,28 @@ &pcie3a_phy {
 	status = "okay";
 };
 
+&qup1 {
+	status = "okay";
+};
+
+&qup1_i2c15 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&qup1_i2c15_default>;
+
+	status = "okay";
+};
+
 &qup2 {
 	status = "okay";
 };
 
+&qup2_i2c18 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&qup2_i2c18_default>;
+
+	status = "okay";
+};
+
 &qup2_uart17 {
 	compatible = "qcom,geni-debug-uart";
 	status = "okay";
@@ -313,4 +333,30 @@ wake-pins {
 			bias-pull-up;
 		};
 	};
+
+	qup1_i2c15_default: qup1-i2c15-state {
+		mux-pins {
+			pins = "gpio36", "gpio37";
+			function = "qup15";
+		};
+
+		config-pins {
+			pins = "gpio36", "gpio37";
+			drive-strength = <0x02>;
+			bias-pull-up;
+		};
+	};
+
+	qup2_i2c18_default: qup2-i2c18-state {
+		mux-pins {
+			pins = "gpio66", "gpio67";
+			function = "qup18";
+		};
+
+		config-pins {
+			pins = "gpio66", "gpio67";
+			drive-strength = <0x02>;
+			bias-pull-up;
+		};
+	};
 };
-- 
2.38.1

