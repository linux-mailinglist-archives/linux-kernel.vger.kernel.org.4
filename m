Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924CA6FEAB5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 06:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbjEKEdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 00:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEKEdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 00:33:41 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B903F4C28
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 21:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZgysXIq0zwXwBTcTiU/97WgyJ1L7NQzvLQF45zsqIiFb92FiE7Ie5FO330+Dfz+GEMThPnwRUfdi8DltffhkCBF1CRO2u002ZgYSy8flbuAbxnyVBR20WW4m+kwVf3NIjNBmS87N/OeLBgzUC8OHqJfryj042oFRU4mR74V1+Bxx3dgQMBJDwk+T5e0FA8tqXKi25Uc5xjSxfzzM5y7ZvTu0g4tAwcF0dR7bYk4XPf4M91gIrHsLNTIKs5X+l8r5Ovjuqto9GPHyA/I6AYWU1VBS3Rxk6O/ZPefGzBD2XIkQvahr9rNUk9usYiWJPaC5sqvUqHr7YToftHVQR1EDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTfqVodgxzvi3UDyu7WueMuQSaz6mm7vorIi5nPDFB4=;
 b=ipHYGEqHxiP4VkOfQpJDXeeoEXbxnfVYHlquluPvn1DsMNqzy2nrz3IPdZfCIoGgzQ8aTQc4AhZmygua63579gXO0hwKihZsuWcPhtieQV03xNCg8rJgfKzG0BOo/3sOGlrZfbzHkpPraed2EndqVhyu4ckjkAjWUlhNNs86CTm8LHQZM7Bh5eXY4cxWKwbs47aEoQCDq//gcCXdLN9ANkl7r5eMuXlRmPp2FEfqGCh2a1URP73tzAjulkAAltGhlwXYZSDWlh99h3TxaaE6atspL2Qcax8rmWE4lZhkX7EW9LBSkD4ytxu76BsgvKPvkUxJLcbj3Ts1eN6wlbZVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTfqVodgxzvi3UDyu7WueMuQSaz6mm7vorIi5nPDFB4=;
 b=bGd6udIsQwNVYqztrpTWXcoJDIlkGp+vh9pag0XXj1oIh8SVjyYbUZwLNQo+/GAcHVB/uXqhx9S7R0K0lCjd1i8bAxejtRhAobKCHKC6oBujcuFLug6KudwWPG8yxW3pNCU8yKUWWPEM61obPOqyTqwVdjamBUeACOD9CrxQEd6pDAntHCCk4BDK/7/+NbMOcM+loSVpN0OYmzJZWPPMkEnDsxv5ugdISpl1FyPAXnlvMoSXyLRfBpqXLnS53xFJwqAFsFEK3TK+bkuixlJyoLfcX8B4eq7iCbS3tZ96DJc+YXuA7rDtDysdLOPkyrt2H4Lp3LPKgkyvccoTcfanpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 04:33:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 04:33:24 +0000
Date:   Thu, 11 May 2023 01:33:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] Add PASID support to SMMUv3 unmanaged domains
Message-ID: <ZFxwEYPn74Tivcrb@nvidia.com>
References: <20230510205054.2667898-1-mshavit@google.com>
 <ZFwIWz8kBL+bti1m@nvidia.com>
 <CAKHBV26rbPXr6QUAx1MSbX58Zr4B7iLhojOgfn9c0tc1wKaP+w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV26rbPXr6QUAx1MSbX58Zr4B7iLhojOgfn9c0tc1wKaP+w@mail.gmail.com>
