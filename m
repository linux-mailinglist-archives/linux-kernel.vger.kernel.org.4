Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34A26E95E0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjDTN3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDTN3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:29:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5834680
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:29:24 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681997361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uyb1MZ7NuV5vu+8jhZvnRspPxQmVwaXDLnhGv/qVF04=;
        b=HKVhhOIR1g0IW4CyBfC5Twn3/c4N2HxrfQRgHRGs0FqB9OT1g/2YQEFlRgyub85ZDCDVCQ
        V5DMLIDPsyxYyOT0cm5iv+dpe6tpAiiu39nyz6R8wGTvno/uh75Q4oKV3M151bMh/mL7cl
        elLLtPe1AJWg8dq1QZc6o/jIDvcB3cpPQ2uaAEfWqScGqClffy0o1BM9jCZ5xTxirCku4F
        xwrFbVEuefcipb+r0zfQvDstNP95Sg2c9wY2PaLlzytftK+S+ITvsaUtQT1fxph3EpGBcW
        1MzN/VzO8AGqrizlggwyjhYdoa4e6kn32QW+h89rjcA8ajWPdK4igikYIfspoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681997361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uyb1MZ7NuV5vu+8jhZvnRspPxQmVwaXDLnhGv/qVF04=;
        b=VEdHKK5Jr71Yq5zTcRjYeq1o0iMLHHUuDuLgCUgf2ZTwMthegftELuhV67RnNnlb1QaOAe
        hwLOrZBJoBwzhOAw==
To:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v4 1/2] printk: Do not delay messages which aren't
 solicited by any console
In-Reply-To: <43d7f8d6e4b45a1a76fceef2d117bbc3954bc0bf.1681994221.git.chris@chrisdown.name>
References: <cover.1681994220.git.chris@chrisdown.name>
 <43d7f8d6e4b45a1a76fceef2d117bbc3954bc0bf.1681994221.git.chris@chrisdown.name>
Date:   Thu, 20 Apr 2023 15:33:22 +0206
Message-ID: <87wn26vg3p.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-20, Chris Down <chris@chrisdown.name> wrote:
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index fd0c9f913940..06f16a5f1516 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1289,15 +1289,13 @@ static int __init boot_delay_setup(char *str)
>  }
>  early_param("boot_delay", boot_delay_setup);
>  
> -static void boot_delay_msec(int level)
> +static void boot_delay_msec(void)
>  {
>  	unsigned long long k;
>  	unsigned long timeout;
>  
>  	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)

            ^----- you will need to remove this paren as well

> -		|| suppress_message_printing(level)) {
>  		return;
> -	}

John Ogness
