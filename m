Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124C1607E61
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJUSmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJUSlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:41:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C4445F78;
        Fri, 21 Oct 2022 11:41:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9B2860DD5;
        Fri, 21 Oct 2022 18:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3581AC433D6;
        Fri, 21 Oct 2022 18:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666377713;
        bh=chtt76ZiBhKV/x6D5wSTJFrTNA5Y435F6vH3R9VYlbQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=u9AIeLg+ua1xpmQS/9Y3zbArzqw+qFzf5K3T1tACqzbOWIHBKd/WGrAScY0IR+Pe1
         VEutOo5F5D6r25Gw/H3xjclTqzIFz8JXZaUEZhb8+aU7IZNqoMeA9fRBOJfuRIcFC8
         69KWIU4MKOf5lvK4KzpDMHjL27eE4eLf8baGLv2vJ4kS1K1uzvfGIS3Y/TD7aYayJ0
         mWgffY1aeiV6xNCT68AV43FUJ+E1hGPxWbPji0Cq+gSlEGTxGiy26aL2r4jnLKT0zS
         gLAYAWgHXQTXmg55b78wHs+XOQAb40KNcBm4Ru2k6nRHb1AqodHTIi3oFsHIRb+MkS
         xHeMHLYJF+S6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D61655C0543; Fri, 21 Oct 2022 11:41:52 -0700 (PDT)
Date:   Fri, 21 Oct 2022 11:41:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, tglx@linutronix.de, pmladek@suse.com
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
Message-ID: <20221021184152.GO5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <87k04x4e0r.fsf@jogness.linutronix.de>
 <20221018152418.GR5600@paulmck-ThinkPad-P17-Gen-1>
 <87ilkh0y52.fsf@jogness.linutronix.de>
 <20221018185936.GX5600@paulmck-ThinkPad-P17-Gen-1>
 <20221018215721.GA1716567@paulmck-ThinkPad-P17-Gen-1>
 <87pmeoawwe.fsf@jogness.linutronix.de>
 <20221019191418.GF5600@paulmck-ThinkPad-P17-Gen-1>
 <20221019220537.GA1234896@lothringen>
 <20221020222718.GA5600@paulmck-ThinkPad-P17-Gen-1>
 <87r0z1gy51.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0z1gy51.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 02:33:22PM +0206, John Ogness wrote:
> On 2022-10-20, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > I have an untested but allegedly fixed branch on -rcu on branch
> > srcunmisafe.2022.10.20a.
> 
> FWIW, my C-I build system was happy with srcunmisafe.2022.10.20a.

And srcunmisafe.2022.10.21a diffs equal, so it hopefully also passes
your C-I.  ;-)

							Thanx, Paul
