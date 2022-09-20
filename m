Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B085BEB31
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiITQi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiITQiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:38:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C49F65257
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:38:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNEDjEsKY3FA01VaLNbZ5XvfLftJkTTIjR4wrRJlIMbWEfXbMaMHN0IwWk618ktpp2DB0V6T7abxYf6LbV2w4oY/sQGe8z29rj3mP06JvuLN5v3yfTitSQcvwmBfb0hYLQfZYATsOw/5FylDp7RE4d2VBlEN4z6VhHgsY5+ysoLcqpDvKRjcnndVCcR1VGThd5hWuqC3AHr2e4Q2j3cUYhZkAMwJBULNsDlyvrFkZmXp8qmmf9efU7/qmRuKkXhT8yDiun2cGNfobd+kWXyHw3wmkg+YS9zk9mDbzG+myK3klreXNQg2OzlUp/Z7HC86AnM1ATRv+tZEoMGL8NUKBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1zmPxH3CC0lnJk3ZoydwQsz5/tBYTby6mIH1/i5AZQ=;
 b=MmbWbo1TFtGuN/uKvCx1oD2Df+MNl0M0IwN747fAI8gMdL0z4iGuhKv1Nkd9L5nNF/+/j8RhAZBXpBTy6I+TV8YMRWLWKnZIolazgozsA/k7lyZGTU15n+6gfKhsL47iJkwm7JOk7+OE38zDPGr/jmfCTWs7lEtQARIx6vvFy/WtfXS5fQtkoUyA84DeD2xy6ewoQFF8Q6AEMMXD63p+e5aAY/EWSBtGOSxN0MT319QsWD3DZQ6fRcoOVzqgl1y3SsM/bUWXTFC+oZ44LWY9ATyjJfG4Vaxexzl0qpN3SRjkyFZ7VrX5oMKWGMdM/1Rne7lziBpZPqnpC2RxF+sUzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1zmPxH3CC0lnJk3ZoydwQsz5/tBYTby6mIH1/i5AZQ=;
 b=HcBYHcx2zjMRzdtlqZTljOKOsMVghcV24pb+YUnMRs42kSsAqXWzfXhHExz1RH6B+i5MWTHTHj+lXHV+aQEYukdNSCetPiP3G/UrP0yM3omeAWT7rFRSNgaNCIfbmiHK4DJWJX2snIfNlWbvQQAS6Y1gE1/leBbbF/3AXAUiQCE/8sqMvRUZwZE+Efo235JG05trvMK+Nn46KUtPeq/1UyvLhLwRlA8ZWZ/VXSkPrnl7pcLGv2PeUcafmICw7+UrYL3WGBq1lj0ygx755G21tYQBW/CHz0CB8WpwOLqWZPKNrLGj+80+pJGB2uy3FcgIQOwhp+P+qGCMjGq3vvm2yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY8PR12MB7563.namprd12.prod.outlook.com (2603:10b6:930:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Tue, 20 Sep
 2022 16:38:19 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 16:38:19 +0000
Date:   Tue, 20 Sep 2022 13:38:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Longfang Liu <liulongfang@huawei.com>,
        shameerali.kolothum.thodi@huawei.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH 1/5] hisi_acc_vfio_pci: Fixes a memory leak bug
Message-ID: <YynsesGyvJl26jDI@nvidia.com>
References: <20220915013157.60771-1-liulongfang@huawei.com>
 <20220915013157.60771-2-liulongfang@huawei.com>
 <20220920103443.72654dd7.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920103443.72654dd7.alex.williamson@redhat.com>
