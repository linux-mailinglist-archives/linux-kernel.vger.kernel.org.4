Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D386B4CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCJQY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjCJQX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:23:59 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AFC8091C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:20:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRNbiy58XzD7HnLGZU6gcRqk8VZmADoKL7sUnbgdJdcHK2Qns3zoyzmWbxudTvZ9otf5nHUITOA/gMMROPxyTLjK3OsJZIBNnJ7E/wjxhHL5h/KLZMpTt3rFnYNIdmAPKCl/kfKzxy9/DvGYDsusDr1jGNC3bfZhutUBBhXBH6CANQQqOVgWtLKktvtFAXLFg+KYVYFqAr0GhHgmy3/0Tbp53V9hPFibqhLu6+Sbc4Ls0DyDyvRGiyXOoWrdSOLgxCFk9yC6UqVPUqieiuLNbcoMHWzJ6PXQvk0HWdBkL7CIAUVAyWJXG51+poBfYGiRyXyDdK3QZZ1vqKRovJLD0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8MlyvKm20A+n1lj7krErAlhaG6V0x/u81kZfDeQHo0=;
 b=C0SdjCyXP3qSiibRuo2r2IL435Pj1hztNTOODRFEmzGup6JHbrAiiw+ZLWqUyMTl7DN2XUevYoasPF90RH/rwSJXUHdl0drHyGBL3cwC/nL7m7oo4s8vM1DdDvpQ+FkH73D/NgQ0Pz0hoqRnHRgeDyt5RrnwCcqpC6Rwj35EbarbAWE3jkGyz3drwZhoo43FGzdjZFVXC2GoQyMkdtU2SgPlnaRlj/GYIRpG1cGwp9nagIHE0S69wSdYdXaDHzz0Jc5zOW+3YgKyzdkyBWrTzzAuE3LvLPj72mldmeQMMh7omFiY4PpNAhzJiTH9qlu6/lEA1vjM5B5QHF4vfvymAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8MlyvKm20A+n1lj7krErAlhaG6V0x/u81kZfDeQHo0=;
 b=YPy9b4YgB0272kmP9gYyiR6K1QLSYF6xSgRxUz7vr3KNB7deMWWWvsoR4ZwuKj4UPbVpRm8LBaJjLSvBkKcWcf1HL78qco+Wy/Pdaq3xL1l35jhqQV6QXYBhtUb8z4HzW63Gv5GEtV1ZnPcRvTf8NANl0zD6y6Q9HmKv9T8AeTvPG6I0fWtMfD8mqjGBn9be/Xalij1k8TgjZRkcpxHmXx8c6hpih5AqEziJVyfOc/H3zX+DRK8dljj1BkBXBClhWhVoZmu9OEXIl+wDnTYvV3M8WNw9by9HU/XSYHwXb6OX/g/a6hvrAwQfw+kwzqPIMnFkRNza9rObC2svSwFrNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Fri, 10 Mar
 2023 16:19:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 16:19:53 +0000
