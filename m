Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859716954F0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 00:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjBMXpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 18:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjBMXpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:45:52 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC07313506
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 15:45:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gG8v8OIHXfeuCiyy/GXp0s1tMXzUMQNpe2xFenmqI0pNx72QxfvgkNdnE8dBSNUgWT41XtI9RbFv8kI+NiWp1XUw1zJ43Koq/iMUZkimvYQi0lHG9z1haqX6D3KDQGI/lM9zmFwfJoTVYqIhiFkMIJxzcxwpuffNSoe4oROqXg0nUQfgSXDT9RThrx2SPncQ1PsmGfapo6TlSemMQgtDyb3E2pPAD2HnjQv3qJFwKKDhdM6MVefPyn5czYQnh+rJD7Y9sKiIy6yvC64osXFgVhSS407+JhqC1B6mA2zPVwtJShGokg+D+jSiFRm96JskDesQs/8+GFx0sDP3WggcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ju1p289+xNFSWQ0fVHAx+SeaUHQp9GCnacck1cuPNM=;
 b=Edn8IecfTYpTMl25HJSlpU+Iq8D3kwS2HxXyCr0fjkBhEg/ZbJUD6DjDArHv1/MHrFKZKJi9hTn5UbE7ckJOFXqjwhyTM+JuP0IH7T3VcZBEuJASc0iVD5mX4MmtnJA0ZMrlf0rqIsd+OMWTqx2ZPnrPZoiRd2fj2YN7jW/Z5Kz3uhfyrd5Si5co7/WyNdj4TNpwJi4p9kbHCu9wqCYkf0kbzhpoK9tBkLyV385rUoWaZcSGLCAWGxI+jQYcztnT30D56nZ0eFzydf7rbLIF8RLksi7nP5jU9A/R/jx9A+34OJgrUNLB39X2ewMw5VGu3TAWRGntJxUH1mCs1CWRbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ju1p289+xNFSWQ0fVHAx+SeaUHQp9GCnacck1cuPNM=;
 b=Id4dSNE0zD/0BFKKqXfOXy3KqKrCmReJeNItIsAsDOs6FEl3SADFHhFuyvR4eGMlz6tDoLh7GZfTuxXfvggdSnQd51nkCuQSONFfoHxUdE9DBLrR3svfjgwsJX70HPFEpjzwLB1qj/DNWUg8c45OBvI+tdb+bfBbEOusxr80VJv3/QjU2qCohKINrw7myXFRquKm9jPb0SguUI4kXmfBdA7i0Th9RrmfBrVGYT+qTw9kBZw9G6grCiiPI8YMEvUjbQK+t+8ovIXWubwm88TKHoJ+ZsPgGf6KaBgS0tMz/6MP6WNi0vnddGsRngrnLfZhW4MuqPeI39NAM7KXOX+69g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 23:45:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 23:45:48 +0000
Date:   Mon, 13 Feb 2023 19:45:46 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 2/2] iommu/ioasid: Remove custom IOASID allocator
Message-ID: <Y+rLqg66BBPsfsRK@nvidia.com>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
 <20230210230206.3160144-3-jacob.jun.pan@linux.intel.com>
 <Y+pjTR80bnl9rMK1@myrica>
 <20230213103455.02f3ac37@jacob-builder>
 <Y+qR5zC8ZOkVphgv@nvidia.com>
 <20230213134402.194ed7fd@jacob-builder>
 <Y+rFW80DUHvf3hQP@nvidia.com>
 <20230213154345.0f76eea1@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213154345.0f76eea1@jacob-builder>
