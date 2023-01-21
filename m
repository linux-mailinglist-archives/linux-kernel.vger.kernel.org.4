Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B950676759
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 17:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjAUQY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 11:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUQY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 11:24:26 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAA424489;
        Sat, 21 Jan 2023 08:24:25 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso7797812wmc.4;
        Sat, 21 Jan 2023 08:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YN0RgsGY5sjGwWchYqHougYTE34oL9zgVxdSvXbiA+I=;
        b=axs0MMcnoNP58RZQ0NnQKFxcaprb/RIXNjgNOzL6Ntr6HXXK5XkH+IjMLEIe1BQ4t8
         uHU32xccS8zpmJt+2inu9E7omuQg8IsrTKOWjylFTchtEoYlrV/md/E4WjmdRqztUPui
         CLjVRAJBnA+zyQPh8+2hSnwDtjY6YRsUvSaGrglIBM+iZUbGR2z1v7hcurAuo5hZrbab
         JVdPO7ZUTqBeEzHlliyEl/+A5lZroKlSqIxE17QDMJkyBCRnhlW007rlHe/e3d+PPKDi
         IR491Fz2OFXvByAedeasXzfLAAXDlO3AZZfjKogGLYLGis7ILZwWw5Kztkv1ce6Mr1uU
         BAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YN0RgsGY5sjGwWchYqHougYTE34oL9zgVxdSvXbiA+I=;
        b=MBygHj5JxIzv7xiXh+ZaoZFStS3MakwBpscid8nTWPLNS5b5nQtUUTM+QcGLeEljOj
         dQMzOecrac5CsRHXDfEgXt+vtRH4AaU9Kd/pcs2UTDksdOvCpg3+JSnat9zGoiDBZ1yT
         Opig0jAvkM3C1Z/IgcN8BZrZYfHd/+dqrnp9YsdKhq5XnqMgifmes80Ym0AtGTSSGHD5
         W8VRgseKHgdPnUedDFpdN4vHwJJTif09Ml00V7UXbhlTr6oAqkbCCzMTfY2L60eVumuf
         C4l4a0Mv8yC1d46wq9RKGlgk6tquCWua+FM+2hSytY6GienFUH92nMtXiddVIbmly7na
         zywQ==
X-Gm-Message-State: AFqh2kpLQbePcQHhiepbu3IpjnRNBCmYwWu4LiMiB3HO8/dz/cMWF237
        hly4XOVPbm14gzpPALHj628=
X-Google-Smtp-Source: AMrXdXueG+30f15FM6ZNJFdngtP8IrOmcwx4tufP2MpKVjvv5woJcynb6f9jfv42oBWUVemFbct+Sg==
X-Received: by 2002:a05:600c:1604:b0:3c6:e61e:ae74 with SMTP id m4-20020a05600c160400b003c6e61eae74mr19145049wmn.4.1674318263594;
        Sat, 21 Jan 2023 08:24:23 -0800 (PST)
Received: from localhost.localdomain (2a02-8428-46a0-7c01-43c0-f52a-beed-541b.rev.sfr.net. [2a02:8428:46a0:7c01:43c0:f52a:beed:541b])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003db30be4a54sm5831443wms.38.2023.01.21.08.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 08:24:23 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul@crapouillou.net,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH v4 0/2] Add support for the AUO A030JTN01 TFT LCD
Date:   Sat, 21 Jan 2023 17:24:17 +0100
Message-Id: <20230121162419.284523-1-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.39.0
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

Changes since v3:
  Reworked the few init registers that are used for hblk, vblk and standby
  Use of dev_err_probe() instead of dev_err()
  priv->panel_info = spi_get_device_match_data(spi);

  restored spi node to dt-bindings that was missing in v3
----

Changes since v2:
 - added macros for stanby mode (untested, please review @pcercuei)
 - added SPI table_id
 - changed description in the bindings to describe the hw more

Changes since v1:
- fixed the dt-bindings maintainer email adress
- dropped backlight, port, power-supply and reset-gpios as they're
  provided by panel-common.yaml as pointed by Krzysztof Kozlowski
- changed reg: true to reg : maxItems: 1


Christophe Branchereau (1):
  drm/panel: Add driver for the AUO A030JTN01 TFT LCD

Paul Cercueil (1):
  dt-bindings: display/panel: Add AUO A030JTN01

 .../bindings/display/panel/auo,a030jtn01.yaml |  60 ++++
 drivers/gpu/drm/panel/Kconfig                 |   8 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-auo-a030jtn01.c   | 308 ++++++++++++++++++
 4 files changed, 377 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-auo-a030jtn01.c

-- 
2.39.0

