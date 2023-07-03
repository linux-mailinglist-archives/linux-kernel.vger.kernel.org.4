Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE3A7460A7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjGCQWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCQWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:22:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1D25E42;
        Mon,  3 Jul 2023 09:22:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F10A2F4;
        Mon,  3 Jul 2023 09:23:16 -0700 (PDT)
Received: from [10.57.27.93] (unknown [10.57.27.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E29FE3F663;
        Mon,  3 Jul 2023 09:22:30 -0700 (PDT)
Message-ID: <4e16fb56-7628-8b2f-182b-170a85168cb8@arm.com>
Date:   Mon, 3 Jul 2023 17:22:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 03/17] PM: EM: Refactor em_pd_get_efficient_state() to
 be more flexible
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
References: <20230512095743.3393563-1-lukasz.luba@arm.com>
 <20230512095743.3393563-4-lukasz.luba@arm.com>
 <418bef75-883c-2442-3376-03fd7537c734@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <418bef75-883c-2442-3376-03fd7537c734@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/23 12:06, Dietmar Eggemann wrote:
> On 12/05/2023 11:57, Lukasz Luba wrote:
>> Prepare em_pd_get_efficient_state() for the upcoming changes and
>> make it possible to re-use. Return an index for the best performance
> 
> Don't get the `possible to re-use`? Did you mean `possible to be
> re-used`? But then `re-used` for what?

The function will no longer get a pointer to 'struct em_perf_domain'
but instead to 'struct em_perf_state'. It would also require to
get the number of states from 'pd->nr_perf_states'.

This is preparation for handling 2 tables:
modifiable (a) and default (b).

Then it also returns and ID not the pointer to state.
It all makes it more generic and ready for those 2 tables.

> 
>> state. The function arguments that are introduced should allow to
>> work on different performance state arrays. The caller of
>> em_pd_get_efficient_state() should be able to use the index either
>> on the default or the modifiable EM table.
> 
> This describes the WHAT but not the WHY.

I will add that description as 'why' in the header. I wanted to
avoid mentioning in the patch description something which
is coming in the next patch.

