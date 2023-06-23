Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2314C73B1B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjFWHbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjFWHbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:31:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2114.outbound.protection.outlook.com [40.107.220.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76CB19BF;
        Fri, 23 Jun 2023 00:31:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTPbuCwiaybkkt8wDzlPU2Xt644SWxGjp3i+P2ymfFQz+w1mYAalCuZ2Ny9bk45SpT5OK97oHx4DOgFZCiEVBgyBHsvej5cEO9VM2W84N5SsUu4Xxl1bxl0NBiQJOVvYKm+Yb2AO7Ua9jMXP6MVsXGmPrS5e1vHkf/jPjziigN3lo3fXG6+CoO+Oyio+NKtQGnZdOIBQlwdSTwo521pul5mavb75zDJQZ3DKmj0wiLIRP03ePa108ToqkLasbCty+M9bu3/906mDGTV5iayegfli0Ica9q/x7gZRKzjI58LQRrLi1bp0QIe5baWA7BobPJa8/Y6+d0XjLHhg5XG8og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Xr3v0/zgPMquinjdsIgXYyC7PBzNaSE1ok7BmfGdrM=;
 b=VGB8aLgFjFXlzWOaovXD+MZqLHBWdEdySG09kXH6HHVsqLS1L/ph2qatjM0YDJBw6AJO8w7ZXUySxDp/mJFuevjyJpWxNo0csSMxi8LZPH88ICsWVDLaBXO6PJncqxkewrecptQiSCbaMKGQeu8jiwdEy6kq4JNThWpoVKXfX/IqBIkx9FOKW4JX+u77jGDkWL9p5e7ov1DLUb5PoVJQQ5w11hNECVt2jCRRyn7BS3+o/rPlARy5BdoSYKUFVkwh9Pax/KLC4qcv5RYkRTFOmd8egU5ej2bXvmD8wkSFTA/XB8uGYV4bEGBi6R8KdbEc9Z15JoDUVgrExQ2IYAfsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Xr3v0/zgPMquinjdsIgXYyC7PBzNaSE1ok7BmfGdrM=;
 b=gLtzD6xcZZj0Nv3n5uLAXUTXbWUH5eiHLI05I3qjzmFiWS+5hxR/D0Bez9e/3CcJhhYqUmA3xZ3cq95nqv2VVXcXydTOOcX79a8LtqHxys/54aUdaBEa510dbscHO04+F5uRJIZ1F7eaHolehRe2KbubS54TO26VEHvaseWQEKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM6PR13MB3754.namprd13.prod.outlook.com (2603:10b6:5:24a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 07:31:17 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 07:31:17 +0000
Date:   Fri, 23 Jun 2023 09:31:10 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: broadcom: drop brcm_phy_setbits()
 and use phy_set_bits() instead
Message-ID: <ZJVKPuuSikoGGKOm@corigine.com>
References: <ZJRqMLepCTPqvCD9@corigine.com>
 <20230622184721.24368-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622184721.24368-1-giulio.benetti@benettiengineering.com>
X-ClientProxiedBy: AM0PR04CA0133.eurprd04.prod.outlook.com
 (2603:10a6:208:55::38) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM6PR13MB3754:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cdbfd77-1a13-40a7-d0f6-08db73bbd4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A8Jlas9Ib1rc+wNsA70XQ4IMBKS7BE7RAR3KC6JJGrfjyQB0cR7RmAsqQcov/dOQ7Acc9fTvvB1DvQvgDQjDelHDpRyRYd/61rxq4rOPkzoYY8dyCGB4iP4hGhVWobfzxay+hxttXg3O49nYZ0u0+uauCPnd4GGPXn0Tswg1ZlZ/JqjkDklmv2kQmtUhkoVZXSDrBuOWmJEtsbLBolMZ9CMc4hhF4UPpj+R/hfgrxjUYJQai8dEq9N7HjGxWeJkLq/cwBNYJ86JB7c+h/xQryZbew2pbXSubSc/koylbF2USc3vHtIXv36iWFcCDZ1MYfh8UeLKNDuY/eh7f+iCLe5m8jZHPAu7R/XqERUhNOFGzB2iNsKIVL/EhptYzL8bHgTEnUimj+H5urHuL2ZRdbBIH1FV2xrNobDHy/83HCg+eQKLWKYMnxLAvSntX+GFAwdfNG8In8HZ5Y5K+AbV0PazPFCzktVLFxHV3OY+5QI4SiK7mcQ5hR9BcseeyiCzNpdkxdq2+HX8tCuV7IQD78TLPy7qfP/D4V+THTetB791hwOCBpRPgzOKh/yachXbhpv3otLknFUsAh2ghhQhc86RO9jnEUYx9U9eW4ZNl6oE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39830400003)(136003)(346002)(396003)(451199021)(38100700002)(86362001)(316002)(2616005)(8676002)(6916009)(66556008)(66476007)(8936002)(41300700001)(4326008)(66946007)(44832011)(4744005)(7416002)(5660300002)(6506007)(6486002)(478600001)(6666004)(54906003)(83380400001)(6512007)(186003)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FVAecTMojzPrCh2kmFOeC9GobQC3GgUw4Ej1RKIKH+rOTN5YqwqSXCFar4TJ?=
 =?us-ascii?Q?4EnJj4L0M9Y9hfDKPTBvtOHEg46SPmIaYciTQ3Chz5dTywch230qAdrX516/?=
 =?us-ascii?Q?xG0Wby8ZTMMyik6x01qHAMCL9wFjH2v1qkF9Ieed/wF1c6Dr/BHzF2bOvznw?=
 =?us-ascii?Q?sro82tX/IgtnB7zQgRm1ndOqDqEpHCo+NMT8e2dhNjePFmosDh7V0sqisXZB?=
 =?us-ascii?Q?ejoaOdMDy5SF2/4wGP7z+5LfedmOy+LvXKo3P/Ub4TxW2XS/bvtxCHebWlP4?=
 =?us-ascii?Q?igw6d/b4Wv76Ge55FBWj/F7qj2q3tqBXf0XTJY+Zi19ONkWDmqxlk4U0BSxs?=
 =?us-ascii?Q?l+h4ewLYZs0x6xC6C5thYKtZ6FyYhJiI+M6viBbQAXkYHIT6WUA2YK9EnJWE?=
 =?us-ascii?Q?Im3GrLZEKXJg/5ywaNf+cwSCxFZn2aCTwhDcqecD6jlh0lR4IspReY98CwCU?=
 =?us-ascii?Q?Jtj/7KzttPXbsATrzO2ApknSpDg9ndbIWF0/Klj6YRqlwlx4DfrySI4MaQqU?=
 =?us-ascii?Q?UB92sszmKaSyMbZGRLoE3OjENJ1FNVN8ZX/FUDeb7biEX+yX9S/fNbBUZ6wu?=
 =?us-ascii?Q?9zDso6PFnWfNpfXCM1fK9uVcBGRoro8KxOh6Srlnfy4MM5rWEwZubeu7ppkZ?=
 =?us-ascii?Q?DM0k6tKHxCk7stkFnFwKd5wgjAzUgeIbtefKAazqy3GT+0E+CgwUw06Ler1o?=
 =?us-ascii?Q?i75/BDEdizPcqa2cBaLPcSIALYO4VMC7sOBOT2NJtOITsbJe+aqrBDTSh45M?=
 =?us-ascii?Q?fpAH06PmX2PEFQLUWahHjbGEzTVdDokRlt7VwfyQAisjvjca4jwhfks/VdB/?=
 =?us-ascii?Q?HeCj+uUVW4ejue4yTOL4wjbcEsU0iG4v6U7jRrp5fP+1wsk1KaExNdKSGlJc?=
 =?us-ascii?Q?lSHAW24Cr+6D/c30M9Qv63qVtx3+fLWfXHqRznZ7EPOgRCq1Dlkolti5EicM?=
 =?us-ascii?Q?8QSmIC+8Ibb88AaYYMaP8DTYbrEVldIaFKGhw24A+a8lkkNvi6SnE3rHVZtL?=
 =?us-ascii?Q?iroHC4l/U91mYnRtN7/TMmXP4Nh9tr46N2DuML3fryaGHrr3BImBZgWMTOg4?=
 =?us-ascii?Q?wPMBxAyzyd9iFdgt817ptsgSE63N/G+P8bUDs8Na3hTw6tLO3Zg7rp4WFApq?=
 =?us-ascii?Q?pv7iP2pNZ8si0VjYjwnMJoBdA08s02ArBkyy18sGqgJ0AYEfeybi87WwOYUU?=
 =?us-ascii?Q?Kon9RV9RT0ldT314glgBRNvzHkChlxejcv8w90peTb+9ueUA+AvGh+OmS0kn?=
 =?us-ascii?Q?twTlnxMZ/D9YNyS61dO16Go8ifqLoUtTfNEANEm4sjQhgC6ZtTYxl9jUvZSV?=
 =?us-ascii?Q?Ws7EhwqKGGMV6hHwKKY6plOsEwhKVc7FBOsCGwX2E0cvDpsQ8o7CV5tSELYG?=
 =?us-ascii?Q?vadteH4GK6qWHw5L0Vj6TRtmSn9M7AuLE/RnLQDkPySMwBp0j7kFn2ytKhEw?=
 =?us-ascii?Q?ZOcbBI48mG2NFE9R19F/OGxWPeWB9ITFTI21hjHimG7kWeJmzUrnOr7s7Z/b?=
 =?us-ascii?Q?uVJOswl0zRb47UNE80bHFxQyOV1IEWBNe2PUEVa+E/L2XCxAuzGb633MNxsZ?=
 =?us-ascii?Q?RlSY2WO+Ecjj2KHNa0UniSZuUKfMjtk/gbJScRmbrHpBwggRlUDtXiNYu3Qa?=
 =?us-ascii?Q?+fIimWZAGHAVp4gNP8MkYldZFlNxh1FSx9IrpJKmyUM91eK4+IwcELQPtuSu?=
 =?us-ascii?Q?4u6ZeA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdbfd77-1a13-40a7-d0f6-08db73bbd4ed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:31:17.2449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLGwKhouWE32zoPUsU7FNHOid1S7vPzsQvM+OTUa4q5pvHWblIdpe36SVHWLGWLBrxLOKHVy4+3qWXZk8pPJtvX9Fw+M/U5xlwXN91CNgWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3754
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 08:47:21PM +0200, Giulio Benetti wrote:
> Linux provides phy_set_bits() helper so let's drop brcm_phy_setbits() and
> use phy_set_bits() in its place.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
> V1->V2:
> * fix code style and add branch net-next to subject as suggested by Simon
>   Horman
> ---
>  drivers/net/phy/broadcom.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)

Reviewed-by: Simon Horman <simon.horman@corigine.com>

