Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0686FF681
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbjEKPyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjEKPyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:54:33 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC85665B0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 08:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnTMduSF7JoE9ALjTXJcZlmO5vuVqOLfFKNHDyVULAsBqbni5Kfwgkn+/YDTV52588YMyGWKQVpUI5sSGk1xfH4wtdtllYQSaHKV1vCEFGnQyvDPTid/IhtoafK+DQB/fxVqCO5cMfVNMHWbZSYCDIyUW2bjnynwEqZUBflPTOpw4YK0O1EW0ex3sP93AllS4k022zYYzVLCigdZnFJ4Y+QxkHmDh7DGkxpw5HmottjTY2MKIJ25uBPc2ekPMbqwj0GqhWw6btbpJHp+tA0ly0wIX7CRHlwS7nz5TCGm1OS2luPUck2xsB/6N7cdTwNx64NPnqyJdZwQpvebluwJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smgJHTnzUmrWPla4pHxSRaS3BCqebahLW0Xeh2AOhAg=;
 b=T4T9OVZo3yjWI72h3IbG2BF+wFubxd6dOREArnsh+A90sGJT4auV35XMsCcm0hbaTBKui/Zcy/ddjMROLOM/xiVoq2xqBRR18OSudOHjy+zcv8AFFOb5civ3coIX563zZm2unPgbru5QR1RmBcFP/nszicQ3CZBlYeK1EBuGcxGhgGLzgSUJX0yD0a98v/cm89WAlnFgibvp/nRZCTSlEDxVrMavK9fUWs0vgIuQmwlWtRcLfcCewdmAlthVlMASat2zJC/c4Fe1NgbWTCB/tuafNguMgqnvKS/pIqOiLlMTr1vg7jjMZwmZXAIVdzhMyz0T1oMP042V5A58uzwf6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smgJHTnzUmrWPla4pHxSRaS3BCqebahLW0Xeh2AOhAg=;
 b=gsoih6bMAkK1hujIAg6CEbtgoUYga+4BVUpkiwf33jbJHE3XkaocpDjp+vsNgUw0jm6tKQFNNt+SFXAqyoP85rbhjxpWdrgikyZmy93QY/pWVHSVRplj5Axc/SWuchVL9Q4fZ3jTsYHBRUWVkRESM909R0UVPHun1KUsvtHYuHuu9o5XfxBJu23cWCFAr0wlUYaiJnDIqQTfFOyCX+uftAIxVnvqwPy2oILfTn7lz/t8ihcYBimOiKzi4JnGyKVe+zKjp9iG28frcmuy3ln7UTRojSBVgHnOxhBbsAz+NhFjp7hvb/niln3kN0cZyj2XwQP5ybdG7FchYxpNFHd+oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CYYPR12MB8938.namprd12.prod.outlook.com (2603:10b6:930:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 15:54:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 15:54:29 +0000
Date:   Thu, 11 May 2023 12:54:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Michael Shavit <mshavit@google.com>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] Add PASID support to SMMUv3 unmanaged domains
Message-ID: <ZF0PsybSn54A4f/+@nvidia.com>
References: <20230510205054.2667898-1-mshavit@google.com>
 <ZFwIWz8kBL+bti1m@nvidia.com>
 <CAKHBV26rbPXr6QUAx1MSbX58Zr4B7iLhojOgfn9c0tc1wKaP+w@mail.gmail.com>
 <ZFxwEYPn74Tivcrb@nvidia.com>
 <5deb8a32-7f49-06ed-2275-721b93bbfb9b@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5deb8a32-7f49-06ed-2275-721b93bbfb9b@arm.com>
