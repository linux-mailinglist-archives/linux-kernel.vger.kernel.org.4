Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FEA661555
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 14:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjAHNEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 08:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbjAHNEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 08:04:48 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8633DF83;
        Sun,  8 Jan 2023 05:04:47 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c17so8691350edj.13;
        Sun, 08 Jan 2023 05:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSsCe1/vYrCPdq2/qm0aU0QWLaInEUASjxbLN6gEMCs=;
        b=LyJWVkmkVQDracXJJR1Fnzi4JLU/adPerzQZNgCGezlTDDfY33AgCdT+6EkACT2wI/
         gI/6ciVPbG6LDcZvrK9EQwNkvV6SbzOKj3utJzad3cneej0JH7aHqB9gr4ghzZSNS49y
         y1ZMjiFHO7iiw14O0Go4NNvmJNxAjZBrtcVU020KlNsQGWmx9VELCzujvVjuxbpBmUN1
         Hh73QCrZ1+4Hf+NHQn4pCUtcEAEEcS7SCUbkBZn87zPcluoOkFCT2URY3vkidBWTrPXu
         0czzc3o/JVBCrfz9xfrSXJQaPEXwNRMhZ0PAaqr07QSWQZiobvF/CTaHSCQcq25rPQTU
         i8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSsCe1/vYrCPdq2/qm0aU0QWLaInEUASjxbLN6gEMCs=;
        b=JAqH9Hr1B7AI3mC/goZPotGe/nSyKBGpvsehq3iQoiKQx1D74BhW1jRdVjq+jYMAPH
         x4FEZfYu51Kjs7SXw6ip2PhkWF1xa6r4Gjs5lmzerCVuF6ZgcweRQFnzemAc29ilEaWM
         5rx/c/yTEZ/5sxYqC7aWESVIv/Ay9pJBOcFjgc78jUUNIsSfGRKrOe1Ke3mACaWZnfZs
         KsrJhIeprpDgJWiEzanYmGfXFsMLyhW5MWkKeEGf5p2aFiO9xiwOO4zhaLbnSh3ZDMA5
         0VQ1DFXSOllk5z/7ZS5gJi+TZ03CJNfRE2inzDnmh1vcrB9TzbStmG59QZZnQ429gG3R
         O+EA==
X-Gm-Message-State: AFqh2krQu16ajF7LGKjckR/NR436CyeWyFkkvLM7MtjHR2CPNSvWTKd4
        mS8zLi9jlwbHwzwAjQhAK9uZh7VPve64Ow==
X-Google-Smtp-Source: AMrXdXvIg7qVZS0BDw1oYpfXn7Aq8TDaG087Z9cth3zZXWQ1MOPSPsU0+XIGwVesdwYDFpsGYRZRvg==
X-Received: by 2002:aa7:cd49:0:b0:497:d8ea:d79c with SMTP id v9-20020aa7cd49000000b00497d8ead79cmr5259999edw.27.1673183086239;
        Sun, 08 Jan 2023 05:04:46 -0800 (PST)
Received: from fedora.. (cpezg-94-253-128-11-cbl.xnet.hr. [94.253.128.11])
        by smtp.googlemail.com with ESMTPSA id l10-20020aa7d94a000000b0048ebf8a5736sm2499285eds.21.2023.01.08.05.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 05:04:45 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/2] arm64: dts: qcom: ipq8074: correct USB3 QMP PHY-s clock output names
Date:   Sun,  8 Jan 2023 14:04:40 +0100
Message-Id: <20230108130440.670181-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230108130440.670181-1-robimarko@gmail.com>
References: <20230108130440.670181-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that clock-output-names for the USB3 QMP PHY-s where set without
actually checking what is the GCC clock driver expecting, so clock core
could never actually find the parents for usb0_pipe_clk_src and
usb1_pipe_clk_src clocks in the GCC driver.

So, correct the names to be what the driver expects so that parenting
works.

Before:
gcc_usb0_pipe_clk_src                0        0        0   125000000          0     0  50000         Y
gcc_usb1_pipe_clk_src                0        0        0   125000000          0     0  50000         Y

After:
 usb3phy_0_cc_pipe_clk                1        1        0   125000000          0     0  50000         Y
    usb0_pipe_clk_src                 1        1        0   125000000          0     0  50000         Y
       gcc_usb0_pipe_clk              1        1        0   125000000          0     0  50000         Y
 usb3phy_1_cc_pipe_clk                1        1        0   125000000          0     0  50000         Y
    usb1_pipe_clk_src                 1        1        0   125000000          0     0  50000         Y
       gcc_usb1_pipe_clk              1        1        0   125000000          0     0  50000         Y

Fixes: 5e09bc51d07b ("arm64: dts: ipq8074: enable USB support")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index a0f7460020c2..3d1fccdf37c7 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -263,7 +263,7 @@ usb1_ssphy: phy@58200 {
 				#clock-cells = <0>;
 				clocks = <&gcc GCC_USB1_PIPE_CLK>;
 				clock-names = "pipe0";
-				clock-output-names = "gcc_usb1_pipe_clk_src";
+				clock-output-names = "usb3phy_1_cc_pipe_clk";
 			};
 		};
 
@@ -306,7 +306,7 @@ usb0_ssphy: phy@78200 {
 				#clock-cells = <0>;
 				clocks = <&gcc GCC_USB0_PIPE_CLK>;
 				clock-names = "pipe0";
-				clock-output-names = "gcc_usb0_pipe_clk_src";
+				clock-output-names = "usb3phy_0_cc_pipe_clk";
 			};
 		};
 
-- 
2.39.0

