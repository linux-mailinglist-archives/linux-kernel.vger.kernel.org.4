Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0B868AD63
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 00:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjBDXRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 18:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBDXRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 18:17:08 -0500
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DBC19F16;
        Sat,  4 Feb 2023 15:17:07 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so10498042pjq.1;
        Sat, 04 Feb 2023 15:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCjib6YGp7oCe4br7XrH4tA0fTB0xh2BzncxrSSXIus=;
        b=Tq8L01qXQl2Y0sLgGBw49V2beSkReHvJSIj/L/TWWpLNLcOvtK7iuDRCUOxogCKyW9
         +EqFz7TOPpzgW2smELjgWqKNxGUVVMr1Ms8EMUoM7ytCyAFDaMxc4BlPBkv/kCOjKg96
         m1sG4jswYR6xB9no3xGptckzLF8IQUYZtxOebSxM8MM2HUugi0x5UEVxutLJQ4juZ1TC
         9WQt2jUmaMYzRmPVN3uSeszK2kS/TApkZQlu1N1g3CRbI3W+yN3kQl90nQ9lixigRHCu
         NXRcHP/FE6avumoEfd00IIyedDpWoLsokTTm5mFg2goBJwCc/OAWz/UfQBcQrM0Yd397
         Ec7Q==
X-Gm-Message-State: AO0yUKXloNLx7LmxBlF1UUWpBNapVkhLt6gdTh02FvC37S/6/itRouoW
        Q1s3esbP4+yXb0rNQ1x7obc=
X-Google-Smtp-Source: AK7set+1FvYxFJNsmodSe7ia7v6qf3RFt43H8C2JcL56/7ekAK7EZyR0rrWQUao+vJHlsv+vm3gn3g==
X-Received: by 2002:a05:6a20:3a96:b0:bf:ae32:5ea8 with SMTP id d22-20020a056a203a9600b000bfae325ea8mr9372685pzh.11.1675552626837;
        Sat, 04 Feb 2023 15:17:06 -0800 (PST)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090a1d4c00b0022c90b7e3efsm6963281pju.50.2023.02.04.15.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Feb 2023 15:17:05 -0800 (PST)
Message-ID: <3ad1c3b3-f54d-4b0e-2441-ab348d099f3f@acm.org>
Date:   Sat, 4 Feb 2023 15:17:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] trace/blktrace: fix memory leak with using
 debugfs_lookup()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-trace-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202141956.2299521-1-gregkh@linuxfoundation.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230202141956.2299521-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/23 06:19, Greg Kroah-Hartman wrote:
> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.  To make things simpler, just
> call debugfs_lookup_and_remove() instead which handles all of the logic
> at once.
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: linux-block@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-trace-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   kernel/trace/blktrace.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 918a7d12df8f..5743be559415 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -320,8 +320,8 @@ static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
>   	 * under 'q->debugfs_dir', thus lookup and remove them.
>   	 */
>   	if (!bt->dir) {
> -		debugfs_remove(debugfs_lookup("dropped", q->debugfs_dir));
> -		debugfs_remove(debugfs_lookup("msg", q->debugfs_dir));
> +		debugfs_lookup_and_remove("dropped", q->debugfs_dir);
> +		debugfs_lookup_and_remove("msg", q->debugfs_dir);
>   	} else {
>   		debugfs_remove(bt->dir);
>   	}

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
