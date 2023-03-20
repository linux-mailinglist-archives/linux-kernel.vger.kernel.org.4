Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7736C1F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCTSLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjCTSLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:11:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905373754A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:05:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C75C61760
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 18:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A3CC433EF;
        Mon, 20 Mar 2023 18:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679335503;
        bh=8np/lbjjJ8FCVyjL6iQLvblXqr7n0c7bPvXEH9MwKbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PVhKuCK81gyCbt2F0XSDTdoqnqHLkkLR6w7sbAyxyyRHgzPsA/51b07az4zQ9Ealq
         C3qnFJQxHicSx/XpZwuyEMJi+jnCKOlvI+OFUFPzTKPUdcI7OjSMl62E+qQIOfjVoI
         XCq4hu23ApqbOex9a8OAp4oUgAn5PHAMEhwvuBdNDoNnl3MCh9AvaiBVYlGvtS9hgP
         +D+MmwUBy3saoHMiRhCpjdvQ9C2HG6gbVMy1TcNFWnRc9MOkckFso4uA/gpqv5yt24
         dC1MnxF0MXPpvzgQjdce2+qiRStI5/0ayrLgEc5I4hATrwdkXJK8U7aBHUjs1A0pHy
         P8pSDQyL6BoGA==
Date:   Mon, 20 Mar 2023 11:05:01 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: Linux 6.3-rc3
Message-ID: <20230320180501.GA598084@dev-arch.thelio-3990X>
References: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 01:50:21PM -0700, Linus Torvalds wrote:
> So rc3 is fairly big, but that's not hugely usual: it's when a lot of
> the fixes tick up as it takes a while before people find and start
> reporting issues.

...

> Please test and report any issues you find,

On the clang front, I am still seeing the following warning turned error
for arm64 allmodconfig at least:

  drivers/gpu/host1x/dev.c:520:6: error: variable 'syncpt_irq' is uninitialized when used here [-Werror,-Wuninitialized]
          if (syncpt_irq < 0)
              ^~~~~~~~~~
  drivers/gpu/host1x/dev.c:490:16: note: initialize the variable 'syncpt_irq' to silence this warning
          int syncpt_irq;
                        ^
                         = 0
  1 error generated.

There is an obvious fix that has been available on the mailing list for
some time:

https://lore.kernel.org/20230127221418.2522612-1-arnd@kernel.org/

It appears there was some sort of process snafu, since the fix never got
applied to the drm tree before the main pull for 6.3 and I have not been
able to get anyone to apply it to a tree targeting -rc releases.

https://lore.kernel.org/Y%2FeULFO4jbivQ679@dev-arch.thelio-3990X/
https://lore.kernel.org/67f9fe7f-392a-9acd-1a4d-0a43da634367@nvidia.com/

If that does not come to you through other means before -rc4, could you
just apply it directly so that I can stop applying it to our CI? :)

Cheers,
Nathan
