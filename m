Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D150640E89
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbiLBTcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbiLBTcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:32:09 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3022EF3F88;
        Fri,  2 Dec 2022 11:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670009526; x=1701545526;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ecs2pfeCWUPN5vHFHooMw9Hl6xttgAGD82rKpyx0VaM=;
  b=FAKAiGftI/eP+P8aX2IdhrSSlTd4bExUjyqoKK06re8af4SQaDD5C3VK
   zKCEvuRlC8OE6lOLSv/HNjkcrw3AxQzubM8iTW95hfqDKcY4D1lOopwRc
   PhPgcIQ520Fc1sxIb/FP8eu+5NQ0lkfNSxhUIBI1jOnZ5YLptTG78qQwc
   JwJ61gIxHo/KaGMrzUjFobX79Wd985JBOHVPvwVXu1WzwlHSQ+Y7UkDti
   BWfMBBOv7BJaAgE+1TZmN0gbfJ34rDNr1WXIL9/B0BNXScS3BI6/KId2i
   PY0w2fvuriG6xXc+qp9Qs1N5qyC80riYxPZKCXP9tdx8O67VcLmsQhGFD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="303634745"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="303634745"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 11:32:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="751384122"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="751384122"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 02 Dec 2022 11:32:04 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 11:32:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 11:32:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 11:32:03 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 11:32:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtuYR6nv7EPurpetv2JLQr1P5wqNisJiVwFuvmEOoWFTshHGnHQwmNwVFepjQYhhV4dy6KkWZ/MvqoLKYB4a9NfQVrIwKSpntYSjf2kXKsF9zVy6W0ah1x1Mv+fAWIoRYeKtlpEaHqIrgeLChCKg9baWi/UTJQJwZWs+V4C8O7pyVIuGxvTA+UK6aUtBB+lrIxLhW0Sa/q/6GwOpuZTAO2ZUlCf44qJ1IhjrJFoq+3o6B+1rZrtrGD0Edwj62OZJWPDkX/wyGe5HfDSfj/pIMyXVKlyaIidE0U2rd9RIIuMsFp2kkO7oPxQUOP4QFIJw4SRTTiEfmq1Th+tUs8zVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fUZQQtIHoe1JpN873Ni6X5XQ7pQgGYHxWWjMAN9n+w=;
 b=Fv/NYryK1LH+OZRLJfVDTTl47+JrzVMyiw1kPXTTJTvUuV15cxvkmV06rMGIrQurlvBSkLOnQv7XHmFVD2HVqMAUfz7VO8iSmC3+Ah4pLDE91doRxEZV+43BQ31BkoaDgViv3E6khTW3PI/SWaiXaNe7K15adqc9TeaTt5i5NpAdn/nTvFNgFOBHyqCNy0pjW6txGg/EfqoLXxZBQnhcNYfGrb+1K8Q7mzFYtR6LkShMFxfWIlKbDS6F3AvybXZX8Yd7P/UPuLjlpbVfjown/CFatqxD+TZHTX1rU++IwTgT5+zmOdC0fYQNMY+V1UDi4/AnNu5bighpubAvh5MWfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by CY8PR11MB7265.namprd11.prod.outlook.com (2603:10b6:930:98::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 19:31:59 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::f43e:351c:5a4f:3c3b]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::f43e:351c:5a4f:3c3b%4]) with mapi id 15.20.5880.010; Fri, 2 Dec 2022
 19:31:59 +0000
