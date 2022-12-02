Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D930A64093C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbiLBPV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiLBPVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:21:22 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B79D9B29
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 07:21:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+2WciKZSxloVaPMMg0R0TD39p4KivcjZznwosyoJXn+WV/i3tPdz3nwqmaO5RqqzxbHOFSzzq1Qe28OgmdlqY1IGybW5Mh7YL8kGQDngjd8T1qj2chkpNIEDbHqlihS51JW2+SuEVN1vLczCe56C+yvkk4ZXC986KpbzUy/wkpod6EXx2XYUh8uKfCgz6vwa1+9xmNHUpMs+oC4UW0Qm1wmEctnbwuvoGb/pBppnbSoh3fznpRfuITt1ZFqPIUfS8DPguHwYXl2221YJconSk5fezgyts+Cooacndn0NMmMTAzsmvFX1aBkOTxk61+yAn0XbaBOzwiglUVFlq4qTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTa4AQyU8kNoSosRU/jmtYA+w+sPZCSTR9kA1l88oqc=;
 b=AjnRHuGjQ+SuJipA1C1cbtV30mh0lPlR5lykNPrGXCAY9jyu2gW/l+nYYewnvSflNXkyoZGmU8DbmGXveLcNXYV02Kqdf1TRJuunqIjqJzHLaBAOvn+kYRMB4sEmoJEY9JZ2mfaGDjGZs7DEroTJVDK2bZ49kn2S+EcpZAMQdmzHr7f+wwk+9rcCOe5ambNzuL8GBLO6gj97ETdX1gV59EZRlOIkAbB5kpvJ2yVj1l4NtJT6/ko2jRl9zSqf/v1M+LfXkAemDR9ujBOhne+c4lvtF9U+Wu1y4QbI+3lb6J6C13UHGdfyejMQa24zgyvO45hWuTYlC7ExL6yO0mtBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTa4AQyU8kNoSosRU/jmtYA+w+sPZCSTR9kA1l88oqc=;
 b=Ib5aA9WIWDFvmtbjZyrRdfHZzVjeYxKSlYpCjihaMsa/TDi/rD6HOnaGM9LWW9H7nm3U9/q73cPoHIy8VpEO8JZm4TyFTbSUynQehUlp+yqWDP0osSpyAS6rKafvaieldhv+RwnxdTB/Yd/fkndDpuB3vMM9BVYQcSZ/Ad1vbiHVATXB65Oe6QsVZXbuSY9t0vsHINZZUW3ld2Vu1C6uEyk9pR63mYCQlYCYwO010Jjc5LAMtU7YOQMISBOPzS9RRoUAp4/qjCFduXQhIUCtUJ9U5jLTzhymXHhVBMs4HwKSmCTlscODBo2Fh12gWcEKzLMPD9634lEuZlhLCbIs+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 15:21:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 15:21:08 +0000
Date:   Fri, 2 Dec 2022 11:21:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        john.garry@huawei.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH v4 3/5] hisi_acc_vfio_pci: register debugfs for hisilicon
 migration driver
Message-ID: <Y4oX4zC0eUbZsmMW@nvidia.com>
References: <20221202092625.35075-1-liulongfang@huawei.com>
 <20221202092625.35075-4-liulongfang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202092625.35075-4-liulongfang@huawei.com>
