Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABCA6571C2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiL1Bsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiL1Bss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:48:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F4AE37
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672192088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=P5KKuoIGAE6MpY1AzB0SKM8BM5G/7Bvgi1+Zq+kEeaY=;
        b=RSMpeccVYd7arYys5YhxZTgOI9w8MSV0kbmkIFCTvPpEU29MutQUWaBqq+udXSlzddyoTu
        JAOOUEGGlSv4mjvQh/mMjd0f345yNCL6yoe0fdzzymyP5ibl3nm6Sb/CSS7ndXNZGbjGlQ
        a1gc5teUSSc7Ofe1DuG0+avvwrM5Qgo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-94-FVhK1hWeNDKZItgM9cu1Sw-1; Tue, 27 Dec 2022 20:48:06 -0500
X-MC-Unique: FVhK1hWeNDKZItgM9cu1Sw-1
Received: by mail-wm1-f70.google.com with SMTP id q6-20020a05600c2e4600b003d211775a99so6023111wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5KKuoIGAE6MpY1AzB0SKM8BM5G/7Bvgi1+Zq+kEeaY=;
        b=O7etsvLGSxnrqqZ54jwy4vC1Risu3I4EUpgyKZ69c5cybLO5/3neNwOeCQQ9vNXIGM
         vtRkSMrpZMIheN270nCfT0oXiubZVBD7AREMk/UK4zqR6BOvdwzXQ2hmtslXtCPpPfxH
         ODoznK2kIhrJpGyRO0dlJqj6cD6xzAlV8rADA099DdMu9a1w9WnA4TjYr1KPNCJAcyZP
         G3bKgMhRdsnkpNhlHj74/YVkSG1UpevcBGEEanL8bTvzyRQCTgzl2hbgo3dcxM/+vOgM
         xbWXeaj5QJGzmMNZRgaUzpqQjHXLAnxZrgO5t8fKaPA//VBRI9Twl2L2hJYEvVHIgV6F
         k0ew==
X-Gm-Message-State: AFqh2koOEIYSIwU3NnMSCxTR5SZ4jbP6y49Ll2sG07MlHjpMaROqPJzv
        DpooRNlOAXRDWpzKM5+hbq8wLfucdcfOPsS20slabavh5gkgmztjifXiJZtgG0/OKdwxV7EtOJx
        t575NTlTNDdY7hONAsn5ssSgd/06Yo6FxbI6Zs5DnMs97EiCGoTm3MQTjTeSCQooUpy5GdM5gGQ
        k=
X-Received: by 2002:adf:aa89:0:b0:248:2d6e:aa3c with SMTP id h9-20020adfaa89000000b002482d6eaa3cmr17806154wrc.58.1672192085024;
        Tue, 27 Dec 2022 17:48:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvvPMePoymVldOmzVyLZLGayM8TTqf0I+K+2FRLyH9T84ePvZEMQyZLl7/owZtTQ0WURql2OQ==
X-Received: by 2002:adf:aa89:0:b0:248:2d6e:aa3c with SMTP id h9-20020adfaa89000000b002482d6eaa3cmr17806138wrc.58.1672192084746;
        Tue, 27 Dec 2022 17:48:04 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k16-20020a056000005000b002258235bda3sm14158873wrx.61.2022.12.27.17.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:48:04 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 00/14] drm/panel: Make panel drivers use existing DSI write macros
Date:   Wed, 28 Dec 2022 02:47:43 +0100
Message-Id: <20221228014757.3170486-1-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series contains cleanups for DRM panel drivers that define their own
DSI write macros instead of using what's already in <drm/drm_mipi_dsi.h>.

The changes are quite trivial but I've only tested this with allmodconfig
and `make M=drivers/gpu/drm/panel/` so please review and testing would be
highly appreciated.

Best regards,
Javier


Javier Martinez Canillas (14):
  drm/mipi-dsi: Add a mipi_dsi_dcs_write_seq() macro
  drm/panel-asus-z00t-tm5p5-n35596: Drop custom DSI write macros
  drm/panel-sitronix-st7703: Drop custom DSI write macros
  drm/panel-leadtek-ltk050h3146w: Drop custom DSI write macro
  drm/panel-elida-kd35t133: Drop custom DSI write macro
  drm/panel-boe-bf060y8m-aj0: Drop custom DSI write macro
  drm/panel-novatek-nt35950: Drop custom DSI write macro
  drm/panel-jdi-fhd-r63452: Drop custom DSI write macros
  drm/panel-samsung-s6e88a0-ams452ef01: Drop custom DSI write macro
  drm/panel-samsung-sofef00: Drop custom DSI write macro
  drm/panel-sharp-ls060t1sx01: Drop custom DSI write macro
  drm/panel-mantix-mlaf057we51: Drop custom DSI write macro
  drm/panel-sony-tulip-truly-nt35521: Drop custom DSI write macro
  drm/panel-xinpeng-xpp055c272: Drop custom DSI write macro

 .../drm/panel/panel-asus-z00t-tm5p5-n35596.c  |  96 ++---
 .../gpu/drm/panel/panel-boe-bf060y8m-aj0.c    |  28 +-
 drivers/gpu/drm/panel/panel-elida-kd35t133.c  |  34 +-
 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c  |  50 +--
 .../drm/panel/panel-leadtek-ltk050h3146w.c    |  64 ++--
 .../gpu/drm/panel/panel-mantix-mlaf057we51.c  |  24 +-
 drivers/gpu/drm/panel/panel-novatek-nt35950.c |  14 +-
 .../panel/panel-samsung-s6e88a0-ams452ef01.c  |  24 +-
 drivers/gpu/drm/panel/panel-samsung-sofef00.c |  24 +-
 .../gpu/drm/panel/panel-sharp-ls060t1sx01.c   |  19 +-
 drivers/gpu/drm/panel/panel-sitronix-st7703.c |  83 ++---
 .../panel/panel-sony-tulip-truly-nt35521.c    | 348 +++++++++---------
 .../gpu/drm/panel/panel-xinpeng-xpp055c272.c  |  44 +--
 include/drm/drm_mipi_dsi.h                    |  16 +
 14 files changed, 374 insertions(+), 494 deletions(-)

-- 
2.38.1

