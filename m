Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604336C8D73
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 12:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjCYL3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 07:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjCYL3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 07:29:16 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578B112862;
        Sat, 25 Mar 2023 04:29:04 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y20so5418512lfj.2;
        Sat, 25 Mar 2023 04:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679743742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybH5MmJH8SEpMVxdPkHcz9qeJYxFxp9Si4fjLNySVz4=;
        b=e4bhS2MNPPaxZ+gOkVSWjISSLuT9vdGBX3ASlFA9eWXEOJONvYTSJc5A1RNnz4Ucnh
         pp++W5XGLStcH3jlGYkjMvR3h+U1330IrCbxGibQZQf+8ULAVQMhvdOzROIn0PSaDvGb
         +hMN9gK/h5O+sTLXprnVzTF46wfUu2ZMy8DeSUCXDiAmsPSZwTWE03dzulwJv8bMP5dA
         nrr07oGqgnL3iLqM7sQe1zHjw6NgplP0XJfvtu3qNl/pNmXxGFbrSXCRTaHSgpW5K9xS
         ptuItdXSc9dT+uvNh7J5Ou0GY/qSfEHFdPDIOecj2OSHwG/UASABzpzUSieahnlSWibX
         j7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679743742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybH5MmJH8SEpMVxdPkHcz9qeJYxFxp9Si4fjLNySVz4=;
        b=ij/YQaptxpfdBEo9gGxwO1uUjTT/Kwd39stS9wV3zHJsYh+C0gLx9o6g8JRun7onJK
         cXSBZaKxJJGTv9OX2LOk9I1xFu5bmvoKDgX58DR6dGMsirKkdqk6Y864K5UM+Us/lXT0
         8doUQc9Bn6Qxzy1f6FqYFFrUdvYFuZmrzVAJRThw8xZCVBMD9UXlV6BqsnKQ+KFXuFXQ
         P8flUKX5QGlpyFNUJrTXMlGzK3H1mxV/o44vuAh2OgHaltu99XEoetmCMplUDLx6DtEi
         KrJrDglCl43hhw79CPBWFlyPnOiKY/CPAURj1wgLM9z1Dk5c+hrfB8jsaEXg4LhuOEuO
         XCqQ==
X-Gm-Message-State: AAQBX9cwZjHN1SnRrnqwqG882OzFKGJD8JUsu1zhuyZO76pTX/iPTlSk
        0+QviNYstdBch8nC3g89fJ01so9bysxCCQ==
X-Google-Smtp-Source: AKy350ZQM7LhtZUypMbWYPj4Mbe/WHfriKtSP6gN3WlTuJclJolM9dYoT4FoGsEmaP+PgQFNCH41zQ==
X-Received: by 2002:ac2:4c11:0:b0:4dc:65c0:c74e with SMTP id t17-20020ac24c11000000b004dc65c0c74emr1452103lfq.29.1679743742780;
        Sat, 25 Mar 2023 04:29:02 -0700 (PDT)
Received: from localhost.localdomain (cdb25.neoplus.adsl.tpnet.pl. [83.30.151.25])
        by smtp.gmail.com with ESMTPSA id m30-20020ac24ade000000b004eaf55936eesm1502510lfp.233.2023.03.25.04.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 04:29:02 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: msm8953: Drop unsupported dwc3 flag
Date:   Sat, 25 Mar 2023 12:28:51 +0100
Message-Id: <20230325112852.18841-3-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230325112852.18841-1-a39.skl@gmail.com>
References: <20230325112852.18841-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Property phy_mode according to binding checker does not exist,
drop it.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 5dd10c35ee0d..0a1bf1058cbf 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -977,7 +977,6 @@ usb3_dwc3: usb@7000000 {
 				snps,hird-threshold = /bits/ 8 <0x00>;
 
 				maximum-speed = "high-speed";
-				phy_mode = "utmi";
 			};
 		};
 
-- 
2.25.1

