Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E082692314
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjBJQQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjBJQQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:16:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B05265B8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676045756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eKne9KVuVdje+JYeGh16BUK5PUdXLIJtZx0OA4yquDU=;
        b=hwAxvQdPmvu96ArqrGx5gA2lXEybKo40XfFwJS8064rCANIhTiLIw0fuZRceS8JfxqkqBi
        uIolk/zufaQGyInMouFnE9nuPBXDLeU8o1U7DYJv4Hhai1BSTEZv2ydvamIUOW9l6gPJhM
        x75NcGpZslza3jTraBmpoXaeM2v93mw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-347-rWu-tmPAN5aZpiRby3vSSQ-1; Fri, 10 Feb 2023 11:15:55 -0500
X-MC-Unique: rWu-tmPAN5aZpiRby3vSSQ-1
Received: by mail-ej1-f71.google.com with SMTP id xh12-20020a170906da8c00b007413144e87fso3859831ejb.14
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:15:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKne9KVuVdje+JYeGh16BUK5PUdXLIJtZx0OA4yquDU=;
        b=Bmi5EWOu0Cdcftexxn+WpL8/Nyu4nJKBpTXajuTnaIbbWyVZUfaRK42n+s8qsFkXX1
         8X56qMxsOQxiBN1obfvoamjQSuZKYhIKL+qAgRdW1WqKP2shO0aSq+2l9VP0Iu3Wczar
         txnvpDL0D7jGikCFVWwcWUFZwm4qFfRCPXQBM5End3BUaTMNiMNgym/Tp8zkzJBOqtyG
         varuOO2nrMOXvo6DfDlhot5aTwrhSgxl30ceUSFALdLqo8roqpDp0RV+cuw2JsENwicu
         4N+Ls5nOsVukVk9yVB6Y2J+lo/kyTtitJX/nTvsh0039dOAfz4/7DzIxJboSzFZeZvZY
         BWTA==
X-Gm-Message-State: AO0yUKUpRvTmg9LvTO8reSjqLMk61CtRTxpwLoKYYtDHqsWoh+YJzIz7
        t3ut750h1HImV9wQ4LIm5J8O7OOvPNvG3UfhhN9tlAP0zFJOsrEuYf5mngYwVvrwSQqEmxYYR6E
        YaeBNLZFRpT2KjdTLDAbRTTRB0VNnRQ==
X-Received: by 2002:a50:d78f:0:b0:4aa:c77d:fa0a with SMTP id w15-20020a50d78f000000b004aac77dfa0amr16755404edi.22.1676045753540;
        Fri, 10 Feb 2023 08:15:53 -0800 (PST)
X-Google-Smtp-Source: AK7set9nSFQLGra3eu64GQ4Kkjwj62X9ldWiXdK+DbO+h+sjbItyTGn3UGxBQFM11FncNyve1qPFaA==
X-Received: by 2002:a50:d78f:0:b0:4aa:c77d:fa0a with SMTP id w15-20020a50d78f000000b004aac77dfa0amr16755393edi.22.1676045753385;
        Fri, 10 Feb 2023 08:15:53 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id f8-20020a50d548000000b004ab33d52d03sm1421293edj.22.2023.02.10.08.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 08:15:52 -0800 (PST)
Message-ID: <7d1749ec-bd8a-1fb4-49c1-0bb680ad530f@redhat.com>
Date:   Fri, 10 Feb 2023 17:15:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 1/1] platform/x86: Fix header inclusion in
 linux/platform_data/x86/soc.h
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org
References: <20230206145238.19460-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230206145238.19460-1-andriy.shevchenko@linux.intel.com>
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

Hi,

On 2/6/23 15:52, Andy Shevchenko wrote:
> First of all, we don't use intel-family.h directly. On the other hand
> we actively use boolean type, that is defined in the types.h (we take
> top-level header for that) and x86_cpu_id, that is provided in the
> mod_devicetable.h.
> 
> Secondly, we don't need to spread SOC_INTEL_IS_CPU() macro to the users.
> Hence, undefine it when it's appropriate.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  include/linux/platform_data/x86/soc.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/platform_data/x86/soc.h b/include/linux/platform_data/x86/soc.h
> index da05f425587a..a5705189e2ac 100644
> --- a/include/linux/platform_data/x86/soc.h
> +++ b/include/linux/platform_data/x86/soc.h
> @@ -8,10 +8,13 @@
>  #ifndef __PLATFORM_DATA_X86_SOC_H
>  #define __PLATFORM_DATA_X86_SOC_H
>  
> +#include <linux/types.h>
> +
>  #if IS_ENABLED(CONFIG_X86)
>  
> +#include <linux/mod_devicetable.h>
> +
>  #include <asm/cpu_device_id.h>
> -#include <asm/intel-family.h>
>  
>  #define SOC_INTEL_IS_CPU(soc, type)				\
>  static inline bool soc_intel_is_##soc(void)			\
> @@ -34,6 +37,8 @@ SOC_INTEL_IS_CPU(apl, ATOM_GOLDMONT);
>  SOC_INTEL_IS_CPU(glk, ATOM_GOLDMONT_PLUS);
>  SOC_INTEL_IS_CPU(cml, KABYLAKE_L);
>  
> +#undef SOC_INTEL_IS_CPU
> +
>  #else /* IS_ENABLED(CONFIG_X86) */
>  
>  static inline bool soc_intel_is_byt(void)

