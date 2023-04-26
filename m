Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBD66EFE18
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 01:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242796AbjDZXnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 19:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241632AbjDZXm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 19:42:56 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816E53AAA;
        Wed, 26 Apr 2023 16:42:48 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-5ef5245e5b2so35147716d6.0;
        Wed, 26 Apr 2023 16:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682552567; x=1685144567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8SZe3hC7Z59GY12y1nJWCl9RcoLJZwFGnOEfEm15qo=;
        b=JGvEGdje26JMCOMaFdeRaz10zZmrg5fkt2/UMeJR64cXoKN2fL4yW20ojTzMdbHM00
         k1D6qWJb3z5NEicUMcmD4Bx8KFemYp5p6yNP0Ko703nbAOn0evsb7lSJC6xqBgNiisGk
         3w7t3+rYVGHvnchYZcx2Ow/9cKoW7nfiBn/gJFDxeTJzvZyWXwbq33RXba72YcwOraWl
         vehS+PxqS6XfwcikkP2VrSEBhQtryBytEROTgMZSIw0TNOeFiK8teDe/EH4ZHPfHIqMm
         Kuq4R+MukQ5EapqGoVkqWA1XLraYQ8CufBKYpIE1406C8aOmoO6cIWr+Nbr6IVhnJYtL
         /z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682552567; x=1685144567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G8SZe3hC7Z59GY12y1nJWCl9RcoLJZwFGnOEfEm15qo=;
        b=AWI8RsT5N7lL4i4QztFpgMLrApLOtxFXXTwbHzQK0EwrBEiRRQNKQYQLbS7QbERwuW
         FuINtVpicdjYiK1LllABhxIMs0ejgJFpI0428oVS69S6e3cz4hwHavUPDY7pE62nZ5nm
         ONoeuftc6d24FG4JiizNmCYGWxFDOxmCfjCddpTDyFIwoR2BN1K3ACVxIpq00dxxX2vi
         e9+CwNQTScx2SPaoa1YaLbPsuIUji2teC+rD2VGvwOC0vbQNYR3HFBB6zWmwNoXFGBey
         cstcDdUjWKWHkmTVQOkm5kzcRVH0vnWQK3jQsmI0cA6ySnEFe6r25Na026g4kjcS0h+O
         rKuQ==
X-Gm-Message-State: AAQBX9dLyTeYj4BgtgXndwOkVWsmc/FUGgbWrBcpvnltmapzt1X5rxmf
        Sb5frdFSbgMX79M8Esd8tA==
X-Google-Smtp-Source: AKy350a39RVGLoHUdEi0Nc662WpB0gs58j57a8DoN7U7hUhuJlUMAwEC2Ve5B1CyD/Nnk0NMhUitng==
X-Received: by 2002:a05:6214:1cc8:b0:5ac:58cc:69d1 with SMTP id g8-20020a0562141cc800b005ac58cc69d1mr34042573qvd.31.1682552567479;
        Wed, 26 Apr 2023 16:42:47 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id z8-20020a0cf248000000b005f5a05448d8sm5140094qvl.100.2023.04.26.16.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 16:42:46 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t560.mvista.com (unknown [IPv6:2001:470:b8f6:1b:de9b:7730:1c53:557e])
        by serve.minyard.net (Postfix) with ESMTPA id C606F180011;
        Wed, 26 Apr 2023 23:42:45 +0000 (UTC)
From:   minyard@acm.org
To:     Craig Shelley <craig@microtron.org.uk>,
        Johan Hovold <johan@kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, Corey Minyard <cmimyard@mvista.com>
Subject: [PATCH] USB: serial: cp210x: work around silicon bug setting break
Date:   Wed, 26 Apr 2023 18:42:21 -0500
Message-Id: <20230426234221.1867222-1-minyard@acm.org>
X-Mailer: git-send-email 2.35.7
In-Reply-To: <ZEmDs0ASdnEAnpsL@minyard.net>
References: <ZEmDs0ASdnEAnpsL@minyard.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cmimyard@mvista.com>

At least on the CP2105, sending this once doesn't work, you have to send
it twice to make it happen.  If you only send it once, you will get a
really short time (a few bits) where the break is sent, right when the
break is turned off, thus it isn't recognised as a break.  Sending it
twice won't hurt anything, so just do it all the time.

Signed-off-by: Corey Minyard <cmimyard@mvista.com>
---
I played with this a bit, and found this change fixes the issue.  It's
not ideal, I suppose, but it works.

 drivers/usb/serial/cp210x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index cdea1bff3b70..e410a749325b 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1446,6 +1446,15 @@ static void cp210x_break_ctl(struct tty_struct *tty, int break_state)
 	dev_dbg(&port->dev, "%s - turning break %s\n", __func__,
 		state == BREAK_OFF ? "off" : "on");
 	cp210x_write_u16_reg(port, CP210X_SET_BREAK, state);
+	/*
+	 * At least on the CP2105, sending this once doesn't work, you
+	 * have to send it twice to make it happen.  If you only send
+	 * it once, you will get a really short time (a few bits) where
+	 * the break is sent, right when the break is turned off, thus
+	 * it isn't recognised as a break.  Sending it twice won't hurt
+	 * anything, so just do it all the time.
+	 */
+	cp210x_write_u16_reg(port, CP210X_SET_BREAK, state);
 }
 
 #ifdef CONFIG_GPIOLIB
-- 
2.35.7

