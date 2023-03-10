Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D3F6B4BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCJQBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCJQBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:01:20 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA78A64B5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:56:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwVsM0fsH0q/LvYkRCBhF6me8nlbUTWb6LAHQJgXrEMY9yHQeTBtVZOtBf56G/d/Rj6ica8biJZ4nGC2qYLHbpzCCYoynO6B0MiJwDpANQ4ZQvxANhjEpx/b2OEZVoYPNauiceCGi4BbyEq0qFIjfd5mKiNn54NLpcS2fYwDuJoHDXqWPKb0JFPuPbyyRCHpsZ5noHVFL0K4yjYzN/03paXB4hWm5EnNTWHyg0QuZQ7vxa//Blm11JQZ/jtiR5JJuXosThStWRW/AYjSmkDnPe3VbrtzHuDqJ9S/cmFlZEmc5ALXR5XZt6Y9LVtO5ybLBRaW8SfpkXcB2xj+sYemqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0lHmurMdQfyRg/Zo9tXSknskVO9VsNlzlJ2TYyCotM=;
 b=P+J9Pw6lNmTm+nJH/QMhbmcjqRgXKjCqYFrcPQcQmIRxCQqQPKqN39YNQGS2YXYMyB4vBdG0h400SnIDpUE9DaLX9FYFQRdnZjMVPZD7HecJHEVkW1u9tCyOLWsHuDKVYHSRhWZ6R7RdfpdLVcwdj3FXTv3Kuz+uEqsatnHe+NQy1qbnYkNhMDXdUPpXLe+lOz/uZymZhYQ7CvcJGhM+qOnA9Q3FfU2gP3iVLO2wmqnF3ueHMNcXDqOdLA47g/aiTCzkM3g10QYHccNqWIhtEt+r2G8IRrUwv3sl2ezmIA87jU/jyufvQnucSgPFHGuVy516PeryTOAY5gk112CkUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0lHmurMdQfyRg/Zo9tXSknskVO9VsNlzlJ2TYyCotM=;
 b=GNZVqGNC+g/bUPWWEFmjcnKgUNI8gm1QPqYZ7JvBluFov0vzOmROZJmjFxLXpOG+JFOs+TkfjxbsHkX0hldxl96YcIOFkjFKWDmIeOSTkAHh3iI2rfo+AAzx3SkThrkRDamIkIY6bWeOtWD3Q7Rs1OPV5yAYLlz7xOfE3qRwrusyE2qEWUnVCjOtE351IyrpobKpRbByD+9LqL4mMSQGNEKik2hEp+qAVZcJh02X2fnTrP3nWwt17R7kTJ3+/76NHCOgrlDDAmHwW4QjPcIDzn09h/t9pFuOAweQJBqReBGdqK+pBB9XjnAd18Y2w3heOEL/2e4Eu5WXeQfxCAKYPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 15:56:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 15:56:39 +0000
