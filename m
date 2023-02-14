Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF7B696953
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjBNQX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjBNQXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:23:46 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3142B086
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:23:33 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id eq11so18178700edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTPqrWxhude+tFhrp4bP7IHAfI/NrAfRFzJAxS+VITU=;
        b=hcPRMw8MYprk1cQvIQBqgMdDPff/6FtYOAOwhjljD3kog2cOhnIkh/alkvM1Qvu4RG
         XCJkS7XxzRqxg0fD9fsAtDvNN1aBtWICZczDwpYuMfOaWfdkx/jFfLLQR+vI9YKGdKLK
         foD4nCmkprT/mM/qrrYggqOsFrK01nLTItCFm2/FwGqVXGOm1/TP2Li67NWqtO7IRzbW
         wtO/q6xMBOxsuRt9kQHj8qtDpRA/2uVtYlW0PPjyCSkwXcXh1vjwptW9pO0vVanW4mG7
         BWfQqC4h4hv4YPLPV+kdrr8l8tdyzyZLhAfBBopQZ9+h8fg7N1aD9rUj9qbF7NhKtpcV
         N6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTPqrWxhude+tFhrp4bP7IHAfI/NrAfRFzJAxS+VITU=;
        b=HkcA3E34OxdxpNnuf/WP1WOvgRqzFz4Mu9fWFoT9GCBnGeZfiU+boEkxinTvd6ko78
         UqrYFGViHHVWlj4ck7UJn+412bJHLf6FOrlbiq/fQUCvMWmV81D5NJaW20C4xQ9Cla6q
         EpaUy2nk9pXi9PrYAhz3P+YSbSizvTTNBl0tdL5IqsUpIZA61Thz8CLnI4K4pKjxjvL/
         +zf5PWttO8MSnaX1Fc7k6CeOxQg5XF7lPui9U6j551YzK1mx5bBAmM3egTbkS7jciJ4K
         RFi6VXqDB1Cj1vottq09A/CwA07Fg30htbn6PR85rQ+8Glzu/bHdjYAQ5cs3ocXkEmBo
         Bz3w==
X-Gm-Message-State: AO0yUKX9A0TXLmesAXgJ+Q/P3q0WxLbmIphpTHBzPxYy8sIA4blIm4N2
        4Dd6CDuLmJA0Arjgc0ar5De/YQ==
X-Google-Smtp-Source: AK7set/iekWwxvnBmWdW6HmF7NVSlg0EO5ceaKNAeBEFqbS/HY5Mw6oHGJHPJx/k0trsGK9f/F9neQ==
X-Received: by 2002:a50:9ee7:0:b0:4aa:a390:bf4a with SMTP id a94-20020a509ee7000000b004aaa390bf4amr3412234edf.20.1676391811511;
        Tue, 14 Feb 2023 08:23:31 -0800 (PST)
Received: from fedora.. (cpezg-94-253-130-165-cbl.xnet.hr. [94.253.130.165])
        by smtp.googlemail.com with ESMTPSA id bp8-20020a170907918800b008806a3c22c5sm1318027ejb.25.2023.02.14.08.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:23:31 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 4/7] ARM: dts: qcom: ipq4019: remove clk-output-names for sleep clock
Date:   Tue, 14 Feb 2023 17:23:22 +0100
Message-Id: <20230214162325.312057-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214162325.312057-1-robert.marko@sartura.hr>
References: <20230214162325.312057-1-robert.marko@sartura.hr>
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

Now that sleep clock is being passed directly to GCC, there is no need for
global name matching, so remove clk-output-names for sleep clock.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 7d3a812e2b13a..0342e51a03f32 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -144,7 +144,6 @@ clocks {
 		sleep_clk: sleep_clk {
 			compatible = "fixed-clock";
 			clock-frequency = <32000>;
-			clock-output-names = "gcc_sleep_clk_src";
 			#clock-cells = <0>;
 		};
 
-- 
2.39.1