X-ClientProxiedBy: MN2PR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:208:23b::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab9237b-19a6-4fe9-64bb-08db0e1c6ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mS53rN/kFuOjBi7L/vbYan2qi3s9Iz3qfh7Ywj6IBuDKl9hXHMrDiJeKNH+jlRE2uddaEwdTm2h9Yx7d4sIkEpNBT5JpikeyoxEkjY/55ph4mWpA0S+rKXrmfzIT2XAn+uNhVRJw0/vCGp6k/sDlUro2OenjOGGc5X3iclDnt2Zjq4ltwN5X08mPgV8tFABp8pGBQk+gYju/UvrEeBp4AEBR3Bqpoj48Rm5OenorWuqS4uxkFMd7clLi3wBWDg9HiWA9ivp6S8Q1QIa1FxhdgLKIcdyOQDBzL6LuEF3jZLYdnikoHkPVrNiO09jiIOn1OjbjtAgiAAHUuIZIhvZFo0dWiNfjzgAUTKOq8fi9z0kbiYn2vh4eRheMWTA8w1ba5PdZUOqWjPmaDsa0qyOLFCVrXeyk8Kw8ld2VOWhEYvUUJK10Nj6A51U7NgKWaexWTwe5M7eM8SPj9Dtb5R9C+l+sNnn2+gb/zJ3lkWDGVDCjidwC0Q+ACneYc2+RBNOeOVcIC5AlAkIaxMQf34c7wrHOs3Lq6OSPzd8AIYNsqmRjhsPZUXO2KPNxyvZnUFj+d6FOgs1XptLfXv7QfvCRXNwbC83ocYJtyF/QeivhUWmEpI8Vdpv/YJ4R4KurcmWO4v9OHz8kQm/Q6CCMtiHjXHInhfE1HN8BEUTH6WgRly3Cxd+JxeqzGMmAWqchwHsv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199018)(66946007)(38100700002)(5660300002)(478600001)(2616005)(6486002)(41300700001)(36756003)(8676002)(8936002)(6916009)(4326008)(66556008)(66476007)(2906002)(83380400001)(54906003)(316002)(6512007)(86362001)(186003)(26005)(6506007)(7416002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CywUlh8q9Gnt0gt6PsVU7CTMw/PEw9XjyZLy4y16iMhzuOdms3jBom3d7n2K?=
 =?us-ascii?Q?Ivt9Ad/ipxfi86j29yYWFotL6/bjBDnhh4x9Bmic1mA/qd1bjVbP1uLjlXOo?=
 =?us-ascii?Q?h5l3VzfUwcfTOitC6LlFACFPZD/rPvFSq5bPjkB+Da8ziwsYNv0xxYXhYHtZ?=
 =?us-ascii?Q?0TRgQR5Snmm9Flvi9ZHkuUUWiHsgWBgXpQyUNypI3lFz2wT9wWLr2VyRnpTi?=
 =?us-ascii?Q?dq456UbcL3bYoTQHlKFJpKbj25/GTM4l3TmlMhwb/5YUBc5v63Cc6TqpiQaJ?=
 =?us-ascii?Q?Ki1q4yLvjmEGSAN9Qo0cMBLwiiMN2/1iA3HY+kO0hUgae1U446xNNZv2Hdzl?=
 =?us-ascii?Q?nYiBubRu07mtFLTRLRFIoa/vpex5AIpBIE1O5oxsz71vEp81urd1Gk6UUyUI?=
 =?us-ascii?Q?XPeTMdIa9n68qxEQloTDsT11tE7KokwCdmBC80JIP7uHuJZMGgJRZCG0JI5Q?=
 =?us-ascii?Q?jiQWB81yYpJb7h2KYFPImipNZtV7aPHGl7/oS8mSq9Jvw2Ud7a+D4pvWcZ0a?=
 =?us-ascii?Q?JjMLEGPuHKoW6ww+jX8LnaN2SWpys9lKYrs43ZIU/wDNN93tm5zYH89+QvSI?=
 =?us-ascii?Q?FEcEjDQfLYcTLXP+gtLZ9dtRAvlIuLtQVSmBuu359LjEqJfgTHa2D+tRZft1?=
 =?us-ascii?Q?766SO7IygMVM600gl90TdoMmZLPF9RzvFXfpYhAWju48v6z8Udfr1ycXqFI4?=
 =?us-ascii?Q?RHzLzHnd/rTOJeQG2zTjCKYqivo4Kz+Yn5Fdhd5hQs93H/qNsnv+nXTp3/O5?=
 =?us-ascii?Q?6X3lvdii9NxzPpHkgGEJvMPmp5/JWS9w3bkjvqVLe6GivXsWBrfx3ZJveYed?=
 =?us-ascii?Q?O8go7nMRGJmlnWZuUtc2ayvGGbSMu+Bx1+eZtIc2c9X+GX/sITNL9tqWeNVU?=
 =?us-ascii?Q?3vX02KDmMBPKEKCj3IeFqO3sNTGYas+ZPclAoQ6fW7NrtXWAO0DwO/QiMdOJ?=
 =?us-ascii?Q?yWk5Q0v7TJ1MqPj865s0/s4586f4CcapsPaGmUQkMBQXVDuz9mj0g1mTle5T?=
 =?us-ascii?Q?ljO9Kd4w6mkG1Gz7HXLAeTAKTBrjZub9bBBAo/atxiUzWZj39E2cYiEgwHyX?=
 =?us-ascii?Q?qDNdX0yDeIn87xGHgVyVZEX1wr/G9YFA9Fju65bRKsk5eiOZs3m36ItMmi18?=
 =?us-ascii?Q?nOC6YhaAPAJt9FGi7U1Ie5gXf4gPQftT5IgGC7uUuGxS4y49oNV1lyRByqhb?=
 =?us-ascii?Q?LUEHaNPyTx/cZoHj9IcaeH02C4p6BLJg2DOa01HK6gp8PzDRAL5gzOUPRE0O?=
 =?us-ascii?Q?y9w7zI/KUF9/xeWtjEH/VTYKP9G0eQ+DuFYg92eQsOQZw68wevkYe3kcJmWw?=
 =?us-ascii?Q?Y+XAOc2fH0DbEZBR/enIJ7h0xSks0WWtCab1zivv5n9bbCAKHx596wL0eCH1?=
 =?us-ascii?Q?42gaFOUMX8GB3OaRX5CDbMV3KKT31oRe+nB1OR9qjVjEsqsIdrnv8oqWr/2i?=
 =?us-ascii?Q?pHiRcqq5LTE1/BsCAAiQK8CZIl2969b6Vuk1O+Cxkg1JAZulHn+/CvhDLv6k?=
 =?us-ascii?Q?bq2Cvkc2reYVVPCe2I0kFzQZIvNulUXNf4fp+zCz/5SLFYPcxSkT1wWAlqtM?=
 =?us-ascii?Q?cuK6IlU/0dp+Oa7882BSUCBpCPFN1hpo+RxRAF4x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab9237b-19a6-4fe9-64bb-08db0e1c6ec7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 23:45:48.4583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCZ6WdJKAW5N5n+BsmeoC85LCF8QJIAVC2WnmVsi8Tt/X64oP7xeJKND8a6zcpHW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8308
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 03:43:45PM -0800, Jacob Pan wrote:
> Hi Jason,
> 
> On Mon, 13 Feb 2023 19:18:51 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Mon, Feb 13, 2023 at 01:44:02PM -0800, Jacob Pan wrote:
> > > > Your DMA API PASID thing will simply need one new API to alloc/free a
> > > > PASID from the iommu_global_pasid_ida  
> > > It should satisfy what we need right now.
> > > Just wondering if we were to do resource management of global PASIDs,
> > > say with the new misc cgroup controller, do we plan to expand in iommu
> > > sva code? If yes, do we keep DMA API PASID in a separate range/set?  
> > 
> > I would say all shared PASIDs held by userspace should be captured by
> > by a resource limit, it doesn't matter if they are global PASIDs or
> > device local shared PASIDs.
> agreed, I was just thinking in-kernel DMA PASID is not held by userspace,
> might be good to keep them in separate pool, thus keeping ioasid_set.

Then you just don't charge a cgroup when you get these, you won't have
a cgroup anyhow in that context.

The "ioasid_set" is really the xarray, and you don't have an option to
use two xarrays with the same RID, so we definately wouldn't have two
pools.

> > So if a cgroup comes it is just a matter of putting charges in the
> > right place which is auditable by looking at calls to attach pasid
> > functions.
> shouldn't we charge cg during allocation? Or it might be too early for
> iommufd so we have to wait  until attach?

We need to sort this all out. I would expect that iommufd will have an
allocation API.

Jason
