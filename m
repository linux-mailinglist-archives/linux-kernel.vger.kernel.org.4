Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7C57379CE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjFUDkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 23:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjFUDkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714E2184
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 20:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0311861463
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3239BC433CC;
        Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687318822;
        bh=0lRN5FnZLtCRTf6vn1eHcW7i4WruP/CJ51DKHEgN0M8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OCZa9nIj9DpB7wGlcvDTww8yIe1cWqwucCf8NAVI+Y2HhOl8pbn45M+ruoo/Mtwzk
         oy0vg0LyIQCLJcxAUfTbqRI3JZDmqGjqFz0c/tYFQvtAc8Yju9J8TzC/LJQPR7t2ns
         5jSm1rmdPdqahj08Gd4OZ3xgXLFz6hUltb6j8ThhdC08pBbtuzIfHSx0lRjpO2XYo+
         KJsn5YuLZbyXCxaI9SCvldOmJQpw1H+79KotzKFfSehTsCY8BBWROIP2lzWE+tOXpG
         rePqg1OwFTFCHG88UNeliV2AnSJ1FchO7VII1DZRtvIOZ0T5LFWmm1AecEGyFxNh0R
         pKY0Akq3U1mKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FCC5E301FA;
        Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] [v2] sfc: add CONFIG_INET dependency for TC offload
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168731882206.8371.11751260150778183648.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Jun 2023 03:40:22 +0000
References: <20230619091215.2731541-1-arnd@kernel.org>
In-Reply-To: <20230619091215.2731541-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, simon.horman@corigine.com,
        pieter.jansen-van-vuuren@amd.com, arnd@arndb.de, jiri@resnulli.us,
        alejandro.lucero-palau@amd.com, netdev@vger.kernel.org,
        linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jun 2023 11:12:09 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver now fails to link when CONFIG_INET is disabled, so
> add an explicit Kconfig dependency:
> 
> ld.lld: error: undefined symbol: ip_route_output_flow
> >>> referenced by tc_encap_actions.c
> >>>               drivers/net/ethernet/sfc/tc_encap_actions.o:(efx_tc_flower_create_encap_md) in archive vmlinux.a
> 
> [...]

Here is the summary with links:
  - [1/3,v2] sfc: add CONFIG_INET dependency for TC offload
    https://git.kernel.org/netdev/net-next/c/40cba83370c2
  - [2/3,v2] sfc: fix uninitialized variable use
    https://git.kernel.org/netdev/net-next/c/f61d2d5cf142
  - [3/3] sfc: selftest: fix struct packing
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


