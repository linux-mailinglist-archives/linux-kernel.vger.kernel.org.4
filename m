Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BA76A3BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 08:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjB0Hcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 02:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0Hcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 02:32:46 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B761ABC7;
        Sun, 26 Feb 2023 23:32:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8mwgyxU4J5B0oVCFvz9Ns55PcGN+n929KW8hJSOmeC5Z3usNiUWEUVDPk2kNqHUdj9HZYi4a3DygBBD04SE03mh6e1qxYC5imAGyIAGXUmhao0yhaU7lYt7ErtuP/E4i3kQaSKa5Fafs0IkkiOJ2Cfcy2eRHPAGoRvDYl69VC7qpsJdA/duPwCYmVJKxBuNEMT8PAtfMJAV1CoCaD7Xyi2eEMday19xOFTzjrqNEZSG3xYk7HotyC/ZjtyBDY7KKwAHuLgtrqY8SJE1uPzm1jAyfe8jHKOF0AiRf0EcckHoR1wEGqyDKLv8UjPa+DMNSOSSCd3agN9bEymth+rSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0g33prTw1iRiGdRnMAcvGlrMjVDPm/Ibt8ODV3+qeYU=;
 b=S7ld5yPz0FqUlRbdx2Ye8DTYlWoY2fr3FjgM9Fw1wo/AS75a3sMjVJOlFAYLKdMdAag1AXhG3cPZq9Q/OErNCWuDJoPH4ARLIkps/hydeJV2LIK3Zq2dB243Lmabv7fDyOpQGGUm16KdOM701pvmLNDudVQiuVY4bNdDVEk3bAxcr4Xexgt1mLQIZK477/m0rK0pC76xOt8iy/9hUCSglwKRy5XiR6mvu0KHGc7/dbu9VfsiovALXWhg4msnsfRMft+hFXdGLVnBxaoj3h2kKjZ3tKBWgakC5dytG+ME7eVcDnugEwa627JOeZSxY2GQ4YWBxAF8uYyx8VhMpWgxEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0g33prTw1iRiGdRnMAcvGlrMjVDPm/Ibt8ODV3+qeYU=;
 b=BmodUrxRHCdqNSCbySzwmtyg9SUK3DEFyKQOKouFCElBbOM7KPPhfXmyzWrmSrGFs1ILaHp+97HjsRNP769+Oz5zdRgmd+RflLQR8EolqVNl7cn1bSZcwU4xBAQI0m3RF2E/DDwhJzRIFez3PocizW1wcQuy934pNhxp/7gX3r0=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 07:32:42 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::616b:fd76:ff5f:5ae7]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::616b:fd76:ff5f:5ae7%8]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 07:32:42 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Franck Lenormand <franck.lenormand@nxp.com>
CC:     "code@tyhicks.com" <code@tyhicks.com>
Subject: RE: [EXT] Re: [PATCH] drivers: crypto: caam: jr: Allow quiesce when
 quiesced
Thread-Topic: [EXT] Re: [PATCH] drivers: crypto: caam: jr: Allow quiesce when
 quiesced
Thread-Index: AQHZRRk2Q72HS0RGrU28OvfZ+gtJ8q7Y5FOAgADGoQCACMTqYA==
Date:   Mon, 27 Feb 2023 07:32:41 +0000
Message-ID: <DU2PR04MB8630DF686E62018E2F90FEC595AF9@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230220105033.1449263-1-meenakshi.aggarwal@nxp.com>
 <20230221054219.2142012-1-meenakshi.aggarwal@nxp.com>
 <9f33c874-17ef-ddd8-041c-e1f9995385fa@linux.microsoft.com>
