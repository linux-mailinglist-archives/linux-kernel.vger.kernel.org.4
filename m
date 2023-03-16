Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB31E6BC574
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 06:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCPFGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 01:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCPFGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 01:06:01 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2085.outbound.protection.outlook.com [40.107.8.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A047A90BE;
        Wed, 15 Mar 2023 22:05:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5G4W//S/NarhmQO3ZDaJ87Y5l8Ri9itf91WvB1AonweTyTx+9Na3isDV+BX/x4zNu4hLspOIcJ1UWEo/FXoreZNU5fX5LMP3DZ5Rfll1lspHnegmGQMXSu8DDDNGfxIVDceR6c6cGfHbWZ+dVsw1E9j7wYr3GNP1j5Sx1vKOlt7M092wSia/FSxGhy0+nByfM4Z/DBb2B40PQQ10W87kwzsaBlhwkw9pXGx7H0PGlIo/jernCzhprO0kbXMHnlyUqkJrRqdbf/VXttm3x26rVswoxNzXXsx9K433WHVWmDCqBt9pej3mc9kgxi+biBm6te7MSbwgVH0yu3Q2PdKng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X15tLujJF42xcfdtcwCtCxyGxhxqzzNtmfiPLW2eumk=;
 b=L2ESs/VCFIX9TzTyEtNvVwcbck6RyuJQXkXtzoICVEv75R1Tnm1OvBzzkgVnFDVnajbBxeGrWip4i6wU3nv2bCs+BHGoFavjw3WjcTHMPojVc7P2orSaCsxxEIw6wJqveofGGht+IuwgIBRTITB+BwLCnFP2kuW4YT5ClKZPPfW8HxlQM01QljO9+unNU/kAWxvbvjjW17R+STblwW+6BeMcSn9IEetA+xgQbgB6IUyubaEcHcK3BMKDMgTFRIgR1RELWRkgNSMTINHEaBU+dRylZX6eHCPOxawmfH9jl/UfV/Sg9SVhTQ+LcvX+NCtK/2lz5GvLw94NyT6a/sWv0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X15tLujJF42xcfdtcwCtCxyGxhxqzzNtmfiPLW2eumk=;
 b=HhrF1VbqXVh6KMXRl2IG30jkydKPZ+LaohMqyDIsiX4ZuGiaLgx2iGsq5oA/yctATL5hOHcLa40UtZEHd8ttPF28qNo17i6e5hgBAMSvNpANsSho4OerM5f1WR5SZrOIWJqydODf1kwiU0fef8A6+gKXW4Y5eEzJPIKSrbmVrAA=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB9PR04MB8219.eurprd04.prod.outlook.com (2603:10a6:10:24d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 05:05:55 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3079:f55a:740e:c103]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3079:f55a:740e:c103%9]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 05:05:54 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serdev: serdev-ttyport: set correct tty->dev for
 serdev framework
Thread-Topic: [PATCH] tty: serdev: serdev-ttyport: set correct tty->dev for
 serdev framework
Thread-Index: AQHZVw9OUac0kayKm0KF91nNt7mFIq77dH6AgAAIVPCAADjvAIABHqmA
Date:   Thu, 16 Mar 2023 05:05:54 +0000
Message-ID: <AS8PR04MB840403BB4EA577870C2F4F7D92BC9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20230315072143.7815-1-sherry.sun@nxp.com>
 <ZBF2Pyd4VSZq3HoA@kroah.com>
 <AS8PR04MB840408DC92F4001AB440353292BF9@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <ZBGs/sWZGnIbqHbd@kroah.com>
