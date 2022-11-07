Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D5761F0A1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiKGK37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiKGK3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:29:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609ACBC1B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667816935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0GKRHeT/hSkShGots+moeceaSZrmk8mLFZWP8W+tQNo=;
        b=UNDDwFkZHZSHqHXzDB8Ri1GI4EUSKnrhW4oJYMAcvA2Ru5Brfk8PCCH71cKgdKBuaE9+nk
        uZJj/PM5en9SeuGSO5GjraNFKKEc526f7Zyps18MnnUJ2rdjs/jeAp+HZ/1b0hGA55sYSg
        wnvv2nRvHAU1jfHcVARMVwsw7N1YH9Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-KNKyuAd8Nt-0TN4IhABCyg-1; Mon, 07 Nov 2022 05:28:54 -0500
X-MC-Unique: KNKyuAd8Nt-0TN4IhABCyg-1
Received: by mail-ej1-f70.google.com with SMTP id sg37-20020a170907a42500b007adaedb5ba2so6040476ejc.18
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 02:28:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GKRHeT/hSkShGots+moeceaSZrmk8mLFZWP8W+tQNo=;
        b=SKiHA0wK8CPlifYuGchqloaazJS1XeBORIJV0LURM1SbGlx6lI+zkBBVj9EPX1ty7D
         OveGadTSNYjA/u/kHVUe+EEfewjoHs9w0yI5qNypMxVq3wGrWEoX522Nx0Jn5P3ohqhO
         05QVPxPIJxcXX6lFU9NUnoGdkBjEH9QL+xyyH7ixnlG8lM/vTnBzb4/YbSZonwVn0XZV
         XPk/tcohClOc5hpt0LazAVHjDtpO6opcdeLglnW/kh4MziV+7B9GPAXHQumRP4OjWZJR
         TaQgftJ8oY3nWTQ0NmZ1x+QXMjzWkylCSLpkVbOjnU8umNEtiLXkiIYGGAE2xk8zEMHr
         M/wQ==
X-Gm-Message-State: ACrzQf0M24bbinXEL0nJmO4BqgS/sJbPrwA/+2udN5uA1mEY8qQOBNO7
        Y4lx9XkGoQ5Y9SUIoLmMKH5nyy4dALfpGHpl1TWvncjUrHQJzvBvUCYJTB3U4mjsRWr+Ws95XGe
        QcDkBMqgdkf7EvxhJzBVZzHua
X-Received: by 2002:a17:906:bceb:b0:7ae:75e:3929 with SMTP id op11-20020a170906bceb00b007ae075e3929mr25890148ejb.400.1667816932918;
        Mon, 07 Nov 2022 02:28:52 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6cN9WxsTv8pDFQdgYI7Us38X7mQ64h/3sPONJKcXBuo3KkIoh7qRxk071npAzvQZTZn50WCA==
X-Received: by 2002:a17:906:bceb:b0:7ae:75e:3929 with SMTP id op11-20020a170906bceb00b007ae075e3929mr25890136ejb.400.1667816932718;
        Mon, 07 Nov 2022 02:28:52 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id k18-20020a05640212d200b0044ef2ac2650sm3922664edx.90.2022.11.07.02.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 02:28:52 -0800 (PST)
Message-ID: <0910bcc4-d55f-6f3a-b2df-4e30d164aeeb@redhat.com>
Date:   Mon, 7 Nov 2022 11:28:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/1] platform/x86/amd: Fix pmc compile dependency errors.
Content-Language: en-US
To:     Yupeng Li <liyupeng@zbhlos.com>, Shyam-sundar.S-k@amd.com,
        markgross@kernel.org,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        caizp2008@163.com
References: <20221026072531.346013-1-liyupeng@zbhlos.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221026072531.346013-1-liyupeng@zbhlos.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/26/22 09:25, Yupeng Li wrote:
> When disabled CONFIG_SUSPEND and CONFIG_DEBUG_FS, get_metrics_table
> and amd_pmc_idlemask_read is defined under two conditions of this,
> pmc build with implicit declaration of function error.Some build error
> messages are as follows:
> 
>  CC [M]  drivers/platform/x86/amd/pmc.o
> drivers/platform/x86/amd/pmc.c: In function ‘smu_fw_info_show’:
> drivers/platform/x86/amd/pmc.c:436:6: error: implicit declaration of function ‘get_metrics_table’ [-Werror=implicit-function-declaration]
>   436 |  if (get_metrics_table(dev, &table))
>       |      ^~~~~~~~~~~~~~~~~
> drivers/platform/x86/amd/pmc.c: In function ‘amd_pmc_idlemask_show’:
> drivers/platform/x86/amd/pmc.c:508:8: error: implicit declaration of function ‘amd_pmc_idlemask_read’; did you mean ‘amd_pmc_idlemask_show’? [-Werror=implicit-function-declaration]
>   508 |   rc = amd_pmc_idlemask_read(dev, NULL, s);
>       |        ^~~~~~~~~~~~~~~~~~~~~
>       |        amd_pmc_idlemask_show
> cc1: some warnings being treated as errors
> 
> Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>
> Reviewed-by: Caicai <caizp2008@163.com>

Thank you for your patch, however I do not believe that this is the correct fix:

> ---
>  drivers/platform/x86/amd/pmc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
> index ce859b300712..2b08039921b8 100644
> --- a/drivers/platform/x86/amd/pmc.c
> +++ b/drivers/platform/x86/amd/pmc.c
> @@ -433,8 +433,10 @@ static int smu_fw_info_show(struct seq_file *s, void *unused)
>  	struct smu_metrics table;
>  	int idx;
>  
> +#if defined(CONFIG_SUSPEND) || defined(CONFIG_DEBUG_FS)
>  	if (get_metrics_table(dev, &table))
>  		return -EINVAL;
> +#endif
>  
>  	seq_puts(s, "\n=== SMU Statistics ===\n");
>  	seq_printf(s, "Table Version: %d\n", table.table_version);

The table variable gets used here, but now it no longer has been initialized by
get_metrics_table() so just #ifdef-ing out the get_metrics_table() call is wrong.

> @@ -503,11 +505,12 @@ static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
>  		if (rc)
>  			return rc;
>  	}
> -
>  	if (dev->major > 56 || (dev->major >= 55 && dev->minor >= 37)) {
> +#if defined(CONFIG_SUSPEND) || defined(CONFIG_DEBUG_FS)
>  		rc = amd_pmc_idlemask_read(dev, NULL, s);
>  		if (rc)
>  			return rc;
> +#endif
>  	} else {
>  		seq_puts(s, "Unsupported SMU version for Idlemask\n");
>  	}

Same thing except now nothing gets send to the struct seq_file *s,
so this is wrong too.

Shyam / Mario, can you take a look at the reported compile errors please?

Regards,

Hans

