Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F5B6E19EE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 04:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjDNCAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 22:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjDNB75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:59:57 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2047.outbound.protection.outlook.com [40.107.15.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ED04C32;
        Thu, 13 Apr 2023 18:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIKAiDAe+hjqz73Kz7xlkmgyrBzk5ERZxHzrGykCSsVespZ1YrdhimL/38enby14INzUxLcgA/EZrCEllXNfSnjraLokGnFpZOhFheSNWAsxYrTZNPW7USRw5OvpVb8E9MR5AcfTj0s8GqbvW28TXJxh6sbX+zae5A2N6OOVvQqlFyJHci13/qD9RAlqU4C1qWQsMJFP+xLeaCffzpSzjTi6Mi1IoC0pcgiunOxtSgeT4Ms7tMeNHv9qZjG6MoGA8D5Db80FMmN8AUA3mbHJL1GzZVsR16R2oOPjehpdoqQ8EEUVxmGtu/MdyswVeh4lXaZ8RF/hhrM5+WXhXR3DOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCYh0XA+8z0tb+PlzoH+wVqiTlqCwoj+yJtXuuZ+cZo=;
 b=jEfQsJr8HVXHHH1ZrZ89FJrsVasgeF7JI6sJwMduPMtpTXckReLxkO6dHIqdcTuJpYLtyCBa+yId3kubXPb/kQng6s/qel2Ba0xyPuuQnBh8tbjgBGgsOdt+Xmh2RoISdUFDmJF+1rNwbSrnztn8M9E/WOfEzVpC6OIu6pp0AQjlDL23KGdtEzt19j+Z2pG0p3/2i20QYnLXhGZKuJmkSeTblklpNMCQxKFdnhxgCKhIY5lQX8Qxkd/ENhYpXEIW11IBmEvBY24gxOj85BbENXx4w5as9ZRVnpvniL9gR4OExJiYDCJzjkWxKv6BHOmftHKRPLKrIXVTXvORZFCJ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCYh0XA+8z0tb+PlzoH+wVqiTlqCwoj+yJtXuuZ+cZo=;
 b=H+pbGcV7d/dOyx1Y58Osx7btAkjjC/Hz44t0YnNHykNSXw6bgSugOCxlXuYwh0UGe9mLaxO6mKX+QErudC4FxsyL5e2ynUP2+rBUw1IE2EJ0m7OmEjMpVBVWxQNr/5bVl8nQ5t1dpyoeKtXxoQTZBA4NJzKFN95EY+V6CGxRQww=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS4PR04MB9290.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 01:59:51 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::e1cd:e733:d3aa:ea49]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::e1cd:e733:d3aa:ea49%6]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 01:59:51 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "philippe.schenker@toradex.com" <philippe.schenker@toradex.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: use UARTMODIR register bits for
 lpuart32 platform
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: use UARTMODIR register bits for
 lpuart32 platform
Thread-Index: AQHZbcrlWnBtOzGg30ifZBEjWM04Xa8o7+MAgAEdv4A=
Date:   Fri, 14 Apr 2023 01:59:51 +0000
Message-ID: <AS8PR04MB8404AFC75B5C9EBE192DC15392999@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20230413053908.17702-1-sherry.sun@nxp.com>
 <a8e12926-58e7-43c3-f4d1-a67b4bfbc1@linux.intel.com>
