Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF726CC180
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjC1N4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjC1N4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:56:11 -0400
X-Greylist: delayed 344 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Mar 2023 06:56:07 PDT
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73071AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:56:07 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 83BF0163CEC;
        Tue, 28 Mar 2023 15:50:18 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1680011419; bh=g0tcLRO9G5v06N0p/X+8+aWeQpvDq7kJq1+slNUVrtk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KgwSeHuEMi+ns7hZ/VrSTdeDWlz/M/VkzamNDw3v34BtEu9AMm17fh2AaOFBl22Tj
         V9W9kmXW6maLR+BCbO9IAvVUMQEVyR4Sj3YF8ZXluZSNTWSGRMf6uM6x7rJaYwdA6h
         x1E0R188zE+U9U0R67dWW9nLdkR8a6j/rvWEH7ZVAgYGmkvIM9PKY5q+RFwulQpR3E
         nrkp+eCa/dFJrgFplgWY2ZVlniZM77UNUb/yjUl+30qyl2k4H0MqoPSf5uDdXTsh7Y
         +cx+XLlkrcF7rjbcg0nYEFkQ569kpwpnSn2QDnaadki1p+YZZzBL89ZmoB2pEnI2xI
         o+Bu+kgypdhLQ==
Date:   Tue, 28 Mar 2023 15:50:17 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Christoph Hellwig <hch@infradead.org>, "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Message-ID: <20230328155017.5636393b@meshulam.tesarici.cz>
In-Reply-To: <BYAPR21MB1688852ED49499249368D939D7889@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1679766790-24629-1-git-send-email-mikelley@microsoft.com>
        <ZCJEAx/G0x6zokPF@infradead.org>
        <BYAPR21MB1688852ED49499249368D939D7889@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 13:12:13 +0000
"Michael Kelley (LINUX)" <mikelley@microsoft.com> wrote:

> From: Christoph Hellwig <hch@infradead.org> Sent: Monday, March 27, 2023 6:34 PM
> > 
> > On Sat, Mar 25, 2023 at 10:53:10AM -0700, Michael Kelley wrote:  
> > > @@ -659,6 +663,14 @@ static int swiotlb_do_find_slots(struct device *dev, int  
> > area_index,  
> > >  	area->index = wrap_area_index(mem, index + nslots);
> > >  	area->used += nslots;
> > >  	spin_unlock_irqrestore(&area->lock, flags);
> > > +
> > > +	new_used = atomic_long_add_return(nslots, &total_used);
> > > +	old_hiwater = atomic_long_read(&used_hiwater);
> > > +	do {
> > > +		if (new_used <= old_hiwater)
> > > +			break;
> > > +	} while (!atomic_long_try_cmpxchg(&used_hiwater, &old_hiwater, new_used));
> > > +
> > >  	return slot_index;  
> > 
> > Hmm, so we're right in the swiotlb hot path here and add two new global
> > atomics?  
> 
> It's only one global atomic, except when the high water mark needs to be
> bumped.  That results in an initial transient of doing the second global
> atomic, but then it won't be done unless there's a spike in usage or the
> high water mark is manually reset to zero.  Of course, there's a similar
> global atomic subtract when the slots are released.
> 
> Perhaps this accounting should go under #ifdef CONFIG_DEBUGFS?  Or
> even add a swiotlb-specific debugfs config option to cover all the swiotlb
> debugfs code.  From Petr Tesarik's earlier comments, it sounds like there
> is interest in additional accounting, such as for fragmentation.

For my purposes, it does not have to be 100% accurate. I don't really
mind if it is off by a few slots because of a race window, so we could
(for instance):

- update a local variable and set the atomic after the loop,
- or make it a per-cpu to reduce CPU cache bouncing,
- or just about anything that is less heavy-weight than an atomic
  CMPXCHG in the inner loop of a slot search.

Just my two cents,
Petr T
