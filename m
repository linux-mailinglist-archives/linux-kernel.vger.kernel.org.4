Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3900A6CC1E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjC1ORu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjC1ORp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:17:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17370D321
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680013016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=McVfL5jdOZS7kfAfgWz7ZBlWLPWSFJhKhjaCyPWzQL0=;
        b=aBsxDkRv4EEYayz+/siLlEAZSr61NKHj0uJsRfCwewpZqYfafQdum1h30BwSzqdtbqWA73
        cXcnW6EGTNakzO1YPM6lF8ppgXwtfkjWFhBSopbG4nJ3BwQvqLGpC/NTODzZKpCDUDG1fJ
        82nMWf8rTUh6yGthapWqBJUczV5BRMY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-6eaAIWmJPVKZky_9or9_Fw-1; Tue, 28 Mar 2023 10:16:43 -0400
X-MC-Unique: 6eaAIWmJPVKZky_9or9_Fw-1
Received: by mail-ed1-f71.google.com with SMTP id m18-20020a50d7d2000000b00501dfd867a4so17886330edj.20
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=McVfL5jdOZS7kfAfgWz7ZBlWLPWSFJhKhjaCyPWzQL0=;
        b=20zn4oJRteNnDKNjSKjyD26nhwChWQmJoXXb9CVXY8IwpooREhmJlVXtgKO9a0SAjv
         JHNQgqP/PhUEyQTsSc6mslEIOv420f5U0kIz5P2RpjJ7EBzB6KQBSCHEuP/jLy4eMCaf
         Eo2TXq1SjGgKSC59C08LUdwhhuLZhzT/bTEOEfrVoaVPk9vGQ2YluHdrZzuXse7/via6
         3yK6h0F12xSTXBr5WNqUjPQvyCQggzFR2Z8BFXGkPREU7cCln+5C7d3iItw+Mml66B6a
         HpAvBKz1NzHwoQ1J2XGCQFbt8PukhVg3PJuvxoVnrESY3rLesTWsY15dMpSw5P/vFVxE
         bz7g==
X-Gm-Message-State: AAQBX9f9Mf8hJNOPcuCxTwCArO+8tvdm72mhExGjZPmm1lB9J1fTwg3V
        vM4mn81xG4iMR5G0wGAPVf73D09HnX1RtA9owlW0O0YuONGZdZ/3FzOKu9IE0AQkMVWTPoFxzF3
        MrfG0eETYyRLetneMy446hnjf
X-Received: by 2002:a17:906:5a43:b0:8aa:be5c:b7c5 with SMTP id my3-20020a1709065a4300b008aabe5cb7c5mr17112819ejc.41.1680012994692;
        Tue, 28 Mar 2023 07:16:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350aoU2aSW/2CIaXWA1zbjboShcLbK5aGfXZD89zPwYbyXrwZeU0E5CjgejUESFiorIvBi+i+dA==
X-Received: by 2002:a17:906:5a43:b0:8aa:be5c:b7c5 with SMTP id my3-20020a1709065a4300b008aabe5cb7c5mr17112786ejc.41.1680012994437;
        Tue, 28 Mar 2023 07:16:34 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id i11-20020a170906264b00b009255b14e91dsm15283127ejc.46.2023.03.28.07.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 07:16:33 -0700 (PDT)
Message-ID: <e142e2ac-2207-2d97-55b6-fb2ed0e9db89@redhat.com>
Date:   Tue, 28 Mar 2023 16:16:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PING PATCH v4 00/29] Add KVM LoongArch support
Content-Language: en-US
To:     Tianrui Zhao <zhaotianrui@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn,
        Xi Ruoyao <xry111@xry111.site>
References: <20230328123119.3649361-1-zhaotianrui@loongson.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230328123119.3649361-1-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/23 14:30, Tianrui Zhao wrote:
> Ping patch series, please help for reviewing the loongarch kvm patch
> set. Thanks very much.
> 
> This series adds KVM LoongArch support. Loongson 3A5000 supports hardware
> assisted virtualization. With cpu virtualization, there are separate
> hw-supported user mode and kernel mode in guest mode. With memory
> virtualization, there are two-level hw mmu table for guest mode and host
> mode. Also there is separate hw cpu timer with consant frequency in
> guest mode, so that vm can migrate between hosts with different freq.
> Currently, we are able to boot LoongArch Linux Guests.
> 
> Few key aspects of KVM LoongArch added by this series are:
> 1. Enable kvm hardware function when kvm module is loaded.
> 2. Implement VM and vcpu related ioctl interface such as vcpu create,
>     vcpu run etc. GET_ONE_REG/SET_ONE_REG ioctl commands are use to
>     get general registers one by one.
> 3. Hardware access about MMU, timer and csr are emulated in kernel.
> 4. Hardwares such as mmio and iocsr device are emulated in user space
>     such as APIC, IPI, pci devices etc.

Please check Documentation/virtual/kvm/api.rst and document the 
loongarch-specific parts of the API, in particular ioctls that have 
architecture-specific semantics (KVM_GET/SET_ONE_REG, KVM_INTERRUPT) and 
vcpu->run fields.

Code-wise what I could understand looked okay, I only made a suggestion 
on the handling of idle; thanks for going through the previous review 
carefully.

Paolo

