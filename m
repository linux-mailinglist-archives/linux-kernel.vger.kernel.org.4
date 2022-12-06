Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB828644FAE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLFXfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLFXfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:35:10 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76DC303E9;
        Tue,  6 Dec 2022 15:35:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SADianSLhIIKGQgAq8tsxg4ejnag5gzUqC258vZu1PL0TLtAK0u64BFY+lgWQfc0DJ2kAVaCVtdmSS+zsZn48SBYGNwduiFIurW1TTO1bogbA+NnHfdzFIp4MSGuvzEZ7cv1ggAr7Tgj0WAlgYYrfeeMuSm0MWIrAuInkHB4V3j/umeLdGhpKeHeZVTSIduU5JJW+V+ikdLSswsieil70Jdqe2K4ZTQjhYWSyw5tlAI11geFEJy2D/sQ5hzc7tXEpTNmhD/SK6bVFEy+iVAbEMs/8l98kqxcrcOzQgMduky8rRqsGbTSCWmdY9XOZcG4SV6ME7ViBuJCUWpynptsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8sF4vNR1/8jXwLgiiTkk4f9I67zBDx/m9hvLVTW3wQ=;
 b=UN027uPVRhc1uiKLcAX8Utl6bJybuaLKk1kEvQUd/9GqWcLFS9eoSSWaH/PYvXPbSFLcxyfQyGUNf3ifUfHxxBMdE2bUQtEztW11aiGwDmSVLWprvlNddmXpMDcT92TznQAZF4h2QWruXpnzGIvlKie3zzzjw9JAes0F2Btavk+zMmirPu0f5B6zVQIyzHPWb8qU+7sVhUxuoUchpRekAYRK+LphdVtkCAgaBqLKpO67lqAeDkuVn1AVs1j5yzkEuiajP64OwCORr1xBO7DfqeZ4+LRYKJxbFUiafh+f24Hprky/PA8YMHEIypANf44dIgH4TPfWo3nk9ntstkxWng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8sF4vNR1/8jXwLgiiTkk4f9I67zBDx/m9hvLVTW3wQ=;
 b=JPhC7rDewWo4jRoiaEdmQM++ey1g9yOcXMFLNzXWEcnSuRx72Bz1lJb3oD/SKn+lKbv4egXn5xAeDwFET+sNDHkdJIx2BHGfXgPt47Extfdlw9vR1r8jpvt7mmzWzjbtNEGTfYMxbeEFwn8NUJ4d2aY63mifH4o0EeWvUtHuF9PFd62bUFJAj9G6U7b5Qx6vF0jORfeRehaUQGrbNtfm3ubeo27OUzc+4ncvZ6fZXX29QBDI0u6k+0ny+xfU/UyI7KC7ezQ4TsUgHFYEb9h+PkOcslYPR2GInaWwQriIM5FVVNh6tQ0VjZuU0ROSw7S+akiEQ02nihSjEWND4zMIxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Tue, 6 Dec 2022 23:35:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 23:35:08 +0000
