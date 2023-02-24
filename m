Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CDB6A1A96
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjBXKvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXKu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:50:58 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517BA15885;
        Fri, 24 Feb 2023 02:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677235857; x=1708771857;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=noOJVEfLjfjFl/8iEsWqjV4iJjt7i8IK2bqJaCilVlY=;
  b=OR8VPi5FrAlSThRFuSp5Y9adIXNg7iBF2UqtxcOq1GIbh5mGeAYB1VwE
   SycYXo+O3CO8LRql0/Wr779re7zuQmr+4P87VcRMFwYFPP5Dqw/kf4MvQ
   vNQKJZroyj8TkQOb6K+AS5ytyn3eDrUsZWluDQGYWBZrXgBN3A7I9gQs/
   lOBFSTaOqnXXZ8YcpKWKLFIWFfVqT89mIStoLgOh6OfDU/XzumC9oqrEo
   0xXYCUR3ysO/qib2Xmu3+0tgEgILKUTUHwIhs3NGK8S1RI+N9nnWQTN6O
   cJlhAqpxrU6Rsizoqtk84q+ALp+MD/LYbHKwfmf542S7cxlTG9jwVU8Tc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="313838846"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="313838846"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 02:50:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="622674319"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="622674319"
Received: from wmao-mobl.amr.corp.intel.com (HELO [10.212.63.133]) ([10.212.63.133])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 02:50:53 -0800
Message-ID: <582a9b92-d246-fce2-cf39-539d9a2db17f@linux.intel.com>
Date:   Fri, 24 Feb 2023 10:50:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 06/14] dma-buf/sync_file: Support (E)POLLPRI
Content-Language: en-US
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        freedreno@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>
References: <20230218211608.1630586-1-robdclark@gmail.com>
 <20230218211608.1630586-7-robdclark@gmail.com>
 <20230220105345.70e46fa5@eldfell>
 <CAF6AEGv9fLQCD65ytRTGp=EkNB1QoZYH5ArphgGQALV9J08Cmw@mail.gmail.com>
 <cdd5f892-49b9-1e22-4dc1-95a8a733c453@amd.com>
 <CAF6AEGuMn3FywPkEtfJ7oZ16A0Bk2aiaRvj4si4od1d3wzXkPw@mail.gmail.com>
 <20230222114900.1b6baf95@eldfell>
 <CAF6AEGs1_75gg+LCBj6=PH8Jn60PXiE+Kx_2636nP-+pajN8Hg@mail.gmail.com>
 <20230223113814.3010cedc@eldfell>
 <CAF6AEGuE89kuKTjjzwW1xMppcVw-M4-hcrtifed-mvsCA=cshQ@mail.gmail.com>
 <20230224112630.313d7b76@eldfell>
 <a47e2686-1e35-39a3-0f0c-6c3b9522f8ff@linux.intel.com>
 <20230224122403.6a088da1@eldfell>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20230224122403.6a088da1@eldfell>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/02/2023 10:24, Pekka Paalanen wrote:
> On Fri, 24 Feb 2023 09:41:46 +0000
> Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:
> 
>> On 24/02/2023 09:26, Pekka Paalanen wrote:
>>> On Thu, 23 Feb 2023 10:51:48 -0800
>>> Rob Clark <robdclark@gmail.com> wrote:
>>>    
>>>> On Thu, Feb 23, 2023 at 1:38 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
>>>>>
>>>>> On Wed, 22 Feb 2023 07:37:26 -0800
>>>>> Rob Clark <robdclark@gmail.com> wrote:
>>>>>      
>>>>>> On Wed, Feb 22, 2023 at 1:49 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
>>>
>>> ...
>>>    
>>>>>>> On another matter, if the application uses SET_DEADLINE with one
>>>>>>> timestamp, and the compositor uses SET_DEADLINE on the same thing with
>>>>>>> another timestamp, what should happen?
>>>>>>
>>>>>> The expectation is that many deadline hints can be set on a fence.
>>>>>> The fence signaller should track the soonest deadline.
>>>>>
>>>>> You need to document that as UAPI, since it is observable to userspace.
>>>>> It would be bad if drivers or subsystems would differ in behaviour.
>>>>>      
>>>>
>>>> It is in the end a hint.  It is about giving the driver more
>>>> information so that it can make better choices.  But the driver is
>>>> even free to ignore it.  So maybe "expectation" is too strong of a
>>>> word.  Rather, any other behavior doesn't really make sense.  But it
>>>> could end up being dictated by how the hw and/or fw works.
>>>
>>> It will stop being a hint once it has been implemented and used in the
>>> wild long enough. The kernel userspace regression rules make sure of
>>> that.
>>
>> Yeah, tricky and maybe a gray area in this case. I think we eluded
>> elsewhere in the thread that renaming the thing might be an option.
>>
>> So maybe instead of deadline, which is a very strong word, use something
>> along the lines of "present time hint", or "signalled time hint"? Maybe
>> reads clumsy. Just throwing some ideas for a start.
> 
> You can try, but I fear that if it ever changes behaviour and
> someone notices that, it's labelled as a kernel regression. I don't
> think documentation has ever been the authoritative definition of UABI
> in Linux, it just guides drivers and userspace towards a common
> understanding and common usage patterns.
> 
> So even if the UABI contract is not documented (ugh), you need to be
> prepared to set the UABI contract through kernel implementation.

To be the devil's advocate it probably wouldn't be an ABI regression but 
just an regression. Same way as what nice(2) priorities mean hasn't 
always been the same over the years, I don't think there is a strict 
contract.

Having said that, it may be different with latency sensitive stuff such 
as UIs though since it is very observable and can be very painful to users.

> If you do not document the UABI contract, then different drivers are
> likely to implement it differently, leading to differing behaviour.
> Also userspace will invent wild ways to abuse the UABI if there is no
> documentation guiding it on proper use. If userspace or end users
> observe different behaviour, that's bad even if it's not a regression.
> 
> I don't like the situation either, but it is what it is. UABI stability
> trumps everything regardless of whether it was documented or not.
> 
> I bet userspace is going to use this as a "make it faster, make it
> hotter" button. I would not be surprised if someone wrote a LD_PRELOAD
> library that stamps any and all fences with an expired deadline to
> just squeeze out a little more through some weird side-effect.
> 
> Well, that's hopefully overboard in scaring, but in the end, I would
> like to see UABI documented so I can have a feeling of what it is for
> and how it was intended to be used. That's all.

We share the same concern. If you read elsewhere in these threads you 
will notice I have been calling this an "arms race". If the ability to 
make yourself go faster does not required additional privilege I also 
worry everyone will do it at which point it becomes pointless. So yes, I 
do share this concern about exposing any of this as an unprivileged uapi.

Is it possible to limit access to only compositors in some sane way? 
Sounds tricky when dma-fence should be disconnected from DRM..

Regards,

Tvrtko
