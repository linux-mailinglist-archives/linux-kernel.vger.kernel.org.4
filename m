Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746F260AB23
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 15:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbiJXNoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 09:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbiJXNka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 09:40:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20046B274F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666614930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GKxmaBT6LjGiaoDR1Bi+o4OcsEtTqQcUg/nyMQpUifI=;
        b=TIsl7HoksZLjfUbcBMKVdpc3D7jy5sxO0MHvf53h9BP/EuM7t5Xqg+jNISxXoyr9iY1Bow
        jPlNmn/W+AOc0oJDvok3GFPju/biItEibii7TF1m4ZlKT8xFu6xr6KnKTBM/XxG4ZUVVnx
        K8cd1XaDQcBHhkBh3yn5IqSP57bbfbE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-623-JpJjpSYXMGOe2u44G870-A-1; Mon, 24 Oct 2022 07:53:02 -0400
X-MC-Unique: JpJjpSYXMGOe2u44G870-A-1
Received: by mail-ed1-f70.google.com with SMTP id z7-20020a05640235c700b0045d3841ccf2so9328174edc.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKxmaBT6LjGiaoDR1Bi+o4OcsEtTqQcUg/nyMQpUifI=;
        b=2Qph+N6C4U+LtfT71C4wWR1LLK5zE9RYNEgoVJjw+fQ7LEZHCDoSAQrw2oQNv3bK/l
         X1a/nwwyAImtAekrFz/Mvy6iFuKqu0eUGwPPuy2Fxasg+Zb1Sie9wIrPgkycCXzR4kgi
         MeB2cwNWL9SKbvBo8fAa/86un1oQBrnd2A24CJVpkTBbEE3/9JQX4c9LFgiI9/Gn/FYE
         c/Ga7kXEGSza3/ZcoCNZDIoUk4MzkkPoOR9f2/NWid36rW+qkctTVVt97nLyLDiHl2JV
         To9RD2QHkq9ggdmllIc2o4RSdJFrVWtFHc/7F4EAFxEflwBIC/JlKR/NFAT21t5ocFU0
         wQtQ==
X-Gm-Message-State: ACrzQf3g9WEaGLzB5KVT/sSrqzTeyw2MbY9ryFDMbbFEcPHvteCWhY0Q
        /hU/wpfloN/gr+AZ8u0hXUFi/iLPNzENw9MFDE5oTk9PMthZ/yDZEUxayQ4pJGUjqwt8oyUHoYO
        7t22wNw6FTgLmU8zrQTyMaN0SewVS79dYC9wA2LKd5bsWjZRD3DPZ2VjAzcEBrkUwxQQhkXoXxm
        eL
X-Received: by 2002:a17:907:d9e:b0:78e:2ff7:72f4 with SMTP id go30-20020a1709070d9e00b0078e2ff772f4mr25817462ejc.608.1666612380772;
        Mon, 24 Oct 2022 04:53:00 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6tcn4RZya1Fvj8QaE94/aBh+cccAaF2sp6qcdWk+xwIQh5UgVhQ0BXgGBQ/DN8cnxpueRC+g==
X-Received: by 2002:a17:907:d9e:b0:78e:2ff7:72f4 with SMTP id go30-20020a1709070d9e00b0078e2ff772f4mr25817440ejc.608.1666612380490;
        Mon, 24 Oct 2022 04:53:00 -0700 (PDT)
Received: from ovpn-193-3.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a24-20020a1709063a5800b0078128c89439sm15530831ejf.6.2022.10.24.04.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:52:59 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, dmatlack@google.com, kvm@vger.kernel.org,
        shujunxue@google.com, terrytaehyun@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Add Hyperv extended hypercall support in KVM
In-Reply-To: <Y1MXgjtPT9U6Cukk@google.com>
References: <20221021185916.1494314-1-vipinsh@google.com>
 <Y1L9Z8RgIs8yrU6o@google.com>
 <CAHVum0eoA5j7EPmmuuUb2y7XOU1jRpFwJO90tc+QBy0JNUtBsQ@mail.gmail.com>
 <Y1MXgjtPT9U6Cukk@google.com>
