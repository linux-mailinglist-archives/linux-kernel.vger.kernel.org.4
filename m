Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D78F64F8A9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 11:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiLQKNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 05:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiLQKNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 05:13:39 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2077.outbound.protection.outlook.com [40.107.9.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A3B1B1E0;
        Sat, 17 Dec 2022 02:13:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVbclVMXAuMBybNsu/CGJBya4N4TAHEvHDxgahRvP6qg0bCDtj6lHnIvgqq1G5SB2Y8BXh8ua7/Fd4FNZ42CD6Ugbt3CUml7FzHGQCqMJ+xYJj7mfO1I6R25wxH4+1JWXAER2LOrV4U+OjBMx5Sd4pdCtI4mWTrZwGWA5+/vDOKr3CUato+ktArMVJmxLDFP8/kSDpzBXPPoXpCMAHl+2pOnf//UZesdzoWAyXoUjoHqO8AhBRvLpxvcCM5a5aBOesey7tWY6P9v0NWNzbjwfsi9tzUTTP3ZbsTnJdf+xIhxCj8wHK1tCldS1pd+NpnEeBfUu57Rcx1OJP/4MdQ2og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTLbSHf18ppitbxDzR6oxPV70jp9xn4ZiqHlHJ/bnoA=;
 b=JETCxdzijplTNbOv514dNPUCEeolu+pQ3o1CI1kXE+QV2USnpLuDHWeebu+XGpmeSErTpjgNAQk9Dmr0NoLuRxLIeQZEVfEfsiIUc5dJO8M5rwGHrrDUYrtvvyMC6wi8B55W6KrWQY/YIa0ZN4b6AUxkQ4lASfzroGUjFx09dowI5IkUiSWTPlKUcjQ73OLc04McxQPsWBcvri2dLj5JFrTHt/eoJB5ZM3ifT5uvnXQeRa2FN4w4DERtAt8PS9bx5jYbqFsrTUa4QjhT6WrW/PBQFVkwffNi9L/W3cfKYcXqHanLnMSr2bxWb+DhGWaAabI7KOaPBJeulHYwr2oebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTLbSHf18ppitbxDzR6oxPV70jp9xn4ZiqHlHJ/bnoA=;
 b=ooykA6DTb4PIKuR5XNelbLPKJaePhxz0hdScLwERV4jcY96Rdl+32tw4v7xBK/qjkIhKyWqH2H/LXJ33uJLMj6ba8yyqp3kwV+RVileBIWsL3LB6dgzGWuhuoSuyUMTpxDUzjtFm8+bmKDi3iheX3blTo3nPn/q64W2FzyX8crlQCtDwldlCz0ApKM9yePLlR/+gKxDCZq59eQOEeBjxSRfdkL8uqBgNtNdxFStYa5v+u2pwMjRRE2Xi9N/mfYhQ0sCu1Lh8OXesUFsmdb5FFcPitkXYPVo102rXGpIDPWWFEL8kG6th9sGHYs+Q2wl3LEd9rIFmfTEpyv0ijEXCPg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB2264.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Sat, 17 Dec
 2022 10:13:35 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8e8b:856e:12eb:ff9d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8e8b:856e:12eb:ff9d%9]) with mapi id 15.20.5924.016; Sat, 17 Dec 2022
 10:13:35 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Allen Webb <allenwebb@google.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v7 4/5] file2alias.c: Implement builtin.alias generation
Thread-Topic: [PATCH v7 4/5] file2alias.c: Implement builtin.alias generation
Thread-Index: AQHZEZw85fXC7shNXEybRvDTQR+Lta5x3TmA
Date:   Sat, 17 Dec 2022 10:13:35 +0000
Message-ID: <2c8c3839-f4cf-dc28-3865-99dabdf4b87d@csgroup.eu>
References: <Y5IA2NYE5IaAzNby@kroah.com>
 <20221216221703.294683-1-allenwebb@google.com>
 <20221216221703.294683-5-allenwebb@google.com>
