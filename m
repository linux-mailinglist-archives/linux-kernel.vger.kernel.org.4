Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD6A679E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjAXP4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjAXP4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:56:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C4448618
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:56:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AF9FB812A1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95830C433D2;
        Tue, 24 Jan 2023 15:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674575794;
        bh=QFLsB9JzqKvY6nPNDIwdmPSNhyi2EdnFP1HCsqJz3cA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LpRCFrDSqI5jNzzJ0XZ2qQigyajvL3okiqw1XRGNem00t+6zi4LleNjCjB8rkSk97
         R9L+tm4cCLY1U4MENsk88mSr0yNXXiFdKmgXroHwLh8ObasYdLQl3E4s/t7MB58M37
         6+TI8ZzMQ4QqGBT7zMlC6IFGCgzhKjLir2ViLI7N9xqteppht2xwmbZGhc+BpuZjhZ
         L5XUWNBFaIcG3Ig40pCj8PJeGrRHNB3nOqF9mH0jw6KmCzS9h4/praNOEEndhz/gKE
         GpPy1I7+Y6c7+3T0r3pSdAF9Z8SCtDMaQJysTEIreK6xgKQOHcRu4L0i9AmhlY85MC
         R8+MhNOXjkJlQ==
Date:   Tue, 24 Jan 2023 08:56:30 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] nvme-pci: Switch back to sync probe to fix rootfs mount
 regression
Message-ID: <Y8//roUT5byp59UP@kbusch-mbp.dhcp.thefacebook.com>
References: <20230124004542.29659-1-ville.syrjala@linux.intel.com>
 <20230124062140.GA29175@lst.de>
 <Y8+bP2Oqy3B2XyuJ@intel.com>
 <20230124134134.GC25796@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230124134134.GC25796@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:41:34PM +0100, Christoph Hellwig wrote:
> On Tue, Jan 24, 2023 at 10:47:59AM +0200, Ville Syrjälä wrote:
> > On Tue, Jan 24, 2023 at 07:21:40AM +0100, Christoph Hellwig wrote:
> > > Err, no.  We're not going to randomly revert things.  If you want
> > > to be productive check the one liner Keith reported in reply to the
> > > last report.
> > 
> > No idea what that previous report is. Care to share a link?
> 
> https://lore.kernel.org/linux-nvme/849c43bc-7488-72a6-f6fc-8700639b0c79@leemhuis.info/T/#m759092f541ea29fcb41911890307e70868636a45
> 
> Patch to test:
> 
> https://lore.kernel.org/linux-nvme/849c43bc-7488-72a6-f6fc-8700639b0c79@leemhuis.info/T/#md13c22b29cd81bd0ce9167c271c582005ba30550

I'll post the official patch if someone can let me know if it's
successful. Or I can potentially setup a VM to verify myself, but I
probably won't be able to get to that till next week.
