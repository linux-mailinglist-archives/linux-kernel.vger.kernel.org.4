Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED17672116
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjARPVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjARPUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:20:46 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8184AA6B;
        Wed, 18 Jan 2023 07:17:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7EQ4fo+wcbimaD0oU/c3SXzYfJIgrlIK/KhP/qdxBgCy5u3mD9dFS/6BcUHqh+j99JJUSrY75PdlLEM/Gcfm6gIcTRxPLUbQa1xYmz32TYgRNJR4o6sP6Qk9sHUjvETMsx7cW7+O5zZ68+y4WDDnRYecbs4QR2ZfErbBZTvU9PDEpOCxQ5cPTd9R6rIFOr0xRrColcs2Ti3uDlFjQGnWhHcB69CfdaqFM79BBccQAPaRuGDBgnXPc+msvZQMCcoPSXkxXM5FOd5a8zw9T58eyJpmWbv/ci34TKGw5zubFmEQkglqmjR09rrX7BpdbzGSzQiJ3OKgjjwDOVQ53ha+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8s3L++PBOTwApdjhy5l6mZCyt+9lIZPoeFbT/cb49BE=;
 b=hkr1+QDVbm7Ctge+1Fo7+s8b7/n2R34S6C6zZnCpHj68MtbSzGq4d6QVDV7gDaDzpbVIASNWmc/qlK5pi5KNvcPqMVM5h/3VfZbNp4mHZ4k8YPXMw2Y0GFtRaKmYf2uPYt02qrNq8dtFJ1tG51p2CbQeKmIWnuj8U9uxVjZG9Tx96qRGXkJU89yagBiN5k1tJwhlc7jpaoJgFTdhtZcwC3hUpo06fyimwQtnwRLCZLtAB0IHvXVOg0DGz2/PpS8WEGCY3l5tOaonV3kwQ1+YvQYDfUHYAaG1xPmx5IRH+ejrRr5g4CLsd9ErM55Z2FBBY34599wwiWCt4DF86sMIDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8s3L++PBOTwApdjhy5l6mZCyt+9lIZPoeFbT/cb49BE=;
 b=bJUf7gtW5BVh5hSnlA8bEWn49+NGDd7aGqDmSyoBaTF6yreVBlJ40HYotBJQnbMhlN7eLv4OkpbZZdE5A8cnixSPjABXshu0g9hqeGe64XWS9tpY/gLJDYey+mHNstlPuCHdHcEJ62Q2McLCxqgIkQ/0sYTmKiKzSaagUDmMOR0LuxYskaqUDBWIdK4SEDFIy7cTmcT0ghCT14YLHhP4BAKnndXnD6v0r7vyOBAHI9my60UAhJDysV6/BjTJQIlQvY3z1q/qSQ3pNLqu4oVt1pVrIxWRBMI9ypHeSKLo2prjwPghS7I1nSzsmlyVvJNS++OASOYDxhLwqLq37F7SjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 15:17:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 15:17:16 +0000
Date:   Wed, 18 Jan 2023 11:17:15 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the rdma-fixes
 tree
