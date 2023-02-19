Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB76369C016
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 12:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjBSLqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 06:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjBSLqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 06:46:23 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2249AC673
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 03:46:18 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4PKNzm2ymnz9sQK;
        Sun, 19 Feb 2023 12:46:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1676807172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K+kWDPBvqhgCOkAg751UfyRZlB0vI5oXI8/N3dWFXV0=;
        b=vvnEvamWrQo1q8Bb1K5H9UfpI3lDkfmSWlsqLe9Hg9pstZZK2LsMuo22ORxSADSMyNxSZ/
        pZ2ucHMtplFzZCsgTl7tyZz8ZtmfcmfNv+d8tsuA2kdoTi5EsQaWTl92R6MuBUdwtRmfz+
        Ey/k4J4vMiouUm67oE4Zr5osbWVi+Uc+92572e4V9SUf6Ck7mfqmsn05s1Pe9RTM4LlZku
        kmL/S9UFRkR/TP4VpJPCHpTWuSeiAgb03X1/4qOeEXkJeDUZEqppC9/4zq0b1gwxYGdnJb
        0tPO2zWls8lztPfh+6gMS+CwtmM2sIeOuLcBFwpO3CsMH5lZEmlTRg9JqgjQPA==
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Ondrej Jirman <megous@megous.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM PANEL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Frank Oltmanns <frank@oltmanns.dev>
Subject: [PATCH 0/1] drm/panel: st7703: Fix vertical refresh rate of XBD599
Date:   Sun, 19 Feb 2023 12:45:52 +0100
Message-Id: <20230219114553.288057-1-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the XBD599 panel has a pixel clock rate that results in a
vertical refresh rate of ~55.3 Hz. This causes a slight visual
stuttering, for example on the PinePhone.

To address this, I adjusted the pixel clock rate to 74844 kHz. Instead
of using this hard coded value, I inserted the formula. This approach is
already in use by:
panel-jdi-fhd-r63452.c
panel-samsung-s6e88a0-ams452ef01.c
panel-asus-z00t-tm5p5-n35596.c
panel-ebbg-ft8719.c
panel-visionox-vtdr6130.c
panel-sony-tulip-truly-nt35521.c
panel-sharp-ls060t1sx01.c
panel-samsung-sofef00.c

To have a consistent procedure within panel-sitronix-st7703.c, I also
used the formula for the JH057N panel's clock. The value for JH057N was
already correct, so this change is purely cosmetic.

I do realize that I submitted three separate patches for the ST7703
within just a few days ([1], [2]). Should I re-submit all three patches
as a single patch set? These are my first contributions to the Linux
kernel, therefore, I kindly ask for forgiveness regarding any breach of
etiquette.

Thanks,
  Frank

[1] https://lore.kernel.org/all/20230211171748.36692-1-frank@oltmanns.dev/
[2] https://lore.kernel.org/all/20230213123238.76889-1-frank@oltmanns.dev/

Frank Oltmanns (1):
  drm/panel: st7703: Fix vertical refresh rate of XBD599

 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.39.1

