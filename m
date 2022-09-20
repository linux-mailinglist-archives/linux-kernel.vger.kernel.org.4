Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BC55BDEE7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiITH5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiITH5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:57:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649C82DFA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:57:03 -0700 (PDT)
Date:   Tue, 20 Sep 2022 09:56:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663660621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sCP9yCQxHK6W8zHLhqzhqlMNVNEueRQZsr8D5yISAcA=;
        b=F3DZmMwmkTWUYbHkI5PkXxTCHsXuUfdPA4SDS+pXBz4c+aOIVMsQqJHyJ91jqBeunczZUK
        xy1SuRjyW+/0aFJIYmWjkzVckARm/9nh0frSlKF7BG7nZIBlpmCYChFFNXbqKNNj6GnpRk
        uIR61kI/wzQrWDIkqycFLVo3/UDc9cVW9Foc9cbpoR8BkJx/eJjTRui66UAxjY8t2n0T58
        +SJj1whEfmToVyHTPRRBdby/JhmWeNEMdX9fmaKfELxh6UzlUWlTh22WrehiKSAeGjcnQ8
        QTiQmC1CVS3l8wk6HHbdb0xKoI6GEXXR2hJWc1mMQb/czM6sABurXX+FCWaMfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663660621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sCP9yCQxHK6W8zHLhqzhqlMNVNEueRQZsr8D5yISAcA=;
        b=t4fqyrc35iuryhQT7o7XzHa4e+Oqg5YW5RryTnAtZF8vYmXrMNFsvJyj0hLJVqn5w859Lh
        oKdSpSKrroythzCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Maurizio Lombardi <mlombard@redhat.com>, vbabka@suse.cz,
        linux-mm@kvack.org, rientjes@google.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] mm: slub: fix flush_cpu_slab()/__free_slab()
 invocations in task context.
Message-ID: <YylyS7rKigh85sGa@linutronix.de>
References: <20220919163929.351068-1-mlombard@redhat.com>
 <Yylv4TRbrhwCrCnR@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yylv4TRbrhwCrCnR@hyeyoo>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-20 16:46:41 [+0900], Hyeonggon Yoo wrote:
> > @@ -2730,7 +2735,7 @@ static void flush_all_cpus_locked(struct kmem_cache *s)
> >  		INIT_WORK(&sfw->work, flush_cpu_slab);
> >  		sfw->skip = false;
> >  		sfw->s = s;
> > -		schedule_work_on(cpu, &sfw->work);
> > +		queue_work_on(cpu, flushwq, &sfw->work);
> 
> Hi. what happens here if flushwq failed?
> 
> I think avoiding BUG_ON() makes sense,
> but shouldn't we have fallback method?

You get an output to act on and fix. The point is that it shouldn't have
happen in the first place. With the bug_on() that early, chances are
that you never see anything but a blank screen. So with the warn_on you
get probably to see the warn_on before you get here.

Sebastian
