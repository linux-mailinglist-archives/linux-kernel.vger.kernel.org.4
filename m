Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B034742D84
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjF2T0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjF2TZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:25:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58FF3AAC;
        Thu, 29 Jun 2023 12:24:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7737761620;
        Thu, 29 Jun 2023 19:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7B88C433CC;
        Thu, 29 Jun 2023 19:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688066683;
        bh=jN2tbwzFtwBzzn/Qy+P5/edqsoBeZ3fi508iKgvEF3Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ilAzRNspCBmZ3LQIqSOoB+gXOhPg4f2vrOVtgJabshCcF+xo48dPhsyI3kZMJjDqt
         q9pPHccW1gf/K07W4/oJPE6+YY+hpuPNCrAolTmCT071FD4WmF6xq+XEhUsh2OfY7+
         eTGiwoXO241vDnhb4ZxZwynoE3iNI970zXQ06P22ycOe4WNPPFwlqItklbExDb4HOF
         dVZ0rDa5T6AXtXrpJDYF8lJyiJNrXGoyTAJOF0O7QORxfB/5sKRaxWkzJfca52jHG5
         BYe7ebPQKZdu7nk1yGXQUO8pmk1uKbRAFhv+aDKpRQZpwK5os3z4G7hFnpCPBo7SRY
         huu0Xm6TmHvFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6FAAC6445A;
        Thu, 29 Jun 2023 19:24:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 1/3] Bluetooth: btusb: mediatek: use readx_poll_timeout
 instead of open coding
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168806668374.29593.18057977717235081592.git-patchwork-notify@kernel.org>
Date:   Thu, 29 Jun 2023 19:24:43 +0000
References: <2d7bef70b876e4cbd447c5109956f716bad5bc2d.1687565769.git.objelf@gmail.com>
In-Reply-To: <2d7bef70b876e4cbd447c5109956f716bad5bc2d.1687565769.git.objelf@gmail.com>
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        chris.lu@mediatek.com, Soul.Huang@mediatek.com,
        Leon.Yen@mediatek.com, Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, jenhao.yang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        abhishekpandit@google.com, michaelfsun@google.com,
        abhishekpandit@chromium.org, mcchou@chromium.org,
        shawnku@google.com, linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
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

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Jun 2023 04:41:37 +0800 you wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Use readx_poll_timeout instead of open coding to poll the hardware reset
> status until it is done.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> 
> [...]

Here is the summary with links:
  - [v7,1/3] Bluetooth: btusb: mediatek: use readx_poll_timeout instead of open coding
    https://git.kernel.org/bluetooth/bluetooth-next/c/c56e5f834e13
  - [v7,2/3] Bluetooth: btmtk: introduce btmtk reset work
    (no matching commit)
  - [v7,3/3] Bluetooth: btusb: mediatek: add MediaTek devcoredump support
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


