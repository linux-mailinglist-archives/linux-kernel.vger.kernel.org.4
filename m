Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408A3741581
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjF1Pnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:43:32 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:16552
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230273AbjF1Pn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:43:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnfOL+29DGm1JlGV3wAo+LWi9fYdNX3bXW5/jR9DPC+juU3tzp3sqaYZH5mRGjr+iRwa5e/LO3HaRX9ztviNmCZ970NeioXFB7RB+6/8mPfFFoHfezEPDoAF+W8X5SOTdAvO8V2MUKQdOSedcOZRVnNCzm3PMAbtDjgL+D6otboelQV3GI5iwjzssby+0TiEBSrVASXBgYOue+lULJvuw2o37smplzkuOK1ICV9OqxVggBt9V1WnMKoSl1GZYb9q/vJv5R0VXh0Sc0XwVyFYfRweT+MvJIdMQ8jUBVJlKSizkh/sM19GJ41RWq234UelPe6sX8WTnnt/LW71LJ/P+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJ1HTvS6d29EvqK1HRfMhplgqMhbozU2tdo66vHJvG8=;
 b=b3sg/7a4QpgGtTChShPNUOZErG3CWAD+KZ5xhEhn3ASFu8DwlhJfYRGGa9tZAC9vQ+QJdgQOKRgs0umUCaMVqas4EWhYMfA0HnDSOrwc4f4luG1PiHqBueZYmzB7WOTiJeClMrCOuUGlWEb8pi1SE0O2u2llBjo8j55KRG8XJBdgPQ5XWc1F6Nk52Z0xOW2KAAbZYZwBe6fRKFP50eH/dn+qICbnXBk6T/kJ53Q6RzzapiQSYBlgXRr1PY6EUEufssDlJy++WbsSc27t5MVj7h+rJxVM6HeLsakn5Rlwv489+R85Lopswq9cZN0KmZfdlEV7b4NkNNC48dQwGKwzgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJ1HTvS6d29EvqK1HRfMhplgqMhbozU2tdo66vHJvG8=;
 b=KuuDiJqLUjqPHTR5k+qlIIvP0utNK8yCx0wxT9ltvplPiET1ZRRZXI/ekLTXF/AzKl75ZCMD/iVIvZT+yVPFcomEGzVX9VdSbeRtCwQVjSF4uHAgw6DhPbfp9gGsXKpn+52+tFMGrohWqYJ5rfkBjSUHqgf586wPTQsIQf1vP5kVo47NrwKK/g7MyDViQNeUjKv6EgnF4+10EEIcWj/qy293u+HH9qZB73Ion9EEy+yAQF2GBUy4xEuzxFdacY3Tn/ON9UreV2VPcAdCufx37HuH4wq0nbraKyLGNeFz6W6KDcBYI4jotGlTYZXXo/eJOp3YGc1GQ1Ktj/xAJTzVbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 15:43:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 15:43:26 +0000
Date:   Wed, 28 Jun 2023 12:43:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
        joro@8bytes.org, shameerali.kolothum.thodi@huawei.com,
        yangyicong@hisilicon.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iommu/arm-smmu-v3: Allow default substream bypass
 with a pasid support
Message-ID: <ZJxVHf2YZ1LxPx23@nvidia.com>
References: <20230627033326.5236-1-nicolinc@nvidia.com>
 <826cbb86-ac7d-c40b-f7e3-51681cda50b8@arm.com>
 <ZJsXLFtH8WkRK41w@Asurada-Nvidia>
 <1b0c9677-4e2a-6767-f8f2-23081e6af3e0@arm.com>
 <ZJt7GhV4IOLvRhhr@Asurada-Nvidia>
 <2274ba47-7def-082c-8429-8f2cc18adf9f@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2274ba47-7def-082c-8429-8f2cc18adf9f@arm.com>
