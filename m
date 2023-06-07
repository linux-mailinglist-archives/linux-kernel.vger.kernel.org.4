Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCF47266EE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjFGRQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFGRQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:16:08 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA30010EC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:16:06 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-652328c18d5so3601824b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686158166; x=1688750166;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mLU1INJD0pdR3xPCMUbwnl9lW/JWEL01oogkdm7knaA=;
        b=iyjMaOqsH9l08blHXDdDee+kwO0Qd3TyYKKFbv6/EgAl+6Iljqwwbb85GqNl3bHvg5
         E27nnr+5YYQkFydK3OsW+ACLQxiydcugrFj/Tqpu1izMA0Zsk+F7zH2Lj2nO+WrgrIH7
         X0PS/+FSyJu/oyT+bcsCZAW+xu1BPBFmv5WsyJJJ/jBgNi/YKp17G86f9QSdz6PnHcVb
         M3mTvlOVWfV3AmOSCqihZUANoK+s+KweQ2soQSaZoEMRcUeRkHJI2dMMVQKAO3neXHnf
         okOCLqPtfYpixGQO8ik+V8KNFPPpbwatKQQc2+YIPTRH9zK/qQhOyroQTnUaWbnxD/Vj
         3uGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686158166; x=1688750166;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLU1INJD0pdR3xPCMUbwnl9lW/JWEL01oogkdm7knaA=;
        b=XGl4B/Dy1IbrW+BHuIR3blwxeZck/0aeYONtqmU4QFVglVFd/NeDN8GkERlK4qQr4S
         hETpyM9E9fBuyqjR9TDi0Vlf6JG1gYSIK01jWLYmY2ofxDrKiJsshAcGeRP/Bj7dEqib
         yCvppvwXfa2KkceKjQDWpfALyK5bukxTsTp5k1moGEb6jaF4AbslwRbBg6E3nPMGqNxV
         O5pCEj6DhySAvN9Hdb3tm3WXvygnJlnKbWOE8yNtGBFanrAOZJPYiX71vceCGXW3A9++
         rf89BZZA86Dh09PGBrAeMzYM8MSfQHKSaa9Sy2cziwZu+MFhNXXA069k3IE/7bvZK9iv
         WR3w==
X-Gm-Message-State: AC+VfDxmVA3JhjFItQ6rtrZJXCOTw/UZc5MgGCHLWPyowZ+1zxh1pFxz
        uOEHK+hP6oHHeI4ODjI9sQdV
X-Google-Smtp-Source: ACHHUZ5cr2pGOwf4kGEG/YbUqS3i1L1ZabWozbOXyO3M+s3hRdUlRVR6XfnAby63bDyQw6dIhDDP+w==
X-Received: by 2002:a05:6a20:394a:b0:117:51fe:9b4c with SMTP id r10-20020a056a20394a00b0011751fe9b4cmr1780184pzg.7.1686158166390;
        Wed, 07 Jun 2023 10:16:06 -0700 (PDT)
Received: from thinkpad ([59.92.97.244])
        by smtp.gmail.com with ESMTPSA id io23-20020a17090312d700b001aface7bdd8sm10752890plb.31.2023.06.07.10.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 10:16:05 -0700 (PDT)
Date:   Wed, 7 Jun 2023 22:46:01 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org
Subject: Re: [PATCH v2 1/2] net: Add MHI Endpoint network driver
Message-ID: <20230607171601.GB109456@thinkpad>
References: <20230607152427.108607-1-manivannan.sadhasivam@linaro.org>
 <20230607152427.108607-2-manivannan.sadhasivam@linaro.org>
 <26a85bae-1a33-dd1f-5e73-0ab6da100abf@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26a85bae-1a33-dd1f-5e73-0ab6da100abf@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:27:47AM -0600, Jeffrey Hugo wrote:
