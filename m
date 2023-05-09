Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4CF6FC0A2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjEIHpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjEIHpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:45:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A817DA3
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 00:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A70C861E99
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B502C433EF;
        Tue,  9 May 2023 07:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683618306;
        bh=hQf9pNjF7zwQYcyl32iKf1KLzffA/L5NTPvBZwMUTgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5LB7U1w8G4yNHH3tkFYJG0rDXq46KYsBP33UJPdV3muH7IJ0NBQ+GLscVF4mH3Fl
         l/UG0wo3OZFH1I1zVYup3sEMAaSEytVom8vPwn+MQdBrkcJzyrfxPq3AHzWBnwexvJ
         qmsMzYkIRIdc1bs00SywKw5YmU1oRhyMMFAbHZGJ5QsWExGoolS97YzimyCLwMhDKJ
         YLHtjtHuVm7YMkq7e3o836Cbwi2EABhQivy3SAfag6PeYF/ZHy2uk+fLoKS+d5AbGL
         h6Q9m+bZST3sf8Oj27QIrlw0VDTx4pHpm+DEU9EQct67JkatYU+MwuSvDCPh0NABnz
         ss+U6ERs6r7Mg==
Date:   Tue, 9 May 2023 10:45:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
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
Subject: Re: [PATCH v4 1/1] net: fec: correct the counting of XDP sent frames
Message-ID: <20230509074502.GB38143@unreal>
References: <20230508142931.980196-1-shenwei.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508142931.980196-1-shenwei.wang@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 09:29:31AM -0500, Shenwei Wang wrote:
> In the current xdp_xmit implementation, if any single frame fails to
> transmit due to insufficient buffer descriptors, the function nevertheless
> reports success in sending all frames. This results in erroneously
> indicating that frames were transmitted when in fact they were dropped.
> 
> This patch fixes the issue by ensureing the return value properly
> indicates the actual number of frames successfully transmitted, rather than
> potentially reporting success for all frames when some could not transmit.
> 
> Fixes: 6d6b39f180b8 ("net: fec: add initial XDP support")
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  v4:
>   - the tx frame shouldn't be returned when error occurs.
>   - changed the function return values by using the standard errno.
> 
>  v3:
>   - resend the v2 fix for "net" as the standalone patch.
> 
>  v2:
>   - only keep the bug fix part of codes according to Horatiu's comments.
>   - restructure the functions to avoid the forward declaration.
> 
>  drivers/net/ethernet/freescale/fec_main.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

<...>

> -	for (i = 0; i < num_frames; i++)
> -		fec_enet_txq_xmit_frame(fep, txq, frames[i]);
> +	for (i = 0; i < num_frames; i++) {
> +		if (fec_enet_txq_xmit_frame(fep, txq, frames[i]) != 0)
> +			break;
> +		sent_frames++;
> +	}

net-next has commit 6312c685ae0 ("net: fec: correct the counting of XDP sent frames")
which has exactly these lines.

Plus the patch is missing target tree in its subject line.
For example: [PATCH net-next] ...

Thanks
