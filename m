Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8336F4B29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjEBURC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEBURA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:17:00 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4033D26A5;
        Tue,  2 May 2023 13:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=FDskB3SV/1RuJlj1cdT8hXMsx7jb467/4HrUADLnknM=; b=mGYEtCmdXiz6QCc/5oxHgVC3RM
        Kpx1yYbXvd1YUg0TlpUUdObnjmhjHMYQOJkkjAgiVxAH4othcawnd8ivkQekhA94Pwnj0OEVwBcdo
        vZP262xvfLlXY1JyURsMz+js4nsMz/wYuv42419dIM7ldaac4dyzYBhDxfIoO2bXuIxM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ptwPv-00BlIx-Qa; Tue, 02 May 2023 22:16:07 +0200
Date:   Tue, 2 May 2023 22:16:07 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     Wei Fang <wei.fang@nxp.com>,
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
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev, Gagandeep Singh <g.singh@nxp.com>
Subject: Re: [PATCH 1/1] net: fec: enable the XDP_TX support
Message-ID: <6032c1be-4080-4103-b196-c3a44bd5df6b@lunn.ch>
References: <20230502193219.673637-1-shenwei.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502193219.673637-1-shenwei.wang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 02:32:19PM -0500, Shenwei Wang wrote:
> Enable the XDP_TX path and correct the return value of the xmit function.
> 
> If any individual frame cannot transmit due to lack of BD entries, the
> function would still return success for sending all frames. This results
> in prematurely indicating frames were sent when they were actually dropped.
> 
> The patch resolves the issue by ensureing the return value properly
> indicates the actual number of frames successfully transmitted, rather than
> potentially reporting success for all frames when some could not transmit.

Hi Shenwei

The patch subject is wrong. This do not enable the XDP_TX support, it
fixes the XDP_TX support.

Please also take a read of the netdev FAQ. You your put the tree in
the patch subject.

> 
> Fixes: 6d6b39f180b8 ("net: fec: add initial XDP support")
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 27 ++++++++++++++++-------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 160c1b3525f5..dfc1bcc9a8db 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -75,6 +75,10 @@
>  
>  static void set_multicast_list(struct net_device *ndev);
>  static void fec_enet_itr_coal_set(struct net_device *ndev);
> +static int fec_enet_xdp_xmit(struct net_device *dev,
> +			     int num_frames,
> +			     struct xdp_frame **frames,
> +			     u32 flags);

For a minimal fix for net, this is O.K. But once net-next has opened,
please submit a patch which moves the code around to avoid the forward
declaration.

	Andrew