Date:   Fri, 10 Mar 2023 11:56:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Eric Auger <eric.auger@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Message-ID: <ZAtTNK1NbMJ4iyE0@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <eddde530-cd37-f493-7f0f-c97905f0de64@redhat.com>
 <ZAtNrFAEHvmM4FOW@nvidia.com>
 <f61ca5693d8845eba0a2139324e52d98@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f61ca5693d8845eba0a2139324e52d98@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f66cb4d-1787-4d51-e2a0-08db218008cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X0KkUcCHYKbadGGAVcSRJJ0h8sfSWKz/wuLu6AFdpPOk+jtGIG6jlGZpEzR/eXpc+8eWxazLLWIpow7TOKKc2agqp/zWvjXtPxVCoxLATeM4MimBxBa5KdQxrnA3ertQ9Zr6NZq9AenqqqeBMi1mMD/IafWJGQ9tuEqSL/SBXo70BRcrEIquHx+cMD1XWwPQ2eiQTcwEXmzMsSK6qmK5SSNG1uVuImFgLhdxrdvxHpsaV6oEwKciOas7Zc4HjBasVPlpVt9DZIaX9FhUEpNt9aL9WUrgeFLMAWO0M9WtvbDD2rIRoSbkl6ijDEB3DRrV/DLpNRQw1+BrxUcHUeaxVKDzFnD2uwI7emQlhq8c3ZWEKOuHmfi7cAN+8KzktW4SaP8TALs6V6BuvkBL6xXzBoKgdUxsbnrCiR+E1P6KxyVSVNUhFPphmCY9IPcKaA1so9yTslp3+J4ETXPkDWiW5RhoJLgsw0+93rLJYyJGVXdsrRwjdBGZ28iCizr/HDNZm6oIu3vUfpWKIDhLsTzFRnatw2xW2Z4lJph3PvaGdMvZyyjFwblxX4XcxeAs7XIEI7ce/rWzc76daxQwX8TYygWrcTvUN3hSqrRhdDAe9b8loDRNagyLzYW2T87WGdbmy7KP/pwvZenZ6x05eikgolMYgDQAhqBd5NyuxTsF5+Gj7xsmuqN++54ubKUsSuzu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199018)(8936002)(36756003)(7416002)(5660300002)(2906002)(8676002)(26005)(53546011)(38100700002)(6666004)(6506007)(83380400001)(186003)(2616005)(41300700001)(6512007)(54906003)(86362001)(66946007)(66476007)(66556008)(316002)(4326008)(6486002)(966005)(478600001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?beIUcbfoO11TAq09WIg1WjftKaGvrBvUjjxmSekohRR7gn/DlV6/B067AMNC?=
 =?us-ascii?Q?Mzzaai41+YjrUVbf4uNeWPXdmWBtOqq5+2Yh3493TKmaVch/Z1HB8u6r+oC6?=
 =?us-ascii?Q?9I8IJ+SQxZsqaoIEdF3pQMcA6NuUti5awT9GEgrXjqJWiPHcxinyqAISot44?=
 =?us-ascii?Q?Dy5HkdxDwYVNMfG6lCepeHEm0fYmbs3zrrEBlYAEQ6Ic9rq3SP6OMuymbuIv?=
 =?us-ascii?Q?4306jifNmkFKxP90tZW/BWunnYZHGggvDbM4ny6MNdytMIR4a/1rc1yKZPn5?=
 =?us-ascii?Q?SlpArROAYUTm7qHRNTtDoMxMf7fXtq4CT1wY32ApjeVLliXbx8Mkh3Sv/pjJ?=
 =?us-ascii?Q?StiKRMTSi4epZhQPbh52JG+kvly29uPpC0YyHQ3FACQA44JmNcD0JT+fYZsP?=
 =?us-ascii?Q?UtFKkaVgYX0O2NyBH8EQNL2uMHiUCvra/OMIEmppeMSwsRtQFbFINMoHTPaj?=
 =?us-ascii?Q?i6oM21WaxTTMfCpnIDiy5aVIQzNQo4wp+8DP6bZq3u+fN8iVMGdwZHC08+/c?=
 =?us-ascii?Q?sjIP6ZQdcuYjMCL/cojrBzuTkZ1FxBg2UpUR6Q31PqnlGNRZ3cP2YlxUgWOj?=
 =?us-ascii?Q?3kSfGacWDFqkptii5Qs98LmiAjAa7mPpxz//pRx4x/+stmaohdO7/re7MJ11?=
 =?us-ascii?Q?0QxKcDzkYei+7vC00AmNYnbOpGtbmTqeqJIx+v7YcKk+nltULeT8oN4wPXos?=
 =?us-ascii?Q?pjMYpX6h/3n9UQwFROM9tCh2tXMoR5O9sHR5q23FHONNoWppxQOChHaOCMCc?=
 =?us-ascii?Q?MY7NzjZU3+48MPBkYhT3h08vyRaXQtNVwFXjFUn6KFreNIOKnk/Q/aCxoyWV?=
 =?us-ascii?Q?AIWl7DoFn64K7etzEJznGlpUC7d5cLkBKtS98gehOTwmqtPM/mUF6XzuE040?=
 =?us-ascii?Q?GiM+fLM7E61vEQNy8ks/YuhtYeFuRELbFWn8wLA4xL4yTh3oycnzSMY+Z9A+?=
 =?us-ascii?Q?AT1srk+9IBfCrYuPQmk68dG+avB3S2e8k/5BpeqUQJ8vctue6YtiAPexdIpR?=
 =?us-ascii?Q?m8mFv51q4eameJ48oBov43up498pmqQQx8OMkDlV6FLH0jE8IGABPdaGRC3E?=
 =?us-ascii?Q?F4jbPqIHb4j9C5VbquvxvMdXPkiqUAGDRQi6ViHq7ToaAnqC3ysW/SLIY58U?=
 =?us-ascii?Q?+BbprzCMmRwIS9a80DMgjFd9eLUh3QKG0L4JZCFqucz7LLp8ECyz+ayhPyQp?=
 =?us-ascii?Q?nBQTE27uB5hHINU0/RljrVFXp9CG4DmQwUjT+9toovxTbD71T9VEcXo5dC+c?=
 =?us-ascii?Q?mNwVDjm/rcBFyxWFzcwNZESVkctXpUPKUGhkN9gf4aEogN6MkMmj2wdT9psD?=
 =?us-ascii?Q?ZDze4n/ffx+ZRExLdBY8uOEc36APcQ0fQWw/gnyQjRFgORGxs8/95lxW1vq/?=
 =?us-ascii?Q?1S7jMe++TpRCRqJ1pFqquGpXObHtoZTIbCihWRuRn+KAAs7FWyoCeLkRrWl2?=
 =?us-ascii?Q?QrI+whjE0DVzMXRPL2OPZbeS1BgBWxVQSKByNHLya49l+4GDtp/uGZ4iQll3?=
 =?us-ascii?Q?InHobWW0x/WL1FYodoFb9R94sbbje+VQ4t+ZrQh2TVPMSpHAy2+SaJKS+eZL?=
 =?us-ascii?Q?rN0PLiOhYoamZUxom2AnMV9gMqrNPhW5VGQnTSja?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f66cb4d-1787-4d51-e2a0-08db218008cc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 15:56:39.1210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MemlDcusNIKxptbOoGoFsOLyReuH8F8ZWGtbi/DKyfO3ZdAR7NShAoviqy7ypDZz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 03:44:02PM +0000, Shameerali Kolothum Thodi wrote:
> 
> 
> > -----Original Message-----
> > From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> > Sent: 10 March 2023 15:33
> > To: Eric Auger <eric.auger@redhat.com>
> > Cc: Nicolin Chen <nicolinc@nvidia.com>; robin.murphy@arm.com;
> > will@kernel.org; kevin.tian@intel.com; baolu.lu@linux.intel.com;
> > joro@8bytes.org; Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com>; jean-philippe@linaro.org;
> > linux-arm-kernel@lists.infradead.org; iommu@lists.linux.dev;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain
> > helper
> > 
> > On Fri, Mar 10, 2023 at 11:14:59AM +0100, Eric Auger wrote:
> > > Hi Nicolin,
> > >
> > > On 3/9/23 11:53, Nicolin Chen wrote:
> > > > The nature of ITS virtualization on ARM is done via hypercalls, so
> > > > kernel handles all IOVA mappings for the MSI doorbell in
> > > > iommu_dma_prepare_msi() and iommu_dma_compose_msi_msg(). The
> > current
> > > > virtualization solution with a 2-stage nested translation setup is
> > > > to do 1:1 IOVA mappings at stage-1
> > > Note that if we still intend to use that trick there is a known issue
> > > at kernel side that needs to be fixed.
> > >
> > > ARM DEN 0049E.b IORT specification mandates that when RMRs are
> > > present, the OS must preserve PCIe configuration performed by the boot
> > > FW.
> > 
> > This limitation doesn't seem necessary for this MSI stuff?
> > 
> > What is it for?
> 
> That is to make sure the Stream Ids specified in RMR are still valid and is not being
> reassigned by OS. The kernel checks for this(iort_rmr_has_dev()),
> https://lore.kernel.org/linux-arm-kernel/20220420164836.1181-5-shameerali.kolothum.thodi@huawei.com/

So "boot configration" is more like "don't change the RIDs"? Ie don't
enable SRIOV?

Jason
