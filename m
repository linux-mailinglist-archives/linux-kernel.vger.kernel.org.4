Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBFF69DB6C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjBUHqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjBUHql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:46:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1FA1B31E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676965561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fMy5UNnfOflKNYu2v+qdc7M5+Dbw9HBEzHEBe6W2kQU=;
        b=Hz1vTFEKSUYSBuVLxNJC2Lic/2bjMIp5mNU+/8aej5cZ7YNnDvztnktzgEVqoCHv2pOK2f
        eWsjmoK1FIln4fiTHnlmBYwSylPYXsZiruaFfU2zA7s/xIokwAXsfNI+5ndNixZ95aWw50
        s3fRnLE+V0ngzfIqzv3V1yWppuMLu+o=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-479-eKzQv_fYPC-nM00TtxZbEA-1; Tue, 21 Feb 2023 02:45:59 -0500
X-MC-Unique: eKzQv_fYPC-nM00TtxZbEA-1
Received: by mail-ed1-f70.google.com with SMTP id eh16-20020a0564020f9000b004acc4f8aa3fso4764399edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMy5UNnfOflKNYu2v+qdc7M5+Dbw9HBEzHEBe6W2kQU=;
        b=INW1sGmD/YZczgPhJrGipHiDvCbYMYtRldrU5V1254i/ln2RTeDxScJEUGYyH0Wt3Z
         D6Oqy0/6B93NsyxDfAAAj3A7RI/6JMjnvoq1Uqf2K3A8rYlbXNTTdRqgeLqyARf1Dukc
         T2sZJg2weqjJ9rn3kH/+yZfJS/ZtCCltBJ31gfuqTQ5pahdpklaY3Ur0fwny3jun+DRG
         VnJ2pPyTndOFSawcfyDeJ6QakguvVaWIWDnHnnRe1gAvnjkCHW/Z1OU0RSyYp0Q2Bfy8
         EFVRzRVk1n0JGOW00U3uCIFxt8OETcRy8xzB9g7fboJn8RJP5Yy5mnRz0Vf9Gx/D1naW
         VTgQ==
X-Gm-Message-State: AO0yUKU7vQMxVPrQcVMMBgFh5ZyTWn2n1gM0wB2wxfId2cNcsp7ES2jG
        nNW05aY2nPrT+EoTo2QubxhaXqNs1aPNy1NK1TvUwbekQAFkSb+3VQvBFKZY+bWZAApou/+kffO
        DoUpzBPUtrMmZS9u/61YpIbIy
X-Received: by 2002:a17:906:9f25:b0:8b1:4d5f:fb83 with SMTP id fy37-20020a1709069f2500b008b14d5ffb83mr11855606ejc.15.1676965558363;
        Mon, 20 Feb 2023 23:45:58 -0800 (PST)
X-Google-Smtp-Source: AK7set9vghZQIt75cz8byQ+eUxaqXScW0PwKtItzq1+Ju4htLOU5T5BIIbIDPeiHMzCc1djkwXl0yg==
X-Received: by 2002:a17:906:9f25:b0:8b1:4d5f:fb83 with SMTP id fy37-20020a1709069f2500b008b14d5ffb83mr11855591ejc.15.1676965558066;
        Mon, 20 Feb 2023 23:45:58 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id uj9-20020a170907c98900b008deba75e89csm559987ejc.66.2023.02.20.23.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 23:45:57 -0800 (PST)
Message-ID: <50575db8-efb8-2d56-5dd9-fe4318db2af3@redhat.com>
Date:   Tue, 21 Feb 2023 08:45:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 27/29] LoongArch: KVM: Implement vcpu world switch
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
 <20230220065735.1282809-28-zhaotianrui@loongson.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230220065735.1282809-28-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/23 07:57, Tianrui Zhao wrote:
> +	/* Load Guest gprs */
> +	ld.d    $r1,   \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 1)
> +	ld.d    $r2,   \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 2)
> +	ld.d    $r3,   \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 3)
> +	ld.d    $r4,   \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 4)
> +	ld.d    $r5,   \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 5)
> +	ld.d    $r7,   \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 7)
> +	ld.d    $r8,   \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 8)
> +	ld.d    $r9,   \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 9)
> +	ld.d    $r10,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 10)
> +	ld.d    $r11,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 11)
> +	ld.d    $r12,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 12)
> +	ld.d    $r13,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 13)
> +	ld.d    $r14,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 14)
> +	ld.d    $r15,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 15)
> +	ld.d    $r16,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 16)
> +	ld.d    $r17,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 17)
> +	ld.d    $r18,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 18)
> +	ld.d    $r19,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 19)
> +	ld.d    $r20,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 20)
> +	ld.d    $r21,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 21)
> +	ld.d    $r22,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 22)
> +	ld.d    $r23,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 23)
> +	ld.d    $r24,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 24)
> +	ld.d    $r25,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 25)
> +	ld.d    $r26,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 26)
> +	ld.d    $r27,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 27)
> +	ld.d    $r28,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 28)
> +	ld.d    $r29,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 29)
> +	ld.d    $r30,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 30)
> +	ld.d    $r31,  \KVM_ARCH,  (KVM_ARCH_GGPR + 8 * 31)
> +	/* Load KVM_ARCH register */
> +	ld.d	\KVM_ARCH, \KVM_ARCH, (KVM_ARCH_GGPR + 8 * \GPRNUM)

This in practice relies on KVM_ARCH being a2 so please remove the 
KVM_ARCH and GPRNUM arguments from the macro; just replace \KVM_ARCH 
with a2 as needed.

Also, in these ld.d and st.d sequences you may want to use the ABI names 
instead of the rNN names, so it's clearer that you are skipping the 
KVM_ARCH register.

Paolo

