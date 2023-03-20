Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322606C06D4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 01:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCTAae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 20:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCTAab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 20:30:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A674713DCA;
        Sun, 19 Mar 2023 17:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679272229; x=1710808229;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+JZucWAbgTzLeyuaLo5mwbDMAaiWjoDOwZ/F/Qq+tfk=;
  b=AHP9Nq4ZLsYLkC2SmoZyYvyGkMSVQPcZfyMr8MWvhhJt7I2hK5f0czmm
   0NgKr6bhzmg/xnOaJFi6dDvvFhFslMUAtVpytMDQO86CoydE/CkZmB46L
   yqKKYzcAKto6bBmS8vOgvblgq2E44SXEJ3WcnTcRFcFyEg8oiDas8heny
   j6iQ5XV+gVkl2TDs7jduXz4t4rjreH3PJLxOh25apAk6t5U9Tr12NMIm0
   Dzelr6l0XnncRzGhjYuHWB/tUC5CYAhf0qkfwouGnY+FU5d8TtdNSCDRf
   7UbVqoNk2rXS7rBvWNBVvLdIzi/2Rf7DIu9tEfwY5HEeeAlCTSluPibhg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="424824854"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="424824854"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 17:30:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="749888847"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="749888847"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 19 Mar 2023 17:30:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 19 Mar 2023 17:30:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 19 Mar 2023 17:30:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 19 Mar 2023 17:30:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 19 Mar 2023 17:30:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGYE+nr06we88AbVOGCyEpcw6mQbbLflcxTgB1/Sk3MszipdnOSYZQO7fB41HLgdz/j99rtvGguW62Ac5xd6OrqImlREc2iyMGLnfoXyB5W00wSMz1gz1bQUstxP7Cd57TlH2ImwV8SyKNlW3fk2VIsd6dRUy3iFXUHWrWT51nBe8On0qyA38tu1qUalvbSIOGfcn5619YCMiXB1UgQNjtyLMw5674AKliUSkx0d1rt5IkjVg000bB5d9TJvLwUjsP6WpkJXHVN03zKuTEagZsMeFVoRWGOo15Q/XTf84JGhX4/Qw3CBtTtOVBdEoE7EUb37k1CmLS/gKe65H6M6Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JZucWAbgTzLeyuaLo5mwbDMAaiWjoDOwZ/F/Qq+tfk=;
 b=BzHcUNxsw9xY8mKRdviPeFMLqXjQaJxiNxeemFB0Ee6jQ/tdFlYXjYyaXQ5meGFJ6be0nyvcZI/O93EG+5oBHnhjzu26FR3LMBWIZpPmHb/r2wQ3J5/ij04NngeNqzlSjJLukCsMpiXoFaNMi187/de+Y0VFlKz5OtPS+rCbaI+vBWQhPvR2i+bLW0ImOA4GfyYdoVLq1lhPUQqyfuC6Y0+3sMAQxS8RbedlbkAeYL14HCw+B84fOBRePqPEl/nteU4KHQ6BodbJ73Pb6SB5eidt/8L3HIt56j8tICmQRH+2Abe3ZlztEA0ktilZGg6eRHXub4rxXu7m/aE1X145VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2618.namprd11.prod.outlook.com (2603:10b6:5:c0::30) by
 BY1PR11MB8053.namprd11.prod.outlook.com (2603:10b6:a03:525::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 00:30:24 +0000
Received: from DM6PR11MB2618.namprd11.prod.outlook.com
 ([fe80::85cc:49ad:f49d:ea7c]) by DM6PR11MB2618.namprd11.prod.outlook.com
 ([fe80::85cc:49ad:f49d:ea7c%5]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 00:30:24 +0000
From:   "Xu, Even" <even.xu@intel.com>
To:     "todd.e.brandt@linux.intel.com" <todd.e.brandt@linux.intel.com>,
        "Philipp Jungkamp" <p.jungkamp@gmx.net>,
        srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "Brandt, Todd E" <todd.e.brandt@intel.com>
Subject: RE: BUG: hid-sensor-ids code includes binary data in device name
Thread-Topic: BUG: hid-sensor-ids code includes binary data in device name
Thread-Index: AQHZUzXwgfGO1WCFDU+JrWsC/WBLDa70FL4AgACW9ICACdTz8IAApboAgAO5U0A=
Date:   Mon, 20 Mar 2023 00:30:23 +0000
Message-ID: <DM6PR11MB261876C5F763CA6AA9868754F4809@DM6PR11MB2618.namprd11.prod.outlook.com>
References: <592bcdcbb3603cf5dfefd09abdd6916db4efc691.camel@linux.intel.com>
         <317ce138f63b9317ac7be1949a68db5117c19b92.camel@linux.intel.com>
         <424882ed2a79a641f88b5f2d1ed5a5d3d4fe98d9.camel@gmx.net>
         <fe7b41aa975128bd44d351911b0faa17b837033c.camel@linux.intel.com>
         <DM6PR11MB2618B71FCDD70813404F570FF4BD9@DM6PR11MB2618.namprd11.prod.outlook.com>
 <ebed4596ab82f7d99673ea6660800ed2fb0e1245.camel@linux.intel.com>
In-Reply-To: <ebed4596ab82f7d99673ea6660800ed2fb0e1245.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2618:EE_|BY1PR11MB8053:EE_
x-ms-office365-filtering-correlation-id: 3eb5a53d-96dd-4c7f-6305-08db28da4b94
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lWF1Tn93aple45qH3juaTuEz9MSmQQ+0FLcpY4g9EoS1bLCjKNtqodfZc3P3fc2cl2Zxjq4gmSRJcYsuNY9K6L6hYJQMkrL8Jfne+ZgN8InK81+c0UPoiuGtEUDuTOo/FR9QzyfqniJxrKag1dXHA7cwMqhGHjccuvLe4p1UeqUr95Inph3ug2MzL5YERF24HFsuielaCx9dVFZn+EUp4x3tJxfM42JS/Uld2u/jTZot0AJvmw4gLS9EQg3A6YcP7MqCSE7AFALM+YHRLuvSmNmoC830XayJUcj/57jcx4H/gH7kZ+f/9mgLuy7yD8zlXPQap/bxBRRN5k9he4pTVZR4YNMmDC3Ih7fJidsb0OOzeyR/VRVILFFrdQ3KGRMngaqOBNg1s2Pr51ZR5hqJmN2ELxoanbmaVQ/gXsIN1AWvcB9ZmwtB3c0Bq2qu11ayZwGLnP7Tz/gRKhwr42uNy7Ay6DoKIWZhkCJDGEUEIGzAL2iOEFZZ8m3lLi1mEDP4R0U0ZwaskS1nT5DbYqTkaUEAuDpPOXoodCAvBE8l7iC82fYO/W09POBWWKhyhUmm7wtRvHGRf7jfTmEFCC2FpG3dmt/TfooXCGJuFqo0lJiPsBUEHwi8YqInLFhzCy5tlq47ytkCS+doXETrERecsDF1bCB6yUtjyUp3GI32FfJZ4yK5VSwynXyoUqiXfpw05qyFpsSKAHXscn9G5xN0Tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199018)(33656002)(26005)(53546011)(6506007)(9686003)(316002)(83380400001)(4326008)(8676002)(64756008)(71200400001)(7696005)(66446008)(186003)(54906003)(66556008)(478600001)(66946007)(66476007)(110136005)(8936002)(52536014)(5660300002)(82960400001)(2906002)(41300700001)(122000001)(76116006)(38070700005)(38100700002)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3U5RE9pVTgvVDBhYmJBWkc5anVJOWN6anlhb28yQTlIRnFDRkQzUVFFNG9w?=
 =?utf-8?B?aGFZSExqd0hTc3QwbWNaV1l3ZEFRbG5mek5wS2RzTnVxd3NLUHlrZ09LZGlX?=
 =?utf-8?B?UzVkdTNSN2FZZ3IrOUZuR3djaTFjQzZPY1A1T2RpbFozY2RtOVNwa1l4bzJT?=
 =?utf-8?B?N0pibi92Rk13Z2gwOG5POE41bytOT2F4L29EN0N4YmN4Wm4wZTBWTXptRWg0?=
 =?utf-8?B?SnBjVzREWm91SXBoSTA5dFlvSVYxRjdjOG02N0NxZnM3NENmNjlUeGlDbG9P?=
 =?utf-8?B?bWVMRmF4TytHMVh4Q3ByTEhJRGNPWmRLRGlNVlZ5eVNPb1czTXZPT1pIUE1U?=
 =?utf-8?B?cWMreGNvTldlcHhWbW4wOHZqYk1XMm5LR016Nmc2Z0RaTTdWN2l6K1pub1d0?=
 =?utf-8?B?RzdQYWVJZDJqQmw5MnlEMXFzNHQrRTYzNTNzQS8vaHRsUHdiQXBDdGRqcFl5?=
 =?utf-8?B?aEM0dE5jSDEzTGNxS3AvTXBsd0xpV0M2NE10VnlyK3l2MXh6U2JsVmhnQ2RD?=
 =?utf-8?B?bDN5c1Qrd1A3bzlxVldPTlc3aGkrbmk5OFF6Q3NrNlFTOTIvVzVWZ05pTy9I?=
 =?utf-8?B?TVpMYWdhR0MxMCtLbXZ5K3Y4MTlNNXhaeWJreml4M0VzQVpJV1JEYklKWm9n?=
 =?utf-8?B?MDdCN2VmUTdoMUI2WlVGVm5QWmZxV1pzRHR4aTNpY3RvQzBOZUlpYnRWcDdH?=
 =?utf-8?B?V201YzQzTytLV0FrMXlESEdYd1doRFl0T1ZjVUhKZHFHSTBiWkIxb0FrSG12?=
 =?utf-8?B?MzJqVmVTSTF5c2tPUzBVSk5mRkgzYXV4QmJVcDgzc3luSk1SZVo5NFlsT3Ir?=
 =?utf-8?B?TnJKSm4waEMvMFpWbUhoclFQYmlIRGR4VjBGUllUWjQvdmJaL0M4SWwvZ1Jk?=
 =?utf-8?B?TjNQVVkyaHlUUlYxdnEwdnZhRmZXMDNycjhDR0VrSlFOZ25acCtZNkx6MDMr?=
 =?utf-8?B?UTg1a3d3RlYybHBhc2JQUGFmNFpRZjNZd0t6MXA1R3N0N0NGczZCSi9iSVBV?=
 =?utf-8?B?U1E4RDR0cENXTTJCREFGYnpyVUdBQUU2YlBwTU92SnA3NEtaMkEyNnkrKzJQ?=
 =?utf-8?B?aklEZnJjK0dnNTFMcjNDeUIycUk3R3N5aFlROEZndmRKMjlEZU9lR0V3VjBz?=
 =?utf-8?B?bTM3UmEvSWRWWVg5UWRYWDJDeHRLVWNjY0NPWVpDRW4zM1JhVncwRnhrOXVQ?=
 =?utf-8?B?bmpGcFAxVGY1V2Z3N3pnc2JONTRZdlZJdW9qaW9NenhZb0p2U09hL2dYUCsr?=
 =?utf-8?B?TnN1VEFsUjU1UGdGOWVuR0lPSjE3enduWmhGcDdULy9lVG5nR3YwczN5Y0hy?=
 =?utf-8?B?TlB5em5wNlp3VjBFeUI1SzFyNms0MGJ2eVd3OXcxVmViTkkzbklzNzhrc0Iy?=
 =?utf-8?B?Yk9vUWsxQVRkN1dieURtUEFUcTdJS0JxSnU2WlcvQ3NYUVlNRFoxY1NGOTE4?=
 =?utf-8?B?K2RBRDFaMU9SbzdOUVh4d1NBb2hIR3l4UXpLM0pwaU1maDB2MWswTE9admRP?=
 =?utf-8?B?T2lQNUNZUXNBUG5NdTU3SG9FY1g4SWpadTZMUTIzeGNNaVEyUWphUm55dmFo?=
 =?utf-8?B?bjZOOFhuOVIxWlQ2YmxNSEk1WUxFQUUzQk5OK2g3RVIxYVdGdG5YY3lURmtE?=
 =?utf-8?B?VDJwNnBKZHZLU3oxTTUxejM5Zy9CaDBKaEt1dUZnRHZwaFgwZFJSWU1DeWcr?=
 =?utf-8?B?UE5TR0wrNFFzUU9qUTRmSnpoalJkMllBSFdyaVViNzFlUEZHYU5ReEVUOWxW?=
 =?utf-8?B?eG9La20xNDN6U0lobUNIMWp0M0QyQjQ3TUZUL3Z4VTZRdTFFWGphNitTalI2?=
 =?utf-8?B?dnBWcFZyekZVeG1ta2JlK0VYb081SkxzVXE1bzVjTHgrSFJZbzhoVHJUU2Jz?=
 =?utf-8?B?aUhyQW9NSTB3WTdMZTFWN0RDVFZKT3BNRGxZTmE2ZC9RZkFrTUVpeEdZcWxa?=
 =?utf-8?B?RU1vT1FzSC90Y0tvY3ZONTNEVkxuZ0g1a0VYRWhSUVIrUHFuMERvYWw3SzMv?=
 =?utf-8?B?Tnc2RStSVjZSM2JEczhOYjJMa2dkdnFNWGFHWTdQUSt3eW9IRTl2cllucTdK?=
 =?utf-8?B?VU1melFOanV5WCtpN1B2bGZ1WlloTGQyUk00d1JsRXdHV0pGZmIvcWdnMWkw?=
 =?utf-8?Q?Rk0Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb5a53d-96dd-4c7f-6305-08db28da4b94
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 00:30:23.8742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dtjmFKzUhvgVocB4Do75sWDvF1cV7cDcfnww6PUHNdbmsiPFi+Epb/cOFw1PUmnQs9R4MRzsd6VTYj5uZFLvow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8053
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R290IGl0LCBUaGFua3MgVG9kZCENCg0KQmVzdCBSZWdhcmRzLA0KRXZlbiBYdQ0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogVG9kZCBCcmFuZHQgPHRvZGQuZS5icmFuZHRAbGlu
dXguaW50ZWwuY29tPiANClNlbnQ6IEZyaWRheSwgTWFyY2ggMTcsIDIwMjMgMTE6MzggUE0NClRv
OiBYdSwgRXZlbiA8ZXZlbi54dUBpbnRlbC5jb20+OyBQaGlsaXBwIEp1bmdrYW1wIDxwLmp1bmdr
YW1wQGdteC5uZXQ+OyBzcmluaXZhcyBwYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxp
bnV4LmludGVsLmNvbT47IGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KQ2M6IEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbTsgamtvc2lu
YUBzdXNlLmN6OyBCcmFuZHQsIFRvZGQgRSA8dG9kZC5lLmJyYW5kdEBpbnRlbC5jb20+DQpTdWJq
ZWN0OiBSZTogQlVHOiBoaWQtc2Vuc29yLWlkcyBjb2RlIGluY2x1ZGVzIGJpbmFyeSBkYXRhIGlu
IGRldmljZSBuYW1lDQoNCk9uIEZyaSwgMjAyMy0wMy0xNyBhdCAwNTo0OSArMDAwMCwgWHUsIEV2
ZW4gd3JvdGU6DQo+IEhpLCBBbGwsDQo+IA0KPiBTb3JyeSBmb3IgcmVzcG9uc2UgbGF0ZXIuDQo+
IA0KPiBGcm9tIGJlbG93IGRlc2NyaXB0aW9uLCBpdCBzZWVtcyBub3QgYSBidWZmZXIgb3ZlcnJ1
biBpc3N1ZSwgaXQncyBqdXN0IA0KPiBjYXVzZWQgYnkgTlVMTCB0ZXJtaW5hdGVkIHN0cmluZywg
cmlnaHQ/DQo+IA0KQ29ycmVjdCwgdGhlIHN1YmplY3QgbWF5IGJlIGEgYml0IG1pc2xlYWRpbmcs
IGl0J3MganVzdCBhIGZvciBsb29wIHJlYWRpbmcgcGFzdCB0aGUgZW5kIG9mIGEgc3RyaW5nIGJl
Y2F1c2Ugb2YgdGhlIGxhY2sgb2YgYSBOVUxMIGNoYXIuDQpUaGUgcGF0Y2ggYWRkcyB0aGUgTlVM
TCBjaGFyLg0KDQo+IEJlc3QgUmVnYXJkcywNCj4gRXZlbiBYdQ0KPiANCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVG9kZCBCcmFuZHQgPHRvZGQuZS5icmFuZHRAbGludXgu
aW50ZWwuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgTWFyY2ggMTEsIDIwMjMgNzozNiBBTQ0KPiBU
bzogUGhpbGlwcCBKdW5na2FtcCA8cC5qdW5na2FtcEBnbXgubmV0Pjsgc3Jpbml2YXMgcGFuZHJ1
dmFkYSANCj4gPHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29tPjsgbGludXgtaW5w
dXRAdmdlci5rZXJuZWwub3JnOyANCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgWHUs
IEV2ZW4gPGV2ZW4ueHVAaW50ZWwuY29tPg0KPiBDYzogSm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWku
Y29tOyBqa29zaW5hQHN1c2UuY3o7IEJyYW5kdCwgVG9kZCBFIA0KPiA8dG9kZC5lLmJyYW5kdEBp
bnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBCVUc6IGhpZC1zZW5zb3ItaWRzIGNvZGUgaW5jbHVk
ZXMgYmluYXJ5IGRhdGEgaW4gZGV2aWNlIA0KPiBuYW1lDQo+IA0KPiBPbiBGcmksIDIwMjMtMDMt
MTAgYXQgMTU6MzUgKzAxMDAsIFBoaWxpcHAgSnVuZ2thbXAgd3JvdGU6DQo+ID4gSGVsbG8sDQo+
ID4gDQo+ID4gb24gdjMgb2YgdGhlIHBhdGNoc2V0IEkgaGFkIHRoaXMgY29tbWVudCBvbiB0aGUg
J3JlYWxfdXNhZ2UnDQo+ID4gaW5pdGlhbGl6YXRpb246DQo+ID4gDQo+ID4gPiA+IC3CoMKgwqDC
oMKgwqDCoGNoYXIgcmVhbF91c2FnZVtISURfU0VOU09SX1VTQUdFX0xFTkdUSF0gPSB7IDAgfTsN
Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgY2hhciByZWFsX3VzYWdlW0hJRF9TRU5TT1JfVVNBR0Vf
TEVOR1RIXTsNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KmN1c3RvbV9wZGV2Ow0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgY29uc3QgY2hhciAqZGV2X25h
bWU7DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqBjaGFyICpjOw0KPiA+ID4gPiANCj4gPiA+ID4g
LcKgwqDCoMKgwqDCoMKgLyogY29weSByZWFsIHVzYWdlIGlkICovDQo+ID4gPiA+IC3CoMKgwqDC
oMKgwqDCoG1lbWNweShyZWFsX3VzYWdlLCBrbm93bl9zZW5zb3JfbHVpZFtpbmRleF0sIDQpOw0K
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqBtZW1jcHkocmVhbF91c2FnZSwgbWF0Y2gtPmx1aWQsIDQp
Ow0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqByZWFsX3VzYWdlWzRdID0gJ1wwJzsNCj4gPiA+IA0K
PiA+ID4gV2h5IHRoZSBjaGFuZ2UgaW4gYXBwcm9hY2ggZm9yIHNldHRpbmcgdGhlIE5VTEwgY2hh
cmFjdGVyPw0KPiA+ID4gRG9lc24ndCBzZWVtIHJlbGV2YW50IHRvIG1haW4gcHVycG9zZSBvZiB0
aGlzIHBhdGNoLg0KPiA+IA0KPiA+IEJhc2VkIG9uIHRoZSBjb21tZW50LCBJIGNoYW5nZWQgdGhh
dCBpbiB0aGUgZmluYWwgdjQgcmV2aXNpb24gdG86DQo+ID4gDQo+ID4gPiAtwqDCoMKgwqDCoMKg
IGNoYXIgcmVhbF91c2FnZVtISURfU0VOU09SX1VTQUdFX0xFTkdUSF0gPSB7IDAgfTsNCj4gPiA+
ICvCoMKgwqDCoMKgwqAgY2hhciByZWFsX3VzYWdlW0hJRF9TRU5TT1JfVVNBR0VfTEVOR1RIXTsN
Cj4gPiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmN1c3RvbV9wZGV2
Ow0KPiA+ID4gwqDCoMKgwqDCoMKgwqAgY29uc3QgY2hhciAqZGV2X25hbWU7DQo+ID4gPiDCoMKg
wqDCoMKgwqDCoCBjaGFyICpjOw0KPiA+ID4gwqANCj4gPiA+IC3CoMKgwqDCoMKgwqAgLyogY29w
eSByZWFsIHVzYWdlIGlkICovDQo+ID4gPiAtwqDCoMKgwqDCoMKgIG1lbWNweShyZWFsX3VzYWdl
LCBrbm93bl9zZW5zb3JfbHVpZFtpbmRleF0sIDQpOw0KPiA+ID4gK8KgwqDCoMKgwqDCoCBtZW1j
cHkocmVhbF91c2FnZSwgbWF0Y2gtPmx1aWQsIDQpOw0KPiA+IA0KPiA+IEkgb21taXR0ZWQgdGhl
IGxpbmUgYWRkaW5nIHRoZSBudWxsIHRlcm1pbmF0b3IgdG8gdGhlIHN0cmluZyBidXQgDQo+ID4g
a2VwdCB0aGF0IEkgZGlkbid0IGluaXRpYWxpemUgdGhlICdyZWFsX3VzYWdlJyBhcyB7IDAgfSBh
bnltb3JlLiBUaGUgDQo+ID4gc3RyaW5nIG5vdyBtaXNzZXMgdGhlIG51bGwgdGVybWluYXRvciB3
aGljaCBsZWFkcyB0byB0aGUgYnJva2VuIA0KPiA+IHV0Zi04Lg0KPiA+IA0KPiA+IFRoZSBzaW1w
bGUgZml4IGlzIHRvIHJlaW50cm9kdWNlIHRoZSAwIGluaXRpYWxpemF0aW9uIGluIA0KPiA+IGhp
ZF9zZW5zb3JfcmVnaXN0ZXJfcGxhdGZvcm1fZGV2aWNlLiBFLmcuDQo+ID4gDQo+ID4gLcKgwqDC
oMKgwqDCoMKgY2hhciByZWFsX3VzYWdlW0hJRF9TRU5TT1JfVVNBR0VfTEVOR1RIXTsNCj4gPiAr
wqDCoMKgwqDCoMKgwqBjaGFyIHJlYWxfdXNhZ2VbSElEX1NFTlNPUl9VU0FHRV9MRU5HVEhdID0g
eyAwIH07DQo+ID4gDQo+IA0KPiBJIGRpZG4ndCByZWFsaXplIHRoYXQgdGhlIGlzc3VlIHdhcyBh
IGJ1ZmZlciBvdmVycnVuLiBJIHRlc3RlZCB0aGUgDQo+IGtlcm5lbCBidWlsdCB3aXRoIHRoaXMg
c2ltcGxlIGZpeCBhbmQgaXQgd29ya3Mgb2sgbm93LiBpLmUuIHRoaXMgcGF0Y2ggDQo+IGlzIGlz
IGFsbCB0aGF0J3MgbmVlZGVkOg0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2hpZC1z
ZW5zb3ItY3VzdG9tLmMgYi9kcml2ZXJzL2hpZC9oaWQtDQo+IHNlbnNvci0gY3VzdG9tLmMgaW5k
ZXggM2UzZjg5ZTAxZDgxLi5kODUzOTg3MjE2NTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaGlk
L2hpZC1zZW5zb3ItY3VzdG9tLmMNCj4gKysrIGIvZHJpdmVycy9oaWQvaGlkLXNlbnNvci1jdXN0
b20uYw0KPiBAQCAtOTQwLDcgKzk0MCw3IEBAIGhpZF9zZW5zb3JfcmVnaXN0ZXJfcGxhdGZvcm1f
ZGV2aWNlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c3RydWN0IGhpZF9zZW5zb3JfaHViX2RldmljZSANCj4gKmhzZGV2LA0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGNvbnN0IHN0cnVjdCANCj4gaGlkX3NlbnNvcl9jdXN0b21fbWF0Y2ggKm1hdGNoKcKgIHsNCj4g
LcKgwqDCoMKgwqDCoCBjaGFyIHJlYWxfdXNhZ2VbSElEX1NFTlNPUl9VU0FHRV9MRU5HVEhdOw0K
PiArwqDCoMKgwqDCoMKgIGNoYXIgcmVhbF91c2FnZVtISURfU0VOU09SX1VTQUdFX0xFTkdUSF0g
PSB7IDAgfTsNCj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IHBsYXRmb3JtX2RldmljZSAqY3VzdG9t
X3BkZXY7DQo+IMKgwqDCoMKgwqDCoMKgIGNvbnN0IGNoYXIgKmRldl9uYW1lOw0KPiDCoMKgwqDC
oMKgwqDCoCBjaGFyICpjOw0KPiANCj4gPiBXaGVyZSBkbyBJIG5lZWQgdG8gc3VibWl0IGEgcGF0
Y2ggZm9yIHRoaXM/IEFuZCBvbiB3aGljaCB0cmVlIHNob3VsZCANCj4gPiBJIGJhc2UgdGhlIHBh
dGNoPw0KPiA+IA0KPiANCj4gVGhlIGNoYW5nZSBpcyBzbyBzbWFsbCBpdCBzaG91bGRuJ3QgcmVx
dWlyZSBhbnkgcmViYXNpbmcuIEp1c3Qgc2VuZCANCj4gdGhlIHBhdGNoIHRvIHRoZXNlIGVtYWls
cyAoZnJvbSBNQUlOVEFJTkVSUyk6DQo+IA0KPiBISUQgU0VOU09SIEhVQiBEUklWRVJTDQo+IE06
wqAgSmlyaSBLb3NpbmEgPGppa29zQGtlcm5lbC5vcmc+DQo+IE06wqAgSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gTTrCoCBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZh
cy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4NCj4gTDrCoCBsaW51eC1pbnB1dEB2Z2VyLmtl
cm5lbC5vcmcNCj4gTDrCoCBsaW51eC1paW9Admdlci5rZXJuZWwub3JnDQo+IA0KPiA+IEknbSBz
b3JyeSBmb3IgdGhlIHByb2JsZW1zIG15IHBhdGNoIGNhdXNlZC4NCj4gPiANCj4gDQo+IE5vIHBy
b2JsZW0uIEl0IGFjdHVhbGx5IG1hZGUgc2xlZXBncmFwaCBiZXR0ZXIgYmVjYXVzZSBpdCBleHBv
c2VkIGEgDQo+IGJ1ZyBpbiB0aGUgZnRyYWNlIHByb2Nlc3NpbmcgY29kZS4gSSB3YXNuJ3QgcHJv
cGVybHkgaGFuZGxpbmcgdGhlIA0KPiBjb3JuZXIgY2FzZSB3aGVyZSBmdHJhY2UgaGFkIGJpbmFy
eSBkYXRhIGluIGl0Lg0KPiANCj4gPiBSZWdhcmRzLA0KPiA+IFBoaWxpcHAgSnVuZ2thbXANCj4g
PiANCj4gPiBPbiBGcmksIDIwMjMtMDMtMTAgYXQgMDE6NTEgLTA4MDAsIHNyaW5pdmFzIHBhbmRy
dXZhZGEgd3JvdGU6DQo+ID4gPiArRXZlbg0KPiA+ID4gDQo+ID4gPiBPbiBUaHUsIDIwMjMtMDMt
MDkgYXQgMTU6MzMgLTA4MDAsIFRvZGQgQnJhbmR0IHdyb3RlOg0KPiA+ID4gPiBIaSBhbGwsIEkn
dmUgcnVuIGludG8gYW4gaXNzdWUgaW4gNi4zLjAtcmMxIHRoYXQgY2F1c2VzIHByb2JsZW1zIA0K
PiA+ID4gPiB3aXRoIGZ0cmFjZSBhbmQgSSd2ZSBiaXNlY3RlZCBpdCB0byB0aGlzIGNvbW1pdDoN
Cj4gPiA+ID4gDQo+ID4gPiA+IGNvbW1pdCA5OGMwNjJlODI0NTE5OWZhOTEyMTE0MWEwYmYxMDM1
ZGM0NWFlOTBlIChIRUFELA0KPiA+ID4gPiByZWZzL2Jpc2VjdC9iYWQpDQo+ID4gPiA+IEF1dGhv
cjogUGhpbGlwcCBKdW5na2FtcCBwLmp1bmdrYW1wQGdteC5uZXQNCj4gPiA+ID4gRGF0ZTrCoMKg
IEZyaSBOb3YgMjUgMDA6Mzg6MzggMjAyMiArMDEwMA0KPiA+ID4gPiANCj4gPiA+ID4gwqDCoMKg
IEhJRDogaGlkLXNlbnNvci1jdXN0b206IEFsbG93IG1vcmUgY3VzdG9tIGlpbyBzZW5zb3JzDQo+
ID4gPiA+IA0KPiA+ID4gPiDCoMKgwqAgVGhlIGtub3duIExVSUQgdGFibGUgZm9yIGVzdGFibGlz
aGVkL2tub3duIGN1c3RvbSBISUQgDQo+ID4gPiA+IHNlbnNvcnMgd2FzDQo+ID4gPiA+IMKgwqDC
oCBsaW1pdGVkIHRvIHNlbnNvcnMgd2l0aCAiSU5URUwiIGFzIG1hbnVmYWN0dXJlci4gQnV0IHNv
bWUgDQo+ID4gPiA+IHZlbmRvcnMgc3VjaA0KPiA+ID4gPiDCoMKgwqAgYXMgTGVub3ZvIGFsc28g
aW5jbHVkZSBmYWlybHkgc3RhbmRhcmQgaWlvIHNlbnNvcnMgKGUuZy4NCj4gPiA+ID4gYW1iaWVu
dA0KPiA+ID4gPiBsaWdodCkNCj4gPiA+ID4gwqDCoMKgIGluIHRoZWlyIGN1c3RvbSBzZW5zb3Jz
Lg0KPiA+ID4gPiANCj4gPiA+ID4gwqDCoMKgIEV4cGFuZCB0aGUga25vd24gY3VzdG9tIHNlbnNv
cnMgdGFibGUgYnkgYSB0YWcgdXNlZCBmb3IgdGhlIA0KPiA+ID4gPiBwbGF0Zm9ybQ0KPiA+ID4g
PiDCoMKgwqAgZGV2aWNlIG5hbWUgYW5kIG1hdGNoIHNlbnNvcnMgYmFzZWQgb24gdGhlIExVSUQg
YXMgd2VsbCBhcyANCj4gPiA+ID4gb3B0aW9uYWxseQ0KPiA+ID4gPiDCoMKgwqAgb24gbW9kZWwg
YW5kIG1hbnVmYWN0dXJlciBwcm9wZXJ0aWVzLg0KPiA+ID4gPiANCj4gPiA+ID4gwqDCoMKgIFNp
Z25lZC1vZmYtYnk6IFBoaWxpcHAgSnVuZ2thbXAgcC5qdW5na2FtcEBnbXgubmV0DQo+ID4gPiA+
IMKgwqDCoCBSZXZpZXdlZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiBKb25hdGhhbi5DYW1lcm9uQGh1
YXdlaS5jb20NCj4gPiA+ID4gwqDCoMKgIEFja2VkLWJ5OiBTcmluaXZhcyBQYW5kcnV2YWRhIA0K
PiA+ID4gPiBzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbQ0KPiA+ID4gPiDCoMKg
wqAgU2lnbmVkLW9mZi1ieTogSmlyaSBLb3NpbmEgamtvc2luYUBzdXNlLmN6DQo+ID4gPiA+IA0K
PiA+ID4gPiBZb3UncmUgdXNpbmcgcmF3IGRhdGEgYXMgcGFydCBvZiB0aGUgZGV2bmFtZSBpbiB0
aGUgInJlYWxfdXNhZ2UiDQo+ID4gPiA+IHN0cmluZywgYnV0IGl0IGluY2x1ZGVzIGNoYXJzIG90
aGVyIHRoYW4gQVNDSUksIGFuZCB0aG9zZSBjaGFycyANCj4gPiA+ID4gZW5kIHVwIGJlaW5nIHBy
aW50ZWQgb3V0IGluIHRoZSBmdHJhY2UgbG9nIHdoaWNoIGlzIG1lYW50IHRvIGJlIA0KPiA+ID4g
PiBBU0NJSSBvbmx5Lg0KPiA+ID4gPiANCj4gPiA+ID4gLcKgwqDCoMKgwqDCoCAvKiBISUQtU0VO
U09SLUlOVC1SRUFMX1VTQUdFX0lEICovDQo+ID4gPiA+IC3CoMKgwqDCoMKgwqAgZGV2X25hbWUg
PSBrYXNwcmludGYoR0ZQX0tFUk5FTCwgIkhJRC1TRU5TT1ItSU5ULSVzIiwgDQo+ID4gPiA+IHJl
YWxfdXNhZ2UpOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgIC8qIEhJRC1TRU5TT1ItVEFHLVJFQUxf
VVNBR0VfSUQgKi8NCj4gPiA+ID4gK8KgwqDCoMKgwqDCoCBkZXZfbmFtZSA9IGthc3ByaW50ZihH
RlBfS0VSTkVMLCAiSElELVNFTlNPUi0lcy0lcyIsDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWF0Y2gtPnRhZywgcmVhbF91
c2FnZSk7DQo+ID4gPiA+IA0KPiA+ID4gPiBNeSBzbGVlcGdyYXBoIHRvb2wgc3RhcnRlZCB0byBj
cmFzaCBiZWNhdXNlIGl0IHJlYWQgdGhlc2UgbGluZXMgDQo+ID4gPiA+IGZyb20NCj4gPiA+ID4g
ZnRyYWNlOg0KPiA+ID4gPiANCj4gPiA+ID4gZGV2aWNlX3BtX2NhbGxiYWNrX3N0YXJ0OiBwbGF0
Zm9ybSBISUQtU0VOU09SLUlOVC0gDQo+ID4gPiA+IDAyMGI/LjM5LmF1dG8sDQo+ID4gPiA+IHBh
cmVudDogMDAxRjo4MDg3OjBBQzIuMDAwMywgW3N1c3BlbmRdDQo+ID4gPiA+IGRldmljZV9wbV9j
YWxsYmFja19lbmQ6IHBsYXRmb3JtIEhJRC1TRU5TT1ItSU5ULTAyMGI/LjM5LmF1dG8sDQo+ID4g
PiA+IGVycj0wDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBIZXJlIHRhZyBpczoNCj4gPiA+IC50
YWcgPSAiSU5UIiwNCj4gPiA+IC5sdWlkID0gIjAyMEIwMDAwMDAwMDAwMDAiLA0KPiA+ID4gDQo+
ID4gPiANCj4gPiA+IFRoZSBMVUlEIGlzIHN0aWxsIGEgc3RyaW5nLiBQcm9iYWJseSB0b28gbG9u
ZyBmb3IgYSBkZXZfbmFtZS4NCj4gPiA+IA0KPiA+ID4gRXZlbiwNCj4gPiA+IA0KPiA+ID4gUGxl
YXNlIGNoZWNrLg0KPiA+ID4gDQo+ID4gPiBUaGFua3MuDQo+ID4gPiBTcmluaXZhcw0KPiA+ID4g
DQo+ID4gPiANCj4gPiA+ID4gVGhlICJISUQtU0VOU09SLUlOVC0wMjBiPy4zOS5hdXRvIiBzdHJp
bmcgaW5jbHVkZXMgYSBiaW5hcnkgY2hhciANCj4gPiA+ID4gdGhhdCBraWxscw0KPiA+ID4gPiBw
eXRob24zIGNvZGUgdGhhdCBsb29wcyB0aHJvdWdoIGFuIGFzY2lpIGZpbGUgYXMgc3VjaDoNCj4g
PiA+ID4gDQo+ID4gPiA+IMKgIEZpbGUgIi91c3IvYmluL3NsZWVwZ3JhcGgiLCBsaW5lIDU1Nzks
IGluIGV4ZWN1dGVTdXNwZW5kDQo+ID4gPiA+IMKgwqDCoCBmb3IgbGluZSBpbiBmcDoNCj4gPiA+
ID4gwqAgRmlsZSAiL3Vzci9saWIvcHl0aG9uMy4xMC9jb2RlY3MucHkiLCBsaW5lIDMyMiwgaW4g
ZGVjb2RlDQo+ID4gPiA+IMKgwqDCoCAocmVzdWx0LCBjb25zdW1lZCkgPSBzZWxmLl9idWZmZXJf
ZGVjb2RlKGRhdGEsIHNlbGYuZXJyb3JzLA0KPiA+ID4gPiBmaW5hbCkNCj4gPiA+ID4gVW5pY29k
ZURlY29kZUVycm9yOiAndXRmLTgnIGNvZGVjIGNhbid0IGRlY29kZSBieXRlIDB4ZmYgaW4gDQo+
ID4gPiA+IHBvc2l0aW9uDQo+ID4gPiA+IDE1Njg6IGludmFsaWQgc3RhcnQgYnl0ZQ0KPiA+ID4g
PiANCj4gPiA+ID4gSSd2ZSB1cGRhdGVkIHNsZWVwZ3JhcGggdG8gaGFuZGxlIHJhbmRvbSBub24t
YXNjaWkgY2hhcnMsIGJ1dCANCj4gPiA+ID4gb3RoZXIgdG9vbHMgbWF5IHN1ZmZlciB0aGUgc2Ft
ZSBmYXRlLiBDYW4geW91IHJld3JpdGUgdGhpcyB0byANCj4gPiA+ID4gZW5zdXJlIHRoYXQgbm8g
YmluYXJ5IGNoYXJzIG1ha2UgaXQgaW50byB0aGUgZGV2bmFtZT8NCj4gPiA+ID4gDQo+ID4gDQo+
ID4gDQo+IA0KDQo=
