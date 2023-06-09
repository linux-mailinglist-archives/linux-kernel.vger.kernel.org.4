Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD70729376
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239803AbjFIImR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239457AbjFIIlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939B326B1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686300054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+6nJdB62FLF+2nP1h4AZxI2/pI3OeMCUpuUbKJ7vSgE=;
        b=RaSn/98MIzpt8RClXUablE3W6fgOaulJ6zGgR5sucSPdfWz6sakfyU45CMCit1JgE0aHq0
        WzNq8z/vTwjqZdQp8dwU+P/5lC5bln98ITL4azK4Z7hiF3EDSZJtBmA7DfEvyEBqCAHRTU
        36+C7r3QA9Mm/iQ/Qj46pDNV3zDM8A4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-rGHjR9pvP7KZ2Lppldpwmg-1; Fri, 09 Jun 2023 04:40:53 -0400
X-MC-Unique: rGHjR9pvP7KZ2Lppldpwmg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-977eabfc3ccso187586266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 01:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686300052; x=1688892052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6nJdB62FLF+2nP1h4AZxI2/pI3OeMCUpuUbKJ7vSgE=;
        b=aWdtiVaBteR+crutixaaGQfuU+ryVT+pPZUpOYy3W5XDYf1sOc2uxrpRrZvHKEGkBn
         1mgefNLJpLWYQp0KLLJrZmTYpL8B1dV+SQcLCmgAkyKEjttZS445iM/u3PzlQ3GKo6jT
         Uh+pJPdFKaRYjyfVz4f5j6rs5m/+wwiOn6h3pFYDx7T7MKDX040iu1Se5pUo1L0LCqlr
         oyDl0zdv1+ULltDMy4CsXtslDK1puv2a4BehEE4G731DSOtdaGtTIm2ZYYiKgegQQwJ+
         W+0BVZNLUfwjxmiS7H2wdPrE2+IRhQOsEHgvsFaB2ECRqU6Jd180+N/7laF+g+fbb+A5
         HMRA==
X-Gm-Message-State: AC+VfDwWg/n/ATvkGfvSc9C2Vj1/ekELO/kk/BwXN8uZlmWtp76djh5R
        J/utG+KqFRLQJFKo21/w/rsgZCy7OcIs/F2zDV+7gzJAFm+tICE25t+gHHdFSio/FWdy/u4ePor
        FwqN2uCgCOpxXyEVkKtEO6+WE
X-Received: by 2002:a17:906:d554:b0:96f:ddaa:c30d with SMTP id cr20-20020a170906d55400b0096fddaac30dmr1133503ejc.26.1686300051959;
        Fri, 09 Jun 2023 01:40:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5TLWdvp1ZRjzyOomCP+mpoyZ93sSEjxy9ifuzwx8ipw39JGCWasQ8Qab5xhY4QFUwIZdiPMA==
X-Received: by 2002:a17:906:d554:b0:96f:ddaa:c30d with SMTP id cr20-20020a170906d55400b0096fddaac30dmr1133496ejc.26.1686300051668;
        Fri, 09 Jun 2023 01:40:51 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id p10-20020a17090635ca00b00961277a426dsm973774ejb.205.2023.06.09.01.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 01:40:51 -0700 (PDT)
Message-ID: <7630682d-7734-2699-2405-8b7398f4fe3c@redhat.com>
Date:   Fri, 9 Jun 2023 10:40:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [patch 0/6] Cure kexec() vs. mwait_play_dead() troubles
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Ashok Raj <ashok_raj@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
References: <20230603193439.502645149@linutronix.de>
 <ZH4eNL4Bf7yPItee@google.com> <87pm694jmg.ffs@tglx>
 <ZICuhZHCqSYvR4IO@araj-dh-work> <ZIC/b+AwvH2wIz/o@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ZIC/b+AwvH2wIz/o@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 19:33, Sean Christopherson wrote:
Don't most SMM handlers rendezvous all CPUs?  I.e. won't blocking SMIs 
indefinitely
>>>> potentially cause problems too?
>>>
>>> Not that I'm aware of. If so then this would be a hideous firmware bug
>>> as firmware must be aware of CPUs which hang around in INIT independent
>>> of this.
>>
>> SMM does do the rendezvous of all CPUs, but also has a way to detect the
>> blocked ones, in WFS via some package scoped ubox register. So it knows to
>> skip those. I can find this in internal sources, but they aren't available
>> in the edk2 open reference code. They happen to be documented only in the
>> BWG, which isn't available freely.
> 
> Ah, so putting CPUs into WFS shouldn't result in odd delays.  At least not on
> bare metal.  Hmm, and AFAIK the primary use case for SMM in VMs is for secure
> boot, so taking SMIs after booting and putting CPUs back into WFS should be ok-ish.

VMs do not have things like periodic or watchdog SMIs, they only enter 
SMM in response to IPIs or writes to 0xB1.

The writes to 0xB1 in turn should only happen from UEFI runtime services 
related to the UEFI variable store.  Another possibility could be ACPI 
bytecode from either DSDT or APEI; not implemented yet and very unlikely 
to happen in the future, but not impossible either.

Either way they should not happen before the kexec-ed kernel has brought 
up all CPUs.

Paolo

> Finding a victim to test this in a QEMU VM w/ Secure Boot would be nice to have.

