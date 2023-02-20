Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E312369CA4E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjBTLwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjBTLw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:52:28 -0500
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F63219F29;
        Mon, 20 Feb 2023 03:52:27 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id g1so3362847edz.7;
        Mon, 20 Feb 2023 03:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjRP498E4sH1+3FBp83kDkaYhCU3vFUEg4dl9mTy5go=;
        b=5BCGid+zqaaNdE+GnOYde50nqqDE+As5FLHjhp9fPISuxDSTt9ld7b/4krm2TDnG9d
         HRU4OyZdegeftWYSv4NSKPWrSt1Hbkt3uRCf+mDF5eGLTM5TYqpmYCFPy5ifx7zPT3mC
         Sd+ggKui7uH5dTVrn4/YVkS7Zs2Xt/XJs+W5KxFNJZ0aemNSnEVj0RExcYALc5T52L56
         c+4XnS4ZQy1m6oPECqRyVZkXAbzg4Oi6fswl3GKvu5TRMmUXP8yTR1Fl56tOF5nzRbBl
         4NvfzI6dl4ZVjffZECWgwEVf+oAxzVljfulE0ntKovpIpEeVp1+E0HbsrLpc+CqmgzHW
         N5iA==
X-Gm-Message-State: AO0yUKUqkSI9LI/iNK4kx+R3hA1nWgTbvbRkG2QMVDVir6NsuEzyCE64
        n+mtB5FJiFDOcWI2P0C5hCY=
X-Google-Smtp-Source: AK7set+wDePz4Z3uMccVbrEYrOO/RIzu4Hpb6kAT3W2dSSFOpGPqMvB64XFRBbaQaFAP0mHwd0hPGQ==
X-Received: by 2002:a17:906:ad82:b0:8b1:7eb4:6bea with SMTP id la2-20020a170906ad8200b008b17eb46beamr10203037ejb.38.1676893945715;
        Mon, 20 Feb 2023 03:52:25 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id kf21-20020a17090776d500b0084d3bf4498csm5784776ejc.140.2023.02.20.03.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 03:52:25 -0800 (PST)
Message-ID: <70ea8ee5-3f92-fe1c-c59d-74040bd1e610@kernel.org>
Date:   Mon, 20 Feb 2023 12:52:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] serial: jsm: Use min_t instead of min
Content-Language: en-US
To:     Mohammad Mahfooz <mohammadmahfoozpersonal@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>,
        linux-serial@vger.kernel.org
References: <20230219205316.3499-1-mohammadmahfoozpersonal@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230219205316.3499-1-mohammadmahfoozpersonal@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 02. 23, 21:53, Mohammad Mahfooz wrote:
> Use min_t instead of min to cut down n further if needed.
> 
> Signed-off-by: Mohammad Mahfooz <mohammadmahfoozpersonal@gmail.com>
> ---
>   drivers/tty/serial/jsm/jsm_neo.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
> index 0c78f66276cd..4cce1e423b06 100644
> --- a/drivers/tty/serial/jsm/jsm_neo.c
> +++ b/drivers/tty/serial/jsm/jsm_neo.c
> @@ -350,7 +350,7 @@ static void neo_copy_data_from_uart_to_queue(struct jsm_channel *ch)
>   		 * IBM pSeries platform.
>   		 * 15 bytes max appears to be the magic number.
>   		 */
> -		n = min((u32) n, (u32) 12);
> +		n = min_t(u32, n, 12);

Nah, why is "n" signed in the first place? Could you fix that and all 
all those casts in min()s around instead?

-- 
js
suse labs

