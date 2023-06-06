Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3006C724C00
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbjFFTBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbjFFTBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:01:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0601495
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:01:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E9FD635B5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 19:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB594C433EF;
        Tue,  6 Jun 2023 19:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686078063;
        bh=8VSP6X5HdznLbwQMYErzABqaXfaxZIW755OS+DXUrX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Jc5KjSXvQdpp345q2PX36NiZZ/vb4vcpz8ysOTPRNM4mjZFJ+oos/O2ps7jrZTvBP
         jSAA9yYobIgs5OmhViLvRkVIjz8izi3zcTYQmRpPjXq0doKpN/v8x+3BsmgyVluN3+
         EQgXHGed04Uqq1hXXJxrtwG4B/Z1i4OoECdfdZJwDePA/m0k6UfKk9BKcv4YhNzO3T
         DTp2/96VG1pKXwRvWVfOzey0hlwagGlcRRCmloZY5/g2HyVZ0cNHQy9VouEHgYhW1H
         nJS+P0Nn89MlC8i/xA73J/6+toJBfuuL8Wgs9ZHartLOISG4nVRblkmQtEjKMSVJaJ
         CnqJT76hZA9YA==
Date:   Tue, 6 Jun 2023 14:01:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Sui Jingfeng <15330273260@189.cn>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 7/7] drm/etnaviv: add support for the dma coherent
 device
Message-ID: <20230606190102.GA1134540@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <234586a0-995c-b4c4-3b7b-35afeea1a797@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 02:43:27AM +0800, Sui Jingfeng wrote:
> On 2023/6/7 00:56, Bjorn Helgaas wrote:
> > On Sat, Jun 03, 2023 at 06:59:43PM +0800, Sui Jingfeng wrote:
> > > From: Sui Jingfeng <suijingfeng@loongson.cn>
> > > 
> > > Loongson CPUs maintain cache coherency by hardware, which means that the
> > > data in the CPU cache is identical to the data in main system memory. As
> > > for the peripheral device, most of Loongson chips chose to define the
> > > peripherals as DMA coherent by default, device drivers do not need to
> > > maintain the coherency between a processor and an I/O device manually.
> > ...

> > I guess the only way to discover this coherency attribute is via the
> > DT "vivante,gc" property?  Seems a little weird but I'm really not a
> > DT person.
> 
> I'm not sure it is *only*, but it is very convenient to achieve such a thing
> with DT.

I don't know if this is a property of the PCI device, or a property of
the system as a whole.  I asked because PCI devices should be
self-describing (the Device/Vendor ID should be enough to identify the
correct driver, and the driver should know how to learn anything else
it needs to know about the device from PCI config space) and should
not require extra DT properties. 

But if this is a CPU or system property, you probably have to use a
firmware interface like DT or ACPI.

> > > +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> > > @@ -8,6 +8,7 @@
> > >   #include <linux/delay.h>
> > >   #include <linux/dma-fence.h>
> > >   #include <linux/dma-mapping.h>
> > > +#include <linux/dma-map-ops.h>
> >
> > It looks like this #include might not be needed?
> 
> No, the dev_is_dma_coherent() function is declared and defined in
> dma-map-ops.h.  if remove it, gcc will complain:
> 
> drivers/gpu/drm/etnaviv/etnaviv_drv.c: In function
> ‘etnaviv_is_dma_coherent’:
> drivers/gpu/drm/etnaviv/etnaviv_drv.c:56:14: error: implicit declaration of
> function ‘dev_is_dma_coherent’; did you mean ‘etnaviv_is_dma_coherent’?
> [-Werror=implicit-function-declaration]
>    56 |   coherent = dev_is_dma_coherent(dev);
>       |              ^~~~~~~~~~~~~~~~~~~

Of course, but that warning is for etnaviv_drv.c, not for
etnaviv_gpu.c.  So etnaviv_drv.c needs to include dma-map-ops.h, but I
don't think etnaviv_gpu.c does.  I removed this #include from
etnaviv_gpu.c and it still built without errors.

> > You're only adding a
> > new reference to priv->dma_coherent, which looks like it was added to
> > etnaviv_drv.h.
