Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE696D3BD1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 04:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjDCCZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 22:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDCCZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 22:25:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038885B8D
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 19:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680488743; x=1712024743;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GNUFa1GkHxwtGbMp98Zupfl84CwTKzO2CtF4qDqJ9lI=;
  b=UPLlhGHgZCeQ8m9tOcFgOCzW39eifRpF7l+xppCmH62NRCkaGRLrcBNW
   epMoPlPDUuKfw8X+bXyAeit5dKTwRkvFQPx6Zb22bORyLNrBqq2zXmWMh
   JL2brjDkP7HpbrtuxXvOHg9lZyxS8JQ2z1kxN9stRR38eh5z4PvoYkQKz
   nIaS1RvdcteqUJ3ha88c8jhvPRQxXdZhF8vOvtJ7gqkyfkObvFv27LNei
   SXmoC7XPJAeBHS2ZCMW6zP1JuZSjVkroqSSKFisj8r6xOa6Jaz7YyM/ok
   /6wLRoYSwnF9vzF8PVCb5Hks0qTigoWykGLIpcauN/dFs9+eA0EG8w7CY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="325791605"
X-IronPort-AV: E=Sophos;i="5.98,313,1673942400"; 
   d="scan'208";a="325791605"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 19:25:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="775003516"
X-IronPort-AV: E=Sophos;i="5.98,313,1673942400"; 
   d="scan'208";a="775003516"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Apr 2023 19:25:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 2 Apr 2023 19:25:43 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 2 Apr 2023 19:25:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 2 Apr 2023 19:25:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 2 Apr 2023 19:25:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6a7ZN8nFfpP7KHiwcweG7Lli4VraKrqhG6eRTv6WTALVqBeWEpchKqoYthp7rtK0qRjsuGVbzwGFyL7XcKmwxHW1R1WyADE/8ahRWw2eRDqNV67QDYj3cdcOceN3LtmHIIlfY+iY5RHtRCAlBi4EPJRlnU3VTDgzSlkjLWg28ppMNq+C1ew6Z0HkL4TKn/vfGUDolUDKLMZVxI3ali7dGOPPRlLT31cJ2c5g7sNCzQTP4LjIq5hxlN4A8ihU9OSft1/Aw9AHzZZmJMpLo/mhFf14vv126C/bQqmDyqZj0CUdOPkulSAYettsWe/ROVAKLDR6coZkWcX0xoex12XAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNUFa1GkHxwtGbMp98Zupfl84CwTKzO2CtF4qDqJ9lI=;
 b=RakvciGAYy/syATjettTAeBdcO9imjlr6hrdUNzi+60XSFLX6OnjG/nEjZezJN33IqkTa3IgSOfE6oeZzDjVLg6ln4DZi0JLqBwCeuswclIEcyy/0TM6s0mZLTd8RgJdhY4/qVwTnpJpjEqufAHZeBo/N4w7MZsMvObeaaMGtZPqzhdpupteZJL3jE8pLZwTMSS8OBY0u3TJg+0A4En7p4flnfQUg22GunaUuzzpJfBYXHhJqpye2j2BsaLPrexcxaRjFhXeesnuGgvH4P2x83m/tQ9uj4Dc77J7+FioIDDLRh/e/a7Rl4H9hLPLXaV8bfMsGiRIdottwVjAf2p+7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW4PR11MB6837.namprd11.prod.outlook.com (2603:10b6:303:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 02:25:40 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f403:a0a2:e468:c1e9]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f403:a0a2:e468:c1e9%5]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 02:25:40 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Gross, Jurgen" <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Thread-Topic: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Thread-Index: AQHZZGR61ijUNf30fEKIHhN53WCdS68Y3l2A
Date:   Mon, 3 Apr 2023 02:25:40 +0000
Message-ID: <74b1b65577e0e1c3e54a5a708af2f63df132227d.camel@intel.com>
References: <20230401063652.23522-1-jgross@suse.com>
         <20230401063652.23522-5-jgross@suse.com>
