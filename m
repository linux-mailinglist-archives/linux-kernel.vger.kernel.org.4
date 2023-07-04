Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55068746CF7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjGDJOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjGDJN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:13:59 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2095.outbound.protection.outlook.com [40.107.113.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664A6B6;
        Tue,  4 Jul 2023 02:13:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juZeXBVYZy32ooDCfypgUtAV0wIEk5Ea+qJyRHZyZKGM3c6KdrifrcHthqTQBThDLt/mgKz1uM8PKYx4hz1oh8kulK4v8Eutm+fSmhJOyAKcUBzg7olbfmiBBh+RkpFuN6TbQUmwY6fdhbPJRv2uInGYei+6HmwnTi1ipm1hjy6Zvw+38dxzzXEEeyHa2hkyRx6KAl1GjtntzEF0BNjsKcaWs1IRvaaRNKM+ht8olAfmQ5jH6Pcx9tAZJy33oOOUMr/IVOmcldkor7axOrGXxqByh2VeL78KgQ27hP27TEPyjfrMgZwDzCwDkTYvquTDWSaSyuQ+n/5vJczfOQY5sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWkVzcrPpIgOd+jaY+IOSbDv0nslnyQYEeOGF+vRs5s=;
 b=A6fE2I0LIJ9I5e0FrMsxuAFXaPaLgol2S4VtmWBgJvGRMPUh3SZzXdV1zJU/pGUEFDB6ogyq7aYtUvSMAFHbbERIJYRRb426jUECD14sAU8YyiGKX5305AnvOsBSdwRNP9yYd1IXJ2xlKlcJoh25rgqBZVLa19r82AZPyQHSBZZnWKhWW/s6C6MVtzd/n4Ol8vLYZzY7DpvhElcMxgmbiNfouM834t2wHJaf/irRwFwDrU3IXf1Iak09NgHw3+Prn/ExgZdxXgShsfXU5s9S+NiZDTOacxWvilgybfiWR+tCoH9lRXG+0SgftDVR6afi51JArz7gjknJeXbYq+4asA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWkVzcrPpIgOd+jaY+IOSbDv0nslnyQYEeOGF+vRs5s=;
 b=VOOCx9vI2RyPKQbhIELVSZhdZPybyflCtPCf/AhehYYLcKSJbz0b6s6kqA4NHhO++C6fV8e9m/THc4B/IsvyXXQYfNPXcN6ajhE/kUb3ol3cG1rH+R+GIAwvmUqrgrpIBMuznbfpmb8AbYfcT6Rz2u5kydDTZWz4ElrsPyEK/8A=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by TYWPR01MB10115.jpnprd01.prod.outlook.com (2603:1096:400:1e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 09:13:55 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::f12b:3194:2ef9:aa87]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::f12b:3194:2ef9:aa87%3]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 09:13:55 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH/RFT] pinctrl: renesas: rzv2m: Handle non-unique subnode
 names
Thread-Topic: [PATCH/RFT] pinctrl: renesas: rzv2m: Handle non-unique subnode
 names
Thread-Index: AQHZrcAPXISO82dPaUG1CDsE3LFWhq+pUg2AgAABR7A=
Date:   Tue, 4 Jul 2023 09:13:55 +0000
Message-ID: <TYCPR01MB593377C28DC38763481E0F31862EA@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <607bd6ab4905b0b1b119a06ef953fa1184505777.1688396717.git.geert+renesas@glider.be>
 <CACRpkdagL4h+UMVds51j-_i9cRgsJsM8Kq_hhzw=MiYsFvfPaA@mail.gmail.com>
