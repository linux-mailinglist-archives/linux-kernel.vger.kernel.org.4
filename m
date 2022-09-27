Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D455ED034
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 00:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiI0WWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 18:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiI0WWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 18:22:06 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85C61CD694;
        Tue, 27 Sep 2022 15:22:03 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id k10so17755804lfm.4;
        Tue, 27 Sep 2022 15:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=CGvzPjPNHMFgePXTaJBxR51NmeqJhG8EGo7z/G0eoyQ=;
        b=batRzELYyAPtvqhHE4E+G3I2R7HM9HXa5sQMPGDrYyrR7GHcSkxk8WHjCYz2AXBgEq
         NI2LDwr5o2v+akkZMwXgNB4FXBgZI5gvbKibWf9G9EU7v/2Imgi+VHwhkCGpp079Y5lg
         qixHBkubqNgoTlBfw1KTx6tvFuAbZ0tJBHV5gD2MjS9vEDiTuHyU/P4OG0qjpM16CCqT
         Noz62DmaK7cBy7g7obUF7HIpj9tUTxwqwozt8vaFrfNgeuBdIygAOSRsBJkYC0JLk3Cx
         j1WNyo+yKRc9flC+O6A6Z8TTU8UfwmcbhmptbKV9gT69wSzAIzrWPT76L3AoSJegvaKa
         ykqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=CGvzPjPNHMFgePXTaJBxR51NmeqJhG8EGo7z/G0eoyQ=;
        b=lFvxO6L+0onLcTAlB47n5pOSq8LX4+l8lQCgGm3nWhAtekTOsueJ0Be5/iXIJgyGlX
         lB/oAA+TVZeVwWbApL+cjWLTfWHQhtRJCa1SEG65MMxyCoaT4gMhpJU1qmVRSzucbrnm
         8NMxTboJ+GHWB8bXCPoMJYbTxh5J9XxW8zEw0Uxe/hSfpyozu0sgwjrCGMXLyWTGY3sc
         V7/lzl07q/Dp00qXhTvUBmZ6YLj2rPT7HcPDKsDUj9QufdZ7F3TxWVeOYYuDFEqL2JNY
         AG2mIIQOIbX0DtNUnNOEeZHeYEg+NssqUNrKGA1pgXD+4DMYSyYMJtSI60IIHK/G6X9a
         Tplg==
X-Gm-Message-State: ACrzQf1YX6WIJ2nIaSpKpZjDWpTZe/9ksdBAb81idV1ojjPg54PRQE4y
        y3AxJj9zkdNSCNB8seKag2M=
X-Google-Smtp-Source: AMsMyM6Y720BGbl0OWVzLZvKrV63K6Xb8VJMI5K2NWOQMDEjO1x5qdsaS/jAMwgx6pKDhvavL2XqLw==
X-Received: by 2002:a05:6512:110b:b0:49a:d211:bb2f with SMTP id l11-20020a056512110b00b0049ad211bb2fmr11542679lfg.24.1664317321946;
        Tue, 27 Sep 2022 15:22:01 -0700 (PDT)
Received: from localhost ([37.1.42.233])
        by smtp.gmail.com with ESMTPSA id q1-20020ac25281000000b0049f53d53235sm281391lfm.50.2022.09.27.15.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 15:22:00 -0700 (PDT)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Shawn Tu <shawnx.tu@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Pagano <mpagano@gentoo.org>,
        Arec Kao <arec.kao@intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Daniel Scally <djrscally@gmail.com>,
        Martin Kepplinger <martink@posteo.de>,
        Marek Vasut <marex@denx.de>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Add Omnivision OV4689 image sensor driver
Date:   Wed, 28 Sep 2022 01:21:32 +0300
Message-Id: <20220927222152.132951-1-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.37.3
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

this is the third revision of the Omnivision OV4689 driver. Main
changes in this version are (1) mapping physical camera gain to
monotonous and mostly linear logical gain exposed via corresponding
control and (2) reporting consistent pixel rate and hblank. These and
other minor changes are listed below:

changes in v3:
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

changes in v2:
- bindings: reword descriptions
- bindings: move clock description to clocks property
- bindings: add data-lanes and link-frequencies properties to port
- driver: validate media bus configuration when probing

Mikhail Rudenko (2):
  media: dt-bindings: i2c: document OV4689
  media: i2c: add support for OV4689

 .../bindings/media/i2c/ovti,ov4689.yaml       |  134 +++
 MAINTAINERS                                   |    8 +
 drivers/media/i2c/Kconfig                     |   14 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/ov4689.c                    | 1027 +++++++++++++++++
 5 files changed, 1184 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
 create mode 100644 drivers/media/i2c/ov4689.c

--
2.37.3
