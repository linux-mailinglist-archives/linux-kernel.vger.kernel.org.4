Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3559E623A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiKJDbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiKJDbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:31:07 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2044.outbound.protection.outlook.com [40.107.215.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85661DA42
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 19:31:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKMwtFGZGRZWl/rJgm0Umo3M6oq97OeFbwtbuuTCx7FtOH7/CrtQnThCkOIU4LIgRHElzB3r7+inb2xNakrVsGK6bvMZqe6vuot6HCTxFk7wYurch+D/v8TMPGJxGAevLsHfghPX92EFP0Rnw+5jPc8xAUC0Q9OagPwwuzJJi83j7HZ335MTI577Qrxd8UC2N7BN6JruQmRz4iFO5JHLOd8zDFrzlqUeOZ2jNeqxLV1TzwKCYxfM1dlBmeDKAOOUrVSdfOHmtCBVbQQJw5WLbx8IgIMtjAdLpWCrbuFH/Xjnal0nHZBDma/IIulkBtWyGKSJoeRlV+WR2VVJaEBxkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXQJPuY6skHaqCkxzWZJChwB+OQ0d1QgrBGo23NRGhE=;
 b=WdagTw5K7NPCI1oJzDaZ9p1vFiBARJVZsRTalEoMCBdCWqaXgQgWq1YPgf7HW7jlxPD9U1WkTRIUIlEPj2nJr0Uq/aqa0DV7lf5yn3irKsf1XX1cbJWCyuP0/iEz5uqYwr/gZgOPQeE+8HxwzjYRNhCg8ffkVNE2u8yKy3Xtqp0hZWRWgGte2pWHTW3O5A07jVSuV0vVVXjdSrmLIlwD0nCS1GfaiSjgCWxgkLHJ7bS3P8Xk3yW111aXo7+q2XFrUIGaZl5cPfVf2ZP8AmB0F7xns7J5r7Pe41DQmrudjJZib/NPYAl6RthAez8S78b3bIxN+qBMi0b1bvFN+J3Ptw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXQJPuY6skHaqCkxzWZJChwB+OQ0d1QgrBGo23NRGhE=;
 b=hs/qJWzzRhSy8V8wbif5/YmIWqjsMjrlQmJ4cCGTltsNH2J5xrtk6I3bZQUmZSJGfWHKjUuShDgz1MJ9ig5lYLy8Z16fhk5dxBYoEgJMDpM7a21GOyBFTkqrZgHUmWMoWHro5ayel1CJgAp1r6yVEAwgkK4AS3z2Rojv+FGJmZHmyhXdwwwOpk1rTR0cqlb5NC9g+0rbsMp32nBez0KitmKZtYi+s9CdFnaPSI5GHYt2NJrkjjlBboGKDkchUQ1Mh7c3giXEsWx+aJI3swpPZu1GBgBUfF4W++QHxJJky73p2vbQuIkW8H3hMwy9iFAJ6Lg7s7+NS+9sWZFEQLHsTg==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by SG2PR06MB5429.apcprd06.prod.outlook.com (2603:1096:4:1b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 03:31:00 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::7285:f0e8:3a4a:f312]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::7285:f0e8:3a4a:f312%6]) with mapi id 15.20.5791.025; Thu, 10 Nov 2022
 03:30:59 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>
Subject: RE: [PATCH] virtio_pci: modify ENOENT to EINVAL
Thread-Topic: [PATCH] virtio_pci: modify ENOENT to EINVAL
Thread-Index: AQHY7eOBmMelMNnVVUexFvVKFGZ5764rHb+AgAxrT1A=
Date:   Thu, 10 Nov 2022 03:30:59 +0000
Message-ID: <TY2PR06MB342458CA2B7B5B8FDCD3366185019@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20221101111655.1947-1-angus.chen@jaguarmicro.com>
 <CACGkMEs6ZTrf0NMXGuM=VYZC+zAujigiTG2CgE8gAdvxHc2Q7A@mail.gmail.com>
