Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA7E6C12D6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjCTNMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjCTNL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:11:59 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDE122001
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:11:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mq35wzH8lA10RzuADTz6m3Piat3EBWuq7A+WIpMy3k+QocxamnNeifS+xhzTs1YCDBoe1R/j+qRTHunXuijxcNM7io3p0JybM4du2zJV7YWLwEtGNAS0KOVJN7u/IxjMpA7aXSgxNSYt4hcOcacajazcVhChH4XJ+M5mO0KC1eNQoHI/8VRXre7XXYKFavGcLDYl0DNVE0MGSJRUFEgbpiNuuw0eKf721xPnYQ6JHruXaDMRq7BSwNzCuL6IR93hHmoNNF9YCX9Vx9mJiHCgxiKxGcCCqyhA7dTLCyXdJ8UBohYLmFWzY9P49ajY0v08d9KkvkiMDAjzbW9BxoR3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AX9u6DGmSx/SE5GXIy8FxXKlQ+zuE5BXp8dcJGEAsFE=;
 b=SzEawTCABoB0laYwqFHawyieVUuDCbFPPXthUjxDwE1jC0oxqpQd7waqTjw69M7E27A+oEao44t3/OGCGKP8iknTSK0GgR+sofTvmrwLLsmSRIflzumgk14RQemzYs8/JV2kc8gaOLpLak4pqXgpzl6CiJfzsBl0SkWem+DEAaaYesUzSNUhRZP5kz6JAN6GRL3mJBgywdCqKdWi3MV1s+QdbqPKw9DnjP1KSVOE530cLTEmhdc2TucP5reG9di4pPgEAeob4bhKlfhK+rrucdYWVYI5QLqHFBjmzbWPEMLH01vbxzg1oxXjmiWmAr8qq7Hu7J/Eyty4iEceJtNq8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AX9u6DGmSx/SE5GXIy8FxXKlQ+zuE5BXp8dcJGEAsFE=;
 b=ewmgFIWSN7SJkgSHF0n2TkkqT8G2ztGCnnockVAJlDBHAeQo14Gt/0II/sZSNyGw89N8v3KywQlUamt5GYVzF+lbCfWtUunBVi6hS/Jb77RfWfE7rwiU+QIKgifoLvMPiUAsiRBup8iMNt8p7sAUUXCA09d7jJ1hOif1JMRggqm7P/rOfzyvkzBu9AGluiRSSkbnQ2hUxCeq2c7C2oEtGKsq1pmHrrKBVZPXNhg/H6JFsoQRP2fiASh9t6LvqV9+6WsM+Pq2GnKAqCSc0E6p6JlDKVJ8pkW2viqSXmgpAHTR4fJ85Zh/SDfyqEA3gIYhZWKSjwiIE7f6wyEaImo2Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 13:11:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 13:11:54 +0000
