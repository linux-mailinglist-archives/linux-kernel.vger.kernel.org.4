Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2BD7092D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjESJSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjESJSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:18:07 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2044.outbound.protection.outlook.com [40.107.15.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D8510F3;
        Fri, 19 May 2023 02:18:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DD57bDQf+W8ASYvI5UHG05/KBbPpLSEqNL7Mo6Zoj8hn4BIwGLtlirZ4Bbd7V9Zm6Q5JX6evylBC8m77dwsW0SRCTD37sJhClx1G0rkIy42SgFqbMg5VcalOAMrnxb+HdQCEXeLtqJ94Y+6LDqTSM0c0u6RiezVyWGF8+CR5SuHlWpXajhvV7+KnbCkplYiNoUSTpOOut2h4D5cLQkkYbYAAcKQ6DPsFC75iXpz7JzFNgWEBntMttwtzJ+JNVFcc7r7wWdTzVeU1HQFV1/zQsWmIV/eH8Go8s9NIXzyensC0r8z8tfgg8LIo2KvELGuC8jDY+oUf7TVkoF0IToMCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiyYwJq4DOKS6Iim/lJ8vXSeBASz6J5nEgStqIcVcZs=;
 b=GaUQTivnYkTvIQ5ZDrb/kL/SIqE1QjSrlDh3wGWyfQxHrpUeLrLFI2cS7epHUGmZDccTaA5Kk8A7CrRbn/2CXlYQ/6y9y59KXhXgPQ/zLZjDMlgxNSlCrNRPxAIoX72GaZ2vHIP/g3ye9wRRJ+Sn/mKBlXz+IeM1jFjv62YJ14H2S4bAafpnZ5wVYqvBxrLwr5vYF6DNXwDR+M0SgYBM3l4gKTNIopGmDw+W6K2LGcGfrjHIU2UXS0KgSLx77ZFlo9thxTJ2y+Sp+CCvYrIxoutl8/2RgShkacXNWAEt5UVEmL2IQ/CvAY9lmT1cvmJvIwDYcYA83ptShnMH0PHDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiyYwJq4DOKS6Iim/lJ8vXSeBASz6J5nEgStqIcVcZs=;
 b=LnSXj9DTWvbVpT6W2WRtk6jLdI68nTLqzIyKdvRoxxV3QHCHAunzlAZQO8+aPBpRoZwmc652uybrFKg3DUVO2aPtY1DAbAWH4OKo2+sHeEtLuDJxHfjgwgJcLYg/UdKTRTZiY/JV6t6BbbD+k40hQqRUpr15IrlAaaFStV2/KpY=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAWPR04MB9959.eurprd04.prod.outlook.com (2603:10a6:102:387::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 09:17:59 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::e1cd:e733:d3aa:ea49]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::e1cd:e733:d3aa:ea49%7]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 09:17:59 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: make sure to turn off break
 before enabling CTS
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: make sure to turn off break
 before enabling CTS
