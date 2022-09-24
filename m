Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684815E8DA9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiIXPBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiIXPBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:01:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B140413F22
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:01:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62114B80AE2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B02BC433C1;
        Sat, 24 Sep 2022 15:01:14 +0000 (UTC)
Date:   Sat, 24 Sep 2022 11:01:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Liu <song@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] ftrace: fix recursive locking direct_mutex in
 ftrace_modify_direct_caller
Message-ID: <20220924110113.64c6701b@rorschach.local.home>
In-Reply-To: <20220919172955.1196326-1-song@kernel.org>
References: <20220919172955.1196326-1-song@kernel.org>
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

On Mon, 19 Sep 2022 10:29:55 -0700
Song Liu <song@kernel.org> wrote:

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 439e2ab6905e..d308d0674805 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5461,7 +5461,7 @@ int __weak ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
>  	if (ret)
>  		goto out_lock;
>  
> -	ret = register_ftrace_function(&stub_ops);
> +	ret = register_ftrace_function_nolock(&stub_ops);
>  	if (ret) {
>  		ftrace_set_filter_ip(&stub_ops, ip, 1, 0);
>  		goto out_lock;
> -- 

We need to update the comments to this function, as well add an:

#define lock_direct_assert_held()	lockdep_assert_held(&direct_mutex);

And call that in this function. Otherwise, we can be calling this code
without it held and cause races.

-- Steve
