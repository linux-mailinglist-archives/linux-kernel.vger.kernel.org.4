Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3BF652BED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 04:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiLUDqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 22:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLUDql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 22:46:41 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554B1BE6;
        Tue, 20 Dec 2022 19:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1671594399;
        bh=2ppGBTNEKO9ZGf5Jmr6Z5lBYQ/V8tObp7/FB4z0ImVk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JumEZRgUYwBTvJFjedBpRAwFKMWPt91RPx8l1x8EB8Nuk+HafrrTJ1d7ZHKNw9IwU
         Z6v/YgAOZO9AD2TFEE2afW24EJxUTEtFhiW4FxO/Q/gLPEfo7JeK7nfPlhnscq/OhI
         3pjGPY4q9zlh+lsV0L7T5fGW5dSQyQNmzHc6qbjo2o39lMGeOgW+T18iBsxix/0XWa
         pYkIixIXtekn0NK9W5jPW8ThcmaBJ9xtOyGcviYa/qE1u/DTrxb2Y4iolbvevf2el9
         GZk9b3+nfgMl9VKEyUtTRkETe8+hpe0Rxnf55Tziu1VGM9ygRYN0KlTN2BRbSFpKt8
         BvROH7PFufK8A==
Received: from [10.1.0.30] (192-222-188-97.qc.cable.ebox.net [192.222.188.97])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NcKB73dhWzbTD;
        Tue, 20 Dec 2022 22:46:39 -0500 (EST)
Message-ID: <bcb9eb90-9261-ce96-859d-af4cc1d03baa@efficios.com>
Date:   Tue, 20 Dec 2022 22:47:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20221218191310.130904-1-joel@joelfernandes.org>
 <589da7c9-5fb7-5f6f-db88-ca464987997e@efficios.com>
 <CAEXW_YQHpz3dNqW1ocqjr-e9qn09Rkg4kQ19byZORGbO18Xckg@mail.gmail.com>
 <2da94283-4fce-9aff-ac5d-ba181fa0f008@efficios.com>
 <CAEXW_YQBmwynuBOWbV6_L2itRr_i3BZUxQ91PDC2We2vXhpztQ@mail.gmail.com>
 <CAEXW_YTyZaE4ULvm-HygFN2BGm-jayHTbpnYbrJFoo_GOsYKQg@mail.gmail.com>
 <659763b0-eee4-10dd-5f4a-37241173809c@efficios.com>
 <CAEXW_YQ+NTaM43Va5FG8kYSxr2gsbjar4_f3xnpSAHzgUVZ-+g@mail.gmail.com>
 <CAEXW_YRqscm++0TP9bEnM0PQNLMe4cXFWAdRvHh2M5chERm+UA@mail.gmail.com>
 <35293ec4-40a1-cf6b-3bdd-0e3e30819c06@efficios.com>
 <20221221000715.GA27352@lothringen>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221221000715.GA27352@lothringen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-20 19:07, Frederic Weisbecker wrote:
> On Tue, Dec 20, 2022 at 12:00:58PM -0500, Mathieu Desnoyers wrote:
>> On 2022-12-19 20:04, Joel Fernandes wrote:
>> The main benefit I expect is improved performance of the grace period
>> implementation in common cases where there are few or no readers present,
>> especially on machines with many cpus.
>>
>> It allows scanning both periods (0/1) for each cpu within the same pass,
>> therefore loading both period's unlock counters sitting in the same cache
>> line at once (improved locality), and then loading both period's lock
>> counters, also sitting in the same cache line.
>>
>> It also allows skipping the period flip entirely if there are no readers
>> present, which is an -arguably- tiny performance improvement as well.
> 
> I would indeed expect performance improvement if there are no readers in the
> active period/idx but if there are, it's a performance penalty due to the extra
> scans.
> 
> So my mean questions are:
> 
> * Is the no-present-readers the most likely case? I guess it depends on the ssp.
> 
> * Does the SRCU update side deserve to be optimized with added code (because
>    we are not debating about removing the flip, rather about adding a fast-path
>    and keep the flip as a slow-path)
>    
> * The SRCU machinery is already quite complicated. Look how we little things lock
>    ourselves in for days doing our exegesis of SRCU state machine. And halfway
>    through it we are still debating some ordering. Is it worth adding a new path there?

I'm not arguing for making things more complex unless there are good 
reasons to do so. However I think we badly need to improve the 
documentation of the memory barriers in SRCU, because the claimed 
barrier pairing is odd.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

