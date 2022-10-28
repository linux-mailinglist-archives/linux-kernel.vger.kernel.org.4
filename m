Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0486112EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJ1Nfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ1Nfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:35:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8A529C97
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666964079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vFqYz8MMVuDJ4sSoQ0v9rsso2qX+yaIQ4KXzcvg1mhc=;
        b=Hl+7v52gNYDyckNRQORtX5ilGYGv/YO/zAiWQnhzjtew1bXUqU8q+6MX00xTb50xfbk+ys
        lweEJr6bLCk2qE5+zM7gUSwUZn4v/fYrGrPNBFretNuVXZvxa8FFkQvn4WJpMAtqGU40ZL
        NPu+OL/u4pqgXrGxbxeYMSOhvVpQ6pk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-191-1EAjn9ycMqCnRgFg41n2Kw-1; Fri, 28 Oct 2022 09:34:36 -0400
X-MC-Unique: 1EAjn9ycMqCnRgFg41n2Kw-1
Received: by mail-wm1-f72.google.com with SMTP id f1-20020a1cc901000000b003cf475763b6so1448718wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFqYz8MMVuDJ4sSoQ0v9rsso2qX+yaIQ4KXzcvg1mhc=;
        b=KBpq1hvl2pMu/Jv9SSMZNcqYWx2zgwg8QkbdHw7GuXwMmMk4fH8MvptllwyRLKRWcj
         PeW2cL1xGkaQWRv9su5jaFpC66pXWKQNjc37nKf9ozetLT9byGzS82HDJZxG8igDXBhp
         JbDCwfXvlGK4QLgYi6S3cre7RO/AU0pz1kPDJKIkzIMxH0ziYZyWMpBpIol62uEKgpon
         rRSFcUI/x8ZRec/mzKcKIo2rwjW/R9cDbUaTK2ub9FSut2vlA6Mj2KKo2aT6rrnLV7Mh
         KIDYaWE0MiDj54pxxxWOCV8tjGdF01KgfF1J94Tx+gN/OjubUKcixpOXC5B6Gjfc1Lbt
         iiCQ==
X-Gm-Message-State: ACrzQf0wq94SrRByksaifOEwtBtwdhqvc86/n+kO0TgDNbX5Ga+yGqa7
        b3vLMoHLsw+ASmydm6pNhQzy8AoJIoKgrPtuiPOpbmBr8KH5VTwmupzLGUSYpqkFRcjpSQJ1dou
        Bvt04IK3ffcxTC9zWNQN9hR0v
X-Received: by 2002:a5d:5142:0:b0:236:5d8d:6254 with SMTP id u2-20020a5d5142000000b002365d8d6254mr22326937wrt.514.1666964075458;
        Fri, 28 Oct 2022 06:34:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4qPWmRdmYeva1c0+81ekf4TqzWM8LrMLcjdZN9VgV4/YuhTz4wVkJR4JMmkiMCMKDREkRZhQ==
X-Received: by 2002:a5d:5142:0:b0:236:5d8d:6254 with SMTP id u2-20020a5d5142000000b002365d8d6254mr22326919wrt.514.1666964075238;
        Fri, 28 Oct 2022 06:34:35 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id m64-20020a1ca343000000b003b49ab8ff53sm4266963wme.8.2022.10.28.06.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 06:34:34 -0700 (PDT)
Message-ID: <c0e342ac-32a3-4f92-65c1-e4c990af7698@redhat.com>
Date:   Fri, 28 Oct 2022 15:34:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RESEND v4 16/23] KVM: x86: smm: add structs for KVM's
 smram layout
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Yang Zhong <yang.zhong@intel.com>, x86@kernel.org,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Shuah Khan <shuah@kernel.org>,
        Guang Zeng <guang.zeng@intel.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Wei Wang <wei.w.wang@intel.com>,
        Borislav Petkov <bp@alien8.de>
References: <20221025124741.228045-1-mlevitsk@redhat.com>
 <20221025124741.228045-17-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221025124741.228045-17-mlevitsk@redhat.com>
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

On 10/25/22 14:47, Maxim Levitsky wrote:
> +	u32 cr4; /* CR4 is not present in Intel/AMD SMRAM image */
> +	u32 reserved3[5];
> +
> +	/*
> +	 * Segment state is not present/documented in the Intel/AMD SMRAM image
> +	 * Instead this area on Intel/AMD contains IO/HLT restart flags.
> +	 */

Both of these are based on the Intel P6 layout at 
https://www.sandpile.org/x86/smm.htm.

Paolo

