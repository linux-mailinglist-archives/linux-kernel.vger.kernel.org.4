Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A2F67FE75
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 12:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjA2LSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 06:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjA2LSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 06:18:47 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7A81E9CE
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 03:18:44 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id r18so5830387pgr.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 03:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=omrJDSj6uak8lt7vSvDidr6zPPBb1t+NRol4udkHRtM=;
        b=EyaWTcCn7Bsl/JXXTDTZjAdnoGEfWi3WfaZm+IoPJG4o0AqOPrBFPXNSCDbc5SJsq/
         xy8Iuf5Z0eUFmNkuBrJDWxwQdUvVoTnTVp3qhM1ECcFv3AChBXa4wfVlUOtwofY2ULTH
         0PEuzaNw6OtswmD07pCeacFQGL4ecVKTbwLIa4WmpnPVwX8Nn/2x4/jhcMHwdiVCYXtN
         rMwjwJgdTCm99q1AyU/pXVX++bWznugJXUj3JEVWaWbxV+DOgfRMc1nyT5ujpOTiCXjU
         Ivn40iydNry3dh60D2sBFOkS6ibFJIIOZ226R3mXkfSq9jsnaVnNvMnmBJay1DxgMgpz
         +hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omrJDSj6uak8lt7vSvDidr6zPPBb1t+NRol4udkHRtM=;
        b=EXUviYpVzqXcfS7cPv/Pnz9cPaGdK6zZUSRXuFiBJOpoCASKerdBqq9miesl/IHY44
         fBqK9qBUXFdIIXAHCw4E8yW5z8aHWuuWMDOOUplL/agboV/bELzCvqUycsjnQrlzkRK3
         h8xnA2Dv38afREEYMVHSuKbJhr7tZAXpqCYY4V4/I7s64iBQa5QalhnmMQHHpY2N522r
         ao2AMpwRInpeRhehwXkOp8+w0+G2BXKQ86iaAnFdA7idzx0LBl8KnyXyzA6SEUJmt3K4
         T9XZFRurpKEwv1A16LL7RKAsVc4UQZGGMEQgXwoqKYesh+HI+tPnQ2qYYuuLinRN/B+3
         Fl6Q==
X-Gm-Message-State: AO0yUKVjYoL3TUXE3/IYdeATljPPBXihaRE+ZROMWEG6J5MrhEKYL4RO
        MqnAN5pCtCigxjYiN/5xfFU=
X-Google-Smtp-Source: AK7set/z5jQFRQ4/hl+IlZ5xoVlXoweg5f07KqC/6rMEs7Uc5huhG0o2hdeSkM6GHB4Lq7WVgbgysw==
X-Received: by 2002:a05:6a00:1949:b0:593:954e:1b09 with SMTP id s9-20020a056a00194900b00593954e1b09mr5327761pfk.8.1674991123815;
        Sun, 29 Jan 2023 03:18:43 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT ([43.224.245.237])
        by smtp.gmail.com with ESMTPSA id y17-20020a626411000000b0058bbdaaa5e4sm5464492pfb.162.2023.01.29.03.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 03:18:43 -0800 (PST)
Date:   Sun, 29 Jan 2023 19:18:37 +0800
From:   qixiaoyu <qxy65535@gmail.com>
To:     Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     xiongping1@xiaomi.com, qixiaoyu1@xiaomi.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/2 v2] f2fs: fix wrong calculation of block age
Message-ID: <Y9ZWDVV3HJ431Fis@mi-HP-ProDesk-680-G4-MT>
References: <20230113125859.15651-1-qixiaoyu1@xiaomi.com>
 <20230116030850.20260-1-qixiaoyu1@xiaomi.com>
 <7c12ebaa-4d3d-e475-dfb2-7b459cd26e64@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c12ebaa-4d3d-e475-dfb2-7b459cd26e64@kernel.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 11:35:34AM +0800, Chao Yu wrote:
> On 2023/1/16 11:08, qixiaoyu1 wrote:
> > Currently we wrongly calculate the new block age to
> > old * LAST_AGE_WEIGHT / 100.
> > 
> > Fix it to new * (100 - LAST_AGE_WEIGHT) / 100
> >                  + old * LAST_AGE_WEIGHT / 100.
> > 
> > Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
> > Signed-off-by: xiongping1 <xiongping1@xiaomi.com>
> > ---
> > Change log v1 -> v2:
> >   - fix udiv
> > 
> >   fs/f2fs/extent_cache.c | 7 ++-----
> >   1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> > index 342af24b2f8c..ad5533f178fd 100644
> > --- a/fs/f2fs/extent_cache.c
> > +++ b/fs/f2fs/extent_cache.c
> > @@ -874,11 +874,8 @@ void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
> >   static unsigned long long __calculate_block_age(unsigned long long new,
> >   						unsigned long long old)
> >   {
> > -	unsigned long long diff;
> > -
> > -	diff = (new >= old) ? new - (new - old) : new + (old - new);
> > -
> > -	return div_u64(diff * LAST_AGE_WEIGHT, 100);
> > +	return div_u64(new, 100) * (100 - LAST_AGE_WEIGHT)
> > +		+ div_u64(old, 100) * LAST_AGE_WEIGHT;
> 
> How about updating as below to avoid lossing accuracy if new is less than 100?
> 
> return div_u64(new * (100 - LAST_AGE_WEIGHT), 100) +
> 		div_u64(old * LAST_AGE_WEIGHT, 100);
> 
> Thanks,
> 

We want to avoid overflow by doing the division first. To keep the accuracy, how
about updating as below:

	res = div_u64_rem(new, 100, &rem_new) * (100 - LAST_AGE_WEIGHT)
		+ div_u64_rem(old, 100, &rem_old) * LAST_AGE_WEIGHT;
	res += rem_new * (100 - LAST_AGE_WEIGHT) / 100 + rem_old * LAST_AGE_WEIGHT / 100;
	return res;

Thanks,

> >   }
> >   /* This returns a new age and allocated blocks in ei */
