Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C146C2410
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCTVqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCTVqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:46:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7892F04C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:46:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADONF8biNquDtUB8ANBPPrZr1pVc85aKHpLNE6pW4kmqdUdKuVRCtnQpmiUoW20zTdoPWwHPA8w1ahkVyd67JRXJ+q1mm842YERbbI3NEBvqD4/2viSaK4sPFnZGoRR5G4kpE+FkLuAEjPLTRnZGWr0mM3+OmvfH7B9UOpvWfV7u7QL0Bu3aD97+rQYjtAeXO8HKM3DVA/rSUg9nnwxNtHc2NeURtYdIaJxN9JQw+QhuuQS/UB4fHny0Gf5p8fKo4dciqPFqdgmZjCp2yGNQQ9bjTptDmI9PbJd9zszzME9OmRUNyS/mJDIq68wWWB/Wmif7WCuu/vpsEGsWjrJt/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iX0ZYGjrchsa8LgVWpBur8V6TPtTVBcEmf0XFFV0OT8=;
 b=Vemo6HcI3uKJoJBVYSrrlQlDLS7ZOnfAxiOonWBQVBRNe1HGHcF/BBhLhtq8yqfZfHWh4NCiMBOLrM3Hb9QB8kceydzP7CJit0yvYrxcHc82vMv7t7yxONQp8DEWtP9HYuj+ye00z1TFS2Z0azXLVZmr0WsVBuG6OXksPvouA20qlop8cU8e5hpPfnog6QRBeRV4J2jhoLXu3or6xQMmpOkjvHSnY7zXVzsFRAmlAq0Ad+ikl7mmQXVv9w9xXvzz7Fv7491H04lmiSDic/PIs0WVTFAsVXJ8p75zzf4EqDGOLwkOOLC+Dxl/v9HSwAhhVxZBjQn2qvYMXsvP3eBHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iX0ZYGjrchsa8LgVWpBur8V6TPtTVBcEmf0XFFV0OT8=;
 b=M4LPXg47NT7qNTbcbv1yB7jp/2yQOeF8eYaSdXjOFpPKa3Psfxp33OFdD6wp81omadkm111dnAzKcan3d7yLCkVGJSN+t0ErQEMVQ48SAu9senx38yNbHP8WnqwHASu8f8arDnIsS1qGOvanPBj1o7WtVpsQvFMlSyfy/LLEhJ9AAD89S+5ZhVDjrxYXwm9kMVfrXwlONGmQ+AROwKD0QEfaq5+C3FGPmOaWxNXFLsbsOAT/hcTryW3BjSe3vNJ1F+R8pNk1QvU/6cJ4B8qeLrE8J0pTviPClehNWL5LlzGetQKNXc2Sg0w/SAvHYxrC3GLp7Vqt+z54ml3iYZmf/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 21:42:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 21:42:56 +0000
Date:   Mon, 20 Mar 2023 18:42:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Longfang Liu <liulongfang@huawei.com>,
        shameerali.kolothum.thodi@huawei.com, jonathan.cameron@huawei.com,
        cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH v9 1/5] vfio/migration: Add debugfs to live migration
 driver
Message-ID: <ZBjTXwZQs603zHy3@nvidia.com>
References: <20230320092338.2889-1-liulongfang@huawei.com>
 <20230320092338.2889-2-liulongfang@huawei.com>
 <20230320153336.74b853c7.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320153336.74b853c7.alex.williamson@redhat.com>
