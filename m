Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B80F7456A1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjGCIAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjGCIAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:00:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B576E40;
        Mon,  3 Jul 2023 01:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEQa5sj6P93Bd5HDxfxpKzplmPE1wcgxMy/2rBWFtiuYYTizePXRmcayabd8LPD538wW8qnzml1Ltrz2H8Fynh2bRtXteV75wZYMlkad89nrqmqenxhiM6lHrw+J+AwD7JpZPV2wyGcSmva76MR8wxU6/u+m9fLgLYQJKmyCZk1CmS3nyksuV6WsGDnXIeBoscnuxsDjiLdOfi4VKnQ3jWnBBxmmVWSy17ltrA8YZgeVE+7K2uryLKcqErGRhoY6lzDycgWaYPCoBK/ITOdj8ufFyhTGJuhRJ3U945YR2prCmLyA1vxyvS2IrofZIFFBBM3/P/ZbRrkXg22WmdCk6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzP8j7FqKxWCkjQov6LxVw8G6n34G9OH4AN7593wq1M=;
 b=cA12c85zTRdNXtKfdUiAVgbKK6dEU/Iegvt6FD7YPS1j1MLSpQzJiJQZS8ygVlK96gT1WnSkrJI4/PtsRhUv9KPUnO/9tob6GTWePVFv8Sz3Z/rs2GEsJpg06unHyagdzXc4pHdKX39ymtukrkF+fQtrw00GOcSQdk9txsaO+u2RMQTIVDGBvEazuRVYg3MhtKAII7yH//OSR7QtL43HRirp+sxW9+r7Pi3YBubOC2mPp0jebZp3ganNa2vywzOG+n0pSAVe4/M5F4F2HXvgiYRvmhuImus+JCfvRCno7/AovZ3ty3jPr44DA+zb3RLJQjhMmtHjAeinNFu+elaUgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzP8j7FqKxWCkjQov6LxVw8G6n34G9OH4AN7593wq1M=;
 b=tTnqXIiU4bj4cKTcs6tkzF08W3KD+hgcEO8TGzkMO4b7634y/OtmPtj9vsMMrY4JuvDpRHZGzEgY4jap2C3XtLE184iGAWYl31hw8+8+q+abOuIBzFSQQzE3AjavrNTPHBjcYwDMF3Qk39tCDHe7qQaTF0OoLoy/R9AGvm4VvdoKW2a6Kl61mbZvPnB4ZHmVRs4nelboyN/TNFn+BG4nvYrHzLnrupjWAwfYAoNbpNRP65w38PhWDa9zK5aBgPuSywNGjaMp75EBV3JB9d9NbVb7bRcRkD5g64aNbTkfWgLeqtyfwg9FaEuz+Cd82h/43Ee8/TooHpBEn+UoMSgF0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SJ0PR12MB8168.namprd12.prod.outlook.com (2603:10b6:a03:4e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Mon, 3 Jul
 2023 08:00:21 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::66d8:40d2:14ed:7697]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::66d8:40d2:14ed:7697%5]) with mapi id 15.20.6500.045; Mon, 3 Jul 2023
 08:00:21 +0000
Date:   Mon, 3 Jul 2023 11:00:14 +0300
From:   Ido Schimmel <idosch@nvidia.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vlad Yasevich <vyasevic@redhat.com>,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: keep ports without IFF_UNICAST_FLT in
 BR_PROMISC mode