From:   "Wang, Weilin" <weilin.wang@intel.com>
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "Kan Liang" <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        "Athira Jajeev" <atrajeev@linux.vnet.ibm.com>
Subject: RE: [PATCH] perf stat: Fix multi-line metric output in JSON
Thread-Topic: [PATCH] perf stat: Fix multi-line metric output in JSON
Thread-Index: AQHZBoD5lGUsRu3DdE2l74CJjH33Pa5a/C4g
Date:   Fri, 2 Dec 2022 19:31:59 +0000
Message-ID: <CO6PR11MB5635C3BB62A1B9FA532DF57BEE179@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20221202190447.1588680-1-namhyung@kernel.org>
In-Reply-To: <20221202190447.1588680-1-namhyung@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|CY8PR11MB7265:EE_
x-ms-office365-filtering-correlation-id: 1c7bddb3-56ac-4f84-42dc-08dad49be17d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8vs9uRkKJJZZZDgvpOgixsb6zug3Wm4lYN841cQNOFnPlJfvkhh3xNGlWvklUokpuKr1e/1JnwL5ZNiyqYmNTYdudMUO9wlQcUZIUI3aLYpIhhVWcJTbEyl0H/XSHksL3LqTdsQTFPwmzjQuVplR9sQPq1qPHp5LYqpIAy4m83siHy7S8/AS2h96coL21aqzbe9OkA3apGoNLg28/kumHZhtEg3teCnQ++Nu0eCS5tT7d5TnTAgCG84EkfL7Ylp/4N4r8SkJ9xUIDqVvuMhyWf1+TPj9oTDVmBF5otcmAwv8vx8VZWGKTaFU9/Xywa8S1X1Uj3krnkUhXS5XxzXxPyBjlYR9mWSyywp1AOEB42Sz7DNcvZwb0v9sIkiaO/SrhHF+j793PGMAaibsJCAQ47xu7vbTtxEBdI6Pipf9I0vXkB9T03GhdZnHKzjZkAlp3nMNFPqAOp5zruYWyKtlfwGRE6Y0Np7NbOkF1niWQzzqZh1+93sPCeRyIoPOeiX1RgN1khd/ILe2Q5TB5L4Uh3jrYtBj+YHHLWyvc+xxBFkz27TWCiqAYqgK+IRR2p1RRVvIsxz0OTUp2S0afoQgOlsVu8MU6c2EjkQs1UUQkk4LvmzDn2pSpI9OhYbqGt22zUuh6HQhtIN5IVz/vQ6IaHq1LmM+Db1s8FiWYZuIINrGkdHYs/gCI1lwoheS3pD5ud6Z5n+Qxiw8yn8vsTZGBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(186003)(55016003)(2906002)(38070700005)(41300700001)(9686003)(86362001)(83380400001)(8936002)(26005)(4326008)(7696005)(33656002)(8676002)(76116006)(66946007)(66446008)(66556008)(6506007)(7416002)(53546011)(64756008)(66476007)(5660300002)(52536014)(71200400001)(38100700002)(82960400001)(122000001)(478600001)(110136005)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WRql0SrHW30swYQZUMtNwuLj2fTj24bsd6xxY/0j+HdntSe6zCoTR+m9nVjk?=
 =?us-ascii?Q?Ry0OcZ+SObi3E7bje2j+x1cO/ZTumCPSfGOVAIdE9PBy7+vhyEaiIZ8abeFi?=
 =?us-ascii?Q?V0aHvBsHkxQoyzYVlOr986//4Frd5w5UOfZr89AXtY5W9swStAdci5XIrNUr?=
 =?us-ascii?Q?naE/f6xb1sAngzRrTAigG2Ow+nwcmbsOEXz/W9cdO42az2LvQhtK6X23mIH5?=
 =?us-ascii?Q?LafHgMrUw+htHM/LSJkPiOTRwiJHIAYzN9+xinMF/Qkl9khbTOaVP5x7sHaC?=
 =?us-ascii?Q?O3XYqRdXxwhyTHbz73Pyt9M+NFQ/cm8VxQkuhycO8VuPxuarHX8AKZpz24bS?=
 =?us-ascii?Q?/zUeVt5KbQ4cla8DRDQjnrNsDYk8QChv2WZMhrSKTddGa4S0Pa8F+yr0q0Z0?=
 =?us-ascii?Q?dHYWsbwKzLhWZZfU2HvAJQdQO4gH7a6Z35tCI6jyGfnnaOm6yLZHlWon1U42?=
 =?us-ascii?Q?R2+oLVILVK6LvAWCCZzVU5Lit95EtuCbuQaA8IOaF6AZ5uVnv1PZ4U2lHlcX?=
 =?us-ascii?Q?eaOJfBUWrhSdR5ROwqNfPM0VC/vm5xwrgR53xop3SQ0VdC7ADi/1Swfms8Gt?=
 =?us-ascii?Q?9VPGdNcSDQOdqKUOoBu1ck8IJnme2I1TExfbudO2lgRSashw4SwSQQ57us9D?=
 =?us-ascii?Q?DIInCDB/cgmSm3RF406GRbqpLBTdRo2Ax1sjbx+vFC3HHmeZHIwpi/5eXTLw?=
 =?us-ascii?Q?xbF7wit9XWa8MXhP7tJnAbHAJlZ9PgLNvfvTVngnHxpAJ9c1kcH5o+chTfLP?=
 =?us-ascii?Q?cIrUKIxzO4Ek1So/joHF5ks9c7EkIsylgvyma50/QsYUuaU6FvqEVrqJzvLZ?=
 =?us-ascii?Q?L7i4BuryCqaR/RW6+TeHPO4B48QHOP9vh5IJgncKXSwhtZGypla/guCOA6s/?=
 =?us-ascii?Q?f3UU7yC9NFAn1m9oPaB4njs++ZsnnXc08Bqw2FDqCcpftSBGNRinlUWNYoXn?=
 =?us-ascii?Q?kqUXSqc7HAQvIhY0V9Qv0axewJq/oJhuyN0bpUbKVmZSZvYuk4cN0VONkbGO?=
 =?us-ascii?Q?FikS40oeTUme0YjD/UL8GdO8tdS6u66YjC19AYC9ex1sOPtPZ0sfLtNo7smU?=
 =?us-ascii?Q?EkVYcWrtRjLqxrgdbLmgueMmW2rDYRObDbTxFAHhWuvB2ag1hPXeD1OOlzg0?=
 =?us-ascii?Q?twwZ8He4egrvvuCLwZ5zp6x+uFlbpTTtDurUgLxM+L8YYnSFOkv+4797OPKM?=
 =?us-ascii?Q?GCMniaAvedxvh/egeZp9wKsRhWUGHW4QZETn4nb9FNz+Z4vieQrChZC5gF4w?=
 =?us-ascii?Q?JS1rBM6Dpo9oVabji51jz+RB8rELuQPaqYFpIaEOLPCK0wKPov0xv7fg8Edt?=
 =?us-ascii?Q?sefpkiDtk7AqxCAEX0OeLHHt8MVQztK4Oia4CaUevzjC8OUDdifUuUEugyO5?=
 =?us-ascii?Q?KZn/bUPjgb1/wrc+jEqsHE1V8uiO66M2VvALUPV2QGK6JYiR+zv0Jv3fjhUJ?=
 =?us-ascii?Q?M3XD5NR6NjfU+w49Nu2Tpzuty0/FsHfLi5BCdqBYK1D7HMHyEn4XgvYPzJkp?=
 =?us-ascii?Q?RsbwXUBlWpQJrA/Q83OXZZITAqUp4wUV7TKP5RoauOuu2XfWTLZY4yH3GCXK?=
 =?us-ascii?Q?JUrHBAuPUxX/B5+mbuJiEtTTJ0eXrAUB8n0yaABV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7bddb3-56ac-4f84-42dc-08dad49be17d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 19:31:59.3823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Ou9h2ce7tSz4X8H7DCddP+aNOIz6PuHvDsxCYrvo2fP72xEvsps0ib+6NGskrJv+8sg2B7HcnxEsD0LgRUC0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7265
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Namhyung, it works. Thanks!

