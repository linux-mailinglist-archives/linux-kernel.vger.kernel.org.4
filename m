Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C37863DF42
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiK3SpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiK3So7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:44:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590002E9FE;
        Wed, 30 Nov 2022 10:44:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 068CEB81CAB;
        Wed, 30 Nov 2022 18:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB92C433C1;
        Wed, 30 Nov 2022 18:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669833895;
        bh=Z9dPkND220ZAmEQ7/jpi3H9A0H45YTn6OxAzn+3/thI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uuI9FssGzzIFmXPY8Lq3/hQ/ig1Xsc/MGy3M6AfUqsnrGOomAmc+KNsKef1r5jTlG
         KJOlJr4+d6y6QjaT8HDM5GiBdugPHbaaZdTguGWypM+Nm98N/I67uDeJb7NSa3fM/X
         McKA+GPt3dOveu0Ar9uD8dXAoXDbhUeBqFq9Duy85EPoawPSWtK6eYRtYNR4x1YUma
         N2drid4XivobcgMUalqIA/HaHz17HlrqX8jKPIdErkee4ilE/JaMUyiQNGlYhL1EQg
         qxnK7ZHDGI02Cg9mp6OFN2wSRFL44lYW0X8CporW5+hCoYbNBtRgnpDPMd2rnebzt3
         TqaHZ98Iycq8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4708B5C051C; Wed, 30 Nov 2022 10:44:55 -0800 (PST)
Date:   Wed, 30 Nov 2022 10:44:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 3/4] rcu/kvfree: Move need_offload_krc() out of
 krcp->lock
Message-ID: <20221130184455.GQ4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221129155822.538434-1-urezki@gmail.com>
 <20221129155822.538434-4-urezki@gmail.com>
 <20221129233833.GA154809@paulmck-ThinkPad-P17-Gen-1>
 <Y4dS8X+Ir7egYBTD@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4dS8X+Ir7egYBTD@pc636>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 01:56:17PM +0100, Uladzislau Rezki wrote:
> On Tue, Nov 29, 2022 at 03:38:33PM -0800, Paul E. McKenney wrote:
> > On Tue, Nov 29, 2022 at 04:58:21PM +0100, Uladzislau Rezki (Sony) wrote:
> > > Currently a need_offload_krc() function requires the krcp->lock
> > > to be held because krcp->head can not be checked concurrently.
> > > 
> > > Fix it by updating the krcp->head using WRITE_ONCE() macro so
> > > it becomes lock-free and safe for readers to see a valid data
> > > without any locking.
> > 
> > Don't we also need to use READ_ONCE() for the code loading this krcp->head
> > pointer?  Or do the remaining plain C-language accesses somehow avoid
> > running concurrently with those new WRITE_ONCE() invocations?
> >
> It can be concurrent. I was thinking about it. For some reason i decided
> to keep readers as a "regular" ones for loading the krcp->head.
> 
> In this case it might take time for readers to see an updated value
> as a worst case scenario.
> 
> So i need to update it or upload one more patch on top of v2. Should
> i upload a new patch?

Sending an additional patch should be fine.  Unless you would rather it
be folded into one of the existing patches, in which case please start
with the set that I have queued.

							Thanx, Paul
