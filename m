Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6057E681B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjA3Ufy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjA3Ufq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:35:46 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D0B16AD1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:35:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRjjv5iSEJzeL8EE6qWbVvhixwriwUVouBKmP4XUW4+RHwcWNy/tGk81q3Tl9Aw0FtKlI1jds2EWQt8DpXc9wvxx/WerQArrdppcVxU6dhGx4lthhvDbbOaAP46q1K4PfY1i+tLox22qESmQrWlImWz5Ol8dE3vNqs2h/yrWRBEoEMfYmqzrFSKEO18ejDGrXDFx+UMZ6QHG+lsD4xCHDNe8WqiBLz5YJloaOXH82nGWuxiXxdJVaHf5FQOPv5fMdbXOU3pqEInan6pCUyFD7s66L4wn0lKet3CahdEL72pgSbnEXjPaBGjBi/uyGz3nCneHRwarkbaztGFhxNCxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GC75y/jcIhGd7JYHt9zRfkAD3YiOFPn8K+/i6DOqUU=;
 b=Oq0eOLXzGDJLDW3bYS8UU+xy7ZPwWHgbCOOYSJPhdP87QN1uoTXALM2j8ZTstzPKHvdyM7YCu62c010UU8xS0ulMa/49p1vNMmAX/vDsnmvHjQrsS7VcY/zvpkstJMg7sxvnPKfaqCuq97tp3t8M8qFwX/GOEigf7ISxLhUbxmBJMbMIWtZasiavMFdz2H5xmbEh+MhBYbdWSeFAY2ez8o0D1dhC4F2tC5HCGGntefI3BLhTC1Hw6rxLMhY/e494RKpvmFXLcvflpItM9mgKJDJwbzBUQKYir28R6qnMHpoPxh9L1MYE1pytn/vFa75MBc3TKInWwR/58ueFLiL9qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GC75y/jcIhGd7JYHt9zRfkAD3YiOFPn8K+/i6DOqUU=;
 b=FnnVNaQRXd0wGt2Qy3ZblsEfDq0n0HcA6wb3YLnEk6En6xpsL+wxGRwESMl+Y1ljS1fLt7u/ypMBOCAtZUf8DVrTKZsJxatuzyX36jnxrUCYr4Ohj78dE2KVU3XbagvT6V50zUO+gIw1woouTIEW5UOMT2yKuS4D0zLnbGL4IhIEx/daCfkQA1wESq3nOgaclHnfmWHHp9PO1CaVD+VCjUXWT9A8+NUGk5046UXNNZsXeD1ydX0vSN/3YZ1/G/LEtxktHkZ2mg+6j3ocumfKW+ozF43vA6p+dG3CaHKAZYLK6cic7qLgcEDmYt635qPN6OgeCX7m9bcidMjEb2htKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 20:35:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 20:35:38 +0000
