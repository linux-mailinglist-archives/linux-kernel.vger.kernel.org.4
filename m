Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0506B4E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCJRNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJRNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:13:05 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20605.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::605])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39BBE074
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:13:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8/ScCahpJ87FAo+xH+C4ddqb6dS4L2ROPm0LSj4mPIdIhi9JGJ5sgjYUV1Ce/9MlVBXxcgsnXkQ8V4SvzbQJ+1kS95UP3kTVMpCkprgmGLow51KE/O9C95cm25kDB7K4U9uqgvzMVUi0aCaCRtGqCvOBZZYJgcO/V+yCHvHNKR+Q5KURIOhs0eXdhU/jbNeEvAINaefQMqA2h8wmwZvAE6OYC1bc1yIxE0FJPte3Pv5xWkBOKjyoTRkmj2J8D7f6zrp2sdkeGmYoZMXjTGfUFcFzUQVwaPbTEedQjYhQQGIBm/61p+J9TdnCyirvZSSo1vWrrp4zMYlWQd5vKQ27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ed58binvAUIIggCfFgXE3Pf+Dtw0CS6c7tuki++NR8=;
 b=Fii1HaiG8qVGb8BOgPqNiXeNqYEQZ2+QScMJ0Bfgns+48PMA/SgNto6arCwHtUCCiDbcFWUkmCJV72bDfoS3GyToxZ4KpHTfxQksjR6Ym3dXLLm7UKhkU3LA7Vhc9XtfOkjffxb30EYNoQ8TYYMk67XO2AaDYlOfW93JZSJMBAsRP6uApdLSgR0deTH7mVPFF8t1UHKleHAUm2igARykGTvb+qiQVvy4dpdtaZqcfSlNT1xzSPajVv7wyfrIFWXnumjBtAeiV3xpMI3B/y303kQ87NvG/TakbY936xS1JC0wXTCn7KjgxnwKNgs+jgtP5cxCEdLOy1hD20vyeqATug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ed58binvAUIIggCfFgXE3Pf+Dtw0CS6c7tuki++NR8=;
 b=rB5Xo6CLm4M8cZw0T7kVVZn9t6BCRDLTEW9CeH3+9gyoGqgNcYhz9H1i/O72iaMFpZkTx/C6Z5YzMhQUzTKamQFxy11WmwrlyoytZlRausFRyVqZ6xSbFTTeX71oD3qMG2qFkxhV5ai4+zncuraDqqKh+7kL7lKI4tVqk50BE5z6zMJuCdEkGVYFsO5Fs+h4Hqx/MzHoIzjKj5yI7yp+BX1O1edo5MDNR2fxlo6q0C7ebDt/R9eOy2wYcihWNs3SVeKONI/yDDjzXbVoUwOcAQmC1/YPNYmegQKvfDrMGck1CnoutmfX7HP4mZo2Nt6M3JFEqpIJDAx6CFT9neZLeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 17:12:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 17:12:59 +0000
Date:   Fri, 10 Mar 2023 13:12:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        jonathan.cameron@huawei.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH v8 1/5] vfio/migration: Add debugfs to live migration
 driver
Message-ID: <ZAtlGDGZvBMMvE9R@nvidia.com>
References: <20230217084831.35783-1-liulongfang@huawei.com>
 <20230217084831.35783-2-liulongfang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217084831.35783-2-liulongfang@huawei.com>
