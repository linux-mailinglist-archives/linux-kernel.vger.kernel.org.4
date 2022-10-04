Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2745F4C4D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJDW60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJDW6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:58:22 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC6F32A94
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:58:20 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d10so14364905pfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 15:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=bI0zGpTZLBQJOOWB4CpiQ3wDraQSecms/2au9Z/d6Ps=;
        b=R0S3tntjc5TLxkXtK9o8yONdES+h8vz6uv76pIRrKRnJwi+O2AIu1zGl6ygMvSqUEi
         /hVcJ8iKZPJgl28LKnLJUvHjkefOjTtWlqPgmz8mymzg0vecdCMnX3IJQVewQ3osMHLD
         cQ4Wm1JLK1WNyF1A/GBW7LfxBQbWAWpXyfdhpiuoc/UFjrWlVMDRwzGkqa61NV3mik+w
         bJm7KhJi5Oulxzi1oDDno/zFk69vGLSjfbnMZ2A+11LcNH2nWDrQKUZfaW4QNwRWD1/e
         /wInF3SXdL8YeZCuINCd4wBpmqeIb3U3iLkXPjd3JOZBSsHNBFHxCBThDOHSRihxcp5z
         2QvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bI0zGpTZLBQJOOWB4CpiQ3wDraQSecms/2au9Z/d6Ps=;
        b=VJHPLm01kte93Vf+28yb/rUyhWhf6ndQ1ghmgae5UoZtPSxeYLg4fF56U65OxsoL9i
         xqCMEcl3Rd1C2uhz9WnOdtf6ZrzrVkykZDJqZCP0NrCMkwRS0iVwF0G8/kQVne8mOo0P
         cBaL5f6Q9qsvbVUsbZx//Y+O16yI5JplbFBP7CzPquE+HE2M0C/2/bpqs0Q0ThUTHlNG
         BC5D+KNmngEEf2IkyaDRAIRihgMxqFe641BK4ohEHaTHuuWWToiSZhW7vklyn3oUOuZA
         8N7qQQOvNZa49fb/aAh//7+SwXVxStuTDpB8BF6HcNandj1EeWnZyRzbG2SLYoGlMiBo
         AdpA==
X-Gm-Message-State: ACrzQf0HfKBvvTPp3PLWBTHOGsdFmSLrvn5UWCF4+EPoOZoZiESSSw58
        1UpR36K/ye55PXKbO/RO90mrrWZYSyTpYA==
X-Google-Smtp-Source: AMsMyM6JXaigRAqZEKMlG03o7/6XZ7DH+tmCJp/4HuGVvjpppRGn+F3xExppnI3ay/k69ueEr4vE5w==
X-Received: by 2002:a63:2bd4:0:b0:451:5df1:4b15 with SMTP id r203-20020a632bd4000000b004515df14b15mr8785014pgr.518.1664924299925;
        Tue, 04 Oct 2022 15:58:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jm10-20020a17090304ca00b0017b224969d6sm456205plb.76.2022.10.04.15.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 15:58:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 4 Oct 2022 15:58:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] debugobjects: Print object pointer in
 debug_print_object()
Message-ID: <20221004225817.GA2749300@roeck-us.net>
References: <20220519202201.2348343-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519202201.2348343-1-swboyd@chromium.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 01:22:01PM -0700, Stephen Boyd wrote:
> Delayed kobject debugging (CONFIG_DEBUG_KOBJECT_RELEASE) prints the
> kobject pointer that's being released in kobject_release() before
> scheduling a randomly delayed work to do the actual release work. If the
> caller of kobject_put() frees the kobject upon return then we'll
> typically see a debugobject warning about freeing an active timer.
> Usually the release function is the function that does the kfree() of
> the struct containing the kobject.
> 
> For example the following print is seen
> 
>  kobject: 'queue' (ffff888114236190): kobject_release, parent 0000000000000000 (delayed 1000)
>  ------------[ cut here ]------------
>  ODEBUG: free active (active state 0) object type: timer_list hint: kobject_delayed_cleanup+0x0/0x390
> 
> but we can't match up the kobject printk with the debug object printk
> because it could be any number of kobjects that was released around that
> time. The random delay for the work doesn't help either.
> 
> Print the address of the object being tracked to help us figure out
> which kobject is the problem here. Note that we don't use %px here to
> match the other %p usage in debugobject debugging. Due to %p usage we'll
> have to disable pointer hashing to correlate the two pointer printks.
> 
> Cc: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Did this patch get lost, or was it rejected ? I don't see a reply,
and it has not been applied.

FWIW:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> ---
>  lib/debugobjects.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index 6946f8e204e3..a1c987e967e0 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -503,9 +503,9 @@ static void debug_print_object(struct debug_obj *obj, char *msg)
>  			descr->debug_hint(obj->object) : NULL;
>  		limit++;
>  		WARN(1, KERN_ERR "ODEBUG: %s %s (active state %u) "
> -				 "object type: %s hint: %pS\n",
> +				 "object: %p object type: %s hint: %pS\n",
>  			msg, obj_states[obj->state], obj->astate,
> -			descr->name, hint);
> +			obj->object, descr->name, hint);
>  	}
>  	debug_objects_warnings++;
>  }
> 
> base-commit: ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2
> -- 
> https://chromeos.dev
> 
