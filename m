Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC934602F01
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiJRO5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJRO5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:57:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E023D9964;
        Tue, 18 Oct 2022 07:57:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B85856147F;
        Tue, 18 Oct 2022 14:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FBCC433D6;
        Tue, 18 Oct 2022 14:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666105070;
        bh=zMhCwD7bLGnkSr2Cl4g6quQtgr4tL0XMRHbB2k9a2Vk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uATKDw14PNFiBXKHPbyuVe78a7tYtJIQlele13GSgxzawkwKAmLGNB6yif+cShxSe
         kYiCvz/Zf8Ry3kxaNsmVkDKuXzL6q8toiGMrRYQ5viK1n0M4vmdwnjHN4GRyvqMwLz
         9sm22rryYo1EXujcjFhmDbfoOqHMEYv7s5uQcTlxkvg9PvUL+hVYRuqUYUCJi5d2/w
         AwnjBI9CT+8R90mlpxAYVlBgl8fBG9CLc7fgTe15xhKjEzSS7u3EJ40sj7Dg3FHt41
         iRoWSExOHsnfvd0+0k333cSxywzP2nVs11HweMteVzMlk6VN6Q+Se8rnMhDERo6pSf
         LTxCiw6+cMhxw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BB1BD5C0528; Tue, 18 Oct 2022 07:57:49 -0700 (PDT)
Date:   Tue, 18 Oct 2022 07:57:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the rcu tree
Message-ID: <20221018145749.GN5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221018102636.347615f8@canb.auug.org.au>
 <20221018104356.GB1166572@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018104356.GB1166572@lothringen>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 12:43:56PM +0200, Frederic Weisbecker wrote:
> On Tue, Oct 18, 2022 at 10:26:36AM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the rcu tree, today's linux-next build (x86_64 allmodconfig)
> > failed like this:
> > 
> > ERROR: modpost: "srcu_check_nmi_safety" [arch/x86/kvm/kvm.ko] undefined!
> > ERROR: modpost: "srcu_check_nmi_safety" [arch/x86/kvm/kvm-intel.ko] undefined!
> > ERROR: modpost: "srcu_check_nmi_safety" [arch/x86/kvm/kvm-amd.ko] undefined!
> > ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/rcutorture.ko] undefined!
> > ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/rcuscale.ko] undefined!
> > ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/refscale.ko] undefined!
> > ERROR: modpost: "srcu_check_nmi_safety" [fs/dlm/dlm.ko] undefined!
> > ERROR: modpost: "srcu_check_nmi_safety" [drivers/pci/controller/vmd.ko] undefined!
> > ERROR: modpost: "srcu_check_nmi_safety" [drivers/char/ipmi/ipmi_msghandler.ko] undefined!
> > ERROR: modpost: "srcu_check_nmi_safety" [drivers/gpu/drm/drm.ko] undefined!
> > WARNING: modpost: suppressed 10 unresolved symbol warnings because there were too many)
> > 
> > Presumably caused by commit
> > 
> >   54a118fce487 ("srcu: Debug NMI safety even on archs that don't require it")
> 
> My bad. This commit indeed lacks this (Paul can you add the following
> line on that commit?):
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 382236dd5e46..bcd629f5f902 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -651,6 +651,7 @@ void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe)
>  	}
>  	WARN_ONCE(old_nmi_safe_mask != nmi_safe_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_nmi_safe_mask, nmi_safe_mask);
>  }
> +EXPORT_SYMBOL_GPL(srcu_check_nmi_safety);
>  #endif /* CONFIG_PROVE_RCU */

On my list for the next rebase, thank you both!  Along with kernel
test robot.  ;-)

							Thanx, Paul
