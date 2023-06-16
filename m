Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5001732FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345193AbjFPLX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344168AbjFPLXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:23:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5F21FC3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686914604; x=1718450604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5YxJ8z/+8cAqUF19E3NqxLAAhfYyhCPyh1nE3avWinU=;
  b=mdajmggkT4LC6yxAiYgXqAZby0+pPh1oak8xl2JeofT4F/fUS+7zRWjM
   VQ+aC4sNb15wt2otnXj/kco+PHyv9BfQVykC3xY3lOK2lJHGsIvygbrEw
   0bEj6bidalMkTfoq11CyELDYB6aluXz7JhHrpHQ6ZhhioLdE3c/ttuWSK
   0PUILvXlA8vqgLQ/QMKw0W+r6Ylht+r9SBrNaeHHilq8bmH7dXP5Km+UC
   a8Z6MjB/Zi0+Rm5FJpCE5jAcNEYsMNMlrrH+zp0DfH5Lstc+eAcrFWMKM
   vLuvYdLAoHmRjB4o/nKZwAX8uCFgLO0SBjVrcXHCNN+UMjNs5wLj/Ml3Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="362606512"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="362606512"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 04:23:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="1043061823"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="1043061823"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jun 2023 04:23:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 04:23:17 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 04:23:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 04:23:16 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 04:23:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kl9f4EL1DYG8S/DDF6C0i8lPQiwMmO2+AW31w7bGM0oxRLhNWwoMhzZt7FMdxLyBkoJx+Vdb5hzUhKhJtvynpJdpbiS9J1ZAvjMPj4UOgCeNDdHBVAYyeH3e2p+5/flrrtTRlr3FrLcTGbVMEuvUAAz/f0KWORGyjLwgM9jBrPhcktWAJuCrUIbWzBhSr9iCE1TyOk/mSXclFOIM6iNJBob7Y9jdCZTnYe8KaQ/jbW/DC6vUc7utzOWguU2LVgwiUanv+BWPCf0h3TjpBL7CFfYy6ewdUfyWMGeIXlzaNkQBt/nzg6Vtpwd99Qf+g5IVcJP4t25Yzh6XfBJN/O9rcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YxJ8z/+8cAqUF19E3NqxLAAhfYyhCPyh1nE3avWinU=;
 b=e+IZeNRdpvCnVsgymY+/BULWmgifPF5d8BFz6u5bovjnTW8CBToABVgyhJZAiJsavlO+5N3y7tTjYwYjXlVFPPszMC3vVM9Ok1emff7QEIwG3CrGT9hbZYmAgh5476Jks0+ROA9WwTodMcqVqson9PFY1Ou2q7BbIUxMg8PiFaosxOXm8s+WCnjIb6C3PwzB5a6esi2S17FSzs3pz3fb0AC9U9FSlsIex8GRJFt04urMipcQOhkjK240TKNtcHl5zNPKcIk8ZeZYwQMMbsw0tYwB2UBeX3a7DgnAa/3jN+EPLbbCfaOJxDMb/Wa6kdP+upZ9lQDYBIKoXSOwrt5A/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 11:23:13 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::f6a8:daa0:7575:801d]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::f6a8:daa0:7575:801d%7]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 11:23:13 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Thread-Topic: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Thread-Index: AQHZnbiCY6eum+iSlk2uGaiesk42zq+LmcaAgAFpQICAABNVgIAAAjWAgAATPQCAAAZggIAAHD+A
Date:   Fri, 16 Jun 2023 11:23:12 +0000
Message-ID: <dd0a7053f762edaecdf7613da5281a2c2c73ca77.camel@intel.com>
References: <20230613052523.1106821-1-feng.tang@intel.com>
         <20230613052523.1106821-2-feng.tang@intel.com>
         <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
         <d97fe59e47de77a36746107e4070e44ed46bf4d1.camel@intel.com>
         <20230616080231.GZ4253@hirez.programming.kicks-ass.net>
         <20230616081025.GM38236@hirez.programming.kicks-ass.net>
         <d100b30d381b9d28b6fceab5e9c5042c3ca79ba8.camel@intel.com>
         <20230616094205.GC4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230616094205.GC4253@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|SN7PR11MB8283:EE_
