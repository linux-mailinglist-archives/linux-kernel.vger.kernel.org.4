Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F104641883
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 20:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiLCTBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 14:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiLCTBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 14:01:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42FB1B9EF;
        Sat,  3 Dec 2022 11:01:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 27D2BCE0920;
        Sat,  3 Dec 2022 19:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D0DC433D6;
        Sat,  3 Dec 2022 19:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670094106;
        bh=ItYMQ/1jSvCAEDxE87LOVRpnEAcK3AZkSpUtEh5qRoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jEE01nnhtu6kR/Nr3LSa4BKfGyv5jIMq/qcPpZbDBBgKAmuZKCB/mZX4hOowV9M6Z
         WiNbnzbEnfgHFMwSfX5SCaAQpEsvKz/Kf/4EM8XhswW199RYPxnaXByca6vn63VLFW
         ioIR7zMXETIeUafObrY2UhBqlrXuDdjZYhXlxKG68K7+NFAgIkuwO3ak/o2PalHsu8
         7hG5pvPfwM/V7ed/ZEjDlCFfv+uhkAzygXl8AYhbcLqYcXQm+wS+eqaUTRhbE7xv4N
         Y2D0UBPOK8ws+aFR4mC4freAzqxRQoPEGj6bRDPtu3HF4BqJ2/baRJQ8/slr77rNFM
         Hq5Rfxghz1NBw==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, stable-commits@vger.kernel.org,
        yajun.deng@linux.dev, damon@lists.linux.dev
Subject: Re: Patch "mm/damon/sysfs: fix wrong empty schemes assumption under online tuning in damon_sysfs_set_schemes()" has been added to the 6.0-stable tree
Date:   Sat,  3 Dec 2022 19:01:43 +0000
Message-Id: <20221203190143.159947-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221203185854.159885-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc-ing Yajun Deng (author of the commit that this patch depends on for build)
and damon@lists.linux.dev.

On Sat, 3 Dec 2022 18:58:54 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hi Greg,
> 
> On Sat, 3 Dec 2022 12:36:39 +0100 Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Sat, Dec 03, 2022 at 12:23:48PM +0100, gregkh@linuxfoundation.org wrote:
> > > 
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     mm/damon/sysfs: fix wrong empty schemes assumption under online tuning in damon_sysfs_set_schemes()
> > > 
> > > to the 6.0-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >      mm-damon-sysfs-fix-wrong-empty-schemes-assumption-under-online-tuning-in-damon_sysfs_set_schemes.patch
> > > and it can be found in the queue-6.0 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > > 
> > 
> > Nope, breaks the build, now dropped.
> 
> Thank you for letting me know this.
> 
> It needs commit f5a79d7c0c87 ("mm/damon: introduce struct
> damos_access_pattern") to build.  Sorry for not noticing this before.  Could
> you please add the commits together?
> 
> 
> Thanks,
> SJ
