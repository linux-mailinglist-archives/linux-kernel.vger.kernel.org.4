Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA80174E95F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjGKIub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGKIu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:50:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C8E10C7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43B566139D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88CDDC433C9;
        Tue, 11 Jul 2023 08:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689065421;
        bh=/k5olDGpbnyZ4n9IScGnO/ghFsMW4z+IdHliHFazRfY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QQdaVSMQf4Cl2d1URQhv/st9xBAGVyHlQnIRt+bNnJON7uqdHNVD1T6FxqBY7s+Vf
         a2zcnX0dkaZBEYvxMgbS1H21aLNWqAfsdhs/IeCborE4VgQZ5Zu3W1cYJ9T9I+lHkL
         vDi6be6VxrsmJUd1yA+UX+4kYRDmWh8UBK2EFqI5atIu2nXPkE+uoezEc0vjS0IA1v
         8DEa0uMpjD2fTBdbLyMOCZ6a0Kr7h3urVQpvFd7aTWP6Mq/WkhlX6cSMpywmnkDMSx
         m7nqPLZL5A1azKj/Tad4gi8k4Tw5/DMFdj2ThNB33pS8WUwRHrRwr6cESa/aNPXuT9
         9S82HvLTXZGSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69161C4167B;
        Tue, 11 Jul 2023 08:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net 0/4] net: fec: fix some issues of ndo_xdp_xmit()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168906542142.15715.5308120032595362444.git-patchwork-notify@kernel.org>
Date:   Tue, 11 Jul 2023 08:50:21 +0000
References: <20230706081012.2278063-1-wei.fang@nxp.com>
In-Reply-To: <20230706081012.2278063-1-wei.fang@nxp.com>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, shenwei.wang@nxp.com,
        xiaoning.wang@nxp.com, netdev@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
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

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  6 Jul 2023 16:10:08 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> We encountered some issues when testing the ndo_xdp_xmit() interface
> of the fec driver on i.MX8MP and i.MX93 platforms. These issues are
> easy to reproduce, and the specific reproduction steps are as follows.
> 
> step1: The ethernet port of a board (board A) is connected to the EQOS
> port of i.MX8MP/i.MX93, and the FEC port of i.MX8MP/i.MX93 is connected
> to another ethernet port, such as a switch port.
> 
> [...]

Here is the summary with links:
  - [V2,net,1/4] net: fec: dynamically set the NETDEV_XDP_ACT_NDO_XMIT feature of XDP
    https://git.kernel.org/netdev/net/c/be7ecbe7ec7d
  - [V2,net,2/4] net: fec: recycle pages for transmitted XDP frames
    https://git.kernel.org/netdev/net/c/20f797399035
  - [V2,net,3/4] net: fec: increase the size of tx ring and update tx_wake_threshold
    https://git.kernel.org/netdev/net/c/56b3c6ba53d0
  - [V2,net,4/4] net: fec: use netdev_err_once() instead of netdev_err()
    https://git.kernel.org/netdev/net/c/84a109471987

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


