Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AB16161D7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiKBLiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKBLiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:38:08 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB672792A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 04:38:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJSfLlqrqlICtI+xwJkHGAJ67gJoTuTcYsfk6Z8YPuJnAOcxPUuhMRRzeu6+vfdJXeWqz68Fd9Q9tFP/cgY/Rak2S+z1yQIbGgRGCAD8Uk8vidb2PwWMQnf1d4DYZS/TBykDRbQCeWwdS1fnrp3hQ8Ebj0Ct8FaxpyKnINz1rEAYudkCn1UBmVK4oVT11ImvF127HJXwrDaRhiBbw+K+DS/PFX4vg0P2UROTBqLQpSb/Vg4gexZ8T0Z2OG2ozwM9IIvYoMF9bwRkBleLBTRcgUPPMvcO6dSVUyBhpGbmgfGKnnJ9dmG5uFMMtNcvexHUFRYt/YO9M4XnM0Ftt2sKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKG1oIuEt+PzoLQInRpuTAEcD65PyVHD2dEoeHN8h78=;
 b=LvO7F6yw3/yLAacdIPEdlXDkwmyVLaBdkKX3rBYM5vypbWxo25frP1TIIZnAksizYi2EomLtVL2fm1sVxAxMjFguWyQDUHD/N2YgP6zk3ACxQyF3kTrEHzSa8O0E4/F7AHnjVRBw2niHIzwrkK0Q36coM8azy9IiyndwBZZ3L2Z2WUCOzFqYCPKLtjAdSxtCUIwC7afIdCSSSzJECn+GSM/HXIi9qBk1I4o6cX72HEk1SZKprpjlh1An4Tlh5W3CezQG54cPeMDDAAW9Onau1W00oyRa4XI+4epspZ2NRIJKjGaVHmkvB+X/f4fWHRqDoEJtaGKSMxwnVrwRfOlHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKG1oIuEt+PzoLQInRpuTAEcD65PyVHD2dEoeHN8h78=;
 b=mqRweo5pROHE0gxU5Mtq5cNXgpKyBZeMIGezQKBwHJ8XxiBP7J+d841JWRpKAaeHbrHKojFFdeUnp0JnOUxsHWoRulpDrhUd25RAubzzXWZxTUsOup+A5wCLi3SbcAmJPc3+PwC+TJTV9mR8+sjhFlyBstVPO7x1u4UOBZpjDDfkD47Batn+0n5MC7G4gy/w3D7vT75PQa97ZjpZCVvU679GFHhSQ1OCysTVnfDDg8mIWvQEW7+bgkNLL2Mnur32GccP7aRikDZdPDVc7deSN4SjhiQ8TnDc8WgVp9W9CeVvxeRhDsVyK1RZ+Ty1YUMVwhBzxLhKe1EQEX7ot5y9tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 11:38:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Wed, 2 Nov 2022
 11:38:05 +0000
Date:   Wed, 2 Nov 2022 08:38:04 -0300
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
Message-ID: <Y2JWnNbE9SC/4boX@nvidia.com>
References: <20221031152524.173644-1-david@redhat.com>
 <Y1/0e12ZJT6+N0kI@nvidia.com>
 <13c0caee-82e9-c295-b1b4-6d2bff132b72@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13c0caee-82e9-c295-b1b4-6d2bff132b72@redhat.com>