In-Reply-To: <CACRpkdagL4h+UMVds51j-_i9cRgsJsM8Kq_hhzw=MiYsFvfPaA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB5933:EE_|TYWPR01MB10115:EE_
x-ms-office365-filtering-correlation-id: 70398871-4cd5-45a7-2eb9-08db7c6efde3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vmh6HcAKPwgp/d6ODAphvZDNP3xDt8/G0ilomyqvyWv22SmqS/3rFMZZupvFBGZWjrkDbjzPYuJOy3gXyTdoKQ6+yl/nB0/R8urFbXYQ/jjV8xyVUuV/P0wo4z66GqJhXhuD1IHt8VLc8zG2FmB9E/41seNRIGMdEyG3P+gscw2XfR51m++H+iZqPz1gEtY97teeitytVqmM7ZFcpki7Im3EseZFqtj44b1xi5zIRiXb3POrmPztk6yqo/d8lDMdMSYFSshXCiuLo5Xhgwv4K2QJBgplfzi+EIzsrg2eEhgzJiKKoMICeYtyWEaWapxLw4PbAp6zu8fJQhwJZWaJz1fLBifkCLiUTz8STa0afWQ98/drK9AAGnxp5v/7auC8Qdhz6f0OBr5ajp10i/mctuU8okqs3OuL250IIDSDfHRVISFn9qfkIimmu69G9VR/bkPysrpjEXBJjQwkLG1UK/03n3YvTvPgEc95H+M3MMKbVJiSpm93WoQmJrKyDtLsw6fSKZcrG0JnxvLsMN5C41pStVvlbLD/O+didI1dFtbclecgZEr6kilaSvSreOUjtYJku/6p6qNgcBxX80KiLXyQnyH9kEWE1vJBnKV5E8JTfTQBM0WvmLDdqUoRbXe9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(26005)(478600001)(6506007)(9686003)(71200400001)(86362001)(186003)(38100700002)(53546011)(54906003)(4326008)(66946007)(66446008)(66476007)(66556008)(83380400001)(110136005)(64756008)(7696005)(76116006)(316002)(122000001)(8676002)(8936002)(52536014)(38070700005)(41300700001)(2906002)(55016003)(5660300002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUx1Y3dVQ3VrNHNzK005K0NLUitTdW54WHZWclRBMkFGeGNqZkFLa1pkY29G?=
 =?utf-8?B?RVVMN2VCZUlHalFEQzlmTGZLZEQrVngwT0FMVDlabHNua3dPc0RGaUl6MjQ1?=
 =?utf-8?B?dEw0YXI1TTIyNSt5Y3JqOUVZdXdZdzhteVFIU0NnRnpWb0Zlc2ZnOThOYjRp?=
 =?utf-8?B?KzNIQk0wcHVjSXdFc1hOWTZ4QVc1T2ZyZTB0T1NSOWxXSGJFTXh6bnFZQzlt?=
 =?utf-8?B?WG83YW5DS2d5eUdPS2VCR2ZDaG5wa0RXL0habis4OGJIRm1Nb0NHU1hlRDBB?=
 =?utf-8?B?OU5iRGR6MkFkcUJ2UGtZU0NTQTVhcTJPMU85WTRrYkcxWW9GZ0dhZ05mN1FQ?=
 =?utf-8?B?K3N0S3VhYTdFZFY2Yk9jMkIwSGFFODZPWWwwNVRPSVBGTzljV0daajBhSWtJ?=
 =?utf-8?B?VS91N1BIamxUQ09QUVQ5b2VmcEpnU2w5d2VicnEzdXpVTlFsVVlBUXhJRFQz?=
 =?utf-8?B?L2lMbFczTzk4enBTbTJSRUZrNklZUG5IeXFwTWNMRGgwVUpWQjZ3T1hQTzIz?=
 =?utf-8?B?elFYaXlRUzFMbWt3ZVF3MkdmSjZWa2hFY3cvVll6bXI3SUhzcS96YnZLdU1P?=
 =?utf-8?B?U3dWcXZMamVVUmRLSXkrSy9OSG5UbVF6cm1ORG1palRhYlRlV21vQ1hDSUdm?=
 =?utf-8?B?eWxNQUhtcHNzOFVCeGZtaXVCemQweCtWNGV0anQyWDJNRWRaTVVtRWplbEln?=
 =?utf-8?B?UHRrWU5zUkJCVURaZ0xQVFcxUWJFaHVraEl2b284bExGaTd3WWZjMTZwdmEy?=
 =?utf-8?B?UUJqbjUvMmhtS3A4azZSUS9CbjBqdERUeUg5RWJQY0FKK0ErTlQ5SWVaWERJ?=
 =?utf-8?B?TC9Sc0Q3WElYTzBreTB0WUROaCtmUFQ5YURlaDRrVlhYWHZhUkpxZ01aeHJF?=
 =?utf-8?B?V3lSa09LbitKU2k1UTBWUmRSVUp4dHhUYTBkSms4WkhWelZIdmhQRTNYTW5s?=
 =?utf-8?B?Zk5WZkkycFh2T2lqYmpLaGtwMnVDa3dWZzh4RytKTEptZGZwb0RReEQ5cWpM?=
 =?utf-8?B?cWVtblkvSjBuc0E3bWxrZkZmckdJMFRzZ3pnL05ZYTBqalZIbVBMMkV3Vi9n?=
 =?utf-8?B?R3o5ejQ5UHBDZE04NldYaXA3RU5kM1U1dngvQS9wVUZDeGVvRE96eGpoQjhS?=
 =?utf-8?B?QmlzY1lsdndaWk5ZVTJQb1FrMUVubUgwYW1kQmNBbXdhQy9XL1djeHdNRXp1?=
 =?utf-8?B?M3V5WmU3K2NRTXlFRGRRY0p0bzlMbmZJRXZBTGNHSVFvTWdDREk4Y0JrZmsw?=
 =?utf-8?B?MFA5dnhVVkVrU3dOQ3hodDUzSDJ4WW9qeE5JdVZscThaSXNVK3lWYVhUUGk1?=
 =?utf-8?B?cWFQRi9acEd4SVhHcXlPN2d0ZUlKK0VnbDEyR1ZRSjl0NjFZNzJkRmVJK0xi?=
 =?utf-8?B?SnBIa0R5bnB3bFJjeDUxRVUzcUJ1MGE3Sm92cXR3STZFWTA4NUMrcFozYk0z?=
 =?utf-8?B?NEM0T2ZmZ0trWDJDUTdBbTlJUnh6VkNzeHFPOTRsZ0lFRFBsa2E1dzR2cGx3?=
 =?utf-8?B?K01OMEZRUVY3N3EvSnQ2a0E1Qzk0bjR5WGU4ZG5pbFlpVjMwbVkvb1RpUjlP?=
 =?utf-8?B?RkQrUkFDUW91QStudUUycHFHMkxiQkpjYWgvWG9LaGhrZVF0V2ZOTW42Qm9t?=
 =?utf-8?B?WktwcGlJaGdKcHpYUzk3ZGdoa0M0MGQvNEhsbVkrUWFZSnFLN1h0L0hzc1pX?=
 =?utf-8?B?YWwzNk5PSTN3Q080Sms1VnB0T2ZRM0JTVFU0enNUbkpHTTRnSTZFYVJ4c25y?=
 =?utf-8?B?aHV0VnpEMUJxZEJWMDRCZnNvZXh4QnhvSGVOSm5hSzArVnNYZHhhL21Nb0ti?=
 =?utf-8?B?UForS0Iyd0x0VnVDamI5eW5IRFRsUi9sSEZvVWdqNVFmbkE2L01zNTU5Y2ZV?=
 =?utf-8?B?SlIya3d5SHMyZU1rbC8rbzREUUhHOGkzalBzdWhvRFZ0NkxRN0M0M2ZPK1VT?=
 =?utf-8?B?K3RHb0tQaUpIbXBpanNnbkIvS05WYmlUbzFqRkNBVzJ3MUFhY1dlV040S3lw?=
 =?utf-8?B?RzNocHpEZHRzWktPS1hWakhiaitKMUYrUWZOdS9kVmJBVXpBeElrdVhsemRO?=
 =?utf-8?B?U2pYb29tSzF6cWh1NFJ4TTNqWGZPTXI1ZzRpVW9YazJXYVljeUZOZkhIOEdv?=
 =?utf-8?B?eGNPb3pjWGEwcWRCd1A0R1p2cTdMR2tTWTRRU2hnMXNBT3d5cnZqZUlpajRH?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70398871-4cd5-45a7-2eb9-08db7c6efde3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 09:13:55.0721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRXEUx0hjUm9IU9sv7NYhuyfuCzFB81AZtxnOmAkBmip7yG6+9vVoCt9/5fhp4HHwS6doRUboNmvSfn+qqd8yiupeLhcuNkIEl39buXshFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMgVywNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIL1JGVF0gcGluY3RybDogcmVuZXNh
czogcnp2Mm06IEhhbmRsZSBub24tdW5pcXVlDQo+IHN1Ym5vZGUgbmFtZXMNCj4gDQo+IE9uIE1v
biwgSnVsIDMsIDIwMjMgYXQgNTowN+KAr1BNIEdlZXJ0IFV5dHRlcmhvZXZlbg0KPiA8Z2VlcnQr
cmVuZXNhc0BnbGlkZXIuYmU+IHdyb3RlOg0KPiANCj4gPiBUaGUgZU1NQyBhbmQgU0RISSBwaW4g
Y29udHJvbCBjb25maWd1cmF0aW9uIG5vZGVzIGluIERUIGhhdmUgc3Vibm9kZXMNCj4gPiB3aXRo
IHRoZSBzYW1lIG5hbWVzICgiZGF0YSIgYW5kICJjdHJsIikuICBBcyB0aGUgUlovVjJNIHBpbiBj
b250cm9sDQo+ID4gZHJpdmVyIGNvbnNpZGVycyBvbmx5IHRoZSBuYW1lcyBvZiB0aGUgc3Vibm9k
ZXMsIHRoaXMgbGVhZHMgdG8NCj4gPiBjb25mbGljdHM6DQo+ID4NCj4gPiAgICAgcGluY3RybC1y
enYybSBiNjI1MDAwMC5waW5jdHJsOiBwaW4gUDhfMiBhbHJlYWR5IHJlcXVlc3RlZCBieQ0KPiA4
NTAwMDAwMC5tbWM7IGNhbm5vdCBjbGFpbSBmb3IgODUwMjAwMDAubW1jDQo+ID4gICAgIHBpbmN0
cmwtcnp2Mm0gYjYyNTAwMDAucGluY3RybDogcGluLTEzMCAoODUwMjAwMDAubW1jKSBzdGF0dXMg
LTIyDQo+ID4gICAgIHJlbmVzYXNfc2RoaV9pbnRlcm5hbF9kbWFjIDg1MDIwMDAwLm1tYzogRXJy
b3IgYXBwbHlpbmcgc2V0dGluZywNCj4gPiByZXZlcnNlIHRoaW5ncyBiYWNrDQo+ID4NCj4gPiBG
aXggdGhpcyBieSBjb25zdHJ1Y3RpbmcgdW5pcXVlIG5hbWVzIGZyb20gdGhlIG5vZGUgbmFtZXMg
b2YgYm90aCB0aGUNCj4gPiBwaW4gY29udHJvbCBjb25maWd1cmF0aW9uIG5vZGUgYW5kIGl0cyBj
aGlsZCBub2RlLCB3aGVyZSBhcHByb3ByaWF0ZS4NCj4gPg0KPiA+IFJlcG9ydGVkIGJ5OiBGYWJy
aXppbyBDYXN0cm8gPGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2FzLmNvbT4NCj4gPiBGaXhlczog
OTJhOWI4MjUyNTc2MTRhZiAoInBpbmN0cmw6IHJlbmVzYXM6IEFkZCBSWi9WMk0gcGluIGFuZCBn
cGlvDQo+ID4gY29udHJvbGxlciBkcml2ZXIiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEdlZXJ0IFV5
dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+ID4gLS0tDQo+ID4gVW50ZXN0
ZWQgb24gcmVhbCBoYXJkd2FyZS4NCj4gPiBUaGUgUlovRzJMIHBpbiBjb250cm9sIGRyaXZlcnMg
bmVlZHMgYSBzaW1pbGFyIGZpeC4NCj4gDQo+IElmIEkgbmVlZCB0byBtZXJnZSB0aGlzIGZvciBm
aXhlcyBpdCdzIGJlIGdyZWF0IGlmIHdlIGNvdWxkIGFsc28gaW5jbHVkZQ0KPiBhIGZpeCBmb3Ig
UlgvRzJMLg0KPiANCj4gQW55d2F5LCBJIGV4cGVjdCBhIHB1bGwgcmVxdWVzdCBmb3IgcmVuZXNh
cyBmaXhlcyBvciBzb21lIGV4cGxpY2l0DQo+IGluc3RydWN0aW9uIG9uIHdoYXQgdG8gZG8gd2hl
biBpdCdzIHRlc3RlZCBhbmQgY29uZmlybWVkIHdvcmtpbmcuDQoNCk9LLCBJIHdpbGwgcHJlcGFy
ZSBhIHNpbWlsYXIgcGF0Y2ggZm9yIFJaL0cyTCBhbmQgd2lsbCB0ZXN0IGFuZCBjb25maXJtLg0K
DQpDaGVlcnMsDQpCaWp1DQo=
