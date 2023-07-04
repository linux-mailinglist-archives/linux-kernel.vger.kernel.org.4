Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75F1746955
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjGDGHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGDGHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:07:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9EA115;
        Mon,  3 Jul 2023 23:07:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E3916113B;
        Tue,  4 Jul 2023 06:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FF2C433C7;
        Tue,  4 Jul 2023 06:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688450837;
        bh=o6D+8pp4tNQyl210ZE9/yuE7kORb0Ur5TVoqC2A2FXU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PF+kbeDgyG5EkCBX+3/tbN/HtWjE32wgty9RPXR2LfJckckEDdw4uqgMN2pDcolI4
         mgVob5k8LVSMj827hmuO55gkq3q/nSo8VVFaDl/ou/nW6MgnrccHwFJoG69djuLZXB
         GIsiAQsKbSiQ8v2EnFNhU0tHPHk95LUNg92/Y30FAR28h1cg/r3TZiqFZgWmmnRZEc
         sgEZj4QxhzqfUaFDfC4esQmndlj1gRK/PgDKYRy+46tV+oXCgtpSYWLLuzptIkW506
         7gKkS5hi2sza0gAfByS8by4yM9oG2LfM8desOzUoT8TmEggLhR/K+RoFys2aOISldd
         8BLsuHGJ2e1EQ==
Message-ID: <bd531778-a587-e4d0-e360-432208f064ea@kernel.org>
Date:   Tue, 4 Jul 2023 08:07:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] pstore/ram: Add support for dynamically allocated ramoops
 memory regions
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        Isaac Manjarres <isaacmanjarres@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     John Stultz <jstultz@google.com>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        kernel-team@android.com, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
References: <20230622005213.458236-1-isaacmanjarres@google.com>
 <CANDhNCrEhx4LUPaz-FHZZJMG2yX670hk-vGTZs=HxiGR18zm5A@mail.gmail.com>
 <202306212212.5E53607@keescook> <ZJSES98P+zzrhBI5@google.com>
 <3A2CFB4D-27D0-4FEB-93B4-2F888305DE5A@kernel.org>
 <a2c9417b-3a50-bea4-dd39-2f021c196fa1@quicinc.com>
 <696269e1-8b97-66ed-c9b0-ce1b8d637d24@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <696269e1-8b97-66ed-c9b0-ce1b8d637d24@quicinc.com>
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

On 26/06/2023 19:34, Mukesh Ojha wrote:
> 
> 
> On 6/23/2023 1:21 AM, Elliot Berman wrote:
>>
>>
>> On 6/22/2023 10:58 AM, Kees Cook wrote:
>>> On June 22, 2023 10:26:35 AM PDT, Isaac Manjarres 
>>> <isaacmanjarres@google.com> wrote:
>>>> On Wed, Jun 21, 2023 at 10:15:45PM -0700, Kees Cook wrote:
>>>>> On Wed, Jun 21, 2023 at 09:47:26PM -0700, John Stultz wrote:
>>>>>>> The reserved memory region for ramoops is assumed to be at a fixed
>>>>>>> and known location when read from the devicetree. This is not 
>>>>>>> desirable
>>>>>>> in environments where it is preferred for the region to be 
>>>>>>> dynamically
>>>>>>> allocated early during boot (i.e. the memory region is defined with
>>>>>>> the "alloc-ranges" property instead of the "reg" property).
>>>>>>>
>>>>>>
>>>>>> Thanks for sending this out, Isaac!
>>>>>>
>>>>>> Apologies, I've forgotten much of the details around dt bindings here,
>>>>>> so forgive my questions:
>>>>>> If the memory is dynamically allocated from a specific range, is it
>>>>>> guaranteed to be consistently the same address boot to boot?
>>>>>>
>>>>>>> Since ramoops regions are part of the reserved-memory devicetree
>>>>>>> node, they exist in the reserved_mem array. This means that the
>>>>>>> of_reserved_mem_lookup() function can be used to retrieve the
>>>>>>> reserved_mem structure for the ramoops region, and that structure
>>>>>>> contains the base and size of the region, even if it has been
>>>>>>> dynamically allocated.
>>>>>>
>>>>>> I think this is answering my question above, but it's a little opaque,
>>>>>> so I'm not sure.
>>>>>
>>>>> Yeah, I had exactly the same question: will this be the same
>>>>> boot-to-boot?
>>>>
>>>> Hi Kees,
>>>>
>>>> Thank you for taking a look at this patch and for your review! When the
>>>> alloc-ranges property is used to describe a memory region, the memory
>>>> region will always be allocated within that range, but it's not
>>>> guaranteed to be allocated at the same base address across reboots.
>>>>
>>>> I had proposed re-wording the end of the commit message in my response
>>>> to John as follows:
>>>>
>>>> "...and that structure contains the address of the base of the region
>>>> that was allocated at boot anywhere within the range specified by the
>>>> "alloc-ranges" devicetree property."
>>>>
>>>> Does that clarify things better?
>>>
>>> I am probably misunderstanding something still, but it it varies from 
>>> boot to boot, what utility is there for pstore if it changes? I.e. the 
>>> things written during the last boot would then no longer accessible at 
>>> the next boot? E.g.:
>>>
>>> Boot 1.
>>> Get address Foo.
>>> Crash, write to Foo.
>>> Boot 2.
>>> Get address Bar, different from Foo.
>>> Nothing found at Bar, so nothing populated in pstorefs; crash report 
>>> from Boot 1 unavailable.
>>>
>>> I feel like there is something I don't understand about the Foo/Bar 
>>> addresses in my example.
>>>
>>
>> I believe this is being added to support the QCOM SoC minidump feature. 
>> Mukesh has posted it on the mailing lists here:
>>
>> https://lore.kernel.org/all/1683133352-10046-1-git-send-email-quic_mojha@quicinc.com/
>>
>> https://lore.kernel.org/all/1683133352-10046-10-git-send-email-quic_mojha@quicinc.com/
>>
>> Mukesh, could you comment whether this patch is wanted for us in the 
>> version you have posted? It looks like maybe not based on the commit 
>> text in patch #9.
> 
> No, this is no needed after patch #9 .
> 
> I have tried multiple attempt already to get this patch in
> 
> https://lore.kernel.org/lkml/1675330081-15029-2-git-send-email-quic_mojha@quicinc.com/
> 
> later tried the approach of patch #9 along with minidump series..

For all dynamic reserved-memory-ramoops thingy, I think Rob made clear
statement:

"I don't think dynamic ramoops location should be defined in DT."

https://lore.kernel.org/lkml/CAL_JsqKV6EEpsDNdj1BTN6nODb=hsHkzsdkCzzWwnTrygn0K-A@mail.gmail.com/

Please do not send three versions of the same patch hoping one will
sneak in.

Best regards,
Krzysztof

