Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD7C74DBAF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjGJQzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjGJQzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:55:44 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419F71B0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coxbzxikh6hzOgFxhQbVPxVJjKhzzGzwla8/xzb//R3VzfYImMGDOIUBF7LP22JCOZKjWD/PDEEgXB6ooPvncy6BYrmDwzrMq7u9lKF52d6+Y7XxknvYFXiGAD1YwAUddCPbCsI8Telyj+n88zhv20tiH5YlmcQ4+hp38p/fdKjdlozaqAjgiqlQWmrM+sql5PZO807NIFSN0Fscsytlci2vNQb8u6awjHKmJWmUeGRC/HXPIWjFohUKQxx5gQc9xDCUuwkfhNBjQB3N89gE+/rlqhhEaTltuAE/s6cbC3MoNZUnkg+6qXKR6/tHoesFD9VaVksHd4GgcXxSFZc0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmPE0uObwLC+/VaT1VD5s26GPu7PF/zLfHc6qP6vMXc=;
 b=fgmSFcvNJZoARuowV865v6xXUXm28vMdBMO841I+4Qaevrn2U3SDUIN1eLGgFKvrIq9933z93g42LUMKsVpbEZqsAqKw8RyKw201EMNLXEn9tmN7q4onBJ2M9zwsLxzYWrGvWbRpGGLzcGlR/hXdRAGWaQwMTqYnEK6ZC5WrPH5ACtkqHVtHLdfvrYHERb6+Ye0eYkAVzAORYGGZMDnRORZ8M1OVXC61pzNxMd3QPfYMzvCW7TWqCQpaGOhSvyS4UlVDeCMG/SDnw8KzYTl8ha5WFSt1akxJaYg5xW4ijO13XvGopwzwj30psyURewsWznSFlPZ62qSIjF6pvOhpuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmPE0uObwLC+/VaT1VD5s26GPu7PF/zLfHc6qP6vMXc=;
 b=gkiYjo4UyeyLUIy73Je8VMBZxWmyVGng4LY/u5TBx6vfq05IKgMrzm+jo/iMjZqKrDJ5upPGU2LUbKQSIkYPSLHEyA1mrKgRXNAlfJlshNFQW15dKpk74WcrRFqOVA0I9EIU5qmby63vZBdP7ntocwsWJC2oHJyTn242F6wG5gW8xlSfzrRJgOeij7O5LXEzluOXz6iRvp3g7ZW9B+v88W+LCNxKPBfYiuj16SvQK0n2UvWN6DsFP1CkwNo+eoeko+s/iBUebiE3iMWCJbRDVaswsq4b0kF9LK8eyonCkUGqpKlT2CpZUA/j96DYQJm/H1jp1xDcFOU6OMICl+vPlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7134.namprd12.prod.outlook.com (2603:10b6:510:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 16:55:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::98a5:ba0f:4167:8d53]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::98a5:ba0f:4167:8d53%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 16:55:15 +0000
Date:   Mon, 10 Jul 2023 13:55:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Zhang, Tina" <tina.zhang@intel.com>
Cc:     Michael Shavit <mshavit@google.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared
 CDs
