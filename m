Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA996E29FE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 20:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjDNSWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 14:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjDNSWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:22:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586C810F1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 11:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681496534; x=1713032534;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AlpKYruortgR2K46UrbcZgRV8dpK7g/wqw6mPm1VZ2k=;
  b=MkuNivLWw6OloueiPy/+NZqo2dzOIic3pLfVwS6veAF89/l47MpRHqUH
   2/+sGcdTOWTHsnQUu1Wblfg5E3r/hdtKmFZ1Gv3iubKPanDvr8h+lQa6t
   kWU0MkP5Ox3VdYlhn/oVXIXlV5JPUMnataN5pxxlwTLyC08MoJ7lc/J8n
   K1d/Ui1EwT3VgsE37xizKeNr5H5AqfWHv7Mqn62NBuW/ij0NxHLps2RNC
   emwzGbDTa9brnW78OLDWeQec7awgfro6RIgEewjL0Y7J2nCEboX328+Fq
   JIXcJ4FJ63BGeF5wT7yA0mzgHI/TmoNTpSVAWapH7eu7jw5tlbnjOOH9s
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="409743980"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="409743980"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 11:21:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="754536053"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="754536053"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 14 Apr 2023 11:21:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 11:21:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 11:21:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 14 Apr 2023 11:21:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 14 Apr 2023 11:21:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWJey4e47r1Xs1niAH9OKVHhDdYPsxgKgZayEPuuQkeRUiNRT1Az1yQ4jbXbvPbGxYiycYAN9P2HVzs7IHQzIj9JMQbB1AaFzx4Nd6CYn6KxlH0Nq5l025k8YgEpy58uyi9RYEcUntMpcOwXgXXB09f7mkeb5QxPZkZ9z+2eqTwW78PkvbsrWqEnxDI3ABalG+lFgo5tsdtZaMZYhhCxJU/ZpsjMYh5kzQKktq9tTdmvrJ8lYq1YjXjTuYspUwPnCvc7QHbjq+AnKJX7+DpCrUuqy56ozbomrMlh0Qh+y3GSsS1WQKOl4GkcLNpSOOxD2qUGLa3dk+oRXNrLoXql5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlpKYruortgR2K46UrbcZgRV8dpK7g/wqw6mPm1VZ2k=;
 b=Ih7uKhqFTiMOgqNW9P2IVwsX6CY/ApDl0qDwJO6WUmHCcugpCpZ8UQFt6EuZ8Zr2e6Yefy1phGQ5JNRT4lefkrVXTStnMT0+g74T8DEtyfmLlNWUCsRobjbAMO6N6zvUW1/Yfop0NEdl+DxTPl5VasKSr/m63nuP1u6ca1u4qKJpy4q2ki8IFb+tll9Q4YzwzqQLYBk3jR/c7bfm9TnECtv1P0AdBtaH2JkaaZOkdjhN09eCAfb6RadFg23CoeGL7Bl7kKtVWApqoES5kLTBYiSXibqN2hhg2Z/TYmzAqEtiJZaSY5s7wRCnCAN6arp2fP70+z9jell/a+E/hlGklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MN2PR11MB4533.namprd11.prod.outlook.com (2603:10b6:208:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 18:21:53 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3%6]) with mapi id 15.20.6277.038; Fri, 14 Apr 2023
 18:21:53 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Liam.Howlett@Oracle.com" <Liam.Howlett@Oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] mm/mmap: Regression fix for unmapped_area{_topdown}
Thread-Topic: [PATCH 3/3] mm/mmap: Regression fix for unmapped_area{_topdown}
Thread-Index: AQHZbuGFm4Wq+BshnkmYPdeOWIdmDa8q/i4AgAAQdwCAAADhgIAABtUAgAAD+YCAAAPhAA==
Date:   Fri, 14 Apr 2023 18:21:53 +0000
Message-ID: <5f15e46556ac4366682777f797157e48620c3b05.camel@intel.com>
References: <20230414145728.4067069-1-Liam.Howlett@oracle.com>
         <20230414145728.4067069-3-Liam.Howlett@oracle.com>
         <3bf69efaeddae3599a6d7ea8a225f64066811473.camel@intel.com>
         <20230414172610.f35pngvz6cilxsdq@revolver>
         <20230414172919.ynxybbocc4o4tbtd@revolver>
         <3f30fe59dd6b368db82ae91b61152bb133c4831f.camel@intel.com>
         <20230414180759.zves3glmrptl6zog@revolver>
