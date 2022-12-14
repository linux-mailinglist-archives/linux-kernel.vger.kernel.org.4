Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F2E64C83D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiLNLmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbiLNLlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:41:51 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E7210B5B;
        Wed, 14 Dec 2022 03:41:47 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h11so18963007wrw.13;
        Wed, 14 Dec 2022 03:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mnLxEEtkwDMb5Dhb/JDaNIG/lWifqcCuQhOSzipR1SA=;
        b=isJHvU1ub3SUdofMT6POFlCZBGQXJa/2ddC2lMYjMnh/iQF2KhgRYYlVNRuWh8NhIl
         bwmLlXU1ijTvdXFPjjsUyYDC0ZY4mGF2oF8uD1oFNZzVZPx7RzUw+4T6XaamOr0zBCjD
         Zw9jr/oa4vsEG3BOM92wPawkF0dwycFYuLCKoo8BQIxQU0Zog4XSR4s/foTLjPlr/xLb
         ciEGmD7ticxAPu4Wf6RUpFZBv3rGXo8V/ELVCccNNUqPB5YyL9Nht+lv3HhhoGhM1Q1d
         zSgw3UYbpGee8w+5OFryehiIHOPjuO8CYY/lKEWr5rQ5v23BKvijpXSONFid6y6Ohu/y
         /sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnLxEEtkwDMb5Dhb/JDaNIG/lWifqcCuQhOSzipR1SA=;
        b=dTdJHoXiyJ3ZZxEY8bMXHPME23aA3G0y2IbeIXa5T0zZG6J3ji92CVCpT58vwPzfnc
         XBRXPTcmvINP9IAFri1yW52wG0F693W0LAl6zCH9VdtzDed0RnhXsUTfFwnpIiZrV7Hu
         6baIuMgZBynAoSmhqMV4OvtpWOwmijZlBKVGpW6xSJrSCn/GUGGhIA80VpH5SSjWj9l4
         N9GTza6VOf8eM2cVWF0TnPZWjpzq/3vm3Cd5a1usu0LQG5iJopaXljmg63H73fgAiH6e
         ymqAGEduKPW0LxxDfZ6jlKCHJhz8p8SH5KSRz7sF8yd2rOYvLvhakUxyjqFtFtWZz5rv
         7U1w==
X-Gm-Message-State: ANoB5pkaiO3yhv3Z5AHCasL6UjEGzQCqmNl0j99Ltc2cL8CNxenpLT2u
        ldy3kf75jusbxpP1+Mr3rnY=
X-Google-Smtp-Source: AA0mqf6LMR9JT6vXFGbcDlR6xl7ICd1sc9wv75CHxh3AxPEJE63o9fesiJccg7qeGveiU+No4CkZmw==
X-Received: by 2002:a5d:670c:0:b0:242:203c:9ed4 with SMTP id o12-20020a5d670c000000b00242203c9ed4mr16122441wru.55.1671018106380;
        Wed, 14 Dec 2022 03:41:46 -0800 (PST)
Received: from localhost.localdomain (2a02-8428-46a0-7c01-bc7c-15f1-6c3b-ad74.rev.sfr.net. [2a02:8428:46a0:7c01:bc7c:15f1:6c3b:ad74])
        by smtp.gmail.com with ESMTPSA id b8-20020a05600003c800b0024258722a7fsm2697405wrg.37.2022.12.14.03.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 03:41:45 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul@crapouillou.net,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH v2 0/2] Add support for the AUO A030JTN01 TFT LCD
Date:   Wed, 14 Dec 2022 12:41:40 +0100
Message-Id: <20221214114142.204041-1-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Changes since v1:
 reworked the dt-bindings to add a spi node, dropped properties already 
 present in panel-common.yaml

Christophe Branchereau (1):
  drm/panel: Add driver for the AUO A030JTN01 TFT LCD

Paul Cercueil (1):
  dt-bindings: display/panel: Add AUO A030JTN01

 .../bindings/display/panel/auo,a030jtn01.yaml |  61 ++++
 drivers/gpu/drm/panel/Kconfig                 |   8 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-auo-a030jtn01.c   | 295 ++++++++++++++++++
 4 files changed, 365 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-auo-a030jtn01.c

-- 
2.35.1

