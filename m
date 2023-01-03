Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8C865C2BF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbjACPFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbjACPFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:05:38 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4991311A3B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 07:05:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kc7SvZy6J+r+JPzc3iraAD0rvXs9jWyR4scpfwgBAgEV4oC/+KY2FfYTH5QNdrqDEpEcZYKMLPb9p5wEUTqfp0qXRdnlm+FajB8oAE5A0pAUlugjHb0Iubq6zumZQ6j6w5GB2kvXIrG5fm/DMF5H3d4wOx898OgQWdq5QN5bnemvsEuNoAKA1mKfJ/woAkxVmkqiFarRQ/dxBqXuINndZeDBX2eW+P4ncvxIzLschZSgFVH2Yvi0vhnatoINBr3csdRMdzMIEaS0l255UV0O0ayMrYf6T4XwOXBvkRZ3UzgKhDVtNDq2dAyO4jNVuFL0eiTV9QEZDVnD1JYXzQKxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxZ6MNMF4MEWWN1XTQUqu55lTMyDKKA4iQ5DKIe965E=;
 b=hNxLCvfmRLVBMUJUKMmmmCIrUoc6NVWDuckSWRQ2KlyzV7JKhgwOpUrMim/khWcTS3bKB7jzsnOViT9+2S4Qf5otGqTfOxPR8iH/CX5k3d7zxuGQ+SOXK1xahQxeHfaHtYPWYZgRPn904CWgOZ/JgmxczpwRiYGN0nOfDEyBGNtPBIZ3xsqWeEhs14+r6a/CFZAxwU77puAvsgTfPOHdClMtfXEVLMQf9CjC4zZCEVto+kIaDrwZBbAgPOP4opCsf+ZsoEpcTg1aDx7D+wVfS3r33Z0jVmWETJjPeHEi74Q4D9GZQ8ho0Xy+l0Ac8I0MTq0CWEeAVXoCJgPy7nEEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxZ6MNMF4MEWWN1XTQUqu55lTMyDKKA4iQ5DKIe965E=;
 b=mr8ttPr8zzTeVYPMdNeGnP9/ZJEheReEFARclijen5L5abFKvuxx5Ovv5j9UpPo/6daZ/iVcdKJ/fehgjFca8u/ZPcFCI7/XFyXAuGJk88qgkXdgBghbRpk7i7IgdNdj1HYAJCvWuTcQWlIw/XuAWIK9e6bKfpfUHxIna7fS0V21FN/mOW0t8Z1tsrwe92SfxUITgOeUKpX52iFxnGjE9MOwXQs1Np9dUE+Cyk9vPQRzet0uJcyt8yYyspaGVvKd/QqelcMaI/bMFTuX50uVvF/8s/VcvVL68RJLjGlhlpGxcqZahUmeddcpMwFPGQEaRPB41yugXQjXZ7xNBkN7bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB5639.namprd12.prod.outlook.com (2603:10b6:806:22a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 15:05:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 15:05:28 +0000
Date:   Tue, 3 Jan 2023 11:05:27 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        jonathan.cameron@huawei.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH v5 1/5] vfio/migration: Add debugfs to live migration
 driver
Message-ID: <Y7RENxZvOfgOuA+v@nvidia.com>
References: <20221217063248.6735-1-liulongfang@huawei.com>
 <20221217063248.6735-2-liulongfang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217063248.6735-2-liulongfang@huawei.com>
