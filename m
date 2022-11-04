Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5754B61A0C3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiKDTVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKDTVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:21:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C152B1900A;
        Fri,  4 Nov 2022 12:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZSJPnU0FXs8VqCMoeNqk2uKnGuEjTIJp3S+asJyKgYx0uZzioYE/+LcCpV+/AcKgFNmJ9YpytdVyuW1IpVAHKnEo0Y3k8zM/mpDlv66htKJtTel9dIY5vasFJrnL7jaWk3pEl7Kyaw+wfCK3Zos5tWrPJT0Q1NG5tHKI7AiPoIRMUc0Slk3VSTv+i0zuEax3IRJtNJShKtKd7N2oDEOQe+wwKp3GlLo5vRDg9z1+naV4DwEb2qGnUm+GzlFqcWIEvonyUfY5nhaEze9dDgOSvMFaffpUonfcm53oSs9I28/pXHwNdg+ez9mDh+VzBq/dD5V4hphsIeX3l4EPuLnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxR6TPfYmHOkTwfdlau92wMETrvVX6xZo54GA3HsbAo=;
 b=CTgW3afLhj8MoKUmB+759BDhTqjRojB9MPZPQJSzFBdEcUcpwJ/2no6xlrKUWqjbAxysk6XefR0Hy1XiDjuUWnoeL0G4T4lIG0o9bZsGjVh1wyClLXF72cchbPCZwl1pPCr/p2VRM+XTLw8WIFmbbj4umispKbAjHguFdm+ToVd/oy5S1movz9AK0YJPH0Qst3W99+JUkgEO7w7GinkVuop/cwBkDYUp067Mx/GrjeFlcQoaHo4IfZ5PLmgXH5TCEWWz333I6HexT4v2AF1702kMKClRA0kgsZ11obXWMauj3zEpXbsDSy75j9kkf95vgZPXdbGdDxHy8kbbPyJdfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxR6TPfYmHOkTwfdlau92wMETrvVX6xZo54GA3HsbAo=;
 b=HtHGCYruOABDTBr8K1K7+wgUKnTfEUAL9rCoQt3g89Xfg4TAhc1xiVW9UGRupLi7pgVue4gmjqJ7kLOX9j2QminkShaDCZl1m06RfmjB0DC5mEjUPqpkY3XEMey13QlshVNDgTyopC2r4ao+kKLC1Qg7DNqWVpOwx0VB85oqzEuwRarUNkXced67eZjLGdRbALHtHfT9NNOtRJ+i2SJz3y76eVFJ3X0yHJSPcZsZD3apPJoF91stV55+SI1bBFOb7E3x+P6jjNALR418358oPSmtViOsL8mKio/lbTmccK72cUGJQ8jATUqUogIu4I3dLE12YGvoyZ0nhANBetZKFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5892.namprd12.prod.outlook.com (2603:10b6:8:68::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.22; Fri, 4 Nov 2022 19:21:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 4 Nov 2022
 19:21:13 +0000
Date:   Fri, 4 Nov 2022 16:21:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the iommufd tree with the iommu tree
Message-ID: <Y2VmKcQbyBzj7p80@nvidia.com>
References: <20221104152434.7233ed45@canb.auug.org.au>
 <Y2UGmM7nP32KUfmo@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2UGmM7nP32KUfmo@nvidia.com>
X-ClientProxiedBy: MN2PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:208:160::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e6259f-fb0f-4011-f8aa-08dabe99bd12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 04d2IJTNp1qYdAr4d2j6uPZdDxy4WDHRCfpMILriiHynDsXJJXv8GAaVpErN/zWPIVx/occy0J2PX3aD+SbWCL8IOJUZ7HSsmiki2pfh+6Wlrspe11ueq2Kjn85r0fvCE3Q+KeAvQX4A31d2mcA1bymIVmXwFcR6tprjnF9F2bR4yl/8Be5kes7PlR/FTtdf1pAeYmxqs6jcRgs9Om+pY4PaevvDRiBv1otoHBc1hfeAlAKcUr2Td8IlYmmHDLucxKRFQjccqWB9FosdX6cTQZh/bj4+G5aVApraIlOvKYoeGUa8ZdeMV6nv0RVMhWYhC/PACdpBQ/ga217jXWfKEhohVIqvTC49oUG9kyQVEKz5IGUM1Mbgv1/lWazR9wT3iLk0sl6u7kgna/8W0HcrV5sdRfTgESgdghYROYNZtkAWj0pHkMeR34wch0HJsBnRs06G0suEsDQjVTzA73oPVhhfH0p97cQTSJ/U8gaPxIlZl2ue3R10BCklaWJD/R46/+Vfl8DAhrUtHImywkF24u8zb+UvZKyTMDLWGUa8xxVjo9+mvYYdf3/iGDT928jWSamDi9RyhstdGfiuBFVohChFE8l2nR4D8khwiM7+ZVY44+clVLbv0RIQA+MnPnqUqITIV6uWrxzI8qVF6HD/PCSfrBNwPqy6N+WODraYlWVzcwsCX5aoXuULR0CQMJbcAUFVUF4+dVLB5vdXR3WDdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199015)(38100700002)(6916009)(86362001)(41300700001)(478600001)(4744005)(5660300002)(8936002)(66946007)(66556008)(4326008)(8676002)(66476007)(54906003)(186003)(2906002)(2616005)(6486002)(316002)(26005)(6512007)(6506007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eqg+/HYrsJ9PmgSPKADVAUfq09P4Oz7UyVZfXhGKfvVcikBxQXhjY2UXJyEA?=
 =?us-ascii?Q?TcJV5Mj2T8v2L1e+LeVGlFY+gJuw/kXRTJdC1K5VoW9BX5nCDG8eMGFm+Tks?=
 =?us-ascii?Q?oAYOZoujODPot0sdvkyCwUHAIj1MotQMpFwQSVlSXu3lKLLx9wuq3l/kj9Um?=
 =?us-ascii?Q?goeu/ZFjhVmOrzjGTqYI4tfJOb2zI94mzHrka8QHmqerpy29lrEZtDe7n0g6?=
 =?us-ascii?Q?u8bVepD6D1N8Oq3llY71Sf7LH7cEMpC9LKd78AJ1f5Mg17R8L0nAKXXbvEd3?=
 =?us-ascii?Q?GhTz7C4F7Uo+LPjY1ZKWobMj9jsbK7AjCuzEt5MqdDE8ZMt2nCTpGsQmmds6?=
 =?us-ascii?Q?BUGQX8ISuWS1c+7XGSFz7EWigoIp+yMJkfmsckCH8Gjp9dXqxFbjByW1G6HE?=
 =?us-ascii?Q?zrskbeZnqXkiivkbJg02pvsuFUFbr1wyLh/pzFW4YnlrdiahoBMcJzB/x3ti?=
 =?us-ascii?Q?6BTgXjWUzTud25hlLKCMI3HY4rANAvnRKgwHufRBUKs8qT4Md/t/zpevGEgw?=
 =?us-ascii?Q?kKSPLUbhUPahaUL7CcRb5A7LPi7+Svxlv2hdN3R1zkmJf8eVQa85ogLbOONd?=
 =?us-ascii?Q?BeedASA7aaqcyMXSuffjw75T7V/ZQyF9Gb/1IWfZ0YwnZiPzUZk0BgDQMe6D?=
 =?us-ascii?Q?53hLB690bHPaMzVkEJ1hi0XoXC4klIWIvubXthVUfFDqcb0kyzeYo5g9QNml?=
 =?us-ascii?Q?dDm2EQCpgmbdLs/60o7URSM/w28EUQfKVTm6JbYWoxjgRoXoSYGf5b+i9ZRq?=
 =?us-ascii?Q?H+QsI85Jjotw/gzccwXpbDCm2F3xarEF2zEk7+mZS2TOIWxDW655Gs8iVtj+?=
 =?us-ascii?Q?omxrGIz3N8nL3EoOh2qhFam9FIHiSGMO5xPYytoy0uVAniB03OJn11ZGpx4h?=
 =?us-ascii?Q?WaK2TNQYGIo9AsBNjajmtNzeXHSzKOq1bXFnizHlOLaB1nf+fphu+wCxH5d3?=
 =?us-ascii?Q?sTxlZfn11Y0hGWHwuyuTZiBJFIN2wuzXKqKD8N5ihG/nBiYojt1sgFOvYIEv?=
 =?us-ascii?Q?Y8gEyZDcZ+66Kb2/F1CaXwjhvK0E0DdDvK+RqivuHoAm1WkLRFJicCQCd8Ro?=
 =?us-ascii?Q?Rhu3JlIUbNaog+2pvcdZbHSYN+5UF/jUtQXtmVx3iwu/WSXNF+J/96pjYIUJ?=
 =?us-ascii?Q?zBM3IeULLJjfDJwuWqMVRtU1ZSEg5rS49AhSpOTRaW6oos19vUrj+VC0+a1f?=
 =?us-ascii?Q?319d0x4mOBiopotMX2FofpcEhWLW+edDBhTgUW0xZoSBOXBTKQDH9Rkb7say?=
 =?us-ascii?Q?ZcsS+gcZh1lEe9QsOqVn4FgEqVKK0Aea+cRCzACRvKa3OmqtRhQYwTbfe2DP?=
 =?us-ascii?Q?j1KscX1POZkxuUsxDv8r3aeyUBH2xentesrryjqB0NT+/NR5SLJlpTflPIVA?=
 =?us-ascii?Q?zSQ4gWREvQR+b3OqoRfBwY/se7+gq+5MJcU0mP6s+Uooh7kWpipJVy6hryEC?=
 =?us-ascii?Q?8VUlQBwn9S+BdciKyb6GBY9xTMSY4iyEnuFDp7uL6kSzxY8gnWCV+BCOj8Rb?=
 =?us-ascii?Q?7FrRS9pmB2Z2YyQgUWek9MdHzrMbuW8qJdpJ06OqHu04ahCXWBgRBGiD+geC?=
 =?us-ascii?Q?h2FkptGhebfl8UvrULk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e6259f-fb0f-4011-f8aa-08dabe99bd12
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 19:21:13.9333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6A8KqprvWxLNnhwopiF24CZwQfec/ZZGXWHkJ9glSgI5rQ7qqYyY+I+S5495PRl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5892
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 09:33:28AM -0300, Jason Gunthorpe wrote:
> On Fri, Nov 04, 2022 at 03:24:34PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the iommufd tree got conflicts in:
> > 
> >   drivers/iommu/iommu.c
> >   include/linux/iommu.h
> > 
> > between commits from the iommu and iommufd trees.
> > 
> > I don't have time to disentangle this, so I have just dropped the iommufd
> > tree for today.  Please coordinate.
> 
> Urk - this is caused by merging the Intel SVA cleanup series into the
> iommu tree
> 
> Most likely I'll have to take commit 69e61edebea0 ("Merge tag
> 'for-joerg' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd into core")
> from the iommu tree as a shared branch
> 
> Check again tomorrow please

It is sorted out now.

Jason
