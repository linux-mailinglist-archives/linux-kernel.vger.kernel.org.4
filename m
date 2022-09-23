Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F055E79E8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiIWLqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiIWLqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:46:09 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F377E121E6B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:46:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cvfl9EpXE2ida4EZ38789IRSj1VRYrE45+uPwbQkopFPi9bpxnrrOy6615jY6aIKW9BesOghIqeGTSQwS6HukGqJo5oJMlVRpRGQt9qqnbOfj42ead32Ulu+7r37RKmK6gmVHwbauGKox4UYyKMQrXhOl15hRaaqhVktRXuGk0fxPlpFk9vfidG7O0O1tH1S7vK6OeYa+fLwbvqBLdasjyiVEAlx+2mm8kS+P+o7xf13RzFTq9eMdE7GX78v87CvzGM/FmUvtW+y66E7b9syCYlXDc9nU4E0UVtxKxcYopuBk5w26zX0ie4hv6ZXoxTCAS7rZtOfpWoD/rC95DM3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFHVlGciwcNctCI1DNmhA1Sjv/Pp8i9h28tq6seHEDs=;
 b=OutkO/iMTxSZyezsllwr6fukoU15Giy4J3U8GMBXm6mwU0GOesoxsjzK3eJv98388IaM3VP6Nz12fI5fyNBSnPk9h73HpAzo7ZBLv/GBkIl48zydGR6uIOZyhzIKjBso7S+ed3/XhkYisoyeppV8mq660lDiRfYcParm9uuALIS3g+x1fLjCXr/lgEd18Hj0uGLhJDdAuUQ+9tzD/9+A/CRlPN8nck9cR+NS6owF41F++aDVFCLKjlvsqlZfymYe0N5UXBGBQlOGWWcPX671e0MXj6y7EDxndLUG0uCpOvSSXjioEDsy14llRGZUmOt/kW0WX2edJdBBPIcklV3Z3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFHVlGciwcNctCI1DNmhA1Sjv/Pp8i9h28tq6seHEDs=;
 b=EG+SIWqI69P/8CqUMujWbuRQ1L7d3i7p5VUgNvqrbfX72icOeUXduGIDXvM94rvw4WmB8yju+8ibSGkorp/RgF/RKf6Oy26nSRlEZQ7cS57PxlWZ9ypdMZOu9m8m5GN8Ty+oJ9H7NAMw5bgj7b//h2tvu3prs8CvgRT4NLOCNqpx7gVROoc/CDdlwFXjeDiyKdJm8pUJe2JDyCyU9WNClok5gqxq6WPkHzK0Ia6nn9HagoX6nG9Yuty9oKWGtd1CsGriQ1dULgGMcAkIap/vcYUDUi7yjsyaJhY7s+bCAUkEyoleug0B/bYy2v1DhifUzD8rlKJUZow3V20xy+JHhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH0PR12MB5154.namprd12.prod.outlook.com (2603:10b6:610:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 11:46:07 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 11:46:07 +0000
Date:   Fri, 23 Sep 2022 08:46:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <Yy2cfppqkf85hPT7@nvidia.com>
References: <20220914165116.24f82d74@jacob-builder>
 <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
 <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
 <562dec4d-a39f-b517-58a3-45f691a2d10a@intel.com>
 <YytFGqv5V4T8lbM8@araj-MOBL2.amr.corp.intel.com>
 <f1aac14e-380c-f76f-84bb-fdff56207d2f@intel.com>
 <YytT1hfRZdb9GYQK@nvidia.com>
 <20220923004239.ma2gfrmoezsff4ro@box.shutemov.name>
 <Yy1D0dLdqTr7ya71@a4bf019067fa.jf.intel.com>
 <20220923093826.kjad4qe3clwybeh6@box.shutemov.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923093826.kjad4qe3clwybeh6@box.shutemov.name>
