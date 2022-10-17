Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D9F601002
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJQNOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJQNOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34583209AC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 06:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666012456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nWD7kp29dFDStjgSQi/V7WysKblelT5q7daFVKTx7qQ=;
        b=QieeukZkLhOc630b/Cq6X1fGTwvJAjLHKWKgn7czKSbZnrHwPQRmPOKebFa1JwHhaAuP4b
        Vx2GgrkzLBSZnHXzbkbImv06j1eKMdOolbr5r+5fKnoc+J6tXGqSYO+Kp+RQfOwqeiOYdf
        93RM6XCCWRNoWla1TQQgPZS4Wj37WE4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-542-JJ-Xw2Y7PDSl921_jiM_Kw-1; Mon, 17 Oct 2022 09:14:15 -0400
X-MC-Unique: JJ-Xw2Y7PDSl921_jiM_Kw-1
Received: by mail-ej1-f72.google.com with SMTP id xh12-20020a170906da8c00b007413144e87fso4603097ejb.14
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 06:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWD7kp29dFDStjgSQi/V7WysKblelT5q7daFVKTx7qQ=;
        b=SYeS4VPWt7yYa8Hsb2ngDRNZwD4VTzyIrW2Ez/OCEEVUnzcI3nL6ENWNRNN1lMGT9f
         MtwpG7XP8H4Tp8s1bE4hAzvHmlgT6wQXuTZGLChOV6A9jNZVuExJEb5yD7jhig3hzyPv
         MkcVn/tOpYqMGJfr5xj5EqekTAmdf4FOy0FLdxMtoKv/EdpMjnXkQpNdPJ4ms3lhoqdy
         Yp8H8x5fGigmmqyOaWmj+5QwloqG9rZ/LFRGH44hYWFL3p70ehysKyWN20kKqKaZZcbl
         yR+RbYgesmR2luccmIgmaFHd27kJKrmoip5DMufSn+YUGpn8pRYxbvIP0zqAHWJhmIEO
         mOcQ==
X-Gm-Message-State: ACrzQf2xYz7ChHX2PPRJKglCVH5VCMnLCSVt4uvf2ILQBgaKttRhxoUH
        ygFEqsZIMV5MqL8NKqahXBcPywlERmDBMLkeCzFbkXRpvrprlgoBNNGLWnASPQiLI1uCs6pmvtd
        AmBQVtRALGDbicd3c0YwilNAX
X-Received: by 2002:a17:906:cc52:b0:78d:d477:5b7f with SMTP id mm18-20020a170906cc5200b0078dd4775b7fmr8628895ejb.558.1666012453952;
        Mon, 17 Oct 2022 06:14:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6puxnpvlu/tDqMR5K2evis/s4/NlzjLIPEDSRIXNt9YowomUV8MRLSDeLbtNUNIl9alcNF2g==
X-Received: by 2002:a17:906:cc52:b0:78d:d477:5b7f with SMTP id mm18-20020a170906cc5200b0078dd4775b7fmr8628880ejb.558.1666012453741;
        Mon, 17 Oct 2022 06:14:13 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id kx22-20020a170907775600b00738795e7d9bsm6213820ejc.2.2022.10.17.06.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 06:14:13 -0700 (PDT)
Message-ID: <fac9a564-edff-db25-20d4-7146ae2a7dc8@redhat.com>
Date:   Mon, 17 Oct 2022 15:14:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Intel-gfx] alderlake crashes (random memory corruption?) with
 6.0 i915 / ucode related
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <355dde1c-91e3-13b5-c8e8-75c9b9779b4f@redhat.com>
 <87a65usvgq.fsf@intel.com> <877d0ysv1e.fsf@intel.com>
 <717fb4ab-5225-884f-37f9-2032c265824e@redhat.com>
 <241af90a-4cec-9266-8fb0-3c69f9880b52@leemhuis.info>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <241af90a-4cec-9266-8fb0-3c69f9880b52@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/17/22 13:19, Thorsten Leemhuis wrote:
> CCing the regression mailing list, as it should be in the loop for all
> regressions, as explained here:
> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

Yes sorry about that I meant to Cc the regressions list, not you personally,
but the auto-completion picked the wrong address-book entry
(and I did not notice this).

> On 17.10.22 12:48, Hans de Goede wrote:
>> On 10/17/22 10:39, Jani Nikula wrote:
>>> On Mon, 17 Oct 2022, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>>>> On Thu, 13 Oct 2022, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>> With 6.0 the following WARN triggers:
>>>>> drivers/gpu/drm/i915/display/intel_bios.c:477:
>>>>>
>>>>>         drm_WARN(&i915->drm, min_size == 0,
>>>>>                  "Block %d min_size is zero\n", section_id);
>>>>
>>>> What's the value of section_id that gets printed?
>>>
>>> I'm guessing this is [1] fixed by commit d3a7051841f0 ("drm/i915/bios:
>>> Use hardcoded fp_timing size for generating LFP data pointers") in
>>> v6.1-rc1.
>>>
>>> I don't think this is the root cause for your issues, but I wonder if
>>> you could try v6.1-rc1 or drm-tip and see if we've fixed the other stuff
>>> already too?
>>
>> 6.1-rc1 indeed does not trigger the drm_WARN and for now (couple of
>> reboots, running for 5 minutes now) it seems stable. 6.0.0 usually
>> crashed during boot (but not always).
>>
>> Do you think it would be worthwhile to try 6.0.0 with d3a7051841f0 ?

So I have been trying 6.0.0 with d3a7051841f0 doing a whole bunch of
reboots + general use and that seems stable, then I reverted it and
the very first boot of the kernel with that broke again, so I'm
pretty sure that d3a7051841f0 fixes things.

So d3a7051841f0 seems to do more then just fix the WARN().

So lets try to get d3a7051841f0 added to the official stable series
ASAP (I just noticed that Mark Pearson from Lenovo has already added it
to Fedora's 6.0.2 build.

Regards,

Hans