In-Reply-To: <20221216221703.294683-5-allenwebb@google.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB2264:EE_
x-ms-office365-filtering-correlation-id: 53fcc2f6-8ba1-437c-97cf-08dae0175bb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: atkZ0autppLyhiBTw0WPPsD56Y4n0z+tEnYKgsHnKFAd8S/PeC5jBIGJl5SoBrC7Y5wQmE9Y39CoCIyECQfUq94/3sJS8XkGItBT4FQq7DgLY3BoTj4NaQPvJFH1Eopz2vjnEDVOClymg39BG4vo35Gi/YGa555jxzPoLlUqqNWt8D6RsJSH6/TSeZq19TBElbM+roo4s5LT9WGsv9FAdKrnwr0aU7E3gTaCeo8UduyIyvsMdgFY0tBN+GaoKzt7F8Nq6iwMDIRcyhmP6857L7FX2wHNjWlwUhOCdD7SSOESAepZ5flwzfAYaHnPFY6kmMjf0x+Djs7hEcXq7mZe7Md4dLvHDNKoFhaquzIJitbRDJCG5SluLKyfnhi/CSBlv7UqlbWPUucUWGBiBqL7u+Ghzg8iu/BMKOkr6fgtnia1TpjJFW8TstbdIZGwQZjR9pR9XBfRpX08/D4GTCriU+ATMua0Vd3egesKgavbGclsqziRV8PQAFdsAiBE5n7eMmRtAlfYSHpDmdjjpKvNKLnPKgOdLTpSkwyCKp1NgVYg+fYrngKpHMNsdmuXfl02bjIMHtWlkZwp+7hrESgxlkXHbAtSaHxWuPBIiqKoxkq+TE6t/mtqhGrR/lo2/e668+IKtnZvRMUeY0jP0/FcIILT5WfQvFDADyYSmi6qs7jPRMfEKYbx5l38oO8FfmY2mZ1CrjJXAnDTS73+Ac7fhS2stPsRXxc+rMMLnuixp/gvst1forgK0akbNT5zOW9y5tNCoK2/nPZsi773aRs4zQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(39850400004)(346002)(136003)(451199015)(83380400001)(31686004)(2616005)(86362001)(31696002)(316002)(478600001)(54906003)(110136005)(36756003)(38070700005)(186003)(26005)(6506007)(38100700002)(122000001)(6512007)(44832011)(6486002)(2906002)(71200400001)(5660300002)(41300700001)(8936002)(64756008)(91956017)(4326008)(66446008)(66476007)(66556008)(8676002)(76116006)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFdBZlMrRmZtR2xTK3Q3MjV1M2xKYkFQVnU5TjVuajRHRVNpbkRUbWdjTW9E?=
 =?utf-8?B?L0FqZ1RUSWZXR1RRdHYyRWkyYVp6aVRYS2pRSzBURVlEWi9VbWcvR2RzWWFZ?=
 =?utf-8?B?UHNOaXhzdk5pWk1hdEdKdTZzZ2dVN1F5RHNFbjY2c2FldFdtZ1lHTXlpYTBl?=
 =?utf-8?B?ZW15eXZXY0Y4eFhma1ZBV1dZbzNEZHBQWnVYbU1YZHJvRTV1U2IrVDlHR3Mx?=
 =?utf-8?B?SC9xTVB1a0xNM2ZQaFkva1I4dFZ6c3FwMkowRlBiSmp4aURCV2RBTFl0Y2hs?=
 =?utf-8?B?c2FudTFYL2tab05EaUUySUlXRFZNcmFab2lETFo3cDN3N0ZmZHNHNlVENW9a?=
 =?utf-8?B?M1FkWjl5Wi9QNTVCZy9mRDdORXZIVXYzaEYrQzVsUVlENGtHdHdISnBoQWtD?=
 =?utf-8?B?UFhNV3ZyYnVld3h1ckVvR2NMTlZtOUltUVBEWmI1R2orVXo3cEtpQTRBZDFp?=
 =?utf-8?B?ZG9qVXVXM0g0SUtWYkRVYkJvSERONEM4MlZVdVQ1YTFNenJudnQ0bjJuR1Aw?=
 =?utf-8?B?TWx0cG1reFo1U2h1VWxVdUoxRk85SVI5bWNmbTVsaHQxd1Vxb2lrQUtaTHg5?=
 =?utf-8?B?cis2dXlUekxXcyswRW15amUxTk50UThqWmFFdHEyM1piMklDVEE1RTZYQ01v?=
 =?utf-8?B?TUZkZzRTTDRjTlowNnJJclVyMzluV2N5ZFU5V2tBUkZudzl5ejhlQmdqMkk3?=
 =?utf-8?B?dnJjTkg1NEpXc2gzQ3hrRnNUTFNIVFIvY3pSbXQxYXI4aGpwUUVyV1hhald5?=
 =?utf-8?B?aS9TOTFYV1owNi9RdUtTbjdncytNZFRTTXVieUhKN1l3V0d4cVpQeU9WdW9q?=
 =?utf-8?B?RWVwb0FNMmhFNi9CR0F6ajdORFhBZDdWSmJTVDJqZy9GUlduMVRXbG1WTGp6?=
 =?utf-8?B?RTAxR3MwMmxPZmY0VzhUaDNva2hqR25KV0tFZGk4bks3UGNObmg4dlF5UTZV?=
 =?utf-8?B?QmJPamxLUFlnRjRENmNsa2Y4UmJTUFlOSkovUENJU1VHWVdjcEJ5a0JtSWhK?=
 =?utf-8?B?Smw4cm96bUl2d2VSMGNZSlErZGFleThzT2ZsVlkwQWFtQUNuQmdQU2FyRk9n?=
 =?utf-8?B?QlplbjQ5KzJWTElFbkhKWm52V2dVUElFZW40Nlhtd21oQ1FSZkJxZFBhUmJ0?=
 =?utf-8?B?emdoWVh0OUJDSHRjTDhLK1ZkQlAxd1NuVkxBdmp4TWtobXQvUEVmQXdQWTA1?=
 =?utf-8?B?cUpka3JrZmFXKzJyalVoQVpIWElua1E4djNPSlREc3R4VmlHTDcyWGdhYm5v?=
 =?utf-8?B?NVhSYWEzZFdwQ2RMVXgxeFR6Sm1RdVlIZkpOYURoQlNpalhPYXljendueURl?=
 =?utf-8?B?V0h3ZXBTbk1vWHlYZTlnNHVwTFgxZEp6UnNNTGhMbmQ4U251V0lzZ2l4QzdH?=
 =?utf-8?B?OXZEUjFLdXBkaWRidVZMQlZ5RVJ4bU00MEVwWGpKZjJIN1RRWnExbVB2amlT?=
 =?utf-8?B?WUcrc0FObHJ2aGZWT05xY1Zid01uYzMyNnN3Nnh6ejU5TzNwNDJOdVBxNzU5?=
 =?utf-8?B?RmlOSEFNNW9BU0x6NTRTa2R0Ym85UGoxdUFabkVtanpUR3JDckxGNzNrQVpi?=
 =?utf-8?B?NFRUQmVUZS9lME40NlM3Wm95UEhtbzRCTFd2dHdQVDRtWjE3Tk1TWUNsQWZI?=
 =?utf-8?B?MG55ME5NcElVemliZnRweEhBKy8rK3VHZlNUM0ZzQXNiVXEvbzBiV0RhZmNs?=
 =?utf-8?B?Ym45ME9qbmJBelRxV0RaUDB0M2grOHBjb0hGbWJxeThLYnF2djZrcW50MXY5?=
 =?utf-8?B?blZWdWJKa1REL2h5TklYajJjK0ZOM25paS90dy9ZTGpoNTNub2MvbnMrMytu?=
 =?utf-8?B?dFFLeFhvaXNVajhkMS8vUExDV09ERzdDR1hXTysvMlRUT0thcHN0OUZUVmpB?=
 =?utf-8?B?MnZ2WHVDZjhmQU5lOEtHLzBVVG96blA5N0xMV1Q4eTdwOFV3UWI5bFJNMVlJ?=
 =?utf-8?B?ajZHalFWNG5SdmE4b202K3loSjBhWEhzc0dxcStXRFB4eklud2VkdlJSNE5O?=
 =?utf-8?B?NzRFS3JGRk9XWXV3azRlblhDOCtnNDV2ekplZDkweHFXZGowYmV3b0ZsdEJK?=
 =?utf-8?B?Vk1Rb2EyVTVaNis2RVBVRlIzS1RwUlVFSmVjdFgrVllsN1dQY29IUGZjbVox?=
 =?utf-8?B?MWxqdGxYUzN6eGRNU1ZjdEpqajVkRmFsa0wvNVFNeHVyRHNzNWVaMXFEa0JC?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A1E99CC6D5F6B41A0C3BBB08C7D3B33@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fcc2f6-8ba1-437c-97cf-08dae0175bb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2022 10:13:35.3949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ahwAbvEKblVJYK4/xxhMjfuV62EHVthD72h14KG8rCRf4qqNVni0kNUbeAJ8bEOA1JVydlx/q3cdXqYDbihJroZHJ2BF1MDYO0JwEBV5NvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2264
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDE2LzEyLzIwMjIgw6AgMjM6MTcsIEFsbGVuIFdlYmIgYSDDqWNyaXTCoDoNCj4gVGhp
cyBwb3B1bGF0ZXMgdGhlIG1vZC0+bW9kYWxpYXNfYnVmIHdpdGggYWxpYXNlcyBmb3IgYnVpbHQt
aW4gbW9kdWxlcw0KPiB3aGVuIG1vZHBvc3QgaXMgcnVuIGFnYWluc3Qgdm1saW51ei5vLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQWxsZW4gV2ViYiA8YWxsZW53ZWJiQGdvb2dsZS5jb20+DQo+IC0t
LQ0KPiAgIHNjcmlwdHMvbW9kL2ZpbGUyYWxpYXMuYyB8IDU1ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygr
KSwgMTcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9tb2QvZmlsZTJh
bGlhcy5jIGIvc2NyaXB0cy9tb2QvZmlsZTJhbGlhcy5jDQo+IGluZGV4IDQ1OGU0MWFlMGY1ZjEu
LjhlZDA4MTU0YjNkODEgMTAwNjQ0DQo+IC0tLSBhL3NjcmlwdHMvbW9kL2ZpbGUyYWxpYXMuYw0K
PiArKysgYi9zY3JpcHRzL21vZC9maWxlMmFsaWFzLmMNCj4gQEAgLTIzMiw2ICsyMzIsOCBAQCBz
dGF0aWMgdm9pZCBkb191c2JfZW50cnkodm9pZCAqc3ltdmFsLA0KPiAgIAlhZGRfd2lsZGNhcmQo
YWxpYXMpOw0KPiAgIAlidWZfcHJpbnRmKCZtb2QtPmRldl90YWJsZV9idWYsDQo+ICAgCQkgICAi
TU9EVUxFX0FMSUFTKFwiJXNcIik7XG4iLCBhbGlhcyk7DQo+ICsJaWYgKG1vZC0+YnVpbHRpbl9u
YW1lKQ0KPiArCQlidWZfcHJpbnRmKCZtb2QtPm1vZGFsaWFzX2J1ZiwgImFsaWFzICVzICVzXG4i
LCBhbGlhcywgbW9kLT5idWlsdGluX25hbWUpOw0KPiAgIH0NCj4gICANCj4gICAvKiBIYW5kbGVz
IGluY3JlbWVudC9kZWNyZW1lbnQgb2YgQkNEIGZvcm1hdHRlZCBpbnRlZ2VycyAqLw0KPiBAQCAt
Mzc2LDkgKzM3OCwxMyBAQCBzdGF0aWMgdm9pZCBkb19vZl9lbnRyeV9tdWx0aSh2b2lkICpzeW12
YWwsIHN0cnVjdCBtb2R1bGUgKm1vZCkNCj4gICAJCQkqdG1wID0gJ18nOw0KPiAgIA0KPiAgIAli
dWZfcHJpbnRmKCZtb2QtPmRldl90YWJsZV9idWYsICJNT0RVTEVfQUxJQVMoXCIlc1wiKTtcbiIs
IGFsaWFzKTsNCj4gKwlpZiAobW9kLT5idWlsdGluX25hbWUpDQo+ICsJCWJ1Zl9wcmludGYoJm1v
ZC0+bW9kYWxpYXNfYnVmLCAiYWxpYXMgJXMgJXNcbiIsIGFsaWFzLCBtb2QtPmJ1aWx0aW5fbmFt
ZSk7DQo+ICAgCXN0cmNhdChhbGlhcywgIkMiKTsNCj4gICAJYWRkX3dpbGRjYXJkKGFsaWFzKTsN
Cj4gICAJYnVmX3ByaW50ZigmbW9kLT5kZXZfdGFibGVfYnVmLCAiTU9EVUxFX0FMSUFTKFwiJXNc
Iik7XG4iLCBhbGlhcyk7DQo+ICsJaWYgKG1vZC0+YnVpbHRpbl9uYW1lKQ0KPiArCQlidWZfcHJp
bnRmKCZtb2QtPm1vZGFsaWFzX2J1ZiwgImFsaWFzICVzICVzXG4iLCBhbGlhcywgbW9kLT5idWls
dGluX25hbWUpOw0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMgdm9pZCBkb19vZl90YWJsZSh2b2lk
ICpzeW12YWwsIHVuc2lnbmVkIGxvbmcgc2l6ZSwNCj4gQEAgLTYxMCwxMiArNjE2LDE4IEBAIHN0
YXRpYyB2b2lkIGRvX3BucF9kZXZpY2VfZW50cnkodm9pZCAqc3ltdmFsLCB1bnNpZ25lZCBsb25n
IHNpemUsDQo+ICAgDQo+ICAgCQlidWZfcHJpbnRmKCZtb2QtPmRldl90YWJsZV9idWYsDQo+ICAg
CQkJICAgIk1PRFVMRV9BTElBUyhcInBucDpkJXMqXCIpO1xuIiwgKmlkKTsNCj4gKwkJaWYgKG1v
ZC0+YnVpbHRpbl9uYW1lKQ0KPiArCQkJYnVmX3ByaW50ZigmbW9kLT5tb2RhbGlhc19idWYsICJh
bGlhcyBwbnA6ZCVzKiAlc1xuIiwNCj4gKwkJCQkgICAqaWQsIG1vZC0+YnVpbHRpbl9uYW1lKTsN
Cj4gICANCj4gICAJCS8qIGZpeCBicm9rZW4gcG5wIGJ1cyBsb3dlcmNhc2luZyAqLw0KPiAgIAkJ
Zm9yIChqID0gMDsgaiA8IHNpemVvZihhY3BpX2lkKTsgaisrKQ0KPiAgIAkJCWFjcGlfaWRbal0g
PSB0b3VwcGVyKCgqaWQpW2pdKTsNCj4gICAJCWJ1Zl9wcmludGYoJm1vZC0+ZGV2X3RhYmxlX2J1
ZiwNCj4gICAJCQkgICAiTU9EVUxFX0FMSUFTKFwiYWNwaSo6JXM6KlwiKTtcbiIsIGFjcGlfaWQp
Ow0KPiArCQlpZiAobW9kLT5idWlsdGluX25hbWUpDQo+ICsJCQlidWZfcHJpbnRmKCZtb2QtPm1v
ZGFsaWFzX2J1ZiwgImFsaWFzIGFjcGkqOiVzOiogJXNcbiIsDQo+ICsJCQkJICAgYWNwaV9pZCwg
bW9kLT5idWlsdGluX25hbWUpOw0KPiAgIAl9DQo+ICAgfQ0KPiAgIA0KPiBAQCAtNjYyLDE5ICs2
NzQsMjUgQEAgc3RhdGljIHZvaWQgZG9fcG5wX2NhcmRfZW50cmllcyh2b2lkICpzeW12YWwsIHVu
c2lnbmVkIGxvbmcgc2l6ZSwNCj4gICAJCQl9DQo+ICAgDQo+ICAgCQkJLyogYWRkIGFuIGluZGl2
aWR1YWwgYWxpYXMgZm9yIGV2ZXJ5IGRldmljZSBlbnRyeSAqLw0KPiAtCQkJaWYgKCFkdXApIHsN
Cj4gLQkJCQljaGFyIGFjcGlfaWRbUE5QX0lEX0xFTl07DQo+IC0JCQkJaW50IGs7DQo+IC0NCj4g
LQkJCQlidWZfcHJpbnRmKCZtb2QtPmRldl90YWJsZV9idWYsDQo+IC0JCQkJCSAgICJNT0RVTEVf
QUxJQVMoXCJwbnA6ZCVzKlwiKTtcbiIsIGlkKTsNCj4gLQ0KPiAtCQkJCS8qIGZpeCBicm9rZW4g
cG5wIGJ1cyBsb3dlcmNhc2luZyAqLw0KPiAtCQkJCWZvciAoayA9IDA7IGsgPCBzaXplb2YoYWNw
aV9pZCk7IGsrKykNCj4gLQkJCQkJYWNwaV9pZFtrXSA9IHRvdXBwZXIoaWRba10pOw0KPiAtCQkJ
CWJ1Zl9wcmludGYoJm1vZC0+ZGV2X3RhYmxlX2J1ZiwNCj4gLQkJCQkJICAgIk1PRFVMRV9BTElB
UyhcImFjcGkqOiVzOipcIik7XG4iLCBhY3BpX2lkKTsNCj4gLQkJCX0NCj4gKwkJCWlmIChkdXAp
DQo+ICsJCQkJY29udGludWU7DQo+ICsJCQljaGFyIGFjcGlfaWRbUE5QX0lEX0xFTl07DQo+ICsJ
CQlpbnQgazsNCg0KTm8gZGVjbGFyYXRpb25zIGluIHRoZSBtaWRkbGUgb2YgYSBibG9jay4gUHV0
IGRlY2xhcmF0aW9ucyBiZWZvcmUgY29kZS4NCg0KPiArDQo+ICsJCQlidWZfcHJpbnRmKCZtb2Qt
PmRldl90YWJsZV9idWYsDQo+ICsJCQkJICAgIk1PRFVMRV9BTElBUyhcInBucDpkJXMqXCIpO1xu
IiwgaWQpOw0KPiArCQkJaWYgKG1vZC0+YnVpbHRpbl9uYW1lKQ0KPiArCQkJCWJ1Zl9wcmludGYo
Jm1vZC0+bW9kYWxpYXNfYnVmLCAiYWxpYXMgcG5wOmQlcyogJXNcbiIsDQo+ICsJCQkJCSAgIGlk
LCBtb2QtPmJ1aWx0aW5fbmFtZSk7DQo+ICsNCj4gKwkJCS8qIGZpeCBicm9rZW4gcG5wIGJ1cyBs
b3dlcmNhc2luZyAqLw0KPiArCQkJZm9yIChrID0gMDsgayA8IHNpemVvZihhY3BpX2lkKTsgaysr
KQ0KPiArCQkJCWFjcGlfaWRba10gPSB0b3VwcGVyKGlkW2tdKTsNCj4gKwkJCWJ1Zl9wcmludGYo
Jm1vZC0+ZGV2X3RhYmxlX2J1ZiwNCj4gKwkJCQkgICAiTU9EVUxFX0FMSUFTKFwiYWNwaSo6JXM6
KlwiKTtcbiIsIGFjcGlfaWQpOw0KPiArCQkJaWYgKG1vZC0+YnVpbHRpbl9uYW1lKQ0KPiArCQkJ
CWJ1Zl9wcmludGYoJm1vZC0+bW9kYWxpYXNfYnVmLCAiYWxpYXMgYWNwaSo6JXM6KiAlc1xuIiwN
Cj4gKwkJCQkJICAgYWNwaV9pZCwgbW9kLT5idWlsdGluX25hbWUpOw0KPiAgIAkJfQ0KPiAgIAl9
DQo+ICAgfQ0KPiBAQCAtMTQ3NiwxMCArMTQ5NCwxMyBAQCBzdGF0aWMgdm9pZCBkb190YWJsZSh2
b2lkICpzeW12YWwsIHVuc2lnbmVkIGxvbmcgc2l6ZSwNCj4gICAJc2l6ZSAtPSBpZF9zaXplOw0K
PiAgIA0KPiAgIAlmb3IgKGkgPSAwOyBpIDwgc2l6ZTsgaSArPSBpZF9zaXplKSB7DQo+IC0JCWlm
IChkb19lbnRyeShtb2QtPm5hbWUsIHN5bXZhbCtpLCBhbGlhcykpIHsNCj4gLQkJCWJ1Zl9wcmlu
dGYoJm1vZC0+ZGV2X3RhYmxlX2J1ZiwNCj4gLQkJCQkgICAiTU9EVUxFX0FMSUFTKFwiJXNcIik7
XG4iLCBhbGlhcyk7DQo+IC0JCX0NCj4gKwkJaWYgKCFkb19lbnRyeShtb2QtPm5hbWUsIHN5bXZh
bCArIGksIGFsaWFzKSkNCj4gKwkJCWNvbnRpbnVlOw0KPiArCQlidWZfcHJpbnRmKCZtb2QtPmRl
dl90YWJsZV9idWYsICJNT0RVTEVfQUxJQVMoXCIlc1wiKTtcbiIsIGFsaWFzKTsNCj4gKwkJaWYg
KCFtb2QtPmJ1aWx0aW5fbmFtZSkNCj4gKwkJCWNvbnRpbnVlOw0KPiArCQlidWZfcHJpbnRmKCZt
b2QtPm1vZGFsaWFzX2J1ZiwgImFsaWFzICVzICVzXG4iLCBhbGlhcywNCj4gKwkJCSAgIG1vZC0+
YnVpbHRpbl9uYW1lKTsNCj4gICAJfQ0KPiAgIH0NCj4gICANCg==
