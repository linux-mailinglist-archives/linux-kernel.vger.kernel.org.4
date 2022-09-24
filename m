Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E446F5E8BCA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 13:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbiIXLfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 07:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiIXLfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:35:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D3FB07FA
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 04:35:05 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q3so2299302pjg.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 04:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Gx/FQtFTqYmzzoN9qGe/lZfi0RB4xJYgv3lGJHhqdAg=;
        b=AymzzdveXmqvDMFk61n/oxIAIindYvGyswP9C2fAwvYgL/fDBZI7qL4O7/zSeaNkCp
         2V3oa4f/GMSxnS5SMdAiu05FJ6OmXikAI35GV2iFOxPBAff/ZjYpKY7bhHbwk3BfV9sd
         Q1UlfRKb8kGtonl4bfSH+8DMmxcgKN1nHqAxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Gx/FQtFTqYmzzoN9qGe/lZfi0RB4xJYgv3lGJHhqdAg=;
        b=GmDbFwKTi4a1f/HX2R5u0bMrXiILLmLPeMjLe/F8+jmHdP93775NUxrpDRX20Vn5v4
         BHz+sK9NsSprO41AepM5OW/tC1Onf0VKmX79MSXqt+zxn9geXPbCoj+sIHkE+kR1w2ey
         aktO68TS4F1GLs7akid/AKDzHs4o4Kc4mvkraYlJwH092SUWGv+3qjacK+gfdp83phMN
         6s20FNbcNbmUskAifugmSr0VSMo4yevAv8luDtzRCbWxhhvnQYe0Epx+c2S3X98BLE69
         WDE6WDBD4I8+SlCQIkBrcxTthiMYuVynMw7nzLswJeNfJpNtkCA8F4bqz2NLuK19p38s
         zLLg==
X-Gm-Message-State: ACrzQf3tS0wSqq5SipoL01dd107i2fpusZYcu5v8z9IeEbo7Y1OaGHnx
        ysc6+0k+cnQ41zdKcueNngtHIg==
X-Google-Smtp-Source: AMsMyM6fZ3xs4WcbCVNECCSf5NcKaqaZLXtdmmuwYCdHM0MoQqcaSKf80FPeJwdY0OkjdWM6aHXwrg==
X-Received: by 2002:a17:90b:4a89:b0:202:d56e:e202 with SMTP id lp9-20020a17090b4a8900b00202d56ee202mr14182172pjb.22.1664019305517;
        Sat, 24 Sep 2022 04:35:05 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f4de:2419:efa3:8fed])
        by smtp.gmail.com with ESMTPSA id o90-20020a17090a0a6300b002001c9bf22esm3206388pjo.8.2022.09.24.04.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 04:35:04 -0700 (PDT)
Date:   Sat, 24 Sep 2022 20:34:59 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 16/18] printk: Use struct cons_text_buf
Message-ID: <Yy7rY+T7CNW0zwll@google.com>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-17-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-17-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/24 02:10), John Ogness wrote:
> Date: Sat, 24 Sep 2022 02:10:52 +0206
> From: John Ogness <john.ogness@linutronix.de>
> To: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
>  <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
>  linux-kernel@vger.kernel.org
> Subject: [PATCH printk 16/18] printk: Use struct cons_text_buf
> Message-Id: <20220924000454.3319186-17-john.ogness@linutronix.de>
> 
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Replace the separately allocated output buffers with a single instance of
> struct cons_text_buf.
> 
> Note that the buffer size of devkmsg_user.text_buf, when replaced with
> cons_text_buf.text, reduces from CONSOLE_EXT_LOG_MAX to CONSOLE_LOG_MAX.
> However, the buffer is only used to read ringbuffer records, which have
> a maximum size of LOG_LINE_MAX (CONSOLE_LOG_MAX - PREFIX_MAX).
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

[..]
> @@ -2765,7 +2766,7 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
>  	console_lock_spinning_enable();
>  
>  	stop_critical_timings();	/* don't trace print latency */
> -	call_console_driver(con, write_text, len, dropped_text);

+	/* Extended consoles do not print "dropped messages". */  perhaps?

> +	call_console_driver(con, write_text, len, extmsg ? NULL : txtbuf->dropped_text);