x-ms-office365-filtering-correlation-id: 25ca281c-fb1c-4821-a0ec-08db6e5c127a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I35pr8HE+HeGbd4sGOGWrTbNoit9UyokTfn8UwVys6E8Jm4HswZT0EMeuIrr73YLAHeq9rmjdC5GiY972Jj+SN5QvYWLVx6rLru7Ny2NxkbUB2pPdwiGt38HpuJg9SxX9nLMvmvKRkGPiU2W/WR3EXB9MdNRsQYSrF0UhFeCwCgCRPjQTVcVMdm3ks8X6fRhhTjVeSyLc4RQ0wTlsgOjrfMqNXNUdOQ8WLghbREXlRgdh9pnXrp+x2gXJX8bd3qETuvlUZIfXLRXkGGHKsvS+pOIc5iF+cADTnfdW1nMboDHli6BSyInqXoOXfxbtjfNh8uqYXiSiSgQXjmcnIyEEXPvgHP9EnTMpvNdr7cm0rAdiH0h/u2xMtHRiBPmE9/Vmn8XjzDAF6gNewowj7l/fecgMzUblis1W5xmIXlNkdB0KXRlQvhcRFNIiDeevjfR77FUZK7esjkrZul8DSGKWH3oHAqa8S8XjbIUCHEcsUv/+EEOdrmcJK/+0LZzqMsoARv0nSFDwNm+N5ZS061dHDWIAdqM8O76q5z0leBuFqpV2D2ydiR79Fn5Q201Kh3gsx6/dnPVlXGneHi3qQrHdB+30qwpxqi83HDcPozApdA58cruiGzEGJgV9AXQ0p4G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199021)(26005)(8936002)(6486002)(8676002)(6512007)(41300700001)(36756003)(82960400001)(478600001)(71200400001)(66446008)(66556008)(4326008)(66946007)(38100700002)(86362001)(76116006)(66476007)(64756008)(6916009)(38070700005)(54906003)(316002)(122000001)(91956017)(6506007)(83380400001)(5660300002)(186003)(7416002)(2616005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmwyZTlDQzJwZkd6QTdHNFYvSXdJK2djNmlCck5aTE1YRWJqRWIvVjlTMUpw?=
 =?utf-8?B?VFc5R2IxVUtZWFlGMHkwbmN5My9PTWdpakVLbktXUG55YnJqUWNDZ1dyemli?=
 =?utf-8?B?dHpZYUt5U0krcEJEcWI0WjVlZDkxQ0EzOVZqVER4YWxISkUwaTJoQzM5cWJM?=
 =?utf-8?B?Ykl6aUo5T3hNc09sd0pmTVNPYnZOdzBVMU5Kbm1HMXpGMjdBdFE1cFYxSkhX?=
 =?utf-8?B?N0tWL29OZmU4TnhxajBrNEtPTUNsRDhkUmpLNXdxdUlRYjQwOE5xZUFMWTJk?=
 =?utf-8?B?dnBPNUpDU1NTcHk5Q2RaeWxyQjhGRmlyOGpabk1Vc3hQTGJxbWl6ZjJ6VFJX?=
 =?utf-8?B?UHd4bS9TU2daWGVJazBucjFhamttQzhSaUw5cklpWXpLWlVVUUg0Nk15c01m?=
 =?utf-8?B?VTViSHFHT0RSeitkNEFucUo5d3ZrQlRScG1yc2E4emlROG9sWm5hUXRMNUpH?=
 =?utf-8?B?Rk81RHBGdEVTUmR4cGN2V1Z1RklQWks2b0JCOWNySCtvZ3hlNm1mUHdkUmhZ?=
 =?utf-8?B?b1ZoenFVbUVLS3laSy91eXhvZE5qbDlEdEgxU2lOanhvZzdFWHZoYnNOQ25X?=
 =?utf-8?B?aFp2VW1VUXV6VHA0eWF5ajZ6M21rQi9vdk0zZ1lURW9aV2UxUmRpL1dIalVJ?=
 =?utf-8?B?TFJoUlBsYVZ5ckhlSjhyQWZOY0FWSFNLZ2hjcDZSOG81ZWZ1eFBXMWlId1BC?=
 =?utf-8?B?Q0xiYi9hRUpMblI0VHdXSC9pclB1VlR0WXViRlhvajluV1lNT0RYdTBpZklt?=
 =?utf-8?B?WlQzQVhsS1dpMlAwbTczNENYQzZZVnBaZ2xLbmtDTEhFR1VUNG15eWNJcm9r?=
 =?utf-8?B?MUdvbi8rRTREZGRIQXBYN0ZHWFhCMUsrMGt0SE5iMDJ6NWpHT20ydEFmcUx1?=
 =?utf-8?B?SVhtdEIxeUhBRE9VNk1HekhSeEc0eWI1c3hkbm5MNmNldWNod25KY2lNTDAv?=
 =?utf-8?B?UUpQLzdmTEp6TmxIM3l3RmlUVzFuM3oxWTBTTVNtU2FpZmNOS3VzZW5OdjFu?=
 =?utf-8?B?VFV0TTFZeEpsSC9Vc2E4RmpWWTZ5aW9NWnhpVFNRSW5WSFQyTGNmS2FhZ1k5?=
 =?utf-8?B?T3B3aklhV3FybFNnRnZxdGI5N0EvYW5GRXhjeGFvdHcvNW9DY0xlZmNwbXRL?=
 =?utf-8?B?ejlveXh3QlNNQ0JKRGVIeXd3NVlidzBLZjErSmR2RW1XSXVLcjhxUVFER090?=
 =?utf-8?B?UGlaaTh0cXpsNWlDelRKS1FPYW5penRRaWNqSGdDNGxQVkloWmtaYnpyR3lW?=
 =?utf-8?B?RGlENTdNeTZkc3A3cTJvd3A5Vm5DZlQ0eGl6ZmVadEsvZG1PV29EMEtrU2k3?=
 =?utf-8?B?UGNwT3VMWWNOOXZMREppQi85VGtOUEZpeU02TEkyWEZzWElhVHllSmptWS9r?=
 =?utf-8?B?R05wR3FjNmllNFlaMnk3SWswRDgrOFNvSXJGaDlncUJrWm03RWJkSlc2TXd1?=
 =?utf-8?B?UFlFWUV6OVJVZGRNekZrOC9mTXhkcUcwWUtqSlh6ZWFxRTJZOEZCcjBwVk1h?=
 =?utf-8?B?clBzYWpyM3BScVZneE5yNHc0MVUrQ1VOZHQyelQ3OTdQY0R0UXhtZGRKN2Va?=
 =?utf-8?B?cklPVGVGLzVHbm9xNkdEZWhUb1d5dk1GczJMdjYxYTdxQVJwRW54eDQ0Y3hk?=
 =?utf-8?B?alJYZWU2NXN2bDFnT0djRlVyRVNNalFxZ0R4WnlUWjJxbHQrUE9BT0JZVkE0?=
 =?utf-8?B?T1EzL1hVN0tkUnlUdHc4TXFDNVpBL2o0bFFyRE1JL05rQ215UFh5Z1R2RXZD?=
 =?utf-8?B?dG5jdUpZeGttTGFuQm5uUzRMOHRqZVZxUWRNQ1BERGhvcFZMN0V2OExVRUJY?=
 =?utf-8?B?Q3pzdUVZMHB6aHdndkcxd3VraHhlYU1IWFpVYW5KbDJXVlo4d2NpQmF3TXBv?=
 =?utf-8?B?bnJha3RpZEtXamZIaTh1Z3lnUWlkQVpER3h0OG1RRlRBODZjNU90cEh4L0Uw?=
 =?utf-8?B?YXE4bkx4MktseXA3QjYyQk0yVGYrakd6TFVnR1VXYXRsOXdteEdJYXd0d1ZF?=
 =?utf-8?B?eGZlWnFXOVNRcDRtVFRpNnJvS09YanlaQ2tTRmh3Z0NhWkdjVHgvb1cwRnVs?=
 =?utf-8?B?V3dCTHBxTkp1QS85YStRWDAzZnBhOW1lMGJyQTY0YjZlZVJxU2tVUUVXYVRI?=
 =?utf-8?Q?3cMMjxgC/aWWQk9kVgHN9PPl/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F179D4EC4F8314A967E59C3CAEA961B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ca281c-fb1c-4821-a0ec-08db6e5c127a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 11:23:12.8648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qynmzihDH3++hIU0IglZDbt7Kphd1rTO6MmIxHJOh/d/k5wPPUgrCd3pKCLW0FW2d953nvjryYYEhQtGmz9SPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8283
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTE2IGF0IDExOjQyICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gRnJpLCBKdW4gMTYsIDIwMjMgYXQgMDk6MTk6MThBTSArMDAwMCwgWmhhbmcsIFJ1aSB3
cm90ZToNCj4gDQo+ID4gQWNjb3JkaW5nIHRvIHRoZSBNQURULCB0aGVyZSBhcmUgaW5kZWVkIDQw
IHZhbGlkIENQVXMuIEFuZCB0aGVuIDgwDQo+ID4gQ1BVcw0KPiA+IHdpdGggDQo+ID4gDQo+ID4g
QVBJQyBJRMKgwqDCoMKgwqDCoMKgwqDCoDogRkYNCj4gPiBlbmFibGVkwqDCoMKgwqDCoMKgwqDC
oMKgOiAwDQo+ID4gT25saW5lIGNhcGFibGXCoMKgOiAwDQo+ID4gDQo+ID4gYSBkdW1iIHF1ZXN0
aW9uLCB3aHkgYXJlIHRoZXNlIENQVXMgYWRkZWQgaW50byB0aGUgcG9zc2libGVfbWFzaz8NCj4g
PiBJIGNhbiBkaWcgaW50byB0aGlzIGxhdGVyIGJ1dCBJIGp1c3QgZG9uJ3QgaGF2ZSBhIHF1aWNr
IGFuc3dlciBhdA0KPiA+IHRoZQ0KPiA+IG1vbWVudC4NCj4gDQo+IEkgcmVhbGx5IGRvbid0IGtu
b3cuLiBJJ3ZlIG5vdCBnb3R0ZW4gYXJvdW5kIHRvIHJlYWRpbmcgdGhhdCBwYXJ0IG9mDQo+IHRo
ZQ0KPiB4ODYgY29kZSB5ZXQuDQo+IA0KPiANCkkgZGlkIGEgZG91YmxlIGNoZWNrLg0KDQpUaGUg
TUFEVCBpcyBjb21wb3NlZCBvZg0KDQoxLiA0MCB2YWxpZCBMQVBJQyBlbnRyaWVzLg0KMi4gODAg
aW52YWxpZCBMQVBJQyBlbnRyaWVzIHdpdGgNCglBUElDIElEIDogRkYNCglFbmFibGVkIDogMA0K
CU9ubGluZSBjYXBhYmxlOiAwDQogICBJJ20gbW90IHN1cmUgd2h5ICJPbmxpbmUgY2FwYWJsZSIg
aXMgZGVjb2RlZCBiZWNhdXNlIHRoaXMgbmV3IGJpdCBpcw0KICAgaW50cm9kdWNlZCBpbiBBQ1BJ
IDYuMy4gTWF5YmUgYSBwcm9ibGVtIGluIHRoZSBhY3BpY2EgdG9vbD8NCiAgIFRoZXNlIGVudHJp
ZXMgYXJlIGlnbm9yZWQgYmVjYXVzZSBvZiB0aGUgaW52YWxpZCBBUElDIElELg0KMy4gMTIwIHgy
QVBJQyBlbnRyaWVzIHdpdGgNCglBUElDIElEIDogdmFsaWQgdmFsdWUNCglFbmFibGVkIDogMA0K
ICAgQXMgIk9ubGluZSBjYXBhYmxlIGJpdCIgaXMgbm90IHN1cHBvcnRlZCwgdGhlc2UgMTIwIHgy
QVBJQyBlbnRyaWVzDQogICBhcmUgY291bnRlZCBhcyBwb3NzaWJsZSBDUFVzLg0KDQpUaGF0IGlz
IHdoeSB3ZSBnb3QgMTYwIHBvc3NpYmxlIENQVXMuDQoNCnRoYW5rcywNCnJ1aQ0KDQoNCg0K
