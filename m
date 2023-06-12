Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1780F72CA55
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbjFLPgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjFLPgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:36:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38A110C2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:36:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60C6062AD9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F95EC433EF;
        Mon, 12 Jun 2023 15:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686584188;
        bh=zpOn3jUXIrlXKUjJILYlq5I40bKGQmYkswCO9MlY7KA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NxChhF1G2ao1OJQUDnlsP1lZvkzHoIylc5plx01sWujrq4b/Z9Xsihy1S73mwtUQR
         DeRoKFIv5JF6KyMOAF1OuaRwPqVPL1jmWOFk4+HDnJwqpg0Z5qMDQsDFai42y4hmtG
         n0xgMQVxz9mO0fOFkGgfVNqJ3ND+p6wCrDMp/GhYHYVqRai8f2hQNgNcKStRVUsbAO
         blOwFDexlwFRkEHLaR/JxAnD4ROvHfRwdlpDGuY2AeEaH0oz5/W29xb+GbosgA3E+e
         v65m30bmPQFXmiT+eB70izkOprvMbA0Cdr/69yJX8AWqABsYspmOyV/ai9Yh17c/L4
         DRgPLhP7/V5vg==
Date:   Mon, 12 Jun 2023 08:36:26 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress tmp files given extension
Message-ID: <ZIc7ek4UWwjB41a5@google.com>
References: <20230606203645.3926651-1-jaegeuk@kernel.org>
 <7af0f599-2314-56af-2813-5e63754134e1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7af0f599-2314-56af-2813-5e63754134e1@kernel.org>
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
> On 2023/6/7 4:36, Jaegeuk Kim wrote:
> > Let's compress tmp files for the given extension list.
> 
> Could you please check below commit? IIRC, it was introduce to avoid compressing
> file which has unpredictable tmp file, e.g. foo.sox.
> 
> Could you please describe the case you encounter?

I don't know what I need to describe more tho, looking at how to compress
abc.so.tmp and abc.so, given compress_extension=so.

So, your concern is somehow abc.soa? If so, we need to fix is_extension_exist.
Will check what's going on here.

> 
> commit 4a67d9b07ac8dce7f1034e0d887f2f4ee00fe118
> Author: Chao Yu <chao@kernel.org>
> Date:   Tue May 18 17:54:58 2021 +0800
> 
>     f2fs: compress: fix to disallow temp extension
> 
>     This patch restricts to configure compress extension as format of:
> 
>      [filename + '.' + extension]
> 
>     rather than:
> 
>      [filename + '.' + extension + (optional: '.' + temp extension)]
> 
>     in order to avoid to enable compression incorrectly:
> 
>     1. compress_extension=so
>     2. touch file.soa
>     3. touch file.so.tmp
> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/namei.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > index 3e35eb7dbb8f..cdc94c8e60f7 100644
> > --- a/fs/f2fs/namei.c
> > +++ b/fs/f2fs/namei.c
> > @@ -161,7 +161,7 @@ static void set_compress_new_inode(struct f2fs_sb_info *sbi, struct inode *dir,
> >   	/* Compress wanting extension. */
> >   	for (i = 0; i < ext_cnt; i++) {
> > -		if (is_extension_exist(name, ext[i], false)) {
> > +		if (is_extension_exist(name, ext[i], true)) {
> >   			set_compress_context(inode);
> >   			return;
> >   		}
