Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494696C606D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCWHLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCWHLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:11:06 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D1522A1F;
        Thu, 23 Mar 2023 00:11:05 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h8so82436006ede.8;
        Thu, 23 Mar 2023 00:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679555464;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJhxQ9eegIy8auIeHDgaLNjJt7iECL+UFcBbA1fy0hU=;
        b=aVitLeOd4WiRjj3IOZQfgiuCBqHztWLdBxrUzyM+3kiC9kxQ37/OZXqHSqfODTsNQv
         bYqS5l9cWv3DUUEeQnsVCm4Iu6dDag4GXMmtQozJE6cFmAaeDmouxmWkLPtX7OCfsqdc
         eSBpshyYkB3GWtyrmfp/ltuvV9QejWqjUQad6r0HUb4ckwnguwGfa9kUrpjzU8hhimnu
         GOlLaXFwwvBgaUkks5j1xzVeYqW/7azy4MxBw6gRwIRFW4xhloI9WinCvGJBCc3NiRwb
         xBgUDzVyzxXwEoNPxfnj0rWZpcwUvKml4xL47+rxLuCOz46rkxX/+B00Vb8bV9/+YI/0
         FKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679555464;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJhxQ9eegIy8auIeHDgaLNjJt7iECL+UFcBbA1fy0hU=;
        b=F8A8JIAYFREBsG6OdksNrCzSUFtG+SBemKrQdIpr74wusWatAhcu5mN6npEAjvXXZr
         ++E3E9cVb7H4QKDoXZp8Ac3SZrlcOTaVzbjovZaMio0Mi647YfURB72USjanX+qLx67R
         8qfBccdGTBaX/kpHM6TwKxoNCRAcUJkewlAx/oo1laaZQbosrLWy66/oHOZ6BzW9QZb1
         +Z0WoNxvqG3h7vJWI78yJ7QLf9N/zdyPX02nUHyRDNM/zcmthTpMfmdEtrmRk8Ghxrrg
         7cODCKxvNRi7Kdi21o8IXPyDwnssMEW/RNWtAx4FBnTGlUWo9oW/NOPK3N6t68nAuUgS
         NOPQ==
X-Gm-Message-State: AO0yUKUXqJ797i1ItVbnAT9pZv2+nJlud5sMxCmA4oA8FINzfNvV03lG
        bocY6sn+vHbpxYicJJrFZ2g=
X-Google-Smtp-Source: AK7set8JjIMI3M3MQ8kmGBM6/1q4GALj6FNnKbVN7GNh/M/c8BBNUJetqcy0nXuHa0jQ9Ir1ecy/FQ==
X-Received: by 2002:a17:906:90cc:b0:930:18f5:d016 with SMTP id v12-20020a17090690cc00b0093018f5d016mr9996790ejw.15.1679555463531;
        Thu, 23 Mar 2023 00:11:03 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:d509:cbf0:f579:76f0])
        by smtp.gmail.com with ESMTPSA id a27-20020a170906245b00b008d173604d72sm8385061ejb.174.2023.03.23.00.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 00:11:03 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] serial: sb1250-duart: clean up after SIBYTE_BCM1x55 removal
Date:   Thu, 23 Mar 2023 08:10:53 +0100
Message-Id: <20230323071053.417-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit b984d7b56dfc ("MIPS: sibyte: Remove unused config option
SIBYTE_BCM1x55"), an #if in the Broadcom SiByte DUART driver can be
simplified.

Simplify the prepreprocessor condition after config SIBYTE_BCM1x55 removal.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
I looked around on lore.kernel.org and could not find a pending patch from
Thomas Bogendoerfer related to cleaning up this serial driver after he
removed the config. So, to be on the safe side, I just sent this quick
clean-up patch.

 drivers/tty/serial/sb1250-duart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index de56f383964e..b6de0dc51f29 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -41,7 +41,7 @@
 #include <asm/sibyte/swarm.h>
 
 
-#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
+#if defined(CONFIG_SIBYTE_BCM1x80)
 #include <asm/sibyte/bcm1480_regs.h>
 #include <asm/sibyte/bcm1480_int.h>
 
-- 
2.17.1

