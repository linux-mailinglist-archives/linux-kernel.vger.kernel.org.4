Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207E36C6801
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjCWMS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjCWMSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:18:32 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A50B360B7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1LaXoK5QM7tBGTH4PtpofkJ0tRwLpcJQEYNtDpgOg/S1+chueVfni+0sSJWQXW7gksue25uog/yNwCy2X87CTcWqQdUT1fRLFzTOKK7yecneOCVgJgiyEFTMk3wMayK4DgVGldye7B16yxg4aDQ30y7g/QbkXMCf7Dl2STCsplkCdMqNLJFPX/TcW1FR9uSM+BBZ9Lg/9paKwzp+TR8RS0g0s4dLjBSJ4rflS+BxDLK/CfdrfYm+J4+68cA2Pgp/8V4N5FfqxeMrL2/ZHK4TxsqTaU5tF2kO337XQGzbSVXlwJmgTUWa28KqahzmekNRCrHGRJ/AM6q5DrxQ/SpWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evcxZg2RPllE9P+XeEFcvgIo6h1rm3aOywC1NjjlirM=;
 b=decGDTQF33GNeRHY6A2/nHB+EtIS3cIv+nRjqxCfT/aR85JWeQ8x+IseN6DdyL+9kuyvqqrRI2301SIhoqBh8nfx9Zn08vP5vxE2AbHifmuD6LF8/20ZBtWxd9BbrhIZTxje5SR8WPWPe0EFurWC2N3CRBclf5hGLZti3K9plZoDpisnO0ut6qyoSXPEkCa0bjCYhpWLpxy6Knj2hCpUCuScsyR8FahdRWwSLV7FPpZ0/sQO1XUTXBPQyU8oTvlvUdtAMNy2R6xphYLDZGMB32jJirKmkeXryhSzvB8L9DFisDf3L8KSapdM9gNikeK9wTi3j8Qs8/ye/DfwLj2n2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evcxZg2RPllE9P+XeEFcvgIo6h1rm3aOywC1NjjlirM=;
 b=Ajk6Z6v3sJ4+RxA63U5mn2GHvzMKyDIsZsAMg41Wl3rW71ZFI4vvwOms8V+rsOoRvcHXO7HCxR6kpPs4V73xXKzA9Wgne2ttgx+HA8PSJhYWGxUsYk2xvebUZ1l2I7tOjKsEwx5eVlJU9VCTnjhr9cgBQl8qviHO7OiTlzX/xxwVBx53n/t/wGllvw595xKHaDFDxtJRIXnyLvNuXmXY738uYMGvN8QECXh6TDvX+i45s/7+SerBh6FGGRdcE+GurQKWVwcB+P1N+3jX1jE/PbBn1MpRZPGWEbDuos85tDSbIfC/C4Q5RonxD+9Q9K57dNC0sOQ7GfbVd+gVuSNUnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB8524.namprd12.prod.outlook.com (2603:10b6:8:18d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 12:17:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 12:17:49 +0000
Date:   Thu, 23 Mar 2023 09:17:46 -0300
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
Message-ID: <ZBxDavy99vg8OA9a@nvidia.com>
References: <ZAtYphmOuEqQ1BiC@nvidia.com>
 <ZAxsgjuuG3ziqs9E@Asurada-Nvidia>
 <ZBhZiCOQHAxEaamy@nvidia.com>
 <ZBiCEAqP1OU5EvoG@Asurada-Nvidia>
 <ZBiEE+QLjPpxBjkQ@nvidia.com>
 <ZBiRAVROma5/Os2S@Asurada-Nvidia>
 <ZBip4sbxUQo8RjGv@nvidia.com>
 <ZBjOooJZcUf182ES@Asurada-Nvidia>
 <ZBjb9sKkAddFmtOU@nvidia.com>
 <ZBtrs3UHK55UUNYe@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBtrs3UHK55UUNYe@Asurada-Nvidia>
X-ClientProxiedBy: YQBPR0101CA0295.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e29274f-b187-4b1d-c796-08db2b989e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2f2NubzXLeLPgf9kySKmkDVG42C6nT3Mq4liUdS1JSWxZXOkd3yMc3lLNT0hQk7LNl4074A5RZxYupM3rgJU2pFkTgmkHq+GUWoPi9par6Pq5mE1QlMvnEfl2pI6oVRp0uw3fNnaM58tEp6pOg2N9Ydj0EfPOIkXl2LzbnUBuSNHi2LTDgThJNC7ZHzQDlZLTpUbiTvzUXfGpCmuLGeAPXVpWAz3ghpXU28CXYzyNUh5cjONSODjN7I2r3o4Ks5cC4I9rUUpPj3hA3pb1KGK0VJO1IhIXE3XoPLsCPtODpaMtGS+9M7A0x/o/33u8E4Pd5Hwnd5mrtoEF8OkcAklnVdcIm7knsdXkE+w2F0ytm2aMUQpPPF1HcZL+5c6q9o/APFFfaR4Eoj9mNfBv6Tpk6eY1wZkdHDF7BlyvWxs5eoFrGWJwgT0KAx8INBbHRvK48AK6NYyEqDCJczS2QXIoZ9A/rHIT4m+JpMVz80k4Ixp5DwAlJCl7TBY9FY+597LSfyTwb9LXgj1/hHiFQSuunLItuEeQNmeRfoiwMKMQ4q6KqZQ/steHEj+UQ7tqZZWu5vG3Zh+lv8Lu4oXRnbPaw5TV+YY6KycxNwmEhC+cBopW3lvSDhCqNikkelFp0estKjAD9fYuIoHIePwYFGAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199018)(4326008)(66556008)(66476007)(8676002)(66946007)(37006003)(316002)(6636002)(5660300002)(7416002)(41300700001)(8936002)(6862004)(26005)(6512007)(6506007)(6666004)(2616005)(186003)(478600001)(6486002)(86362001)(36756003)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yE+s3mXVw+qd3pazXRQucx6XwtSs8hg/aXnJgVoboprfguXrwLEpqGdrovGt?=
 =?us-ascii?Q?1hrOx4kU263vbdgSIJJUUi7/bXwh8G+UsVGMtGGfktqbXwcKfHRAsUvO1USK?=
 =?us-ascii?Q?h5NFPRAsyDOQgU4XwIgnsN62QgwxT9wq1rSe2wBRHB10FihdTrLfYyS1cUoy?=
 =?us-ascii?Q?cUrpFrPzY5PmHsetp0WOktOU0R+WgHT52bc/Th6UW85Wnwamx2nnNTdcFiNe?=
 =?us-ascii?Q?P8Ys91396FuLs54/tXLn6w+2DeoWuldTQ/YatWuZ4+2WZKjdd986aX+ifeUE?=
 =?us-ascii?Q?SSB2SakoDazq/gb5ab5+qXbEy7Xa7lWLp3JBxRwOvwzK6qfMzyEC6QbaUrL4?=
 =?us-ascii?Q?bHtgCWqhdEkQJTHvGvQQET0yDeH1uLdKMOlkYtwQDiVF6WQcNJD4aSnbB/Q9?=
 =?us-ascii?Q?sZNUdUHAIuoIQnj5Or1Ld0hGcWxO8SWtJL+9BZaQq7l8yCnBlVHNbgs37Uo6?=
 =?us-ascii?Q?ECQ2GJLiaqxtYuEyK/OIUXap1zRoPXLDu+X38RtItWhr4s5wDprUARg4Zx17?=
 =?us-ascii?Q?qZ9SyReNtZE5gR/55kpA67jLZSrPHPgscmWlNukarcfjE2vGzkRxGECjtqO4?=
 =?us-ascii?Q?gB8McMUZpNJvqDqqDwgpN0uJBsJHPIyTxQlG0jO4WCXRDHfhRp08PcmZOFbU?=
 =?us-ascii?Q?mE5uf5Idlo8ydat+y+49NRkxX+iURGN89nAXk515dme0Lq0cOl3IwpghFkyL?=
 =?us-ascii?Q?RnKPYINlpaB8JILdIzF7hGgM5bQQw3hRQ1Xx6HpJpOhlSms0Cdxqldf+eGwD?=
 =?us-ascii?Q?K/S+MMAh0kb5c2VFfsRwQc2mD9LL5RtTjMTs4bop7+eRQgd6XpteWYxECPUP?=
 =?us-ascii?Q?Vkm8018pd9MiwlfTE/rksqG5pJjgc7bqPC71Sh4V3K9CJ2WUR4YzDfTMGEzm?=
 =?us-ascii?Q?M7xu/8UvZs+z5SfjJiFFhP7cbhaWdLb10IvXj0kO/r6zpsc6ex+RWXKNviY3?=
 =?us-ascii?Q?G3P+L1ZCaXICYra0R4AJNHtUxgQULdHNAgL2lPhLGpYq+tjX/H96pJpz8viO?=
 =?us-ascii?Q?motjoPjQp92finJMJFzPfpPcOFr/1OdiG/cfDIUaRpRYxvzBp6QYSV45kT2V?=
 =?us-ascii?Q?JmWfN0t2U2+Wcn/YkoU9vlw6iUqKdH19k1JPd+9S2X6vw4VrA5OFUPE8ePXH?=
 =?us-ascii?Q?QwU+uR1qFatfZpgh7tgB1gqiTN2QY7YLXdLIbf6PYOjP09TodVvi9TuxkXJ5?=
 =?us-ascii?Q?Ckw0GnpMu3VZnxKPq/rFTLrUfikiSkqSXPKPs9IFWPbEUc5aOA0Iu1roCeNx?=
 =?us-ascii?Q?cuRcEbWJodJfvvCNJ22hwyYYFIBqx5i16jeiCnXUySPpny+6KKhYEfZANw+o?=
 =?us-ascii?Q?BoJpxb7ZTyeWZb4OLzTVx93Qcm7eSfRnTu8SF1Imbo+AIfX6mTqpEuKIjPO7?=
 =?us-ascii?Q?2kHmqj7KsHp/Sm46z+kpF1wYlM0qb8j5lDP3OspCdzsN0wJ/nlQW38XOi46j?=
 =?us-ascii?Q?vRucJiIoSc5kCPjKoYVPLmpkYUsRBFpmEY1nsYpyA6ilfvFCpcTzrMhNmOUn?=
 =?us-ascii?Q?Mk8/4Ep/InwMm/mAVABcJGqROtzeFG/FsDGoIB7OwkCsGuFlwdLieUYV+zYN?=
 =?us-ascii?Q?FBK66DAS0Ra+ZsdeYJJmq+jHP7M0ia4dlnVjnviV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e29274f-b187-4b1d-c796-08db2b989e3f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 12:17:49.4622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDiIwDHrnH4W4NO3JuVux3qP4jWh/rk7K9GDQKoOlyPBDrSvPpn7MhpgpAZHbeRW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8524
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 01:57:23PM -0700, Nicolin Chen wrote:
> On Mon, Mar 20, 2023 at 07:19:34PM -0300, Jason Gunthorpe wrote:
> 
> > > IIUIC, the ioctl for the link of vSID/dev_id should happen at
> > > the stage when boot boots, while the HWPT alloc ioctl happens
> > > at CFGI_STE.
> > 
> > Yes
> >  
> > > > > What could be a good prototype of the ioctl? Would it be a VFIO
> > > > > device one or IOMMUFD one?
> > > > 
> > > > If we load the vSID table it should be a iommufd one, linked to the
> > > > ARM SMMUv3 driver and probably take in a pointer to an array of
> > > > vSID/dev_id pairs. Maybe an add/remove type of operation.
> > > 
> > > Will try some solution.
> > 
> > It is only necessary if you want to do batching
> > 
> > For non-batching the SID invalidation should be done differently with
> > a device_id input instead. That is a bit tricky to organize as you
> > want iommufd to get back a 'struct device *' from the ID.
> 
> I am wondering whether we need to have dev_id, i.e. IOMMUFD,
> in play with the link of pSID<->vSID, as I am thinking of a
> simplified approach by passing the vSID via the hwpt alloc
> structure when we allocate an S2 domain.

No, that doesn't make sense. the vSID is per-STE, the S2 domain is
fully shared. You can't put SID information in the iommu_domains.

JAson
