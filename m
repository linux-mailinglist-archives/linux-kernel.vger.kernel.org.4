Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117A972F809
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243669AbjFNIk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243678AbjFNIkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBDD1BD4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05C4D63EF1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DF20C433C0;
        Wed, 14 Jun 2023 08:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686732023;
        bh=ohGafOhz/k8lrTqI3s/xf/QqRX8/sFC70GYv3S6BuX0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=J9rGV7RgGTnL12eyPFOohWllg4U+WPCeM9+Qep9SDvV1nKw71S4MmlIUJ2BczOMp2
         25po0xRBldzcRhaGGl8ZK1NQhv2CZa85QCCykPsu2f2Dv6FgsDC7v9DrQJ4pavAMzL
         CexgBw6k7XTbFfl7kvvt0oSXW3Xlo9D1AgIK1Lph0esZPEZVYv2LKM8/V6xDKQItLI
         X3OCz0L5Qx0Ah79jRwcyfk6Pg/TdGrPi/yvwVyz99voCA4Q+ce07+0s3E0VKlZUcV+
         OPc0UjsXeWm0AHc3xRI0z7r5p1LHTQAO71PQQnN1LzpAfpbetbC17OlJGZn2aJV4Ky
         OItO/F80LfUVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 382A8C3274B;
        Wed, 14 Jun 2023 08:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net/sched: Fix race conditions in
 mini_qdisc_pair_swap()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168673202322.7814.14751124253693940183.git-patchwork-notify@kernel.org>
Date:   Wed, 14 Jun 2023 08:40:23 +0000
References: <cover.1686355297.git.peilin.ye@bytedance.com>
In-Reply-To: <cover.1686355297.git.peilin.ye@bytedance.com>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, peilin.ye@bytedance.com, vladbu@mellanox.com,
        pctammela@mojatatu.com, john.fastabend@gmail.com,
        daniel@iogearbox.net, hdanton@sina.com, shaozhengchao@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        cong.wang@bytedance.com
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

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 10 Jun 2023 20:29:41 -0700 you wrote:
> Hi all,
> 
> These 2 patches fix race conditions for ingress and clsact Qdiscs as
> reported [1] by syzbot, split out from another [2] series (last 2 patches
> of it).  Per-patch changelog omitted.
> 
> Patch 1 hasn't been touched since last version; I just included
> everybody's tag.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/sched: Refactor qdisc_graft() for ingress and clsact Qdiscs
    https://git.kernel.org/netdev/net/c/2d5f6a8d7aef
  - [net,2/2] net/sched: qdisc_destroy() old ingress and clsact Qdiscs before grafting
    https://git.kernel.org/netdev/net/c/84ad0af0bccd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


