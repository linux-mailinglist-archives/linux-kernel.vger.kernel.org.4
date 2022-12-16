Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576C064E6BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 05:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiLPEk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 23:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiLPEkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 23:40:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C81130F53;
        Thu, 15 Dec 2022 20:40:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3930A61FE6;
        Fri, 16 Dec 2022 04:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89072C433D2;
        Fri, 16 Dec 2022 04:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671165622;
        bh=+KkV+X3jVCfNaN9ygGX9jCP52xI05DFOAj7yDkZ5NUs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cGzRTsVowhMWII2SCk5Lmy1pmGDt8lQsKq7vOl4ndolECdsNsascpATgcNlrTkZ21
         KgUv5/0Q6ekRxdI7+PsyAXyuGsKJK1kVxmsYhfa4BvPaXQ1+CUPk4YEMVkFAmiyu0R
         QrgI0UNWYlh/2wLJFe4Yli21BEcvtDu/O2DwQmiTnLnt9nxD0EjGZXim/n7bZ+J0W7
         4/UhNwryhHlHQNlD6GCWnA6Cvb9RQ061vi+4e5ouAG69f1WE2cHzv5j8UeAY+gWIgL
         5lsH7VIy7/lKZtNDCEtpqECYHeSWyxfYJRY/yDCQ7Pqn6XNZFBwYfXU2M98e88su/+
         mY9r9Py/3I74w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 29C975C1C5B; Thu, 15 Dec 2022 20:40:22 -0800 (PST)
Date:   Thu, 15 Dec 2022 20:40:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Do not synchronize freeing of trigger filter on
 boot up
Message-ID: <20221216044022.GA2467686@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221214084954.e759647a2f5f1a38bc78b371@kernel.org>
 <20221214200333.GA3208104@paulmck-ThinkPad-P17-Gen-1>
 <20221215100241.73a30da8@gandalf.local.home>
 <20221215170256.GG4001@paulmck-ThinkPad-P17-Gen-1>
 <20221215135102.556ee076@gandalf.local.home>
 <20221215190158.GK4001@paulmck-ThinkPad-P17-Gen-1>
 <20221215173913.5432bfbf@gandalf.local.home>
 <20221215231027.GS4001@paulmck-ThinkPad-P17-Gen-1>
 <20221215184202.7ebb3055@gandalf.local.home>
 <20221216010118.GU4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216010118.GU4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 05:01:18PM -0800, Paul E. McKenney wrote:
> On Thu, Dec 15, 2022 at 06:42:02PM -0500, Steven Rostedt wrote:
> > On Thu, 15 Dec 2022 15:10:27 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > The nice thing about the current placement of rcu_scheduler_starting()
> > > is that there is not yet any other task to switch to.  ;-)
> > 
> > Fair enough. Anyway the last patch appears to do the job.
> > 
> > Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Applied, thank you!

And I should have checked up on urgency.  Normal process would hold this
one until the v6.3 merge window, but please let me know if you would
like it in v6.2.  It is after all a bug fix.

							Thanx, Paul
