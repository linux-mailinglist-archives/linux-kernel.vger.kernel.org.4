Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE4F5E9869
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 06:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiIZEUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 00:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiIZETv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 00:19:51 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799A2BF76
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 21:19:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id jm5so5083729plb.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 21:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Iz1cLT0Dw3NL/z+eOG9Yepj9a6YSjoGJCO36ZR0E7Nc=;
        b=QDzXG2EVRBnMekEOoO23EeOjQ8zWexlHGQr4Pz7FexEplASG+GjmpU6zJDeBdnv6aR
         Ah4IbHTxVJ7T1SLF8QHkMIXQJrQiDl8tt5cDunYBm1lqlagwo0ANvhqEjkArFY5u9PJ9
         9hNccroGue6sdlkkeWDfP7XTuf9RWvmfOd60E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Iz1cLT0Dw3NL/z+eOG9Yepj9a6YSjoGJCO36ZR0E7Nc=;
        b=UtJ5yjo0M5rhG/XVLKlcFUNyvQd/FrNYTpeitG/5CJQNUxG0DDXjybL8ZcKU8A+x4c
         uCwU5OqIUa/09I5lQGNpm6m2749FSNnObbnuJSnvj0Fu9Znacsx345viwEDspwCaYl2l
         bk6+fJdGF9GuloMWxrgNM13KqD76++udvWaV/dU8UT8+WJv+yAIRxmLHVNDIBcfhXM7W
         6zRiUGu+hlHaxDF11QBOv55yUgs3QF2rJtgNZNGsX5z7pQvM4NpjVUxXKuvABGnyG3OP
         eIrKz7Yvq1U89kFrYykOzViXP2XcmkXum3yyr4bkR1I6jpFL26m3lgogKzLz4o34iGyA
         KG6Q==
X-Gm-Message-State: ACrzQf0v5HM/PXDyv4MByrkkTQh9ID0bOSspTPXYWtqB8r4x0wdlHBRk
        cVDzoz8MkzP4yvK9IdeV3pnUjw==
X-Google-Smtp-Source: AMsMyM6KLQAgcO3l+E3+9GojcyLsebexsjYZquwGShD12eahwVaPSmIQaeSPiNJs3ORy7tPnb390iA==
X-Received: by 2002:a17:902:b085:b0:178:3af4:31b2 with SMTP id p5-20020a170902b08500b001783af431b2mr20508421plr.122.1664165988970;
        Sun, 25 Sep 2022 21:19:48 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:2a7d:69c:905d:1926])
        by smtp.gmail.com with ESMTPSA id k1-20020aa79981000000b0053e72ed5252sm10877944pfh.42.2022.09.25.21.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 21:19:48 -0700 (PDT)
Date:   Mon, 26 Sep 2022 13:19:44 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 18/18] printk: Handle dropped message smarter
Message-ID: <YzEoYPSC5Qf2aL92@google.com>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-19-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-19-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/24 02:10), John Ogness wrote:
> +/**
> + * cons_print_dropped - Print 'dropped' message if required
> + * @desc:	Pointer to the output descriptor
> + *
> + * Prints the 'dropped' message info the output buffer if @desc->dropped is
> + * not 0 and the regular format is requested. Extended format does not
> + * need this message because it prints the sequence numbers.
> + *
> + * In regular format the extended message buffer is not in use.
> + * So print into it at the beginning and move the resulting string
> + * just in front of the regular text buffer so that the message can
> + * be printed in one go.
> + *
> + * In case of a message this returns with @desc->outbuf and @desc->len
> + * updated. If no message is required then @desc is not modified.
> + */
> +static void cons_print_dropped(struct cons_outbuf_desc *desc)
> +{
> +	struct cons_text_buf *txtbuf = desc->txtbuf;
> +	size_t len;
> +
> +	if (!desc->dropped || desc->extmsg)
> +		return;
> +
> +	if (WARN_ON_ONCE(desc->outbuf != txtbuf->text))
> +		return;
> +
> +	/* Print it into ext_text which is unused */
> +	len = snprintf(txtbuf->ext_text, DROPPED_TEXT_MAX,
> +		       "** %lu printk messages dropped **\n", desc->dropped);
> +	desc->dropped = 0;
> +
> +	/* Copy it just below text so it goes out with one write */
> +	memcpy(txtbuf->text - len, txtbuf->ext_text, len);
> +
> +	/* Update the descriptor */
> +	desc->len += len;
> +	desc->outbuf -= len;

Oh, hmm. This does not look to me as a simplification. Quite
the opposite, moving cons_text_buf::text pointer to point to
cons_text_buf::text - strlen("... dropped messages...") looks
somewhat fragile.

Is printing 'dropped' and outbuf messages in one go such an
important feature?
