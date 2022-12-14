Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B55B64C515
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbiLNI3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbiLNI3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:29:18 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14921D0D0;
        Wed, 14 Dec 2022 00:29:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAlT6FVB9LZ9Bh06Gaafa/OYYwS1kX22vy+9YQm/JAJmjLlDDaDOW9oduUEQbrA+UEEYFwV5bAfk5kBmLaA362EMafcbcblZAEM3zChH9hdOP1ZYK03asrcDTtvO6DfZGEJhwqQW/dKsZ+ZZIFXkOcHilHb8m5jMRwNw1Uc/2C+tR78FH1gn6tUBy52PDcnpPWqfS4eAjEJbLEFRtmT1+WTdnq2cZ4kvl61WUlPCMrb3Py6fGZFJTlQZRqiYiqOrFMMeOzs0vmlpwCw3kE4cIcR+Jm+y+5zTW9bXXDCkFShOfhqIiI9+tk1JC20fDHgxrW6sUQV184jPuBnHv8TfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ppJeg26wdq9PN30yMdfvNkFc3h7cdIQG0CtBFOuD5U=;
 b=Pxx5kXZtD6rV4UWpD0EG0C+9TunC2RI7kprD8wCaCjLikIV8L8kqvoyD/7HKXNscC4/xAQlX7Vf3Dx5ZJIJY6EbFJAagr3YDobDj4NhrvyUdyj/qzWI7A+JCufYOGvSCNZ6akOALDDV+VwGFYBqCd0RizWUzDtkDcvM6MC5zrZDn+e+jPETh6qkqpphOU/VKh5z9U8BZtdLCaFjFg2Lc2WAnYXYbN9b9lbWy7+W5IiTapLCokSxC9X4eugds+gRbs1AM7q6aFwA03W40xo+GHYM0HZnNqGdfiTbyWCQTmZ9hTNn5G5omvYhjYgNCbBv8O5zjA2bXRLs2dcUAwRjbrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ppJeg26wdq9PN30yMdfvNkFc3h7cdIQG0CtBFOuD5U=;
 b=ZGkJx+mz6nBlAbdVp2cud3EhkK2IcyGaxtzjcc+o96SEzsVOp32dspndtischrPA4v+mp/ywyNjnB2QUqaEmweTFR5jTrkjEkBgH32+Erz09hkocUeeEm221L8+D8FOr3A8ESjTIIexhYccBZ4u1PkqpwpgplFLxbONzk1cZ5SY=
