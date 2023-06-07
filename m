Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36EB726762
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjFGRa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjFGRac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:30:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C982114
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F0B16420A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 17:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FDD8C4339E;
        Wed,  7 Jun 2023 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686159025;
        bh=j+ZyRRT6qc28MG3Irp4xXHMDHCVWM5gjkopPvv30d/w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DQFEihDpJl4lFI3g/XYu3hNCTwGd5c4BogX/uTVU9fP+ZMb8737ZkUjt0Sm+o/nA2
         BLgYlzCPLahq0BwGlv7yJyY/O7oViA7ML0XJys9qQYEhZRxmVEziK8ygajc00/ucZr
         Qm+Ue6GmkYuHFzTyX7Ps6bkLdWZLAFN87CxZEGy1dV4enY+HEV2dlyc8CX0EKJIc+o
         CuFUWC6DFoXpLlRL4+VxYhMUFd6y8zNapnv4RXpFeussiphZ5MUUlECPZId6EzIB+5
         MVRAdJ1HPpkAesDuDSdcEc59hArBTgy8/gyHO/X0X17cuN8yWz/C8Bk/EOTixh79xd
         ujsBN3LAtCjyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42BD8E4F13C;
        Wed,  7 Jun 2023 17:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3 1/1] f2fs: fix args passed to
 trace_f2fs_lookup_end
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168615902527.7521.505890454109723802.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Jun 2023 17:30:25 +0000
References: <20230601013759.75500-1-bo.wu@vivo.com>
In-Reply-To: <20230601013759.75500-1-bo.wu@vivo.com>
To:     Wu Bo <bo.wu@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, wubo.oduw@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  1 Jun 2023 09:37:59 +0800 you wrote:
> The NULL return of 'd_splice_alias' dosen't mean error. Thus the
> successful case will also return NULL, which makes the tracepoint always
> print 'err=-ENOENT'.
> 
> And the different cases of 'new' & 'err' are list as following:
> 1) dentry exists: err(0) with new(NULL) --> dentry, err=0
> 2) dentry exists: err(0) with new(VALID) --> new, err=0
> 3) dentry exists: err(0) with new(ERR) --> dentry, err=ERR
> 4) no dentry exists: err(-ENOENT) with new(NULL) --> dentry, err=-ENOENT
> 5) no dentry exists: err(-ENOENT) with new(VALID) --> new, err=-ENOENT
> 6) no dentry exists: err(-ENOENT) with new(ERR) --> dentry, err=ERR
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,1/1] f2fs: fix args passed to trace_f2fs_lookup_end
    https://git.kernel.org/jaegeuk/f2fs/c/fddd7d0466ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


