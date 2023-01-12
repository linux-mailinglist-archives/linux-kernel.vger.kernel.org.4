Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11EE6687F5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbjALXtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjALXtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:49:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D0CA45F
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:49:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CDE0620B6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3DCC433EF;
        Thu, 12 Jan 2023 23:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673567347;
        bh=BcevPiRf8UY/AJwT94sbgP4EDRX7+fE8IDyw7absdro=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=re0hEjGl8khyXg4STA6MvB1NotzMYCt0F2XccTAFhX1ezXNRTwqi2uS7BGjAGGSGf
         ojGQ7jvavR0fE+uXJN0H9+8gL3/hIkTjqJAuNPavS2WtU8hglWUWHsOIkGb+MxMpEG
         a6sM+2+miUfY0W8VKxS92XGB+FX+15y+0Mc7Om8tHt80CK4yCMsJvlDRynSsigUF2W
         0rLnf2EZAVK/lSVmCdHv64SS6HXzzsrWLnqmG8kt2Gk3+sbF4Ir51OFevheCY7rsyr
         DlJSy/yq75AIGfItCJgz10bqpbdz3J01T2GyCBJ4kMz70jw4uhQ/xNB+EmcblevOfb
         v2suksHC0YCiQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4B7465C09F1; Thu, 12 Jan 2023 15:49:07 -0800 (PST)
Date:   Thu, 12 Jan 2023 15:49:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc:     "riel@surriel.com" <riel@surriel.com>,
        "davej@codemonkey.org.uk" <davej@codemonkey.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH diagnostic qspinlock] Diagnostics for excessive lock-drop
 wait loop time
Message-ID: <20230112234907.GT4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230112003627.GA3133092@paulmck-ThinkPad-P17-Gen-1>
 <896a2d84918e4adc8a4d00d72510eb3d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <896a2d84918e4adc8a4d00d72510eb3d@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 08:51:04PM +0000, Jonas Oberhauser wrote:
> Hi Paul,
> 
> -----Original Message-----
> From: Paul E. McKenney [mailto:paulmck@kernel.org] 
> > We see systems stuck in the queued_spin_lock_slowpath() loop that waits for the lock to become unlocked in the case where the current CPU has set pending state.
> 
> Interesting!
> Do you know if the hangs started with a recent patch? What codepaths are active (virtualization/arch/...)? Does it happen extremely rarely? Do you have any additional information?

As best we can tell right now, see it about three times per day per
million systems on x86 systems running v5.12 plus backports.  It is
entirely possible that it is a hardware/firmware problem, but normally
that would cause the failure to cluster on a specific piece of hardware
or specific type of hardware, and we are not seeing that.

But we are in very early days investigating this.  In particular,
everything in the previous paragraph is subject to change.  For example,
we have not yet eliminated the possibility that the lockword is being
corrupted by unrelated kernel software, which is part of the motivation
for the patch in my earlier email.

> I saw a similar situation a few years ago in a proprietary kernel, but it only happened once ever and I gave up on looking for the reason after a few days (including some time combing through the compiler generated assembler).

If it makes you feel better, yesterday I was sure that I had found the
bug by inspection.  But no, just confusion on my part!  ;-)

But thank you very much for the possible corroborating information.
You never know!

							Thanx, Paul
