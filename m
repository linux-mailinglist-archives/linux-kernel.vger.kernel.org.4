Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5936F60FBB7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbiJ0PV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbiJ0PU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:20:56 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB35140561
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:20:18 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id i12so1590636qvs.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oriThv321w8lPnb3xddFybxmYLENHvizLP5o3nY/0YM=;
        b=gTWIQ7ctBlXRLUIbSkwdkDCB2qrZPuamRL7bNce2kS2zOeui+831nB8uhfq25PKF4s
         Skz6TM+xoPoUubk+7LqRB06IVKMCplmBDwgjI5fIRC2wYs1RiFJbcvJgSJqbl/IGxsO8
         ydOD9K3kePbACyx4xL43/8uJfvh4OuvPyfPNeGcmcIAJ+Zb+W6QJ1CE7+tJ1hA6Q7oWl
         ARJ30zskV8n5wbK4c3x2HqnBYGnXvHUXTGhNFNvvMUycrBFkavoVaIXT0N1wbz96rELG
         0TlDMfR2exqclL6HpjgmWl2Wo2c7DMqyboILWPfs/ZQhBoH0Um1GYet463qXk+ijE5Lv
         +P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oriThv321w8lPnb3xddFybxmYLENHvizLP5o3nY/0YM=;
        b=nH7An3IVAHU97LgbSlKXBsG4xVeVcoZloUzPp2znd51dGePpSfeM4n1PUK/0XRKM/J
         nJJruWE+iIX2lhxO41Y5a2kO6+UHk9gxvJ0+lzDAZgmiKLOvl+VJhReE4ZEgdT8QzheU
         N2qQcJzW7B/vEY+u+nBNXsoFeIx9Y4uESbxR7ZJA1HAds7ONavlcWwXu/mCRKZ/quG10
         BpCfFH8waHADBRoRso+3LVAo/HJqojJ84ODvb3K+ZWGs9d3n34Vj26GxXOr+0vkTnrKq
         R5WAfev+X1HXSN4HBX3AdR62/0BZU1MsvKjHPNiu+hkqFtQtprK1o1HNloSID1gFCwmS
         bdQg==
X-Gm-Message-State: ACrzQf2782oYXsjVOxxWcCPE/iVashu4kA0NeHbsRK2gIx63QaEERtTz
        dH8r4hJAL6bs70sCesKBjw==
X-Google-Smtp-Source: AMsMyM7ZnaPKO/FedFG52KsDtlBOAgMRKpNa3l4sz0GIZrwDaRK51rXaD5BKU0dIKnwUovGvkv4x+g==
X-Received: by 2002:a0c:dd13:0:b0:4bb:664c:5aaa with SMTP id u19-20020a0cdd13000000b004bb664c5aaamr20965178qvk.121.1666884017635;
        Thu, 27 Oct 2022 08:20:17 -0700 (PDT)
Received: from serve.minyard.net ([47.184.147.45])
        by smtp.gmail.com with ESMTPSA id r12-20020ae9d60c000000b006f9f3c0c63csm985977qkk.32.2022.10.27.08.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 08:20:17 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:2cd9:e696:a60f:3003])
        by serve.minyard.net (Postfix) with ESMTPSA id A88A31800BD;
        Thu, 27 Oct 2022 15:20:15 +0000 (UTC)
Date:   Thu, 27 Oct 2022 10:20:14 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        openipmi-developer@lists.sourceforge.net
Subject: Re: [RFC][PATCH v2 10/31] timers: ipmi: Use del_timer_shutdown()
 before freeing timer
Message-ID: <Y1qhrqfF87gnyiCE@minyard.net>
Reply-To: minyard@acm.org
References: <20221027150525.753064657@goodmis.org>
 <20221027150926.969147187@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027150926.969147187@goodmis.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:05:35AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Before a timer is freed, del_timer_shutdown() must be called.

Thanks, this is in my queue, or:

Acked-by: Corey Minyard <cminyard@mvista.com>

if you prefer that.

-corey

> 
> Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/
> 
> Cc: Corey Minyard <minyard@acm.org>
> Cc: openipmi-developer@lists.sourceforge.net
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 2 +-
>  drivers/char/ipmi/ipmi_ssif.c       | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 49a1707693c9..b577f66f3ca6 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -5540,7 +5540,7 @@ static void __exit cleanup_ipmi(void)
>  		 * here.
>  		 */
>  		atomic_set(&stop_operation, 1);
> -		del_timer_sync(&ipmi_timer);
> +		del_timer_shutdown(&ipmi_timer);
>  
>  		initialized = false;
>  
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index e1072809fe31..bb4df879a5ab 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1273,8 +1273,8 @@ static void shutdown_ssif(void *send_info)
>  		schedule_timeout(1);
>  
>  	ssif_info->stopping = true;
> -	del_timer_sync(&ssif_info->watch_timer);
> -	del_timer_sync(&ssif_info->retry_timer);
> +	del_timer_shutdown(&ssif_info->watch_timer);
> +	del_timer_shutdown(&ssif_info->retry_timer);
>  	if (ssif_info->thread) {
>  		complete(&ssif_info->wake_thread);
>  		kthread_stop(ssif_info->thread);
> -- 
> 2.35.1
