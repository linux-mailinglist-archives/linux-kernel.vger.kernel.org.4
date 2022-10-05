Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7559C5F50CA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 10:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiJEI1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 04:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJEI1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 04:27:44 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2131.outbound.protection.outlook.com [40.107.114.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6F45C36C;
        Wed,  5 Oct 2022 01:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxJIREhdSICIQp+BDMe+6VFAz9LFbyLvsnHS1db3ZVtJfGSWX7IAnoj2LBpuiR7qMpDQxEo7PhkOyfBAbb8Y1O4CPm3W86ysscAjtwTCXbpEAAoNYFTljJv6sLfbx5waKQd4n8a80uq0Ton4Oqro9x3Wrf8B6oyogwuNaTfkhTeKdKH+iABFiYYoPY5x+pXOaCJgnCa7Z5IMvMUojEJLaDJGhMpJFkVAIJHb/5Bv99RmjIueUWQAtWKe4VbOCBE7CKEczuXtKXZuGRUd7nDXXrx57e+RWdS4T1iRMVX9RMxP/xlkSOoEe7OSW28Jud+t/qbG4sdMK0C+CZWe5R2ZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXXlII8ExXZ7cc6HLiV9wDHrYW0TURJR3klLpG0C+x0=;
 b=niSWqOzYbUoH62XECiQY/wqueHXtR+vCtd10iySmFf0jOaSOwYggiFJNYgkDTHnk/+rpSUK43pnf6IbhDOAH2INlZCttFIwoZtaJQ/GsNhXkXKeK4HmWOM2a3Q8Bx1lmtEvNzCPV54kYPPoVjlCBZkmlCGZctKF+9iCVH7DoMJwoRt/fAIVlvh8UUhTTR7ZafjYO8l58Bv7UdWo+cvTaP7qWseWxC1wHlPHTo4FZ9k/9SDfqg6VdX2DsP2DU2VuDQaXbkhYqOfQSdwgJfU2a9/D9DfhpMMKJVUUhNtcIU8utH6J/yyzEoVD7iQxvZFa4kGQPA2T5YK+5JGgRd8KSGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXXlII8ExXZ7cc6HLiV9wDHrYW0TURJR3klLpG0C+x0=;
 b=rZ4HfVniBk9cptUjKtt+6o5SX0TEsFE9PCVvE2Qv2deOvmJFc2zp+E24o4zmSP2G/rgLeDOig/dOfV/1AffBAbdwGnycjCWhUD8tG+FlLhl6nXgGKHZsGKA274JdwSM8GVQMDcwR26JqWB9DAODF0jeoB8Z5jthofep4vG+F8Bo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB9645.jpnprd01.prod.outlook.com (2603:1096:400:1a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Wed, 5 Oct
 2022 08:27:40 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%9]) with mapi id 15.20.5676.032; Wed, 5 Oct 2022
 08:27:40 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to critical list
Thread-Topic: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to critical
 list
Thread-Index: AQHYzCwlVjlhhutYXUubI25P/bpXfa3mwNiQgAAA1QCAAADfEIAACcsAgAAFgUCAGLyhcA==
Date:   Wed, 5 Oct 2022 08:27:40 +0000
Message-ID: <OS0PR01MB5922DAA91FFD18FD52FEC916865D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220919133122.167794-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922E64DD745E4F8A5FEFCD5864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8vAjO9H9BdgNOVXkjWR9zpD+73P_KLo0683xp1nBgVViQ@mail.gmail.com>
 <OS0PR01MB59227B5F87C7FC3CEC271B0A864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8utdkb61v_1=G85O6OCtQDv-+5YuyFy4r7BW+fR2E=WkQ@mail.gmail.com>
 <OS0PR01MB592278FB3E443C84130FCA7D864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592278FB3E443C84130FCA7D864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB9645:EE_
