Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6CD5B32DE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiIIJEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiIIJDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:03:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874C412D57E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662714174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zHlfqI7LQSp6dc3XrEoWZiHy1ZdcT/Lw/HJNhlYjtFw=;
        b=ioCiNdqlUSS65YCPVwGQBdpEtCEmcoUzdm8b2GWNrciVBoCMw0edXhiZtIWKm+sD5K7O8I
        VJUmZrHCdWVcPYecA4cfGIqImNBwcc2IrXP1KFGPIYb9N9VZs2mbvVRE2kD8kh9VUMjOMg
        L3wUj0lrlnrgm3iTv4fMFb2hw3ST5LQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-674-xZJOrCIWPfSkkeP0CuuJng-1; Fri, 09 Sep 2022 05:02:52 -0400
X-MC-Unique: xZJOrCIWPfSkkeP0CuuJng-1
Received: by mail-wm1-f70.google.com with SMTP id j36-20020a05600c1c2400b003a540d88677so552915wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=zHlfqI7LQSp6dc3XrEoWZiHy1ZdcT/Lw/HJNhlYjtFw=;
        b=nNeOmTb8O/5mDOhk0SknjJ/XRm0adDcS5z3btrfAkzl+yRvasGiqKXnjlRKVGkfrDy
         UCeLrWQeCtPfgTP31TBNTeZfH2f9ONKBP0068mR3tVFwYtYir0wSUTLYaimbitEVCyyr
         mq02yxcVmZuuyv9Dj3EG7HD4e3AWF7wG79Vp4qsHK8KkYxuPOV0ns18zE1zYKtRyCjh+
         20rBRaKT0UDxwiKPP71CYUl5GVXYU/mH9M2cpl1ONkagP2MHQtBGkRqBdVj+e56+OA7l
         MtJIlQjSJJcyiLfjvlY4cinSwhc56ASm5LODau4EH71sY8X+KWTdkgpC+b6VOzHw90oi
         cLWQ==
X-Gm-Message-State: ACgBeo1Lefn9wKPTwNnPVukBFnRto30hOGI/QORPnvNp/cFZoJ7CbRiB
        KIiyEAbyc/1bpPEpBG7i4bXhz1bAngKyIbsN1QIDerQNezG23IwjKkIycHLrkjykHOBqXLy9K/E
        VcjxWVzOhcAO2irffeWEpjAzHrxaoQMq9g66wgGB8UfCsJFb31S0G0DYYNUEQBzqk9+LVDoTedl
        Z6
X-Received: by 2002:a05:600c:1e8b:b0:3a6:1a09:2a89 with SMTP id be11-20020a05600c1e8b00b003a61a092a89mr4659872wmb.108.1662714171728;
        Fri, 09 Sep 2022 02:02:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6p9MuPIBZn8UKjqDTf9uyJYHHhrKQv3ZTZrBd8BwMOJwSJMGJhhalRpYBGvX1ife4LilKxRg==
X-Received: by 2002:a05:600c:1e8b:b0:3a6:1a09:2a89 with SMTP id be11-20020a05600c1e8b00b003a61a092a89mr4659836wmb.108.1662714171378;
        Fri, 09 Sep 2022 02:02:51 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id bo21-20020a056000069500b00225239d9265sm1315860wrb.74.2022.09.09.02.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 02:02:50 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
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
In-Reply-To: <20220909050224.rzlt4x7tjrespw3k@sirius.home.kraxel.org>
References: <20220908114146.473630-1-kraxel@redhat.com>
 <YxoBtD+3sgEEiaFF@google.com>
 <20220909050224.rzlt4x7tjrespw3k@sirius.home.kraxel.org>
Date:   Fri, 09 Sep 2022 11:02:49 +0200
Message-ID: <87tu5grkcm.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Hoffmann <kraxel@redhat.com> writes:

> On Thu, Sep 08, 2022 at 02:52:36PM +0000, Sean Christopherson wrote:
>> On Thu, Sep 08, 2022, Gerd Hoffmann wrote:

...

>> >  arch/x86/include/uapi/asm/kvm_para.h | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> > 
>> > diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
>> > index 6e64b27b2c1e..115bb34413cf 100644
>> > --- a/arch/x86/include/uapi/asm/kvm_para.h
>> > +++ b/arch/x86/include/uapi/asm/kvm_para.h
>> > @@ -37,7 +37,8 @@
>> >  #define KVM_FEATURE_HC_MAP_GPA_RANGE	16
>> >  #define KVM_FEATURE_MIGRATION_CONTROL	17
>> >  
>> > -#define KVM_HINTS_REALTIME      0
>> > +#define KVM_HINTS_REALTIME                      0
>> > +#define KVM_HINTS_PHYS_ADDRESS_SIZE_DATA_VALID  1
>> 
>> Why does KVM need to get involved?  This is purely a userspace problem.
>
> It doesn't.  I only need reserve a hints bit, and the canonical source
> for that happens to live in the kernel.  That's why this patch doesn't
> touch any actual code ;)
>
>> E.g. why not use QEMU's fw_cfg to communicate this information to the
>> guest?
>
> That is indeed the other obvious way to implement this.  Given this
> information will be needed in code paths which already do CPUID queries
> using CPUID to transport that information looked like the better option
> to me.

While this certainly looks like an overkill here, we could probably add
new, VMM-spefific CPUID leaves to KVM, e.g.

0x4000000A: VMM signature
0x4000000B: VMM features
0x4000000C: VMM quirks
...

this way VMMs (like QEMU) could identify themselves and suggest VMM
specific things to guests without KVM's involvement. Just if 'fw_cfg' is
not enough)

-- 
Vitaly

