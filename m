Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000AF6A71EE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjCARSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCARSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:18:00 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3532B468F;
        Wed,  1 Mar 2023 09:17:58 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id cw28so7663575edb.5;
        Wed, 01 Mar 2023 09:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6Vzhf0LU+mQzZ8HuoT8gnuPpuKfgSIzrjtdP2YmJJ0=;
        b=B7rgL+5UnHFOpJ9ctSa2vQa8HIzPZRndUv2h4NGLE4xGU62aI8HchqOLPbAOh9k5Rf
         p3RNtgegA6cWMcFqR4gJANmcUAOsoJTGgcr6DdAfl9Tc/LOVoKYYkqzZFpHeZa8GJJTk
         zfgyX8Mxm0tF3StyqJvpYxqQlSgGOecImruAuNvW33W0xUj28Ph4PiWrIUOzk+wmUTX+
         areft4kUou6tOxKYL4T4QwQO5pFmJL5XqAkaw0gi7DhZROj4X7eRhQjB7D/ZdoXWm8cf
         2NFz5Z+Ct2mX/wmYrlrYkdzb2j6EA3UauQGF96ghro8YJEbqGcJxT0CcMiu/sOiguiD+
         1xPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6Vzhf0LU+mQzZ8HuoT8gnuPpuKfgSIzrjtdP2YmJJ0=;
        b=t/S+6rVFG36GaUp36IBNwNBvd+8untYNsPF2ydWt9N8NOhC0Z/hNPYjmcODGzQ75D2
         9O6xxdmL5x7ElwXRqtTQCj0P2C7JumazPZOMtSwv5JQzLkHRn1C6crbpoxshmrcQwgpg
         xfHt1V/9PFe0CG2ZXSte4/iUTGbOAoAGgDjMoTe+DOpWcpu8Ot2zwCQs7ueSxtjNkuEw
         2TQ6a91VgRth2V0eQ1ePyAQXZHFICbxMhw5tSaGvbrTWN2LMvSbW87sLKfvOpPSGhkMj
         1FfUoOoczDo1gDu0CBmWdhS8m1ye9TNqDIF4FJIo8CrymAPdAXBSWyPcHaf8IrZtYU41
         sB3g==
X-Gm-Message-State: AO0yUKUKDNeEcwZB3qiRArOKoDtFdHN0emdeczMVu7haHF3VSXznHLix
        zBdas2OLxWeUBl4Ho5AIVwY=
X-Google-Smtp-Source: AK7set+b77dZQDL5FelK+SgKQVApLGkvHWOdnYLOHUa8vMxQ4Ap+f4nHY7CUk7gUo/n2/wzlpHUO/g==
X-Received: by 2002:a17:906:6d58:b0:8ed:e8d6:42c4 with SMTP id a24-20020a1709066d5800b008ede8d642c4mr7094869ejt.12.1677691076481;
        Wed, 01 Mar 2023 09:17:56 -0800 (PST)
Received: from [127.0.1.1] (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id k20-20020a1709061c1400b008cd1f773754sm5968943ejg.5.2023.03.01.09.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 09:17:56 -0800 (PST)
From:   Jakob Koschel <jkl820.git@gmail.com>
Date:   Wed, 01 Mar 2023 18:17:43 +0100
Subject: [PATCH] watchdog: avoid usage of iterator after loop
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230301-watchdog-avoid-iter-after-loop-v1-1-851f583be9f7@gmail.com>
X-B4-Tracking: v=1; b=H4sIALaI/2MC/x2N2wrCMBBEf6Xsswu5KKK/Ij5skk2zoElJShVK/
 93El4HDDGd2aFyFG9ynHSpv0qTkDvo0gU+UZ0YJncEoY5VVGj+0+hTKjLQVCSgrV6Q48lXKgqR
 vVxeN0md7gS5x1BhdpezT0Lyp9ekolspRvv/nx/M4fqtikHOJAAAA
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677691075; l=1458;
 i=jkl820.git@gmail.com; s=20230112; h=from:subject:message-id;
 bh=oeZBJYZPvD2Na3GsNTaSJcR3WL4A0pZOrvomb/rFVEU=;
 b=4YBYMm4pH7lJGZVCsbwbpSJ/6WZjbAaRU+HlV4qitVIQEXsCyAnmHjtOWp9KdonxbxpgGko0xGwX
 gv6c+M+1CjUGeY5lX184pF+oPyKgVfythpp2HKJlCS6RRymO86Ra
X-Developer-Key: i=jkl820.git@gmail.com; a=ed25519;
 pk=rcRpP90oZXet9udPj+2yOibfz31aYv8tpf0+ZYOQhyA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If potentially no valid element is found, 'p' would contain an invalid
pointer past the iterator loop. To ensure 'p' is valid under any
circumstances, the kfree() should be within the loop body.

Additionally, Linus proposed to avoid any use of the list iterator
variable after the loop, in the attempt to move the list iterator
variable declaration into the marcro to avoid any potential misuse after
the loop [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
---
 drivers/watchdog/watchdog_pretimeout.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
index 376a495ab80c..d8c78696eaf5 100644
--- a/drivers/watchdog/watchdog_pretimeout.c
+++ b/drivers/watchdog/watchdog_pretimeout.c
@@ -207,10 +207,10 @@ void watchdog_unregister_pretimeout(struct watchdog_device *wdd)
 	list_for_each_entry_safe(p, t, &pretimeout_list, entry) {
 		if (p->wdd == wdd) {
 			list_del(&p->entry);
-			break;
+			spin_unlock_irq(&pretimeout_lock);
+			kfree(p);
+			return;
 		}
 	}
 	spin_unlock_irq(&pretimeout_lock);
-
-	kfree(p);
 }

---
base-commit: c0927a7a5391f7d8e593e5e50ead7505a23cadf9
change-id: 20230301-watchdog-avoid-iter-after-loop-a197bf201435

Best regards,
-- 
Jakob Koschel <jkl820.git@gmail.com>

