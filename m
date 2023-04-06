Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C6E6D9491
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbjDFK7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbjDFK7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C354B7A8D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 03:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680778712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMJGZ0wM6SmRKKSmXFuC9u44rhIR7nr561NDFm1Xz2g=;
        b=ir3cVDDgFPEohc7DGaO1dioMzku1eh5JMJpnlihlz3CZkIFTo1tnXVoJNK47eF1d36j5K2
        IOHAyUfgpje8uxVdSCmKmKKp2004pXrCUAsdMqLkwE7O1Ybv3tNBmnsFK1urvJbllFXlyu
        xIa32OrsWXLluuAGYkLWlGHel4gSKyk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-tukkEEXqN42Uff7GRsnCQg-1; Thu, 06 Apr 2023 06:58:23 -0400
X-MC-Unique: tukkEEXqN42Uff7GRsnCQg-1
Received: by mail-ej1-f69.google.com with SMTP id vo2-20020a170907a80200b00949175b0b70so60390ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 03:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680778702; x=1683370702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sMJGZ0wM6SmRKKSmXFuC9u44rhIR7nr561NDFm1Xz2g=;
        b=7Jql0BNv6Un0glQeD7pLKH7PfYNVG5U5q+prgeq83upvfr4kgZMagt3gqcb72AAndg
         82InaB+KKSZq8s8CvdYx2cX/sNQHV87YP+f5JWsBQuF5aSSl9Eg+qAYWF0pTNJyil8+r
         NaiAGfmyRHPG+D/SYQ+TnkZO6696SAna0bDyBtas0CqCauSATxWmm4s/1R4R6XrRHYPX
         2slT7+SwYUA+1FRDVP6zhljX5/fxKbchbB86FGegRRSOL1zvUyw0eMUE+uvCUGOjR+wj
         AMyI5wSno1BRhp5lwv/OgKjtKM3VeGgI15LT4HhwMlpANTeaKWqsJETYIVWRJBCxtexy
         KCVw==
X-Gm-Message-State: AAQBX9fmsnwxgJpxzJJRRq3p6oNkH9WaitXT4wYX9fufQTPBZjaypUo+
        MpM5fPhqJ+lnrZUkZp8xbQvFGF4N5lUqdNYloIbrAs7BrBO6zC7oizUolezcisNIJOl8IGeNaSo
        dHPpdxWhDa1FAvsiXoiW2yTOqeD2tWBJu
X-Received: by 2002:a17:906:804b:b0:930:e3a0:8636 with SMTP id x11-20020a170906804b00b00930e3a08636mr5988398ejw.57.1680778701997;
        Thu, 06 Apr 2023 03:58:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350aoETtwoyere+ZTuvC9Y59fWPxWtLXznfKvZL7UpexVQFUpgNMKCuF81n0tTrFw+RdIw1B20w==
X-Received: by 2002:a17:906:804b:b0:930:e3a0:8636 with SMTP id x11-20020a170906804b00b00930e3a08636mr5988389ejw.57.1680778701721;
        Thu, 06 Apr 2023 03:58:21 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i17-20020a17090671d100b0092973e209f2sm660173ejk.109.2023.04.06.03.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 03:58:21 -0700 (PDT)
Message-ID: <efcdc3fe-de74-0f0d-d9d5-3249fc1d5d53@redhat.com>
Date:   Thu, 6 Apr 2023 12:58:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] platform/x86: intel-uncore-freq: Add client processors
Content-Language: en-US, nl
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230330145939.1022261-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230330145939.1022261-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On 3/30/23 16:59, Srinivas Pandruvada wrote:
> Make Intel uncore frequency driver support to client processor starting
> from Alder Lake.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

I assume that this is independent from the
"[PATCH] platform/x86/intel-uncore-freq: Uncore frequency control via TPMI"
changes ?

(just double checking before I merge this).

Regards,

Hans



> ---
>  .../platform/x86/intel/uncore-frequency/uncore-frequency.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
> index 00ac7e381441..32e2515ee366 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
> @@ -204,6 +204,13 @@ static const struct x86_cpu_id intel_uncore_cpu_ids[] = {
>  	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,	NULL),
>  	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, NULL),
>  	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE, NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, NULL),
>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_uncore_cpu_ids);

