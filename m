Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FB95E64F2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiIVOSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiIVOSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:18:36 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC27F08BC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:18:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5tLKjn7hfRB4ifFNfKV3aWvEAMkqVDqLW1uSnibfOgZzFkNANkpEDC8lgnGcW+ERJG6aVUgvCq+Q9OSUMP3RW/Q5Uo8RggeuO9TLTC47no2W5Qw4kR3rUamYbl3q8YFuRv2VvmcOILGxk2pWvlPIK7ysxsOkU2cZfy06zwvHDTP79YdGkfQwCi9tQgPRalLwk24Y475alzLyRm4qYrK0E9R7nK0Rvb2+Na90929+9Iy5OyQHiWEhyA0cPhTZUYRN3Q3Uwcy2w2KtG1hOqrbhjdAtMR6T+01n1mN/pBW0/0PxEGKADoPrONFpJeyCu5byUwTmKX9+XRfBue6e1eqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwLKdKI8k8xr2md0cSGuPxv2RpVPyE+FRkI6+D1w9bU=;
 b=VbVVTAfMLqdlkoR4A76zKZLCVfEHR2JIJK8u8v/hVcf30qjjVlqZDeiuBlz8TwXB6zwBS+TLFlCUt9OJfIZswAg2Za/ON5Kl38jE6Xo5CprcfkCgWCDKXFoc+/s+gq53oR35szruV3lyyUcEHwQSMZkEvfPm6HKmomTT9kKOJaQ3JYUSS5tMZ5X36R31OzeVCga1RuUO/rzavbbsnRYYFo9IOdN+YBUd3JPQGQP43G1y4DojSWkhxYPXvIOrulyrNWN1M1baWbZ70jd7tkasPlSju8izWj3dG0MfDNW74mHLIv4y1EswJJJXJ/gpqSgduXCr1l8h0N4Grzr1a61jSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwLKdKI8k8xr2md0cSGuPxv2RpVPyE+FRkI6+D1w9bU=;
 b=aqu3mUpgZL6bSAB1sXTdbckfh4HndP9ydXMDUVcz5TEfWW6nZULDf9rWC6+QQqXsC00DD5Bz8jXLajXFUK7cmuZvTdM8lW6ennaZlkvUOjP7eE//RCugewvqSTMwvPhgACJvE/+VvhokzXZI9qvqL2wtg1ul8YbOYpglfmcGesc5VeaNHF1Kz4v61IorENKInVt2ArSyx3TzNZUmWJRYgTkRQeBq9CYHAivmyNGw1KJ9OmAoLZnLqCB9BvpQzd8EeWLBB9Rgik12iaTfS57HlLm3bm2OZQ+PIxSOdEjTaMMOwdXbgpENaCpO9TjvHj07i48NtnidpILJR1bAsRzO4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DS7PR12MB6360.namprd12.prod.outlook.com (2603:10b6:8:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Thu, 22 Sep
 2022 14:18:31 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 14:18:30 +0000
