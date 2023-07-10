Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBBD74D4BB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjGJLnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGJLnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:43:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED9EAD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:43:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D30260FC0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D87BC433C7;
        Mon, 10 Jul 2023 11:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688989379;
        bh=hUf6J5WnjG0KbBU8bMn67a55iQIfrDSdaQj01gr/rbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UTHDRXWqoGzeYmc28eSsX0eiH9NHeWLcA49Zf4XreaB3K8Fh49uO77hPdUv0BaZ/w
         7oeFwp6RwUm/bEQ2bDEiDiLCyC/2VRGRnEOgaMZHuJhkpx+9cldu9vkW/irKQYC/f+
         EzdvP2KEzuKQh7sxZqfEMn+Ml845gKZ2j6r+i5rPZ9ikWUztCdJaDs6PLKRsBaBSqx
         skgLayoeSnyfjDjMT13mbFhHDXz447Rwyuu/hbia1z14i5a/6RH61+MN6hFudFh4/4
         zolz1wWnKT1EevQJq0wVCfmbkl/3L8caz0SShW/r78W+SqBWjLX+bCc1HVEOgcgu4K
         zBYlSOpDnKUmg==
Date:   Mon, 10 Jul 2023 12:42:53 +0100
From:   Lee Jones <lee@kernel.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, linyunsheng@huawei.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Subject: Re: [PATCH net v3] net: ravb: Fix possible UAF bug in ravb_remove
Message-ID: <20230710114253.GA132195@google.com>
References: <20230311180630.4011201-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311180630.4011201-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Mar 2023, Zheng Wang wrote:

> In ravb_probe, priv->work was bound with ravb_tx_timeout_work.
> If timeout occurs, it will start the work. And if we call
> ravb_remove without finishing the work, there may be a
> use-after-free bug on ndev.
> 
> Fix it by finishing the job before cleanup in ravb_remove.
> 
> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
> v3:
> - fix typo in commit message
> v2:
> - stop dev_watchdog so that handle no more timeout work suggested by Yunsheng Lin,
> add an empty line to make code clear suggested by Sergey Shtylyov
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 4 ++++
>  1 file changed, 4 insertions(+)

For better or worse, it looks like this issue was assigned a CVE.

Are we expecting v4 or was it resolved in another way?

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 0f54849a3823..eb63ea788e19 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -2892,6 +2892,10 @@ static int ravb_remove(struct platform_device *pdev)
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *info = priv->info;
>  
> +	netif_carrier_off(ndev);
> +	netif_tx_disable(ndev);
> +	cancel_work_sync(&priv->work);
> +	
>  	/* Stop PTP Clock driver */
>  	if (info->ccc_gac)
>  		ravb_ptp_stop(ndev);
> -- 
> 2.25.1
> 

-- 
Lee Jones [李琼斯]
