Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636C769D267
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjBTRyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBTRyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:54:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15FF195
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676915605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A6m99hVi2S7tt6YKMO1cVTA7Dd38UPq4FNBkdwIRSkw=;
        b=GxfWbySwpPgzGdn/Oqby2az2JVlwp6VLiTc/pl8DfcE6b+JslJrFljIIB3rBtVwq/rKtoU
        sc2GSo064fx0s682Df2TqRMdAV+yMqIStwTBbf/6KSxuQRffeUodm0Br3+4l0Q+fZX8up9
        7R3izTFixqqmJuMZZCJ67687nVE/QNQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-550-4URe3DMSNwmkKI_p7FYSQg-1; Mon, 20 Feb 2023 12:53:24 -0500
X-MC-Unique: 4URe3DMSNwmkKI_p7FYSQg-1
Received: by mail-ed1-f69.google.com with SMTP id ee6-20020a056402290600b004ad51f8fc36so2271692edb.22
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:53:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6m99hVi2S7tt6YKMO1cVTA7Dd38UPq4FNBkdwIRSkw=;
        b=beEMbNwjzGCJmkLYdppOWRJ+peXNgIq3LUhzclxa6vPV16TgxV+nXTW/BDN+g5R7O8
         ovJHIrET+2j3amFjUHQCyPXUejHXF7eDH8rqzg/QxYc2VcWyXh7hUgRj7goIEDXFuRuB
         tuzcGf1Z/QvbtNTuH3rjyPMRL2Mt602izO3Q5Go0m+2hLMvwb6bd2lztuAr3KbVonCN+
         NfKVQtJMW2VOJdPxT6c92xtu6DNWNxfE7/qd2Ms+3/zpopoq4/ogM2ToE3Xb9k6osKnq
         m4vkgCtZx/0iOH2GHXReAGiQbpCKt4xxHuuPi6hty7YZ14Wrtev7AedWqIWUqnYJkzhA
         TIuQ==
X-Gm-Message-State: AO0yUKVxDvzDQDzMcXiJGgdCbaj47YF9WrMj/cpKkihJ66W+9kA6SzoI
        O85IAwOVvGjOa7+JPd/VfY21u/A66oWPQBGBEwhjyJ+Lw2mdJVRTqDlat1iSLGWSm/FD4+dWWBb
        z/2aCf9zc/tcJyXk2ab4ge1or
X-Received: by 2002:a17:906:5587:b0:8ae:707:e129 with SMTP id y7-20020a170906558700b008ae0707e129mr11613418ejp.19.1676915602744;
        Mon, 20 Feb 2023 09:53:22 -0800 (PST)
X-Google-Smtp-Source: AK7set8YUMllxoIfXoPvpKgnxtQVrwTWJX8iE/yV2ZHIe2nb+KwqL6pfZmuCO53IKmK9nVaiNrgo/w==
X-Received: by 2002:a17:906:5587:b0:8ae:707:e129 with SMTP id y7-20020a170906558700b008ae0707e129mr11613400ejp.19.1676915602476;
        Mon, 20 Feb 2023 09:53:22 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:4783:a68:c1ee:15c5? ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
        by smtp.googlemail.com with ESMTPSA id sa14-20020a170906edae00b008b176df2899sm5514793ejb.160.2023.02.20.09.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 09:53:21 -0800 (PST)
Message-ID: <cbd95763-ec38-63f7-89bf-c8b01aa7df77@redhat.com>
Date:   Mon, 20 Feb 2023 18:53:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 06/29] LoongArch: KVM: Implement vcpu create and
 destroy interface
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
 <20230220065735.1282809-7-zhaotianrui@loongson.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230220065735.1282809-7-zhaotianrui@loongson.cn>
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
> +	vcpu->arch.guest_eentry = (unsigned long)kvm_context->kvm_eentry;
> +	vcpu->arch.vcpu_run = kvm_context->kvm_enter_guest;
> +	vcpu->arch.handle_exit = _kvm_handle_exit;

Here as well, whatever is constant must not be stored in struct 
kvm_arch_vcpu.

Paolo

