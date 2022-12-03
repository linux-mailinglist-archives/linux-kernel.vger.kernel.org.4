Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0579F6417C3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 17:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiLCQV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 11:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiLCQVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 11:21:54 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD508205E7
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 08:21:52 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so11990134lfv.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 08:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzcwhdiyD/Q33ZvF0rEIEBBj6MaYk3GPfXyKlwUxX/8=;
        b=IA251Nt6Xcc3Xc4GjmQAov6Ml+2Bevcx+RocH3fpU9Hc1HwqvbvWGSwM4NaeN2NIOO
         HkchpiBL0CboifjCr6JaQVtDL5rwQ1mVMPMMTiafYFiWo+slUOFsNvR/Ggr3gg0TJlWH
         FiIAHEwcCs4yfXSinTqYCPn5s8kGNU5mW/3qQSEeiEzOWwMjyEuQP3O8ut43FkgF/69k
         aq0mtB+j0rSKJ63BsGJcI1YziuGVyjQfQmDdBCvstsCMccefgsBEVU4LW4LcFkSonOY3
         3gp6nLo74h2xaMJLyFmN6gfuEozh9ox+jGl1uBRKbtBWwzh76Y5R5gyUVNLqQ7Ov4CPD
         dFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzcwhdiyD/Q33ZvF0rEIEBBj6MaYk3GPfXyKlwUxX/8=;
        b=lG186jrobZlbTj/cEIlgyFiWlD5e9DXXHo3oTdw97Qvo4lMcL4C8u+kGWKGPqHjPHK
         U4ALRK/oy8EyS+q65jcdGeaKsM1Zm7GvqDrVSb2u6kmVgNhsijYHZwfvVZ3u2ZsGx7Zu
         VHKFZO5q+cz0KizahKKjlx6+xFrwR2FsQaqszymM2pyypirR6jN0YykXrjA0AyJUXUhE
         JqA0D58inOk/FO1udFI+busuCato0EJBXeFveVPMbYjnH9sACpo5O3tjzsxlOoFUNhag
         Yy5oPV/IV5wkooPLTAznE8CYXHDiiArIWXByB6jlAN4zK9RsIR3WLVJRwgiZ5TO/lu1/
         YuZA==
X-Gm-Message-State: ANoB5pke/g5BAsWCIHETb8AGcFwDir+HrBFa1NAKPQeVQXlw9Ma9y1yA
        QH1lDsGcjHRnvQ6e6y5FSa2MDGvMkPUA1by86vk=
X-Google-Smtp-Source: AA0mqf7Lwc3YeYZdxgkprTOWEMJC8O1f+aQqo4H1mCRSujMIbT1nT2tPvuzpVfJNT7y3N6zhlEsTxQ==
X-Received: by 2002:a05:6512:3e13:b0:4b5:3f5f:da27 with SMTP id i19-20020a0565123e1300b004b53f5fda27mr4089537lfv.666.1670084511051;
        Sat, 03 Dec 2022 08:21:51 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bi35-20020a0565120ea300b004ac6a444b26sm1443935lfb.141.2022.12.03.08.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 08:21:50 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ASoC: dt-bindings: Correct Alexandre Belloni email
Date:   Sat,  3 Dec 2022 17:21:44 +0100
Message-Id: <20221203162144.99225-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221203162144.99225-1-krzysztof.kozlowski@linaro.org>
References: <20221203162144.99225-1-krzysztof.kozlowski@linaro.org>
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

Correct domain name in Alexandre Belloni's email address.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/adi,adau1372.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/adi,adau1372.yaml b/Documentation/devicetree/bindings/sound/adi,adau1372.yaml
index f1ba70723e6a..044bcd370d49 100644
--- a/Documentation/devicetree/bindings/sound/adi,adau1372.yaml
+++ b/Documentation/devicetree/bindings/sound/adi,adau1372.yaml
@@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Analog Devices ADAU1372 CODEC
 
 maintainers:
-  - Alexandre Belloni <alexandre.belloni@bootlin.om>
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
 
 description: |
   Analog Devices ADAU1372 four inputs and two outputs codec.
-- 
2.34.1

