Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272F76D1B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjCaJMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaJL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:11:58 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1C3199
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:11:57 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w4so20653172plg.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680253917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7dDIda1MxCpRULqGosvlkvyNyZhebmLJjbWMy1yIaY=;
        b=G4Q9UJX9S0goUgdWSiOmNtvxmYZwmhRRwNVljlTZJJ+DLbmqhHyHMGfjxL1Eu8Uk69
         tZHVgOF0NTQbicau07MxL+P74rmZycqLrHpazONgjAzAywAs4w9RKxieFSshvwTUEuYB
         tndSfeqz8rAvrQxWfVHsFSU8zbAtQpSBlR9yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680253917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7dDIda1MxCpRULqGosvlkvyNyZhebmLJjbWMy1yIaY=;
        b=x0cF5F95G8x+ooC7f7A/v0pyWGFLADIdfnQD8ZN4rS8CJ6Fx7toXzLmArCY3qQ6tKc
         fziHi9ZLS1ZrGnJ4qMZae9B0+wDm6syQ6n86ypCrKg3gN0jXMBgk+7S05krr30KC+F2L
         WemXTW1tTEAOsvcPXntWnfN4VNmZbUEFaS61pIx89IQa7YQVzsplUtObGwrrJZzh7pmf
         x2oUxN/1M5Pkn6luOfh3beD9K5lQaDfgai5qMGLlYshfJpH9caZIhlQNVb857TQkRtQ3
         QYoJxgcDCQJDiy75YePCQiuTtIgB4T9sFaZMRULDiU+xu3Y8agDCRc0vfh2shNGEU37V
         OTpg==
X-Gm-Message-State: AO0yUKXGz9vyNCwDacj2HTZFXnw9XVzez/UZcD+uoCR/Tp5l+I3zRwRS
        KZGu3rWm45dAkp0C7LDCn6aA+g==
X-Google-Smtp-Source: AK7set/YNRJeVCMasa15wj+q0DF+VOPSU+CMSKFUj/3jwBE5DYTHk5kVKbyGMSJGxq9crGAA2OkOSg==
X-Received: by 2002:a05:6a20:ce15:b0:d0:4361:9720 with SMTP id ic21-20020a056a20ce1500b000d043619720mr22160568pzb.61.1680253916733;
        Fri, 31 Mar 2023 02:11:56 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:ae9d:db7a:8a71:d458])
        by smtp.gmail.com with ESMTPSA id n6-20020a62e506000000b006227c3d5e29sm1360905pff.16.2023.03.31.02.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 02:11:56 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
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
Cc:     Xin Ji <xji@analogixsemi.com>, Marek Vasut <marex@denx.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Lyude Paul <lyude@redhat.com>, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Pin-yen Lin <treapking@chromium.org>,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Allen Chen <allen.chen@ite.com.tw>,
        David Zhang <dingchen.zhang@amd.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v15 00/10] Register Type-C mode-switch in DP bridge endpoints
Date:   Fri, 31 Mar 2023 17:11:35 +0800
Message-Id: <20230331091145.737305-1-treapking@chromium.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

This series is not directly related to the built-in mux in anx7625,
which automatically switches between the two orientations of a single
Type-C connector. This series adds support of registering mode switches
for two downstream devices, while we use orientation switches for two
orientations of the Type-C connector.

The first two patch modifies fwnode_graph_devcon_matches and
cros_typec_init_ports to enable the registration of the switches.

Patch 4~6 introduce the bindings for anx7625 and the corresponding driver
modifications.

Patch 7~9 add similar bindings and driver changes for it6505.

v14: https://lore.kernel.org/all/20230322104639.221402-1-treapking@chromium.org/
v13: https://lore.kernel.org/all/20230303143350.815623-1-treapking@chromium.org/
v12: https://lore.kernel.org/all/20230221095054.1868277-1-treapking@chromium.org/
v11: https://lore.kernel.org/all/20230204133040.1236799-1-treapking@chromium.org/
v10: https://lore.kernel.org/all/20230112042104.4107253-1-treapking@chromium.org/
v9: https://lore.kernel.org/all/20230109084101.265664-1-treapking@chromium.org/
v8: https://lore.kernel.org/all/20230107102231.23682-1-treapking@chromium.org/
v7: https://lore.kernel.org/all/20230105132457.4125372-1-treapking@chromium.org/
v6: https://lore.kernel.org/all/20221124102056.393220-1-treapking@chromium.org/
v5: https://lore.kernel.org/linux-usb/20220622173605.1168416-1-pmalani@chromium.org/

