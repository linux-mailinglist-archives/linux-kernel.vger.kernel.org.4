Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767C0627E41
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbiKNMnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237320AbiKNMmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:42:54 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90089.outbound.protection.outlook.com [40.107.9.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CFF24BE9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:42:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXqSZyPF9nD48M1rwAo0EAUX1fVNh5AqxwKoCuAASO2Os6oUfmT0lhUmlCnkZ3Cip1vbMVqk8LxzSIMALOaXjtPgUIv1r3UcBn1crh3gO25s6r3XI3m/R4RgYxWFeDeB7guOT2GzRmeAG5unlcqoMXo+vzKWVUeHLtPl/ySAUEOM7/M95DXJQEXvPeN5awSDy00Cwzvk1swFPd3c+QH44NSzcwixIBmOd6H+LPjn4sV5EuBgXFou1uFdK+qvBtG8bYFKNFMFXvxZozp/BrQxXvbPBIEG9B+So4gNLrcRFx2s7QJuSgu+10k/RCPyAWE/FLJVvfWr6sTqfsd9aEvh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gf1Rxu8zyzZ+ZsNrGgAoG3iktEQar2lAjCr6/UONrak=;
 b=OmDknYafdCo/qLomJeEhlp0d+5VOo/WTKilHphrT5mW/C4HyzoSxcOHV4WdPVy+Qc4sQI7+kXgE1UfPKUpofXgQsyg6vqf6DclHcm/CLjMfCYU2Nne4PynRZ+Q343VEo36HHB9GNQmN6I6NQJnFJ7CQXDqxlBo8lrdc64Jsa3hY5UE8bbbZisYXnesUJ1AmXCAXNIC1babXsX5dcfvBNJkwm7BQFY03X2n6wTgYgknjUHqBYrJ5+lp3OPCv/WWPxBn7v5n5nZmDOVkRVURJL7e+0/D6l3tSWqD1nBxoPtO1UDmnF/o82yrT7mERliGqp8wWECZL9txK+DhyWq0tHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gf1Rxu8zyzZ+ZsNrGgAoG3iktEQar2lAjCr6/UONrak=;
 b=kb/nDOX+Fjk4C+N0bKAE0/5Q8UUip2hD0XBAr76lLPSSxBwlJVNL9NZcyGyMAnNSxg0cA0QXpzTuuIjZ2+iPDDx9FbCsf02JVnK0XvMN4gugJE2N4bpgh1/WbCTe5+R0x+uFOSTtZiakgCVXlKL7WtYm5R5X4fwjfI+q0EJITS1yRb3jzAGb92hQkyyr7ArCzpfMZx98BSFFIYV5R68eUYVoyrtym6qt6v/mfR0V/50fco8Z/k3a3eD9vyCilQX9+q+eGD73LIfsJr4zzOe98sXCMQa15RBKNcYcDtyvqNu5cNpPe8vGkJTG3rBXJ60T7DUIPWf70yE8pfWc+qyyTQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2291.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 12:42:20 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6%9]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 12:42:20 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Lombard <clombard@linux.vnet.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] cxl: Fix refcount leak in cxl_calc_capp_routing
Thread-Topic: [PATCH] cxl: Fix refcount leak in cxl_calc_capp_routing
Thread-Index: AQHYeKGvUKqg+b4y0kecgBrJRQu8xq1OvVQAgPCeeYA=
Date:   Mon, 14 Nov 2022 12:42:20 +0000
Message-ID: <f818d7f2-eeae-8a98-30a6-0c47bef9462e@csgroup.eu>
References: <20220605060038.62217-1-linmq006@gmail.com>
 <269ecf828ebaa4212a5be6310619aba6d8cfe41d.camel@linux.ibm.com>
