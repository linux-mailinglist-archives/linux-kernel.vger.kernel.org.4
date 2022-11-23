Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825F0636BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 22:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbiKWVC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 16:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbiKWVCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 16:02:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDF22A96D;
        Wed, 23 Nov 2022 13:02:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA188B82488;
        Wed, 23 Nov 2022 21:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C96C433C1;
        Wed, 23 Nov 2022 21:02:47 +0000 (UTC)
Date:   Wed, 23 Nov 2022 16:02:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Rafael Mendonca <rafaelmendsr@gmail.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Fix race where eprobes can be called before
 the event
Message-ID: <20221123160246.348c11b4@gandalf.local.home>
In-Reply-To: <20221118211809.701d40c0f8a757b0df3c025a@kernel.org>
References: <20221117214249.2addbe10@gandalf.local.home>
        <20221118211809.701d40c0f8a757b0df3c025a@kernel.org>
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

On Fri, 18 Nov 2022 21:18:09 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> This looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> BTW, would other trigger callbacks also need to add similar checks?

I just checked, and yes, I think that histograms (the only other trigger
that has EVENT_CMD_FL_NEEDS_REC set) has the same issue, and requires:

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 087c19548049..1c82478e8dff 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5143,6 +5143,9 @@ static void event_hist_trigger(struct event_trigger_data *data,
 	void *key = NULL;
 	unsigned int i;
 
+	if (unlikely(!rbe))
+		return;
+
 	memset(compound_key, 0, hist_data->key_size);
 
 	for_each_hist_key_field(i, hist_data) {


I'll add that next.

-- Steve
