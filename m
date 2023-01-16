Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4B566CDF7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 18:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjAPRwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 12:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbjAPRvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 12:51:37 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6684392C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:33:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdvWKTw1fDpE8y5/yZhzXQ2P9KA/x3ZMCc4/ugvf63juj0A3lwc2gKbR1Xc3KdhGTTnWr3bBxV/UC7iZQUjawtagzGBY+5yFD2l5si4tYxW23xZ5SRqO8TUD6yiY46faNda1qQb/OitL55+6k9O/OE4s7Ox6RpnDD3ne4prDW5D1dS3ZwkeCtaPPvfK3JiX+vWeYRcE2sPZYU1cWaWxiYOoMtK4k9ONI+CasWVRmS4bKU5zgIrb+wmVeeUQ33lmpbmA4s6a05K115X6A4RtJ4bi1yGl0HDDoxEYERwHQJCqLiINLndEkgzRpTcxO2O4hR4PMKnKMTGPzR/Ig8OXa+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAcNsaP6jh8PVlNnYQ7jRfMP4sdOsMt1OS+7MjyAChI=;
 b=L0uUEzDwDpOM0+F7eb6Smqyc3SDbtFxs5TGXHIghRMOHrp5XjLfnmdoEXteU6juFzCtlL1AjIS9NTj7DTOyJXEtqOg4pkyg3jVwJYH3liNvpBC2i4C07HA9df+RZqTg/ZMRLycbFF6KHryk0lR2b0W3IovZv85Wu5DM8agJSoGdAfYU08a6ThUBNElupQS/KesrRMS/hzL3Fcl+Xogy0ppE4E8HC8xsZQGDOZh56XbPRXJHLFBiFiOQk22OmC2EmGUwDGQmkc9SJx5bzZykEBxfte//Ok1gtq2L94u4dOoyRdGnjQImU7ye6T/PXw0iGsLkVD+NCaC5o1Ya4zhiJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAcNsaP6jh8PVlNnYQ7jRfMP4sdOsMt1OS+7MjyAChI=;
 b=bDAmML+9c+2F2TvfSVELjCyvb3zct3D2CQd1/EGENVFsAOg6RHp+urJVJv/0LoHG9OO/PeA4gbqiT8vltHKuVzoVfTMM4AicLMef9hkOyBJpGkCMoiwi98+DhkgtoPBfLBND/jyzO4KleuHxuLonBs0xcEQXnGW8+lDsS583ruqeFeRdVGLa6QbkyfKHgfPrwAVAfCCIUTNokxR2/qqkUGMq0YnQx5RYYJ8oK86hOTsOkWaHViihD3y/snb8gKNMSmypXeWhXy3LYtfdaF3f5jpII2xOCUNt/Nu5uVI2UeP0Y6H26ROhBOErPRuGfs+Nal+IccZQAMiVAxFQNplstQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 17:33:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 17:33:50 +0000
Date:   Mon, 16 Jan 2023 13:33:49 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        jonathan.cameron@huawei.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH v6 1/5] vfio/migration: Add debugfs to live migration
 driver
Message-ID: <Y8WKfcWrBHvgh11E@nvidia.com>
References: <20230114092615.51841-1-liulongfang@huawei.com>
 <20230114092615.51841-2-liulongfang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114092615.51841-2-liulongfang@huawei.com>
