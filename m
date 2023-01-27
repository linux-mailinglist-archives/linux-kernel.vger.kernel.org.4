Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0CE67EA96
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjA0QQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbjA0QPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:15:55 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D036E7BBC9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:15:47 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id rl14so15125176ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omzXg8OT+1HtcPdH7sWBJQq9q/lSuoFptSXDIoH2qBE=;
        b=sxKgYruEvXs1bRh0GU0N/RYWpDzF6pgHMmVWgNmjZt5hYKnL6ZEVWQcWoiSFdliogy
         3CtadtBFdk0dE/jtfe50t15kUoTiWKlS/Nxcs4CJ3b0fHqxS03l4D05XavC8Yf6LqI2h
         8Pru7lfSL8ljpelPMdQv1DRqgqIepzTbRUsR2Y8w0eew8k0RrMwtZdALHfFameMy2UsK
         X4JgCRIsgXCrPeVFB8DCgoaEjSCuBa2R/p4SLv0aI/IENp7Mo/+jq+jUPFVkj48rL+fw
         kda+VuwHedyNcigzjOrDLmT+vQL+XICY2lANA+9Dly068XIxKF7IU2Xc2lI+xqqP9d7C
         g0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omzXg8OT+1HtcPdH7sWBJQq9q/lSuoFptSXDIoH2qBE=;
        b=MoLF/CulmBQ7CNTCP35RzBCDLOLM6bPFij1/awZlXpa/mlkJrTKU3dC1dDCQEbUSDH
         F8l+e6wnWBFgX2d3PeUje9eMcGgzOrPFQFYxBqkNH0VtBOG+gN/zePPB/4kf7Q1NXTVP
         nSmoWW5Pfn8I9MMTdWyH2LYiS/SjazkONxuHZ4U5GyroGqZa2HhdXSs/2Ic0fwa4VJLO
         pAowYAyZBoNd/RiCMD8WUT7OsYikc2yf5beiwegzdxUEJiaCOLk9DYZCMoWLxgqbZfLN
         8fz4o7eiM4h5M7yUeaB90koYm99J52/yue0HqzvYGaPfHZjkD4p/UmhJjYxsPAt4/xhT
         fNFA==
X-Gm-Message-State: AFqh2kpFYYhKOgR04H4nULGR0/ifRlTzwDslr3j8eKQU/pY7d3vbyWxv
        KJQEr4OtQx6lZHnR7Taw0JWtqCG8KtDNwQGVqnI=
X-Google-Smtp-Source: AMrXdXunZWLZUXYRKw2maJa5BYMxljiU1YRa2lQcshHGtRF9mVQZf9Gmwt2+FRd9a8Cq0+x2+OWB3A==
X-Received: by 2002:a17:907:9623:b0:869:236c:ac40 with SMTP id gb35-20020a170907962300b00869236cac40mr55061282ejc.31.1674836146460;
        Fri, 27 Jan 2023 08:15:46 -0800 (PST)
Received: from ?IPV6:2003:f6:af06:9e00:9ba6:6299:7a26:8e00? (p200300f6af069e009ba662997a268e00.dip0.t-ipconnect.de. [2003:f6:af06:9e00:9ba6:6299:7a26:8e00])
        by smtp.gmail.com with ESMTPSA id fu17-20020a170907b01100b008536ff0bb44sm2456373ejc.109.2023.01.27.08.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 08:15:45 -0800 (PST)
Message-ID: <ccad240e-d604-60e2-b12d-c7c3ca530887@grsecurity.net>
Date:   Fri, 27 Jan 2023 17:15:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/3] KVM: x86: do not unload MMU roots when only toggling
 CR0.WP
Content-Language: en-US, de-DE
From:   Mathias Krause <minipli@grsecurity.net>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20230117204556.16217-1-minipli@grsecurity.net>
 <20230117204556.16217-4-minipli@grsecurity.net> <Y8cTMnyBzNdO5dY3@google.com>
 <1b4d4488-9afc-91e9-790d-5b669d00217b@grsecurity.net>
In-Reply-To: <1b4d4488-9afc-91e9-790d-5b669d00217b@grsecurity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.01.23 11:17, Mathias Krause wrote:
> On 17.01.23 22:29, Sean Christopherson wrote:
>> On Tue, Jan 17, 2023, Mathias Krause wrote:
>>> [...] 
>>> Change kvm_mmu_reset_context() to get passed the need for unloading MMU
>>> roots and explicitly avoid it if only CR0.WP was toggled on a CR0 write
>>> caused VMEXIT.
>>
>> One thing we should explore on top of this is not intercepting CR0.WP (on Intel)
>> when TDP is enabled.  It could even trigger after toggling CR0.WP N times, e.g.
>> to optimize the grsecurity use case without negatively impacting workloads with
>> a static CR0.WP, as walking guest memory would require an "extra" VMREAD to get
>> CR0.WP in that case.
> 
> That would be even better, agreed. I'll look into it and will try to
> come up with something.

I looked into it and we can gain quite a few more cycles from this, e.g.
the runtime for the 'ssdd 10 50000' test running with TDP MMU takes
another bump from 7.31s down to 4.89s. That's overall 2.8 times faster
than the 13.91s we started with. :)

I'll cook up a patch next week and send a v3 series with some more
cleanups I collected in the meantime.

>> Unfortunately, AMD doesn't provide per-bit controls.

Meanwhile I got my hands on an AMD system and it gains from this series
as well, not as much as my Intel system, though. We go down from 5.8s to
4.12s for the 'ssdd 10 50000' test with TDP MMU enabled -- a nearly 30%
runtime reduction.

>>> This change brings a huge performance gain as the following micro-
>>> benchmark running 'ssdd 10 50000' from rt-tests[1] on a grsecurity L1 VM
>>> shows (runtime in seconds, lower is better):
>>>
>>>                       legacy MMU   TDP MMU
>>> kvm.git/queue             11.55s    13.91s
>>> kvm.git/queue+patch        7.44s     7.94s
>>>
>>> For legacy MMU this is ~35% faster, for TTP MMU ~43% faster.
>>>
>>> [1] https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
>>>
>>> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
>>> ---
>>
