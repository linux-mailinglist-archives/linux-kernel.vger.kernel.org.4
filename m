Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4883F708E22
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 05:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjESDKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 23:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjESDKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 23:10:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04EC19B;
        Thu, 18 May 2023 20:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A00D653BF;
        Fri, 19 May 2023 03:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C207AC433D2;
        Fri, 19 May 2023 03:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684465828;
        bh=Ql1+SfKvSzalhsD2bM0LltkvnRzf+wo7iv/Lg6dahns=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=J1veWu/S5UTWy+HD1QIHFL2CyDr7Fdw60lI29KMmp0h6UY06WPEfYADR+bl/7z30M
         lqDzXBsvzYGeREHq/HNe3EfZIeQdbXDXKKrERgbOygL9RKr+Xlg+ALBkMtl3NPLzs4
         /CH4ZQoNgwh8A13gcGbNMV3mGLHPZhmQOVKhb23KTrSU9Dkcg1mWUx+gUKrZQ+6gLN
         D20EupfHMKywLhNxhcf//Wi8JtU+nDniTut35Dv6kYAsykaCmDEq/YU5j1BXIRxYS+
         B6TLTCf0VwVxg9rrXWZPe3MyawHIIJ1q5D72z01E4EsR3QIvBsNWU+lFut8Uzw8zpg
         +ipoDouKdkOrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B27BC3959E;
        Fri, 19 May 2023 03:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168446582856.25467.9181622347327037026.git-patchwork-notify@kernel.org>
Date:   Fri, 19 May 2023 03:10:28 +0000
References: <20230517133808.1873695-2-tudor.ambarus@linaro.org>
In-Reply-To: <20230517133808.1873695-2-tudor.ambarus@linaro.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     bjorn@mork.no, joneslee@google.com, oliver@neukum.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        syzbot+9f575a1f15fc0c01ed69@syzkaller.appspotmail.com
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
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 May 2023 13:38:08 +0000 you wrote:
> Currently in cdc_ncm_check_tx_max(), if dwNtbOutMaxSize is lower than
> the calculated "min" value, but greater than zero, the logic sets
> tx_max to dwNtbOutMaxSize. This is then used to allocate a new SKB in
> cdc_ncm_fill_tx_frame() where all the data is handled.
> 
> For small values of dwNtbOutMaxSize the memory allocated during
> alloc_skb(dwNtbOutMaxSize, GFP_ATOMIC) will have the same size, due to
> how size is aligned at alloc time:
> 	size = SKB_DATA_ALIGN(size);
>         size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> Thus we hit the same bug that we tried to squash with
> commit 2be6d4d16a084 ("net: cdc_ncm: Allow for dwNtbOutMaxSize to be unset or zero")
> 
> [...]

Here is the summary with links:
  - net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize
    https://git.kernel.org/netdev/net/c/7e01c7f7046e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


