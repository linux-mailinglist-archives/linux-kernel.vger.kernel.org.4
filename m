Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E946760393F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJSFby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJSFbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:31:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5547332B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8nCnRmW685DUE3vwJVXdLh6oqKKkJPRxMbbbLFPNt56I7MMW2FrAf2ofGepawcDjJJcOU3JMRrpfM3eSAS2n9VdBTSVzQhadlvyjdWxN5YBIp4N9DrbtUZKlpebnNueEz/wAbYnIhjaosctQrflu3TSFn2uZJXd7c467UOh4sijEWbtnUJ9etD6Vlu5Sqm/MPHA+F0BV8mg/XJNobdKbMoJ/Uaxf/ctYc0xllODjOhnNkcESBBZeBVWS/clixHS6XA9/uWOEq4AgIbZe/UF7oT9kYKIPnoI2oPE1XUVxqx0sETbdLGhNBUbBJbPpGQ3SigWIAdBJ9tUDJmAMrFSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGYV4RSY/mqfsx4mPiacSZYiBNZHDs2AkYUMDRm+S9o=;
 b=KgKAMH6P6IDgt/+AFgsDjZvllEHqE68NC61aYoaJu9Zx1+7XT71SRP0Rg7AuUSWyl6MooESZ2aBDVhzTdhz2TuT3nMPX4nC9SW3Xr5wveQFFWUdLAOfnDw/kaVNyCV3BVtcETUvDzb75Gk0ODlkm0LH7nXY9EZB/8b6wecMzOUHuzRDvbm8CPmMK9WmIbBh320XCTrJEbgGfgFyy3zT7esdRSbjvVqGt6SZJaS0L4hxemERBFyhW29WsiX6wJ30gKBXga80wFnCigfcJ4RpinYaoRiMARy8Ly+R7JML6aYXu//6x8JJRv3JzVk9SK3prvdRtvpwHqWXasA2+pjVckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGYV4RSY/mqfsx4mPiacSZYiBNZHDs2AkYUMDRm+S9o=;
 b=eMFUsZ7aA9AsyX9v1cOcfJ5OiVlD3XWmtYT3eanMWOB55CwrrXRUu6mw0u70UrJJ/9FZIY/Uzi2wzaqljbcySjisdxgJdfHPjwMICcTyfs8EFvqrQae3nnc/cUq8To1+BMe/OzbawQEpNO6tKUU9r+qeZ8WYknBAIixThxOaoEghrKhILWc/BoLCpk2XG+tK5WOJU6kKG6UduRF6JRhzIYuzmgGvNIuBEbrVWzIAiJdApIsCTQuTRQIxl2qzZcEgve34cJa6vUPZxuOwaQbmTr6CNtekD/4eJ1FtU64Wi1xvCo3E7sXaOHbBeyBv2oKWLsmGw+Qf+FbWMEsNQGBgCw==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.34; Wed, 19 Oct 2022 05:31:48 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357%5]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 05:31:48 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
CC:     "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>
Subject: RE: [PATCH 1/4] vdpa/mlx5: Fix rule forwarding VLAN to TIR
Thread-Topic: [PATCH 1/4] vdpa/mlx5: Fix rule forwarding VLAN to TIR
Thread-Index: AQHY4uKSTm3vnq7kQEqG6a62xIRmzK4Uh6MAgACpquA=
Date:   Wed, 19 Oct 2022 05:31:48 +0000
Message-ID: <DM8PR12MB540062ECEFFA463C69FD08C9AB2B9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20221018111232.4021-1-elic@nvidia.com>
 <20221018111232.4021-2-elic@nvidia.com>
 <7eceaaf2-753a-8ff8-4014-39314b31d47a@oracle.com>