In-Reply-To: <CACGkMEs6ZTrf0NMXGuM=VYZC+zAujigiTG2CgE8gAdvxHc2Q7A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|SG2PR06MB5429:EE_
x-ms-office365-filtering-correlation-id: 0ad94672-c055-422a-3d95-08dac2cbfc60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZqPeu2dsmMXyQm6spWiIVtG1H4ZNxwJFseWTy+7oOz4GNAOLznhowz0pzlXu/2D4BwfrYQ42RkotC/OBQ+nl4ht1S/H60laf9vpM6PpiKEC9pLFkslojGOKPtED1SG52A78RhmIcs/f/dNIg9TfaxhtcylY3qgvBZpCpp5pdyoiCAUgtplvFbBBfCGlOSqm1Yf800lNd/wkTbF7o3tWecfAo97d5tHBgtspWpj4kuTNswx8KO8mE0O7JDGBBLdzdhhW5w2rCgLzPtnlhM1LVXairI4+ijgTC43XEzmTPFQcSwQm2NEx8Vu8yxxs5bGFwuLnZD/xS037PBIo05X3RQkeNaBc95AF7GvW2CEKxuuyavEl8KWlaBb1by9ExQXJfqNL0x+EcEe429u7SSaPZ56dSw6jFoxVV2ruRQsMs1gjWbRVxd1tRjWQjvUdoDZzRkBLH2pDCmiCcj1jyxcswMX2X3kzz6i+Ppv9vJqlkyZ/Yh7HVEKhHekgn/PTZ8q+LsPQu4WYLKLr+AMgXf9Z9/5YH6hFGSGrJkleHzCyqVc4B3AVtKhJ298XZhBZhlxPzDE2ISc9iynYCwxQwkY+bEoxa5zom7FHNe4vESsSx74chz18ci5UnQ8NvQ4tVwt+poWfcQ8wWk0ni9LPSBiNvu4ecYGAyrajvRQpGr69mS2XYV5dMI0Ra2CHq28vDh6GoT11aSClO/c7C2OtN31b13owQ73yfm5ZdqdOhgNzVEIT/CNcoiu6+JvOqRQvud1B6jZjgEGhXoNwiXVCymnNIrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39840400004)(366004)(346002)(376002)(396003)(136003)(451199015)(5660300002)(26005)(33656002)(2906002)(9686003)(41300700001)(6506007)(7696005)(53546011)(44832011)(52536014)(478600001)(8936002)(4326008)(76116006)(66556008)(66946007)(66476007)(8676002)(64756008)(66446008)(38070700005)(38100700002)(122000001)(186003)(86362001)(55016003)(83380400001)(66899015)(54906003)(6916009)(71200400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUpnMWhncWxnN1hqZEp2bnB4VEgwdmg1U2oxR2NDWmQvUjlhNkc5THpxM041?=
 =?utf-8?B?cHdYK1VzVzhNUTJIVlVMd3pqenE4VVhheXhlYndPL0diN2dSQ1RETTA5MUIy?=
 =?utf-8?B?anNTYXVWaFV1Sm9QeW4yU0JHeCs4akVoRnZHRGY3YVY2UzZ2c3lIVDlZZSti?=
 =?utf-8?B?eStvL3ZudlF6RlVTa3IrcmZnWEhyNTlJMVZBRHZydzlkcDh3amxFTGdhdWdU?=
 =?utf-8?B?S0Z4M0wyakVremtxVWl3QU1PaE81ZzViY2hyRWNNcEZoS3RzSXF1cmxuTTEy?=
 =?utf-8?B?cGJaazdodGxXcG5yeGkzZnNkaEhpOUl5RHcrMkNRRGFsNytsb2tKdkpHWllk?=
 =?utf-8?B?MXRHWTR3d3RlaGlodW05ZjgwU0loNURPT0F2R252bGlZVXd4Zkl6OEYwYXZU?=
 =?utf-8?B?elVDMGF5b21LOHkySitReGZvQ3p0M0dOREdVVDE5eEU1WFRQRWhSRVZjUjh1?=
 =?utf-8?B?cGN5b0dmMDVxd1c1UE15R3lZcldyY0tncjNYMmo3MDk4UWwrZHQ3TlkxS3BO?=
 =?utf-8?B?cVBTSFd1OWQ3dzFmcENXRzlIbjNSSnh6Y25SZzdkS0Q5ZGpaWlFvWDBld09L?=
 =?utf-8?B?MHFSTldHL21yTXROaGlPL1NJOHBGVVZBMjlraXRzQVU1V0NuV1FWR3phcTRV?=
 =?utf-8?B?dkE4cm9kZnptNG5zSWRNdWdrZE1DR2g0ZUthNzVMQ1crdVY5YWJNTU41Sm1t?=
 =?utf-8?B?QzMyekdrQmNJU09tTW90RVRCYTFoNVhZR2ZNNHFaWXE5d2d6UExTbGF2YVlv?=
 =?utf-8?B?a29ZaDBPSVIvL0k1ODBWK1REc2tNN09JWjJ1NjllbGxyOER3L2tUMmVPNytF?=
 =?utf-8?B?czlDRmthYXpXWVJWRGJKa3BBWHBkZERRa0U5VWQ4VHR4YWZIRE9vUVdQOGxx?=
 =?utf-8?B?dE45Ykx3Wm9YcFFiWW9XaXJncVpIYXV1akV0Szh0eDJIRkticGVwSzdMbWlW?=
 =?utf-8?B?M2V1cXpVRHlQbHl4dWpUSCswZytvSXFQa3lTM091SXk5VDdKeWFHVndoSGow?=
 =?utf-8?B?b0xLLzBVSllVZ3c4MFNKZThrVFJndHVYcmVvbjdyakt2VjNwd3VzanYxSlR4?=
 =?utf-8?B?RGZ4aXZldURTRElNcm01TiszWThPaEdvaVpRemIzN0xDUW93eDA3eXNCcG9v?=
 =?utf-8?B?SlJ2NlRmQmViTUdZNW9XYjRIZTV5UldIY1B4RUxTNzNieW1mVjJtQVVka25p?=
 =?utf-8?B?Z2lDblB3eitSdlNqbjRxM2JwWVVGTXdybGc1ZGxLemJjZ3ZYNkpXS2dFcUZq?=
 =?utf-8?B?bnlXai9INzRuMTZBMktza0NWTHJ1RU9jUWw1T2ExWG1jZElQd2IrcnVwcGE3?=
 =?utf-8?B?R0hGSm5ENk9WQ2ZzOFd1a25RdHhUbjZxTFF0bExaelN0L2dSRytQZXdVZ1Jx?=
 =?utf-8?B?RUEyRVE1U3VpdTNlVlRoL1YyVkN6azZOWWYyY2hDZGV5Tm1CK2JBaEZSVHFa?=
 =?utf-8?B?aVdiS2pzUmlzRkFJam02K2NFZFk0UG9UTUJ0dlZjVzVUVngrSk9pM285dzd6?=
 =?utf-8?B?ZzlpbGFGZVMzUHJLdDZqOTdOM0x3djRydUJUeEt3UytDZkdZMi8vNDV3QVF4?=
 =?utf-8?B?RVB4cEVvSlJnci9ZR1Zkc0hLdCs5SEp6dDNaVHBFVmlNTkNGd1lxMEZRempX?=
 =?utf-8?B?cEhHbXBKMzBkenk2TWdJUlh1QTVUV0ZNUnl0aUZUTG9ZSFo2UnZYRzhTMFRL?=
 =?utf-8?B?YWltSG9rQzRSaC9OeFV0K2pwVExZYTdpeHk1V3JqbWM2N3Y2S1J2TmJXbk55?=
 =?utf-8?B?WWw3N0NjQWZUWHJQWFJ5Si9MeExoemcrK3BsZUZBRzhIY1NPNWg4dkl1VlIw?=
 =?utf-8?B?T2cxbXpXM25TMzFMa2RCMXBJVFUzVk0rRDNnUkFDQ0N4WTVtVHF4L3pxSExQ?=
 =?utf-8?B?QzkvRFRJNmk0M2VVRXN3bUJNcVNPS1ZsZHBka2NJVWNibit6OUdaVk1wMzZu?=
 =?utf-8?B?Yi84L2JlQ01tSW4yR3QwZXQxaGEvL3dZOGp2bTBLSnJhK2hwTVpLQzJVeTUw?=
 =?utf-8?B?RklLRWZQUklwaHgrci9PTzRkU2xHMUsrSHRIN1hoM01SbTErUFViM05HdG5T?=
 =?utf-8?B?NndOMHFvSUY2ZHhjOWI0NFRMY3A2S0pZTVdWdjBSRHF3TlFjOHRMMVFBa25i?=
 =?utf-8?Q?9lmlTShyBuTryaDvH+DXQE4Dz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad94672-c055-422a-3d95-08dac2cbfc60
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 03:30:59.4349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zXgbC+koQCEnC2Ds/iY+KMxWjUUB8vaLRtz92qGpRql1KFQtosSr+FUooaNA2RPPQhTF/hJAWOlIMZHuaiEbLWQ7PcqqRiLj5mh36ouDIwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzb24uDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAy
LCAyMDIyIDE6MzQgUE0NCj4gVG86IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8u
Y29tPg0KPiBDYzogbXN0QHJlZGhhdC5jb207IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW5nc2hhbi56
aHVAaW50ZWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHZpcnRpb19wY2k6IG1vZGlmeSBF
Tk9FTlQgdG8gRUlOVkFMDQo+IA0KPiBPbiBUdWUsIE5vdiAxLCAyMDIyIGF0IDc6MTcgUE0gQW5n
dXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4g
VmlydGlvX2NyeXB0byB1c2UgbWF4X2RhdGFfcXVldWVzKzEgdG8gc2V0dXAgdnFzLA0KPiA+IHdl
IHVzZSB2cF9tb2Rlcm5fZ2V0X251bV9xdWV1ZXMgdG8gcHJvdGVjdCB0aGUgdnEgcmFuZ2UgaW4g
c2V0dXBfdnEuDQo+ID4gV2UgY291bGQgZW50ZXIgaW5kZXggPj0gdnBfbW9kZXJuX2dldF9udW1f
cXVldWVzKG1kZXYpIGluIHNldHVwX3ZxDQo+ID4gaWYgY29tbW9uLT5udW1fcXVldWVzIGlzIG5v
dCBzZXQgd2VsbCxhbmQgaXQgcmV0dXJuIC1FTk9FTlQuDQo+ID4gSXQgaXMgYmV0dGVyIHRvIHVz
ZSAtRUlOVkFMIGluc3RlYWQuDQo+IA0KPiBJJ20gbm90IHN1cmUgSSBnZXQgdGhpcy4gSXQgd291
bGQgYmUgYmV0dGVyIHRvIGRlc2NyaWJlOg0KPiANCj4gMSkgd2hhdCBraW5kIG9mIGlzc3VlcyBj
YW4gd2Ugc2VlIGlmIHdlIHJldHVybiAtRU5PRU5UDQo+IDIpIHdoeSAtRUlOVkFMIGNhbiBoZWxw
IGluIHRoaXMgY2FzZQ0KPiANCj4gVGhhbmtzDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQpX
ZSB1c2UgYSByb2JvdCB0byB0ZXN0IG91ciBkcHUgdG8gZ2V0IHRoZSByZXR1cm4gdmFsdWUgb2Yg
cHJvYmUuDQogV2Ugb2Z0ZW4gZ2V0IEVOT0VOVCBmb3JtICcgc2V0dXBfdnEgJyBmdW5jdGlvbiBi
ZWNhdXNlIG9mIGRldmljZSBlcnJvci4NCk1vc3Qgb2YgdGltZSwgbXkgZGV2aWNlIGNhbid0IGhh
bmRsZSBxdWV1ZV9lbmFibGUgd2VsbC4NClRoaXMgdGltZSx3ZSBnZXQgJ0VOT0VOVCcgYmVjYXVz
ZSB0aGUgZGV2aWNlIHNldCBtYXhfZGF0YV9xdWV1ZXMgYmlnZ2VyIHRoYW4gbnVtX3F1ZXVlcy4N
Cg0KSSB0aGluayBFSU5WQUwgaXMgdXNlZCB3aGVuIHRoZSB2YWx1ZSBvZiBzb21lIHBhcmFtZXRl
ciBpcyB3cm9uZy4NCkJ0dyxpdCBub3QgYSBiaWcgZGVhbCxJIGNhbiBtb2RpZnkgdGhlIHJvYm90
IHRvIHdvcmthcm91bmQuDQoNCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmd1cyBDaGVu
IDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy92aXJ0
aW8vdmlydGlvX3BjaV9tb2Rlcm4uYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYw0KPiBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lf
bW9kZXJuLmMNCj4gPiBpbmRleCBjM2I5ZjI3NjE4NDkuLmVkZjJlMTgwMTRjZCAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jDQo+ID4gKysrIGIvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYw0KPiA+IEBAIC0zMDMsNyArMzAzLDcgQEAg
c3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnNldHVwX3ZxKHN0cnVjdA0KPiB2aXJ0aW9fcGNpX2Rl
dmljZSAqdnBfZGV2LA0KPiA+ICAgICAgICAgaW50IGVycjsNCj4gPg0KPiA+ICAgICAgICAgaWYg
KGluZGV4ID49IHZwX21vZGVybl9nZXRfbnVtX3F1ZXVlcyhtZGV2KSkNCj4gPiAtICAgICAgICAg
ICAgICAgcmV0dXJuIEVSUl9QVFIoLUVOT0VOVCk7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVy
biBFUlJfUFRSKC1FSU5WQUwpOw0KPiA+DQo+ID4gICAgICAgICAvKiBDaGVjayBpZiBxdWV1ZSBp
cyBlaXRoZXIgbm90IGF2YWlsYWJsZSBvciBhbHJlYWR5IGFjdGl2ZS4gKi8NCj4gPiAgICAgICAg
IG51bSA9IHZwX21vZGVybl9nZXRfcXVldWVfc2l6ZShtZGV2LCBpbmRleCk7DQo+ID4gLS0NCj4g
PiAyLjI1LjENCj4gPg0KDQo=