Date:   Tue, 6 Dec 2022 19:35:06 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yi Liu <yi.l.liu@intel.com>
Subject: Re: linux-next: manual merge of the iommufd tree with the vfio tree
Message-ID: <Y4/RqtFMCobuOL8J@nvidia.com>
References: <20221206125542.52ea97a7@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206125542.52ea97a7@canb.auug.org.au>
X-ClientProxiedBy: BL0PR02CA0117.namprd02.prod.outlook.com
 (2603:10b6:208:35::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 2417816a-1dba-453f-f0fa-08dad7e28282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sh5wKCaMH1rta8vpT5z/uKOw0KJbfPFjsef5bJY7yAlvoSbOMksAv5EARAbcUAksl+l9uWkQq7m1yZFJrOUyQiG0yjRNr9KFr+FQdAfkev5GDBwPLRoFyNDM1cnacZCBHpMDp+EpEr7q7R7+Bx4kRSPiuJiz7ifuVusVxpomxBFuawhRgxzYzVyqHw49pH5ID60cfbFqIxXzJa8EmUCpkEo6v49wKtB7pvjWCRmIxMrMIXB/YupDZjC/jsqbbn39iUIXWz4Dr/AKIBvPVNR1jOdCAFGA9mbTwWOO2tJkcAgD/oK/Gl/erKo/clpzVzuY8zt/nR5HzgAIfwxvASHKiQkQcactZ9Lkixpf2IwzV+hiInnYwuFGovgsSEo4lW0f9nPg6kHhERCAaITqSno86zqnaVT4YPtmVfZ3cForXueafjquj3x3DCb1wHf76RmaunWxXZCGYRS6nK1c8vdCJEuAT5zZTATXy2ovBfxb7wW0WOLIWuDR5mIJh0p6V8XFgcqV71eUbfw7Hd69jHGhBXpAD/gwWnEZgAgdAyXdh28ilA00qBpB1kAngmc0loEs57PInR8XV95Ylp/HVFWqQQynVokqJfZeqG8oqD3rWexRlmau4tocYWZ9HDQVWi8kv+/JLvtLCtCUCm3N44ZFXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199015)(2906002)(66946007)(83380400001)(8936002)(8676002)(4326008)(36756003)(66556008)(5660300002)(66476007)(316002)(54906003)(41300700001)(86362001)(6916009)(6486002)(478600001)(6506007)(26005)(6512007)(186003)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UL/uuArNvccwZUpe2/ZLkyz36Z+gvB9hPfp9Zh9mvspUZDvmwsrcNithq8Pr?=
 =?us-ascii?Q?P3JiiglA4cEIuD1xxqc3+2sZSgjiIQ2CrkMaH2vq+3PinNzbKRpys93JTLi5?=
 =?us-ascii?Q?POSKgWD/hGlbjdDgW+auRX6QOIAhDbrsI9BIVctqW7kI5dbFeVpa4aP0dXYz?=
 =?us-ascii?Q?GE5uljjUbcz7NA8fozqKsvCEwLNSGtN4i0tm7b23sssCOxlvuVG3ZjnxeFs5?=
 =?us-ascii?Q?wmpodipIePEM6Dhu8XPQlEWXMwbnDYteTCeowzt1uXXB7q1HQpZhVn0OCHUQ?=
 =?us-ascii?Q?J3AX/ne4eYBMxHZwFqrAQUfZsD9+qvtQNY2ywTI3wb9hLlgbuUJOxDDXyPmV?=
 =?us-ascii?Q?0h5vIxFVX9VhJLXQlT4JtLPVhgWzX5xPzMAHzJu5YHX2wM9eLS7a2Wz2eGvP?=
 =?us-ascii?Q?WvdQEIyeoYTb7XIsiC22naXjJrUUS626FvVystKVji7/U+UVDjRB8B3H6qIi?=
 =?us-ascii?Q?z0YTplh/mvrPME3GfV7zC0zQG2y8pJX70nESTbr96WEmV1uA5E0LRe3vmD1S?=
 =?us-ascii?Q?xNn8hKCe9n+HFITMr8kHH7eQXt9F5zrKrSG0Z3kcoRZOZ9Avn10nbMnCeRGE?=
 =?us-ascii?Q?ebPn3y6mLaieZM30yKLIRVDfk8hZ6AKeDjSwSXor+abpionJ8arWJBKiqs5W?=
 =?us-ascii?Q?s7zp4b+WlE1XNOHUw9boVVjuF00d/Sz6hhpp+Y7kWCJO6avUMqKei0LtgIN8?=
 =?us-ascii?Q?+4HeBR6IDNaENtiMpqeWoOZhflldkieQWEOBIaQYyrGvnbdetZznAYRapdsW?=
 =?us-ascii?Q?7qLT+zmgj4OefL3J4DAkYhKz46lXdwStvk/jx5luaZj5j5dOzjDNu7SI2Kcy?=
 =?us-ascii?Q?Ts4K6Pg9Ojb+k0ueLtC+o7Ka16keWcR4v0eInzR9K2APaw8q0uXlmIXujLpG?=
 =?us-ascii?Q?c674Yn9SE1uh8qnMS2rWS76krVJORpTvo/EePMtAvRuqxhzziqNxUKxEvRzQ?=
 =?us-ascii?Q?wFFEU/ZJm8nnGP9SjhuPDjAt1/HA0Z3EVK5E9w2YEzQVDtkn2zqkR1R9l+JN?=
 =?us-ascii?Q?4Opxo3hD5sHyl2YymnXTDFpVxD/sY70lExC8IwN7WP8YrVI7z6p8GSi497Jl?=
 =?us-ascii?Q?m2c1y32Bg7AOW5VaoIuBLgSffZWSh8CN4qm0NE2Zp60yp7dlxw/OJ2iYZZjk?=
 =?us-ascii?Q?Lp4JPW7g38mibX3zHUFco6+PaPvCi0HKSNgj6PCXCV1FPH9pJlccvirv28bs?=
 =?us-ascii?Q?cxE7p3DhBszwSXo0HSe1mFeYucIQJ6mdNIGIrCB5p+pRLrugqNaP52cyvOIk?=
 =?us-ascii?Q?nLp9CezJyV1T9UX8Kd3QBaM/PdwcOfFQECRJva4tpnvJgc5WuXuW+536iCoO?=
 =?us-ascii?Q?hLApaM4GywHXYZtRAx9xcMhpIvDxf6NStUB8JikrfIAard/BZU3xKvaZKgMr?=
 =?us-ascii?Q?8ub4rQjt6F53XyInNZiPoxeLkoFVyjBaMe0cOLSN+f1WQ7rRa96+mZHDTKN1?=
 =?us-ascii?Q?u7FYdsh70VKgj7v6AYt8LIgksdjJf2gzw60B6mdylxpSQobwOpI3l7PObBRK?=
 =?us-ascii?Q?eeOD9O3DcPys50klG8hp6kX3CGKmHuzn/iJXJdHxdTbxuKtgQUAOCODn2eP6?=
 =?us-ascii?Q?/ASlxUwSu8RntUzkopk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2417816a-1dba-453f-f0fa-08dad7e28282
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 23:35:07.9952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eSDicNTD1zfhdlfp//4h22E+RjX7OeiJ2dlS24ZJH8A3ZdCVbtvVbr0vjjl6KSx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 12:55:42PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the iommufd tree got conflicts in:
> 
>   drivers/vfio/Kconfig
>   drivers/vfio/Makefile
> 
> between commits:
> 
>   20601c45a0fa ("vfio: Remove CONFIG_VFIO_SPAPR_EEH")
>   e2d55709398e ("vfio: Fold vfio_virqfd.ko into vfio.ko")
> 
> from the vfio tree and commits:
> 
>   a4d1f91db502 ("vfio-iommufd: Support iommufd for physical VFIO devices")
>   e5a9ec7e096a ("vfio: Make vfio_container optionally compiled")
>   c2849d718d26 ("vfio: Move vfio group specific code into group.c")
> 
> from the iommufd tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

