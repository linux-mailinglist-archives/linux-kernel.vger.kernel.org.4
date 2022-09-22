Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B966E5E5CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiIVIBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiIVIB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:01:26 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE6120345
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR5ksN6t4/zek1O9LNc4+m74C4E/ko2Q1vv+C8hRsX7TVFi1+zdJk33xlbPgg+g5TX/eRp+utSFCJmjrsuVMMECvZf5DbKsRchx//l+CDonEPerf2c0IfLzh6RJxZUTky6AnEpHWctd8u71zulEgtV++1BzgjrWHJeiVmCuxdimEgRBeTGpPfydco3NIy63vSXyw8iaQVXyD5r8f4cjpz1S4kQQjMsnrB12lNxli6caecHgvfStBLmdKitdnqglEWmHUTBs6BOEfN3TtjddGRNt5K5eZcY+hgghxguxYzMLCgphvukMy4X2WcqJ/+7XwNRKGlNpZ5Uf8PiHdo+9tjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLgyn+ybysxI81OnqMoRNoep59zNQkD1gXe8zyrHvfo=;
 b=Ml+9FSu7HI+NPWOStPPzZcm6ONB0TRn5xS+Nz8KDVcTOAwd5XMOQ31B0zJcUzaHeAVGn9yhsnW/89bnMPS/0qZMMDnLSyinuwTAwoEBf4FFWXa2X3SHoeUrVjIA/qqp7K1PTknaqC9ZYyHK51+YZ0zaLcIELKXGiPHI+s2zn09WXubjSg+lOwfQZ5KFx3Hhava7vPW6BuWSs4KGZv+MmE/MJ6OORIZQFzuaF+zWRqpBgQTOrnX0+3s1b+s+1rJBLTN7szPz2aKRexWQInRKEvzjT0feE4BnhUz5qwFgs9Wq6beZEozk09gbaUUwql5NdfkRG4G0QcKmFVlai1RqQcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLgyn+ybysxI81OnqMoRNoep59zNQkD1gXe8zyrHvfo=;
 b=ElZg3V+4iVc+LIkicuM1n6na8PuV0412lCZn+1TGCYJfOnfGvOGoiLeE0ZGauumvp65vfAOn0rZBW3WbnveWpfBOahUsBXL23jYIkOaWFu0wvaKU7ENczXmhyVMOGco5hMr+vho1UOpWFNY6FB8A0ZMSEJ22htjMxCTiKnwA4jw3h1DYt0854yKIKOK6vP52pE/ByiZWKLsiSEQni0sYs3OC0zdMcP/xU+dUCoHQtcwqPURDO16hEdfoPah2QQhRNcTyg9ntGD6IBG0+wmcAyUDpQDsd8uVGjTP0v0ggLZPVyrKTkMpZXXT/j6zQHih3DxjEPuUpLMRQAICVKdnEZg==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.21; Thu, 22 Sep 2022 08:01:23 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357%6]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 08:01:23 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Jason Wang <jasowang@redhat.com>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        Parav Pandit <parav@nvidia.com>,
        "wuzongyong@linux.alibaba.com" <wuzongyong@linux.alibaba.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>,
        "gdawar@xilinx.com" <gdawar@xilinx.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "xieyongji@bytedance.com" <xieyongji@bytedance.com>
Subject: RE: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
Thread-Topic: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
Thread-Index: AQHYzi0gH9Mt5ZhE+EK/NJhRzVZV9a3q52cQgAAmcQCAAATFgIAAAdaAgAABs3A=
Date:   Thu, 22 Sep 2022 08:01:23 +0000
Message-ID: <DM8PR12MB5400EC129B7A2B0D86EE72F2AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
 <DM8PR12MB54005C65A85B32063A5E17A8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220922032858-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400D6550D2253E9964260F8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220922035028-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220922035028-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|DS0PR12MB7629:EE_
