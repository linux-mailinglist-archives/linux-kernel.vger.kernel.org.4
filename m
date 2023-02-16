Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E54D6994DF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBPMxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjBPMxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:53:05 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FB93C7A2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:53:03 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d4so1664808wrj.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuXf3qcdLoRKFYAi7wFYWNuVj8BPbd9z/6kD6caVGIg=;
        b=U6wziLk5VK0em7tZCPVllUbuxwAfADINXVKJgchub5Xt0p8tk/6TpgL4lsQBVaZPSX
         eb8Xie8uI0r7VG2QrkiVXz89K39Ylvt4Ab6s+R0RwFeW6oKwPpduB7T9hAnh3Y3vwMTV
         U57h4W8djMI3cP6HcKpSrJu3jvtE+RQy9028yg/5OhY/gNIXan4xpClJFQSlVALKJpc0
         0sU4ZmQ8+ZrIib70a+6qtBmhrPRij2Ha/Ph/yjH+eqSaXqu6jkb390hWg01n7b8VEfBm
         G8fnLeWbk+o1UunBOyHK4IM4R1+WhWmDezJ+qullKL5WvRtWrD6pOKq5NrSegTpuRtKX
         V9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuXf3qcdLoRKFYAi7wFYWNuVj8BPbd9z/6kD6caVGIg=;
        b=oPfnswn+itxh15ZmGIoQuttioPKVmD6jd29RNfnlQLCaFF17WHBxbyHTNuELPuZDng
         xYrC+wk0O5YynCJEcOCKPHdsEQ7XYNHCDYvHWrHTfRa/xliKdb4OXiYFBRs0G5Tm/cgy
         gyBvndffzihE1AlC9pywC0H7Y3nEY3y5hcGZ3ldn2AW7cO9YYcisA2BDQR3tACSbkPic
         xruPlzjmLRsQkZFS13Cx7CWF4nB3c4vESSDEsXL4IuuAAFIwFCmKTuMbPgUuhF26FReA
         fuyjOdNBiaEMMkam7vbLh7INPg6e7oJGrBj6J/ZaHrU3+E8jdDijWMAfB/NsYtr0MBwI
         tRnw==
X-Gm-Message-State: AO0yUKUhbPp+8pShGp+sem85wMfRUZ139+KxzeRz4/nLyFIOfs2BnqoV
        7v1w+cKBMVvy2SdZXr/bT6xCiA==
X-Google-Smtp-Source: AK7set/fppPwIypQ59Se3kjutRGbfgpFr0UJHzPZY4k7kOOsYAY+qMJ4Y57KhOKVmvGrdJs2QFOvOg==
X-Received: by 2002:a5d:6685:0:b0:2c1:28e7:5081 with SMTP id l5-20020a5d6685000000b002c128e75081mr4263665wru.68.1676551982466;
        Thu, 16 Feb 2023 04:53:02 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7c5b:1160:db5d:72da])
        by smtp.gmail.com with ESMTPSA id h18-20020adffd52000000b002be5bdbe40csm1453292wrs.27.2023.02.16.04.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:53:02 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 2/9] arm64: dts: qcom: sa8775p-ride: enable QUPv3 #2
Date:   Thu, 16 Feb 2023 13:52:50 +0100
Message-Id: <20230216125257.112300-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230216125257.112300-1-brgl@bgdev.pl>
References: <20230216125257.112300-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the second instance of the QUPv3 engine on the sa8775p-ride board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 3adf7349f4e5..a538bb79c04a 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -24,6 +24,10 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&qupv3_id_2 {
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32764>;
 };
-- 
2.37.2

