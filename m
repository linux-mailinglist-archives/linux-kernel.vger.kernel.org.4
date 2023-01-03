Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F2465C2C4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjACPID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjACPH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:07:57 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ACE132
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 07:07:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Atxd18AheiKpRm00uewocMNp78pVCDJI+rBh2VCcJaeUWj9eiLH/mPJP01awSC3MvU2BFMIWQXg9F/fphKCmxCYWjqtozbr7EPp+v7x8Dgn3AcCunUSR5w4h4VKti3EpA7QnVlFUXA5aBPn+IiP+DOkV1yU5peiPsg8IMEuxKoSSzrUpLCGzy/vphKyUIYnh1jb6N1NM3BL5yMcCmeitgGjmsziTpYAQ5Q4vv5GLHT1oprceLsYaQ9LKcRYCzbozitmuv0sjGHK1yk10W4XxSbz/g1AOHexm2ryw6GIJj0Qb34oUQr5fBMqjAXyWUrQ4vbNzq4aqZlrmqwQGYkACRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFpMygkiV0dcejj8CsTVlXE/LsEz4zHmwbaMr+XDOi0=;
 b=A0BwFrCzlCag0PPAwefPYfYaUwNMJJkm3vP2nhW+jnaBmyeU2W2lbfdMdOlFUpteliWyOxiEDZRPGmtUzcJ298WYp4JTnFZmi65yv3O7zE4N9Ie8DUMFbpG/wFS5EdT1/vxfP6L+glspgNoxZtcz4v1n4ucNgEd7HgoX8uRLHi5B5DTguQQTCrfjquFdPO0FtoVK+xhRPe86TDQlLS2OL5REmW8tQq9UBiuNxjVpYXSstqV8+GkDvWGJrpoLZWdvm2NbX7E+2pe4a6+jdt4X9P2Er1X7+iO65C2FhIfWm7kS4yK6zyfmp7FiZAvs5uyfqzdG9Vj2T5ZQLJ1jlGCdTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFpMygkiV0dcejj8CsTVlXE/LsEz4zHmwbaMr+XDOi0=;
 b=Z+7wc6AyYQl+wJ4e5taiorEUAiTHWrfqvr26dur8B4ikPy37lskQ59qlqy5xIT1Ex5Zh0cjVnLBcZdP28TX/N6iZYYweMyuV22CJAAX8zxY6v21ptLKr3Xpa3NlTZVOeOfbo6TsxLCyoIFGQ2QhZh7AREDruyrOQUYHSHPoIz4Xz7tAdWwjg4HqFmNOaK6tIp+WKDGx1rEMQnIakRuSmbycPSbhYUGBeXSQUESO48LCxzB5abbbHqkDV66PN5sHfiFES/12+4FtLfgymT4TYnBKLSFUxr9WZHSk5Go8V6Pp4iUvpmgHRBHRoe8LmMKJ+6hQoANxaZGaEx9bEqYZo1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 15:07:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 15:07:54 +0000
Date:   Tue, 3 Jan 2023 11:07:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        jonathan.cameron@huawei.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH v5 3/5] hisi_acc_vfio_pci: register debugfs for hisilicon
 migration driver
Message-ID: <Y7REyEY2ngkHT6z+@nvidia.com>
References: <20221217063248.6735-1-liulongfang@huawei.com>
 <20221217063248.6735-4-liulongfang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217063248.6735-4-liulongfang@huawei.com>
