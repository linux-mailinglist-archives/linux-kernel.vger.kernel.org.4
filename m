Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B3F6E387D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjDPNII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjDPNIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:08:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4122D1FE7;
        Sun, 16 Apr 2023 06:08:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sz19so295060ejc.2;
        Sun, 16 Apr 2023 06:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681650485; x=1684242485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+KDQHaLJ8qvbp2xFnk+s991bcH9UQHReavTLwQ6GCys=;
        b=PvSQWosWKH48ypxeTXgJCmKox+JHvvMf+LZk6SevC4ngYReeufXYTIHNGMUZfZfSjr
         auurTl1TGZl7LPIONks3oRy9SCzKZSV38dN/tphwpUTulfDlKv9yZhVRoR8KPvUcwqtT
         Tq/MkPVG//+ns5l/E3/mb269L/qf5DOgHCKzmWutsP9D4Z8Y5L1mm0sXryzFMmBWQ1dl
         /ifXmvQR5bw02PuCviKJyn4jZmpZsATmbZP34vwmIehJFu/IReMpCClzc1L9LWP8I36Q
         Qe9GEFok/kLF18v+wLtA2+dGQaIOHzaU1dfwBqmRG9h/GnGeXQrDqShn6R0qukTRyxU3
         oZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681650485; x=1684242485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KDQHaLJ8qvbp2xFnk+s991bcH9UQHReavTLwQ6GCys=;
        b=h2Lr2QxUtI2D+I/NMIyN5LxrLRhVcPvPQjivuTeURHh3UkUOTnD1YrsDLZdcOhQWmO
         smLBhFBvVBUhPehZ3XPqucVTVMhgFcl71SAevA39eeZcXBzrxF34jt8J8IUdv163jxnc
         INHrIFr1ihHNPa4NjQutw318BU/Yy/0BofPFNQGqJP+eA/DQEJMOncjc0Yw01HRaA8EP
         ZKvHhnOFG4eXbrDNd0YPE6GLigDYJJ717qjMp8Omx0eNXmONNhunWFIhhRMzV2B+xF8Z
         dWBSaUKlR+OxAkVwwj/X3xuaSYnb15W1fj0CNA5wccXOeCeILFpvzYxWuFfRknr81/z2
         WQUQ==
X-Gm-Message-State: AAQBX9c8EldduJlnfbZf+vfWQ1ufs/mkB7Nn8mzaOjYhfzwK0/ii3fJX
        RW2xBmdSHcoAcZ8HFF+izsLTTtcGAvCR2A==
X-Google-Smtp-Source: AKy350aKX3vg6Kp0KkHCRmesMo5qpwWn9CeQ7h6ufV0GJX8sTcxsE6O60TgF+JbUMsYUlqOtfRwDZA==
X-Received: by 2002:a17:906:2412:b0:93e:908d:cfe2 with SMTP id z18-20020a170906241200b0093e908dcfe2mr5314054eja.0.1681650484403;
        Sun, 16 Apr 2023 06:08:04 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id l12-20020a056402344c00b00504803f4071sm4511609edc.44.2023.04.16.06.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 06:08:03 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     thierry.reding@gmail.com
Cc:     sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v2 0/3] Add Samsung S6D7AA0 panel controller driver
Date:   Sun, 16 Apr 2023 15:07:32 +0200
Message-Id: <20230416130735.30965-1-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds initial support for Samsung S6D7AA0-based panels.
Currently, only the S6D7AA0-LSL080AL02 panel used in the Samsung
Galaxy Tab 3 8.0 family of tablets is supported; other panels can be
added in the future.

Changed in v2:
 - Added commit messages for dt-bindings and MAINTAINERS entry commits
 - dt-bindings: Applied suggestions from Krzysztof Kozlowski
 - driver: Removed unused panel_name property from desc struct

Artur Weber (3):
  dt-bindings: panel: Add Samsung S6D7AA0 LCD controller bindings
  drm/panel: Add Samsung S6D7AA0 panel controller driver
  MAINTAINERS: Add entry for Samsung S6D7AA0 LCD panel controller driver

 .../display/panel/samsung,s6d7aa0.yaml        |  51 +++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/panel/Kconfig                 |   7 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 395 ++++++++++++++++++
 5 files changed, 460 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c

-- 
2.40.0

