Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E3A73C164
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 22:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjFWUvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 16:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjFWUvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 16:51:32 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F955359A;
        Fri, 23 Jun 2023 13:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAnQhmILrv9VUVvcOdJkwO3ocuJefP6AjvTxav3UXmdt4WEvDDDz1Pa8lqcrFm+wiy6CJBE2ZlI200UM+VIVuu1PIbUNg5lDv5kKRhb9R6hnNsH+bLb+i+wEvjMTTlt2fAyV2bwVC0IKhuGd8HY5ps3haXt4Rz+ISSE1z2lHrldr0rdV+/zGXfoUH0L5KQTlFMqLdu6niR25y2eTA6Vqa52oMXKpqihUiCaiJTXQFHG6ArbodE+K0AhTiphRRoQ1vDdiETVZB5W5R8wokKi00RDETHb0ze0Mb+hYsM7CvEmx07amvUqrUYk92Cz9ElMLreEsqRzCAgnFD3N3EHm9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBbHK03y5/n56zALIXxchMGeNM/a/Mh8nVR1d9RGVmU=;
 b=SA15kVY1GX/n9xNJATfJG9KK8Lf0vc+TloaYlIO8NbKu/zrQdyGA124D3uZ62V41c0rvReSZTpywykzKOKt4/sNFe4coeQ8k/JLeRsqfRxNboUcuTVnDePkRJiZmWJD75nedTBCJq/xkox27VmTypa1Drh4h5xQzM1nGJq3jtYkxBXdvFYhN4vLGSr1HNUghtp1DN9qNG4DxlFpsqvbwPWhag+/Ul1LIMd/sWjwM7cCjqYVnJZQ3NoTND+1kavYv8ysegBAYxqUsqRfEzJCuS6kcCfwyem7uD7v8Zmq2lvQxEb1ZZ1SBVBfSoLP8s2Zc7vLBXROENlJTejotvShW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBbHK03y5/n56zALIXxchMGeNM/a/Mh8nVR1d9RGVmU=;
 b=hUu/SQUVPwhXwAupVoQxw6jux1kkpWCscyT/qN9tJXdDbS5+/5bhE11TIxw7894j05YAilCh6Ft7vywg0zEQqqcdV1qYbLOoMNibQpB2HE5E/FLfOKLIbF2ol4Y/YHbVL8qf3oTfDs7i84CXsDOQb9tqVOjBKCeKisogI/0Q35Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO1PR13MB4871.namprd13.prod.outlook.com (2603:10b6:303:fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 20:48:24 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 20:48:23 +0000
Date:   Fri, 23 Jun 2023 22:48:13 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 10/10] net: mdio: support C45-over-C22 when
 probed via OF
Message-ID: <ZJYFDcbZqI+EC3OX@corigine.com>
References: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
 <20230620-feature-c45-over-c22-v2-10-def0ab9ccee2@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-feature-c45-over-c22-v2-10-def0ab9ccee2@kernel.org>
