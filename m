Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B9060B491
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiJXRvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiJXRvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:51:13 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C528175AD;
        Mon, 24 Oct 2022 09:28:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5FcPd3a0IRH8wELBm3YiQuTyfCJ7eFrcW8Z0MI16Qq0tzKdC8Uz89Eazayz4q8Bt1QAx0Qj4vwHQ4e6wylBukMVFqM1hyLKK4adXzFlKygfJAzNImspkmwyKXGXgGC1ueQtRILT/cnYRledK7bpiYtfEItR6jL0EnzgM7KS49fGt1GOSj11P1WJF7x+40rOP1Ak9LCyygl9lPxD4fmrqPtIqIM8ey1wmZxmFqhPJ/1KM2SBfN+uTfixbMmVSJ8MRQzBHs0FhpmbgKVhWUcD1wYUd5yPuQ45V3AsYCiLPV9omz37ckR9YZGD8GDmqzHQbPhRmEdNyvN0WYrijN1hIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrtS4FYtHSaz32ZmTGgr+QmGisXQJbFA7vhnud4kTqE=;
 b=l0LEQo3kgMHnzhni2U+c35nc+IPgB0D/McDLyTYNoak+SbBby2yyuLE/gHkq8MbqVyuHWBH20x3dJHgZCbdUadXA5NkQ1N02ehUEIiGgQx6c95GOlRxiy8jyROqpfTRx/V+t+ixWSx7yBMXbLymtMfzQrPELey6WJ3jQtAdQrri60dOfoLnejo4kRY2/3ckG+Zzg7wv2bCydUH24CFFTDPalxXbJt8SZ3UkqpNJR0FYGQYkSv4LgkCHBl/pHQpi5/qC7ROQ2RqutP3/P/Jft+/USkem1Or76mFNu1WPqxjJq30/t11nm5LbzlBgdOjBh2iW1/z5uiFvdiUHsjT2ekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrtS4FYtHSaz32ZmTGgr+QmGisXQJbFA7vhnud4kTqE=;
 b=neo5nPDOe5KbqnjC1aiznu7MZzATbT2Bq5DInRnX6Cou4aE8TKiFl7qnQ9trTqGeDTwg88NBwMWhbzq8FNG+WscqoWIZB7omRoRw0dK5jxns8wtIOYswGPkZ3GS6y/ZVao6crSsReSgVp6Hrbz2Mn09WC7HrMX0y/1lRSaXTju01F6ejTa3mMSXboDdcvhJlR5AbOJhI5GfrWn3qDDY2cZ9s/o4j0M2rAB/F2zqLu9McCfp8raD21v5Ir7zaWPJCUV5rK3ozG17vKXZ47nncIjrieLDdUCjflIwe3ITe4S+u9PkXhw+fJ9u/SSr4W/AiNcltlyvN3FVxw8elmUNmeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5308.namprd12.prod.outlook.com (2603:10b6:408:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Mon, 24 Oct
 2022 16:26:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 16:26:17 +0000
Date:   Mon, 24 Oct 2022 13:26:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iommu/s390: Use RCU to allow concurrent domain_list
 iteration
Message-ID: <Y1a8qM4c2ZAM9glJ@nvidia.com>
References: <Y07Dz/NROAMI0Hku@nvidia.com>
 <8e268ab5e0dadf86be5fd7ffaa9debb76cea67f3.camel@linux.ibm.com>
 <Y0/lMCQ8oeXJ2HTg@nvidia.com>
 <f3551bb461b3ef3cfc1a0c644093816be1835b3f.camel@linux.ibm.com>
 <Y1ErcEe82yjJI+ET@nvidia.com>
 <68d91d7a5aadbd46dc34470eccd6b86a84c9e47b.camel@linux.ibm.com>
 <Y1KgX8EwH8T+FgWC@nvidia.com>
 <89a748fb5caee8be5d91806aa5dfd131e92d5d82.camel@linux.ibm.com>
 <Y1K1AqVWEyY0/Uqy@nvidia.com>
 <cef734b9f9b33380c1bbff40b56bb67b3de29341.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cef734b9f9b33380c1bbff40b56bb67b3de29341.camel@linux.ibm.com>
X-ClientProxiedBy: MN2PR16CA0009.namprd16.prod.outlook.com
 (2603:10b6:208:134::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: 554ee1ed-fe36-4046-f990-08dab5dc7a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zin4tzB1jjQDYsmF4N2LWXGSjGixtJAazwZXepEdT9Ib4y4nHNUwjbhI3GyYQBUVYRfysPqzRzrUYsA+i+DlbmC0AHQWy2DnrV6knunpcCKlhdmSdeMhIHLvGvzoYCGQt5FUKIvp2PrWLYtsHBgstuR/eFx9mnZgS0gyrQ76npwlYInyVZCMsCwvDnva8b1yE1rIBNmgln6dWtFJKjNvE0r7MkYOmCmvX+l7XT/86zBqb/1HqOt9pp8NWhDmbX7xv4UXHwQ++Ci0S+6qHubnWHkgrUtW7soL5JRE3AHuV90JvmLxr8oaBX8P36lXTs1RFS2k7MFy0mp9kPJ0B/OEY8B244gWP4xgUF3Pp1CrZMPwCPO2p1wE6pxDunqlmo8feFyUlLkBKG7rWxaor8xB8X+NlrkOfWybn06nePwLB8Vz3nYVQS4KzeNN0cp9aXtt4Xv8EOX4OgnMzmtBMU6xgrykxLSBEWZwaBaChgdqPiE0hg32sCWk8/Ln+QO9RsBiJIXWVsGn8F1R7IVbnBgqQPTnSajUrAaLaYcUy3jRTxNiDbY5pNLQZYFrLxL/V/OXXi61sbYgQYRpj6ZlolLLLJCDunluJG7ftFhjrNlXronLUcw7jkR9LRdfTZGY2yqw2ESeYTl25jhhHh3ho1h8tKKYokjQ21YCgvbM5cFOq9j5iCv9N12k8Nwhkas3veTY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199015)(54906003)(36756003)(8936002)(316002)(5660300002)(38100700002)(4326008)(8676002)(86362001)(6916009)(66556008)(7416002)(2906002)(66946007)(66476007)(83380400001)(478600001)(41300700001)(6512007)(6486002)(6506007)(186003)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jOXPyBf3PCQwv44HSmEv6/B0B1ZXv5v2X0GSIhOg6VaAXK3XnIQKzPvNUT8m?=
 =?us-ascii?Q?/NiLVoFXw7Xh9jSo6S1a/Xh29dPQt4vbecLbQj1030yzdApI586dssB54CPK?=
 =?us-ascii?Q?P7xFN+q9NFqgVvmuqVm8+e1gyqyt5qgYKh++f2vxUtv0gMmIYQIGFtGGC7Se?=
 =?us-ascii?Q?YnGWQYznteDckSjNNvXzXD6gftTYu7oDzmKJmmlWb9RgYqXQDsDgDfkyg2Tt?=
 =?us-ascii?Q?hPNETbJ768p3UtOFaZDNA4IJw8CDFtmQd6+Qx7NToHYzrhNllUgtdo8cgNd7?=
 =?us-ascii?Q?ShjcQw/vCEV/cGAVstEX1Y7es+RTwNcJ4RFGesKdwVvWtAVqiAHknU2eEX52?=
 =?us-ascii?Q?jFR5MIosve0CptXKkepXMV7CT+tedXYCW8aEZIg6Hfa5J6wpDNpLnHN4h+9r?=
 =?us-ascii?Q?Qxz0GPQUHLRUh6SEBIoxU/WOeoNrecmpQfaRr+HupobvMoY7+7UluNJgKjUa?=
 =?us-ascii?Q?zbB8fLXtubfSv1LkS1hiF0o4mAt8rzlVmSs5eSlYZ9+Qc10WGA0W/mreRUjn?=
 =?us-ascii?Q?03fa8w7185XArmEqOOmSCxhuriGnpNnX/nIFS0xV1a810DBQnE+bNdIstjaB?=
 =?us-ascii?Q?o2/zrNbu9o1zDWtJPjQ2lA/TYQeTqBcrCRjt78RwdEzwLWArV3gDtLyzDTk/?=
 =?us-ascii?Q?3i5AG3qylmiM6OcD9cizC4thL+jOsRxAqBfjNVkwAaV3zAF1cGNxkQrQwxgk?=
 =?us-ascii?Q?esqIs+F6KiSkynVTNDSgGPNEhdYBYutG8c1/e//FdD7mL8U/5nM1vQtRV03v?=
 =?us-ascii?Q?9X+Yl6djIA28TmSOwCyE/pFylX59NwA6+fvxCMwMhKMP8jWicUoA9ak/imwQ?=
 =?us-ascii?Q?rnh/EhplcMTOd28C4/6anwrdmPfm1cIuHx6lQBul3mZNUwMFp/2OMY5wEIRn?=
 =?us-ascii?Q?ghBkh4D1rYJbdVmjnieWqUUKXKpE8L2cYQdQFAq4D89d6PS8qOAN2p463oDO?=
 =?us-ascii?Q?ptgaU9UQdASTf/ehGlzgM02TJIJfODEBu9oTVGAssz6ZJyfPvHFHQvyih0+7?=
 =?us-ascii?Q?SPyQNJAoqrcfrklFWKSYBQLTcjZj3LE38bPQV16A9BT+44/QNfilHzioh6p8?=
 =?us-ascii?Q?2QjQtGOtxoU2/msLbNoDiIsXvYFV58Zdj2ZzNv/h118RitYlSbrH/wTd3y2U?=
 =?us-ascii?Q?1M66fG0f9OKDLpWG5hztLs6nCTVKZhxyUACp1fD5FF+fhRnL9pgdsy9Ys3dZ?=
 =?us-ascii?Q?s6Rbtr/sAaTjY5jzh9qKFU+3JM+6Xk72mN8034NDzEu1BU+XMoMAiCDcxdwt?=
 =?us-ascii?Q?Luurl5cq9PeKCe5LINHYhoADEu5CwY7vj5q2CbWigaLpCjTOAcSHLSNeNzsJ?=
 =?us-ascii?Q?RBOZUMgXNxNToe4UOvsjND83SV9SMDOtEVvppmb72zRqFkpj57nQ90jzWutt?=
 =?us-ascii?Q?V8vRxMV6vulpjCt9XJzLp8HZHVX+taipz7TL/S+2hi1N51gjzhCbJ9hTZthP?=
 =?us-ascii?Q?/rlmDvxZRoetsM9KIAK6SPJjg2vGPuxlto3u1ErGbWbmiPuLLCBItIZ4VDDw?=
 =?us-ascii?Q?99zd8IuO5Hq/3pD9O93+u0QMc5wzfAk8XbhVaxnoEEbCcK7cXJfm7lpbeUng?=
 =?us-ascii?Q?SRuI/2EpRgPJPJtZhqk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554ee1ed-fe36-4046-f990-08dab5dc7a18
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 16:26:17.5998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qb3hMsXPVlUknvKxlH81w/nhfBHhOGWW8jMv73JpxNoY8o4YbH5KNdTOr+NyRJu+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5308
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 05:22:24PM +0200, Niklas Schnelle wrote:

> Thanks for the explanation, still would like to grok this a bit more if
> you don't mind. If I do read things correctly synchronize_rcu() should
> run in the conext of the VFIO ioctl in this case and shouldn't block
> anything else in the kernel, correct? At least that's how I understand
> the synchronize_rcu() comments and the fact that e.g.
> net/vmw_vsock/virtio_transport.c:virtio_vsock_remove() also does a
> synchronize_rcu() and can be triggered from user-space too.

Yes, but I wouldn't look in the kernel to understand if things are OK
 
> So we're
> more worried about user-space getting slowed down rather than a Denial-
> of-Service against other kernel tasks.

Yes, functionally it is OK, but for something like vfio with vIOMMU
you could be looking at several domains that have to be detached
sequentially and with grace periods > 1s you can reach multiple
seconds to complete something like a close() system call. Generally it
should be weighed carefully

Jason
