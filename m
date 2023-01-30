Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198296812C1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbjA3OZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237423AbjA3OYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:24:30 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED8F41090
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:23:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyLyocJE36hh2DuPoRsrfsFs17XrqiYioMpb0TctPtTavuq5qm8ILqXi/7lrEEdsY114vmcn/lOIy08E/eqXq6gwn3qgonZMNTDrd/s0CstJu8QoTvx/EvpBrszYjOBom7e+K0OrPXRwC2mq5J62MDWzwTgDBU9sWX05qi+ef7TAvRucKR0Lc50HaE0jxxLzxsl03WZxTLh8MQBsNXh4EKce8dEDelT0XFZ7E2EGUvteDjXYoyxl2OS6G0CXWv10bKgNIJCA3BRPT1H7jl4EqiTFyP4y7WGXPwRIxnX6DQtuh9LC3W+PMa+KiOQqLYn4oE0eew7Q52yLRkV3TWH8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JvaiWa6RESmmruvGZDeB5WWjyCmjORZil+4RoIBbrU=;
 b=YDTJ1y347zPvvEHXJd5g76V1P/gr64e2jlIRSnZoElol7T/LnvfgUaZQ2iewiOu27uh3taQS8wl6A4gIwVxFDS7GPzSo72JDrpiDLIXhuL8bvfmrtQkdd1/jf06dpWPpvuJfz/wr6psQqT4PGGzPaT1GnsqvpooPpwtXxKkRnD1sk14Bf9Byew/Zm1d6WiXj5UHvqBvIVTKjHtVV4yRjwGm0Yv5MFdChhHNI7csZXxmTwbOQbqIJetEDHMmMYAB0w9Bo0mPb+s9ZpPgicGsB4ASUPe1jFlgSX/LafSZICGwYVPXSFcPljDurqu7m7Pik0oK/2D4a/T6XEMeK4OKFgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JvaiWa6RESmmruvGZDeB5WWjyCmjORZil+4RoIBbrU=;
 b=sBOVw4OQeD6iQvBKZV47OpkISgnMvikc2PXviFSeiFXvuaa/BIcY34oXVobVtxgbHFOmrYacoQxGsTH0s3MvZm+1dyIGy4mENkaNL29N+DfQTqNItQqs1oAv/ZH7MEyyMOL/AWIpwGVBo6Xz9Ab2fKX3kUZ35m6OpkM8jxgsEis16jwxAzLNasog33MU4rTasQ2qpqJJJuldYdHbiL9A5tlTuafY/YB/+4U8wuORnlsLAzaTBl3oavrcCsShWrSqOm7KASnKpGkXpGq6FWzfg/5rnHrMWPl3wITxKrUY0i9kSPIrYYkbs31qdD/s+wUjaesyvRW2XOYKuN0vRo96TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 14:20:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 14:20:46 +0000
Date:   Mon, 30 Jan 2023 10:20:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, hch@lst.de, baolu.lu@linux.intel.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 7/8] iommu: Retire bus ops
Message-ID: <Y9fSPLCyo8ZjLTYG@nvidia.com>
References: <198e82a6b1a28605409c395da4ec1a67b0e1587b.1674753627.git.robin.murphy@arm.com>
 <202301282015.hjj2YFYy-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301282015.hjj2YFYy-lkp@intel.com>
