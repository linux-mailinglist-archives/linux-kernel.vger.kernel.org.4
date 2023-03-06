Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EA96ACCEF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCFSrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCFSrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:47:06 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B541430B1D;
        Mon,  6 Mar 2023 10:47:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9BEAjJARckbhblGpvyXwEHp4KYBx1k5N3Fa6Xpjdx8TZYhSt7ie5wTGrZ6aW+DNN2+UIOR0KleAGvqQZBzoO2xFnQ9Q6XWLFm4XOPP/eaEJGtstqIvqzZIwX6syg9K+PbKDyUqteKVBEn5SM5liMaoKVZzzC3BlqTD+R2RApi2Q/+7ljvRhXgFopVa8xBwb8SQFDg1CM0WKCG+YGOh4gBWBpbeeIk9vooktXqPn0Mrk6tHjpeCl/6Zygavk4M5jU/BM9oyNQokT8aaiXDI2ugr5UFypl95kgCD/AJIKFRoJ1e2DKmjpvO8JaIgykzAFueqSSCCNJQePocuSVSZL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfjUzqeo6L+wD47isWt+wWCrieNi4JM123746b3/f8A=;
 b=fmoKA7tzActN1lfk+ei/v+xamtddDGV4kqyzA3kQRCUXXn0lO8xWoF3ep4T2XKCJ6S+uy4pIHyERPEjn7fAFbwdUVredjkLhmX8zVX56P9KaXP/OJkNZCLShMkZSngEcZv2gl/Ev6Cs9wVqA14AvQSqtEiTe/bYwz2AvynpaZ1Ld7cOVc3cxdsM8PcNEU6UjZlQL9aGlrt1+2Dw8NrzsXqNA7UckpKbss9oSfT2tr7f5Ymzp1RJSsKUwYjOoQ26bshobq85ZUWa0/+tyUSh+FgQaIyb0i8E8CWI+ymD9wybphABb15gFLBRd0duGCfasTiEX5VdcIpqlLq4h7ReHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfjUzqeo6L+wD47isWt+wWCrieNi4JM123746b3/f8A=;
 b=AaGzZWAZ3emEel4ncESuvXA2kRxJENYREmaMflgM5aIvJ4IrY+u7/7I0UXSp4qaO8Bp8Amj+z9ObXXCrfmgO6YN/sP0VCG7O/ytf4raVYHolWLrA6WVjZ3QxR9DrgD4sIQh0N7DHJSZKsF/OSddmCIgLtC6EG2OcTqNyUDAVq5Ixkl9FxfUjA1W3uezxD4KZEAqtz5tjmNv/25rhgMqnTpVl3AcNNRkDkc7ZafN5PlBmAR2qlMrZmkQM/CjNDpYzq3W42E3m55qVOioCebLhesPs5UKTMzVQddapcAtoJV9K7Zbv0rgPL92A3hLd8XF+sbmDvjrgm/hJaIWytMclaA==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by BL0PR12MB4929.namprd12.prod.outlook.com (2603:10b6:208:1c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 18:47:02 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::b22f:ead7:357e:803a]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::b22f:ead7:357e:803a%4]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 18:47:02 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] gpio: mmio: handle "ngpios" properly in bgpio_init()
Thread-Topic: [PATCH v3] gpio: mmio: handle "ngpios" properly in bgpio_init()
Thread-Index: AQHZThtH/OLv20XXVkWPk6fCVbgKjq7ppJuAgARuJPA=
Date:   Mon, 6 Mar 2023 18:47:02 +0000
Message-ID: <CH2PR12MB3895B0A2360B02F0387F9FBBD7B69@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230303215814.24783-1-asmaa@nvidia.com>
 <CAHp75VfpRVf3fzBf76mipu3dWDbwGCBFUOzyR-P=DLab3_y=Kw@mail.gmail.com>
