Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956396B4242
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjCJOB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjCJOBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:01:19 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CB1114EF0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:01:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4rulSrEOwB5+wkSDLWlJ8L64w0WqYCSgh9JrFnrDE/AdgCS4EykGQxZavghqmALJ814CfGrZ56nVM3fxBQC2rZQ5iYohGWXU7XWSSlvTyBpBQ5LuHK6GWri2Ipv1Alifh4GoS4z1ShX/6sN0gIV8fJ6DUiSePbue1ufaR4Ze/eOjyZ/9J/uF18//TZ6Z0+D45WCyUWSyprEF66RfQumstDxKZPNnk0RgdDe2Hc5rwkunUM57kXJYJAA7EUQieCuuEv0WxIzBuVFiB+DCC5BOn0mxRYREuR7jtJeEUiOdIM3h36bBUXIxwwviwXSIeaOaEqpIcVc1IhbwQDMS8yE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cz4GZaYA7+izLDu6lDbiN9HAD0rHbrFXnpAZe3VNTVQ=;
 b=Cwx6dRL7KjZZuOyDqyB64+81pWDcRjkqUsnDYWDJwtyqYZdlXoP3gk4YTTlmuVtTdutd84VBB38frsSTCAMK6IQEGmzgfpu1zlGZFJLS7doD6GTVZXdB+x+u1r1jLzvdkrxDEKqXvwIp37Kx/9H3iOYt6wSjj9XvuRcfqQqX/kBj1NWvTyNA/V/pnOAHnKX2L86iVe7XS9ul1ATlQLvspM1uUwEMib2WV22lhuJcCiqfq+97Sr1qHFcySuLxL3NKeZJC83xB8mH7XsyxhJnZoS2yiGjofWhWjda9UbDgMW+H+xjHJ9kIXb/2GrfQU+RX8mVfC3urbR3/Tf2o/3CoIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz4GZaYA7+izLDu6lDbiN9HAD0rHbrFXnpAZe3VNTVQ=;
 b=ZDpLFkoSRyo7S7PdZ18Hm8Vf0aBLOOlFJmgDJfg+1X70btszXJY38H9WLgZ8wkpbXL8shYoQ1iesF4VGzY7jGRIyIx6f+Ycx96IyZ395GVX08Ykxatk19EkJI1kU5lYQQikK8Y+FHnHLCCBjy9SCKcVgnNTpTqDKhFuhlolmz7rMabfKVEfDZ8RyaScDG7vOhX4RECtC5EF1FOStLoxn/18RO+todGwRZNNs/DWYiTMQZRtcVb+UKGpx29mz4+cMOo2Vp6tug3ZF00UPPVd98Yl8/Z7NL/irku0kMIfeaIAAtKcEf0DJ+7ctodSTVf5j6jRXZixmePHeAQdGi7WCjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6747.namprd12.prod.outlook.com (2603:10b6:510:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Fri, 10 Mar
 2023 14:01:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 14:01:01 +0000
Date:   Fri, 10 Mar 2023 10:00:58 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
        will@kernel.org, eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, yi.l.liu@intel.com
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Message-ID: <ZAs4Gtuom9V8f1iW@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <ZAnx0lUkw02cVTi+@nvidia.com>
 <ZAq3LJgbo8ApejvU@Asurada-Nvidia>
 <20230310125453.GB1745536@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310125453.GB1745536@myrica>
X-ClientProxiedBy: SJ0PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: f24307a1-6cd8-4d7f-800d-08db216fe14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZqc5PQhvFf7USK4vOpypH3JPeBL3DXfjMNxEKGHg4I/c4i4avlc3MZhOIHqW79FK6SgEl4GrK916Se3rh8djSUJ3ZYVnvwu/KcUIeSLfk5c0ZCc9F2h1G6njI79hQlGCPRuFOL+Y44atQDwu42iNs2gEk3q9TN2Dfe6SxOXsa981bP78wl5xwfQbrpbzxQUTejdQE2WfgB8qtBNsl5+fvrK3Hk3lx3VRo7c9I209bWBV9ApIpKiiWQURbxJd+60CWe4T5MLLEz4e98BL44xvyL6Mc5ug7nWeG6yD5bT+jEch+JyxgXs7u3cstLf1m0LwJyr7QS0W32yOZoDL0wvXTsftxIk682M0wSrsgLzECZTQV45XI5k4UZy7/JeEs5DdDMBd4PWbed2Vg5jNTGTDs8Y8AawZ0pXWKF2bpLqwHuuObFEBiRbXP+2v1CPwGDhS4RDG253hGYaIMo8p+DjkHxj2KU9+jHzRsghe5CgDhGoWRYeFVjdTVqoxSrzLqXYbOfH29f73L0lrMY4jzda7+c4pcgXkcy693vKU4DwLxG3cQ8R3MX5L8dsN7MILOx0CSGRvHz9dX3s7htX4g3lV1qqmTsU/Fx9tDUbx2J54Uk0nZqmONZgOLRqdVqtxiHTMxeqveSQsN8o62GM/0L1yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199018)(83380400001)(478600001)(36756003)(186003)(38100700002)(66476007)(66556008)(8676002)(66946007)(4326008)(6916009)(26005)(6512007)(6506007)(2906002)(6666004)(5660300002)(7416002)(2616005)(316002)(6486002)(41300700001)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1U8niqAseZYrg9/z9pDSgVRq7uy++Y5aSoZEO3wxckMIvy6hkGxjeFZbgH50?=
 =?us-ascii?Q?jfZj0+j6AcsG+d5+fWzZrWCqoP43f5C5Ut9YQXWIUHJDEKqr0HDaXymQbYW8?=
 =?us-ascii?Q?Av6SLFUOR/hOO+BwaSF1BlUQm5TchFeYly8Y61UJvmVgejJTobP8qI7Wlj/K?=
 =?us-ascii?Q?pcv0nrDF7vykl872Rfl8u05Aqcj/zmapJbPFc7kWSYE0h2etPyoH5fk+Mk07?=
 =?us-ascii?Q?1RwM0zy1H5ZNHbPdQntNDmG8FNJMpzaKNgkGuz/fQREkmK4KmWv/NyC32mC8?=
 =?us-ascii?Q?4WOO2iYrqutICasONIpIqWonpCBRlZY7RW0CG69/vK8E/opcyxng76wCjWyf?=
 =?us-ascii?Q?D10TgWLO208FFdWClGw/njSqY8HfyBleKViuElRVM0YSlB3JD03JEVwUtjDS?=
 =?us-ascii?Q?4F51FzXln5TswvbMLCpodV6iFRPI0rA7iEm3L+9ocTmJshh6c7eg1iCO7MMo?=
 =?us-ascii?Q?8Snyxs0TVC/c34LL2eymDk6+EdN7widD69B+srMUm5w8lcSBR25M46bqT0O4?=
 =?us-ascii?Q?2Ec6Por8EroBPJcQPZajgwe1suiXTYw3WkizDr34BymAMEY9BgMI7iWHHeyd?=
 =?us-ascii?Q?mc58/R9TladP1XEtH2JVTlyq2gqQcTNZTnwfwk5YL9WYTkYRq6FYd1bQrs0+?=
 =?us-ascii?Q?LdWNC79NgU5nbmHGMKyzZrfRTIaXr0JTWLKth0vATm0J07j9pp2TKa4peEs6?=
 =?us-ascii?Q?iWsT8dqVtm/Pja6y58krbhSqA38vR0PFnGy+jqJ0L6f2VVvYt0vniqP56qw/?=
 =?us-ascii?Q?PhI8+U2EqQdv869hpDZQ8qzigC1ghuMnEJuEdNXMllNBG5ZVDW7O0/nafba8?=
 =?us-ascii?Q?4N+BNy8mzsA5dca9L+mcZr4VSt04peZNjzGWVwmMo1HIIx6ERLshPK8CUHkW?=
 =?us-ascii?Q?tZa83RmL+o4cnpZl8BzQI/XmWY8GQ0WvHJjIzdx2TH2T3fNG91003lA6iU28?=
 =?us-ascii?Q?jf45hu1yBn9LrDKnG2emn/9MaLAUV98GrB8N9x2rTOhCZzcDY6Fet2oEulUk?=
 =?us-ascii?Q?tl2s6FzURNCsHT3349O0hjfp7kiPFhgryce+fyMW98uzNrvcs86tPOTH4s73?=
 =?us-ascii?Q?bSY4H30gUfWuO3gE8MkbxojP7Bmy0Z1VqdUgialtzvPfqAWSjyQIbmrKu9K2?=
 =?us-ascii?Q?mpbI8dlZO8NfgX6uxc8O2wEI0Pl9bDSyvJ2xFzK1DgTCX/QXzClJO9SuxQje?=
 =?us-ascii?Q?QUnCRftIKD8hxUY1dCKIhsZxZ3VCbf+PUuO2WOmoFiQiNkXpUFgVIiX30j/r?=
 =?us-ascii?Q?arOWqhP+1JzuNYjjn5quGTWKTvgMRwp6U7WGXMZnZ5+9CcyCY6Bxpr3+DpGL?=
 =?us-ascii?Q?JdMCUyu7kHSG27P9qdUJ45ao41xpJ9MXVpAweFfjoxcalOO7uYNHB0128etO?=
 =?us-ascii?Q?BXxxCcOrofUEx49Bai3xJ3H02BRKROWY0nfcPJvrj+s55pO12hJSJckOnZHb?=
 =?us-ascii?Q?27Zg77Rr43/615Se1aSTzlN0Zi5yIkIWGj+vw/Ha0hWFONin8xhorfORxDP0?=
 =?us-ascii?Q?evYwvKfqXC+BdEUE3ijxe+80Ed6ddBv9mOs3bqBaNvURG6cj41wkErGZ3RMC?=
 =?us-ascii?Q?n6mvK9UDPYcRnyCunG7Ckg1O1jE1+DKrqzuONfGq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f24307a1-6cd8-4d7f-800d-08db216fe14c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 14:01:01.5389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNDvgvAsYTJt62FENeKq+rGHUB1PuRs3yRbl+oG9dkMZBpAXCVd/b3Wq3xlSKNvm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6747
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 12:54:53PM +0000, Jean-Philippe Brucker wrote:
> On Thu, Mar 09, 2023 at 08:50:52PM -0800, Nicolin Chen wrote:
> > On Thu, Mar 09, 2023 at 10:48:50AM -0400, Jason Gunthorpe wrote:
> > 
> > > Nicolin, I think we should tweak the uAPI here so that the
> > > invalidation opaque data has a format tagged on its own, instead of
> > > re-using the HWPT tag. Ie you can have a ARM SMMUv3 invalidate type
> > > tag and also a virtio-viommu invalidate type tag.
> > 
> > The invalidation tage is shared with the hwpt allocation. Does
> > it mean that virtio-iommu won't have it's own allocation tag?
> 
> I'm not entirely sure what you mean by allocation tag. 

He means the tag identifying the allocation driver specific data is
the same tag that is passed in to identify the invalidation driver
specific data.

With the notion that the allocation data and invalidation data would
be in the same driver's format.

> Note that none of this is set in stone. It copies the Linux API we
> originally discussed, but we were waiting for progress on that front
> before committing to anything. Now we'll probably align to the new API
> where possible, leaving out what doesn't work for virtio-iommu.

IMHO virtio-iommu should stand alone and make sense with its own
internal object model.

eg I would probably try not to have guests invalidate PASID. Have a
strong ASID model and in most cases have the hypervisor track where
the ASID's are mapped to PASID/etc and rely on the hypervisor to spew
the invalidations to PASID as required. It is more abstracted from the
actual HW for the guest. The guest can simply say it changed an IOPTE
under a certain ASID.

The ugly wrinkle is SMMUv3 but perhaps your idea of allowing the
hypervisor to manage the CD table in guest memory is reasonable.

IMHO it is a missing SMMUv3 HW feature that the CD table doesn't have
the option to be in hypervisor memory. AMD allows both options - so
I'm not sure I would invest a huge amount to make special cases to
support this... Assume a SMMUv3 update might gain the option someday.

Jason