X-ClientProxiedBy: BYAPR11CA0077.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: c00cf207-e0a3-4261-4462-08db218ab28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61c0rypTV4j89FrT+l2hRfhhEibJs64jqBWsTvznmbFJE+XiZ9KSCDtEgzcNpQ4wnh7hcBoCuXMqWFnxzGRRv48/sirrsSvGIX8ZEn9eEkkzHnZ5NKk6eV9oxZ8Le/vT0OjjK7HcqfRSIxFhvnGm6ojKb9fMEszL/A77VWcYMctnQ2Ip13hOfZQmN3JxnEs++ilkpZwO3OENt1qsUijnf+h0/IQS5PuG929ktDb2ASR4/UnbVP7N44j0UhADH6yd/GxqqCr26GF8jv0kC8ikk6SLC0+8NvWGqcc9pTZ9YtyMkNO4RUueCY3VXv/3+VWbKTW67GEdE8aJG7veYux0WyFEg05r0iaoUiRdOr44mARbeyNuyMAzjpqxq1HkvDbsriEwUnMxqHCZNuZw52jOmYwJhisbI3G1/a9WDoLC+gVQ47jIwUPAfjQS8P9FJOgskOSvHPGl2wiIPpHsNr/aWk3W8dvR0AOnkkv6rjnizPy+QfWHO8SDRA9+uRFlfHIZFE1HuoXeca0xS5U0yYTpBJmcUQTggvviZJ0ERri2bXvHGYJWMVGLvGHHM6BoRckLUey+rQCyx5+MdHKr3bZfZpEKncXT7KppWDW2s+jyzbZeKyy9+oQ4i8lmeQRk7LZPIhmty1oF7IUcILx9W4xMXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(451199018)(6512007)(6486002)(6506007)(26005)(2616005)(6666004)(186003)(316002)(66946007)(66556008)(66476007)(8676002)(8936002)(5660300002)(4326008)(41300700001)(2906002)(6916009)(4744005)(38100700002)(86362001)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cj0BU/ageMYzK3qAXowkCEpb+7jSXbvt8RMaVEHQ0EK9jTTO1lxzXYmwNpAW?=
 =?us-ascii?Q?aJYFTrBgm2j/+okeE157zjblJcAzVGm7LSk5tXmO8JaY0AK8DJR64zUA/S3I?=
 =?us-ascii?Q?ywGhhOZGSJNw+1JA9AUsXLQNX28VCvo6oRxQtHnzRrwQ+KzdYEjCsWtXmd7F?=
 =?us-ascii?Q?KQY7oxsXpbmRX6ibX6hJhNEaU9D+j3P34VLvSEavEWI6L4sSA/7PnI4oL4q5?=
 =?us-ascii?Q?qLSdnxvsc7FQZjLUlFukk1AvVtgmnH479PabRxf5zn7aT8NjVRJSVBjGq/Td?=
 =?us-ascii?Q?negbTe8YwQcC9XuTOcqR25meIShwbUG8JapYQ217ELhtTJqvQWr/lF4cxiG6?=
 =?us-ascii?Q?CurZzb6uB0tYKEM/AxwXD5jNxl117hUHToYhMmYd3HkaSpMxSDbI9yGzyRTI?=
 =?us-ascii?Q?Ma4EHFBMJkF5MJH9JwU+R8HOysKnFKiMcClkf+i/OC79CyRvNe9IEF4QM2Rx?=
 =?us-ascii?Q?T4Au3nDqZftctwiz+KOTB/dTAt8AhfVwnusTj3eyM/dWEd6ODj0ie/g8dTQq?=
 =?us-ascii?Q?Y+La3YX6Zzc+fZes6+xrMl/3Zicgt3B/Si2p/ZZeHf2KxEIBET/pQgiVKOkR?=
 =?us-ascii?Q?wEpXRsSrVH+ebDZPUZH5FJSINfpVUuymil5kVXzFFA/eR0gfNiKkU9SJhWtH?=
 =?us-ascii?Q?qAP8/zZkjqouac+J98DPHL7+E81FocJAD/RSRbzmkpQkOttqlfJxGGLpBodE?=
 =?us-ascii?Q?BPi7rZXxUa0lKr4rbSg/sktrlWHtF5BuIn09rfJLvuM8aHXUDur2asIL/2K2?=
 =?us-ascii?Q?JhqJx7g0NRxCDX9WdULPvfYB4OMl8+TW77K6rL1bT4AbW6hHagYsydTcBu44?=
 =?us-ascii?Q?8n1Nb6Sj6r54YrOO6Dh3RztBDX1f0wfhTm2/rv5XCx+tT7RzsDsDGG0GOmfo?=
 =?us-ascii?Q?8XuojgFNtY7ljK0VpIrlFKUb8aLsT4LdsAZBMZmwOZ5513yfwbIv7zYxUhnv?=
 =?us-ascii?Q?d/PQsX+DlgNEHeeZYOo2JWCwUwyp14YB0+cmv38/DRKextwqzPeBSkrPECMe?=
 =?us-ascii?Q?c4UldWf/cmPNzW4L5JZP1Ra0pay2my+oYSmIh66JndEm6EjmyZFcArIm5cdP?=
 =?us-ascii?Q?ta6DEHH/5Jy6LisJUO3p/AixsvdGoffSKKlwfxMkTimKmOnSBR5BIfpvd2Cy?=
 =?us-ascii?Q?SZuHmsSMXjcscQ0QIW6/tQwdbQGu+WaHQrJUmrrU9j/Cwmzx2lBjFy1pnieE?=
 =?us-ascii?Q?bjCMRY5QQYLP7NKCWDFQM4y0B+5F5MCPKgHf1jK7QFay8oRx83LsWv2d1meN?=
 =?us-ascii?Q?G0BT/WNWr5cQcfjar6GaK3b+HXGR5fHG2uDF/HxuYDRiAINHFedLOf4T/soC?=
 =?us-ascii?Q?LRBg8sXrnNHC/9fe4ILJWscyfQOLNx5m6YX6zIE9dPVTIkMUmyka0upE0f+g?=
 =?us-ascii?Q?ZShAbWLQeGXXjZHmR8owlskhHCPYpKK5ZBEcbcAVm8k8pE4zmBFcNh7eWtID?=
 =?us-ascii?Q?TfpXofVdwu7A3ceSuyqvGkhE6dxrCKjd/cQks6vQii3ybAymcybMNihCGGt5?=
 =?us-ascii?Q?4S2hRDre4lP1zMCEtAXDfSp3UIwGompMjibvgetDkKo3zg2DWoZST7fClQSw?=
 =?us-ascii?Q?HaUU8S5vPZJVn95PXqjQ5mApWZtq6FLKl3PRm7BF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00cf207-e0a3-4261-4462-08db218ab28c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 17:12:58.9686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEbvoug3rht2qmSSbdEKdyja5PMwlznxFZuVsmwaEWICYMe/DlzFnbpUa0VtBKOj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 04:48:27PM +0800, Longfang Liu wrote:
