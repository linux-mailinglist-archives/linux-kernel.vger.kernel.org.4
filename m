Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAC67503BF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjGLJsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjGLJsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:48:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3DC1736;
        Wed, 12 Jul 2023 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689155284; x=1720691284;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2WHclcV0q6My+F68DlQVIVuheRjpPEOSlso5nB/K6I8=;
  b=cuRjzIsRL4bymfqbu/8DZhuKTo3gctuuAHNTopXhA1y18qGMzUXF2ZOl
   cGX3LH0hXcjWzKTjYPhH9qXB7BVihV2ZTQmRwZ4NF5sD/waBlp8T2i2kC
   aSlGUcNJXvrv2NJCjailhOol0oUO91vmlAFi120cBo0l8s64NS0+83y3O
   Doof0NxDDEO6nyygDz5UMmpXgp4DN14L1FaR/w17Kysd77kz0K5kzASHk
   stqYHsQ783H+gV91QD6PrgLj4qfNsmq/66GpEs9Ad/i/ZTvK5RHKrYz3n
   bf87eswhir6Qy1KR4vIql/V/MAKxvO3NcAh8/YVIkkJYdWROLuahuNWX4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="395646257"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="395646257"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 02:47:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="724818515"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="724818515"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jul 2023 02:47:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 02:47:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 02:47:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 02:47:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 02:47:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBqlVXDEO6EB6UCbEBp8pHZRE+7iHcVCHAWS4OsMK8s5/9JjzV3cVF4zkDXxYux7RIjwGEI4b5zswf+bvEvh79n57vxRV64J3SrdqVEUlBppivVOv1u0margGwHRVPz4LiZDIS/OKZ/Px0BvzMxLMePqIgtJiiHjpP7nNypjrYHtnecs+3jWBM5qFatZ7loF2vzOo4LUEndZKs2JiPe+kUM1RbLUOQdh5vpDNrCehuvtolg+V5+NwTWOv8yI7xgQhIhwXmFyDGKr3cM8CPFFGueHd4Vq6GpI/vmXC4M03a4fNw1JM4Iqbd8vFrGJeGu5pp/u69r78dMzz0i2VK8FRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hOsGlOhYqgsgwA1CNaoZ6ohvioE5O8XCsZx7nthmZg=;
 b=H0NwZkhjJY44JYlvNtp40Bl5Kcxgh9j2reqop2RwfFYbzgu/YLWcsK/Sexws/kcSiPbHeiX4b4Up7Vw5X0SlXcv7shvAe7WTpspDxhjPwe61BjR8qUmpieSEIXJb6iSJfGAiAP2GXs/z9jf9FCj3oUbF0hjKnxvC8scHPmFfhLL3yq+MA8WPZKVRbhI/h8og+axcpQuyhzbUohxTEl/KjY40nC0yrKCxQBPrxq57zE/7Ki/F4LTvHNEcSxMwzwn2+O4W8Ie+ggRPidWcClhFnommSeSuDMdw3DgldQl6JtDCSLBapLZQ3EAMOmtskZYZmYcoYI3Px06rlV5z0z11cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 PH0PR11MB4999.namprd11.prod.outlook.com (2603:10b6:510:37::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Wed, 12 Jul 2023 09:47:44 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6%3]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:47:43 +0000
From:   "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: RE: [PATCH net-next] tools: ynl-gen: fix parse multi-attr enum
 attribute
Thread-Topic: [PATCH net-next] tools: ynl-gen: fix parse multi-attr enum
 attribute
Thread-Index: AQHZs93dRsBnvsQ2oE6qwQQo1+9ekK+1guSAgABffbA=
Date:   Wed, 12 Jul 2023 09:47:43 +0000
Message-ID: <DM6PR11MB465780867DE4C45F977A06D39B36A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230711095323.121131-1-arkadiusz.kubalewski@intel.com>
 <20230711205953.346e883b@kernel.org>
