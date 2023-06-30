Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19033743511
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjF3Gb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjF3Gbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:31:55 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083A730C4;
        Thu, 29 Jun 2023 23:31:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fjg+P1ScwzdERJRLsy2bnAcsuS+8L3Ma89LVXu1CD+YuM7EC3UWc2yiw/m83fi9N4erYDeqi3/kqlTL3VoUAsaKE+7KFfG8nyvIwFsQW8B7QpvWHeMlUeUouZRDUFLD1H7DYYhG6M1tfVSmSp2tKn+d0wsSWJC9P6tsKnlYXYB8VSA5QIWGEzKjM+93qUK+jhAV3nkcsqqr9JwkCaePxMxkSsu+lxqTBw1DReoVbQTrdADTRIRfNHrq2GbGH2PjEJ+GfmM49AULvgpomLYNzL7VuNso62hOyj5MbciNo/xqJkRF0S9AE+RrPmoUmUnY6V4YuEc4juiG/Q5FPtnfLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XelsG0qtNVN+sWJqqlRmJNT5TsdFPn3JR7C8hIJf7N8=;
 b=PZxxXhQlhTK1IUYJZfI8w+DtFTUHjp54WF8XhUX1TV/sN1IIgLCaNR9gZ0O6KLmA7VH1iTCwva5ipgK2hd2TnpGnJ9eM1qG0Ml0bJ/fUk/HiQEqBFbPaC40GEigWJcVUW6xqwkrPYwOiI/EfbIPdP+voVqD1SThBrzJg9IbRY8/JL8Y3vJeS1lL9o66YAnzPHrSvwrxDHXMmjbrlo7tF0vg1tZ+U4T2zyw3sU0UGQ0iRjbxKYIVFkzZOCnwppru1XD7IvwdijcI+R6hW92OQKeg/nwiNmvh9CXzpkwy8KETgI7oq0oBFNVs54FfL28cyi58T7apO/iO0XrvW5lRsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XelsG0qtNVN+sWJqqlRmJNT5TsdFPn3JR7C8hIJf7N8=;
 b=Ood0PtFh/8QFLDxBSw5zON7NQ3llKUWdkqlICRQvxemqFRyHPO8vJ/Q3y2QY62LXQSEFNPTA2uSHEwBC1qbzSlBocZWaJanM/I2sPPNe9gN5rsVidINiffS083U4nZM4fBIIX3EmW4M8SS2GejxZ6JKNqS+XWdvhAVlyV7FLmk8=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PAXPR04MB9447.eurprd04.prod.outlook.com (2603:10a6:102:2b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 30 Jun
 2023 06:31:50 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad%3]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 06:31:50 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2 0/7] *** firmware: imx: NXP Edgelock Enclave
 MUAP Driver ***
Thread-Topic: [EXT] Re: [PATCH v2 0/7] *** firmware: imx: NXP Edgelock Enclave
 MUAP Driver ***
Thread-Index: AQHZcrogJPKfZjv0DkOEv2ZLfqLZea86htoAgGjMkQA=
Date:   Fri, 30 Jun 2023 06:31:50 +0000
Message-ID: <DU2PR04MB86301800B528D8A73BB8C18B952AA@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230419175538.855493-1-pankaj.gupta@nxp.com>
 <CAEnQRZD4-BofvpLaatbYnw3G7Mrs35ZiZsrRJmjrZA7qY_QbHw@mail.gmail.com>