In-Reply-To: <9f33c874-17ef-ddd8-041c-e1f9995385fa@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|AS8PR04MB7878:EE_
x-ms-office365-filtering-correlation-id: 5cfdcbf4-5c31-420e-d4f7-08db1894cf9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m+IEslVVEvZWXtLlj3HSTeYExyu7WlHcGxvF5SKivgmIo5jH2MC6jy6VEXFRjXrz7IAst6XrnFxJeGX2pfhv4sx4kGP/7UjcruyBykeFbZDS1tUm+qDcO2hjwem/YLIgRbKvJfbHdasxBXDB0vM7ZXFv5SVvcMsEPdPwDRGpMxrpxtBx0Axgbdd5c8Q6fpAetVyWVTaNrWIoBN+x8TYxaO5CDPgfL+3T171r7L3flhXyJRkh+lyGUZv+aoQs30XSXLMPPFuWfX6AeZ5eJoQX/iqr7UhmuasptWb7iKUWglXPl8YZ4XdIWHBJFJoJz+WyHsVpT/lq0td5VgcbIv4JsRQ6X5nSEhDNcwzDRdG16UONI86RvyrfxfN9UusnedH+FSlQkl9yIPEooTtjkZt3zNsK+pgWY7sDcfVS7RaU4h4y5B4NSuMUsRs0XB5nSw53MgnFB2OoG/039MzT3lrxeLWNX44oAGCPXzET3sB+ZE7pBbJN/MmjdiTeeGdwV75iIt66i+yC47bupyS1vVGTw6ujU7QyJ/QSBHDej6le7c6dKAR3vq+qowIVqStgotSD4phyjEljSKIk4mJgqM7zHAw9uewQmofh0k2VR7W58CUz+uHdhyTVETvbpqR60xSBz+b47ntowS/RYsNTy1diN14A1dxyMPz7/N8brmoUfwa2fNTQeTIxRDZnJacFRPIP4YfecHT83sZW91oLbek/cQGKazHjIsFNB98Hu6WbFqA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199018)(33656002)(316002)(110136005)(6636002)(478600001)(71200400001)(5660300002)(7696005)(52536014)(2906002)(8936002)(44832011)(8676002)(66946007)(66556008)(66476007)(76116006)(66446008)(64756008)(4326008)(41300700001)(122000001)(38070700005)(921005)(86362001)(55016003)(38100700002)(9686003)(186003)(26005)(55236004)(6506007)(53546011)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3VFMUo4YjRGdDNqUVFwUWova01DMmlKR3VscFVmSUgydVlxRThBalJkaERt?=
 =?utf-8?B?UzhaSXBnSklGRU9DTlE1ZldHdnFlWjhDcm9LblNmVmxXRUlEZGJJMmRqSkNj?=
 =?utf-8?B?TTVFZVorc0l5cHdNVFhBSFI2VDhZcjRKQlBVN0VHanhYS3VBWnBxQjVaQ0pu?=
 =?utf-8?B?MUJZb3d3K0hGTElmQWVWNHBuRnRnVG1zbnR3bWVnYVhhbnZDTFJrQmJNVWFL?=
 =?utf-8?B?UVZFMG0vYVNPOGxpVk9oTk16bWJwSStKblBheXl1b1lXT2dJZlFrWG43UHJy?=
 =?utf-8?B?TXlhSzNhMzExZVl3K1FGMG5RcUdjMk9UeVIwdjAwdXlJcWVhYmNuU3VoU05M?=
 =?utf-8?B?STdzRmFJSlVncm9GSUlCcnRVZjMzTHA0YktSNHRGRXcwNUVzdUJwbTFnRE1a?=
 =?utf-8?B?Smp5ZEV3UWZRRmZUb0ZhZGFzdVQySXFtL09Wa3VRcDBOTEN0UGVBMEEvVGR2?=
 =?utf-8?B?Q2RVZGgyMEtXd0tEVXNnYVFhVWEzQ3VMY3pTT1pZamVaQlpmditwSVFTdFo5?=
 =?utf-8?B?bVpUZE9Pck5CZlYwY25pdjg2K0pOVnVnbDMraWpjZ250NWhrTXNPNkRlUXQ1?=
 =?utf-8?B?aytsdUkxMXZkYzdYMUlKUk1KRXoyUzJRaXZ1M2dXc3ltMmhQSGZDYkN2d1Bu?=
 =?utf-8?B?dTg2VkZRUUp2WllOSm9BZVlXYlh6THJ2THBYclVMTzhTTk5ha09jRk8wUlE3?=
 =?utf-8?B?bUpHaFlKaERsWXVubE5qNTNYWVZtTXV3UUNYYUdCYlVhSDAzcWRWMURCSGhl?=
 =?utf-8?B?djNnejVFaWNwa0E3TzFEUm94ZHBBV1pXVjhTbWlyZjlxcGU5bk9nR2tuNmk3?=
 =?utf-8?B?amRxdTVXbFVpT3UwS1EveXA5Qm5WYUZJKzR5emcyZEY2NmY5akp6UmFGdW05?=
 =?utf-8?B?QXpiNmhDb2cwSytRWlpJOFQ0eWtQZ0c3UUE2TmY3TXAxU2tNa3k2Ykxmb0tq?=
 =?utf-8?B?YmtXVGNrVUs1ajhkQzBWRFdNNklrdmNZenRVenEwakpuQlBYaVF6RU0zaHRi?=
 =?utf-8?B?ZHF3bjVPNWY0endtM0c5cDFXVk9zSWJBb0ZlTnFUYmR2TnFQaVZ4VUt0MjB1?=
 =?utf-8?B?T2U5eDlPV0J5emRqZ0hZL2xCYWc1b1d6UGxQcUxFQ2ZHT1g4Wk9OZC84bzFB?=
 =?utf-8?B?cW5pRmdpWk92aHkyZHN4WmU2VnRtQitHc1B5ZWhkV21qbm1sRFVCMmFodExO?=
 =?utf-8?B?bXM2OWVncjZFaXZTSnozWk01bU02QjlGUmlEVVdRUG8wUjlaMUxYMGlVSmV5?=
 =?utf-8?B?c2Jkd0RQOGxKdUs2MHdmTEFsZHYydWw5dGJIdnplRUlra2lWMHBsQTBvL2p1?=
 =?utf-8?B?eHJZRG8xUDBUOHFWMlpLMWxSMlM2Zmt6M0xhUUZxVGh5cUlraUk5V0djM3BC?=
 =?utf-8?B?bHd6UThZTkdrbEtzcU9zYVlIc280UlVQRjlnYStJU2hiUVdZVk01OTIxSkIz?=
 =?utf-8?B?RWFJVkR0UFRuYnJOc29TS24yTVNhdU9UODFYV01aVEJDaXJJdWROOWtQdDRS?=
 =?utf-8?B?WFQzVzVRM0d3NTQ0cGcxTVRsK0R6RWFNSHh3RVFiTW9OTUJnOVk5cm9EQ05F?=
 =?utf-8?B?WFhCL2k1NmQzdy9XSSs5MnVEa3pKeEFkSjl1cCtFMjcyeG92RXA2Q2xXZmZa?=
 =?utf-8?B?bi80bVRkWWFmYllYclhJU1lodDcrRHptdzI4M01RYW82OFBqeFUrT29zZGE4?=
 =?utf-8?B?SnZxZUo2dXBFSUJvRjdHZS9YREkvd3pPaVp0cjJSVUFpUyszeVJsUnpSelZi?=
 =?utf-8?B?cHlBcVJIWGh0NWlJUW82MDQrM2IxVkVIWEx5RW9CTXkzRHZFbDdVNlFTRG03?=
 =?utf-8?B?ZTQ5b3A0RVE0bk55bHhXV09zbmljRlBMZ3I5STlHZGtBOWFoVlJhOUF0YVV4?=
 =?utf-8?B?eVZnRm9YMEZNRDRnL2E3NnBUcE1OSFlKNWdtaTk4WjZzMHBWT3lpbWd4M1Js?=
 =?utf-8?B?VWp6UnZnaVN1c2JKc1VRdWNwYVcybVQ2b3RHVlFrcjc5WllsUUlveWx3emRm?=
 =?utf-8?B?cjQzRk51TFJUSHFwRFFMUFk0R3V4QTlPTnFoTnczZ3UwU2pZSjhSeXMxczRE?=
 =?utf-8?B?VDZNbGM5cURFZUlkdU9Qa1EvdEQ4am9EUEhPUVdPTUMxTzNyVUFvMVIvZWFl?=
 =?utf-8?Q?irAs81tqiYa8COucG5k2IJnUg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfdcbf4-5c31-420e-d4f7-08db1894cf9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 07:32:41.9976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vuLwbOkbLroqVT3kdn1XZ+1NTf8yvqrCcwi9KpxoT2cgfg8Qk7dQHepeJ5tya8++WBUKwKqU8F2rsN9Ui/3C1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlIHRoZSB5ZWFyIGluIHRoZSBMaWNlbnNlIGhlYWRlci4NCg0KQWZ0ZXIgY2hhbmdpbmcs
