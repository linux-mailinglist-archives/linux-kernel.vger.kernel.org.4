Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85ADD722EAA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 20:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjFES2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 14:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjFES2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 14:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B57AD9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 11:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685989655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NLqF+FP9XKGLY/N8TYvolkTUJ/XX2aaQacQy9cI24wI=;
        b=cbx1B7Mk8qzL95Y4II46wxyl0djxz9qFVaaIiX3LI8CVsRWYi+Xc/PsQE9sO/yGN6Zfesy
        ynLGeEarxJTQMRjLGYeZPw4occm6v93e33tdqcrDbrC4Y2ya6VmdiYxah8Y4EBAMqPSJrm
        6Lh5AZuxksgU6mg9w+v0BFJQ5V8zu0I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-4ZyE_Fw5Oey7PNd0dozH6g-1; Mon, 05 Jun 2023 14:27:34 -0400
X-MC-Unique: 4ZyE_Fw5Oey7PNd0dozH6g-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-514abe67064so3396897a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 11:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685989653; x=1688581653;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLqF+FP9XKGLY/N8TYvolkTUJ/XX2aaQacQy9cI24wI=;
        b=gmmpeYvaecooLBVzyOpKMuQv3vijGmKbaQgy2eJMZIudqN2uCaT9asXUGzV6pIvOSs
         tAdwdQ+4m3m8tVtumiOJgyrk0LAVMwI+NlOSxmJsYa0BKvFP43hDk/+VeRddXhwzoItB
         AFupStLjccgbOCSlwiqAIqrgGKVuLHpPUeZgtgFbHUuopp+JDUQnqCqGVJyYcM9JnYYm
         EEsBHYq3xpFozty4EgL8MIxv+j5jw5sTizECQq51Rceg8BbGxF7SaCDNbGJw4kHAUa6X
         KuQkigU9+XsiVr7KXY+KQoNL7UD6gIvU+BNgkHttNAfwYKq0mSOs7jxp8ZXxlfluoxEc
         5l9A==
X-Gm-Message-State: AC+VfDzxh7azgg86s8k8sPVtYxNT37VYyNs58/Ynd7/GcklFb0OYQR3J
        qmXrCTB5v2nmTyQ25TYNPwNRrFE3TflAEyA0cTt1+R9RqiPv2W6llJcblo/JZhQSm2s6OOSOQO7
        Tn3xAnQhZHpN45s4gsmdfsjv5
X-Received: by 2002:aa7:d051:0:b0:514:9dd7:4bcc with SMTP id n17-20020aa7d051000000b005149dd74bccmr36024edo.14.1685989652940;
        Mon, 05 Jun 2023 11:27:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ40LZ2pka/pHDfXINckd39P6zW4VjPB1HZOEZInL2ZhFkwFzNmdd9ivBw6YCEmTf5+BOFbxmQ==
X-Received: by 2002:aa7:d051:0:b0:514:9dd7:4bcc with SMTP id n17-20020aa7d051000000b005149dd74bccmr36018edo.14.1685989652626;
        Mon, 05 Jun 2023 11:27:32 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id v12-20020aa7cd4c000000b0050bc6983041sm4057277edw.96.2023.06.05.11.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 11:27:31 -0700 (PDT)
Message-ID: <3b7194b7-4616-0585-9a4a-91d42eebea9a@redhat.com>
Date:   Mon, 5 Jun 2023 20:27:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] KVM: x86/mmu: Remove KVM MMU write lock when accessing
 indirect_shadow_pages
Content-Language: en-US
To:     Ben Gardon <bgardon@google.com>, Jim Mattson <jmattson@google.com>
Cc:     Mingwei Zhang <mizhang@google.com>,
        Sean Christopherson <seanjc@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230605004334.1930091-1-mizhang@google.com>
 <CALMp9eSQgcKd=SN4q2QRYbveKoayKzuYEQPM0Xu+FgQ_Mja8-g@mail.gmail.com>
 <CANgfPd9kKxq1146F3mX_u7KCC0HrWfgYrxZd6c9Dh7s19E4Eog@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CANgfPd9kKxq1146F3mX_u7KCC0HrWfgYrxZd6c9Dh7s19E4Eog@mail.gmail.com>
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

On 6/5/23 19:17, Ben Gardon wrote:
>>> -               if (indirect_shadow_pages)
>>> +               if (READ_ONCE(vcpu->kvm->arch.indirect_shadow_pages))
>> I don't understand the need for READ_ONCE() here. That implies that
>> there is something tricky going on, and I don't think that's the case.
> Agree this doesn't need a READ_ONCE. Just a read is fine.
> kvm_mmu_unprotect_page starts by acquiring the MMU lock, so there's
> not much room to reorder anything anyway.

I agree that "there's not much room to reorder anything", but it's not a 
particularly formal/reassuring statement :) and READ_ONCE/WRITE_ONCE 
have documentation value too.

Or maybe it's because I've become used to the C11 memory model.  Either 
way, I like the idea to use READ_ONCE/WRITE_ONCE more explicitly 
whenever there can be concurrent accesses (which would be data races in 
the C11 model), and I think Linux is moving in that direction too.

Paolo

