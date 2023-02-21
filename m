Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFB269DBDE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjBUI0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjBUI0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:26:17 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A0723332
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676967976; x=1708503976;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4xr1Lr+p2c48KZ3chpBkkGvCASIQpCvn9UP9ya4o3ck=;
  b=QT2BRO3w/7DUoGwWtOsoLS0yWdhRF6RVOYj65K40y8jcTy9xgHmr8Pc2
   SHsYfwM7X8hdEpkvGb6HhqB6GkYX2UhUVaqWQSpbXAjDoIMV3/e+SYGHS
   J0eJ3mwvsTI/XiCwR7E5UQ1KbHTT1oarfs6CPchWq16S9r2e+88K6txaT
   qbtZ6ohOrb+fGgf5C1u4Z9yo4AlSw5g4NDp54mI1G0xsFcIUISqPgPXUi
   SuEUqhOAOM6NqfLaFMKz4wnJ8hoRtms+Q/F/KlFz7hIZMTds06efnaRIE
   WXN36a+3OwhkiNU49U4ys/6oVWCWgS5V2lWdpdLhVVfpJlq8RqIvkZAw1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="395057032"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="395057032"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 00:26:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="917097068"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="917097068"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 21 Feb 2023 00:26:15 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 00:26:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 00:26:14 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 00:26:14 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 00:26:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkSjSOAc7XREzKsjyhXu1NhFjTrcOKwP9WeAc+FJsvQ2TeB1O44M+a1UyZxdlz6vTCFyY7G3duHQs5tjIjXlr1zu7hUSICqee44S+rTXwWTEATZYJIn+4Gx+L6PeFV4W8Dy2jBoOcBS0HtmOBE9NATBdmXBKSD0gFIfzkpvwn5XCnaMj1RZzCy/SaTvVugGJlnMiwd8Tz3tZvZnNXUvHNJTaHLJNM0xITCBGMqTIM+GFOm6MpdYsRaAGNXGTkbrJKf82Xc+jdgd0YXLkX2eyIevGdzND8X2FS5o0qMFq67vRQEADOdNnwEWAg9rln/G0ygJv+f/TBjMV4/tUSRCXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xr1Lr+p2c48KZ3chpBkkGvCASIQpCvn9UP9ya4o3ck=;
 b=CL4J4k7N6rj82AtB/6R4/rfDAIX2cw7WnLHmt1OyviEF3k5s9DNfu55PIHhc4ekuG2+SXmYPydmps1Qd4AHF5cOvTCTQQx2Vy1XvaMGlTU+Hx5s9Zq0GDbC4w/5UvYkNCpFkyeaBtiLRK6cpMMx0lU2qKbfPnX4s0rGJnpE2+ZqJc/3nm1OxaJLdYXs5hkXkbHmJOv+sVnSXgfopMBv4+1Kvvq3xYxIPHGga8Tm/Fj4PUk6UMYYY9lM6mw9tq+St9hrYwGM7ds+OPlrp2rBRTXOe56swLZ96dOxWT4q1lIRFumEs6GDXRy1Jx4dEEwjivVWYj/T/SVFJa8DDNFXHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MW4PR11MB5889.namprd11.prod.outlook.com (2603:10b6:303:168::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Tue, 21 Feb
 2023 08:26:07 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837%8]) with mapi id 15.20.6111.018; Tue, 21 Feb 2023
 08:26:07 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "Brown, Len" <len.brown@intel.com>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH V2 0/1] x86: cpu topology fix and question on
 x86_max_cores
Thread-Topic: [RFC PATCH V2 0/1] x86: cpu topology fix and question on
 x86_max_cores
Thread-Index: AQHZRNuCmUZrj67G7kGhK77N+UN9Nq7XrYkAgAA5PoCAAIrCgIAAoQeA
Date:   Tue, 21 Feb 2023 08:26:07 +0000
Message-ID: <65bb51627b7384190f6aa1c549548a2497a926c3.camel@intel.com>
References: <20230220032856.661884-1-rui.zhang@intel.com>
         <Y/NUni00nDuURT1H@hirez.programming.kicks-ass.net>
         <fe5059317c4f3cabeb86c388d547504b9b6ea581.camel@intel.com>
         <87edqkosty.ffs@tglx>
