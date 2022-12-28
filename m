Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A624657267
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 04:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiL1DuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 22:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiL1DuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 22:50:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1155F65AF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 19:50:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94560612E1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 03:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4335C433D2;
        Wed, 28 Dec 2022 03:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672199416;
        bh=iVSbpG5q72cpxth8FTXCpTOZjGJPR4Wcqvruu7fBW0s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mr/QYDTprNgtLfO/gEpob0rXmNgA7J+1kTJ3jFZBudtNoweC/dB1XQd+5MTZ99Bbd
         nHL9RT0KH7rFAMVfmMgcKZpLPGny+0ge8BEnpry973q1oenH9MG87258d2NBNWvz7O
         FKUkotyJXVU7QYaD8a+njiR6T/FU29XS+CH9Og4NToVbd9VJnVWw3R0sAo9KmThFm6
         i4mCsuAQNY73JkCU3qkOPTb32bgMKUmeQt+Z8GA1kro25JlRGBqjfevIZB61mE7Dlx
         zwDAuWb7lYnrXR9aAbJuYB7puutAQtYIhiSMMnNyYPR3jz0uCBvOhfw2LBcEgpqgn1
         AQLSWvIrRn/EA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB3E1E4D029;
        Wed, 28 Dec 2022 03:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v13 1/3] platform/chrome: cros_ec_uart: Add transport layer
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <167219941582.31925.13873263945811927474.git-patchwork-notify@kernel.org>
Date:   Wed, 28 Dec 2022 03:50:15 +0000
References: <20221227123212.v13.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
In-Reply-To: <20221227123212.v13.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     linux-kernel@vger.kernel.org, rrangel@chromium.org,
        bhanumaiya@chromium.org, pmalani@chromium.org, bleung@chromium.org,
        groeck@chromium.org, tzungbi@kernel.org,
        chrome-platform@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Tue, 27 Dec 2022 12:32:22 -0700 you wrote:
> From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> 
> This patch does following:
> 1. Adds a new cros-ec-uart driver. This driver can send EC requests on
>    UART and process response packets received on UART transport.
> 2. Once probed, this driver will initialize the serdev device based on
>    the underlying information in the ACPI resource. After serdev device
>    properties are set, this driver will register itself cros-ec.
> 3. High level driver can use this implementation to talk to ChromeOS
>    Embedded Controller device in case it supports UART as transport.
> 4. When cros-ec driver initiates a request packet, outgoing message is
>    processed in buffer and sent via serdev. Once bytes are sent, driver
>    enables a wait_queue.
> 5. Since ChromeOS EC device sends response asynchronously, AP's TTY
>    driver accumulates response bytes and calls the registered callback.
>    TTY driver can send multiple callback for bytes ranging from 1 to MAX
>    bytes supported by EC device.
> 6. Driver waits for EC_MSG_DEADLINE_MS to collect and process received
>    bytes. It wakes wait_queue if expected bytes are received or else
>    wait_queue timeout. Based on the error condition, driver returns
>    data_len or error to cros_ec.
> 
> [...]

Here is the summary with links:
  - [v13,1/3] platform/chrome: cros_ec_uart: Add transport layer
    https://git.kernel.org/chrome-platform/c/04a8bdd135cc
  - [v13,2/3] dt-bindings: mfd: cros-ec: Add UART compatible string
    https://git.kernel.org/chrome-platform/c/5be8cd61dcdd
  - [v13,3/3] platform/chrome: cros_ec_uart: Add DT enumeration support
    https://git.kernel.org/chrome-platform/c/c34fea225806

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


