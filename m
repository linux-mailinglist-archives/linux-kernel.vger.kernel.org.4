Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29DA74045B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjF0ULu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjF0ULs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:11:48 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2101.outbound.protection.outlook.com [40.107.114.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4C51BC5;
        Tue, 27 Jun 2023 13:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPpwQVnBRjqQTmK+eWcY6q9r49pAbAeLZEOkpiqaGg3vy49Eb2yas1osrAgWad6Lzj3oXJSdaFY5WFMv7pGAuhQ0BaxvYSnFl4Pjm/DLxIDEa1f1+CkMwHOvvNEj7ILjkL2qO1PgnIiOZ65K1SrA7jvEeZauHl4BpDMS8blur3koejxzs26PVsVvbb1KVLk5O9T05sBegH9pcG36SNCwgaGmd9xNtz9MgJaPHQv82E5Fi6E+OroS0zAzqqRmBeYSyVvA6pxDBBda2sPadCyU1SLFgD1qAxR+0O3QRLRBYO50Nt+nh5OFOriKEMmiMDaTLWUchudrFwi3lXYgJi3zmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FLHf9mesIp6lWlvSXQLzIpp2QsWr/JnwU0u/nMIcsQ=;
 b=Q0QcMsRkaA/LJmG7VoBYSwKVCiKEUyiJ1/F3OEeEAHleiEyMeJKc8vKqf7Duj4uAm8N/N7qy7QWrvUEu3+byb7v/PyKNebKl9Yb5rnYrnPsA+sFvCmxxj3coFA1SljX6zmH7bXgt+h2beXBwMozH10LtDwfmQAIcebTLwVmHojJUuZ/DN6agmKfH7kQaxEFCXXJuBym4ESeGh8G1mik7XijrYQBw5zo+lUvdaasDaDX3SbCDu3HnMgBsa4OP7L+E5Wbmyc/Sq3y4mI/KBbOXBEcvtHU5zhHTKgR7KVIRjBNtr/2awRVtRomnNyqo+uWJGahtuXrXGTlgfhM9sGjhpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FLHf9mesIp6lWlvSXQLzIpp2QsWr/JnwU0u/nMIcsQ=;
 b=jK+em6v9RwrYuollE3f+izYJ3gunWiP+1o8QZT8D1KhubKtIAPUyf1sEsKR6Z97pNw9YpyH+krUiNss99/yG5uJR5UIcbNAVOoe71/sjvs4r7tcQI8Bvwp0ZClJd8j61m0miU83mgw+tpjwBMjpcrbDKJNHnBfYIHZCGx0i2dyw=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS0PR01MB5553.jpnprd01.prod.outlook.com (2603:1096:604:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 20:11:42 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 20:11:42 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>,
        "conor@kernel.org" <conor@kernel.org>
Subject: RE: [PATCH 6.1 000/170] 6.1.36-rc1 review
Thread-Topic: [PATCH 6.1 000/170] 6.1.36-rc1 review
Thread-Index: AQHZqFwFmnCI2CpMOUC9MrvFqvOcmK+fD+dw
Date:   Tue, 27 Jun 2023 20:11:42 +0000
Message-ID: <TY2PR01MB3788F3518DDFF7E2E3367E57B727A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230626180800.476539630@linuxfoundation.org>
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS0PR01MB5553:EE_
x-ms-office365-filtering-correlation-id: 0ea6cd50-7e37-429c-cccd-08db774ab958
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2iGkYhqTTyVe/U9hmpTwoB3zDZBhzX5FnRFHfZ1hVVk3pC2WAnkHXC9j4UaeiNuaBcnj1RhSNyTdvSGf09J96DJlz/FLDa47WA4jM3pwTiohZ0n7Veo7n8y0IWdz+cnQdBJsDK7eHpkAmP2yLp/d6tWNLBre9l3LanBtzcS33JlnlO7agzGmlUsCo7E+Cq3NxNGrVLHJm6elQjN2oDp6y+mw2vb/5oKy/bWhywDXwf8T9iLwAiS9T3eV4L35TriRAtspUS1O1+FW2Me+D2fmLKuKfKLktWVi6r9T/9EpC0pwyAk3JLQB+yIDXeWjAaSzvPtGmqrPB3kHvNy3PhWdwwshy0Ap4T+qxxrflPoccA8/U/c0gLDfxmx+eP3fEm4XZFhLWwKjhzuPsx3aNVxknRHsIqiGCuG5nqE1SMP4QjRM6yrkEOhFBu+88nCXlvm0SNdqNJPVzSO3+nbw/ijSu02Eq0ad2g1ZShfNPnk5YVteLOe8KPEuoLrrWyWg7BnhmKy9YvIwc+Dr5qz61BaLZiL8pvKRdgtKESuuVVkbs5EFml/cf6686eoPI5nUVMAyCMvs5V+mJwlp40zX2BxWst+qanU/g8RkdtJezcL42p9TzIkZBo6wx7W+zyt26ZMtU2PF34w0ghr0kb4wXX7sYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(8676002)(8936002)(55016003)(76116006)(66946007)(66556008)(66446008)(316002)(64756008)(66476007)(9686003)(4326008)(4744005)(6506007)(186003)(26005)(110136005)(7696005)(54906003)(966005)(41300700001)(71200400001)(2906002)(52536014)(5660300002)(7416002)(478600001)(38070700005)(38100700002)(122000001)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czZBR2pXbFExWVZGcE9IM1JSUERwWDc4OFdGWlZ0Y3lVdHkwUjlxRDZDaHl4?=
 =?utf-8?B?WC9pU2YwY1hXOVRPeEhPWVlHYnRvb094UGV5VHdMeTBoWnBWNXN0c0NvSTBm?=
 =?utf-8?B?UlpTeDRxazEzaDRnZkdmbE1rSitNRk5ZYWp3Y3RIL2tLSnBBbWNJZnVHWStB?=
 =?utf-8?B?SmlEUzVLYVZ5UXEycll3NFFtUWNNelFBWkMzNDdVRXhvc2djRlNSTEEwN2NY?=
 =?utf-8?B?dVExT0Nhakt3YTcxRk9GWlZHdGNKL0FkbFNWQ2Fpa3J1UEx3Ti9scytZWURK?=
 =?utf-8?B?NlNDSGdxR0dDVmMrd0wrZVhaVk1PSzMxLytpMDVoWUZjYXBLTm9GWVM2cTdv?=
 =?utf-8?B?WVNZVlk2cStzdER1NzY0ZW1JVEFDZGgwSG1vUXFUcms1cDlmZ2hCbkErY1Fo?=
 =?utf-8?B?ME9qTHNtaTY2S3VkNjdxMmMrcXBVWUgreUhuK0RXaGRuL0ppS3pFNFNJeTJO?=
 =?utf-8?B?OFFjdXlkSnVNTC9qQlllbEpOVXAwc3ZUN2hFRUZPeGFtdGNPNjZpaHhhMUh2?=
 =?utf-8?B?YklDRkl0QWRSazF5TUtUZ0FDeXQwOXAvL1pLMVJab2F2cUo1MEh1TkVKQkFH?=
 =?utf-8?B?aDRpTUJvM04wSlE1ZXZJeXQ0cXpWbm1zT0M3R0ZDZUNlUGM5eit0NnYxSWR2?=
 =?utf-8?B?dm5QQWNyeTRhOE53bGlsR3AyVDhOQ1c0bXNnOWYwMXM1cDQxcHQrYk43SE1R?=
 =?utf-8?B?SEZTTTBlMzY4Z1lpZlpLQ216T2xiL3hpb1pHSTBoUG83N2IvU0szR1NNdVo0?=
 =?utf-8?B?cWZNVUMxTWJ0YzlsUkl3V0lvQjNBUE1wUkxuZFNBRXNBZW1rbjhKYmJjTHVn?=
 =?utf-8?B?N3d1NWZ1OFdOWTJaMTBKNGVDYytMc3Q0Y2l0WGpiOWQya2x3SnIxOVFFdmVo?=
 =?utf-8?B?WSs4NHQwNlZrOVNlTUpWQk0yMmxFQWJQVDd0a1U1TTM5eXpGUElOS0kyWUIw?=
 =?utf-8?B?dXhvYU1UWkJzd0EyRG5hYjA3SDlIQWJCblRFZW80SWpvc3I1WTUwM094VDYr?=
 =?utf-8?B?NGFDNjJvNUVoZ1drRlpCMmttNEM0cUxqRDRMajkvYUp2dVpTT29TNkYvNmE1?=
 =?utf-8?B?RHdxUFR1RkdTTlF5dDYrNUt0TXVWRDdLQ2RZTXZLcXJvdURudk9BVHZ3ZHpl?=
 =?utf-8?B?aXhKSkgxNzdNK3Z5RTEraGQ1MlZubHczUkRVZ3RBRDM0UXlKeGZnVEdFdVor?=
 =?utf-8?B?S3Y2VEVLUjByN0wzTHZYaHFYQStLMlEzOUQvSVZ4Vm04RWVUWWhYWXVKSk8v?=
 =?utf-8?B?eGF1QnN0THFrSUpKU01yK0tteHFHN0Y2R0dqZ0c1U0NyVS9uWFRGVHZVVHJH?=
 =?utf-8?B?d3M0blZjQk94U0NrbjBYTDRRUmRidmxpVHNETnZVcDQrUjE5VFg1dWs1c29w?=
 =?utf-8?B?TXo0c3VCWVZyMGg5eFNvbnJ3NlJlbitiZ1pBL3JDTkFwazY2emNrWDUvYzZo?=
 =?utf-8?B?WitPTUMxRzVJSVVWbkxwSGRKeUFBZEh4YU5ydWxYRzJoSlFVOUoxMWtoS1dD?=
 =?utf-8?B?SE1GTXRNZnB1cnN3ZjVDR2VoMkNFbFBxaU9JSWszeFZUeHhLMWlXZ1Vqa3VG?=
 =?utf-8?B?UGpmODM0YWdHeVl2VWVHOTRwU3Q5bkEvU0Q5N2h6YmdvOURMUE5iNW85Zmx3?=
 =?utf-8?B?a3FkdWdrQ2NSUktlUjJGNGszcWhtL2plR0dwc0FhLzJuSG5nM1RUVHlLUHNh?=
 =?utf-8?B?VlEzRCtOdUs3Q1ltMGl3amQ2MFhFdkc5c2VFUWZGVmwrNGdMMEhWYitpNXp0?=
 =?utf-8?B?SWVFTkppMTgybXo3YUZUZStIY1R3dmNoeXFsbjZxRjlRS01QMlpkL0NrTHBB?=
 =?utf-8?B?blFrbXAwSW1ncy8vZGsyN3lNYlcwZW9VcWpGK0VPS1ZsdFJZWS9JMkxldUM3?=
 =?utf-8?B?TzNyZXhPOFoyVEVJUDBWcWhhM2F1WGdBbjdSUTBpQWY2WGVIVHNYOGFOQklN?=
 =?utf-8?B?d3J3NjRCNkEvTFRtd3RYRWJUcktmUDA5TWNrM0V3YUhobDk5bHA4NEZHNWJm?=
 =?utf-8?B?Q3QwQjdzOTFMbWROUHVOdDZMZ056QWRnNnk3U2FIRXZ6aW5oVHVjK1RWWVVL?=
 =?utf-8?B?bGp5dUpuVmZkQjkyV1dUNkVsR0k5MlVMMndEOFU2T0hKUkZ5RGlqQm9LOEZH?=
 =?utf-8?B?NHUvdTVlMElaY2wrOGwzSXNRVFo1eHZ1QTNyUXNhaDR6MzhpTm15RWR4MWl2?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea6cd50-7e37-429c-cccd-08db774ab958
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 20:11:42.3463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OB26gGEG6VRAKzjQ5IwYzOXkw1mhJdSH8lUkOYlEWpEJ+IeoWPYD/eUGxvZVVOM0FHuTBPS8GCoT7o/Fl4o6vWjL7PtRE2VdMpz1fweR7HQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5553
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KPiBGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bmUgMjYsIDIwMjMgNzowOSBQTQ0KPiANCj4g
VGhpcyBpcyB0aGUgc3RhcnQgb2YgdGhlIHN0YWJsZSByZXZpZXcgY3ljbGUgZm9yIHRoZSA2LjEu
MzYgcmVsZWFzZS4NCj4gVGhlcmUgYXJlIDE3MCBwYXRjaGVzIGluIHRoaXMgc2VyaWVzLCBhbGwg
d2lsbCBiZSBwb3N0ZWQgYXMgYSByZXNwb25zZQ0KPiB0byB0aGlzIG9uZS4gIElmIGFueW9uZSBo
YXMgYW55IGlzc3VlcyB3aXRoIHRoZXNlIGJlaW5nIGFwcGxpZWQsIHBsZWFzZQ0KPiBsZXQgbWUg
a25vdy4NCj4gDQo+IFJlc3BvbnNlcyBzaG91bGQgYmUgbWFkZSBieSBXZWQsIDI4IEp1biAyMDIz
IDE4OjA3OjIzICswMDAwLg0KPiBBbnl0aGluZyByZWNlaXZlZCBhZnRlciB0aGF0IHRpbWUgbWln
aHQgYmUgdG9vIGxhdGUuDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJlbGVhc2UhDQoNCkNJUCBjb25m
aWd1cmF0aW9ucyBidWlsdCBhbmQgYm9vdGVkIG9rYXkgd2l0aCBMaW51eCA2LjEuMzYtcmMxICg4
YzgwNWZiOTc1N2UpOg0KaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC10ZXN0aW5n
L2xpbnV4LXN0YWJsZS1yYy1jaS8tL3BpcGVsaW5lcy85MTIzNzMyOTINCmh0dHBzOi8vZ2l0bGFi
LmNvbS9jaXAtcHJvamVjdC9jaXAtdGVzdGluZy9saW51eC1zdGFibGUtcmMtY2kvLS9jb21taXRz
L2xpbnV4LTYuMS55DQoNClRlc3RlZC1ieTogQ2hyaXMgUGF0ZXJzb24gKENJUCkgPGNocmlzLnBh
dGVyc29uMkByZW5lc2FzLmNvbT4NCg0KS2luZCByZWdhcmRzLCBDaHJpcw0K