X-ClientProxiedBy: BL1PR13CA0274.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4572:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cecedc2-85b1-4164-b674-08dabcc6b50a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ea3k7f6ASAWEmxrXnH4JhGbomuXbeW8GgQkNQ9ClYRCu7aOYjTwE6PzuSM2ug1F82b/iziiLsWxSxb9n3/Eq1smZCgAAHMMhtGVLiaMBpo/qf/pLPzJHajvXn6x2egCWj25c5ewERWqPiJ3+tieIU0Eat0zKMmNT5cQ4c7pNgNlr/fgd1Ak2qLkD+pzT8IqNeVevLDEolQGS4CYuMnSJX1FvSwWvdLDPZsMeN2Ndy5WbDaYurdJkhpd5I+JYrzFYCqg7xV5PK5bjRXkC25MghHrQfkkiJ7Ct7wTf8wjpcl2GKaX8q4vE8Naz/gxmuYyKA8kJSAfjLU1CLVRp3S4v7VxoVTKJxmt0vdsTN2ZhZGPkFnsuXClsaaudDYg+X6ODkkPdzkImaJiXkc8sf/R3px4rC/Di0SABwxcHmL7eCVv24fRNML0jEQCQAoYeUSWbQwDmD3dmUDDK8H9Oa8wwr4BMZqgxy1RQuOSM6AjO9e5s+IYLKgNbhrlbJlIeiWkGJNUOTgQRI/GQiXmyVnmXwFQo9kD3EZHmhyqFuVZ/mHoTNqo1lkIixyl9vMLOHdcG8szxnFZdPnB7IT6/oE6ZF7st6M3i+Db/npH+W9Hy+JDDSx3pMALMT0iag/aoTdJfz9reACJTxnASEUp3Q6lDUY4QVYwwkQjbZ5Dyx1g+lDVSl/pedCfmp85A3N501aQZiGSiq0uIjnGW4FMtT7vc4ahJa9Fuf53YjQuy62H4/2vpM8ZhgfumzcxZgD2nCRc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199015)(83380400001)(86362001)(38100700002)(5660300002)(4744005)(2906002)(4326008)(66476007)(8936002)(66556008)(41300700001)(8676002)(66946007)(6506007)(186003)(2616005)(26005)(6512007)(316002)(6486002)(478600001)(54906003)(6916009)(36756003)(83133001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WaYTzXsoz88I3lSqR5JGk/+taZAcPf8+8m6VX9zMux2igX7n1sL+kO4JSt1/?=
 =?us-ascii?Q?Xhz1v/EzuUnCJT1VlVvdqBbEJMG4unCCTnLu+YHUew9icLfmk6fdcP/Zm/MW?=
 =?us-ascii?Q?+ZKjyShoxL8pO2Y0sF8NY3o01uPCatH2USbgYMDdlURsJMl3ksbteDT5Mnjx?=
 =?us-ascii?Q?vj6ebTfgaYH8vTtts9dF470OEvyS6PizfRYmQUrlTTHIJGq++41igRudETAs?=
 =?us-ascii?Q?7ScRSIxLJcXaiBvZiZprC69xjKntOdnVXVtSE6CwES8VbauR5Ot4yxwwVwLh?=
 =?us-ascii?Q?X8eQdsr9/A2iEr/qw6mP8fKofD5C/W+elJO+WZbj0g3TNxBdE2z1327XewSj?=
 =?us-ascii?Q?EMTM34amGt41hJXrr6bbDydC6SKiNXMYrw3wewj71zXhsoyi5iR4cRyvP1LO?=
 =?us-ascii?Q?cICGwHPI1U3FB+4FuSipksv/lFT4+zpC1BawkLp0RIeA1EoyNSYgSPf1y33K?=
 =?us-ascii?Q?O24EDThzD6xXeQefPflsDhmOk2akObX8WVWqNkbhIGKdYwYA9fKXE+UgzUTy?=
 =?us-ascii?Q?/e77TL1aqjbZPneDYOQLRVlvk/9PJcM9q9m/UwXvksqCL0pn5Mb2nTB1D5iJ?=
 =?us-ascii?Q?CM+gGXT3D2H1SIWtci7kMtSFudEAS3Kdo6XMziLku3L1duupVzsWF5Uota8t?=
 =?us-ascii?Q?sSPUCepkpgJKVNknEmtRazn29ZCVXiPwZJxFd4du9ktx95qR6MFQ/P7YwDmC?=
 =?us-ascii?Q?cgF/JtSrpTziqYFgdnd+CzLudzEuD0zZKvlQyjtU5CnrvJY/aJNv25SN4qmu?=
 =?us-ascii?Q?DPb6B8p+6sS9kUjfOEGMa8wKumj0wcJrfGowu5hEZQq67QWCD7auUceoYwwQ?=
 =?us-ascii?Q?g4jMGN4njInHA6vAUbakWyIKcydqyuVJQDNnzRorUhG88IpaID5XYDTLSJI3?=
 =?us-ascii?Q?K+Viyz4aINcA0avtcWX6avfgDC1UBy/eXFi8SA78rk5vpQduezQ0JwMaAcs5?=
 =?us-ascii?Q?DPXOd8B7A+s28Ze2kLm+iq0VxB5kwB2hJPQr+Sl+ORt4/Arr8tvsoSxdeq0W?=
 =?us-ascii?Q?82WGPCB3DAuxsWTxzaX6u4f71+88UkXrAJIQTIxrTLR3oIhf0B0tzMCiHoYE?=
 =?us-ascii?Q?gJ9Tt5ezoDTnmLmhRBdyELjsbOmuixCg6r/oXlBJmZG/goRstwR7BjH6Dk9A?=
 =?us-ascii?Q?PKNNpZFsUKgeUbs6NQw2nsf4vFWHkARqQ0ZLyqaR+WYDXI506ZjWm7107rph?=
 =?us-ascii?Q?kkpSd8B95iUNz1KD05gJUCpBHifhVK4ie0TGj4V4YBOkJ7GblUbpkGcMGRA0?=
 =?us-ascii?Q?m9iiRK8GOLGuC57qh9uVpJeh1gLxgpXolQsQThKP0nNYpi0UradI+k+q22Qm?=
 =?us-ascii?Q?U69THiKtYgJXpAxN+PK/gT4xsp0ZwPRE3rOH+y4dg7WJsV4JX3251WHmKGom?=
 =?us-ascii?Q?q6pjn/xV2xhH/Pnkr+cWG35yXVrfkCayXsqNdrzByif+lJF8Dq+6JoDqdDlZ?=
 =?us-ascii?Q?tt0t77i/yShjL+CbOGwyr2O8ekhpRmzFcyk29xsMN5i23P9PaQfbEqQE0gLB?=
 =?us-ascii?Q?7iW7tZSXJ5E+gVdZCEbyeAJRKLGqbdqj1Hb3KN4TA7sJvQvaWeSnNakcWPj/?=
 =?us-ascii?Q?BuESDXTSwnJQu/SC3EA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cecedc2-85b1-4164-b674-08dabcc6b50a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 11:38:05.4354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9R3D+6YvBWYx+7LnGxvC7bHL1sHAZ1VGkyxm5JJsmObejmWRzkB+uyfqB/k423Jd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4572
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 10:14:34AM +0100, David Hildenbrand wrote:

> RDMA (due to FOLL_FORCE) would now fail (instead of doing something wrong)
> on MAP_PRIVATE hugetlb mappings that are R/O. Do we have any actual examples
> of such RDMA usage? I was able to understand why this case (MAP_PRIVATE,
> PROT_READ) is important for !hugetlb, but I don't immediately see under
> which situations this would apply to hugetlb.

It may be that every one is already using MAP_SHARED for hugetlb,
which would make it fine..

Jason
