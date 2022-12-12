Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB12A64AA8D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbiLLWp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbiLLWpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:45:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAAB5F85
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:45:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0274C61257
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8C6C433D2;
        Mon, 12 Dec 2022 22:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670885151;
        bh=5kq95Pw53HX7zhofjWxC1xDEv7YmHp1EXdZBaOLAUA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VuIhAEq+r2QP+BHcS3AZ7Z3iV5o3qKTRYdrC7afzDKSeUQAFBmwA9jr7fAR6vY4kP
         w53Haxf0laLHSJsFSJwxSiaMXn8ZlrD0dRaF/Lk6sckD7orHs7V/SL+BvyA2WFbAcS
         TJ1ysYQwlHtXJJ47OHf5sJcircVOE3HdmHCY0bgZyuBAzl7OCf5sBPkcuRBIbqbaOs
         mMVHh3w50S6nvUCLcbqCGTWC5u2x045LIWgsEJPfk56vFP5tNWoJncEpIg5Ni4SQXo
         ZFeqTem0KpafQyuicbKB/uPr2b3UH0uO75c1LbKNjejrNXqzSpjAWfOoU94XGt2Dqy
         I2lF09RksM74Q==
Date:   Mon, 12 Dec 2022 14:45:49 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: don't call f2fs_issue_discard_timeout() when
 discard_cmd_cnt is 0 in f2fs_put_super()
Message-ID: <Y5evHVvzGC/8lMfK@google.com>
References: <974f5013-b6af-a39e-0b0f-2ce86253eaeb@kernel.org>
 <20221212141429.6329-1-frank.li@vivo.com>
 <2f100a4a-592d-f098-b204-efeef58341ee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f100a4a-592d-f098-b204-efeef58341ee@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12, Chao Yu wrote:
> On 2022/12/12 22:14, Yangtao Li wrote:
> > Hi Chao,
> > 
> > > The difference here is, if we use f2fs_realtime_discard_enable() in
> > > f2fs_put_super(), we will only write checkpoint w/ CP_TRIMMED flag
> > > when discard option is enable and device supports discard.
> > 
> > > But actually, if discard option is disabled, we still needs to give
> > > put_super() a chance to write checkpoint w/ CP_TRIMMED flag.
> > 
> > Why do we still have to set the CP_TRIMMED flag when the discard opt is not set.
> > Did I miss something?
> 
> Hi Yangtao,
> 
> I guess it's up to scenario. e.g.
> 
> mount w/ nodiscard and use FITRIM to trigger in-batch discard,
> if we set CP_TRIMMED flag during umount, next time, after mount
> w/ discard, it doesn't to issue redundant discard.

If fitrim was called with a range, we can get a wrong FI_TRIMMED flag. Isn't it
better to get a full discard range after remount even though some are redundant?

> 
> Thanks,
> 
> > 
> > Thx,
> > Yangtao
