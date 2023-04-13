Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E976E1294
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjDMQnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDMQn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:43:29 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0971E9026
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:43:29 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7603c5af4a9so10169639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681404208; x=1683996208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ekzkbuh/jPEC3nuF9C8mr0fHCUtO5IR37kdS+rbUHQ0=;
        b=em2V8aqYDszVx4fyS1cMSYnEKFMDrbnDUKEDSzJ1n9Hmo/3v1WyKF2xEdcr20SZYqU
         UvcTNPr2SDPMB30t2OlfIzAOGx8l9n1ydIOo6MbwzxweGVEC2JKPzc/af8LxpjvAeL6f
         J5fXqEzP3eCG8EdsTs5YyiHlW49JqYFOoViNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681404208; x=1683996208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ekzkbuh/jPEC3nuF9C8mr0fHCUtO5IR37kdS+rbUHQ0=;
        b=Tjk83aNbJGIXPY3n0OUfeouWbDBHSPWff//44tM/EElzB+HtVqCPzPdgdygFVHNIRX
         Gu66pcG847SRH6Bk8tUztb7ROvTL3gRLDh8XPNdOBl7+Iut0Lew1Msnv3QgRte3AwkH4
         eC9FyZbvwFE1Z7VqNOJYSTLMtTu53SGS+r/LTp+i39O6w7g3xl/rRXfpFNsAob3ApIId
         1xMcbuc4nMNdSn9EyIQk3PRGh1n78W6SLy4ruFUrWKxJphYmV7xx1RPXwQwgeMUSWVHk
         u0TQBQ745//DAPCf+ShGnUT7LNvcjaszmRa8j2gxVKLo/TdsD1dhxZZoV9LC53HphXcd
         Oj4Q==
X-Gm-Message-State: AAQBX9d83rrdvcgvRJxYFTPC7OLJXL81gobz6VhQNzq6T83tvTokK8vv
        pHjkIKWR3CdyGSMfk8dTku8hMg==
X-Google-Smtp-Source: AKy350ahqOvmt3EVe12Q3J5oRDw6HTbVCdu/GJ8L/g4aJbsI1DwT+xBaDo5eYovj/dDyI4BgSi7dxQ==
X-Received: by 2002:a05:6602:1496:b0:758:5653:353a with SMTP id a22-20020a056602149600b007585653353amr1349277iow.0.1681404208383;
        Thu, 13 Apr 2023 09:43:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v11-20020a02cbab000000b0040f019ae7a6sm583358jap.95.2023.04.13.09.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 09:43:27 -0700 (PDT)
Message-ID: <4ed23224-f418-3751-bf60-138a8b972d6c@linuxfoundation.org>
Date:   Thu, 13 Apr 2023 10:43:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] cpupower:Fix resource leaks in sysfs_get_enabled()
To:     Hao Zeng <zenghao@kylinos.cn>, trenn@suse.com, shuah@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230413044602.3221453-1-zenghao@kylinos.cn>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230413044602.3221453-1-zenghao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/23 22:46, Hao Zeng wrote:
> The sysfs_get_enabled() opened file processor not closed,
> may cause a file handle leak.
> 

Please add information how you found this problem?

> Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
> ---
>   tools/power/cpupower/lib/powercap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
> index 0ce29ee4c2e4..a39ee1c89679 100644
> --- a/tools/power/cpupower/lib/powercap.c
> +++ b/tools/power/cpupower/lib/powercap.c
> @@ -51,7 +51,7 @@ static int sysfs_get_enabled(char *path, int *mode)
>   		close(fd);
>   		return -1;
>   	}> -
> +	close(fd);

The error path logic can be simplified with a goto to
to handle the error path to close the file and return.

>   	if (yes_no == '1') {
>   		*mode = 1;
>   		return 0;

This path that returns 0 can be simplified as well to do
return just once, after error path handling is done with
a goto.

Please send me v2 with the changes above with information
on how you found the problem.

thanks,
-- Shuah

thanks,
-- Shuah
