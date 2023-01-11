Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D6A6655AB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbjAKIDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbjAKIDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:03:06 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C22CF7D;
        Wed, 11 Jan 2023 00:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673424154; x=1704960154;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dhxUuuUu9Gy861Kc8cWdr9u3OLlu2beJirMM7aLcDWg=;
  b=R7NUiBvJ5Vh57WOhvt+wNOLMUnfUXClHJm7/zkhk2LcAK10U6WyNB9Kg
   0diJSw+fcTIFeRpjoyyVEIoPFsHq1tp6JwhJBCOPX4Nmf/+K/hZZic9Gq
   ZI+Vy4dpHCk9+aDeQSM86d4DS+lwpJVH3Ba59a/+Tj42hyTIfFqfH2mlk
   fihLk+2aDj7Aq7Jd/a1btv4yreQSxCQ5vV+JZqPIFNU+k5Tc49s4Ql0ud
   9M0/P0eo90R8/C9vMHXQgFYsjUH0HDaqu9kIjIAq92KN2/he5WiqN4Yyn
   GH7t+PlgWoXxIz6Oy1CgW/c3oprArx2YpgvCDdhQaEeBtKvBvS2Cnfsjg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="306873759"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="306873759"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 00:02:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="687843408"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="687843408"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 11 Jan 2023 00:02:33 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 00:02:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 00:02:32 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 00:02:32 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 00:02:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLBmi3az3w8c6G+8Rc8jgd6ZJz8owN3KPIAiMcByXZKwhEaRCR01Fa3PBGnPFQDAc7Y02uMu8bWJzLx3bT7F2KY8loeeyKh2xg6cWF5hZ6L79kXCYgiLjZQsmAQqtbh485+Gxq3umSgTXC7NX92NXRSylsF77bZFx89/uqED/xF4Zt9CgQcak1nLUr4QSizew44gz8PjB3qpu1vg5Ew86IiJWK+ijQf83j9K4/FmZg5mIW+WMa4ZZaUcpYh4cQxAcWMgB2oY7IKz7EZ2NkS2iwaOscLwPFWJIgmok+Baz/WyrIqY6RrcIspVik2PGbag11wG1P6W/4FLMbiX3bcoHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhxUuuUu9Gy861Kc8cWdr9u3OLlu2beJirMM7aLcDWg=;
 b=GwPORBurTpQiBOYtj5TSbyBgglePlN9v8PvQg2GqbmoQxnAoOpszPO+Pc8CtTOgxtorSWiqukNGSfBxLGGJ7XGpMhyzWAlFndwrngu+5cHhJIBYrjPSgSiIOyL0KaAN7sx0BUa8kkkbV7e4FPkb3Lqte8qECcElI7TGgdnm5ct5/lm+bI1Go3DU/GNpzSkLm2LfmiGjWe1lKS7xV6fEjftzunmKOzv1WQGCVncVC+JQy5h19Bcr49+mSIp8lUWYsioHqRpb+OUCaWVHAstaxsQ90/E1oPANovTDynt1/+QtB1X8e8F2YF3LGGgb4mP/4V2rWTXdL2ig+aKUszLjoSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DM8PR11MB5623.namprd11.prod.outlook.com (2603:10b6:8:25::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 08:02:30 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%6]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 08:02:29 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chen, Yu C" <yu.c.chen@intel.com>,
        "Zhang, Yang5" <yang5.zhang@intel.com>
Subject: Re: [PATCH v1] ACPI: PNP: Introduce list of known non-PNP devices
Thread-Topic: [PATCH v1] ACPI: PNP: Introduce list of known non-PNP devices
Thread-Index: AQHZJR0gKBuvlkN6PUyPjwH7KCdxOa6Y0XGAgAAKbIA=
Date:   Wed, 11 Jan 2023 08:02:29 +0000
Message-ID: <b6c9bbdeea2f9d7f05d2d129a47e8449033d956c.camel@intel.com>
References: <12149290.O9o76ZdvQC@kreacher>
         <c9acadcd3e19e7dafb8ba4cf1f0abb0200b18b1a.camel@intel.com>