In-Reply-To: <20230711205953.346e883b@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|PH0PR11MB4999:EE_
x-ms-office365-filtering-correlation-id: 2c769c60-a9c5-4193-cc6c-08db82bd0a6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pgKP8jOKWhUQO+txjyfo9XtMY9mpRQz8w6Mk6VLsSGJqQlCD1D6FBMZR1mLmxXyEZI1KrNgRmaX12yChvptLdS0aeeo2I3nnb40mKxqec4g4gcrDBnVtx0yrHBHEkqZwU0sqH0woL1BZUhbGq+mX/ILy2+6rf3d/OmM7vvbu/IVDFf2JsneyAtFHrVC9srettfBJH0hRVkZXzHxdYpRBDB8MABaGFCq0159s7P/xApKtAqJ4UqdkweSWmlWDpQULWfFz1f/PWnvUnPHptN8kggMvFT1OM+3Z+NnmhTxdNyF2uU6HYIYcVdVLAeyIbtEtDnDmTULkH1OBNke5EDtLbUNWG3Vc7cnmdXIc8bxAeCsvrBEw41NRtYvqA1UWbKvBskeONl/xkJZJF+ASBDmoLcfCATZ6djPJ8zMkLSq04WfHE0YgwiU3VaQ3fg53XqHVAo9BM/CmBlYsbA0FIEfAYY9LuA3ltRcoeQ38pRQ/DQLNMvqipuqNUH5aM2JLKUpzhoIIcNJAF+mb1zrj+bFeNVP675gCt+rCAecKoCHOXkbO08VLTBHuRqDuen7lZx9uTFWlrujCzsgwc6wcoPipZebnArBb4rJqQ9KYyZQMfg9oQnvegee1oVzHp+wBN4kY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(54906003)(478600001)(76116006)(7696005)(71200400001)(6506007)(26005)(9686003)(186003)(66946007)(2906002)(316002)(41300700001)(6916009)(66556008)(82960400001)(4326008)(66446008)(66476007)(52536014)(8676002)(64756008)(8936002)(5660300002)(38100700002)(86362001)(33656002)(38070700005)(83380400001)(55016003)(122000001)(66899021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IjqvDaaeKIvF8j5rPjFnw5ks8pMDbnHPDt6wl7EYr4o+ONftm+8pbSM50oFS?=
 =?us-ascii?Q?tlJ04luNlE1DoCcatGNs6QIfqiu+bR17Lgie0i32eqoRHjRxF0b2vknz3iCW?=
 =?us-ascii?Q?xWFuqUgoeWAcc4iacTSJQRl+7l05lttEUNSa7+Tz+4zbbjn6xuCBCvGHS+ip?=
 =?us-ascii?Q?Zaa/yF3hNbRjbt3OYkmiUc/Ni6b9mucjONaVGCG4ORTmA025sYOOd5QJJ646?=
 =?us-ascii?Q?BZw2XYNRZFR2afO7kAEDGil9Ro6b7ZzCjvqpD/f8u3/CaeIgUvSvvJNyulEQ?=
 =?us-ascii?Q?7Ik0tbwQgS/U5kZ/16GrAx83yS///H+MWLfY4QYlLThVoRE2nRS8URZ4Vte9?=
 =?us-ascii?Q?xHo7a3wIT6Y4adzj40s6YqqxlACC1hdpLt7V2F3wUEjkC4mK1fW8TboHmMxu?=
 =?us-ascii?Q?xv9EReEzZ/LzRm8rV4f6I0lBNXlJVj1tdPUFve6HhWHiPxxRL4uVofno3Zap?=
 =?us-ascii?Q?yuj5uuyArKJLIjUPwqgYAGjxiEdF0TyNCPbKHMYs8LF8W2fhzKLoqpAq/GS9?=
 =?us-ascii?Q?x2UQXx9CCXQClgPw4tWQGCPh/9GnJcH1BL3+CK5xLXNjAmjzFkKCxS7y1+cq?=
 =?us-ascii?Q?RMfJxeh4pNO9njVX5oGP4IlVgCa6WFJx1mnKukUrw4HEWAuE/cZQENjf5Q0M?=
 =?us-ascii?Q?HMtYB3mwIgiJ8RJ6TDUNEmVzsBxL/6G+Me9qiQKCSaGm9+CHGWGW4gTggE4m?=
 =?us-ascii?Q?stbNzOmIiH0Fdr5NdAxaW9hD3K1OyKesRRev4vB1YHU/geeiDerawdBLdhYl?=
 =?us-ascii?Q?kHeLTg1Ez89Z9cOSJBvyHN5cAEEuziSQkruMLcT7Ed47jSOGadDIFrz70jVC?=
 =?us-ascii?Q?/SVX1ei7nZeskRRDkdo2/a51D/5DtluD6VD36bcxcaRq34MzOuGwYEm89Vkj?=
 =?us-ascii?Q?zjmQPbd67NQbfSKaPLuGD2/co+Y+EQQs1z342It4ZfdZzVjF3GglUS97qfez?=
 =?us-ascii?Q?i3jhVfG1GIiOBRtZHyIhGiO8uz6x6RAxR4O7Icw/bj7g0qleQ9jo03jYzrhj?=
 =?us-ascii?Q?oLhKpPtVN+wDo/rdOIPr6vlVf6fayFzy0KalR2bblCtvdNxlLL7jujeltLwq?=
 =?us-ascii?Q?T0nly8nBV+m1JT8taD/0s/Y3tLS2MzpEEToJZPbfWG7eP4ly/oLRo1GlEKDW?=
 =?us-ascii?Q?DzmaPB2XTJqhfN8WG0vbMJUgNzIpeVQ5sa3OWhGMsLOGhLod19exTtitQCU8?=
 =?us-ascii?Q?RfdgFmhsyHJRfRp/w+cSbmiIqHn+/mqExRoYksWcKYJ/nE610LjlcIVvpG7V?=
 =?us-ascii?Q?wg3FrhHp9dlgFGM+auUTZTZwOJGuSdLtiwtuA2DYXR7jd1oerOssvM2m2pO9?=
 =?us-ascii?Q?6c6uOFfXBwgcuXk/MgLlOI9WmSo/+iQP/1P+u0EdRmpKAXx0WwdXEke12xv3?=
 =?us-ascii?Q?U7TC0RpKeJr4wZzHg49WRZZfcXNm9fI/NLtf+wHGnGU+uU1BlxOTIw789Sfk?=
 =?us-ascii?Q?29YnCvQNJA8rVHHzhk3OsaYuwLxBh3JO/0evctbLCQZ86/j4WFnqdDoHBFTK?=
 =?us-ascii?Q?WLHCqeM2zQb/XjC6Gtf8GdFo7iLo0gvm50ZBuCyz4QA4DmGnRmU2Er/Ubfv9?=
 =?us-ascii?Q?WorBqjNkaqTkU1qmo3zNL1r0eBqQvDjkoUfGw1hf9D5T4hW/A9obj/7INHUe?=
 =?us-ascii?Q?Kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c769c60-a9c5-4193-cc6c-08db82bd0a6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 09:47:43.7675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9tu2Sp7E1boQIhxa6GHrmw5X9cF0GYws7yayKY0F2RaL7kSm3kpOXadvCAKTME9mt5hcJ2rk8rTHg24ZYWn1yR1b+DwWeEmoStVU0TkN9yI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4999
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Wednesday, July 12, 2023 6:00 AM
>
>On Tue, 11 Jul 2023 11:53:23 +0200 Arkadiusz Kubalewski wrote:
>> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py index
>> 3b343d6cbbc0..553d82dd6382 100644
>> --- a/tools/net/ynl/lib/ynl.py
>> +++ b/tools/net/ynl/lib/ynl.py
>> @@ -407,7 +407,14 @@ class YnlFamily(SpecFamily):
>>                  raw >>=3D 1
>>                  i +=3D 1
>>          else:
>> -            value =3D enum.entries_by_val[raw - i].name
>> +            if attr_spec.is_multi:
>> +                for index in range(len(raw)):
>> +                    if (type(raw[index]) =3D=3D int):
>> +                        enum_name =3D enum.entries_by_val[raw[index] -
>>i].name
>> +                        rsp[attr_spec['name']][index] =3D enum_name
>> +                return
>> +            else:
>> +                value =3D enum.entries_by_val[raw - i].name
>>          rsp[attr_spec['name']] =3D value
>
>Two asks:
>
>First this function stupidly looks at value-start. Best I can tell this is
>a leftover from when enum set was an array, but potentially "indexed with
>an offset" (ie. if value start =3D 10, first elem would have value 11, sec=
ond
>12 etc.). When we added support for sparse enums this was carried forward,
>but it's actually incorrect. entries_by_val is indexed with the real value=
,
>we should not subtract the start-value. So please send a patch to set i to
>0 at the start and ignore start-value here (or LMK if I should send one).
>
>Second, instead of fixing the value up here, after already putting it in
>the rsp - can we call this function to decode the enum before?
>A bit hard to explain, let me show you the diff of what I have in mind for
>the call site:
>
>diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py index
>1b3a36fbb1c3..e2e8a8c5fb6b 100644
>--- a/tools/net/ynl/lib/ynl.py
>+++ b/tools/net/ynl/lib/ynl.py
>@@ -466,15 +466,15 @@ genl_family_name_to_id =3D None
>             else:
>                 raise Exception(f'Unknown {attr_spec["type"]} with name
>{attr_spec["name"]}')
>
>+            if 'enum' in attr_spec:
>+                decoded =3D self._decode_enum(rsp, attr_spec)
>+
>             if not attr_spec.is_multi:
>                 rsp[attr_spec['name']] =3D decoded
>             elif attr_spec.name in rsp:
>                 rsp[attr_spec.name].append(decoded)
>             else:
>                 rsp[attr_spec.name] =3D [decoded]
>-
>-            if 'enum' in attr_spec:
>-                self._decode_enum(rsp, attr_spec)
>         return rsp
>
>     def _decode_extack_path(self, attrs, attr_set, offset, target):
>
>Then _decode_enum() only has to ever deal with single values, and the
>caller will take care of mutli_attr like it would for any other type?

Sure, I will try to implement your proposal and send update here.

Thank you!
Arkadiusz

>--
>pw-bot: cr
