Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ED85B401E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiIITrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiIITqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:46:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DE54A11C;
        Fri,  9 Sep 2022 12:42:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F23CB82607;
        Fri,  9 Sep 2022 19:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE4DC433D6;
        Fri,  9 Sep 2022 19:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662752558;
        bh=J4h0e1eeHD+F345cJw7D5vWTYQ3cTiWfm7V+L/GXkrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mPGhEzE0ic9kseOm2K6qxxz0hcm3QgU3PIGTsapTt3Gu6YUZuEMV7JcNfIe+lT+Jj
         giFnL2k3y8frDA1x//9/UPSfAVNfq7/KPteflKfEKeGcNc3uQX/Lefq56eMVmJtJOG
         HXKiGzA4ekzDFUW5102gMIwlvxz2U2UUCr0jD/3ltTpS0Rt+nn88I+o9pM6Sw9tjaB
         58RQ7mjb7/ku5gfAdYxzf2OYfC4ecDPrRyPxkUMTHXGE8YVdq3mRu62R11cta9/Vo8
         JHjg5RHBWSKGFBqcB2qpxkTevxEhwItTGUQ9V6HJ0kNmvQK7RXIWAWt6XFw5oPNrhT
         0Zu4cU4jkz45A==
Date:   Fri, 9 Sep 2022 13:42:34 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Guenter Roeck <linux@roeck-us.net>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-hwmon: Cache-line-align the NVME SMART
 log-buffer
Message-ID: <YxuXKrkVbGBJwxRS@kbusch-mbp.dhcp.thefacebook.com>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
 <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 10:19:15PM +0300, Serge Semin wrote:
> Recent commit 52fde2c07da6 ("nvme: set dma alignment to dword") has caused
> 
> Folks, I've thoroughly studied the whole NVME subsystem looking for
> similar problems. Turned out there is one more place which may cause the
> same issue. It's connected with the opal_dev.{cmd,req} buffers passed to
> the nvme_sec_submit() method. The rest of the buffers involved in the NVME
> DMA are either allocated by kmalloc (must be cache-line-aligned by design)
> or bounced-buffered if allocated on the stack (see the blk_rq_map_kern()
> method implementation).

What about user space addresses? We can map those with cacheline offsets.

> ---
>  drivers/nvme/host/hwmon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> index 0a586d712920..94192ab7a02d 100644
> --- a/drivers/nvme/host/hwmon.c
> +++ b/drivers/nvme/host/hwmon.c
> @@ -10,9 +10,10 @@
>  
>  #include "nvme.h"
>  
> +/* DMA-noncoherent platforms require the cache-aligned buffers */
>  struct nvme_hwmon_data {
> +	struct nvme_smart_log log ____cacheline_aligned;
>  	struct nvme_ctrl *ctrl;
> -	struct nvme_smart_log log;

So this by chance happened to work before 52fde2c07da6 because the field
started at a 4-byte offset on your arch?

The change looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
