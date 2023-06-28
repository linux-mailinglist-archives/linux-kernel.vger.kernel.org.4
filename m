Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B3B7412EC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjF1Nq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjF1Nqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:46:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B2F198E;
        Wed, 28 Jun 2023 06:46:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A92461336;
        Wed, 28 Jun 2023 13:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903A5C433C8;
        Wed, 28 Jun 2023 13:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687960010;
        bh=wgMMJMfTyVwxcOPMIJp46LB31ptEtKR4JfsP16lGm9k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=o++EuTxwQNKpUT8rchLW4uiFlCodtVJ9mCVTuOO26yZkA0sHg0HEImHXbydkQeByi
         aHgsv3bKxFKgbEbhyeB1g5cdgVlzTP6rgxSFtvrJWv99KIIzk0XL+nI1hdzckDnzvm
         aTqHOvxyUZ+yZzyfipOtQg9LZ9M53zPi8+r9roOYThY8F9Eva2B+AdxUSSzHbuxQe4
         k6gxrKTuuFxCToclnpIG61uQcks2SJKAEkCKoON7ODyJ6nIcUMz1WnHnS6Ml0PPvgi
         1JcE24yW4lmU42VtBhcLK1K0gErFKLMGzuGcoBn3pUD2he9QDlcW1OJV/dukbuW56r
         a5Bh6Xf3rpeuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2D46FCE39D5; Wed, 28 Jun 2023 06:46:50 -0700 (PDT)
Date:   Wed, 28 Jun 2023 06:46:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org
Subject: Re: [GIT PULL] RCU changes for v6.5
Message-ID: <9b1a620a-975a-490f-b9ee-6aea7c8effe0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <963d6eb8-6520-4c33-bbe8-6c76205bfd3d@paulmck-laptop>
 <CAHk-=whn4DGusRgq7ihBmu7vPBhvSDZsYN_ctef94E1rVbf5jA@mail.gmail.com>
 <fcc987bb-4ce4-4816-a909-cffa4c3f24ff@paulmck-laptop>
 <ZJw26orq0ZLEOL9q@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJw26orq0ZLEOL9q@ziepe.ca>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 10:34:34AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 27, 2023 at 11:30:46AM -0700, Paul E. McKenney wrote:
> > On Tue, Jun 27, 2023 at 10:56:21AM -0700, Linus Torvalds wrote:
> > > On Sun, 25 Jun 2023 at 08:35, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2023.06.22a
> > > >
> > > > o       Eliminate the single-argument variant of k[v]free_rcu() now
> > > >         that all uses have been converted to k[v]free_rcu_mightsleep().
> > > 
> > > Well, clearly not all users had been.
> > > 
> > > The base of this RCU was v6.4-rc1, and when that commit was done, we
> > > still had a single-argument variant:
> > > 
> > >   7e3f926bf453 ("rcu/kvfree: Eliminate k[v]free_rcu() single argument macro")
> > > 
> > > but look here:
> > > 
> > >      git grep 'kfree_rcu([^,()][^,()]*)' 7e3f926bf453
> > > 
> > > results in
> > > 
> > >    7e3f926bf453:drivers/infiniband/sw/rxe/rxe_verbs.c:     kfree_rcu(mr);
> > > 
> > > so the RCU tree itself can not possibly have built cleanly.
> > > 
> > > How the heck did this pass testing in linux-next? Did linux-next just
> > > assume that it was a merge error, and fix it up?
> > 
> > Because idiot here failed to notice that the needed change was only
> > in -next, and not yet in mainline.
> 
> It passed testing in linux-next because Stephen fixes eveything so it compiles:
> 
> https://lore.kernel.org/all/20230328121609.68105dd5@canb.auug.org.au/
> 
> It seems Stephen's report is a bit odd because it wasn't a merge issue
> vs rdma, it was vs v6.4-rc1..
> 
> I suppose the question is why didn't something like Intel 0-day catch
> it when it trial compiled the RCU tree's branch.

The revert meant that 0-day didn't see -rcu without the single-argument
kfree_rcu() definition.

							Thanx, Paul
