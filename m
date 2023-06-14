Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D87372F80A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243684AbjFNIkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243683AbjFNIkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8630A1BE3;
        Wed, 14 Jun 2023 01:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1249C63EF7;
        Wed, 14 Jun 2023 08:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6463EC433AD;
        Wed, 14 Jun 2023 08:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686732023;
        bh=w7r/Vy2RBgUGguVLqB/vtm9DdBD26hBrdfNnOcrlkOE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sTVizSWFb/tzgy5+wTBvprejqGJcc4Ww/FCrXSMdhUC+0j7FGaWBicvTiHvgwzTlX
         tMQvF6uLXVhh9x8SGKUmd2LHBO5/FRNn30wzr6OXbfmLV3amJbPAJ82oV2LhIpo/1n
         xourXznT9H9cli0svwAOkSPODn8ZcxeiiqVEiXLJhuK0ZtpE9Jr5vB4LTvlIJ+DKm2
         hPi7VhJjCiYq4WaEJnZRxKDNU7wyBP4TgHHY5AX6NKSxcWKRj5kvrBfDQN+5CtAw/P
         lqgEr9laYn27OOCKEM+p6r0zevQjnqc8eBpt+mK2TvIoXvWQiNzH9rFsplNgORfGjs
         b0NQMnmfL4RVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 449DDE2A048;
        Wed, 14 Jun 2023 08:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net/sched: act_ct: Fix promotion of offloaded
 unreplied tuple
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168673202327.7814.1952400928675625882.git-patchwork-notify@kernel.org>
Date:   Wed, 14 Jun 2023 08:40:23 +0000
References: <1686313379-117663-1-git-send-email-paulb@nvidia.com>
In-Reply-To: <1686313379-117663-1-git-send-email-paulb@nvidia.com>
To:     Paul Blakey <paulb@nvidia.com>
Cc:     vladbu@nvidia.com, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ozsh@nvidia.com, roid@nvidia.com,
        saeedm@nvidia.com, pablo@netfilter.org, kadlec@netfilter.org,
        fw@strlen.de, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us
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

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 9 Jun 2023 15:22:59 +0300 you wrote:
> Currently UNREPLIED and UNASSURED connections are added to the nf flow
> table. This causes the following connection packets to be processed
> by the flow table which then skips conntrack_in(), and thus such the
> connections will remain UNREPLIED and UNASSURED even if reply traffic
> is then seen. Even still, the unoffloaded reply packets are the ones
> triggering hardware update from new to established state, and if
> there aren't any to triger an update and/or previous update was
> missed, hardware can get out of sync with sw and still mark
> packets as new.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net/sched: act_ct: Fix promotion of offloaded unreplied tuple
    https://git.kernel.org/netdev/net/c/41f2c7c342d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


