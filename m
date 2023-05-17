Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DD7705FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjEQF7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjEQF6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:58:54 -0400
Received: from DM4PR02CU001.outbound.protection.outlook.com (mail-centralusazon11012002.outbound.protection.outlook.com [52.101.63.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7594ECE
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 22:58:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImN2uALCoOoE7licLFuMa6P5wj1IpaZvR9flotoblGntJKlH79xeB4vPNy90H+xkLhym4bFTFrfjEgjbac0Ujhju2nEr54XZ9NlKGSlch+/ri/oF9H72HlhV0ssCMlAFSoKMWAq4w8NU6vVEkY0hfT2CP4ptY1eXSGp+dHb9UMzjHEECt1AvTZ6DgFmJEXUn/4i32QxlktlEa09E35exkbbdU8kev+ZSt4QzolEmkC0Mdzwxpde31nP2XE52hgLVj5K4QmrjHqKoCV0IV9bSJPf+N2XpGj71N10VYk2fg8pQqpq1BQcNmr/DHyYE/7zHMSacTdxUxzDJ0+DxEx7XAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIspJMS5sPtrPXOq4oAMsUUtD09j4h3XRxWzVtP790w=;
 b=dv3Js7vOAg3p1E/onlGxOazPL1IuaiOx/9w8hlpNs4iFIyvaabg9BLss+blkmkTbBYKj9Vv13kOXw59q057PAPxoEXQByHhlwgF/fH91WiG8B15NpLqV2SI06cgifS2tB1Tyay6QmplwMb4xp/grFZ8WyXC0b/QbTvyeYY23Al6Tt78KwjQcZmilXCdOnWg+x0yT+zzLLfjlBKFSAWQGhZo0iHSD7HJRaCzQAys/ddf2yA6++LviSgy9Ia1ldnzhoi/Q3EZLyeCFYNHfvTOQ7g9+570bvsIX/PYffwKnBqIY7SuPjw5kwRg06P+oniOFo9H9H7wIHPjqkqCodQfvKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIspJMS5sPtrPXOq4oAMsUUtD09j4h3XRxWzVtP790w=;
 b=vdIaoW3v6S0YPpY9v+yuwsT6ozbxoPXYW181Q4Pn43A/KDzyLxTI/XHPkcEJIMkmzOq5i4KjX/yafxojN8tXJqv/ZHpmdgPHriUpnbb67Y1iZRtSy1IfsEPGgQaD8gdQSSwPWx9FIDIqx+QCRH6M23TxWazs03zsMWCe5OxuB84=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BY3PR05MB8417.namprd05.prod.outlook.com (2603:10b6:a03:3c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 05:58:43 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f1bc:4933:8701:7ff0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f1bc:4933:8701:7ff0%7]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 05:58:43 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Jon Pan-Doh <pandoh@google.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudheer Dantuluri <dantuluris@google.com>,
        Gary Zibrat <gzibrat@google.com>
Subject: Re: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
Thread-Topic: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
Thread-Index: AQHZeH5MzL7QCyjHEUuk1s9n/e4s+69eFaGAgAACmgA=
Date:   Wed, 17 May 2023 05:58:43 +0000
Message-ID: <71A3F44C-B684-4946-AF11-3DB98E3AC641@vmware.com>
References: <20230426203256.237116-1-pandoh@google.com>
 <CAMC_AXUkiHvBaWQm8fnAbgbxe59iF9UM59=yBoa3LcuLGQ=E3A@mail.gmail.com>
In-Reply-To: <CAMC_AXUkiHvBaWQm8fnAbgbxe59iF9UM59=yBoa3LcuLGQ=E3A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|BY3PR05MB8417:EE_
x-ms-office365-filtering-correlation-id: 1935178c-6dfe-49f7-ce36-08db569bc55e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b2FP8ZgFkpHoz00wvwE15KJLrSrhzZPM1gf+hwC2QZxZK9AsZoYvxRYZ9NlZJ11NDOTnhrPpjX1PZkN4dLSk2gF/0PV9Oc8UQsFj4BxFJr6qPFLh1IDACqnL7gbFsRfxYRC3GGRZMR8j6zgWAYqNpla+mhSMSJoZBq7yDtL+gprJXywU69XrAPACn/UG0u81lMOUP7YFbEwpkSy3VoZVGAKhirhrSVhEEUzz60OwX5zC1Ul4izj07tzwmCUIHyrH32rWHicuOOq/U/lIg7WZcA587ohL8b9A+xd+ccK0EHO+fOhx6vKuLPRuPDE4YmOhu8vTm1IBRB30K6856PkA279Tj6Agv2SUjNuMV6Z+H3ouZcWjHXLOlSucCNVK4dwDO3c/0rDgLkNYN7CkcV6SSUopXWqUtDbLdlOFUBvdU+i7njZs9S9I0iDi8oKUpOIeBpN8V7DgwB4L24NZtn/ghEeYVaabFPJ4DIszEOrlMb22+x6XKaW2ho8NIDvdvP/2hnY88KBC5n668tXLBfwURksaLszapOzZGKmR+bpAb7RgsVGYJmNMH5oswshXlv1SQ6g9Q5aSySI8nQ3AedYAcOYQ8qUm44BjH8NKfsseKrAFqPy+gEKZTwuhZVI4Tys3CuGYyu7dRaf5+TK4CUaNcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(53546011)(6506007)(26005)(6512007)(83380400001)(36756003)(38100700002)(2616005)(122000001)(86362001)(33656002)(38070700005)(186003)(2906002)(76116006)(8676002)(64756008)(66556008)(66446008)(6916009)(54906003)(4326008)(478600001)(8936002)(5660300002)(66476007)(41300700001)(71200400001)(66899021)(6486002)(316002)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVpOdG90enhvTFhrdmV5US9PeXJVY25YTU5TMlRhZExhL045ZVJiYUpxTitZ?=
 =?utf-8?B?b0tmM1pkSHlob1ZxNUo0QmtLdHIwVm5rVXJCZzJUUnh6TFU2eFFBZGNUMEtU?=
 =?utf-8?B?WGdkR2lyd1NyQ2cyMTFWcXZTYWRwOUpSM1BpT2tETmhHTFdJVkFMS3IyL0pC?=
 =?utf-8?B?VGdzb1RWZ0w1Q05heGdQL2RKbEpwMDdEVGZYbnZhQndDZ1VvSVBCUDFzcDFC?=
 =?utf-8?B?NkR4WGl1YTdMYkQvSXZnQ3daVUtObVNRb1NyU2xmdHl2Tmh5TG5VaFNKc3pN?=
 =?utf-8?B?Z3JYcjk4TnlUZHN6dExVcVZyV09mNWg3RXVhNnRlZERkRGtrbzBQSEYveC9M?=
 =?utf-8?B?SnUva2JkSWZpaWRxNGw3U1dsakt6L2dDNkVTczJ2K0o2ZUlhc0pOOS83dE56?=
 =?utf-8?B?aXZkK3M0YnpzSVp1K29CUWlIWGVKNGIwczVYNkIxTDlZSGxtUExWcWxPM2dC?=
 =?utf-8?B?bGpSK2VFMTkwQ0ViMlVsSzlueVFzYTJQMlFSem42MFg2OXZ5YWN3ZEFIeXFH?=
 =?utf-8?B?WHFlZ0drREFkR1l5dTByb3VtSWZyY05rd1hjUmV4MWc2bXp2WHdDcjlNUDky?=
 =?utf-8?B?YXJBWUZldXdoS1dBZXBzbFNaNVQ4eVIrNUVHWkZpajMzSXVHdnNwUlR5aGRV?=
 =?utf-8?B?Mk1SeWI4a2htM2wvVGIzNmF5N09oSFN3Skl6NWt4MmhqS05XVGYwWXdGK2M5?=
 =?utf-8?B?VUZ4RFJUb2tHWFlmZDJucVJERjlWMUx4WjNCTmpuTU8rODNsbEpXN3NOTHpi?=
 =?utf-8?B?Wk5lVFF4S3pZMzZHOGJSMDVaTUI2cDlmSTAvZ0pNOXg2ZzRkYWxvYWtuTlo0?=
 =?utf-8?B?eVBWM0JGbFBST3JFanJSRGU2cWNvdXgySTI5RnFvSEVkWURFcnRQMTNwb0xL?=
 =?utf-8?B?U2V6a2c4enQ2UGNPdEtRZVNhWmFyL1Ayc0R2QnRzQ21ZdFZ0TVJXK1pUY0lJ?=
 =?utf-8?B?TWFVbjRZSDRxVlNOTWdYRXBPR1NGc0NjMlY1TlltN2ltVlFRbWFLM1I0YUFr?=
 =?utf-8?B?ek1HcTZZWTR2NU9SeFJ5S2g3QzgxUGJxQnBzT0VKVmw0cXNUUGpEWlFJQWdx?=
 =?utf-8?B?UGZScnlRcmEvZXZLOVgyczNMRHhnbCtyenRDUVBxY3JIWVFnTTZnenpOTW1q?=
 =?utf-8?B?bjd6dm9pZXZRM3pJbFZUcS9VMXJFakFVMWZhZTNUbksxbmdJbExDaUR4VGZt?=
 =?utf-8?B?enN3b1ZJM3pRVHRFaGZjcnVOY2VXeHRoOURRc3ZVZVZ1bkxnd0VHVFNRSlNR?=
 =?utf-8?B?NEI1UDZiSTVxNHJMYi92cTBCM25LcmcwT2E4cjVkT0pwcHpCR1N2SEVDcUkr?=
 =?utf-8?B?THkyblh4R2JTNldNNGM4NXp6OUFhVkJKS2hIZkxWMDcrcnBGSlluYVF1L0hN?=
 =?utf-8?B?Y1AzengvU2pNb093ZzhVMjdJYkVCbVlyMzRiM1VMT1V4Uk1YRXVRSUJ3c0xG?=
 =?utf-8?B?Y3hGMnZyL05UYzVJbksxc1B0cEhBZjRlU0dJNHArbzNqWWFPQmowa045d0Ex?=
 =?utf-8?B?aER1KzRXSkI1TENnSGFlOXFOc0xYYjcxalFWa1RCdFAzT1BCc3Q1Wkk0Nmt1?=
 =?utf-8?B?UCtMKytrcjhoZUxGQ1hwRm9la1NUNytlcVhzc01NV08vSGRlTTBabEcreXFH?=
 =?utf-8?B?Yk9sbkVFY3hTTDJXY1BBZ09RSlFTRlJCbDZUamNvWUVWSmh3K2VTdENKYUZx?=
 =?utf-8?B?V2hXT014SEhQL05OUGJLTnNLTG1IUElQNzBuUnBIdVdHNU9VMkpueWptVWFE?=
 =?utf-8?B?YnprNExMM3BCeUZPaUI3S0xMMUpNTVQzcmpsTDV5VlZhYkRvUmxIMUhxbERN?=
 =?utf-8?B?MzV4QVBnNUoxTHFMK3VzUEJmeTh0bVovODlWN0JGbTdEYTYyQXFkWlRYUWY3?=
 =?utf-8?B?ZSswb3lUL1c3M2Yxb3AzVk1PTTVhNHBiVEEzMHF1SkFKczlIaFRrWTV6bUF3?=
 =?utf-8?B?UldiTmZnN09acU1aUmdHcnN1RjdORW9wcGdDUzd1YzBqQysyNjhic2plVUp6?=
 =?utf-8?B?TitBRm1CSmJZSHJWb1ZPekI5ZzJmb2NRdGlkbkkvVXlHd0Q0eGtVU1NaV0Jv?=
 =?utf-8?B?Qnltazh1UG9ZQWNMN1ZoQ2NUK3dNSXp0U25JSFRlaE9Ld3N4Q2tKVkdhMElK?=
 =?utf-8?Q?dGs/vAYSNoptQIAddLbs7WLQN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09E2286A0DB5504BB1C19E1B8922254D@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1935178c-6dfe-49f7-ce36-08db569bc55e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 05:58:43.3894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcNEDybD3rT6qaDqvgmgY3cdhxWa10ZxcbTvH2Xb4XUFrk8DiiiljAAz2XU1j5YrvG87C85vGr/F+H9n8ItA0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8417
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE1heSAxNiwgMjAyMywgYXQgMTA6NDkgUE0sIEpvbiBQYW4tRG9oIDxwYW5kb2hAZ29v
Z2xlLmNvbT4gd3JvdGU6DQo+IA0KPiAhISBFeHRlcm5hbCBFbWFpbA0KPiANCj4gT24gV2VkLCBB
cHIgMjYsIDIwMjMgYXQgMTozMuKAr1BNIEpvbiBQYW4tRG9oIDxwYW5kb2hAZ29vZ2xlLmNvbT4g
d3JvdGU6DQo+PiANCj4+IFdoZW4gcnVubmluZyBvbiBhbiBBTUQgdklPTU1VLCB3ZSBvYnNlcnZl
ZCBtdWx0aXBsZSBpbnZhbGlkYXRpb25zIChvZg0KPj4gZGVjcmVhc2luZyBwb3dlciBvZiAyIGFs
aWduZWQgc2l6ZXMpIHdoZW4gdW5tYXBwaW5nIGEgc2luZ2xlIHBhZ2UuDQo+PiANCj4+IERvbWFp
biBmbHVzaCB0YWtlcyBnYXRoZXIgYm91bmRzIChlbmQtc3RhcnQpIGFzIHNpemUgcGFyYW0uIEhv
d2V2ZXIsDQo+PiBnYXRoZXItPmVuZCBpcyBkZWZpbmVkIGFzIHRoZSBsYXN0IGluY2x1c2l2ZSBh
ZGRyZXNzIChzdGFydCArIHNpemUgLSAxKS4NCj4+IFRoaXMgbGVhZHMgdG8gYW4gb2ZmIGJ5IDEg
ZXJyb3IuDQo+PiANCj4+IFdpdGggdGhpcyBwYXRjaCwgdmVyaWZpZWQgdGhhdCAxIGludmFsaWRh
dGlvbiBvY2N1cnMgd2hlbiB1bm1hcHBpbmcgYQ0KPj4gc2luZ2xlIHBhZ2UuDQo+PiANCj4+IEZp
eGVzOiBhMjcwYmUxYjNmZGYgKCJpb21tdS9hbWQ6IFVzZSBvbmx5IG5hdHVyYWwgYWxpZ25lZCBm
bHVzaGVzIGluIGEgVk0iKQ0KPj4gU2lnbmVkLW9mZi1ieTogSm9uIFBhbi1Eb2ggPHBhbmRvaEBn
b29nbGUuY29tPg0KPj4gVGVzdGVkLWJ5OiBTdWRoZWVyIERhbnR1bHVyaSA8ZGFudHVsdXJpc0Bn
b29nbGUuY29tPg0KPj4gU3VnZ2VzdGVkLWJ5OiBHYXJ5IFppYnJhdCA8Z3ppYnJhdEBnb29nbGUu
Y29tPg0KPiANCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCg0KQXNzdW1pbmcgdGhlIHBh
dGNoIHdhcyBzdGlsbCBub3QgYXBwbGllZCwgSSB0aGluayB0aGF0IEdyZWcgS0ggd291bGQNCnBy
ZWZlciB0aGF0IHlvdSBzZW5kIHYyIHRoYXQgaW5jbHVkZXMgdGhlIOKAnENjOiA8c3RhYmxlQHZn
ZXIua2VybmVsLm9yZz7igJ0NCihub3RpY2UgdGhlIOKAnDzigJwgYW5kIOKAnD4iIHNpZ25zKSBh
bmQgaWRlYWxseSB0aGUgdmVyc2lvbiBpbiB3aGljaCBJIGFkZGVkDQp0aGUgYnVnZ3kgY29kZSAo
c29ycnkgZm9yIHRoYXQgYWdhaW4pIGFmdGVyIGEg4oCcI+KAnSBzaWduLg0KDQpJIHRoaW5rIGl0
IGlzIHZlcnNpb24gNS4xNS4NCg0KSU9XOiBJZiB0aGUgcGF0Y2ggd2FzIHN0aWxsIG5vdCBhcHBs
aWVkIGJ5IEpvZXJnLCBwbGVhc2Ugc2VuZCB2MiB3aXRoOg0KDQpDYzogPHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcgPG1haWx0bzpzdGFibGVAdmdlci5rZXJuZWwub3JnPj4gIyA1LjE1LngNCg0KSW4g
dGhlIGNvbW1pdCBsb2cuDQoNCg==
