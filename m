Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB8868FFC8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 06:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBIFRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 00:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBIFRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 00:17:50 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E132CC7A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 21:17:49 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E7C8367373; Thu,  9 Feb 2023 06:17:45 +0100 (CET)
Date:   Thu, 9 Feb 2023 06:17:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Irvin Cote <irvin.cote@insa-lyon.fr>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        kch@nvidia.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci : rectifying the nvme_probe teardown path
Message-ID: <20230209051745.GA8420@lst.de>
References: <1517857586.68818728.1675870734911.JavaMail.zimbra@insa-lyon.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517857586.68818728.1675870734911.JavaMail.zimbra@insa-lyon.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 04:38:54PM +0100, Irvin Cote wrote:
> >From ced363dcd3ef076e509bfbb4ce9815ebaff6aee7 Mon Sep 17 00:00:00 2001
> From: Irvin Cote <irvin.cote@insa-lyon.fr>
> Date: Wed, 8 Feb 2023 11:38:39 -0300
> Subject: [PATCH] nvme-pci : rectifying the nvme_probe teardown path
> The nvme_probe teardown path did not account for
> undoing the work of nvme_pci_alloc_dev, which is
> what nvme_pci_free_ctrl seemed to be intended for.
> Thus I displaced the call to nvme_uninit_ctrl
> from nvme_probe to nvme_pci_free_ctrl and added
> a call to the latter in the teardown path of nvme_probe.

Can you explain the problems you are seeing?

> index c734934c407c..db480bc64c7b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2731,6 +2731,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
>  	struct nvme_dev *dev = to_nvme_dev(ctrl);
> 
>  	nvme_free_tagset(dev);
> +	nvme_uninit_ctrl(ctrl);

->free_ctrl is called for the final put of the ctrl, calling
nvme_uninit_ctrl here does not make sense.

> -out_uninit_ctrl:
> -	nvme_uninit_ctrl(&dev->ctrl);
> +out_unalloc_dev:
> +	nvme_pci_free_ctrl(&dev->ctrl);

Also calling nvme_pci_free_ctrl directly and not through the method
table is also wrong.