In-Reply-To: <ZBGs/sWZGnIbqHbd@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|DB9PR04MB8219:EE_
x-ms-office365-filtering-correlation-id: 1abb5c58-04ad-4dcd-bb5f-08db25dc1f05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3KR/fAgkEzzDJTDVhkg1KRO1V9tAPNqdrpsWGXj0TmlCCUoL9oODZEOKt+nfpH8tOZAS5TPTjmv6tU4QZpqD/OscL/LK538pqfy/93syJmp3ig0MPBFLe57RuyniY7FHZ84XO9bbze4kCx526x/4TFjqXcLxXmRWGgZPdd0TSJAIX8ekTlL54eBNUqAaQ+FG9zgMJBXyOWJAlRLkBH8DPiXq27WjG0wDvR5OqaFPEICCSOhQVVvSJMh3DDWdqH1Rh4AAY3GOZj13OkJNN9ApZlbgSBQripW6EKcTiGXAdD07Uaw2XEgyx/tXtVeHHzpVvDLBf5vdzbtBNg4UC/n7Ki4bTsZg31KlGbnuXyQQhsOEPaDeKf4Ut+RcLTIqJEAuyOCHWNFnG7nZjLfypF7dpUqcbiqRKUSwbZbRVa/UclBBkVQScGcnTUI4KXOpbefuN4TeNDOrG1lmOUoZG4yIobhD1rZdzVNMCIE20rw/G/YSA6IBiMmP2trz0kd9TEP16SaExtH3lLTbTXyQPslPZEEfjp+B2V38QFl6sNK+rcrGSLHHGIW3vWvKtkutctew47jy414RLl4eS5fseggEvu14qgdaKDGGAnrumf5OgbnMd9YjIEvhwL3T+UPtfe/FsSHYDymcznsYoV+JljcC2Bns9vmiTRBEkzroR7+IS5uUiNOdpG1jtAmlGE6c8ofMmo4kEiob+ZZNYjh6NwLOYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199018)(38100700002)(122000001)(2906002)(478600001)(6506007)(7696005)(33656002)(316002)(55016003)(38070700005)(54906003)(86362001)(71200400001)(66556008)(66446008)(6916009)(8676002)(5660300002)(26005)(66476007)(4326008)(66946007)(64756008)(9686003)(41300700001)(76116006)(8936002)(186003)(52536014)(53546011)(83380400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEljY0pjUjNkK3QrNEFjVEZiOFFDYXFJemFOK1VMM0EwNGdGVDZsMmVvZVVp?=
 =?utf-8?B?YndCcWU3VHRvbWhZRmMydVhLZkJRMU9EdXRVZ1lST09IWnlPMDAxRmQ0T1Jm?=
 =?utf-8?B?Y2oxVHg1eDhpQ2tqcmo1Q0tKSktDdUVma1Vkc0gxK3VwZzBHN2E2KytaYjNm?=
 =?utf-8?B?cnVBcC9aaFU4UWtkcVRqTjJlZG1aREwySTBlSjRNQWJMeEJ6djg5S09xc1ZI?=
 =?utf-8?B?VExrMU1LZktJL2FIN2NMRXkvdWZRV0F3dm1vMHZkTGxoQmF0WDFjL00zTTM0?=
 =?utf-8?B?ZFJ5Y2RjL3VBaU9pd1Y0Z29WRkhJMlpTaVl0akt3UzJhbWpQSXcreVNKZlpI?=
 =?utf-8?B?WHc0S3NoVVd1VnBrYkQ2eGcwUWJxajA1Q0t5UERCenZaU043eExhYko0c1Vs?=
 =?utf-8?B?ejh1NGZYeDNMdFFBMW1NRFN3NHRIeDRlRDJwMW5jNzUzSUs0K3o0eDNKc3dx?=
 =?utf-8?B?TENoNG5TV0V5d0EvaElTSjhoRXkySFNTcm9PSFRVVWtJYU9wM0w4WFBlczRl?=
 =?utf-8?B?N1Y1RDVjQ2w3QzZtakxqMTN2czczZFBoQU5rblNIZzJ0aTM0NFpheDFHd2Rr?=
 =?utf-8?B?V1V0MVJuMEppY0ZQbDdUa25xRHNSaU1zZXFUa3o1ZHhHWmFtR2lxZjR5WU8v?=
 =?utf-8?B?NVFqVGhJN0NDZ3MvbERhTkRkRnRXQjZNazZESzlISDJocWVJRXEzclE1YnFv?=
 =?utf-8?B?amJNNzBDZHVRMHRDVVZ1bUFuS3hUcXFlSHpKdjUvcmJzbFlzNlBNZ3hNWnF0?=
 =?utf-8?B?RGMya05ZQmpNcnNkUUdiRjBvYnlvbUE3L20wTUpOVDRpZVRiUnRkUmpWWWZj?=
 =?utf-8?B?VnUzQStXUlpTV1pYWXNZOWVHR2JRbGNZUHFsMng1bnhwRWpHZ1ovUmRmemFo?=
 =?utf-8?B?TjZFb1pVWnA5RHZLM0wzaEhMUWhBNy9kcVh0Q2tYcHp3SG81eWJNM25hTjhZ?=
 =?utf-8?B?cEovK3ZDVzJub2pwdlJtdjlvbzZ6dXJObktuM2x1MC9zZ2d6WVJuUDFuZUE0?=
 =?utf-8?B?TUxyblBlNExvZ3U0MkFFWnpJS3BWTUw3MWFscE5FNTF5LzdCc0RWdStodU9G?=
 =?utf-8?B?TzdKR2dPYThCY0RiaVQ5WlRiVi9lNDE0UE1PL0dHbzNTL25Yb0ZxOXcyS3FU?=
 =?utf-8?B?WmUxUmRyTWVFQUh3U3FzM3gzWWdaendNaExTT0ZiU3cvU3B2Zk1lczFRTnFr?=
 =?utf-8?B?Y1BVbWpZTXlpaFMwNUxOYldaeUZscFZ2NGx0Z2tUTko5S1B3elN5YlNsTk04?=
 =?utf-8?B?N3IvQ0xqSG4wSlkrSllOSnNYb1l6cXQyb3BIajBJZVV4bzIyTWlmZVNIV25i?=
 =?utf-8?B?K2dqWWtIUTJMY0VHMlZlL2dRTmtTZnMwRTZCeWw5bHpiY1NEeDJ5aVArdGFR?=
 =?utf-8?B?Qzd0ZGxkdFdianFoc1hkOE9HS2RGYkI1WVQ3S0QxNGV6RTQ0cE9kUEVnQk5s?=
 =?utf-8?B?anFpUGtlcWZHcFFFblozQVhOaEFHekxFcjBiQm1MQmZ0cHZBQUE4YU5KY0Vp?=
 =?utf-8?B?QzM1M01nNmhqRlJvOUVWTm5tNXFWSFNUNFJjY0hnMHFwekMxc3kydUpyY1Ux?=
 =?utf-8?B?cHUrbGtyYytHVG1xMFFsbWlQZitKeFltbldnQit4d296U2xUZ0FqNUR3anpl?=
 =?utf-8?B?eVdnWElZQkM5Zk5pbHJSMmV0dFdsNXdOdldLZW0wWnk5YWRGOTdFaGJpYTBW?=
 =?utf-8?B?UXBqR1dNRVhsZG9DTFdBc3dlbnprQzBvTzV4TjJaTFMyWWlDbzlGcEw1SFdk?=
 =?utf-8?B?N280TjdaK01DeFQ0c2xpdWo1aCtmRjNqUGxnR1NwWS9xR2V2VlZBUlZGOEdt?=
 =?utf-8?B?cnA4MmVIMHdVMXhPVkgrdWw0UjVNay9QN2RsWVhYVzg1NDFEVWd2OXVDWTVR?=
 =?utf-8?B?Z1VBZy9rcDdab0Y5YTZIVkNuNFgzVThBTXh5a0lXL1gyMDJRczduUjNHK2VV?=
 =?utf-8?B?cE9lTG5VUXBoWGx6YzdBNVpRSGpndk5abW52Y3IzYzFRZVVJcEF6QklENVhF?=
 =?utf-8?B?Zk1ESllSTnU0cyt4S05vakd6cm4vdGp6SFFSZE1XZ0RzQm1vVVJNUzUyMksz?=
 =?utf-8?B?VG12VTlIRWljNVVZYTRvaUk5c3Z2UFBCdlozeGtPRWh6cW9pRDNxWW44VXBw?=
 =?utf-8?Q?qfR0ZCEmD2HjdAZQyIHZM0lqM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abb5c58-04ad-4dcd-bb5f-08db25dc1f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 05:05:54.6403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8nXR5k2l/hZ9MLkB07OiunLb/gzF5XotX+PiYipX4kyHRVnvNEcq4vhPaVWWkzHj8GS0sjcVyCinhm4vPJACqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8219
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3JlZyBLSCA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFNlbnQ6IDIwMjPlubQz5pyIMTXml6UgMTk6MzMNCj4g
VG86IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gQ2M6IGppcmlzbGFieUBrZXJu
ZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7IGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54
cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHR0eTogc2VyZGV2OiBzZXJkZXYtdHR5cG9y
dDogc2V0IGNvcnJlY3QgdHR5LT5kZXYgZm9yDQo+IHNlcmRldiBmcmFtZXdvcmsNCj4gDQo+IE9u
IFdlZCwgTWFyIDE1LCAyMDIzIGF0IDA5OjQ5OjUzQU0gKzAwMDAsIFNoZXJyeSBTdW4gd3JvdGU6
DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206
IEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiA+ID4gU2VudDogMjAyM+W5
tDPmnIgxNeaXpSAxNTo0MA0KPiA+ID4gVG86IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNv
bT4NCj4gPiA+IENjOiBqaXJpc2xhYnlAa2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3JnOw0KPiA+
ID4gbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsNCj4gPiA+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+ID4gPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSB0dHk6IHNlcmRldjogc2VyZGV2LXR0eXBvcnQ6IHNldCBjb3JyZWN0
DQo+ID4gPiB0dHktPmRldiBmb3Igc2VyZGV2IGZyYW1ld29yaw0KPiA+ID4NCj4gPiA+IE9uIFdl
ZCwgTWFyIDE1LCAyMDIzIGF0IDAzOjIxOjQzUE0gKzA4MDAsIFNoZXJyeSBTdW4gd3JvdGU6DQo+
ID4gPiA+IHR0eXBvcnRfb3BlbigpIGNhbGxzIHR0eV9pbml0X2RldigpIHRvIGluaXRpYWxpemUg
YSB0dHkgZGV2aWNlLA0KPiA+ID4gPiBidXQNCj4gPiA+ID4gdHR5X2dldF9kZXZpY2UoKSBjYW5u
b3QgZ2V0IHRoZSBjb3JyZWN0IHR0eS0+ZGV2IGZvciBzZXJkZXYgdHR5IGluDQo+ID4gPiA+IGFs
bG9jX3R0eV9zdHJ1Y3QoKSwgYmVjYXVzZSBzZXJkZXYgZnJhbWV3b3JrIGRvZXMgbm90IHNldA0K
PiA+ID4gPiB0dHlfY2xhc3MsIHNvIGNsYXNzX2ZpbmRfZGV2aWNlX2J5X2RldnQodHR5X2NsYXNz
LCBkZXZ0KSBtYXkgYWx3YXlzDQo+IHJldHVybiBOVUxMLg0KPiA+ID4gPg0KPiA+ID4gPiBGb3Ig
c2VyZGV2IGZyYW1ld29yaywgd2UgbmVlZCB0byBhc3NpZ24gdGhlIGNvcnJlY3QgY3RybC0+ZGV2
IHRvDQo+ID4gPiA+IHR0eS0+ZGV2Lg0KPiA+ID4gPg0KPiA+ID4gPiBGaXhlczogYmVkMzVjNmRm
YTZhICgic2VyZGV2OiBhZGQgYSB0dHkgcG9ydCBjb250cm9sbGVyIGRyaXZlciIpDQo+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gPiA+ID4g
LS0tDQo+ID4gPiA+ICBkcml2ZXJzL3R0eS9zZXJkZXYvc2VyZGV2LXR0eXBvcnQuYyB8IDEgKw0K
PiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gPiA+DQo+ID4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJkZXYvc2VyZGV2LXR0eXBvcnQuYw0KPiA+ID4g
PiBiL2RyaXZlcnMvdHR5L3NlcmRldi9zZXJkZXYtdHR5cG9ydC5jDQo+ID4gPiA+IGluZGV4IGQz
Njc4MDNlMjA0NC4uYmJhMzdhYjkwMjE1IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3R0
eS9zZXJkZXYvc2VyZGV2LXR0eXBvcnQuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3R0eS9zZXJk
ZXYvc2VyZGV2LXR0eXBvcnQuYw0KPiA+ID4gPiBAQCAtMTEyLDYgKzExMiw3IEBAIHN0YXRpYyBp
bnQgdHR5cG9ydF9vcGVuKHN0cnVjdA0KPiA+ID4gPiBzZXJkZXZfY29udHJvbGxlcg0KPiA+ID4g
KmN0cmwpDQo+ID4gPiA+ICAJdHR5ID0gdHR5X2luaXRfZGV2KHNlcnBvcnQtPnR0eV9kcnYsIHNl
cnBvcnQtPnR0eV9pZHgpOw0KPiA+ID4gPiAgCWlmIChJU19FUlIodHR5KSkNCj4gPiA+ID4gIAkJ
cmV0dXJuIFBUUl9FUlIodHR5KTsNCj4gPiA+ID4gKwl0dHktPmRldiA9ICZjdHJsLT5kZXY7DQo+
ID4gPg0KPiA+ID4gV2hhdCBpbi1rZXJuZWwgZHJpdmVyIG5lZWRzIHRoaXMgY2hhbmdlPyAgSG93
IGhhcyBpdCBub3QgYmVlbiBhDQo+ID4gPiBwcm9ibGVtIHNvIGZhcj8NCj4gPiA+DQo+ID4NCj4g
PiBIaSBHcmVnLCBJIHNlYXJjaGVkIHRoZSB1c2VycyBvZiB0dHktPmRldiB1bmRlciBzZXJpYWwg
ZmxvZGVyLCBmb3VuZCB0aGUNCj4gZm9sbG93aW5nIGRyaXZlcnMgbmVlZCBpdC4NCj4gPiBkcml2
ZXJzL3R0eS9zZXJpYWwvc3RtMzItdXNhcnQuYzo3ODA6ICAgICAgICAgICAgICAgICAgIHBtX3dh
a2V1cF9ldmVudCh0cG9ydC0NCj4gPnR0eS0+ZGV2LCAwKTsNCj4gPiBkcml2ZXJzL3R0eS9zZXJp
YWwvZnNsX2xwdWFydC5jOjMwMTg6ICAgICAgICAgICB0dHlfZGV2ID0gdHR5LT5kZXY7DQo+ID4g
ZHJpdmVycy90dHkvc2VyaWFsL3N0LWFzYy5jOjI2NjogICAgICAgICAgICAgICAgcG1fd2FrZXVw
X2V2ZW50KHRwb3J0LT50dHktPmRldiwNCj4gMCk7DQo+ID4NCj4gPiBBY3R1YWxseSB0aGlzIGlz
c3VlIHdhcyBmb3VuZCB3aGVuIEkgdGVzdGVkIHRoZSBueHAgQmx1ZXRvb3RoIGRyaXZlciB3aGlj
aA0KPiB1c2Ugc2VyZGV2IGZyYW1ld29yayBhbG9uZyB3aXRoIGZzbF9scHVhcnQuYyBkcml2ZXIs
IHdoZW4gc3lzdGVtIGlzDQo+IHN1c3BlbmRpbmcsIHRoZSBmb2xsb3dpbmcgTlVMTCBwb2ludGVy
IGtlcm5lbCBwYW5pYyBpcyBvYnNlcnZlZC4NCj4gPiBUaGlzIGlzIGJlY2F1c2UgbHB1YXJ0IGRy
aXZlciB3aWxsIGNoZWNrIHRoZSBkZXZpY2VfbWF5X3dha2V1cCh0dHktPmRldikNCj4gdG8gZGV0
ZXJtaW5lIGlmIHdha2V1cCByZWdpc3RlciBiaXRzIG5lZWQgdG8gYmUgZW5hYmxlZCBvciBub3Qg
YmVmb3JlDQo+IHN1c3BlbmQsIGl0IHdvcmtzIHdlbGwgdGhlIHRoZSBsZGlzYyB0dHksIGJ1dCBz
aW5jZSBzZXJkZXYgdHR5IGRvZXNuJ3Qgc2V0DQo+IGNvcnJlY3QgdHR5LT5kZXYsIHNvIGhlcmUg
Y2F1c2UgdGhlIE5VTEwgcG9pbnRlciBwYW5pYy4NCj4gPg0KPiA+IHJvb3RAaW14OHVscGV2azp+
IyBlY2hvIG1lbSA+IC9zeXMvcG93ZXIvc3RhdGUNCj4gPiBbICAgNDIuNjU3Nzc5XSBQTTogc3Vz
cGVuZCBlbnRyeSAoZGVlcCkNCj4gPiBbICAgNDIuNjY0MzMzXSBGaWxlc3lzdGVtcyBzeW5jOiAw
LjAwMiBzZWNvbmRzDQo+ID4gWyAgIDQyLjcxNzYyNF0gRnJlZXppbmcgdXNlciBzcGFjZSBwcm9j
ZXNzZXMgLi4uIChlbGFwc2VkIDAuMDAxIHNlY29uZHMpDQo+IGRvbmUuDQo+ID4gWyAgIDQyLjcy
NzA2M10gT09NIGtpbGxlciBkaXNhYmxlZC4NCj4gPiBbICAgNDIuNzMwMzgzXSBGcmVlemluZyBy
ZW1haW5pbmcgZnJlZXphYmxlIHRhc2tzIC4uLiAoZWxhcHNlZCAwLjAwMSBzZWNvbmRzKQ0KPiBk
b25lLg0KPiA+IFsgICA0Mi43NTM2NTJdIGZlYyAyOTk1MDAwMC5ldGhlcm5ldCBldGgwOiBMaW5r
IGlzIERvd24NCj4gPiBbICAgNDIuNzgwNjgxXSBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxM
IHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVhbA0KPiBhZGRyZXNzIDAwMDAwMDAwMDAwMDAw
ZGMNCj4gPiBbICAgNDIuNzg5NjAzXSBNZW0gYWJvcnQgaW5mbzoNCj4gPiBbICAgNDIuNzkyNDMw
XSAgIEVTUiA9IDB4MDAwMDAwMDA5NjAwMDAwNA0KPiA+IFsgICA0Mi43OTYyNDJdICAgRUMgPSAw
eDI1OiBEQUJUIChjdXJyZW50IEVMKSwgSUwgPSAzMiBiaXRzDQo+ID4gWyAgIDQyLjgwMTY2MV0g
ICBTRVQgPSAwLCBGblYgPSAwDQo+ID4gLi4uLi4uDQo+ID4NCj4gPiA+IEFuZCB3aHkgYXJlIHlv
dSBzYXZpbmcgb2ZmIGEgcmVmZXJlbmNlIGNvdW50ZWQgcG9pbnRlciB3aXRob3V0DQo+ID4gPiBp
bmNyZW1lbnRpbmcgdGhlIHJlZmVyZW5jZSB0byB0aGUgcG9pbnRlcj8NCj4gPg0KPiA+IFNvcnJ5
LCBmb3JnaXZlIG1lIEkgYW0gbm90IGNsZWFybHkgdW5kZXJzdGFuZCB0aGUgcmVxdWlyZW1lbnQg
aGVyZSwgZG8geW91DQo+IG1lYW4gd2UgbmVlZCB0byBhZGQgdGhlIGZvbGxvd2luZyBjaGFuZ2Vz
Pw0KPiA+ICAgICBnZXRfZGV2aWNlKCZjdHJsLT5kZXYpOw0KPiA+ICAgICB0dHktPmRldiA9ICZj
dHJsLT5kZXY7DQo+ID4gICAgIHB1dF9kZXZpY2UoKCZjdHJsLT5kZXYpOw0KPiANCj4gSWNrLCBu
bywgb25seSBkbyBwdXRfZGV2aWNlKCkgd2hlbiB5b3UgYXJlIGZpbmlzaGVkIHdpdGggdGhlIHBv
aW50ZXIgYW5kIGFyZQ0KPiBub3QgZ29pbmcgdG8gYWNjZXNzIGl0IGFueW1vcmUuDQo+IA0KPiA+
IEFuZCBwZXIgbXkgdW5kZXJzdGFuZGluZywgdGhlIHJlZmVyZW5jZSBjb3VudCBuZWVkcyB0byBi
ZSBpbmNyZWFzZWQgYW5kDQo+IGRlY3JlYXNlZCBmcm9tIHRoZSB1c2VyIHNpZGUsIGhlcmUgd2Ug
b25seSBkbyBhIGluaXRpYWxpemF0aW9uIGZvciB0aGUgdHR5LT5kZXYuDQo+IA0KPiBUaGVuIHNv
bWV0aGluZyBpcyBub3Qgc2V0IHVwIHByb3Blcmx5IGhlcmUsIHNvcnJ5Lg0KDQpIaSBHcmVnLA0K
DQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMsIGJ1dCB3aGF0IEkgd2FudCB0byBzYXkgaGVyZSBp
cyB0aGF0IHRoZSBjYWxsZXIgb2YgdHR5LT5kZXYgd2lsbCBjYXJlIGFib3V0IHRoZSByZWZlcmVu
Y2UgY291bnQsIGhlcmUgd2Ugb25seSBpbml0aWFsaXplIHRoZSB0dHktPmRldiBwb2ludGVyLCBs
aWtlIHdoYXQgd2UgZG8gaW4gIGFsbG9jX3R0eV9zdHJ1Y3QoKSwgc2VlbXMgbm8gbmVlZCB0aGUg
cmVmZXJlbmNlIGNvdW50Lg0Kc3RydWN0IHR0eV9zdHJ1Y3QgKmFsbG9jX3R0eV9zdHJ1Y3Qoc3Ry
dWN0IHR0eV9kcml2ZXIgKmRyaXZlciwgaW50IGlkeCkNCnsNCi4uLg0KdHR5LT5kZXYgPSB0dHlf
Z2V0X2RldmljZSh0dHkpOw0KcmV0dXJuIHR0eTsNCn0NCg0KRm9yIHRoZSBjYWxsZXIgb2YgdHR5
LT5kZXYsIHN1Y2ggYXMgdWFydF9zdXNwZW5kX3BvcnQoKSwgaXQgd2lsbCBjYWxsIGdldF9kZXZp
Y2UoKSBpbiBkZXZpY2VfZmluZF9jaGlsZCgpIGJlZm9yZSBnZXQgdGhlIHR0eS0+ZGV2LCBhbmQg
d2lsbCBjYWxsIHB1dF9kZXZpY2UoKSB3aGVuIHdoZW4gaXQgaXMgbm8gbG9uZ2VyIGFjY2Vzc2Vk
LiBUaGUgY2FsbGVyIHdpbGwgaGFuZGxlIHRoaXMgbGlrZSB3aGF0IHdlIGRvIGZvciB0aGUgb3Jp
Z2luYWwgdHR5IGZyYW1ld29yay4gV2hhdCBkbyB5b3UgdGhpbms/DQoyMzE0IGludCB1YXJ0X3N1
c3BlbmRfcG9ydChzdHJ1Y3QgdWFydF9kcml2ZXIgKmRydiwgc3RydWN0IHVhcnRfcG9ydCAqdXBv
cnQpDQoyMzE1IHsNCi4uLg0KMjMyMyAgICAgdHR5X2RldiA9IGRldmljZV9maW5kX2NoaWxkKHVw
b3J0LT5kZXYsICZtYXRjaCwgc2VyaWFsX21hdGNoX3BvcnQpOw0KMjMyNCAgICAgaWYgKHR0eV9k
ZXYgJiYgZGV2aWNlX21heV93YWtldXAodHR5X2RldikpIHsNCjIzMjUgICAgICAgICBlbmFibGVf
aXJxX3dha2UodXBvcnQtPmlycSk7DQoyMzI2ICAgICAgICAgcHV0X2RldmljZSh0dHlfZGV2KTsN
CjIzMjcgICAgICAgICBtdXRleF91bmxvY2soJnBvcnQtPm11dGV4KTsNCjIzMjggICAgICAgICBy
ZXR1cm4gMDsNCjIzMjkgICAgIH0NCjIzMzAgICAgIHB1dF9kZXZpY2UodHR5X2Rldik7DQoNCkJl
c3QgUmVnYXJkcw0KU2hlcnJ5DQo=
