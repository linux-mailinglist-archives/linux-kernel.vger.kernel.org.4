Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6115F7A5B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJGPPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiJGPPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:15:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514D470E53
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:15:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EC2191F8C0;
        Fri,  7 Oct 2022 15:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665155732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7UKd3b0cMV6HiBe8IZCW+WhAmj3ZOmaJOUwYJpeuYds=;
        b=iq3hybtaH6yjkeyVjM13Z09oUlkGUr7InHUhp6/jxgLGpdeO2TNgmHSn5Fsu47x5KczH2r
        oZIQp7hdB/1/3Fdmv5CrMUDJL0UBWc7msA8rMcrUrZaMm8vXPZfiFQPPwxvguhvz7n2mlr
        PPrzGmSSbVo5KTBi4njN9iGbVWCxVak=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9B3592C141;
        Fri,  7 Oct 2022 15:15:32 +0000 (UTC)
Date:   Fri, 7 Oct 2022 17:15:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 15/18] printk: Add struct cons_text_buf
Message-ID: <Y0BClAlwfWfWcsDD@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-16-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-16-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2022-09-24 02:10:51, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Create a data structure to replace the open coded separate buffers for
> regular and extended formatting.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  include/linux/console.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 8ec24fe097d3..05c7325e98f9 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -173,6 +173,20 @@ enum cons_flags {
>  	CON_EXTENDED		= BIT(6),
>  };
>  
> +/**
> + * struct cons_text_buf - console output text buffer
> + * @ext_text:		Buffer for extended log format text
> + * @dropped_text:	Buffer for dropped text
> + * @text:		Buffer for ringbuffer text
> + */
> +struct cons_text_buf {

Sigh, I feel bad to nit-pick about this. It seems that you have used
"cons" everywhere in the new API so any change might be painful.
But I personally find really handful when an API is predictable
and consistent.

I see that "cons" has already been used few times in tty subsystem,
especially tty/vt and tty/hvc.

But I do not see any single "cons_" under kernel/printk/ before
this patchset. Either "console_" or "con_" prefix was
used everywhere, including CON_XXX flags.

Is there any change to change this to either "console_"
or "con_", please? Or is there any particular reason why
this new API should be distinguished by the new prefix?

> +	union {
> +		char	ext_text[CONSOLE_EXT_LOG_MAX];
> +		char	dropped_text[DROPPED_TEXT_MAX];
> +	};
> +	char		text[CONSOLE_LOG_MAX];

We should explain in the commit message why we need
the separate ext_text buffer and why it can be shared
with dropped_text buffer. Something like:

<proposal>
Create a data structure to replace the open coded separate buffers for
regular and extended formatting.

Separate @ext_text buffer is needed because info_print_ext_header()
and msg_print_ext_body() are not able to add the needed extra
information inplace.

@ext_text and @dropped_text buffer can be shared because
they are never used at the same time.
</proposal>


Also I think about using pointers instead of the hard-coded
buffer size. For example, there is no need to have
the big ext_text buffer in the kthread when the related
console does not allow to allocated the extended text.
There is actually only one console that has this enabled.

I mean something like:

struct cons_text_buf {
	char *text;
	char *ext_text;
	char *dropped_text;

	unsigned int text_size;
	unsigned int ext_text_size;
	unsigned int dropped_text_size;
}

We might create a helper to define static buffer:

#define DEFINE_CONS_TEXT_BUF(name) \
	static char _##name##_text[CONSOLE_LOG_MAX];			\
	static char _##name##_ext_text[CONSOLE_EXT_LOG_MAX];		\
	static struct const_text_buf name = {				\
		.text = _##name##_text,					\
		.ext_text = _##name##_ext_text,				\
		.dropped_text = _##name##_ext_text,			\
									\
		.text_size = CONSOLE_LOG_MAX;				\
		.ext_text_size = CONSOLE_LOG_MAX;			\
		.dropped_text_size = DROPPED_TEXT_MAX;			\
	};

Another advantage would be that it looks like a more safe way to
pass the buffer size. The existing code hardcodes CONSOLE_LOG_MAX
and CONSOLE_EXT_LOG_MAX everywhere. And it is less obvious that
the buffer and size fits together. Especially that the names
do not match (text vs. LOG_MAX and ext_text vs. EXT_LOG_MAX).

Well, this might be out of scope of this patchset. I do not resist
on it. We might do this later.

Best Regards,
Petr
