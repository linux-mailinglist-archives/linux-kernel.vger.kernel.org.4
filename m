Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F66D608E6D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJVQVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJVQVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:21:00 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33A95FF40;
        Sat, 22 Oct 2022 09:20:58 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h8so7546220lja.11;
        Sat, 22 Oct 2022 09:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ow15MbA176n1kepBcKE6T4nByFrRV82RJQgMkdjakt0=;
        b=YM4xrPFC6f9ys2iysg7iytkDNDU2BxRMJnbZ1e52Ldei31jE/3k2YU9ZJJNGZdlTRc
         603nRjVGVIZfnjIeSiZOXgmDco3LGesGzPqMrqOHZkoPmYAJ+sLUq+hVaRYYC2UWCdIg
         i1G4dfxD54FQbJHErtB0nq3dW3FDplq5Fqnvpq61T6L30ZG1o9Lo0XO3t8QcjqGHI3bW
         MD/0/dJxVQ0K+qNySJgpt3n7OfaA4yiAFP9xYXH8sgJongyveP+uAruiwe4r8YiTcPpa
         N8jEkvwc/YEOpzo56j6IELuXSyooKxCrZLTHlBj4a0KckhezuldFJbo97hZW+KEl48wE
         Z1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ow15MbA176n1kepBcKE6T4nByFrRV82RJQgMkdjakt0=;
        b=TjYfvXoEHRhwvyZQ6PB9acxG9+miSCscCN62chizGXK05rb5TGTesUjvPvTMmlLPdJ
         aN7bwJ0qlH9xX47rNXAAe551AlcpSn6A1fEic45Da/r26bgpC07CmydQuVLeGnvW1KPo
         uaKekrODGQCXb8L/iGRr2e1yhBvmlO62zbriRcA89Ma9gmIfPGqMDDf6P4S/hFb0/NKb
         cLSQtvSqL/Cz07FvOCiVpAFz1Wv0OE5WpBqYquRJ2caXzw5d2MdUAkVuGYu2fiTCefCY
         5jueC67m+P8YO4WWCYgrZUrgOTQxHzcUqrDZ15px8WgXOsE5HdIk1hcLfAdwfuhvHZ+v
         UHAQ==
X-Gm-Message-State: ACrzQf3+t6r2OL+UWV8sJTAjU8OWiYe6pu2fSqPPuOPV3VbE/HZcOYIY
        c8f5s5kGcKOfXHwd6NCz0V8=
X-Google-Smtp-Source: AMsMyM44dTWRR5dzyzW+XWTdCTMEmjIUW5akyDDu72LqTnvWv3wLHpLy6QtUKm7vAKb93JbtXgNWLg==
X-Received: by 2002:a2e:b753:0:b0:276:ac05:b7c9 with SMTP id k19-20020a2eb753000000b00276ac05b7c9mr2632297ljo.137.1666455656950;
        Sat, 22 Oct 2022 09:20:56 -0700 (PDT)
Received: from localhost (95-31-187-187.broadband.corbina.ru. [95.31.187.187])
        by smtp.gmail.com with ESMTPSA id f2-20020a19ae02000000b004a2550db9ddsm3618980lfc.245.2022.10.22.09.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 09:20:55 -0700 (PDT)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jimmy Su <jimmy.su@intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Daniel Scally <djrscally@gmail.com>,
        Marek Vasut <marex@denx.de>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Add Omnivision OV4689 image sensor driver
Date:   Sat, 22 Oct 2022 19:20:05 +0300
Message-Id: <20221022162042.14113-1-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is the fourth revision of the Omnivision OV4689 driver. In this
revision I have addressed most of the suggestions from the reviews of
v3. See detailed changelog below.

Changes in v4:
  - driver: drop OF from Kconfig (Sakari)
  - driver: remove ifdef CONFIG_ (Sakari)
  - driver: unsigned int in ov4689_map_gain in ov4689_map_gain (Sakari)
  - driver: remove num_ranges and use ARRAY_SIZE instead (Sakari)
  - driver: make ov4689_remove return void
  - driver: move selection bounds to struct ov4689_mode (Sakari)
  - driver: remove braces in if (IS_ERR(ov4689->xvclk)) (Sakari)
  - driver: fix ov4689_cal_delay (Sakari)
  - driver: remove MODULE_DEVICE_TABLE(i2c, ov4689_id) (Sakari)
  - driver: update copyright (Jacopo)
  - driver: drop device.h include (Jacopo)
  - driver: h_blank_dev -> h_blank_def (Jacopo)
  - driver: change -EPROBE_DEFER to -EINVAL if fwnode_graph_get_next_endpoint fails (Jacopo)
  - driver: dev_err_probe() for devm_regulator_bulk_get() result (Christophe)
  - driver: reimplement error handling in ov4689_check_sensor_id (Christophe)
  - driver: fix ./scripts/checkpatch.pl --strict --max-line-length=80 warnings (Sakari)
  - bindings: collect Krzysztof's R-b


Changes in v3:
  - set 1st patch title to: "media: dt-bindings: i2c: document OV4689"
  - schema: drop clock-names
  - driver: use dem_clk_get(NULL)
  - schema: remove maxItems from powerdown-gpios
  - schema: make gpios optional
  - driver: use devm_gpiod_get_optional()
  - driver: remove __ prefixes from function names
  - driver: switch to .probe_new
  - driver: remove of_match_ptr
  - driver: add and use enum ov4689_mode_id
  - driver: make xvclk optional & try to get frequency from ACPI
  - driver: drop #if defined(CONFIG_MEDIA_CONTROLLER) in remove
  - driver: use ARRAY_SIZE(ov4689_supply_names) instead of define
  - driver: remove unused controls from struct ov4689
  - driver: use 504000000 instead of OV4689_LINK_FREQ_500MHZ
  - driver: compare link frequencies with menu array clock-frequency
  - driver: replace |= with ret = ret ?:
  - driver: merge power on/off into pm callbacks
  - driver: use actual clock rate in ov4689_cal_delay
  - driver: set up controls after writing register table in s_stream()
  - driver: remap sensor gain to linear and monotonous logical gain
  - driver: set pixel_rate to 480000000
  - driver: set HTS so that we have 30.00 fps and fix HBLANK reporting

Changes in v2:
  - bindings: reword descriptions
  - bindings: move clock description to clocks property
  - bindings: add data-lanes and link-frequencies properties to port
  - driver: validate media bus configuration when probing


Mikhail Rudenko (2):
  media: dt-bindings: i2c: document OV4689
  media: i2c: add support for OV4689

 .../bindings/media/i2c/ovti,ov4689.yaml       |  134 +++
 MAINTAINERS                                   |    8 +
 drivers/media/i2c/Kconfig                     |   13 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/ov4689.c                    | 1026 +++++++++++++++++
 5 files changed, 1182 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
 create mode 100644 drivers/media/i2c/ov4689.c

--
2.38.1
