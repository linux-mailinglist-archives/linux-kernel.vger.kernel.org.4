Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0049D73FA3E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjF0KaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjF0KaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5218F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:30:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38B8E610A5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D5EC433C0;
        Tue, 27 Jun 2023 10:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687861806;
        bh=FOeyj2T+q71UWDj37Av5ICv8IlRSfBwsz7KuaG/aBps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZjNgANBOJZY7eHx10ZRfadTQTLLgP2u+lZ/0gzlVU//tWQ45RZBo+I6lUS6Wuk30M
         ueYy+oPqfhitnSwse8I5nTr6iCiB/U1SRSEbpNkTatbOvTarojpmoelZ9t8pfinODh
         4+X0VLhCbVuX8jpn0E+JuZ40+eg+chTS8pZivgqZrACCWYYwed9Iwdy+NzXJBbJEre
         yhJ8plXtFihmQxc7EiDeaKjWhaOey7zYmTZUef8ehe/w6+R4PVdo8HvZn3y49317lb
         IyxfamVFoA6wzDvJi0OzqapEipxpsFExXudAOojWevB6sEuyeHW+JgIwmOtaVqIiTy
         e7QfFr0ERCh1g==
Date:   Tue, 27 Jun 2023 12:30:03 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch 11/45] posix-cpu-timers: Remove incorrect comment in
 posix_cpu_timer_set()
Message-ID: <ZJq6K4XGGVWTGLE2@lothringen>
References: <20230606132949.068951363@linutronix.de>
 <20230606142031.648340279@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606142031.648340279@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:37:36PM +0200, Thomas Gleixner wrote:
> A leftover from historical code which describes fiction.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


> ---
>  kernel/time/posix-cpu-timers.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -704,13 +704,8 @@ static int posix_cpu_timer_set(struct k_
>  		}
>  	}
>  
> +	/* Retry if the timer expiry is running concurrently */
>  	if (unlikely(ret)) {
> -		/*
> -		 * We are colliding with the timer actually firing.
> -		 * Punt after filling in the timer's old value, and
> -		 * disable this firing since we are already reporting
> -		 * it as an overrun (thanks to bump_cpu_timer above).
> -		 */
>  		unlock_task_sighand(p, &flags);
>  		goto out;
>  	}
> 
