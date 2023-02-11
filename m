Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78F9692DD3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 04:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjBKDV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 22:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjBKDVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 22:21:48 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D124BDF1;
        Fri, 10 Feb 2023 19:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676085679; x=1707621679;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=N84OoedRSiwhUGAXTuCEGJiel6HADw89bHyy4nXznkg=;
  b=aaKHMG+eXW9Urp6crJSeUN/WRZbVs7rsX+cWNUaSpwPrIOk19D7c784Q
   F0pxm7vXKSZvIHeV5Sh4MMn9Kgb2NYk8mnCWFB1Nus/kyFNM8aiLBhJxm
   HzoIBP35WXt/SLQYqTcxZ869IGn2m23Si1qQW4SWKXhNpbIey710XcNGQ
   6wFjFr70OlaaHcj7xf4f51R3BZxn9PSb1lrU574XyiuPCWaBdvEkynaKU
   kQQdPCzekrTVSJGxZFD7Oej4+yDk44AL/wXws5yDgNW1CeQRFTEOLXJWH
   0bF2TzqMh6xakTyw31gQSq9Bup8ivJsLa2FFmjAxJU6+OFkdgAAYTSTP8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="328273554"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="328273554"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 19:20:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="670211449"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="670211449"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 10 Feb 2023 19:20:15 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 19:20:14 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 19:20:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 19:20:14 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 19:20:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ini2pORv/Y6Yo9ky3EV8yAbewpFe953KyYVC7TVP/4w9uqsJfpPDQ8JLcLw451zRubGJQvDvOYU1VuJDkAXvX+yesfisRvlqsIku1vOFaBWBtyCzkfs64/Qf7bf3XEtxXZqlshvHs1LwlSNfNfE3aDX2wDJUnkJ64/VO2/LVqGAJDg3A/HWR1iXdfDWvPJPV3qbph5PWVTvJf5bNJJBFWh3mhtHAhtFd0cee3aaeL2h6dj714xMF/SiWCBbWl8pHmdOkkcfdhOsiyozEzVrkOiy516Zr3/jLZ0GYZbqhExEWTbO3u8vLpYXGTAkU23lXhpz+Nqzc1oMX9xUigTq6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N84OoedRSiwhUGAXTuCEGJiel6HADw89bHyy4nXznkg=;
 b=WIgfitDfmDwvmMSXQ+jiXjbKpXDfT5n8/+BL+YYKaZw37/5/z46g7kijDIKEqWI48hrjIRj6FSzJPwVHap6vgiUTxfksNhC9QIihFG9sKYhSsj1SBlkC/KmbQX5eWp+PANW4h4/pp8tMGB+iRNaXObaxnkwvrH7EW5CA04BNbDceLuMpX5YUZhm4EU0jMjS8w3bBOOeXGKCMst0OOs2dZlkoOQd7nMlh3qdXnYUU47Vlg77F0fM0JGwgDieasiB6u+Eh3yZIF0BFNw7ctnJJpeHBg8/DYdMOYkqwT3CLlfeuJlCmrtTkG54Ze4n6iVYoGF5V2g1/GUNE/TcxuD46VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CO1PR11MB4962.namprd11.prod.outlook.com (2603:10b6:303:99::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Sat, 11 Feb
 2023 03:20:12 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837%8]) with mapi id 15.20.6086.019; Sat, 11 Feb 2023
 03:20:12 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powercap/intel_rapl: Fix handling for large time window
Thread-Topic: [PATCH] powercap/intel_rapl: Fix handling for large time window
Thread-Index: AQHZNqVBQ2trYfwp1E+Hy1nOxzLWsK7G5HoAgAI9uQA=
Date:   Sat, 11 Feb 2023 03:20:11 +0000
Message-ID: <f11965a6908c4db51ee5b8b70404c12ecd28c3ea.camel@intel.com>
References: <20230202013140.30416-1-rui.zhang@intel.com>
         <CAJZ5v0gtCffDTVi-SoQ0KanPiSZUS3gONX7a-ZHAXQRr97H-EA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gtCffDTVi-SoQ0KanPiSZUS3gONX7a-ZHAXQRr97H-EA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CO1PR11MB4962:EE_
