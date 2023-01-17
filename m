Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B74066D5C3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 06:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbjAQF6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 00:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbjAQF6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 00:58:24 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7E0222E5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 21:58:22 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 54EDA67373; Tue, 17 Jan 2023 06:58:19 +0100 (CET)
Date:   Tue, 17 Jan 2023 06:58:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Klaus Jensen <its@irrelevant.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: regression on aarch64? panic on boot
Message-ID: <20230117055819.GB13795@lst.de>
References: <Y8XINx8fpGPKudW6@cormorant.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8XINx8fpGPKudW6@cormorant.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 10:57:11PM +0100, Klaus Jensen wrote:
> Hi,
> 
> I'm getting panics when booting from a QEMU hw/nvme device on an aarch64
> guest in roughly 20% of boots on v6.2-rc4. Example panic below.

This smells like your setup somehow doesn't wait for async driver
probe.  Does the hack below work around it?

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b13baccedb4a95..f47e19c701d520 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3508,7 +3508,6 @@ static struct pci_driver nvme_driver = {
 	.remove		= nvme_remove,
 	.shutdown	= nvme_shutdown,
 	.driver		= {
-		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 #ifdef CONFIG_PM_SLEEP
 		.pm		= &nvme_dev_pm_ops,
 #endif