In-Reply-To: <87edqkosty.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MW4PR11MB5889:EE_
x-ms-office365-filtering-correlation-id: 6b198516-34d9-423a-a202-08db13e54779
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nFlbha6pRKMl1PoztqoR1LyPYVLusPIwr9i7XBQ56tJ5X7mUhV0HaHiWkMyP0OFatUeHKRuxeGTJlc0BhPAkHD83PBw938jYzNKYvQcqqweGCYvnknzb1oQ69cGHKhfQtdAoWMYz7RItPtpyk1H5qeclQEGyUN4BDOtDBIToTHwEf1KMbituA6sJpZWTXvnLt4J7Ovxj3WUJK1BwjEAXSI886KhYwmu7+I3XHrsZGBhwryHnvpGwvb+t9D/QxFjgauJ7oYRgIPO0LxGhadusYjnDtS7BABW/moMFyFT8UQz2xPo0mD2QZmUz/ovsxfPYOq42ll69vcwa95zZdWjrsgEeD6TOUnYYS6958KGBmq9has6uKGk16zIIbXGcwH6lUDAf56Z3APnaPChHcc54sVAvR/sV+CFbfY8zV2iGUNkBRr5SFBRTY/q2Uz3ZT/u0+ZtR+APH/fA6DyN5yuPCAwBFpsDe47dC4PflFT5S5zACizcZM4VeM5bzmPHp9B5/zieJEzNj7wPHO66DSBj54vFs4nBC8UTe2YA/NEzrj2yM9GG+tFNs7jmK7QLYxFbwUWsniAY6ivNEdNXexoja/ltW1jWOwPHrLpBlgL7aZq8jrITIy8A7zuacCSg547vzfLwb5lzJ5F4oJ2cKaDO3haekPwenPXCQbYVgWMXq3IL0eWRgdptHNQLXS/zlBsmA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199018)(36756003)(8676002)(478600001)(6506007)(4326008)(6486002)(26005)(54906003)(186003)(316002)(41300700001)(76116006)(64756008)(2616005)(66556008)(66476007)(71200400001)(66946007)(91956017)(6512007)(8936002)(5660300002)(122000001)(38100700002)(86362001)(110136005)(82960400001)(66446008)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1g0ZlhCY3p4aHA1N0tQdC9qWmhuSkhHRHd4UjRmOTBrd2ZKNnFpaml3eXVC?=
 =?utf-8?B?ZTFsUDRoa1FmM1I0L2FmVG9oYkVONVNwRHdzQ256UHpYeGlRdGNwNmRJczlh?=
 =?utf-8?B?U3dTeW9hcnZOSnNhQlNlSDZHNjRHcjVHeXY2cWVKZXBoVlltUDVONGVTSlpJ?=
 =?utf-8?B?azdSMDBwOTIybDlkQjE4MHVOZ3VOTFM4MC93dHIzTjV3NkRmb0lQU1ZnMWpy?=
 =?utf-8?B?dFFtSTdDRDVFM2U1R1pCTlVNYkoyaE9Bc2s0RHlyZEpsUWM4RUptUjlJUFp1?=
 =?utf-8?B?dU9ld1JuTEJtSlZrdTFZNjRLMmg0ZFdDVnhPbkc0YVY1U1orRS9NcS95cFJH?=
 =?utf-8?B?eVU0M3M0VzlvMGp0WSt2THVGNUdBeVZVZGdIVEdvbW9hMlZRS3RBaHVGdDhh?=
 =?utf-8?B?cmtheXg3SzVxUW9rN090V05KQzJlaVNYUUxlVFBncDRjVkR6R1JlMTBBaTZh?=
 =?utf-8?B?bjFlcWVaVHhLNE84RCtFL3JQUkUybjN3OEtwem5pYUV3SUZaNml2Uy9qR0th?=
 =?utf-8?B?ZnRmc3J2cXh1Y0hhb1BTNFRCUjE0U0MwcVhkRG5rSWJpcE4vTCtTd2srVUZx?=
 =?utf-8?B?dUlxYU5JMnE4L3pFUXpMZ3A2RlZkUXhQU0hCZVZONXlPamVSenRZbmxMTlcx?=
 =?utf-8?B?NmphTFZsM2toVXZBR2ZhTWhjSFhGNHhUOGhFM0svL3JkNmhjeU83K1c2bWpn?=
 =?utf-8?B?emx5azNINkU4eTZiNjJXcHZrYzdkK3NWQmJOcXZsZlAvc0tKR0xYQ1BFSFR6?=
 =?utf-8?B?dDVHNkFnUXBqYXh1U3JqQUNBSlFBb3JTcTJHSm1ZcEtxbEZuUGlwZkxWYUNv?=
 =?utf-8?B?SHRTSXpDaFkzcEw5cVJmS2FUTEcrQ295T20rQ0k5TG9xakRIZ0N4VmF5MlFK?=
 =?utf-8?B?TWd5VUUyUXJtMVpnajQ5NlNVYUI5VTFuTnVReTBtdXM1czNvc0JLMHduSGs4?=
 =?utf-8?B?dlpidnl0WlVYNVRJTlE0S1BqczhGNTlBK0kwQ3UxSG9CUHFXRFVlU0FnQ09J?=
 =?utf-8?B?NndwR1hFQTM4c1EwSXVxYjQ0YUJRdTNxOHE2UHdWclZ5dmYzQmdhOFlUOFNX?=
 =?utf-8?B?TytBMHhRQS9qKzdZRHB6YTkrM3FhNE1XZFdqMzRNQjhyY0RyOGY3V2V4NW0y?=
 =?utf-8?B?L2N3Rm12MHlhNlFZdGtSeHB6U2pvVXBpZFViQUhNWUwxNDU4VjQrQ0tmT0Rm?=
 =?utf-8?B?YTJRZmNGdllCWDQ2MDc0eHMxcVYwSWRxQ1AwR1pxWHdGYy9YUUNpZDEzVElG?=
 =?utf-8?B?cFF2TGRZdG80c2c3a1Y1Z0N2WnFjTmJ6US93QTdZS1JYZ1JER2pIa0NXWUk1?=
 =?utf-8?B?ejBiaDZ5VHJzWmQyZkM1a3ltbkdCWHRvV29QR25iUUJUUmFka0hrVmRaa2lh?=
 =?utf-8?B?end2bTFYZjVQMzIyQ09rNDVkN2thRzNxcDZHazdKZlJvOEQxd0pjeDNaLzA4?=
 =?utf-8?B?MTJiNmFDelR0K2R0a20zejlmaGtqTHJjL0hEUnZ4c1dvcWFTSkNOcDR2VkE2?=
 =?utf-8?B?TitWd0VTeHpUUGRWTGFSWXk5ZTAzd2xMM3RwNDlUQlFKYVp0QzE3YklhQXRl?=
 =?utf-8?B?V0tuTFFhR2kyZ2IrTFZLa1VRa3dPWkNsaEY1K09zWTdtaEhHMVVNeG1Oem1u?=
 =?utf-8?B?TnROeUZhaGlCZU05ckRKdnJZTHk2MjBPdXBNTDNkWW5jTGtCeG1NNzRYZ2gw?=
 =?utf-8?B?bEphdEUzVk1XbmZxQXJWa2t5SU9XbUgwSGhpWmVab0RPdm9uRjJuYW03T3h5?=
 =?utf-8?B?cVVmQ0lEV0JtcmxFU212YkhEVUNUdEdleVB0V3crSWpWVEh1YXFVazNqTEpt?=
 =?utf-8?B?MW1nOTdiM3hUWHNVVTNSWTIyS0dqMXVBdlk2emxIRTZHZEVSb1pmLzV2Yk1k?=
 =?utf-8?B?NjN0ZXFVM0hTT1VYT205bm56dmFHcUY4d1lqODZlbnZleVdUT1MxUHBKSUxm?=
 =?utf-8?B?K3gzMmZhOTVMV2p3NUliQXlSUUJPSk0wY0I1MlBHbERnZkdMeHBHdWl5UmFH?=
 =?utf-8?B?L1ExZlZDcDB1aVh1dzJUcVNEdnBXbEk0UjZNeWlUc2gvMHlZZzVORkRNY3ow?=
 =?utf-8?B?bXhlR1F4Sk9oRHVUNE9KVlVKUkliQXl2azFmdHlzZHA5YWczQmdIY2M3LzQy?=
 =?utf-8?B?RktHUklOUkhBbUFDTnZPbkNqQ2Z1UnNtSU52bFBIWGQ0T2xIRWZtYmx5SlFG?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D38D609BDA3F34684251EFF97831CE8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b198516-34d9-423a-a202-08db13e54779
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 08:26:07.0180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F6BHN8SO7kQvLOeZhPgflPYn+FnoRvZGK910Uee95GaGG6mN85MY2NzurUv74OlgLxO3IOkMeTdSEruh13Kw6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5889
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gDQo+ID4gSSB0aG91Z2h0IG9mIGltcHJvdmluZyB0aGlzIGJ5IHBhcnNpbmcgYWxsIHRo
ZSB2YWxpZCBBUElDLUlEcyBpbg0KPiA+IE1BRFQNCj4gPiBkdXJpbmcgQlNQIGJvb3R1cCwgYW5k
IGdldCBzdWNoIGluZm9ybWF0aW9uIGJ5IGRlY29kaW5nIHRoZSBBUElDLQ0KPiA+IElEcw0KPiA+
IHVzaW5nIHRoZSBBUElDLUlEIGxheW91dCBpbmZvcm1hdGlvbiByZXRyaWV2ZWQgZnJvbSBCU1Au
IEJ1dCB0aGlzDQo+ID4gaXMNCj4gPiBsaWtlbHkgdG8gYmUgYSBmZXJ0aWxlIG5ldyBzb3VyY2Ug
b2YgYnVncyBhcyBEYXZlIGNvbmNlcm5lZC4NCj4gDQo+IFRoZSBBUElDLUlEcyBhcmUgb25seSB1
c2VmdWxsIGlmIHRoZXJlIGlzIGFuIGFyY2hpdGVjdGVkIHNjaGVtZSBob3cNCj4gdGhleQ0KPiBh
cmUgYXNzaWduZWQuIElzIHRoZXJlIHN1Y2ggYSB0aGluZz8NCg0KSSBkb24ndCBrbm93Lg0KRG8g
eW91IHRoaW5rIGl0IGhlbHBzIGlmIHRoZSBBUElDLUlEIGxheW91dCBhcmUgZGVmaW5lZCB0byBi
ZSBpZGVudGljYWwNCmFjcm9zcyBhbGwgQ1BVcz8NCkluIHRoaXMgY2FzZSwgQlNQIGtub3dzIHRo
ZSBBUElDLUlEIGxheW91dCBvZiBpdHNlbGYgYW5kIHRoaXMgY2FuIGFwcGx5DQp0byB0aGUgb3Ro
ZXIgQVBJQy1JRHMuDQoNCj4gDQo+IFRoZSBTRE0gaXMgbm90IGhlbHBmdWwgYXQgYWxsLCBidXQg
YWNjb3JkaW5nIHRvIHRoZSBBQ1BJIHNwZWMgdGhlcmUNCj4gZXhpc3RzOg0KPiANCj4gICBQcm9j
ZXNzb3IgUHJvcGVydGllcyBUb3BvbG9neSBUYWJsZSAoUFBUVCkNCj4gDQo+IFRoYXQgdGFibGUg
YWN0dWFsbHkgcHJvdmlkZXMgcHJldHR5IG11Y2ggd2hhdCB3ZSBhcmUgbG9va2luZyBmb3IsIGJ1
dA0KPiB0aGF0IHRhYmxlIGlzIG9wdGlvbmFsIGFuZCB0aGVyZSBpcyBhY3R1YWxseSBjb2RlIGZv
ciB0aGF0IGluIHRoZQ0KPiBrZXJuZWwsIHdoaWNoIGlzIEFSTTY0IHNwZWNpZmljLg0KPiANCj4g
U28gd2hpbGUgdGhpcyB3b3VsZCBiZSB1c2VmdWwgaXQncyBub3QgdXNhYmxlIG9uIHg4NiBiZWNh
dXNlIHRoYXQNCj4gd291bGQNCj4gbWFrZSB0b28gbXVjaCBzZW5zZSwgcmlnaHQ/DQoNClRoYW5r
cyBmb3IgcG9pbnRpbmcgdG8gdGhpcy4NCg0KSSBnb3QgYSBicmllZiB2aWV3IG9mIFBQVFQuIFNv
IGZhciwgbXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IFBQVFQNCnByb3ZpZGVzDQoxLiB0aGUgY3B1
IEhpZXJhcmNoeSwgYnV0IHBhY2thZ2UgbGV2ZWwgb25seS4gVGhlcmUgbWF5IGJlIG11bHRpcGxl
DQpsZXZlbHMgYnV0IGl0IGRvZXMgbm90IHRlbGwgdXMgaWYgaXQgaXMgYSBEaWUsIE1vZHVsZSBv
ciBDb3JlLg0KMi4gdGhlIGNhY2hlIEhpZXJhcmNoeQ0KDQpJIG5lZWQgdG8gZmluZCBvbmUgcmVh
bCBQUFRUIGltcGxlbWVudGF0aW9uIHRvIHNlZSBob3cgaXQgd29ya3MuDQoNCnRoYW5rcywNCnJ1
aQ0K
