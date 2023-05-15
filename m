Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B85F703062
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjEOOo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238267AbjEOOoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:44:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93771FC4;
        Mon, 15 May 2023 07:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684161857; x=1715697857;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z0UYuKXZAimzRMSUvj1zKWNZ+l6ztyXJAeYQWXsusko=;
  b=yopQMOb406kujwOWR+dBKh99afkaFSALwDoaLH/cY0ciXR3Gii5hJBQD
   PFm6dvDBluT4iLVH71bcnKsnD4Kax+QyZFBdhag2kzwCYnFmeovw6O7XZ
   DGt08+XSgjmTR4HaoMACIn9uNR2VY7N59b092/8YiZd1ZtVL1TVW6PJid
   67EAUKHh6nzszP93yVSRr3Ua4EgOnQ3TuGKI0OYMR9k+bp9HbzEtVzRcc
   G05OQCVjLFBAxzvR9CsVv984oiPIUfRVBSx4pqJPtQ4pnmoFBh/iKBpsE
   SV8+g3f0qb2Xdeq83r+s+3WgFFj80YLOwYibAcJnK54kso6RMR01653Vn
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,276,1677567600"; 
   d="scan'208";a="225372504"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2023 07:44:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 15 May 2023 07:44:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 15 May 2023 07:44:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfT8no/UmcnVKAZDKi9wZlwQZ6oVCVxfn9IIXlKEoB8ceNuKUafAeETJjUw5Qbxmyn4qehZdElo+K4v+khgucjYBJAbuxf7bHfHXRFiyuV9urYoe2NHavCz/I5osgWpmWgX2kunk5aD1kKijGLwH0IrtDWbdDuk9U0jGPGu0ytdU2yZeJf5sZZ8pb7txOoW1xlCpcK7fLFtIJQXewuIdgK4eMRlmYFwZbVwNEE/GB9X2yQ5gcQ41tACKtwNWCzYk4cRzZMSIDw6AvhBQwPAMOsacpvWC6BCAnR2Uad25QuVNBYYx8LnJnk+OfShblqieSNmaRdz+yiVrpKwk3drSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0UYuKXZAimzRMSUvj1zKWNZ+l6ztyXJAeYQWXsusko=;
 b=T+4ec2eVT4/Kkkc4/Gmbs9DpbPj+Uv9CmBYAaPJiCMl/Lluk6pDF4lSk0xEi+Ypd9ldPDPbHxBvLVFzeVElMS2T2m8lYCtS5fzqa9NdUQzaPEMEVZ1f+LNP7+OJG4hMD2N/XztIq4G+scn0IJGTBbg0C7dJzhGbNb8ezkWFuCZZUa262IJpBSV9CpDoAIx+04jA3JyWLJNn6dt9c3ekAIFShJoGZ0C79t+F1HwvxrVLvyyy6EDCDy6ProTVueq7w7zE8M+uQ5D9iabDMuz62+uSHbXDH7I+E/MwGveMhHhlePBNdnXbymEmJ1br1vB3bkZ5/rSG6IBzEBbH4X32VBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0UYuKXZAimzRMSUvj1zKWNZ+l6ztyXJAeYQWXsusko=;
 b=huagYDBsAzAXxw85O6lXHac/J+B9kSZOzaIdktJrI+WQt9n4K/a8cP0DiRAGE3Afq0Ji9bP7MX++wVQX1RZP4bYW+aPeclpAYV1ebAQWFX+kPMN8c3hTPU2+D4RxnG8/RNm2CWZLaUN5XV403p1Zj0z3LGHS1aXsnP5KlhfmSGU=