Thread-Index: AQHZh99s8RWAVNtMX0y0/1fbxEQUmq9hVVyg
Date:   Fri, 19 May 2023 09:17:59 +0000
Message-ID: <AS8PR04MB8404282ABF1BADCB551D66BC927C9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20230516101138.24179-1-sherry.sun@nxp.com>
In-Reply-To: <20230516101138.24179-1-sherry.sun@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|PAWPR04MB9959:EE_
x-ms-office365-filtering-correlation-id: b0e4c31d-0fda-4902-79f4-08db5849f08b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5XfwCUaUbqrVs3uaqoGDsJQMVyiZqTYm9HPWIPRfLnqyE0nT3JbGSbyv2SqSRkfbpHZdL0yWxd1zqu755AGQAhpP9cSQiaYah7JE5tu8DAYxa13n3sBlCHqdyuXUwNR60HYwvmlmwDID3WZG20u9AJIbBO2SJQmNtw0f2Qwpgr8C5te0lPJveLaTVuH4n8FXz9oc8q50ejXh8flpTx6ib3jC4XtyMqh3sW8QUR5KAhTneGuFWyHPCxHBN48BiVMxq3gyZstxRuABDup4bRjRS3cCKaItVl/vgmmgZw6f3kHKoy8nc9g5SZqeCHLKG4mmTJjSXfx8vtLqr0Bn+RKmkPeLH4JsBrn9gQyy+PKYdB9Qg/7rWAzF/I/c0gPA6dZBgAy3lk2UMAkYZ0aBgTklEuD/Nrn6inKsTEhLlgWYOKt3lEsTY2/kzbA+tSH7S7Y+M1lmy4lfrHLGDVtnHKe/ElFcFCQ3rWl1/aLs8N1o+YuZv8CArbOVb/sQz9KW6fhVLcyZibhXVJiO8wjjFTb4th5k8MadmKBV4EHg92PRSSkcu4bXJhxfcd68WI3puRj2XHIA+pFXWVTnnsWZIy9Bl9YmlcbthzcFVmCavYXEEN5LyNlzxdNdgY16XVr+SnIz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199021)(86362001)(83380400001)(8936002)(8676002)(2906002)(66446008)(4326008)(66556008)(66946007)(66476007)(76116006)(38070700005)(478600001)(5660300002)(52536014)(41300700001)(54906003)(44832011)(110136005)(64756008)(316002)(38100700002)(122000001)(7696005)(55016003)(6506007)(71200400001)(186003)(9686003)(33656002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?L3ZQd1lCaVZ6K3pha0lHZ3hzWDRWTmFpMDZjczVRcFlzZUpLa3hSME1xeUZL?=
 =?gb2312?B?YzNKclRuY1dyVE5POTA4V1hOV1laNFZvMWNRcWJrdmtuT0FsQ28xQVRURGdw?=
 =?gb2312?B?TXpVc0xjR2RWREQvUms0UCtXcWx5TG9RQjRpOFdkZ3FKaVR6cDhsdm1zd0p4?=
 =?gb2312?B?M2RUc0pKbVJCVjJ5Z2lHeEZNbVNQY2VobngwVFE1cjhMblF5RUlmOTVCTXI4?=
 =?gb2312?B?VER6VjJsalFvVUhWcHRMSkVEaWNvOU16bnMrSDNsSStSL1EyZkQrT2RrWXJl?=
 =?gb2312?B?d2xvdEY5eU9tUlM1MGNEUGhUWkpXaStLKy83VmZTdTQ5N00wZTZQNVh3YnVX?=
 =?gb2312?B?b1FtejFNMVc3b1V2ZTgyaWFpQ2tqaDQ2MHZYc0wyQjJZbkdhWklsZXR6Z1Z5?=
 =?gb2312?B?TiszejBaZkRNbmNuTXdDTk1OZnVUU2NkL2xmdzVBdFJYRTFQRkQwazFTTWdL?=
 =?gb2312?B?OXFwUkZLTVR2R0NkVXBRbzZJUlBZSTBFU1hzRER3MlhmR0NLV25pdmZUV1RI?=
 =?gb2312?B?OHppRTJKSnl3bzJQU0VMNWNEQTdidGxZamh4MzVoWWdOR29yTWhKT1VFdi9C?=
 =?gb2312?B?QUNQUGZzRGdPNHZ0b2VpUER0RGNraE5rQUErVFNNdTQ2cEhRQ25Hay95VEs2?=
 =?gb2312?B?QjdULzVtYm9PVGFwQks1anVUS2s3WE40RzU1aG9iNC9xcEd3MTFGa1gveU01?=
 =?gb2312?B?aFVESEtHYjVLb2ZsT000WDlia2NpQThUaEdrM3RnRTZQOWVMdllyZ1JJRk94?=
 =?gb2312?B?MjZOZ016TXMwUzM1UFFFZE9uS3hObGYvMFU1MFk2aXQvaklsTjlsMlpjMGlU?=
 =?gb2312?B?OTdETGJWc2ltakM2SjVoQ1pPZTA0RnI5UFgrK08rUU1aT0hQUUd6U1Rmcng2?=
 =?gb2312?B?bnAzbXlRN3l5SlNTd21tb29jM0Y1VnhGN1NVSEFpQXZQU1BSMGNLdndBMUg1?=
 =?gb2312?B?ZkFFVFpZSmxycEgwOThuQmErcUxQOCsrWEk0OVF4UTdjOUs2SXdyOWprZ3Bw?=
 =?gb2312?B?ZzJuNmlVVWZ0alE4NHUxelllbm5wWkJhRTVqOXo2L2VJeUI3bUdRUEhnMUl3?=
 =?gb2312?B?ZUtBa2lCR1ArM2dLYjg3MUdMTUw0Kzk2cld5MzR1OEJYcDVCckZ5dEZSYllE?=
 =?gb2312?B?YnRCMk5HbFlwKytoR1RPblkyaFhXUU9lRlBCMFIzSWFxTVUvVE1lUUlDblBT?=
 =?gb2312?B?R1pKV1lXQTM4VzVEcmNYN1NRTUUyVHVReFB0dW9HVmhYQURzcHY3SFBuY0Zv?=
 =?gb2312?B?YWxuQURHUGI0a2VBZVR6VGJ2c25aZVRyOXBLd0NwREFLTGQ3NHhhUGRHaWI5?=
 =?gb2312?B?cm9pcTRNNXJjcDNkYU1GTzlramlxdVpvMzJGUjhzSEY5YndPK2FMbDhXdFll?=
 =?gb2312?B?bDhUcXRMaGxHeWNMSzF1RE9wU3h6Tm9PUlEwNmZsZndicVphSzkvNWVjMFRG?=
 =?gb2312?B?eHVnZWd4NUpPU1V0ZjMxV1dzQ3pINUlHR3ZKOGNETnBsc0ozbEV3Y0IvcGp1?=
 =?gb2312?B?ZlJmU1F0SGQzeU4xYzE1RXR1cDVKWWJsS2xZNXdZN0J2K3RYRXpoSUcvMkpU?=
 =?gb2312?B?a21kRFNsVHc0YU56ZW1LYWZMRnhyUVJDWkxqcXB2V2ZVcW1mL2o5VU41Q0lF?=
 =?gb2312?B?OCtqSmpjVkZMSkppWGdtbkhoYUJRanJZOHo0TC9ON3pXcGhHb0pIelJGajFa?=
 =?gb2312?B?ZWM3ZGV0RjlyOEM3aUJTWHF4eUpUZytqalNaMXhTVmhRdFZWRmxpUlF0Q1h0?=
 =?gb2312?B?NjRmd2hrK2hNNk5QNGlmVXBla1BwUGRJWGdaUVRDc3pnbjlkYmRBTHREaVJ2?=
 =?gb2312?B?WEJBcm42Y01oNmR6WGdZOWl3M2Y0bFYyMFlnVUdCakNZY1NzK0UwcC9jRWJB?=
 =?gb2312?B?L2p0Zno2SjFCNFkrWjVOOEEvekxGam5idENjYU5GeXZuWnhWS1J3SWp4SGhy?=
 =?gb2312?B?dDdENmp2ams2MHNlbmQ4QlZVblNvZkhwbmQ5bG5sNldkM05XRHZwQzVTV1NF?=
 =?gb2312?B?TkY3bWFuQ0NnS1YzWjVja01sYmpKT0JWdnluOHNIKzNtcDBVeng2QitLSjNy?=
 =?gb2312?B?ZFdWVm1xTzFLUnVGY0tFZ1AzeXlXM1kyS3RUdz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e4c31d-0fda-4902-79f4-08db5849f08b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 09:17:59.4020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Gtmo2MI4gsv8UyhWyfCws+G5GrLLJEfWtUzqhYFW/fBo01je3X4xenSI2eX6tc3cwkX1sSvKrIMHKRuPgztyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9959
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnksIHBsZWFzZSBpZ25vcmUgdGhpcyBwYXRjaCwgd2lsbCBzZW5kIGFub3RoZXIgcGF0Y2gg
dG8gZml4IHRoZSBscHVhcnQgYnJlYWsgaXNzdWUuDQoNCkJlc3QgUmVnYXJkcw0KU2hlcnJ5DQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNoZXJyeSBTdW4NCj4gU2VudDog
MjAyM8TqNdTCMTbI1SAxODoxNg0KPiBUbzogZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGpp
cmlzbGFieUBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBu
eHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIHR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0OiBtYWtl
IHN1cmUgdG8gdHVybiBvZmYgYnJlYWsgYmVmb3JlDQo+IGVuYWJsaW5nIENUUw0KPiANCj4gRHVl
IHRvIG9uZSBMUFVBUlQgSVAgYnVnIHdoaWNoIHRyZWF0IHRoZSBDVFMgYXMgaGlnaGVyIHByaW9y
aXR5IHRoYW4gdGhlDQo+IGJyZWFrIHNpZ25hbCwgdGhhdCBjYXVzZSB0aGUgYnJlYWsgc2lnbmFs
IHNlbmRpbmcgdGhyb3VnaCBVQVJUQ1RSTF9TQksgbWF5DQo+IGltcGFjdGVkIGJ5IHRoZSBDVFMg
aW5wdXQgaWYgdGhlIEhXIGZsb3cgY29udHJvbCBpcyBlbmFibGVkLg0KPiANCj4gU28gY29tbWl0
IGM0YzgxZGI1Y2Y4YiAoInR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0OiBkaXNhYmxlIHRoZSBDVFMg
d2hlbiBzZW5kDQo+IGJyZWFrIHNpZ25hbCIpIHRyeSB0byB3b3JrYXJvdW5kIHRoaXMgSVAgaXNz
dWUsIGl0IGRpc2FibGVzIENUUyBiZWZvcmUgYXNzZXJ0aW5nDQo+IFNCSyB0byBhdm9pZCBhbnkg
aW50ZXJmZXJlbmNlIGZyb20gQ1RTLCBhbmQgcmUtZW5hYmxlIGl0IHdoZW4gYnJlYWsgb2ZmLg0K
PiANCj4gSGVyZSB3ZSBlbmFibGUgQ1RTIGJlZm9yZSB0dXJuaW5nIG9mZiB0aGUgYnJlYWssIHRo
ZXJlIGlzIHN0aWxsIGEgcmlzayBvZiB0aGUNCj4gYnJlYWsgc2lnbmFsIGJlZW4gaW1wYWN0ZWQg
YnkgQ1RTIGlucHV0LiBUaGUgY29ycmVjdCBzZXF1ZW5jZSBpcyB0byBkaXNhYmxlDQo+IENUUyBi
ZWZvcmUgYXNzZXJ0aW5nIFNCSywgYW5kIHJlLWVuYWJsZSBDVFMgYWZ0ZXIgYnJlYWsgb2ZmLCB3
aGljaCBlbnN1cmVzDQo+IHRoZSBicmVhayBzaWduYWwgd29uJ3QgYmUgaW1wYWN0ZWQgYnkgQ1RT
LCBzbyBmaXggaXQuDQo+IA0KPiBGaXhlczogYzRjODFkYjVjZjhiICgidHR5OiBzZXJpYWw6IGZz
bF9scHVhcnQ6IGRpc2FibGUgdGhlIENUUyB3aGVuIHNlbmQgYnJlYWsNCj4gc2lnbmFsIikNCj4g
U2lnbmVkLW9mZi1ieTogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiAtLS0NCj4g
IGRyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMgfCA3ICsrKy0tLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9m
c2xfbHB1YXJ0LmMNCj4gaW5kZXggMGU1NmZhNjRiNGNlLi5kOWU0NmY3YjgwZTUgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMNCj4gKysrIGIvZHJpdmVycy90
dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KPiBAQCAtMTU1MCwyMCArMTU1MCwxOSBAQCBzdGF0aWMg
dm9pZCBscHVhcnQzMl9icmVha19jdGwoc3RydWN0IHVhcnRfcG9ydA0KPiAqcG9ydCwgaW50IGJy
ZWFrX3N0YXRlKQ0KPiAgCW1vZGVtID0gbHB1YXJ0MzJfcmVhZChwb3J0LCBVQVJUTU9ESVIpOw0K
PiANCj4gIAlpZiAoYnJlYWtfc3RhdGUgIT0gMCkgew0KPiAtCQl0ZW1wIHw9IFVBUlRDVFJMX1NC
SzsNCj4gIAkJLyoNCj4gIAkJICogTFBVQVJUIENUUyBoYXMgaGlnaGVyIHByaW9yaXR5IHRoYW4g
U0JLLCBuZWVkIHRvIGRpc2FibGUNCj4gQ1RTIGJlZm9yZQ0KPiAgCQkgKiBhc3NlcnRpbmcgU0JL
IHRvIGF2b2lkIGFueSBpbnRlcmZlcmVuY2UgaWYgZmxvdyBjb250cm9sIGlzDQo+IGVuYWJsZWQu
DQo+ICAJCSAqLw0KPiAgCQlpZiAoY2ZsYWcgJiBDUlRTQ1RTICYmIG1vZGVtICYgVUFSVE1PRElS
X1RYQ1RTRSkNCj4gIAkJCWxwdWFydDMyX3dyaXRlKHBvcnQsIG1vZGVtICYNCj4gflVBUlRNT0RJ
Ul9UWENUU0UsIFVBUlRNT0RJUik7DQo+ICsJCWxwdWFydDMyX3dyaXRlKHBvcnQsIHRlbXAgfCBV
QVJUQ1RSTF9TQkssIFVBUlRDVFJMKTsNCj4gIAl9IGVsc2Ugew0KPiAtCQkvKiBSZS1lbmFibGUg
dGhlIENUUyB3aGVuIGJyZWFrIG9mZi4gKi8NCj4gKwkJbHB1YXJ0MzJfd3JpdGUocG9ydCwgdGVt
cCwgVUFSVENUUkwpOw0KPiArCQkvKiBSZS1lbmFibGUgdGhlIENUUyBhZnRlciBicmVhayBvZmYu
ICovDQo+ICAJCWlmIChjZmxhZyAmIENSVFNDVFMgJiYgIShtb2RlbSAmIFVBUlRNT0RJUl9UWENU
U0UpKQ0KPiAgCQkJbHB1YXJ0MzJfd3JpdGUocG9ydCwgbW9kZW0gfCBVQVJUTU9ESVJfVFhDVFNF
LA0KPiBVQVJUTU9ESVIpOw0KPiAgCX0NCj4gLQ0KPiAtCWxwdWFydDMyX3dyaXRlKHBvcnQsIHRl
bXAsIFVBUlRDVFJMKTsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgdm9pZCBscHVhcnRfc2V0dXBfd2F0
ZXJtYXJrKHN0cnVjdCBscHVhcnRfcG9ydCAqc3BvcnQpDQo+IC0tDQo+IDIuMTcuMQ0KDQo=
