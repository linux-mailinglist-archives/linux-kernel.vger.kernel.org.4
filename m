Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E1B747907
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 22:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGDUaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 16:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjGDUao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 16:30:44 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2125.outbound.protection.outlook.com [40.107.92.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7BBE7B;
        Tue,  4 Jul 2023 13:30:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbFDm4uZzbS9MNQnaetFXqamZEebNxl+sUizMPXWnIzdSgkAzLl2miQc57luAkyHk2vtdlXexDjHzwlFq3G/ijHs/L35t6yN/dAjCFQ/KOSELoEFaV/HsooG8xG6K3oJ0Dnypp1nQ1+aVvskHS2+P7I2oxuQLYw3CRmk8C0xm5Fs9j1qSDQdxRdn8Wnxi1qzf0JzZxhdI+CVLlzBG1TYDBhWgdeX68Cb5BOnLWzGIT5/z26W8q6svD7LmLPrKBArkNgjHpcDvg1Fa6gEjjhMBZej+fFoK9VpPIE+6gDpL4KrIpXKVYYzMAtCElKnxlW+hbK30wqMaK/qKwUBUWDaaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOMo8NcpYuFvX7GsdLlFtvQPCIzFRb1hckBkwwu533k=;
 b=l2/le8a+y9LF738CREmmBbcDPmSh2a7LnlZXcEHC6IleoITXa2ePPJMU1ClR2ut2p4nOKszaJokIdUdN9aIpBA8e09va3tQjYnwZpzbLBm8MKPH0lkR4l2TFc6z+UAPlltj7yv4aHoM3w3nQ+3VVXg8quvKpBlC1DBe0pOH992z1Gk2Gvfcy0/xTt+tku4Z7onoYXNVQFKTsvYXrFXmwQxyHRlWWiVFC+xRrHAdJofRpgOmyQi3btL7ZvnL+4ZLAK8HxsZfebZhzvuUejeANqQTrb7B7bp0wfdiaW6SeI7rUQkEdHjs3QrbFLkCOysOJlrKR12POKaaCGXYRtFypnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOMo8NcpYuFvX7GsdLlFtvQPCIzFRb1hckBkwwu533k=;
 b=SnA+UF0uFQePP+m8deAcjJUN4N7UgWb52DZv522JZJB3A96Ej9Ty5S3va7aTXqd1mvJRuA5a+KdPC/3yq1aohyKswTZodZxvNM5GrA9lgbFC+QGeFU2d95/zokZTzy5TJZ1NoY5s4u8tmYGstkU4uXuK+2pMvPibf34PG1lOrII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH3PR13MB6508.namprd13.prod.outlook.com (2603:10b6:610:197::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Tue, 4 Jul
 2023 20:30:37 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 20:30:37 +0000
Date:   Tue, 4 Jul 2023 21:30:29 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Wang Ming <machel@vivo.com>
Cc:     Sunil Goutham <sgoutham@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] net:thunder_bgx:Fix resource leaks in
 device_for_each_child_node() loops
Message-ID: <ZKSBZW1a/f2H7H41@corigine.com>
References: <20230704141457.4844-1-machel@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704141457.4844-1-machel@vivo.com>
X-ClientProxiedBy: LO2P265CA0226.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::22) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH3PR13MB6508:EE_
X-MS-Office365-Filtering-Correlation-Id: eead7932-903d-4a31-b9a6-08db7ccd8674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B06ohbL9PAT5S2fg6UDhB3b+8Ir7CWzAOaVhqqNhnQS4bXtn6aQTdMlhmtTgiHgeNq3Y1Qhj2LWACPOh4mxgQCtCNo9NH9xUpoDQP21Stghzg8O6AWAMi9fsXts9K0Tic9uq/LP6aIcRhAYeooGPQK6N+HY/eFCs/MERqpMdl4Torvoy1koAxi561FNMYLjzfd0DAnW1SlKFctOS9Blq+8rDiTnSd0/oJXnx2jCzKYqDwCsB8ouYBtcHgUZXzawmMs14CV2V9ogaQBxc69qi+8vOOxG/fiZw+jdLUp5iNlraxD7IbNHKd+5eM3ayEO3pwww5q/YfZoon5AKUk0BkNDqzn0yPqVCkn8zz5PNhX3vYuCTytItiPyqTB7Vtj1NSlgMOYTJ+cmNMpi5bZ5JdYF7mJuItjLXlfgltJIMO2Y7UmgUcxmQbc9rieo81JYCfxcHYdZG0CnHTAjFQe5LeHrfx0MZ1HOoFP8VNzIPyUb+u+jKw1J6LtXHJLm0XYrCNjrIsyfYCwusCE7Xxr/BmMzAUKNy/j8Kll8b+8yFSU6yX/rouNrXDOPug3LxAuEz/2PCadJNWddIa+ialvn7Elvp2cY+46dA8MtehYcQlo/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(136003)(39840400004)(451199021)(6666004)(6512007)(6486002)(966005)(478600001)(54906003)(2906002)(6506007)(26005)(186003)(66476007)(44832011)(6916009)(4326008)(66946007)(7416002)(41300700001)(8936002)(8676002)(5660300002)(66556008)(316002)(38100700002)(86362001)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XR6LiFRrseWhK273YPEf60iRy3KEEXH6v6bENzjdlKrR2hoSuBZ2YNrI2ER2?=
 =?us-ascii?Q?ilFRxixToRh6/7Ij89uSSJ4G+3HbK3V7anIcwq2+81CdVEF1ScQSZZ6VRNRN?=
 =?us-ascii?Q?gaCM6/a7fyoOgpdSdLV1zCHwGoPAtInq4gh7ZMnsyhiGEHVPiqeQ80u3Bsaq?=
 =?us-ascii?Q?wF3/YC6EQMu5GRsGpinOJVMLLK2G1q4OiggoTLFQUSE3dVPikT7J51DnZduo?=
 =?us-ascii?Q?o6uuKqYcjX40kGZUE5lHemYxUJrKgDNzhU41AWukXwc312OWy2r0CzJV17hF?=
 =?us-ascii?Q?QIR0EBi04zQ6SYyOfQuKcLKtGjrf2hWdjI1u0aHxK76n+3slnPm/k/E8vgdD?=
 =?us-ascii?Q?xrQ/P2xCDw/y3/gjrhzB3IG6BDtvrMvdpQMAp1UWNqs+uvRka8j9Flc8u2Yx?=
 =?us-ascii?Q?ZmIaVF7Mn/AhAykMzmcQYGgT0/cuPlF1y755Vq6koCzHJJOUWjvWrPx9NQm5?=
 =?us-ascii?Q?BN+uQgUYvEKPEYvtUHvWjdDNGr1lTKYvVdnp5iQeWKOljXS0mC7bxQHVfzQG?=
 =?us-ascii?Q?0DGuuGOXZp1qBIdRC/TIlmtH5Xo8oaF2wtfxrcoDsIQzyTBsTR7jVfgxuyOP?=
 =?us-ascii?Q?3hlcd5oDW0A1W+0Ekdb5eeLgDmr98PVQKRNCa9ihaXhAtpMa8KAf3GmV1xHx?=
 =?us-ascii?Q?dj+QYm483AIcO+/L5Opi/XEr1u+/VUfGKlpTNBd7BpQ34roFRPuPheLS2tIr?=
 =?us-ascii?Q?e+/RjC7Ni1GipxBW9O8bx5foW/XI6TcDi9aqrSA2ZAdg1JXd9/9+YkOogxYr?=
 =?us-ascii?Q?V6GGviMscB4lpI3hnKYJoHrnOnnkVLmSNXy3ZAvoRdXp9M2GkwF2SQ2UTibQ?=
 =?us-ascii?Q?2RrjDCoaXxQRLrP/SOGCdUpvpYoLPWUZxZ7lEXm8T135C0faMYMhxHn/Z7lC?=
 =?us-ascii?Q?YFpnPvuBFavZ4YmqFVcAoN7kbXIDoHJ+VCpqid7eU5TW+Y3XcUbzjNakfw+D?=
 =?us-ascii?Q?bykshJ+VoIWO3wDgVqFDDE+aneKlaluoQL+LK5Lf8Myrmrw9KI+PHtobqVij?=
 =?us-ascii?Q?GE7n8jNkD6rmtCUDl1BjKUIIDkIDyR+8/KH89pMj+yiMAxKOZxE9ftQO4EOs?=
 =?us-ascii?Q?0j0ABJiknLriNoN6OftGbX8rQMieRmsKbHSJTR7n9PS55KlmQ5ivEGiTLejf?=
 =?us-ascii?Q?VDp8Xop5pfJd0FOCGF3t8AxwjpOUWS0ZwMDc7MLEzAT4x3iYQMfm31fRF3bA?=
 =?us-ascii?Q?niCqYoOW6nsHXNMuKqgqLO8QN0PVaLlkbbqGlcRQcw8rd5I7ykx5Xiv3R5Fp?=
 =?us-ascii?Q?6jJUAhl6nSP+zF5Z72/qBLlHOCZjDHmTboMHEhkGR0sjHPt7DzL53LGmB1+X?=
 =?us-ascii?Q?tr7F6oUPzmRP3d2aK3YtpwetGaCJYL41snwujn/7nSmpeLAts6KvWhS5yHga?=
 =?us-ascii?Q?G4sz9GJgDSHLpOHeiPQTiaYSnG4Rn5aZpzYz32RAaQOolYlyQWCOAeG6ZVxO?=
 =?us-ascii?Q?rw2eSYS8kdZD7f2mXBUa6kLdbiDsZ/9Uy7vKoPS55js4hn2IZ6dAXXYRfgjn?=
 =?us-ascii?Q?/Lvq91/X4BSqaCRpW95YSyFTKPvzuzk+JX5/Yi8XNV9H+tHHOMwSWgbrZ4aY?=
 =?us-ascii?Q?07F873uGuYnmT3QcUIKINXG0+Rc7W721XwHl33u8zTEYGomJjbrCadsVH22L?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eead7932-903d-4a31-b9a6-08db7ccd8674
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 20:30:37.0481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qb7EzJo0cR+kP0CQ4V8Tg9lYgNNt8Qh9UKg7uv56jm7x2zOVn6know7eTbP+KWTLGp8hA3orqgZqvgn+Lyga0Xh+KgIbe5SPAZ8xWhfHJvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR13MB6508
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 10:14:47PM +0800, Wang Ming wrote:
> The device_for_each_child_node() loop in
> bgx_init_of_phy() function should have
> fwnode_handle_put() before break which could
> avoid resource leaks. 
> This patch could fix this bug.

