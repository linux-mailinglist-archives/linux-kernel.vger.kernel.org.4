Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88EC68FD11
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjBICYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjBICYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:24:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FA229149
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675909441; x=1707445441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zt3YSN0c6iufyfK4H+pt5uwBA5n0rWuVaA2inEs0MOI=;
  b=YOu1K/unMMKavEyOyrkjZVKYktpAGFkRsygFtVan8E7Ik5R0NFtp5tL0
   L8i9VkcE+xDQgCxMDfb4RejlePa8G1j74CUC7arjoNlyl+GmLRvhCuyAk
   Ph9rwhQMBhVDBSTTOfJ31Tv03WZ4agKHUCayQ9wF0LActrerxsrzvFWtP
   E+hHwfwXKPrvPVF+a99wyjmhMCNxdggzwENaMpe5NiQXRVkHOgpFbw23J
   0ad4Im+cXOGu/cYwHq7Bl79D5Wcv23FUIAM2LnA1J3/D/hP7ylWa9ebmx
   137r/9jiHrnl5NX8JXlFbB5bieezfP+mkooCO9eLg4slayZihlVrm1B+F
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="416210933"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="416210933"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 18:24:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="912951939"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="912951939"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 08 Feb 2023 18:24:01 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 18:24:00 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 18:24:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 18:24:00 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 18:24:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQiw33HdysuV9K1V+78YpYuiSk0ZEy5z4Wxo4yNy1CGtxEE3YAadUpHnVZMxYN9kloF+nrApiSIsbjT1tCfF84zwsDA9/E8zMDlSvmayvS609HwEKx9EZpzO6UbQDQIUOJObr6vuxKt3hq51VFGReDQtneSj9DtKvJEqM+YQOeTBZlQyKNcOd9pLDTWzLHyVCAlJMf4z182WST5h8i+VIFX8ya8hCEO3qBREbD0g+M0KhYujZCFKWqE2C0/8g2yGM/DKs59v+tzrTvK/98eRSFhk3lVEfLsHJGZYlKHBqP+f8ctKkmqIe1MBR4Xf2nh9rj1Gno91HMM6SynxY6IweQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zt3YSN0c6iufyfK4H+pt5uwBA5n0rWuVaA2inEs0MOI=;
 b=ml9OwznPtpmfDf7YvuwdveReVS8ud7XvdQN82Zn85M8c0jxE7fQgIExATkXrEg7QvjsNrFpw7XZhcr/s+h28D4nZs3qLHuMvTrm9gMvXi7H9TZpTcHxvPFpwoHzdf/v87D6WjTga9QHD2CAVWNpV5C1MnrDoBtJmN6H+O6P1a2O0CwaAoyE6iedpVv/M3xQ94GupK3CNOwNe6rPyVVLYWUTCuOeSUmj3Z6F2HPgELBLs0XcuH/bOJA+E9YTcEQOC2bXACEBkuW/1UAoADTEg1Hbqfc3kNSjc3yZqmSvQQoHATTUoqhOFQ73hk+fojZDVBn3u2xEZ7ZlcXRFYfprQuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6658.namprd11.prod.outlook.com (2603:10b6:510:1c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Thu, 9 Feb
 2023 02:23:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 02:23:58 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Fix error handling in sva enable/disable
 paths
Thread-Topic: [PATCH 1/1] iommu/vt-d: Fix error handling in sva enable/disable
 paths
Thread-Index: AQHZO32fHArdF9PgYESH+MrY/W/gAK7F5AUA
Date:   Thu, 9 Feb 2023 02:23:58 +0000
Message-ID: <BN9PR11MB5276EFE09D263FBF9EEF8A988CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230208051559.700109-1-baolu.lu@linux.intel.com>
In-Reply-To: <20230208051559.700109-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6658:EE_
x-ms-office365-filtering-correlation-id: 68df7056-efdf-457c-66df-08db0a44b31d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n6nappOkgP/IbW45YpmTKrArbxyfS8ONWPJEOISLlyzq3tz4bqmx5j+ZQl83JYkjfSfHQ31m5Yqv1bRfv+j3ItzUy1GvYQHd+KqlnexICDHaWmynY2c82RkDrCySkr8to4JP999vLSUwKkOf/8SUAVRQ00MUJkUVYzU/0IH3dQFeFysONHh4nKQaTSL3Fomsp6x9N32J/ZOWPj9RyuGf45DDnl4u2jw+iLLL6qOBAfag3kGyEzQgN/LaB3NkDRn9iO03dXMQsU7LUrf4TMkzTWRdK8RPydGNKcYaHfKoXY/SM3Wz20ietuoCp8/U6QG4J1GjmB1VeelWtrfzE5kvIKSh0HaG3XvIvJ925MOAD4HuOR99tDpyWQnN86XxtRx/fRWI8DgLVpsl+WbLosOcR4GOzV4j/MSPvDcAJNuk/JmSO8CJMgh9Z8nXdlOKMLlBV3C5fqbMrE2f3CFU20ZXEVxMCaAovE890WoeU058LRrE/yJ3brQBlMBrJl4jHba1kBPqr/WPqL8AlDSnzN/HqFDR3epzRnGUeDHS4Gur1Qlx4Ed4Y7J+OPrezdCCG5PpvmAmJmJ+blE9LpjFwi2u+Wnqfzn8Bu4+KZFcM+xPtPjK2y6EWDAcwp72P/iuGj2+wi5r0MNtYbJrEGTNsXNzWkurvL5BCVc0TMKiGaSOUiIUF1VcjI6PDI9JcQa7Hnym7lSf3JlZMaUaYPA19Pifag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199018)(71200400001)(66476007)(66946007)(316002)(64756008)(76116006)(66556008)(8676002)(66446008)(86362001)(55016003)(4326008)(122000001)(8936002)(5660300002)(41300700001)(2906002)(33656002)(52536014)(558084003)(82960400001)(38100700002)(54906003)(110136005)(6506007)(38070700005)(9686003)(26005)(186003)(478600001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rBJlwDrhlEcct1KkqZtBn6gvhQAdogdmKrKHPhp63ydpfJiitpJFxnrueW3f?=
 =?us-ascii?Q?ukxHOS1PphuNIYFE8wehC7VEl/NEotaMBR6Ho7rFqLe1LEweGapvYpbWb4qa?=
 =?us-ascii?Q?xeg2S5H78vLTxsOH2nexiGBaWmkb5JLgLJ8rQMolHMRtWSNlsICW4FXvg/WT?=
 =?us-ascii?Q?9YDpYYuK5QBAjB6tqiN/FE4jFxyBbbdfzscr1EipbPuEIz6OLsANB/CHXUvt?=
 =?us-ascii?Q?ocp0PUBm4xjEqz/0/m/UJs0bEA8WptpaV730Txi1NxVmHLsKsvyLuZWg5J1X?=
 =?us-ascii?Q?OrDtX5ykn4ZlWsU25bCfnV6TX/U1VFsu+vprR7Lkae0hsfsUUAJYlQ91d5nX?=
 =?us-ascii?Q?pqYQH55TIyW2iirIgBHd/AFGF2wc8y6gmMTQ7uHmTaf3k1BqpnZITEyWnn2R?=
 =?us-ascii?Q?Lm0OX6ZSILvohtOBj1RzYc7ne/mKAU8GXHxA1DCeZ034l4dnrwKIDMB/r8cO?=
 =?us-ascii?Q?AYHnSvAsZggYoxt7NJPDEDDQP6h8PPCC7Sch2Z2AHwOv1+XI3sY9Ad8DHm5Y?=
 =?us-ascii?Q?9Y0oa4NtERdvU7XRwYHo626RKbRlo8QlMqfn0j66cGSGk01wlCFCAHZlP8XB?=
 =?us-ascii?Q?MxDZ3C0Bg+Q6PVuCFWSlwPEvyV/OjTFi81mdpXBJTN+SI8xnH/a6q0fl8ebD?=
 =?us-ascii?Q?g4hXJIovF2qJZalLmg+UlLMiwxiSeEVpuHQQOB5g5glhjFYzPVCWqO6sMXo8?=
 =?us-ascii?Q?oyVnULpbDsAefn/9sPKzy71tsTMJ67dyANtbRzKkRRpwLasr4xKvCCUYTUzY?=
 =?us-ascii?Q?QlH14z+HtFiL83O2l5PWo0sWWyp5vfd5ZvzZ5Tw/6qMV1cSHg0cEDLDJf8Jj?=
 =?us-ascii?Q?M8vtrYuA864ARUPfMwqqlfmBfo1lP2Oh4x0+Vza/2cS2CZcFZkYIBdjR2vrd?=
 =?us-ascii?Q?xTTIRi28TKWIYwACS2dbUqxq8iG1BZT5tfWLuLGn8hAEewW2XOwwZpAaHEhc?=
 =?us-ascii?Q?zqAtw7kpc8aQ+TvvHhHu57LYh77AY26fHMMVxIJ4gIPRvF1UD5s+HPQ0D1jx?=
 =?us-ascii?Q?bG49IpwYwSRZCuXbsNEfmB89OZQtz4FFPzz2j/+3cw+DinJyq44Q5A6Vyt+G?=
 =?us-ascii?Q?cNJNizSfbf0FkbswwlnxgMDh/D3/7RSOqgsAoCfKo8O2NkfVHXIej+dT9Um1?=
 =?us-ascii?Q?+fmdxMwJpfEJgRd0MbZw+daQerbTgQkIR9lewiAiXom7nhZH6vgE5PRuL/F5?=
 =?us-ascii?Q?/BNnT+cqyp7dYoVyR08i6H5/iIaOtABhsuJlt3fmMFf4glV2oLgYXP2JTBV+?=
 =?us-ascii?Q?Jjyg68/lnOBcH9fLJdLW4ZZtHZ9wkjiYb9xCZVjSd9vj7mNDBiBkL6HRdge3?=
 =?us-ascii?Q?x9Cn9TWVYyWhV3JUQU/owAImAvLvwsrt6WdK8yuL9x8wkLBgdqjnILhafztO?=
 =?us-ascii?Q?/GRfI3oV6CJfcSe47OOWV/S5SlHDf5tBVoVdYGwG/5cK96Xeeel1uZ93HCUj?=
 =?us-ascii?Q?8mlrEYdX2+f/4fIij9hYI7KZB9tHfKtCq2aMR84iwhxqWlSEQ6lpjFvt/j05?=
 =?us-ascii?Q?sLTIDlYLAjBOJmgCGm0/USgMKcDijDnWqqRgGhxo/X8UT6eWbJHWlRtDVnv5?=
 =?us-ascii?Q?3oOjQdebBvAjn5b0O55/Esbx3Ewp3yCsugK4/7UW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68df7056-efdf-457c-66df-08db0a44b31d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 02:23:58.2003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nHLUAVURTvNSU7InU0RaypHHB1jxwNaCMQtrxjyT2hXA7HikxrJFZIuPNRjD6keuDMyhQFdPhABPke76CPDDHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6658
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, February 8, 2023 1:16 PM
>=20
> Roll back all previous actions in error paths of intel_iommu_enable_sva()
> and intel_iommu_disable_sva().
>=20
> Fixes: d5b9e4bfe0d8 ("iommu/vt-d: Report prq to io-pgfault framework")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
