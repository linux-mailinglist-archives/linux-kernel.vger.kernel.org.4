Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1511E694B19
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjBMP1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjBMP1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:27:40 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5561C8A41
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XokbwITZbA4yJxooLN1vSQzP0sY0c4YQV6Ht0KS44UA=; b=JJZA78/wSrUtJ9NXp5/QsfNXCt
        0tKCMEkBAjUBO9/UnYhNKETtcTnxuSlScjlflrjcJBLGlJXUdJ8gjP3T4NX5ZuVzjWP8fFVYdGyS4
        NZk/aFdozk5C7M7x1fQQzA2bFC48cmkmPH9AP5ObrtYhuoEAGz9AJvyovDN2e9pMHEj6lD0OmDsbT
        PvnzkecFiMpMI/90or0fwfGdLtcxyx+EKnxKjtLK1wGj5HjnHcrw98Bb3nKhFQr77MHPgR1TVteWG
        9taA1MXVcawIvp1DdonPt8fhEl3RBOyG1v5epth+NuseyARvtnOfKLkyFhw2sucGRhP+VvczTm7pA
        K2Z41avA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pRais-009M35-2c;
        Mon, 13 Feb 2023 15:26:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 27B0330030F;
        Mon, 13 Feb 2023 16:27:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1028920835894; Mon, 13 Feb 2023 16:27:11 +0100 (CET)
Date:   Mon, 13 Feb 2023 16:27:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Schspa Shi <schspa@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+6cd18e123583550cf469@syzkaller.appspotmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [syzbot] WARNING: locking bug in umh_complete
Message-ID: <Y+pWzult7UDgoilC@hirez.programming.kicks-ass.net>
References: <20230127014137.4906-1-hdanton@sina.com>
 <9d9b9652-c1ac-58e9-2eab-9256c17b1da2@I-love.SAKURA.ne.jp>
 <7d1021f1-c88e-5a03-3b92-087f9be37491@I-love.SAKURA.ne.jp>
 <Y9z76ZLe4On96xIN@hirez.programming.kicks-ass.net>
 <Y9z+SerR8mlZYo16@hirez.programming.kicks-ass.net>
 <6c47dbcf-2a17-6bb2-719b-841d851c603b@I-love.SAKURA.ne.jp>
 <Y90ar35uKQoUrLEK@hirez.programming.kicks-ass.net>
 <caa13441-5f95-b7d6-dd5d-1cf49e709714@I-love.SAKURA.ne.jp>
 <Y+Eh9CFdTwwv+hot@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+Eh9CFdTwwv+hot@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 07:51:16AM -0800, Luis Chamberlain wrote:

> I think this seems to be the same issue that Schspa Shi reported / provided a
> fix sugggestion for [0]. This lead me to ask if:
> 
>   a) incorrect usage of completion on stack could be generic and;
>   b) if we should instead have an API helper for that?
> 
> Although he already implemented a suggestion for b) to answer a) we need
> some SmPL constructs yet to be written by Schspa. The reason I asked for
> b) is that if this is a regular pattern it begs for a) as this sort of
> issue could be prevalent in other places. So the status of Schspa's work
> was that he was going to work on the SmPL grammar to check how frequent
> this incorrect patern could be found.

Do I read correctly, from you above alphabet-soup, that someone is
working on some static analysis for on-stack completions or something?

If so, perhaps the simplest rule would to be ensure there is an
unconditional uninterruptible wait-for-completion() before going out of
scope.

This latter can be spelled like wait_for_completion() or
wait_for_completion_state(TASK_UNINTERRUPTIBLE). More specifically,
TASK_INTERRUPTIBLE and TASK_WAKEKILL must not be set in the state mask
for the wait to be uninterruptible.

If it cannot be proven, raise a warning and audit or somesuch.
