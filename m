Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0565B645507
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiLGIAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLGIAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:00:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6ECDF9E;
        Wed,  7 Dec 2022 00:00:33 -0800 (PST)
Date:   Wed, 7 Dec 2022 09:00:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670400031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wKDkOx0HlWRonLHxoYKpkkIPzXELWNRGE8f2sh6dWn4=;
        b=FztapfyXQvvcURZVkmrjRLVDpPa6ZPN5boUQdlMmLKFsX5vJkaY//PUztOqY92SrOo8G8B
        SLoVfXgVMXn85Liq5FCfNNcvNGUxsZENDigDzVxAtE9ZEM3+OMLhdo5B5qXaPdIqwZhK6v
        VctHFevjvTXT+KG58RvEZTEQ6cLm0kYCDGws7TzEyaDW8sJcZ5iLco8VvMNCBXYtnpZC8S
        es5zLl42QQF2G16cX2DeMzrKvD8jVejEfWrUmk0KVW9nFQ/KTiSy//6Ni8UNeI4XJKKczt
        5Hyor+wia27pASnc2ganH+p9SQGGk3COCkshNY2wPyVv2W3Wu6le415qx5snng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670400031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wKDkOx0HlWRonLHxoYKpkkIPzXELWNRGE8f2sh6dWn4=;
        b=WOp/gj5libGx/W+qHdWiQ5H6ool2s1vfj8ByaK8sUZ+b8Oj5TjUZqg8s5hIQ5OizCW0yqO
        ZtraWhg4BVPe3vCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm/highmem: Add notes about conversions from
 kmap{,_atomic}()
Message-ID: <Y5BIHdnP4yeJ8svL@linutronix.de>
References: <20221206070029.7342-1-fmdefrancesco@gmail.com>
 <Y472ipY908pHip+B@linutronix.de>
 <2093077.OBFZWjSADL@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2093077.OBFZWjSADL@suse>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-06 20:12:13 [+0100], Fabio M. De Francesco wrote:
> >   Furthermore, code between the kmap_atomic() and kunmap_atomic()
> >   functions may implicitly depended 
> 
> I suppose it should be "depend"? Shouldn't it?

Ehm, yes, correct.

> >   on the side effects of kmap_atomic()
> >   namely disabling pagefaults or preemption or both.
> 
> I agree with you for rephrasing, mainly because it is 
> written in poor English.
> 
> However, I still have doubts about why you deleted "migration". 
> AFAIK, __kmap_local_pfn_prot() always takes care of disabling migration for 
> HIGHMEM enabled kernels. 

That is correct. Historically kmap_atomic() never had a
migrate_disable() statement - only preempt_disable(). With disabled
preemption the task migration is implicitly disabled.

> How about !HIGHMEM, where kmap_local_page() is an indirect call to 
> page_address()? Did you mean that, if the code between kmap_atomic() and 
> kunmap_atomic() depended on migrate_disable() (in PREEMPT_RT) we should always 
> just stay safe and call preempt_disable() together with conversion to 
> kmap_local_page()?

Even in the !HIGHMEM case it always uses preempt_disable(). With
PREEMPT_RT it is different as it never disabled preemption and always
did a migrate_disable() instead. If you talk about what needs to be
considered while migrating away from kmap_atomic() then I wouldn't add
the PREEMPT_RT bits to it since it was never in the picture while the
code (using kmap_atomic()) was originally written.

> If so, I understand and I again agree with you. If not, I'm missing something; 
> so please let me understand properly.
> 
> Aside from the above, I'm not sure whether you deleted the last phrase before 
> your suggestion. What about making it to become "For the above-mentioned 
> cases, conversions should also explicitly disable page-faults and/or 
> preemption"? 

They need to disable preemption or page-faults or both if it is needed
(not unconditionally) and where it is needed. This means not
unconditionally over the whole kmap-ed section.

> Thanks again for noticing my mistakes.
> 
> Fabio

Sebastian
