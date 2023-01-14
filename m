Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68A066A765
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 01:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjANALn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 19:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjANALk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 19:11:40 -0500
Received: from CY4PR02CU007-vft-obe.outbound.protection.outlook.com (mail-westcentralusazon11021015.outbound.protection.outlook.com [40.93.199.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FB28E9B7;
        Fri, 13 Jan 2023 16:11:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TG0F++YMu8Xn/otmT6ppHWcZKCl95tWJO3zexsAKThRJiIYGdy37DvyFWfc0loU92ncoREy79GzeF8yUPcasvNwma8TOnDgDxHbF4AFh9aOdFucugbyugeW8q2sZ+GpTZfQg26jIYT3HYZbQ9uAZlCi4kS+1dSoDKr44JiJe9fa0XTsEsCRHjTYjgB7YqpmCKd/dGAHiATJaSMZzuqYh+KcoGotXCC/yoNH9gVVisW78zeKbtP0i8KvFg7E7azGHJDv53rS3B6qSQzdX5DvlFF8nKtacXKgS5RlXh/UhiupkDsKTNry1ZvK6aOJFADCAsOw6TG6Q3e1dHZO3rTrWtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggpgM4kPzTYAi/YLhvL6Vn7Ymbxgs+IybMPgFe6shSI=;
 b=m9lTGwS2X+FmC5ctQvsgc1spkevunpxUPA7LTV0t9cpDrie49UeQmVXO1vAckOUxF9aIjT+gpxTKwa3cFd/o8v8i6F2mkZ2zfHIo6NZ2anfv7NssZ0psMCaJPEmUJiN/xwPHtcJRYugJJPoidvKw7pVWlcWEhCJQiIDn4q01kIYd+KLks7hPPOFkh7npwBaG0/23B8v6wmLHxxgBU3+IqW10YWh5JDZMBzV1PE89HEhs+tPDOUh62VOpi0x/ziQwMqPh8kxi9mTJAedwu/SEpdogNYpbukAI4fEjaoWoRBLNu1+HYusSHSKgX2HpHQAF5uqIDDE2C3I5omQm6kLy6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggpgM4kPzTYAi/YLhvL6Vn7Ymbxgs+IybMPgFe6shSI=;
 b=hW2/X+W3debtb7OyTmcGNionjghx3ZWWP9uuNEGSEC51Ra2fb/IcZlXPzZi3glntGe945K4XD6dvzFEgfK0wmxQ/Zp8u7cJ2nmAE4bcmJNTbqs3Xp57JKktvHqS/1tqlGzyU0gz/oIOZomtygxTzEu96uLcy2YJ7Wv6t75o+K2w=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DS7PR21MB3525.namprd21.prod.outlook.com (2603:10b6:8:92::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Sat, 14 Jan
 2023 00:11:37 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c14e:c8f3:c27a:af3d]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c14e:c8f3:c27a:af3d%5]) with mapi id 15.20.6023.004; Sat, 14 Jan 2023
 00:11:37 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Shradha Gupta <shradhagupta@linux.microsoft.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: RE: [PATCH] kernel: power: swap: Suppress expected 'Image not found'
 error on Ubuntu
Thread-Topic: [PATCH] kernel: power: swap: Suppress expected 'Image not found'
 error on Ubuntu
Thread-Index: AQHZJ4uk3VW9YTwjQ0+OYg9R0focd66dBefQ
Date:   Sat, 14 Jan 2023 00:11:37 +0000
Message-ID: <SA1PR21MB13359F44D6EB8037117F9F31BFC39@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1671085226-21347-1-git-send-email-shradhagupta@linux.microsoft.com>
 <CAJZ5v0jb3eU6asQ1TqPqV=s5k+255yse=4QH9WssnM2LH-d3uw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jb3eU6asQ1TqPqV=s5k+255yse=4QH9WssnM2LH-d3uw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f0b86067-7307-4653-9b30-2033a529fd79;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-13T23:55:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DS7PR21MB3525:EE_
