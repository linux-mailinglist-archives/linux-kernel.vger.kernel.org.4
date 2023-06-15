Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3124A731BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241240AbjFOOoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241034AbjFOOoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:44:37 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5012D2736;
        Thu, 15 Jun 2023 07:44:35 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f5f728c4aaso1098132e87.0;
        Thu, 15 Jun 2023 07:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686840273; x=1689432273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3OVYFBud63oBmzgiKeGVku/0LMDSys68f5xBbeb6bPY=;
        b=gvJvlhyz6mGHxA6nEwkgEECKteCPa2XcgRP0HBANaI9uGOK4+v7YqzECwuC3X++sJX
         hmcfk1TB7MorQ53pXiXkFZwE2SnZ5yQzfR5IZkW3JROxBQKCJDev02f6ceBfUnJi/rAN
         wgUhMIn1iEQYRglCfEFTaaeiIMNYZmsFK9TiX7QIXc44bPvXovr0hRQ92G1VaCWX5YtM
         XKkpbbX6WZRNoclcYpz4CdcmOFpXy6eTajJ73BHS6wwvX8QG1gi2AvEEHO37TKs40+5l
         WE76EUYGaOl1joKIc2rXgiudqb8+ZYuylTmuEG7i0D/Kjj1c2WBpnWX0BcZ8+9KeFqr+
         ehGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686840273; x=1689432273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OVYFBud63oBmzgiKeGVku/0LMDSys68f5xBbeb6bPY=;
        b=VqNi7hgcrgKNKjZCMj+HSZaYL98fDrovt0tB4jzK8fInyV8EPymWbtE8MnE6tDdxGN
         StcCRIsVvbbQxLaE3wIpsGahhhGuHhmovRSjNCgzQ9lYTCYJ6IlcWitB3LdwYFj8za5E
         JzeOXb+xks1AQohK8pXoE75ogpRTWoZfnXcCEQwaZ4WWhpkeXz4/3lXBtqvB2TD3k0U4
         Pg5EZm0pxPLfWi2zReH6cygnd35M4Fb3mjcWf4cZ//29r8QP3ZcSPIsx8513f7uk38Zw
         jeMLzVybKUn5l8Oszaa8t1ZTV1KhG5/S4yGEtfsWKH+BrXAjBWzRiBQGefNiGyI/GeTX
         FoVA==
X-Gm-Message-State: AC+VfDyW6s1H2J+5Q+D85TTlJpgafJL6K/PxhXAiBAlrVavbMfHqpQ+B
        vYowK2qwnxSXq5zzyBRYIvajQVmCAO5e/bKs0A==
X-Google-Smtp-Source: ACHHUZ6DbPaMv5ulJSq95WK2pTU4k2Fu5q20+cJlSAw29Dpc0bbyrB4k2JLeuY6MVfaHWXKm0JpdEA==
X-Received: by 2002:a19:645b:0:b0:4f4:2717:7e6f with SMTP id b27-20020a19645b000000b004f427177e6fmr1101587lfj.23.1686840272990;
        Thu, 15 Jun 2023 07:44:32 -0700 (PDT)
Received: from localhost.localdomain (mail.pulsar-telecom.ru. [94.181.180.60])
        by smtp.gmail.com with ESMTPSA id h7-20020ac25967000000b004f13f4ec267sm244451lfp.186.2023.06.15.07.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 07:44:32 -0700 (PDT)
From:   Aleksandr Shubin <privatesub2@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Aleksandr Shubin <privatesub2@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: [PATCH v1 0/3] Add support for Allwinner PWM on D1/T113s/R329 SoCs
Date:   Thu, 15 Jun 2023 17:43:55 +0300
Message-Id: <20230615144423.828698-1-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for PWM controller on new
Allwinner's SoCs, such as D1, T113s and R329. The implemented driver
provides basic functionality for control PWM channels.

Aleksandr Shubin (3):
  dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM
    controller
  pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
  riscv: dts: allwinner: d1: Add pwm node

 .../bindings/pwm/allwinner,sun20i-pwm.yaml    |  70 ++++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  12 +
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sun20i.c                      | 364 ++++++++++++++++++
 5 files changed, 459 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sun20i.c

-- 
2.25.1

