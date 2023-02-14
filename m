Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B60F696C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjBNR5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjBNR5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:57:34 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65642D15C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:57:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUZ+EyiHfzPza9WX5idX4CQQg3DBrnh+4Mn4qsVOry9aPV65VA6ajkOi5jV1NWlcKi6bhAzrv/MqqCwC8+0c3pmIW0SsRicc2/PeP7DzP0m5HTsbbeIJc+LxyXweR6Pgs3C1R+eYwUrpRh7wOc/vJFU9lkhfWMqFVnzvgzp3YXPzb2IyH/atwADCIf7f94Dk+/W56BY8yMA/OrkyAKPv6832eITMDgonMetbzBoeTKzUQ1LhF1JLy/ravE+pX5WWe8xoWfE2jfbiI0karDjJF7OS6SOcmblXEsAeJHAl45TFFMwduMt5TRQSwstRh7mHfrQzYtIbsGSkeqk3MthSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Tl9VLbLUjZ5lxlwrOO6cDCel2i5Ed6Yts82kClQo+4=;
 b=DZCur0AMOfVaSn8mXFiM3Do9nfXudnWpUtquO3oWHSI1y5n9FPyPUOWy2vqn0uAiARPg5bPQomIbyyPm4+ZIJeTNUekMSr75wtWjImuKlaGDDjWJADmh0/fQWUaOh8aJ0/1M/ixLPhXibOmV+/RFWQHqTqSG7VUCrWvLyyjirl3QSQ52ZO2KN3099TczbijCbzI7DN0LzHWoH1NmMpua3XDZkAoTPJ93GRUAJJ4p5VxI5CM5nn0MbycEBEFVUA50jC2mQD4G/8obyPjEiQ3grBE4pOp61e8w0vP9kJchKWIZC+byfydrjGFwCcuj72umuZ1os1sPHQIy347WvNqP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Tl9VLbLUjZ5lxlwrOO6cDCel2i5Ed6Yts82kClQo+4=;
 b=d6jDjTFfZOfttSvW9hl1imGNAX5xZHnQr8mMJH3NDUoHkL7wNX4Ivec8On3synVP3NkGbnhYmDEWS1H9Fydqa6M4c7OugSyLqN2I4FbxE4bdIatlnQR9+t4PIjSkHvYb+//S7wB4Rpc970JH8BN/btPCJbPN4VqJcg/4u+KR8WqImz3J/agVqCQD8hyxah6INW0XhbT8Crnc2E5RFfjqA3snuQ4fs4EXZuIzBZUljygeZt77jkLSqkM1DaKcs+4XGB3L9Cteb23TvqQSDt+ukeg11kRZ+Wk6yPntfF7P+VwK0MrnYyi11C2jzprvQI1mKJguV/5LtOmSW7+kJofEIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Tue, 14 Feb 2023 17:57:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 17:57:30 +0000
Date:   Tue, 14 Feb 2023 13:57:29 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 3/3] iommu: Remove ioasid infrastructure
Message-ID: <Y+vLiWS3+Rp+If6U@nvidia.com>
References: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
 <20230214064414.1038058-4-jacob.jun.pan@linux.intel.com>
 <Y+tVMRzRQbcc7Guz@myrica>
 <Y+uHSry/tpgGNr/b@nvidia.com>
 <20230214093107.323d7e76@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214093107.323d7e76@jacob-builder>
