Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBAF6361C2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbiKWO3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238350AbiKWO2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:28:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134D75ADC7;
        Wed, 23 Nov 2022 06:27:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BB6661CFB;
        Wed, 23 Nov 2022 14:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25E4C433D6;
        Wed, 23 Nov 2022 14:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669213642;
        bh=3/MdpCK2LPNdAQRlQNjcyOug5wXrMB04iJ1Ceaat6VU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LpI9OfA1SI50YA6YqhHhH3OuxJCB37NtydNeFnHjVVcC8Suuq5VsFRjyjbvgKkl7b
         aP9+seLWxhP/DSopejY3SNL/A+5d98S3PwyvZhWvdhzsyNIFb7e7r57cfUlmRq+c6n
         DESVeS4CD1EHvxKPe/XGc4NKav3JFmodFPv1TMfluXiV2lNTBpQM1KCgk25OlNvbAN
         epGji8oeP+TIVnzSgNyXbjAt7AhQuZx/G3Mrl5HLZCFJshQZSdwbMaKg2ARMjvRlNQ
         RAoHfMC2bALSwguQhOhUD3iqBfYfliICIqb9kdVJIFe/X/muSQyJiXIRdvxt6CiT5/
         OIXHvX4Uc4VZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 70A9D5C2DE7; Wed, 23 Nov 2022 06:27:22 -0800 (PST)
Date:   Wed, 23 Nov 2022 06:27:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the rcu tree
Message-ID: <20221123142722.GV4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221123163255.48653674@canb.auug.org.au>
 <2be7872b-3978-9ea2-c00b-6b075516ec74@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2be7872b-3978-9ea2-c00b-6b075516ec74@huawei.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 04:19:15PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/11/23 13:32, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the rcu tree, today's linux-next build (htmldocs) produced
> > these warnings:
> > 
> > Documentation/RCU/stallwarn.rst:401: WARNING: Literal block expected; none found.
> > Documentation/RCU/stallwarn.rst:428: WARNING: Literal block expected; none found.
> > Documentation/RCU/stallwarn.rst:445: WARNING: Literal block expected; none found.
> > Documentation/RCU/stallwarn.rst:459: WARNING: Literal block expected; none found.
> > Documentation/RCU/stallwarn.rst:468: WARNING: Literal block expected; none found.
> > 
> > Introduced by commit
> > 
> >   3d2788ba4573 ("doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information")
> > 
> 
> Strange thing, I specially executed make htmldocs before, unexpectedly did not
> find these warnings.
> 
> I already know why. The literal block is not indented. I will post a new version to
> Paul E. McKenney. Excuse me for causing trouble to everyone.
> 
> For example:
> @@ -398,9 +398,9 @@ In kernels built with CONFIG_RCU_CPU_STALL_CPUTIME=y or booted with
>  rcupdate.rcu_cpu_stall_cputime=1, the following additional information
>  is supplied with each RCU CPU stall warning::
> 
> -rcu:          hardirqs   softirqs   csw/system
> -rcu:  number:      624         45            0
> -rcu: cputime:       69          1         2425   ==> 2500(ms)
> +  rcu:          hardirqs   softirqs   csw/system
> +  rcu:  number:      624         45            0
> +  rcu: cputime:       69          1         2425   ==> 2500(ms)

It is probably my fault during my wordsmithing, but I will happily
accept a new patch to replace the current one.

							Thanx, Paul
