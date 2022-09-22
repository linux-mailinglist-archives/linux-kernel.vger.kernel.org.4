Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA9D5E6247
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiIVMYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiIVMYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:24:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB9CEA58E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663849449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8e2m2BIJ4Jf3Uy1uaFM/1F4XDeTAJFxAGEpCMvvXt30=;
        b=YkZ438xB/1wRJDzSkCSlCKzezK2jObLqYepnHjXfb9t88a5SO2/OqRunwBZFqZViB37n0A
        ya3AtuT5UrA7Kur0oyy+niGI5FZU5Uv5+zNpU4ahc1C39iAgfqiyWgt+pew3nsSthTcRNT
        uy/flfBIBOKW9ui4OPa8+2YdZuZBn04=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-490-4juCjIGeOy6BJPjFE4Yxjg-1; Thu, 22 Sep 2022 08:24:08 -0400
X-MC-Unique: 4juCjIGeOy6BJPjFE4Yxjg-1
Received: by mail-ej1-f70.google.com with SMTP id sb32-20020a1709076da000b0077faea20701so4390606ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8e2m2BIJ4Jf3Uy1uaFM/1F4XDeTAJFxAGEpCMvvXt30=;
        b=FvZFwFMBK2Ss3xuBuz+fTMRK4qRFgPDP0yorbJ3jS7VYW3pzAk9c7q/iTjEF0mzfiD
         Afa1qCGcplEoO/20iaDvbE/hg0aWOG102R1Ayj4x/cO2D4BZlz0oNvEPsDrL9qjN8T4v
         YRl+LprKB5WqQnP7Kv0TBlWwUXJWlKefLYr0L0j4YcfuRaPHXIWvbcVqYf6UxWROmBT7
         CLjU2s9uci/49yXhRi5L7a4cG1k3mm44bYqMZZcuSdS2TNEkYmODrPSRP3JQtWpdWVFk
         2+dB0Rl67JA05X4rwKDAfzWFXu81pvX0cYBEoM6KSnr74tP/alo9iBd1mKPXQq/Y7y6U
         h2mg==
X-Gm-Message-State: ACrzQf1ogj2kBLy1F/aH0gVZmYJtI/oTZGEa2vcC53A3MdCN/7xXNq3S
        LFQvKTXqHG1jx1zE8PhqCd2WunXw11rYQPFp4DG5XLDLerK9thA+7Kf79Cv0OXXTl+XpKzQ73kr
        aNW/sYVSk/dUEKKQW48wFFz/z
X-Received: by 2002:a17:906:9c83:b0:779:c14c:55e4 with SMTP id fj3-20020a1709069c8300b00779c14c55e4mr2511287ejc.619.1663849446754;
        Thu, 22 Sep 2022 05:24:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4tWYiTyufR0wbEleDRnc2xWoYUYa/ttq8hBl5FeRce4HU7msDjXoA/W9b+dN1gzhhiGgen6w==
X-Received: by 2002:a17:906:9c83:b0:779:c14c:55e4 with SMTP id fj3-20020a1709069c8300b00779c14c55e4mr2511269ejc.619.1663849446511;
        Thu, 22 Sep 2022 05:24:06 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id p16-20020a1709060e9000b007707ec25071sm2491540ejf.220.2022.09.22.05.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 05:24:05 -0700 (PDT)
Message-ID: <2db45546-d504-d006-ce3c-65f832b5a70a@redhat.com>
Date:   Thu, 22 Sep 2022 14:24:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] kvm/x86: reserve bit
 KVM_HINTS_PHYS_ADDRESS_SIZE_DATA_VALID
To:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220908114146.473630-1-kraxel@redhat.com>
 <YxoBtD+3sgEEiaFF@google.com>
 <20220909050224.rzlt4x7tjrespw3k@sirius.home.kraxel.org>
 <20220921134246.xibospqoktp4wjie@sirius.home.kraxel.org>
 <Yysm8/Nkt6EUI5+k@google.com>
 <CALMp9eRkXPPWbPfm16onV9+ondg0x7_RG5ku7hCpBAODLWpSgw@mail.gmail.com>
Content-Language: en-US
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CALMp9eRkXPPWbPfm16onV9+ondg0x7_RG5ku7hCpBAODLWpSgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 18:32, Jim Mattson wrote:
>> The issue is that this "hint" effectively breaks other VMMs that already provide
>> an accurate guest.MAXPHYADDR.
>
> Any VMM that doesn't provide an accurate guest.MAXPHYADDR is broken.
> Why do we need a "hint" that the virtual processor works?

I agree.  Since old (and current) versions of QEMU wouldn't get the bit 
anyway, just fix the next one.  I'll follow up on the QEMU mailing list.

Paolo

