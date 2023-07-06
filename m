Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465B6749A9C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjGFLaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjGFLax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C821727
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688643006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LuiRGI269Np92lVN6nJmdyMw4xzKbo2Z74mCs1dTD80=;
        b=Y4dSImJB1zfrvwl1WAs6S/aKXBRf8ADvKL1+JjO164NZmCWeCRZQIOvBKUdz9t9fJY4qKS
        WsY3gWeFB7KAVadbiA13opsiDCmHIYH7ZF51CdpFWDh5b40ewMLO7dWVOW3LfQNgKNJTpV
        XjdNrE/1thXrCXgDXWA/LpLHye7A4uA=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-gOsOnnx7NQOeWfagFzmsRw-1; Thu, 06 Jul 2023 07:30:05 -0400
X-MC-Unique: gOsOnnx7NQOeWfagFzmsRw-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-47e114de3b7so68188e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 04:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688643005; x=1691235005;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuiRGI269Np92lVN6nJmdyMw4xzKbo2Z74mCs1dTD80=;
        b=Hf4Ucya/wKdSHxU+OwKK8f6aqfEr7Gcb+EtoABe48tn4BRY0o5oLoGV5OUOOO9rtWS
         d+Dnw9eXtDxNLsRhcvfLH3l0ODoVyFpxoTi50If3Hd3Wa4iv9cVJk9en4i/3YjBNkagn
         9EczoeSxblbkzNzH39z2rAvdR6gJX1Lsl/FWZ7yhSjAX9fb/EzMjZe2pGC9HPHJUX5ul
         Olh8gBBXeZXI557dhfOnOTMqwnsrFzZ0EIIJGDTQFXHFlX+jXllp6shQ/Ifv5xj8jPKM
         OBiPfJNOPA9VQmrcUBp4MF2zuOc/nXPBdxkywZM/rPnGvSnGYe7bpaV60aZv1Pzx4x67
         lBXg==
X-Gm-Message-State: ABy/qLZzxuU78NzUaZloNSLo0r3ZE3EtD/1oCRxHnaJB425NtZzZ+T9j
        KKsHKLtpNr1uH/QI93KlDP9teFPchmhpBoVDII/IBeK9Kp/Z6KhikX8J347nSB2LLXCT5RmP6sm
        MmGGpr+mBWMeBllgjS3jFKFoU
X-Received: by 2002:a67:ead2:0:b0:443:7599:d460 with SMTP id s18-20020a67ead2000000b004437599d460mr514997vso.1.1688643005211;
        Thu, 06 Jul 2023 04:30:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEOiF8Wo8ldpNlkhzPot2vQELEDG+c71tqhQGpmzmO1eN6k2V6nMi6SJLmlPXMGtcsuw7emcA==
X-Received: by 2002:a67:ead2:0:b0:443:7599:d460 with SMTP id s18-20020a67ead2000000b004437599d460mr514990vso.1.1688643004926;
        Thu, 06 Jul 2023 04:30:04 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id a25-20020a0ca999000000b0063645f62bdasm761336qvb.80.2023.07.06.04.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 04:30:04 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Chuang Wang <nashuiliang@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Petr Mladek <pmladek@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
        Julian Pidancet <julian.pidancet@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH 00/14] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
In-Reply-To: <57D81DB6-2D96-4A12-9FD5-6F0702AC49F6@vmware.com>
References: <20230705181256.3539027-1-vschneid@redhat.com>
 <57D81DB6-2D96-4A12-9FD5-6F0702AC49F6@vmware.com>
Date:   Thu, 06 Jul 2023 12:29:58 +0100
Message-ID: <xhsmhwmzduvk9.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/23 18:48, Nadav Amit wrote:
>> On Jul 5, 2023, at 11:12 AM, Valentin Schneider <vschneid@redhat.com> wr=
ote:
>>
>> Deferral approach
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Storing each and every callback, like a secondary call_single_queue turn=
ed out
>> to be a no-go: the whole point of deferral is to keep NOHZ_FULL CPUs in
>> userspace for as long as possible - no signal of any form would be sent =
when
>> deferring an IPI. This means that any form of queuing for deferred callb=
acks
>> would end up as a convoluted memory leak.
>>
>> Deferred IPIs must thus be coalesced, which this series achieves by assi=
gning
>> IPIs a "type" and having a mapping of IPI type to callback, leveraged up=
on
>> kernel entry.
>
> I have some experience with similar an optimization. Overall, it can make
> sense and as you show, it can reduce the number of interrupts.
>
> The main problem of such an approach might be in cases where a process
> frequently enters and exits the kernel between deferred-IPIs, or even wor=
se -
> the IPI is sent while the remote CPU is inside the kernel. In such cases,=
 you
> pay the extra cost of synchronization and cache traffic, and might not ev=
en
> get the benefit of reducing the number of IPIs.
>
> In a sense, it's a more extreme case of the overhead that x86=E2=80=99s l=
azy-TLB
> mechanism introduces while tracking whether a process is running or not. =
But
> lazy-TLB would change is_lazy much less frequently than context tracking,
> which means that the deferring the IPIs as done in this patch-set has a
> greater potential to hurt performance than lazy-TLB.
>
> tl;dr - it would be beneficial to show some performance number for both a
> =E2=80=9Cgood=E2=80=9D case where a process spends most of the time in us=
erspace, and =E2=80=9Cbad=E2=80=9D
> one where a process enters and exits the kernel very frequently. Reducing
> the number of IPIs is good but I don=E2=80=99t think it is a goal by its =
own.
>

There already is a significant overhead incurred on kernel entry for
nohz_full CPUs due to all of context_tracking faff; now I *am* making it
worse with that extra atomic, but I get the feeling it's not going to stay
:D

nohz_full CPUs that do context transitions very frequently are
unfortunately in the realm of "you shouldn't do that". Due to what's out
there I have to care about *occasional* transitions, but some folks
consider even that to be broken usage, so I don't believe getting numbers
for that to be much relevant.

> [ BTW: I did not go over the patches in detail. Obviously, there are
>   various delicate points that need to be checked, as avoiding the
>   deferring of IPIs if page-tables are freed. ]

