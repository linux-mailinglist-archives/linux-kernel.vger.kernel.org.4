Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E2A666F23
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjALKLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbjALKKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:10:09 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB388DF2B;
        Thu, 12 Jan 2023 02:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673517901; x=1705053901;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CdNd2rs3sbZQ0JgyaL5CRtp37nBlIz42j2ArIfclvlg=;
  b=z1yQue+PWme8VH6ebKCFTgyGdMNdfpiLuvya8vvbajAGYgudOcqzVZON
   LEGv5JTHD2unOwO999Ig8IJ2Cp9yV2KRbivNau8yurvG9B8gyphLZOJMg
   ySBa4/KoyquyR5WZJIZJpphvH/RCGxMO+oNKSrM5Eo3WD01uMzPg+7raW
   jN2uSQMHzr6NQNCmZbeM1cOCgtllWefNH59wsinm2Qr7DmKfBk5WvY/1F
   8UO1KgB52/ZV2sb6X0fH4SZUCPRN68ciPRODLlB49/hbEcCp2l0OsuK9b
   lH2YpEQqjmbhtSMzxE50ge89mOvsFh1Xr9/DTRvWzng/Ge0XOrQFNxB1+
   g==;
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="207456822"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jan 2023 03:05:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 03:04:59 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 12 Jan 2023 03:04:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWdKZldQpdcY9AmyWwyONCH68MhVXMYINEiPdRn9YGpxvsEAES85C/H+WsQhYP5znzAMUOcnF0R6pvr8QZItVNDDz/apCvSqLIjea4JRiYmrxFgkCWHwaAmjwZaZhVtglxzyeKTvg6fHVOEHzvyLYiXB3kygvp4IntKki1OYdVRCUZ8yV/edaTVkm0ZrTN2BfVJOgvti+Y4KXHDmk0P218RF8GQZ/mnWwlBfognsUOmo16G9x/g2tffJ9snE6OUcW7zouitYaouvbgZrvofy6CPfJKFr7lxPJQJxRUSS3A7jBPWGHT215Nc931vXd8KXyS9wDjN+f3RPYcI6LBYi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdNd2rs3sbZQ0JgyaL5CRtp37nBlIz42j2ArIfclvlg=;
 b=NYhHGsvzrAJ7Zn8Wy9UNvMCjbuaejxDCAQAnnWlQzTLQRJu1casbtqY5FKf3JkO48ab/HjL65BziAtTa4fv3J3bbXZ724pOU1iKsDb5i6BY5VvU/uHvUcN1ogaGWaSrsZ3OQbq+5kuBaPWxh3WiFRc7c9j+EnGWoOsCeqrExE441Q0eErOXZh1NLRhCvrSttkXKwKzQHwDl8imXcGrE0/sIYIMAuDBNnZEzACkTt5kOqJSJwXl6BIVO6hW8J5C8R5fCEuxIN6hKNcqWXvc7VFM/bRFh3bKMQVq0oE3e1KbczZyS9cEhtXHQjt4SXdsDlB1a10cUNMaVVrbl6Ta6Iqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdNd2rs3sbZQ0JgyaL5CRtp37nBlIz42j2ArIfclvlg=;
 b=oCB0KExq103OBIV8BMelPKTO7lIWLkZ6HK+fZ/gBLax/ByrrhxtUB15V0iv3F+wP6ISKRvTz083IYQ76j5SvWIQ7gmWfNCzlQD7SN6HDJzzaoCxsnsV9MhqCyAgGKEV27eHENzfPOyHPoYQokW/LGWUhWJbHTnk9LuBpZjMf0UQ=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DS0PR11MB7530.namprd11.prod.outlook.com (2603:10b6:8:146::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 10:04:57 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5%9]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 10:04:56 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <geert+renesas@glider.be>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <Conor.Dooley@microchip.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: microchip: mpfs-ccc: Use devm_kasprintf() for
 allocating formatted strings
Thread-Topic: [PATCH] clk: microchip: mpfs-ccc: Use devm_kasprintf() for
 allocating formatted strings