Message-ID: <ZKKADtxlXyPmBvbr@shredder>
References: <20230630164118.1526679-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630164118.1526679-1-vladimir.oltean@nxp.com>
X-ClientProxiedBy: LO4P265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::19) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SJ0PR12MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: a33c7162-b68f-44c9-20ce-08db7b9b8c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QKQOtGLev6AHpKi/NCfZJ1JoF9/52n+eCgUKDwd+oP6rsYMyimGscspTlmWtY5lDHhFxx4Mgcjd5RtXHnCvTh8Ix3fWxlu2ivenr0TCtN2tehxNG50tWbPFzbbuh/3MNib4sMHja8OCTNpU2H2RWPq2Uy/UeHe3d94jFtWrLocQWMsajT+sgWMDbKylpQ0444PwJmUnrD1ZW9jX6oyUN6JZiRBpFG6AD9jeuSqPj4tWQbJmdQRw5HPtlW5vvxkVjmRrU7K01ls1UlgsM6M5pUslL/+Nq7DE964/gjXOkf7si2c9/JPLbTuCWWsavysraMNkVB+WqTZc/vB/QM73Vqwj0AXwiHFnk4QlveIPbY9tIA4dhg7ks7VxrfGjDmzgePDWfQci2Kh5aGcFcGjqInH1MTiIYb6A7K+DJZx73TazM9OkhMUhjzo3/vBiXvpV0SfS0k81SGbP3Di190H1ifRStIzvZAi6mL6+oKy+NNb+nPd7Cdld+rsB5KxX04bgJyRIa/llF1NMd3ra6qCSg2XdclSEMTYBXrzo5XQh0Od5v/K1bG4vEFKpRv50mR2RY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(6486002)(478600001)(6666004)(33716001)(26005)(186003)(9686003)(6512007)(6506007)(38100700002)(86362001)(6916009)(4326008)(66556008)(66476007)(66946007)(316002)(2906002)(5660300002)(7416002)(8936002)(8676002)(41300700001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QUJ6s0bOJx+hCQpPpCIgB5rZgXxMjeesXnn6hQ/fWAQX8RLoLFNz8fDUVeN6?=
 =?us-ascii?Q?MyIZswLQ0/yJdzPpEd+APR+kG1jxITJCsxPhE4V1WsQwuxclYwPZ8xxt1ftz?=
 =?us-ascii?Q?JtNIz2qM9SeGqT9RGVfkUBSX/vyuXJOG0w75x9SvOksloLe+3EptFT2sHa0c?=
 =?us-ascii?Q?Rf44Q5eaxPo3L5L3YSHO0OgczSUX5uou94TEZnZZGPbb86AurUaqdsLUlYrh?=
 =?us-ascii?Q?9dpF8m7fVlWL1OzRRUXjQADF1Xb7BBjP5ikkC4xh2ts4yGNccRcPwLDMiE3R?=
 =?us-ascii?Q?ONr5mz0XYI/fpXiXhv/Q6mBK9wzKC4iH4m7Rxzwq1gAbUvnXuPF0SXg0GRvN?=
 =?us-ascii?Q?WbCIGd6pyQ0/cESKyOmbLjwtwS7XVGxCKSr7YtawAkXadVZsUoUbh+pbKvmk?=
 =?us-ascii?Q?hEtmzLQIyC8JI8wXQZjFDRMoXt+MwxK1xGB+6vraGrQq+m9aYXaNDNH8pfpM?=
 =?us-ascii?Q?/oVjsyk0RQ+B+wI8X17Ct2EBkseghWqT7+WaaVRSH1T8JxxTxzzAFYEO6Y3s?=
 =?us-ascii?Q?LPP/ZWr60UWcUA6VvLgcf1uSOFxPCWGlfJIsxWW6A7cNnL/LRfQQ7dOvzikZ?=
 =?us-ascii?Q?Ej02mPOVduRZBbLF07bFB0/wwPwR279PS8ggt8+mJR2JC+cmmux7vW6ruDca?=
 =?us-ascii?Q?bJF2DH9cHzy2gWJVVyOLnK+JiDK/xwAOKgUap9XqrV1TFgiMER6Eve/AeL4d?=
 =?us-ascii?Q?CiYqE8xPFAsDBiQqmcaJZ5eXF4gCedk2l98C6JESBGRe2zkwkM7V3Qt93Bj3?=
 =?us-ascii?Q?BiFjgkGUE13sYXeWF8yJ2TNaNEuZmAWa5Jl9mUhvZxv55jxmmV41/icFgA1w?=
 =?us-ascii?Q?NXOcmYxnVZipcqcCFIa9FHhXR5GoYt3qbjEyfHwqgOHu+yBmChMSoDXR8wRg?=
 =?us-ascii?Q?OGKgdo9r7n4anggw5GlqFfiyqF/RD9M+vsNONOjFF5GtMiE1iMvZiFIY9Osv?=
 =?us-ascii?Q?UycfVl9NE3tRe3zcih4ImGuvD9IWF5wm8E4/2OwcyfLNm5rjUD0HIhqU2iL+?=
 =?us-ascii?Q?FG1NDGIlQXyCsL3xnwtj2ng/+0JHIitGmeK4/ugqY/YOtleLl4lfA6odWN0X?=
 =?us-ascii?Q?+IlLtBF/MNgWlxBhd/bDRzOapT3uykRoiRT3iTpawUSu5EVxZ445+jfC3PDg?=
 =?us-ascii?Q?4hhl0pjCvHvDAEIV72koDZhQYhoB9b/c57+eaX6JlROVvxOKVrOfnIxmOI9a?=
 =?us-ascii?Q?azmfbqjvPdlx4q14mps8v+58dXWmXfc+7HwD/+amdQzl2NmZcaS4tLDs6ygZ?=
 =?us-ascii?Q?RtzTyjxi7V2R54pnSjFtUpOXKlRd02IFBskHAB4zQ7Ha6EFLArgShaHPG9X9?=
 =?us-ascii?Q?SO7sdj5IYbqWWrHFIoXSAa3qtv9iBsXGAbfXdzX6TkT+C/yR+I67Pt7siUP5?=
 =?us-ascii?Q?6mgjDVJn4nX5zxIeMeD4z3ZFItIZbtJoefSkldO2xUa3EnjBOc9iRUttAMai?=
 =?us-ascii?Q?vMsYc2+czdlkEKGTrgcylX/QrbvIv61uXrtneq1tZZCxC/I2RCg/AGnbqsA9?=
 =?us-ascii?Q?PNEsbyAuKsId/3DUz+mibmXdeJ+1C/O13SuCMJWWxgzneHbjKh9bXfSxxDWz?=
 =?us-ascii?Q?vK0imZm04pwU9BTei5R5z4EYevexAITXIxBWORTJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33c7162-b68f-44c9-20ce-08db7b9b8c55
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 08:00:21.1222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uF8RrmWH7UpsYtxhfVjHV8bDDf0nbMhPnvMzN2PUgG6U4KhvIhErIRmeW+78O3o0mMAXHXNYLtl3LKV4RB/xWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8168
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 07:41:18PM +0300, Vladimir Oltean wrote:
> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index 3f04b40f6056..2450690f98cf 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -166,8 +166,9 @@ void br_manage_promisc(struct net_bridge *br)
>  			 * This lets us disable promiscuous mode and write
>  			 * this config to hw.
>  			 */
> -			if (br->auto_cnt == 0 ||
> -			    (br->auto_cnt == 1 && br_auto_port(p)))
> +			if ((p->dev->priv_flags & IFF_UNICAST_FLT) &&
> +			    (br->auto_cnt == 0 ||
> +			     (br->auto_cnt == 1 && br_auto_port(p))))
>  				br_port_clear_promisc(p);
>  			else
>  				br_port_set_promisc(p);

IIUC, you are basically saying "If the port does not support unicast
filtering, then set it to promiscuous mode right away instead of waiting
for the addition of the first FDB entry to trigger it."

If so, LGTM.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Tested using [1].

Before:

# ~/tmp/promisc_repo.sh 
0

After:

# ~/tmp/promisc_repo.sh 
1

[1]
#!/bin/bash

ip link add name swp1 type dummy
ip link add name br1 type bridge vlan_filtering 1
ip link set dev swp1 master br1
ip -d -j -p link show dev swp1 | jq '.[]["promiscuity"]'
