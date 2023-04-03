Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7686D410C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjDCJrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjDCJqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:46:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226A312BFD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680515162; x=1712051162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=asdzuJLF2Lcoajw6G+67FEpEb8x1qCUGXYAXA08aGTU=;
  b=gzBiJxyJplzHHTjrJxy/x1s2aK/jVM8q3SAn+lrapBEQIMIkWvGkE0A3
   LQI8dqiYOnR+L1G3kROePThatE1XAPPN8+ckfEKwsmyo/FnuMqlYgArJx
   qw9hOT1vyJgeTIYZdNmKhSujzkW9g/RZZvYX0daqSYHxeQSbMEO8da2wq
   NPy7jDIauWnnfaqsHhghC9s+bDEFH1ITwMQmsVnullypEtc7vfw0JMhW5
   fT6sTAtwuy9/ebrkZV+qvJvSzHG6t4FFOjupKkLca+EsaFf49VAS7B7FC
   raDExIWnvWVPww3qkM48eK4ZqWTHbbPrDdxncHQNnNik1+S1Q9Fi7zqFY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="369661904"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="369661904"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 02:43:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="636061541"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="636061541"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 03 Apr 2023 02:43:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 02:43:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 02:43:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 02:43:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 02:43:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oF9B2Yn0x+PCaNiKrf289popVlYiM+nwxaZWPNRz2CPK5wTrzuN2UJj7FctYSccKJo4LluGNzYDbfdfOYBV1A2wjcB7RT2I06ce3SU1s9BrPS4rsOViWTxAKVUDw+nzYvM7EYMSLi/0dH/6qhp8/7rlfy7Gwo9bIfj4/4RsTiZHMrUteEPUWaPYqd8Wj404Ft49Jqy35NiOhgMy/YRP6iJdaR5RI57PYl6W39b2kkProxT/ay1COAYKoWntEKDfdxy36a60SXTOUo2Qku3VQgTHdw9nwI6IeAqoyLXK6SvUTvMkaGbKHhM9PuOu5tX4oDp6f/GX2ZjT+iHKWdXxPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asdzuJLF2Lcoajw6G+67FEpEb8x1qCUGXYAXA08aGTU=;
 b=L1BWE7DILFlkMhHjTUxHnZYGwFuJwVsiaIgzikt5/nh5lBj0PEULt4cUbpSRQYMOytuE72LGmYeIvbdS36WqusKjnBqtWgCO97mjouIK/A/cOcJ1cxZye61xiV/f1fKFTJezAth1tGYPoA3rag5jTesA6DEn2SXDbS/U3SI6sfiCWV/x8OgvzNlYdGIw/XlzOcDUj+Eqbv4fyz4pbUe/0I8RddiGEZmw17pXUxw1bMpHj34QjpRvOuzS0b2V4GTf13PJ3d60GJJHHBnbQOEgfa5tWUlOVhydJY5C9lwDBarGDuuMUmKUEQaFdHkZhdJKzrVQTcw8qYqUSEWIhJr9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB8017.namprd11.prod.outlook.com (2603:10b6:8:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:43:11 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f403:a0a2:e468:c1e9]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f403:a0a2:e468:c1e9%5]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:43:10 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Gross, Jurgen" <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>
Subject: Re: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Thread-Topic: [PATCH v5 04/15] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Thread-Index: AQHZZGR61ijUNf30fEKIHhN53WCdS68Y3l2AgABPgQCAACZ1gIAABEeA
Date:   Mon, 3 Apr 2023 09:43:10 +0000
Message-ID: <d2039843c14d04a4e9928834c4bf40ea93592d34.camel@intel.com>
References: <20230401063652.23522-1-jgross@suse.com>
         <20230401063652.23522-5-jgross@suse.com>
         <74b1b65577e0e1c3e54a5a708af2f63df132227d.camel@intel.com>
         <45062273-9550-be39-3e53-cb8b35717fa9@suse.com>
         <ee5a89965a49dab6e6946fe6b6614db60a77c8ca.camel@intel.com>
