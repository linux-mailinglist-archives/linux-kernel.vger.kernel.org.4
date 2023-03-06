Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478346AD027
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 22:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCFV0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 16:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCFV0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 16:26:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC2F41B4E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 13:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678137934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2kPDaMtvAn6Ke+rpaXnpSgonfs3hJrOw/Y58l77EwTQ=;
        b=bEL2otxWyw2qXWbe71HZqW+u8n+ywQr1K2nNxd3OQb8Kb+xEkSlLltnttc5/oQ4QCpejEm
        vfPgHvE9/P8f1MTs3Q/rv8vPnV9ApFU7k3GI7HOK0cwZg4E7PO3eYuotJzlBssbJtU+5M+
        pC1RV6C4tzM9D44e6Y7ghamo4AMZ9i0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-Uwbf3hMAOhKC-9_iXtI4sw-1; Mon, 06 Mar 2023 16:25:33 -0500
X-MC-Unique: Uwbf3hMAOhKC-9_iXtI4sw-1
Received: by mail-ed1-f69.google.com with SMTP id r9-20020a05640251c900b004d4257341c2so10003346edd.19
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 13:25:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678137932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2kPDaMtvAn6Ke+rpaXnpSgonfs3hJrOw/Y58l77EwTQ=;
        b=c/tZ9xLgDW6VyvfY8GBL0ApHU5sPP8mhw6VnjY5pxUKfBlcJdC3F73MXXEyF22ZCJB
         xb16zplKYsnAQVSX4l1eqt0nqOTx5P/bPGVKD8YHkeFOjos2i926pg19m+/0LP3adJB1
         wXVGoZdUZRn3IBfaKa1uxcP7Cy99dMznHoWzI6QqAHCMF9byyRn2CTv3PMDuZfDqxpxS
         ExB5ioknhzxO75rRHph4rojRKQtuHvfWUzPVvKToGuLPqC/3N2lOGNhduNLH9/Qa7Pm+
         gQGVXO7Tv/QUBwSWf2YnfR7S4flvtTWefOHeDN3+JGd2bolOD9zk4aIuMz/fx8vwUCIF
         lR4Q==
X-Gm-Message-State: AO0yUKUUp+7NYrhPG/RzvawyP9dM0Oo3kCnu8qeT26fV9VKwlzZyYKj4
        iISGvkzPr3MGnI5qrGxnJWO7xkz7+HejJCr5fgjafWW9fViGH25T8Jjxwf/Ow57cVv27IA9EeMx
        oLiMvwDHXOobYD7lrgJyqthSF
X-Received: by 2002:a05:6402:6d2:b0:4af:51b6:fe49 with SMTP id n18-20020a05640206d200b004af51b6fe49mr13680144edy.13.1678137932140;
        Mon, 06 Mar 2023 13:25:32 -0800 (PST)
X-Google-Smtp-Source: AK7set8wQfD9t+0vFV281etvV4VvHRK6RFDe078d2lY81cAFFnqsn3dyja3VYsEnRhCRbyrGeeKa0Q==
X-Received: by 2002:a05:6402:6d2:b0:4af:51b6:fe49 with SMTP id n18-20020a05640206d200b004af51b6fe49mr13680126edy.13.1678137931814;
        Mon, 06 Mar 2023 13:25:31 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id o22-20020a509b16000000b004c4eed3fe20sm5700927edi.5.2023.03.06.13.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 13:25:30 -0800 (PST)
Message-ID: <e5bf7da5-df29-31c6-6d33-81bbecb849ba@redhat.com>
Date:   Mon, 6 Mar 2023 22:25:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/2] KVM: x86: Propagate AMD-specific IBRS bits to guests
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Takahiro Itazuri <itazur@amazon.com>, dave.hansen@linux.intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org,
        zulinx86@gmail.com
References: <Y/5oBKi6vjZe83ac@zn.tnic>
 <20230228222416.61484-1-itazur@amazon.com> <Y/6FIeJ5KCOfKEPN@zn.tnic>
 <ZAZYKe4L8jhMG4An@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ZAZYKe4L8jhMG4An@google.com>
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

On 3/6/23 22:16, Sean Christopherson wrote:
>> Not harmless - cpufeatures.h should contain flags which the kernel uses
>> and not*every*  CPUID bit out there.
>
> I thought that the consensus was that adding unused-by-the-kernel flags to
> cpufeatures.h is ok so long as the feature is hidden from /proc/cpuinfo and the
> kernel already dedicates a word to the CPUID leaf?
Yeah, I understand adding no new CPUID leaf just for KVM, but you don't 
gain anything really from not having X86_FEATURE_* defines.

Paolo

