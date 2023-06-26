Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5CB73D611
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 05:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjFZDCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 23:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjFZDC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 23:02:26 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2069.outbound.protection.outlook.com [40.107.255.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6891A7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 20:02:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yed8zT66rFyVUKfNKqAG6drz78dU0U7nNS4LUsL4SlNpR2iGZUtUKIaqp0zL4e8V9khGcr0WpdsLtlpNxIvnmnsF3BNH6BrF85iWNYpAnGQ4DlZxDqSzsZbLwiLHhYjLMlUUJ+DJtfLmO8ddSTjWeWZuen/7yvciRxsu54MVEbEZjvv2jZsBVOsFQu748cPwi21Y34dfN9EcOqByXPEum0FvY4ZwRhaEtF6sLfFeP61osw1XQFM732HEE9KVtIhZzQ92m/RRuRp2WFbnuD8rOrf4NM2mEkex+OLqqg5mgQn2WYkoTq84GXdIcgK1WpDYocluqzfsrUXTbPN+NEGoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJgmAKM4+f0Wk0cDE/bhGS3njZPIweBkFcdrsKINCKY=;
 b=O8nynhDaOytqvUlr/0JEtgAug/Gg62oMGW3tYkcJZYg3K7vg3FZiyAFIAqfxZfO1TqMvlyeayZUcQmpLnxywDIZCADF6+8SFSrSnkCiYhSfTQGH5I4X/iljQ8VvWlSkOOSL0kR/RpfEeMAk1jdYlraQSWCs81Ya8Kl9ZI3fywUB8PMzbkKiD4dtM6cNwDEIGG6mpLIKYFGOALq0gTwAMlJyzgHGpSl2BfaU+BxjzUoqUndzbIZIf0PsPfvqdP4Q52Pqb0XShddI3eUU7BxvXst6j73YY7kBfjT2T+wv3R6Yr0sDDkb32klI0hD40mcT8EjsFKxV5bxb6M7Vtj5lAzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJgmAKM4+f0Wk0cDE/bhGS3njZPIweBkFcdrsKINCKY=;
 b=En70catiWbtXNzOQsIrljmcUfFTkReoOgsUlh2Wgi+exqmwV/twVWspyVdBOVm2xHWcCdTHI8ewfl84nicly42lylVmCrrV6qIjfiSbUnEbjTH0ky44qtlo0Ng2JpgwTE2tDwg8nRkitHkg4KcWd5Naym2f6h594j3YIWGS/e/A7gJDJ7VJXHcspWqVR37dX1HFf5SNyZME0tpiJtrgPv8YnzmWU815jLAmoXDwtUw34lZcovGmlDzBAsuKeEtlDXf+yneTU+SSVSgVSNi8Cst1j+buUNVwKt2mqk/XVWi1odF9a38QB2KP+6eSmD/NPqbnnDS2XnSvcobLGEZfQxw==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by KL1PR0601MB4017.apcprd06.prod.outlook.com (2603:1096:820:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 03:02:19 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::57d3:a80d:905:d7be]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::57d3:a80d:905:d7be%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 03:02:19 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device from
 add_config
Thread-Topic: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device from
 add_config
Thread-Index: AQHZmefhGgrgL1M5iUCr+LYolFSqU6+ceIAAgAACjaCAAANEgIAAARTg
Date:   Mon, 26 Jun 2023 03:02:19 +0000
Message-ID: <TY2PR06MB3424EA4EADAE511ED3CB282C8526A@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20230608090124.1807-1-angus.chen@jaguarmicro.com>
 <CACGkMEtp6H1x301CynwDfsXCMOVt_mrVh9G7dUxVdDLdLBB8yg@mail.gmail.com>
 <TY2PR06MB34247A17ADD347D439EF84DA8526A@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <CACGkMEuXfo3DRrAfrwFPfKaOTCkmJ7hxVw=JVP12mPBM8Ccp=A@mail.gmail.com>
In-Reply-To: <CACGkMEuXfo3DRrAfrwFPfKaOTCkmJ7hxVw=JVP12mPBM8Ccp=A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|KL1PR0601MB4017:EE_
x-ms-office365-filtering-correlation-id: 62e3ffc9-ddaf-469e-aeb6-08db75f1c176
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w4/q/qKuNfUWx1tOonanqnvUoAPMN5htGwil94OA3uYYpPqmGilDBDzzGVhow75fh/ZBShD4tClggAyNNKI6Jq7cfV3EKgYYCp9LgEXDoazx8BMOp5+p83Kwvi2/8cbApYb9076j7y6huPjPqS1hshujvDQ8HAozI8LlsOXffoc2kPg2uFUqS65zoAmFmmXhR8+HtNFkQJnv3yU/zpYRjFVfJIbRiT80wcVNtnR8QBjH9p8J7U1a5fjwjYR/3eAuX6LeeKbpPy1pFkXJ1uNRGFAntYlgTchkXnv417/7HLgB4VjNKSf0li0FLGPX1DYZVSd0+Wdk0BcApr9ZtyM9mT1zMqNlpJp0v1fERsohSmab4yNmc2VkAPJCYestTnsY452gzd7xizUD/LJQS0N/w8RHKoHcz1dtWcXp9pJXj4GWFFe8noFTh/pJiat5mo2/hCF0Py5MDrhYaMftDyy73XdEe1SGwHhdiwUjBdWM644Q9wduUmOxqsEhTDexXbKApJFH35SU5CaGUnRrKDN10QCRgmZakIc3ObbQu3dOyAiqx4aAHS1q55SYFxHZHTEP+ofblawcGOz3iNPw48KxZBkByP1O2mdNruF+uauv1EDOWa9J7JexteD+oijQk1BN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(39840400004)(136003)(451199021)(33656002)(52536014)(5660300002)(44832011)(41300700001)(316002)(86362001)(66476007)(6916009)(64756008)(8936002)(8676002)(38070700005)(66446008)(66556008)(76116006)(4326008)(38100700002)(122000001)(55016003)(66946007)(26005)(6506007)(53546011)(2906002)(186003)(9686003)(7696005)(71200400001)(478600001)(54906003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTNmTnhlTVl3YkRMTnhnRk4xaVZra08zWDhqbnpLME1FMU9meEUyVWtYbWJG?=
 =?utf-8?B?NFBZZkU0V1VzdFJtMEV4YVB6ZU9RYVc4SEFqUVFmSWZmeDA3ODFveDdaSmJs?=
 =?utf-8?B?YWwrQlYxUVo0Q05ZMU1kVUxuT094OEU4RVplQjQyUGhZNnBDS2RQUnRQRHRy?=
 =?utf-8?B?dXFDakJrSWFNNWs1Z3dlN1BEaDJ2VkdSUU9xMXQzUk01Q0dheFZyV0VPYk03?=
 =?utf-8?B?SUQ2QUlpaXJPRTJ1Ky9qSkR6eEhSYVlvN0tEQTNyblJIbUtWaE5uZG0rbEcy?=
 =?utf-8?B?dEZETk1hc3YreGIxTVlkeWNpVmJZRHprSXlLTHU2UGJqYXJPQ2tTYURSeGdS?=
 =?utf-8?B?Sm5ZcStBdk5DaDExejZRREdjUXFOdHp6VDNXTnYvaWg2cUduaHZYaURYaWJO?=
 =?utf-8?B?bVVZK1NKeWlIRXRoZU42L3R6Y1lwZUVIc0pUTmFkQ0FjOFB6QVBTdW9iL0JC?=
 =?utf-8?B?VEI5VDJQUEdFQ1JQWnRLSnVpNXc2b3Z3R3VYUW1VaDBTV09LUE1tVkVWcHd4?=
 =?utf-8?B?VUFNY3F2dHlUYzdwUjdOdTRWNmZqQnlPbDVFV1FBQzNyekxJSGFreUtJWkM4?=
 =?utf-8?B?Sjc4Tm05Z2xTWEFmKyt0NlluVG9HaWt2VlFTSDNtUGxpZ29FRzVIQklpTXlQ?=
 =?utf-8?B?bU9RMnlhbGtOVGMrcUlZbVhyb2pzbWJvQ0dnZzc0N2E1MTNDYzlubGFEdXY0?=
 =?utf-8?B?MjRTRVV3bWVUM2N1TVdEaVR4Rm5WVUhWdlluajM2SSs3Zzk5dnhVdjVneEVx?=
 =?utf-8?B?QStabTkxT2RLWWtid2hVR2J4WUVOTHRrRVU3YWxhcGl4bTZJeUgxdUEwNm51?=
 =?utf-8?B?RFEvRnVrMllwTVR2bU5nNi9xNnN2eURuek1hSVVFS3pXemxpZGpxSTF3VVdo?=
 =?utf-8?B?SUNsdmVqcU9jT3YxbmhObXZvOU1BcWovU0dGVUdRUUZ0RmtRNVlkeFZKNUZD?=
 =?utf-8?B?Rm53OVdwUU1FZFVBUkV5cGhlQzB3YlphbUpGK3pveE5XOTEvMENzU0toQkln?=
 =?utf-8?B?OFp2Wnhnc0JSUXl1cGNLSjNBdWRlSjVSeVBUN012aGxzaTRFdkp3ZFJ0MGdM?=
 =?utf-8?B?NXZwc1Zaa29OeGZ0MllzNFFCZDhEL0VsaWJmZGN1MEc4Y1F5K014dzBMQUtk?=
 =?utf-8?B?ejlmSGptQm42SWloWkVjUHY1Yk01T2g3Nk1zQTlWRnczMldwaG5tZlhublpj?=
 =?utf-8?B?c1F6cE5zMm5PZnRIbFhOa1FOWHZabm03ZUc4Z0lEaHczZUdzb2Jkc3ZqVlJw?=
 =?utf-8?B?ZldXRlZ0K2p1UTJKenBKUDR1REFSaEZaTHc2dDJsNG55bEMzSGV4ZEdmWnJZ?=
 =?utf-8?B?dCtNcVFjaFFEOU5JRGU0dzFBOGkxb216YWQ3SCtKTVBvTVI5aXpndjUyWm5i?=
 =?utf-8?B?cmZkOWFadVlZUFRRTTZXRGptdTJPK253MmxoWUxpbzRPSFI3RmtyMHRWQWYy?=
 =?utf-8?B?SktKYkZSeU1JSFhOU3NDeW9nMU5NZmJjUUpQZytoSitPcnBLazZwa1dMOXBu?=
 =?utf-8?B?OVpadm90N1BOdHcrYlZsRE5rWmQ2cWd5bjNDQTBFY01XbFpERUFPTmxhRTdM?=
 =?utf-8?B?Uk1wTGdJTDFmOVMyamwzUzZVQVdGZHJZTnZjTW0vUUdRVEQvUlVQNy8vRkg4?=
 =?utf-8?B?UFRKWjlJcmNWaWJmYkcwbGt6aFhVVm10cUdWb1J4cmhQK1U5Qjhtd3ZtaW9K?=
 =?utf-8?B?VU5HbG9mSnJRWERBb3dYaUZJK0wrSmZvMXk4eldWLzZEY3poaytLWmlxVzcv?=
 =?utf-8?B?ZzVwc29wQklxd01JdTY0RkxJSlVyN3NHQlMyeDJsWEtuYUI1TnFWRXF2WWEr?=
 =?utf-8?B?Z3VrZjdYdEx3ZGJiYm9VTFltbUQ0dkZtNFJ4MTZ3UDBJRXFZenV5SnF1YlR2?=
 =?utf-8?B?RWkwYjhUd2pSa2oveTlkRGdYaTJ2aUpUQnNtYTdLZTlxTGNqeHA0dk5sWXZO?=
 =?utf-8?B?TU5OUlBKMjY0OHdoYjl6OUgxT2phZ2R4LzlSV3dLcDV0VW02WXdmYkM5NUpU?=
 =?utf-8?B?dU9KRHJFM1F1Q2s4aGZzd2VzSW5va1A5a1BYalNVUno3YVc2Vy9wY1dic3U1?=
 =?utf-8?B?REtKdklDd0EvQ3NpWFhiVXRadU1WamZXY0xBaW53YVRpckQ3UkEyYW9vTjJx?=
 =?utf-8?Q?/kSbUwMamQLqzFLGbyW0/bO1I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e3ffc9-ddaf-469e-aeb6-08db75f1c176
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 03:02:19.6037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jq+suK3iCSiWIGlPtgLlhc6Ut3+yAuzgjWQEVz/bY/RhhgSuu+usEk5ligKDKLAnun0S5IfOlN0+T2S0DnsMsUq5WV57JRylNuKopej4StA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4017
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdW5lIDI2LCAyMDIzIDEwOjUxIEFN
DQo+IFRvOiBBbmd1cyBDaGVuIDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4NCj4gQ2M6IG1z
dEByZWRoYXQuY29tOyB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsN
Cj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
XSB2ZHBhL3ZwX3ZkcGE6IENoZWNrIHF1ZXVlIG51bWJlciBvZiB2ZHBhIGRldmljZSBmcm9tDQo+
IGFkZF9jb25maWcNCj4gDQo+IE9uIE1vbiwgSnVuIDI2LCAyMDIzIGF0IDEwOjQy4oCvQU0gQW5n
dXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4N
Cj4gPiBIae+8jGphc29uLg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+
IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+ID4gPiBTZW50OiBNb25k
YXksIEp1bmUgMjYsIDIwMjMgMTA6MzAgQU0NCj4gPiA+IFRvOiBBbmd1cyBDaGVuIDxhbmd1cy5j
aGVuQGphZ3Vhcm1pY3JvLmNvbT4NCj4gPiA+IENjOiBtc3RAcmVkaGF0LmNvbTsgdmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSB2ZHBhL3ZwX3ZkcGE6
IENoZWNrIHF1ZXVlIG51bWJlciBvZiB2ZHBhIGRldmljZQ0KPiBmcm9tDQo+ID4gPiBhZGRfY29u
ZmlnDQo+ID4gPg0KPiA+ID4gT24gVGh1LCBKdW4gOCwgMjAyMyBhdCA1OjAy4oCvUE0gQW5ndXMg
Q2hlbg0KPiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+
ID4NCj4gPiA+ID4gV2hlbiBhZGQgdmlydGlvX3BjaSB2ZHBhIGRldmljZSxjaGVjayB0aGUgdnFz
IG51bWJlciBvZiBkZXZpY2UgY2FwDQo+ID4gPiA+IGFuZCBtYXhfdnFfcGFpcnMgZnJvbSBhZGRf
Y29uZmlnLg0KPiA+ID4gPiBTaW1wbHkgc3RhcnRpbmcgZnJvbSBmYWlsaW5nIGlmIHRoZSBwcm92
aXNpb25lZCAjcXAgaXMgbm90DQo+ID4gPiA+IGVxdWFsIHRvIHRoZSBvbmUgdGhhdCBoYXJkd2Fy
ZSBoYXMuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuZ3VzIENoZW4gPGFuZ3Vz
LmNoZW5AamFndWFybWljcm8uY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gdjE6IFVzZSBtYXhf
dnFzIGZyb20gYWRkX2NvbmZpZw0KPiA+ID4gPiB2MjogSnVzdCByZXR1cm4gZmFpbCBpZiBtYXhf
dnFzIGZyb20gYWRkX2NvbmZpZyBpcyBub3Qgc2FtZSBhcyBkZXZpY2UNCj4gPiA+ID4gICAgICAg
ICBjYXAuIFN1Z2dlc3RlZCBieSBqYXNvbi4NCj4gPiA+ID4NCj4gPiA+ID4gIGRyaXZlcnMvdmRw
YS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYyB8IDM1ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0NCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlv
bnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92aXJ0aW9f
cGNpL3ZwX3ZkcGEuYw0KPiA+ID4gYi9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMN
Cj4gPiA+ID4gaW5kZXggMjgxMjg3ZmFlODlmLi5jMWZiNjk2M2RhMTIgMTAwNjQ0DQo+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYw0KPiA+ID4gPiArKysgYi9k
cml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMNCj4gPiA+ID4gQEAgLTQ4MCwzMiArNDgw
LDM5IEBAIHN0YXRpYyBpbnQgdnBfdmRwYV9kZXZfYWRkKHN0cnVjdA0KPiA+ID4gdmRwYV9tZ210
X2RldiAqdl9tZGV2LCBjb25zdCBjaGFyICpuYW1lLA0KPiA+ID4gPiAgICAgICAgIHU2NCBkZXZp
Y2VfZmVhdHVyZXM7DQo+ID4gPiA+ICAgICAgICAgaW50IHJldCwgaTsNCj4gPiA+ID4NCj4gPiA+
ID4gLSAgICAgICB2cF92ZHBhID0gdmRwYV9hbGxvY19kZXZpY2Uoc3RydWN0IHZwX3ZkcGEsIHZk
cGEsDQo+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldiwgJnZw
X3ZkcGFfb3BzLCAxLCAxLA0KPiBuYW1lLA0KPiA+ID4gZmFsc2UpOw0KPiA+ID4gPiAtDQo+ID4g
PiA+IC0gICAgICAgaWYgKElTX0VSUih2cF92ZHBhKSkgew0KPiA+ID4gPiAtICAgICAgICAgICAg
ICAgZGV2X2VycihkZXYsICJ2cF92ZHBhOiBGYWlsZWQgdG8gYWxsb2NhdGUgdkRQQQ0KPiA+ID4g
c3RydWN0dXJlXG4iKTsNCj4gPiA+ID4gLSAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKHZw
X3ZkcGEpOw0KPiA+ID4gPiArICAgICAgIGlmIChhZGRfY29uZmlnLT5tYXNrICYNCj4gPiA+IEJJ
VF9VTEwoVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVApKSB7DQo+ID4gPiA+ICsgICAgICAg
ICAgICAgICBpZiAoYWRkX2NvbmZpZy0+bmV0Lm1heF92cV9wYWlycyAhPQ0KPiA+ID4gKHZfbWRl
di0+bWF4X3N1cHBvcnRlZF92cXMgLyAyKSkgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICJtYXggdnFzIDB4JXggc2hvdWxkDQo+IGJlDQo+ID4g
PiBlcXVhbCB0byAweCV4IHdoaWNoIGRldmljZSBoYXNcbiIsDQo+ID4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYWRkX2NvbmZpZy0+bmV0Lm1heF92cV9wYWlycyoyLA0KPiA+
ID4gdl9tZGV2LT5tYXhfc3VwcG9ydGVkX3Zxcyk7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ID4g
PiAgICAgICAgIH0NCj4gPiA+ID4NCj4gPiA+ID4gLSAgICAgICB2cF92ZHBhX21ndGRldi0+dnBf
dmRwYSA9IHZwX3ZkcGE7DQo+ID4gPiA+IC0NCj4gPiA+ID4gLSAgICAgICB2cF92ZHBhLT52ZHBh
LmRtYV9kZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ID4gPiAtICAgICAgIHZwX3ZkcGEtPnF1ZXVlcyA9
IHZwX21vZGVybl9nZXRfbnVtX3F1ZXVlcyhtZGV2KTsNCj4gPiA+ID4gLSAgICAgICB2cF92ZHBh
LT5tZGV2ID0gbWRldjsNCj4gPiA+ID4gLQ0KPiA+ID4gPiAgICAgICAgIGRldmljZV9mZWF0dXJl
cyA9IHZwX21vZGVybl9nZXRfZmVhdHVyZXMobWRldik7DQo+ID4gPiA+ICAgICAgICAgaWYgKGFk
ZF9jb25maWctPm1hc2sgJiBCSVRfVUxMKFZEUEFfQVRUUl9ERVZfRkVBVFVSRVMpKQ0KPiB7DQo+
ID4gPiA+ICAgICAgICAgICAgICAgICBpZiAoYWRkX2NvbmZpZy0+ZGV2aWNlX2ZlYXR1cmVzICYg
fmRldmljZV9mZWF0dXJlcykgew0KPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICByZXQg
PSAtRUlOVkFMOw0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2
LT5kZXYsICJUcnkgdG8gcHJvdmlzaW9uDQo+IGZlYXR1cmVzDQo+ID4gPiAiDQo+ID4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInRoYXQgYXJlIG5vdCBzdXBwb3J0ZWQgYnkg
dGhlDQo+IGRldmljZToNCj4gPiA+ICINCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAiZGV2aWNlX2ZlYXR1cmVzIDB4JWxseA0KPiBwcm92aXNpb25lZA0KPiA+ID4gMHgl
bGx4XG4iLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldmljZV9m
ZWF0dXJlcywNCj4gPiA+IGFkZF9jb25maWctPmRldmljZV9mZWF0dXJlcyk7DQo+ID4gPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyOw0KPiA+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiA+ID4gICAgICAgICAgICAgICAgIH0NCj4gPiA+
ID4gICAgICAgICAgICAgICAgIGRldmljZV9mZWF0dXJlcyA9IGFkZF9jb25maWctPmRldmljZV9m
ZWF0dXJlczsNCj4gPiA+ID4gICAgICAgICB9DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICB2
cF92ZHBhID0gdmRwYV9hbGxvY19kZXZpY2Uoc3RydWN0IHZwX3ZkcGEsIHZkcGEsDQo+ID4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldiwgJnZwX3ZkcGFfb3BzLCAx
LCAxLA0KPiBuYW1lLA0KPiA+ID4gZmFsc2UpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAg
aWYgKElTX0VSUih2cF92ZHBhKSkgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgZGV2X2Vycihk
ZXYsICJ2cF92ZHBhOiBGYWlsZWQgdG8gYWxsb2NhdGUgdkRQQQ0KPiA+ID4gc3RydWN0dXJlXG4i
KTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKHZwX3ZkcGEpOw0KPiA+
ID4gPiArICAgICAgIH0NCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIHZwX3ZkcGFfbWd0ZGV2
LT52cF92ZHBhID0gdnBfdmRwYTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIHZwX3ZkcGEt
PnZkcGEuZG1hX2RldiA9ICZwZGV2LT5kZXY7DQo+ID4gPiA+ICsgICAgICAgdnBfdmRwYS0+cXVl
dWVzID0gdl9tZGV2LT5tYXhfc3VwcG9ydGVkX3ZxczsNCj4gPiA+DQo+ID4gPiBXaHkgYm90aGVy
IHdpdGggdGhvc2UgY2hhbmdlcz8NCj4gPiA+DQo+ID4gPiAgICAgICAgIG1ndGRldi0+bWF4X3N1
cHBvcnRlZF92cXMgPQ0KPiB2cF9tb2Rlcm5fZ2V0X251bV9xdWV1ZXMobWRldik7DQo+ID4gbWF4
X3N1cHBvcnRlZF92cXMgd2lsbCBub3QgYmUgY2hhbmdlZCwgc28gd2UgY2FuIGdldCBtYXhfc3Vw
cG9ydGVkX3Zxcw0KPiBmcm9tIG1ndGRldi0+bWF4X3N1cHBvcnRlZF92cXMuDQo+ID4gSWYgd2Ug
dXNlIHZwX21vZGVybl9nZXRfbnVtX3F1ZXVlcyhtZGV2KSxpdCB3aWxsIHVzZSB0bHAgdG8gY29t
bXVuaWNhdGUNCj4gd2l0aCBkZXZpY2UuDQo+ID4gSXQganVzdCByZWR1Y2Ugc29tZSB0bHAgLg0K
PiANCj4gT2ssIGJ1dA0KPiANCj4gMSkgSSB0aGluayB3ZSBkb24ndCBjYXJlIHRoZSBwZXJmb3Jt
YW5jZSBoZXJlDQo+IDIpIElmIHdlIGRpZCwgbGV0J3MgdXNlIGEgc2VwYXJhdGUgcGF0Y2ggdG8g
ZG8gdGhhdCBhcyBhbiBvcHRpbWl6YXRpb24NCj4gDQpUaGFuayB5b3UuQXMgbXN0IGRpZCBub3Qg
c3VwcG9ydCB0aGlzIHBhdGNoIHNvbWUgZGF5cyBhZ28sc28gdGhpcyBwYXRjaCB3aWxsIGJlIGRy
b3BwZWQuDQpJIHBsYW4gdG8gcHVzaCBhIGRlcGVuZGVudCBkcml2ZXIgb2Ygb3VyIHByb2R1Y3Qg
cmF0aGVyIHRoYW4gcmV1c2UgdnBfdmRwYS4NCkJ5IHRoZSB3YXkgLGlmIEkgd2FudCB0byBhZGQg
c3Jpb3Ygc3VwcG9ydCBpbiBvdXIgdmRwYSBwY2kgZHJpdmVyLHdvdWxkIGl0IGJlIGFjY2VwdGVk
IG9yIG5vdD8NCj4gVGhhbmtzDQo+IA0KPiA+ID4NCj4gPiA+IFRoYW5rcw0KPiA+ID4NCj4gPiA+
DQo+ID4gPiA+ICsgICAgICAgdnBfdmRwYS0+bWRldiA9IG1kZXY7DQo+ID4gPiA+ICAgICAgICAg
dnBfdmRwYS0+ZGV2aWNlX2ZlYXR1cmVzID0gZGV2aWNlX2ZlYXR1cmVzOw0KPiA+ID4gPg0KPiA+
ID4gPiAgICAgICAgIHJldCA9IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldChkZXYsDQo+IHZwX3Zk
cGFfZnJlZV9pcnFfdmVjdG9ycywNCj4gPiA+IHBkZXYpOw0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAy
LjI1LjENCj4gPiA+ID4NCj4gPg0KDQo=