In-Reply-To: <20230414180759.zves3glmrptl6zog@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MN2PR11MB4533:EE_
x-ms-office365-filtering-correlation-id: ee746ad3-d0f3-40f0-6c2d-08db3d151f7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UJis7kdx7j3NV0YLnG7NgGuFJa1psi0pQEYtr2dxCXmX/gMkH5vy/xWhEXi1cJKvbIyQu7Jcu0MbIwHtyARcPrV3ou2R+yLjpAJt+ZhCqgXDBLwvtFGM5XG1+88JC3D2A7WANFHtRQvBrNBnb16THkPlsYxo86iiN9G80ipVMqscQxiwGrG1aIwS8KgBxdQ1QmKK7uBfNTlvfM+2Yfj1ennEDVE+yFXy79rGQO12yE9ZtRDNkpgf2WV3qO/jHLv79hemGZUHOX8lTyCukcAWCD1YBdl+edQg9Yk1WP4IHchTm+GE1qeSXFDodtZbuFshl3WKrFSUW9plHtgTtmszb8y/EoD6fL3uNqji2pZJIkcv73n4IQtO4ugodR9j8D+1FpTpe07gSxgFv9SToP8ufFmKyLNp+FmbqjVu15e5EzjhJKuH982S18r6g6Sz/68r8i28xWkgPHLrVa4I8fNJtW4BPQe5w5HLwK2cy4eR1key1szkuWt77bAzZoV2rQh4dJt7NSP3KjyoCcbd9pituL+giHc4WTuarvxeqwB8p1K9inDsH2bk5eTt9Hra4wi9XHQwpYHrOlQukGVUXk3r9nyRljOgkmVS5fehztXNWnWj2zB8U2X+qrChVWHvXG6c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(5660300002)(71200400001)(6486002)(66556008)(6916009)(2906002)(66476007)(36756003)(4326008)(66446008)(76116006)(66946007)(64756008)(91956017)(38070700005)(86362001)(38100700002)(122000001)(82960400001)(41300700001)(8676002)(316002)(8936002)(478600001)(54906003)(26005)(6512007)(6506007)(2616005)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHB3WVk3d21hYU9OQzNMT0hpVlhYVVl2VlBtQXFqUzlPbjhyaWlYWFdqRVlr?=
 =?utf-8?B?dkF6d2ZrTnFlMDd1M0hqSXpQRGVKcjZTZmZEN3VxbnNIYjZFZFFDS1hsYm9j?=
 =?utf-8?B?NlMvT2JIb3MzYkF1bVNScnRIN0NvcFpoZDZHY2JnVnVIWHZ0UTBEWExFcUVv?=
 =?utf-8?B?SStnYkhsVVN0U1RFZGlPQ1lPckZtMjA0TzdKYkF2eWpBOUV4R0kwSXVrVWhu?=
 =?utf-8?B?S3lZYkVyaXJnMDZxakFZZHlSVmJ4Ty96NmdDbmhKNGtyUHVuMW1zZXM2dzI2?=
 =?utf-8?B?Zjlyd1dpcUdCbHpGNnYweUkxQTNKa1FCUVFQdzlDbGtJalJFNmwzZXBlUHJy?=
 =?utf-8?B?MVpNak9BTjlLS0Jsbmh5SkJGbExVbHpCM25XaTFTUHpNTGE4Nmg3WXYwWEIv?=
 =?utf-8?B?R2UxemRNSk1lRlB2NEE1YjZUWjZITjBuUWpzWDN5SVVSbm1zdW42TmJZL3pM?=
 =?utf-8?B?ZlZqTXdmczRrS2orcW1kTnJGcEhPNnZidzljQ1lpQ1JuZ0dDeU9YdkxXbFB5?=
 =?utf-8?B?MDdnb0hpekM0bjhZWXozZmtMUFQwWWNrYmpwL1o4elZUSXhpYnpNa29FemJr?=
 =?utf-8?B?M2NGZHE2ZjBTdmNjK09rZ283WDR0R0krMDFiTGZIVWtmaEp5S3FUNVZkQUhI?=
 =?utf-8?B?eXFEeXdqem5meVNldEI5YnVsTXRrd1R0OTdFWUdLOUJuWFlvelRxRlo0UmNI?=
 =?utf-8?B?TEpndE1GMGZ1VkFiaCtVQ2t1bExXb3ZUdDhGbmFWQkJoczhTYzRzMzAyc1h4?=
 =?utf-8?B?NWFYZWc5bHNBaHhVbUFmVUM5MTZCYTJDK0hCWXRCeWJVcUlQYVI1TS9MZXNI?=
 =?utf-8?B?cXk5QVVtNGdMaS9ZTU5UK0hNRzlUdjlpd1YrRWpKV3FIOHp6ZGFZNnMzd3lK?=
 =?utf-8?B?K05xK0dkT2M0QVhGK2ExdUlKSmg4dlprY1RnOWJpRU9odmYzRHNBNk5LY3E0?=
 =?utf-8?B?TU8xeGdCaUdFU2liOERHMmIweFhhL0RCaEx4TWhua2MrTU9mUWIwM1pweUN4?=
 =?utf-8?B?bGduTE5Rc3RwZFcwb05iU3hlTVpFd1lPN3d2M3BRcTRzT0pSTkJOTzdjOTF0?=
 =?utf-8?B?MXZYMHdDZUJ2c3V0cG5tc1lmQlV3aERMUmZYWnlpVFhla0NML2lobGx3dGxk?=
 =?utf-8?B?TDBMR1RNZ1pFWUVSUXVrQkpmMld3NEdxczMvWVBTUTlsS09TZ2VDU2EwQlRI?=
 =?utf-8?B?YWNSWHJjVUpYbThhOWxRZlgvZDgrRWN2Z3R5amlkcFZveXJrZ0VYcHdIWXFt?=
 =?utf-8?B?KzgzdVlaaWw1VTlKS1JLZFZNTmx6dkFJSC94c3NFSzVJNjRLZFNLcXlhM05W?=
 =?utf-8?B?dTRkL2NRQUUvR2ZyUGdlb3Q0alV6eVJNY0NrRkpQUEhaZGJuNElTSGZxY0tM?=
 =?utf-8?B?K081ZVdKYWN4YVYxMTBLa3o0aTVhdmZGbldpeTd5dDViVUFOZE9NYkVEcTdh?=
 =?utf-8?B?dkJzWEZoWUZMK3AvOVA5R0hJenQvMUs5RWh3V0ZONnlOU1BSU3NkY3pvMTMz?=
 =?utf-8?B?SGh0VFFreDhRZmh0b1BGZHRZOGh3YnpBNHNWaXRRNTI2V0plM0hORm5hSlpI?=
 =?utf-8?B?N2o5U2l0WGFWMEI1MUhaRXcwL2EremIvYnRZMEZPS05mRjBnR3hqUnZSdXRY?=
 =?utf-8?B?YndXUFYrNHZaYi85SnYwNklHdXQ3REU2NGxjcmdCVE11UFhpVXZIV3VhZ2Zl?=
 =?utf-8?B?ODBTSUowdnIzNGtPNjZUeUhFVG1HQUtRVzgwUnQ5ZzJKMFk5N1l6STNOWFgv?=
 =?utf-8?B?NWRlakk0R3ZxU0FYWDJQV1lONXpDQnVFMlpqMjVvMGxQb3k0WUJKakRydWtD?=
 =?utf-8?B?SE42THV5bGhsSWdzMmlEV3dWei9KNGdzekFKQit5eTJ3bW42Mk5pWjN0dWR1?=
 =?utf-8?B?Ty9sRzV6RVd0U0hXVDZ4YjRwenhSdUxUS0VWOFh3Y1R6NVZFbzVBMmZSSUxr?=
 =?utf-8?B?cFhaWWpienBzcmRtZGxaWkN4MmFRU0lnaXdXNi9oWk1TS3d6R0pPeUFJTzgx?=
 =?utf-8?B?RklHV2l5enJNTmwrV2ZGbFhKNlg3MmVESXZDa1ozYmdvbWgvQ2t4Q1pBNlVN?=
 =?utf-8?B?YVNjR3VHUWpORjdrbGFRVnBjczVjNDY5ZnBsU2cxS3NGcXhqUjBZbGVyTGFM?=
 =?utf-8?B?SXdvMzZ3bGhGazczSFRxVlNFaEUvdm9wS0RYS05nSThWaWhkb21hMk1BdWVO?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBA8C92944073E43BD5B69841A3983EC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee746ad3-d0f3-40f0-6c2d-08db3d151f7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 18:21:53.4521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fB0GAcGesMePJ8x0L37jueIgytoklHDR2l+yQxGCo/LLuP5r3EeaBW+FCBzAOJ+lyAnLEcyCcdxAvaYlwOIetfyvkIbfVa1upYfJA7gAP2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4533
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA0LTE0IGF0IDE0OjA3IC0wNDAwLCBMaWFtIFIuIEhvd2xldHQgd3JvdGU6
DQo+ICogRWRnZWNvbWJlLCBSaWNrIFAgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiBbMjMw
NDE0IDEzOjUzXToNCj4gPiBPbiBGcmksIDIwMjMtMDQtMTQgYXQgMTM6MjkgLTA0MDAsIExpYW0g
Ui4gSG93bGV0dCB3cm90ZToNCj4gPiA+ICogTGlhbSBSLiBIb3dsZXR0IDxMaWFtLkhvd2xldHRA
T3JhY2xlLmNvbT4gWzIzMDQxNCAxMzoyNl06DQo+ID4gPiA+ICogRWRnZWNvbWJlLCBSaWNrIFAg
PHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiBbMjMwNDE0DQo+ID4gPiA+IDEyOjI3XToNCj4g
PiA+ID4gPiBPbiBGcmksIDIwMjMtMDQtMTQgYXQgMTA6NTcgLTA0MDAsIExpYW0gUi4gSG93bGV0
dCB3cm90ZTo8YnI+DQo+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqB0bXAgPSBtYXNfbmV4dCgm
bWFzLCBVTE9OR19NQVgpOw0KPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHRtcCAmJiAo
dG1wLT52bV9mbGFncyAmIFZNX0dST1dTRE9XTikpIHsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBX
aHkgYWxzbyBjaGVjayBWTV9HUk9XU0RPV04gaGVyZSAoYW5kIFZNX0dST1dTVVAgYmVsb3cpPw0K
PiA+ID4gPiA+IHZtX3N0YXJ0L2VuZF9nYXAoKSBhbHJlYWR5IGhhdmUgY2hlY2tzIGluc2lkZS4N
Cj4gPiA+ID4gDQo+ID4gPiA+IEFuIGFydGlmYWN0IG9mIGEgcGxhbiB0aGF0IHdhcyBsYXRlciBh
YmFuZG9uZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGlmICh2bV9zdGFydF9nYXAodG1wKSA8IGdhcCArIGxlbmd0aCAt
IDEpIHsNCj4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgbG93X2xpbWl0ID0gdG1wLT52bV9lbmQ7DQo+ID4gPiA+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1hc19yZXNldCgmbWFzKTsNCj4g
PiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Z290byByZXRyeTsNCj4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9
DQo+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqB9IGVsc2Ugew0KPiA+ID4gPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRtcCA9IG1hc19wcmV2KCZtYXMsIDApOw0KPiA+ID4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICh0bXAgJiYgKHRtcC0+dm1f
ZmxhZ3MgJiBWTV9HUk9XU1VQKSAmJg0KPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB2bV9lbmRfZ2FwKHRtcCkgPiBnYXApIHsNCj4gPiA+ID4gPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbG93X2xpbWl0ID0g
dm1fZW5kX2dhcCh0bXApOyANCj4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgbWFzX3Jlc2V0KCZtYXMpOw0KPiA+ID4gPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIHJldHJ5OyANCj4g
PiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9DQo+ID4gPiA+ID4gPiAr
wqDCoMKgwqDCoMKgwqB9IA0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IENv
dWxkIGl0IGJlIGxpa2UgdGhpcz8NCj4gPiA+ID4gDQo+ID4gPiA+IFllcywgSSdsbCBtYWtlIHRo
aXMgY2hhbmdlLsKgIFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24uDQo+ID4gPiANCj4gPiA+IA0K
PiA+ID4gV2FpdCwgSSBsaWtlIGhvdyBpdCBpcy4NCj4gPiA+IA0KPiA+ID4gSW4gbXkgdmVyc2lv
biwgaWYgdGhlcmUgaXMgYSBzdGFjayB0aGF0IGlzIFZNX0dST1dTRE9XTiB0aGVyZSwNCj4gPiA+
IGJ1dA0KPiA+ID4gZG9lcw0KPiA+ID4gbm90IGludGVyY2VwdCB0aGUgZ2FwLCB0aGVuIEkgd29u
J3QgY2hlY2sgdGhlIHByZXYuLiBpbiB5b3Vycywgd2UNCj4gPiA+IHdpbGwNCj4gPiA+IG5ldmVy
IGF2b2lkIGNoZWNraW5nIHByZXYuDQo+ID4gDQo+ID4gSG1tLCBJIHNlZS4gSSBndWVzcyBJJ20g
dGhpbmtpbmcgYWhlYWQgYSBiaXQgdG8gYWRkaW5nIHRoZSBzaGFkb3cNCj4gPiBzdGFjaw0KPiA+
IGd1YXJkIGdhcCwgYnV0IEkgY2FuIGFsd2F5cyBhZGQgdG8gdGhlc2Ugdm1fZmxhZ3MgY2hlY2tz
Lg0KPiA+IA0KPiA+IEJ1dCBhcmUgeW91IHN1cmUgdGhpcyBvcHRpbWl6YXRpb24gaXMgZXZlbiBw
b3NzaWJsZT8gVGhlIG9sZA0KPiA+IHZtYV9jb21wdXRlX2dhcCgpIGhhZCB0aGlzIGNvbW1lbnQ6
DQo+ID4gLyoNCj4gPiDCoCAqIE5vdGU6IGluIHRoZSByYXJlIGNhc2Ugb2YgYSBWTV9HUk9XU0RP
V04gYWJvdmUgYSBWTV9HUk9XU1VQLCB3ZQ0KPiA+IMKgICogYWxsb3cgdHdvIHN0YWNrX2d1YXJk
X2dhcHMgYmV0d2VlbiB0aGVtIGhlcmUsIGFuZCB3aGVuIGNob29zaW5nDQo+ID4gwqAgKiBhbiB1
bm1hcHBlZCBhcmVhOyB3aGVyZWFzIHdoZW4gZXhwYW5kaW5nIHdlIG9ubHkgcmVxdWlyZSBvbmUu
DQo+ID4gwqAgKiBUaGF0J3MgYSBsaXR0bGUgaW5jb25zaXN0ZW50LCBidXQga2VlcHMgdGhlIGNv
ZGUgaGVyZSBzaW1wbGVyLg0KPiA+IMKgICovDQo+IA0KPiBJIGRpZG4ndCB0aGluayB0aGlzIHdh
cyBwb3NzaWJsZS7CoCBpYTY0IChvcnBoYW5lZCBpbiA5NmVjNzJhMzQyNWQpDQo+IGRpZA0KPiB0
aGlzLg0KDQpBaCwgb2suDQoNCj4gDQo+ID4gDQo+ID4gQXNzdW1pbmcgdGhpcyBpcyBhIHJlYWwg
c2NlbmFyaW8sIGlmIHlvdSBoYXZlIFZNX0dST1dTRE9XTiBhYm92ZQ0KPiA+IGFuZA0KPiA+IFZN
X0dST1dTVVAgYmVsb3csIGRvbid0IHlvdSBuZWVkIHRvIGNoZWNrIHRoZSBnYXBzIGZvciBhYm92
ZSBhbmQNCj4gPiBiZWxvdz8NCj4gPiBBZ2FpbiB0aGlua2luZyBhYm91dCBhZGRpbmcgc2hhZG93
IHN0YWNrIGd1YXJkIHBhZ2VzLCBzb21ldGhpbmcNCj4gPiBsaWtlDQo+ID4gdGhhdCBjb3VsZCBi
ZSBhIG1vcmUgY29tbW9uIHNjZW5hcmlvLiBOb3QgdGhhdCB5b3UgbmVlZCB0byBmaXggbXkNCj4g
PiBvdXQNCj4gPiBvZiB0cmVlIGlzc3VlcywgYnV0IEkgd291bGQgcHJvYmFibHkgbmVlZCB0byBh
ZGp1c3QgaXQgdG8gY2hlY2sNCj4gPiBib3RoDQo+ID4gZGlyZWN0aW9ucy4NCj4gPiANCj4gPiBJ
IGd1ZXNzIHRoZXJlIGlzIG5vIHdheSB0byBlbWJlZCB0aGlzIGluc2lkZSBtYXBsZSB0cmVlIHNl
YXJjaCBzbw0KPiA+IHdlDQo+ID4gZG9uJ3QgbmVlZCB0byByZXRyeT8gKHNvcnJ5IGlmIHRoaXMg
aXMgYSBkdW1iIHF1ZXN0aW9uLCBpdCdzIGFuDQo+ID4gb3BhcXVlDQo+ID4gYm94IHRvIG1lKS4N
Cj4gDQo+IEFic29sdXRlbHksIGFuZCBJJ20gd29ya2luZyBvbiB0aGlzIGFzIHdlbGwsIGJ1dCBy
aWdodCBub3cgSSdtIHRyeWluZw0KPiB0byBmaXggbXkgcmVncmVzc2lvbiBmb3IgdGhpcyBhbmQg
cGFzdCByZWxlYXNlcy7CoCBIYW5kbGluZyB0aGlzIGluDQo+IHRoZQ0KPiBtYXBsZSB0cmVlIGlz
IG1vcmUgaW52b2x2ZWQgYW5kIHNvIHRoZXJlJ3MgbW9yZSByaXNrLg0KDQpPaywgdGhhbmtzLiBJ
dCBsb29rcyBnb29kIHRvIG1lIGluIHRoYXQgcmVzcGVjdC4NCg==
