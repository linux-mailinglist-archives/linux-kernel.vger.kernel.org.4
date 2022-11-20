Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B9163160E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 20:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiKTTun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 14:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiKTTud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 14:50:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95912FC34
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 11:50:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EE5760D14
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 19:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A714C433B5;
        Sun, 20 Nov 2022 19:49:59 +0000 (UTC)
Date:   Sun, 20 Nov 2022 14:49:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Fix infinite loop in tracing_read_pipe on
 overflowed print_trace_line
Message-ID: <20221120144956.30bb1725@rorschach.local.home>
In-Reply-To: <188a48b7-f426-6348-086e-22e56bb07206@huawei.com>
References: <20221114022946.66255-1-yangjihong1@huawei.com>
        <20221117164003.6e655615@gandalf.local.home>
        <188a48b7-f426-6348-086e-22e56bb07206@huawei.com>
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

On Fri, 18 Nov 2022 18:21:12 +0800
Yang Jihong <yangjihong1@huawei.com> wrote:

> > That way we can see the broken trace event and not just silently drop it.
> >   
> Ok, will change in next version.(Because iter->seq.seq.len may be 
> smaller than strlen(dots), direct subtraction here may not be appropriate.)

We should only need to do this if the len is maxed out.

Hmm, len is only updated if it did actually copy it.

Perhaps we could just add:

	trace_seq_puts(&iter->seq, "[LINE TOO BIG]\n");

And perhaps that will work?

Anyway, what is triggering this?

-- Steve