X-ClientProxiedBy: BY5PR16CA0032.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::45) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 6981cecf-cc95-4620-4492-08db51d8dba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYeUIEJhU2uYlAO4skPGPXqti86BN9THVdR4jqr7cN75UTvzaPXWAaAy+opbEv3p7HVWYifZ2YISfPRCVhcIIuepNNHfbGJl2D7SYGMA+xCvgTfDqPMMtAfi+B1Bo9mBQbuhoPH7KOuqjXIH4KP2cmby37P+zibabMQERk5Zvqv0/hzg1RLhp2YEptRnoXqXYfAobsu4Tgh0+ZTepAj8Gs45S4l4PISAtUXNt/cQjS8OzHeTT6zFoSEkvp5xaQnDC18yFhbWIpWuRWxmpS/k35mR1G3+gDhcqRsFIOVORQP2RfT/wBLFyV7le921GAdtryVM9y6faD3q0Sl4LL2zKds8OWia4udVWm/aVts4onz61Ew/rLoKehDQlTqdv1L2/u3gNzPL9sgFFcvuBJc+2iIls2dwe4eIysraJIUgLPw4H16RVC/nkQXzPtwLDihQ/J7RclarrgFDwkNwRMWUjbHMXdcXygmuIHZEqCZe62aUjKS/rLl1b7WE0BaY4t+Uhea5NTS0hqOmH5vSh4tCTgU0Dv5Egf+dqInXKwbzrnGVpSZP1rT2B+drZg76FX7Qf+clfuyw7DKMshy93mQCng+t0H3FxGYCh2GJQOmlv8d//jI47bTI5O9PCmNQzo/1G7pBqho5IALDWWpoxpz9gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199021)(6916009)(5660300002)(6666004)(316002)(4326008)(38100700002)(41300700001)(66476007)(86362001)(26005)(6506007)(54906003)(66556008)(66946007)(6512007)(2906002)(8676002)(8936002)(186003)(6486002)(36756003)(478600001)(2616005)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ALa5Ep7YI1G1aFRnL7muK+HuM6rikPOlQffR4c7DNFx5P25pYvvu6gCHy+UQ?=
 =?us-ascii?Q?7U1WpMN2F80EZntnSaPj4eUf9aQxpHidfzR1MDHpb1OSiSIrLByV31L2DeHo?=
 =?us-ascii?Q?rAgfJdivHp0z+CAbYDENoi4T6g7bADGdfariiw831egxlF9Odp3G3A9go/sa?=
 =?us-ascii?Q?5waDLZ1sus/tGD9c2HjawOfr2SgALni52x8RS6rCcJs2LSHRfhQj3EYIyJRh?=
 =?us-ascii?Q?L448cgvwJCgua22pw+pv96Nvgz4SBFpWv4R/FP/BSLXpMV4kNjRMj7OlEgFL?=
 =?us-ascii?Q?Bos1tX0DHMsjc7bD/QTHHsxpNxb67ugZiI+gw+nXlFu6UaD7eLBLcceQ2SAG?=
 =?us-ascii?Q?EYegx5o9dSNgV5UHaYLKdFclybh2bcjRQTyqYeyuv+y58Ozf8t4AIrluu7Oj?=
 =?us-ascii?Q?7QAwLupySu+fHkOFCm3gr6pHphkrncTtF8/Hq+pwY1apyuJ1usiZ6JczeCw+?=
 =?us-ascii?Q?DSbdkx3WdjzDZx8g+kvFhudJCF+SCv2P3xMPzukwzPjCxUEg7/2Jl927t97l?=
 =?us-ascii?Q?B03oDdN0aW350/86Xb/1rRhzWnVv+v7eN8UBwsAZxn/V5zsax2uuNzTn2iGy?=
 =?us-ascii?Q?qinZNPWq+XXAXHP5C0/eTI3CZqZG+K1f19oAuJ1NJ79XeXxtA64zi466INI2?=
 =?us-ascii?Q?bRaIzTbzynLLrPslAA+PHVwgziLfp6QxcZx/U8y3WsEk0xZ+Fapqpr5CUybl?=
 =?us-ascii?Q?pK2MVYVoWv8Eq2ZeA4dRsP36VFTLFeWZGMJCS3P4Ta61fa6tg2DDVvfqDvcB?=
 =?us-ascii?Q?3yB1EeXpigoryh2rJDEwTwn9Pxge2vint7ObJlGoZTRBTb+hXkfD0ruBSW0s?=
 =?us-ascii?Q?OLC1Pj0tR0ZqHctZ1hJhRyPQhL8FI+RIqeR4IdTTAWp9IxP7E766Df10ZoaD?=
 =?us-ascii?Q?LHbST8ykuBYFQ+C96qBToPiqD3B1GbW4Ifn/1otBpZjcJ63iLeKwY7gtpDq+?=
 =?us-ascii?Q?AS7ZtL3+yN8OUgOz2TGF6ZowOgTuUkGTUvyZ7exZUIJ9kvChLDKbnxw7IN6Q?=
 =?us-ascii?Q?oKAb3Y7Vik6W8vT7r9SWz5x2W/cxZfFMxk9WmaFePiBd99skMhD7Wveh/GU4?=
 =?us-ascii?Q?CSSt0Tj6Zsr+A77QmOcQ1hwN0kfG2oFtTUjygjrQYFLoB8L+QMVpazvdIWkh?=
 =?us-ascii?Q?eJoUdKJBCq3RItyhMSyMT4TI3jcBL518ICvPdbJCItsecm6IDQb8E9V7uoUk?=
 =?us-ascii?Q?+Zrj9eS9gfK/WMQbtkexe+f6BCgrM7UkOF5RHPlMQ6k+h3ED8CFQfoyEbenp?=
 =?us-ascii?Q?9RFRUkOQLCMoLTvzdDm1MNMQQErXsOcKNfioSl+TiCwhIfhE5aGNjwqxRCah?=
 =?us-ascii?Q?ASU78F5A/b8rMQbWJYi2WDAPJOC9vWDvzDG+4701qKJKYsBKTqhNqowXMefU?=
 =?us-ascii?Q?NPKiwVNeW6RtOHVVsTJ1JdMLOPxTnvNe7QiVVgOx+YG1/Y6qQ+a9na3e6MPL?=
 =?us-ascii?Q?YPC4uy1ai2qkNwPfxXBcWwpAIm3V31l+osxVGGkpm+DLMz/Vsu8WDDfjhC+G?=
 =?us-ascii?Q?hJAueZnfnj9XhET4Cqr9mVJ1RhxFeHjwqCoY+x6tcGrap0RgqqDBkvgYRb/M?=
 =?us-ascii?Q?6RixZ02ZXI041eSPa8P4WcGsgRIOBnUtsuxjSxpM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6981cecf-cc95-4620-4492-08db51d8dba4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 04:33:24.3988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUcImwaK1g+c0zqst5T+ynWBMozRTlXJcFVSxqK+iVANXdFmXEpyovabBiengp37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 11:52:41AM +0800, Michael Shavit wrote:
