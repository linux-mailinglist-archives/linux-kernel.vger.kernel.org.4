Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87F1738763
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjFUOo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjFUOoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:44:25 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2129.outbound.protection.outlook.com [40.107.244.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499B5C3;
        Wed, 21 Jun 2023 07:44:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fui3KhwuokyNshbL2Sv/nPv5z8NwjgISgYOplzgPok5I87fxNcEhylda+pXKarCNoveyVjBj/z+DjTNwUy97e3SF3Y+BpVBwxnkDR0a7VSj136G4yn8Zkm74PAPr5nRg0wKgESQre7bKNUxVE+ZwBypwh8NhLTSwioRPfSanaBjt1fTUeBGCdJ8zC1pY3Tl2U6zy2O+4qEqo+gu9SQU8coCXHf1UZOC3gkMUnIhW8oAQaD6cZOxdSJpQQJD45dXLuO4T+nCmjqejVOq9G//x9ag/YDYemLZDcTJ91gPpzyC3BwBErcRl1J6JvzIBsevengbobEAXDoyld6zpKTGfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+Th/fjDcvVXQSSuHBc/6oc22HTisFtvcI5vWK4U2Bo=;
 b=boMdsskXacKeR9u+9Utd4z4fa9hTkO7HVPhFEpAj6pzm0g2peo8/FS0iQlIS2ZUZSx9DQacMFeaF0xThXcWzjV4/+928qz8H1TPpzYJRvGeEty3ZC1ARYgZBMxq1MJ+AwzG6CAfbLRDPhmvmhqz3eZwpPvExvD7MlTvX+qQXgniafuI2bHI0GGGBil2fNWZvbU27SJ0wjTNMWxIJf49zAFMSAYMnnk19mtfMRg6WQeDGE34o2HRzV8iCLDUGI1sj8+ZvlVpX6R4P4yGvpMx2ojBJPUHw/fgDYdtQh5xT1rumMJlMdsuabZpudTsCA1raNeJLtGU1J7e6xLVFrKQMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+Th/fjDcvVXQSSuHBc/6oc22HTisFtvcI5vWK4U2Bo=;
 b=nCEnC6fDiS8JG301MxnJsuwn9HO3W/DD74oymFED60nAx2+f0dpvfxMUD9Gztfv/blmCZYu3Rra+fnXzXaOzjOWm4A6LyxTjGVdPqDvrmA3F+j6tG/KBckH+7w7BQiLfN1uKuWx55S46oaJAKLJLI7MWJcA+ryugJjK9+Pz1iAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM8PR13MB5176.namprd13.prod.outlook.com (2603:10b6:8:6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Wed, 21 Jun 2023 14:44:21 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 14:44:20 +0000
Date:   Wed, 21 Jun 2023 16:44:12 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     michael.hennerich@analog.com, alex.aring@gmail.com,
        stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ieee802154/adf7242: Add MODULE_FIRMWARE macro
Message-ID: <ZJMMvCus42nD2lrc@corigine.com>
References: <20230616121807.1034050-1-juerg.haefliger@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616121807.1034050-1-juerg.haefliger@canonical.com>
X-ClientProxiedBy: AM0PR06CA0092.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::33) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM8PR13MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: 46389b2a-c430-40a2-c405-08db7265fec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JaOiMFGit2PUJnYZq8opMYaKaVpHaqGyCgwCrkddOSdIL/Y/HXILvIZ/Swh/CG6R1XhRx8ZXhZt+3JFuBti9eROpjSWvWtFUR1VmALT1tV87OIxJ4rtKQtbLlBre2KH2c4m/+LhNbO1j0/hMdOQstrnM0rM6r+USiiM0nWGixa8Wct+N62/AbdacsmrHBqhJ967K5/hWSWO9gnYQ7xs0QOGdZ3S6eUjYau1qEKPeJOBdTDJ9fNjtaRkAe/7OYMq8KmsFNor1HhMHj93BoltOJf4q6hdMEbSg9sn06n/tG16DfHUPR8atzjYDvpVqfb18qbaJrU2vOciVd0LvUwsqYKmgYp3pqcIQEObnWudkPUJoWQMtgH+RQVA8MGJ+VW3ZdaSEkanBs0WzjA9RAXNbW9X8DrJsGV5w4xlBUouR9+ISnl4aMMMHYf1bWYgWRqsyfjLDlGKiJQZpbAUySxhmca4H79+s1kii93Jk949lTdkMt7wndqw8QnzuIvGG39W5G7lDSe7XvdqmaKGvOFxAIGRZ1pfLNbknf6AgXKb1vEKa1cCoE6qyAm/lNaAn42xXJVH4ezDaQCNQs6KiCQPII7LAi2Uw+L9nuZmL8Ab5KJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(376002)(396003)(39830400003)(451199021)(38100700002)(7416002)(44832011)(2906002)(558084003)(36756003)(86362001)(2616005)(6506007)(186003)(6512007)(6486002)(6666004)(478600001)(66946007)(66476007)(66556008)(6916009)(316002)(8676002)(8936002)(5660300002)(41300700001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dFyW2Dl0b0kab4uCmDz8DBoeUSqjER39YdNQvy7zR9r4xLxJFKEGdnETfS6q?=
 =?us-ascii?Q?N0vaglNwHAnHStDK78HBlCp2nsE99l14tPhVLCSWKEc/U5z1OvYlOhw0gB3M?=
 =?us-ascii?Q?bIPkE272OVQFQ2jQ2cKOYjPP07eUo74ySXsE24p6jVB/Mk0L3pQrp8TlI1Jq?=
 =?us-ascii?Q?38/0h6VhK5cxCMdprhh0xS0JRBXCMhYmVhTV10Yhp7MkVWfZw4EfkSE9xkdr?=
 =?us-ascii?Q?BTeipm6lSYJHWmaTtkN1Dbe/oqN5bPplChWTNPlmsG5rqQvm3FsY0BgTRqoZ?=
 =?us-ascii?Q?8T+GnJV3OEOs3yHKBg0Oq5nJx++nKqznDOw5V+IzWFW3EUeDTMe9RbKufj4f?=
 =?us-ascii?Q?xxCGlmoLMfiarHU9ZXlrq6iuytasfEmnKA1MRKVhLSOfUMbCjpxdpsI6xpRV?=
 =?us-ascii?Q?LfK68PsnEYMH4yIj8wpjXPqY3KIythzy23lzMcrUS24PmsYbh0ri08zwOCUk?=
 =?us-ascii?Q?RAgcbpmCoXJ9UeXck7yjQQNcR2EMcDjokE8LBptlQSCdJQESGZbt+7kJfnHC?=
 =?us-ascii?Q?smwxntkiLlEfRHj026dgcKD4jIilN9cAJA7IhynIp9v+n5T8loyZO9qomf1u?=
 =?us-ascii?Q?W8DdnylwQqATn/YyNDu85T1MhD1e7kdMJP1P5yBLPAvtkIvYToF6fZsBxEir?=
 =?us-ascii?Q?VP82gMZhpbsMKoS3mGHZYeSYg1C8AXEGCmuZSSdI5nbVR4MACu710Bakd6qf?=
 =?us-ascii?Q?2YhNV+D4AXtBZxNpUratd0PwqZhZ/qoCMbETBUq4gylN5hqEnum1DW55lSBu?=
 =?us-ascii?Q?WbNrSiWskt81VVcDHzcfw2FfxtUBg+SH7goSJHfGOSPz7FsdSVaR65Bpi927?=
 =?us-ascii?Q?kXwFYrYBO5E5oJug1faEcJyK/eL/gR2tyKZW7X1p9kWf+yy65V6d5K8SmHXv?=
 =?us-ascii?Q?B1XRlxnMWaa16pmFk0xw4SHjVBWnmM3ZmdDBL690cflf645npoWLqMlyxd6v?=
 =?us-ascii?Q?+VzY8PxI5t8c+FMlmFYpZJihNSsaH04YZrAXlx+9b5RhY5a9SmSLyGnKz6uF?=
 =?us-ascii?Q?UfhbcYX040trjlUTnY9gS1WjlU+pRO6VfdLxJ5a27x7ew4s0I9SgpbQJixHT?=
 =?us-ascii?Q?CrnWYNbO60rTjodLxQzaGEF3aAGuEuRHawse82GnSfL4GHmgKL6iN5kM2fG+?=
 =?us-ascii?Q?SUabPbZkdnS46sStM6ciJav0b0/umkDSigJf5dvj62wh+UuYocQji/2q3jsq?=
 =?us-ascii?Q?TvlPumuw338g1F6z8Jyi/AkxdRaENiwe2q13XdhASVn38ODl8uQXtx53kzJD?=
 =?us-ascii?Q?qoR6zMJA9CpglMw2Z4Gtw50ucTFmy9ykWxQ19NwbFHXUoIpSR0DJw4IUQmSd?=
 =?us-ascii?Q?pywpep0JrkuUBzFs+25pGU83GFulQSuDlgyfvw2OTv1Skk4P5cK0dDt6s3Cw?=
 =?us-ascii?Q?HsOmZ0xlzodi3AoYVvysoho/ZGv+Y/bElnU5Rm9JEGkKkyTjsl2lvKEzXHqX?=
 =?us-ascii?Q?r8aValqJQOcDp5NYdcl714mTkqGpQoJMEw4Ta3JLwf8HG1UE0hsQsUHcXZYV?=
 =?us-ascii?Q?9oKSZP8yDBhTNPVMNPVfKWe/QH8iESp+td3IU+cZ/4Z6zfRid+zufEXheoFG?=
 =?us-ascii?Q?mbi/hcQ5Jmdtm47zMABcCE8KpdQoNxiFa8Te2EjFrcTz50UiD+PrPqQiLxJI?=
 =?us-ascii?Q?HHSE1ghCs8OjF6tfEpkzxRlLsQEnctUGY22H4ch0IAFuPreJesAnRb4gl/Gb?=
 =?us-ascii?Q?NmSekg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46389b2a-c430-40a2-c405-08db7265fec0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 14:44:20.4825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItiolKVw7W441bVNlVlqVMMX6zPP2NghB0X5clxY0QuvTBeS5hr1hEGq2RgNkY8lSHIBrhdPLw3zqBQNY6E/phCzT7Ih/UVCM5YgLRrLU7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5176
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 02:18:07PM +0200, Juerg Haefliger wrote:
> The module loads firmware so add a MODULE_FIRMWARE macro to provide that
> information via modinfo.
> 
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