Date:   Mon, 30 Jan 2023 16:35:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Message-ID: <Y9gqFwDNd3VKQvC3@nvidia.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
 <Y9fcAdFxl7GVSH9r@nvidia.com>
 <Y9gaKaMKOf+P2NtK@Asurada-Nvidia>
 <Y9gfbx/fszb0aTJn@nvidia.com>
 <Y9gi0UaE1PlKVzmn@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9gi0UaE1PlKVzmn@Asurada-Nvidia>
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c7ef1f-3361-4210-7068-08db03018bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qJHjb+Bb68FMKNHiiKmaf0Sfjue4QMadABDF+AGByuXI8GvuZztQrXP5KwfDExWFs4Q1p84A5XPJ0IHEJgtwMbqaHEgjtVgVbW3cKB9Mhv9oOZsA6ruw7GXc5bciWc5z8iBZDG1p8+TGxOuU+PjF9Zbt6NEdLflEdUYy5gEMyMhNvSXDDQg4k4uldIBGxkYJKTX7g0m02RfuwojoYuvYX/12UG/G7reEQ+OdbU4hgad9nHqQjdFXqt+oznW1dtyUumKRCuOSKS6mgVTtDvIz3I7dU2aX+2KZTS6G6QF3LtnWtzwut92evuaWPugQCa8ANBqr5i026h4aWPhN4HxlRPoU7Ct+/inRdDLqKgSF8zLDA9WTzDTX3ky1eLYP/1ntS995EpGsLfD6vF1VRpRZOmExPalvbGOLSJKLqIYuHHl5sgw7/BfAhy2w4Cfx/wIs8VjV3RqV87iwjwkFZ2IcvN1F/0UgsNMrvXeajOZE1oOykAZz82CFrE1dRCJv0Tp9hFpZjhTAQykSMCkLAgitzDN1of0MJUClDhbPknR9rYG6KQoDEMdZwtx8viiER9NwWF93TbsznplAHGr4s6wnVwMyBwV4brYwDRr3gIo0fLaPel7yufmzJ7ev8fzyeZ2z74Y6OorS2lp9v55BlstWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199018)(4326008)(66946007)(41300700001)(66476007)(66556008)(8676002)(6666004)(8936002)(6862004)(316002)(37006003)(5660300002)(6636002)(6486002)(83380400001)(36756003)(2906002)(6512007)(186003)(26005)(478600001)(6506007)(86362001)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/RoxgChLDnuS1tHKUNWYeWh6evqVLEH68JTgdp+kuV/Et4h+BLTYyECee7Uo?=
 =?us-ascii?Q?Lkxy4OqSUjSQDiGY63tyjdchk2+4sxSJIU0p8AOoA7BZXRDZ+t/NhPfC/MHS?=
 =?us-ascii?Q?d7oO+i2Tgd8ARgEfjMTbhHblQIH2dh32IZoRq1sXMi4SKz2sfRSuLu+OLX5n?=
 =?us-ascii?Q?qwVMH14hIz11vGqDgLMZb5Mag8dXSnWiO6nV590NkD7ghwqwv1gCp0ctbkqa?=
 =?us-ascii?Q?Mbiy4tAzk1MUfLkNcUQ6Jhn4Ip6uLq4Y5/GvxggTq3P/P99JFLK/c0+xSHq0?=
 =?us-ascii?Q?GjohJw5LtFqg0PYwQds58U3FdVuh8hW7H1tmFPsawgX1Dum8K4XApym/Kh/y?=
 =?us-ascii?Q?t75HvACToxKGUavJTHIEJRjGAQIZe2CuV7jiwY7ZbsL4/XnNESvKutPZCi+G?=
 =?us-ascii?Q?hbJVxY9IRmLyulAQWtQRcSWcGh2ZD/XNJTU7qxobCz2qu+wKYY8kg3OpqU7F?=
 =?us-ascii?Q?nGu75HSqAgkX204bME4AQ0xvk/GHfS+n6tDELAyTUyctCsw0DrGSk7B4pLOK?=
 =?us-ascii?Q?CmNjOymk2W2iNmEXX6o04BRsa5ScxzRnzXxq+7A8ddN+yduzx7LfukjcW9cQ?=
 =?us-ascii?Q?rAy9RGdfv1x5EUeQ0ytV+8DgEnyjwmoIh7/EdHDiwadnUJQOZnC9N8cIv8NS?=
 =?us-ascii?Q?f9p7nXH4W4PnaNNS4RLhjVDH/RoK5rhciE48Abhllr8akO4F4P1sQYqvE/fO?=
 =?us-ascii?Q?jEOplZ2GzYpN1ZD16mtbko/CfwpaDzbMN2+QALH/8MJrYU43ZhAABmDz6/QP?=
 =?us-ascii?Q?1p0I+EzzttTpVJsJVKvktzzqftX3zkfT7Lblfc5da5g3jSkNARC1mDtyWAlo?=
 =?us-ascii?Q?dZcbNsDM2ZH6FQD5CRIZGnMur+P44pwntibTPAOqq+JxunCBti+h2Wro38sP?=
 =?us-ascii?Q?K1JTyIJf10Mh9DptlUza648sCscd2A3Y7kcV9TJm2VVZpI8wrLidLCZW/2ap?=
 =?us-ascii?Q?/jtDvJdlmNjAqGwjrgipyhmEgEeRwOr5bThpP1vk9B/DJp0JE9Cb8ogd5H8H?=
 =?us-ascii?Q?0lEFtP5pGF31B/gHfiGzAgoyg4LeMUoRBAPfYHcSkqLydbzdDzL2s5BYVWDW?=
 =?us-ascii?Q?SVdsYYtZc/M9bDfpWjUGBUuS2XwXkTIL9MAWGLmP7Plc+y1MdfR1E3G8GAGg?=
 =?us-ascii?Q?TJpi+35fYT8bSfgNvd5C4MZnNz6bromozZ6C2leeM92mM/omKdghEch9E7ok?=
 =?us-ascii?Q?acfu6AlyN4Rmpbrkaa/qPLc0N9ysm+wsNJ2jviY08kUu4FXXM7aQq8oLqFzR?=
 =?us-ascii?Q?xSSrYehr9B62BJkEavVL3DDiXHUXebqL+mCubBTLLPkmu7r6gd19QTT5XjUi?=
 =?us-ascii?Q?pbgMIpiRRAuzpBWt1PLqhXGP2D66CXktC0HXVEBldHrEHn4yrlglJdgiAg0R?=
 =?us-ascii?Q?UIjH2OGERFC1NdT9Ni9yk0sABpNUdx5/d5wPuJaCUiHBvP7t6IVMx9SwCAcW?=
 =?us-ascii?Q?O7D6zIHs6LF8mU4LCdF8NB8HSu8nLyRyCzH1ZfDogjMH8IgzHRPy2MTAaTh/?=
 =?us-ascii?Q?feVLqrYg7F4CyRbg3+pS4PyAZzID+CvoXwjdeEaTF+ElCmkTCkyX/kjWT20m?=
 =?us-ascii?Q?94QaTTKknju3fbx5772KCJr4jlCIXYjCSDEuyy4P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c7ef1f-3361-4210-7068-08db03018bee
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 20:35:38.2910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFFkstTMWWBrBct4OFi254N6eB3jx0FMy8sYb7OD2Cb7qofR8ld2GzxxVX6XzndI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 12:04:33PM -0800, Nicolin Chen wrote:

> I recall we've discussed this that SMMU sets up domain when it
> attaches the device to, so we made a compromise here...

The ARM driver has a problem that it doesn't know what SMMU instance
will host the domain when it is allocated so it doesn't know if it
should select a S1 or S2 page table format - which is determined by
the capabilities of the specific SMMU HW block.

However, we don't have this problem when creating the S2. The S2
should be created by a special alloc_domain_iommufd() asking for the
S2 format. Not only does the new alloc_domain_iommufd API directly
request a S2 format table, but it also specifies the struct device so
any residual details can be determined directly.

Thus there is no need to do the two stage process when working with
the S2.

So fixup the driver to create fully configured iommu_domain's
immediately and get rid of this problem.

IMHO I would structure the smmu driver so that all the different
iommu_domain formats have their own ops pointer. The special
"undecided" format would have a special ops with only attach_dev and
at first attach it would switch the ops to whatever format it
selected.

I think this could get rid of a lot of the 'if undecided/S1/S2/CD'
complexity all over the place. You know what type it is because you
were called on a op that is only called on its type.

Jason