In-Reply-To: <ee5a89965a49dab6e6946fe6b6614db60a77c8ca.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB8017:EE_
x-ms-office365-filtering-correlation-id: 8052dbd3-7793-4ada-6a42-08db3427d633
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YjWIiIsJ8sDWOmFYf/f1X5+dH9NH0X7RjsAe6sgGPSBdYhZvJvYEw9d30ds+6DyJAE9kWiJL+dioitoAY8xK5KcSdLVeCQNFhrvwmVKMjCj+by57rsoXyPgQQEfOIXh2cDEO0Ci8m0Rww8V8g0HtR48qth2KXjrkYJxZzL95u54CIsjDnGXOdbI6nn9tLLfYIcCKGOitaPdeu7S8V1nWgy5dvGlYZ6q71yM7wC4VNj/xeFx5qXk5YfUZYH16BQLkRU6P7KJnhD2+IueU0Hma0llrS/Z8KdIm/6atAgAMweoFnsT/7yu1PUSxOSHDq9RoWUSTXtsZHh8OHRvwb+cGdwiNIknZQKgpIFhisgbOxlUgxCYah9PS9Vkv1nf/bOcIOZBZB7BYacQZQPRvYNVQOe5RoA3aDO9xDKzqMnOQOK7tXIXhySylmRK3GbVC30lL9ZWCf1FtO9sYDnahUncj7XRwqjpLG6430e/WIrli56vylU3yBeBdAa6Bdeeu+fcD+Q9jwCRI7xa3xFNgBUGSag+pT1753WhmvOL5byMPQxsRvJ7Dz0MhS4Q+o5za/j/fX8qofGRyUX7UsfxMe0biKutPyGEDhNeOaGQy1FlefgaEfNP8R6+9To9J/GBx4j4p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(2906002)(38100700002)(122000001)(5660300002)(82960400001)(38070700005)(66946007)(76116006)(66476007)(8936002)(66446008)(64756008)(66556008)(41300700001)(4326008)(8676002)(36756003)(91956017)(110136005)(54906003)(316002)(2616005)(86362001)(478600001)(186003)(6512007)(6506007)(26005)(71200400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFFGQ1h5UlZ1TUE0TjhJenFwOExJb24rM2szN1RtUWovT0tuK3ZqVmV4NlhE?=
 =?utf-8?B?WE43U3lEVWNpTE9Ub0dVRlJZK2o2ai9xZkxUTmNEaVNSdWw5YzZ0OVZjally?=
 =?utf-8?B?YzdDS0svekRWUjJPZmdvdGZoZWl1ajk1MS94SDZudHBIak4yLzBwVHQ3N3ZD?=
 =?utf-8?B?T01TdXVYb1J1VDFiamhSZno1TlZuRDdmN1VsQ2ZYWlVKc1BYOXN1RE4xT3RC?=
 =?utf-8?B?T1hIYkhPUStjTGZncy95ajhTd0t2K05UWFZIa09sRjNHWkZOZDd0ZWdHREZp?=
 =?utf-8?B?ZUZtSlQxMVIzRSt5ZHFidW50KzdVL0VpRlF2QzJPb1ZDWDUwdEpBMU1Ja1Zw?=
 =?utf-8?B?YWphV3FRMkpqazR4VE5oc0Z2Vm9LWVBCeGVBVVFYbzZBVlkvd0lhZS9mSEhD?=
 =?utf-8?B?dlVveEZLSjlxVUIwa2xkaExuUHVIeitrSFlWS20zbTNkdHBmcGwvQXpjZGc4?=
 =?utf-8?B?TnREKzMxdTVGOGJkQVc4MVJIZTA0TFE3UFlrSUIvT0xLUFJzdjFZb0d6VTkx?=
 =?utf-8?B?QlNjeHZTS0dYV3dKUkZKOVJJUDFaWUFKYllsN1BQejA5NXlSZWRJYjhZMVFo?=
 =?utf-8?B?RFgrdXMvVWt0Z3VVNlB2TjlxZ1FoRE9BaUY4c1YwUkhCN216TUJLUkd2YXdN?=
 =?utf-8?B?cUJoamQxRXVLamtpNGJKZ3RzSDJxRGFvM3B5ejJVN0hNL0E4Q21VUGtrMXQ4?=
 =?utf-8?B?SW9nSXVOM2JTa3RsV2gyN0JlNHNDdWlqSXVwaEdwam1wRGlvN2xJVDduNnl2?=
 =?utf-8?B?WTRiVURKNEowdnkyeWZhb1VXbFc3QThoUmhYRXdhYWpGYnVaRDRWenFtZmNy?=
 =?utf-8?B?RUkzWEU2Tzk4eTJIM0RndnVSK1RzZFgvS3BLc05mL3Z1Q1cwOGZRbWJ3d3Ji?=
 =?utf-8?B?UU8zN3QwSFpyNmVPallkdnBTQUJBU1BwbmkyWkwzdjZCazBwWDZFNVVab2c0?=
 =?utf-8?B?VjMrSUZRaDBCMGx4bG9LemdIWlY4YkxsWjg3ZWh0RjNzck1odkNaQzRhQ2lw?=
 =?utf-8?B?TmxVS2JHWjRiUHFrdjRDRk1OOW9VUm5weUlvTit2aTh1Yk9LblpDWW5CL3k5?=
 =?utf-8?B?SFlQZlp3SGJYaWF6L2c4dVNnWm9RRXRYeFNrL1hRNTVuSXN6TXp4THJJU0Rj?=
 =?utf-8?B?NkxFSG1QR2lhdGJlMjZtNC9uREdKNjFUbXMwUlhKS05GUnNLRGtNNStJSHc3?=
 =?utf-8?B?ZERaVC9WZ2VDcTMrblFSMW4vc2llcFBtM29WWFY4bTNkT1NuN29RdmQzcU8x?=
 =?utf-8?B?REdQUHF3a0N6d3FFcVRIbDhFcy9aVFVLaGpJZXBYd0ZWSWU0bFpxRVRya05t?=
 =?utf-8?B?c1F1d282RVlIWG45T2NXSnIvTmQwZzZDUnVsTDFGMlM2TGZjb1AyMXI4Wk9r?=
 =?utf-8?B?VkIzOWpTWVBWVWtsditBdkNEbVZTUlNTUGF4cnEvVEU3ZjFyUlNKbmtXYVRv?=
 =?utf-8?B?WG9HVkpmNFlnd1YxNEVOWjBFU1NGZlZjeHBVWkxoY3BkQmpkR1drMFp0OFlj?=
 =?utf-8?B?MVRJbmdMVE4yOW5OVjVweWxjTkNBeDkwOHdmeCt1OEJFK1RvMGtpOGdTYVB3?=
 =?utf-8?B?OWZ6ZHNzbG1BTXh3R2Q5YVM2eGtFNDE3amJlQlJnbGlYblgxZ2VnNnUrZFNO?=
 =?utf-8?B?cFBXSWVjbSs0WVpaQmRzc2ZlU2QzSDJVWFFXbjBYQzBRMUxwWEh2SDVPVlNP?=
 =?utf-8?B?TmV3U3l2aVJoMG1KR0NqcDlXMVR2RGJ3bStWcnFkTjVmQ0pEMlJHT0xlUnFW?=
 =?utf-8?B?Y2FzNFoxaTZDMHJSS1grQ0Z1YVd6NjhxL3FxWllHR0xTRUNZOGNOQlRNUjh1?=
 =?utf-8?B?ajZqTkJVNFhrSTVnVWVsRmh0Ulc2ZVhpcUhtcnZ4Z3N2Ym1MTEhYdVlwbkk3?=
 =?utf-8?B?SkVma29wMVBLaEg2bit5aENBb3dqUVVqLzZqandKU2NrU0taUWhWWWcremVt?=
 =?utf-8?B?ZU1CcnZ0U2YyQ2ZlOVJVR1NBY0ZrM1JaRXlsZSs2d2x0YWV5M1kyQ054amk0?=
 =?utf-8?B?V2phZ2ZleFUxVk9rc3NvRDJFWW1OU0lBWE95YWZHUFFIeVNOWm9GOXFkQ09E?=
 =?utf-8?B?TDdCZktJdWtKMGc5VUdkelliWVNrV2VjRG5yZFVyRXI3RW1MWHpubFJ0UFhK?=
 =?utf-8?Q?mb2/+Zk/idokIeuZZyer6qEZt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69BD5AF940170D43985F2B4333349837@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8052dbd3-7793-4ada-6a42-08db3427d633
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 09:43:10.4738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zEwJdo/YavmNeVVaWsq4En1v90fJIp9Oj2i4KOnk5bUXmAKXqO1jCALwM+M4TbqWHPexy1bK2CNy8UEdONPmeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8017
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTAzIGF0IDA5OjI3ICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+
ID4gPiDCoMKgLyoqDQo+ID4gPiA+IMKgwqAgKiBtdHJyX3R5cGVfbG9va3VwIC0gbG9vayB1cCBt
ZW1vcnkgdHlwZSBpbiBNVFJSDQo+ID4gPiA+IMKgwqAgKg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYw0KPiA+ID4gPiBiL2FyY2gveDg2L2tlcm5l
bC9jcHUvbXRyci9tdHJyLmMNCj4gPiA+ID4gaW5kZXggMWJlYjM4ZjdhN2EzLi4xYzE5ZDY3ZGRh
YjMgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbXRyci9tdHJyLmMN
Cj4gPiA+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL210cnIuYw0KPiA+ID4gPiBA
QCAtNjY2LDYgKzY2NiwxNSBAQCB2b2lkIF9faW5pdCBtdHJyX2JwX2luaXQodm9pZCkNCj4gPiA+
ID4gwqDCoAljb25zdCBjaGFyICp3aHkgPSAiKG5vdCBhdmFpbGFibGUpIjsNCj4gPiA+ID4gwqDC
oAl1bnNpZ25lZCBpbnQgcGh5c19hZGRyOw0KPiA+ID4gPiDCoMKgDQo+ID4gPiA+ICsJaWYgKCFn
ZW5lcmljX210cnJzICYmIG10cnJfc3RhdGUuZW5hYmxlZCkgew0KPiA+ID4gPiArCQkvKiBTb2Z0
d2FyZSBvdmVyd3JpdGUgb2YgTVRSUiBzdGF0ZSwgb25seSBmb3IgZ2VuZXJpYw0KPiA+ID4gPiBj
YXNlLiAqLw0KPiA+ID4gCQkJCQkJCSAgICAgIF4NCj4gPiA+IAkJCQkJCQkgICAgICAhZ2VuZXJp
Yw0KPiA+ID4gY2FzZT8NCj4gPiANCj4gPiBOby4gVGhpcyB0ZXN0IGp1c3QgdmVyaWZpZXMgdGhh
dCB0aGUgKHZpc2libGUpIE1UUlIgZmVhdHVyZSBpcyBzd2l0Y2hlZCBvZmYsDQo+ID4gYXMgdGhl
cmUgYXJlIG5vIHdheXMgdG8gbW9kaWZ5IGFueSBNVFJSIHJlZ2lzdGVycyBpbiB0aGUgb3Zlcndy
aXRlIGNhc2UuDQo+ID4gDQo+ID4gSSBjYW4gbWFrZSB0aGlzIG1vcmUgb2J2aW91cyBpbiBhIGNv
bW1lbnQuDQo+IA0KPiBTaG91bGQgdGhlIGNvbW1lbnQgc2F5IHNvbWV0aGluZyBsaWtlIChiZWNh
dXNlIGl0IGFwcGxpZXMgdG8gdGhlIGNvZGUgaW5zaWRlDQo+IHRoZQ0KPiBjaGVjayk6DQo+IA0K
PiANCj4gCUlmIHdlIGhhdmUgYSBzdGF0aWMgKHN5bnRoZXRpYykgTVRSUiBhbHJlYWR5IGVzdGFi
bGlzaGVkIGZvciBzcGVjaWFswqANCj4gCVZNcywgd2Ugc3RpbGwgbmVlZCB0byBjYWxjdWxhdGUg
dGhlIHBoeXNpY2FsIGFkZHJlc3MgYml0cyB1c2luZw0KPiBnZW5lcmljwqANCj4gCXdheSwgYmVj
YXVzZSB0aGUgaGFyZHdhcmUgdG8gcnVuIHRob3NlIHNwZWNpYWwgVk1zIGluZGVlZCBoYXPCoE1U
UlIuDQo+IA0KPiBUaGF0IGV4cGxhaW5zIHdoeSAndHJ1ZScgaXMgcGFzc2VkIHRvIG10cnJfY2Fs
Y19waHlzYml0cygpLg0KPiANCj4gPw0KPiANCj4gDQoNCkFuZCB5ZXMgSSBndWVzcyBpdCB3b3Vs
ZCBiZSBiZXR0ZXIgdG8gcG9pbnQgb3V0IHdlIGNhbm5vdCBtb2RpZnkgYW55IE1UUlINCnJlZ2lz
dGVycyBpbiB0aGUgb3ZlcndyaXRlIGNhc2UsIGJ1dCB0aGlzIGlzIGFsc28gY2xlYXIgdG8gbWUu
ICBTbyBubyBvcGluaW9uIG9uDQp0aGlzIHBvaW50LCBidXQgSSBkbyBmaW5kIHRoZSBvcmlnaW5h
bCBjb21tZW50IGlzIGEgbGl0dGxlIGJpdCBjb25mdXNpbmcuDQoNCg==
