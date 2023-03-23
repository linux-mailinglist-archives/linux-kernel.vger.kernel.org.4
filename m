Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDC16C72B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCWWDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCWWDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:03:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E764D13D5B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:03:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64D75628DA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 22:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FFCC433D2;
        Thu, 23 Mar 2023 22:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679609004;
        bh=goJ4V9EA3h8tpdyLAJRYYFW4knwa/WVSAHQH3lMkgl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dM6si4v4OoCcVcoOqAx/sf+oiBJriayq0sO2xzovDAAhA1uieRCpJ+hibfqxQNPit
         DZtNG4r/J+2QxBE1ZIQ4OAjC7j5fhaG4ID3GnLxWx3DR65KEmU0lUFhgfxwDJvbJ2W
         pQrl1k76LI5lcX+vizatOsawtmeOmSRuVzo6Q/hicdheeL0KC8ezRo/Gc7uwMO3yUG
         +Sck6h5dkveSi4cRMIwiFghdXLAYGGdOpKODWyDnRvOObjp55HQOnv4mL+7R05QlDP
         u0tojVrN1a2weuQCrJfgKUVePaBtlbujBovq+/+cNPRKK0A9oSWoLtfHegcVFxrmUB
         J7Uj6scixKeAg==
Date:   Thu, 23 Mar 2023 15:03:22 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     yonggil.song@samsung.com,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] f2fs: Fix discard bug on zoned block devices with
 2MiB zone size
Message-ID: <ZBzMql6DkrUWiRKP@google.com>
References: <CGME20230313094825epcms2p71e6cb549251dc55e8d202dd64b9913a6@epcms2p7>
 <20230313094825epcms2p71e6cb549251dc55e8d202dd64b9913a6@epcms2p7>
 <a24d66ad-4048-fd5c-ae47-2dd17c87bcbe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a24d66ad-4048-fd5c-ae47-2dd17c87bcbe@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23, Chao Yu wrote:
> On 2023/3/13 17:48, Yonggil Song wrote:
> > When using f2fs on a zoned block device with 2MiB zone size, IO errors
> > occurs because f2fs tries to write data to a zone that has not been reset.
> > 
> > The cause is that f2fs tries to discard multiple zones at once. This is
> > caused by a condition in f2fs_clear_prefree_segments that does not check
> > for zoned block devices when setting the discard range. This leads to
> > invalid reset commands and write pointer mismatches.
> > 
> > This patch fixes the zoned block device with 2MiB zone size to reset one
> > zone at a time.
> > 
> > Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
> > ---
> >   fs/f2fs/segment.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index acf3d3fa4363..2b6cb6df623b 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -1953,7 +1953,8 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
> >   					(end - 1) <= cpc->trim_end)
> >   				continue;
> > -		if (!f2fs_lfs_mode(sbi) || !__is_large_section(sbi)) {
> > +		if (!f2fs_sb_has_blkzoned(sbi) &&
> 
> Could you please add one line comment here for this change?

This was merged in -dev a while ago. I don't think this would be critical
to rebase it again.

> 
> Otherwise it looks good to me.
> 
> Thanks,
> 
> > +		    (!f2fs_lfs_mode(sbi) || !__is_large_section(sbi))) {
> >   			f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
> >   				(end - start) << sbi->log_blocks_per_seg);
> >   			continue;
