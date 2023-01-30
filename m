Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22DF68181C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbjA3SAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbjA3SAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:00:15 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E760D3BDB3;
        Mon, 30 Jan 2023 10:00:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLh+1frfzVCTHyPa21sh+Zn/+HY8igZQbP87N2ry4VlvyoZySOLpGM8/G5nyGE8ybkDV2Z9vm+Eyek6PJ4g1tX3by/mlFPyslPS890kdQyR3qv4o3G6LCkvBwqg5jznuNd4lfcb4BxqT3UDqOBbwaYx4NGrmISQaQxhGrZeTVXYNKmavFij5ukTJZhsitMzQWKM6iOsZ2Tf90UUvIdEOh9/8tY3tKLGcAR9KQ4w1H0/DUTCnL+26r6pbxedo7KuYcYQqzgQ2Sq1HCCTVqVCiy5wN8MCASwsfoBTEYppgwGe4DrwjGJOhpK1Bkc3RSSXo9Uo8eE/S/la//8+XRB8QUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oBU5fFJBWFkQW7cEASKb+LgIB5RX8EQ2PhAJV7Vhwk=;
 b=U6Z6bgU0nzJFkaJvyNV6lFTkil5G30+bGa9k1vfqFbmHgsRbqskQtwSBE684xfGcdeH4ZaZIpLrBv3DMKXr7djR4Maa7qvRugZH5eZB4rDQPO7wyaUNHvGZzR9EGOIWQ2nl42sIm2ZIpgAy2svB/6HAnx/UQrtte4NhWHene13/x0pTPIUNc8vEhZgJ1dixxMPKn3x6h1lsw8N/em4Qk9ahGrjvsPzxVZDlU4UMNtX+ehVcGPfrn2XsW+0ZJr7Z5WEsYvczc+wsXG6orASIIyMzTDrcof6GCEZ8m8TnOUtImQmY3C7CbwgqCpF4dgVe7jeXuhuFd4frDttcO/7QlPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oBU5fFJBWFkQW7cEASKb+LgIB5RX8EQ2PhAJV7Vhwk=;
 b=iItwgSehJ59SHQrt9PEQ76IWwtZOAYOGUvytG6Y8EGGOLGpPdgAlYvF+RiRofO/PaGLJUWgzUmIjbJeUcS3PFqS5dQlWgv5lO/NwoyqJNb3pB5Vk5bXJ8859TgQKdMetFx6nIshlL2wAVkYyPGy2Rt+fY7PJA0+047YjFppEDBwzxuQbIU3JIzCvOXw0Sn7bHHBqx6/nwhtSpTF9mGvNRtL3tBcj4tO+Xp9EMdoTKXzHLJiWx/IQU8cBLjbuWoC4b8GuzJBEnx1wgHCosf3yCQUYbLRZVrYszNgG83ViEaYPlnCO5jtzh/uHZoXKEHNwp54lKWIKoZ/YWRxVKHUjUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5303.namprd12.prod.outlook.com (2603:10b6:208:317::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 18:00:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 18:00:13 +0000
Date:   Mon, 30 Jan 2023 14:00:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: linux-next: manual merge of the iommu tree with Linus' tree
Message-ID: <Y9gFqyDctgECQnSQ@nvidia.com>
References: <20230127141330.28b2c653@canb.auug.org.au>
 <Y9eEjCsWUWeFccGd@suse.de>
 <20230130105549.70044a51.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130105549.70044a51.alex.williamson@redhat.com>
X-ClientProxiedBy: BL0PR02CA0080.namprd02.prod.outlook.com
 (2603:10b6:208:51::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: 22146114-2e0a-4e72-5e14-08db02ebd5ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYJooqtqtWbl/5XPVgUG4BxrJSr0k2igoamumiShxZ0DUuoXNJu5vz/iotfOL4IJADCyBz63guRPcZFT+LA2354okgJUFbqGtCUEA10JQS5nP+/qVxISomlk5pnx5d+EOdO6ozJpraWmkkEvkxCH/TyNVjROZZR0wPEUJUPilPIuv0hcKfaFCRr3DeDA2akG5q6OGX4uxVDml7EcA4gJ4eZLlgHY0/B3/UC6GtpqqeIOon89fkl4FYgEtkI6XUHGlva11NR2HJE9znBOLhseDOxT5dEL9ibIBxPei1BoafpAIz45wWrI6Z4bpFTX3+CEhl8lFf/ShRdFS0OV9pixaFOlpA6WiqVIflu4/qe0wbAeU9aSCDxu3S11SW/JxP5EGNRUdblOt0EcFpNbZ1tATN3CQPC5v3ur7e8LUe3p4C/tu8PF7FGS2fQzZ7bcIG9QfDhNoMAUk9phxqxEHJbRxe/LkI5m9F8nv4PJSr3AIEjEfk2GuPOI9kj3BSf/qpsSDmq/nLW/LP/Q7GVcbKph82IHm1QYyj3rlRuh4/xbGIYWuNkOXqMq7hgk5BIalqFN/ZZGDf5f0rR5uCegSENMI16DQu2EB/ZzKfTctZ/kfToNy0yG+4EZ3A+snumSoLtmh8iPZkB96pK4qCj9q2+I11E2t9Llezk5A6XJBk17w1AGIU7jXzuC8DSVtE6x7H5SZX1hkM6PsCywZrgbEJTy6pox6h3ATy+kE04gTkARLDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199018)(86362001)(38100700002)(36756003)(316002)(5660300002)(8936002)(66946007)(66476007)(54906003)(6916009)(8676002)(66556008)(4326008)(2906002)(41300700001)(2616005)(83380400001)(6486002)(478600001)(26005)(6506007)(186003)(6512007)(966005)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yUq9U6WpfixgNcTvn9YWYJD/XMUYU17e0IGEhhq8Y2X4VXs9MoHBkroCL3Nx?=
 =?us-ascii?Q?78BM8TBYma5WDe8O/cnquPWzBKBQMPL1phDEByNqQhKd431/eJLqaxglpbvn?=
 =?us-ascii?Q?8vie/Cc+2GR/gMDuLa5GorSW+d+ZY960i+E3ixqWaO7D4g+YfDO3riBCdGHd?=
 =?us-ascii?Q?rtgfw6/PjNP39gUq5AaDdimQwficL+ofD1GQgC6djYSHgBOgXnQrNKnN0I/R?=
 =?us-ascii?Q?vtAivBga6y+C+hYzqI42Z/nd/rv0nyYHlPwY5Fo05oko411aciWsyyDDPkpi?=
 =?us-ascii?Q?NLnmTNHSY3PR39eQYjEWgiS572oZXjQUX69HZjYP2P1UHRhG7H4nTJUJr9R/?=
 =?us-ascii?Q?Gvre+DJIa/hK4Tah2mDsAaME5fAxOuSSPYTvoQt+edmtpDUtSJgQ6814AIKn?=
 =?us-ascii?Q?25bt9UwK9SGdkSU8tOHA6MgOUhhzQYzgxC1dxssGBEUqjP4ATxKFeBHTwY6D?=
 =?us-ascii?Q?0QN77k/RxuMT083Lb7AwriorUsVnlCmeahQL3qI082Id02jHkK5jCu1rX0Y/?=
 =?us-ascii?Q?+ZK1n+Px7cBslN45oqJ54Tcd0ti4h0Jodz5PrZRSZOqfAONrEo2XWPOP+j+w?=
 =?us-ascii?Q?Cv8emKx2fvIyMcQ8Kb5cZkdeV5RzffIIBmsXEpwG3wcbTj4sM6qKPgavoVVk?=
 =?us-ascii?Q?GLekkstdfoIYwkiiwt5OuHKS+TcK+7oi0hcExyBS5e2i4IkzcEGXmcDBRV5e?=
 =?us-ascii?Q?l3qd6AjPPje4sCii069AIv/qwuDFH9tMLHD+81W+C4bxpCsBeC+ss0OtGxaf?=
 =?us-ascii?Q?o2FGqXbTv6XmPk1XQzFxso8nbNJzqMnIUcBj06pPnWjdJphM0N5AELH565PR?=
 =?us-ascii?Q?bA/zhnkAk6RgqDFgKQr1SuLH269KNEHPlqZmxIsfRW7V3uDcXnNmc31iiE2N?=
 =?us-ascii?Q?Fxmq1R5MbuzcUlBI5jVPNDsCWfnRBcvSC9wAVuCwUX+ltpch43H7pRQrioM7?=
 =?us-ascii?Q?DymMW08EapCJmoG5dI7Q98GHizBT+i/VmX2OelEHrqtxj4nxXrETz2kHdBi1?=
 =?us-ascii?Q?6EDvHkDf/vpjX9EnOdpKA+9cf9QVdcKw8vH2CceLZRcT3+NFixDHqfchtnJL?=
 =?us-ascii?Q?VPBR3GBGY7Q7BQELVlOtzM4OrUoq0usQ0xN0p/Jhu/mZulbvrCE6Dw6LKZ8w?=
 =?us-ascii?Q?x5Oc085ltE3WMV8IqOysDTxpJuqzrw0uLxyXXoNN4OfsI8Lnagpyy9cWZNpk?=
 =?us-ascii?Q?3N2aGnCYmy+Nmq30soCHGPBGqE3v1Cpg1Zb20BRjAOH+vLmJ1A1G8DpRDftf?=
 =?us-ascii?Q?/1wF9NpLYFEo6rLWqEJhRlvF8s142GOEVnuu6fEO4GAZh6H5cFbBlyZZ/85k?=
 =?us-ascii?Q?68iy9q2G/fKOi7IzzGz/5kEr1Tp9rP0K7QiWpoZg4uFRvj0lmUcly8r49WQh?=
 =?us-ascii?Q?MMNd9QbHxEoKdwAQKsnO9t8Er9ZXXjVp29Udizs7Z/6oeQPozu1QUEA01gBc?=
 =?us-ascii?Q?USWFW5B4Hp2tXYgBnsF+assA8ZLp0A5WT/+6ZZHzhpIxJBgLHBBNRGjKmb6i?=
 =?us-ascii?Q?z6ohHHkw/WlTaH6Mya/nvRynkjuat3dm7uqXVY9sm2hmtUgIyqH0sLYzsPWt?=
 =?us-ascii?Q?uQ3BpW/g0LV6KqF3S8uEz/LoOeQ9gyBnEZ//UZGP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22146114-2e0a-4e72-5e14-08db02ebd5ba
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 18:00:13.0794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCcU90qoy6kTXDRw6ftVMuADxRGMJIlFXs8AMoA8KuWZ3x3J8ljtQCFlHLly2IKh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5303
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 10:55:49AM -0700, Alex Williamson wrote:
> On Mon, 30 Jan 2023 09:49:16 +0100
> Joerg Roedel <jroedel@suse.de> wrote:
> 
> > Thanks for the report, Stephen.
> > 
> > Alex,
> > 
> > On Fri, Jan 27, 2023 at 02:13:30PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Today's linux-next merge of the iommu tree got a conflict in:
> > > 
> > >   drivers/vfio/vfio_iommu_type1.c
> > > 
> > > between commit:
> > > 
> > >   895c0747f726 ("vfio/type1: Respect IOMMU reserved regions in vfio_test_domain_fgsp()")
> > > 
> > > from Linus' tree and commit:
> > > 
> > >   1369459b2e21 ("iommu: Add a gfp parameter to iommu_map()")
> > > 
> > > from the iommu tree.  
> > 
> > In case you want to fix this up in your tree, the patch-set causing this
> > is in a separate branch in the IOMMU tree which you can merge into your
> > tree:
> > 
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git iommu-memory-accounting
> 
> Hi Joerg,
> 
> The conflict is with mainline, not my next branch.  The commit above
> went in as a fix for v6.2.  Thanks,

I usually sort out conflicts against the rc series when I send a PR, I
pulled Joerg's branch so I can deal with these conflicts, they are
trivial enough

There will be another -rc conflict from rdma as well:

https://lore.kernel.org/r/20230129093757.637354-1-yangyingliang@huawei.com

Jason
