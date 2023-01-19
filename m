Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D5C67413B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjASSth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjASSta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:49:30 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323FD8BAAD;
        Thu, 19 Jan 2023 10:49:19 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id br9so4578637lfb.4;
        Thu, 19 Jan 2023 10:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0tYQWEbUqqtKGBVD+CO4A492dYz/WsYLmCYf41kZNY0=;
        b=n4+uFCk4bo7SZ7RmgW5WWFS2/uh17oFHi2Wu9OV80FtxP/hAJM9pjaHBJ5mpNMX4zp
         iqUbr25lWZiyYIdkoLZHprxJ4JDQEiSqI7v0q/QYCLR3UBEKWET2ObvRHhWUKDyvsB2s
         YObPiYCnEY0r7z+Keof0aqnZ1Zi5fNiEVxqf5FsInWplXEqz/kqY1BirhVrF1e8YKUuq
         fkW05KcHdREfG9ceIUhO+7zrn3HBd5vnYGE0aAo2VdY+Cnz7OlDJj/JN5qfDJUxYqRBB
         CADly1MC2ftqbiAlNtjs0w5MBnay+SAahDiPJ7cUj9iSDgEtV2qFXwdkpcv6hBBR7nTq
         rkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tYQWEbUqqtKGBVD+CO4A492dYz/WsYLmCYf41kZNY0=;
        b=cnKNRY5ih5ndBcpAKspYMg6PguowkUhFkeLn8/45mT7q0/8O/sAxy6DOO3CkEP7VJ/
         aHZYc2L3R46MSiPzS1Gxj25PQFvGHb+mdb7H9j8fMci/AEMDoEVBjtciKJ5acg6OWPWn
         IkIwSKNZqWHoRTduBiDGaoKbq0OE1YBvs6IIhty/eFD9eFoTsECimNiEnE1/a7HcbRFC
         k7ARO03dsJqRutYKqLOqYNIcTPM6wUKQfR68B2JRPfsyOJV9tUaN3pw4n5TlI26034jO
         0muFVFTjvugn0tzQ6IxzJqMJh0mbhH94AQMpeEvg5LMfK0b/Kofbf8xXFy9OnunVmvaZ
         519A==
X-Gm-Message-State: AFqh2kr/kUm1ZfHJ4CG2aGeVqvQ7mM+izSOwJ+dXX1M5bE58Yx/IAKN1
        s/F8I8Lj3Od3d094l+EyCS4=
X-Google-Smtp-Source: AMrXdXsjFhKWKq7za7X1ZzjrMsEeb9ETu3sg+Kbqp8I3AZi5X5TNNlg+CZgXDBTXn0b9+8w2zTN+zw==
X-Received: by 2002:ac2:57cd:0:b0:4cd:afbf:c206 with SMTP id k13-20020ac257cd000000b004cdafbfc206mr2700092lfo.22.1674154157481;
        Thu, 19 Jan 2023 10:49:17 -0800 (PST)
Received: from U19.ag.local (static.187.76.181.135.clients.your-server.de. [135.181.76.187])
        by smtp.gmail.com with ESMTPSA id b31-20020a0565120b9f00b004d30752a561sm2112737lfv.298.2023.01.19.10.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 10:49:16 -0800 (PST)
From:   Alibek Omarov <a1ba.omarov@gmail.com>
Cc:     a1ba.omarov@gmail.com, alexander.sverdlin@siemens.com,
        macromorgan@hotmail.com, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Frank Wunderlich <frank-w@public-files.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] drm/rockchip: lvds: add support for rk356x
Date:   Thu, 19 Jan 2023 21:48:02 +0300
Message-Id: <20230119184807.171132-1-a1ba.omarov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series adds support for the LVDS controller on the Rockchip RK3566 and
RK3568. First patch adds the support in rockchip-lvds.c driver, setting all
the needed GRF registers. Second patch adds device tree bindings, and third
patch adds a note in the documentation.

LVDS controller on rk356x does share DSI DPHY with MIPI DSI, and all
groundwork on enabling it is done by Chris Morgan.

Tested on Autogramma Monitor RockChip, custom board based on Radxa Rock 3
Computing Module Plus.

Alibek Omarov (3):
  drm/rockchip: lvds: add rk3568 support
  arm64: dts: rockchip: rk356x: add LVDS bindings
  dt-bindings: display: rockchip-lvds: add compatible string for RK3568

 .../display/rockchip/rockchip-lvds.txt        |   1 +
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  25 +++
 drivers/gpu/drm/rockchip/rockchip_lvds.c      | 144 +++++++++++++++++-
 drivers/gpu/drm/rockchip/rockchip_lvds.h      |  10 ++
 4 files changed, 173 insertions(+), 7 deletions(-)

-- 
2.34.1

