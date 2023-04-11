Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B35E6DCF7E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 03:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjDKBrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 21:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjDKBrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:47:07 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2062.outbound.protection.outlook.com [40.107.255.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9566126AE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 18:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcMWbD8aWYzl+PVVkUuJ6HuC9uYYkSYByppELeHpBM+2Y7tXKbok1m0XMaWgcw9BtXCs76mx0lSXpWd+Dc+Dsd7o6gflQkutc1YXhP5dPYLvJigDxK6CI2FsnXUod7JbpyHYI2x6WIMRN1iE4o9baqWyNqmfJGFuXraD840KsH296yhkh41n7KadF58nkbE9Cgs12e5yCzeNO+qImtdCCAWWM944kFAuvvl2Rw8N/pTfsMUMrqd9cWvKoHoeHwm5SoqbRB07SQk7cplc4Fw1h3h5DwJFvY48Kpb3T7UZP+bjLuVuP2dTI1Rj7dOHRYzNadV0JLsVHvTZSZVMScgapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miUZfi7R2QsJRlAL2CBxMrk3ZcrfhdnLOpZE/19sZms=;
 b=QtakV77I9p3zxdRB7agZaDpFfs+fI3ErMHv9q7Mi+dXr3ELfHYz3vwhlfdX59/HbFoBIvsO7BUt82H/jUKvujRX7whNPZQGfBIMzJo3Jb33hokFSOb5Mt7sXx9cHoj3mwdqidoznubYTIycBOCSA1R8YSiwOfZDTVQrrdrHVjvKk1a6i2jlxPmeAM+Mni4V6W5tw+WNkNdpNUAfCQbOgdnE4dU9O8K6ur847348hxwvN4gGslHZq55TFUAir+Ee65qa2v/jfFk7nFn4kbW4HLnYntsurQa34OykQPRi0Cvfv6n7SIBtgthDRVMjIO/gU5rMbtCttbYynJI1nPEfvmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miUZfi7R2QsJRlAL2CBxMrk3ZcrfhdnLOpZE/19sZms=;
 b=W1az+h6ZQJvwQkOm2HZevasRpfRtMb/DBad0oidhedYykh+mjv5s5LCSdNNt5zGz/2AcsPIxgULe/i62hoLziKSTcQSb9l9qRonGzJSgZ4PdkL3xbLyyYSbDmFM5ck4JX1IxLMO5kbS3aap6uN9S3tKSb3tX4ySGhoRXFhA+q6XnNATY5rrb1fEOXDugg2bP7jDhUgUq+kZ4WqGk2Q3BaZ5Jk1fPZRW00loJ+lJBs/oR2hBsJKqmqQZ2Bj/6uFZ1eTT027RBeYk7JGuFRYNVTigjmf5VjXSFFQVjhTWd21SNfrCsvF+jaS0M7ZafjycFXM1VTKYzUaCpi8U8J57gow==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by TYZPR06MB5507.apcprd06.prod.outlook.com (2603:1096:400:289::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 01:47:00 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6%3]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 01:47:00 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] virtio_pci: Wait for legacy device to be reset
