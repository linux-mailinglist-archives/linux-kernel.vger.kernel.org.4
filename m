Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E98273DFBC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjFZMsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjFZMry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:47:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5C3295B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:47:02 -0700 (PDT)
Date:   Mon, 26 Jun 2023 14:46:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687783591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VmINLe5aE6bvM7zI6mza4ChXb7pzWJvnvszQrFwxRDQ=;
        b=OqPiNHbVqow5azO7zVRY9vihAbZtmZBg3D7YNXXbb7HCdksak0UhztW5EDVoz23vVTJDqo
        7/RPGZ72QeXDaI3a/CD0+UheqvsE7hz589JRB0DeQ8yX/Nu3lIF3Av8mLZkGrvFEZAogqm
        htCzTDDHqtKZYQorYU9xhh+faqUwBidCFZqLLUCIcuB0Oga/cPUXTmPUZPcb2zYHevc4Yh
        m7VmqnW++CoT0iTN/02DKsJ1woFt2jARa6cULFXfeIVNRLltGUJSJbvmePiXyGStE6lM4s
        puOCg6Ez/4wPjJJO4HswdnLEylhYO8x8FHFqjV/votlfoXF9Rb8pkBN6YZlBAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687783591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VmINLe5aE6bvM7zI6mza4ChXb7pzWJvnvszQrFwxRDQ=;
        b=Bp/2A1C/ULc/ER9a16XwV37SHxAPLTufYUZ+R/9E1X6QwMIfFbaaPhO8yCC/Ct1GkIx/0U
        CcyoOaGseNEa6JBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/2] seqlock: Do the lockdep annotation before locking
 in do_write_seqcount_begin_nested()
Message-ID: <20230626124629.UDvM0W3m@linutronix.de>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
 <20230623171232.892937-2-bigeasy@linutronix.de>
 <d9b7c170-ed0d-5d37-e099-20d233115943@I-love.SAKURA.ne.jp>
 <20230626081254.XmorFrhs@linutronix.de>
 <0a0c768c-227d-c0cd-1b91-5a884d161c1b@I-love.SAKURA.ne.jp>
 <20230626104831.GT4253@hirez.programming.kicks-ass.net>
 <3a4ad958-a9a5-c367-a16d-bd89a173a628@I-love.SAKURA.ne.jp>
 <ZJl4C7aVk3gLLyMs@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJl4C7aVk3gLLyMs@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-26 13:35:39 [+0200], Michal Hocko wrote:
> Is there any reason to backport RT specific fixup to stable trees? I
> mean seriously, is there any actual memory hotplug user using
> PREEMPT_RT? I would be more than curious to hear the usecase.

There is no need for stable backports for RT-only fixes. We have
RT-stable trees for that.
The reason why we fix it in the RT-stable tree is not have something
broken that was known to work.

Sebastian
