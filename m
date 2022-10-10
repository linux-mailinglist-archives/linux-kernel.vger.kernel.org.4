Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6665FA38B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiJJSp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJJSpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:45:55 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D7059256;
        Mon, 10 Oct 2022 11:45:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMHxF9IrTsY7KUl1ZjqDQYIRgV5elkRjOT0RKt4TGVUTNVw/apOtPVcH5jJK8kaoGmcW51EiZVSSvkoV2mqzVbQZ3397jmWmf+4/pag6rYe5L+9MUntjpLqlUlHcfFztmhcRrACNDnH7BE/rpjZj+kW1/qG5aO1UVMtifgl54sjWLp29QNp7Jd8FOTKmHDOdWZbEgLF2nc6LoOgqs2z5POOfeagoyU1ujwW60VgAHynXkqYDHK7sOafaR8UJp+vAqDYBr7gJTIN3IWe4NRNby3n+HxmqlPwwUvmhxNsUKquwGcaQUsrVYqaSJ60THEPiyXPRKWwYLPY24QosW3q70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnDssGs6oWesvpYF/5peAyHxxbZ4huPtO/vMqLO2QgY=;
 b=aXoGy4sALUWUl0w/BhEBmcw3VLAxWWSqYZqF7s3tYyofQclCBU7ejXbUgBSW6CgOAwCc8dPVSVZZnI89CaEdD7HFKcyeXIICTIwrnHGodOUXDsV1WqxvV9OJ7naPCrIGlwAEgWQl1z3w1nwy/lHq9t85MY79QG0q22TxKY3bLBeSzU/XIYQd90T9Mg+jqrtTyhTK1mujOid0D4QC1NrSmaJhfmK3shcJPmqqOMdHNBgDiZ4jvgYJrqxCFP3ql3R9679Cjc98gvjwUb6IvpDJb7VN1bgpcHk1Wwm48ScNlvLK0Rgxc87ZMQLA8B1nEp7hVnjjLlWkPHUxq7JzP3Aw9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnDssGs6oWesvpYF/5peAyHxxbZ4huPtO/vMqLO2QgY=;
 b=oh2lapGkU5oEOaYucsnbUKtzvWNgzYAt9hin+Q5Cy1dKwrlPefFM2jBMmyV2vmmbKJBTXuLPAJq+KIma6398MnrSOePyUalCMuClql2pEX37JBAtJZ00c7OpOaa0w0KnN+C3rJHB5aGjbhKte6rVT+HVBUcOFUN4XA40O1O/OFQ+9LlunuKo3S3RCbAT0NeMd1LhThrrHUKdUpcSUDs+MSDGGr/nvxR7eisTM8AY2aJP/aN4EKQ4dO21RwlGe52TKMJTrl8CabuNggC5Bhv8gwzH+2dW0Toki8NtJc6lJmlGZYui7rgEDf2L2ZjkbjbahArEIEAcQLVFvMhYPpGolw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 18:45:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%5]) with mapi id 15.20.5676.032; Mon, 10 Oct 2022
 18:45:50 +0000
Date:   Mon, 10 Oct 2022 15:45:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/6] iommu/s390: Fixes related to attach and aperture
 handling