In-Reply-To: <269ecf828ebaa4212a5be6310619aba6d8cfe41d.camel@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2291:EE_
x-ms-office365-filtering-correlation-id: f25ec9e1-a36e-447f-756a-08dac63dabaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ya5yIhVDMJUYyLSv3npeKtp0EgEr2hDHJ687J2x2/40wRItzz/cNY2l0lm7EGxXtchN/kdhFeEJog4sL7DBlRK9grMDUBb8QwWXjsGdNkGKjVr7F3FrsVKUGHwCVRQ4vVoeYNZsCXwiAgexyBASHTYca2XfjjdO1vN8o6rqI0EkEXsAbwmaUQryLcuKarfTYcgpJFd56bswgyDY3Lt7cXcmCLVgKPmeOLgzfbWMjY7SMAmB/lB65x6RteHO6b24d8j/4Jnu96aKTOJpr6XMZcfTToe7umegD38Kyvfot7D3uT98UmvGfNYdz+oR4Qu5/rBYYaHqap1RVesTtenWZIwMGsFVIPxqDd2tto5dlvtW2diFHZqyRkn5dpLf6GApyp50vdQrwBxmRMYP5CZjA3J2hP8KWpuy12aSbR0yjzOhycOUevJYgc9pQRPY3a64zcvxDlBKjXHcMi9QPrtIvuinJiM9W+v8GO0pCIiNIYnnjFaDWE44a1OAwYcYyo9wSPrljmWPmMUTNH/G9GdN8MrUHycVSGeeolEJTBEtzkNJRYMs2W8uilIrJD8neaCqh3xoOjR93zYbsdPNcDgTy7oJrC6DRBxL0iRFyb7rTFoaquL+Wcwpq4ggTgkhI8585KNRfCiykcN6+JVDgHGXbfE2bsJGvCl98or/A3rbqbr+qSWpxrDqYr2T35LGAACBcAREPOhwTpccxlD5SHAF2UiVWZqdX94VZBbrowpzI0AVaa/Ri70z+mot48Ld2S/xqo83eIFeheWcVm0HkcfMhszMuVlZUg5ZnQkwAsXggOa8OVwVvMiwABk1RuukNL8V9EZuzM46NcR0V2IcsukSCMRxdOBfv5q2jaNtBo2EXQo4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(366004)(136003)(346002)(396003)(376002)(451199015)(2616005)(921005)(38100700002)(122000001)(6506007)(86362001)(38070700005)(31696002)(186003)(6512007)(26005)(8676002)(64756008)(316002)(91956017)(110136005)(76116006)(66476007)(66446008)(66556008)(6486002)(478600001)(71200400001)(41300700001)(2906002)(5660300002)(44832011)(7416002)(8936002)(66946007)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGU0T09GYkRrY25TQzc4bmVwRTdRUWtOY3Z4R1BlVFVNNWlKL1dGeEJ6OXdH?=
 =?utf-8?B?dWlBWlZmQWF0bFpzWU5ZMkp5UXBGRTErWWljbm9IUUxGSmpwazFGNUtkaThX?=
 =?utf-8?B?WWNQU28yZ21uT0ZxZDBBMGNSY2hETFN2b1dJb0MxaENMWXU2aE84U3ovS0ZK?=
 =?utf-8?B?VThoamR4eDczYnUzT2lPZVB0VzZ3cTNhOFhZaDNGUHE2NDNoamxTY1puREJW?=
 =?utf-8?B?a3NZMnlCRldwdkJKZjdlZzkyM3V3Ny9xNEo4SWJORGRBM1JIUlF5NWRBZEJw?=
 =?utf-8?B?MC84NW9uNi9jQUhsZ3cyQWFzeW1JeWp3bytSVnVSUVNUSUVPVlE5TU8zVnV0?=
 =?utf-8?B?OU82MEdYUTM2Q0RqcGpESHgxU0c2eituaVBGOEY4THFWUnZGbnNoTXlPSnFJ?=
 =?utf-8?B?dlNFekhJbUEzTDZuTTMrdFdrRVp1ZlQ0M2RXTzlIM2krYzJmS0JiNHJ0eDRM?=
 =?utf-8?B?SVpHTE5rZmlnN0RYQ2FDdVZ5aHhRS2FTZFBTZlNMSGFzZEFKSVhWRWpRN2Rk?=
 =?utf-8?B?Tzc3L1RvTi9FcllaMDZvTVQ0NW5tejA0bjJobGNMUlFKU2VuR0l3Z0c1bnlF?=
 =?utf-8?B?Um5QN1Y2UU13M0pPblk4ekRhM1pvRDdWQzg1OXIrQ1hLQ2lRb0xEUnpVWFdF?=
 =?utf-8?B?eWl3Rk5QM1lGakpXQ2Q1N1hzR0NoSi9QZjFadVh3cWF3VGRXZUF6S3lDa3lu?=
 =?utf-8?B?OU9sWEFqcHhvRlU1YXE0eWxTY01IWE9YaEtKMFlaYTZDeE9VWktZSkRPbE1p?=
 =?utf-8?B?Vk16RERTVTMzakFoV0VYd0owbUI1M0p1Q295TFY0cERhRkZDVUR3VU9CMDc5?=
 =?utf-8?B?bGlWVmx2dmhoYTA5ekFxbFBFM21jOFVtU0NVZlBhbzFWY21URHNWQnZTRGZ4?=
 =?utf-8?B?c3lQZFUvQ1FSTENhMExBMytQMG1WL05qb0h2bU8yZGpsL2tIYWU1UGlwZWZ2?=
 =?utf-8?B?bEE5REJNdnl6bXBUVHRyMXUxVTFjRUc4c1F0YmxVWTJObENDZlp0QStvL2Ro?=
 =?utf-8?B?c1hScnF0MVJYbVBWNjVOWHRvQkxZelpSRGI4bXVaUEgyTTdBY0I1SGFKa3Y2?=
 =?utf-8?B?UjAyVE1hc3JOU3FCWkdPVWxsb0R3SW9CTkNtMTZ4K1BhUDZMbDNCQm9zNVBV?=
 =?utf-8?B?VHlFM2ZvTW1idHJqZDZwM1k1UXRUaXR2RStoQVN1WmNBb3gybmRmZTdGV0FB?=
 =?utf-8?B?NEtKK0Vya25SZUJNU1pmbmh4bkVYdGJIdWdEMXUvNXZ0VHpPOVIvMDlVMkVC?=
 =?utf-8?B?QTdqeEl4UHc1b3NBbWlBeUp3YmpXbW9qS3R5b1NOdWxoRnVrWEN5TGFnQUdJ?=
 =?utf-8?B?NW5Fc05kd3BNM2FIcjBCTEwwMnAwQkl1eWF3d3FiZUpwUVdqT0lVOUJSUFR4?=
 =?utf-8?B?NUswTTBrWVRNTmRCNXdtb2I3Z1BtTGZPZTB1NW4zS2twODVGTm1WRUZhWFV3?=
 =?utf-8?B?MUFhTThOUmVRR2hQSjQrUEV4WE9IZk5PZVU2bmVrY3JxVVpBUzZZdk9Eb1FS?=
 =?utf-8?B?L2FpcUI1S1dCekVrcS9LSFFKQWdRM1FZM0s2TUs1TFd4c0hRQ0o3SVA2V1V4?=
 =?utf-8?B?OWtLUG8rc2NBM29wZDJGdEF2VklabXZlL0dGY2Fmc3g5eHdidFFZaGJPRXJX?=
 =?utf-8?B?THBLZjRKTmp5V0NGRW50NUNTL2xrWEtBTENKdVgvdTNZYk9xNko1MXFaTnRl?=
 =?utf-8?B?OVJnVStxNVcrc1hIU0JjUGVuTjhUQXJ5d1dsVmRhVXIxRjZBVXhseDNmck9J?=
 =?utf-8?B?M1hkUjllM3lkem9rMk5Va0pTdmpKa0Q4Nm5ab3FVUWQ4ZmdSQTRjazU2dlVz?=
 =?utf-8?B?ejIwRElyNHJzZE9QSm0wNGhpNTdINkJsQVMxbDBMK1FVcTVyZjBhQ0RJTFl1?=
 =?utf-8?B?WSsrVjZhQXJZdVBncjhMWjVhbzhleWV0RDR2OGdPK3cyZG9naitEOXQzdlFZ?=
 =?utf-8?B?Q2ZDTGVuZHNKN1hGN2xHd2lhYkxJUEY1S2dkSGtISnlBeUJvWHNrVUptYzRx?=
 =?utf-8?B?cGtMbFJlYWxOeTJwUHZSWHdpUlZjWWZXL2lZQUNRcVVRRmJGQ3lPdzNXY0JO?=
 =?utf-8?B?U0laQldOK3FZVkVKVE1NTFV6VmtWOElHMXBsOXMzL3JYblhxemM2elpJOVJu?=
 =?utf-8?B?TDV0WFA2TmZkQnpsZlNkeDMvSkRyRWZSWHV6VGdaQUx4Zk92ZG94ZUJ3QThF?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81F6F9BFF682A14D904AD3CF7EB8FD64@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f25ec9e1-a36e-447f-756a-08dac63dabaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 12:42:20.1741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A1ojN4eFllbMDxv9xW6SVXnVJdNu5ndtokixK+TmCmnQlQ+isy0eR/nwAW6gamIRaih3hCKuFXBJaTsjmFt5u0zzzG/GYmyKhfRY1D5vgY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2291
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2hvdWxkIHRoaXMgYmUgYXBwbGllZCBieSBCam9ybiBhcyBtb3N0IHJlY2VudCBjaGFuZ2VzIHRv
IHRoYXQgZmlsZSA/DQoNCg0KTGUgMTQvMDYvMjAyMiDDoCAxMjoxMiwgQW5kcmV3IERvbm5lbGxh
biBhIMOpY3JpdMKgOg0KPiBPbiBTdW4sIDIwMjItMDYtMDUgYXQgMTA6MDAgKzA0MDAsIE1pYW9x
aWFuIExpbiB3cm90ZToNCj4+IG9mX2dldF9uZXh0X3BhcmVudCgpIHJldHVybnMgYSBub2RlIHBv
aW50ZXIgd2l0aCByZWZjb3VudA0KPj4gaW5jcmVtZW50ZWQsDQo+PiB3ZSBzaG91bGQgdXNlIG9m
X25vZGVfcHV0KCkgb24gaXQgd2hlbiBub3QgbmVlZCBhbnltb3JlLg0KPj4gVGhpcyBmdW5jdGlv
biBvbmx5IGNhbGxzIG9mX25vZGVfcHV0KCkgaW4gbm9ybWFsIHBhdGgsDQo+PiBtaXNzaW5nIGl0
IGluIHRoZSBlcnJvciBwYXRoLg0KPj4gQWRkIG1pc3Npbmcgb2Zfbm9kZV9wdXQoKSB0byBhdm9p
ZCByZWZjb3VudCBsZWFrLg0KPj4NCj4+IEZpeGVzOiBmMjRiZTQyYWFiMzcgKCJjeGw6IEFkZCBw
c2w5IHNwZWNpZmljIGNvZGUiKQ0KPj4gU2lnbmVkLW9mZi1ieTogTWlhb3FpYW4gTGluIDxsaW5t
cTAwNkBnbWFpbC5jb20+DQo+IA0KPiBUaGFua3MhDQo+IA0KPiBBY2tlZC1ieTogQW5kcmV3IERv
bm5lbGxhbiA8YWpkQGxpbnV4LmlibS5jb20+DQo+IA0KPj4gLS0tDQo+PiAgwqBkcml2ZXJzL21p
c2MvY3hsL3BjaS5jIHwgMSArDQo+PiAgwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL2N4bC9wY2kuYyBiL2RyaXZlcnMvbWlz
Yy9jeGwvcGNpLmMNCj4+IGluZGV4IDNkZTBhZWE2MmFkZS4uNjIzODVhNTI5ZDg2IDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy9taXNjL2N4bC9wY2kuYw0KPj4gKysrIGIvZHJpdmVycy9taXNjL2N4
bC9wY2kuYw0KPj4gQEAgLTM4Nyw2ICszODcsNyBAQCBpbnQgY3hsX2NhbGNfY2FwcF9yb3V0aW5n
KHN0cnVjdCBwY2lfZGV2ICpkZXYsDQo+PiB1NjQgKmNoaXBpZCwNCj4+ICDCoMKgwqDCoMKgwqDC
oMKgcmMgPSBnZXRfcGhiX2luZGV4KG5wLCBwaGJfaW5kZXgpOw0KPj4gIMKgwqDCoMKgwqDCoMKg
wqBpZiAocmMpIHsNCj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByX2Vycigi
Y3hsOiBpbnZhbGlkIHBoYiBpbmRleFxuIik7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgb2Zfbm9kZV9wdXQobnApOw0KPj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIHJjOw0KPj4gIMKgwqDCoMKgwqDCoMKgwqB9DQo+PiAgIA0KPiANCj4gDQo=
