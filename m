Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192775EBEAE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiI0Jcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiI0Jct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB643CBD1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664271167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SWzvIWhu2p5oGZsL7YjmEHhgIgzvZ3iiY7FpFO/QMaY=;
        b=bWjfRPj38PcZX9Tw3XfICb0R8sWbDv8NGQjk6sXxGnEdMRVD8HHqP//8c1ODXw2OfBw75P
        tVr+rsFu/+jiwkHs1CPvUmJ59LJlOw4Z0hyl8wrLja/yt9mBRoDAhWuygDJth2TzsphzPp
        dsg3DIhZ3qEBgAdK1Dklvn5/G+dSKfk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-202-kPsBc1PNOI6r9PXcouFtkA-1; Tue, 27 Sep 2022 05:32:46 -0400
X-MC-Unique: kPsBc1PNOI6r9PXcouFtkA-1
Received: by mail-wr1-f71.google.com with SMTP id j16-20020adfa550000000b0022cbdfcea2dso401633wrb.19
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SWzvIWhu2p5oGZsL7YjmEHhgIgzvZ3iiY7FpFO/QMaY=;
        b=k0wVLWLqU0FGxEvhX58Zw2fmMmR3CNSMWSLoTaZUSCn2iaTHjaWXtN7DRwtt9YV6LF
         PspRPZtL8fHUtDOd5GR+A6rp4IvOQTe2ppenSvCpD/zVESfAUhrZJbGaNcRishEAwCXO
         t2plSEGJ820W0BHyJ5HbAJJsLuiX0xiK6Izo93JAyGax6ou6yxad583HYBGQIDUaYyEP
         5RDxjW8qc0Tnzs+4enwQwbDD2GXfh7r3eNG85Y4AI6BjS6gGHSvG70w2sDJNTh5xrIXV
         OLCAyO0FeomB4l4Q3WxtHYRCJguevQk7mjz6onYzbaPDKIjNO9r9f+oqdhhBm5UqBmpD
         Ikhg==
X-Gm-Message-State: ACrzQf1SxMEugHbGN3FtfWxR66hXV3iDilIaAzDzLFRAOajNL90nMUbg
        dLm0OetCoO+JdHNWF/w5FJ8BtFpWVWdxFx7v3/s3i/ptEMuuxL/zExnzfm/B4jCtxO0UWOmtAFs
        Hk2iLc3dFmDNPQPhqlYAQEH0u
X-Received: by 2002:adf:fa83:0:b0:205:c0cb:33c6 with SMTP id h3-20020adffa83000000b00205c0cb33c6mr17004728wrr.39.1664271165244;
        Tue, 27 Sep 2022 02:32:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4565MFwjtigqjrfzQqmtzphrZ6sO+5jsO8tFcq1hCl3Ew+gbKmypG209xqcSaWhBh8bXCIrg==
X-Received: by 2002:adf:fa83:0:b0:205:c0cb:33c6 with SMTP id h3-20020adffa83000000b00205c0cb33c6mr17004711wrr.39.1664271164966;
        Tue, 27 Sep 2022 02:32:44 -0700 (PDT)
Received: from [192.168.149.123] (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b003b47b80cec3sm14617665wmq.42.2022.09.27.02.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 02:32:44 -0700 (PDT)
Message-ID: <81c235cc-1198-9765-d1e7-a158ea63eac4@redhat.com>
Date:   Tue, 27 Sep 2022 11:32:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH 9/9] kvm_main.c: handle atomic memslot update
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20220909104506.738478-1-eesposit@redhat.com>
 <20220909104506.738478-10-eesposit@redhat.com>
 <cde8be9d-64c0-80e5-7663-4302d075dcbc@redhat.com>
 <07014070-5186-ca95-7028-82f77612dedd@redhat.com>
 <a8c40c94-771c-ca3d-ee1d-44cbed2398e8@redhat.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <a8c40c94-771c-ca3d-ee1d-44cbed2398e8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 27/09/2022 um 11:22 schrieb David Hildenbrand:
> On 27.09.22 10:35, Emanuele Giuseppe Esposito wrote:
>>
>>
>> Am 27/09/2022 um 09:46 schrieb David Hildenbrand:
>>> On 09.09.22 12:45, Emanuele Giuseppe Esposito wrote:
>>>> When kvm_vm_ioctl_set_memory_region_list() is invoked, we need
>>>> to make sure that all memslots are updated in the inactive list
>>>> and then swap (preferreably only once) the lists, so that all
>>>> changes are visible immediately.
>>>>
>>>> The only issue is that DELETE and MOVE need to perform 2 swaps:
>>>> firstly replace old memslot with invalid, and then remove invalid.
>>>>
>>>
>>> I'm curious, how would a resize (grow/shrink) or a split be handled?
>>>
>>
>> There are only 4 operations possible in KVM: KVM_MR_{DELETE, MOVE,
>> CREATE, FLAGS_ONLY}.
>>
>> A resize should be implemented in QEMU as DELETE+CREATE.
>>
>> Therefore a resize on memslot X will be implemented as:
>> First pass on the userspace operations:
>>     invalidate memslot X;
>>     swap_memslot_list(); // NOW it is visible to the guest
>>
>> What guest sees: memslot X is invalid, so MMU keeps retrying the page
>> fault
>>
>> Second pass:
>>     create new memslot X
>>     delete old memslot X
> 
> Thanks a lot for the very nice explanation!

Anytime :)

> Does the invalidation already free up memslot metadata (especially the
> rmaps) or will we end up temporarily allocating twice the memslot metadata?
> 

Invalidation creates a new temporary identical memslot, I am not sure
about the rmaps. It is anyways the same code as it was done before and
if I understand correctly, a new slot is required to keep the old
intact, in case something goes wrong and we need to revert.

Thanks,
Emanuele

