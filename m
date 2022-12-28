Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71DF657300
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 06:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiL1Fka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 00:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiL1FkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 00:40:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA881142
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 21:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 811A2B8122C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 05:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 326C7C433F0;
        Wed, 28 Dec 2022 05:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672206016;
        bh=9C/iGokP5mbB+1w9Ml8yw9eL3F6j+JXSOx4WmN/BV2c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ewvzqH5FtKddlBONfDVml9Gh6ilPTo+E/xOTFWwHRrZRS32XEF5yeZbJjyJK1yHPu
         v4bDVAJDHb3lUfu99xQAuADJCBqRG33tfQrdkg5NHimh+5jmNCKlntCiGsBL8Ec/vQ
         +7dfkHWQ3FcEPqtyEx9Bk/RLkjtXQkpvH8u9e+zYpPtaqlkR6fPuVeN4JQapiQ1UBK
         OtcR61JVWD7r5w7MNFr9Xp5bluWWvjlMuwwSwEaCct2Cs63HFB1bhRbiQc0VrICZQZ
         cS5lPo26eEh3wau2ugZDk+3s3Z1XwCTSWYJwiDQX9L/A+omYkiaLmfFppZg8DA3rAG
         tzmTfL96wCSVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15037E4D029;
        Wed, 28 Dec 2022 05:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v12 1/3] platform/chrome: cros_ec_uart: Add cros-ec-uart
 transport layer
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <167220601608.11271.13667673251726047908.git-patchwork-notify@kernel.org>
Date:   Wed, 28 Dec 2022 05:40:16 +0000
References: <20221209092619.v12.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
In-Reply-To: <20221209092619.v12.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     linux-kernel@vger.kernel.org, rrangel@chromium.org,
        bhanumaiya@chromium.org, lkp@intel.com, pmalani@chromium.org,
        bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
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

This series was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Fri,  9 Dec 2022 09:26:22 -0700 you wrote:
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
  - [v12,1/3] platform/chrome: cros_ec_uart: Add cros-ec-uart transport layer
    (no matching commit)
  - [v12,2/3] dt-bindings: mfd: cros-ec: Add UART compatible string
    https://git.kernel.org/chrome-platform/c/5be8cd61dcdd
  - [v12,3/3] platform/chrome: cros_ec_uart: Add DT enumeration support
    https://git.kernel.org/chrome-platform/c/c34fea225806

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


