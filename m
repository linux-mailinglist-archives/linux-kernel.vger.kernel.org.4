Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D8673FB1E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjF0LaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF0LaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:30:12 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8880C10C;
        Tue, 27 Jun 2023 04:30:10 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 0630888EE8;
        Tue, 27 Jun 2023 13:30:06 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1687865407; bh=PMTYuWEHp4RzWxSHWEhXWEo5d5MHLxZfnxLeMEnfGD4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pcG7sqNkBFFgow2Mmh7j1elzlR0/jjXSQNzKLduKGlzVYfZajP/QiJ4lkbDtFwJLi
         pESn5wq4anP0MZET52ZTEyNhiqUsxP6UEtpu4YIthoSaYFSns/v6oXVDnx7k0HKw2V
         fYAaQSUKIxmzf+4SjVZDWmH+40O4FvNXNR2gRt4a7LRHTWA5RAf9DfPWrmi6XJhYTD
         rriJpAd+AMIr+QRiWzJl6V91faWGK5BevB3Xt+t2O00J/1rFoj0fHl+yvxQGUd1PD2
         VqpnCoIh+9t2srRILgq8MxkRXkjjqcpIMUU0TxphHFBmcdXdM+KPz3HUteGJKKi+tI
         tEwiLAN1YW+8Q==
Date:   Tue, 27 Jun 2023 13:30:06 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Saravana Kannan <saravanak@google.com>,
        "moderated list:XEN HYPERVISOR ARM" <xen-devel@lists.xenproject.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:XEN SWIOTLB SUBSYSTEM" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v3 1/7] swiotlb: make io_tlb_default_mem local to
 swiotlb.c
Message-ID: <20230627133006.16ee11af@meshulam.tesarici.cz>
In-Reply-To: <73f11258-1562-17c1-969e-b134dcb5f35c@arm.com>
References: <cover.1687859323.git.petr.tesarik.ext@huawei.com>
        <a1ef6eeab8b64fac817b9734da4a056f05a68d01.1687859323.git.petr.tesarik.ext@huawei.com>
        <2023062745-routing-palace-d0b4@gregkh>
        <73f11258-1562-17c1-969e-b134dcb5f35c@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, originally sent only to Robin. Restoring the recipient list here...

On Tue, 27 Jun 2023 11:55:00 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 27/06/2023 11:24 am, Greg Kroah-Hartman wrote:  
> > On Tue, Jun 27, 2023 at 11:54:23AM +0200, Petr Tesarik wrote:    
> >> +/**
> >> + * is_swiotlb_active() - check if the software IO TLB is initialized
> >> + * @dev:	Device to check, or %NULL for the default IO TLB.
> >> + */
> >>   bool is_swiotlb_active(struct device *dev)
> >>   {
> >> -	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> >> +	struct io_tlb_mem *mem = dev
> >> +		? dev->dma_io_tlb_mem
> >> +		: &io_tlb_default_mem;    
> > 
> > That's impossible to read and maintain over time, sorry.
> > 
> > Please use real "if () else" lines, so that it can be maintained over
> > time.    
> 
> Moreover, it makes for a horrible interface anyway. If there's a need 
> for a non-specific "is SWIOTLB present at all?" check unrelated to any 
> particular device (which arguably still smells of poking into 
> implementation details...), please encapsulate it in its own distinct 
> helper like, say, is_swiotlb_present(void).  

I'm sorry for writing two replies, but I realized too late that this
part is unrelated to the MIPS Octeon platform.

Xen is the only user of an "is SWIOTLB present" interface. IIUC Xen
needs bounce buffers for the PCI frontend driver, but if there is no
other reason to have a SWIOTLB, the system does not set up one at boot.

Yeah, they should probably do things differently. At least this code in
arch/x86/kernel/pci-dma.c is fishy:

	/* XXX: this switches the dma ops under live devices! */
	dma_ops = &xen_swiotlb_dma_ops;

However, I don't think it's up to me to fix that...

To sum it up, I can certainly provide a separate function instead of
overloading the is_swiotlb_active() API.

Thanks for the suggestion!

Petr T
