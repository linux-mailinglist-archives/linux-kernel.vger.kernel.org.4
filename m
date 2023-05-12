Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A12700780
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240608AbjELMN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbjELMNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:13:23 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2104.outbound.protection.outlook.com [40.107.113.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E203C39;
        Fri, 12 May 2023 05:13:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJr2w5Ob6hB29IfTCLtCk/NneHMv6sC0QQopnga/HPZpaQozK95LziNGS4wj97SpgFnB0fN47z51zwOP+O2eVZXspLlrQcPfm4EWw8+lDjyKiIZtbBVZ5jY8bqcd+CXbLb4cm2jOLihgFRJhVIe4gluSSKjK8+jUsdAQwlOJTiE+FoHKJRQNrXsxkc3HN1qI96jKUvLTzRd2SwKTGj2s86BRiQywEjo+gbP1FM8No3mMlIkqvBaeZ/GVSvUq6P5C/pcQHP5HKNhuKlC770pZHtWliV7iiJczmQFHLBzAg6O3yRN8HPLVNoAYVL1LC72tO2oM50coeFMS+R7/UAaTJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuKkBBS8r/DjZ8HtApXhceTe6oXlki0EkKl7teAidRM=;
 b=gtm/4uXAMT21MbU5cKmVNh5500Qb0fdl7BCeficcPG8HTCbh0fdxMw2clC74bz4XUgjSgEHzQqsQWo+jGW/UuYmS0eZ4ePyh/jmyjvuJsHM65ZC/Hf8wlHyDzfGTQ7Nv+ttS/53hXuakDVypByAZ390/gSOuqfny0hiXvnqh4LRAEgmPVftamJw9Kt0K2u0nDLSpj1TROnh7CblOxdm6Li4paE5rSAIznifFKbJUFeTdrNE743/0jQ3wnb5cxMqqUtyeVGbUlpfPoKkn50J8JIzpTqAIwbFylWQenBymHGpBrj8LRmrG7bTQdQapOahPrATpGJhKa7aDyBcsCiQ12g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuKkBBS8r/DjZ8HtApXhceTe6oXlki0EkKl7teAidRM=;
 b=gqiuOPL7jvpVLZIRH5KnYf7KIHOrFEhTpqUEGFvXMjyKvTXY16HqUGmRrlB+h6fJ8y2wzJ+VgYU34USzKhKh0Alg6AMUtGm7YAi33JEHrsv38haPiOBGTpKGsV8CC3kSjV37+uhTOoRNjqgq/6LyF8K145VjOqXtzvXoBRQUdyU=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYYPR01MB8000.jpnprd01.prod.outlook.com
 (2603:1096:400:f9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 12:13:17 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%7]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 12:13:17 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH RFT v3 0/3] drivers/thermal/rcar_gen3_thermal: add Gen4
 fuse support
Thread-Topic: [PATCH RFT v3 0/3] drivers/thermal/rcar_gen3_thermal: add Gen4
 fuse support
