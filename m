Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF106DDA73
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjDKMLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDKMLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:11:01 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2050.outbound.protection.outlook.com [40.107.215.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AE410B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:10:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmp/lX1M6dheAJgpd2ktoK/V/MOvNEln1KPDJ3OfaKggIiCKvxz/r8G+B7Ux/pOJYejfAVl4RFHmdFmgkIYHWMKg3QEyzeQ7LsF1STaxyMJvrsVAlzi7+0EIy47YKuGWIYYQBCPWijAjQYtwJjt+M+Fnuh3Q67o+OL3nfmqklLyn+aakUJHmB6k2p0ZXREjL12nmnP3rE93jRTUt0o8UPjGngLOQBURpEmdX3MNTVOxf+bZChrkvN+bQSGAE7wvxvZwbfpigZAYrHBFQavto+xXVNwzYHMhU32DOMwpGXXr2If0zOANnUTcZFEV8naSgErwW1I+m7R+wswzS82oIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMWqJbfzrdtK5hvpijmsIT1SDxaIm9FE1mpm+Mvx+hA=;
 b=IUTYnbbjaIxUsBYl7WE7K/gR2RDm4LK3qmMai06QIpmzxBZHJZnOe/XPBWlAprZ4N0Z5gXZOq5Oauz/kR0uVFXL1DdC18kQbcqNojDn01f7QLflnyK6bwL1Lkn9I22tcwSqWjqfYI7IREX57U4cD/UMfurPCPVcH3Id2CzSTdAt3aJ7xLqCKheI0asY60P55+XxFkTERcyulAx9yEkc9kOJSaBzhPZxmB9KvL+cme3HTe3oWHEjRI7nug3rxd8rmVf8EEcTmhgtq7EfHMPzpnWpnic1TBO2ANSYWQBx2ZGv7Er7emmYWYtQ1cm7ztu/0xPkhJ3CpoPjDwSiYgHiWcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMWqJbfzrdtK5hvpijmsIT1SDxaIm9FE1mpm+Mvx+hA=;
 b=cRJMN02LlPfVFjSPb6MOau+v42rSm9B14fziNoQEfYcfSAfxohHRKcYWRCdzOMRFIf9t1wd5x4g5fNeoRUoMKWkrch+E8vVbi9szjxfUllKJy7kXxabqc014zUrRoFIdl2GsWd/ziZds1bnhfhe6unK7WIl1XpQ2vjK+rnU8WSnY16spjbZXkHWKyySie1Ja7C2Fp7+eer7YEyWrGMuYBCqbP9rENHY8msXXTj4JtDrMCaIJo4bcglmZcgdPZ86pEyF36MLg36gAC3j4wETC3OJUt79goEMY9YJlC8p0U3vaACL1a12npfq2wHruMxR9k2zrb9VxAH6jE8I2lsjs6w==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by SEYPR06MB6130.apcprd06.prod.outlook.com (2603:1096:101:db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 12:10:54 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6%3]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 12:10:53 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] virtio_pci: Wait for legacy device to be reset
Thread-Topic: [PATCH] virtio_pci: Wait for legacy device to be reset
Thread-Index: AQHZbBZh3jvrK38aOUOklBMw4wCkQq8lk3uAgAAOhKCAAAi3AIAAADGAgAACIwCAAAP1EIAAAzUAgAAAfRCAADBNAIAACkyggAAF3ICAAAp1oA==
Date:   Tue, 11 Apr 2023 12:10:53 +0000
Message-ID: <TY2PR06MB3424F04CDC1D891BABCBE5DA859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
 <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411024459-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424E3C222C3B896BB583DFD859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411025335-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424DB10784CA5504A10099E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411032014-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424DE523E669A3B1910D7F0859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411061409-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424185F07F76D82746B6503859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411071111-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230411071111-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|SEYPR06MB6130:EE_
