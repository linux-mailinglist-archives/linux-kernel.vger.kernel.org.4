Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C796EE5A4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbjDYQXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbjDYQW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D178F2685
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682439732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wc3sq+wvLOMloVG0PPLLAe5aQ9YXWrAOIEnr/ok0Pnk=;
        b=hq9x/7YoUB69nAlzQclERkxFgu1cFWL2Fcr7wV8PFS2qBxregpONPM4KsWcVPnChKijG7V
        HM1UFSqENDsHRl6AnIQDU7nSwdL+EgqTZwv5QHtcQ/Fqj16pGmKggZkeiJnVn8BeEsfk63
        QJ5PdRaYRclpH9nTgb3xEJsi9qasJIQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-KpvS1w0JNb2aqi4ZU4GrbA-1; Tue, 25 Apr 2023 12:22:09 -0400
X-MC-Unique: KpvS1w0JNb2aqi4ZU4GrbA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-95836419a73so403416966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682439728; x=1685031728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wc3sq+wvLOMloVG0PPLLAe5aQ9YXWrAOIEnr/ok0Pnk=;
        b=Dw2eLaSrAybRNg60wSneYmKgNvFfhl4JClw0dwaqWSqy+g0Dd+A2xsE8HvIIhFTBgd
         yujLjoiEChFgCqCFiFr9SCAHNOVD5YSwz1Pp5simOhOowozZ/mfAsJekg6gemp5F7rdm
         pDmGjJjkqsV20EQi6wN8p25kJ9JSG8jWcewwpSaKVld60XFzQywsjC6SLOIXG8oMjqM2
         FaV9eXoOBIbM/JcjcjW4eFi0tgpLWer4NKKi9J7nl9BqKi7MchMr2rdXfnXhY2uYTdgn
         9a9a3LYZIrX27O7nogBWU/b0RUHhPzzT+YC5lm4gSme+dX/eOE+hsf969aXY75/P4j+f
         pNiA==
X-Gm-Message-State: AAQBX9eDZgjQV29JEAystDdU/M6pcaQNKsWyoFj+equbDD0KhbtMJ/L9
        gwCkA9V6gzBiL5ErKD3DjdHRru5euX8iQJDRgUsFbOZPaNaFU4ly0EYUCSLMuOMTSZgp4U3GRX5
        9pd4IzmSq+JrzDo4I+kNwIaxP
X-Received: by 2002:a17:907:3fa7:b0:94a:bd17:fc40 with SMTP id hr39-20020a1709073fa700b0094abd17fc40mr16489454ejc.25.1682439728454;
        Tue, 25 Apr 2023 09:22:08 -0700 (PDT)
X-Google-Smtp-Source: AKy350aw+Tc5PhsObeVGT8U6+glz+Pi2QAN665tMRHpHNQdGascSOpJW2sDjaPwyT0ZQHoczoBOshQ==
X-Received: by 2002:a17:907:3fa7:b0:94a:bd17:fc40 with SMTP id hr39-20020a1709073fa700b0094abd17fc40mr16489354ejc.25.1682439727017;
        Tue, 25 Apr 2023 09:22:07 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id vc14-20020a170907d08e00b00959c07bdbc8sm2095008ejc.100.2023.04.25.09.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 09:22:06 -0700 (PDT)
Message-ID: <d7abd814-3028-9f13-a5ea-eede9d90f72f@redhat.com>
Date:   Tue, 25 Apr 2023 18:22:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Return error on write
 frequency
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Wendy Wang <wendy.wang@intel.com>
References: <20230418153230.679094-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230418153230.679094-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/18/23 17:32, Srinivas Pandruvada wrote:
> Currently when the uncore_write() returns error, it is silently
> ignored. Return error to user space when uncore_write() fails.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> Tested-by: Wendy Wang <wendy.wang@intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Patches which are added to review-hans now are intended for
the next rc1. This branch will get rebased to the next rc1 when
it is out and after the rebasing the contents of review-hans
will be pushed to the platform-drivers-x86/for-next branch.

Regards,

Hans



> ---
> This patch has no dependency on TPMI patches for uncore support.
> 
>  .../x86/intel/uncore-frequency/uncore-frequency-common.c    | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
> index cb24de9e97dc..fa8f14c925ec 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
> @@ -44,14 +44,18 @@ static ssize_t store_min_max_freq_khz(struct uncore_data *data,
>  				      int min_max)
>  {
>  	unsigned int input;
> +	int ret;
>  
>  	if (kstrtouint(buf, 10, &input))
>  		return -EINVAL;
>  
>  	mutex_lock(&uncore_lock);
> -	uncore_write(data, input, min_max);
> +	ret = uncore_write(data, input, min_max);
>  	mutex_unlock(&uncore_lock);
>  
> +	if (ret)
> +		return ret;
> +
>  	return count;
>  }
>  

