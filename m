Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022596F664E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjEDHvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjEDHuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:50:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADFA35A2
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:50:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98197631B6
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFD4C433EF;
        Thu,  4 May 2023 07:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683186650;
        bh=+EwHUzp5vJUnfYrar71It4x2Lp1m5riSIiiWulMenKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PBh5syGFz84KqWEZYJukp+DtC9fl67HGByQFIvC8ov7rmJ4rOzoIlwgNXAAIyZbEc
         VVR/KTYvMnRUvGNzg8oB9qmWoziBB0/1CcU0TL5Z4pyyorN2t/rKucW4hHsAI2SbrQ
         lJA9AkwSQwvKE6e0RPhlOanpzg6xgLCS2WwiJTo+cbeIKkdnw60HvXGgmYoL1ZpUfI
         2g4TcUUF0sVYokDsax5F4CynDcaxTiBk2SVnuc0q/Xv+vHJesB0go4il2K0TdtOlFH
         3tHWQQsVKjZg8vD+YNegoANiW0CcvFyB8q0e5A6yXCla+LbhVefeq3YvAZTiBEu6+d
         YvMU1J1/DsRaw==
Date:   Thu, 4 May 2023 09:50:47 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Victor Hassan <victor@allwinnertech.com>, fweisbec@gmail.com,
        mingo@kernel.org, jindong.yue@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tick/broadcast: Do not set oneshot_mask except
 was_periodic was true
Message-ID: <ZFNj183r1APx/Wem@lothringen>
References: <20230412003425.11323-1-victor@allwinnertech.com>
 <87sfd0yi4g.ffs@tglx>
 <ZD/uWdz7dKLKlUqH@localhost.localdomain>
 <87jzy42a74.ffs@tglx>
 <ZFDxph8YDPjwvbej@lothringen>
 <87y1m652n2.ffs@tglx>
 <ZFLftU4sEgeEaRJe@lothringen>
 <87pm7h3u2n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pm7h3u2n.ffs@tglx>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 12:53:52AM +0200, Thomas Gleixner wrote:
> On Thu, May 04 2023 at 00:27, Frederic Weisbecker wrote:
> 
> > On Tue, May 02, 2023 at 02:38:57PM +0200, Thomas Gleixner wrote:
> >> Updated patch below.
> >> 
> >> Thanks,
> >
> > Looks good from my layperson's eyes, just a doubt about a comment below:
> >
> >> +
> >> +	/*
> >> +	 * When switching from periodic to oneshot mode arm the broadcast
> >> +	 * device for the next tick.
> >> +	 *
> >> +	 * If the broadcast device has been replaced in oneshot mode and
> >> +	 * the oneshot broadcast mask is not empty, then arm it to expire
> >> +	 * immediately in order to reevaluate the next expiring timer.
> >> +	 * nexttick is 0 and therefore in the past which will cause the
> >
> > Is nexttick really in the past? It's set to tick_next_period...
> 
> Only in the non-replacement, i.e. the 'from_periodic' codepath, no?

Bah, missed that, right.

A shy Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!

