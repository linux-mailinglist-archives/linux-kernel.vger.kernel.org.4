Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCC86078C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiJUNnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiJUNnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD47278145
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666359791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Fp/t0MHVjo92qogg0AYC5TyzhcxyvXKs2Riw174VTM=;
        b=N/dj3LSWJ3/jLp5tpHPPzvF4JF2Gc8ROlzi/7RlJdqqF+P2ncIGB33+u0WNfQmRtPnMi/6
        NiGKtYLkTCpJzS9Wkcdtu8VPaO5SnXYauQhThOfz2hW0qNvOdpEZrm84Z1+q4j1uFeEuWa
        yLeVzoOWoKqVIdbaxxXAC/+tZrfteQY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-53-ZyKgZmSsNxafutW8lLOK-A-1; Fri, 21 Oct 2022 09:43:02 -0400
X-MC-Unique: ZyKgZmSsNxafutW8lLOK-A-1
Received: by mail-ed1-f72.google.com with SMTP id y14-20020a056402270e00b0045d1baf4951so2528944edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Fp/t0MHVjo92qogg0AYC5TyzhcxyvXKs2Riw174VTM=;
        b=2ypIiiF/Pro9rZV6gyVXVXQrv4/w/qYL2qEV7prGz6sr4NWQLRtipxgRMK7FfSaBas
         3MyVuU6XQGKA6L2kU426Hmg6pAg62xA8QUta/SZpPLigauMVGzybbzBDU2OWNkNiMBaT
         8ueuxKbg1TvizFGklCV1W2GwztJheYU9pgq3p8bRlh/d+c+9DtmaZfjZpYYoSpwVovbp
         UuVzLlwsW6N55MugUaVPgZroaVwbyZBXjzWHrbCFAuF4nwLIvTH0JJpQKuEE/0nCwbgs
         1oUXAG1aOSv5IorwNar1u/U/yi4R//JWI1m3bH4a3nuEh4l/Jt3UiDpXkphTkk3+2i6T
         9Ohg==
X-Gm-Message-State: ACrzQf05xisAbhdJua846NwNI7soyCA95zvwHhXpptjOHKhMDrsHkE6k
        HHpXolQ4QLCXoSWuNc0FTk1hQhRmS8dpIw1FW4tkVV6e20FWuWz5XcAMN4cucYdBGy2rDVIF6Cg
        +//mh+HAx2yL05FZaRYUYJykgIeOSVVLDw2rjcCbZlf8yg0yHP76Y9GHcVdUGbQg40vhE2cpp76
        48
X-Received: by 2002:a05:6402:50d4:b0:45d:fe2:45 with SMTP id h20-20020a05640250d400b0045d0fe20045mr17837351edb.221.1666359777097;
        Fri, 21 Oct 2022 06:42:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM50/NSD4ymcGHu4c1l7asjJM1pvpRY2nyQysqVvK1pwNVFmAnQO/1RBD/6H+/pj7se2K/xv4A==
X-Received: by 2002:a05:6402:50d4:b0:45d:fe2:45 with SMTP id h20-20020a05640250d400b0045d0fe20045mr17837321edb.221.1666359776876;
        Fri, 21 Oct 2022 06:42:56 -0700 (PDT)
Received: from ovpn-192-65.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id s11-20020a50d48b000000b00458947539desm13649818edi.78.2022.10.21.06.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:42:56 -0700 (PDT)
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
In-Reply-To: <874jvxcnyp.fsf@ovpn-192-65.brq.redhat.com>
References: <20221004123956.188909-1-vkuznets@redhat.com>
 <20221004123956.188909-34-vkuznets@redhat.com>
 <Y1B1eBIL9WhB4dwc@google.com> <874jvxcnyp.fsf@ovpn-192-65.brq.redhat.com>
Date:   Fri, 21 Oct 2022 15:42:55 +0200
Message-ID: <87zgdpb8dc.fsf@ovpn-192-65.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Sean Christopherson <seanjc@google.com> writes:
>
>> On Tue, Oct 04, 2022, Vitaly Kuznetsov wrote:
>
> ...
>
>>> +
>>> +	r = pthread_cancel(thread);
>>> +	TEST_ASSERT(r == 0,
>>
>> !r is generally preferred over "r == 0"
>>
>>> +		    "pthread_cancel on vcpu_id=%d failed with errno=%d",
>>> +		    vcpu->id, r);
>>
>> Do you happen to know if errno is preserved?  I.e. if TEST_ASSERT()'s print of
>> errno will capture the right errno?  If so, this and the pthread_join() assert
>> can be:
>>
>> 	TEST_ASSERT(!r, pthread_cancel() failed on vcpu_id=%d, vcpu->id);
>>
>
> The example from 'man 3 pthread_cancel' makes me think errno is not
> set. 'man 3 errno' confirms that:
>
> "
>        Note  that the POSIX threads APIs do not set errno on error.
> Instead, on failure they return an error number as the function result.
> These error numbers have the same meanings as the error numbers returned
> in errno by other APIs.
> "
>
> but nothing stops us from doing something like
>
> #include <errno.h>
> ...
>
> errno = pthread_cancel(thread);
> TEST_ASSERT(!errno, pthread_cancel() failed on vcpu_id=%d, vcpu->id);
>
> I believe.

... only the fact that this won't be thread safe :-( i.e. if we also try
setting 'errno' from vcpu_thread() (where the pattern for
pthread_setcanceltype() is exactly the same), we will likely be
reporting the wrong errno. I think it's better to keep reporting 'r' for
now (and maybe think about pthread* wrappers later).

-- 
Vitaly

