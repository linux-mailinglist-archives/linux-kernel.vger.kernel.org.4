Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF1D72C993
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbjFLPQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbjFLPQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:16:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6289DE7A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:16:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD904616C1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221C2C433D2;
        Mon, 12 Jun 2023 15:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686582979;
        bh=VLmvo45nf29IuG+YTl9Gl3lt4c+ebnPo5uxerXRlXko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bshr1OfYltFslXZdEjlUSqICDgJI1LPrtzlg4RjMXgNVBy5t0laRk4j0e8oAp7SWD
         /HeQd41h84YtSmYI8DPAWppaKZGw3O260hkx9AVF5vbGcx9jHGi5WIVZjS4kiAr7cb
         dEFrkHfXIoEBFFqYQd8Um0IZo1s53eLemxXjm0E7aksMsYx3naW26tnV6pBv1El3DF
         CnkldVBK9IXX1NVRerTjTT7qn1NNgPNPda4nElyPi6n+plkt0YGa4kVa3mx3qOFXlP
         PJEG4XkwvK1pRaCwroaByVOH7AOxi5Eh6IfOBv+ZhhvhJutVevEyuP3i0PGNQjqe1r
         rXUA3GQ6JpTyg==
Date:   Mon, 12 Jun 2023 08:16:17 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: set zstd default compression level to 3
Message-ID: <ZIc2wa2ZRLQ/Q8LE@google.com>
References: <20230607162954.2651657-1-jaegeuk@kernel.org>
 <85ff67e0-c6c6-e693-bcba-6e36a3dd2ea4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85ff67e0-c6c6-e693-bcba-6e36a3dd2ea4@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12, Chao Yu wrote:
> On 2023/6/8 0:29, Jaegeuk Kim wrote:
> > ZSTD does not support compress_level=0.
> 
> IIUC, it looks the range is [0, ZSTD_MAX_CLEVEL], 0 equals to default
> (ZSTD_CLEVEL_DEFAULT).

Ok, that seems a quick workaround of zstd, since it'd be quite hard to know
level=0 will be interpreted to whatever default behind the scenes.

> 
> zstd_compress.c
> 
>     /* row */
>     if (compressionLevel == 0) row = ZSTD_CLEVEL_DEFAULT;   /* 0 == default */
>     else if (compressionLevel < 0) row = 0;   /* entry 0 is baseline for fast mode */
>     else if (compressionLevel > ZSTD_MAX_CLEVEL) row = ZSTD_MAX_CLEVEL;
>     else row = compressionLevel;
> 
> Thanks,
> 
> > 
> > The commit d7ffafc99c42 ("f2fs: add sanity compress level check for compressed file")
> > revealed the issue.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/super.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 8fd23caa1ed9..1fb8d4f27a40 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -627,7 +627,7 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
> >   	int len = 4;
> >   	if (strlen(str) == len) {
> > -		F2FS_OPTION(sbi).compress_level = 0;
> > +		F2FS_OPTION(sbi).compress_level = 3;
> >   		return 0;
> >   	}
