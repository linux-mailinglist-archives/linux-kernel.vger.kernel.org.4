Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4916251BF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiKKDhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiKKDhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:37:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F1F5B5AD;
        Thu, 10 Nov 2022 19:37:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF14360B43;
        Fri, 11 Nov 2022 03:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C240C433D7;
        Fri, 11 Nov 2022 03:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668137834;
        bh=BW+6NiGC5bV2CUlC2KS1G+poCUzcj9JDfXA/NeRzZrI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l5Q2PopPs/PKzl3JPfBH3E4n3kUXXoMGQvSo+Monx+poaVzminou5lZLiPiKjxvv9
         WRAiddvCrJasedjQ/HyrH0R84LTl94U2iJmVCa2GapKljxiTUtGRe0itAn6/QEyhNa
         8r/hd+H3lE/m6VYIByKPts/jboIKDvrhRFjFzhV5MV2pRDaflPoibEN4cAMe/gZJiT
         FGzgGoXjKq1xLh3by9bH1ehqxsMD7FpxNHH548xcUEkCgguGg88nIl6cO7uVYIt6n9
         g5zeYqJ7bmrbGMUW9CvrEAA0QtzlTipqXfFVo8rCbHY9S2tpsAEHnh+rNA3noVVPK2
         PNeaRUU5CWzjA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3EA625C13DD; Thu, 10 Nov 2022 19:37:12 -0800 (PST)
Date:   Thu, 10 Nov 2022 19:37:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Subject: Re: RCU stall on 6.1-rc4 (and some previous releases) related to
 ftrace
Message-ID: <20221111033712.GO725751@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1ef5fe19-a82f-835e-fda5-455e9c2b94b4@igalia.com>
 <20221110191651.3a177417@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110191651.3a177417@rorschach.local.home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 07:16:51PM -0500, Steven Rostedt wrote:
> On Thu, 10 Nov 2022 18:25:41 -0300
> "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> 
> > @@ -4184,6 +4184,7 @@ match_records(struct ftrace_hash *hash, char *func, int len, char *mod)
> >  		if (rec->flags & FTRACE_FL_DISABLED)
> >  			continue;
> >  
> > +		cond_resched();
> >  		if (ftrace_match_record(rec, &func_g, mod_match, exclude_mod)) {
> >  			ret = enter_record(hash, rec, clear_filter);
> >  			if (ret < 0) {
> 
> This isn't where I would put it. I would add it after the if statement.
> That is, at the end of the loop.

I am good either way.  Though one could argue for putting it at the
beginning of the loop in case every element takes that "continue" above...

							Thanx, Paul
