Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6377163E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjE3OX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjE3OXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:23:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB361E41;
        Tue, 30 May 2023 07:23:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8776A62BD5;
        Tue, 30 May 2023 14:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEE8C4339C;
        Tue, 30 May 2023 14:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685456529;
        bh=k700hgbiU2x5v71H9KHKEiPJRC2HKKRUZbC/XC2nTNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RQJ+edKK9vPos0wVd2D7Ef/BPog8efISHA8NkA697qyRU/yLVFgd2aEExM/wYh60/
         /NE53C/NmCt+mdkOF9cmriwPSJRosIvPIjx71tuKUyL29P55idt7KB0g3QN4AJt9Og
         +SHI/K2YqQOROccEoRLwpqGX4qQvhDYZNln4YCqSyvTH5497i6oBYP+jTGSrpKH0ds
         Koow4LSFejvhNTTp2EODkAhGPRfS9TJEpEmI6+hHRmswqM1qhfev+mgJtykdWkjsjb
         0XcqMYiPqembqFubXole0hEQ6rmDWV7IxWSuYyGr7+KRB7I0UUhCjb+goCvM4XYGxj
         Mo/xF6ZkJNF+Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q40El-0007rF-BZ; Tue, 30 May 2023 16:22:11 +0200
Date:   Tue, 30 May 2023 16:22:11 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH 0/2] Bluetooth: fix debugfs registration
Message-ID: <ZHYGkxX-Z6deSgAH@hovoldconsulting.com>
References: <20230424124852.12625-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424124852.12625-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 02:48:50PM +0200, Johan Hovold wrote:
> The HCI controller debugfs interface is created during setup or when a
> controller is configured, but there is nothing preventing a controller
> from being configured multiple times (e.g. by setting the device
> address), which results in a host of errors in the logs:
> 
> 	debugfs: File 'features' in directory 'hci0' already present!
> 	debugfs: File 'manufacturer' in directory 'hci0' already present!
> 	debugfs: File 'hci_version' in directory 'hci0' already present!
> 	...
> 	debugfs: File 'quirk_simultaneous_discovery' in directory 'hci0' already present!
> 
> The Qualcomm driver suffers from a related problem for controllers with
> non-persistent setup.
>
> 
> Johan Hovold (2):
>   Bluetooth: fix debugfs registration
>   Bluetooth: hci_qca: fix debugfs registration
> 
>  drivers/bluetooth/hci_qca.c | 6 +++++-
>  include/net/bluetooth/hci.h | 1 +
>  net/bluetooth/hci_sync.c    | 3 +++
>  3 files changed, 9 insertions(+), 1 deletion(-)

Are there any more comments to this series or can we can get this merged
for 6.5?

I hope this is not blocked on the bogus checkpatch warning the robot
posted?

Johan
