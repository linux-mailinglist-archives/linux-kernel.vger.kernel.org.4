Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C26D5ED9C6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbiI1KFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbiI1KE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562DE6581C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 03:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664359487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gOXFa4wgpDR84YOIokUYaCRoTVoGsxAct6Mv2/6apw0=;
        b=MrztFzZnuK5Hfz4vE7ziVXpGcZCWw8/Lj2QoxizrtC0oYIv1EQuexbrPsTh0pd2DlRcpu2
        2BsvAsgq2AgTFnMdjA3f6fTC+BDoLARE0kfWiX1LP/g9xuvdPanAtgK6fOqt1Em2adHKQU
        nKl4UnN7l3XJKEwECAhBLMBi/Wv3Mug=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-8-8l8CIXlbMRW2lISFY9seyQ-1; Wed, 28 Sep 2022 06:04:45 -0400
X-MC-Unique: 8l8CIXlbMRW2lISFY9seyQ-1
Received: by mail-ej1-f70.google.com with SMTP id qk10-20020a1709077f8a00b0078297c303afso5304119ejc.20
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 03:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gOXFa4wgpDR84YOIokUYaCRoTVoGsxAct6Mv2/6apw0=;
        b=x+5G/S9L0uIfQiLFp8T1n9Xfj/cXwILy+1AifpQYEtarFWKOOYD74f5ivFdLF+z2u4
         CuPv9QBO9zSafz0+l5bjxIhLCt4Th7SEZwKOTofxKIesxbTX152BwOskJuTG4j8L8Hf8
         S+CD0pkAg5anUYoDGIuHLriRrwI+p72olAOGSpru1nVg12RSgSYkQFJZii7IWd/dROnK
         6o0yBYjI8spwhI0h0UN4YcGvA6ZXal31NksfeD+hyLIaqZdXs+6GenRvmvzDvq3/FaAQ
         bZc5f5pl71ztrYSQT8Q8x2dMGnC64kMkMUPGxWj594wPziXiHeXxA3aH89lZCn5adh1L
         4Nvg==
X-Gm-Message-State: ACrzQf3LcXhR23PvrSxyUiF2HQQOXQc2S13W9Mw9By+k5pQ2XfYWYQJQ
        QwcFIMhu5kDzSbVCBUoBsJt6uKY95kr2Siu3+hvXIlUWKuBFhaH0RfnOc+0XF3rEv2hYY6PZQ8g
        3u5VXYuuEKQXMptgSqHJOS+N6
X-Received: by 2002:aa7:de9a:0:b0:44d:8191:44c5 with SMTP id j26-20020aa7de9a000000b0044d819144c5mr32099913edv.232.1664359483678;
        Wed, 28 Sep 2022 03:04:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4BAseVOKMHhPxZ7uacWftYWh46xROz2vwCahNlnyio8uA8nSfw8yOF7MmbOMepfM7swFjeTQ==
X-Received: by 2002:aa7:de9a:0:b0:44d:8191:44c5 with SMTP id j26-20020aa7de9a000000b0044d819144c5mr32099896edv.232.1664359483459;
        Wed, 28 Sep 2022 03:04:43 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:2f4b:62da:3159:e077? ([2001:b07:6468:f312:2f4b:62da:3159:e077])
        by smtp.googlemail.com with ESMTPSA id 12-20020a170906328c00b007867dcd3f15sm2025740ejw.104.2022.09.28.03.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 03:04:42 -0700 (PDT)
Message-ID: <3fd38a32-863d-36a8-d5b3-3b3f181d0e56@redhat.com>
Date:   Wed, 28 Sep 2022 12:04:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20220926165112.603078-1-pbonzini@redhat.com>
 <YzMt24/14n1BVdnI@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: x86: disable on 32-bit unless CONFIG_BROKEN
In-Reply-To: <YzMt24/14n1BVdnI@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 19:07, Sean Christopherson wrote:
> On Mon, Sep 26, 2022, Paolo Bonzini wrote:
>> 32-bit KVM has extra complications in the code due to:
>>
>> - different ways to write 64-bit values in VMCS
>>
>> - different handling of DS and ES selectors as well as FS/GS bases
>>
>> - lack of CR8 and EFER
>>
>> - lack of XFD
>>
> 
> More for the list:
> 
>    - SVM is effectively restricted to PAE kernels due to NX requirements

True, but I'm not sure how it complicates the code?  Do you mean having 
to kmap/kunmap, and if so are you thinking of making KVM depend on !HIGHMEM?

>> - impossibility of writing 64-bit PTEs atomically
> 
> It's not impossible, just ugly.  KVM could use CMPXCHG8B to do all of the accesses
> for the TDP MMU, including the non-atomic reads and writes.

Ok, rephrased:

==========
Breakage in 32-bit KVM is somewhat rare, but it did happen and
developers themselves found out a few months later.  This means that it
is very unlikely that it has any users.  32-bit processors with
virtualization extensions are a historical curiosity; 32-bit userspace
can only deal with small guests due to limited address space.

Hence, it makes sense to restrict x86 KVM to 64-bit hosts and kernels.
This removes all the conditional code to deal with the above
differences, and it also enables unconditional use of the TDP MMU:
making it work on 32-bit systems would require contortions using
CMPXCHG8B to write 64-bit PTEs atomically, and they are simply not
worth it.
==========

>> The last is the big one, because it prevents from using the TDP MMU
>> unconditionally.
> 
> As above, if the TDP MMU really is the sticking point, that's solvable.

Yeah, but until now the maintainability cost of keeping 32-bit on life 
support was small.  Using CMPXCHG8B in the TDP MMU is possibly worse 
than having two MMUs for the two-dimensional paging case, therefore 
dropping the old x86 direct MMU for me is what tips the balance in favor 
of removal.

(Once David submits his MMU callbacks work, I still want to see if it's 
possible to preserve the "old" x86 direct MMU, for example for use in 
pKVM; however, it would not be in arch/x86/).

Paolo

> The real justification for deprecating 32-bit KVM is that, outside of KVM developers,
> literally no one uses 32-bit KVM.  I.e. any amount of effort that is required to
> continue supporting 32-bit kernels is a complete waste of resources.
> 

