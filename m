Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF0A69E0EC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjBUM7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjBUM7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:59:05 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807F99757;
        Tue, 21 Feb 2023 04:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676984344; x=1708520344;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K/gjKx/A3amWB+5FHw5P2Ub5ZY1eofvs+O+v0e82Zok=;
  b=RELUVF2FtYAhSjoq3LV/irFUYfzAAp3MvZsYwfO+YiQUHOfsUkIFtNNo
   d5gi/crnCkvzoYulBaz0nmgdcaSKRUg/xTI2I9E925+DlHWOTmezUY34w
   7/PR4jTaV8Xtp8fv7dHcyWyMji5dte3mZsOTCMIvhxqwk8lfrVdX5JBDw
   KnAnixObU2NjAtFpBODLYsh4dqhANVHwT1Bu1bYFAyAjKQPP73UqO1q0N
   lbwshcmHXzHX0o743YF85U2ok9uhHPRTINBC+kb16EmY2zg/3PeqZoKn4
   cSO8YgQtrAJahipi9cv1eG3HtmAPY+eumDlcHoH0Gm4Yp9NkXHi0nwg5R
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="333982844"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="333982844"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 04:59:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="917180526"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="917180526"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 21 Feb 2023 04:59:03 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 04:59:03 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 04:59:02 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 04:59:02 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 04:59:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Frex+LLjbzZZ47zYnarspUPsjcs4BgcxAijuX9O1sllkG1FGFIsOsWJSFipGgWy+TyW0poR6PNXs6dGBqwFBbJ0CZbj3QqtSX+pAILhaV/6gYkunjrfzc0OcJpFcBES9Nz+YW6BC+SLCF14lypjC1Q8X5BvtPG9fhVh5iz9S8qBsAg3Whgeyf0uA9otXYAVX5XP6r9dlh5iDU3+vRhY5dGCFPIXIuDt8SPFNP2ENJWFo6P16PvFdjeCAzAVCj/Sl3zyCdwKFaOwz62xQZ6j2JIoC6ONdo2iSVdDw4tGHw4VS/kTP4eH+p/6a+hWT6WebyMJfW5Twa4Dr97IJXaaWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/gjKx/A3amWB+5FHw5P2Ub5ZY1eofvs+O+v0e82Zok=;
 b=L+T+8olmXM1NJ9KU3T5YPFhnSt4YaLKH3irB485nAulJspj3Ra4FQX+vQhDV6rlpnGJ80zmWa2Vd0ibA0fgY0kZ8ggY7Pc5TWJQfvl2/uEq1PuhmajU/TYE+0E/O2YRfvPberq9DPNxSa/s5gXggjEffwRSf+Qwa2tLL7JWaENRuPjCI1QtK4+ht0mBM5zpzKRh6qgtWPYFRSeZgGKecEGFIwieT64ebfAkjl5Zpub1jGV7mBqtweHfQkvueaPJ3xPsMVFHuSsvgNR7aCihqh+Mvz6DVPgbnly5KNg8yPix9nQ92o0/GxS4tKE2vWGy5v4bbmAzDESjvBzbY+PxA+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CY8PR11MB7243.namprd11.prod.outlook.com (2603:10b6:930:96::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Tue, 21 Feb
 2023 12:59:00 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837%8]) with mapi id 15.20.6111.018; Tue, 21 Feb 2023
 12:59:00 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thomas, Sujith" <sujith.thomas@intel.com>,
        "amitk@kernel.org" <amitk@kernel.org>
Subject: Re: [PATCH RFC] thermal/drivers/intel_menlow: Remove
 add_one_attribute
Thread-Topic: [PATCH RFC] thermal/drivers/intel_menlow: Remove
 add_one_attribute
Thread-Index: AQHZRUfUQd8JkpNbU0G4xbaL+Gycn67Y7zcAgABWG4CAABiigA==
Date:   Tue, 21 Feb 2023 12:58:59 +0000
Message-ID: <6b63db0832fadffa56ff85a1c4ca2b98d165df50.camel@intel.com>
References: <20230220162419.1276952-1-daniel.lezcano@linaro.org>
         <27488f102c917ce1f6d24d30f801b1e1745674e1.camel@intel.com>
         <b66fca52-d1f9-2761-4117-819c5820308d@linaro.org>
