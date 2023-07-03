Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1F6745730
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjGCIUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjGCIUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:20:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C46FE40
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:20:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BDED60E76
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92E19C433BB;
        Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688372422;
        bh=1txSw2srHoolnewTEuF54cblhQjnp+V4SXu+ZkTp4+E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oJ6IQWNCIwhqKYpXbMUQLnpwU2wjb4ufpY6PmmOvGG4bODo12xZh9Q6fGdoTyVac0
         rT0rH04E38HPjQiNJOqVUTWwjH69KhGsxYJ+CJQZ0+Kt0+R4iAYzpXHjJaeKYTEcex
         /QCdQJ+e8MWml6qKyG8P/RirT9TDPSlyUHYJE/zyH5vFea8cqi5FIiT9ackFGI4Swp
         CEZPPW9La4CvgKHXPTNwe66ahVY6hej00/3K19fmZlxlE/bg1b3TOqTbtGF9s7TTDK
         cqTeYbH2IRGZl6qGvDvsLPi8G3A5X8QGX7DPUVO0ZZrPUorCR6zb+xmWn8Xej2D75Y
         LzMdITR5DgCNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7351DC39563;
        Mon,  3 Jul 2023 08:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: tag_sja1105: fix source port decoding in
 vlan_filtering=0 bridge mode
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168837242246.9798.5147519916489764756.git-patchwork-notify@kernel.org>
Date:   Mon, 03 Jul 2023 08:20:22 +0000
References: <20230630222010.1691671-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230630222010.1691671-1-vladimir.oltean@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, simon.horman@corigine.com,
        linux-kernel@vger.kernel.org
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

On Sat,  1 Jul 2023 01:20:10 +0300 you wrote:
> There was a regression introduced by the blamed commit, where pinging to
> a VLAN-unaware bridge would fail with the repeated message "Couldn't
> decode source port" coming from the tagging protocol driver.
> 
> When receiving packets with a bridge_vid as determined by
> dsa_tag_8021q_bridge_join(), dsa_8021q_rcv() will decode:
> - source_port = 0 (which isn't really valid, more like "don't know")
> - switch_id = 0 (which isn't really valid, more like "don't know")
> - vbid = value in range 1-7
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: tag_sja1105: fix source port decoding in vlan_filtering=0 bridge mode
    https://git.kernel.org/netdev/net/c/a398b9ea0c3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