Received: from DM4PR11MB6238.namprd11.prod.outlook.com (2603:10b6:8:a8::13) by
 CH3PR11MB7389.namprd11.prod.outlook.com (2603:10b6:610:14d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Mon, 15 May 2023 14:44:06 +0000
Received: from DM4PR11MB6238.namprd11.prod.outlook.com
 ([fe80::4f91:f62c:a55e:8589]) by DM4PR11MB6238.namprd11.prod.outlook.com
 ([fe80::4f91:f62c:a55e:8589%5]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:44:05 +0000
From:   <VaibhaavRam.TL@microchip.com>
To:     <michael@walle.cc>
CC:     <gregkh@linuxfoundation.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <arnd@arndb.de>
Subject: Re: [PATCH v11 char-misc-next 2/2] misc: microchip: pci1xxxx: Add
 support to read and write into PCI1XXXX EEPROM via NVMEM sysfs
Thread-Topic: [PATCH v11 char-misc-next 2/2] misc: microchip: pci1xxxx: Add
 support to read and write into PCI1XXXX EEPROM via NVMEM sysfs
Thread-Index: AQHZepKEX0F/13MY5UCvSdzErhCIxK9P+9AAgAuGwIA=
Date:   Mon, 15 May 2023 14:44:05 +0000
Message-ID: <87220fa2cac256353ada7a1626553957d8c71bcd.camel@microchip.com>
References: <20230429120209.2232-1-vaibhaavram.tl@microchip.com>
         <20230429120209.2232-3-vaibhaavram.tl@microchip.com>
         <78faf23f4f746f332dc53f7f981ac0fe@walle.cc>
In-Reply-To: <78faf23f4f746f332dc53f7f981ac0fe@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6238:EE_|CH3PR11MB7389:EE_
x-ms-office365-filtering-correlation-id: bb511c87-2621-436f-0671-08db5552d549
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WE8ubEnCe4ButifHfnaRJtDi/wrTzED9/qboOWiNP5WlNYjM/5gRSoCVP0icM9oNKjY8YlaRIIm82rVaWhevlBiDcz68boWce6iBxyvBukaMjakK4Biw9oKQT+kQTzZs+NXKxQYcQyF5tfVXnQfTTJRBd+W1KQ6xNIklbbT5go1pb6c2yf0DGXrbM22KWBEHuGFfSQ7S3sTpsMmJRbaHRLC0Yh0KFnDHLFsPks2ll3gUS+IDBP3NVNJ3rGVB7/WK5zUI03zggT9FVACCBGByFeRoYFAXOu1rLHCn8JojbXywz6fLTTFHd5XkigREBVMj4Ybfo1pIsJLOuV9QjC0XNf1lV9dLhrlDSkkhuT319eYrrmzTWK5T5Z34kcriO5+d7+5SW6MSWWFMIivVa40PTQQbTP8101DrVBnalj9KvH/dW9PhA86QTzw2jrVubLBERpUDezFunheaS1uRq2u8YVHMNt/w2Jc8/qiMza8aQ9K6s/2tquXDuKqN5JXtm6/6GophPJnOao0K+wI8U0D7sSIiR6NzXekM5WFi0imODZ+mrMR0i+hzTlAkpjk+uXZEAO9l6vW/Hx6GSYT5VC1sNuAy04cBhs8AHQQFy/KJTK5iOYhX/EDgMi6yCYPcV+Mzm4hzOhbLG9gK65eec9QzdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6238.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199021)(54906003)(478600001)(8676002)(8936002)(5660300002)(2906002)(86362001)(38070700005)(36756003)(76116006)(66446008)(6916009)(4326008)(64756008)(66476007)(66556008)(91956017)(66946007)(316002)(122000001)(26005)(41300700001)(38100700002)(186003)(2616005)(6506007)(6512007)(71200400001)(6486002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3JYUVBjbGtFNFcwbm1aMzJ3WURXSERJR2VwVGVYTjN5em9zZXkzcGdVMUYv?=
 =?utf-8?B?QmJJYnM5YXNXS0c2cjNQaWVVZENnTEs3QldWTC8xN2pqUjNyNmRST3ZmWnVU?=
 =?utf-8?B?TzdMZy96a254dVdFQWVTVFp1eGU0TDl1a0pIaTlRNUpUdTJybDlBdzVLanpC?=
 =?utf-8?B?YWVOS3pEbTB2dFF4dmUvSStnOHEzQTVhR3Z1R2FBb2RBQzdlMUc5ZlJodXE4?=
 =?utf-8?B?YjN2WWg4RFpDZ2dXMEtnZlZid1IyWHZreU1OT09YNmtBR3BsVzBUQldwWkg4?=
 =?utf-8?B?NGg2R3FiS1l0azRZZmVld05CMjRyc0RwaXFMQVFVUWFPaG05bnpRZFdLR3ha?=
 =?utf-8?B?N3RGY2xsaS94emU0bkljVkZaVGRRUElUbnFMVHAyamUrOGx0QkdxUE16Wldi?=
 =?utf-8?B?YmM5ektzMUM5bXdMMHB6UnpPNFZRMEVkVzBITlpjWVk4c3dTZCtKSkJOdFRP?=
 =?utf-8?B?blpOZjhPRWRwbmdIQ1drdFVKYVNOd3BCQmpUOVZWTGhzazhHdkl4bVlXWE1T?=
 =?utf-8?B?d2pIVkpUWmtycnZsemYzWnNnTmtZTTZHaWNDUnJ6dkVxOFJsS041b2d0NVBr?=
 =?utf-8?B?bUJZbkZreXlhRmg4c3hCaGJ5MnY3b1gxMU56ZXRZemN2WWFtYmNiNGxTV2ds?=
 =?utf-8?B?WU4rMWwrdm9US3ZON1JLelhVL0hjL3VTL0dncFlONHNUMVFad1ZkbFJ4RkVG?=
 =?utf-8?B?YzNDZzhPeURMYXV4anlJSkdCdHh6ZWs5cHZlcHJESVU2RUdTL3ovR3F2RitI?=
 =?utf-8?B?VXhISzlZd0dZNnNQejlGb1c4dG9EZEk5QXJQdFZpUFhxNFdQUzh2Y2NCVXZW?=
 =?utf-8?B?K29Zb1FDNmVIRWtpOXpRTTdFZmpRei9tNVdJS1p5a0VSbkI4VHY3OVZOSEpT?=
 =?utf-8?B?TGZOSzRicjc1bW4vNVRHaW5vdFJ5Vml1ZDd2NTdIK2k0UnQrMFRGc1lOb1NH?=
 =?utf-8?B?aWh3Q0lpaGRGWE16OFdudG5JNEYrTHNPMTRiR0RXTUxLbTRYU3VPOUtGY2E2?=
 =?utf-8?B?cmhtUm41UGplaXlRVVZXcnFwcmlRWEwvaGNIdmJqd0NaR1NCYUhqbmYwSmsr?=
 =?utf-8?B?NmFGQ0p1Nzh2d0VOcHMzWmJNS1NIcDBXRnBtZEh6WkZ5T3hHVUlFZDFkN2Mr?=
 =?utf-8?B?UmMwS0xEWkIwYnhKalpuZExhc0xBcmozNGtQd0ZDcThscTJCQUxaTFQ2TytR?=
 =?utf-8?B?NlRuRm44aThiUVh1RHVodGM1UVIyVElIZHlIb0JYQ0NCWlZSUHJCTFpDeDVv?=
 =?utf-8?B?eHFCd2FmM3p0Z2Z6QmxkaXZ1RUJsYVlMTDBveFR3dG5JRGlML2Vhck9YZE5R?=
 =?utf-8?B?d3hpSG5jNEVaYnQ1bGlvZVpnZHdLZXlSektieTduK0JXazhNbjZKN1lwS2p4?=
 =?utf-8?B?aGJQNW4rQVprR2M4Y3FIVlBvUVdRVm1Kb2h1R3BFeCtSNFNMZUllYVdQNTlz?=
 =?utf-8?B?akVwUFFOYzNJOUE2NGUwUkVpVFFWbytxRVM0RVRVaHEwd2s2eElpOHp1SmRQ?=
 =?utf-8?B?elJlZGt5a3o1cm5TSzcxemljOWdiNGRYZ1lxQzgvaXBMMzhNVW1GbmY0WG5B?=
 =?utf-8?B?YUlraUI4ZytScTI1a1lBR3BhNHYxR3kxcllBT3JnTTdWRWVuRGVnYzFGQkZ3?=
 =?utf-8?B?RHpGdDJYeEdkZmEwdmdHYUgyUW8yclAvUHdoUExURWFZL0U0cWJ2VDJubW03?=
 =?utf-8?B?UW12MEJxelNJWS85YkwycHQ3b1ZwSjZMcVIrZUdJSUlGZUhaT2xFVG1KdXdK?=
 =?utf-8?B?c3pMaGVLak5iNHJQMzZPK2N2b1RpNjZWNEhIa3djRXlEazRseCtyK2RtQy83?=
 =?utf-8?B?NHZpMzBhc0JGVU9JZDdya0lITlFWdGtaMG9GOTZwRVFDMUUvb2g5bExvcEJi?=
 =?utf-8?B?bUNsNHFrazU2SXZQS0ZRYzlWOTVOR1I2M3YrZXdmK08reDZFem45RVhSSVBS?=
 =?utf-8?B?MnV0M3Z1elhEQTVmc2RwVThIcTVqR3VTdm9qWGltTzBodWw2RzRYM2laQkw4?=
 =?utf-8?B?cWFJRVpMaTY1RllPRHRpWWpucThZOWpBRndhNm5zenJxdXVnb1AwQjBPbDBp?=
 =?utf-8?B?bEpXdEVvSForQ0k4MFVYQXZGcVVvdE1SR09iQTN0NkI1NGtadGdUc0tkSVRV?=
 =?utf-8?B?TSsrYldNaUhmVm42em9RZ3liZ01nQ2p0VElGQXNCSE1wVjdhLzJISnpFNTJ1?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9ECE743EDFA173458F73944778DC4ACF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6238.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb511c87-2621-436f-0671-08db5552d549
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 14:44:05.6602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6yEJE/Skf/HbWJ616q5OqldqYcosyG6YrqSq/GW1PAfVkf+O9gwOf8za9U6mqlg2LLbXrtPesGD1jQHjrYRwmGWeAHQ4EbRUjkBOlhkBp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7389
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA1LTA4IGF0IDA4OjQ0ICswMjAwLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpLA0KPiANCj4g
PiBAQCAtMjE5LDYgKzM0OCwyMiBAQCBzdGF0aWMgaW50IHBjaTF4eHh4X290cF9lZXByb21fcHJv
YmUoc3RydWN0DQo+ID4gYXV4aWxpYXJ5X2RldmljZSAqYXV4X2RldiwNCj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT01FTTsNCj4gPiANCj4gPiDCoMKgwqDCoMKgIHBy
aXYtPnBkZXYgPSBhdXhfZGV2Ow0KPiA+ICvCoMKgwqDCoCBwcml2LT5udm1lbV9jb25maWdfZWVw
cm9tLnR5cGUgPSBOVk1FTV9UWVBFX0VFUFJPTTsNCj4gPiArwqDCoMKgwqAgcHJpdi0+bnZtZW1f
Y29uZmlnX2VlcHJvbS5uYW1lID0gRUVQUk9NX05BTUU7DQo+ID4gK8KgwqDCoMKgIHByaXYtPm52
bWVtX2NvbmZpZ19lZXByb20uZGV2ID0gJmF1eF9kZXYtPmRldjsNCj4gPiArwqDCoMKgwqAgcHJp
di0+bnZtZW1fY29uZmlnX2VlcHJvbS5vd25lciA9IFRISVNfTU9EVUxFOw0KPiA+ICvCoMKgwqDC
oCBwcml2LT5udm1lbV9jb25maWdfZWVwcm9tLnJlZ19yZWFkID0gcGNpMXh4eHhfZWVwcm9tX3Jl
YWQ7DQo+ID4gK8KgwqDCoMKgIHByaXYtPm52bWVtX2NvbmZpZ19lZXByb20ucmVnX3dyaXRlID0g
cGNpMXh4eHhfZWVwcm9tX3dyaXRlOw0KPiA+ICvCoMKgwqDCoCBwcml2LT5udm1lbV9jb25maWdf
ZWVwcm9tLnByaXYgPSBwcml2Ow0KPiA+ICvCoMKgwqDCoCBwcml2LT5udm1lbV9jb25maWdfZWVw
cm9tLnN0cmlkZSA9IDE7DQo+ID4gK8KgwqDCoMKgIHByaXYtPm52bWVtX2NvbmZpZ19lZXByb20u
d29yZF9zaXplID0gMTsNCj4gPiArwqDCoMKgwqAgcHJpdi0+bnZtZW1fY29uZmlnX2VlcHJvbS5z
aXplID0gRUVQUk9NX1NJWkVfQllURVM7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoCBwcml2LT5udm1l
bV9lZXByb20gPSBkZXZtX252bWVtX3JlZ2lzdGVyKCZhdXhfZGV2LT5kZXYsDQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmcHJpdi0NCj4gPiA+bnZtZW1fY29uZmlnX2Vl
cHJvbSk7DQo+ID4gK8KgwqDCoMKgIGlmICghcHJpdi0+bnZtZW1fZWVwcm9tKQ0KPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+IMKgwqDCoMKg
wqAgcHJpdi0+bnZtZW1fY29uZmlnX290cC50eXBlID0gTlZNRU1fVFlQRV9PVFA7DQo+ID4gwqDC
oMKgwqDCoCBwcml2LT5udm1lbV9jb25maWdfb3RwLm5hbWUgPSBPVFBfTkFNRTsNCj4gPiDCoMKg
wqDCoMKgIHByaXYtPm52bWVtX2NvbmZpZ19vdHAuZGV2ID0gJmF1eF9kZXYtPmRldjsNCj4gPiBA
QCAtMjU4LDYgKzQwMyw5IEBAIHN0YXRpYyBpbnQgcGNpMXh4eHhfb3RwX2VlcHJvbV9wcm9iZShz
dHJ1Y3QNCj4gPiBhdXhpbGlhcnlfZGV2aWNlICphdXhfZGV2LA0KPiA+IA0KPiA+IMKgwqDCoMKg
wqAgZGV2X3NldF9kcnZkYXRhKCZhdXhfZGV2LT5kZXYsIHByaXYpOw0KPiA+IA0KPiA+ICvCoMKg
wqDCoCBpZiAoaXNfZWVwcm9tX3Jlc3BvbnNpdmUocHJpdikpDQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBwcml2LT5pc19lZXByb21fcHJlc2VudCA9IHRydWU7DQo+IA0KPiBXaGF0J3Mg
dGhpcz8gVGhlIGVlcHJvbSBpc24ndCB0aGVyZSAob3IgaW4gd2hhdGV2ZXIgc3RhdGUpLCB0aGVu
IHlvdQ0KPiBzdGlsbCByZWdpc3RlciB0aGUgbnZtZW0gZGV2aWNlLCBidXQgcmVhZCBhbmQgd3Jp
dGUgZG9lc24ndCBkbw0KPiBhbnl0aGluZw0KPiB1c2VmdWwuIFlvdSBzaG91bGRuJ3QgcmVnaXN0
ZXIgdGhlIGRldmljZSBpbiB0aGUgZmlyc3QgcGxhY2UgaWYgaXQNCj4gaXMgbm90IGZ1bmN0aW9u
YWwuDQoNCkFjdHVhbGx5LCBpbiBwcmV2aW91cyBhcmNoaXRlY3R1cmVzLCBmb3IgY2hlY2tpbmcg
YmluIGF0dHJpYnV0ZXMsIHRoaXMNCmZsYWcgaXMgdXNlZC4gQnV0IEkgdGhpbmssIHRoaXMgY2Fu
IGJlIHJlbW92ZWQgaW4gdGhpcyBhcmNoLiBUaGFua3MNCg0K
