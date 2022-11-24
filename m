Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D05637EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKXR76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKXR75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:59:57 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614AD69AA9;
        Thu, 24 Nov 2022 09:59:56 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i64-20020a1c3b43000000b003d016c21100so4447885wma.3;
        Thu, 24 Nov 2022 09:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wFryhuzqqlfrdXm8Yqe5E1QW6Qi9B17446w+hn0n96Q=;
        b=LEYOK0dHustuLUDHHcTB+Blka+IkUMFLAk5sceqqAXbwR/fHgOJ8ZbpeSPDJnubZLP
         hc38ufRiCsnYSdPqCYCG76UZyFw+/W90abU5qAwqJfsqgIzf6GtcqhXi2wAH4ry/ifyi
         FytyuYp0sjEQ/+AbMTgUFvLg5wVhfbTkmSSvVHjA1K/cWisi34dBeEWVrqNqR8aJHBb8
         zraAPlEBeodHjKjm0C02vqnAawkR4vgY8KxzvDua/Z8iBDOF/1hk9OddxXnHiukVjgbc
         MM3Bbka37QFYelzXv7wwtdAQcIAXYVEhCP1ij1N2A3lfKhzsadiW/pOhcANoWusGOBW5
         g0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFryhuzqqlfrdXm8Yqe5E1QW6Qi9B17446w+hn0n96Q=;
        b=2xrH1HXoU/IswUG0H3VNxlxHS2k0xtXO8a2SNlxYtrWTfgUbjOh099i7RI9a+Mo0Sg
         78OcfUjStcM5di1YS3ODMUvAm/2ZGQOUd9A512RJyMkH0FHYXvbQrfldZbWYZcyDhHPc
         LKlGkBHp+0Cfoz3xUChbuJ7rxT/FM2/zDgo8kokcBwn3yALewpxDO37DsAblk7wB3N2O
         oY+xZe3UJ7gT/V6duNMfmoEcmZBoqR/jf2QzpNI0GXb3loL1FCOvu+Vx+DRkBQf63Wfp
         IheiQfYg1jzjl+jjBDDTIXi36ffU2H6/noyc4d//kLzi2yPc83wbaOYudkzEHSlTX/it
         IeyQ==
X-Gm-Message-State: ANoB5pm944RJSuZkgEOAfzZvo30MwMNzyjhR53wdOaMSOkUxGV6Nupfc
        yMFMzOQXUnEyW86e4SBGeuY=
X-Google-Smtp-Source: AA0mqf6NKrLGQaoCPEEtEULQxb/N1IQWGU26OzYoZlqaV4vK37zjZaEJU+AUim4ZE5eqTy5m3fH+0w==
X-Received: by 2002:a05:600c:4fd6:b0:3cf:d952:db2b with SMTP id o22-20020a05600c4fd600b003cfd952db2bmr8469774wmq.19.1669312794852;
        Thu, 24 Nov 2022 09:59:54 -0800 (PST)
Received: from localhost.localdomain ([94.73.35.229])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600c4f0100b003c6f3f6675bsm7094865wmq.26.2022.11.24.09.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:59:54 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH RESEND 0/1] HID: input: map battery system charging
Date:   Thu, 24 Nov 2022 18:59:36 +0100
Message-Id: <20221124175937.7631-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This patch adds support for reporting battery status (charging/discharging)
for devices with a charging usage in their HID descriptor:

	0x05, 0x85,         /*      Usage Page (Battery System),    */
	0x09, 0x44,         /*      Usage Page (Charging),          */

I tested it on Apple hardware (mouse, trackpad and keyboard) as well as
on UCLogic tablets with battery [1].

On other hardware (HID_DC_BATTERYSTRENGTH or digitizers with battery)
discharging should be reported for backwards compatibility.
I did my best to keep the old behaviour by adding KUnit tests; However,
I don't own any of those devices, so I'd appreciate any help testing
the patch from someone with the actual hardware.

Best wishes,
José Expósito

[1] https://lore.kernel.org/linux-input/20221029161240.15548-2-jose.exposito89@gmail.com/

José Expósito (1):
  HID: input: map battery system charging

 drivers/hid/.kunitconfig     |  1 +
 drivers/hid/Kconfig          |  1 +
 drivers/hid/hid-input-test.c | 80 ++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-input.c      | 36 +++++++++++++++-
 include/linux/hid.h          |  2 +
 5 files changed, 118 insertions(+), 2 deletions(-)
 create mode 100644 drivers/hid/hid-input-test.c

-- 
2.38.1

