Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600F270854F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjERPtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjERPtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:49:12 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779EF194
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:49:09 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f4fc2a4622so12743661cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684424948; x=1687016948;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9K3/dcfFhDlfOWF8AkzlrJ8hrxfd6jNyjEB/GmUE5Q=;
        b=YfTn2g43JVOGPLwFFhKdK2bacXhwDh/DAdp8+QJJR+ZHfTJWN4huXk9JSzsDnaIZ1W
         fgztgmaNiYfoxyguskt5F/bEXPM3jRitCaEZCtEKuptATfSTmZ1BPm97oB2O9ychg9p/
         kNVOhhvksDL/pFYmNVObFTgcerxfBohxuoqiveauCgSTo/7gAhvumCX+geIMZ7hD0NxJ
         +oWdxfhw4F5dwswstiywCjJ5Mvv4mCNYHOIeCX1KBcziHh18SvR0sisBj74eMMDvWW+h
         JQ4Fkqk6HLIWeCnQs//1RyY1q9fwt5+ssua5AvRr4jb3xlwdVTfE93BET3hhW7rmGC31
         OOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684424948; x=1687016948;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W9K3/dcfFhDlfOWF8AkzlrJ8hrxfd6jNyjEB/GmUE5Q=;
        b=WG2UJypN8Kk+xbTx+wHQlBOKECua9C2wJdk6VR8draMDkaSpoRChAszrBylVHSvz5P
         5MhZG20roKUQARy4ibsfr/Yf0Mc7Udt1HPq5fwI1TkJtna0BPVBhJrF0ic3H203u+wzi
         1j5LFhW/6Bof7tgP4f8plSucW9lCTOtgCqwnpmhqd0P0B1QIccM7x7DF3qsbiJ9oYETx
         UI4Lx4gK/IsTHd616fXEAJrqewfuCYfHvhDyNusrFehj28FeLRNHgF/zkSAhw4dMxiiJ
         i1B+wzmTu7zWx2eYDW9g04URSh73KI0oZuKbrk4iBN9ZGVKFTHCOzvDc7aH6NRA1i4zV
         FbKw==
X-Gm-Message-State: AC+VfDy4bu0k03Ok4MtUGKlAmnQFA3OV5LjXr5VvJI+3IKKG2UpF43hB
        l5nRGtSjZwS/pQ1vxVhycw==
X-Google-Smtp-Source: ACHHUZ4N8VCB5dzCwyT9oJkzaWVOkoXAy5WTOrLHGtdGgIyJBPzbJ/dGs32bnXEi5d/+Svmq7WxFxg==
X-Received: by 2002:a05:622a:312:b0:3f0:a108:8630 with SMTP id q18-20020a05622a031200b003f0a1088630mr163505qtw.39.1684424948287;
        Thu, 18 May 2023 08:49:08 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id o9-20020a05620a110900b0074dfd9283afsm472565qkk.79.2023.05.18.08.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 08:49:07 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:9fd5:7d6d:b75c:c88d])
        by serve.minyard.net (Postfix) with ESMTPSA id EC4EF1800B8;
        Thu, 18 May 2023 15:49:05 +0000 (UTC)
Date:   Thu, 18 May 2023 10:49:04 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Yu Chen <chen.yu@easystack.cn>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: Avoid 100% CPU usage during reading watchdog
 when a task get signal
Message-ID: <ZGZI8Mdb7eoq9VCE@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20230515121941.59859-1-chen.yu@easystack.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515121941.59859-1-chen.yu@easystack.cn>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 05:19:41AM -0700, Yu Chen wrote:
> A simple reproducer demonstrating the problem: (use ipmi_watchdog.ko)
> 
> In one terminal:
> 
> $ cat /dev/watchdog
> ...
> 
> In another terminal:
> 
> $ ps -aux | grep cat
> 14755 pts/1    R+    43:00 cat /dev/watchdog
> 51943 pts/2    S+     0:00 grep --color=auto cat
> 
> $ kill -9 14755
> $
> $ cat /proc/14755/status | grep SigPnd
> SigPnd: 0000000000000100
> $
> $ top
> 
> Tasks: 1049 total,   2 running, 1047 sleeping,   0 stopped,   0 zombie
> %Cpu(s): 0.0 us, 1.0 sy, 0.0 ni, 98.9 id, 0.0 wa, 0.0 hi, 0.0 si, 0.0 st
> MiB Mem : 522594.8 total, 517241.4 free,  2922.1 used,   2431.2 buff/cache
> MiB Swap:      0.0 total,      0.0 free,     0.0 used. 516589.2 avail Mem
> 
> PID USER    PR  NI    VIRT    RES    SHR S  %CPU  %MEM  TIME+ COMMAND
> 14755 root  20   0  215552   1024    576 R 100.0  0.0  0:15.12 cat
> 53417 root  20   0  224960   7040   3648 R   0.7  0.0  0:00.10 top
> 11 root     20   0       0      0      0 I   0.3  0.0  0:02.85 rcu_sched
> 1772 root   20   0  512256 387776 380800 S   0.3  0.1  0:32.05 python
> 
> We can see that when the cat process gets the signal, the CPU usage
> is 100%, Since signal_pending is true, the pick_next_task function
> in schedule always returns itself, it retries schedule indefinitely.
> ipmi_read() will busyloop.
> 
> Signed-off-by: Yu Chen <chen.yu@easystack.cn>
> ---
>  drivers/char/ipmi/ipmi_watchdog.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
> index 0d4a8dcac..173ed4266 100644
> --- a/drivers/char/ipmi/ipmi_watchdog.c
> +++ b/drivers/char/ipmi/ipmi_watchdog.c
> @@ -803,6 +803,11 @@ static ssize_t ipmi_read(struct file *file,
>  		init_waitqueue_entry(&wait, current);
>  		add_wait_queue(&read_q, &wait);
>  		while (!data_to_read) {
> +			if (signal_pending(current)) {
> +				remove_wait_queue(&read_q, &wait);
> +				rv = -ERESTARTSYS;
> +				goto out;
> +			}

This skips the call to remove_from_wait_queue(), which is bad.  I
already have a fix for this from someone else.

-corey

>  			set_current_state(TASK_INTERRUPTIBLE);
>  			spin_unlock_irq(&ipmi_read_lock);
>  			schedule();
> @@ -810,10 +815,6 @@ static ssize_t ipmi_read(struct file *file,
>  		}
>  		remove_wait_queue(&read_q, &wait);
>  
> -		if (signal_pending(current)) {
> -			rv = -ERESTARTSYS;
> -			goto out;
> -		}
>  	}
>  	data_to_read = 0;
>  
> -- 
> 2.27.0
> 
