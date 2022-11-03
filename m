Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F68D6174E3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 04:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiKCDXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 23:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKCDXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 23:23:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A1725D1;
        Wed,  2 Nov 2022 20:23:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2D4661D0C;
        Thu,  3 Nov 2022 03:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2ED0C433C1;
        Thu,  3 Nov 2022 03:23:36 +0000 (UTC)
Date:   Wed, 2 Nov 2022 23:23:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     <mhiramat@kernel.org>, <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ftrace: Fix use-after-free for dynamic ftrace_ops
Message-ID: <20221102232334.0c1ae93b@rorschach.local.home>
In-Reply-To: <20221103031010.166498-1-lihuafei1@huawei.com>
References: <20221103031010.166498-1-lihuafei1@huawei.com>
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

On Thu, 3 Nov 2022 11:10:10 +0800
Li Huafei <lihuafei1@huawei.com> wrote:

> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3028,18 +3028,8 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
>  		command |= FTRACE_UPDATE_TRACE_FUNC;
>  	}
>  
> -	if (!command || !ftrace_enabled) {
> -		/*
> -		 * If these are dynamic or per_cpu ops, they still
> -		 * need their data freed. Since, function tracing is
> -		 * not currently active, we can just free them
> -		 * without synchronizing all CPUs.
> -		 */
> -		if (ops->flags & FTRACE_OPS_FL_DYNAMIC)
> -			goto free_ops;
> -
> -		return 0;
> -	}
> +	if (!command || !ftrace_enabled)
> +		goto out;
>  

Hi Li,

I think you misunderstood me. What I was suggesting was to get rid of
the ftrace_enabled check. The DYNAMIC part is most definitely needed.

	if (!command) {
		if (ops->flags & FTRACE_OPS_FL_DYNAMIC)
			goto out;
		return 0;
	}

-- Steve
