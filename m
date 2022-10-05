Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F295F5426
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJEMER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJEMEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7285264AB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 05:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664971452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BlPrrfcGT4CkXDtYZUhRJ8tm3C0EIa49OiJh2AlYYUE=;
        b=hyN6B0sv9uaqgAzV4kjrD00l5nGN30CcBYHQEaM2ENLJ3O7gfhPLlZ48ufqNxY0z35AFuC
        bmR9Bb94bf78Gog4Zkb+uvo78pn2m7JvZH0HkIAKvF/oR2QNtchOVPvPQ+HtbFMOqbCwIb
        eI3hN2LwenuGa0LKS4rGSuCnKrGHijg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-650-eqYy07J5Ml-7oMrvuiaXhg-1; Wed, 05 Oct 2022 08:04:11 -0400
X-MC-Unique: eqYy07J5Ml-7oMrvuiaXhg-1
Received: by mail-qt1-f198.google.com with SMTP id ay22-20020a05622a229600b0035bbb349e79so11191103qtb.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 05:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BlPrrfcGT4CkXDtYZUhRJ8tm3C0EIa49OiJh2AlYYUE=;
        b=4jMmyKok2OQBIlWdP8nAnt/MEwtwA12vNtxUprPMfJ0iO+bMOFD6wAbt9yskXeD1Vo
         QPACsFr0hM/H1NiKh2AvZWnrbjMP2OEU4gacUGuzzQSUHoCQhRglv3oljQjHMFZn1GGP
         4Kx0m4vMNoewqtNHU5ohbYC4kJG07WU+ovry8/KInolP/QtIgyvALwSNYvj/iPmiGayi
         ZLjtNaqSmivVMVJELWHvflSQ/nvnIpfZG4Dli75nt+9n6XEdCd3gqZRhLrPoz+aF7umE
         QFfRXUOdElJOqs08mYfjfonfeudbfdeiYLptnXxx3LumTS6Yna/wIkTQQsJdo4uWsq0L
         Ecxg==
X-Gm-Message-State: ACrzQf16mcn3t6LjLmyeiGRaGwPcB1uUi6e53Urx0PKmC5b+0lMa3X0P
        Xv04znhE0rcytY7XoL96vKQsNXfVl/1A/f67CDjcQfhmBGeW9RcPtwO0ll9dVCna7RzvVADUVzd
        CQ9wiiy7eb6cWk4twrUTMxeiP
X-Received: by 2002:a05:620a:bcc:b0:6ce:c077:acf3 with SMTP id s12-20020a05620a0bcc00b006cec077acf3mr19618716qki.263.1664971451484;
        Wed, 05 Oct 2022 05:04:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4hKMNqZ8bYcjvLp5n2KqUIIJBdLNHxVrMW4wzuvyPidckVVWCZhPsj+BIWR03I5VfGgnaIIg==
X-Received: by 2002:a05:620a:bcc:b0:6ce:c077:acf3 with SMTP id s12-20020a05620a0bcc00b006cec077acf3mr19618692qki.263.1664971451078;
        Wed, 05 Oct 2022 05:04:11 -0700 (PDT)
Received: from [172.20.5.108] (rrcs-66-57-248-11.midsouth.biz.rr.com. [66.57.248.11])
        by smtp.googlemail.com with ESMTPSA id o2-20020ac87c42000000b0035cebb79aaesm15016302qtv.18.2022.10.05.05.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 05:04:10 -0700 (PDT)
Message-ID: <d074cb45-72d3-a4a4-30f9-cfb664bb010a@redhat.com>
Date:   Wed, 5 Oct 2022 14:04:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Finish removing MPX from arch/x86?
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arjan van de Ven <arjan@linux.intel.com>
References: <547a1203-0339-7ad2-9505-eab027046298@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <547a1203-0339-7ad2-9505-eab027046298@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/22 19:34, Dave Hansen wrote:
> We zapped the userspace MPX ABIs and most of its supporting code in here:
> 
> 	45fc24e89b7c ("x86/mpx: remove MPX from arch/x86")
> 
> But, the XSAVE enabling and KVM code were left in place.  This let folks
> at least keep running guests with MPX.
> 
> It's been a couple of years and I don't think I've had a single person
> opine about the loss of MPX.  Intel also followed through and there's no
> MPX to be found on newer CPUs like my "Tiger Lake" 11th Gen Intel(R)
> Core(TM) i7-1165G7.
> 
> Is it time to zap MPX from arch/x86/kvm/?

I agree that the likelihood of anybody complaining about MPX is low but 
Jim is right that the timeline for removing it is unfortunately quite long.

Removing MPX from XFEATURE_MASK_USER_SUPPORTED is possible, though we 
need to add a new XFEATURE_MASK_GUEST_SUPPORTED that includes MPX.  I'll 
take a look.

Also, it's worth noting that MPX lives in the sigcontext ABI because it 
uses the non-compacted format.  Because of that it is not possible to 
remove the structs from include/asm/fpu/types.h, for example.

Paolo

