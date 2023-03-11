Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB85B6B619B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 23:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCKW5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 17:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCKW5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 17:57:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7705ADC7;
        Sat, 11 Mar 2023 14:57:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4914B80B01;
        Sat, 11 Mar 2023 22:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81951C433D2;
        Sat, 11 Mar 2023 22:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678575457;
        bh=NRjBczy/HPk2CwSneiTQ9xUfvWYOCoTY2Vss4hP7PvM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=EIABw264Fz0h1+O03avqPudnZqPUVSGSUPKhqQeAI1/WoZ0AbezxUeEFlsAMtXWOD
         CaptaRyYmv8Ky4zohWR1casKUsIBzia4MrJk79oRhfP5FU5xUcRnhsQYEpVZWH+mCk
         +kG73APRzx7kE4meEZUQouc7q/MHcE6cql4oiKfnp9LcMpfjTaSoUo50QphJRdpZL3
         q1DNYWI30Q5T2HIbWeRNF9HtT/i3f1uNa0TWrcZLabGSXLaQBLExmwiVkRAqYu6ZBC
         COysTOFiZPQxB6Xi5OdFDiOIGwfz9rtQqa8INxM75TlDqYNjHauZhXew4q1mvZRa90
         e1p1lDXGVGBhA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1F610154037F; Sat, 11 Mar 2023 14:57:37 -0800 (PST)
Date:   Sat, 11 Mar 2023 14:57:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org, urezki@gmail.com
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <4b5f3af3-7df2-4300-9cb2-8b7da572cda1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230303213851.2090365-1-joel@joelfernandes.org>
 <20230304010251.GD1301832@paulmck-ThinkPad-P17-Gen-1>
 <20230304045145.GD2176990@google.com>
 <a9e974d1-2b83-44bc-ab2e-56ef9511c2ef@paulmck-laptop>
 <20230311222354.GA2367813@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311222354.GA2367813@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 10:23:54PM +0000, Joel Fernandes wrote:
> On Sat, Mar 11, 2023 at 12:44:53PM -0800, Paul E. McKenney wrote:
> > On Sat, Mar 04, 2023 at 04:51:45AM +0000, Joel Fernandes wrote:
> > > Hi Paul,
> > > 
> > > On Fri, Mar 03, 2023 at 05:02:51PM -0800, Paul E. McKenney wrote:
> > > [..]
> > > > > Qiuxu also noted impressive boot-time improvements with earlier version
> > > > > of patch. An excerpt from the data he shared:
> > 
> > Now that we have the measurement methodology put to bed...
> > 
> > [ . . . ]
> > 
> > > > Mightn't this be simpler if the user was only permitted to write zero,
> > > > thus just saying "stop immediately"?  If people really need the ability
> > > > to extend or shorten the time, a patch can be produced at that point.
> > > > And then a non-zero write to the file would become legal.
> > > 
> > > I prefer to keep it this way as with this method, I can not only get to
> > > have variable rcu_boot_end_delay via boot parameter (as in my first patch), I
> > > also don't need to add a separate sysfs entry, and can just reuse
> > > 'rcu_boot_end_delay' parameter, which I also had in my first patch. And
> > > adding yet another sysfs parameter will actually complicate it even more and
> > > add more lines of code.
> > > 
> > > I tested difference scenarios and it works fine, though I missed that
> > > mutex locking unfortunately, I did verify different test cases work as
> > > expected by manual testing.
> > 
> > Except that you don't need that extra sysfs value.  You could instead use
> > any of a number of state variables that tell you that early boot is done.
> > If the state says early boot (as in parsing the kernel command line),
> > make the code act as it does now.  Otherwise, make it accept only zero.
> > 
> > If there really is some system that wants to set one time limit via
> > the kernel boot parameter and set another at some time during boot,
> > there are very simple userspace facilities to make this happen.
> > 
> > And there is also a smaller state space and less testing to be done,
> > benefits which accrue on an ongoing basis.
> 
> Ok, thanks for the suggestion and I will consider it when/if posting the next
> revision of this idea. I got strong pushback from Frederic, Vlad and Steven
> Rostedt on doing the timeout-based thing, so currently I am analyzing the
> boot process more to see if it could be optimized instead. I tend to agree
> with them now also because this feature is new and there could be bugs that
> this patch might hide..

Agreed, fixing underlying causes is even better.

							Thanx, Paul
