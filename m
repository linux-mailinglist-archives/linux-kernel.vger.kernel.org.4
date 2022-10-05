Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE04C5F5407
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJELvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJELvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:51:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9820179EEB;
        Wed,  5 Oct 2022 04:48:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbIPVYqQTz95F0H8RQSGVW9vioenvM9NndoTL3ePbjosnfpIRlRCdpRThC3QUdGvGTrmDA1pg7m77ua187OsKOpOIXstU7NPAdYtscSFymxi31D1+EIiROQ+JV4IUjztcKskrsQ+6x8+T3wnhW30nzb6v/I7qfrdTGyksSvEzgseoIYGFQUeVRHD/XNilrTQoY49ZWP7USg9xMP3k1f4XvD01N5hJULQGmGzdGCUKVXV+DGrwGbzuhQi8lj2MT9aJhikrLesgU9hEccTc7uHnXVHuoY2uaide7BbwJ0eEdkKrV/kquSDLwcWhI2SkDVxOlvfc6OQp1Pu2fLTAniS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOkGdWvPcCbFNxGVIbIDE1x0EHvcA752N/Z3558MfCA=;
 b=fl2BuLd3m2ta0cJ8e+LoaXDpUVHWkxWQJp/vmkn02Pa36inqTLvh4/GJOBDP8Am6RTFK1FkCSqF91nHsAuh6wqMfUkJ/L84CnyEVtdNuUks0ITAjnFHWiHEfaiq5hIbFBo/OkD+42eMZfkSIZIFsEOeu6RgzOsKQb46FefGgdEd7f3afzrvf+MUda/h3HzqKsUO74xdy3jkSk7i4S7jD7YvGA6bSb00tl88O3sAmmnsFS5DJKUDm65JfG9ZYBzrYcHILNWwMJV3Rl2Azo8cbFBJpupDnGRGKk/BsIw9iKB0ZvV3EzrFbXNqom1ipw/lrJJUrFyFvjlZWw7//aceLTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOkGdWvPcCbFNxGVIbIDE1x0EHvcA752N/Z3558MfCA=;
 b=Hc4XyoWSzNCEeFOaXgIKx0je06uPB2Bw8FQG4rdzJ0nIvAtZwk3opE+Rtu3zUffuEwGvDgIGBmvkLeT6Ht9Yq5npZ31G/bKNzfugUn3lWX7NvSCOH8uaV3uNj4oIIYEUQyG9kufNXugpuc4NRKORQ8Rf1NdnTgIcmXd1o0EhIXRdHS+Bik3Vg2Vy2Eco35NQABFk5V8YeH+BP5gDVNnGTKh9M8qq3+Y0gnbCa/Px/T/YHsNobImZH9GeKfTt///SMvpAZSHJF2s0mdrg73Ta0dRiwj/qnjB+MGSjHpEWzJxYM3lvefha2yBiwePkos7Fb+TG6eTklCGfLmNupX0zNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Wed, 5 Oct
 2022 11:48:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%5]) with mapi id 15.20.5676.032; Wed, 5 Oct 2022
 11:48:45 +0000
Date:   Wed, 5 Oct 2022 08:48:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] iommu/s390: Fix duplicate domain attachments
Message-ID: <Yz1vF7B0FLvLVvE0@nvidia.com>
References: <20221004120706.2957492-1-schnelle@linux.ibm.com>
 <20221004120706.2957492-2-schnelle@linux.ibm.com>
 <2a56d7bc-3beb-51fe-fc65-f2f3bd192e34@linux.ibm.com>
 <dd92817a13601a4a449096b7ae94caa66a113853.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd92817a13601a4a449096b7ae94caa66a113853.camel@linux.ibm.com>
