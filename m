Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E8B69D2E0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 19:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjBTSlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 13:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjBTSlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 13:41:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407CA2194B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676918429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F3F8Gw7wQ/aD89+huyNtH63/PjWUgmmQE0UEbpOsSXw=;
        b=KIO4dSnsLwOR5Lh/g/9r/fG6OopE2JahMOvif53LF2GthwqnrT53WswQVciploFb9LdcTX
        PYJAhjrOX+zqVlOISHJ/0xgNvJItSoR0zCse4h5soifpX/EZYv+0gdPpHTcaVD+8WIXnQJ
        8RXHcv/86Qi6pq8QMyId3FaVvffTvuQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-KAAAt79FMCeQmRFCOGNpfw-1; Mon, 20 Feb 2023 13:40:27 -0500
X-MC-Unique: KAAAt79FMCeQmRFCOGNpfw-1
Received: by mail-ed1-f71.google.com with SMTP id r6-20020aa7c146000000b004acd97105ffso2870013edp.19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3F8Gw7wQ/aD89+huyNtH63/PjWUgmmQE0UEbpOsSXw=;
        b=wDGnmIWia3Z7fBojR3rO7y1b/WEnqWf5j4oVmW9eTuqMM3f2bHXQdw3SBsF/0IgbWe
         RjlUvcbGdJAA3YfzVO5BM/JjZhxibpg/rGw0uxLFqptzi2q2lXAfU7Wn1bnWhtA3RSen
         21+q+pN3s+KzSG5RpK2JJUm3eNyydOb87tMhPlgrJ60gtLYANKVAX2hJcmtHk2DVGS/8
         mdVByPxdJV5t5l6zs22DsIXt4HsZ1EKx6JvoMXVg2TkbJmhYhCMGlxo8qLQyPVPHWgli
         O3BYebvt/p3Ait9+emaYyFBadF/hfU29sQJ/7mNIhUDGYsSxRHwqurueBgH5+DAKiL1W
         wRiw==
X-Gm-Message-State: AO0yUKU2/K7emKYFrPMTk0Ul+whQ9JBnBS3ZOxmTttbovXyLdufyyGaA
        9HpjdZUA07TrOKQbpCvBS9g87Z7x5MLC+4WxBqRDQ6m3PCPajgpphEPx0UbVXjy1xvWmKCEcnI5
        UkmKYDUZlprcgvtlwCX2e+HmJ
X-Received: by 2002:a17:906:4096:b0:8b1:238b:80ac with SMTP id u22-20020a170906409600b008b1238b80acmr10072768ejj.67.1676918426579;
        Mon, 20 Feb 2023 10:40:26 -0800 (PST)
X-Google-Smtp-Source: AK7set8vaeadSh+WEZgFopd44iTWJVbIBlfL8Loa4pmELIDekvoYycXElcxoWwuFXC46zuNXn+On2Q==
X-Received: by 2002:a17:906:4096:b0:8b1:238b:80ac with SMTP id u22-20020a170906409600b008b1238b80acmr10072757ejj.67.1676918426322;
        Mon, 20 Feb 2023 10:40:26 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:4783:a68:c1ee:15c5? ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
        by smtp.googlemail.com with ESMTPSA id i10-20020a170906a28a00b008bda61ff999sm3554090ejz.130.2023.02.20.10.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 10:40:25 -0800 (PST)
Message-ID: <06d61407-00b9-812c-e5b3-de585c47ae6b@redhat.com>
Date:   Mon, 20 Feb 2023 19:40:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 22/29] LoongArch: KVM: Implement handle idle exception
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
 <20230220065735.1282809-23-zhaotianrui@loongson.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230220065735.1282809-23-zhaotianrui@loongson.cn>
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
> +int _kvm_emu_idle(struct kvm_vcpu *vcpu)
> +{
> +	++vcpu->stat.idle_exits;
> +	trace_kvm_exit(vcpu, KVM_TRACE_EXIT_IDLE);

Please add a separate tracepoint, don't overload trace_kvm_exit().

Likewise for _kvm_trap_handle_gspr().

I think _kvm_trap_handle_gspr() should have a tracepoint whose parameter 
is inst.word.

Paolo

> +	if (!vcpu->arch.irq_pending) {
> +		kvm_save_timer(vcpu);
> +		kvm_vcpu_block(vcpu);
> +	}
> +
> +	return EMULATE_DONE;

