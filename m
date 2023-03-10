Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306926B4B42
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjCJPiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjCJPhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:37:48 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC42012C0D7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:25:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSWjU1OQHCM3QW0urly50asTerbjiIzIcTChljPRpFkwgDgcq+5mqgf1eJtWchGpkfXZTz3iCFXYt0Zug5y9D3y8w4dXpS0X+c+xy8xp5Ql6Um/uvG8LWRIesG3/BOFqfJRWpbsXLMN5i+5tXWUToVPHZ1gjmY3gjS1X/KgKoSJbBkapSVCN85K3wskz8yCyepzWJxPp/xEDUjfKcwdnZBIQjj13ogOIhH6zjhOOqoUNH44+uH6uZpliuIz1xLWaDMUA7oBdwWnq2BrHVeWXDoXZGdd+PhFlb6OgXIfWbxythO87xP3B28TbJe85BkFfdx2069nt3/NUuQZgUShbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GB1Er/NWXN6E1Cnp+XW+MP291Dg0C43yWClYmjCl4Ss=;
 b=ZYaDvZrp8Sq/eRPwtHJHl3euSzfcyUfpqySgxd+86mYp65ZoOQbwzxJuy9yyJK1dU3YE7btLMbv5feKboW2itWJ5luRus8v2X8A2FbmvNUfdGnLhHDMukR7Gv5rUNWkW5peFV786hEfi15koZO/g5Wc7qS3hRSs4p/eq10wFW8QG84GWutXv0yZwa4SdLz2aXZDOz+AH44+UTgyzjvQTvOBydYbVy3tYDGD029EaWr8YgjaZSJNKu3TlVg/v1cu6+jIo4JilxKLRmXW8g1Hy5WgyCumQm90+WXlr7W1EdidDFa1awZo2Qh109Ja8E5GpLgVF3aopvxN6nQrYxKvrBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GB1Er/NWXN6E1Cnp+XW+MP291Dg0C43yWClYmjCl4Ss=;
 b=EUD56ZRViEH0nWZWpvEqSD+s7uvExu4C/THjtXv4iz1asmb07ifgKcWSsxWWcj/rU2JBqIuCm84Ldaaz3xIZUWVMUdVErc7Remj34qDjZfF2EqDQX5Xl71uQW/GVkSS9VIM5rLA05rIQeicK6aEI5WpSMDtGCWabffiam88T1DO/IA7FiZKLu3UQbX6NELsFPqCKQduqi7wfwht3rOXJPiqAmxUzAvcGTJr4lecA2XOMJ0WS7G/0b3xlkEgFmlRppIiIDJPolUH/4zRpiceCyQF54AZt7kUXcVfV+ayJ/9BYDAZLgzedxp6M8dWhkXrdFQNMSc9RonMWlp/WmGgaXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Fri, 10 Mar
 2023 15:25:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 15:25:07 +0000
Date:   Fri, 10 Mar 2023 11:25:04 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
        eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, yi.l.liu@intel.com
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Message-ID: <ZAtL0Dx0QRbXOTfZ@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <ZAnx0lUkw02cVTi+@nvidia.com>
 <20230309182659.GA1710571@myrica>
 <ZApJGwPjHhlDwTDV@nvidia.com>
 <82f5b94b-01fe-5c99-608c-f7d124247b7c@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82f5b94b-01fe-5c99-608c-f7d124247b7c@arm.com>