Date:   Mon, 20 Mar 2023 10:11:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZBhbmqprnux4q00i@nvidia.com>
References: <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAqpOQ+DDvEfq0Dg@Asurada-Nvidia>
 <92fdb06f-e5b1-8534-fb0e-ad47b5be9e1d@arm.com>
 <ZAx2K08L5TIm6r3y@Asurada-Nvidia>
 <ab762cc6-5adf-2515-d9d2-d21d916eb6ad@arm.com>
 <ZBJcS07G3mt7gjkA@Asurada-Nvidia>
 <c753c2a8-024d-5bef-8987-96582084991e@arm.com>
 <ZBOFcenanpRsGFzF@Asurada-Nvidia>
 <ZBe3kxRXf+VbKy+m@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBe3kxRXf+VbKy+m@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:208:2d::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 421218f8-f3b9-4af2-a91b-08db2944ad5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svpFwhhWLyeWq3oerz6mc9/sK76008GLBI9AZrFPt/08MjEOX5ZDeliACCvhp/Taq/l2050PD+dggYDhD7hw+psZbngoK/a0iIwC86JHwoFRczi+UgW8ZKRZWx8K+KIJa9ppiiyoAwD1CPuyVn5dU9sUUiPaj5f1cxrAOQtO+n5O8+U2VHt0v09Lk8HVqNfIwgwy5ShldOE6SYgCGjGkNzaYX/5WAIKw1/reFXsVtzdmrsMof1LHOY/YJvQwpgdgWVK2P5payzalT9TdATX2kxLHnAW8JZuBlWz1756ZVaG8quEAmRO8RYMPlJi3YRgvxN3UBrfxKC4HREPbv3coQ/m+C73tFn6OugxyEZMBjv+wA/Gj28NCDkQpl71ow9eaNC/Z5eFVOZ9wlmdRveKX4XUhqYkeAyb/HWWvg+bRI1gbSiPKzGq3qvQ9Cn3aA34J+nmGqBz2MFqmTwPtRUkADbfjP00mvprD+eYtABHmgZon/be7cPxnBPi47RpblgKOJ2viv4B6pB2iMG3w0wTlDy46uVqBAUQIOpcbJj4xU8KaK69po5/G1D1g08B6++zZeVdUSrmuRhteocM3YRq8w5I+RDLPPlp5xkPBSf8H+NTs0YPS53fnekJcaUbjsh1W5sBkJFEB0xOcKm9AuxHAgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199018)(86362001)(36756003)(6636002)(8676002)(4326008)(66476007)(66946007)(83380400001)(66556008)(478600001)(316002)(37006003)(6512007)(6506007)(26005)(186003)(2616005)(6486002)(38100700002)(4744005)(5660300002)(7416002)(8936002)(6862004)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YAR+XLXtlOACoPqRndOYvnWuEta/oquTBdNjlCpu6rbeRX6+ha90zsGt3n0H?=
 =?us-ascii?Q?2V32cmG6yVwXfVsDEnX7EKQ5z/sz2BDtXRVOyN45AH1uk6zoUavwHveB5n6a?=
 =?us-ascii?Q?uYB923nNWMXug3lYxf7Talv2l05W8ngWfffBaokg+/yOIk9WMiaygqIeVUUT?=
 =?us-ascii?Q?1Fo9Yz6pygz0Z8g7GKNNQmC7FAP7M9ca7TZ5UJYYk9t1SNVGGDaTlhm/L67w?=
 =?us-ascii?Q?ECx8VcE4IW8445vqc5avFhawo/3rD0n3z+v5ITV2lzX5aHkWsvpj6yhg0d8b?=
 =?us-ascii?Q?ShVRI55lm1sOhIKkkP6THoR1ZrqwK4c3dPb6cfm2S2dn3J/byf0kNW7ZYjEa?=
 =?us-ascii?Q?tdw/5a+pzOeG3U+m0OPI/s6t2Z9HHl6L+FKN2tKeUW/jKUmd7Vzgn9wqUkzm?=
 =?us-ascii?Q?WNBpjX14RTQeWsEfFp1LCos4Q0dfwokqNxcbhrVI3oODT09cdDKwEpLodumV?=
 =?us-ascii?Q?h2rDbBovtmC2pLsQz3sXOLViInfnzEXDlxqLSn5ERZDd3qMHXecStBF9Qd15?=
 =?us-ascii?Q?flvysIXhKzNLCP0zgvFTTRd5Xx8D/u9u7eteaLQYvSrKfrWmgIH4JmR/Uj8Q?=
 =?us-ascii?Q?1CQEZcT4lIetlOL5V/ioZZGLz8Rx/a7efmyJpU/2yJM8lUVJlmIRPOnLNyvN?=
 =?us-ascii?Q?9ND/uEFFqNrlXRA2OmjM2bB+0aMhqkAStgq5DUbhzXSKdG9oVcWQbSFxNK1+?=
 =?us-ascii?Q?UJoEeD3GGpt3W6QD+L8il+7Gj7xHp6aB6Qusxl4pTKJsBXDfat8OVTqhOZTp?=
 =?us-ascii?Q?j2DxkCSgIEDXOMtgNmjTeCFWtMyiOx9JSYUzeoMyqHQ0cv1Ai1dk7Ru00CKH?=
 =?us-ascii?Q?2n5oyn6qYIRn0hRee+u2pmUY+VSm0mWlBjJyw983Vw1EnxVZk7yRW+CVyQnP?=
 =?us-ascii?Q?3T4XfybSsTZHV5YESQKV+zPeDIclBJNcv45al+kAhkaRvtcNxPrXcEGH/85p?=
 =?us-ascii?Q?zMH7GFRpWRmTxnunmKDiENt64bZRcG7PS1fGvYJH6zW7De9JIGZ8zl7egd2J?=
 =?us-ascii?Q?Z4gzYVSrMz3brI90qG6Nc2HV7ohep8PDzz8gz9BqHLXviulCQlz0QjeivyTU?=
 =?us-ascii?Q?WDye7kynd1sUz+v7lFlTangP7SOsoFBtjPUOLozfERPCX10+jCWjhn4K/qTQ?=
 =?us-ascii?Q?WOCoNB0FnSx77PsmhvTeuNkoUurTWjgHzWY3XRSPGtBL+2/N9uIdhM+6Iw19?=
 =?us-ascii?Q?3BgvSMV58EKDdjYaWWcpBmaLyUkR63K3BWXm+wP0aeLkfKR0r3uSj+OcCDKE?=
 =?us-ascii?Q?G5nxAf1C+Kj+YMD+QMkjDJuhIm36KEd1VkhcKTeD8B2kRGD2dbYP001Fou89?=
 =?us-ascii?Q?mFbqjc6rrZfVVYVD6r5LZdr5wQ/nHGUAz5j6eBrkBLmZKxOXNU2s7EA5bSuE?=
 =?us-ascii?Q?R50Q0hEFliCQW6P6jU3MROHHDjZWFY8ucSW6sOyzCuHaPayZA/BRzw9GzB8C?=
 =?us-ascii?Q?Xw50+eTH9++pxm2XJWaXizSoGQBWK/e/3sty5Q5a2vM41aGGzMyMJia+rCRa?=
 =?us-ascii?Q?w066hUAq/JATMNwEBTqpoG9MwdDMCTgJh3J6Qvh9LRXBPDcTjDIA+W5mBZTb?=
 =?us-ascii?Q?nfp3vgNrNgXnZGnR01UrgMve/7trzgq+2E1QieQH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421218f8-f3b9-4af2-a91b-08db2944ad5f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 13:11:54.7549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/0tgNWMrPQ41TsCNQFNrSxtJpux6c1IMNSoRMhHDdJxhbUmy22XQmag9+qASU7r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 06:32:03PM -0700, Nicolin Chen wrote:

> +struct iommu_hwpt_invalidate_arm_smmuv3 {
> +       struct iommu_iova_range range;

what is this?

> +       __u64 cmd[2];
> +};

You still have to do something with the SID. We can't just allow any
un-validated SID value - the driver has to check the incoming SID
against allowed SIDs for this iommufd_ctx

Jason
