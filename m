Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7446E6C125D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjCTMxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjCTMxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:53:00 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F9040C1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfITWRtGqHOocXyBO7kMfHsgPwpGAv7J+Ks0XHjFamxFSk5RwSeYREEK/qQimh5H6mh9SZBjQjkX18Nq1qO7weIKEHWD/S04gU9m2BZTNM3MtUmnDSXvfbCpv72IRXAE8P7Lh+EdGIHTTvDQgUOZ1KAkf1lPO3nMzeRGXbIcg/Mf/8BXaP5qu3BLs7LNU/3cQHKZgtl3TEScb5L6Pa7eazST8WNcE6LwyZzjTrPsHs3HgxegvEPdLNUCPVT74ezABQZPQlViGyI18GFrOPUmi/8g3Cp/gS2581klxf6xZYYqbZZh72+Exrk753u6y5HsmagSUq2AxijShmskN9+SpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZpl8P8MTpp/wOd6YGcz5L0uTWurcFN57HkJ9pyzIfQ=;
 b=fYLy3xgMYgN6I+Ew5QAFI/KKipsGPIQd31H/BfrzVoL80ZTUwl/Gj+AO9VufCHWWFhTNybPEmpqmEAaWuSXMuC8jiNCNghB06AzldTHrrgNca3BxsBunk6XcvxDbNGPjb8Y/sn9AOUAF5XNhCNpVgrSBl5vO4lnp1xRfADl+uuUdi5IuuDDGB3Gs6VGAVr8IrKCUiPO1Ob0mHtX/4qmKvl6ebsOxRf/52P7m3rx+SAmbXBm4m6xvzKKsohFEkSdTYykhscsbmUp3C5zlR3cP0h6zDDWtt1bRVabNlQlFxSbSFe7uceS/15f1AaGr9BS/FwRbWI+A0wDdrmxBEHfWUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZpl8P8MTpp/wOd6YGcz5L0uTWurcFN57HkJ9pyzIfQ=;
 b=DfkHoEIMRM6aq4mYneDCaFnexgxwR9huizZJ2bxaNL7rtL+/HUItjfvD2LZwC9LH5eKrMewA2wIgipniuLd7PVvmJHzbEt0/xcdDnJEB2b1znmCLAlpG42BCor5gMu9NANmWQYFxDgAzovGB8OCOcILHL2neslDVbjhiUMk720u2M5FhXZm7KYozaO+YCBCsUuEAdZ5JCqLZVE2+yBqpCaAr6xN4BCmHiYkyhg1ARKTM/S1XklcIW6KbOb+nH8xAuNT1SGjGu6/5tdbiHGVsfetorQzihQf6uniZ25/YmEAkAVG9yIKFXYmVt/h2H0UMyS3KX6kZ1fUg6I/cc01Aqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 12:51:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 12:51:47 +0000
Date:   Mon, 20 Mar 2023 09:51:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        Eric Auger <eric.auger@redhat.com>, will@kernel.org,
        kevin.tian@intel.com, baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Message-ID: <ZBhW4i+49sxR1yyU@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <2118a147-ac95-d846-ad6f-85d7cebca46a@arm.com>
 <4938b20b-14d8-86f8-e80b-9d8ed9d8f28d@redhat.com>
 <ZAtS21vqhp7LqA+B@nvidia.com>
 <ZBJvLsfeIRhV6cME@Asurada-Nvidia>
 <cacb6338-6dc9-e8b6-426c-aeed3104c8af@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cacb6338-6dc9-e8b6-426c-aeed3104c8af@arm.com>
