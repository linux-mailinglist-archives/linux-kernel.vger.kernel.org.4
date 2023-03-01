Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28A66A6767
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 06:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCAFjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 00:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCAFjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 00:39:31 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2082.outbound.protection.outlook.com [40.107.14.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F34B21954;
        Tue, 28 Feb 2023 21:39:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmRDgj3FpSPYBgX3tZSwjmWl3dCG9e9uAg7oW2QXnTlRtiuSvY1pvQvFUkCLELHVofGpS+J3HTO2O2ssi7NDqh/1lEQh6rMnAvEbodDs8+No5ZRgg/XHLUEde1nRtZqTarokOcv/Ed0GW0Fur1O8EYszwXSK2FGxSfyC0rG/jPwKK4uJZlEw7W+qs18cAM6nPj7jRuObWzX1lSTbGf0ON9L69enLlvC1iHcXiaabXR+FJWOzq1LFncCdZ0+KfKsCcsMJLHJ+8drDinw1mnN1kiZ7+EOGMyK7GFU7RpIcR9+H0dQR76HOz6qrmMITDF0L0khfUjjMzAhcrJa159dz9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYkW6fgx3zPXUlvtyQzC9RU7sW5wi2L8MS4uc1e3sZ4=;
 b=Wfrx1YTGNwGd5jyuAHLtCLa/AZKYaU6tVUzkuV3cAQk9DOKzjMoQzDMXv26Ky8PtBPv7zHj/YVczHBofpzWaiPUHNpu8p12/ydjVThQJlyyW0kNpre2kMjjwVWSZxGyi1EMuNd1lCyPvCS94bwNDrAYuD5NInWwyqwyGKoTUXI99XNMu2RnBJLFlOcxWgzlKZoP1J5m7pcch6eO81jZS3S3/1Fi6F6DMLibNAvr0yWgqO+Gzq+rUacY9NDBuYl707qY0rJzFiz8L6LcEe3LNee17HbwPFYXbBjCpu54wRwt0Amr4jZyYxIcuTKQSOICmM6xWzBfzcXUep0oV0mAXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYkW6fgx3zPXUlvtyQzC9RU7sW5wi2L8MS4uc1e3sZ4=;
 b=LVhhiq9VPsawSto2OeVVLb3w9//STIcuVYcY4q/b4rJmpfUkWS7CsPXrhJz2dfHAuA0CT+NgfBCpZqydzQ/zEQ1ymrtcPgSS4SnOxqEMoPME2gO+CjBTWPqosqyv/A7lwR2RYqiSgWWWzsBAlZDRWEM10n/6WegVp6AHS5/HTyY=
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by PAXPR04MB8526.eurprd04.prod.outlook.com (2603:10a6:102:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 05:39:26 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%4]) with mapi id 15.20.6134.026; Wed, 1 Mar 2023
 05:39:26 +0000
From:   Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Franck Lenormand <franck.lenormand@nxp.com>
CC:     "code@tyhicks.com" <code@tyhicks.com>
Subject: RE: [EXT] Re: [PATCH] drivers: crypto: caam: jr: add .shutdown hook
Thread-Topic: [EXT] Re: [PATCH] drivers: crypto: caam: jr: add .shutdown hook
Thread-Index: AQHZRbcdZwi0NNJ1FU2rf8OJ6oegUK7ZqW+AgAjGiwCAAwSxoA==
Date:   Wed, 1 Mar 2023 05:39:26 +0000
Message-ID: <DU0PR04MB9563816236B13CBB7F398D528EAD9@DU0PR04MB9563.eurprd04.prod.outlook.com>
References: <20230220105033.1449263-1-meenakshi.aggarwal@nxp.com>
 <20230221054047.2140558-1-meenakshi.aggarwal@nxp.com>
 <d253d5ba-8e57-dc20-dfb4-08aac9e92a4c@linux.microsoft.com>
 <DU2PR04MB8630B140D8B546864FBA016095AF9@DU2PR04MB8630.eurprd04.prod.outlook.com>
