Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5101F68AF2F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 11:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBEKC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 05:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBEKC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 05:02:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158535258
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 02:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675591327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VrDv5M1D/Bnij+vafx4QbbnsdIPEMLEUcsFcsJyS3RE=;
        b=axulsXaG7FLtp7KX3QLbQn0T5AhmzVoHyjhUNavRyOycTRRePMtrNZ+MyzdmcR+dr7aI6e
        b2Kl10QSIdJw9NLUIIqUk7v6ST4jxtdbSp1YTYS+KEDtxN0DYUpKNnCO+8w+lyLKyc/8lI
        QhVVpceRoOh13v4Ox3pa4zWCMJJOCIA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-408-O7MeU-J2P0KoRo_Iv5jo9w-1; Sun, 05 Feb 2023 05:02:06 -0500
X-MC-Unique: O7MeU-J2P0KoRo_Iv5jo9w-1
Received: by mail-wr1-f71.google.com with SMTP id t20-20020adfba54000000b002be0eb97f4fso1126514wrg.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 02:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrDv5M1D/Bnij+vafx4QbbnsdIPEMLEUcsFcsJyS3RE=;
        b=OqAHkwyijJw3gP7xTXZMMZS2V43xR57UO5bK0OAuvK9flBAgeU8HNliBRk77T2Sp5r
         S+U8EFtbe6opP4Se3DZseI+ensHLSikVde8kQ16AiA/KngRpzpT4n0yU28fjToXTJ6oq
         R/jeDmnKJdEgrHdBJsJZ6KVNZ13M2ZrCC9lTm1WC8rt/CyMqb/Y8o0GbQN2c+YEtJNxm
         kmpy6PxWqwP990EYb2HQyuPrzFJ/7JC1sEk9hW0xjnHrqYEzz6vrylVNG/JEQ8iqrBhJ
         IPvo8TGOiTgQAUdU71GC9mPIdNiLb+K/qlFW3XhuI7D/sVKEviPwQdBSWu+4AePOyY+A
         B74A==
X-Gm-Message-State: AO0yUKWL6ViZuZY+sq3ckxnz09eM669QPUHKRkY55TXFAaD2gQkXRPKU
        ykfMBz982n/ZOf8lAAnaw3dO5Nxt3Xj6cfui0Sz8IcHXijA8etlEL9SECrwlkukqcqQ9n+Dsdqt
        m5LPdwkJvscdra3iSOj8MIfbn
X-Received: by 2002:a05:600c:3b91:b0:3dc:545f:e9ce with SMTP id n17-20020a05600c3b9100b003dc545fe9cemr16747397wms.24.1675591324639;
        Sun, 05 Feb 2023 02:02:04 -0800 (PST)
X-Google-Smtp-Source: AK7set8YLVmOZelQcBfOFDQIwXIOlKP8w5Qv0I1NMGLe7/YwB6qM3lW7lMaCyN+hDLgREf6CkLg2yg==
X-Received: by 2002:a05:600c:3b91:b0:3dc:545f:e9ce with SMTP id n17-20020a05600c3b9100b003dc545fe9cemr16747383wms.24.1675591324442;
        Sun, 05 Feb 2023 02:02:04 -0800 (PST)
Received: from redhat.com ([2.52.129.177])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c089400b003dc41a9836esm7523257wmp.43.2023.02.05.02.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 02:02:03 -0800 (PST)
Date:   Sun, 5 Feb 2023 05:01:59 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Wang <jasowang@redhat.com>, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP function
Message-ID: <20230205050122-mutt-send-email-mst@kernel.org>
References: <20230203100418.2981144-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203100418.2981144-1-mie@igel.co.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 07:04:14PM +0900, Shunsuke Mie wrote:
> This patchset introduce a virtio-net EP device function. It provides a
> new option to communiate between PCIe host and endpoint over IP.
> Advantage of this option is that the driver fully uses a PCIe embedded DMA.
> It is used to transport data between virtio ring directly each other. It
> can be expected to better throughput.
> 
> To realize the function, this patchset has few changes and introduces a
> new APIs to PCI EP framework related to virtio. Furthermore, it device
> depends on the some patchtes that is discussing. Those depended patchset
> are following:
> - [PATCH 1/2] dmaengine: dw-edma: Fix to change for continuous transfer
> link: https://lore.kernel.org/dmaengine/20221223022608.550697-1-mie@igel.co.jp/
> - [RFC PATCH 0/3] Deal with alignment restriction on EP side
> link: https://lore.kernel.org/linux-pci/20230113090350.1103494-1-mie@igel.co.jp/
> - [RFC PATCH v2 0/7] Introduce a vringh accessor for IO memory
> link: https://lore.kernel.org/virtualization/20230202090934.549556-1-mie@igel.co.jp/
> 
> About this patchset has 4 patches. The first of two patch is little changes
> to virtio. The third patch add APIs to easily access virtio data structure
> on PCIe Host side memory. The last one introduce a virtio-net EP device
> function. Details are in commit respectively.
> 
> Currently those network devices are testd using ping only. I'll add a
> result of performance evaluation using iperf and etc to the future version
> of this patchset.


All this feels like it'd need a virtio spec extension but I'm not 100%
sure without spending much more time understanding this.
what do you say?

> Shunsuke Mie (4):
>   virtio_pci: add a definition of queue flag in ISR
>   virtio_ring: remove const from vring getter
>   PCI: endpoint: Introduce virtio library for EP functions
>   PCI: endpoint: function: Add EP function driver to provide virtio net
>     device
> 
>  drivers/pci/endpoint/Kconfig                  |   7 +
>  drivers/pci/endpoint/Makefile                 |   1 +
>  drivers/pci/endpoint/functions/Kconfig        |  12 +
>  drivers/pci/endpoint/functions/Makefile       |   1 +
>  .../pci/endpoint/functions/pci-epf-vnet-ep.c  | 343 ++++++++++
>  .../pci/endpoint/functions/pci-epf-vnet-rc.c  | 635 ++++++++++++++++++
>  drivers/pci/endpoint/functions/pci-epf-vnet.c | 387 +++++++++++
>  drivers/pci/endpoint/functions/pci-epf-vnet.h |  62 ++
>  drivers/pci/endpoint/pci-epf-virtio.c         | 113 ++++
>  drivers/virtio/virtio_ring.c                  |   2 +-
>  include/linux/pci-epf-virtio.h                |  25 +
>  include/linux/virtio.h                        |   2 +-
>  include/uapi/linux/virtio_pci.h               |   2 +
>  13 files changed, 1590 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-ep.c
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-rc.c
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.c
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.h
>  create mode 100644 drivers/pci/endpoint/pci-epf-virtio.c
>  create mode 100644 include/linux/pci-epf-virtio.h
> 
> -- 
> 2.25.1

