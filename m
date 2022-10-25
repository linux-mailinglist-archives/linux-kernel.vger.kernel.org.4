Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A685E60D4B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiJYTdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiJYTdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:33:02 -0400
Received: from smtp.smtpout.orange.fr (smtp-11.smtpout.orange.fr [80.12.242.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EB3DCAE3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:32:52 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id nPfLoHUnu42kJnPfLovwLq; Tue, 25 Oct 2022 21:32:50 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 25 Oct 2022 21:32:50 +0200
X-ME-IP: 86.243.100.34
Message-ID: <bad224c0-98a3-37db-99c3-b44687cc396e@wanadoo.fr>
Date:   Tue, 25 Oct 2022 21:32:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: RE: [PATCH] lib/string.c: Improve strcasecmp speed by not
 lowering if chars match
Content-Language: fr, en-US
To:     Nathan Moinvaziri <nathan@nathanm.com>,
        Andy Shevchenko <andy@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BYAPR06MB557347406F22FBA1E400A5BFD8319@BYAPR06MB5573.namprd06.prod.outlook.com>
 <CAHp75Vd4Vk0v-T3kfxApGHb-H26KTHgH59DGP3Wm4qBgunDt6A@mail.gmail.com>
 <Y1embP5sEp/NPxK0@smile.fi.intel.com>
 <BYAPR06MB557390C5F741300BDE2BAA8BD8319@BYAPR06MB5573.namprd06.prod.outlook.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <BYAPR06MB557390C5F741300BDE2BAA8BD8319@BYAPR06MB5573.namprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/10/2022 à 19:53, Nathan Moinvaziri a écrit :
> Hi Andy,
> 
> I appreciate your quick feedback!
> 
> I have done as you suggested and published my results this time using Google benchmark:
> https://github.com/nmoinvaz/strcasecmp

Hi,
the algorithm on github is not the same as the one posted here.

IIUC, the one on github is wrong. If you compare 2 strings that are the 
same, they will have the same length, and "if (c1 == c2) continue;" will 
go one past the end of the strings. And the result will be <0 or 0 or >0 
depending the the char *after* the trailing \0.

On the other side, the results of the benchmark on github are likely not 
accurate with the algorithm posted here, because there is one more test 
in each loop ("while (c1 != 0)") as long as the 2 strings are the same.
On github this test is skipped because you will go through the "continue"

CJ

> 
> After you review it, and if you still think the patch is worthwhile then I can fix the other problems you mentioned for the original patch. If you think it is not worth it, then I understand.
> 
> Thanks again,
> Nathan
> 
> -----Original Message-----
> From: Andy Shevchenko <andy@kernel.org>
> Sent: Tuesday, October 25, 2022 2:04 AM
> To: Nathan Moinvaziri <nathan@nathanm.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering if chars match
> 
> On Tue, Oct 25, 2022 at 11:00:36AM +0300, Andy Shevchenko wrote:
>> On Tue, Oct 25, 2022 at 4:46 AM Nathan Moinvaziri <nathan@nathanm.com> wrote:
> 
> ...
> 
>>> When running tests using Quick Benchmark with two matching 256
>>> character strings these changes result in anywhere between ~6-9x speed improvement.
>>>
>>> * We use unsigned char instead of int similar to strncasecmp.
>>> * We only subtract c1 - c2 when they are not equal.
> 
> ...
> 
>> You tell us that this is more preformant, but have not provided the
>> numbers. Can we see those, please?
> 
> So, I have read carefully and see the reference to some QuickBenchmark I have no idea about. What I meant here is to have numbers provided by an (open
> source) tool (maybe even in-kernel test case) that anybody can test on their machines. You also missed details about how you run, what the data set has been used, etc.
> 
>> Note, that you basically trash CPU cache lines when characters are not
>> equal, and before doing that you have a branching. I'm unsure that
>> your way is more performant than the original one.
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 
> 

