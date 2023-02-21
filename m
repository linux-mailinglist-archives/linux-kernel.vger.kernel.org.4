Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C7969DBB7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjBUIPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjBUIPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:15:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD69C662
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676967254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CMD/lSpj8Q+BWiNprToa/ipg9NB2qcmu1EFE9cZ2W3g=;
        b=B9dAcKauPhgRy0UtscRJccn7nkXfD1lNGw67rheO6oIuRkoGnXL23vejX4wpvK2Ncecvjg
        MEFfS1AS940CDlgzpAe+irrjhc44d06XeGRN4OH60phCTrHyJqyukNLYGbUItoBeqDzDRL
        WmlnP/2pxO+YvYEGWcPgvLaxUdYsskQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-347-w6WOUOzpObuiaE8aRtJFKw-1; Tue, 21 Feb 2023 03:14:13 -0500
X-MC-Unique: w6WOUOzpObuiaE8aRtJFKw-1
Received: by mail-ed1-f72.google.com with SMTP id en10-20020a056402528a00b004acbf564d75so4145768edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:14:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMD/lSpj8Q+BWiNprToa/ipg9NB2qcmu1EFE9cZ2W3g=;
        b=2k9toCDVl4XM6/ZOf/IHdiWCbHdX5IHOCdgHQhfVfxkc/WDu/e/JKHpeJxOK6ozrMK
         0xoL0z/99ICSDBr1AxhQQRQ4eRUT5JFG0cyiZWNbjSeZW8kQKqiMSZco6YMzYtLFg40M
         FefjO7YtXLyEValbchqMJtjyluWX1s3NX03hRNeAbaH9o8Zu32xGSYQ+7r5CLwTIL+Cs
         S5h2Eg0Ze3gbIImuGeyg+eRU7UzWXf9D2yVU0NwbcZy18nGKN+wtv/Sk2/3sd7ViTGhS
         gFLRmfXHb3jRfpFQvJ90l0nFP3T/qxNPph4teQ7yno6Tkdw3vSnRx2WQBC9lAGlvKPuM
         GpZw==
X-Gm-Message-State: AO0yUKXCVNUmfvhE6MgG/HIuXoCBYxnvFsnnQFyLZFGmGpxikIDu/3pW
        XUth1MP0ikwWss/87VDkeQgSyfRQq2Cj6u2CGHDAgiDOB4Jd70caFX1s36bwjla+k0tPxUB0v1w
        Zq94C76J+PEuZyvmglFOnNRhW
X-Received: by 2002:a17:907:2cc5:b0:8ae:e724:ea15 with SMTP id hg5-20020a1709072cc500b008aee724ea15mr14369740ejc.76.1676967252331;
        Tue, 21 Feb 2023 00:14:12 -0800 (PST)
X-Google-Smtp-Source: AK7set9AS5QbQlqtrVyvZDghkkGcXTp+zHcc9xFk+Kvirqcn35qFg8g54l0y9vHodt2+vSxdFaPeOQ==
X-Received: by 2002:a17:907:2cc5:b0:8ae:e724:ea15 with SMTP id hg5-20020a1709072cc500b008aee724ea15mr14369720ejc.76.1676967252017;
        Tue, 21 Feb 2023 00:14:12 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id lf13-20020a170906ae4d00b008b12c318622sm6855117ejb.29.2023.02.21.00.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 00:14:11 -0800 (PST)
Message-ID: <3f16a8e1-21d9-808e-aa1a-4f1d6f6f291b@redhat.com>
Date:   Tue, 21 Feb 2023 09:14:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     maobibo <maobibo@loongson.cn>,
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
 <20230220065735.1282809-3-zhaotianrui@loongson.cn>
 <bf4111f9-f722-1847-4f1d-964c5356f392@redhat.com>
 <0fa9c062-d3fc-61e5-4d54-6bc29f7c64cf@loongson.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 02/29] LoongArch: KVM: Implement kvm module related
 interface
In-Reply-To: <0fa9c062-d3fc-61e5-4d54-6bc29f7c64cf@loongson.cn>
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

On 2/21/23 07:59, maobibo wrote:
>> Also, why does the world switch code need a copy?
> There will be problem in world switch code if there is page fault reenter,
> since pgd register is shared between root kernel and kvm hypervisor.
> World switch entry need be unmapped area, cannot be tlb mapped area.

So if I understand correctly the processor is in direct address 
translation mode until the "csrwr t0, LOONGARCH_CSR_CRMD" instruction. 
Where does it leave paged mode?

Can you please also add comments to kvm_vector_entry explaining the 
processor state after a VZ exception entry (interrupts, paging, ...)?

Paolo

