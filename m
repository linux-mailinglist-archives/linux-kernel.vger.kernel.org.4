Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D8569DB4B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjBUHgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbjBUHgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:36:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91384233C6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676964965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GJUhBSU80naNAyt7KCYwVauVvdFPDJ7F9xsF0ak04fU=;
        b=h0hCGKI4GX8EXB11Aq1UIm9dwOL4vxri4CjVha5ALxDTknbML0MRrVHdbxNJ2RGci62p/u
        XVPlwGyKz5VNmg5iqQGeTX5M3VS3bM+TJJPciNZ9BHudK2KlgL2gQx4hrts59NJHXXeuy4
        +eOAawN5hP0g9CcMz2Qjpx7qBJH9Ffg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-477-veNvzddAP-6rbOlWqSXldg-1; Tue, 21 Feb 2023 02:36:04 -0500
X-MC-Unique: veNvzddAP-6rbOlWqSXldg-1
Received: by mail-ed1-f70.google.com with SMTP id ec13-20020a0564020d4d00b004a621e993a8so4452513edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJUhBSU80naNAyt7KCYwVauVvdFPDJ7F9xsF0ak04fU=;
        b=v2IWsXiQKvs52wFJWSso2fD8T3FLYdEF2Nzh6G0Mko2OMjkWUn2ZJMiBgZLUWIbKOF
         tQxI0s7VhJ8MrmrKZWwwbL3Sl8pp+RCYpxRg4dqje/TuIQewdS0Y357FjtOPbZTgUVlY
         bE78JsnBa8uODTaCf2a40YwVsaMY8tNJzr5Wdm3z0SFp2QOwj/8orCqZ5WoOYdM0S3Nn
         nHO+pk3+Lxei3neMOpjgEfOmQmsMIxpgYtYLwHzqdjCzXBKV8YNufGluT5TZCeoc00CJ
         Md3UXx+5rnpwhcP8TTdWm+HS9uNp5WDzgmTiyxaG6QdRqKl/khOb5dlpLwdpM+YqU6f3
         0qFg==
X-Gm-Message-State: AO0yUKVrnKfpSAcZKB4FTDGldCXaVwa4C2N6fr103qxxAee15eEne4fv
        gE9wiyOrhIGgZle/04jJgbkjqot8yOUk7LkmNaCgY86tYBNz+3r1wCcyI28rwb9RZcR/SY142ym
        NiMU8SKNJHRxfWeTyWBeczInu
X-Received: by 2002:a17:906:eca1:b0:87d:eff1:acc8 with SMTP id qh1-20020a170906eca100b0087deff1acc8mr11390836ejb.48.1676964963252;
        Mon, 20 Feb 2023 23:36:03 -0800 (PST)
X-Google-Smtp-Source: AK7set9J1/92GkILe5uy/U98ad25HyMRx/vMAcuPeun433EDTbMLSpuGQJ2VGiRFrZCp9HdNZZQeUw==
X-Received: by 2002:a17:906:eca1:b0:87d:eff1:acc8 with SMTP id qh1-20020a170906eca100b0087deff1acc8mr11390829ejb.48.1676964962981;
        Mon, 20 Feb 2023 23:36:02 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id z10-20020a170906714a00b008ba365e7e59sm4555423ejj.121.2023.02.20.23.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 23:36:02 -0800 (PST)
Message-ID: <87268dce-1b5d-0556-7e65-2a75a7893cd1@redhat.com>
Date:   Tue, 21 Feb 2023 08:35:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 05/29] LoongArch: KVM: Add vcpu related header files
Content-Language: en-US
To:     Xi Ruoyao <xry111@xry111.site>, maobibo <maobibo@loongson.cn>,
        Tianrui Zhao <zhaotianrui@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>
References: <20230220065735.1282809-1-zhaotianrui@loongson.cn>
 <20230220065735.1282809-6-zhaotianrui@loongson.cn>
 <497693ca2cbc443c1d9f796c3aace6c9987bec72.camel@xry111.site>
 <7d6125dd-29e8-14d8-b1d7-d8c14d7bec80@loongson.cn>
 <4cd00b5cdc78da6357d2d326e607b169faee34a8.camel@xry111.site>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <4cd00b5cdc78da6357d2d326e607b169faee34a8.camel@xry111.site>
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

On 2/21/23 08:12, Xi Ruoyao wrote:
>> We are preparing to submit these instruction support for binutils,
>> however it is still necessary. Supposing that it is supported in future
>> gcc version, we can not drop existing gcc 12/13 supporting to compiling
>> kernel with LoongArch architecture.
> You can drop the support for KVM with less capable Binutils versions,
> like:
> 
> config AS_HAS_LVZ
>      def_bool $(as-instr some_gcsr_insn \$r0, \$gcsr0)
> 
> config KVM
>      depends on AS_HAS_LVZ
> 

There are precedents in Linux for using .word when necessary.  There's 
no reason to prevent using KVM on old Binutils versions.

Paolo

