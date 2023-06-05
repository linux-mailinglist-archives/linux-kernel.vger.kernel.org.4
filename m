Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D23F722899
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjFEORb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbjFEORR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:17:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B291AF9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:17:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B8EC621D8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 14:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5E1C433D2;
        Mon,  5 Jun 2023 14:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685974627;
        bh=EjKVzHEQE6AFEn44fePw694F4A8RUgP5HVlndyzHc24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TVwrJXBAr1d8PjsQQMfP40s6ci3Jfo0A0cP0TJ1GtlDl1qQQSjUu3RoRGE8o7QnAY
         w5klcNEXW2zyHar/0nU/6h3syLB9bNHXQy8sbMhP21bVwE/ShWRVzbiBTyITQnWjJg
         81E13a3eyb4VW4FrX7xdIdogzodmZ3uRbGwPLM6U1KhUll8oX8J0ebvSymOpj0YILX
         9POtIPnBivwwbrlxKE0Y9j3JdQRcS+OR7+zGlIXoHu0XqnFjOOZcuEX2LGEzqTsgu2
         x0ARjrCjOmwck6Qr5mxtYBcFsnixEtw6nCJhSEsEspAPh8NVXPhCGrFZymYR4SiU8x
         zuwvC73TgHV6w==
Date:   Mon, 5 Jun 2023 16:17:04 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch v2 02/20] posix-timers: Ensure timer ID search-loop limit
 is valid
Message-ID: <ZH3uYNznMXMbwjbM@2a01cb0980759691cfef005a85b365eb.ipv6.abo.wanadoo.fr>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de>
 <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx>
 <87v8h62vwp.ffs@tglx>
 <ZFoVg9UmItpIaA69@lothringen>
 <877cth1xyd.ffs@tglx>
 <ZFpWNIoTo9FfO2t5@lothringen>
 <87bkhzdn6g.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bkhzdn6g.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, Jun 01, 2023 at 08:58:47PM +0200, Thomas Gleixner a écrit :
> posix_timer_add() tries to allocate a posix timer ID by starting from the
> cached ID which was stored by the last successful allocation.
> 
> This is done in a loop searching the ID space for a free slot one by
> one. The loop has to terminate when the search wrapped around to the
> starting point.
> 
> But that's racy vs. establishing the starting point. That is read out
> lockless, which leads to the following problem:
> 
> CPU0	  	      	     	   CPU1
> posix_timer_add()
>   start = sig->posix_timer_id;
>   lock(hash_lock);
>   ...				   posix_timer_add()
>   if (++sig->posix_timer_id < 0)
>       			             start = sig->posix_timer_id;
>      sig->posix_timer_id = 0;
> 
> So CPU1 can observe a negative start value, i.e. -1, and the loop break
> never happens because the condition can never be true:
> 
>   if (sig->posix_timer_id == start)
>      break;
> 
> While this is unlikely to ever turn into an endless loop as the ID space is
> huge (INT_MAX), the racy read of the start value caught the attention of
> KCSAN and Dmitry unearthed that incorrectness.
> 
> Rewrite it so that all id operations are under the hash lock.
> 
> Reported-by: syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
