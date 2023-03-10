Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350D36B4E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjCJRX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjCJRXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:23:32 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E995B9C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:22:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOvMxeSMiV3f3K977iQg8T9SRtSJrBEJKAxz4568kVOtVCisXFffNlfSUFiErHjMADO4uDRv0I05hOGSEq6Mks3GJWg6gdyyHm53Lwy8umy88An7WMTqsWlRUYCRWuq5fV9kpQrlTuj05et0ezSAZPk5gUquzQ8Otb5ne5QNKTXaDnWrjqZuGy4xaTvNJOHPegA/x2Zfny13C778HvIHMH7gkWMthKZaomWq2/I5iMp3AhdGDC0ebCHpBYH7nHy+WVn6bX10ikOqztG3BydDVQtTwZJLVDCQ+JTeBYyBlMKGca9p+sk+gwloYvWRsjfIz1Zj32cTFsn/CiyXzpU3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2lecgZd7EJl1n2ytMc1H2+7/HBclYSCANJ4wxOUhjc=;
 b=VlaSAflJ3QCe0AAoPVasxRtZ31MEPs82WhW6b33anBp0Qdhm7qjiMSwNqv43jnNDAsliwJGH+OF3ozisWZWKUq6jFnfiB+zKjciYJ5vmVhpAwZ/rhFEaaIlpuwQ0RzpXcGHe7L6oBdG6B0nUG88h/Pb//Etd3vX0/WMV+5C8vAc6PvOv8EAKtJQlWSoC4IKzUT7kegDDTy1q/Ms2PmkPeQsnxnKme+naG3UhaINjpGBXAg/X/LWEMjo8PdOpvHtOlZgLexD7SUyUUaO79m8wyMn6GryzRjp6r0u5bc7+ld65EOVbIdAaDRjmAzZkpvbwrdOsc/zRcN9J68/whEgfQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2lecgZd7EJl1n2ytMc1H2+7/HBclYSCANJ4wxOUhjc=;
 b=B3YfEEDqWkD2rRNf0UOfeL8t0Nw/nmSnMHC0vR7E9VJ6wMyEIoQJdtrUSY7IYeORdYXvEKCc2qP5XnhUJq0+/1B+AS0ncjVzdpD8D9JTjyyJhwOSM40RgU52Ps44UijNB5byyTRqRC2vrjnCtB1qcaT809hoKOnkUyh4p/wGnRzjmSoknweyIiKtjN35+zXtrytx/QEdRGrK3ygqRETUDegIVuYpDa1EcAxJQ0t4AJGHVvdtudR2Wa62V5zgoRaxhjEU2nG6BCfxVqsq6W0iwGhp1t1gCJrfud1MvDEe5T1+h5bGHGO4KHvdrA4O87OAGJpQNxU0+2Ni998QWmyc3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 17:22:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 17:22:51 +0000
Date:   Fri, 10 Mar 2023 13:22:48 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        jonathan.cameron@huawei.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH v8 3/5] hisi_acc_vfio_pci: register debugfs for hisilicon
 migration driver
