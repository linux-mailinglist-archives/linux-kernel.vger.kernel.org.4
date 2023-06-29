Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E28F74295E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjF2PUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:20:10 -0400
Received: from mail-sn1nam02on2093.outbound.protection.outlook.com ([40.107.96.93]:47985
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232602AbjF2PT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:19:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArGY/r0GTZQ3ee8lMQDw27Hp5Rrs86+poODuLCTvhj2KVWzvpNLYXV8gf6ZdaZ2AOnqjPFe/J87IZcUM68K1jUZyLvL9hRrXCMcmYf9ugDH43dFZQWnr/+15RdP9mHLkpnkBa17QGsRLmYtnIBqvANveIh3bTLP7qd0iIp4H17GzYu+TRZkzV95ALy5aea5W13PQpGrBef1ApN3E7k1Hkq0FcI3hntrQV3M00v71kCmNNvxafncbuV+pQNvOB0MDcv3vXA2cyFpmJawbClm9zXtoEn8DC79+8WlABvu+rJzgKZPzSiT7DvFFn8ykfw0Z3ttXmOzEmI2TJYmLQRpHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSD7K0hG5WPyxAmkt56DEvgNbVcUTsdd11Tc8KlrzxE=;
 b=QrgraUJJAZair2oK/NUnW6MLnQpCshKfckYdXpSeg7Y/ex/NdH0erhB6/rr03rjuFYQZJYHSFnTolV/VIVSroHYhAePdZMtrU/i6rnSQiCLW7kuT9zQCNga5elwaeJXioyb9zVSvexsPLsC6J53CCNcLq/mpBW3PFEE3fn0G+BJpvRhmMKVvMLQm8S3EBXCnsOJNGCgNnKNHj2v7wBO/Euxi0aTQZj7bTZ4osYI2NwFj1kd5Mx3e+ciz1xhg6qFa3CY1UCPaMhpvztpBrkG9S073fwFu4BKFV45yeujh1xSMC+nWt6Sov03xs9whtgLppIMTRGTcp15EkkchMWUfIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSD7K0hG5WPyxAmkt56DEvgNbVcUTsdd11Tc8KlrzxE=;
 b=wNWvolu77ANw2e/K2omvS3Ozn5BH6PostUs6fx2LZhjkzk5KOFfXo/nbaKTnmGvJ8bYQOs/m1UhTu5p87FLVh4AzaCQRtChCt+XWPGP10gHAnVX8YBk8qOiZUPLYPf72zTMIS83dNZuS0i1nPK+9m2lb8Ag8ctodd+3/TcwSaOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO3PR13MB5671.namprd13.prod.outlook.com (2603:10b6:303:17a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 29 Jun
 2023 15:19:53 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 29 Jun 2023
 15:19:53 +0000
Date:   Thu, 29 Jun 2023 17:19:47 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v1 1/2] net/core: Make use of assign_bit() API
Message-ID: <ZJ2hE5sUnd86Nc0O@corigine.com>
References: <20230629132240.80372-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629132240.80372-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: AM4PR07CA0015.eurprd07.prod.outlook.com
 (2603:10a6:205:1::28) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO3PR13MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: b65405b8-a217-4d31-c339-08db78b449da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJVhO4YWEum2fJIiQGjKH9t2U9CxUgZ2qNdvirtR+8wLM0GgVA8tS4ceq4PCLGa275KGPlsSfvyumvnhuFA506SuMnXh53aLXo3HplVwLPtfpheFC1gvicL529oq2jw+Y7oPL+X9mWK2iHLwgsqHeJs5543FDHF+ILRiZpomWsyPzZe3PhzCEBCbBozxCtLuYi0zKel3a4OAnAJbcfNVnO1IjwCPL3hVWQgGX3kYP+nLvygbT2Ni0kre3Tn+4Ge60lMMjOuSsWH0PfxGD2fTr8fn8RRvHVNqcL58JnCf9yQwBvin14CavmDdHrjqMvT/SVPzEOZX6sKClwfzrC55uSwDcWYINkkCjJDY/oTtdpgb8q+HYtiIxMiPFuu5PV5DFVk1c80bZ3DO/lPB2LatENrCcYD47kM38ZnbauuUfwAbZJDa6v8JghuVg8FFFQ35Q/cNY0RrPDYr122adtoxJZu7eIRN/RXixxnVLvQ3WMzFUpuuX/HU+iAlxeE+3MAqbIvLUQbE/yVbZf4wWDIQN2SqiBXej46e1SUTyh+4OoOrkUbe7JrxjQBA52+32pXLL1AQJxflhkuHNwM983qtWhl/tSH0SUSdHN6kqRCPVDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39840400004)(376002)(136003)(451199021)(41300700001)(6512007)(966005)(316002)(83380400001)(86362001)(186003)(44832011)(6506007)(4744005)(2616005)(2906002)(38100700002)(5660300002)(36756003)(8676002)(8936002)(478600001)(54906003)(66946007)(66556008)(66476007)(4326008)(6916009)(6486002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PnoyKd8mkLybTYyMlhHTTcmliRh5kn/rE2hrfCk1VbZsOKrp/kV1gcAajk6X?=
 =?us-ascii?Q?5eA+lP+K0j1+VbZcuQEeqyhEG1W3FYLr7wzlti9Sm6eanjYBUESKDDp4x+OG?=
 =?us-ascii?Q?mlaJsK++Qjzs73CQ3l9Sk57hxxgKmr9mHU9zEtHLAnNO9lqAD05L8p+dO64N?=
 =?us-ascii?Q?Kn0Jn9hsqvZD1uN1rX33mqpGB6tzVOPf10DuMi2OEwP5cYcqQJQKuwwg6tfb?=
 =?us-ascii?Q?+wuCEk+T6zobdaMiG21iBoLiqpB4RVV0DABTOCtUQuLDTggoWH8brLNx5T76?=
 =?us-ascii?Q?lo3heeOd/xEpE6FIpVYDQTB9za8Z34uBMZBuwRiJhM88p5L376vPiq2c6KJf?=
 =?us-ascii?Q?b3tmQs5Xlrn0sUBbe9pFrfmSz1J02fae8EtigT/aJoG1F92PrXAgBpsDT38D?=
 =?us-ascii?Q?DCj7sAS8M/6W0dImO6HH4FVrWoSODzbVZXeGoxAKTHnYc1AM9xxMKeEG/lf5?=
 =?us-ascii?Q?E9kut9aqKUgFQ+bs06KhSzNPeb4IaLzI99w9+gM61Hi2z4fk5uzQMLhxAAyn?=
 =?us-ascii?Q?Vqh74PlLwmsAYv710hiEBLtDOM3Fp2fzx99CnWClMx5Nfk5Icih8TtX6zMIO?=
 =?us-ascii?Q?nhzbRBE43LGOqDQ5W428ddMKY73oIRZoZnlbJQjpwOcm1UZ94KoQa0Qnlnwl?=
 =?us-ascii?Q?qwgL9+VZRij3UiFTt5xOeJk4iw3X11oyPRSniGWBimDKJ0aWi/aSEd55wg/i?=
 =?us-ascii?Q?vax6rH8WyJ0pVc9ilSGBJ1m6bYFDANwNXxahf86fQhlHMUnft45zn7Uwg9OW?=
 =?us-ascii?Q?QQ3iIs//cJpHPlTE2DzSZr+XiE7h5kQRrk02x7jbOORwz9WVfKAowSm7A+dg?=
 =?us-ascii?Q?xcBlZIvrfByE4bUad1FYiUzifGMBAR7n5slDjsdsHzOsK/R1g4E/5VytOmP8?=
 =?us-ascii?Q?JPYM+/1IcUWuZFTEY0IRBS+ppC5DHydc5/ka19OTKz5W99GgjYV7zT2dIy/W?=
 =?us-ascii?Q?h+i3dI5vacSCIdUjyt1193whefkAy8qyPuO8y8VpioSOjQRkOL2HxyEFJs/v?=
 =?us-ascii?Q?xYHEnUkHpuCYBqNBSpDVS5sGBQ0Inovl1qFeKn1mzOY5FrGUzicwXAzzFe4j?=
 =?us-ascii?Q?VqVv5I3zHUa512z0xVsE5ZHVA9mBXps6+uxY41k+N+4wAMBnTdFR9Q1GRLzh?=
 =?us-ascii?Q?/O233nia2zHz/Cg9I6EfKKHw93Ho5tMiBdX84+usfm1gDei0UBtbS0CJ6ZUM?=
 =?us-ascii?Q?xqOJk9JocMB4dDdyHAMgnb+cfn62jYvqDb6Booa/myjTOI6a75PdDfB8nJGD?=
 =?us-ascii?Q?O3WNVyHfRzfM6dtfcsLwjbXJZqoef+pMn0S+CxrReiQzMajxh3iRkX4nxNAi?=
 =?us-ascii?Q?eELJ5kPCY0ZCPyqzoY5iHstH7hpPZC3Sis2K8Em8zoq0vkh1oyCRczo67D5d?=
 =?us-ascii?Q?QIVLZMBaf8ZkFw30xerb7QTZLK4floClk0QYKUdv4WMPhUteHboXZ7zsL8Ho?=
 =?us-ascii?Q?3hz4DdrN1LL/EExlGQ1wu5goqw4+egf/GEQDQg7gocPBmxkwYdY48ghWYh5Y?=
 =?us-ascii?Q?MHhiOzhBOQqJxzYzh+V/YU4049h0xXTBCYmN5Frsbzpp6RaGQLilkYznMhHN?=
 =?us-ascii?Q?WATZJ+QdI9sJ23mFadn00qvtwA+h2gTdKCNWydttTIfthhSKiJvntlJZelfJ?=
 =?us-ascii?Q?uRH/Mqw/vok5FKag6Eew1nJnFsMU2Qd105gWUIllfJNmc2zRF+yB7JC89DMU?=
 =?us-ascii?Q?kKmUOg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65405b8-a217-4d31-c339-08db78b449da
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 15:19:53.2988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLZjHYAd/ZzZPnZmWcp+2Z5gVYbrw5NO1REoKWRTdjS4W5ybcG4g1MIllqafRZZqpr4i6t5xMiChW7H+vVKXWYVbGMCprRWeIJlG+/Nd1gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR13MB5671
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 04:22:39PM +0300, Andy Shevchenko wrote:
> We have for some time the assign_bit() API to replace open coded
> 
> 	if (foo)
> 		set_bit(n, bar);
> 	else
> 		clear_bit(n, bar);
> 
> Use this API in the code. No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi Andy,

I'm assuming this is targeted at 'net-next', as opposed to 'net', which is
for fixes. In any case, the target tree should be included in the subject.

        Subject: [PATCH net-next v2] ...

If it is for net-next, then please repost when net-next reopens after July 10th.

Link: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

-- 
pw-bot: deferred

