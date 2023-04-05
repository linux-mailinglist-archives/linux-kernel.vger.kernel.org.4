Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CCC6D7B0A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbjDELTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbjDELTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:19:19 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8202B5277
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 04:19:17 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id q14so36907435ljm.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 04:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1680693556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSFYI7j66ps5gPOzhCvfrqWJlEEBkt6nqqDRdGGPNWs=;
        b=ZRZYDZjb9UaQoM5xipqVaih2q2qQxdW+75scFDNwTkOWzj5AOn/6IzMeL95eQ6fD92
         MkEaGbjNZ1YZsGZgx0jehxkuD9ObaD1WH4q9rcsJA17e6eA4juTKVmZEaVFvAZOGWh9O
         4nWR7jh6GAsWilAbgoNRIqTh9bsfb5I5WrjvDHBgrHtK99x4spl9oE54ZLSh8f7aELbK
         loF2pv7z6hUBQotlHBb1avnuuW+nyLkj4hR0H1Sm3s9PQ2RCyO/vZ664fJrauutfDV7v
         n+dcjt2LdkUu1GTIyAhgVurBo8wP7+icLnOtF1o8bjlJTY0C6wRlwpCYEHAB7ACL01QX
         mqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680693556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSFYI7j66ps5gPOzhCvfrqWJlEEBkt6nqqDRdGGPNWs=;
        b=4Y3cFsaZy5IwwkYN09I5qhipE+S6Eyt4Oe5IVDJ5WDQOSBS9f0GZRqVEwRy2L8oMdg
         oe2YafuQ2tyKEwCoWW4gIRYUV8fpevINtZ+dgeSswKUJEtKPTm4Tj+QhYhJ8xxqgTqu7
         XvwElckF2x4iIbdmJ4mrHo9bP5pebAIxrkE+AVeJiYgxu09kuqRicXYCS6az/Ftu48RV
         uNwIBcku4CqcSPXNERtPUWVM3zlWeax4AqW71gTbRzgB+wpwIsxC+UdonZ0g6yqa2dAb
         2ltGj/HyKRXvEg0/77dSBrS4ffjioji6Ah+xIuPNSQKQ08tuom8QPrnZUGVrcDUQj+ym
         g3vw==
X-Gm-Message-State: AAQBX9eAwgIIv196IyNIg1X6RxFFCT19fISIR/lsYyDg6Rr5OUiub8Sz
        x2Tc+mxT3L/17GtEVtPp1tZXug==
X-Google-Smtp-Source: AKy350aFzI2aNBR5MfpNTrIYh9Wa208NBwtIuPbYLOClHOuwpmtcl7SA9+n1MxM5vjHoBl3aTedR4w==
X-Received: by 2002:a2e:8ed2:0:b0:299:a55a:f66f with SMTP id e18-20020a2e8ed2000000b00299a55af66fmr1471636ljl.22.1680693555793;
        Wed, 05 Apr 2023 04:19:15 -0700 (PDT)
Received: from lmajczak1-l.roam.corp.google.com ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id i19-20020a2e8093000000b0029f3e2efbb9sm2817730ljg.90.2023.04.05.04.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:19:15 -0700 (PDT)
From:   Lukasz Majczak <lma@semihalf.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@semihalf.com, Lukasz Majczak <lma@semihalf.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/2] serial: core: preserve cflags, ispeed and ospeed
Date:   Wed,  5 Apr 2023 13:15:58 +0200
Message-Id: <20230405111559.110220-2-lma@semihalf.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230405111559.110220-1-lma@semihalf.com>
References: <20230405111559.110220-1-lma@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-enable the console device after suspending, causes its cflags,
ispeed and ospeed to be set anew, basing on the values stored in
uport->cons. These values are set only once,
when parsing console parameters after boot (see uart_set_options()),
next after configuring a port in uart_port_startup() these parameters
(cflags, ispeed and ospeed) are copied to termios structure and
the original one (stored in uport->cons) are cleared, but there is no place
in code where those fields are checked against 0.
When kernel calls uart_resume_port() and setups console, it copies cflags,
ispeed and ospeed values from uart->cons, but those are already cleared.
The effect is that the console is broken.
This patch address the issue by preserving the cflags, ispeed and
ospeed fields in uart->cons during uart_port_startup().

Signed-off-by: Lukasz Majczak <lma@semihalf.com>
Cc: <stable@vger.kernel.org> # 4.14+
---
 drivers/tty/serial/serial_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2bd32c8ece39..394a05c09d87 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -225,9 +225,6 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 			tty->termios.c_cflag = uport->cons->cflag;
 			tty->termios.c_ispeed = uport->cons->ispeed;
 			tty->termios.c_ospeed = uport->cons->ospeed;
-			uport->cons->cflag = 0;
-			uport->cons->ispeed = 0;
-			uport->cons->ospeed = 0;
 		}
 		/*
 		 * Initialise the hardware port settings.
-- 
2.40.0.577.gac1e443424-goog

