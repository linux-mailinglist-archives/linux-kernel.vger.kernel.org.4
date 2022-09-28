Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399835ED279
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 03:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiI1BJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 21:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiI1BJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 21:09:55 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A800459B8;
        Tue, 27 Sep 2022 18:09:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzlG3b0M/UgjLCkjuJuI29OuIIO32rYe9+l5toVqzPJHRzIFMj9uc+8iuA1RZaTCoA0xjDzH2ZCJA5dUJ4StcoumnBFnbddkbXFG9RK9Wg+6ANSmyuRKRIZ3GeU6kRzSvsDDqIUscek55jRF5jIKeTL7s+hofcMGxysIckQ5e+XB3ZvycgasJ2pkFdR2FNmIYoZCiJ9XXutWkjEI6cepvSXdEXtzfOLOpQOgsmRnf7McPT9WHVwNlIXDccV+4OHl7MyUP+DEJ74G4iyXX4QZW6FMcuPMr1Nsh4SvGbrQk04jAwKF7HoJrqyWbFuC0l1z7ZTqjvSNOfnTDWT8Cgn9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKOoZq/nb4Hg6hYTnSidstHCI7ntOYH6LzSZMqW2VPw=;
 b=Cjz5joO6pq6UxOkIO2rezUrKpCxRcsDVR/J0xr6r3zfcWSCzGclrF8Tg8WlwY6qcsZlOyGIyJipYCUAs+xw+i8EjhCY4NOqt7BBkVeoZR1/KqYW5MJBW5uc9IIRSiGmkw01K4UJLqjbh9vWOF0hP76PhYRI/amz1IksLLfl2EWXQpKCG4HCz8wZ7G+gnjvGFzHzwe2hLocKMcwgDQdaYCMXrrTKKVYCxCIXRHYeMGlGGzuIJRhtav6Olf6+dpL3n5hQYvTYNpgQPYqiO9H1z9a5+euqYskMgHYmT47JbU4fjKX+SmvU53XcYLbayCl9V+fOsssrx6Zuqo7slRFWOVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKOoZq/nb4Hg6hYTnSidstHCI7ntOYH6LzSZMqW2VPw=;
 b=1B3EK0DbgZbJR8Y6crjKZ5rxJSzY0nzZhJaqmueUWKdmCUiojqiw/A01oSdQXNoEF+cKZG3bEGCBtBwWLHfdlWYw81UpC9npqTbEYMv5vgqiR+gynvVTQxsiKMTMpouztgPF0/bgHQhHLzK3duf7Ac9BN7bshPpdEig8txENr1I=
