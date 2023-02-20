Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948FD69D2B7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 19:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjBTSXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 13:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjBTSXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 13:23:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4426D20548
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676917336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/gpJAHMzCGZDzd5ahHH1dkmWAXlvJ43+tMHBJHsRtPc=;
        b=RDuH9IUusqNQ3Hk8GUAYnian4eMOFc54Y1nuTBg72+k2SNdWYeLzhNCTCnvQLwkEtH5G2o
        NEU/Adj9QC4brq0FrOCeOswUDx3VJaQYpIxTAxsq3TRkZ0oTNuDEKe/dSpIgyRIuU8G0lA
        cegm5myXqWBiRzLD6gytBSq69l175jo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-670-Kfkv8jl1N3yVSvMV_ISPog-1; Mon, 20 Feb 2023 13:22:15 -0500
X-MC-Unique: Kfkv8jl1N3yVSvMV_ISPog-1
Received: by mail-ed1-f70.google.com with SMTP id cf11-20020a0564020b8b00b0049ec3a108beso2469640edb.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gpJAHMzCGZDzd5ahHH1dkmWAXlvJ43+tMHBJHsRtPc=;
        b=EMb4v7ulPtpyclVesPmh0DVktb8ILyoMVjUhKez+F1SRODx5RH6RJnTAG+DkWwf3Os
         gOMUd71xcKGh70WY6PHSvsQtC94T4JBmcPGXYSitK5PRntoy1n3mHTd/pLcACc5jhXae
         bzr7mI8VhoWQDagzUgjDXmnZDfsjqi8ma0iM0hixR5u9VfFwXszdtVSpgOdrH/oitJ1Y
         D/AiytvzG9x2dxOo2j/9d/8rdRd1VvFjecyZcJb4fkeNk0Z/skcW/9P7kxbrk1DJsS7B
         FrBBWbgR3cXD2S/bEtqWleSao9mumV0Ls2aOfP7C4keQOT15sqeEJUTriU0rOvSZrb/r
         919Q==
X-Gm-Message-State: AO0yUKU4qjP8E6EsZkbWHPbYgRg0Fp+HOcR/Qf6z/o8JvDTfs2ktEZTp
        BoRBpGBCu34pGHc+X0mcrFvBS/2ZkwM96QDyifNbGWyl+IDk/EVuFSR8IHXkMTekTZzmOhijfdz
        ZJmE7oht81lflS5r+rwp842FQBwq4BQ==
X-Received: by 2002:aa7:cace:0:b0:4ad:7abe:f41a with SMTP id l14-20020aa7cace000000b004ad7abef41amr1229474edt.25.1676917333721;
        Mon, 20 Feb 2023 10:22:13 -0800 (PST)
X-Google-Smtp-Source: AK7set+4CVGpOiWcW9kTs3XQyKjwDB5XGYxKs1Buak8GTZGSmZIwhKKOoqXKiHsWLcJdCkgfgPMdUA==
X-Received: by 2002:aa7:cace:0:b0:4ad:7abe:f41a with SMTP id l14-20020aa7cace000000b004ad7abef41amr1229456edt.25.1676917333441;
        Mon, 20 Feb 2023 10:22:13 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:4783:a68:c1ee:15c5? ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
        by smtp.googlemail.com with ESMTPSA id y36-20020a50bb27000000b004ac54d4da22sm6572247ede.71.2023.02.20.10.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 10:22:12 -0800 (PST)
Message-ID: <2b047b75-7397-0cce-e7af-ebba67ae2561@redhat.com>
Date:   Mon, 20 Feb 2023 19:22:11 +0100
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
 <20230220065735.1282809-2-zhaotianrui@loongson.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 01/29] LoongArch: KVM: Add kvm related header files
In-Reply-To: <20230220065735.1282809-2-zhaotianrui@loongson.cn>
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
> +/* Resume Flags */
> +#define RESUME_FLAG_DR		(1<<0)	/* Reload guest nonvolatile state? */
> +#define RESUME_FLAG_HOST	(1<<1)	/* Resume host? */
> +
> +#define RESUME_GUEST		0
> +#define RESUME_GUEST_DR		RESUME_FLAG_DR
> +#define RESUME_HOST		RESUME_FLAG_HOST
> +

Most of this code is dead, I'll give more instructions in a reply to 
patch 8.

> +	unsigned long guest_eentry;
> +	unsigned long host_eentry;
> +	int (*vcpu_run)(struct kvm_run *run, struct kvm_vcpu *vcpu);
> +	int (*handle_exit)(struct kvm_run *run, struct kvm_vcpu *vcpu);
> +
> +	/* Host registers preserved across guest mode execution */
> +	unsigned long host_stack;
> +	unsigned long host_gp;
> +	unsigned long host_pgd;
> +	unsigned long host_pgdhi;
> +	unsigned long host_entryhi;
> +
> +	/* Host CSR registers used when handling exits from guest */
> +	unsigned long badv;
> +	unsigned long host_estat;
> +	unsigned long badi;
> +	unsigned long host_ecfg;
> +	unsigned long host_percpu;
> +
> +	/* GPRS */
> +	unsigned long gprs[32];
> +	unsigned long pc;
> +
> +	/* FPU State */
> +	struct loongarch_fpu fpu FPU_ALIGN;
> +	/* Which auxiliary state is loaded (KVM_LOONGARCH_AUX_*) */
> +	unsigned int aux_inuse;
> +
> +	/* CSR State */
> +	struct loongarch_csrs *csr;
> +
> +	/* GPR used as IO source/target */
> +	u32 io_gpr;
> +
> +	struct hrtimer swtimer;
> +	/* Count timer control KVM register */
> +	u32 count_ctl;
> +
> +	/* Bitmask of exceptions that are pending */
> +	unsigned long irq_pending;
> +	/* Bitmask of pending exceptions to be cleared */
> +	unsigned long irq_clear;
> +
> +	/* Cache some mmu pages needed inside spinlock regions */
> +	struct kvm_mmu_memory_cache mmu_page_cache;
> +
> +	/* vcpu's vpid is different on each host cpu in an smp system */
> +	u64 vpid[NR_CPUS];

In _kvm_check_vmid(), you already have

+	if (migrated || (ver != old)) {
+		_kvm_update_vpid(vcpu, cpu);
+		trace_kvm_vpid_change(vcpu, vcpu->arch.vpid[cpu]);
+	}

so a vpid will never be recycled if a vCPU migrates from physical CPU A 
to B and back to A.

So please keep the current VPID in the per-cpu struct vmcs, and you can 
just copy it from there in _kvm_check_vmid().

> +	/* Period of stable timer tick in ns */
> +	u64 timer_period;
> +	/* Frequency of stable timer in Hz */
> +	u64 timer_mhz;
> +	/* Stable bias from the raw time */
> +	u64 timer_bias;
> +	/* Dynamic nanosecond bias (multiple of timer_period) to avoid overflow */
> +	s64 timer_dyn_bias;
> +	/* Save ktime */
> +	ktime_t stable_ktime_saved;
> +
> +	u64 core_ext_ioisr[4];
> +
> +	/* Last CPU the VCPU state was loaded on */
> +	int last_sched_cpu;
> +	/* Last CPU the VCPU actually executed guest code on */
> +	int last_exec_cpu;
> +
> +	u8 fpu_enabled;

This field is always true, please remove it.

> +	struct kvm_guest_debug_arch guest_debug;

This struct is empty, please remove it.

Paolo

