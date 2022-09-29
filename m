Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1705F0192
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 01:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiI2Xxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 19:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiI2Xxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:53:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4111CE621;
        Thu, 29 Sep 2022 16:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA578621F2;
        Thu, 29 Sep 2022 23:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F59C433C1;
        Thu, 29 Sep 2022 23:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664495627;
        bh=zGoeBEsQFYR1XddbT/4DDXBJnqm/WcRswhc2BoBKNsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ei7KWbmfxEJw0h3HBiNrGSOWNuOiEfbtjZ6aLz3C+GQXZYR5ZkazD9oPv0kBuK1n7
         W2jsgUdNNk/ewDV565eh/s05q8gpUQRiWl2sFn+jNlH6ZpebjUsbMNwzXaw/gVQJ2x
         fJ8b96KylIqy1qU1FK18niUAimozIpikL3DDS9cvmlUx0V5FYCtt3bSKEO2We0eTUI
         5PKr/gKxyey9anLVcOyVoSUNBRiZGBnSctC6mG5ABKMJ6Ld6GZQ9UhoZVrjGm7JRh7
         4h6JdMMfrEvifxwtr0+lwDbXMynTptHBnu4QF0xGsHAYBfcwyjFkpbQ1OcMhwQfg/E
         qXYS07xGLV4Gg==
Date:   Thu, 29 Sep 2022 17:53:43 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] nvme-hwmon: Return error on kzalloc failure
Message-ID: <YzYwB7lRGW80r4HA@kbusch-mbp.dhcp.thefacebook.com>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
 <20220929224648.8997-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929224648.8997-2-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 01:46:46AM +0300, Serge Semin wrote:
> Inability to allocate a buffer is a critical error which shouldn't be
> tolerated since most likely the rest of the driver won't work correctly.
> Thus instead of returning the zero status let's return the -ENOMEM error
> if the nvme_hwmon_data structure instance couldn't be created.

Nak for this one. The hwmon is not necessary for the rest of the driver to
function, so having the driver detach from the device seems a bit harsh. The
driver can participate in memory reclaim, so failing on a low memory condition
can make matters worse.

The rest looks good, though.

> @@ -230,7 +230,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
>  
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
> -		return 0;
> +		return -ENOMEM;
>  
>  	data->ctrl = ctrl;
>  	mutex_init(&data->read_lock);
> -- 
