Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F6472C896
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbjFLObp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbjFLOb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:31:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B871985;
        Mon, 12 Jun 2023 07:29:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AA0762A34;
        Mon, 12 Jun 2023 14:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89300C433D2;
        Mon, 12 Jun 2023 14:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686580041;
        bh=rxg1S6IQcpSNyoLhkAT/bGn9HA6mUeGJAAfQyEFiPa0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pk0Ui3pyQoQKq52oTwRo1B3KHkOWDh6YSVV+nZJQXBU1zGZt2/5guwx2ZSwdDlDA0
         LbcaMIbj75RL/t/247CjpWjUGG1813yoIvPV1UAt4I77BcNsq5ECPgIbjezgT9ZkAL
         swt1oP4XOsup2IrlpgXAYf7SCaKWMBGUheNviJovgRXcDC3VJaNtWsibtbh8Te3MEK
         1HLE2X70p6rSyikSkCeieOfjno7f0Sm5oA/sVWoxKJGXV2pjkqYEQyzJFXKADYeW03
         ffZ6vUKXMymGQwC74j7ZoHAjtpA1SfY/ZeIeYrm8LqNaIR9OH6Ll4DGDlcA03WmuT5
         cWq7D3AoYB1mg==
Message-ID: <f0329c00-8d5a-ba89-c793-608f85cf70b3@kernel.org>
Date:   Mon, 12 Jun 2023 17:27:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] net: ethernet: ti-cpsw: fix linking built-in code to
 modules
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-omap@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mao Wenan <maowenan@huawei.com>, Andrew Lunn <andrew@lunn.ch>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>, bpf@vger.kernel.org
References: <20230612124024.520720-1-arnd@kernel.org>
 <20230612124024.520720-3-arnd@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230612124024.520720-3-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 12/06/2023 15:40, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are six variants of the cpsw driver, sharing various parts of
