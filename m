Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EA7627850
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbiKNI7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbiKNI6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:58:45 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B781D66B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:58:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeeA0tGAw+AJLrwP0erBeUn92N3WlD2Y3EeIoraTeSjuFeml8ixrms5EK47UWtTxGdvK3YzDOXBqdBqCzLVq2YRz913skDmfyDcb5X+rZKoydjC0Yn1n/h1lRB6yS+fog3qRhVT1dx3SqC2Y+0SvDMDBWZNqLnwVKZIrvaJE2ko3xkeNpSEXIDNxTqBAUt0InxDwOG3ngI9Nyp421bAqPC7i4LMmsEul9rNvnCm1NjYw16Zi4y8YXqKn6Si9XcUWc5AjItNclyXoZyd+lJgNOywr+9q4HHIUd/tugNFvP5szMKccqf9nf8NmhMlx5g7JSewn4dmH33UXacDDiVT92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uElWvTbjSl2hqu5iZ+lCfIZhAQUMm21kByeVBjhvc0=;
 b=YghwGx04Ksqr1/KCXLIncW6jXTsInE8nqX8kxoyIb/Wuuk0bEleVLvIciFDDuI52SG0bvGEbW74fO8+B1a8TcbEHON8LnC3NZXJFaeazRrpja+iPI/K9H0NSpEBB5TFkJlHzPqvzvtnBRWB4AV1ydHywo/88/2qOZ71gksW86uUzeuax9THtUrVlNrbE3qondXduUP6n0gcxec882Pl0aqVidSRvIfm5EBHf9+3Yl8nD47bG3GmT2WZy+BPH785m7QcS9QYil3bf/jxRdO48HwWxhYIw1M0krGksXDGFEv9bz+sa4Kwrt9+DQOZyJ97xNm626H9EI+0EAla7XmcWgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uElWvTbjSl2hqu5iZ+lCfIZhAQUMm21kByeVBjhvc0=;
 b=T+3qIiCwz2ylcwDfrRCBYVmmkHfuN4V4WhdYyJ8toiPRoFtJoq7ZXIRaNLA5KLzXeeeT0hHa1X05Gak+TxlqEz74KR3ZQFoyLbkrQkcs7IfE6FjtOJXvPpT2dXptZyQPoDQ5ofmzKxKu7HEWRa1dW9uRKwkmAlOOpcOO6kaU0t5fL0+3cDh/JUtXsuDb1fMDp2EbEik1vcHXciTwxGT4WlGJZ0pQIilUyfJXKvgK9/emIFETogKCbvaUh2m1WX5JUTbmeObDM31TFe5AHkaGFfZW1isN73RKIrx8dAyfueEufsUoD9Si/gXFkzQ4/yRARC3EvcBCsBA4NyGeGaWIiw==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 08:58:19 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::dd38:ea25:225c:bd6]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::dd38:ea25:225c:bd6%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 08:58:19 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>
Subject: RE: [PATCH 6/7] vdpa/mlx5: Avoid using reslock in event_handler
Thread-Topic: [PATCH 6/7] vdpa/mlx5: Avoid using reslock in event_handler
Thread-Index: AQHY92YuGq/T8yLr7US8pN3NxU+2ma4+DXmAgAARO8A=
Date:   Mon, 14 Nov 2022 08:58:19 +0000
Message-ID: <DM8PR12MB54008F8D33409AFCA5878AAAAB059@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20221113134442.152695-1-elic@nvidia.com>
 <20221113134442.152695-7-elic@nvidia.com>
 <CACGkMEt+7kKD8_q_OFKURbFR1W=YbJpcuwZq5bf5jC4qzE8PEA@mail.gmail.com>
