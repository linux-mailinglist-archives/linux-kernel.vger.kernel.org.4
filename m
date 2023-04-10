Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D4E6DCD88
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjDJWiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJWiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:38:21 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D7E1BCC;
        Mon, 10 Apr 2023 15:38:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 566856D9;
        Mon, 10 Apr 2023 22:38:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 566856D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1681166300; bh=/lYt8/XY4xRlf2u3bBtJmDZ8TPXQC6ureYYFEZbdOYU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LSndp042OPJEi1j120AU19XQQQXYjEOwhKVMHzh7KXLHvffiEou/JQ5zIEjVvGrLJ
         6NGAqrcWl+kuBJanGgSy5pHmAJGa5Q95FsjIMZN90D6G9ysdV5pJMnyRTm3qXcp1YF
         tUwPL/BsQu/FKBKCQ2a2wn+iQ7PhP0W8RaffmE5Yd2OpuLIcsTjktf9s0pQ3OSOBht
         Z3//wpXrcOPY+Qa9zQQcmiyUb4RunnQCKY7VfkhzsBl/4MbsMkx7/ZVK3WEx9JiuM4
         BisVkpONIHCPBpUY7DEPk741Ea6sQXoa2YS7rvg48vwSqpSxfm9qI4/Cm+QREtKYsD
         I3h+Gp84z6DZg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Feng Tang <feng.tang@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Mario <jmario@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, dave.hansen@intel.com,
        ying.huang@intel.com, andi.kleen@intel.com,
        Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v4] Documentation: Add document for false sharing
In-Reply-To: <20230407041235.37886-1-feng.tang@intel.com>
References: <20230407041235.37886-1-feng.tang@intel.com>
Date:   Mon, 10 Apr 2023 16:38:19 -0600
Message-ID: <877cuje52c.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feng Tang <feng.tang@intel.com> writes:

> When doing performance tuning or debugging performance regressions,
> more and more cases are found to be related to false sharing [1][2][3],
> and the situation can be worse for newer platforms with hundreds of
> CPUs. There are already many commits in current kernel specially
> for mitigating the performance degradation due to false sharing.
>
> False sharing could harm the performance silently without being
> noticed, due to reasons like:
> * data members of a big data structure randomly sitting together
>   in one cache line
> * global data of small size are linked compactly together
>
> So it's better to make a simple document about the normal pattern
> of false sharing, basic ways to mitigate it and call out to
> developers to pay attention during code-writing.
>
> [ Many thanks to Dave Hansen, Ying Huang, Tim Chen, Julie Du and
>   Yu Chen for their contributions ]
>
> [1]. https://lore.kernel.org/lkml/20220619150456.GB34471@xsang-OptiPlex-9020/
> [2]. https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
> [3]. https://lore.kernel.org/lkml/20230307125538.818862491@linutronix.de/
>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Applied, thanks.

jon
