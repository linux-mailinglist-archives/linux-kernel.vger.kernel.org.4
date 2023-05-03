Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FF86F5BCD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjECQRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjECQRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:17:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82DE9B;
        Wed,  3 May 2023 09:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683130655; x=1714666655;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7GP1c5eJZsmeGZU+WZppUsJmYZXiOQZyj67leMtznFM=;
  b=f7POdVUXNIaHWnKxfAg2VV0AWdku6ZQGY4UnxVUNAHjsyFpumkue9Q7z
   vthHX9EsBwFQ//s5RniIKEJ08o2cTsoTiOSZ9nlmpM8xGMAEqn0moaw6T
   CLWxrm4EXk+Ix6u7ItfOTZZdJivp12GsE9y+j3e2bE17L1XR4SdtF546b
   oiRJ8Citiq3iULYN6zA264g5XvZY7lcneOF/ttx3NAdckA2R3MJGJxMIb
   HEHsTT4N6/2tXgFbkfnfBkk5ZkSZ6uCOLMTuUcdI1067pFe8qDIZiLNZW
   N/1SXA5hglyPqduAz5NJ+hxcsYZxd0R2IQ///qFFhZ3vSOFU9k4xaDvz8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="348738177"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="348738177"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 09:17:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="766189296"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="766189296"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 03 May 2023 09:17:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 3 May 2023 09:17:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 3 May 2023 09:17:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 3 May 2023 09:17:30 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 3 May 2023 09:17:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iav/QcuRPMCdQEIXHZfWq0pZfIKjINB8VTJJfDVbfJmU88Bw/x9j4k/oOUpQAblVeUlC9szPsfTgvKs5Y+grMPQGTbULuZS5HaDxNztiZx0XlYDDqW5Ze9m4Alk0SzP5WfPb0tGXkFqTvdqJDpsG0iDO2enyLrHXW3f6EwBHp3Av02PfHGPDfPR3js1vonl8Xs3WcRvtj8KSf9B4kFhZDBD4O367YqizgdM+g1IZ95z+MLA8BrgZcxXhdDJO2cI+0oKJIRyfYXC0zgPmmBSg42qd0uWd5ZNKXsAo2RnygtxEfRVsnTyCFZvJSb7cWvP/Vb/5+HogivzxOplMfkJBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NowGrf6nxbV8cqarrmjx7v/CntVaPoDJvIAf1/T7OaY=;
 b=Exd4fN4uDHXOG5ICwcNSy4lKQXaVR2COIIx5xc3pQDqrhPFBaW4MtRRmAM42wcz8OtTjIzIyOqqj0j0brule1vF5qEzoN15Xr4dygknsCyz63IjD5aZUsSTnJyZ+DQXccDWd7DVeyLBFoSqp3u0uBI62dIQuDAX8VtytZaGe3xxfBSPTBYNK+txlOTgkfaGT1rSUvKM1UGeBrTdva04IcrNMg6OU8HLBSPsVOkNvwpThr7cwKBV4uf+TWzYLX+RP1/9bKJ7YyAmoYKxwkK4Cts+hFot4Y1G84xS4wdhNoyxStDCn9n/YqmzRFIg7CVCxx12/SS7VnLTLZdVWBtmi6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB6822.namprd11.prod.outlook.com (2603:10b6:806:29f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 16:17:27 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 16:17:27 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Piyush Malgujar <pmalgujar@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
        "jaylu102@amd.com" <jaylu102@amd.com>,
        "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "jannadurai@marvell.com" <jannadurai@marvell.com>,
        "cchavva@marvell.com" <cchavva@marvell.com>
Subject: RE: [PATCH] ACPI: APEI: EINJ: EINJV2 support added
Thread-Topic: [PATCH] ACPI: APEI: EINJ: EINJV2 support added
Thread-Index: AQHZfczsvQZZ3YHiF0y/f3F4PxE7u69IuSJw
Date:   Wed, 3 May 2023 16:17:27 +0000
Message-ID: <SJ1PR11MB6083F4A2C15BF5DFA5D80346FC6C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230503143759.10485-1-pmalgujar@marvell.com>
In-Reply-To: <20230503143759.10485-1-pmalgujar@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB6822:EE_
x-ms-office365-filtering-correlation-id: c90e8a50-5717-48e8-b053-08db4bf1e306
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DZWDfGtCKtKIic+mmjEeKd+LRGx6h1Ue/FJ9mqBJDZoQA2iXJ5SZ/KoRTxQ7jtsVYXVUTJ10ZnkXBu7rn8l4XAXXgJ3JiIPIonZJstzOz3wVbG9IuIwkbBeGY4tjEom4VpzX1DiFaE8S2EYK9gpEFInL00LJJo8gD67BtmGNEJVu/Ezf/WflAkqBL74hM62qopkcTjwzL6X+IO/X5kcKxyIc4NZ9t0U42ZYgDgh9VEIHyEsVLb3rggzKjbtFZUqvsI1vs0ORZ5V/Z3PkmS9SSxEBCvAXPxdAhE3oghrS6VjE6iUjWUn+otWtcB/c7z/M2OZc8KAX2XONNZwWwemGw1Ke60hHcExODKeGS2T9fnyLxrcK7m5wsdLACt2m0wND2nsgJ7ZW/pLJpqTmtc7hMHN5giNXma6nG96NxkAISsutSVIHJ8qPzpoltNzAvaybIWb0DNXep3X3Vd8ZTDhe8cyXt6ZR4GGmXCg2SjpQeZn4PxSgiv6BFEg9oyUb5fQBBHQdnjZms2Rp6nJQNpKOjIO4gwBueWxZC+mRwTF4HE4Fw/IrbSrBP3U7oM6EPahTl36Qhem4wJhwZrGSs3bE7UkgpQnz3aaKDacMBNlrkCWnoMC6N9nuwhY8yXNQanfxjQPq+qrJIuqoZXgvA9et4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199021)(478600001)(7696005)(316002)(5660300002)(52536014)(38100700002)(7416002)(4744005)(2906002)(38070700005)(8936002)(55016003)(86362001)(64756008)(66446008)(66556008)(66476007)(76116006)(122000001)(4326008)(8676002)(66946007)(921005)(41300700001)(83380400001)(54906003)(6506007)(26005)(82960400001)(71200400001)(186003)(110136005)(9686003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ty4EFOPOXKDLabe92LeTaroeOjbqxqVC1m9Fy+XU2lFR1Q7RroezeOFwjyDU?=
 =?us-ascii?Q?pc3tQQcmcqhpIUh+Y7Pi2quvTN4wCIw+BmPeSHGolUSlI6DPUiEz814jjTOS?=
 =?us-ascii?Q?y8omOX8oFpRV5v1UEZyPPvce+NnvoklktZzXkh/8h8sVOTY3X9NiVJxU04Ig?=
 =?us-ascii?Q?NUN0f4WIhttwI+G3Ie4Nzw4/5BnTH2nuvnjQgGtw+vbGi22k+nMBS18Fbx5j?=
 =?us-ascii?Q?3qwkAr6V9T+Gr1Hjh9jicny373e0wOY0X7q/SM/H2ucq/CVgyyxtaYtG+Z9g?=
 =?us-ascii?Q?3oERCqp4XxXRzAEDIhNg3qO+NH2Mo+F8lYH/4Nx3rRWiZbn853ZSSy3N4LTG?=
 =?us-ascii?Q?hpiXYtz78yV7eylhyIyZ1W5L5UAzb/KuHkNbmplfbOz3fryha2D2Z6Jrtdyt?=
 =?us-ascii?Q?f7GzP9INH+GFj841H7EsM9E+3fAEnJEwM6ke6QwVtNPqWCMQTx1YK9Gz04iV?=
 =?us-ascii?Q?5xEkxrI3tWCKFsxzu/hG7N5nmHPI2i8DagoqxPqFb/2fKZOviIxe7vKD0g4k?=
 =?us-ascii?Q?DS75zjqTwyTmGFJGbgce6WP46JeDfbZu7utchfR/AHctMywpfvd/tZ7ltRp5?=
 =?us-ascii?Q?RnBEHrGsKzNISY+Rr4Mqol7E6I2vJcTYY61U809rsALYDYsu5+4EhaJQJ7Ph?=
 =?us-ascii?Q?krLW/ldZDqy0wHW0XGMddbfTPi1CK9UTpiEXqfF3p3pkWZaGPhCjOUF7HNSK?=
 =?us-ascii?Q?Pv5JPgmpy7BYgmmo84WLVl90FLOuEiI2uojHvmsHO82KiDyGAVNAUhRAAabS?=
 =?us-ascii?Q?2wrsa9OQT0jHrEgIeKTOXh7CpHq6dR18mEFq3huqHLnGnSdTwiY1LV275z2p?=
 =?us-ascii?Q?+Kcm4Rs/32sXKqjvYTlmv2Ec125SzTismOyvx750IzySh8/wv6lkBw7XHxzS?=
 =?us-ascii?Q?a+uNdA3yOwwAG4XYZN0dThFurE2YeOYixmwM7U1hlD0eE+ODRbi7xG6ePyr5?=
 =?us-ascii?Q?UBHQ7klqUdgJEckBOJgwvpHm1HHHlzfMeG4xCEHxol8vZS657m/AMVrSLE4i?=
 =?us-ascii?Q?5J6hkDHTSiRITBaYMMGegTimzuUskV0xkCWI52y10irSzRDM+L9BkBNoH3FM?=
 =?us-ascii?Q?mOkr8ZFdqKfaKUkI6s6tRvS69mjuOxoR/MREOgGqkGzeVaJd70M+D/ZEOn8T?=
 =?us-ascii?Q?E27jnQBX/muVe0McWP/MsOXGzK8dPnEakr1pKDQuqAee/rwyE0o11ajLza0h?=
 =?us-ascii?Q?TPPd6vJQFGjVDLIjjbMCYH1/Bd7aoEC5nn5MsMXEHXrCR7PXUn5KnSrdsCy/?=
 =?us-ascii?Q?xHDHxnQpgCmTMsC9hyW1A/ggijbkiJdCKBy/al/JW078m9IPbISzbG0v0A58?=
 =?us-ascii?Q?DRUuwXSptldtS9j8bqGPaN0uoNwP7CgaWLDbeqFYggevlnMW7kcUizinqZRK?=
 =?us-ascii?Q?tV6JtPBzVeWvGgU/ncz7+8rAJRjZzz4gk3q/l90h3wIG7WnNrZur++cc+bwE?=
 =?us-ascii?Q?de/LRga4TUX6AvBHHFDHkW4NximQyIMXgryjrB3LcQJJ5eYGmBTGjtyOnXl/?=
 =?us-ascii?Q?WibqxX8c6o4jgGzNzTynu45a5u/kiSmDggwZAHH811MkjmL8zV+Z2tOh19gm?=
 =?us-ascii?Q?w4ULx1/L2uYvXm/MTlo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90e8a50-5717-48e8-b053-08db4bf1e306
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 16:17:27.1055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERwx0bqyZJwRcl+VMsfzqps4p+GaEIdRgDmqXK9dpKZ8zzB0+oh2gmsbgikLtnJD9sA7jsBJYLix4wM5JaSl3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6822
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/acpi/apei/einj.c | 172 +++++++++++++++++++++++++++++++++++----
> include/acpi/actbl1.h    |   4 +-
> 2 files changed, 157 insertions(+), 19 deletions(-)

Needs an update to Documentation/firmware-guide/acpi/apei/einj.rst
with some example of how to use the EINJV2 injection. It appears that
param3 and param4 are now used for memory injection instead of
(or as well as?) param1 and param2. But it isn't all that obvious what
they do.

-Tony
