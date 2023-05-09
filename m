Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0D56FC691
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbjEIMiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbjEIMiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:38:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE1544A5
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 05:38:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683635930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h4kxchsyaaVSqhuwSS07o+CGltQKN3utS5btQ5n6GOk=;
        b=kqf931XB/l6jJjbVcpDbGWQDpMM621I9GPKYunJEl668nK77PIuhcP4GdXWfy7qY3tO6KP
        GmMmJ6e1O3an0+tBKKQ5oOsBxgOB+P4Mg7EpCuOAYRBhmM+R4oCfHe170qzmaUIaEg0TzF
        8RVXshJLLVFkMc94xD1CyIqxtZ9HcDtcdNObhmOTEbieR3hZSau2r5GK+UISYWcGbVUCqU
        E8qlze913J2n1NhJexrkF4GM5OYbJ/6WYbc1MzYs3Ijth3lLhCYycQ2RPMzjl0h1etuDKz
        4D0td+usz48YwTBkw2cLC2F7iirw3WGozx8bFfiildaUTe+whvdVW6C8kEo9Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683635930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h4kxchsyaaVSqhuwSS07o+CGltQKN3utS5btQ5n6GOk=;
        b=l1LQnw/6lgglWF3xjlLVhCqPJtq2tJpF4pPi8QYaPx/H4p9L7oDJwnofJlOC9ga5T513p2
        HtOMsyzH4gTyM9AQ==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 02/20] posix-timers: Ensure timer ID search-loop limit
 is valid
In-Reply-To: <ZFoVg9UmItpIaA69@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de> <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx> <87v8h62vwp.ffs@tglx> <ZFoVg9UmItpIaA69@lothringen>
Date:   Tue, 09 May 2023 14:38:50 +0200
Message-ID: <877cth1xyd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09 2023 at 11:42, Frederic Weisbecker wrote:
> On Sat, May 06, 2023 at 01:36:22AM +0200, Thomas Gleixner wrote:
>> Unless you think about the theoretical case of an unlimited number of
>> threads sharing the signal_struct which all concurrently try to allocate
>> a timer id and then releasing it immediately again (to avoid resource
>> limit exhaustion). Theoretically possible, but is this a real concern
>> with a timer ID space of 2G?
>
> I didn't go that far actually, it was just me misunderstanding that loop and
> especially the (id =~start) part. Now I got it.
>
> I guess the for statement can just be:
>
> for (; start != id; id++)

My brain based compiler complains about uninitialized usage of @id. I'm
pretty sure it's rightfully complaining and a real compiler would agree,
no?

Thanks,

        tglx