Date:   Mon, 24 Oct 2022 13:52:58 +0200
Message-ID: <87k04pbfqd.fsf@ovpn-193-3.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Oct 21, 2022, Vipin Sharma wrote:
>> On Fri, Oct 21, 2022 at 1:13 PM Sean Christopherson <seanjc@google.com> wrote:
>> >
>> > On Fri, Oct 21, 2022, Vipin Sharma wrote:
>> > > Hyperv hypercalls above 0x8000 are called as extended hypercalls as per
>> > > Hyperv TLFS. Hypercall 0x8001 is used to enquire about available
>> > > hypercalls by guest VMs.
>> > >
>> > > Add support for HvExtCallQueryCapabilities (0x8001) and
>> > > HvExtCallGetBootZeroedMemory (0x8002) in KVM.
>> > >
>> > > A guest VM finds availability of HvExtCallQueryCapabilities (0x8001) by
>> > > using CPUID.0x40000003.EBX BIT(20). If the bit is set then the guest VM
>> > > make hypercall HvExtCallQueryCapabilities (0x8001) to know what all
>> > > extended hypercalls are supported by hypervisor.
>> > >
>> > > A userspace VMM can query capability KVM_CAP_HYPERV_EXT_CALL_QUERY to
>> > > know which extended hypercalls are supported in KVM. After which the
>> > > userspace will enable capabilities for the guest VM.
>> > >
>> > > HvExtCallQueryCapabilities (0x8001) is handled by KVM in kernel,
>> >
>> > Does this really need to be handle by KVM?  I assume this is a rare operation,
>> > e.g. done once during guest boot, so performance shouldn't be a concern.  To
>> > avoid breaking existing userspace, KVM can forward HV_EXT_CALL_GET_BOOT_ZEROED_MEMORY
>> > to userspace if and only if HV_ENABLE_EXTENDED_HYPERCALLS is enabled in CPUID,
>> > but otherwise KVM can let userspace deal with the "is this enabled" check.
>> 
>> There are 4 more extended hypercalls mentioned in TLFS but there is no
>> detail about them in the document. From the linux source code one of
>> the hypercall HvExtCallMemoryHeatHint (0x8003) is a repetitive call.
>> In the file drivers/hv/hv_balloon.c
>>           status = hv_do_rep_hypercall(HV_EXT_CALL_MEMORY_HEAT_HINT,
>> nents, 0,  hint, NULL);
>> 
>> This makes me a little bit wary that these hypercalls or any future
>> hypercalls can have high calling frequency by Windows guest. Also, it
>> is not clear which calls can or cannot be satisfied by userspace
>> alone.
>
> If future support needs to be moved into KVM, e.g. for performance reasons, then
> we can do that if necessary.  
>
>> So, I am not sure if the default exit to userspace for all of the
>> extended hypercalls will be future proof, therefore, I went with the
>> approach of only selectively exiting to userspace based on hypercall.
>
> But punting on everything _might_ be future proof, whereas the only way that
> selectively exiting ends up being future proof is if no one ever wants to support
> another extended hypercall.

While some 'extended' hypercalls may indeed need to be handled in KVM,
there's no harm done in forwarding all unknown-to-KVM hypercalls to
userspace. The only issue I envision is how would userspace discover
which extended hypercalls are supported by KVM in case it (userspace) is
responsible for handling HvExtCallQueryCapabilities call which returns
the list of supported hypercalls. E.g. in case we decide to implement
HvExtCallMemoryHeatHint in KVM, how are we going to communicate this to
userspace?

Normally, VMM discovers the availability of Hyper-V features through
KVM_GET_SUPPORTED_HV_CPUID but extended hypercalls are not listed in
CPUID. This can be always be solved by adding new KVM CAPs of
course. Alternatively, we can add a single
"KVM_CAP_HYPERV_EXT_CALL_QUERY" which will just return the list of
extended hypercalls supported by KVM (which Vipin's patch adds anyway to
*set* the list instead).

TL;DR: handling HvExtCallQueryCapabilities and all unknown-to-kvm (now:
all) extended hypercalls in userspace sounds like the right approach.

-- 
Vitaly

