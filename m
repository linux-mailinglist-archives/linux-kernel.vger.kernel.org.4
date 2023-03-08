Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0352B6B079B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjCHM7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjCHM7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:59:16 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C29E746E6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:59:15 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ec29so34509810edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678280353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Is03OJ4mQJUe1cHowCP0OZJPLl5QGT88Km2eA43ho8o=;
        b=qj/VUygnuQqRd2/7da6w2SacNPIFTRbk7kM3kX/xqwllAL0SfUDThk1BURnWZkw96C
         96tFtvsTjFcavykwP7Uc0v/YgXQw2CL7HDTqZbQ7IVwu6p2yCjWfdbV/6Pr9Ky/GVgz/
         BLNEjZ4BamCPiBgjRw8Q8yV0MQv2sd3DM03rQNzc/YI4eF64w2z9pWNAqyllDa1mca5e
         OP3A2t9SQsMjilV67gwBWN9s7o+opGkJ9tvcg5ZYrizp8CHcBhC0NanJsdGd0jIS2zrp
         TvRbgP9ZXQ1oHb/kVs7pKbBFx+Gf9upU//tKg1y7pJLdMfovhwcoXxOFc5Y84sYD1Iyv
         jQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678280353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Is03OJ4mQJUe1cHowCP0OZJPLl5QGT88Km2eA43ho8o=;
        b=Z0E9LxwK6/xIsls0QuCxNnBQ/nBQFuqKtSQyHSMxMP+0qVW6mdINt0OPwpPmXzvy9a
         leUrQHxo1mGIDR8oHxG2hsB+VgnDCb66HnWat+xIBIDnBWuUA5iLpuHcSx0jxFMQxD3k
         FH+bWf4mUnNnzlsw1WuJjR6e1TNeKOnes3k0OPGNqsqHBu5ZusM+9E79OgxYLhUU208n
         XFErx3D/Ffwl9FRsv66poW5CyGsZmIj5fXd9+/p2LfI1tnmGFIkpovIbX5gC9J2EPi46
         H9v+VE7FXn2EjAAddOMuZyX6ZEPYTsvrRZqjbmnFSwArEkusbflikPQ3uZyX7BH3CmKu
         waPQ==
X-Gm-Message-State: AO0yUKWpjkyveeixaXE71HneY+Wf7SaQPeQVtinxlJjPUvjnqenmf7sj
        Ygi7og/6wV81KaTrxEWz2JO1DQ==
X-Google-Smtp-Source: AK7set+IabKSS8d13E0Wa0MBP0JkFXhqz2tmIVYpv3jg2bayZ+iBAGl8eGlLsO4zj9kJQ/x99rkkeA==
X-Received: by 2002:a17:906:4bcd:b0:8b1:812f:2578 with SMTP id x13-20020a1709064bcd00b008b1812f2578mr15564387ejv.45.1678280353722;
        Wed, 08 Mar 2023 04:59:13 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709063b5900b008d0dbf15b8bsm7464141ejf.212.2023.03.08.04.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 04:59:13 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 05/11] arm64: dts: qcom: apq8096-db820c: drop SPI label
Date:   Wed,  8 Mar 2023 13:59:00 +0100
Message-Id: <20230308125906.236885-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308125906.236885-1-krzysztof.kozlowski@linaro.org>
References: <20230308125906.236885-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPI controller nodes do not use/allow label property:

  apq8096-db820c.dtb: spi@7575000: Unevaluated properties are not allowed ('label' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. None
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 9ffa0e66e276..5ceaab5d4039 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -146,7 +146,6 @@ &blsp1_i2c3 {
 
 &blsp1_spi1 {
 	/* On Low speed expansion */
-	label = "LS-SPI0";
 	status = "okay";
 };
 
@@ -183,7 +182,6 @@ &blsp2_i2c1 {
 
 &blsp2_spi6 {
 	/* On High speed expansion */
-	label = "HS-SPI1";
 	status = "okay";
 };
 
-- 
2.34.1