Changes in v15:
- Collected Reviewed-by tags
- Change the struct definition order for the Type-C switch helpers
- Fix style issues
- Updated the docs for the return value
- Updated the description in Kconfig
- Use dev_name as the typec_mux name
- Swap the definitions in anx7625_typec_port_data
- Add comments about the completion
- Abort the mux_set callback when the switch is unregistered

Changes in v14:
- Collect review tags
- Introduce a new Kconfig becuase it didn't build when CONFIG_TYPEC=m
- Add comments about devm_* usage
- Fix style issues

Changes in v13:
- Update the kernel doc of fwnode_connection_find_match
- Add typec_mode_switch_node_count helper
- Fix style issues
- Update a typo in the commit message
- Collect Reviewed-by tag

Changes in v12:
- Check the availability of the device node in fwnode_graph_devcon_matches
- Ensured valid access to "matches" in fwnode_graph_devcon_matches
- Updated the documentation in fwnode_connection_find_match(es)
- Add fwnode_for_each_typec_mode_switch macro
- Remove a duplicated dmesg in the helper
- Used IS_REACHABLE instead to guard the function signatures
- Removed the 4-lane binding in analogix,anx7625.yaml
- Reworded the description for the mode-switch property
- Fixed style issues in anx7625 driver
- Fixed the inverted orientation setting in anx7625 driver
- Changed "&ctx->client->dev" to "ctx->dev"
- Fixed the schema of "data-lanes" property for it6505
- Fixes style issues in it6505 driver
- Replaced &it6505->client->dev with it6505->dev
- Updated the error logs when parsing data-lanes property

Changes in v11:
- Added missing fwnode_handle_put in drivers/base/property.c
- Collected Acked-by tag
- Use fwnode helpers instead of DT
- Moved the helpers to a new file
- Use "reg" instead of "data-lanes" to determine the port number
- Updated the description of the endpoints in the bindings
- Referenced video-interfaces.yaml instead for the endpoints binding
- Removed duplicated definitions from inherited schema
- Moved the "data-lanes" parsing logics to bridge drivers
- Removed Kconfig dependencies for the bridge drivers
- Updated the usage of the private bridge driver data
- Added a clarification on the anx7625 built-in mux in the cover letter

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

Pin-yen Lin (8):
  drm/display: Add Type-C switch helpers
  dt-bindings: display: bridge: anx7625: Add mode-switch support
  drm/bridge: anx7625: Check for Type-C during panel registration
  drm/bridge: Remove redundant i2c_client in anx7625/it6505
  drm/bridge: anx7625: Register Type C mode switches
  dt-bindings: display: bridge: it6505: Add mode-switch support
  drm/bridge: it6505: Fix Kconfig indentation
  drm/bridge: it6505: Register Type C mode switches

Prashant Malani (2):
  device property: Add remote endpoint to devcon matcher
  platform/chrome: cros_ec_typec: Purge blocking switch devlinks

 .../display/bridge/analogix,anx7625.yaml      |  88 ++++-
 .../bindings/display/bridge/ite,it6505.yaml   | 101 +++++-
 drivers/base/property.c                       |  31 +-
 drivers/gpu/drm/bridge/Kconfig                |  20 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c     | 265 +++++++++++---
 drivers/gpu/drm/bridge/analogix/anx7625.h     |  22 +-
 drivers/gpu/drm/bridge/ite-it6505.c           | 326 ++++++++++++++----
 drivers/gpu/drm/display/Kconfig               |   8 +
 drivers/gpu/drm/display/Makefile              |   2 +
 drivers/gpu/drm/display/drm_dp_typec_helper.c | 107 ++++++
 drivers/platform/chrome/cros_ec_typec.c       |  10 +
 include/drm/display/drm_dp_helper.h           |  46 +++
 12 files changed, 874 insertions(+), 152 deletions(-)
 create mode 100644 drivers/gpu/drm/display/drm_dp_typec_helper.c

-- 
2.40.0.348.gf938b09366-goog

