Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27E68B48B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 04:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBFDk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 22:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBFDkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 22:40:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4712016320
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 19:40:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEBA8B80D24
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DCEAC4339E;
        Mon,  6 Feb 2023 03:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675654819;
        bh=3lsHKYlG0rjr2JlV/zJCvNh38EhpdamnhOGOfmFdU3A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=m8QfoChuBi6UKVquPysZISxu0Gm3T4biqEyZRiJOxk6cxvov4s8ItOhOwMKKUoaE6
         Ig4FYiVU2JrrvTtQcMgXaCpGlWCxN0ZhQ4DLoOLnbsSa5PTK+7FC1DnJ/xVsk2Zquy
         1aXXFNk8qZG424XbV7PzHg+jARQiZH7hv33rZ1OcSWkJk6fYfcZVQcRMqLNrDGYwuG
         5jbsPXeiqsxOSkaDH+QdhYQ9zIdz12Rl3z/QysmNZG3iODJwACI6hTHRvz4b3yd+j8
         k1h3h7BRcI+PVz2e6w27RqJjcK6mZ20xbO7pEWICiEW1e7skS8tHm+OmihdDuU2Wk9
         M4lftsW2/5uxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B0CBE55EFF;
        Mon,  6 Feb 2023 03:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: reduce stack memory cost by using
 bitfield in struct f2fs_io_info
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167565481942.5323.508420128518769085.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Feb 2023 03:40:19 +0000
References: <20230202070456.3497513-1-chao@kernel.org>
In-Reply-To: <20230202070456.3497513-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, nathan@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  2 Feb 2023 15:04:56 +0800 you wrote:
> This patch tries to use bitfield in struct f2fs_io_info to improve
> memory usage.
> 
> struct f2fs_io_info {
> ...
> 	unsigned int need_lock:8;	/* indicate we need to lock cp_rwsem */
> 	unsigned int version:8;		/* version of the node */
> 	unsigned int submitted:1;	/* indicate IO submission */
> 	unsigned int in_list:1;		/* indicate fio is in io_list */
> 	unsigned int is_por:1;		/* indicate IO is from recovery or not */
> 	unsigned int retry:1;		/* need to reallocate block address */
> 	unsigned int encrypted:1;	/* indicate file is encrypted */
> 	unsigned int post_read:1;	/* require post read */
> ...
> };
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: reduce stack memory cost by using bitfield in struct f2fs_io_info
    https://git.kernel.org/jaegeuk/f2fs/c/2eae077e6e46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


