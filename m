Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DC76226B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiKIJSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiKIJSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:18:44 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF66E9E;
        Wed,  9 Nov 2022 01:18:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W40hLNSnoR6YiLEEr03QVwvd47ZijtaMOQeEA2RLMHqYgkI686fcqcKC1P+sCMaNKz3L7ZQEmbX+ZfM2g763BAwsDjHpLGGJe1Vhhnj0nybogSiXl86QkEKAatiwTFksgulQRllgCbuYsvoI+nXE8Kizr1bg8GSBGfvaYxMRVCqlmdSjulsSJ+bIialW6hK0fQDXy2rtgnIiig+ZuofX8sop4H4tPvhiwX+p6n9iduB9QJ4QbpXA66Jg3pyFp3GRVuNOY8RTKnXkZ67Qj0WTPn7d7qmfvGVbGtWr7/s60Pmt+Z8KbRvE+iT66xzbXDp4ztNSIpE7TUzl2pDiINDGCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=douqyBZfv+Xl4nKT2Lbjlfb/uCap1z5I5kgFZXjnArI=;
 b=VroeNZ+KZhSIJToviWxozf/yuYVWg7sL0dnXXJ88gaOOiQCYQsru47JzM7aigJwbiTQaFs/W8ww0MhHRCN/r1PzJyZs6QM3/mKW8QbOuGvHwX4/3MGZjmNQi8PF44Zj2s9iZzbBIo7p/5ELFQce4XiDNmuMaOlshkyfU4/tQWxwJT7AYTOqUfypvSTdDHZks/WrP8SrfGLjDKpHCAhZztOp+j4Edyqt96TmKCgo057BFSHI8Qf/5bSuu+scUNgglzzfDFFOmjcqkZtjHf/8LUhu2LAZoxeIWhhDPefLfpBgNYUF76MJi1k+6ruDja7mn3wyy9VJD8Eij1j7MU09x7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=douqyBZfv+Xl4nKT2Lbjlfb/uCap1z5I5kgFZXjnArI=;
 b=elQ8UN7DloM1u1qRfA/w0asn7kvlFCGuf5FKmQkTwlOmk1jtOLFa46wkX0lpt1DfjRfYAGneaeXSmk58eZrziMbaIyxAI/BT7ZVjHotQFhknAky/C+77EN5CBgd285HdoRPmhQFHFRu7I4dXdhJSFTzTwntvvUBomXubVQNZxQ1nz3OEWvwDhl3ZXIuYABslYx5fLf66f93j03p7fpF9rIDRptaVZaP6klWVIm+eQYk3Kc0LH2OEGtm0uRde9WMILPiIsUAoe0R4RB1o+tAVwUBDeW2fnFi7o4o2j0GvBDtbL0YyXHABgtVTNzFn1flytzgEpKbEQGkUek9/+eESwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by PA4PR04MB7773.eurprd04.prod.outlook.com (2603:10a6:102:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Wed, 9 Nov
 2022 09:18:41 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::b7c1:3e11:9b46:28c9]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::b7c1:3e11:9b46:28c9%4]) with mapi id 15.20.5791.025; Wed, 9 Nov 2022
 09:18:41 +0000
Date:   Wed, 9 Nov 2022 17:18:25 +0800
From:   Chester Lin <clin@suse.com>
To:     Andrei Stefanescu <andrei.stefanescu@nxp.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        dl-S32 <S32@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Larisa Ileana Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Matthew Nunez <matthew.nunez@nxp.com>,
        Phu Luu An <phu.luuan@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Chester Lin <clin@suse.com>
Subject: Re: [PATCH 2/2] pinctrl: add NXP S32 SoC family support
Message-ID: <Y2twYZmlJRxynHwK@linux-8mug>
References: <20221031100843.14579-1-clin@suse.com>
 <20221031100843.14579-3-clin@suse.com>
 <AM9PR04MB8487C664E75EBA4D3678DD03E33F9@AM9PR04MB8487.eurprd04.prod.outlook.com>
 <d3905a85-4746-09e8-ecf9-b39757bf6d85@suse.de>
 <AM9PR04MB8487A41078460D1792CDA4DCE33E9@AM9PR04MB8487.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB8487A41078460D1792CDA4DCE33E9@AM9PR04MB8487.eurprd04.prod.outlook.com>
