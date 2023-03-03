Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEB86A95A6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCCK4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjCCK4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:56:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D0C30B0D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 02:56:49 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677841006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zRgsR2xEWYTWX691F+Y+Zz/v3gKexsUP6akBuivKZYM=;
        b=iNbKOxdpjevaKnEeelU+IxV49VCUPumEVqb2zOVwlZaLvro7HGWLNZ5Xk0AK4evmtTxi+6
        pSbMOj0KPyZWtpRAq9rWHUNUakRvk0a4h+rta9W2s6VcxidGFEPfZAvaNaUQyCQD3FSUOK
        fx2JYvBsU98RJ4lmAUqchITSqah+ge1Io8vWS4mSruY6OcghsAKlaq7AGokSEk78f0Fsjl
        +twnFe+ztVwBE6Gfj/nx+nYvtBSKldTtZ6oMTiwhxf1GBR1faVkok0dBiT/xC0yFroUNEt
        sSCIsOrhaSC7kq7jH72GAXkXrUmhrn6xqioJ9nOW0ZqthkqaCyIFGfMaFAFoeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677841006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zRgsR2xEWYTWX691F+Y+Zz/v3gKexsUP6akBuivKZYM=;
        b=8ka/6gJCXJrPPeoX0PZqbAlbEYt3pbF+dK5H7jakaEO+0IuQeNoV+uDnfLnydqNYuQSjAq
        A0+j4DCimsTKGGAQ==
To:     kernel test robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 10/18] printk: nobkl: Add emit function and
 callback functions for atomic printing
In-Reply-To: <202303030859.j7DLimWU-lkp@intel.com>
References: <20230302195618.156940-11-john.ogness@linutronix.de>
 <202303030859.j7DLimWU-lkp@intel.com>
Date:   Fri, 03 Mar 2023 12:01:23 +0106
Message-ID: <87mt4uw1d0.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-03, kernel test robot <lkp@intel.com> wrote:
>>> kernel/printk/printk.c:2841:6: warning: no previous prototype for 'printk_get_next_message' [-Wmissing-prototypes]
>     2841 | bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>          |      ^~~~~~~~~~~~~~~~~~~~~~~

This function needs to be declared for !CONFIG_PRINTK as well.

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 8856beed65da..60d6bf18247e 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -188,10 +188,11 @@ struct cons_context_data {
 	struct printk_buffers		pbufs;
 };
 
-#ifdef CONFIG_PRINTK
-
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 			     bool is_extended, bool may_supress);
+
+#ifdef CONFIG_PRINTK
+
 void console_prepend_dropped(struct printk_message *pmsg,
 			     unsigned long dropped);
 