x-ms-office365-filtering-correlation-id: cfa98945-96c2-4693-2417-08daa6ab7796
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P4qn3/E3ddbvwefLiq2StoBADuv7t/FdXQDsipz/e8c5MH4JDwpDvrUn3zqvyCXylCqp/M+EQDmelhY4PLfmjwDE9V2VGzJHUJ4d2czTG4OedGC5eTi3Lmc1GG3Wq/R7xv7J63ZFFyjwoCzwKZDTgX1BC0TGLmgjhG6DmhuA9TPiLBoGTNAY18A52YAX+lUS6SDbNeIhIo1KL23smKrjCNaQaf2BfGMg7MnHiMEtfWqLzF7nM5Hj3QzpYxOOv3kuMYIM4cTpjiTBl6cI+kQ+sMnRr6xnpr0I85QmVzbjJyiUd/pb+6mxFn3pB5V14bLzsJ5QlCf1Lwn779mU46U45FeRBwBq6DHRxKW1C5N3+P0psVvRPPjhDNYe+3qdJ4DiH9lfQ4C3bFy94EXZ8+rR4ZFUlAnakVMEfdqIzVJboNA9Hm9tj1s5PyvHh5XqlIMCeWKuUwc0hscdXK5fKYGMPw1iXzIvZYdI7OwLHpuCWaVidyGB5o3aza5O++RWmhkphWrunDhpKOTHOLJ1A/cp3/sC+ljQi5B44CAAhCZsw2K/Qs98o26UvUKnXyzeYOZfD1eQk5PAK5U06UTrQ6qAKTGZYKxexTIRjr+fNNbPlBFgkemx6rB3z5ezioXCwAN2wasfsitSHtHWfEVaUwKpz44IRSiqxs+Bnl9rs7xiCBmXW7UTcaRLvmGjThKj6AoURUNvDGpfgp6kea62+Z1rGYM9wzOi2EseM3umg5Yzcvn2lnLIkGg5KlZ8+D03HvSXs+Hzqvz03ZR2ZhGOcsPB6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199015)(2906002)(8936002)(52536014)(5660300002)(76116006)(38070700005)(41300700001)(55016003)(4326008)(64756008)(8676002)(66446008)(66476007)(66556008)(66946007)(38100700002)(122000001)(316002)(110136005)(33656002)(26005)(6506007)(7696005)(54906003)(86362001)(186003)(478600001)(71200400001)(107886003)(9686003)(53546011)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V09yWmoxZEVYdWNwdXZnQXFaV0hKSFRaQUlXa1VaWEhxTE1MNkx2bHcrODRy?=
 =?utf-8?B?WVAyYWppRnZ1bUlQanZBZzRPeTJKdDNQSmpZVW5GSWRIT3Z1V01ka21SZGll?=
 =?utf-8?B?WHlaL2tWb3N0LytueXFsQzhqN0JUd3JYRmkxajltNU5ldDJ4bzhtTU9JZ2Q4?=
 =?utf-8?B?cmhhTzBWWWFCU2JGa3VTdXRCdFcrb21lM0gwQXgwQ2dBbnJmOGd3b1FGYUZk?=
 =?utf-8?B?ZzJmN00weGlrRTRUOEZpME5mNGJ5dDFNUFFCRS9MNG9pVVQ0dVhtZXBGVkVD?=
 =?utf-8?B?dGthWnIyVTVPMWF5cGRmb2F2Rkl1U0grWHhpb2NITDVYa0RBQVRrOEtDSjg4?=
 =?utf-8?B?YVMvajdtWlJ4b2NwU3BYNWhlWTZFRjVYM1N3TVorKy90WkE1RjJqRUVvMFU0?=
 =?utf-8?B?Y0tKMHNKbzZ5YisrcXd4dVB2WVA4TExCY0ovdDQ3SWN5a3RwVnlqVWFJMVI1?=
 =?utf-8?B?S2lGemNXblZGWWJKTnoxWVRTVXZJRkVVVkc2aTQ2UzBFZ3dJZm1LQ1JsQ09H?=
 =?utf-8?B?VE4vZ2NCb0J1Z2pBbkllczVlSVFmeXZmalNBZG5iQmNtUWc1UTFLN09KcmJY?=
 =?utf-8?B?a1FmY2laK014ekVwL0YxeFpmbGFVYnl2Z3duTjJ5YVF3aGpjK2F6Qkc3WVMy?=
 =?utf-8?B?L3Bqa1ovOXc3amxQRG1IWTY5OElxS0RkSk9LdWlHYkxNekVBRXFxNXlGd0pi?=
 =?utf-8?B?NEJpTHNURTdTODViQjZjc3Z6Wjl1dkRWUEt4ci9VWW1Pcmd6T0VuRjdRc3hn?=
 =?utf-8?B?ZUM1MFVRS0dldVcvSE1taEFnN1U3VlZTbVFLNENHMVFoT3FYVUFwTURKc21q?=
 =?utf-8?B?Mi9PaGNOVGdzV0ltK2MwUk1qK2NxZ2hXSWE2UGNoOXVsZTkrNEp1U3o3Y0Jr?=
 =?utf-8?B?RzVaSnNHK2VHVWgwRHFHUWUvblFST2ZOQ3pvY3VvTFJQZWJEdWJqM1NGSDl5?=
 =?utf-8?B?TzhVaS9Sck5mMlNJZ25PYnE5TEFrZUVxeUdFcHRZaFlwT1h5dW1pb2N6NXB2?=
 =?utf-8?B?SVZqNnNmTmxpZnlBR1JvWUoyci9PWDgrbWhsQkNqaE5LNTVZSVdpanZBckc1?=
 =?utf-8?B?ZVc0SE5UTjRoakp6cFU3T0k3S2RxdVpHUHZJdE5OdURQeGdZMmVsVVgyVzdQ?=
 =?utf-8?B?RTZXY3A0aExVL1lLSGhmUjA3dHFBVy9LNmYvL3RKemNaMnVRckIyeXd2Ynk3?=
 =?utf-8?B?b05MQlFJL1NwcG1zbDU5WXdXcy9JaTE0M2Vqa3hlQXh5OXRacmd6cXN2Q0x2?=
 =?utf-8?B?bnNvdHRSVjViTUZPYnM4aTVhbFNnWnpWZGdkVjRvaHpkZWFGWHEzNXhiM21M?=
 =?utf-8?B?S2RaSWZEOWhncUNZN0o2NVdocXh5ZDV3SjdHQjRHVnRwa0FMek9JcitHb2F2?=
 =?utf-8?B?Z0dmYzZ0bFRjZnY5bTFYRUpDMEJoa3grcWZVY3RZTyttS3lEQmVRQkY0Mkxu?=
 =?utf-8?B?NlNXcUJQTnQxeVJKNXEyUWcvMFA4N0lEbzhGUDJUTCtkOTFLWG5EV2NkbE1R?=
 =?utf-8?B?emtPWk1yd0txc3BBS3V4YU1YaWtlUlJENG1QNFVBWDBZV1l2d0dQKzJma3ho?=
 =?utf-8?B?SWh2UEs1bFF1d3pwMkRyU2x1UE9qeG5iS3lHaWgwQmRKeXpIcnZTbVBWZkE3?=
 =?utf-8?B?a2FGL1FVV0R2L3g0QVVxOWJWSkVERXkzdWNzc2FCdDhCMGY1ZjIrWms4OURN?=
 =?utf-8?B?RUUzN0dPR0x3VGFaVTBtY3F4aWZlcCttcDYvNFJFNE15bHZ1VGozZzBjMkJZ?=
 =?utf-8?B?dzc0RE5uVnVtL2hmZ0luTk9UYzVDL2tEb083aThKeHExTWI2R3BzZWZpUHJh?=
 =?utf-8?B?VkNwWm15Vk9lbmxzcnVPTXdxMkR2bXIzakxRZG11Sm55L1lxVW9GNXllTWUy?=
 =?utf-8?B?eTdTWmF0eU5tMTZPSWE1N3YxMDUwRUtKek01ak5tckVEWHFQbjZtcDZYbHBZ?=
 =?utf-8?B?S1RhSEZXVXl2dDVMZlg1allERGRGN1pTQzZGRVhVWm16YStLZldQNklZcFEx?=
 =?utf-8?B?YzErRDg2TmRPbUpjRmJ0eHQzSmsvajRjeVRSK0syV0t2Y1A5SW1OSFk5UEFC?=
 =?utf-8?B?NE1qZEJzWm56aFI5M1lyNTZhZGJMUGxpUTJ3M0Y0ZmZsaXEvU0ZqNWw5dGJJ?=
 =?utf-8?B?RGtybG8rL0o1UExFVUo1bVVkZ293ZGZNNDVOcDVnL2ZNSlhxc0tqVDJkeUZx?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa98945-96c2-4693-2417-08daa6ab7796
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 08:27:40.2137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AkM+rFkBpfjDaT1UsD5LaCkdf2MSyGppCt2t/bQgJyiPlvWGjpSOJ+REhQ6APynlt8nE9XWJFIg1ow5PlZKJmnh7/JZFFfBqOgPAWoHDKLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9645
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQgYW5kIFByYWJoYWthciwNCg0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBjbGs6IHJl
bmVzYXM6IHI5YTA3ZzA0NDogQWRkIFdEVDIgY2xvY2tzIHRvDQo+IGNyaXRpY2FsIGxpc3QNCj4g
DQo+IEhpIFByYWJoYWthciwNCj4gDQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gY2xrOiByZW5l
c2FzOiByOWEwN2cwNDQ6IEFkZCBXRFQyIGNsb2NrcyB0bw0KPiA+IGNyaXRpY2FsIGxpc3QNCj4g
Pg0KPiA+IEhpIEJpanUsDQo+ID4NCj4gPiBPbiBNb24sIFNlcCAxOSwgMjAyMiBhdCAyOjUyIFBN
IEJpanUgRGFzDQo+IDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiB3cm90ZToNCj4g
PiA+DQo+ID4gPiBIaSBQcmFiaGFrYXIsDQo+ID4gPg0KPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBjbGs6IHJlbmVzYXM6IHI5YTA3ZzA0NDogQWRkIFdEVDIgY2xvY2tzIHRvDQo+ID4gPiA+
IGNyaXRpY2FsIGxpc3QNCj4gPiA+ID4NCj4gPiA+ID4gSGkgQmlqdSwNCj4gPiA+ID4NCj4gPiA+
ID4gT24gTW9uLCBTZXAgMTksIDIwMjIgYXQgMjozNSBQTSBCaWp1IERhcw0KPiA+ID4gPiA8Ymlq
dS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gSGkgUHJhYmhha2FyLA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBTdWJqZWN0OiBbUEFU
Q0hdIGNsazogcmVuZXNhczogcjlhMDdnMDQ0OiBBZGQgV0RUMiBjbG9ja3MgdG8NCj4gPiA+ID4g
PiA+IGNyaXRpY2FsIGxpc3QNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBGcm9tOiBMYWQgUHJh
Ymhha2FyIDxwcmFiaGFrYXIubWFoYWRldi0NCj4gbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEFkZCB0aGUgV0RUMiBjbG9ja3MgdG8gcjlhMDdnMDQ0X2Ny
aXRfbW9kX2Nsa3NbXSBsaXN0IGFzIFdEVA0KPiA+IENIMg0KPiA+ID4gPiBpcw0KPiA+ID4gPiA+
ID4gc3BlY2lmaWNhbGx5IHRvIGNoZWNrIHRoZSBvcGVyYXRpb24gb2YgQ29ydGV4LU0zMyBDUFUg
b24gdGhlDQo+ID4gPiA+ID4gPiBSWi97RzJMLCBHMkxDLCBWMkx9IFNvQ3MgYW5kIHdlIGRvbnQg
d2FudCB0byB0dXJuIG9mZiB0aGUNCj4gPiBjbG9ja3MNCj4gPiA+ID4gb2YNCj4gPiA+ID4gPiA+
IFdEVDIgaWYgaXQgaXNuJ3QgZW5hYmxlZCBieSBDb3J0ZXgtQTU1Lg0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+IFRoaXMgcGF0Y2ggaXMgaW4gcHJlcGFyYXRpb24gdG8gZGlzYWJsZSBXRFQgQ0gy
IGZyb20gdGhlDQo+ID4gUlovRzJMDQo+ID4gPiA+ID4gPiAoYWxpa2UNCj4gPiA+ID4gPiA+IFNv
Q3MpIERUUy9JIGJ5IGRlZmF1bHQuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gUmVwb3J0ZWQt
Ynk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiA+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IExhZCBQcmFiaGFrYXINCj4gPiA+ID4gPiA+IDxwcmFiaGFrYXIubWFoYWRl
di1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICBk
cml2ZXJzL2Nsay9yZW5lc2FzL3I5YTA3ZzA0NC1jcGcuYyB8IDIgKysNCj4gPiA+ID4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3JlbmVzYXMvcjlhMDdnMDQ0LWNwZy5jDQo+ID4gPiA+
ID4gPiBiL2RyaXZlcnMvY2xrL3JlbmVzYXMvcjlhMDdnMDQ0LWNwZy5jDQo+ID4gPiA+ID4gPiBp
bmRleCAwMmE0ZmM0MWJiNmUuLmNmOWIxYmQ3Mzc5MiAxMDA2NDQNCj4gPiA+ID4gPiA+IC0tLSBh
L2RyaXZlcnMvY2xrL3JlbmVzYXMvcjlhMDdnMDQ0LWNwZy5jDQo+ID4gPiA+ID4gPiArKysgYi9k
cml2ZXJzL2Nsay9yZW5lc2FzL3I5YTA3ZzA0NC1jcGcuYw0KPiA+ID4gPiA+ID4gQEAgLTQxMiw2
ICs0MTIsOCBAQCBzdGF0aWMgY29uc3QgdW5zaWduZWQgaW50DQo+ID4gPiA+ID4gPiByOWEwN2cw
NDRfY3JpdF9tb2RfY2xrc1tdIF9faW5pdGNvbnN0ID0gew0KPiA+ID4gPiA+ID4gICAgICAgTU9E
X0NMS19CQVNFICsgUjlBMDdHMDQ0X0dJQzYwMF9HSUNDTEssDQo+ID4gPiA+ID4gPiAgICAgICBN
T0RfQ0xLX0JBU0UgKyBSOUEwN0cwNDRfSUE1NV9DTEssDQo+ID4gPiA+ID4gPiAgICAgICBNT0Rf
Q0xLX0JBU0UgKyBSOUEwN0cwNDRfRE1BQ19BQ0xLLA0KPiA+ID4gPiA+ID4gKyAgICAgTU9EX0NM
S19CQVNFICsgUjlBMDdHMDQ0X1dEVDJfUENMSywNCj4gPiA+ID4gPiA+ICsgICAgIE1PRF9DTEtf
QkFTRSArIFI5QTA3RzA0NF9XRFQyX0NMSywNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IERvIHdlIG5l
ZWQgdG8gdHVybiBvbiB0aGlzIGNsb2NrIHVubmVjZXNzYXJpbHk/DQo+ID4gPiA+ID4NCj4gPiA+
ID4gTm8sIHRoaXMgaXMgaW4gcHJlcGFyYXRpb24gdG8gZGlzYWJsZSBXRFQyIGJ5IGRlZmF1bHQg
ZnJvbQ0KPiA+IFJaL0cyTHtDfQ0KPiA+ID4gPiBEVFMvSS4NCj4gPiA+DQo+ID4gPiBCdXQgdGhh
dCB3aWxsIG1ha2UgV0RUMiBkZXZpY2UgaXMgbm90IGVuYWJsZWQsIGJ1dCB1bm5lY2Vzc2FyaWx5
DQo+IHRoZQ0KPiA+IGNsayBpcyBvbi4NCj4gPiA+DQo+ID4gQWdyZWVkIHRoZSBjbG9ja3Mgd2ls
bCBiZSBPTiwgYnV0IGRpZG50IHdlIGFncmVlIGVhcmxpZXIgZm9yDQo+ID4gcjlhMDdnMDQzLWNw
Zy5jPw0KPiANCj4gWWVwLCBzdGlsbCB3ZSBoYXZlIGEgY2hhbmNlIHRvIGNvbmNsdWRlLCB3aGV0
aGVyIHdlIG5lZWQgdG8gbWFrZSB0aGlzDQo+IGNsayBhbHdheXMgb24sIGlmIGl0IGlzIG5vdCBl
bmFibGVkIGFuZCB0aGVyZSBpcyBubyB1c2UgY2FzZSBmb3Igd2R0Mg0KPiBjb250cm9sbGluZyBm
cm9tIENBLTU1Pz8NCj4gDQoNCkkgZ290IGNvbmZpcm1hdGlvbiB0aGF0IHRoYXQgdXNpbmcgV0RU
MiBmcm9tIENBNTUgaXMgcHJvaGliaXRlZC4NCldEVDIgaXMgb25seSBmb3IgQ00zMy4NCg0KV2l0
aCBDUEcgcmVnaXN0ZXIsIHdlIGNhbiBzZWxlY3Qgd2hldGhlciBDTTMzIHRvIHRyaWdnZXIgQ00z
MyBjcHUgcmVzZXQsIG9yIHRyaWdnZXIgc3lzdGVtIHJlc2V0DQp3aGVuIFdEVDIgb3ZlcmZsb3dz
Lg0KDQpJZiBXRFQyIGlzIHVzZWQgYnkgQ0E1NSwgaXQgbWF5IHJlc3VsdCBpbiB1bmV4cGVjdGVk
IGJlaGF2aW91ci4NCg0KU28gd2UgbWF5IG5lZWQgdG8gdGFrZSBXRFQyIGVudHJpZXMgZnJvbSBi
aW5kaW5nICsgZHRzaSArIGNsb2NrIHRhYmxlPz8NCg0KT3INCg0KQWRkZWQgaXQgdG8gY3JpdGlj
YWwgY2xvY2sgbGlzdCwgdG8gYXZvaWQgY2hhbmdlcyBpbiBiaW5kaW5nICsgZHRzaSArIGNsb2Nr
IHRhYmxlDQphdCB0aGUgZXhwZW5zZSBvZiB0dXJuaW5nIG9uIHRoZSBXRFQyIGNsayB1bm5lY2Vz
c2FyaWx5Lg0KDQpQbGVhc2Ugc2hhcmUgeW91ciB2aWV3cy4NCg0KQ2hlZXJzLA0KQmlqdQ0K