X-ClientProxiedBy: BLAPR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:36e::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: d359a685-3daa-4f68-8917-08daed9c49fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXYYRGGZG6Tz9auClBAcREX8IDMJv+JZOVDl76Gf+CCGPUl4R6yBS9UCeDVC1jU/R6KPx51Xry1RVNIsYA8agb+vHVF7XB/Dw6d75RQkqPV2QI7dlbLNhhSuCssbEovUqjKeKjRxqqRelu7pDZAYU5lHpDzc/sbkDgThKSp3rZBIZ6/GX0ke9iy6KLv8gCztrguf/RBqIKIoIyjEWpsSIXqP3t9ZKZRPSpUlGXrKjDjiP7a55Uvp2AJnpG59QBgIfSkU5bEQ+YePUEQp4dOmjgxvLfDcObKe6EEw85A3xxpGMA8+uKOLl2hbBvt0VhS7PRHj/mXgl9DV/qT0tfRJ/fp0Mfn9ioRHc0rWRrs1ITnS51urFhSParygHLValP+5eeSnjnk1zPOKGJV5aT3BaT3yrK8B9F7C0A0YMdxNbcx2ASj3iEgL3tzAZrp//NreK2odNwZy8DzruQbTzqtsxKXaR9vXdglz4+ZSRr9Xuy+IAZS2lZDOZN6MxeoBdvIzZAwWDtXb4DfJ6RVMFdxAEBR3HJTdpHR8ynuZAfNMMoBp0wHLB7SQNKy//MrXcQdlnP3aAa3puxrg0QCx9nFXc6Ym8FlCDRBzwEFy3BZ9r4uBBmRZKt7okllS8ak7ZV+ijYjilorQd9Dr1Z16qvbbbKtOvWtqAobFG7AUEpcNrsJAsuKgnFMeihYTVj1m3rSz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199015)(36756003)(4326008)(41300700001)(66556008)(66946007)(4744005)(6512007)(26005)(6486002)(478600001)(8936002)(6506007)(186003)(66476007)(8676002)(6916009)(316002)(2616005)(86362001)(5660300002)(2906002)(38100700002)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7CLfqIw4fid8cVQArT04Ds2BJr3IIhEpXFzXXRvSaxuXcoQYthWZeW8Isxra?=
 =?us-ascii?Q?GMzgF02kpui0gbw1AW4KwH5jYWOFZphBY5XHJsK2gKYihy2TvD4gIemJHDbj?=
 =?us-ascii?Q?IukvSzOYt8kDwsLWKtjY7liYeDOHmvDO1t0lSv/TM0vJx2txRwQo/XGwLOqR?=
 =?us-ascii?Q?0uTMcIW2MAjG97KabD/MYfKjrn0kXoNuf7zz5g4QK/cj43zSRwR4jNm8T5U7?=
 =?us-ascii?Q?mk/XdrZGuLlQlHjnTGCozYAJTdnzd5Eqc5hDKb3EmZcWNYiSqTnRs3GYpjXh?=
 =?us-ascii?Q?CE1PZN517mbtYi/gog8vA0jl3L8bD46ipfsPGeD5E6EfGu6L86pkyG2Sai8m?=
 =?us-ascii?Q?bk0UKjMV1mpDBnV4C3y47UNRxApwvdcjCq5iDrRydqflia5g9Nf0CbBPsq7k?=
 =?us-ascii?Q?bVAjKxUscWIV0LA/bZ0hLCvlHH6CKMQlxUmczHzJdJB+vLSz0AhMgzgOASKF?=
 =?us-ascii?Q?urh2/Ad+lvsH8b/5sKvzgnMtUUJ0UZsXGIQ+DjeuVHNXzdwv6oTktZJLGm/e?=
 =?us-ascii?Q?p60xUcw6ZEkdqjZqOLrZpCIu6u8/YqVpO53udfRREmowjOcvK8wErnndW2LG?=
 =?us-ascii?Q?XA2cfEAsrbWsmfLgHJqq1bszEVeHO2SgY1A26Qy4mULc6oSKVjtkze3dw5v6?=
 =?us-ascii?Q?DgFrktwA/Cb9Mhikombq+vnKVN5i/2m6s1spKgn6LCkfV2Q/va0fT/VrktWP?=
 =?us-ascii?Q?7tn+iY1tKB6kQeVqienb9QOMwV2MZyvKL8P+A3BAqY46ikhaw0r8+20rgVkD?=
 =?us-ascii?Q?RMaL0UuOZAqI4aja5oIErXMQpcComobVo+jXzehQ/agtDJBpDbKbMp7fTYcH?=
 =?us-ascii?Q?VYD9G539+78rwLOHfzykiwoqfgubrSZ6qCvtLdb2kP5F5yE6UbFzI2Ps0Ym0?=
 =?us-ascii?Q?XwQ9bi6YB/uJjt0t3MNeijrzsFF0fmII5DZVY6XbmnlV67GgVrxdJrj/Dn/3?=
 =?us-ascii?Q?7sb+zrKRwC4bqOBICTsi3HVql+kmFSLqyLnQtwbdH1CtdnB5BEVhmKvSKiaZ?=
 =?us-ascii?Q?NxG6zIgzQSBRLdnoynm/oGso1WwIQ05xqIHY1H0zEYjFY9MitpF9f/yxpYQS?=
 =?us-ascii?Q?OdVeo8e7Gu73Wd+0YqtI4ieIgV6EZpcG1HJIevhsUGsbPc5yRQhe5zlDhH/b?=
 =?us-ascii?Q?SHHXokb0h3JzuDqazl1crP5CHusXqz68CUjBOssoO6QI80D2TKg/nrtNZq/i?=
 =?us-ascii?Q?mfvVFrwHFf2kWBY4rok6j0vSr44TB1eMwAiyCwslKf64vgHoHknu5dDUzfMI?=
 =?us-ascii?Q?cXdy1/DeSxUsI4z59YS0y7ZbeWJF+ccdtXfYwM3ZWGLQhpPVtb14JBQDzIhu?=
 =?us-ascii?Q?zIhDEi/yLEUrvAht/oIgj4jh07nyAXe0xnHeh4OwMdRWIX4T/dey+e3ZI7WE?=
 =?us-ascii?Q?t5TQmqCkOUnXOIA79BqDPU1xQSGpIWnSL4FqNaElF1RHlpqbp2/q+SCXBMvZ?=
 =?us-ascii?Q?3U1ST+RRaA7QDeINSnalj3m46keUu9t47IWHzfMdnj6p/lMCqFM/VUVF52/8?=
 =?us-ascii?Q?6q8Kp8dFsi6jCS0t6GcI8eLB3t7NODkPZ/Hc0zD0RecO5firHy7t4yWKpo4u?=
 =?us-ascii?Q?V06n6TNXZwYjpHv+c1oKFPwskjOEgqZqKABs4xp7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d359a685-3daa-4f68-8917-08daed9c49fa
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 15:07:53.9745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOJHXXY2UG2mbwAGWBNQg5en2Q8W63s+tZxB7kEd3m/ElNV4yXA/jLZTxa1Shbx5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 02:32:46PM +0800, Longfang Liu wrote:
> On the debugfs framework of VFIO, register the debug function
> for the live migration driver of the hisilicon accelerator device.
> 
> On the basis of the original public debug function, a private debug
> function is added:
> 
> mig_data file: used to get the migration data of the live migration device
> mig_attr file: used to get device attributes of the live migration device
> debug file: used to test for acquiring and writing device state data
> for VF device.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 276 ++++++++++++++++++
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  11 +
>  2 files changed, 287 insertions(+)

You should put this all in its own file and not compile it when
debugfs is turned off as well.

Jason
