Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DAC68D94B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjBGN3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjBGN3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:29:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D17A21979
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675776498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9btqwAUpHle2BvSwyJKP2IU4aANhcCkTU8iQE6/qdo4=;
        b=Mc350gZ40rO3kI/PhspKLSlG04TMob5joiZQVZaa3jgalQmDXd+EYKmEqQW5/GbfTnU1MV
        VFJyNJjRF0fFk8lpBDPQDtBQTcMnDuorg6+6PaomFF5qD1Rej2jr3G6b5Dc93Rlz5asOT9
        zIaSaFUxwXw4PsqXcbPUN7bJdlMrG4Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-211-0fOVNN0lOfWxvnsF7aegDA-1; Tue, 07 Feb 2023 08:28:10 -0500
X-MC-Unique: 0fOVNN0lOfWxvnsF7aegDA-1
Received: by mail-qv1-f69.google.com with SMTP id ly4-20020a0562145c0400b0054d2629a759so7651383qvb.16
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 05:28:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9btqwAUpHle2BvSwyJKP2IU4aANhcCkTU8iQE6/qdo4=;
        b=3BXLwXoGQR6YefObR5MbG/TiftJAeU7wZgCfiNZYQpMesNfgpMCDrC1PMGZRbeejEt
         htKFxAShVvGZqdt6w2ShyFgy3g1n7u9zuTa88ZjhguAbZJL/BHAex5TSjjgY0wJWGlRR
         8HJVZWCqJSE/ZDoNaFpHYOh7CKals5WP3c3rQOLO/Lf9dgr8ib4owsKfivWy3zzwNQwV
         gj3IAMAgCOuIoFOT+iw1l5z9l9RxCB0rehIpq6Cr73QNJAi1WY4/75fAJneHemsTQBYc
         3ErbYJnZztCuKqy0hSCZJHlmtozXkK+nZdsHECT4KUIPzYy6bFzDPvOfDfIuTO6H+7E4
         kOMw==
X-Gm-Message-State: AO0yUKViMOzyCezSJeh1NnccJoIp2e9WcNIM9V5C2/+dBccdp3OybSwt
        1MCY1bI6i9DB2pqGNThNoQBHVXy//+KkDnNlirOA/2mlUFHAFCcjO366dBdOiVMtUL2O+nS4TlI
        3rk9bcZaGVkUlnKlOyXUsJ58=
X-Received: by 2002:a05:622a:651:b0:3b6:3a8f:ecbc with SMTP id a17-20020a05622a065100b003b63a8fecbcmr3794311qtb.66.1675776489782;
        Tue, 07 Feb 2023 05:28:09 -0800 (PST)
X-Google-Smtp-Source: AK7set8/p6FiRxQXpDHQnZ676YJHD2oDI5ZaoxLPFSd1xRwHmRBbhfB1NntMru5EJ2n33lNXX3sVIA==
X-Received: by 2002:a05:622a:651:b0:3b6:3a8f:ecbc with SMTP id a17-20020a05622a065100b003b63a8fecbcmr3794289qtb.66.1675776489433;
        Tue, 07 Feb 2023 05:28:09 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-30-183.cust.vodafonedsl.it. [2.34.30.183])
        by smtp.gmail.com with ESMTPSA id o5-20020ac80245000000b003ab7aee56a0sm9259630qtg.39.2023.02.07.05.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 05:28:09 -0800 (PST)
Message-ID: <7ab96897-f9eb-4abd-a453-cac622588469@redhat.com>
Date:   Tue, 7 Feb 2023 14:28:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 1/4] fpga: add initial KUnit test suite
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20230203170653.414990-1-marpagan@redhat.com>
 <20230203170653.414990-2-marpagan@redhat.com>
 <0491c635-1c0f-01a9-6449-0970f7c0c52f@intel.com>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <0491c635-1c0f-01a9-6449-0970f7c0c52f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-02-07 02:05, Russ Weight wrote:
> Hi Marco,
> 
> I've just started looking at this, but I have a couple of early comments below
>

Thanks for looking into this.

[...]
 
>> --- /dev/null
>> +++ b/drivers/fpga/tests/Kconfig
>> @@ -0,0 +1,15 @@
>> +config FPGA_KUNIT_TESTS
>> +	tristate "FPGA KUnit tests" if !KUNIT_ALL_TESTS
>> +	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT
>> +	default KUNIT_ALL_TESTS
>> +	help
>> +	  Builds unit tests for the FPGA subsystem. This option
>> +	  is not useful for distributions or general kernels,
>> +	  but only for kernel developers working on the FPGA
>> +	  subsystem and its associated drivers.
> These lines seem shorter than necessary. You can use up to 75
> characters per line.
> 

I'll reflow the text in the next revision.

[...]

>> +static struct kunit_case fpga_test_cases[] = {
>> +	KUNIT_CASE(fpga_base_test),
>> +	KUNIT_CASE(fpga_pr_test),
>> +	{},
>> +};
>> +
>> +static struct kunit_suite fpga_test_suite = {
>> +	.name = "fpga-tests",
>> +	.suite_init = fpga_suite_init,
>> +	.test_cases = fpga_test_cases,
>> +};
>> +
>> +kunit_test_suite(fpga_test_suite);
> 
> When I try to build with these patches, I get this error:
>>
>> ERROR: modpost: missing MODULE_LICENSE() in drivers/fpga/tests/fpga-tests.o
> 
> I was able to fix it by adding this line at the bottom of the file:
> 
>> MODULE_LICENSE("GPL");
> 
> - Russ
>

Right, I forgot to add module info macros to the test suite module.
I'll add MODULE_LICENSE() in the next revision.

Thanks for the feedback,
Marco

