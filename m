Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74895741617
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjF1QMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:12:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:22202 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbjF1QM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687968749; x=1719504749;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QzFsJRt5cXPjlWSoF84zm+V390fVOklzem7lZGh3VrI=;
  b=UD6wTWMSLWgJwved9YUXPOJL2P/Yshw6u7l1W6VsO83s9fzL+7LjpTJL
   cXPAZD79HS9nzglo6j/l08PYdOlgZI8bazzpdJjR5VY/D2RMoERfW87gj
   E3lTTqo3/D/2pVOljCc8T8UDg3UsqZzNdP27I2g8JElksmkKlMSh9lrg7
   aJ097HzpXF5ZJ9yQh8zwS9tEcxucKI8Ra57i7aB8jYL3XdYb4CbUtk+F5
   DP9huZzfXpm9g3EsIE+ncFKrDh84m5/ajRpZTPLCR55w+rDgV4DBC9Y5O
   W+kQPvdMOyv9Zy3pMb6xFXHQ0ML0iFHMYyeFGgqsNmAWS1oLCJPJvdv99
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="448273987"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="448273987"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 09:08:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="841127072"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="841127072"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 28 Jun 2023 09:08:28 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 09:08:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 09:08:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 09:08:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+Cy+TVAbbDJn9fnp9T6fdbrgO28NSW0lyg8EOe+vxi2E3NII/WJpFDEPhevjvzNVbQWOY9G9ytnRwlNQnlgTKc4cJI6+uofVYey6FwSXQBRGd1ajfTw7nlusg8UwX3BKg+ndKndFUlwEEUgn6N9kbYPo3TUTa6Ac9NOrZkhBVb0XSl8hwtncZzcADaV8X4kYNbD2c/keJONSibMulxsOExKZ/+kSEl2Dmqjd7JSkhpfYJOUpjyiWz6A98PTajZ+NDd8bXeaKU7hT4SyXhfKvYobUoJFWaxo6iZ+wdRNtTHUrLpSTNgG4Rw0vFrZKiC+FROP4rtUOT5uL4ptwux6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzFsJRt5cXPjlWSoF84zm+V390fVOklzem7lZGh3VrI=;
 b=ktYNROQFjhxUOU/I02VcYCrZK+w80dRYz4HIDznfewsKCUO1OZlhDfiMtQgtm/gFfNulg0DfM3/GoaBl/r1wvLiPgWUGJu8ogCxMODfM3oh7XxK2MSG4XQKlJ8G4MqnXc8ecit5HqbBqkGLVg9IWBrk/8VSyGTGu5Q74Em2WoOyka+Lo0BjFAhdE+nx+RXm0Ug4e2XItqOaywpmd7x4xC0vJqvq00dVhmLf45WRzAUdPYoFeYdfD9SPXKKmBJQKolRs+Hv9lk1warPwqUeKucmHJwsO0LchkkP0wqx9MmKlciqDbVvjN3T8T8TqpnAntCZOWt1ns39zbY/RwvCQwcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB7050.namprd11.prod.outlook.com (2603:10b6:510:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 16:07:41 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 16:07:40 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Newman <peternewman@google.com>
CC:     James Morse <james.morse@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "Pitre, Nicolas" <npitre@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "aricciardi@baylibre.com" <aricciardi@baylibre.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Eranian, Stephane" <eranian@google.com>
Subject: RE: [RFC PATCH 0/2] Resctrl - rewrite (WIP)
Thread-Topic: [RFC PATCH 0/2] Resctrl - rewrite (WIP)
Thread-Index: AQHZoyiDuZCsHP7U1EeCATLJj0kK+q+gA5iAgABnpeA=
Date:   Wed, 28 Jun 2023 16:07:40 +0000
Message-ID: <SJ1PR11MB6083BF7C63A699E5FA83858EFC24A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230620033702.33344-1-tony.luck@intel.com>
 <CALPaoChfFSKiWeVC39wFoxUXG+hYU3_HQtCU6AQaB+kAYh3ffg@mail.gmail.com>
In-Reply-To: <CALPaoChfFSKiWeVC39wFoxUXG+hYU3_HQtCU6AQaB+kAYh3ffg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB7050:EE_
x-ms-office365-filtering-correlation-id: a327e1bc-8d63-4655-bd3b-08db77f1cc70
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W946Tr0W3EwpbYmSDk8Y6zkRwBwFV69z2DjMnYF1lUuO4XW0eT1Q1Um2olGtQg7moKyzT7L7SChHgDl4AALe/SFco/H4otGMarSCVHQVg+RYXopvBHAueGnIwPI7ztqTqWvuSGT1Rvcpyg6ELB62fg0hBGWKjvA3mxNjWPBFGT/BDVMGjv+FI2lVzqpAIABDAHpiTsulKfjwpP/n/I3a9+XtXZhB1Gq48cybYT5CSp53WGroY/p6QWrBkA37I+CXGcvMjaPwA3g53mQWtkT+AzCyR6ULhMpq1TUkebrRwrWiGVtIUFlEzzydWrF+tW3nIPLnPfi8IoHCTaHiCEfS8fs78ifC0oOjhKruh6Ikq6mFhT56oAIfpAxcomCDz/ZsLGX5ytKksLmuc2C8h5yFYqbiWlpAJeNQnONQ4xL/SQScX7AXB8Jdb5KQy/6yZLjpeXeeaJCVfxIJZUD/X6xCMXiChWSDb82iCw/x7nWSPObBuh500POd+/eGsUuHLCQ8n/Qa2ssB7bBAifo2uV9baqfs5oNxDWhs+O755tOggqnG1ONrEJ7itDEucoUc23BqATel4IXYPqjA7cexioOMHdGfD3q/ts0gt7BH2NF/Mw0g6tGESZfhm0RPNl5S3Lla
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(66446008)(38070700005)(26005)(66556008)(66476007)(33656002)(122000001)(6916009)(5660300002)(52536014)(7416002)(86362001)(8936002)(41300700001)(4326008)(316002)(8676002)(82960400001)(55016003)(66946007)(64756008)(38100700002)(76116006)(6506007)(9686003)(186003)(2906002)(83380400001)(71200400001)(54906003)(7696005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cC9lL2YyM2ZXRWZwYk5jUytHeGtzeXNxWlB3YWZIV3h0WS9QQkFRajdQcjU3?=
 =?utf-8?B?SU1aUjNyZEpCU1V5eHZFcnFOR2ZlZTB0bHZBcXdncW95eVFDU2QzUkhsZnhH?=
 =?utf-8?B?ZW9RVGtRM0ZOMlBCM0pWQ0RiYjZMY3dBM0lXb21aRlhQTURsamNpaEc1Nm9V?=
 =?utf-8?B?L21ZZFhvNDlsazl3L1Y5S2Nna2VneGRsb1Q4WUtVR21LaFEvaUxaUkN0ZENQ?=
 =?utf-8?B?Skt2bDAxTlk1SjFKYytTbUJKSmthbSs4VkpKQ1Fva0RTdlovNVZLTjk3ZmNi?=
 =?utf-8?B?TFIxeVBSKzc4b2dtU2pEKzl0VWk3YkFQMXdmSkcrbWRyQjR0d3pYWEtadHdV?=
 =?utf-8?B?bTdSNlNsTjdtN1lPbzJwYzdXeUxhc09EM1pqcmZPUWpHOEN2NVlqcXArUFRF?=
 =?utf-8?B?eW5Ma05EYTNNR3BEQW9TL2IyMzBxaVlxSmFManUzR2VMbjdxdTd5Rm9Hb1VN?=
 =?utf-8?B?QXlvTmxFRWJuU0FFdDdyMjBCelFOM2RNOFdJdGJweTFpUURmNjdrU3d4WVdV?=
 =?utf-8?B?UndOeUhMYWxzZ0U1QWFvejA4aFF0bGZxUWljTVBvcVlFa2hSOTVEUFZSVFBp?=
 =?utf-8?B?RnE2cExrU2RJdWZjaWF6TDJSTXJ4R28zWXREUlhpL3cyNTg3Q0x6RFViN3lX?=
 =?utf-8?B?cnM2bmNHdms1a1Y5Z0EzZVlSNjNDLy9pVFhROWppbXp0TTlzRGJyWDF0L3Zz?=
 =?utf-8?B?VncxTDZSQ2VPUUhxY08rSnpOVUVTUVJLRzlIeUZ5emlpTWlHdEtYUjE5KzQ2?=
 =?utf-8?B?elRqa2xycGVPajZnbzNKbTE1WTJYQ2J2MWtQSHYzSlVNRlJQS2ZIdXphSjRH?=
 =?utf-8?B?bUJyLzZ3Y0VLQkhEQm5leGg1YVlWclFTQWdGQzhFbVZVUUJBczM1NE1vbTg5?=
 =?utf-8?B?YU9ncXg1TlAxUURLM1BHS1p4dmoweHMzdGlyL0x1OW9xbnBZdkN1MU1VN253?=
 =?utf-8?B?NHBRWEZsMnVBNll1QjhJZlgrRktEOXlscGpiV2xGejhZNDdoWlRuNlZHSm4x?=
 =?utf-8?B?a0RXbldHOTd0Z2RDcCtXKzhCNzRtUDlINUllczcrUkxTaTQwL1c0NWYzTm9q?=
 =?utf-8?B?QlpkWTVSNXV5cUxMVGVFRnlIbUtNdWRJUGFWcEYxUCsxQlNUeDJyM0V1Ums1?=
 =?utf-8?B?WHdYZ21SWEh3Q2s4ZWE3TUlmbHBoYVVuak5tV1IwTmpiNkZjL09ZTUtMcm14?=
 =?utf-8?B?bTVadkZkZ3pETG5tUVlRQSsvNHp0LzdhOTVSR2k4VmdZRXB5SnFPYmM2LzlT?=
 =?utf-8?B?VU9EWWFzcXZWTlMxK2hnTS9vdTFjK01leEYrK2RYODVseUxDSkMwcnZlWFNI?=
 =?utf-8?B?cVFuTDNmTCtNdDEyMWNBMFhwRzJLa3dZVkkyMkk2L2IyenBkaDRaQUF3Zi93?=
 =?utf-8?B?c3liZmNPbUl4U3Y1R0RCbnVRV29CdklIaGJsOSs5ZTBPOHcxRzBHc3kxRDdq?=
 =?utf-8?B?YTExSEl2Z0x6ZTVzZ0o2Y2kwM2tHczJTcko0czlkMlFOVEFhcjNMc1p2Q1Ar?=
 =?utf-8?B?UDhBZG95L3RadStmR2lEVHZvdk9aeFJSNUh0QWZiOUhqU1E1Y3g3U1R2NHBV?=
 =?utf-8?B?Q1RvOWNLWDIzMnY4QlNHYStJM2RURDI0c1M2bVo4WVIzL01iZTFnclFjN0lm?=
 =?utf-8?B?OE1UUmRyb3dkUmlWS0NrQXF6a2JBMFBHZmpoUnIwSFd0di9jY3UwWFY5RXFI?=
 =?utf-8?B?VFpkV1E2TkhCRzRVZnZuRUJ4M1VJL1V1ZzBWZ0xrbVFTb0VqOFlaSnRkUTRP?=
 =?utf-8?B?QVRNaldyTmttaFdZcUoySTFScmpVVXlmMC93bkZCUEtzUUgwSUxwNC81bTFu?=
 =?utf-8?B?K3JOR2JQa2ZnM1l2TTFyb0FBZW5EWk5KbnhpY0VlWjVJZ1lhd0JzWUgyQ2ZG?=
 =?utf-8?B?QXdUNGkzbjBmMXNhUUJSczRtRmN0aXJhekRNYkVjelR0SjZtWTZwbjdFY1NH?=
 =?utf-8?B?OWRiNVFDNklnU3l1Zmh0bkZHUDN3OU9zRkVrZ3Y5SlROQzZqcUNKTE9RNUww?=
 =?utf-8?B?dWV2aERFWk9YcWJ5elkxVDNjMWhMZU85MWt2cEN1U2VOd3poYXJrOXAzd2VP?=
 =?utf-8?B?RVdpQzVLYjE2cDJ1aE1nc1NWSDE1NnN5Q1pLMUlrM0R6NnFacC9NL253TjJH?=
 =?utf-8?Q?EiuY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a327e1bc-8d63-4655-bd3b-08db77f1cc70
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 16:07:40.3367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+Q+Rc6gE62zi6Xhne9oo2dZLgFKdPWLQ84bDHxDX71+El6dEl4IaA0cnRVHeyAXpn6m6qpd89EPtnaW2Lar/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7050
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGFua3MgZm9yIHdvcmtpbmcgb24gdGhpcyEgSSBwbGF5ZWQgd2l0aCB0aGVzZSBjaGFuZ2Vz
IGxvY2FsbHkgb24NCj4gc29tZSBvZiBvdXIgbWFjaGluZXMgYW5kIHRoZXkgc2VlbWVkIHJlYXNv
bmFibHkgZnVuY3Rpb25hbCBzbyBmYXIgYW5kDQo+IHdhcyBoYXBweSB0byBzZWUgZHluYW1pY2Fs
bHkgYWRkaW5nIGFuZCByZW1vdmluZyByZXNvdXJjZXMgd29ya2luZy4NCg0KVGhhbmtzIGZvciB0
YWtpbmcgaXQgZm9yIGEgc3BpbiBvbiBzb21lIGFkZGl0aW9uYWwgc3lzdGVtcy4NCg0KPiBJIHdp
bGwgbmVlZCB0byB0cnkgd29ya2luZyB3aXRoIHRoZSBjb2RlIHRvIGdpdmUgaXQgYSBzZXJpb3Vz
DQo+IGV2YWx1YXRpb24sIHRob3VnaC4gV291bGQgeW91IGNvbnNpZGVyIGl0IHJlYWR5IGZvciBt
ZSB0byB0cnkNCj4gcmUtaW1wbGVtZW50aW5nIHNvZnQgUk1JRHMgb24gaXQ/DQoNCkN1cnJlbnQg
Y29kZSBpczoNCjEpIExhY2tpbmcgbG9ja2luZyBmb3IgYWNjZXNzIHRvIGZpbGVzIGNyZWF0ZWQg
b24gYmVoYWxmIG9mIGR5bmFtaWMNCmxvYWRlZCBtb2R1bGVzLiBTbywgSSBleHBlY3QgdGhlIHN5
c3RlbSB0byBjcmFzaCBpZiB5b3UgdW5sb2FkIGENCm1vZHVsZSB3aGlsZSBzaW11bHRhbmVvdXNs
eSBhY2Nlc3Npbmcgb25lIG9mIHRob3NlIGZpbGVzLg0KMikgTGFja2luZyBlcnJvciBjaGVja2lu
ZyBhbmQgY2xlYW51cCBjb2RlIHBhdGhzIHRvIHVuZG8NCnBhcnRpYWwgb3BlcmF0aW9ucyB3aGVu
IHRoaW5ncyBmYWlsIHRvIGFsbG9jYXRlLg0KMykgVGhlIHVubW91bnQgKHNiX2tpbGwoKSkgY29k
ZSBoYXMgZmFsbGVuIGZhciBiZWhpbmQgZGV2ZWxvcG1lbnQNCm9mIG90aGVyIGZlYXR1cmVzLiBT
byBleHBlY3QgbWVtb3J5IGxlYWtzIGlmIHlvdSB1bm1vdW50IGFuZA0KcmVtb3VudC4NCg0KSXQg
c2hvdWxkIGJlIE9LIHRvIHBsYXkgYXJvdW5kIHdpdGggdGhpcyB2ZXJzaW9uLCBidXQgdGhpbmdz
IHdpbGwgZ28NCndyb25nIHdoZW4gdGhlIHN5c3RlbSBpcyB1bmRlciBzdHJlc3MuIERvIG5vdCB1
c2UgaW4gcHJvZHVjdGlvbiEhDQoNCkFsbCBvZiB0aGUgUk1JRCBhbGxvY2F0aW9uIGFuZCB1bmRl
cnN0YW5kaW5nIG9mIGhpZXJhcmNoeSBiZXR3ZWVuDQpjb250cm9sIGFuZCBtb25pdG9yIGdyb3Vw
cyBpcyBsb2NhbGl6ZWQgaW4gZnMvcmVzY3RybDIvYXJjaC94ODYvcmR0X21vbml0b3IuYw0KSSB0
aGluayBJJ20gbW9zdGx5IGRvbmUgd2l0aCB0aGUgZnVuY3Rpb25hbGl0eSBJIG5lZWQgaW4gdGhh
dCBmaWxlLCBzbw0Kd29yayB5b3UgZG8gdGhlcmUgZm9yIHNvZnQgUk1JRHMgaXMgdW5saWtlbHkg
dG8gbmVlZCByZWZhY3RvcmluZyBmb3INCm90aGVyIGNoYW5nZXMgdGhhdCBJJ20gbWFraW5nLg0K
DQo+IEknbSBhbHNvIHZlcnkgaW50ZXJlc3RlZCBpbiBKYW1lcydzIG9waW5pb24gYW5kIHdoYXQg
dGhpcyBtZWFucyBmb3INCj4gdGhlIG9uZ29pbmcgTVBBTSB1cHN0cmVhbWluZy4NCg0KTWUgdG9v
LiBJJ20gaG9wZWZ1bCB0aGF0IG15IGNvZGUgY2FuIGJlIGEgYmV0dGVyIGJhc2UgdGhhbiB0aGUg
bGVnYWN5DQpyZXNjdHJsIGNvZGUuIEJ1dCBpdCBuZWVkcyBhbiBNUEFNIGV4cGVydCB0byByZWFs
bHkgYXNzZXNzIHRoYXQuDQoNCi1Ub255DQo=
