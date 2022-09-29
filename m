Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3D65EF9A7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbiI2P7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbiI2P7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:59:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87C71CFBAB;
        Thu, 29 Sep 2022 08:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSnXKPQMJgIg5+tGT81uC8qrxqLSir85TvcCYTaW7b6XMoeKXp8tF71A47YdXoCQTeosGgF82MlWlIKbUvjcHi5Z/dyWEERnrxhL1MEHndd/WkGwDV60A+HeeMcVBz5tkIqWQzH85I9OCugeovBqRTCLzlim+jFs7biooui2r7xduLoR1/p/NVBfadD71qQD87g+haZ/2Qj1DdhiowZ063U9PD4GhguqwVT29gFFoGmVQSe4J+8C4W/eIUzTAVrbdH1pub+fnQmdqDoDcmY3jiuhsNab1NrAhqFHT3ByTD/oSHlfcayK7jM5lzJfcrHCsOczHnX8vttrlEb60Hv7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLd2fwsUUNoCZMgfEipXw/a+Fq6DpYfCZL41GxgaGAc=;
 b=TX+F+HBQ+z0Q1BYfwhF4s4bhWRhzeucrIk5zhYtwvzOvmAhFlQG5R+ekzfh46IghTpMH8Oh46hJhc8c6t9g4t6VHNNPDOHm3TJuC49alYkW2cRauJZUGMZNHZAG/U3JJdKzm3OGo1hpdxU0GY913CUA4GyKgtZ8KDrg8h7W+BFxyCP6PBtQzz0waxsqpyV+5AB+pEuvpVGJsSZT1Evgn+Wq6T2Yw0Jz4sjY/9BozZhKzP2vo9Xb72S5nk1Pt3NS+QNDU7lvpjP9kQfwrJ0JWO3IC0QhVQP/58P2eHJ4QM4I6ncsBuX6WLyN0yCIjzBuPhYbv1www+hucAAeov5CMCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLd2fwsUUNoCZMgfEipXw/a+Fq6DpYfCZL41GxgaGAc=;
 b=NdBFxTJWT71IFGzOsQT21RAGUZ4URT/0A5jxsRvP4vag4UMXcMTa4aR2KcO6ARF/vJZLwseXDMc138W/jTKIqBLamU5Fq7Kwu9rm8E5lbHy6E2hDd9wSMu/UnQcVMuh21gtJV3CoIa/sWzD1Lb40NLdLG7FvLgcI//y8GprXTU5Awjgb+tczPtfchaNo6De5bfK8aqTrW4C2iznNUvZVNLxc2IraM2cs1rC50HRNnYRjuk1OLRxbR12kYkhTvlztnT4rYW20DbMVZZ3VNcgNXZwM0BZfkOqvd2qqrGwbhiOeDa/z9jy/25QEqKddih3xP8/00vJvthjY7B2SH9shcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Thu, 29 Sep
 2022 15:59:03 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::f0c0:3a28:55e9:e99c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::f0c0:3a28:55e9:e99c%5]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 15:59:03 +0000
Date:   Thu, 29 Sep 2022 12:59:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] iommu/s390: Fix incorrect pgsize_bitmap
Message-ID: <YzXAxmtajuK5fevj@nvidia.com>
References: <20220929153302.3195115-1-schnelle@linux.ibm.com>
 <20220929153302.3195115-6-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929153302.3195115-6-schnelle@linux.ibm.com>