> On 6/7/2023 9:24 AM, Manivannan Sadhasivam wrote:
> > Add a network driver for the Modem Host Interface (MHI) endpoint devices
> > that provides network interfaces to the PCIe based Qualcomm endpoint
> > devices supporting MHI bus. This driver allows the MHI endpoint devices to
> > establish IP communication with the host machines (x86, ARM64) over MHI
> > bus.
> > 
> > The driver currently supports only IP_SW0 MHI channel that can be used
> > to route IP traffic from the endpoint CPU to host machine.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/net/Kconfig      |   9 ++
> >   drivers/net/Makefile     |   1 +
> >   drivers/net/mhi_ep_net.c | 331 +++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 341 insertions(+)
> >   create mode 100644 drivers/net/mhi_ep_net.c
> > 
> > diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> > index 368c6f5b327e..36b628e2e49f 100644
> > --- a/drivers/net/Kconfig
> > +++ b/drivers/net/Kconfig
> > @@ -452,6 +452,15 @@ config MHI_NET
> >   	  QCOM based WWAN modems for IP or QMAP/rmnet protocol (like SDX55).
> >   	  Say Y or M.
> > +config MHI_EP_NET
> > +	tristate "MHI Endpoint network driver"
> > +	depends on MHI_BUS_EP
> > +	help
> > +	  This is the network driver for MHI bus implementation in endpoint
> > +	  devices. It is used provide the network interface for QCOM endpoint
> > +	  devices such as SDX55 modems.
> > +	  Say Y or M.
> 
> What will the module be called if "m" is selected?
> 

Will add that info.

> > +
> >   endif # NET_CORE
> >   config SUNGEM_PHY
> > diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> > index e26f98f897c5..b8e706a4150e 100644
> > --- a/drivers/net/Makefile
> > +++ b/drivers/net/Makefile
> > @@ -40,6 +40,7 @@ obj-$(CONFIG_NLMON) += nlmon.o
> >   obj-$(CONFIG_NET_VRF) += vrf.o
> >   obj-$(CONFIG_VSOCKMON) += vsockmon.o
> >   obj-$(CONFIG_MHI_NET) += mhi_net.o
> > +obj-$(CONFIG_MHI_EP_NET) += mhi_ep_net.o
> >   #
> >   # Networking Drivers
> > diff --git a/drivers/net/mhi_ep_net.c b/drivers/net/mhi_ep_net.c
> > new file mode 100644
> > index 000000000000..0d7939caefc7
> > --- /dev/null
> > +++ b/drivers/net/mhi_ep_net.c
> > @@ -0,0 +1,331 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * MHI Endpoint Network driver
> > + *
> > + * Based on drivers/net/mhi_net.c
> > + *
> > + * Copyright (c) 2023, Linaro Ltd.
> > + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > + */
> > +
> > +#include <linux/if_arp.h>
> > +#include <linux/mhi_ep.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/netdevice.h>
> > +#include <linux/skbuff.h>
> > +#include <linux/u64_stats_sync.h>
> > +
> > +#define MHI_NET_MIN_MTU		ETH_MIN_MTU
> > +#define MHI_NET_MAX_MTU		0xffff
> > +
> > +struct mhi_ep_net_stats {
> > +	u64_stats_t rx_packets;
> > +	u64_stats_t rx_bytes;
> > +	u64_stats_t rx_errors;
> > +	u64_stats_t tx_packets;
> > +	u64_stats_t tx_bytes;
> > +	u64_stats_t tx_errors;
> > +	u64_stats_t tx_dropped;
> > +	struct u64_stats_sync tx_syncp;
> > +	struct u64_stats_sync rx_syncp;
> > +};
> > +
> > +struct mhi_ep_net_dev {
> > +	struct mhi_ep_device *mdev;
> > +	struct net_device *ndev;
> > +	struct mhi_ep_net_stats stats;
> > +	struct workqueue_struct *xmit_wq;
> > +	struct work_struct xmit_work;
> > +	struct sk_buff_head tx_buffers;
> > +	spinlock_t tx_lock; /* Lock for protecting tx_buffers */
> > +	u32 mru;
> > +};
> > +
> > +static void mhi_ep_net_dev_process_queue_packets(struct work_struct *work)
> > +{
> > +	struct mhi_ep_net_dev *mhi_ep_netdev = container_of(work,
> > +			struct mhi_ep_net_dev, xmit_work);
> 
> Looks like this can fit all on one line to me.
> 

That's me trying to stick to both 100 and 80 column width :/ Will fix it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