X-ClientProxiedBy: MN2PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:208:23b::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: b91bc55f-485a-4675-0084-08db0eb4f109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zllw1RlN6rXJEAcdXAATL4ns6qCsFN/K3VQOOWpYXFvGjLgSoqpFTC7pte/3lo17ZKEDusyRmsiFBTjglqJRCJSYAVLnQHt/U3evXXjskzqBpTIVITt0xcGcnsuXeoXBjmNVoxbX7z6aP+2hr9E8v7thio67NtoJxQsV7N0cT6ptOpfiRkaj6XvnTzTgv2ioDPdLq9UKhcLa3jm4G0gmZbd0hoU1NESCis0s9SdQ1GuY/8TorgF4RLBsMwHjSCIVlYVWoH+D1FssDj1ETflDQ4DcHhvLW5Zyw+zH6HPWWvwqzBQei9McYuChlfeyazRbV5TKasS7pKLRvdd9hT7d/Bw8u7eS9oD75JhWIwyNdQv3y0zpJ8+ShJLfJJuJIApgiSVh4QuqkjG7qAcTfU+BdlmdBAiYxjCWPs911DgzRfj5R6xINlYPO5ViFqztLgGlWJABXmCYyeOyrVqd8DYRY1AUBmexBNTUhX1h1ycpSNZGIaO22DabkjB7NGBW0QhMhg3pGvpSfaom2Ly5nsqQzWHCurDODdqNFBQAjSVXkarLNQnKacK9qgB+tc0IPGNm53Gv517uVyOmvX+MWX9xqo37q1bE9Az0fgLfqeiPNS8gvno7+DobvJ8GPDc68KLTypqvuj1sFop/bovuu25pWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199018)(36756003)(86362001)(66946007)(4326008)(66556008)(8676002)(6916009)(54906003)(66476007)(478600001)(316002)(6486002)(2616005)(6506007)(6512007)(26005)(186003)(41300700001)(8936002)(5660300002)(2906002)(83380400001)(7416002)(4744005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?htucNRW+rYCrU3UPb+nmAXE3MjQeqeXBy2qXey56QCqKA42lpB6egL/i7q1R?=
 =?us-ascii?Q?Uyw6/mC+mxrIRK8zJHBcpn4gG2QVicFfAbuCsPmMyIdEt1NbijT3/eT8BZKE?=
 =?us-ascii?Q?nyD48imhLsbfxiZI/x+FMDPh1bmmK/gppP271ltBuytnAdosCJf12TuY8tLK?=
 =?us-ascii?Q?NHwBAQg6Pk7fFbzgIwx2h8W+oo/xUDEMOYzBJeAGfhMbYJyZ3InNFGZX1lU0?=
 =?us-ascii?Q?FXNUmZ7241CVxYoTTfhraI1WwraLZA+fV8RRSyhIHix13VLm+EXjb/ALxgBQ?=
 =?us-ascii?Q?mfgikA4KUnLkdYaZWEN0jAO0st3yVOtfawbJjCQXli5VVXtDmKb7eYOtoLvh?=
 =?us-ascii?Q?2t0sRBqA1r/qij98lpKAnoGP/VMUKR2HD4CftsrMckue/YqhpA3mCSh6tc3+?=
 =?us-ascii?Q?XJIZZs+r7Yq+ATDnNHCatMMXc8fRDF++A4Ml1pYcSccN89pKtAeN7VYKCgn/?=
 =?us-ascii?Q?ohkbLCNumeHVN6dL6LzW8pJYkE+/Gett1ccGAfny+FwKl4WoIWDDX5B0wvID?=
 =?us-ascii?Q?0s0ckro3vhULMPs1wWaqROc2+TYXW2j1OBzaYk6xBsx2382wEi8KhJ5OBUvG?=
 =?us-ascii?Q?4c+S4JaigDNIh/vsPVLVnIPRyb+N46Grns7bNuQGPegS5nKvnT3+VujYEsWU?=
 =?us-ascii?Q?Cls1mJQy9ogrcxeieET+/aKaaoS+/r8lDxKlKd1p2irkuj6OSWux777r4R+a?=
 =?us-ascii?Q?HryjKY5O+/v0I4lx5uzKmnMIl5uJcFqu06qWRK1ypJqymXw01eiu1qHFipmP?=
 =?us-ascii?Q?c5vvt//+Rqv7t18PMb3oMJH7fI9nI9SpCcFD7eq1h9yjS4veFAzHA0LY1t7f?=
 =?us-ascii?Q?ywYAUBMqyyaL0Sti60iYunji6uAgmZx8r+sQ/P8IF43bd478lMwwWrlKlRH0?=
 =?us-ascii?Q?dVpo0CLitkkC1aX5ODR7Bi8EeUZSECwCjFb/ZTQ/CSq6TSay0D30tUhIfbyd?=
 =?us-ascii?Q?WvPKrfuIB/0bYGIFbvFcJxEpkV35pkL40qS2AdIYsT1TBoZoxm0C6BaI80+3?=
 =?us-ascii?Q?jZ/N1Gdz2LHsbHTgKcXi0ukI9ZX2jB+wO2EhZ972mD/epgYvfY5D3qP28+x9?=
 =?us-ascii?Q?e03v3cSEokSx2YZvlVxM08b9fATA0SMNXOgmi8p9kHiyf1FhcK4QuYAsQFGL?=
 =?us-ascii?Q?vForkwrkLaYQl6FSowY4wlsYpy7aa31ci5+OYRas5h8IIOhVjV9kJmblDdHm?=
 =?us-ascii?Q?liSzlcUwfcBkVnTNyQ/xpAI7VRLhtctcc2Vlb8gDa/sUEONSG+bgW+GBZGfN?=
 =?us-ascii?Q?Y/yV9xdMn7cCznVhW1KnjKoDVkO7/FWc/67ksLEwqpGnb06FzNMRhPjLsHRe?=
 =?us-ascii?Q?p07/hTbVw8h/T/08mECwKHBgojXwE9OeG+UZvKimGYqRJE8utY0yjCnwVixB?=
 =?us-ascii?Q?Mt6uvg9cT8oGPNb6cpwUBPwyaWoIIpxJNzGGoPO2u3XjhZxDec+7siIKKz0y?=
 =?us-ascii?Q?9/ycBAwN3C5pSGSK/A0bg0vpr5Va1+K8KQUyuM738J4zTsH7ovlPz+evlGHM?=
 =?us-ascii?Q?aCw4NenINTp9vU5Mxo6FWmy6zOWih8DLmx654W/7FhNldU4rdS1KEZY/ZZ+v?=
 =?us-ascii?Q?o+7wCF7XHlQ+A1tLlqlfS5MheY4fJ7A9EN0eRLT5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91bc55f-485a-4675-0084-08db0eb4f109
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 17:57:30.5108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJ9HeMvUv9SFXudPN6KtbiukW+3+b09A1uLJ+WV23vvj5KJQezvIWi7uz1VH/ssD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 09:31:07AM -0800, Jacob Pan wrote:
> Hi Jason,
> 
> On Tue, 14 Feb 2023 09:06:18 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Tue, Feb 14, 2023 at 09:32:33AM +0000, Jean-Philippe Brucker wrote:
> > > > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > > > index 65d8b0234f69..a95f07f0c98c 100644
> > > > --- a/include/uapi/linux/iommu.h
> > > > +++ b/include/uapi/linux/iommu.h
> > > > @@ -157,5 +157,6 @@ struct iommu_page_response {
> > > >  	__u32	grpid;
> > > >  	__u32	code;
> > > >  };
> > > > +#define IOMMU_PASID_INVALID	(-1U)  
> > > 
> > > Why change UAPI?  
> > 
> > There is no uapi, this whole file needs to be deleted too
> > 
> ok. another clean up.
> 
> As I also replied to Jean, I ran into a circular #include problem if mm.h
> #include iommu.h, I guess I could also create another header, e.g.
> iommu_defs.h to avoid it. any other suggestions?

Given this header is not used, just delete things from it to resolve
the problem?

Jason
