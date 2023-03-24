Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FC76C8258
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjCXQaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjCXQaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:30:21 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0602D55
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNWEXXYqAH8iw3DEIjFJQYm6WbPlw+usJYFvc5z2kCmrG7lzSKuhgBuI2+Aytxn62Gh58mJgZMsaTuf/tnqCEFMAHbvFUXMzHiRoe4StUmUzet7b/6mgNTUlTHn78DM/iC1OdtDpKUcBlCCzk89NxTSJksQ8Bxwg9w9pjsvftAcEkdCf4Yx0Sk7YCuz3ykqPzYFJucttmFnsNe73arE267I3qNDejP8nEXysqpqxxVJ/gMnTAss8B8695VRc8v7tQNdBfKR88eEH8kgRlXMSjIyXNF/UTRjhSxUkEkZU7Taui3N1ts+ZxYTcG5wo+fU0oh80RiBFtjBWU317xqWBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5QBKTK3ZaD714vBwFL+mBGKmKT2z8llkEpY3LRisOI=;
 b=XiEWHQKABjS8AAqw4uaUEUBP61fYppkvAgntOEUMFxN2bgz5ZRyPsDEvKFw+dUVLb0eF3mQ2rt8rYX473kLmKmsbiLdxn3ZD2lfjlG2ao1F2wkxTZ6i3fb34Pfe3DVS42K8mk/9CHK6DJFGjsswE2hkcX1gjjzFOqeYjcMdAlDrL6pqlqu5iDY/exlYaTRVajAzfb3Zy6iS7vyHgnIfsCiXBlOXXTqqZGWaELLKh++eE0JlBOEWFxz5OqQycjAjB7XIsTQvpz5eB3l30INPiPJsP5DoYMF3j603HHgx6WN3mozlSKZK6OV/r0jIVtrxdsDFr50p+9wUBSAiZsqWnvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5QBKTK3ZaD714vBwFL+mBGKmKT2z8llkEpY3LRisOI=;
 b=cLOWvw7S+cpS0ZuAr6FQEsCuEFYvbqIlqy8fn7NLOPCJG1VKRgmW6L1QqjR0uShZ62QGThvgQBWB6lTlIjf8XJBncl/6TqJ81nJ2w8N3SPYKtNK1wnEY+k0jI1eOXh9L4V+RjYWbnhogqIAvavQ4Z2ysImx5w+wC3rriOF65EhsGXT97npx7Ks5oqp/F8HZ88vT63uvERrbPkECoUwHYZ+jM+cSFSO4A52nqc4UB2e9u86PIi3Yu++s5wHI3xpy+g3rhkGqwgPen6zfI//qifkPTAxrH7rwYgpS06PCqvgFbtmOU2b3t9M9WMThe3EyG7BILN506P7ilF6syOLuZgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB9033.namprd12.prod.outlook.com (2603:10b6:930:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 16:30:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 16:30:16 +0000
Date:   Fri, 24 Mar 2023 13:30:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
        will@kernel.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
        joro@8bytes.org, shameerali.kolothum.thodi@huawei.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 12/14] iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED
 type of allocations
Message-ID: <ZB3QFmzCwQ2OnFLJ@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <b01b2bad6d0d34908812d964eba118a9cc1e89ab.1678348754.git.nicolinc@nvidia.com>
 <b870ec68-623c-df0c-3ea5-7fe6a95e2ef6@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b870ec68-623c-df0c-3ea5-7fe6a95e2ef6@redhat.com>
