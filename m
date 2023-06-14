Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C88D7304A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjFNQMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjFNQMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29D21FFF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72FF060ECD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66E7C433C0;
        Wed, 14 Jun 2023 16:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686759154;
        bh=FEAvt09O6YlhBhsJVN7XSwEaTIxjO3rTJIGM+hEU564=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I+bdARuVnMWdw4t+E5ZTma/ibxUmcJ7ShxJ9VNEwWMqpy/xF5Y6fRnDbxYZLInq3o
         Sz/2uxYawHv0/oz732UW121Q2zelg4oo+9zyScjRiBjosdyV8WL4U6F836U0ImOZH6
         5WnXuKNguk+my7Er9pftjkkNLZccC1VXtybFP2OwgqIXhAnlzGlyjKlCOIvtU9hZHm
         XcchYq7dPA9udSqGe27mHkmCUTz5FmCYwyviG8RnmVrbL+bqsHiWbV9JlNMQTYsm40
         xpVD1mC3yog/JPFHtKdShRyb5xj8LpnlEa2IWDpXWEovId8Q6jX7zIZOXVnjgYqdyX
         5V4rvSjySnTmg==
Date:   Wed, 14 Jun 2023 09:12:33 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daejun Park <daejun7.park@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [f2fs-dev] [PATCH] f2fs: do not issue small discard commands
 during checkpoint
Message-ID: <ZInm8cxDnqnD9QrU@google.com>
References: <20230613203947.2745943-1-jaegeuk@kernel.org>
 <CGME20230613204109epcas2p158ecc100d3fe2db1ab2b7ee8335d01e7@epcms2p4>
 <20230614060757epcms2p4e11a8f8bf2fa44eac99a5bb7f47f8dcd@epcms2p4>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230614060757epcms2p4e11a8f8bf2fa44eac99a5bb7f47f8dcd@epcms2p4>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daejun,

On 06/14, Daejun Park wrote:
> Hi Jaegeuk,
> 
> > If there're huge # of small discards, this will increase checkpoint latency
> > insanely. Let's issue small discards only by trim.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/segment.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 0c0c033c4bdd..ef46bb085385 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -2178,7 +2178,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
> >          }
> >          mutex_unlock(&dirty_i->seglist_lock);
> >  
> > -        if (!f2fs_block_unit_discard(sbi))
> > +        if (!f2fs_block_unit_discard(sbi) || !force)
> 
> If we don't handle the discard entries here, dcc->entry_list will still have them,
> so stale discard entries may be handled by trim, causing incorrect discards to be issued.
> Therefore, I think this patch should also prevent the creation of discard entries
> in add_discard_addrs(), unless it is a checkpoint caused by trim.
> This would further reduce the latency caused by the creation of a discard entry.

I found this causes some objects were not reclaimed when removing the module.
Hence I'm testing v2.

> 
> Thanks,
> Daejun
> 
