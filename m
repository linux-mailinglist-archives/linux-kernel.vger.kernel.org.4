Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A76F63C67B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbiK2RdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236636AbiK2RdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:33:16 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F31C69328;
        Tue, 29 Nov 2022 09:33:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8WpEOQ0BuM7yOQVbr2pdR1H9ZCOglrpIeaKvbNrDX5qkwwYEBsrs8xPAy+0XpgKFSJpl4g6OgkyJvKYtRcplZMy5mi8qgFT9BEFwhj3TaNJscCCMBIeSlGTh74G8/+gdnTPZ9GJe0mmUSLC0iiKQbcaRQM0oIDRtjBS0GcLB5XRCnLz6n0lvUdlac2tJQgwWwbN6ZqqKR9QNyLQ0tSmVEGT1cXoncEAV3dZYTOdY2qWqp21Zt0xzmRu0LeY0Ue1dwH1ubtOOwz9fMVZ8WdnBIks7TMTv0QRfmjIDrn4dRwvVTxdI6d0vF8Vvf0LaMdR++bUhA2FPKh+M59fgHyxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mfRvJ3IgB0Remea/T/A2PtFhTC8v+9cvPa1qsmCBsc=;
 b=FE2ENb7eTahjJYQf5/Sw6BzSYs+UeezZnomqYvKR+GhI7G3U6b9Pi1WpxKE47J5AhPj3r98Y/PSf5yJgQx0QYcdm4I+teOk/injPEcr1oRmdEKUxcI1T7xcRGdGZBFjFzsIhVGCdXAgcqGcRGWprbAi4CZmQxlCYdnYOpWSvVdtqymQ0nsmJwAeXaXVGwUWNs2TNsS3OPioVbMSfo3pwX/TvmEikhgZmZcJUxATVwiW6LG9Sjuyo35uFA58vqsqeNt0OC2eSC0R7Fvi41ABJNWHoV627juxpxt0cZGpIx+aJTrAMJv6yozkP+vzZfJV1KV75sa2Cg/srfKswXzOD0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mfRvJ3IgB0Remea/T/A2PtFhTC8v+9cvPa1qsmCBsc=;
 b=Ea0xi1CqKDIPm9+ThZeqvImI9AoXFkgv3D7IU5opJrN3CTY3IJCeXI2sPMhlzOp3hG3DWD/lHuwj7S1Wk3eyC/H1fHbbiqEOA0tWn3CGCY6acr2D0QtEVJFt2jzcgoN5y0CsaJNqwPUXQjgHzQBn/No99bB39N5u6WSBk2nsNo6qMbOYOkBvkCMDQqjTa+Otf8UJIs952uK9vnHar3SrB3QVax1q4qtOBNdvAEQNJCYny6Dl9yXOahOGSwarzgg9F9iEQ0saHK8i8cCI0LQxGAbC2LSXLSCbfcPJPW/2PQv7q3tGALtz9Pa74+vfdDJ9UlQ7aPfoLIIIYUdq4VPheQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4588.namprd12.prod.outlook.com (2603:10b6:303:2e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 17:33:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 17:33:11 +0000
Date:   Tue, 29 Nov 2022 13:33:10 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v2 4/7] iommu: Let iommu.strict override
 ops->def_domain_type
Message-ID: <Y4ZCVgLO9AHatwXe@nvidia.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
 <20221116171656.4128212-5-schnelle@linux.ibm.com>
 <33eea9bd-e101-4836-19e8-d4b191b78b00@linux.intel.com>
 <9163440eb6a47fe02730638bbdf72fda5ee5ad2c.camel@linux.ibm.com>
 <Y4S3z6IpeDHmdUs/@nvidia.com>
 <52fe7769ca5b66523c2c93c7d46ebc17dc144aca.camel@linux.ibm.com>
 <Y4TjWOXYD+DK+d/B@nvidia.com>
 <6c4c3a3e-1d8d-7994-3c03-388ef63dddb3@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c4c3a3e-1d8d-7994-3c03-388ef63dddb3@arm.com>
