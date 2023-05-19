Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C41070A36B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 01:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjESXiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 19:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjESXiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 19:38:13 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 906DCE5D;
        Fri, 19 May 2023 16:38:10 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id CF87F20FB427;
        Fri, 19 May 2023 16:38:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF87F20FB427
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1684539489;
        bh=+lcHrgoSxmM497pz+TvQKuSRuTtCUUpNGUvG+0pEOv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxMQg95KWD5Ywkw+JWITI8rnrc6BphwJR354XYudgBQOououTKGcYIPrGAfNnMgW/
         OGSHr1GX6gtWT/K8WNv4BiLgPoVXdKrbiw2xEuD6YyNisigQHVZNrzXBV3fVFg6srE
         6mrwts482xxTGfXCyBl+eQavZmtVKtRw2uHCiqPA=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     sunliming@kylinos.cn
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH RESEND] tracing/user_events: Prevent same name event per process
Date:   Fri, 19 May 2023 16:38:04 -0700
Message-Id: <20230519233804.863-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519083740.232401-1-sunliming@kylinos.cn>
References: <20230519083740.232401-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> User processes register name_args for events. If the same name are registered
> multiple times in the same process, it can cause undefined behavior. Because
> the same name may be used for a diffrent event. If this event has the same
> format as the original event, it is impossible to distinguish the trace output
> of these two events. If the event has a different format from the original event,
> the trace output of the new event is incorrect.
> 
> Return EADDRINUSE back to the user process if the same event has being registered
> in the same process.
> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---

Thank you for the patch, a few comments.

>  kernel/trace/trace_events_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index b1ecd7677642..4ef6bdb5c07c 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1996,7 +1996,7 @@ static int user_events_ref_add(struct user_event_file_info *info,
>  
>  		for (i = 0; i < count; ++i)
>  			if (refs->events[i] == user)
> -				return i;
> +				return -EADDRINUSE;

The ABI currently allows this to allow for shared libraries to share a common write
FD. Do you feel strongly that this should not be allowed?

If you and others feel this should not be allowed, I'd kindly ask you to also update
the self-tests at tools/testing/selftests/user_events/ in the tree and ensure they
pass fully.

For example, see ftrace_test.c at the above tree location:
...

TEST_F(user, register_events) {

...


	/* Multiple registers to the same addr + bit should fail */
	ASSERT_EQ(-1, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
	ASSERT_EQ(EADDRINUSE, errno);

	/* Multiple registers to same name should result in same index */
	reg.enable_bit = 30;
	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
	ASSERT_EQ(0, reg.write_index);

...

Thanks,
-Beau

>  	}
>  
>  	size = struct_size(refs, events, count + 1);
> -- 
> 2.25.1
