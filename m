Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331C8675B81
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjATRbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjATRb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:31:29 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7519AED90
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:31:21 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j17so4679642wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JC33nkvOY9jllaeQeA877nEGh7EFhyBhoHxhC9ikSio=;
        b=ePFzI6jF5QJfJDiWdbL4WzhmMgUAt+JzcDfbRdufvGnU/DvyJmt7dMOrh5jA/ZkWoX
         VP3zy8a3qde3XULU1uFg+1j8ClQUg3vjJbJo1xg5ZPUPDZ5ZRaNcHpnf4qk0QjO2JIQA
         acgVvEPOc5F55b9w0P/U6i5kGEvn+tMJpQ1d2hibDs3kbSA7voRyZDNurnrxjJmxT7RV
         3gCS73wGfB15htucGR9S7LfN3ujDqGGPKf2am/nAlMA73j3ttTVhgfTh+lMLpW4+hSJB
         fkjKF1R9Na1RQyoKeZtpowx4GSL1/YocBcAjYK6VpfjfnK+TuHM+S8CyKlf7cP9GmgFg
         F1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JC33nkvOY9jllaeQeA877nEGh7EFhyBhoHxhC9ikSio=;
        b=qo3pUYsv5RZ1QSnmKd6Na8bDqrjh0Wo5rON7cAGbXVzye15xJ6SCx9LIlLGyBOyq0e
         /FPVJ5ujEArDmKKLakuVq2UJrMvfCskxWSBE4lKL9DeGZd7LCEzZMzQY1mZduHu0CWWM
         GK9m4l/766bwR6FONmzhXV4oQ3niP20L8cIQszqbfebU5tP5Si3YdJmJ/oUGrWwVxFND
         M7y15rHFDOskcerJLxQyv9xb6Q9dHcpMy2mjttdD5NJOdF07YdEkiIZneuFzgBg+CZj7
         3aprBa+uEIn8fOf4fD6t982GV4bcTJu45sa3UPKgeAw0bGkttvKAKUctTnDs5ZWGvY6u
         6b1g==
X-Gm-Message-State: AFqh2kqx/F2nuym+e6GK2gxLLADUvRlqbd7fO2PpXTcUPqcpLPmKEbpN
        LBK7a/TVlzv81YHIYD2oo2cC3jyK5DzmcXZg
X-Google-Smtp-Source: AMrXdXui6w/iZmq/RJsnFzJp4F10SPSRvGEMGIQD0vSmX0FFM6XWOuOB2bpLwJVxRaXvIks+RBfaoA==
X-Received: by 2002:a05:600c:d3:b0:3da:23a4:627e with SMTP id u19-20020a05600c00d300b003da23a4627emr14507270wmm.6.1674235880481;
        Fri, 20 Jan 2023 09:31:20 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d22-20020a1c7316000000b003db0dbbea53sm2819179wmb.30.2023.01.20.09.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:31:19 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/6] arm64: dts: exynos: disable non-working GPU on Exynos7 Espresso
Date:   Fri, 20 Jan 2023 18:31:11 +0100
Message-Id: <20230120173116.341270-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The Panfrost GPU drivers require clock but such was not provided in
Exynos7 DTSI.  The CMU_G3D clock controller was not upstreamed, thus
consider GPU as non-working and simply disable it to silence warnings
like:

  exynos7-espresso.dtb: gpu@14ac0000: 'clocks' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This patchset fixes remaining Exynos/Tesla ARMv8 dtbs_check warnings. No
more excuses for not running dtbs_check on new patches.
---
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index b846c0be90e3..829657c9c7ca 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -61,7 +61,6 @@ &fin_pll {
 
 &gpu {
 	mali-supply = <&buck6_reg>;
-	status = "okay";
 };
 
 &serial_2 {
-- 
2.34.1

