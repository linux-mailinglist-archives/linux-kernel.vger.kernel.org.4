Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332B36F3CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 07:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjEBFE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 01:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBFEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 01:04:25 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047A026BE
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 22:04:24 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-94f1a6e66c9so654740466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 22:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683003862; x=1685595862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OgzyseyNKn3BAzeVNoQ1abk/qDCWOYAUTM6xsA6lH0o=;
        b=DMS8kvGTL995kuyJA2SVt23lzgvvz1qoCxJGKwNRoEQJER14EseZildENGgB8vxqUt
         aZYkrVrey+qm0Sj3M+EgavX1LhzyoMNamYCFiRN6Lpzm6mIH6LshB2+FmZm6bi612evs
         eERbGB3/+9Pt18BWWf+3OgNXtXggUsjVxJIwldo3ckjYdVDwvAssfSg3dtgobOdOlqjj
         sLa3PhODRZsSjbSPUwXxXKXVBUW/B/kIhguyXg9JgiE9RyX/vXdDzbIFegeU/YuAYN0g
         uyOg564lfmB9N/fKpvpO9snlZNKFBRNuBa5HQh/oxFisre9Z1pxWOEW8OJN6zdPHIx6m
         LL2A==
X-Gm-Message-State: AC+VfDwVdZRKC/3FoarZuMe6L7XJJhqNcbXZ+VDyrpBWpUvtJ+6ROQMe
        hsZ/G4sqaRw0u9IhBQUujfQ=
X-Google-Smtp-Source: ACHHUZ6wZnzq6dXCYVoFw+8hIHkZybSBetA1IHSVvgWlbKVgCw6Y10goZO9+kxg5BqoPe16lkczt7w==
X-Received: by 2002:a17:907:60d2:b0:95e:ce3b:a471 with SMTP id hv18-20020a17090760d200b0095ece3ba471mr14248178ejc.55.1683003862223;
        Mon, 01 May 2023 22:04:22 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id gv57-20020a1709072bf900b00960c27e4611sm5631398ejc.181.2023.05.01.22.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 22:04:21 -0700 (PDT)
Message-ID: <c8f74500-c383-b179-d1e6-71c231030a04@kernel.org>
Date:   Tue, 2 May 2023 07:04:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] tty: remove duplicate hung_up_tty_compat_ioctl()
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        linux-kernel@vger.kernel.org
References: <20230429203523.538756-1-arnd@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230429203523.538756-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29. 04. 23, 22:34, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The hung_up_tty_compat_ioctl() has been identical to hung_up_tty_ioctl()
> for a very long time, but now the only caller is inside of an #ifdef,
> causing a harmless warning:
> 
> drivers/tty/tty_io.c:446:13: error: 'hung_up_tty_compat_ioctl' defined but not used [-Werror=unused-function]
>    446 | static long hung_up_tty_compat_ioctl(struct file *file,
> 
> Avoid this by removing the function entirely and just using the native
> one in its place.
> 
> Fixes: 04f378b198da ("tty: BKL pushdown")
> Fixes: 4c87e9e5479b ("tty: tty_io: remove hung_up_tty_fops")
> Link: https://lore.kernel.org/all/2a07bded-25e5-fd27-a2de-8b606e4d1d2c@I-love.SAKURA.ne.jp/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>


> ---
> I did this patch to fix the build failure locally before I saw it
> was already under discussion. Sending it anyway in case nobody
> else has done a formal fix yet.
> ---
>   drivers/tty/tty_io.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 553182753098..31d465279b6c 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -443,12 +443,6 @@ static long hung_up_tty_ioctl(struct file *file, unsigned int cmd,
>   	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
>   }
>   
> -static long hung_up_tty_compat_ioctl(struct file *file,
> -				     unsigned int cmd, unsigned long arg)
> -{
> -	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
> -}
> -
>   static int hung_up_tty_fasync(int fd, struct file *file, int on)
>   {
>   	return -ENOTTY;
> @@ -2941,7 +2935,7 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
>   	}
>   
>   	if (tty_hung_up_p(file))
> -		return hung_up_tty_compat_ioctl(file, cmd, arg);
> +		return hung_up_tty_ioctl(file, cmd, arg);
>   	if (tty_paranoia_check(tty, file_inode(file), "tty_ioctl"))
>   		return -EINVAL;
>   
> @@ -2959,7 +2953,7 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
>   
>   	ld = tty_ldisc_ref_wait(tty);
>   	if (!ld)
> -		return hung_up_tty_compat_ioctl(file, cmd, arg);
> +		return hung_up_tty_ioctl(file, cmd, arg);
>   	if (ld->ops->compat_ioctl)
>   		retval = ld->ops->compat_ioctl(tty, cmd, arg);
>   	if (retval == -ENOIOCTLCMD && ld->ops->ioctl)

-- 
js
suse labs

