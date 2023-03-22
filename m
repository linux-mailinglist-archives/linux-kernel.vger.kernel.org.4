Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3A66C5274
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjCVR2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjCVR2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:28:43 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3104EE385
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:28:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGAsxMKmZhSg2hLBTX4DCGATm8ot5O6JkI8fl13GOWWMC0Sv/XqWFfW2uv2cgCoW3h+vMh9T6OYAbxvMt2iAtSecadhtL6S/ZOVDy6i2jT6PSG8S0qZ35Xi4Du82orxYzgXo7bVnIE3hGP7Do1XnR0Mv7TXvG8rLYoP2kTSbVewMLZ6WjbusC7/xpZuLyFqmkMk2+g0XWLb7OXPhtRArFkULboYrkQO3+zlBE0ItaHwWbxYh5T103Vug5NiJcJbd1EvgM2xDwVzgnAiGO783pwPUU5mHYDX1BKYB0HAxy7dkhCqKWCnUxUhnSgsZBr+4vNenkV7lCqexiMeFT8I7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Di7FZrZ8+bLwRb+Nhw5JI3n+0BzB85SJ/Xg29RsuSyQ=;
 b=fCQrNl2OXdigelVSuWM3IrCzlO/CqyR+D5BP85mgleRrLbex9I5lfWVCYI16NTq3giC7rd9Hcg/NP/knaRo3t9uSP3QftAbnkcEAvjR0FEWNfpRtRBh8oXtZlFtzJsb836mUh4dm2ciTeWdBFVT3CvoQobhcQ6/21LLJSjrp009YCQuWodHTdDSuuOWcQ8eeH1ItY935CK532bzHrj1pItVuHnLJmYIM6ACZtPhsutHg4r9iQSALnS6UHnsCfL/jNVQIP/gm7jdrXiOI1AjTdr/++QRVyO4uiyJprSGvyuBLdk3FYqxW7e4znqVLC8Gu1GXlDdJOy0nfv1BIIt1gpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di7FZrZ8+bLwRb+Nhw5JI3n+0BzB85SJ/Xg29RsuSyQ=;
 b=c1IX4qOoDwpdGukZ2mdobPwPv/R5K9TDMMmMGch2pMRWJXPyAIauZ6D0LHOyIroUUy4NfKervmRDz/Y7ZDh8CHRkDD+qe69fn5eVK8Zzz3b1f/GsxcHeF5L9D9hMV1RMZoG2x8wd1YLMx9yq6ZyXU+u48bLZ6iKAihTDggbfmADzP9FwfiZpwrKLQUUXe3NHAhbhDSCyacmceryccZZUSntp3EaUPIhe/jA3joYINToD2sFKANSgIxlh6Ohry4WcbQwjAH/11IHFdcAhMiaG1kFl4JPFa1MI6O6YoVes9OpwL/NrBVBH3jazCnVawvRWXQy6qfjtwnxd9tPdMJSKVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7413.namprd12.prod.outlook.com (2603:10b6:930:5f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 17:28:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 17:28:39 +0000
Date:   Wed, 22 Mar 2023 14:28:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
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
Message-ID: <ZBs6xlqMGYhLbI27@nvidia.com>
References: <ZAtYphmOuEqQ1BiC@nvidia.com>
 <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBhYq8o4gqFZVb6k@nvidia.com>
 <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
 <ZBifWkY2Lt/U1Z7R@nvidia.com>
 <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBmZj2pscX0hx2kQ@nvidia.com>
 <ZBqjUeEjjtCclgLN@Asurada-Nvidia>
 <ZBr3/1NzY5VvJrJQ@nvidia.com>
 <ZBs2xaa7Ow1pnB3C@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBs2xaa7Ow1pnB3C@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:208:134::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: e351e17d-6c39-4321-6379-08db2afadfd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DDzVuZ6Hgc0wXjiL2cScwnQzr93PB4iRhP/d135RBrXyNTHxNbv/3csTHVMCi8cVB3XQkvMScMgtwvC4lv3xwZU5XZIkC4T10Qi9AVDiMxOKB1uCU0Jfw5zdEsq+sdAkh12MUmsE1P+HUr/w5g4Aj779V1XPNC7BDC/dTriw8XzkC6AJ4wfsIiOiBJqM69Gn5UF5A7ib6BsCBoIpZgBVQWfWluMzAU2oh9HW8QVvs0Lo5gfv2oS5LCK5tytyTWtIYqfi4B/08Hjx6QdI+Rf/0CJUr+K87MCCcB3J+z398TLD0eYukIU2j3gL2MzGq94ODwz3ZIe0Mpw5wLSXDPm/YIsjswSrJrmBSTgMGL1dQjEs93pzDX5y9pZn+S5gvbQ+f/uWv0AB8TPAjJGBYZS6N8ZF5AGm6PsC2iftJCVV1hQT+rHGDy0wUtRiA4V+s4W1TTRcgCQZhpnciT+kcA4AsAGKKQozSZRxevfekFPacv/islHI0clJouNEnHHcS0jOXfEKQhoGo85T4vDc1YT9+80i0LD1d+xRgVl6Ruy7Vptuu7H2P+uNp3Pb0taqKsb+tnPsm9LoyXqZVKbWhyKYHAssOE2E3DlrknSujMrBPTJDmnzRTA6rV1S1OBrwenSEkYAAvfTwX4T99Gl8gY7N5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199018)(2616005)(86362001)(6506007)(6512007)(6486002)(5660300002)(26005)(478600001)(37006003)(316002)(54906003)(186003)(83380400001)(7416002)(66476007)(66556008)(36756003)(4326008)(6636002)(8676002)(41300700001)(6862004)(66946007)(8936002)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TpyKToyD2KMhXcOOW39zo565PYgRUwDct6nUcSav4oceDQvF9zMR8c7QXUob?=
 =?us-ascii?Q?fdFPP1riAKbw89MgPdIy7ra7ipXXNvPNNb0QdTbSXQZSIaOs2hbakqPWIzE8?=
 =?us-ascii?Q?BIZZTZZEWrfCzB62X9VKh8/JJ6+Pms9dnWJ2iw/yL9T/jGwlYVy0LqGOjpKM?=
 =?us-ascii?Q?pjstSEPhw81LYDYjnZXg8OsZHEn2lf2VPynKfp0ZiJKu+s/0lxJWLL4uwG/o?=
 =?us-ascii?Q?Tde7hsO7F+AIFtqKjbPj/X5HsApVtbaNL0BQRYvvFhrV6cYdb1bDh+BhdjJK?=
 =?us-ascii?Q?KsV9QnVfNDSfbWM/1eqljmrTtVe4t9r8LBfj6y1ZYXQBfbU3MPrEfbnXJoxe?=
 =?us-ascii?Q?lxtcRBAKZhYH2gFmapHNijCzgLAYvE0p5+P97LUXElF2VH1vTjcJYgEVjdlP?=
 =?us-ascii?Q?41Y1i7T878LqgJ4ilL+nQYgJ56xfZLx81frQdkBQh4Px5ZjZOD3sceSTVGLF?=
 =?us-ascii?Q?P+t0vb3uoCxRuGFlLJdKkc8sg+hDTccWEMjvpNKUlvJQzLRcZfgxcSo7qq6i?=
 =?us-ascii?Q?mwvFbvFAqKg1N1NMvrIaA+SfyqDJylFsJBVWhd3+T9NmfcZHgqXQHN18JXFU?=
 =?us-ascii?Q?7wq/6PGXpRVOl5RKJEjT2FE9y8OgunNmYiub4iPMarasM2gfqUHqVcMd2sEt?=
 =?us-ascii?Q?u8Arhurcdnb+iCqNKAHUbjG2jmvwKLobeJPMoYmfuZLL3JQBg8MJPJS9t8+p?=
 =?us-ascii?Q?cOJQBJdroqbPnhrXl23Hhjl71hxIipRqZIwZu4TD2siuNe//zaWQgWXKYDCW?=
 =?us-ascii?Q?AKY55r/5oxbDP93+2kcw2J2sThbnSwBt8lH5KADBCXQB3B2Tmayk2DzLIDLC?=
 =?us-ascii?Q?tnJZS0xk4EQu4FFKaOzpj80TCobkAnB/c/a2uzK4QENgRgysC0JERgYMDXFp?=
 =?us-ascii?Q?A4lj2I6exh/Y8SAw+7+j3MU8VJHr6GS8W1ZhZE/lG7KTOx1dplXzFwMofUXx?=
 =?us-ascii?Q?drQ+PLg/enzDfMSMkqg/4wvGNTfNOGmnP5OrAXOJdOaZV8/gjgigqNs1ncex?=
 =?us-ascii?Q?zScImYUgZwzKqtbnt4NOB5cBmXOm5PCRejJebtudPZMHn7Wy/7DIDwmQCcAj?=
 =?us-ascii?Q?06tCkkuwEcEoW/qGozk+kJsAlEjplgKnXtlTcsaJq0D8stenStuCBuvd2SYu?=
 =?us-ascii?Q?K5JWr1KtoRdqnEr9MF2aowLXr2KhW8gtZLzIoHLlxNxwVAQFcqngPgDPH14s?=
 =?us-ascii?Q?ji6tMXpls7Ezhqf+vLN1/xoLrhcQ9Ax+qOMGrJ5qil66//EIg15B5UhQdCqO?=
 =?us-ascii?Q?mYQWKktCqQutYZNK1mPlBUzRge9umz1pG1Botoi3FJFYe67VzCWkSpr04qR2?=
 =?us-ascii?Q?H1FDpJW5GRVVnUfJB4SmM53T1c3vLUya82GU4kCt7DdN8EyO0uEbquSFwtVm?=
 =?us-ascii?Q?njaF7NK+4vidAO/nEx1+s2649Sqx32NBuc0XZjjSrj+nUZ6lM5mioQDjZ12h?=
 =?us-ascii?Q?unLGWbyxFV6IVtLRK6erdTwC+xUtb6ZdmzAOoWPJZwcBeYXcI1DDOH6VMdyV?=
 =?us-ascii?Q?Jl34rhe5PNkEhzOvY1tLIfE6+CzIljSFTqI1BQvXJy9xA3gXdRV82QQWdxBz?=
 =?us-ascii?Q?jHU9itOpR3vtBO9MSWDym9t/wEnTb6h5Ei7DyvHg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e351e17d-6c39-4321-6379-08db2afadfd9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 17:28:39.0532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmdNunUB7GgnXe4WVuxR2PaQM6p/n+2A6yFvdkpB5IESwYrIpEesUToqLHhQuJut
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7413
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 10:11:33AM -0700, Nicolin Chen wrote:

