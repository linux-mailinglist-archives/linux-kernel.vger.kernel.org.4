Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466AA647EF1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 09:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiLIIIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 03:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiLIIH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 03:07:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B46E5B85F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 00:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670573217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4sxH0I5QtK63vsm8GUs2GfZ9XLUpU5JHWlHlEFhZnIc=;
        b=C505qvlpQUdpJPfIraOKpwAcCM+S/YOlgoDaFdtUyGxTn4lX0UPvlHX6nMKCwiTnpb/eBW
        B/1MRk3Wn36pil/tIEUg2kAZ9h7Jml7Qsdk9YIoBqryfPSzgjmxiO4tXHbEdH19Ob+Ll03
        +divFSPZYFKuuWI598kEuV09FBuyAgU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-619-ivEgFgWYPIqQloQU9LtJlg-1; Fri, 09 Dec 2022 03:06:56 -0500
X-MC-Unique: ivEgFgWYPIqQloQU9LtJlg-1
Received: by mail-ej1-f72.google.com with SMTP id qf25-20020a1709077f1900b0078c02a23da3so2604913ejc.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 00:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sxH0I5QtK63vsm8GUs2GfZ9XLUpU5JHWlHlEFhZnIc=;
        b=sGk4Fqcwt5tc+hAO4/r2NHhhzIN08TRKAp9K+B8J9QPCPQ3VRTavt6LWB4GLCYvGhf
         mb4R7qJJ6dKRnl3dCIan9ME5flTFUh3cyp9guZ0B+jLaO/3sJbcDlC1kgep0uQYHBAID
         xLyoHOjq/RvaiiUoDcr93cJhGdrpl4NJUyGFcrwIZbE5+n1LRFA68hshPPCVaMlqG27d
         Zo40BQQg7bBR3pnyxvxy6euGLMcridkVwWT8Wl6F74oZK9DWwNbfygP83Q2kZtUlSSf4
         /l73/FwX5r6eZWDD/xQ53hZ/780EqNnjBISkCBSw2Ec7mGnkjAI1rJ0eAVQYh19Gho6S
         PEaA==
X-Gm-Message-State: ANoB5plhdUVlIE/e80bsnbgJgcPOUXbNwIZmX75Fy1broDRo+BMXrN9A
        jI735JPa7Qf4WG0QRL/4NrwWNX9uxhODhk3My0BJiAYTQ2cQ4AuyV9ZBAwNhrX7r4qfiWx9Neh0
        cOdVgi9gEDvKOJkjADDmPS9Gg
X-Received: by 2002:a05:6402:294b:b0:461:ca30:653 with SMTP id ed11-20020a056402294b00b00461ca300653mr5783804edb.31.1670573214728;
        Fri, 09 Dec 2022 00:06:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4IWiovX3D2RO3PKxMaf3X1KDdCX7WBEwluagDv4bB4lLaMjPqF5xAXvwkyMTS9DjXMSz6MeA==
X-Received: by 2002:a05:6402:294b:b0:461:ca30:653 with SMTP id ed11-20020a056402294b00b00461ca300653mr5783786edb.31.1670573214464;
        Fri, 09 Dec 2022 00:06:54 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:e3ec:5559:7c5c:1928? ([2001:b07:6468:f312:e3ec:5559:7c5c:1928])
        by smtp.googlemail.com with ESMTPSA id k23-20020a05640212d700b00462bd673453sm332365edx.39.2022.12.09.00.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 00:06:53 -0800 (PST)
Message-ID: <6e316b6a-7a9d-8e53-2c5f-8b71892ec7fd@redhat.com>
Date:   Fri, 9 Dec 2022 09:06:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] KVM: X86: set EXITING_GUEST_MODE as soon as vCPU exits
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Jon Kohler <jon@nutanix.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221129182226.82087-1-jon@nutanix.com>
 <Y4j9u6YEpJ/px6kj@google.com>
 <B9071742-7C64-40F4-8A93-D61DC1FD4CE5@nutanix.com>
 <Y5D1JWutV7+nARxS@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y5D1JWutV7+nARxS@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 21:18, Sean Christopherson wrote:
> 
> And now that kvm-asm-offsets.c exists, I think it makes sense to drop the @regs
> parameter for __vmx_vcpu_run(), e.g. to roughly match __svm_vcpu_run().

Yeah, that I had already here 
(https://lore.kernel.org/kvm/20221028230723.3254250-1-pbonzini@redhat.com/T/#me77cdd848fa86cdce03f59447ddb4f2cba45f79c) 
but then I dropped when it became clear the SVM series was targeting 
6.1.  I planned to resubmit for 6.3 after the holidays.

Paolo

