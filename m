Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1129A6DEAE9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjDLFUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDLFUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:20:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A3E4488
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 22:20:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B25762DC4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791C4C433EF;
        Wed, 12 Apr 2023 05:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681276839;
        bh=yXh+zPdD62iUCl7sJbs2hyldBMsSE2x9y7HCaly3Xpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b60RyrvoxymT/OMHE/tfjZeiFwTqxJFea75aUnwuNwABz1lTmcB0Di0jlNe8JC6yq
         xseGO2ONPwGeEcrtlQ6SKVkfaVwcjDyKeADYUHOiXOcYGdNuV8TnWP78k7h165LKF5
         MCCpGREjIsU0c1W18lRiOUww7dDl+j7yTpBoD3MH5NyasMm7oaBteGQSIfyIM4eJnR
         FaCQv0gVN8nC1wYdHq4X8yar/Sj44RNhshXooQLdR8MVPTsJ64ig9k2hqaclh7BNxd
         oHILi1akl3+Ap/vKKx7rL9A6zQz6FcTIVKLalgkqNXjrbiCOBf3QStsyshRLl9cYxG
         3BmZx8vJaJkyA==
Date:   Tue, 11 Apr 2023 22:20:37 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     peterz@infradead.org, keescook@chromium.org,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, rostedt@goodmis.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86: make __get_wchan() use arch_stack_walk()
Message-ID: <20230412052037.nz75jeoeqibx6otr@treble>
References: <20230330081552.54178-1-zhengqi.arch@bytedance.com>
 <20230330081552.54178-3-zhengqi.arch@bytedance.com>
 <20230408050822.ezdbhc6j7zuvutrm@treble>
 <fffd59ff-eaa8-bba7-03f2-9fc27620bd1c@bytedance.com>
 <20230408221206.mi7nsquoxklgword@treble>
 <4aba3e74-a205-5dd1-69bc-9186c04e733d@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4aba3e74-a205-5dd1-69bc-9186c04e733d@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2023 at 02:30:23PM +0800, Qi Zheng wrote:
> 
> 
> On 2023/4/9 06:12, Josh Poimboeuf wrote:
> > On Sat, Apr 08, 2023 at 01:36:06PM +0800, Qi Zheng wrote:
> > > 
> > > 
> > > On 2023/4/8 13:08, Josh Poimboeuf wrote:
> > > > On Thu, Mar 30, 2023 at 04:15:52PM +0800, Qi Zheng wrote:
> > > > > Make __get_wchan() use arch_stack_walk() directly to
> > > > > avoid open-coding of unwind logic.
> > > > > 
> > > > > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > > > 
> > > > Can we just have a shared version of __get_wchan() for all
> > > > CONFIG_ARCH_STACKWALK arches?
> > > 
> > >  From a quick glance, I think it's ok, but we still need to define
> > > the arch's own get_wchan_cb(). I will try to do it.
> > 
> > Hm, why would we need to do that?
> 
> Because I see checks for count++ < 16 exist in __get_wchan() for some
> arches and some don't. So I'm not sure if this check can be discarded
> after using arch_stack_walk(). And I see that this check is retained in
> arm64, see [1] for details.
> 
> [1]. https://github.com/torvalds/linux/commit/4f62bb7cb165f3e7b0a91279fe9dd5c56daf3457

That difference seems to have nothing to do with individual arch
differences.

The 16-check limit looks like some ancient cargo cult ritual which was
copy-pasted decades ago, presumably to avoid some kind of infinite stack
recursion loop in scheduler code, which should never happen.  That
should definitely be removed.

Another good reason to unify them, to get rid of cruft like that.

-- 
Josh