> > Yes, there are a few different ways to handle this and still preserve
> > batching. It is part of the reason it would be hard to make the kernel
> > natively parse the commandq
> 
> Yea. I think the way I described above might be the cleanest,
> since the host kernel would only handle all the leftover TLBI
> commands? I am open for other better idea, if there's any.

It seems best to have userspace take a first pass over the cmdq and
then send what it didn't handle to the kernel

> > On the other hand, we could add some more native kernel support for a
> > SW emulated vCMDQ and that might be interesting for performance.
> 
> That's something I have thought about too. But it would feel
> like changing the "hardware" of the VM, right? If the host
> kernel enables nesting, then we'd have this extra queue for
> TLBI commands. From the driver prospective, it would feels
> like detecting an extra feature bit in the HW register, but
> there's no such bit in the SMMU HW spec :)

You'd trigger it the same way vCMDQ triggers. It is basically SW
emulated vCMDQ.

> Yet, would you please elaborate how it impacts performance?
> I can only see the benefit of isolation, from having a SW
> emulated VCMDQ exclusively for TLBI commands v.s. having a
> single CMDQ interlacing different commands, because both of
> them requires trapping and some sort of dispatching.

In theory would could make it work like virtio-iommu where the
doorbell ring for the SW emulated vCMDQ is delivered directly to a
kernel thread and chop a bunch of latency out of it.

The issue is latency to complete invalidation as in a vSVA scenario
the virtual process MM will block on IOMMU invlidation whenever it
does any mm_struct maintenance. Ie you slow a vast set of
operations. The less latency the better.

> Btw, just to confirm my understanding, a use case having two
> or more iommu_domains means an S2 iommu_domain replacement,
> right? I.e. a running S2 iommu_domain gets replaced on the fly
> by a different S2 iommu_domain holding a different VMID, while
> the IOAS still has the previous mappings? When would that
> actually happen in the real world?

It doesn't have to be replace - what is needed is that evey vPCI
device connected to the same SMMU instance be using the same S2 and
thus the same VM_ID.

IOW evey SID must be linked to the same VM_ID or invalidation commands
will not be properly processed.

qemu would have to have multiple SMMU instances according to S2
domains, which is probably true anyhow since we need to know what
physical SMMU instance to deliver the invalidation too anyhow.

Jason
