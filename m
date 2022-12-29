Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF3365901D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiL2SEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiL2SEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:04:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2617A15833
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:04:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BFEAB818F0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 18:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2A9C433D2;
        Thu, 29 Dec 2022 18:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672337077;
        bh=zE2PL61SyVmgZLzrsWmVw2XuVVi926GhweLinTybOLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jp2dXz3ydvsUA8LGHkb7kvEyKuTA7eYSKNmcI3tQAC3dZurUY7magETTNkkPO77aJ
         cMZRBW0ePy0QshrVYxKlyFloUVJiLWdWY29RLmqWsiLa3y+vbJdmK17jjMe88/UbXd
         4IfWVm+GnMp5JRyL/kI3qjUSNBQ+RI5iwfumvAXK4gm2aTpu/OyGmNKbv27BkfHDPe
         ZWjFNjICYyeHXwAoTGSUzGUyHha50E9wUG6Ofx2PJaHw7Kb6zYllRheB31iDMo4gEE
         dQChsry1iUXlLdNQDpsXCbg5E9AlbXLa8SpScYe5cABR/HI7hZLIPxHNEelKeyZjzy
         F0f5IX8yvCWLQ==
Date:   Thu, 29 Dec 2022 11:04:33 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        t.zhang2@samsung.com
Subject: Re: [PATCH] nvme-pci: free irq properly when cannot create adminq
Message-ID: <Y63WsX8Hvxep/dtN@kbusch-mbp.dhcp.thefacebook.com>
References: <20221229060549.3976570-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229060549.3976570-1-ztong0001@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 10:05:49PM -0800, Tong Zhang wrote:
> nvme_pci_configure_admin_queue could return -ENODEV, in this case, we
> will need to free IRQ properly. Otherwise following warning could be
> triggered
> 
> [    5.286752] WARNING: CPU: 0 PID: 33 at kernel/irq/irqdomain.c:253 irq_domain_remove+0x12d/0x140
> [    5.290547] Call Trace:
> [    5.290626]  <TASK>
> [    5.290695]  msi_remove_device_irq_domain+0xc9/0xf0
> [    5.290843]  msi_device_data_release+0x15/0x80
> [    5.290978]  release_nodes+0x58/0x90
> [    5.293788] WARNING: CPU: 0 PID: 33 at kernel/irq/msi.c:276 msi_device_data_release+0x76/0x80
> [    5.297573] Call Trace:
> [    5.297651]  <TASK>
> [    5.297719]  release_nodes+0x58/0x90
> [    5.297831]  devres_release_all+0xef/0x140
> [    5.298339]  device_unbind_cleanup+0x11/0xc0
> [    5.298479]  really_probe+0x296/0x320
> 
> Fixes: a6ee7f19ebfd ("nvme-pci: call nvme_pci_configure_admin_queue from nvme_pci_enable")

Right. It's really only needed when called from probe as the reset_work
handles the cleanup when called from there, but this is safe for both
cases.

> @@ -2584,8 +2584,13 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>  	pci_enable_pcie_error_reporting(pdev);
>  	pci_save_state(pdev);
>  
> -	return nvme_pci_configure_admin_queue(dev);
> +	result = nvme_pci_configure_admin_queue(dev);
> +	if (result)
> +		goto free_irq;
> +	return result;

Since you're already in this function, you should also add a "goto
disable" if pci_alloc_irq_vectors() fails. Right now it just returns
with the pci device still enabled, and it won't get disabled from probe.
  
> + free_irq:
> +	pci_free_irq_vectors(pdev);
>   disable:
>  	pci_disable_device(pdev);
>  	return result;
> -- 
