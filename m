Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596A25FAE8D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJKIiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJKIiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:38:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C448D7F0B1;
        Tue, 11 Oct 2022 01:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KO7gU+LefA6D5wKQ9wSoqhxq2c2iQC8o1fyv5h63CAw=; b=YUUfb42mPZ2+kOu6aaItA3oZJo
        sFLP+fyN2y9tRMkBLL5GkSc+CEK5Remo0jI0MfjC9DG3x58PbX/1o0klgRCZk9lEsBnZnt5wDWEmI
        b7Si56ravAbG+8rDvk2fhtlBvm63FA0eSG8jfRYv6QIwViZF0GLzeAx0MLXAenWVVzDjzPQJpeRm0
        /XUJiFIOqwthieUeq1TNrUW9eRkp+aDVtNH95DUt56boLklPoTQcEfuVfE5a7/uzD8V0bLqJ2gCj/
        4yPlXIA3DO1fX3LuyByQX/UmJzHlCyb7wv+TjnwC/Z2wbw8ichLlEqGiDzX623Tk6nfh70YdKfTJ9
        UeMnMMuQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oiAm4-002X70-Om; Tue, 11 Oct 2022 08:38:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4D3A730004F;
        Tue, 11 Oct 2022 10:38:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C98320E1D7DB; Tue, 11 Oct 2022 10:38:04 +0200 (CEST)
Date:   Tue, 11 Oct 2022 10:38:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, Dietmar.Eggemann@arm.com,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: Update CPU capacity reduction in
 store_scaling_max_freq()
Message-ID: <Y0UrbBioezoyeez/@hirez.programming.kicks-ass.net>
References: <20220930094821.31665-1-lukasz.luba@arm.com>
 <20220930094821.31665-2-lukasz.luba@arm.com>
 <20221010053902.5rofnpzvyynumw3e@vireshk-i7>
 <3f9a4123-171b-5fa7-f506-341355f71483@arm.com>
 <CAKfTPtBPqcTm5_-M_Ka3y46yQ2322TmH8KS-QyDbAiKk5B6hEQ@mail.gmail.com>
 <8a7968c2-dbf7-5316-ef36-6d45143e0605@arm.com>
 <CAKfTPtB3Lk5bc9k634O+Yi8wwP=MVeKS5NPbpaqwhX1F4t5EbA@mail.gmail.com>
 <9611971c-d8dd-7877-6f50-c5afbf38b171@arm.com>
 <Y0Py/Ol9t+LMM1pI@hirez.programming.kicks-ass.net>
 <7ded9241-6c21-6631-8910-9f1150db6724@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ded9241-6c21-6631-8910-9f1150db6724@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 11:46:29AM +0100, Lukasz Luba wrote:
> 
> +CC Daniel, since I have mentioned a few times DTPM
> 
> On 10/10/22 11:25, Peter Zijlstra wrote:
> > On Mon, Oct 10, 2022 at 11:12:06AM +0100, Lukasz Luba wrote:
> > > BTW, those Android user space max freq requests are not that long,
> > > mostly due to camera capturing (you can see a few in this file,
> > > e.g. [1]).
> > 
> > It does what now ?!? Why is Android using this *at*all* ?
> 
> It tries to balance the power budget, before bad things happen
> randomly (throttling different devices w/o a good context what's
> going on). Please keep in mind that we have ~3 Watts total power
> budget in a phone, while several devices might be suddenly used:
> 1. big CPU with max power ~3-3.5 Watts (and we have 2 cores on pixel6)
> 2. GPU with max power ~6Watts (normally ~1-2Watts when lightly used)
> 3. ISP (Image Signal Processor) up to ~2Watts
> 4. DSP also up to 1-2Watts
> 
> We don't have currently a good mechanism which could be aware
> of the total power/thermal budget and relations between those
> devices. Vendors and OEMs run experiments on devices and profile
> them to work more predictable in those 'important to users' scenarios.
> 
> AFAIK Daniel Lescano is trying to help with this new interface
> for PowerCap: DTMP. It might be use as a new interface for those known
> scenarios like the camera snapshot. But that interface is on the list
> that I have also mentioned - it's missing the notification mechanism
> for the scheduler reduced capacity due to user-space new scenario.

DTMP is like IPA but including random devices? Because I thought IPA
already did lots of this.
