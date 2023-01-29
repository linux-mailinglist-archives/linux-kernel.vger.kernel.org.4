Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA27D67FDE4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjA2Jj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjA2JjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:39:25 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227D3199C5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674985165; x=1706521165;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jv449yZI282UicUwxgztW41+UANjapssm+Hi55XfRwM=;
  b=PdObGiPkl5ALD71V8oRV/HHyTtm9fbPorpskvl1J1l+fSJqAd5rEmxAK
   R8yhpLmIWAUTrSaO36+EtJzfkNXG0hNwUXve+9Wh6pNRfhxmOp8cLOZYH
   qeat0hoAJeUEMPfqEVWThNDbXm6yNmWHjmFQNBgH85CbQVRHDhGJfOXdP
   5VyxaIbMkuxakeqhQHX1tFVP9SXXbhg2ayZd7/fd48o+O7xCVO6XXOoup
   2Mnn8qc+hkLiQjlyDhUmYsfIcFsh3kaEokKlfix1urjcYdnYsgTt9HAVS
   JHX1CMZcmPywKbkQS2aeTJgK08X7Y8ntOCn4ats7VUJvvOZvF1XFKQELs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="389760402"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="389760402"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 01:39:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="787687734"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="787687734"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 29 Jan 2023 01:39:24 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 29 Jan 2023 01:39:24 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 29 Jan 2023 01:39:23 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 29 Jan 2023 01:39:23 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 29 Jan 2023 01:39:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDkqsUQo0d5YlAr2BJV/PyqGytTTnfcuxZ8r2WwvkLs/2Na3CeHe31RbPjQdK+JYgSHnwW22vZi3TZ/1at8paFMTAqcBcNMMvoQIIeCDSexFtua0NL23BJOIov57aD+kRXD45s/IbZ0NzMcp+1cHPwK9tK1JQ+8XpMu0XqAJ52JLvXtpnQBGFZL171eCqzQlesOQvQohjeEurJ2r4a4sxfxzvew8poxygxmG08qOM2ZyuyQhQLiDneE2b73kzNQWya0YZLMwgslwfielBIPDFiosc0YymaZMkgZ1N+oP6VvEOiWP85JhRlXP2SrWwaj2f9iGGBMDJ8HdsPG9JF9GFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jv449yZI282UicUwxgztW41+UANjapssm+Hi55XfRwM=;
 b=Rz74M1yzFBiGlsdc/xc2MuAA0wmQ4gsKnP0uqN+mqed61tTJKo6cHvVOv6awmM/4yApm2+ZBL+HDi2EDrZE4fhW8NSeuoG16AYF85hhnCtHA0wSjvhEiCe6FTXc1VX3lcgO+0RxGpwj2BSnm+bdFIiGKFzSVQtIUrkLi2s3q7LyiGGY8U7J/5CgOKvW+0yhzLXMKCdRDplDvKOpHEDgrSztsjf/LNz+COMgL2wfySzexrq95WAYT/MGnDEwXa+2SmVneb7W5262JWanLQ5YZWLTa3W1m+z4izyQZ9ULqSthmlpQCfdyDFc+Zj3SAFWaJekqN/9wo4B34+1H8VevMXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6956.namprd11.prod.outlook.com (2603:10b6:510:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Sun, 29 Jan
 2023 09:39:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6043.033; Sun, 29 Jan 2023
 09:39:21 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Thread-Topic: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Thread-Index: AQHZM14aiBBOVVT39kua9XTPj2Vjmq61HlcQgAADmICAAAJc4A==
Date:   Sun, 29 Jan 2023 09:39:21 +0000
Message-ID: <BN9PR11MB527626814EFADD79226CC9CB8CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
 <BN9PR11MB52764F6D34C9252A58DDA69D8CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y9Y8ue3SR7gM1ZFG@Asurada-Nvidia>
In-Reply-To: <Y9Y8ue3SR7gM1ZFG@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6956:EE_
x-ms-office365-filtering-correlation-id: 56f131a6-3283-42d3-4730-08db01dcb365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ajd2MS3N8xVA30ax5uhKpce/ojPJY+ksFV4N9/315YHs+owzlWYRVDwDpHA5/YJKLmuQfluv3kzvzM1tN9wUJoseRZRM3Wu26YFrHtHg5mQCWuhM0LhiTKNTaTXR+Cie/tWGFgpSrBpGu1a3GvJkqZ0fdZbnxdDhfaIth9q1PdQtzttW+UxlJOvDWz+fnzZEMeYNgUK8p3Yxez6GikGAGK69yeuwT1Qxd0IvRMrLUJ1ph4+hbkEHce0pU6hFzYRnKJLmSUNQ9FCw3+vrYoTefeEv0TTJ81L8I5L0GVc3pGCGQZNqgryvRBMs2BOIyb1fCgKArzNzLT0SjuZADc3t7xS6aTO8qYePHqE/BkfpOi05tm+JqtilxBzFPf3vqb92uYHsb3N/YBdAmSbhnfJk9ath4TdHJdfB37d5m6U8NE4n0fpOFDV8SpVPmL0nK6zujraDS2YflD4uxbc/8H+KWZWwRl8xnTik7SXJp5MjDE+MUYPafGDkjmcAVMCBbKWQiw7OImbQznB320byvqIRl3VQ2XEBztwseft7AqQMrcPRhASDzkWrmHgNe3UIdN5cyoxEznBl1X/sMKwhwqVly4s+Mn6dyGsQvX/98pDhdSu7hg2Gpea52DAuY0g0WrMPHvU6B0iO+sdCDsHlh5+UBMgRD0pn83IV7YMLSsSiHG78hVGPaElf7Q2V7n5SNwMoLELlMEtTS6XwTch4ZcD1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199018)(66946007)(66476007)(64756008)(6916009)(66556008)(76116006)(4326008)(82960400001)(38100700002)(122000001)(558084003)(86362001)(52536014)(54906003)(316002)(5660300002)(38070700005)(55016003)(2906002)(33656002)(71200400001)(8936002)(8676002)(41300700001)(9686003)(26005)(478600001)(186003)(6506007)(66446008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EaFStATwshVgmj+LVooL5WZW/M6wr7veNLeeMvW6NFgPv4ham6s8OPJp5fr+?=
 =?us-ascii?Q?sZZnbN37Q916LpVeyXQOEQanIrtzUqbCwhle+ok+4m4QBW/NGfgLNB8iAJDN?=
 =?us-ascii?Q?EBEYERGLs2Ux6Q883m/DJab1MP7HglZAMSWkXKCXW4CvU4jzAnC84DCjvhdc?=
 =?us-ascii?Q?HuOUwCSSvUeUUuYPEu99dAVfGp09wVcdcJLpUhMrVttGmgdK6y4usGZX3g5H?=
 =?us-ascii?Q?d8XCKuK0jPY8Af9hLgbcd63243RDHOCqVBStEdBklZExhBKjDBei5nh6LLlF?=
 =?us-ascii?Q?RR65WjmRATn6lpPA5jchwWhc4eDkYejies8nOYcQToZXxmaDUvWLuD2nyoM8?=
 =?us-ascii?Q?o7tUjfsbujx/im4Tuty7TqgHXUK5bLoLif0zIuiPaUhc/i/amjDJdp+XTdLp?=
 =?us-ascii?Q?lqDSRnZ84exr83HTiM2TUi4405uxNOeKWlPISOIUB03keolhye2vD5pKA3Pv?=
 =?us-ascii?Q?Ee07VmFptwOkRdZYMVMq04fiBVMxTQyg2Y6+tFqqsREe2aa3Tk1+oCZls4j/?=
 =?us-ascii?Q?o/XFdjTxnBHn8qLfYTzkJHuZbnFa9WDI39qIroe6CiS7GA3GFQypVb4xMkRI?=
 =?us-ascii?Q?r/IJeMwxmV02PAFwZhTRIEp7D+baXbg/uAQAuDWkDgP8HkFh6HnKQy3paDKZ?=
 =?us-ascii?Q?z7739mbuQv9/984bN0hrtZVb2RijmhvFKQ0AOW+lQF6dQsKj6L7q11geBEw7?=
 =?us-ascii?Q?da0lLPmtCX2flx0TBmZ9M5fHdHMShvt5R9n9eGEpM4RmpJtfL4/hHMihX1HR?=
 =?us-ascii?Q?Ypot4m1zZ9GnXbO+SpS4kvx4bPZnk4mD/X/QwGI0Hn/bYMWqlZbYutsU475/?=
 =?us-ascii?Q?WYVYyqYxhQN4x8paQlFgF78AQ0Cm+F3ih4rZXkGpZPpJt41Vr3Kg2pk98bGB?=
 =?us-ascii?Q?UhgGTuhQXfdsxGcPrqfxmdy5iA3xzgsFNeE4U8ojxv4EPme4BDxgnPTEY70o?=
 =?us-ascii?Q?BIBCy+NK0WegcH6+txtUImKEdtPL5DYH9P/dpcCb+WKJOQAnmG+Y2UpoQqbd?=
 =?us-ascii?Q?10v6FGgWTC5f49aMTbAfQdbvuSDi0D+BMnp77sIyMhAGyvjtolVbu2jy7lQk?=
 =?us-ascii?Q?7jU0F3v/UBknkXdM5zQTPREkRiRuNsqJFzWfWO41Jj0wZ3anSYJB5oDcYxFS?=
 =?us-ascii?Q?R4K+EVsPrxJqK31a3/5dxpdMABgTEjz16oB1Zt1oo4+K0CTonX+HCBV+RGAW?=
 =?us-ascii?Q?G5+QScGlxjbNdCme10qBsJ0dxkBr5OU5P4TvuQu9soHzSh6yi1Yykostz8t/?=
 =?us-ascii?Q?CEJqXzouIiNT3KgbuhyXsObF19WbfzqXs8pui+9VMn0p6uru/mmo4JodDmIz?=
 =?us-ascii?Q?NL7Sno21pUuRj1OjJadKOOAPbPpvzedF1WD0ZnRiKWnIf8gAb/hjF8Um0UUp?=
 =?us-ascii?Q?DU3LDSxWaWcoWq3PQQvy/rWIGkQy+rf5cXVNjXxt0PNT78RI84wlm1mlg+ro?=
 =?us-ascii?Q?qwfDfmlWQWQp0tYEOGiUxDhc2iKRWZY2dhUeufE30EGflwZptziMeaHsbwZr?=
 =?us-ascii?Q?YdMb7ZBtgaZg96hV79awsALsyS6I99sMrjVLEpqSKUxBQvB3MWScVyJeRRH0?=
 =?us-ascii?Q?co0FC0J/dfAyX87yVho4B9QAFFZbOczgkxBkoYQa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f131a6-3283-42d3-4730-08db01dcb365
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2023 09:39:21.7093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sEePHbITK6vtoJuNip/yx6YBVefU/7+IyDYjuYH9wXa4s3ZDBJo5BWvRgHgVKB7evcCrgsl6d/dK/tOnAyOFfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6956
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
> Sent: Sunday, January 29, 2023 5:31 PM
>=20
> > > Add a devices_users in struct iommufd_hw_pagetable to track the users
> of
> >
> > device_users
>=20
> I assume you are suggesting a rename right? I can do that.
>=20

yes