Thread-Topic: [PATCH] virtio_pci: Wait for legacy device to be reset
Thread-Index: AQHZbBZh3jvrK38aOUOklBMw4wCkQq8lVKlw
Date:   Tue, 11 Apr 2023 01:47:00 +0000
Message-ID: <TY2PR06MB342406D4DAA8F62140E461DC859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
In-Reply-To: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|TYZPR06MB5507:EE_
x-ms-office365-filtering-correlation-id: 4fd40ceb-d699-4026-e5a5-08db3a2ea45c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZAG3vPBbfQ62qPRwMwjbum6F4fiMktHrRzzvkTiIggmTnFnMR0DKWlqC3H6FPcBwXfAR/NKWFXJus/ays4ey5RUmG7PzMndhHGrvI27YIznaHJpTXyOi5jdEL280z2to/pVb5Qgu8oPmgzBt4fBVOZR4gQktpxptS+m8rvRNphKOX8poRyr0IWqRVQtvEF573eAF0TVTCi4DunOi83EXiMJoO8tyI8cW5l4bCdozAubUUY7Tu0fCO4kcZ7ZEjIo/Qb0bVtruwez5tyG3xnzWS7GhJk8wytB1/aV6kpriaiETTsP0JGxfoCRowoozlNAWptoZZyU18O7LKKB6EWSMbGcEB0DGNi5UwsJsi7VYBmoAw1nIgcFQyoRQ7XySR+fgFS8kUYO+/tdPS4xcyCBz0PnK2GZhhO2qu0Gv+92Eiasw9IECHQoK79L/oXFOijdXnEF3aFQQH0/sYftywnyHKPjdc3tSN6qrq4QP6RX9QEawN5St+LIIbDV3Ii+fZgUedDobRRmjPu3eVLGwpNFgmPhG0esNytFpEiAwAC5Uv7oivOFjwFG+tzoJ6w4RRIXOa64QD8OZS2jO6jv52H5nc8I219h2XLtaX95ZdDVUIILYfoeVe2A48wBlF7hMgb34
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39830400003)(346002)(376002)(451199021)(83380400001)(316002)(54906003)(478600001)(110136005)(33656002)(55016003)(9686003)(71200400001)(26005)(186003)(53546011)(6506007)(7696005)(38100700002)(64756008)(66946007)(76116006)(4326008)(2906002)(66446008)(66476007)(66556008)(8936002)(8676002)(86362001)(41300700001)(52536014)(44832011)(5660300002)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXZwUGpEcFo4OW8rbjFrWlUrTkpPUG5XWXNSRmROaDBkQ1dOUE40R3BsLytV?=
 =?utf-8?B?c3BpNjVEOGpDb3hROWVXeDU2MkZrUlNZVHV6UnkvdWRrWE5VNXN3Zm5DRStG?=
 =?utf-8?B?TVFnVmoyQkZNbUNaOEVacndCdisySFR3ZnQ0eUgxVXRXbkNULzdKeFJNRGg5?=
 =?utf-8?B?S042ZW5QbTFYVFJBd2k4UExlNU1tYy9kTVdKeitaQWY2QWtsMjVaMk5DcTJZ?=
 =?utf-8?B?QVVBcVVHTldrVmN5U2NjYjJYSWFWdzZ4MERFOEV6VGRSdE9ic0xPNFFqZlIv?=
 =?utf-8?B?dzFsaEtiU2lqaExnZUpQTTlTbTlKdXpHbW9OYU4vaXM3YUVwZU5vKzM4aDZ1?=
 =?utf-8?B?TmRkTTNhdmlLckxZcUkrcFV5b1Y0YVZKMzZrMGpkOHpTRUttRStmZDF1NHc1?=
 =?utf-8?B?b1FoNjl1Uk1SRS9PNTRPK0pPNFN3VG1rU1ZHd1ZqMG9mbkRlbzhPWFZBN3dR?=
 =?utf-8?B?bTJsMXBqbDZ3c2tPb2JUbG9wZWl6WEN6Q3JLWU5LblZvY05CakRKaU4xK0p1?=
 =?utf-8?B?RnJPdHU3YmZFcnQ5bjRlZjRRdkhNWDc3aVhIRmMzMkljd2c2Z1dPRXBPZUZ4?=
 =?utf-8?B?RFFWVm90MUVBNklMRkp3MGw2TytaTmg0blpIZHJGS3Y4dWZrNkYxZGtQaUtW?=
 =?utf-8?B?TlYrd3VrS0FFRmJLREQ0UWl0ZXBDcjV3bkdOSkJQZExiN0Q3RVBieWJXZVM4?=
 =?utf-8?B?QVlLYWtaSHNDa0tENHVzUkRSc1dreVdsNDdjSmdrZmRWcmFLUDJPRWJnL3l3?=
 =?utf-8?B?MXdrTHZNcU5ldU5Nd2tmSEVPMTI1RFFrd09jR0RXY2FlRWpBKzM4VFIzS2Zy?=
 =?utf-8?B?bThKS1Jjd1NTaXVYaFhiNGFyVUVpNnJqLzBxNE5OeXZGSldFSTJvZEFUL3Rw?=
 =?utf-8?B?TDlBcEJ3NVpxbVpCVGR5NmpFdm4yUnpTM2gvTy9HZm9SYmVuK1NWMVJ6ay9n?=
 =?utf-8?B?UUE0WnNzVkowQXZOWVJPcUVnOGNDZ0psN05kNWZVdDljMGY5SjdoMVhUOVhS?=
 =?utf-8?B?MlovTkNhbFFoZDJyNFFCYVMrd0xQRU5PRytRV0dtcU1nQmFnUW5kOFNqSUgx?=
 =?utf-8?B?RVJBci9UcytLdkxPWnZtUzJHZnp6RzBwT2lpMXdJOGdFSFpiaC8xczNrWlkz?=
 =?utf-8?B?RldsM1pOU2lpYlZjcjh3SzM3WDVXL1NMOUZXY2d4Y09pbVV4QUxIZi9aSmdx?=
 =?utf-8?B?STlxM0tDVENaemNDVWhkQU55d05QWWR4UVhZWXc1RUh0Um5IaGU2TDN1bXpP?=
 =?utf-8?B?RHREUmJlaGI2dVdyeFZxNVVDYVBXbHd6a21id0k5bEtXanJKeDFsOVBwc0c3?=
 =?utf-8?B?ckZoVjJjQXFEWURQTXhaUkpPYXBZS1hkNXQ4WExPTXZDTGViVzdtOThid0tp?=
 =?utf-8?B?dm1jcC9lNitJSEFVQVZDYnVYTXRBYWZCbUVwRi8xN0hIejB2OXp2L0xTTkd0?=
 =?utf-8?B?KytKQSt4NmxaNXJBZkh6dWtlV1FaY3hib3Fad2tic0FlbkN5bjhwSnJuWFVv?=
 =?utf-8?B?N0hDa3lFMXJNY2R6dU9nVXVWc2hzTXRVcDYwd0dEKzZYSW9iUmsyRldoMFBB?=
 =?utf-8?B?UzVsejBndlRyM25LZGk4cmlOQjNhVXlCWnNZdGYvSHF3RjUvb0ExdWZ0OWgw?=
 =?utf-8?B?UVdDV0Y3WmhwT1pnY1R4M1ZTRzl3Z0FZZ1NDTEpwSkI3bnZZNDJVR3BzRW4r?=
 =?utf-8?B?T0E5aVp1SEJmU2hYdHhJL0ZaSHpiSjJmRkNTNVgrTysvZUE0SmpFT0c3UWpF?=
 =?utf-8?B?MTFQRWVsMjhpU3AzSkw1WkV4UDU2SE5JeGltRndWRGY3S05iV29QSm5YTFF5?=
 =?utf-8?B?QUNsODBFc2VCTi9keVozai8vSnFGdDVyR1F3eVlZREVzbjlGUDNNWVJWOURz?=
 =?utf-8?B?cXFVbWxVeEZVcExZbjh3MzNEOXJnVUYrdFhudGREUk5vM2NKZlZPcnZteTk0?=
 =?utf-8?B?Vk5CVnozYk04c1hrZ0FURGVkcklvK0ZaQ3RjbVlTeExoejMyZWRGTjJZR0tq?=
 =?utf-8?B?cy8wY3BCUVgwUG1MMC9Ldk92ZlYxbEhXbVFvQitvMEx1SjJoSkVZS29JSDdp?=
 =?utf-8?B?RTI3L0tPdUxMdktxMTJlZ3dCRmN4TEQvSm1yY3JNQ2pibUJxVmZWdWxyL3RB?=
 =?utf-8?Q?ATpCY7L3CdWaFY91BbLSoeLpZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd40ceb-d699-4026-e5a5-08db3a2ea45c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 01:47:00.2976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MmrMuVSx0yTna3uBg7pvA5LtBWlt4Xdctj2JDRU1NsLKT2tkZavJau1NjUFe1i3Fg51aAYxzn5EUowCedbcTUhIm81TN5J173Wr7992xuyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5507
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkuDQoNCldlIGdvdCBhIGxlZ2FjeSBwcm9iZSBwcm9ibGVtIG11bHRpdGltZXMuDQpBZnRlciBy
ZXNldCB0aGUgbGVnYWN5IGRldmljZSxhbmQgd2UgcHJvYmUgdGhlIGRldmljZSBxdWlja2x5LA0K
V2Ugb2Z0ZW4gZ2V0IHRoZSB3cm9uZyBzdGF0dXMgb2YgZGV2aWNlICwgZXNwZWNpYWxseSB1c2Ug
aW4gdmRwYSB3aXRoIGxlZ2FjeSBtb2Rlbi4NCkl0J3Mgb2Z0ZW4gb2NjdXJzIGluIHRoZSBzZXQg
dnEgc3RhdHVzIGlvY3RsLg0KDQpJZiB3ZSB1c2UgbW9kZXJuIHZpcnRpbyBkZXZpY2UgLGl0IGlz
IGRpc2FwcGVhci4NCg0KVGhhbmtzLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IEFuZ3VzIENoZW4NCj4gU2VudDogVHVlc2RheSwgQXByaWwgMTEsIDIwMjMgOTozOSBB
TQ0KPiBUbzogbXN0QHJlZGhhdC5jb207IGphc293YW5nQHJlZGhhdC5jb20NCj4gQ2M6IHZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiBBbmd1cyBDaGVuIDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4NCj4g
U3ViamVjdDogW1BBVENIXSB2aXJ0aW9fcGNpOiBXYWl0IGZvciBsZWdhY3kgZGV2aWNlIHRvIGJl
IHJlc2V0DQo+IA0KPiBXZSByZWFkIHRoZSBzdGF0dXMgb2YgZGV2aWNlIGFmdGVyIHJlc2V0LA0K
PiBJdCBpcyBub3QgZ3VhcmFudGVlZCB0aGF0IHRoZSBkZXZpY2UgYmUgcmVzZXRlZCBzdWNjZXNz
ZnVsbHkuDQo+IFdlIGNhbiB1c2UgYSB3aGlsZSBsb29wIHRvIG1ha2Ugc3VyZSB0aGF0LGxpa2Ug
dGhlIG1vZGVybiBkZXZpY2UgZGlkLg0KPiBUaGUgc3BlYyBpcyBub3QgcmVxdWVzdCBpdCAsYnV0
IGl0IHdvcmsuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmd1cyBDaGVuIDxhbmd1cy5jaGVuQGph
Z3Vhcm1pY3JvLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2Fj
eS5jIHwgNCArKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdh
Y3kuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMNCj4gaW5kZXggMjI1N2Yx
YjNkOGFlLi5mMmQyNDE1NjNlNGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19wY2lfbGVnYWN5LmMNCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3ku
Yw0KPiBAQCAtMTQsNiArMTQsNyBAQA0KPiAgICogIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJl
ZGhhdC5jb20+DQo+ICAgKi8NCj4gDQo+ICsjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCj4gICNp
bmNsdWRlICJsaW51eC92aXJ0aW9fcGNpX2xlZ2FjeS5oIg0KPiAgI2luY2x1ZGUgInZpcnRpb19w
Y2lfY29tbW9uLmgiDQo+IA0KPiBAQCAtOTcsNyArOTgsOCBAQCBzdGF0aWMgdm9pZCB2cF9yZXNl
dChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikNCj4gIAl2cF9sZWdhY3lfc2V0X3N0YXR1cygm
dnBfZGV2LT5sZGV2LCAwKTsNCj4gIAkvKiBGbHVzaCBvdXQgdGhlIHN0YXR1cyB3cml0ZSwgYW5k
IGZsdXNoIGluIGRldmljZSB3cml0ZXMsDQo+ICAJICogaW5jbHVkaW5nIE1TaS1YIGludGVycnVw
dHMsIGlmIGFueS4gKi8NCj4gLQl2cF9sZWdhY3lfZ2V0X3N0YXR1cygmdnBfZGV2LT5sZGV2KTsN
Cj4gKwl3aGlsZSAodnBfbGVnYWN5X2dldF9zdGF0dXMoJnZwX2Rldi0+bGRldikpDQo+ICsJCW1z
bGVlcCgxKTsNCj4gIAkvKiBGbHVzaCBwZW5kaW5nIFZRL2NvbmZpZ3VyYXRpb24gY2FsbGJhY2tz
LiAqLw0KPiAgCXZwX3N5bmNocm9uaXplX3ZlY3RvcnModmRldik7DQo+ICB9DQo+IC0tDQo+IDIu
MjUuMQ0KDQo=
