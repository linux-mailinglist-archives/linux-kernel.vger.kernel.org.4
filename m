Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E4F609761
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 01:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJWX4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 19:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJWX4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 19:56:41 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2063.outbound.protection.outlook.com [40.107.114.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32EC61D57
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 16:56:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+c8Q+B3vSK6zw+AbuMJEcQz283bn61tnGLvqyhbo9xzkWT9rUz2twjqWCmsToZbJVgsuK/eBB9dkmwhH3l+P69MCzjtrwuwy3PcGhuhwTdvAp/mLdfFV0IUc5yJVKfblNqASikLFfXMfwmW9b3NVFMT1KjJno068ESkgPylzGW3sC1ObdUZoVsBY3i7EZUu8Mex5P6rMRdd160PbwDWjKKMWbC9+7e7nLm+AZffK8X50dPu2XmJ7NCUR+uGxHydR+DsrXalKxFbdYgOs48CNJRwykoKN4Ec9cZxfzINkZKOZZcy54e3Cz7cz8g3SemudYE6OViVoZCxXJfugaH1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNH0gtxcz6Ezx+b49wtK2/RdQry0cL84aNVHdXaDjrU=;
 b=Qd4OQMxUKas0k9eifvrrn9YwQXzj1twiueXypEXTli2lADa7nyqBMJtYV39x4fe8skDGFzaIeSnAkb/HkodZkAPapZUDOodTo9WM81jxCuoB8Blg0DC6At3zuvQSmOJL8GNgJ45WNu4IOmUB4jYQ3dbKEB8RDJPJGluGpy9/To2UEiTUYdTXiIsGxBGH/ztPa+lt4izL6f1CEdIa3CiJS3lZJ9gKyRCZztbUx6Sc0T8Qrj1J1bPrPGhXjejO7ix5V4l9dd+WaaVZVdo6U4RHUcDxMw7qYZYmwMes5ifUnto7aSkWLfyQJuESoI412frgL5OTLPSsEhblEx6K77ZMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNH0gtxcz6Ezx+b49wtK2/RdQry0cL84aNVHdXaDjrU=;
 b=VDkxrajRkHb6/YAHU4D8lV34RXmcDh8XlJe0NWDhfxZEhlHFni0zJzNVDARbsxlnSE9orgj/B//Q0XeDQhHqaK8G/9JDnGprehNGkz58VY1ES5+kHIO/5cXux1L4KyEfJDuevmYHs+00NQBqbAHx6hLClPovbRzT9pBCp7YBCkY=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY3PR01MB10029.jpnprd01.prod.outlook.com (2603:1096:400:1de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Sun, 23 Oct
 2022 23:56:34 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c%9]) with mapi id 15.20.5746.025; Sun, 23 Oct 2022
 23:56:33 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] mm: memory-failure: make action_result() return int
Thread-Topic: [PATCH 3/3] mm: memory-failure: make action_result() return int
Thread-Index: AQHY5Sb2eeX4VlpHC0m4P7p5ks+/C64cq9mA
Date:   Sun, 23 Oct 2022 23:56:33 +0000
Message-ID: <20221023235633.GC4024629@hori.linux.bs1.fc.nec.co.jp>
References: <20221021084611.53765-1-wangkefeng.wang@huawei.com>
 <20221021084611.53765-3-wangkefeng.wang@huawei.com>
