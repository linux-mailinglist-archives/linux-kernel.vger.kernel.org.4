Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BFD604A82
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiJSPGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiJSPFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:05:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5091DDC6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:59:03 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5NubkodPN0irIWt1R4/lmY742ka0PyGCnf6KGs6APw=;
        b=WEzWfi4KYJK6tM+UtRO9gMqcL80wT6ZfChj8pVIGHeb3YIK8WqcUSy2zLWw/YojPSsGNup
        y7TQiRk0nnLkGjmOTqw0TEl1/pK8HDisoKp2Nk5Yb4JeRsivDB1CzI0E2o2qg0LVhsdq8m
        zyNH5ObjKPbpSu80an465e/0eKD5IrMpnPWTzA90Ir/JAkTes5pABQ40isFhZEHLol3hQf
        G/9qi1yXpMDuoHf2/pGXSYMCmXLbcMI9K/QMqEtFkkge19m+3XWRUYic9PsXu+yn2/vmRZ
        FNkJG8kyRt1kEdOSxEc5o/S3bJfASgsb4wf/OAS1njjVebC3sch6ryLQd2ZEmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5NubkodPN0irIWt1R4/lmY742ka0PyGCnf6KGs6APw=;
        b=7C+o7eTStwH+TXiK5kilPxMT0uoA0rWx2USLmgf4Q5VlRjt97pmtga3hTsgy3a6OZTtOaX
        Cj0gT50z2MtWHsDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH printk v2 17/38] tty: tty_io: use console_is_enabled()
Date:   Wed, 19 Oct 2022 17:01:39 +0206
Message-Id: <20221019145600.1282823-18-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-1-john.ogness@linutronix.de>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace (console->flags & CON_ENABLED) usage with console_is_enabled().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/tty_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index de06c3c2ff70..2050e63963bb 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3532,7 +3532,7 @@ static ssize_t show_cons_active(struct device *dev,
 			continue;
 		if (!c->write)
 			continue;
-		if ((c->flags & CON_ENABLED) == 0)
+		if (!console_is_enabled(c))
 			continue;
 		cs[i++] = c;
 		if (i >= ARRAY_SIZE(cs))
-- 
2.30.2

