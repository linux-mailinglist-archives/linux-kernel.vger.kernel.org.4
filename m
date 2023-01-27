Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DBD67E2EF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjA0LSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjA0LRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:17:54 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308F826AD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:49 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so5167873wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJ+Rhyub7QdZQCx+PBV6POAj+tkBwCFqMXV8WoFTj5c=;
        b=Xo1CBygkgpHH/tFpj6j9kDXLuhq5A62Kw4X382lY5a0voNm7I70yrWARWKgfTYaSen
         /u8E+UxVTnjROQ2Xt+vzmmDv+q2RfSn5vjTcb0zYYad6E3NHPuPLYxmxc+5HB89uY4n5
         dv2tGgTHCpLOHms1png8qrbAhuDBSlTIxAHus4LPbYw7qYHPQK05L6g8FaU/3gkKUiRK
         kUtGMcFgnNurNB3zhupRa4gK+zgQHzHSfXQzEwOrELIQ9FtnIm7/WrcA7f4DTIQsG4ee
         4yjvBX7l9MfPAjnMDiWA/xbIrHoDbcLnWQ0A8I8tj1uy11fnb2cerK8pdoGJZGgeRNCZ
         KcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJ+Rhyub7QdZQCx+PBV6POAj+tkBwCFqMXV8WoFTj5c=;
        b=J9G7fQLPiw1ToIolQKii7c+JxNnHNm0XIK29bT5lMF+qXcZoWsQo3W+9dtok5Z0SCX
         1newqvoV7Otnyq+/OGABbymEYQa4KH4rC43DhTRHSO4mLBg+I/idvdCccwSRCyfHqViI
         sBiSqsqvBnls5XTajSvff1/qfybjEBBYOMyxDID3QJjvtNmzU4ndMoTadmnDN1poMuaa
         V/IEypyCQYddtaYj98VpJQg11849PhM9nJjP6DpeRDSNMEA79OHFmz2YkTugLrbLGtDY
         CvICJo6pSK00/zdk/BTiaQrJ4Z9TnatPYi6YN9ZrE+jjJ5qmhR38NpNkN74ke1JtkeM8
         IHlQ==
X-Gm-Message-State: AFqh2krZZjS5mMEwV0Yln+PH169hPJ4KIy964lG5UWK8lvcqYMA2Bl7u
        fJH2R0GyvRPNfjumUfD0ka/E9Q==
X-Google-Smtp-Source: AMrXdXs5hoz3LN8AV2WP8uQa1Q0FSeoiyd6UjOw0yoktx94Xvj1VmKahJrQehGLQr3aJvhvo4r7ukg==
X-Received: by 2002:a05:600c:1713:b0:3da:fd90:19dd with SMTP id c19-20020a05600c171300b003dafd9019ddmr38975229wmn.26.1674818267879;
        Fri, 27 Jan 2023 03:17:47 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:17:47 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/37] dt-bindings: nvmem: Add compatible for SM8150
Date:   Fri, 27 Jan 2023 11:15:33 +0000
Message-Id: <20230127111605.25958-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

Docuemnt the QFPROM on SM8150.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index b7811bbb0e71..a248033026b1 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -31,6 +31,7 @@ properties:
           - qcom,sdm670-qfprom
           - qcom,sdm845-qfprom
           - qcom,sm6115-qfprom
+          - qcom,sm8150-qfprom
       - const: qcom,qfprom
 
   reg:
-- 
2.25.1