In-Reply-To: <20221021084611.53765-3-wangkefeng.wang@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TY3PR01MB10029:EE_
x-ms-office365-filtering-correlation-id: b55d7b19-6233-4eb2-6864-08dab55236e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JCau0ftlo8tYLi6r8XH5Ke/dUU0mNN9+iiJnK2ukkku9PgxpJviGeWgRyjeEllp6l1c5wJuifpCtH45+1XxG7A5v6lZufiktJcNiahrAFaJzoaF+T0LWChWmErTCo8PE5PxMnXyN4yAVjCCw9OcftOwkITKl9me/Hsxq8xvi+LLwAhBPvzRjOya5FEq6T1bS86tY2tZ3wC22NJ9nK1EPjRcsx2a0MzymNl8r7vBDi3xbnbz+p9XxkqLtAWlMpr6O3FQT9q5MQVRUeuSYV4GPRWRd7L8bsS4UepSfplJiJ9X5jbVPrWzDFhwnJRjaQLrDvbqp7SJzbDofyGImIJM1pDW/vh/vnB2c7p2IUlghaBqkCaskuNBwCY3dSoVhScWZuv1+19No4uOre1mEZlQUhIV3zaxbSkjxfh/DQZpUSxykK/x6DiuoQhtAHduXbU+oNdQhjdzIrB3Ls+TEu1s10XK3fOtPPtKOqrLLELW0p5pxsxSItIdFNaHbCef1ktB+0UzvAAGJvPE69f6LaEJlYJwzC11cQnlpDaXveUJVZfMuEnILbhbT+TY2CDBArPToWTk4QheD1dMQuJ93VzCxUpcxEFNcmileSVOECljLG27NEGY+Im2uiyRamruOEm4V2eggEn5rSmUvzrVIwTQBLNzCUrSXnYIFVmmg/H6HJgADospS0Od53OdTkorqLRqygN4f51kAtrpa27QFv/aUJfHXpUxUjapfXLPe8Sq/FVgabCnzaDxFYUNduvX5Ac79gHju0cljNdbSo2c5FKIuQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199015)(41300700001)(5660300002)(8936002)(6512007)(9686003)(6916009)(26005)(54906003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(6506007)(85182001)(4326008)(316002)(82960400001)(38070700005)(122000001)(38100700002)(2906002)(1076003)(186003)(33656002)(83380400001)(86362001)(478600001)(6486002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE1XTUNPeXNHWlY5Tkk1QTZzOGVJeW9IREJyZ0plc1ZKOHkwaEkySHBlb2x6?=
 =?utf-8?B?aWFVdXdURW9TMjk1Nk0xSDBieTdLemFyb3RXTnBWclhDc2ZrQ1kyNWh6dlRp?=
 =?utf-8?B?QkdiaU5ab1BORnRXRUd3SnRsN05MZVhDRzduK09DSjgwbDJQM0RmNWhydlcz?=
 =?utf-8?B?N0xBa0N0dVFFUXdHb3BmbllzTFBMRDJlKzlzK01RUUxzYzhWR1Y1Q2V6aUxT?=
 =?utf-8?B?ZEloMHNCUi9FZVRKRlhYZ2ZKWkdtTGtvUTg0TWlEcGVRUEpTMGVncWxnUVRG?=
 =?utf-8?B?aDQxUnRGdXRzUGl1OVNqck1BRkpGN3lGYllFSm43Y2J0M2hrY2syczFrQlZV?=
 =?utf-8?B?YnlSQmNnL2hDTHFCcHNuT08xbHFVbXhuc0J1UTBOVDBwcEJLNUFINVA2YTFE?=
 =?utf-8?B?K2k5OFpnZlNQU01Jdy9tS3BHZ2RNbDlDeE1Bb2luSjFNZXgwWDNDRjYyWEo4?=
 =?utf-8?B?OWcvMlk2QnI3bm5EZS9JeEY3enVsN2NOUHdBREJDSnVLVlNEcmlyQVdJbVVh?=
 =?utf-8?B?ekYveVhqQ3RTK25UWEtkWEhMWGNwWWtPYmxaMFRERHlOSjRtMUhuN0NFQko3?=
 =?utf-8?B?WjFTblA4bVNLd1NwVi9IOU9aa2lZWkNCMUJYOWtDVWtsQmdUbUlsZkZrMnUx?=
 =?utf-8?B?ZUdRa1RxemxkZGFmWWc5eXUrQ1VWOVd1MmZDNWgxOThyWE9Zd1hrTUkyTHVt?=
 =?utf-8?B?VDJaTTBObFdieXRUWWFyZkptT2VwRzZPWXBTYVI3ZkRXSTdSZksycUllSlBG?=
 =?utf-8?B?VkQ3QU9iKzRwNXNleWVPYnFmYit1UjVqSGJQZGlUZlRORXBtNExZdDNYNUdO?=
 =?utf-8?B?QmNVeWpPeFlvUFN6THVHRVhKZ0JGd293NlowZXQybzk2M0NKS2tBajMzNmFw?=
 =?utf-8?B?NGdKL0ZFQ0dVaTFZWmNZelhmaVNHWm9lYUlzVThpcEV6MXUzREtKZTlpMnpU?=
 =?utf-8?B?UU1iVjV2RFZTbzlmNkNrNDg5b0I1R2JPVGZLNkc4NHUvSHd3QStNaU53Y3VY?=
 =?utf-8?B?UTR2QjBGMEQ2YUdGNGcwWG5KL3c1ZG5WMjNXSTU1NDBnb0dBQ1NuSEFsNklt?=
 =?utf-8?B?V0hRYXpWUmw1ckpkVXkrZm1hQ0djWjlCa253Z3lHVm5vcVpsZWZmMEdZMW9h?=
 =?utf-8?B?Q2o2OWNiL2lCOGQ4b3BhMXhQTUtKSFRGeDMvQkxHMlBXN2VOL1ZMM0NoY053?=
 =?utf-8?B?UzZNYmlVUHNGTkZUT3E4cjZkeU1SWExKcldQWnJIdHFxRFVOdnAyMUh4RHRN?=
 =?utf-8?B?Y1U5b1k1ODRHN0FPVm5lQ01UVEc1VHR3Y2M3d3BsNVp5c2V4b1VValgzMmQ0?=
 =?utf-8?B?eXkxUFlXMkFobVpadGRzVHA2MjIwMVozRldlS0drZ0ZtZURHOHhKSkIvOHdE?=
 =?utf-8?B?UWhJSXNES0Y2MFpONmVmLzFqZHhwU0JScEtVWFplUW9HWHBQajdPVCt2UU5W?=
 =?utf-8?B?NFR6V2d2SGIxZXJQZHdIbHdVWHJoQzUyZzczR3VmcDdqeVZOZ1FZbVF0MUdv?=
 =?utf-8?B?YjFKYUxubDZnRnlVNEpqUXdNL3JPYTgvbnlxcTI4NDFiUTVTM2JKZGw0aWRW?=
 =?utf-8?B?ZkVZOTQ5TzhVVUdyamd2ZGZOTXA4bkpOS2tLc3lHcjBPRzhWRDFoZWhrNVUz?=
 =?utf-8?B?YXJNeWxxdDB1Y1ExY2lVUnpNd3BiRzlPKzVpbEdzV3JiaW8xN1JwY24wN1FJ?=
 =?utf-8?B?R3BLUzJEMkNJMy9QTzRCOWtGNFliUHlPRE9FYTRlazg2V0RNWWhIb2xWVVg4?=
 =?utf-8?B?NEF2cTFFUzFhZ0x3SmJzdVMzUW1EY2N1b2tFZVdGLzFDUHhTMGE3SStzbXl4?=
 =?utf-8?B?TGhJR0FRbGJ0UjhsQ3BVWWpRdER3cSt4ZU1JMURTczFxVEdtTFlieUlabjRX?=
 =?utf-8?B?Z1RHaDNmNS9FcnZsQ0Q4OGxVYzhOQTUzQ1JSY0ppUEpFMEx4c1kwTHc1VThy?=
 =?utf-8?B?OUlrdTlSMkdPRzhRSUFtNDlBSlUvY1NVelVhT2RTd25BZjdMbU9JZmxLRTd1?=
 =?utf-8?B?cktxWWRVeWp2WW9Bd09UanFOTzNXbkNtcTNQQnBiRnZPM1ZXbDFRZXRldndL?=
 =?utf-8?B?bUhtUHc0MmdUZmZMQnkzaG8wc2J5T3ZtSzNxWUF1emdLZXd5OXdmL0JjdFQ1?=
 =?utf-8?B?NmtjRmJiaDdISW5NWThDL0wrK0pPa3lRT0NMTm5tT29uNjNtK0tMTjgrRDRo?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5519C57734ABB244A000CEE5BFD25249@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b55d7b19-6233-4eb2-6864-08dab55236e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2022 23:56:33.8762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AT1SOu4n+MFNREsSFHhQP8dsDTrl/9d9hxq3mzdqRh+N2vbHaqUOpU7M2+NQ8lxDSga9Dtq/D2rnrvYT1/MjSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBPY3QgMjEsIDIwMjIgYXQgMDQ6NDY6MTFQTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IENoZWNrIG1mX3Jlc3VsdCBpbiBhY3Rpb25fcmVzdWx0KCksIG9ubHkgcmV0dXJuIDAg
d2hlbiBNRl9SRUNPVkVSRUQsDQo+IG9yIHJldHVybiAtRUJVU1ksIHdoaWNoIHdpbGwgc2ltcGxp
ZnkgY29kZSBhIGJpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtlZmVuZyBXYW5nIDx3YW5na2Vm
ZW5nLndhbmdAaHVhd2VpLmNvbT4NCg0KVGhhbmtzIGZvciB0aGUgY2xlYW51cCwgS2VmZW5nLg0K
SSBiYXNpY2FsbHkgYWdyZWUgd2l0aCB0aGUgY2hhbmdlLiBJIGhhdmUgb25lIGNvbW1lbnQgYmVs
b3cgLi4uDQoNCj4gLS0tDQo+ICBtbS9tZW1vcnktZmFpbHVyZS5jIHwgNDIgKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5z
ZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5
LWZhaWx1cmUuYyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gaW5kZXggY2EwMTk5ZDBmNzlkLi4z
ZjQ2OWUyZGEwNDcgMTAwNjQ0DQo+IC0tLSBhL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gKysrIGIv
bW0vbWVtb3J5LWZhaWx1cmUuYw0KPiBAQCAtMTE4MiwxNCArMTE4MiwxNiBAQCBzdGF0aWMgc3Ry
dWN0IHBhZ2Vfc3RhdGUgZXJyb3Jfc3RhdGVzW10gPSB7DQo+ICAgKiAiRGlydHkvQ2xlYW4iIGlu
ZGljYXRpb24gaXMgbm90IDEwMCUgYWNjdXJhdGUgZHVlIHRvIHRoZSBwb3NzaWJpbGl0eSBvZg0K
PiAgICogc2V0dGluZyBQR19kaXJ0eSBvdXRzaWRlIHBhZ2UgbG9jay4gU2VlIGFsc28gY29tbWVu
dCBhYm92ZSBzZXRfcGFnZV9kaXJ0eSgpLg0KPiAgICovDQo+IC1zdGF0aWMgdm9pZCBhY3Rpb25f
cmVzdWx0KHVuc2lnbmVkIGxvbmcgcGZuLCBlbnVtIG1mX2FjdGlvbl9wYWdlX3R5cGUgdHlwZSwN
Cj4gLQkJCSAgZW51bSBtZl9yZXN1bHQgcmVzdWx0KQ0KPiArc3RhdGljIGludCBhY3Rpb25fcmVz
dWx0KHVuc2lnbmVkIGxvbmcgcGZuLCBlbnVtIG1mX2FjdGlvbl9wYWdlX3R5cGUgdHlwZSwNCj4g
KwkJCSBlbnVtIG1mX3Jlc3VsdCByZXN1bHQpDQo+ICB7DQo+ICAJdHJhY2VfbWVtb3J5X2ZhaWx1
cmVfZXZlbnQocGZuLCB0eXBlLCByZXN1bHQpOw0KPiAgDQo+ICAJbnVtX3BvaXNvbmVkX3BhZ2Vz
X2luYygpOw0KPiAgCXByX2VycigiJSNseDogcmVjb3ZlcnkgYWN0aW9uIGZvciAlczogJXNcbiIs
DQo+ICAJCXBmbiwgYWN0aW9uX3BhZ2VfdHlwZXNbdHlwZV0sIGFjdGlvbl9uYW1lW3Jlc3VsdF0p
Ow0KPiArDQo+ICsJcmV0dXJuIHJlc3VsdCA9PSBNRl9SRUNPVkVSRUQgPyAwIDogLUVCVVNZOw0K
DQpJIHRoaW5rIHRoYXQgTUZfREVMQVlFRCBtYXkgYmUgY29uc2lkZXJlZCBhcyBzdWNjZXNzIChy
ZXR1cm5pbmcgMCksIHRoZW4NCnBhZ2VfYWN0aW9uKCkgY2FuIGJlIGNsZWFuZWQgdXAgYSBsaXR0
bGUgbW9yZSAobGlrZSBiZWxvdz8pDQoNCiAgICBzdGF0aWMgaW50IHBhZ2VfYWN0aW9uKHN0cnVj
dCBwYWdlX3N0YXRlICpwcywgc3RydWN0IHBhZ2UgKnAsDQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdW5zaWduZWQgbG9uZyBwZm4pDQogICAgew0KICAgICAgICAgICAgaW50IHJlc3VsdDsN
CiAgICANCiAgICAgICAgICAgIC8qIHBhZ2UgcCBzaG91bGQgYmUgdW5sb2NrZWQgYWZ0ZXIgcmV0
dXJuaW5nIGZyb20gcHMtPmFjdGlvbigpLiAgKi8NCiAgICAgICAgICAgIHJlc3VsdCA9IHBzLT5h
Y3Rpb24ocHMsIHApOw0KICAgIA0KICAgICAgICAgICAgLyogQ291bGQgZG8gbW9yZSBjaGVja3Mg
aGVyZSBpZiBwYWdlIGxvb2tzIG9rICovDQogICAgICAgICAgICAvKg0KICAgICAgICAgICAgICog
Q291bGQgYWRqdXN0IHpvbmUgY291bnRlcnMgaGVyZSB0byBjb3JyZWN0IGZvciB0aGUgbWlzc2lu
ZyBwYWdlLg0KICAgICAgICAgICAgICovDQogICAgDQogICAgICAgICAgICByZXR1cm4gYWN0aW9u
X3Jlc3VsdChwZm4sIHBzLT50eXBlLCByZXN1bHQpOw0KICAgIH0NCg0KRXhpc3RpbmcgZGlyZWN0
IGNhbGxlcnMgKEkgbWVhbiBhY3Rpb25fcmVzdWx0KCkgY2FsbGVkIGZyb20gb3RoZXIgdGhhbg0K
cGFnZV9hY3Rpb24oKSkgYXJlIG5ldmVyIGNhbGxlZCB3aXRoIHJlc3VsdD09TUZfREVMQVlFRCwg
c28gdGhpcyBjaGFuZ2UNCnNob3VsZCBub3QgYWZmZWN0IHRoZW0uDQoNCkRvZXMgaXQgbWFrZSBz
ZW5zZSBmb3IgeW91Pw0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGk=