x-ms-office365-filtering-correlation-id: 80eef9bd-0eb0-4182-298a-08db3a85cc43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pTINiwIjh9vdn0wn6nlGwQcQSI5WgRx67zsch+GgRkCnEBChbXCo1brkiKLGNBGF3Iibsucng0C1cmKTJBYY9mmpyfdAuwhkI3C+iqivJMfQZ39S/rTxmEof/+z136wGnBBnnMulhqUz0W85uLcnUp8Q8FcDQYyUao/rKe8ik7iWXuCjwF5/JvBEHtzWKrLUMRc0Ow6N70NcUuSrvsk1tWzE57gCuUDNJ1IWXnp0MsDyKnPM4bg8HXnCsARqmZWqrYhJa0xInJP5GxM+vRQrQfJjLYWtVmQh2ntHFHGOpxYFuILYXPmBvYFkuxuIIcqgZbM1y2uojuxUBvw+zthwcBHjpdNvoaAQlVvbUVAFxFvd8MjsJUdD7cYw93Q25l20nBJvqAXVHmfwpWO7KoIARstrSHCL+3CW/HRvkHU+rLA7uFyZbAiH+rahFMIuayysfzqZ5IXCc3i6FmFmglIKo6iFJ44SfO5oy3tWdanmYv6Mr3kaFSh1iIJfLjmLpP4XJtnL318ibiMunGE2I6y+R9x1+g4xqFf9aSJ3qS7+utAJF+vJT5NM5ue7T0pJ10Ogedfcks+BSFz6R6bGFDWwk+MspoKtZrzDeIwUQDg0uqZ8ugrAmxwf/WSfZSQHVRy4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(39840400004)(346002)(396003)(451199021)(7696005)(71200400001)(66476007)(4326008)(6916009)(66556008)(54906003)(478600001)(64756008)(66446008)(66946007)(41300700001)(76116006)(316002)(86362001)(33656002)(83380400001)(9686003)(26005)(6506007)(8676002)(8936002)(5660300002)(52536014)(2906002)(44832011)(55016003)(38100700002)(38070700005)(53546011)(122000001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2lDSEQ2YVVzc2xKd0x1OWlDMXM1WTFtdE9DbFkzc2c3UytkcWlTUjdvZlVT?=
 =?utf-8?B?d2NUTHQ1NDdmL2RCT2pJa292ZVdsYk5SV3RuZWtUd0xFNlhiV01OS3JQamtW?=
 =?utf-8?B?dXVYalBvOEp4d0E2OXpwMW1uRFQ5TlZ5MjZhRjlVNVFuc2QvbkNZWW1ESCs5?=
 =?utf-8?B?RjE2eWFJTkJMOUZTbTQzWTd3NXFYTmt0OHZ2Slh4NmZnSzBpRW5hcXVJTjFz?=
 =?utf-8?B?NTdMNXBhVGlFZXYwS0NXbENUQjk3bktFTnhYTGZLRVdML2kxcDFPNnVFb0FW?=
 =?utf-8?B?ZXVJRHlFZHhzYzE1RVFoQTVTMTZ2UG1yZmhaeUpieGNMMmgyY3RHaXJveXht?=
 =?utf-8?B?WkZ2TnF6cURRZHdQeDYwRHU2M01YUER4dHk4Sk81L0YrbFZ6eWdsOThJL2lB?=
 =?utf-8?B?OE55b3B4ZDhFV0V5WEpNWjhiZyt1Tmhycy9uMlVTMFNJL3pIMDJlVXNYM2d0?=
 =?utf-8?B?aWNiMkFnSlBFcUtuVDlqQk5ubkg5VEd6TThWTTF6S090cW9mbEpTSktSdklJ?=
 =?utf-8?B?Kyt4Vy93TzhoSHlPVW0xQVFGL09nWjlFdGg0V25JQVFIdXMzNzd2S0VpNFAx?=
 =?utf-8?B?dVpJc29wazVqUzlIeDNDcEdKTnVjdTFjbHFPQWU1K3BIYlE2SzlkbmhQRWlm?=
 =?utf-8?B?OGdPc3ZSTFErSEd4UnN0Yi9ndUhOU2xxRGVyL3JtTkJ3QUxyWHNDTHVGSlBB?=
 =?utf-8?B?QkNvWFpaY1ZVamhqZ1lzaDdkb3ljS2RRTXU4bzM5b3VZMlBZQ0hQRW1UcGF6?=
 =?utf-8?B?dW11MjBQeHMxQjlSTnIwVS9rQTVSRkRYT2VmS2pmVHdLam1QMDVqeGdBSEE4?=
 =?utf-8?B?ZTVNem9iNU5BSnl4dWoySE9ZSGk0Sm44a2s3d3QyUm5GYTZPZU5LRGdMTDRQ?=
 =?utf-8?B?Vkd2Mi9OcjRHSFowTWpJQWpKOHlYN1E0NitKWThBYTdYS3Z3WTYrYUpuYm5v?=
 =?utf-8?B?WWE0cXhxUzhQTUVteUpFVzV5MzdsbndUb2c0V1JPdVp0VGg5b0NIY054NW5D?=
 =?utf-8?B?UTNXdjIxZkQxMVVmZnBqSlAzNzhmanF6bUloUWV3YWJzV1J5dVgrRUlPeGtN?=
 =?utf-8?B?S0E4OWtZczdETWRnU1lHeVhmMzA5dHFZNmZ1c2ZaVnJLVXhTTERUdVpRa3dO?=
 =?utf-8?B?NHp6SzlhRDFpT3dabFJkWFZiL0gyNTZsZEQ0RE1DVmd2Q0xPeUVPSzNYRGhp?=
 =?utf-8?B?TzZJWDhUODZDdkt4RmJHTUxLc0VBUHBjbmUzL0phUm1ua3Z3WVl0bTlXR3VJ?=
 =?utf-8?B?Q0cwZVlWcjIvMjdXMjIxcGxUdlIyZXNaY25ZTXVFRXV0SFgxVitVbHZWd0hm?=
 =?utf-8?B?QkdHVjVZR3Y5b3haMldMc0I4bkU2RnE5OEZyQTl4emNCZ0E3SStzdmE3MjZZ?=
 =?utf-8?B?WW5nNU1XRm5BcXZiWStneVZGNzlwYTQvZjJsVU9iNmpOZXorZS82aXVvUmNR?=
 =?utf-8?B?UzJnQTJ2T1NMR1ViODlUQUg1Q0xnVmRKMlB3dE52WmdLRk5HNGdEb3pZdE51?=
 =?utf-8?B?LzJqRnFwekxwWENMSGJOc0UxemNNOE04UmFRQ1N1N0VtdkhoejNZcnluclZx?=
 =?utf-8?B?TzU3dXFZcDZLZzRFQ29TVXRxV21CN0pTVi9sTjRmY2RmNGw3bkRGVkdsb3hO?=
 =?utf-8?B?TXJXSUdhazM2VWdoRVhCWmlxY3N1SmRJcEIzK3NKcXNocE16Q2ZWQ3dMY1dl?=
 =?utf-8?B?Y2tQWFdqR1lnOGFMRSt1VlFyRHlrQm1QMmtTK2d6Zzg2TThXVUNhUlhrSlJD?=
 =?utf-8?B?MTQrQjZucU9kbi9iall4K0gwZFIrcCtXcXVoYTdEOWZ3dVlxM0tZVzVOZVho?=
 =?utf-8?B?ZVZFTmpRVmN5anpKeGJpdk5ycStqdGRRcWFEcnVnRG5XalFnQ1VhaG9mM3VV?=
 =?utf-8?B?b0lvTk5NMVVWdno2QUljbGxxU3BTUnJoSVFPSlpWeXVNQmJNSUR3MVE1MXZ5?=
 =?utf-8?B?c0JidE56TGhKbVBDQjhYQjFXVWxoeGtFT1o4OFlEL1ppTlIvMHN3RHM5MjBT?=
 =?utf-8?B?SW9Ob3hGTDBzNHpYaFAvcVNNR2lPL1E0SEd4N3hYZVU2dWh3cWt3cWNhdVBC?=
 =?utf-8?B?MWN6QUVCU1d6eU1wRU93R1B4Z2VkTjJ4R3ZwQUJvaURwTFpDY1pTYVFLYmkv?=
 =?utf-8?B?RlBXWE9hSlFVTFlmVTI0QnFneW8xMTZCaWtwQy92QzNHRllPYlRIQXVqcFVN?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80eef9bd-0eb0-4182-298a-08db3a85cc43
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 12:10:53.5013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JZE/D99jvBhw4aVwl0l4f7gGX3aT9ZCirF0dWx0cHnaE0N4IXCzqVRMLugAM1vE5lsjAbFlPNEXZcV0h3J4qqXMTaXkemY/xDKEv/GnNVFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6130
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBTLiBUc2ly
a2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVlc2RheSwgQXByaWwgMTEsIDIwMjMgNzox
NCBQTQ0KPiBUbzogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+IENj
OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPjsNCj4gdmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSF0gdmlydGlvX3BjaTogV2FpdCBmb3IgbGVnYWN5IGRldmljZSB0
byBiZSByZXNldA0KPiANCj4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMTA6NTc6NTFBTSArMDAw
MCwgQW5ndXMgQ2hlbiB3cm90ZToNCj4gPiA+ID4gPiBZZXMsIG5vdCB2ZXJ5IGNsZWFyIHN0aWxs
LiBXaGF0IGFyZSB0aGUgZGV2aWNlIGFuZCB2ZW5kb3IgSUQgb2YgdGhlDQo+ID4gPiA+ID4gY2Fy
ZD8gRG9lcyBpdCBoYXZlIHRoZSB2aXJ0aW8gY2FwYWJpbGl0aWVzPw0KPiA+ID4gPiA+IFRoYW5r
cw0KPiA+ID4gPiBJdCdzIGhhdmUgdGhlIHZpcnRpbyBjYXBhYmlsaXRpZXMuDQo+ID4gPiA+IFdo
ZW4gaXQgaXMgdXNlZCBpbiBiYXJlIG1ldGFsIO+8jA0KPiA+ID4gPiAgICBpdCBqdXN0IHVzZSBQ
Q0lfVkVORE9SX0lEX1JFREhBVF9RVU1SQU5FVC4NCj4gPiA+ID4gV2hlbiBpdCB1c2UgaW4gdm0s
DQo+ID4gPiA+ICBJdCBpcyBqdXN0IGxpa2UgOg0KPiA+ID4gPiB7IFBDSV9ERVZJQ0VfU1VCKFBD
SV9WRU5ET1JfSURfUkVESEFUX1FVTVJBTkVULA0KPiA+ID4gPiAgICAgICAgICAgICAgVklSVElP
X1RSQU5TX0lEX05FVCwNCj4gPiA+ID4gICAgICAgICAgICAgIFBDSV9WRU5ET1JfSURfSkFHVUFS
TUlDUk8sDQo+ID4gPiA+ICAgICAgICAgICAgICBWSVJUSU9fSURfTkVUKSB9LA0KPiA+ID4gPiAg
ICAgeyBQQ0lfREVWSUNFX1NVQihQQ0lfVkVORE9SX0lEX1JFREhBVF9RVU1SQU5FVCwNCj4gPiA+
ID4gICAgICAgICAgICAgIFZJUlRJT19UUkFOU19JRF9CTE9DSywNCj4gPiA+ID4gICAgICAgICAg
ICAgIFBDSV9WRU5ET1JfSURfSkFHVUFSTUlDUk8sDQo+ID4gPiA+ICAgICAgICAgICAgICBWSVJU
SU9fSURfQkxPQ0spIH0sDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gT2theS4gU28gaXQncyBhIHRy
YW5zaXRpb25hbCBkZXZpY2UuIFRoZSBxdWVzdGlvbiwgdGhlbiwNCj4gPiA+IGlzIGhvdyBjb21l
IHlvdSBlbmQgdXAgd2l0aCBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jDQo+ID4g
PiB3aXRoIGEgbW9kZXJuIGxpbnV4IGF0IGFsbD8NCj4gPiA+IERpZCB5b3UgYnkgY2hhbmNlIHNl
dCBmb3JjZV9sZWdhY3kgPSB0cnVlID8NCj4gPiBZZXMsSSBjYW4gcHJvdmlkZSBtb3JlIGluZm9y
bWF0aW9uIGFib3V0IGl0Lg0KPiA+IFdlIGNhbiB0ZXN0IGl0IHVzZSBmb3JjZV9sZWdhY3kgLG9y
IHdlIHVzZSBhIHNlcnZlciB3aXRoIG11bHRpIG9zIGJ1dCBpdCB1c2Ugb25seQ0KPiBvbmUgY2Fy
ZC4NCj4gPiBUaGFua3MuDQo+IA0KPiBPa2F5LCBzbyBJIGRvbid0IHlldCBzZWUgbG90cyBvZiB2
YWx1ZSBvZiBtZXJnaW5nIHRoaXMgcGF0Y2ggdXBzdHJlYW0uDQo+IFRoZSBwcm9ibGVtYXRpYyBj
b2RlIGRvZXMgbm90IHJ1biBieSBkZWZhdWx0IGFzIHRoZSBtb2Rlcm4gZHJpdmVyIGlzDQo+IHVz
ZWQsIGFuZCBhcHBseWluZyB0aGUgcGF0Y2ggdXBzdHJlYW0gZG9lcyBub3RoaW5nIHRvIGZpeCB0
aGUgbXVsdGktb3MNCj4gY2FzZS4NCj4gDQpFbiwgSSB0aG91Z2h0IHRoZSBzYW1lIHdheSB5b3Ug
ZGlkLHNvIEkganVzdCBmaXhlZCBpdCBvdXQgb2YgdHJlZSBvbmUgeWVhciBhZ28uDQpCdXQgdGhl
IGxlZ2FjeSB2aXJ0aW8gbW9kZWwgaXMgdXNlZCBtb3JlIHRoYW4gd2UgdGhvdWdodCBpbiByZWFs
IGNsb3VkIGNvbXB1dGluZy4NCg0KQnR3LEkgd2lsbCBzaG93IHRoZSBtYWlsIHRvIG15IGJvc3Mg
dGhhdCBBbHRob3VnaCBpdCBpcyBtZXJnZWQgZmFpbGVkLCBJIHRyaWVkLGhhaGEuDQoNCj4gV2hh
dCBkaWQgSSBtaXNzPw0KPiANCj4gDQo+IC0tDQo+IE1TVA0KDQo=
