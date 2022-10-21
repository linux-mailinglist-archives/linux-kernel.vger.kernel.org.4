Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A276D60783E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiJUNVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiJUNUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA89D24E38E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666358450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZsPij9BvW1d4VCHGwc7667RVR2VkSQ3/k+XB1C+z4tA=;
        b=dRXKJMxmepjAj74b+76AQ3LVWS6kWKDakUfY4nG1ZSGGP5f7bK1TNV/0w89dnRKWlRCuH/
        r+ZyXbH2ipxlfr02I+TWrEycZK7f+6A/YWXbyXgDY1bwTnU1+Hx4jwN4M5KEP5ZJGuLizs
        1fnjJ8iADjlp2iCZsXMWh4fFruBHm7c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-i1A2PuoiNxmi5pn9vig8RA-1; Fri, 21 Oct 2022 09:20:49 -0400
X-MC-Unique: i1A2PuoiNxmi5pn9vig8RA-1
Received: by mail-ed1-f70.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so2415031eda.19
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsPij9BvW1d4VCHGwc7667RVR2VkSQ3/k+XB1C+z4tA=;
        b=yuX/46xLXYfoKh21Zu1eAYDNfxJrinwFYsPo4FyZurHwK9bqYGvwti8Taq6kexP+RO
         XY36LuveIA8ySUNGdEeUg66XgkuKORiT3gK7u/7XsG3yXzVOLl/2SIa/OlIVBfK5sLA3
         /vrizF6oXruBA5Q2gOxmavfch8h6UNcjArpp/ND9NQNvCZ0bVaOLhQQ9mLKlYTdcchDp
         ei74L6xYUaosquHJH8HPNCCnMBXRuScn4BYnKyBKtJr36LiAnVIghm2HpuNheAQFtRvK
         tLelHgtYNlRaz7hWZAqZs9Luu+RgW3xiek0dPI9koVrIJaffMJiEeWjIIumTRC0j9DC7
         ptqw==
X-Gm-Message-State: ACrzQf2PeJR+dXEfwRx9B+5x3Afo5sQWdhFSZbQFtsLskrpx27FPDj1g
        52qSGFE4rv+DsDjBYE8Mo+xxfv8YkOwdJzaTpXA6142JgU5Nnv0WngDNuZ9M8aiEFtM1JLd4ewp
        4EMi6fh/oW9OSlYrR1ttbEqFpeoSIC1RzIveq9xjygEnDnNLRVADRoNaufq15lb2xscgGNv6sTU
        xu
X-Received: by 2002:a17:906:d550:b0:78d:a6d4:c18f with SMTP id cr16-20020a170906d55000b0078da6d4c18fmr15768855ejc.113.1666358448492;
        Fri, 21 Oct 2022 06:20:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM78Ox5DULLooxv+oNbpida2qPtNCXNw0skZAst4D7gv1coM+49eLIkJVlVXWJCrWr8ON2a8tQ==
X-Received: by 2002:a17:906:d550:b0:78d:a6d4:c18f with SMTP id cr16-20020a170906d55000b0078da6d4c18fmr15768817ejc.113.1666358448188;
        Fri, 21 Oct 2022 06:20:48 -0700 (PDT)
Received: from ovpn-192-65.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id de13-20020a1709069bcd00b0078d957e65b6sm11587521ejc.23.2022.10.21.06.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:20:47 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 33/46] KVM: selftests: Hyper-V PV IPI selftest
In-Reply-To: <Y1B1eBIL9WhB4dwc@google.com>
References: <20221004123956.188909-1-vkuznets@redhat.com>
 <20221004123956.188909-34-vkuznets@redhat.com>
 <Y1B1eBIL9WhB4dwc@google.com>
Date:   Fri, 21 Oct 2022 15:20:46 +0200
Message-ID: <874jvxcnyp.fsf@ovpn-192-65.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Oct 04, 2022, Vitaly Kuznetsov wrote:

...

>> +
>> +	r = pthread_cancel(thread);
>> +	TEST_ASSERT(r == 0,
>
> !r is generally preferred over "r == 0"
>
>> +		    "pthread_cancel on vcpu_id=%d failed with errno=%d",
>> +		    vcpu->id, r);
>
> Do you happen to know if errno is preserved?  I.e. if TEST_ASSERT()'s print of
> errno will capture the right errno?  If so, this and the pthread_join() assert
> can be:
>
> 	TEST_ASSERT(!r, pthread_cancel() failed on vcpu_id=%d, vcpu->id);
>

The example from 'man 3 pthread_cancel' makes me think errno is not
set. 'man 3 errno' confirms that:

"
       Note  that the POSIX threads APIs do not set errno on error.
Instead, on failure they return an error number as the function result.
These error numbers have the same meanings as the error numbers returned
in errno by other APIs.
"

but nothing stops us from doing something like

#include <errno.h>
...

errno = pthread_cancel(thread);
TEST_ASSERT(!errno, pthread_cancel() failed on vcpu_id=%d, vcpu->id);

I believe.

-- 
Vitaly

