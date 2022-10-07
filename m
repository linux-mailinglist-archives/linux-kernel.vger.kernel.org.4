Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1485B5F7D23
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 20:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJGSJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 14:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJGSJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 14:09:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3D686F81
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665166132; x=1696702132;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dpNsmOQitMfjiFV6253KhYaCKSpF0Aq1K/bSL5Hs+hU=;
  b=MGpD/7hdkKeVMeT7cGEmNnXBiBrcBWW6y2PvIhViaFwFV1zoXV6BEAt7
   F1GhexpL/INARHwJY4cl0nk7IdEpB79Yf2XuJZzDmxVKeVKrxjDT76qqK
   H2ZyLMKeSAP+0js8Rroi3tsbFFDBRZG3Rn0uV9JuZ4oQL150nzDBshNPA
   XxbY38ELs4YPDZwYisWX+KcmOgsU11P3mNZB6p7s8DhSj4lcpw+zOnh5i
   0yqicnmbguirXVJWHa8lHXISL+LMkmEMKO19Fof3CkAqdE13395ckIY0M
   ouX8+n6/7/ZdkJUfSHGnjIHi11U5RaDUzNeJJio2307vzrnAQzcZAnR57
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="283518409"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="283518409"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 11:07:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="954155948"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="954155948"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 07 Oct 2022 11:07:37 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 11:07:36 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 11:07:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 7 Oct 2022 11:07:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 7 Oct 2022 11:07:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLyUS1tOJTvSiEtM6VPfTrj84SOH8g4YB93Mnwgv34R9PoUhUg4ypK0tp7gi+i7ZKEGYBgx0jkbYf5teVnMNGziz9FX/2JFApKmUXzVrtr2otNlZyWnB3rre0qtUj58+BkFiUFwxtXdAQd9bmy82K2uMtn99IrM4hHPx5/hSW5HrAFJup/f+putkN5/Gy3iB6dcmQpXHk/s8sH4PJCZ0LsT/rl4woYmDU1lh2LgWzQcjkMhhr/OkRmkkeLHgNt7CZaewnGS///UFR1LRsJJhUCqB8yZpbnpTIpYXTStMaJRhNyqAaJmyo42S39aHSiwAPe0C0jmFDbBp7dzw1X+SWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpNsmOQitMfjiFV6253KhYaCKSpF0Aq1K/bSL5Hs+hU=;
 b=OeC26PGTmBOfXgkI7rUcqftUGX7jc0+mkoeOh353sN0BTAdPnOZ2i2QhCSY3ca2+7o+J3UvwGPmtpAWHofjrPZjiMOlNg/HMs5SdcehyykfQhVrf1aahwoBTPVfjIQYJNpM+XaR/GzP6I98DzCZqupg1MTzoeSWdeCBBQnsw0Sijzy1HdvGfljur/xHohExb+t68Uf0Mkaf4b+yKGzGqJ92/qxyvGZmJceuEx4v0HmNafoaNYa8wC6W2lE/y7a/IE9B3KlMUlrft2OqlBmxspWOW6rlUryoGJat347a1tt+T2uJIaDApGvC5wBMaDIFN9RRVLp218mJ6iL5yAu+IDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by PH0PR11MB4774.namprd11.prod.outlook.com
 (2603:10b6:510:40::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 18:07:34 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5%12]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 18:07:34 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: RE: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Thread-Topic: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Thread-Index: AQHY2Z1YsyE3enznIkOfLcepaehVE64DBB+AgAAxwgCAAAT8EA==
Date:   Fri, 7 Oct 2022 18:07:34 +0000
Message-ID: <BN6PR1101MB216170B28962901E72C539BDA85F9@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221006154041.13001-1-xin3.li@intel.com>
 <20221006154041.13001-7-xin3.li@intel.com>
 <Y0A77RLAgXQyrVPq@hirez.programming.kicks-ass.net>
 <5E3D5429-33BC-4924-B82C-C731507C0F06@zytor.com>
