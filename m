Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FE06CA293
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjC0Lgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjC0Lgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC7E524E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679916946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3oWG8eDFO3W8b0ATQ4Ccurk5o+Kqkmxt/w3c7PVH8o0=;
        b=QWbcvVoSjcvI1FiPc/4eF/PWXHpS8pW1OoHxZrKwCFuyYH2fyMgfGybQ/HYxyerbrX1jnI
        OkJf21fQU16I9lIVeWbpvMbpuyJahEd5YPpVTKXgc0VnpLusx8KKjuD/F3/tqXmd3T1wN+
        S1j2VmbtCLdI5+GP0EvucrMnmqLC/WA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-DttPMjBaMaa85VYbr8mr7Q-1; Mon, 27 Mar 2023 07:35:45 -0400
X-MC-Unique: DttPMjBaMaa85VYbr8mr7Q-1
Received: by mail-ed1-f71.google.com with SMTP id q13-20020a5085cd000000b004af50de0bcfso12385854edh.15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679916944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3oWG8eDFO3W8b0ATQ4Ccurk5o+Kqkmxt/w3c7PVH8o0=;
        b=H1WK5F4XoPPecsc2Ku0bCIUvp+0upJDLDrTHgx43C3PPe2HLIor9TocLaZXah0kzzO
         7n60k8oZaNmn4zFCN5SsDpYwFR3ga52EGfQSZ7GidY8XBpUuybFntL9djmYFKYVBKsS5
         lcKt0xFBIt9siE7BY50x6J9YpPKQyqqROinow/AVjjynWAwYoGzBb5mTKuJDRhRF2imJ
         HAnckar2uiWw9GuCMnuZ2aqgYcU0Mnmw7HHsXkHaEywUOV7mg/jIclr1u/GCx36ewRlT
         CkPF+HZN0gaJCQPUZtD6hgE65oY4iemCZZxMyrkjJTo9tp4hzvakU7Ur5yU8EH+TDfAT
         e+Wg==
X-Gm-Message-State: AAQBX9cTR6AKKIkaAdU2BBXeM1bS0laobRg3XKzRVqN/9sN/fthE/HVa
        cxRQF/fLylShHFqrzemypBlk+Gono7aLG/Q+kd+UN6SoJE1asN0zZv+QMuSqodJpPcCfLoJJvzE
        aSYE6FE7oZerJwgduicXuTd07
X-Received: by 2002:a17:906:a15a:b0:8b1:3a18:9daf with SMTP id bu26-20020a170906a15a00b008b13a189dafmr11390673ejb.74.1679916944336;
        Mon, 27 Mar 2023 04:35:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350boHJ5uNr+JK/9/WOgc9ulehxxm7proX2Hnn5GmK3taR/nOP+mMUfcFyAYpZUAUBytn+q44Dw==
X-Received: by 2002:a17:906:a15a:b0:8b1:3a18:9daf with SMTP id bu26-20020a170906a15a00b008b13a189dafmr11390662ejb.74.1679916944075;
        Mon, 27 Mar 2023 04:35:44 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id jg35-20020a170907972300b0093e817ee3f9sm4262255ejc.191.2023.03.27.04.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 04:35:43 -0700 (PDT)
Message-ID: <6395d2c2-33e4-fed4-f46f-e350e923e081@redhat.com>
Date:   Mon, 27 Mar 2023 13:35:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] platform/x86/intel/pmc: Alder Lake PCH slp_s0_residency
 fix
Content-Language: en-US
To:     "David E. Box" <david.e.box@linux.intel.com>,
        irenic.rajneesh@gmail.com, rajvi.jingar@linux.intel.com,
        markgross@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20230320212029.3154407-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230320212029.3154407-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/20/23 22:20, David E. Box wrote:
> From: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> 
> For platforms with Alder Lake PCH (Alder Lake S and Raptor Lake S) the
> slp_s0_residency attribute has been reporting the wrong value. Unlike other
> platforms, ADL PCH does not have a counter for the time that the SLP_S0
> signal was asserted. Instead, firmware uses the aggregate of the Low Power
> Mode (LPM) substate counters as the S0ix value.  Since the LPM counters run
> at a different frequency, this lead to misreporting of the S0ix time.
> 
> Add a check for Alder Lake PCH and adjust the frequency accordingly when
> display slp_s0_residency.
> 
> Fixes: bbab31101f44 ("platform/x86/intel: pmc/core: Add Alderlake support to pmc core driver")
> Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans


> ---
>  drivers/platform/x86/intel/pmc/core.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index e489d2175e42..61ca7c37fb02 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -66,7 +66,18 @@ static inline void pmc_core_reg_write(struct pmc_dev *pmcdev, int reg_offset,
>  
>  static inline u64 pmc_core_adjust_slp_s0_step(struct pmc_dev *pmcdev, u32 value)
>  {
> -	return (u64)value * pmcdev->map->slp_s0_res_counter_step;
> +	/*
> +	 * ADL PCH does not have the SLP_S0 counter and LPM Residency counters are
> +	 * used as a workaround which uses 30.5 usec tick. All other client
> +	 * programs have the legacy SLP_S0 residency counter that is using the 122
> +	 * usec tick.
> +	 */
> +	const int lpm_adj_x2 = pmcdev->map->lpm_res_counter_step_x2;
> +
> +	if (pmcdev->map == &adl_reg_map)
> +		return (u64)value * GET_X2_COUNTER((u64)lpm_adj_x2);
> +	else
> +		return (u64)value * pmcdev->map->slp_s0_res_counter_step;
>  }
>  
>  static int set_etr3(struct pmc_dev *pmcdev)
> 
> base-commit: 02c464b73645404654359ad21f368a13735e2850

