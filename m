Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADFD742DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjF2T1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjF2TZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:25:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65923AB1;
        Thu, 29 Jun 2023 12:24:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F18061627;
        Thu, 29 Jun 2023 19:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB296C433CB;
        Thu, 29 Jun 2023 19:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688066683;
        bh=L9C7oOakDN59nBwxio4rrnZ5puCMWHaJhaQkT95aTVs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tIh/Xv1fjjFllaWns4oz4Nak8x4gAUKrBLHf7Xgu65f26Q6G0PLLaEcyWYQ7zNkOL
         5oKn78ofQ2lwfXdUb7ncxnpUZe7vY4e0Dop96CCxzxZLND6S/yBdP+OEVSiYaKdh7a
         CfZaBLGa/siBHomfr/EGpOAQRVBrAKG40/LIx+uiCJB6MtHk3Od7iycx7nKZSBDTgU
         JHeFB1GLERTyamYrx0gI7Zpcu7kdSqFQmLgDjZDl2qxFFjrNJg8pgKHqoP7jFqMCPw
         v0RkKgxaMVPeC3WZOv5McxSh7ujI6LttGFY8RGRLQC4lTSm5jwjVkzIM+92X79N1x8
         BIoHXxjErQXqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A334AE5381B;
        Thu, 29 Jun 2023 19:24:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 1/3] Bluetooth: btusb: mediatek: readx_poll_timeout
 replaces open coding
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168806668365.29593.2167157062342737212.git-patchwork-notify@kernel.org>
Date:   Thu, 29 Jun 2023 19:24:43 +0000
References: <80efe66b16d933e3457bd38b1a60a5d51d4dee9e.1687991820.git.objelf@gmail.com>
In-Reply-To: <80efe66b16d933e3457bd38b1a60a5d51d4dee9e.1687991820.git.objelf@gmail.com>
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        chris.lu@mediatek.com, Soul.Huang@mediatek.com,
        Leon.Yen@mediatek.com, Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, jenhao.yang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        abhishekpandit@google.com, michaelfsun@google.com,
        mmandlik@google.com, abhishekpandit@chromium.org,
        mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
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

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 Jun 2023 06:54:55 +0800 you wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Use readx_poll_timeout instead of open coding to poll the hardware reset
> status until it is done.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> 
> [...]

Here is the summary with links:
  - [v8,1/3] Bluetooth: btusb: mediatek: readx_poll_timeout replaces open coding
    https://git.kernel.org/bluetooth/bluetooth-next/c/c56e5f834e13
  - [v8,2/3] Bluetooth: btmtk: introduce btmtk reset work
    https://git.kernel.org/bluetooth/bluetooth-next/c/ed2e80b8b6a7
  - [v8,3/3] Bluetooth: btusb: mediatek: add MediaTek devcoredump support
    https://git.kernel.org/bluetooth/bluetooth-next/c/872f8c253cb9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


