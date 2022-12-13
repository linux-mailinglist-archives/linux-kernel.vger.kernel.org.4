Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1443164AD8F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 03:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbiLMCVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 21:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiLMCV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:21:27 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6771B7B5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 18:21:24 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso228280pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 18:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3GJvqoej8HYxTnxfSuAPi6hTjb1Vgz1dmuhQAIbX9nU=;
        b=pXvyZqmR+fhVi20IlDjOV2Q3MEsWPbOYS18DKR68vMzvEyspd/XpHRmI/p1Btap2Sf
         DsMe9t/H17Ep5HryqMpJKZ7L9ePm7SZ8p5DlmofWc3Qjf3CXS6vz4HPMBaILiTMvjJGx
         4d4fweQDMPY0sOQrLpW5WzVryzaZwMA/Je7SvBjADzephzI0lEKJBMCUc918sgHl0thX
         y7RAW8K+GNt20urQd/bFPp8vBnjWWbjGRfCOkv1Pd9Ahtv7YkaLJj4ylei/7geg0ZLH9
         +AYOQOI5qWsMam9mWSnMHNe6uPvwja47a8nT0EJeGA4BCX+S0wjEVfkixeOVTsihUxQn
         XvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GJvqoej8HYxTnxfSuAPi6hTjb1Vgz1dmuhQAIbX9nU=;
        b=Pjey9pZVmnZUvltDlzIW/kIrgi1YBILE7+X1UmkTTu11Jkaa3CLYh0j81pkLn6soEW
         CuQhzbwyvQOKK4rQNURn1lmIugPMkDCdparn9/BC/07/hklN+0aGSwqWWzEumMEoVvdt
         XUuMrDwH8kmeV5Qb2Q9DXCMnXKyG6Ecxib0Dywx7VGCmEAooN82kLuIQvk5di7Nbk6wQ
         Y4FlEEdCb5234840ZWRBhkO/QZ3CymQ4ZFlrkgtxrjlHEzysRyL5N5avlvO5JqLtxNLN
         ds/S6ZloYq8v0ls2lP+oskeQjmQTkr9tm5+8zg2iC/xxBvLXVrfn6mgp39JAbnMFaUdu
         5uOQ==
X-Gm-Message-State: ANoB5pmVMbcQ6oFc5SMEHFMvCK16fxV2QVWzwWyBv5ugY63F0Vs8HJFf
        1bLJz7tPj975Ds2aUE825SQ=
X-Google-Smtp-Source: AA0mqf777PQQ8zccjWAtTOaxYZB+2AHCAP7D4AyTJhtpBojKU57ansA0CiKHHn5CJNaxclSljVe/9Q==
X-Received: by 2002:a05:6a20:699b:b0:9d:efbe:2078 with SMTP id t27-20020a056a20699b00b0009defbe2078mr30988576pzk.46.1670898084417;
        Mon, 12 Dec 2022 18:21:24 -0800 (PST)
Received: from mi-ThinkStation-K ([43.224.245.228])
        by smtp.gmail.com with ESMTPSA id f4-20020a63dc44000000b004786c63c21esm5795430pgj.42.2022.12.12.18.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 18:21:23 -0800 (PST)
Date:   Tue, 13 Dec 2022 10:21:00 +0800
From:   zhoudan <zhuqiandann@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, zhoudan8@xiaomi.com
Subject: Re: [PATCH] f2fs: don't set FI_COMPRESS_RELEASED if file is not
 compressed
Message-ID: <20221213022100.GA841758@mi-ThinkStation-K>
References: <20221208050808.2448146-1-zhoudan8@xiaomi.com>
 <Y5OYYJYx9G2LbRmc@google.com>
 <20221212122109.GA714122@mi-ThinkStation-K>
 <Y5ezpOwd8sOTTaW5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5ezpOwd8sOTTaW5@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

However, 'f2fs_compressed_file()' only determines whether the file can 
be compressed, not whether the file has been compressed. As far as I 
know, when compress_mode is user, files marked FI_COMPRESSED_FILE 
will be compressed only after 'f2fs_ioc_compress_file()' is called.
On Mon, Dec 12, 2022 at 03:05:08PM -0800, Jaegeuk Kim wrote:
> On 12/12, zhoudan wrote:
> > Maybe I'm not describing it clearly enough, but I think there is 
> > something wrong with the logic here.The 'f2fs_release_compress_blocks'
> > method does not determine if the file is compressed, but simply adds 
> > the FI_COMPRESS_RELEASED flag. 
> 
> I firstly lost your point since f2fs_release_compress_blocks() checked
> f2fs_compressed_file().
> 
> > In particular, in the current Android system, when the application is 
> > installed, the release interface is called by default to release the 
> > storage marked as compressed,  without checking whether the file is 
> > actually compressed. In this case, when compress_mode is set to user, 
> > calling the compress interface returns ENVAL and the file cannot be 
> > compressed.
> > So I think the implementation of release needs to be modified, and 
> > only set FI_COMPRESS_RELEASED when it's really compressed and the 
> > storage is released.
> > 
> > On Fri, Dec 09, 2022 at 12:19:44PM -0800, Jaegeuk Kim wrote:
> > > On 12/08, zhoudan8 wrote:
> > > > In compress_mode=user, f2fs_release_compress_blocks()
> > > >  does not verify whether it has been compressed and
> > > >  sets FI_COMPRESS_RELEASED directly. which will lead to
> > > > return -EINVAL after calling compress.
> > > > To fix it,let's do not set FI_COMPRESS_RELEASED if file
> > > > is not compressed.
> > > 
> > > Do you mean you want to avoid EINVAL on a file having FI_COMPRESS_RELEASED
> > > with zero i_compr_blokcs?
> > > 
> > > I think the current logic is giving the error on a released file already.
> > > 
> > > > 
> > > > Signed-off-by: zhoudan8 <zhoudan8@xiaomi.com>
> > > > ---
> > > >  fs/f2fs/file.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > index 82cda1258227..f32910077df6 100644
> > > > --- a/fs/f2fs/file.c
> > > > +++ b/fs/f2fs/file.c
> > > > @@ -3451,14 +3451,13 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
> > > >  	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
> > > >  	if (ret)
> > > >  		goto out;
> > > > -
> > > > -	set_inode_flag(inode, FI_COMPRESS_RELEASED);
> > > >  	inode->i_ctime = current_time(inode);
> > > >  	f2fs_mark_inode_dirty_sync(inode, true);
> > > >  
> > > >  	if (!atomic_read(&F2FS_I(inode)->i_compr_blocks))
> > > >  		goto out;
> > > >  
> > > > +	set_inode_flag(inode, FI_COMPRESS_RELEASED);
> > > >  	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > > >  	filemap_invalidate_lock(inode->i_mapping);
> > > >  
> > > > -- 
> > > > 2.38.1
