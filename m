Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226CA6E94BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjDTMjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjDTMji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:39:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBF76E9F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:39:31 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f1833c5991so4278095e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1681994369; x=1684586369;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YAv08zAu835VyLUIxerX7wJ0A3J2jIaNEGE7AcNdfA=;
        b=fPQBJcqa3wSJD4o0SaCFjHJsOWzBcpmYweDaFGA8KWYpku/0ocbDo+D7Kgy8f/r57k
         4Vvzvel1/+U5dcEed3vGPlgBnhcupAnzIP2QTpzXlTKKOriCArh4rcVC/d4QbERRFaHp
         hIsZ3KJsTk73n1EN025aTi61n5WkA14dtm+S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681994369; x=1684586369;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YAv08zAu835VyLUIxerX7wJ0A3J2jIaNEGE7AcNdfA=;
        b=TRsDXzyp7bXqxyXHWKxTE2abSRZyqkx0wNsklc36FNzITzX5uvHDVe0s4hxqRwiNE3
         sbhoXjg5GtiA2mD4NaNsF/b+fzE8i/NivnS3NWksXrLkZ6SfcX39RhjcwoqNR020UNFV
         I0l6nRtygVnYMaFCpd/TcltHfik/crj08JdesLOOA2bZfDcG1lANg2wAjvGIeGMZ328n
         4u8oUsKzgBpEzbxxw47+c5rDXN8E9Ro9cdWl6vjaJZwnL6VHXGkm+qP1kxfg/LVCH5WX
         Isa4zqSxyN+FJdruX3+CnlpXSX3z6w16pmAqiK5J3D1hQGqh8qv6Dd3w+jtdbeqEdbFC
         OBtg==
X-Gm-Message-State: AAQBX9fvjrjOL5ST8KsJzbN/VYQwGaF+hW1bEU5WMx+RVEMBV3ycnGUd
        1wrMcz2iikrDOhmyLMMvFOedz5li7Csrrd8kHt8=
X-Google-Smtp-Source: AKy350Zm+L57Etv6+ORsSBHzod4yA1UD2qVE2sMoJBNBj8QR9HaH9mrjPPWE38M1Zf1XZoSluhihoA==
X-Received: by 2002:adf:f48c:0:b0:2fb:2a43:4aa1 with SMTP id l12-20020adff48c000000b002fb2a434aa1mr1254562wro.42.1681994369494;
        Thu, 20 Apr 2023 05:39:29 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id k13-20020a5d6e8d000000b002fae2a08089sm1882662wrz.70.2023.04.20.05.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 05:39:28 -0700 (PDT)
Date:   Thu, 20 Apr 2023 13:39:28 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: [PATCH v4 1/2] printk: Do not delay messages which aren't solicited
 by any console
Message-ID: <43d7f8d6e4b45a1a76fceef2d117bbc3954bc0bf.1681994221.git.chris@chrisdown.name>
References: <cover.1681994220.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681994220.git.chris@chrisdown.name>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boot-delayed printk messages already have this checked up front, and
it's odd that we don't do the same check for global printk delays, since
there's no reason to delay if we are not going to emit anything.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 kernel/printk/printk.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fd0c9f913940..06f16a5f1516 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1289,15 +1289,13 @@ static int __init boot_delay_setup(char *str)
 }
 early_param("boot_delay", boot_delay_setup);
 
-static void boot_delay_msec(int level)
+static void boot_delay_msec(void)
 {
 	unsigned long long k;
 	unsigned long timeout;
 
 	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
-		|| suppress_message_printing(level)) {
 		return;
-	}
 
 	k = (unsigned long long)loops_per_msec * boot_delay;
 
@@ -1316,7 +1314,7 @@ static void boot_delay_msec(int level)
 	}
 }
 #else
-static inline void boot_delay_msec(int level)
+static inline void boot_delay_msec(void)
 {
 }
 #endif
@@ -2064,7 +2062,10 @@ int printk_delay_msec __read_mostly;
 
 static inline void printk_delay(int level)
 {
-	boot_delay_msec(level);
+	if (suppress_message_printing(level))
+		return;
+
+	boot_delay_msec();
 
 	if (unlikely(printk_delay_msec)) {
 		int m = printk_delay_msec;
-- 
2.40.0

