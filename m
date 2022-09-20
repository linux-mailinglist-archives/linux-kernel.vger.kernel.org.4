Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333455BE196
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiITJNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiITJMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:12:54 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8DE6D9E9;
        Tue, 20 Sep 2022 02:12:03 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oaZIF-0003sr-Dh; Tue, 20 Sep 2022 11:11:51 +0200
Message-ID: <f2c28043-59e6-0aee-b8bf-df38525ee899@leemhuis.info>
Date:   Tue, 20 Sep 2022 11:11:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Content-Language: en-US, de-DE
To:     Dusty Mabe <dusty@dustymabe.com>, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
 <YxBZ4BBjxvAkvI2A@T590> <20220907073324.GB23826@lst.de>
 <Yxr4SD4d0rZ9TZik@T590> <20220912071618.GA4971@lst.de>
 <Yx/jLTknQm9VeHi4@T590> <95cbd47d-46ed-850e-7d4f-851b35d03069@dustymabe.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <95cbd47d-46ed-850e-7d4f-851b35d03069@dustymabe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1663665123;03f15537;
X-HE-SMSGID: 1oaZIF-0003sr-Dh
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

On 13.09.22 04:36, Dusty Mabe wrote:
> On 9/12/22 21:55, Ming Lei wrote:
>> On Mon, Sep 12, 2022 at 09:16:18AM +0200, Christoph Hellwig wrote:
>>> On Fri, Sep 09, 2022 at 04:24:40PM +0800, Ming Lei wrote:
>>>> On Wed, Sep 07, 2022 at 09:33:24AM +0200, Christoph Hellwig wrote:
>>>>> On Thu, Sep 01, 2022 at 03:06:08PM +0800, Ming Lei wrote:
>>>>>> It is a bit hard to associate the above commit with reported issue.
>>>>>
>>>>> So the messages clearly are about something trying to open a device
>>>>> that went away at the block layer, but somehow does not get removed
>>>>> in time by udev (which seems to be a userspace bug in CoreOS).  But
>>>>> even with that we really should not hang.
>>>>
>>>> Xiao Ni provides one script[1] which can reproduce the issue more or less.
>>>
>>> I've run the reproduced 10000 times on current mainline, and while
>>> it prints one of the autoloading messages per run, I've not actually
>>> seen any kind of hang.
>>
>> I can't reproduce the hang too.
> 
> I obviously can reproduce the issue with the test in our Fedora CoreOS
> test suite. It's part of a framework (i.e. it's not simple some script
> you can run) but it is very reproducible so one can add some instrumentation
> to the kernel and feed it through a build/test cycle to see different
> results or logs.
> 
> I'm willing to share this with other people (maybe a screen share or
> some written down instructions) if anyone would be interested.

This thread looked stalled, or was there any progress in the past week?
If not: Fedora apparently removed the patch in their kernels a while
ago, as quite a few users where hitting it. What is preventing us from
doing the same in mainline and 5.19.y until the issue can be resolved?
The description of a09b314005f3 ("block: freeze the queue earlier in
del_gendisk") doesn't sound like the change does something crucial that
can't wait a bit. I might be totally wrong with that, but I think it's
my duty to ask that question at this point.

>> What I meant is that new raid disk can be added by mdadm after stopping
>> the imsm container and raid disk with the autoloading messages printed,
>> I understand this behavior isn't correct, but I am not familiar with
>> raid enough.
>>
>> It might be related with the delay deleting gendisk from wq & md kobj
>> release handler.
>>
>> During reboot, if mdadm does this stupid thing without stopping, the hang
>> could be caused.
>>
>> I think the root cause is that why mdadm tries to open/add new raid bdev
>> crazily during reboot.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
