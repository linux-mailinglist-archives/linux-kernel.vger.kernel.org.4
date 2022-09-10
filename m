Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFE35B46B9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 16:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiIJOc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 10:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIJOcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 10:32:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4572F3E744;
        Sat, 10 Sep 2022 07:32:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso3787425wmb.0;
        Sat, 10 Sep 2022 07:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=d90cBTaHglfa/L3UmwiIFS49uaF4cnaVMbMrPZWt4mU=;
        b=Pf3ZbWZmoSp4b0PiB79zmttmwY9GZvfsiJD3qnijs/pKOwcaphMcEYwE6XTyROjahc
         1jI/fC4wLyb/R29fUi+aDfz42+dtctP0u/d91HRMR5WNsqX1a7L4NzkUrPVmWxdwqY5s
         1osNMOBycjchzchvJtcIfsvNWJR9zKF2FJ0uL8fIX1qYEvM3ws+dsg4llR7+f9Jj0cfd
         xknrOClKnSK9og0/UvshNu0I7H23ppzxZbl1dugVvXBVpxILv9dLKcrRoDa8wY6gwBjM
         zY68XEpGZwsy1dZ/1xyY+VRvNLrGbj3fVNXqe7Zk6wDsZH9/xz58wKsBzgyFT4pR4oU8
         Pd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=d90cBTaHglfa/L3UmwiIFS49uaF4cnaVMbMrPZWt4mU=;
        b=hrovr5gRwDK3gW/K77fyzA3q7gkrHkU2m0VH5S7WzYtapuy8Ti1KJEk2huMyiuBGp4
         ynCg5jpj6N9m4CvzkGuIIH8i75CibvgiWKNFjFz3wfh2ACE4mYxaS/paTOPZSNaz1Ls9
         vmNOMD7rDjrPJxeppceNyD7ZOqb5t8grj3z7zaW6eHT0NPaIEg3Zn8bV/dSTtz2iq9/5
         GLQZoX2wwBEMhFZEaxCXnlXLr1hmiRKQ5TjlWLhTddCtS8SXWNQL0aFFPUBZpmtO03YL
         FP3GQctkQF20pZH2YLjiYxdJ7n+AgC9xC5tZQK6AVrSAp2LQE8lslyqpCMXvFvtpMV0L
         nyuA==
X-Gm-Message-State: ACgBeo2Tg19nVImfVewIqJ4RdjGXEDdxQo8cUqFN1NTHhQtUHubLub21
        lzOEFCarMvorrgkmHh6Flm4=
X-Google-Smtp-Source: AA6agR40CTeHcj4T2kdwHf56nx59EEdZlChShjSJbJs4mODAIpLM9Z/mme3lCEAK8yn+qnvk43ohBw==
X-Received: by 2002:a05:600c:228c:b0:3a8:3d5d:5729 with SMTP id 12-20020a05600c228c00b003a83d5d5729mr8458272wmf.144.1662820338630;
        Sat, 10 Sep 2022 07:32:18 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id bg14-20020a05600c3c8e00b003a840690609sm5280319wmb.36.2022.09.10.07.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 07:32:18 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/9] dt-bindings: arm: cpus: Add kryo240 compatible
Date:   Sat, 10 Sep 2022 17:32:06 +0300
Message-Id: <20220910143213.477261-3-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220910143213.477261-1-iskren.chernev@gmail.com>
References: <20220910143213.477261-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kryo240 is found in SM4250, the slower sibling of the SM6115.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index a07c5bac7c46..5c13b73e4d57 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -174,6 +174,7 @@ properties:
       - nvidia,tegra194-carmel
       - qcom,krait
       - qcom,kryo
+      - qcom,kryo240
       - qcom,kryo250
       - qcom,kryo260
       - qcom,kryo280
-- 
2.37.2

