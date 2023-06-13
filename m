Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8B172E360
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242008AbjFMMxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjFMMw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:52:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354AF10D9;
        Tue, 13 Jun 2023 05:52:57 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QgT3V5DLQzTl6g;
        Tue, 13 Jun 2023 20:52:22 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 20:52:52 +0800
Subject: Re: [PATCH]
 drivers/thunder:improve-warning-message-in-device_for_each_child_node()
To:     Wang Ming <machel@vivo.com>, Sunil Goutham <sgoutham@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <opensource.kernel@vivo.com>
References: <20230613123826.558-1-machel@vivo.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <4aa86edd-5526-929d-8576-9d2b6f828eb0@huawei.com>
Date:   Tue, 13 Jun 2023 20:52:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20230613123826.558-1-machel@vivo.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/13 20:38, Wang Ming wrote:
> In device_for_each_child_node(), it should have fwnode_handle_put()
> before break to prevent stale device node references from being
> left behind.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>

A Fixes tag seems necessary according to the commit log, and should
target the net branch using:

[PATCH net] drivers/thunder: improve-warning-message-in-device_for_each_child_node()

Also it seems confusing the 'improve' in the title suggest that it is not
a fix.

> ---
>  .../net/ethernet/cavium/thunder/thunder_bgx.c | 37 ++++++++++---------
>  1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> index a317feb8d..d37ee2872 100644
> --- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> +++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> @@ -90,7 +90,7 @@ static const struct pci_device_id bgx_id_table[] = {
> 
>  MODULE_AUTHOR("Cavium Inc");
>  MODULE_DESCRIPTION("Cavium Thunder BGX/MAC Driver");
> -MODULE_LICENSE("GPL v2");
> +MODULE_LICENSE("GPL");

Is there any reason you changing the license here?

>  MODULE_VERSION(DRV_VERSION);
>  MODULE_DEVICE_TABLE(pci, bgx_id_table);
> 
> @@ -174,10 +174,10 @@ static struct bgx *get_bgx(int node, int bgx_idx)
>  }
> 
>  /* Return number of BGX present in HW */
> -unsigned bgx_get_map(int node)
> +unsigned int bgx_get_map(int node)

It seems to be unrelated change here, is the changing related to the
problem you are fixing?

>  {
>         int i;
> -       unsigned map = 0;
> +       unsigned int map = 0;

Same here.

> 
>         for (i = 0; i < max_bgx_per_node; i++) {
>                 if (bgx_vnic[(node * max_bgx_per_node) + i])
> @@ -600,9 +600,9 @@ static void bgx_lmac_handler(struct net_device *netdev)
>                 link_changed = -1;
> 
>         if (phydev->link &&
> -           (lmac->last_duplex != phydev->duplex ||
> -            lmac->last_link != phydev->link ||
> -            lmac->last_speed != phydev->speed)) {
> +               (lmac->last_duplex != phydev->duplex ||
> +               lmac->last_link != phydev->link ||
> +               lmac->last_speed != phydev->speed)) {

Same here.

>                         link_changed = 1;
>         }
> 
> @@ -783,7 +783,7 @@ static int bgx_lmac_xaui_init(struct bgx *bgx, struct lmac *lmac)
>                 bgx_reg_write(bgx, lmacid, BGX_SPUX_BR_PMD_LD_REP, 0x00);
>                 /* training enable */
>                 bgx_reg_modify(bgx, lmacid,
> -                              BGX_SPUX_BR_PMD_CRTL, SPU_PMD_CRTL_TRAIN_EN);
> +                                        BGX_SPUX_BR_PMD_CRTL, SPU_PMD_CRTL_TRAIN_EN);

Same here.
Please make sure it only contain change related to fixing the
problem.