X-ClientProxiedBy: SJ0PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CYYPR12MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: 339809a6-a2dd-4657-c1d0-08db52380104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efH+EOyJypsm5cYqcerKeauSQyelht1OUgC7ceKanz+hMGgEWa8YvKNGZRbjH4M0VVPsuk4t8Mhxg0WSCeUQ7qCxDvUl7NQLFm2ZVfateLFYmbRiWEDoKu/UuYxwaAdEfs788QuHjzTbv39ATBlWyvI9wvYkTjTX8mKsIwQctZszreeW1Dj1JO9xq1mJqknnLBFPIFybR8dOS+lv0F8/gNJ0cuITM0hwmF0IAD1JgzYng7t1chxYtuRkIAtpwSaCq375KwLNwIptEc7lAWUfQbmwEYBgg4ulrEBYILPpTjAbe+iJrnaBkZQmEjGCQWX2cPd9l03pRRbWAy/5VdTXpAUPVP6tHkduFKhc7McOUG52Mod+iBNXGLtXUYINJ8jegvSL03x8zYbnuUFGsrkohe6BsrbTy9CjUo6aGg9EnXDLPzeiWxLkPRjHCDeIWjWcgjQpW+WpSNGF+oDXx7vFa/6fMYpWWyNR1zvv7XLSLWbHFIvUmfDgix8q9rd0dX69II3fHiEesiA/6ZqxykXplY89g/hng6WGq0PJEGDpLRKUkBjO01KaEwT13QlzX570V0VpaRrfeGRHx2GT4Hvf66tew5ukfZtjqHhH0rQlTpf0543PU9BTjXOBCFfnlBJx+ylo9+d7TPo3wfdFyrSOWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(8676002)(38100700002)(8936002)(6506007)(26005)(5660300002)(6512007)(2616005)(2906002)(36756003)(66946007)(66476007)(4326008)(186003)(6916009)(66556008)(54906003)(478600001)(316002)(86362001)(41300700001)(6486002)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?08CpPcHBwNosg9gAcu6bvyC1QK/3oHQLAgFu3k32r/nmYN+ACHMpABuwC+f+?=
 =?us-ascii?Q?DVS0kBNsGcOJ0+p91pJqEOOFF9McaUpxb4P2jiY+pySR53ZUCANYPo4Ub95A?=
 =?us-ascii?Q?NWwbaE81oByC0UY0c9GJdRXr13goxsvYE5oQjwW5XWcuF/zEUlM3xlg3v2gB?=
 =?us-ascii?Q?RKbKCoPRa4iCZg/b7+ghV4N9zlVeI+G4ZCe3VYgzsXnHMxjIwG6uQbD76JJ9?=
 =?us-ascii?Q?QoRM6IsFcDBA3DoadhOQSVol12yjvx/9z3OEnFuHlgIJT76bD9kIAH9FvQSv?=
 =?us-ascii?Q?AWKSta+VgLlae1QlP8HnHf+ai6NkbtA+XdChQvrhBgRr4utOLd7Bgkj7YHha?=
 =?us-ascii?Q?HwvjrNkF5ennG7OO73cPyJz2n7Th6tNszFwH54TpUFEi/GWfnAdBIYpTuVFU?=
 =?us-ascii?Q?I3+NrifAxnYuUn+qXGvnv3wXSXLG4az48ig2BgmBiXR1A1rx6aM67PwFfwvK?=
 =?us-ascii?Q?NdVejMNng5JRSXpaeHGMdYpvH4l6XuUmZI1wnDSe9UHH1AUO0tYZGXV036ht?=
 =?us-ascii?Q?m5KfEdQBEhKq3lC7MT6wdEn2k5z9QPLW0OBBL/i+zRK14EcpA9h5Yv0x8KpO?=
 =?us-ascii?Q?srzs0d1rSqJJ4lp//jUuYQvDY1MsXd9nc1J4RMX99M+fl1u+YTqE+/j+MRUB?=
 =?us-ascii?Q?15r9QRangl6TNm8IObhlmv2MOf1niL33YJvzgaIUL40t/AlgrDz9QUs/t7WY?=
 =?us-ascii?Q?T7vncpFLswZhJYumtlvc6pU6fVmE/LLLU8z2mEQTiD1AHihFyYl7Yp2lHHV/?=
 =?us-ascii?Q?HO/QURzh/SRKuwFMPldIi/+Yn17tHpo8JefWMuholEYqY7/deAcGmNcnRcuq?=
 =?us-ascii?Q?EpGUhxspHeuyg/pzNm1qNwYzH9RG2xp2d60eS5qmcSkpw7mBZTqWens4zeHc?=
 =?us-ascii?Q?qpZJNDm780BsoxHLe/U3M313vf9dmloNsVo188uF/wwzW3siK6pjdDEVKb1V?=
 =?us-ascii?Q?L6fZytj0cmV17CWkpIjxaj1FCpsv0A50+u4wYhU7KW/JaaxX+W9W4osCaxxz?=
 =?us-ascii?Q?8OHGWY7UZ4otDy1n3Esc58PVy9cV1RJyOxBIKxZSkAWJQlSY2Lv7iHeXrkvo?=
 =?us-ascii?Q?V41Zn5d4k8Z/lxokY0cZh9yDUZwnEVrGr1vwSTWFVRdaELloRtuMxaegIwR4?=
 =?us-ascii?Q?NuKEWWuRNstyMQY2oHYBV7gg/Iza7nzBcPGubb58IIk24lZI5FZkhVIUzw83?=
 =?us-ascii?Q?1W/GVuHPf+WoO5FmJ4CJMhRzS/TDyxYLrYq1ig+y3JAq7U3dtwZ99SJObSNj?=
 =?us-ascii?Q?tQT3Pkda2hLoZWlLKbDi28yNfd615saN34tabSoXM9npBAyWej97plTE8IVv?=
 =?us-ascii?Q?vWMxCVucgZ/ODFoGVH1A3in7JqhI2sFEvd6VsxYasOZdSnxrFFhMLuvLDill?=
 =?us-ascii?Q?nFGYYJlNWk9ALrvwalxKgVmWuFmx6Xs2iw64jL2jw9tZEITwvtYduGWc7Amv?=
 =?us-ascii?Q?W2wKGs+XOQp+XOEQNPNcc8g8lyInMnX/UcEYdBkr0W5k4NpPsG2raOJ2hCAy?=
 =?us-ascii?Q?xuRstnN7fe6fB5Xb6fHIGu5aRo+RUc1D0XdDbtbBhAN7tn7lJZztOOZKM8+u?=
 =?us-ascii?Q?nAFITfry9zTBd1MJwcPRCenOzdZrkj5V9lb00/SJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339809a6-a2dd-4657-c1d0-08db52380104
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 15:54:29.2881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8CTyUUNqwqU+kbUnwki8UKNWH9EPQlrP8XsOe/6Px1tA9NOdhrzYJeE3k+/e5il
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8938
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 01:33:58PM +0100, Robin Murphy wrote:
> > > 2. arm_smmu_master should own an s1cfg (which holds a cdtable) that is
> > > used by unmanaged/dma and sva domains attached to this master.
> > 
> > The arm_smmu_master's cd table can be inserted into a steering table
> 
> Not sure what you mean there... STE.S1ContextPtr is essentially just a
> pointer to an array of CD structures (which only contains 1 element when
> PASIDs aren't enabled), so every master must own its own CD table directly.
> There is no viable indirection if you want the abstraction to bear any
> relation to reality.

Yes, this is what I mean. Whenever we need a kernel owned CD table it
comes from the smmu master and is inserted into the steering table
owned by the arm_smmu_device.

"Insert" is just the usual verb we tend to use when talking about
these kinds of structures. Ie a PTE is inserted into a page table and
points at a page - a page table doesn't hold a PTE owned by the page.

So we have, basically, three kinds of tables, Steering/CD/IOPTE, they
are owned by their respective objects
arm_smmu_device/arm_smmu_master/arm_smmu_domain

And we insert pointers from Steering -> CD -> IOPTE as appropriate.

The only case a CD table is not in the arm_smmu_master is for nesting,
but we can still say that the nesting domain is inserted into the
steering table.

Jason
