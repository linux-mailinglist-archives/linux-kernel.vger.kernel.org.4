Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4985E6C592A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 22:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjCVV5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 17:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCVV5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:57:18 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2052.outbound.protection.outlook.com [40.107.249.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C0A24BF7;
        Wed, 22 Mar 2023 14:57:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jo7NIlM9KJfztqbbG7wGkxfnddd5vQrIZg2O2MpRjpoXVf6TAFxBgEroz0fxmu+5KTdTmyiJoDzZ2OS00AzYB3m6zLWWkGHoOl+sjtlf3695FRStRt1rmRTvTYIr6Bb7Fny/OgDKn4veqBnzhUpB1+ZC06Yz3fnzP+4ruk2xbIWUTmjz9g03HxkuOOAQY768P9+mm0sOWLFKkBNyHpM/Go9hDqxBrR77qUcaI5Zyz8zMczanHKrAEoz4qrGeOlPbW0EiyAp4H4Eb0NY3y52MUBydJT/jvDiTBuxQA7OQAXD3VFHJjfpz2nLKomev21lYxsGAMcgLfJ5bcZuR6v5Qsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7/kx17r3WFcMmAHEXBXSAIt0wzxE1ricKNpnIf6eSU=;
 b=YYDXazLBuw5qzS1+d23XSwHFx7NIYTosNIXdW/8mhG/tvBuIBboVYYvVzsNctLLo9jVFO6Y8MJDb4LFavKRhTU4vEGfxB4xaJ6Vq+4ELhH14c6R9rSRr/IwLdnTb+nOjJQugf00Pgb0BEYt1DyqUaTeupLApojmIAIto8rpU1Wd3fF3Y8eBWtmocfLKcuK6p7fqOqeej6A6Rr0wMWmuI4sYjZUsqN4uXlsKzt72FBdvfkfJlmsRrRwARiCZK/4XUS0KDvY8FZzds11Ku2UOKS0vHAFn+1atntYiVafdj9pl/wOqfqA80P/NJWXZIGAjuBliWSUsnLgWg9S6rTJLCnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7/kx17r3WFcMmAHEXBXSAIt0wzxE1ricKNpnIf6eSU=;
 b=jTllXrIQgUsdRSlRtSQViC6ZEyiSAmbo5+FtUiA6cohxLoBDafX0tq5LzzpUc6QjxXE8B3LTHCYbA7kp3F0UAjfomMeC+HBJmeZYwpT6CWVMmYPekZ2+3Nz31WoElS7CbE7TJYPO5xtvGT3tZlNy+7pbX3yHd3Dkt1xGtJZwLuE=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7777.eurprd04.prod.outlook.com (2603:10a6:20b:236::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 21:57:14 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 21:57:14 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [EXT] Re: [PATCH v3 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Thread-Topic: [EXT] Re: [PATCH v3 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Thread-Index: AQHZXAih0MCX1q8KWEWxpTpi/nrVFq8GaNGAgAByipCAAHgTAIAAAD6AgAABboCAAAA0kIAAAREAgAAAXdA=
Date:   Wed, 22 Mar 2023 21:57:14 +0000
Message-ID: <AM6PR04MB4838ECE2917EF132943830EA88869@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230321151951.2784286-1-Frank.Li@nxp.com>
 <20230321151951.2784286-2-Frank.Li@nxp.com>
 <1ce3bf91-6bef-b4c1-1ec9-3a345518efeb@linaro.org>
 <AM6PR04MB483828FC1083E3C98930DF6488869@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <b5d67af0-ed08-e243-2c0c-92f1f002e552@linaro.org>
 <AM6PR04MB483841E17BEEE4F9EC596DBA88869@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <835cda64-5d42-1ff3-aa8f-0802fe3d705f@linaro.org>
 <AM6PR04MB48383C58EF1D9CFD8F7C401E88869@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <24767874-0b26-78c8-43c2-6cc3adb901f8@linaro.org>
In-Reply-To: <24767874-0b26-78c8-43c2-6cc3adb901f8@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|AM8PR04MB7777:EE_
x-ms-office365-filtering-correlation-id: 7e7c7851-3f4f-43e0-59cb-08db2b20653f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mkvGp4o7Z9eMIY7mhVoQ6sPq1MEQr9Gk4FQndC5FGZ7dlQdlB/tMjRPE5P7tQHOp3rj/uW+YbPV7sIokFQfekmaJXt+pttIYpa6H17lJSHKZSkLK/h+kYILuw2pekzmz6OE3z+FV7PYnM8u9F761SzzoKu+/8xmmicXTSadwMXGO23tZuyTk7LXpX5eR0oLHAByqVuB5RVbdfwX6yveEehbcNvxdden38N/YXnLuyJT4tl9zZLlkfUXtSzhGzCmHH8cPzodAwkgTuruxFsttn0lOSESpmM5XiZ2xI6WJlKmE2C5AY7gm/9OjHaHuVJlnBTSQyl2zbQ08CmUXLjgyAFQrIj78eEPYDxUmMI0Q8RZQTIrvVtzscqJ1tgO5kbNhQ54dchAWM5/9vQCLhroNxTx6Fenu/ULMLl3ib3ms2oav1OgjYrurqhq+uqBkxRL88f7dsp21NrcF+A1OUx9fhFIkWLzITBFmT+1vuRbqNj92bvHNVbaLRZW/tYSVXmusLhiJcDlgEtpKU6CeDFRdk9+58nHImVw+tntw9oX571SuoHcLnDc3C8hj5FbX1hu/RKmG84LAUoEPiowCNT+P2ApDCcOxK9vTznK39fiSewxwLCGhPvAK8XQbCG9qtBk/xsTFSbvsD5kfkSJo2o4JWNCG4diOKqITifmXUTyq62k460pKD6uS+LwclzA0rHGQrbMMZ+yKLRBtzpaazfqSgijkAAVaGpjmRI1BI8txx6s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199018)(7696005)(54906003)(316002)(478600001)(53546011)(6506007)(33656002)(5660300002)(55236004)(9686003)(7416002)(83380400001)(186003)(122000001)(71200400001)(38100700002)(26005)(86362001)(55016003)(38070700005)(52536014)(6916009)(66946007)(76116006)(44832011)(41300700001)(64756008)(8676002)(2906002)(66476007)(66556008)(8936002)(4326008)(66446008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVFBTCtaSXMrWnBjY0FQYmFZYllqaW5uUWFNRlRMaGJuNGp0QmNHMFBIakYv?=
 =?utf-8?B?bHh5cXVlcDVUMWNIaTJSNnM5UWVwRm5jUlhzTTBHKzV0MFIrZW5rOXdWZFZK?=
 =?utf-8?B?QWk3MXVRcENPRmI4dnpYOUZyR3l2Z0lRUnhhOUZ0TUxycXB2TXJjMmM2T0hU?=
 =?utf-8?B?UVZLY3NjTjJ3blhSTGdOeGx3N21ydVE4WWtTSTR0aUpqUEhUcWpmeWE1S1Bx?=
 =?utf-8?B?aUxxOXhISGJ5ZFRNa3BhZVkvOVdnNlV2Q3U5cFhDcVU2dVdyUVJta25FbXlO?=
 =?utf-8?B?LzdRalFCejBMcVV0TXRsUzlabDFYeUYzSEVBaHdRWEw4NzlVeU5VZ1V3Rmt0?=
 =?utf-8?B?a1N3azF6VUVnSHZ4SWVhZlRqa2ltWS9STEFjSjdYZ010YVNlTTlIdUU1VnF4?=
 =?utf-8?B?QjYwZkU4aHBZZTg2RUhnamYxMVphejg3T2YydDF2VW5DSzk3UTl0cjA4RlZv?=
 =?utf-8?B?TmFCQUJTYXdTOENOOFBkV2NKMVRmYmRucDF4bURFNzdMSlBIMG5jdTdld3k4?=
 =?utf-8?B?eXB4MDczZ3hySEJZdkxtQ0JwM3ZqbC80OFRZd2pKWUZNbk5zWmpSMWF1R0hT?=
 =?utf-8?B?MUV3bnZBWGd1S2ZFZEFBT1JzTmlOQ3JXMm51aUpzQ3I4OHhpeTR3dHFlK1NY?=
 =?utf-8?B?MHVaZHdQK3A0bXJxdWlvTmtwZVFnNjBHbGVoZnNGdzc3K2Q4ZEVlSnIvZ2ZR?=
 =?utf-8?B?SSs5NzN5OGtqdjZyTmMzTWN0UUs3ajBzUUQrZGRocy9WcVZCZS9MYkFmVVcy?=
 =?utf-8?B?VUZMbE1FVEl3dzNnYS82SzZUWm1qTWl3dTJBR3gvTllmT3VzNm40OW10cEhC?=
 =?utf-8?B?SmxnZ0p6SWNWL2FZbWRHREdzeFArOFVvUnhsaFFjZStqUEtqcEpoVXU4dmVE?=
 =?utf-8?B?bzhONDFwMXN1OWJjZ05pbkdwMEMra1FTeThtdHNCRFZ3RDVCY1RURXlCS1Rt?=
 =?utf-8?B?SlhLSW1XdTlrcnA0bHJTcmZCZnFPcFVrNTkrNXBZTFl6NCt0UEYrbThLMXNy?=
 =?utf-8?B?Qk5xcTYrV3VFL0QwSExIT2tiNzd4QlBINHJkaE1NcERKWW1nVkxwMEtzdXNw?=
 =?utf-8?B?Qkc0YkkrRFVJTFNNYjdZeWdqWmlJek1OS01CanFKR2w3aXdoMEV1VXQ0blI1?=
 =?utf-8?B?bm11OHlGMytjUFkwOTFObTNHT2c1OEdUMTBoYXIxKzBUVWk4aUF1RUZFZnVS?=
 =?utf-8?B?czJDUzlLOUJRV3dXL1B4aVR4WlJXT3ZESG1iWVYzaHJmNGZNcVE2bWdwTnI5?=
 =?utf-8?B?SjBwckllUCtYSnBwVzNyRnZURHdQd09YaVNqQ0xXN2tRZEIxQ3NIendJcmhj?=
 =?utf-8?B?SEZrUHhtNWNoVjdMVTBRcWxnWEhIVVpzRUNFdDd6U1J4RFpGSWcxK3pLY0h4?=
 =?utf-8?B?cnMrN09HelNrWXY0NTZCRWJURG8yWHc1djFVb2FBeWpvbXlUVkdGMDlVbkhP?=
 =?utf-8?B?S3JKWC9NZGtEYUlBZ3VGZlNjdWdySkdFVWdoR2VYUmltZzVjVVhBaWFXNzhT?=
 =?utf-8?B?Vk0zKzd5TCtVZ0kycWpmcTVqZCtSc0ZnbW4yN08xdUNNM0lXQ0FoOFRwUkhX?=
 =?utf-8?B?WHRGUk1VVll5dm1wdUNPd0pJT2ZCQ2R4VXlCaERqOEZ2SUxVWk9HeGJWaDVp?=
 =?utf-8?B?RnRjc2dmME9RM2tKRkg1djUrYXFOUUF3dm1hUnRjOGlLb3RCMHdPb0RIZXlY?=
 =?utf-8?B?R3ZHR3hUMmkvbUJLc0ZqMVpZR0RtZTlTSjk0R1NuanJlQnJjZXpwYjZnalhY?=
 =?utf-8?B?azcrbUVmbnZmR0RGa1hsWmZZTzkyeWVlbmtkZC9odXpWWTNGUjRHdEJhb3Vj?=
 =?utf-8?B?djM5YjZLYnR5Z3FEZVZvVUNoVXlFR3FCL1BKT1lnQlBqL0FwaDU2TVRVNmlv?=
 =?utf-8?B?Rm5vdGFxd09COEZiRjBTQ2lqUVNpZGNaYW1wQ09yQ1FMbDJCQisycTNGd2RB?=
 =?utf-8?B?MjBhdmhRV1gvcXl2SCt5S0ljSjN6KzhMN3cvRWFZNytiL2ZsTEpGdS9DOU1C?=
 =?utf-8?B?Y2NNVGhNTTllMktTay9VbEhoUFhXRjdnWlJtVERVNEN3V0x4T3hXZTA1dUZa?=
 =?utf-8?B?MTkxWUd6d1FMUkNnZFhXM2ZXWTBCSzJaVkpTZEFTZjhDTEswdUVFaXpoVVda?=
 =?utf-8?Q?a2JA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7c7851-3f4f-43e0-59cb-08db2b20653f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 21:57:14.0186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VqAqMckllOfFor78U1+EsGrmYwrkpoaVk9RAKb+OjJzpPh3MF6EcDu1APZtmVVd4A4tIIOvvsKLA92AbWkUqag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7777
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IE1hcmNoIDIyLCAyMDIzIDQ6NDMgUE0NCj4gVG86IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29t
Pg0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGZlc3RldmFtQGdtYWlsLmNvbTsg
aW14QGxpc3RzLmxpbnV4LmRldjsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBrcnp5c3p0b2Yu
a296bG93c2tpK2R0QGxpbmFyby5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJv
bml4LmRlOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTog
W1BBVENIIHYzIDEvM10gZHQtYmluZGluZ3M6IHVzYjogY2Rucy1pbXg4cW06IGFkZA0KPiBpbXg4
cW0gY2RuczMgZ2x1ZSBiaW5kaW5ncw0KPiANCj4gQ2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBP
biAyMi8wMy8yMDIzIDIyOjQwLCBGcmFuayBMaSB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGty
enlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBNYXJj
aCAyMiwgMjAyMyA0OjM4IFBNDQo+ID4+IFRvOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT4N
Cj4gPj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBmZXN0ZXZhbUBnbWFpbC5jb207
DQo+IGlteEBsaXN0cy5saW51eC5kZXY7DQo+ID4+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsga3J6
eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBsaW51eC1hcm0tDQo+ID4+IGtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgbGlu
dXgtDQo+ID4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsgcy5o
YXVlckBwZW5ndXRyb25peC5kZTsNCj4gPj4gc2hhd25ndW9Aa2VybmVsLm9yZw0KPiA+PiBTdWJq
ZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCB2MyAxLzNdIGR0LWJpbmRpbmdzOiB1c2I6IGNkbnMt
aW14OHFtOiBhZGQNCj4gPj4gaW14OHFtIGNkbnMzIGdsdWUgYmluZGluZ3MNCj4gPj4NCj4gPj4g
Q2F1dGlvbjogRVhUIEVtYWlsDQo+ID4+DQo+ID4+IE9uIDIyLzAzLzIwMjMgMjI6MzYsIEZyYW5r
IExpIHdyb3RlOg0KPiA+Pj4NCj4gPj4+DQo+ID4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPj4+PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tp
QGxpbmFyby5vcmc+DQo+ID4+Pj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAyMiwgMjAyMyA0OjMy
IFBNDQo+ID4+Pj4gVG86IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPg0KPiA+Pj4+IENjOiBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiA+PiBpbXhA
bGlzdHMubGludXguZGV2Ow0KPiA+Pj4+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsga3J6eXN6dG9m
Lmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBsaW51eC1hcm0tDQo+ID4+Pj4ga2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBsaW51eC0N
Cj4gPj4+PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IHMu
aGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+ID4+Pj4gc2hhd25ndW9Aa2VybmVsLm9yZw0KPiA+Pj4+
IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIHYzIDEvM10gZHQtYmluZGluZ3M6IHVzYjog
Y2Rucy1pbXg4cW06DQo+IGFkZA0KPiA+Pj4+IGlteDhxbSBjZG5zMyBnbHVlIGJpbmRpbmdzDQo+
ID4+Pj4NCj4gPj4+PiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gPj4+Pg0KPiA+Pj4+IE9uIDIyLzAz
LzIwMjMgMTU6MzQsIEZyYW5rIExpIHdyb3RlOg0KPiA+Pj4+Pg0KPiA+Pj4+Pg0KPiA+Pj4+Pj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+Pj4+IEZyb206IEtyenlzenRvZiBLb3ps
b3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gPj4+Pj4+IFNlbnQ6IFdl
ZG5lc2RheSwgTWFyY2ggMjIsIDIwMjMgMjozMiBBTQ0KPiA+Pj4+Pj4gVG86IEZyYW5rIExpIDxm
cmFuay5saUBueHAuDQo+ID4+Pj4+Pj4gKyAgICAgIC0gY29uc3Q6IHVzYjNfYWNsaw0KPiA+Pj4+
Pj4+ICsgICAgICAtIGNvbnN0OiB1c2IzX2lwZ19jbGsNCj4gPj4+Pj4+PiArICAgICAgLSBjb25z
dDogdXNiM19jb3JlX3BjbGsNCj4gPj4+Pj4+PiArDQo+ID4+Pj4+Pj4gKyAgYXNzaWduZWQtY2xv
Y2tzOg0KPiA+Pj4+Pj4+ICsgICAgaXRlbXM6DQo+ID4+Pj4+Pj4gKyAgICAgIC0gZGVzY3JpcHRp
b246IFBoYW5kbGUgYW5kIGNsb2NrIHNwZWNpZm9lciBvZg0KPiA+Pj4+Pj4gSU1YX1NDX1BNX0NM
S19NU1RfQlVTLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IERyb3AgdXNlbGVzcyBwaWVjZXMgc28gIlBo
YW5kbGUgYW5kIGNsb2NrIHNwZWNpZm9lciBvZiAiIGFuZCBuYW1lDQo+IHRoZQ0KPiA+Pj4+Pj4g
aGFyZHdhcmUsIG5vdCB0aGUgc3ludGF4Lg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+PiArDQo+ID4+Pj4+
Pj4gKyAgYXNzaWduZWQtY2xvY2stcmF0ZXM6DQo+ID4+Pj4+Pj4gKyAgICBpdGVtczoNCj4gPj4+
Pj4+PiArICAgICAgLSBkZXNjcmlwdGlvbjogU2hvdWxkIGJlIGluIFJhbmdlIDEwMCAtIDYwMCBN
aHouDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gVGhhdCdzIGJldHRlciBidXQgSSBzdGlsbCBkbyBub3Qg
dW5kZXJzdGFuZCB3aHkgZG8geW91IG5lZWQgaXQgaW4gdGhlDQo+ID4+Pj4+PiBiaW5kaW5ncy4g
WW91IG5ldmVyIGFjdHVhbGx5IGFuc3dlcmVkIHRoaXMgcXVlc3Rpb24uDQo+ID4+Pj4+DQo+ID4+
Pj4+IEkgYW0gbm90IHN1cmUgMTAwJSBzdXJlIHRoZSByZWFzb24uDQo+ID4+Pj4+IEkgdGhpbmsg
ZGlmZmVyZW5jZSBzeXN0ZW0gdGFyZ2V0J3MgIGF4aSBidXMgZnJlcXVlbmN5IGlzIGRpZmZlcmVu
Y2UsDQo+ID4+Pj4+IEFuZCBqdXN0IG9uZSB0aW1lIHdvcmssIG5lZWRuJ3Qgc29mdHdhcmUgdG8g
bWFuYWdlIGl0Lg0KPiA+Pj4+PiBGb2xsb3dpbmcgb3RoZXIgZHJpdmVyJ3MgY29kZSBzdHlsZSBt
YXkgYmUgYW5vdGhlciByZWFzb24uDQo+ID4+Pj4NCj4gPj4+PiBUaGF0J3MgdGhlIHJlYXNvbiBv
ZiBoZWF2aW5nIGl0IGluIERUUy4gQnV0IEkgYW0gYXNraW5nIGFib3V0IGJpbmRpbmdzLg0KPiA+
Pj4+IFlvdSBkbyB1bmRlcnN0YW5kIHlvdSBkZWZpbmUgaGVyZSBpbnRlcmZhY2U/DQo+ID4+Pg0K
PiA+Pj4gSSBkZWZpbmVkIGhlcmUgaXMgZGVzY3JpcHQgQVhJIGZyZXF1ZW5jeSBmb3IgdXNiIGNv
bnRyb2xsZXIuIFN1cHBvc2VkDQo+ID4+IGRpZmZlcmVuY2UNCj4gPj4+IFBsYXRmb3JtIHdpbGwg
aGF2ZSBkaWZmZXJlbmNlIHdvcmtpbmcgZnJlcXVlbmN5Lg0KPiA+Pg0KPiA+PiBJIGRvbid0IHVu
ZGVyc3RhbmQgaG93IGRvZXMgdGhpcyBhbnN3ZXIgbXkgY29uY2VybnMgb2YgaGF2aW5nIGl0IGlu
IERUDQo+ID4+IGJpbmRpbmdzLiBJZiB5b3UgZG8gbm90IGFkZCBpdCwgeW91ICJ3aWxsIGhhdmUg
ZGlmZmVyZW5jZSB3b3JraW5nDQo+ID4+IGZyZXF1ZW5jeSIsIHNvIHdoYXQncyB0aGUgcG9pbnQ/
DQo+ID4NCj4gPiBGb3IgZXhhbXBsZTogaW14OHF4cCwgaXQgbmVlZCBzZXQgdG8gMjUwTWh6LCAg
aS5NWDhRTSBuZWVkIHNldCB0bw0KPiAyMDBNaHouDQo+ID4gTWF5YmUgZnV0dXJlIGNoaXAgY2Fu
IHNldCB0byA0MDBNaHouDQo+IA0KPiBBbmQ/IFNvIGFzIHlvdSBjYW4gc2VlIHlvdSB3aWxsIHN0
aWxsIGhhdmUgZGlmZmVyZW50IGZyZXF1ZW5jaWVzLCBzbw0KPiB3aGF0J3MgdGhlIHBvaW50PyBX
aGF0IGlzIHRoZSBiZW5lZml0PyBEdW5ubywgbWF5YmUgd2UgZG8gbm90IHVuZGVyc3RhbmQNCj4g
ZWFjaCBvdGhlciwgYmVjYXVzZSBJIGRvbid0IHRoaW5rIHlvdSBhcmUgYW5zd2VyaW5nIG15IHF1
ZXN0aW9ucyBhdCBhbGwuDQoNCkJlbmVmaXQ6IE5ldyBjaGlwIGp1c3QgbmVlZCBjaGFuZ2UgZHRz
IGZpbGUgZm9yIHRoZSBzYW1lIElQLCBsaWtlIGNoYW5nZSBiYXNlDQpSZWcgYWRkcmVzcyBhbmQg
aXJxIG51bWJlci4gIA0KDQpZb3VyIHF1ZXN0aW9uIGlzOiAgIndoeSBuZWVkIHRoaXMgYXNzaWdu
ZWQtY2xvY2stcmF0ZXMgSU1YX1NDX1BNX0NMS19NU1RfQlVTIHByb3BlcnR5PyIgIA0KDQpNeSBh
bnN3ZXI6IGl0IGlzIG9uZSBvZiBoYXJkd2FyZSBwcm9wZXJ0eSwgbGlrZSByZWcgYmFzZSBhZGRy
ZXNzIGFuZCBpcnEgbnVtYmVyLg0KDQpJZiBjYW4ndCBtYXRjaCB5b3VyIGV4cGVjdGF0aW9uLCBj
YW4geW91IGNoYW5nZSBhbm90aGVyIHdvcmRzIG9yIHByb3ZpZGUgbWUgYW4gZXhhbXBsZT8gIA0K
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
