Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10F272977B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbjFIKu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238795AbjFIKuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FADEE1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 03:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CEE2656D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BF27C4339B;
        Fri,  9 Jun 2023 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686307822;
        bh=l85ItVcFL5/r/0pp/ddXy/ZBIkYXxeHiyfXqVdsAj7s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GqPbooHKd3N6NXIrHzgoM96EYVML7u4qnsmC2oeJXSR5Qncuej2Ya1hGBrF2aw8FM
         hwt6PedgFXN72fUzM4QGaNLDrIEVzk7eFJFwRrgPDqeaoVyTQLv0Z3FYvOX2rrSvyK
         tta/QZUxn6lj+4162bsvlVrYkejXFmkAfnNp+IE33cSM7YnDq52h6JRApBTtPTT3MF
         aJEuwG5zR5dvn+Gw+h/6NavTE5KXJbX3H09fXqsGbgOkXI012arjf175ApnSlkBLmQ
         X+JCFIlI977oAIv16yTQkoouuVe0Vo/d4Ol+bCkxYWo4eckDqhKweeAUoXjuV4M09W
         +QycmnqDPqaBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C6D9C43157;
        Fri,  9 Jun 2023 10:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] net/sched: cls_u32: Fix reference counter leak leading
 to overflow
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168630782237.20473.1733377791755125144.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Jun 2023 10:50:22 +0000
References: <20230608072903.3404438-1-lee@kernel.org>
In-Reply-To: <20230608072903.3404438-1-lee@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, stable@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  8 Jun 2023 08:29:03 +0100 you wrote:
> In the event of a failure in tcf_change_indev(), u32_set_parms() will
> immediately return without decrementing the recently incremented
> reference counter.  If this happens enough times, the counter will
> rollover and the reference freed, leading to a double free which can be
> used to do 'bad things'.
> 
> In order to prevent this, move the point of possible failure above the
> point where the reference counter is incremented.  Also save any
> meaningful return values to be applied to the return data at the
> appropriate point in time.
> 
> [...]

Here is the summary with links:
  - [v2,1/1] net/sched: cls_u32: Fix reference counter leak leading to overflow
    https://git.kernel.org/netdev/net/c/04c55383fa56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


