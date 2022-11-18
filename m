Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E90162F86D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242081AbiKRO4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241701AbiKROzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:55:53 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD19240AA;
        Fri, 18 Nov 2022 06:55:28 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id h21so3250419qtu.2;
        Fri, 18 Nov 2022 06:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1hUB1CG0ZAd5p0bPUclNpK4BZ15p3GlgtAxgJ6lCak=;
        b=WJCV8JBRN9CY1n6C0ycMywErBCrs4UW7PhljBaHhnABbcN77s6DiHy+ieq3Keho7Fh
         hSgxsXpdiJ9p56AI0ZoSlrwIglziuz2OmnZO2q5bsguwe0BZQ4bqjWye+Sg7QVj0lSbd
         IkT+Ha+UMXXek3ykGxm8M83Ku7RtnypSxoWWcKGb8RWfEeAPWEkvfErWltE1yRtvdVUE
         yLe5C80j6OPHRGuuUPEYZa6F1evdUzBlB4FcHvQ5PiuyNOdsRwvpCrFOZ4gsqOqpfzh5
         EdL45pH2raanZZHr6hZ+tf3fjqeKCFbujSCD45yVttWd0YHLyiR850GGyhThMYkn3K50
         PGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1hUB1CG0ZAd5p0bPUclNpK4BZ15p3GlgtAxgJ6lCak=;
        b=6wn1DMpZ/WeIvx+K/BvRyhg4f14iE9qaQYZ+d8SlgT+WpJ/ICW4L6sK+rKuB1kj7nP
         GeuKKlZfgjp9Cx9pulF87BpYbQ8J+dpLpzKtfHLPCMYROcJ57666jSQFZxybk31hDOFJ
         YSgYqmGIHPEo9ftJAbAKdye/VcfknyhPBpZAqE/d3cvVgPUg47LFFJjBHeDF7EjgeJUZ
         OTR0XdL+Pzidab0rX7Bgk7p2ASq5+yLXMX2xZH7nRMoARgt3CHfRJEdYzR3sF+en3b35
         Zkd+WLJpzZc1FNOSl/KebnAaBii7c+GpprYKVurF775JWHtdkMBFgMYOHx7ttYITx/e1
         yVag==
X-Gm-Message-State: ANoB5pkMiNBqOWHGUvyuJrc/0pBAJx2jr+bWfDYyKygblrAawISAbalu
        UYiO+mQjZbG/PkSzXudIqv86jR3tmaAhDQ==
X-Google-Smtp-Source: AA0mqf5RVLDQhr3kEvYa4VddEuglS7PJJX6YF6W751EnoKOEWxrPN15p7dW1Bcphmdzya6dyVtVh1w==
X-Received: by 2002:ac8:498a:0:b0:3a5:1c61:230c with SMTP id f10-20020ac8498a000000b003a51c61230cmr6965266qtq.29.1668783327307;
        Fri, 18 Nov 2022 06:55:27 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id m125-20020a378a83000000b006cbc6e1478csm2397269qkd.57.2022.11.18.06.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:55:26 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 06/14] serial: liteuart: move tty_flip_buffer_push() out of rx loop
Date:   Fri, 18 Nov 2022 09:55:04 -0500
Message-Id: <20221118145512.509950-7-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118145512.509950-1-gsomlo@gmail.com>
References: <20221118145512.509950-1-gsomlo@gmail.com>
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

Calling tty_flip_buffer_push() for each individual received character
is overkill. Move it out of the rx loop, and only call it once per
set of characters received together.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/liteuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 1e3429bcc2ad..81a86c5eb393 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -87,10 +87,10 @@ static void liteuart_timer(struct timer_list *t)
 		/* no overflow bits in status */
 		if (!(uart_handle_sysrq_char(port, ch)))
 			uart_insert_char(port, status, 0, ch, flg);
-
-		tty_flip_buffer_push(&port->state->port);
 	}
 
+	tty_flip_buffer_push(&port->state->port);
+
 	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
 }
 
-- 
2.38.1

