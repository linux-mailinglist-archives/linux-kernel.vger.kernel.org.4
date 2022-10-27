Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B6B60FB18
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiJ0PDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbiJ0PDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:03:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6076B18DD5D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666882996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJvDBKztTqHWH2ECApC5EZ1MlW+Ts28acLI3gKMXC7E=;
        b=Gw6x5i97k31BuyT/jXNtTaUhR9arzIa2RJtxgNI8Ozlso0bOyfJgvwYJHdeRHx9u5oGO/D
        ETu+beV/AYlcnxacbywatgRGxVGD4dvTE5QcXmxcIFpUluBCVP4fGYZcDlKqc6eYTlh1Zk
        haC7XrDFVdmeiMIJycGSQKW1UZ3ZOKE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-41-LThIo0fAOZy3b9uncnnR0w-1; Thu, 27 Oct 2022 11:03:13 -0400
X-MC-Unique: LThIo0fAOZy3b9uncnnR0w-1
Received: by mail-wm1-f69.google.com with SMTP id h8-20020a1c2108000000b003cf550bfc8dso695289wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJvDBKztTqHWH2ECApC5EZ1MlW+Ts28acLI3gKMXC7E=;
        b=Yy+WZz0qrPx0Pod+c+Jyz9BwjbPtSbCGgWHvxuMzBdYjLJC/hRcvMsnuEJwd2gdWmD
         /yx/UE9qHYNjGFUrkXOXSNOiwldBDWbLTYozVkHRBKbaYz9ghhUi1EJLkTKTpRK/gomA
         ynKayTr6K9Z3fqTpur9JMQrZ8WR+GTeIbrKtFdoodon4JeuI2ELwjqhSRtfN2OLMm+6G
         LrYPpsRRcvZjxdv101yELkOZTbM5d3HfrGvNWCuESCiFpSiMy/TQKGH9crQFSrOPIRbC
         M0thlKHSpTFZQwtQu0xfUL2H8WSk2NrD6vc7cN4qMF4GtHMR3auR2f68fPYgIavgXa8L
         lKEw==
X-Gm-Message-State: ACrzQf2ppuPQlPHefMl5vPNctiOnymiUZ01qEejAtiuG3CeGr3yTYjT7
        mKgQgMykqbYudYpGIaLBampcpIeWQLSw0eTErnlgAsIMDCJuo9ygMGWhg5tHfh+LBIHsbxhEfE8
        BSKejcD9JQP5sf+UDn7dM+UjK
X-Received: by 2002:a1c:f20f:0:b0:3be:eff3:bda2 with SMTP id s15-20020a1cf20f000000b003beeff3bda2mr6127376wmc.125.1666882991490;
        Thu, 27 Oct 2022 08:03:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4nVlOa+R+hUdc5WaG70oHT5KXVZtqksEvvPR8qBPnvxOulKaZTOuDjihr0t9y1sc8P/ozZsQ==
X-Received: by 2002:a1c:f20f:0:b0:3be:eff3:bda2 with SMTP id s15-20020a1cf20f000000b003beeff3bda2mr6127347wmc.125.1666882991217;
        Thu, 27 Oct 2022 08:03:11 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id y16-20020adfd090000000b0022ae401e9e0sm1285436wrh.78.2022.10.27.08.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 08:03:10 -0700 (PDT)
Message-ID: <24768aa3-0e2e-6d29-2749-9d74a26f9205@redhat.com>
Date:   Thu, 27 Oct 2022 17:03:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 03/16] KVM: x86: Always use non-compat
 vcpu_runstate_info size for gfn=>pfn cache
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>,
        David Woodhouse <dwmw2@infradead.org>
References: <20221013211234.1318131-1-seanjc@google.com>
 <20221013211234.1318131-4-seanjc@google.com>
 <afad5f40-03ef-1380-9bfe-03bbaaed47a9@redhat.com>
 <Y1qZagwM0dMBjYhe@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y1qZagwM0dMBjYhe@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 16:44, Sean Christopherson wrote:
>> - long mode cannot be changed after the shared info page is enabled (which
>> makes sense because the shared info page also has a compat version)
> 
> How is this not introducing an additional restriction?  This seems way more
> onerous than what is effectively a revert.
>
>> - the caches must be activated after the shared info page (which enforces
>> that the vCPU attributes are set after the VM attributes)
>>
>> This is technically a userspace API break, but nobody is really using this
>> API outside Amazon so...  Patches coming after I finish testing.
> 
> It's not just userspace break, it affects the guest ABI as well.

Yes, I was talking of the VMM here; additional restrictions are fine there.

The guests however should be compatible with Xen, so you also need to 
re-activate the cache after the hypercall page is written, but that's 
two lines of code.

Paolo

