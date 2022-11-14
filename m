Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F2F62853F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbiKNQ3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbiKNQ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:29:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F73E53;
        Mon, 14 Nov 2022 08:29:37 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MpXDwx4HKdMdBWDyluBjDSAFdjedUOkxkf204NlGPAs=;
        b=ZIb+4NiGcX3L5i14ZL3n7tyukxCFrzAaN2u/yt52dY0OinERwz3VqBV0iF7GolWDeFJnsS
        svoW/OdbNhOb7rb654aqbqcDtFwbYfHWhVZ2ceuMPMcmhjv0V1q3gI9oTYPoEvd8jv81b2
        ma9pcNTXKnS70k2gFZOc7Mia1+4plCCQeNOoytXM9nVFKXzKRZtPhuY59fzFOSCKq0RZRA
        poyjWM9clrOP4N2sx47bznvDPqWcHfs5npYE93Qb0Y0jv9sBxSYz56D2YmtmCZohhyLeYI
        KMrf2UiGEmrv9Y3gYhZPaxYcx475ZwaukWQ0CpuTNgN1i+6jxNyGMVDu29ZVDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MpXDwx4HKdMdBWDyluBjDSAFdjedUOkxkf204NlGPAs=;
        b=rHBzMhUuyyCGljjYgo6M9g2z9ptIJHtaTE0co9JJYi84qxrRS2zWgGLSRMhVC57vB7U60l
        V2qJLfb/YvGXv+AA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: [PATCH printk v4 01/39] serial: kgdboc: Lock console list in probe function
Date:   Mon, 14 Nov 2022 17:34:54 +0106
Message-Id: <20221114162932.141883-2-john.ogness@linutronix.de>
In-Reply-To: <20221114162932.141883-1-john.ogness@linutronix.de>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

Unprotected list walks are not necessarily safe.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/tty/serial/kgdboc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 7aa37be3216a..e76f0186c335 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -193,6 +193,7 @@ static int configure_kgdboc(void)
 	if (!p)
 		goto noconfig;
 
+	console_lock();
 	for_each_console(cons) {
 		int idx;
 		if (cons->device && cons->device(cons, &idx) == p &&
@@ -201,6 +202,7 @@ static int configure_kgdboc(void)
 			break;
 		}
 	}
+	console_unlock();
 
 	kgdb_tty_driver = p;
 	kgdb_tty_line = tty_line;
-- 
2.30.2