Message-ID: <Y0RoXXclqRiMzN9T@nvidia.com>
References: <20221007095005.2017126-1-schnelle@linux.ibm.com>
 <838e7df1128e52ac5229307dde6690c2e26b830c.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <838e7df1128e52ac5229307dde6690c2e26b830c.camel@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0273.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f5f232-06dc-4a1e-65bf-08daaaefa6da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VuYXvtEhL1ep4224YIiS0glHVZb5Nr+JvsHLrZlaXp4jZNrRQY2airSdJ//+NvjeIolPH7mYuIQoGLRX5P0xBTgADXt/bGCYD+FwZ8MZxWUt9NskCP6jI9IaVG4+AukTWmGqhN3x/LQd9sgWbN+rHtXJdkaeEyvyr5LDtC5iwpPZwcXPZVwjE3chtn0lZvB2TYQJs2/fNlEJHr5nNi0gHviBP51PutwnKttl1AajWzQa8yhfNgqLBtfBhL2XxHgmEvynBxYcBdUohs5TGf9tpBERhOFQc3w318z37OyD92/czG6Udw4F3qxYy3B39dz6HrnzzZn4raIyyphb2tX1uRIdjGmUEMtSL4HCbNns1vMUVanMecpC31QXS0RAa287S55iMTygjdBhwZUVK8TuzmI1eW0AT+oxX6DCmPd+YpE/CYGgGK6+knCqwUYieHFpmPLu5WQCu3bUVnCiTLd+jn7U9uoXwYB7dNPfQ7FxDeYXOVt0YrcAt9GNPJssZIZgotldtxJZr4u7xSKFsZ93DdJp5AZebbG0a4FkjMxH/z+/bdg1QyTnOI6AAIAMkKgy1PMHy9BcBTJ/ryBzZ2YjJj1+6xV4snTB4Yum5c4HPWZ1C7qb8vDQllOUhQpyH8o+fzxyRkE2qoPoh+4+oK3eteEiYnD9K1dc2z+Q1crzWULc0CnDRnGTrrY3NOOy2tV3gkE8/+qDvR4PtcFYBc4+4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199015)(36756003)(83380400001)(316002)(6486002)(2616005)(86362001)(2906002)(26005)(6512007)(66946007)(4326008)(66476007)(66556008)(6916009)(8676002)(54906003)(38100700002)(8936002)(6506007)(41300700001)(186003)(7416002)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RsspnB/uCjQDiomFm5jOcteVZzYwGSQ2om+d1QEC5wQ4XMSK3oqse8loGYDQ?=
 =?us-ascii?Q?OFPtb7V3vTC3s9Pa8xCW4u15lRM8mym4wqEZOia7SbwRkE2uQZac+mYzBiqB?=
 =?us-ascii?Q?vYKn3AjIoPLdniWy35sxzgu/chXNaIPRfV2jg6vRCyrtnvCHDu+WO0EwSl73?=
 =?us-ascii?Q?fGxYbbzj3u2LF5h2MzH+PWGcM3IDSe2Od+9qG2Mf2A0COUjSQ849armLVxyv?=
 =?us-ascii?Q?P+ghwLUEwZPyh7W8IZQJLMMu4ZEJ4kqK5tVFpbIuqrw1L7V/D5ENyXAOHo1O?=
 =?us-ascii?Q?7hW9syeWcXhtUjfCwVUJsaRjQOtkEm4KBcmRTjdXC4E4Wdw2rYUPns9mYqRS?=
 =?us-ascii?Q?GU26OAoJqPIVCj8VustTvJX/ArmduV3ja636+tlDeG9SOiMLwj4FluIuNQCK?=
 =?us-ascii?Q?mlPKJJ68b+t1j+fMzF9T8H+naHVdaJepK+oPhLgrDRJO5We18bMQAfVQw70i?=
 =?us-ascii?Q?Af8CQac3XcQE5uHzQ/nhThZWNr9QINFP7yhKXTE6tV3e/zDlUl4eDiqDFx0D?=
 =?us-ascii?Q?xr2VJPlwO/WCSdv3ckXbPNB1DZaH73PwszLLO15XvCmgeRpXoecLXCLa4vFn?=
 =?us-ascii?Q?5lmljVY5oerfxPt9JYDEvI2E371XawRYcz8ZhCIkGMSBuBy1GnduU4dGF7ZE?=
 =?us-ascii?Q?zwjjcUHEQUOQYJ9lQ/tPOqTHjt62zkyTPHLnDV0etokZC18Umdz3oHFvEGFF?=
 =?us-ascii?Q?qm7GH1OscEK5FAYilpkrMSZJZMnu/bcYcnNx7A5WGiXiuGjy3E032EAS3UOz?=
 =?us-ascii?Q?CIpz/hL/tQHQ1lXyi6Pb83/PlrjUayd5E1qIdMI40FO9BYGTivzdUd3sWVz8?=
 =?us-ascii?Q?izh+OmoHI0Z0Tq2eMxP0QfCWBjKGQVutWxGB8YIx+1U5FdtTkMZyIt441EU3?=
 =?us-ascii?Q?ZpmQO7iPHtqGfqmZDGK+GakRSrJWPjWxCwuzDlW+j5ZYs/zIVHDdwEXBfmfn?=
 =?us-ascii?Q?vinzJfZspXBkTsk+9+2kpx6RiaIYyZXZH7dMwkOY0HV2Qs0uWK9tjoI3xsxJ?=
 =?us-ascii?Q?IDzOhHCHkPvOA8z3UgRyIZRAgwgBoJzskRdRlU3aqx0fMGVYjuaf4EBbOmAv?=
 =?us-ascii?Q?E3UI277K2RddIuCv+0QFmPd7Ui2fK3Fipw31CMGJt/UG7k70a89qScjsM0d/?=
 =?us-ascii?Q?Y0Ohhy+gQdIRU3mzweuybjj5qZ9JL7ybjLaIBCG91lpnqCMajLjpVI9Q9QTv?=
 =?us-ascii?Q?apZdcS7Ym3S0G07OMNIADlCjetAcXcMy5vvPs+sjsXSQXA6m0XVcDfP4QD8o?=
 =?us-ascii?Q?paeSKac/oZMTwYGNoiHR4OfckKpA1pi2mKzuv30QjeEz0U0gkyrldiA2ZTaX?=
 =?us-ascii?Q?9tuqN5/y/EbKKaFR5Brc063vBnBe8OQLRfm8HIEQNqwM1zLAx8moNFKZ1BrX?=
 =?us-ascii?Q?rHCAE6ZcQKpNoC+c7wkoebZG/flkUWQPOndZsp/ge4idooELQCVBHLYi4tPm?=
 =?us-ascii?Q?dMAwbPsnX5xU+es1ZZxIZiSHbiH8WcpGRPrKT3wu5zaL2A7npu4vJLqJ9Kfh?=
 =?us-ascii?Q?hcSvwE3ea7fXmgSAPkDBs6qnQk1Fat+Lt2zkf2XsITW1/bCxmj9Ru47q3HcO?=
 =?us-ascii?Q?y2TE1mJoD12+AIOlfiM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f5f232-06dc-4a1e-65bf-08daaaefa6da
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 18:45:50.0832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JLA3AelkSIWCxXwtySoKsdWQw3Fjqq5ohisAGeNJpbF5QA3owueUzdSTFtaQVUc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 04:54:07PM +0200, Niklas Schnelle wrote:
> On Fri, 2022-10-07 at 11:49 +0200, Niklas Schnelle wrote:
> > Hi All,
> > 
> > This is v5 of a follow up to Matt's recent series[0] where he tackled
> > a race that turned out to be outside of the s390 IOMMU driver itself as
> > well as duplicate device attachments. After an internal discussion we came
> > up with what I believe is a cleaner fix. Instead of actively checking for
> > duplicates we instead detach from any previous domain on attach. From my
> > cursory reading of the code this seems to be what the Intel IOMMU driver is
> > doing as well.
> > 
> > Moreover we drop the attempt to re-attach the device to its previous IOMMU
> > domain on failure. This was fragile, unlikely to help and unexpected for
> > calling code. Thanks Jason for the suggestion.
> > 
> > We can also get rid of struct s390_domain_device entirely if we instead
> > thread the list through the attached struct zpci_devs. This saves us from
> > having to allocate during attach and gets rid of one level of indirection
> > during IOMMU operations.
> > 
> > Additionally 3 more fixes have been added in v3 that weren't in v2 of this
> > series. One is for a potential situation where the aperture of a domain
> > could shrink and leave invalid translations. The next one fixes an off by
> > one in checking validity of an IOVA and the last one fixes a wrong value
> > for pgsize_bitmap.
> > 
> > In v4 we also add a patch changing to the map_pages()/unmap_pages()
> > interface in order to prevent a performance regression due to the
> > pgsize_bitmap change.
> > 
> > *Note*:
> > This series is against the s390 features branch[1] which already contains
> > the bus_next field removal that was part of v2.
> > 
> > It is also available as branch iommu_fixes_v6 with the GPG signed tag
> > s390_iommu_fixes_v5 on my niks/linux.git on git.kernel.org[2].
> > 
> > *Open Question*:
> > Which tree should this go via?
> 
> The conflicting commit that removed the bus_next field from struct
> zpci_dev has now made it into Linus' tree via the s390 pull. So this
> series now applies cleanly on mainline master. Still not sure though
> which tree this would best go into.

Arguably it should go through Joerg's iommu tree since it is only in
the iommu driver..

If you need it on a branch to share with the s390 tree then send Joerg
a PR.

Jason
