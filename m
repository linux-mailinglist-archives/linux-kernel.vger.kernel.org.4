Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FFF70D744
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbjEWIX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbjEWIWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:22:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B92110E3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:19:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1q1NFB-00042k-Vn; Tue, 23 May 2023 10:19:46 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <j.zink@pengutronix.de>)
        id 1q1NFA-002CaN-MA; Tue, 23 May 2023 10:19:44 +0200
Received: from localhost ([::1] helo=dude03.red.stw.pengutronix.de)
        by dude03.red.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <j.zink@pengutronix.de>)
        id 1q1NF9-006uEf-M8; Tue, 23 May 2023 10:19:43 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
Subject: [PATCH v2 0/3] Support non-default LVDS data mapping for simple
 panel
Date:   Tue, 23 May 2023 10:19:40 +0200
Message-Id: <20230523-simplepanel_support_nondefault_datamapping-v2-0-87196f0d0b64@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABx3bGQC/03OQQqDMBCF4atI1k21CS3Sq5QSxjjRAU2GTJSCe
 PdqV13+i/fxNiWYCUU9q01lXEkoxSPMpVJ+hDigpv5oZRpjm7uxWmjmCRkiTk4W5pSLiyn2GGC
 ZiuuhwAzMFAd9s94Gg2Da0KoD7EBQdxmiH09yfVxtXRKTr/9Q3S2iQ8ozlHPDGQN9fgdf733/A
 uWrwz+wAAAA
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        patchwork-jzi@pengutronix.de, kernel@pengutronix.de,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johannes Zink <j.zink@pengutronix.de>
X-Mailer: b4 0.12.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some LVDS panels, such as the innolux,g101ice-l01 support multiple LVDS
data mapping modes, which can be configured by strapping a dataformat
pin on the display to a specific voltage.

This can be particularly useful for using the jeida-18 format, which
requires only 3 instead of 4 LVDS lanes.

This series moves the data-mapping property for LVDS panels in a
separate file and optionally adds it to simple-panel when matching to
the innolux,g101ice-l01 compatible. This property allows to override
the default data mapping set in the panel description in simple-panel.

The last patch in this series actually adds the driver support for
parsing the data format override device tree property and modifying the
corresponding values for bit per color and media bus format in the panel
descriptor.

Best regards
Johannes

---

Changelog:

v1 -> v2:  - dt bindings: Worked in Rob's review findings (thanks for your
             review), refactored to use common include instead of duplication
           - driver: added missing error unwinding goto, as found by Dan
             Carpenter's test robot:
             Reported-by: kernel test robot <lkp@intel.com>
             Reported-by: Dan Carpenter <error27@gmail.com>
             Link: https://lore.kernel.org/r/202304160359.4LHmFOlU-lkp@intel.com/

To: David Airlie <airlied@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Thierry Reding <thierry.reding@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: patchwork-jzi@pengutronix.de
Cc: kernel@pengutronix.de
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Johannes Zink <j.zink@pengutronix.de>

---
Johannes Zink (3):
      dt-bindings: display: move LVDS data-mapping definition to separate file
      dt-bindings: display: simple: support non-default data-mapping
      drm/panel-simple: allow LVDS format override

 .../bindings/display/lvds-data-mapping.yaml        | 84 ++++++++++++++++++++++
 .../devicetree/bindings/display/lvds.yaml          | 75 +++----------------
 .../bindings/display/panel/panel-simple.yaml       | 26 ++++++-
 drivers/gpu/drm/panel/panel-simple.c               | 39 +++++++++-
 4 files changed, 155 insertions(+), 69 deletions(-)
---
base-commit: 33a86170888b7e4aa0cea94ebb9c67180139cea9
change-id: 20230523-simplepanel_support_nondefault_datamapping-13c3f2ea28f8

Best regards,
-- 
Johannes Zink <j.zink@pengutronix.de>