X-ClientProxiedBy: MN2PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:208:120::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 399b3f3c-2dc7-4dd3-ab38-08db298c1125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M1g+PUN9VyjRQyIBGtnj6+W0C5YCgSxtFDAwAKa+nDQHUuw9oMaiA3OfQkc2bD3msMYgym7zvPU1skFP3cdmISSSyIxFyUteKLkMMJiys11dfIGbsIex6O3J1c5kfQPDPi3S+tBv2k50AN+EgkCYkcNwDLGvDAYNTeFNDCZOzc2YiD56GtylopQRFj19R8dmgwvqfWvl1FbzLO3i9X00jeqhI+Mmcop/jxlJct8jgu1dCpOje6uGH8dvPdDZBMxGIowEjNEffSF6FvFzsem9VZCmpGHo5ym71QVp732wBvRiIHau8Q+H+OV6NzqZOOAAQvYS39WLN3n4x5UPR+QbiHCiDPV5hJ357YpstC6ALl/35243vAa6rZky8Bzzv7R9fz1AuyrVwujANbd23fyHL9uR+qWtY+Bytw/nBZ9vjiPCq+AFzKBqv3poiCV5jRyjBZfb7qduD7bUMv8UGKcsy1Yv8aBkZ3VaX//KXwumu6rbO+fzNPr+orNVX/fBnMwlS2qGTTaTrsFCuPs/bBHEqFpNmyoFKyWHkGIrjE7j7IKd2tJGOl4MHHsVXRKNaLuD+t22itJCx3Bf6QQXDmuTDrogDHe4WP//FG3mRUt0gMY8ZHtT9+QsRZHrw64JKD5xFRMmN6If/Ne9vRTjQtWEJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199018)(2616005)(86362001)(38100700002)(66556008)(41300700001)(36756003)(8676002)(66476007)(8936002)(6916009)(66946007)(2906002)(5660300002)(4326008)(4744005)(478600001)(186003)(26005)(6486002)(316002)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ib/N46x9dKlYB1mlMwqkC/6uExXroGCyc/RQJQiIiPj1yZsF01O8yUTxORb?=
 =?us-ascii?Q?iC2PtreDDbzUqG/DXmFzmWVRVa205NJUGAMFjFTtgK6Z5dPvzZVdVa424rtV?=
 =?us-ascii?Q?94JXnNyROclfn2ATa4etVp4LOtZGENQvjyB6IiV5GNJqaE6vldCMKcslUUEU?=
 =?us-ascii?Q?whyPKq9rJI6jqTCTLpT4n//ewoc2MymAkjC+BaR10H7W6sk3ddGDEOId5wqo?=
 =?us-ascii?Q?uUkB7Mu1WPNjgO5b6ysmoMnzm1s07t2yuKsPNtKfT0HfLs5U70AE+ZzcKsK7?=
 =?us-ascii?Q?L1u66N5M/B0uRZwX/igX9n7Vhdr6CVBEZKU+G9ScFUN3XX1ntB6JeVGQOIaG?=
 =?us-ascii?Q?ZChYm5B5WZRx8TSKqNBdAPPoQ8ncXZuCluI52fxmSdu/NL7Ti1ZhcqfTDGkc?=
 =?us-ascii?Q?mNMfuJsrofnJ7Mq+8BWf4w0V+eDeAutWNRqJvogbgcySg4+cPYPnTHOCOys1?=
 =?us-ascii?Q?H0FIa9Svw+fmD9DcRlgiw4kjtB4+DTeIZ+VrQ6+D5TnLF6Q6RqgbekwYZQ7w?=
 =?us-ascii?Q?6pxt/RGORH0JEWFKvOD/oIAH0XA3m/l7zWdtSvl5HiUhuq9KL9CARG2Lz11w?=
 =?us-ascii?Q?6CLUTjov09SzRydeGnRw+unnRDIpQQmT38rkNWfAeLBuIhwSy45W3MsvF5ir?=
 =?us-ascii?Q?CImJwB4k28SioQrQrNPmxN7ZLI4yvd9C9LaYZ5NBXXkn+MKZFlldqn6XRbyc?=
 =?us-ascii?Q?XC2S/nfxFSNIEe0rUYwlpXH+sBE+x7hPUiLlZ2iLbtv+7Oahce6fBdjHdtf/?=
 =?us-ascii?Q?+D45rW0Z9cSSZ/jL0xPyID0LkTpx8oG+Di0X2QTDdOHo8GblDG87LwLc2arY?=
 =?us-ascii?Q?5pXZM9O0XKwx5VbDQa9nQEnzqttSga7h9lPma/xIsqJSirxDwYIrtRXNxVri?=
 =?us-ascii?Q?PaiI89kDI9wy4ABy84eaLEADUgJ5ec9n87HwUF5JFE1epOL1MMUX2+rMRkx+?=
 =?us-ascii?Q?W6wUc7uhLa5a4VzAnRzxyI5OQd7o66QWNl5Y3N/dDyUJbvTdb47IVXeJ6KvB?=
 =?us-ascii?Q?RjiukkcV7H5+7wnopUuQ2PxWj2cktHG+ZJalcibzukkZ/CVmlwEaxlC/hTuz?=
 =?us-ascii?Q?0g+c+fZoWd/Aipe3hOoU3Ix3II9NNNx7ffUz5V9LezZA4a87THDBUEXBBXE/?=
 =?us-ascii?Q?jUtumSNmBJ4WR+k88J9xasvv1nMfKHjN32tLmZr9lKfD/DKoV6DfFw7FnbGI?=
 =?us-ascii?Q?R20mI78duxe8EejsM9p+DRLOG+OBr82FqqyCN3Mi1zEJPS7nS/L/HyppvH1J?=
 =?us-ascii?Q?rCutGivUYEsmFFbqchDYFV56uqTfBI53DSmEiw7xzQ6AY4vHWy42eyuk0cP4?=
 =?us-ascii?Q?j4eXG8rJCBefMKJni4GNMKNt27ai0aIGCCPfLZhUXUeDC6UOvJwMyREWRwZr?=
 =?us-ascii?Q?K9w5tU3LKHD8IOAXbfzwUiQvyF1AFFOgWov7gIEo1V+hPf2LlLIfuFnwJlM3?=
 =?us-ascii?Q?PyJTjInsTGdRkQYesuKp+OvsBmDvuszQ4yRA5SCMPSsxtcXum1SzQ/jArGb6?=
 =?us-ascii?Q?1lZD7K4+xIdWi72IfIliVjhx44fl4jDadIAg5mKSj+8vRblCM1AsZl/EG+Po?=
 =?us-ascii?Q?JY44AAee70kx56SzgeS7MbEiWizmF9agGWLO+ttb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399b3f3c-2dc7-4dd3-ab38-08db298c1125
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 21:42:56.4004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zFycZnDHNtQlOtstsHxU1ZzSM6d4gWBZ2YpAtgWM3jsiIf/2GX1vAOpW0B/+aKN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 03:33:36PM -0600, Alex Williamson wrote:

> This would allow that mlx5 and future drivers automatically get this
> with no driver code, and in fact all devices would get debugfs dev_name
> directories for better test coverage.  hisi_acc would only need to add
> driver specific entries after registering the device and free any
> related data after unregistering the device.  In this way, none of the
> entry points here would need to be exported for drivers, which is
> perhaps the direction Jason was thinking with his prior comments.

Yes, my point was more not to add more ops specifically to wrapper
debugfs stuff. If drivers want a special debugfs file then there is
lots of infrastructure to just create that off a common point

Jason
