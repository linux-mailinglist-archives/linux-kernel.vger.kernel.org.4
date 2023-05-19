Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA9E708E87
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 06:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjESEEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 00:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjESEEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 00:04:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D90210CF
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 21:04:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6AB6268AFE; Fri, 19 May 2023 06:04:05 +0200 (CEST)
Date:   Fri, 19 May 2023 06:04:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     Christoph Hellwig <hch@lst.de>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, xen-devel@lists.xenproject.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH 2/4] x86: always initialize xen-swiotlb when
 xen-pcifront is enabling
Message-ID: <20230519040405.GA10818@lst.de>
References: <20230518134253.909623-1-hch@lst.de> <20230518134253.909623-3-hch@lst.de> <ZGZr/xgbUmVqpOpN@mail-itl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZGZr/xgbUmVqpOpN@mail-itl>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 08:18:39PM +0200, Marek Marczykowski-Górecki wrote:
> On Thu, May 18, 2023 at 03:42:51PM +0200, Christoph Hellwig wrote:
> > Remove the dangerous late initialization of xen-swiotlb in
> > pci_xen_swiotlb_init_late and instead just always initialize
> > xen-swiotlb in the boot code if CONFIG_XEN_PCIDEV_FRONTEND is enabled.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Doesn't it mean all the PV guests will basically waste 64MB of RAM
> by default each if they don't really have PCI devices?

If CONFIG_XEN_PCIDEV_FRONTEND is enabled, and the kernel's isn't booted
with swiotlb=noforce, yes.

