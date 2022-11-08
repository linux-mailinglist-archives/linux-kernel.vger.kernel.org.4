Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A781621BBE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbiKHSUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbiKHSTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:19:35 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90050.outbound.protection.outlook.com [40.107.9.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E3470572
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:18:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mU5XvdmAkWS6Qk1c+GnFEPJvZJNDUwKh+0cS7cu+j2E4Yq3Zb1uNowPrrOQOWXK+gCsOOaK5GvEL7DeTJddD/XWp5dYdw1LWMqM8JGXTB/2MoDckRrgB7xzvR0ukgu/HljAs9KW8yT3/3xAs+eCAufsArSK8x5AY8DnV1mzueo4SQgWblI9/2sDY0rZGSs6Gb8EnhPpfm5f4dBvMolIwtiWn+WKG+f+z43F6f2ir6QAvxdtWV2YMHRVlY09b+oyU0LeDHYqrErcQCv8zIRAOxLsYWDX/07Qr5HcG0t6QTmqjJZ0xM+yYPQed3HSyREeFAT/LYeIo/m0bsyYoYZ6Pxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIZArHj0pC/8hGJqtMPLulQ+udY/0PTQcQgrin6zjbY=;
 b=Ioe/R3UonNcq5dj1KFADcPpLUw3cH7XDjA3sRY0mwK+ZsTvBRQ+t2sjivl8ghhMlzLHKAeR/INg/nl5Hd+Hqqvmzk1yXjePg7jhtAsIUmlAFi2slGCd1OHVhHkfeUgziK6fd5nZaDxg85uc/gbTR+D7logH5BY8LeeofWdQ2n0btyniSk/ad8/Ya/PH0Ymis/Gc0gNW8n2fPWWFjzspbPHcWIRKbTeBbKh+Vb2qorbIOxU9MEY3pdGtz9Tut1bo7LijCxdfqvKlrtWDQZ5udA0AwdxPQhk69XM+0G1X5SJmx+j0qmDpghBZFlDvUSuz56NdwdOTEq2Dy9jlHESjEsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIZArHj0pC/8hGJqtMPLulQ+udY/0PTQcQgrin6zjbY=;
 b=csjTL7lUbkCnDJsb8yg/UUSlSj2ORVIs4fxlyK1JJpCit7mvgWxo9ldV5RYbsTiIZTf7KM+V2RQQXU1YkDvNuBwRqdoAc1CyHVxn9NXB2HmGsC+oqtqm34rpbbi6ofbOUrbkJ8aalFy4ccTzwwHLPnany4ymm6wcCLkkzw7Mz+/GILq+CFHRqF9uF2i8LWQwqCmqdM1qKezfpnm+LoE60jv/c+nFww1BgOABShEk/SJZsWptofPuRS2J9hqRsLU9MBYzEKVHBWd5eJbsI3xqyRb5oaY+/3tOfU9CTJx1MkRbxtvmLlQlgGS5klwNsnLxeV1G7LV8/9QUiKZUEcBHRQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3449.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:149::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 18:18:46 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 18:18:46 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
CC:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rustam Kovhaev <rkovhaev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Deprecating and removing SLOB
Thread-Topic: Deprecating and removing SLOB
Thread-Index: AQHY84qLBN82GiU6L0yVLqZyUQvaqq41Vf6A
Date:   Tue, 8 Nov 2022 18:18:46 +0000
Message-ID: <fae76c45-ba57-3646-b65b-b8f75e544a95@csgroup.eu>
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
In-Reply-To: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB3449:EE_
x-ms-office365-filtering-correlation-id: cb2e6de2-64bd-46bd-74db-08dac1b5ad1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4T/qZEcPygPa6udSmgDBPAmO90EIfz8xCoJG+a2zpO/r+ajj/yX5XkE+OSkUIFh1LYszP1ezjhvLcaQSsU1U6hJkQFQ1IEYeUcCtBR+WmW6dETf4ZHa8g/e50a4V3xtmyQCdm3yHxcpbakCxyVOlN5vaqyUlsURRBBSLmBuNK2hodP7k4U4ngqVqJVoJpmTV8zQFHxWWdb8CTP78pQPeavZTxYYMnEqiHsHjvIngeVUiv+AMEVh2CoCqvkOLkWrt9pmrGk4SIPLOJmPwwaKAzxRWjrbCcsZRIuPWTgx/juh3N35kh051NwxcLbN1HKv5tr1EGHljhLtFDnpNYbgPWZAqXN6A0jKE/JptNlR+HHXc+H10lrXlwH8hYZOduRdoML+QlsvYs9Yr22Wk0QHMIHXvZwix4EtCCnSrXVlOHfSTWdM21aNb4oFxonGRH3xr8j8Bly4NYVBop95+fbsREJtrzIzGrGTsF5Qtej3+svr6lhcpjweHbn4RtPsoSK497gRRZnMjyVasJWV7p/pAl76XPY4LNNUjuyfzv+RT8lPQMJg5CNqM+MUQURSXmJaXTeKLesDw/VAZTp11G4kzgnl9mRUbBUUalVU38BQvo2zKanEuRYn/frqdyoZy/6aRO6YtVcdkmNZ03tqdy0nR4p0K2xpteGvcVH2Mky/1nFxdPN04VgZhalMPC29EILUtaQcXGNMIhDsC46HX23vGztsUqr3MGm3WGUsIrgvSnC5YHZBwI3LwsZ6uqEIPmDjjek6KUDoPZdC3VEH1WsUx8v8oXJKIagHXMvwPGLNSXaFNbmHkfH5aHQ7mbjtXksNhZKRw/6QCNWtodVprsvYO5T0dhIKk2gxSjKzbCV3WkHA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199015)(44832011)(36756003)(66574015)(83380400001)(6506007)(2616005)(26005)(6512007)(186003)(122000001)(38070700005)(3480700007)(38100700002)(5660300002)(2906002)(86362001)(31696002)(41300700001)(71200400001)(478600001)(110136005)(54906003)(316002)(966005)(6486002)(66446008)(8676002)(76116006)(91956017)(66476007)(66946007)(66556008)(64756008)(4326008)(8936002)(7416002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0lsRDcxeTBNRmsvMzZ6ZmEwRDVHd1lNdVlWNW13RzAzcU53SHlXd0NKZXR0?=
 =?utf-8?B?ZDhqT2pkSEwwclhlQUNRUVA4VlIwNG1rd0UwUFd0MGs3ZGZ3NkEwbVp3KzNp?=
 =?utf-8?B?SUpnaU1zTWV2UVhtdEJFb1RQbHdueGZJY2lvOTlrT1NUb1hiZ1NXWHZqbnJZ?=
 =?utf-8?B?OGw5VDNsRmN4akliSWt2c3VZYlNhTGRoM0d2N0puejd4eU9XbUtwdFhnb1E4?=
 =?utf-8?B?UlNVb2xQMi92Nk1KQVFxUTZ0MGF6QXVMU2k5T2pkeHVPbDVKZnJQVEhsL3V1?=
 =?utf-8?B?eE95dCswVVpXY2FLNW1iVUJwczJsSFdRZlRpdEVieWFDeGZOK1ZmelRXWlpF?=
 =?utf-8?B?ZVhteC9BNFdESzRQOHpRaG9IbE5aM0hWTU1sb0E2UGVyZVlzWU0zbnA3NDdz?=
 =?utf-8?B?S1B2T1V5L1Y2Z05lT2k4c25TcFFhWlVIZ1NrT3RwMUhVdCtVbGd0bXgraWcw?=
 =?utf-8?B?MjBMMDlZS01wNGNPTFpiam5GejRDcjd6MVV1MkEyWEJmd3NURURzUkNXWWp4?=
 =?utf-8?B?V0pwVFd3dDVuWGpveXl4ZDZ6YlEya0wyUm9XdnJwMUJjcFZpNHNqdXZmUmls?=
 =?utf-8?B?K1FySndnU2VWYlA2VkNxUWJ5SXJQbHRhVzAzRzZlbW5RVEd4QlZxaWVKMW5s?=
 =?utf-8?B?ckx1eHEvK2tjV25PRytBNUk4RWpKbzhZUDYrWTFNbksrU2JVREgyaFV4ZzRC?=
 =?utf-8?B?V1JWUDVaRnhINVh4NDBDekJtLzZLdFU4QXRlZzFFcWJsS1VzNVNzVTZYR0ZM?=
 =?utf-8?B?NUxrUU9rMm5pQy8xdU1neTNZdTlKaDVxbTZZbndxd1hQSS9vY0RHWHk2dGtH?=
 =?utf-8?B?TU9FSU43S0NFRVpOV0VHNk43ck5tbjZuck0zTnQ4aWIxcG1uN0JJZ3krUm14?=
 =?utf-8?B?ditseWQ1TFhZVlFoTHdzS0dDdTlhTEozNnRMYTQ2RGdhTk40M2VkZWtuVTZB?=
 =?utf-8?B?djdYcFBkVTZXUHpuTERsWWdqczdXdWNGZDg0b01SY2VCNitmQ0xEZGJ3THM0?=
 =?utf-8?B?R00wVzF4b0c3Q3M2ZGdodzROYk5YR0FPbjNMakNWNlpLa05LVHVtZ2luZmdl?=
 =?utf-8?B?K01IaThuV1ljVDZrc0tlKzQrcFdXcGhlRFJCcGM5S2F1RFRISVh4Uk5BcnR6?=
 =?utf-8?B?NzRnNnlidXErb25KS3hnb3A0aXB4Sk1raWM4UVdSdXN5VjN6cTBocXhEdytv?=
 =?utf-8?B?WG1JUnYvMyt1aDdjNnhWVTgrdE15NTBGZXBlYXRYSmhYMGRUaGpSbTJZbUor?=
 =?utf-8?B?ekJWOHI5YVlUbFFDSnlPVXpwdmZEb1pDQnVsYVlwNEpvS2JlZFVuRnFneHV4?=
 =?utf-8?B?QzdlN2x1b3dnT0FNMUhuQk5KUmhQSWlhSk9XcnFHL2dnYzBNR3RPemlCOW13?=
 =?utf-8?B?b1F2aFV1VjhXNWNaWVZrNTgzdHJQQTJodlRaaU5Zb1VCT3pvWVd5dFE1ZW52?=
 =?utf-8?B?eFJ6dXgzcHhZTXdWUUVzOWVDcHcvdkxuRTFXWjFZMi9BbysxL0RtU3Z3OVYz?=
 =?utf-8?B?SXFpV0I4MDJlRWJPTGV3RXQ0ZzRJZE1PL3VuNXBORW14cmRqeTNRZ2wvQWFw?=
 =?utf-8?B?YWl2bWJnRG9sTVYyWWgySGFhMzNSaDI0bmhlb0RyYThTUkEvN3NkaVNkc0tj?=
 =?utf-8?B?K3dudUtOV0YxYlpHZUJsSVpTd1o0Nmp2QVIrYk5nSVl0ZUNQZmZyUTViWEVG?=
 =?utf-8?B?U3ZreHFIcGM4Q3VVNGl0ejlHU3RDWWt0UlZtTkVodjlaU0JZQ1BHeENTOFFt?=
 =?utf-8?B?cFQrSk9XaUpVTGhuazQyZVhVR1N3bUUwTlNzZ0JvN2xVU1lzNm5rcHB1eXRQ?=
 =?utf-8?B?QlplLzBmU1YyNW9Jd3o0UFp6UjFacEFYMTdSUldKNGlWNC81Rmcray9EOEJz?=
 =?utf-8?B?S2FtQmkvQUtubjBtYmIxbzc0N0hQNjBZYndldTB1RHIwVXoyNWJqMHJSNjZZ?=
 =?utf-8?B?N20wSWNyMUN3QVl5SlFEZ01FZlB2Nk9rT2lxbm8zc0hNQkZiZXI1R2JCWmNn?=
 =?utf-8?B?clNVNmZTaEpDb2NjVHZTNGswclpPZ2pWV2JFUTE2NitXYjViRUZHRnZ1Rm5T?=
 =?utf-8?B?T2Evb0VXQjlMeXROOVpnVE9KYm9zQXlnekIxZDZETmhXdFpjbzkvdkdSa2FE?=
 =?utf-8?B?eWp4anZqc0tJdmVUWHlyUC9ETzBhYnhUQmRsZ0RFZitRa040RFNtU0wyK1hW?=
 =?utf-8?Q?G7QFMaO1TXB3S1MeY/hLrDg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A62068B01FB2824695ABBA112BA05FD8@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2e6de2-64bd-46bd-74db-08dac1b5ad1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 18:18:46.3311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: toS0pI4ORfeDbVoHy4dryKFQ9m5HNxZ483gIipOnuyMYO0MA6DtS8oxmGDj64w7h06fZaUHmA4slMsX5hoQ4N2z+Mf7G0nYRvATBQrCq9/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3449
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA4LzExLzIwMjIgw6AgMTY6NTUsIFZsYXN0aW1pbCBCYWJrYSBhIMOpY3JpdMKgOg0K
PiBIaSwNCj4gDQo+IGFzIHdlIGFsbCBrbm93LCB3ZSBjdXJyZW50bHkgaGF2ZSB0aHJlZSBzbGFi
IGFsbG9jYXRvcnMuIEFzIHdlIGRpc2N1c3NlZCANCj4gYXQgTFBDIFsxXSwgaXQgaXMgbXkgaG9w
ZSB0aGF0IG9uZSBvZiB0aGVzZSBhbGxvY2F0b3JzIGhhcyBhIGZ1dHVyZSwgYW5kIA0KPiB0d28g
b2YgdGhlbSBkbyBub3QuDQoNCldlbGwsIHRoZSBvbmx5IG9uZSB0aGF0IHN1cHBvcnRzIFBSRUVN
UFRfUlQgaXMgU0xVQiBhcyBmYXIgYXMgSSBjYW4gc2VlIA0KaW4gbW0vS2NvbmZpZywgc28gSSBn
dWVzcyBib3RoIFNMT0IgYW5kIFNMQUIgd2lsbCBnbyBhd2F5ID8NCg0KPiANCj4gVGhlIHVuc3Vy
cHJpc2luZyByZWFzb25zIGluY2x1ZGUgY29kZSBtYWludGVuYW5jZSBidXJkZW4sIG90aGVyIGZl
YXR1cmVzIA0KPiBjb21wYXRpYmxlIHdpdGggb25seSBhIHN1YnNldCBvZiBhbGxvY2F0b3JzIChv
ciBtb3JlIGVmZm9ydCBzcGVudCBvbiB0aGUgDQo+IGZlYXR1cmVzKSwgYmxvY2tpbmcgQVBJIGlt
cHJvdmVtZW50cyAobW9yZSBvbiB0aGF0IGJlbG93KSwgYW5kIG15IA0KPiBpbmFiaWxpdHkgdG8g
cHJvbm91bmNlIFNMQUIgYW5kIFNMVUIgaW4gYSBwcm9wZXJseSBkaXN0aW5ndWlzaGFibGUgd2F5
LCANCj4gd2l0aG91dCByZXNvcnRpbmcgdG8gc3BlbGxpbmcgb3V0IHRoZSBsZXR0ZXJzLg0KPiAN
Cj4gSSB0aGluayAoYnV0IG1heSBiZSBwcm92ZW4gd3JvbmcpIHRoYXQgU0xPQiBpcyB0aGUgZWFz
aWVyIHRhcmdldCBvZiB0aGUgDQo+IHR3byB0byBiZSByZW1vdmVkLCBzbyBJJ2QgbGlrZSB0byBm
b2N1cyBvbiBpdCBmaXJzdC4NCj4gDQo+IEkgYmVsaWV2ZSBTTE9CIGNhbiBiZSByZW1vdmVkIGJl
Y2F1c2U6DQo+IA0KPiAtIEFGQUlLIG5vYm9keSByZWFsbHkgdXNlcyBpdD8gSXQgc3RyaXZlcyBm
b3IgbWluaW1hbCBtZW1vcnkgZm9vdHByaW50IA0KPiBieSBwdXR0aW5nIGFsbCBvYmplY3RzIHRv
Z2V0aGVyLCB3aGljaCBoYXMgaXRzIENQVSBwZXJmb3JtYW5jZSBjb3N0cyANCj4gKGxvY2tpbmcs
IGxhY2sgb2YgcGVyY3B1IGNhY2hpbmcsIHNlYXJjaGluZyBmb3IgZnJlZSBzcGFjZS4uLikuIEkn
bSBub3QgDQo+IGF3YXJlIG9mIGFueSAidGlueSBsaW51eCIgZGVwbG95bWVudCB0aGF0IG9wdHMg
Zm9yIHRoaXMuIEZvciBleGFtcGxlLCANCj4gT3BlbldSVCBzZWVtcyB0byB1c2UgU0xVQiBhbmQg
dGhlIGRldmljZXMgdGhlc2UgZGF5cyBoYXZlIGUuZy4gMTI4TUIgDQo+IFJBTSwgbm90IHVwIHRv
IDE2IE1CIGFueW1vcmUuIEkndmUgaGVhcmQgYW5lY2RvdGVzIHRoYXQgdGhlIHBlcmZvcm1hbmNl
IA0KPiBTTE9CIGltcGFjdCBpcyB0b28gbXVjaCBmb3IgdGhvc2Ugd2hvIHRyaWVkLiBHb29nbGlu
ZyBmb3IgDQo+ICJDT05GSUdfU0xPQj15IiB5aWVsZGVkIG5vdGhpbmcgdXNlZnVsLg0KDQpJIHN0
aWxsIGhhdmUgZGV2aWNlcyAocG93ZXJwYykgd2l0aCBvbmx5IDMyTUIgdG9kYXkgYW5kIGZvciB0
aGUgbmV4dCB0ZW4gDQp5ZWFycyBhdCBsZWFzdC4gQnV0IHRoZXkgaGF2ZSBiZWVuIHVzaW5nIFNM
VUIuDQoNCj4gDQo+IC0gTGFzdCB0aW1lIHdlIGRpc2N1c3NlZCBpdCBbMl0sIGl0IHNlZW1lZCBT
TFVCIG1lbW9yeSByZXF1aXJlbWVudHMgY2FuIA0KPiBiZSBicm91Z2h0IHZlcnkgY2xvc2UgdG8g
U0xPQidzIGlmIG5lZWRlZC4gT2YgY291cnNlIGl0IGNhbiBuZXZlciBoYXZlIA0KPiBhcyBzbWFs
bCBmb290cHJpbnQgYXMgU0xPQiBkdWUgdG8gc2VwYXJhdGUga21lbV9jYWNoZXMsIGJ1dCB0aGUg
DQo+IGRpZmZlcmVuY2UgaXMgbm90IHRoYXQgc2lnbmlmaWNhbnQsIHVubGVzcyBzb21lYm9keSBz
dGlsbCB0cmllcyB0byB1c2UgDQo+IExpbnV4IG9uIHZlcnkgdGlueSBzeXN0ZW1zIChnb2VzIGJh
Y2sgdG8gdGhlIHByZXZpb3VzIHBvaW50KS4NCj4gDQo+IEJlc2lkZXMgdGhlIHNtYWxsZXIgbWFp
bnRlbmFuY2UgYnVyZGVuLCByZW1vdmluZyBTTE9CIHdvdWxkIGFsbG93IHVzIHRvIA0KPiBkbyBh
IHVzZWZ1bCBBUEkgaW1wcm92ZW1lbnQgLSB0aGUgYWJpbGl0eSB0byB1c2Uga2ZyZWUoKSBmb3Ig
Ym90aCANCj4gb2JqZWN0cyBhbGxvY2F0ZWQgYnkga21hbGxvYygpIGFuZCBrbWVtX2NhY2hlX2Fs
bG9jKCkuIEN1cnJlbnRseSB0aGUgDQo+IGxhdHRlciBoYXMgdG8gYmUgZnJlZWQgYnkga21lbV9j
YWNoZV9mcmVlKCksIHBhc3NpbmcgYSBrbWVtX2NhY2hlIA0KPiBwb2ludGVyIGluIGFkZGl0aW9u
IHRvIHRoZSBvYmplY3QgcG9pbnRlci4gV2l0aCBTTFVCIGFuZCBTTEFCLCBpdCBpcyANCj4gaG93
ZXZlciBwb3NzaWJsZSB0byB1c2Uga2ZyZWUoKSBpbnN0ZWFkLCBhcyB0aGUga21hbGxvYyBjYWNo
ZXMgYW5kIHRoZSANCj4gcmVzdCBvZiBrbWVtX2NhY2hlcyBhcmUgdGhlIHNhbWUgYW5kIGtmcmVl
KCkgY2FuIGxvb2t1cCB0aGUga21lbV9jYWNoZSANCj4gZnJvbSBvYmplY3QgcG9pbnRlciBlYXNp
bHkgZm9yIGFueSBvZiB0aG9zZS4gWEZTIGhhcyBhcHBhcmVudGx5IGRpZCB0aGF0IA0KPiBmb3Ig
eWVhcnMgd2l0aG91dCBhbnlvbmUgbm90aWNpbmcgaXQncyBicm9rZW4gb24gU0xPQiBbM10sIGFu
ZCANCj4gbGVnaXRpbWl6aW5nIGFuZCBleHBhbmRpbmcgdGhpcyB3b3VsZCBoZWxwIHNvbWUgdXNl
IGNhc2VzIGJlc2lkZSBYRlMgDQo+IChJSVJDIE1hdHRoZXcgbWVudGlvbmVkIHJjdS1iYXNlZCBm
cmVlaW5nIGZvciBleGFtcGxlKS4NCj4gDQo+IEhvd2V2ZXIgZm9yIFNMT0IgdG8gc3VwcG9ydCBr
ZnJlZSgpIG9uIGFsbCBhbGxvY2F0aW9ucywgaXQgd291bGQgbmVlZCB0byANCj4gc3RvcmUgb2Jq
ZWN0IHNpemUgb2YgYWxsb2NhdGVkIG9iamVjdHMgKHdoaWNoIGl0IGN1cnJlbnRseSBkb2VzIG9u
bHkgZm9yIA0KPiBrbWFsbG9jKCkgb2JqZWN0cywgcHJlcGVuZGluZyBhIHNpemUgaGVhZGVyIHRv
IHRoZSBvYmplY3QpLCBidXQgZm9yIA0KPiBrbWVtX2NhY2hlX2FsbG9jKCkgYWxsb2NhdGlvbnMg
YXMgd2VsbC4gVGhpcyBoYXMgYmVlbiBhdHRlbXB0ZWQgaW4gdGhlIA0KPiB0aHJlYWQgWzNdIGJ1
dCBpdCBibG9hdHMgdGhlIG1lbW9yeSB1c2FnZSwgZXNwZWNpYWxseSBvbiBhcmNoaXRlY3R1cmVz
IA0KPiB3aXRoIGxhcmdlIEFSQ0hfS01BTExPQ19NSU5BTElHTiwgd2hlcmUgdGhlIHByZXBlbmRl
ZCBoZWFkZXIgYmFzaWNhbGx5IA0KPiBoYXMgdG8gb2NjdXB5IHRoZSB3aG9sZSBBUkNIX0tNQUxM
T0NfTUlOQUxJR04gYmxvY2sgdG8gYmUgRE1BIHNhZmUuIA0KPiBUaGVyZSBhcmUgb25nb2luZyBl
ZmZvcnRzIHRvIHJlZHVjZSB0aGlzIG1pbmFsaWduLCBidXQgdGhlIG1lbW9yeSANCj4gZm9vdHBy
aW50IHdvdWxkIHN0aWxsIGluY3JlYXNlLCBnb2luZyBhZ2FpbnN0IHRoZSBwdXJwb3NlIG9mIFNM
T0IsIHNvIA0KPiBhZ2FpbiBpdCB3b3VsZCBiZSBlYXNpZXIgaWYgd2UgY291bGQganVzdCByZW1v
dmUgaXQuDQo+IA0KPiBTbyB3aXRoIHRoaXMgdGhyZWFkIEknbSBpbnRlcmVzdGVkIGluIGhlYXJp
bmcgYXJndW1lbnRzL3VzZSBjYXNlcyBmb3IgDQo+IGtlZXBpbmcgU0xPQi4gVGhlcmUgbWlnaHQg
YmUgb2J2aW91c2x5IHVzZXJzIG9mIFNMT0Igd2hvbSB0aGlzIA0KPiBjb252ZXJzYXRpb24gd2ls
bCBub3QgcmVhY2gsIHNvIEkgYXNzdW1lIHRoZSBldmVudHVhbCBuZXh0IHN0ZXAgd291bGQgYmUg
DQo+IHRvIGRlcHJlY2F0ZSBpdCBpbiBhIHdheSB0aGF0IHRob3NlIHVzZXJzIGFyZSBub3RpZmll
ZCB3aGVuIGJ1aWxkaW5nIGEgDQo+IG5ldyBrZXJuZWwgYW5kIGNhbiByYWlzZSB0aGVpciB2b2lj
ZSB0aGVuLiBJcyB0aGVyZSBhIGdvb2QgcHJvdmVuIHdheSANCj4gaG93IHRvIGRvIHRoYXQgZm9y
IGEgY29uZmlnIG9wdGlvbiBsaWtlIHRoaXMgb25lPw0KDQpNYXJrIHRoZW0gYXMgZGVwZW5kZW50
IG9uIENPTkZJR19CUk9LRU4gPw0KDQpDaHJpc3RvcGhlDQoNCj4gDQo+IFRoYW5rcywNCj4gVmxh
c3RpbWlsDQo+IA0KPiBbMV0gaHR0cHM6Ly9scGMuZXZlbnRzL2V2ZW50LzE2L2NvbnRyaWJ1dGlv
bnMvMTI3Mi8gLSBzbGlkZXMgaW4gdGhlIA0KPiBzbGFicy5wZGYgbGlua2VkIHRoZXJlDQo+IFsy
XSANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjExMDE3MTM1NzA4LkdBODQ0MkBr
dm0uYXNpYS1ub3J0aGVhc3QzLWEuYy5vdXItcmF0aW8tMzEzOTE5LmludGVybmFsLyN0DQo+IFsz
XSANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjEwOTMwMDQ0MjAyLkdQMjM2MTQ1
NUBkcmVhZC5kaXNhc3Rlci5hcmVhLw0KPiANCj4g
