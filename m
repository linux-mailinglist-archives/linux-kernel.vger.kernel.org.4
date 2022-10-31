Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E036131C1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiJaIey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJaIev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:34:51 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CA65FDD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:34:50 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id j15so14898860wrq.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBpYw5hM1LXIqvvaSMOXxY2X0Rxx3iDl+/6c5V3MbsE=;
        b=tZBnCnJLc+g2Bt30cba4dd3vjN6vzgub12Tb4/EqB9WBvQl7pFjnU+bA2iM21i7Q6K
         5S6DcIu21a/y0/Spfobh70t0Em4ys3svVkvtednm6KEdgiARJMs7Typm24/qM33bCZjI
         +BCFBeoXPJNPTfdxba2R5yjPINj5XxSod+07pHxlNvL/cW2OPIDLPbz7VMncioza2wDf
         OltgYacplD1h/nK9mX5yfxtWmQniTZPd3o4ju7NYTZeqLwDvtTYHQ3WS26jLpUCRFkne
         A0OOudTI6IyOgi7hj4iOZFr2+dngQyDUbnhwOqEVjRBVXBSVRNtJKGmoyFrI+lXpE0rX
         wliw==
X-Gm-Message-State: ACrzQf1hKmoYDWVAe7aEuEZqcktMJF0KJ6GMUDLOYvpWSnaLZ+lf1xRw
        SX6otOi3u7ber668rpWB1ordVIObHZk265NW
X-Google-Smtp-Source: AMsMyM6V8vx3NrObv5+5Sf/e7yIjKU7D9jDzgliPNKecxvkbq1cNLSbmpVzyHgpVPucltil+sysBpg==
X-Received: by 2002:a5d:5111:0:b0:235:849f:f132 with SMTP id s17-20020a5d5111000000b00235849ff132mr7294190wrt.5.1667205288608;
        Mon, 31 Oct 2022 01:34:48 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c35ca00b003c6f1732f65sm4127185wmq.38.2022.10.31.01.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 01:34:48 -0700 (PDT)
Message-ID: <36a08c1a-b675-84ec-ce08-2ada7223bd33@kernel.org>
Date:   Mon, 31 Oct 2022 09:34:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC][PATCH v2 26/31] timers: tty: Use del_timer_shutdown()
 before freeing timer
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20221027150525.753064657@goodmis.org>
 <20221027150930.128814334@goodmis.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221027150930.128814334@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27. 10. 22, 17:05, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Before a timer is freed, del_timer_shutdown() must be called.
> 
> Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/n_gsm.c | 2 +-
>   drivers/tty/sysrq.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 5e516f5cac5a..1d167469a700 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2098,7 +2098,7 @@ static void gsm_dlci_free(struct tty_port *port)
>   {
>   	struct gsm_dlci *dlci = container_of(port, struct gsm_dlci, port);
>   
> -	del_timer_sync(&dlci->t1);
> +	del_timer_shutdown(&dlci->t1);
>   	dlci->gsm->dlci[dlci->addr] = NULL;
>   	kfifo_free(&dlci->fifo);
>   	while ((dlci->skb = skb_dequeue(&dlci->skb_list)))
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index d2b2720db6ca..20b1c9802506 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -1003,7 +1003,7 @@ static void sysrq_disconnect(struct input_handle *handle)
>   
>   	input_close_device(handle);
>   	cancel_work_sync(&sysrq->reinject_work);
> -	del_timer_sync(&sysrq->keyreset_timer);
> +	del_timer_shutdown(&sysrq->keyreset_timer);
>   	input_unregister_handle(handle);
>   	kfree(sysrq);
>   }

thanks,
-- 
js
suse labs

