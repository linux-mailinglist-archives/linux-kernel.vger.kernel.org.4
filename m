Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BD069EBF1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 01:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjBVA1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 19:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBVA13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 19:27:29 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADDA1B5;
        Tue, 21 Feb 2023 16:27:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGvaxQc8XXjcL+MKaOPYN/JqFquqCtv4tUczqQeeH1flwslpBjNNL6n5QB7AwhZWoVouMPlww1/x5fhkqvpPG1xOsz258k5QWwk/SjF8Zj9yo7BdZV566NAvT4/gs6CbPbrLRRhcZQF+A6+27R4w4umPnedpqAzfI9jFTsqdMryLE6Tyt6WkdcZHVnXpEQxotXlzwnn34f9NtF4ju78jkmmIJuDmPGvV65VS/WFxWo6eHNgL/T0juGRJuKMQeahz9VkjyWX1P0jsGuiwYO7QGs5KNJEcvY9vskrCTzQjs5wExeIIUb7WCU9TOwMuby3pzo/zzQN46pwx0qV7n87A7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYYtow5EiSL1LDfnW8HcgBVbmzo8QB4knVRwC192j5c=;
 b=Or3LoM2f7uRSxBu9pj/0GVSfq8TqDr0oT6mGcuAtRUQeQvDu9rfoFhBbyzTde1/MYkxUhSC2+BnCfFh6HO6r7j0yTaJxuyPaU6gT91QKIFPbdHA6/NxMfUphM4ESWqDMfPDrq6zT0sl5GCj1XM4zIF8NQFDoC+jwN2I7Q4EPyyEaIOg/NE0eMO2KbbM7aytwtfOothro02EmnaszAQksWqZzxUDxbrttwccrfi0Cqv96fwzbio3ckrGSxMMck15oVyJlXigxXDEp9cGXE8I3kxYQN7XiH3U75m4X3p4DekAjgLy6LGZm9Z8oP3GDDK/VZzyfKc69StOT0EMgUak06w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYYtow5EiSL1LDfnW8HcgBVbmzo8QB4knVRwC192j5c=;
 b=dupY1iRbDUtCnXhFEeEp7Q+G86hNlgY1laOtyzcEZcOy7BbngyAjBTsuCd9oJJh5qPjI9VLf0TjHMxmR4PqRynqbxdHrECB0aLbsF0MAvCCkdGLcjkf1TpxH4DvDSnfBkjP09BO1AAjQon9sL30RkYff5peP7RejB7ZM90P2VnI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8631.eurprd04.prod.outlook.com (2603:10a6:10:2de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 00:27:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6111.019; Wed, 22 Feb 2023
 00:27:25 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Xu Yang <xu.yang_2@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH 2/2] dt-bindings: usb: usbmisc-imx: add i.MX8MM usbmisc
Thread-Topic: [PATCH 2/2] dt-bindings: usb: usbmisc-imx: add i.MX8MM usbmisc
Thread-Index: AQHZFnvkbVA7eIUDvEOOMY6gPO+/wK7Z1qoAgACkitA=
Date:   Wed, 22 Feb 2023 00:27:25 +0000
Message-ID: <DU0PR04MB9417BFF5F785C1C77904572388AA9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221223031012.92932-1-peng.fan@oss.nxp.com>
 <20221223031012.92932-2-peng.fan@oss.nxp.com>
 <CAL_JsqLW_YxC+S5Tp-gveHQpksKfzmrpEFXtcdLJ3xMJoX4+qw@mail.gmail.com>
