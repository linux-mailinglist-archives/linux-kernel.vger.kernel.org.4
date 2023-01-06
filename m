Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4579465FCB0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 09:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjAFIZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 03:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjAFIZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 03:25:38 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383AF78EBD;
        Fri,  6 Jan 2023 00:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672993537; x=1704529537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MR9hyE4hIOlfTS9kSsRwe0tQtTg+HFuV8U61wcS0BS8=;
  b=aTGgTWyhpj/wlP7YF7543K9tgE+fLsT/Mg51EZYmTVET5m73N5iFODij
   7/ZGVncmLrcYrrPGReA4T8CfCTbZd0zPIy9D1xKsow9Ag/+bv7/Xy3A8Z
   h/53Un2O+MqJC59cnhLCTDuR1cnLD1uN5nd9hIBOQjryeeGOWM4ZOxZom
   qC2wTr+zAkKuG9NUFxB7A2Idk3zgtqk5quWTanzXJfc7ud07HFUBVg77V
   VOJhhXPMkAhLUdfjPZAVVMMUEdU2RpHQ3/sf9VT56fG7HGxBq0zyaUyue
   WAxhAI2drPHwCcXjeDWZX5dziKtzB5jJetaNERWdhXMJj18Zbw0y3Wky3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="302798087"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="302798087"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 00:25:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="901223213"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="901223213"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jan 2023 00:25:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 00:25:35 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 00:25:35 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 6 Jan 2023 00:25:35 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 6 Jan 2023 00:25:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U27HFx0gKwr4AZAEd59SgFv31N/u0nPD8vvEa9Q84g8DuqXnlNtnBETZGhYygsvC6FhK7fHw+wcrBIuphSspS6l1npegF9b1fqaHh7TBKcANelTKaG4dUQa5qwXSaGj/Fwy0CoyvvYTFpG17SgnqlY7TDoraAoeAErycc71O6RjW2wJ20Os49NLN+W3nOcp+d5lLz2Y4clxkjOhSWUFHwrzl5LlIHVcQIoLOSoJVbF4BomZUUexS5LGJHqO8lyM7q0cKd/LvIZ5aoNQq5uQw2nGAA+Jt13BRKDWZWhy05aAUFLt8jaO0I13WPC+DXFscF0pJpR708dZdSdSkgerbcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MR9hyE4hIOlfTS9kSsRwe0tQtTg+HFuV8U61wcS0BS8=;
 b=BRbK3OsHv2s+SU5R6QoXA1B7CsmrS+dTiJelYLsYFu9OPttAGSnODjfqOEqZzn8tJzjQPYVzpw2tHPzEfYgVnHXFkXCSPj76y5A1b+1Xg/QiadiSeSUtx+8qW8S9tjmEojHeCIPLZL+NygeT+4HLMxurhMVLFabcAj9yrvk6j1l7LGjPSxB2IhpVMjchYHP0tRC24mqkDz6pKMgExNljNykv8gcR7GcaKwW+FKQXgPQbclQ2bmgJnJ0t/XzimN8YIgCmZQgDZ+EwAE7qv8tv+HAskOrosnIQW4cnOBLhPiLY/KFH4s2kMrQecxK3tVMhHU+TzARP24YKf7mEHR/lDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DS0PR11MB7263.namprd11.prod.outlook.com (2603:10b6:8:13f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 08:25:27 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%6]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 08:25:27 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] Thermal ACPI APIs for generic trip points
