Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E58740ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjF1IMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:12:18 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16304 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjF1IKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:10:05 -0400
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QrY3g602pzLn30;
        Wed, 28 Jun 2023 15:23:59 +0800 (CST)
Received: from [10.67.102.37] (10.67.102.37) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 28 Jun
 2023 15:26:04 +0800
Subject: Re: [PATCH net-next 07/10] net: hns3: remove unnecessary (void*)
 conversions
To:     wuych <yunchuan@nfschina.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
References: <20230628024510.1440567-1-yunchuan@nfschina.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
From:   Hao Lan <lanhao@huawei.com>
Message-ID: <408a4d7b-5dbf-fa3b-357d-1cd736f92e83@huawei.com>
Date:   Wed, 28 Jun 2023 15:26:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20230628024510.1440567-1-yunchuan@nfschina.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.37]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/28 10:45, wuych wrote:
> Pointer variables of void * type do not require type cast.
> 
> Signed-off-by: wuych <yunchuan@nfschina.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> index 51d1278b18f6..1df941ef86e3 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> @@ -570,7 +570,7 @@ static void hns3_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
>  
>  static u64 *hns3_get_stats_tqps(struct hnae3_handle *handle, u64 *data)
>  {
> -	struct hns3_nic_priv *nic_priv = (struct hns3_nic_priv *)handle->priv;
> +	struct hns3_nic_priv *nic_priv = handle->priv;
>  	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
>  	struct hns3_enet_ring *ring;
>  	u8 *stat;
> 

Hi wuych,
Thank you for your patch.
nit: the local variable declarations could be reverse xmas tree
longest line to shortest line. One option being:
 static u64 *hns3_get_stats_tqps(struct hnae3_handle *handle, u64 *data)
 {
-	struct hns3_nic_priv *nic_priv = (struct hns3_nic_priv *)handle->priv;
 	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
+	struct hns3_nic_priv *nic_priv = handle->priv;
 	struct hns3_enet_ring *ring;
 	u8 *stat;
and elsewhere in other patchs.

By the way, the net-next branch is currently closed, and you need to wait for
the merge window to open before merging patches.

Reviewed-by: Hao Lan <lanhao@huawei.com>

Yours,
Hao Lan