I got the same as you for what you showed, but I also got a hunk in
vfio_main.c as well? It looks close to your next-20221206 tag, but I
renamed 'err_virqfd' to 'err_group' and 'err_dev_class' to
'err_virqfd' for consistency with the rest of the file.

Thanks,
Jason

@@@ -1260,27 -1902,59 +1348,34 @@@ static int __init vfio_init(void
        if (ret)
                return ret;
  
+       ret = vfio_virqfd_init();
+       if (ret)
 -              goto err_virqfd;
 -
 -      /* /dev/vfio/$GROUP */
 -      vfio.class = class_create(THIS_MODULE, "vfio");
 -      if (IS_ERR(vfio.class)) {
 -              ret = PTR_ERR(vfio.class);
 -              goto err_group_class;
 -      }
 -
 -      vfio.class->devnode = vfio_devnode;
++              goto err_group;
+ 
        /* /sys/class/vfio-dev/vfioX */
        vfio.device_class = class_create(THIS_MODULE, "vfio-dev");
        if (IS_ERR(vfio.device_class)) {
                ret = PTR_ERR(vfio.device_class);
--              goto err_dev_class;
++              goto err_virqfd;
        }
  
 -      ret = alloc_chrdev_region(&vfio.group_devt, 0, MINORMASK + 1, "vfio");
 -      if (ret)
 -              goto err_alloc_chrdev;
 -
        pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
        return 0;
  
 -err_alloc_chrdev:
 -      class_destroy(vfio.device_class);
 -      vfio.device_class = NULL;
--err_dev_class:
 -      class_destroy(vfio.class);
 -      vfio.class = NULL;
 -err_group_class:
 -      vfio_virqfd_exit();
+ err_virqfd:
 -      vfio_container_cleanup();
++      vfio_virqfd_exit();
++err_group:
 +      vfio_group_cleanup();
        return ret;
  }
  
  static void __exit vfio_cleanup(void)
  {
 -      WARN_ON(!list_empty(&vfio.group_list));
 -
        ida_destroy(&vfio.device_ida);
 -      ida_destroy(&vfio.group_ida);
 -      unregister_chrdev_region(vfio.group_devt, MINORMASK + 1);
        class_destroy(vfio.device_class);
        vfio.device_class = NULL;
 -      class_destroy(vfio.class);
+       vfio_virqfd_exit();
 -      vfio_container_cleanup();
 -      vfio.class = NULL;
 +      vfio_group_cleanup();
        xa_destroy(&vfio_device_set_xa);
  }
  
 


