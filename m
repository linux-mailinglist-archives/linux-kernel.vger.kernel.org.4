Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945FB6E2888
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjDNQlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjDNQli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:41:38 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF1A4EFF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:41:37 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-328990497e7so1044145ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681490496; x=1684082496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1KMGf0SzwXvFf5sUG5Xm6eIyrT5N7p2Kjq8aD/XELRY=;
        b=Ku10yB4Ku0lbno78QD/FX+Uj6db8NV/QLSRmVXjeViXwr4SgIBI6cZNuMPl5aQsAJN
         LAsULvH/+/tj65QDNJja0LoC4eES1CHJPe9B2MDQjsPtkIjJPub5QcHP0xrDwxuN2Gkd
         Iy+Vhn2qWPD54qDn6HDeUPVTc/QAaYw9I1RZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681490496; x=1684082496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KMGf0SzwXvFf5sUG5Xm6eIyrT5N7p2Kjq8aD/XELRY=;
        b=ZSCsbbnwZ5ByixNDG37wCT/i/Uc4Z7Fk7L8FGhtWe+r4VLqwC9SH/QvSxZjWjjnI48
         5IuIPujqACxFVnugbcW3BP5KmLAWszK3h2V2RGQ5hrvZeEffFOh9FIs65AS5IK+VqjaB
         +8wtqWCw5fTWcJkUEEGPXwZ7NtBwlEw4FVS23CbQiOABhh3LRgb1RrvZeipxf5JWIX92
         lZswbHMHpKAMxGZ3TyeRanfJHH8Kct9jaxd43NyAD2lrguO+M/qc0cV0YeErNLzC2fPj
         /rtoa98iwoli8iS+CEBUUepyPz8JQUVwG5Fx0t0pjQKA0/FszoIaYEMc51nVOGU5dp8l
         0sEg==
X-Gm-Message-State: AAQBX9fuaUP6sAAyEoGOO0lRiycihEy0Z56bxjpfjA3wE7uKuOY6AZGC
        /AqocVbnCCZimt2OluJi2bWTEw==
X-Google-Smtp-Source: AKy350YFoPwc0TzXcMOd6kW+eYPa3IaIbmv9ZNk6nEenRzBlPrOnRj9ZArc+SMmkbcZP0Vr1Bw5XBA==
X-Received: by 2002:a05:6602:2e83:b0:760:478f:e436 with SMTP id m3-20020a0566022e8300b00760478fe436mr1650922iow.2.1681490496504;
        Fri, 14 Apr 2023 09:41:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k12-20020a056638140c00b0040894c572basm1311968jad.125.2023.04.14.09.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 09:41:35 -0700 (PDT)
Message-ID: <4c04ae6d-f8db-0a2d-0bd5-97c4ec828a59@linuxfoundation.org>
Date:   Fri, 14 Apr 2023 10:41:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] cpupower:Fix resource leaks in sysfs_get_enabled()
To:     Hao Zeng <zenghao@kylinos.cn>
Cc:     trenn@suse.com, shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230414030830.3829332-1-zenghao@kylinos.cn>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230414030830.3829332-1-zenghao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/23 21:08, Hao Zeng wrote:
> When the read return value is equal to 1, a file handle leak will occur
> 

Would like a bit more information on how the error paths are
redone, since memory leak isn't the only one that is fixed.

> Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>   tools/power/cpupower/lib/powercap.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
> index 0ce29ee4c2e4..02ec5b0bff6b 100644
> --- a/tools/power/cpupower/lib/powercap.c
> +++ b/tools/power/cpupower/lib/powercap.c
> @@ -40,7 +40,7 @@ static int sysfs_get_enabled(char *path, int *mode)
>   {
>   	int fd;
>   	char yes_no;
> -
> +	int ret = 0;
>   	*mode = 0;
>   
>   	fd = open(path, O_RDONLY);
> @@ -48,17 +48,18 @@ static int sysfs_get_enabled(char *path, int *mode)
>   		return -1;
>   
>   	if (read(fd, &yes_no, 1) != 1) {
> -		close(fd);
> -		return -1;
> +		ret = -1;
> +		goto err;
>   	}
>   
> -	if (yes_no == '1') {
> -		*mode = 1;
> -		return 0;
> -	} else if (yes_no == '0') {
> -		return 0;
> +	if (yes_no != '1' || yes_no != '0') {
> +		ret = -1;
> +		goto err;
>   	}
> -	return -1;
> +	*mode = yes_no - '0';

I am not seeing much value in changing the above paths.
Leave them unchanged.

> +err:
> +	close(fd);
> +	return ret;
>   }
>   
>   int powercap_get_enabled(int *mode)

thanks,
-- Shuah
