Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2616BFAEE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 15:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCROln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 10:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCROll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 10:41:41 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04922884E;
        Sat, 18 Mar 2023 07:41:36 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id t4so8536130ybg.11;
        Sat, 18 Mar 2023 07:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679150496;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dLPasiW4wXVIcw3dYPau5cyl60uI/uhzmr1mBi9HhnE=;
        b=mdPha3r3qnla2jIaaGzEGOD3OmH+pKT6QdNcjL1/bQGuf5RSbP9uHteSAIKjrmK+8O
         VWM5tzX/ENS8VJRTKti9nnRccLjZyfpIMyhKsqqqwFFdNU7E5dHkHg726UWkDsp/MlkB
         3gvsSbza41mbEJW2HwdJ+6YgAI9b8ib+f8+fxWTZJphWZlYiaIzblUa70osAAZe58HJS
         ebtL1tp4W0WBsGrcPAYm0dNxHn/fsbrJMweI2d+FUh7ohBtSYBostduk8oz8Bu6HOn4K
         9vU3RtRLghRlM1+jmrRdQmaazxhsn43svMXhyHF3l0VxNRz49d9dQMwo6DNRE8GrdIBQ
         P5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679150496;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dLPasiW4wXVIcw3dYPau5cyl60uI/uhzmr1mBi9HhnE=;
        b=c1fd8Lg0evd8+SIRhbiEyWU2UY4Ayyl8jF7C1F6J2yFzl4pQrNpmYcmK3yVAfhX16B
         6TzggWan1S1DUU5sJN+r4nLYHQq0TdZ3iXx1qY7lfGFZ4KyL1Xzt//RkF+zKB+lWh1/H
         nMn6ExYFGU1wHu/35kO8y9DweQz9lJE8/0MdiMHFh2oTf/XK/AfoR+7XtDwakkcu55hB
         XW1sYc3vYdz31o3scjuo2ZYs/hGqnG6wfqj8/NbPal9LUqWuNaBq7g8Ill/dl+x0n82K
         OcAjDbwXjQCrbU8k6pjIAX3nxvOvtNGktCUfgKnUqxfGWG8WIGuxeKAOL6yknfjM12iU
         lw3A==
X-Gm-Message-State: AO0yUKUYRbyJbrYKIPF3HavCVVqhavUCzF0o0fVzMg7c+BZ9W28HuIv2
        GM2uIW0uCiKohDet4/+EKnWqMReNmzLSShgcFr8RfN2cUkM2OLcF
X-Google-Smtp-Source: AK7set/USFx6SL92vrbK7UMJBUMUhbz9/SxJ8CMpwtHsmavN3Em70lrlrLmjg4GdYklHlpVw2drZ4ENxdr7OM11QVo0=
X-Received: by 2002:a05:6902:1101:b0:b26:d140:5f74 with SMTP id
 o1-20020a056902110100b00b26d1405f74mr1830252ybu.1.1679150495867; Sat, 18 Mar
 2023 07:41:35 -0700 (PDT)
MIME-Version: 1.0
From:   Matthias Benkmann <matthias.benkmann@gmail.com>
Date:   Sat, 18 Mar 2023 15:41:25 +0100
Message-ID: <CAK4gqCCk7ipRbZ=LM8Nsj+nE2S6v6QN39ziYSr3d2NmVMHULYg@mail.gmail.com>
Subject: [PATCH v2] Fix incorrectly applied patch for MAP_PROFILE_BUTTON
To:     linux-input@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, Nate Yocom <nate@yocom.org>,
        hadess@hadess.net, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the linked patch was applied,
one hunk ended up in the wrong function. This patch moves it to where
it probably belongs.

Link: https://lore.kernel.org/all/20220908173930.28940-6-nate@yocom.org/
Fixes: fff1011a26d6 (Input: xpad - add X-Box Adaptive Profile button)
Signed-off-by: Matthias Benkmann <matthias.benkmann@gmail.com>

---
 drivers/input/joystick/xpad.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index f642ec8e92dd..29131f1a2f06 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -781,9 +781,6 @@ static void xpad_process_packet(struct usb_xpad
*xpad, u16 cmd, unsigned char *d
        input_report_key(dev, BTN_C, data[8]);
        input_report_key(dev, BTN_Z, data[9]);

-       /* Profile button has a value of 0-3, so it is reported as an axis */
-       if (xpad->mapping & MAP_PROFILE_BUTTON)
-               input_report_abs(dev, ABS_PROFILE, data[34]);

        input_sync(dev);
 }
@@ -1061,6 +1058,10 @@ static void xpadone_process_packet(struct
usb_xpad *xpad, u16 cmd, unsigned char
                                        (__u16) le16_to_cpup((__le16
*)(data + 8)));
                }

+               /* Profile button has a value of 0-3, so it is
reported as an axis */
+               if (xpad->mapping & MAP_PROFILE_BUTTON)
+                       input_report_abs(dev, ABS_PROFILE, data[34]);
+
                /* paddle handling */
                /* based on SDL's SDL_hidapi_xboxone.c */
                if (xpad->mapping & MAP_PADDLES) {
-- 
2.25.1
