Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288B2679FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbjAXRRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbjAXRRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:17:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB3322000;
        Tue, 24 Jan 2023 09:17:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9D3DB815E6;
        Tue, 24 Jan 2023 17:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A2EC433D2;
        Tue, 24 Jan 2023 17:17:04 +0000 (UTC)
Date:   Tue, 24 Jan 2023 12:17:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     <yang.yang29@zte.com.cn>
Cc:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>
Subject: Re: [PATCH linux-next] tracing: use strscpy() to instead of
 strncpy()
Message-ID: <20230124121703.1e3a1ac4@gandalf.local.home>
In-Reply-To: <202301091939219689840@zte.com.cn>
References: <202301091939219689840@zte.com.cn>
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

On Mon, 9 Jan 2023 19:39:21 +0800 (CST)
<yang.yang29@zte.com.cn> wrote:

> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL-terminated strings.

But the string being copied is *not* NUL-terminated! And this change causes
a bug.

This is the 3rd patch I've seen that blindly converts strncpy() to
strscpy() and causes a bug in doing so. Not very safe if you ask me.

> 
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>  kernel/trace/trace_events_synth.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index 67592eed0be8..cd636edd045e 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -195,8 +195,7 @@ static int synth_field_string_size(char *type)
>  	if (len == 0)
>  		return 0; /* variable-length string */
> 
> -	strncpy(buf, start, len);
> -	buf[len] = '\0';
> +	strscpy(buf, start, len + 1);
> 
>  	err = kstrtouint(buf, 0, &size);
>  	if (err)


Here's the code being affected:

static int synth_field_string_size(char *type)
{
	char buf[4], *end, *start;
	unsigned int len;
	int size, err;

	start = strstr(type, "char[");
	if (start == NULL)
		return -EINVAL;
	start += sizeof("char[") - 1;

	end = strchr(type, ']');
	if (!end || end < start || type + strlen(type) > end + 1)
		return -EINVAL;

	len = end - start;
	if (len > 3)
		return -EINVAL;

	if (len == 0)
		return 0; /* variable-length string */

	strncpy(buf, start, len);
	buf[len] = '\0';

And you are replacing the above two lines with just:

	strscpy(buf, start, len + 1);


If you noticed, the string being placed into buf is:

  "char[123]"

Where we want to copy that "123" into buf.

strscpy() expects the source to be nul terminated, or it will return -E2BIG.

So the above will *always* return -E2BIG *and* not end buf[] with '\0' as
if strscpy() returns -E2BIG, then buf[] is not guaranteed to be
NUL-terminated.

  NACK!

-- Steve
