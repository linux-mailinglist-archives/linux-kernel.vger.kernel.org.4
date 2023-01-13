Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A0C6692DC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbjAMJ2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240992AbjAMJ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:27:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0256CFE4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673601627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E39P6xJFtKdnbgiloEzSc7PdC9n7NpO9iAPJ8YamLms=;
        b=jHwRJZYJOlbMye34UJd1QDO2OC/7OLox0JvkaMH6C1hVEnKXKzeBA/E0b78Rc5TWPfZ20u
        dLdlK00eG8eOuSZXf/LMFozd5gvp4nkq1rj4eH5aAai3Qh7vW7bS7ic/+UJpO0jxL1Kiq+
        jsqm6To5lec5Cbt/LIKEuJtAxa8bpZ8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-66-R6Igy8NsMnGmGemgLm0PfA-1; Fri, 13 Jan 2023 04:20:26 -0500
X-MC-Unique: R6Igy8NsMnGmGemgLm0PfA-1
Received: by mail-ej1-f72.google.com with SMTP id xj11-20020a170906db0b00b0077b6ecb23fcso14674175ejb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E39P6xJFtKdnbgiloEzSc7PdC9n7NpO9iAPJ8YamLms=;
        b=sSZZtSsL7ctl1ND1H/I+7VEtSwCxbn+vuPjB8pkmxtwab0OhSggt2vuE8MRD2gF8kq
         fZu+XmlRk/z1PetpSWLwjA5tpKsL9uPLWX1Qa76dV2w2MR5fTSqoD+ZXWylPTFyqu3N7
         ezGKhaDd1nHXRnM6CTY8lFbQMEEHQlVeph+oZalwMcvUnQInV+p/VQVzZP3nF6TdPgpw
         28qAWSJK78WXoNN/I1gnJq+pYsUhZuiBAv38Cm0rDX9JhwqE5/V0TXEYVOiBKKgIDRSi
         NowdmNxgED9Q7Oy5p+BRw88+wejerwRv9kt6t9MtfrlhXAV6JWIuGswwz1VB08dA1zE4
         XU2A==
X-Gm-Message-State: AFqh2krEiKNhrgMaVffjdvWjl6x9UG/p1DPXAQY9Bxhcy7aa88T5bHsR
        Okrd00yUPgEj0cWjR2wcaOQLms4HhQJVjBYDRXgEO9Ne6LsMAQZzN3TWLQssP6X7t7zCMqdm53b
        UmlhPTfyg04fxqz5gg37/3HbE
X-Received: by 2002:a17:906:d052:b0:7c1:5098:907a with SMTP id bo18-20020a170906d05200b007c15098907amr70409399ejb.35.1673601625179;
        Fri, 13 Jan 2023 01:20:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu+A9VTXHX62QJzylA4ENTpGt4m2gHv/owT5LMNTowovwA1ALCFnAa/p3OapN/YFDUVfnHYPA==
X-Received: by 2002:a17:906:d052:b0:7c1:5098:907a with SMTP id bo18-20020a170906d05200b007c15098907amr70409391ejb.35.1673601624959;
        Fri, 13 Jan 2023 01:20:24 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id ad7-20020a170907258700b0084bfd0a117bsm8405899ejc.16.2023.01.13.01.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 01:20:24 -0800 (PST)
Message-ID: <d1d44f07-558c-e0ed-403e-61a854c868cb@redhat.com>
Date:   Fri, 13 Jan 2023 10:20:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] Documentation: kvm: fix SRCU locking order docs
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com, Joel Fernandes <joel@joelfernandes.org>,
        Matthew Wilcox <willy@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230111183031.2449668-1-pbonzini@redhat.com>
 <a14a13a690277d4cc95a4b26aa2d9a4d9b392a74.camel@infradead.org>
 <20230112152048.GJ4028633@paulmck-ThinkPad-P17-Gen-1>
 <Y8EF24o932lcshKs@boqun-archlinux>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y8EF24o932lcshKs@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/23 08:18, Boqun Feng wrote:
> On Thu, Jan 12, 2023 at 07:20:48AM -0800, Paul E. McKenney wrote:
>> On Thu, Jan 12, 2023 at 08:24:16AM +0000, David Woodhouse wrote:
>>> On Wed, 2023-01-11 at 13:30 -0500, Paolo Bonzini wrote:
>>>>
>>>> +- ``synchronize_srcu(&kvm->srcu)`` is called inside critical sections
>>>> +  for kvm->lock, vcpu->mutex and kvm->slots_lock.  These locks _cannot_
>>>> +  be taken inside a kvm->srcu read-side critical section; that is, the
>>>> +  following is broken::
>>>> +
>>>> +      srcu_read_lock(&kvm->srcu);
>>>> +      mutex_lock(&kvm->slots_lock);
>>>> +
>>>
>>> "Don't tell me. Tell lockdep!"
>>>
>>> Did we conclude in
>>> https://lore.kernel.org/kvm/122f38e724aae9ae8ab474233da1ba19760c20d2.camel@infradead.org/
>>> that lockdep *could* be clever enough to catch a violation of this rule
>>> by itself?
>>>
>>> The general case of the rule would be that 'if mutex A is taken in a
>>> read-section for SCRU B, then any synchronize_srcu(B) while mutex A is
>>> held shall be verboten'. And vice versa.
>>>
>>> If we can make lockdep catch it automatically, yay!
>>
>> Unfortunately, lockdep needs to see a writer to complain, and that patch
>> just adds a reader.  And adding that writer would make lockdep complain
>> about things that are perfectly fine.  It should be possible to make
>> lockdep catch this sort of thing, but from what I can see, doing so
>> requires modifications to lockdep itself.
>>
> 
> Please see if the follow patchset works:
> 
> 	https://lore.kernel.org/lkml/20230113065955.815667-1-boqun.feng@gmail.com
> 
> "I have been called. I must answer. Always." ;-)

It's missing an important testcase; if it passes (does not warn), then 
it should work:

CPU 1                                    CPU 2
----------------------------             ------------------------------
mutex_lock(&m1);                         srcu_read_lock(&srcu1);
srcu_read_lock(&srcu1);                  mutex_lock(&m1);
srcu_read_unlock(&srcu1);                mutex_unlock(&m1);
mutex_unlock(&m1);                       srcu_read_unlock(&srcu1);

This is the main difference, lockdep-wise, between SRCU and an rwlock.

Paolo

