Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54EA64AAB6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiLLW7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbiLLW7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:59:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0EFFD15
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:59:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26DD86125C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62116C433D2;
        Mon, 12 Dec 2022 22:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670885951;
        bh=J8NGtFkQLRX6/TbtLwsBA7Kjq8Yuonc02Ue0Zj4NUwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VpkuGvomgZG5gzrK6Jnyc/CpL8p+DoFA7fTxHjM3uZ3UB/oyVZcgAil3S+mYfVUXo
         33aPAHt5PyeSZccz6RG47o39CQUt2xNB81st9jHCcArrQUDxF96OQBb5RTfyjtwRu9
         75SdWuB5xwha4xQBlYAR1UXX6Z0nYbnM6sCOWB59MR9GfebBrSdM+MFAYp/mHTbPWN
         MnIp5LAI3ZYz4XXOHDI6y3YN8afh4SFgy35ezIVJOhoMC8/dY+pfg4qgTx5f/RIIRM
         s35vDQPuFFiHzsGEOgMywvN+9VYOjG63FMwLlGwbRf47jXrUSTXGUSsUn+7pEn9Sd/
         3kP3T0G3qD+XQ==
Date:   Mon, 12 Dec 2022 14:59:09 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix iostat parameter for discard
Message-ID: <Y5eyPe7Yqz2xpluU@google.com>
References: <20221205145603.70779-1-frank.li@vivo.com>
 <38ab73c5-4865-188f-9554-6bcaec7cc78b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38ab73c5-4865-188f-9554-6bcaec7cc78b@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11, Chao Yu wrote:
> On 2022/12/5 22:56, Yangtao Li wrote:
> > Just like other data we count uses the number of bytes as the basic unit,
> > but discard uses the number of cmds as the statistical unit. In fact the
> > discard command contains the number of blocks, so let's change to the
> > number of bytes as the base unit.
> > 
> > Fixes: b0af6d491a6b ("f2fs: add app/fs io stat")
> > 
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> >   fs/f2fs/segment.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 9486ca49ecb1..bc262e17b279 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -1181,7 +1181,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
> >   		atomic_inc(&dcc->issued_discard);
> > -		f2fs_update_iostat(sbi, NULL, FS_DISCARD, 1);
> > +		f2fs_update_iostat(sbi, NULL, FS_DISCARD, len * F2FS_BLKSIZE);
> 
> In order to avoid breaking its usage of application, how about keeping
> FS_DISCARD as it is, and add FS_DISCARD_IO to account discard bytes?

I picked this to match the f2fs_update_iostat() definition. Do we know
how many applications will be affected? I don't have any at a glance in
Android tho.

void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
                        enum iostat_type type, unsigned long long io_bytes)


> 
> Thanks,
> 
> >   		lstart += len;
> >   		start += len;