Thread-Index: AQHZJm1SmvfM1AcehE+opR7KJSov7g==
Date:   Thu, 12 Jan 2023 10:04:56 +0000
Message-ID: <715515eb-0a9c-8ee8-5393-d8986facb55b@microchip.com>
References: <f904fd28b2087d1463ea65f059924e3b1acc193c.1672764239.git.geert+renesas@glider.be>
In-Reply-To: <f904fd28b2087d1463ea65f059924e3b1acc193c.1672764239.git.geert+renesas@glider.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|DS0PR11MB7530:EE_
x-ms-office365-filtering-correlation-id: 6c6b532f-5055-495c-0166-08daf4847564
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7noa7KzRhVKDN2bhSKCSmvnTLT1uyiwwBmT/XxeP5oRxAE2bFrAulF7954DFYeF6h4pEcn1xM3s5RlrM2KbA/smqU30pPCWGj5YBC3enE37yvgRH8UaYCBUv5c1gckUefwg4JOr6a9y7rgXFnxKXLdjgGfhlqDV+16uCnA0BV9WkMivLlDNwdJA3MUPl26w1hrQ41rmOFuUZlfFDRzhDHflIawqYB41QY/m4/8vQQNITHz7VyUdfO0dCW31gqrrAUL+JNDxDAskHycEjpNCjJlvWsOvCBgvqDpYXT178IZ1Mmuhz9c1VQM5oyxYHStpqnZzUXIvWhfVPrP2KNONSZ2JGJEqkSmYL87c74D9kIx1QelElQ0DkuwHIOhFdXw2G6SVUIf8sgt3hr91zI7qsvjfNXGPGse8ZqVqoRyU7AOQdkGd/wmP6bZGnKHaOJYf2KZ2yVRjVLSTohKiOmHTc+wjM82vahNtrfhd4hUmlNeXMkfUEEnGGSNmN/OlpaXCw10l/m8HllRiA9378f+/xn1LNllDMtywqAExo528ajPBdoVqOSmIPgU4WR5uVS5Ep82aw3/kxNd7ByHP4RsesZ1/1M/NvbOqP55rcH3hCASRHYTuheIm0HOXFP6J4UnqrJPl8KoNCl4QNbrSkNQQOdPct7jXjtuotti2LSG3R3HZp/V+aSYqikHCFoqPvr96VP8SdZB2tJgSWAGRgH+5Bj26lD+4Huuv4Y8R4gKGaaDoMeCW51ZPYZArJAcXwX4wbEZ/u5ZSlW8wTg9wyj2dF1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199015)(2906002)(83380400001)(478600001)(66446008)(66476007)(64756008)(66556008)(5660300002)(66946007)(8936002)(53546011)(122000001)(26005)(6636002)(36756003)(186003)(6506007)(31686004)(6512007)(6486002)(2616005)(41300700001)(38100700002)(110136005)(8676002)(54906003)(76116006)(86362001)(38070700005)(316002)(71200400001)(4326008)(91956017)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YU5mQ2pTT210Zy9Eb3dCU1hWd3gweHVkUEt2WmNnZnBoaVZJVmZpWll2UFJy?=
 =?utf-8?B?Nk5SMjB5bWI0WUJLMjNkWHpYYTBlTDlpSTBOV0RPb2RuZVpWaHRnRWpYWFJN?=
 =?utf-8?B?bnFtSE9LcDIraGJaUSs0TG82WG9LVS9mNVBnNHlEYS8vNHdsOXVjM1NoNFRB?=
 =?utf-8?B?RW15dlBLWm93OVIzRCtLYjlqVXgyV3dQVnZVVElIcGR0cVpnRUVUQUczbG5w?=
 =?utf-8?B?R1EwTG9qNjFGQXJWeUp2emdpS3daSVErY1NQNEpnd1o3anBYQW9IendxRks0?=
 =?utf-8?B?SVcrU05vWERoemp3U2U4K2R2M3RheExTc3ZFazVFNXF2MmExV1NuZW9ScUgz?=
 =?utf-8?B?WFh4NFpIZFgxbkNYRXNjZTR3TG9FSjVpWEQwTC83WDNFUE1Td0xMdkx4ZXVh?=
 =?utf-8?B?ZlM3S291VGQyUWJsa3k0SmpMZ3hRcHhKa1YzU1lIUTdxSkN1Z0pDTmpuYnNP?=
 =?utf-8?B?Uk1sem1ia2lLbkN2R0ZORGhkMnUwc1QrZWRBSDMzbnlyTDlmMVRBajdUT3dj?=
 =?utf-8?B?TU1jWE44a1hWeWNQSEtiUXJMU2RSR1prcFByN09RSE43QjAvZFJOYTIydk1S?=
 =?utf-8?B?N3lBL3N2bnhpemJjSXB3dlpWMlJROXpETkRobld3dzRVSHRGUjJWcmRDWllE?=
 =?utf-8?B?WUVpNEQzMUgyUVFMRkFpK284a29OK0ZxZ1Exdnl4THZBNFd6YTRhTGRMem1P?=
 =?utf-8?B?MnVzbEw3U3NMWTFqZmlCVWRQYXFMNVNQUGR0RDdzK1dBaGRXbXJ1d2VtVFRQ?=
 =?utf-8?B?dE1mcVMwS3RKMVppaHVxb2p3SjQwTHNsbnFoM3ljRGtYWFF4TzVzK2NoTjFQ?=
 =?utf-8?B?UXZsVmRiZHR5eHBSZnZzUmpJbG03R0cyMjJMbE1yRGlDdXIvRXI3OEEyUGht?=
 =?utf-8?B?L1FjTVpuQmFreG1TNkpENS9TNnkycmdlcG1acG5iNDhVV0VSL293YlQ4S0Jx?=
 =?utf-8?B?OC8rTTRDbTg5cHZ3K2xCbU1WYlM3T2wrb1FTYjJtejRTUitlelZMRHhyNWtK?=
 =?utf-8?B?Q2V1MWhQVFZDaUtleFkvTk5FblJvUlRLSGVkZ0NsRzM2WTlqU09SWk9rcHZI?=
 =?utf-8?B?WFNTd2wyay9FbHBnbXZ6SjlQanZuLzhnRWZmZ1BwNzZKVDA4alQ4VmpkajQy?=
 =?utf-8?B?bjhmVkxGTXBNZ2hIOGU2aHZwLzZHd3VDTk1qaTcrZm1mZ2VCUjl4ZmpXZm0y?=
 =?utf-8?B?NmtlQk1CNFdjK2RNS2hHOHpvdjJ6MkhaYVZDd0Y1TlVtcFVaU1U1QWtXV29q?=
 =?utf-8?B?ZTVHL25uelRlTU03NnJFRUNvT3liUlFjeFVtT3FiZEFlTjRFdk1CVGljNTBZ?=
 =?utf-8?B?Lzl5bk5SV0RScGVocjQwQzZFekpjTktiS2xkWUhTckhqNU1RTUQweGFUK0tW?=
 =?utf-8?B?T2ZGenloclYyK2tqMGd1MURUaXErWEhNOHpUZzUwZWVLWUk0SW9yQ0tmUENF?=
 =?utf-8?B?b1dZa0JSWG9iVGZ3bXBySlpuc1BSQVNEa3V6MHh6WW5RRjVwMTMvNDQ5M2Jz?=
 =?utf-8?B?djd4QzlDeHNFVnBUa2hPYUdiZ3Rxa2hRbkhCSldHTjlJTjZZZGZvRVJMYnpD?=
 =?utf-8?B?K0NLOFIvbzhXL3gxeEJ5dStKaktYY0Rqdi95OXhCekRidnVLcE5oWlpZdkg3?=
 =?utf-8?B?VThUL3d0MmhGK2FQQlZidFROU2ZFQXdlckdKZHg5Yjc1STlXVnhtSFZIcTFC?=
 =?utf-8?B?bkpwdkJCWlg2ZUNsYnluNGVRR2FkWElFQm9hczVMRlIrZmI1cDRPNFlQcXpz?=
 =?utf-8?B?ZTNyQXRpZVFOWWl4d0VXUnZYRXJMVnhOaDB3b2EySEF4dTNXT29KcldVZ1hM?=
 =?utf-8?B?cXBJb2lMdHgvQUQrNWFWUUFpa0YvejRJdnRsdkl1aGIwYS9lU3ZSSkJMdXhW?=
 =?utf-8?B?R3NiN3AxVExPL0FBVk9hdmM3eWNGeEs2dlgzdEVxaUFGeWZyRkh3eXNVT21m?=
 =?utf-8?B?MGpuUkZkK2kxMnI4ZHA4MWREamhvK253N2phNDFoRHV1R3RKKzFxVVhFQmlE?=
 =?utf-8?B?SlVoWks5N2g1ZXM3bExrSERHdW5YME9XR3BmOGVLZGVISTVxTEI2VHkyL1Na?=
 =?utf-8?B?ZXlRdlAra0NWWnJJSzJuVUpyLytUUFdRSm1DUDBhKzVrYXVLdnVUMW1YRUxB?=
 =?utf-8?B?UGhVOGN1MUdXQWxIbzU5QStUNDE2aW9kQ2ZqNk5qSmQxQkI1eElINlFzaytV?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C23B5497B7078E449A486364C2AD6045@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6b532f-5055-495c-0166-08daf4847564
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 10:04:56.8382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1u6QHoXW2NfmUZ8h5O682ljNk1UKDxSRnqeKD/AoaKrgxJLIz8AyWfUKPDXilVX/s8PpGtI1gm2AUHYFSow5MqDQ1gdNp0EfGkMGo/CCUZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7530
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDEuMjAyMyAxODo0NSwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEluIHZhcmlvdXMgcGxhY2VzLCBzdHJp
bmcgYnVmZmVycyBvZiBhIGZpeGVkIHNpemUgYXJlIGFsbG9jYXRlZCwgYW5kDQo+IGZpbGxlZCB1
c2luZyBzbnByaW50ZigpIHdpdGggdGhlIHNhbWUgZml4ZWQgc2l6ZSwgd2hpY2ggaXMgZXJyb3It
cHJvbmUuDQo+IA0KPiBSZXBsYWNlIHRoaXMgYnkgY2FsbGluZyBkZXZtX2thc3ByaW50ZigpIGlu
c3RlYWQsIHdoaWNoIGFsd2F5cyB1c2VzIHRoZQ0KPiBhcHByb3ByaWF0ZSBzaXplLg0KPiANCj4g
V2hpbGUgYXQgaXQsIHJlbW92ZSBhbiB1bm5lZWRlZCBpbnRlcm1lZGlhdGUgdmFyaWFibGUsIHdo
aWNoIGFsbG93cyB1cw0KPiB0byBkcm9wIGEgY2FzdCBhcyBhIGJvbnVzLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCg0K
QXBwbGllZCB0byBjbGstbWljcm9jaGlwLWZpeGVzLCB0aGFua3MhDQoNCj4gLS0tDQo+ICBkcml2
ZXJzL2Nsay9taWNyb2NoaXAvY2xrLW1wZnMtY2NjLmMgfCAxMCArKysrLS0tLS0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY2xrL21pY3JvY2hpcC9jbGstbXBmcy1jY2MuYyBiL2RyaXZlcnMvY2xr
L21pY3JvY2hpcC9jbGstbXBmcy1jY2MuYw0KPiBpbmRleCAzMmFhZTg4MGExNGYzYjFjLi4wZGRj
NzNlMDdiZTQyOTczIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9taWNyb2NoaXAvY2xrLW1w
ZnMtY2NjLmMNCj4gKysrIGIvZHJpdmVycy9jbGsvbWljcm9jaGlwL2Nsay1tcGZzLWNjYy5jDQo+
IEBAIC0xNjQsMTIgKzE2NCwxMSBAQCBzdGF0aWMgaW50IG1wZnNfY2NjX3JlZ2lzdGVyX291dHB1
dHMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbXBmc19jY2Nfb3V0X2h3Xw0KPiANCj4gICAg
ICAgICBmb3IgKHVuc2lnbmVkIGludCBpID0gMDsgaSA8IG51bV9jbGtzOyBpKyspIHsNCj4gICAg
ICAgICAgICAgICAgIHN0cnVjdCBtcGZzX2NjY19vdXRfaHdfY2xvY2sgKm91dF9odyA9ICZvdXRf
aHdzW2ldOw0KPiAtICAgICAgICAgICAgICAgY2hhciAqbmFtZSA9IGRldm1fa3phbGxvYyhkZXYs
IDIzLCBHRlBfS0VSTkVMKTsNCj4gKyAgICAgICAgICAgICAgIGNoYXIgKm5hbWUgPSBkZXZtX2th
c3ByaW50ZihkZXYsIEdGUF9LRVJORUwsICIlc19vdXQldSIsIHBhcmVudC0+bmFtZSwgaSk7DQo+
IA0KPiAgICAgICAgICAgICAgICAgaWYgKCFuYW1lKQ0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gLUVOT01FTTsNCj4gDQo+IC0gICAgICAgICAgICAgICBzbnByaW50ZihuYW1lLCAy
MywgIiVzX291dCV1IiwgcGFyZW50LT5uYW1lLCBpKTsNCj4gICAgICAgICAgICAgICAgIG91dF9o
dy0+ZGl2aWRlci5ody5pbml0ID0gQ0xLX0hXX0lOSVRfSFcobmFtZSwgJnBhcmVudC0+aHcsICZj
bGtfZGl2aWRlcl9vcHMsIDApOw0KPiAgICAgICAgICAgICAgICAgb3V0X2h3LT5kaXZpZGVyLnJl
ZyA9IGRhdGEtPnBsbF9iYXNlW2kgLyBNUEZTX0NDQ19PVVRQVVRTX1BFUl9QTExdICsNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgb3V0X2h3LT5yZWdfb2Zmc2V0Ow0KPiBAQCAtMjAxLDE0ICsy
MDAsMTMgQEAgc3RhdGljIGludCBtcGZzX2NjY19yZWdpc3Rlcl9wbGxzKHN0cnVjdCBkZXZpY2Ug
KmRldiwgc3RydWN0IG1wZnNfY2NjX3BsbF9od19jbG8NCj4gDQo+ICAgICAgICAgZm9yICh1bnNp
Z25lZCBpbnQgaSA9IDA7IGkgPCBudW1fY2xrczsgaSsrKSB7DQo+ICAgICAgICAgICAgICAgICBz
dHJ1Y3QgbXBmc19jY2NfcGxsX2h3X2Nsb2NrICpwbGxfaHcgPSAmcGxsX2h3c1tpXTsNCj4gLSAg
ICAgICAgICAgICAgIGNoYXIgKm5hbWUgPSBkZXZtX2t6YWxsb2MoZGV2LCAxOCwgR0ZQX0tFUk5F
TCk7DQo+IA0KPiAtICAgICAgICAgICAgICAgaWYgKCFuYW1lKQ0KPiArICAgICAgICAgICAgICAg
cGxsX2h3LT5uYW1lID0gZGV2bV9rYXNwcmludGYoZGV2LCBHRlBfS0VSTkVMLCAiY2NjJXNfcGxs
JXUiLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
Y2hybnVsKGRldi0+b2Zfbm9kZS0+ZnVsbF9uYW1lLCAnQCcpLCBpKTsNCj4gKyAgICAgICAgICAg
ICAgIGlmICghcGxsX2h3LT5uYW1lKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4g
LUVOT01FTTsNCj4gDQo+ICAgICAgICAgICAgICAgICBwbGxfaHctPmJhc2UgPSBkYXRhLT5wbGxf
YmFzZVtpXTsNCj4gLSAgICAgICAgICAgICAgIHNucHJpbnRmKG5hbWUsIDE4LCAiY2NjJXNfcGxs
JXUiLCBzdHJjaHJudWwoZGV2LT5vZl9ub2RlLT5mdWxsX25hbWUsICdAJyksIGkpOw0KPiAtICAg
ICAgICAgICAgICAgcGxsX2h3LT5uYW1lID0gKGNvbnN0IGNoYXIgKiluYW1lOw0KPiAgICAgICAg
ICAgICAgICAgcGxsX2h3LT5ody5pbml0ID0gQ0xLX0hXX0lOSVRfUEFSRU5UU19EQVRBX0ZJWEVE
X1NJWkUocGxsX2h3LT5uYW1lLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGxsX2h3LT5wYXJlbnRzLA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgJm1wZnNfY2NjX3BsbF9vcHMsIDApOw0KPiAtLQ0KPiAyLjI1LjENCj4gDQoN
Cg==
