Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB8764092B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiLBPR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbiLBPRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:17:23 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F21C512A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 07:17:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nO/n1jgQLxkZzDZTR7Pv7/QkgadAC52nFVM9ScJ3oIOYDqRuU8uL55iKSCJshIm8pDrypu9tpYj4C8gcviJd2GOE2k8GXwYCJP+/OHzkeNHu8yAg88bJifTYpkrkmIqNBqIif0wPujCEPrH7ZRJxrqHdH7ThSL8t74y1S6srhqWdI2ZW9J+95psPjKp1C/tclVIk1Zhef6Prg4qgRcYpgtXD7mBsZZBBssm8YlqCySEmNISbgkPPwuwnPJU0Qj85o+f+49TwZ0iO5sisz8iV5dVL8mGYM7vVjKxTgVRXjAfCZIYQyTMZNnk+rIAFpNIha/eet47KkjfxZPo7Qv052Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQV4nWhKXY/QYI5ZtgI3xMSC3g7GKY0CjSq556qT6SQ=;
 b=QV1MlB2AYKd4Aj1iGrTonF5NO4NVOrvZq9U2GRr09vdQ467P3OJ9hz5I6cvXWq/ukZO9rqz9Ds6AVORnQ7a2SN5UUfacUyO8Hjl77kiM0TWlSGCvIlScFoChW3+CxeZnyXcV3rYBZ+DD1RX3oi1rSnu//mCVRh6LLNXJGg+eJdvF/Y04TN0zQMebyHA1bAWhaeSnJg8xVNq7QmiSUGka/LXcHnimaDhTl1BG2Z0GN+7Qjxp3ef8rJ6RpuPyfQgqDKhdoyCmRivCg6SqD0MN84eL4usC4HXMcAgxxgl5jaPYewftmvp6IbWlNC5Ifu+j9OttAxcUnmBW8d96e32symA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQV4nWhKXY/QYI5ZtgI3xMSC3g7GKY0CjSq556qT6SQ=;
 b=pzj2bLWkxX9V+dk1GiRU/COe9g3g/4ZDBHsBsv5DEPz8bosTZzwqJ/TrHjupW8F+jlDu8WnANL8WGqY9x/41Nzjzsq/EmWsRzKzVEjOfrgy+0XKjyGafvQYWzIDRbFFEp1b9UHGqWLFEGGZOmIE8eIAK+5JhLPDnmpMWqSXPFnGfuh3EiLmJcNPH7GHe2Y6/Eid/wDSdwNNn7uyoNYGH+ALq1FTly1eYrHXm/tTxRtWIv/Eaqw4c8flZAE2z0z9xqbRGnZVUKmLCkcYNwQOmwsMzTtVj5rAuOYS5rXi5EgsBwHtPwyVr8lQsP8cCuCRGIKlVBeLr3QHVZo/MrkUL3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 15:17:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 15:17:18 +0000
Date:   Fri, 2 Dec 2022 11:17:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        john.garry@huawei.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH v4 1/5] vfio/migration: Add debugfs to live migration
 driver
Message-ID: <Y4oW/ToMZEUnlYZ1@nvidia.com>
References: <20221202092625.35075-1-liulongfang@huawei.com>
 <20221202092625.35075-2-liulongfang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202092625.35075-2-liulongfang@huawei.com>