X-ClientProxiedBy: MN2PR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:208:237::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 83901ea8-991c-4000-6f95-08db2941ddd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v+eangms4Z63octsgmSs1wMg5Lh/klF4ctzc9Ta3cQXscMq/h8UVPgquNcuJ3TLZq1lXAmXOVf75Kzr/+9EGDUzBncY3MVK1DbHIq1LFvAKusAixgu7M7xp109dqf0dzRW6VUyK8EmHFYI0z3p0fpDsvMzyOSc+kxiM+iF6YPL69CdrryLrL+lfZYWWmTDqrOW+mInIx3t7Pr/L8a2lMlCtZRqcWnNqXXDqAOAXNFMuoInHtC+0yYB52dngLheumOKobsTuP0jKU2P3OcKBwI/EIY8mNVCE1nArk+k270Fnr8/O7etcd+NBwCwxTfOCRt2A8W3SndnWQ2EykyE6+oPngdz9CTGMzvwOJvXxrsARFQWcmV714F+SAkWwg6TzR0fQi/5i+HGrMMt3GfNo9Cg09KoxuynLUsZTpPjl7RyM/m/ylRKzQ7Gt53SGoqSi4SD5/TtLKtJ+aqxTusR4MARl4NuTsHJ5SUxgvkOEXDv1wDFU0+Okw5bXbIci2VePuXdKKxXAlO7Z6G5X3bfm5W2bmAx9fG8liF/F5oGBkM8b+NGs7/bYOnysXolvcxoIqHTTxZsagBC6oRha+H897L4ODV3Fkdgv4B+lfeX8PCnFyGjnoN8Fbt3eDpse/vs5vmNo26s8f5cF/ix1cbvVnQ0/FBVeZNt/Og7ER+9dS2ihV+4q+Nl19U6XyTPM5oM4+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199018)(6506007)(2616005)(26005)(6512007)(6486002)(8676002)(4326008)(316002)(186003)(54906003)(66476007)(53546011)(478600001)(66946007)(6916009)(8936002)(5660300002)(4744005)(7416002)(2906002)(41300700001)(38100700002)(66556008)(86362001)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5sSjpZyD/EEPR1vNYBv5LnJz9QGiJBBbYN2ofysFsk7C6kNDRcB/+ZqQaUHK?=
 =?us-ascii?Q?sB2QDjSykQhcj2dxqNNov1XSxbEtsnMW5JqyU9+s4O4bKTRsnStpNXTSq8lx?=
 =?us-ascii?Q?bTRObdG1xN4z82CTiLLgSRm7SHT/WXvfXe7BQAhuSyMaHo4XtY6F3aXZHfmR?=
 =?us-ascii?Q?Jb+opjHDr0fetp59RhaxXZ49IORJKd03K+K+rCnIoccGYp2Yt5r4o5vQOnWd?=
 =?us-ascii?Q?gfHLXzHlO+LRtPNI38EPaW/Cqr/n0NdUGJP6mk9wTB0ui7KudESkLi4HuKVs?=
 =?us-ascii?Q?McVN4VmHFAlwCunAbiSJF51c90nAnTLFR2IKHVPFuBw2AoZyGGXT1vlLuGhV?=
 =?us-ascii?Q?YM7eLqMbv4zFAA3qifLGS+E5jiw6l+ddjLgOFuRT6QOs6GdzUR0Z98/WOatZ?=
 =?us-ascii?Q?9K4qUAfO5R0Rb5srHNFssZTVSMufHvgZN73CJzLuUgg9aagbgwyjSF65Rov0?=
 =?us-ascii?Q?TkTNmYdMhpd8DjKG3ZxWsiDCm8YR4LWZJrxI+XBjfqNDdOKjPE0Tqnj1kxhg?=
 =?us-ascii?Q?KO2pXcuPQSLRNx9Jr4Bx3qfc07VbynMxAFNAkGL5IqjqbHxOKnzLrEIrTfV1?=
 =?us-ascii?Q?pUECq1h9deaY7IX/OkS3DqZWZA1T7seVCzF3Hkl7iKiVZ4kX7jnQvOEtMZNg?=
 =?us-ascii?Q?MGKKI0IR0c/51KFd6LNbK602ZRDNj3mK+hMuRmoWHTcVgPBIuo88x0brcIjz?=
 =?us-ascii?Q?akc0kA8RTTsI2nSf2iUrjO+02HULPeMEkf5+wtFyWi7MjAUVyqj/gXWacvNg?=
 =?us-ascii?Q?6dj2ckrr3eQkvZNRp6GtaY4uL18IRBqjNsIGLu/pPlm6RILyjZMK7XWjo+Cg?=
 =?us-ascii?Q?reKNqt+pB7O+CnUfhKrAVVEcn91fURF6jWxQrCYy1NuH2tTI25tpEhOHfoOX?=
 =?us-ascii?Q?O8Igb/M1SlUeOYGbYD7ZpKAQ9SAHO9xH2RVlp1bHlyozq4NBVwadhB3m1zIT?=
 =?us-ascii?Q?Cmd4v/mIRnTFEHlozsg7fnU+6D14aqmOAL9Q/nJzcYO7vrSw3cmmKx9VMG4p?=
 =?us-ascii?Q?28FY2LDg6oJgx7ELJ+7+4aouNESSbGTHCjh20rN9sFZQLxFcR0qta81CVtvf?=
 =?us-ascii?Q?Z2jojqWcORSwrb+cP0R/Hm28v8KP2qIS5TmS9waZYi2AiY/AIg8HqEtehz3n?=
 =?us-ascii?Q?ggENBMHsvJnFB/e6J2uHcNQeSLqCFKp/8LCX6FKonq1MpafwJ/n1S0C/1nbx?=
 =?us-ascii?Q?QTgVEMW2styQW8GVRlHFQBHe2MO2P1tfwa64532Y2R0aB9MrO76SF1EBcPIP?=
 =?us-ascii?Q?KCnyFjtXxwwNJsTA4hfUMv4MpkLBjIy7yTgbtrWUbk3lXOp/A+xr+b4ehlkn?=
 =?us-ascii?Q?P9PbR2wFIlVclgCkxjydinC55V6qAvIpRjiOu/Amd7Uyz3SjeIjnvP53nkn+?=
 =?us-ascii?Q?Hhw00mJNWPsTvcjkzQ0Vw9NxrRhl7cpzgLVvk8eYaZuX95XLvA/LTeoA/hZ9?=
 =?us-ascii?Q?NnwtDw6q9jUqNBl2sNT4ZW+W3iPmcQxtAAyH0XnOq+JIxMuWFmQQevd7akKf?=
 =?us-ascii?Q?vARIOV8V7Ots70ZG6Qkx+O0gVqhADD0s+ikxN5ZKudAx+eJWmEpCPlHpdHLb?=
 =?us-ascii?Q?WM6276F/yVivgF2KEdKiO5Bk81J+U4YChzhZQlO2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83901ea8-991c-4000-6f95-08db2941ddd7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 12:51:47.7834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SqzovZghhhfr7XL7hlJPg6XHI6yTdcR44HzmZUTZRc5LE88Ff1PKatDCoge3FWP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 06:42:07PM +0000, Robin Murphy wrote:
> On 16/03/2023 1:21 am, Nicolin Chen wrote:
> > Hi Robin,
> > 
> > How do you think about Jason's proposal below? I'd like to see
> > us come to an agreement on an acceptable solution...
> 
> I think it's so thoroughly broken that I suspect Cunningham's law might
> be at play, but fine, you win :)

Not to belabor this, but what was wrong with it?

Jason
