Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD456815C3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbjA3P7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbjA3P7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:59:20 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B52232527
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:59:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5cT115EoiiXMM+yLT8iNSnKm7dVtIQq3nDPgsjw3I77GJQSk3NTqVfV8PvLdwTS4NtKDpwt2U+oRedrc2PMQh3bo81kOmmX6mqglsTN0ptkFgGhdcN5BOqPi/86q6cfkGXeNPhtskV7T5OF5/dqwBPqnWSX666YxIrff1+YkOAI0pzyOTC4k5fI7hlELmMji6vEotm0D06TQLU5h7Eqi46VJOO3pBnbYKfcU6ez5L02vhomczdq7+Bz3qzYwn/FoBTy2vJwQP+tnWTnpB/qaNsg2vFAMfebHOAibN8X18TLXG3AZe/MIBfVSj/uNrzD0HP3Vl6egM57tcgKcGCk9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbDqjQPll1iR03xwp9YM7r52N8aRLG2TOBs2LNKmr2c=;
 b=eclOScNxrESK816qa8NQgDvjdZVuiIU051r7XB0MGyf3StTb261BKc/Sucg/+FXglfpl/I3P4XykOawtYy9BK4wIpRI6EEgov1L1dCSiSyOZrppt10Pek2aB24DTj/Pve5Rt/ch8NERX3KUeQ7Few4PO7Jr3vSYEEaaYXudVoBgiEVWM3nYjgftVlxMhQ00IWXuWwXN9/LtTXlyP+asQ2uTLgMFCAm1zO1BnHg65gN/IsHxG6Fans1ufQPJmlyx5RKYtahIuVGb+2ZKb+KTc103EyVJLQg0LwTUaBPd/zo2JAc1GN3Uo2pqQerv4uySNPXpRVq2wvICr4bdufQHrcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbDqjQPll1iR03xwp9YM7r52N8aRLG2TOBs2LNKmr2c=;
 b=eQA2EEelNcyvJHOe1tJ4tg2z1hSzk8tn3tk8RdNrpQsLXGJ7sx3MWePloy2KKM3xmeebisNB0ziXrbC75iYw5Zb7R+rG3WfzsWjyjG+iTlLNxMIb0toivWxOk/Vpb6l3yv2bjI/jbbji6ZtvCwVR5aAtOEZvBVanF0KV66ZxqOa1+mCLHVUSihZN+uZd/huu2la7MAMHf3HoF6pimnrBM7xtRv4vY4RgVoi2DfYpTmXBisHa0lIFSrhLFXZniAtdHMHD5oqNr/vTgZc3q4Rprd/GoWW//+cx6jotBX6Vc1xYOuZ9Oz2YsezmD0Cv4xjdOjTP50Hh+JlEIUwQV1hjYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 15:59:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 15:59:14 +0000
Date:   Mon, 30 Jan 2023 11:59:13 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, hch@lst.de, baolu.lu@linux.intel.com
Subject: Re: [PATCH v2 2/8] iommu: Validate that devices match domains
Message-ID: <Y9fpUTg9wN+SXD+x@nvidia.com>
References: <cover.1674753627.git.robin.murphy@arm.com>
 <0f78ba36a7b31a0d534416e56ea0f1af0efc2659.1674753627.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f78ba36a7b31a0d534416e56ea0f1af0efc2659.1674753627.git.robin.murphy@arm.com>
