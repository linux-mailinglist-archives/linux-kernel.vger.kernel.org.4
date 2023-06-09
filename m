Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353A872A355
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjFITq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFITqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:46:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06D73590
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 12:46:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8486D6207B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 19:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B831CC433EF;
        Fri,  9 Jun 2023 19:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686339984;
        bh=JvHYpswbys1U43XNU3gZS8w1UgfVc1fwneoyXTNvECk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=J78D8Dy1WGHKj+OU1z1AyPk/ILwM0Ky/0tg1+4BmsQVGYRqn4RNHttT3R+k4aZ7jE
         kgbXw3wSFaqQgiTP+C3VCtoXUYD9K07zHs7hYM8DJcWxxssnCXRM4Of8NuDq1DhpeR
         l30RirOHJRX54yqwmIjGKcEOxtgjwaq30xUQWaEZqlgj12UBDJy+FLlBiFNCN3H9f+
         tD5iAFRYcmTKU7Tiz/vaN9L9anrGMkB9ckgoXJ+rreCSbR6j3Nb0ZFACuRnvs7eGu0
         9gaeVILUk0c+/RhstEtifN5mx+AUSsi/8Iu2RXsjAd61fkxkS8sI2qbh2/xfbOE6o4
         f4NdG9LUEQ6Ag==
Date:   Fri, 9 Jun 2023 14:46:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Li Yi <liyi@loongson.cn>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sui Jingfeng <15330273260@189.cn>
Subject: Re: [PATCH v8 6/8] drm/etnaviv: add driver support for the PCI
 devices
Message-ID: <20230609194621.GA1257228@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79e07134-4f89-22dd-5a9c-3c8dfac50bf2@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 02:07:58AM +0800, Sui Jingfeng wrote:
> On 2023/6/10 01:52, Bjorn Helgaas wrote:
> > On Fri, Jun 09, 2023 at 09:37:02AM +0800, Sui Jingfeng wrote:
> > > On 2023/6/9 01:32, Bjorn Helgaas wrote:
> > > > On Wed, Jun 07, 2023 at 06:55:49PM +0800, Sui Jingfeng wrote:
> > > > > From: Sui Jingfeng <suijingfeng@loongson.cn>
> > > > > 
> > > > > This patch adds PCI driver support on top of what we already have. Take
> > > > > the GC1000 in LS7A1000/LS2K1000 as the first instance of the PCI device
> > > > > driver. There is only one GPU core for the GC1000 in the LS7A1000 and
> > > > > LS2K1000. Therefore, component frameworks can be avoided.
> > > > > +	{PCI_VENDOR_ID_LOONGSON, 0x7a15, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
> > > > > +	{PCI_VENDOR_ID_LOONGSON, 0x7a05, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
> > > > PCI_VDEVICE()
> > > This make it impossible to hook device-specific data in the future.
> > > 
> > > But currently there no device specific data associated with the
> > > 0x7a05 and 0x7a15,
> > > 
> > > so it's acceptable for now. Thanks.
> > Haha, ISTR having this conversation before, sorry for repeating it.
> > 
> > Indeed, it's fine as-is.  But PCI_VDEVICE() actually *does* allow for
> > vendor-specific data because it doesn't include the data element,
> > which defaults to zero if you don't specify it.
> > 
> > So for example, drivers/net/ethernet/realtek/r8169_main.c has this:
> > 
> >    { PCI_VDEVICE(REALTEK, 0x8129) },
> >    { PCI_VDEVICE(REALTEK, 0x8136), RTL_CFG_NO_GBIT },
> > 
> > where 0x8129 has no driver_data (it defaults to zero), but 0x8136
> > does.
> 
> PCI_VDEVICE macro end with two zero. (I thought it was three)

No worries, I thought the same thing the first five times I read it :)