Thread-Index: AQHZhD3ysbOIiRq6BkyZmSYQ5SIz169WjPmw
Date:   Fri, 12 May 2023 12:13:17 +0000
Message-ID: <TYBPR01MB5341AF3D9EB0F9A074283341D8759@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230511192220.7523-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230511192220.7523-1-wsa+renesas@sang-engineering.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYYPR01MB8000:EE_
x-ms-office365-filtering-correlation-id: 5f824e8a-54d9-4f10-e23c-08db52e2451e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qkBebTNMPV0jBce6Sw+n65O/ZQJhvYzsATwl7//wwkSo/ep6nlQ5Ow2CEjL4Z2IIhSvnImZoUEyoLOIQGpKPL1F3xKACDWYeLFQEDQ7zfVjhXHk1p7zgnHoDr0onJJxwD89V50GZJYKokYmputO4rDtYWTW4A9+UcNR3b9As2q5f5iZ0w3yNbtD5qHpwQE5H9knQoe1PKq3n5eG+joDbyAwu3lQ2+YTxgZ9WsEt7rxRfw80BGzkI88HnUrtboUuIxA/x00E8QH7YcUC+XgS79Gm5PfPmUYj7kEJvzxgFJjx4oq0uPtFsL/QJt7aB1k+PXneWXmr27QeXYB75j1GqzEGdtVcnMJiJGmu6A8m9vqM80gcB9pPztr+6Df+SfT5pGk2O4+qglLTrQf8gQOiKT3iornl/mKak8eSKr9s9MXrRg7C2GShasAMjJ4Q8rsFH7R/WXbEkFDB1td/orzdZFi7q50+xUKodfueYZxplO6aRgTgwsKsl3r8j1VefEt/e3CicMUOoAk3JFGvLz4DzHcfP7Ygd4xEZ8cLhmjjDOJOepSk+FbIgID2JKn0ieHHFsZf3LPYNkzSlMD71larFdxEOmFXbbEN7xMc5fsMWOJgQKII5/Oxzw8WDCGsOZz2v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199021)(7696005)(71200400001)(83380400001)(38100700002)(33656002)(86362001)(38070700005)(55016003)(6506007)(186003)(26005)(9686003)(122000001)(5660300002)(54906003)(2906002)(478600001)(76116006)(110136005)(316002)(4326008)(52536014)(66446008)(66476007)(8676002)(66556008)(41300700001)(8936002)(66946007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmdsZmpmKzh3UkVVRXlack9kQklIM1o1MWsyRmE2UTAvc1llSjJ0MG9iRlpO?=
 =?utf-8?B?VmRYZVNKRzh2NCtObzVrUGZJQ2QyNHBVR3lVenRXQlg5Y1IzdFN1aE9zM2gv?=
 =?utf-8?B?c01aT1czbGN1YjhtZ25sWVNuMU1NT3VSQVpGTVc0TmhRL1lNdnlURjhiT1lu?=
 =?utf-8?B?b3A4bURJUXlSUjZCNnd3cEpQbDlRL1UxZnRScjdacEo4aC93aGNqcFRWdkV0?=
 =?utf-8?B?dDA3R3lFRTIzK0N1NGZNZlMyV3NtNnAvODJ3UXZhZTVZUFJ5dHZFZHV6a29h?=
 =?utf-8?B?WnhuQXNaSGxqa2R6cnJsTmkxblByZVEwUVV5OUFLbzY4TVNERUV6NTBCVlZO?=
 =?utf-8?B?Y3ozZGJuaXJaZWdXMUFNdVBzOEZKL3RBNHpzK1dVMWU1WHRHOGdBcEx3bjF2?=
 =?utf-8?B?VDByVjY5RWN1eVJyZzdFWTVob1NvR3RLTFF5VmUyOGhuaHBDQlJpemJ4UHR5?=
 =?utf-8?B?a0FSVjhnQW05OFg3YzFBZFJXZVVSK0JwVnN4YVQ5dmhMWUpRb0g5ZGt4SmdR?=
 =?utf-8?B?WG13dXBoYjhlTlYwRGs5bmRHS2pvdkJ6anpDNHVERnlFMGx6VkJBd2FQS0ZG?=
 =?utf-8?B?SG9RMTl0OFkyM1BCaDRlbEFjOUgrZUFtamJIUlUwZmxEMjJhWGo3MzR3aHJ5?=
 =?utf-8?B?bnZjTERjWUZaZ2pIdzZ1Yk1xYzVjS1JRSXU0clRhN0NYL1hsZVdCVzhJL3Fx?=
 =?utf-8?B?Q2JmSXMrTkkwdEVRR0k0L09ndmF5NUpDUEdicm9hV1dxYnIwbnh0Q1hLWkR4?=
 =?utf-8?B?aWxrN3lYdnV6SGw1Z0tCOHFXNTN3endrTWVPN0lCK0FiZlRDRlJ1Vkh2ZGlt?=
 =?utf-8?B?aHdNY3hsS0J6VldnS3BlR2tiL3lBMnNjODY4YmkrVk5naDZ3d3NFWXJsS25y?=
 =?utf-8?B?RVVuaEp0RmVBQkovN2kxd1B6dXRBbEpWNm1HYkhDbDFicng1VXh1M1pBTW9R?=
 =?utf-8?B?WUcvYzNUK1ppV0xQejRCL2c1aFpRSTJIenNsU2cvTmJkeUhySVp0a0VqU0ZU?=
 =?utf-8?B?dEY3R2VnWUN4aWFnSm44UlIxVkNpVGplL0M1VDNSTStRV3kxSTBBQVV5Zkd3?=
 =?utf-8?B?eE5HeFNkbjVwNlZxRmZLMlhFZG5WM25sTlA1VUFHeHNndVpZMDhvYlI2OVZV?=
 =?utf-8?B?UmxoQkpSQlNwc2IwamYwV3lGQ0NhUkloQXN0T01QNlRoRnlvTGxacTROWlNZ?=
 =?utf-8?B?U1lrS05FMHBqWDZxUU02dmlrZzlCaVZYUjVud0lmVkVuRjFDZklOeG9ydFZ1?=
 =?utf-8?B?NzRVUUFrQldQYTVldGlHTTZ3ajJ0NHhNUGJQOXhybHFhMisyc01Ic3krVmY3?=
 =?utf-8?B?dENhWmdMT3RWTXNFR21ocXJlRUR3MUVwM2hUOUVnaGQxSmR0Wm4xM3lRNzBO?=
 =?utf-8?B?UUZ3TUtFSGplYUMwNXBMbFBiQW54M1VJS2VUUkRNclBwY1NkQ0NhTmJhUHBT?=
 =?utf-8?B?UWR2SkE4YnFEMTFuVEMvTmhPU2NUcm5hUkowbjg5bm5CZkgrNDRlTWs3UUZk?=
 =?utf-8?B?L0pLTlFLNG1yejlnMlZ4TytaMTdXaUxxTVR5SjJMN1N3dkhMSmFLNjYrUXBC?=
 =?utf-8?B?NlVEVXJjaXRONWl0TzQvQ0xqMlphZHBrZHhZazZQWE1vWTg5QUJFcFdJekYv?=
 =?utf-8?B?MVo0UlN4NExGQW9PNm5oMm9BeU9WZHh1MFFKdlJQZVhQVGF0eWw1UmMzSmsw?=
 =?utf-8?B?K2NPMmx6MkJTS0dYM203Yys2VDhhZlBJVkhFYmZURjlxZndQMGNMNW5VNU5J?=
 =?utf-8?B?V2xnNDVudDFqQ0FiRSs3VkdBVXZZbkcreU8yQ3R1QytKNEU5VG1RT0o0S21W?=
 =?utf-8?B?SGo3VTlBRnc0ckU4cCtmZ29XeUtSZFZERnkvNUVPc3R6OHRxWlJPNVU5YTZ0?=
 =?utf-8?B?K29OdXdWYUxadTN0c0xDNFdDTk5nZzhPVWxNRnkzR0g3WHZQeXh6T2RxdmhF?=
 =?utf-8?B?QVA1T0lrM2c2dWVCQ2hBNkhkVUFYRzFUMFMwQ1AyTUQybGpRa3ZSaHdtQWRx?=
 =?utf-8?B?N25HaVg1eTArVVpwQjJLRlcyVzFsSzhPRHNYZ3c5eFE2U3pSaVBEUk16NHM0?=
 =?utf-8?B?Nk1xQ29QOG5NakNzL0JoVWM2UklnR1QrSnZsd0VPU3NacmJPSGNQUjVHZUIv?=
 =?utf-8?B?bkFiWGYrMEF5Zi83a3I2Sm5ZaDZKWkJlRFhmQ25oK3BZQzBBdUtpMk5xR3dw?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f824e8a-54d9-4f10-e23c-08db52e2451e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 12:13:17.8602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pgp5Bef+ild6cSrkr3+flMUNWtV4hh4VkPeeV5ZjtkPb9K2EyUJIXlGXw6a9rn8yhHFuvOjnAssdtXxsZuN8EOTehgO+WrJu+d6gJt46krlBZ91c2zg+qR4WtXV7dOZi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gV29sZnJhbS1zYW4sDQoNCj4gRnJvbTogV29sZnJhbSBTYW5nLCBTZW50OiBGcmlkYXks