X-ClientProxiedBy: BL1PR13CA0154.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 4705aae0-8d24-4ccb-a30e-08db02daef69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 81lBdR1s5Ib5dImHqK32ycb1NcaQDYrWsQFrvJOlpkMcjuAKPly2U2tdGuE/YkWB3AEKEkRnzWl02V9ytEHpxaHVyVINWtTwTOYpWcRZm1Sn7/zEJV1jRcxNnLZg2WxyHdhUleEqQUl7zE48agqfPWKrJ9JVB2l4LPRLjAdQEEbKcZWx+ALEd7n8ChurKLXtCGGmgvWMrrXLmHV9FKw7wFVIMeud8T4wOvLUyJpELJt4Sh8Hzo8vEk3S2HGf5CXPCrHQgxZA0LCnG2bxxy6L6O6ZHbRZaFiRES9dTAyjyyXaKhTrDlqhRjMOGe/5woMGUusQP+YAfesJSQjUUPjSDv+2YKNSsH7+1gHLCq/925JN0Zf5EaZ6cjgUADEetd5xzI3RBnkithzv+EqWNmvMgsWUzIBZAK50fiRhVxJPcEsAyv1sbTbIdukk5aqDikiyoQli0hlIEFTLSlCqI/O0Y2vagE987hbgsEfSeBWj53v0kcfuikscT2rrfHY7qpypUO4Fvn/O4iu7yfpQ3u1rx1k2mo/JSyWeIsoNZ4hOEUDLYoV9rPdfUG2HSFxTx3RDazzc3jcfaOEzlZBkCRJfE6emAv6p4lOxpCUP/E0eS3vSWX/8bagHa5l7kbT6r/Bf6V9kt7qC4kVl1ybWLn3klg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199018)(36756003)(26005)(6512007)(38100700002)(2616005)(186003)(5660300002)(4744005)(2906002)(478600001)(6486002)(6506007)(66946007)(6916009)(8676002)(4326008)(86362001)(66556008)(316002)(41300700001)(66476007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FBP0eNuALr7QGaIl0XlbP7RM+1MLGXUG+0Q0816T2o8YYwOZWkx7SSiWPfT9?=
 =?us-ascii?Q?mtCcyA7ZnkdU6w6B1R6Np5u6StOoibH+f0wQuVVjFMxNu4VxgSWlHxYI2kJu?=
 =?us-ascii?Q?NLHOVyQVHN4KiLAav7wIg+lTnRZq1Z231FaBsVYpPdgLSuZLbszD2+aDELKJ?=
 =?us-ascii?Q?qrBwosJxHBJ2qAZWM3MYpAFbhXqwcUXM98xIHAxArKPD+mzcCpLcHrTAZQa0?=
 =?us-ascii?Q?C9+8wiJm631BbAAB5e1PMzkbFsuO18TWEm7nJw+PicnZptDM/lfZePjnZEHb?=
 =?us-ascii?Q?7k5uUzpcjMlwIosQ+akZ9M8r85IZKg5LudTBdyKqziZpWEZaifF+Wy4+g0UY?=
 =?us-ascii?Q?ABXQaXpabQaJkYJyqvE692MkdVYjU+gURKXFSnI0M5bIFoSA6o0V1JKTrvgN?=
 =?us-ascii?Q?lgzcjnUcGtW01qeSUfb3AoVH9uvVO0D3xH5qjzpNsFQGPMVeohWAW4OUom89?=
 =?us-ascii?Q?9jthYbBCWlq/uXTLflVvLnnZXFBoUWoYYHw/6mGl9DODfL7Ut1sP02ZTynZ0?=
 =?us-ascii?Q?VZl7T0T1TR4LiKz+mE6EMRHYM9anDcfp0FZBnp1SxGW5d0V5wIvHbqXpfKf1?=
 =?us-ascii?Q?fmR9W0knaTHfEdrcuXVPr3pH9AifcMHqS2mvPzBQmy9gWVXTHnJol37EaEPn?=
 =?us-ascii?Q?xdxIG5oNTTk/3zTYOBBx7aNZsWmMgPk81QSum37vU0NRS2J08gAXsdOAoTaJ?=
 =?us-ascii?Q?byIFo9B2j/whBy1l8LLe9xCeVxUacuJv5IIV5u1/REqtNmUD9XcW2ZnZ2qzt?=
 =?us-ascii?Q?+ZfgXXoDBj+hhKHlyrHFt4dcHRx47zLyJaDIyvL2jM/ZZwmEcD74CTfcXj7c?=
 =?us-ascii?Q?B4OOQhW9Fw/L2co4kp195ZQNsCephd1jgzcddp+uj4bAwSQxDasGP8GBaGuk?=
 =?us-ascii?Q?R8Btw/tZRHVMhjsi8NWUhGdbve495xJuZY7gAKZVbTkjDwUb/fUcwG2jjlmQ?=
 =?us-ascii?Q?5j+83xAAR+AVcKj2k/oBM+BvmxNTWlThYSGjBUQW5ulBAmFuSedVrTqSxcrr?=
 =?us-ascii?Q?p3TYTjqkiywa5J/u7JSMtVPmsrnyubzGHKdwXSFQyiOtvuDFwTItfqF/x212?=
 =?us-ascii?Q?0/HjlDhTDkTCxRBXxeVJuySRQDcWOufO0z0mB4DZLSPf5nvg88OEdM/lQ+Ww?=
 =?us-ascii?Q?gHiWIAKB3eocwmeKyiSBq77rfYt7OwXcQKdmRi4Z6Ohvs/npFrk+cnwqg6dj?=
 =?us-ascii?Q?KgB5EIeeTYHqIbfmGpG1ywz4p1hawK74LS4mEMInoj7R/CmD0ksMBKAo9OdD?=
 =?us-ascii?Q?PkU7wZnw38VfWTssDGnG7UyfeLgmWTbRLKlU7CxERqXJnk8XAcXhhO26nq0g?=
 =?us-ascii?Q?2HwveOfqGiFhPNL86E9aYRE5WK4CLOafZ72HlCccUlyArLohRNYNIPXjd81T?=
 =?us-ascii?Q?s7r0t2+R0P2al7QXN484vVBrfz+jDt47nqMt6w29THxoLynGh0eCe2yzSsgw?=
 =?us-ascii?Q?/qekeyrSOFntU+vxFVemw4W5LebL4jkg4d2hBLWnz9VN1Q5ZXC0P57NEHQzh?=
 =?us-ascii?Q?JVp4acRH7i/Jqo99YdOxxUITDf6KUEOfsoqYqRhOUVzesbOt8v0BQ2ZGTqJV?=
 =?us-ascii?Q?il1UNpAUx7C8KG5Nv5OAg1PS9w/fzeyEPale6qGM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4705aae0-8d24-4ccb-a30e-08db02daef69
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 15:59:14.6954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZQ/RCmAXGHVndLjgpEL5NplK7QKH1Xq8nPXSjNYfqurSLZEpK+qnMMNNyXtuVNZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 06:26:17PM +0000, Robin Murphy wrote:

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 3589d1b8f922..86fa52025e75 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -95,6 +95,7 @@ struct iommu_domain_geometry {
>  struct iommu_domain {
>  	unsigned type;
>  	const struct iommu_domain_ops *ops;
> +	const struct iommu_ops *owner; /* Whose domain_alloc we came from */

For some reason I thought we were trying to save bytes in this struct?

Putting a pointer back to iommu_ops in iommu_domain_ops would allow
that, then it is just domain->ops->owner

Regardless,

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