> +void vfio_vf_debugfs_init(struct vfio_device *vdev)
> +{
> +	struct device *dev = &vdev->device;
> +
> +	vdev->debug_root = debugfs_create_dir(dev_name(vdev->dev), vfio_debugfs_root);
> +
> +	debugfs_create_devm_seqfile(dev, "migration_state", vdev->debug_root,
> +				  vfio_vf_state_read);
> +}
> +EXPORT_SYMBOL_GPL(vfio_vf_debugfs_init);
> +
> +void vfio_vf_debugfs_exit(struct vfio_device *vdev)
> +{
> +	debugfs_remove_recursive(vdev->debug_root);
> +}
> +EXPORT_SYMBOL_GPL(vfio_vf_debugfs_exit);
> +
> +void  vfio_debugfs_create_root(void)
> +{
> +	vfio_debugfs_root = debugfs_create_dir("vfio", NULL);
> +}
> +EXPORT_SYMBOL_GPL(vfio_debugfs_create_root);
> +
> +void  vfio_debugfs_remove_root(void)
> +{
> +	debugfs_remove_recursive(vfio_debugfs_root);
> +	vfio_debugfs_root = NULL;
> +}
> +EXPORT_SYMBOL_GPL(vfio_debugfs_remove_root);

Why are these symbols exported?

Jason

