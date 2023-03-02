Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8930F6A835E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCBNTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCBNTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:19:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658F418140;
        Thu,  2 Mar 2023 05:18:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 052CD615B0;
        Thu,  2 Mar 2023 13:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A88C433EF;
        Thu,  2 Mar 2023 13:18:57 +0000 (UTC)
Date:   Thu, 2 Mar 2023 08:18:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 0/2] tracing: Fix adding some modifiers to histogram
 values
Message-ID: <20230302081855.7ee88b32@gandalf.local.home>
In-Reply-To: <20230302010051.044209550@goodmis.org>
References: <20230302010051.044209550@goodmis.org>
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


I forgot to add Tom Zanussi on this series.

-- Steve


On Wed, 01 Mar 2023 20:00:51 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Mark Rutland reported to me on IRC that he accidentally added the
> ".buckets=8" modifier to hitcount. This should not be allowed, but it
> did not error. Worse yet, when reading the hist file, it would crash
> as there was a NULL pointer dereference due to the values not having
> fields assigned to them.
> 
> The first fix is to make sure that histogram values do not get assigned
> modifiers that they can't use.
> 
> The the second patch is to not crash if a NULL pointer is passed to
> hist_field_name() (which is what happens if you allow some of these
> modifiers to be used by values).
> 
> Steven Rostedt (Google) (2):
>       tracing: Do not let histogram values have some modifiers
>       tracing: Check field value in hist_field_name()
> 
> ----
>  kernel/trace/trace_events_hist.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

