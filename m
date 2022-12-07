Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D9D645BE0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLGOBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiLGOAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:00:44 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B32E5CD32
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 06:00:33 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so1511297pjs.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 06:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfunYPN7pQzIq/aXuuYsh9BqM9fjFphrjnxLDwW5HDM=;
        b=P/D+hvsSzs5/Z2g+hUwoSTGiCaJQRcrqbPrEN3djw3epYnLFlbXktZajYPahX5bTnY
         Ro130UAGILR62rxsSXDZ7b5kM6S6yvNxWGoq6LVWl79Cajn0bPQT8OKkjger2zTNuBdS
         k0FP8H1x1NWDJIX+j2/Biaw23GI/3/Z5n3tGFa6Ukd3rUkE8MuO8K6pin/D18dIXOuxo
         jc28OHhgT2kWkqoZaoSe0TbvkPulj4hBNI7Vwmuks4Bn5Psj/0oIWEUx/Vf0iCkiKRUP
         bSDza/ogKT+CSehmv3ULvp/XU5wOSlCTAYvUxvXzUg+IC8mMa88hlA8wg5d2pdRPwa+K
         nsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfunYPN7pQzIq/aXuuYsh9BqM9fjFphrjnxLDwW5HDM=;
        b=5ROpAk1h2P6eR1pNxFpnuYZrhrpCIIaz8NZD5h7DJwLb4lwY2+To9Zxj8NDoQ3o2mO
         BlTEK4uViwfHm0wNbqrhk5iD1P/ANrYgWLITFU/j89yESh81LXvx71hvcRiyOkqZz2mE
         d9klbYc+D7l/rv/P1CiBcNjbM/dMoOXtvFFCEP8YQm8ejXbDMe8HeSqj0WIAvoyrBmXj
         p/OdKej2KwOMAehuZXPbrmObA5p7O0vPk8VZwX24oOQaElv1Qv6OdGcKKL0nu4Y/u4yZ
         3zCnkxUpSW6Bwy5JgwNxrRKHmB0GMyfY/9Ka1Qj15pr8i5229RQUHHPTpqularNVtVBQ
         UxfA==
X-Gm-Message-State: ANoB5pmZunRfmqDi2/l0BtGFfN2bA6dSgjOOjod4rhLx4ZNuw8qZ4iLe
        KJ1TRun6QKdplbP5QGSj//xo
X-Google-Smtp-Source: AA0mqf6e6lJbaOA8uQds3om0jADfzRMHAvMsP7NLMRU5y1QZh9n7PUcvTRC/GPic/srqltROqfBZrA==
X-Received: by 2002:a17:902:ed94:b0:189:66dc:4af4 with SMTP id e20-20020a170902ed9400b0018966dc4af4mr59310310plj.149.1670421632460;
        Wed, 07 Dec 2022 06:00:32 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.5])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902d49200b00186b69157ecsm14720160plg.202.2022.12.07.06.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:00:31 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 09/12] arm64: dts: qcom: sm8350: Fix the base addresses of LLCC banks
Date:   Wed,  7 Dec 2022 19:29:18 +0530
Message-Id: <20221207135922.314827-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207135922.314827-1-manivannan.sadhasivam@linaro.org>
References: <20221207135922.314827-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LLCC block has several banks each with a different base address
and holes in between. So it is not a correct approach to cover these
banks with a single offset/size. Instead, the individual bank's base
address needs to be specified in devicetree with the exact size.

Cc: <stable@vger.kernel.org> # 5.17
Fixes: 9ac8999e8d6c ("arm64: dts: qcom: sm8350: Add LLCC node")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 245dce24ec59..836732d16635 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2513,8 +2513,11 @@ gem_noc: interconnect@9100000 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sm8350-llcc";
-			reg = <0 0x09200000 0 0x1d0000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x09200000 0 0x58000>, <0 0x09280000 0 0x58000>,
+			      <0 0x09300000 0 0x58000>, <0 0x09380000 0 0x58000>,
+			      <0 0x09600000 0 0x58000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc_broadcast_base";
 		};
 
 		usb_1: usb@a6f8800 {
-- 
2.25.1

