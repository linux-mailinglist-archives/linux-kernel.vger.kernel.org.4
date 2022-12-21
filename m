Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0582652AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiLUA7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiLUA7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:59:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4189FC6;
        Tue, 20 Dec 2022 16:59:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48E9EB81ADB;
        Wed, 21 Dec 2022 00:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF67C433EF;
        Wed, 21 Dec 2022 00:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671584340;
        bh=Jjg3RuhlIBepTZq0rBQOcgcpTBE7WewrQRtghSQ2uL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AaA8qaOSDsMfK2V9fqLnfIRZ28z+cut/Qwn0MRRmmlo0s8vtSVfVtPZB/63WNmDzF
         YUv7whEYRqqDPymuCacyBNWj3dG2CQSFWat5TLO6HNopSAgzjjDY/jyFlhwBBBgkPZ
         XcKecfEebzJQ54Sh0kbKkUkpYjrHuyMrOIgMeoKzIYRCWQxuMDApSKlXqWlPx8tu3Y
         2xSHxU5A8epYj6ZdRftFf5JhLqZ8EzfKY28lD8ebtj97WZGP8JwdIiPSIr+DhBnFAM
         uTC0NclOXLxFU664aC5M3czn4xlnCkmU4mrHd9bG3I6JEBWbnBgYIQKvjX/8h+UdPL
         D3HyTNzEdPgTA==
Date:   Wed, 21 Dec 2022 01:58:58 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Message-ID: <20221221005858.GA29316@lothringen>
References: <20221220140714.GB22763@lothringen>
 <CA83E649-8C79-4D39-9BFE-BBEF95968B98@joelfernandes.org>
 <20221220224459.GA25175@lothringen>
 <CAEXW_YSAv+MzZoW9RK9H3E6DAyZH+wB=4bMy5nXTOExSwgSwAg@mail.gmail.com>
 <20221221004957.GA29021@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221004957.GA29021@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 01:49:57AM +0100, Frederic Weisbecker wrote:
> On Tue, Dec 20, 2022 at 07:15:00PM -0500, Joel Fernandes wrote:
> > On Tue, Dec 20, 2022 at 5:45 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > Agreed about (1).
> > 
> > > _ In (2), E pairs with the address-dependency between idx and lock_count.
> > 
> > But that is not the only reason. If that was the only reason for (2),
> > then there is an smp_mb() just before the next-scan post-flip before
> > the lock counts are read.
> 
> The post-flip barrier makes sure the new idx is visible on the next READER's
> turn, but it doesn't protect against the fact that "READ idx then WRITE lock[idx]"
> may appear unordered from the update side POV if there is no barrier between the
> scan and the flip.
> 
> If you remove the smp_mb() from the litmus test I sent, things explode.

Or rather, look at it the other way, if there is no barrier between the lock
scan and the index flip (E), then the index flip can appear to be written before the
lock is read. Which means you may start activating the index before you finish
reading it (at least it appears that way from the readers pont of view).
