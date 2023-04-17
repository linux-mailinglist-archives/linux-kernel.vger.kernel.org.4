Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C3B6E482A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjDQMrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjDQMrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:47:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F27191;
        Mon, 17 Apr 2023 05:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681735649; x=1713271649;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FuKaNLFsqJkP+8TZKpbvOKV5a2Y9WHUN59AcZlsSamE=;
  b=pbz0pJNoZLPaiurF3cQHXryKu60071jx+0gqHwvNH8QCDtEjDXgBJcCU
   8ErJOQ7K81VNmx8fH0pJZuW5D0floWGHqcSryOmGAcBqcg8eAsZ3zp8MG
   ot7LM/iaqVCMwn74QUQB9tFQxOMx0zXOwtex/o7IiHCLOr69OdIgbPQWb
   qcoEffUN/0yGZHhvRjGO8fIq92HPP32cNAKVnUKSxz5wIxJivELPoUH5u
   Dhaa1yBU4lVUw3u6/91I2MktEE+vJYpLr1yMfofDKthQj2OPzebjPY7gi
   hEWRdN/+KPczunF9KqJaBO7wzLfWZFGe8yxmoBATxykifFFp1gebZCGmV
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,204,1677567600"; 
   d="scan'208";a="209400059"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Apr 2023 05:47:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 17 Apr 2023 05:47:22 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 17 Apr 2023 05:47:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiT9cP9xHaJ0u7a/ixCC2isZ/9vT9X1KvGJ6eKb22Sn0WZPSmelHtrDEET+/0hOqynnl3vJefrnmvwVOqp15/PsPZT0J9aPybR2OUml+s4Yzt0/g0bW1NzmxAPnBA7x6f8jZ1efz6INZ/17cE+ZCARrkVj0CgLzB+mgOoE0o7VKSQJfMTnykYGznNZc569B0PGjsTxlIX2HwSQxW+UOvgfKqLSI9rbiSblWgBA5tW3qMMkd28GZ4xgrROlpNs+N/v7Es2pywZl7uGd0JCm7utjPJzTQudfBOljRrlc9XqLLmuDxV8vaCcFo+2HWTEapIigqKUniPN8l/80USxWyBQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuKaNLFsqJkP+8TZKpbvOKV5a2Y9WHUN59AcZlsSamE=;
 b=HsqZGf8LO7sPXTCoG7A0TD7nJtkYjcn0C43pTjDHD/GnyODfnD6vmfGFpHL2+4I1gV2lwAcXKHamX9yVaTv8f46IStFKa/KsltUJcJV2ZmUKdVJ3xf8WJhIOjsd+qIElKdb0jhGNQUeV3ksJaPBr2xymWPnqa6icfbK4qX9Z+9dFYIT5MMNruBpHfpg29ez+GnLA58YvmQtLyrh0XggM55gs1EikIqIFNgazw4kU0u4MONtWhJ2T29lF9IGn0gFUwfBEBG82/dK4JVhuVYc0iPTxGKNqtpxRnz9lFi1IFgN3AxbitWBgdbOA6XR3VZL4zfn5yc4IiFv8JyFNM1BPUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuKaNLFsqJkP+8TZKpbvOKV5a2Y9WHUN59AcZlsSamE=;
 b=s8w7xCwv2MGOSVfvoHo1Uae5igaOVrsxMXrZ/N003zOlAweyXap07QTxXM7VIcnHoAH5W6/37ioQ+UG7+GhoawkEanl1YwuQz6yArsmyb1QUc2Dw2jF8VRk9aUNb6j/Quv2TDzgBLWovhbqqPpUVHLRboqCvaDp0I9EzkdQZK9s=
