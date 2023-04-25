Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D186EE277
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjDYNG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjDYNG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:06:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2B218F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:06:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94eff00bcdaso1048611066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1682427983; x=1685019983;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tW/eSmOquWqsn4Qc9vBkGwpaFrA5k5cuyKEI0tatxaQ=;
        b=II+GFlqveQXslPCMvlz6nOOgzMNg/0IL7uNof8ns0KJdajnk8QOAbkxbsicOINYAzF
         Imb4t/cHet6o/bXvXiOoQqmzeGrTpjQDXVJorNwA++HQuWc0Y3WSu6RmhyACMS4/E8rs
         AAtGD/0N74vR/k7jxmiUTydl2EpN4zNWQ4RFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682427983; x=1685019983;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tW/eSmOquWqsn4Qc9vBkGwpaFrA5k5cuyKEI0tatxaQ=;
        b=J1KAb0qaCa2832nH36jCuM6XIY0Sd6sdUQdyy9w1pABgXYWe6ihnUN83UVpSpHAtYm
         oadg/ik0zDF6LH6c1YYxiT1O23Qy9ZeDKGUIEllWkCaL2jM7asxMTfQCuOaDkDZgawMm
         WF5CCQrVb5Lc+2vxNUH4GnRqEsDcr7xSq4tv5ByxHpH4Ss8VtRj2gptL5iTDsuwmYOoY
         j0YOBWiI/opF8cpHOw/6FtDlaVZiaJ4VxzAR5UwFaN0AlWlsK8x9XFaEModkz7d9aq5P
         E/zgo5qDs/6YDUByDskd420mvCmDCVPCbFTopenBQkffF0VjFy+PhEROqiYkafeyo1s3
         KOLw==
X-Gm-Message-State: AAQBX9ePrspK4unF1+mXJcuirg5pKzUL4KcCr+2HZHPKIhsG5yOzTW2W
        2a8dZWeuFKZWFlKCvWKGdxUKUTNUENiNXOcg+A8=
X-Google-Smtp-Source: AKy350aaTF/MCEXIurAqS8P5a1U1C8WTPHLQwtoa938vLtnHMgtp88MBVB6AzEoluu1M9/USitTPfQ==
X-Received: by 2002:a17:906:d72:b0:94e:ec0f:455 with SMTP id s18-20020a1709060d7200b0094eec0f0455mr16164034ejh.54.1682427982922;
        Tue, 25 Apr 2023 06:06:22 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:530d])
        by smtp.gmail.com with ESMTPSA id k21-20020a1709061c1500b0094f7da9f1besm6732378ejg.61.2023.04.25.06.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:06:22 -0700 (PDT)
Date:   Tue, 25 Apr 2023 14:06:22 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: [PATCH v5 1/2] printk: Do not delay messages which aren't solicited
 by any console
Message-ID: <d2bc3639839e232a841bc06c3ca7e8b4d502e412.1682427812.git.chris@chrisdown.name>
References: <cover.1682427812.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1682427812.git.chris@chrisdown.name>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 kernel/printk/printk.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fd0c9f913940..041c7bd56005 100644
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
 
-	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
-		|| suppress_message_printing(level)) {
+	if (boot_delay == 0 || system_state >= SYSTEM_RUNNING)
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

