Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F06F5BA0C8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiIOSUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiIOSTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:19:47 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0316EA0635;
        Thu, 15 Sep 2022 11:19:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vnl5ZnbVj6bGkCjUB6eapEphvambXbcEE4EngK7hF19dr2zWIo3j/4Tbafu/Z9Z9ho64vazlY5z3BSgtkIb4E22mZZ0C4ypr88c3Ci5KL2RmyjUgR7U8qLverPhJqYXiWrfVE2gQGFig0YQ66ajpYUKNWNxMpehzeg4rajbIJo/qBhFDnYtsSn8pzdLtR2Ns+8bWq9Qk03zB74+O/m87Ay7H8U9HiPngav8I7VgXXdv4NuItZngMsKPrssZ5w+fCvQeIy7b/zyMXXCiSCj4F9XK3OT2KQmqaQ8ebgozhREDaOXrJaaSDTNzKKHeYmy0bRiq+QsWU3k5Mll72C58A6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQOLIkqN0qfoGUGvhAaOSfDOGsp2vGkF73DniCiCueo=;
 b=kzx2VdamG0FsXShA3lhymPwzx6XaBwSo4H3SEPv7z46y/L3pf3A4TwPDUvZRjMC21sRWBmx8cb+2FmQzJI7dvjZcTkl6cvsKXIvMNV0z1uy8TBah44zhvOakHioBlwQRxKzu1+t9TBU5+Z1n0/NrueNUdpCmrYWDmnHg8IMjnulc5aDR4OCj+xRR0u9MhtI5+qpUK6Swjb5et6Kw3G2BwGIGwRs+t/wf8cI5cJqFtJxxtrLzIl2nrVQR89aA44/d9x+DOWO5EUrVJbEF5IpzQ5Jo8sSQaatWC7DBx0p+zlsxRj9eBBQgJIKKvdQHFBK47uSqE2+5ZN3sj4h/SHnzsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQOLIkqN0qfoGUGvhAaOSfDOGsp2vGkF73DniCiCueo=;
 b=EM/ciJAgJQlpF54qTTZDnSvpwWEWi4W8grWbDyER70k4B9aL3ObChvohaD9KrUD5yrWNen5OptmsUqJay69EMzINyfSNSqdA3NicI6FGPkOSCn35H26w8KvQdSgP35gxyj+XwYaOOKmjq66koaLPxNwsJdYYvvhFYLN9/eXQb14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by PA4PR04MB7998.eurprd04.prod.outlook.com (2603:10a6:102:c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 18:18:58 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::9466:d44b:804:72ef]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::9466:d44b:804:72ef%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 18:18:58 +0000