In-Reply-To: <5E3D5429-33BC-4924-B82C-C731507C0F06@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|PH0PR11MB4774:EE_
x-ms-office365-filtering-correlation-id: fbd1462b-e595-4b6f-2790-08daa88ecf52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8bH+1S/a3R3MehrziEiQjjkqdBuhcwf6bBim6PMTRfriMYLc/60kbrNcECnkBbIfqaWFtGVKkGfP8Gse8Tgiez0aMVstAzsW0WoKpK2kuJk6+r7t5y+g1fFreVNeVOqGOS99tSqUydTqJK7H8KytH4SMbaDrWYsgL+r7gOQfBjwvkxHYzob7KthEICSTxRo5TUiD3RYrMmaaBY+ABoZM8TLBMvBeeLjUaczJSQW0gCdaMdq7GuHMe5ze1KkPu64+rFWRWt0qys7klxtA/vt5qfJ3js5rfrjIeWtje5sLc/4mcIUTn9hM7v2dBEGN91YkbZB/i2jDuVDV/wa4B6P+XT9CGdKoUQGWaddq3qQFu1q8IWqAUOTXgR/G6cqjpLY0rnROUI5joQ9HqBZL3ZHFtOlMJM83HJxypSz/GvMTJ1bYSqfc+Y7QeYac3JvtH0qlQNMES8XQq92ipaLJAiM1Kph08TvO/+ey83AYogKI1a9mfpvU498Y38XBMpcuuf54nkd+t8gyiKkJyR3AvCixKjXY4Z0oCPxA0IEwBvVAPG5yEsz1A+mbFVTy/gOZEeLUK3riFyLnLdDKoaVbnZtUqsiSZefKyZ+ymqat7mUv4Me3MNPPCahrGU1/Nv/37BMxBT23MkYmfFmwA8lJMqdvi6teCL1ptALc3WC+EcBY/A7dW5jrNX+iBg1FtI98jJTH2cWN1Q89RcYhgF7mKRAPEXBviC3REI73pfDDnsbk5CqOppk3CIQgk4acdnaaBx9AxmiXlcuOyM5OwNYhsIERmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199015)(4744005)(52536014)(5660300002)(8936002)(2906002)(41300700001)(55016003)(4326008)(66446008)(64756008)(66556008)(66476007)(76116006)(38070700005)(6506007)(478600001)(33656002)(7696005)(26005)(9686003)(38100700002)(82960400001)(8676002)(66946007)(186003)(71200400001)(316002)(122000001)(86362001)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTVKMTlHNmlwV3N1WThzMms1MlAxZEtLbGlENVVkbDA4NkhVNEF6djQ0WVlR?=
 =?utf-8?B?YVZTQ2hwK1NIRDgrT01GdTdTZGQ1QXQ4eTFGUFpqYXMyZmRtT2cvT0NkYXY5?=
 =?utf-8?B?YmR0NnFWRjN6TXB3NTNtcGc1aG1BU0VpZkhqTkphVUZLd1JNNjdGTEdZckVN?=
 =?utf-8?B?enRSUnZuQytpQW5pWm16aDZPbUFhNzMxbk9yZm1PRmhCK2hDdml4Z3Y2UVFT?=
 =?utf-8?B?WTdRUmJXREdMS0E4a3ZDbGNZV2dZNHM5cnBOZk05bUUxeU10UWhiaElBY2E1?=
 =?utf-8?B?NnRMemZNMUZjZ1ZTamo3L0NQdGY3OUt0TllXbzN0TDNGRDhPSWtxN0dER05m?=
 =?utf-8?B?dmNFMzByeUN5VjRFVU5PUDBYa3gyTXRQOFRsVmE2TEtEVURoUGNYWDNlV1ZZ?=
 =?utf-8?B?eE40NTBLakQ2c3BoNWVPSm9MMWdScUtJR3ZWQmRmUk13RjhJQXJ3aG9iMFcr?=
 =?utf-8?B?eUswU2Y5VEJBUWhlVjZSSFIrK20xNnd1Y0lzd2o5R1N6UEV0WjhkWUl1aWs1?=
 =?utf-8?B?RkpBdVYwVUo2eGFMZEVWYitlRkRJdFZDc0lhTk5haTBVTDNYdDQyZkU1aGx4?=
 =?utf-8?B?cXNhR0tpeDM5M3kyWC9qYThlRDFjV0dEUVdXU1JWL3BSYktoTmYzc0V5Y0h3?=
 =?utf-8?B?dzBLcmhqMUI3OVdNNEc3RUplb3NvcEplUVFxL3NNS2tpTUtIWnhzYkg2VEk3?=
 =?utf-8?B?WUFIYUc5bGV1eDdMVVQ3ay9JRmx4YXFmcTM2TEpQUWNYdFQ2bVZrV2wyeEpX?=
 =?utf-8?B?RDJVK0lXRnhhaEJXMDRPTTZjNXF4T2RHdWV5V2F6N0xqaUM4MGlFQkk3bnBj?=
 =?utf-8?B?b2w5NXMxUXp6UlpqZlNqQ0V6YzJRRVlycXZONWhocVJFdGlIOXZlMEdaSG9a?=
 =?utf-8?B?RGd1cUZpWjZnRmg2ekNydmpBaFBsMzltMVdMNHpGdEdxYUlPUGhMSXMrK3Q4?=
 =?utf-8?B?ejZCdkxBeHRzNjdPYkZwMXBLMDMvZ2ROR1VYbjRmb3d4NGxPK0p3THFhRndB?=
 =?utf-8?B?cjFLcHlIUDdGRlZobFZyR3lzcWI5bGdZTlI0OU1WMmFycktPVDV2c3lCaG1x?=
 =?utf-8?B?bE55MzEwQ29DWWpYaTdsUjc3ajM1SmRyUmpFYXRQcDV3THo2UmZJbUxGVk9F?=
 =?utf-8?B?MXZ4K1IrTWRmTGVWendZZDlvaXNoQ2lRcW9wamhrbE9JTlZrSlpCTFFRRDBO?=
 =?utf-8?B?T1dpTHBNZC8xb05rNXdJUVlOa0JXdGJOZFdLU2U2KzV4WnczN1pMNDVORisz?=
 =?utf-8?B?eGFOWk5abjF6R0RsUG9LRk9UNU1kQWtNNjFZMVZkMnM1c284MmVGdHFZb3JL?=
 =?utf-8?B?MStmSTJPNXJ2WnFxcnhOeGp6QnB5Qy94dWFnLzk5RFpNRkZ5ZUpoSEhneEc3?=
 =?utf-8?B?ZEhyQ0xycXNZZmZkRmg0YVBoc1FUUXdjMlhRdS9OSkFadVp6aEpROEJnNnRi?=
 =?utf-8?B?dUp4RXBxMmFYalljaEVhd0Y3VlltaWdTMUkwOHc2dm4rYy95SS9ONlB5ZWNq?=
 =?utf-8?B?UzU1cVcxNUdrUXdYclBxM01pM0dHbm9heDBCREZjMkNxeU5WanR5SkJJeVVC?=
 =?utf-8?B?MkI5ajRvK0ZKclNyemt0NnZoUm0ySmNweHMrTWw4NjJFRGgxR3pCOGFFczV5?=
 =?utf-8?B?VUxxSktVcmJUTnhQWHFMTFdST21kQzJMKzdWZXUxM01sVzRuZmNWejEwbE9q?=
 =?utf-8?B?SG04SFlNQ0lZYnh4UDBTUlI2N1NLOHc2NDVzVW5XVXJmQklqQ2w5d2R5b2Fi?=
 =?utf-8?B?QmFQeVNOWjhCK2JJYnNlR2Q0ZWQ3WHlITS9PRCtBYlE0MGRKSlhDNFcyNTZG?=
 =?utf-8?B?SVhneHpRRmQ0MFdvQzVBWTBsc29Eck9MMjZBMlF6UXNJRlFFaEN2QkhFbDBK?=
 =?utf-8?B?ZGhvTnBBa0RiUmxjM3pKVEJRT1JIU2lUdGNmbDF0bFpiZjY2ZkFlSmFzVWNK?=
 =?utf-8?B?eDR2Qk9WQ2g0OE8wb3JSVjJNOGpFaHA4MitFS3YvcVZKUFE4cVdxc0p2QjVY?=
 =?utf-8?B?ekMzQUtXK0wzUHpVZEh5Ym9iS3RSNlB5dFQ4UGpxeWNHbURaNHpiVnppc1JQ?=
 =?utf-8?B?OWdxSVg0MmREL0I4V2R3VkJVbDA2SFVwZUprUHQveDNBWm9mY3FCVjJpRkFu?=
 =?utf-8?Q?1q8E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd1462b-e595-4b6f-2790-08daa88ecf52
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 18:07:34.2967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pw2cI0UrAkgE2FCE5OJgzSJw3VkQJ+m9pMevcjHzCZ1i+A0vFTzxezhxbibryCsjEI2yyiPKbjQS+E5V5qphEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4774
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+PiArCWFsdGVybmF0aXZlX2lvKCIxOiBjYWxsIGFzbV9sb2FkX2dzX2luZGV4XG4iDQo+ID4+
ICsJCSAgICAgICAiLnB1c2hzZWN0aW9uIFwiLmZpeHVwXCIsXCJheFwiXG4iDQo+ID4+ICsJCSAg
ICAgICAiMjoJeG9ybCAla1tzZWxdLCAla1tzZWxdXG4iDQo+ID4+ICsJCSAgICAgICAiCWptcCAx
YlxuIg0KPiA+PiArCQkgICAgICAgIi5wb3BzZWN0aW9uXG4iDQo+ID4+ICsJCSAgICAgICBfQVNN
X0VYVEFCTEUoMWIsIDJiKSwNCj4gPj4gKwkJICAgICAgIF9BU01fQllURVMoMHgzZSkgTEtHU19E
SSwNCj4gPj4gKwkJICAgICAgIFg4Nl9GRUFUVVJFX0xLR1MsDQo+ID4+ICsJCSAgICAgICBBU01f
T1VUUFVUMihbc2VsXSAiK0QiIChzZWwpLCBBU01fQ0FMTF9DT05TVFJBSU5UKSwNCj4gPj4gKwkJ
ICAgICAgIEFTTV9OT19JTlBVVF9DTE9CQkVSKF9BU01fQVgpKTsNCj4gPj4gIH0NCj4gPg0KPiA+
SSdtIHZlcnkgc3VyZSBub25lIG9mIHRoaXMgd2FzIHRlc3RlZC4uLiB0aGUgLmZpeHVwIHNlY3Rp
b24gaGFzbid0DQo+ID5leGlzdGVkIGZvciBhbG1vc3QgYSB5ZWFyIG5vdy4NCj4gPg0KPiA+ICBl
NWVlZmRhNWFhNTEgKCJ4ODY6IFJlbW92ZSAuZml4dXAgc2VjdGlvbiIpDQo+IA0KPiBYaW4sIHdo
YXQgZGlkIHlvdSB1c2UgYXMgdGhlIGZvcndhcmQtcG9ydGluZyBiYXNlbGluZT8NCg0KNi4wIHJl
bGVhc2UsIGFuZCBteSBrZXJuZWwgZHVtcCBzaG93cyBtZSBhIGZpeHVwIHNlY3Rpb24gaXMgdGhl
cmUsIGFuZCBhIGZpeHVwIHNlY3Rpb24gaXMgY3JlYXRlZCBhbnl3YXkgaWYgd2UgZG8gInB1c2hz
ZWN0aW9uICJcLmZpeHVwXCIiLg0KDQoNCg==
