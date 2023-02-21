Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DD169DD37
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjBUJvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjBUJvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:51:11 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BDF234C6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:51:09 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id pt11so4805270pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pm9I7nw6XriJ6pEKHNiteEKQZGZA9l4iGaftQdH9nVM=;
        b=XzB+kAvx+qj+foqpLl4+jeactkmccPwb3V7SBl2JgxaFc+pql6e9gDB5TsVTs069lc
         6UyR7NB7BR2pyLIPASV11yRUoGsvzrhmbH30+crUV6Fdjn+oDLY4pdqHUNyEo6HIhknO
         XEZnW2zYZR8a+Vx4B21lCORpnNTWpUdfq2pm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pm9I7nw6XriJ6pEKHNiteEKQZGZA9l4iGaftQdH9nVM=;
        b=6RCze2RmuGWmti97/SxsJ/aGyDdeTqrjHhJEQzowAHSJY9sTZbV7wm9aePsQ7Hkuh5
         6PVPvXYNAw0BewIKm767CTP3wpENODEEHd4V4Bujc92cqxY7dpzgOhjAKxnPRwxe0ITe
         0rfGOrserJ+y3tRLl2l2rlpHhM2V0zubRUPp6V756baJtUktGL4JQUOmj2+ceSmDEvgx
         Mblr54hLC+eq77QArMFYlqE8lZPHV8t8pmWhji9gm2V/AZJODoEtRRI1thPV9b0vYV6t
         S8HISktkFXa2OuLlN3SLfmGXbttu2fwr30B97nSNLsX3puYMDMbhnW9bH8BMnhO0Zerd
         ZKnQ==
X-Gm-Message-State: AO0yUKXMa+hLcjhrJ0hIbWVrb2dx7KYa37JAKQu2rTTBblA87M4/CUOv
        D0lWDzohb33Y6tdviz1DrR1DLw==
X-Google-Smtp-Source: AK7set+lt5mTKdNeRiKG1ksrSYZV5MRLTMmV0Ba7YhiV3pDyImcjhF9MdifJ+oKLI9jRNrguT742fw==
X-Received: by 2002:a05:6a20:3d94:b0:c7:6f26:ca2 with SMTP id s20-20020a056a203d9400b000c76f260ca2mr18480137pzi.58.1676973069224;
        Tue, 21 Feb 2023 01:51:09 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:a1f5:f58d:584e:5906])
        by smtp.gmail.com with ESMTPSA id t25-20020a656099000000b004eca54eab50sm3524918pgu.28.2023.02.21.01.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 01:51:08 -0800 (PST)
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
Cc:     Pin-yen Lin <treapking@chromium.org>, linux-kernel@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Marek Vasut <marex@denx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Xin Ji <xji@analogixsemi.com>,
        Lyude Paul <lyude@redhat.com>,
        Allen Chen <allen.chen@ite.com.tw>, devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, chrome-platform@lists.linux.dev,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-acpi@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v12 00/10] Register Type-C mode-switch in DP bridge endpoints
Date:   Tue, 21 Feb 2023 17:50:44 +0800
Message-Id: <20230221095054.1868277-1-treapking@chromium.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

v10: https://lore.kernel.org/all/20230112042104.4107253-1-treapking@chromium.org/
v9: https://lore.kernel.org/all/20230109084101.265664-1-treapking@chromium.org/
v8: https://lore.kernel.org/all/20230107102231.23682-1-treapking@chromium.org/
v7: https://lore.kernel.org/all/20230105132457.4125372-1-treapking@chromium.org/
v6: https://lore.kernel.org/all/20221124102056.393220-1-treapking@chromium.org/
v5: https://lore.kernel.org/linux-usb/20220622173605.1168416-1-pmalani@chromium.org/

Changes in v12:
- Check the availability of the device node in fwnode_graph_devcon_matches
- Ensured valid access to "matches" in fwnode_graph_devcon_matches
- Updated the documentation in fwnode_connection_find_match(es)
- Add fwnode_for_each_typec_mode_switch macro
- Remove a duplicated dmesg in the helper
- Used IS_REACHABLE instead to guard the function signatures
- Removed the 4-lane binding in analogix,anx7625.yaml
- Reworded the desription for the mode-switch property
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
 drivers/base/property.c                       |  29 +-
 drivers/gpu/drm/bridge/Kconfig                |  20 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c     | 257 +++++++++++---
 drivers/gpu/drm/bridge/analogix/anx7625.h     |  22 +-
 drivers/gpu/drm/bridge/ite-it6505.c           | 314 ++++++++++++++----
 drivers/gpu/drm/display/Makefile              |   1 +
 drivers/gpu/drm/display/drm_dp_typec_helper.c | 108 ++++++
 drivers/platform/chrome/cros_ec_typec.c       |  10 +
 include/drm/display/drm_dp_helper.h           |  35 ++
 11 files changed, 836 insertions(+), 149 deletions(-)
 create mode 100644 drivers/gpu/drm/display/drm_dp_typec_helper.c

-- 
2.39.2.637.g21b0678d19-goog

