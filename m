Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A863668E7DC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 06:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjBHFsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 00:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBHFsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 00:48:15 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35F511EAF;
        Tue,  7 Feb 2023 21:48:14 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id lu11so48546997ejb.3;
        Tue, 07 Feb 2023 21:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYe6aqMu2x9+vN3yhcrZtZHWGal5Z5H51jOu9lqDUVU=;
        b=e+SKcUC8SeP4FEi2kVPT6is6VGew+DGNvXL+BEFIzRqkCb9loj23DYuczkt+UERuhU
         8ErJoFs/4ZpejYECX1MGpTfm2Rf2mwbZVcW+ah1mSCdD+6XggRsBLAojgZYcrDQ6PF1L
         Dvgk59kKA7l+wAR8uEsxHM0Bbds8DQIBzeQoJjubnFuNRBm9HdqKzdPU8HygCMhiMXIW
         ucCqb3d2WJxXyQYSSjw5KgOKL3db3qKM/ZMtqyWlhZHfyhHAgvQ+tbtg3LBVjp52TFWA
         W3pQpMpX1Ple95zHk3NiWn4hVSMrE+fJtvrQbFtU/GL/tdgLDwp2L6yfyqaKfWyb/oNC
         GGzw==
X-Gm-Message-State: AO0yUKVOHAeuScJE69bJC3fvcdKu+w6EuMMrJqtix9Vpzt/knvMxhYXI
        qohVU79qQMKITGVUPSktYYnO4powCMc=
X-Google-Smtp-Source: AK7set+cVv7jF6uzVc/ZvERg4iwXP/HeLZJ/9NGLwUoVvhZz4KwIR8Avr3Yb5rdYLPJ16Yni/J+dNw==
X-Received: by 2002:a17:906:1252:b0:889:7781:f62e with SMTP id u18-20020a170906125200b008897781f62emr6344857eja.22.1675835292979;
        Tue, 07 Feb 2023 21:48:12 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id s24-20020a1709060c1800b0088a0d645a5asm7906972ejf.99.2023.02.07.21.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 21:48:12 -0800 (PST)
Message-ID: <8dffe187-240d-746e-ed84-885ffd2785f6@kernel.org>
Date:   Wed, 8 Feb 2023 06:48:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] vc_screen: break from vcs_read() while loop if
 vcs_vc() returns NULL
Content-Language: en-US
To:     George Kennedy <george.kennedy@oracle.com>,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Cc:     sfr@canb.auug.org.au, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <1675774098-17722-1-git-send-email-george.kennedy@oracle.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <1675774098-17722-1-git-send-email-george.kennedy@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 02. 23, 13:48, George Kennedy wrote:
> If vcs_vc() returns NULL in vcs_read(), break from while loop if partial
> read, else if no reads have been done, go to unlock_out and return -ENXIO.
> In addition, change the goto unlock_out after vcs_size() to a break
> to conform to the break handling after vcs_vc().
> 
> Fixes: ac751efa6a0d ("console: rename acquire/release_console_sem() to console_lock/unlock()")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> ---
>   drivers/tty/vt/vc_screen.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
> index f566eb1839dc..c599b452969f 100644
> --- a/drivers/tty/vt/vc_screen.c
> +++ b/drivers/tty/vt/vc_screen.c
> @@ -406,19 +406,17 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>   		ret = -ENXIO;
>   		vc = vcs_vc(inode, &viewed);
>   		if (!vc)
> -			goto unlock_out;
> +			break;
>   
>   		/* Check whether we are above size each round,
>   		 * as copy_to_user at the end of this loop
>   		 * could sleep.
>   		 */
> -		size = vcs_size(vc, attr, uni_mode);
> -		if (size < 0) {
> -			if (read)
> -				break;
> -			ret = size;
> -			goto unlock_out;
> -		}
> +		ret = vcs_size(vc, attr, uni_mode);
> +		if (ret < 0)
> +			break;
> +		size = ret;
> +		ret = 0;

I think the previous "size = vcs_size()" and "ret = size" in the error 
path looked better than this "size = ret" and "ret = 0" here. I mean why 
not to preserve:

	size = vcs_size(vc, attr, uni_mode);
	if (size < 0) {
		ret = size;
		break;
	}

?

thanks,
-- 
js
suse labs

