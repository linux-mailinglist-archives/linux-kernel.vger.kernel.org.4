Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6263460FC2C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbiJ0Pku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbiJ0Pkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACD28FD58
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666885240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YKRsMCLFqXQIRxY49mceOe7zpnfO38tmJlxXIDPO3nk=;
        b=ONbByKVhCMab6Q9lj1MxBOoUYmYlOjF/SsB07AKVO7e1xHWDqo9YEb8eeXzPUvZHMjUslc
        41/iOvVU6GERR4H6O3KsFqL/RB6YDBr1XyFdbe1jcSPOdTrM7Jb891LwaKB7yKPht1J5gY
        inWBZFkFWPTLXSdWSrH4CZ6Y4mdQifw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-i1s0AVzNPGGo9VLfmZ1gMw-1; Thu, 27 Oct 2022 11:40:39 -0400
X-MC-Unique: i1s0AVzNPGGo9VLfmZ1gMw-1
Received: by mail-ed1-f71.google.com with SMTP id s3-20020a056402520300b0046262a46f88so1375777edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKRsMCLFqXQIRxY49mceOe7zpnfO38tmJlxXIDPO3nk=;
        b=5fx246+REFT3E0elxwMgdDPg8Vk8IswEephWgVVZ7y+v3UXulfp4hfTsij97NzZMmD
         mcuoetA/vE0xrUlHxF07RWPS6gK5l74K10RaTUHQwGEheqLyeA7wD4pzBelUdYpOq8wT
         LQJUf0OKlvDp7LV9bz9+x+bu18nWnGqbkCLo5PxXu6T0u76TAT09vSFygwSYczVAuITU
         N235D2YSdBAeu/yWnW86wf2Z1fjdCuK7ZteUIuWgzklhXTfcPG0CsSbJmCaQgUgmKrh5
         uMtNA7cwkHi83uCHxFX0WaJhZXWuFf5BiZNiktVvXqIJjhAaD6LdVoQ1E+lNhxjpcI75
         CFrA==
X-Gm-Message-State: ACrzQf3/qNcab6K6Sq5Ep+lUSO+IRGkiLBUYX3snAhgQAxFbPT2VTM82
        RHRb/mATxoGWsAcjuRb8EEeC5l7bkAiLijjPp32nMtg6cSfRlW24DANlm8ltX+lJFqzHK6IfWgC
        Z9+82rsbUJvfSwdqWGjPHheNg
X-Received: by 2002:a17:907:a067:b0:7a7:dc5e:eb2d with SMTP id ia7-20020a170907a06700b007a7dc5eeb2dmr20247167ejc.121.1666885238070;
        Thu, 27 Oct 2022 08:40:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6Fsb3RaQYZ9nrA1g50CSpu2aVgB/3n8AKmtdSp8DoNxb2z0BGKLJ2hM5h6GwUEI0EWwBKMHw==
X-Received: by 2002:a17:907:a067:b0:7a7:dc5e:eb2d with SMTP id ia7-20020a170907a06700b007a7dc5eeb2dmr20247150ejc.121.1666885237895;
        Thu, 27 Oct 2022 08:40:37 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id jp1-20020a170906f74100b007a9a56e2a07sm965692ejb.49.2022.10.27.08.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 08:40:37 -0700 (PDT)
Message-ID: <4b7304c0-8dd5-9add-7c84-4e9f0aa9396b@redhat.com>
Date:   Thu, 27 Oct 2022 17:40:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1] platform/x86: intel_pmc_core: promote S0ix failure
 warn() to WARN()
Content-Language: en-US, nl
To:     Sven van Ashbrook <svenva@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     platform-driver-x86@vger.kernel.org,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Mark Gross <markgross@kernel.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
References: <20221027151908.v1.1.I295e65357f06f162b46ea6fc6c03be37e3978bdc@changeid>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221027151908.v1.1.I295e65357f06f162b46ea6fc6c03be37e3978bdc@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/27/22 17:19, Sven van Ashbrook wrote:
> The "failure to enter S0ix" warning is critically important for monitoring
> and debugging power regressions, both in the field and in the test lab.
> 
> Promote from lower-case warn() to upper-case WARN() so that it becomes
> more prominent, and gets picked up as part of existing monitoring
> infrastructure, which typically focuses on WARN() and ignores warn()
> type log messages.
> 
> Signed-off-by: Sven van Ashbrook <svenva@chromium.org>

WARN() is really only intended for internal kernel bugs and not for
hw misbehaving, so I'm not a fan of the change you are suggesting here.

Intel folks, do you have an opinion on this ?

Regards,

Hans


> ---
> Against v6.1-rc2
> 
>  drivers/platform/x86/intel/pmc/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index a1fe1e0dcf4a5..834f0352c0edf 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -2125,7 +2125,7 @@ static __maybe_unused int pmc_core_resume(struct device *dev)
>  	}
>  
>  	/* The real interesting case - S0ix failed - lets ask PMC why. */
> -	dev_warn(dev, "CPU did not enter SLP_S0!!! (S0ix cnt=%llu)\n",
> +	dev_WARN(dev, "CPU did not enter SLP_S0!!! (S0ix cnt=%llu)\n",
>  		 pmcdev->s0ix_counter);
>  	if (pmcdev->map->slps0_dbg_maps)
>  		pmc_core_slps0_display(pmcdev, dev, NULL);

