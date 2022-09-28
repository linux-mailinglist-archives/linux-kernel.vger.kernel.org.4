Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC825EE2EA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiI1RSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbiI1RSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:18:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECBCCEB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664385512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/r6KCKf1vxWod/Dk6IGZU/aQVyTqynzb69MIGT/niI=;
        b=Soq+qQv94hjXcPonQYr/bOXTlKjC9/1Fus/1+iKmBMfpUJ2UIkyNoKy1DBq4tFRVqWZ5RU
        Lgib3mFKEzG2zRDDmH6u2WdC+TnntPXWgNTesIiLMfEgxvlqW9TMm5MRSk2PMN7w5knLgV
        hedj1JSX8B5kqvwQw4uB0RG3n0ExuiQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-0dMFG0vnNjGmS5rELwguNA-1; Wed, 28 Sep 2022 13:18:31 -0400
X-MC-Unique: 0dMFG0vnNjGmS5rELwguNA-1
Received: by mail-ej1-f70.google.com with SMTP id xh12-20020a170906da8c00b007413144e87fso5807376ejb.14
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=X/r6KCKf1vxWod/Dk6IGZU/aQVyTqynzb69MIGT/niI=;
        b=M0qDlH+QV5LvfnAYvFP3S8N4ugCcAZBDpc0ZHFz6//67Jd/pkXhQVGylIMTb5VQRyE
         tTJSPvlDxnuA97gUJUspJqRUnaI39V8LiXGoGEjDD1QvdBMPiL4kdxHzZBXx/Cb9rwZx
         +aYrxIPgbvlJ9AWzr2cuMqdU8M9xqgkln/ZU8NwYbImsu5/5+70MAOmoyCQtu/CyQHwD
         U6+eAKClbYRFSf2CbCstjeAmNhhnPesakLNUj/k2E6hrroE8fyzin7sbk9kGe20Ch0Kv
         bx10QvOyV5hduPPNA45c6Kr5eKn8nOVQ7e6Y4bHnROy2dMijRscDSDyuCR3oAyzOVOmR
         7TSA==
X-Gm-Message-State: ACrzQf2cZ3Wprfu9AuXZ6ZzoH2+9E2GqLG185gzVj3TQw6+s+z4XZSWT
        iYnwVL2B5n9P4vuyDcF4wlfEumJsSQnufy7des16BCoELDb9f8NxpYqrxfTpZ3nGve5v2vvgJZS
        LC6XAsp7iuyFIufM1QZfDXMfc
X-Received: by 2002:a17:907:a067:b0:77b:9672:3f83 with SMTP id ia7-20020a170907a06700b0077b96723f83mr27719524ejc.523.1664385509625;
        Wed, 28 Sep 2022 10:18:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4y+VtC+3fkqh3nOfD54Thq7KzED4MZaOBS96HS+eMi4AX7iODHQvWUOeCZ783oe015OIfXuA==
X-Received: by 2002:a17:907:a067:b0:77b:9672:3f83 with SMTP id ia7-20020a170907a06700b0077b96723f83mr27719507ejc.523.1664385509419;
        Wed, 28 Sep 2022 10:18:29 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:2f4b:62da:3159:e077? ([2001:b07:6468:f312:2f4b:62da:3159:e077])
        by smtp.googlemail.com with ESMTPSA id m5-20020a1709062ac500b00773dbdd8205sm2644031eje.168.2022.09.28.10.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:18:28 -0700 (PDT)
Message-ID: <3e457190-8ebc-2234-5a14-79cab89b393f@redhat.com>
Date:   Wed, 28 Sep 2022 19:18:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC PATCH 7/9] kvm_main.c: duplicate invalid memslot also in
 inactive list
Content-Language: en-US
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20220909104506.738478-1-eesposit@redhat.com>
 <20220909104506.738478-8-eesposit@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220909104506.738478-8-eesposit@redhat.com>
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

On 9/9/22 12:45, Emanuele Giuseppe Esposito wrote:
>   	/*
> -	 * if change is DELETE or MOVE, invalid is in active memslots
> -	 * and old in inactive, so replace old with new.
> +	 * if change is DELETE or MOVE, invalid is in both active and inactive
> +	 * memslot list. This means that we don't need old anymore, and
> +	 * we should replace invalid with new.
>   	 */
> -	kvm_replace_memslot(kvm, batch->old, batch->new);
> +	if (batch->change == KVM_MR_DELETE || batch->change == KVM_MR_MOVE)
> +		kvm_replace_memslot(kvm, batch->invalid, batch->new);
> +	else
> +		kvm_replace_memslot(kvm, batch->old, batch->new);

This is also

	kvm_replace_memslot(kvm, batch->invalid ?: batch->old,
			    batch->new);

with no need to look at batch->change.

Paolo

