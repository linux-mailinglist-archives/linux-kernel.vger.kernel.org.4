Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA82F65BDE7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjACKT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjACKTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:19:25 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F50DE9D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mQ+kH7Y1jP8FPnV3r6fvzT20qbbg9pYdOaXBVU8Mh1s=; b=VfiIGMI2Jwicl5gjt8FuQRhlgB
        FtZPIMyWuAC4dgXlPh3TkJuEvvN+V0RWGejKvr4P5AGwseO7pDjNmN5yiVfQJmZO09UEPWc6ZtPJ+
        ErgjrC0kT2jtz/DG0Vks/zZnVUH861EWUJBfJdRstwFZr+k0ygSCHgv/YuH6/DUIKfQlz7nI2OIUn
        W8XAdWtdq+xUtMMDjYd+hCDMaEkA0vGy1OaFYiqzZAqXV9RTTmf9itr6fU8YLfgaRs9AMrAObCGEp
        AiJUNANy6036vD/1GpQsBMaNjCblNsUReY/aU4OOHe0BBRA+lptViivo2TdYUITBzxOQ3iP8F6OLZ
        2b6s46eA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35912)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pCeOA-0005Cm-J8; Tue, 03 Jan 2023 10:19:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pCeO8-0001yu-W1; Tue, 03 Jan 2023 10:19:21 +0000
Date:   Tue, 3 Jan 2023 10:19:20 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Deepak R Varma <drv@mailo.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v2] ARM/dma-mapping: use kvcalloc for fallback memory
 allocation need
Message-ID: <Y7QBKMzuzNQAdKyY@shell.armlinux.org.uk>
References: <Y6HDwOyR23QPssRa@qemulion>
 <Y6wYQNvloBeW1oq4@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6wYQNvloBeW1oq4@qemulion>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 03:49:44PM +0530, Deepak R Varma wrote:
> On Tue, Dec 20, 2022 at 07:46:32PM +0530, Deepak R Varma wrote:
> > Current conditional determination of whether to use kzalloc or vzalloc
> > has known issues such as "indefinite retry" when less than PAGE_SIZE
> > memory is needed, but is unavailable. This LWN article [1] describes
> > these issues in greater detail. Use helper function kvcalloc() instead
> > which is more efficient in terms of performance and security.
> >
> >  	[1] https://lwn.net/Articles/711653/
> >
> > This patch proposal is based on following Coccinelle warning using the
> > kvmalloc.cocci semantic patch.
> > 	arch/arm/mm/dma-mapping.c:858:28-29: WARNING opportunity for kvmalloc
> >
> > The semantic patch suggests using kvzalloc() helper function, however,
> > this patch proposes to use kvcalloc instead. kvcalloc() helper function
> > uses 2-factor argument form which is better from a security perspective
> > as described in the following KSPP project commit.
> >
> > 	Commit 4e3fd7217105 ("wireguard: ratelimiter: use kvcalloc() instead of kvzalloc()")
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> 
> Hello,
> May I please request a review and feedback on this patch proposal?

The DMA API on ARM has been maintained by others recently, so it's no
longer up to me. Please include Christoph Hellwig <hch@lst.de> when
sending changes for this. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