In-Reply-To: <CAL_JsqLW_YxC+S5Tp-gveHQpksKfzmrpEFXtcdLJ3xMJoX4+qw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU2PR04MB8631:EE_
x-ms-office365-filtering-correlation-id: 2d230972-c5b5-46e6-3a1e-08db146b928f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DlzRJshkHooFbRlS/bhjY+ZgRKwY6nQafFzA+mCPldLve4wKUhNzb9Rnh6/5hK9rHca+CqQ/koDG15JRoJMlEjRRiTlQq8wDzjozLP4/tM92hQl38wnbFBw9vnwEbrovmx5Xn2z6Me0f8Cr9tGlvh712mT0GZJISMYyjnS32ip3clLEE2CwzhRvl25SWUHp1SzoXZgwgLymT+wCsotvm1CVGO22uGdMZD9pYt1iqSzeB091+amMZtZ+yOZ1sDyqTaiBEWTh/mKWeSxqqpMhruVCEz5eRh9C0Cy1cICQch0zxyA7EGZtcjDQPYwAPKY73T1XuIbEfDW6RXEZ/QkikU+nUpWuPrkVXoiKs+oQ5MZJnhOMcDLGtz3ngVqEMJ/rSPLHXXdK8ggMuKE3nzISuIh2icW9Roh26MjGZz3txip9ySB56bK+Jz0JhA2CVF14YwKWySDV11UlCPHYjx2Uc2n3czOHXnnknKYWM6rvwoIfXBR0q+Fu3cl8PAySvf9j+9LG/ALFtNglst6AOWen9wjl5eds+QfiZqXUwV2XvuiwSmKEd1pkPk1etCUU55ci1FbsMuoSEEtZB3QnLMqCiC05PQbx3qGzYb6zFXeRzeKFNmEGJULrA0DpB06dmeq4TjC+KE5rnv3DftaVSleKrIz/tYDz1+9OEviTU7JM1rzZiV70kMy1ZyYK/a9ujRZ/hEqzwClNKgyLVF7p3dV9cxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199018)(122000001)(38100700002)(2906002)(52536014)(8936002)(44832011)(4744005)(5660300002)(7416002)(54906003)(9686003)(26005)(33656002)(186003)(83380400001)(41300700001)(64756008)(66556008)(66946007)(4326008)(66446008)(8676002)(76116006)(66476007)(55016003)(53546011)(7696005)(6506007)(478600001)(86362001)(110136005)(316002)(38070700005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEFZbWRPVVVtZnlhZU4rNEplSkZSck5MWmIwb2dDTWhaRS9abUJFKzB4OWhS?=
 =?utf-8?B?UHhVMWtlcml1TkliME9VVEJIQy9pamxWUDlWc1MxeGZFeUlOZ2U0QVlzaFJF?=
 =?utf-8?B?NVhETlI1RGljTS9BUmNWdFN0dDEvUEtMa24rMkZVNW5OZXpFQ2tIZDNYa1ZN?=
 =?utf-8?B?S1YwbFFDN0hRVEZldXZUck9ORk5jODJVckxjT2VLM1Z3NW1iSkhVUm1uSEhO?=
 =?utf-8?B?SHNQSTkzTFBkTmo3TnhzMzZSVG9FQ3BlNVd2VTVCdDUwUDRNQlJNUEZwSEZX?=
 =?utf-8?B?dG92WTU1d1ZDMzg1VjE4WitRcHRpRXoyWmFVbUdkVGUxdWczY1YrWTUwVExp?=
 =?utf-8?B?ZTN6YjRKQUdzR2ZJeVJ0YVo5UTcvb1FZZFd6QjB1V04zNytJaVllSXQzNXN0?=
 =?utf-8?B?Yk1RWWNmL05nUHNnNklpQjBOVk9uMnUwOHFNKzdBWHhaRVNpS1VkbEpVK21N?=
 =?utf-8?B?Q1JSRm1nU09JSy9oS2x3YXpqOVRrb0lwR1hYdGRHcGVkblkzbk43ZlVFdjU2?=
 =?utf-8?B?NGpFYlpINER5WUltVmZVdTgrM1B1VEF2TWIyUVhqOEkwNzc1MktmOFptdWQ0?=
 =?utf-8?B?cUtMakZEZnJjTkxQcWkxZUF6cjR3OXIwLzJRK0FGNnhRTThqME5TRVR3dFF4?=
 =?utf-8?B?SktUY2ZyU2RXUVVvcFNYbmRDMVV3WnRBbGs1UHhtdmFLQkpiZzkxV1dLYzZQ?=
 =?utf-8?B?TUJCODVVN25JMnZydUwycFNhNFRXRGdoaWpLa0h4a2Flc0NqRzhCekZEb0hZ?=
 =?utf-8?B?a2hnWDN0cFZVU2pnY0UwdERJWitaUE8rV1JiQmU3dTVIOW0rWTg3MmN2UFBR?=
 =?utf-8?B?cmtzZllRMEpmRzkxLzJ6T0NWNDc5dXNUUml0MzVTUHpSL3FUS05JenR1Ukhm?=
 =?utf-8?B?cjhIOXJ0dS9zVUhBRUpWR3ZoOGJPVU1tQ1R3dU55ODNkL3JMOFdtWkRWZXNw?=
 =?utf-8?B?YTA1R2dFMW9MQ0JSbFM2YVBIM2Q4dEs0MFYxZ2hoc0FDbm9HbGQ1VUxkUXlu?=
 =?utf-8?B?blNHbE1GWXVtQ2x2ZnBCSW9mdXRmYVhDT2d1RjQzOHJiMjhtN21zdHBwMVls?=
 =?utf-8?B?RUxaM1lmUW9zT3pvOWEwcjRUTzlabDFONDNRSk9pVEhEbXp4UWpWYVliRXVk?=
 =?utf-8?B?SjR3aHZEc2dzb1JVZDQyMVFVMHF3OWJjUVkxM3F6V2FPSmhvaWFXUWlFRU9w?=
 =?utf-8?B?SWlEL2xJbkZLR1RWcytsVHRDOEtZdHJybVMwdmRnbXJpemRiTXZnTDdUbHk1?=
 =?utf-8?B?Wnd2Z3g0RzFlLyszZWFmbXVYQUhrSUVUOGhuSEVjQXlJbmY2N21JVzJ3NXNL?=
 =?utf-8?B?dUtkQVRGL2VvTnhJVEY0amx4Qmt1RmtMcUkvWWNIRm44RlBsRjdkY1ZxTkt4?=
 =?utf-8?B?UFdkY21qVXo1REFUdVR3WjNzMXd3NFQwZjdNYnlBUXNGWkNuZmtiYnRyakFZ?=
 =?utf-8?B?V1Npckp1Y0JleElYSFZsdW9PYWRFMmdaa1Vrd3M2WGRqVGZiNkRCU1YzNFUx?=
 =?utf-8?B?M3NGaldVeEx5YTRlMXh3WlI0RWl6K25Uamx0cFYweU91R1Rtc1pvSlFYazVL?=
 =?utf-8?B?RXpIeDhqLzN5QWJ1cVhsUVRZRDhRNXpiRnVZTGp4d2phR2lHRjl5OUJaTUZO?=
 =?utf-8?B?QVFsYThhUVBCU2NTWm9nQmMzU0Z5QnVWR2E5bE11N1dTTVdOT01EZmJ6RWJL?=
 =?utf-8?B?VWlrRmxiMmlNeWJGVUtQVzNNRHR0MERtSmV1MFh4M1liQ2t1WHd5QVhVNVh6?=
 =?utf-8?B?WXVUb1FWbExINStibE8zK1BCUk80T2xzVFJqWk5HblJSdWRjSjlaK1lTOXZr?=
 =?utf-8?B?ZE9Fd2FKdU1MZ0dnSFpKeS85c2pRSFRBQTBPUXpwMEJ5eERIZ3pqUW8vQUx5?=
 =?utf-8?B?NXdFeWZHb0xidktQWm45ekxGZHRhNVh0WERqSUtoTS9pU2hoclJuK2hHTDU2?=
 =?utf-8?B?RnlRUmJHbG4zM09EZTRJd1BvSy92VnhXVm1lTWlnR2twRU9SYVppSm1xbTcw?=
 =?utf-8?B?a2lpcjJYRFIzRTdpQ3lJbkxXZlVpUCtrcW9GaGllbmQvNThDTXFnODJSbWp1?=
 =?utf-8?B?c25ZcHVkajZLeW41SWRKZlZXRzZORDVobmR3bm8rUlJJWHV0cXU2a0U1L0gr?=
 =?utf-8?Q?BYq8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d230972-c5b5-46e6-3a1e-08db146b928f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 00:27:25.5817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xg7fZRg2mbBaXZyw+o6yIm/1/9yWudkN+vb7Mj4RMU//N//Y+e5UiT5h2OBnFWyLxbZ52JysuulOW1dF8yNhWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8631
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBkdC1iaW5kaW5nczogdXNiOiB1
c2JtaXNjLWlteDogYWRkIGkuTVg4TU0NCj4gdXNibWlzYw0KPiANCj4gT24gVGh1LCBEZWMgMjIs
IDIwMjIgYXQgOTowOSBQTSBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+
IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4N
Cj4gPiBBZGQgZnNsLGlteDhtbS11c2JtaXNjIGNvbXBhdGlibGUgZm9yIGkuTVg4TU0NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IC0tLQ0K
PiA+DQo+ID4gSSBoYWQgYSBWNCBwYXRjaHNldCB0byBjb252ZXJ0IHRoZSBiaW5kaW5nIHRvIGR0
IHNjaGVtYSwgYnV0IHdlIGFyZSBpbg0KPiA+IHRoZSBwcm9jZXNzIG9mIEFSTSBTeXN0ZW0tUmVh
ZHkgMi4wIGNlcnRpZmljYXRpb24sIGRpcmVjdGx5IHVwZGF0ZQ0KPiA+IHRoaXMgYmluZGluZyBk
b2MgaXMgdGhlIGVhc2llc3Qgd2F5IGZvciBub3cuDQo+IA0KPiBUaGVyZSdzIGJlZW4gc29tZSBt
aXN1bmRlcnN0YW5kaW5nICh3aXRoaW4gQXJtKSwgYnV0IHRoaXMgaXMgbm90IHN1ZmZpY2llbnQN
Cj4gZm9yIGNlcnRpZmljYXRpb24uIA0KDQpZb3UgbWVhbiBTUi1JUiAyLjAgcmVxdWlyZXMgc2No
ZW1hIGJpbmRpbmcgZG9jPw0KDQpUaGVyZSBtdXN0IGJlIGEgc2NoZW1hLiBCZXNpZGVzLCB5b3Un
dmUgYWxyZWFkeSBkb25lIHRoZQ0KPiB3b3JrIHRvIGNvbnZlcnQgYW5kIHNwZW50IG1haW50YWlu
ZXJzIHRpbWUgdG8gcmV2aWV3IHRoaXMuIFNvIGNhbiB5b3UNCj4gcGxlYXNlIHJlcG9zdCB0aGUg
Y29udmVyc2lvbnMuDQoNCm9rLCBJIHdpbGwgcGljayB1cCB0aGUgdjQgYW5kIHByZXBhcmUgdjUu
DQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IFJvYg0K
