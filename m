Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857EF6522C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiLTOhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiLTOgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:36:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93961C412;
        Tue, 20 Dec 2022 06:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671547001; x=1703083001;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U+ZqQQE5YNogzNRDrfmFt99El9vDYVtdIbYXX2WLgv8=;
  b=ct3oa7TXVgbP0EjO6cdxzBcZ7rhfI4StUJeB7tiWc/CJrCZh+qNQYW8u
   donnUzPamvOlfTfUn8u3Gvnxu77g9SB2iqcrIAyGRgWUek5QpJVGPRKKi
   ARwd+HTm69ob/o4iZJnP9tqlNcCYKUPqZC7zoZSjPOxHY3gtiUav6ZIS+
   BU4eXdHGKQ67FVjAskNLV5nSeml1YnsI2qcMCH5KjrvNbEXhU26xZ//0x
   LG0Ttq17pTgfm0Ctwk+E0mPN4a76BOkxCTFqEMhTQWUbiRIvX7BgtG6yB
   5zv1Hy3vr85HSKDAkw+M454sH4tFhgnMc0y8qzW5Ibc0puiZfzpsZqoSt
   g==;
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="193825054"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Dec 2022 07:36:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 07:36:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 20 Dec 2022 07:36:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1gUHgasY91uAHTjTxSR/s57sAqjYTt/rqLdqmkM/v48RRZfHZ0EXNnrtFOj7uJN71pAda0xfNthJlwSoVKtC1at9DpVkPUuPH9FsZ9nEXOH4+kB8pdy5iLFAuq6lWcHkuOcR4nMgiXBAOBEyAmG7FsXer9vo8BDiWV45oaE5eJzzAO0eD/bDWLrWN28DJttUCeMK/fdHMo/XuVNgYHPY8cpp0n09/dqEVHRachsiVV6k8+Ftc3jrai66mONNSsta/Jo47Cwpz8BbsEFE7zUZqRSI+ArizfvQL7XWoAJONjrgI2gf/Gmim6rJROOxTU9NXUjuUabPeyWo2G+GJn1GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+ZqQQE5YNogzNRDrfmFt99El9vDYVtdIbYXX2WLgv8=;
 b=gUIIN3sXZs7fkBKFTFnUgPlUnLL6Uroq4xR6057WV2EUSq1Tc+KvI0PC3i/Gin8eHintkK0wmbgH70Pg9Sg001gGaA5gL9vCbtElsotCIJBLdeEYKqXKgsNDUMtMBXLwGHiolvgQfDLlthlB6EOvhRw66VvWnuAVihxEZzeZeVhbBH+fAokYl/qX4ItEV2Zn/0R+2i5waF4E9J/R5W+HPuu6D0b6K6zOng/JYPhzUqucNu2X8v6KTjj+7lsIUi94NDmH4ihjkENiuuQOT74LN39+r17CIzShov9A5IxjRy1FVkp2lVMA0g3r8meiey3SSKLZScDOis1rj8mQt7e86g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+ZqQQE5YNogzNRDrfmFt99El9vDYVtdIbYXX2WLgv8=;
 b=HlP03uiWml7FbJ1wz0ag49Uw01zL27Qk/2jedLGFNtsSf/rHV22PcApKbQ+BetAv1Xn0VXCZELcBoAktyiK0q7Fe+NsIOtSulrXU28Uo3YPWF4it3n9cT/6O812fJbasoBeWKf0nIa/buK0dBVc/Vies7QXkTGAu3Kn8ZA/2BFY=
Received: from BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14)
 by PH0PR11MB5627.namprd11.prod.outlook.com (2603:10b6:510:e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 14:36:32 +0000
Received: from BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::775:3af1:d96f:ef6e]) by BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::775:3af1:d96f:ef6e%9]) with mapi id 15.20.5880.019; Tue, 20 Dec 2022
 14:36:32 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <krzk@kernel.org>, <linux-media@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <luis.oliveira@synopsys.com>,
        <lolivei@synopsys.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: media: Document bindings for DW MIPI
 CSI-2 Host
