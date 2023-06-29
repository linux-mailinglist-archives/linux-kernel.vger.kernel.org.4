Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08397426AB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjF2Mo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:44:26 -0400
Received: from mail-am6eur05on2050.outbound.protection.outlook.com ([40.107.22.50]:33564
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229459AbjF2MoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:44:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kO3P2hpTlCpWH67xnkwpVRmEVaC0TibhknfbyCprQMgtftQWzjRmfz0V+HIxHAq3ginVZJWjzE/28bkHHy4kz1tq339CBic1MNeZVPhSJrQa6m1qFXRzoouWe1bi6aaxFr9/EDc0PO7Pj/1yprU92DB/oqejCoZvPLoCaT/waacwPli6+V1LZcIlkVhZG0heyn5Ose0C6UtbJIVN7YyzIHtXJ5qGE4fukfWi5Qq+8PHMaaFhTLmFZLiQsrabVMX8U54nJnnCPP0r+9TrfJ/DEEBmh5bG+WKXnnLgMy1T5GWOHDFDSLW4+EhYmtwUTqYC4mhUjq66NBSTZKWry9wjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C079X1vjVe48mt3+JQkUydcFjcsoQMvyUx+yymL/Xnk=;
 b=frzb13oWu56FPgtesiEadNyKBsL404nOECkXCloNVqtQXM7g/gr9h9gq2mn+i2618CUVthc7KjULz90HCcLpgRCh+LQ6oG2eBNTekToM2FQbcRMOqNRwniS5spe6xMNKFnYKCuq7ahu3q/vKQa24GOEKechA1nt1lWFt7Btn0MNJW4dJxuZb3hTS3QBSQEtTsZPLSZpSX3blW2UCk/Q+JBysIGF/5Q96ZTAEUOX4OaEaIRR4Q5n+e3EEHYw9j49pxJ1szGi/Zi+qF+lF6UYgfLrxke6flntCnHdrx8nktokJW90C0XxU4sf5AmOF2TTH+TNUmgDJQdkEAknzqsBFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C079X1vjVe48mt3+JQkUydcFjcsoQMvyUx+yymL/Xnk=;
 b=dsGAdTccHhCk7qmPdbSbf41eKlJeKwGC2wiRmmPTMbPzoBO9/5kESniOpbpbdYZYy+XdG8BWJhXcnkqnDtZKUa4WNL2cAethUqdkUcCU9sLCppy1q+vJrRtACETPXG7YMzrpfWNiRI2Douxo1fqhyCFd6lqu13isSefCyFDX0mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB8978.eurprd04.prod.outlook.com (2603:10a6:20b:42d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 12:44:20 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.036; Thu, 29 Jun 2023
 12:44:20 +0000
Date:   Thu, 29 Jun 2023 15:44:17 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 1/2] net: dsa: sja1105: always enable the
 INCL_SRCPT option
Message-ID: <20230629124417.cl5dffdik73lw363@skbuf>
References: <20230627094207.3385231-1-vladimir.oltean@nxp.com>
 <20230627094207.3385231-2-vladimir.oltean@nxp.com>
 <f494387c8d55d9b1d5a3e88beedeeb448f2e6cc3.camel@redhat.com>
 <20230629101950.7s3kagwvkzlnu7ao@skbuf>
 <756bda986e5b9946e2035926dc0370d14138fd20.camel@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <756bda986e5b9946e2035926dc0370d14138fd20.camel@redhat.com>
X-ClientProxiedBy: FR2P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::9) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3d209c-bec4-42e0-62db-08db789e8f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3jWNs/YyYq2MJgSuYxRqwmen8kYa5Ol3OA8gn02JtYWocgrguLHH0hSEp+tDBjpOSIZrGO2DKs6Iwu+0W1dyzgoBSW9zaplFaE1q7Q8efwi6yukj5VnnLSo7w9JMhRHXy7pgr7WnM1mbI4JsC7x6o1Mi5MYZqyercDMXHykjZHYv165DGuFvu7muMRS6BADQx48dlAsyjwu1RMCEYU2KW38uEiXKfnmgw0WaqvY6k4Symodqqn1FTpUPSmJW9bRl8MF+TEdLdHARDccXn1K0Jxn/qWd+m/Og9IlpoWoyli5q/C8m6liiH1lxaE6xWEo5ZYydoBrCgdMUFkez6JA5eHBE49ZQnkVW35OmdUea/VddH0XtPCMTTLIEqhvbZzjo0hF6TTlDdVIVoyt55lRVLlbbFO2q2YbRRP/xPMyPT2Us5QEmeTuFsn3czfwQt6wMhDALtQ5G691ugAK/4b6tuXY31WoYoOiWzVf1yvK9GR5Xxm2q+l8h40pBq5T36DrZ6jtWaewmwDp8O4laXT+OvLYqsGjcB7QhLngiHUhCAUq0ze5G1wxrEx41ZK0YUZg2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(26005)(9686003)(4326008)(66476007)(66556008)(8936002)(6506007)(478600001)(1076003)(54906003)(186003)(2906002)(6666004)(6486002)(4744005)(44832011)(33716001)(6916009)(66946007)(5660300002)(38100700002)(86362001)(8676002)(316002)(41300700001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fbjd6Ry1bkg1fpE6gnh2qaxajHlcBP50fYpo/zilYLBcgQXCsHuNRXUZh165?=
 =?us-ascii?Q?OR8rQUoGm2ahfWvkvfFpNG9zpUDxmpgYpuJbcuI4WUmowWYYycSxdFv6awH1?=
 =?us-ascii?Q?3nisVMVyVPqcllS67Ob+bRKWERfCaJhSDlQuh5egxAkX1FPlk9mUvMTA7h6A?=
 =?us-ascii?Q?cZ4eRAJSPQ3qy76gJ8SA9moOrrU+BhAvO5lEjIGEe6aYfo9M6hsKvrbp1Utw?=
 =?us-ascii?Q?t46m9ZWJVrsd2qWLv18N4Z61ghXMHzbND3980PRAYvwb6jICYxG7dnLteDob?=
 =?us-ascii?Q?GlcOlHK5Q8Iai3L7QMboymSY0MTitcwFn8yzFNwZZKv4AVVDwPclVzyeEFsn?=
 =?us-ascii?Q?gN8zISmj1seLKmU1I+NOiSor6wNge4uUUefanQ2G0g2eTnQ6/ysKVx9TfTz4?=
 =?us-ascii?Q?PJOrrwbOmAqsg8+EKZk5z8qowluLG4krtskBczKOKr1dHw2pM1g/TGV5hMp1?=
 =?us-ascii?Q?la3ADBSk/HBNo4ifI7uCK/sAJd37X/DAOp5oZGGpEXowY3+2YqKK6X6mFlpy?=
 =?us-ascii?Q?XCXs6YGOaRcSI5KyBZGmcosol7dxeQ6kZ0MfpIvCTomjP+qmdntE1rQaxHJF?=
 =?us-ascii?Q?wnmN4ciAVIV2tWFysuF7FffhgeXMXrYCTgJnlERZYB3q9dVEG+Tbri1jPf0U?=
 =?us-ascii?Q?h/2RGoiuHn1RwqfZULJzIjjyNLunDamlR6eC5Zt5M3zcty0a04cah8qNierK?=
 =?us-ascii?Q?CI7zJePgYhoTizKAkNyFBpqqV29ofx1m7VKqQepg+AZezT7Z5PM4irazVc8P?=
 =?us-ascii?Q?qIs/Q54z4zomqrf6Ve96AQ6an41TOtNwIxMVcih73gPjU+jMfL7as9jR11Wp?=
 =?us-ascii?Q?jo8Jx9Vn15wERl64O98JGSlYS6bopGeAgS5qwwelTCB0uebGANQ4bh+nzXvG?=
 =?us-ascii?Q?Jv2+HZ5Dscpnf5Tu6zHWoJkx1agxQJ5WN4DHROK0AJ1KrlfXTNhCwgC6wGsX?=
 =?us-ascii?Q?1F/xI/eXFtpyglfGkwGsZ8cpERnVf9UexeYMIIwN0Pdxm1IeDNT1B0rbvxNv?=
 =?us-ascii?Q?X0u9Ri2d1QLryOB563gLyiC7yak8DsaT2l2AFNUueWnxN0KtLW8grPPSmoZo?=
 =?us-ascii?Q?nJMPZapds8w44kigI8Lz5DR/vOLXm//vYBnI21AO4r6TeRjQ+wBS4aSas91g?=
 =?us-ascii?Q?U5MPwItuvw70NccguAUglFAx5U0N8c63dupS/f3ivSo8LeoCaa2obUKvylta?=
 =?us-ascii?Q?loKMgb7dcUIl4i4lstcoVkmvgN5D02+vd8JlnCqiZBEkRkTbERL1qkHn7qwr?=
 =?us-ascii?Q?n/ZeUB/zWYyxMj15CvU1XMK1VS2nlzwiVeJrAwQu9eHM23D9agmO7AM/l4XS?=
 =?us-ascii?Q?3UxMvTvEG6f/crzzMJGdElQLfuaU8gEJk2aEefF8CeptPvwGLrpZ5b/ChjQG?=
 =?us-ascii?Q?X0eKOoHfXqfZ6GRO7A087oCSW7JWNDoS8ITcc4pPzHlO9V8XYhoK8oXYonXc?=
 =?us-ascii?Q?NzozyeAVUG/D2Yn2R/aY4L7gqZPHcePwTBEjSWKT3JvH/U9G/DNQUq0Xckvp?=
 =?us-ascii?Q?Ak1uI6Fena+d7wUxVQViIPJORsXZgeBWYooOgksphK9pyUMkmvZvgQ68N7Qp?=
 =?us-ascii?Q?i4Ma+1mZ92oEjfsdMZeeES14U8qk0EjnefbIHmok+QwqCXbhRlkjzsO3wo36?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3d209c-bec4-42e0-62db-08db789e8f09
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 12:44:20.4398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OpIrhAQuJJfeF6LSTHR+xTKObFSAw6yrp1ZiHuwEnQsEtJh6BRkf1nKt6doP+GuiXa7ZcAHJzv6UTzwRZL+dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8978
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 02:38:35PM +0200, Paolo Abeni wrote:
> [I'm mixing replies to your 2 emails here, I hope overall this is still
> human parsable ;) ]
> 
> Quickly skimming over the patch you shared I *think* it could be -net
> material, too. Given the mentioned lack of complains for the potential
> issue, I think it could be a follow-up to this series.
> 
> I'm applying it right now.
> 
> Thanks!
> 
> Paolo
>

Ok, I'll formally submit this third patch as a follow-up to net.git once
this 2-patch series gets applied, and see what feedback I get for it.
