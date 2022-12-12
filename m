Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A08649E91
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiLLMVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLLMVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:21:32 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A2964EB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:21:31 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id g10so11875574plo.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BcAXeIHfkMK9KXq9ftGmJ8WUeCsNRonPesUxZB6zPLw=;
        b=q1os7l5fQQrL4oJv26hp6jcpO+N+CbETyzz+5akCRldnOkaXXxnRteRq1IZULQwt+c
         1POQqWJC8TkNILQ+n26MFX6SxRuFgfvpxSiQifOLk5hat+lJUjaIvLOofjEoU0Hob/zq
         ExRGFvbT+wJsST7Nv0eW4crBzmwgY/HryE3OrHf2zSnK1rnxN+bVh3LwKTlHrQrgmZDB
         QNqMalMf/ZgJuFA+GsjPm9gt1FIyaucdAjOQWYZFJBhjk/eqECnDBd/8cOpJqMbO93LY
         OOoGMo1qn1ElRhYh1yCVSY6SX8roC9jECzwGpvIeao6C3Eu2pBXJa4B9ILW+s5z9NWBd
         r18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcAXeIHfkMK9KXq9ftGmJ8WUeCsNRonPesUxZB6zPLw=;
        b=1nQCYKGHNGl2jXK8zA20/9GkIwvlu0WdpkiAqc6au/U9PqDgUL8o9PZDv5Sa6KgUp9
         jOUUe5xMN4TWgbbFuZjBH4E9j0v6P9F93e+7B/nPeHLd2nIza4ybjVmSLj/s4q/FHw07
         nq3R1VgS9GjtK3vTokKRETopb60rZHayXiXXeSshT2LTQGB9SEc9xT/WhtpLKVe7AeKC
         EzL2hQ+/CW6WS7CXpxSfLhyuKC7zmMqgJZIcJPbIibSqXazptouG9iwgJThpwDg4Mkyr
         L3UDqD55gymwWz9uBS03HNnBhkPxoBVmN+Q2PJKzqn418QzPxljdblhqUJc32xvwivRx
         1QFw==
X-Gm-Message-State: ANoB5pmcey4w8ZqBb2eeig2pVu1+QrHCJWlMWo2rCVD9fvgQyQ/pMKni
        GH7+tTxyjyUvurWp+4BMnwE=
X-Google-Smtp-Source: AA0mqf7kyIG8mVVfnKhyWnMxqTyfdu0OUZOEIX6skITpEGLG5oR1+P2LXCbqtxizE7PqzGQSKC32cA==
X-Received: by 2002:a17:902:8688:b0:189:89e0:4077 with SMTP id g8-20020a170902868800b0018989e04077mr16291429plo.55.1670847690686;
        Mon, 12 Dec 2022 04:21:30 -0800 (PST)
Received: from mi-ThinkStation-K ([43.224.245.228])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902714b00b001895b2d48a1sm6199469plm.253.2022.12.12.04.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:21:30 -0800 (PST)
Date:   Mon, 12 Dec 2022 20:21:09 +0800
From:   zhoudan <zhuqiandann@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, zhoudan8@xiaomi.com
Subject: Re: [PATCH] f2fs: don't set FI_COMPRESS_RELEASED if file is not
 compressed
Message-ID: <20221212122109.GA714122@mi-ThinkStation-K>
References: <20221208050808.2448146-1-zhoudan8@xiaomi.com>
 <Y5OYYJYx9G2LbRmc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5OYYJYx9G2LbRmc@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe I'm not describing it clearly enough, but I think there is 
something wrong with the logic here.The 'f2fs_release_compress_blocks'
method does not determine if the file is compressed, but simply adds 
the FI_COMPRESS_RELEASED flag. 
In particular, in the current Android system, when the application is 
installed, the release interface is called by default to release the 
storage marked as compressed,  without checking whether the file is 
actually compressed. In this case, when compress_mode is set to user, 
calling the compress interface returns ENVAL and the file cannot be 
compressed.
So I think the implementation of release needs to be modified, and 
only set FI_COMPRESS_RELEASED when it's really compressed and the 
storage is released.

On Fri, Dec 09, 2022 at 12:19:44PM -0800, Jaegeuk Kim wrote:
> On 12/08, zhoudan8 wrote:
> > In compress_mode=user, f2fs_release_compress_blocks()
> >  does not verify whether it has been compressed and
> >  sets FI_COMPRESS_RELEASED directly. which will lead to
> > return -EINVAL after calling compress.
> > To fix it,let's do not set FI_COMPRESS_RELEASED if file
> > is not compressed.
> 
> Do you mean you want to avoid EINVAL on a file having FI_COMPRESS_RELEASED
> with zero i_compr_blokcs?
> 
> I think the current logic is giving the error on a released file already.
> 
> > 
> > Signed-off-by: zhoudan8 <zhoudan8@xiaomi.com>
> > ---
> >  fs/f2fs/file.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 82cda1258227..f32910077df6 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -3451,14 +3451,13 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
> >  	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
> >  	if (ret)
> >  		goto out;
> > -
> > -	set_inode_flag(inode, FI_COMPRESS_RELEASED);
> >  	inode->i_ctime = current_time(inode);
> >  	f2fs_mark_inode_dirty_sync(inode, true);
> >  
> >  	if (!atomic_read(&F2FS_I(inode)->i_compr_blocks))
> >  		goto out;
> >  
> > +	set_inode_flag(inode, FI_COMPRESS_RELEASED);
> >  	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >  	filemap_invalidate_lock(inode->i_mapping);
> >  
> > -- 
> > 2.38.1