X-ClientProxiedBy: BL0PR02CA0105.namprd02.prod.outlook.com
 (2603:10b6:208:51::46) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 96326a0d-532e-428d-b045-08db02cd2d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbJ+U6akWc8xldbzc9oMOfXMW9T+VK4FnjDuPS2HK9OuLUoOKgtrSTaY5/R+SNP/a4dtXnVM1F8VBfPpBqvVb1DGIzKjxIUgCdpAZ7VahxV/Exx25DHvva/uXbDYgpru736Mvj1Ie85wx+K5lIp/2eZy3TjL6RTVzPK2ti34rHkwDZAbLGu82otGQ6cqdPIkE10Jzvikz/SjT9OHQleyjndAk/0lBQanqWkfIeVUVsn6ps0vBf20Rlz7rGiIN8LBulZX2VPPVlVoAeSRoAtbgYKZI8rGTdC9DGd/cWZ36tRhvtPzvo5lx6xCJs9ZQD1JdWsUlflRXpaBZRSmPiFm+XHftjLTTZWD8ccnsv0fsAnV0hzsPwJfLYJFUXtYzsDzreBYRmStLLPlvvHEPPe80HT56MFR35TrJxlw1dYWOcQrUhIzRS8jZnzL7iD8YQvRKLLPd4NnbDoOmcdw5T7eIvr2qcj8SsOztZg7aTWnuR6r09rxVHYOBgBvK4YIAJWP53vveqJ2eV5o5yAg6vxe5jPVSPUNGAMikYFpEi5VX86kRCtiV1FqgbkJpncdL7bV1OIUiSqD8iIjoEZcK+fQep7h8oyNhFfm8MpD3bvP23tfS/ceugqfN6MwAUvMhaU1dx+phHg6fe+ROfRU6VjCTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199018)(86362001)(38100700002)(36756003)(5660300002)(8936002)(54906003)(66946007)(66476007)(316002)(6916009)(4326008)(8676002)(66556008)(2906002)(7416002)(83380400001)(2616005)(6486002)(478600001)(41300700001)(26005)(6506007)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hvardq2lR6LYPT2S8FiicRAVWm9NBYbSbwVfzlEYoar7TP5MSk7tg+PJp99I?=
 =?us-ascii?Q?SZYY2ihctFlJzlnLgC67MqkscmdX54oz0VIrNtajC7IFYWzAOaVyf5CVZoc4?=
 =?us-ascii?Q?4Crbp9uSIxHmuY3jEo4NFy1uktTojveXuFrTJmTpodYajVshB6Inh6XKb4kk?=
 =?us-ascii?Q?4sBdNXB4tci+nBw2N+HwEb2HlQ1RKv26i5Lm9DkQFdwStuiR4NRhC3rXSX3p?=
 =?us-ascii?Q?GrfwqONkM88GJRSVJ061Q1jHLNXf6JN3I1/ENtYqeqB5Mn21g54G7IAVjaMu?=
 =?us-ascii?Q?7txPDvUh4DyLwKI2cZoktJGeR4NntGhYLwrLMsPtDt6KfZ4wq6RD1rZctW1U?=
 =?us-ascii?Q?J88Q2VeQt39/d/zEV8YAADrOCaYf9heSJ/w9kMM1tiPX27nxbAlnMfIcl2uI?=
 =?us-ascii?Q?C5+xIlV776yP/oEJnSIt1pztLDjXo1HPT1L92h9eqEm7URbdjiL3v6Q36lRE?=
 =?us-ascii?Q?jZM+vDeDoN0/8YuOLkr5WeqQmdPdxXQYmY6k//aI9ZjIsmOam0OBHQzNnUud?=
 =?us-ascii?Q?Ko2JWpZREBoaHpZHnHHq/HALr+tNNQmh4y5zr/eVGuPT9WtCANXiY/IgnHrL?=
 =?us-ascii?Q?3Dbnu0bqt1qD4a3qgp3OckRbHPtKgVexwZ2PesGPB4FL+nv8Nyon3Ojc4Ahz?=
 =?us-ascii?Q?jzy2xCZuqiD3kuTGnMBJxtVG1N+CG7RPxMDg9pJ3qQ85ko4FqWSU86gNE6LV?=
 =?us-ascii?Q?qYgNTuGWRDkxGxCSR9OFMJ5N9nhpqqgQRP1X76qDIPoVfqgfbzB3cjxA3Og7?=
 =?us-ascii?Q?5mbyJlRhTqwjVpbX68fEasrFucb63imKb0KaoY6rOktjl4zvloIXzUsVjAML?=
 =?us-ascii?Q?1xKMgXMuUjMVX20ew/pYBL4Op3ueXHaZbd1lUq8I9LW/FrCWCxdnb1f8mJTm?=
 =?us-ascii?Q?5/lkA7mnEap2cmKgsLuiFKmy112yG//Cz64fYTmddXNpCIpDAd2AWT46ytuH?=
 =?us-ascii?Q?eOF0gkQOq65WO0PpT7xHwtq/yJkgGK2KbMEqHFqRO0SAnJ69vkPVY/Z4xmAF?=
 =?us-ascii?Q?lLukqUBE538atWScLVsNVQ7wLtlnvwvHotU8qWkHfj5zAX6JR9ccscqV12fA?=
 =?us-ascii?Q?UiqsSwO1cup6wBdkhBENYjV+Qq4naFzG0Z0vpE8LG74SYK34PfTbLcz4lMWb?=
 =?us-ascii?Q?QOUhoAgq9tTZCZAw3mDsSoUbh2M2Euh1+6Pv1hHTrK5WPADBo3VasEpFGJrm?=
 =?us-ascii?Q?IRuxV/DDOkRi5ETyUOME9aFA+l4V7ox1tIIJWq+zvGQGF1SBb+HxxbqjfSRQ?=
 =?us-ascii?Q?tiEy9zos/UXD5qgsIp4Q7cZVz0j517e9x0OkDabYW7oRdrv5XDoAvi1YGuNM?=
 =?us-ascii?Q?mC/Zi6ZjZYkUBTM29ib53dZF3x9MIJl1DvWOI8RycONuc8r8KVPFgPAckEax?=
 =?us-ascii?Q?+laXhKN1LwmyNVtiVtY9Zacn8vElV/jc4YEU/tuDvKpV001U/9ejWEgYSS4C?=
 =?us-ascii?Q?4hEsLgrZjHzLE9DxNXE66fFOtQ/LchT21Ty3FKX7ZlU43lHaZItBwwGXnFjX?=
 =?us-ascii?Q?N837HbnpHY8SO9+UtPn8c9LGIvVWtdr35Kfu6EeS6qGQJ/VbBNVB07aFGgOb?=
 =?us-ascii?Q?+dLlXgoygfitrShJgQEUCAS8uljt8wYbU9ehF6F2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96326a0d-532e-428d-b045-08db02cd2d88
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 14:20:45.9332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0Nsz5guYCWuHODcSzgdN9j5eW0gCjNchKrKCXGe7TNJ2+eetLWwnUtdwXBd+uUH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 08:55:09PM +0800, kernel test robot wrote:

