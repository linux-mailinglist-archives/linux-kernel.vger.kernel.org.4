Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8A86D4108
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjDCJpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjDCJpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:45:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E97D11653
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680515015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Nw8RQOwzXx7j209w1MoiZoGhjBw50UbeNbp6+/Psis=;
        b=Y5VNXsVuZGOTO2ze43D/OkMEt+OG4NNgwhz2fRuQnOv3dBk0ktfXCg9Kq4GQ4CQlHqA9Wf
        yywppET71SJi/9IAoZl+a3Fp+dYvAA6sQL/Hant4OIB3TYtjMgVpq+CINPm5w2iKVGXzz6
        5A6GNIOD9DDzpF4A0sQUqxy70B0QUY4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-LcA4BJrPMiO3_k5at9p3bw-1; Mon, 03 Apr 2023 05:43:34 -0400
X-MC-Unique: LcA4BJrPMiO3_k5at9p3bw-1
Received: by mail-ed1-f70.google.com with SMTP id b6-20020a509f06000000b005029d95390aso3878144edf.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680515013;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Nw8RQOwzXx7j209w1MoiZoGhjBw50UbeNbp6+/Psis=;
        b=Yi+gP9AtXIgGvYmpExVFE0L5jqNolX0ieoWhk3Ks9BsPRBPc0t+nq+gDu9Dwi5nHBu
         8797FN2PUsGMA7U0cFOL1oOjSETlHguV/mvyb4uROGtG7+aMbDOKComrBji2B8QMUxQl
         yGBnyNFL2JW+bD77nLeSD0EH7irhjhbx1E1l60QmVLdCmqyUB8FhQp6+aq5j8REpSNFA
         q151Vbfzei+LkQQsz2k3EzqrixSKm+3T0q8EjSNZscnqTQOsBG6KbQc7SK85c0/APi/T
         lVHrHNjmf0ApVc1GVx0rUSZhG4ZAjZWeoExuusJ1YjLmpRH5x9zGbTDkSUOKy1afihpQ
         z1AA==
X-Gm-Message-State: AAQBX9cXjW7JBx/u0RYpwA+CsyWGMviTv5H0WU7XbqHe0ZpQ28oLWEfF
        lsqJV9e26IP76UKug6vzFTC6VqxQnxO4NOFA4ABD2TFwd8np6+aE+cw9Op/7VmbWxjNZeehKXzk
        /CmlqmyFke0OnctHmx7c2S8mJ
X-Received: by 2002:a17:906:ae96:b0:93b:1c78:5796 with SMTP id md22-20020a170906ae9600b0093b1c785796mr34009199ejb.43.1680515013233;
        Mon, 03 Apr 2023 02:43:33 -0700 (PDT)
X-Google-Smtp-Source: AKy350aCjSpFEG4yIY7UXk7+qX6baIEI/sKcZYyV35iTQt4Vrj8T/cMExE6jBz9NaDi45Z+PjXodjQ==
X-Received: by 2002:a17:906:ae96:b0:93b:1c78:5796 with SMTP id md22-20020a170906ae9600b0093b1c785796mr34009185ejb.43.1680515012982;
        Mon, 03 Apr 2023 02:43:32 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id oq26-20020a170906cc9a00b009318ad4a583sm4279505ejb.210.2023.04.03.02.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 02:43:32 -0700 (PDT)
Message-ID: <ad7cd0bc-b451-f4b5-c4ed-620b4298c2e1@redhat.com>
Date:   Mon, 3 Apr 2023 11:43:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/2] platform/x86: think-lmi: Fix memory leaks when
 parsing ThinkStation WMI strings
Content-Language: en-US, nl
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     markgross@kernel.org, W_Armin@gmx.de,
        mirsad.todorovac@alu.unizg.hr, linux@weissschuh.net,
        Mario.Limonciello@amd.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20230403013120.2105-1-mpearson-lenovo@squebb.ca>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230403013120.2105-1-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/3/23 03:31, Mark Pearson wrote:
> My previous commit introduced a memory leak where the item allocated
> from tlmi_setting was not freed.
> This commit also renames it to avoid confusion with the similarly name
> variable in the same function.
> 
> Fixes: 8a02d70679fc ("platform/x86: think-lmi: Add possible_values for ThinkStation")
> Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> Link: https://lore.kernel.org/lkml/df26ff45-8933-f2b3-25f4-6ee51ccda7d8@gmx.de/T/
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
> This patch series builds on top of the proposed patch from Armin Wolf
> "platform/x86: think-lmi: Fix memory leak when showing current settings"
> Changes in v2: None, but rebased series because of issues with second
> patch.

Thank you for your patch series, I've applied this series
to my fixes branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this series in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans




> 
>  drivers/platform/x86/think-lmi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 6034df6d577d..87f832142d8d 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -1459,10 +1459,10 @@ static int tlmi_analyze(void)
>  			 * name string.
>  			 * Try and pull that out if it's available.
>  			 */
> -			char *item, *optstart, *optend;
> +			char *optitem, *optstart, *optend;
>  
> -			if (!tlmi_setting(setting->index, &item, LENOVO_BIOS_SETTING_GUID)) {
> -				optstart = strstr(item, "[Optional:");
> +			if (!tlmi_setting(setting->index, &optitem, LENOVO_BIOS_SETTING_GUID)) {
> +				optstart = strstr(optitem, "[Optional:");
>  				if (optstart) {
>  					optstart += strlen("[Optional:");
>  					optend = strstr(optstart, "]");
> @@ -1471,6 +1471,7 @@ static int tlmi_analyze(void)
>  							kstrndup(optstart, optend - optstart,
>  									GFP_KERNEL);
>  				}
> +				kfree(optitem);
>  			}
>  		}
>  		/*

