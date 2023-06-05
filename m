Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213DE722346
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjFEKTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFEKTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DBDF4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 03:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685960329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k2I42yHoa8cBG+5F/vO+XJiYcKmCOnxhW9y167l+rbY=;
        b=G70VAKgPHOcvqqh5JhKGnKW3ZRsZaCy3IdZJAvsfVU480thw/DvvefVQXUXbbwyEOI37GD
        Mekns7PXk7rGkTIUJ+NoOa5QX+k5HPKzVj8y6O3Xah1ZPlmQ9jNXEAlnm5HKJ0O1HMtPxL
        dPwNyzywb3WdTTO/afVe2vtw0W4WSu4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-WADH_BswPJKKhMuheDUdpA-1; Mon, 05 Jun 2023 06:18:48 -0400
X-MC-Unique: WADH_BswPJKKhMuheDUdpA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-977eabfc3ccso43736366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 03:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685960327; x=1688552327;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k2I42yHoa8cBG+5F/vO+XJiYcKmCOnxhW9y167l+rbY=;
        b=T/GIm6QvWroBvoMh1zxKxhDMnVOXbUnRcf+BCAysinV5luQaKzKIaB9PFyy96sZ8Kl
         2yB9uZKJYlciVQYHov/6WdZcIkbaxhqPOn9BuAE23K9KGUKAdJLb7mzWGBwV2N/SUeC+
         nUZwj5wjX1PeUacRJWe4litIpUUEUrRBMayFgo5vMjl9uCjzvTmbqFyCB0sOLd2u66Im
         dQLBBIBn2dhb+1wB6USOE8F+P51NA1N6NuIqbnKuDGdtsxfhWO2UxaXIDAjGuUmCvFXa
         KpMGj9YUbBSv3Ni518o7y/koUyUs5i/N37fy9glzYNg4tojE/8ve8LXqUzAtSHOVm1X1
         yBxQ==
X-Gm-Message-State: AC+VfDx3f1wBcAxZmI8vTi7v6A06XC2H8rpVDOl3tt8GcmSfPOGysr18
        OEKneEAeG4W3aRTjsJx05sardLlfoZZlrW/dyxsvRH5nj20TpGELUZGULx2SVxIO3q+a5c2vMbl
        oCCRteJaZ0alWe9nyZczGLxUW
X-Received: by 2002:a17:906:58d2:b0:974:5a12:546 with SMTP id e18-20020a17090658d200b009745a120546mr5892870ejs.23.1685960327178;
        Mon, 05 Jun 2023 03:18:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4y5FTZMdHhj+OpYwDLDbO7vzaJvoyV4RaoadpCqeL/iBSSvEhdT6Qn1T/bEdAIbL9INizO6w==
X-Received: by 2002:a17:906:58d2:b0:974:5a12:546 with SMTP id e18-20020a17090658d200b009745a120546mr5892862ejs.23.1685960326938;
        Mon, 05 Jun 2023 03:18:46 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id y11-20020a17090629cb00b009660e775691sm4063967eje.151.2023.06.05.03.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 03:18:46 -0700 (PDT)
Message-ID: <e013dd26-40e5-0da7-8648-83fd9906b207@redhat.com>
Date:   Mon, 5 Jun 2023 12:18:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v12 01/31] LoongArch: KVM: Add kvm related header files
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>,
        Tianrui Zhao <zhaotianrui@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn,
        Xi Ruoyao <xry111@xry111.site>
References: <20230530015223.147755-1-zhaotianrui@loongson.cn>
 <20230530015223.147755-2-zhaotianrui@loongson.cn>
 <CAAhV-H6B9M3iN7ugR9hFVxSpDHMgD=biZJbsArx_Uncgk3OHcg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAAhV-H6B9M3iN7ugR9hFVxSpDHMgD=biZJbsArx_Uncgk3OHcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/23 07:00, Huacai Chen wrote:
> I found something like this in our internal repo.
> 
> #define KVM_CAP_LOONGARCH_FPU 228
> #define KVM_CAP_LOONGARCH_LSX 229
> #define KVM_CAP_LOONGARCH_VZ 230
> #define KVM_LOONGARCH_GET_VCPU_STATE    _IOR(KVMIO,   0xd0, struct
> kvm_loongarch_vcpu_state)
> #define KVM_LOONGARCH_SET_VCPU_STATE    _IOW(KVMIO,   0xd1, struct
> kvm_loongarch_vcpu_state)
> #define KVM_LOONGARCH_GET_CPUCFG           _IOR(KVMIO,   0xd2, struct
> kvm_cpucfg)
> #define KVM_LOONGARCH_GET_IOCSR              _IOR(KVMIO,   0xd3,
> struct kvm_iocsr_entry)
> #define KVM_LOONGARCH_SET_IOCSR              _IOW(KVMIO,   0xd4,
> struct kvm_iocsr_entry)
> #define KVM_LOONGARCH_SET_CPUCFG           _IOR(KVMIO,   0xd5, struct
> kvm_cpucfg)
> 
> These are all UAPI definitions, if they are needed (at present or in
> future), they should be merged in the first wave of KVM.

No, dead definitions should never be mergd.

Paolo

