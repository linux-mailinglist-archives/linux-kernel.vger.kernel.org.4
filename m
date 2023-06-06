Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF5F724837
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbjFFPuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbjFFPuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E510D2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686066561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sHW62n9UHGko3VJYRUlg4WSO9igiZ1RT0fE8QaKfMYc=;
        b=VN8iDBjW6Xxr98AEHGnj+vD0sj/AlOtD00aUhK7KKdi8RxXS+L+fVAVwMuDAkk6U3wy8d/
        6LUlt7wasvGRMyJ2yENo3g8NIeYTiAWwQ0dzK6CX+S7ntQE56OeVWUude4yVg7hxdZWrJp
        ula0Er0IoK/SX9txMjX6diP6HQeX7pE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-DpaFSkLzOJq4ZWeCjTCjRw-1; Tue, 06 Jun 2023 11:49:20 -0400
X-MC-Unique: DpaFSkLzOJq4ZWeCjTCjRw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6262e6c3b44so68650566d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 08:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686066560; x=1688658560;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHW62n9UHGko3VJYRUlg4WSO9igiZ1RT0fE8QaKfMYc=;
        b=fyPun3EzLnzSAALcTb0yipFAqllTfioJYBmYcOZLpk9fiq0BoTVXBbQiuquctwq523
         V8lWwdmJCjpc1IDK+mENgbEZsQ5w5ZmlnrKzi3c2+wjTrJ1QWfd46ZsiufiHOmIH25BM
         hQtaPA04MUKyOEEvmDahMolca/CZKXIWHS/LFd6ckwGHHksb5v/O5WWs2tAWPO6YPydF
         gjAR2faPHMu4kFmEsw0Yp+G5599qLWj4ImLrgiDHOjKpwl/DCKbfu5v3Ajj7o/VGryYH
         KvQuda+TBcOSNILqkRzsv9VTFEDqpZBc7smEZPa+Di+GWcxSApbs8ZRnf3uD/yLn2YZu
         Fi6Q==
X-Gm-Message-State: AC+VfDwuwjfoc+QON0IYbytVnR2pQxB8A3G1WL3lYo8yAtgxCbrlsCx/
        jEs/sOn9IP3zCCqET7ppzJHmFOmsFUIC41aSTN5+PJVVTIFIVVrirK590VUSiMyY3+s2tGDsqST
        DJm86dNhfPjqMpQ+Y7CQHUhqX+MH6CuhT9xbYiRw1IE9Bmm48PB4riiWqIBDdk7psKIrVaW4sQ0
        h0xvaznKMI
X-Received: by 2002:a05:6214:c4a:b0:623:9218:58e5 with SMTP id r10-20020a0562140c4a00b00623921858e5mr3046802qvj.39.1686066559997;
        Tue, 06 Jun 2023 08:49:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ50JQIIoil5JiSTdmsb+6pApFtKxP9ntyQPRWklH9ZkQzBpZua8a7/GwPPddH+uoWxcHSKrVQ==
X-Received: by 2002:a05:6214:c4a:b0:623:9218:58e5 with SMTP id r10-20020a0562140c4a00b00623921858e5mr3046767qvj.39.1686066559718;
        Tue, 06 Jun 2023 08:49:19 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id u5-20020a0cc485000000b006263c531f61sm5428989qvi.24.2023.06.06.08.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 08:49:19 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] x86/hyperv: Mark Hyper-V vp assist page unencrypted
 in SEV-SNP enlightened guest
In-Reply-To: <4103a70f-cc09-a966-3efa-5ab9273f5c55@gmail.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-4-ltykernel@gmail.com> <873536ksye.fsf@redhat.com>
 <4103a70f-cc09-a966-3efa-5ab9273f5c55@gmail.com>
Date:   Tue, 06 Jun 2023 17:49:15 +0200
Message-ID: <87o7lsk2v8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tianyu Lan <ltykernel@gmail.com> writes:

> On 6/5/2023 8:13 PM, Vitaly Kuznetsov wrote:
>>> @@ -113,6 +114,11 @@ static int hv_cpu_init(unsigned int cpu)
>>>   
>>>   	}
>>>   	if (!WARN_ON(!(*hvp))) {
>>> +		if (hv_isolation_type_en_snp()) {
>>> +			WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
>>> +			memset(*hvp, 0, PAGE_SIZE);
>>> +		}
>> Why do we need to set the page as decrypted here and not when we
>> allocate the page (a few lines above)?
>
> If Linux root partition boots in the SEV-SNP guest, the page still needs 
> to be decrypted.
>

I'd suggest we add a flag to indicate that VP assist page was actually
set (on the first invocation of hv_cpu_init() for guest partitions and
all invocations for root partition) and only call
set_memory_decrypted()/memset() then: that would both help with the
potential issue with KVM using enlightened vmcs and avoid the unneeded
hypercall.

-- 
Vitaly

