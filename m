Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF10268E0A2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjBGSyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBGSyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:54:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49F7103;
        Tue,  7 Feb 2023 10:54:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 814E261137;
        Tue,  7 Feb 2023 18:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFBCC433EF;
        Tue,  7 Feb 2023 18:54:05 +0000 (UTC)
Date:   Tue, 7 Feb 2023 13:54:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracing/selftests: Ignore __pfx_ symbols in kprobe test
Message-ID: <20230207135402.38f73bb6@gandalf.local.home>
In-Reply-To: <20230207135147.5ce618d6@gandalf.local.home>
References: <20230207135147.5ce618d6@gandalf.local.home>
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

On Tue, 7 Feb 2023 13:51:47 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The kprobe probepoint.tc test started failing because of the added __pfx_
> symbols that were added because of -fpatchable-function-entry=X,Y causing
> unwinders to see them as part of the previous functions. But kprobes can
> not be added on top of them. The selftest looks for tracefs_create_dir and
> picks it and the previous and following functions to add at their address.
> This caused it to include __pfx_tracefs_create_dir which is invalid to
> attach a kprobe to and caused the test to fail.
> 
> Fixes: 9f2899fe36a62 ("objtool: Add option to generate prefix symbols")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

This is assuming that kprobes can not be added on top of these. But another
solution could be to have kprobes just pick the function the __pfx_ is for.
Would that be a better solution?

-- Steve