Message-ID: <ZAtnaFHucAe9ntKW@nvidia.com>
References: <20230217084831.35783-1-liulongfang@huawei.com>
 <20230217084831.35783-4-liulongfang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217084831.35783-4-liulongfang@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c8d800-6537-4020-97ad-08db218c13a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZXdsNcIZkz3PsQXajg1n4wCyhnPboROftLTpM/LXXvPysRQM8JBiqGoiM/8OBYet7viIHBKV1XThoO4P5mn7IUuU0bn4lHdq8O8oGDqvjxoMP/ENq52gjZlFmA0P7nsv5EFQNGRg8rQbxuutVUBlcNlp7U+Ao1TllOnV96+PQcLMbB81qO5qQEc66os0bQiO1/zi9ocAsfMOCl1kefce4azHOedqF3XZPrT0dDm/pBhe5J/g5YBEZYPnCgr3C9trZU8CWbToNNIf62Vy8BzfzRaK4ev1kyekaws3bjialt7in3Lz7kkGUSApKh0usQ9OGaWr7CbNZlM7kfwtPDMvzGTiU0BT8FqhYEWn9bbi2M9SFIQzB+2zje+MUA6ibLAkoUpnB6d/rTSUB49L2hxHMQeBz13o/mt/uQLFJDpim4CGmJvgGaa8K3/3MIrPGTyWTH3sUzTxv3WjfP3vZ3OWWobmJJzry4bUlqAR9vAu2gH16qdB6DpjsRPiowWrabH2VD59/WTemcvfUfkQt5mVVGoBM7s7NNHNUJMGRp/eVKdlKd9sGoAd8edpDDuUUj0vSNXLLWQh066/r/amjV2HS6ZTUNH0b4AjoNJJeiPzEeCH7JW2fEYNAkXjfJTDb13peNfXc+HkTtvo8lQ/zFYr3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199018)(66946007)(2906002)(5660300002)(26005)(8676002)(36756003)(4744005)(8936002)(4326008)(66556008)(6916009)(66476007)(316002)(86362001)(478600001)(6486002)(6666004)(38100700002)(6512007)(41300700001)(6506007)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c/2GW8Ae0YP/WcYf3QmzT3usF2VR9Lo13PL2pXI9TE8xpmZhM5UjbDL6EgOY?=
 =?us-ascii?Q?uKfnmCGV57jGgvOdvSt5uunUfLGjycSOAsSG5BIMnNIOwre0feK5MFxNc9bo?=
 =?us-ascii?Q?J2MbqKhqkBgc0n6mFErsPhyTveyixN24KCXikurdFdUGhkZzA3yZas5gX1VG?=
 =?us-ascii?Q?qe911bmA1HKoDYMufbuiDhUj4k4iWeG68JX5aRHLR4tQWzvhizfvCE6DwKkr?=
 =?us-ascii?Q?gBBM+JxSyw3nf5EAHT/zwCCqJWLcX6pUpIk9cq/2zTgrPB20uIa5qZy06wOI?=
 =?us-ascii?Q?cs4+PbcLYPBRQvtIU0CigT0R7BvImYVFt+XtSqhm8LEkSS5z1ZC1LpdzA2b0?=
 =?us-ascii?Q?60flmkrU1JswAdxxhLhR4L/MzI7yR7WG1lpj8/eNj5XsOUExSOKAwtHY/qML?=
 =?us-ascii?Q?FqoRqHEkqIBEnTUu25yk3Mi5nPqssf/mowdusC9j+F/4JMtAsiJ2ZVQuZ+b0?=
 =?us-ascii?Q?ODbYDPBzn8o1CO41mm9PyL3c7bI3VNG8Q1s0wGCWxY+JMOZJIC1F9i+AIsbg?=
 =?us-ascii?Q?u+XYb+d+xoUVmruElEJXZqeGytisC21tbjMKSOlVZ14epO5Y03vzVc0w0W5V?=
 =?us-ascii?Q?71tgVIgqV28KTUGu6A5SuJg7fNqwfd6o50Ss3067UKEadOY4tHf8ujTBvGSc?=
 =?us-ascii?Q?nxQbE2GIRqLT73a5lqs3NYNThZyjcnY3LSnj+kFKVqdQPVkZyRRqVLe+cv1Q?=
 =?us-ascii?Q?POhAvuwAYbsgsjBrluERK9WA3xuARQS/Rkh/fqpSIRl1TH14DBsCFsgcEyCR?=
 =?us-ascii?Q?Y4AnG1zBORPrp7oCDpgtaKg5mX9BPmuTsu+Cxh1Cpnhnzn2RmuhEGZA1n6er?=
 =?us-ascii?Q?BKftTLJ93f6M6+qOJnrzB6JXU31hJPfLnjxhuWkOFSa4Rgp8q1UCJ1yoBHry?=
 =?us-ascii?Q?VYRpx9FeCd8rhOKRxsNfKnsaNhwy1VAfDduYCguu/7wsxZmjwGbzcrjVDA/M?=
 =?us-ascii?Q?VsAf7sN0M0B69WDKSqfK3BqER0cQ+2Ja28lO1+s9D2ZjBZMt6CK9nelvkXDq?=
 =?us-ascii?Q?EQCaC98nHFEC5hoISXApmAnmzkrBGVXs6Q+3rKDqy/LqMxGCAQsIAHWaK2BS?=
 =?us-ascii?Q?qQGqjFTSqLeOyTQ+7o2DmTdUFxgGOfzVBrjclo/yZfzf1wkzqUiUNuusBjVz?=
 =?us-ascii?Q?twu6v0Tx5Cie3mPii0AdZr5Day7Bstk8l9pHAnrw8ipz17ALj95GMSyHf7+k?=
 =?us-ascii?Q?94w5Q1z86HclmKHFwGQSJLmIFY1xruNXISh9GkDyiQ1Hh0mHmx7lz7aKwKFt?=
 =?us-ascii?Q?/UI9ljNiE/beLICmrCHd7K/IoRpKPwh9ZdgLq1SvfjY9FyefcWUbDFjCSNF8?=
 =?us-ascii?Q?0FNmFrhPSqdjrl/QpSzWhxXls6e22uNwFL4h1yH5axwixG1y7zfS4rlxvdax?=
 =?us-ascii?Q?40gcjRZdLNnK1YVaIzLu7MXLmDgJBojrWCKZe9VWuxV9VAXAM1ceekfARDsx?=
 =?us-ascii?Q?hoglMa1aJniQfujZwEtQJTZrVF76DHKo84LjGqjXcgZL38VmfKP10O/fzplZ?=
 =?us-ascii?Q?85FbnGRAEODBPGKwNXX/bXA8IBrgX9etJWNvqzTFpykIyGQHBMdCotHG5rNg?=
 =?us-ascii?Q?4DxDbVgIKFZrMLXhO2ldDiZl6YE9BAVU/4piowiO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c8d800-6537-4020-97ad-08db218c13a6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 17:22:51.3754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBkH0Qln+xj5MqmNwygAr4w4wimz3Wq2hfyCIGnURodDXaBaQeJzPA60gn1FipaL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 04:48:29PM +0800, Longfang Liu wrote:

> +static int hisi_acc_vfio_debug_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
> +{
> +	struct vfio_device *vdev = &hisi_acc_vdev->core_device.vdev;
> +	struct device *dev = vdev->dev;
> +	void *migf = NULL;
> +
> +	if (!debugfs_initialized())
> +		return 0;
> +
> +	vfio_vf_debugfs_init(vdev);

This is weirdly named with _vf_, this is just
vfio_device_debufs_init()

Jason