In-Reply-To: <c9acadcd3e19e7dafb8ba4cf1f0abb0200b18b1a.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DM8PR11MB5623:EE_
x-ms-office365-filtering-correlation-id: fe8ceee6-a4a7-46cd-32d9-08daf3aa2fd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RegsHuc634bZu5P6TP9st3Bpf+Sdjcrgpf6AwOOENr7w6+D3lNRo4TZrjPbjq1hlxkguof33bu8v8utYuWBoYlSanlWvnDN92RcYW3jNy7E8oCoa4+0h2gwj+/4sX+FhiYrnvHthnysgfXO2QBwRRZQUUYZ813UkZHJPRrrFPaXzsqM1iF/2VPsmT19y/zVmxCSnuJNIVw+MuGRdHSq9pUMUcDbDyrmYVlgB07siV5zU54oQfI3TNtDb5Suk9aW4sLq0oHBHJFEOb2xSjJ0hVCT3Jgi5wSwVISvGw26fI6OU1/ZXo5kLTk2n/r6b1AVMHpeGXkO4h/tkC6ExX6QVPJDl3UUp7lf/e3H6HH4zk6R9GVRnS/m8OCCS3C2lCvsXRyyVBjQncFQ+IaqFQZqIN7ms9uhZa4BhJvc+rvG8HTQYmtVzSopuVvN4MzXJRFQG34O5WErUYRHxvdHHLIXIPT/DYxtPO3LUoiJ1nYLH6ZoozRBlueyMDzwM7os3YZrDmWTYdc/gDmILqtXuSRS0gKVrQ1Molo3IejvR5neRKWIxJYVywDEgcVAoITi50BN1DHzZwtWWn0GIze4BI+JjPVe4Xwe1FXijsx9XP0VNb3rdmU/1OB6AuPjAKghachnVMoR/Vl1lXPjVXbUzHuA6SwrLMVQvEbncsTqf623TMa3JcCjy+iNQC59dAnkSa9rXAkIGrFyiiZB2l2+SFMXCQbPLwduTrsQXUEOACbcMfHrKXzkW4zSXRLsHQLC4LLCo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199015)(107886003)(6506007)(2906002)(64756008)(6512007)(4326008)(8676002)(66476007)(66556008)(36756003)(66446008)(84970400001)(5660300002)(8936002)(122000001)(83380400001)(91956017)(38100700002)(82960400001)(38070700005)(41300700001)(478600001)(6486002)(186003)(26005)(76116006)(66946007)(86362001)(71200400001)(316002)(2616005)(54906003)(110136005)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTBmZzBFdnFqRFZYWXUxN2RPM3p0K0NFWVZWV0IzazJZK0wvZXk5ZmJEK0NE?=
 =?utf-8?B?YktiTUEvVmJrbXhWaUlmNCtPREM2VERpZXowZkFRQUlmdUlmajNkdXRFVjRl?=
 =?utf-8?B?N2NjZk1FN056OXJMQ2VSWWNVSHpxQ0lldi9VYWF0Sk1TVUdNSCtLSmtSTHp3?=
 =?utf-8?B?VXRlZEJTdFZueGtrM3UzTXJCRk9iWUFYaEs0cUVMNlNtK0xvRXkza2N5V2Jz?=
 =?utf-8?B?cnNGb3lwZFB4bzFFTEhiL2tHZDRzU0FRZHZvU3RnVHBVVTFpVVZ1SXFyQ2tw?=
 =?utf-8?B?YlFHemdQdkltbXh6Z28rdmExdjRLQm04RzBDS0E3S0FaSGJCaGhQSVlwTVY2?=
 =?utf-8?B?Si84SnNzN1lRYVptMzdHM29GdisvUEtOZnI4dUp5dmpQM0hveHJBdnZtOWp0?=
 =?utf-8?B?dmhQdk1VUVg2emovS2xSUTRDL2N0MWNodWxEYm55bXpoQ2tJOFV1Z3JwQ2RY?=
 =?utf-8?B?ZVZPVWdORnZwWkJ4MWp6NXJkMzRWS1Y3OTkxWlBpamJGU0kyTjZMVnhhdzVV?=
 =?utf-8?B?NHVzUTJTWGVrN0EralczUE56bU1nSWRydDdkNi9xZnNiaXgwK3JUV2tZUGVX?=
 =?utf-8?B?alFXVHdHWGNJSE1KeDFtTWF4T1pwcG1MeWJ3d0R3YkJjZEVRSFFSY1RTdkxX?=
 =?utf-8?B?aHNkM29OV0JjWTY2Y21tSEJuTnZoOHN4cFYvMjY4bWNNVG1rUXhQaDVkb2FI?=
 =?utf-8?B?SVFCY2Y1eG1YNXp2SFRKQm1aTWJDd2taYWlyd0pKUXlsRmJ6SGpzVVJsWlpG?=
 =?utf-8?B?S3RWOXB2eG44UnJzTjR4d2FZOXdPNlN3eGhjM0FyVzg2YXVLVm9NdVlCcjE2?=
 =?utf-8?B?UWIrM2dnNWVFaStnVG1rK0s3OGtJc0piMmtMdTErNFdYNlNqNUtraFdtYTZu?=
 =?utf-8?B?bVhYUHJNTmp2TmRYWmRmYkgwZUFGbDdFNlNTRGJEUERkNTZRVlRwbStjYThj?=
 =?utf-8?B?QURiVHhhaUt0cWRINTVZcmlOMmZHNGF6R0pLbUl5YXhxMDVVS1QvNWNQT2ZI?=
 =?utf-8?B?VFZlM3RzUml6OW8wWm8wMTNSY2IzdkltcVdiWG4yaDlEa3ZDeDE5cWVIMHVs?=
 =?utf-8?B?N25IZmtXc3ZxTGJmb0l6TVlrUWRXdkRDelJMYlBPTW5PZnQyejlPVThTWkdh?=
 =?utf-8?B?UkNKQ2laczQzYXZqeUVPSVZrUytQNjJjeE5ldWpOS3NKM0w3NC8xYnRKYzAr?=
 =?utf-8?B?dFB2VnZ0enhFYVM4ZSt5ZktQVEJoVDR2UGRCY2VpTjVRZnlaQmFJUlJvYlFQ?=
 =?utf-8?B?cUZjSStvREVWcGU0RmxNUU1PQ0dzRDhTNmYwYk1MSTZKaEJGSnA1WS8vblM3?=
 =?utf-8?B?dTA4dXprYmE3WnFxUkdNbUl6bGxkc0ErQXNjMWZZaG95Yzc0by9LdVNGcGZj?=
 =?utf-8?B?YXFGb1ZweDlMOGQ0S0NBQ2VqUlFwYmtIM2RndlI3MkZTNW1OM2xVb2dnWFJB?=
 =?utf-8?B?YVl6d2IvUjJwUnFFTDYxL29zUGNLUTN3OTh6eEtCMjBsU0NtcEFwY2dYYW5I?=
 =?utf-8?B?RmswODlORHltaDZmQ3duUDJBdU5UM1R3ZU1LQWZzV2c0alZIVnR0RDMwczRs?=
 =?utf-8?B?QnpVcXpJZzdsT3pKaExDVUlodmFUc0x6NGZMV243WEd1M2tLZG5GUVFaclls?=
 =?utf-8?B?ZXdMeUxWZjREU0lrQUhuUWlMRHNTKzFJS1JEVUc1ek9jd3NocFpzZHJpYml1?=
 =?utf-8?B?ZndCS3JCMTZtOGQ1WEJHdVNQZERwOUdQeWg0UFVla2ltVFhzZFZ4bFVMYXpq?=
 =?utf-8?B?VU9sVHI1VTc1c3ZrUUtZeERLd0t2cUp6eWllRmRueURnRUhNOGVRTVAzczVh?=
 =?utf-8?B?cnFBdUdBaEc2SzZIalhhKy83YUsvUzhMV0JqbjA5QmdMM2FpRTk3a0NOTmEr?=
 =?utf-8?B?aXJGdTJLTWlTRGlvaTN1ZFNBNENhUGplUDJ3THcvOWhmN0MrWVRYK1VtdEYr?=
 =?utf-8?B?Q2RoQTZaV01FTXdHWlI2OGs2V2dBc1pkWW9pbk9aa3VXRVVsTUlwaWFMNENp?=
 =?utf-8?B?Z3J0YkJhTnYrQjFtUEtNWXRjbnpweU10LzExYUhDd3RGS2xiZmFOVC9GY2pq?=
 =?utf-8?B?akZJL2dHSmc5OFE0U0hScXNzdkpDZFM5K3ByU25mWEdzS3hyVFhac1k5Y3Zr?=
 =?utf-8?Q?OBLFzMvCQQWbnb+qZes1HBeCs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B08E1AF22CECA44B74436DA40176AF7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8ceee6-a4a7-46cd-32d9-08daf3aa2fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 08:02:29.8041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDXZP0aXjis+bj+M7SVGD2MOqsWlxwDNfzqR+ow6+3rg8yibPvcxa0J5LEk2Ctq0lEWdY1nYVTPJ9lr3Ok3vDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5623
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q0MgWmhhbmcgWWFuZyB3aG8gaGFzIHRlc3RlZCB0aGUgcGF0Y2guDQoNCk9uIFdlZCwgMjAyMy0w
MS0xMSBhdCAwNzoyNSArMDAwMCwgWmhhbmcsIFJ1aSB3cm90ZToNCj4gT24gVHVlLCAyMDIzLTAx
LTEwIGF0IDE4OjU4ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4gPiBGcm9tOiBS
YWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+ID4gDQo+ID4g
SW4gc29tZSBjYXNlcywgUE5QIGRldmljZSBJRHMgZnJvbSBhY3BpX3BucF9kZXZpY2VfaWRzW10g
YXJlDQo+ID4gcmV0dXJuZWQNCj4gPiBieQ0KPiA+IF9DSUQgZm9yIGRldmljZXMgZm9yIHdoaWNo
IG1hdGNoaW5nIHBsYXRmb3JtIGRyaXZlcnMgYXJlIHByZXNlbnQgaW4NCj4gPiB0aGUNCj4gPiBr
ZXJuZWwgYW5kIHNob3VsZCBiZSBib3VuZCB0byB0aGVtLiAgSG93ZXZlciwgdGhlIElEcyBjb21p
bmcgZnJvbQ0KPiA+IF9DSUQNCj4gPiBjYXVzZSB0aGUgUE5QIHNjYW4gaGFuZGxlciB0byBhdHRh
Y2ggdG8gdGhvc2UgZGV2aWNlcyB3aGljaA0KPiA+IHByZXZlbnRzDQo+ID4gcGxhdGZvcm0gZGV2
aWNlIG9iamVjdHMgZnJvbSBiZWluZyBjcmVhdGVkIGZvciB0aGVtLg0KPiA+IA0KPiA+IEFkZHJl
c3MgdGhpcyBieSBpbnRyb2R1Y2luZyBhIGxpc3Qgb2Yga25vd24gbm9uLVBOUCBkZXZpY2UgSURz
IGludG8NCj4gPiBhY3BpX3BucC5jIHN1Y2ggdGhhdCBpZiBhIGRldmljZSBJRCBpcyB0aGVyZSBp
biB0aGF0IGxpc3QsIGl0DQo+ID4gY2Fubm90DQo+ID4gYmUNCj4gPiBhdHRhY2hlZCB0byBieSB0
aGUgUE5QIHNjYW4gaGFuZGxlciBhbmQgYWRkIHRoZSBwbGF0Zm9ybSBydW50aW1lDQo+ID4gdXBk
YXRlDQo+ID4gYW5kIHRlbGVtZXRyeSBkZXZpY2UgSURzIHRvIHRoYXQgbGlzdCB0byBzdGFydCB3
aXRoLg0KPiA+IA0KPiA+IFJlcG9ydGVkLWJ5OiBDaGVuIFl1IDx5dS5jLmNoZW5AaW50ZWwuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWwuai53eXNvY2tp
QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9hY3BpL2FjcGlfcG5wLmMgfCAgIDE0
ICsrKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvYWNwaS9hY3Bp
X3BucC5jDQo+ID4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+IC0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvYWNw
aS9hY3BpX3BucC5jDQo+ID4gKysrIGxpbnV4LXBtL2RyaXZlcnMvYWNwaS9hY3BpX3BucC5jDQo+
ID4gQEAgLTM0OCwxMCArMzQ4LDIyIEBAIHN0YXRpYyBib29sIGFjcGlfcG5wX21hdGNoKGNvbnN0
IGNoYXIgKmkNCj4gPiAgCXJldHVybiBmYWxzZTsNCj4gPiAgfQ0KPiA+ICANCj4gPiArLyoNCj4g
PiArICogSWYgb25lIG9mIHRoZSBkZXZpY2UgSURzIGJlbG93IGlzIHByZXNlbnQgaW4gdGhlIGxp
c3Qgb2YgZGV2aWNlDQo+ID4gSURzIG9mIGENCj4gPiArICogZ2l2ZW4gQUNQSSBkZXZpY2Ugb2Jq
ZWN0LCB0aGUgUE5QIHNjYW4gaGFuZGxlciB3aWxsIG5vdCBhdHRhY2gNCj4gPiB0bw0KPiA+IHRo
YXQNCj4gPiArICogb2JqZWN0LCBiZWNhdXNlIHRoZXJlIGlzIGEgcHJvcGVyIG5vbi1QTlAgZHJp
dmVyIGluIHRoZSBrZXJuZWwNCj4gPiBmb3IgdGhlDQo+ID4gKyAqIGRldmljZSByZXByZXNlbnRl
ZCBieSBpdC4NCj4gPiArICovDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYWNwaV9kZXZpY2Vf
aWQgYWNwaV9ub25wbnBfZGV2aWNlX2lkc1tdID0gew0KPiA+ICsJeyJJTlRDMTA4MCJ9LA0KPiA+
ICsJeyJJTlRDMTA4MSJ9LA0KPiA+ICsJeyIifSwNCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0YXRp
YyBpbnQgYWNwaV9wbnBfYXR0YWNoKHN0cnVjdCBhY3BpX2RldmljZSAqYWRldiwNCj4gPiAgCQkJ
ICAgY29uc3Qgc3RydWN0IGFjcGlfZGV2aWNlX2lkICppZCkNCj4gPiAgew0KPiA+IC0JcmV0dXJu
IDE7DQo+ID4gKwlyZXR1cm4gISFhY3BpX21hdGNoX2RldmljZV9pZHMoYWRldiwgYWNwaV9ub25w
bnBfZGV2aWNlX2lkcyk7DQo+IA0KPiBhY3BpX21hdGNoX2RldmljZV9pZHMoKSByZXR1cm5zIFRy
dWUgaWYgdGhlIGlkIG1hdGNoZXMsIGFuZCBpbiB0aGlzDQo+IGNhc2UsIGFjcGlfcG5wX2F0dGFj
aCgpIHNob3VsZCByZXR1cm4gZmFsc2UsIHJpZ2h0Pw0KPiANCkl0IGlzIF9fYWNwaV9tYXRjaF9k
ZXZpY2UoKSB0aGF0IHJldHVybnMgVHJ1ZSB3aGVuIG1hdGNoZXMsIGFuZA0KYWNwaV9tYXRjaF9k
ZXZpY2VfaWRzKCkgcmV0dXJucyAwIGluIHRoaXMgY2FzZS4NClNvIHRoaXMgaXMgbm90IGEgYnVn
LCBzb3JyeSBmb3IgdGhlIG5vaXNlLg0KDQp0aGFua3MsDQpydWkNCg0KPiB0aGFua3MsDQo+IHJ1
aQ0KPiANCj4gPiAgfQ0KPiA+ICANCj4gPiAgc3RhdGljIHN0cnVjdCBhY3BpX3NjYW5faGFuZGxl
ciBhY3BpX3BucF9oYW5kbGVyID0gew0KPiA+IA0KPiA+IA0KPiA+IA0K
