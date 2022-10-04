Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27DA5F481E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJDRPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJDRPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:15:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C83233A9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:15:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F146F614DA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 17:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60157C433D6;
        Tue,  4 Oct 2022 17:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664903717;
        bh=mGnX35o3y1NNdpCSMlejw46q4AM700HTmz9Es/OfI7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aem2PfxUwzcAtdp/4gwiBW4foLdCqlY75A9d4bOftRj3DeXAZeQ7mUDhJ3pzR52ld
         XJEo6dsMtjcxvjSJOZGivS1jn3aeu+RxVi1f+y3/R9SJA/NN3gZzMnVgh7yR06lPbx
         +P1dGn3XFeJyzSnOc2m5eXwzzm+uU7RcJUZwZ1EL8RDWbbfY5ODJzLb2Lhev1RxudX
         2XHSNC23/Oi6YqSCnU6CFinQOysLNhihm/9k2X+SHpAL/RzhgcIlqy9JlkOy4yjwDn
         wEwcWA/sWbM58krWJywf81salJN34dOrsHEI+DrVXXrRqxz/946mH3hcjl5ejdpQ+n
         ywKsAPQreqGwQ==
Date:   Tue, 4 Oct 2022 18:15:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>, Dao Lu <daolu@rivosinc.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y
Message-ID: <YzxqH095FxqKZpDg@spud>
References: <2546376.ElGaqSPkdT@phil>
 <2E96A836-764D-4D07-AB79-3861B9CC2B1F@jrtc27.com>
 <13396584.uLZWGnKmhe@phil>
 <CAOnJCUKdBpbj=KDz5oibB_N_SjOiMrkWcttczuGbisi_nMWaVA@mail.gmail.com>
 <Yy+Plxzj4bckXrhy@spud>
 <CAOnJCU+fA-pxLPRviqW2d7q-E__qJYkZKkCdiNHXhJBjWCRPaA@mail.gmail.com>
 <YzS5kT2CCBPxqLg+@spud>
 <CAOnJCUKn-rNwyw5BK7=hNM-vnJ=VROjipCiDtB4BL=LZ3kKAAg@mail.gmail.com>
 <YzifTW5Y7O191gCo@spud>
 <CAOnJCUKtoiXKaS81BZyvpybFDkh-undHLqE5ZxoNmf9AtAtvfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOnJCUKtoiXKaS81BZyvpybFDkh-undHLqE5ZxoNmf9AtAtvfw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 09:52:41AM -0700, Atish Patra wrote:
> On Sat, Oct 1, 2022 at 1:13 PM Conor Dooley <conor@kernel.org> wrote:

> > > Thanks. It would be good to understand what happens when "pause" is
> > > executed on these boards ?
> >
> > The actual pause instruction? uhh, so with the usual "I don't know what
> > I am doing" disclaimer, I ran each of the .insn and pause instruction 48
> > times in a row and checked the time elapsed via rdcycle & then ran that
> > c program 1000 times in a bash loop. Got the below, the insns were run
> > first and then the pauses.
> >         insn    pause
> > min     2.3     3.2
> > max     9.5     10.6
> > avg     27.0    29.1
> > 5%      2.9     4.2
> > 95%     18.1    19.1
> >
> > Swapping the pause & insn order around made a minor difference, but not
> > enough to report on. I'd be very wary of drawing any real conclusions
> > from this data, but at least both are roughly similar (and certainly not
> > even close to doing the div w/ zero args.
> >
> 
> Yeah. That's what I was expecting. So we can't drop the div for now. Otherwise,
> the existing hardware(don't support Zhintpause) suffers by spinning faster.
> 
> Thanks for running the experiments.

I've lost track, does that mean the patch is okay as, is or needs to be
changed? The former, right?

Thanks,
Conor.
