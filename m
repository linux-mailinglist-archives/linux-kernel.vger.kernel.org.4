Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29676A46D5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjB0QQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjB0QQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:16:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4847F23328;
        Mon, 27 Feb 2023 08:16:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD42460EA7;
        Mon, 27 Feb 2023 16:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE044C433D2;
        Mon, 27 Feb 2023 16:16:27 +0000 (UTC)
Date:   Mon, 27 Feb 2023 11:16:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        contact@pgazz.com
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 rcu_core
Message-ID: <20230227111626.463b8f85@gandalf.local.home>
In-Reply-To: <CAABZP2zZHQ22MPsWkPZ5kPW5SNDPt0mT37xw3f4VNLeBsxRPvw@mail.gmail.com>
References: <CAABZP2z+Hk_w7nAhhyhJA9zidQViibMUO_xYianfm3xcG1QQwQ@mail.gmail.com>
        <D59B7575-FAB1-4446-BBA9-DF5EAA1B5DCA@joelfernandes.org>
        <20230227103257.4b99b6fb@gandalf.local.home>
        <CAEXW_YT6_cSaEODPu3HLWUB5kJhs6U=CQrQ4v4ODKtk-D+Bzug@mail.gmail.com>
        <CAABZP2zZHQ22MPsWkPZ5kPW5SNDPt0mT37xw3f4VNLeBsxRPvw@mail.gmail.com>
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

On Tue, 28 Feb 2023 00:11:51 +0800
Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:

> > Yes certainly, the rcu_head is allocated on the caller side so it
> > could have been trampled while the callback was still in flight.  
> Thank you all for your guidance, I learned a lot during this process
> >  
> > > OR it could be a bug with RCU if the synchronize_rcu() ended before the
> > > grace periods have finished.  
> Thanks again.
> 
> By the way, the syzkaller on my local machine has been running for 8
> hours, only three bugs reported[1][2][3], but they don't seem to be
> related to Sanan's original report.
> Maybe there are some configuration mismatches between us.The test
> continues,  I will report to you once I have any new discovery.

Note, the above races (either bug, the one that tramples on something in
RCU flight, or a synchronize_sched() returning early) may be extremely hard
to hit. It could have been the planets were lined up just right to hit the
bug, and won't happen for another 27,000 years.

-- Steve
