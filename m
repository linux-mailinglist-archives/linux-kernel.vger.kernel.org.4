Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA0F6CA88C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjC0PEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjC0PEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:04:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29F061B6;
        Mon, 27 Mar 2023 08:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679929458; x=1711465458;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yyDnGuwcnh4FTMRBoKzyuwa2tCyC6DHhGWphMTYswps=;
  b=JejWzaYxUANDmConcdN3hfNddEmAYOhsfB2T6Zfq31MzXL/ZaRTo59Yl
   DS6mk52SuIkxsXw47eRc9VOVoDTuVvvAbVASEAnkDGr8KkzbRKCtGB+2d
   +8cvz+K7h6DvPCbTI6piYyRFAmwRJMJ3L0dt2NRXOdLRWiCLa32IwQw8V
   38XLweO49khWqSod1tJTwuVPlPZQuvJeOxbcHDX5J4kDo1KwPSEbrTzR/
   0OwMIGfPfqsrs8cYkG6MJDqsIhTiL2MwzN8u81b12u/VlVxm92SfBkRQv
   Z8DYzotHstHnFMwc4jrJTBA5hiY1eRBbzrStur/PwkD6IBVki2P6UT83w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="405214457"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="405214457"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 08:03:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="929491747"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="929491747"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 27 Mar 2023 08:03:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 08:03:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 08:03:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 08:03:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 08:03:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBwWXDg7f35tEZp+yZwZTvHNz0P2r8j8hByckT8fqzwS5tSZIUtarCWvcSGXOOcnVgvXhOU/9P7N+mOFu72ys9DEHC2po+nKS7VREoPmZR62oATQzydREaMscqSAWJ006eAAEHoXlk0/+YoHVR/hpdmcXXnW/Uj3a87oLM9wn0oypO8gNH6pGeBqm0MKNTDHXkCnI7GnboGRnimiQCTezfx91h8Qrr+rqYuXkQGHeVKv1P+6A1ExzkAoUet2NqgBx8Bc6KrfGhKmECI6k5k5ijujAcVpF+D1QrHDPtkFY06iZBEro48FTiK5r2EBY6TsmUN6s8eBP/YT4Suo83LOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyDnGuwcnh4FTMRBoKzyuwa2tCyC6DHhGWphMTYswps=;
 b=WOtmFu/NtOTWJCFS74BePJa0hzF7eWRNOQJuWmLFllk9vSn8oAmtsmcLGgA05PNV97s1N4kFyrYd1yIABcJUivrqS8wcmXYZdtHoWp/wMLAdXvVk0Wi5N12uNOev1T3d3Ns5OFAGxmCjteI589xAUPUeZqUCU6tN/XLORvhBbAszWDrAFvP7/ak4m6PCqyqfAT/gB/fWUf9XyK0JXTZuRC6IPvk+PAMuHCIuAYVuxbsGL3kyhqx24lsLxc7xJ4PpzkGySxe030oeQbxzXURQQdPJZ0dG7K4TU87PoXUvYU523IWmAyJVBdkWp/ozEebKjHE2TK0ZYU4/uNvrEjfiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by SJ0PR11MB5631.namprd11.prod.outlook.com (2603:10b6:a03:3ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 15:03:35 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 15:03:35 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] thermal/core: Enforce paired .bind/.unbind callbacks
Thread-Topic: [PATCH 4/5] thermal/core: Enforce paired .bind/.unbind callbacks
Thread-Index: AQHZXh+CyTuWvcuddEyrrhjOft+WQ68J65kAgATSvwA=
Date:   Mon, 27 Mar 2023 15:03:35 +0000
Message-ID: <06389d876e4513b6f5e677fecac99a23e42ee946.camel@intel.com>
References: <20230324070807.6342-1-rui.zhang@intel.com>
         <20230324070807.6342-4-rui.zhang@intel.com>
         <CAJZ5v0gXfHQmRGEiHsZRXxTB+=dTLca9fbyQA299gL49ysF6rg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gXfHQmRGEiHsZRXxTB+=dTLca9fbyQA299gL49ysF6rg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|SJ0PR11MB5631:EE_