X-ClientProxiedBy: MN2PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:208:160::37) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|CY8PR12MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bfbe223-5b20-4bd2-adb7-08da9b268678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zy0xiIccnfV6sLtpeUkHevy3z8at8/hzgXvd0Scs4CzcH9WBSgyqz2+5vpKE9YqzJDfuW4QB9DDupT0C5EvI5bLTbe92XctvwfgJKZpZ70aFOTWbeZysAXHqN/QCXvDC6yL73OWsN9bY+FB1ZKUn0NrQADx0BBRQGulYuFWowbFXh4OcYcftXE51lVaQeUlLaIWaCO/YCpzsh5edIgdnhtqRxU7+qC2HaHu5viZw0VpGfsOx10OnVPo9zd7dpViGIkeFX2s56H8PxDzCFsC4OLebM98WAth04J33/Z9NR22n7mrXGE+a2veGzb2gYxKedpkVcsS2tpNKhtdPPNGLHltzzFm/dRykbfmMF6fIJxWcU4KWzId0OfgPkxaribYMleHok98v0nvO30mS51xsV9TdFhCiI3hTfnzO0FpdkYDJ8NhNXrFF7ChSp72j6heXuZqocnsGUj1MNh4JcRbouilvZCfEPVKgBmYrPpxYB1Mr/V7b41Sn2wOkeOtrJnprZIjCielq+ig1ZSXmxb9ukpRbii3zwI0odHGPxQel8fyV54j1Oy0P8ilcZ9zGA3PgQ9OJGvxvwKUt1gDNbTdX6bjdp0iTXpttLp3LYkFt49KTH/0sGrIt6E3L8LL74dOWe1sQiSLpioCzWiyZYPjKCQZU6Kcy0XEvbJk/3KvrPYoM5pXWWNPuVRMybOrazeUkvwJ+kwN9aMSHGm8+sppR9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199015)(36756003)(5660300002)(41300700001)(4744005)(2616005)(66946007)(66556008)(66476007)(186003)(8676002)(2906002)(86362001)(38100700002)(8936002)(6916009)(478600001)(6486002)(83380400001)(316002)(4326008)(6506007)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I+yOQ0ZjzSNVYHy80vhziHmz/MdVxcbG3SsV7mSc+Co+PzDHsXMRYBB/9OC3?=
 =?us-ascii?Q?33lJS49TVXqNBgJR2WiBJd/KgB8Kw7T//l9YoueykDIRlxjKWU0Bv7XYF0iO?=
 =?us-ascii?Q?nRs/GDxHS2QSpgqffGlXXGU9KB+u2gZk95RkBufE0KFp3xttdfej4lY0niRq?=
 =?us-ascii?Q?n1WX4iG7OzY6MlYqa+AF/EAfKQ9fi817fILEbN+GtlFJ62D7h+FnEyPOXsaq?=
 =?us-ascii?Q?FD64K17PsMuw3iZ0u+oFI2ClqYOoYj1tIS96V9vZt0TO8AaPQ1wy3XEXfLHV?=
 =?us-ascii?Q?AHpF4THl6eiZpyVTzkQJkFzNeEF4Qya0V1lNdcgulru5q1aRM2LFHstC2rLL?=
 =?us-ascii?Q?+7W1osGguXHnFkFJGAlgD5Oj6EiSJJklGKQxOIaPOjGaTV12o/cpLgA/6bEf?=
 =?us-ascii?Q?10FRMldEm3ZNnDN8WbpnvoFMz7WzMNqUozZbYjOwiDiLMSRc40VWegQm/S/Q?=
 =?us-ascii?Q?4om11oHJ5BLTrTGgwkz1klx3QYGrf5hDIRV1HHGX8SPKjcpvZQGWgFHdtQXP?=
 =?us-ascii?Q?FDeYnJ8dDqjq0ECiZH9bhk7d0mNi6zxmz8cCx2oOyLtTE+VeJA1hhqBSKFU2?=
 =?us-ascii?Q?uFG9qfSJJrA8Vw/qHMT+fb9W48YLDLgAUToVRr0kYfIyfOwGxLTH9eFYzXhl?=
 =?us-ascii?Q?jZzq45elvtrYJEU0/hb36Y44gZXOJmfMWaxAqP9SIc9Z8LsbiUHUFpB4GYJ0?=
 =?us-ascii?Q?A8IMI57rbDO4giGne3mR7DyRPl8VXKpAfXzoEVCK4i9tE2p27i/4+NlR0Avl?=
 =?us-ascii?Q?fp8tZ/8wxLMfKi/X/aEUPOj/gqyGhKH9HEwkMwTuYv5rcTuh0fvnKwxq24Xe?=
 =?us-ascii?Q?Z502wZRRmFUsamO55v4JvorctdXdl/2tt2jqxzSi1JsyTk/9RqxrL+u8zmQu?=
 =?us-ascii?Q?94oV3HxfSJDZbGG6a95nf/KUsU99NSszNpnAdlLFu0XaVNXM6midwi5X6QdA?=
 =?us-ascii?Q?xv6hv2dGvzmtXL/JjtFaVRQMHDu5Z5Beq/Qide3MckZRLYIB+ynO8H9V6k+Z?=
 =?us-ascii?Q?h4Hqnxd4/kUgxiX5U6OblixhhhoDHePVTul/4aepDY6HdRqF4xlahwxxSHQQ?=
 =?us-ascii?Q?uaaKkE1X/ssfbLD7IL6myYLDUUZTZYmtR+KOyHyp3kuN/ufgC3pALAhYEg//?=
 =?us-ascii?Q?rtUsbRUwplByJkJ2RhbsqTW/oIiT/TiUToQNMbSWw8RWKpryDBZzHt1sFvDY?=
 =?us-ascii?Q?5kRZabyfABRYTy1uJaYJSRlfyJKQQKLAxNxFN8Cb2bGsvTjFxY8kE9hO/s+V?=
 =?us-ascii?Q?8fNzQ9QFBG8t9th8+oB7fajggZzyQvBjMW6PmL/zNh+0lwPAjDTEoWNbtSXC?=
 =?us-ascii?Q?ZdKmkpUsRQNjMmeyqcwal7UjALQvHBD50iAg8q8UPGRTSSJ81TQQo50YtO9d?=
 =?us-ascii?Q?jIhgpxjG3J3T9dUNcWvVAN9uvWwXZjneOtYMZUPUsVeAXHsLHQZzGcL9LVV4?=
 =?us-ascii?Q?kjh4XwJY81WehA6r8fgNVeIumdApbV7Wbg0vqfW/CKSbeghbgOrgsMGXB5LG?=
 =?us-ascii?Q?gDG2eIPqJld6LxXiZR3USbc1Pa4Vw/SRV9lm2+/FcNvkTTvYVcAaRowiqf0R?=
 =?us-ascii?Q?RRQXOmfqi700oA+SxhF11+pbc59s/jLUOgW9l+uy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfbe223-5b20-4bd2-adb7-08da9b268678
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 16:38:19.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjFLBzw+k85v7zxisGbl50RZLmFLBY3Vdk46FbpvOGtTFRxbUHmEokTKkY2a0g3H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7563
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 10:34:43AM -0600, Alex Williamson wrote:
> On Thu, 15 Sep 2022 09:31:53 +0800
> Longfang Liu <liulongfang@huawei.com> wrote:
> 
> > During the stop copy phase of live migration, the driver allocates
> > a memory for the migrated data to save the data.
> > 
> > When an exception occurs when the driver reads device data, the driver
> > will report an error to qemu and exit the current migration state.
> > But this memory is not released, which will lead to a memory
> > leak problem.

Why isn't it released? The fput() releases it:

static int hisi_acc_vf_release_file(struct inode *inode, struct file *filp)
{
	struct hisi_acc_vf_migration_file *migf = filp->private_data;

	hisi_acc_vf_disable_fd(migf);
	mutex_destroy(&migf->lock);
	kfree(migf);
        ^^^^^^^^^^

This patch looks wrong to me.

Jason
