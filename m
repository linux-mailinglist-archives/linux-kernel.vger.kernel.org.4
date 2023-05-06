Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E266F6F8D40
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 02:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjEFAx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 20:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjEFAxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 20:53:55 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021022.outbound.protection.outlook.com [52.101.62.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E565FD6;
        Fri,  5 May 2023 17:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LS1MpF61S0SiLXzXzkxI7LfoQ3vW7euzQ8IObApn5AwVo268iqb2hPiVgffH26wRbnOSvoININAgKdMuHZtzm/XhuFSWDLGcRFjtEEmWto3/vQ8r0hupl8d3Kp3Ca/drU8weVeKiFev/5xlgvAYeXP9SuaXKQxx1EzWiKNU/bSA5eqkbzPF78UkbeFqs4vXGuHjgC0kS6cIvJmNIyzlTIDtYTtn/kh9N9dru1Dz1Lm5bNgmHM3wC/yq0A/DLCX20Nvwr2+ChjmPjIF08Xnpx2eoOpKVKbFaxM2OBaQW3sM5U6mACJPohKTBzIrjRnUjIkpSI71ntOmR+WY95rdOAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sK/IQvGZxUgMCa0K1Eigw1rYj2UhiPgrotGAq3MSiR4=;
 b=kHfC5XSovSYGyS/+5jTV0QwQSwNaV9i7AbzrU842xsrZOvuXe4PaMeRdSjeA0tGIhfwLOiGlmhfbcetXSZJgbfsv6/QAjCuebaxkCKLMzSyLTgwmklbBVw+SzcWaqfT9TmBUOpiQaEjikyVMvNQo1Y1WD1+zeuTVjc9v3Kk+VpHErHFtjBNeUSvZFJ74Ffy4JWr/eHFxyIe+W66n7/aVh0NRoI2HEyScVohriKYD9xtcoLS38mNHCVYW+Ckthx3YPLkvTnmAMt19fpoib/1He0tIdm7eeZwKM0VQuTO6sSBPwO/a2QKcafw0ubfLmUc3gTnlrilHtWMoXmSMRiAW8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK/IQvGZxUgMCa0K1Eigw1rYj2UhiPgrotGAq3MSiR4=;
 b=b/hnm1GFlBHcj/2O4ssVnTDvGc/uQDdR+tpq5T/NLUTGLwLHywgdHx/bCkEsGChRv9b6csldT8JyqwDxaGT6WwxxBRewBKNFvGp+HKBcpSyfUYL/2zLgIQyrCUhHOEXHjyeJCeery1RjvkNPQoTh+JcjUURgUMWkGFp5q84viWE=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3447.namprd21.prod.outlook.com (2603:10b6:930:c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.11; Sat, 6 May
 2023 00:53:50 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a0f:a04d:69bd:e622]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a0f:a04d:69bd:e622%4]) with mapi id 15.20.6387.012; Sat, 6 May 2023
 00:53:50 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>
Subject: RE: [patch V2 38/38] x86/smpboot/64: Implement
 arch_cpuhp_init_parallel_bringup() and enable it
Thread-Topic: [patch V2 38/38] x86/smpboot/64: Implement
 arch_cpuhp_init_parallel_bringup() and enable it
Thread-Index: AQHZfrsPO9aHmT4GeE2OzCti+2hGJa9Macrg
Date:   Sat, 6 May 2023 00:53:50 +0000
Message-ID: <BYAPR21MB168869144087644F89BAC89FD7739@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230504185733.126511787@linutronix.de>
 <20230504185938.393373946@linutronix.de>
