Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DE065BE65
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjACKt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjACKtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:49:24 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF35F20
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1672742942; bh=YSVUc8AUwmy5LJUg0+wk8lgBBJf75FDlmAOX4Fj/1nc=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=N6Ee4eALM3vIoAmLheTPmvIm856Bno9SK+QUEgmM9jR7juMOL5T+8lUcGDx5J+RWE
         OQSPJJZcvDX0J2xHETt0zeItuotT6U3tT8NtUAbLBuBl/I+fW/8aOeYzku9FDK2R2T
         OTldSsz7dp4aXkmbhH16UM1CS5o1wVA2mDF9HGro=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue,  3 Jan 2023 11:49:02 +0100 (CET)
X-EA-Auth: 2KAjtx4HnJXL5wRi5YfPVJGYAfG5azavUVqBYrbEbx5N5TKbpYBBClrVit4FeXmcfKs3v4HfRqYkVRqY06rLeAKf2B2wqvlJ
Date:   Tue, 3 Jan 2023 16:18:57 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH v2] ARM/dma-mapping: use kvcalloc for fallback memory
 allocation need
Message-ID: <Y7QIGfF3GyD5nsP3@qemulion>
References: <Y6HDwOyR23QPssRa@qemulion>
 <Y6wYQNvloBeW1oq4@qemulion>
 <Y7QBKMzuzNQAdKyY@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7QBKMzuzNQAdKyY@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 10:19:20AM +0000, Russell King (Oracle) wrote:
> On Wed, Dec 28, 2022 at 03:49:44PM +0530, Deepak R Varma wrote:
> > On Tue, Dec 20, 2022 at 07:46:32PM +0530, Deepak R Varma wrote:
> > > Current conditional determination of whether to use kzalloc or vzalloc
> > > has known issues such as "indefinite retry" when less than PAGE_SIZE
> > > memory is needed, but is unavailable. This LWN article [1] describes
> > > these issues in greater detail. Use helper function kvcalloc() instead
> > > which is more efficient in terms of performance and security.
> > >
> > >  	[1] https://lwn.net/Articles/711653/
> > >
> > > This patch proposal is based on following Coccinelle warning using the
> > > kvmalloc.cocci semantic patch.
> > > 	arch/arm/mm/dma-mapping.c:858:28-29: WARNING opportunity for kvmalloc
> > >
> > > The semantic patch suggests using kvzalloc() helper function, however,
> > > this patch proposes to use kvcalloc instead. kvcalloc() helper function
> > > uses 2-factor argument form which is better from a security perspective
> > > as described in the following KSPP project commit.
> > >
> > > 	Commit 4e3fd7217105 ("wireguard: ratelimiter: use kvcalloc() instead of kvzalloc()")
> > >
> > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> >
> > Hello,
> > May I please request a review and feedback on this patch proposal?
>
> The DMA API on ARM has been maintained by others recently, so it's no
> longer up to me. Please include Christoph Hellwig <hch@lst.de> when
> sending changes for this. Thanks.

Sure. Actually the get_maintainer.pl scripts still returns yourself as the
maintainer for this driver. Hence the email to you.
I will send a v3 and include the change you asked for. I will keep you in cc if
you don't mind.

Also, let me know if I can help with getting the maintainer list updated for
this core subsystem.

Thank you,
./drv

>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!