IHlvdSBjYW4gYWRkIHRoZSByZXZpZXdlZCBieSBtZS4NClJldmlld2VkLUJ5OiBQYW5rYWogR3Vw
dGEgPHBhbmthai5ndXB0YUBueHAuY29tPg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IFZpamF5IEJhbGFrcmlzaG5hIDx2aWpheWJAbGludXgubWljcm9zb2Z0LmNvbT4N
Cj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMjEsIDIwMjMgMTE6MDMgUE0NCj4gVG86IE1lZW5h
a3NoaSBBZ2dhcndhbCA8bWVlbmFrc2hpLmFnZ2Fyd2FsQG54cC5jb20+OyBIb3JpYSBHZWFudGEN
Cj4gPGhvcmlhLmdlYW50YUBueHAuY29tPjsgVmFydW4gU2V0aGkgPFYuU2V0aGlAbnhwLmNvbT47
IFBhbmthaiBHdXB0YQ0KPiA8cGFua2FqLmd1cHRhQG54cC5jb20+OyBHYXVyYXYgSmFpbiA8Z2F1
cmF2LmphaW5AbnhwLmNvbT47DQo+IGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdTsgZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldDsgbGludXgtDQo+IGNyeXB0b0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEZyYW5jayBMZW5vcm1hbmQNCj4gPGZyYW5jay5sZW5vcm1h
bmRAbnhwLmNvbT4NCj4gQ2M6IGNvZGVAdHloaWNrcy5jb20NCj4gU3ViamVjdDogW0VYVF0gUmU6
IFtQQVRDSF0gZHJpdmVyczogY3J5cHRvOiBjYWFtOiBqcjogQWxsb3cgcXVpZXNjZSB3aGVuDQo+
IHF1aWVzY2VkDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IE9uIDIvMjAvMjAyMyA5
OjQyIFBNLCBtZWVuYWtzaGkuYWdnYXJ3YWxAbnhwLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBIb3Jp
YSBHZWFudGEgPGhvcmlhLmdlYW50YUBueHAuY29tPg0KPiA+DQo+ID4gSXNzdWVzOg0KPiA+IC0g
Sm9iIHJpbmcgZGV2aWNlIGlzIGJ1c3kgd2hlbiBkbyBrZXhlYyByZWJvb3QNCj4gPiAtIEZhaWxl
ZCB0byBmbHVzaCBqb2IgcmluZyB3aGVuIGRvIHN5c3RlbSBzdXNwZW5kLXJlc3VtZQ0KPiA+DQo+
ID4gRml4Og0KPiA+IEZsdXNoIHRoZSBqb2IgcmluZyB0byBzdG9wIHRoZSBydW5uaW5nIGpvYnMu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3JpYSBHZWFudGEgPGhvcmlhLmdlYW50YUBueHAu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEZyYW5jayBMRU5PUk1BTkQgPGZyYW5jay5sZW5vcm1h
bmRAbnhwLmNvbT4NCj4gDQo+IFRlc3RlZC1ieTogVmlqYXkgQmFsYWtyaXNobmEgPHZpamF5YkBs
aW51eC5taWNyb3NvZnQuY29tPg0KPiANCj4gVGhhbmtzLA0KPiBWaWpheQ0KPiANCj4gDQo+ID4g
LS0tDQo+ID4gICBkcml2ZXJzL2NyeXB0by9jYWFtL2pyLmMgfCA1MyArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystDQo+IC0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDQ0IGlu
c2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jcnlwdG8vY2FhbS9qci5jIGIvZHJpdmVycy9jcnlwdG8vY2FhbS9qci5jIGluZGV4DQo+ID4g
NzI0ZmRlYzE4YmY5Li44NzQ1ZmUzY2I1NzUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jcnlw
dG8vY2FhbS9qci5jDQo+ID4gKysrIGIvZHJpdmVycy9jcnlwdG8vY2FhbS9qci5jDQo+ID4gQEAg
LTcyLDE5ICs3MiwyNyBAQCBzdGF0aWMgdm9pZCBjYWFtX2pyX2NyeXB0b19lbmdpbmVfZXhpdCh2
b2lkICpkYXRhKQ0KPiA+ICAgICAgIGNyeXB0b19lbmdpbmVfZXhpdChqcnByaXYtPmVuZ2luZSk7
DQo+ID4gICB9DQo+ID4NCj4gPiAtc3RhdGljIGludCBjYWFtX3Jlc2V0X2h3X2pyKHN0cnVjdCBk
ZXZpY2UgKmRldikNCj4gPiArLyoNCj4gPiArICogUHV0IHRoZSBDQUFNIGluIHF1aWVzY2UsIGll
IHN0b3ANCj4gPiArICoNCj4gPiArICogTXVzdCBiZSBjYWxsZWQgd2l0aCBpdHIgZGlzYWJsZWQN
Cj4gPiArICovDQo+ID4gK3N0YXRpYyBpbnQgY2FhbV9qcl9zdG9wX3Byb2Nlc3Npbmcoc3RydWN0
IGRldmljZSAqZGV2LCB1MzIganJjcl9iaXRzKQ0KPiA+ICAgew0KPiA+ICAgICAgIHN0cnVjdCBj
YWFtX2Rydl9wcml2YXRlX2pyICpqcnAgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPiAgICAg
ICB1bnNpZ25lZCBpbnQgdGltZW91dCA9IDEwMDAwMDsNCj4gPg0KPiA+IC0gICAgIC8qDQo+ID4g
LSAgICAgICogbWFzayBpbnRlcnJ1cHRzIHNpbmNlIHdlIGFyZSBnb2luZyB0byBwb2xsDQo+ID4g
LSAgICAgICogZm9yIHJlc2V0IGNvbXBsZXRpb24gc3RhdHVzDQo+ID4gLSAgICAgICovDQo+ID4g
LSAgICAgY2xyc2V0Yml0c18zMigmanJwLT5ycmVncy0+cmNvbmZpZ19sbywgMCwgSlJDRkdfSU1T
Syk7DQo+ID4gKyAgICAgLyogQ2hlY2sgdGhlIGN1cnJlbnQgc3RhdHVzICovDQo+ID4gKyAgICAg
aWYgKHJkX3JlZzMyKCZqcnAtPnJyZWdzLT5qcmludHN0YXR1cykgJiBKUklOVF9FUlJfSEFMVF9J
TlBST0dSRVNTKQ0KPiA+ICsgICAgICAgICAgICAgZ290byB3YWl0X3F1aWVzY2VfY29tcGxldGlv
bjsNCj4gPg0KPiA+IC0gICAgIC8qIGluaXRpYXRlIGZsdXNoIChyZXF1aXJlZCBwcmlvciB0byBy
ZXNldCkgKi8NCj4gPiAtICAgICB3cl9yZWczMigmanJwLT5ycmVncy0+anJjb21tYW5kLCBKUkNS
X1JFU0VUKTsNCj4gPiArICAgICAvKiBSZXNldCB0aGUgZmllbGQgKi8NCj4gPiArICAgICBjbHJz
ZXRiaXRzXzMyKCZqcnAtPnJyZWdzLT5qcmludHN0YXR1cywgSlJJTlRfRVJSX0hBTFRfTUFTSywg
MCk7DQo+ID4gKw0KPiA+ICsgICAgIC8qIGluaXRpYXRlIGZsdXNoIC8gcGFyayAocmVxdWlyZWQg
cHJpb3IgdG8gcmVzZXQpICovDQo+ID4gKyAgICAgd3JfcmVnMzIoJmpycC0+cnJlZ3MtPmpyY29t
bWFuZCwganJjcl9iaXRzKTsNCj4gPiArDQo+ID4gK3dhaXRfcXVpZXNjZV9jb21wbGV0aW9uOg0K
PiA+ICAgICAgIHdoaWxlICgoKHJkX3JlZzMyKCZqcnAtPnJyZWdzLT5qcmludHN0YXR1cykgJiBK
UklOVF9FUlJfSEFMVF9NQVNLKQ0KPiA9PQ0KPiA+ICAgICAgICAgICAgICAgSlJJTlRfRVJSX0hB
TFRfSU5QUk9HUkVTUykgJiYgLS10aW1lb3V0KQ0KPiA+ICAgICAgICAgICAgICAgY3B1X3JlbGF4
KCk7DQo+ID4gQEAgLTk1LDggKzEwMywzNSBAQCBzdGF0aWMgaW50IGNhYW1fcmVzZXRfaHdfanIo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU87DQo+ID4g
ICAgICAgfQ0KPiA+DQo+ID4gKyAgICAgcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gKy8q
DQo+ID4gKyAqIEZsdXNoIHRoZSBqb2IgcmluZywgc28gdGhlIGpvYnMgcnVubmluZyB3aWxsIGJl
IHN0b3BwZWQsIGpvYnMNCj4gPiArcXVldWVkIHdpbGwgYmUNCj4gPiArICogaW52YWxpZGF0ZWQg
YW5kIHRoZSBDQUFNIHdpbGwgbm8gbG9uZ2VyIGZldGNoIGZyb24gaW5wdXQgcmluZy4NCj4gPiAr
ICoNCj4gPiArICogTXVzdCBiZSBjYWxsZWQgd2l0aCBpdHIgZGlzYWJsZWQNCj4gPiArICovDQo+
ID4gK3N0YXRpYyBpbnQgY2FhbV9qcl9mbHVzaChzdHJ1Y3QgZGV2aWNlICpkZXYpIHsNCj4gPiAr
ICAgICByZXR1cm4gY2FhbV9qcl9zdG9wX3Byb2Nlc3NpbmcoZGV2LCBKUkNSX1JFU0VUKTsgfQ0K
PiA+ICsNCj4gPiArc3RhdGljIGludCBjYWFtX3Jlc2V0X2h3X2pyKHN0cnVjdCBkZXZpY2UgKmRl
dikgew0KPiA+ICsgICAgIHN0cnVjdCBjYWFtX2Rydl9wcml2YXRlX2pyICpqcnAgPSBkZXZfZ2V0
X2RydmRhdGEoZGV2KTsNCj4gPiArICAgICB1bnNpZ25lZCBpbnQgdGltZW91dCA9IDEwMDAwMDsN
Cj4gPiArICAgICBpbnQgZXJyOw0KPiA+ICsgICAgIC8qDQo+ID4gKyAgICAgICogbWFzayBpbnRl
cnJ1cHRzIHNpbmNlIHdlIGFyZSBnb2luZyB0byBwb2xsDQo+ID4gKyAgICAgICogZm9yIHJlc2V0
IGNvbXBsZXRpb24gc3RhdHVzDQo+ID4gKyAgICAgICovDQo+ID4gKyAgICAgY2xyc2V0Yml0c18z
MigmanJwLT5ycmVncy0+cmNvbmZpZ19sbywgMCwgSlJDRkdfSU1TSyk7DQo+ID4gKyAgICAgZXJy
ID0gY2FhbV9qcl9mbHVzaChkZXYpOw0KPiA+ICsgICAgIGlmIChlcnIpDQo+ID4gKyAgICAgICAg
ICAgICByZXR1cm4gZXJyOw0KPiA+ICsNCj4gPiAgICAgICAvKiBpbml0aWF0ZSByZXNldCAqLw0K
PiA+IC0gICAgIHRpbWVvdXQgPSAxMDAwMDA7DQo+ID4gICAgICAgd3JfcmVnMzIoJmpycC0+cnJl
Z3MtPmpyY29tbWFuZCwgSlJDUl9SRVNFVCk7DQo+ID4gICAgICAgd2hpbGUgKChyZF9yZWczMigm
anJwLT5ycmVncy0+anJjb21tYW5kKSAmIEpSQ1JfUkVTRVQpICYmIC0tDQo+IHRpbWVvdXQpDQo+
ID4gICAgICAgICAgICAgICBjcHVfcmVsYXgoKTsNCg==
