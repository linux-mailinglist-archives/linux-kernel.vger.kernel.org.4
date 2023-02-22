Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECB969F200
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjBVJl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjBVJlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:41:05 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B5A2BF21
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=miFmceZ/Cmi0jtcW8Op7ZAfvpqWGZ/5wSm66jO5JBI0=; b=WqCJ63I84/hNLKisgigjZ1YgwZ
        8sk47M3S578eMgSZiPcGV/n5w7a2akDXTzQDfysZCBx4KXgOQzMRFMz1zzQxnjUohHQq78sGRy8/8
        7xkbbLN29YZX7bQrmz/GKy0HLEeuB+y03YlPYDZbgZdAIzsOwqwx/ymxRXqVbnZOyhx2obg29NZeM
        gdz4B7hL1BsmUMtlWRoP6r2BpvMBpe5mx0qhbkyykKdEsQftcreNkJcoUxHt8rc48pQZYm07k2cIs
        OH9grguLnVkUmKuVnmviAFjGzQ/ceL/5/kHZCIakFbCD9FF2VH/+0LEljKf2wzLBjmf9rlDn3+xvo
        0FCDTO2g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pUlWO-00CUI3-17;
        Wed, 22 Feb 2023 09:36:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D3BE03001E7;
        Wed, 22 Feb 2023 10:34:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC72020DD8786; Wed, 22 Feb 2023 10:34:42 +0100 (CET)
Date:   Wed, 22 Feb 2023 10:34:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+6cd18e123583550cf469@syzkaller.appspotmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [syzbot] WARNING: locking bug in umh_complete
Message-ID: <Y/Xhsna3gfadzAAk@hirez.programming.kicks-ass.net>
References: <9d9b9652-c1ac-58e9-2eab-9256c17b1da2@I-love.SAKURA.ne.jp>
 <7d1021f1-c88e-5a03-3b92-087f9be37491@I-love.SAKURA.ne.jp>
 <Y9z76ZLe4On96xIN@hirez.programming.kicks-ass.net>
 <Y9z+SerR8mlZYo16@hirez.programming.kicks-ass.net>
 <6c47dbcf-2a17-6bb2-719b-841d851c603b@I-love.SAKURA.ne.jp>
 <Y90ar35uKQoUrLEK@hirez.programming.kicks-ass.net>
 <caa13441-5f95-b7d6-dd5d-1cf49e709714@I-love.SAKURA.ne.jp>
 <Y+Eh9CFdTwwv+hot@bombadil.infradead.org>
 <Y+pWzult7UDgoilC@hirez.programming.kicks-ass.net>
 <m21qmkahoj.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m21qmkahoj.fsf@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 10:31:58AM +0800, Schspa Shi wrote:
> Peter Zijlstra <peterz@infradead.org> writes:

> > If so, perhaps the simplest rule would to be ensure there is an
> > unconditional uninterruptible wait-for-completion() before going out of
> > scope.
> >
> > This latter can be spelled like wait_for_completion() or
> > wait_for_completion_state(TASK_UNINTERRUPTIBLE). More specifically,
> > TASK_INTERRUPTIBLE and TASK_WAKEKILL must not be set in the state mask
> > for the wait to be uninterruptible.
> >
> > If it cannot be proven, raise a warning and audit or somesuch.
> 
> This is a good suggestion. I have written a SmPL patch to complete this
> check, and now I need to rule out the situation that the driver has
> added an additional lock to protect it.
> 
> And I have found a lot of bad usage, should we consider adding a new
> helper API to simplify the fix this?

Please first share some of the locations where this would be applied.