Date:   Thu, 22 Sep 2022 11:18:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH v2 0/5] Fix some bugs and clean code issues
Message-ID: <YyxutTFZvRyuyWPd@nvidia.com>
References: <20220922083928.58797-1-liulongfang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922083928.58797-1-liulongfang@huawei.com>
X-ClientProxiedBy: BL1P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::9) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|DS7PR12MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: b42eecc0-c461-4c67-7725-08da9ca5534d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6OWENIFSb/g278AqeLk+gN3iTo7JGJcqN9Nt6wJFZjvzmUyOMX4ucMjcqcE0BRIX5LG/CiPVJnrGGdy5zPEdlaSLRe/2ndcnOzFbKpkqcV51dOLyPB4kPNvo2XYoNZJufRqOH3NXk92pE509/T7TVdcJ5Q7D4k/izHG4mA/4yhEIqhsqBJdr0fDTs/B2FdZ621eFr0VKcrS9C2fqPOuoLc4Pq9KE4DKsDxogl+khre6MducN0tOa9lvspTRnaHQDBXK/+dVgPKetSi3GPDpVEv+2GxGX34I6PuzJzIW5dIw2ow//bBjVfAK+xxMMpttPuDAFWIo6t6SMj6shwbfL6fO1Fd6SXurSx/+eg4YtTDoLlj4FVtoJLLOD/WgjqFAjAXCWvLETNjYlRAlNwUlCI2YxvoqykL23sWdNfsbL1Rp3xkNZU8BbmKWn/PqdMgBmIZa4xmRQ/dqy8zewjev6HIExCZOaxGYJ0Jso/nnvVYRIJLF3NAyolnQXlR6Hjq4s6osJyRiCYNZCN/97gFcTyaujZmIN14VjMwJ4A2r+HCovNY8PCSnlBnWngZ5qUrgTLgm0PChKx2eS3IfmMA0gVDOxvmNnzfn2DHavhwqVHey7IOt4iY66fObMI7TsNiWmF22CR+Go+ssBorpXKb+LTwZr+CP+HTGE0jiHWz2JXgzms2cEdwCpr8G55iobrvOOtAbpBXoQZoF91mZFcT8RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199015)(6486002)(478600001)(6916009)(316002)(66946007)(4326008)(5660300002)(6512007)(8936002)(8676002)(83380400001)(66476007)(4744005)(86362001)(26005)(6506007)(66556008)(36756003)(186003)(38100700002)(2906002)(41300700001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o0ZIXHxTcTbm6MhBJrPL/029RT3vQdaWmKHY1j2M1ASMQd0buvm5Vz+fZK0X?=
 =?us-ascii?Q?wzEV1+Sw2eSL6j7HnqPLmaDRoci4azcpjV01NN/m84ZPeFG3OoeqcozhGs9V?=
 =?us-ascii?Q?U6kgxKR1CFKBYK2VvZaHpElWgnHamD4w8nxikr0ae44TE3iUI2hcFQ6Knd9p?=
 =?us-ascii?Q?HQlD896nOBz+NGGcDy6DwffGJfbspsg2HewMBj/6zJQdjlzJJ7QVaXVX+e1f?=
 =?us-ascii?Q?iAGJMrwAJ6tiqBc/GZmRNPwJenVShDz+Cj7SzpHFg+1ArwlyT00TGgrU82T5?=
 =?us-ascii?Q?awBTbXMLuphMgv7PD8mBGF+L0BkCR1mAwHty02z8nQwXJuBWYnU/tRH7F/tt?=
 =?us-ascii?Q?1BCdAtnae8hO/ro/2H4hEQ599/Wy5cTGYV6GhWd8mR+j3TYY4NC3hhwvT8DF?=
 =?us-ascii?Q?C5zmQzXPHcQjxb/DCthAvgKOks7cVB8hmhB9mVWpkufS57nc9H5qM4KFoS4j?=
 =?us-ascii?Q?FvpoBJitDrepLeocUAA/DdDlI3nwBxsWf8vn5hSk84G4zngjOPPoq01LV5fM?=
 =?us-ascii?Q?vwEARrGM/wDSjijbug4uwUFhNS3HzaP7v6pJMCl9zoHOYCoCCopAMYrtyDPL?=
 =?us-ascii?Q?PdHjDQ+8oPVVAQNMKRpXnkJXLtEp4vXJ7LvsjPzyrAHTzPdyxl7ORK58dGeT?=
 =?us-ascii?Q?hF8wZlaOkPwWl3lgtixjnvaSsaCWoJULdKqM+088pSSZce2La+ykBMZ4aW8A?=
 =?us-ascii?Q?/bvGvIvXFGMOWqwQKjeQjv1wd0304clx6psJEhJg2yQapz5ViIYi/81Tlpsh?=
 =?us-ascii?Q?ewIbj8Kxo2kHBBx5B0p1q0QjKOWteiB5+eG7GOMeg+a/Ca+vXVjNqFNGS7aX?=
 =?us-ascii?Q?O+bFBXYIZ3DmdP8aZN7ART6RT+y+1smmxQD6RGid0OJ1BkLp4QbkOv3ysBfw?=
 =?us-ascii?Q?KDPpJsDXwqM84CBpcMFf+gGu8JuCmF/GJ/wyvQbRWgFZaCIkZivgu7M/4FS9?=
 =?us-ascii?Q?MNOkWqINVkkr8LKP/15idF2fTjfQAox14fIfA2UF6UNInBHZMsA3cEwsOrSa?=
 =?us-ascii?Q?Q/9xqABJJFCtztOWlrK4FpemycJh1ulgWFzW5dy3mY5OvMgzK/NaAIv6QcHK?=
 =?us-ascii?Q?PWUGgRaTMRRqC1ys/1xh8iPp/AsliXKcftteFIVAn1qpfxFA6Gfg/2oLz+Q2?=
 =?us-ascii?Q?4X2TuZbfpBWy1FGJSj1w1Rgg5sHCAVlhBuj4XqHi5Bb4aIqEP6let05HZNgD?=
 =?us-ascii?Q?hxfTaM2hvM6fJbB8D9FbnJLQ72VOkcUi9nnG6Sc8apBqbzOeUSOlfixdFgU8?=
 =?us-ascii?Q?i/WFgq0SLuqPB2M1Nvr5L9RviQj0YmKiTUApqDm2MkRQLyqF6FXLZ5dn5+IU?=
 =?us-ascii?Q?SfpUhsLxMqJoN7xQrKDKCIq/EuvjP0Zr86aFof/afdwOJpEi6YAiYHmLdLHi?=
 =?us-ascii?Q?Qdsc1kG4S2cSSWIeVaXupK3gCWEMEiRnVZvJCU2KbjeUZ9hRNXZCEGir69os?=
 =?us-ascii?Q?JuoI+H7IM9Jt97xtzuDGkmqPL0x4RFqLdqd7+nvN/t07VHr4vN0mJGvBKS/f?=
 =?us-ascii?Q?L73wdkjn9KOzGSvAw0dJAUFMnOMXaber29xRnbS5pktsozbrwDRwB1nRn3DX?=
 =?us-ascii?Q?PeiBIndp4Xyvai1jT6skZYDS0BvTeeg9X94ILyWO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42eecc0-c461-4c67-7725-08da9ca5534d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 14:18:30.8718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFK24epcWCBMUZMLLgz6tuB1gT3P3zsk6MuvBKtXjlybBGwY/8vGQamR3SaJqhWm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6360
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 04:39:23PM +0800, Longfang Liu wrote:
> Modify two code bugs inside the driver, update the format of the
> driver's log and comments, and delete an unused macro definition.
> 
> Longfang Liu (5):
>   hisi_acc_vfio_pci: Fixes error return code issue
>   hisi_acc_vfio_pci: Fix device data address combination problem
>   hisi_acc_vfio_pci: Remove useless function parameter
>   hisi_acc_vfio_pci: Remove useless macro definitions
>   hisi_acc_vfio_pci: Update some log and comment formats
> 
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 36 ++++++++++---------
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  7 ++--
>  2 files changed, 22 insertions(+), 21 deletions(-)

For the series

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
 
