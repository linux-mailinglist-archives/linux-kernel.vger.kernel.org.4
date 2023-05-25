Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EE97105DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 08:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbjEYG64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 02:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjEYG6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 02:58:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5901CE43
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 23:58:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2533d8f4a1eso813904a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 23:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684997917; x=1687589917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76cyFsl2b2nTdh3+cZxDim2urSf6JLnxU9wqhFG5ggU=;
        b=pYqBGlyAqWE90ctUYKEbyJzhJ7DpOZ+1KSSGEhvTCgkchRc9TvJ0aLbi8RAAGWXEQj
         sicDjePVjx8/yyszMCfiG4q/Qr1JltIyUNANz9iz/r2BfUsu5akNUHbpL+/dtwT4Oq1X
         z1k5JftXCm6QUuVlZ8f2t3h3FgbFVQNpij8UwKR9s5PvZlCMwopkacNqi+D9V9ZrQ7cM
         jCyz9Uv+xTBfvmHTUcuQr4CJUSj266x0dStzP5Hk0aJfTU0eybwJSVABte0vnZScIAlo
         VCBj6Au+s28WA6LnqSE+EJlT/IvzAI5g+VK6Pna0mLOKaQCp1U0R3GBc52QmnSM4XDnP
         yknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684997917; x=1687589917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76cyFsl2b2nTdh3+cZxDim2urSf6JLnxU9wqhFG5ggU=;
        b=H62q2btrbkGIDtBkv0PSTNBGEVYgdgmY1U31AssOBqyrElfIh9+1YAL0/bZxluoSqF
         GdgnGIj68/N0nzf422tcJxu2wu3o11/0QYLiAyrH2BF2F+uWlLWmMFHheIb6nzJ6o+za
         yw44wOQuinJGq2u2ub5GAzAT1frDORrJtpnIRXtcRZDBtfClnl1cXhMSZTzx+Fz41lRO
         CGD8nrR5CNR6X6yuHbpfbigS0Aal55ESOBrQq0pK4eXcuH/tRzV1e4NsF0Br5Rf1XyBm
         +uvxbnvFKsIfXXZT6rBEh6LPDRpdsVx7xs5PAaJx9LvBycIQlNyp3Yn3rZSAjG1/u4ft
         8CRQ==
X-Gm-Message-State: AC+VfDxj21tLaKqyXI15fB9Q0x7oYMHQYRqKCzIotNp4Nma9kQrNhSr3
        kGjC98mZZtMCTfy7dpEzT3S3A08I/Hs=
X-Google-Smtp-Source: ACHHUZ4+MJzn5XoqZQWfZ0jYR4AVC6gVamQpUPZWjUIH/tlw6ChugTewBGvgXPckl+CzKGdmQJHAHQ==
X-Received: by 2002:a17:90b:a12:b0:255:e753:dcaf with SMTP id gg18-20020a17090b0a1200b00255e753dcafmr772052pjb.16.1684997916701;
        Wed, 24 May 2023 23:58:36 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090aac0500b0024e2230fdafsm546727pjq.54.2023.05.24.23.58.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 May 2023 23:58:36 -0700 (PDT)
Date:   Thu, 25 May 2023 15:06:37 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        huyue2@coolpad.com, zhangwen@coolpad.com
Subject: Re: [PATCH] erofs: don't calculate new start when expanding read
 length
Message-ID: <20230525150637.00000a55.zbestahu@gmail.com>
In-Reply-To: <c3dbd82a-75c2-969d-02ce-b7a31b29a95e@linux.alibaba.com>
References: <20230525055147.13220-1-zbestahu@gmail.com>
        <c3dbd82a-75c2-969d-02ce-b7a31b29a95e@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 13:56:14 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/5/25 22:51, Yue Hu wrote:
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > We only expand the trailing edge and not the leading edge.  So no need
> > to obtain new start again.  Let's use the existing ->headoffset instead.
> > 
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > ---
> >   fs/erofs/zdata.c | 12 +++++-------
> >   1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > index 874fee35af32..bab8dcb8e848 100644
> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -1828,26 +1828,24 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
> >   {
> >   	struct inode *inode = f->inode;
> >   	struct erofs_map_blocks *map = &f->map;
> > -	erofs_off_t cur, end;
> > +	erofs_off_t cur, end, headoffset = f->headoffset;  
> 
> 
> That is not quite useful, or could you merge this info the original patch?

Okay, i will do the merge later.

> 
> Thanks,
> Gao Xiang
> 
> >   	int err;
> >   
> >   	if (backmost) {
> >   		if (rac)
> > -			end = f->headoffset + readahead_length(rac) - 1;
> > +			end = headoffset + readahead_length(rac) - 1;
> >   		else
> > -			end = f->headoffset + PAGE_SIZE - 1;
> > +			end = headoffset + PAGE_SIZE - 1;
> >   		map->m_la = end;
> >   		err = z_erofs_map_blocks_iter(inode, map,
> >   					      EROFS_GET_BLOCKS_READMORE);
> >   		if (err)
> >   			return;
> >   
> > -		/* expend ra for the trailing edge if readahead */
> > +		/* expand ra for the trailing edge if readahead */
> >   		if (rac) {
> > -			loff_t newstart = readahead_pos(rac);
> > -
> >   			cur = round_up(map->m_la + map->m_llen, PAGE_SIZE);
> > -			readahead_expand(rac, newstart, cur - newstart);
> > +			readahead_expand(rac, headoffset, cur - headoffset);
> >   			return;
> >   		}
> >   		end = round_up(end, PAGE_SIZE);  

