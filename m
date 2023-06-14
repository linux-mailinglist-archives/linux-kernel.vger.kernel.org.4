Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562B772FF2C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbjFNMzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbjFNMzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:55:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2ED10EC;
        Wed, 14 Jun 2023 05:55:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30aea656e36so4807054f8f.1;
        Wed, 14 Jun 2023 05:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686747341; x=1689339341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f4a+nqynai93p3DslnYapWoLBaBt6oixAJaqzvjoA2A=;
        b=O7bqwRo9lqTLd0GymqyDJ/F7I5npZ3EjGhqdc8H3z76pJF+lG6ctgHpTwrGS13GdeJ
         7/+hPgUpA7T81p6dBhiwsmDmSLI6YRtANIy5njh4PLpnZFxoVlEtMM2jCZpGI4ULOpws
         lbZy49S4H5M104U/AMIj/GdKhxXCOX2/DYD03RarZYLu2D2saslnN2zqChnZIGpUUCr/
         5laFVT1VMh6J2ECV7iqvALDhM6ApBsXH3ElHD4cuypHY2tURBT8rcE7Fe7vtBeDT6G9u
         aByQdm+gWh963O0oAxOTS97kALwPMyubxCNNW7EGWRpz2OlqLbaNogz987Mvkv3xkHDn
         1uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686747341; x=1689339341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4a+nqynai93p3DslnYapWoLBaBt6oixAJaqzvjoA2A=;
        b=SpZEK14VY/hXcpE9m5lL3pZnIISay3U8nNvsDS+wz8LbByOZH7qzwrtqGvUMGwIZxH
         mMQNb7/7+3n4dYfB0QfDDp/Urs6o1kw1Y6L9xWUVVCPA5ejJDFNjDe4/AutahOQIcwSI
         At4c/en3uoqWqIk6ce3QJueeukfjt5lHNOFlTrACdxtNvvY316+vT1R9XSqOMZK6C5Mp
         GMexZv38qpAnRu9oPTgazzusny6FOJKn0GhCxqTcqYGkDyqufnJrWXcsxyvKMpNjLFz6
         Dgl+IQKqYyYKo7apdSTEAhsC1BS4Nh5sGs6550hkZ2OpZ+x0JnuaIR5pkri+NrCquC8G
         DC7Q==
X-Gm-Message-State: AC+VfDyqq5WxZnYeJKfAg/lxVVJDOW9gXz6k50TCMTKsKIGMrFqE6VTc
        SSmXy+KKvhY86hZ50G13g/TMgJEzCWD6iRGD
X-Google-Smtp-Source: ACHHUZ5CgQtLa5Ylyn328rgorrSA/Y3m894rHJvNMi4kR8Twg1Hc7ZqF2fyloHx8zTEu2k8bZ90qfw==
X-Received: by 2002:adf:dc42:0:b0:306:28f4:963c with SMTP id m2-20020adfdc42000000b0030628f4963cmr9087095wrj.23.1686747340807;
        Wed, 14 Jun 2023 05:55:40 -0700 (PDT)
Received: from user-PC.. ([92.51.95.194])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0ad500b003f7310a3ffasm17402522wmr.2.2023.06.14.05.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:55:40 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 0/3] Add D1/T113s thermal sensor controller support
Date:   Wed, 14 Jun 2023 15:55:18 +0300
Message-Id: <20230614125530.660597-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
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

This series adds support for Allwinner D1/T113s thermal sensor controller.
THIS controller is similar to the one on H6, but with only one sensor and
uses a different scale and offset values.

v5:
- Dropeed 'thermal-zones' node from sunxi-d1s-t113.dtsi

v4:
- Dropeed DT bindings example

v3:
- Fixed SoB tag again

v2:
- Fixed SoB tag
- Moved binding patch before driver changes

v1:
- Initial version

Maxim Kiselev (3):
  dt-bindings: thermal: sun8i: Add binding for D1/T113s THS controller
  thermal: sun8i: Add D1/T113s THS controller support
  riscv: dts: allwinner: d1: Add thermal sensor

 .../thermal/allwinner,sun8i-a83t-ths.yaml       |  7 ++++++-
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi      | 17 +++++++++++++++++
 drivers/thermal/sun8i_thermal.c                 | 13 +++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.39.2

