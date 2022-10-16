Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B83F6002A7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 20:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiJPSE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 14:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJPSEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 14:04:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AC82F033
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 11:04:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bk15so15104711wrb.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 11:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Flxbi0Mv/YCPndR4M73folsyura1ac1CobzaAOFvbE=;
        b=eMAMAejyEepxo0zGBOp3pYvkSFHo/wpqFSxmmN1J2Dqmc3uaKsX2CZp7i+bkvVmqpc
         rJt9+/kHeCQN7Zvd1aBsgLDJiZxJ8oXNJmhlMhNz5gNCXS0x/11NFTpkv0ibw9WJJ+fE
         HREMmYpI7/UX1l0cZi2w2DPcBQabaHaxOw3v+zzdoEi6holkSrxBwES0NNDCyKpPa8Bw
         bLAQEsZjYY6iQgsS2P53qjRohXwVe95tx7eDZmXcSkfXMZ2Uk252JuHbepgtQ7g19UQl
         2dMolbtFkC8txbrCATN52YRPPzUCitpYfnHvRjXUrJqKLIt7yxDSE8NpQF0bV+ph/r9K
         a0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Flxbi0Mv/YCPndR4M73folsyura1ac1CobzaAOFvbE=;
        b=gRhvlXGArmVizEzhT4zcNrzxexNgVFdUaGxX8J/KofZtJewsZk4eZigtIxKf+ifzej
         qMqCZ51G0eArgHW1avznAq2feKzAKreNkqB0wI+QqlBBwi+qkila1Ms0JHmcw5bNlcnj
         oFajFM9Nl3Jg7Wb1FmSFndRRk+hdZDmuVOaKnJ81Hsa+Xpt0Iy6abkZXIZdz8cMLdLl2
         1c/1DLi8MT3vHfpItv65XP0pwLpIFbxOPIYjyXGWHVeerM/gQWD30uWxSk57GwdWLPYU
         DOAz01Fnc5QNlNgui1cvLeAr+vqv4Kxqr9oqaSTV0owWLyhpnMIXAginbK0hb0lJFJVs
         8LXA==
X-Gm-Message-State: ACrzQf1cB05lJeIOUNJdgqcQ8mu9sljraytIwovLg+X2G6xnxLceLJrf
        D+IYUDh5eRqPS8FSCVkVQyahr1IrkZQ5TQ==
X-Google-Smtp-Source: AMsMyM4NYjLvqnwPjNljY+u6D1BLxbFqv904f0MZpPvsn0bVKmnho/ejGJINmlVnpzzXlOf0Pu9+nQ==
X-Received: by 2002:adf:d1c4:0:b0:230:7771:f618 with SMTP id b4-20020adfd1c4000000b002307771f618mr3872247wrd.203.1665943449596;
        Sun, 16 Oct 2022 11:04:09 -0700 (PDT)
Received: from localhost.localdomain (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net. [86.14.22.118])
        by smtp.gmail.com with ESMTPSA id k5-20020a5d6d45000000b0022e57e66824sm7844181wri.99.2022.10.16.11.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 11:04:09 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org
Cc:     Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/5] arm64: dts: qcom: sdm845-oneplus: enable rradc
Date:   Sun, 16 Oct 2022 19:03:26 +0100
Message-Id: <20221016180330.1912214-3-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221016180330.1912214-1-caleb.connolly@linaro.org>
References: <20221016180330.1912214-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the RRADC for the OnePlus 6.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 392461c29e76..be9db844e5a1 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -461,6 +461,10 @@ pinconf {
 	};
 };
 
+&pmi8998_rradc {
+	status = "okay";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
-- 
2.38.0

