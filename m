Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB67D70EBF0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239288AbjEXDkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbjEXDkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD55BF
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 415D763849
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D030C433D2;
        Wed, 24 May 2023 03:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684899619;
        bh=pSs7L7UqeT5hUVoodkICmpCsW8Vf/4gY6mZt3Rx0HII=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XWAcPBVKQvYtJmLVr+vH0o0dskU8JDB0Yp1aoT0qqTSSaQ3CEQD638LZfej6DZc7r
         sLBFn92q6Sq5tNtZBenF8GkspT4Jkn8ZZjxpeSHpnunWfpV+OKLG18MxnWv4rMsz5D
         qn75npGSxyaJgcwl3Jwtnfxbm2f8sfY46M1tfdWEkZdu8XgWMi52v8CN63wpQQnrpT
         W63AOwvNwQqkNxjzf5O4TWhjmIZk4mzdUmD1uYpn0TeX+azO9ZTTQDE13PfKUP/tcK
         lEzRH19DqpR+yP63UskWvXaz/gS/11eXNucNJFd2m3L3dz8NKr+zpwfgO0TxYczsUt
         BMZ+s3nkRlTdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79605C395F8;
        Wed, 24 May 2023 03:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] page_pool: fix inconsistency for
 page_pool_ring_[un]lock()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168489961948.3716.18030218604369017925.git-patchwork-notify@kernel.org>
Date:   Wed, 24 May 2023 03:40:19 +0000
References: <20230522031714.5089-1-linyunsheng@huawei.com>
In-Reply-To: <20230522031714.5089-1-linyunsheng@huawei.com>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hawk@kernel.org, ilias.apalodimas@linaro.org, edumazet@google.com,
        lorenzo@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com
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

On Mon, 22 May 2023 11:17:14 +0800 you wrote:
> page_pool_ring_[un]lock() use in_softirq() to decide which
> spin lock variant to use, and when they are called in the
> context with in_softirq() being false, spin_lock_bh() is
> called in page_pool_ring_lock() while spin_unlock() is
> called in page_pool_ring_unlock(), because spin_lock_bh()
> has disabled the softirq in page_pool_ring_lock(), which
> causes inconsistency for spin lock pair calling.
> 
> [...]

Here is the summary with links:
  - [net] page_pool: fix inconsistency for page_pool_ring_[un]lock()
    https://git.kernel.org/netdev/net/c/368d3cb406cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