X-ClientProxiedBy: BL1PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB5438:EE_
X-MS-Office365-Filtering-Correlation-Id: d8767cde-78dc-4689-d5e9-08dad4784d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJZo6XcLkANKcvH6xJGyC+5X7YW1+QWfjxkdvEfCFn3CsXQTcSuNJ4FbBYEVcmFFUpzkkP4wa7C8sZAbZ72yk+dJrmLmkCC0lWylnIMb5NeqCwCyVkK4h45QJSUGqZvJwRn2h2FUm21ZLclrnlzZXbHXUYLMBi1TL47oIf5Ed6DvWM5safh4butaTph4lQLPrkHeyi0P+Qzyb9Uka6uZ9DLp2/yH0s/s0teJZ0E1F+9j6ccWPppHvCIWf1UCmB0kV75aYDC7CNiZTNdx/e6/w6MbVPz0HGgSuoKjRvGJGy41gleLvE5s5sGDpTOLiooBaNHaoxQQlSzZ9+HgQ8579WsHw7TFVmOiaPl4a1VsyH4Nc4+ZbcmEZCjQQoWH9CAM4/SHu1iMqlGeuHBXsQoLDT2Eul/dS8B4uoTQcmqOEi+BW6rTcfmQEnnaxJkrhbbpsaQ3wQMRa4+gC+ONqgp1ssP2TJoStWN3uI5SEAzbfLFAH1pQpeujXG8jUhBMxhemUxea7gAs/2+q+i+Aa+HS9KFPnJ7zmtohpkh4R45zQ7mmpKp92R4LBf4b7rzBufRV1zv4BLicjE5Z8dgENT2J7qCblpPoU1hBf7Jalp6lnB8sAK/cbtR86U+J9yplJGkW6e9iVtSLY17kGKsEHoAIew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199015)(36756003)(86362001)(6916009)(6486002)(316002)(5660300002)(8936002)(4744005)(66946007)(8676002)(4326008)(66476007)(41300700001)(478600001)(66556008)(38100700002)(6506007)(2906002)(26005)(6512007)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z5g7HwlIwGfIv1aALLU66ONuQzbor07BcNKDhMxN7RiGW6SVwSmIih/d1iYW?=
 =?us-ascii?Q?vG1+syxpEV3WVS9US0HJs2+gWoKhrkqAAcWtEPIq1pcrTM+XLlwQo85lJdue?=
 =?us-ascii?Q?uouPgcQEpWUUG3qDCswEAN7OciTVOL4+XdmMM0Bl/v95CbLqX83yNdP1PDYa?=
 =?us-ascii?Q?FyQV39VrHrfo8rRjeeeIPMChg92WEnWN0moTGHGc4L9wntIwR9UbAUDZudol?=
 =?us-ascii?Q?du+ZRTT8aWud/qEQ76iaop2Oae4Yu11+EwU2fQ0ud2bAm8Ejsq1X/3MOdrwI?=
 =?us-ascii?Q?n7YYc+CUg9H6ztUMXhtB1P0NTRZsgYA6kYjeZuUEWmfEeSeGIZE9FtpztJFP?=
 =?us-ascii?Q?eiRb/rr+X6ttL3YMlSdttcVRbSXNv267TYTDH4MAGPq2a1yXmXEvcmZqALnw?=
 =?us-ascii?Q?2N0995EaXltmxcoZx0j3g+mC6oCiH3EOEBWVw6ekucSEreRg1nN9Cb4PsRIi?=
 =?us-ascii?Q?0P/q1OaPxDZAileHDHI0taJW+atxNEtohciSuqn5ZQcII5lsO1amj0NGyLBj?=
 =?us-ascii?Q?ZHqAXsJVhxlxtFXQQGfgg/v6z8hSPvWLbwXgP1ixhkwh8MxpZvNnfdVoSruW?=
 =?us-ascii?Q?2k8mSsDwMKx00lTxuifFuDr3ON7Gu7p4/WKMCIsSXPcXVlvp+cnntmNYNrzh?=
 =?us-ascii?Q?Et3IIvs5k/U7T2T+S/nYM3cd0NCwyZY/2R9NIcsi8CQL1PGCLQbnxcb3rpkP?=
 =?us-ascii?Q?ay82xVKWrgsJhj3sQGTM5u229qlwB4VuFmpAAmIxh3w0EbFZ/FwW0shpf/Vc?=
 =?us-ascii?Q?AG3O0Q4O4ey9pg8lp1ayyL3PVlMh09BXGrGnDLhPC8NxcH+Pgtt2y6LNIQdH?=
 =?us-ascii?Q?+rUGVbGYYRYyKYd02e0q/UjAwbrm29mjmZq47zyF7/SCuMJYvRO/e1aLRckV?=
 =?us-ascii?Q?wZ7kxcp0XslwmTb/rmcrHTsQ6mdkd01cMQbx6PqPYHx3/9qnxhYOCCaevaVN?=
 =?us-ascii?Q?DaItfdV6xDXIO1LJ5X81kkL/MeitPwsB69q0fNgzeR7QUbKOiR6ywoF3qa9N?=
 =?us-ascii?Q?6Shebh4wMtbgF2TIULFsq64WbJuYN93UVe+DI2qEi8RpZ3zHb2m0f/loZTJl?=
 =?us-ascii?Q?BYGDYi4xGpUSWHA05c1n7goLOVkcMYI/fhiwKQrylvm8spNYTVsqX3Y28Qsg?=
 =?us-ascii?Q?/xUfcor4ZRMzX25KYazWYFw4eQu0bgjJv8fyM14OFvJ0ltA/4TGeUrrIyhwY?=
 =?us-ascii?Q?OwpMNbzoUaNBYKAQtDVW725bYD/9YSdlohElfRLpvQHHe08OkZYMsPChQkUU?=
 =?us-ascii?Q?3NecO/AXCaPiVQCMq+ZQVFef2hrYUmDcrWb3mWvu5UxJb7UAbrHsows/1lIT?=
 =?us-ascii?Q?J1jXjT83VAjYRSOuoiJtkPTx0fvBNVPanTueIMH9KaOmVKh2fJHrNY2T2az/?=
 =?us-ascii?Q?+GNE2/o3N0qnzDWTze6uBrVhKMuuoKckDaQofPUw3i4r5n2iFM2+XGBFEF+K?=
 =?us-ascii?Q?g5N+6oDStyz1Zvj0oNo67CMURQXlpJ1tnnP5J6B558aGnhYYUL5zpylAaTys?=
 =?us-ascii?Q?LENcoTmmZXhjarNSoHnXoXkjwDKntI6OiBwt/UDli+XDOmyjMgco7d2QH3xf?=
 =?us-ascii?Q?iiDopYonsS92sAfbYQQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8767cde-78dc-4689-d5e9-08dad4784d4a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 15:17:18.5197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zM7m4xRrpY3zcvW8iwv06WUa6fXxSioFdQNLEHrvZsYE/v/sQbAR4UyvXXW+IkNs
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

On Fri, Dec 02, 2022 at 05:26:21PM +0800, Longfang Liu wrote:

> +static ssize_t vfio_pci_vf_state_read(struct file *filp, char __user *buffer,
> +			   size_t count, loff_t *pos)
> +{

This would be better to use debugfs_create_devm_seqfile()

Then you can simply use seq_printf()

> @@ -119,6 +129,8 @@ struct vfio_migration_ops {
>  				   enum vfio_device_mig_state *curr_state);
>  	int (*migration_get_data_size)(struct vfio_device *device,
>  				       unsigned long *stop_copy_length);
> +	int (*migration_get_data)(struct vfio_device *device, char *buffer);
> +	int (*migration_get_attr)(struct vfio_device *device, char
>  				   *buffer);

Still no to passing through debugfs ops, create these files in the
driver.

Jason
