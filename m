Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF6F6EA7B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjDUJ5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjDUJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:57:44 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B04AD0B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:57:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5055141a8fdso2062406a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682071060; x=1684663060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ll096wS+rMglwJUqHd7/WviOAK7D+NwskZNxj/VNilE=;
        b=x7/VlZitTyclDzd4sI/XDO8hgRJmkhaUmI9qAJFg/WWdopJe/xPdFJtXHOWMBmHchF
         SG7gMPPK3FCjaV+WIkN20GtRm1fo4/IXGT0W36JTywqUu7upngxjS16nlKRnDzkUlVRu
         /hMEm9VpDBY9mSTq8fNB/Ea3yz5MS0YXEnr0ckIffzwD7SqxCJMjY/SG5HTNpnVw/zGj
         u3oW9vGYwe6dNesRbHa8w1anFUjvNL27Z+nRJwnhFHyAiUgqmKQAvpyRlaFSOt4QN5mm
         6kVTvkrnQk523qfuauWKWHvh8ZxQZzOLKTIlbFTF9Wzh7c/Q5asD+s44mwrPYuAbkwTC
         JxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682071060; x=1684663060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ll096wS+rMglwJUqHd7/WviOAK7D+NwskZNxj/VNilE=;
        b=bT6fAKIgI23uTaWh6PVnQkMgdrf8wWgeSQxqHNZSBmHkaKskbRY+pXIoctjOgDnZan
         ZYqw+CudfnBPB4NGGI/gTHxcTpFe1LbGTqZedNTqNRknwVIAh7GKWtCZqU200JqY8n3J
         /3TkLz/P2dY7aImtygkAFzqiQXSwNZv99xsRkv85WLcM8a0igrzDj4qxA56E/V2M3apc
         GR6eXl/Txd30V+2KBo3/NNxXDvX3eft2sbgPfttG+4M3/zzHN5D5kIxGxLSyXZbA6j+H
         cUPVMB9tfDq+TDoV5m92lVu4djJQguXACCwL4BjYLavYRgXXGov93TA1KkHvQjTSoZ9P
         DhcQ==
X-Gm-Message-State: AAQBX9dPn6QAEHaLKx4t7t/xPCkNDdXvhvVQlrvvm4WvDm55jW5jbRkC
        dydii203BNvs6L6j5lTlHXMGkA==
X-Google-Smtp-Source: AKy350Ze8DH2vV1SQhJHC1mCp9M5Zia3JaHxu3ktakvGrCE/pUS0tx+VxY0PsWOLP6ct7di+QhLOAw==
X-Received: by 2002:aa7:d683:0:b0:506:be43:e1ae with SMTP id d3-20020aa7d683000000b00506be43e1aemr4163022edr.34.1682071060070;
        Fri, 21 Apr 2023 02:57:40 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:668b:1e57:3caa:4d06])
        by smtp.gmail.com with ESMTPSA id f7-20020a05640214c700b004fa380a14e7sm1686062edx.77.2023.04.21.02.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:57:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Pawel Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] ARM: dts: s5pv210: add dummy 5V regulator for backlight on SMDKv210
Date:   Fri, 21 Apr 2023 11:57:21 +0200
Message-Id: <20230421095721.31857-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230421095721.31857-1-krzysztof.kozlowski@linaro.org>
References: <20230421095721.31857-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Backlight is supplied by DC5V regulator.  The DTS has no PMIC node, so
just add a regulator-fixed to solve it and fix dtbs_check warning:

  s5pv210-smdkv210.dtb: backlight: 'power-supply' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/s5pv210-smdkv210.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-smdkv210.dts b/arch/arm/boot/dts/s5pv210-smdkv210.dts
index fbae768d65e2..6e26c67e0a26 100644
--- a/arch/arm/boot/dts/s5pv210-smdkv210.dts
+++ b/arch/arm/boot/dts/s5pv210-smdkv210.dts
@@ -55,6 +55,14 @@ backlight {
 		default-brightness-level = <6>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm3_out>;
+		power-supply = <&dc5v_reg>;
+	};
+
+	dc5v_reg: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "DC5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
 	};
 };
 
-- 
2.34.1