X-ClientProxiedBy: MN2PR15CA0051.namprd15.prod.outlook.com
 (2603:10b6:208:237::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: 84470b07-fd49-48e0-5a5a-08daf7e7d47e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iXLFiKyYpl9uLVe1/9rdWGcv6Ngoa16TiptDkZNIe32l1DF+p8NDvuK6zJhnPxK9Y6pJqk9A98TkscKALerg5hiByiodUCqyXE445SBHUHrBSKVwNHEwIkUB6AEsHoABPVC8Vc1E1eNkn3+hZ/ibqqYgUlVn7WUT7CJBfy8ydBpveI5Idl/EUIddWC22M48fuPYiuPnl6O8QBb//l5v6tZsWEJwXTFB9g/eiWzd4IA1RWKZW4KY8EUOCrmxn0FxnrRLYYSYceM3tX9tJGUJHJFpEKBu+PnCTcptXvzviIJgX5+wpmFRz/PMiokEDvLLRy0SQm9pChTN1f4eCJFe8H0GJrgmQ9KceRTURXilj+iAXRG57C4uOuZ3Iiu3h9CYXkf6dy2PdHpCWKibpmM6P6bvke4TLC9LakVc3OWAKjlH3iC9A3upno3isoe8m1oDu612Q1ta1jAdeE8wHNIgUTFINR8sORL3AbJExxOwdSW5pxPR8CFq43wSilqBfWjb6y9ODp+yDqpq+3swSs2q4kTJPNaOYy2/n/bMv+KzdkALQKWYkoAQAbDTJll3uObNbUqaVzIoVcAJxnDgd9OzKlGIXDGPw9MAOL3Y3J0CYMtiRlVHR7vylfd++lRdOvZB/hhnWVvKsYY4/iu6Ajsb0XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(36756003)(478600001)(6486002)(6512007)(26005)(6506007)(2906002)(41300700001)(8936002)(5660300002)(316002)(6916009)(4326008)(8676002)(66946007)(66556008)(66476007)(38100700002)(86362001)(2616005)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ocnZ92RV84atRWPBiaoa8m/RRWb5UGYoFZ0b2N7aLAMujZlY6y0IB2MNIhkK?=
 =?us-ascii?Q?5swHCUTV9sSCpWubmdov1xtyydHwdWZLn5Y45BV9l5Nqrfd3MJCqvq8Tk6zr?=
 =?us-ascii?Q?7GrxUcLTqdd2qi6I1KGQI8XtmhZODaASN9/O19iPQcQnUNIkXt5WZ4S/SELk?=
 =?us-ascii?Q?e9Zv/VCBLNuYp38JDzTr9Mm8KnHkZ0Jc0QkxfqSV5wc++Wx1Wfc9NsKwJ99V?=
 =?us-ascii?Q?mWciJawBOaXucsx9n1ras8Sg40cq8hCDv64yuAvRkU4dkoapVG2tPgA+LueK?=
 =?us-ascii?Q?UiDqXYuY4laF/KvPTYm0o+SX+dJjtrzjR9Df2E8kb1GEtAI4D1Pc7pgbDDcV?=
 =?us-ascii?Q?EE2r4p+ddx6EHDDpOrskhA+PsR370TTJQbjJLBboRx+dzc7LGqfszKlE7KmW?=
 =?us-ascii?Q?AvIgFAvprez7geQDKReAQ3lv/mIcaoTgAD6Lq2SgZHkO3FohoVIQHsBUyMs5?=
 =?us-ascii?Q?vi56F+IFifOIeS5K1PPArBnRW2h9Hu8jiTVrV4NQ1zM1C6aEij8cpHUawhAt?=
 =?us-ascii?Q?0kbs/5guLRLHFK55DhQMJCP18qu2QPYuH3eVK3dwGsCOjO8RfhcrmBR4VheB?=
 =?us-ascii?Q?1tJqCrseLi8znp3Rq30uLmLgiyyWP5Oc4xmsYJ8nxT+B/i+Nval1YZuRqBos?=
 =?us-ascii?Q?BUF5d3qb9qOD1kmcA34ZdJPOXyipIsIf9RKU0NRjqgnkZbYOujLPH0M7BZJu?=
 =?us-ascii?Q?DLZI8OMaCk7b0BhtTmmr2YDhZgnJUSBY1PaW/a3O5/v4fPD+WinjK2FPBvJ9?=
 =?us-ascii?Q?1ZfND/cYDIj63ca66Qpc3tI5unFN5ExkwRmhS2f9UyEROvVWMC4tfPh4zESC?=
 =?us-ascii?Q?J+T+E4rBD4YXGdE8ri1e/kL9PMRJWldzUJ2MvjImFRIE9YA25vdbZBsWg+ZI?=
 =?us-ascii?Q?WQHqP+fhacUdcxB3lIGPg7vSQmiOvH6lYP2nnu5miw39yBs3H/x9+cy0Zriv?=
 =?us-ascii?Q?PMXaF6uh/weBgNx8+TNem76rh79mqjiHn3F2T8lplr6+bgKmEE8sDeITNkEN?=
 =?us-ascii?Q?5Noo7MtQ0x07N6BY3QZpP5cyCfPmF6NJFJ5lsgxLLP1m80OzKSXcNY4MGBFl?=
 =?us-ascii?Q?At81kvhiuQApDi75KNOyl6/K4eXJlQ61x82RpR9cuTRYlwHXzl/Kaw8DLord?=
 =?us-ascii?Q?7/iHXN//U9vab+HmzNgb2IpVpbAnUCacSmjSqKJsYjI3oVNNQk8OUkPgfHCs?=
 =?us-ascii?Q?JAvAdmrgFc72UQcuIg7NhhK03PQ/6csJrV6DZVmh9KiU45/qJYzAgLk3N81D?=
 =?us-ascii?Q?hjBE1wr0CxMnfSpj3Zf7KP/EepM9dUEUEuHkH9wqAq3xkhDr3K+ERLzjHY+j?=
 =?us-ascii?Q?+AWE/+SHcPAfunRewxijHq0/G4mPRjZN3vkQyBqWqn2QEVy35AsfbJowxVi8?=
 =?us-ascii?Q?ualrIL2zQjmfH9U7g3cUHsbhFX6lIDyKPmWyO9BWz027lxA2sZd884qnyuUk?=
 =?us-ascii?Q?zIoAgNLrmv6B3FNEbNdsQGQa6E2l1KqBfnciqxA+Nk7ny+Xnob24nZ/GR7xk?=
 =?us-ascii?Q?kapt4AXSCJzovN8rAJE7zQ3cvEPZJn4bd2VUh8BTUnUxY1WPGrZrfRrSMVJ/?=
 =?us-ascii?Q?Pq+7OFlrAp3YxpXMw3WwgheWHnpAijNEmP2uDqhU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84470b07-fd49-48e0-5a5a-08daf7e7d47e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 17:33:50.2308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxbdoWXnjUKXvPjFpSBkg/ZF3+pq1OILQP4yFe+edUIHy9uTPFvM6odVjjkNvGIK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 05:26:11PM +0800, Longfang Liu wrote:
> There are multiple devices, software and operational steps involved
> in the process of live migration. An error occurred on any node may
> cause the live migration operation to fail.
> This complex process makes it very difficult to locate and analyze
> the cause when the function fails.
> 
> In order to quickly locate the cause of the problem when the
> live migration fails, I added a set of debugfs to the vfio
> live migration driver.
> 
>  +------------------------------------------+
>  |                                          |
>  |                                          |
>  |                 QEMU                     |
>  |                                          |
>  |                                          |
>  +-----+-------------------------+----------+
>        |   ^                     |   ^
>        v   |                     v   |
>      +-----+--+                +-----+--+
>      | src VF |                | dst VF |
>      +-+------+                +-+------+
>        |   ^                     |   ^
>        v   |                     v   |
>  +-------+-+------+        +-------+-+------+
>  |Debugfs|state   |        |Debugfs|state   |
>  +-------+--------+        +-------+--------+
>  |   debug_root   |        |   debug_root   |
>  +-------+--------+        +-------+--------+
> 
> The entire debugfs directory will be based on the definition of
> the CONFIG_DEBUG_FS macro. If this macro is not enabled, the
> interfaces in vfio_pci_debugfs.h will be empty definitions,
> and the creation and initialization of the debugfs directory
> will not be executed.
> 
> debugfs will create a public root directory "vfio_mig" file.
> then create a "debug_root" file for each live migration VF device.
> state file: used to get the status of the live migration device.
> debug_root: used to create your own custom debug files for live
> migration device drivers.
> 
> The live migration function of the current device can be tested by
> operating the debug files, and the functional status of the equipment
> and software at each stage can be tested step by step without
> performing the complete live migration function. And after the live
> migration is performed, the migration device data of the live migration
> can be obtained through the debug files.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/vfio/pci/Makefile           |  1 +
>  drivers/vfio/pci/vfio_pci_core.c    |  3 ++
>  drivers/vfio/pci/vfio_pci_debugfs.c | 82 +++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_debugfs.h | 30 +++++++++++
>  include/linux/vfio.h                |  6 +++
>  5 files changed, 122 insertions(+)
>  create mode 100644 drivers/vfio/pci/vfio_pci_debugfs.c
>  create mode 100644 drivers/vfio/pci/vfio_pci_debugfs.h
> 
> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index 24c524224da5..75fe37e72e8d 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -2,6 +2,7 @@
>  
>  vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
>  vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
> +vfio-pci-core-$(CONFIG_DEBUG_FS) += vfio_pci_debugfs.o
>  obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
>  
>  vfio-pci-y := vfio_pci.o
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index f9365a5bc961..e85df2deb8e6 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -31,6 +31,7 @@
>  #include <asm/eeh.h>
>  #endif
>  
> +#include "vfio_pci_debugfs.h"
>  #include "vfio_pci_priv.h"
>  
>  #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
> @@ -2555,11 +2556,13 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_set_params);
>  
>  static void vfio_pci_core_cleanup(void)
>  {
> +	vfio_pci_debugfs_remove_root();
>  	vfio_pci_uninit_perm_bits();
>  }
>  
>  static int __init vfio_pci_core_init(void)
>  {
> +	vfio_pci_debugfs_create_root();
>  	/* Allocate shared config space permission data used by all devices */
>  	return vfio_pci_init_perm_bits();
>  }
> diff --git a/drivers/vfio/pci/vfio_pci_debugfs.c b/drivers/vfio/pci/vfio_pci_debugfs.c
> new file mode 100644
> index 000000000000..169570de7ccb
> --- /dev/null
> +++ b/drivers/vfio/pci/vfio_pci_debugfs.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022, HiSilicon Ltd.
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/vfio_pci_core.h>
> +
> +#include "vfio_pci_debugfs.h"
> +
> +static struct dentry *vfio_pci_debugfs_root;
> +
> +static int vfio_pci_vf_state_read(struct seq_file *seq, void *data)
> +{
> +	struct device *vf_dev = seq->private;
> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
> +	struct vfio_device *vdev = &core_device->vdev;
> +	enum vfio_device_mig_state state;
> +	int ret;
> +
> +	ret = vdev->mig_ops->migration_get_state(vdev, &state);
> +	if (ret) {
> +		dev_err("failed to get device migration state");

Don't print

> +		return -EINVAL;
> +	}
> +
> +	switch (state) {
> +	case VFIO_DEVICE_STATE_RUNNING:
> +		seq_printf(seq, "%s\n", "RUNNING");
> +		break;
> +	case VFIO_DEVICE_STATE_STOP_COPY:
> +		seq_printf(seq, "%s\n", "STOP_COPY");
> +		break;
> +	case VFIO_DEVICE_STATE_STOP:
> +		seq_printf(seq, "%s\n", "STOP");
> +		break;
> +	case VFIO_DEVICE_STATE_RESUMING:
> +		seq_printf(seq, "%s\n", "RESUMING");
> +		break;
> +	case VFIO_DEVICE_STATE_RUNNING_P2P:
> +		seq_printf(seq, "%s\n", "RESUMING_P2P");
> +		break;
> +	case VFIO_DEVICE_STATE_ERROR:
> +		seq_printf(seq, "%s\n", "ERROR");
> +		break;
> +	default:
> +		seq_printf(seq, "%s\n", "Invalid");
> +	}
> +
> +	return 0;
> +}
> +
> +void vfio_pci_vf_debugfs_init(struct vfio_device *vdev)
> +{
> +	struct device *dev = vdev->dev;
> +
> +	vdev->debug_root = debugfs_create_dir(dev_name(dev), vfio_pci_debugfs_root);
> +
> +	debugfs_create_devm_seqfile(dev, "state", vdev->debug_root,
> +				  vfio_pci_vf_state_read);
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_vf_debugfs_init);
> +
> +void vfio_pci_vf_debugfs_exit(struct vfio_device *vdev)
> +{
> +	debugfs_remove_recursive(vdev->debug_root);
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_vf_debugfs_exit);
> +
> +void  vfio_pci_debugfs_create_root(void)
> +{
> +	vfio_pci_debugfs_root = debugfs_create_dir("vfio_mig", NULL);
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_debugfs_create_root);
> +
> +void  vfio_pci_debugfs_remove_root(void)
> +{
> +	debugfs_remove_recursive(vfio_pci_debugfs_root);
> +	vfio_pci_debugfs_root = NULL;
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_debugfs_remove_root);
> +
> diff --git a/drivers/vfio/pci/vfio_pci_debugfs.h b/drivers/vfio/pci/vfio_pci_debugfs.h
> new file mode 100644
> index 000000000000..8d1a4aef05db
> --- /dev/null
> +++ b/drivers/vfio/pci/vfio_pci_debugfs.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * vfio_pci_debugfs.h - VFIO migration debugfs interface
> + *
> + * Copyright (c) 2022, HiSilicon Ltd.
> + *
> + * Author: Longfang Liu <liulongfang@huawei.com>
> + */
> +
> +#ifndef __VFIO_PCI_DEBUGFS_H
> +#define __VFIO_PCI_DEBUGFS_H
> +
> +#include <linux/debugfs.h>
> +#include <linux/vfio.h>
> +
> +#ifdef CONFIG_DEBUG_FS
> +void  vfio_pci_debugfs_create_root(void);
> +void  vfio_pci_debugfs_remove_root(void);

extra whitespace

> +void vfio_pci_vf_debugfs_init(struct vfio_device *vdev);
> +void vfio_pci_vf_debugfs_exit(struct vfio_device *vdev);
> +#else
> +static inline void vfio_pci_debugfs_create_root(void) { }
> +static inline void vfio_pci_debugfs_remove_root(void) { }
> +
> +static inline void vfio_pci_vf_debugfs_init(struct vfio_device *vdev) { }
> +static inline void vfio_pci_vf_debugfs_exit(struct vfio_device *vdev) { }
> +#endif /* CONFIG_DEBUG_FS */

Just {}

> +
> +#endif /* __VFIO_PCI_DEBUGFS_H */
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index b4d5d4ca3d7d..7d6d02f165cf 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -54,6 +54,12 @@ struct vfio_device {
>  	struct completion comp;
>  	struct list_head group_next;
>  	struct list_head iommu_entry;
> +
> +	/*
> +	 * debug_root is a static property of the vfio_device
> +	 * which must be set prior to registering the vfio_device.
> +	 */
> +	struct dentry *debug_root;

This should be ifdefd too if you are doing it like this

Jason
