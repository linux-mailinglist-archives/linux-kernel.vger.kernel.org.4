Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7902D70099B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241327AbjELN5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240855AbjELN5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:57:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B4211DB1;
        Fri, 12 May 2023 06:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683899836; x=1715435836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QwWE/tJlAPiCpmRXJUsvyc0KqZbQ5lpruaSv6RHumwg=;
  b=n9yvwfKQOFStLfiN/7ANP61yDQXq4M5JKwqpZTupb6QKaT5X//BQwv/d
   Cw8xwGCmOfN3VGjjDn4BNWJz5t9Owd1bySvbRL+kzFbNcM0FxdoEwDZ7E
   3UXIQGukEa+E4tkmtnr7itWbA1NcNyyvueA84wKUXAsc/GT9h3jbE1Dp+
   fQQ+ZQEPpBVHInBZi0wraH4/mU+UVYeCgn9EUuelE9ZArsa1CUVqDrsSO
   hlw5pGkia1SaNJUzXKRjKkup5zs0U04yPtZ1S28ToHeW+rmcUCUMkTwxf
   IgisY9wE6gMP0okz4Kh+vJ9/nHjG8R4ZJ0DcxG2EFUDcXiAo2GcAOcNk3
   A==;
X-IronPort-AV: E=Sophos;i="5.99,269,1677567600"; 
   d="scan'208";a="210976329"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2023 06:57:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 12 May 2023 06:57:14 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 12 May 2023 06:57:14 -0700
Date:   Fri, 12 May 2023 15:57:13 +0200
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
        <linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>
Subject: Re: [PATCH net] net: fec: remove the xdp_return_frame when lack of
 tx BDs
Message-ID: <20230512135713.lwfpw4lzreece4rb@soft-dev3-1>
References: <20230512133843.1358661-1-shenwei.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20230512133843.1358661-1-shenwei.wang@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 05/12/2023 08:38, Shenwei Wang wrote:
> 
> In the implementation, the sent_frame count does not increment when
> transmit errors occur. Therefore, bq_xmit_all() will take care of
> returning the XDP frames.

Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>

> 
> Fixes: 26312c685ae0 ("net: fec: correct the counting of XDP sent frames")
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 42ec6ca3bf03..2a3e8b69b70a 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -3798,7 +3798,6 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>         entries_free = fec_enet_get_free_txdesc_num(txq);
>         if (entries_free < MAX_SKB_FRAGS + 1) {
>                 netdev_err(fep->netdev, "NOT enough BD for SG!\n");
> -               xdp_return_frame(frame);
>                 return NETDEV_TX_BUSY;
>         }
> 
> --
> 2.34.1
> 
> 

-- 
/Horatiu