In-Reply-To: <DU2PR04MB8630B140D8B546864FBA016095AF9@DU2PR04MB8630.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9563:EE_|PAXPR04MB8526:EE_
x-ms-office365-filtering-correlation-id: d2da10ef-cbc7-42f9-7c3b-08db1a1751df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HV8diZoGhOTKCvuZYDiX9UD/VKyNUWVaYlnNbXXKEXJVyB823ywQtyw1NIxnUj6Yvc3PW/AhN1RL72Pdd+NhCoKY/jXvTfyq1aKoLun1ZiThaql5MJUh2OQsQhiVFWRZttkXopQGB37pUKiUGS/zqBruqkQmnrUoylPUDhn3VNIPaajs0mKbcY9hSSz6lxdKpKW5PGj1QgoR/0MbvCEAuIfvxz8O2oMk4J70bTW7vQo4129RLjyrwPYBur31oaYprlYh0zFJqjw6Fwb8RAxVm4df7MDyEQZj76M+/PDtdTVbhf0dxlkq7t3+V/IXnmwGUI9PtsEVLCT/wm07CqOMJmCvXxm2PC8ajMf5Tv9LP3I46wWUT7BeSP/nSM2+JeX8W6X2uIHlytxlFpuXVKZEda8fY31MN1BwXsqF2jeIpu7cWnzOKhUak7eTRcDW2SLZyI+Cz+YWS0v79oXUn15akVbO4KZH4PH1cPfyms8LuLq8SzBennVoueASPNUuo1F8HSHgVwUdP/7SV7dHT0qLqhr/Bcu1fd3bJUC7fAvCQ+Vzz4StLsrMwU8VEvpiaCCPHh9Fpx+ONrz9FrpzH34E02q7VtfhYfWcxId1PgVY8GllcFFSDQOLI614nIRu4z3NBiG6GXT9ybkiTftdnGwVp5iFQtJjHIFiYYlDcABgj+q0mjEwjBu+tlZauGWUYvRUNi8ddTZbSH+s8oFb1PGj7/EzQVo9drn8RdsyQ3TkCX77/4lGhhPtVDnoV7HMyDc+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199018)(38100700002)(122000001)(921005)(38070700005)(86362001)(33656002)(2906002)(44832011)(41300700001)(55016003)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(8676002)(5660300002)(8936002)(52536014)(76116006)(53546011)(6506007)(186003)(9686003)(83380400001)(110136005)(6636002)(478600001)(316002)(7696005)(71200400001)(142923001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWpTZ2JPcmI0RDdqSDJSbktKejU4SUo4RVYzekVEbjQ4TWNIWUxmNDJIdjUv?=
 =?utf-8?B?WFlUZFc2Tjg5Q1RiQkdFbW93UFRaNXlZSUVIamtyejJLcTlvQWMvamVaQnpr?=
 =?utf-8?B?cEI4Q2FhblhHb3Y5WHBhTVhqcWhRUlo2OFJDNzRuMEV2YVFvd2RhNmtoVzFT?=
 =?utf-8?B?RHorWDVQZi9JVUthUmtRR2ZZMXB2YmRueXJKL2ZHVEdyREdMOFkwVm9XWnR3?=
 =?utf-8?B?VVJNK1I1cU9zZ1VEUG10UFpTaTVpN1N5OVVPeG1VVXRXQTVGOTBLM3hINDN3?=
 =?utf-8?B?LzFuRFBYSGxuK2RJWXdiWWZ0QmhhcFJKaHFXaWJuWFlTQ0pEM3oxTy9RWlRV?=
 =?utf-8?B?YTE0L3RvSGk3cHdJSkVSMGFCSVZJcVZpTXZ0M3R4ODErSnlzOHJUd1ZsNEZl?=
 =?utf-8?B?VU13ZlNEenQyVS9YUHJJY3IzNjVCQVI3RzgvTlNFbU43SHdRWXl0NEpPSHZD?=
 =?utf-8?B?czA3aWtrT05sK3V6cmQrdkFydDRhTEgwWUlsN1JnNkhXQitVMU5UM2M5d0Fy?=
 =?utf-8?B?OVQvRTJCUlZpR1hEME12ZktHRHU4b0Nqd1NBNEtXa054bWh0VkVET2EycEcr?=
 =?utf-8?B?YUozUU84UHR1SFo5cVZCWVIvcElvNS9DclB2Qjc2MytJZjNaekQ0bncrbFJo?=
 =?utf-8?B?T1ZGYnRSSU1xMjZNaEF0dG4rQ0ZWUzlkRW1scjduQjRjaTMwSHgyZytqQVpD?=
 =?utf-8?B?aVhwb1NLZmNWQ2dFTnJubU9UUlY1UGdPZmxpNXVjRHMrdEovR1JSaStoeGti?=
 =?utf-8?B?ckt1ZjFYQ3JobHA5WEthMmJpUFZUd0NXTDB5bzF5eHFZTlk4YVEzT3NSeWZ3?=
 =?utf-8?B?UWJEUFA4YzZJVW9SWW53VlpqdUFkVk9GdUtEQThWZ1BZc0RpVjZOMEJvTGZq?=
 =?utf-8?B?cndJbmRtNy83UElPbFVYWm9GbU1nN0pEb3RFdjQzQk1ING9jZ1d1RXcxQmk1?=
 =?utf-8?B?RkoyVk9DbEQvaW96QXF6NERPVVB4RlVxM2JubXRMNW9UYXM5Z1IvVTZEL0Ry?=
 =?utf-8?B?T1dxRDNKTmk2Wkx0Y0NEcE1lSGZDQkhGVWZ0eXAwUkhqZnphMGRjRHVVZENv?=
 =?utf-8?B?Q3Q2V1hNR2p4ZEtMaEFMa2gvRXJoejJWUENrV2EzQWU1RklMeW0zVGNTMXRk?=
 =?utf-8?B?Slc5VkFieDhMeElVNWVXckxrcEhtNjZQcmF1bHhQd05Gcm43bmlkTVV0cHBZ?=
 =?utf-8?B?QWM5U0VweWlSRStXYjhxNysrcVZrV3VTekllTVVUUEFJenltdDd6Y3RyNkoy?=
 =?utf-8?B?Y3lYd2NWbEl2ZUI4WGJtWDhib3JIKzB5cTR0QlQ4ZUNKQlhaeWpXcWx4clAz?=
 =?utf-8?B?TkFxNmhsZzJIVjhxU3VQUVhBRzMrTlpNelJMbzFyV3FmVy9hNUZFdUFuN0hZ?=
 =?utf-8?B?RlFnOWVsaU9IdTNCdGMzRWNzVnJaU25LYTRxdTNCMFZDUGlBTFVNRGQ2ZnlK?=
 =?utf-8?B?VTNPMkk4TEV5QUNtZUo5Q2lmelVMNTlEVEswV2Uxa05mTGR3YXFaNlVFSDVE?=
 =?utf-8?B?K1JUcE1rV0lQeEFGekNkeFUrd0E1d3dtZ056eTdlQ2Q5QnQ1bWNIOTNoNlhH?=
 =?utf-8?B?YUdSNlc3WXp2WCtrRG9HQjNJOXJIcDZwTE9TQ0pSdGpJL0FIQUpSdW5NL3Zk?=
 =?utf-8?B?RzFhUEdNTEpEbzZEV0lydFgzVWVWM1pENE9EM1hVM1FmaHd0N0hPNnUxYnpt?=
 =?utf-8?B?dzBTTTFBdjBxMUk1UVM3NUZGcXFMdndreEM0ZlM4TVlER2ladC9QYlJFUFBK?=
 =?utf-8?B?NTlsb3dNWnUzK3o4VFNvN1VtekJRUjNrVHIzRjhJaGtXRjJvRTdiQ05ScU12?=
 =?utf-8?B?RFhGQnhuSnJnK0ExUzJKZnhoWE9Oa0YrcGx5YjBFS3FMYk0xRTJXcVVzalAv?=
 =?utf-8?B?K1l5RVVPMUMxSnJlaGtJVFlmM21hdkpvMEczL0JhZHgwbmNweHV4eXArd2pn?=
 =?utf-8?B?cTFhS3dTWWpNcFkrRlNILzYvdk1IVU5NUmZLd2ZPWXRMTldOS0toSm10VzNM?=
 =?utf-8?B?SjRSdE5nakdMZkFSUHpESHBWZkNOeFBWZ1c1YzI3TlpiRDNZVUM3Ni9RN1Jy?=
 =?utf-8?B?b2Ywc2p0Qm1GZStCbXBzRzBRSU1ZSGZ4dTNKMkVnVXZoZHlqQUhaMkFjYms5?=
 =?utf-8?B?NkVJRkhxck9XTnF4WU5JYVhucm1FMHBta0p6cEZGejhjOVlDUUZwbnVTZFIv?=
 =?utf-8?B?TURTSU96TWxWWkhZWFpna25hRjZyRStvZlVwNUYzMXFhcmt0ZmFKNXdna1Y3?=
 =?utf-8?B?RmpjR3YzZHc2QlVOR1lIbHBFdzZnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2da10ef-cbc7-42f9-7c3b-08db1a1751df
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 05:39:26.2916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hwG9R5wPq+mJXaUm2QJPL/SzDNumAE9J0DIVbKGftI87L2kFsjhAJVm8ajDHNngeOmuJPa3z53UdnCoq2yonDcdE1+5VMjN2p6lZrHx/9DM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8526
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q29weXJpZ2h0IHVwZGF0ZWQgaW4gYW5vdGhlciBwYXRjaCBhbmQgc2VudCB2MiwgYm90aCBwYXRj
aGVzIGFyZSBtb2RpZnlpbmcgc2FtZSBmaWxlIHNvIG5vIG5lZWQgdG8gbWFrZSBhbnkgY2hhbmdl
cyBpbiB0aGlzIHBhdGNoLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IFBhbmthaiBHdXB0YSA8cGFua2FqLmd1cHRhQG54cC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgRmVi
cnVhcnkgMjcsIDIwMjMgMTowMyBQTQ0KPiBUbzogVmlqYXkgQmFsYWtyaXNobmEgPHZpamF5YkBs
aW51eC5taWNyb3NvZnQuY29tPjsgTWVlbmFrc2hpIEFnZ2Fyd2FsDQo+IDxtZWVuYWtzaGkuYWdn
YXJ3YWxAbnhwLmNvbT47IEhvcmlhIEdlYW50YSA8aG9yaWEuZ2VhbnRhQG54cC5jb20+Ow0KPiBW
YXJ1biBTZXRoaSA8Vi5TZXRoaUBueHAuY29tPjsgR2F1cmF2IEphaW4gPGdhdXJhdi5qYWluQG54
cC5jb20+Ow0KPiBoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU7IGRhdmVtQGRhdmVtbG9mdC5u
ZXQ7IGxpbnV4LQ0KPiBjcnlwdG9Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBGcmFuY2sgTGVub3JtYW5kDQo+IDxmcmFuY2subGVub3JtYW5kQG54cC5jb20+
DQo+IENjOiBjb2RlQHR5aGlja3MuY29tDQo+IFN1YmplY3Q6IFJFOiBbRVhUXSBSZTogW1BBVENI
XSBkcml2ZXJzOiBjcnlwdG86IGNhYW06IGpyOiBhZGQgLnNodXRkb3duIGhvb2sNCj4gDQo+IENo
YW5nZSB0aGUgeWVhciBpbiB0aGUgTGljZW5zZSBoZWFkZXIuDQo+IA0KPiBBZnRlciBjaGFuZ2lu
ZywgeW91IGNhbiBhZGQgdGhlIHJldmlld2VkIGJ5IG1lLg0KPiBSZXZpZXdlZC1CeTogUGFua2Fq
IEd1cHRhIDxwYW5rYWouZ3VwdGFAbnhwLmNvbT4NCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPiBGcm9tOiBWaWpheSBCYWxha3Jpc2huYSA8dmlqYXliQGxpbnV4Lm1pY3Jv
c29mdC5jb20+DQo+ID4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMjEsIDIwMjMgMTE6MDIgUE0N
Cj4gPiBUbzogTWVlbmFrc2hpIEFnZ2Fyd2FsIDxtZWVuYWtzaGkuYWdnYXJ3YWxAbnhwLmNvbT47
IEhvcmlhIEdlYW50YQ0KPiA+IDxob3JpYS5nZWFudGFAbnhwLmNvbT47IFZhcnVuIFNldGhpIDxW
LlNldGhpQG54cC5jb20+OyBQYW5rYWogR3VwdGENCj4gPiA8cGFua2FqLmd1cHRhQG54cC5jb20+
OyBHYXVyYXYgSmFpbiA8Z2F1cmF2LmphaW5AbnhwLmNvbT47DQo+ID4gaGVyYmVydEBnb25kb3Iu
YXBhbmEub3JnLmF1OyBkYXZlbUBkYXZlbWxvZnQubmV0OyBsaW51eC0NCj4gPiBjcnlwdG9Admdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBGcmFuY2sgTGVub3Jt
YW5kDQo+ID4gPGZyYW5jay5sZW5vcm1hbmRAbnhwLmNvbT4NCj4gPiBDYzogY29kZUB0eWhpY2tz
LmNvbQ0KPiA+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0hdIGRyaXZlcnM6IGNyeXB0bzogY2Fh
bToganI6IGFkZCAuc2h1dGRvd24NCj4gPiBob29rDQo+ID4NCj4gPiBDYXV0aW9uOiBFWFQgRW1h
aWwNCj4gPg0KPiA+IE9uIDIvMjAvMjAyMyA5OjQwIFBNLCBtZWVuYWtzaGkuYWdnYXJ3YWxAbnhw
LmNvbSB3cm90ZToNCj4gPiA+IEZyb206IEdhdXJhdiBKYWluIDxnYXVyYXYuamFpbkBueHAuY29t
Pg0KPiA+ID4NCj4gPiA+IGFkZCAuc2h1dGRvd24gaG9vayBpbiBjYWFtX2pyIGRyaXZlciB0byBz
dXBwb3J0IGtleGVjIGJvb3QNCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBHYXVyYXYgSmFp
biA8Z2F1cmF2LmphaW5AbnhwLmNvbT4NCj4gPg0KPiA+IFRlc3RlZC1ieTogVmlqYXkgQmFsYWty
aXNobmEgPHZpamF5YkBsaW51eC5taWNyb3NvZnQuY29tPg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+
IFZpamF5DQo+ID4NCj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2ZXJzL2NyeXB0by9jYWFtL2pyLmMg
fCA2ICsrKysrKw0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4g
Pg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3J5cHRvL2NhYW0vanIuYyBiL2RyaXZlcnMv
Y3J5cHRvL2NhYW0vanIuYw0KPiA+ID4gaW5kZXggODc0NWZlM2NiNTc1Li5hMmE5OWQwOWI0YWQg
MTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2NyeXB0by9jYWFtL2pyLmMNCj4gPiA+ICsrKyBi
L2RyaXZlcnMvY3J5cHRvL2NhYW0vanIuYw0KPiA+ID4gQEAgLTE5OCw2ICsxOTgsMTEgQEAgc3Rh
dGljIGludCBjYWFtX2pyX3JlbW92ZShzdHJ1Y3QNCj4gPiA+IHBsYXRmb3JtX2RldmljZQ0KPiA+
ICpwZGV2KQ0KPiA+ID4gICAgICAgcmV0dXJuIHJldDsNCj4gPiA+ICAgfQ0KPiA+ID4NCj4gPiA+
ICtzdGF0aWMgdm9pZCBjYWFtX2pyX3BsYXRmb3JtX3NodXRkb3duKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpIHsNCj4gPiA+ICsgICAgIGNhYW1fanJfcmVtb3ZlKHBkZXYpOw0KPiA+ID4g
K30NCj4gPiA+ICsNCj4gPiA+ICAgLyogTWFpbiBwZXItcmluZyBpbnRlcnJ1cHQgaGFuZGxlciAq
Lw0KPiA+ID4gICBzdGF0aWMgaXJxcmV0dXJuX3QgY2FhbV9qcl9pbnRlcnJ1cHQoaW50IGlycSwg
dm9pZCAqc3RfZGV2KQ0KPiA+ID4gICB7DQo+ID4gPiBAQCAtNjUzLDYgKzY1OCw3IEBAIHN0YXRp
YyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGNhYW1fanJfZHJpdmVyID0gew0KPiA+ID4gICAgICAg
fSwNCj4gPiA+ICAgICAgIC5wcm9iZSAgICAgICA9IGNhYW1fanJfcHJvYmUsDQo+ID4gPiAgICAg
ICAucmVtb3ZlICAgICAgPSBjYWFtX2pyX3JlbW92ZSwNCj4gPiA+ICsgICAgIC5zaHV0ZG93biA9
IGNhYW1fanJfcGxhdGZvcm1fc2h1dGRvd24sDQo+ID4gPiAgIH07DQo+ID4gPg0KPiA+ID4gICBz
dGF0aWMgaW50IF9faW5pdCBqcl9kcml2ZXJfaW5pdCh2b2lkKQ0K
