Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9486C1F46
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjCTSOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjCTSOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:14:04 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A689A442E7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPEuJ5V4a+qdKB9asudIM6vRBNCB67Pc9nO3fy5mhtUtwshSqBYWx9fhnj4EIUKDt2BcgbZGDBo9EpSvmwi3Ajtd+HphDSvqdAsGmz4xYYWltMxnlSv0U1j5bUEJ4rFjzcfDlJ69/N+1qlYI6YMlrkjtrqM+joKdkEagRcQRXeVeyasCbh/mcIn5hDiUZcmx7OW4D15ApYxDyKH51vPp02wZDY8G/DQqGTlvEL7OclzHAJ8Bo1kisKOatSgi375jtBePFBcPezUcET8hzNzZ3841j4zy+H0ORBtJx13Ntku8QgpRb7Cdv/2gk8j5MFNL7QhhNo6r4qwkpom0OJXHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5aLextkr8W0jj6WUCd7cVoha6y8ycvSx1TCotj+YGo=;
 b=FcOpmVZJqkOg4y0fppZ+VXkGReWKwRyStUQC/lNGrIxss7sDDPxNEPxDSJZbskuTzNNSXco17fsQrjWm5HeBvrUt9mnAMfw4tN8M9YcoZv43GsR9nh1k0SPKgH7LOQ4qVkszOOOMVyWqIJKM7pcGSpRgkSrBZ5I9Oci/lAUksmoHI2KW3/Yb6UtWaVGSrBBimAZ83ThkixgvsA9vHBw6X7WGDXOCbas6mYuP60AWeSuC1pPojlNlvixBvVKb3RhwtRIU2d9ptZKzm/g8VA5C5GHl9vyKf3xGFMWkABgVrgnDk9AvjA+DZkIc9t4ajOVcr+V1VL3JSL3Mbi9MVNJhhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5aLextkr8W0jj6WUCd7cVoha6y8ycvSx1TCotj+YGo=;
 b=Q2aYA9Uq8FapyPp0Nq6i7A4fIKfax6Ikgx7WZXxip/057NfiK3mGSFGPLwq/zD6ptEgWVtAt2R3UW+N4GY2pWIcHc8aB4KURMM7zpCgHgrD22rKa6Yj9tGl858vG2CeoXkXnbDWufu3Fs7YJruwYSApo4Qbl18ym8Dgjf5mdiS/00Bai5R7bnKuo79HVQPBF4cIxYav8ys+COdW0t8KvnGHgEESmgnvSX8BXgL8h/VyhwFKnzomLKJsuhjOUejBwNvWV/zptGaEq15PsAu92qmqkVznBjWOVGxDUMGyrGPuVDsdUu5pK9v+AMXSUyvU0bGbfUX7px/+XfwQVFXjTNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5242.namprd12.prod.outlook.com (2603:10b6:408:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 18:07:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 18:07:14 +0000
Date:   Mon, 20 Mar 2023 15:07:13 -0300
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
Message-ID: <ZBig0fN3l7LsUlQg@nvidia.com>
References: <ZAx2K08L5TIm6r3y@Asurada-Nvidia>
 <ab762cc6-5adf-2515-d9d2-d21d916eb6ad@arm.com>
 <ZBJcS07G3mt7gjkA@Asurada-Nvidia>
 <c753c2a8-024d-5bef-8987-96582084991e@arm.com>
 <ZBOFcenanpRsGFzF@Asurada-Nvidia>
 <ZBe3kxRXf+VbKy+m@Asurada-Nvidia>
 <ZBhbmqprnux4q00i@nvidia.com>
 <ZBh7hSX5hdW4vxwh@Asurada-Nvidia>
 <ZBiDcYwxL7eV1EmQ@nvidia.com>
 <ZBiLSJvtY5UKDJ5l@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBiLSJvtY5UKDJ5l@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:207:3c::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5242:EE_
X-MS-Office365-Filtering-Correlation-Id: d811e816-08db-4a05-7ea4-08db296def32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wujEk3/Xqs5QYLNevKBoujkAJunbfkNFCcODyLLsjoQN9yfnv+tiTjknAvJAj4JXggYXFmOFO8uBLpXj8hDCIcmlTi41mVAkQsSbY1oTQ8wQHnAC33dA82FU3d/QlIiGodnvhKPYsbmS8W2cCDF00rnwE6VR96ORhZZCuu2oP+Q2I5xyVmpQBqTv+2bxlc9Am3Jn6ycfVXHV/i4CTEg3DTVvkI1ropXkPToBbZiPVst7df2vg4FkcU+a9I12RHzcHIx+UjK76c2zQI86ztLzSyF/fSZ84vcAy5u1mJKMe3qPkp892FRJUaEH+FI4tiU4rUvD5nvVAAv/P/Sr8s3BPO2vw91pQ6C2saiAlUcMWjI1bx1o35k0YVFKL+ZhcD6doZlFR4Rg9wrjpd46dZgDS5DXJR2RvEjjWy6khEUcqraw/3k4tTRAHccfRWLvDjDNXuZTTL0OCzzlhb6kr02je2DEmgcHD8Am+zkhQLHy6zx+THLFYjex9Vaz2prOGF8QwVeH8wtyDA6HdE09paD5JTl/y2ZJ2jWWg/oSzygSDr0P7Qe97cd6H09l0Q1L9MmxaxZp1r0duGrHhSNIPH1Ea5V0ZjwqoWGBRtutCrkQnmRPYJ2uCI69l1XC65yFpaZ5tMpOGAcBM6uZ7LuxoVkgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199018)(38100700002)(6636002)(316002)(8676002)(4744005)(7416002)(37006003)(66946007)(5660300002)(66476007)(36756003)(66556008)(4326008)(8936002)(6862004)(41300700001)(478600001)(2906002)(86362001)(2616005)(6512007)(186003)(26005)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OxBTJlIeno4c6awe8+p8eiyzuUzw9/PUnSZUAiwRYcIr56ypHG/vcJ5IxdwV?=
 =?us-ascii?Q?KuCp8F8FYvlYf2r1KSueurchD2orY7movGmBSgunAi0O/tcf3DtJ6ASxXHl7?=
 =?us-ascii?Q?2Z5rl5a8WG+tV/GwlDwvKIldcJp2a5+XDW+PBq8a4MRdNEMtKqJHPHUCNuwz?=
 =?us-ascii?Q?HPSez0RMo4GFet4IRABC1pG5yWWlebn3aiLriMUDbfUCqn+E4Z0a+O7DCfP3?=
 =?us-ascii?Q?3s9EkT2vJbGVMc3GjQnwGpJd5XHk30KyrwGCErHCek1w3td3ZM7sqSpGpANq?=
 =?us-ascii?Q?BDeJw8HZmLOKR3ZRonFXMnlnjEQ4hOctU8DcWOxjqYnrDvwZu635ECHtSc5Q?=
 =?us-ascii?Q?53RWY1tHXbSHBH+L8V2yuE0KmTA+8o8IINz5cvmR2I1q14DzYulaXlkC28aO?=
 =?us-ascii?Q?F7tmLbaEaNHhG9H6hu575WfZfwLUpc6qwu/EJu66SADxAPPwZvuYeHiPuHkY?=
 =?us-ascii?Q?l1hUoU5rGS7AKqFb//1ytl96Vpar0Yq8FNcSUQAczsjOPVO9NvXaBgb8RMYF?=
 =?us-ascii?Q?yKN8pXG2yf3DADy1Kn7i6yhRNsqL95Tln+uiNi46P4hLxzgeVjiHeh594m/V?=
 =?us-ascii?Q?uiarcH0ycwWSokK04UeYh6ieGIIJAaX35nKFelPp8VqotDjQG5s+xaU1cvA8?=
 =?us-ascii?Q?H20h2nxcFXP91i6wYo4at+hjNTLXU4J9EF6KTeloFT/2JbnM5+YoxgX8dacE?=
 =?us-ascii?Q?+rwsTxThFEsuqNTWOowQcxKNRNW6+GVvwGbfK66B7WHBrQaZGrdlvhX1U4iv?=
 =?us-ascii?Q?gTClcDpb3vSCoOwqF5jm21/6hdLtYnGYS5aBqXR7b0pWsZ659OL2dDEzF+T9?=
 =?us-ascii?Q?Hkc7leCDSTeOo1+CqqCTnvZfB9UPfMXh6YF2If5Z+2glFyHb6pdhJmy/oDjx?=
 =?us-ascii?Q?53jEjSq5YUMN1vnZj0wIolTUiDFdkoBdoXfJTq1LuBcw75pAd4HhNE9D4pPk?=
 =?us-ascii?Q?sEysUeFYh63xBj6ZRWE74V+WHCv9olafuZSlOB+ODnGq2dEi4gj/6OqT5ySK?=
 =?us-ascii?Q?MrsyqBGdIqWVA+WhQczQb5ifhiCiHwK+vkR9V3puTJy18z4NUsWNiyDsVnfd?=
 =?us-ascii?Q?xAkLDINa63Hr/oz7FFNJbxQJlGNQHcIXDe9LrtCRLfoa6s9fDMZ5cLy1k+ry?=
 =?us-ascii?Q?ky9WKwAN2WlmnebqL0L5nMYPj62SpxQZIBgbk8SJbQv7j+jqTHZgGdlbtLiM?=
 =?us-ascii?Q?R4ts+hS9yOJeyIapUyEOg2+Xj654r+VYWoq9zYDvgoY1K48PmOunS3TyNz1+?=
 =?us-ascii?Q?n0P/Bnx0P+k4LTYk4sG6noIwZMW45XJB5i77WD7buyIhKnKDLGBLtlZZvmR5?=
 =?us-ascii?Q?kHxxh8y7F2VUec+veQOAILV0UemF2hBTGoDlKMAidoIqQQDDO4aO0r3MizQj?=
 =?us-ascii?Q?QG9eaDQ2NjtqIINwa1zDIHfw4WkLSF4LgzqNpRcJvMLPFaabuxu62F7prDHJ?=
 =?us-ascii?Q?fljz/kAg/kXBIsqytU11LsQHylhuUh4MJPC6x8KmmBsjW2d2f7nqpoVnWApP?=
 =?us-ascii?Q?DfroF/UCqq0HqJ6b6G8ROSenDDgEGVQgIMwZxrHA9YQkVsmhIzcCaQKvP2AU?=
 =?us-ascii?Q?DeCqbx2NdT/mOjTW1WybFZ7Q3cryMhRIC12efcTL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d811e816-08db-4a05-7ea4-08db296def32
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:07:14.5857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aa1Y7NSqIv8n8vSQi9sFZlX/46riWkhnZZam06ZoUsHEDDzx3yzxBNfaFcfytM72
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5242
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 09:35:20AM -0700, Nicolin Chen wrote:

> > You need to know what devices the vSID is targetting ang issues
> > invalidations only for those devices.
> 
> I agree with that, yet cannot think of a solution to achieve
> that out of vSID. QEMU code by means of emulating a physical
> SMMU only reads the commands from the queue, without knowing
> which device (vSID) actually sent these commands.

Huh?

CMD_ATC_INV has the SID

Other commands have the ASID.

You never need to cross an ASID to a SID or vice versa.

If the guest is aware of ATS it will issue CMD_ATC_INV with vSIDs, and
the hypervisor just needs to convert vSID to pSID.

Otherwise vSID doesn't matter because it isn't used in the invalidation
API and you are just handling ASIDs that only need the VM_ID scope
applied.

Jason

