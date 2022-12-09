Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3B264830F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiLINy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiLINyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:54:11 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C0775098
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 05:54:10 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c17so3130073edj.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 05:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4yh5xgjEQoq90Bl89iS4Grp7fPsFxoV4M+wDWpZgpE=;
        b=T9AMDcmPce0wGjd2pPpDE2xhD/MhpmqUzUpvmRoOTT+76RP0S+fE/RqkE/j85/pdM4
         YiBAFTw4rHHyO40snTvXwUVOXawyZ+3K5I8AqjJ5EEiW9HndRoTV/EOqZYvDvo1WJboV
         R41ULrSdSW/Md7gdUykVAGDJ13/VqjlrcKmO0HcAmDp74cIwgCvUjFa32w0uAj7n+hN8
         BM7ZXBrnOzw12Bjpv8iYeEHmW2yGsDwdBv7mej4QneFqqtZDQnZMx6B7pDJLHHhkMJH1
         BkaACbwnnFvUpT4+2tDGT7zD3ZSJ0dgDqheUbN0omCxCC4S+oOtyORuOZCcFFrXx4EQZ
         MPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4yh5xgjEQoq90Bl89iS4Grp7fPsFxoV4M+wDWpZgpE=;
        b=jawftYBkrhJPcChBcLPbyeNuYZihGQCVx4nzG3A1+Vg8+qvG8U1TkHD7MPj/hJ9aDV
         iotZ1pROIKoLyslJZzjweTtBX35cwPh7DQoq/Mp8JU9kSLvlMavntlPrZn8U7by4PlBH
         b2fyqbuAwEsRjffrL8P8wE+lsmYn3O6MK3Y8aA0TO2kF3MwDX/lRmWuGGfAEMs2JUd1S
         Lb82WkANBqM7PhxqS91tSIs8AXepmOIzsEUXm4FCcNHRXc7J4DEtEczQz3yR292oC3ff
         LxabJ7xRb9HH5yAWeY8r1r6m+X4VYdxhtqphD++BaW1l3vKt/49HevxJsRYIeyntfRCu
         tkSw==
X-Gm-Message-State: ANoB5pkvo2swDslWaHykQzQfqGp3JIfukNr8L6IiYlQm4dz8pmrZc4+i
        3oq8Hb0YfJPGP3Q6iDZBQMHmmA==
X-Google-Smtp-Source: AA0mqf7X23tw1uk6uJrsTDNddrFALdnj1e042jncHPzXIju6bC/k236aIcNNV+1TT/qimYb9pExEWg==
X-Received: by 2002:a05:6402:5483:b0:467:7b2e:8863 with SMTP id fg3-20020a056402548300b004677b2e8863mr3742690edb.12.1670594049274;
        Fri, 09 Dec 2022 05:54:09 -0800 (PST)
Received: from [172.16.240.113] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id k19-20020aa7c393000000b0045b4b67156fsm656371edq.45.2022.12.09.05.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 05:54:08 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 09 Dec 2022 14:54:07 +0100
Subject: [PATCH 2/3] arm64: dts: qcom: pm6150l: add spmi-flash-led node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221209-fp4-pm6150l-flash-v1-2-531521eb2a72@fairphone.com>
References: <20221209-fp4-pm6150l-flash-v1-0-531521eb2a72@fairphone.com>
In-Reply-To: <20221209-fp4-pm6150l-flash-v1-0-531521eb2a72@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.11.0-dev-64ef0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node describing the flash block found on pm6150l.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pm6150l.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
index 90aac61ad264..86e659fcbba6 100644
--- a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
@@ -112,6 +112,12 @@ pm6150l_lsid5: pmic@5 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm6150l_flash: led-controller@d300 {
+			compatible = "qcom,pm6150l-flash-led", "qcom,spmi-flash-led";
+			reg = <0xd300>;
+			status = "disabled";
+		};
+
 		pm6150l_wled: leds@d800 {
 			compatible = "qcom,pm6150l-wled";
 			reg = <0xd800>, <0xd900>;

-- 
2.38.1
