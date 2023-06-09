Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03C57296DE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbjFIKbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbjFIKaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930351A1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 03:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686306058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQiGjNiItnmLkeqgf+FiJ4SBs5FhBkkGC4T+rqTu/+s=;
        b=U/pvH2Za5SQqFBnXLQqXQkkHNea6HF0kKWOcLQYZRgtHtQ8ShLDWbMiiGMGkSNQR32wQGI
        mGUXHGTX+z5qfLLUnhClG+EUx9PaVY1bGkfZGa4Nwyr3iKPyAINmSPlipradpHuidq7DOO
        THN0lhh9vMiYo/71EGdzZ6fIa3lnJ28=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-y9wbOmL6PtqVghAkXzlMMw-1; Fri, 09 Jun 2023 06:20:57 -0400
X-MC-Unique: y9wbOmL6PtqVghAkXzlMMw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-977d0333523so203997066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 03:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686306056; x=1688898056;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQiGjNiItnmLkeqgf+FiJ4SBs5FhBkkGC4T+rqTu/+s=;
        b=ZbGwZ73gMVzymcg4jI6QCtDykNxiPNxNfQ4H77Yu4k8Rt6ib8jlWtpeVAbttMGkVMl
         lOiRdTngC15m8GHkz5SjnyGn1TPSCT4LfBEwRH+dyHcbWXw9Rx9lUJcr6pf87d0gXhHi
         BLzbj38gceNVXF37xHMKxZA1Sv8jVIbD5NnwbqehcVs6Eo6Da7yCGl2fIvL0GSKaJWpv
         8k9yolvnBH23eXvgCJcKCyusnmuD8BDHwM/OteQZUH3+opFipxIucpMehyPtn0m/fBAq
         GZRddkQuLPVDdEKXOhbbC5F2LwTtmXZcNS6T4bmhayBy8sjBaSbmUjDcbE/8MURUlq8T
         xxLg==
X-Gm-Message-State: AC+VfDwtW3myzeInlgCTU4OEOsAxubyd6pZ+b75dnthlqHUPBhJQPQnw
        jttdjMyhq3baPp/8SUIZdAGd0qafp3J7dFyiFdTNRLBgFN9LyHXV8hpZrOFjpsbTlK6mtsM+3Gp
        4O1yHm9ZsgVLeTHc2fh2hv5GD
X-Received: by 2002:a17:907:368d:b0:961:78c2:1d27 with SMTP id bi13-20020a170907368d00b0096178c21d27mr1631103ejc.19.1686306056614;
        Fri, 09 Jun 2023 03:20:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6iKtG7y80UtPpN+4/2JHdJO340nWszUvGlvULhmXBlodeeYW/klqijJzqsUOBY4fzUPfHSeQ==
X-Received: by 2002:a17:907:368d:b0:961:78c2:1d27 with SMTP id bi13-20020a170907368d00b0096178c21d27mr1631060ejc.19.1686306056270;
        Fri, 09 Jun 2023 03:20:56 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id y21-20020a1709064b1500b009682b2b3d66sm1086253eju.197.2023.06.09.03.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 03:20:55 -0700 (PDT)
Message-ID: <e7095f56-44c4-7cf1-69f5-4ff66d20952c@redhat.com>
Date:   Fri, 9 Jun 2023 12:20:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de,
        linux-toolchains@vger.kernel.org
References: <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net>
 <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net>
 <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
 <20230607094101.GA964354@hirez.programming.kicks-ass.net>
 <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
 <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com>
 <202306080917.C0B16C8@keescook>
 <CAKwvOdmY_NEK4cnrqwU8acpU=SK3Z2uV_3PYCnhA5zQt2_TJJg@mail.gmail.com>
 <20230608185142.GA1019250@hirez.programming.kicks-ass.net>
 <CAKwvOd=MurF6DQHzRTai15h67FEpd_4R-gz_iFejzLsL=dw3dA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
In-Reply-To: <CAKwvOd=MurF6DQHzRTai15h67FEpd_4R-gz_iFejzLsL=dw3dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/23 22:14, Nick Desaulniers wrote:
> Here, we're talking about using __attribute__((cleanup())) to DTR
> locally, but then we return a "raw" pointer to a caller. What cleanup
> function should the caller run, implicitly, if at all?  If we use
> __attribute__((cleanup())) that saves us a few gotos locally, but the
> caller perhaps now needs the same treatment.

But this is only a problem when you return a void*; and in general in C 
you will return a struct more often than a raw pointer (and in C++ you 
also have the issue of delete vs. delete[], that does not exist in C).

Returning a struct doesn't protect against use-after-free bugs in the 
way std::unique_ptr<> or Rust lifetimes do, but it at least tries to 
protect against calling the wrong cleanup function if you provide a 
typed "destructor" function that does the right thing---for example by 
handling reference counting or by freeing sub-structs before calling 
kfree/vfree.

Of course it's not a silver bullet, but then that's why people are 
looking into Rust for Linux.

Paolo

