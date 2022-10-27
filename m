Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF20960FD67
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbiJ0QtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiJ0QtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:49:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2644618F911
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666889353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SBR+zNlTAG21dDioM5sgF6nCCLjPvKzLkAHg4n7ta1Q=;
        b=WiQ+eTb8304LY2NZvSgNH2D1Pmh5r/Xd6NT487D8g9aRe54/6fKnqh6XHxfP8C/7DBo+PC
        yvnV4PIdkhVAN44wqfEYyCbA30mBIPgt5kHsIwFw26fv6MGF9Gg2W4yKEfYwUVz1/3qgfs
        N8X6eTujuBM8pf4OVmN5TbXHj1q6fgM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-556-l0OPBXYIMlKwkGdY8kWAIQ-1; Thu, 27 Oct 2022 12:49:11 -0400
X-MC-Unique: l0OPBXYIMlKwkGdY8kWAIQ-1
Received: by mail-wm1-f71.google.com with SMTP id bg25-20020a05600c3c9900b003cf3ed7e27bso951351wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBR+zNlTAG21dDioM5sgF6nCCLjPvKzLkAHg4n7ta1Q=;
        b=sBH0bQAwHUozp4RGANN6xEtJN/BYi92sn+aO1jv4ywOf2DjdECUMt1QmRJUKJvoGzZ
         tON3d5IxhIJI4aklS9/fgWlhPBDDS3/VEjtf3UHDPRkpmc42HahpwpEiA/bOC7RUBePN
         rt2qgSjbyGrpBV6hPHRsGIP38kHfJ3XjVYKEG/xzeT8F75VrF8v5KrjIT7hlOE/8G3ES
         7PxcfLB3a/QQF/KGQWvxf1FBKV35SInnE+0SBuLALwzqEN4t/g/P4DadAIhC0uN3Db+j
         MCLpj8GS3CyDTVq8tct/FxSLLk0wu1AvrcSGK7JPtKlg5olTzSbj1WxjGO5VHof1lANW
         A2YA==
X-Gm-Message-State: ACrzQf1nxreKYHpjcCTGG6QPpI3Oxojn8aVSVEmfx22gI4CJkchgSWLY
        j3tN7NKoz+96Dglg/ukqFWqIVKq8qjVf7RB2274uGKlxuy4m8Q3KkpX4peyajXgr4/g7Ba8/V67
        VlxnoHgjQVU2Y/QJJ3BREJ9uD
X-Received: by 2002:a05:6000:10a:b0:236:6a79:f5cf with SMTP id o10-20020a056000010a00b002366a79f5cfmr15965887wrx.470.1666889350571;
        Thu, 27 Oct 2022 09:49:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Y6At6prTJyixBcdRFchUGzanWYZ2mDWqXwbRXFsEFagdyFpLO8S2LxyUFFO7cp89cHZAQDw==
X-Received: by 2002:a05:6000:10a:b0:236:6a79:f5cf with SMTP id o10-20020a056000010a00b002366a79f5cfmr15965875wrx.470.1666889350283;
        Thu, 27 Oct 2022 09:49:10 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id z17-20020a1c4c11000000b003b3365b38f9sm1937795wmf.10.2022.10.27.09.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 09:49:09 -0700 (PDT)
Message-ID: <0e3a0cab-1093-3e83-9e9c-f8639ebe5da0@redhat.com>
Date:   Thu, 27 Oct 2022 18:49:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RESEND v4 00/23] SMM emulation and interrupt shadow fixes
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
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221025124741.228045-1-mlevitsk@redhat.com>
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
> This patch series is a result of long debug work to find out why
> sometimes guests with win11 secure boot
> were failing during boot.
> 
> During writing a unit test I found another bug, turns out
> that on rsm emulation, if the rsm instruction was done in real
> or 32 bit mode, KVM would truncate the restored RIP to 32 bit.
> 
> I also refactored the way we write SMRAM so it is easier
> now to understand what is going on.
> 
> The main bug in this series which I fixed is that we
> allowed #SMI to happen during the STI interrupt shadow,
> and we did nothing to both reset it on #SMI handler
> entry and restore it on RSM.

I have now sent out the final/new version of the first 8 patches and 
will review these tomorrow.  Thanks for your patience. :)

Paolo