Date:   Fri, 10 Mar 2023 12:19:50 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZAtYphmOuEqQ1BiC@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAqv87fjbdynVaHA@Asurada-Nvidia>
X-ClientProxiedBy: BYAPR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: ff02e8ef-2248-49fa-4b99-08db218347c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/cY2KtvZ9n2AfNetC14XBm8ieS/jKIYv2Ftgv65pLBbw/IOz1EdPJIUod9nrZRkUi+gQZum6hPutfkCBk9/6qxzvBKewC+pqmBB16155EkPzVupPFcAux25yzRKttFviurwPpa0XXerR4t+57Kwt5JTr3leg45dOwNYCim9IR+xZDeOxrM0qcEEenHEdK49kRVtfB5xOuSA2vZZ/lSgJ7X/8ONDGBLImt+bIKzMFJ11sQGFQKYJ+lTRxV2F69cvdEfEHSDsXj3om7Uh3TccMVK8kFJ9AxKAKf1Pg8GBZuHB/yQiFlk6EkaBDoOjXgZYJTv2fWjOzOqawcFKDUdeL4SEs9td0qf0Ed/WujOZciF8CyvCsly69Z7U0sVAj311YriaMj02KcQDNGv9kaf3yt9V3IPfx5jtE06mUqEc4KpJDDVJibX7cvFYj38RSVDcnZNN3TvXWYDAmH6yrWbEF9sxmv5rOvx/voIwQzL1NoOHQ+ZXm4f5A1klY4v3GTwrpDbZTSJjq4tTNZLlMsQKoDIwu05q+x9sx/S3CATmbVobtfKzkcEpsjbbTgcgGCHGS5/Q1XVPDTWMifGbrM8v2QLyjEPYqNlwueQw6UBHLSZSdeazrnHxiPBEENWzg5rSqeZUOe5lX0mFdgvHnlqP4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199018)(83380400001)(2616005)(2906002)(7416002)(186003)(5660300002)(66946007)(66556008)(4326008)(66476007)(8676002)(26005)(41300700001)(8936002)(478600001)(36756003)(38100700002)(86362001)(6636002)(6506007)(6862004)(6486002)(316002)(6512007)(37006003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t2rXqCs2ZUcoBWvSlSO67NekIcGfcumRYqO19coYAG3/3H3qSd0XxLvnTVuv?=
 =?us-ascii?Q?eOUZ5bFb3+EEzUEUUxZjw28VjQYa+SNIIcr2HWy+YrAr9iGWQKLoap6PDtXi?=
 =?us-ascii?Q?xd+TiAN2Bbzcc/0EfFkVGjYrvROvcJUm+alcFMSyNqhkijvmC2lKN78sG0l5?=
 =?us-ascii?Q?xErW3yOiPWYpVv5Ky5YfwiYk3BHIslPDSX9JTF5VBhMXhaEig1ArtnGlFg56?=
 =?us-ascii?Q?Mwd2G/Au5u7CFX+MOP604udF8e79TJTSNAnbeLo6n4CWDbZpzursWf2Z5QXg?=
 =?us-ascii?Q?Obo4OI2kfDwUovM2DExJvICA2bhi9YqXQUKw/UOnqYGywRBpSkwmT2R0JlPs?=
 =?us-ascii?Q?atJpYL+BaLAhp250arXUvRuhBCO7DOLgnbbCcfzZLQS1LCKe1zVS7oHzyDyE?=
 =?us-ascii?Q?9I/3cPSKa241TjS2RrQgqaZTu65OFoWujHx4BsPO9t83iCDq1Cnh3RNhEzh6?=
 =?us-ascii?Q?MIwDM0cMnX0JI9a9NSl/H2LkZwaQIDk1eM6qzqVpG9VL1yf/6a2I3EbM2iol?=
 =?us-ascii?Q?c6cn/6y+NiUePBh9sayjKTX8caEa/gBalg97n+TMSX34NKYaI6AbERtOgPUk?=
 =?us-ascii?Q?8rtjR0KtPpqnHTdm2WQQo1t9OmLa1SZh3N6nDVMaKJGLGgzRSsA+QSoJc/D2?=
 =?us-ascii?Q?icAfOwwrGLLdzGSRCsS1kYdV4/v+u18qkn8A601J5P4huaBqSBlg7gVPJ5UK?=
 =?us-ascii?Q?WZYfYkYi+Ur4W03R3ACupGdZeBZ6cD/337gwDilE/j/dzVMcSgT9cSdpkCvi?=
 =?us-ascii?Q?NwtiWf1Vb0akhqFtCate0wO6ijZPFAEchyRx0RSmnc3ICnMjE94Yw1zXdOvE?=
 =?us-ascii?Q?vGMB1wHuopDd6RU6PTlNVQt3g4PPJLi6n10RAX4SeknHES2dB67AVRyqfIfx?=
 =?us-ascii?Q?XudoDlRsyTWqNG2mgU7cfEegWNJxHAOueaJ/MIjHL1nLuo9VIN6z0hbx159p?=
 =?us-ascii?Q?1RKUeNarPLgPTziZJKQ15qz7SWudrzgHOSwWSyt3QsqnH3hURTGJ8bdYVpza?=
 =?us-ascii?Q?i48Kyjo7dZMSTyAWhGY77oNvEBpYLONrNMKsUnctYBGfPJqyXLqdZecQC+sP?=
 =?us-ascii?Q?eg2UoP8r0lS1s8kct8KXedvx/N9scOR1qWa8kirhhfOQAUSEQqCHmLNPd8CF?=
 =?us-ascii?Q?GUL4DumQfXmJsS9TgBpdvdQtpfXIu6H6nj6Vkea7zJTW2Xwr4dsyymtGLWx/?=
 =?us-ascii?Q?AmCLKmC+ZqeZqq3zRB0Y/zYXDhM67fe1VW1ghxoOWHNfXcNjXcXvzFu14trH?=
 =?us-ascii?Q?9Y9UiR6J/HYq4pa9mAswb5cT15DNUW5BkoDGHLklqnloWG89NO7CeTUBUSM7?=
 =?us-ascii?Q?wjpC5w7hMSnUUnOnIgtG3Giu3Y6s/J6L413DNajRkvhNfULeLX3wPzsmO80h?=
 =?us-ascii?Q?Lc/ytJMdrZf3U5J8jP1aLManTu3zV3pU2XOYQkN9VAfwNml3U7WbEwhtJTF0?=
 =?us-ascii?Q?pUGBaTrZStXmWAskC17KlyuMszt/rtk2QwRiuQ4kFKtzF+IzA6YKhoSrU8WM?=
 =?us-ascii?Q?QMi9V/QAIo/WAW5Dgx+MDswksm76X5U6lVPrpBUnUhKaY29NwfCcxeBSYFrx?=
 =?us-ascii?Q?dFHrRJbVFc4OTFGUN4s+IC57FaPL0zo+9vFHW2Ln?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff02e8ef-2248-49fa-4b99-08db218347c8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 16:19:53.5235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrB+ZOlBKJ+xDKNL4I1WfTDEo+OxqwrP+NTopnpbRyEr5hTKcCIv0CfLmsnDRe3r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 08:20:03PM -0800, Nicolin Chen wrote:
> On Thu, Mar 09, 2023 at 11:31:04AM -0400, Jason Gunthorpe wrote:
> > On Thu, Mar 09, 2023 at 02:49:14PM +0000, Robin Murphy wrote:
> > 
> > > If the design here is that user_data is so deeply driver-specific and
> > > special to the point that it can't possibly be passed as a type-checked
> > > union of the known and publicly-visible UAPI types that it is, wouldn't it
> > > make sense to just encode the whole thing in the expected format and not
> > > have to make these kinds of niggling little conversions at both ends?
> > 
> > Yes, I suspect the design for ARM should have the input be the entire
> > actual command work queue entry. There is no reason to burn CPU cycles
> > in userspace marshalling it to something else and then decode it again
> > in the kernel. Organize things to point the ioctl directly at the
> > queue entry, and the kernel can do a single memcpy from guest
> > controlled pages to kernel memory then parse it?
> 
> There still can be complications to do something straightforward
> like that. 

> Firstly, the consumer and producer indexes might need
> to be synced between the host and kernel?

No, qemu would handles this. The kernel would just read the command
entries it is told by qemu to read which qemu has already sorted out.

> Secondly, things like SID and VMID fields in the commands need to
> be replaced manually when the host kernel reads commands out, which
> means that there need to be a translation table(s) in the host
> kernel to replace those fields. These actually are parts of the
> features of VCMDQ hardware itself.

VMID should be ignored in a guest request.

SID translation is a good point. Can qemu do this? How does SID
translation work with VCMDQ in HW? (Jean this is exactly the sort of
tiny detail that the generic interface ignored)

What I'm broadly thinking is if we have to make the infrastructure for
VCMDQ HW accelerated invalidation then it is not a big step to also
have the kernel SW path use the same infrastructure just with a CPU
wake up instead of a MMIO poke.

Ie we have a SW version of VCMDQ to speed up SMMUv3 cases without HW
support.

I suspect the answer to Robin's question on how to handle errors is
the most important deciding factor. If we have to capture and relay
actual HW errors back to userspace that really suggests we should do
something different than a synchronous ioctl.

Jason