In-Reply-To: <7eceaaf2-753a-8ff8-4014-39314b31d47a@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|BL3PR12MB6546:EE_
x-ms-office365-filtering-correlation-id: cd22257a-eefd-48f7-8ec4-08dab193381a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5iTB8TzuBdACdpdMPU48wCb4tzUycNpyna4sFRgVkcA3TyjsH5mYe8eg+/E29yrpc2smlulqJ1c8bXxcl416ZUO6FwvAqBZ/cZLmpE+z2FRcld3wujDrp6RVBBWuLxANP8pBhiCVh0JydADE6e1HPS0BtUP21kf0cSkcQAmgG8WJqH9pX8TIDdrcPcd85JOL5Ygcmg/Jp7C4JgQZA7obU1xMIpB0uku9KfjfGxiu7TQkdOjLQJmDySermi44YzwO/S5zl5Sr4UDVulzrfpApxql1S3917yuRZ6b1Q0bIBXavt836PEPa89AcrEKpaj1dYQMukWBwrM05e2XhOfMemxf+pEyvwkevnLHfqPfeWd36YoTFHxCYloqQ724i5Ez/W+/lwxnYFKluAwwdhQK0YbHge9S2sdsbrd8WzAby071g0SZb8wY4CIXj0EYET50z8KZbimzzkYPPj5yPfW2RE/8a02jAefGNOP2Kl+RkViZXf6Uz9fiFG1BcYVZJTK1fX/wd8tcYv426Q9hfFrEl3NajNNeELzd+wsMWCm00Rlav/FsO7rr1j019mqTJ9T0dGUUej1Q7FmAjmBlTDBgbE3XmmB2OJmADpfm7RToxpb34z5+w8uTxuJpYpyGMBlFqBh4vJnDFoxH3ZudrsJZd5ZbmCIy9LoJd50WA1USR6fWizsUoMOJBtqu/3M7e8vkapY8uUSoUqr2P+3xbTS8N0NEUfntxRDQC5az9pnxmDEYeiu1bsuZEfDfOulIrIHCHhqHT4enIZ89cXNkjEueBmWlq6Mihnq85XublgNChcVEsFVC2cab0r6q2Sli+9+AjUrlxwJOY4FjddZmVn4tXWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(54906003)(110136005)(8676002)(4326008)(64756008)(66946007)(66556008)(66476007)(66446008)(86362001)(83380400001)(41300700001)(26005)(6506007)(7696005)(9686003)(53546011)(5660300002)(316002)(8936002)(55016003)(52536014)(76116006)(38100700002)(966005)(186003)(71200400001)(33656002)(2906002)(478600001)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFpXV2tXUnlBUlVhR2tjOVpFbURNZU55R0hRYnBVVktxdFdCS0hRbVZ0OE1J?=
 =?utf-8?B?ZzEydWt6bUtMa1BtQlZGdW9FK1NCNUJHcTRNYytBU01vVW1IbWhSclV2d3hB?=
 =?utf-8?B?ajJ5VDhMbHl3eW41dnJic3JvOEFSTlZqMnpoYlRia1hoYVFKYUNOYlFuS2N3?=
 =?utf-8?B?bzlLbC9nTTNTZmpyUDRWMC9lOTlPT1pQSUZxVG1oVEZSczAxTTFTRzFUMk84?=
 =?utf-8?B?bXliUk1LejU3RXJLdFd0c1NxcDFia3lZbXFpcjdiR1dHaUdXeDg5K1dlVDA4?=
 =?utf-8?B?M2pxWnFIdEREQThVTVVNK2xPUlpyck1SaFpPTHpDTUpXY3RYb3FqdUtRL2ZH?=
 =?utf-8?B?WFJMakpmZWFzRTMwWUNVUkM4ZmhBWWYwSHZ6dGdxRm5sRTVJMW1PY2RvMGVP?=
 =?utf-8?B?dEVNd3hkYThoL3IyWUNxVUlZRHU0VnBYaUN5U3lmVlYvRkREdEdORkEwZ2FQ?=
 =?utf-8?B?YkZsWUQrL2NSTlZyalNhaUU3R081SVdSWHBzb3czQTNIWGlNaTYrYjBvaERv?=
 =?utf-8?B?QmJHV25raTVtTi9weC9waGF4WElsb3o5WjRWRUpaaHR3bDV4SzhzNmh3WjQy?=
 =?utf-8?B?U3JvSnZSNEZDeVRickxCMEZxV2ovTk9qekt0S3FaSUY5RWlMSmU3WVE3Wm04?=
 =?utf-8?B?K0k2SWJqUEg4dmY2N2Q5RmtVcElGN1lSRnpFdmROQ2xid1FvdlpTSEZNN1NR?=
 =?utf-8?B?YkZjVEJabXFrWmFPdXg5bjZ6bCt5YTFyYldvM2sxaXE1T3BrQjJNaHNxaW0z?=
 =?utf-8?B?RkxIQXBlaTFYWDdOSzc5bU1GSUtZR29DRGxtWVFKVTEveWxWWHkybk9mbTNS?=
 =?utf-8?B?UHVMTm1WOEdRWFpRSGVBS3VUbTVTNGNsOGxwVkdEdVFjUWxtL1JXMHVPN0Y3?=
 =?utf-8?B?cTc2MVE5M0szS2MxRU5hbUFQTDNRRWM4eFNRdnBPREJocVdHMm9VR0R5KzhQ?=
 =?utf-8?B?Nlg0dXAxY2ZOdWRhN0dDdGUvdVJRbjJQaDdxUDdaWHZxeUJwQ1ZtZWlTMGc5?=
 =?utf-8?B?SFk0WDE4ZUt1dk1QWUtsOTErKzY5K0NsdVRhclA5aTNuM1VZRHJyanFMdDhE?=
 =?utf-8?B?TGc0LzhTdFEyaWF4aWg0RjM2eVZhbnh6VDJwQ2FERWlocjVhckphTS9QaDdL?=
 =?utf-8?B?dkZjL3Y4eXdOSWZYemZ1MDhuZU5UU2RlU1V1WU1nWE9UM0xSL3I5cEdtUHRr?=
 =?utf-8?B?Y2xLT2tnYjZ1K3daQXpGOTNwc0pWdk92VWo1L2g5V3NqdlZablhlOWVnM3BO?=
 =?utf-8?B?MEs5NkEwY3RQWFFyLzNIN3ltOHV4R0ZYMEc5ak5Wd25xZXpNNC9ram9UdTk3?=
 =?utf-8?B?K1pQZk56OUlhSzJhK0dWQXZVTFZLU2FOVGx3cmY0RDRtdElKanVIc3lueFBS?=
 =?utf-8?B?c1lsYjNCUU9COU5UUGFVK0pVVU1TZWkxMklDQWZYS1IvOVVDMDJOM00vbEZt?=
 =?utf-8?B?eGMxY25JOFVwUHhxeHdxNWxmZHE2Smpzb0pQU0lMdHZiSjdPWXZRTXZmbDhF?=
 =?utf-8?B?b0l6ME43VHNFaXZON0l1UitHaGI2cnlWZC95aVozOUZvZTRjZ25RUStScUFk?=
 =?utf-8?B?aTlZVnkxWG9QUnFaWCtNTmFKRDA1VE53ZTc2UlMyeHBzeUpMSEhwVVNLRy8v?=
 =?utf-8?B?ZU0zTGFRTTlLZ2gzaTBsMHV4K09EY2R6WXIzWUVla3NWYzI3NTZUMDkyK1JC?=
 =?utf-8?B?MWR2eFFJVHJkQTIxTzNnL3hOU2RtUC90L0E3RktFM0RZcGU4YjI4Zk5JSlEv?=
 =?utf-8?B?WUlTbFdWL2hVS0xXSTFHYUJlT29VMWFFem9qWGt6Y1BieUQzUW5ybWxFeEQr?=
 =?utf-8?B?VHZweVlhYzJBM0UvckZ5aFk3RFkvaGhlRENwb2pidXpEcDZibDZOdzlpQ2xp?=
 =?utf-8?B?cXE1N215c3ZVOGpXN1l5Wjk5NGdPNi8rZG1VcU9EdmhITzFhWlg3UGZQYmVk?=
 =?utf-8?B?bmJKaFFPdkFXcmZZMTZBLzFJcStMV0RpTWVLMmk5cVpsZVZPY3ExZUZJTWVl?=
 =?utf-8?B?L1RXb0FHL3BtajVLWUtsenI0a0wwZlhHcjhpeGRWTnJRdHVjaFNJWUcyM2JE?=
 =?utf-8?B?Skt5TGtidkk3Q1dhVHAzTERRZTI4YW5CRzhkYmxwRXBpaGljRjVPTENoMXp4?=
 =?utf-8?Q?br0s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd22257a-eefd-48f7-8ec4-08dab193381a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 05:31:48.5607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TTati6mqfkTlIX4c14dooK4250QoQDf6jAOhJfMTCFBhocQ6oAN3VMg0+KsseSzM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIDE4IE9jdG9iZXIgMjAyMiAyMjoyMQ0KPiBUbzogRWxpIENvaGVuIDxlbGljQG52aWRpYS5j
