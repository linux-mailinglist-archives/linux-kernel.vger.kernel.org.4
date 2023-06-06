Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53785723E34
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbjFFJtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbjFFJtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:49:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EA010C0;
        Tue,  6 Jun 2023 02:48:58 -0700 (PDT)
Date:   Tue, 6 Jun 2023 11:48:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686044936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KSa4OY9dsWXX7LG19K4ps06QwMPn/kJbzHoa0LvQ/dI=;
        b=kD6EPcw8dfX8tpFG4VG8J3fP0j3U6yVTftzZul3WT4zmlELTbQOT5cnUQvQlKUhdLh8Hbg
        t2OO5xKtxJTTdTicNTD8UGPPkCzPzIQvZKnNI8YEii8e8jLBYMpAcQQV+n8ePSaC7/g5D2
        trt7kdkXsSUDhsQjZt7B5In/yPv4E1/WFQQq53FoxYk+IhBPgegvZdsYLz1bXSNbS4TPeo
        gGWXdfdr+d/HxR0UacwZmwpBVqmk5tGfRLL22eTzC/T+ETyO6b8TMD1fUgtM5ELXmA6ahr
        bJ6XpGSE1SNRCHxt1iVHrY4297Kn3R/jdmvng2cLleiSojDUFJQtA4W8M5qvQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686044936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KSa4OY9dsWXX7LG19K4ps06QwMPn/kJbzHoa0LvQ/dI=;
        b=CAkW+0ZxzgX8EbTa5o4RZs12jtVQjzM2EIG7LLHwHbFe93r/jfHiMwkAhjXeMdJrnwnkyz
        r7nurGx2ELrFK0Ag==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [ANNOUNCE] 5.10.180-rt88
Message-ID: <20230606094855.v8zhk78I@linutronix.de>
References: <ZHZSlJFnTK1IpXeg@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZHZSlJFnTK1IpXeg@uudg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-30 16:46:28 [-0300], Luis Claudio R. Goncalves wrote:
> Hello RT-list!
Hi,

> Support for deferred printing was removed in v5.10-rc1-rt1 by commit
> 9153e3c5cb0c9 ("printk: remove deferred printing").

Sorry for not getting back to earlier, where you proposed the change.

> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 83c7734e98025..92e0656841128 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -609,7 +609,7 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
>  #define print_hex_dump_bytes(prefix_str, prefix_type, buf, len)	\
>  	print_hex_dump_debug(prefix_str, prefix_type, 16, 1, buf, len, true)
>  
> -#ifdef CONFIG_PRINTK
> +#if defined(CONFIG_PRINTK) && !defined(CONFIG_PREEMPT_RT)
>  extern void __printk_safe_enter(void);
>  extern void __printk_safe_exit(void);

This needs to go entirely. The "new" printk code does not need this safe
functions also for !RT.

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 5f1c50a6bebc5..7e65e3ef16e3a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6057,7 +6057,6 @@ static void __build_all_zonelists(void *data)
>  	 * tty_insert_flip_string_and_push_buffer() on other CPU might be
>  	 * calling kmalloc(GFP_ATOMIC | __GFP_NOWARN) with port->lock held.
>  	 */
> -	printk_deferred_enter();

That is okay. However the commit, that introduced this
	a992c387b4118 ("mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock")

also added a local_irq_safe a little higher up and it has to go, too.
The code as-is should produce warnings once it enters this path.

>  	write_seqlock(&zonelist_update_seq);
>  
>  #ifdef CONFIG_NUMA

Sebastian
