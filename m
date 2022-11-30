Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E643463DB70
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiK3REZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiK3RDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:03:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C12900EF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669827541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m9a6wFc0RaDwZ5W3tObwtvd4DevYG79SiLdXsbs2flM=;
        b=RkwMdPiGfWGRRqlZgMWCo/c6EwlhsfI+5qapUN/ED/vT+tou+0fM1VvaDCo+R5F7WOH5sT
        EApABchB7Iry/e+PzqEFA8kh2T/3AMfcTGXvE3+3mZsGHXUNwVcWo1eBsQTbd50VV05iQ2
        6+zFR0YB3brEqvMSLAJzLvLma91aa7I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-88-TOT6T7w0MdWwGxTjMz2j0A-1; Wed, 30 Nov 2022 11:58:59 -0500
X-MC-Unique: TOT6T7w0MdWwGxTjMz2j0A-1
Received: by mail-ed1-f69.google.com with SMTP id f17-20020a056402355100b00466481256f6so10092861edd.19
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:58:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9a6wFc0RaDwZ5W3tObwtvd4DevYG79SiLdXsbs2flM=;
        b=y7Nc0cnUzIvnh3qZnnkIG2FZVqLbEb0VgO3Sp4tqu03FsNA8+/Yj8JRlt0D5Z/eOt6
         BCwV4MebgYS2CNiq00H4s8SYkigXM61SogTATNKJaI9vaUaiHQMDreT/ZQ2J9Bp1uRNe
         HTJ6qsj5tfmQuJG8YqbBHo/QF8JOkIR3069uIkPif4p1uaCkF6Yn28B/gvT+FmXfKWPD
         EgzvgpdqVSNqvLDUNMS9jKTkiBeT/+qelEj6W56zVJ8cWHaq8HnFy2+m9XYfaRBWvEui
         evnxl5Wtes4TPo60U+h/z1Asvx7KR0StH4AIm+4rCOtRuIYUWg5rHZATPIDpLgSmaOfJ
         pSwA==
X-Gm-Message-State: ANoB5pm9QuA80glBxRmJTIumh9RJ010OO8OqT7SSJf+6LraI+icOZOc+
        PcYLvkc4kyUkHi2a5ePEMa05tbgaoBnddgJCuxJpnKYbCR/qhdG5bdnIQZU2XHBmQfmfT9cpDXw
        iKdNaAfEFmJGOrnn/gBHMH7tm
X-Received: by 2002:a17:907:7784:b0:7ad:9ad7:e882 with SMTP id ky4-20020a170907778400b007ad9ad7e882mr39488590ejc.520.1669827537829;
        Wed, 30 Nov 2022 08:58:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf73qL1Jhq523BYbZhmApLx4RduRu+6qDZGDKtgYCMtGXyWkWoUIgRl5EweEwMB+7nAWZtnqqw==
X-Received: by 2002:a17:907:7784:b0:7ad:9ad7:e882 with SMTP id ky4-20020a170907778400b007ad9ad7e882mr39488574ejc.520.1669827537573;
        Wed, 30 Nov 2022 08:58:57 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:4783:a68:c1ee:15c5? ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
        by smtp.googlemail.com with ESMTPSA id gi20-20020a1709070c9400b0077d6f628e14sm847674ejc.83.2022.11.30.08.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 08:58:56 -0800 (PST)
Message-ID: <e43ffb47-6526-6b2d-f7b3-0755f3c54a71@redhat.com>
Date:   Wed, 30 Nov 2022 17:58:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] KVM: Deal with nested sleeps in kvm_vcpu_block()
Content-Language: en-US
To:     Space Meyer <spm@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kpsingh@kernel.org
References: <20221130161946.3254953-1-spm@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221130161946.3254953-1-spm@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/22 17:19, Space Meyer wrote:
>   bool kvm_vcpu_block(struct kvm_vcpu *vcpu)
>   {
> +	DEFINE_WAIT_FUNC(vcpu_block_wait, woken_wake_function);
>   	struct rcuwait *wait = kvm_arch_vcpu_get_wait(vcpu);
>   	bool waited = false;
>   
> @@ -3437,13 +3439,11 @@ bool kvm_vcpu_block(struct kvm_vcpu *vcpu)
>   	preempt_enable();
>   
>   	for (;;) {
> -		set_current_state(TASK_INTERRUPTIBLE);
> -
>   		if (kvm_vcpu_check_block(vcpu) < 0)
>   			break;
>   
>   		waited = true;
> -		schedule();
> +		wait_woken(&vcpu_block_wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
>   	}

Also, this does not work I think, because there is 
add_wait_queue()/remove_wait_queue() pair.  Adding it is not easy 
because KVM is using a struct rcuwait here instead of a wait_queue_t.

Paolo

