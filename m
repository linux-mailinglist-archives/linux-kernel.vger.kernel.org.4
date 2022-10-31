Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BF9613B09
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiJaQPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiJaQPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:15:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B6910B76
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:15:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIhp0CT0U9nEYL8gfhJGhH+PhdIamcOVFKg3MugUkRNtoh/GnlMvjo2zSrgRuBaPvyakbB6NfYTSTfnBdfnDR7+AHOEzuxeESMepo9BwcJxq0RJFaERw40m3zl2Zc1qlc6KbthdVd/IiRg+llU72KhmRYzIJPBrEGWaANtLXbo0pxYxK7+kMdC8j8DFcOY+44w7iP64DOiZ2a/6uChL2mF0GRduEAtGyGKFSpqqc+fJCcCstYFPZhkrAkgsETKovc3672EO3WuJZ/sD1dizlKIh8HcOnUmykOkukVmbhS+ovUax8YpKrTOhDJO8D425ewLFQkUiM2NvqgZqKsespag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ymv/Gx0nEYYPUWvHj///ebZ5kzdVa97TeZxdXMbKpU=;
 b=jg9DSmOJtXmZ7GTLz/4sB/u31OqNElLzC4U/DU90vg/vWurovp4dlTK3aMcAsFDHo2Kt9qOd2T0IIoYNklwdiIbmnUSAlimRcOkvZ8UPM+7DoZMzmKgGnSaM0GZKJfcAgzGgb+1WcIQN5q0Y6TupyCfC7lWvnCDDWKxVlcjaxayWZKK3ApWLMizBVYsQUFSajOb6g7key38kcBBx85+PaUDhQX+nDp9eEC6jnXhb3oP57J78oendR1aJmOhH0hhNmYHekw4Ak0VFqoT4fdgws5q7CgTWLml14tjZI4HXmMahmnQJcZAYwgzkkQ6UMZbcxj5oUzleuwh9UQgWrPfhVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ymv/Gx0nEYYPUWvHj///ebZ5kzdVa97TeZxdXMbKpU=;
 b=r54p0SKB95sUebh93mtmUAN1j8g5viUmaSpq9oJ4A7TgvGYj1k3x19MwzsqVCq1+B6kz9FW6rrssfezTUHRzW7P9ROhR+yCfu+8ZeP3yaLFqAu8f3aCWwF4g9xDOO9MIKCJFe7+Hkrd5KejZ2Jmx5FajrKgLZiSIaen7MGiDaTv+OYJ3Aovq+5gKuMoYvk8ej/nJRN7Mfr+lGk9PA6k6U0bSQo/DQBMCrf2ok2LDib1c6sttmUa2bBZJfeCdZyhClOFrrnAffkjMVGrAHGpNJSzwLCJ7NJD0e/vYdgV8ibCIFgchBBz0uIXp6OpBBRPHwbLCWgWKFJs0HDQPY6lXSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.18; Mon, 31 Oct 2022 16:14:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Mon, 31 Oct 2022
 16:14:58 +0000
Date:   Mon, 31 Oct 2022 13:14:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com
Subject: Re: [PATCH v1] mm/gup: disallow FOLL_FORCE|FOLL_WRITE on hugetlb
 mappings