From:   "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viorel Suman <viorel.suman@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] sync SCFW defines with SCFW kit v1.13.0
Date:   Thu, 15 Sep 2022 21:18:03 +0300
Message-Id: <20220915181805.424670-1-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0284.eurprd07.prod.outlook.com
 (2603:10a6:800:130::12) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|PA4PR04MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f85dbf-5692-43c5-a099-08da9746c1e9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kg2q+WJdEo/Xe9tb1MzTgithoZe62GCrvW73Lq4ZFg0Ec3MPIH8WHiDbkcAdBOmIt8BoK/ptfpJQ36Bd+L2gW8r5LKRsD25yWVRStgEEFLJ76KpapykYmYH6mX5143pzSJ6XUlcPXBxcdAhmo8wSqnqXOO93zzOGdRNZpNeG7WJ+ypCfQkHlZpylc/ZRV9PiPkSC6WSN4tnPDDKnThWsN3kN0ihgHS9YEhXoHc7a/zPhmEq516IOsE7yx9vzhYt/cbNu+FNyyEt75QKaVDdZTvhhenHVIBzTCOmWPh4NC3kU5zmxih4a1WcvSx8kAYb9okYFwPEbNH1py92VpxC3LHJLhkqX1rkLry0Ijnod5rNndB26+mOin9GUPeByLou8Yy8/nEcC4GSTWBxD1PuUl0BYVvT0/c95j5OqMpNNuFGXxc8vLZ4ubCXd9Pq9Li6jIpvSjW/8ZZnhlI8WObVvOCSHiNvuC6AdTXn7wCokkTyupM/Txh6lO+Yk9mocw1QMSXGVdCv+qt/AXwut4btlyaWBrA7B0mWo3YFsjlCsY3uCL0DwYkhp4IECqB/TjaxCRCEsuhy0HtQVrMHQhVJk0Uvxw6j/aHQGd6/hiUR1e66hJb+hQa1nvcx5pv9SNUkBpWUh8heKvblANAXvRgkl7rbkR+vnkHbbeaYLlTKep0ZlwzfqX5rRhad1Lj6beFuxs8xa2rwgEo2DUz6zSr+QHQgjfX5Y+hJXxn94Ooq9zlGmolhTsZyLjcR5Lot0mtLA94W5DeJmvF1tyk1NpPls4aqA3MTcRJLHMNefKSBCEllfdaJhvthtAonwNHz5dzku
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199015)(5660300002)(8936002)(4744005)(2616005)(8676002)(966005)(2906002)(6666004)(921005)(316002)(66946007)(110136005)(41300700001)(6512007)(86362001)(66556008)(38350700002)(6486002)(66476007)(1076003)(6506007)(38100700002)(83380400001)(52116002)(186003)(26005)(478600001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?POouE0CjjWaZxOn0dbY+hhNc+fHE38fXqmitZWVtiyT55v0Ee+D/dgfOK5ii?=
 =?us-ascii?Q?PzsoMb2jdDQBwwUqy9wsGTH2mB7vFdEjnsAEzghiMDJ3ix8408jSBHYlqskV?=
 =?us-ascii?Q?dWlBNvsYm7rq99GiwYM0dWCIw7ep0lVX4OTdCnCXlFxmw4ipT+m7/6G18Awl?=
 =?us-ascii?Q?5pN1LZGWrJGIEl7RKwjh3wAQGw1pchnVucBK0b7uS4QxXCFNwXphqgJw6ZYd?=
 =?us-ascii?Q?oM9UxHTOsH2qeONtqmNKOLqpSVNY2iugsbOy8I68Fv0cuN2EVffiJMrxJcsj?=
 =?us-ascii?Q?p8dq/9kcAQ5JbCnwAXBF3c0ZuRT+t0dbeuH4PFrBDNtLVxYptTuAjgTHC+FG?=
 =?us-ascii?Q?Owg+kHkWShp68MrH4U1/txQMHrOiyb16Fc846gjs0oxUXVGHllG4Ik+xYMR+?=
 =?us-ascii?Q?Psw/PpTv4QqBCl1w+AFvrIPrxxUKphSUzmEuTDjxCK60OcoO3fSD1KEKdQxg?=
 =?us-ascii?Q?ceo6gWywzwfRm/IDvc0hZ9aqXpZWadewI9JDkvPfRK2PG4CylR48wBUzvD7S?=
 =?us-ascii?Q?gv188a7DIicDD9XbcSkDv8Z7qfZu/ApehjP1TZFMUpTq+ih0PUzMc5ntu/l7?=
 =?us-ascii?Q?H5gQLz6izFLezMNHunPn63fQDQ0At6LG0jB1rnMPU3U9eJATJMO2ILAL20VG?=
 =?us-ascii?Q?mUc1O6R89PneLQtJSDwxK8wWcwbSzqUqjg7ElU9AH45W/mbH+nLtKxgjtSIU?=
 =?us-ascii?Q?NkmU0iwOCjT0nvrFNP31ezt6ov1c8HtTMa0U16IarSn4BKvDX2QN/6M32m4e?=
 =?us-ascii?Q?F/XLlBNPogD0akhJmA+JMhwteD91Pqf8Oe7nr2NYQgUy3cYsakFLk2o0i23/?=
 =?us-ascii?Q?aYxPbTDoHjAojJK/EfPKzq9tBpLE+mk6Rb/zRdVhs378eqUG64NsqryS8Tfc?=
 =?us-ascii?Q?SuNQX0hyVzY6Km8xOL6cXk5RNiO84QYh74OkfjToWNRg6W7B190Tp9pS7+pd?=
 =?us-ascii?Q?5BqkMMQJBk+sFqAckjnUW32wqmr72xumHAhcBXHN5JBgS7SqTeKi7HaeneSd?=
 =?us-ascii?Q?GPLCtg4hjLpGuSGm2uOAiVsFU/wxCNOjdZkT1LH72BBFEjw2nofPqECGWHCP?=
 =?us-ascii?Q?Kbx5anZwnN7ufxpLTd60+45F16L6J0+8vI9FY4aeKMGsgWgPpFi9qEjmRZeM?=
 =?us-ascii?Q?/wbsEHLgvnCfVopn+3j4A8iPypmtjqDTGMLsxkoOlo61GdH2C4D/VpketsLS?=
 =?us-ascii?Q?zq+aPlC39yIpA7Zx5gsphajuFrOIB+o6JI4pO6gq37Iz4pZU9gowa01k4PMi?=
 =?us-ascii?Q?XQPiZN5iBr/y21Q/yjZ0RFYrranpOFmM0FhkWR23aDnHxQI6VyeZ/O/s6Alk?=
 =?us-ascii?Q?BSsCDwbjkob0gIWWDKjSxlkzKB0RlNm8vEZ7PhXE8VlYShcm8znAZxjov2ui?=
 =?us-ascii?Q?1qP+wpUj1UWh/sAfHk/d/5QqaU9OJcSSo+R/9n+8xTYt+T2Mw2/Qci6mjGz2?=
 =?us-ascii?Q?TmKEtnMIhaFfC+i4r8W/blFTgAj7BO5PlmF4OeMVm+lVeUMxe2SFn4SXAkyP?=
 =?us-ascii?Q?7CEDXyCx0xXCLi80DYkgDuEsC7GD8Zgdz1ccvATNhWuR6A9zcqrbrlsST0HK?=
 =?us-ascii?Q?fiYVt0DxlYA/OPuZLpqiW/tpEg8aymW3eFAVvKaPNddBhAEFgP4idj0qHQD2?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f85dbf-5692-43c5-a099-08da9746c1e9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 18:18:58.5821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2H3yYUEI5AzIvbHpuruFe/FOgchfC5ipRe8TW25+3iD6uH88Mc36i+mCBs5fm5tKDTDCsU1Tr+WNiiX67bIWiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7998
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

The latest available SCFW kit is version 1.13.0, may be found at the address below:
https://www.nxp.com/webapp/Download?colCode=L5.15.32_2.0.0_SCFWKIT-1.13.0&appType=license
The patchset updates the kernel defines so they are in sync with the latest SCFW kit.
"rsrc.h" patch include also the defines required for backward compatibility in the same
fashion as in SCFW kit.

ViorelSuman (2):
  dt-bindings: firmware: imx: sync with SCFW kit v1.13.0
  clk: imx8qm: sync with SCFW kit v1.13.0

 drivers/clk/imx/clk-imx8qm-rsrc.c       |   4 +-
 include/dt-bindings/firmware/imx/rsrc.h | 299 ++++++++++++++++--------
 2 files changed, 205 insertions(+), 98 deletions(-)

-- 
2.37.2

