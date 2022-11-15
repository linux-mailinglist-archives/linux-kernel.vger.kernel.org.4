Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55686629CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiKOPH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiKOPHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:07:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523422D1C2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:07:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 113B6B8162B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 15:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF7FC433D6;
        Tue, 15 Nov 2022 15:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668524839;
        bh=QkNQYbk7sT+LWeYMY8bXDXIsFDEOy7WD1ocCTl5Lxvw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fss09H86y6CN9bVN+MgYRrFI+TGRp4rHhBHLlGlwDyKjC71WuRGo+QDF1Yk4yiPxn
         2jm7m7iAxxDOtCogFEqKsQGUuBUxCk5nwBcoscGU1pPmmgGeGngN68We5PG68po5iT
         kSdgqdT7ACt5hkpfxIBsHMAmcXUN2tk9soTXdg3ygCvbWqr1NYvSqPPiXY8atMmwse
         gnAeXvH7MAzml2YpBv6I5OD+XJ+UI2djd/gAvyFKGGRhrtBKGZq34rm4H+Za046AnS
         jn1/9MAQpQCwMs43oLPe2s4OWyV/mEHvoMiJnn5icrKvv0KrwBDE4LVzSFPWB94DJO
         vM+kY8DYpLI7A==
Date:   Wed, 16 Nov 2022 00:07:17 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     <rostedt@goodmis.org>, <beaub@linux.microsoft.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/user_events: Fix memory leak in
 user_event_create()
Message-Id: <20221116000717.4b62513eeaf0b2296b399bda@kernel.org>
In-Reply-To: <20221115014445.158419-1-xiujianfeng@huawei.com>
References: <20221115014445.158419-1-xiujianfeng@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022 09:44:45 +0800
Xiu Jianfeng <xiujianfeng@huawei.com> wrote:

> Before current_user_event_group(), it has allocated memory and save it
> in @name, this should freed before return error.
> 
> Fixes: e5d271812e7a ("tracing/user_events: Move pages/locks into groups to prepare for namespaces")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  kernel/trace/trace_events_user.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index ae78c2d53c8a..539b08ae7020 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1100,8 +1100,10 @@ static int user_event_create(const char *raw_command)
>  
>  	group = current_user_event_group();
>  
> -	if (!group)
> +	if (!group) {
> +		kfree(name);
>  		return -ENOENT;
> +	}
>  
>  	mutex_lock(&group->reg_mutex);
>  
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