Hi Wang Ming,

If this fixes a bug then it probably warrants a fixes tag.
And it should also probably be targeted at the next tree:

	[PATCH net v2] ...

If so, please allow 24h to elapse before posting v2.

Else it should be targeted at the net-next tree,
and posted after net-next reopens after July 10th:

	[PATCH net-next v2] ...

Also, looking at git history, I think a more appropriate subject prefix
would be 'net: thunderx: '

	[PATCH net v2] net: thunderx: ...

Link: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> index a317feb8d..dad32d36a 100644
> --- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> +++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> @@ -1478,8 +1478,10 @@ static int bgx_init_of_phy(struct bgx *bgx)
>  		 * cannot handle it, so exit the loop.
>  		 */
>  		node = to_of_node(fwn);
> -		if (!node)
> +		if (!node) {
> +			fwnode_handle_put(fwn);
>  			break;
> +		}
>  
>  		of_get_mac_address(node, bgx->lmac[lmac].mac);
>  
> @@ -1503,6 +1505,7 @@ static int bgx_init_of_phy(struct bgx *bgx)
>  		lmac++;
>  		if (lmac == bgx->max_lmac) {
>  			of_node_put(node);
> +			fwnode_handle_put(fwn);
>  			break;
>  		}
>  	}

Should this change also apply to the 'goto defer' case in the same loop?
If so, perhaps a more idiomatic approach of releasing resources
in a ladder of goto labels is appropriate. Something like this (untested!):

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index a317feb8decb..3091c96134e4 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1469,6 +1469,7 @@ static int bgx_init_of_phy(struct bgx *bgx)
 	struct fwnode_handle *fwn;
 	struct device_node *node = NULL;
 	u8 lmac = 0;
+	int err = 0;
 
 	device_for_each_child_node(&bgx->pdev->dev, fwn) {
 		struct phy_device *pd;
@@ -1479,7 +1480,7 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		 */
 		node = to_of_node(fwn);
 		if (!node)
-			break;
+			goto out_handle_put;
 
 		of_get_mac_address(node, bgx->lmac[lmac].mac);
 
@@ -1501,10 +1502,8 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		}
 
 		lmac++;
-		if (lmac == bgx->max_lmac) {
-			of_node_put(node);
-			break;
-		}
+		if (lmac == bgx->max_lmac)
+			goto out_node_put;
 	}
 	return 0;
 
@@ -1519,8 +1518,12 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		}
 		lmac--;
 	}
+	err = -EPROBE_DEFER;
+out_node_put:
 	of_node_put(node);
-	return -EPROBE_DEFER;
+out_handle_put:
+	fwnode_handle_put(fwn);
+	return err;
 }
 
 #else

-- 
pw-bot: changes-requested

