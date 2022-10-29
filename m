Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC066122B7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJ2MEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJ2MEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:04:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132F8A449;
        Sat, 29 Oct 2022 05:04:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so5372101wmb.0;
        Sat, 29 Oct 2022 05:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxceK4h9km4GtO20VnsGtzfG02HWM3iZYATl3ehVRaM=;
        b=FWIbQyJhzY7HCJanl24skL2GSGNxq6sAVg1aer2Wqb/acbszlNYVkq16F4OOMoq+AV
         xMNccTxQ+q7rgmZjvE2ShT+0gMS1adXEw1HeBWvAd/DmL9jmKRRSyuYElTFIin6kkcwL
         ovzthrlffpvRDpQ86beWWHGFCehKjlv3ccF/S4Eq/UfJgSyqg2myipJ5+er06pBnjbSL
         1U8gWIXIB2AhyjEqWG+HMNxitZr+YRnXbwCaZ8rRHNrxjaDGIEVE5LLzLfsS/UepvZ27
         a3uMEE+M/jJaY9DgSfhlKLeX708197Ah67A3s9zkJzBI0DukTBtxmIHYnQGPNrSIShY4
         4T4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxceK4h9km4GtO20VnsGtzfG02HWM3iZYATl3ehVRaM=;
        b=VdTDVHe3hyWhjJL6BBWg9jFjOYUCnb0r3aD0XQ6MCJvXl52haigNlaeLNmFeKXW17k
         r1NXHUG7WWjYxigOh/YHiH/hkuOcMCgyw6Rft8v1oC+k07zIZzPQYL/StEefYlhltflA
         8m3t54v1p/dUDKI/36NnAMqnAcTQrIqy4J2CnIw0dJ5WD2LuXqf6kQzSCgE9KXGA3jPR
         FfUvNEgIzilVJ+KqkAgznxa27s6eXY+kjJRdOKozD0g+7so7+A87aXbBnCTLkaaQei6S
         2PVzj35mFfxagOvoXsEmP6C8qO6/PNK4KPzRJ6TMWbiitSQbljlinNWnMbzsJAe6lFhr
         DXkQ==
X-Gm-Message-State: ACrzQf3pPhjDH2WAR+hE4UbUb8qOIDrBc00Ax8oaG7zD8Ln5GD+Cr8qx
        E5UkLkJ/V2SR/g4Y+J/nQYGsIJbKf7BUTQ==
X-Google-Smtp-Source: AMsMyM54NGcIXLjs4cTJiBgHJMv72kMp4FYEhPZr09NXVbmP7g6ReX9ZGhef9J1RLW4V3OVnU6ktnA==
X-Received: by 2002:a05:600c:4f87:b0:3cf:693b:3386 with SMTP id n7-20020a05600c4f8700b003cf693b3386mr876608wmq.55.1667045067861;
        Sat, 29 Oct 2022 05:04:27 -0700 (PDT)
Received: from eray-Lenovo-Z50-70.. ([188.132.247.187])
        by smtp.googlemail.com with ESMTPSA id z17-20020a05600c0a1100b003b492753826sm1472439wmp.43.2022.10.29.05.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 05:04:27 -0700 (PDT)
From:   =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ike.pan@canonical.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, pobrn@protonmail.com,
        =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
Subject: [PATCH v2 3/7] platform/x86: ideapad-laptop: Report KEY_CAMERA_ACCESS_TOGGLE instead of KEY_CAMERA
Date:   Sat, 29 Oct 2022 15:03:08 +0300
Message-Id: <20221029120311.11152-4-erayorcunus@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221029120311.11152-1-erayorcunus@gmail.com>
References: <20221029120311.11152-1-erayorcunus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reporting KEY_CAMERA when pressing camera switch key is wrong, since
KEY_CAMERA is supposed to be used for taking snapshot. Change it with
KEY_CAMERA_ACCESS_TOGGLE, so user-space can act correctly.

This patch needs KEY_CAMERA_ACCESS_TOGGLE to be defined, thus depends on
"HID: add mapping for camera access keys" patch.

Signed-off-by: Eray Orçunus <erayorcunus@gmail.com>
---
 drivers/platform/x86/ideapad-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index b67bac457a7a..0ef40b88b240 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1038,7 +1038,7 @@ static void ideapad_sysfs_exit(struct ideapad_private *priv)
  */
 static const struct key_entry ideapad_keymap[] = {
 	{ KE_KEY,   6, { KEY_SWITCHVIDEOMODE } },
-	{ KE_KEY,   7, { KEY_CAMERA } },
+	{ KE_KEY,   7, { KEY_CAMERA_ACCESS_TOGGLE } },
 	{ KE_KEY,   8, { KEY_MICMUTE } },
 	{ KE_KEY,  11, { KEY_F16 } },
 	{ KE_KEY,  13, { KEY_WLAN } },
-- 
2.34.1

