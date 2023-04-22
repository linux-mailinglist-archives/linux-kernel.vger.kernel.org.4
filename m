Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF51D6EB9C0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 16:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDVOsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 10:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVOsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 10:48:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882F21723
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 07:48:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 264FF60670
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 14:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF3EC433EF;
        Sat, 22 Apr 2023 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682174923;
        bh=O4rgEkLJmewMNmbBssn0vGFbxV4mGZy57G3IusOA+d4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lqZcPBL8IbGvxblXaJir3U/7j7Th8Z0ZUNwtLiX+mu1NTyR92gnv+oVooKTlWFGXw
         TE2Ie9ei/NV0ezt2Kz/BR/aTkhEvfK6+wGWqLWQwiZYnct+jfN7YfFnGiRLaA6ivcu
         i7qsh1uVzVP20SPhtRLzO7N7GBfL1L27eDT73Lbq2fXTtzyYRdL6lgs/ICzOX+SXUL
         1+HgW4aMfoHY2jeAxoxRm/OaYXgPml94ODZGqn5OvmPoVoNwyjSTHGG4zz7Gk3amGn
         426tUePWmgRH2Xjm5s6nHovp2guapp+rn0N++15/0OwXHuMffKXwLTVfF/AWA6U5BJ
         02kyvVnRtWs+A==
Date:   Sat, 22 Apr 2023 16:48:40 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Loongson (and other $ARCHs?) idle VS timer enqueue
Message-ID: <ZEPzyGZciQF5TPLU@localhost.localdomain>
References: <ZEKDZEQmKExv0O7Q@lothringen>
 <20230421142446.GA1185829@hirez.programming.kicks-ass.net>
 <ZEK+IeTYsauHLozy@lothringen>
 <20230422080814.GA1214746@hirez.programming.kicks-ass.net>
 <20230422113811.GB1215777@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230422113811.GB1215777@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eeLe Sat, Apr 22, 2023 at 01:38:11PM +0200, Peter Zijlstra a écrit :
> On Sat, Apr 22, 2023 at 10:08:14AM +0200, Peter Zijlstra wrote:
> > On Fri, Apr 21, 2023 at 06:47:29PM +0200, Frederic Weisbecker wrote:
> > 
> > > > *HOWEVER*
> > > > 
> > > > intel_idle_irq() is affected -- except that we only (normally) use that
> > > > for very shallow idle states and it won't interact with NOHZ (because we
> > > > only disable the tick for deep idle states).
> > > 
> > > Well I don't know, that doesn't look comfortable... :)
> > > 
> > > Also why does it need to enable IRQs if ecx=1 ?
> > 
> > Supposedly this is some interrupt latency hack. See commit:
> > 
> >   c227233ad64c ("intel_idle: enable interrupts before C1 on Xeons")
> 
> Something like so perhaps...
> 
> diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
> index 778df05f8539..07a4072c43de 100644
> --- a/arch/x86/include/asm/mwait.h
> +++ b/arch/x86/include/asm/mwait.h
> @@ -115,8 +115,14 @@ static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned lo
>  		}
>  
>  		__monitor((void *)&current_thread_info()->flags, 0, 0);
> -		if (!need_resched())
> -			__mwait(eax, ecx);
> +		if (!need_resched()) {
> +			if (ecx & 1) {
> +				__mwait(eax, ecx);
> +			} else {
> +				__sti_mwait(eax, ecx);
> +				raw_local_irq_disable();
> +			}
> +		}

Yep that looks good!

Thanks!
