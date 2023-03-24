Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD6B6C82A9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjCXQyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjCXQyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:54:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E655A9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:54:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7930AB82277
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C9CC433EF;
        Fri, 24 Mar 2023 16:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679676881;
        bh=s26PMR9LnZjCeBo1ZeGJ+j/whi/RZtcTzPjkiJphWmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=euCzy08TjPyv44g0XuHekfA7PUE7xp6aY25yiju00O0x3s+tD067nu2KN14eKX7SF
         ocFWU9Rf0Qwgg2Mk9LjbqUFu9SRvYKlXic7nPajYEwWP4YB99vIMAYneyO8gYILfzG
         YWN3B9J2zKdmTi6JRQZYmbyFiex325ZE7W2GUp32bCuS/fWU2ESmal559j/3cSxPzK
         0fQWHnEsq2TNU1u2C6tjehM46U5au7hl+bCR29AQJSnhROGmF/uRWB3SwrA/ZXLmik
         bN+1cgIkFGKs6VoCtWMTmh2oIkaH5GSjJZ3vKhTul9rsvlZWdf1xR3ohRIaSV8Sht9
         +urIUgkfi4ktQ==
Date:   Fri, 24 Mar 2023 09:54:39 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     yonggil.song@samsung.com,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] f2fs: Fix discard bug on zoned block devices with
 2MiB zone size
Message-ID: <ZB3Vz9w2ybNVSY8C@google.com>
References: <CGME20230313094825epcms2p71e6cb549251dc55e8d202dd64b9913a6@epcms2p7>
 <20230313094825epcms2p71e6cb549251dc55e8d202dd64b9913a6@epcms2p7>
 <a24d66ad-4048-fd5c-ae47-2dd17c87bcbe@kernel.org>
 <ZBzMql6DkrUWiRKP@google.com>
 <35dd1eea-f1b9-418e-5f97-cfd10b7ff803@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35dd1eea-f1b9-418e-5f97-cfd10b7ff803@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/24, Chao Yu wrote:
> On 2023/3/24 6:03, Jaegeuk Kim wrote:
> > On 03/23, Chao Yu wrote:
> > > On 2023/3/13 17:48, Yonggil Song wrote:
> > > > When using f2fs on a zoned block device with 2MiB zone size, IO errors
> > > > occurs because f2fs tries to write data to a zone that has not been reset.
> > > > 
> > > > The cause is that f2fs tries to discard multiple zones at once. This is
> > > > caused by a condition in f2fs_clear_prefree_segments that does not check
> > > > for zoned block devices when setting the discard range. This leads to
> > > > invalid reset commands and write pointer mismatches.
> > > > 
> > > > This patch fixes the zoned block device with 2MiB zone size to reset one
> > > > zone at a time.
> > > > 
> > > > Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
> > > > ---
> > > >    fs/f2fs/segment.c | 3 ++-
> > > >    1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > > index acf3d3fa4363..2b6cb6df623b 100644
> > > > --- a/fs/f2fs/segment.c
> > > > +++ b/fs/f2fs/segment.c
> > > > @@ -1953,7 +1953,8 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
> > > >    					(end - 1) <= cpc->trim_end)
> > > >    				continue;
> > > > -		if (!f2fs_lfs_mode(sbi) || !__is_large_section(sbi)) {
> > > > +		if (!f2fs_sb_has_blkzoned(sbi) &&
> > > 
> > > Could you please add one line comment here for this change?
> > 
> > This was merged in -dev a while ago. I don't think this would be critical
> > to rebase it again.
> 
> Yes, it's not critical, fine to me.

Added:

/* Should cover 2MB zoned device for zone-based reset */

So lucky since I had to rebase to fix other patch. :(

"f2fs: factor out discard_cmd usage from general rb_tree use"


> 
> Thanks,
> 
> > 
> > > 
> > > Otherwise it looks good to me.
> > > 
> > > Thanks,
> > > 
> > > > +		    (!f2fs_lfs_mode(sbi) || !__is_large_section(sbi))) {
> > > >    			f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
> > > >    				(end - start) << sbi->log_blocks_per_seg);
> > > >    			continue;
