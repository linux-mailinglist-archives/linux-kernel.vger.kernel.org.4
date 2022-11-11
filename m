Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC1624EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 01:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiKKAQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 19:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKKAQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 19:16:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CB760EA1;
        Thu, 10 Nov 2022 16:16:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F47361E63;
        Fri, 11 Nov 2022 00:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E055C433D6;
        Fri, 11 Nov 2022 00:16:54 +0000 (UTC)
Date:   Thu, 10 Nov 2022 19:16:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Subject: Re: RCU stall on 6.1-rc4 (and some previous releases) related to
 ftrace
Message-ID: <20221110191651.3a177417@rorschach.local.home>
In-Reply-To: <1ef5fe19-a82f-835e-fda5-455e9c2b94b4@igalia.com>
References: <1ef5fe19-a82f-835e-fda5-455e9c2b94b4@igalia.com>
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

On Thu, 10 Nov 2022 18:25:41 -0300
"Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

> @@ -4184,6 +4184,7 @@ match_records(struct ftrace_hash *hash, char *func, int len, char *mod)
>  		if (rec->flags & FTRACE_FL_DISABLED)
>  			continue;
>  
> +		cond_resched();
>  		if (ftrace_match_record(rec, &func_g, mod_match, exclude_mod)) {
>  			ret = enter_record(hash, rec, clear_filter);
>  			if (ret < 0) {

This isn't where I would put it. I would add it after the if statement.
That is, at the end of the loop.

-- Steve
