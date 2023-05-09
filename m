Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AF96FD2F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 01:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjEIXGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 19:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEIXGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 19:06:10 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008A61BFE
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 16:06:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZV8kPkfeBAhz6rwN8ooqxKH3UHPNzMlEGdPMBMPZ/w5GtGPHH31KiEOWrEzR/+pN2OaUlnhQc5+oh53Z0tXGIR0k5CIwQg5j2rapFVkq4A6xG2+G2oobUvGdZ21+wESnuQuLNJzCQSBHZYNOwnYscbWkQFE8LST4R7Ftiw2bXTcr4Lu6HjlFUnSWQeIQcvGoL7oVFai3zCdaFTTh96+TbeE8GOzo/ANDy7Bdcgz3Q6fafqNGug4jhU/W1B79VjD41b7QpD6gROQm1FY9E8lEvHpo8lTqT+l7uBSPuxrVQy32vIILQoPaKolM/2bk+Zh09h1EigYKafc+aQ7lmoimaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+E4ic5uQWQjKHNb+O3IOZ3y27j5ZYKekQtIv5Il5q0k=;
 b=ZEIF7CSdaOhMU6Bx9s3PoXeuLAVq9dID2k6OFRhI9ZAnSPviC40hO1NxSKkZCWeiOcM50MXUXg6zFuu+uSj7YiIXQBPqwObnu7rJs1+XmEeV7lNKV73vV3slUXTPJOgTAwz8Yf3bpBNdjWhV69V48nc8Ffkor+mbjyo5aqhucw9OnK+0tMSL1PEp834263RXvQ0+LPJAyUSwNVkdmz7PLB4nzKoDbHJameZ2+VtqAMDtkbR51+0glIUy01pe4P6EuoH4iNyQxD6Q9Wq88H6T8+G6xcgpcF+VXPVNa2snpeRf+5xdECoR1iBoBeyp1CYmMtSlVqQAONV/KmqbCoyAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E4ic5uQWQjKHNb+O3IOZ3y27j5ZYKekQtIv5Il5q0k=;
 b=rBF2Kwrf5lAhvVlLeUt1/ou08b6EUGHjpibVgIWXTwgN4N51wUVbHyR4RArCd0/ZeXFwlRs5fupNtvnA0SB28oYsXyBLGxt9KdQWhHY7XJOgUy9NUzuoqqTo9ock+Btxbiox/sVZR2R36XPXPuOF77bHv1mVxt4gsZpvkJgBCwFASmYPTjQeh7JfB9BNYAfABzLVTbY/GhqKPwc1ejDAUUS4/fIbMHnhp4vZEaz0qkduR3ButGyFNm9xMpLUbJmEuKwS6qXmyfy9Fatbu5Q3FnPgLYciWADAzHj9KElUf1JGWpTHRBw81fTSfQ4sRY4omhtwpYO1nv6RxAFwlcwkng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 23:06:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 23:06:03 +0000
