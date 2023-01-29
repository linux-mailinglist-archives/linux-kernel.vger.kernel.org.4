Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE94367FDD2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjA2JXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjA2JXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:23:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BB622017
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674984188; x=1706520188;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2tub8rVC7otmbwiDRk4PkywT4aM9D+A8ckSSGyyWiJM=;
  b=PA7GMZNoTJyF1Dm9O7CsJoDjLo3yGLUddardShexHVARUObd8X55BVIv
   4TImiAZOkfqf09PNQltCVSBRZr+dPIcuKkZIBb9f73leA3yuJhy7NTeLs
   If6bRiH4HBzWy7JC2phLSGK7nkVI5i/Ktgoi94+GbJjhEB7M9KQvC7AXi
   O2oOhfGjSmWLgamJtAXCpqCMmpFJiKcJoOdsK55JkYj+KnBtDkLSRFKsM
   6JL/SjiAcNnJBwf9f1lLvfVeGPQsDcwqO5mzbDyHzRbQmnworU9jfGQy4
   O4Dg1CLZ0oaW68KR16Je2yKkcbSbup+kjzc/iCERud0KqG/FgBwrv6a1H
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="329506628"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="329506628"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 01:23:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="992554050"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="992554050"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jan 2023 01:23:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 29 Jan 2023 01:23:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 29 Jan 2023 01:23:07 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 29 Jan 2023 01:23:07 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 29 Jan 2023 01:23:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+LGMdUqw2eU/SsXFqLeEHgVkl7EGaykQqO+IMm8uX+bn6LESQS1WQMb7kIFmpysdrMAT9YTsiJLIqHxCWofeh0Qd8y/lC4Kr8lKVEHbVQgjNOlq+lweAmcg4m26yN7hIVgtdPdHjOWCrDSAVj7Rxm8JovYamd7zAvLwniegZZeCvfWBXwnM2dlIg0vzqdn6Y/4ozDOJN9DZbzDSWphtNQzC5F+vFmQqmBeMOR31sebCk/IkowDiEwOze7pj6Y7Jwg4Ub2kPVAtZ35swDSMcH9bYsWYlz2WDfFvw/zI6I9HSvtQWl/7XnuXKvskVimGuyWwcJKbQa8NtzoqtQyNU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tub8rVC7otmbwiDRk4PkywT4aM9D+A8ckSSGyyWiJM=;
 b=gVPmNGQaM71OnTQRtwknHWloBBx05/kIt7CgooXi1ITuM++p2WjmGmTWbf253Z+gdKX2zAa1vU91TFUlNKmjNvLlEuAYI1qtXs7Zx7w1/9ZGms7pvh6zbkgd7PzZYVRH9MWUncsTTgdNAFfEakv+wjCwJfJSkcZN1sCtA67XVfDdE0nHS4G5wl7zagAz+262toF87eApA++tAy5vwygdTeYETtYVCBl9WvELdlhjiZ/mAuI7SVrwGNrC3oaUYVQqP3qho+EffSSFOod6qEtd/EdjqE0kR6w/ElP5AqnZOi/blYHX20XnNrE8KyMjAn2eLfIxRCjqr3vwF/zKiOBsCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6711.namprd11.prod.outlook.com (2603:10b6:806:25b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.28; Sun, 29 Jan
 2023 09:23:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6043.033; Sun, 29 Jan 2023
 09:23:05 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Thread-Topic: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Thread-Index: AQHZM14aiBBOVVT39kua9XTPj2Vjmq61HlcQ
Date:   Sun, 29 Jan 2023 09:23:05 +0000
Message-ID: <BN9PR11MB52764F6D34C9252A58DDA69D8CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
In-Reply-To: <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6711:EE_
x-ms-office365-filtering-correlation-id: 73ef8700-100d-4cc3-f558-08db01da6d5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QZvCVoUlTFapI4QBw2y5wj9NKvUQTc8dfqmPkpkoKV99JNE1KdgoJ4/g2rh5Uw6DfRbrbA3sEH7xyjqJO9L3H56+sRGuaohZ/FZjGat69Ud3x3kw71/wWuLUhiRwcP2xfuIIrACxdrMvjrelLfSTGg8IgiynESjFNW/Hc/NWR/NiFbQ8MWrUV0BHwgXYSMCa9Uujve8Em8W9b6jmjvnbYbgB2bUXvfI8X2JL/c3IxQ7+Jbs1RFvyjAzk3/YPFC0Y32fxxzu2oOIROqDXeQ49JRrzdmebfzU2ORJVLk5mtwoQQwcalVLh6KEqYsJsM2z8DeDiw6d7cB0dbIoa/mPSYQv0H7JjCJXPqbslas4V3a/yxD+MMaEtzroaGCiDsz3EpmnQQKBU/1XjKmjQqyzIwWhlWJ4AHT3fqhnwT/dGzqwYmEoeVESlem5prRauw1Bk2yTfCJeKS74dfjALpZi+YMTlKHEK1auQ9FqCEb5q1fbbw+PujxIdZywiK6hrlet7QHNl8k3djefF/kAgXV7owIY2+Wq8b5VBjjESLYzysXPLNSIWkdE+YFU5Kc84uT8Lle0dJlJkbge4XJ25EPa0WTDN8yjWhnTE3oJWDsvI6JJivTi1rLN+mBP6uKg7I/uVg67VAnBoZ4elW9w2pXlh3pmFWUKIOztVLkUm7iGHnIM00tgC7t06oB9XLNrzR4W8zrqg6lOtwJ5HM6ugb0tNYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199018)(26005)(4326008)(8676002)(186003)(76116006)(83380400001)(9686003)(38100700002)(6506007)(41300700001)(8936002)(52536014)(33656002)(82960400001)(316002)(122000001)(64756008)(66446008)(66946007)(66556008)(66476007)(86362001)(5660300002)(38070700005)(110136005)(54906003)(2906002)(478600001)(71200400001)(55016003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Aiu4/wjPLM6fohXmjoqhTl1zd484w1/+o09jJJgNYNp+seVYsB20B+efUN/w?=
 =?us-ascii?Q?vy7LgLlVsKBcjq1i6ARr+VCTFDDIx96iCrRGxCBHRzGfjDBa3xonlf2hjOao?=
 =?us-ascii?Q?8jwe3kap6nbSkeIwn+rbddqjbNNBDAPNKEdt77yhz6pqqfS5sNUGrmEPvhB9?=
 =?us-ascii?Q?c27yvvskRUaoMsyCjcOElM1vNDSqMTgHa2qSE6Qcczd30urf/yU52RcsIA2M?=
 =?us-ascii?Q?VHldLko8aeWeWuV5Werd0Si4kf0oTa2xZrBcD3GECqsD4mOfBVPm6UM5SAcF?=
 =?us-ascii?Q?agQw874tEnBTiNeW6VsL19yMdQdNuG2s9mkt4T1HxF6u8zCtQleI9luvX6Au?=
 =?us-ascii?Q?UKxzeP10S4ysZaKtk9zv6Y7tvmZrZR7T/rQCDxgODZszr8TJ0g4UloKGY5k6?=
 =?us-ascii?Q?yh95Iz2qttLTpBVKbJO0ylvKV4E5vliAgJvwE3qCWAsyJW3eKAAddWLeJL6z?=
 =?us-ascii?Q?jIeqkhKtFPRyewyKycJv2x3Qy2tniM3CyKUtZOuOnn1cYqh+C44J+LGei46W?=
 =?us-ascii?Q?jHUbX8zAc8r9odqAx9ha/7cF5RYYNbuVzJznSqI3D97giCqLR6Xvgrl7LRFg?=
 =?us-ascii?Q?tphUjzHDtlIDMLhErge7JsFWSCx2aLlV4VikilaO3AZVs7qgfZ0PEJ6MHC7S?=
 =?us-ascii?Q?O/YIaWZ31SIWvvSbbyM3X15/y5UHXORX9VcWhnEwstuWvh6IMNMfl/hIs4GF?=
 =?us-ascii?Q?IofULieVjkFSMUORFmB4rLatFyqiJKuYunL9VmrZKbh2hiBziLs+gSI7kFoP?=
 =?us-ascii?Q?Y4Q9d+IdEahhuAGtTGemo2kLprSMI61g0r1UGAkyPqqhOmLt2K6Dim1eJipa?=
 =?us-ascii?Q?d/r2w3uevgqLwBszx4qoS+2VzWIPqZkEvxqqldCmGgzh6ctHXyhT4wTZUOKW?=
 =?us-ascii?Q?7S1bGroLYbiWAnhEngkP982xhi4gBI75RvXgtLe51N5ZHFT5kgVMQxEWsFBu?=
 =?us-ascii?Q?kofdBF9yaYsoNqzJWiZyOpi1SoP8Zr4vdsRxGpRRPLEZkFqjz9DuJn6cS0cB?=
 =?us-ascii?Q?s4+xUiSvORG+gMLA2yXsYHDTZ5WYMbIEW8vvRd5FDnVtuyxU5VBMZrapZd3U?=
 =?us-ascii?Q?6+HuKqzbhMzLRVu2jZHTvUK7p2JdMCnjoNwM7WnMHOxtiPH7nIH8XfJViIfx?=
 =?us-ascii?Q?Eeo/xJQ6pFChGU10xbtnZEF3mIxBLvkrFC1dFceBUTtFBb+cPA4tbGYBga/E?=
 =?us-ascii?Q?0Xw3goOB+wxoi1id5pSwCK04EWvky8E8RhOuPZ0ja4nmkVAh20GdIcwaPgsX?=
 =?us-ascii?Q?NLJmkwTtWv8w+Z+IkHo0OBKgRJay+8IibUpGOTHlJIoyZysNr7uRSxVB8bpO?=
 =?us-ascii?Q?FQ2F3VM5OcDdB589dCE4h7E0UczlWGn+kNsp7khuorlFhnQ61ZT4A1noXB8v?=
 =?us-ascii?Q?gzNQgG07+Jn+8JUvr7Vzn6pIFl4I0MZO5SlW6IR8SbAa+JtyOwdu1LEbr4+G?=
 =?us-ascii?Q?6jLSYN2ZV6ARa9F/DCEXR5w5T0qp8n7RtLD6mz/2QBm79IC17WFj9iDx4Qvt?=
 =?us-ascii?Q?Ebdz0YrYRS5kRp9GiCMeH9rEGlxkhFVOEzCgmFFBO4E3vPiQkhEMLkP/TgtA?=
 =?us-ascii?Q?dvcTE8wNb3og3SZvn72wzeBDoT3oVmPgi+B6vLY+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ef8700-100d-4cc3-f558-08db01da6d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2023 09:23:05.2076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRKcVQIGONojct6SQtH4BrlxCcNa+2JeoLpxKJmCt9o9OSI1IizjaDW0cpwM6TM09pkgMu0W63slsUFyfeSUrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6711
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Sunday, January 29, 2023 5:18 AM
>=20
> From: Yi Liu <yi.l.liu@intel.com>
>=20
> Currently, hw_pagetable tracks the attached devices using a device list.
> When attaching the first device to the kernel-managed hw_pagetable, it
> should be linked to IOAS. When detaching the last device from this hwpt,
> the link with IOAS should be removed too. And this first-or-last device
> check is done with list_empty(hwpt->devices).
>=20
> However, with a nested configuration, when a device is attached to the
> user-managed stage-1 hw_pagetable, it will be added to this user-managed
> hwpt's device list instead of the kernel-managed stage-2 hwpt's one. And
> this breaks the logic for a kernel-managed hw_pagetable link/disconnect
> to/from IOAS/IOPT. e.g. the stage-2 hw_pagetable would be linked to IOAS
> multiple times if multiple device is attached, but it will become empty
> as soon as one device detached.
>=20
> Add a devices_users in struct iommufd_hw_pagetable to track the users of

device_users

> hw_pagetable by the attached devices. Make this field as a pointer, only
> allocate for a stage-2 hw_pagetable. A stage-1 hw_pagetable should reuse
> the stage-2 hw_pagetable's devices_users, because when a device attaches
> to a stage-1 hw_pagetable, linking the stage-2 hwpt to the IOAS is still
> required. So, with a nested configuration, increase the devices_users on
> the stage-2 (parent) hwpt, no matter a device is attached to the stage-1
> or the stage-2 hwpt.

Above is very confusing w/o seeing the full series of nesting support.

As a preparatory step this should focus on existing code and what this
series tries to achieve. e.g. I'd not make device_users a pointer here.
Do that incrementally when the nesting support comes.