> > Logically when an iommu_domain is attached to a device or a PASID a
> > STE or CD is generated from the iommu_domain's configuration but the
> > iommu_domain doesn't "hold" it
> >
> 
> Ah yes, I was using iommu domain and arm_smmu_domain interchangeably
> here since there's a 1:1 mapping between the two. In the current
> smmuv3 implementation, arm_smmu_domain holds the s1cfg structure which
> represents the s1 portion of an STE.

I mean to include the arm_smmu_domain too..

Generally this sort of seemed OK in the code, I just wouldn't use the
word 'hold' - the iommu_domain may cache a computed STE or CD value
but that the actual steering or context tables are held else where

ie you insert an iommu_domain into a steering or context table, it
does not 'hold' a table entry.

> specific to SVA about this behavior however, SVA will do the same
> amount of work whether the cd table is owned by some special iommu
> domain or by the arm_smmu_master (since we require that special iommu
> domain be attached to the master and disallow detaching it).

The CD table for SVA definately should not be part of an iommu_domain,
moving it to the master seems reasonable.
 
> Gotcha. So this patch series should be less aggressive, but is
> probably still workable with the nested domain patch series:
> 1. For (stage 1) unmanaged/dma and sva domains, arm_smmu_domains
> should hold a single CD. For the nested domain series, arm_smmu_domain
> can alternatively hold an entire s1cfg.

These are just pre computed values the can help when inserting the
iommu_domain into a steering or CD table

> 2. arm_smmu_master should own an s1cfg (which holds a cdtable) that is
> used by unmanaged/dma and sva domains attached to this master.

The arm_smmu_master's cd table can be inserted into a steering table

> 3. arm_smmu_master also holds a pointer to the live s1cfg, which may
> either points to its owned s1cfg, or the nested domain's s1cfg, or
> null (bypass or stage2)

The steering table either points to the CD table owned by the
arm_smmu_master, a S1 domain held by an iommu_domain, or a S1 & CD
table owned by userspace represented by a special nested iommu_domain
and its internal parent.

If a kernel owned S2 it attached then the S1 points at the CD table
owned by the arm_smmu_master and the CD table points to the S2, same
as if there was PASID (IIRC, from memory I don't have the spec here
right now)

Think about it in terms of what object owns the table and what other
object(s) are inserted into the the table. Nothing "holds" a table
entry.

Jason
