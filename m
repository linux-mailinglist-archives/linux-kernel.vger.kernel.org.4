Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB7B5B6AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiIMJkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbiIMJkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED21B5E577
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663062034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sflp17eJhc6ept2xi0SWY42ep/NMxsC10ShY19t+0CI=;
        b=NTXlxoAmGKSY38GcmE25/ZMym980dZwO7wZ7Ye7Snl0B19FqUJK5re2lN/i80x8weg06Dh
        FrybXpfgPXkaeSZFurX3hICZfYvVBX/mR9aSe3LmrjBDIiNOkaaXP4Q7dM0NmBBbabVyXG
        HxySTxj/3I8zWXU+NMAN8isZ7uoOXtA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-5-t0LIfq7vPlyKqQzeWHE_KA-1; Tue, 13 Sep 2022 05:40:33 -0400
X-MC-Unique: t0LIfq7vPlyKqQzeWHE_KA-1
Received: by mail-wr1-f71.google.com with SMTP id g15-20020adfbc8f000000b0022a4510a491so2731054wrh.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=Sflp17eJhc6ept2xi0SWY42ep/NMxsC10ShY19t+0CI=;
        b=0ChIYObY5+MrFvUwXm22LYbcDDkplQqbzUvGAzfHjeNQE8pHU36eNGV42MeIZJ7ovs
         l66FGo0wTpTOFevD4Hpi+uS5H7qH7xpwr6sxs9y4xsganaML5eAZi7dC2vG27ERCjVGB
         pCYXXiFPml36SXbkyyqvvnNoqz0dTfHkb3bv8JkPXqBhDboZ3Yul4JIqZ/ku7ud3umV3
         Txg2mc3jPrsM9XU+jys3H2WJartb4wA/SkCkmhCdAYeAYN71qzvlQ0JOEw4epDgp5MZz
         6tfV0YMa5saQ3S3IqC3iBuUy5o2m6yXYMw41JPIsRdn/yBUGdImzoCS2DEiR24JuMXye
         pljA==
X-Gm-Message-State: ACgBeo03lt4ODopdH9Z8pLSDSiGcNdjxf2w9BlhI/d5ycFN7YtUEArgL
        g8ro++p5/4hOWYvsKX56zydcKhIDJs30DShuwdGIkqrcrt7VABpil9VG8dLplnKZtcfPWgosxNg
        E7hL+xN/kbPCXMcA9QbjSSV/I+xiQRmJKWXdoJQeQFwCb4pBxmkx6u8Cx6boMpED/QgLE8RX0kW
        8L
X-Received: by 2002:a5d:59a6:0:b0:229:5349:c1f3 with SMTP id p6-20020a5d59a6000000b002295349c1f3mr17462863wrr.515.1663062032379;
        Tue, 13 Sep 2022 02:40:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6jaq2PVrOnPDxfhaVZXkF7NsdnHPt1y/doWApyWr4nm3vxYyALGFoCYAA0dCc/khARcPQvpA==
X-Received: by 2002:a5d:59a6:0:b0:229:5349:c1f3 with SMTP id p6-20020a5d59a6000000b002295349c1f3mr17462837wrr.515.1663062032119;
        Tue, 13 Sep 2022 02:40:32 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id bk12-20020a0560001d8c00b0022762b0e2a2sm10240844wrb.6.2022.09.13.02.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 02:40:31 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kvm/x86: reserve bit
 KVM_HINTS_PHYS_ADDRESS_SIZE_DATA_VALID
In-Reply-To: <YxtTfn+cckhBY+BW@google.com>
References: <20220908114146.473630-1-kraxel@redhat.com>
 <YxoBtD+3sgEEiaFF@google.com>
 <20220909050224.rzlt4x7tjrespw3k@sirius.home.kraxel.org>
 <87tu5grkcm.fsf@redhat.com> <YxtTfn+cckhBY+BW@google.com>
Date:   Tue, 13 Sep 2022 11:40:30 +0200
Message-ID: <87a673r4s1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Sep 09, 2022, Vitaly Kuznetsov wrote:

...

>> While this certainly looks like an overkill here, we could probably add
>> new, VMM-spefific CPUID leaves to KVM, e.g.
>> 
>> 0x4000000A: VMM signature
>> 0x4000000B: VMM features
>> 0x4000000C: VMM quirks
>> ...
>> 
>> this way VMMs (like QEMU) could identify themselves and suggest VMM
>> specific things to guests without KVM's involvement. Just if 'fw_cfg' is
>> not enough)
>
> I don't think KVM needs to get involved in that either.  The de facto hypervisor
> CPUID standard already allows for multiple hypervisors/VMMs to announce themselves
> to the guest, e.g. QEMU could add itself as another VMM using 0x40000100 (shifted
> as necessary to accomodate KVM+Hyper-V).

True, VMM can just use another hypervisor space (+0x100) but we can view
it from a slightly different angle: KVM itself is insufficient to run
VMs, there's always a VMM in the background, we may want to provide a
"standard" for its information meaning guests won't need to search for
VMMs signature[s] but can directly refer to "standardized" leaves. 

(All this is a purely theoretical discussion at this point, we need a
good reason to introduce this first).

-- 
Vitaly

