Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5BA69FD4F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjBVVAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjBVVAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:00:52 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2073.outbound.protection.outlook.com [40.107.6.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705B42D173
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:00:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5AUz1X/ggpwaRVBh46ooMv2VOGagq1OY/cgzYw8JNMK3MZBG8In5at+U0k7GHQXd9I4wevOZvy9eWr2DVSlE0+OXXgWev3exc/1DraxWaqpJrODVKDRPXuxImcDkw2sSgpQbM8QKwcOan+zobuV51ZgihmhNAL2myGf5OuO4OZuuL0Ls3iCypS2Q8qOGfIvZpPJ0kfLHn4lS6zaR215vZGid7S1icXZhH8hNQnFOh7rlIsdoo9OHvEivUp96Tb1jvqv0NUqsLJNchptW5mT1kbd4JI3iry17Q2LXx9rDR5ZQYE8GXgeqpCClfoMICfhQxiJQUVg2LyPSXGORFs9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JglINDcC2g8EKU8dkM3LM3jaa4aDlLifRKoV3LV7law=;
 b=cgmIYQu8Xj+4UYR7Ajnbtt//xYK3fExPi12qexJyr6dFca5Dhek+GuaiI21tR1r/BERXZZ1Zv/GH+gnNbba1YZcQpF7MzUOYAJDnIGnANLdTlFvq+u6wUHhVPBb0bkEhNgkLljm3tRm7sqjtLsUwfaEXWnX/eBIymTruE0xN8gATNhZxUlf8iBP+OrUI6/DR4d/7xYIK3uUPjg3PmAFNcGZsbEBvixpwJnoyz126IULPbs9kwHbXYj9QUwQZFXbbnatMJjGAdGvfVKuSdFW+vHMValLG319orwaGmKSCALr8x61YeuR6aIX800xF9kThGS+OlJ3AossqN6t1BYjjcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JglINDcC2g8EKU8dkM3LM3jaa4aDlLifRKoV3LV7law=;
 b=XPpiIiTYKbDYy4ySpqL2c/hFFoYKwj8PJplwsL1A7XwqDktazo7DfDxabhLsJY//DqJypAm5Kr2+t4wuB9e0y5kOSzlXjcbxLwR0/NOHkPhVGgYuAApWsZyHt94QqyrcTgU3WfpmxncC96qLGhT2VSrmwpVP7xDMhlYiwj3vZcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by DB4PR03MB8657.eurprd03.prod.outlook.com (2603:10a6:10:387::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 21:00:40 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::6852:2e66:e605:86bc]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::6852:2e66:e605:86bc%6]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 21:00:40 +0000
Date:   Wed, 22 Feb 2023 22:00:34 +0100
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stafford Horne <shorne@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v2 1/4] sched/task: Add the put_task_struct_atomic_safe
 function
