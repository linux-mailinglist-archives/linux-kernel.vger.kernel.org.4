Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED5B7228C3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjFEO0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjFEO0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:26:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB97699
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:26:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86E3261361
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 14:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EE3C433EF;
        Mon,  5 Jun 2023 14:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685975196;
        bh=riZ6RIajBfnKWVAP+l75FazrFPYYacaLdTA1K64PwTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxpZCjJazPbm1NIgKyTkwvU9CBKuNrVNf4HiIqR5xGw5UF1X5C94bRkfPeEZv+ETz
         3Fe5s8f9W+uPBfi1b9JZbIrj4e8iRuqtI5Obkbz09PEhpNk2XySzqrDCgS46gnvSbI
         2TdpJU/SFccNTubNuUKokuu8KTebkorQ5y45+7VTc/AbFlNGUegPJn3MxyUFmCW0Sr
         MrsfLXkZvvY4srPhBPgfRP6CUAmVqeCN7CZoCx5cphq5Ov9z806ZefScT9IRYjZ7Q/
         ZWdNhWKeBHaBArp6a7Npp6nH88dCZJ+2FwBKflL1AOmXu4ZQ9e2TJ1EsVbNegzYmyD
         FwlsM41c73hgQ==
Date:   Mon, 5 Jun 2023 16:26:33 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 18/20] posix-timers: Clarify posix_timer_fn() comments
Message-ID: <ZH3wmQLHyJuEH2yw@2a01cb0980759691cfef005a85b365eb.ipv6.abo.wanadoo.fr>
References: <20230425181827.219128101@linutronix.de>
 <20230425183313.777610259@linutronix.de>
 <ZHibcwrDgegKwQeQ@lothringen>
 <874jnrdmrq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874jnrdmrq.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, Jun 01, 2023 at 09:07:37PM +0200, Thomas Gleixner a écrit :
> @@ -359,34 +360,35 @@ static enum hrtimer_restart posix_timer_
>  			 * FIXME: What we really want, is to stop this
>  			 * timer completely and restart it in case the
>  			 * SIG_IGN is removed. This is a non trivial
> -			 * change which involves sighand locking
> -			 * (sigh !), which we don't want to do late in
> -			 * the release cycle.
> +			 * change to the signal handling code.
> +			 *
> +			 * For now let timers with an interval less than a
> +			 * jiffie expire every jiffie and recheck for a
> +			 * valid signal handler.
> +			 *
> +			 * This avoids interrupt starvation in case of a
> +			 * very small interval, which would expire the
> +			 * timer immediately again.
>  			 *
> -			 * For now we just let timers with an interval
> -			 * less than a jiffie expire every jiffie to
> -			 * avoid softirq starvation in case of SIG_IGN
> -			 * and a very small interval, which would put
> -			 * the timer right back on the softirq pending
> -			 * list. By moving now ahead of time we trick
> -			 * hrtimer_forward() to expire the timer
> -			 * later, while we still maintain the overrun
> -			 * accuracy, but have some inconsistency in
> -			 * the timer_gettime() case. This is at least
> -			 * better than a starved softirq. A more
> -			 * complex fix which solves also another related
> -			 * inconsistency is already in the pipeline.
> +			 * Moving now ahead of time by one jiffie tricks
> +			 * hrtimer_forward() to expire the timer later,
> +			 * while it still maintains the overrun accuracy
> +			 * for the price of a slight inconsistency in the
> +			 * timer_gettime() case. This is at least better
> +			 * than a starved softirq.

Could be hardirq. How about:

"This is at least better than a timer storm."

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
