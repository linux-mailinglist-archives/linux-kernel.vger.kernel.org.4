Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EA46B06A6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjCHMKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjCHMKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:10:17 -0500
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA5D26B5C8;
        Wed,  8 Mar 2023 04:10:15 -0800 (PST)
Message-ID: <97ad368e-7379-37db-8103-3b4ecc2342fd@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1678277415;
        bh=7BWXGLzpcMKFQqb+ZMueLngLx1rrCtrD3QworHvQMag=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DuuqzImJlm/gNNlFLOXPiEKSJYt3mbEVMd2sdPyA11ZgU2g4MNFBylijhlNaq7x8X
         gKii25T8Mm5M1RxZ6r9A1IIcMy/j/jGxMIydZLsEfX6qTyAgtUy2ydQfisPk/TwAEZ
         78O06xNI5EiWeGhIRhPJ1YEAOJRjeTW5iTZV+H90=
Date:   Wed, 8 Mar 2023 13:10:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Regression] rt2800usb - Wifi performance issues and connection
 drops
Content-Language: en-US
To:     Thomas Mann <rauchwolke@gmx.net>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Johannes Berg <johannes.berg@intel.com>
References: <b8efebc6-4399-d0b8-b2a0-66843314616b@leemhuis.info>
 <5a7cd098-1d83-6297-e802-ce998c8ec116@leemhuis.info>
 <6025e17e-4c29-6d36-6b9c-2fec543b21c4@wetzel-home.de>
 <debc7fe9-204d-63a7-aa61-91b20a46f385@wetzel-home.de>
 <20230307233123.14a411ee@polar.lan>
 <4171c994-6b02-95d1-30c7-8f6f72af7893@wetzel-home.de>
 <20230308112650.3c72d6f2@polar.lan>
From:   Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <20230308112650.3c72d6f2@polar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> @Thomas:
>>>> I've also uploaded you my binary kernel I'm running at the moment
>>>> here: https://www.awhome.eu/s/5FjqMS73rtCtSBM
>>>>
>>>> That kernel should also be able to boot and operate your system.
>>>> Can you try that and tell me, if that makes any difference?
>>
>>   >
>>   > i can't boot the binary kernel here, as the initramfs is included
>>   > in my kernel, if you send me a patch, i can apply it and test it.
>>
>> That was an unpatched kernel. Idea was to verify that it's not a
>> compiler issue. (You seem to be using a hardened Gentoo profile.)
>>
>> Can you share your initrd, so I can include it? (Mail it to me
>> directly, upload it to bug in buguilla or send a link to some cloud
>> storage.)
>>
> I can't share this config, as it's a production system, and i'm not
> allowed to run abitrary binary code on the system. As 6.1.x works
> without a problem, i don't think it's a compiler problem. I will try to
> get a none hardened compiler and recompile the kernel.
> 

I was suspecting something like that. I may try the same in reverse. But 
it's so far quite some way down on the list. There are more promising 
ways to spend the debug time I have for so far.

But one remark:
As far as TX is concerned 6.1 and 6.2 kernels are handling TX in 
drastically different ways for many - including yours - cards.

The patch you identified as culprit is well after the move to the new TX 
mode of operation and only fixes a comparable minor issue.

Your setup seems to require both, the move to iTXQ AND this minor fix.

>>
>>>>
>>>> I'm also planning to provide some more debug patches, to figuring
>>>> out which part of commit 4444bc2116ae ("wifi: mac80211: Proper
>>>> mark iTXQs for resumption") fixes the issue for you. Assuming my
>>>> understanding above is correct the patch should not really
>>>> fix/break anything for you...With the findings above I would have
>>>> expected your git bisec to identify commit a790cc3a4fad ("wifi:
>>>> mac80211: add wake_tx_queue callback to drivers") as the first
>>>> broken commit...
>>>>
>>>> Alexander
>>>
>>
> 