-----Original Message-----
From: Namhyung Kim <namhyung@gmail.com> On Behalf Of Namhyung Kim
Sent: Friday, December 2, 2022 11:05 AM
To: Arnaldo Carvalho de Melo <acme@kernel.org>; Jiri Olsa <jolsa@kernel.org=
>
Cc: Ingo Molnar <mingo@kernel.org>; Peter Zijlstra <peterz@infradead.org>; =
LKML <linux-kernel@vger.kernel.org>; Ian Rogers <irogers@google.com>; Hunte=
r, Adrian <adrian.hunter@intel.com>; linux-perf-users@vger.kernel.org; Kan =
Liang <kan.liang@linux.intel.com>; Zhengjun Xing <zhengjun.xing@linux.intel=
.com>; James Clark <james.clark@arm.com>; Athira Jajeev <atrajeev@linux.vne=
t.ibm.com>; Wang, Weilin <weilin.wang@intel.com>
Subject: [PATCH] perf stat: Fix multi-line metric output in JSON

When a metric produces more than one values, it missed to print the opening=
 bracket.

Fixes: ab6baaae2735 ("perf stat: Fix JSON output in metric-only mode")
Reported-by: "Wang, Weilin" <weilin.wang@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
Weilin, could you please verify it fixes your problem?

 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.=
c index f1ee4b052198..8d0bdd57163d 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -440,7 +440,7 @@ static void new_line_json(struct perf_stat_config *conf=
ig, void *ctx)  {
 	struct outstate *os =3D ctx;
=20
-	fputc('\n', os->fh);
+	fputs("\n{", os->fh);
 	if (os->prefix)
 		fprintf(os->fh, "%s", os->prefix);
 	aggr_printout(config, os->evsel, os->id, os->nr);
--
2.39.0.rc0.267.gcb52ba06e7-goog

