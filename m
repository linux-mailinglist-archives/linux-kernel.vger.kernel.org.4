Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F948674006
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjASReG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjASReD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:34:03 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3F42137
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:34:02 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30JHXW4n018458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 12:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1674149616; bh=jX0t83R7p7p0HQWetaSXC63gp0f3+PSHgcNUT/Jsbtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=DGk5acJ2+G3WnlsmvTXbQlRa0dwU1xHO14zUkCg6Gqlgs8seCPnGw2+oFv/E9fDAb
         NlvdOaZy6BzERVwnAj1shmNS0ULxmH5OvbX99TsBXmaPY9vfbCu35Osz/pwRZRavFR
         xnvOTwCMo5JsnKwDfOelz1lCTxR0dvR6SpSTS1qCBLxeHHCId4WuSrf0IzUwdwh/c8
         J/iKEC526tnr6ArK/RLJwG7cptVHpPXIBPM9fEGhRvjRq5j0+w91x0JDKJzQ18HTt0
         leZNMbMgVaFOjwXF8mQAbjKC1JW0f/Srdq1QWC239rvCqjLo+i6Q4SydOMUg0la7cD
         dh6L4gYiQYi5Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4130215C469B; Thu, 19 Jan 2023 12:33:32 -0500 (EST)
Date:   Thu, 19 Jan 2023 12:33:32 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Greg KH <greg@kroah.com>, Vinod Koul <vkoul@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sing-Han Chen <singhanc@nvidia.com>,
        Wayne Chang <waynec@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the phy-next tree
Message-ID: <Y8l+7KfRdPweMGWd@mit.edu>
References: <20230119153145.598885cf@canb.auug.org.au>
 <Y8jfW2TTnHd3J7R1@matsya>
 <Y8jpFw5mfvyRLX/C@kroah.com>
 <Y8lJiJHHcUO7MXQY@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lJiJHHcUO7MXQY@orome>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 02:45:44PM +0100, Thierry Reding wrote:
> 
> This has been a recurring theme, so I'm trying to get a better
> understanding of what people expect here. Some maintainers want to see
> a whole series for a single feature (in this case it was Tegra234 USB
> support) even if it crosses multiple subsystems/trees. This has the
> advantage that patches can be arranged such that all dependencies are
> resolved. Other maintainers like things to be split up so that patches
> are easier to pick up.

Yeah, that's a problem I've seen work both ways.  For example, there
was the "Convert del_timer*() to timer_shutdown*()" series, which was
sent out both as a treewide patch as well as piecewise for each
subsystem.  The patches haven't been applied yet, and it's been on my
todo list to figure out (a) whether I should wait and for it to go in
via some other tree, and (b) whether it's safe to apply it standalone
for ext4, and that's what the patch author was intending.

Personally, I'm happy to do it both ways, especially for fairly
trivial treewide changes.  If it's complex enough that it's going to
cause merge conflict headaches, that would be different, but very
often, it's just 1 or 2 line changes in a very large number of
subsystems.

Cheers,

						- Ted