Received: from DB9PR04MB8411.eurprd04.prod.outlook.com (2603:10a6:10:24c::9)
 by PAXPR04MB9278.eurprd04.prod.outlook.com (2603:10a6:102:2b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 08:29:11 +0000
Received: from DB9PR04MB8411.eurprd04.prod.outlook.com
 ([fe80::395d:5383:b665:b281]) by DB9PR04MB8411.eurprd04.prod.outlook.com
 ([fe80::395d:5383:b665:b281%4]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 08:29:11 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "atsushi.nemoto@sord.co.jp" <atsushi.nemoto@sord.co.jp>,
        "tomonori.sakita@sord.co.jp" <tomonori.sakita@sord.co.jp>
Subject: RE: [PATCH V3 0/3] fsl_lpuart: improve Idle Line Interrupt and
 registers handle in .shutdown()
Thread-Topic: [PATCH V3 0/3] fsl_lpuart: improve Idle Line Interrupt and
 registers handle in .shutdown()
Thread-Index: AQHZALf6SzRM0ICZj0mTAd+zWQtpoq5syguQgABgAoCAAABQIA==
Date:   Wed, 14 Dec 2022 08:29:11 +0000
Message-ID: <DB9PR04MB8411D4D4B5FB353C1666943492E09@DB9PR04MB8411.eurprd04.prod.outlook.com>
References: <20221125101953.18753-1-sherry.sun@nxp.com>
 <AS8PR04MB8404BABDC0FD4FAB0D89534B92E09@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <Y5mIrXNjivMXVnNi@kroah.com>
In-Reply-To: <Y5mIrXNjivMXVnNi@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8411:EE_|PAXPR04MB9278:EE_
x-ms-office365-filtering-correlation-id: f4d47009-d014-4a79-b6b2-08daddad4710
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vtRDkhJfqGUssDqfyKdiTxGh+oSdDiztU8vwYJVDGghVRghLo/dlpO6uOGTE5sEvhLTihKpmenHRir7b9g3934CCUTe2G8UZk8vFPafEq/6V0hDCyad6H0zIcH+nM0Xy36KvtsdMkGPg/2fQoG5Dn0Q6IV/OtLEcAZk4P8q+xaPpaIXJVnBqZsofek3uMgL0Nqke6oQRFsK3hZMM5Tj+M1mngK/L37ucZQeR0sVeiccUS4aZNd1L7FjFOxcss7bKaZQeo6n085xrW9Q8H/MNVATo9qbeNnSSSTKlIf6GpGYW2OXMc/safjKkI+a5A5peNOKgBbHL1OEcWx7k4i7B20p7dKgOmYbS5xxQTZ0QxBSXERnwTAhwsuMTwTQa6UeRAWriOOGMux5UioIhtjfziXlH2Q5z/TFIv3yOILar2zSEyWdXksUeTEiIOtx0LlzvLEaDmhWo8Jfj5wYA9H7U5xJJbfzsKcqt1xpREaWTeHsHDde8Pt46Dd3GWw3rlo6oAu17sys/ilBXfs1Pznzx4nbiIB6MaSwSzuemrNE3gXMWBo6geFvQ/Ixj8Mr07BCCCd87qR5bYI2u8aXt+bI9nQnqP05XMLprcX1rtjrw0wn1pqFIHSTz3txKJk0NN4HmjXjoOfuNfqWL5/2SPqJVer8XQcdwR0X5Uu5n9M/7Z5h8pusK4O6K9ErpY7cleJs0whWo4QTAsgPJJXGb+Cz7ScHAT4S6WeIlaLj1uRl71nk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8411.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199015)(316002)(52536014)(38100700002)(54906003)(4744005)(6916009)(8936002)(9686003)(478600001)(6506007)(7696005)(53546011)(122000001)(71200400001)(38070700005)(26005)(186003)(2906002)(33656002)(86362001)(55016003)(44832011)(64756008)(4326008)(83380400001)(8676002)(66446008)(76116006)(41300700001)(66476007)(66556008)(5660300002)(66946007)(142923001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dTRicjlRYVZ4NHlFazVKdmhTWmJCZUFpM1B3WFNyRytMUG15aTZMK1d3bnkx?=
 =?gb2312?B?bnU3K0dzamxJbW1IdGdCU2RyZjNxVUxtUUYzQStsRlU5UkVpV1RxK1lJa29t?=
 =?gb2312?B?YkR6RWxLd2FYb1hXekxBM3c0c0NVT3BVZ1RYd2N3V1BPU1dQYlVvamQvb0Zr?=
 =?gb2312?B?aWQxQlYrYXlRTDNTdmJvSmd6YlpnMndGblM5UDByR3lvSFFkRlYrR2xzWE0x?=
 =?gb2312?B?djk2V3crNk5leGdvZ2lKVlloVWlrNmlaYUNMa0pvQUtKQkdVNjdXTlFHdGcz?=
 =?gb2312?B?ZThaelVnR1VYNUNHcHFucUVZby9OaXUvZXNrbGQ1YmhRYlVPV2FnVW8vSllw?=
 =?gb2312?B?MmFub2QvamU0am0rZEFqelUyNmovWUNiUS9IeDB6bFpJTVN3QzV6SGk0MVVG?=
 =?gb2312?B?bWJrQkszdHhvMDBPOTJMWHFCZmJmSGw1Vmw3b0VBMlVyaXBtMVZqTlEvcWdF?=
 =?gb2312?B?a3VWQ2V4Y1hRcVNPS2grN0srWk5uODZvRDdDMit5blhDWXhWYVlubUJONklW?=
 =?gb2312?B?MFRFTGxBRTVBRHM5UFllRzU0NG05UGd3M0x6SzVLUmhXSFd1UHM5ZnhON25x?=
 =?gb2312?B?Qnh2QmlXeFpwMm9tTC9WR3FaQU1NRGhoOXJta09iMVlWK3c3L2xrSGFTMXd1?=
 =?gb2312?B?VXIrU2FJNW9ZNTBXKzdqaXBUSnc5aGZYZzlZT1drblhKeU1LUS9hSWE5V3Fn?=
 =?gb2312?B?a0NZRENwQkEvV2psaWUvWlVQZ1J1QXl0Y3N5ZkhXbDB4cW9CNm1BZlNDTjFB?=
 =?gb2312?B?TEh3T0R1VWhSVCtjY1NCYlRwa1VBNjhxVEtwZFp0RksyUmJ0K25tUG9lb0lL?=
 =?gb2312?B?SCtHNEVRY3plOWVYdHYvNjdueVpzclpTbVNFNnllSElnS0kwaG56SnNhLzRq?=
 =?gb2312?B?MHZDL3JYQ3RxSm84ck9xcEdoeHFCZ1JVZUpPT0djVXlHelhpL2JGSGdSRU1J?=
 =?gb2312?B?OGxZRUg3eTVVSUc5RkFla0RodHhpZ0xmMlBFNTdacjA1a2hMKy9FTVhBdUty?=
 =?gb2312?B?VjJpemVtVWp2MmlIUmg1czVxL09ySCtWQWtQN0tSNUhlU0U5WnRFbUxXRVF4?=
 =?gb2312?B?c3U4K2lTUit6ZnpBTVc0R0NzakxBVGZ6WnAxYmR2T1daN0FiSzAwc01LK3k0?=
 =?gb2312?B?UjA0Y2luLzhScG94ZzhiTkNkZ1paNzFoUUJEcnNnMmVMaml1Y1dKWk52d0RD?=
 =?gb2312?B?R0xPNDIrVG00dDBodHE1WGtlSEZWTGQxbElLWjQyeDlsTXAxVm52WWgzQ3lW?=
 =?gb2312?B?ckJQOUpkVy9vRXNscnlrZkdXeDlNMFpIcTFvVmk3clhzUmdQTy9jQUVDcVl1?=
 =?gb2312?B?Ync0UzJaVW5YVUd3NkY2T2NSeVFLbXNBNmRyZlNNOGVmUll2UFpGdlhoNmJQ?=
 =?gb2312?B?dWR6U095UzJsNXByRDN0NUxDS1ppbVArNy9hcDZpRkhwR1o4YUZrdzQvSXIv?=
 =?gb2312?B?dE5BcUl5Q0luYUsrY0h0V3o5dEdCTkFWT0VtektZNkIxbXI0aUp1RVZrQ09k?=
 =?gb2312?B?Vk9Pb1RMRzVSbDc1dmJLVTFqLzFQSkRUSFhhWDRqMGsydlJXQ1FCcHBUdkRJ?=
 =?gb2312?B?NzN5bW9zbVhoWVRKMWg4UTdJcFNHMmM3dlJqdFY4bFVmSjV6S3ZoSXlHdTdR?=
 =?gb2312?B?OWJScW9ocWZiTkNKU1BXN2FHTkZrVm40aGpFdkFQY0hHNk0zZ3NMdWpVUlpq?=
 =?gb2312?B?NStETHJzRHBVdnpkZGcraDlMR2JIQzZMVXZtdG9zS0VxK0FoM1FDd1ZSNWxo?=
 =?gb2312?B?UzFmOHUrZzkxTnM0SjR2elcwT2RQZ09qRkd2eUFqcjJsTjlGazdCYzliSFcw?=
 =?gb2312?B?L29TWi9ITHV4a0t5SVRvSzlmUTh1RlFZS1FRN2Ywb2tENk9KT2JBMTdhMStM?=
 =?gb2312?B?NDJRT2hwbHc3N3pWWEpROFhFRzh4VGtsdUZlZVFUclNCR0JORTI1Nmp2eW1S?=
 =?gb2312?B?NDRtemtUa0pvKzdKcnpBWUx3T051b0U0Rk5vZDBUZXpiaGluYmNhazFXc2JN?=
 =?gb2312?B?VmpRNFBQS0xpWlBOaldTVlY0U3BFa292S0dKQW5Qa1RieTl6akwwaGNmdjVK?=
 =?gb2312?B?YmY2Mmpia3N2YnBPNVowWCtCZ0pDNklIUDZRS2Rlc3hSQ3FtdXBQT1lCUjNx?=
 =?gb2312?Q?ATfAB7ZVnt0oPNW/oXzLwyd1o?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8411.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d47009-d014-4a79-b6b2-08daddad4710
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 08:29:11.7236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYZnrH2vY/obcNyUkcnmuqK3uNHmeX1M0TREoEN6MovdwCtUCI5dE+82YFuyacAwjP3zu+/arNUCk1cMVkzIMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9278
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogZ3JlZ2toQGxpbnV4Zm91
bmRhdGlvbi5vcmcgPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiBTZW50OiAyMDIyxOox
MtTCMTTI1SAxNjoyNg0KPiBUbzogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiBD
YzogamlyaXNsYWJ5QGtlcm5lbC5vcmc7IGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBu
eHAuY29tPjsNCj4gYXRzdXNoaS5uZW1vdG9Ac29yZC5jby5qcDsgdG9tb25vcmkuc2FraXRhQHNv
cmQuY28uanANCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMyAwLzNdIGZzbF9scHVhcnQ6IGltcHJv
dmUgSWRsZSBMaW5lIEludGVycnVwdCBhbmQNCj4gcmVnaXN0ZXJzIGhhbmRsZSBpbiAuc2h1dGRv
d24oKQ0KPiANCj4gT24gV2VkLCBEZWMgMTQsIDIwMjIgYXQgMDI6NDM6MTZBTSArMDAwMCwgU2hl
cnJ5IFN1biB3cm90ZToNCj4gPiBHZW50bGUgcGluZyBmb3IgdGhpcyBwYXRjaCBzZXQuLi4NCj4g
DQo+IEl0J3MgdGhlIG1pZGRsZSBvZiB0aGUgbWVyZ2Ugd2luZG93IGFuZCB3ZSBjYW4gbm90IGRv
IGFueXRoaW5nIHVudGlsDQo+IDYuMi1yYzEgaXMgcmVsZWFzZWQsIHNvcnJ5Lg0KPiANCg0KT2gu
Li4gb2theSwgdGhhbmtzIGZvciB0aGUgaW5mbywgc29ycnkgZm9yIHRoZSBpbmNvbnZlbmllbmNl
Lg0KDQpCZXN0IFJlZ2FyZHMNClNoZXJyeQ0KDQoNCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgN
Cg==
