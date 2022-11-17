Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9656862DD49
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240194AbiKQNxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiKQNxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:53:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A718270A32
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668693140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wpvdRRPSWuBOzqjkLW4UVAXlXHzxi+SeLUYh0KTToJ0=;
        b=BzcEDMT8R2yHZy1XgtECAp+C9N5cOB1hiKs9yymTrToHSuNfVmRUwWPuuhpAQYuXQCT6Bb
        8XWj1OX56pm1p8mUgUap/pm3ZDdSwpqjQv8FPl4YAoQXgj+epaLvE0XB5oa8TTTLMR/8u3
        lm4MG2cfuXTXYEQn3w7AGA7JaxWvusA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-307-ZsKwc8ipPVOwL8AfbXjvBQ-1; Thu, 17 Nov 2022 08:52:14 -0500
X-MC-Unique: ZsKwc8ipPVOwL8AfbXjvBQ-1
Received: by mail-ed1-f69.google.com with SMTP id w17-20020a056402269100b00461e28a75ccso1262204edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wpvdRRPSWuBOzqjkLW4UVAXlXHzxi+SeLUYh0KTToJ0=;
        b=ryW8jwsCRU7++k5wU17KZDZcRmq86bqwfrn30V1sYDOkNGGh5Q4CvuSmpQG0rJtha0
         b7DtSUoqjpF8krFUcyuewI58R92WKFMuOG4NXvPhMwe4gxWuhDgRLEa3QTZkqNvsUUVu
         vwMYkEWPjEP+xm6btLWJ6LAXHO53PuuSV+OCRKyWzZGeydGatsKr4QZKAsFmfbQL9y3R
         PSZihRkgR94ZNTeFGm+bd+Y2ZHhM7/yvgBExqgcMS8MDqSE7CzpUbBLGVBgjFHuaVnpF
         ETvVT5h57nVWr/B7WNxSzVHuhJ6+qBifw9IU09YlrvdydrJsaJbOiP0gRZhYpLH0R7e7
         7M8A==
X-Gm-Message-State: ANoB5pkhdM22S/rzWZql89+Dfk4J7Xj/rglQfQZg5TMmkeF9H7ny9Vn/
        iDQTptNPmygV0vOBgucfj9l5Lva5PwLTrkA7hG/wvw31MY3iQOn2V++/Xxr1sSY6/WY3x/mZ81E
        9sEQJer78IelLwCyXoBjH7lFU
X-Received: by 2002:a17:906:14cf:b0:7af:1233:948d with SMTP id y15-20020a17090614cf00b007af1233948dmr2075088ejc.698.1668693132531;
        Thu, 17 Nov 2022 05:52:12 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7DJT1l3hKzc+AZRjibvqJIDZSE3FxLXwc+Igdq1pqDYhjR0x86ACHr43Lmrk/TQlyVtM+lYw==
X-Received: by 2002:a17:906:14cf:b0:7af:1233:948d with SMTP id y15-20020a17090614cf00b007af1233948dmr2075083ejc.698.1668693132383;
        Thu, 17 Nov 2022 05:52:12 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id c20-20020a170906171400b007305d408b3dsm400332eje.78.2022.11.17.05.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 05:52:11 -0800 (PST)
Message-ID: <cda5e08b-4962-3f5a-8c9f-fca177d9b35e@redhat.com>
Date:   Thu, 17 Nov 2022 14:52:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 6/9] tools/arch/x86: intel_sdsi: Add Intel On Demand text
Content-Language: en-US, nl
To:     "David E. Box" <david.e.box@linux.intel.com>, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221101191023.4150315-1-david.e.box@linux.intel.com>
 <20221101191023.4150315-7-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221101191023.4150315-7-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/1/22 20:10, David E. Box wrote:
> Intel Software Defined Silicon (SDSi) is now officially known as Intel
> On Demand. Change text in tool to indicate this.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  tools/arch/x86/intel_sdsi/intel_sdsi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> index 9dd94014a672..3718bd0c05cb 100644
> --- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * sdsi: Intel Software Defined Silicon tool for provisioning certificates
> - * and activation payloads on supported cpus.
> + * sdsi: Intel On Demand (formerly Software Defined Silicon) tool for
> + * provisioning certificates and activation payloads on supported cpus.
>   *
>   * See https://github.com/intel/intel-sdsi/blob/master/os-interface.rst
>   * for register descriptions.
> @@ -150,7 +150,7 @@ static void sdsi_list_devices(void)
>  	}
>  
>  	if (!found)
> -		fprintf(stderr, "No sdsi devices found.\n");
> +		fprintf(stderr, "No On Demand devices found.\n");
>  }
>  
>  static int sdsi_update_registers(struct sdsi_dev *s)
> @@ -206,7 +206,7 @@ static int sdsi_read_reg(struct sdsi_dev *s)
>  	printf("\n");
>  	printf("PPIN:                           0x%lx\n", s->regs.ppin);
>  	printf("Enabled Features\n");
> -	printf("    SDSi:                       %s\n", !!s->regs.en_features.sdsi ? "Enabled" : "Disabled");
> +	printf("    On Demand:                  %s\n", !!s->regs.en_features.sdsi ? "Enabled" : "Disabled");
>  	printf("Authorization Failure Count\n");
>  	printf("    AKC Failure Count:          %d\n", s->regs.auth_fail_count.key_failure_count);
>  	printf("    AKC Failure Threshold:      %d\n", s->regs.auth_fail_count.key_failure_threshold);
> @@ -428,7 +428,7 @@ static int sdsi_provision_akc(struct sdsi_dev *s, char *bin_file)
>  		return ret;
>  
>  	if (!s->regs.en_features.sdsi) {
> -		fprintf(stderr, "SDSi feature is present but not enabled. Unable to provision");
> +		fprintf(stderr, "On Demand feature is present but not enabled. Unable to provision");
>  		return -1;
>  	}
>  
> @@ -458,7 +458,7 @@ static int sdsi_provision_cap(struct sdsi_dev *s, char *bin_file)
>  		return ret;
>  
>  	if (!s->regs.en_features.sdsi) {
> -		fprintf(stderr, "SDSi feature is present but not enabled. Unable to provision");
> +		fprintf(stderr, "On Demand feature is present but not enabled. Unable to provision");
>  		return -1;
>  	}
>  

