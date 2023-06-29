Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55946742ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjF2QsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjF2QsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:48:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E2A30DD
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 09:48:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc41398c8so902385e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 09:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688057292; x=1690649292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ck75qwMLAYsu4fdOQ2ZPfvL9NJwp3DUFn+wFIqZjMSI=;
        b=QrhkhV9IESwo6EVlqZZQhK0oTx73qCOiXPBadfWgs/n0icWc2PuXxL2GkF/RAYu5sX
         kTUfQv0/eGrp2cg2iGzNKqh24UD2CpW7HyCzsxmTEp4pYeW+rWEUXd9hJJ9jcR42fovN
         sqp27mLeaipdXMWQ2NiRtHuDbrRC1XV+cqNhHNC2+ot5D86uLyAXESaoBeOIt3bNKQk/
         jZrYYesikpVrajV3BU3RNN6v+SraRexHIzifmFHkTOix97RZxYNs/ANmHRHl97iToGyf
         oHv8X0UQhefjAz5g/9cGljkH6sXnVs2+W6xa+jhPFzq4aTjnK2l8wEHHaemHdGQAdLQE
         LwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688057292; x=1690649292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ck75qwMLAYsu4fdOQ2ZPfvL9NJwp3DUFn+wFIqZjMSI=;
        b=V6xQsiU0xXJ+0MCWOJhAPm/6PpEMEyIipBUUasxqTujrEWEL+4FLrC6kmrxPvqtfnF
         zOGhZ32jj4mQ1mT0aMAQsUxYheEuLzAjV47tsMWYDXseM7bG2c1sbi4XX43JSKhogDpj
         0DmLIdM3tkRzapstI1YN+2C5JCVaFxXjAz8/GTy4AlQfrchYHvnkdFe/X8hXqOtQCB68
         M/IA6XxDEGiLNb4o/0yykg+3Ukcl1JvJpql6TQ9VMYJMZhQ2amb5CaG0ZLAe3HdXoo82
         IJr0A3j0F+/oQPGlOtJZAzCC9gOApc9JTf8rDbgsTjPXz1PPWrQ9HWj5EZKiHXQBzt4B
         xJhw==
X-Gm-Message-State: AC+VfDz0Fz4MpUp9XBIhEl0jOnoAQoGeRCIRta9Xp3zc/Ri35PSoXDbQ
        90xfSyDYs5J8o8UWNOl/WM+uEg==
X-Google-Smtp-Source: ACHHUZ4+zHDq74XxcvyN8aG1Iu+IgudsPOO9+qu5vVtoc3b+/Y8ToE33xHz9Rjg/R5DSYGENZ6LAPg==
X-Received: by 2002:a1c:7c08:0:b0:3fa:9939:47c with SMTP id x8-20020a1c7c08000000b003fa9939047cmr9522406wmc.37.1688057291632;
        Thu, 29 Jun 2023 09:48:11 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fbb5506e54sm3403487wmj.29.2023.06.29.09.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 09:48:11 -0700 (PDT)
Date:   Thu, 29 Jun 2023 17:48:09 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: Handle LF in the command parser
Message-ID: <20230629164809.GA2872423@aspen.lan>
References: <20230628125612.1.I5cc6c3d916195f5bcfdf5b75d823f2037707f5dc@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628125612.1.I5cc6c3d916195f5bcfdf5b75d823f2037707f5dc@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 12:56:17PM -0700, Douglas Anderson wrote:
> The main kdb command parser only handles CR (ASCII 13 AKA '\r') today,
> but not LF (ASCII 10 AKA '\n'). That means that the kdb command parser
> can handle terminals that send just CR or that send CR+LF but can't
> handle terminals that send just LF.
>
> The fact that kdb didn't handle LF in the command parser tripped up a
> tool I tried to use with it. Specifically, I was trying to send a
> command to my device to resume it from kdb using a ChromeOS tool like:
>   dut-control cpu_uart_cmd:"g"
> That tool only terminates lines with LF, not CR+LF.
>
> Arguably the ChromeOS tool should be fixed. After all, officially kdb
> seems to be designed such that CR+LF is the official line ending
> transmitted over the wire and that internally a line ending is just
> '\n' (LF). Some evidence:
> * uart_poll_put_char(), which is used by kdb, notices a '\n' and
>   converts it to '\r\n'.
> * kdb functions specifically use '\r' to get a carriage return without
>   a newline. You can see this in the pager where kdb will write a '\r'
>   and then write over the pager prompt.

