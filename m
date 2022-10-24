Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB4360A364
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiJXLz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbiJXLyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:54:10 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95AB4C2C9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:45:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e129so8452088pgc.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zcdfaNsoIuuSNF9XByhbeUp3KpNdfCPWzGZ8aF5nLxA=;
        b=A/SaFlQiUebp/U4yUjESResGqrVwntBISSfqBzWDzKJibVbtIVr9UUfU6mxLj07U3t
         BF1P1ziYSaSoZu2hLeXkqtIzAlvAh0MFneC+wQBMWmi0FH1LXXFBqHadJUpo8KeJTncO
         UfWe0DIEAPCTW/sCTy15HwE2CBjAb+Rx1eEUSB+NNH260sZc5OtfAVjOXussqn3KA347
         PpO/tyEscshRJ9N6nCBeacKW6fv3Tw1lcWUes4Zil4fK5WzarbbrLQTA4j7+JXjg1OB5
         Nl7VXtFCfuFWoaeikVJ/SxvLnxREoubYa0ceNbAiLW7yzBhF70OMrb+09Y3IJKqA+AuT
         576g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zcdfaNsoIuuSNF9XByhbeUp3KpNdfCPWzGZ8aF5nLxA=;
        b=UMwFockpIfsDFAoI37kkxrNKgQX93+luI2LNtPnCnQkpJFq5hHy6u0JxfZIMon/9SK
         m11Kf6Tk9dbaSPg57XpGMjKcAag//yhym80/5MZ62xkpRNi7VqfjeCwQVsb/PUzrpFUC
         lvD5VQn+jIOV4esiqBFkYdcp2Zpp1vPQ0q9vWIoCGgZ7S4EbNm4USQ6jYzIop+8za4R9
         x8e+TdrSnDCR2N66yR0dE4yTkjD0WPZ5gK/f2oQenl4AV8k4oprNEolNlVsJ+HzZ21Oq
         7SuH0pKrz+t0eMKt7Ben8S4TwJYynwpO8ftXe349tRLw3oExLCkYpzbS2e7alzwkuNMA
         3DKw==
X-Gm-Message-State: ACrzQf0MpbNyYGEdb7C6sGpz5TjLsAcEO7ASEWkHSOUiiP6JWo0MHz5z
        swfZJOV6MFCBH8ctM6BEpkl86XdhlsqEzzFq
X-Google-Smtp-Source: AMsMyM5stq/ljVzMueZdUgOUcwUqYp0qFBFo+CXciS0i44pLthcVHJASa5mVlU8sjRqgQycqku2BPA==
X-Received: by 2002:a63:2345:0:b0:463:7c74:73b with SMTP id u5-20020a632345000000b004637c74073bmr28176901pgm.39.1666611341111;
        Mon, 24 Oct 2022 04:35:41 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001830ed575c3sm19475075plh.117.2022.10.24.04.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:35:40 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Jonathan Woithe <jwoithe@just42.net>,
        Ike Panhc <ike.pan@canonical.com>,
        Daniel Dadap <ddadap@nvidia.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Mattia Dongili <malattia@linux.it>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Azael Avalos <coproscefalo@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Robert Moore <robert.moore@intel.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        ibm-acpi-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org,
        devel@acpica.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 00/22] Fallback to native backlight
Date:   Mon, 24 Oct 2022 20:34:51 +0900
Message-Id: <20221024113513.5205-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2600bfa3df99 ("ACPI: video: Add acpi_video_backlight_use_native()
helper") and following commits made native backlight unavailable if
CONFIG_ACPI_VIDEO is set and the backlight feature of ACPI video is
unavailable, which broke the backlight functionality on Lenovo ThinkPad
C13 Yoga Chromebook. Allow to fall back to native backlight in such
cases.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Akihiko Odaki (22):
  drm/i915/opregion: Improve backlight request condition
  ACPI: video: Introduce acpi_video_get_backlight_types()
  LoongArch: Use acpi_video_get_backlight_types()
  platform/x86: acer-wmi: Use acpi_video_get_backlight_types()
  platform/x86: asus-laptop: Use acpi_video_get_backlight_types()
  platform/x86: asus-wmi: Use acpi_video_get_backlight_types()
  platform/x86: compal-laptop: Use acpi_video_get_backlight_types()
  platform/x86: eeepc-laptop: Use acpi_video_get_backlight_types()
  platform/x86: fujitsu-laptop: Use acpi_video_get_backlight_types()
  platform/x86: ideapad-laptop: Use acpi_video_get_backlight_types()
  platform/x86: msi-laptop: Use acpi_video_get_backlight_types()
  platform/x86: msi-wmi: Use acpi_video_get_backlight_types()
  platform/x86: nvidia-wmi-ec-backlight: Use
    acpi_video_get_backlight_types()
  platform/x86: panasonic-laptop: Use acpi_video_get_backlight_types()
  platform/x86: samsung-laptop: Use acpi_video_get_backlight_types()
  platform/x86: sony-laptop: Use acpi_video_get_backlight_types()
  platform/x86: thinkpad_acpi: Use acpi_video_get_backlight_types()
  platform/x86: toshiba_acpi: Use acpi_video_get_backlight_types()
  platform/x86: dell-laptop: Use acpi_video_get_backlight_types()
  platform/x86: intel_oaktrail: Use acpi_video_get_backlight_types()
  ACPI: video: Remove acpi_video_get_backlight_type()
  ACPI: video: Fallback to native backlight

 Documentation/gpu/todo.rst                    |  8 +--
 drivers/acpi/acpi_video.c                     |  2 +-
 drivers/acpi/video_detect.c                   | 54 ++++++++++---------
 drivers/gpu/drm/i915/display/intel_opregion.c |  3 +-
 drivers/platform/loongarch/loongson-laptop.c  |  4 +-
 drivers/platform/x86/acer-wmi.c               |  2 +-
 drivers/platform/x86/asus-laptop.c            |  2 +-
 drivers/platform/x86/asus-wmi.c               |  4 +-
 drivers/platform/x86/compal-laptop.c          |  2 +-
 drivers/platform/x86/dell/dell-laptop.c       |  2 +-
 drivers/platform/x86/eeepc-laptop.c           |  2 +-
 drivers/platform/x86/fujitsu-laptop.c         |  4 +-
 drivers/platform/x86/ideapad-laptop.c         |  2 +-
 drivers/platform/x86/intel/oaktrail.c         |  2 +-
 drivers/platform/x86/msi-laptop.c             |  2 +-
 drivers/platform/x86/msi-wmi.c                |  2 +-
 .../platform/x86/nvidia-wmi-ec-backlight.c    |  2 +-
 drivers/platform/x86/panasonic-laptop.c       |  2 +-
 drivers/platform/x86/samsung-laptop.c         |  2 +-
 drivers/platform/x86/sony-laptop.c            |  2 +-
 drivers/platform/x86/thinkpad_acpi.c          |  4 +-
 drivers/platform/x86/toshiba_acpi.c           |  2 +-
 drivers/video/backlight/backlight.c           | 18 +++++++
 include/acpi/video.h                          | 21 ++++----
 include/linux/backlight.h                     |  1 +
 25 files changed, 85 insertions(+), 66 deletions(-)

-- 
2.37.3