In-Reply-To: <20230504185938.393373946@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=48817eed-6fcb-49bc-9a01-6a43bf5b9b82;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-06T00:42:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3447:EE_
x-ms-office365-filtering-correlation-id: ede41693-710a-42e8-4c62-08db4dcc5b7b
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UOc9Db0wWrh2du3sbXN0q2e69LdewzzfxnEuAoaxPnLtsxOnJnAB9i5KvkPtcUvLUcYvZBqs2LsO/Op4kmGLXv3b53PL7TZ3cuVWyzCXcqCI2qnWoM6iAmETAT7kQPx8lNlJE3c5M1LfwEirdynbOqzw2x+ZnesUsUcpgjqKJZMp9fuIYAzO4+vyNgmeueiyEMKZgt6vRRLoszEtZeFrGzCjHQmN2Fkiz5T7qtnh6Vwxl7aZ5g5ywZtikNZK6HURstJAg8bBygsc49lnxmKrpknDPNVprVXI+KQuGFuJtguW0sayTwbCSyOiRE02N1L7wxFWU4MMYpqrAE+e3keyXLsHgB5Tz3v8Xb/TnXJwyQqNrkwnbMmY3Uorg6zno8dOiyAJiTtyCwTVWosokiYsQaJbqlTRpp4oel/CKQl+VSOT92d8tUsEa2mpDh49VwwMjvbWPlZoZ4wzG9QY388dS5Ea07jeqR6cpjlmLlcvfLyLeA6W/n0kxpzdaL5oimNGNxsQ3s/xc02EOcvSJLguKtDrIuZ2243EzD6Y3kYG438lBjO56Di1RKYe75hDOLB/nXrbxgoLqb7WEQv803wlVcmQKAflpagVQoN5fXvd2+m+MF1yqCgj280TK7fYzgcHQv0G/aKj5gsn0iT9WlGYD6a/UJ4/6N2HCHcxbOnl2eI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199021)(38100700002)(8676002)(8936002)(5660300002)(7406005)(52536014)(83380400001)(2906002)(38070700005)(82960400001)(316002)(82950400001)(786003)(7416002)(66556008)(4326008)(66946007)(8990500004)(76116006)(6506007)(26005)(66446008)(9686003)(64756008)(66476007)(71200400001)(54906003)(110136005)(41300700001)(122000001)(7696005)(55016003)(186003)(33656002)(10290500003)(86362001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVVTR0xkZ0lpelRrMnRGYXB0dDVnNTM1Q3dPVnhheXNHRkIyRjlvYVEvdjFL?=
 =?utf-8?B?RFN4cjB6MS9talI2MnNIZTJtZHViUCswNkMrMUU4UVZ3TDFxRWZpUllGQW9I?=
 =?utf-8?B?bVJOVncydDR4TXdvNWZmL3NJd1J4bW01U3pncjFlZ0hJeDJPOEpBZWpUd1Vt?=
 =?utf-8?B?YVgzMkJhY2ErVVRsSDErYVZwM3pkME45MG8zYy9Sd0NHSFI5RkNtUzRLUjBJ?=
 =?utf-8?B?dHdVUCt1THlsYjErWDF3ZHZsU2hhL1J0ODdJcWVoWGpGejJtWWdyeS9UcFU4?=
 =?utf-8?B?SmFIeGF3YUx2cDZqNktSTERYSkhrR2tIQjZBaHZHWHBlS0tSVHFOWlppUW9T?=
 =?utf-8?B?dUE1WXhxbG5tNnA4R1FzZ3lXdzcwMXFsNURPTmRSSWpYY1g4UGVzK211SUp5?=
 =?utf-8?B?WVNWcml0NThtN3Y4cU4xM0l3S1Npb3RJV2swMzNOVDkwYnBWN2UwclhsZTJq?=
 =?utf-8?B?bEFYMTBnWHRIUDN2cWkrNlErdHd4TWxIdnBBNHZWcTUxWFBrbUhIZ3VFMzZY?=
 =?utf-8?B?WkN3bVdrWGdDbE1RakNUSEREcVJOWGNBV0lULzlCSysrN0Y4ek9wUWw2ZXp3?=
 =?utf-8?B?WGZMRWlUQkx3dDBXUUtoa2RUQ21GSlFlQ2xXOGhGdXQwdElwbTZwdDZsczVi?=
 =?utf-8?B?QVBSTDRiQkpNNms1MTJUanZRa0F3QU1lb2FDLzA0S3pCYzA3SGFzL0ZGRmdF?=
 =?utf-8?B?L1dlYUplcS9rZEJiVFRpM3VIVHpTcTYyZ2Q3VkpvY0NSSFNMWjliejM4VHVu?=
 =?utf-8?B?dWRQaTlsUHZUMXhyMStQMjBkdjU3THNhMitDa05NL0JKT0NycHJPWExZbXpI?=
 =?utf-8?B?N2dObEFueVNsbkV1ZXp4R1laWHZKOWE0ZmdUTVBrY2lYSnJONWwzS2VYMjNX?=
 =?utf-8?B?dlNhSWlsMWpqN3ZHSXBtWjZ4VzYxaFlKbG1uR3RIc0tJZDR3TXZyVDU1NTVt?=
 =?utf-8?B?dlB6VzNuQjRVa0ZOMUVjRkYvcDZPZFYzTGZDOTQwM2plQVQxS3llK2FHT0NH?=
 =?utf-8?B?QWxhbTVsdW1yUEJoaWk0QWpUK2E2ZDZ5NDVCUUlNdjdyMTZHbk84R3lCMFp5?=
 =?utf-8?B?b0xqWkV6MktvWkYvbDk1TGc1RVFKbHgrRVBSUjdmS0h5V0tCV0pUK3ZFZHR5?=
 =?utf-8?B?ZlFkN2xvcGo3S2pmNUZ0c0k0VTNQRW1GRXhCUlhZbW1YZ3hHK3g4eHpsODN5?=
 =?utf-8?B?Ni94cFgxeENZeWlWK0w5cjRxM0pKL2ZGaXFjYXJ3NEM3VXh0ejNUaDd6dzda?=
 =?utf-8?B?YnFXTWVZWUpZOWlqeU9WdEMxMDBTQUhyZmhZcUZPYlByUmVPMmlYNDRwR01B?=
 =?utf-8?B?cjMvb1BTcUZVVDNWMDNnZmp4V0o5WGpIRnJjN2c4dVZacFl4c2szcStnM0w1?=
 =?utf-8?B?eTJ2QnhMUjVibHZvWGN6bHEydGl1cGw2cHoyakFUdUExblF0T2NNSTVacEFS?=
 =?utf-8?B?T1o0a0Q4TlVQMmgxZkw2VnNEVC8xRlNXekFUcGkzWk5nMlJQNVI0eVB1OGdr?=
 =?utf-8?B?UUg3UGdGcGhaYk55WHhQMU1sNHJlNSthTThIalpmT2sxelhvWWtkbVltMW85?=
 =?utf-8?B?UnVaK2VnUWxMRlpSdkhhS1ZTSHlHdUVIZE9IOENoVGdPN2VMUUNMTE1JVEhr?=
 =?utf-8?B?bzBrRTEraXNVNFEwZFViaUxROENpNnYrM0x6M0dYNjR3RFZ3SE80UXFGclow?=
 =?utf-8?B?RytDZlNpbllzNFRNamcyc0F5MUxUN3ZDSnNwdnRBaDRQdFgxOHF5NWhSbUNh?=
 =?utf-8?B?OXRlK1hQNG5LV3czbEdaeDR0Qlk5UzFkdUlGbURoQjRPVnRDMmZ2ODhBRXAy?=
 =?utf-8?B?WDM5Q0NrMFBXVmVtdE1wZkFpcTJHdXAvMWVpaVhSQlpIb000Q0hSWW0zZzRz?=
 =?utf-8?B?SjZHY0NBRm1RSUgvaHNFSy9NdXoxSmxpclBmeForY0RiY3RWYm9oVzROeVpK?=
 =?utf-8?B?WldOMm5sVm5Pd2dEbGdCRTJWK29aRmV0YVFmbmQ2N295N3JmTllaV0JWZjRa?=
 =?utf-8?B?bnpJMGsvbjZZRFNld3pNaXJkUy9scFVKV1U5VEJYRU5XUit0N0h2NlFoWlFq?=
 =?utf-8?B?TmRMUW5CaTdtMmNMK1J4RzFET3VJdXdEWkg4NXQ3RkxaekdwZmp0M3FIVFlF?=
 =?utf-8?B?bE5ucTlNOUFFZElDYk1JbmI3Z1NUNEdOUS9HWk15TEthWG5aVmhPeUxpdmta?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede41693-710a-42e8-4c62-08db4dcc5b7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2023 00:53:50.6070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5f63waM6CyyNfW9fBBr2sRx9cC18cFX9lz+N40ZowcuYvVqDxvJLM4ohL5Diajh7fXh+UFKh20WcZBTRuMpfqoZiiLRuRDrQycKnms7QMlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3447
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+IFNlbnQ6IFRodXJzZGF5
LCBNYXkgNCwgMjAyMyAxMjowMyBQTQ0KPiANCj4gSW1wbGVtZW50IHRoZSB2YWxpZGF0aW9uIGZ1
bmN0aW9uIHdoaWNoIHRlbGxzIHRoZSBjb3JlIGNvZGUgd2hldGhlcg0KPiBwYXJhbGxlbCBicmlu
Z3VwIGlzIHBvc3NpYmxlLg0KPiANCj4gVGhlIG9ubHkgY29uZGl0aW9uIGZvciBub3cgaXMgdGhh
dCB0aGUga2VybmVsIGRvZXMgbm90IHJ1biBpbiBhbiBlbmNyeXB0ZWQNCj4gZ3Vlc3QgYXMgdGhl
c2Ugd2lsbCB0cmFwIHRoZSBSRE1TUiB2aWEgI1ZDLCB3aGljaCBjYW5ub3QgYmUgaGFuZGxlZCBh
dCB0aGF0DQo+IHBvaW50IGluIGVhcmx5IHN0YXJ0dXAuDQo+IA0KPiBUaGVyZSB3YXMgYW4gZWFy
bGllciB2YXJpYW50IGZvciBBTUQtU0VWIHdoaWNoIHVzZWQgdGhlIEdIQkMgcHJvdG9jb2wgZm9y
DQo+IHJldHJpZXZpbmcgdGhlIEFQSUMgSUQgdmlhIENQVUlELCBidXQgdGhlcmUgaXMgbm8gZ3Vh
cmFudGVlIHRoYXQgdGhlDQo+IGluaXRpYWwgQVBJQyBJRCBpbiBDUFVJRCBpcyB0aGUgc2FtZSBh
cyB0aGUgcmVhbCBBUElDIElELiBUaGVyZSBpcyBubw0KPiBlbmZvcmNlbWVudCBmcm9tIHRoZSBz
ZWN1cmUgZmlybXdhcmUgYW5kIHRoZSBoeXBlcnZpc29yIGNhbiBhc3NpZ24gQVBJQyBJRHMNCj4g
YXMgaXQgc2VlcyBmaXQgYXMgbG9uZyBhcyB0aGUgQUNQSS9NQURUIHRhYmxlIGlzIGNvbnNpc3Rl
bnQgd2l0aCB0aGF0DQo+IGFzc2lnbm1lbnQuDQo+IA0KPiBVbmZvcnR1bmF0ZWx5IHRoZXJlIGlz
IG5vIFJETVNSIEdIQ0IgcHJvdG9jb2wgYXQgdGhlIG1vbWVudCwgc28gZW5hYmxpbmcNCj4gQU1E
LVNFViBndWVzdHMgZm9yIHBhcmFsbGVsIHN0YXJ0dXAgbmVlZHMgc29tZSBtb3JlIHRob3VnaHQu
DQo+IA0KPiBJbnRlbC1URFggcHJvdmlkZXMgYSBzZWN1cmUgUkRNU1IgaHlwZXJjYWxsLCBidXQg
c3VwcG9ydGluZyB0aGF0IGlzIG91dHNpZGUNCj4gdGhlIHNjb3BlIG9mIHRoaXMgY2hhbmdlLg0K
PiANCj4gRml4dXAgYW5ub3VuY2VfY3B1KCkgYXMgZS5nLiBvbiBIeXBlci1WIENQVTEgaXMgdGhl
IHNlY29uZGFyeSBzaWJsaW5nIG9mDQo+IENQVTAsIHdoaWNoIG1ha2VzIHRoZSBAY3B1ID09IDEg
bG9naWMgaW4gYW5ub3VuY2VfY3B1KCkgZmFsbCBhcGFydC4NCj4gDQo+IFsgbWlrZWxsZXk6IFJl
cG9ydGVkIHRoZSBhbm5vdW5jZV9jcHUoKSBmYWxsb3V0DQo+IA0KPiBPcmlnaW5hbGx5LWJ5OiBE
YXZpZCBXb29kaG91c2UgPGR3bXdAYW1hem9uLmNvLnVrPg0KPiBTaWduZWQtb2ZmLWJ5OiBUaG9t
YXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gLS0tDQo+IFYyOiBGaXh1cCBhbm5v
dW5jZV9jcHUoKSAtIE1pY2hhZWwgS2VsbGV5DQo+IC0tLQ0KPiAgYXJjaC94ODYvS2NvbmZpZyAg
ICAgICAgICAgICB8ICAgIDMgKw0KPiAgYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYyB8ICAg
IDYgLS0tDQo+ICBhcmNoL3g4Ni9rZXJuZWwvc21wYm9vdC5jICAgIHwgICA4MyArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+IC0tLQ0KDQpbc25pcF0NCg0KPiBAQCAt
OTM0LDEwICs5NjEsMTAgQEAgc3RhdGljIHZvaWQgYW5ub3VuY2VfY3B1KGludCBjcHUsIGludCBh
cA0KPiAgCWlmICghbm9kZV93aWR0aCkNCj4gIAkJbm9kZV93aWR0aCA9IG51bV9kaWdpdHMobnVt
X3Bvc3NpYmxlX25vZGVzKCkpICsgMTsgLyogKyAnIycgKi8NCj4gDQo+IC0JaWYgKGNwdSA9PSAx
KQ0KPiAtCQlwcmludGsoS0VSTl9JTkZPICJ4ODY6IEJvb3RpbmcgU01QIGNvbmZpZ3VyYXRpb246
XG4iKTsNCj4gLQ0KPiAgCWlmIChzeXN0ZW1fc3RhdGUgPCBTWVNURU1fUlVOTklORykgew0KPiAr
CQlpZiAobnVtX29ubGluZV9jcHVzKCkgPT0gMSkNCg0KVW5mb3J0dW5hdGVseSwgdGhpcyBuZXcg
Y2hlY2sgZG9lc24ndCB3b3JrLiAgSGVyZSdzIHRoZSBvdXRwdXQgSSBnZXQ6DQoNClsgICAgMC43
MjEzODRdIHNtcDogQnJpbmdpbmcgdXAgc2Vjb25kYXJ5IENQVXMgLi4uDQpbICAgIDAuNzI1MzU5
XSBzbXBib290OiB4ODY6IEJvb3RpbmcgU01QIGNvbmZpZ3VyYXRpb246DQpbICAgIDAuNzI5MjQ5
XSAuLi4uIG5vZGUgICMwLCBDUFVzOiAgICAgICAgIzINClsgICAgMC43Mjk2NTRdIHNtcGJvb3Q6
IHg4NjogQm9vdGluZyBTTVAgY29uZmlndXJhdGlvbjoNClsgICAgMC43MzcyNDddICAgICAgICM0
DQpbICAgIDAuNzM3NTExXSBzbXBib290OiB4ODY6IEJvb3RpbmcgU01QIGNvbmZpZ3VyYXRpb246
DQpbICAgIDAuNzQxMjQ2XSAgICAgICAjNg0KWyAgICAwLjc0MTUwOF0gc21wYm9vdDogeDg2OiBC
b290aW5nIFNNUCBjb25maWd1cmF0aW9uOg0KWyAgICAwLjc0NTI0OF0gICAgICAgIzgNClsgICAg
MC43NDU1MDddIHNtcGJvb3Q6IHg4NjogQm9vdGluZyBTTVAgY29uZmlndXJhdGlvbjoNClsgICAg
MC43NDkyNTBdICAgICAgIzEwDQpbICAgIDAuNzQ5NTE0XSBzbXBib290OiB4ODY6IEJvb3Rpbmcg
U01QIGNvbmZpZ3VyYXRpb246DQpbICAgIDAuNzUzMjQ4XSAgICAgICMxMg0KWyAgICAwLjc1MzQ5
Ml0gc21wYm9vdDogeDg2OiBCb290aW5nIFNNUCBjb25maWd1cmF0aW9uOg0KWyAgICAwLjc1NzI0
OV0gICAgICAjMTQgICMxICAjMyAgIzUgICM3ICAjOSAjMTEgIzEzICMxNQ0KWyAgICAwLjc2OTMx
N10gc21wOiBCcm91Z2h0IHVwIDEgbm9kZSwgMTYgQ1BVcw0KWyAgICAwLjc3MzI0Nl0gc21wYm9v
dDogTWF4IGxvZ2ljYWwgcGFja2FnZXM6IDENClsgICAgMC43NzcyNTddIHNtcGJvb3Q6IFRvdGFs
IG9mIDE2IHByb2Nlc3NvcnMgYWN0aXZhdGVkICg3ODI1My43OSBCb2dvTUlQUykNCg0KRXZpZGVu
dGx5IG51bV9vbmxpbmVfY3B1cygpIGlzbid0IHVwZGF0ZWQgdW50aWwgYWZ0ZXIgYWxsIHRoZSBw
cmltYXJ5DQpzaWJsaW5ncyBnZXQgc3RhcnRlZC4NCg0KV2hlbiBib290aW5nIHdpdGggY3B1aHAu
cGFyYWxsZWw9MCwgdGhlIG91dHB1dCBpcyBnb29kLg0KDQpNaWNoYWVsDQoNCj4gKwkJCXByX2lu
Zm8oIng4NjogQm9vdGluZyBTTVAgY29uZmlndXJhdGlvbjpcbiIpOw0KPiArDQo+ICAJCWlmIChu
b2RlICE9IGN1cnJlbnRfbm9kZSkgew0KPiAgCQkJaWYgKGN1cnJlbnRfbm9kZSA+ICgtMSkpDQo+
ICAJCQkJcHJfY29udCgiXG4iKTsNCj4gQEAgLTk0OCw3ICs5NzUsNyBAQCBzdGF0aWMgdm9pZCBh
bm5vdW5jZV9jcHUoaW50IGNwdSwgaW50IGFwDQo+ICAJCX0NCj4gDQo+ICAJCS8qIEFkZCBwYWRk
aW5nIGZvciB0aGUgQlNQICovDQo+IC0JCWlmIChjcHUgPT0gMSkNCj4gKwkJaWYgKG51bV9vbmxp
bmVfY3B1cygpID09IDEpDQo+ICAJCQlwcl9jb250KCIlKnMiLCB3aWR0aCArIDEsICIgIik7DQo+
IA0KPiAgCQlwcl9jb250KCIlKnMjJWQiLCB3aWR0aCAtIG51bV9kaWdpdHMoY3B1KSwgIiAiLCBj
cHUpOw0K
