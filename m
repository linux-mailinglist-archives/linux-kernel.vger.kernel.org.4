Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521A8737122
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjFTQES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjFTQEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:04:16 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2103.outbound.protection.outlook.com [40.107.95.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B876DE6E;
        Tue, 20 Jun 2023 09:04:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkK6wYznSczdWQsyat5DKwT64n98LJa3qIcK/L8609agp2FiQF7qP7YEuVqADCVFfxqMTPUEllX2C0uAifILDclZN5GLqP1xsNZRjWSAuR6ZidDRURtMqUutFmu0G1bZdSe/9by1Li1aI1iFN7v6en+PqRd7CkpPeTj0b8d/ccr8wPlMv3zRrCjX7zK4cxFPpMIoFFrHHcs3GCtdRtCu3oaMOTSbp4U883m1zB7g9o3Ki53NxRlkS2rN/DG/OErNJboSirZAJkpq3sIPWWhKLYUNvS+I6TB5PU7kHaULJpOoW4As0yCE9i2gr0T85NqkLA0SE/7pQlaDZn0cpllvMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCdEaDnvh9BjTKd0nnG/SHeC017GyxVqV3VV/gO0Feo=;
 b=eJiH99bkRCtClqZbk70UDmKjSjdyD4QWnyHaicBADZYRTaG8K6xI5bTmC5czdvhKcxrhaxr29UWotgZarTT++75b16fmRBBOvyr7eDvhggsp5KiRl0cs+DQDsnJMUpZPqFE1AXlwA0bTufA7axhEy/UWH2r/Hd0d3CyJ/aUtCJIgPce3vn4s3ac3N5ZlB6NYdZca8IodX0l1BQEHII9/pYJ9DDs9Lrfdd2rr4eWzfOt0M/t0TQC5ir+qzkp6PDDvUE/fgu4Ww865d0VqVhlPhW/sSq3JugBu7+RwKHAKOX20C28/P7vo0n+8wLxy6sMwrOaQb9yIEeqRCt/NetFThA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCdEaDnvh9BjTKd0nnG/SHeC017GyxVqV3VV/gO0Feo=;
 b=UCVBzdgvkL5l9ryHJMy3wZgrjMQYsJsQudoZZsSCEcHzV9UpOuu6TApa4nX3rcn4LPrlKI1cni6QWGghyMS/Wz0dv01pVDYuqPHbG0X2JTbBX8D68ExzCm83bCgsNt0KnFhUCYvXSxEum57YDhMK62Crkt8GtR4s3Ov8Yj1Fe0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM6PR13MB3787.namprd13.prod.outlook.com (2603:10b6:5:240::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 16:04:10 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 16:04:10 +0000
Date:   Tue, 20 Jun 2023 18:04:04 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: dsa: microchip: simplify ksz_prmw8()
Message-ID: <ZJHN9Enzc8YlIeBD@corigine.com>
References: <20230620113855.733526-1-linux@rasmusvillemoes.dk>
 <20230620113855.733526-2-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620113855.733526-2-linux@rasmusvillemoes.dk>
X-ClientProxiedBy: AM0PR04CA0041.eurprd04.prod.outlook.com
 (2603:10a6:208:1::18) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM6PR13MB3787:EE_
X-MS-Office365-Filtering-Correlation-Id: 446927e4-ed06-4c10-e38a-08db71a7fbd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3u1oCo2DOfC5+HzVvoZnAJ8OOgG4X1FLF3DTJjZFIJQ3K2OYmPZAgDmBr4C+Zk6nuyTaKuzaQnPfqAfq+TAPXy2ckIwsx9PKZIRC8hKjHlrI8AH3syfFnIONARcK0LGM36TSC4cQnDW5HiT4EXWu+/y8WuDQ+fta5Tn1Do/8kXipmyyK1Ul10U9nQKVHe7DEXhqqYpPSVozzMRQpjgFoNYBlf43pGys0PUtDLf++Oa005oSLZsWxM1dhOSau/zGO1lIHUrJLi2CjmFotbiYAkOqu+IPyvI4brQgrlQFeSfflDZRE+nfM+CkDcPVnUrdEIf6vB3fDANMjkeChkFyivOET6ELx8ZZ7g7iFM+esySdiYGsd+VfI5m7I0g82I/yPYoV8yCsCkcJsWJ/trMjWHGcgSh2Mb35Gn9EyVtCRf57f8UDtfKOSIzxtoCuYAtYfmGeCtpGqKH/hfa1YpIS8tfnDJAQuO3gTQ1ra7EHo5VHQEC9lAwdoHNtibHCAqpYxIro3p56TPzEmfBWAgT2VHqV82sAgNZAA5fuKzgpJdEdP9qBkjnID+Sz8qpHNKEPoVeS4KsX1h9XLCLXoDEDKaqDS46yu3CVNgU52BVzbV1U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(396003)(346002)(366004)(136003)(376002)(451199021)(4744005)(41300700001)(7416002)(5660300002)(44832011)(8936002)(8676002)(2906002)(36756003)(86362001)(6506007)(6512007)(186003)(54906003)(6486002)(6666004)(478600001)(66946007)(66556008)(66476007)(6916009)(4326008)(316002)(38100700002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hjwrgT2TFKvKsWU83lBwTq6tEJ/RyORnujEGGrE6BbmNdhQobOCKwOQeuxw/?=
 =?us-ascii?Q?B4u7DgSfMEzds3VmzWXpVOgTSv/bnjhTS/jzk3ehu8XchG+cw+uqWCy/k2MG?=
 =?us-ascii?Q?bTOov/bi+znVena5liS2GGFUTVtzpxmtw1whuJ7YaaK43aa1AatWUTFDvh54?=
 =?us-ascii?Q?RvIhXYK77I9Cl3nLlX8aJCFSm4nSsyduj0EeeoEW0Dw4k+44QK1D9jBf1YtI?=
 =?us-ascii?Q?4zHnumnXWJ1ukg98YxlxcxxyEJKHjeFcEg8w3/vFQD/cR9dgDDsFeCCaGRqA?=
 =?us-ascii?Q?+oNPLtXNRCv7fkhqLey+YWDBJlQLtoCncle18lrKDxjgiUBLcPiIJrF0m9/O?=
 =?us-ascii?Q?brUKfm7xiWoA8Yn5YQBsC+Elhze+/BdMhP7IsKDfEezbdh/YcMGhnew8Owi3?=
 =?us-ascii?Q?G6QyZ1W7KymnMJ/Ya3oqdcbY4gPbGCdMDLv0Y9W0pnncvjBafLmePtOclmHx?=
 =?us-ascii?Q?L11ofYJAIJNctAeq0ff2X0HRyUBQSD9T1fjWvUp/Mx2EzI0wH6J7CBoJlEHc?=
 =?us-ascii?Q?G6066qHJOzMiRXKPUYpcWJpxphVuCCPfOcdT9yIGi476jtQUqfgwQzpsoMJu?=
 =?us-ascii?Q?ycEDJy3Nh1XNi0wfye4wo9TbVsnqyf3hZnaySDKFNKCD3Q814xnc1KD6AjgR?=
 =?us-ascii?Q?qwJ53I/onFma/w1rq0P6MYUUTAkCVDGv7FvTdtXtxbNBM/XXcr4YfBb58psT?=
 =?us-ascii?Q?rcvYYYFpr3KR5OVV6C+660Z4FYCi3Ev2PTg22f0BmdKHLtl5472qtigSy6FH?=
 =?us-ascii?Q?Vuel9Sl+OjFfbiYSjO8Ble2XnKfJH7X/1qmeigjE1vsTOdF4nWydY8HwsIXI?=
 =?us-ascii?Q?2sezFHhGKikNppQo3ierKOPa/UFytrxKopXgLb3Fzjn2SfKuCSj3birfVsA0?=
 =?us-ascii?Q?VX03X7NmNZMLyP3jwp1LsPx2EvkdIobfV4aXrUjcVIXceofwczeg6BTyuQly?=
 =?us-ascii?Q?In+IchrJAg/ZFSW66zeCt2a2dd99O40ebDiIdCgCLtLwrJ/xn///h9XohcQe?=
 =?us-ascii?Q?cBwV1i2OGDMd6yY3tbXNJpZCM1b06IO+S1Mnkzzr4tFQlZMUKST6XOicmolv?=
 =?us-ascii?Q?AwIz05spjm3Or7prch87BnaY4ArQOw6qm+XMNWwvZaEdAWUiEWnafmYmxZW5?=
 =?us-ascii?Q?8w6cSJjg49OFiLS2O2f+F7wMK94T0J5NTGpZqFp4zcCEbtO6NNuR77z2WWAb?=
 =?us-ascii?Q?MC4HQJhSrN+uy1GwZgU1zAL1kfetP0f/1/728cW2HlXrMCU7pP/gh4pUPma4?=
 =?us-ascii?Q?/zmjLHCYFJQGZbZGxvCiAEoyAHQs8ZJ4m7L/mJzhfxHUBmI2FxdLWAgqCZot?=
 =?us-ascii?Q?obm6zPyFQ59PQ6SAKab7R7D0qPbja5RNsXsnJECgBsnAZ+aBRLiTqY1QqaQ2?=
 =?us-ascii?Q?MH5nQ9U5FB8B0cJ/GLZoXgEb6cjFlSA6Qo6Ue+y8QXL7mU31nTgyHquVNbre?=
 =?us-ascii?Q?nqMRuDbtHQ5cClxiBmTZwtQEq5YrOV7FetN+Ikn0Q03hInJhxx3Y8J4BnClW?=
 =?us-ascii?Q?ag34DZFTFsUeLNfrYQy6asT9ZIrSI85fnjAW2jXPK3hWd3hNQyzU1z03CnMn?=
 =?us-ascii?Q?RUKh/OMxT3+ZstQ2zWmyZ60sq2iNCawPtSiVhu0d/MeqPs2x+AppjdILZsyA?=
 =?us-ascii?Q?PF4IN9qAnezQWwlsBxjyEmruMJaS9S2GAEMGsmK+suo5Q85sU+oe6nXOjseC?=
 =?us-ascii?Q?u5nV0A=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446927e4-ed06-4c10-e38a-08db71a7fbd7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 16:04:10.2986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSAHDAi1BV6m6la1cQfnv4Cb1Iszr8IvpUi/NdZmUjN4nd25YA3qY1wyIToj3Zb8Cin/8+81VL3En6MRhRzUQk4nxLnc56TCpiV+Bsgm/Yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3787
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 01:38:52PM +0200, Rasmus Villemoes wrote:
> Implement ksz_prmw8() in terms of ksz_rmw8(), just as all the other
> ksz_pX are implemented in terms of ksz_X. No functional change.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

