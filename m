Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F4273FD6B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjF0OKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjF0OKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B682129;
        Tue, 27 Jun 2023 07:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C723611B1;
        Tue, 27 Jun 2023 14:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA6F7C433C9;
        Tue, 27 Jun 2023 14:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687875020;
        bh=41mhKtRygxn0cfvIJ7LiprOmFh4P7ibsganlOCklc90=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FpJczB8rgiC0c1lLjEbvYtuZGTO6gmy8c8JTg2YFHip4pPITMtGMQXV+a4YwAz4DN
         m+dd9lUkrT0uRa3rsGE21yA379NFgAEX7OAISGMQbA4jpFJIWlANuMvA25mcnTObdl
         SnW5ci4Yi/E/htpbK60FT9i2S1JDl5x7MJf9kdNpKhpp/UbigbWowR5rNhuUlSyB0i
         LuPzqTcGR9CfJGj/DXtA5quva8CjZrdv6cyi6hzN7AnSQUmwxNq61LO9ao4AMFfrvx
         QrPnypixdLL/RnNKrJA48Ro7BkrRiQu0+iR8MxZtIvUUykzEEI0YJE1+8RpotFBrWL
         yrVMgh91htJjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A63D3E53800;
        Tue, 27 Jun 2023 14:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] perf trace: fix MSG_SPLICE_PAGES build error
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168787502067.23817.13449627195435393734.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Jun 2023 14:10:20 +0000
References: <20230626090239.899672-1-matthieu.baerts@tessares.net>
In-Reply-To: <20230626090239.899672-1-matthieu.baerts@tessares.net>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     dhowells@redhat.com, acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, bpf@vger.kernel.org,
        davem@davemloft.net, irogers@google.com, jolsa@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org, sfr@canb.auug.org.au,
        acme@redhat.com
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
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 26 Jun 2023 11:02:39 +0200 you wrote:
> Our MPTCP CI and Stephen got this error:
> 
>     In file included from builtin-trace.c:907:
>     trace/beauty/msg_flags.c: In function 'syscall_arg__scnprintf_msg_flags':
>     trace/beauty/msg_flags.c:28:21: error: 'MSG_SPLICE_PAGES' undeclared (first use in this function)
>        28 |         if (flags & MSG_##n) {           |                     ^~~~
>     trace/beauty/msg_flags.c:50:9: note: in expansion of macro 'P_MSG_FLAG'
>        50 |         P_MSG_FLAG(SPLICE_PAGES);
>           |         ^~~~~~~~~~
>     trace/beauty/msg_flags.c:28:21: note: each undeclared identifier is reported only once for each function it appears in
>        28 |         if (flags & MSG_##n) {           |                     ^~~~
>     trace/beauty/msg_flags.c:50:9: note: in expansion of macro 'P_MSG_FLAG'
>        50 |         P_MSG_FLAG(SPLICE_PAGES);
>           |         ^~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [net-next] perf trace: fix MSG_SPLICE_PAGES build error
    https://git.kernel.org/netdev/net-next/c/2553a5270d6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


