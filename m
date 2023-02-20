Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7527169D419
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjBTTaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjBTTaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:30:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF3AEB43
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676921350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oNEQIMEKzUu2uav8P64r69zff0c8FcvklSUxsToQk9c=;
        b=e77ZJV9FkCOiAnwPpLiJbrfbLW/cddWqUubqAJOYjJVIMUyFx+PilcAD0skH+LFv0f8uDx
        GQWm2te3btMz9eTb9yRwD4WuuOOLcAmvW8BdPRKrDcaZ0ah8x4oWFmGBSug3pMfhXe+xS5
        dO1JNex5PzPGppD4ujvOB3yKgL6vZOY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-RQpjCvtkPfmrNhl_BEUMvQ-1; Mon, 20 Feb 2023 13:50:12 -0500
X-MC-Unique: RQpjCvtkPfmrNhl_BEUMvQ-1
Received: by mail-ed1-f69.google.com with SMTP id r6-20020aa7c146000000b004acd97105ffso2891692edp.19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNEQIMEKzUu2uav8P64r69zff0c8FcvklSUxsToQk9c=;
        b=2EWsoSXEN3Mc/ZO1JmthATEO6jBgGNc1GRJp8tI/iQjmAXOztKGYVkxB25+SPtbM4i
         h3pGHmioP/KUacAFVYouQyi2VQ/yKJJuUjiJ3DU5UpP9IQFkmV1gSZ9MZb2I2y5VQ+BF
         tDQ2TUI7DUQ81HXqUaXKwAz9Xl6opj19HNrasJmoZ561z0WDGArkMR9TbvgRBabXyDla
         eSayuhisS5CzFrj6Yy1G2xXF5PAGX+PSDlXE0NyVFdXJjmo4356nLVEr4ENn7PdC9IoD
         HGwBmRAcrPxyLsZ09KH9yHV/Bau36ilb2ZbU54MNmcy7IFelKd3pce+9lkuWIGBYR1he
         oTmA==
X-Gm-Message-State: AO0yUKXvfMQKsK8OUUy+MSD8cJ9exdXEs4h0ZJpiwPljMjUnIhdfNmsP
        upVP/2XWCikn5hJ0OO6i7e0r1HxdJYbSwk2T0BL6sK4WTRps7yhfFBKdzzRv971Dkfca/jgInyt
        cGyv9yx34i3iDP8RwzEYpSyU5
X-Received: by 2002:a17:906:2413:b0:86c:a3ed:1442 with SMTP id z19-20020a170906241300b0086ca3ed1442mr8756811eja.4.1676919011914;
        Mon, 20 Feb 2023 10:50:11 -0800 (PST)
X-Google-Smtp-Source: AK7set/xFOW7y3n8LAi7Lq4oM1pBvG3AfNA2jHHJRrTVLW3aX4k0F1SjGK9u/iFMGDvuf2vLJ5sZqg==
X-Received: by 2002:a17:906:2413:b0:86c:a3ed:1442 with SMTP id z19-20020a170906241300b0086ca3ed1442mr8756797eja.4.1676919011664;
        Mon, 20 Feb 2023 10:50:11 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:4783:a68:c1ee:15c5? ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
        by smtp.googlemail.com with ESMTPSA id fq30-20020a1709069d9e00b008ce5b426d77sm2194511ejc.13.2023.02.20.10.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 10:50:11 -0800 (PST)
Message-ID: <918d0522-56ac-49c3-6604-f44a58ddc645@redhat.com>
Date:   Mon, 20 Feb 2023 19:50:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 13/29] LoongArch: KVM: Implement misc vcpu related
 interfaces
Content-Language: en-US
To:     Tianrui Zhao <zhaotianrui@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn
References: <20230220065735.1282809-1-zhaotianrui@loongson.cn>
 <20230220065735.1282809-14-zhaotianrui@loongson.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230220065735.1282809-14-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/23 07:57, Tianrui Zhao wrote:
> +
> +int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
> +				  struct kvm_translation *tr)
> +{
> +	return 0;
> +}
> +

Please return -EINVAL instead.

Paolo

