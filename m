Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2F56B79C6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjCMOAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjCMN7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:59:52 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81C96F611;
        Mon, 13 Mar 2023 06:59:30 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id y4so19635056edo.2;
        Mon, 13 Mar 2023 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678715969;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fN1dQT+PN2R8a3kO0NDn0Z6JMMME9zE9z+uQaFMNxh4=;
        b=jcpxiX875t/ZNhNKsmB738+3N2Jq9gvZoTjtb3wq6So/RnAHOBZOy0dI91Sp16dAJd
         4kTAsHVnjd76NKjEKp0/iveiBzyVYgg5+VRQLE8Bu8y1HQPSwqVHAu2tdxBxU7u17g0C
         yoxysF68AueW1Gf0VQa+nHoEPsqTWfOjTxFeOmkQKBj/tcvlcWdHwyIBpiMc3zhvZLtx
         g8NqJR3l/SN9i68mj23fdFG6OHQ7B2NJp5BzWIr6Cj5Isb3zvfy2H7ELLoUEhbVwevne
         EUqrt6+AXqYW8rOZ8HGO7bhsHMtx1AjV0NqXcRYuqVKcgdrayO2oL1OwbBw6hfhf+mq7
         96ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678715969;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fN1dQT+PN2R8a3kO0NDn0Z6JMMME9zE9z+uQaFMNxh4=;
        b=tKPdP+ihkSvJw8+VlkJXMPdlTH5fq02Hts5VAMR6X9Ye7XcvGmh77MjmlKlnK2zCaf
         gBMoPwy/ooVHUNlmIacks4J90fojpM0VjzVfWp6e3CnAhe9VLBHve2ly9gKlhEgBjCKj
         1ynZZ0ESIwSfB0ZNewk5qT8rY6hjrj9X82OTK69FDqF3cfIEkisYWG9RAnrDVVotK6pb
         hypcWISB0Vd460ba1uOPuxUbMr+z52lagMPtw9lsJI9jZ2mpuAzabHzcc8bE5AOFOouI
         n+t4kcFW/bU6LMsMYYD14jJ9K2UaQKjP8142CA/db09eVW5cKN3GignVuXAXa993enow
         NFyA==
X-Gm-Message-State: AO0yUKVALXwQOFQnfayuFpWQqZI2VP2fFx2uKVZzAu/aJ84ydOExD9CE
        cmuO3G/e/6psJN4KNCkNjhY=
X-Google-Smtp-Source: AK7set/Hs5/np/06DvK71sMCs5LvwEH+FBtLTWDd7uwUA8oxyW7QC+KHB6dBgcf4GBfaRqFOMS+hTw==
X-Received: by 2002:a17:907:b1b:b0:92a:32ac:8f3d with SMTP id h27-20020a1709070b1b00b0092a32ac8f3dmr2778237ejl.66.1678715969365;
        Mon, 13 Mar 2023 06:59:29 -0700 (PDT)
Received: from [127.0.1.1] (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id w7-20020a50d787000000b004c19f1891fasm3299161edi.59.2023.03.13.06.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 06:59:29 -0700 (PDT)
From:   Jakob Koschel <jkl820.git@gmail.com>
Date:   Mon, 13 Mar 2023 14:59:19 +0100
Subject: [PATCH v2] watchdog: avoid usage of iterator after loop
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230301-watchdog-avoid-iter-after-loop-v2-1-8411e3bbe0de@gmail.com>
X-B4-Tracking: v=1; b=H4sIADYsD2QC/42OwQ6DIBBEf6Xh3G0EatSe+h+NhwVBNlExYGgb4
 78X/IJeJnk7m5nZWTSBTGSPy86CSRTJLxnE9cK0w2U0QENmJiohK1lxeOOm3eBHwORpANpMALR
 FJ+9XQN41yoqK32XNcojCaEAFXLQrMTPG/FqMNRhLn7P51Wd2FDcfvueQxMv1787EgUNbc1u3U
 pnONs9xRppu2s+sP47jBxZllqrlAAAA
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678715968; l=1573;
 i=jkl820.git@gmail.com; s=20230112; h=from:subject:message-id;
 bh=Zyf7+R+AMoECnD523+X9aDNjyuDaYzeTvhqsg90q7kU=;
 b=900ZykUCEY7u8MZhgZuIdUmEP0GFLUY8w8tcsGY3dlz96RpuYHcAy1POmpE9uT/J849Xe8WscfsP
 cQfCfCOsDUwamdqgABhFvvVkQLUuJfsLF3KLFLc78doPd0GhvRkg
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
variable declaration into the macro to avoid any potential misuse after
the loop [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
---
Changes in v2:
- avoid returning within the list iterator
- Link to v1: https://lore.kernel.org/r/20230301-watchdog-avoid-iter-after-loop-v1-1-851f583be9f7@gmail.com
---
 drivers/watchdog/watchdog_pretimeout.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
index 376a495ab80c..e5295c990fa1 100644
--- a/drivers/watchdog/watchdog_pretimeout.c
+++ b/drivers/watchdog/watchdog_pretimeout.c
@@ -207,10 +207,9 @@ void watchdog_unregister_pretimeout(struct watchdog_device *wdd)
 	list_for_each_entry_safe(p, t, &pretimeout_list, entry) {
 		if (p->wdd == wdd) {
 			list_del(&p->entry);
+			kfree(p);
 			break;
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