> the code: davinci-emac, cpsw, cpsw-switchdev, netcp, netcp_ethss and
> am65-cpsw-nuss.
> 
> I noticed that this means some files can be linked into more than
> one loadable module, or even part of vmlinux but also linked into
> a loadable module, both of which mess up assumptions of the build
> system.
> 
> Change this back to having separate modules for each portion that
> can be linked standalone, exporting symbols as needed:
> 
>  - ti-cpsw-common.ko now contains both cpsw-common.o and
>    davinci_cpdma.o as they are always used together
> 
>  - ti-cpsw-priv.ko contains cpsw_priv.o, cpsw_sl.o and cpsw_ethtool.o,
>    which are the core of the cpsw and cpsw-new drivers.
> 
>  - ti-cpsw-ale.o is the one standalone module that is used by all
>    except davinci_emac.
> 
> Each of these will be built-in if any of its users are built-in,
> otherwise it's a loadable module if there is at least one module
> using it. I did not bring back the separate Kconfig symbols for
> this, but just handle it using Makefile logic.
> 
> Note: ideally this is something that Kbuild complains about, but
> usually we just notice when something using THIS_MODULS misbehaves
> in a way that a user notices.
> 
> Fixes: 99f6297182729 ("net: ethernet: ti: cpsw: drop TI_DAVINCI_CPDMA config option")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/ti/Makefile        | 29 +++++++++++-----------
>  drivers/net/ethernet/ti/cpsw_ale.c      | 23 +++++++++++++++++
>  drivers/net/ethernet/ti/cpsw_ethtool.c  | 25 +++++++++++++++++++
>  drivers/net/ethernet/ti/cpsw_priv.c     | 33 +++++++++++++++++++++++++
>  drivers/net/ethernet/ti/cpsw_sl.c       |  8 ++++++
>  drivers/net/ethernet/ti/davinci_cpdma.c | 27 ++++++++++++++++++++
>  6 files changed, 130 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
> index 75f761efbea71..d1f44f7667a96 100644
> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -3,28 +3,27 @@
>  # Makefile for the TI network device drivers.
>  #
>  
> -obj-$(CONFIG_TI_CPSW) += cpsw-common.o
> -obj-$(CONFIG_TI_DAVINCI_EMAC) += cpsw-common.o
> -obj-$(CONFIG_TI_CPSW_SWITCHDEV) += cpsw-common.o
> +ti-cpsw-common-y += cpsw-common.o davinci_cpdma.o
> +ti-cpsw-priv-y += cpsw_priv.o cpsw_sl.o cpsw_ethtool.o
> +ti-cpsw-ale-y += cpsw_ale.o
>  
>  obj-$(CONFIG_TLAN) += tlan.o
>  obj-$(CONFIG_CPMAC) += cpmac.o
> -obj-$(CONFIG_TI_DAVINCI_EMAC) += ti_davinci_emac.o
> -ti_davinci_emac-y := davinci_emac.o davinci_cpdma.o
> +obj-$(CONFIG_TI_DAVINCI_EMAC) += davinci_emac.o ti-cpsw-common.o
>  obj-$(CONFIG_TI_DAVINCI_MDIO) += davinci_mdio.o
>  obj-$(CONFIG_TI_CPSW_PHY_SEL) += cpsw-phy-sel.o
>  obj-$(CONFIG_TI_CPTS) += cpts.o
> -obj-$(CONFIG_TI_CPSW) += ti_cpsw.o
> -ti_cpsw-y := cpsw.o davinci_cpdma.o cpsw_ale.o cpsw_priv.o cpsw_sl.o cpsw_ethtool.o
> -obj-$(CONFIG_TI_CPSW_SWITCHDEV) += ti_cpsw_new.o
> -ti_cpsw_new-y := cpsw_switchdev.o cpsw_new.o davinci_cpdma.o cpsw_ale.o cpsw_sl.o cpsw_priv.o cpsw_ethtool.o
> +obj-$(CONFIG_TI_CPSW) += ti_cpsw.o ti-cpsw-common.o ti-cpsw-priv.o ti-cpsw-ale.o
> +ti_cpsw-y := cpsw.o
> +obj-$(CONFIG_TI_CPSW_SWITCHDEV) += ti_cpsw_new.o ti-cpsw-common.o ti-cpsw-priv.o ti-cpsw-ale.o
> +ti_cpsw_new-y := cpsw_switchdev.o cpsw_new.o
>  
> -obj-$(CONFIG_TI_KEYSTONE_NETCP) += keystone_netcp.o
> -keystone_netcp-y := netcp_core.o cpsw_ale.o
> -obj-$(CONFIG_TI_KEYSTONE_NETCP_ETHSS) += keystone_netcp_ethss.o
> -keystone_netcp_ethss-y := netcp_ethss.o netcp_sgmii.o netcp_xgbepcsr.o cpsw_ale.o
> +obj-$(CONFIG_TI_KEYSTONE_NETCP) += keystone_netcp.o ti-cpsw-ale.o
> +keystone_netcp-y := netcp_core.o
> +obj-$(CONFIG_TI_KEYSTONE_NETCP_ETHSS) += keystone_netcp_ethss.o ti-cpsw-ale.o
> +keystone_netcp_ethss-y := netcp_ethss.o netcp_sgmii.o netcp_xgbepcsr.o
>  
> -obj-$(CONFIG_TI_K3_AM65_CPSW_NUSS) += ti-am65-cpsw-nuss.o
> -ti-am65-cpsw-nuss-y := am65-cpsw-nuss.o cpsw_sl.o am65-cpsw-ethtool.o cpsw_ale.o k3-cppi-desc-pool.o am65-cpsw-qos.o
> +obj-$(CONFIG_TI_K3_AM65_CPSW_NUSS) += ti-am65-cpsw-nuss.o ti-cpsw-priv.o ti-cpsw-ale.o

cpsw_priv.o and cpsw_ethtool.o (included in ti-cpsw-priv.o) are not required by ti-am65-cpsw-nuss.
It only needs cpsw_sl.o

-- 
cheers,
-roger
