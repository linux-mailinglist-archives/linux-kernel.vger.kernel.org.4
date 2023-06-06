Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3691D7249E1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbjFFRJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbjFFRJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:09:27 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ACC170D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:09:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSv0X7olT2FHK8ri/0CP+301iDQ0qAuaSRJmKlhiR0h8FwFOp/ETIptX1URWfQnQIy6C5DwN6680bXwIGSCAdv0QIYvdaPTbcVYZEOUoTZEdO4CqbEZsdXPE87a1r+AGRxod8bSnG82fj6nnJaRXEZBSsxIHFRo/rlEhralJMFi4OJ3qg13fw/zgjDXrGc8i86LTjTXb2i/jXlnCYqaTaxicjyUP797cNmTwwuku5bdhhc7hZbBe9QSYq5RJbglFIlPOxOXSI6ZejnRARShyBrOYCdJUXHbD3wB352AU5O/wYtWI2uG0nuqV9qfNRmYPSh5w0mgeSTUTzWYgdHLT2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdi9Eerc3XeysOdK1RLTER/aN8qP0sxpv+zOEE2NQFw=;
 b=KJ/rfN12Cj9cVueAY4joPQdSa0ZKdOjib33JqNIhaqM4KbmPyAclvakheWLcLSGyY9tdydJHtO6JGXkWM8fjrbAwAjWyp3w4ffpe5ddMcxXMCs7lkTle68ZBNlLYoUVA/Fq4C7YoDgKiaWtwYnDsVS/uBZacHKuqz6yKmNjFuLgbw6h+0nG8/bE3IbUkhmW/6BVcgG9FemA+2VrA01jPcG1/FHPioOWGeMhW5Mo0cbeigWo3lznnhFbjqCP4sZPxairrfkG9ZThcIXI/2k9OCy6PF/gtNlmIUFIC2F6WFsEkA9Qolohc/qAPU/xg/I0iXUP1ELgx9Pus7Q3wteLoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdi9Eerc3XeysOdK1RLTER/aN8qP0sxpv+zOEE2NQFw=;
 b=d2j234tW7MoWhxRKsQQdggZ+0roV3mLieJISYRCP9rriPHQCIFc4JvkqgOO0mIjaU8ErNFzkcM5q0BzvHXT5bjT9S9ugbF8jJavyrjttEY/IwBbzh/NhGjrn7nC+JZHQN6IfSxTerd+7QQZCMmyOZu+wNz+mdVFFjeIZehwxrw5nT6rMQXFGZ26LYKVc8orTqZKjajSTKqtb9TlVGoYUXrwWM60EA5AgGsZ0po5G5+7hhOZdwmcYZF/4EFipW3oLAAY+9Z1kplFu2mJ9J8dzER6bb/KuUMRKT++4hi+oiOa6Hj3LpshNAy/sGFVh6rxtFToLXt1W/N96W2zG1/fzCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CYYPR12MB8922.namprd12.prod.outlook.com (2603:10b6:930:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 17:09:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.028; Tue, 6 Jun 2023
 17:09:23 +0000
Date:   Tue, 6 Jun 2023 14:09:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared
 CDs
Message-ID: <ZH9oQMmI8CezMCnx@nvidia.com>
References: <20230606120854.4170244-1-mshavit@google.com>
 <20230606120854.4170244-15-mshavit@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606120854.4170244-15-mshavit@google.com>
X-ClientProxiedBy: CH0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:610:b3::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CYYPR12MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: 30401537-2278-49f6-36fe-08db66b0c68f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7A6YTcvSZIbVQeZbqq1NZvJVzeK45vRdU+YM3AUyhlj6wn0Ke9x4zbHuGTru09B08eHpno1sPzkLJhv4Xp+cDNC890CisiBU3l1tyxnM4f8DObSHjbrvJmc4nVeQaa3vqxnHI89SEpGaE+IpfjE9M8bedEx66qQMg+nDrAQ/hQ9rxcTbJ+sRNm5LW+cK12FDDqEFrLX3PrWX+U/mQjSTyWcHB+AZtr0HgrSMZCcW4aPGCnRbZEAwzeZSCin1SV565kdhZsC/Rglhv9HjSxp97GblfZpgHM0CX/xcl8EOl9eXLKtjZNEPdaDc9k5034P83nUOtbl9CzuR6hrswJn4BgyJT0te/GIHafOCclL0VUgDAwS7OwJms7cikGUVUN4vKvZRtfS0/txmTwUoaNb1Cv2z/FRuNYWUpSCqGGw97lBNm/PAA7cOgJf42OhynTtCJUX1KbqxkKLfAL9Hhn4qCMBnX8xA273yzGQJbErbJsNFPvlA+VIQgQ/NKAXTW4kEfMvTdtwFn33yfU1rnewIvk70dz14VxPxWHqvZu1htYTYs/osDu09UNF0+8bS8Sf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(8936002)(8676002)(478600001)(54906003)(5660300002)(6486002)(316002)(41300700001)(26005)(6916009)(186003)(4326008)(66556008)(66946007)(66476007)(6512007)(6506007)(2616005)(2906002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I6mBLjipJDoX/niywMOSrSBDAzuUujUnNuPp4P8BTSb+mrpQX49kzon1jQGK?=
 =?us-ascii?Q?5hdlzvGc99gysgs9nBpPgFPnANI+L7DmbA3PtS4Pa48r48pI2IGMejZ/Y/sG?=
 =?us-ascii?Q?PSqJlp9ckrB8WlwtjXn1jydxpJjAtQx7PlxrcH4FxYz0AJ8B53U90xakDHjJ?=
 =?us-ascii?Q?d1CBSj3y2TACxWIiuRWmEcHK5OPHijAmLo8NDnvNEAyUjrBiu4j+x4DyEsnt?=
 =?us-ascii?Q?dI7nQrb8L1q+izeLWM9PV69yIDPo6WN8TXR90M77JBMjd2TBkp20HnDul64q?=
 =?us-ascii?Q?FMY/WcyybbR4Dr6n9tY8mJbRsa45tBFRAl1mIscGQaVjYEbmRcv8vnk+0Tvy?=
 =?us-ascii?Q?iWpU0pC/TyuKSOG3m3Q7ie/IdsD+dsyq3Jx0xZL8/mzyFCAedqp6U0nF63GR?=
 =?us-ascii?Q?l1ItkEiCZllOI/ZO7oX0wC9pHZx1K+vzPL3dTlk55s7xQCnVcPZ04GSffQ2H?=
 =?us-ascii?Q?g5TKhoed5CZTSBv9AfmmAqhX5mz7Id9HKrVSJk6x6u83ZfFS2F6iYRsEv2QQ?=
 =?us-ascii?Q?4ad+iyYP7cSgL8F3++GTarQ9/ax1McV+60v1Ti1xT0Kj40vQ2VQWJRSW9Is4?=
 =?us-ascii?Q?qiBYDufvSSwDG78tVRKOzeoaFS1T2XU9chxX2+DDz4abxeDzd/P0On/x9GZu?=
 =?us-ascii?Q?ykwEyYj8EKxTpiJr5YWrD3p6iZG6kxyFR6r0NqNQeHLfTOVa2En3LQlgl17j?=
 =?us-ascii?Q?QNaax4ueqTKIwdFZYIpFEYYYUWimIUGv3TPugA0wMOhiA81RVlDJPFFtBN0V?=
 =?us-ascii?Q?A/+EPYqt2uE8banc7T+MSOM/VcOfadKDtLAD40v59RvjB007xVK79pCUswLC?=
 =?us-ascii?Q?ZyBjRmgRBSk+9twIVANx0DavfG9BO0DP8OwsjoN9XeZTK2hq+pdAfRST905V?=
 =?us-ascii?Q?05e0STJSDewNMwSrenCg36TJlYoPfDz5rBIYwvRSBfEiXIQ2+bmS90XdhrJK?=
 =?us-ascii?Q?OjyqNOe/SzStVI8FmkxXMZLPnpkhRHZ0WtwWJdDA5EugBwLtHG9ejDsiFmOK?=
 =?us-ascii?Q?9x6lFD933xu793fMCO0IbrUFFNhyIIjBWmmYvUb0T48cKzcvf+fCFd9gmFEK?=
 =?us-ascii?Q?uCcuwRMsyzj5mzDmB3VRkeOGlB8eoEt9565KpihKznO1TTsQvezgoAUpsO1M?=
 =?us-ascii?Q?Tb4IHEdoxbOD+aMqZYqaDw3EFh229nqTpL/Yb0VbYuejvAdY0xmhZb3Lgm3i?=
 =?us-ascii?Q?R7+P3ROD5mUdGlZyvsoEBUK+1z6VSFZa70nqhoAWVq22XFmrivwMh0rKhjqt?=
 =?us-ascii?Q?Ckp1bPXsG/eYypRsSn7AqnZabW+E4uwMSuQn7r12PeXayxXtcSBMoIjJTIBY?=
 =?us-ascii?Q?JcXoxTcpKwnOXGJl8urd0FuXhimH1EnGG97s0bVMQT9I0crCG7M5YH0Q7vqn?=
 =?us-ascii?Q?NeQS0utGlw8nvXPSL6tqMm+NNlqW8H5yFcUQbWm1sf5gn/kOQUXFJ7IfyUs7?=
 =?us-ascii?Q?uRSoKSbrhZ1d7RlX2zUoSsHRmfibHKV2l5RFnUFAZ2He2hDCn9VVq4R9bX2S?=
 =?us-ascii?Q?6pt0kcDLxiMmvkzN6mQmhj3mKccojBTUFE31BKUGC3Cmfz22IrGo47sXDzi/?=
 =?us-ascii?Q?quAekyXhocRBTja3nA8nfDKHztbyBLHUe/tpCLOU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30401537-2278-49f6-36fe-08db66b0c68f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 17:09:23.5913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbvw4LdrBqEu5nDEviNZQ+6AprGYQK14sHujRLv/V3O8hwIJ4ucL50JB1UAHboF0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8922
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:07:50PM +0800, Michael Shavit wrote:
> SVA may attach a CD to masters that have different upstream SMMU
> devices. The arm_smmu_domain structure can only be attached to a single
> upstream SMMU device however. 

Isn't that pretty much because we don't support replicating
invalidations to each of the different SMMU instances?

I don't really get why there would be anything like a "shared CD".

It looks kind of like the arm_smmu_ctx_desc has become a bit weird
since its main purpose seems to be to refcount the ASID.

But our general design is that the iommu_domain should be 1:1 with the
ASID, so it is really strange that we'd refcount the ASID..

I would expect different SMMU devices to be handled by allowing single
domains to be attached to a list of masters where the masters can all
be from different instances.

When an invalidation comes in we have to replicate it through all the
instances for the IOTLB and all the masters for the ATC.

What we definately shouldn't do is try to have different SVA
iommu_domain's pointing at the same ASID. That is again making SVA
special, which we are trying to get away from :)

You might try to stop your series here and get the first batch of
patches done. This latter bit seems to be a seperate topic?

Jason
