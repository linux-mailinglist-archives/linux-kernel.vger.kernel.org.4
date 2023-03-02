Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35A16A880B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjCBRoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCBRn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:43:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5AC14493;
        Thu,  2 Mar 2023 09:43:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 885E1B8133A;
        Thu,  2 Mar 2023 17:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0412C4339B;
        Thu,  2 Mar 2023 17:43:54 +0000 (UTC)
Date:   Thu, 2 Mar 2023 12:43:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 2/3] ring_buffer: Change some static functions to
 bool
Message-ID: <20230302124352.6d6295a8@gandalf.local.home>
In-Reply-To: <20230302164129.4862-3-ubizjak@gmail.com>
References: <20230302164129.4862-1-ubizjak@gmail.com>
        <20230302164129.4862-3-ubizjak@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Mar 2023 17:41:28 +0100
Uros Bizjak <ubizjak@gmail.com> wrote:

> -static int
> +static bool
>  rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
>  {
>  	struct list_head *pages = &cpu_buffer->new_pages;
> -	int retries, success;
> +	int retries;
>  	unsigned long flags;
> +	bool success;

Nit, but I prefer to keep the "upside-down xmas-tree" format:

That is, instead of:

  	struct list_head *pages = &cpu_buffer->new_pages;
	int retries;
 	unsigned long flags;
	bool success;

Have

  	struct list_head *pages = &cpu_buffer->new_pages;
 	unsigned long flags;
	bool success;
	int retries;

It's easier to read, and looks cleaner.

-- Steve

>  
>  	/* Can be called at early boot up, where interrupts must not been enabled */
>  	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