x-ms-office365-filtering-correlation-id: 44ef960a-2cab-4eda-c99a-08daf5c3e72a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CNq4Us9lWOH9H5o6qLAt6bu+ndbAjAPEN58/C17QanrwowB2oHb+DtywWZ9kmID/NIVWgHUzCOrEb75gIIpD4HA8p07qx1Ulasc4k1wzCMnOIMU98xJzpHK2GTZaYD2Eqj1eZWrAVnexKn0sns9CBTownGd0QmUNlqHyoed+3+FmWbw2MQTIaHQxFEV3xcC9tIn/ZuJwHEEqjc1NkTjU8YV4AB4+fDKyhg4aPVOK6PzC0U3kydk/bdqOfVJSfdOSvyf9HIMs8ze3hqge7hdN8uTWDpbaQ9KMoKdFlyrxoz/8uuwv37ZMFKp2dihs7KZVGLM5d+jMdap6EwauIXvxoFjmYLTQ69QoIoe0+X6dvArnudhOmg2X3piVDRxLy3r45axV+IdxkohnnMTk7JtRQ+dRSTadqzSU5yw2H1cTEXdTaPiG8XZwLcXRQVEF/RVdp1ls4TyivbrLNAauAq8aaAwYxM0m9T9DWZeApAM0K3ywQSZhl8dm8ET5vaeeSMTCAoFiR9GVhIajbWAmhRVD9Lwq/I7zbRlT70xUMv03qw1X+FkaR0kMfQW5/BUqczYut1fWEeMORDAf8QUaHko7OrBRZnfxS7uDTld+8+4RoIhxpwDvBeRhDfUwGNJZ7CFRkqgAt/+dnZr4Mymhijh89wbhmuIATvjxQ9QdsKPyIcKeMqa81acgaenabIPReMdThn2niSK22oyZeOB774fLGzdR+iVN4SXql/7iYRuXU3RHS5Igl3CgWJLy5CfmP9pIa39T7e5rVPKIR7FHC8EeZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199015)(84970400001)(8990500004)(2906002)(83380400001)(7696005)(64756008)(52536014)(33656002)(66556008)(8676002)(4326008)(76116006)(66476007)(66446008)(66946007)(8936002)(86362001)(316002)(41300700001)(5660300002)(38070700005)(54906003)(71200400001)(53546011)(55016003)(9686003)(10290500003)(26005)(6506007)(186003)(110136005)(122000001)(82950400001)(107886003)(478600001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDFJV3puNFhjT1ZwV25YSngvNzBtK3BYbkdzRE9ldDE4bXFQWjRMVmZZZWFP?=
 =?utf-8?B?eEtrOWdBSWFsK2xnTmlraGFrNUp4a01JdkY3eWx5MmZzRFlJempxZTdBY2Fk?=
 =?utf-8?B?dmhFRXdseVJhL1VjZlpLV3Joek8wa21NMXAvTU9rdkhLZTVUNzR2NUJYVVRS?=
 =?utf-8?B?Q1lPdVpJZU9YSWJ2QjBpaXRtaVFuc2hOa3JtUmlpRmxTVFZwVVpqQ2xZKzBP?=
 =?utf-8?B?ZnMxaFVDbVFSaGpNMjMvNnYyZ3N3MlpYazdCaG84Q0svVmJBbkk0cGVjTHBJ?=
 =?utf-8?B?aTdvK0J3bkdHTGlYOE9lOFZZWFU2dE5qRSt3bm5jclhhRmo5cUtNcnRUMHBN?=
 =?utf-8?B?QjB5bXVvNEFJb2tmWnpwcGRzM3JoOHh5aVVWVEQyazNCamVRVndtTGp6Mktw?=
 =?utf-8?B?bGVXdkg5L1RQcyswNU5oc3ltNnY4YVFpRURuMHZhWFdPZm5iYXRQMTF3WlUx?=
 =?utf-8?B?bzVzWW1nemNyZjRoZkwzRExyUTJnRGpsVXF5Z0ZNOWcvNjJXbkhweTE5Q3Yr?=
 =?utf-8?B?NTFTSGRQK2pHQlNWRHY3VExnY0J3UlhVbVZ6UDBGMkpSRWdwQ1RFcHNJcGFE?=
 =?utf-8?B?RzFQdVErd1A0RmpKSWJTN1laZWRZdU0vRzdZdkYwQWtsMnZ3cktCSS9oV1oy?=
 =?utf-8?B?NUVTM29kOFVXa1d5bk0wckcxRlN6UFhBSGd2MVBDSEFBU01jd1Y1SGc4ZVZu?=
 =?utf-8?B?VmRNYjM5VFJtYzk1RlVRcEVjYjIrYlhtOFRsNHM2Wm9nbGdkbmhHdS9scWJK?=
 =?utf-8?B?V2QrZlRzdlpqcmFpNjRZaG1KWUlxUHU0aUhlb1FnZjRQUUJIbVY3Ym4zV0dP?=
 =?utf-8?B?R29xbnArM1R3Rnd5MVpBZ1JnZXdpTENmMlJvYXZGZ2VFanRsUXZ3a3ZpZDV6?=
 =?utf-8?B?b3Q0czBzSVVFU3diRHd3YURNYks3VHVhT0hTbWdMT0c1MmxEUzJoc0VCeEEw?=
 =?utf-8?B?dEY3ZEtQdzBEUHczSFpFb2dMekQrMXowZ1J4alJFdlJmQUQwa01DM05zVlpo?=
 =?utf-8?B?WXJqRk9GZWsrMnZlMGlLRWduN0Y0cWZ6ZXNxcFB2WlovcE1HdkovcjhtTWNp?=
 =?utf-8?B?OWhVYWpEYTNaZmxidFFrYTU3aVlha0kybE13bElTZnFsRkh0VFl4bzlZWXg1?=
 =?utf-8?B?TmluZFE3OVFPbENGU3FKMWduMUZ0RkJPMkFZNWs0aU1XZXRHS05UQUpMeUNi?=
 =?utf-8?B?K2duWEdBRlArWjVYZUNaMmphYWx3Wm02UzlZdDBtTHBqdmZFNU5lTGtta2JL?=
 =?utf-8?B?dnNObWVlZ1FmdmNrWHRKbE5Qb0VHR21LYi9iSndLUTd0SlM4UDdQTld4aldQ?=
 =?utf-8?B?ZkRkSUN0Y1ljY2ZqOXB0YkExdUZ1b3hmbDBlUGpRWTFaYUpZV3ZDTGFnVUd2?=
 =?utf-8?B?QzQ1bG1Ya001VEJYbmVWNGZaRnYyTkRRNzVZK05Rc0lwaXRjRHJzbmJBSGdX?=
 =?utf-8?B?TkJyK3VDV2J2eU5YVDhWWE41ci9JYzFPTW9TNW5jQmVVNFFhZTBuaDRRMXNm?=
 =?utf-8?B?UlhBVnc4aEJFb2EvYittdUZIQy9oM3hoWC9KSmVqbUQ5Q3J3RkM2QlJsaG9V?=
 =?utf-8?B?cWxiOVZyQjFkWGdtL3doSDBWc2c0OGtaQTYxZlgzSnhJT3MxMHFPc1J4QS9I?=
 =?utf-8?B?eno5cjA3eXEwQ0p0aklGVEFtTWRQS0YyWGplRjVsRGxqSE9jOEpuRzI5L0NP?=
 =?utf-8?B?amtYNVdCc0FMdnBZSXFNN0huMHF1bDRUZCtIYkRPNDBGNld4OVZ1WkZqeFlJ?=
 =?utf-8?B?bSsyYWwwdWM4ZTk1ZE9XUURhWlludElnNWtOODZURWRhMlppYTdQcjkxQjBD?=
 =?utf-8?B?Y1NDQWhmbWxEWFVyZkdwdkVZQTRWTlRrZy9lVHlWb1l5Mk11TnpnTlFZckFy?=
 =?utf-8?B?eXRWSWJvSWt1aHFaNDFFblZnbTlhekhyUkhheEZwaC9DWEYzM2lOY2xMWHM4?=
 =?utf-8?B?QWxNbU5qcldXQUtaQXdVZUZ2V1FkcGxCNURaQXVuZkNYYUhDTWV3L1dUa3ZO?=
 =?utf-8?B?a3ZCZWdSUmdjeEJuT0Z5TUExU1R3S3RKQmxaYjZCdUUwNStjTzQrS216RE0v?=
 =?utf-8?B?Wm9UTFdLZlN4czhlbDc1bE1tS21WV09Wc0ExVzZCbGFPTTRGdlpudGlBajN4?=
 =?utf-8?Q?sEdRyNa8GrKRuTJCX6hQqf9Gq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ef960a-2cab-4eda-c99a-08daf5c3e72a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2023 00:11:37.1490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZQC2WM1MF2/afkjnOCdlJcsR16ptPI1n5hjAQIgSngOoyrw5s86ILK6vQEpXhzqd8RhG+WDS91r6/53URHcPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3525
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZy
aWRheSwgSmFudWFyeSAxMywgMjAyMyAxMjoxNCBQTQ0KPiBUbzogU2hyYWRoYSBHdXB0YSA8c2hy
YWRoYWd1cHRhQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IFJhZmFlbCBKLiBXeXNvY2tpDQo+
IDxyYWZhZWxAa2VybmVsLm9yZz47IFBhdmVsIE1hY2hlayA8cGF2ZWxAdWN3LmN6PjsgTGVuIEJy
b3duDQo+IDxsZW4uYnJvd25AaW50ZWwuY29tPjsgRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0
LmNvbT47IE1pY2hhZWwgS2VsbGV5DQo+IChMSU5VWCkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGtlcm5lbDogcG93ZXI6IHN3YXA6IFN1cHByZXNzIGV4
cGVjdGVkICdJbWFnZSBub3QNCj4gZm91bmQnIGVycm9yIG9uIFVidW50dQ0KPiANCj4gT24gVGh1
LCBEZWMgMTUsIDIwMjIgYXQgNzoyMCBBTSBTaHJhZGhhIEd1cHRhDQo+IDxzaHJhZGhhZ3VwdGFA
bGludXgubWljcm9zb2Z0LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJbiAnc3lzdGVtY3RsIGhpYmVy
bmF0ZScgaWYgcmVzdW1lIGRldmljZSBpcyB3cml0dGVuIHRvIHRoZSBzeXNmcw0KPiA+IHJlc3Vt
ZSBwYXJhbWV0ZXIsIGEgc29mdHdhcmVfcmVzdW1lKCkgY2FsbCBpcyB0cmlnZ2VycmVkLiBUaGlz
IGNhbGwNCj4gPiBpcyBleHBlY3RlZCB0byBmYWlsIGluIHN3c3VzcF9jaGVjaygpIGNhbGwgd2l0
aCAtRUJVU1kgZXJyb3IgYW5kIGFuDQo+ID4gJ0ltYWdlIG5vdCBmb3VuZCcgZXJyb3IgbWVzc2Fn
ZS4gVGhpcyBmaXggc3VwcHJlc3NlcyB0aGUgZXhwZWN0ZWQNCj4gPiBmYWlsdXJlIG1lc3NhZ2Ug
ZnJvbSBnZXR0aW5nIGxvZ2dlZCBpbiBVYnVudHUgc2V0dXBzIHdoZXJlDQo+ID4gQ09ORklHX0RZ
TkFNSUNfREVCVUcgaXMgZW5hYmxlZCBieSBkZWZhdWx0Lg0KPiANCj4gSSBzZWUgd2hhdCB5b3Ug
bWVhbiwgc28gd2hhdCBhYm91dCB0aGlzIGNoYW5nZSBpbnN0ZWFkIChtb2R1bG8NCj4gR01haWwt
aW5kdWNlZCB3aGl0ZS1zcGFjZSBicmVha2FnZSk6DQo+IA0KPiAtLS0NCj4gIGtlcm5lbC9wb3dl
ci9zd2FwLmMgfCAgICA5ICsrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IEluZGV4OiBsaW51eC1wbS9rZXJuZWwvcG93ZXIv
c3dhcC5jDQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0NCj4gPT09DQo+IC0tLSBsaW51eC1wbS5vcmlnL2tlcm5lbC9wb3dl
ci9zd2FwLmMNCj4gKysrIGxpbnV4LXBtL2tlcm5lbC9wb3dlci9zd2FwLmMNCj4gQEAgLTE1NDYs
MTcgKzE1NDYsMTYgQEAgaW50IHN3c3VzcF9jaGVjayh2b2lkKQ0KPiAgICAgICAgICB9DQo+IA0K
PiAgcHV0Og0KPiAtICAgICAgICBpZiAoZXJyb3IpDQo+ICsgICAgICAgIGlmIChlcnJvcikgew0K
PiAgICAgICAgICAgICAgYmxrZGV2X3B1dChoaWJfcmVzdW1lX2JkZXYsIEZNT0RFX1JFQUQgfCBG
TU9ERV9FWENMKTsNCj4gLSAgICAgICAgZWxzZQ0KPiArICAgICAgICAgICAgcHJfZGVidWcoIklt
YWdlIG5vdCBmb3VuZCAoY29kZSAlZClcbiIsIGVycm9yKTsNCj4gKyAgICAgICAgfSBlbHNlIHsN
Cj4gICAgICAgICAgICAgIHByX2RlYnVnKCJJbWFnZSBzaWduYXR1cmUgZm91bmQsIHJlc3VtaW5n
XG4iKTsNCj4gKyAgICAgICAgfQ0KPiAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgIGVycm9yID0g
UFRSX0VSUihoaWJfcmVzdW1lX2JkZXYpOw0KPiAgICAgIH0NCj4gDQo+IC0gICAgaWYgKGVycm9y
KQ0KPiAtICAgICAgICBwcl9kZWJ1ZygiSW1hZ2Ugbm90IGZvdW5kIChjb2RlICVkKVxuIiwgZXJy
b3IpOw0KPiAtDQo+ICAgICAgcmV0dXJuIGVycm9yOw0KPiAgfQ0KDQpzb2Z0d2FyZV9yZXN1bWUo
KSAtPiBzd3N1c3BfY2hlY2soKSBjYW4gYmUgdXNlZCBpbiAyIHNjZW5hcmlvczogDQoNCjEpIEFm
dGVyIGEgVk0gaGliZXJuYXRlZCBhbmQgcG93ZXJlZCBvZmYsIHdlIHN0YXJ0IHRoZSBWTSwgYW5k
IHRoZSBzY3JpcHQgDQppbiBpbml0cmQgd3JpdGVzIHRvIHRoZSBzeXMgZmlsZSAncmVzdW1lJywg
c28gcmVzdW1lX3N0b3JlKCkgLT4gDQpzb2Z0d2FyZV9yZXN1bWUoKSBpcyBjYWxsZWQgdG8gcmVz
dW1lIHRoZSBWTS4gSW4gdGhpcyBzY2VuYXJpbywgaWYNCnNvZnR3YXJlX3Jlc3VtZSgpIC0+IHN3
c3VzcF9jaGVjaygpIC0+IGJsa2Rldl9nZXRfYnlfZGV2KCkgaGl0cyBhbg0KZXJyb3IsIHdlIHN0
aWxsIHdhbnQgdG8gc2VlIHRoZSBtZXNzYWdlICJJbWFnZSBub3QgZm91bmQiLCBidXQgd2l0aCB0
aGUNCm5ldyBwcm9wb3NlZCBjaGFuZ2UsIHRoZSBtZXNzYWdlIGlzIG5vdCBwcmludGVkLiBXaXRo
IFNocmFkaGEncyBjaGFuZ2UsDQp0aGUgbWVzc2FnZSBpcyBwcmludGVkLg0KDQoyKSBXaGVuIHdl
IHJ1biAic3lzdGVtY3RsIGhpYmVybmF0ZSIsIHN5c3RlbWN0bCB3cml0ZXMgdG8gdGhlICdyZXN1
bWUnIHN5cw0KZmlsZSwgc28gcmVzdW1lX3N0b3JlKCkgLT4gc29mdHdhcmVfcmVzdW1lKCkgLT4g
c3dzdXNwX2NoZWNrKCkgaXMgY2FsbGVkLg0KSGVyZSB0eXBpY2FsbHkgdGhlIHN3YXAgZmlsZS9w
YXJ0aXRpb24gaXMgYWxyZWFkeSBpbiB1c2UgYXMgdGhlIHN3YXAgc3BhY2UsIHNvDQp0aGUgYmxr
ZGV2X2dldF9ieV9kZXYoKSBpbiBzd3N1c3BfY2hlY2soKSBhbHdheXMgZmFpbHMgd2l0aCAtRUJV
U1kuIFRoaXMgaXMNCnRoZSBzY2VuYXJpbyB3ZSB3YW50IHRvIHN1cHByZXNzIHRoZSBtaXNsZWFk
aW5nICJJbWFnZSBub3QgZm91bmQiIG1lc3NhZ2UuDQoNCklJVUMsIFNocmFkaGEncyBjaGFuZ2Ug
aXMgYmV0dGVyLg0K