I'd view this as simply "what you have to do drive a terminal correctly"
rather than indicating what the official newline protocol for kdb is.
With a human and a terminal emulator I would expect the typical input to
be CR-only (and that's what I setup the test suite to send ;-)).


> However, all that being said there's no real harm in accepting LF as a
> command terminator in the kdb parser and doing so seems like it would
> improve compatibility. After this, I'd expect that things would work
> OK-ish with a remote terminal that used any of CR, CR+LF, or LF as a
> line ending. Someone using CR as a line ending might get some ugliness
> where kdb wasn't able to overwrite the last line, but basic commands
> would work. Someone using just LF as a line ending would probably also
> work OK.
>
> A few other notes:
> - It can be noted that "bash" running on an "agetty" handles LF as a
>   line termination with no complaints.
> - Historically, kdb's "pager" actually handled either CR or LF fine. A
>   very quick inspection would make one think that kdb's pager actually
>   could have paged down two lines instead of one for anyone using
>   CR+LF, but this is generally avoided because of kdb_input_flush().

These are very convincing though!

> - Conceivably one could argue that some of this special case logic
>   belongs in uart_poll_get_char() since uart_poll_put_char() handles
>   the '\n' => '\r\n' conversion. I would argue that perhaps we should
>   eventually do the opposite and move the '\n' => '\r\n' out of
>   uart_poll_put_char(). Having that conversion at such a low level
>   could interfere if we ever want to transfer binary data. In
>   addition, if we truly made uart_poll_get_char() the inverse of
>   uart_poll_put_char() it would convert back to '\n' and (ironically)
>   kdb's parser currently only looks for '\r' to find the end of a
>   command.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

This arrived just as I was gathering up the patches (I know... running
late). I've added a couple of cases to the test suite to cover the
new feature.

The code looks good to me. Are you happy for me to take it this
merge cycle?


Daniel.

> ---
>
>  kernel/debug/kdb/kdb_io.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 5c7e9ba7cd6b..813cb6cf72d6 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -131,6 +131,7 @@ char kdb_getchar(void)
>  	int escape_delay = 0;
>  	get_char_func *f, *f_prev = NULL;
>  	int key;
> +	static bool last_char_was_cr;
>
>  	for (f = &kdb_poll_funcs[0]; ; ++f) {
>  		if (*f == NULL) {
> @@ -149,6 +150,18 @@ char kdb_getchar(void)
>  			continue;
>  		}
>
> +		/*
> +		 * The caller expects that newlines are either CR or LF. However
> +		 * some terminals send _both_ CR and LF. Avoid having to handle
> +		 * this in the caller by stripping the LF if we saw a CR right
> +		 * before.
> +		 */
> +		if (last_char_was_cr && key == '\n') {
> +			last_char_was_cr = false;
> +			continue;
> +		}
> +		last_char_was_cr = (key == '\r');
> +
>  		/*
>  		 * When the first character is received (or we get a change
>  		 * input source) we set ourselves up to handle an escape
> @@ -244,7 +257,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
>  			*cp = tmp;
>  		}
>  		break;
> -	case 13: /* enter */
> +	case 10: /* linefeed */
> +	case 13: /* carriage return */
>  		*lastchar++ = '\n';
>  		*lastchar++ = '\0';
>  		if (!KDB_STATE(KGDB_TRANS)) {
> --
> 2.41.0.162.gfafddb0af9-goog
>
