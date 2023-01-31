Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BD26825EA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjAaHxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjAaHxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:53:21 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758DA37F27;
        Mon, 30 Jan 2023 23:53:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhNMNJstx3CUphoDIe9XHIGyBmnNRJAaJ4VGOqf9B1fDqSpaEw+ylmpFyvBBNmtKnjQgEVfp9P5WmGI+wgadp+2iZ9NHDWa1hBjkQxjqaAzq6NQRW+0n/6IXKdr/jts+4PTnJ4ryLJkkQDtfpSFVJo1mA25Y00M4AR7EKKpeEjuPlgw7yLNaz3J1O6XldiCZro+1YFKb1ZtFrAof0ze53qmxUXeqO0+mL+pTNaRr+NhS/Rz8zVEamRApQusBZchASqf/RsaP583ZxQVap7r87X/FSxYeckgB/I1BCIZfe3iMtfDla7pbIqoBW7fOROef0EgG2VT3tXwEKZ5kBJ5kVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkW9eTp2FWuF1M8fJCfRw0MdRGjMnOOkVc6ognQ2Wi8=;
 b=S5SAGPf4EYcPVMPF8MzGwI8ePuTehl8CIJIqgId1mwQK/Dj/WATb08c//RdErTZJHEqxMfXy8Q39vi/KFvSYPWQIl5Gr5CYz1aUFQOcIgVjRelIzPTmKoPS3UGHowjC3jmX/dlR4LRLUsa+ch8wKFRtVdDuET7ot6eDnu36JrFimazKbkD8Ax/ng3ZBeUmEr4lefgMITEv6i8cSDCGbAms2qOfIVKLECu8cj2FzHnv5qLcULEgNHYiaBn9QusC2GjzVMlQiCKO9Ee1rJL/WTT/HFfcGP5owjijGpJtWqEWXumFVwLWwdqX1Tp1+Ptk1ddBolX98yjH8o9Kt0afGKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkW9eTp2FWuF1M8fJCfRw0MdRGjMnOOkVc6ognQ2Wi8=;
 b=Acj+qTcDC4oAdOz2OrxAiitoDK12K6hXAV5kjeHMxuLNGoBBjOZa6co3Vy76GIlDaJYB9oNFvNjjBzq0K4uSqk+8veM8fvCoQaI0sTvhHCsMRwrvZYJjOkoh3MuMqjT80sjz/xq5+8m4l1gh4H8a5/YIlzvn8owHfhgT/1lmWa8=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB7618.eurprd04.prod.outlook.com (2603:10a6:20b:2dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 07:53:14 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::4dcb:740c:bf92:954a]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::4dcb:740c:bf92:954a%9]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 07:53:14 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Peng Fan <peng.fan@nxp.com>, "marex@denx.de" <marex@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Frank Li <frank.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v7 2/5] dt-bindings: imx6q-pcie: Add schema for i.MX8M
 PCIe Endpoint modes
Thread-Topic: [PATCH v7 2/5] dt-bindings: imx6q-pcie: Add schema for i.MX8M
 PCIe Endpoint modes
Thread-Index: AQHZNF780K6c3/4exkuMP9SOmzlGt663i+cAgACVyCA=
Date:   Tue, 31 Jan 2023 07:53:14 +0000
Message-ID: <AS8PR04MB86766A39B64D9C4B8E6787DF8CD09@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1675049539-14976-1-git-send-email-hongxing.zhu@nxp.com>
 <1675049539-14976-3-git-send-email-hongxing.zhu@nxp.com>
 <20230130222932.GA3634639-robh@kernel.org>
