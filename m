Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AABA5BCAF3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiISLlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiISLld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50862DE8E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663587691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NYrB5jXka4MSSRtLAagt7tKGvBVemiYpsuNtJkRXpFM=;
        b=avhjaMC3InwdTh4ZRWCAnABbT9F1+7fXM3UrXGtbFGqhQZyBdSuE2mA7zClmhfkFqNXaV0
        JyLTcFRe8PP2bXCnUpV68o2GvvD6YTJ8ihG60MbiWbf6Vjw1+w6B3ngg6JWjxEEMtJdfZ3
        yxATjvpyE8ltVxq1HUXfUdDdcYGuj9U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-13-c0WIN4BFPEaN7UhE9nkpbg-1; Mon, 19 Sep 2022 07:41:28 -0400
X-MC-Unique: c0WIN4BFPEaN7UhE9nkpbg-1
Received: by mail-ed1-f71.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so19996831eda.19
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NYrB5jXka4MSSRtLAagt7tKGvBVemiYpsuNtJkRXpFM=;
        b=N9neLwiKOFGFkboPLyQ/9uDC0LVI4tzb3w1teBfLA8stm+2e9hdQ2D1GF0hkzvgOxy
         uH6PnvZcg6lvtj0H/YsRR1L7HYoXAfTV9Qzh2NHpf0yq7EU9SpH3YydObzVlnPCiSX/Q
         yANq8vOi/MiUqFkZSY2ogpqIZGiTnRFDJZub0C6XpnZ5DjdpS/OyMOHIdVXShJ/RDjA4
         B9AcfQ4was7n7SWkkXsEs4zAzdDorl2RM3cBXb6x4hJ/5prGuncarjYDvvNEpvl8QDDH
         MNNNJD9p9sPuVSzUvW9l7OxvUnqWqIAUOUGgkJUNWiL/eS6tNOWvy24yVXHl/1R2sZJu
         q5mg==
X-Gm-Message-State: ACrzQf132SpQjCE9H7JMH12oskaJJ87BXanzesWapfADMv9jrlNyhX+B
        A0sS4ZMr9NgtbO03f9YxO7Dl7oQYKFEHTxISsLSKtTsOeK6u1FrDtYXawaoeZDnIS34qvudm5sh
        1bwWAhOEOQx7sZJjZnDKwLXUk
X-Received: by 2002:a05:6402:e01:b0:442:dd7e:f49d with SMTP id h1-20020a0564020e0100b00442dd7ef49dmr14815593edh.355.1663587686949;
        Mon, 19 Sep 2022 04:41:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6vNL48ciwqGn+vRPvAPI7nBmFGOKzBvaNfpCQGIp249nFnSOGMgIDTjEzjxM51VUfJ1QpeGg==
X-Received: by 2002:a05:6402:e01:b0:442:dd7e:f49d with SMTP id h1-20020a0564020e0100b00442dd7ef49dmr14815584edh.355.1663587686807;
        Mon, 19 Sep 2022 04:41:26 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id z15-20020a170906434f00b007413360a48fsm4381702ejm.50.2022.09.19.04.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:41:26 -0700 (PDT)
Message-ID: <3537fa63-9015-c63d-2321-a77062e24d6f@redhat.com>
Date:   Mon, 19 Sep 2022 12:41:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 2/2] platform/x86/intel: pmc/core: Add Raptor Lake
 support to pmc core driver
Content-Language: en-US
To:     Gayatri Kammela <gayatri.kammela@linux.intel.com>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, irenic.rajneesh@gmail.com,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
References: <20220912233307.409954-1-gayatri.kammela@linux.intel.com>
 <20220912233307.409954-2-gayatri.kammela@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220912233307.409954-2-gayatri.kammela@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hk,

On 9/13/22 00:33, Gayatri Kammela wrote:
> Add Raptor Lake client parts (both RPL and RPL_S) support to pmc core
> driver. Raptor Lake client parts reuse all the Alder Lake PCH IPs.
> 
> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: David Box <david.e.box@intel.com>
> Acked-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
> ---
> Changes since v1:
> 1) Added a dependency patch- ea902bcc1943f7539200ec464de3f54335588774 :
>  "x86/cpu: Add new Raptor Lake CPU model number".
> 2) Rebased the above patch on v6.0-rc1 with "Acked-by" from Hans and
>  Rajneesh.

I still cannot take this, since patch 1/2 is *already merged* through
another tree, so me cherry-picking it leads to potential conflicts.

As I have already explained twice you need to submit this upstream
throuh the same tree which has the original merge of patch 1/2.

You can tell the maintainer of that tree that I'm ok with merging this
through that maintainers tree and that that is what my Ack is for.

Regards,

Hans


> 
>  drivers/platform/x86/intel/pmc/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index a1fe1e0dcf4a..17ec5825d13d 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1914,6 +1914,8 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>  	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&tgl_reg_map),
>  	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_reg_map),
>  	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &tgl_reg_map),
> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_reg_map),
> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_reg_map),
>  	{}
>  };
>  