In-Reply-To: <CAEnQRZD4-BofvpLaatbYnw3G7Mrs35ZiZsrRJmjrZA7qY_QbHw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|PAXPR04MB9447:EE_
x-ms-office365-filtering-correlation-id: b37c7a13-b769-4201-dbd8-08db7933afc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3fDNHZ1uus5da31eu0BUk4SqEWVV/unLxNn4gkg/yqZgnYi81B8POlKyHY2fLzYIC/RmQKQ4kEi3XFPZ9uDdsr654NV51I+Pog12gL8dz3VHCNwMjvKQ3cIOSDkmKFwngZyqjrKI5RseQyKj4avlaVJqPWVXO95SXLSHLIYVXg2eBL6SqBr51Zq56nFrDsSI0iVWN4VG0qQJmy72/CV0vPRnO86ybt7WwIb4M/pwZG06Z/X2iYUrBOe2x94zWgPtv3xqDwCjfBQ5pSQ1nyum+0nbSl+C7CjxGNMncc2CjPTMKrlmOipfPN9Oq013qQUJjwS6IaQn8KEkSi94KvJfQ6vAEE23SG1vhl/q/JNsN1xmBNOjHyoI70145vcHw9uPD5N1FEbmutOdq6+hBuBBGDzrOc+ISojO93Uo3F7OcX3qHY1Pym0riT+yFbf79BHkIQRrehXf/TnFaf0Ugf8b1AngF0gjEu2YgdOtJb77h0J7MsHuIgptN06PCe8uSiNCPMwKGSLCsOhk6qau0UGMLNyEKV2LroXzawQ8H3UdIxc1tiEPveeF0zghGY/EySUGgt0DLw8U4QmhLGbO1rqYcakqvevieQnfaVfSpb/xEe6NOg9OICW7ihpxArwGGVZ+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199021)(38100700002)(122000001)(38070700005)(83380400001)(33656002)(86362001)(54906003)(7696005)(478600001)(71200400001)(76116006)(66476007)(316002)(55016003)(8676002)(4326008)(66946007)(41300700001)(66556008)(8936002)(6506007)(53546011)(9686003)(6916009)(26005)(66446008)(186003)(64756008)(2906002)(52536014)(44832011)(7416002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE92VTg3dTNmNWFjbG1iWGcxb0JOVlFrOW85bEthSEJSSkFGRDRpUU1KMVZk?=
 =?utf-8?B?cXJTVWh4dnJyeG9NU283dXZUU1RTZFdsTFB6QXZaTnluUjFBS1JRZERyc3pW?=
 =?utf-8?B?VDlTME5jYnlNZW5rRW5scURjWkxheWF0Y1huVHd5RVBWVE1YMG5pZGliTEkv?=
 =?utf-8?B?S3lKb1J6aHJKdnU2amJ4QVRFWmJ2alMzUm5CWnVaWTFla2oxN3FpNnhWNTUy?=
 =?utf-8?B?NDhPdWZhM0FNZkhiYzR2UnVoUGo4QTg4Sm1kYzlUVkxTdWxKaFpiZDIvbTZx?=
 =?utf-8?B?cVl6VFNYYzVaUE4wbENYSWZya1dmUUpZQU4yeG02V2xqYXJMVGJGNS9sNkdD?=
 =?utf-8?B?WkhucklFMy83ZzFRTmNSRHpHWHVDZUxGOXhwYlJONDEwejY2cUpmQmVyZ1ZH?=
 =?utf-8?B?aW41RzQvcVpyY3R5VCsybWVJcXViVzdRbm9yRlB5cE1iMnBKOTF6Vlo5dFk4?=
 =?utf-8?B?N1hYM2tLcGNReWp1SkRqeG1qRE0ybi80aE9Bb29UQXRqeVpVdEdTVmRaRHk3?=
 =?utf-8?B?Z05mU0QwdzRPc2lhWmJSNzlTYUV3bVErK3RDaVFwbFNkb3UxQXQ4eHYvM2dv?=
 =?utf-8?B?SnhkZEhGTlJ6eFJ4N1FZWk15QStmb1grWEZpeGZBbkR6U1BiMWFOSkcrVXhK?=
 =?utf-8?B?eWZpcG5YZ3FiOFFLalo5TzgrajR0MXJDbWVEMlpKWEV1VCtXMzNjQmI2ODdC?=
 =?utf-8?B?MkZQVFlaeWszZXFlTGlJdWhOR0tsbTNYYzBZUEorai9GMUNMREZ1S3BNYnFO?=
 =?utf-8?B?ek1hcmhjZWJkTlE2MmdFN3d1allCdDZESlM0Mm40azZvcUJFdWpyWnNPMUgz?=
 =?utf-8?B?TWdrVXBadUlFRTZXdjdoL2pRK0RCUERxVnBaNDBFeThqUUh4b1JzMS9iVjRs?=
 =?utf-8?B?cm9uUVQ0RFdqOEtDRDhrL1YwcFc5ZTBVWlZoYldYcVJPNlNERTVaNFZ0TGF6?=
 =?utf-8?B?WTJheklhNmVPVzZNczVYNDhNUk1vWEYvbElzY2RiNnZBUFd3SCtrYWEwam5s?=
 =?utf-8?B?N0lRY0lwNGxtRFBPVjBEd2VHbUs2d3YrWnA3TExUSnV1ZWxWZjZqZjMrSTEx?=
 =?utf-8?B?cFlwOTRtbU0zT3BwaXl1M25rN3pVeElyc3d3SUpVeTRSMEd2M2ZRcy9KR25O?=
 =?utf-8?B?SjFsaWF4ME9uazlNaTNWK24vWFZicUdEcC9MQzlFV1M2eWlMMnhKZncvR1hk?=
 =?utf-8?B?L3RUMlVCVVFnd0l6dXBiQm1CbXFTcERiYkRCMGdKYTJ4NmVaWUErK1lSL2s2?=
 =?utf-8?B?bHFFTFV3WDRSQkRpckYrWjlUblphOExWQXBUZGZEL29SME9oS3oxRS9EdXNS?=
 =?utf-8?B?ZVp2MEZlVWVuakZMcmhaejJYZUVoTEQxc2RWQlV5WVRCU3NoQkJLcVQ3aWMz?=
 =?utf-8?B?VzN1ZmNjWGtBOTVhZTNKcVM4bnZDcXNkcUtWZXFhNmIzUWNxN0w2aGZ5c3Bx?=
 =?utf-8?B?V3VUQkxYM3M1THhUY1Rqcy9iUFpyNWVianVXNnZKdGIvd2d2aDg2T09EUGg0?=
 =?utf-8?B?SGd6akZCNEJGTW5UczFJTjYxOWM0bEVla0hPREJwUmVrcEYyVUFOL3dVZUJK?=
 =?utf-8?B?NENuOEJpdXZkdWozbDFRNlgxV3l3OTM5M2xlWHFxMis4dDJtK3NEeUtoU2gw?=
 =?utf-8?B?UVBMeXpaVDhvcTVKNkZ5M2VvM2ovemM2RXZDejROaG14TGlzYTVXNXNQZVY0?=
 =?utf-8?B?ejUzY21FUXJSZy9rQ3cvVFZhNnNNc3UzS2s4QndnZ0ltb0FtMmdrOS9hUUE0?=
 =?utf-8?B?L2VhOG1ySjJ5YlhFZ0dQUHNEYy9HWXptQ2VwWGpCR21jejd3NzlWaU9ROWRx?=
 =?utf-8?B?NnAvaXkybFdIK0FFbHVzYzlvNXNlei80R2tWWmdPNDIxQlRQYWlOQ1VxNytM?=
 =?utf-8?B?bkhWZ0loVGpNMStHMFhSZERRVTlYejk3RDNhRFpzUjlnTXR5RGFXK3JlTTgr?=
 =?utf-8?B?RWFZTVRTWm1PZUZwNGVUNEZDZ1RzNnJRaHNIbUU2a2V2VmlQanJkTDAyc2lO?=
 =?utf-8?B?UnhkYXJHekZDT2ZJWk9ZT0tVdmhHRGNCNUFadjhoZTczbFJScjc3OVpxZ3dy?=
 =?utf-8?B?UGpic3dicGFGY3Y2MEpDazhyMW55OWZmd3kxNzZ0dVVIVkZ6cjZwSHcxOU9Y?=
 =?utf-8?Q?l+g0rkKjn+HNn4/2rNvfSeJwU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37c7a13-b769-4201-dbd8-08db7933afc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 06:31:50.1583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K6WOul/dhtg76hKe4FtXLBlMeRyfbgh9ZqbDkrhLQspwXtvkMb5738oFDIHrCq3v/x90yemPoe6NBYhyZUsing==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9447
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsLA0KDQpBcyBkaXNjdXNzZWQgYWxyZWFkeSBvbiB5b3VyIHF1ZXJ5LCAgYW5zd2Vy
aW5nIHRvIHRoaXMsIGZvciBldmVyeWJvZHk6DQoNClRoZXJlIGlzIG5vIGV4aXN0aW5nIE5YUCBN
VSBkcml2ZXIsIHRoYXQgaXMgdXAtc3RyZWFtZWQuDQplbGUtbXUgZHJpdmVyIGlzIHVzaW5nKGRl
cGVuZGVudCBvbikgdGhlIHVuZGVybGluZSBJTVhfTUJPWCwgZHJpdmVyIHlvdSBtaWdodCBiZSBy
ZWZlcnJpbmcgdG8uDQoNClRoYW5rcy4NCg0KUmVnYXJkcw0KUGFua2FqDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBn
bWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgQXByaWwgMjQsIDIwMjMgNzozOCBQTQ0KPiBUbzog
UGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGFAbnhwLmNvbT4NCj4gQ2M6IHNoYXduZ3VvQGtlcm5l
bC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsg
ZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXggPGxpbnV4LQ0KPiBpbXhAbnhwLmNvbT47
IHJvYmgrZHRAa2VybmVsLm9yZzsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0K
PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBHYXVyYXYgSmFpbiA8
Z2F1cmF2LmphaW5AbnhwLmNvbT47IFNhaGlsDQo+IE1hbGhvdHJhIDxzYWhpbC5tYWxob3RyYUBu
eHAuY29tPjsgQWlzaGVuZyBEb25nDQo+IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IFZhcnVuIFNl
dGhpIDxWLlNldGhpQG54cC5jb20+DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjIgMC83
XSAqKiogZmlybXdhcmU6IGlteDogTlhQIEVkZ2Vsb2NrIEVuY2xhdmUNCj4gTVVBUCBEcml2ZXIg
KioqDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IE9uIFdlZCwgQXByIDE5LCAyMDIz
IGF0IDM6NDXigK9QTSBQYW5rYWogR3VwdGEgPHBhbmthai5ndXB0YUBueHAuY29tPg0KPiB3cm90
ZToNCj4gPg0KPiA+IHYyIENoYW5nZXM6DQo+ID4NCj4gPiAtIEZpeGVkIEtlcm5lbCBUZXN0IEJv
dCBpc3N1ZXMuDQo+ID4gLSBSZW1vdmVkICIuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94
L2ZzbCxtdWFwLnR4dCINCj4gPg0KPiA+IHYxOg0KPiA+DQo+ID4gVGhlIE1lc3NhZ2luZyBVbml0
IG1vZHVsZSBlbmFibGVzIHR3byBwcm9jZXNzaW5nIGVsZW1lbnRzIHdpdGhpbiB0aGUNCj4gPiBT
b0MgdG8gY29tbXVuaWNhdGUgYW5kIGNvb3JkaW5hdGUgYnkgcGFzc2luZyBtZXNzYWdlcyAoZS5n
LiwgZGF0YSwNCj4gPiBzdGF0dXMgYW5kIGNvbnRyb2wpIHRocm91Z2ggaXRzIGludGVyZmFjZXMu
DQo+ID4NCj4gPiBUaGUgTlhQIGkuTVggRWRnZUxvY2sgRW5jbGF2ZSBNZXNzYWdlIFVuaXQgKEVM
RS1NVUFQKSBpcyBzcGVjaWZpY2FsbHkNCj4gPiB0YXJnZXRlZCBmb3IgdXNlIGJldHdlZW4gYXBw
bGljYXRpb24gY29yZSBhbmQgRWRnZWxvY2tlIEVuY2xhdmUuIEl0DQo+ID4gYWxsb3dzIHRvIHNl
bmQgbWVzc2FnZXMgdG8gdGhlIEVMIEVuY2xhdmUgdXNpbmcgYSBzaGFyZWQgbWFpbGJveC4NCj4g
Pg0KPiA+IFBhdGNoLXNldCBhZGQgdGhlIEVMRS1NVSAga2VybmVsIGRyaXZlciBmb3IgZXhjaGFu
Z2luZyBtZXNzYWdlcyB3aXRoDQo+ID4gaS5NWCBOWFAgRUxFIElQOyBib3RoIGZyb206DQo+ID4g
LSBVc2VyLVNwYWNlIEFwcGxpY2F0aW9ucyB2aWEgY2hhcmFjdGVyIGRyaXZlci4NCj4gPiAtIEtl
cm5lbC1zcGFjZSwgdXNlZCBieSBrZXJuZWwgbWFuYWdlbWVudCBsYXllcnMgbGlrZSBETS1Dcnlw
dC4NCj4gDQo+IA0KPiBXaGF0J3Mgd3Jvbmcgd2l0aCBleGlzdGluZyBOWFAgTVUgZHJpdmVyPw0K
