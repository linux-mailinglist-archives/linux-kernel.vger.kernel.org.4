Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04502686ADF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjBAPyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjBAPyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:54:15 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30AC757AC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:53:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeyXbJkSmvluCvcVBKByExu+mD+AP/SDZ2zAQkG+1fNsTaaBSISgR/xHDJkXb7F2x606U0nIzRrYEZMBcPPmkoB1vRI1QK3/Nj+lGTK7kr6nYI+KUa/alsbmdikqQ2lf5OT0Yri/p4OBiId70EKJHzy4F0HwTbrO6ZrpPKIjNMO33sbAUZhAskLcxdw1YxQc9i/UsB8j8UtmvbeTeZaWahFrdTlL0Y68w9xMRHlvpYqq9ZRdKBP4Lz786Ufpw+73iVQNeNiw7wIYXCdmUStyL9pFonfJg85GrO8b6Egjtp314LahDljsJYEgrnmI0nMY/NJ1SnwLoLszZ5r79q9wLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yev67sH1yq4Yo6/HWAjeGV3837OMsGsdIHsSUf4ZjvI=;
 b=mUW872+MIgiXAxgoW7sqt8Rg1Yg+G4JxVfqxsWue7qMPsQRG1DE4AFIg2a9TNhOuOiR70ANe0mD6v65GeBwdt8pYJ5jbXRiOrWQncGjlFqEz8McENVaXa1tam5cv3HKNJqLESl44Z1EvNacohapaO0qqnhfgreClcYH/1qtECDl5u4MC9NaVHD7Yhr+loT3P+4WIfCIfGHufztBqIXRo5gqSSkWkoWJ0I5PJQCeOePbQwKAVwcps2+d4IB7CAUS0CesdtNZw4scE2nhTFewPHM5n1xIrvlPlYTg2cFk3HkNdOxJDODs79DABlJJFldsrneAuq01z4xN4vwXlYXzsGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yev67sH1yq4Yo6/HWAjeGV3837OMsGsdIHsSUf4ZjvI=;
 b=smzr7F9SWz+V6lRb61lwCCmAhTZsrh8sz2BXNGgIWWT1uOwU/bae4c9ZmXIE8l2zfvZwnjJ0MiDyhTIE/dbu1qco3RdtDD9Jy9bp2iZnUlXdGWurkrBarnlINhsGWy1NOc4GueOS+X86XFIClhGkg1iU2bvayJWNEKsSz08Gp16BLSFPvTimeOtRhCnO8EDMdUs6slQ82fjcaWraq2r/PK7bvByW9FIuhxZWyZGND4MugMELnOsgAh2kDeI/mygDsQIuRiwUdyxImBuqVIZuMxr6rsXbp1XqjGvw3rvrUpZh+L5qnTLtT2raKmZXyiaZZNmSCPRC7IRVJ9mg9Z3G+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Wed, 1 Feb
 2023 15:53:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 15:53:04 +0000
