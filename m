Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E68162FE0A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbiKRTen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbiKRTeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:34:31 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120052.outbound.protection.outlook.com [40.107.12.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A675C1A22A;
        Fri, 18 Nov 2022 11:34:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqUEuvSSb8BCBeJL8Dr/etI3fEbpCFGx/HC75c4LE7NwbZZfQfik2Z7HPJmQOhEq/ja83wodJH8x2nvmtCY2ZH5EzjWhM3FLhHrohTxjmj6rPHhr6ODZ4iG3zySgjvESzCGFRbi+IpkqfP3NLt08LRNrMeqjyPr25RP19lVInkcKLWHsDEqrfdiD1DnbGqgoZhYX3QXz+gClCfsDg+y1UkYZTtPngm2o5jnSudM+CN/FNOJGCIM3lsEEtNVzMEFCmYQ/TpO1q6v9tXb2jDwnL1tBSwZbkxUMuU3wPx/qEOi6H6mHznCotxRxutH6hwJvkGRI1xEkC2beksTZjK4p0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBnL/feiFjSco0n9pYDsPBgDIMjTjI3jcbhfbawpLCk=;
 b=PzKu98rSfKciXsIvgcMoqrzGhVDX61legs+bBG47UtVM9XjQL373lSQw9UCTv2B5WOjJ1246yvCEZbZJxqWrORvBIwF+X+5Ubr9sLzCWmpUwjhRf2FZdFcdUG88CqLiRow66JFGqurDFdp8y/Vtngw1cx+gJ1ysWnsWa4fOP0xiVvlqyo9QlM5NqDlLOZADbeYkuklAkubNAVEpW5kNvutqn6oGFZQHQ8il/QzLxWAAKOtydpT1SSofs5pw7odn0OiK9FL02WVnpKxc81RVp2cI3RVPbZTKFy5vpgoKnnVB+2RsxPK601gz9QVKW/BDc9no+L4B/HwP9GpGpQxugwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBnL/feiFjSco0n9pYDsPBgDIMjTjI3jcbhfbawpLCk=;
 b=vooYetSXD733iUcaDs85Mt7uDeDVzYArXVBzCITi0A40EZRPoD3UoSnwPWiMi7ZpPtVmCBJhqlN20Bh3Et6smxn8KZjmqlMfVrNhw6AFNvaIi9Flsybbq6JnkrmX4mFQrEUoQOklhli7ycRPWyIheugq/wDwmSTLnNr9Y08GBFY6w/DEgjJiGX0sXC1BwPOWQBie32nzLccnDQ8olkf1AWr9CTg+J+BhU27u8ffKcB1UYhwXCWmnmB/8cCwk5/bRS398rZT0dkEyYkMRE80arYktD2gWggmIqbw3D++1Rdds1Cs1MugLCewODTmWyETrVsk9DJx07A/gnHPdzah20g==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2901.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 19:34:26 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6%9]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 19:34:26 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH v4 2/3] random: introduce generic vDSO getrandom()
 implementation
Thread-Topic: [PATCH v4 2/3] random: introduce generic vDSO getrandom()
 implementation
Thread-Index: AQHY+3O4zDHynjEiUE6xFq7Mo++rLa5FEqEA
Date:   Fri, 18 Nov 2022 19:34:26 +0000
Message-ID: <ecfd265b-49e7-79b2-1818-e08a2c652db0@csgroup.eu>
References: <20221118172839.2653829-1-Jason@zx2c4.com>
 <20221118172839.2653829-3-Jason@zx2c4.com>