Date:   Tue, 9 May 2023 20:06:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
Message-ID: <ZFrR2XEuGWpZyJfh@nvidia.com>
References: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
 <CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com>
 <20230506150741.2e3d2dcc@jacob-builder>
 <CAHk-=wjmOAQnqJF-pW=fzMXb_Rk_J_Oi4ESBLmVPhxwBK4xfGg@mail.gmail.com>
 <20230508094014.53913cf3@jacob-builder>
 <CAHk-=wgobPe0U=Sc-PH08vF-ZbG00KrzftEpQMQ=n0LLNn7y6A@mail.gmail.com>
 <ZFkpk8y8mUZuZjkV@nvidia.com>
 <CAHk-=wiv=Dm5diw2N-4Mx3k8iYWNfyvjzrQxB3JxVLC_7cuY+g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiv=Dm5diw2N-4Mx3k8iYWNfyvjzrQxB3JxVLC_7cuY+g@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:303:b7::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: f4512eb9-f2e5-4dba-dbf7-08db50e1f678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: arTQP6d5UQu6RqtqEhlQABc7anr4Ga6XXf8f1ivJj0J7rbvNqbXXJvyMg7vxqktvZ0c5bPOFGNVETll8qewqquA3XbtVCMhbl9379dKs53UjVrUqE66933XzBjr4ZhQ6yseu3cdmb+vBTMll5daX+z7V17GOMdcu/lME2MaTMgjuLUn0Q49W8NtmgxR4exe4dpuqFF3+olk35A/R99kJCK0Ny1amjxyguu75iKqbVwDwre+09Kalsj0bd9T+a/LcQnyis9eLSjN5uiHmikFZ39dFHaYioRRWsLZX52Lwub/Uljvbor6oUqtSSAyLbixPUcLOwP4TWkhqXz1pPB4ddBxks389dLXlgjcKt98c0XBFzrDTg3E5eAasSwL4arA8yKXrZrVa+FflvhiNi0wHnqc3pahXItrpP015fexcCJ2dp+dnOQzGGOQY9mka7F/9Z3eT/5h2yZRCmJLu2csubXo8ydBL7R1fkwIuYs/fRFmcsXRQl1G/fahdOyM0M1ygbRfv83lA6dPShYOFr2Loa7SwWut1yMl61Hr8kiK2oUrHhyZWhRTv23oSW1IjCb1o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(6916009)(4326008)(316002)(66946007)(6486002)(478600001)(66556008)(54906003)(36756003)(86362001)(66476007)(26005)(6506007)(6512007)(83380400001)(2616005)(5660300002)(2906002)(41300700001)(7416002)(8676002)(8936002)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EIq5O4a/q0vORPIgyw4eSFJaD9kGO/38aNr1U4gm0UGN9TB+Zewr6+oJqyFZ?=
 =?us-ascii?Q?iiqiEn29DIB/fwV3xflSTNcyZaq1R5UurGsTaEFrg7oJIg5Ode3qYjphiuaT?=
 =?us-ascii?Q?GHxKwjOMamdAnuf66z2lmLOGJja6hiq4DbfjkU5RY8y5bIjxqzV3Sii9BN4f?=
 =?us-ascii?Q?+MlnfOQho5M5h5q3NjpVVJs/t/MBVEVffPtSqOwLusDPGf4D1h98GZmMRsf7?=
 =?us-ascii?Q?Pgr/PTduM4bN7Tw+0Jq+nrVCZrY8p5FDcxPyLBJPHjcu4MlQOEe8ajLDKHn9?=
 =?us-ascii?Q?MRh79V+DD0zpz66M8Us5evtEqxqmiQis50QsU596TtqJ53T3UNAyKIj2rpcm?=
 =?us-ascii?Q?q4Ifk7LeT+eTz2xgkQe/tIdzT/AbKdGmNA7wvDARYuocVi91CV3d79ZCoeEp?=
 =?us-ascii?Q?Cz3/PjOEVPfDd/RVLl12JN6msSpgMF7PK1iLi0msf98UnPqt3O1sTDpMU650?=
 =?us-ascii?Q?oLe2RxYVwr/CW5LH/zj6j9HW3DLlu8/GucEs/Dtjcck7KZ1+KcXfm82U53Le?=
 =?us-ascii?Q?GKBo6ICtqFg3OIrkMxCJgSy39HL3iV/QQRwZWCXJR8/CDa2fn/tzysB2Ag5M?=
 =?us-ascii?Q?9XylqyEMyhw22BOOwDl75WUoMw0Ap78tOzZDJSQIPaKuA4U9u/4By/PQJKwj?=
 =?us-ascii?Q?1d+saZNfiPCjdoOk5xHKwCAtXHzoaQ6p/UaZjyiJFzixxNrHYwaDRuiEf3l3?=
 =?us-ascii?Q?Ji/j4sl73HoU6Mp9IDbssJYfg1Mt9XxT/sMn016zRs0qEu1Ie1eKfA5rzvOu?=
 =?us-ascii?Q?/+9Sr1BYGJuB++245CEYeBWPdlgqLzcJSl0NmcSlyisBpuyX0FMqy5w4BAPa?=
 =?us-ascii?Q?QkH/nMOWDW0f3mgKbuQEJ9LU65mVLooGl5NqsupO0NOVCmX7ubbgX+EfIEgH?=
 =?us-ascii?Q?66MbyMqzhqEltY6t2xwLolF15qMh7ajeNQlOfCLGau/ZZ9Gjl8nwc28Z9RMb?=
 =?us-ascii?Q?x1DIRNP2SOXOTd6bcA1/LeBUPpPx5sQ88QpQ5RIzfTQe8+LDbjj7HPDAEC38?=
 =?us-ascii?Q?XnvztOGHkSzN0ie8lX+R/f0MH5vwPfwpAfju/bEol8yNOMQrcUB45lyGDynD?=
 =?us-ascii?Q?y3xh5ty3ZoKc2+QOu1OHHM0jzfFLNx7wXRcq96qJ++unEsBlLVD9NZAmset6?=
 =?us-ascii?Q?NCNrhN056ibeIEECGuMOprJe6Xsw5e82zCpoHZrA19qsJNOYefg6LzYrUHAf?=
 =?us-ascii?Q?s+tdJCv9NdqblZpkn43Ex7Ub5ww32Ug91oaeByiCS/XPb4DqP21ir12b33HG?=
 =?us-ascii?Q?lxaVWsEvEPW3zjmBeTDrxH/4TrgAJY1OrGp1L6V/MXeUz1rZwP81QU7wl7yE?=
 =?us-ascii?Q?asoF+dqeAuSANdHCg93QOyWNzlD0T2ghZsZ4QiBiIJEQcA7LvaJBs2nkxoYb?=
 =?us-ascii?Q?JGctK9gQV6z1HS2Ggseq/vyXX5crJ0ls9drlnW8DSqbdm0YFsldjFB9QynSJ?=
 =?us-ascii?Q?a/M4PUIkfqWjR2LJdyLCn/v4hEQRfSXMbNNxdghFQ0HiqPH3oNvPQHtlUxH/?=
 =?us-ascii?Q?qHvT6WJZCi6ehyr7sg5qSL0kHZvgRjNDAN/Vcvj+syC3o0KUUu+lJNcCOByq?=
 =?us-ascii?Q?TkPeHoQc5I6XFDOmhV0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4512eb9-f2e5-4dba-dbf7-08db50e1f678
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 23:06:03.7345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UR4qIXRBALQKYHKgOIksn8LIXDk0O/NK+alkqb12bH0RJFtPgstD4XaltKaBvAHK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 10:17:53AM -0700, Linus Torvalds wrote:

> That said, the arm-smmu-v3-sva.c code clearly *also* uses pasid,
> except it seems to really want to call it "ssid".

This code is incorrect.. It is using the mm->pasid to try to deliver
an invalidation, but our new design does not restrict the userspace to
a single PASID, thus it will fail to properly synchronize the ATC in
some degenerate cases. In general the driver needs to be able to go
over a list of PASIDs that the domains are linked to and replicate
invalidations (of any sort) to the whole list. 

It is still a WIP to make this driver implement the driver contract
for PASID logic properly.

> Now, "SSID" is a completely horrible name, as I immediately realized
> when I tried to google for it. So arm64 is just wrong, and we're most
> definitely continuing to call it PASID.

Yes, PASID comes from PCIe so we are using that.

> I'd lean towards just "CONFIG_MM_PASID" or something, but at some
> point this is bikeshedding, and I don't know about any possible
> non-iommu direct uses?

I don't think there is any other use, IOMMU should be the only
consumer of PASID, so it is a fine name as well.

Thanks,
Jason