X-ClientProxiedBy: BL1PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4588:EE_
X-MS-Office365-Filtering-Correlation-Id: bad90f02-1edc-4d0d-ff76-08dad22fc9bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kc/xakKIM3YNxKTPYIhlBVIBvyHzrBGVXGHNW9NjlhKZkcupgqDEapBUIq3cm5dWDDE0B5a/zmd5F4whXhdDRezvOaqYrGxRVmWxJWaPrxd6h3aMUS70Jil6jznRJ8uDYEdA7EMsYsrUxTe8MbOSuMOGJ3/V3XjfCkAPL5l0uDhJdd4oh2NnDnafMvJnvnS7S3c1hbKtYPc3Tz3f1pbtkWhU8wMimdkDKse5i22gRCN5UNVo2BM3EIykg2ZvBcPV26HwYejyC1MvasA3nlfPmjKZnYKWBd+qlNn0Dk62+GyuP6qsAuxZPmBTgP570S+R6OhCencIkDP6j3NampkbMsfzLcMZ0H6JM7E2AK18nJUxUS40PZKhVFKr/mCEFKZQONC1JvHt8EhNvKJHhwZVIYcj3GY3XYmOk2cfDjJpBo2knO0zCUexWxx7DdcHfbk4M1SOjX24PssbNz7y9EbWvuwFHrpwBf/2o/9CBxUztEDAqt2C65ciS8i4HmllVPBOS61ySf2Yyg1tW9OlNQ6wADA2CyJsxT2O1szRbId8eRNRZncDO1qJNzVI7MFX+lebLVm3aMCWVvpjeVd7UKCv4B7OIpf1bjYoN43vcq2r3GigZlowfDuFvNG/9MUFRS9u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199015)(8936002)(5660300002)(8676002)(54906003)(186003)(36756003)(66556008)(41300700001)(4326008)(66476007)(6506007)(6916009)(316002)(38100700002)(83380400001)(2616005)(6486002)(26005)(86362001)(6512007)(478600001)(66946007)(7416002)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Nt+PANYRhzBnJ85FVTAxknOclPshJJ2nJ5qJcop3V0ldqDELrOljbtKX+fK?=
 =?us-ascii?Q?PN4boOLokDSsiEzjpy/0VlaIuUzLX8K3AXqI6H/2RrGUTG2sPznGnS3kVjxq?=
 =?us-ascii?Q?iz9x/srDIyUC/L7bAE0qjatz46Ofvz9EqWwHlISFs/9AyL+POIp7KIRUUcNi?=
 =?us-ascii?Q?wJm/cCwdXXtSxR0FnZMdReE541NPQar6fbiK2NQZPKg5TC9chk+ndF1+SCih?=
 =?us-ascii?Q?8CAytB8PXcVRpuySp0rzizINKivweZnOXihgbG863usPwfs3Owlduf7/4Y2+?=
 =?us-ascii?Q?zOiTswpubtX7q09V0AGIrMk/QKU2IebUfU+W3HsXEf0eunHC/qVQpRSYhCU4?=
 =?us-ascii?Q?ZeXFmA5vUZYrl+HKYR7f9DGJGO0XPV9vd79zg9ZPmE4ncbwYoPPbKGVUjITl?=
 =?us-ascii?Q?rPRSEI+cOsGMM1Ok2+yLraCTElQQFmVow90t03zq7JSSecaWJ0uQRgpOfabS?=
 =?us-ascii?Q?SLiYWZ8Vr/AGGHNy/RrujhZP6+ZfE26hVdIKC5keWiyeb0FuIXo8dunUymRS?=
 =?us-ascii?Q?Bep+hyTQMpUTcxGpqi7s2b0mM1cDW3A9PArxFaROF+sbSnQSR3hVPzlECYWR?=
 =?us-ascii?Q?Fhhycintd/ifUJtBPKaFCuMGMbTemTiE3yS/U/JbR2kEEvQpD5PhcbSJdaZ9?=
 =?us-ascii?Q?aYGWdLWkdZo07nTcn4e+jJnLyBia91HMHaC9XRCTH47zm+fqixYDv9xrggh5?=
 =?us-ascii?Q?bXDjRtegrWbigcZ1IyoOcBdThiTxgBApAy0bKv42QGcXUOspKShPSTkU/L2z?=
 =?us-ascii?Q?1Go/v5voi4yrEkds8vNpposKSJeQAombzYssePZyslSDxAcaCPEyXKgsTrE7?=
 =?us-ascii?Q?oWT/wlCBIVDb0YqzURmkpTF7HsfGOHbtg9Td56niTy/kcqCQV4UEQde34XTp?=
 =?us-ascii?Q?zmWTcthKZqWCjCxLt2NyKlQYEmrA/H695/nfQIKAtEvXnJKpPM81Lhd4jNzB?=
 =?us-ascii?Q?FOJm0w7xfAXe+Sv6aqSwg+5xyNaVMecfWzgUWhdoGavStWTsClcl9618e3E9?=
 =?us-ascii?Q?xzv+NN+P/gPXg7UiX910ZpKg9gtHgfU/uzX/ggKkXyCOZUORwRstpa5yX7Oc?=
 =?us-ascii?Q?vz5KzkQocCEer776kE4Q97ossU/RKpK3c30o+AKu6FYnI4yG1AkpKVsLShPW?=
 =?us-ascii?Q?5vTbYXa698zgQnm8mklj+rXY+Nifxw4NpeEecOiPjNBbJrs3rs+TW02yTjDl?=
 =?us-ascii?Q?/Upf6KLqaac0ELTRqc1SBNq0AgbZFZG7WHRQHjdvtoUkO5VZ5rLNSiTA7XKs?=
 =?us-ascii?Q?T8tMMEUAG3ClByo7yQ66RTsado6TxS/FtIsigH2I2Mo3nX64m6Tu+fulUWnW?=
 =?us-ascii?Q?g8RWZt7Q9cZ5C5ty2mYVSRIsGemo55riisK64SP/Pu1pFdkQUT3vescRMpWi?=
 =?us-ascii?Q?wKHM1T9Zo9rQq4NPxIZywdO68EoAZ79JivV58QwRAOoLjRHTgL+kAhQIFqiD?=
 =?us-ascii?Q?24AsC3jjc0cztbKqotYNX7yR4KRiwL+b9fNiRETusa0yYnaBYCJOrSvrazq1?=
 =?us-ascii?Q?87vff95uqyEgqj3mXY97Tzj1t491Ay2Mje2brgikUrdQg5XVlUuI9yEi+DIg?=
 =?us-ascii?Q?r65jPeaa9tegnIO7IKc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad90f02-1edc-4d0d-ff76-08dad22fc9bb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 17:33:11.8058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMlCkp/Em+edISWqGn2svmXA7ve0HdBc95iRZKoGU1rw1Ix757pLdx4iWE92EDxX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4588
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 09:01:43PM +0000, Robin Murphy wrote:

> I'm hardly an advocate for trying to save users from themselves, but I
> honestly can't see any justifiable reason for not having sysfs respect
> iommu_get_def_domain_type(). 

We really need to rename this value if it is not actually just an
advisory "default" but a functional requirement ..

> > The driver should have no say in how dma-iommu.c works beyond if it
> > provides the required ops functionalities, and hint(s) as to what
> > gives best performance.
> 
> That should already be the case today, as outlined in my other mail. It's
> just somewhat more evolved than designed, so may not be so clear to
> everyone.

It is close to being clear, once we get the last touches of dma-iommu
stuff out of the drivers it should be quite clear

Thanks,
Jason
