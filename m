Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194676AE099
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjCGNcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjCGNbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:31:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EF651FB2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678195739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SSepVbXAw2WH/mQidIhIRDeHSi7UEyovwrr8tho6HPc=;
        b=e69f/aKgtbdHR02qLkxBsb6vH1xd0VjwigE+Wrleeeu5TC9hi9O2AkUTmM7lESoHXxCWvM
        2y1c+hZgChcvnEb70HHCTS6/j6qqC2sFuBz/WICq7Ahp8Jlglzfgp91/V2xsRLDGlh8OdO
        sahLr8+gxRQG48ceIxbfE7r23WmTXd4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-iCZKu5b2P1ufcOjsVtE6Eg-1; Tue, 07 Mar 2023 08:28:58 -0500
X-MC-Unique: iCZKu5b2P1ufcOjsVtE6Eg-1
Received: by mail-qt1-f198.google.com with SMTP id t22-20020ac86a16000000b003bd1c0f74cfso7103468qtr.20
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678195738;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSepVbXAw2WH/mQidIhIRDeHSi7UEyovwrr8tho6HPc=;
        b=dL6OAibLPhuabtIU/chMeRac1ED3zuTyQNUiTqhtLXi0HQtGRpfouzAOKRteMhLdo8
         +YiwA2Aj+MwDXIiV4aA/DnUMj0GxifR2vYyvP96txrUV9KbHBdrqAmka71xM5GUmpevG
         PHHC4+uGX3FvCL+ANSfXdz+TNAckJRvVSkGM+vyZcHykqPUTOY8bQs/dMvVI/Ml19SM7
         8wGDPvI9Whjq8xjOFGfsIH5eEFiGpaReeYO4HMp5oSL+Yhhtzu9cfzBWuaFk4G1VbXjK
         g1TJfvUdh16p7WbU1ycHcl/wsFe9OWdRqFIUsHnhJaRbquZXwz2J+AG8XAQI7W7+OcFH
         qmFw==
X-Gm-Message-State: AO0yUKX/FkaTPY5R0h5KvIuUYWeHq86aXR3JgJsYBR8HsdsxZYVJLvfa
        +wQD4ueRrHtLqNfWHbqxiw7zd7IeuA0qWMDgV0HnON8p18OCUQURMmkVm8+9QgfHx+TBTwU9VDF
        uwZq4JEainylLS05VDUr4rK5j5Q8vyr7nDNfG8RXlFVD/9uJMp/k8hs0fEacU3wgYJBt1k6tJ4h
        3TtjM=
X-Received: by 2002:ac8:5c4a:0:b0:3bf:d9a4:fda7 with SMTP id j10-20020ac85c4a000000b003bfd9a4fda7mr24528231qtj.19.1678195737793;
        Tue, 07 Mar 2023 05:28:57 -0800 (PST)
X-Google-Smtp-Source: AK7set95HVP7ucSBzMytZsSw4EEfa64rvq496w2lLCE6Sq9S76+hjQ76PHjasG+Vbm/TdGouAp2xrg==
X-Received: by 2002:ac8:5c4a:0:b0:3bf:d9a4:fda7 with SMTP id j10-20020ac85c4a000000b003bfd9a4fda7mr24528187qtj.19.1678195737461;
        Tue, 07 Mar 2023 05:28:57 -0800 (PST)
Received: from [192.168.1.19] (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id h15-20020ac85e0f000000b003b85ed59fa2sm9937656qtx.50.2023.03.07.05.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 05:28:56 -0800 (PST)
Subject: Re: [PATCH] init/Kconfig: extend -Wno-array-bounds to gcc 13
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Kees Cook <kees@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>, mhiramat@kernel.org,
        akpm@linux-foundation.org, masahiroy@kernel.org,
        paulmck@kernel.org, hannes@cmpxchg.org, ojeda@kernel.org,
        thunder.leizhen@huawei.com, christophe.leroy@csgroup.eu,
        vbabka@suse.cz, linux-kernel@vger.kernel.org
References: <20230306220947.1982272-1-trix@redhat.com>
 <CAKwvOdkd7pUu_oxt4=CW3fxXz2y7evtU9J5Gd7oQuyi1MkDMCw@mail.gmail.com>
 <C01C39FE-E776-48DA-84F2-402B49A705A8@kernel.org>
 <899b639b-3c93-b96d-863d-9e25d1824dc3@redhat.com>
 <CANiq72kKmVzQYU7aOy4k0GsrgV=jfi_fLk2TvtWVGV_sXc8e2w@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e7eef530-16b8-0a5d-273d-98aa3f673e61@redhat.com>
Date:   Tue, 7 Mar 2023 05:28:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CANiq72kKmVzQYU7aOy4k0GsrgV=jfi_fLk2TvtWVGV_sXc8e2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/7/23 3:42 AM, Miguel Ojeda wrote:
> On Tue, Mar 7, 2023 at 2:07 AM Tom Rix <trix@redhat.com> wrote:
>> The build with fail generally with gcc 13.
>>
>> The warnings could be cleaned without having an error, but I looked at
>> multiple errors, none of them were real.
>>
>> imo this is a broken compiler option.
> I am not sure I understand -- my reading of Kees' message is that he
> would prefer to get the warning (rather than the kernel) fixed before
> GCC 13 releases.

yes, that would be ideal.

But anyone using gcc 13 in the meanwhile will have a broken build

and any other aspect of testing the kernel with gcc 13 would have

to be deferred to after the fix, if it happens.

>
> Are you asking to have the option disabled until GCC 13 releases and
> reevaluate then? How many warnings are you getting? Are those actual
> errors or `-Werror`?

With W=1, there are 40 error:'s, sorry I do not have the default logs at 
hand.

I looked about 10 of them over the weekend, they we all bogus.

So gcc needs to be fixed first, just disabling with -Wnoerror will

give folks bad problems that do not need fixing.


I am asking that we at least temporarily disable this option so

the build break is fixed.

Tom

>
> Cheers,
> Miguel
>