b20+OyBtc3RAcmVkaGF0LmNvbTsgamFzb3dhbmdAcmVkaGF0LmNvbTsNCj4gbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcNCj4gQ2M6IGVwZXJlem1hQHJlZGhhdC5jb207IGx1bHVAcmVkaGF0LmNvbQ0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDEvNF0gdmRwYS9tbHg1OiBGaXggcnVsZSBmb3J3YXJkaW5nIFZMQU4gdG8g
VElSDQo+IA0KPiBIaSBFbGksDQo+IA0KPiBJdCdzIG5vdCBmb3IgdGhpcyBwYXRjaCBidXQgc29t
ZXRoaW5nIHJlbGF0ZWQsIHNvIGp1c3QgYSBmcmllbmRseQ0KPiBoZWFkcy11cC4gSSBoYXZlbid0
IHZhbGlkYXRlZCB0aGUgVkxBTiB0YWdnaW5nIGJlaGF2aW9yIHlldCBmb3IgbWx4NQ0KPiB2ZHBh
LCBidXQgZnJvbSBteSBxdWljayByZWFkIG9mIHRoZSBjb2RlIGl0IGRvZXNuJ3Qgc2VlbSBpdA0K
PiBkaWZmZXJlbnRpYXRlcyB0aGUgY2FzZSB3aXRoIGFuZCB3aXRob3V0IFZJUlRJT19ORVRfRl9D
VFJMX1ZMQU4sIHRvIGJlDQo+IGNvbXBhdGlibGUvY29tcGxpYW50IHdpdGggd2hhdCdzIGJlZW4g
aW1wbGVtZW50ZWQgaW4gUUVNVSBzb2Z0d2FyZSAoYQ0KPiBzcGVjIGFkZGVuZHVtIHdhcyBmaWxl
ZCBhcyByZXF1ZXN0ZWQgYnkgTWljaGFlbCk6DQo+IA0KPiBodHRwczovL2dpdGh1Yi5jb20vb2Fz
aXMtdGNzL3ZpcnRpby1zcGVjL2lzc3Vlcy8xNDcNCj4gDQo+IC0gd2hlbiBWSVJUSU9fTkVUX0Zf
Q1RSTF9WTEFOIGlzIG5lZ290aWF0ZWQsIHRoZSBkZXZpY2Ugc3RhcnRzIHdpdGgNCj4gYWxsIFZM
QU5zIGZpbHRlcmVkIChtZWFuaW5nIG9ubHkgdW50YWdnZWQgdHJhZmZpYyBjYW4gYmUgcmVjZWl2
ZWQsDQo+IGFuZCB0cmFmZmljIHdpdGggVkxBTiB0YWcgd2lsbCBiZSBkcm9wcGVkKS4NCj4gDQo+
IC0gd2hlbiBWSVJUSU9fTkVUX0ZfQ1RSTF9WTEFOIGlzIG5vdCBuZWdvdGlhdGVkLCBhbGwgdHJh
ZmZpYyBpbmNsdWRpbmcNCj4gdW50YWdnZWQgYW5kIHRhZ2dlZCBjYW4gYmUgcmVjZWl2ZWQuDQo+
IA0KPiBDYW4geW91IHBsZWFzZSBoZWxwIGNoZWNrIGlmIHdlIG5lZWQgZnVydGhlciBmaXggaW4g
dGVybXMgb2YgVkxBTiB0YWdnaW5nPw0KPiANCg0KU3VyZS4gSXQncyBicm9rZW4gdG9kYXkuIEkg
d2lsbCBmaXggdGhpcyB0byBjb25mb3JtIHRvIHRoZSBhYm92ZSByZXF1aXJlbWVudHMgYW5kIHNl
bmQgVjEuDQoNCj4gVGhhbmtzLA0KPiAtU2l3ZWkNCj4gDQo+IA0KPiBPbiAxMC8xOC8yMDIyIDQ6
MTIgQU0sIEVsaSBDb2hlbiB3cm90ZToNCj4gPiBTZXQgdGhlIFZMQU4gaWQgdG8gdGhlIGhlYWRl
ciB2YWx1ZXMgZmllbGQgaW5zdGVhZCBvZiBvdmVyd3JpdGluZyB0aGUNCj4gPiBoZWFkZXJzIGNy
aXRlcmlhIGZpZWxkLg0KPiA+DQo+ID4gQmVmb3JlIHRoaXMgZml4LCBWTEFOIGZpbHRlcmluZyB3
b3VsZCBub3QgcmVhbGx5IHdvcmsgYW5kIHRhZ2dlZCBwYWNrZXRzDQo+ID4gd291bGQgYmUgZm9y
d2FyZGVkIHVuZmlsdGVyZWQgdG8gdGhlIFRJUi4NCj4gPg0KPiA+IEZpeGVzOiBiYWYyYWQzZjZh
OTggKCJ2ZHBhL21seDU6IEFkZCBSWCBNQUMgVkxBTiBmaWx0ZXIgc3VwcG9ydCIpDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4NCj4gDQo+ID4gLS0tDQo+ID4g
ICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAyICstDQo+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMNCj4gYi9kcml2ZXJzL3ZkcGEv
bWx4NS9uZXQvbWx4NV92bmV0LmMNCj4gPiBpbmRleCA5MDkxMzM2NWRlZjQuLmRkMjlmZGZjMjRl
ZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMNCj4g
PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMNCj4gPiBAQCAtMTQ3Miw3
ICsxNDcyLDcgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfYWRkX21hY192bGFuX3J1bGVzKHN0cnVj
dA0KPiBtbHg1X3ZkcGFfbmV0ICpuZGV2LCB1OCAqbWFjLA0KPiA+ICAgCWlmICh0YWdnZWQpIHsN
Cj4gPiAgIAkJTUxYNV9TRVQoZnRlX21hdGNoX3NldF9seXJfMl80LCBoZWFkZXJzX3YsIGN2bGFu
X3RhZywgMSk7DQo+ID4gICAJCU1MWDVfU0VUX1RPX09ORVMoZnRlX21hdGNoX3NldF9seXJfMl80
LCBoZWFkZXJzX2MsDQo+IGZpcnN0X3ZpZCk7DQo+ID4gLQkJTUxYNV9TRVQoZnRlX21hdGNoX3Nl
dF9seXJfMl80LCBoZWFkZXJzX2MsIGZpcnN0X3ZpZCwgdmlkKTsNCj4gPiArCQlNTFg1X1NFVChm
dGVfbWF0Y2hfc2V0X2x5cl8yXzQsIGhlYWRlcnNfdiwgZmlyc3RfdmlkLCB2aWQpOw0KPiA+ICAg
CX0NCj4gPiAgIAlmbG93X2FjdC5hY3Rpb24gPSBNTFg1X0ZMT1dfQ09OVEVYVF9BQ1RJT05fRldE
X0RFU1Q7DQo+ID4gICAJZGVzdC50eXBlID0gTUxYNV9GTE9XX0RFU1RJTkFUSU9OX1RZUEVfVElS
Ow0KDQo=