X-ClientProxiedBy: AM0PR06CA0082.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::23) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO1PR13MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: 95895b6f-f154-425c-9cc9-08db742b2f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FiqyXjZtb3KviAiMqkJKiccNNYcwbfp4YrxVamf9B6csGSsMrCZvpRcIaNS+9ICz+esq77B3XSlfRgBp00Sy0hx+XG9aYwQs78ELRU/gTA87REXz7NG/Hgve0EDNZ6Ls0pDYCqeOlnuKrpw5Wmtki971iJ43XlWjm0Bm39Gch8AuaXVADTiAHBDMB5H1SQ35KaTS9+runBLuoQjFL0yjbJrsFbLV2Rij8iLYgwtdWecLor2hHQcj0JNwSJ5WisazHQhrqe/akK3yloeGjqCnJAW3AAjABDYUJzLRX75NPxfkXvmo5eqfYIn6ciNOFIssXScM0U1s1f8OfD+XGdA50/PKTu2NlkVmmtOaAxSaU/z74LyWRiFJpAT4F9U4yb1L3Fra70vKCHR93WHMakQ81l3dyMKP1QLJ7YMbNsb8D1pz23Tkbgd1I2knuj4aCRYRchqnFykF6T8d8sp72R7VdvOcqOAF/GwKmxJGbfsaD75HWA6YrBRZqyyj33MUp4YgGc3iJ5tafpII5JOxGXhH6QOquCCSxZ/um92gJwBP4HjRkH733s3Cd1GCix/bXAsN9/sySMZQop6MMoFSmoFRPedUeh3jBptdaSUYu+FI8+iN34ZU1V1WSCIQTHxmdM/ZKwhp1ZhjgHYuvu4kCm5+os5v8bjRt5gTWv275/SqVKs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39840400004)(136003)(376002)(346002)(396003)(451199021)(6486002)(6666004)(38100700002)(86362001)(2616005)(186003)(6512007)(6506007)(36756003)(83380400001)(8936002)(8676002)(2906002)(7416002)(6916009)(316002)(4326008)(41300700001)(66556008)(66946007)(66476007)(478600001)(54906003)(44832011)(5660300002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8QeIgqZlWKngej9li8bb5VKzu55fdDyKksJqck6f7HEmPhccpPXiwJarlQf+?=
 =?us-ascii?Q?eOjsYQQp9h9rjGmBDgUFaye0vHK7y/UgwR7AkP9bWfYWNJkJ506uVsmUVFTw?=
 =?us-ascii?Q?CEegY/QDCrPPkKyePV4yZj5pNEo3PrPkYJFYdue0R7Z3ygd+DCfxoFyWHcy/?=
 =?us-ascii?Q?8HZITNziU/hyvJNnFlVojc3Z0Qkhv3mDU5AznHqfEP9T+QYjS15wH0oiV1iV?=
 =?us-ascii?Q?ZJHtVIqHQI6aOCe4nTxDEZdMQCQPTCOg3ZjeUtcpKdr5u2+7Jn6ahQGOsx+3?=
 =?us-ascii?Q?xHoz9GP8KHgIlFrMU64RlQV+Z9LBIo/9P/rjGk9DL54aIcB6A6f792VnFEgV?=
 =?us-ascii?Q?WkqHu065okPdhGoFcf5sQzS/N1L0e6E9Gljfesuo2kA08sYVS9qph0imrC9q?=
 =?us-ascii?Q?okGXIhFmdhZYbcuNUsvwXuubkOt3YWq9SfEE8yKNGdYFNVvT3QXL1gCi1S/P?=
 =?us-ascii?Q?ZQyY3A8gup4ibB9mI+EjmqrcDZR4fwLNBzEQfneCnmGv3x+NsbGE3j/1PbZx?=
 =?us-ascii?Q?JCTLkaq6KfhwXQIbp/7anpeEsWC2HCE8nVLlNn2/lawyqsHED2LfpCDbUvVh?=
 =?us-ascii?Q?VWzIy9FbYcATgWqnzvvhkwbaqfyXy1FUeIBxBmOxQzT4nm42uvpaBq0t8a8h?=
 =?us-ascii?Q?NY94sjf5Qeh6df2WtLm9bYX+t53dMFgwb/eoZhVbi6Elx07PJqmIsl2D2oPe?=
 =?us-ascii?Q?xGsVqQ2pQ/BsLLh41wwUugPZkijCkw0kwWedRs431iVH7SGmprO3+SlPjYde?=
 =?us-ascii?Q?5HgoowFqV0hNY77e/nbmhgN55eck9vtEQpzmeiDN5BpD3nkRcg0JBUxG8bRl?=
 =?us-ascii?Q?Qqx4FQNSYVWtBU8If7BjCtymEbw0d1i7EERy8+HndUDTbK+ny7gk38L+wkXj?=
 =?us-ascii?Q?9yhSrzcl+I9B4JINxHObGbF8kB9qW9dIA6369GkLVAB+E3obFRMHwxAXpZr9?=
 =?us-ascii?Q?ovCSvI7rPDcVhxTldohb4Z739SeoCgUKt1ecmukn56wCXQA6MkttXJ04yKTG?=
 =?us-ascii?Q?Ucx5MVw8f5zsERft+tz+Cz6XFJiBloz606foNuMQOdLCpSrW9JR8rNUrrSJJ?=
 =?us-ascii?Q?nOCqQI/riOJ5CqzjETQ09hMYjkFsSKpWYG42i4Bs1kkVJL6RORyslUiktea4?=
 =?us-ascii?Q?+zUZQ3v41pHqmxcsvF8d0fKkRjJWv0Gs/r2JSoXz5YANhlgx3Tc4dy9pbZXN?=
 =?us-ascii?Q?liYbyR9JgH6ZmaC/dpZOOQdrIiIFxgQlIGz3Cu+knRJmXd7A/g7p/JKZ4R3Y?=
 =?us-ascii?Q?hF66HI7+I+wUyuhNzheKKfNuCvKfQT47JZajWb4QwFCl9McxMX0yGAr8Aj0l?=
 =?us-ascii?Q?Fbsi6suIQFVeyWBbdLn3e1eMho3tuUgYJ6tFJD0XHQ+7NpjTvQDL4o+Lqf/S?=
 =?us-ascii?Q?FbflrMs5faEVDv6M3APNfnk50EJS6I+0LXQp4kxZzS2T6Brhjf+xjUi+Uu1w?=
 =?us-ascii?Q?LoMRthPtf+Q4DHs6EKLKgcL4n1RPlc3oaicbO4GWehwLu4peF/olLgpTLlwp?=
 =?us-ascii?Q?r/tVLDdYhwyrLbIkXTsWsvsiyhsZv9HH+jw2E7k3y2sMcao/2IxgmEoQEP/t?=
 =?us-ascii?Q?vXFM/1kLep0p2st3+UmFjMG+Qdqdw2iY0m3hCQMexhsa33l7mG6PoCvorm/D?=
 =?us-ascii?Q?rrJbhNBwPQL3J4n7IYiTWeSg8DI+mDFiJ8hjfOxQ0Ain/ZePLGsQxSSYeG4e?=
 =?us-ascii?Q?jLtcnQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95895b6f-f154-425c-9cc9-08db742b2f5a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 20:48:23.0998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8AMw+ZOshTiGjOpeG0VfG0qtAGvklwYx6Wo2TVpD0Lr3Dbps8hhRus1lCNRWeTgoBcMvgnyMUeFGtw/jzPouczH+55wHL/jtfJizLhYxck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB4871
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 12:29:19PM +0200, Michael Walle wrote:

...

> @@ -178,24 +209,26 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
>  	if (rc)
>  		return rc;
>  
> -	/* Loop over the child nodes and register a phy_device for each phy */
> +	/* Loop over the child nodes, skipping C45 PHYs so we can scan for
> +	 * broken C22 PHYs. The C45 PHYs will be registered afterwards.
> +	 */
>  	for_each_available_child_of_node(np, child) {
> -		addr = of_mdio_parse_addr(&mdio->dev, child);
> -		if (addr < 0) {
> -			scanphys = true;
> +		if (of_mdiobus_child_is_c45_phy(child))
>  			continue;
> -		}
> +		rc = of_mdiobus_register_child(mdio, child, &scanphys);
> +		if (rc)
> +			goto unregister;
> +	}
>  
> -		if (of_mdiobus_child_is_phy(child))
> -			rc = of_mdiobus_register_phy(mdio, child, addr);
> -		else
> -			rc = of_mdiobus_register_device(mdio, child, addr);
> +	/* Some C22 PHYs are broken with C45 transactions. */
> +	mdiobus_scan_for_broken_c45_access(mdio);

Hi Michael,

Unfortunately this seems to cause a build fauilure
for x86_64 allmodconfig.

ERROR: modpost: "mdiobus_scan_for_broken_c45_access" [drivers/net/mdio/of_mdio.ko] undefined!

-- 
pw-bot: changes-requested

