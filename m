Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0388D696C26
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjBNSAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjBNSAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:00:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC20A29E3C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:00:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87626B81E96
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 18:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35607C433EF;
        Tue, 14 Feb 2023 18:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676397635;
        bh=QWPRQNPeqPQ0ymGdZhWgjRi5SgQBcrZ8Gc6k7uRPv10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oZLjwQIYKz544VwAUoZ8wzr7Wia6sqdKJdaY3kbVrkw8NEkwTaYhV8OpRGOZVy9SU
         rpiqmhbhNgSNSQ2kNiH7ODH16gtyxthYb+mOal4DGV8KtMkX2W9EjxQPef2NZmqRbX
         85K4qou1bFDsj4Gwv83no2FsCv1r65smy8CjeBM3e8fxZCUaZHEJ6JMahS3DGlZ8Ek
         mNL3XSQDuUHjbyu0JLT0i5+3AzDrLpX+Zxvx2icVoOYTokNixfvpjcQi7uij9XryWL
         eCwH0Xfs6/3KKNTeJM55syPPefAGikJM8rBBa2ibgfdycpNt0cDiKW2OKeWNvyjr79
         lDP+SVG4fV6xw==
Date:   Tue, 14 Feb 2023 10:00:33 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix wrong segment count
Message-ID: <Y+vMQURYclERhJmK@google.com>
References: <20230210213250.3471246-1-jaegeuk@kernel.org>
 <1a66e32b-efc0-626b-b585-7f2bfac506a7@kernel.org>
 <Y+p311Vi/odYKuC2@google.com>
 <a7ccac95-384c-f4de-a60f-ee6b8680c9d7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7ccac95-384c-f4de-a60f-ee6b8680c9d7@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14, Chao Yu wrote:
> On 2023/2/14 1:48, Jaegeuk Kim wrote:
> > On 02/13, Chao Yu wrote:
> > > On 2023/2/11 5:32, Jaegeuk Kim wrote:
> > > > MAIN_SEGS is for data area, while TOTAL_SEGS includes data and metadata.
> > > 
> > > Good catch!
> > > 
> > > Could you please add fixes line?
> > 
> > It seems this is not a bug case, and exisits from the first F2FS patch. :)
> 
> Alright, anyway, it looks good to me.
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

I assumed this for v2. Let me know if you have other concern.

> 
> Thanks,
> 
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > ---
> > > >    fs/f2fs/segment.h | 4 ++--
> > > >    1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > > > index 8ee5e5db9287..6003fbaf4b7d 100644
> > > > --- a/fs/f2fs/segment.h
> > > > +++ b/fs/f2fs/segment.h
> > > > @@ -720,7 +720,7 @@ static inline unsigned char curseg_alloc_type(struct f2fs_sb_info *sbi,
> > > >    static inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
> > > >    {
> > > > -	f2fs_bug_on(sbi, segno > TOTAL_SEGS(sbi) - 1);
> > > > +	f2fs_bug_on(sbi, segno > MAIN_SEGS(sbi) - 1);
> > > >    }
> > > >    static inline void verify_fio_blkaddr(struct f2fs_io_info *fio)
> > > > @@ -775,7 +775,7 @@ static inline int check_block_count(struct f2fs_sb_info *sbi,
> > > >    	/* check segment usage, and check boundary of a given segment number */
> > > >    	if (unlikely(GET_SIT_VBLOCKS(raw_sit) > usable_blks_per_seg
> > > > -					|| segno > TOTAL_SEGS(sbi) - 1)) {
> > > > +					|| segno > MAIN_SEGS(sbi) - 1)) {
> > > >    		f2fs_err(sbi, "Wrong valid blocks %d or segno %u",
> > > >    			 GET_SIT_VBLOCKS(raw_sit), segno);
> > > >    		set_sbi_flag(sbi, SBI_NEED_FSCK);
