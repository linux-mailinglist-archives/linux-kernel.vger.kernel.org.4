Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0130A6EACEF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjDUOa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjDUOaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:30:24 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6934C654
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:30:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlOSHWP3Gl+6zR9jRfUZyUMWxwT3IoZgmR17oV7idJrEbMsdtNpYgpORI2e+Zc4l0m10D0oKEQOsEWnin1eEOUuuHgZoPgriSUN9FvXWQJdLQf0iNkdLXhZMwtTz0pwpwABheBGUY/dy7KEF4gj1XNweoUUY6I8tZXidavvKKvWbv/uTjx8GjVKLk1/5i884qw9HmrHi9I78oVG0ivoPy4713UyOtKGGYy/hHJvay2nKRMMJxmBVmHNevbjBTOhJXJZGnPdtpV/vM8lPYoJWs/q2igjSYqmODesple7xoq+G7pAyOCy/gy+i1rUjVtr4X4oj+IlXYpWE3caJHDo1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NP7uC8DH7ztPiCSWVUFljzl8G5bcI6Ea5E+VLGdlJKA=;
 b=RrvzlWhCrlkVI1LPX9ntPmB1zCNTGoKIiCbjEw74TaTetAunpUVbWAp9KTzvilPJL702QAZ1OC7zR5ZaU6zRtTqJIHUvASC7tnoPjNwDzIeFdwpUknUYAvrot8mf0XoOJm50ghmk+kzZaR2Y3FLy7W42eeoGZGPrioxoGia1qi3wX5itHwEgKVzcASso0qsk9N5r0dwzszIl8K+tS0AWI9smqlAx8Ikn01yBFPfOKbAnaxTlNwx5e1oqzsP5iKHyPpVAN67mY+VCkeXC2s1P6USF1HGF9cW/9mop2l3TKC9xwAF+cH5SYpblH7XJn0ziCuplbAhzIvQuOxIzIDd9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NP7uC8DH7ztPiCSWVUFljzl8G5bcI6Ea5E+VLGdlJKA=;
 b=LFm1W0d0Zs1HabL6i8fl6GtQdsBOHKuVovC3e0bM8rHZ9h1/Ia9iMKzGEX/NbJr/vp5mvpzKke39ueMDoUsni0HgHosM8AUDgV2e3oIoN6oimKL23EqSvrerhEaI+0KlHxBCUXlhpYEsVi+F7YvImd2qx0HaY3n7LZIx0J7rr9WyDqMu08HoNeGN9pyHksRv5iZxFSmQAC8ZUCtRp3y8apqUJb2HfhoEdzypay0hagrMtO8ObmczmfC64F5MjtOoBnOr7ogNYpqufVixu6Z+VaS6hK8ALMV4Opdn0CUrOh+hiGG3QGFGYd+dm9BWkcgc2RdjY4ZjO3jO860Z6gywiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Fri, 21 Apr
 2023 14:30:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Fri, 21 Apr 2023
 14:30:14 +0000
Date:   Fri, 21 Apr 2023 11:30:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        jonathan.cameron@huawei.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH v10 5/5] vfio: update live migration device status
Message-ID: <ZEKd9Rnt9rT0aAHh@nvidia.com>
References: <20230408074224.62608-1-liulongfang@huawei.com>
 <20230408074224.62608-6-liulongfang@huawei.com>
 <ZDlGOlGqo2ZHDFm3@nvidia.com>
 <fe02f34a-c3d9-056a-3081-58605e8e1247@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe02f34a-c3d9-056a-3081-58605e8e1247@huawei.com>