Message-ID: <ZKw38RrJ0FG8zbqt@nvidia.com>
References: <20230606120854.4170244-1-mshavit@google.com>
 <20230606120854.4170244-15-mshavit@google.com>
 <ZH9oQMmI8CezMCnx@nvidia.com>
 <CAKHBV25eDNXEu+6GWDJqpw1h5N-Jq-GPzf81kNH1dyw3Z=KsZA@mail.gmail.com>
 <ZIBxPd1/JCAle6yP@nvidia.com>
 <MW5PR11MB588179952AEDB50D9259549C892FA@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB588179952AEDB50D9259549C892FA@MW5PR11MB5881.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR15CA0005.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: fddeb388-e13d-4d31-67c8-08db81666ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YEoQIuwzDgNpEifNcajx5576CTxl7fJt/Rs4qEknQb/nT0DzwkAPYN/sDASM7ue9tCZyloWPJFm+0uFw8HA7OimR0RioUn2v7/VV3ZGpzW3KNcSBZSq72UwUZugRlJ7f4Uro+HlDHXHARLsJlvx6p4p45pfp0N3BeMWj1cVCrhfABabEP5mBXcHsFumKMqfC79X62KnRKSDvMAbmB8FqNMgFAeReaUqnEsR7XWxvtVJhxP1S9wxFj9Nb/tixm/qt6nvCo6PLAPfJVRAmPqfeKn110rrnjJj+S50FtpDDTHXXXolGgO2sl/i99YT86+0gdj3bkNPW/HHiVvIj5ctmZTNoKT7SS9Q/WxA+vbl6fwi+RWGTJu05J0p2BNvIH8voh7FMEotJ5wr0gU/qSqwj+q4ExewOq3adNK5heSg4bow5yfb2aRgExpTQDpK0uj/+esho9kbJQvLT0QbrXS7C1hJuok7MluTmHa1UQywM7AYD3SbWkaJjd3RZsa54l4E5+x82R3uh4kDcJNbVUch+n8/7Ue4+oRcjEnCH3d/5sF1QCbxSNFcT1JdLDf4eY+hx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(186003)(6506007)(2616005)(6512007)(26005)(83380400001)(41300700001)(4326008)(66476007)(2906002)(66556008)(316002)(7416002)(5660300002)(8936002)(8676002)(6916009)(478600001)(66946007)(6486002)(54906003)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Xjq8bSwOqth/0D+P0n9KSX5mDorFbvRIlhBPG2yF3bjSNa7guMoCdFMGhGG?=
 =?us-ascii?Q?bQJz0plxqvJOXiWfyA9fQob2EFuZpIEu9/xpfCSDp8H+tgviE48QpgS9kA0A?=
 =?us-ascii?Q?0CiKqsEy0xBEwKOCljxkChJUm+s1suQCdJIuhdmcFAQwO4bde+ArdatpghhU?=
 =?us-ascii?Q?2uFU7sxlLydxTyEzR2GLBN6F8o0Yyaj95HW/amSauEsFJRF8NiCZsKjAtafG?=
 =?us-ascii?Q?xk3WnpEMh0rE6emYuOiK3v4RDhgA+OhIv2hFgIJV5+cOVITeooJalvVzXLhx?=
 =?us-ascii?Q?dZnECU6l/uXlLZBNcE9vJ4J09/D0CYNUaf47Bq5SqhoSzKP4qIWiHa5KwHg9?=
 =?us-ascii?Q?xHAnO1AIdNSSG4bicDgh+t5dxN54hC2dG/DZrbA5TRyCp+2q1DfiB0YNnm5I?=
 =?us-ascii?Q?Ude9k2eIWl3gW29amVUvlgKjhKYWl6RzdwgaxO3/ZEUobob6a2/AIgNnAimA?=
 =?us-ascii?Q?2cFDi9ZHJwvL7TfdFZvnuEfuF9cgnDPsUhmYBuES8c3XmbhV5eSLLlSQjfvc?=
 =?us-ascii?Q?o78r275bP/R01Sye1yCE49BWL/mC0gU4j5IPRp+2G1wtDjX6DIRxSzfvjRD1?=
 =?us-ascii?Q?r6AlDLqTzq0DLx9MrR/KH6vgPjCT1/smj4vQVgNYOBD1tMIRusw/iKx34rCT?=
 =?us-ascii?Q?JtaBs84suOSc4nQpotAmieOkW+mXebMiHpdSYP7VqeunfKiccMoEXVaCz/cg?=
 =?us-ascii?Q?WZVZtzP3H8zzSAb7sLfIclUvrO7PJpvA/Q0ofUgsh1jZ/yXjFw7J1qQBT8vz?=
 =?us-ascii?Q?1EjIIzwk22FBJYPJaow6LLL7v4mlx+fB90+IACS+waHrfQiO50noST6JmQPq?=
 =?us-ascii?Q?hSNYt/6nB74H0ImeBJn/PYqhb2Lr1Rm0iaSfl410agT2FAHeoYibrVun8z4g?=
 =?us-ascii?Q?Y20BWN8kqFSaGS63UZEJY3M9DNogP6SEkjyaRMjqF/7vnzuuHOBiJH3Irc0T?=
 =?us-ascii?Q?7JORlXlVxavPO5s+EcRuencOgUxijy4bJk0TbZ2YqgCrubB+obxB/ckMHLKi?=
 =?us-ascii?Q?jF1YCT2rRGdGhJd+2e5NcPoswTA2fVTvu4NKsVnRVKFYGexRzCa/a8WvUZym?=
 =?us-ascii?Q?JMOTTjG8Q0+shNZFXAYO0HRDustsZTUEBbij/1LYuNatFYS/Y0wg7512mwzV?=
 =?us-ascii?Q?cYnUek2ed2P858N72yck4EG2AnVEM5A0lf5LjlI3ExH1l6pqIl3Aoko0szq5?=
 =?us-ascii?Q?+BFljKbniM6gpV7uj8QG6kVKmi6++JNnu9HB6tTowjaT7sYRi2RVZU2ffyJS?=
 =?us-ascii?Q?PyG9D6k9Vn4kFHldjoq5LBW/1Kqg4iB02s4yMabitHQxQhyqM0PRN3DQ1DQ4?=
 =?us-ascii?Q?tt+9/zvFv3Pf1zls8SM46himBokXP+1g6D4mm6uPBemxJc+QvPqXikfkh7Eg?=
 =?us-ascii?Q?Hwtjsam3O/NDdApfBYrQtwRDaRsQsuR9Yw+GomtNvxO40qBDvIAfgRHJIY31?=
 =?us-ascii?Q?GOdXfh95qS+xRzIqllwtOBiMONI45pjQN10IIrLX6BrzREVyHyIyWr7UU/Y1?=
 =?us-ascii?Q?7yLmHRQhK3ym6GXJLHmrCFPNcC5ygd1alqeHChix755uhtTRCtIpT07w4PXW?=
 =?us-ascii?Q?R/Y7in99xclGgZGsLIW87wZfs8QF37dS9Lw0VDeK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fddeb388-e13d-4d31-67c8-08db81666ee3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 16:55:15.2741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZATtB023dmav/omqOxHpRb9KgOCkLX8D3qSynS4gktrVG6hz24i/4BLagkN3fsl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7134
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 09:56:50AM +0000, Zhang, Tina wrote:

> > Possibly what we should do is conver the u32 pasid in the mm_struct to a
> > struct iommu_mm_data * and put alot more stuff in there. eg a linked list of
> > all SVA domains.

> If we are going to have 1:1 between SVA domain and pasid, why we
> need a linked list of all SVA domains? Would a SVA domain pointer be
> enough?

Kevin asked this, we can't assume that a single SVA domain is going to
work in a multi-iommu-driver system, which we are trying to enable at
the core level..
 
> I've got a patch-set which takes this suggestion to add an
> iommu_mm_data struct field to mm_struct. I'll send it out for review
> soon. The motivation of that patch-set is to let the
> invalidate_range() callback use the SVA domain referenced by
> mm->iommu_mm_data->sva_domain to do per-iommu IOTLB invalidation.

Huh?

You are supposed to put the struct mmu_notifier inside the sva_domain
struct and use container_of().

This is another reason why I'd prefer we de-duplicate SVA domains at
the core code level as duplicitive notifiers are expensive..

Please don't add stuff to the mm just for this reason.

Jason
