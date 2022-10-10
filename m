Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7092A5F9AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 10:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiJJIUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 04:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiJJIUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 04:20:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D015A2C3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 01:20:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2F66168AA6; Mon, 10 Oct 2022 10:20:44 +0200 (CEST)
Date:   Mon, 10 Oct 2022 10:20:44 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Xander Li <Xander_Li@kingston.com.tw>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "christian@brauner.io" <christian@brauner.io>,
        "jeff_yang@kingston.corp-partner.google.com" 
        <jeff_yang@kingston.corp-partner.google.com>,
        "dora_chueh@kingston.corp-partner.google.com" 
        <dora_chueh@kingston.corp-partner.google.com>,
        "james_liu@kingston.corp-partner.google.com" 
        <james_liu@kingston.corp-partner.google.com>,
        Vincent Wu <Vincent_Wu@kingston.com.tw>
Subject: Re: [patch] nvme-pci: disable Write_Zeroes on Kingston SSD
Message-ID: <20221010082044.GA23747@lst.de>
References: <CO1PR10MB4691DEAA88F86F001ACA5A1CCB5D9@CO1PR10MB4691.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR10MB4691DEAA88F86F001ACA5A1CCB5D9@CO1PR10MB4691.namprd10.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 10:01:11AM +0000, Xander Li wrote:
> 
> drivers/nvme/host/pci.c | 10 ++++++++++
> 
> 1 file changed, 10 insertions(+)
> 
> 
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> 
> index 98864b853eef..d08c8c854f3a 100644
> 
> --- a/drivers/nvme/host/pci.c
> 
> +++ b/drivers/nvme/host/pci.c

This patch seems very white space damaged.

> 
> @@ -3503,6 +3503,16 @@ static const struct pci_device_id nvme_id_table[] = {
> 
>                 .driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
> 
>         { PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
> 
>                 .driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
> 
> +       { PCI_DEVICE(0x2646, 0x5018),   /* KINGSTON OM8SFP4xxxxP OS21012 NVMe SSD */
> 
> +               .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> 
> +       { PCI_DEVICE(0x2646, 0x5016),   /* KINGSTON OM3PGP4xxxxP OS21011 NVMe SSD */
> 
> +               .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> 
> +       { PCI_DEVICE(0x2646, 0x501A),   /* KINGSTON OM8PGP4xxxxP OS21005 NVMe SSD */
> 
> +               .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> 
> +       { PCI_DEVICE(0x2646, 0x501B),   /* KINGSTON OM8PGP4xxxxQ OS21005 NVMe SSD */
> 
> +               .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> 
> +       { PCI_DEVICE(0x2646, 0x501E),   /* KINGSTON OM3PGP4xxxxQ OS21011 NVMe SSD */
> 
> +               .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> 
>         { PCI_DEVICE(0x1e4B, 0x1001),   /* MAXIO MAP1001 */
> 
>                 .driver_data = NVME_QUIRK_BOGUS_NID, },
> 
>         { PCI_DEVICE(0x1e4B, 0x1002),   /* MAXIO MAP1002 */
> 
> --
> 
> 2.25.1
> 
> 
> 
> 
> 
> 
> Xander Li
> Technical Resources Group
> Kingston Technology Far East Corp.
> Office Line:  +886-3-5641539 Ext.6135
> E-mail:  xander_li@kingston.com.tw<mailto:xander_li@kingston.com.tw>
> 
> This email and attachment(s) may contain material that is confidential, privileged and/or attorney work product for the sole use of the intended recipient. Any review, reliance or distribution by others or forwarding without express permission is strictly prohibited. If you are not the intended recipient, please contact the sender and delete all copies.
---end quoted text---
