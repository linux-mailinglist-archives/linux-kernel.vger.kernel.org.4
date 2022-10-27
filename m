Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0DB60F92A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbiJ0Nfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiJ0Nf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:35:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEAB12A35D;
        Thu, 27 Oct 2022 06:35:27 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666877724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qUNnaSiTpnz8zitnV3znO1WDSOsrJ4JHkGUBNirU8e0=;
        b=HZYNVE0jgBeZDZOVHj4C7tlK31pHEp+SXTTvp39STk13iUrdwUHjJrlrCXHvFCpGXc3z2l
        hRvUlmvJRVpPsC5BwmbFW+S9u4cXXQzUxgxkmKmyJzZLys+51YXAP3x2YuDGBtIB6b49/p
        bXEJf8/vIKh/DZUYRYH3QflGEAudHc2pjG4s9qcZxdY14pwWa+XWPsXQPl4trs0U59t/Kq
        cJLCs3aEi1nh7zZZI7M4l90knFfp2TLdjBRfXQhQNbYF2GUkJg0UeDhqdkCHcBDQVuo25r
        YGzP5qFFP5joDEDs1sAaY7fP7OsQ/2qUbujdaR0huZcrLDPz+BlH0aYCShkbQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666877724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qUNnaSiTpnz8zitnV3znO1WDSOsrJ4JHkGUBNirU8e0=;
        b=K8svDYQnhUfwQTDx+8cl3c6kL/K6magEDxEws98VvnaxAhrM/pDkWdvd4JUu3Bnj6xHQOa
        g9lKHnKVwORNFTDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Tom Rix <trix@redhat.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH printk v2 38/38] printk, xen: fbfront: create/use safe
 function for forcing preferred
In-Reply-To: <Y1qFHbi39SpTggPH@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-39-john.ogness@linutronix.de>
 <Y1qFHbi39SpTggPH@alley>
Date:   Thu, 27 Oct 2022 15:41:23 +0206
Message-ID: <87v8o5crtw.fsf@jogness.linutronix.de>
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

On 2022-10-27, Petr Mladek <pmladek@suse.com> wrote:
>> -	if (c) {
>> -		unregister_console(c);
>> -		c->flags |= CON_CONSDEV;
>> -		c->flags &= ~CON_PRINTBUFFER; /* don't print again */
>> -		register_console(c);
>> -	}
>> +	if (c)
>> +		console_force_preferred(c);
>
> I would prefer to fix this a clean way.
>
> [...]
>
> I would suggest to implement:
>
> [...]
>
> It is a more code. But it is race-free. Also it is much more clear
> what is going on.
>
> How does this sound, please?

I wasn't sure if any of the other preferred-console magic in
register_console() was needed, which is why I kept a full
register_console() call. But if it really is just about forcing it the
head and setting a new CON_CONSDEV, then your suggestion is much
simpler. Thanks.

John
