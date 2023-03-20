Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102D26C2374
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCTVQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCTVQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F4419B3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679346927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rsIjYsSNa4Bp7Br3XMg1/eTUykKFq+/ah4LLYuZMMLI=;
        b=i880EueWz80MCnGfS3fDvbHjE/nU1CGHNxi1rtatQMvCPdwRfXus5zZ/SIyLlKmNSN02Ts
        g67XdIWdptCqEQFvQ0bVCOsM4QR7u8iGmrXXVe+cfOMiWjBNml74rz3J+zK3L5OfmdnfaW
        uti8R3NNJ7RMJZWC9tlH2d1vvSTWpD0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-eUsFXU6wPpWA29wUJoBHEg-1; Mon, 20 Mar 2023 17:15:26 -0400
X-MC-Unique: eUsFXU6wPpWA29wUJoBHEg-1
Received: by mail-wr1-f70.google.com with SMTP id c3-20020adfa303000000b002d5737d3835so523383wrb.21
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679346925;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rsIjYsSNa4Bp7Br3XMg1/eTUykKFq+/ah4LLYuZMMLI=;
        b=VG+WE+wf24H1FzClhpz9Wf0F7dm5A9xoQt3UsZ8Flnk661BkozTS9zDkqX1WcH2jWJ
         OMyNWFhoPYgRvCQ3W0anZ5eMK5Ricwu+6KFKlKisLNnvm1jzljmJ7hhMh5wvbescvNZk
         psCLhVbdiDJygms84fUcZkTYxy85MbSAmd8MpJMqKw2D4IUuHfL/9pxw0yDkvbs40Qxr
         nFLSDsUHPWgd1CdqiwSmGJFVHG9MY5z7QqeYG6MvGsxyOq446uBKCCthVrvS0juGwyL8
         h+siU3AofQ7c8EGu915Wsx9zz9DfcBDxEtKeLKHSf4LPHwJjo8fZ2xEZZlhvlEjY8T3g
         Okrw==
X-Gm-Message-State: AO0yUKUhpQmRfBX7B6FPUVrYhP2DyRQ93ZiV7VZJzgYmbUCBErrBdnYv
        j7oGDxxFeXmBmGRqCOFpBn/nlWbGaoN2uzwYkh3K1c9TE6f1gpv9AdVeqGSGrjEwXId21MDWrP3
        OCSjidb8MZnf901mh6mWRK0sC
X-Received: by 2002:a7b:c8cc:0:b0:3eb:3104:efec with SMTP id f12-20020a7bc8cc000000b003eb3104efecmr623596wml.16.1679346925235;
        Mon, 20 Mar 2023 14:15:25 -0700 (PDT)
X-Google-Smtp-Source: AK7set8kY9DQ0hBegzf+xUpwollY185tlNaAjHmhxSHmKHHXj6vzUaVDo6IvvIxbjXzEJjbX+lviBg==
X-Received: by 2002:a7b:c8cc:0:b0:3eb:3104:efec with SMTP id f12-20020a7bc8cc000000b003eb3104efecmr623576wml.16.1679346924852;
        Mon, 20 Mar 2023 14:15:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id d8-20020a1c7308000000b003ed1f6878a5sm11746258wmb.5.2023.03.20.14.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 14:15:24 -0700 (PDT)
Message-ID: <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com>
Date:   Mon, 20 Mar 2023 22:15:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org
References: <20230311051712.4095040-1-mcgrof@kernel.org>
 <3b25ed5c-8fb9-82d3-2296-fadbbb4db7e4@redhat.com>
 <ZBHuBgUQFbsd6l+J@bombadil.infradead.org>
 <f18ec4d3-be63-7e86-1951-f3d460acd7a7@redhat.com>
 <ZBOsc8dc0Mhvh/vv@bombadil.infradead.org>
 <ZBOsyBu68d4vh6yU@bombadil.infradead.org>
 <ZBUBsUx9++Ksl91w@bombadil.infradead.org>
 <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
 <2bd995a7-5b7f-59a1-751e-c56e76a7d592@redhat.com>
 <ZBjLp4YvN1m/cR4G@bombadil.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZBjLp4YvN1m/cR4G@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.23 22:09, Luis Chamberlain wrote:
> On Mon, Mar 20, 2023 at 08:40:07PM +0100, David Hildenbrand wrote:
>> On 20.03.23 10:38, David Hildenbrand wrote:
>>> On 18.03.23 01:11, Luis Chamberlain wrote:
>>>> On Thu, Mar 16, 2023 at 04:56:56PM -0700, Luis Chamberlain wrote:
>>>>> On Thu, Mar 16, 2023 at 04:55:31PM -0700, Luis Chamberlain wrote:
>>>>>> On Wed, Mar 15, 2023 at 05:41:53PM +0100, David Hildenbrand wrote:
>>>>>>> I expect to have a machine (with a crazy number of CPUs/devices) available
>>>>>>> in a couple of days (1-2), so no need to rush.
>>>>>>>
>>>>>>> The original machine I was able to reproduce with is blocked for a little
>>>>>>> bit longer; so I hope the alternative I looked up will similarly trigger the
>>>>>>> issue easily.
>>>>>>
>>>>>> OK give this a spin:
>>>>>>
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230316-module-alloc-opts
>>>>
>>>> Today I am up to here:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230317-module-alloc-opts
>>>>
>>>> The last patch really would have no justification yet at all unless it
>>>> does help your case.
>>>
>>> Still waiting on the system (the replacement system I was able to grab
>>> broke ...).
>>>
>>> I'll let you know once I succeeded in reproducing + testing your fixes.
>>
>> Okay, I have a system where I can reproduce.
>>
>> Should I give
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230319-module-alloc-opts
>>
>> from yesterday a churn?
> 
> Yes please give that a run.

Reproduced with v6.3.0-rc1 (on 1st try)

Not able to reproduce with 20230319-module-alloc-opts so far (2 tries).

> 
> Please collect systemd-analyze given lack of any other tool to evaluate
> any deltas. Can't think of anything else to gather other than seeing if
> it booted.

Issue is that some services (kdump, tuned) seem to take sometimes ages 
on that system to start for some reason, and systemd-analyze refuses to 
do something reasonable while the system is still booting up.

I'll see if I can come up with some data.

> 
> If that boots works then try removing the last patch "module: add a
> sanity check prior to allowing kernel module auto-loading" to see if
> that last patch helped or was just noise. As it stands I'm not convinced
> yet if it did help, if it *does* help we probably need to rethink some
> finit_module() allocations things.

Okay, will try without the last patch tomorrow.

-- 
Thanks,

David / dhildenb

