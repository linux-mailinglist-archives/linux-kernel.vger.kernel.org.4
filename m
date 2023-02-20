Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFFD69D251
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjBTRri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjBTRrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:47:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C061EFD7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676915202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hWZIjcrYwrJWS0SnFQ4J1tbY58nVFYJ+Qq2znZbe+pI=;
        b=BwZ/HBcW/n0leTXpuflT4SAgPUQnT4eA8cd2Qw/6qqk7HBR5/LQIMCn8vP8b/82ScPa+Di
        fVgdhjVBdEUrh30fda2p1NsAraPdRQYMVD5Wl8cghGjeZcssloR1lTkZcOfPtUBbolC912
        CfsJoZR1FLDXl4LtOEOygQ2cOD6tOQw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-7n8U-z1lPzaYAXm62ZS_2A-1; Mon, 20 Feb 2023 12:46:41 -0500
X-MC-Unique: 7n8U-z1lPzaYAXm62ZS_2A-1
Received: by mail-ed1-f69.google.com with SMTP id ee6-20020a056402290600b004ad51f8fc36so2257435edb.22
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWZIjcrYwrJWS0SnFQ4J1tbY58nVFYJ+Qq2znZbe+pI=;
        b=OJjGaazyWE+12Nn3C3pxVeQWGEbgzH/9JyS8FGfUDMdQpvoFN8FpBRPNDP01+aHMmw
         KR57cBuaCv1x3VGvNaGdxEq4mzwfdxkOqkbJkt73jqKgfq3+7K1gS4PbYj3IgBEbZu8X
         m87tytZiC0QXm48lvSOgGq+BiHyI4L/3ST1Yl5TNLi8mPLYIcTfd98CVIu0xPo7aQ964
         ODo74b8szQk8Ac8T4aWfq4neOqmdo9HKssxsdwdpBm2PT7caJl7q38bzaOLkVRlzcslP
         70o/GhlGmzvJLG7876y3pxdF5nGM3ATvkwjGb0SYhD2PZdFuBiQvRkhKMKdjMAMUl6pP
         uYDQ==
X-Gm-Message-State: AO0yUKVplG/Rk+rwfIHr5hAfD22c3I3Q9SIr1EoHdMQz+0aUHSyr1ziG
        bHeECmyR9yRZGTZJHsDus0n3Q98IDN+vpOiL9Twb1HA0mEBrKH4wXrcEl8PAT+REUMxBiYZjOXP
        69C+FcJLYb/p99oVVXMynRTXG
X-Received: by 2002:a17:906:c55:b0:8b1:7dea:cc40 with SMTP id t21-20020a1709060c5500b008b17deacc40mr13014042ejf.9.1676915200203;
        Mon, 20 Feb 2023 09:46:40 -0800 (PST)
X-Google-Smtp-Source: AK7set/4M5AqthPWPDaHqd+T/52TERaZwpNY5aFMq33k0a6rEitA+IBF394l4ksyh+KMrx6UqRgCxQ==
X-Received: by 2002:a17:906:c55:b0:8b1:7dea:cc40 with SMTP id t21-20020a1709060c5500b008b17deacc40mr13014024ejf.9.1676915199884;
        Mon, 20 Feb 2023 09:46:39 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:4783:a68:c1ee:15c5? ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
        by smtp.googlemail.com with ESMTPSA id m18-20020a17090607d200b008d044ede804sm1872252ejc.163.2023.02.20.09.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 09:46:39 -0800 (PST)
Message-ID: <4c501e8e-6981-814e-4fec-71a56363711b@redhat.com>
Date:   Mon, 20 Feb 2023 18:46:38 +0100
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
 <20230220065735.1282809-9-zhaotianrui@loongson.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 08/29] LoongArch: KVM: Implement vcpu handle exit
 interface
In-Reply-To: <20230220065735.1282809-9-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/23 07:57, Tianrui Zhao wrote:
> +	if (ret == RESUME_GUEST)
> +		kvm_acquire_timer(vcpu);
> +
> +	if (!(ret & RESUME_HOST)) {
> +		_kvm_deliver_intr(vcpu);
> +		/* Only check for signals if not already exiting to userspace */
> +		if (signal_pending(current)) {
> +			run->exit_reason = KVM_EXIT_INTR;
> +			ret = (-EINTR << 2) | RESUME_HOST;
> +			++vcpu->stat.signal_exits;
> +			trace_kvm_exit(vcpu, KVM_TRACE_EXIT_SIGNAL);
> +		}
> +	}
> +
> +	if (ret == RESUME_GUEST) {
> +		trace_kvm_reenter(vcpu);
> +
> +		/*
> +		 * Make sure the read of VCPU requests in vcpu_reenter()
> +		 * callback is not reordered ahead of the write to vcpu->mode,
> +		 * or we could miss a TLB flush request while the requester sees
> +		 * the VCPU as outside of guest mode and not needing an IPI.
> +		 */
> +		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
> +
> +		cpu = smp_processor_id();
> +		_kvm_check_requests(vcpu, cpu);
> +		_kvm_check_vmid(vcpu, cpu);
> +		vcpu->arch.host_eentry = csr_read64(LOONGARCH_CSR_EENTRY);
> +
> +		/*
> +		 * If FPU are enabled (i.e. the guest's FPU context
> +		 * is live), restore FCSR0.
> +		 */
> +		if (_kvm_guest_has_fpu(&vcpu->arch) &&
> +			read_csr_euen() & (CSR_EUEN_FPEN)) {
> +			kvm_restore_fcsr(&vcpu->arch.fpu);
> +		}
> +	}

Please avoid copying code from arch/mips/kvm since it's already pretty ugly.