X-ClientProxiedBy: MN2PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:208:15e::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB5438:EE_
X-MS-Office365-Filtering-Correlation-Id: ec2c91f9-1d25-4750-6c4a-08dad478d690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I02FNHulY7IFQOzJ1i8DZRs2+NIyYL8dG5+ExMHnl6dd0Oqiz8N3ZIpCbMXsMtNlLJeFuJKluwNlbK4zWshZL4GupfyOLAR5Yuq7gfRlC0aPBeEs84pM0ZFzGXabr6xrLWDlGGgy0Y3bF+MwPLDwuseH1wDod7U7FaC3cx3EpmUCrZPuG7KNbi4CPsJXJPXTD9V4/cPlug4Eh5aZ9nJvOvNFE+Vw4Lh8arqUcHNKsjFS96XamfT3ZxrYEfJIKXE8nGRnxZk4nokG6MjtYTuYArPrfc/YbLpk3FnSyrtFAl9KF5AbDKupn659DuSoIYJzxCW/o/NIPmJQuICRWWQJjI7JHh7Eyv3bcw8DqmeZHzKMDznsO5t+/CODM7+5eHSSXUyqdRLtCdHmHzvnoY0kmdRQyscK5y6OzPlmEEiEAqVYv2bJQcOf06+Axb0qpvnMMLlxel2x965iSo0lfWzTPWJwgVNAO6kHy0ASRV0f2pBx0b1RuyBrLgJ7ofuer9RKI42YB1Jx3j1bki/ypwH1NEq3/XVkcMsIL2l5y9VgO7Nec4CgwxIVFiqrrSvJ8HpB2XgB9BhsoYJNjFx0TvlRZ4CucIsY6orP3/eTTh32gtT7cU3kGR3utPdPc38dMriFrynjWl0nX/AgjF/UG2XoVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199015)(36756003)(86362001)(6916009)(6486002)(316002)(5660300002)(8936002)(66946007)(8676002)(4326008)(66476007)(41300700001)(478600001)(66556008)(83380400001)(38100700002)(6506007)(2906002)(26005)(6512007)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?86FBWcQ5evX9xal1hXK86nR2bnrSqqdAjEUTgjPHC8VEdFqnPDzjNnL7/cl0?=
 =?us-ascii?Q?6ZOqwn1f2Gsf21G6LJmqaDBBaLH2/Mh4Pf+YVv0ELCrWuP2rxm5jvrQeR3pP?=
 =?us-ascii?Q?vc9YYMa1csJoaui39Mw12Onyx43wBeW4P7sa8eq+zzR5QpT2nGPF5MdmwEPk?=
 =?us-ascii?Q?G3CcGtJ55+1olKaVn+Pv7W4e2PIlfvIT7bKKuWL0dUmR0pODyDlsgG5yiVGO?=
 =?us-ascii?Q?bYtiZRZAp0F7KfnbKW4lMj+Qczegt6YMr79na6eN5HNTL34a/DxebEmsLBdN?=
 =?us-ascii?Q?rDkXkIXKWIOW7q7M0zyQTMSofFnzQso/ME6QPq5a8B9jD9Sydlg/0ttfK8YJ?=
 =?us-ascii?Q?hnVyiNC+tcrA4bYAHtMEMtADhnq4RYOOOOfau8/2+dwaMiqxrQvGMCsjWgl0?=
 =?us-ascii?Q?ilSIIyseqWmPyuwGQcFIQJxhZFxBLuqf08bR3zugi2yIgpUqYv7bUGyVxYxj?=
 =?us-ascii?Q?Q7QxspCRT0vRT23bjdNaf75CvEy/S0c/o9Z6f/O5iiIkCHN/FaFmaEIkYHK6?=
 =?us-ascii?Q?QSK96hpHYpJQkB0wG0ub4ONIsZUk5y5E46gldZ8k2u1LFucHnff+PTc/G2aP?=
 =?us-ascii?Q?/7nlaTZweTXNfjZGe7zCLuohofSXcN5KnUd1Avor8HvKxpKPPaNZOfeUMv/5?=
 =?us-ascii?Q?ZrrbakxrO3AqojHsBiOv5Odn1shMZwxFcIc5TLUp5Lfhf1ASoT6of6JzPPgi?=
 =?us-ascii?Q?PTH2X9CbEukRuS9Ai02/XK5h2VfUNqg92EhXtNuONicJgzj4CrbgD0Fg/ehm?=
 =?us-ascii?Q?7jyYePLb+WLhY1CXQjJ0672dTEnu326khDKUyNhz5cSYcrMLZuM5PDziUVcH?=
 =?us-ascii?Q?mtj+QR8VxrZmuIDmMxQe9i1XUGwbUf522CFjg8/WtaRFqMVK1rMBz5xeGdeT?=
 =?us-ascii?Q?WRXPmAm9CU/IEYc2TAEx+0Lm4OdzJSu6sTWnH/OptrosG3agZIntFLs3+KRw?=
 =?us-ascii?Q?rqwVZF+qlMuMqOcSavWM6pC3r+fGeWB73EmO7F89ytldu3TQLfPKw0tckRrb?=
 =?us-ascii?Q?cvs3jh2t5wvhAyG2w6zu/kaDtc7iNo5pQVo0f5HGiOPEZ5e9XlAGDCw5IKWP?=
 =?us-ascii?Q?2WaEtf8s0bLX8c2dRgZuIQt/lrqg/BkWFfAjtkNxeW7t7QK7kdORYcZkh3//?=
 =?us-ascii?Q?b3CXaGaDtEsN+PW+NsVd5cjsugC6usxLLp337UOy+GJuCWXbAiu+ylUSGzV3?=
 =?us-ascii?Q?LQ/j2/OcrVQFqsSQLArn9qyJ3fbSEuXwhaMGKC5710CA6q61Y2lw4n73wE+r?=
 =?us-ascii?Q?oDcrhkk4DLhM2t6d+KzhlcgK7KseW3GjjCvPdMp03D2+B95V4FRbjHC1pKFx?=
 =?us-ascii?Q?d1H3t/nqFwFjBG8kX3Rzwdf5SMZc7qV4jbLMBY6MS+lMw3iBRSUK+IRST1Nu?=
 =?us-ascii?Q?EJ1iNa24Qjp1MFSVHSJe/EIXl3pD3gqVty4g5Dg4FOPE2fBlPRacr2Ae1B0k?=
 =?us-ascii?Q?h6uwXhsAyuk3b0OwK23AXxMKvtQF1IAUnpsdXSA5iuA0jZEuT5O89BUcXs5h?=
 =?us-ascii?Q?usqd2MEp5GTm0qa8p0xK5TjzM+wOnnjRoj8Xv46oWSw6932/MrKJPkkSKnjK?=
 =?us-ascii?Q?dklSrGqe2OAxdgp/kcs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2c91f9-1d25-4750-6c4a-08dad478d690
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 15:21:08.8549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zApJCUEyHKMV6X0/nqosXCBKhNrxF32Q3bxf7oSBR+f+zVh2IzkD5vZv4lxMB1pP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5438
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 05:26:23PM +0800, Longfang Liu wrote:
> On the debugfs framework of VFIO, register the debug function
> for the live migration driver of the hisilicon accelerator device.
> 
> On the basis of the original public debug function, a private debug
> function is added, so that the single-step debugging function
> during live migration can be realized.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 250 ++++++++++++++++++
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |   9 +
>  drivers/vfio/pci/vfio_pci_debugfs.c           |  10 +-
>  3 files changed, 268 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index eb18edffbd5f..0f35cde6e8ec 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -15,6 +15,7 @@
>  #include <linux/anon_inodes.h>
>  
>  #include "hisi_acc_vfio_pci.h"
> +#include "../vfio_pci_debugfs.h"
>  
>  /* Return 0 on VM acc device ready, -ETIMEDOUT hardware timeout */
>  static int qm_wait_dev_not_ready(struct hisi_qm *qm)
> @@ -609,6 +610,18 @@ hisi_acc_check_int_state(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>  	}
>  }
>  
> +static void hisi_acc_vf_migf_save(struct hisi_acc_vf_migration_file *src_migf,
> +	struct hisi_acc_vf_migration_file *dst_migf)
> +{
> +	if (!dst_migf)
> +		return;
> +
> +	dst_migf->disabled = false;
> +	dst_migf->total_length = src_migf->total_length;
> +	memcpy(&dst_migf->vf_data, &src_migf->vf_data,
> +		    sizeof(struct acc_vf_data));
> +}
> +
>  static void hisi_acc_vf_disable_fd(struct hisi_acc_vf_migration_file *migf)
>  {
>  	mutex_lock(&migf->lock);
> @@ -621,12 +634,16 @@ static void hisi_acc_vf_disable_fd(struct hisi_acc_vf_migration_file *migf)
>  static void hisi_acc_vf_disable_fds(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>  {
>  	if (hisi_acc_vdev->resuming_migf) {
> +		hisi_acc_vf_migf_save(hisi_acc_vdev->resuming_migf,
> +						hisi_acc_vdev->debug_migf);
>  		hisi_acc_vf_disable_fd(hisi_acc_vdev->resuming_migf);
>  		fput(hisi_acc_vdev->resuming_migf->filp);
>  		hisi_acc_vdev->resuming_migf = NULL;
>  	}
>  
>  	if (hisi_acc_vdev->saving_migf) {
> +		hisi_acc_vf_migf_save(hisi_acc_vdev->saving_migf,
> +						hisi_acc_vdev->debug_migf);
>  		hisi_acc_vf_disable_fd(hisi_acc_vdev->saving_migf);
>  		fput(hisi_acc_vdev->saving_migf->filp);
>  		hisi_acc_vdev->saving_migf = NULL;
> @@ -1188,6 +1205,231 @@ static long hisi_acc_vfio_pci_ioctl(struct vfio_device *core_vdev, unsigned int
>  	return vfio_pci_core_ioctl(core_vdev, cmd, arg);
>  }
>  
> +static int hisi_acc_vf_debug_io(struct vfio_device *vdev)
> +{
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
> +	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
> +	struct device *dev = vdev->dev;
> +	u64 data;
> +	int ret;
> +
> +	data = readl(vf_qm->io_base + QM_MB_CMD_SEND_BASE);
> +	dev_info(dev, "debug mailbox val: 0x%llx\n", data);
> +
> +	ret = qm_wait_dev_not_ready(vf_qm);
> +	if (ret)
> +		dev_err(dev, "VF device not ready!\n");

debugfs has helpers for this, you should use debugfs_print_regs32()

> +static int hisi_acc_vf_debug_resume(struct vfio_device *vdev)
> +{
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
> +	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
> +	struct device *dev = vdev->dev;
> +	int ret;
> +
> +	ret = vf_qm_state_save(hisi_acc_vdev, migf);
> +	if (ret) {
> +		dev_err(dev, "failed to save device data!\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = vf_qm_check_match(hisi_acc_vdev, migf);
> +	if (ret) {
> +		dev_err(dev, "failed to match the VF!\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = vf_qm_load_data(hisi_acc_vdev, migf);
> +	if (ret) {
> +		dev_err(dev, "failed to recover the VF!\n");
> +		return -EINVAL;
> +	}
> +
> +	vf_qm_fun_reset(&hisi_acc_vdev->vf_qm);
> +	dev_info(dev, "successful to resume device data!\n");
> +
> +	return 0;
> +}

This doesn't seem like it belongs in debugfs at all, please just write
a test progam using normal vfio ioctls to do these steps and put in
the kernel selftests directory.

> +static int hisi_acc_vf_debug_save(struct vfio_device *vdev)
> +{
> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
> +	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
> +	struct device *dev = vdev->dev;
> +	int ret;
> +
> +	ret = vf_qm_state_save(hisi_acc_vdev, migf);
> +	if (ret) {
> +		dev_err(dev, "failed to save device data!\n");
> +		return -EINVAL;
> +	}
> +	dev_info(dev, "successful to save device data!\n");
> +
> +	return 0;
> +}

Ditto, I don't think debugfs should be accessing the device state
independently of the main FSM.

Jason
