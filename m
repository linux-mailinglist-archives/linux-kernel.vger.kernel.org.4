Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F4A73DF72
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjFZMkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjFZMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:40:51 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2124.outbound.protection.outlook.com [40.107.220.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08707E60;
        Mon, 26 Jun 2023 05:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dO58HdrHJFcbl3sVmE8Z8UofB2VAbzCnhchJOlE9sLRwYORkT7ak9npEB/3EKeILuESidn+dbmt/KTrg7wenva+C2cVv8t66vErtiNpSOP+kFMhI/r+FjTYSGfE2NikpXcx8sUcbNghpCwnAf5qIUw/FFOvzZnIs2Ckqa+2jJXC2DTKsjVHzTudjhnUO6lqbKtg0/6J1fXPUUricjVRxIhr8Q5bAWw3AgBkgqTI12OlTGXBDIxMlHRZmnwsw3reQhrr1hq8XzLXFI37C5IRN/vctBuTU4RoA8FLvI1Z68ntU5KOFUorgOse5ejQQIrOiFsFN73YeYSwup9I5HXiw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4H7QIwQO4IJQ+pROlHCMt+fEDjW1SbhFcUK2sTU8qdw=;
 b=FR2v8nWV1UogvU50I7YsHHhp4AxCt2sHy7gx22EIFjIXvrQmDchEKibtLQdAsDsvEaysf2oUKNWWgXHeMEr5kxLra5kT5+7xpFjfkzXQMbLF/+eJWDrcRIfBEkiVd86BtI+a8v0ftYOG0Y67S8WfOhSTDPGkWJYd+7HmPe4JwZ0NqIb5TcTxwUtk1zIXyeF8tPEA3XMueCOjlYkd4mQIEF7ySMbE+9sJFB+zZWHO9OznYN+wZIlK/IcjvBHCBW/pfvWp1XUZ6HePw1ZaSRSnuFPZgZlH5FpOcVPpZjGylhtJGBBXeLXH9Yyhkvt2T74yCWBZ1z2AC3RRmyQUeivj4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4H7QIwQO4IJQ+pROlHCMt+fEDjW1SbhFcUK2sTU8qdw=;
 b=lvPsgS6orZXK7A5spkF8HMd/efNDd1k3jnCZxf73ldctmNj5LzYAZv2HSk2GWi+kxp4pbHD3gqnsQ56j+0g1qVMjG9jFmMMQkWxOOCUeOduwDHYTRaE2RMhI/eH7/0RWYOXHefYryVH0aDc/LYpcEG2RgOuURWZYGP4n28dQPqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB4877.namprd13.prod.outlook.com (2603:10b6:806:186::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 12:40:45 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 12:40:44 +0000
Date:   Mon, 26 Jun 2023 14:40:38 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     You Kangren <youkangren@vivo.com>
Cc:     Kalle Valo <kvalo@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "open list:RAYLINK/WEBGEAR 802.11 WIRELESS LAN DRIVER" 
        <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] wifi: ray_cs: Remove invalid conditional statements
Message-ID: <ZJmHRrd/erRQXZgD@corigine.com>
References: <20230626102752.1583-1-youkangren@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626102752.1583-1-youkangren@vivo.com>
X-ClientProxiedBy: AM0PR06CA0141.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::46) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB4877:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f53d6f-6ffb-4a5c-5e8c-08db76428f54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Xq3LK+M68McIxv3JCdvOIkf8+y16+xbqxqFWbUw6wgnfHwiYUKd5GNHCUQ4Qg07Y9mB6ECT0215Gw/XtwWLRjSjbIpLt/1vZCCCAR0S14rraOfZQ8kZjAAZNijtHGkJKfRvmg+EalqdvTToiofE/9lzbZ3KSvkxvjD3pf0GrIeSCpt0UMf87fijbEwUn+AsPajDyFId+sKKbnoOx4D0zmaiqBdFh10pVOs3S5hDiuJuTzmuhEnunmAvm5138cxDI04LSiUsphztFF7zmBCLZIjLvpowNwCXHqYb3xwr3FN8OKLllWUUMTCKPiunNPm8sLJTkXXHYtIlK09gs+SnteobE2MKmNoeSwujh3/ZFqrIynbH5Muakr3sNLFXX6LhjNXuS88GqFfbNX97eEleLgY4daR6Pm4BxTMApvUbndIHteE2LhkACwKIikb+/2iwyrzfERktxpzI1FivEkQI1iTLDDFNneUllZlLfribsR8djV2C9dLWD3zaEX7fUn8bNZ933bjv5vmFiEkMQna8DiIv3ojFbVmadnoGaSrMO437qK8QXCWs4+oohjNTgb1xkrKGeB48d4CdYT1xiTmhP3VavGvRgvTXYPPN3HshkVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39840400004)(396003)(376002)(136003)(366004)(451199021)(478600001)(6666004)(6486002)(54906003)(2616005)(83380400001)(186003)(6506007)(2906002)(5660300002)(44832011)(36756003)(38100700002)(4326008)(66946007)(316002)(86362001)(8936002)(8676002)(41300700001)(6916009)(66556008)(66476007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iPi9x70Qi0zGgW4mFIMn3PsiFFKe9I2KzqChyl31v1Ilwo46lRXlXkzChvBj?=
 =?us-ascii?Q?BY7FRmz+KTIdU+PcVKB15jlBp3ORSVwROVNRIDgPtfZFx1MO+pFPRECYognO?=
 =?us-ascii?Q?av1busezhGSINB41GHEsrptw231b2XWqD87jFq1Z3qYOqlogt9iPtd7rbBng?=
 =?us-ascii?Q?8dJV7ZXuSTGA7yiSa857il3NeoiZtFa18OTUr2HiUJILmVe0qRjVuUlDRZXe?=
 =?us-ascii?Q?wio1Yb7FnLJD+V+v2YGNn99RQZPyhGI0qYRtqwKNXeWJNgHsyFstit179pBQ?=
 =?us-ascii?Q?PH3TxbvJr/pva3a0SKjyqFBCZ6pLdlWuP+L0qbOdtyeC+0KCFrgzq6buAdVN?=
 =?us-ascii?Q?RK5rPVQe6XQK4FOIqD9pKGi6/8x+sVw+wVMzQbOPClb5PJPnjnYO23wCNJN7?=
 =?us-ascii?Q?d991MRFAARxmruxfS1aEogTxZQeSgtz0HZj672lGnxDEOYHPCNYctUf1LLt+?=
 =?us-ascii?Q?A8L+JCnLG22BuXBz0iTewDMpaWNSLP63tBlTRbJ4NsQqLAi/C7rhbVnWefXE?=
 =?us-ascii?Q?xwIwykF9+WN5HOYgloWUQmwKmKxQIBTFRM6Trnr84licS4bvV70U/o+dI0OM?=
 =?us-ascii?Q?EQ0Kxf55spjX71u1VV5O7sGaKPqQqiu0D+RRCBhlmtwP8ptC0FZXgJErf71l?=
 =?us-ascii?Q?HwHMAbLG5yBR6j1IKQkWmAgLj9vCTkH07cvVm1+74VYQHkQY816ml6AZ3NFR?=
 =?us-ascii?Q?dNrBbD9o84YX6oyblCUGTZqYOMeMcisaNl+rswIILsmym+XaND+NW6Yxa33c?=
 =?us-ascii?Q?tMqrayhY5niSAXMcDGfvUMcoXGSP8aN3kdEztiXZPHt2Z5UfeeZdxC6N2VdG?=
 =?us-ascii?Q?rdtpI68Mw6J1I2Q4Jb80B8oLqnxG/PYUM1I8EhA10A1UlhdXQgPQGUh9/yAJ?=
 =?us-ascii?Q?Ngr++YBa8d90eza5npoZN4J2xJ1UYq9/9+2eA6nn+njIQTC7mX1GSvplOMno?=
 =?us-ascii?Q?rxqVeL/BX06bthPSVkZRwRxjlv09w7lItDEk+2XBPFMT6HF4g4S+YQuUD1Am?=
 =?us-ascii?Q?wvts6KYC4FMiI2s4SN9w7StqJ8ZdF5kcHutO0cILm5uPeKQj1flK0fWrt4yt?=
 =?us-ascii?Q?2UMrrr53dfWwljfz5aPFPUoLkN9Chgh2Yg7OYYz/Y0elQskrfYyCA8XKOlhr?=
 =?us-ascii?Q?oCasdsD7yc13HS4vmSfd4xxTZEK0yFRMbXg85/6RCtUaSx0ztVEkgpPs1cMe?=
 =?us-ascii?Q?2qUC5j5QQXyD1Bnman4MOk3GBImOl9oVsRHLZPWb4AvVisSZzWtK5X/6TWOt?=
 =?us-ascii?Q?uhtrgcKSxrHtQTfwg/yhQNYCVH1rmRjP9ZcGsuQ6J9BJZMCHkQ2nC3YjvB1+?=
 =?us-ascii?Q?A6DN0nndO3ZATUFaCyyU9SvWICp3XGVoHwUG+Aln6/5PCnV31HhtHFoxEzTu?=
 =?us-ascii?Q?IPRieOIh9OhoFoTkU2qt9pch435H4E67LunjkRVk7KwCY+OgTZH7lChVR2pb?=
 =?us-ascii?Q?/KvCT0IU9K3B62f4t9Hh5WtdLgW/iIvhQdQQ9liLD4rmL8fP9S+nDX1LdoGo?=
 =?us-ascii?Q?813OdEcN2JmyCveuorozc7M5gpgBIlm61Jszn50QYwjrTdOdKnQ/rsXk+s9b?=
 =?us-ascii?Q?z+k90hfAmle20+02sSF08RJ4UbohOrdc+DVBegNnFX6gsXm0FC75aPDS4WYa?=
 =?us-ascii?Q?A9dOnSEuUEWURVj45Xfwoq+96nxsKhDpXr2Gar+kWHlA8Lg4oOn2DZDlKU6Z?=
 =?us-ascii?Q?0RY6uQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f53d6f-6ffb-4a5c-5e8c-08db76428f54
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 12:40:44.8574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TS7w3PJxx9sPpYD/H5kctmq3eAxWSAqbu094/dCvffJOva71iiedFcUEsv5V9MzCW/5mglWRJH3x15+maGRtToV30SewCC8CUD1EvfWquyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4877
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 06:27:50PM +0800, You Kangren wrote:
> Remove invalid conditional statements to make the code clean
>
> Signed-off-by: You Kangren <youkangren@vivo.com>
> ---
>  drivers/net/wireless/legacy/ray_cs.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/legacy/ray_cs.c b/drivers/net/wireless/legacy/ray_cs.c
> index 96f34d90f601..0022038b0758 100644
> --- a/drivers/net/wireless/legacy/ray_cs.c
> +++ b/drivers/net/wireless/legacy/ray_cs.c
> @@ -2116,7 +2116,6 @@ static void rx_data(struct net_device *dev, struct rcs __iomem *prcs,
>  #endif
> 
>         if (!sniffer) {
> -               if (translate) {
>  /* TBD length needs fixing for translated header */
>                         if (rx_len < (ETH_HLEN + RX_MAC_HEADER_LENGTH) ||
>                             rx_len >
> @@ -2126,18 +2125,6 @@ static void rx_data(struct net_device *dev, struct rcs __iomem *prcs,
>                                       "ray_cs invalid packet length %d received\n",
>                                       rx_len);
>                                 return;
> -                       }

Hi You Kangren,

Some minor nits from my side:

1. The indentation of the code is now wrong,
   it should be adjusted one tab-stop to the left.

2. The two remaining conditions can be collapsed,
   which leads to a further reduction in indentation.

3. Also, the indentation of the "TBD" comment was wrong before this patch,
   and is still wrong. So we can probably fix that while we are here.

I suggest folding in something like this (completely untested!).

diff --git a/drivers/net/wireless/legacy/ray_cs.c b/drivers/net/wireless/legacy/ray_cs.c
index f0bc7a06a257..f339927f1f56 100644
--- a/drivers/net/wireless/legacy/ray_cs.c
+++ b/drivers/net/wireless/legacy/ray_cs.c
@@ -2116,17 +2116,12 @@ static void rx_data(struct net_device *dev, struct rcs __iomem *prcs,
 	u_char linksrcaddr[ETH_ALEN];	/* Other end of the wireless link */
 #endif
 
-	if (!sniffer) {
-/* TBD length needs fixing for translated header */
-			if (rx_len < (ETH_HLEN + RX_MAC_HEADER_LENGTH) ||
-			    rx_len >
-			    (dev->mtu + RX_MAC_HEADER_LENGTH + ETH_HLEN +
-			     FCS_LEN)) {
-				pr_debug(
-				      "ray_cs invalid packet length %d received\n",
-				      rx_len);
-				return;
-		}
+	/* TBD length needs fixing for translated header */
+	if (!sniffer && (rx_len < (ETH_HLEN + RX_MAC_HEADER_LENGTH) ||
+		         rx_len > (dev->mtu + RX_MAC_HEADER_LENGTH +
+				   ETH_HLEN + FCS_LEN))) {
+		pr_debug("ray_cs invalid packet length %d received\n", rx_len);
+		return;
 	}
 	pr_debug("ray_cs rx_data packet\n");
 	/* If fragmented packet, verify sizes of fragments add up */