X-ClientProxiedBy: TYAPR01CA0226.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::22) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|PA4PR04MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 013ca8bd-a1c3-4dfe-7cb3-08dac2336463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ydY4M/cjo+tNRlq8WotsIvXQlPfZ8SYg8d2hLJIjx0mn30qF+upnUPu2f4iMsNjcP8g6lr1EpYHtMa0zOTY+mvh61ARh5t3WSyfQaD3OvZGwce8ZeaRKujWq1gVQR56j/lUGuXPH92wrDWevpyllksc/WasB1kKsQYuef34mjIELuS5GXRXSzuYPPmOR8gZrEtXDE69h5AvrFATfysf4bTmhhPlwoGEpzEIwX6/QWcucMoLaK01wuP3z59pVMcxeuNXF3jy+yF3uLu8NQ5jlhGV/HY0g/d7xeiQRo/2SQEuqArhpwFb5Yo/fDHdGwcwrBBhrG2aeJzCYiH31DqD6sStbKtTrhkhvKnFxKlkVcMEI3A1gfLyChacPsiSoBF0CYA7/d++mbHeTRMfbBEZPKNsl6jiNPAmyzMdEuOee89dc9fZYmVQWU4650cgpGCymi8aVXscTImFe/9G1cgeHFJC12JCMpCnj+SzKV6uShV70jayK7LhL+b6i7eSr6qaiwDclIicrvyGBtgOg0cEbslE/ep7HjcjkSBA+q+5hxFXWvAenTMRe/+LNtfZilan/JODd+D+NAq99IUWGVn545SO1IpXbVQGBVfVq4ddQ11dcC9hklKZBnlBDs6po0nJUYudSV9dxG8mxKHQvzNsbd6+ZjRPcdcAiYWQUldU7NkAkd7sQvreO2x/RfzXnIPNU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199015)(6486002)(478600001)(107886003)(6666004)(41300700001)(86362001)(54906003)(33716001)(6916009)(4326008)(2906002)(8676002)(66556008)(316002)(66476007)(66946007)(6512007)(9686003)(26005)(5660300002)(4744005)(7416002)(186003)(8936002)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VnchpE4j/hafiIntwCXNNUHBd7lVaN60jtnhk/1rT+OzWsFSi25ydPX2CqOz?=
 =?us-ascii?Q?IITxriawiuFEre0caz7aaFoucw85CXxAo7oTWx/i2Zrb1OvL8jwqHPKORsCW?=
 =?us-ascii?Q?Ayl+irF6++1v5ZEeZCGwqwJln3EeceZSZFAsuR1JTM2hGELzTBGLWBpcaplB?=
 =?us-ascii?Q?1waodx2F41YZLkij678zIDVTfZc6kweibGfghuTbw3KthJVMm8zukjJdcEtA?=
 =?us-ascii?Q?cxIbXByVQYD+huZxYE3Elq3+zDBQnXPJueIL6h+fp4pqHwo6RMNhvKT/+l29?=
 =?us-ascii?Q?KEWIlgzih5ASJ4Omk8NQX4lw6yzI1fx6mKT+SWlueYnSXHCUgit2Rd1Mzbkg?=
 =?us-ascii?Q?aWwaVIwb5hjdy2I7VtFLuwPT5x/zpMm29BUUa7UsIJ7IMjcqKZFUEJXEoTzr?=
 =?us-ascii?Q?xdXI33sh5NiAngdL0e6g1VTGhmuXgu2+0/whun9viAF41L2lzu9aNqt3jnE0?=
 =?us-ascii?Q?76NCa4MmQsXR15F7l7lGc6KssoAoJBzJkm7tjqGtZKotffgW3yVAlu+L8tbi?=
 =?us-ascii?Q?3SBVt67sQMy4VkSVWNwCTgRpbDr8fLq1Issvk9zBZuM4ZMeQT8Q+pFuCgbwe?=
 =?us-ascii?Q?UHnbnylH15jfzn0ezg6ClmxXRuwgEDWpNQIIFw2oEHOXbXcbAKB5ZQKFbVK2?=
 =?us-ascii?Q?HmuJYF6Osgo83Mwqh7yQ7q2fckQ9qoe2eZByzfADQpDDTh/6QF7XpnTAqvEt?=
 =?us-ascii?Q?e67q53l855pya844h/nIkg8H1Z9lToLcWN0oliE6llJUJjHpmIWg3t8ol7GO?=
 =?us-ascii?Q?+CsDgQVw+2JS7IjzEVcfta2b6hy2JWA7wcRXJ26iJ6WDjbQKaxZnhYSG9C0C?=
 =?us-ascii?Q?xQ0h2NzaipiXuSPb+aPisdT53GATnJc9vty5QuHWteuK/wzFqVctHv7i9hZb?=
 =?us-ascii?Q?BDJcfh+xGIcDdVYBvTGRG0FyfR0qK8Hn/Mls+AJ6szqnneCyYZhop6wnrUJC?=
 =?us-ascii?Q?GtdcRLSOVIatIxXFublQjqiNAqHZ+vSyQ2prjbIklOztkkSJid4RofWOq9Co?=
 =?us-ascii?Q?DfDOMCSl1NFW8Hlf0LS7mk9RqiUKaG+1LQhbsV4xoAk8oAs0svatQ432JUXq?=
 =?us-ascii?Q?tH6kft4NZVyzLrpCqojtaJD7TH25WDou+mgjh4yojSoAQ/bqiiNpRanjJHqu?=
 =?us-ascii?Q?5sElunx+CPB0VrnZUOlW3dfiOPPZRwV3YXezVdJdq5zJukXuwVvq8anzF558?=
 =?us-ascii?Q?HBtTAWyBSFpR0CZApWCWUiB6VVCOaZFPA6Ey/iO0Y5+zoGZpKydgf14V2CUH?=
 =?us-ascii?Q?IUxp2knicjqBdLA7tIXBYV0Z4cqm0UH/etiGs3HAAcnVU6DxJPFuksWi2KQv?=
 =?us-ascii?Q?iEdhTlJLoeH3epB9rhQ+ZNdAXa3JS6mIerSqvK37upyAs2Rs0S8kvI3YuRuC?=
 =?us-ascii?Q?XEukAMRjvtGdNnXbKED2RfzEOm2SJ7ErVTI7sEEPghvEV71KWNnjrXRKgFhn?=
 =?us-ascii?Q?E1+J4Ym4/iRJ5s6erWbU7YQcUZt5Mj35P+qDKU5I7BTvurp8kfPuIpsdmMJi?=
 =?us-ascii?Q?Yy3pwoUNm6cZClDH42qbWoGbdotsmJrcs6wM06QtSiDNFJCzlf8pVgQG8oAy?=
 =?us-ascii?Q?fdNrK3qLZG6Z4kTvhf0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013ca8bd-a1c3-4dfe-7cb3-08dac2336463
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 09:18:41.0958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8IF259NYY7P8z/uCLe8R0CTlCqLzQpk0YdaI+3ziEZnMvPuwNKbFzhfgrlzYQ0k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7773
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrei and Andreas,
On Wed, Nov 09, 2022 at 09:06:12AM +0000, Andrei Stefanescu wrote:
> Hi Chester and Andreas,
> 
> > @Andrei: Intentionally no (C) or (c) for Freescale? (column alignment)
> 
> I now see that all files in these patches have the (C) present. All NXP, Freescale Copyright statements should not have the (C) symbol present.
> 
> Thank you and best regards,
> Andrei
> 

Will fix in v2.

Thanks,
Chester
