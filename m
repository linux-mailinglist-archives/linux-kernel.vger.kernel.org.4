Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9885368F705
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjBHSg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjBHSgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:36:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFC24F87E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:35:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43D9E6173C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C11C433D2;
        Wed,  8 Feb 2023 18:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675881315;
        bh=pHw45Bur1Eds9PkCMxJM+9DF+J/zCwBWK1Hzb+5N3pY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ib6GrJ8LUqeYE2u8AQSAxwkQRajb4TEym7/HxmGXGiRZWvJcaYhT6u9v9LvZLky8J
         bo9OegYzItSkCLtyes/yOen4IywXOibVTHu2ERDm5+kcpgzceLf+ny998wY1HLVZ8q
         frpktdhAIQ8yssliYkYCI1CydUreVJaMRY/6Nt3k78ii+BNhi2OwPNHKwUfmm3NaLy
         Kmm5sQaLkA1QAe0Hzn1W3Ttl+KHsFqqNnLbqMTb1kEvLKseWJMKxNOH9W2n+78KH4L
         s7PbYfdaB3TOI8t60KhcXFNa6U9rkSeWQnzf6BiaetUR/oOuP7vj0kw1z+glw8WMEC
         813NZyo4npQLg==
Date:   Wed, 8 Feb 2023 11:35:13 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux@weissschuh.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] objtool: Honey, I shrunk the instruction
Message-ID: <Y+PrYVKwXIyutFEl@dev-arch.thelio-3990X>
References: <20230208171756.898991570@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208171756.898991570@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 06:17:56PM +0100, Peter Zijlstra wrote:
> Hi,
> 
> Boris complained he could no longer build allyesconfig on his 32G desktop
> machine without having OOM terminate either objtool or chrome.
> 
> After talking about these patches on IRC, Nathan mentioned the linux-clang CI
> was also having trouble of recent, and these patches appear to make it happy
> again.
> 
> In total these patches shrink an allyesconfig run by about 6G:
> 
> pre:	5:58.22 real,   226.69 user,    131.22 sys,     26221520 mem
> post:	5:03.34 real,   210.75 user,    88.80 sys,      20241232 mem
> 
> Also at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=objtool/core

For patches 1-9:

Tested-by: Nathan Chancellor <nathan@kernel.org> # build only

Prior to this series:

    [INFO] Memory used: 25.09GB

After this series:

    [INFO] Memory used: 19.27GB

Our builds on TuxSuite were consistenly timing out after four hours and
they had no problem passing with this series (the worst time was 2.2h,
which is line with the VM specs that they use I believe):

https://tuxapi.tuxsuite.com/v1/groups/clangbuiltlinux/projects/nathan/plans/2LQbNuWRo3Xf62Yg3SINuA9d7cR

Thanks a lot!

Cheers,
Nathan