x-ms-office365-filtering-correlation-id: c40e0e25-1a6f-47a4-413e-08db0bdee2db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5dQvXWHdGwK/c6oPcsBTrpnqEFDSEoNVxP8hzEeeu7qBHkbQQE7xC4HAnGsG5D9/us54jPgicxYLUby58ajQoj64xbIHLrDKKqjDXgGhM7cxnTORscJLfXFYBUMa/p+nurI4M2RVA4jB636gW3ZdWiLMkFYYPat8c3EGoozdMF8hiAQ+rqGV2LkJALB1cymRVmlCqubDqzR3hcxVIHlCIDf0ONhK/24bzYvsJA/jnMgW9Yi3jq5k7URMNy4sOAAwh4DEXIYppL//SKd2yOToL/ABCKWOmUPpBDW1Tmgw/bFqAPCfWQsPXniVXUMT0+wCF+ep1MCQl73yImqV6SWDkJPcYz+CpOu90kdC+ti2+03ITaeDTrcsJ9jGQsx2Iz3Ci6ZFz6nbDNPcJAhg6AujtSZFMcBMljYIhExZpM8GkvfZkJ4IzCvM7f6gxplTyssA9ZG85bP0N8vRYQscPJ/NMoOrkZXL132C5KKkF2ye+aLEWDAnq/IyWn9tk6I1FXSTuQqBjXZx4IjjuB6KxA9/x/0PFwnu0nGW22L2hNAti0oqOVr9zfBZuM00FLxBk6B0zDWkpjT2c3A58byMm85yfYPruEAPjdcXUOtgwkdBiNcp8oblTmOKHJKOkfYIRqVGIQVESJmciAQ+ULFXHBK6rA8vq2EI0CVrtIAOKOJENPR+T7egYjWf5ZBNYl3RH5N1rKJw32LIGDaQP138r80K2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199018)(38070700005)(36756003)(86362001)(316002)(83380400001)(91956017)(66946007)(66476007)(66446008)(64756008)(66556008)(76116006)(6506007)(53546011)(6512007)(186003)(26005)(54906003)(71200400001)(478600001)(2616005)(6486002)(82960400001)(122000001)(38100700002)(8936002)(5660300002)(6916009)(8676002)(4326008)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmhpTDhtWExFTVNrWEtsTWlRdCsvOUFpdlB2SFFicGNaMWswMTMvSG9Gc0NK?=
 =?utf-8?B?RE1Kd1pad2xVUGdKSTYzY0VkUjVlSERlL28xY2ExckJJc2ZkN2RuUHluSlZp?=
 =?utf-8?B?b1c0alFCUTF4ZzVLNHovWE1zM2luaTNYdDc5TkxzeVNYTVRWZWVEVGNqdWZY?=
 =?utf-8?B?dkhoZzIrWGJFMG1LUENaQW16L2ZnUTY3d0V4Q0YrMk1RZjRWTk1hUlo2aTJz?=
 =?utf-8?B?STBXdFZkd0o0Y3ZUOFhFWGFkVjd5MEl2YjFjbVhBNzdYK0hPR0RXR2t2dFZw?=
 =?utf-8?B?V0tReDZWZ0tNZEtoQ3hJaWhhZjB0a29JYTBzMGY1aGFmZWpWc2k0RURGMHZv?=
 =?utf-8?B?Sm5vRHhyVHFtRGNLRTJkMUkrS2dQZEJBQVM3Y1lTd0Vrbktya3NxbnFEOHF0?=
 =?utf-8?B?MFFjanR6ZW1XbkR5RHlYandUTVN0SytHbWlkTmJ5RVY1WTh5cU8zNDJSeURh?=
 =?utf-8?B?cHBpOUhpVUdOVVVsZ2JGNXBRdmUyRXdPK3NIRHJjSG9PMXBMWTFyQnJEaWpJ?=
 =?utf-8?B?Zkd5TVZ1azY5RkhiamNlRE5vdytkdmN0S1B5MjNiTldTK1F1NXRmWmk3OWFE?=
 =?utf-8?B?YlBGWGhlcUhXT3Y1cHdxdnE1OGEvNnQxTlIyR3U5ZCtqQVJ6SmtDRHprZWEz?=
 =?utf-8?B?MEE0S0JhRGNPcVpockZ0ZzE5R0J2dVBlOEpDUjJhcFQ4ZmZYdWt1aTdWWmo4?=
 =?utf-8?B?TkZzMUxTM0tiSENucUZydlo2cUoxNFRkSG0reVZPT0crRk5Ibmhkdyt3eEF5?=
 =?utf-8?B?R2xPRUpTbk1VTG5SZCtGWnFNNTlmYmp4dTliSnJpYS9EWkFlNU5WU2puQmsv?=
 =?utf-8?B?VDJ2bGtxUlFld0JZN3BJeVg0SDR0eHV5dXNrN1I0RUdKb1J1V0FjdXd4UHpL?=
 =?utf-8?B?eTJjclN5eFBIVHNkaXAvM2lyNnJyNGpGTDhGQUVaYk1McDhsSFVUZVdxekU3?=
 =?utf-8?B?MUNqNXQ2Zkx2VUJtMDdKV2RjQTBCU3Ixc0plV05YeVBNSE8wNjd3ZDFUV2d6?=
 =?utf-8?B?U21sV004VlJBYzNOSXJnSjhJb3N4OGFyaElFcm5NengwRG1FdUNIamd6eHdC?=
 =?utf-8?B?SzhKa1pNalR4V3FmV3VsTERPa0VjY1FCZnJueFpLZUFzQlFhVlR3RzFXZ2Zm?=
 =?utf-8?B?TlEvYkxoUXNrNUM4Y0dBMGRzeWVIWEFhS2JTS3ZzOHVHME9zclRzb0s0TzNG?=
 =?utf-8?B?OVNMcjBRaysvejU4bVJyblhjRVlJd0R4YlN4bWwvYlJhOCs4RXZ6VndHTldH?=
 =?utf-8?B?VGlVVWFOWStGL1paNmczMjExaWl1czI2azdvZXVhYWJzRDZWblZKYU1WWjJ6?=
 =?utf-8?B?VE1OSXFXZmJlWHJNQXgxUHhlOWVvYnpYOHJQOUNkTzgxRTRMeHNKSEFGTGNO?=
 =?utf-8?B?cW5OUW5PK0d3NDY1bFBHV2dJbW5MTE90U0NHV2xCVmx0NlcxajErZnFUaTR4?=
 =?utf-8?B?SzMrQXhhMmxYdElSWTNHc05EaFVUMDRNa1ptMTRMSnVMNDluWEthdFFUNUlK?=
 =?utf-8?B?RDI1TXo4ck11LzlXYm56NHY0L2gwN0NSbVAvOUxpejFnSHZQWkoyMlJkMSsx?=
 =?utf-8?B?RURNTjljbG1HM0hpYXRQempRcndMMEhob2RJRUpKSGZpU3lqYW9tUDBhNkZs?=
 =?utf-8?B?d1NmbG5LWGphNElwU0szb3IzT1BGWjRoRE91QXpKM0tUaUlqZ0pXdGlmUUFR?=
 =?utf-8?B?Uk9jUWVvUDBESXYzWWZBNzJKSnhBQzBRM1d4anNiUEVGRDgrRUFYWmlHZmJN?=
 =?utf-8?B?bVE5Y2p6WE9BckgreTIyRXJsV2tuN0tIWnkvQ2FSa3RNRjFPMlY3alJNYXhp?=
 =?utf-8?B?QWxTcWxlNHFZYlJmZWN3QU91Ym9qTVJIdHRLWm1IUkFKc1JYdVUwYTRMeHcr?=
 =?utf-8?B?VmdBNVRaQXN6RzZSSTNFMGZncXpETmdBbC9KNzRDK0xQand3dEw4OXpCZVdS?=
 =?utf-8?B?SFdITUhPaEQxYUd4aGdPWjZOYmxyK09mOFBXdzB3ZWtpbjV0NEI5aW5lbjNs?=
 =?utf-8?B?ZzBtL1M2YTEzdzZtQ0xsNWpONXo1Y24zWlN4WmdpWWZ1ZEo3RnFmaEtHdm9B?=
 =?utf-8?B?N2d2Q2EzWWFMektEWjUxK2FqcHhENkd1K3F6Mm13alZJLzl3UURrRzE4WDc3?=
 =?utf-8?Q?gE4UG7hd094Q/Ajyew8QClwco?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC8CC46277A3AF458674ACF8E0C4CB07@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40e0e25-1a6f-47a4-413e-08db0bdee2db
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2023 03:20:11.9253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bcd9Syy8sGqsYQ1y7wArgJ/rsdhDVMlI44NBZY7WhWPdcTEsnPzPzv04eEHtHThk5VASEEWFzPqnNpvcXbqR9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4962
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAyLTA5IGF0IDE4OjA2ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gVGh1LCBGZWIgMiwgMjAyMyBhdCAyOjI1IEFNIFpoYW5nIFJ1aSA8cnVpLnpoYW5n
QGludGVsLmNvbT4gd3JvdGU6DQo+ID4gV2hlbiBzZXR0aW5nIHRoZSBwb3dlciBsaW1pdCB0aW1l
IHdpbmRvdywgc29mdHdhcmUgdXBkYXRlcyB0aGUgJ3knDQo+ID4gYml0cw0KPiA+IGFuZCAnZicg
Yml0cyBpbiB0aGUgcG93ZXIgbGltaXQgcmVnaXN0ZXIsIGFuZCB0aGUgdmFsdWUgaGFyZHdhcmUN
Cj4gPiB0YWtlcw0KPiA+IGZvbGxvd3MgdGhlIGZvcm11bGEgYmVsb3cNCj4gPiANCj4gPiAgICAg
ICAgIFRpbWUgd2luZG93ID0gMiBeIHkgKiAoMSArIGYgLyA0KSAqIFRpbWVfVW5pdA0KPiA+IA0K
PiA+IFdoZW4gaGFuZGxpbmcgbGFyZ2UgdGltZSB3aW5kb3cgaW5wdXQgZnJvbSB1c2Vyc3BhY2Us
IHVzaW5nIGxlZnQNCj4gPiBzaGlmdGluZyBicmVha3MgaW4gdHdvIGNhc2VzLA0KPiA+IDEuIHdo
ZW4gaWxvZzIodmFsdWUpIGlzIGJpZ2dlciB0aGFuIDMxLCBpbiBleHByZXNzaW9uICIxIDw8IHki
LA0KPiA+IGxlZnQNCj4gPiAgICBzaGlmdGluZyBieSBtb3JlIHRoYW4gMzEgYml0cyBoYXMgdW5k
ZWZpbmVkIGJlaGF2aW9yLiBUaGlzDQo+ID4gYnJlYWtzDQo+ID4gICAgJ3knLiBGb3IgZXhhbXBs
ZSwgb24gYW4gQWxkZXJsYWtlIHBsYXRmb3JtLCAiMSA8PCAzMiIgcmV0dXJucyAxLg0KPiA+IDIu
IHdoZW4gaWxvZzIodmFsdWUpIGVxdWFscyAzMSwgIjEgPDwgMzEiIHJldHVybnMgbmVnYXRpdmUg
dmFsdWUNCj4gPiAgICBiZWNhdXNlICcxJyBpcyByZWNvZ25pemVkIGFzIHNpZ25lZCBpbnQuIEFu
ZCB0aGlzIGJyZWFrcyAnZicuDQo+ID4gDQo+ID4gR2l2ZW4gdGhhdCAneScgaGFzIDUgYml0cyBh
bmQgaGFyZHdhcmUgY2FuIG5ldmVyIHRha2UgYSB2YWx1ZQ0KPiA+IGxhcmdlcg0KPiA+IHRoYW4g
MzEsIGZpeCB0aGUgZmlyc3QgcHJvYmxlbSBieSBjbGFtcCB0aGUgdGltZSB3aW5kb3cgdG8gdGhl
DQo+ID4gbWF4aW11bQ0KPiA+IHBvc3NpYmxlIHZhbHVlIHRoYXQgdGhlIGhhcmR3YXJlIGNhbiB0
YWtlLg0KPiA+IA0KPiA+IEZpeCB0aGUgc2Vjb25kIHByb2JsZW0gYnkgdXNpbmcgdW5zaWduZWQg
Yml0IGxlZnQgc2hpZnQuDQo+ID4gDQo+ID4gTm90ZSB0aGF0IGhhcmR3YXJlIGhhcyBpdHMgb3du
IG1heGltdW0gdGltZSB3aW5kb3cgbGltaXRhdGlvbiwNCj4gPiB3aGljaA0KPiA+IG1heSBiZSBs
b3dlciB0aGFuIHRoZSB0aW1lIHdpbmRvdyB2YWx1ZSByZXRyaWV2ZWQgZnJvbSB0aGUgcG93ZXIN
Cj4gPiBsaW1pdA0KPiA+IHJlZ2lzdGVyLiBXaGVuIHRoaXMgaGFwcGVucywgaGFyZHdhcmUgY2xh
bXBzIHRoZSBpbnB1dCB0byBpdHMNCj4gPiBtYXhpbXVtDQo+ID4gdGltZSB3aW5kb3cgbGltaXRh
dGlvbi4gVGhhdCBpcyB3aHkgYSBzb2Z0d2FyZSBjbGFtcCBpcyBwcmVmZXJyZWQNCj4gPiB0bw0K
PiA+IGhhbmRsZSB0aGUgcHJvYmxlbSBvbiBoYW5kLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9w
b3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jIHwgNyArKysrKystDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wb3dlcmNhcC9pbnRlbF9yYXBsX2NvbW1vbi5jDQo+ID4gYi9kcml2ZXJzL3Bv
d2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCj4gPiBpbmRleCAyNmQwMGIxODUzYjQuLjhiMzBl
NTI1OWQzYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfY29t
bW9uLmMNCj4gPiArKysgYi9kcml2ZXJzL3Bvd2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCj4g
PiBAQCAtOTk5LDcgKzk5OSwxMiBAQCBzdGF0aWMgdTY0DQo+ID4gcmFwbF9jb21wdXRlX3RpbWVf
d2luZG93X2NvcmUoc3RydWN0IHJhcGxfcGFja2FnZSAqcnAsIHU2NCB2YWx1ZSwNCj4gPiANCj4g
PiAgICAgICAgICAgICAgICAgZG9fZGl2KHZhbHVlLCBycC0+dGltZV91bml0KTsNCj4gPiAgICAg
ICAgICAgICAgICAgeSA9IGlsb2cyKHZhbHVlKTsNCj4gPiAtICAgICAgICAgICAgICAgZiA9IGRp
djY0X3U2NCg0ICogKHZhbHVlIC0gKDEgPDwgeSkpLCAxIDw8IHkpOw0KPiA+ICsgICAgICAgICAg
ICAgICBpZiAoeSA+IDB4MWYpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBwcl93YXJu
KCIlczogdGltZSB3aW5kb3cgdG9vIGxhcmdlLA0KPiA+IGNsYW1wZWRcbiIsIHJwLT5uYW1lKTsN
Cj4gDQo+IElJVUMgdGhpcyBoYXBwZW5zIHdoZW4gdXNlciBzcGFjZSBwcm92aWRlcyBhIHZhbHVl
IHRoYXQgaXMgdG9vIGxhcmdlLg0KPiBXaHkgZG8geW91IHdhbnQgdG8gbG9nIGEga2VybmVsIHdh
cm5pbmcgaW4gdGhhdCBjYXNlPw0KPiANClJpZ2h0Lg0KSSBkb24ndCBrbm93IGFueSBBUEkgZm9y
IHRoaXMgcHVycG9zZSwgc28ganVzdCByZW1vdmVkIHRoZSB3YXJuaW5nIGluDQpwYXRjaCB2Mi4N
Cg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAweDdmOw0KPiANCj4gQmVjYXVz
ZSB0aGUgdGFyZ2V0IGhhcmR3YXJlIGZpZWxkIGhhcyA3IGJpdHMsIHRoZSBmdW5jdGlvbiB3aWxs
DQo+IHJldHVybg0KPiBhbGwgb25lcyBpZiB0aGUgZXhwb25lbnQgaXMgdG9vIGxhcmdlLiAgSXQg
d291bGQgYmUgZ29vZCB0byBwdXQgYQ0KPiBjb21tZW50IHN0YXRpbmcgdGhpcyBoZXJlLg0KPiAN
CnN1cmUuDQoNCnRoYW5rcywNCnJ1aQ0KDQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArDQo+
ID4gKyAgICAgICAgICAgICAgIGYgPSBkaXY2NF91NjQoNCAqICh2YWx1ZSAtICgxVUxMIDw8IHkp
KSwgMVVMTCA8PA0KPiA+IHkpOw0KPiA+ICAgICAgICAgICAgICAgICB2YWx1ZSA9ICh5ICYgMHgx
ZikgfCAoKGYgJiAweDMpIDw8IDUpOw0KPiA+ICAgICAgICAgfQ0KPiA+ICAgICAgICAgcmV0dXJu
IHZhbHVlOw0KPiA+IC0tDQo=
