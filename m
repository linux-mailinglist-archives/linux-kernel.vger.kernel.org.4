Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3247073115B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244523AbjFOHuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245400AbjFOHuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CE8C7;
        Thu, 15 Jun 2023 00:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0091860DFF;
        Thu, 15 Jun 2023 07:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D342C433C8;
        Thu, 15 Jun 2023 07:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686815419;
        bh=uXXz4yd7ee+6QGrv/NuvRMJeE5gSJfqC9YZGaaJo6WU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=khPEWZ0o7q7MaBPuSsXiKEQH8CeXfdRoTOLtbN1SWp3dHEOPGoIWCFLydNrd1iiaO
         gleU9AXCQfBQelJC/Cqu4itv3ZNHzG+CvBC+Spxia8wF6Bz2aKoSlipAbQAb6Uki+G
         WFXK7/8HE6e67lvyk27q2uuId9Dj9eRgLxLdyHji8veoUF3/9YGJE97q+MengkmFg+
         +Qu65VFyQfqCCvZrBj1ZpCFkTGhdjuYhwep33QUsuGsRkkYnVxqtkn9/ea9u+D1t23
         2jxxW/dZ3dY+5rofQM39KUR5A121TkCoAE85ylac7T4MTJl+Cgj9/a58Ev97bseqeI
         MxoJ2ACnuw3+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33725C3274B;
        Thu, 15 Jun 2023 07:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] s390/ism: Fix trying to free already-freed IRQ by repeated
 ism_dev_exit()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168681541920.22382.10439773407681596212.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Jun 2023 07:50:19 +0000
References: <20230613-ism-rmmod-crash-v1-1-359ac51e18c9@linux.ibm.com>
In-Reply-To: <20230613-ism-rmmod-crash-v1-1-359ac51e18c9@linux.ibm.com>
To:     Julian Ruess <julianr@linux.ibm.com>
Cc:     wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, jaka@linux.ibm.com, raspl@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        schnelle@linux.ibm.com
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

On Tue, 13 Jun 2023 14:25:37 +0200 you wrote:
> This patch prevents the system from crashing when unloading the ISM module.
> 
> How to reproduce: Attach an ISM device and execute 'rmmod ism'.
> 
> Error-Log:
> - Trying to free already-free IRQ 0
> - WARNING: CPU: 1 PID: 966 at kernel/irq/manage.c:1890 free_irq+0x140/0x540
> 
> [...]

Here is the summary with links:
  - s390/ism: Fix trying to free already-freed IRQ by repeated ism_dev_exit()
    https://git.kernel.org/netdev/net/c/78d0f94902af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


