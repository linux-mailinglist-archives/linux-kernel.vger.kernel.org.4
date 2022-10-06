Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC485F62CB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJFIey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiJFIea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:34:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267B6937B2;
        Thu,  6 Oct 2022 01:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665045261; x=1696581261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pbhMklSh43x3bKrg6UWoXQ8XWhRL3WYGm33DPAPX1sE=;
  b=tk3FIBTe1AChsqBMKz1NGNu3kGU8yv+A9n2lUUkqCwsoYhj7UeNhuJXD
   uQnla14KDd1FfGlaliSxKL+x04BU2CS0Lxl+88nDEB0keiha0+rd93kkG
   eD6FpH2CX5RCZLTkFgDnGwJc/oIcRz7t0KyyEAtqL84N+Fn5rV/WNf72E
   k7uclasB8KE1E/6YbfONfXg4xS1hX2Z21AWTHB7iP4dl/PCFNSCUMPdpI
   +iWBX3+2Kof9+Upj06UIyPX5qR/yRk8roMqbWkqo7pD0REYsznHBkhHut
   SNZpbhjK9HrNwXwk1hpVHi/uk4vqGokuQyZEUl5Lv0Z8bpv8sMiUwaqcO
   g==;
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="183533752"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Oct 2022 01:34:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 6 Oct 2022 01:34:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 6 Oct 2022 01:34:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apX+7JVndNfGWNeidGIqa9E1yiuuytDrOGLXtYlMAJC10FIiIaSp53ML6TIEqPYqxMVzPyiyycyAvu0a01vP/bMjUZUMHbMnjZUkzO42n1yNugdWkZEQgrzHx03kZThsw7yvEH4qiZ7BsFqaW+SI71pkFewN+eV65fz6qMMjVh9B2mWuu8Axrk2LNIXKgtQpcsBFR+U9bYcyO9XFoVZuP2ZCX7YEQxcdwc0v+H8qaARjjPjl/cQVX/94AfJxfkevtRteIgC2ejrBej/SYY7U3OrLqNh+DrmI5yHmzsgZg/BSGqVGTowO27SF2scGAHdcoNXt6mvDQuwP8Uvq4UB3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbhMklSh43x3bKrg6UWoXQ8XWhRL3WYGm33DPAPX1sE=;
 b=cT7WfaMzYMW+48Cm6l/mzGl4+Q31CszJSdQB7IS5q1Nd/BNKfSSll82iL/1waW3pNS8554JEsKnAVaF4IUqYXGMIEpfLg3UKZTyj6hvhg4nhcVDv1l4sPSUHzKfBEf/E17h1CsIPGdKmB69IMUh+WZuie6QCvqkRU7L0CfixI9jl3IL2td/78reo+LBJubAyzPVQEqr/Bj2FtieANm1guDhM6rKZciLKCYH6llrBe0xdtfVSBxnnsh3mVPN2pQGhO9RKaRghkEpPThsic+ev+QWPX9zjNWk5VKBrE2nhAuNNOkK+foh1v0IsPJKGnHtY7liK1mUl8UUMStzbbM9irg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbhMklSh43x3bKrg6UWoXQ8XWhRL3WYGm33DPAPX1sE=;
 b=aJ14kgu2E3C8drHySQCWWei9y+jq5Z7lxsXqWU3iuJUwWBUy4qKA5Kvx2rfqn57/rP2nmQnk5272PA6eFUYZfYU+ETdjqsP1ZgzNA/CadAcj6FSFY+Ipga6kE0Scj8EY9kYfRDcQ4LY7cMK2S7H3SCJ7/kUnog8H7JkaKecWfSQ=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by MW3PR11MB4650.namprd11.prod.outlook.com (2603:10b6:303:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 08:34:18 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 08:34:18 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mazziesaccount@gmail.com>, <matti.vaittinen@fi.rohmeurope.com>
CC:     <Eugen.Hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <alexandru.ardelean@analog.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/10] iio: at91-sama5d2_adc: Fix unsafe buffer
 attributes
Thread-Topic: [PATCH v3 04/10] iio: at91-sama5d2_adc: Fix unsafe buffer
 attributes
