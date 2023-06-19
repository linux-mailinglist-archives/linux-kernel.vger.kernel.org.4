Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5960734A70
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 05:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjFSDDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 23:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFSDCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 23:02:50 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2E9A1BD;
        Sun, 18 Jun 2023 20:02:49 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id BF25592009C; Mon, 19 Jun 2023 05:02:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B0C1092009B;
        Mon, 19 Jun 2023 04:02:48 +0100 (BST)
Date:   Mon, 19 Jun 2023 04:02:48 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Sui Jingfeng <15330273260@189.cn>
cc:     Bjorn Helgaas <bhelgaas@google.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        linux-fbdev@vger.kernel.org, Sui Jingfeng <suijingfeng@loongson.cn>
Subject: Re: [PATCH v7 2/8] PCI/VGA: Deal only with VGA class devices
In-Reply-To: <20230613030151.216625-3-15330273260@189.cn>
Message-ID: <alpine.DEB.2.21.2306190339590.14084@angie.orcam.me.uk>
References: <20230613030151.216625-1-15330273260@189.cn> <20230613030151.216625-3-15330273260@189.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023, Sui Jingfeng wrote:

> Deal only with the VGA devcie(pdev->class == 0x0300), so replace the

 Typo here: s/devcie/device/.

> pci_get_subsys() function with pci_get_class(). Filter the non-PCI display
> device(pdev->class != 0x0300) out. There no need to process the non-display
> PCI device.

 I've only come across this patch series now.  Without diving into what 
this code actually does I have just one question as a matter of interest.

> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index c1bc6c983932..22a505e877dc 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -1500,7 +1496,9 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	bool notify = false;
>  
> -	vgaarb_dbg(dev, "%s\n", __func__);
> +	/* Only deal with VGA class devices */
> +	if (pdev->class != PCI_CLASS_DISPLAY_VGA << 8)
> +		return 0;

 Hmm, shouldn't this also handle PCI_CLASS_NOT_DEFINED_VGA?  As far as I 
know it is the equivalent of PCI_CLASS_DISPLAY_VGA for PCI <= 2.0 devices 
that were implemented before the idea of PCI device classes has developed 
into its current form.  I may have such a VGA device somewhere.

  Maciej
