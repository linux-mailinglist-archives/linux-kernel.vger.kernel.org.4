Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200735FA2B5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJJRXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiJJRXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:23:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADC34E427
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E63860FBD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68665C433D6;
        Mon, 10 Oct 2022 17:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665422574;
        bh=sTmASzYKfJzVNadyE54t+nuZVthL8wB7zBryW4ZrKDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IcariJu3eA4iPPpWNv2HLkgAso3MRgC43VnFbE18E1PVVLa/75R3fys+BoSOdvjb0
         wDH06hl+SEQBKbkgTJ4Hc4JMM9W2aa9TBT+m4bdMXKbgzFelZ9EB97AH5DskcesW81
         Np7GpyzFlxTB/P8OLPDBUUCVyv8zwgwKKYd2C8tmtod6M6nOIfm1MIQ8tgijgpwU0l
         uk7LgkeoT5lVlUZyztdgzHszltAeT68Etss+UeoLJwBAXx9VELHUmiUBpa8PuR2CZO
         dtqpfIDY30Plukh80T7QRBOKBCgQHZhD+CF3t+ZBMpJKROlKAzhOHhCdxQA8SOfrBH
         4RAuUUF+/9OHg==
Date:   Mon, 10 Oct 2022 10:22:52 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix compile warning
Message-ID: <Y0RU7G05vIEhUOYB@google.com>
References: <20221006151428.57561-1-chao@kernel.org>
 <Y0CDoWiaGKHkmnzQ@google.com>
 <6d45ea3a-5a71-b760-b60d-9e3e7dda3be4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d45ea3a-5a71-b760-b60d-9e3e7dda3be4@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08, Chao Yu wrote:
> On 2022/10/8 3:53, Jaegeuk Kim wrote:
> > Merged into the original patch.
> 
> Thanks, so it looks it's not too later to update commit id of original
> patch since it's close to the end of merge window.

I put this in the next pull request.

> 
> Thanks,
> 
> > 
> > On 10/06, Chao Yu wrote:
> > > fs/f2fs/super.c:3886:6: warning: no previous prototype for 'f2fs_record_stop_reason' [-Wmissing-prototypes]
> > > 
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > >   fs/f2fs/super.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > index fad333881ea2..2908d41ed462 100644
> > > --- a/fs/f2fs/super.c
> > > +++ b/fs/f2fs/super.c
> > > @@ -3884,7 +3884,7 @@ static void save_stop_reason(struct f2fs_sb_info *sbi, unsigned char reason)
> > >   	spin_unlock(&sbi->error_lock);
> > >   }
> > > -void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
> > > +static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
> > >   {
> > >   	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
> > >   	int err;
> > > -- 
> > > 2.36.1
