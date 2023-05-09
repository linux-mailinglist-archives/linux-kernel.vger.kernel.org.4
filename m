Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896166FCFB9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbjEIUmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 16:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbjEIUmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:42:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4422D1BDB;
        Tue,  9 May 2023 13:42:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDC10618EB;
        Tue,  9 May 2023 20:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F6DC433EF;
        Tue,  9 May 2023 20:42:46 +0000 (UTC)
Date:   Tue, 9 May 2023 16:42:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230509164244.3163e421@rorschach.local.home>
In-Reply-To: <20230509163050.127d5123@rorschach.local.home>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
        <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
        <20230509130111.62d587f1@rorschach.local.home>
        <20230509163050.127d5123@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Tue, 9 May 2023 16:30:50 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> >From the user space side, which does:  
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/user_events/example.c#n60
> 
> 	/* Check if anyone is listening */
> 	if (enabled) {

Hmm, looking at this deeper, we should update it to prevent the
compiler from optimizing it, and keeping "enabled" in a register. Which
would not work. Should probably add:

	if (*(const volatile int *)&enabled) {

-- Steve


> 		/* Yep, trace out our data */
> 		writev(data_fd, (const struct iovec *)io, 2);
> 
> 		/* Increase the count */
> 		count++;
> 
> 		printf("Something was attached, wrote data\n");
> 	}

