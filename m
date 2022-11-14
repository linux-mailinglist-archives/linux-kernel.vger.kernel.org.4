Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5646627C74
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbiKNLiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbiKNLiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:38:13 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5414013CCF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=43CxAXBLLYgE1DbXFL71Q2aYCGQ6icUba5GaNeZ6VQg=; b=qMu6ZglD8IPj//yaWoUWTch116
        GUf/RjCnebWPAxHq5tXoF58K9QbQ08xN6DLo1BdA6kXnjNZwDsR0lSAp1gsKHqnsqh2Z/PtOXju2m
        EibTuCqb/pkcqjSViQ0KhbEACK8HmRaXGcp5Zvfn/u89jlAtQL98EbuZeU7BgBL595qhkc4FAow5N
        YLaqGvzyXOCVyFNmtM+QfknqgBUZnsDmcA8gRia+Tg2onWBp39udxXQuBFXIkQs34pVfo8MztMyMG
        Og3vsjxrI+X4Pln+MEDViNgs2/NpKilQeIQl70aEQSjWuu+8qUZf5gasZc2PK7FIoRbbSHcHd5yao
        4wyQuNmg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouXmP-000ome-6R; Mon, 14 Nov 2022 11:37:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B6EF83001FD;
        Mon, 14 Nov 2022 12:37:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 91B0A20ABE4A8; Mon, 14 Nov 2022 12:37:31 +0100 (CET)
Date:   Mon, 14 Nov 2022 12:37:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Izbyshev <izbyshev@ispras.ru>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Yang Tao <yang.tao172@zte.com.cn>
Subject: Re: [PATCH] futex: Resend potentially swallowed owner death
 notification
Message-ID: <Y3Ioe9xq6XE9fmgN@hirez.programming.kicks-ass.net>
References: <20221111215439.248185-1-izbyshev@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111215439.248185-1-izbyshev@ispras.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 12:54:39AM +0300, Alexey Izbyshev wrote:
> Commit ca16d5bee598 ("futex: Prevent robust futex exit race") addressed
> two cases when tasks waiting on a robust non-PI futex remained blocked
> despite the futex not being owned anymore:
> 
> * if the owner died after writing zero to the futex word, but before
>   waking up a waiter
> 
> * if a task waiting on the futex was woken up, but died before updating
>   the futex word (effectively swallowing the notification without acting
>   on it)
> 
> In the second case, the task could be woken up either by the previous
> owner (after the futex word was reset to zero) or by the kernel (after
> the OWNER_DIED bit was set and the TID part of the futex word was reset
> to zero) if the previous owner died without the resetting the futex.
> Because the referenced commit wakes up a potential waiter only if the
> whole futex word is zero, the latter subcase remained unaddressed.
> 
> Fix this by looking only at the TID part of the futex when deciding
> whether a wake up is needed.
> 
> Fixes: ca16d5bee598 ("futex: Prevent robust futex exit race")
> Signed-off-by: Alexey Izbyshev <izbyshev@ispras.ru>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

