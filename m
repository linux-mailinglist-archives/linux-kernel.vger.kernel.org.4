Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AC47211F9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 22:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjFCUCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 16:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFCUCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 16:02:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C58618D;
        Sat,  3 Jun 2023 13:02:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D48E9604EF;
        Sat,  3 Jun 2023 20:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16E98C433EF;
        Sat,  3 Jun 2023 20:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685822548;
        bh=W6Ph1V7NwcCTO1o11ACZOYg3bN9VWa0uLMUPomqMqnA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KkH29b6rkyGAJmJHJckzZfOoD20UpfrqiArUK/vKyrIodwNmnLkiATwPc/3y9Mrnp
         p6JAMSTlAqgMZsoCVm+jE5DNsNl2FZ2qAo4vBZrEXEtmSE1ZtjNd45CphKBRmjXhxx
         q7BWHJKAKNPyvrQyoZ9gicOKhWi1A+1xbnQ2VB0Hbdb8/dSj8510Y4x1ELAYtPg6CI
         OBl0Wy+4qtaMe34Ij+iYcLqx3mAO3Kszp49c2Z1i4ieuypcs84T5mTimN5Yj+Wyq6S
         OLaN6oSBCTK3RlhUQBJfkn6YE/nOCyGSB1xaE9er6Oad+Qy5ByXBdU3tH9THm3fj5V
         TjxT5VN3QmDEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC8D1C395E0;
        Sat,  3 Jun 2023 20:02:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: Avoid to access invalid RMBs' MRs in SMCRv1 ADD
 LINK CONT
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168582254789.6132.5199487430130096814.git-patchwork-notify@kernel.org>
Date:   Sat, 03 Jun 2023 20:02:27 +0000
References: <1685608912-124996-1-git-send-email-guwen@linux.alibaba.com>
In-Reply-To: <1685608912-124996-1-git-send-email-guwen@linux.alibaba.com>
To:     Wen Gu <guwen@linux.alibaba.com>
Cc:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by David S. Miller <davem@davemloft.net>:

On Thu,  1 Jun 2023 16:41:52 +0800 you wrote:
> SMCRv1 has a similar issue to SMCRv2 (see link below) that may access
> invalid MRs of RMBs when construct LLC ADD LINK CONT messages.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000014
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] PREEMPT SMP PTI
>  CPU: 5 PID: 48 Comm: kworker/5:0 Kdump: loaded Tainted: G W   E      6.4.0-rc3+ #49
>  Workqueue: events smc_llc_add_link_work [smc]
>  RIP: 0010:smc_llc_add_link_cont+0x160/0x270 [smc]
>  RSP: 0018:ffffa737801d3d50 EFLAGS: 00010286
>  RAX: ffff964f82144000 RBX: ffffa737801d3dd8 RCX: 0000000000000000
>  RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff964f81370c30
>  RBP: ffffa737801d3dd4 R08: ffff964f81370000 R09: ffffa737801d3db0
>  R10: 0000000000000001 R11: 0000000000000060 R12: ffff964f82e70000
>  R13: ffff964f81370c38 R14: ffffa737801d3dd3 R15: 0000000000000001
>  FS:  0000000000000000(0000) GS:ffff9652bfd40000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000014 CR3: 000000008fa20004 CR4: 00000000003706e0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   <TASK>
>   smc_llc_srv_rkey_exchange+0xa7/0x190 [smc]
>   smc_llc_srv_add_link+0x3ae/0x5a0 [smc]
>   smc_llc_add_link_work+0xb8/0x140 [smc]
>   process_one_work+0x1e5/0x3f0
>   worker_thread+0x4d/0x2f0
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0xe5/0x120
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x2c/0x50
>   </TASK>
> 
> [...]

Here is the summary with links:
  - [net] net/smc: Avoid to access invalid RMBs' MRs in SMCRv1 ADD LINK CONT
    https://git.kernel.org/netdev/net/c/c308e9ec0047

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


