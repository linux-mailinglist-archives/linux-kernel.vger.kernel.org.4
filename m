Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B61960043E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 01:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJPXm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 19:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiJPXmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 19:42:21 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946DA240AF;
        Sun, 16 Oct 2022 16:42:20 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso8778586wmb.5;
        Sun, 16 Oct 2022 16:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBGk5yA9hr5t3AA+tWd2/rq303jcXV9PFlMj181BSFI=;
        b=FhzdIdle7Byp6UdzdLvBMHNqAXydDtYl8lsjaf+sXGSFAyqWiKijaWH6Gwvy2XXdRc
         5SuBEo+syYBxHH+A6SALXgimxXRouIkhHCVh+MmkCrrvK9iZCfFFZSDaE7q9yD8lG7Z+
         0r9fXF+ZUB87e7rot1GrdNYtXfXBZ+qlmAZr1EtVZwf4ZW33ei6IWgck3v7oXNmiQpcm
         D1/0reRUyJDqOOUsjLTQMqjt46oD8wn6PkKsLLcO0K88r8l6hAHkj5pHHLlppGF/sSSw
         Asp5bFIn9D2HU/LRD0cfH2G/NwacMnNuHJqZbir2cA6sBu89Lsn9+aLxJ32N1T025h65
         PlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBGk5yA9hr5t3AA+tWd2/rq303jcXV9PFlMj181BSFI=;
        b=lxGiQ4GVaLf1ecUn7aSdUxqbfVPC9Y6SGe4LnH+FpvP6RU+5IixagR9dtN0hxHDnz3
         Eg40FGD03RAARNlrop8tfYsB5O04MduAK1oZrh6vT37lS5x1iv0s5OdXkVgZ/UuSTLY4
         rGfi0hvkOf+SJ/rCTS60l5nHTPQwMCXTSthh5p+yrXPeW4JQxhNun8E3zC5vEwc9x3uA
         lm/D2gRMnqcd5Vhavm5pY4oiYGT+IiQvyQWwmz+qdNfYiaHDRC4f0oztZ+Xg1oIJaxnN
         Mk9z/p4yT4wYhEm6DfwUfEIr24fHoObhuqBgDbvty9WYKx8HVbrmBTpfhAboJCUnKm1I
         Caiw==
X-Gm-Message-State: ACrzQf0nk1kkK6Obn+a1SU7ZoEbw5q1kgi0/fAesoHsKx8fY4IBUo+FG
        z7mHddRiSSYXfVsp/0kPyJ4=
X-Google-Smtp-Source: AMsMyM6a1b3h3S0EzopzsnKdRQez9JmYa4UY6asFstktCNSMPY1coWwLPN5UeQ/iX+acJIMRkSrByg==
X-Received: by 2002:a05:600c:1c08:b0:3c6:e398:64e0 with SMTP id j8-20020a05600c1c0800b003c6e39864e0mr5455065wms.2.1665963739130;
        Sun, 16 Oct 2022 16:42:19 -0700 (PDT)
Received: from localhost (188.31.4.189.threembb.co.uk. [188.31.4.189])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c4fce00b003c6b67426b0sm14315527wmq.12.2022.10.16.16.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 16:42:18 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc,
        samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v6 03/13] dt-bindings: power: supply: axp20x: Add AXP192 compatible
Date:   Mon, 17 Oct 2022 00:43:25 +0100
Message-Id: <20221016234335.904212-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
References: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP192's USB power supply is similar to the AXP202 but it has
different USB current limits and a different offset for the VBUS
status register.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 .../bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
index 3ce648dd91bd..34b7959d6772 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
@@ -22,6 +22,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - x-powers,axp192-usb-power-supply
           - x-powers,axp202-usb-power-supply
           - x-powers,axp221-usb-power-supply
           - x-powers,axp223-usb-power-supply
-- 
2.38.0

