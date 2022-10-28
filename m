Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AC3610EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJ1KhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiJ1Kgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:36:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156EF196ED8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666953321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AHHc5DYHXDTbroGg4eDNG7KGetgNkKtBzWrn2006T0E=;
        b=FX5TQ6D6mX+PDRVN98VkWMcL7JZO4srIH/XiPq8cPHAAgc3pLEgeUzAbTdWHAKnJQoRLG3
        4CSRfO+xdq9jP8U4lsv1px5qax6XyPDeNyaCdAurQ7vENyhhrIxF+iQtx3z4xBW6ijM5tF
        vMh0M6bzbppMYGAUs3SedP/Kl/NTkMs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-88-FXlzZg7nPq67Vg60eRvp4A-1; Fri, 28 Oct 2022 06:35:19 -0400
X-MC-Unique: FXlzZg7nPq67Vg60eRvp4A-1
Received: by mail-wm1-f69.google.com with SMTP id v23-20020a1cf717000000b003bff630f31aso1308773wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHHc5DYHXDTbroGg4eDNG7KGetgNkKtBzWrn2006T0E=;
        b=4biDqSxe7hBQUlyspWSYlv/FQmSIxX0bBHzhseS5Pu9fUWDP2zkX6m5Jo0sXFhtNfW
         eLZj36k+NNcph4OsoLnXrivCYQJqfH6qEPZCeFj9niO+1HZiYbqeNcKul9RmJvXB6l0l
         +/Sck/+HHwb5f1J5gNNYa7aiBAXAFxRvj1RqXxaAeAAvKTBMYYmIlVE/dKtIwJdeoC9X
         Y4exj9uF62NfE1Wp3mG5c/30++Q1QBMVL3juM4DddcVK2tiRBmkRQ6XQ/G7RQSSwWTOr
         dQcLAN9QAzllqp0mTJh9OrOsiFTaVIqrYvBUA7b/53GZop38fJ/10jKgutUA4XP7bop0
         JTug==
X-Gm-Message-State: ACrzQf3b5JaVl7kCl1852OnpsnqDKIRiu7keH6F97pVXC5OVyuKhMRIX
        KDq0e2UmatJUa0l1J38NpJksA3vcGs6SnnFXegX6fuU1gpGpcg2GoTL/GYIXEKbo2ycl5wwkjqC
        +JRHPGRnUHfxd7qn0Bu9vPNPx
X-Received: by 2002:a5d:62cd:0:b0:236:6ea0:a609 with SMTP id o13-20020a5d62cd000000b002366ea0a609mr16771206wrv.508.1666953318643;
        Fri, 28 Oct 2022 03:35:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6fApbM+YGw2J1Oa0PPkdj7Kvml3S9i9FB/WJLWdDFQlLGFmi2b3HQOlm75URoHDv5Fix/7Ug==
X-Received: by 2002:a5d:62cd:0:b0:236:6ea0:a609 with SMTP id o13-20020a5d62cd000000b002366ea0a609mr16771188wrv.508.1666953318364;
        Fri, 28 Oct 2022 03:35:18 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id i15-20020a05600c354f00b003cdf141f363sm4311927wmq.11.2022.10.28.03.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 03:35:17 -0700 (PDT)
Message-ID: <137568e8-90a6-19e3-1bcb-055ed0c419e7@redhat.com>
Date:   Fri, 28 Oct 2022 12:35:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RESEND v4 23/23] KVM: x86: smm: preserve interrupt shadow
 in SMRAM
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
 <20221025124741.228045-24-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221025124741.228045-24-mlevitsk@redhat.com>
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
> @@ -19,7 +19,8 @@ struct kvm_smram_state_32 {
>   	u32 reserved1[62];
>   	u32 smbase;
>   	u32 smm_revision;
> -	u32 reserved2[5];
> +	u32 reserved2[4];
> +	u32 int_shadow; /* KVM extension */
>   	u32 cr4; /* CR4 is not present in Intel/AMD SMRAM image */
>   	u32 reserved3[5];

Of course the placement of KVM-specific fields is somewhat arbitrary, 
but based on sandpile.org data I would place it at 0xFF1A ("reserved", 
you have to search for 7F1Ah in the web page).

> @@ -86,7 +87,7 @@ struct kvm_smram_state_64 {
>   	u64 io_restart_rsi;
>   	u64 io_restart_rdi;
>   	u32 io_restart_dword;
> -	u32 reserved1;
> +	u32 int_shadow;
>   	u8 io_inst_restart;
>   	u8 auto_hlt_restart;
>   	u8 reserved2[6];

Likewise, based on AMD BKDG I would place this at 0xFECB after the "NMI 
Mask" field (which unfortunately I learnt about only after "inventing" 
HF_SMM_INSIDE_NMI_MASK).

I can do the changes myself, but please ack.

Paolo