X-ClientProxiedBy: YT4PR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB9033:EE_
X-MS-Office365-Filtering-Correlation-Id: 4078e3bb-a149-443a-e0cb-08db2c850d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qchn/mZIKHEWMP9H98FkmWHVT0FiqYzd3HjKQbZtXnfj5uTm6Kv9f73aZK6SDvZuk060LVJCzLiB3V4AuLjmYbFqVRff8L1AHCkLoMyHGBtn1kE2XwXnonU0YTmywje20QWHybT1geGy3n1+xk6j9D2O4sl7WkBJZ+Ovu3yfW3xyzmp1YNK98hxmpJG2UeKK6TXq0hDGTu0obhd5lNZMXDmPcae3kfsv30kDdMiVwjTS7o9VVtYtvA4mwS58/k3+IjarpRRH6hU5icjH5to/xr9QISXP8sdxnLfvmqdX6aiGIQPi1PumGR/ojEwOPDui8VhV6VojhrEnXbdsOzhxSVjjWznbaOQizzVa7W9NuYEjm0UYIb8zL26QBooG9784+N3CO0Ij6JL0mZK1qJzO95lVo6fA3JffvEmoP4zT8pXY2yX2+r8yn3QcC5vDDVt14sA64PQ8gM2FJElLJ5ynIu8WSuuhCord4tOiWqZP+si8r8DefEwdLZeyJpDtUFryIB72dfkt8n+VOU2qImrovunjEBNzAYsy/tYOe/z2zrtDInjfqikALKI6XsCHL62j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199018)(36756003)(8676002)(4326008)(66946007)(66556008)(4744005)(6916009)(41300700001)(5660300002)(316002)(7416002)(8936002)(6512007)(26005)(6506007)(186003)(66476007)(478600001)(6486002)(2616005)(83380400001)(86362001)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sjp7VCMNi9wh3IgUq0h/5s2APUYdZont4h9eKOw4JV6fLj1Wd6k4dai2LRcR?=
 =?us-ascii?Q?8EG9Rwfds4UREraEvzGecJTKLqrFl1fhsXVxlOWvg/1yDieOLPhKC1tcyW5l?=
 =?us-ascii?Q?SIcKgeu5py8dUVMdIy0cQtPU08KXTFxisGneURgsLE3kNeRKGfeqItM28EHK?=
 =?us-ascii?Q?McQveK4qgFf6+IMfjsnoMgvDg05DqrN2UJXgstA7WQ3Hk+PqIMpCPM/X4z/7?=
 =?us-ascii?Q?JSYWfD/zEtgNJ+M2eAZWagzAZe1VHLXN5Qz6wD8z3dmj8soGgTWm6IyfgiwD?=
 =?us-ascii?Q?i0UrlIRfV5tjHEbK+nkSVzKB3MkLZ1ysJ5aylRUbVl45dsvC9bdyLjUPM3tH?=
 =?us-ascii?Q?SCaxbxOXtRXxhANQhkTaj9X8Fc8xw4HuzPJSiJ9lg3RV+/Ox01ebN3SSqW0R?=
 =?us-ascii?Q?TtpSGal3/k/QD6bZdm46TjMet6O3DHWM1yUQJojdCkVo4x0OGxhxQHC3fDyk?=
 =?us-ascii?Q?VkVUpODyTKOBBs62pmorVLs9dg6i5+Jk0iJLRM7VgjYEM26YayW2/CEsOqCG?=
 =?us-ascii?Q?hp1oFLKGHBCnuB4NJHAMKsbZEXGWpn4FPahVvVxh9k10n677zaGa/ugf/YnP?=
 =?us-ascii?Q?F0Ebj5cOo6wgI+MeubTz9JvzXneki4deX9Z9o1OrSHW9DfM2XuSC2edLjHLP?=
 =?us-ascii?Q?1BkoWyA+sTB0X2yqBThq/6B+okO34oKNhiJiS+f8GCQ/52+N+T1OspAlAiKH?=
 =?us-ascii?Q?C69lY1jc4zzmk0D5DxqAaiP1Sz5sfURFs+/9iW5Ho6zSSJHD5lQueyMzAuTB?=
 =?us-ascii?Q?D5gOh0ZqUUJBzz6slyY/iDzXI8qtX2emQ7uDc5ZUvTyTrzlFkM8bcwsaE9B1?=
 =?us-ascii?Q?ZIoQOey5k7/gOhmAxNsPB1DUobvq6WJc92brY1X28VKymBxdHBRZCzsc9Zyq?=
 =?us-ascii?Q?8R41Z2khVXOZcWqwo+E6blvgywWHF4vwnfYaMtQ72B4J53j+SsGr8GrI2neV?=
 =?us-ascii?Q?13Q/m5U1tarSfDc7f/mb3STM5BpsOBLbEi8dBY2kGLrnosDi5DqYlmtUYIEH?=
 =?us-ascii?Q?x8RwNvPHApTpJBZ1kslJS/eKHGlHjfFBl0OrtYADeOo0gg0OqP84sFgUMwjk?=
 =?us-ascii?Q?8EiXvW2FkgVVJ4Hft7vuf20POOshSuWead4tkA+j7U6ik4/jGIoD4to4gVGO?=
 =?us-ascii?Q?0o/JbJJ0uMW/JTjoWwLkgAuhy+b6UJT7xDO/ZwyOrAprO9gY7upo5zk5LkUr?=
 =?us-ascii?Q?0+5V5K1pH8x2hy0uknT8LzJ1HBpRnq8sOUSucR4cn5Ru0v1h3Ffh6UNSETbY?=
 =?us-ascii?Q?TcZQN1bQvpwotDxOmInO4zk0VikP23eVcecwdpWmF9k1AFsADxUYDAZiI9QL?=
 =?us-ascii?Q?aFF8KZWiOS638p4ILPgMmCcPKlOIy2HHeAJ9RICrihSYADBlic20qD2Z4+hN?=
 =?us-ascii?Q?9q5C115hz7HWgxR48R32glB7P5vswlGBnTZEyW5b3zsKL0f/9KMn2VwVxVsx?=
 =?us-ascii?Q?5cuPqftZwLGaP9VWFPxrksTEJL+P74OBvHGQK4rdpv8b4crx13HrTAhWi+52?=
 =?us-ascii?Q?7i6cdoHOwgK2pKf8u3LXGKHgtR6WSkSk0rzCgMsBz2tmAiknekv1PbMhyw+B?=
 =?us-ascii?Q?JEWSwZsHJk1nFXjP0S/HO/5iL64DITXtTTv+0/VM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4078e3bb-a149-443a-e0cb-08db2c850d1c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 16:30:16.7356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zt3Tq8X3uaB0cnrTjiv3CP/VIVGEoF7QTGv+c9lOf1fMsSuRgFfRXGhn18EobgKz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9033
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 04:44:58PM +0100, Eric Auger wrote:

> Please can you explain the (use) case where !parent. This creates an
> unmanaged S1?

If parent is not specified then userspace can force the IOPTE format
to be S1 or S2 of a normal unmanaged domain.

Not sure there is a usecase, but it seems reasonable to support. It
would be useful if there is further parameterization of the S1 like
limiting the number of address bits or something.

Jason