X-ClientProxiedBy: BLAPR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:208:36e::22) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|SJ0PR12MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b112ac-0af5-462c-c6c9-08daa23387c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c0rgXyNm+tcOdiW5Vs3qpfH+tfDLruh+s3oXt8bAuUynzyCDxQ3s66zFgERn3LIJGN1FChGS/19YDV3s+unlO1OS0+eaGJcC2V7zthz5KzmOMSUvqsyiDxZK3FutqytnA5v3AY2a50sXpNmUuFeeOUvA6C9N8LMWB6p01vZgwHT6xDIdABynSOaGGffeXlewTYCvG5Vzie4uzZjswqQvft+ULKtLPE8M/ll+Jb3CuNg9HqV0oOqPjr2u9xn2if/Mmq9eJ3BPuLzg1v15xqYsfw0JOtCiIuYR6AJu3at6q8HXAERsVilOKsVFcOUFmCQ4kUeZyKOxYZgo2YK9eZmP15zi3U3P/ZlTDkvTw4n04CasiPu9veHBoi7ltFBzjo/T0FmqiulpJxEQsMFb/D6FG/olGrzv9d85WN6K03KpQa20N3Dqtr+hNpgFHFBmXjXQ/j3En8hKFwdrqHjeS30/JixRyp0ILobqxazmmZz3i8yz+f2ctzPkp5t1KZ4oBuTTpMncJfrFHvCruknLPa4zegAhHLb+DdTKOVcalsXwVNaOUTAVRZHk2QRXj2c8PyO8aojYIWW0NGMM7Tlu3UqSabQ91MyQkQ8cyu8+GNgocyMcbgfji2vVAw/T2n/H/PjB6JAmU1m7H5XbuGB3yWgS/iOyzRLXk43z99Dw6tETfxbRw1rR7KB0Vrl5oPjDWbvxGn1UqIo2j8t6v8G9L8xdXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199015)(7416002)(478600001)(66946007)(86362001)(6916009)(36756003)(5660300002)(6486002)(38100700002)(8936002)(186003)(6506007)(83380400001)(66476007)(4326008)(316002)(4744005)(54906003)(6512007)(2616005)(26005)(8676002)(41300700001)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qsda0IyMxEJVYDXAg9AQKJajuydL3l2WCKvEAIR7Nbx5yc3GycEA9JXb+r3H?=
 =?us-ascii?Q?GmJ373qqhkaDPlRyrSb5HC6RBJVaBWFLosGsY23EA14plWynSFLyAaTeG+Bz?=
 =?us-ascii?Q?Ax66GVgrjsjapKf/irNTa19oZf18w26J8TtP4jgdBrkDJTy1nDOxMvrsE2kV?=
 =?us-ascii?Q?J1nj/22cy/itSYbKbmiAsaDPJRX9XT67fPwuNZM2VXaLkGZm9mcTxNXiISJF?=
 =?us-ascii?Q?SenwveaivqRR4WG6nnbJm8FLug34QCCnjFVpqxd2UtzMmC7wgcntfz9EdFEC?=
 =?us-ascii?Q?BvRcTlSDztrRLlKz+XCOoWrV9S6khnczab7bsjLo5/Lqq6HR7x3/RYobPqed?=
 =?us-ascii?Q?3MLaGmJ/oDqIRn6NvTwFSnBDsptFHEp6uaOM3CIkO21OQqXK8uBaNiPG2Dlp?=
 =?us-ascii?Q?9Xh0OnbbO25vRvU7EPBiNYYcnGV3BvJLCFpQOXbClNI/mbhmNGkxzHFdSq5v?=
 =?us-ascii?Q?NxtFrt8FZ+hh5d29v8d0CUq7fYU5jJ4mGU5zbX3nu1VlK8i7F8gR9Ph5SLbT?=
 =?us-ascii?Q?u5SVkzfag7xyV67YGt2ECMnL7zLP1Xi4xpSbnvVZtVkrjd6nGUeFVlhlfPus?=
 =?us-ascii?Q?WChSh+36X6yosWnnZhBcdq+z7kF/ILT3tWCtdXoBEm9Vuhwms1GKpM5VmKRN?=
 =?us-ascii?Q?C8AGVtV0QDkatkgsDXP/Fa2+mv6iLM+vHsYB1YZPi8wulnDbmk6LLHqGIdg0?=
 =?us-ascii?Q?umnXCbv8lcwym/n3q9RkfxHsh21n0b5DPw+la4zJuKGg6y7WtGR9piplIfUt?=
 =?us-ascii?Q?8A8dHnkbQNdk7h57WMdvvyKMdmMdqjoHU8jVQjGOxowe1oktK8WWQ5SC8BdN?=
 =?us-ascii?Q?bo4uwPykK7e3wzHraSzI3nZ4ZkcitWLFnkvaeBA8/5dxxbT9GgOGUZ2NCf1+?=
 =?us-ascii?Q?wuh8Tt8KQNSRCTb6CU2J4F04pD09eKRoOdd79UpII7UmWksVScyQTOGurXzc?=
 =?us-ascii?Q?TSTAwWm099JXWD18ADPOdsj1mvX9R8gVlNQDBpWW7vdvCO42dR37eV5FlC2u?=
 =?us-ascii?Q?vV1Lj8NOW1Wl5qQiFHv8feZZw25Y5CRVZEqO0yg5pCJZ0Hvz2OZwjiTH7Zvf?=
 =?us-ascii?Q?VZ+Nwgq7BINwxKYUo9pZGDRFR7UXA4gYt0u7yloKemgqPwfL6G2s0riuY92K?=
 =?us-ascii?Q?fk8LI5TY5QmNJ68YAnTIGV+aFVnaUkUkMqEEgDpWV8cxB550F+amYs43ZQS4?=
 =?us-ascii?Q?S7VtTYLikTFEhv+s8q9LvooDUv4pRjCwKxLlUn8DhzkdZjFftVyKVt1o3Eu1?=
 =?us-ascii?Q?iC284qumclpkrp6F/qaQqL+LccP8pVKO0ERsh6XQHR1EuMELBNCXPmpbchin?=
 =?us-ascii?Q?0IQQE1W3IJgXIUXWOmHPWjevXUvxh9ZivmDrhp5aCGIxB1P/Z5FsGRKCJiDe?=
 =?us-ascii?Q?Uf7z2aXFBwdzWG2BLur8HhhWIPyDIgc0HIh2hFEXXfXRohMwr7lCsksla0Hg?=
 =?us-ascii?Q?i+x85MG+4FtfBbh5Pvq8ep0DnKCErmabASdIiEnSIqy5aUqucnhRid10NddV?=
 =?us-ascii?Q?1T4HDqpK7nYu+A52M1Kw44se803LtGphU1TOEWHtSZEjWbhqnw+Bzlz60lio?=
 =?us-ascii?Q?U+oA0D2DjZqxgkqSBYQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b112ac-0af5-462c-c6c9-08daa23387c2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 15:59:03.2647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9W3Npq92w4zKig6P6XOFOX0W5D748eqnBBS4faxQMfUaQspp+EP1S5Yaj+lJT1ah
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 05:33:02PM +0200, Niklas Schnelle wrote:
> The .pgsize_bitmap property of struct iommu_ops is not a page mask but
> rather has a bit set for each size of pages the IOMMU supports. As the
> comment correctly pointed out at this moment the code only support 4K
> pages so simply use SZ_4K here.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/iommu/s390-iommu.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Yep!

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