X-ClientProxiedBy: MN2PR16CA0005.namprd16.prod.outlook.com
 (2603:10b6:208:134::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 0144ae23-416c-48af-999b-08daa6c78ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4FCEVhfBgYTQCwm1wCDED+ns343TVEmzUFoXrYcT/yBE1taVmsh6vFzw1FUk44H8kF4wwMgQM/svBlAiywTyr+tYW7FFpUSM1NAVllg3MzRfk2gpLCvufICbDvwQGFQEz96asKjKMcgc4iC6/IpgKSk/udjdlWlGIdNMIiIDd7Od/vSCu68MCY776mPkRpzRJg8fpCkRDoYlmdVf/Ff3jHKDJMpRNIHuORVb88CwCrEcH+vDN7Na/2fudbAmiBFyH0KblqFXeQ0j5YNwyhYIEkp0beMaVlGAfBeCPnGdbfYefjQIYfXBC/bg7XXN8uK1hWDF95+w4J0HxfWGG+qH2YsLf5ejLt0e/2aXslCIGkK3M09w0/9hxOjB18fuCqWV4iurL9mNM0ILaUO9BXH+KUYUIvG9R5Pt1ypTJso2WsxBsVTD/V5xgasX1rYZGt+umiWTgGSPgOI9trjqtMdXSyqZQrPYiwV7v/fSSz90CkLmSdXOBbErA1j9rAwOfEYfDz5UeQ3f+tMes/mzPf9jRY7Zzr/qQVJki9azptivuowm4gykL8ITDfJGoYFAELqwEEWF79vGwQ0gKiv8OHtMvoggFd4Rd9zeA33XzFKOE/uUqXnnEvcaDVc6QvBbyfIUI9FFOJprA/IZako8dmbYul+J89gf6XNRaDkdED/pGkiNqkpwoKVIfBTaEDVM4i3JaEo8bGZiwaHe3wiAMJSjLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199015)(2906002)(66899015)(8936002)(7416002)(5660300002)(6512007)(6506007)(26005)(6666004)(316002)(478600001)(6486002)(6916009)(4326008)(8676002)(41300700001)(66556008)(54906003)(2616005)(38100700002)(186003)(66946007)(66476007)(86362001)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dy6n0A34T+SJS+Qu5BX6+jJ/VewlLoRVyHXSZNKQLMqep6cff5udAmu3JaTE?=
 =?us-ascii?Q?VRo8ipsqW9NwvngOhlJuK9SDmFXtc8Hsa6rbOwJoU9mHKcsNb5BwL9TmFiyK?=
 =?us-ascii?Q?193t/Jw2wKsXVCdn74zhsoMpdJ4DSNLnSGeVvA/V898FbgKdm6LY9LmWHZxK?=
 =?us-ascii?Q?2+7TMP1prWvC7usbtIGLpw25mByVGozC+bQMwqDhlKrwzN3Tz/lKuwAnX5Qp?=
 =?us-ascii?Q?WbjMvy4lwjv7jCOfqwL1TwGcclIIdNzdNn4bf++YNnxuPrvZsO6WPRYB2ekc?=
 =?us-ascii?Q?XdcZxD6Gemnt+AIpGx3ctUF4yDETUOWM25cKFPwiWA2PSFvfnhzXeOybvlnc?=
 =?us-ascii?Q?5Cf0EYUiqkGhKPlgg+8zyg0+QlI5mnD5/+m/jkwOZCbuT41+zb5R4H56+dsh?=
 =?us-ascii?Q?qwFKuIL7JwLXmxCZlccD/Tl17hoght2/amn4nbjBgtjg122ElG986/pnKjAc?=
 =?us-ascii?Q?x1DtlAnDa7WUaghbXXbdsDA6s8hniG3bml6NNh5REeLjw6cD/XS8HB8qfY9O?=
 =?us-ascii?Q?rTTv5/b6qC5LOx+3mcaZ8C0zfLi6VYiN65DM8a1fs5t6krEdyOymgsVw28+N?=
 =?us-ascii?Q?yNwA+WTYeOiXjn7DAew9pAnWn+9kXudWkF/2wduJtrKg+7srhBDOMRNBYxZC?=
 =?us-ascii?Q?ofF5QspKY6ymBr38/EhZei0Ld/kZw3H0jZvLYm6yDUastZ+T6+LV2VsXfuN7?=
 =?us-ascii?Q?tjw9PUETmI5db4v3RAIS3yrn1pgu6/UbgCZihv4vX4lbxDdS9xZBX0dw//DG?=
 =?us-ascii?Q?NTjbSsg7fFIHiNIOU9emZziSLJQKeRhrRGNHDhRxfMUmEPtprRG2NcMJFcxW?=
 =?us-ascii?Q?eCDhTyK2koPpZhMGs+cbwuxeidiVLQKQIoldG1zZwKWicRe733U6HpTo7Ejn?=
 =?us-ascii?Q?+dE0YvkZLXwyrP+RumYS2OYsKcn5GR7NdpLurLRuuV00D+BkpHgG0+tH8Bu+?=
 =?us-ascii?Q?zWy0c9zYbEhJd6dnoXIfxBvYsHGiw4fTni9/HzIvWCC7CBArYtLQDQHh67Rf?=
 =?us-ascii?Q?nFio49sQ+3URwN6KaTadUyaQzAs/7Sj1Lsu8uZ92lN1msYACjvKI8v+/iBN+?=
 =?us-ascii?Q?wQ8s40rmAntvdWQbF2lNjnSp2e5qc7xuZtPQmVIeLx/5eMLybwlfHlxz7v80?=
 =?us-ascii?Q?XOXRoX58unzFUyDL2FPP+CRlEN4mj2h1m5ZHyh/AmHy3IBL296yNlEnPtV/0?=
 =?us-ascii?Q?8+N2bDCLS+wPjSDj29UzDdY8W7jEJYejSq300Sa6Vx8fNLu22iDFwo0RrZCX?=
 =?us-ascii?Q?bGHMJ3496NkBBrpHQktZuVnkmJg0UXjz6+52lafxBrWPacqUwTKbAUGVBFMB?=
 =?us-ascii?Q?TL2BQHYjpituuVhuXQGr1I7uH1ZsmxbFN+V3QJWIPMuYjueli/r2k48dDvqu?=
 =?us-ascii?Q?twHVEvme9E7QmzVpICLsu8w38IvAD2xwzIcAwUxmHcuauu78vVDzAiR0ONhN?=
 =?us-ascii?Q?L5yuEXZkBnd8mpCjR/SsvlSCa6U+Hn0xXvaubtq/sSkvQKzEz7QDcIgtniN5?=
 =?us-ascii?Q?iqGWxEuBfjmsMivF3Mw0u6W21pKDGpSCUd0UHosOBfgonEuxIrUuEEacG+Iu?=
 =?us-ascii?Q?o0M6BuapyNbW0twpStA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0144ae23-416c-48af-999b-08daa6c78ef9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 11:48:45.5177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuZ/oY6nN5et42CI06PNMZIohXSR1j52fi7L3n/QyM8+t7l1SCc7vTxRDgoY29SA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 09:58:58AM +0200, Niklas Schnelle wrote:

> A failed aperture test leaving the IOAT registered would indeed be bad.
> I guess I focused too much on the failure scenarios at the state after
> these patches where this can't happen. I think this would leave us in a
> bad state because zpci_register_ioat() succeeded with the domain's DMA
> table but we won't have attached leading to the wrong decisions in
> recovery paths (see below).

Domain attach should either completely move to the new domain and
succeed, or it should leave everything as is and fail.

So it looks OK to me.

> Recovery (via zpci_hot_reset_device()) should then be able to deal with
> these situations as long as zdev->dma_table matches the IOAT
> registration state.

If you are doing reset the s390 driver should keep track of what
domain is supposed to be attached and fix it when the reset is
completed. In this case it should not fail attach here for the
mandatory success domain types.

The core code does not reasonably handle failures from this routine,
it must be avoided if you want it to be robust.

Jason