X-ClientProxiedBy: BYAPR21CA0025.namprd21.prod.outlook.com
 (2603:10b6:a03:114::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bc74cb-2570-45de-fde7-08db217ba13d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ZatDRfUNfJGx2z2AIHrg6Iixx5xj5lFfEPv79QsNc+kB3hNXTCSjHsd31UUszhmK5rfeNW5SKOsvYts7W8z01o6gf5Myh5Hpjaxr8qap77uHSKXL/TSU5BhjmoPIGRKKFM7RT03fAfCZdxn3ssw1SrQLlsmx9YZHrbM2arFmMtj2HRZAny95gl3c4QShXRTTgBpeREwI/8F0JhRBt9PVN4LRAqrS2naaZo5rUAkU1G339WK9TPHL+P2SxUy0YWS5isRBJJS0YRINgE1MGcfG2eIsLtwkozzCo60t0EZq9+d3IBAkqlDkQIe2FJLB9m+5OFeEz2Zgf1twlFmzKaa4QiRdjRoOQ5d+/Rneo4YlmsCphIV7E3KSlsQ7w0bom0PxL+Q1CgkBRtCP/0qHb+vokFgGuyvw/8dUyHbGa7y9SX8UD2xael1SqB/NyV3d/XYyz7pZuZfVHqzZWOL6Qq8ZUBA3QhS6Z2gZ8GhFo0LUYF3sCfyy/OweiVJ6L8Zbm0HM7QPxxxk2JIIVqM88V6GSxSNdXHlGB+Fzpo7IgUYVAS2LVEtklceDCxOUNAc2TfX9EYfy7z4lOBZ+g0qBLXpdHstNGC6F2XFyoZwTFSnMeVY+Qf4Xw6ScFJnfjz9BewbRo7kXqUgaltOxyip0M+8/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199018)(36756003)(54906003)(316002)(478600001)(6486002)(5660300002)(7416002)(41300700001)(6916009)(8676002)(4326008)(66556008)(66476007)(66946007)(2906002)(8936002)(6512007)(86362001)(38100700002)(186003)(2616005)(6666004)(53546011)(83380400001)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pSQucLOmu+eCQaz5opisn0QWPsOh2xHRjVQsyh7ZkvDAIbA8ew0nD+BDijTy?=
 =?us-ascii?Q?p6MhcJXrrT0LTXgeSv613WbqxNaMUWdx+Yh99JDFKUEIlsdhkuIYJBpC0GzE?=
 =?us-ascii?Q?FvkDcCX9I6PzaOU9lwXQmvPJnAFXftgs8Cu1rCMGFH39mwYzGkBe1cajZjlP?=
 =?us-ascii?Q?z1/bjnm/Z6WUd0kwEkdRYEHF/uJ8PDG01Yk9XHEjRiTbhtv21dWXPe9pxxa1?=
 =?us-ascii?Q?gRxjkcvR3PV5To2yH/rHTENzvVeXue9onv+Qok4A+Wsm4Q/Rj/WVJgdHNwQE?=
 =?us-ascii?Q?65Wa/s+STkPypcEdKrzNmwKEgs/QzRwlKBsFA3D3u6zIN0CMwMoIL1KRnpa5?=
 =?us-ascii?Q?qabSLuKknOub6vZYqNMOgdvySSeLFjb+N+t6ret2u/VVoPHBWhMZdri5jhD0?=
 =?us-ascii?Q?QmrNfr4LMqOWTfu44+IIWQVTPg0peeNM1H2hizwOCnZL+Q8TtN6riAl7Tc1i?=
 =?us-ascii?Q?HTkY51LAwt1ptZ3mYJ5MDHgX/n8WoBywWQhDrw5lrY6XYcN7RanL3uQCxSRs?=
 =?us-ascii?Q?9CqReccSHmuuXYl3iW04/8t97BiBEPp3T79lho4LryV2HYgQOfJ8L7xAEZhk?=
 =?us-ascii?Q?/8gRIiwm77uwxLE5zXQprHmUIOGpnpOp/4jbnOyP6kPjbZWciMvDFvCzPvLX?=
 =?us-ascii?Q?USAUpXreUNPZDlNoeiJi0ZGXWEN6gmk3vqU3ogR16lts1gRqpnCfgq+F7KuU?=
 =?us-ascii?Q?OrL5TC7wBTZEP5GesaUcTr4HyYRHk4Yalz8AA1tY/+/fvPuAm11DRbf716Lx?=
 =?us-ascii?Q?YFZZbr4OOdIt2ssxtG+uTrBa6O1q8HYlAJX0duAnYi7RN7UCiWGbvEOyVIL4?=
 =?us-ascii?Q?b4mIw2laLg8T9JisGZH31ngNM6s6PjEm0IYbnH/VP+3XeQpwjSf4E+k//GlU?=
 =?us-ascii?Q?zNagHr6u2H5Fgi7QIjDgq8SLaq/A9MQtQjp7y32UNeLIERkiPDfrnmsgz5oO?=
 =?us-ascii?Q?eMWqPoGJh9PaNowxxcvGP+fXx5XyBjaFPFmjQ/BZGq/CfcNWc+Frc22jW7mo?=
 =?us-ascii?Q?Gpjb8OlZLpO4Lo+Tp5qtKlUAvGBD/8DeTWrFvKeWB3+1/NmpJWBEBLQhFg8S?=
 =?us-ascii?Q?1O9tLz2amj9kzRW5GUNqWF/GWG1nl5nxOs/PHNPGpUB0n5sXoPrF0lXzhbnw?=
 =?us-ascii?Q?7EiUyVjr5TKtrokBnLaBUBna8hbSfeZ+AIJq6j2XJaGtI4/J5rIQEayaOOBV?=
 =?us-ascii?Q?jlpUULoiZN719PVt7IVkkELWgHEblGyIxnuonnazCrlVFvb2CnoOva6VAhmP?=
 =?us-ascii?Q?2oscKOyyvUtI7Q7sbeIHlllcvc8nNGMdwTzauW052qbOJhWbTaXZdWDMxhiM?=
 =?us-ascii?Q?7aEvJSEHAq/ExsmQqjm/7EBNWaxDgLHD31vEsZ5hjZ6c4kUoE2OpZUOEQw6H?=
 =?us-ascii?Q?J0artBmisNuOpb4GRnV0giXPo/2E9IsJf+dyUO9bA5BsUlw6AIIKK7iqdc9g?=
 =?us-ascii?Q?tiytYu4EXyWhk5aw9AkSPWMw4avir6neVMSI39tWBZg8LGXu3/1uOTfXnOJ1?=
 =?us-ascii?Q?2Xv82PyJRhHjcX6p2Q87tkBXh7JI8E4GGS8F88IFcP7Hbor/2de0wspioeQC?=
 =?us-ascii?Q?kBG4EYOrBnyb9offm4ja4jRfmGP5hFjYussHmTnp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bc74cb-2570-45de-fde7-08db217ba13d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 15:25:07.4351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loDTmUxYYQu9g+uTGUn7W7L0WolCaGltx8+JenVv8kzm5x5Ayt7TVE/Wc77PTPmq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 02:52:42PM +0000, Robin Murphy wrote:
