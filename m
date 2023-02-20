Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F84669D250
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjBTRrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjBTRrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:47:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B730206A4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676915181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ck/8YAQ6br4cg4ndwhAICwHSU+oSs0QdaDqjZp8nNfE=;
        b=D8Jilf6to6LqQ5fttr2vt2BOjQDwMzw9V9PqwzjKtsZtgus3F1jU2gnfG8Uot2bCZBTHyj
        9q1PQSxAUgEKb1TBBI2iIXDs/Z/EMWu7oCHkLDMBnuYhzO7iCgMv8w5jTFxVpWT4T+3HId
        llOLE+Z8Dmg99ZGAkGjwrYNthWokbFU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-R_WDnDw1NOizJPOsil654g-1; Mon, 20 Feb 2023 12:46:20 -0500
X-MC-Unique: R_WDnDw1NOizJPOsil654g-1
Received: by mail-ed1-f72.google.com with SMTP id dm14-20020a05640222ce00b0046790cd9082so2856402edb.21
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:46:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ck/8YAQ6br4cg4ndwhAICwHSU+oSs0QdaDqjZp8nNfE=;
        b=ubIAdmUZyZhk6FKhJpKxp3mYUJcZ8RAVN5ihWQ5PZYBaMEf3Gy6BY6+sORwbI8FGKW
         DblcU9C7yJn+hzi7H74vMzavHdrstlmMz5DSrkG2V0PnRWXNdcJCFXqpKyjFsTfythPI
         1EyPadXrA1ugK5vXUk97m2JxtWrTWwoZMow03yaxQS67VHL16+Lu0FxVbCQeU4TeLP4P
         K7bK5ut3EJm0vdkX4saA/0p8HPJq3Ya5gs641luZ/i8nkiPBzz70OlTyr3upjW96ZXZF
         uTj0/lfkdUv/WponoF0DnUeRLu+42Ccbfh8oPlrNIptlKcTEl/c0QtSRoS305fYzQY8C
         sQ2Q==
X-Gm-Message-State: AO0yUKXwvkUP1qy3Hi6/I5PcmILKgIfBPmRMMISxdujURi7dXvto+DaM
        bMA7KRYkYycsgk9/ETFj0iewE5LcD1PC/+g1uQPZvRgVDzEqlInhp7D+8vB/StQFYskxh2FZa2O
        fx6NhuA+9E94bl+QoGGNmYYGk
X-Received: by 2002:a17:907:9714:b0:8b1:7eba:de5 with SMTP id jg20-20020a170907971400b008b17eba0de5mr9354786ejc.10.1676915179027;
        Mon, 20 Feb 2023 09:46:19 -0800 (PST)
X-Google-Smtp-Source: AK7set/Tg+D8jplbtCuUA/KAbL7Qq6RReoePpMuhnouFw3R+uTK3cUHQ5gyse11r3SB4HbH+iQqFqw==
X-Received: by 2002:a17:907:9714:b0:8b1:7eba:de5 with SMTP id jg20-20020a170907971400b008b17eba0de5mr9354767ejc.10.1676915178760;
        Mon, 20 Feb 2023 09:46:18 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:4783:a68:c1ee:15c5? ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
        by smtp.googlemail.com with ESMTPSA id ce6-20020a170906b24600b008b1fc59a22esm4860751ejb.65.2023.02.20.09.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 09:46:18 -0800 (PST)
Message-ID: <bf4111f9-f722-1847-4f1d-964c5356f392@redhat.com>
Date:   Mon, 20 Feb 2023 18:46:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
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
 <20230220065735.1282809-3-zhaotianrui@loongson.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 02/29] LoongArch: KVM: Implement kvm module related
 interface
In-Reply-To: <20230220065735.1282809-3-zhaotianrui@loongson.cn>
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
> +	order = get_order(kvm_vector_size + kvm_enter_guest_size);
> +	addr = (void *)__get_free_pages(GFP_KERNEL, order);
> +	if (!addr) {
> +		free_percpu(vmcs);
> +		return -ENOMEM;
> +	}
> +
> +	memcpy(addr, kvm_vector_entry, kvm_vector_size);
> +	memcpy(addr + kvm_vector_size, kvm_enter_guest, kvm_enter_guest_size);
> +	flush_icache_range((unsigned long)addr, (unsigned long)addr +
> +				kvm_vector_size + kvm_enter_guest_size);
> +
> +	vpid_mask = read_csr_gstat();
> +	vpid_mask = (vpid_mask & CSR_GSTAT_GIDBIT) >> CSR_GSTAT_GIDBIT_SHIFT;
> +	if (vpid_mask)
> +		vpid_mask = GENMASK(vpid_mask - 1, 0);
> +
> +	for_each_possible_cpu(cpu) {
> +		context = per_cpu_ptr(vmcs, cpu);
> +		context->vpid_mask = vpid_mask;
> +		context->vpid_cache = context->vpid_mask + 1;
> +		context->last_vcpu = NULL;
> +		context->kvm_eentry = addr;
> +		context->kvm_enter_guest = addr + kvm_vector_size;
> +		context->page_order = order;
> +	}

A lot of these variables are constant across all pCPUs, any reason to 
have them in a per-CPU variable?  Likewise, since they are all the same 
as the constant global vmcs variable, why make them part of struct 
kvm_context instead of just making them globals?

Also, why does the world switch code need a copy?

Paolo

