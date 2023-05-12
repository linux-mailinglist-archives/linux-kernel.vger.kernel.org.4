Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5186FFE41
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 03:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbjELBGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 21:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239656AbjELBGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 21:06:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4671465A0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 18:06:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D67A86135A
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 01:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27BCC433D2;
        Fri, 12 May 2023 01:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683853570;
        bh=O2xWsXKa4DjDdRZtiAgJqkrBYrAeY725PaQRhhhgrEQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pBrwLga7/TezsQ1Kh7o15ipSWuuCVFFIHPkIkomN4nRFP0Wxljj/vefQ32eDNjIJq
         rpQ/eJoZ/LRvVBiOWMj6ZuEq0xoTzt0enapdJ7QNjA6PC5sAOpvQ2TqIAxjKxJZugX
         r/AZvRyw4bcHXmSFA6+Yc88DAq30831M1neh3OhcpHsMofQczURhSqI5mHlMbslRAQ
         vIgiC9wweJ+8Y1lZkhtoGmOuOnTValycTxHzZrHlqrCTAGwTQ6M/Eq0sZ01yxBCZOe
         cSpOHkWWAiFjaIxsWrHvfIZ2WT7Q/SnHFJ52/ZwRgpMf7apNU/D6AI6IOdaQ1VCGVq
         ToPHUTgvERRKQ==
Date:   Thu, 11 May 2023 18:06:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Lorenz Brun <lorenz@brun.one>
Cc:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 net-next] net: ethernet: mtk_eth_soc: log clock
 enable errors
Message-ID: <20230511180608.6e1f6620@kernel.org>
In-Reply-To: <20230510181350.3743141-1-lorenz@brun.one>
References: <20230510181350.3743141-1-lorenz@brun.one>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 20:13:50 +0200 Lorenz Brun wrote:
>  	for (clk = 0; clk < MTK_CLK_MAX ; clk++) {
>  		ret = clk_prepare_enable(eth->clks[clk]);
> -		if (ret)
> +		if (ret) {
> +			dev_err(eth->dev, "enabling clock %s failed with error %d\n",
> +				mtk_clks_source_name[clk], ret);
>  			goto err_disable_clks;
> +		}

dev_err_probe() would be even better, I think?
-- 
pw-bot: cr
