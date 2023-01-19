Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA02673E59
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjASQPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjASQPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:15:01 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534DF4ABEC;
        Thu, 19 Jan 2023 08:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674144897; x=1705680897;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OJ/ul4YpqbZY3ACta4jyzIXySdD9rt3CGcDSZWiEEdg=;
  b=FYDVV1/3noWRyVlcrtA4yBLJ59dk40mBirmbHLSWgYN89dkB8PWpf7Lp
   ZPrNew2EIKxe3UQ7CY0sRwYmANcZSfHyQ0+FpAN1W5kBNpDpHG9Qu5Fmv
   v2vXICd14VmrhRrtvYhrC4UqJXL3srAIXRpGq/Kf1BF43GvmOMHi+GlWJ
   +ZwHcAWem8gBLJtYpoi9MTin6dhu92RITV7SV6xhL0qFIpfBCsnJ6Dgjx
   Cqpe8JShUAsY8B7k9ICmZMGFkOtf8lfNdkUG4ESStKteUf/mTSb/usZmN
   L9sJKMB6XwdKZIqY1VEFyszAHEKdrB3SkGDJv8pypca9rKF3nMgfQfDFG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305697348"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="305697348"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 08:14:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="637753583"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="637753583"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2023 08:14:01 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 08:14:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 08:14:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 08:14:00 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 08:13:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WN/0rcgEZQee/bPc8ll98cdRUQEB+LJix2Y3y1/eDFX7vB7KJj2Dw/BvgKNc7W85DFOloBgkOzO4Xg52BD8c7h+Z3cWsRLlwcqa8ZQNhhPcF8LTolIuKRkCjI9JT7U9f/kkDsZZtmoS8RpZOw2o9KzDuGNaxggSZctuunJrOm3jdchnSD2xvz9DJraosbbMjcSmeq+TkEs1QRVrZC0DAJRCcG3ehWGGkyjKiO8a3VQoN2Lx0kaSmdikI7qHIwG/5C+cWWI6FCfuOctGPbmGHpdfLLUQnNxbyzv8OnNwN++VVln/0pV01Rwt2fJj4HkFA46lB+f2++ZjcXYeY8ccS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJ/ul4YpqbZY3ACta4jyzIXySdD9rt3CGcDSZWiEEdg=;
 b=gAw7TM+6ntSBQ/vhnsxqFRBnITiEUqpW5xstvyiFli69GIZZSjcvYI/my2zyO9YqsYcGS5vdk3rMvaZlX4ATMiy44G5ZS/SWP/VpqpLU1TZYgioYbEw1rg8avO2iqVb+Cr0zyi4ZoNzepnzNPSUlCJ91fqEp2UwKtsStPlEABLKiLpIEO+tEEYcFpBcs6zxaqZVpGqxISFbetxZrlXbJgPV02xRJd8WKTMQGokaS6Jy3BMhH3nARgJlZmOI0noR7iLAQjuPBbsfAd4roCcQvainOo0UWF00x+rtjupe4i9eEtsFiXzd7ZgvKJih0Eq79fsivSAWTn9mB7X2cj6wUtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by IA1PR11MB6268.namprd11.prod.outlook.com (2603:10b6:208:3e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 16:13:57 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%5]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 16:13:57 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "noltari@gmail.com" <noltari@gmail.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