Thread-Topic: [PATCH v3 0/3] Thermal ACPI APIs for generic trip points
Thread-Index: AQHZIIrtE0wsORY450Wg9lBwVETFZK6RD8SA
Date:   Fri, 6 Jan 2023 08:25:27 +0000
Message-ID: <cef493c6d918565d1b8c16aedadf5a19edd48b48.camel@intel.com>
References: <20230104222127.2364396-1-daniel.lezcano@kernel.org>
In-Reply-To: <20230104222127.2364396-1-daniel.lezcano@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DS0PR11MB7263:EE_
x-ms-office365-filtering-correlation-id: a2ddc6df-6b94-4232-cb94-08daefbf90cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: peR4Pc9R2FoEQo/dW3H0v5sScp3sMW0XDgyKh89majctiI61N8usAH8fFVKnB/sNLgdzI7ttMcC/MfFg6/Q2axR8JG/rCQcYBjnhrWiiKK+JXf8EHDhUf8Ha7hlzT0ReJtdaTkg/cSn9v++0uSRerxYxOqcwEg0P2HBIV6e7I9yOdC5YxN0dCq6FVAGk0bbem2leQgNeozCLa+IJYtmAjafl/pJvpj+09GwKvHNOjsJRBPr3qEOfxPIMd0buFsxsckKvrggHbkcXYwrHSUAsePDM/OOV+oCjOwt1faDDTsK4cQ3KHsHYbejY3pI28+6tnqKTa17szqWYHuXk8FzUCuccvbUyyFmt36zADKZjjOW9nvP1orkzTgXU5qV8mWg3h4qejbSQ8MnoqtNCYn63yhfYcarncHHZeRjC/Fe0TO2nLey87mYAtva2DsuWfHG7Stb/d/scdUqO+Gy01LtkPSfcsXHIIbOemeVtvw3uDVFiW+FKh70qcIc4AhsiTHNNYpyLRbI98LxrI59APBa8fii6DYfFvAcSpQ7WLOOX4+BjXRyH/WkbLfFcU8GYSGumEhawfZsTB2FjgeBTBdEwBQyjNrRbwDCfQ9zr0oSkaLkmcwbw7juy/XzzJByUSPoNzNGHVYqFXVLR7cDsXm0PK+03XzS23sGKUdJnMZqDi39T8XJvedxPAe1q2A2IJ1ceEmiokQf55ZhuULwXyCXsC9h/HcJAwaJsq4wjlwtIdZg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(41300700001)(4326008)(5660300002)(76116006)(91956017)(8936002)(66946007)(66556008)(54906003)(8676002)(110136005)(2906002)(66446008)(6486002)(6506007)(71200400001)(316002)(66476007)(478600001)(64756008)(86362001)(2616005)(186003)(6512007)(26005)(83380400001)(122000001)(36756003)(38070700005)(82960400001)(38100700002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGlualdrVGhzS2N0WmRDajlLdzZUSGNoN0dkMUJhUEdPaHBGMys5VHMwSGc3?=
 =?utf-8?B?SStsZklBM0Fyb2NObjJuTHRXMFJFdkxFelY5UnNxbTZZZ200dThGUEtlK3RS?=
 =?utf-8?B?N0VZcEFHcXVPYTlCZCt6SjlPc25PaEpDMDVyT2VXTzdLaFBjNElBQnUrWWhV?=
 =?utf-8?B?ZHdnZCtsTHhTdDZwbWI2NTl4a0VMdkxsRG9MekxJYzd0ZGRYc25NZHEyNHZV?=
 =?utf-8?B?Y2Z4TE1ISTlDYTFNY1RIaFNBVnROWVlDMmJ1V0ZqOGJ1THJQdldKMGZ0K3o3?=
 =?utf-8?B?TFR3czRWaTlQaGdwV01PVHNWY2pBV1lDbjhXNGM4VUQ5OE1yMnhObGJlbEVZ?=
 =?utf-8?B?Y3pyUHZkaiszN1lIZjhkSXNIaW1LakhhVUEvWGpoeE1POHlaSDJWdjkwakhO?=
 =?utf-8?B?UjRGdXNtTlhtYTBNSmhxMjhoSkRRMWhOa0R6bThsTUM1Y1ZCS25oUDl3dnJL?=
 =?utf-8?B?SGpRdnhjdmJxN3dkdU1nTUNTV1h4UW5zT0JaajJTSFM1N3dzSjNSRUJJZjJG?=
 =?utf-8?B?VWtZL1hhdWdTelNMRll2TTd1d0QrT2w5MlRDQkdGVlRMUWFXUWlycml4eXJQ?=
 =?utf-8?B?amRQTVVTOGZMMkQxcmJJWmpiSGFSV3FvRHB5L2JmZWE4VmRFWWFKK3U2YnRr?=
 =?utf-8?B?aloxcXR2MFpGbWhoSTErTGkrd3M2Qnl4SlhWWTdCMWNxOEdad2dMVUFydlpn?=
 =?utf-8?B?RmRRSU5xWUNTQzNyNEVaZDJ3ekJmUHhscmkvRm1JUGFRNENaVnZudVJBQkJV?=
 =?utf-8?B?aE5NakZnUWRIWHk2aExJenNkZGR4d0hRLytoZkt5M1RPb1hGUlZESm5Zd3di?=
 =?utf-8?B?OEhDTjJBSnZ0M3kweUFuaEVQZWRSWENtdTRoSUFZQkVSQWVvV29DbE5DSTlC?=
 =?utf-8?B?eUluRzFJcUhOeHhtLzV3ZDJpOFZPcWxuRm93UDJ3dmpyQnE5ZmtMcDY4NWRF?=
 =?utf-8?B?VTFSWkt2VUZkK1lhd21XR2c5a2lBOHdBNCtZUWJKcm1QeEh1bkFJeDdNSldl?=
 =?utf-8?B?UDZhVmRLd1BUZm51VEVFaTdWcSs0U0Q2VmpsMHlzQ21rb3YzY21ITndzNU9G?=
 =?utf-8?B?cDFaQWRFODR6VlJFdGtvYzZ3ZXU1K1hSOFFOYVpBc1VRN0ZVNEc4QzNvek9D?=
 =?utf-8?B?UlRoK2k3Vm9kdzRrMVVKS0huRWxDYnBFcFR0djJRZmNDczEwTnp0aE1WMkJk?=
 =?utf-8?B?NEZIOS9NWlpFeFhkNWk0ZjljYUdPd1hkbldXaVRTckdmT1FzeEpIaUhLMGll?=
 =?utf-8?B?VExHdFhETmVlRHc3R0x0OUtDaW5VVkw2Uk5EOSs1aEI1ekFiODcxUitxV0N5?=
 =?utf-8?B?eFpGR1Jib2ZLWW9XV0lKOUsra1JNU21TZXhRanAwRGJsb1BXZFkvaEJ2RFFm?=
 =?utf-8?B?ZXBSb0E1Zmt3QXovSXcvSnpWQ2ZpdzNrK0lCYXhOYk1ROWZXNzJ0akxNcm1N?=
 =?utf-8?B?U0RSL2ZYVCs3OW5QR3JXeW00LzJ5OERKS05WSkMzVXAvV2lUcDVrL0hsZFBp?=
 =?utf-8?B?dlZqNnFjZlhkM0ZBcnM1cFhmUWpiV0t1MDBQMWZnZUtTRG05aFJhVG5nU2xI?=
 =?utf-8?B?ZE9DYzFmcy8wLzZxRDgweFk3RzBqdjIwbnJYeWpkMnk3RmhGeUVNU2U4L2Ey?=
 =?utf-8?B?V2lXR2ZTZ2tEVC9KaUlDUXJqYWszckE4L1dUUkN5NGJzbXJ2YnNOSmJVd2F1?=
 =?utf-8?B?UncxWXdnZFFBalhVUkpRVVdRQkwvTXZvZy9pUlZCTE15WTRtZDNqbXkzaW1r?=
 =?utf-8?B?Sk1Menp5WlpsczV3TDR4UGtyZ0pEWkk2bU1PdTZxZXlTOXk0OHJaRUR0aU9Z?=
 =?utf-8?B?SmMyNjIwcW1hbmEycitwODgxSjZlaDhiQlR6a2hxRjk5V1lwWFl6ckJhLzZ4?=
 =?utf-8?B?bThGL0ovVHpnTThlTFFISXV5dXR0K0w3ZVZ0NUNXR21YSDBjc1BKakxOaE1E?=
 =?utf-8?B?ZmNzVEdZZ1krb2gvUCtrTGpjT1l4aGl1UVZsM2FwTDVDUWRVWXlNZ0NtVURq?=
 =?utf-8?B?ZkdQQVJkb1ZQZ1hySGJ1SEJzd1ZpR2E3aHRFTklJZXFraDVDQXZrTTBwT0Mv?=
 =?utf-8?B?YTZhWGF5N2NxZWtvYVpmVGtYdnlWdDJya3M4cEd2VDJQMGlzRHFHRllIWWpm?=
 =?utf-8?B?YnloTSt3ZjZUbUxVM21aa0FhdnZZRGU1OEtFcnltbHZVd1owRGlhWmx6UEZS?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F4F52E54CED304CA6601B79E9FE1309@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ddc6df-6b94-4232-cb94-08daefbf90cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 08:25:27.3257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wCgxwGIwF+y7k5BCLL1pWj+BkZ+977/IALnM7uFxHN3UYriIB4F3rQeEPi56YhvU9k4eREyOgGKBWnRnwwb/8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7263
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksICBEYW5pZWwsDQoNCk9uIFdlZCwgMjAyMy0wMS0wNCBhdCAyMzoyMSArMDEwMCwgRGFuaWVs
IExlemNhbm8gd3JvdGU6DQo+IFJlY2VudGx5IHNlbnQgYXMgYSBSRkMsIHRoZSB0aGVybWFsIEFD
UEkgZm9yIGdlbmVyaWMgdHJpcCBwb2ludHMgaXMgYQ0KPiBzZXQgb2YNCj4gZnVuY3Rpb25zIHRv
IGZpbGwgdGhlIGdlbmVyaWMgdHJpcCBwb2ludHMgc3RydWN0dXJlIHdoaWNoIHdpbGwgYmVjb21l
DQo+IHRoZQ0KPiBzdGFuZGFyZCBzdHJ1Y3R1cmUgZm9yIHRoZSB0aGVybWFsIGZyYW1ld29yayBh
bmQgaXRzIHVzZXJzLg0KPiANCj4gRGlmZmVyZW50IEludGVsIGRyaXZlcnMgYW5kIHRoZSBBQ1BJ
IHRoZXJtYWwgZHJpdmVyIGFyZSB1c2luZyB0aGUNCj4gQUNQSSB0YWJsZXMgdG8NCj4gZ2V0IHRo
ZSB0aGVybWFsIHpvbmUgaW5mb3JtYXRpb24uIEFzIHRob3NlIGFyZSBnZXR0aW5nIHRoZSBzYW1l
DQo+IGluZm9ybWF0aW9uLA0KPiBwcm92aWRpbmcgdGhpcyBzZXQgb2YgQUNQSSBmdW5jdGlvbiB3
aXRoIHRoZSBnZW5lcmljIHRyaXAgcG9pbnRzIHdpbGwNCj4gY29uc29saWRhdGUgdGhlIGNvZGUu
DQoNCk15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGUgQUNQSSB0aGVybWFsIGRyaXZlcg0KKGRy
aXZlcnMvYWNwaS90aGVybWFsLmMpIHNob3VsZCBiZSBvbmUgb2YgdGhlIHRvcCB1c2VycyBvZiB0
aGVzZSBBUElzLg0KDQpJcyB0aGVyZSBhbnkgc3BlY2lmaWMgcmVhc29uIHRoYXQgaXQgaXMgbm90
IGluY2x1ZGVkIGluIHRoaXMgcGF0Y2gNCnNlcmllcz8gb3IgaXMgaXQganVzdCB0aGF0IHlvdSBk
b24ndCBoYXZlIEFDUEkgdGhlcm1hbCBkcml2ZXIgcnVubmluZw0Kb24geW91ciB0ZXN0IHBsYXRm
b3JtPw0KDQp0aGFua3MsDQpydWkNCg0KPiBBbHNvLCB0aGUgSW50ZWwgUENIIGFuZCB0aGUgSW50
ZWwgMzR4eCBkcml2ZXJzIGFyZSBjb252ZXJ0ZWQgdG8gdXNlDQo+IHRoZSBnZW5lcmljDQo+IHRy
aXAgcG9pbnRzIHJlbHlpbmcgb24gdGhlIEFDUEkgZ2VuZXJpYyB0cmlwIHBvaW50IHBhcnNpbmcg
ZnVuY3Rpb25zLg0KPiANCj4gVGhlc2UgY2hhbmdlcyBoYXZlIGJlZW4gdGVzdGVkIG9uIGEgVGhp
bmtwYWQgTGVub3ZvIHgyODAgd2l0aCB0aGUgUENIDQo+IGFuZA0KPiBJTlQzNHh4IGRyaXZlcnMu
IE5vIHJlZ3Jlc3Npb24gaGF2ZSBiZWVuIG9ic2VydmVkLCB0aGUgdHJpcCBwb2ludHMNCj4gcmVt
YWluIHRoZQ0KPiBzYW1lIGZvciB3aGF0IGlzIGRlc2NyaWJlZCBvbiB0aGlzIHN5c3RlbS4NCj4g
DQo+IENoYW5nZWxvZzoNCj4gDQo+ICAtIFYzOg0KPiAgICAtIFRvb2sgaW50byBhY2NvdW50IFJh
ZmFlbCdzIGNvbW1lbnRzDQo+ICAgIC0gVXNlZCBhIHNpbGVuY2Ugb3B0aW9uIFRIRVJNQUxfQUNQ
SSBpbiBvcmRlciB0byBzdGF5IGNvbnNpc3RlbnQNCj4gICAgICB3aXRoIFRIRVJNQUxfT0YuIEl0
IGlzIHVwIHRvIHRoZSBBUEkgdXNlciB0byBzZWxlY3QgdGhlIG9wdGlvbi4NCj4gDQo+ICAtIFYy
Og0KPiAgICAtIEZpeCB0aGUgdGhlcm1hbCBBQ1BJIHBhdGNoIHdoZXJlIHRoZSB0aGVybWFsX2Fj
cGkuYyB3YXMgbm90DQo+IGluY2x1ZGVkIGluDQo+ICAgICAgdGhlIHNlcmllcw0KPiAgICAtIFBy
b3ZpZGUgYSBjb3VwbGUgb2YgdXNlcnMgb2YgdGhpcyBBUEkgd2hpY2ggY291bGQgaGF2ZSBiZWVu
DQo+IHRlc3RlZCBvbiBhDQo+ICAgICAgcmVhbCBzeXN0ZW0NCj4gDQo+IERhbmllbCBMZXpjYW5v
ICgzKToNCj4gICB0aGVybWFsL2FjcGk6IEFkZCBBQ1BJIHRyaXAgcG9pbnQgcm91dGluZXMNCj4g
ICB0aGVybWFsL2RyaXZlcnMvaW50ZWw6IFVzZSBnZW5lcmljIHRyaXAgcG9pbnRzIGZvciBpbnRl
bF9wY2gNCj4gICB0aGVybWFsL2RyaXZlcnMvaW50ZWw6IFVzZSBnZW5lcmljIHRyaXAgcG9pbnRz
IGludDM0MHgNCj4gDQo+ICBkcml2ZXJzL3RoZXJtYWwvS2NvbmZpZyAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDQgKw0KPiAgZHJpdmVycy90aGVybWFsL01ha2VmaWxlICAgICAgICAgICAgICAg
ICAgICAgIHwgICAxICsNCj4gIGRyaXZlcnMvdGhlcm1hbC9pbnRlbC9LY29uZmlnICAgICAgICAg
ICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90aGVybWFs
L0tjb25maWcgfCAgIDEgKw0KPiAgLi4uL2ludDM0MHhfdGhlcm1hbC9pbnQzNDB4X3RoZXJtYWxf
em9uZS5jICAgIHwgMTc3ICsrKystLS0tLS0tLS0tDQo+ICAuLi4vaW50MzQweF90aGVybWFsL2lu
dDM0MHhfdGhlcm1hbF96b25lLmggICAgfCAgMTAgKy0NCj4gIGRyaXZlcnMvdGhlcm1hbC9pbnRl
bC9pbnRlbF9wY2hfdGhlcm1hbC5jICAgICB8ICA4OCArKy0tLS0tDQo+ICBkcml2ZXJzL3RoZXJt
YWwvdGhlcm1hbF9hY3BpLmMgICAgICAgICAgICAgICAgfCAyMTgNCj4gKysrKysrKysrKysrKysr
KysrDQo+ICBpbmNsdWRlL2xpbnV4L3RoZXJtYWwuaCAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDggKw0KPiAgOSBmaWxlcyBjaGFuZ2VkLCAyOTQgaW5zZXJ0aW9ucygrKSwgMjE0IGRlbGV0aW9u
cygtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdGhlcm1hbC90aGVybWFsX2FjcGku
Yw0KPiANCg==