In-Reply-To: <CAHp75VfpRVf3fzBf76mipu3dWDbwGCBFUOzyR-P=DLab3_y=Kw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|BL0PR12MB4929:EE_
x-ms-office365-filtering-correlation-id: dc67cb2d-c3fa-49f3-4f32-08db1e732ce2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pMQkIVK/fMydOzLjrIqetyqz57+vKS7razlxG/sgyPCfaFvKZdoTp4ngfLNwNglXpWAtgcS5easJWDpdw6yFxXUqx1WmoivDzlt8f5s+hA1XQqVJgFZ6GSjl/lddsqbkooovLGR9Zi1NfN14RWtf7WNetV8SCTuQXWYdWJIQKxr3usWfPurYnDwCDJLHJ+/ZvwJCqzYZxPgyAkORNzIxE7RRuFlffzg34sjO21YOAVHCnZfYMkIa9x7H/X6uthTfT304vD356rbCqcNNBbpwGEJTXfwUhoG/kn4KJQT2q24SyFUC5CVQA8e9ojCXkU3SA9WJ2gUg7IIkBCDEmslqz6RGfGHOteTr4ImDP7l3Nv6Qg9w1+9Ebhnuv/S9VJskJ/C5mqiFpmaAUUsWY17ajIyAsIateuBNQhSsnhE9oYuhctwvCqk962okvpkB6DiowrtZD+LSbGh215A8EyJyt/7yWg+gwkxGjtrCaZxvueYJJ24SoRCL9HvrYO6EhtozH6L9ocswBHpd4SeH9wX1Pxi0aRi8n25cGSMyxU3eFmV1sYlkjWQ3wzXpWEF0B3HJcVN2LFcHt5MKHUgLsmnFLp0tdQVGSsGrsyLF4aHvCBQ6sQ1bwMe0B6muEnpCvnrowKr22BNM37plgYbVOebRf59VicUEByG060nFxO+cqZzD+YJDjVRrvUatMcoSE/PS4CN8XyPVugklFluAXIHdYWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199018)(38100700002)(86362001)(122000001)(38070700005)(66476007)(33656002)(66946007)(5660300002)(2906002)(4326008)(76116006)(8936002)(64756008)(6916009)(66446008)(8676002)(41300700001)(66556008)(52536014)(186003)(26005)(9686003)(83380400001)(6506007)(54906003)(55016003)(478600001)(316002)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHBVYjhGUlhQMmJRZ2lEWDNPOG9EZ2NubUg3bzhTeCtWZVBoaTNTN1oyVVJU?=
 =?utf-8?B?UXVEOUd6QW05L05RS0dhcnROZTE1WGc1a0p5ZUlVTG5FZldZQkdDTkpDVjhK?=
 =?utf-8?B?N01GRmFvdGxiWGhWRkVCQUFCcUUva0p0ZTcvNmNZMVlkSTB6Tk9Jb1RldlA5?=
 =?utf-8?B?ZUs5NkFTYWhqbzVuSDJ3Vk0wV2FKMStEZWd4d0Z2R3pPaE02K2ExSUpDS2ZH?=
 =?utf-8?B?bGMwY05ZdXBNem1OSC9lNk9LUFYwem5Fbm1Xc1NnMlBKOFRXU3c2TytITTl3?=
 =?utf-8?B?d1g5dldqeWlTaTZvMTYwRDlpVFAybFVYRnRGVjJBbmZmdXNFS0ZVMGxVYXds?=
 =?utf-8?B?YzcwM2hZZTFuV0orMWIwd2JwWEFVMW05WWJaU0ZGRHl1MTgzalVkMWZGbi9o?=
 =?utf-8?B?c3hMWm5lckthY2JqOGFEZVRRVDIrVW1ObVErS2htLy9OQ2Vwb0FGcDZ1OHJT?=
 =?utf-8?B?TVR3RE5rWXZDWmIydWJRMjBVRVVPSnJ6K2RoMUkwNHB6REVGK3dWUWdQZzZz?=
 =?utf-8?B?NUp2M1ZjUDBSRDlYVzl5Z29nTDY1RzNPZHVRaXJJRXNKNUF3eEtUT1VlUUU0?=
 =?utf-8?B?aVJKSXlyMUZ3Y0dqQU1RSm1mNDZoNVN4MFZJNWovRCt2aDd5RytRN3ZxRk1P?=
 =?utf-8?B?UzBVcjNkTTU4TGFiRHZta3Byb25XMlVGYmFSY2pLRVZ2RXNtdkVTR3hodVpy?=
 =?utf-8?B?MWFYRjZJY1djRXBCUzRqdHFwOWJMci9od1gyVkxoVnZnMmpveWorMXRMQVNP?=
 =?utf-8?B?ckM4bXJ5ZlJSNWUyVGFTTGJCRHNFRklXTjVrcEZtVTc2amVEL255cmNRaDJP?=
 =?utf-8?B?ZmM1cnFxOXI4Vm55TG83WlJ6SmVWTWRCeC9UZ0hjVTRrVVpXZ3VVNUtLeU1Z?=
 =?utf-8?B?RFVSS1FWKzBWbFNISitXczRzT2xLcjZFQ1d3bmRySDkyN1FTeUwzT3RtY1RN?=
 =?utf-8?B?YURpd0JjSm5TaG1lOVdkcE5Rd1NxNEpMRTRveG5ldEdrM1M4WTlQQitBZ2Jq?=
 =?utf-8?B?YkdMNTJzUGVrMWVYL00yalZ1eGZpZDlOUWRhVVlJaGE0RFdtZ3N3UkovMmtt?=
 =?utf-8?B?NWNWZVQ3V1NydG4wS3psQmkzeVR4SFZUalRndFdaNzJKRzAwdk53UHNTcFRs?=
 =?utf-8?B?VTF2NHlqcE9ZTGpUdTNxSi9lWkg2MGF5NittRzNnUCtzSTY2V2FFbzRldmpp?=
 =?utf-8?B?b1J2cEt6U3VyWFNwMzdDNmlSeVVHOGpRMS9mcUJNSGJpTXIrU21lU1RVL2pB?=
 =?utf-8?B?SHdhdkpqekYrOW5hWEVRUHBuOE1aYVBMejhLOGRZY3N4ZEdJbUlmK2dzczY5?=
 =?utf-8?B?OE5ES3BaYUNCZkJ5Q3BMY21Zc0NMR2pRQVM5ZjRCUndTbWpCcm1oMWRvVlVN?=
 =?utf-8?B?RzRScFJIS0d2MUNsZlVXN0lOZDI5elRDQkZpUDNHUWZOM2RCV1V0bzJKRGVI?=
 =?utf-8?B?OFRTWDlNcUNFbkNWRy95L0hNUmdlVUxVMm41Qk9Rd21TV1BuaDJoL3B1ZjhO?=
 =?utf-8?B?OVNyNjVtZDFDRjFUcHNHbTZHSXpvWjRLekhNRWNRc1R3RkRPdUV4VkZuYzh1?=
 =?utf-8?B?dncveUZWbUZOUjA5Rk9kT3NxUXVMeHJTa3VQV0hVRk5tVzV2V2tOdVVtR3Qw?=
 =?utf-8?B?cGg1SEhjVUdpRmdFRWF0a2Z5S1pHOTA1VWNMbjlDWDFFOVBnMGNZNU1BdHNQ?=
 =?utf-8?B?aXYwQ3ZicEkwR21tVm1GQWpOY1ZwQUtCa3BDOUdqMURYQ0p0UXVXUDg5L0gy?=
 =?utf-8?B?OWxmSVFMWW5OY2NTYUJYalF3eEVmTWc2R1lSck5PVUhNeENQd2tPVDI1dzgw?=
 =?utf-8?B?N2JFWFB2OEFCeGgrQkhnZXlQYmJPOWFoendVRlJlMlREM1VFbncrWVVBdDcx?=
 =?utf-8?B?bUx3bHNSeVN4UDRMam5TYTlYOUdLblRXcStOc2RsRmpOaDNHSU9FeGFjZWt0?=
 =?utf-8?B?Z2NBSG9SeCs2c1BUK2FqSWhlbEN4OWZUSHdPQzZFTW13WU8xZDNzMTFMd3Y3?=
 =?utf-8?B?ZE1ZOU9oOUxTeG1OVUs3QXY0RFdFZlBMMmFBc2xLdHVncXk3NW51VEJLZWRG?=
 =?utf-8?B?b3YyZ2E0NFBsTGx0S2NBZk5KcmtaMjkvcmtyODREWVZESjJCVXZhLys3NkFB?=
 =?utf-8?Q?2nPM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc67cb2d-c3fa-49f3-4f32-08db1e732ce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 18:47:02.5845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ClUXZH7BrCLiheBCw/ar7mQvtS5Ea1NpYi7GS0VFsncfnRgsyFySTMA7B+P2i+LzfTfbIYGn4FMcqB2HoKMcIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4929
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsgICAgICAgcmV0ID0gZ3Bpb2NoaXBfZ2V0X25ncGlvcyhnYywgZGV2KTsNCj4gPiArICAg
ICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAgICAgIGdjLT5uZ3BpbyA9IGdjLT5iZ3Bpb19i
aXRzOw0KPiANCj4gQnV0IHRoaXMgZG9lc24ndCB1cGRhdGUgYmdwaW9fYml0cyBpbiB0aGUgc3Vj
Y2VzcyBjYXNlLiBDYW4geW91IGV4cGxhaW4gd2h5DQo+IGl0J3Mgbm90IGEgcHJvYmxlbSAoc2hv
dWxkIGJlIGF0IGxlYXN0IGluIHRoZSBjb2RlIGFzIGEgY29tbWVudCkuDQoNCkluIHRoZSBzdWNj
ZXNzIHJhdGUsIHRoZSBiZ3Bpb19iaXRzIHdvdWxkIGFsc28gYmUgZXF1YWwgdG8gInN6ICogOCIg
YW55d2F5cy4NClRoZSBhcmd1bWVudCAiIHVuc2lnbmVkIGxvbmcgc3oiIHBhc3NlZCBpbiBiZ3Bp
b19pbml0IGlzIHNwZWNpZmljYWxseSBmb3IgdGhpcyBwdXJwb3NlLiBUaGF0IHRlbGxzIHRoZSBn
cGlvIGxpYnJhcnkgdGhlIGdwaW8gcmVnaXN0ZXIgYWNjZXNzIHNpemUuDQppZiAoIWlzX3Bvd2Vy
X29mXzIoc3opKQ0KICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCiBnYy0+YmdwaW9f
Yml0cyA9IHN6ICogODsNCg0KSWYgaW4gdGhlIHN1Y2Nlc3MgY2FzZSwgd2UgbWFrZSBpdCBkZXBl
bmRlbnQgb24gdGhlIG5ncGlvIHZhbHVlLCB3ZSB3b3VsZCBuZWVkIHRvIHJvdW5kIGl0IHVwIGFu
eXdheXMgdG8gdGhlIGNsb3Nlc3QgKHBvd2VyIG9mIDIgJiYgbXVsdGlwbGUgb2YgOCkgd2hpY2gg
aXMgdGhlIHNhbWUgYXMgInN6ICogOCINCkkgd2lsbCBhZGQgYSBjb21tZW50IGluIHRoZSBjb2Rl
IGluIG15IG5leHQgcGF0Y2guDQoNCj4gDQo+IC4uLg0KPiANCj4gPiAraW50IGdwaW9jaGlwX2dl
dF9uZ3Bpb3Moc3RydWN0IGdwaW9fY2hpcCAqZ2MsIHN0cnVjdCBkZXZpY2UgKmRldikgew0KPiA+
ICsgICAgICAgdTMyIG5ncGlvcyA9IGdjLT5uZ3BpbzsNCj4gPiArICAgICAgIGludCByZXQ7DQo+
ID4gKw0KPiA+ICsgICAgICAgaWYgKG5ncGlvcyA9PSAwKSB7DQo+IA0KPiA+ICsgICAgICAgICAg
ICAgICByZXQgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF91MzIoZGV2LCAibmdwaW9zIiwgJm5ncGlv
cyk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChyZXQpIHsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBjaGlwX2VycihnYywgIkZhaWxlZCB0byBnZXQgbmdwaW9zIHByb3BlcnR5XG4iKTsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArICAgICAg
ICAgICAgICAgfQ0KPiANCj4gVGhpcyBpcyBub3QgYW4gZXF1aXZhbGVudCB0byB3aGF0IHdhcyBp
biB0aGUgR1BJTyBsaWJyYXJ5LiBXaHkgaXMgaXQgc28/DQoNClN1cmUuIEkgd2lsbCBrZWVwIGl0
IHRoZSBzYW1lIGluIG15IG5leHQgcGF0Y2guDQpUaGUgcmVhc29uIEkgZGlkbuKAmXQgaXMgYmVj
YXVzZSBJIG5vdGljZWQgdGhhdCB0aGUgZmluYWwgcmVzdWx0IG9mIHRoZSBsb2dpYyBpcyB0aGUg
c2FtZSBpLmUuICIgZ290byBlcnJfZnJlZV9kZXZfbmFtZSINCiJpZihyZXQgPT0gLUVOT0RBVEEp
IiBpcyBoYW5kbGVkIHNlcGFyYXRlbHkgaXMgdG8gYWRkIGFuIGluZm9ybWF0aXZlIG1lc3NhZ2U6
IGNoaXBfZXJyKGdjLCAidHJpZWQgdG8gaW5zZXJ0IGEgR1BJTyBjaGlwIHdpdGggemVybyBsaW5l
c1xuIik7IGFuZCByZXR1cm4gcmV0ID0gLUVJTlZBTC4NCg0KPiANCj4gPiArICAgICAgICAgICAg
ICAgZ2MtPm5ncGlvID0gbmdwaW9zOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAg
IGlmIChnYy0+bmdwaW8gPiBGQVNUUEFUSF9OR1BJTykNCj4gPiArICAgICAgICAgICAgICAgY2hp
cF93YXJuKGdjLCAibGluZSBjbnQgJXUgaXMgZ3JlYXRlciB0aGFuIGZhc3QgcGF0aCBjbnQgJXVc
biIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZ2MtPm5ncGlvLCBGQVNUUEFUSF9OR1BJ
Tyk7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIDA7DQo+ID4gK30NCj4gDQo+IC4uLg0KPiAN
Cj4gPiAgICAgICAgICAgICAgICAgcHJfZXJyKCIlczogR1BJT3MgJWQuLiVkICglcykgZmFpbGVk
IHRvIHJlZ2lzdGVyLCAlZFxuIiwgX19mdW5jX18sDQo+ID4gLSAgICAgICAgICAgICAgICAgICAg
ICBiYXNlLCBiYXNlICsgKGludCluZ3Bpb3MgLSAxLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgYmFzZSwgYmFzZSArIChpbnQpZ2MtPm5ncGlvIC0gMSwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgIGdjLT5sYWJlbCA/IDogImdlbmVyaWMiLCByZXQpOw0KPiANCj4gQUZBSVUgdGhpcyB3
aWxsIGdpdmUgYSBkaWZmZXJlbnQgcmVzdWx0IHRvIHdoYXQgd2FzIHByZXZpb3VzIGluIG9uZSBv
ZiB0aGUgZXJyb3INCj4gY2FzZXMuDQoNCnRoaXMgb25lIHByb3ZpZGVzIHRoZSAibG9jYWwiIGdw
aW8gcGluIGlkIGkuZS4gMC0+MzEgZm9yIGV4YW1wbGUuDQpjaGlwX3dhcm4oZ2MsICJsaW5lIGNu
dCAldSBpcyBncmVhdGVyIHRoYW4gZmFzdCBwYXRoIGNudCAldVxuIiwgZ2MtPm5ncGlvLCBGQVNU
UEFUSF9OR1BJTyk7DQoNCndoaWxlIHRoaXMgb25lIHByb3ZpZGVzIHRoZSAiZ2xvYmFsIiBncGlv
IHBpbiBpZC4gd2hlbiBiZ3Bpb19pbml0IHNldHMgdGhlIGJhc2UgOiBnYy0+YmFzZSA9IC0xOyBh
bmQgZ3Bpb2NoaXBfYWRkX2RhdGFfd2l0aF9rZXkgYXBwbGllcyB0aGlzIGxvZ2ljOg0KcHJfZXJy
KCIlczogR1BJT3MgJWQuLiVkICglcykgZmFpbGVkIHRvIHJlZ2lzdGVyLCAlZFxuIiwgX19mdW5j
X18sIGJhc2UsIGJhc2UgKyAoaW50KWdjLT5uZ3BpbyAtIDEsDQpiYXNlID0gZ2MtPmJhc2U7DQog
ICAgICAgICBpZiAoYmFzZSA8IDApIHsNCiAgICAgICAgICAgICAgICAgYmFzZSA9IGdwaW9jaGlw
X2ZpbmRfYmFzZShnYy0+bmdwaW8pOw0KVGhlbiB0aGUgYmFzZSB3b3VsZCBiZSA9IEdQSU9fRFlO
QU1JQ19CQVNFDQoNCkFwb2xvZ2llcyBpZiBJIG1pc3VuZGVyc3Rvb2QgeW91ciBxdWVzdGlvbj8N
Cg0KDQo=
