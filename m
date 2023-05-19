Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB78708DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 04:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjESCM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 22:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjESCM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 22:12:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E040DF;
        Thu, 18 May 2023 19:12:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37508652C5;
        Fri, 19 May 2023 02:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C48C433D2;
        Fri, 19 May 2023 02:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684462374;
        bh=LomNzVv+RM63A9mGOo7tAYZ/L2kgQitvKBAYCtUl7xI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AbGS3xCZvv8KAH+CsGwQI915B9gXH9B5O4qTVyIjm9M24uO+jsBCrnayBdfnTG+IR
         KilFKvMAs6vNJllt69xwnvdPyJrBZ6a2X13WUm82mn2QCQ/aFdbuCSK+iUkiC7LHUm
         QzKUcmjLMCTjR7nsCYcFNBgqZf+tlhOCg9ugNB/qr3EKgeum8PxMZBUsyKtIqUbhzx
         MiAO4za382yrB0n0+ULf25pDfjC7YuTALMGFoi6BjOXyJNBcr9Xqw3zIvRoPshWZGb
         Ol5qSwHtROUr3D1sA6eCHwH+1HbW5H8EB80eJyRp90nK3qUpHJxH2rDFt26aKDeOpE
         LoakJW7ynp3Jw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 78A95CE0CC0; Thu, 18 May 2023 19:12:52 -0700 (PDT)
Date:   Thu, 18 May 2023 19:12:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the rcu tree
Message-ID: <cc4ab028-cad3-413b-8360-ea34f6914ec7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230519105950.2d021e86@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519105950.2d021e86@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 10:59:50AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the rcu tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> kernel/rcu/rcuscale.c:340:27: error: 'get_rcu_tasks_trace_gp_kthread' undeclared here (not in a function); did you mean 'show_rcu_tasks_trace_gp_kthread'?
>   340 |         .rso_gp_kthread = get_rcu_tasks_trace_gp_kthread,
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                           show_rcu_tasks_trace_gp_kthread
> 
> Caused by commit
> 
>   9bb839a83e1b ("rcuscale: Measure grace-period kthread CPU time")
> 
> CONFIG_RCU_SCALE_TEST=m
> 
> I have used the rcu tree from next-20230518 for today.

Huh.  Modules and #ifdefs trip me up again.  Will fix, and thank you
for catching it!

							Thanx, Paul
