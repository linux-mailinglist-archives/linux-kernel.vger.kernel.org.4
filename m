Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DBA6FC97D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbjEIOva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbjEIOv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:51:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E79E6A;
        Tue,  9 May 2023 07:51:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25B5B60B3A;
        Tue,  9 May 2023 14:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D41CC433D2;
        Tue,  9 May 2023 14:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683643886;
        bh=PSuly6IqXkBhVavF6HVipVlpYPya9EjQa9lgfCgsi+0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MhaCSWZs9T3/Sy230PJYTRtWP2wNeoDMloajhpkNztUTJq3krTV8okrWy1zqeN2XG
         nvxq7wxOof2jiR5ym0Zdc4McOInxY9QsffhOWpxAVQP35zu+zbuL69ZRlUgEM80RIu
         lp4nJcC3TggBkEUYr+BwFTivpb9j+zXqb6O0HscIeLeRtL4Zok/ZH2Ure/Y5lUUbZ2
         HwOTwXenNMy6DkSr/HE6hHtGbRxKKvBKQOBs1M4GrfUBxfe1kEx1VJoO2MPYsE8V/K
         0DlbkYTw8pUB/mSMb9B1iddBADg5H/+8kqdjDlASAgwOMtqEBIkD/UUh0nWS+7b6TS
         tC5ExHfL4tpWg==
Date:   Tue, 9 May 2023 23:51:21 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v9.1 01/11] fprobe: Pass return address to the handlers
Message-Id: <20230509235121.28974ab2b5341eade5491a35@kernel.org>
In-Reply-To: <20230505112134.34669200@gandalf.local.home>
References: <168299383880.3242086.7182498102007986127.stgit@mhiramat.roam.corp.google.com>
        <168299384798.3242086.3958932989430895961.stgit@mhiramat.roam.corp.google.com>
        <20230505112134.34669200@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023 11:21:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  2 May 2023 11:17:28 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Pass return address as 'ret_ip' to the fprobe entry and return handlers.
> 
> The change log tells us "what" but not "why".

Indeed, and thanks, I almost forgot the reason why I introduced it :(
This is actually for fprobe_exit_handler() to pass the return address to
user handler so that the fprobe-events can show the return address correctly.
When I implemented the fprobe-events, I found this was required but splitted
from the main fprobe event patch but forgot to update the description.

Let me update it.

Thank you!

> 
> -- Steve
> 
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