X-ClientProxiedBy: BL1PR13CA0368.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a53e70f-97eb-4fac-5f99-08daed9bf316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1/U1e/814qGgQ+mU5r1vR6aVEOuVkEjawoKojusj14wlyjIX1ds9EMMS3jvKHbwCgqmnTnW++xzGowhgRQTucrgB7KDEMOysHtfMMxtG5LzfvtBggr4A7r9uwZZfe2mIvc83Qt30fRhDipEEQxvHKXxx/2MgoXLw+d4tu4pOCmW6vB8CVtVMZdc89DqPolf5d6UjHbuf3KE5gM6yCxe59ZoUlgOrcdgZiJrXrC4smdwNBBRrocNFov80dFhnt0QAgPUOld/Sba99/eDIS8H1PTTcg63/HRrsgnliFKKWbCRK+ilbc0sbW0NIsbLgsBULEYoZ7SP3pQKlMuf0/MiLplN/FB6o8yrtc60/ynRiWW4ve4udoOKc9EsV2pEtDGR/ssy6UPQtSi46dOBslcaMkzPkhVndtkujUwpsa8uTEwyVq8oaeSe7EELBJm77PwQjxSFjSTlhjQ7biLpflFXhFuQQyeRIfQL1pXy3TJIkDdo3qwwx4PgSFCgzxHUGRcLfW75qUbmyUCsT9/EcoJtcofItvDWcBgsR5Z1K0o5sgDxK/QIrgLs2ru6VC/HEkUxmS2VqmNjzYJ3B4uQDbUh0DWsz6rqxK8SS/GA45aKl7h9tIahRfV1CaBKW2rHm96yaFFAA6ziE7jR9DH8boaJs3F8eGgnEqOezqgSfjWPsmdBQNce6Cqtqefhk1rhDr4Sy7aRNGGoZQAHwxnVvjagj6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199015)(83380400001)(86362001)(8936002)(2906002)(38100700002)(41300700001)(5660300002)(6506007)(4326008)(186003)(6512007)(26005)(2616005)(478600001)(8676002)(66476007)(316002)(6486002)(66556008)(6916009)(66946007)(36756003)(22166006)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2G4b+Yh0aWs0Y87wJNKs0Mz0ItIq6TSdBrVt0FA9ZupkXRhlPZ5D7RP0Xs1K?=
 =?us-ascii?Q?8GrfWocD/5mktzPQYX0NH2ftbrh31epz7n0VNNcSoDINymWisLQme5vj9yM2?=
 =?us-ascii?Q?/GAWN21I+qp4Y0/bSLO++4TumUrVUBdWMujD5Z0CG+JDzE1QBg5FDL+/fm0v?=
 =?us-ascii?Q?gELdL+rDFUZYF6qNZD2CgBEvKHzhuWKaKexMM2p7HpbE6vPQh7rp4HRlKVSw?=
 =?us-ascii?Q?dwcNwtVTrgmydcEjPFPddGRFh1qTcaW3v/68ePwUZlboknodAMlR71yJpeEP?=
 =?us-ascii?Q?nyE67ZnitzuJqvgJEI79hwDLz1jlerg3cSNiER2EbJi2lx8+WLvVMzrTq7NZ?=
 =?us-ascii?Q?5Gn+VF0qCZEM43ijMDuzT7ZSHrTtAeReQDXQpkN9IrkZaU9Ip+uLNK3bOJP0?=
 =?us-ascii?Q?I8qRQvPj/ycnGm6t0x+lc9oHN3TwA6y/o/fe1LAuq8SnwchxhybILezhwagB?=
 =?us-ascii?Q?gD3yVVBd+CzSWQc085A/eGzVqeOdm+1/g/6FFAchIXrJZk7M9U7b1AjZzEbc?=
 =?us-ascii?Q?bda4XweWGYxaZD+v/S2eaeuuZe0bYOQGold18B6EQio2dTP/EfwKhOLAK7Wt?=
 =?us-ascii?Q?pwknN9+mLFbLX5iqAnu2U2uqt3W2D0sUHX6TIGKfEZA5sq3Og4PXMZI9nGB5?=
 =?us-ascii?Q?nlad6SOoZiDXiHEvdqAdxN54/OCdofCtKUrDo3rZ56odix0ijG8MSaersXFo?=
 =?us-ascii?Q?F5YUL2gyN4M9pDz5LXhT4gXFAifTun2hcG4ukEaGQDJutmihd1wgDkWu5Jpu?=
 =?us-ascii?Q?1FCgRsfWWXWPx6entos4XLX3dr5Zq/tvHUpc+LPT6TDUPEHEiSWed423aY9N?=
 =?us-ascii?Q?iAkgRLb5E9dNzVxoZCwrOloXb3cBYo2NZEOoNJ4ePZraHoFIJ+P9E+fIceVv?=
 =?us-ascii?Q?l+kUkgs9xfGDyc64y8fwrKtaFt0bo6GhtwKYJAuYNtkLNXxqEYsyXh61zUR1?=
 =?us-ascii?Q?v0DM+Rb5thBgmy1Ql3bxPBaung4bZ984wEG1Ye05wXWGh7GpEDFvVXN/jHhi?=
 =?us-ascii?Q?hg/jSkAt4XSaZGKNSFgZIvn2wj28VXMO+z+W3TywWbfj9F7GeGZoZrivT4Fr?=
 =?us-ascii?Q?OUDINeWIo5hDtaKEHL3fE970oaNrJXMCI4LM4FCcp5xYeXvP+8u1OUxvQPse?=
 =?us-ascii?Q?LxkEb8mfAz045UxqJz6gwP9fax+toZIJtHhirDeDatee/V33zSw2yuHcAVA4?=
 =?us-ascii?Q?Pbh1fjirLEq6vDKb7Em6ncdbm0kDk08u8ob3lvCdy3QD+2JXNtbJBmE73OwR?=
 =?us-ascii?Q?qxwd2ezslD3A47n08FHud0FtNby/23bVh3sgLkn2fG63f8GD231Al+sYm1H7?=
 =?us-ascii?Q?fUxPFUAO1o7HzoTb5eTpZO8lx15T62K4Wa15LPtm1whFQt2YAVEqd8wzgNkh?=
 =?us-ascii?Q?tFE2l/ZyFdsW1g1ZlR2nrIns8LU1ktbBRPcVFRzOhth0udS3aGhz5d/KsnwE?=
 =?us-ascii?Q?neWVMTYExIrnBHJwzb1xin4wzR812Elnn9iM24nfAyM3uIh4aKxnuBxXxHtv?=
 =?us-ascii?Q?03dRyFlXSBA+o/9reVHNz1r2f3NXEbYYXJc2xb+tcwqHl2OWdyM9HC9h+Esb?=
 =?us-ascii?Q?qq4/5SRHqoL2Ihz+8BR2K65Shn0pCHi4DSk35QcE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a53e70f-97eb-4fac-5f99-08daed9bf316
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 15:05:28.2420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjk1IaJTcdOHVFKDOmcKerWHJzjbqWuBWtoYMuDjbxqGWFEWwEdy4MTIBNVUS9/f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5639
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 02:32:44PM +0800, Longfang Liu wrote:
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
>  drivers/vfio/pci/Makefile           |  4 ++
>  drivers/vfio/pci/vfio_pci_core.c    |  3 ++
>  drivers/vfio/pci/vfio_pci_debugfs.c | 76 +++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_debugfs.h | 30 ++++++++++++
>  include/linux/vfio.h                |  6 +++
>  5 files changed, 119 insertions(+)
>  create mode 100644 drivers/vfio/pci/vfio_pci_debugfs.c
>  create mode 100644 drivers/vfio/pci/vfio_pci_debugfs.h
> 
> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index 24c524224da5..efe032623664 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -4,6 +4,10 @@ vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_con
>  vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
>  obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
>  
> +ifneq ($(CONFIG_DEBUG_FS),)
> +	vfio-pci-core-y += vfio_pci_debugfs.o
> +endif

This is now how makefile should be written

vfio-pci-core-$(CONFIG_DEBUG_FS) += vfio_pci_debugfs.o

> +static int vfio_pci_vf_state_read(struct seq_file *seq, void *data)
> +{
> +	struct device *vf_dev = seq->private;
> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
> +	struct vfio_device	*vdev = &core_device->vdev;
> +	enum vfio_device_mig_state state;
> +
> +	(void)vdev->mig_ops->migration_get_state(vdev, &state);

Do not use (void) like this, and why not handle the error?

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

Why are these exported symbols? The core code should handle this on
its own.

If the device defines migration_get_state() then the debugfs should be
created.

Mabye you need an op to populate the driver's debugfs to also trigger
creating the directory

Jason
