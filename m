Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5446F9E70
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 05:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjEHD4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 23:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjEHD4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 23:56:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460D45FD1;
        Sun,  7 May 2023 20:56:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6D4A61E52;
        Mon,  8 May 2023 03:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5E8FC4339E;
        Mon,  8 May 2023 03:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683518162;
        bh=Fu6gVnMtHqTZpyypofzpTYmo67wTgSom5YIB1n37dXE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Wc47SxRZPFSGz6n7NcJqwwMTGEIp05ZD2f3EFftmYcbdESoM0QfZhEhysUUGykfjg
         2iimF5xrFB/zHh4pZLBp1YxOAVw0uyBvE7wzOIC4at1x5Xg3AzvAD72AVYozYP9kF9
         wJLSmroRzUdZgLC3ji00mUfRbOh5b5VtIMpbEcA+v+EmSkTxAml2/nrR6DCDNyG/6k
         cuAtWstDi7GYkcI3Ta5q8mmq2UpJl2nDJq1xyIuZ+bxq+mxbc4guDaOggAhAZyaiKo
         +e7V3NAd9+GaHMpWZB0HMyDOaWLBRMZd2dmqZR7PRYiI6B3nKGH0/889A/pMCfMO6Q
         04vuaTF+thtUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BDF96E26D27;
        Mon,  8 May 2023 03:56:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] pwm: Ensure .polarity is set in .get_state()
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <168351816176.5651.17672713691449446038.git-patchwork-notify@kernel.org>
Date:   Mon, 08 May 2023 03:56:01 +0000
References: <20230228135508.1798428-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230228135508.1798428-1-u.kleine-koenig@pengutronix.de>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40pengutronix=2Ede=3E?=@ci.codeaurora.org
Cc:     thierry.reding@gmail.com, kamatam@amazon.com,
        xuejiancheng@hisilicon.com, yuanjian12@hisilicon.com,
        robh@kernel.org, bleung@chromium.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        groeck@chromium.org, chrome-platform@lists.linux.dev,
        kernel@pengutronix.de
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

This patch was applied to chrome-platform/linux.git (for-next)
by Thierry Reding <thierry.reding@gmail.com>:

On Tue, 28 Feb 2023 14:55:04 +0100 you wrote:
> Hello,
> 
> in the context of the discussion with Munehisa Kamata about the meson driver
> not setting .polarity in .get_state() I checked the other drivers for the same
> issue. The identified drivers are fixed here. For three of them
> zero-initializing *state would be good enough, still I think setting the
> polarity explicitly is a good idea. For the hibvt driver (that supports
> both polarities) the change is a real improvement.
> 
> [...]

Here is the summary with links:
  - [2/4] pwm: cros-ec: Explicitly set .polarity in .get_state()
    https://git.kernel.org/chrome-platform/c/30006b77c7e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