In-Reply-To: <20230130222932.GA3634639-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM9PR04MB7618:EE_
x-ms-office365-filtering-correlation-id: 7fecb451-35fb-4bbd-3f7c-08db03603516
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jj39ynCVhqjjIK0n1yl+WYdsThvcbfLrqVfHgridtdHoe4jlDLPBccZgCxAlQnCyAOa60s4PEMFmSE2cpr40KoGWOAICR/4F9SCDsYFtu0bV2nuLVa/VFUxprxDuClu6BFbEi3Cqud8hopvCUM9tcfKZEPKt1100/DIOy3kFPvnhhQ2xtTrnknJkoDDKL3DhxNlYnCzTYrhkm0Q9B18suyPJ1UhbXRtLtOwzNRR7cpBB96Y5l/fV/2EI+5naY/jj5tTCJ8ABKP+qJmz/vWTY4Lh5zZp8VEK7dL72jqjpBO5DGScme8mebSgpJ/OcHi74YdMv6UtvUcHc7HSjdre0Jcp0i2fhE2Q2DqH+Ib0YExIviXWdSwfrQ9QJufsypMC7hDq2Wo+IqdYeTDGCpcKlqYnC3CTaVqSU4dk8+sSS9pBZmIGIRVQUfhS6ItZSuw/r9fcu4Oku5SEbSggn0Y765c23qQXQOt1Yt/xBlJmlFUXFXjwk64FXPJj03Gk9h/x+J91BQmxW4asgXktTx0ymM02aY5W8oeLE75pc15tQ1OkDDztvIEgimFCc3RVITvhgu29JEOd7q1Wjx/Si2BrQNicraPXgznxoQ4VmhkrHx7JDDs7vbhNHhMwaBvDuIYr77lniV8m7siu/0uDfj8EQHumPsDBG2hSXwnAArN8Kgxbyf3RJOu3eguzNUM1JLSXb/rX8mr3zxwPwB18T4dgEu2E5yKsOxkNP7gWvY7mU70k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199018)(316002)(66946007)(66556008)(76116006)(83380400001)(55016003)(86362001)(38070700005)(38100700002)(122000001)(54906003)(45080400002)(71200400001)(9686003)(26005)(186003)(7696005)(53546011)(6506007)(33656002)(478600001)(5660300002)(44832011)(52536014)(8936002)(7416002)(2906002)(41300700001)(66446008)(66476007)(64756008)(4326008)(6916009)(8676002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cXdsejBCc3Q3a0NUWFF5RVAxM1FUWkNaK0o5emxRSm02TjRBbTBNR1V5Tmc1?=
 =?gb2312?B?V01HdUI1Y0loaFVabm1zV3dLcllNZEpKKzYzT1JIam1Za1VEUndOOXh2Um5B?=
 =?gb2312?B?cW8wR3VVa2hTRC83TVRqUDV6Mkg2end1TWRXNzU0QUdvVlZONWo5YWhRVnli?=
 =?gb2312?B?RVpMQkVKVXVhQXBqcDIzVzBqbndIZVFjT2tKbEFTUnMyS3IxblZtdXJvSkFC?=
 =?gb2312?B?d2k5WlhPQVpYUHgvZktrVWlkYmVIZVl4Y05sMWc2L21Pem1Td2xNOHl3NmYx?=
 =?gb2312?B?bEF6eUxhR3VzTmJMYWxjMDFWWDEvN0V6cjd1M1dtc2xjblhtaTJuMHlyRmx5?=
 =?gb2312?B?R1Vib0pjQzVncW5FWWNXZzRJRDc0ZGZrUzlhWXpvMTFodFlUMEh6cEpCU3Br?=
 =?gb2312?B?eFovdUMrV1dicVJYVmdEck15eFpSa0F1MThxbUNsZ2xqM0dSd1JoQTNyVkNR?=
 =?gb2312?B?YmVsYjA3YmZIdStMY3RBYStXSlQvNmlTL2xXN21DK2pWd2orcm1PTVBTM1RF?=
 =?gb2312?B?ZjZJRDBjZU5IaWlLblhpQWFyZVVJc1ZoSFV3bnVqTFBCMDhVR2oyU2ZYWlB5?=
 =?gb2312?B?U2tNZUxlME5OZkZ5SEJaTmxnQk51elorYW5lck1BcVdOMW1EQ0dReDlCTlJi?=
 =?gb2312?B?Z2hmZU1VYzhYTVNOblZEU0g1NGxveVRleDZLNUw1VmNmSnB2Vi93RUZFQzdy?=
 =?gb2312?B?cEFyOXN2OER3dDFBSlZqNFFoZnlHb1VrSzg4amhrZ09tanZsWHh6VnkxWE1F?=
 =?gb2312?B?YUdyTE1seTdyZXUwT2hSeDRqMG5BcG5hY0JCWmhyOXVYVGpQZmdLWG1NV2hi?=
 =?gb2312?B?dHYyK3ErdXRyZHk5SHJYYnJOZW5iS3R3eGgrYnRlMXRpa083c3NDNm5OUWt6?=
 =?gb2312?B?WWdjRVRTSTNaQlhCNU15aHpyRG9XakQ1N3R6bThOQXdrZzhhRm80bDRObUJF?=
 =?gb2312?B?a2VtbUp4QkQ4S3pYRm43YUVBT2hFV28zUHdQaG9QbEtHTnJGeUVQNFE4dXVJ?=
 =?gb2312?B?emxrQnI1dE9yZk1sY3kxUHNhQkhBVDFBNW9KRkwzOHcvak5PeTljeUVlQWY5?=
 =?gb2312?B?WlNaN3pYeUJiMnB4d2o5eHRQSzBRUWR0YnEzdVo5blRZLzRmczNjc3ErUCt0?=
 =?gb2312?B?ZlRPd09BTVZORlR5b3FPOVY4QzgyVGVGVVRheEExbkxNTVJqUk9rQXl5N0du?=
 =?gb2312?B?cE8xNU82REZZSlZZUWZhaGZRNmJOYWxyR1F6cTlJMHluMzhzWWhEajlZS3pj?=
 =?gb2312?B?SFZtTDFub3lHS21DMWxmTStrOXJNNkJPNG11SUZWZHp0NmwwYjU3eVJrYTYz?=
 =?gb2312?B?UmJnNzA5YU00bEluRlovVVVTVHA1R3BsUkowbU5qM05mbW5BYU5WNElIdmJF?=
 =?gb2312?B?cGRaaUhUWjYySzAvRnUyWmZZZnFzeTk0aEdLWXdMVTdmUFhScXFaOEJyRk0x?=
 =?gb2312?B?Qk9INzRUbVVsQWhtaitPUGdMaGhQbi9tMDh4ZnhWU3QzNXg1RmJWd1ZRYjI1?=
 =?gb2312?B?em8vWHVTanNGcFNSTitMWlh6ZnRSR3ZBaUlrRXliYkw5UFNsMjJWN1pYa3c4?=
 =?gb2312?B?QytiR0VMaUhoV1BpcjExNEJ6Vk5EcEQ3TkxHZ055cGNuZzhoR2g5bm45WCtD?=
 =?gb2312?B?akVzNTV6MzlyVThnTVYxMDFJVWc5ZjQ2djdPcDZ3c2xiUENmM04yTVMvQ1Jo?=
 =?gb2312?B?U3lYUGpDWDZudnV2Ulg2cm9kNWdhU3FMRzdoZk1QNVZ2OHBkMGllK01kZStu?=
 =?gb2312?B?YytLdG80T3QvYlU0T1Z6bHovR1lxQVZaWGJtYUJ0OStuaGtDcDRNSldmREs1?=
 =?gb2312?B?bXZvRG9XeDNMSmJGdk9YeWYwdnludkF2THZnVmZHWHdOanZadlNUcW84aXFn?=
 =?gb2312?B?Y0o1byttYTBaTVBpV0g3enp1bkloQ3hHNzlOdW5kWm5jU1FqOFJRcUR5a3dE?=
 =?gb2312?B?d00vaWdZbXVLUUxKL3RSUE45cE80bkV3bVBlemhFVmlaSk9kajVaYjhHU2F3?=
 =?gb2312?B?LzNLNStWL1VtaFhZSGR1dFVrdWJkNnRMUC9uWUROdlZ1MmxvZ3lCci9lTTM1?=
 =?gb2312?B?c0RacTdyWHl4NWNmYUg1ODNJMGg5TTVWeEc1SmlYSi9Wd0xKQXRsay9pK0tV?=
 =?gb2312?Q?9TO83H7f3YbLiDA2dYo6ZOyJq?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fecb451-35fb-4bbd-3f7c-08db03603516
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 07:53:14.5295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NaLs6Wb2kMAQeMhe+kDvJE39/wtce45s1N4HDFzTwb47018wTfLBbTFgYM5ysZwLpbjMTXcYfzHx5Ai4vqa8BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7618
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDIzxOox1MIzMcjVIDY6MzANCj4gVG86IEhvbmd4aW5nIFpo
dSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxp
bmFyby5vcmc7IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7
IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBueHAuY29t
PjsgbWFyZXhAZGVueC5kZTsgTWFyY2VsIFppc3dpbGVyDQo+IDxtYXJjZWwuemlzd2lsZXJAdG9y
YWRleC5jb20+OyB0aGFydmV5QGdhdGV3b3Jrcy5jb207IEZyYW5rIExpDQo+IDxmcmFuay5saUBu
eHAuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2Vy
bmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHY3IDIvNV0gZHQtYmluZGluZ3M6IGlteDZxLXBjaWU6IEFkZCBz
Y2hlbWEgZm9yIGkuTVg4TQ0KPiBQQ0llIEVuZHBvaW50IG1vZGVzDQo+IA0KPiBPbiBNb24sIEph
biAzMCwgMjAyMyBhdCAxMTozMjoxNkFNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBB
ZGQgc3VwcG9ydCBmb3IgaS5NWDhNIFBDSWUgRW5kcG9pbnQgbW9kZXMsIGFuZCB1cGRhdGUgdGhl
IE1BSU5UQUlORVINCj4gPiBhY2NvcmRpbmdseS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJp
Y2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRp
bmdzL3BjaS9mc2wsaW14NnEtcGNpZS1lcC55YW1sICAgICAgIHwgMzE3DQo+ICsrKysrKysrKysr
KysrKysrKw0KPiA+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgIDEgKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDMxOCBpbnNlcnRpb25zKCspDQo+ID4g
IGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9wY2kvZnNsLGlteDZxLXBjaWUtZXAueWFtbA0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS1lcC55
YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2
cS1wY2llLWVwLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAw
MDAwMDAwMC4uN2M1OTRhZTUzMDY3DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUtZXAueWFtbA0K
PiA+IEBAIC0wLDAgKzEsMzE3IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChH
UEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRp
ZDoNCj4gPiAraHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/
dXJsPWh0dHAlM0ElMkYlMkZkZXZpDQo+ID4NCj4gK2NldHJlZS5vcmclMkZzY2hlbWFzJTJGcGNp
JTJGZnNsJTJDaW14NnEtcGNpZS1lcC55YW1sJTIzJmRhdGE9MDUNCj4gJTdDMDENCj4gPg0KPiAr
JTdDaG9uZ3hpbmcuemh1JTQwbnhwLmNvbSU3Qzk4ZTM4YWI3NTY1NTQwNmQzZGVhMDhkYjAzMTE3
NmRhJQ0KPiA3QzY4NmVhMQ0KPiA+DQo+ICtkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAl
N0MwJTdDNjM4MTA3MTQ1NzY4NjcyOTk5JTdDVQ0KPiBua25vd24lN0NUDQo+ID4NCj4gK1dGcGJH
WnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3
aUwNCj4gQ0pYVkMNCj4gPg0KPiArSTZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJnNkYXRhPW5RSjlO
Mm1ubDNmQW13bXlYc0VScXpzdURvDQo+ICUyRmd6eUR4cEJENQ0KPiA+ICtjMExxaXpNJTNEJnJl
c2VydmVkPTANCj4gPiArJHNjaGVtYToNCj4gPiAraHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZkZXZpDQo+ID4NCj4gK2NldHJl
ZS5vcmclMkZtZXRhLXNjaGVtYXMlMkZjb3JlLnlhbWwlMjMmZGF0YT0wNSU3QzAxJTdDaG9uZ3hp
bg0KPiBnLnpodSUNCj4gPg0KPiArNDBueHAuY29tJTdDOThlMzhhYjc1NjU1NDA2ZDNkZWEwOGRi
MDMxMTc2ZGElN0M2ODZlYTFkM2JjMmI0DQo+IGM2ZmE5MmNkOQ0KPiA+DQo+ICs5YzVjMzAxNjM1
JTdDMCU3QzAlN0M2MzgxMDcxNDU3Njg2NzI5OTklN0NVbmtub3duJTdDVFdGcGINCj4gR1pzYjNk
OGV5SldJDQo+ID4NCj4gK2pvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklr
MWhhV3dpTENKWFZDSTZNbjAlM0QlNw0KPiBDMzAwMCUNCj4gPg0KPiArN0MlN0MlN0Mmc2RhdGE9
VzNDbU1jYTllUnNQVXlZaVo2UTJISVZtbUhVMVFnSmN6R2V5Z3VMczdQOA0KPiAlM0QmcmVzZXJ2
ZQ0KPiA+ICtkPTANCj4gPiArDQo+ID4gK3RpdGxlOiBGcmVlc2NhbGUgaS5NWDYgUENJZSBFbmRw
b2ludCBjb250cm9sbGVyDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIEx1Y2Fz
IFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPg0KPiA+ICsgIC0gUmljaGFyZCBaaHUgPGhv
bmd4aW5nLnpodUBueHAuY29tPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246IHwrDQo+ID4gKyAg
VGhpcyBQQ0llIGNvbnRyb2xsZXIgaXMgYmFzZWQgb24gdGhlIFN5bm9wc3lzIERlc2lnbldhcmUg
UENJZSBJUA0KPiA+ICthbmQNCj4gPiArICB0aHVzIGluaGVyaXRzIGFsbCB0aGUgY29tbW9uIHBy
b3BlcnRpZXMgZGVmaW5lZCBpbg0KPiBzbnBzLGR3LXBjaWUtZXAueWFtbC4NCj4gPiArICBUaGUg
Y29udHJvbGxlciBpbnN0YW5jZXMgYXJlIGR1YWwgbW9kZSB3aGVyZSBpbiB0aGV5IGNhbiB3b3Jr
DQo+ID4gK2VpdGhlciBpbg0KPiA+ICsgIFJvb3QgUG9ydCBtb2RlIG9yIEVuZHBvaW50IG1vZGUg
YnV0IG9uZSBhdCBhIHRpbWUuDQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBh
dGlibGU6DQo+ID4gKyAgICBlbnVtOg0KPiA+ICsgICAgICAtIGZzbCxpbXg4bW0tcGNpZS1lcA0K
PiA+ICsgICAgICAtIGZzbCxpbXg4bXEtcGNpZS1lcA0KPiA+ICsgICAgICAtIGZzbCxpbXg4bXAt
cGNpZS1lcA0KPiA+ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBtaW5JdGVtczogMg0KPiA+ICsN
Cj4gPiArICByZWctbmFtZXM6DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBjb25zdDog
ZGJpDQo+ID4gKyAgICAgIC0gY29uc3Q6IGFkZHJfc3BhY2UNCj4gPiArDQo+ID4gKyAgaW50ZXJy
dXB0czoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBidWlsdGlu
IGVETUEgaW50ZXJydXB0ZXIuDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdC1uYW1lczoNCj4gPiAr
ICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGNvbnN0OiBkbWENCj4gPiArDQo+ID4gKyAgY2xvY2tz
Og0KPiA+ICsgICAgbWluSXRlbXM6IDMNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRl
c2NyaXB0aW9uOiBQQ0llIGJyaWRnZSBjbG9jay4NCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjog
UENJZSBidXMgY2xvY2suDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IFBDSWUgUEhZIGNsb2Nr
Lg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBBZGRpdGlvbmFsIHJlcXVpcmVkIGNsb2NrIGVu
dHJ5IGZvciBpbXg2c3gtcGNpZS1lcCwNCj4gPiArICAgICAgICAgIGlteDhtcS1wY2llLWVwLg0K
PiA+ICsNCj4gPiArICBjbG9jay1uYW1lczoNCj4gPiArICAgIG1pbkl0ZW1zOiAzDQo+ID4gKyAg
ICBpdGVtczoNCj4gPiArICAgICAgLSBjb25zdDogcGNpZQ0KPiA+ICsgICAgICAtIGNvbnN0OiBw
Y2llX2J1cw0KPiA+ICsgICAgICAtIGVudW06IFsgcGNpZV9waHksIHBjaWVfYXV4IF0NCj4gPiAr
ICAgICAgLSBlbnVtOiBbIHBjaWVfaW5ib3VuZF9heGksIHBjaWVfYXV4IF0NCj4gDQo+IEFyZSB0
aGUgY2xvY2tzIGluIGVuZHBvaW50IG1vZGUgc3VkZGVubHkgZGlmZmVyZW50PyBJIGNhbid0IHRl
bGwsIGJ1dCB3aWxsDQo+IGFzc3VtZSBzbyBzaW5jZSB0aGV5IGFkZGVkIGhlcmUuDQpUaGVzZSBj
bG9ja3MgcHJvcGVydGllcyBhcmUgc2FtZSBlaXRoZXIgdGhlIGNvbnRyb2xsZXIgaXMgaW4gUkMg
bW9kZSBvcg0KIHRoZSBFbmRwb2ludCBtb2RlLg0KU2FtZSB0byBwb3dlcnMgYW5kIHJlc2V0cyBs
YXRlci4NCj4gDQo+ID4gKw0KPiA+ICsgIG51bS1sYW5lczoNCj4gPiArICAgIGNvbnN0OiAxDQo+
IA0KPiBZb3Ugc2hvdWxkbid0IG5lZWQgdGhpcyBpZiBpdCBjYW4gb25seSBiZSAxIHZhbHVlLg0K
PiANCmkuTVg4UU0gUENJZSBjYW4gc3VwcG9ydCB1cCB0byAybGFuZXMgZGV2aWNlLCBhbHRob3Vn
aCBpdCBpcyBub3Qgc3VwcG9ydGVkDQogeWV0LiBTbyBpdCdzIGJldHRlciB0byBrZWVwIHRoaXMg
cHJvcGVydHkuDQoNCj4gPiArDQo+ID4gKyAgZnNsLGlteDdkLXBjaWUtcGh5Og0KPiA+ICsgICAg
JHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZQ0KPiA+ICsgICAg
ZGVzY3JpcHRpb246IEEgcGhhbmRsZSB0byBhbiBmc2wsaW14N2QtcGNpZS1waHkgbm9kZS4gQWRk
aXRpb25hbA0KPiA+ICsgICAgICByZXF1aXJlZCBwcm9wZXJ0aWVzIGZvciBpbXg3ZC1wY2llLWVw
IGFuZCBpbXg4bXEtcGNpZS1lcC4NCj4gPiArDQo+ID4gKyAgcG93ZXItZG9tYWluczoNCj4gPiAr
ICAgIG1pbkl0ZW1zOiAxDQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBkZXNjcmlwdGlv
bjogVGhlIHBoYW5kbGUgcG9pbnRpbmcgdG8gdGhlIERJU1BMQVkgZG9tYWluIGZvcg0KPiA+ICsg
ICAgICAgICAgaW14NnN4LXBjaWUtZXAsIHRvIFBDSUVfUEhZIHBvd2VyIGRvbWFpbiBmb3IgaW14
N2QtcGNpZS1lcA0KPiBhbmQNCj4gPiArICAgICAgICAgIGlteDhtcS1wY2llLWVwLg0KPiA+ICsg
ICAgICAtIGRlc2NyaXB0aW9uOiBUaGUgcGhhbmRsZSBwb2ludGluZyB0byB0aGUgUENJRV9QSFkg
cG93ZXINCj4gZG9tYWlucw0KPiA+ICsgICAgICAgICAgZm9yIGlteDZzeC1wY2llLWVwLg0KPiA+
ICsNCj4gPiArICBwb3dlci1kb21haW4tbmFtZXM6DQo+ID4gKyAgICBtaW5JdGVtczogMQ0KPiA+
ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gY29uc3Q6IHBjaWUNCj4gPiArICAgICAgLSBjb25z
dDogcGNpZV9waHkNCj4gPiArDQo+ID4gKyAgcmVzZXRzOg0KPiA+ICsgICAgbWluSXRlbXM6IDIN
Cj4gPiArICAgIG1heEl0ZW1zOiAzDQo+ID4gKyAgICBkZXNjcmlwdGlvbjogUGhhbmRsZXMgdG8g
UENJZS1yZWxhdGVkIHJlc2V0IGxpbmVzIGV4cG9zZWQgYnkgU1JDDQo+ID4gKyAgICAgIElQIGJs
b2NrLiBBZGRpdGlvbmFsIHJlcXVpcmVkIGJ5IGlteDdkLXBjaWUtZXAgYW5kDQo+IGlteDhtcS1w
Y2llLWVwLg0KPiA+ICsNCj4gPiArICByZXNldC1uYW1lczoNCj4gPiArICAgIG1pbkl0ZW1zOiAy
DQo+ID4gKyAgICBtYXhJdGVtczogMw0KPiANCj4gU2FtZSBxdWVzdGlvbiBmb3IgcmVzZXRzLg0K
UmVnYXJkaW5nIG15IHVuZGVyc3RhbmRzLCBpLk1YN0QgYW5kIGkuTVg4TVEgUENJZSBjb250cm9s
bGVyIGhhcyBvbmUgd3JhcHBlcg0KaW50ZXJuYWwgUENJZSBQSFkuIEFuZCB0aGlzIFBIWSBpcyBu
b3QgZXhwb3NlZCBhcyBpLk1YOE1NL2kuTVg4TVAgUENJZSBkb2VzLg0KDQpTbywgdGhlcmUgYXJl
IHNvbWUgZGlmZmVyZW50IGNvbnRyb2wgbG9naWMgaGVyZS4NCj4gDQo+ID4gKw0KPiA+ICsgIGZz
bCx0eC1kZWVtcGgtZ2VuMToNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBHZW4xIERlLWVtcGhhc2lz
IHZhbHVlIChvcHRpb25hbCByZXF1aXJlZCkuDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBl
cy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPiArICAgIGRlZmF1bHQ6IDANCj4gPiArDQo+
ID4gKyAgZnNsLHR4LWRlZW1waC1nZW4yLTNwNWRiOg0KPiA+ICsgICAgZGVzY3JpcHRpb246IEdl
bjIgKDMuNWRiKSBEZS1lbXBoYXNpcyB2YWx1ZSAob3B0aW9uYWwgcmVxdWlyZWQpLg0KPiA+ICsg
ICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4gKyAg
ICBkZWZhdWx0OiAwDQo+ID4gKw0KPiA+ICsgIGZzbCx0eC1kZWVtcGgtZ2VuMi02ZGI6DQo+ID4g
KyAgICBkZXNjcmlwdGlvbjogR2VuMiAoNmRiKSBEZS1lbXBoYXNpcyB2YWx1ZSAob3B0aW9uYWwg
cmVxdWlyZWQpLg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlv
bnMvdWludDMyDQo+ID4gKyAgICBkZWZhdWx0OiAyMA0KPiA+ICsNCj4gPiArICBmc2wsdHgtc3dp
bmctZnVsbDoNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBHZW4yIFRYIFNXSU5HIEZVTEwgdmFsdWUg
KG9wdGlvbmFsIHJlcXVpcmVkKS4NCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwj
L2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAgZGVmYXVsdDogMTI3DQo+ID4gKw0KPiA+ICsg
IGZzbCx0eC1zd2luZy1sb3c6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogVFggbGF1bmNoIGFtcGxp
dHVkZSBzd2luZ19sb3cgdmFsdWUgKG9wdGlvbmFsIHJlcXVpcmVkKS4NCj4gPiArICAgICRyZWY6
IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAgZGVmYXVs
dDogMTI3DQo+IA0KPiBOb3cgd2UnZCBkdXBsaWNhdGVkIGRlZmluaW5nIHRoZSB0eXBlIGZvciBh
bGwgdGhlc2UgcHJvcGVydGllcy4uLg0KPiANCj4gVGhpcyBuZWVkcyB0byBiZSByZXN0cnVjdHVy
ZWQgaW50byBhIHNjaGVtYSBvZiBhbGwgdGhlIGNvbW1vbiBwcm9wZXJ0aWVzIGFuZA0KPiB0aGVu
IHRoZSBob3N0IGFuZCBlbmRwb2ludCBzY2hlbWEgY2FuIHJlZmVyZW5jZSBpdC4gSU9XLCBsaWtl
IGhvdyBvdGhlcg0KPiBzY2hlbWFzIGhhdmUgYmVlbiBkb25lLg0KVGhhbmtzIGZvciB5b3VyIGFk
dmljZS4gVGhpcyBpcyBhIGdvb2QgaWRlYS4gV291bGQgZGVyaXZlIHRoZSBjb21tb24gcHJvcGVy
dGllcw0Kc2hhcmVkIGJ5IFJDIGFuZCBFUCBzY2hlbWEuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFy
ZA0KPiANCj4gUm9iDQo=
