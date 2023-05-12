Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32007009BF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241419AbjELOBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240663AbjELOBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:01:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204D612EA9;
        Fri, 12 May 2023 07:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683900067; x=1715436067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3vzGUZA+RgRqbweBvwNd/nEAcsPe7ebT5+bnM8nlORI=;
  b=SvY6blzUWALJTv+A6pI4F6TL6NWm/6ba+gcAa+rKTo2yyCiQhqwZNarx
   iuU+lt6TL2NH4uYr7oMdsRB2IT0IXRPdTW/lf6vSlic8YNWpg5ik8hIL3
   cSlBiezNIxF4L6GH6WXJbDN+d6AtOvuV227l8yhiGdj9SKjXGSgJ66hMs
   Fv5mnS/wtamfTMz/z0mZupppVQgFIdLOxQx41i5bbVe23cY3Se3s6ZtX+
   8mIPhBbPuGLRphQU3g4uuitzefKo2Xaltmt9XiDqW/QLn4OuCFugWbBTA
   W4D1dwbDcAJ0dJBzeX4m2QE+zht8oQQIYfIsb0FwM1nBDu1AQhpD/+Z1Y
   g==;
X-IronPort-AV: E=Sophos;i="5.99,269,1677567600"; 
   d="scan'208";a="213608245"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2023 07:00:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 12 May 2023 07:00:50 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 12 May 2023 07:00:50 -0700
Date:   Fri, 12 May 2023 16:00:49 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Shenwei Wang <shenwei.wang@nxp.com>
CC:     Wei Fang <wei.fang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v4] net: fec: using the standard return codes when xdp
 xmit errors
Message-ID: <20230512140049.tgshwq5xz6jxhcrz@soft-dev3-1>
References: <20230512132010.1358350-1-shenwei.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20230512132010.1358350-1-shenwei.wang@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 05/12/2023 08:20, Shenwei Wang wrote:
> 
> This patch standardizes the inconsistent return values for unsuccessful
> XDP transmits by using standardized error codes (-EBUSY or -ENOMEM).

Just a small thing, you have forgot to add net-next in the subject.
I think you should hold back this patch until the fix that you have sent
to net will reach net-next, otherwise will be a small conflict.
Other than that it looks great. Thanks!

Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>

> 
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> ---
>  v4:
>   - remove the fix of double call of xdp_return_frame in this patch and
>     will correct it in another patch for net.
> 
>  v3:
>   - remove the fix tag.
>   - resend to net-next
> 
>  v2:
>   - focusing on code clean up per Simon's feedback.
> 
>  drivers/net/ethernet/freescale/fec_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 42ec6ca3bf03..cd215ab20ff9 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -3799,7 +3799,7 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>         if (entries_free < MAX_SKB_FRAGS + 1) {
>                 netdev_err(fep->netdev, "NOT enough BD for SG!\n");
>                 xdp_return_frame(frame);
> -               return NETDEV_TX_BUSY;
> +               return -EBUSY;
>         }
> 
>         /* Fill in a Tx ring entry */
> @@ -3813,7 +3813,7 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>         dma_addr = dma_map_single(&fep->pdev->dev, frame->data,
>                                   frame->len, DMA_TO_DEVICE);
>         if (dma_mapping_error(&fep->pdev->dev, dma_addr))
> -               return FEC_ENET_XDP_CONSUMED;
> +               return -ENOMEM;
> 
>         status |= (BD_ENET_TX_INTR | BD_ENET_TX_LAST);
>         if (fep->bufdesc_ex)
> @@ -3869,7 +3869,7 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
>         __netif_tx_lock(nq, cpu);
> 
>         for (i = 0; i < num_frames; i++) {
> -               if (fec_enet_txq_xmit_frame(fep, txq, frames[i]) != 0)
> +               if (fec_enet_txq_xmit_frame(fep, txq, frames[i]) < 0)
>                         break;
>                 sent_frames++;
>         }
> --
> 2.34.1
> 

-- 
/Horatiu
