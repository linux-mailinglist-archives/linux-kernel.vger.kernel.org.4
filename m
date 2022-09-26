Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90E65E98EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 07:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiIZFoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 01:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiIZFo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 01:44:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AD725EB4;
        Sun, 25 Sep 2022 22:44:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so11300250pja.5;
        Sun, 25 Sep 2022 22:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tYfnxulldj171ixk25F2gMZ3H1v7kdiDVADiAeKVB2w=;
        b=dKkCvrI3++CEhnNBVVhNi379RVaSByu+G5rn7BoaLCQ7JHDrdeX6elVjqvLWk4J0yj
         9V+66r6y1AUP8tQYPYZVdbEo1n5NbBb7u6QHfZtJb/HRdqoovcc07bF4MRIbJg3xXj1l
         MVgcEqwBN0pDqQ1VD1eMnQ1cWN/e2w29F2rCxExZhjLq0vQWHKCW32zKya4Go88x/CnN
         APgKSZXoLscYCO7QbyOXRREryfTSA9nQYkqa5W28bUO9Qe/EFYvGLKtGqjsMopTWCOug
         xe/j+T6dE9wJwMW1YbMWnhVAlPZgmc193WwoU9b7wz9LSeHktQoglD9vH/56AwQibUQX
         4tWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tYfnxulldj171ixk25F2gMZ3H1v7kdiDVADiAeKVB2w=;
        b=1tIZeR4NNni0oKcP9UGV7z81R2zFeTDSARdkwK13AKKI2xbpavDV7oEIo/Tsqh766P
         5INjLknr8d23O4XDHh2ohpFudw78wHi2ewNyG90aBQCTUP5S6W1sC+u3CyPuPeMiSAAO
         J9SFmre4YDEiSmrcbS6PgZmIDPdB8A9wuqQWeWaPqqMQqSYaecuRG0LBkyieV7ezwkZH
         KxzFi9adEKYacmGKMJmsl+PWUYvkXFlw0fua0rBqfqwVNzs76JCDPbrquANGsp9IN8K2
         7Q2V0a/9T7FogeGM2DIfqUUXo5SkkRewdEMWla/oedKEAbMTLbHcpmCObt/p4/9FlGvJ
         mDNQ==
X-Gm-Message-State: ACrzQf0Q8wTQU5uwlJdw2GskrUyZbs+/3Nk9yJd+JHm2+XAw+wDeTod5
        sGpqAnkIrH3ou1sWSTAnc28=
X-Google-Smtp-Source: AMsMyM7xvlNRzqXXwVgnEGnQFpWzpscQ+XxEN4fT2nWBhp6a3WuCSN35BCMjQCiR/A2a2qk8qEeKqQ==
X-Received: by 2002:a17:902:db0f:b0:176:e70f:6277 with SMTP id m15-20020a170902db0f00b00176e70f6277mr20276684plx.13.1664171066256;
        Sun, 25 Sep 2022 22:44:26 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:7e1b:858c:19dc:934])
        by smtp.gmail.com with ESMTPSA id r11-20020a170902be0b00b00176c0e055f8sm10110489pls.64.2022.09.25.22.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 22:44:25 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH 3/5] mfd: palmas: stop including of_gpio.h
Date:   Sun, 25 Sep 2022 22:44:19 -0700
Message-Id: <20220926054421.1546436-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220926054421.1546436-1-dmitry.torokhov@gmail.com>
References: <20220926054421.1546436-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
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

It does not appear that any of palmas sub-drivers are using OF-based
gpio APIs, so let's stop including this header.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/mfd/palmas.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index 1e61c7e9f50d..117d02708439 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -16,7 +16,6 @@
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/extcon-provider.h>
-#include <linux/of_gpio.h>
 #include <linux/usb/phy_companion.h>
 
 #define PALMAS_NUM_CLIENTS		3
-- 
2.37.3.998.g577e59143f-goog

