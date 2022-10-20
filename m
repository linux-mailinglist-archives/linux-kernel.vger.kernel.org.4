Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3FE605E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiJTLFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiJTLF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:05:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02431F708D;
        Thu, 20 Oct 2022 04:05:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXBnQm0RqhE5ltyfcRc/rbev96AYJkx6aWQ7WP1O/mXwgHDtaRCiSJy16t3fzreM4haqqKyTiBabYD/FjQ6SuxJT4X/kG4+BFFlsIMsJ+pww4qCiCoHMM3tLb6umCAWqjjsIUetQd0Op6w9ZAfyuFwAL7ru/Klyynk2WPqlON6rxZ2RAcbhTlpn7zZEQz0oE2hNEOFhgb3BH9F27+CnQS2MymLsqPxyPKA3l1kt6DrDXm1oE8EKLWTA/4CTuf2KO4NJ+65cjLuzsAiyitxzad/q3r2R9D+3SHIQ3HrxE1OmNIs37PmFZczl8YrNCL/Xu4UxYCVE6LsAskiEyHWDJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJadNk4dQ25WPPBB+hjLuQllRIhVQV3CQkzNDMF/naQ=;
 b=hMpIovCAEtym2hKDQQ1MZIeDrLlW2/Bj9wLcptjgL4O93rtC6ApqnI7F7+Gd/r46mYVTGOuPQXD3NQnJbBMRVcUIlTVSh1hThEkBTlvUmbQXAyGZmMvWZzJpp1uGHapuG1Y6wZ6mS8WCBYaslzx5o5xtC3/lU0jANJMxib2zFxTRWaoHKulMFo7HVvYdZR1tgiXxGGwKimRV/EY/Yn/LiI1K+r6jSh7deHNnXdZr09OZDfMYy0nGFNW0KanFPW0x2AtCZB9BU1RmxjsLKqceVRZSu8q/qZVN0kNUZ8U8DKj9H+ZNdf+2Xy4RO6OCkDajNcvF8gRJSwGO99KjSRvYWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJadNk4dQ25WPPBB+hjLuQllRIhVQV3CQkzNDMF/naQ=;
 b=k11+4A/aWu8KSS1T7ndH4Ftu+Acuc4+lDwUcxbcSp9N8nQ04TJGCFmmomtwjIKWBT7IyFUk214s5n/Ng3ecgmr3jRkA18o8JGmSdr0uwy1tjoyHksa8CJwhQ6AlxRBDDhuUKntOnf958L36P+NoAeJ/UzqQXx+On+ntOXTBTt/r5xA7MygYYTWipx+HO0CqbiC0F7e3lS1dH+Lbs7JAl0tGfYzpyIxMwhihWbQtAAHqlR7RHLHXPCJTDUKJANPO82B9vJcgfdKeLkcKO/MkorrkNjZ3FQCpEy6bATv/49gpnYVkaiLmhVDkWNfJvTrY89Dcug3nJBmFMe60C0bl2aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 11:05:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 11:05:21 +0000
Date:   Thu, 20 Oct 2022 08:05:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iommu/s390: Use RCU to allow concurrent domain_list
 iteration
Message-ID: <Y1ErcEe82yjJI+ET@nvidia.com>
References: <20221018145132.998866-1-schnelle@linux.ibm.com>
 <20221018145132.998866-4-schnelle@linux.ibm.com>
 <Y07Dz/NROAMI0Hku@nvidia.com>
 <8e268ab5e0dadf86be5fd7ffaa9debb76cea67f3.camel@linux.ibm.com>
 <Y0/lMCQ8oeXJ2HTg@nvidia.com>
 <f3551bb461b3ef3cfc1a0c644093816be1835b3f.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3551bb461b3ef3cfc1a0c644093816be1835b3f.camel@linux.ibm.com>
