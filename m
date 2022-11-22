Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9CB6340B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiKVQBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiKVQBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:01:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A2A6B3B1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669132814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UH2NKASbFNrFdasvahoGiAeoT+d8FFw4FDleUBrke7c=;
        b=dyBGXbiIoLsapNBbBoa5hAfcWKHd0r0jTM/kr3/hUoYThKyiy5ltGWiDJagCMStlbJweff
        NVqGDiGxzDWBXmM1/PVSjo4akfFd0gTeq6mfMcPz/N1GsReKcnenaRTsnDMUfKNeKmpYcr
        VfD5mzAZ5CP9d0O3eYrglmRFubtDf94=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-512-1LPvtDAYO9OB_14WPVtcow-1; Tue, 22 Nov 2022 11:00:12 -0500
X-MC-Unique: 1LPvtDAYO9OB_14WPVtcow-1
Received: by mail-ej1-f70.google.com with SMTP id dn14-20020a17090794ce00b007ae5d040ca8so8520915ejc.17
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:00:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UH2NKASbFNrFdasvahoGiAeoT+d8FFw4FDleUBrke7c=;
        b=KYx1w9bhLraN7rWgYR6ExxLwqNSXjLNVat+Y+CVaW1w6G9K/pVLtX5EFh9fZq09arC
         8xIYYJUu1mUb2JokTGTmQX9XBnb9V3smXt8knfzPUFf7ZA9qmiwm6XcIS70ovOlbdIGB
         W8qyUMnTkmXaqob5Cxea4HG+HposQdGuROU9A/XY1sxX7meKA75lEFkvq6+y06FEebjQ
         eXMQq4bNGOK/GEGeTypcMURPA1GLr32AXlMcH3wEbMTaB0A1FZdr0ygbyjr4f1PoJPCo
         q8yDAHSHlnchgnni5lJlHAJlEmvMqreU6I0sLQ8UgjdyuzOgmACC0oQzQ3++GMeUM1F/
         7Tng==
X-Gm-Message-State: ANoB5pnFcpJ/UxSpJsgw3S1l6xSAffF1AFO1jqsnUm+zH3/NzFpzHMrf
        R71zNIR2rFOaPnhIkX5MfFPJNpM4RTZpgmRHW1sWishMIMHvoRgyQTKJDeMaS3o86TbKG722wHh
        DEV2z00kc28uPAv28UH8OOj2w
X-Received: by 2002:a05:6402:5011:b0:469:9c84:3bdd with SMTP id p17-20020a056402501100b004699c843bddmr9158206eda.302.1669132811257;
        Tue, 22 Nov 2022 08:00:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6IMRfjjWtDhhBIWcX2jWUelv73XRu4/xzCW+gQPl4m2UG8bjSYPEa1GIZh3z8eFBgWtUqRJw==
X-Received: by 2002:a05:6402:5011:b0:469:9c84:3bdd with SMTP id p17-20020a056402501100b004699c843bddmr9158186eda.302.1669132811001;
        Tue, 22 Nov 2022 08:00:11 -0800 (PST)
Received: from ovpn-194-185.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p22-20020a17090653d600b0078c213ad441sm6201926ejo.101.2022.11.22.08.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 08:00:10 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Subject: Re: [PATCH v2 4/6] KVM: selftests: Replace hardcoded Linux OS id
 with HYPERV_LINUX_OS_ID
In-Reply-To: <20221121234026.3037083-5-vipinsh@google.com>
References: <20221121234026.3037083-1-vipinsh@google.com>
 <20221121234026.3037083-5-vipinsh@google.com>
Date:   Tue, 22 Nov 2022 17:00:09 +0100
Message-ID: <87k03nou7q.fsf@ovpn-194-185.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vipin Sharma <vipinsh@google.com> writes:

> Use HYPERV_LINUX_OS_ID macro instead of hardcoded 0x8100 << 48
>
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/hyperv_clock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
> index d576bc8ce823..2ee0af0d449e 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
> @@ -104,7 +104,7 @@ static void guest_main(struct ms_hyperv_tsc_page *tsc_page, vm_paddr_t tsc_page_
>  
>  	/* Set Guest OS id to enable Hyper-V emulation */
>  	GUEST_SYNC(1);
> -	wrmsr(HV_X64_MSR_GUEST_OS_ID, (u64)0x8100 << 48);
> +	wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
>  	GUEST_SYNC(2);
>  
>  	check_tsc_msr_rdtsc();

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