IE1heSAxMiwgMjAyMyA0OjIyIEFNDQo+IA0KPiBSLUNhciBHZW40IGhhcyB0aGUgZnVzZSByZWdp
c3RlcnMgYXQgZGlmZmVyZW50IGxvY2F0aW9ucyBhbmQgd2l0aA0KPiBkaWZmZXJlbnQgbmFtZXMs
IGJ1dCB3aXRoIHRoZSBzYW1lIHB1cnBvc2UuIFNvLCBmaXJzdCByZWZhY3RvciBJUCBjb3JlDQo+
IGRpZmZlcmVuY2VzIGludG8gYSAnaW5mbycgc3RydWN0LCB0aGVuIGFkZCB0aGUgZnVzZV9yZWFk
IGNhbGxiYWNrIHRvIGl0Lg0KPiANCj4gQ2hhbmdlcyBzaW5jZSBSRlQgdjI6DQo+ICogSW4gcGF0
Y2ggMywgSSBtaXhlZCB1cCB0aGUgUFRBVCBhbmQgVEhDT0RFIHJlZ2lzdGVycy4gRml4ZWQgbm93
Lg0KPiAgIChUaGFua3MsIFNoaW1vZGEtc2FuISkNCj4gKiBwYXRjaGVzIGFyZSByZWJhc2VkIHRv
IDYuNC1yYzENCj4gDQo+IFRoZXkgaGF2ZSBiZWVuIHRlc3RlZCBvbiBSLUNhciBIMyBFUzIuMCBh
bmQgTTMtTiBhZ2FpbnN0IHJlZ3Jlc3Npb25zLg0KPiBBY3R1YWwgdGVzdGluZyBvZiB0aGUgbmV3
IGZ1c2VzIG9uIEdlbjQgc3RpbGwgbmVlZHMgdG8gYmUgZG9uZSBiZWNhdXNlIEkNCj4gZG9uJ3Qg
aGF2ZSBhY2Nlc3MgdG8gc3VjaCBIVy4NCj4gDQo+IEBTaGltb2RhLXNhbjogbWF5YmUgdGhlIEJT
UCB0ZWFtIG9yIFRlc3QgdGVhbSBjYW4gdGVzdCB0aGVzZSBwYXRjaGVzPw0KPiBBIGJyYW5jaCBm
b3IgdGVzdGluZyBjYW4gYmUgZm91bmQgaGVyZToNCj4gZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L3dzYS9saW51eC5naXQgcmVuZXNhcy9mb3ItdGhlcm1hbA0K
PiANCj4gTG9va2luZyBmb3J3YXJkIHRvIG90aGVyIHJldmlldyBjb21tZW50cywgdG9vLCBvZiBj
b3Vyc2UuDQoNClRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoZXMhDQpJIGNoZWNrZWQgdGhlIHBhdGNo
ZXMuIFNvOg0KDQpSZXZpZXdlZC1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGlt
b2RhLnVoQHJlbmVzYXMuY29tPg0KDQpBbmQsIEkgdGVzdGVkIG9uIFItQ2FyIEgzIEVTMy4wIGFu
ZCBSLUNhciBTNCBhbmQgaXQgd29ya2VkLiBTbywNCg0KVGVzdGVkLWJ5OiBZb3NoaWhpcm8gU2hp
bW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQoNCkJlc3QgcmVnYXJkcywN
Cllvc2hpaGlybyBTaGltb2RhDQoNCj4gSGFwcHkgaGFja2luZywNCj4gDQo+ICAgIFdvbGZyYW0N
Cj4gDQo+IA0KPiBXb2xmcmFtIFNhbmcgKDMpOg0KPiAgIGRyaXZlcnMvdGhlcm1hbC9yY2FyX2dl
bjNfdGhlcm1hbDogaW50cm9kdWNlICdpbmZvJyBzdHJ1Y3R1cmUNCj4gICBkcml2ZXJzL3RoZXJt
YWwvcmNhcl9nZW4zX3RoZXJtYWw6IHJlZmFjdG9yIHJlYWRpbmcgZnVzZXMgaW50bw0KPiAgICAg
c2VwcmFyYXRlIGZ1bmN0aW9uDQo+ICAgZHJpdmVycy90aGVybWFsL3JjYXJfZ2VuM190aGVybWFs
OiBhZGQgcmVhZGluZyBmdXNlcyBmb3IgR2VuNA0KPiANCj4gIGRyaXZlcnMvdGhlcm1hbC9yY2Fy
X2dlbjNfdGhlcm1hbC5jIHwgMTQxICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxMDIgaW5zZXJ0aW9ucygrKSwgMzkgZGVsZXRpb25zKC0pDQo+IA0KPiAt
LQ0KPiAyLjM1LjENCg0K