X-ClientProxiedBy: BL1P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: d814c4e6-1e77-4901-82ea-08dab28afb19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anM4sGgxkwZV0uUFR9K9gVmad26xO9dT6OwIwFLW3SmoWclBBDSzi/ncSYVv6G4TN8+OpcNnqiJXa7VrZqyChNpCUfHTRJEAgQjT1nCnw4zKvJgncz3mtVlJtTrCxHjblzeRM94ftlowsW4wmkPm/msHa1a6BEpBl9+fus3/869QdC4JIU3PdrLwDzVZr9cTyqMkLv49lZ5gKxeoK3Pvz2ZfMcntXJw5UaevXEVlS8zue9pmoSsTqlRxPjJkiFjDiKpR1hauPuJpgwRJR6kfQnYUUpyXuAy1FyRi/5Ovmahh5o06IaV7TzgGlepkL93i7xryzbLRoN5bRVOPsyesO25YHhvgLQ3KQpxCC5tHZ1FyLuMhbAwvIg/HZEB3wy5FLHOiuSfOJfSabNfwrUkEe5EPF46eKF/2ybbdYJp+LQnCkKo/a/WsTA4MV0nfl5/iYDT09kueGuVaomTwrmqbiSBo6AGbXvQIvf84I2Vr98/By2du4dW7aDJPvLQj8V8z+iQXmNkB3jOi2uuGm85cIb4R7AgGK1WtHkrSovUWM6d6hPJ5cGOLqca0vWFXCbtqrl7X9f+2Y22+iGKUC7EewlY5Ni26T2zRSQHDpKXzDD1kRVmBTPPLBsfWOgq4n5W0ut1bpmC60JAgEk81dwmoeZLsjM8pdYvaibCI6wkxmBwokQ44oOWc8PSonEP1tyIYMxqwhaOF3AlCkgTD8UR4ZuV84LlZv16hu5UmBsqbUCF/S0zcmxlDlk0kWiiSKhWo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199015)(6486002)(186003)(2906002)(2616005)(38100700002)(478600001)(8936002)(4744005)(8676002)(7416002)(5660300002)(54906003)(36756003)(66946007)(66476007)(26005)(6916009)(316002)(41300700001)(6512007)(86362001)(66556008)(4326008)(6506007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RVCC+Y5DsYv9ZZAJJIWSIZHyi+inK8+2T7Srm3l5bPVO4UiGUSrUqkgEPMA6?=
 =?us-ascii?Q?U1gymKWghX0YLcDkpqMeEUPzXxn0MQIAejEpVxs9dsbA5B7MfMj8nBlMyykz?=
 =?us-ascii?Q?EnD2grKSazY2OHYS0AYTvolbmmwhm/de5TYvdhrJNTLJFkD+4boAYojxnm6G?=
 =?us-ascii?Q?IDD8LuOmXWYYT6QxF2psBzP7bP1zwBkcnKsWhnKPEqyyeKvzipiHd+U4dR66?=
 =?us-ascii?Q?G3OxBenTPlptoyFWinLAu2EbQsGBSykBNxMquhkMUrzLwjNsWrvNa49upuiI?=
 =?us-ascii?Q?EfFxr+3ZcZu8CI+2k+0g9tGS88ZGdtgRCMcwzCRLVC7UBgpaQnBb/5h37cqB?=
 =?us-ascii?Q?WaL/3jHCPt4vhRpsBMlIiHMki5wuJwUFGeDhELKq/bnTlpVQxPyK/R5uGiya?=
 =?us-ascii?Q?Qzbx0grSq9lkE8lDtA0EYmlV0QPV5SWaGT6XjmQs/hl2Xpt/W/KGJo3s0aSc?=
 =?us-ascii?Q?65xlTnRC0CC8TkwOJTQ1gjux/nKfeE5y3rMwS0T6KqJJVph62P/7LEGLT+s5?=
 =?us-ascii?Q?W4kHnN2VduiaaezJAvYO1kUkRMQttq2TFcIE/Lny/m4fQGh87eVRYfUQ0HdI?=
 =?us-ascii?Q?/p6lF42aL9f5t6jyF0DhjBtw94JKrd5ofio8Y/1C13hd29h9cu2q7G97kFbo?=
 =?us-ascii?Q?qnnQ3C/+MYjotk/GPu705xMfX6JpNO7EaXjlDIIbr+dnHtyvLEJKoI2bgEGJ?=
 =?us-ascii?Q?6p726VMSjHXVAjNATdMu8lKowOYvl774ef7S/J4UBLVNkkLS5JpCvGMEH3Xg?=
 =?us-ascii?Q?STA6WZFuIyXhplq57cB+5GiJfd/6E9UdoNyOcqLRqiDp25OIgrRnco4rBfFA?=
 =?us-ascii?Q?aPaZlFTEYfyC1AUvAAyN+LPElB3Ug6SYYOvXzxK63hRtMwfWJWq2ab6JuN6x?=
 =?us-ascii?Q?iftLfKhC+dF4rorYkUA55tAdb+YBr81lmTYBueNF+G7F/gYnjECBFyzgj0i/?=
 =?us-ascii?Q?sHyd7WDE8N74U53tW0gnecmiTrAKpEu9AEJS8u3qsoKZAnVgVm+LzKCxEcmH?=
 =?us-ascii?Q?GLbhgzdPwGu5ibWt8tjqf3QkcXYsn9EP9LkacPuYKkjF0o+rX2INJHEKFa8/?=
 =?us-ascii?Q?FjjCxy1FuehLsNSir0glgy/WO6pa5uhU4RJQot1hHbU+ssdPhbDx41pjsuDU?=
 =?us-ascii?Q?Nu/4C3+F/JR5F8X+SG3ezMx0FeAezISfX8hvchZEm9kqRrKHPy5ahaNU1G7r?=
 =?us-ascii?Q?gc68e8iVEpavHkeOa1U7rhaHoo7m6BiulHxqWbWU0uVhyuwz1ztfhaosnTgr?=
 =?us-ascii?Q?rgLn/PBZeQYKW1OXfuD2gadTkdXWWAK3IIq2NhRIYZyhfJ2U7VEJpLv/3lIW?=
 =?us-ascii?Q?HJwfsphr0BCdgY2tg68qgH+XdX2M8XKb1zmI9Hpe8IB/uIJvN64tE6h8U4L8?=
 =?us-ascii?Q?3iZ813ZbAdKCQ5LIMAtQ9MppHWpQfqtATqGShOw7f2QGfQ5Omig6Zw1kM8Kl?=
 =?us-ascii?Q?LouBQSgIbzgiZug6f/BIrXmMgkhvIKPWVzaJy/Gaf+yc8jaCG0+T2UfvQHGT?=
 =?us-ascii?Q?P3kgl5uVRZ3cYaBr/QUu5jIBsZroy+WTbfvIFJVlFmpyxu1rQH4CJhOk+DZ+?=
 =?us-ascii?Q?XfKJdG8thp4Sc9Ez8EQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d814c4e6-1e77-4901-82ea-08dab28afb19
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 11:05:21.5736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8r5UZ7g8+jAPWsrvTZf0pvDC0kUcRZsfHc7YlZ0e1lRIyBWud59qSim1XFcDnY47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:51:10AM +0200, Niklas Schnelle wrote:

> Ok that makes sense thanks for the explanation. So yes my assessment is
> still that in this situation the IOTLB flush is architected to return
> an error that we can ignore. Not the most elegant I admit but at least
> it's simple. Alternatively I guess we could use call_rcu() to do the
> zpci_unregister_ioat() but I'm not sure how to then make sure that a
> subsequent zpci_register_ioat() only happens after that without adding
> too much more logic.

This won't work either as the domain could have been freed before the
call_rcu() happens, the domain needs to be detached synchronously

Jason
