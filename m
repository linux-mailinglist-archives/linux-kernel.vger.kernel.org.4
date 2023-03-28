Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903EC6CBEF9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjC1M0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjC1M0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:26:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0965BC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpX30WMRMsG2h/g3kCjIzZePdFFfZE3ys+NVyxqr5gPAl3X497NZTikpBZcsg9lA1MVESwGqpo/SQCKJ4qcZW/7ZdmgKeTDHqXQPrMvT/Zk7L8RgZZwDCinrW7/nE6ucaasZvUU9fJ7Qo2ubNtw2b4zLQtK5orRwjseIXy+oRqvgpLErCMc5LsaCqxFFXa0jMZJfIvPOh/rQKc+drmBQB8bsmJGSEj6j54+vskI9M7CNf+/2R+w91R3W5d1Tlv6YOXGuTvJeA2wf0Gmcn4/mD1at8qSj/Z8spdL8styf1yxhWivbOXVoSCaNCBfthSmetEutvuxw+2CBw8MmTWUTow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFnT0Lf4GyyJpbIeFRXHHIPmvdpTCGZQUsT2dr84ogg=;
 b=FBIlEOiS4MxefkV2Tj8RS0BzqEbeExF5SXp9ae00EOXg3mbN5yh1OKDR2QZEOmk7QzDnEaNk9MGOxzcbbu7NOpzLUEaeoZ/yjUtZo2bbJVnjvI8NumHV6wBuYOiJI/vwGQ/8b76Up4GQydMlsPKxsonBiWZiiaOv3uxIHFBQCx/7rpwAw1edl6rdEo/69TgEnMC9Nt7jwpDr4Lyw65dfPJNex7GEqMrrPqBg0zwRXwhXFtHf1TkRSG8WWjHsuMdtu8dZAKYrl6RRShu/3wXrJBF9kgr3zKlwh2e8iryaZNE8m8D8M3T/aooYd/C2ezPNSQeFDnD5FE0IYmo3RvUJ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFnT0Lf4GyyJpbIeFRXHHIPmvdpTCGZQUsT2dr84ogg=;
 b=ao3TotDKZYSK1ACMOYzrTZ0genkCJb+C1JbWTxIz0LwIavV2HloT3qlHFmL9pBuT1pXnf6dqr1ju/kLEfrNW1N7K1ZOq52E4PDBfIB+Hp/BEoVSXosIhfwsvn0DLEocU9B9NEHa+tK9v8TN+Ui/TsrSLJhrtMkOfQx5N954ei0c7Qa9LC4I1Rod2M954+nsAFJucQuQudOKgjViFFn6PRhxgzo4qBywRap2WBVFXlk4ahZP45j1WnmgyS02Nns5sUEckgnMD0H0+HACJbWIt4z2bLYsXL+CJcdULTiLk5udU7uwouLAPE2ON7133Xfim843A9GEf7k/T7ncvkFb5Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5314.namprd12.prod.outlook.com (2603:10b6:610:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Tue, 28 Mar
 2023 12:26:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 28 Mar 2023
 12:26:37 +0000
Date:   Tue, 28 Mar 2023 09:26:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZCLc+5/exFTZJMRi@nvidia.com>
References: <ZAtYphmOuEqQ1BiC@nvidia.com>
 <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBhYq8o4gqFZVb6k@nvidia.com>
 <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
 <ZBifWkY2Lt/U1Z7R@nvidia.com>
 <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBmZj2pscX0hx2kQ@nvidia.com>
 <BN9PR11MB527663094F21D3DCF8A3038C8C849@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZB23WJu2BEH0yC/y@nvidia.com>
 <BN9PR11MB52760914939B62A61E5309858C889@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52760914939B62A61E5309858C889@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4P288CA0047.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5314:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b06eb5-7afa-4bfb-4349-08db2f87acbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pi+RqzU72nPKytIyT27Af9B6V7rTPIHl01MjeVb7MP88rbRuTNsOSNNDqpsA5F/11/fariWuwC7DJRgf5/0cFwrTE5u3rzO5GcWWBg3LQyBRWU4B5ya7TbA7z0Vzhj9RFPlVHBsy2zZAI9aE1XdzTsY4zKdq0yGg4C1x5OCGFVFUtRYKsp4/GHT/javQ7vg9hBOhn58N0Wx8dZN0xGzebuDobQG4I+VH7+Besb1tN67+2sMwnh/4l4GRIQG9kMc85YvSKbTCd7GPV09F3GMeCTYhH/BrDm9ScnqPOZXO3/gQngZRzc3PX98GVltwuvQognVQsscjIOVGbdK+8IjZ+5Mxp9SiFm3P45olAxuCFdzmM8F8lwJ91eSgdNNsHoFoSYgW48gLzQZl7TzWWWYzFfG7W1olv4LBbyFQ41fIo15MuMCUXvofuSOUMdxGo4+87id43nFTZZ+qM0Tg9WM1UYIvJ3GeDlB/x9hCB3KvMrN0dMxdlFO3bciUrwbfW2HgXMlaIQflGIrJp6PZv7F4An4ZmliBN29t9Esb9u2TaZteUODwHtq2nLgJNFLBMJTn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(83380400001)(2616005)(41300700001)(36756003)(86362001)(38100700002)(5660300002)(6486002)(8936002)(478600001)(54906003)(66946007)(66556008)(2906002)(8676002)(6916009)(66476007)(6512007)(4326008)(7416002)(6506007)(186003)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bbPZO3abjiSFTGu3aFDTNdwVjlPZJtVWtsJzfJeCwnsZRhhHQq5LMGuW1+gZ?=
 =?us-ascii?Q?d0UfV5VlfoGnToXjww7g1iEF46xNSgy4Y15JsqZhbS5cDJEsqi39iOiTkfPC?=
 =?us-ascii?Q?mmRiQfDrH1fYC5c6UTI1KaDbh/j0L8E4Zg3TGsMO1ZokwwIwMGJm6p/uXhXN?=
 =?us-ascii?Q?Shlx30OQIxjfnfKSMvFzwnexRgzuuNrwa8YqDSgrcbjygXWvS3+Ynh1AwMxE?=
 =?us-ascii?Q?aSZtEQVZ8OCA9Zlz/vZelvEoi2jcId4NKU4s7v6Hr2uLqMBe4drjpD4ispKt?=
 =?us-ascii?Q?Qe/4tBZJLmZtGMBvWOSaR9hXu854IIpY93bIsNTXo4/kl5J3sgRbdu2n9yjj?=
 =?us-ascii?Q?0mc+X71iRIsO0LVOon7YmipX1yLbThIuO79KqfY2sMLaTDfudpHycmoK7S2u?=
 =?us-ascii?Q?WvDrN2Hr4hcFphnCjFOpYB3qNdMkJKwKtvKLeNP5hsKVi8ffGMp7nGaKjLf/?=
 =?us-ascii?Q?LLrCGkIN6cHrPfHTwA7oA9RR2oZXccM0PxgyEh+t26gsZhxmGqQoeUu/HXcA?=
 =?us-ascii?Q?xzP1J6wAtXsZcF491AA4rF9DrH11zgEwcLV2PWNxaIYv0T0yHJwfOs2ZQOTh?=
 =?us-ascii?Q?SYefRsOMFTSY5FtxMI5if/aLBklj1EXnlFP8iDdtVOBRkgHJvEucQrvYgaoK?=
 =?us-ascii?Q?SLiYV6Oe1JWl0zQxpYnBJmMa2Vzw7anmktbMaWbnr0A8T6yFEgS5Q+Ug+8ME?=
 =?us-ascii?Q?TUCxki6jcHl3NLC81dRmauDZfPNd/I/M1ANeFFQf+47N6JL/sBKe2T2uHvyf?=
 =?us-ascii?Q?HhZK6WKZlb7b7fio09LcVWgvDWO6enPZPiFG6QwyQIrQfcz8bMgvw0poLGXx?=
 =?us-ascii?Q?Pv2mTJoz+wFgeFxxjKM7zPjHkvUkz0ubp6l6DiKdMoOFIVLPQsrQnvU3Tu5J?=
 =?us-ascii?Q?rCJpjBGu3yyuDmb1PBnV6/0Y0noxV43VthG231gH1uchbQqu/NLujYQ21H+h?=
 =?us-ascii?Q?3cXC3BTKzkMcGWZLmjQ4qDoxv/pqz+w9pFOV2N2dBnXWtE3873nme98Dgzl4?=
 =?us-ascii?Q?O4JFCTwJp/EkyS5srM26Y486p6yU4AV4WACCM1dqLI+fTtS8OYEmxjumuVoU?=
 =?us-ascii?Q?WJ9NATW8MvzUMZwTWrldi/Tzk4W4WbQfVOdI+gPg0GfPXH4EfhocDxEsdNJz?=
 =?us-ascii?Q?V1z7ohaTNwOan+1kPawfS3AwOA0Kp3XIWCBlZI1K5qnXBmZlN+ADqTHzCHFh?=
 =?us-ascii?Q?rHV0H6pvSnK5+Z8XC558txRHBvnacNL8e3jyVJFqwd6/5T6/3maOyGertDbp?=
 =?us-ascii?Q?w+0Rh3uJ/6ene77i6lVEitid52qeUEx9qbzAhkpA4ZM9RZKpzQfcO9TXbBXG?=
 =?us-ascii?Q?oXzxI0oQxjEGRSFl4SCpQXZpTiHy8Ldb+bBeiS/2Bt/78h+N7nH/U+GoueBK?=
 =?us-ascii?Q?j5WAC/07i8s/5fRyI2jZFzu+yMCu5/giMH+sjkZfWM16yte1NBevo1HjI8LK?=
 =?us-ascii?Q?/QDIOcE2106tNzJENnxS4hyO5q7YxMu/Y+khwZb0roSaFUPxIC5+0LCwW1DF?=
 =?us-ascii?Q?mlQzb9kOndnCOjn1+0O6PIXM3YpQvOQiLmUw4xamE9nOzAJmeYAMpYWfYMqz?=
 =?us-ascii?Q?nnN5QDqR7cfd+M3JiWgxN6Gl6tvGH/TRsXDi8SYQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b06eb5-7afa-4bfb-4349-08db2f87acbd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 12:26:36.9794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/rArlxII7WuPwxZsIxUjgYInc6DCelgfkG+PHQIFFnOJax5M+tHGBwwDEnJQeud
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5314
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 02:48:31AM +0000, Tian, Kevin wrote:

> But emulated vIOMMUs are typically MMIO-based ring structure
> which requires 1) kvm provides a synchronous ioeventfd for MMIO
> based head/tail emulation; 2) userspace vIOMMU shares its virtual
> register page with the kernel which can then update virtual tail/head
> registers w/o exiting to the userspace; 3) the kernel thread can
> selectively exit to userspace for cmds which it cannot directly handle.

What is needed is for the kvm side to capture the store execute it to
some backing memory, and also trigger the eventfd.

It shouldn't need to be synchronous.

For SMMU the interface is layed out with unique 4k pages per-CMDQ that
contains the 3 relevant 8 byte values.

So we could mmap a page from the kernel that has the 3 values. qemu
would install the page in the kvm memory map and it would 
arrange things so that stores reach the 8 bytes and trigger an
eventfd.

Kernel simply reads the cons index after the eventfd, looks in the
IOAS to get the queue memory and does the operation async.

It is not especially conceptually difficult..

Jason
