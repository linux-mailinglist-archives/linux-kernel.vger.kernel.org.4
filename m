Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E3B66E848
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjAQVQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjAQVPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:15:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3353B0D4;
        Tue, 17 Jan 2023 11:37:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED4D861514;
        Tue, 17 Jan 2023 19:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EB4C433D2;
        Tue, 17 Jan 2023 19:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673984255;
        bh=t6g2SSM3g8PpaGH31BjO5/jj+xwDslS5NO8uD6va4Dk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qiDs3bkWnP14mvlyz7SIVFjUhWxhf1YTO3Uo5P5IO9Uvne5aFZKEYmG863Nw4vURX
         tgoCvlVbtnp7BYXhiqgGFVqE7TcmuqiQ6SZqzDwyvgUAb+alPnKxZrGK/x50chrimo
         pH67AEptS+Ku9QSetT2pM6ynOhjPxZWbI6UXJo9/+ypiM7jcxsnsLwGL/XI1zR35jn
         Pfk3rZC2w6QVnzmicuojaHfU4AZq9fCYQLRo2VrutsctsE82FS8JjKBSWT33lkESda
         SREPYLkesLoRvWxhH7oeQWAHjWw3VDbLnoh13DDCb1gYoLipDGuYA2mCJeOoL4M/I4
         xMCKC3tLlk/cg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F23A35C0543; Tue, 17 Jan 2023 11:37:34 -0800 (PST)
Date:   Tue, 17 Jan 2023 11:37:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, fweisbec@gmail.com, urezki@gmail.com
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu: Track laziness during boot and
 suspend
Message-ID: <20230117193734.GO2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230112005223.2329802-1-joel@joelfernandes.org>
 <20230115162504.08ef72b0@rorschach.local.home>
 <CAEXW_YSNurO-hK+q2amP6wa96jr0KkZ_ggF+5x_sTHESC9vpNw@mail.gmail.com>
 <20230117143224.6fbf7da8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117143224.6fbf7da8@gandalf.local.home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 02:32:24PM -0500, Steven Rostedt wrote:
> On Sun, 15 Jan 2023 16:34:58 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > > > +EXPORT_SYMBOL_GPL(rcu_async_hurry);
> > > >  
> > >
> > > Where do you plan on calling these externally, as they are being
> > > marked exported?
> > >
> > > If you allow random drivers to enable this, I can see something
> > > enabling it and hitting an error path that causes it to never disable
> > > it.  
> > 
> > You mean, just like rcu_expedite_gp() ?
> > 
> > > I wouldn't have EXPORT_SYMBOL_GPL() unless you really know that it is
> > > needed externally.  
> > 
> > At the moment it is not called externally but in the future, it could
> > be from rcutorture. If you see rcu_expedite_gp(), that is exported
> > too. I was just modeling it around that API.
> 
> The reason for the export should have been mentioned in the change log if
> the patch is not obvious to why it is being exported.

Would something like this suffice?  With attribution, of course.

	Export rcu_async_should_hurry(), rcu_async_hurry(), and
	rcu_async_relax() for later use by rcutorture.

							Thanx, Paul