Date:   Wed, 1 Feb 2023 11:53:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Message-ID: <Y9qK3nJHjU4Bvxaf@nvidia.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
 <Y9fcAdFxl7GVSH9r@nvidia.com>
 <Y9gaKaMKOf+P2NtK@Asurada-Nvidia>
 <Y9gfbx/fszb0aTJn@nvidia.com>
 <Y9gi0UaE1PlKVzmn@Asurada-Nvidia>
 <Y9gqFwDNd3VKQvC3@nvidia.com>
 <Y9oNSUbDe1YOTj+b@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9oNSUbDe1YOTj+b@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM8PR12MB5478:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8145af-7539-4059-3bcd-08db046c673c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zLvhGg2T1c7H7Q7Bk1c2ERzNv4Vm4uEWyhi9If72YIBntsOmRxYq1W/EhVWoVYNNwzaKQC9g0AhGOtaqu6h9rPbv1Q3EprO6GOarrQCvUBQbxliFUjYCHbXYJHBPa2VdR2GTx80jIA5zNODu9yR0RZBX+4BpANVhKGTY8SvG9ICRwuNlbEFcmV6L8IoXquFFzspIyyFBLLwFPikH16XfsofRz5sLMBoOTFtKlxsjgStweDXa741P8/TSx6ZSw97l9vOxhfABmDPhTWwWTVOUfUkx3ZHKFP3rd2tpVjm2DDmQ0f+FFFmbcQaSiBkiIYm17uBpeHZVUbLt+Id9n1QDDXM5KRQgvK9tmDDlxUqCFjO5hKBNs8Dc1IlFQltGv+70cs1ySWMXg8q0EiD17Htgoa0Qw0W69KoEh6c9b624yw81tKdwkFJ/F8M8x0xTWjh46MA2CI9aB9QYsfiJU0y5yVU5D8u1MF5oKSD8pwnwQwEqt8pqvFNSfBMk8qVNNxJmU/6GjUfEWIG5yGWSQR7Ldo0kAFu+0zKE0T2NGFickLQekYjHFldc7jd9Yzvm2bX5iF8Vjk55vfKera9UkMZyOJYiIDFoHf8eTi01hs7dHmTFHgK4ouaj3R2STpyCiWTB1vM3HaPOMfwG6b9i/x9V7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199018)(2906002)(316002)(6862004)(37006003)(6486002)(4326008)(66476007)(66556008)(8676002)(478600001)(8936002)(6636002)(66946007)(38100700002)(5660300002)(6506007)(26005)(186003)(86362001)(2616005)(36756003)(6512007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yYITWEgFOHs0dPmFMD/Ez4wAPi7AzLqO2XYyuqPee58erbi8XyzRrH0iN4Ct?=
 =?us-ascii?Q?1MM2i8Nfwkp3YWYGZGf44bueBxHjhKY4U7PNYXwlrvX67Z1PD2V1vKYNwP0q?=
 =?us-ascii?Q?d92L39pj0dnsDukekUJbVacNyD88z9YAp4Fz0gxnXBHSKwfbQvSRMsgcjToP?=
 =?us-ascii?Q?xZfTbDBKdRC75o209jrj+nlTIvs3rNktS7DjeFwmOI39x4/dJfdv3YkXmYJ7?=
 =?us-ascii?Q?z7ZzbYZ1pYO2bBvaB9NToJTs4ciLqDDJkuhe1FGtKbEeZ9fqMaHK3cNpQkk4?=
 =?us-ascii?Q?mXCAZ+Dt6rpwK4S5DKV7VzE/UiGVp9VO82RhH2HW3wqvdP1X+uNZoPZus9p+?=
 =?us-ascii?Q?P4jTKyKGFlkso1q7Y/zq9NxcDvAhw13YKySFDs1ymS/Bt+WWekI76BNTtATB?=
 =?us-ascii?Q?Jhch9BIYzPD6ZRViDW8XBApZALgC8Cz8YspFHCW/Yo5IH1z10EcySPMdbbJ5?=
 =?us-ascii?Q?ecHdadTJmjsDVvm7YLil8c7s45hLc87U/CsQ4zzQYDeDOEYN89LV/AJ0uwWq?=
 =?us-ascii?Q?NEgkzg1sBc2tsvYB/JRUBQwp8fhij+qqOf/XLE6ZqQDU/+dG5vOVfj+/J9Xa?=
 =?us-ascii?Q?eu+6UB55zMs7h+D4hDLcn3QGha0lwUh9hY6kgp4sFxTTSU3cD8ZQMeu0a5YZ?=
 =?us-ascii?Q?AoJfkt2IyjsbYvOXT3xmENeXGvpQcAYA0WjUTSKO0aqsfQ7I/T9xOcTCeS7Q?=
 =?us-ascii?Q?ZliyKQMnQUs3VLs9JdkktRcx9YqbS41bR0P2gT6Sz4KjqnuQBDei9swLfXrw?=
 =?us-ascii?Q?sa8X+RlhEHod/Q6jILjaKU76v1og9MiKXiJvDRMdt6NBz6LGosP0xWy2/lCk?=
 =?us-ascii?Q?y/B0vK6dKRQWLL9h7z2yVN7nuCfo1eTUdrT18H6I6GXq4dvi8vHpjXCrRObS?=
 =?us-ascii?Q?ihabCOro0NSom6ZrDAGPmiGCFVk5UkRRC1G6J2ggIuP14eNH9Sw4H1ypjxHP?=
 =?us-ascii?Q?ob0QRutVEZXts4QUvxynuwetKoywM/kZiBls/Pfk22UB/v6agcjL7T0lKBSH?=
 =?us-ascii?Q?AMlBI1joZgc+MTJ5YUo7GLDORfdePv87oiAm7pYOvdT4El+jx3q3mkQNyOIM?=
 =?us-ascii?Q?a4iqscuHMuYdgQdXJYQuut44rV8RB2FHx58ccFgNF88qG41SsdqHCdDL0DyU?=
 =?us-ascii?Q?XUVXuEDIuPioNmrmbwCwEr57J1hMs4IOQJ8MvzXaGJFZP9139OjctCxtX56R?=
 =?us-ascii?Q?s4B8TzP5nE5QIlii+TzmBirvgS7465nWo+BelEBIHu7eSVSfmqaykYAlFhmF?=
 =?us-ascii?Q?JymEwAo1DNb/hsNpOWjzXELaaj9VRP/KjH/O1sRR8/FX7x8WoUm0OPKqOAJJ?=
 =?us-ascii?Q?L4oJpthkHXgJ7yhr4DAeUhFRfSiBPZ1VSpwlXX3TRQJjznwSvBNjbVEB+75D?=
 =?us-ascii?Q?WBumo/m43ZCXjXkh0rP2sQBZtTXuaa+V8rEvyoD28yB2IMxT/O1S3BYWb5w5?=
 =?us-ascii?Q?jR2xrm+bv0d4F7x0OkK1Wc0xbwvXSO5guSxZr8MpmFIl0Aq3qm4ImIBO2H5Y?=
 =?us-ascii?Q?sMAk/StCFXhnKE2vuUdiOIPvsme+acXuftZOC9SZRCWRxJpWzYuSxpkiX4Gx?=
 =?us-ascii?Q?UOcLN/3oFNu/VsSdANrNcFjzNzYH7BVH3DaN9lEz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8145af-7539-4059-3bcd-08db046c673c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 15:53:04.0067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DugG9bZfYbK/pXfYyIVw+ftwCtLExnHXCx1n2b88xTW/KOpzUu3ZJsOljV7+OGaR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5478
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 10:57:13PM -0800, Nicolin Chen wrote:
> On Mon, Jan 30, 2023 at 04:35:35PM -0400, Jason Gunthorpe wrote:
>  
> > IMHO I would structure the smmu driver so that all the different
> > iommu_domain formats have their own ops pointer. The special
> > "undecided" format would have a special ops with only attach_dev and
> > at first attach it would switch the ops to whatever format it
> > selected.
> > 
> > I think this could get rid of a lot of the 'if undecided/S1/S2/CD'
> > complexity all over the place. You know what type it is because you
> > were called on a op that is only called on its type.
> 
> An auto/unmanaged domain allocation via iommu_domain_alloc() would
> be S1, while an allocation via ops->domain_alloc_user can be S1 or
> S2 with a given parameter/flag. So, actually the format is always
> decided. 

No, it can't decide the S1/S2 format until it knows the smmu because
of this:

	/* Restrict the stage to what we can actually support */
	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
		smmu_domain->stage = ARM_SMMU_DOMAIN_S1;

So the format is never decided.

> that we don't pass the dev pointer down to ops->domain_alloc. So,
> the SMMU driver can't know which SMMU device the device is behind,
> resulting in being unable to finalizing the domain. Robin mentioned
> that he has a patch "iommu: Pass device through ops->domain_alloc".
> Perhaps that is required for us to entirely fix the add_domain()
> problem?

Robin is making progress, hopefully soon

So the issue is with replace you need to have the domain populated
before we can call replace but you can't populate the domain until it
is bound because of the above issue? That seems unsovlable without
fixing up the driver.

I'd say replace can go ahead ingoring that issue and that for now
replace will only work on ARM with domains created by
domain_alloc_user that are fully configured.

It will start working correctly for auto domains once Robin's changes
get finished.

Is there another issue?

Jason