In-Reply-To: <20230401063652.23522-5-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW4PR11MB6837:EE_
x-ms-office365-filtering-correlation-id: d58a37ad-9015-4be3-a6b5-08db33eab7cd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g1GjO9wxfHjBdsMWHSRfJMU5W3kHheteqObJN51cnHVVPbrKmU6o1HNfdkKRDrlu3aGin3p5CINthmdNq2mIzU5WHaGdAVSjp8wz3eO8AYZ04E4t7sDsd86pD7IB5mfPQ9QobRIqls1AiKnrV5f0eH3DpdLy4zC0PLsDrvraQa3EBP7txO2TaLb4QPVjAZBdsaXBDU6NSNm8KbDe1WXCOQWpJZ+5OjVso7W3yS75TG+vFV9GgvgKTWEXijGMQXq6DDRYYvV2UydFP5XcNnBUTQPsqvDr0Qmz4Q0Q62dJFZNpNN5aXsgyt4gW+iwgs9Hpz2JTNlpK05IGd97BlWFum8N+knd34hWWLMShTF5HlZ9stlX6OObevE0gfXymYUInEWMJeCSUAB2ZqU9wFsVHxo0y+O+woQpeboQ4E1QPadUwhJRuX3YGdmRITlaC8HA9weTsW2KrWeMCUEnedxohSKC6NO8/E4+F3RZu6b0eqfUBc0dFPU7ZX8WkJuniZ+ubw6yiF8W9WQGBUpLrFqST+F/yoamNkA4bhlLSXitxL6zAb3npEEzHrXsBjeMJ+rBEfO1BTiOGmXro4RVTR+INQLCjdcTEBcrbx87Des33UvY4Tje1Bxtf4+lI+7PCA1gR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(186003)(26005)(83380400001)(6506007)(2616005)(41300700001)(8676002)(76116006)(54906003)(66946007)(478600001)(66556008)(91956017)(110136005)(316002)(4326008)(66446008)(71200400001)(6486002)(66476007)(64756008)(38100700002)(82960400001)(36756003)(122000001)(6512007)(2906002)(38070700005)(86362001)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkxEV2RJekIydlJmRXpJR3BRb015L3llR2JCL3MrQWdNeFZNUVlvUCttSFdP?=
 =?utf-8?B?UlQ1UzJlajJ0Ynl5WlhzSERMSFk1aDkvM1Zjd1BMZ1ZveFZxN0QzVG1kbXNk?=
 =?utf-8?B?aW45bEF4NkpxZFJmcDZtMHVEUDBlbTYxNGEzdktSeU8zWnRJTG9mL2YrVngz?=
 =?utf-8?B?djFPQjVidU56NG9JY1VuRnNFSVo1RnlEd0tNWXROajgwbFJrdUpydmVkU0ZC?=
 =?utf-8?B?Z25zWWluUzBDSkg1WU5IcXMycGU1UE1lUDZjeTFmeGE2Sk1FdTZSSHpIMTA4?=
 =?utf-8?B?aG5uZTczYzNBUzA4SXhyQVpVTE1qUllkRFhDQTVpeG5lNDFROERGVTBCZXRP?=
 =?utf-8?B?dVhGVUtsbXNwdUozck5XdVlTTURUVStZN1dCd1R3Zk1iYWlOZklNdHJnOEkv?=
 =?utf-8?B?V0VUNHFnVTM3WlVtZTdEVWN1WVovS2pid1JNK3lESG9TK3dTbG9JV0xiQnBI?=
 =?utf-8?B?MTZlblEwbHh4c0dTRzVnQWxsRVhFTEJyd0xVZTNORmlYYklReHlRM0NDZmNO?=
 =?utf-8?B?THU3bWtZdTFTYVM3RzBGdmpmM1RxaGNndWhlQVN1N3BFU053Ym5vREhmTWtJ?=
 =?utf-8?B?UFQwS0xGUnMvUHlNZnJZRzhpRTU4OUc5YW9yTXZVQ08vVXBjSWw0TmVNU0xM?=
 =?utf-8?B?QzAwM2dCUXVQd2RjWHN3ODlDaEVFNDJwQjQrYzdCcDhqc2psNnY4b2xscnBy?=
 =?utf-8?B?YVF4ZGpjL2NyREZBWGh6aWkrTWptZXN1NHJDRnpKM004OW1HVkZJWXpKYnRo?=
 =?utf-8?B?NGdTVlBLM3pZSjFYQks4bG1wekh6ZGswQWEzUmp2RDJFeXJOL0Qwdk1wa0Er?=
 =?utf-8?B?YVlZK1V6UDNnVFAvQmVzQ1pkV1dHc3ZJaTZHL2Y1d1c2SXliMUlzd3lUOTZx?=
 =?utf-8?B?WTZKTTVzWWNINEE0VUNyMUVFQWRObGVEbCtGQ0dSblZqU25RM0ttOGkwTXV0?=
 =?utf-8?B?RmpaVmV2MFhHdktMZGpxNDd2Y2NXQmEvZDZUSitNQzNYeFhlT1Zld3lFK096?=
 =?utf-8?B?RGNod3MzYURXV2RmK294OEV0NFM3ZVpjTk5jNzNkK1czdXBSOGJVY1VRZGt3?=
 =?utf-8?B?NC9YcTR5aHc2ZGVNVzRwSTE3bUtCWEord004TFUwZ2xMK0FYcllUMjN4blFk?=
 =?utf-8?B?OFBOZUtuNktpN3gwKzJjaEo5MWNFRW51c2J2YVM4MmpLR1Zlb0U0S0RNUkxm?=
 =?utf-8?B?ZWJWV2wzWlZLNzNNVnBIN05HRFQ5RXJpNEtTTmpyRFZ0MG00dDZrK3hLdW15?=
 =?utf-8?B?MGRucUd4VTkySFdOMXd3ek1sQVloeGZERXRsa0RUOHVIUUNqOEVqNjQ3OXN1?=
 =?utf-8?B?VWV3bXFhK2s0VGJUYThBakpTRTZPc2FEM0RaamF4bjM1QjRmc1RKeXZ4TVU1?=
 =?utf-8?B?eGVnOFh0eCtMc0FITWhBWWNpNjMxRlVVOThGQmhFbzVnRE52Si9MaUx1d3VP?=
 =?utf-8?B?WUdQUlp0alpaUVdqME5MdExZTmpwcS9XTGpZSHVtcWwxcFRUSUFqSE91M0dW?=
 =?utf-8?B?MTlndUlPVVZMTzNmV04rbnFoaTNodms4Q2t6NitoRjRUbUlWSUZDbHE4TTd0?=
 =?utf-8?B?bXlUd2ZXblZFdkovNWEvWXY1eVQ3UFJxRE5oZ3Rkd01zSGhsbTVqc2JLVDNo?=
 =?utf-8?B?N0k5S0dsemk3ZHNJV2taMnFNZHJsd0w2MmJHKzFlZnRNSlphd0haWmV5UnhS?=
 =?utf-8?B?TlJ3ajZvWmlIMUg0UmRwWlRscjdWaWZ4eE91YzYvZG0vR1UxRnlZWjVpeHVN?=
 =?utf-8?B?a2c5aElzeU9hTndQeER4TEkxNFRucGlVUGpTRDFYNTAwZ3lsU0F4UEJZR0VK?=
 =?utf-8?B?WitDOXROZEorbmpTSldwV0p1Q0d4STBiZ1hSRllUQ1pDcUJROERLTW1TWU8w?=
 =?utf-8?B?NTNNVTJiRmFjV1F2b1EvSnVSdDNXRnNHa0ljUFdQVk0xcDZpTU1adVNzYjFQ?=
 =?utf-8?B?WWdVWEgwR3JmVzlVK0VLV1czbGpiVGxwN1VuSXhac0s2bEU4VlU4c1hqMmpk?=
 =?utf-8?B?N0tCeWUzY0d5SWZuOWZJUHFZbngrQit4aXlDRlcvRWkyZ1M5QkJmM1lNalZR?=
 =?utf-8?B?S2ZTSnRPczUyT1A0dUE1RXp1LytEYmRGRHNsVlRvanlvdmE3UE5OeXBudE51?=
 =?utf-8?Q?FcEh6rT6rlDMGe9KtBhYu1nso?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FC688FDF938EA4F910C1A6768281FDF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58a37ad-9015-4be3-a6b5-08db33eab7cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 02:25:40.1691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UyDKttPrqtsqbQxK2B//sYhmO9bsete0B5+pllzMBNDu90PvNcisF0bZQttoCkbjaZ/Q+H7a+xom46aVHtBafA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6837
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA0LTAxIGF0IDA4OjM2ICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
PiArLyoqDQo+ICsgKiBtdHJyX292ZXJ3cml0ZV9zdGF0ZSAtIHNldCBzdGF0aWMgTVRSUiBzdGF0
ZQ0KPiArICoNCj4gKyAqIFVzZWQgdG8gc2V0IE1UUlIgc3RhdGUgdmlhIGRpZmZlcmVudCBtZWFu
cyAoZS5nLiB3aXRoIGRhdGEgb2J0YWluZWQgZnJvbQ0KPiArICogYSBoeXBlcnZpc29yKS4NCj4g
KyAqIElzIGFsbG93ZWQgb25seSBmb3Igc3BlY2lhbCBjYXNlcyB3aGVuIHJ1bm5pbmcgdmlydHVh
bGl6ZWQuIE11c3QgYmUgY2FsbGVkDQo+ICsgKiBmcm9tIHRoZSB4ODZfaW5pdC5oeXBlci5pbml0
X3BsYXRmb3JtKCkgaG9vay4NCj4gKyAqLw0KPiArdm9pZCBtdHJyX292ZXJ3cml0ZV9zdGF0ZShz
dHJ1Y3QgbXRycl92YXJfcmFuZ2UgKnZhciwgdW5zaWduZWQgaW50IG51bV92YXIsDQo+ICsJCQnC
oCBtdHJyX3R5cGUgZGVmX3R5cGUpDQo+ICt7DQo+ICsJdW5zaWduZWQgaW50IGk7DQo+ICsNCj4g
KwkvKiBPbmx5IGFsbG93ZWQgdG8gYmUgY2FsbGVkIG9uY2UgYmVmb3JlIG10cnJfYnBfaW5pdCgp
LiAqLw0KPiArCWlmIChXQVJOX09OKG10cnJfc3RhdGVfc2V0KSkNCj4gKwkJcmV0dXJuOw0KPiAr
DQo+ICsJLyogT25seSBhbGxvd2VkIHdoZW4gcnVubmluZyB2aXJ0dWFsaXplZC4gKi8NCj4gKwlp
ZiAoIWNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfSFlQRVJWSVNPUikpDQo+ICsJCXJl
dHVybjsNCj4gKw0KPiArCS8qDQo+ICsJICogT25seSBhbGxvd2VkIGZvciBzcGVjaWFsIHZpcnR1
YWxpemF0aW9uIGNhc2VzOg0KPiArCSAqIC0gd2hlbiBydW5uaW5nIGFzIFNFVi1TTlAgZ3Vlc3QN
Cj4gKwkgKiAtIHdoZW4gcnVubmluZyBhcyBIeXBlci1WIGlzb2xhdGVkIGd1ZXN0DQo+ICsJICog
LSB3aGVuIHJ1bm5pbmcgYXMgWGVuIFBWIGd1ZXN0DQo+ICsJICogLSB3aGVuIHJ1bm5pbmcgYXMg
VFNYIGd1ZXN0DQoJCQkgICAgIF4NCgkJCSAgICAgVERYIGd1ZXN0DQoNCj4gKwkgKi8NCj4gKwlp
ZiAoIWNjX3BsYXRmb3JtX2hhcyhDQ19BVFRSX0dVRVNUX1NFVl9TTlApICYmDQo+ICsJwqDCoMKg
ICFodl9pc19pc29sYXRpb25fc3VwcG9ydGVkKCkgJiYNCj4gKwnCoMKgwqAgIWNwdV9mZWF0dXJl
X2VuYWJsZWQoWDg2X0ZFQVRVUkVfWEVOUFYpICYmDQo+ICsJwqDCoMKgICFjcHVfZmVhdHVyZV9l
bmFibGVkKFg4Nl9GRUFUVVJFX1REWF9HVUVTVCkpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCS8q
IERpc2FibGUgTVRSUiBpbiBvcmRlciB0byBkaXNhYmxlIE1UUlIgbW9kaWZpY2F0aW9ucy4gKi8N
Cj4gKwlzZXR1cF9jbGVhcl9jcHVfY2FwKFg4Nl9GRUFUVVJFX01UUlIpOw0KPiArDQo+ICsJaWYg
KHZhcikgew0KPiArCQlpZiAobnVtX3ZhciA+IE1UUlJfTUFYX1ZBUl9SQU5HRVMpIHsNCj4gKwkJ
CXByX3dhcm4oIlRyeWluZyB0byBvdmVyd3JpdGUgTVRSUiBzdGF0ZSB3aXRoICV1IHZhcmlhYmxl
IGVudHJpZXNcbiIsDQo+ICsJCQkJbnVtX3Zhcik7DQo+ICsJCQludW1fdmFyID0gTVRSUl9NQVhf
VkFSX1JBTkdFUzsNCj4gKwkJfQ0KPiArCQlmb3IgKGkgPSAwOyBpIDwgbnVtX3ZhcjsgaSsrKQ0K
PiArCQkJbXRycl9zdGF0ZS52YXJfcmFuZ2VzW2ldID0gdmFyW2ldOw0KPiArCQludW1fdmFyX3Jh
bmdlcyA9IG51bV92YXI7DQo+ICsJfQ0KPiArDQo+ICsJbXRycl9zdGF0ZS5kZWZfdHlwZSA9IGRl
Zl90eXBlOw0KPiArCW10cnJfc3RhdGUuZW5hYmxlZCB8PSBNVFJSX1NUQVRFX01UUlJfRU5BQkxF
RDsNCj4gKw0KPiArCW10cnJfc3RhdGVfc2V0ID0gMTsNCj4gK30NCj4gKw0KPiDCoC8qKg0KPiDC
oCAqIG10cnJfdHlwZV9sb29rdXAgLSBsb29rIHVwIG1lbW9yeSB0eXBlIGluIE1UUlINCj4gwqAg
Kg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYyBiL2FyY2gv
eDg2L2tlcm5lbC9jcHUvbXRyci9tdHJyLmMNCj4gaW5kZXggMWJlYjM4ZjdhN2EzLi4xYzE5ZDY3
ZGRhYjMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9tdHJyLmMNCj4g
KysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYw0KPiBAQCAtNjY2LDYgKzY2Niwx
NSBAQCB2b2lkIF9faW5pdCBtdHJyX2JwX2luaXQodm9pZCkNCj4gwqAJY29uc3QgY2hhciAqd2h5
ID0gIihub3QgYXZhaWxhYmxlKSI7DQo+IMKgCXVuc2lnbmVkIGludCBwaHlzX2FkZHI7DQo+IMKg
DQo+ICsJaWYgKCFnZW5lcmljX210cnJzICYmIG10cnJfc3RhdGUuZW5hYmxlZCkgew0KPiArCQkv
KiBTb2Z0d2FyZSBvdmVyd3JpdGUgb2YgTVRSUiBzdGF0ZSwgb25seSBmb3IgZ2VuZXJpYyBjYXNl
LiAqLw0KCQkJCQkJCSAgICAgIF4NCgkJCQkJCQkgICAgICAhZ2VuZXJpYyBjYXNlPw0KDQo+ICsJ
CW10cnJfY2FsY19waHlzYml0cyh0cnVlKTsNCj4gKwkJaW5pdF90YWJsZSgpOw0KPiArCQlwcl9p
bmZvKCJNVFJScyBzZXQgdG8gcmVhZC1vbmx5XG4iKTsNCj4gKw0KPiArCQlyZXR1cm47DQo+ICsJ
fQ0KPiArDQo+IMKgCXBoeXNfYWRkciA9IG10cnJfY2FsY19waHlzYml0cyhnZW5lcmljX210cnJz
KTsNCg0K
