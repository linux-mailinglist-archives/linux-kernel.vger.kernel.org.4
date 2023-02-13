Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C9C694ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBMPPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjBMPOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:14:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212321E2BC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DddUdFnT5YKRjSBaNvrwFw2LOUY1jD/ic2jpWx5YLiQ=; b=SQsyeyxcFsVdKxdwTuzLU/Cr9c
        ZV8eOiPD9S8Gnu42L5p78+u6DyqUEqvLeix0ZueOe+0Hv3UmITXHRcRfKOyBrf3cML+Grv1noj+z/
        R5aMf9Q9rFriUoeC5OYdSk2k7EjRkeJqIVl5Y/6oF+kqkD87IDulFdYpuWy0H8sy+dNawF9Fqybit
        bUGFH1oWWdY7GgQo3DrX+TXSWISmZxyeJ26ycRvvGwr7za57KcOUVXmfl/Ny2OW66YEMMCWUmumeN
        9DE28Hv9njhwNW1YpXcQlNQ4ChSgXKBg/tXX2Ze6MOqzCJGbJnyoGETh2zG2UthcOmXkRW00+Ro7D
        RGWwlPPA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRaX2-005sEI-1C; Mon, 13 Feb 2023 15:14:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3FA0A30049E;
        Mon, 13 Feb 2023 16:14:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23D1D209A00B5; Mon, 13 Feb 2023 16:14:15 +0100 (CET)
Date:   Mon, 13 Feb 2023 16:14:15 +0100
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
Message-ID: <Y+pTx0yFUrMpR8E2@hirez.programming.kicks-ass.net>
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
> 
> Please let me know your thoughts as perhaps this issue / discussion
> didn't get on Peter's radar as it was rececently discussed with Schspa
> despite being on Cc.
> 
> [0] https://lore.kernel.org/all/m2pmcoag55.fsf@gmail.com/T/#u

-ETOODAMNMUCHEMAIL :-/

Urgh, esp. :

  https://lore.kernel.org/all/m2pmcoag55.fsf@gmail.com/T/#m9f0105d28fcfe4947a2583cd3d425169c4fe5dfa

is quite insane.
