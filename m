Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3422E6D5061
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjDCSad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjDCSa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:30:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73F4212E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EBDD619EB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B09D3C433EF;
        Mon,  3 Apr 2023 18:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680546618;
        bh=4LH6DmsLQfzTs2kOVQRO7644p9IgdG5cgEpOhmSGjRM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oTD81naPwuSaro0Hvwrg1IJXSP2u1sMcvRGBbpwv1mhhjeLHp8blQZXsylbgYrivI
         EKX6thdKaKqSgGE+n4dRucWLN0dolTkLXBOrqjvvbF+HTYqBOyrJpmVFbvYW66JXOP
         IlPVsGGNuAzWG7sCBXrkR5zXRb/Qlt63kJQYwh0BN047YVIfVaE/vN62vfohT/Bgu7
         4GgUC+ajo7U6v3xFW6C+RjZWNzqO4Y8wnQp1HXibjmjXVngYTESZKPDTXaI5sQ/fGx
         DM3rPUFuPQnUwUeAoPFxRhZ7SJ3A7gMH+Vca3HV+VKw2MnnJ5V2rVyovqTjUf9MDg/
         9hOgwRKrnAicQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93268E5EA86;
        Mon,  3 Apr 2023 18:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix iostat lock protection
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168054661859.14597.6329451701329861497.git-patchwork-notify@kernel.org>
Date:   Mon, 03 Apr 2023 18:30:18 +0000
References: <20230331092658.72386-1-bo.ye@mediatek.com>
In-Reply-To: <20230331092658.72386-1-bo.ye@mediatek.com>
To:     Bo Ye <bo.ye@mediatek.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, qilin.tan@mediatek.com,
        yongdong.zhang@mediatek.com, linux-kernel@vger.kernel.org,
        light.hsieh@mediatek.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-mediatek@lists.infradead.org, browse.zhang@mediatek.com,
        linux-arm-kernel@lists.infradead.org, peng.zhou@mediatek.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 31 Mar 2023 17:26:56 +0800 you wrote:
> From: Qilin Tan <qilin.tan@mediatek.com>
> 
> Made iostat lock irq safe to avoid potentinal deadlock.
> 
> Deadlock scenario:
> f2fs_attr_store
>   -> f2fs_sbi_store
>   -> _sbi_store
>   -> spin_lock(sbi->iostat_lock)
>     <interrupt request>
>     -> scsi_end_request
>     -> bio_endio
>     -> f2fs_dio_read_end_io
>     -> f2fs_update_iostat
>     -> spin_lock_irqsave(sbi->iostat_lock)  ===> Dead lock here
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: fix iostat lock protection
    https://git.kernel.org/jaegeuk/f2fs/c/daa080db4e7e
  - [f2fs-dev,2/2] f2fs: add __pack attribute for extent_info
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