Thread-Index: AQHY2V5sDwsCRScU70Gx+GugRYdTLw==
Date:   Thu, 6 Oct 2022 08:34:17 +0000
Message-ID: <2d150d6d-17bb-3e18-3174-e769f4cc8417@microchip.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
 <be69775aa302159f088b8b91894e6ec449bca65b.1664782676.git.mazziesaccount@gmail.com>
In-Reply-To: <be69775aa302159f088b8b91894e6ec449bca65b.1664782676.git.mazziesaccount@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|MW3PR11MB4650:EE_
x-ms-office365-filtering-correlation-id: 51f7d0a2-1ad5-4c61-5d16-08daa7758f16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YCpRB4yvw063EOGEv2CdVr1wdPpRp3lZemloLMJmiT68GsR8FpMfpf6mdHMZ0LhJ0FMRtdq67iA/VjmejvGGqvoLz8lPYUaIbasKuAPEHGA7l0ikQjldAJXoeXQky19ONYZwFClk1YS9R4gqRSMFNwviLihATfLf6h66Aec7xgdJX1U9hTh+jgjDwLwSRI7EavcHX3nAjpoKTSuk39KU8yGWC781oFlyITv+PIBKIltJ8enGkBzEYESzdys8RpMzpJaagdVS4y7tLmdmvw9N49t3MUxVH51YOwI01aaEjDlOlQCbkPuABWxY8VPv0aq4ECycZzY1C3VnUi23zHKOeGILqq8fR8uTQkqJTX3vjGFGOg+8xer7hx1r/eTxzKSQ20EN1p9u2lm98FNrMzRAFYsQr+TS3UqOavhPmxXlGKFiA/5aNvvHDhSzGYmzakt6oBlRU1WeLuhPvgiYY1PwDtMt8g4vm0rrN+KTy3XcBNgFQPuHFSgHWPukSTDSZCE5m+bIkPSUjepTtY+tXtp9gwQS4zygnJXzJNUSn8X6l30RAJaYysu3Et5UaFfRW2VTe9kfav7RP/jdwIcHcxawa1gHuuL7YcNgXSS+VaSSdOVoedPoxd+vraFtggP1kZUTH+SgpMULJwEsDERAQX3Wey9uLHty7qzjWqe1Rg1csAE7hOi56zbfUHCs2JjTlQOt4/7HqfD5EdzBUukPgw0Eeo2RGvNcAt8z8fjM3HPdQdl7DNHsqSB7736u1GqL0BL7A7UKR81iVhx63sYOscig0f9Cdnsa2fGP1S9g4u4YwrojK+4/mBXm/Ud4B7k9kxqk3rCICYfLsNAh3eR8bp1bvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199015)(31686004)(122000001)(36756003)(38100700002)(2616005)(83380400001)(186003)(26005)(38070700005)(6512007)(86362001)(6506007)(31696002)(53546011)(6486002)(478600001)(5660300002)(4744005)(2906002)(71200400001)(8676002)(8936002)(41300700001)(91956017)(316002)(110136005)(54906003)(4326008)(64756008)(66446008)(66556008)(66476007)(76116006)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dU4rNkpPVm4vbnVwbEhoWEdnanhKSER4ZUVLU1ZqL3puQVlmSDRDdUNSeVpN?=
 =?utf-8?B?cUxRR0p0UTRCaldCS3YvZmxkSGhQOUhlcEVuNWNJVzRmajE0enA1UjRXdm5h?=
 =?utf-8?B?ZVdpNGExWW5UbDNLa1R5c0MyNVBBOVJUYTBLR1B2NlBOMGdBVjQvblR2YU0z?=
 =?utf-8?B?MkhGemJYV2tCSVF2Qks5Q285Mm9TZGZwbmIvWWhrQkdnVEZGR3NMTTJiL3Fv?=
 =?utf-8?B?bXpuM2cwazZDNjMxVUttUlVzVzA3K3RyNFd1NS9VOXVmKzQvRkVUMTJZYVd5?=
 =?utf-8?B?MjZLdDBOL3BzVm05K011VjNTTk9kalg0YlhmNlZHZE9FTjFLZ2QwN3ZKSzNu?=
 =?utf-8?B?d2tDSS9mNHZISXVFYytVQkdpbElrc29uTC95eWl1cEV5bkwwREhqTXd0REJx?=
 =?utf-8?B?VUZ5UStySjUwK0tkeGRJMG8zNlNTV1lmZGRRekFqbGxFSnR6WitFTE9ZMGRK?=
 =?utf-8?B?cDBHYTRmd01tZzZiL0VRZzBvWjluVGVHekRIQlhHY1pMMkRFSmNyejVwcHBj?=
 =?utf-8?B?M2xBRmtUOC9KTFVicDVSRDcwUmhKY0thVElSUit6UmtYS1UxZXpRa3MzRnlB?=
 =?utf-8?B?NW1mQVlFRWtpWW52NVpBakoyNXNVSkhYMUR0L1pUY3VUNEQ4KzFKQ3hybk1H?=
 =?utf-8?B?VVhXZnFmMTQvakpLSCtOYnJuUkhSczVhcUZFeGpwWHVreTFleGNCV0dnOE9Z?=
 =?utf-8?B?cGVwSEs2UUo5Q3ppajhmNUd4WFZpSDVJdzY3M24ybG5EUXhDQWhTTG1rMDZG?=
 =?utf-8?B?dVFIMnRBOHRRZ0hOYnk3cWUweGxuUmZYbWp6SFBhZzRrQnhtYkxRUkhOdnZS?=
 =?utf-8?B?TkVLWHA1UHV4Z0tuUXlNWUQycno1UE1ZNUxuQkw0T2pTUjdSU3drZ1o1OHVS?=
 =?utf-8?B?S0d4clQxTkVvMjdIekFHR2FWYytBaHcyMTVaU1NvYWlqRGgzZktqT0FTQnB5?=
 =?utf-8?B?Y1BFVnQ1K0E3RFBEL044U0xnL0l0WWM3V1dmWENOZXYxdnN6TGQwWFE2M0xw?=
 =?utf-8?B?bTdSZUM3T25WaWJzTzRvM1lVaUlKcklROGFYTTIxRDFWY0l4dk9yc3dkT2h6?=
 =?utf-8?B?OEQwY3ZQRGtPaHRYV3k0WUREdWo1MTFrWWVXT3FabkNpTk4zYklHa0Z0U1Mv?=
 =?utf-8?B?eWduejlBUW9nRXlHRUQyRjJXV0F6WHZrcUk5Rkc5YVpTVnA5MUZhUVE3N1Fu?=
 =?utf-8?B?QmxZQ0QvNWtHTE9yN08zZmdhLzdVNEIwME1tSFNzQkJ0VFphV2pFbkJxYmpt?=
 =?utf-8?B?RUtrbkJLOFkwT2VqZ2ZhNFVRQlNvbGVqeW9UT1QvdDQyK25XUnVoY0dlZEgx?=
 =?utf-8?B?YU1UVlN3ZCsvYWZpUThKMWZqVHlHNUJLcVhkbUFYUTJpd0RRVzdoajZLdExh?=
 =?utf-8?B?Z01sYmhpYm5RdndlSk1QVWs5aU1mV0lucUY3akZCNDltcG5PaWpoZG9Eb3py?=
 =?utf-8?B?c2xqcmtHRkxvd2hydjRqRlF4SEY3UFpDYUd5cElpa3dzb2l4dGRRUnpzZnEz?=
 =?utf-8?B?Zi9RWGJoU2VyWFd3YzM1NGJQa3dTUWViUzVsY0pqM0hRd0RxUlNIRk1WY3VL?=
 =?utf-8?B?cXMzQUtHR0UvZWtnczNPT1E0OVhMRENpREZLeG9oaDk4bWtDVHkvUDRONkxC?=
 =?utf-8?B?OWtndU1BM2NPckdjTVlmaGhBazdyS2ZOWlRyeC9kbDZHdXE1YnV0UU9Kc3h2?=
 =?utf-8?B?elVhSm1ZTzgwQmdMNWNuN0hzaVlRRFBWVm9rVWo1V0MxNFR3bytSbmxWcGRU?=
 =?utf-8?B?WUwxT2syRWRrNThMSTM3ZndHMXgrNWJiTmtYeGpLcmxscVBHSno0c1RSdU9z?=
 =?utf-8?B?QTE5Z1k0akNCWmtQRklteTRQK2FqZWJiZWlyMkowa09kcm9lTkpMdkZGVmZB?=
 =?utf-8?B?WXRCZVlQSnU3OUNCZmR1K2llaHpvbVEyWnZQUWJKNEhLM1lLRTVFekdUNzk5?=
 =?utf-8?B?bDJnRC9BSlVmOWJMcVFYKzUydlZuRXNhekYxam5aVnkxOE45bHQ2R2MrK3ZD?=
 =?utf-8?B?SFA0TUZZWm1lWkdTT2llQkl3N0VzWUo0QU1TZHljb3M4Tk9VU1FueVp4NGE5?=
 =?utf-8?B?VnJsRGNBRjRvQldpcmppSUlBMXIrc1NwdGFDSmJCaksxTU16ajYxc1F6OW8r?=
 =?utf-8?B?VUlGZnNUNHNhUWRheUcvNk1iNFdlRXFSeEtzOUJ5eC9tRHhCbHFLVkg2blJZ?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <587102F486182143803ACA6434841305@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f7d0a2-1ad5-4c61-5d16-08daa7758f16
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 08:34:17.9341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lMX+LzuN7oYTIQrEGzD8mgXHc+OIebetBrjlUmekFzQDXXhSzeRV+CpUEh8FFM4WNb+cZOFeU8nVP6VQ2OFGzHM/WZPnrNQkDhe4RgmzAu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4650
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMTAuMjAyMiAxMToxMSwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPiBUaGUgaWlvX3Ry
aWdnZXJlZF9idWZmZXJfc2V0dXBfZXh0KCkgd2FzIGNoYW5nZWQgYnkNCj4gY29tbWl0IDE1MDk3
YzdhMWFkYyAoImlpbzogYnVmZmVyOiB3cmFwIGFsbCBidWZmZXIgYXR0cmlidXRlcyBpbnRvIGlp
b19kZXZfYXR0ciIpDQo+IHRvIHNpbGVudGx5IGV4cGVjdCB0aGF0IGFsbCBhdHRyaWJ1dGVzIGdp
dmVuIGluIGJ1ZmZlcl9hdHRycyBhcnJheSBhcmUNCj4gZGV2aWNlLWF0dHJpYnV0ZXMuIFRoaXMg
ZXhwZWN0YXRpb24gd2FzIG5vdCBmb3JjZWQgYnkgdGhlIEFQSSAtIGFuZCBzb21lDQo+IGRyaXZl
cnMgZGlkIHJlZ2lzdGVyIGF0dHJpYnV0ZXMgY3JlYXRlZCBieSBJSU9fQ09OU1RfQVRUUigpLg0K
PiANCj4gVGhlIGFkZGVkIGF0dHJpYnV0ZSAid3JhcHBpbmciIGRvZXMgbm90IGNvcHkgdGhlIHBv
aW50ZXIgdG8gc3RvcmVkDQo+IHN0cmluZyBjb25zdGFudCBhbmQgd2hlbiB0aGUgc3lzZnMgZmls
ZSBpcyByZWFkIHRoZSBrZXJuZWwgd2lsbCBhY2Nlc3MNCj4gdG8gaW52YWxpZCBsb2NhdGlvbi4N
Cj4gDQo+IENoYW5nZSB0aGUgSUlPX0NPTlNUX0FUVFJzIGZyb20gdGhlIGRyaXZlciB0byBJSU9f
REVWSUNFX0FUVFIgaW4gb3JkZXINCj4gdG8gcHJldmVudCB0aGUgaW52YWxpZCBtZW1vcnkgYWNj
ZXNzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF0dGkgVmFpdHRpbmVuIDxtYXp6aWVzYWNjb3Vu
dEBnbWFpbC5jb20+DQo+IEZpeGVzOiAxNTA5N2M3YTFhZGMgKCJpaW86IGJ1ZmZlcjogd3JhcCBh
bGwgYnVmZmVyIGF0dHJpYnV0ZXMgaW50byBpaW9fZGV2X2F0dHIiKQ0KDQpUZXN0ZWQtYnk6IENs
YXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQpvbiBTQU1BNUQy
DQoNCg0K