In-Reply-To: <20221118172839.2653829-3-Jason@zx2c4.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2901:EE_
x-ms-office365-filtering-correlation-id: 305a78b6-8d8c-4e7d-e043-08dac99be753
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2cTbQF9YMNQS5ds7nJD1Q3qz2/3cni1zRKDZOBkfx8eOYQx0pBCnCdDmx+MAXyxPcSmr8Lxuv6LQ2clfBABByuyAOx9Z81I+Wp1rDdPgYsyJvEXa0DlyuL/8rwlko/zpjUp4W+8j5h4xyFPCLJ9tfX2wbLgMXjDoG9FYMkc5g7ILXffGuWR4JtXnTc6uWPxswhCpEFvgeLXn2cbgEGhHjqjjjCLuKCsKE8xB++Wu9GuOt4qaC0q8jA4tOK4Kuu33/90mQcAbiQQiGCEHcQ4+Q4cLI5cwNND4nLIBSfcMbJoAa4hFzKSI97PaOOCmU9/2QNk7pNOR4/Gz8eZt9/ynolvpXAC+rPhTusx3+xjRQJIPgNhCJhRiVw2/+ZSOQmVjzJMmUzRY9FKoMDmOryHjTqebyyNxDDxMo5P4VUmj55JXoRQaqZ4xOTOeO8LOKZJ13PNJMkIJSqHk+PLOQUblNzXiCBK7zGvAoMhyaA8q78OpX2IOFq8L2s9wkDzsC7BNM0o66XGknjhO/bKzDF1WIENucoHn4BxUuzaw3w5E3CepR1vZUPQxIXjz4CcZmWaWpA14oNG+CDs1/8lwH+A+Rh4kiaopNa5fw+/jXD8VobZ81DorBtjKurOZf6MatLOPzlE0wXccrx5w09Ne7uhHqTSj+rxYjNIUBj5B/1UnAJ3BuydHJbziLzpWltO37YzAOyodWGUqTDQCqkXeWdBoUq83kFdC12HRb+Rv8Tc49RutUv0PwdvDTbl5Fyk3bdyN1U+0194+1iTCTHTsn3LdSUWWx1e9+uGoh2ZJOUUt9M0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199015)(31696002)(8936002)(64756008)(36756003)(86362001)(41300700001)(76116006)(66946007)(2616005)(66446008)(44832011)(4326008)(71200400001)(8676002)(66574015)(5660300002)(66556008)(91956017)(6486002)(478600001)(316002)(186003)(54906003)(26005)(6506007)(38100700002)(110136005)(122000001)(6512007)(66476007)(38070700005)(2906002)(31686004)(83380400001)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjkvYWlsUXlhUVRacVRjUkdBaUdmb1hHeThVRzY3aW5oUHljNzdHU1g5cWd6?=
 =?utf-8?B?ZkVqdVVkZ0hQVTVrZmJoOElEd1FDTWFDcVVYTVhkRk16UEg5ZDk1N2dleWJ6?=
 =?utf-8?B?N0tabGhOdVcrVjF6OGNGS1JINURBdnVmbHJ0VHdEejdjRE9vTDl6UHYvRzVm?=
 =?utf-8?B?bThUeUdiNWt0ZzczMWxzejdESTBINElNUlphOTVmNS8yR0pGY3pFanA0aC9G?=
 =?utf-8?B?TFg0S2crWnRBQ1VBcXZwOERSdUNZaGl6ZDRiU1djeFNmNE5Iek1VSEl5by9I?=
 =?utf-8?B?ZTA4emZkc1phbldLZnRBRUtPV0M1eFpKb3F2OG5HbmU4cnRwSDB5QWJKL05o?=
 =?utf-8?B?NCtYSjQ5aXg0alVsMUw4d0JSL1ltd3c0bVo4K2ZRdURka00rSTVVRkwxbDhS?=
 =?utf-8?B?NDBIREd0VEpnKy9US0JPbG1yaW5tRGkyb0N0QjRkUGpSMUpwSXB0U3RYNVpn?=
 =?utf-8?B?eHlsT2lpQmxmdXdNeDgwVmh4MDdYQ1FmSDllSWpFQ1hLVXg1ZXpCbzRNVEtT?=
 =?utf-8?B?MzN1cnBWQmpHdE1LMmdGVjFTRmtWeDRvK2VVMGJ6aTlGTGp2bC9GQVJaZDNx?=
 =?utf-8?B?NjlBZDNHN015VksxN05FenZna3JyUXlmZHVKc1A4blJVczBidmJxTWZKOWVi?=
 =?utf-8?B?Sk5NSDROMHdCZ0R1MjJHeU5qUDdYdUhPWDF0YkkrNVZQMTh0K3ZHeVhpS0RL?=
 =?utf-8?B?Y09yTWhlUjRHL3dmNkFnY0NRQmNWQ3I0Umk2Q1NqNXRPSURyMlJRamRZRGEx?=
 =?utf-8?B?TUZRKzVqN0I1WnBielBiVjdQaWxmV3czanpRcU9TbG5qZ0x4TmRPYTV6dEhx?=
 =?utf-8?B?T1dWMzVOSjUxejJDVjdyWDRwM0ZUWW93RU1OZTlCN3NtdDQ1MUh1YTRrRnRi?=
 =?utf-8?B?a3lRbzFTOEtxcUVQL3huSUxFU3dWTHRUaXd6OVl3YS9uc1BWQlp1Y3ZOUHF2?=
 =?utf-8?B?RGtmNitLTHN6Y3J2S1IzY2FORkdweXdtV1Q4eEJBN2V2TE5DWjQzTHJlenBy?=
 =?utf-8?B?NkJFMDhycDhsMDR6cG9pSjRncThzanJVYVlzV2t4S3ZXWmQ0d1pNQjFwOWdj?=
 =?utf-8?B?R2tWd016T2kzQkJQQlU4anhTR0V5SmoxbUp3M1FJdDR1dy8weFlvWlUrVVEv?=
 =?utf-8?B?R1FSM0x1Wkxqd3lFaXZkenVKMGhjbDZtWjR3cTNyL2ErUEFpOUZUNmZmeEdT?=
 =?utf-8?B?VU43QUhEaEZVRm5neUNZdEJvUUlCZVR4R3ZBWm5SWFFBem40K2R5TGhzeURU?=
 =?utf-8?B?cFdaWDkycm1QSkR0WnEzdlpucHZBQUs1TnlGbk9XKzNXN2poR0VQNEd0aXhB?=
 =?utf-8?B?bEFLM0VMUlRrd1VtOEF2WUdkYU04ZjRHU2lSd0c0eFVhSFF6WENVUmFTN3VG?=
 =?utf-8?B?cERHNUpnTFZsZEhXTVB2OEQrcjJDM1hRNDBMeGNkWGRLS1UwU1VrSlNBY1Mz?=
 =?utf-8?B?TGFPQ3FFYUY1ZlRZaGZ5MFY5Ly9mam9vdjNqMDR4OWEwa0ZnNjlOWUdwMXBN?=
 =?utf-8?B?K2o3U3AxdlNkUVMybVFHY08zWVhDUzVmN1dPY2ZNVUtQUXdvSE42eUxLWFlQ?=
 =?utf-8?B?MGUxUHdZV1dEYXFrVFhEdWROa1dMUlA3MlplSXlxSC9PdktOZExlOFQxcVIv?=
 =?utf-8?B?TjlneHhEaTRFNzJobGVjSWtIYnh2bytSSi9wdmoydmpseHFKSWdMd3VQcHpL?=
 =?utf-8?B?NWZWckpWdW9TTDgzaXlvelhCYVB4aThEdmkwTlVnWEtBTXZVeW5hcWQ1b0tN?=
 =?utf-8?B?cmFjRUtGamt6d2J0REZYTTJJL25PbmM2T09uT0JidCtrVy9jWHcwRzJJVXhm?=
 =?utf-8?B?VmQxNFRONDJaVXMrVDlhVnJCTEpEWG5kVUY2OStCM0lXWms3Q0hrWFRhOXNT?=
 =?utf-8?B?U3U3ak50OFdyRDZiSm52SnNKeERUUzFyWWZzdzdFNEs4ZDhHbnhFUEVvQ0g2?=
 =?utf-8?B?OURRMFNreG1MaDdEOUgrejlFSWlsUlhDdlhZWDRnMEdITWJMRUIydkorRU9n?=
 =?utf-8?B?VlcrUm8ycnN5VG0vOHBNTFVNRGNTVWZBQWZFVEhDWmxTWmtBSnQ5ZTJJOWQr?=
 =?utf-8?B?NXRxbVBPVDgwcVpYODdDNWpWSGRiWllXTUNoRlh5TVp1NWgzM1FMdEJoNUJG?=
 =?utf-8?B?dnlHRERvMEQybCt1dmZvZlZBNmpRVEFHRjVIMEZlc1E1SHFMakRTcUFobDhs?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A180EC0E3E0E4A4DB1420EB87FCABCF6@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 305a78b6-8d8c-4e7d-e043-08dac99be753
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 19:34:26.4181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FjIu9fF51deRjDlIedXndMfZ5wcfw8RK4nEIoEbybs9I6++YrvdNqgw9wSbFBQide2TeKOazKcrjUBs5emresf6yTqjgTvkJQeWwoo9kKls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2901
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDE4LzExLzIwMjIgw6AgMTg6MjgsIEphc29uIEEuIERvbmVuZmVsZCBhIMOpY3JpdMKg
Og0KPiBQcm92aWRlIGEgZ2VuZXJpYyBDIHZEU08gZ2V0cmFuZG9tKCkgaW1wbGVtZW50YXRpb24s
IHdoaWNoIG9wZXJhdGVzIG9uDQo+IGFuIG9wYXF1ZSBzdGF0ZSByZXR1cm5lZCBieSB2Z2V0cmFu
ZG9tX2FsbG9jKCkgYW5kIHByb2R1Y2VzIHJhbmRvbSBieXRlcw0KPiB0aGUgc2FtZSB3YXkgYXMg
Z2V0cmFuZG9tKCkuIFRoaXMgaGFzIGEgdGhlIEFQSSBzaWduYXR1cmU6DQo+IA0KPiAgICBzc2l6
ZV90IHZnZXRyYW5kb20odm9pZCAqYnVmZmVyLCBzaXplX3QgbGVuLCB1bnNpZ25lZCBpbnQgZmxh
Z3MsIHZvaWQgKm9wYXF1ZV9zdGF0ZSk7DQo+IA0KDQouLi4NCg0KPiBkaWZmIC0tZ2l0IGEvbGli
L3Zkc28vZ2V0cmFuZG9tLmMgYi9saWIvdmRzby9nZXRyYW5kb20uYw0KPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmIyNTNlOTI0NzcwNg0KPiAtLS0gL2Rldi9u
dWxsDQo+ICsrKyBiL2xpYi92ZHNvL2dldHJhbmRvbS5jDQo+IEBAIC0wLDAgKzEsMTA5IEBADQo+
ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArLyoNCj4gKyAqIENvcHly
aWdodCAoQykgMjAyMiBKYXNvbiBBLiBEb25lbmZlbGQgPEphc29uQHp4MmM0LmNvbT4uIEFsbCBS
aWdodHMgUmVzZXJ2ZWQuDQo+ICsgKi8NCj4gKw0KPiArI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5o
Pg0KPiArI2luY2x1ZGUgPGxpbnV4L2F0b21pYy5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2ZzLmg+
DQo+ICsjaW5jbHVkZSA8dmRzby9kYXRhcGFnZS5oPg0KPiArI2luY2x1ZGUgPGFzbS92ZHNvL2dl
dHJhbmRvbS5oPg0KPiArI2luY2x1ZGUgPGFzbS92ZHNvL3ZzeXNjYWxsLmg+DQo+ICsjaW5jbHVk
ZSAiZ2V0cmFuZG9tLmgiDQo+ICsNCj4gKyN1bmRlZiBtZW1jcHkNCj4gKyNkZWZpbmUgbWVtY3B5
KGQscyxsKSBfX2J1aWx0aW5fbWVtY3B5KGQscyxsKQ0KPiArI3VuZGVmIG1lbXNldA0KPiArI2Rl
ZmluZSBtZW1zZXQoZCxjLGwpIF9fYnVpbHRpbl9tZW1zZXQoZCxjLGwpDQo+ICsNCj4gKyNkZWZp
bmUgQ0hBQ0hBX0ZPUl9WRFNPX0lOQ0xVREUNCj4gKyNpbmNsdWRlICIuLi9jcnlwdG8vY2hhY2hh
LmMiDQo+ICsNCj4gK3N0YXRpYyB2b2lkIG1lbWNweV9hbmRfemVybyh2b2lkICpkc3QsIHZvaWQg
KnNyYywgc2l6ZV90IGxlbikNCj4gK3sNCj4gKyNkZWZpbmUgQ0FTQ0FERSh0eXBlKSBcDQo+ICsJ
d2hpbGUgKGxlbiA+PSBzaXplb2YodHlwZSkpIHsgXA0KPiArCQkqKHR5cGUgKilkc3QgPSAqKHR5
cGUgKilzcmM7IFwNCj4gKwkJKih0eXBlICopc3JjID0gMDsgXA0KPiArCQlkc3QgKz0gc2l6ZW9m
KHR5cGUpOyBcDQo+ICsJCXNyYyArPSBzaXplb2YodHlwZSk7IFwNCj4gKwkJbGVuIC09IHNpemVv
Zih0eXBlKTsgXA0KPiArCX0NCj4gKyNpZmRlZiBDT05GSUdfSEFWRV9FRkZJQ0lFTlRfVU5BTElH
TkVEX0FDQ0VTUw0KPiArI2lmIEJJVFNfUEVSX0xPTkcgPT0gNjQNCj4gKwlDQVNDQURFKHU2NCk7
DQo+ICsjZW5kaWYNCj4gKwlDQVNDQURFKHUzMik7DQo+ICsJQ0FTQ0FERSh1MTYpOw0KPiArI2Vu
ZGlmDQo+ICsJQ0FTQ0FERSh1OCk7DQo+ICsjdW5kZWYgQ0FTQ0FERQ0KPiArfQ0KPiArDQo+ICtz
dGF0aWMgX19hbHdheXNfaW5saW5lIHNzaXplX3QNCj4gK19fY3Zkc29fZ2V0cmFuZG9tKHZvaWQg
KmJ1ZmZlciwgc2l6ZV90IGxlbiwgdW5zaWduZWQgaW50IGZsYWdzLCB2b2lkICpvcGFxdWVfc3Rh
dGUpDQo+ICt7DQo+ICsJc3RydWN0IHZnZXRyYW5kb21fc3RhdGUgKnN0YXRlID0gb3BhcXVlX3N0
YXRlOw0KPiArCWNvbnN0IHN0cnVjdCB2ZHNvX3JuZ19kYXRhICpybmdfaW5mbyA9IF9fYXJjaF9n
ZXRfdmRzb19ybmdfZGF0YSgpOw0KDQpJbiBvcmRlciB0byBlYXNlIHdpcmluZyB1cCB0byBwb3dl
cnBjLCBjYW4gaXQgYmUgZG9uZSB0aGUgc2FtZSB3YXkgYXMgDQpjb21taXQgZTg3NmYwYjY5ZGM5
ICgibGliL3Zkc286IEFsbG93IGFyY2hpdGVjdHVyZXMgdG8gcHJvdmlkZSB0aGUgdmRzbyANCmRh
dGEgcG9pbnRlciIpDQoNCj4gKwl1MzIgY2hhY2hhX3N0YXRlW0NIQUNIQV9TVEFURV9XT1JEU107
DQo+ICsJc3NpemVfdCByZXQgPSBtaW5fdChzaXplX3QsIE1BWF9SV19DT1VOVCwgbGVuKTsNCj4g
Kwl1bnNpZ25lZCBsb25nIGN1cnJlbnRfZ2VuZXJhdGlvbjsNCj4gKwlzaXplX3QgYmF0Y2hfbGVu
Ow0KPiArDQoNClRoYW5rcywNCkNocmlzdG9waGUNCg==
