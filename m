Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF00661D13
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbjAIDy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbjAIDxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:53:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED47212094;
        Sun,  8 Jan 2023 19:52:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69FD8B8085B;
        Mon,  9 Jan 2023 03:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EDEC433EF;
        Mon,  9 Jan 2023 03:52:31 +0000 (UTC)
Date:   Sun, 8 Jan 2023 22:52:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Quanfa Fu <quanfafu@gmail.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/eprobe: Replace snprintf with memcpy
Message-ID: <20230108225229.1cef1a67@rorschach.local.home>
In-Reply-To: <20230109033213.3220884-1-quanfafu@gmail.com>
References: <20230109033213.3220884-1-quanfafu@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Jan 2023 11:32:13 +0800
Quanfa Fu <quanfafu@gmail.com> wrote:

> @@ -923,17 +923,17 @@ static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const ch
>  
>  	p = ep->filter_str;
>  	for (i = 0; i < argc; i++) {
> -		ret = snprintf(p, len, "%s ", argv[i]);
> -		if (ret < 0)
> -			goto error;
> -		if (ret > len) {
> -			ret = -E2BIG;
> -			goto error;
> -		}
> -		p += ret;
> -		len -= ret;
> +		arg_len = strlen(argv[i]);
> +		memcpy((void *)p, argv[i], arg_len);
> +
> +		if (i == argc - 1)
> +			p[arg_len] = '\0';
> +		else
> +			p[arg_len] = ' ';
> +
> +		p += arg_len + 1;
> +		len -= arg_len + 1;
>  	}

The above is too complex. I mentioned strncat() but you could still
just keep snprintf() too, which adds the '\0';

	for (i = 0; i < argc; i++) {
		if (i)
			ret = snprintf(p, len, " %s", argv[i]);
		else
			ret = snprintf(p, len, "%s", argv[i]);
		p += ret;
		len -= ret;
	}

-- Steve

> -	p[-1] = '\0';
>  
>  	/*
>  	 * Ensure the filter string can be parsed correctly. Note, this