Received: from DM4PR11MB6238.namprd11.prod.outlook.com (2603:10b6:8:a8::13) by
 SJ0PR11MB5053.namprd11.prod.outlook.com (2603:10b6:a03:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 12:47:20 +0000
Received: from DM4PR11MB6238.namprd11.prod.outlook.com
 ([fe80::4f91:f62c:a55e:8589]) by DM4PR11MB6238.namprd11.prod.outlook.com
 ([fe80::4f91:f62c:a55e:8589%6]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 12:47:20 +0000
From:   <VaibhaavRam.TL@microchip.com>
To:     <michael@walle.cc>
CC:     <gregkh@linuxfoundation.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <arnd@arndb.de>
Subject: Re: [PATCH v9 char-misc-next 1/2] misc: microchip: pci1xxxx: Add
 support to read and write into PCI1XXXX OTP via NVMEM sysfs
Thread-Topic: [PATCH v9 char-misc-next 1/2] misc: microchip: pci1xxxx: Add
 support to read and write into PCI1XXXX OTP via NVMEM sysfs
Thread-Index: AQHZbfZJz/zmDIu/UkeVapWon7U8Zq8paGUAgAYRcYA=
Date:   Mon, 17 Apr 2023 12:47:20 +0000
Message-ID: <49405ea2bb0bee16a41ce88b7d679ff714823585.camel@microchip.com>
References: <20230413105318.6070-1-vaibhaavram.tl@microchip.com>
         <20230413105318.6070-2-vaibhaavram.tl@microchip.com>
         <51847629489852d493af928580c5a2de@walle.cc>
In-Reply-To: <51847629489852d493af928580c5a2de@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6238:EE_|SJ0PR11MB5053:EE_
x-ms-office365-filtering-correlation-id: 2ec9c333-01c5-407c-5986-08db3f41e256
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xzHOm4Izoql1dlyG+qH7Gi2YpG4i+kz9oO4gsc83DYqFO0/TvcQy+xUsCyo+WjdANx192SESEanLOyqZVAhBxcZRu7fTnAI8vbPfa4TPVc2CgPYSfVsHHytP0UPb1oVR4+MPj0GUYtftdAkPZfSU0zhoet/Q5Bm5ui17lIj//d+XjeW9voSYan3hP49zsMDLsenYyGFu4wJ3wkVfum5Am6y8d6tLUyXWHrx/IRAQ6JNN34lX50FJeQkgg5c9ToENmdgpiww1PgGwXoQT0AY2+/CSfoDkZIj/iaD0ZaiFNsRaPFtcMQeuopyTlJiEWno7DL8BmybNcZ2hHyz+Qo+WqoD7+D236GaY8118892nD3CUiCe9U0d99fFEI/TBhjOarA6MTiz1ZBvd1SiQ6I/G9nfNZUbs7SzfjdUMJzl008KkhxyiasYyRLfWsNRlOCLzWSxoTnUC+LDfDjY65gRl7DuDQV9IkmBVpI1VZ2ZMr7WtV1UcqIcNdP+Jxlt7h1qApA1PDkOoE+e+3YpAWLJlkNI4C84FcTpsFtim4Wk1UVo74Y/TEHhebZxNIfD8UfrUYGQSokwo4BoOrOOVeLKuBJxhVmkQ1TfNJ+vPYRnpfW6Oel/S0A4PpbO4M1a5GCfy4Z7dqCoTOG4g6Y0izYGgAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6238.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(54906003)(478600001)(66476007)(66446008)(64756008)(6916009)(4326008)(66556008)(91956017)(66946007)(76116006)(26005)(6486002)(71200400001)(6506007)(4744005)(2906002)(41300700001)(316002)(8936002)(8676002)(6512007)(5660300002)(122000001)(86362001)(36756003)(38070700005)(38100700002)(2616005)(83380400001)(186003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVZKTHVMcGpsL0RLS0huempqSThnaEtHc3Y0aUk5aVBmaURhNnJiSHJPMzRV?=
 =?utf-8?B?L1FDNDIwdkZxaVdGWEJBMHlUWGwyU2l2U3NVcUh5aU04QkhFQlV2TWwveVZa?=
 =?utf-8?B?QjFKZUJSdkNFVDRSTUtBMlZFSmNiNTZ0a3doZzJlKzkycDdHNjFIRVZnL3dS?=
 =?utf-8?B?a3lWcjdseU1rT3NpQzJmOWdoQVQ2dVlXYW5YRXJBeW1mU2dUWW05L3BIcVM2?=
 =?utf-8?B?UEtqT01idVBzSjl4QjVzU2J2MXkrNFBtdGlzSGRYUDVkdHZYbEZseVQzQ0hP?=
 =?utf-8?B?WUx2WGVmc3RKZ3dzS2RBdDRCWG1mUVFZRy9ObWlFbXVtdWNOL2YvZGVQQzdi?=
 =?utf-8?B?Z3hTMWlrb1VjZ1o4Y2NuSG5tOTVJQ0xEMG03cXdTT3hkbnU5a3Vpd0huejdQ?=
 =?utf-8?B?YmdOc0NKYldFUjRIOVZ3akR6dDI2SnJ4Wmc5TlBQZlQ2ZUZtTEF6bExYRzB3?=
 =?utf-8?B?bzJ5RkZQRzRvOWNYeEJ1ZnY5czgrZVF2WDhrRm1pajlBaEZQMzJIa3ZjNG5t?=
 =?utf-8?B?UW9wUVVVck94M0JncWd6NkZMVkZkNWJRTWREbkkvbS9Jc1BDUDB1b1VWNDd2?=
 =?utf-8?B?MEFZeWdOeEJkOHpRL0NUS1ZrMHZEMGRnL3ppaFZJYVgyNUtQVCtXa0doR1ZK?=
 =?utf-8?B?VlNpb2xaUDVvd2V6VVVuWmYzaHN3ZlZnTW9vR0NkR2ZvRlhQcXRjNURVS0tT?=
 =?utf-8?B?RWhIWSsrMm50WnpmQkxVSkp6dUErMHk1bWlSMDh0YndqeU9ybGlpYkdvYlUy?=
 =?utf-8?B?NE1oSCtUMWZ1V1BPVk1VSlpaN1JUZWRpSGtxdy9PVGRFaEpHVTF4ZUZzbEVl?=
 =?utf-8?B?MmFqK2FvMlUrRCtIT3ZWWmJyWmc5ZyswWkNuWDZ6YkxjSXdWK1FDek5HMFRI?=
 =?utf-8?B?NjZoL3BNMUJBcmNobzgzSG9GVjdrMlExK1JFckhFRHA1eVJuTkdURkZBNjlG?=
 =?utf-8?B?Tk1tUGZ4SXhuMm5FQklJZ1BlbGVvS0IzNkFCaXpzYWxmbzhEOUoxamJwV0JT?=
 =?utf-8?B?d1NzTk5tY0lYNkYzRDQ3OTJaWDN2NFRNejNqcUdkRk5hWklvRGdHWkxRb29T?=
 =?utf-8?B?QkJiemh2bm11a1pFaVdQWnZSM1MzRDc3NjRBRU5uRWNWMkRVbEREY3krQndX?=
 =?utf-8?B?RCtqZi9HdXlHUloxOW1RT0sxRzBpbEZWcC9iRWFFNFl6VTJVd09Na291aWpP?=
 =?utf-8?B?OEp1MW5PTnZkRnB6OFBodjFkUDhvSDNXSnlQOEFxVCtzY3lUWUdOK3dzR3NQ?=
 =?utf-8?B?MENPMGZtdHhXSWRwbnJCVTQ1dzMrdGc2TlgzV3NzaWRRN2tocmtkMVVYVkVm?=
 =?utf-8?B?SEE4YUZ0OWVZMDJtWEtmaTRSc1VTZTJaanAxRHR3WHovRHJxb3NmK1ZwL0xJ?=
 =?utf-8?B?ajF5ZWliNmNEY3RkYnZmRHM3V2Eza0ZlR2F3YUJMMnZMeEVmRG5ET0JLOG9x?=
 =?utf-8?B?REdxU2M2S3FwOG43U2s4NDJkaExmMHIzSnIzNUJCM3RiRlVGK2F2S1Iwa2ZP?=
 =?utf-8?B?UzlxczIxUjF2Vm0wQXd0MG9GZzN5WnRVM3pYNy90ckUxUjJtaWt6YjhpNFBy?=
 =?utf-8?B?QzE3NDVUZmd1b0E2OXg4UkJXYTFNREdFUFdneW1WNnltQURvd05OZGg0QWtQ?=
 =?utf-8?B?K2V1d1NqdHVqb0k4VlJYditNU0N5dDJvN0Z5REkzMnlJMUNLQm92OVk1LzAz?=
 =?utf-8?B?MDBpVnpMWFh2RE9RQjhYZEZKb3dUT0hsK3lVNzR2ZnRmTVE0TVYrYjNXUS9I?=
 =?utf-8?B?aEsySkhNaWhWY0owcElpblkzcjhxYzM2QXBjL1p4ckhseFVyaFBkdnQ2UFdo?=
 =?utf-8?B?cmp5YWRMZUlFQUZ6cndiOE45QVhQTXQ5RHdyWWhHU3NTdVhZSEdQYjZaTTAv?=
 =?utf-8?B?TG1NUldXT1RVYnh5akZZTkdpbmNRQkVMZnJtNmZsWWJ1L1ZEUGQ4a3dSYUFH?=
 =?utf-8?B?QVJwMUg0bnVsaUQxRjJwRnFhT1ZTc3NDM09GZWFBWTFnZ2tHY0NndnpFOVR5?=
 =?utf-8?B?Q2JXc0w5dUFwb1hLUkdqTHBrZUNpVWJ0Nzk4U1VwYjQxcFlDNStXVmJNeW9l?=
 =?utf-8?B?TkFxTHd4RVEzRklwc0Y2bTFHV2NxZytKNmpqbzdEOGE2Y2pmZHY5ZUtpa2ND?=
 =?utf-8?B?UDZEVUtJS29MR2dEM3ZGdkNRSjFMYmNLaWJtL3pMNWVNTDJqUnNGNTZZN2Fw?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <613BBEA85FDF254CAE8EB1426D3EF223@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6238.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec9c333-01c5-407c-5986-08db3f41e256
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 12:47:20.5347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RsgyYaAmqSk3y3A9rtoOst8nBjDc1fjqUofqbDDIf5R4SvCRnb849H/tP+gTRP+4v/61WVvXYW7rnNkoX9vCh8WK/h+e/A8EvV9B2U4CfI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5053
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4gPiArI2luY2x1ZGUgPGxpbnV4L2F1eGlsaWFyeV9idXMuaD4KPiA+ICsjaW5jbHVkZSA8bGlu
dXgvYmlvLmg+Cj4gPiArI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPgo+ID4gKyNpbmNsdWRlIDxs
aW51eC9pb3BvbGwuaD4KPiA+ICsjaW5jbHVkZSA8bGludXgva3RocmVhZC5oPgo+IAo+IElzIHRo
aXMgbmVlZGVkPyBJIGRvbid0IHNlZSBhbnkgdGhyZWFkcy4gQWxzbyBiaW8uaC4gUGxlYXNlIGRv
dWJsZQo+IGNoZWNrCj4geW91ciBpbmNsdWRlcy4KT2ssIFdpbGwgcmVtb3ZlIGluIG5leHQgdmVy
c2lvbiBvZiBwYXRjaAo+ID4gK8KgwqDCoMKgIGlmIChwcml2ICE9IE5VTEwpCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJiID0gcHJpdi0+cmVnX2Jhc2U7Cj4gPiArwqDCoMKgwqAgZWxz
ZQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT0RFVjsKPiAKPiBVbm5l
ZWRlZCBjaGVjaywgcHJpdiBjYW5ub3QgYmUgTlVMTCwgcmlnaHQ/Ck9rLCBJIHRoaW5rIHRoaXMg
Y2FuIGJlIHJlbW92ZWQKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGF0YSA9
IHJlYWRsKHJiICsKPiA+IE1NQVBfT1RQX09GRlNFVChPVFBfUEFTU19GQUlMX09GRlNFVCkpOwo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0IDwgMCB8fCBkYXRhICYgT1RQX0ZB
SUxfQklUKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJl
YWs7Cj4gCj4gTm8gZXJyb3IgaGFuZGxpbmc/CldlIGhhdmUgaW1wbGVtZW50ZWQgc2hvcnQgcmVh
ZCB3aGljaCByZXR1cm5zIGNvdW50IG9mIHN1Y2Nlc3NmdWwgYnl0ZXMKcmVhZCBhbmQgdGhlcmVm
b3JlIHVzZXJzcGFjZSB3aWxsIHJlY29nbmlzZSB0aGUgc2l0dWF0aW9uIHdoZW4gdGhlCnJlcXVl
c3RlZCBjb3VudCBpcyBub3Qgb2J0YWluZWQuCj4gPiArwqDCoMKgwqAgaWYgKCFwcml2KQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZGV2X2Vycl9wcm9iZSgmYXV4X2Rldi0+
ZGV2LCAtRU5PTUVNLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiTWVtb3J5IEFsbG9jYXRpb24gRmFpbGVkXG4i
KTsKPiAKPiBKdXN0IHJldHVybiAtRU5PTUVNLiBObyBuZWVkIGZvciB0aGF0IG1lc3NhZ2UuCk9r
LiBXaWxsIHJlbW92ZQoKVGhhbmtzClZhaWJoYWF2IFJhbQoK