> >> drivers/iommu/iommufd/selftest.c:276:39: error: field designator 'iommu_ops' does not refer to any field in type 'struct bus_type'
>            static struct bus_type mock_bus = { .iommu_ops = &mock_ops };

So this shortcut isn't going to work..

Probably something like this is the simplest thing:

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index cfb5fe9a5e0ee8..27bab42b1ff841 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -274,6 +274,8 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
                                    struct iommu_test_cmd *cmd)
 {
        static struct bus_type mock_bus = { .iommu_ops = &mock_ops };
+       static struct iommu_device mock_iommu = { .ops = &mock_ops };
+       static struct dev_iommu mock_dev_iommu = { .iommu_dev = &mock_iommu };
        struct iommufd_hw_pagetable *hwpt;
        struct selftest_obj *sobj;
        struct iommufd_ioas *ioas;
@@ -291,6 +293,7 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
        sobj->idev.ictx = ucmd->ictx;
        sobj->type = TYPE_IDEV;
        sobj->idev.mock_dev.bus = &mock_bus;
+       sobj->idev.mock_dev.iommu = &mock_dev_iommu;
 
        hwpt = iommufd_device_selftest_attach(ucmd->ictx, ioas,
                                              &sobj->idev.mock_dev);

And then delete mock_bus at this patch

Jason