Message-ID: <Y8gNe6Y3QbLtYNXD@nvidia.com>
References: <20230118080424.03c542f9@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118080424.03c542f9@canb.auug.org.au>
X-ClientProxiedBy: BL0PR02CA0100.namprd02.prod.outlook.com
 (2603:10b6:208:51::41) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: bb404788-8887-4055-8238-08daf96715a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aCvAzKxZ/iYDBHAdmv+FqHfAUOE7bKiX/3YsaMhTAcd9ZeWSxXuXatCkAierxbyG0ycVJv/Qv9IGV6UWTshavdkOlHcEq4XMPmMl7k+jZUVjLMKTbRm1uCd/eyaEyHnlz+hbl5t5CYyzShiHrsUJKu6xRGQ9XqyTG/9x/ezTDnVKGdEKbMD+noLWcnzrHPUkm7yf50YlLfXDWseS7ZMVKGnfZEk02zR+SgkQik1J6oo5qZb+hMBH0PuPSVR1EcSb2MaZ3XREHFHejXA1oPkDJBDIWjm0BDWjewALU+eOACRDDyAFUegKR6K8JsLjL6L7759T5RO4gQzezSrSlUu4d6AstXfvv8woxPumzoWPcyo3F7obsnmVHOnin5xBnjaX8WAQAEYO+vmabhg9kfE5qW18QwkO5sCo3EL6r/a53KD8neSC7SVZSGXJkEVlKzzu0njlEqCa2yTU+bJTyt3yHKrGkfnoDtfBW9ua4e8uAGCC2JcRlMhYwck7WutGLMoqPlrb0YioMwNkiN9+Eolbj0UNU42Fjzq9OKlQbwSysCAzXWK99XXRNFqAa0Gxsr2V9YxR22hSZ08lk6WlIGFPrAirgaXbx+SGIdilsiosjiqnI3slEAG1duhIZi37fZi7hPAZf+qawe/hIXucPk6cfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199015)(38100700002)(558084003)(86362001)(2616005)(54906003)(8676002)(66946007)(26005)(478600001)(66476007)(6486002)(186003)(316002)(6512007)(6506007)(66556008)(36756003)(4326008)(41300700001)(8936002)(6916009)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6VKq9B5mMPENhJOq8x7nHdwOaOQr1AyHwqm+OQeW33XLSkiJh8jPDFNCVy7d?=
 =?us-ascii?Q?4z85RgIk7q42es6/ItnfAueRWbhM1xr2V8aokSNjdY4oUWvoxro1tvYh/xau?=
 =?us-ascii?Q?E3lnNN51+tHQNoANggojFqTl1JMmqUGECcMP/cfF7jJmLx1Pxqq2coEgqygX?=
 =?us-ascii?Q?wqLZ/t9ODvyKfz7LThEM6/m7Z/fTWlalM6kEbQ8EdzetwvJqIrNRbQ58eniM?=
 =?us-ascii?Q?BC1fUDO1T+B8uM8pl4gAalG3ZFrEZB42kaXlrFntIrcMWm9Z0EYv89imReOQ?=
 =?us-ascii?Q?FTwul1XPMc2plsnZBT4VO2iUk23wJEzulARU1q1bdlZ6U+J2HBg2QURvaoNW?=
 =?us-ascii?Q?Nu+eq1o7Lz98SJy8xvt9fjwVcAv77J9MxBPKfmPBrmPv53torzXVulC7g7aD?=
 =?us-ascii?Q?tCkH2LC/jRxVTQx1R/sh7FOCxSKdyoHEO6x+KiR0AYo9YfyAfQ02Omstf4W0?=
 =?us-ascii?Q?w8OUv8dBT8/g4uVuHNELy0MVb9a5GC5jWWrKME7AUxBPXw/LFuCQJfbw+c6R?=
 =?us-ascii?Q?8qJJTxkLs7FR47Tv2fNJIm1fPRDQhWijvrCyGiZBeI1OOR9/0lsY1NHZKxMg?=
 =?us-ascii?Q?UaPK9f/ntG/odNVRiIU8d8AGYKSGt1kjzRGHj2Or3H6UOQ7tPu+xKi9hbMJF?=
 =?us-ascii?Q?JVwQ1l7bQw9Cmhg7xrQIb13aeyrgfDyMQoucUj8dT/dOc6kpQIDuCf2+LWnV?=
 =?us-ascii?Q?f/QOOx34Vo9z31iGNHm/16gJgQHeBEHhN9PSl2AhJzBrOJ9z3RuGghpGYFCR?=
 =?us-ascii?Q?2WEkdHBRf1ZPfy5DJ3Hc5IBb3BchY+/u64jARTksHkmGC9/9+6vkjSMFtYlX?=
 =?us-ascii?Q?OlTjAnjKuyzSthkxrvvxEh11fqfbx8x0mHk6IePFIVhYj0wR0yCipeZfMwdT?=
 =?us-ascii?Q?OvMhyHIrzSP5HqNC1dYbrtPVE6MrZ7Ps1wIXgE62xGmWGRVP4bJu8HiFRWZx?=
 =?us-ascii?Q?5CmAEXFBaOuK03tv/CrFuNj3+tuMJ8EIHeYCFaOC10X4JgUdeECwKQP9uInL?=
 =?us-ascii?Q?ZlKi2DzrMg0RRiSc6YE07i/8nNNn9YK8pIhF42AeaG8KAzR8qecQYj6zllUX?=
 =?us-ascii?Q?Aj81noJONEId/0aV3m6UZkVXtMcJevNxESQ+vANiU6aWJjCQ3MrdczNBYaQg?=
 =?us-ascii?Q?qE4iVMjsqWL1NaLVCGgw3juf7IQNtWcu+FrBxExwoXOY3zrtBxJ31T/h80B2?=
 =?us-ascii?Q?OOAWARdbBy/OccHYhplQrTV4fXLcA9ya4pZHflozJVnYe15ieSC+DRvTYEf7?=
 =?us-ascii?Q?ieH5pocujRQo/VXQcnleqWNcqjHuVXeBlQybinhoyMTtvA+RS59OlHjlIM5M?=
 =?us-ascii?Q?ucef/IwEWrohVDeaW1TdBwKEbWziZXg5ra179cddYKqbYmMItKJlEQxqvhzV?=
 =?us-ascii?Q?TVG0sziH2NUhrSWcP9SyJ/4xlh757PWSBk4vhd5xRRDRVoAG4soixoMamOs6?=
 =?us-ascii?Q?zRYBXLRAgqbpPQv/DtPOXU2DY9h1We9BlPQNXbSZY4tF4syhsHAGvk3dADdw?=
 =?us-ascii?Q?T3kY1VLqhh27WGdU0G6nPRQSktZajkTKVPUWGtMIpJPHjhIkDMeThzLL/rG/?=
 =?us-ascii?Q?328KZsdCbZS+wQYNZNScw7xakRBNSesOmfowrHtl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb404788-8887-4055-8238-08daf96715a3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 15:17:16.7737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/jaRjUez1Zy+T64MKQe+EoFvM9X2S0n+claM8W7h8Hw/B1+Be/ClP6vX+8ROGCK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 08:04:24AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   41f4a67e6d24 ("lib/scatterlist: Fix to calculate the last_pg properly")
> 
> is missing a Signed-off-by from its committer.

Oops, I tried using b4 for this patch and it got missed, I fixed it

Thanks,
Jason

