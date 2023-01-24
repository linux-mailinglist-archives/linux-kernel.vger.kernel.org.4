Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF6E67A593
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjAXWUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjAXWUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:20:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2580D37F2F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:19:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7398B81714
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 22:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A44BC433EF;
        Tue, 24 Jan 2023 22:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674598796;
        bh=9iFrfubPvHkXkZRsBFgVQ8F91LkJAJBVgFQiapRHzs8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jhlMb2hzv21TpaaPbTaED6UyekpkT8jIYa6+GIj23XJuGXGb8PtviQIAAU4ycOARm
         8NoT/uGSjJrceFO4ZmwrICiNr5fuUgLgOrXcJ0Mz1MulHkdLsCJWRr+w8pIBMk0xau
         XEOxJa0Xj/eJ93L+S57JBMl6ibmHQtC7mGxGlUpV32q49lkuKmzucZrGI/E5vG8TIW
         4LI3t+6xymiLdR6Jn2lmMd5dqIyGyTqv9a95FNi1uJ/xvG0AVGVCJ1MQ+HV5W83/CM
         +pY5KOGLT6VW7I1fYgHthvXh/81nCO+dGLyFrhyAXnBrNpbzM/33ThIIuy1EwkVTEl
         xkJ6wpK16iSuw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0D3055C1183; Tue, 24 Jan 2023 14:19:56 -0800 (PST)
Date:   Tue, 24 Jan 2023 14:19:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/memory-model Flag suspicious use of srcu cookies
Message-ID: <20230124221956.GX2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230124143951.23372-1-jonas.oberhauser@huaweicloud.com>
 <Y9ATHMm/iVG8goln@rowland.harvard.edu>
 <20230124191535.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9BFDYUykYBqjfw1@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9BFDYUykYBqjfw1@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 03:52:29PM -0500, Alan Stern wrote:
> On Tue, Jan 24, 2023 at 11:15:35AM -0800, Paul E. McKenney wrote:
> > Thank you both!
> > 
> > I wordsmithed the commit log as follows, but then realized that this
> > depends on Alan's earlier patch.
> > 
> > Did I miss the official version?  The latest one I have is
> > message-id Y8q9zjxA620GAFu2@rowland.harvard.edu.
> 
> I wanted to update the patch description before submitting it 
> officially, but I haven't gotten around to it yet.

Would you like to queue Jonas's patch in the meantime?

Either way works for me, give or take forgetfulness.

							Thanx, Paul
