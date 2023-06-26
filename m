Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A313073D5B0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjFZCC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjFZCC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:02:26 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5632A1A6;
        Sun, 25 Jun 2023 19:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byOcBfkiXbuF+aoGzsIObH5IPDXNFNusRldrWSt93iZe0G2zIsqnK1cE3Y095TeIxhTPX5u5ljsnC5eHfRQhYw7+v0dCWwcb/ezfP0R1Ryu2qlDjkDPHd3rEZHAPwo2bj/jx0Hb+H2TOKlwc5R7imTQGwRoGfdFld6+KMmtkpDDawwk2+GWwKFErUlDBbRq0RBRgVewC+jAaMM5sJ1mSbV7Xmvo8JngScn7GEpYlTnDmhId2/GwCDbA+qqwFzouRG0FMv5Y6gtop5IkwZFKyp/8oCyyXlWJBN/GHVHCw83W5Iw9B72klSwo/4mfouHwE8p08RNay5eaKFOJtaglY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Us/4CdGOR6owdudnc6F0LbukH6St+BYBq0i/5PelKtw=;
 b=MkNXcid7/ZuWlZ9MXoEldB3Icj/ZCaetaTf3WUXo1YR4nanPsLA64fsTRkBjHymkL5KuFpYUbGlbMeoiJPD/pxQEpoILSgqs1w3H03J6wwrbXBb/luuVAY5j6zYiTKPRKCtnQfSf0mixRA8eZCYRj6P25pzraaaP+y+6f8xHF61AWo/slmu8mZboCIOchJSb2dS2fV0MDK3EnPFw+UrBsiFyRYkzhbKLem3jxPNG77l9avSGRZamkKPd081dB7RcntGXhMyZiZIh/INI4uFZmEib6QNrSH87FYUspzDBY9WXD/xpUOCud6XySHiuxLNjN5cuJTLFHdfdbViYYuIvmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Us/4CdGOR6owdudnc6F0LbukH6St+BYBq0i/5PelKtw=;
 b=UyQrjSizsGaPJjeFu+g35OiJOAJWoS6DGhkoqKuYLx75Q5KJl27SGgVI3Q+iv/j097rmbGd4cg3AccXOsCdviy9JFcHoU/L2aV9I8h/PlshHKrpaU7BK1bhCXl/W28PHiTrQCG7uGS+67vCwY5GrS2LJ+dN+oKMdDpaLBw2oqXw=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VE1PR04MB7454.eurprd04.prod.outlook.com (2603:10a6:800:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 02:02:17 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 02:02:17 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 4/4] dt-bindings: serial: fsl-lpuart: add imx8ulp
 compatible string
Thread-Topic: [PATCH 4/4] dt-bindings: serial: fsl-lpuart: add imx8ulp
 compatible string
Thread-Index: AQHZp0sbmRUgGoZupUyaQLK7zLF8TK+bTeyAgAAqn6CAAC+cAIAArTvw
Date:   Mon, 26 Jun 2023 02:02:17 +0000
Message-ID: <AS8PR04MB8404E78E7DB663FC639CD0749226A@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20230625094857.29644-1-sherry.sun@nxp.com>
 <20230625094857.29644-5-sherry.sun@nxp.com>
 <d990a281-b4a3-1e26-1fdf-dfd35ab9cd24@linaro.org>
 <AS8PR04MB84042EF903689014CC0C33809221A@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <731db330-4a0f-2427-a0ab-318f2d8be73b@linaro.org>