In-Reply-To: <CACGkMEt+7kKD8_q_OFKURbFR1W=YbJpcuwZq5bf5jC4qzE8PEA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|MN0PR12MB6271:EE_
x-ms-office365-filtering-correlation-id: c1cd5ae4-92b0-484b-ad95-08dac61e6060
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4uwxJa4m1x0/IIVWK7qargeCXIZbQrzk5cYMqkE63PWJbiRgPdhqFOq9gYP0MhYl96QikxA6OqC80plbS/mLv5eYlZI+iXg9dYYxzfoFGEgrrRdIhrk0fV5/cN7GpmeOR+nycbZJWhTaYeZw3RIU5CqW2MOR4gMxnpteA2OQ1J88BrqnlBDjDjBerNlPvDmR+Um7EOHGj3UwOVCRB+7oqOeWCVnA91mGHnXihsQLv90fnan7Ca8X5MvI2YVP17QJUdbUA3RYYdMD6LChRAJkNWpOTNXYfERMZqS4qoHWh61NtCcfgg14UviTvmIc1HM1e8TfgNJSMef0ekBazW0NNqwDJCCEwe7HBPXQ/AFOh3/3l6GVeIlcaF75smYIj0xFrlbA72rHmXKlpHRhDxQXkAu2xOMmnVJMfCYG2h/A/t51rGTX1/ypxXV3uri7acGHKuYfucnYUB18qJ/UhdgtDC0S9ZrBdf1IRgXve0LU44LgK/l1kEmBwOvvKfMZNxUZBUnajXYEM59Nyk07MPWFEJr//D4IJ5ExsfeCydms7hm1npTzG6GZHp+ESf5i+feDNp74P62nGD5OQ/caJhTI0YFOk2lTB8dGRKjmHR7Brc45zi73GlsREgBC2ERkINQOUwndvYGoP+FghkMFQooYcfq3wtm7wzHVi94oxoPsdRfiDTWRzPTBaY7WM/XMYaE5BXeHQ50ZCwY1XnLeRcC1waDGRNlzOfED5jk/iUX9Qpk5lye7tv0g1r0izKx9MuI5cdcLrXMq78r3Cpkw2jZpSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199015)(478600001)(71200400001)(7696005)(6506007)(38070700005)(54906003)(6916009)(66556008)(55016003)(66446008)(316002)(86362001)(26005)(76116006)(66946007)(53546011)(9686003)(122000001)(8676002)(64756008)(4326008)(38100700002)(186003)(8936002)(52536014)(5660300002)(83380400001)(33656002)(41300700001)(66476007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjVOUVhZQ2o1RG9IbXpDazNKSmdHOE1ORWJiUkdIMzNyb3hrQkxuaURmRDM5?=
 =?utf-8?B?c1Fmak9YQTh4SGdWWHduRXBXNFVNSlFoNTkxNzJXL2JKazd1RGhmeGNvdmhq?=
 =?utf-8?B?dWpmRDd2TGFXVStsVGFJUlNQZjloN3ZVMVU1VVZ3YlowYVdMdSsybm1qSFVp?=
 =?utf-8?B?dHpvVk0vazNWcGpmczRaS1dLMmlON0RIOWVLNlBreFZOa3VQZVdsWmZWdUYr?=
 =?utf-8?B?eElsbnNGZUFVU29rcmVHczFERXBDRi8vMTJQNWxhRllBWnVjbVZpOEMyUlUx?=
 =?utf-8?B?V25WUjlNTHFKUTdLQ0FubTBQcnAwcnFjd1lvaktTZHNTQmpuZmd3YTlHdzVG?=
 =?utf-8?B?SlQyQ0piOWtTOUNqWHk5dW9rM0xWaGs2eE5Kb04waG5pZ1FqWXNrQ3FLbXlZ?=
 =?utf-8?B?U2FWUlRZVUl1d1lhckczd3VoaTZrTTVJdU43R0N6U1FXMWR6KzlGWVRNTUtT?=
 =?utf-8?B?eFVabjVoR0lhWjYvZGlMS1JqRXJ2aTJsalVBQU5GVXQ5ZGx4WHd6UFFyREQ3?=
 =?utf-8?B?UlVPU3JSQmlUckVyZHBnR0Jya0p2Qkc5NEZjNWhQWGs2QjRzaUFSdlVGVUdE?=
 =?utf-8?B?L1V3aTRxV0Y0MGZhTDduU0VmMUhGK3dCY1ZQUmlveWNjZlhYSU5lLy9YSEJ2?=
 =?utf-8?B?SytGUDNnS0pTc2pCcjBhMTQxSW0rdW1EWXVCNGUzczU2bURhK3VqK0grYU1x?=
 =?utf-8?B?NVdxM1NlUko4aGJzOHUvc3lMbm1lZlhVaGdWL1J3N2NHUEZpTERMbitHaWlk?=
 =?utf-8?B?TWhlRHBNSUpqSjUrMjYra01ZRS9FbkZnNXNVbWN6aWRzc3p6U25sc1U4OWF3?=
 =?utf-8?B?eXRZSExtTUN0dVdSVDVPS21rOElKYnYzWkdVajJKbUJTbTRFT203c1A3MzJ3?=
 =?utf-8?B?K1ZyZzM4czhsMjloUmV2eVJNQzNOemEwcGhXWDduako1Tm5mWHB2bzJFaTgv?=
 =?utf-8?B?VWFQcDdNTVEzQzJ3NGsrVWZjN1ZOcW5mbnp5dlhXSWpLbWZ0QlJNNXpnaHh0?=
 =?utf-8?B?MFYyM0F0dmIxK2ZCa3ZKVmpUV1daRU13a25wUFpJUmI5YmtIclhjb1JUUkZF?=
 =?utf-8?B?amsvUnpXQk1uYklTcWptMkxNbTFBSk5ONWl4enNydi9SZ2Z5cGd1RWlwMitD?=
 =?utf-8?B?VmlUZFFYSHYrcExack5ISzVYTWZEbDU5QUpXNzBIQzFSc3lPS041Tmp0cDJJ?=
 =?utf-8?B?OHFkTllDWklLRTVUUlBRZmVDbjZ4bmhpYnVuU05LL1RMeWNDcG10d2xrRWs1?=
 =?utf-8?B?ak1vQnRGWlhMK05RMEk2VkFCWDF4a05ZbDk2NFYyNVZXODg0dmRoQ013ajB3?=
 =?utf-8?B?d0Z6NXJRbktWU0RnOWt6YXdlZmRVUHF3UW9TelovcHlaZFM3VFhiS3BYT2pB?=
 =?utf-8?B?U3NFdVRBbUFva2RZdUh4NDd2b3l0UGovZ1JOeUpWRkE2TVcyZUVHYUx5UHMy?=
 =?utf-8?B?Z0FhaGNacVdSQzBTanQwc2lyamVFZkl6cjgyMUtyaXdkeUIxRm1Xb24rd1BK?=
 =?utf-8?B?UGVSRUREQnY5aDFYYWx6c25HcTNtaHM1Sk1rcWhSMDFIU01qQ25sblFuMzBE?=
 =?utf-8?B?aDFjVTA1bEdlUmVrWW0wMkgycWdYaXN5S0VVMitXb0t0WDQ2bkFwRndHMFlq?=
 =?utf-8?B?WlFBaUpOalEwU2lKVXVsRFhzS0txTko0RkpuWm5xWWpaTmhNbXRmNGVZWkRx?=
 =?utf-8?B?dDFKWUFXbXBRMTFiWFRrYTU3MnAwaS8xQjdVRmZPekxOOWJOd1Q4TkUrVzFz?=
 =?utf-8?B?RCtWTkFaSmZkWFFmd2hSWG1aRDdaVVJFZjh6NFVpMTRBVG0zbzJDTFFDYXow?=
 =?utf-8?B?TUQxZENZL1B0MlF1U1RERG1JODVlQTdNdkRidXFlVjFuNUpxT3I3MG9iYzBr?=
 =?utf-8?B?L09VMVZxVlJMMFo3Q0ZvTkg4d21rK2ZyaHcxaTltQmlHTzdQM1JFS2Rnb0FS?=
 =?utf-8?B?VW1lc3NmanN1S0RFckhHa21UYXRGeXNBTmFlZWxjSUI2STZ3akg5TlltWFVU?=
 =?utf-8?B?dWx4ZGNMVWxPczZJZjhiYjlZMDM3ekNTcG56VjFrdU51MGlGOS9sdG1SVkh3?=
 =?utf-8?B?cUhnRU1XMkR0cnM2K2NCNStkT0FrMTV1Qnl1TkV3VlpvM2tUVXlkd29lRUlt?=
 =?utf-8?Q?na8c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cd5ae4-92b0-484b-ad95-08dac61e6060
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 08:58:19.4301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3TjrD/VM31guPbNCCKUn3fc7ADZNpzR2QMumplvaygQtvEqYL6sZfaXTCqNs39QE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBNb25kYXks
IDE0IE5vdmVtYmVyIDIwMjIgOTo1Mw0KPiBUbzogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+
DQo+IENjOiBtc3RAcmVkaGF0LmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgdmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtDQo+IGZvdW5kYXRpb24ub3JnOyBzaS13ZWkubGl1QG9y
YWNsZS5jb207IGVwZXJlem1hQHJlZGhhdC5jb207DQo+IGx1bHVAcmVkaGF0LmNvbQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDYvN10gdmRwYS9tbHg1OiBBdm9pZCB1c2luZyByZXNsb2NrIGluIGV2
ZW50X2hhbmRsZXINCj4gDQo+IE9uIFN1biwgTm92IDEzLCAyMDIyIGF0IDk6NDUgUE0gRWxpIENv
aGVuIDxlbGljQG52aWRpYS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gZXZlbnRfaGFuZGxlciBydW5z
IHVuZGVyIGF0b21pYyBjb250ZXh0IGFuZCBtYXkgbm90IGFjcXVpcmUgcmVzbG9jay4gV2UNCj4g
PiBjYW4gc3RpbGwgZ3VhcmFudGVlIHRoYXQgdGhlIGhhbmRsZXIgd29uJ3QgYmUgY2FsbGVkIGFm
dGVyIHN1c3BlbmQgYnkNCj4gPiBjbGVhcmluZyBuYl9yZWdpc3RlcmVkLCB1bnJlZ2lzdGVyaW5n
IHRoZSBoYW5kbGVyIGFuZCBmbHVzaGluZyB0aGUNCj4gPiB3b3JrcXVldWUuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgMTQgKysrLS0tLS0tLS0tLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jDQo+IGIv
ZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jDQo+ID4gaW5kZXggNmU2NDkwYzg1YmUy
Li5iZWJmYmE1MzAyNDcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21s
eDVfdm5ldC5jDQo+ID4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jDQo+
ID4gQEAgLTI4NzIsOCArMjg3Miw4IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX3N1c3BlbmQoc3Ry
dWN0IHZkcGFfZGV2aWNlDQo+ICp2ZGV2KQ0KPiA+ICAgICAgICAgaW50IGk7DQo+ID4NCj4gPiAg
ICAgICAgIGRvd25fd3JpdGUoJm5kZXYtPnJlc2xvY2spOw0KPiA+IC0gICAgICAgbWx4NV9ub3Rp
Zmllcl91bnJlZ2lzdGVyKG12ZGV2LT5tZGV2LCAmbmRldi0+bmIpOw0KPiA+ICAgICAgICAgbmRl
di0+bmJfcmVnaXN0ZXJlZCA9IGZhbHNlOw0KPiA+ICsgICAgICAgbWx4NV9ub3RpZmllcl91bnJl
Z2lzdGVyKG12ZGV2LT5tZGV2LCAmbmRldi0+bmIpOw0KPiANCj4gSSB3b25kZXIgd2h5IHRoaXMg
Y2FuIGhlbHAgYW55dGhpbmcuDQpJIHRoaW5rIHlvdSB3ZXJlIGNvbmNlcm5lZCB0aGF0IGFzeW5j
IGV2ZW50cyB3aWxsIGNvbWUgd2hlbiB0aGUgZGV2aWNlIHdhcyBzdXNwZW5kZWQuIFNpbmNlIHdl
IGNhbid0IHRha2UgcmVzbG9jaywgSSB0aGluayB0aGlzIGd1YXJhbnRlZXMgdGhhdCB3ZSB3b24n
dCBnZXQgYW55IGV2ZW50cyBhZnRlciBzdXNwZW5zaW9uLg0KDQo+IEFuZCBpZiBpdCBkb2VzLCB3
ZSBoYXZlIHNpbWxpYXINCj4gbG9naWMgaW4gbWx4NV92ZHBhX2Rldl9kZWwoKSBkbyB3ZSBuZWVk
IHRvIGZpeCB0aGF0IGFzIHdlbGw/DQo+IA0KV2UgaGF2ZSB0aGUgc2FtZSBjb25zdHJ1Y3QgdGhl
cmUgb25seSB0aGF0IEkgc2V0IG5iX3JlZ2lzdGVyZWQgPSBmYWxzZSBhZnRlciB1bnJlZ2lzdGVy
aW5nIHRoZSBub3RpZmllci4gU28gSSBwcm9iYWJseSBuZWVkIHRvIG1vdmUgaXQgYmVmb3JlIG1s
eDVfbm90aWZpZXJfdW5yZWdpc3RlcigpLg0KDQo+IFRoYW5rcw0KPiANCj4gPiAgICAgICAgIGZs
dXNoX3dvcmtxdWV1ZShuZGV2LT5tdmRldi53cSk7DQo+ID4gICAgICAgICBmb3IgKGkgPSAwOyBp
IDwgbmRldi0+Y3VyX251bV92cXM7IGkrKykgew0KPiA+ICAgICAgICAgICAgICAgICBtdnEgPSAm
bmRldi0+dnFzW2ldOw0KPiA+IEBAIC0zMDUxLDcgKzMwNTEsNyBAQCBzdGF0aWMgdm9pZCB1cGRh
dGVfY2FycmllcihzdHJ1Y3Qgd29ya19zdHJ1Y3QNCj4gKndvcmspDQo+ID4gICAgICAgICBlbHNl
DQo+ID4gICAgICAgICAgICAgICAgIG5kZXYtPmNvbmZpZy5zdGF0dXMgJj0gY3B1X3RvX21seDV2
ZHBhMTYobXZkZXYsDQo+IH5WSVJUSU9fTkVUX1NfTElOS19VUCk7DQo+ID4NCj4gPiAtICAgICAg
IGlmIChuZGV2LT5jb25maWdfY2IuY2FsbGJhY2spDQo+ID4gKyAgICAgICBpZiAobmRldi0+bmJf
cmVnaXN0ZXJlZCAmJiBuZGV2LT5jb25maWdfY2IuY2FsbGJhY2spDQo+ID4gICAgICAgICAgICAg
ICAgIG5kZXYtPmNvbmZpZ19jYi5jYWxsYmFjayhuZGV2LT5jb25maWdfY2IucHJpdmF0ZSk7DQo+
ID4NCj4gPiAgICAgICAgIGtmcmVlKHdxZW50KTsNCj4gPiBAQCAtMzA2OCwyMSArMzA2OCwxMyBA
QCBzdGF0aWMgaW50IGV2ZW50X2hhbmRsZXIoc3RydWN0IG5vdGlmaWVyX2Jsb2NrDQo+ICpuYiwg
dW5zaWduZWQgbG9uZyBldmVudCwgdm9pZCAqcA0KPiA+ICAgICAgICAgICAgICAgICBzd2l0Y2gg
KGVxZS0+c3ViX3R5cGUpIHsNCj4gPiAgICAgICAgICAgICAgICAgY2FzZSBNTFg1X1BPUlRfQ0hB
TkdFX1NVQlRZUEVfRE9XTjoNCj4gPiAgICAgICAgICAgICAgICAgY2FzZSBNTFg1X1BPUlRfQ0hB
TkdFX1NVQlRZUEVfQUNUSVZFOg0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGRvd25fcmVh
ZCgmbmRldi0+cmVzbG9jayk7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFuZGV2
LT5uYl9yZWdpc3RlcmVkKSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
cF9yZWFkKCZuZGV2LT5yZXNsb2NrKTsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiBOT1RJRllfRE9ORTsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICB9DQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgd3FlbnQgPSBremFsbG9jKHNpemVvZigqd3FlbnQp
LCBHRlBfQVRPTUlDKTsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAoIXdxZW50KSB7
DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1cF9yZWFkKCZuZGV2LT5yZXNs
b2NrKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoIXdxZW50KQ0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIE5PVElGWV9ET05FOw0KPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgIH0NCj4gPg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHdx
ZW50LT5tdmRldiA9ICZuZGV2LT5tdmRldjsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBJ
TklUX1dPUksoJndxZW50LT53b3JrLCB1cGRhdGVfY2Fycmllcik7DQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgcXVldWVfd29yayhuZGV2LT5tdmRldi53cSwgJndxZW50LT53b3JrKTsNCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgICB1cF9yZWFkKCZuZGV2LT5yZXNsb2NrKTsNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBOT1RJRllfT0s7DQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgICAgICAgICAgIGRlZmF1bHQ6DQo+ID4gLS0N
Cj4gPiAyLjM4LjENCj4gPg0KDQo=
