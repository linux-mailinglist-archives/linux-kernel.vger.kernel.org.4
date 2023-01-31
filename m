Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54C868361F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjAaTK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjAaTKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:10:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0460E56490
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:10:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3071B81E3B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 19:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40AB7C4339C;
        Tue, 31 Jan 2023 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675192220;
        bh=5NLjWCifPKsQYHmWtcs0Dc3TPZQumXh9dKHEVGxZPRU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MDsfcKYIuZoY8ld3wB8Px3FT0Jrg1ZliYZ/XGhL0ZqH0vmue+4xOIr7zVR3NoaUAG
         TjkIlQmlgP1B4QiRIFDQCN3Y7unvvpLV7NjyvQDNcq8D9z2TfJaGmwr02qBtGFt9fF
         WoTg9rlZYfHxIzjPPK7/2aGVlOTsv0T4g/s5shDfnF/8V7Be5/A240c2h3fiDdZYp5
         MJX5AyXq2HD2aZkDWLZaHSiD2CSJJwyV5UyYBV+cbj5IuBiBZ6AemZ3tROjELkdl3w
         Rem1nQFch3t0UTX8t7tLJmyDIwlS1eUrGOLc+iI61U8aTJTnqcCzt0FxA/r+T0XkBc
         6j48/Z6ezlqyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14C76C0C40E;
        Tue, 31 Jan 2023 19:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: reduce stack memory cost by using
 bitfield in struct f2fs_io_info
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167519222008.20142.15227307379912347562.git-patchwork-notify@kernel.org>
Date:   Tue, 31 Jan 2023 19:10:20 +0000
References: <20230130012012.2078978-1-chao@kernel.org>
In-Reply-To: <20230130012012.2078978-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 30 Jan 2023 09:20:12 +0800 you wrote:
> This patch tries to use bitfield in struct f2fs_io_info to improve
> memory usage.
> 
> struct f2fs_io_info {
> ...
> 	int need_lock:8;	/* indicate we need to lock cp_rwsem */
> 	int version:8;		/* version of the node */
> 	int submitted:1;	/* indicate IO submission */
> 	int in_list:1;		/* indicate fio is in io_list */
> 	int is_por:1;		/* indicate IO is from recovery or not */
> 	int retry:1;		/* need to reallocate block address */
> 	int encrypted:1;	/* indicate file is encrypted */
> 	int post_read:1;	/* require post read */
> ...
> };
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: reduce stack memory cost by using bitfield in struct f2fs_io_info
    https://git.kernel.org/jaegeuk/f2fs/c/998863dadd2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


