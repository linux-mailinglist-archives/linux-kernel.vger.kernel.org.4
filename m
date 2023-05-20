Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF1D70A5A0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 07:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjETFS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 01:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjETFSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 01:18:24 -0400
Received: from out-27.mta0.migadu.com (out-27.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDD11B1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 22:18:22 -0700 (PDT)
Date:   Sat, 20 May 2023 13:18:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684559900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6hm7M8XDbSD+iSGn9J7trDiGr6FdOKQaknC5vC3b+WY=;
        b=lyLDHsGT+JWt1IJfMJoxCQaWaKL5z6w5vmalX2MqStk2J7cHWDYnw7HIr9ZDDbGp7162ep
        OdG8yAaNZLEJuLEer1KlqoWBFlTbBR779v4XfPybKkO6koJ0tuhtPLm21UFPtshFVKSPhI
        5VV9gfWi5Pa4FXWN5etZIxrj+oasLzQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v10 0/4] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <ZGhYGb47hv6Za34/@chq-MS-7D45>
References: <20230517030115.21093-1-cai.huoqing@linux.dev>
 <ZGddCpjX8n1ML21j@matsya>
 <ZGd7/FGJVi6lDk8F@chq-MS-7D45>
 <ZGezgLc63PsqfWBs@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZGezgLc63PsqfWBs@matsya>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 5月 23 23:06:00, Vinod Koul wrote:
> On 19-05-23, 21:39, Cai Huoqing wrote:
> > On 19 5月 23 16:57:06, Vinod Koul wrote:
> > > On 17-05-23, 11:01, Cai Huoqing wrote:
> > > > Add support for HDMA NATIVE, as long the IP design has set
> > > > the compatible register map parameter-HDMA_NATIVE,
> > > > which allows compatibility for native HDMA register configuration.
> > > > 
> > > > The HDMA Hyper-DMA IP is an enhancement of the eDMA embedded-DMA IP.
> > > > And the native HDMA registers are different from eDMA,
> > > > so this patch add support for HDMA NATIVE mode.
> > > > 
> > > > HDMA write and read channels operate independently to maximize
> > > > the performance of the HDMA read and write data transfer over
> > > > the link When you configure the HDMA with multiple read channels,
> > > > then it uses a round robin (RR) arbitration scheme to select
> > > > the next read channel to be serviced.The same applies when
> > > > youhave multiple write channels.
> > > > 
> > > > The native HDMA driver also supports a maximum of 16 independent
> > > > channels (8 write + 8 read), which can run simultaneously.
> > > > Both SAR (Source Address Register) and DAR (Destination Address Register)
> > > > are aligned to byte.
> > > > 
> > > > Cai Huoqing (1):
> > > >   dmaengine: dw-edma: Add support for native HDMA
> > > > 
> > > > Cai huoqing (3):
> > > >   dmaengine: dw-edma: Rename dw_edma_core_ops structure to
> > > >     dw_edma_plat_ops
> > > >   dmaengine: dw-edma: Create a new dw_edma_core_ops structure to
> > > >     abstract controller operation
> > > >   dmaengine: dw-edma: Add HDMA DebugFS support
> > > 
> > > You should have a single name for all these patches :-(
> > 
> > Hi Vinod,
> > 
> > Thanks for your reply.
> > 
> > Do you mean patch[0/4] and patch[3/4] shouldn't have the same name?
> 
> It should be Cai Huoqing or Cai huoqing not both :-)

Sorry, My mistake :-)

I resend v11 here:
https://lore.kernel.org/lkml/20230520050854.73160-1-cai.huoqing@linux.dev/

thanks,
Cai-

> 
> > 
> > Thanks,
> > Cai-
> > > 
> > > > 
> > > > Tested-by: Serge Semin <fancer.lancer@gmail.com>
> > > > 
> > > > v9->v10:
> > > >   1.Update commit log.
> > > >   2.rebase for dma-next
> > > > 
> > > > v9 link:
> > > >   https://lore.kernel.org/lkml/20230413033156.93751-1-cai.huoqing@linux.dev/
> > > > 
> > > >  drivers/dma/dw-edma/Makefile                 |   8 +-
> > > >  drivers/dma/dw-edma/dw-edma-core.c           |  86 ++----
> > > >  drivers/dma/dw-edma/dw-edma-core.h           |  58 ++++
> > > >  drivers/dma/dw-edma/dw-edma-pcie.c           |   4 +-
> > > >  drivers/dma/dw-edma/dw-edma-v0-core.c        |  85 +++++-
> > > >  drivers/dma/dw-edma/dw-edma-v0-core.h        |  14 +-
> > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c        | 296 +++++++++++++++++++
> > > >  drivers/dma/dw-edma/dw-hdma-v0-core.h        |  17 ++
> > > >  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 170 +++++++++++
> > > >  drivers/dma/dw-edma/dw-hdma-v0-debugfs.h     |  22 ++
> > > >  drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 129 ++++++++
> > > >  drivers/pci/controller/dwc/pcie-designware.c |   2 +-
> > > >  include/linux/dma/edma.h                     |   7 +-
> > > >  13 files changed, 807 insertions(+), 91 deletions(-)
> > > >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
> > > >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> > > >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
> > > >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > 
> > > > -- 
> > > > 2.34.1
> > > 
> > > -- 
> > > ~Vinod
> 
> -- 
> ~Vinod
