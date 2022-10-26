Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CF360E621
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbiJZRFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbiJZRFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:05:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7968317CE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:04:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92D2CB82373
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 17:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30064C433D6;
        Wed, 26 Oct 2022 17:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666803896;
        bh=Q8RhGmve0EqK5guDgkRGYNKHoxwkXq/IG+Ua0iv00Ik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rCieFf8WqL2FpAcgU+cOs2w22J1Y6niUHB/uor+xLGDg/Mv/XH/ITS864Z9S8pEQv
         +Wkrt4CQsoKa+AAENjkfcOn4tIvDR73oyBgxUt55EZ6u0fvXko1Ls22bBspx62KBj/
         wFlWgKu2oF5k04p4+QHTSAXetBfsErFAXpAQGXcjESpgFO7b5PUJT1H12hk2YYk6GH
         /XEuJKVjDmeJHRgP6IHVT1Es3picTCllSIcpDo31ZKSrjCqiEQKh8THaDm1qNtFwKV
         Qj4edN7/N+rxE5qx3bt4rQ4b+0drMyjOVATc/dD7CzIhkAIkK1NVpVEXMXvnH3yAyM
         eUJuKBvbll06A==
Date:   Wed, 26 Oct 2022 10:04:54 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow to set compression for inlined
 file
Message-ID: <Y1lotu35Z/l6YzwR@google.com>
References: <20221024233634.803695-1-jaegeuk@kernel.org>
 <ae5f7c6e-248b-3cf7-b111-a4ddc85dd411@kernel.org>
 <Y1gg6P6CO9KbDO0O@google.com>
 <0a339e33-d79a-19e4-fadd-bb37a5a9f79d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a339e33-d79a-19e4-fadd-bb37a5a9f79d@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26, Chao Yu wrote:
> On 2022/10/26 1:46, Jaegeuk Kim wrote:
> > On 10/25, Chao Yu wrote:
> > > On 2022/10/25 7:36, Jaegeuk Kim wrote:
> > > > The below commit disallows to set compression on empty created file which
> > > > has a inline_data. Let's fix it.
> > > > 
> > > > Fixes: 7165841d578e ("f2fs: fix to check inline_data during compressed inode conversion")
> > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > ---
> > > >    fs/f2fs/file.c | 3 +++
> > > >    1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > index 1c4004c9245f..304fe08edc61 100644
> > > > --- a/fs/f2fs/file.c
> > > > +++ b/fs/f2fs/file.c
> > > > @@ -1915,6 +1915,9 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
> > > >    			if (!f2fs_disable_compressed_file(inode))
> > > >    				return -EINVAL;
> > > >    		} else {
> > > > +			/* try to convert inline_data to support compression */
> > > > +			f2fs_convert_inline_inode(inode);
> > > 
> > > It needs to check return value of f2fs_convert_inline_inode()?
> > 
> > I intended to catch that in the below checks?
> 
> But it may hide the real error number, e.g. -ENOMEM returned from
> f2fs_convert_inline_inode()?

Fair enough. Let me send v2.

> 
> Thanks,
> 
> > 
> > > 
> > > Thanks,
> > > 
> > > > +
> > > >    			if (!f2fs_may_compress(inode))
> > > >    				return -EINVAL;
> > > >    			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
