Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9E161326C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiJaJT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJaJTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:19:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522DBD2E4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667207905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wEf8cRb4TLYPYASggaPulamyqh6fRxomZhqUsJe70lA=;
        b=JNju3m/nRBMX092vQ3W4go73D3qWawC3RkucJ7bVxDJJ0fgXOy7znZjTv86Mru2t/ITGSq
        46hEJqsjXaoPT+iMnc8hb4gNSvnT2xpd4JDIfxABg30ON8D2kueF4h6ioWjlckOYiCa98l
        sY7AhcjzC+fMKCC1iKMqmQtfq4Y81dE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-424-x5jOAwLPPAimc9ECWQj1fg-1; Mon, 31 Oct 2022 05:18:24 -0400
X-MC-Unique: x5jOAwLPPAimc9ECWQj1fg-1
Received: by mail-qv1-f69.google.com with SMTP id e9-20020ad45369000000b004bbb737fcf9so2807668qvv.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wEf8cRb4TLYPYASggaPulamyqh6fRxomZhqUsJe70lA=;
        b=5PaE8oyG+2YEgUlW3FgCIwC0Mjo241AzBPiupGgKw04SEzIxhQ1K7CGqrAxvg6SJJg
         3qPh9cRLf+q7Z4n4HqA1ufrmQkYsCm22dcj1Rnwzm1G/83KJ63XapWyO5KzbnE7VtE23
         svjI7X/ixk4I+RmSzfiAn2micLFU9HCuI2p3u2xQi16wNxtSTH9cc2VsArQxG48fnHoy
         XySgxJRzqw7ky7XM0Nu/fsDWKMjqQzwmouH0Ks9yCZOf1lj+BRuN7ZiSoz8GWAWB0ecD
         uV2Y2bXFip7bseO4kCuj3Ivqer/z34B8b0n/Ar8EqCRfJxusiQcwuLuD+yII0KToCUWZ
         PLcA==
X-Gm-Message-State: ACrzQf3bXeHz+h/0rmnSATVxj4+pCJT1lh/Op+axaAgeHmOqVu/gHJJM
        UPpRGWbRz2jkgPM/cpvpz8FQbQv5SD//Jf5/pQMRqlE1HRNH0VxUESOPTCMqVVy/ll/uZk07UUa
        d/ApBU5EUYfECWaqZBxClxrrv+5cgy/Bsat9Oy2t3lFxLssnNNOonPdMn4qFaZo9vrcNc3kxUH6
        b2
X-Received: by 2002:a05:620a:199f:b0:6ee:bbd2:4c50 with SMTP id bm31-20020a05620a199f00b006eebbd24c50mr8364047qkb.500.1667207903727;
        Mon, 31 Oct 2022 02:18:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4olZT6py2Dkvc62FgswOCrOLSA+9D1FbQFn4jFwUP7lTvfqZXuIVpxdtJRuQF/qYD1vFf9DA==
X-Received: by 2002:a05:620a:199f:b0:6ee:bbd2:4c50 with SMTP id bm31-20020a05620a199f00b006eebbd24c50mr8364026qkb.500.1667207903435;
        Mon, 31 Oct 2022 02:18:23 -0700 (PDT)
Received: from ovpn-194-149.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id g1-20020a05620a40c100b006cebda00630sm603594qko.60.2022.10.31.02.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 02:18:22 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/46] KVM: x86: hyper-v: Fine-grained TLB flush +
 L2 TLB flush features
In-Reply-To: <Y1m1Jnpw5betG8CG@google.com>
References: <20221021153521.1216911-1-vkuznets@redhat.com>
 <Y1m0ef+LdcAW0Bzh@google.com> <Y1m1Jnpw5betG8CG@google.com>
Date:   Mon, 31 Oct 2022 10:18:19 +0100
Message-ID: <87zgdcs65g.fsf@ovpn-194-149.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Oct 26, 2022, Sean Christopherson wrote:
>> On Fri, Oct 21, 2022, Vitaly Kuznetsov wrote:
>> >   KVM: selftests: evmcs_test: Introduce L2 TLB flush test
>> >   KVM: selftests: hyperv_svm_test: Introduce L2 TLB flush test
>> 
>> Except for these two (patches 44 and 45),
>> 
>> Reviewed-by: Sean Christopherson <seanjc@google.com>

Thanks! I'll take a look at 44/45 shortly.

>
> Actually, easiest thing is probably for Paolo to queue everything through 43
> (with a comment in patch 13 about the GPA translation), and then you can send a
> new version containing only the stragglers.

Paolo,

do you want to follow this path or do you expect the full 'v13' from me? 

-- 
Vitaly