Message-ID: <20230222220034.02c38eb3@nowhere>
In-Reply-To: <20230222184237.hkfznxm3ts3gye2i@fedora>
References: <20230120150246.20797-1-wander@redhat.com>
        <20230120150246.20797-2-wander@redhat.com>
        <20230123163002.GB6268@redhat.com>
        <CAAq0SUk1vfNDuzGbXNftgW4wq4PC_EzMhpq4E=RBQNkOB3f4YQ@mail.gmail.com>
        <xhsmhbkmkdla4.mognet@vschneid.remote.csb>
        <CAAq0SUnUH6DEjwEs2RxRCtkTU121JXpdsV_rZky1d0Bo04=fiQ@mail.gmail.com>
        <8632d9c6-7ec7-c3aa-f9e7-fa63cc82f6ae@redhat.com>
        <20230217200437.551ad7c2@nowhere>
        <20230222184237.hkfznxm3ts3gye2i@fedora>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0028.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::15) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB2880:EE_|DB4PR03MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 568f0ce4-ba62-48a0-2dfd-08db1517da5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hx/fPJpq4MugO1ukoHR+3nZwsfnPxbIupvWtuwpK+9NYJYWnsw/DRBFbP8A2kobWYqAgFpciIv3ypVlP/HiTVLEat6G+rpSkequkYwV76HCF+eQ8rkHISwlzeV+qlOEpzgTeNkzaxQ3LjZkZrGBi0jUnvjxOPALOCJBgcbyneny0ZoXyhZtNiXeSWDKvYFT47s3Ge4HO6LQ1sGXEQbJbWv1tC/qyXQ4les69uFRP+n5iSy3T+Prg1aEXFg0WxiJL2gDEwv08ksMbzSG9ckkRCuyAQHCceYgba/kNQo3b8CoOoCxTZ6GX/IGHDq2wB/IqwKE634IqocY4qlsUj0xXnhK3Mgv9jCEqvZ0Brxqt6xxs+0RhOFztb/IxXAW+Bb3eYy0mirJwzhtiBT5xm4Okydb3tF68Ei17N17R7PQ3xU/DUoQ4PDjBpZhpdSuELZUnVGcuEglA01yvwRAeB+nHz9ty0V3+KUGMRjU1pCVRmQMYGJSE+/NgFSuy+N5CXcsL1effes6HDn0jJ17iQv2B8RQZUzvVNrLXkOenLAlKDEG3axOnMwPmxJVhbMU4bz8kK9YCt+7z0JM4x27IEbLknlFlO3OcIBQx16ThoW+HO8CnmN1/FpRoAugMRdh1aYgdE3NKb3FsmxbxTpbhVHCsDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(366004)(39850400004)(136003)(396003)(376002)(346002)(451199018)(41300700001)(54906003)(9686003)(6512007)(186003)(26005)(786003)(316002)(86362001)(6486002)(478600001)(6666004)(36916002)(6506007)(1076003)(6916009)(66946007)(66476007)(66556008)(8676002)(4326008)(33716001)(2906002)(38100700002)(41320700001)(7416002)(5660300002)(8936002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i+curt+A8cqmgH/gOql5Uledwr/YymoivvWddWFt/1ktIfu/WRl0Tlmd/Z1v?=
 =?us-ascii?Q?qXNOSNSxCiD49e5WYSr+kvJJJtca1KHen7OygzUp+i7scV39Zg++JW3147lq?=
 =?us-ascii?Q?YgkB9O7ms4T6iHWFry3GWShnI2E8rbGlwK6/1mYCfgI957Nm3UXzXUGJblPH?=
 =?us-ascii?Q?6Y4zB8GUz+8DSMkZ4rZustP4cijHI0+YnsP67+s8szGXwD1ZuXqTthL7MG80?=
 =?us-ascii?Q?Ykn0cOczd2NU8yc/zSgkULVFvGZSMbd6mFFpDhHjsuibf82KtRr71rKSXo27?=
 =?us-ascii?Q?48UlQOwJQga185WUl6nNkNjdPoEXKEQ1nQL1chv3ngjh89H5iBAQmGQ2Wr+U?=
 =?us-ascii?Q?ucsTc2PhiTu/AySxkGlqUsXQplwhk3i3EZal5W7IpJhKg+uHsYiTV08XPsb9?=
 =?us-ascii?Q?jCeoyzzeo3/lukZwSRi+sGfQlcfzE21I5ZwFqv9wuemldf8v2X3Rgn8Jd5wK?=
 =?us-ascii?Q?vnWwTsd6rFC2mfk/MMnhfmIkI5SMSLzdhdFXtpR1alO4kpuDQ1YHXCmQ+8zR?=
 =?us-ascii?Q?bhPVqP9jnwXT5PdSXD9yw1/bA5Xdq383h+2APP7sUNq4sEUj8efgkYykI88p?=
 =?us-ascii?Q?5UNVukO+nWltdbrXZZd9MTle5Q58Rag20w+WD+LTlufSFzYN7E5L4gkuvArx?=
 =?us-ascii?Q?Z2GSU6JU+di4luipQtbJFYKso+UqLEJX4i06YwlzBVj0W8Xfo9SuhCMrhYl3?=
 =?us-ascii?Q?dFToI1olbX/IqFp3xPftRPNaAvIL51KPCNjvzMO0SZQSL8IzDqKezhssmhGp?=
 =?us-ascii?Q?onrmo5WWuZdFTjs4PbssdI10e5Lff/OOghzRMNgXyZI5DQmf/NzUvMDMy9jl?=
 =?us-ascii?Q?knwZyEGs2G57UGnmc9p+jgNL5UTxgRtUeedZVV+sCBfVZ8jIBHW0iYOz2nJ0?=
 =?us-ascii?Q?onFu84EtYR0Wh5ZnmByYxXbtfNQ+HUeMVg0z0p63Z4GZuzh5fvt6llOIhEwh?=
 =?us-ascii?Q?A9Dq+nd6fw/B+5OdI10xViDgybdLYOgA4ysaTF3iRW7y91cTEN/E7ojPmHkR?=
 =?us-ascii?Q?J/8RbTkS3l1bPUPA0ox52HE2cwh2z/yaMCYPcjHNFZf+pNNQvkSWGimRQTSN?=
 =?us-ascii?Q?O6yz/NLncb6zYaEejwhFTWdLBPlorKnqiia0hM92Y68JbGEdo0Lg/32xL8Ot?=
 =?us-ascii?Q?Gk/ymN3vcTUWTnuNebaSYG87R7UBXoKF+gTl6OLE/2LMbtrtHgQcjy/vOWfR?=
 =?us-ascii?Q?90ZYo9ZsvvCKv3tDySQ1CbP1tkLl66J3CQAeB26s4y09i/75BW9o/Lgv8X/p?=
 =?us-ascii?Q?Xt3wmrgOj8j8vBOoyK8SDtwRsqYmdkcr8zGcyZ2Ra7gvxeSBLnuz6sL3OOJR?=
 =?us-ascii?Q?h0h/sAJtYg8yotPbqRC6ZWI8+gfeDYHkMg3IL+ZjnPB4xR9ntd/lqXGByiyS?=
 =?us-ascii?Q?5rg0fijztRYFmbnOcSKoe2PpMLz76M8jRSBBs3fa1d4pY1NVjEzj1ngYmprL?=
 =?us-ascii?Q?pL2TXQa/nbZA9I0R5cUPHdX6WC1f4gf6ObJL98WQMaPxv9h6EmUvn/76KJYv?=
 =?us-ascii?Q?32LAzdN938+xnBisvfTDzfIDNJR56Ig3ZWxwo3hjsd3WErjq9gctXC1f74Gf?=
 =?us-ascii?Q?RerrE/ZJVpxYIFNUI6yEiQkSVgwZUELZop3xrjVepuBy7ppmKUChJERQnvm4?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 568f0ce4-ba62-48a0-2dfd-08db1517da5b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 21:00:39.8646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+91IwurTTpAzWSPiqYSvycsn4j/4j1hmZx3zhDecDOVLIxb/9owP++s3ek839z3hOnfwck+edo3rrff9FEodQZtKHwpim82MnhbfkXcqGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB8657
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2023 15:42:37 -0300
Wander Lairson Costa <wander@redhat.com> wrote:
[...]
> > I triggered this "BUG: Invalid wait context" with a 5.15.76 kernel,
> > without PREEMPT_RT. I can reproduce it easily on a KVM-based VM; if
> > more information or tests are needed, let me know.
> >   
> 
> Does it happen in linux-6.1 or linux-6.2?

I only tried with 5.15.76... I am going to test 6.2 and I'll let you
know ASAP.


			Luca
