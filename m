Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54ABC726367
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241127AbjFGOzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbjFGOzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:55:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796C910CE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:55:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1598264056
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 14:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CA2C433D2;
        Wed,  7 Jun 2023 14:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686149734;
        bh=vK5wtnM6iJmNzrRhOdMaLhRBkGv8evYYP+H7CYwmXC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EdGtaxIPES1T9mApxXwWAK3eInmvNC79mApd2zO+nI9M4M3w98ID/zi8vuhKj94c7
         oYLyl+bH6l5HgWgFSuw2IuT+ILJlfsxwC42EYnZS7JHki8WxbXFNbjGjNTH5BJm1bX
         fwvky6FL7tVcyd+RPYVgue8CVK768+u4Gwzr0D3r13Xp2LtQj1e4lSmiBDkWpjx93+
         TVIRYNgkDWVQ74pRqOEsVXxxhFd9TT1DjOMtypUpwWXaUKln+vF6KYHCI2PdDByXZJ
         a8dtG/34O72X08OYwnP5g1fl7XHb8DHlOOf6YtMjTjydOpl14CbUKrwciFmy2QK7Vv
         jBV8pFRf97WKw==
Date:   Wed, 7 Jun 2023 16:55:31 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v7 15/21] timer: Add get next timer interrupt
 functionality for remote CPUs
Message-ID: <ZICaY9/vpEPoHE7q@lothringen>
References: <20230524070629.6377-1-anna-maria@linutronix.de>
 <20230524070629.6377-16-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524070629.6377-16-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 09:06:23AM +0200, Anna-Maria Behnsen wrote:
> +# ifdef CONFIG_SMP
> +/**
> + * fetch_next_timer_interrupt_remote
> + * @basej:	base time jiffies
> + * @basem:	base time clock monotonic
> + * @tevt:	Pointer to the storage for the expiry values
> + * @cpu:	Remote CPU
> + *
> + * Stores the next pending local and global timer expiry values in the
> + * struct pointed to by @tevt. If a queue is empty the corresponding
> + * field is set to KTIME_MAX. If local event expires before global
> + * event, global event is set to KTIME_MAX as well.
> + *
> + * Caller needs to make sure timer base locks are held (use
> + * timer_lock_remote_bases() for this purpose). Caller must make sure
> + * interrupts are reopened, if required.

That last sentence looks weird. All we want is the caller to call this
and the timer_[un]lock functions with interrupts disabled.

Now of course at some point the caller will need to unmask the IRQs
but heh, not our problem :)

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
