Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091C6624417
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiKJOTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKJOTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:19:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9871165AF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:19:04 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668089943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CLHBQggQls4mWIgeZbw7Mj4Foog8Zgpi+AZP3I0LDjo=;
        b=TeyzoeMBsyYpwQEcZ7EWDcxKdM1GA5YG3rA9Rd/s6Mj/hMRJt/CpMZqEY2AONXSU5QtyvO
        PXdvYEzwGP3Ulb+OiWg35ZaYuNuAI3CHWUqqEPfBQLNfvmOQ/ZXjJImfXkGx7uy0XfTQWA
        vmtCMPHTIqnf8FO54hbFouDBVPzGZ69l2EBCngFRZNG9G1I2tpXDMAO1QHwU968mx4yzod
        HXi5s97LggtkkmtA56Lwre1sjoZRcHFgJVMPKk8B1dzPVlGI31nSoS8gV3GOhutszYS7WC
        tFXYCVanN6ah4JTrlmFUNPzD2QkKPYd2rL2q+btcRzXBjjzUkvooQ2dN6jXKPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668089943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CLHBQggQls4mWIgeZbw7Mj4Foog8Zgpi+AZP3I0LDjo=;
        b=XVCMkXBronBmd1KX+rOaAL7HrZZrturZw18aI93S+jm3mmMSItyqIEZXc2Qx33a+nZGgqy
        nib2Diw68mRskRAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH printk v3 24/40] tty: nfcon: use console_is_registered()
In-Reply-To: <Y20DoLPsrfgm528O@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-25-john.ogness@linutronix.de>
 <Y20DoLPsrfgm528O@alley>
Date:   Thu, 10 Nov 2022 15:25:02 +0106
Message-ID: <87cz9u6gfd.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-10, Petr Mladek <pmladek@suse.com> wrote:
>> diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
>> index 557d60867f98..292669fa480f 100644
>> --- a/arch/m68k/emu/nfcon.c
>> +++ b/arch/m68k/emu/nfcon.c
>> @@ -49,14 +49,14 @@ static void nfcon_write(struct console *con, const char *str,
>>  static struct tty_driver *nfcon_device(struct console *con, int *index)
>>  {
>>  	*index = 0;
>> -	return (con->flags & CON_ENABLED) ? nfcon_tty_driver : NULL;
>> +	return console_is_registered(con) ? nfcon_tty_driver : NULL;
>>  }
>>  
>>  static struct console nf_console = {
>>  	.name	= "nfcon",
>>  	.write	= nfcon_write,
>>  	.device	= nfcon_device,
>> -	.flags	= CON_PRINTBUFFER,
>> +	.flags	= CON_PRINTBUFFER | CON_ENABLED,
>
> This causes that register_console() will always put the console into
> console_list. It causes regression, see below.

Agreed. Nice catch. I will remove initializing with CON_ENABLED.

>>  	.index	= -1,
>>  };
>>  
>> @@ -106,10 +106,8 @@ static int __init nf_debug_setup(char *arg)
>>  		return 0;
>>  
>>  	stderr_id = nf_get_id("NF_STDERR");
>> -	if (stderr_id) {
>> -		nf_console.flags |= CON_ENABLED;
>> +	if (stderr_id)
>>  		register_console(&nf_console);
>
> My understanding is that this should enable the console
> when debug=nfcon kernel parameter is used.
>
> It is a non-standard way. This is why CON_ENABLED flag
> has to be explicitly set.

Understood. I will add a comment explaining why CON_ENABLED is set here.

>> -	}
>>  
>>  	return 0;
>>  }
>> @@ -151,7 +149,7 @@ static int __init nfcon_init(void)
>>  
>>  	nfcon_tty_driver = driver;
>>  
>> -	if (!(nf_console.flags & CON_ENABLED))
>> +	if (!console_is_registered(&nf_console))
>>  		register_console(&nf_console);
>
> This calls register_console() when it was not already
> registered by the debug=nfcon early parameter.
>
> It is the standard way. It should enable the console only
> when console=nfcon is defined on the commandline. Or when
> there is no preferred console and no console enabled by default yet.
>
> We should not pre-set CON_ENABLED in this case.

Agreed. The hunk itself is OK.

John
