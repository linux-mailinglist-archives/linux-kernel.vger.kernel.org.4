Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB906378FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiKXMio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiKXMil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:38:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5462382BF9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:38:40 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669293518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JWvvEuP41VoNHtPg/3PY49qC6uQeXEV8eRG/F++jjd4=;
        b=pvVHd81LSU4BltldBkUKcR7GOX3D89UWrJjeKTWMfZ9pUU84hskO8fs17LkZFsMv+FNPQ0
        IvLufv8jXNjFJxQ36XifO3kvOBkgGODFq1wLntSpis96bvelWd/1S2IVgZuzBF7odO7LRy
        VNeXO9aAy6EE2L8GJHA7b2JqqANzAknIoySONPQTE8XnTozaCgK77FLcbar3w0W6ObQKa/
        vLIU3bJ+HH+fLgl4AzB1t+lMndZODb05UBwTfPpl5N9CIpRrECIaAK1K5c3sK8vhJ36S8s
        31ERWZ8yb5AlIktrZdeM/ik71TI/0hMckz9Tsi57laMqk59vPDKPUI7CtG47uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669293518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JWvvEuP41VoNHtPg/3PY49qC6uQeXEV8eRG/F++jjd4=;
        b=lwgS6XaimcJm/g9Kv30ll8A+4WgiKLoqMfHmwJpEuC4Cd2M8QxRMF1GofDEaobp7oINTON
        5iYQGokISV1YupDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 1/7] printk: Move buffer size defines
In-Reply-To: <Y39Q5TjoHUUKXC1S@alley>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
 <20221123231400.614679-2-john.ogness@linutronix.de>
 <Y39Q5TjoHUUKXC1S@alley>
Date:   Thu, 24 Nov 2022 13:44:29 +0106
Message-ID: <87zgcgttmi.fsf@jogness.linutronix.de>
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

On 2022-11-24, Petr Mladek <pmladek@suse.com> wrote:
>> Move the buffer size defines to console.h in preparation of adding a
>> buffer structure. The new buffer structure will be embedded within
>> struct console. Therefore console.h was chosen as the new home for
>> these defines.
>
> The buffers are not embedded into struct console in this patchset.
> Are they going to be added directly or via pointer, please?

By "embedded" I mean added directly. The buffers need to be available
immediately and cannot be allocated or assigned dynamically. The console
struct is generally defined by drivers with:

static struct console my_console = {
   ...
};

I could think of no way to statically define the buffers but keep their
sizes hidden.

> IMHO, it is always better to hide these implementation details
> in an internal header or source file. It will be possible
> if struct console contained on a pointer to the buffers.

The problem is not pointers, it is static definition (without knowing
the size of the thing that is statically defined). The new thread/atomic
consoles run in parallel, so they cannot share the single static buffer
like we do now.

>> --- a/include/linux/console.h
>> +++ b/include/linux/console.h
>> @@ -122,6 +122,20 @@ static inline int con_debug_leave(void)
>>  #define CM_ERASE    (2)
>>  #define CM_MOVE     (3)
>>  
>> +#ifdef CONFIG_PRINTK
>> +
>> +/* The maximum size of a formatted record (i.e. with prefix added per line) */
>> +#define CONSOLE_LOG_MAX		1024
>> +
>> +#else
>> +
>> +#define CONSOLE_LOG_MAX		0
>> +
>> +#endif
>> +
>> +/* The maximum size of a formatted extended record */
>> +#define CONSOLE_EXT_LOG_MAX	8192
>
> It looks strange that we need the buffer for extended messages
> and not the normal one when !CONFIG_PRINTK. I can't find any reason
> for this. It looks like a historic inconsistency.

Yes, it looked that way to me as well. I will move it under
CONFIG_PRINTK for v3.

John
