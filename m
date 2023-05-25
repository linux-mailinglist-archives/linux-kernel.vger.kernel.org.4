Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E5B711168
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbjEYQx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbjEYQxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:53:38 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F07319C;
        Thu, 25 May 2023 09:53:36 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9CF0E20FBE85;
        Thu, 25 May 2023 09:53:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9CF0E20FBE85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1685033615;
        bh=ZZ+c+EEe8Ld032DoWLP+pWoIJX6IUdfMjVhJYrHMqQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k6mxVBNgJk158KdcKYkckUhLj1Rn92c0CHEICBei2hRQOczKDCiLwskL6Rb4mmsj0
         Brjhr3ceAqkfFG2IniwTfUbBrOV78SOulQTJpwVIz1lHy0Q8lR/lR+mdW7mGVcuMtm
         xjCpW8r2gd0OgVp7Wk1MjUCXMoKoET4XcIC/gys8=
Date:   Thu, 25 May 2023 09:53:29 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     sunliming <sunliming@kylinos.cn>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kelulanainsley@gmail.com
Subject: Re: [PATCH] tracing/user_events: Fix the order of the fields in the
 trace output
Message-ID: <20230525165329.GA82@W11-BEAU-MD.localdomain>
References: <20230525054032.29392-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525054032.29392-1-sunliming@kylinos.cn>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 01:40:32PM +0800, sunliming wrote:
> Commit 4bec284cc0b9 ("tracing/user_events: Use print_format_fields() for
> trace output") use print_event_fields() as safe and gives user readable
> output. However, due to the insertion of the struct ftrace_event_field
> structure into the field linked list from the header, the trace output
> oder of fields of user events is reversed. Fix the problem by insertint
> to the tail of field linked list.
> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  kernel/trace/trace_events_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index aacd22c1e9f8..e9e2ec3c7613 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -972,7 +972,7 @@ static int user_event_add_field(struct user_event *user, const char *type,
>  	if (filter_type == FILTER_OTHER)
>  		field->filter_type = filter_assign_type(type);
>  
> -	list_add(&field->link, &user->fields);
> +	list_add_tail(&field->link, &user->fields);
>  
>  	/*
>  	 * Min size from user writes that are required, this does not include
> -- 
> 2.25.1

Thanks for the patch, however, this breaks the tracefs format file. The
fields are required to be put in backwards since it walks them
backwards.

Example using this:
echo 'u:test u32 a; u32 b;' > dynamic_events
cat /sys/kernel/tracing/events/user_events/test/format

Before this change:
name: test
...
format:
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:u32 a;    offset:8;       size:4; signed:0;
        field:u32 b;    offset:12;      size:4; signed:0;

print fmt: "a=%u b=%u", REC->a, REC->b

After this change:
name: test
...
format:
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:u32 b;    offset:12;      size:4; signed:0;
        field:u32 a;    offset:8;       size:4; signed:0;

print fmt: "b=%u a=%u", REC->b, REC->a

I do agree though, that print_fields() is doing it backwards. Can you
please fix the print_fields() function instead? (It should walk the list
of fields backwards like tracefs format file does).

Steven can then Ack that work, since it's isolated there.

Thanks,
-Beau
