Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5032065F050
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbjAEPmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbjAEPmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:42:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00469559C6;
        Thu,  5 Jan 2023 07:42:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FABE61B0B;
        Thu,  5 Jan 2023 15:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9863C433EF;
        Thu,  5 Jan 2023 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672933350;
        bh=rYLLvAR7qCxC2NW9cBbIijuxkUi6aKDT/oIR1nZIP0M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cg04Q+e7do/v/m0+12IJZWJ5GKocxU/KF12DQzObMGjVXX9zK8O0gph4aU/xSBjNx
         XweZrbr+bDOZ1UG0T7I6sw0qsJi5rwZe8j+Zd0tlid4bfLI3vjiF++Ol4qCdw4NWbN
         JnR23TehDqtluNXjLUXseVhVlzICw8Md/oc+7Ek7lvMHjB+6ohWp+/+uL/XyziPQ5E
         IE2vCl5thcdTljW5u1t+90Dzbl2rnmNqxevHP2wxY8xYjiFoLTSNmL3XgLIdCkFLvt
         F5NETytG4OcOyo7+Pqr3JA++hk4k1tw9L5iexaPMj1IGLTbgGh6JH2DHgAsPH7p+Fe
         bKIZ4rIMH4xRQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 81DA35C029A; Thu,  5 Jan 2023 07:42:29 -0800 (PST)
Date:   Thu, 5 Jan 2023 07:42:29 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH rcu 02/27] arch/arm64/kvm: Remove "select SRCU"
Message-ID: <20230105154229.GU4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-2-paulmck@kernel.org>
 <86mt6x724m.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86mt6x724m.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 09:38:01AM +0000, Marc Zyngier wrote:
> On Thu, 05 Jan 2023 00:37:48 +0000,
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > Kconfig statements.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Alexandru Elisei <alexandru.elisei@arm.com>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Oliver Upton <oliver.upton@linux.dev>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: <linux-arm-kernel@lists.infradead.org>
> > Cc: <kvmarm@lists.linux.dev>
> > Cc: <kvmarm@lists.cs.columbia.edu>
> > ---
> >  arch/arm64/kvm/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> > index 05da3c8f7e88f..312f0e9869111 100644
> > --- a/arch/arm64/kvm/Kconfig
> > +++ b/arch/arm64/kvm/Kconfig
> > @@ -28,7 +28,6 @@ menuconfig KVM
> >  	select KVM_MMIO
> >  	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
> >  	select KVM_XFER_TO_GUEST_WORK
> > -	select SRCU
> >  	select KVM_VFIO
> >  	select HAVE_KVM_EVENTFD
> >  	select HAVE_KVM_IRQFD
> 
> Acked-by: Marc Zyngier <maz@kernel.org>

Thank you, Marc!  I will apply this on my next rebase.

							Thanx, Paul

> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
