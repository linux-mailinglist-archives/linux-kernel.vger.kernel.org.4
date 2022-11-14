Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B02E62856C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbiKNQbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbiKNQa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:30:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570182EF32;
        Mon, 14 Nov 2022 08:29:48 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ihos3kVL43GcNnwvRQa8EAkart8aw0DgSI6lBkWbDJU=;
        b=gDRDGEIlmAFx9jHad/WBpJk7dYEPGJDAe4Rk61bOKfOqT3mehUsQKb4keYsUMPSPsdPCH3
        rh/IqkNd2kP12Z7ZZJ5Q6UpQi26MMcGDyn79l+kAgPljp3n+P/nE9gbcQHMels/aOZlf04
        gvzaSIAO9Ov+RLj7wqaNb3eSDwxjPoyfs8flmUMma2qp4bWhG3+4S0HLB1HhV1AKJYSgCa
        szkb1zz0UHIRDO1rxOcXWYYeZyPGsEQDX3qRaTEnhRfn5nCLnkBEw1zRJUXCVuYN2De9ix
        pXy9j1e90b+yrfTItl3IJ3+fhxo/dA8V2eV6JZTU15Mr0n7Yj/pazIX44e1v5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ihos3kVL43GcNnwvRQa8EAkart8aw0DgSI6lBkWbDJU=;
        b=qEGMwJgLtL6+f1KskwLCVPpGRA/Rkj8qPXYJz8mOscQn36t/rcF9+WsdQUG6lPJ/3gDIvG
        HaEcIL6ZNzGiLpDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH printk v4 29/39] usb: early: xhci-dbc: use console_is_registered()
Date:   Mon, 14 Nov 2022 17:35:22 +0106
Message-Id: <20221114162932.141883-30-john.ogness@linutronix.de>
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

It is not reliable to check for CON_ENABLED in order to identify if a
console is registered. Use console_is_registered() instead.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/usb/early/xhci-dbc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index bfb7e2b85299..797047154820 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -927,7 +927,7 @@ void __init early_xdbc_register_console(void)
 
 static void xdbc_unregister_console(void)
 {
-	if (early_xdbc_console.flags & CON_ENABLED)
+	if (console_is_registered(&early_xdbc_console))
 		unregister_console(&early_xdbc_console);
 }
 
-- 
2.30.2

