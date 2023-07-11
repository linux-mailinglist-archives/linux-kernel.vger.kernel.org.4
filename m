Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F19274F0E0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjGKN6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjGKN6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:58:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41F99E;
        Tue, 11 Jul 2023 06:58:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61B91614F9;
        Tue, 11 Jul 2023 13:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A37C433C8;
        Tue, 11 Jul 2023 13:58:05 +0000 (UTC)
Date:   Tue, 11 Jul 2023 09:58:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>
Subject: Re: [PATCH v2] ftrace: Fix possible warning on checking all pages
 used in ftrace_process_locs()
Message-ID: <20230711095802.71406422@gandalf.local.home>
In-Reply-To: <20230711201630.1837109-1-zhengyejian1@huawei.com>
References: <20230710104625.421c851a@gandalf.local.home>
        <20230711201630.1837109-1-zhengyejian1@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 04:16:30 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 3740aca79fe7..b46e539dc085 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6473,7 +6473,9 @@ static int ftrace_process_locs(struct module *mod,
>  {
>  	struct ftrace_page *start_pg;
>  	struct ftrace_page *pg;
> +	struct ftrace_page *pg_unuse = NULL;
>  	struct dyn_ftrace *rec;
> +	unsigned long skipped = 0;
>  	unsigned long count;
>  	unsigned long *p;
>  	unsigned long addr;

Nit, to keep the upside-down-xmas-tree format:

	struct ftrace_page *pg_unuse = NULL;
	struct ftrace_page *start_pg;
	struct ftrace_page *pg;
	struct dyn_ftrace *rec;
	unsigned long skipped = 0;
	unsigned long count;
	unsigned long *p;
	unsigned long addr;

-- Steve
