Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E15A73CD58
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 00:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjFXWud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 18:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjFXWu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 18:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03657171A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 15:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E05860ADE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 22:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BADC3C433C0;
        Sat, 24 Jun 2023 22:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687647019;
        bh=XfzAH5D+NJ2x73kry8Xp6iNcZsdkJPTh9EhjfSDHT3w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=X+Ahd5NJdGZpuc+mdW4+2vHXTYlT/9gdnj0nZ71A2RhOnm1y6XAcW+dUiucW9gPae
         Kc+tQQrq7suCGPQzEpTqOeOSVtNoWbSHOmYfrsFGzJiQvVCvqRuzTmH3e6bbQuoHh0
         JqCQD0F92LV26K4G9PIbMD0Ww1rgeDLZb6kRql2NMmE7TSkhZhOif/2rkxqoGJjk4y
         F3nHgUA2n/Q4tdy0lOPRlFdXOCTZTS5RUgzhAyeP/JUb9Jj1whQsMLhBhWVpnTlSIV
         iyuPsEZ8w5NyCLBG5MsS4mNLD0yl1VBsZoXml+O7+CocqGIt38PmkZJZQND0AK1NMx
         gjsCbG50IUd/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9FE1DC395C7;
        Sat, 24 Jun 2023 22:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/1] net: axienet: Move reset before DMA detection
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168764701964.4822.15290219701986465008.git-patchwork-notify@kernel.org>
Date:   Sat, 24 Jun 2023 22:50:19 +0000
References: <20230622185131.113717-1-fido_max@inbox.ru>
In-Reply-To: <20230622185131.113717-1-fido_max@inbox.ru>
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     netdev@vger.kernel.org, robert.hancock@calian.com,
        radhey.shyam.pandey@amd.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        michal.simek@amd.com, andre.przywara@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jun 2023 21:51:30 +0300 you wrote:
> DMA detection will fail if axienet was started before (by boot loader,
> boot ROM, etc). In this state axienet will not start properly.
> XAXIDMA_TX_CDESC_OFFSET + 4 register (MM2S_CURDESC_MSB) is used to detect
> 64 DMA capability here. But datasheet says: When DMACR.RS is 1
> (axienet is in enabled state), CURDESC_PTR becomes Read Only (RO) and
> is used to fetch the first descriptor. So iowrite32()/ioread32() trick
> to this register to detect DMA will not work.
> So move axienet reset before DMA detection.
> 
> [...]

Here is the summary with links:
  - [v3,1/1] net: axienet: Move reset before DMA detection
    https://git.kernel.org/netdev/net/c/f1bc9fc4a06d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


