Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F82A716283
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjE3Nrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjE3Nrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:47:33 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2100.outbound.protection.outlook.com [40.107.113.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283EDE42;
        Tue, 30 May 2023 06:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KV/IZFaXTytcftXL91Vf9IHWFrHyKjUpUoex41/r4verLd+Zse6O5I+8z1VMBxmlgm/jMZTUrx8nCfgsS9aekpJZbgd7xIZWlh7e0iutIdLIDNi3unh6RwpGQlzWU+VTKafH8w2ZfCdhN11Y8faTz9dyAyIj1f5AjGFwpU3YeU9JnCSYktDBqEpJwVJn+rJuFIt/+pEY63MVSQrfqRBmyaMunjQbJdGvbAAzgyRylbD9TL3unybHrVgwylGup5uFDLIRvpf8QcKCxpSnQqfYe3ACbTjZNS5cz9Tmj63b5CnaM66K3tgu1xPajMFkmWgdT5T6dmWuzAqvaPxE7664wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zINllwjL4cpC5VWo4251kHllA+kkuI/6c8+XdntqnjA=;
 b=iTZPNTES++ohcSFBkw63APvHHf0JUGigVTx2ZAmhliFparECsTb3kYWp+XOdtSymWDQh0CgL4d9d7i7tCuKetwsoXZZwvZSEC1JiX1L+nnky7+AOxx04cJ2vwWKc3BllaTHM+KG5zdcpon6tPnkcLcduXqu725peQ1EHEQ+hkTHKS+aWXMQ9RtefulA41KmyN3x/jm2LqmorzOkIgPDBvnNh1KkEGz577h3gjv5hSPq8FdLKeVNUyPuUmxyQFKcovHLFuQ2UrmjK7Yg/o4pk3/ZQkbrICNNxK8uG/mryyFSrZtncvh2ywJSmGmjrZopJCwHNLGXAFu0BwZ5FODtwrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zINllwjL4cpC5VWo4251kHllA+kkuI/6c8+XdntqnjA=;
 b=pUcdgp68m7iCrIkHLUmIE4PLO1n1ADMk0/yYtJMGomcsLqTUQE/YBklr+cuMRRd0xQVuvUOJVnJJtvuyqhCWEWHPsrEf48wf92/VUjBDjipGTBLtqqVXbBDRYQoAt+4uEqwJxT6ShDXVxmc/V8P/OcHwLZoXBqI/HKQiNpU8o70=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB6189.jpnprd01.prod.outlook.com (2603:1096:400:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 13:47:12 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.020; Tue, 30 May 2023
 13:47:11 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Marc Zyngier <maz@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zheng Wang <zyytlz.wz@163.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
Thread-Topic: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
Thread-Index: AQHZj99wvrGBFYOn5Ea9mIuOTwGccK9wyqwAgAAi9sCAAAmpAIAABFqAgAF9FPCAAFmOAIAABUHA
Date:   Tue, 30 May 2023 13:47:11 +0000
Message-ID: <OS0PR01MB5922A75B0911A11A83029A72864B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230526143615.372338-1-biju.das.jz@bp.renesas.com>
 <20230529061714.GA25984@pendragon.ideasonboard.com>
 <OS0PR01MB592296756992262EC6D382D0864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20230529085656.GL25984@pendragon.ideasonboard.com>
 <86a5xncxhc.wl-maz@kernel.org>
 <OS0PR01MB59227AF1F83A73620179CDF8864B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdXnF87BqcxESzOjB9hSMZ0HSnqzRNXEvCXGczDj+4yPjw@mail.gmail.com>
In-Reply-To: <CAMuHMdXnF87BqcxESzOjB9hSMZ0HSnqzRNXEvCXGczDj+4yPjw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB6189:EE_
x-ms-office365-filtering-correlation-id: e4dd03da-7854-4b7f-c225-08db61145eb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cD4/dc7ak7JmBU6xJx9GfWB/rGvglZy6AcprCOMoYoB+h5c36nN4ebkR3OGMHvBffYnwTZCHgcsGyMaLQfJDuWC/elbKUQ3P3CMBYIYw8gWPLPw/z9bTUwEHydaDKq9W/mo7/koLqWu9N3FtVly9/PoFWxW9RALRV3dkByAuCXL7W15aSqChD49XgGBt6y8kt+/ZW7ZS0RkB/Bx9g4eNC1UTmqc3oGTqWvCdt8V6ABVWEpovmm/QuK/IHDZZe+Tal6IT4XH0LwOOEdR+TOa4kXCbS1CTg98zCiuAWqT+e2idDsdCj1fMcPt9cSFRvolkDsEgYKaYn/+etQ6qxvm8XIXmpuOdONfDoegXjgBjjyzCG+h4UdK3n6YgxwDlhMjdpSKOCQzORgS7gKFr5pwi7zXfTS8HvYN8NVLaJFi93HLdML45QHlu7VRiNKQowAN7kvARRF3F0N0vtp+ywAh0a3y8HnoK0SUbiQIofwAk3jh85m7b2/oLzP3mTwOGOKxzQCwyLGi71hWLI/I3xb4J+nIz+GqYAr2cJBGQghTJlj1j+FpSrtQ2I2AnIKJ5hn5ccM5xW3TGyUqdx99V9wV3ecgBYnFDqhOpWngaxZ1ODjsFp5RvhRgTx+uVj+NnEcJ4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(66946007)(7416002)(76116006)(4326008)(66446008)(64756008)(6916009)(66556008)(66476007)(83380400001)(52536014)(5660300002)(86362001)(41300700001)(38100700002)(186003)(7696005)(8676002)(8936002)(2906002)(122000001)(38070700005)(55016003)(71200400001)(6506007)(316002)(26005)(53546011)(33656002)(478600001)(54906003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFBaWTdqcytwU3d0M3hMcEM4U0IwemsvU2Vrdm8xSW9BbFBWbnFSLzg1M1BI?=
 =?utf-8?B?aUZYbndIWkFBTmI4QllkcDdrZXJtNWZHNENMa0ZmUCtFZlF3anBxQnoxSkV3?=
 =?utf-8?B?TDg3ckhWUWo5UGVDRmxsQTRlME56RTZPM09QSjBBRUFUL0RudW9lZis1bWdx?=
 =?utf-8?B?UXB5T3VHZElXcTA3UDM5eVl1QjZUYlFLNjdYRjAzUjRDSnRKc3ZHc2Z1dWZx?=
 =?utf-8?B?R1lBeEdwZjhNZEtxai9aZlFLUVQyV0V1QU5QbGVURVFHZjhrSWdpU1ZDaUor?=
 =?utf-8?B?emd6S1pMaHpUdjhHdElQa2ZHMitQQ25vZXpaZ3ZJdmFYQnp5SGZ2QnVkTDBx?=
 =?utf-8?B?dC95U0FBODl5MVRYQVA5KzZ0Z3kvUFRjMHhKQzhkN2k5dTlWMkpFUm8zL1pO?=
 =?utf-8?B?MUJ3S25WWmk2UE5jV21nMEtORlRJdG1zYUJqbzNiMHZFVnlSZ0IrRU5vTzk3?=
 =?utf-8?B?VTJzc1lLZnhYOTExWDBXcUlhMWQ3Q1ozekU4ZnUzVnp6aC9KeUp1NVJFay9E?=
 =?utf-8?B?TDZkV3QyQWFwcmJMR3A0dGdFS0tTZmlQWjJaOXhxMDltcWkrelZKSVVzR09C?=
 =?utf-8?B?ZXJCUnYzQkE5UDFhajlIL0MzcnNncFhCaWpHYWlQdW9hdzJKcVF3anR5bnU2?=
 =?utf-8?B?NmQrQ0VmT2N2WW93Tk9zVkNWKzBhcml5eHF1ZlpNWWNjME42R1EyRGFzSTBx?=
 =?utf-8?B?YVFGN3VYR2RlZ1lHdS8wWC9Ba0JxSFc3aGlkYkprNlp3Zm8reHFUL1J6Qmsx?=
 =?utf-8?B?R3NNYjlhaGRHT0Z6Yy9CZm1aMlN6aE9MZExBSzFwekhudGJTL2RBOHBDZUpv?=
 =?utf-8?B?Z1lxZWREcjJYNUw2Rk9yc0xmakdMNy9YQ1BjTWZUcWsrZTRnWm8zWWJpNnZW?=
 =?utf-8?B?VGdzY1VkR0tmU3FMUHZlSmZxeGFNV0F3R05qZVpOTDFYZkpqTjFnczQwWSth?=
 =?utf-8?B?bXdJQnNFL2J1WDg3R25mcHdEbCtpbk0waGRLVlVRS0pFcFFVT1RDQnErZTNH?=
 =?utf-8?B?dDQ3diswcVlPREZONFFSMXJnZnNDenY1MlVjRWk1bVJzMGdVdjJLTFFIMk9t?=
 =?utf-8?B?YkFRRldYcmxRbHFGa0t2WXlrQzB3bklQMHpVT3ZEL0FrLzZYWkZHNmJIcVRX?=
 =?utf-8?B?NURpekdjaEFqb2gwOUF5Rk4wZklTdi8zSERLenA5aEQ3RjVpaVpnNjA2L2JN?=
 =?utf-8?B?ZVBpZUE0Z3llZGRGRXZtVXlnUXpIQThvbUNQVENURUJBeVpQcmVCai85dnpJ?=
 =?utf-8?B?OFkyZUxvdllkZFdFMFlZVjhKelB2V2tyS2Y3UEI2YmZ4SXBRdXVqelgxWWxJ?=
 =?utf-8?B?UVZvS2pnM2p6bFBwS0RRbHVrRHRwR3VncU11TGtvbFpJdlUvYTVCY0hiZzVK?=
 =?utf-8?B?cy9SamprK0dNTHhBcWJRdHFYZXVTV243WWViQ1dmVE9ZbnFKN0pRcUJCcHpN?=
 =?utf-8?B?WUU5MERzWTNNWlNTcWsxbm4yUVJYOWhwT09XRTJGOSt1enFqSzZ6N3NBWEdS?=
 =?utf-8?B?VERzelZRd3RHdFJSVFg0dWVMeDJhV1pzdTQ3THk4azJBR053ZHVWT3EzWXJh?=
 =?utf-8?B?N2NJcEtxb2NCR1dOQWltNmlBMHVYL1VoeloydkRLOFNzdjB1ZGNyUUM3djQx?=
 =?utf-8?B?UDYrY2o0bHJzYy9naDl4S3hZQ0RMa29vWkdNMGQ5cHg3N1RScnNva0NuRnJT?=
 =?utf-8?B?c241a25sYzdEK21ybi9FcWgwdXBaUGNqSG4yOGhKMSt5SzZMMTJJMHVvSzBZ?=
 =?utf-8?B?aGxBVzhIKzJIWjNSaWtFRVR3S1QrdzcvUHNhbm9NT2d4N1pLNFcwZDZ3Z3lz?=
 =?utf-8?B?TkVmOCtnbVEyMGJBRFBFT0lVT3VDWkZxNkJzQVRvSUJPVnl4ZFBVVitySURZ?=
 =?utf-8?B?WFpzWkU1Z1FuR1lZVjRwbHRzc09xcjBRUkJiT0dlSzdBNGQ0TmFiZW1BV3p6?=
 =?utf-8?B?ck1yaTJEaE1UVm9ZeDViVlhKZEZ6M1UzL0V3WE45bzhvZHoreWdYM1pWcDFK?=
 =?utf-8?B?dDQvSzgvRVJ1bTlDVEN2a0YvVTFwL2o3V3VRYzB4dG1PSjlyNkI5ZVFSczVB?=
 =?utf-8?B?S1FFR2NyNWFaaHUwWGJaOC9IOEgyR0RtRUYyNi9zMmZZY2VVUGl0N2FUUFNC?=
 =?utf-8?B?NHl5YXBvc09mK1pnUlhNZThya1Q2Qk9rSmVCRDJTUkE5T3NCcWlBSUVCVktS?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4dd03da-7854-4b7f-c225-08db61145eb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 13:47:11.9038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+oCaItO2E4iriIWGeS8gaLBMRRoe3VMR/nbjCLH2ofNSLxyn18mrczy1b/WypzpIIQo4p1SuMbvse+zED5r8xVrtOkxVwn1yPg0JAz7HRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6189
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAzMCwgMjAyMyAyOjE3IFBNDQo+IFRvOiBCaWp1
IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IENjOiBNYXJjIFp5bmdpZXIgPG1h
ekBrZXJuZWwub3JnPjsgTGF1cmVudCBQaW5jaGFydA0KPiA8bGF1cmVudC5waW5jaGFydEBpZGVh
c29uYm9hcmQuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgR3JlZw0KPiBLcm9h
aC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IFpoZW5nIFdhbmcNCj4gPHp5
eXRsei53ekAxNjMuY29tPjsgR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRl
ci5iZT47DQo+IFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2Fz
LmNvbT47IFdvbGZyYW0gU2FuZw0KPiA8d3NhK3JlbmVzYXNAc2FuZy1lbmdpbmVlcmluZy5jb20+
OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+
OyBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBQcmFiaGFrYXINCj4gTWFoYWRldiBMYWQgPHBy
YWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT47IGxpbnV4LXJlbmVzYXMtDQo+
IHNvY0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdXNiOiBnYWRnZXQ6
IHVkYzogcmVuZXNhc191c2IzOiBGaXggUlovVjJNDQo+IHttb2Rwcm9iZSxiaW5kfSBlcnJvcg0K
PiANCj4gSGkgQmlqdSwNCj4gDQo+IE9uIFR1ZSwgTWF5IDMwLCAyMDIzIGF0IDI6MzfigK9QTSBC
aWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IHdyb3RlOg0KPiA+ID4gU3Vi
amVjdDogUmU6IFtQQVRDSF0gdXNiOiBnYWRnZXQ6IHVkYzogcmVuZXNhc191c2IzOiBGaXggUlov
VjJNDQo+ID4gPiB7bW9kcHJvYmUsYmluZH0gZXJyb3INCj4gPiA+DQo+ID4gPiBPbiBNb24sIDI5
IE1heSAyMDIzIDA5OjU2OjU2ICswMTAwLA0KPiA+ID4gTGF1cmVudCBQaW5jaGFydCA8bGF1cmVu
dC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gVGhl
IG5hbWUgaXMganVzdCBpbmZvcm1hdGl2ZSBzbyBJIHN1cHBvc2UgaXQncyBvay4gSXQgbWFrZXMg
bWUNCj4gPiA+ID4gd29uZGVyLCB0aG91Z2gsIGlmIHRoZSB1c2IzZHJkIGRyaXZlciBzaG91bGRu
J3QgcmVnaXN0ZXIgdGhlDQo+ID4gPiA+IGludGVycnVwdCBoYW5kbGVyIGl0c2VsZi4NCj4gPiA+
DQo+ID4gPiBXZWxsLCBpdCByZWdpc3RlcnMgaXQgaXRzZWxmLCBidXQgcHJldGVuZGluZyB0byBi
ZSBhbm90aGVyIGRldmljZS4NCj4gPiA+IFdoaWNoIGlzIHdyb25nIG9uIG1hbnkgbGV2ZWxzLg0K
PiA+DQo+ID4gT0ssIFdpbGwgcmVnaXN0ZXIgdGhlIGhhbmRsZXIgaW4gdXNiM2RyZCBkcml2ZXIg
YW5kIGV4cG9zZQ0KPiA+IHJlZ2lzdGVyL3VucmVnaXN0ZXIgaGFuZGxlciBBUEkgd2l0aCBjYiBm
dW5jdGlvbiB0byBhdm9pZCBkdXBsaWNhdGlvbg0KPiBvZiB0aGUgY29kZSB3aXRoIHJlbmVzYXNf
dXNiMyBkcml2ZXIuDQo+ID4NCj4gPiBCYXNpY2FsbHksIHRoZXJlIHdpbGwgYmUgMiBleHBvcnRl
ZCBmdW5jdGlvbnMgKyAxIHNwaW5sb2NrIGludHJvZHVjZWQNCj4gPiBpbiB1c2IzZHJkIGRyaXZl
cg0KPiA+DQo+ID4gVVNCM0RSRCBkcml2ZXIgcmVnaXN0ZXIgdGhlIElSUSBoYW5kbGVyDQo+ID4N
Cj4gPiBQcm9iZS9yZW1vdmUgZnJvbSByZW5lc2FzX3VzYjMgZHJpdmVyIHJlZ2lzdGVyL3VucmVn
aXN0ZXIgdGhlIGNiDQo+ID4gZnVuY3Rpb24uIFdoZW5ldmVyIHRoZXJlIGlzIGRyZCBpcnEgY2Ig
ZnVuY3Rpb24gd2lsbCBiZSBjYWxsZWQuDQo+IA0KPiBQbGVhc2UgZG9uJ3QgbWFrZSBpdCBtb3Jl
IGNvbXBsaWNhdGVkOiBpZiB0aGUgcGFyZW50IGRldmljZSBkb2VzIG5vdCB1c2UNCj4gdGhhdCBp
bnRlcnJ1cHQsIHRoZXJlIGlzIG5vIG5lZWQgdG8gbW92ZSBpdHMgaGFuZGxpbmcgdG8gdGhlIHBh
cmVudA0KPiBkZXZpY2UgZHJpdmVyLg0KPiANCj4gWW91ciBwYXRjaCBsb29rcyBmaW5lIHRvIG1l
LCBqdXN0IHJlcGxhY2UgdGhlIHNlY29uZCBkZGF0YS0+ZGV2LCB0b28uDQoNCkFncmVlZCwgd2ls
bCByZXBsYWNlICJkZXZfbmFtZShkZGF0YS0+ZGV2KSItPmRldl9uYW1lKCZwZGV2LT5kZXYpLg0K
DQpXaXRoIEludGVycnVwdCBJRCAiMjc0IiB2cyAiMjc4Iiwgd2UgY2FuIGRpZmZlcmVudGlhdGUg
ImRyZCIgdnMgInBlcmkiIGludGVycnVwdC4NCg0Kcm9vdEByenYybTp+IyBjYXQgL3Byb2MvaW50
ZXJydXB0cyB8IGdyZXAgdXNiDQogMjI6ICAgICAgICAgIDAgICAgIEdJQ3YyIDI3NCBMZXZlbCAg
ICAgODUwNzAwMDAudXNiM3BlcmkNCiAyODogICAgICAgICAgMCAgICAgR0lDdjIgMjc4IExldmVs
ICAgICA4NTA3MDAwMC51c2IzcGVyaQ0KDQpDaGVlcnMsDQpCaWp1DQo=
