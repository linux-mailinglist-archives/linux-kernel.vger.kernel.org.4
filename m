Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDFC727A91
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbjFHIzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbjFHIzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC94DE50
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686214501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hy3A1Ua9yZiMcI9cw8LBoikuGcbbLc5s+RNFFyFQvUg=;
        b=EMbEYcMlFi5dMOZRv4MZrMDj4RS9Bmbzl3qZonW/8IwoTqKZ+5QhqXeSGDohZO4BO91dp+
        xFS192wBIKhhYOH42pe3E60ujqBEFB9UFCRcHAxQq8M2fwoaIMSpwykXXBwEF4PF201RN4
        QwOBBbkO+komWu0oTIeDhp9Hb15QSPI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-KHlz1mO3PrGaMme1m5jPPw-1; Thu, 08 Jun 2023 04:54:59 -0400
X-MC-Unique: KHlz1mO3PrGaMme1m5jPPw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75d558057f6so48575885a.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 01:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686214499; x=1688806499;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hy3A1Ua9yZiMcI9cw8LBoikuGcbbLc5s+RNFFyFQvUg=;
        b=QuZeXOQFxTyTM2jg8pHgNDV1zvYl5/21tffLJ94wvm+LTDl64SoxgSmkrVDtA4LimY
         um40ZvMQFg3BVqs/xRq/fgZasie9s/kOlNZxgORKJEgVVrxKJHyQoHddUNuRU0k6tcpg
         cWEi1lF1VJ6e5UqwBWwTxJpi67yxPmtlgA5fF6reVL/alQZbCbODACycFI6HE5waTcs4
         4dKs7WY3RwvGWDDoe+mTf1FhsharFhpCIXpn6vLTVZAhpBZI3RCflZBZb0g6lnnGD6e6
         AcwFwY4F8zd5OMTNvQ9g2L/Jd7YpGOOmL0+F/0UOm/FS3BqE/RCxDJNxzhPsYJWM5Xcd
         ty8g==
X-Gm-Message-State: AC+VfDzZuugC6Z8ifevDqysm4x+yPtaf2gGh+TGB8o+Tijx9OnJw9UVP
        0AZXz0JBRiaYKD9HTCPTOArD0zKIlkfyWYhykuYZGfdq+BbSLOKXyh2xo+xJDVlOusvApuo6D+T
        scegdbLC+hIuU2dfJuyld3cjjcnwfsA33vcdrdl7cCGR1kuLj12itkXf5gPJPCOWrSVfagzC2xT
        d5CwfGEn25
X-Received: by 2002:a05:620a:27cc:b0:75d:5803:a20 with SMTP id i12-20020a05620a27cc00b0075d58030a20mr4694405qkp.68.1686214499222;
        Thu, 08 Jun 2023 01:54:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60oKmeuw06BMJkmeUPBP5oGcgJHw6hr4LDQE1HQbUBnKu5b4VIu+yrq+1gpDjw9S/JAlbteQ==
X-Received: by 2002:a05:620a:27cc:b0:75d:5803:a20 with SMTP id i12-20020a05620a27cc00b0075d58030a20mr4694360qkp.68.1686214497800;
        Thu, 08 Jun 2023 01:54:57 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id pa29-20020a05620a831d00b0074d3233487dsm182509qkn.114.2023.06.08.01.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 01:54:57 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] drivers: hv: Mark shared pages unencrypted in
 SEV-SNP enlightened guest
In-Reply-To: <2803e5d6-58bc-57f1-0721-226333238883@gmail.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-5-ltykernel@gmail.com> <87zg5ejchp.fsf@redhat.com>
 <2803e5d6-58bc-57f1-0721-226333238883@gmail.com>
Date:   Thu, 08 Jun 2023 10:54:53 +0200
Message-ID: <87cz26jpuq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tianyu Lan <ltykernel@gmail.com> writes:

> On 6/5/2023 8:54 PM, Vitaly Kuznetsov wrote:
>>> @@ -402,7 +417,14 @@ int hv_common_cpu_die(unsigned int cpu)
>>>   
>>>   	local_irq_restore(flags);
>>>   
>>> -	kfree(mem);
>>> +	if (hv_isolation_type_en_snp()) {
>>> +		ret = set_memory_encrypted((unsigned long)mem, pgcount);
>>> +		if (ret)
>>> +			pr_warn("Hyper-V: Failed to encrypt input arg on cpu%d: %d\n",
>>> +				cpu, ret);
>>> +		/* It's unsafe to free 'mem'. */
>>> +		return 0;
>> Why is it unsafe to free 'mem' if ret == 0? Also, why don't we want to
>> proparate non-zero 'ret' from here to fail CPU offlining?
>> 
>
> Based on Michael's patch the mem will not be freed during cpu offline.
> https://lwn.net/ml/linux-kernel/87cz2j5zrc.fsf@redhat.com/
> So I think it's unnessary to encrypt the mem again here.

Good, you can probably include Michael's patch in your next submission
then (unless it gets merged before that).

-- 
Vitaly