> On 2023-03-09 21:01, Jason Gunthorpe wrote:
> > > For a lot of SMMUv3 implementations that have a single queue and for
> > > other architectures, we can do better than hardware emulation.
> > 
> > How is using a SW emulated virtio formatted queue better than using a
> > SW emulated SMMUv3 ECMDQ?
> 
> Since it's not been said, the really big thing is that virtio explicitly
> informs the host whenever the guest maps something. Emulating SMMUv3 means
> the host has to chase all the pagetable pointers in guest memory and trap
> writes such that it has visibility of invalid->valid transitions and can
> update the physical shadow pagetable correspondingly.

Sorry, I mean in the context of future virtio-iommu that is providing
nested translation.

eg why would anyone want to use virtio to provide SMMUv3 based HW
accelerated nesting?

Jean suggested that the invalidation flow for virtio-iommu could be
faster because it is in kernel, but I'm saying that we could also make
the SMMUv3 invalidation in-kernel with the same basic technique. (and
actively wondering if we should put more focus on that)

I understand the appeal of the virtio scheme with its current
map/unmap interface.

I could also see some appeal of a simple virtio-iommu SVA that could
point map a CPU page table as an option. The guest already has to know
how to manage these anyhow so it is nicely general.

If iommufd could provide a general cross-driver API to set exactly
that scenario up then VMM code could also be general. That seems
prettty interesting.

But if the plan is to expose more detailed stuff like the CD or GCR3
PASID tables as something the guest has to manipulate and then a bunch
of special invalidation to support that, and VMM code to back it, then
I'm questioning the whole point. We lost the generality.

Just use the normal HW accelerated SMMUv3 nesting model instead.

If virtio-iommu SVA is really important for ARM then I'd suggest
SMMUv3 should gain a new HW capability to allowed the CD table to be
in hypervisor memory so it works consistently for virtio-iommu SVA.

Jason
