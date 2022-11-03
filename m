Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4B0617745
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiKCHKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiKCHKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:10:10 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04321006B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 00:10:08 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b185so831496pfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 00:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFJpBjb6QP5w8jom1mD9aX3bwJzFPKeDTupRGJObZls=;
        b=UDVMH3hseinsmZ/5eokoX7zXybLKWNJ4j4JXaTJxc2oysEHWNIOh0GAfaeUtRymNdb
         PhFGcFHbg2Shm1sjCS8j3+nyLcw2nG4gUBCYolwhVxLtOupGJmmyTvzHix1iS+I876gb
         p+iaaRufs3P6aZA6zzAUy95Jr7ln8jPbv4LSX9RP8ZII5GXxTaP+pAyXLYicPoy+4Wsk
         AlIuzu99Qv6PlHIURb+uEZy9i/3u/+Yj5S+gXEdFJhfVqB3Xdvlb2K++eESGhK9FiNIa
         GYAU1uE/4l2gydnPSgCL/uFy4xsIvAlyNhQyXA2Wtn2/TRmLG4KTPX2WdsSDY7Jadxyl
         Z+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFJpBjb6QP5w8jom1mD9aX3bwJzFPKeDTupRGJObZls=;
        b=19rSHzE2UfZ28SQ8gWJUkp0VHar3nDtOaT9Cgf8QlAWixPcPDU2QtDCnmX+TvtB7r+
         QSi8B55B7EtedCKgu7la05Ly7U2eKlftGR68mYq/nedx75xVmBrPMBo7KAwH7H46b2wZ
         YNiasJUh2xbPupnE3IaXdIldOBie4F5pkqN5mbYTfwaLImeBc+E+DXiZU7F/PBEHhoF3
         OV3WpBAAJjZ/K4SuGidCekJeTuotH+JueDOp25zX0nnhxkf+VxHigbs894lgVTsgDWYg
         i2GBid663WfQXTVMz6EqdHPGhipIDTXDxImGlUWdLsSsyqfC6l3dgxkUC6k5FJ+tQ5uF
         1AmA==
X-Gm-Message-State: ACrzQf37ipKS0Tk7f6yV/cioIvUdDc3BwMPiDAFxIRD37B+xDMNNpCRH
        Pc9Qn8dGH2i6TqbzfsMtwmID
X-Google-Smtp-Source: AMsMyM6iiObOsWJMJK9MuUxyP+cAg9bjkkTqruFArtt7Gmmd/coTKc7heUxnbM2RVLKJz97SzGt92g==
X-Received: by 2002:a63:cc:0:b0:463:6cb7:4f5d with SMTP id 195-20020a6300cc000000b004636cb74f5dmr24593969pga.489.1667459408606;
        Thu, 03 Nov 2022 00:10:08 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.64])
        by smtp.gmail.com with ESMTPSA id s9-20020a170903214900b00186748fe6ccsm9451244ple.214.2022.11.03.00.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 00:10:07 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 07/12] arm64: dts: qcom: sc8280xp-x13s: Enable PMK8280 RESIN input
Date:   Thu,  3 Nov 2022 12:39:06 +0530
Message-Id: <20221103070911.20019-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103070911.20019-1-manivannan.sadhasivam@linaro.org>
References: <20221103070911.20019-1-manivannan.sadhasivam@linaro.org>
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

Enable resetting the PMK8280 through RESIN block in SC8280XP X13s.

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index b2b744bb8a53..6aa8cf6d9776 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -169,6 +169,10 @@ &pmk8280_pon_pwrkey {
 	status = "okay";
 };
 
+&pmk8280_pon_resin {
+	status = "okay";
+};
+
 &qup0 {
 	status = "okay";
 };
-- 
2.25.1

