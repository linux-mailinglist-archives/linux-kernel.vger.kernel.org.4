Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF40733194
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344910AbjFPMs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344254AbjFPMs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:48:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0370297F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D1696115E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B895C433C8;
        Fri, 16 Jun 2023 12:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686919703;
        bh=T9+U4Djd/HXnHrFKYN+j+1Mj6rD45TKf1gAvy2c4JqQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Qp7kzElcTUC7RODPj8v+KsFrkrI0ocR1kNf0mXz5KsMRdPLDiM16VIRFlqDWap/dR
         YyucVfYtlB91MoBVR9ytYWB4izH6dzxCVJQqCWy5OxDfQwn3MOFARty580tdHat0mN
         0qga+HbFczmQKBSRzyy+QlEWlDXcHSjbY7mzAaLbfa2dgqiD+7Dbf8jOGWMj7cdqms
         pXx+X3MVr9xKxZhXVomyVP5eN/rMWEmdRaQm2K3xmjQ8nkkhVyunwVinYxjX0gzYEB
         1e8GNa6vxhepaSwWNB+MPJ3o0FGwgguXclve6vnxy3AFlzHXcztpiHB6kp3l3XOjnb
         MOIKBtuy/jukw==
Message-ID: <bce68893-f4cd-cf93-5da7-ce98cc984c3a@kernel.org>
Date:   Fri, 16 Jun 2023 14:48:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH V3 6/6] sched/fair: Implement starvation monitor
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1686239016.git.bristot@kernel.org>
 <bd9977efff8cc3e002c4b2db02f611167905a99f.1686239016.git.bristot@kernel.org>
 <CAEXW_YT0DmvQo_gfCq5uzpZpf36HmfzXozo9+=sYJp-hZx4qTQ@mail.gmail.com>
 <b2cd0072-d226-4adb-ddf5-958d9635f881@kernel.org>
 <CAEXW_YR9Tfw5KyFU7TQtYE02k+DpaMXH=osx9Ws5w_j1YpHxhg@mail.gmail.com>
 <841849b5-1f9c-4f0e-2de8-1da278256888@kernel.org>
 <20230616120507.GM83892@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230616120507.GM83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 14:05, Peter Zijlstra wrote:
> On Tue, Jun 13, 2023 at 03:41:30PM +0200, Daniel Bristot de Oliveira wrote:
> 
>> In an 0-laxity scheduler, the server would run at 0-laxity, jumping in
>> front of DL tasks... that would break EDF. It would be mixing two
>> schedulers in one. It is not required and likely not a good idea either.
> 
> I did consider a hybrid 0-laxity and EDF scheduler for mixed
> criticality, as have others like Ted Baker IIRC. IIRC it can be done
> using an augmented tree, but none of that solves the problems 0-laxity
> has (like over preemption and the general problem of playing chicken by
> doing things at the *VERY* last possible moment).

There are papers here or there about it, but it is far from being the most explored
way to do mixed criticality because of these side effects. It is more common to have
virtual deadlines for high and low criticalities, while using EDF.

Having EDF and being working conserving makes our life easier for other points
we are way behind, i.e., deadline inheritance.

> I think I did a talk at OSPERT on this at some point many years ago.
> Luckily some bright fellow had this semi-partitioned stuff that would
> make live much simpler :-)

It will, we can have two partitions, one for high and one for low. The general
case in the low power CPU, and if it does not make to finish on it, it continues
in the high power one. Still, always using EDF. Having virtual deadline is part
of semi-part. Anyways, EDF schedules more, and it is simpler... it is hard to beat.

This patch set is a warm up for that...

-- Daniel
