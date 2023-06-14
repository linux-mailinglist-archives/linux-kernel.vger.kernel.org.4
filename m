Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C78E72F8F0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbjFNJWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbjFNJWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:22:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223C8E6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JNVBaXAEDwRQkV1bpJQicoSKIIZSGP2RaOTVLSjdsPY=; b=Y9ccCGmgUwhbAji12G3nyANtZk
        9U1Pb/SfpPnOJPEeo1vXg4c+cFl70g5VlcMAFs+zj7k5oQJIhjEflBeuE8ytbbZVh1tWgARhUwJx0
        tlQcA6QWTFnmscymidT7akK+F3NZaozSFTC9TF+bkSW0zs/5eYPM59blih9benJk7pCnrDiiNQ1ak
        eK1VDDtgyi0RNZU5ZqT/6QO2xCFWzs3y+Cb1REbuBa/pJaVJ3BkqERMDMmGgmNqYaccgtlbLbVlJE
        XbUgxIPMDqo8UdG2og8fZ04DVTN6kR4faBIZpwWmtCcoqVwvSbDoYdgNmf8xym0jSpWYU+U/S+/IQ
        suBcBBcA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9MhT-00AfQc-2b;
        Wed, 14 Jun 2023 09:22:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2BC94300188;
        Wed, 14 Jun 2023 11:21:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 915B82C676971; Wed, 14 Jun 2023 11:21:58 +0200 (CEST)
Date:   Wed, 14 Jun 2023 11:21:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     Aaron Thompson <dev@aaront.org>, linux-kernel@vger.kernel.org
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230614092158.GF1639749@hirez.programming.kicks-ass.net>
References: <20230613134105.GA10301@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613134105.GA10301@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 02:41:05PM +0100, Richard W.M. Jones wrote:
> [Being tracked in this bug which contains much more detail:
> https://gitlab.com/qemu-project/qemu/-/issues/1696 ]

Can I please just get the detail in mail instead of having to go look at
random websites?

> Recent kernels hang rarely when booted on qemu.  Usually you need to
> boot 100s or 1,000s of times to see the hang, compared to 292,612 [sic]
> successful boots which I was able to do before the problematic commit.
> 
> A reproducer (you'll probably need to use Fedora) is:

Debian only shop here... in fact, I still have machines without systemd.

>   $ while guestfish -a /dev/null -v run >& /tmp/log; do echo -n . ; done
> 
> You will need to leave it running for probably several hours, and
> examine the /tmp/log file at the end.
> 
> I tracked this down to the following commit:
> 
>   commit f31dcb152a3d0816e2f1deab4e64572336da197d
>   Author: Aaron Thompson <dev@aaront.org>
>   Date:   Thu Apr 13 17:50:12 2023 +0000
> 
>     sched/clock: Fix local_clock() before sched_clock_init()
>     
>     Have local_clock() return sched_clock() if sched_clock_init() has not
>     yet run. sched_clock_cpu() has this check but it was not included in the
>     new noinstr implementation of local_clock().
> 
>   (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f31dcb152a3d0816e2f1deab4e64572336da197d)
> 
> Reverting this commit fixes the problem.
> 
> I don't know _why_ this commit is wrong, but can we revert it as it
> causes serious problems with libguestfs hanging randomly.
> 
> Or if there's anything you want me to try out then let me know,
> because I can reproduce the problem locally quite easily.

Well, since it's virt and all, can you attach gdb to the gdb-stub and
see where it's at? Any clue is better than no clue.