Subject: Re: [PATCH] intel_idle: Add RaptorLake support
Thread-Topic: [PATCH] intel_idle: Add RaptorLake support
Thread-Index: AQHZK9QM69Ctt/8BWU2kz43rXhq0Oq6l6maA
Date:   Thu, 19 Jan 2023 16:13:57 +0000
Message-ID: <c79904e98b86b68c87add286aa1487b3f81712b6.camel@intel.com>
References: <20230119070205.90047-1-noltari@gmail.com>
In-Reply-To: <20230119070205.90047-1-noltari@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|IA1PR11MB6268:EE_
x-ms-office365-filtering-correlation-id: 28507c62-c44b-413c-7b00-08dafa382b09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y0N8JB51TxkJIb1es+YkYfLLZmT2xKAibsfWnRUTp+msuEdGGG2YuRPbgMPxhQB8ixtg/cwTZpDx4i6/JqgAGGzKUpZXas9WOcYQOJys86ZYkqlAPbiFyqxlSFhCzrKiBK57wBum7Q1jyIDPPT0a1eRhTS1uWtsNIrzelSGMr6kilLw+A+oXsWQtTZegf2XZocWJ4heDt9v9P15ouFP+I2VaS+KWz7Q0tTQYnYpKwjAr+jQKQXqT5xWzi79Myhb4bcDuP78E0bsfVwjuOMe7BoDpXIkPNo4n2etGnPc3E9sBvCj4WBrGeoSG0lQxWdWNg16lUA3/RbdssMQ+30xZ7cFvlGiz7BGbB1wFQ4DaqoL8wjZBkTa3BeuAkHsRMBqQVLRQLcbGPdyTTHxeN1NCpe+PG3MQNyfJS3ktUitO2goJ+ia1mGQKeZ+XQvVErdvCKpsrABOfMUIhS/hrHFwnXvxGI9NMRednM/uF9+3btFppIJsr9r3VjRL4Ew958UC9zzOmEVw+WT9TfCqZHcBCRaHUma1+QBIaYnXDDVrhAA8c255Sk6bVI6hJ7BCZbew8fGN2qGxcGs3//yM+GXh/Ad7iy9hxnXoqMCQzBrA2deOxQ5QkPWK/78SWqpIzGt4CO3TkA/UU+FqdyISuZ2JtZIsVrabJjapOAbjQqtP8PM3uoEXZnR3oBy9WPKxTwNIZSQVv46uusJeOeaqBRH/6/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199015)(86362001)(66476007)(76116006)(91956017)(2906002)(8936002)(82960400001)(122000001)(5660300002)(66556008)(38100700002)(66946007)(316002)(110136005)(478600001)(66574015)(71200400001)(6506007)(4326008)(38070700005)(6486002)(36756003)(8676002)(66446008)(64756008)(41300700001)(26005)(186003)(6512007)(83380400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmNIeGhzMUtiaXJmZFM3eEVOV1BxeXJnaE4xelVpekpRWFdRbHhOcHR3NTdp?=
 =?utf-8?B?Z3ZiTTdray9lOHZsWFJ4L0t0d2MxbXlUOTVVbTBHblVYUWEzSFN1TU5QRzlE?=
 =?utf-8?B?WWpabC9LSklYRytpcStaV0tSVldoUkYwYStuaGMzNDFaaVlPZjdoaVhCS3Vn?=
 =?utf-8?B?RGxLRVZGWjdRZG1iaWJqUXZFWHFWKytJRTJVallpZWREeWhmWmFSNTRQTmZs?=
 =?utf-8?B?TWNXT2hVWXB1S1c4a0dvMnQ1eW5OOUZtUW91RTNoS2ZDTmJXWEJLRXN4ZzBw?=
 =?utf-8?B?a2hwYnBPcTl2bnFIbEdJTnkrN0ptRWZqWlBzdXpEVG1pS0premZuRC9wdDlN?=
 =?utf-8?B?TWJ6d0RxSkZ3K0ZWY0VidHFNZkdXQjlCN1dySHFHb3NVc1hOMHMxd0p5eElQ?=
 =?utf-8?B?dGtydk9GNmRtakNTUVNVanBEeEVJQlRiSGlmajhYRERsVjl2aVNYbzlieWtK?=
 =?utf-8?B?aGdBbDJzclZOVUE3eEpaS1BzR2dLOHZINVppT1ZnSzc5V2YxZExnRzY2eDMv?=
 =?utf-8?B?eGdadFJZVjlhWFMyN04vV25XVnNUSEh2WHozNzdCSFNoM3N2RTYvYmdlZ1R0?=
 =?utf-8?B?U2FtUlA1R1BXWk1CSEpYVkIzUGRucGN0dUI4OXJ2MmFwd3hBWWRxQjlTS01M?=
 =?utf-8?B?ZktGMlV5ZTJiVjZnRlB0R3hDK0NJZTlEMGlZMUtqaE1iYmVWdk0xbVlLM015?=
 =?utf-8?B?NkNQd2NIbzV1NVliWGxla2h1aml2UUhqamN5Vm5vTDBOVUtMazNwdWlHM3ZP?=
 =?utf-8?B?a04vZitRRUFPWGkzQmVzUS9FbDh0WUVPUklKOFV6SSttL24wWWljTzRXbGJm?=
 =?utf-8?B?aXdYcjdXVHZtTDN2M0xISDRSWTFVYlVjY1J1V0FqOEMvdFRZeGJTWG5nTkpN?=
 =?utf-8?B?cHAzQVg4d21hTjRJb1NXZU1UZVJkZnZmRWtTei9lSXVFZ0JKZndGL01kVGly?=
 =?utf-8?B?eVJHbUxnajRESzR0M1BreFFtNWFwbVlpUzlhODBxb3hoYzB3a3J2ZFVZVENt?=
 =?utf-8?B?WWhHNWRUZjdxbWRYVVlYNEg3Rkt3dmpPTkxvV3ZwS3VpWDkrL2Y1bnhDN1Ew?=
 =?utf-8?B?ekFLeWZhTEVnZTNvQjlHekVLQWtDU2NMVjhFMXpxblFVTXk0OEVjMmo5SWo1?=
 =?utf-8?B?OFVBTGYvY2JZMGpsOGo2T0JmL1hPYTBzVVgvRlFtYllndWc4SWlTancvNEcz?=
 =?utf-8?B?RnBoT213ZjdneE1oSkRMWVgrazdTZHkyeTRHSlJnTHRkaDB5ckhBVjUvM2xt?=
 =?utf-8?B?ZFZONnpGc3VuTWNNM2NOTVlXVjlKNVVMdGlwNURFNVRKZDA0blpBekhDNFpB?=
 =?utf-8?B?UFNWZHFaQjczOFlPQUFWUm5iMFk1T0lDd2pDSktDanUvb0RxTnFqZkpQNFpp?=
 =?utf-8?B?TXpEUmFENUI5bHRtcExOSEMwTXROMkJIOFBOaWMxd0MyVUJrU1BKNWx0Q2g5?=
 =?utf-8?B?bWdqblJvYzBsbS9QQ01KcGdMN0l2SUdkUFYrQm5walpFaDVhWlErODZpN1ZD?=
 =?utf-8?B?UXEyaE5OTDdXMFNBVXE1aWlDYzFaWDFUSTZyQytJY3EyZWxoMnlLMkEyV0di?=
 =?utf-8?B?UTI4VXBObGZXbnNXSDNVTW1VUkROd3Zlcjk2MFd4WUp2Q3VtQWh5blRaQU1o?=
 =?utf-8?B?U2lTRDVhT3dlZVhzTjg4T04wdU8vR050c05iaWkwV1FMaE1lWTd0VklJUkZj?=
 =?utf-8?B?UUlBdjd3VEIrdFBMOUErVVFuRzZWTTlaUlJrMGFxZ3lqUjFXTGo0ZDl2SFFJ?=
 =?utf-8?B?QU5qMlFzckNjcmZzeSttd2xUMi9QL0hWaXBSSWIrSHZGTEZHQmtHdlBpV1Vl?=
 =?utf-8?B?SmIxd2lDbHhOWmgwc1FtYW8wN3Y1N2dVc3huTjh1UStWTC9IMDFHVkJOV2tR?=
 =?utf-8?B?RTFiSi9TL0F3Qjlzc2tHbWVtSHRaYVBnS2lvckNxSFJFRlJ2SHFHNHNmdTJz?=
 =?utf-8?B?M3hwSHhKT0RuOVVWUGdyU1BKZFkva2FPc2xZZE1VZXlJaDZpMzlvbmY4bHJ3?=
 =?utf-8?B?ZXhEWW1oNFp1cmlCN05YaXhTeGdFeTZLUnE0eldDVzB6UjJ5THhnb2VrUzFr?=
 =?utf-8?B?cGhzU003VkZjTCtmOWZZaTBGejVIWmJvNHhUUEhhcmlnSkNydTJRanFtYWty?=
 =?utf-8?B?YkRHUlJMdGdSRTdSSDV0cDUxbGw1dnVzV2JwSUlMZGg3NVVib3BqSHl4TjlB?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FD6387A63A3F1449206896DE1181ADC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28507c62-c44b-413c-7b00-08dafa382b09
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 16:13:57.2875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8vAYbGGsEX0n07BsXaGtRuQiv9uoYvW+OfEdRBktWDSOK06O6tVOUZ1gc7FUb4nDkTuuX2fCNEl9XmC6loKew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6268
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAxLTE5IGF0IDA4OjAyICswMTAwLCDDgWx2YXJvIEZlcm7DoW5kZXogUm9q
YXMgd3JvdGU6DQo+IFRoaXMgcGF0Y2ggYWRkcyBSYXB0b3JMYWtlIHN1cHBvcnQgdG8gdGhlIGlu
dGVsX2lkbGUgZHJpdmVyLg0KPiANCj4gU2luY2UgUmFwdG9yTGFrZSBhbmQgQWxkZXJMYWtlIEMt
c3RhdGUgYXJlIGNoYXJhY3RlcmlzdGljcyB0aGUgc2FtZSwNCj4gd2UgdXNlDQo+IEFsZGVyTGFr
ZSBDLXN0YXRlcyB0YWJsZXMgZm9yIFJhcHRvckxha2UgYXMgd2VsbC4NCg0KUlBMIGFuZCBBREwg
aGF2ZSBzYW1lIGNzdGF0ZXMgYW5kIHVzZSB0aGUgc2FtZSBtd2FpdCBoaW50cywgYnV0IHRoZQ0K
bGF0ZW5jeSBvZiBlYWNoIGMtc3RhdGUgYXJlIHN0aWxsIGRpZmZlcmVudCBvbiBkaWZmZXJlbnQg
cGxhdGZvcm1zLg0KU28gd2UgY2FuIG5vdCBqdXN0IGR1cGxpY2F0ZSB0aGUgQURMIHRhYmxlIG9u
IFJQTC4NCg0KVGhlcmUgaXMgYW4gZWZmb3J0IG9uZ29pbmcgdGhhdCBtZWFzdXJlcyB0aGUgbGF0
ZW5jeSBvZiBlYWNoDQpjc3RhdGUgb24gdGhlIFJQTCBwbGF0Zm9ybXMuIEFuZCBiYXNlZCBvbiB0
aGUgbWVhc3VyZW1lbnQgcmVzdWx0LCB3ZQ0KY2FuIGRlY2lkZSBpZiBhIG5ldyBjdXN0b20gdGFi
bGUgaXMgbmVlZGVkIG9yIHdlIGNhbiBqdXN0IGNvcHkgdGhlDQpwcmV2aW91cyBwbGF0Zm9ybS4g
SG9wZWZ1bGx5IHdlIHdpbGwgaGF2ZSBhIHBhdGNoIGluIGEgY291cGxlIG9mIHdlZWtzLg0KDQp0
aGFua3MsDQpydWkNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IMOBbHZhcm8gRmVybsOhbmRleiBSb2ph
cyA8bm9sdGFyaUBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9pZGxlL2ludGVsX2lkbGUu
YyB8IDYgKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYyBiL2RyaXZlcnMvaWRsZS9pbnRl
bF9pZGxlLmMNCj4gaW5kZXggY2ZlYjI0ZDQwZDM3Li4xYTM1Yjk4ZDliYWUgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvaWRsZS9pbnRlbF9pZGxlLmMNCj4gKysrIGIvZHJpdmVycy9pZGxlL2ludGVs
X2lkbGUuYw0KPiBAQCAtMTQyOSw2ICsxNDI5LDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB4ODZf
Y3B1X2lkIGludGVsX2lkbGVfaWRzW10NCj4gX19pbml0Y29uc3QgPSB7DQo+ICAJWDg2X01BVENI
X0lOVEVMX0ZBTTZfTU9ERUwoQUxERVJMQUtFLAkJJmlkbGVfY3B1X2FkbA0KPiApLA0KPiAgCVg4
Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKEFMREVSTEFLRV9MLAkJJmlkbGVfY3B1X2FkbA0KPiBf
bCksDQo+ICAJWDg2X01BVENIX0lOVEVMX0ZBTTZfTU9ERUwoQUxERVJMQUtFX04sCQkmaWRsZV9j
cHVfYWRsDQo+IF9uKSwNCj4gKwlYODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RFTChSQVBUT1JMQUtF
LAkJJmlkbGVfY3B1X2FkbA0KPiApLA0KPiArCVg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKFJB
UFRPUkxBS0VfUCwJJmlkbGVfY3B1X2FkbF9uKSwNCj4gKwlYODZfTUFUQ0hfSU5URUxfRkFNNl9N
T0RFTChSQVBUT1JMQUtFX1MsCSZpZGxlX2NwdV9hZGwpLA0KPiAgCVg4Nl9NQVRDSF9JTlRFTF9G
QU02X01PREVMKFNBUFBISVJFUkFQSURTX1gsCSZpZGxlX2NwdV9zcHINCj4gKSwNCj4gIAlYODZf
TUFUQ0hfSU5URUxfRkFNNl9NT0RFTChYRU9OX1BISV9LTkwsCSZpZGxlX2NwdV9rbmwpLA0KPiAg
CVg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKFhFT05fUEhJX0tOTSwJJmlkbGVfY3B1X2tubCks
DQo+IEBAIC0xODY3LDYgKzE4NzAsOSBAQCBzdGF0aWMgdm9pZCBfX2luaXQNCj4gaW50ZWxfaWRs
ZV9pbml0X2NzdGF0ZXNfaWNwdShzdHJ1Y3QgY3B1aWRsZV9kcml2ZXIgKmRydikNCj4gIAljYXNl
IElOVEVMX0ZBTTZfQUxERVJMQUtFOg0KPiAgCWNhc2UgSU5URUxfRkFNNl9BTERFUkxBS0VfTDoN
Cj4gIAljYXNlIElOVEVMX0ZBTTZfQUxERVJMQUtFX046DQo+ICsJY2FzZSBJTlRFTF9GQU02X1JB
UFRPUkxBS0U6DQo+ICsJY2FzZSBJTlRFTF9GQU02X1JBUFRPUkxBS0VfUDoNCj4gKwljYXNlIElO
VEVMX0ZBTTZfUkFQVE9STEFLRV9TOg0KPiAgCQlhZGxfaWRsZV9zdGF0ZV90YWJsZV91cGRhdGUo
KTsNCj4gIAkJYnJlYWs7DQo+ICAJfQ0K