In-Reply-To: <b66fca52-d1f9-2761-4117-819c5820308d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CY8PR11MB7243:EE_
x-ms-office365-filtering-correlation-id: 23a03ccc-e4b8-44a9-a334-08db140b666e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xRP78qlGX8xfc6pHgmwbiDfh6mXYKfOqLI+6dIpZsCR9cXf6XvlDVm/5jbUy2VDkOwN78YFjdLLjAHa/Si/vwxwtNTGn3S826IvfU3kvxcE9u/jHSYX4qB17xdQjX27nPoZ0pO0ulmP/J6E/bEIMdhi28b7kqrKLs1HNaeBDIUOY/6ZKx04VEzkGMtFi829SZRuisaZvh7mBOJp8FQ4Oc7nvFp9s86r57zGs+lWKlTzG0Y8nMKS1JMdredI7ru73DuBAJuyUPPisRLi4caijrCA4pJAzL9j+umkFF0bFB87RZNz50lGcjg7+7QwH1i/Dqx5aA766EPKpEviDyuBks/NqutyUVLPfi8iaku6YdEYhZg3PP+SAQPmDXm3kX+4ZK4mbpaxyJAI8EUvDTwKMh9G5lEX8lh5EziEFHCXW4j/VCfZ8rxuUI9AVp7VuIEAroxPDip7i2O3sqpjDrc5N6bVNvdYq0kPlQ1/HtHP1wAzDvYqqXfP0xZXRaP33lxKRhfG2V1qgTBa/i/wHuSXn5f/eybt/vstl0FM2CCPvu4lhquNRa7UUfoqZnWlBDE9SJ17Wi6ZoB9fvPw6Li9A83s8qtLkq/h+fHg33ZuRT2Nfpcn0vc5vl5/Ay5WxOKko6wGeipCPxnnd9jbdoi2gttF4mEPXNVma51QC+PZQdVXGFSMBIyeRN1VNHuuAfzBxXat++IFqySDt8igDPqM3flw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199018)(86362001)(8676002)(478600001)(66946007)(36756003)(66556008)(2906002)(66446008)(4326008)(64756008)(8936002)(76116006)(91956017)(66476007)(5660300002)(122000001)(82960400001)(38070700005)(38100700002)(41300700001)(71200400001)(110136005)(316002)(54906003)(6506007)(6486002)(186003)(2616005)(53546011)(26005)(83380400001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWViK04wRTZESmREeE1jR1ptZStvM2EvUzlWeEdZNCtxdEdCUXNyUnpCN2FJ?=
 =?utf-8?B?eFpRb0pZZEZ1dGF2eEltbllYMFFGT1dVMnBtUkpQMUdURGhqd2JPdjBtbXBu?=
 =?utf-8?B?WVRaclRXaXFzN29YSXBkUlFVRVg4Rjh6dHFCbXVEd2Fad3gydlArekdGZkdy?=
 =?utf-8?B?Q0UzZVRyY2tvTnNXY2ZOSlEveXlDcm1yTjZETmZMblRzWDUzTjZlT2dLZXpw?=
 =?utf-8?B?SzdRTE9kNUlFdWpZQmFXd2hBcUpWZzVqbytON3dvMjhpQ0dEYmFESStzakw0?=
 =?utf-8?B?TDBhaGpHcG9KR2prRy9RR20wQzZXWWRCRFp2MzA3Q2RkTHpCQnE2M3ZhVEZW?=
 =?utf-8?B?SUd2MlFxSXF0TFRoOFlOVTcxY2J5MkptYU1wTUEzaHQ1MGljcm9sSmM5QWVM?=
 =?utf-8?B?cU9XZzVqVEJlMWdlemllT01tbExSaDhuMXpVTVdzb213aGMxeWp0Q21IUndF?=
 =?utf-8?B?ZXdoanJ2NkUzbVR1TXZDb0lMNUJ3U2tjZ0kyRDREenNGODZoZUxtUm43ZDI0?=
 =?utf-8?B?NWNQOUh3ZXc4Z2M5elBXeFM1R1RHcFJiNXFRaTJmYnNIQnZ6MEU0Y3AyV3FG?=
 =?utf-8?B?bm1DcndQSGhKQU9rWVVwSWF1QzNzZDVIeFhKdjVxS1VLMTlUZit6OE1JRmQw?=
 =?utf-8?B?QmcybXFIK1ZIMWtWV3hvdjF1aTZVd0p2R3BlY1pFdWxDdkFGRnlTcXRzR21J?=
 =?utf-8?B?ZVFKYVN5NjB4NVE0NkhhZnJPcGQ2a3R5TUY3eENZZVQvTGtLb3pQQ0EzOXJ2?=
 =?utf-8?B?bEpRbEthWGVxaGdkMWt6TE1KcXRldGYzVWxvdmR5OFo0SHBzaElyQm1hekxk?=
 =?utf-8?B?YVF6ZTB3djU5em44WVRZWENsUzFFWFFpMjJ4OXFweDhwL1VIVEpHc0RlYkpK?=
 =?utf-8?B?N3AvOVVWOFRhaUN4eVJsYmpwWGdKSElsdksxV3c1cjdpWnF4K3BlNXJkM1J4?=
 =?utf-8?B?UCtQMjQwaFZIN3RLakwxb0ZEaElRSGJjczB2ZkxWUzAzd0ZDM0F2N2Y5bWNE?=
 =?utf-8?B?NVBDK3pOZitqSGxic2NYQ1NUamU5bUVPMk95TURUdHo3QnNaWnlhOU9tZnU3?=
 =?utf-8?B?WXhQSSs0R2Y4dmVtSjBkVkhTRGtBczM4azdKdnhGYS9kcHFGQUZkek4yOE5Z?=
 =?utf-8?B?aWdRNW1DaDNwV2szdmluNXd5TDVRKzN0REgybWNwcS8xWmR4RXJzUEJwd2Yz?=
 =?utf-8?B?SUMwQUEyV3NJdVpvNU9MblZZSVFhUTEraDYwYnQ3US93STk5Q3BiU2pLcnZ4?=
 =?utf-8?B?aTBuUjc1Yjd1MXJIUkFyendxRi8rNDB2emtMbUNkbTN2REltYzRncnpxRmRl?=
 =?utf-8?B?LzBxZUJhcXZoeGNEV2lhNGNML0dvaDF1d0ZSeVNQcHppa2RueGZCTkR4WDEy?=
 =?utf-8?B?YldRU0NrWDFVc25LOFJhT29MQjZ0SDVlT0ZISlRRNTVabEVHbER5S2NzTFcy?=
 =?utf-8?B?c2E0dk8zNDk1c2c0dmpMUkJlZXhXZVkwMTdLMUdaSFVqcitZOVRnWE9nbDRr?=
 =?utf-8?B?bDZWQit1SzA2dFE3TktoZTEzUEJPT2ZzQ2d2Q3l6cTd1TE9UbGVIL1oxa0pD?=
 =?utf-8?B?T0ZCS0xjeE45UHhlWmdBeUI1K0hua1ZvOTFBZGNNdXZGZmNZMVhJNmx6ZWdt?=
 =?utf-8?B?TWkzVFFJMUhlbG9XL1NYZmdFTjlSTFAvQWFibTE4bEIvM2RPR05XQ080eFE4?=
 =?utf-8?B?SGgzSnJJbFZTRmIzOFRxWEdGZklhWWptbVRVZHBWZE9ORms1dkE2RDZNaWYw?=
 =?utf-8?B?TlNxcUtnRi9wd0ZvUEFxZU1BeGRnbUp3WjEyZ29QRVc5ZDU5R3dQelE2eFJi?=
 =?utf-8?B?OGJUZEYwTTlTR3lqUWFMcHY5MklvYW5ubG4xSGVkSjVnWVZUejFya0lldDNP?=
 =?utf-8?B?SWdpTDhqd1JtZHp2ZWpRMDBScVpFWHNCM21DSGhPZDZ4bGM2bFFrU0NnMjY2?=
 =?utf-8?B?K2tJQTJqK0dQVEhJSUpoTzdrVXdBbUJIOS80YVJvYnZ6MFVWTUtSYWc3bHdh?=
 =?utf-8?B?QlhEV2xDZjU0NldnUmZMWmdDTkxEczZ3N2tZR3d4ZCtoU2p1UkJ4R2VFMzJV?=
 =?utf-8?B?WWQvQUZ4WmdScEF5SXdZNkMxRCtHQjZWMlpUZElMUU1HMnhZUHZCSzRBTUtF?=
 =?utf-8?B?em53bHcrcEl2eklkdXlyQmRsYmJ3VDdETkhoaWI2bUpQWVFaYzNVZXJmblZh?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B4C934AB70A8244A408D673D8988516@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a03ccc-e4b8-44a9-a334-08db140b666e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 12:58:59.8623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJHtAPa7T1lY2etKj2NbLjvYeExNAnckj752GExzoQmzZ0xDZOeYTlSHOIxC6MY1pHnJQI76pMGng5odyG0MIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7243
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

SGksIERhbmllbCwNCg0KT24gVHVlLCAyMDIzLTAyLTIxIGF0IDEyOjMwICswMTAwLCBEYW5pZWwg
TGV6Y2FubyB3cm90ZToNCj4gSGkgUnVpLA0KPiANCj4gDQo+IE9uIDIxLzAyLzIwMjMgMDc6MjIs
IFpoYW5nLCBSdWkgd3JvdGU6DQo+ID4gT24gTW9uLCAyMDIzLTAyLTIwIGF0IDE3OjI0ICswMTAw
LCBEYW5pZWwgTGV6Y2FubyB3cm90ZToNCj4gPiA+IFRoZSBkcml2ZXIgaG9va3MgdGhlIHRoZXJt
YWwgZnJhbWV3b3JrIHN5c2ZzIHRvIGFkZCBzb21lIGRyaXZlcg0KPiA+ID4gc3BlY2lmaWMgaW5m
b3JtYXRpb24uIEEgZGViYXRhYmxlIGFwcHJvYWNoIGFzIHRoYXQgbWF5IGJlbG9uZyB0aGUNCj4g
PiA+IGRldmljZSBzeXNmcyBkaXJlY3RvcnksIG5vdCB0aGUgdGhlcm1hbCB6b25lIGRpcmVjdG9y
eS4NCj4gPiA+IA0KPiA+ID4gQXMgdGhlIGRyaXZlciBpcyBhY2Nlc3NpbmcgdGhlIHRoZXJtYWwg
aW50ZXJuYWxzLCB3ZSBzaG91bGQNCj4gPiA+IHByb3ZpZGUNCj4gPiA+IGF0DQo+ID4gPiBsZWFz
dCBhbiBBUEkgdG8gdGhlIHRoZXJtYWwgZnJhbWV3b3JrIHRvIGFkZCBhbiBhdHRyaWJ1dGUgdG8g
dGhlDQo+ID4gPiBleGlzdGluZyBzeXNmcyB0aGVybWFsIHpvbmUgZW50cnkuDQo+ID4gPiANCj4g
PiA+IEJlZm9yZSBkb2luZyB0aGF0IGFuZCBnaXZlbiB0aGUgYWdlIG9mIHRoZSBkcml2ZXIgKDIw
MDgpIG1heSBiZQ0KPiA+ID4gaXQgaXMNCj4gPiA+IHdvcnRoIHRvIGRvdWJsZSBjaGVjayBpZiB0
aGVzZSBhdHRyaWJ1dGVzIGFyZSByZWFsbHkgbmVlZGVkLiBTbw0KPiA+ID4gbXkNCj4gPiA+IGZp
cnN0IHByb3Bvc2FsIGlzIHRvIHJlbW92ZSB0aGVtIGlmIHRoYXQgZG9lcyBub3QgaHVydC4NCj4g
PiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5v
QGxpbmFyby5vcmc+DQo+ID4gDQo+ID4gSSBkb24ndCBoYXZlIGFueSBkZXZpY2UgdGhhdCB1c2Vz
IHRoaXMgZHJpdmVyLg0KPiA+IExldCdzIHNlZSB3aGF0IFN1aml0aCBzYXlzLg0KPiANCj4gVGhh
bmtzIGZvciB5b3VyIGFuc3dlci4NCj4gDQo+IEkgdGFrZSB0aGUgb3Bwb3J0dW5pdHkgdG8gYXNr
IHlvdSBmb3IgdGhlIEFDUEkgdGhlcm1hbCBhZGRpdGlvbmFsDQo+IHN5c2ZzIA0KPiBlbnRyaWVz
Lg0KPiANCj4gVGhlIEFDUEkgdGhlcm1hbCBkcml2ZXIgYWRkcyBhIGxpbms6DQo+IA0KPiAvc3lz
L2NsYXNzL3RoZXJtYWwvdGhlcm1hbF96b25lMC9kZXZpY2UNCj4gDQo+IHdoaWNoIHBvaW50cyB0
bzoNCj4gDQo+IC4uLy4uLy4uL0xOWFNZU1RNOjAwL0xOWFNZQlVTOjAxL0xOWFRIRVJNOjAwDQo+
IA0KPiANCj4gQW5kIGluIHRoaXMgZGlyZWN0b3J5IHRoZXJlIGlzOg0KPiANCj4gL3N5cy9kZXZp
Y2VzL0xOWFNZU1RNOjAwL0xOWFNZQlVTOjAxL0xOWFRIRVJNOjAwL3RoZXJtYWxfem9uZQ0KPiAN
Cj4gcG9pbnRpbmcgdG8gL3N5cy9jbGFzcy90aGVybWFsL3RoZXJtYWxfem9uZTANCj4gDQo+IA0K
PiBJIHdhcyB3b25kZXJpbmcgaWYgd2UgaGF2ZSB0byBrZWVwIGl0IGFsc28/IEl0IGlzIGEgY3lj
bGljDQo+IGRlc2NyaXB0aW9uIA0KPiBhbmQgd2UgY2FuIGhhdmUgdGhlIHNldmVyYWwgdGhlcm1h
bCB6b25lcyBoYXZpbmcgYSBkZXZpY2UgbGluaw0KPiBwb2ludGluZyANCj4gdG8gdGhlIHNhbWUg
bG9jYXRpb24uDQoNCkkgZG9uJ3QgdGhpbmsgc28uIFNvIGZhciwgQUNQSSBUaGVybWFsIG9iamVj
dCBhbmQgdGhlIGdlbmVyaWMgdGhlcm1hbA0Kem9uZSBkZXZpY2UgYXJlIDE6MSBtYXRjaC4NCg0K
PiAgU28gSSdtIG5vdCBzdXJlIHRoaXMgaXMgY29ycmVjdC4NCj4gDQo+IEkgY2FuIHVuZGVyc3Rh
bmQgYWRkaW5nIGEgbGluayBpbiB0aGUgdGhlcm1hbCB6b25lIHBvaW50aW5nIHRvIHRoZSANCj4g
ZGV2aWNlIGNvdWxkIG1ha2Ugc2Vuc2UsIGFuZCB0aGF0IGNvdWxkIGJlIGdlbmVyYWxpemVkIHRv
IGFsbCB0aGUgDQo+IHRoZXJtYWwgem9uZSBjcmVhdGlvbiwgYnV0IHRoZSBiYWNrIHBvaW50ZXIg
bGluayBzZWVtcyBzdHJhbmdlLg0KPiANCj4gV291bGQgaXQgbWFrZSBzZW5zZSB0byByZW1vdmUg
dGhpcyBzZWNvbmQgbGluayA/DQoNClRoYXQgd2FzIHJlcXVpcmVkIGJ5IHNvbWUgdXNlcnBzYWNl
IHRvb2wgcnVubmluZyBvbiBtZW5sb3csIHNpbWlsYXIgdG8NCnRoaXMgb25lLiBCdXQgVEJILCBJ
IGRvbid0IHJlY2FsbCB0aGUgdXNlcnNwYWNlIGRldGFpbHMuDQoNCnRoYW5rcywNCnJ1aQ0K
