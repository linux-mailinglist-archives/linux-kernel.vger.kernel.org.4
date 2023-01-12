Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A701666A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbjALEWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 23:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236658AbjALEVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:21:25 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E77DFAC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:21:14 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id q9so11969891pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e9TgMkUTB5YOnsNGFXtHW+XO6z2pX0iNsH1isonaM8g=;
        b=TbTXQTNnYb2+/gCpZS4/jwvr2YSRxosGiiZSD0IWuQeoMMyS2ipZzmSa+e1OXJTj3s
         LYJZ/mucmWPGqJkCrYg4Blol0UStFlbZIsrwquBSd9X2UKuLCnxN2iT5dcZXdO61MssC
         5Iu1FEvWkv+6pyjCFAFFKVBwVBZR+JXgMK51A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9TgMkUTB5YOnsNGFXtHW+XO6z2pX0iNsH1isonaM8g=;
        b=65vm2BYVhwYhyHYm5lLZn/47JvqwZtnXFUMsqMXgbFZmwKddTQhsVbwL7pQllZTje3
         dgwdPn/9VQS4ImLj52sAhl+Oi9qVbzB5QsOxMW1L6C/RYtmgQ6QFjKnk0i8n3OR4624i
         gRMzmEw1cJnPdc6ZBUaOrezAruv/gTNCU6fdh724cpuiT/yL3f2h7fXJEhzkFtqsFZ7Q
         RYCN/JGYBcUHDzQmkfnbAALq35cqJg6MUxptF/HEDRwpSzXYZJi9a99Phfy5OPYtSUFq
         Vxru7ZRr7UC8IIiMFHbSE6PSdLN0583kJplrUsE7PdpjvGmhFFim41R32fwcy+GgKEEj
         qJ0g==
X-Gm-Message-State: AFqh2krm3u+oP6J4Ql4nDqHJB4YstIQUPfrvhaExy/ekldeP7XzoT4b4
        nZ1GHsgp3CLsPLTdEu2AVPZDMg==
X-Google-Smtp-Source: AMrXdXtEEf4zzIOGihPovGiSTQAooTH6SaH3XCz54U3JEV62yCNR6gI7P35jZs5wWV8JXGLSWMOBTg==
X-Received: by 2002:a62:1684:0:b0:587:8d47:acdd with SMTP id 126-20020a621684000000b005878d47acddmr12787846pfw.34.1673497273462;
        Wed, 11 Jan 2023 20:21:13 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:594f:5484:7591:d074])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78bc8000000b00582579cb0e0sm5519478pfd.129.2023.01.11.20.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 20:21:13 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Marek Vasut <marex@denx.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Lyude Paul <lyude@redhat.com>, chrome-platform@lists.linux.dev,
        Xin Ji <xji@analogixsemi.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        linux-acpi@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH v10 0/9] Register Type-C mode-switch in DP bridge endpoints
Date:   Thu, 12 Jan 2023 12:20:55 +0800
Message-Id: <20230112042104.4107253-1-treapking@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series introduces bindings for anx7625/it6505 to register Type-C
mode-switch in their output endpoints, and use data-lanes property to
describe the pin connections.

The first two patch modifies fwnode_graph_devcon_matches and
cros_typec_init_ports to enable the registration of the switches.

Patch 4~6 introduce the bindings for anx7625 and the corresponding driver
modifications.

Patch 7~9 add similar bindings and driver changes for it6505.

v9: https://lore.kernel.org/all/20230109084101.265664-1-treapking@chromium.org/
v8: https://lore.kernel.org/all/20230107102231.23682-1-treapking@chromium.org/
v7: https://lore.kernel.org/all/20230105132457.4125372-1-treapking@chromium.org/
v6: https://lore.kernel.org/all/20221124102056.393220-1-treapking@chromium.org/
v5: https://lore.kernel.org/linux-usb/20220622173605.1168416-1-pmalani@chromium.org/

Changes in v10:
- Collected Reviewed-by and Tested-by tags
- Replaced "void *" with "typec_mux_set_fn_t" for mux_set callbacks
- Print out the node name when errors on parsing DT
- Use dev_dbg instead of dev_warn when no Type-C switch nodes available
- Made the return path of drm_dp_register_mode_switch clearer
- Added a TODO for implementing orientation switch for anx7625
- Updated the commit message for the absence of orientation switch
- Fixed typo in the commit message

Changes in v9:
- Collected Reviewed-by tag
- Fixed subject prefix again
- Changed the naming of the example node for it6505

Changes in v8:
- Fixed the build issue when CONFIG_TYPEC=m
- Fixed some style issues
- Fixed the subject prefixes for the bindings patch
- Fixed the bindings for data-lanes properties

Changes in v7:
- Fix the long comment lines
- Extracted the common codes to a helper function
- Fixed style issues in anx7625 driver
- Removed DT property validation in anx7625 driver.
- Fixed style issues in it6505 driver
- Removed the redundant sleep in it6505 driver
- Removed DT property validation in it6505 driver
- Rebased to drm-misc-next
- Fixed indentations in bindings patches
- Added a new patch to fix indentations in Kconfig

Changes in v6:
- Changed it6505_typec_mux_set callback function to accommodate with
  the latest drm-misc patches
- Changed the driver implementation to accommodate with the new binding
- Dropped typec-switch binding and use endpoints and data-lanes properties
  to describe the pin connections
- Added new patches (patch 1,2,4) to fix probing issues
- Changed the bindings of it6505/anx7625 and modified the drivers
  accordingly
- Merged it6505/anx7625 driver changes into a single patch

Pin-yen Lin (7):
  drm/display: Add Type-C switch helpers
  dt-bindings: display: bridge: anx7625: Add mode-switch support
  drm/bridge: anx7625: Check for Type-C during panel registration
  drm/bridge: anx7625: Register Type C mode switches
  dt-bindings: display: bridge: it6505: Add mode-switch support
  drm/bridge: it6505: Fix Kconfig indentation
  drm/bridge: it6505: Register Type C mode switches

Prashant Malani (2):
  device property: Add remote endpoint to devcon matcher
  platform/chrome: cros_ec_typec: Purge blocking switch devlinks

 .../display/bridge/analogix,anx7625.yaml      |  99 ++++++++++++-
 .../bindings/display/bridge/ite,it6505.yaml   |  93 ++++++++++--
 drivers/base/property.c                       |  15 ++
 drivers/gpu/drm/bridge/Kconfig                |  21 +--
 drivers/gpu/drm/bridge/analogix/Kconfig       |   1 +
 drivers/gpu/drm/bridge/analogix/anx7625.c     | 105 +++++++++++++-
 drivers/gpu/drm/bridge/analogix/anx7625.h     |  13 ++
 drivers/gpu/drm/bridge/ite-it6505.c           | 119 +++++++++++++++-
 drivers/gpu/drm/display/drm_dp_helper.c       | 134 ++++++++++++++++++
 drivers/platform/chrome/cros_ec_typec.c       |  10 ++
 include/drm/display/drm_dp_helper.h           |  17 +++
 11 files changed, 598 insertions(+), 29 deletions(-)

-- 
2.39.0.314.g84b9a713c41-goog