Message-ID: <Y1/0e12ZJT6+N0kI@nvidia.com>
References: <20221031152524.173644-1-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031152524.173644-1-david@redhat.com>
X-ClientProxiedBy: BL1PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4c6c2d-8181-40ef-34f6-08dabb5b0e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c+D2mSppAEKgitK1FDmhIjS1Cs7/+2plH7/TgS1aOGoogpS3z2GhSJCLSx6E1bdSF+pJvRlLoYtXxP6K314/YllFfgu8Im9xfqeJJ0k8SVgNOwf69r8FFU447AHmOaicLKy+JA5MTzQiIRcH3ZSlDm/NBIEWL4/nq6xpYIvovRFbLnBclkKgK9yNmkqmLiLRUQmKO4TYVoE/i97j0sFBgwnx6qnj+Z8kAZxtw2KGQbzJJ5cVDCNNLMhdW5J2K3rOoUKSSsAwmcrmF5nbcjuk8nDFiwlMsefOct6S18L+bEDwL3aqi2EsoHGXsGDcAiVKa3IrLSDi7qpN1KefneJtw2GVeoRv6L+JjWY1SJysHAUGJ01M7SXNP+Xnce1hR+5i16z3lwS8UIJmUxXoNCQYFwroiyowPjCN5aeHqhpLr8PRWWZNPkxLOE/H3Sajy9GMmx1YW81HQ5dnog4cv8M2TmqMEPW7hyB5hFU8n2u52FejZLNgwGhOXZdPLqmoix1tXB71EvS2xCQsVhOP0MJUhuJ1sHDhfdWHe8qrYoNANVPuA41zDmFIKAWRt0Tfqu27M0VeSDn9WTr6gHo3nvkNZrD7GrveNWhauFCCg43tyCS+Ggh7lgU8iJDTgl2sKHs3MN7GEJoTYEMvbqvXIwc7/72sviqYFWSzolbhWFhIf+EwTudW2BaBbE9YWbnKXPL7kGCduKSIRqHWF8f3kAlSiqEoxesHP+BFArbuAZRCwBmOPgh6luo9F/UxpYjFiZ3T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(186003)(2906002)(26005)(83380400001)(6512007)(41300700001)(8936002)(2616005)(4744005)(36756003)(5660300002)(86362001)(38100700002)(478600001)(316002)(6666004)(54906003)(6916009)(4326008)(6506007)(8676002)(66556008)(66946007)(66476007)(6486002)(83133001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zX0z0Bw+Q3tNGjh4aIm9OMkfax0ve4xXEoCjrhhO2LzQLqigl18cP19vZAO6?=
 =?us-ascii?Q?U8zE0z6x1MZcccRFViTQogTgLDjkEadgebAWsllJjFpjiTCPac+p5qQOYPiq?=
 =?us-ascii?Q?SiMoBRw1N4zC6StxzITMyOEzCAPnDEBZcFtsXrsxZeSibGWF1y/sr5C3bjzy?=
 =?us-ascii?Q?w6diZ5KFYAjPI1Zxq+DOdWA+/+QCmmNu4ELipoCCvCimmnYO4gLEHEkE8jKa?=
 =?us-ascii?Q?UsbBsHmr5hgebGg9ZDwCXuM5GIVWwqA1idNEfN7KYOPn+Awb6pR8onu0IPxE?=
 =?us-ascii?Q?b8UUBKvvveD0zl5jHu42vqToRVR00cSRSBBarR0NWS8znk+MBrzW3YI+hs5q?=
 =?us-ascii?Q?+uq3Qb+lN2nL7yklWdmS8yU/HyZ6dUcy4nGMK+jH0F63Eq4VGLK/dfOs712k?=
 =?us-ascii?Q?WUjXrU98AfRms/7StJv1+f2P5gA5C/4PPPHN5WYeV4l1xR+dTyUQ2NpGAiVZ?=
 =?us-ascii?Q?yXhGrWvuQXm3d0uijANxHJZLmlXbuEFPTUzsF9MkQKm3tUzsQEZ9xGhsn/Xt?=
 =?us-ascii?Q?niYUq9w7FujUzUSEi1WH6KBhNeVDMyE26k8+sM3/YYz1KmVdBz98PbaO5mdP?=
 =?us-ascii?Q?miC46Shh7duvOpCs9acESwz1WfQzPPG0NkfcC3nF0/FONrJNqBsF22NkYMdQ?=
 =?us-ascii?Q?2qCMjXSMWxbBkHHbh7Uhj/OAh7Ip+TpiGPM5us69zq9STi7f7sE83BqCkuZi?=
 =?us-ascii?Q?5pAcTPAYpohj2roKw8Yq5S9KOgGlwGKf3cm1Fbr9xeGLYr7N6x0w1Qxgh9xn?=
 =?us-ascii?Q?N/5PFBxZiZlmJ6O2Fb/ZgrRnWoQ0KXyHuTpMCjCQ3SnfwigSl1hSiSVcWgax?=
 =?us-ascii?Q?oMg8NQjLaGrplkmMLN/rzWqJENnSAF7lhI99DS9LA9xxgS4OC2E6Dk96++aw?=
 =?us-ascii?Q?RSXhFv8iJKTlGSs2ee8MxcK0WxCvRLI4CSGs5La03KGRVN2Aa8RF4OEFHh6d?=
 =?us-ascii?Q?GpfnilQl7pa5Do26HjvvUS/9j/SiUGpxgjSKw9s4sjikpRJC9oBAbkjueJ1U?=
 =?us-ascii?Q?XFfHWMKvMqOKlen7V+E87mTF/SubM831aoPGyu5EVEvxVoGM+mtIPz8tv4g+?=
 =?us-ascii?Q?jPBbMZi2OqEpwHy5ne8QIdh8AW3gLyVsqRmKZmuX8/DIFYN6GdAqRRDRp+f2?=
 =?us-ascii?Q?uFabqsEEGWFZWj9VcNfj5BRLP7HN1jzcRcAUIv341G5NzjfrFHu0E/h2Gv76?=
 =?us-ascii?Q?RpOZAlEU5ytXMdcv1KhWWKQ17Q7CfeeZz92qtthHztzJ3A2QU8mhw6p3Dw8E?=
 =?us-ascii?Q?oOYhRb/E0WZkeGRkO+HESEqakvzHczkAzjSviE6qKxf6w8LhB3Wvo9Ni737x?=
 =?us-ascii?Q?zGh9PLhHzF0APMwK08evm7qesjXcXUowI5SrVeeDj0vIuXOntBx/KuUrtvxm?=
 =?us-ascii?Q?mvCCeVHCETtEA6VviiO9faeM1aUOIxHxzeBCW+g8E43TeHV+jI27QcrWKdZn?=
 =?us-ascii?Q?D/cP7gIVbHMx5hgeEKBBQJfb7EZIOhmfnSvGtbW//i18B2CWjquUao0FAzqx?=
 =?us-ascii?Q?/rNmjLuvUOqsn1FHYYwEcX3ee8ahehJdLhAWg6ehf/W5dYVIZFQ6l3sGcbCC?=
 =?us-ascii?Q?ryAck1dd5tU3o0OBhlU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4c6c2d-8181-40ef-34f6-08dabb5b0e3d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:14:58.2906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cdd4O1iqhPU+zqfJ2AKrdX4fQleffen5cyNlmLtELpUMvabE/tiYJmRkxLZsM8Xs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 04:25:24PM +0100, David Hildenbrand wrote:
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Reported-by: syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> I assume this has been broken at least since 2014, when mm/gup.c came to
> life. I failed to come up with a suitable Fixes tag quickly.

I'm worried this would break RDMA over hugetlbfs maps - which is a
real thing people do.

MikeK do you have test cases?

Jason