In-Reply-To: <731db330-4a0f-2427-a0ab-318f2d8be73b@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|VE1PR04MB7454:EE_
x-ms-office365-filtering-correlation-id: ec70fff1-35a0-44c2-2c0d-08db75e95e45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tw8v1f1dib4n3hUM5KhKbRNXvOqB6a0iyhCZEk7JX6vanLq59Q9DOqbJ8bZRtk6zbttwUXxcjvMpb6CYegHfd2Ca9SGZysic4DcZDovXJIELA78VYke563wm3MZAzfRN8L+H4ASSZBRIRuGUJz/g5lAvQayRpRvaPE+zzPlHsUkRdQEJfjFGJVqeDivqGtC2MP6gWNueV7G0wF8FdDOF0pIfSVRLAQqG1LgNzDN+f0xrjeJKiZ+L00hxG39ThCwyLJloTWiZeJ58KrjNhfVoeUXMROwYhY2CJ+o9lvfTzYeuSFSE6KtxT2ix2oT/bVV6GBpKmNcnBxqEIqdsAsoPIjBfHyARCeMPnFLChnC7B+l0hHHRxPX35Qm8IGrCVFzl+Drv0kCp/AEk/vC0li3NIWiQ+8WkpbmmI4O9HOxl7ZoiZQKfsKS9HZbV7iI84HvSdbedhkenu/l2e59m+5pdg6UlWvYpTLesLcu6yCb+ODt6hoc06nFZrdGIGfB9hwAU0b/mgpCYe+pmpui5MQ98s9o5Kk8PxgBt1zEn4hfXUCBiGApKJFa9weLTZpAmqE8vYk232FQ7jrKfquakAVA5eaLVIl+3MaAHwDLEsadCwul6myBMZIWV0xPv/IIEBiJmmb74ZOuLOc4/YMCauB+qjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(26005)(33656002)(52536014)(5660300002)(44832011)(7416002)(66476007)(86362001)(8936002)(8676002)(41300700001)(66446008)(4326008)(64756008)(38070700005)(66556008)(38100700002)(122000001)(55016003)(76116006)(66946007)(316002)(6506007)(53546011)(2906002)(9686003)(186003)(71200400001)(478600001)(7696005)(54906003)(110136005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1RGSytvUHZWZlhrVmtLOFphRzFTQzhDbnNCaXpGcC9UTlNmSitWVjBHbmF6?=
 =?utf-8?B?dVRzbTN5eHhxWHo1eHZqMEMxRkJuSWVnNmYyUnE1azZwMi93ZlBRaVpUYTBa?=
 =?utf-8?B?a1pJSTk2MnhqdTNucnZUQVN5SXRNSUFudFU1c2FScnFvUG0vRXJ6MGxXblg5?=
 =?utf-8?B?OFRKa01FaTlKS0dId01XbDRHN0kyRzcxc3lRS1pEVkJ3MDZJWmJ0QU1GNVFB?=
 =?utf-8?B?Q09xczZvaHpPaW5OWWVOSWdqMXExSWg0Zll3bU8xZkQvdFVnWUhjQVVoNGth?=
 =?utf-8?B?YVE0THcyZ1l3Zml3WFljK1VXL2M2MTcweHVZVlk0T1d6WmpNL1BqZjVXeUFo?=
 =?utf-8?B?Myt1d2pMVGVtZVNLYW9EUUhoTzBiUWk5YlhTSGR1NG1lZ1BnN2ZCN3RaWlpR?=
 =?utf-8?B?YUxqQXE0YUtxUWdIblZMZTU4SzlmbjZvUTlDNEI2T3R0RVRHbzJRQUNMVlE3?=
 =?utf-8?B?dy9EcldhRFY2ZGt6NkVYMnhKNkk3VFVpYS9EWjl4Ukl6L2krK3hYZUV6dmdu?=
 =?utf-8?B?Y2h2bmhiK25zWVkreG1Oc3JzVUcwS09NREh1dFhkVURHeXUvUlBncTZFSkZY?=
 =?utf-8?B?Z1ZVQStNSUxCL2JXNXlDWVNHNVZTVDZVaDM1NHZBekdqc3BBM0RxL2FXY3dC?=
 =?utf-8?B?VHFBQnhtc1Z2TnQ4elZqVzM2UEtLL3VURXliWWZ0czlwZWNiS3NqUVlEZkEx?=
 =?utf-8?B?S2R0TkYzUlprRUN2N09zRXliTlNpRVlLK0FtWVpvU29MdkVKZENtS2ZvazRo?=
 =?utf-8?B?TjRuelI0WmVlSFh1WWhsWFJuTVpJU1JwcGFuTFFEMURHNXFuTDRtYlFyUFZP?=
 =?utf-8?B?bDVra2VyaC9UeVlvd0x1dlBYZ0dEYkhUbGExVjc5Rm5BVElESzQ0T3E0Y3NV?=
 =?utf-8?B?aG1NN0ZqSnBKQWplblFLb1kzWXJJRDQ3elFqRjNhQ1ptSk0yekppNHkwbzhS?=
 =?utf-8?B?aUlQeFY0eEYveVk1QTFpQ0dyckswSzdJR0R4czQraFNvRFA2bkZyNUdxRlU3?=
 =?utf-8?B?YzBlS1BDZEZINFhBMVlKem1xaUwxY1phL2Ziamw0U25xSHZaRWtHaFU3a2pi?=
 =?utf-8?B?cStzNGtpcFJyQXN3bFpaK0Z6MjJhN3c3aFlUY1h1ajlXaGRmeHFqY1VTOTQz?=
 =?utf-8?B?RERZVThPcjl2UEVnamREeDJWcUdwa2cyLzVFRUhteVd1eWtJVTFmckJtVVBz?=
 =?utf-8?B?cGRCUFRpUHVsTkt4dTVXSGdRcE9kaWxBWUZJUldmK1FoUExPMndKeWVXUnFG?=
 =?utf-8?B?VUFNbmtDZVlrSG1CMmhiWE4zRjV5K2VVU2dBRlE3WjI1NW15TmxUalljdlk5?=
 =?utf-8?B?MVlqZUt0UEJQb25jUGh3T1lyUWcxbkRLNWF6V0xsVnd6NHFTS3RTcXdkV1p4?=
 =?utf-8?B?Y1duK0szNG9hcm9qc3F6RkJMMVpYZ3JEK0J0UHJ0SjV2bUxlZWt6ZWc0TEFE?=
 =?utf-8?B?TlhZSnArc29IV2l5am5KNGE3TGxTNVBBZmlqNzg5a2x3NExHOU9iNFczS0Rv?=
 =?utf-8?B?R1hKcEdRYm0rMGNpU21pU2txWkdPeU9GY1dCcDN6YkN0OFRQaGNGaURqMjdB?=
 =?utf-8?B?cnlqWEJrUFpHRHRUVzNIWEZyQkNCVU42M09OU0hmQXBJaHBFZS9hSThaM0FR?=
 =?utf-8?B?ZEUxS280ZTZuZytJbXZUNE51YlpyN0dVeHNKL0IzM1VEYkgyc0JPcXROcXR2?=
 =?utf-8?B?Y1kzZmRNdWlRY1RzRUZUVGRCN2VMNC9WcDJQRng3Z3BEdDdjNTZtSXc4U3Bo?=
 =?utf-8?B?NXBOZHRENzk0ejhYSCtOT2pvMVVYaE9ZL2dkV0ZKT2lxM1hhV1Q3akRIblBv?=
 =?utf-8?B?OE5zZVpEOVRIN0t6NGJDQXJHRnZSeVRGWVBURlpnWHBmalBrQzNaK3RidUpF?=
 =?utf-8?B?R25xeE9xaW9WaXRLeHJRaXpldll2VUJIRHRmSktTZ2RSZytYR3hvM0VnSmFj?=
 =?utf-8?B?bkVob1F5WmVOMTZTUS9RTmhycTl0YmFQeURvL2JKc2lSY3dvaEFDNllKbjk2?=
 =?utf-8?B?VEp3ays3QzArWXloNkROWE5rNlBMR2JnYjRQdk1rSGdVVXJpMjhyTlBVWUhk?=
 =?utf-8?B?ZEl4TDNiWVFnN2syRlZEZjRjMHA4UWpmUFpsSXJsMWdmTHAwNkc0WFl0Vk1L?=
 =?utf-8?Q?iLBw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec70fff1-35a0-44c2-2c0d-08db75e95e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 02:02:17.2295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UTmIEBlPgGg6gOiZifpVh/Wh88SwVyGbhDNQBrLEEVsNHyKMs+cRlktFK5DmuIwWFRoN0OBfvL1qf3F0TQ2+qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7454
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4+DQo+ID4+IE9uIDI1LzA2LzIwMjMgMTE6NDgsIFNoZXJyeSBTdW4gd3JvdGU6DQo+ID4+
PiBMUFVBUlQgZHJpdmVyIGFkZHMgYSBuZXcgY29tcGF0aWJsZSBzdHJpbmcgZm9yIGlteDh1bHAs
IGFuZCBpbXg5MyBpcw0KPiA+Pg0KPiA+PiBXaGF0IGRyaXZlciBhZGRzIG9yIG5vdCwgaXMgbm90
IHJlYWxseSBjb3JyZWN0IGFyZ3VtZW50IGZvciBjb21wYXRpYmlsaXR5Lg0KPiA+PiBUaGVyZSBh
cmUgcGxlbnR5IG9mIGNvbXBhdGlibGUgZGV2aWNlcyB3aGljaCBoYXZlIGJvdGggZGV2aWNlIElE
DQo+ID4+IGVudHJpZXMgaW4gdGhlIGRyaXZlci4gV2h5IHdvdWxkIHlvdSBkcm9wIHRoZWlyIGNv
bXBhdGliaWxpdHkgYmV0d2Vlbg0KPiA+PiBlYWNoIG90aGVyPyBJdCBkb2VzIG5vdCB3b3JrIGxp
a2UgdGhhdC4uLiBQcm92aWRlIGNsZWFyIHJhdGlvbmFsZSBmb3IgdGhpcy4NCj4gPg0KPiA+IEhp
IEtyenlzenRvZiwNCj4gPiBXZSB0YWtlIGlteDd1bHAgbHB1YXJ0IGFzIHRoZSBiYXNpYyB2ZXJz
aW9uIElQLCB0aGVuIGlteDh1bHAgYWRkcyBzb21lDQo+IGltcHJvdmVkIGZlYXR1cmVzIGJhc2Vk
IG9uIHRoZSBpbXg3dWxwIGxwdWFydCBJUC4NCj4gPiBBY3R1YWxseSBpbXg4dWxwIGNhbiBhbHNv
IHdvcmsgd2l0aCB0aGUgaW14N3VscCB2ZXJzaW9uLCB3ZSBjYW4gc2F5IGl0IGlzDQo+IGNvbXBh
dGlibGUgd2l0aCBpbXg3dWxwLCBidXQgd2UgbmVlZCB0byBlbmFibGUgdGhvc2UgbmV3IGZlYXR1
cmVzIGJ5DQo+IGRlZmF1bHQgb24gaW14OHVscCwgc28gd2UgYWRkZWQgdGhlIGlteDh1bHAtbHB1
YXJ0IGNvbXBhdGlibGUgaW4gbHB1YXJ0DQo+IGRyaXZlci4gU28gZm9yIHRoaXMgY2FzZSwgbWF5
YmUgY29tcGF0aWJsZSA9ICJmc2wsaW14OHVscC1scHVhcnQiLA0KPiAiZnNsLGlteDd1bHAtbHB1
YXJ0IiBpcyBjb3JyZWN0IGZvciBpbXg4dWxwIHBsYXRmb3JtLCByaWdodD8NCj4gPg0KPiA+IFRo
ZW4gd2UgaGF2ZSB0aGUgaW14OTMgZmFtaWx5IHdpdGggdGhlIHNhbWUgbHB1YXJ0IHZlcnNpb24g
YXMgaW14OHVscCwgc28NCj4gaG93IHNob3VsZCB3ZSBoYW5kbGUgdGhlIGNvbXBhdGlibGUgc3Ry
aW5nIGZvciBpbXg5MyBwbGF0Zm9ybT8gTWF5YmUNCj4gY29tcGF0aWJsZSA9ICJmc2wsaW14OTMt
bHB1YXJ0IiwgImZzbCxpbXg4dWxwLWxwdWFydCIsICJmc2wsaW14N3VscC1scHVhcnQiPw0KPiBC
dXQgdGhyZWUgY29tcGF0aWJsZSBzdHJpbmdzIGxvb2tzIHRvbyBsb25nIGZvciBtZSwgc28gSSB3
YW50IHRvIGRyb3ANCj4gaW14N3VscC1scHVhcnQgYW5kIHRha2UgaW14OHVscC1scHVhcnQgYXMg
dGhlIGJhc2ljIGNvbXBhdGlibGUgc3RyaW5nIGZvcg0KPiBpbXg5MyBhbmQgbGF0ZXIgb3RoZXJz
IGlteDkgc2VyaWVzLCBJIGFtIG5vdCBzdXJlIGlmIGl0IGlzIHN1aXRhYmxlLCBzb21lDQo+IHN1
Z2dlc3Rpb25zIGhlcmUgd2lsbCBiZSBhcHByZWNpYXRlLCB0aGFua3MhDQo+ID4NCj4gDQo+IFdy
YXAgeW91ciByZXNwb25zZXMuDQo+IA0KPiBTbyB3cml0ZSB0aGF0IHRoZSByZWFzb24gb2YgdGhp
cyBjaGFuZ2UgaXMgYmVjYXVzZSBsb29rcyB0b28gbG9uZyBmb3IgeW91IGFuZA0KPiB3ZSB3aWxs
IGp1ZGdlIHRoYXQgcmF0aW9uYWxlLiBUaHJlZSBjb21wYXRpYmxlcyBpcyBzdGlsbCBmaW5lLg0K
PiANCkhpIEtyenlzenRvZiwNCkdvdCBpdCwgdGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24sIEkg
d2lsbCB1c2UgdGhyZWUgY29tcGF0aWJsZXMgZm9yIGlteDkzLg0KDQpCZXN0IFJlZ2FyZHMNClNo
ZXJyeQ0K
