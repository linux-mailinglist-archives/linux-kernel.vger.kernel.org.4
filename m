Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E545672F3FB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 07:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242763AbjFNFKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 01:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbjFNFKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 01:10:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BD7199
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:10:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14F4463D98
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69B9BC433C9;
        Wed, 14 Jun 2023 05:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686719429;
        bh=3sGXZ7z/sPBpvq2al6Aj5QjOXMcMqKujVylOzPVS6vc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=guuaC5aCF2wnDhF6gJwiexTISGqMnPyqKBzb+Y5JEsnTlBgbMSRgmWWIViks5MEKc
         MeXCB2sFVnDWf2WTKU73orddYlvFzXVAtsCFJyHEpHBfuwHZuSsUgbPw6kL/esuc45
         JauRrUx4Gfpzb0UDrf4/cbZhvgkAhrJWkYl/ocVNiuN+vgaWiTIoYdvddezdMfN/6d
         OjpPKiBVcqnbIJaIyBU6Iy4H4A9Ue/HuJPPoSiv0cGSRaZOE8amZQNPBahTa/EF0MC
         A2DfDQlCZSpRAp7mSkIRNltBaJlU2K5LShMhcngknaJc2VdxKV0vkIGH/gnq9OW+wJ
         +aneJ5OcpsgmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2750BC3274C;
        Wed, 14 Jun 2023 05:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ethtool: ioctl: account for sopass diff in set_wol
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168671942914.26522.8914520829149345552.git-patchwork-notify@kernel.org>
Date:   Wed, 14 Jun 2023 05:10:29 +0000
References: <1686605822-34544-1-git-send-email-justin.chen@broadcom.com>
In-Reply-To: <1686605822-34544-1-git-send-email-justin.chen@broadcom.com>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew@lunn.ch, d-tatianin@yandex-team.ru,
        marco@mebeim.net, mailhol.vincent@wanadoo.fr,
        korotkov.maxim.s@gmail.com, gal@nvidia.com, jiri@resnulli.us,
        kuniyu@amazon.com, simon.horman@corigine.com,
        florian.fainelli@broadcom.com, linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Jun 2023 14:37:00 -0700 you wrote:
> sopass won't be set if wolopt doesn't change. This means the following
> will fail to set the correct sopass.
> ethtool -s eth0 wol s sopass 11:22:33:44:55:66
> ethtool -s eth0 wol s sopass 22:44:55:66:77:88
> 
> Make sure we call into the driver layer set_wol if sopass is different.
> 
> [...]

Here is the summary with links:
  - [net-next] ethtool: ioctl: account for sopass diff in set_wol
    https://git.kernel.org/netdev/net-next/c/2bddad9ec65a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


