Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD10620B92
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 09:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbiKHIxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 03:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiKHIxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:53:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0107C2E69E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 00:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667897568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RKuZuuCI3q1K/HAD0IraHvmgBZQfdPy2jKFzjPsKHLQ=;
        b=PbAV/nsQYNlOgKCOTa+7l3+MxDr52SGnVzXAO28ZISmpl/lQEByPligXroMNLFOK9vZOT9
        QEu+TllH23kUJr3ro8fVaNus5XLJA1R+Y270FB+wlK+0fjcJx4Xc/9ind805QAHO7oG9j7
        S/3ZlYA0fTYQm6yhiYQ+dfG4/UWqAJk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-163-Rpz48Fb2OwayaBUvVT5Pog-1; Tue, 08 Nov 2022 03:52:46 -0500
X-MC-Unique: Rpz48Fb2OwayaBUvVT5Pog-1
Received: by mail-wm1-f69.google.com with SMTP id m34-20020a05600c3b2200b003cf549cb32bso9610998wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 00:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKuZuuCI3q1K/HAD0IraHvmgBZQfdPy2jKFzjPsKHLQ=;
        b=SejKP2N5QN5+/uUllAbpLeLVJPrezOOAYRFsvuXd7FXNN6HLf9Yx7/eu+Y4swMUByO
         6fBkDEZV2lwF3ChZzhmLyLTzg98rzBjySL/fO2AaORT2mtcMDROzOzKuNBKkH3rTmmzG
         nFprj5Yu6xrJoHyWMYvdsa0hMbhlS9Ab0BocQBzzwuoH1m++8Z5zzkCd/Qjy/BjXkgI0
         gCvbd2ThpLYAIOqadzOVNGDoosNf6nGLU6rxWlXQ9DKItrnBalbmoIjxs+VxZY/A8oQi
         pDSYIOkR43XRmf0Kwo0RFDC1qPIH4NUftK5zexk/qrjOoVTCIrOExSvKAMgs9C+IQZ7b
         BbVg==
X-Gm-Message-State: ACrzQf3VFSmrFff6fLSEynomxopnqLVCxBdcOORyGlVsZOhCRr6CqOqX
        bYhFGKxQYc0CLtJZMKbl1+efQGrIGhviDn790VMw20TEZoUQ8OySwhme5KVkM+p1MDj6Ynz0gUc
        o1ReAeUhbUdT/8FLhCkcFTSGT
X-Received: by 2002:adf:d1ec:0:b0:236:880f:2adf with SMTP id g12-20020adfd1ec000000b00236880f2adfmr34973830wrd.617.1667897565468;
        Tue, 08 Nov 2022 00:52:45 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7Td3mYckln2lF/t1NuVY8SNErV7PoyhpXFlmaTgJp4otL4qyQGKPyguMnBStkFyC35OBmmZw==
X-Received: by 2002:adf:d1ec:0:b0:236:880f:2adf with SMTP id g12-20020adfd1ec000000b00236880f2adfmr34973813wrd.617.1667897565248;
        Tue, 08 Nov 2022 00:52:45 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:e3ec:5559:7c5c:1928? ([2001:b07:6468:f312:e3ec:5559:7c5c:1928])
        by smtp.googlemail.com with ESMTPSA id bq21-20020a5d5a15000000b00231ed902a4esm9931077wrb.5.2022.11.08.00.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 00:52:44 -0800 (PST)
Message-ID: <b9debf81-1489-6379-4377-e987f604bf96@redhat.com>
Date:   Tue, 8 Nov 2022 09:52:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/8] KVM: SVM: extract VMCB accessors to a new file
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        nathan@kernel.org, thomas.lendacky@amd.com,
        andrew.cooper3@citrix.com, peterz@infradead.org,
        jmattson@google.com, stable@vger.kernel.org
References: <20221107145436.276079-1-pbonzini@redhat.com>
 <20221107145436.276079-2-pbonzini@redhat.com> <Y2k7o8i/qhBm9bpC@google.com>
 <3ca5e8b6-c786-2f15-8f81-fd6353c43692@redhat.com>
 <Y2lLFEt3tQBoZTDe@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y2lLFEt3tQBoZTDe@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 19:14, Sean Christopherson wrote:
> On Mon, Nov 07, 2022, Paolo Bonzini wrote:
>> On 11/7/22 18:08, Sean Christopherson wrote:
>>> What about making KVM self-sufficient?
>>
>> You mean having a different asm-offsets.h file just for arch/x86/kvm/?
> 
> Yeah.

Doh, it would have been enough to add #ifdef COMPILE_OFFSETS to 
svm/svm.h, but it was also pretty easy to generate a separate 
asm-offsets file so why not.

Paolo

