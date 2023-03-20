Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27856C1D27
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjCTREm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjCTREO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B53366B6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679331306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8jLk4WbwvS9Ny13bH7DClBsHew7f2C7O1NAotrJay2U=;
        b=byUMn5s97TO9TTxYPhhA2y5dHkzbH4yezsXkjplsJqzb2eMq+N2kILDM6gFHhfSNw6LRh3
        U367y86cXzRv3eNlOi5TG4DQCoj4Eq+lSRCEuO3tb2QDCBbsxS6etH3pVWSNKIaL9MHmuu
        l2e0PVF2AscP2QfLze1OS9biqhxWtrg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-vLUA5zUuMvyeQ-vfsjLHVQ-1; Mon, 20 Mar 2023 12:48:55 -0400
X-MC-Unique: vLUA5zUuMvyeQ-vfsjLHVQ-1
Received: by mail-qv1-f70.google.com with SMTP id qf24-20020a0562144b9800b005bd49d98a78so4624421qvb.14
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679330934;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8jLk4WbwvS9Ny13bH7DClBsHew7f2C7O1NAotrJay2U=;
        b=rVZRo1xXXTQdsBs0OVGEyv5ogHhQRGRabz0T7quskPyBhulM8Eyk9a1/1G5jmGF6Jo
         TmVER/3DRucKzi5FfqYtC2SsC4UDYzY7RJAwnhHpTYxe6jfycAEK87xWHYAXFtYfSJfC
         sjhh+AwpePuUufpIoEU26nISJNwr398VD7sLlxDQf2YWYG9ypor+upnX6XTumRxcIoab
         5B7PMJ50MEf9ZqK/uANDJbgRoUn4EZOAyEeozEz+Mucjn7xS1X7QiCJxvNmwIcBN4aFG
         Zls578pDXDsCdvLY0vX4Bgvpc+BnSIlHA4lorzX4tSofpsU59jVaNinptZtyTw80MxOV
         npoA==
X-Gm-Message-State: AO0yUKXhpnOk4l058JgDJqLgpwDRXfLlDR0WsbtpjtsrK2dyjJte+QP+
        P3riz9816fO0cWz7Yx43NIjKIyxomrze6T7s1fB1lRSbWs9omEndRh2ykaMFg/dESmKP967//8R
        v10TSfjMc/2buf8x0ssMVsmlm
X-Received: by 2002:a05:622a:315:b0:3e3:7cf1:c453 with SMTP id q21-20020a05622a031500b003e37cf1c453mr2812313qtw.18.1679330934533;
        Mon, 20 Mar 2023 09:48:54 -0700 (PDT)
X-Google-Smtp-Source: AK7set/nha1fcO+y4yO4p9AC5bCoFlYVNIMLGxBzqcQix8NlbIGIUZJ7jJj7d5Agz6/Uf8LuvPgs3g==
X-Received: by 2002:a05:622a:315:b0:3e3:7cf1:c453 with SMTP id q21-20020a05622a031500b003e37cf1c453mr2812271qtw.18.1679330934232;
        Mon, 20 Mar 2023 09:48:54 -0700 (PDT)
Received: from [192.168.149.90] (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
        by smtp.gmail.com with ESMTPSA id w2-20020ac87182000000b003b9a6d54b6csm6615687qto.59.2023.03.20.09.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 09:48:53 -0700 (PDT)
Message-ID: <c83cb646-ce29-5397-aa1b-4a26f92a6102@redhat.com>
Date:   Mon, 20 Mar 2023 17:48:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] kvm: vmx: Add IA32_FLUSH_CMD guest support
Content-Language: de-CH
To:     Sean Christopherson <seanjc@google.com>
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>, kvm@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Ben Serebrin <serebrin@google.com>,
        Peter Shier <pshier@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20230201132905.549148-1-eesposit@redhat.com>
 <20230201132905.549148-2-eesposit@redhat.com>
 <20230317190432.GA863767@dev-arch.thelio-3990X>
 <20230317225345.z5chlrursjfbz52o@desk>
 <20230317231401.GA4100817@dev-arch.thelio-3990X>
 <20230317235959.buk3y25iwllscrbe@desk> <ZBhzhPDk+EV1zRf0@google.com>
 <301c7527-6319-b993-f43f-dc61b9af4b34@redhat.com>
 <ZBiIt2LBoogxQ2jP@google.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <ZBiIt2LBoogxQ2jP@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 20/03/2023 um 17:24 schrieb Sean Christopherson:
> On Mon, Mar 20, 2023, Emanuele Giuseppe Esposito wrote:
>>
>> Am 20/03/2023 um 15:53 schrieb Sean Christopherson:
>>> The patches obviously weren't tested,
>> Well... no. They were tested. Call it wrongly tested, badly tested,
>> whatever you want but don't say "obviously weren't tested".
> 
> Heh, depends on how you define "tested".  I was defining tested as "tested to
> work as expected on systems with and without support for IA32_FLUSH_CMD".
> 
> But yeah, I should have said "properly tested".
> 
>> I even asked you in a private email why the cpu flag was visible in Linux and
>> not in rhel when using the same machine.
>>
>> So again, my bad with these patches, I sincerely apologize but I would
>> prefer that you think I don't know how to test this stuff rather than
>> say that I carelessly sent something without checking :)
> 
> I didn't intend to imply that you didn't try to do the right thing, nor am I
> unhappy with you personally.  My apologies if my response came off that way.
> 
> What I am most grumpy about is that this series was queued without tests.  E.g.
> unless there's a subtlety I'm missing, a very basic KVM-Unit-Test to verify that
> the guest can write MSR_IA32_FLUSH_CMD with L1D_FLUSH when the MSR is supported
> would have caught this bug.  One of the reasons for requiring actual testcases is
> that dedicated testcases reduce the probability of "testing gone wrong", e.g. a
> TEST_SKIPPED would have alerted you that the KVM code wasn't actually being exercised.
> 
Yeah, I should have added a test. I see what you mean.

Anyways, as the cover letter said patches 1-2 are both unnecessary and
taken from an old past serie that was left unanswered (that's why I
thought it was lost).
What mainly interested me was patch 3, ie advertising FLUSH_L1D to user
space. As far as I understand, that looks good to you, right?

I'll be happy to do the exercise and resend all three patches plus an
unit test to verify it works if you want. But if you think they are
useless, just drop the first two and take only the third.

As always, I appreciate you&Paolo&others feedback :)

Let me know what you think.

Thank you,
Emanuele