In-Reply-To: <a8e12926-58e7-43c3-f4d1-a67b4bfbc1@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AS4PR04MB9290:EE_
x-ms-office365-filtering-correlation-id: 23ca2ad7-be1a-48a1-b323-08db3c8bef59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F1EKMSPbmO8dwYp2DosiYHJo6Z1FjVA5qFZDuEiO7uSptsfVWNwIt9T9TZHMSTplTnL2osjtkNVqj01o1KZdP8nSpRiUCdnnHWIV/E/Wb/0h5ffYgsLbXc/wvd15PqT0YDzLdONj2/9Id2cAnWQyXFCqyMKmXgm/nh3LAyzhGSwiEkqfSISPWkRtoYRvemVkEagOc9BdB2or7OIbrLveOMj25/jsZ51JNX/Dx6mIxO7TxZjysNMXp1av6WQIQ/KTBPuU1ocTelRSa7svecStbApZ8dlAYrkOVZoqL7iiH8YZ0WpJrTeS4rGQKKnBvRaL3p8x61snAMkYZqBaHhE0xC1NW4NtGABlfVmcvG6j6jCYEbqBkDbZG/uc979xjRU7nJ1AN7Ag5GZ0aRk0Z3WDlboMC1alS3kt6uJ4uTiGH1PAlEujQ79si+dHDzyjwoVFbLRH4daARgf5O0YAS5t8SnILJ2v8hLJoXYFrmtWdof1x+hkl/YQMnta61R84r0av7EsrnvkOT/D0Y1fbw0a0UM7Q9YVOd8XabJ0Q4tO2vO+Zlc6jf0avuJlPHUpJ9iBTgMACtXyWkjunRliW9/lXGGHGYF5Q1PgtiGAH/ANGW7i3NgENLkq6TznOStJ9fcHu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(8676002)(8936002)(76116006)(41300700001)(52536014)(5660300002)(44832011)(66476007)(66446008)(66946007)(66556008)(2906002)(4326008)(64756008)(122000001)(316002)(6916009)(478600001)(54906003)(86362001)(38070700005)(7696005)(38100700002)(53546011)(6506007)(9686003)(186003)(55016003)(71200400001)(83380400001)(26005)(33656002)(66574015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDJIandaSGl1ZGhQcFl2NDQ4aXZQa0xZOUJJek1GV1EzaEVrVDNSbzYwaDQ2?=
 =?utf-8?B?NDJwQjF1Q1FMZk5paHgyS1VpNnNpSkprQ2FOVUxtU3BuRzhCVDcwRXBhdEQ1?=
 =?utf-8?B?OHFkbTRUWkJPNjJHc3ZpRDdMcTBIaGVUdXRKQmlwUGZ1UkNKTEtKOWlBTEpu?=
 =?utf-8?B?TElTcjIrcGZ4NHlMeWx1RDZxcE03a3IvRkVmQXdhb3dSWWVaSkxaaFpCOENF?=
 =?utf-8?B?bnV5ak9lSi81Q3JTWmgrTjJ4MVphOUtoemVxakVKTjFsQmpqd3Qxd2p5cVU4?=
 =?utf-8?B?WjVXREhJbGtWVmFlVDFoTlZXYkRTcTlaeFF6RWZhekNIalgvM3hwN213aWVw?=
 =?utf-8?B?NDdMWkJBOVBDTXUxNS9zMDFVemZhNVh1TndDWFFhbndXcUZFNFRCeVBreFhk?=
 =?utf-8?B?cGZNbVpOaVpBMWJoTVF6aXdlTFZYMTlDQkgwYjI1WVpMN1VEUWQvR251MGww?=
 =?utf-8?B?MUVqcjZVT0wzN2VBcHlHMHFMMFVMNVg5dHc2WXVjVTVaSnM3UnY5dkp4OGc1?=
 =?utf-8?B?emJFaHp3aHFrWU1ZL1AwK2VwTHlvMzFLdDh4SDBGb0xBWmJVOUV4ZXFXVjVZ?=
 =?utf-8?B?Nm5OMUNIVUxnZi96R2xCYWg1SHQ0d1dkVmpBSjZ4dDVnQ1oxV3ZDWm5xM296?=
 =?utf-8?B?U2NHaGRmRS91M3p6ZUFwWWdaaUNQTm1ONUJaenBLNWZXSnhUN3hhRDFLRW0y?=
 =?utf-8?B?eVUxbGN4RDQ4VjFWaU5MS2YrWnk5YnJzNHpsQXBSZmRZcElMYjhoYUZscFd6?=
 =?utf-8?B?YWtFU25GYVZNUFdhOXZhNXRROWFlT2Mwc0dhUGRHRUdEbEVpZUw1ZjFyT0hO?=
 =?utf-8?B?czlmODJMTkpkRGRWM0FrdlBsdFlMdXR3cEpWdVMrcFA5ZjUyR2xLRjU4NmV1?=
 =?utf-8?B?ZDJiZlFyV2Nsc1h2V3NFWkR3OUQxRFFLSGdFcTZFZThGV3Rxbm02aXVsb1lX?=
 =?utf-8?B?MDZhU1pGTm9lSVMvdHNJTmIxS0NiaWpnalJ3V0p2K2EvMG5uNk8xQ0hDeFA4?=
 =?utf-8?B?a3lHSkltd2pETXZSZFE1NUFkWlBKU0ZUZWFYTEhIOGtKVUJrOUVpYjVuWCty?=
 =?utf-8?B?MWN2a2kxK1lNb0ZZM1FJM3V3OUQxcXR5byt2ZGhVeXdxSmFCRHlDSUJmeXZi?=
 =?utf-8?B?c1ROYUpIaUVJYThoY3V5ZmVnclYxNUMxK0ZRVVRCbzVwYXZwUE1GWkV2M08y?=
 =?utf-8?B?bnQ0UnA0SGV3UVZudjUwaFlMMjc3SzNnQXNDQzZHT1MwUi9odVBVaUJWOFVG?=
 =?utf-8?B?VVlkSE5JUzJqOUdQSU9hK2xEcXhzeG93Q080Rm1rZk1EVlRPRVgwOUVvTkpK?=
 =?utf-8?B?T1RyeGViWWttalpUblo5d0htQUNyVGV6eVZkVWpWdW5hODlJQ2tnL0FCVEZK?=
 =?utf-8?B?d1RLQmFITG1kZGR4NjVrY3hrNzY5ZlhGaXU1ZE1SY2k3R3NsMTZiT0h0WXVt?=
 =?utf-8?B?K0w2amROWG9sbUQ4RnF3L2ZJcWdlOC9tMEFiSngyYkttK0Yvblg3QzgyeFQx?=
 =?utf-8?B?ZWR5SFRRbExBNEtTeWNEZDlDaWFhQUY0aHV2RHF2OHJ6bnh6OVNmVDFDNkw3?=
 =?utf-8?B?WkpnTm9nd2hHQ1cwRm04OVBQU0hNZE14OVlSblBMYUp2VktnU2lja3R4OHpC?=
 =?utf-8?B?RlludVlIU2krS3pGK213NjJsendWb3RnSHZjUlN0S3pkMk41cFhrTjdKdk85?=
 =?utf-8?B?NUZHU1JUUmpiU1lqcTF0L3ErQ2JTdUxIMCtaOUFWSTFPNk1WeW5Ybk1QWi8w?=
 =?utf-8?B?dloySURhVitpN2NoOUpubHVxbkl4b24zTkJXL2ZzR3NOTW82VWRMZnlWWml1?=
 =?utf-8?B?Y1FzZ1FJQXJLc1dsMGdHQ1dmemJ5b3RPYTBnMEpYT3NMaVJBOG5MN3FEb0Ru?=
 =?utf-8?B?SVJ3WGNmR25iVkhtWXluUnpFTGp5RkJsQlI1dDRBR1RJTm4xbzN2MkVXeDhr?=
 =?utf-8?B?bnNHaEI5SHRoOXFxOEsrN05XL0psL2IzS1BnWHFaUjA4UTZxVkg3VDMzR1F1?=
 =?utf-8?B?bUprcEgySlQ5cVZWSnFTRUtZaW9ZeDdjYjNBK253anBDMVRBeVZHbHlBYXcw?=
 =?utf-8?B?aWk0ZmtKZTV0dFZtWmpNYWFyNk5od2k3ZlRXQzBjOWRsR2RlZHBQYVZHeGZs?=
 =?utf-8?Q?Fs9M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ca2ad7-be1a-48a1-b323-08db3c8bef59
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 01:59:51.6287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJhtEaibt0vOWsAsiWLINLr57rfDVQLldUHyVQQhwQMYNlOlhO+uGLpvM5CHVzXeFocpZtUcwl8g9tKPjXQzkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9290
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWxwbyBKw6RydmluZW4g
PGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPg0KPiBTZW50OiAyMDIz5bm0NOaciDEz5pel
IDE2OjU2DQo+IFRvOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+IENjOiBHcmVn
IEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgSmlyaSBTbGFieQ0K
PiA8amlyaXNsYWJ5QGtlcm5lbC5vcmc+OyBwaGlsaXBwZS5zY2hlbmtlckB0b3JhZGV4LmNvbTsg
bGludXgtc2VyaWFsIDxsaW51eC0NCj4gc2VyaWFsQHZnZXIua2VybmVsLm9yZz47IExLTUwgPGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBu
eHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSB0dHk6IHNlcmlhbDogZnNsX2xwdWFydDog
dXNlIFVBUlRNT0RJUiByZWdpc3RlciBiaXRzIGZvcg0KPiBscHVhcnQzMiBwbGF0Zm9ybQ0KPiAN
Cj4gT24gVGh1LCAxMyBBcHIgMjAyMywgU2hlcnJ5IFN1biB3cm90ZToNCj4gDQo+ID4gRm9yIGxw
dWFydDMyIHBsYXRmb3JtcywgVUFSVE1PRElSIHJlZ2lzdGVyIGlzIHVzZWQgaW5zdGVhZCBvZg0K
PiBVQVJUTU9ERU0uDQo+ID4gU28gaGVyZSBzaG91bGQgY29uZmlndXJlIHRoZSBjb3JyZXNwb25k
aW5nIFVBUlRNT0RJUiByZWdpc3RlciBiaXRzLg0KPiA+DQo+ID4gRml4ZXM6IDY3YjAxODM3ODYx
YyAoInR0eTogc2VyaWFsOiBscHVhcnQ6IEFkZCBSUzQ4NSBzdXBwb3J0IGZvcg0KPiA+IDMyLWJp
dCB1YXJ0IGZsYXZvdXIiKQ0KPiANCj4gVGhlIHBhdGNoIGlzIGdvb2QgYnV0IEkgZG9uJ3QgdGhp
bmsgRml4ZXMgdGFnIGlzIHdhcnJhbnRlZCBoZXJlIGJlY2F1c2UNCj4gVFhSVFNQT0wgYW5kIFRY
UlRTRSBiaXRzIGFyZSB0aGUgc2FtZSBmb3IgYm90aCByZWdpc3RlcnMuIC4uLlNvIHRoaXMgaXMg
bW9zdGx5DQo+IHRvIGF2b2lkIHJlYWRlciBjb25mdXNpb24gcmF0aGVyIHRoYW4gZml4IGFuIGFj
dHVhbCBwcm9ibGVtLg0KPiANCj4gUmV2aWV3ZWQtYnk6IElscG8gSsOkcnZpbmVuIDxpbHBvLmph
cnZpbmVuQGxpbnV4LmludGVsLmNvbT4NCg0KU3VyZSwgd2lsbCByZW1vdmUgdGhlIGZpeCB0YWcs
IHRoYW5rcy4NCg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg0KPiANCj4gLS0NCj4gIGkuDQo+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYyB8IDggKysrKy0tLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+ID4gYi9k
cml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jIGluZGV4IDA3NGJmZWQ1N2ZjOS4uOTg0NWQz
ZjViODRiDQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVh
cnQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMNCj4gPiBAQCAt
MTQwNiwxMiArMTQwNiwxMiBAQCBzdGF0aWMgaW50IGxwdWFydDMyX2NvbmZpZ19yczQ4NShzdHJ1
Y3QNCj4gdWFydF9wb3J0ICpwb3J0LCBzdHJ1Y3Qga3Rlcm1pb3MgKnRlcm1pbw0KPiA+ICAJCQlz
dHJ1Y3QgbHB1YXJ0X3BvcnQsIHBvcnQpOw0KPiA+DQo+ID4gIAl1bnNpZ25lZCBsb25nIG1vZGVt
ID0gbHB1YXJ0MzJfcmVhZCgmc3BvcnQtPnBvcnQsIFVBUlRNT0RJUikNCj4gPiAtCQkJCSYgfihV
QVJUTU9ERU1fVFhSVFNQT0wgfA0KPiBVQVJUTU9ERU1fVFhSVFNFKTsNCj4gPiArCQkJCSYgfihV
QVJUTU9ESVJfVFhSVFNQT0wgfA0KPiBVQVJUTU9ESVJfVFhSVFNFKTsNCj4gPiAgCWxwdWFydDMy
X3dyaXRlKCZzcG9ydC0+cG9ydCwgbW9kZW0sIFVBUlRNT0RJUik7DQo+ID4NCj4gPiAgCWlmIChy
czQ4NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfRU5BQkxFRCkgew0KPiA+ICAJCS8qIEVuYWJsZSBhdXRv
IFJTLTQ4NSBSVFMgbW9kZSAqLw0KPiA+IC0JCW1vZGVtIHw9IFVBUlRNT0RFTV9UWFJUU0U7DQo+
ID4gKwkJbW9kZW0gfD0gVUFSVE1PRElSX1RYUlRTRTsNCj4gPg0KPiA+ICAJCS8qDQo+ID4gIAkJ
ICogVGhlIGhhcmR3YXJlIGRlZmF1bHRzIHRvIFJUUyBsb2dpYyBISUdIIHdoaWxlIHRyYW5zZmVy
Lg0KPiA+IEBAIC0xNDIwLDkgKzE0MjAsOSBAQCBzdGF0aWMgaW50IGxwdWFydDMyX2NvbmZpZ19y
czQ4NShzdHJ1Y3QgdWFydF9wb3J0DQo+ICpwb3J0LCBzdHJ1Y3Qga3Rlcm1pb3MgKnRlcm1pbw0K
PiA+ICAJCSAqIE5vdGU6IFVBUlQgaXMgYXNzdW1lZCB0byBiZSBhY3RpdmUgaGlnaC4NCj4gPiAg
CQkgKi8NCj4gPiAgCQlpZiAocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1X1JUU19PTl9TRU5EKQ0K
PiA+IC0JCQltb2RlbSB8PSBVQVJUTU9ERU1fVFhSVFNQT0w7DQo+ID4gKwkJCW1vZGVtIHw9IFVB
UlRNT0RJUl9UWFJUU1BPTDsNCj4gPiAgCQllbHNlIGlmIChyczQ4NS0+ZmxhZ3MgJiBTRVJfUlM0
ODVfUlRTX0FGVEVSX1NFTkQpDQo+ID4gLQkJCW1vZGVtICY9IH5VQVJUTU9ERU1fVFhSVFNQT0w7
DQo+ID4gKwkJCW1vZGVtICY9IH5VQVJUTU9ESVJfVFhSVFNQT0w7DQo+ID4gIAl9DQo+ID4NCj4g
PiAgCWxwdWFydDMyX3dyaXRlKCZzcG9ydC0+cG9ydCwgbW9kZW0sIFVBUlRNT0RJUik7DQo+ID4N
Cg==