X-ClientProxiedBy: BL0PR0102CA0019.prod.exchangelabs.com
 (2603:10b6:207:18::32) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|CH0PR12MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: 36882971-4542-4222-dab3-08da9d59339d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/M3u6KZgZP4IeHUwCVexvayJrnQJH95DQG5BeF5nNrv7yB9ZZJU0MnNsT0kS7N3cv0+K+Zx3Qt3s2sJcZNPXoMUYzHmMUN2S9SCpyReh85qbWAaqxBWgtxIXNbg23caBGfQI0peu4+FpOQA5SfcdSaPQbsYX0RARHYdfzJ802x/ufYbHDx8ZkshAE7pQcCvFLtNyMZaDIgPWBZ10wUOQidvjFgVMAlGEebwge5fglVy1LSreQOXxuTM/YtCnh84nY0+oJnKE1MOdYZqeU6MtIondVC7M7+rljU7KsnfIMBBnRfQBM8Wy20pcl2N1hjMUjptpvDL07xYXRx++LkJKV3OOlTdwbK6xcNFoUAWvJN8c/jaC3huCSzEAYDxziWoby7QfrmW0u5K7Qjytnlvi9254nK/9lUIZtpSz/p1/f6jvR3PnXN0Jh1U7jPYc4nPcswiz88MCLCmBLyQ5cahZaeIBKo/Bsh0DuOWrXOCzvY/O3Sc0WJJBwz1ZvjeKLjwocN8evLs5DDl+5nQ8V0EFbvyUr9WewBcVV9TehNSz+LAVYILKq7tw7jYlXcYoMqSCLJHx2vR6E/4rkekY/QD6N8yD7RdJyxT6SdL7Tr6SwmtVd0mVmjgqyLtWVO6UqD8jUc7TjwLZ0bMgDB1GigT3ZUDWn8899qW22aJGYaQGU1pdwD7gWXtWG0S+2Q4N3fvpLswBJ+CN5z38pL6yI9KEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199015)(2906002)(26005)(6506007)(36756003)(6512007)(186003)(2616005)(66946007)(86362001)(5660300002)(4326008)(8676002)(4744005)(66476007)(7416002)(8936002)(66556008)(6916009)(316002)(54906003)(6486002)(478600001)(41300700001)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TFrlUHNAIo0cpGyGpOtNgxaahFOVReOFVaLjEDpN48v7ijrzELF47kb4aG8N?=
 =?us-ascii?Q?94S3fIPeyaP4nK9TCWiBnIA15mlBcNaC+vdTMOe23uTigZc5s/dKqyBlJ7cF?=
 =?us-ascii?Q?Fc1udtJjzV7mVYzIRBqsRFvOGOFmC7JFVXooir4jV53AS48+IxC/xk8w/rwJ?=
 =?us-ascii?Q?cZywQroLKEK3SKbfp4NX+7q313lj85OZVOnUm+4ugvvyG7PI8gRAHeq2sPBa?=
 =?us-ascii?Q?0NpEPS/s3XzL38LK+2Tv5QfHlrp9NkBmkajIjI3D4wi0sbnN/qUUXG0YWMu3?=
 =?us-ascii?Q?o1ZHiUwpTnyYtzwkQT8qjlEaistsLOu6NcLP1Xm73xA19oqioHb1+fDf4Jzw?=
 =?us-ascii?Q?s2FDedLcmJLS+QtIcwUNUwg6zq9mIserAUY3swBn+PEdNc7lLF3q1gmnyfAV?=
 =?us-ascii?Q?1+hKHLDjkW8EXc4Kyw3z+CbLZlSyMWo6lOcpv/WxMMHIsp3z89EA2LFbbXNl?=
 =?us-ascii?Q?zc8vr0wUY/WkOnUrrcEl1ao3I6eFyyEdGKPxRfXu9UsxrPMq79G5MUVxhJcu?=
 =?us-ascii?Q?EI2AshRqxiXDdu3TgGE8beUb8lxaD8T+mVYwKJliU6yKnbynVMHlK+T2xldM?=
 =?us-ascii?Q?smoQn3i0w9T4x/vtF4F5XogVSRCmGZVsz0KZYWTi4+SAXmJK7ORbGwgxbDF/?=
 =?us-ascii?Q?GrQyzIi74ifNXLE/MGiXQWGHQP/LSrxnB6HxdvPKX3hooXFuwN8zw3Eo4+Jf?=
 =?us-ascii?Q?wy9v6Bz4vUWnMqaNT5ULQe72TXLIJefZ2BtCUsMSroceYjYl2wJ5miY7TSlg?=
 =?us-ascii?Q?A8KG99FV6gx2TQNmPi7hIT9djD7frCfYBkFNS8cPAh95xiOuiSDAfNT0csGe?=
 =?us-ascii?Q?g4qJaer1FfkdI4dk9je6S9dI6t21YBfWjNZEyDpIa7CmKJYD8S7R9sORD/9k?=
 =?us-ascii?Q?DaiLUMBztYuCJzas+lo9NMitTfszmnIwMEV1nQmCWjtdGlzdui03qnQXo6H7?=
 =?us-ascii?Q?VkLUxxB8rhuW+SY99wPrVw/BK5mwZ825q1mPkDODLEUled9kKc2VbUtdAl1r?=
 =?us-ascii?Q?FvsOkDKhvtJYt6sB0896QrkVdt4EcVdzwaVfXSjMTvkaqGurjT4boMxUNzxe?=
 =?us-ascii?Q?hEyv0kYLzMW5/g6Bn+MUrBPOdQI/RoWO2oEpLtGNtaxzLzpnTUH4V3TEHptz?=
 =?us-ascii?Q?0OWN0b6qHUoOUSpQFBaJHJ1GCI2e6Ne+QPKtGu1hFgF0her9PIY+5gSKceUa?=
 =?us-ascii?Q?qpRTqnIpu+c9+TuKUvsTfdpkOUQNfHC/2zF+2cCxJJsNZINA6r6/YQoGIhYQ?=
 =?us-ascii?Q?YYjFza8EwAYGw0eKNMwZWfsPBvUKTIELBudcXA6bBB6fTq+3rFF7zbxjYlWc?=
 =?us-ascii?Q?DO/xiG/aUfSq/Yg13InpCkcC9QfHvDWPCdsXrR8JvG/RYx6p5/yvgaFgMUAk?=
 =?us-ascii?Q?bmKvhHyek/d75J4Kr5/vOjFRti3ZXk+TdzWAqJltC5Z9rQ0U7JPWPX9nnmib?=
 =?us-ascii?Q?jhBNwThgL6y0/C8uuHH2KPNau0dStsmnywTkKAeJPhVsnqb+w9RG8bSCA0un?=
 =?us-ascii?Q?z9yighDjEeVv7J5AA2Nr4xbLihAWdo0fFWhK7r1Bj0a0OQMlRO8zq6q6g9at?=
 =?us-ascii?Q?3b0oVnEMeWemluBm7sq01nhRfPFx1B15QjUD2kP/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36882971-4542-4222-dab3-08da9d59339d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 11:46:07.4354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iy0yHSnglChFp7UB4d47GwYIVDvQfjERn7PjYIwnYAbYrbcs29E3rA7nWxQtIsO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5154
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 12:38:26PM +0300, Kirill A. Shutemov wrote:

> > So I would assume an untagged pointer should just be fine for the IOMMU
> > to walk. IOMMU currently wants canonical addresses for VA.
> 
> Right. But it means that LAM compatibility can be block on two layers:
> IOMMU and device. IOMMU is not the only HW entity that has to be aware of
> tagged pointers.

Why does a device need to care about this? What do you imagine a
device doing with it?

The userspace should program the device with the tagged address, the
device should present the tagged address on the bus, the IOMMU should
translate the tagged address the same as the CPU by ignoring the upper
bits.

Jason
