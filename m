Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA7D62275C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiKIJos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiKIJoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:44:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBB422BE4;
        Wed,  9 Nov 2022 01:44:45 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667987084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kPAk+3cLOj2C0i9syAj3cq39vfGjg5hFSD8YkhVNKCk=;
        b=KGQPt3BuMB8UxOiIeFc+7+g3uFtm5Q+FCy0D1VPuuhLPP7wqeYjclkvf1RZxSMfB6ZYBCt
        O5f5FF0udqPW6CI/S0q6BcPp+Y5RSQoTsPStReWTA85+wKkTrJjAgTbSEAeoXsA3kVvFE7
        PEXiLJdpH/khQx7aMlU8mUKl1Y4fvdVWoa8Ty7z8J5eH3ft0N/k/3y6tPQqkXFUeFJWakU
        WtOA5VwvhTYQ/TBB3pnQwMlyenIw21lmNsyYhrjRRERT4DVCo4owgVakHWDZhAnMSIzOfY
        kwrI2VjoZ+EHwYrhzKzN6fxSAY1G9IMwfNLmcCELUTNB4I5Se7wkQhlDwQTqeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667987084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kPAk+3cLOj2C0i9syAj3cq39vfGjg5hFSD8YkhVNKCk=;
        b=LsawK0XIGHqnjIumlhGVKLy3i3Z9JVErl5RyBoTCpwhm33D+5Tr+t5xSfti/otQSEWiBov
        Du2+ohG3YC9rpIDQ==
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v3 36/40] tty: serial: kgdboc: use
 console_list_lock for list traversal
In-Reply-To: <20221109090631.wbtar2ho45x5yanl@ash.lan>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-37-john.ogness@linutronix.de>
 <20221109090631.wbtar2ho45x5yanl@ash.lan>
Date:   Wed, 09 Nov 2022 10:50:43 +0106
Message-ID: <87tu388nsk.fsf@jogness.linutronix.de>
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

On 2022-11-09, Daniel Thompson <daniel.thompson@linaro.org> wrote:
>> @@ -463,9 +476,14 @@ static void kgdboc_earlycon_pre_exp_handler(void)
>>  	 * serial drivers might be OK with this, print a warning once per
>>  	 * boot if we detect this case.
>>  	 */
>> -	for_each_console(con)
>> +	cookie = console_srcu_read_lock();
>> +	for_each_console_srcu(con) {
>>  		if (con == kgdboc_earlycon_io_ops.cons)
>> -			return;
>> +			break;
>> +	}
>> +	console_srcu_read_unlock(cookie);
>> +	if (con)
>> +		return;
>
> This change isn't mentioned in the patch description.

I will move this change into its own separate patch.

    tty: serial: kgdboc: use srcu console list iterator

    Use srcu console list iteration for safe console list traversal.

Thanks.

John
