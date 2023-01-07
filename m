Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE4F660DC4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 11:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjAGKXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 05:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjAGKWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:22:43 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E1F6B585
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 02:22:41 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so7784497pjj.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 02:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M5R04EwX4eIZOZILHF8zQrZe1x1GS9dIPxgkF6+Qqr0=;
        b=akf9h+6HPph8LYoUpBWnZE9ueCAAVE7fkGGFnOW7f5vGFH7ccqvIb67QKgIwFG3F4H
         EiX0jKlN3C+vDWVOHTROt6baus0ESTgsqcxJ90Jw1vlrcNBJxPbtnVZwY2HZCysHMJX6
         KE+dlRVIOe8DDOBhRoX7Hr/sOP0lHvlasEcaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5R04EwX4eIZOZILHF8zQrZe1x1GS9dIPxgkF6+Qqr0=;
        b=OaSjhj14B74WGbO7XSMrWNzsdIQ3jsfH2ry3Xh+r5ITWeCv4MQR8dTS0d5Kl3J6h/S
         58iNZIx+KKvv0454k1yEFgjIrqqRreRNqZk4u6xVyn/w4xMJj8NMAVNP1qSxrEUdIw8T
         FWPjkxWU2YLlsKftLxJhmCTL8vfrZMNJm0Yqeqk9dhHnTOtqOj1NQKJJoXclUrsJlH6U
         gg4H+FYZvRnMICkEcfvmx+PsikMcRlc2zR8+UDwC8asgfV6uw6KZ9q+Ew8EYvH1sLSlj
         x2yeMrL+nT+NLbjtpl063y5z14fglmXTMvA1Q0P7RHs4R428dDFBEJmxCNUqy2PLRrFQ
         ZKeg==
X-Gm-Message-State: AFqh2kpny0Lc3yl0AjRyVJFridZCRjcNVI++BKVeY04nkl/mJoW9RlAl
        Xsdh3uqI88y2Kr2QpU9/6H8enQ==
X-Google-Smtp-Source: AMrXdXsCanC85OIBD7HFU0hQjEKbk7kiLL3g+5Cn5NOlUfjTVfcWHqQr/B+TqYO21un27l3PbdCEtg==
X-Received: by 2002:a17:902:b495:b0:18c:cde:fddb with SMTP id y21-20020a170902b49500b0018c0cdefddbmr55110444plr.65.1673086960970;
        Sat, 07 Jan 2023 02:22:40 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:180d:95e8:f4:84fb])
        by smtp.gmail.com with ESMTPSA id b1-20020a170903228100b001892af9472esm2366362plh.261.2023.01.07.02.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 02:22:40 -0800 (PST)
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
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Xin Ji <xji@analogixsemi.com>,
        Pin-yen Lin <treapking@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen Chen <allen.chen@ite.com.tw>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        chrome-platform@lists.linux.dev,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, devicetree@vger.kernel.org,
        Marek Vasut <marex@denx.de>, linux-acpi@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: [PATCH v8 0/9] Register Type-C mode-switch in DP bridge endpoints
Date:   Sat,  7 Jan 2023 18:22:22 +0800
Message-Id: <20230107102231.23682-1-treapking@chromium.org>
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

v7: https://lore.kernel.org/all/20230105132457.4125372-1-treapking@chromium.org/
v6: https://lore.kernel.org/all/20221124102056.393220-1-treapking@chromium.org/
v5: https://lore.kernel.org/linux-usb/20220622173605.1168416-1-pmalani@chromium.org/

Changes in v8:
- Fixed the build issue when CONFIG_TYPEC=m
- Fixed some style issues
- Fixed the subject prefixes for the bindings patches
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
  dt/bindings: display: bridge: it6505: Add mode-switch support
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
 drivers/gpu/drm/bridge/analogix/anx7625.c     | 101 +++++++++++++-
 drivers/gpu/drm/bridge/analogix/anx7625.h     |  13 ++
 drivers/gpu/drm/bridge/ite-it6505.c           | 119 +++++++++++++++-
 drivers/gpu/drm/display/drm_dp_helper.c       | 132 ++++++++++++++++++
 drivers/platform/chrome/cros_ec_typec.c       |  10 ++
 include/drm/display/drm_dp_helper.h           |  16 +++
 11 files changed, 591 insertions(+), 29 deletions(-)

-- 
2.39.0.314.g84b9a713c41-goog

