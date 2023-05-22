Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061B170CD8E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjEVWMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEVWL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:11:58 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AD5AF;
        Mon, 22 May 2023 15:11:57 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-25533eb3e5dso1931833a91.0;
        Mon, 22 May 2023 15:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684793516; x=1687385516;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TqA2bW+knFFTcINvHPp626nnl9sqoY30ci8T43RsWJk=;
        b=nKYzvQIMQJqMQ5BBdo0++O7XZTz6uXDtrWDvwb7qw9QG2TxZhaVt1NBG3WlYXAyyLt
         GpzrxBe3nS4T5tA3HlXlilx3n8l2VTImdwP2W8skYSYQzIXw7meGS0Ww0VibEpVUZGpy
         DVdWnd1yifD6IDR1lSS6JAozyyk2yrArSG5w301T2WnUjfAWnSzqeneIIOyB4JyPDS3F
         vGWM+/wGs+TTDDcG0qNHWAxZZXG6DTX26UEUxlMmKwQ+ATzWzrnXFSYJXnEbfX1Agmhf
         QRkDe2zGqR9DQh7Q2nfsv5ORExE2spZfaO5ALOwn4UCJKArvMGMh1Mtw4Ti4zJRrXqso
         kmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684793516; x=1687385516;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqA2bW+knFFTcINvHPp626nnl9sqoY30ci8T43RsWJk=;
        b=XHGG4gdnbe4WAXeD+0e2JLoXsZZP7ySosKHM/Tytm6aTjNzELII9UnglWEEIXpS9WL
         k8c9726MQNFl5CCijbRj9h88aDikw9PqmkKXHeyFOeRVi8KzZp6yWN27Fl8H2NMd7myD
         6BhB4lKlr/xFDgalwRL+vp7TMmae8VbPxxiwgApHNtv7IcUkaI8NWSrWExpdbOljaM2G
         Y8OtLxqohFj3XU9Y7lG5Ke8AO5aK2v2S6Q9G2nEEvIgEU59vj4cjUku/NB5DJE/r/IGj
         NZpC4eyLJFCGMA7PfHwYYbNG7fNAru5W3VD90ZFbXkbkjli9JunrDicVB3GCo3h47sAW
         GYWw==
X-Gm-Message-State: AC+VfDzJCqLkTWBUViAilc12SuINESF09NhuAyfT+sBubzBjEjbcfZ+e
        vKAXigLdyia0FPqUAZiF6zafgrFpJmU=
X-Google-Smtp-Source: ACHHUZ7nIMqIUxqN6WdjTpH6xGDkGusMk4zpoVfzAKwBF1itBLvhmFTIZq3EOY29XE+C92YWp39S/g==
X-Received: by 2002:a17:90b:3749:b0:247:8ce1:996e with SMTP id ne9-20020a17090b374900b002478ce1996emr10376861pjb.29.1684793516019;
        Mon, 22 May 2023 15:11:56 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:54fa:e8a7:76de:888d])
        by smtp.gmail.com with ESMTPSA id m12-20020a17090a34cc00b0025356cce0e4sm4961750pjf.24.2023.05.22.15.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 15:11:55 -0700 (PDT)
Date:   Mon, 22 May 2023 15:11:52 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: gameport - provide default trigger() and read()
Message-ID: <ZGvoqP5PAAsJuky4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of constantly checking pointer(s) for non-NULL-ness provide
default implementations of trigger() and read() and instantiate them during
pore registration if driver-specific versions were not provided.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/gameport/gameport.c | 17 ++++++++++++++++-
 include/linux/gameport.h          | 11 ++---------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
index db58a01b23d3..26e197942ff9 100644
--- a/drivers/input/gameport/gameport.c
+++ b/drivers/input/gameport/gameport.c
@@ -21,7 +21,7 @@
 #include <linux/mutex.h>
 #include <linux/timekeeping.h>
 
-/*#include <asm/io.h>*/
+#include <asm/io.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Generic gameport layer");
@@ -518,6 +518,16 @@ void gameport_set_phys(struct gameport *gameport, const char *fmt, ...)
 }
 EXPORT_SYMBOL(gameport_set_phys);
 
+static void gameport_default_trigger(struct gameport *gameport)
+{
+	outb(0xff, gameport->io);
+}
+
+static unsigned char gameport_default_read(struct gameport *gameport)
+{
+	return inb(gameport->io);
+}
+
 /*
  * Prepare gameport port for registration.
  */
@@ -536,6 +546,11 @@ static void gameport_init_port(struct gameport *gameport)
 	if (gameport->parent)
 		gameport->dev.parent = &gameport->parent->dev;
 
+	if (!gameport->trigger)
+		gameport->trigger = gameport_default_trigger;
+	if (!gameport->read)
+		gameport->read = gameport_default_read;
+
 	INIT_LIST_HEAD(&gameport->node);
 	spin_lock_init(&gameport->timer_lock);
 	timer_setup(&gameport->poll_timer, gameport_run_poll_handler, 0);
diff --git a/include/linux/gameport.h b/include/linux/gameport.h
index 8c2f00018e89..0a221e768ea4 100644
--- a/include/linux/gameport.h
+++ b/include/linux/gameport.h
@@ -5,7 +5,6 @@
 #ifndef _GAMEPORT_H
 #define _GAMEPORT_H
 
-#include <asm/io.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -165,18 +164,12 @@ void gameport_unregister_driver(struct gameport_driver *drv);
 
 static inline void gameport_trigger(struct gameport *gameport)
 {
-	if (gameport->trigger)
-		gameport->trigger(gameport);
-	else
-		outb(0xff, gameport->io);
+	gameport->trigger(gameport);
 }
 
 static inline unsigned char gameport_read(struct gameport *gameport)
 {
-	if (gameport->read)
-		return gameport->read(gameport);
-	else
-		return inb(gameport->io);
+	return gameport->read(gameport);
 }
 
 static inline int gameport_cooked_read(struct gameport *gameport, int *axes, int *buttons)
-- 
2.40.1.698.g37aff9b760-goog

-- 
Dmitry
