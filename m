Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4655F73E1FE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjFZOWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjFZOVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:21:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939392135
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:20:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687789190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ngm5SNIc7qaDpF8d3m19g9+Q/sZ/NSUz+Si3W6tR2dM=;
        b=DNZXyqA9av87SdhMjMWT2t9zLRBtio/bDNUeSRntSxQVrx1Y9VRVmJbE8DvZGN7zSo/hkl
        YKM94vpkprr6ddVPf43EbWaw+LWBXHqGJyHzHVwHh7rh051XqnLU0C5csyK+3vmmOD24to
        QYpmt7oXl5g2LiNR8C3Po2MAOEAHkTdJEMqToGP7VSIRziNLUpIapAuA9/zFjV0TUz7Xun
        3LUXCfEFjQ+e06pk/a++LqugJMHGe6zDwIQrBH9WQV0z6qFHX6Mm/GL6ReHwufjOmN9SKy
        UMPN9UHzyXCGc6DnE5SBEkGXKzr357/wWmOXTGz17tkignC8fxFtIBgvp4qsDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687789190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ngm5SNIc7qaDpF8d3m19g9+Q/sZ/NSUz+Si3W6tR2dM=;
        b=Qx+APiTTa1xXzgW1iQIPAPgfB/ReMCPTVwXhWqfnLxalAneMzmgyGNdrdteGz8cvua4X5Y
        NlPYk3Hh6YI6RKDw==
To:     You Kangren <youkangren@vivo.com>,
        "open list:POSIX CLOCKS and TIMERS" <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com, youkangren@vivo.com
Subject: Re: [PATCH] posix-timers: Release the acquired lock before returning
In-Reply-To: <20230626120017.3030-1-youkangren@vivo.com>
References: <20230626120017.3030-1-youkangren@vivo.com>
Date:   Mon, 26 Jun 2023 16:19:50 +0200
Message-ID: <878rc65mrd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26 2023 at 20:00, You Kangren wrote:
> Release the acquired lock before returning to prevent errors

Seriously?

> @@ -599,6 +599,7 @@ static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags)
>  		 */
>  		if (timr->it_signal == current->signal) {
>  			rcu_read_unlock();
> +			spin_unlock_irqrestore(&timr->it_lock, *flags);
>  			return timr;

The name of this function is __lock_timer() so it better returns with
the timer locked, no?

>  		}
>  		spin_unlock_irqrestore(&timr->it_lock, *flags);
> @@ -1066,9 +1067,10 @@ static void itimer_delete(struct k_itimer *timer)
>  		 * do_exit() only for the last thread of the thread group.
>  		 * So no other task can access and delete that timer.
>  		 */
> -		if (WARN_ON_ONCE(timer_wait_running(timer, &flags) != timer))
> +		if (WARN_ON_ONCE(timer_wait_running(timer, &flags) != timer)) {
> +			spin_unlock_irqrestore(&timer->it_lock, flags);

There is no lock held in that case.

Thanks,

        tglx
