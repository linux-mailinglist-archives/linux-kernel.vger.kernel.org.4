Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D716D26DE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCaRom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjCaRok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:44:40 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6AD22213;
        Fri, 31 Mar 2023 10:44:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdUCwbuXGvYXILdeDZz5EhV8Iu5CezrpYyFyi3dx+HB8SOs5BB2JrruMDR0svbe/+FQe45CVeM+2GHNkX8X4y98q95RHwKRMvAKV2qYzqXDCFWAIDRebUpna9QCeZv+OLzbdCgJ3qizvnheDIrFzssRNZKUitcqXkdLTFeOJMMXFcVNC6HlssG3a04h5xqX1vD42sXtl9bXfa2mE15MguZJS3lzEHo7b9k8p8q85a5GG6x4w4GEL7hvZrz2/5hSWDiIEby8pW0cMy0ft/wTU6IoN/9dYPNZE1mbrBU81MnyV50ucO0wuXCcdoc31RzN2Ekxjv61u2VaXXmz1smgu5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eu9ZgjTGEOhC6ko+7tm+Cjdy0653VAr1JLRWalraKgI=;
 b=WIuFx9ecbW6R2ZoDUFSE1I82UqivzWF6ATwKMiuu0vQjS0IvYKlvdo3wzuHuhY5mCf/c+baIC06eAdwXnHRrJgdX6ip1Ee6a+aZCJsMlsiWHn1gTqZYzS1/sEQ1w+pS6lUFKXhcGngdby77ksMG/UP6Yp5f0l7Gt2OVSKFgSCOp4YkmEeMBgOIpcamDmOhW8lWuH7iUT3Maj54U4+cWEiqL7ufbMKrqiCTXRoflMzX/bQNU/oJszBq1VLw5gcv5dbX2t0jovB5PcPuX1ms7vd1e6itsvspRajGCQcSMIkVewsTqbdSM199pgin41VjFdoHu1+ydVu5dPOz49ncnLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eu9ZgjTGEOhC6ko+7tm+Cjdy0653VAr1JLRWalraKgI=;
 b=bcHvL6rgtgUBTb5E6La7965kdN5bY8+jV040a1dwxM2ed95sbnnzm6XvKTufrfOTRxOZrB+1M15tk/2R37+KCpWsOIKc4aV93VKRazOLzh7/FJWcJdNwbSo9gR8bl7Psj8QtVy7V0aVEbaUA+Cx0svC9CzW0dB8RDlRH5AnQsL3Z1R5FXBtqml8e+5GUjsMBKkf9X27SRIh8FwCClTmEpZvUUhHv/6GILw0Jh7O3JPAkNzBe5m2c2SW1O8A9Et1KMynWn4QQ2k3/dE2NVRq3FXgvQqVLnTMOIVVdp1ZDYmfttnhxppKZYh4KDXsSMYhJmIwjahFM53dmxeAsgFrHCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8693.namprd12.prod.outlook.com (2603:10b6:208:48e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 17:44:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 31 Mar 2023
 17:44:37 +0000
Date:   Fri, 31 Mar 2023 14:44:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Yi Liu <yi.l.liu@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the iommufd tree
Message-ID: <ZCccAzdcYLio0Xoa@nvidia.com>
References: <20230331153146.478c4d56@canb.auug.org.au>
 <ZCZrEtNH5YjGjRqS@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCZrEtNH5YjGjRqS@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:208:23c::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9d91f8-55fd-47c8-3202-08db320f9882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LbvZywZH4+ZYCOePtioOhNob7tynxRX4UemJgLGkAOHMY6FV0VveTH6ml+JG5aMZpCUoSIAdS9EkS561hnUtMh93Ada9O41J0vL/qktFyL3D1HmzhtkFzbl+5ArRj0IZKDaYnS0XNjtD11VwxmB4ruYyI8OKozL1r4beapFl3s7hoic5G5i9CcbgoH3LxYi6UO4j4oGYCmxxXEuMA3r5fZHHGrKrx8k4ucFt0cIdTp1Uu/G6TvVn7qt7y7u73Yyejqr13ZN27Wy7RA9VP6072viAZr8CI3F6Dw3usqZAvWBw6B3NKaYX1dTvstAQTwz2+K9QNIxJCgGApM69Tz/rj5ZKjvj0NE4ix2jIvB/1qXWiQPISre+FAtIkWO0dUAcTLUJUpMywNKOZOyRT/q9dJWCtnuwkmczEUwWFDImRrxqzX6T3Q8gZfTyqrFmHKF0J6KcoJ1kiRaBz7AGIODyX1wBCS1qswTQ3LPiVm8qYHsLYEpkfC84NqZjT8wHEDbptGBBanZNyu2gjYzBnRo+zhDvMnxCdNzzsjohs8gyU3FNmF6qafHxIxkvOf9LAQu+w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(38100700002)(66476007)(6636002)(66556008)(4326008)(66946007)(41300700001)(8676002)(478600001)(54906003)(316002)(37006003)(86362001)(6512007)(83380400001)(6506007)(186003)(2616005)(6486002)(2906002)(5660300002)(36756003)(6862004)(8936002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UKGg/773mh6iuZOJp0qJvEO4zDztJ1NLJSKrDTx1cwYrE5iT5QMO8LmwzPk5?=
 =?us-ascii?Q?k+nKNNW6P422U+PLc0Oyztt2l9D+IVzSmEh+BPCn8RBaRhvaCZJkuKRZtpEU?=
 =?us-ascii?Q?Kh3k7o+Z0dj/6BNX+csYI+6tLZxNdQR5IwIKDZKZVR+QiqK0oLvA7IcT2mI1?=
 =?us-ascii?Q?P4T2aWTcU1KvceTE919ZrK+KqL7bQMnRfAn6UaRPujYUsNcefBYadcCT0dPc?=
 =?us-ascii?Q?aoklFEo7v7iIyzBgkepsQBqxWcfOGfAMlSHkMzb/7vvuTsDnjS4UUkpMcsxX?=
 =?us-ascii?Q?trhgRzw1eVk6H+3bzfKhJ+cYw2yOL3a6rlpX1VIm6mu4Soil9Zp4JITyIaTg?=
 =?us-ascii?Q?yJJtrlv5+ZC+uVrCaNaNUdivae4xHDDRhT7uQhRrYuJi9IJTCa/TzJrnYy3q?=
 =?us-ascii?Q?JxKU3zWUIARCj/yoHSPDQF4wHc8Y3ZOZcBW/o3PcHldZhEXIJYCmgAmp7Sdv?=
 =?us-ascii?Q?m2OhvZ+qDeeUWes4UJY0KIdByliyLuI5sdpTKziJkN2seNtAsOmkDwk2XsAc?=
 =?us-ascii?Q?gSH7nksbLT20y2P+CoeznZzTyXHooJDXGKyGAa7qviBgakgZ0ECK5ztOweCL?=
 =?us-ascii?Q?dJ/NXQCbQvKqLsPjqhRsANyVqG/TNTY5mDOJ5FE/3aO7qftcZCDHBYFDUTce?=
 =?us-ascii?Q?q5z2PA8LKH5T320PTQeLFFg18U6CRCCFwmHxfiwmdJ04ttLwcldJJF44KIUP?=
 =?us-ascii?Q?Zf8udZfM3UmxmMmCamWvbSAQ5eOsd2BjYNPZg4dqlJz9phjC2F5BBuV1oz6d?=
 =?us-ascii?Q?7XrOWo70DyUeDaDBzVZKqGj4fMv1Bzz1udiFQl9EHX/QyL5MhRII4p2478bG?=
 =?us-ascii?Q?49XEhDhhAYtpY71Y84HZosXC2f23heSSnOLdpXw2gWuOkS0y4EkUn4Ynrc91?=
 =?us-ascii?Q?M2+EZYBcGJcKS6DX4fkGqsJTgs22cs+O8+E1mXCd1yg6dbYfqI9t17jzqUYw?=
 =?us-ascii?Q?2TLtwSHEgpuo8isiUREpdxciy6MdRZ5Vvp1BcnB6ONAiL7bMk3mn+KNQCX8k?=
 =?us-ascii?Q?IZ482bxCZUR+oq8BG7y+wGVCYGQBsqQjxaAmDKtvoxFkQ5CafIuX8iwS8jLF?=
 =?us-ascii?Q?em7clqMqQ3pLlwhswV/suk8Lu1oNSjqYTD7MMv/ejC3AYcOkWNj4jJEHHmbh?=
 =?us-ascii?Q?kPRZRILZfP/k9MaXt9BYdmTDq05ppNk/zuakPWZLYTinwxATYtHwXQq8oQpP?=
 =?us-ascii?Q?FVMUCp7Q9kVYJXf4/HfTA2MTQnU9U4fpS43WhKR2dfEfSIvE83c9dD9gcRbP?=
 =?us-ascii?Q?zjXF9nW0C1AeGm5vPSfmqGAtou3cluaG+mdDvvUI7q8CM+G9BLONFFZ1NjBo?=
 =?us-ascii?Q?KVeJP2P9iQpv8G1nDXexYiVEZEQERSNkIpZyzgnSZjxtmyujkjHiIkYk+yOj?=
 =?us-ascii?Q?lyyJPza6ySNpq4keYLEyMEJQlrjndK32OvYrG3KJ1GzDq36QqK/e1JYGmfvL?=
 =?us-ascii?Q?wYS5GwmnRMc06ms7R7TgkJIUNk+rNiKlAUB5u14AX9Te5VRRiZeuNfaYl2b1?=
 =?us-ascii?Q?fJ2IDRx/Xhv+Lx2UjdTUt6tsJzq+DYpGGpQCV432Kc0dxfzxcZXv7y0Q6BHQ?=
 =?us-ascii?Q?YLGeR6Y34cqJBNZnTi6I4egwmBCplB2dIvL5Q5c0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9d91f8-55fd-47c8-3202-08db320f9882
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 17:44:36.9186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7xYs64PsfNIpuC/d5a83lCyAgUJ7RCgCkFdGsrkKLr5ef5gSyNF1Ky6XAo6UZlr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8693
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 10:09:38PM -0700, Nicolin Chen wrote:
> Thanks for reporting.
> 
> On Fri, Mar 31, 2023 at 03:31:46PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the iommufd tree, today's linux-next build (htmldocs)
> > produced this warning:
> > 
> > drivers/iommu/iommufd/device.c:674: warning: Excess function parameter 'ioas_id' description in 'iommufd_access_create'
> > 
> > Introduced by commits
> > 
> >   7540af571dc7 ("iommufd: Create access in vfio_iommufd_emulated_bind()")
> 
> Should have dropped that line from kdoc in this commit.
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index fca09bb4e839..d791ab5830b4 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -795,7 +795,6 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
>  /**
>   * iommufd_access_create - Create an iommufd_access
>   * @ictx: iommufd file descriptor
> - * @ioas_id: ID for a IOMMUFD_OBJ_IOAS
>   * @ops: Driver's ops to associate with the access
>   * @data: Opaque data to pass into ops functions
>   *

Got it thanks

Jason
