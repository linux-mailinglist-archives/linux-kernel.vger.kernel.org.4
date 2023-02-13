Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B794694E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjBMRsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjBMRsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:48:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349CE1F5FE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:48:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD441B81618
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 17:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBC3C433D2;
        Mon, 13 Feb 2023 17:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676310489;
        bh=s+Zu2f5zVc4BKI5uEdJvxc75sJaut41fE2PEiEwMQPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BY2V18kbSV/8VrBUAv8ODCkRkxV4Fbnn0cyNFbdy7AOFu6lXaDCQ70kvOP7R0bW/U
         O2klCsErKlEbR+M7DeYt0R8R5izo3mb1IuHfXmxDNuCRPqaZdy+C/hGHWawQQ5Hgxx
         UTC2Rk8w37iuaxG+Rrzy89lffIx/sT1+YmcNPaYMTNzFj1q4V+dGs9uwyRXI7eh5nb
         uC55xhTsVBPKjYyk8E9ULVyc437Opzh9z+sTnVc4QJm/6Oz+bJtIiKrRKs9MZyCXjr
         sw4JzAS8uVU2RHL+EuwfUb765CPb1kR7wCSTU0nWXM7rDVSlDZPE5bn9xgViwNG70Y
         W9g7jrl4XiGdg==
Date:   Mon, 13 Feb 2023 09:48:07 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix wrong segment count
Message-ID: <Y+p311Vi/odYKuC2@google.com>
References: <20230210213250.3471246-1-jaegeuk@kernel.org>
 <1a66e32b-efc0-626b-b585-7f2bfac506a7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a66e32b-efc0-626b-b585-7f2bfac506a7@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13, Chao Yu wrote:
> On 2023/2/11 5:32, Jaegeuk Kim wrote:
> > MAIN_SEGS is for data area, while TOTAL_SEGS includes data and metadata.
> 
> Good catch!
> 
> Could you please add fixes line?

It seems this is not a bug case, and exisits from the first F2FS patch. :)

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/segment.h | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > index 8ee5e5db9287..6003fbaf4b7d 100644
> > --- a/fs/f2fs/segment.h
> > +++ b/fs/f2fs/segment.h
> > @@ -720,7 +720,7 @@ static inline unsigned char curseg_alloc_type(struct f2fs_sb_info *sbi,
> >   static inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
> >   {
> > -	f2fs_bug_on(sbi, segno > TOTAL_SEGS(sbi) - 1);
> > +	f2fs_bug_on(sbi, segno > MAIN_SEGS(sbi) - 1);
> >   }
> >   static inline void verify_fio_blkaddr(struct f2fs_io_info *fio)
> > @@ -775,7 +775,7 @@ static inline int check_block_count(struct f2fs_sb_info *sbi,
> >   	/* check segment usage, and check boundary of a given segment number */
> >   	if (unlikely(GET_SIT_VBLOCKS(raw_sit) > usable_blks_per_seg
> > -					|| segno > TOTAL_SEGS(sbi) - 1)) {
> > +					|| segno > MAIN_SEGS(sbi) - 1)) {
> >   		f2fs_err(sbi, "Wrong valid blocks %d or segno %u",
> >   			 GET_SIT_VBLOCKS(raw_sit), segno);
> >   		set_sbi_flag(sbi, SBI_NEED_FSCK);