Received: from CY4PR05MB3047.namprd05.prod.outlook.com (2603:10b6:903:f4::7)
 by MWHPR05MB2960.namprd05.prod.outlook.com (2603:10b6:300:61::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7; Wed, 28 Sep
 2022 01:09:48 +0000
Received: from CY4PR05MB3047.namprd05.prod.outlook.com
 ([fe80::d893:b27e:529:35ae]) by CY4PR05MB3047.namprd05.prod.outlook.com
 ([fe80::d893:b27e:529:35ae%7]) with mapi id 15.20.5676.015; Wed, 28 Sep 2022
 01:09:48 +0000
From:   Zack Rusin <zackr@vmware.com>
To:     "masahiroy@kernel.org" <masahiroy@kernel.org>
CC:     "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild: Add an option to skip vmlinux.bz2 in the rpm's
Thread-Topic: [PATCH] kbuild: Add an option to skip vmlinux.bz2 in the rpm's
Thread-Index: AQHYzrN/VRmK2L3UgEuheFbAOIwErq3yAEKAgAIQV4A=
Date:   Wed, 28 Sep 2022 01:09:48 +0000
Message-ID: <a96c0711f0e163e1de8362b32010dbac2f973ee6.camel@vmware.com>
References: <20220922184525.3021522-1-zack@kde.org>
         <CAK7LNARRUbcZLNUOY-is=EVC7Ov8-0SHS=207=XbQkkjS59g4Q@mail.gmail.com>
In-Reply-To: <CAK7LNARRUbcZLNUOY-is=EVC7Ov8-0SHS=207=XbQkkjS59g4Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.1-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR05MB3047:EE_|MWHPR05MB2960:EE_
x-ms-office365-filtering-correlation-id: dd275cb4-f954-4e93-2f1f-08daa0ee2357
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TYFBeT7eTaHCJUK2JSeezwsp69V2SCW0lwUWQbSWlWgrVwFwZ/Lw5/gWmPwYywA6iU2R09mdQPY4Mu9CFotwb3K0kzpzCnztpy0krtUZXIdBri6tj2+lI2hEYFMSVb+yqj91FSiSRJfAYOMWLkCZ+e8wI9Z8+LFCH6Toqum24ELG2FYFsHcWO7GYyuA+nmvCDQfhFgRKiudZei8LeHttA7k6QRHurScVCYP2zsl8/9Pg83x97zU8xAAMxPt8XyxS43oZqX4LB8dyuN0jEzmdw6S43Yh5YhB2WGlu4unDhhG29sPCCj8f6LRw79sTG6WRVBUih8QBXh0sP8rOMC9zne5VeOnY4nytbDChz3XxJh2J9KYUX89p8UCiR9+BEkyakDvmAtZk1HGvwyN+6D8wV/g6TspW26mRVFu0uN4MxxBKfMIsx6bKSNOwxMlR7/i59cOnEUkMpCU1ADW8zSBtgGfRrr8AwZFtxK3rCh7GFXB17dyPx4B2kwNecLsirxO41HtKW8BAJYvIQCv8zPKY9UBmBGz+LpRHU8T9l4umq6sWlfbNRf8TQSx0ySHH4yw5e2sQJmQqwfc9eOuKNS6ruutdyept3jTvHgRJlq8bYP5JJO6FmCa0KmgbD6Xr0izXZSCXhs8TQhue+AuYlRtqzGkuSQxOk9lRQSB12dQ4mAo4v41nn9WNz9252xN3e9xj/a0Qt357/tLsUGHTwwbOu66dUm2NI5EIJKWS6ElpFkKmOaL2svNd0/dq26+/hzLS/mv8380fvOoXnwKdhHH92g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR05MB3047.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199015)(186003)(316002)(86362001)(6916009)(478600001)(83380400001)(6486002)(38100700002)(2616005)(36756003)(71200400001)(122000001)(6512007)(76116006)(66476007)(26005)(66946007)(91956017)(66899015)(64756008)(53546011)(54906003)(6506007)(66556008)(66446008)(2906002)(38070700005)(8676002)(41300700001)(5660300002)(4326008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUJxMXFOb3Bxd1ZzR1EvREpHNE5BRE4rZTh0NE5OckRLOGlCQk5mNUJOOXpZ?=
 =?utf-8?B?dGRkVmZNQmIwWHN6R0xyQ1FSMzhRcXFOTkVFSUhwTmphc0xrdGlOM0kwanh0?=
 =?utf-8?B?VWJ5VFppUWhwM2VKa1JBam93bURtMDlBSkdtVnZNcmhwenlKVnlEdlpwTG1Z?=
 =?utf-8?B?QzdNUUpteG0wNExWZDRCSDRRS3BnRU1tOGRkT1lndjB3Ui9QTWVsa1A2R0F4?=
 =?utf-8?B?NCt5WUdFSGJ4NCtWbk5hU29RTGtRMTQ3WlZQcEQrQU5EWVRyMWJJMG4velZI?=
 =?utf-8?B?L3ovMXN2UG1TNWo0TGw4QmRjVG14TllBekdsTmJwUlRyWXdIYmJjN0hIaEhq?=
 =?utf-8?B?YkE5clhBZ1JCRERkWS9DVE1qRkJtTHZrajBxbG1KQ3diMmZIZVdGQXFXNnhL?=
 =?utf-8?B?eEgrTFQyRWNRSjcwR2UycFV3a2V4Z2lzSkNhUHBXQSsxbmJsck1ISDZHOWh0?=
 =?utf-8?B?RWVxMkU3MU5Va1AycDlMNWg3Q0FrdHZxSlRwZVc3aUlZMDJueTFSOGpBMHB6?=
 =?utf-8?B?QmsvQk5UUmlnbm1uS3g4M3pTcmZ1cGxhT2E1a1RNRzFHQ0hlK2RneVhqQ3Mv?=
 =?utf-8?B?UkxnUDVXcFphdkhXbFk4bG9MVjZ0WTdNNkJjRml3bkhnaHJ3Vk9yV3JOdEUx?=
 =?utf-8?B?U0x3L1kvaHVXYmIwak5PSVFjWlg2ZTZDWFROcWErVVR6VFVjeU1yYUFrZWFm?=
 =?utf-8?B?NmVTWmVZUUhUQUdUbUZibnAwS2VobW1TZExjcjVudWFXOTE4RStwa0JnUlE5?=
 =?utf-8?B?d0ljOVM3MTVoK251d3BPUnNPVEo0SmczK2pDYXp4NEVqRmZ6dENpUmw3TjhW?=
 =?utf-8?B?VDhKeHJiczB4b2V4U294UHJ3TEZTbmcybUlINGJxVThIWVk5VGliamRlQ2w4?=
 =?utf-8?B?ZXhzYW92ZjErODhQUVl4bFpqZHJRbTVsZWZFOGtZT3RmR1FrMklaMFg0OW9O?=
 =?utf-8?B?a3d1b3RQT3d4SEw5aUNCYS81ZHZFcFFkY0U2Rm0rb1dsb0FiUkREcS96bnlu?=
 =?utf-8?B?WmltdkhxMnNnOXBGK2dld1ZhZ3Vubyt3RmpGTndHTUNlTkU3SmVnSitrS0Ew?=
 =?utf-8?B?Zk9NbkU3NE9SeFdTUDNiNEFUNUpTbHNJOTZqcXhtUHJ2OStVN0V3TXhINW14?=
 =?utf-8?B?YSswTWxjSmR2SlIrd0M3VkZMZnBxT0tsRFRnMXo0S1E5Z1U1ZlcrZGhjUDlX?=
 =?utf-8?B?eWhhSm9LdkJ1NUNjMFFNL1VMbVdMWitLTjBUR3hndnR4Q0JoVFNCUjdzWkMz?=
 =?utf-8?B?Ty9ZU2xvZ1ZaZ244aEJEa2U0aHVGdkpZa1NPYUEzQ3dpc2VocnBuajkyYjVj?=
 =?utf-8?B?bHZwaWs3cXoxWS8rUlVteWl2T3c1Zm1vNkdqM3RwUEdNUFA4SHEzUVZzcytj?=
 =?utf-8?B?bDB1RWRSQmJTdlZWUnBzNGh1eGFVcUdkVi8yS2w2V3U0LzdtdHN4aGVPdTh5?=
 =?utf-8?B?UmFPWXROdXNuUCtKVG5YazdQQnAyVmtyaElEYzVSRzQySENoQTZXb2ZBV0ky?=
 =?utf-8?B?VlY2d3VxM2x2ekhoNm0ra3dyRnkvbTh3SStVYUZ3WHJlYlVQSWN5NWNKYWVu?=
 =?utf-8?B?bWdxVXdXSElyaUlpUllBOHpad0FJOTJxZUcvekpvZ3VoTWpCaHRmaGRqdGxI?=
 =?utf-8?B?VjVVQXNRbGNaWTBxSzQ5aXdKMXVxcGVTZ1VjeGd5MXhMMUtWbEhSZERScnQv?=
 =?utf-8?B?blFpK3BtQkQxZ2VZTVNsMXVPZFdOVThRTkJ0VDZjN1IzSDVBcXdUb3pZQlVi?=
 =?utf-8?B?Q2lSdlFOaGt5OXE5RE1vZ1RyQ1U3ZWpkN09ORU5yQlBKUjFnT2x1dEZaMlFQ?=
 =?utf-8?B?ZHJmNEJuWEk4YzZydGVNVkVTU2oyOG91OE1Gc0lrUlVLYmFuYkdoNmtlVUdj?=
 =?utf-8?B?ZS9LMFJnZlJ2MUVoWFJEOThOY1BzSFpvSFNpc1R4UUpRZUxFSSszNm1ZVzE1?=
 =?utf-8?B?V2FqWnlGcGc3Ulg2N21rK09DYW8yUzNMTW93S3l0YVVZZTdxNEE3c3Z5UEZO?=
 =?utf-8?B?Y01LRThmenMrUlYyMlRzdXJrdFNHdzNwVE81SDRTZEpablZMSEUvWDBxck5u?=
 =?utf-8?B?bW9YKzFFd0piSk51d0ZPdCtwZWZ0c3RGL3VZL1ZQU21hRy91WFhoZXlkVTFS?=
 =?utf-8?Q?/L0rOSJwLCjH64mtVlGlXWjoh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <239C831156B3DE4DBB91C53F46F6C4DA@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR05MB3047.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd275cb4-f954-4e93-2f1f-08daa0ee2357
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 01:09:48.1767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zuo2DrhDA4PkKZ8CBGqb3v884m71Q5IRhGGLwjeM8czYliCuz7lnrCtoFjdzc12EL+yssXDCjwgFPOGguorrMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB2960
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTA5LTI3IGF0IDAyOjM4ICswOTAwLCBNYXNhaGlybyBZYW1hZGEgd3JvdGU6
DQo+IOKaoCBFeHRlcm5hbCBFbWFpbA0KPiANCj4gT24gRnJpLCBTZXAgMjMsIDIwMjIgYXQgMzo0
NSBBTSBaYWNrIFJ1c2luIDx6YWNrQGtkZS5vcmc+IHdyb3RlOg0KPiA+IA0KPiA+IEZyb206IFph
Y2sgUnVzaW4gPHphY2tyQHZtd2FyZS5jb20+DQo+ID4gDQo+ID4gVGhlIGRlYnVnIHZtbGludXgg
dGFrZXMgdXAgdGhlIHZhc3QgbWFqb3JpdHkgb2Ygc3BhY2UgaW4gdGhlIGJ1aWx0DQo+ID4gcnBt
J3MuIFdoaWxlIGhhdmluZyBpdCBlbmFibGVkIGJ5IGRlZmF1bHQgaXMgYSBnb29kIGlkZWEgYmVj
YXVzZSBpdA0KPiA+IG1ha2VzIGRlYnVnZ2luZyBlYXNpZXIsIGhhdmluZyBhbiBvcHRpb24gdG8g
c2tpcCBpdCBpcyBoaWdobHkgdmFsdWFibGUNCj4gPiBmb3IgQ0kvQ0Qgc3lzdGVtcyB3aGVyZSBz
bWFsbCBwYWNrYWdlcyBhcmUgYSBsb3QgZWFzaWVyIHRvIGRlYWwgd2l0aA0KPiA+IGUuZy4ga2Vy
bmVsIHJwbSBidWlsdCB1c2luZyBiaW5ycG0tcGtnIG9uIEZlZG9yYSAzNiBkZWZhdWx0IDUuMTku
OCBrZXJuZWwNCj4gPiBjb25maWcgYW5kIGxvY2FsbW9kY29uZmlnIGdvZXMgZnJvbSAyNTVNQiB0
byA2NU1CIHdoaWNoIGlzIGFuIGFsbW9zdA0KPiA+IDR4IGRpZmZlcmVuY2UuDQo+ID4gDQo+ID4g
VG8gc2tpcCBhZGRpbmcgdm1saW51eC5iejIgdG8gdGhlIGJ1aWx0IHJwbSBhZGQgU0tJUF9SUE1f
Vk1MSU5VWA0KPiA+IGVudmlyb25tZW50IHZhcmlhYmxlIHdoaWNoIHdoZW4gc2V0IHRvICJ5Iiwg
ZS5nLiB2aWENCj4gPiAiU0tJUF9SUE1fVk1MSU5VWD15IG1ha2UgYmlucnBtLXBrZyIgd29uJ3Qg
aW5jbHVkZSB2bWxpbnV4LmJ6MiBpbiB0aGUNCj4gPiBidWlsdCBycG0uDQo+ID4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogWmFjayBSdXNpbiA8emFja3JAdm13YXJlLmNvbT4NCj4gPiBDYzogTWFzYWhp
cm8gWWFtYWRhIDxtYXNhaGlyb3lAa2VybmVsLm9yZz4NCj4gPiBDYzogTWljaGFsIE1hcmVrIDxt
aWNoYWwubGttbEBtYXJrb3ZpLm5ldD4NCj4gPiBDYzogTmljayBEZXNhdWxuaWVycyA8bmRlc2F1
bG5pZXJzQGdvb2dsZS5jb20+DQo+ID4gQ2M6IGxpbnV4LWtidWlsZEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+IC0tLQ0KPiA+ICBzY3Jp
cHRzL3BhY2thZ2UvbWtzcGVjIHwgMTAgKysrKysrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9z
Y3JpcHRzL3BhY2thZ2UvbWtzcGVjIGIvc2NyaXB0cy9wYWNrYWdlL21rc3BlYw0KPiA+IGluZGV4
IDdjNDc3Y2E3ZGM5OC4uNWE3MWZjMDg1MmIwIDEwMDc1NQ0KPiA+IC0tLSBhL3NjcmlwdHMvcGFj
a2FnZS9ta3NwZWMNCj4gPiArKysgYi9zY3JpcHRzL3BhY2thZ2UvbWtzcGVjDQo+ID4gQEAgLTIz
LDYgKzIzLDEyIEBAIGVsc2UNCj4gPiAgICAgICAgIE09REVMDQo+ID4gIGZpDQo+ID4gDQo+ID4g
K2lmIFsgIiRSUE1fU0tJUF9WTUxJTlVYIiA9IHkgXTsgdGhlbg0KPiA+ICsgICAgICAgRD1ERUwN
Cj4gPiArZWxzZQ0KPiA+ICsgICAgICAgRD0NCj4gPiArZmkNCj4gPiArDQo+ID4gIGlmIGdyZXAg
LXEgQ09ORklHX0RSTT15IC5jb25maWc7IHRoZW4NCj4gPiAgICAgICAgIFBST1ZJREVTPWtlcm5l
bC1kcm0NCj4gPiAgZmkNCj4gPiBAQCAtOTQsOCArMTAwLDggQEAgJE0gICAkTUFLRSAlez9fc21w
X21mbGFnc30gSU5TVEFMTF9NT0RfUEFUSD0le2J1aWxkcm9vdH0gbW9kdWxlc19pbnN0YWxsDQo+
ID4gICAgICAgICAkTUFLRSAlez9fc21wX21mbGFnc30gSU5TVEFMTF9IRFJfUEFUSD0le2J1aWxk
cm9vdH0vdXNyIGhlYWRlcnNfaW5zdGFsbA0KPiA+ICAgICAgICAgY3AgU3lzdGVtLm1hcCAle2J1
aWxkcm9vdH0vYm9vdC9TeXN0ZW0ubWFwLSRLRVJORUxSRUxFQVNFDQo+ID4gICAgICAgICBjcCAu
Y29uZmlnICV7YnVpbGRyb290fS9ib290L2NvbmZpZy0kS0VSTkVMUkVMRUFTRQ0KPiA+IC0gICAg
ICAgYnppcDIgLTkgLS1rZWVwIHZtbGludXgNCj4gPiAtICAgICAgIG12IHZtbGludXguYnoyICV7
YnVpbGRyb290fS9ib290L3ZtbGludXgtJEtFUk5FTFJFTEVBU0UuYnoyDQo+ID4gKyREICAgICBi
emlwMiAtOSAtLWtlZXAgdm1saW51eA0KPiA+ICskRCAgICAgbXYgdm1saW51eC5iejIgJXtidWls
ZHJvb3R9L2Jvb3Qvdm1saW51eC0kS0VSTkVMUkVMRUFTRS5iejINCj4gPiAgJFMkTSAgIHJtIC1m
ICV7YnVpbGRyb290fS9saWIvbW9kdWxlcy8kS0VSTkVMUkVMRUFTRS9idWlsZA0KPiA+ICAkUyRN
ICAgcm0gLWYgJXtidWlsZHJvb3R9L2xpYi9tb2R1bGVzLyRLRVJORUxSRUxFQVNFL3NvdXJjZQ0K
PiA+ICAkUyRNICAgbWtkaXIgLXAgJXtidWlsZHJvb3R9L3Vzci9zcmMva2VybmVscy8kS0VSTkVM
UkVMRUFTRQ0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4gDQo+IA0KPiANCj4gDQo+IA0KPiBUaGlz
IGNhbWUgZnJvbSBmYzM3MGVjZmRiMzdiODUzYmQ4ZTIxMThjN2FkOWY5OWZhOWFjNWNkDQo+IEkg
ZG8gbm90IGtub3cgaG93IHVzZWZ1bCBvciBhbm5veWluZyBpdCBpcy4NCj4gUHJlc3VtYWJseSwg
aXQgd2FzIGEgY2hlZXN5IHdvcmssIGFuZCByYXRoZXIgYW5ub3lpbmcgdGhhbiB1c2VmdWwuDQo+
IA0KPiANCj4gSW4gZGViaWFuIChzY3JpcHRzL3BhY2thZ2UvbWtkZWJpYW4pLCB0aGlzIGtpbmQg
b2Ygc3R1ZmYgaXMNCj4gYSBzZXBhcmF0ZSBkZWJ1ZyBwYWNrYWdlLCBhbmQgb25seSBidWlsdCB3
aGVuIENPTkZJR19ERUJVR19JTkZPPXkuDQo+IA0KPiANCj4gVGFrZSBtb3JlIHRpbWUgaW4gY2Fz
ZSBzb21lYm9keSBtYXkgY29tZSB1cCB3aXRoIGEgYmV0dGVyIGlkZWEuDQoNCkknZCBiZSBoYXBw
eSB0byByZXdvcmsgaXQgaW4gd2hhdGV2ZXIgd2F5IHdvdWxkIGJlIG1vcmUgY29udmVuaWVudC4g
QmVjYXVzZSBycG0NCmJ1aWxkcyBhbHJlYWR5IGRlcGVuZCBvbiBlbnZpcm9ubWVudCB2YXJzIGR1
ZSB0byBSUE1PUFRTIEkgdGhvdWdodCB0aGlzIGFwcHJvYWNoIHdhcw0KZml0dGluZyBidXQgSSdt
IG5vdCBwYXJ0aWN1bGFybHkgYXR0YWNoZWQgdG8gaXQuIFRoZSBpbXBvcnRhbnQgdGhpbmcgaXMg
dGhlIHRoZSBlbmQNCnJlc3VsdCBvZiBub3QgaW5jbHVkaW5nIHZtbGludXguYnoyIGluIHRoZSBy
cG0gaXRzZWxmLg0KDQpJIHRoaW5rIHRoZSBvdGhlciByZWFzb25hYmxlIHF1ZXN0aW9uIHRvIGFz
ayBpczogaXMgYW55b25lIHN0aWxsIHVzaW5nIHZtbGludXguYnoyDQpmcm9tIHJwbXM/IEJlY2F1
c2UgbWF5YmUganVzdCByZW1vdmluZyB0aGF0IGNvZGUgY29tcGxldGVseSBpcyB0aGUgYmV0dGVy
IG9wdGlvbg0KaGVyZS4NCg0Keg0KDQo=
