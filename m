Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0542B661150
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 20:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjAGTT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 14:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjAGTTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 14:19:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8A733D68
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 11:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673119114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=j4lvL16cX5Ecc0dt+ze79o67iI/xFSw7pgX0Q6ktKIc=;
        b=RQVDyY+HPxddoXvnIMW2da976YrNmSdtswAtVjc9ihYnpdYw/mJiQfoW+gUfh+xnJLt3YW
        FICi8KdA08Dn0yNMpei7YD77FPpsu4cbeC4gCIFaxYGfMVxPBpAX+YgRU6SOuT4eXnVBsK
        cseYGOb+RI574vvKWQ8g+e0m09PiELw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-672-U-wGKr60OweIehLEnq1Buw-1; Sat, 07 Jan 2023 14:18:33 -0500
X-MC-Unique: U-wGKr60OweIehLEnq1Buw-1
Received: by mail-wm1-f71.google.com with SMTP id i7-20020a05600c354700b003d62131fe46so4644952wmq.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 11:18:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4lvL16cX5Ecc0dt+ze79o67iI/xFSw7pgX0Q6ktKIc=;
        b=XpmbKnQZM502Gcj3TB5BL0tTHzIsZfT2dZYvv1KoUVn0SMAthOo0D0NXNGHzEw+1yE
         ht2jmelyCAIU+Loow+4ssmxDkrkUoT4IzNboF5BU/F4uUgtUddz0gZoJ5eNk0hXQXSE+
         LIcnK3rS5J1GgyOJPvDiX6bClo9WDhTeSF0DdWfHPJdk85Fm7OJ7VKyAWqkwC7H53UuP
         4toVj3RmkrxOIpT8JS3wpPjv0CxtTzQWGTypqtF/VMoA1aADuHBlbvrtY30Cs8xkTNcC
         mgk7UK64AIE06zhCYaGrGp4j7X/OX5QwASY0PtfVrszR/PjFXwSxHLLsJqF+7LfRQuFF
         Gs0Q==
X-Gm-Message-State: AFqh2krRZDFTSAABf3wjedMKA2nFEXDIaE7ngcxIEs/v2BpIC+WHtuBb
        fGYrjWAfxVtmOtYphc78Me/BypuCG8wrIs7F52dc2R7rMCdt/10p7qzgT8GQqrj4kgLKHNF7vF9
        pVtgwf+540bsI193tjLLT5lpZ2pco1puNNBAzKxl9XDO+c5hnlw5krQkdZS4THt8FxrKnqlA6GL
        E=
X-Received: by 2002:a5d:5b07:0:b0:270:f10a:b90a with SMTP id bx7-20020a5d5b07000000b00270f10ab90amr36172332wrb.6.1673119111948;
        Sat, 07 Jan 2023 11:18:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsnFHfGQHY5z41Y/XajscECribjEcj8eAoYdGQZoRswR+RMReVfcV5D+H2q7ZWXCx6inx7cUQ==
X-Received: by 2002:a5d:5b07:0:b0:270:f10a:b90a with SMTP id bx7-20020a5d5b07000000b00270f10ab90amr36172316wrb.6.1673119111661;
        Sat, 07 Jan 2023 11:18:31 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bp28-20020a5d5a9c000000b00273cd321a1bsm4553900wrb.107.2023.01.07.11.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 11:18:31 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Ondrej Jirman <megous@megous.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 00/13] drm/panel: Make panel drivers use existing DSI write macros
Date:   Sat,  7 Jan 2023 20:18:09 +0100
Message-Id: <20230107191822.3787147-1-javierm@redhat.com>
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

This is a v2 that addresses issues pointed out by Sam Ravnborg in the v1:

https://lore.kernel.org/lkml/20221228014757.3170486-1-javierm@redhat.com/

The changes are quite trivial but I've only tested this with allmodconfig
and `make M=drivers/gpu/drm/panel/` so please review and testing would be
highly appreciated.

Best regards,
Javier

Changes in v2:
- Fix identations and a usage discrepancy in one driver (Sam Ravnborg).

Javier Martinez Canillas (13):
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
 .../gpu/drm/panel/panel-boe-bf060y8m-aj0.c    |  42 +-
 drivers/gpu/drm/panel/panel-elida-kd35t133.c  |  46 +-
 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c  |  58 +--
 .../drm/panel/panel-leadtek-ltk050h3146w.c    | 106 +++--
 .../gpu/drm/panel/panel-mantix-mlaf057we51.c  |  24 +-
 drivers/gpu/drm/panel/panel-novatek-nt35950.c |  14 +-
 .../panel/panel-samsung-s6e88a0-ams452ef01.c  |  44 +-
 drivers/gpu/drm/panel/panel-samsung-sofef00.c |  24 +-
 .../gpu/drm/panel/panel-sharp-ls060t1sx01.c   |  19 +-
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 341 +++++++--------
 .../panel/panel-sony-tulip-truly-nt35521.c    | 398 +++++++++---------
 .../gpu/drm/panel/panel-xinpeng-xpp055c272.c  | 112 +++--
 13 files changed, 594 insertions(+), 730 deletions(-)

-- 
2.38.1

