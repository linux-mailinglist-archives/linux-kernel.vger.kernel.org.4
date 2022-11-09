Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CDE622FBA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiKIQJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiKIQJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:09:23 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE4822B0C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:09:22 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bs21so26492179wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 08:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newflow-co-uk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZWwNSEAuMfkLC1//h9rhEQdeaWkxTtOogVUcqByABI=;
        b=DyyM7OXTB4UJmJ8I8T/ovHtsqnCJLeta8aQ4cnQBcoO2caXnhXcA61FKkwxeH6xXsC
         OlQ/gOBB5WZh15vqFGANySRt7ypc2/Xvfa/wjxBsGWaehz01Zf1X6cTqnYnmIp5/MErU
         vnRjY/u/4lHFoEbeTWv0FxVToQS/BC95P0yXrTP+8Gz3NVvcbSj9DE+HnrKtg8MCWT5q
         KZuQvHjZDWfSwRVkco+40tYcMqozj2r6IV6CkpQYbZ4u7o9b7u445ydSsJpVPT+9S/PR
         NPHx0SV4zmZsxSOJwbbMptyz+WjY4F42ZlDjeyf7GnMBfshbyHo9MEPT5vLrYJvvxcYu
         WPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZWwNSEAuMfkLC1//h9rhEQdeaWkxTtOogVUcqByABI=;
        b=aen8uk9hZEc+99BfPRBzxzxxaIc9yavsHkU5pry4vY/9o4PzC2zh06fuYQ92esbzs4
         okIjPHtp6rg751gON1+dGp7RK0dRafPJ+wjZM4JJ9wOP72c8d1rCOWOLtFplbfgDxLGP
         wq+45hgZOr66n98OjK1RwT214ZYFdJ5Q6GnJ5yk6F3IHHlN8gXLzzyCK49UxnjwK3rSs
         Xzc6v9caND1mAB6gXDZm0EQRCp/25aVgOXTbiR+NW1WwsDFR5zCS8nzAPRA0FsPKtkWl
         NRtTW1lQiHLV4VZdH52OuUQ4ktniINIUtJej9ck6C+ebmGuz5LQskHqpK/Lo1X5mh1G0
         PQjQ==
X-Gm-Message-State: ACrzQf0PP2pOWUfZJFuh6trCUkUskfimJUxH5eoJzzm6IrB5xkr6IkFz
        +mV1jkZmTHIu6JdCmBHWb8uyGg==
X-Google-Smtp-Source: AMsMyM4MbiwJYQDTdPHUWGLJ5LwaSU5ZSyFSnw+N9Wteih8C3GJQFIO3o931AsfYTN8MaLW09vOeyw==
X-Received: by 2002:a5d:5643:0:b0:236:699c:6cd8 with SMTP id j3-20020a5d5643000000b00236699c6cd8mr39608243wrw.435.1668010160873;
        Wed, 09 Nov 2022 08:09:20 -0800 (PST)
Received: from mpfj-unity.. ([94.12.112.226])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d6604000000b002366fb99cdasm13307772wru.50.2022.11.09.08.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:09:20 -0800 (PST)
From:   Mark Jackson <mpfj@newflow.co.uk>
To:     Mark Jackson <mpfj@newflow.co.uk>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] ARM: dts: nanobone: Enable I2C temperature sensor
Date:   Wed,  9 Nov 2022 16:09:02 +0000
Message-Id: <20221109160904.183147-4-mpfj@newflow.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109160904.183147-1-mpfj@newflow.co.uk>
References: <20221109160904.183147-1-mpfj@newflow.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NanoBone platform supports a temperature sensor on the I2C bus.

Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
---
 arch/arm/boot/dts/am335x-nano.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
index cecc2afaeff4..2be831927af6 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -212,6 +212,11 @@ &uart5 {
 	status = "okay";
 };
 
+temperature-sensor@48 {
+	compatible = "lm75";
+	reg = <0x48>;
+};
+
 &i2c0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.34.1