X-ClientProxiedBy: BL6PEPF0001641E.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:e) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ecb51e-4c72-4544-8758-08db77ee69b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +FoDUZ/6IutYv2WwYfxiVPheZewMdps1mbEMXtn4DNxsqzRfNNP3ZX/1azl8in+7V/Qa9LntxyWBP+rXZIQUoDpm2IUFp87SUnVhSsjQyVWDm23eOhk4nu/LZQuVgMeHT1rLXnQ647BsJCJHdEfzBlm942y/ZcIO4TdVuVt2Np/Xfhl5qhwhFyHtvshsvq2EXFjz74wu25E8WcS3s4CxOqAUNDpypoXRQKaSDmFTZjb4/YlQBhOD/LywtLVYCWPf3YFgv40WA4Mvvx2N5XUjn4WzofVyZgFOU0HBHSYeGWaTormon4bUJkepUiUtPuPsh8/JopNuuUBpjaw6M4Yl4qbjZhWGvoI03jYL8KAWB2DVacYKtw/Km5/Ybekw8eoJokuzINHTcG8BTGHWKufkDur4iPn8lqsbJy+u2I8W1BWeazJG4TiMYwfr7bTzKqbBFiJwUixDqhQiubTYl/BMecV7sL9jdI2iV//KvyibZxVlIixVXkR49zKe0xg0K57NO299NYV7dJuu18RhdHypOpKaxWea16tZ0EdlhEDgusVKNwvGY4vQMEqYHyBGHIpZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(41300700001)(36756003)(5660300002)(38100700002)(316002)(66476007)(6916009)(4326008)(86362001)(8676002)(66556008)(8936002)(66946007)(6486002)(26005)(186003)(6506007)(4744005)(2906002)(6512007)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aZCllzTobXO0OHxTcw0jJEufyiuTYKxRYbTbLarPwyJwCyTfNz8VCcLeg6AU?=
 =?us-ascii?Q?rCXr57XWSC6lRBbTuYcK/qtYqp3ZIdw4mzIZjFHxLY2RtbX08N7F0yKl/xUb?=
 =?us-ascii?Q?T3XJ2wFT3ejhlOwF7Q4zYIcvk0TOPknpFQa/mUZYOmunC0oWdqt6nFQRm9qF?=
 =?us-ascii?Q?2Fp/kRcNPxbEI98HeUjGLRXWRSbOkdUDODEGW3KL2HYvsc8HiulPecYBQ7yX?=
 =?us-ascii?Q?rdKt9J9qteU1aGJtEf2KW06sGmGDE6Ctur+H9CYi1ZH8rSnui+fOrL4rCv86?=
 =?us-ascii?Q?H3xr7s6Z+PWEQSWCPq1dQCzaQa/hvkq+oPjHm6GrTFJPZJIV4WpZHR9ytjfP?=
 =?us-ascii?Q?SKDIdpGxsNDSXM29orj87zzPkT8yP5b771LBSd2k4GeydPqP2HmCMgQOt1aW?=
 =?us-ascii?Q?hIFiC/MUtiyIQZ1pIkuIdATj6vZnAXC3zwlVeFfejN5pEy3YoDT3PTERnAqJ?=
 =?us-ascii?Q?NiAGw/wnYjr7FvOpLX+csUjh2d1hPDGvr1J2Fjzt2UB2RkU5gfdHlITIAnD/?=
 =?us-ascii?Q?cwkIkXMJ1Lvzo5cSrDlsNdLlKgC41h4Dem4H6EQ6qGDPos9wvOJeDCylh9jD?=
 =?us-ascii?Q?vlIjdEH/nb2JDgavFS2ulSEQLuds4lNOVxXiSc+buf3r6VcygRpOxr2fOwfM?=
 =?us-ascii?Q?KtshA57fPrf7C2PyJ8GyhSdq5S+rdLtcRGwDZ7TSpB9Prk/F9RrF5RtsS6af?=
 =?us-ascii?Q?OpvpZdrPv0NLolmQGH5mX6Yr1iy2mh991VJmJFI3JN8pCOY8YV3Ecu/ovGfc?=
 =?us-ascii?Q?yh5IQtcbdJZycpyRIsU0pCp0niD2kR8xUidjsgXS5Clq15pJ1lbK+LefiWip?=
 =?us-ascii?Q?4S/PCDxNI6BcH5I//N076uXwtm19s+OJaEskYcIHul2KoWk0S2fLUVrb0Lf+?=
 =?us-ascii?Q?eOlGLhz4L2vPvJCY5E8ZWuauGAcjBCswgk2u6oy1nF3AHbCfUjEfh4XCG71+?=
 =?us-ascii?Q?Y4wKod1IVQ4ixEd8ERbVv/a6LG6gK1WtmbUoiybft0724Rie+5tjYclcN9e2?=
 =?us-ascii?Q?CPGM8xa35S9+B8NNfSDyi+DUw1u2os/ViXv001YmKlX786hUhDO2SZMfOKIx?=
 =?us-ascii?Q?0h4Q7PbWia6X4j07pKk1BWME/7BRyDC3i5U1pUuv/GR02Tg1Z2+QDlM6Qn6L?=
 =?us-ascii?Q?9rjr7gI0NVTCp76OO2JE87TQrlMsJi4UTo8vnOhp1OJ4c6Znpq6FoEX3y+R2?=
 =?us-ascii?Q?YvhOVJEjh5bXTwzZEE1K8Oa7MUnk6akQwkGUHPiEomyHCRpSXy/mp0NT9OxC?=
 =?us-ascii?Q?oyD8gy826AaNYPGYnqzRRceTzV2j8/6vDg+VrgXPgbp56JutOZm8RMdN7kqZ?=
 =?us-ascii?Q?uonKBBZ4mIZbtNQZbXqaWAY5nyuIS3HGz/zymru6tncS/XpztQHmzGTQWNDl?=
 =?us-ascii?Q?fI+RUvdg7CjJNfObPuHOL/RZatUhl6SIoxoidXOinaQS4xstYQc4K5rNZiS3?=
 =?us-ascii?Q?swyCUmtF2VxQDSs8xjK+6ND24nswrBeoOw54q7YLsuaoWrbT4jYuryoEbRDP?=
 =?us-ascii?Q?3gUXo7c6mJQbzzV9OLO5MArH6FKVtH8NYRvND63r1XuBg9BRnFb/dEwWNNBP?=
 =?us-ascii?Q?r+QE+TrdfPNz9mQOZooRJ3NF1ghIg+PWFl0PuRpR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ecb51e-4c72-4544-8758-08db77ee69b3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 15:43:26.3782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAP54ZsPs3P+VINpYcgEdhgf4RpwotIqNQ/hTB9ssCfx47z48wOmrbrLjdj3BY0m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 04:39:48PM +0100, Robin Murphy wrote:

> > I'd try keeping most of the parts intact while adding a pointer
> > to a structure holding pagetable stuff, to make it cleaner. Then
> > the S1DSS bypass case can be flagged by an empty pointer.
> 
> I'd expect that what you need for this is much the same as what Michael has
> already proposed for the PASID-generalisation series. The current inside-out
> notion of S1 domains owning CD tables is what's getting in the way of doing
> the right thing cleanly, in both cases.

Yeah, that was sort of my guessed feeling as well..

What do you think of Michael's series?

Jason
