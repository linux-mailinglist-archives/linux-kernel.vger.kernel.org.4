Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A9A64E581
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 02:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiLPBB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 20:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiLPBBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:01:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678EC18E16;
        Thu, 15 Dec 2022 17:01:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 166C9B81CFD;
        Fri, 16 Dec 2022 01:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17D4C433D2;
        Fri, 16 Dec 2022 01:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671152478;
        bh=5/rE1fJuD0tDNw8jKIlNkk3sa5LNmeVxQaC+Mp6A0fo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=V9CjPsd1doCb+tL3Ulb6W9aZLHFYnbwas+X7imQ5ez9JbGtECyglHIQf0ndZkUkmY
         CN9ZRAcaP69tEW5/btVv68wS+pEunYgekuBIkDpe8VToO2ArN8x72GADbvqudPAJ3w
         Ju7uhxth9ZtOO3c8n6L9ytmwitAFj/SbsDXQXfhxr2lGsGfc+wBg6LLpZTqa8xvYxX
         gawK3m5tHxAp3oQGB+LIPFX9LktR7XID02baIO8vARIxQIzGuxe70W7O9IHHlYqlnJ
         /cbCNQRCYLhUc6+guIOsLHaWfg1JGK4RZ6vw4KG4vLF9KquNvpnsmAKeXj9CaAlEPK
         Uw0TSf2ryCvZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 29FEF5C1C5B; Thu, 15 Dec 2022 17:01:18 -0800 (PST)
Date:   Thu, 15 Dec 2022 17:01:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Do not synchronize freeing of trigger filter on
 boot up
Message-ID: <20221216010118.GU4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221213172429.7774f4ba@gandalf.local.home>
 <20221214084954.e759647a2f5f1a38bc78b371@kernel.org>
 <20221214200333.GA3208104@paulmck-ThinkPad-P17-Gen-1>
 <20221215100241.73a30da8@gandalf.local.home>
 <20221215170256.GG4001@paulmck-ThinkPad-P17-Gen-1>
 <20221215135102.556ee076@gandalf.local.home>
 <20221215190158.GK4001@paulmck-ThinkPad-P17-Gen-1>
 <20221215173913.5432bfbf@gandalf.local.home>
 <20221215231027.GS4001@paulmck-ThinkPad-P17-Gen-1>
 <20221215184202.7ebb3055@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215184202.7ebb3055@gandalf.local.home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 06:42:02PM -0500, Steven Rostedt wrote:
> On Thu, 15 Dec 2022 15:10:27 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > The nice thing about the current placement of rcu_scheduler_starting()
> > is that there is not yet any other task to switch to.  ;-)
> 
> Fair enough. Anyway the last patch appears to do the job.
> 
> Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Applied, thank you!

							Thanx, Paul
