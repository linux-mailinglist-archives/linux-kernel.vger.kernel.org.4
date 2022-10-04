Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69A25F3E27
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJDIVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJDIVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB681BE9B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664871676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ey2tkE+Uksmp2pmcaxq0Z3p4VeNfOuZjcREwwMwZJB8=;
        b=bXPZiHDQjQyk5omGJCbdvoQeTaS5rK7A18FLgs6182X9xJDN4L7crtnQKyjSnZ8KbZjx3D
        NwR4eikAaAW+VAXeXwIxSz6iNYD9XqwceiX/kS3Jh+7itfR+ZmFbFz8URrI8sazG0PKXYT
        32Lq9416x9f5NGsc3V6DnYQLOrnPSWc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-42-0XoFfG7TPCSByNhMfsu4kw-1; Tue, 04 Oct 2022 04:21:14 -0400
X-MC-Unique: 0XoFfG7TPCSByNhMfsu4kw-1
Received: by mail-wr1-f69.google.com with SMTP id i1-20020adfa501000000b0022cd1e1137bso3742873wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ey2tkE+Uksmp2pmcaxq0Z3p4VeNfOuZjcREwwMwZJB8=;
        b=P8J8rJYk5/bVAPR87Bry7M0sOnmANoAJEV/3toktjyQwdLic+MGYGrLtrM70m32VCx
         3K/+4xlhqPyNB0vxGb3XZTgGtMh5Mk20u09HknpR/F4Tk9I/iN4LGFVlb6HirQEyJJa2
         GABkyVqver1rOwzyd3PVHzduJmSfHi4FQytSed2s5+iIp1W4DsC/MqWzcmGhqi4pqgLN
         L4mSHLuzQrDTKutsmEDnHkfTqKLZcO0oAD9POZ21ci1EWyxdjXdDMFVxpHqxff405TG5
         DHsr7DeJ2MpnErcwwcdb48JH2PwvnyHNN1i9pR5S2SpKtE1Ua4MHCQZwXBId0ZDpLEN0
         4fSA==
X-Gm-Message-State: ACrzQf1fTZJmbDjGKS3//+W7P8CksXnOe+B6DYEVHU8ujL2TXg+SEvib
        WNPPHdMaFQ+DYtpDCafu8KaUbtpRMFjB1hCjs9GO2ooJZlyHk1N5qX/E+ukqniV9uzTJ1VGcVE2
        G2aE6/sXd5JOZeN1FMeMCfKlx
X-Received: by 2002:a05:600c:474a:b0:3b4:cb93:7d57 with SMTP id w10-20020a05600c474a00b003b4cb937d57mr9507757wmo.41.1664871673644;
        Tue, 04 Oct 2022 01:21:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7t7/WnQ/rPAxDlAuMCud8gO/JdRg8ZGL5c/bT8KDb0P6rlWds0eGi2vsKOLBXUv0PFtCmybw==
X-Received: by 2002:a05:600c:474a:b0:3b4:cb93:7d57 with SMTP id w10-20020a05600c474a00b003b4cb937d57mr9507735wmo.41.1664871673457;
        Tue, 04 Oct 2022 01:21:13 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-178-246.web.vodafone.de. [109.43.178.246])
        by smtp.gmail.com with ESMTPSA id x24-20020a05600c189800b003b4727d199asm13080082wmp.15.2022.10.04.01.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 01:21:12 -0700 (PDT)
Message-ID: <3762a3e2-07f8-0048-6b3e-6b0417aff781@redhat.com>
Date:   Tue, 4 Oct 2022 10:21:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 8/9] KVM: s390: selftest: memop: Fix typo
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20220930210751.225873-1-scgl@linux.ibm.com>
 <20220930210751.225873-9-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220930210751.225873-9-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 23.07, Janis Schoetterl-Glausch wrote:
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>   tools/testing/selftests/kvm/s390x/memop.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index 3a160ab0415b..1887685b41d2 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -970,7 +970,7 @@ static void test_errors_key_fetch_prot_override_enabled(void)
>   
>   	/*
>   	 * vcpu, mismatching keys on fetch,
> -	 * fetch protection override does not apply because memory range acceeded
> +	 * fetch protection override does not apply because memory range exceeded
>   	 */
>   	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, READ, mem2, 2048 + 1, GADDR_V(0), KEY(2));
>   	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, READ, mem2, PAGE_SIZE + 2048 + 1,

Reviewed-by: Thomas Huth <thuth@redhat.com>