Thread-Topic: [PATCH v5 1/4] dt-bindings: media: Document bindings for DW MIPI
 CSI-2 Host
Thread-Index: AQHZEVv447w8tTLZyk+wfkA0S/sigq522J+AgAAFjYA=
Date:   Tue, 20 Dec 2022 14:36:32 +0000
Message-ID: <0ebd778e-1f82-d451-f4ec-1c00d3c865e3@microchip.com>
References: <20221216143717.1002015-1-eugen.hristev@microchip.com>
 <20221216143717.1002015-2-eugen.hristev@microchip.com>
 <3a0980ef-7128-1153-7016-6bb44760bf3b@kernel.org>
In-Reply-To: <3a0980ef-7128-1153-7016-6bb44760bf3b@kernel.org>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5384:EE_|PH0PR11MB5627:EE_
x-ms-office365-filtering-correlation-id: a24a8169-0a37-4c12-3854-08dae29796a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y2r8tl/4WlhNcXjLAtV0ytpJEbReKqsZTbOp3MoqdweU3pK+X9jxM+okVmBf7ZhIxrA69us7F0Vx8Y3xs+QpQNQJvh/AcfBcMnOvzvojhnnui+E2pZnHErPj5rWhUcknjdpsPTmb5tD6N/Cu8jg+B5ifDrwjXXohWkn41Misq6vKt54/jXqZF9x9rDHM7aN6vMUdfLdBGMqAQ7/vWTSByK8MUVXlRuW3Q7t93If/d/RaY6ddQyjWNkh8g9uMelgU94Ny4skE2bRJQgHQn8PRoj0BRFrcIhAkHXvSGLfR4Ryu2h8gfzMryNnBU4eKRaK+FhP+QfOko8Q+b4HYrBGKlXvqBV3PrdzOB472wLqRr2F2C0DFCdOn4LhDPkXpx5DFKc3ErOzrtdSXh/orCeBZJbNG2oV1Xv+4RgtqrH+5MbahjIEuq5jYcteiqnSkAJ2xzFZLz62cSs1JtFAoMDqo3NiSxxlh4hbs5X1lyACVj4uC3y+mHoNdq4EKlFETHgXwbEgdJX1Fx1VGwAZ3sZNpsUGeFL7epK2UKZWNaO+XpKbwryW2vxi658vnZRawoa1CDpLPx18Ns4tNFX7tTbsfPONOIeCs5WHm4RZKeN9WBUdPWH6kQGMjSzYaNVrEcZgtuOhawtrGjZBQT46TozUv4PV3cctXrWD9JdE0zIkTr3bhvBmJFyDFdZ1rUjLA3uNkLNj2zhXbaZbiGg3jYEN3NtEdhfJNXSTxztXWioxiNWBvCm/7Ooo/becpNWAMZrX+m9KyYDXYsPnSYm5RMVJXySrilZoX3udEslA3rfvVj/wganEoYayPmUxY0IUDnhOEFe36jSQjp/tswL05Be+Eug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199015)(86362001)(2616005)(38100700002)(31686004)(53546011)(6512007)(2906002)(71200400001)(36756003)(26005)(186003)(6506007)(478600001)(6486002)(966005)(110136005)(91956017)(8936002)(122000001)(316002)(54906003)(66476007)(66946007)(8676002)(66446008)(31696002)(66556008)(64756008)(4326008)(41300700001)(5660300002)(83380400001)(38070700005)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QldTRmgrWnZ4VFhEbDVkeUlqUGZObjJleUFiZnFzSlgwTHRRa1NjL2JnS2pl?=
 =?utf-8?B?dVJnbjFnQ0lSK2ZETzBQVUJiODlnTCtvSjAyMFlQcUVtM244cVYyU3UwalNx?=
 =?utf-8?B?YldmamtIQXRYeEZMY2dSNXhKOE0rOWRKNzRoVy9KTGxSZmRkZlhiK1pvM0Fo?=
 =?utf-8?B?YVVyN1NPOEc3UW9senUxU2xWTitQalVtazNXbzdNQm1aRkVZczUvSndMNmFN?=
 =?utf-8?B?OGJhNDluakpzMERmK2U3NGJiU0Q0ZlRxZ1VSMEdlZEFnTmZLZ0pUZ3VJb1FI?=
 =?utf-8?B?WFRMVkt0eERLb0pOVC9vdSt0aFFkMXZ2ZjE2Z2ZSc3VWcytkNE1uS2lOTWRG?=
 =?utf-8?B?VTE2WFN3V1F4dmNobTZYMHFxNnplM0k1MGVWODVXMTlEN1l5MnhpVFdrMkQ3?=
 =?utf-8?B?eHFGMTROZkNGaGdIUE5yK0hIcTNweWE4T0kxbk1oaDJqbFFxcEtUcFNMWWZ5?=
 =?utf-8?B?UWJ3eml6a3BnYVFjeFo1N2JJQ3VxN041b0poTHprakZUMjlMcmt0c3d0eW51?=
 =?utf-8?B?S0hCWWlnNzlrQjZ0dUlqR09YakhJUHkwVkRDeUZwSVNTVktxN3NidzBrT0FH?=
 =?utf-8?B?dUlxdzEzcm1tMHNDdFVIenkvWitFVGNMYVZ0Um5SUllpZUxLd0F3RFdOZS9I?=
 =?utf-8?B?clpyczRLRHVMQXpHWDJ1czNPeXJ1TlgvbkRUMEhBaStRdlQzalYxdWtQM3RW?=
 =?utf-8?B?NDNhZmxHK0pkWTUzQkg0ZEhrMUMxSXJsQ25lQzVNdllyK3lIYmxKWDBtYlRR?=
 =?utf-8?B?aGo0emFoY3ppb1N4czFCRXBQVjdySHNLOTlJVXJZKzcvUTRtazBodDRSZTVD?=
 =?utf-8?B?ZzNQM2xkeUFSc2I2Mlg1b2E2UjRWN2gyLzVXZGRVT08rSU9Ta2JQRHJTdGRF?=
 =?utf-8?B?TkNySE8zblNqWS9Wa3ZETG9DUms2SWJqUlpyUmRycnowYkxQU3JQTHRtTDQ5?=
 =?utf-8?B?VnhrZlBVS1d1ajN4QW90US9kRXV2bzg2aUN1Z0hVd1l3dDNRMG9IbVRqK1RS?=
 =?utf-8?B?Z2ZNQWpPRU1RTW5rczNaMW56MkF0ZlRNelhzalJKSFFKajBNNjhMWTBCVVhE?=
 =?utf-8?B?TnVJYmpETmtQSWFJTzZIUll1eEZVdno2bjZZb3hBMFAvN0toMW1CR2FEQitB?=
 =?utf-8?B?VXJwZjRMVWJ6eFFKZEhLZUFQZGxKalF3ZmJJU3ZXbWdoQjR2cmkzUkRlWXRJ?=
 =?utf-8?B?K1BDM1FQZTdOMmFQb0xwWkVxOWxDUmFkTHFnM1k5UlRYS0EvMllBeVpHV01h?=
 =?utf-8?B?R1FpNk0zNWJvWXpWanhoZXgvNHFKVnlRaGh0WGNJbWNudXBJcXd5YVBxTzJp?=
 =?utf-8?B?SmNONzBkTUk4SFM5ZEl6bm9Vc0d6MVErakhWN3p6RWtVa0lIZzBnL3BSNjlV?=
 =?utf-8?B?QXpQVVVUTlY3U05XM2tGejhCS2tmOWFYcWRtNzNkdzQvR1czQmhneER5VGEv?=
 =?utf-8?B?MGcwem01NHJmZWVsd1JkeTNrdmsvNUJJY2c0TnJLQnN0YjViNjFlNERZbGls?=
 =?utf-8?B?TjFqSG9pcXRtN0NMNzhyZ3VQc05heXhraXZpbFFSbTUvcjlLSTBZQWNzUFpO?=
 =?utf-8?B?N3RkVnRZanhRZk1GUTErSjRmZkhYN1hYQWUycThkMkFxOEtLVVNFRklIM2JL?=
 =?utf-8?B?TWY3Zi9UQ3cyU3hlN0dIZStDd3JkYU8wWmNOS2g1VGFPRVJGTVI0R1hTbDU1?=
 =?utf-8?B?WFJmM1lvYlpYRjNkZHY4SEdqQ29PVEZWellta3VkYmlSaXh2aHRDQ1VFbVBw?=
 =?utf-8?B?MGVCV2tRYUVucjZKK3kwQ1RXWkZhZFZ1aWMvbWQvSDlsMFpLbklaVDdUaUVz?=
 =?utf-8?B?dG9NdlRHVkZpOTFyN2tmZ3VjaytJSjJjR2Voc0pNazl6cWZhVytScy9yUEp2?=
 =?utf-8?B?YUo4Y2UxNzZnN1hXWGhadGpBTjVvdjRFWXlSYXUyREYwSkg4Ly83dmJGV0VS?=
 =?utf-8?B?RjJ6QXZzcUlsREpJT01YcVRXWWZneTR2NSt4aHFESGJxN1dEUFZST1ZVZzhY?=
 =?utf-8?B?R21ZbkFMVnY0K3hkRlhXalh4ZnJZeTd6NXFTb1h4TmcrS1dBVDlFaldOZkRw?=
 =?utf-8?B?cnptdmRJUmd0Y251SlBsN05nbEo4R05aYVhRKzAyaG5XZFFXYUtjQ1pSR01z?=
 =?utf-8?B?aWxBQVdtQ0Erby8zNGZ1THlXVk1kbkdQc0xKZjgza29xdmJmRGNFa1NHQmx3?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B16A3BC1DA6CCA4DBB7260DBC608DBF6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24a8169-0a37-4c12-3854-08dae29796a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 14:36:32.1252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODHXmnxPpH/c8742SV3ezdWyl84RTIIoAjIRfM3xJIAeGY3vSKsnHH183Yd3EasmnH0sR+VEOGH30+4YKOziH0ZjZsHUralIL6XSusRY9T0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5627
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMjAvMjIgMTY6MTYsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIDE2LzEy
LzIwMjIgMTU6MzcsIEV1Z2VuIEhyaXN0ZXYgd3JvdGU6DQo+PiBBZGQgYmluZGluZ3MgZm9yIFN5
bm9wc3lzIERlc2lnbldhcmUgTUlQSSBDU0ktMiBob3N0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IEx1aXMgT2xpdmVpcmEgPGxvbGl2ZWlAc3lub3BzeXMuY29tPg0KPj4gW2V1Z2VuLmhyaXN0ZXZA
bWljcm9jaGlwLmNvbTogcmV3b3JrZWQgYmluZGluZywgY29udmVydGVkIHRvIHlhbWxdDQo+PiBT
aWduZWQtb2ZmLWJ5OiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+
DQo+PiAtLS0NCj4gDQo+IDEuIFBsZWFzZSB1c2Ugc2NyaXB0cy9nZXRfbWFpbnRhaW5lcnMucGwg
dG8gZ2V0IGEgbGlzdCBvZiBuZWNlc3NhcnkNCj4gcGVvcGxlIGFuZCBsaXN0cyB0byBDQy4gIEl0
IG1pZ2h0IGhhcHBlbiwgdGhhdCBjb21tYW5kIHdoZW4gcnVuIG9uIGFuDQo+IG9sZGVyIGtlcm5l
bCwgZ2l2ZXMgeW91IG91dGRhdGVkIGVudHJpZXMuICBUaGVyZWZvcmUgcGxlYXNlIGJlIHN1cmUg
eW91DQo+IGJhc2UgeW91ciBwYXRjaGVzIG9uIHJlY2VudCBMaW51eCBrZXJuZWwuDQo+IA0KPiBZ
b3UgZGlkIG5vdCBDQyBhbnlvbmUsIHNvIHdobyBpcyBzdXBwb3NlZCB0byB0YWtlIHRoaXMgcGF0
Y2g/DQoNCkhpIEtyenlzenRvZiwNCg0KVGhhbmtzIGZvciBsb29raW5nIGF0IHRoaXMgLiBUbyBh
bnN3ZXIgeW91IDogbm9ib2R5IC4gUGxlYXNlIHJlYWQgdGhlIA0KY292ZXIgbGV0dGVyICwgSSBh
bSBzZW5kaW5nIHRoaXMgdG8gcHVibGlzaCBteSB3b3JrIG9uIHRoaXMgZHJpdmVyLCBhcyANCml0
IG1heSBoZWxwIHNvbWVvbmUgb3V0IHRoZXJlLg0KDQpFdWdlbg0KDQo+IA0KPiAyLiBTdWJqZWN0
OiBkcm9wIHNlY29uZCwgcmVkdW5kYW50ICJiaW5kaW5ncyBmb3IiLg0KPiANCj4+ICAgLi4uL2Jp
bmRpbmdzL21lZGlhL3NucHMsZHctY3NpLnlhbWwgICAgICAgICAgIHwgMTQ5ICsrKysrKysrKysr
KysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTQ5IGluc2VydGlvbnMoKykNCj4+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9z
bnBzLGR3LWNzaS55YW1sDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tZWRpYS9zbnBzLGR3LWNzaS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL21lZGlhL3NucHMsZHctY3NpLnlhbWwNCj4+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjQzOWVhZGM4ZTUxNw0KPj4gLS0tIC9kZXYv
bnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL3Nu
cHMsZHctY3NpLnlhbWwNCj4+IEBAIC0wLDAgKzEsMTQ5IEBADQo+PiArIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+PiArJVlBTUwgMS4y
DQo+PiArLS0tDQo+PiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9tZWRpYS9z
bnBzLGR3LWNzaS55YW1sIw0KPj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRh
LXNjaGVtYXMvY29yZS55YW1sIw0KPj4gKw0KPj4gK3RpdGxlOiBTeW5vcHN5cyBEZXNpZ25XYXJl
IENTSS0yIEhvc3QgY29udHJvbGxlciAoY3NpMmhvc3QpDQo+PiArDQo+PiArbWFpbnRhaW5lcnM6
DQo+PiArICAtIEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCj4+
ICsNCj4+ICtkZXNjcmlwdGlvbjoNCj4+ICsgIENTSTJIT1NUIGlzIHVzZWQgdG8gcmVjZWl2ZSBp
bWFnZSBjb21pbmcgZnJvbSBhbiBNSVBJIENTSS0yIGNvbXBhdGlibGUNCj4+ICsgIGNhbWVyYS4g
SXQgd2lsbCBjb252ZXJ0IHRoZSBpbmNvbWluZyBDU0ktMiBzdHJlYW0gaW50byBhIGRlZGljYXRl
ZA0KPj4gKyAgaW50ZXJmYWNlIGNhbGxlZCB0aGUgU3lub3BzeXMgSURJIChJbWFnZSBEYXRhIElu
dGVyZmFjZSkuDQo+PiArICBUaGlzIGludGVyZmFjZSBpcyBhIDMyLWJpdCBTb0MgaW50ZXJuYWwg
b25seSwgYW5kIGNhbiBiZSBhc3NpbWlsYXRlZA0KPj4gKyAgd2l0aCBhIENTSS0yIGludGVyZmFj
ZS4NCj4+ICsNCj4+ICtwcm9wZXJ0aWVzOg0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgY29u
c3Q6IHNucHMsZHctY3NpDQo+PiArDQo+PiArICByZWc6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+
PiArDQo+PiArICBjbG9ja3M6DQo+PiArICAgIG1heEl0ZW1zOiAyDQo+PiArDQo+PiArICBjbG9j
ay1uYW1lczoNCj4+ICsgICAgZGVzY3JpcHRpb246DQo+PiArICAgICAgQ1NJMkhPU1QgY2FuIGhh
dmUgdHdvIGNsb2NrcyBjb25uZWN0ZWQuIE9uZSBjbG9jayBpcyB0aGUNCj4+ICsgICAgICBwZXJp
cGhlcmFsIGNsb2NrIGZvciB0aGUgaW5zaWRlIGZ1bmN0aW9uYWxpdHkgb2YgdGhlIGhhcmR3YXJl
IGJsb2NrLg0KPj4gKyAgICAgIFRoaXMgaXMgbmFtZWQgJ3BlcmNsaycuIFRoZSBzZWNvbmQgY2xv
Y2sgY2FuIGJlIHRoZSBwaHkgY2xvY2ssDQo+PiArICAgICAgd2hpY2ggaXMgdXNlZCB0byBjbG9j
ayB0aGUgcGh5IHZpYSBhbiBpbnRlcm5hbCBsaW5rLg0KPj4gKyAgICAgIFRoaXMgY2xvY2sgaXMg
bmFtZWQgJ3BoeWNsaycsIHBoeSBjbG9jay4NCj4+ICsgICAgaXRlbXM6DQo+PiArICAgICAgLSBj
b25zdDogcGVyY2xrDQo+PiArICAgICAgLSBjb25zdDogcGh5Y2xrDQo+IA0KPiBEcm9wICJjbGsi
IGZyb20gYm90aA0KPiANCj4gDQo+PiArDQo+PiArICBwaHlzOg0KPj4gKyAgICBtYXhJdGVtczog
MQ0KPj4gKyAgICBkZXNjcmlwdGlvbjogTUlQSSBELVBIWQ0KPj4gKw0KPj4gKyAgcGh5LW5hbWVz
Og0KPj4gKyAgICBpdGVtczoNCj4+ICsgICAgICAtIGNvbnN0OiBkcGh5DQo+PiArDQo+PiArICBy
ZXNldHM6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICBpbnRlcnJ1cHRzOg0KPj4g
KyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgcG9ydHM6DQo+PiArICAgICRyZWY6IC9zY2hl
bWFzL2dyYXBoLnlhbWwjL3Byb3BlcnRpZXMvcG9ydHMNCj4+ICsNCj4+ICsgICAgcHJvcGVydGll
czoNCj4+ICsgICAgICBwb3J0QDA6DQo+PiArICAgICAgICAkcmVmOiAvc2NoZW1hcy9ncmFwaC55
YW1sIy8kZGVmcy9wb3J0LWJhc2UNCj4+ICsgICAgICAgIHVuZXZhbHVhdGVkUHJvcGVydGllczog
ZmFsc2UNCj4+ICsgICAgICAgIGRlc2NyaXB0aW9uOg0KPj4gKyAgICAgICAgICBJbnB1dCBwb3J0
IG5vZGUsIHNpbmdsZSBlbmRwb2ludCBkZXNjcmliaW5nIHRoZSBpbnB1dCBwb3J0Lg0KPj4gKw0K
Pj4gKyAgICAgICAgcHJvcGVydGllczoNCj4+ICsgICAgICAgICAgZW5kcG9pbnQ6DQo+PiArICAg
ICAgICAgICAgJHJlZjogdmlkZW8taW50ZXJmYWNlcy55YW1sIw0KPj4gKyAgICAgICAgICAgIHVu
ZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4+ICsgICAgICAgICAgICBkZXNjcmlwdGlvbjog
RW5kcG9pbnQgY29ubmVjdGVkIHRvIGlucHV0IGRldmljZQ0KPj4gKw0KPj4gKyAgICAgICAgICAg
IHByb3BlcnRpZXM6DQo+PiArICAgICAgICAgICAgICBidXMtdHlwZToNCj4+ICsgICAgICAgICAg
ICAgICAgY29uc3Q6IDQNCj4+ICsNCj4+ICsgICAgICAgICAgICAgIGRhdGEtbGFuZXM6DQo+PiAr
ICAgICAgICAgICAgICAgIG1pbkl0ZW1zOiAxDQo+PiArICAgICAgICAgICAgICAgIG1heEl0ZW1z
OiA0DQo+PiArICAgICAgICAgICAgICAgIGl0ZW1zOg0KPj4gKyAgICAgICAgICAgICAgICAgIG1h
eGltdW06IDQNCj4+ICsNCj4+ICsgICAgICAgICAgICAgIGNsb2NrLWxhbmVzOg0KPj4gKyAgICAg
ICAgICAgICAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgICAgICAgICAgICAgcmVtb3RlLWVu
ZHBvaW50OiB0cnVlDQo+PiArDQo+PiArICAgICAgcG9ydEAxOg0KPj4gKyAgICAgICAgJHJlZjog
L3NjaGVtYXMvZ3JhcGgueWFtbCMvJGRlZnMvcG9ydC1iYXNlDQo+PiArICAgICAgICB1bmV2YWx1
YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+PiArICAgICAgICBkZXNjcmlwdGlvbjoNCj4+ICsgICAg
ICAgICAgT3V0cHV0IHBvcnQgbm9kZSwgc2luZ2xlIGVuZHBvaW50IGRlc2NyaWJpbmcgdGhlIG91
dHB1dCBwb3J0Lg0KPj4gKw0KPj4gKyAgICAgICAgcHJvcGVydGllczoNCj4+ICsgICAgICAgICAg
ZW5kcG9pbnQ6DQo+PiArICAgICAgICAgICAgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0K
Pj4gKyAgICAgICAgICAgICRyZWY6IHZpZGVvLWludGVyZmFjZXMueWFtbCMNCj4+ICsgICAgICAg
ICAgICBkZXNjcmlwdGlvbjogRW5kcG9pbnQgY29ubmVjdGVkIHRvIG91dHB1dCBkZXZpY2UNCj4+
ICsNCj4+ICsgICAgICAgICAgICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAgICAgICAgICAgYnVzLXR5
cGU6DQo+PiArICAgICAgICAgICAgICAgIGNvbnN0OiA0DQo+PiArDQo+PiArICAgICAgICAgICAg
ICByZW1vdGUtZW5kcG9pbnQ6IHRydWUNCj4+ICsNCj4+ICsgICAgcmVxdWlyZWQ6DQo+PiArICAg
ICAgLSBwb3J0QDANCj4+ICsgICAgICAtIHBvcnRAMQ0KPj4gKw0KPj4gK2FkZGl0aW9uYWxQcm9w
ZXJ0aWVzOiBmYWxzZQ0KPj4gKw0KPj4gK3JlcXVpcmVkOg0KPj4gKyAgLSBjb21wYXRpYmxlDQo+
PiArICAtIHBvcnRzDQo+IA0KPiByZWc/IHBoeXM/IGludGVycnVwdHM/IEFsbCBvdGhlcnM/DQo+
IA0KPj4gKw0KPj4gK2V4YW1wbGVzOg0KPj4gKyAgLSB8DQo+PiArICAgIGNzaTI6IGNzaTJAMzAw
MCB7DQo+IA0KPiBHZW5lcmljIG5vZGUgbmFtZXMsIHNvICJjc2kiDQo+IA0KPj4gKyAgICAgICAg
Y29tcGF0aWJsZSA9ICJzbnBzLGR3LWNzaSI7DQo+PiArICAgICAgICByZWcgPSA8MHgwMzAwMCAw
eDdGRj47DQo+IA0KPiBsb3dlcmNhc2UgaGV4DQo+IA0KPj4gKyAgICAgICAgcGh5cyA9IDwmbWlw
aV9kcGh5X3J4PjsNCj4+ICsgICAgICAgIHBoeS1uYW1lcyA9ICJkcGh5IjsNCj4+ICsgICAgICAg
IHJlc2V0cyA9IDwmZHdfcnN0IDE+Ow0KPj4gKyAgICAgICAgaW50ZXJydXB0cyA9IDwyPjsNCj4+
ICsNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KDQo=