X-ClientProxiedBy: MN2PR20CA0046.namprd20.prod.outlook.com
 (2603:10b6:208:235::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e59b3a-1e76-42ed-daac-08db4274ec0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PieZW5mca05sxeAoSMWHypxfv7GwP7bBwi+HBPPn1m1gMLXqiA4fpbRdpFrSQE5JZtbM3QeRvf5A+jHz8o8kmZ8V89AnK6XnPIMeGa7DhgmNTR61YnvK6X6BKfxTpOs0FNZil92jFg5FI05/w431mstmXmvX8GRxrIS5m5V8yfeKQY4vFlLhkh+mF33AQkuO/NwuoIQ+j6FUGDQHIhVLAi+zH5WYnM2+vburWDBDGrhOtA7wbuQ8j6khgiJcAgGZvOgDOiK/7RxbmRQQKcFkULcTvXfTVAWKtDUzI8Wh/XZ+RalEExU+c6gMrZlkNJzb5pr4oLQY4bQzVIZvP2KHsLEcgfJzRjD272VZWjbhPsyjcFY05rD8M2FFUOdWB7CevOPG8jBFSH3SLrZcNDM1rC9zAqLzqygufVyCTtkE77EnZ9a7xAP2wIAtREZIqrMX4aVnQoAenP6muAne2g8Hk5QWG51Act7l9p9NsoFDEt497zoyo7N5k5OmbM34Eg3tOVV9yC+Xha3L/PmOuO6SLUZnIia+Gr100YyOIzhtEjQjflGAjcI3u0ELPwCEJ6G5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199021)(316002)(66556008)(66476007)(66946007)(4326008)(36756003)(6916009)(6506007)(26005)(38100700002)(6486002)(2616005)(186003)(6512007)(83380400001)(5660300002)(8936002)(478600001)(4744005)(8676002)(41300700001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+X72Ae7UoztZWIKU39kQwvweI7VW4DkSv3U1/wkX/6CT+I+VdNbRwHXN0t6w?=
 =?us-ascii?Q?rFJYzVymuNwaDr055PA4PMclQXjhqJeRP4hZ3OePiRDu7aXe8otTe7q8YK1R?=
 =?us-ascii?Q?AhaXudz7wGocHA6s4BuYqBos3uz6UecooIzrpk99au0Tu8FLxGTzU0K/DzHY?=
 =?us-ascii?Q?+y4Cl2lSVKzfDkd3nFMv6Hdk3GeYXIoENo+SuHGuSB1PWDkjwUUD9zimhCc8?=
 =?us-ascii?Q?Bj0+nw6Tg8pVi5LXHnTkG2TpJo3D/G949jktCCwPF/k7l1L2PEgWp0ezcBOo?=
 =?us-ascii?Q?ONwi8C5LnXOV1iwQSbGawUN8hWDfnB42tsKiyyDs0rN1DCB+x4Zon6e53qoM?=
 =?us-ascii?Q?ME8R7Wt+xlez3f704ZOtO/tGmvXRLO8KqK3U8GGCfva/4VwYTb7bZsCzPodc?=
 =?us-ascii?Q?G/VNMtUgOf7aaBoIi3tANd0y3NmxitKN5N8mee2d+DCyNpLjLnFe+UGTmlO4?=
 =?us-ascii?Q?JOgq5EvtOsTLwpauQdIlHrConUvemM5yKQCXuU+ljKGJ9f6dve+kxCHOjBPn?=
 =?us-ascii?Q?gdsXMd+V+WO6U7MqFGfiP4cmN2F/zA2HDALyfJOx0PkYZkZw0zcTUIhDiwDg?=
 =?us-ascii?Q?bKDweOwmfFSTvptKy2MkaG6FGo6FiB3vjVsvq45W+ZXwsL7PTBll+yr3n+U1?=
 =?us-ascii?Q?ALQYfu5NVTpFmz6c+/zZbXgTPXDYsArLdDOFcBhwHoxX1Z7i5TZVN22sN37k?=
 =?us-ascii?Q?me2HADFJpoexpmRxqCduh9R51BZiyCs/VNi/krOWY8uvSUvA8HyeVa9iWVxU?=
 =?us-ascii?Q?nTGRAiObbCIvSPicXAnP0+ldzQA+6w3Lg+zoKVT2E3+aF80aB/7DyJViYd/B?=
 =?us-ascii?Q?DxeSkc/Up4i8ghzFjIh2ctlrfemxtPB7mvXx4EKzTlyl4u93ikRuTywCzGNI?=
 =?us-ascii?Q?bOqY6GELTjzMEozgPgiM/z7umNZD6n6qt+eUxkG1Q9gOi0M9UZnlw0uwKymP?=
 =?us-ascii?Q?aFIe9iqjUq+vv3AG3wrxvxSz4Hh4QCUYv1wYjgAtdMxWpFzwTeHF+6n3Y3KF?=
 =?us-ascii?Q?9x9V1rRPSAjFEk125orIXlW6hXmQov0F6QgoqP+SIQdGQJdVmXdPsKtvo6vU?=
 =?us-ascii?Q?gBXaWknyTgaHEoaFGoNcMEnH1co11b8qS8GixNltFXIktyGVan/e3jBPOspi?=
 =?us-ascii?Q?eezofJyx/MpRsbhomW5JpfzKn/SUUaQhJ6PdnI3pA8De2m/qNWCCyVQzSlH5?=
 =?us-ascii?Q?ogIgH25EokvzNTJxCGQPJBJQXHnET8uOMYVI/lk9YNFiERTGZj/iu0+FQ8O/?=
 =?us-ascii?Q?3ePYq2JCJBKXf+EknTWnrE3Z3JaS2rGEEIn1bYfhh10koqSDXp7PK77mxiri?=
 =?us-ascii?Q?xNaD7NxKrMzTj4YRCyqGWjZcTktL15A9CKLBwSCdQ9WRspWaYSMmcDC/A/ME?=
 =?us-ascii?Q?yZd42cxPM3+d1H9uSqGZKOMJCQUHTvgNW45tJOdPzi7Lb+KO7bDl2ZKAPiZy?=
 =?us-ascii?Q?/QKZcIWPt30TABlkvRQ0Xm8XFLVSkrmPYsfk5GoD+F/qIDJFHEhM6UnlztGU?=
 =?us-ascii?Q?xXo7fQWwGPGyL0JuvMZFZGPkVhQmOGo5yphwKEG0AFM4r2tii8rLHqDhccm1?=
 =?us-ascii?Q?roOcEEulnr/UoOQzxnp3WT1EoMTEMgux8UOZFUal?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e59b3a-1e76-42ed-daac-08db4274ec0f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 14:30:14.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHWO8LrrUdF6YsdzJ968EJSyg8yH9gSf2jvtcaAssbnWuN1FscequGWTaeM4umWb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 11:07:53AM +0800, liulongfang wrote:
> On 2023/4/14 20:25, Jason Gunthorpe write:
> > On Sat, Apr 08, 2023 at 03:42:24PM +0800, Longfang Liu wrote:
> >> migration debugfs needs to perform debug operations based on the
> >> status of the current device. If the device is not loaded or has
> >> stopped, debugfs does not allow operations.
> >>
> >> so, after the live migration function is executed and the device is
> >> turned off, the device no longer needs to be accessed. At this time,
> >> the status of the device needs to be set to stop.
> > 
> > STOP means the devices isn't functioning
> > > An idle device that has just been reset is RUNNING by definiton.
> > 
> 
> After the vfio device is opened, it will be set to RUNNING, and after it
> is closed, it should be set to STOP according to the function of the
> device.

No, VFIO does not STOP anything, RUNNING means the PCI function is
operating normally, which is always how VFIO leaves it when the FD is
closed.

Jason