x-ms-office365-filtering-correlation-id: dd30a177-a23c-4304-bbcf-08db2ed4702e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bc4AhRHEkUcNNx5/CWu7f0vouHM7amlXU5/1x4SabmPzDgmAQ8KIyzqVw63nF3wG4brCwMmuiJoWWtSLtjxRLm0R91H+VAo4mtwqiS1z7gH844ZnrZQgwEBUt3ZptmDUX6VJ968qvy0azAKdTh3J/GdeQvLss7MJDkxoNSANoI2axW5V2AVPwL5myD6KaH8Vs52BjCbUqlTKTHtpbbKtvcRhjs/0SXJnorKUabw72x3pY0ng1BZJ8tuH6zEam4nLt0yXWtf/IMmXiAfosY5Lfx2hz8VMgLGDQDWnHgwqiayIU1XNrGqdnxjP/oEej5EcSfsOoZRYJg2FIOhowGsw30oKa4xJ/l/9gPMjNrUSN3p8lLypRX9XIaTZq4xSPnjPsQwyqXkE/K6gKHbdXVh3s7DOAiMA6mhPAuGxzR91w47I/UifaSEvq60PkYd100DqIKUSh48oS0C+0H08LmIV2qsLGvzloKLsVxDpILXc6piTLxsSWPgwvRsCA10c+K2Ol1cS9PmJbso9ieOZ9HY3ECwcL8xpjVT9ujJVBWRlLE8blVsls65tBNRcEgGhhkwCKXcHv0FZ6+Ud0Moesttl/QunQPlW5ahZGnWFjQUZkGg7k9F3Nidw0A/GnGvhmpYWGn7g30J/wDJ8iItTkT/ynaD3AIbzkCCXzxPgIK7HVkQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(71200400001)(54906003)(38070700005)(478600001)(86362001)(316002)(6486002)(66899021)(53546011)(6506007)(6512007)(26005)(91956017)(38100700002)(186003)(66946007)(66476007)(76116006)(2616005)(64756008)(66556008)(122000001)(66446008)(6916009)(8676002)(4326008)(82960400001)(41300700001)(8936002)(5660300002)(36756003)(2906002)(83380400001)(142923001)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGplVC82S1FWMnN4YjhxS25XQis2dmM4c3FCWlE0WjFnNHA5N3k1TmpIdHZa?=
 =?utf-8?B?UnZ4V1R2RnJyZW12bnFKRXp0ckVDWnVTdDU3RzJCSnpkNGd5M3dIQnNFdlEw?=
 =?utf-8?B?UnUzZnpaRnJ3UXhIdTU5dS9MNFZ0TjhvN1Z5VnU5MnlCczA5SWZXTUZWaDhh?=
 =?utf-8?B?dkpsV1h3N3pBc1NrOGpyd2Rpc1hvc3VsU1RIelNhNE5XSytrdko1Ykx6d0dB?=
 =?utf-8?B?UEtJaFYxRzhJTzRiRXBKbjM1REJvQjJ6dlZ3UzZZaHVpSjFHdFN1T0tBTFFr?=
 =?utf-8?B?K0ZHQUVEQjF4MXk1bkpRY0hDaHorbXdPeTJDL1g2R1piWEk3ZWYzK3d3NjBp?=
 =?utf-8?B?aURhc2N0N3FMV3JDN3p2SUJLbk1zc2RramQ0ZlIzaW1ZREI1MzFueUxQUUZo?=
 =?utf-8?B?SGZES3lWRTdxTVZkQnBSa04xQWM0WWtQL2tYajVHRmhpMFJLSDAyMFc2blgx?=
 =?utf-8?B?ZEc1OGRoWGRsTEYzSHFzRWdjNzdYeUlmVWxXazVSdnQyZkF5SGRTbnEwWGN4?=
 =?utf-8?B?andSSnFBWjBzY2gvRGFqUTQvK0w5bmVwUlc3S0Z5YndnNS8vS2NnU0QzRjdP?=
 =?utf-8?B?c29zUDJONXEvUEtnZVZxYWVzZ1BvdjFWUFJ3SG5pd1hjVlJ6QkpPNDJKUTJW?=
 =?utf-8?B?dkk3N1V5NEFNUXlITEpxNGdTdllSaEhQQXdwNVRzOExnTitNZTB3V1VBVHVF?=
 =?utf-8?B?MzlmamxMY1lVOUt3Q3V0Si9Dcm9BT1l6TWFFeURYeXFQVmxxSVVVNG1relhK?=
 =?utf-8?B?ZkNrOE1VdUJMNFVzR2NJREFLemc4eXJYZHFyQWUrZGh6NndYUmd6Z3liYlVp?=
 =?utf-8?B?R05jb3FSeGNld2FtcWQvYklIVWRNMlJKM2VEWTFVODNWdEVpNG9IUTI0cFNj?=
 =?utf-8?B?bFg2Mi9OUFEyU0o2cGM4Mm5wcStxZ3RlUVlhOVM1SDdUdjU0VzJQcVdxbnZW?=
 =?utf-8?B?NUFSUmJzUHZYbzRyQ3Z2anZBQ2ZlN21pZ09iSkxjdjlDYnVrTFhiNVVhNU81?=
 =?utf-8?B?dVFVL3Z1cEhUTjZlVFdxblE4MWVoT2JhMXhMaDlmWHFXdGNINkh6UnNzZGJK?=
 =?utf-8?B?RVYwc0J0Mll6NnRJa09BUTYxQ2NYeG16Z0hUMWxKZU5jNStBbVlHRnNudmFC?=
 =?utf-8?B?azdaTFNTZWVsMTdsVGVVUCt1VVlWSGRuL05XTEFQREoram02Y0RUTmZVeXVU?=
 =?utf-8?B?WVdENVFFMnBoZTNsdmdBTGRrRlVxbms0NERHVndiYXB0S08rM0ZLQmlWdWhV?=
 =?utf-8?B?bnM3Sm5oSXlDWm5WdlNFZTloSm5US0dYbVVOcnR1NWZSR2p4YWRhT0JsUEpp?=
 =?utf-8?B?Z1JtWVovY2w3Yzl0TklYSkpHek1lNFJsaHdzVUgyOG1Hd3hxbFRwQkhzMEtP?=
 =?utf-8?B?N3FaQThwQ3d0RTNETHhkMGhLOGs1c2VBRlVXRWFaV2FlRFZUbUI2eXovWGJr?=
 =?utf-8?B?THoxTVIrWkJxT3BpQ1FHdisvS1pVdHRqUE9pMmh2WXZ4aUpoazBWRm5FS1lY?=
 =?utf-8?B?ZHo5VTdkdFJyNVp4ZmZvWTdSNWV5UkRtVDEyTEljVUNSa1BmNEozaUNFdkcr?=
 =?utf-8?B?MGY5aDdPbE5NQS9uSS9DRVZsRnlFZ0t5aTJncWQ2SlBjRHl2STB4c2JRZTdv?=
 =?utf-8?B?d3RjYkVDbGgxVTk0anZVR3BFVDVSWkprQ0pKeGlJQy84ckNMQXlGSlVjbTJj?=
 =?utf-8?B?cHBnZkhoL0h0eDd0d0xUK3k3K2hqYUIySklEV3daQTI4bHd5VkVHdStRSHow?=
 =?utf-8?B?VzRzeUIyZ1dwTWxucklIWFNab21VdlRmRE5xZVFKdVJJb2V3QmZsc3U0NGU4?=
 =?utf-8?B?WFd5OVY4SVN5MmYxNC90eFFIVnBXSktvOHJ6Zkw2UDhuYTd5YXZvdERGcHN2?=
 =?utf-8?B?dE1ua1dMMVBRNW8rSVZVQ0tOMmphSmw5MEM5a21JTWZFTWlEQmZmbGJkVkdu?=
 =?utf-8?B?V0xhUzZUZStqV01tVW9BMWk5VG12WDNOaVhxTGtwZXpiVTNHMEpmeXp2MzJ4?=
 =?utf-8?B?Wmc5RmlScG5LVUR2OUZNQkFpc0ltN09pSFgwbEVCK1F1TE5qYTE2dE1GQlE3?=
 =?utf-8?B?Y2pqOWhsWW5WSTZhRS9NbVNNMHFzeEVJS2V4ZURKNUdWWlV4NVJYMlMxeXFw?=
 =?utf-8?B?N050cTlpSHptUjArMGpVL1JCcGVNY1NDT1ZmWGZrOFo2dnF4NzZ5eUs4RlVW?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <984F06080151AF4C994F35F8DC250EA6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd30a177-a23c-4304-bbcf-08db2ed4702e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 15:03:35.2643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x9QykR9/L2KMgJ3R69xr4vXhETSXESejFRk0atcStpQ88i02NzlDLR6ebg+rxO+Y4cKqalp3gb9/Id1GwsXsVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5631
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAzLTI0IGF0IDE0OjI0ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgODowOOKAr0FNIFpoYW5nIFJ1aSA8cnVpLnpo
YW5nQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4gVGhlIC5iaW5kLy51bmJpbmQgY2FsbGJhY2tz
IGFyZSBkZXNpZ25lZCB0byBhbGxvdyB0aGUgdGhlcm1hbCB6b25lDQo+ID4gZGV2aWNlIHRvIGJp
bmQgdG8vdW5iaW5kIGZyb20gYSBtYXRjaGVkIGNvb2xpbmcgZGV2aWNlLCB3aXRoDQo+ID4gdGhl
cm1hbA0KPiA+IGluc3RhbmNlcyBjcmVhdGVkL2RlbGV0ZWQuDQo+ID4gDQo+ID4gSW4gdGhpcyBz
ZW5zZSwgLmJpbmQvLnVuYmluZCBjYWxsYmFja3MgbXVzdCBleGlzdCBpbiBwYWlycy4NCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYyB8IDUgKysrKysNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMNCj4gPiBiL2RyaXZlcnMvdGhlcm1hbC90aGVy
bWFsX2NvcmUuYw0KPiA+IGluZGV4IDUyMjVkNjVmYjBlMC4uOWM0NDdmMjJjYjM5IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYw0KPiA+IEBAIC0xMjU4LDYgKzEyNTgsMTEgQEANCj4g
PiB0aGVybWFsX3pvbmVfZGV2aWNlX3JlZ2lzdGVyX3dpdGhfdHJpcHMoY29uc3QgY2hhciAqdHlw
ZSwgc3RydWN0DQo+ID4gdGhlcm1hbF90cmlwICp0DQo+ID4gICAgICAgICBpZiAobnVtX3RyaXBz
ID4gMCAmJiAoIW9wcy0+Z2V0X3RyaXBfdHlwZSB8fCAhb3BzLQ0KPiA+ID5nZXRfdHJpcF90ZW1w
KSAmJiAhdHJpcHMpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FSU5WQUwp
Ow0KPiA+IA0KPiA+ICsgICAgICAgaWYgKChvcHMtPmJpbmQgJiYgIW9wcy0+dW5iaW5kKSB8fCAo
IW9wcy0+YmluZCAmJiBvcHMtDQo+ID4gPnVuYmluZCkpIHsNCj4gDQo+IFRoaXMgY2FuIGJlIHdy
aXR0ZW4gYXMNCj4gDQo+ICAgICAgICAgaWYgKCEhb3BzLT5iaW5kICE9ICEhb3BzLT51bmJpbmQp
IHsNCj4gDQo+ID4gKyAgICAgICAgICAgICAgIHByX2VycigiVGhlcm1hbCB6b25lIGRldmljZSAu
YmluZC8udW5iaW5kIG5vdA0KPiA+IHBhaXJlZFxuIik7DQo+IA0KPiBBbmQgc3VyZWx5IG5vbmUg
b2YgdGhlIGV4aXN0aW5nIGRyaXZlcnMgZG8gdGhhdD8gIEJlY2F1c2UgaXQgd291bGQgYmUNCj4g
YSBmdW5jdGlvbmFsIHJlZ3Jlc3Npb24gaWYgdGhleSBkaWQuDQoNClllYWgsIEkgZGlkIGEgY2hl
Y2sgYW5kIGFsbCBkcml2ZXJzIHByb3ZpZGUgLmJpbmQvLnVuYmluZCBjYWxsYmFja3MgaW4NCnBh
aXJzLg0KDQpIaSwgRGFuaWVsLA0KSSBrbm93IHlvdSdyZSBkZWFsaW5nIHdpdGggdmFyaW91cyBv
ZiB0aGVybWFsIGRyaXZlcnMgcmVjZW50bHksIGFyZSB5b3UNCmF3YXJlIG9mIGFueSBleGNlcHRp
b25zPw0KDQp0aGFua3MsDQpydWkNCg==