x-ms-office365-filtering-correlation-id: 288e23d0-5811-42bc-88c5-08da9c70a44e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XZCp86ltWj24SOUMj11amEkJF3khiB9RA9SWjdwrSeWLnNWA2RUpS35aryYG7dN66fiYxUIDCn6AsWeTBFZkV1Q1PZGcpBoNiKukUId8gvEkhgO7bOD7bYNzLlWSB9gIOqfhx3bRxVNG3JrrOJ7zoo2KcQxhtFx2QH0GzK49GAkySbsojTq8jOjx/Q6gPb3fL/krOCLL6NCddbat0o983uH4MpUt7t5hAcb9r+Mo6xtn4i0IVUovcYmYLpx19dzaWDmYBi8+Xbf0sB3eC3vrsbjNQ0rjiFNKoQ1JEEBABdFeyiH23YpNbXqwEJMdx50BnbkObgphJ+i6Ix4zIC+71pMoxozI60SeHdnbP0Rl7e7DJIjvaE0MI4TcKpOy0ByW8JywSqWKNwf/4CA0kXyUUBQ4S2QbHLvqyzWv90QHlibi3wpEuU/9JKqs1t4Cigh56a65H5RlLVKz2656xA76xwfP3BCHxGaoJh42Gn4bkMh+K5qA6U6yIK9XJA6IJ0J9K1lxs/bmWQUR0VrRsKDmK9c/OlP8RG7Ug2n3hC+qCSiCrpx+bmpcIFb1Qe8Gu1Xb3I/mRDGwhsYxPDcWiM03kpe7sQdUHlqOV8pJftkEQU28+xngs2JBHOIEKGHmBEIQSVoLCpwupQBueKYQ/J6pLpGkKe0TYlgrj7nz6+PlQs3fsejdWNwwExme1RTbkfi6+fMeAl1eIXwJ8JvrO980qP9FHhe0udBymNjRkc648eSo+7UNm2eH1iVxKBnsifnEXjQSGV0JlA5T7pGxYFRUgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199015)(7416002)(5660300002)(186003)(52536014)(316002)(6916009)(54906003)(26005)(9686003)(38100700002)(76116006)(8936002)(86362001)(33656002)(66446008)(4326008)(7696005)(38070700005)(6506007)(71200400001)(478600001)(55016003)(66556008)(41300700001)(53546011)(83380400001)(66946007)(2906002)(64756008)(122000001)(8676002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3NkYnRFc3NGSHNwMThHVlZITHBkSW1OOThRNG5oTUNLdWhZQzRqSUdLNGVF?=
 =?utf-8?B?bzVTTGp5WjBuVWVsVHh3V0dnNmp6UnVzV2w2N0dRbnRpa0hBOVhHbHZYYWNo?=
 =?utf-8?B?V2h2NG5mRDNIR1Y2OGE5TVp3N1VXMHpTNDZtMkx2Z0tWVFZ2dThtRzZGL0lr?=
 =?utf-8?B?NkI1TjVWZktiZHgrcHJiMGNuaWNlZDRqVlpPbG1XSVZ6NkNOWjdDY0lxRytX?=
 =?utf-8?B?aVpQNlJaeU4zZXU3elQrcU9waC9KTEZpaGNESW1OZ0RUUXNSUkVwakcxR2Nl?=
 =?utf-8?B?WU5tOG9YSUdHS1Z0S01hT3ZDUGNyQWllVnlIcG9EK3lweTBiWXlmNjMrdnlN?=
 =?utf-8?B?VDdCaWxZRFFQLzg5dHVWc0FsdXlZN3IwS0txdTFWeHRERDZ2YWdjQit0ZDFi?=
 =?utf-8?B?M2szd3gwWVg5cEZrdXEwVWZSQy9STVJ0cVR1V1RZTFpnRHhLMnExc3NKdFBX?=
 =?utf-8?B?WllicW9xZU1idmdkU3hoMjYzajdFOVB5MWxQSFFZVzdzMUhHeTcxaEU0UnFO?=
 =?utf-8?B?YUc3ZUE5UW15VFVmWGNUcVlaZUY0cVVySVZkdDE4QW5vQkFUZkNXN21ydUZ2?=
 =?utf-8?B?SThOTlRrV0RzeVZPcFk5UjJGYis2K3JtMWlBSm1abTM1eHdwUmxaaS94ZEZo?=
 =?utf-8?B?Y1ZhcXlRQW01VEJidkhpQk5ubDFEY0tJQTFaZkVDTTFOU3lDWUg0Q2dhaXkx?=
 =?utf-8?B?WFdFQTBITFZaUThzQ2Y4azZncmdhUWZ2N2lOSVRQcXFMVTFuSThuVDd1TXJR?=
 =?utf-8?B?UE43OGhFZU42Rkt6LzdvOWZGQ0lJNjJlbkF2WUtDOVlnQStCaURRcW5tN3ZH?=
 =?utf-8?B?Njd6R0ZrQnJTbUNob1ZjNkl5TFRFeWZVLzlUNXIzRExNODNEdVBhQ1BMT1ht?=
 =?utf-8?B?cjNSbk00MnUzci9qeUROOW1HMHY1dFNnUnF4S1d1SERBL2NEQlJsVWhxQ285?=
 =?utf-8?B?enp5N0orOVMzU0IwMzcvdGs3TkxQSVJ3cjQrYkFiM1ZWREd4VVdpRmlzaW1k?=
 =?utf-8?B?QWZPT2ZXajkyU1hLak1vZUhBL1BPM1VVb0JwT1daUlFHZG9KYzJ6aHZ2TWVk?=
 =?utf-8?B?clJIcjlBbzVUbzFWR0l6RmdBcVNDTmVFKzRyd094ZnhyL2dXWHlOam03U2lG?=
 =?utf-8?B?bktmUmRUb3NvYW9idDZsWXplSjRrVWZ3bW45TUxrV2pEL3Y2RHptZURQSW41?=
 =?utf-8?B?M0NXYVRkQkJYbndDR2VMQkgwMWRSdGkxTjRhYjhSa2V3cFd4WGJmMGpnSXNv?=
 =?utf-8?B?dndBSFoyRURDblZSTlZBREZhbFNMbXR6YW5FTTJKeE9WeFQwRW9RUUtpZ3hC?=
 =?utf-8?B?U1Z3bGsrbUdiTUhZblNkVG1oa1FrSG1XZ2dtWStrS0dxUkIyUTJpZ0hIeFVV?=
 =?utf-8?B?NE0wcXUwbGxtOWdGSlBKV2xONE4vZm50UXNma0lrZStGYUpWU29FRndtcy93?=
 =?utf-8?B?MlBnTHVwRUdubTF2Nzg4RjFyK2Y0QWRiVlMwNFRaZjNMTGZlSXFqYTY1LzlM?=
 =?utf-8?B?Vy9BR3NkdDR3dTM5MVhTTUhBaHVhUExMUmhSWVhHbUxnSFJFU2VrZ2ZmZlVM?=
 =?utf-8?B?bDdEMkNQV29Wa1huaitmbVpqOGtmSnh0Nk55alFrSzNKYTBnRk1POUlXb2l6?=
 =?utf-8?B?dnpMb1paL0NzNWoxdWVORjRadEJKREIwSHhpZkJrK1RUaHhFRzhCKzQvYWJl?=
 =?utf-8?B?L3prMHkxeStiL1U5V0lFaFFVZCtnaS9nU2VDS0ZlMXVwNWNZOHhxNzRGbDRU?=
 =?utf-8?B?RTRoMS91a1I4WE1lSHdDMnI0cDFuMC9GSndNTkZjRTBjWkQvUk1mQXZqWjZo?=
 =?utf-8?B?Q2NQVnF0RlcxMEFPZy81MzlwODhwWk03czdqdmhQdC83dWYrWW1CSWxEMDk0?=
 =?utf-8?B?WU0rdUdCeTloaTJrL0tKQkJHSnZ1dHNKT2dmd3FJdEVsMVJia0ZVT0ViNkEz?=
 =?utf-8?B?ZmpZTmV2YmlUMnNmQ3Z1MFR5a3lsaUVjK3p0R0xBM3d5cmpROGx4bG1DeUUz?=
 =?utf-8?B?UEY3Rlh4U0VoZzJLaEtYOW56ZGJNbFZOdEtWb0F2dWtKNDdHRTYxd0s5YTky?=
 =?utf-8?B?dG56K1hVMERPcTZVVFAyT0htaXVzdit1QTlBWDZuallrNGRZdGFuSzlNcm1j?=
 =?utf-8?Q?dJzM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288e23d0-5811-42bc-88c5-08da9c70a44e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 08:01:23.2758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H0+zqKf2EmaU85sXH7+SSyLMpzOoDnKS7px0i/uK52OtKet2lSdD6iCGk1C2SDdo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgMjIgU2VwdGVtYmVyIDIwMjIgMTA6NTMNCj4gVG86IEVsaSBDb2hlbiA8ZWxpY0Budmlk
aWEuY29tPg0KPiBDYzogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT47IHNpLXdlaS5s
aXVAb3JhY2xlLmNvbTsgUGFyYXYNCj4gUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPjsgd3V6b25n
eW9uZ0BsaW51eC5hbGliYWJhLmNvbTsNCj4gdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGVwZXJlem1hQHJl
ZGhhdC5jb207IGxpbmdzaGFuLnpodUBpbnRlbC5jb207IGdkYXdhckB4aWxpbnguY29tOw0KPiBs
dWx1QHJlZGhhdC5jb207IHhpZXlvbmdqaUBieXRlZGFuY2UuY29tDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggVjIgMi8zXSB2ZHBhX3NpbV9uZXQ6IHN1cHBvcnQgZmVhdHVyZSBwcm92aXNpb25pbmcN
Cj4gDQo+IE9uIFRodSwgU2VwIDIyLCAyMDIyIGF0IDA3OjQ3OjQwQU0gKzAwMDAsIEVsaSBDb2hl
biB3cm90ZToNCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
ID4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gPiA+IFNlbnQ6
IFRodXJzZGF5LCAyMiBTZXB0ZW1iZXIgMjAyMiAxMDozMA0KPiA+ID4gVG86IEVsaSBDb2hlbiA8
ZWxpY0BudmlkaWEuY29tPg0KPiA+ID4gQ2M6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+OyBzaS13ZWkubGl1QG9yYWNsZS5jb207IFBhcmF2DQo+ID4gPiBQYW5kaXQgPHBhcmF2QG52
aWRpYS5jb20+OyB3dXpvbmd5b25nQGxpbnV4LmFsaWJhYmEuY29tOw0KPiA+ID4gdmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+ID4gPiBlcGVyZXptYUByZWRoYXQuY29tOyBsaW5nc2hhbi56aHVAaW50ZWwuY29t
OyBnZGF3YXJAeGlsaW54LmNvbTsNCj4gPiA+IGx1bHVAcmVkaGF0LmNvbTsgeGlleW9uZ2ppQGJ5
dGVkYW5jZS5jb20NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMi8zXSB2ZHBhX3NpbV9u
ZXQ6IHN1cHBvcnQgZmVhdHVyZSBwcm92aXNpb25pbmcNCj4gPiA+DQo+ID4gPiBPbiBUaHUsIFNl
cCAyMiwgMjAyMiBhdCAwNToxMzo1OUFNICswMDAwLCBFbGkgQ29oZW4gd3JvdGU6DQo+ID4gPiA+
ID4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gPiA+ID4gPiBTZW50
OiBUaHVyc2RheSwgMjIgU2VwdGVtYmVyIDIwMjIgNTo0Mw0KPiA+ID4gPiA+IFRvOiBtc3RAcmVk
aGF0LmNvbTsgamFzb3dhbmdAcmVkaGF0LmNvbQ0KPiA+ID4gPiA+IENjOiBFbGkgQ29oZW4gPGVs
aWNAbnZpZGlhLmNvbT47IHNpLXdlaS5saXVAb3JhY2xlLmNvbTsgUGFyYXYgUGFuZGl0DQo+ID4g
PiA+ID4gPHBhcmF2QG52aWRpYS5jb20+OyB3dXpvbmd5b25nQGxpbnV4LmFsaWJhYmEuY29tOw0K
PiA+ID4gPiA+IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51
eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+ID4gPiBlcGVyZXptYUByZWRoYXQu
Y29tOyBsaW5nc2hhbi56aHVAaW50ZWwuY29tOw0KPiBnZGF3YXJAeGlsaW54LmNvbTsNCj4gPiA+
ID4gPiBsdWx1QHJlZGhhdC5jb207IHhpZXlvbmdqaUBieXRlZGFuY2UuY29tDQo+ID4gPiA+ID4g
U3ViamVjdDogW1BBVENIIFYyIDIvM10gdmRwYV9zaW1fbmV0OiBzdXBwb3J0IGZlYXR1cmUgcHJv
dmlzaW9uaW5nDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMgZmVh
dHVyZXMgcHJvdmlzaW9uaW5nIGZvciB2ZHBhX3NpbV9uZXQuDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiAxKSB2YWxpZGF0aW5nIHRoZSBwcm92aXNpb25lZCBmZWF0dXJlcyB0byBiZSBhIHN1YnNldCBv
ZiB0aGUgcGFyZW50DQo+ID4gPiA+ID4gICAgZmVhdHVyZXMuDQo+ID4gPiA+ID4gMikgY2xlYXJp
bmcgdGhlIGZlYXR1cmVzIHRoYXQgaXMgbm90IHdhbnRlZCBieSB0aGUgdXNlcnNwYWNlDQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBGb3IgZXhhbXBsZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICMgdmRw
YSBtZ210ZGV2IHNob3cNCj4gPiA+ID4gPiB2ZHBhc2ltX25ldDoNCj4gPiA+ID4gPiAgIHN1cHBv
cnRlZF9jbGFzc2VzIG5ldA0KPiA+ID4gPiA+ICAgbWF4X3N1cHBvcnRlZF92cXMgMw0KPiA+ID4g
PiA+ICAgZGV2X2ZlYXR1cmVzIE1UVSBNQUMgQ1RSTF9WUSBDVFJMX01BQ19BRERSIEFOWV9MQVlP
VVQNCj4gPiA+ID4gPiBWRVJTSU9OXzEgQUNDRVNTX1BMQVRGT1JNDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiAxKSBwcm92aXNpb24gdkRQQSBkZXZpY2Ugd2l0aCBhbGwgZmVhdHVyZXMgdGhhdCBhcmUg
c3VwcG9ydGVkIGJ5IHRoZQ0KPiA+ID4gPiA+ICAgIG5ldCBzaW11bGF0b3INCj4gPiA+ID4gPg0K
PiA+ID4gPiA+ICMgdmRwYSBkZXYgYWRkIG5hbWUgZGV2MSBtZ210ZGV2IHZkcGFzaW1fbmV0DQo+
ID4gPiA+ID4gIyB2ZHBhIGRldiBjb25maWcgc2hvdw0KPiA+ID4gPiA+IGRldjE6IG1hYyAwMDow
MDowMDowMDowMDowMCBsaW5rIHVwIGxpbmtfYW5ub3VuY2UgZmFsc2UgbXR1IDE1MDANCj4gPiA+
ID4gPiAgIG5lZ290aWF0ZWRfZmVhdHVyZXMgTVRVIE1BQyBDVFJMX1ZRIENUUkxfTUFDX0FERFIN
Cj4gVkVSU0lPTl8xDQo+ID4gPiA+ID4gQUNDRVNTX1BMQVRGT1JNDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiAyKSBwcm92aXNpb24gdkRQQSBkZXZpY2Ugd2l0aCBhIHN1YnNldCBvZiB0aGUgZmVhdHVy
ZXMNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICMgdmRwYSBkZXYgYWRkIG5hbWUgZGV2MSBtZ210ZGV2
IHZkcGFzaW1fbmV0IGRldmljZV9mZWF0dXJlcw0KPiA+ID4gPiA+IDB4MzAwMDIwMDAwDQo+ID4g
PiA+DQo+ID4gPiA+IEhvdyBhYm91dCAiZmVhdHVyZXNfbWFzayIgaW5zdGVhZCBvZiAiZGV2aWNl
X2ZlYXR1cmVzIj8gQ291bGQgYXZvaWQNCj4gPiA+IGNvbmZ1c2lvbi4NCj4gPiA+DQo+ID4gPiBO
b3Qgc3VyZSBJIGFncmVlLg0KPiA+ID4gZmVhdHVyZXNfbWFzayB0byBtZSB3b3VsZCBtZWFuIGl0
IGlzICYgd2l0aCBmZWF0dXJlcy4gTm90IHRoZSBjYXNlIGhlcmUuDQo+ID4gPg0KPiA+DQo+ID4N
Cj4gPiBTZWUgdGhlIGNvZGUgYmVsb3cNCj4gPg0KPiA+IEBAIC0yNTQsNiArMjU0LDE0IEBAIHN0
YXRpYyBpbnQgdmRwYXNpbV9uZXRfZGV2X2FkZChzdHJ1Y3QNCj4gdmRwYV9tZ210X2RldiAqbWRl
diwgY29uc3QgY2hhciAqbmFtZSwNCj4gPiAgCWRldl9hdHRyLndvcmtfZm4gPSB2ZHBhc2ltX25l
dF93b3JrOw0KPiA+ICAJZGV2X2F0dHIuYnVmZmVyX3NpemUgPSBQQUdFX1NJWkU7DQo+ID4NCj4g
PiArCWlmIChjb25maWctPm1hc2sgJiBCSVRfVUxMKFZEUEFfQVRUUl9ERVZfRkVBVFVSRVMpKSB7
DQo+ID4gKwkJaWYgKGNvbmZpZy0+ZGV2aWNlX2ZlYXR1cmVzICYNCj4gPiArCQkgICAgfmRldl9h
dHRyLnN1cHBvcnRlZF9mZWF0dXJlcykNCj4gPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwkJ
ZGV2X2F0dHIuc3VwcG9ydGVkX2ZlYXR1cmVzICY9DQo+ID4gKwkJCSBjb25maWctPmRldmljZV9m
ZWF0dXJlczsNCj4gPiArCX0NCj4gPiArDQo+IA0KPiBPaCBJIGRpZG4ndCBub3RpY2UuIEl0J3Mg
dW5uZWNlc3NhcnksIGlzbid0IGl0Pw0KPiBDYW4ganVzdCBlcXVpdmFsZW50bHkgYmUNCj4gDQo+
IAlkZXZfYXR0ci5zdXBwb3J0ZWRfZmVhdHVyZXMgPSBjb25maWctPmRldmljZV9mZWF0dXJlczsN
Cj4gDQo+IHJpZ2h0Pw0KPiANCg0KSSBkb24ndCB0aGluayBzby4gWW91IHdhbnQgdG8gbWFzayB0
aGUgc2V0IG9mIGZlYXR1cmVzIHRoYXQgdGhlIGRldmljZSB3aWxsIG9mZmVyIGJ1dCB5b3UgY2Fu
bm90IGRpY3RhdGUgaXQuDQoNCj4gDQo+ID4gPiA+ID4gIyB2ZHBhIGRldiBjb25maWcgc2hvdw0K
PiA+ID4gPiA+IGRldjE6IG1hYyAwMDowMDowMDowMDowMDowMCBsaW5rIHVwIGxpbmtfYW5ub3Vu
Y2UgZmFsc2UgbXR1IDE1MDANCj4gPiA+ID4gPiAgIG5lZ290aWF0ZWRfZmVhdHVyZXMgQ1RSTF9W
USBWRVJTSU9OXzEgQUNDRVNTX1BMQVRGT1JNDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBSZXZpZXdl
ZC1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+
ID4gPiAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jIHwgMTEgKysrKysrKysr
Ky0NCj4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRw
YV9zaW0vdmRwYV9zaW1fbmV0LmMNCj4gPiA+ID4gPiBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92
ZHBhX3NpbV9uZXQuYw0KPiA+ID4gPiA+IGluZGV4IDg4NjQ0OWU4ODUwMi4uYTliYTAyYmUzNzhi
IDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9u
ZXQuYw0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9uZXQu
Yw0KPiA+ID4gPiA+IEBAIC0yNTQsNiArMjU0LDE0IEBAIHN0YXRpYyBpbnQgdmRwYXNpbV9uZXRf
ZGV2X2FkZChzdHJ1Y3QNCj4gPiA+ID4gPiB2ZHBhX21nbXRfZGV2ICptZGV2LCBjb25zdCBjaGFy
ICpuYW1lLA0KPiA+ID4gPiA+ICAJZGV2X2F0dHIud29ya19mbiA9IHZkcGFzaW1fbmV0X3dvcms7
DQo+ID4gPiA+ID4gIAlkZXZfYXR0ci5idWZmZXJfc2l6ZSA9IFBBR0VfU0laRTsNCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+ICsJaWYgKGNvbmZpZy0+bWFzayAmIEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9G
RUFUVVJFUykpIHsNCj4gPiA+ID4gPiArCQlpZiAoY29uZmlnLT5kZXZpY2VfZmVhdHVyZXMgJg0K
PiA+ID4gPiA+ICsJCSAgICB+ZGV2X2F0dHIuc3VwcG9ydGVkX2ZlYXR1cmVzKQ0KPiA+ID4gPiA+
ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiA+ID4gPiArCQlkZXZfYXR0ci5zdXBwb3J0ZWRfZmVh
dHVyZXMgJj0NCj4gPiA+ID4gPiArCQkJIGNvbmZpZy0+ZGV2aWNlX2ZlYXR1cmVzOw0KPiA+ID4g
PiA+ICsJfQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiAgCXNpbWRldiA9IHZkcGFzaW1fY3JlYXRl
KCZkZXZfYXR0cik7DQo+ID4gPiA+ID4gIAlpZiAoSVNfRVJSKHNpbWRldikpDQo+ID4gPiA+ID4g
IAkJcmV0dXJuIFBUUl9FUlIoc2ltZGV2KTsNCj4gPiA+ID4gPiBAQCAtMjk0LDcgKzMwMiw4IEBA
IHN0YXRpYyBzdHJ1Y3QgdmRwYV9tZ210X2RldiBtZ210X2RldiA9IHsNCj4gPiA+ID4gPiAgCS5p
ZF90YWJsZSA9IGlkX3RhYmxlLA0KPiA+ID4gPiA+ICAJLm9wcyA9ICZ2ZHBhc2ltX25ldF9tZ210
ZGV2X29wcywNCj4gPiA+ID4gPiAgCS5jb25maWdfYXR0cl9tYXNrID0gKDEgPDwgVkRQQV9BVFRS
X0RFVl9ORVRfQ0ZHX01BQ0FERFIgfA0KPiA+ID4gPiA+IC0JCQkgICAgIDEgPDwgVkRQQV9BVFRS
X0RFVl9ORVRfQ0ZHX01UVSksDQo+ID4gPiA+ID4gKwkJCSAgICAgMSA8PCBWRFBBX0FUVFJfREVW
X05FVF9DRkdfTVRVIHwNCj4gPiA+ID4gPiArCQkgICAgICAgICAgICAgMSA8PCBWRFBBX0FUVFJf
REVWX0ZFQVRVUkVTKSwNCj4gPiA+ID4gPiAgCS5tYXhfc3VwcG9ydGVkX3ZxcyA9IFZEUEFTSU1f
TkVUX1ZRX05VTSwNCj4gPiA+ID4gPiAgCS5zdXBwb3J0ZWRfZmVhdHVyZXMgPSBWRFBBU0lNX05F
VF9GRUFUVVJFUywNCj4gPiA+ID4gPiAgfTsNCj4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+IDIuMjUu
MQ0KPiA+ID4gPg0KPiA+DQoNCg==
