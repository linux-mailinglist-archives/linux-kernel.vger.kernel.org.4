Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C597E7315C5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343596AbjFOKu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240308AbjFOKuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D96273F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0352C6377D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 603E5C433CA;
        Thu, 15 Jun 2023 10:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686826220;
        bh=mmKn3ew/3ihNeUTsrH7kpRJDU9VC/tq1DF43WBYgUjc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XQb1yjyu7equ0BYhCU1QJjHdCwPx/7WS07cuh6Ee/ukzrWWJa1lOqiPrjFZ7bhIfN
         rqCUw7iOdeMlQ9Sd/UBrbOA+krlqf3GAn3GdEoyfc6UKwyzmCTNn7jghlDT3pBTU6l
         cWK/1mKjrVPpo/YRcAWseb2TvcyzHFORxlrToAV62W/je68U9PrS8+dftkAC64UZXW
         AWNzPahr7Pl+Rn2y1yaqaWLwv3imYKQklYwYL/6YjiIGiQ+78GTit/u4OfD34Idahr
         VZdGhjkog7/pya9NtGQ9RyKKftj1EPmI3MhfvHrdXxgAUurN34QcFeTsJoLkIES5Bs
         XDiN23PvR+y4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3709AE270FB;
        Thu, 15 Jun 2023 10:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: macsec: fix double free of percpu stats
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168682622021.15431.8579667893782171995.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Jun 2023 10:50:20 +0000
References: <20230613192220.159407-1-pchelkin@ispras.ru>
In-Reply-To: <20230613192220.159407-1-pchelkin@ispras.ru>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     davem@davemloft.net, sd@queasysnail.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, raeds@nvidia.com,
        liorna@nvidia.com, saeedm@nvidia.com, hannes@stressinduktion.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        khoroshilov@ispras.ru, lvc-project@linuxtesting.org
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

On Tue, 13 Jun 2023 22:22:20 +0300 you wrote:
> Inside macsec_add_dev() we free percpu macsec->secy.tx_sc.stats and
> macsec->stats on some of the memory allocation failure paths. However, the
> net_device is already registered to that moment: in macsec_newlink(), just
> before calling macsec_add_dev(). This means that during unregister process
> its priv_destructor - macsec_free_netdev() - will be called and will free
> the stats again.
> 
> [...]

Here is the summary with links:
  - net: macsec: fix double free of percpu stats
    https://git.kernel.org/netdev/net/c/0c0cf3db83f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


