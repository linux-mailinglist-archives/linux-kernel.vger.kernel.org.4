Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34214736775
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjFTJQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjFTJPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:15:34 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2109.outbound.protection.outlook.com [40.107.114.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062421727;
        Tue, 20 Jun 2023 02:15:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFg162KIDcHfSjIJLejbQGDKf6WNa/cf4chUlENM51nwD2yUyr69J5uDKFCKL3J8K+BTSMAEeUwf2pWecfvVJ8+PDXqQRDmxT8AHzrK1fgMcFi35iQCHWgXLzf02v7mnyA2xMlf0HzLrrszlrEVaemQh8x0O6sZFLHsrP8I0EDYxUKsf9eHAPEXY2Zc7gJAkFmIvzdV3WpAy43hOtZ5CxolUrdwyoA+sn2s2Jk6/keT6eg1i+hSlCK6j/CLZ7jaCAMPG0dm18ypeiDsL/4BwbOIAtTBsK518t5dXGTanEkqlpg/fAkSS1KMORwMaPZGs8Ce6sB9GqqC2YA4hNYoeKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0OEjnfUU6NmEhkVJ1OnL5qcxZUcrmzfE1EL4o8U75Q=;
 b=hFY5IH/x1yPXF1mT3XeX+2VI7Q3YU+f7v7TfVuraOXRGdnzNwdY0PSCLyOUkG2CN0W34PPvEMdVdV0TsLk5hxVZ626AAf0I9/madXDodYIBu9NGDnxY79agNY4p3IF+5C3l+927cto14+UPnuCWdgxb4r9jrJfjlyhDI8SzLE902B37RLAYLnidExZ91RAyAXtMNpnYKYRmNPWM9J8DiYtceQ6djHm96rorEPpmpw/RJpizBcihJ7xoOCXNKtMEfcaiqS4dRxOAL6EaGC25JH0j4PxTDnC6DlV03lVbdfW3Jrzh9XO7QcvsynlOk3HisBoNPUmyrcww778ejFBjPlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0OEjnfUU6NmEhkVJ1OnL5qcxZUcrmzfE1EL4o8U75Q=;
 b=FC3YcsgQml7GxDkjqbnr8p4wCuD04ztTnb6HKxjKzvr7AD5ni9XNIQNBK21xyFEgKhQ84ic2cY9w9LiPVvZ/bSN7Geu/lPPW2ca8pOLiSK6ftbHyXVV7xGZ3/RC+F8MLs6WCHHWU4IURBEMynpMenGi9A7fJyBjGZyJCeix4EjY=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS3PR01MB9414.jpnprd01.prod.outlook.com (2603:1096:604:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 09:14:16 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:14:16 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>
Subject: RE: [PATCH 6.3 000/187] 6.3.9-rc1 review
Thread-Topic: [PATCH 6.3 000/187] 6.3.9-rc1 review
Thread-Index: AQHZoplTEH7iMOaua0SNAy8OlPDRGK+TabhA
Date:   Tue, 20 Jun 2023 09:14:16 +0000
Message-ID: <TY2PR01MB37889B99B900401368752AA3B75CA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230619102157.579823843@linuxfoundation.org>
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS3PR01MB9414:EE_
x-ms-office365-filtering-correlation-id: 968069e9-0075-454a-f777-08db716eb8db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tyuRAUgjJG068sgPEn1SGv0f0bFifg20dF7zQEr3oNQ2eoiq/xd7H1/CHANbEiXZVu/Rn1dwJH0AK6lx9PP87JJOIDB69HEVahGhtr5OVhyoQDQgHaFTwkUsDsHN+C0nrnb9fgssUHGS9GePkF8mOqPBkL7L7NOG91aHFEOgbUM6+rid8QWBwK4Sek7HT7PYGDDMguTLXdeMYENMbOI/7SZ3r+N6hdC8XhHtU9gxGHbTnSa3Qlt5+kgQAU0dOnzqHJZZ48usT2+FWiHCUDm/w8UD/hGSZ2jP1CQsWjMT4KylBq1yzWFA+SJ/rilCYubA170YBHrVmMf0vWhlpybdqM/a+ZCjD1T/m+1Iz2+OtYKQXMak24oo3PJH9nZiaHU9EnMR3hd7KXNXU9crAQLJyb3uPQ/eZJmBm14lbCNH+x1x0cNgf2F4nHbzWollJQDr/om23H6IskNQJZH/xMO/NaSheH5i7lT5BrqR0rSofhUZdrGdRsh2GoHGhSmEknEDp4lODJImhbmwUs4iaASXfIVDaCdz7yiXhXPTEbO2JZkA8V6wZ9A/H9Y8o3Xo/SqOEBFfOdVaAQtnZIqS+CI0AHEQ84eCsWSGouz0M7AsoKj4mwBtUEUkYkMRYCFbvtWD33y+TdfGYIyExdiOYH7wbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(7416002)(52536014)(122000001)(86362001)(38070700005)(2906002)(4744005)(5660300002)(110136005)(76116006)(54906003)(64756008)(8676002)(66446008)(4326008)(8936002)(186003)(66946007)(66556008)(66476007)(26005)(966005)(41300700001)(38100700002)(478600001)(9686003)(55016003)(6506007)(7696005)(71200400001)(316002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjQyVjY4MGpIUUpTRi9XM28xUDd1bmJKSVh5VVIzQWJWY3ZYbVZOWHdoUk5Y?=
 =?utf-8?B?R1VqcUgxbnNtWjJwaGJaUVV6UlVYNlZ3RHdhWEE4RFcreHVKZ2x6MWs0Mml2?=
 =?utf-8?B?MFhWckM1Mnh3MnFGQlgvN04zaGhQZThLdWUreEFDbkZsb2FjSEFjSUF1NVZ1?=
 =?utf-8?B?KzlCamYxSkRQcnFtOVJVWmFzKzZpVllwZjJhTWEyOC9lMWNRMUNraXlOZlBi?=
 =?utf-8?B?dk12QUdza2tyZ3djb2xxNVFkZDR6aUE0c3doSy9PUHE4NTZUb2NLSWo3Zmh3?=
 =?utf-8?B?Sm95Q0UrSUw1ajd6MzJjUEM2TVRHa3EvZDloMDNnNjFHUUhNTzRhK1ZTeXdj?=
 =?utf-8?B?eUJYaWNRRTVGT2NBT2dqckhqL2VPdERWRVp2TEVIb0s5dDhTMERma1JGWFpu?=
 =?utf-8?B?Q2dSb2JhcG5HVTRReGFvNUQ1cUJDV05jM0Z2Mklhb1pRSzQ1bGVsRUhSWHF4?=
 =?utf-8?B?OVB0R1VmKzlYcVZoSER6WnlFZHMyb1dhTllhdEVUdURCeE92WnV3Z0xXWXYv?=
 =?utf-8?B?NllmVTRoNVI0Y0t1SjlyR0pLNXhneFpTQzZnZldob3BOTG0vSzU3ZnhZRDh4?=
 =?utf-8?B?aDZNNVM3UnAyQXN2ZU0yY09UeFpwNGw0am1HaTBTdjZweThZejNvYy9SelQr?=
 =?utf-8?B?WGRuSEN1T3NBWjd1b3ozazMyVVJKcWF1U28xNWdQOTNieUEyVWRHYTg0MVhr?=
 =?utf-8?B?Q3VOTHFZSlNNRUlrVUpHL2lHaExPSzZLcnM5YmhCaTNXOWp0SUpNQ0tBOGg1?=
 =?utf-8?B?T1cwdjJ2Z29EeiszbE55QW5YOEdVREFnMUdubHJDUmU1TTlrdnNMWGl5dnBX?=
 =?utf-8?B?RWsyOU5GOUx6Z1dtaVlUME5kTW1jRHEvNW1VMmtYd2lORFV5OVBoMm9WTEJV?=
 =?utf-8?B?enVTYVhhcXgyNU1PNkIybm5meDhWR3gwRzdVeUJSVEllMnVKTWxBcFpzSGU0?=
 =?utf-8?B?M1Nhc3FlU1lBNDR4S3dqMUZPbkNwSm40SnE1cDA2eEZLYUp3MFpqK3BpUmFp?=
 =?utf-8?B?RmF5VGhHcVZYejBzL2c2UHN5QXFrNkFKUXg1bjhEUzZUYmpOU0RWa1B1K1Aw?=
 =?utf-8?B?OGZuSERXak10cjJUemNXSWZIQ3NCcDlFR29zNWpmZURhbElHVmNtVzAyWEVl?=
 =?utf-8?B?S0lta3AvcTMvL2hMa1RPZTZQdnMzTjRubEdPbXlmWEVBUTJ6OUpJaVUycm1B?=
 =?utf-8?B?d1JTdkVGbDdIRGpTclNwNzM1WitqcHNSOUJVeVdQdklYSk4ySHc1Qk1MUW93?=
 =?utf-8?B?MFBrcXExb2xkaGFxK0VRa2RVL2hpL3FnaElyUER4T2cyRFcvbXJWZWFlcWRF?=
 =?utf-8?B?dzVIYnhXMm1PMmtLOVh1aVdpMDZULzZkYWd2Q2pTYk1zbWVvWkdmdWQxRUdy?=
 =?utf-8?B?VzQwUndhVHpKbURLTEQ2SFVhbTJSVCtLTlZwaXBKVVMyTUR1WVhZV0ZoRjVz?=
 =?utf-8?B?Yk4vYUg1OGtOQm1uNmxDQzRYcGRRa08zTXBiRFFLRUhVWUI3U2xxRG1QU1E4?=
 =?utf-8?B?SElXZWFTRlh5SFQ2R3VpcnN3cHhnVkkzbFZRNkgzZXgxVnpEM3R3ZjVWMW5N?=
 =?utf-8?B?dVNOb1JDd2Q5SXpSRFNQK1g1YmpwWVBOVytFK3gyUWRlbklPenk0S3lvZSta?=
 =?utf-8?B?TDBSdVNXcDNNODM1czFteStwcDJTWTdaVm1UajdmU0IzV3VUUGE1RnRTMk1P?=
 =?utf-8?B?OVc3SGtGUFdubDJBTlhxM3dzYVZ6QlpDZ09NVnhlaUpOS3JhWFlzenhLenpL?=
 =?utf-8?B?Vm5hSjROUGpyK3p6YURCNEFENjVvdjE5Z21JRHkyMFNPOW9mSldNRjkzQ0gv?=
 =?utf-8?B?WS84ZEZ5M1J4NHVrdFB1dk9OS1pwRVl5V1A3dGtJWW4raTlsSWYwellzdEg1?=
 =?utf-8?B?L1ZLVklCcURiNTVBeWpnRitkTi9xekdOQVNydzhqSWxESEMvUm5RcTI4aVNn?=
 =?utf-8?B?RXgxdk1RaDBNMWE4RVhzV0JTRnFVZnlZYlFEUzFaVzBTa040UkV5dzBtRGxv?=
 =?utf-8?B?eFZySVJqVTd1cVoxcHFkTGJFMG5CZ1RBNjhVOTlnUG1UaCsxOGRvY0I2eWhG?=
 =?utf-8?B?NHFSNXRZTXFFTWE3UitwVVJoalBIVVI2UVF5NVJvQjRDZzdubjdPSGF0Zjdv?=
 =?utf-8?B?NWxWdWZxZ2svNENBczBOSnBZcnVpRDBjY055bjhEM3lPSk5IMDZUMU9TVFhO?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968069e9-0075-454a-f777-08db716eb8db
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 09:14:16.4245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c72awBfNfOVMrkODNQdmqUPyyqQev5NDbK4dm7qUmbjI7QzjwkK1cDq0plY9S08G3IaL2x/AJT/z1eVWT9NtF1mEUhD7if16SNqiLWQ9X3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9414
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gR3JlZywNCg0KPiBGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bmUgMTksIDIwMjMgMTE6MjcgQU0NCj4g
DQo+IFRoaXMgaXMgdGhlIHN0YXJ0IG9mIHRoZSBzdGFibGUgcmV2aWV3IGN5Y2xlIGZvciB0aGUg
Ni4zLjkgcmVsZWFzZS4NCj4gVGhlcmUgYXJlIDE4NyBwYXRjaGVzIGluIHRoaXMgc2VyaWVzLCBh
bGwgd2lsbCBiZSBwb3N0ZWQgYXMgYSByZXNwb25zZQ0KPiB0byB0aGlzIG9uZS4gIElmIGFueW9u
ZSBoYXMgYW55IGlzc3VlcyB3aXRoIHRoZXNlIGJlaW5nIGFwcGxpZWQsIHBsZWFzZQ0KPiBsZXQg
bWUga25vdy4NCj4gDQo+IFJlc3BvbnNlcyBzaG91bGQgYmUgbWFkZSBieSBXZWQsIDIxIEp1biAy
MDIzIDEwOjIxOjEyICswMDAwLg0KPiBBbnl0aGluZyByZWNlaXZlZCBhZnRlciB0aGF0IHRpbWUg
bWlnaHQgYmUgdG9vIGxhdGUuDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJlbGVhc2UhDQoNCkNJUCBj
b25maWd1cmF0aW9ucyBidWlsdCBhbmQgYm9vdGVkIG9rYXkgd2l0aCBMaW51eCA2LjMuOS1yYzEg
KGM0ZjJhMmQ4NTVkNCk6DQpodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLXRlc3Rp
bmcvbGludXgtc3RhYmxlLXJjLWNpLy0vcGlwZWxpbmVzLzkwNDM1ODE2OA0KaHR0cHM6Ly9naXRs
YWIuY29tL2NpcC1wcm9qZWN0L2NpcC10ZXN0aW5nL2xpbnV4LXN0YWJsZS1yYy1jaS8tL2NvbW1p
dHMvbGludXgtNi4zLnkNCg0KVGVzdGVkLWJ5OiBDaHJpcyBQYXRlcnNvbiAoQ0lQKSA8Y2hyaXMu
cGF0ZXJzb24yQHJlbmVzYXMuY29tPg0KDQpLaW5kIHJlZ2FyZHMsIENocmlzDQo=
