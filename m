Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6886BFB2E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 16:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCRPVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 11:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCRPVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:21:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D726234EA;
        Sat, 18 Mar 2023 08:21:09 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h8so31137921ede.8;
        Sat, 18 Mar 2023 08:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679152868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKsKjVODmTjzpUnEKj54Pvt3U2mzabRle7b25tXkzeQ=;
        b=hwBdlY+KF5sgsSeZqZ/wxXKn8wxGaeBEet0zv97YCN/Gsp6lbN2E9nuMwLjPlWuUn3
         IT/lbKgKviDUpp+10U+blkBAT8AXwd6AFJGw+C9jmjibvJmdmF+Fxwb7ULY0cTD5P2aM
         ujT6t/4P7NjtjFQnoR+hrsCLXckbAwWXr+x0Ou08RgTA0D4EHeva5aKSEkbLWK+7IpZ+
         QT5pbdxZpwbA9Us6ml2DHw1O8IJ2RlnJOWrU5cYeb4abfKcuaSpD2sOrlTcpsj2c5E77
         9rDMXJnt6Quk16y4QrVaCF3IuCVGFDGtgUW6b73EowV8T+7YNhTFgW32AvfAS/45MzGq
         JsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679152868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKsKjVODmTjzpUnEKj54Pvt3U2mzabRle7b25tXkzeQ=;
        b=l54sSNG4WQwXqJTWyBNr4Lq2oJ8aXrmdYU/EWqfj7cd8hbnxfFl8DABIxLU1ioGe8U
         O+l2CwlPtbhD4eu8wPIkohy/zZ1C6uk/nxj+BB+793rshoDrsuz35O7GOV5W+xd8iUZ7
         xs+ybf36qJvXedWTyXkfkcM8QfjyOYP1/fozpUprcgyGVwtGNXUlK1wDaiiWESZZtAJW
         pDhz+QyNbeFJ9+v/jwzioRlRrxqSfKkacEtF0gKiTiMQkrPjp1tnMK+ETCqbOAu0qhkS
         A/Jsw1tF0jX+Df8zynYvg77OjcfIS3CHPkCaAXjntvnuO66LOEsPg0vWs3uuUxK7nkbT
         xCXw==
X-Gm-Message-State: AO0yUKU3y/EileL39qcQOz/06+shAsoD4G/hIdTqIIakm84xCVN2EChj
        V9MePdTRRUDMj9w5ANgML3dViaz4vkU=
X-Google-Smtp-Source: AK7set9cmQ/3RYlETwit+jpCD+VnhwP5jiot1MRP/0MccFeTh6e5K1INTgt0Ub8ST5JH8d7w+3iHkg==
X-Received: by 2002:a17:907:7669:b0:931:2f49:c040 with SMTP id kk9-20020a170907766900b009312f49c040mr3234959ejc.51.1679152867686;
        Sat, 18 Mar 2023 08:21:07 -0700 (PDT)
Received: from ninja ([2001:9e8:2bf0:6200:ae22:bff:fec3:bbcf])
        by smtp.gmail.com with ESMTPSA id c2-20020a170906694200b0092b546b57casm2262226ejs.195.2023.03.18.08.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 08:21:07 -0700 (PDT)
Date:   Sat, 18 Mar 2023 16:21:06 +0100
From:   Matthias Benkmann <matthias.benkmann@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, Nate Yocom <nate@yocom.org>,
        hadess@hadess.net, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH v3] Fix incorrectly applied patch for MAP_PROFILE_BUTTON
Message-ID: <20230318162106.0aef4ba5@ninja>
In-Reply-To: <CAK4gqCCk7ipRbZ=LM8Nsj+nE2S6v6QN39ziYSr3d2NmVMHULYg@mail.gmail.com>
References: <CAK4gqCCk7ipRbZ=LM8Nsj+nE2S6v6QN39ziYSr3d2NmVMHULYg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
@@ -781,9 +781,6 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
 	input_report_key(dev, BTN_C, data[8]);
 	input_report_key(dev, BTN_Z, data[9]);
 
-	/* Profile button has a value of 0-3, so it is reported as an axis */
-	if (xpad->mapping & MAP_PROFILE_BUTTON)
-		input_report_abs(dev, ABS_PROFILE, data[34]);
 
 	input_sync(dev);
 }
@@ -1061,6 +1058,10 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 					(__u16) le16_to_cpup((__le16 *)(data + 8)));
 		}
 
+		/* Profile button has a value of 0-3, so it is reported as an axis */
+		if (xpad->mapping & MAP_PROFILE_BUTTON)
+			input_report_abs(dev, ABS_PROFILE, data[34]);
+
 		/* paddle handling */
 		/* based on SDL's SDL_hidapi_xboxone.c */
 		if (xpad->mapping & MAP_PADDLES) {
-- 
2.25.1

