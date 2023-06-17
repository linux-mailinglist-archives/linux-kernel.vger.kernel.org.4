Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83118733F1F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345863AbjFQHU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 03:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbjFQHUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E8F213F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EB5960ADC
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 07:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 855ADC433C0;
        Sat, 17 Jun 2023 07:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686986422;
        bh=axbxhwfcqMSCE380nBysXx5dBfYZA9l7izhNqwViekU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jDgyB3FQRRuL496+2C+VBRByI0olseAjGt40HSYGpaxM9VaFWY5wJo2RmYNE0I3aU
         AvkaxaBZZnfMRhoCkKSglfCj3XeApenBBKRCT9+3pmaue/F37OvnOyvyYELhMQj5VM
         xR1vYOEjkhoW8ezVNqqtRTO893szHbx53tavkM3NzxfrEhYzS9tKl37J5thrSNN+Gl
         jj5zwvmw9LDIYbMHC6rfrJ16eQI1I/+GgF70XTZh65jZOQa1+GFuanZ6caBzgiok5c
         MKdr0HSJIC33/k3HemKdI3Tvi99ZeSVpfvUJKDZx/8/V7yKOkzbNgAeeJxI7s3IKjY
         Mw8o2uR4GuhzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64FD9C395E0;
        Sat, 17 Jun 2023 07:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] kcm: Fix unnecessary psock unreservation.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168698642240.16794.4653349244571397318.git-patchwork-notify@kernel.org>
Date:   Sat, 17 Jun 2023 07:20:22 +0000
References: <20787.1686828722@warthog.procyon.org.uk>
In-Reply-To: <20787.1686828722@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        syzbot+dd1339599f1840e4cc65@syzkaller.appspotmail.com,
        tom@herbertland.com, tom@quantonium.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        axboe@kernel.dk, willy@infradead.org, linux-kernel@vger.kernel.org
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

On Thu, 15 Jun 2023 12:32:02 +0100 you wrote:
> kcm_write_msgs() calls unreserve_psock() to release its hold on the
> underlying TCP socket if it has run out of things to transmit, but if we
> have nothing in the write queue on entry (e.g. because someone did a
> zero-length sendmsg), we don't actually go into the transmission loop and
> as a consequence don't call reserve_psock().
> 
> Fix this by skipping the call to unreserve_psock() if we didn't reserve a
> psock.
> 
> [...]

Here is the summary with links:
  - [net-next] kcm: Fix unnecessary psock unreservation.
    https://git.kernel.org/netdev/net-next/c/9f8d0dc0ec4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


