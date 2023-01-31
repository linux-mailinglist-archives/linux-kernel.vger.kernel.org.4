Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5D9682AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjAaK7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjAaK7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:59:15 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2059.outbound.protection.outlook.com [40.107.247.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97F847091;
        Tue, 31 Jan 2023 02:58:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3iVpIj6CSw1ic0Lkv4piA8fPvQe4O0N3AI1/CwLejCUM35+pJMHPVeEJvnThLjwcjO2vM7+42DOVFlRLlLZrnKrBiQtmuc/Hc1eYHaBs8mCeb69u0pxFvKx8OclIneXktjnNTy9ThvrnlNsXMNgL9gTMFBOZj8RhHOuwWHUZH8evXDf6kUSHCjN5uTHm5KEhCfnJPA5C+D9tqZkWbWAiE62YWxYO5QXsQQpx1drznPQKYO9tdyBnupRfnXr7ybUmej25OkVKjecyv+OYVuDbHWigfNfK4tiVTxGwDzg4mG+EJUUFajVwAY4sNZnrTFnPIxKJmkdMDszug3VKM3+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQiS7JnqBC3ixzQLvNaRyHi+KyMM7FsWKVmTNgicMeU=;
 b=NC5axvZ2iTNUien83fpe4bKgzGrUvuOhuS4eygZEXNI8fHnGeuojQfbgY1UZgHzc0RP5366Qad2m0Qo/Lvyltum7MfkJFKBGGxFXpOb4NecfTJlNLvJ8dbNcKsiSaIYMlHF3EO1TF2U/GNyXua3njzPm1EMZ7+Ml+CqM8RCVnxyIj/vcaQdEaiT2xFGolaNpleQYx9MTJMegeTdZaRziElWdBoUw0DJsk00ZxErHMJolXQFVCQlEws64rKq0NccgaAJV68B9CsNMmV11Tb3K9Sh9E7GEi+WXSKyke9PFcZQUmjqttGtjJtK3SwlrRrjdQ9ozhWf3x6dt3ZjxbhS2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQiS7JnqBC3ixzQLvNaRyHi+KyMM7FsWKVmTNgicMeU=;
 b=AsmI8IpVtfAk3wdz6oB5gFUyNOe4C7+eo1WPycwJjKniJ5inJKSqBA9nNwpx61jYfgV4qek80TLvEHbE/oQpr5HZW+1utEewylxFXO8xgwSqulMwP7kjcHrqUesxWQeKIT2FVXuRegjZXEfmgeW9UKVefTmjq76ptCd1gN3LDvWRVumvkcxOpXIvpl1+IikixHyQZJ2eDEX7JswZ3+P8oMFCZohL5ngnkZvZnw9xWuXDGlf0spR01hJgLm03nE3+GLdCCpsmLri3aNhxG7aco0oPpW7s860jy4WcVlh5P4Lxm0bPxfCI+CmKkYdQLmvw1zUBQNevRns76YUOdHcmnQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB1665.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:12::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 10:58:56 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%6]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 10:58:56 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>
CC:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "kernel-team@meta.com" <kernel-team@meta.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4] module: replace module_layout with module_memory
Thread-Topic: [PATCH v4] module: replace module_layout with module_memory
Thread-Index: AQHZNNeu9tEplrAKq0WRjCl0zKXTeK64PbKAgAAepQA=
Date:   Tue, 31 Jan 2023 10:58:56 +0000
Message-ID: <1302e2b6-8980-e6e5-7433-6754634c98f3@csgroup.eu>
References: <20230130182109.3571524-1-song@kernel.org>
 <Y9jau76YwdCElzZ0@hirez.programming.kicks-ass.net>
In-Reply-To: <Y9jau76YwdCElzZ0@hirez.programming.kicks-ass.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB1665:EE_
x-ms-office365-filtering-correlation-id: 2eefd512-d050-413a-769f-08db037a2608
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JS4lDsVfY1umOAxjBTnLM0gpH+O1xPVIwwTil1EyJkxFzlUQMGztsN3gC9lvoe5d7oMMmzWqqj3rTcA9/NlsIbwnBdJGRL/BMDy554Nf/wqHFcYOakKAklxY1jzSPOuMAQLJa29S17TCfju3Zv1BXhbzWr5ppq55jj+yYouuzfgrIwiTm2hlOgx+EVBf6Fm5S4B85aOP3xaexkDSSqy/d7fnnBlz+YmgCJwqp4uzyk7b9ed1hr3wftpA4/VErM+jzWjsJXXZbNSTiGATCliK8cMZYcrNAKjzpVcQLu4RFKYzH0GZmpSCZDWxNSODC0937l7aJO/V/rMopklkB7hkQ05rNv082xdtf0KmlPPwLGBM8eXTcsPw4SKckPUunx69qDQ6UNGYbTGoPbOlEL2y+rPLbn2/g7MCcIQ8D3ezMSlMA1msU64+kCVOxbBM5usZ/0hGvPRVxyi2wu0JV0oCCmBSyR8QKZ75xGJYxybu0OLnPCsmDeonpsh84wmTfwprat+Src5ig5302HGl+Ru7JOx5A3Ettoscgcjuna+MkX8vBsZIzwkMxue+VZ1VM4a9O/fCXOGl0dPgr6ocQVdKudW1XJwn5NInFlG72pJ7RLxky1AbLNI43QHdw8Agaxvn+YwWxRBWzlsCgoPXjO6fzPyPgiYaUQ2OoL1tf9PI62TVJI5W400RoEW42dM/xkKk4V6V01kS1IbselU8qKg41oVNWLxjaRHVV5+GFaz0HKC58TllZMennXTIqJ3WYkoyGvvWme+tmL9FE+tOanQ+ZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199018)(31686004)(36756003)(66556008)(66946007)(66446008)(66476007)(64756008)(54906003)(316002)(110136005)(8676002)(91956017)(4326008)(76116006)(5660300002)(41300700001)(8936002)(122000001)(38100700002)(86362001)(38070700005)(31696002)(6506007)(186003)(6512007)(26005)(71200400001)(44832011)(2906002)(478600001)(6486002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHo5ajRZSG1iRVNyU05tOWk4NXA5b2JwTGxsdldpbVZqdk02NFFjeFdrclc4?=
 =?utf-8?B?ZVpyRkFtTlZuUjZZRGRvRythOGs1bCtUTW02UkhLbFZnZFJQclM3aVhiSTdt?=
 =?utf-8?B?RTFmNXBCQnc4UFBHR25zb2xJTzh2S05YRERQNGRld2kwVVhxTWFCRXY5ZE9r?=
 =?utf-8?B?dnlHUUFIa2xnczJmalpjR1lBK0YzTXhDN2lLdVZ4ZXFxVFBhMUpJSnZ1RFZS?=
 =?utf-8?B?bDFYa2Y3L0RJY3JwVENGdW5ZU0JJYmxrUTV4OEtQRWJSVGxHK3M1c0h6Y1NY?=
 =?utf-8?B?WUlnWlh2ZTQyT2lOQzFhSEw5L2dtdkNhMEErOFYrKzRJV0lhWUZYbUh5dGJF?=
 =?utf-8?B?ckFic05mYU9KMFAza2IvSGxsd1puRFFLZjFsMHJ2bHFnWjJudW80Wk9mYldY?=
 =?utf-8?B?U1piRUR2bC9ZeWp6eWI3NFRYYklKVzB1b0I0cTQxS05zMTFnUExPZjFhMDBi?=
 =?utf-8?B?Zm0vSHdFWThwZFJkUDBZTFREd0loUlVEdWNLR1RNMEJsWldOSGFFSjFpdDVy?=
 =?utf-8?B?NS9pUHZ0OXhUeFZQQVBEY0kxZDR0MytISU0xK21KVDlka1JFV0I5VGpZUXMv?=
 =?utf-8?B?VjYzV2o5SkpEMDZzTk1Ga3MzLy9HRmNUVm9KZ25mUTVLWnFRZ0R4VTcySjBw?=
 =?utf-8?B?OHVrcWtCN2RtdUhxdWdIYjc3UExyYmpjZm40NUNTMVViK3R1dW9vdXZiNFVQ?=
 =?utf-8?B?ekFRTEJ4enFKRDZUaFd4OFZHOFdsUUQ1THdWMXRVOGc2bG9ST0VsSCtWSzNx?=
 =?utf-8?B?K0ZXUXU0VGZxUHhWTDNkN3g5R3VGWks3Q0xheWdzWlowUWlEUlE4ZmtSTjYy?=
 =?utf-8?B?S0VwbXNQMWI3cmJSZ1ZCZWFiaHBlZHNMcnNxb2xsMVBvc3d2TnRna3dvVDhu?=
 =?utf-8?B?RzZ1RUpZa2dZczhod0JxaGRhaVgzY2lhWGlDR2ZLWVJBYmJIUlJyMnNoRjkw?=
 =?utf-8?B?a0IxMFZRVU5abGhNSjkwT1hxNGlWUjdXcHhZRU9jV3h6cmJVVis0S1dWb2Yy?=
 =?utf-8?B?aGEvRTM2dVRxbUZUdFJEUDBsdEY5bnFzbi9KWFdOcE5Wdkc5NWM4UVJoMG4r?=
 =?utf-8?B?VVRBdDRKelJDMzhpdGE4WGVTTERJN3NNRi9hSUtuZnJiT1dUdnlnWnRYMVhG?=
 =?utf-8?B?VTMwYVBhdkNzeG0wS1dkTXE0bmZtSjVlanJhKzAvWXFNRmt0K2Z4eUJkcEM1?=
 =?utf-8?B?R0JjR2k2TG9PZWw0K3FPZzZpZkU2djVzRDFVV29rT3Facy92ajRFRUdnaXIy?=
 =?utf-8?B?REN6QUY5YVM3cG1hQXU1Z3dTYllrZ2hoemd6RE0yZnpOeEdMemo2K0g3MWFN?=
 =?utf-8?B?TjByRWNOVUFsditLNXZOaFVIZWZnRlBTZ3EyaG5ldDd0ZGtPTlE3QWhPdzB4?=
 =?utf-8?B?ZmdKWVA5TXVBcVA3bloxR29OckhYM0k3VjZxcFgzYnhiWFplTjZ4ZEVWdnhY?=
 =?utf-8?B?Ly94Y1NvWmJUSU4vL3VSNXU2dFhlMTBUTzdnSmpTS2J6QVRIZCtCdTU1VzM4?=
 =?utf-8?B?M285bStPU0xnc096amxSKytza05pMS9XdytXZ3JIWm9aMDMvSnFacDlKbGY4?=
 =?utf-8?B?TWhTZk5oR0JqOTdxWkJjREw1Ymswd3RKWE11aWpSaHNMY1hlMW5Zb3hoK3Na?=
 =?utf-8?B?K3JMZjd1RStxT2ROelM1Q05qUWRPb1JFWk9YUDBvVlhSUkVNajV4NjZrcUF4?=
 =?utf-8?B?cXB2dFNaTllvSDJvVFJLdGJJSG5RQS9KQ3hybUo4TGtieTFUMTArWHkxMGZq?=
 =?utf-8?B?eEMyam85MlBEd0pUeGl2b2dETVlCY1BIUkJsWlZpcEpiTmE0NlVXV3dlS0lV?=
 =?utf-8?B?Nm5aWHVkQ3NTdXNxdnRWMWVqVnY3VVNZTHd1SFgzdk1UR1ZVYVg0Mm5PL3A2?=
 =?utf-8?B?WVZjQTkvQllGbnZWczJOalgrOUMvR3dLcmpmWUFmM2ZvT2czYnVRMHJTeVlV?=
 =?utf-8?B?OVY2eG14cGNPMW1VSXpQTmxjbmtMRnJNQkVYTXRXOVBXNmJnSi9jZHk4NXlv?=
 =?utf-8?B?bm9LY3VHbDB4Zk1XSGZlRUhmcG1IZWhmb2dGcEFGMHJsZ1NYdmFBb1Jvb3dJ?=
 =?utf-8?B?Wk1tWHJyM2txSjh1WEdvdW1sa1FxVVZwMmxYZXJPRlBETmNhVUtyTjBsSk85?=
 =?utf-8?B?L3R3aFVVY1lrdGNTQ2JacUlYOTZuVUFVWEY4emgrYk50YnhoOTJ1clZYK0xU?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A70A81998216A8459BDA2BB5BB4264B2@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eefd512-d050-413a-769f-08db037a2608
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 10:58:56.1570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QeAK7FbQSsv+C6SU8aVkQWaa5yW+ldiNcoNl/M6/xUZIijJxifrvFCL3iJ/NNRojKOiHQb2FUMxWP+riAAhGzc3RTLt2APofs+iocKV5MHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1665
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDMxLzAxLzIwMjMgw6AgMTA6MDksIFBldGVyIFppamxzdHJhIGEgw6ljcml0wqA6DQoN
Cj4+IEBAIC01NzMsMjMgKzU3NCwzMyBAQCBib29sIF9faXNfbW9kdWxlX3BlcmNwdV9hZGRyZXNz
KHVuc2lnbmVkIGxvbmcgYWRkciwgdW5zaWduZWQgbG9uZyAqY2FuX2FkZHIpOw0KPj4gICBib29s
IGlzX21vZHVsZV9wZXJjcHVfYWRkcmVzcyh1bnNpZ25lZCBsb25nIGFkZHIpOw0KPj4gICBib29s
IGlzX21vZHVsZV90ZXh0X2FkZHJlc3ModW5zaWduZWQgbG9uZyBhZGRyKTsNCj4+ICAgDQo+PiAr
c3RhdGljIGlubGluZSBib29sIHdpdGhpbl9tb2R1bGVfbWVtX3R5cGUodW5zaWduZWQgbG9uZyBh
ZGRyLA0KPj4gKwkJCQkJICBjb25zdCBzdHJ1Y3QgbW9kdWxlICptb2QsDQo+PiArCQkJCQkgIGVu
dW0gbW9kX21lbV90eXBlIHR5cGUpDQo+PiArew0KPj4gKwl1bnNpZ25lZCBsb25nIGJhc2UsIHNp
emU7DQo+PiArDQo+PiArCWJhc2UgPSAodW5zaWduZWQgbG9uZyltb2QtPm1lbVt0eXBlXS5iYXNl
Ow0KPj4gKwlzaXplID0gbW9kLT5tZW1bdHlwZV0uc2l6ZTsNCj4+ICsNCj4+ICsJcmV0dXJuIGJh
c2UgPD0gYWRkciAmJiBhZGRyIDwgYmFzZSArIHNpemU7DQo+IA0KPiBQb3NzaWJsZSAoYXMgaW5z
cGlyZWQgYnkgYWxsIHRoZSBhYm92ZSBpc197aW5pdCxjb3JlfSgpIGV0Yy4uDQo+IA0KPiAJcmV0
dXJuIGFkZHIgLSBiYXNlIDwgc2l6ZTsNCj4gDQoNCkluIGtlcm5lbC9tb2R1bGUvbWFpbi5jIHdl
IGhhdmUgYSBmdW5jdGlvbiBjYWxsZWQgd2l0aGluKCkuIE1heWJlIHRoYXQgDQpmdW5jdGlvbiBj
b3VsZCBiZSBsaWZ0ZWQgaW4gbW9kdWxlLmggYW5kIHVzZWQuDQoNCj4gDQo+IHN0YXRpYyBpbmxp
bmUgYm9vbCB3aXRoaW5fbW9kdWxlX21lbV90eXBlcyh1bnNpZ25lZCBsb25nIGFkZHIsDQo+IAkJ
CQkJICAgY29uc3Qgc3RydWN0IG1vZHVsZSAqbW9kLA0KPiAJCQkJCSAgIGVudW0gbW9kX21lbV90
eXBlIGZpcnN0LA0KPiAJCQkJCSAgIGVudW0gbW9kX21lbV90eXBlIGxhc3QpDQo+IHsNCj4gCWZv
ciAoZW51bSBtb2RfbWVtX3R5cGUgdHlwZSA9IGZpcnN0OyB0eXBlIDw9IGxhc3Q7IHR5cGUrKykg
ew0KPiAJCWlmICh3aXRoaW5fbW9kdWxlX21lbV90eXBlKGFkZHIsIG1vZCwgdHlwZSkpDQo+IAkJ
CXJldHVybiB0cnVlOw0KPiAJfQ0KPiAJcmV0dXJuIGZhbHNlOw0KPiB9DQoNCldlbGwsIG9rIGJ1
dCB3aGF0IGdhcmFudGllcyBpdCB3aWxsIGFsd2F5cyBiZSBjb250aWd1b3VzIHR5cGVzID8NCkFu
ZCB5b3UgY2FuJ3QgYW55bW9yZSBzZWUgYXQgZmlyc3QgbG9vayB3aGF0IHR5cGVzIGl0IGlzLg0K
DQpJIHByZWZlciBpdCB0byBiZSBleHBsaWNpdCB3aXRoIHdpdGhpbl9tb2R1bGVfbWVtX3R5cGUo
VFlQRTEpIHx8IA0Kd2l0aGluX21vZHVsZV9tZW1fdHlwZShUWVBFMikgfHwgd2l0aGluX21vZHVs
ZV9tZW1fdHlwZShUWVBFMykuIEJ5IHRoZSANCndheSB3ZSBjb3VsZCBtYWtlIHRoZSBmdW5jdGlv
biBuYW1lIHNob3J0ZXIsIGV2ZW4gd2l0aGluKCkgbWF5IGJlIGEgDQpiZXR0ZXIgbmFtZSBhcyBp
dCBpcyB1c2VkIG9ubHkgaW5zaWRlIG1vZHVsZSBjb2RlLg0KDQpTb21ldGhpbmcgbGlrZQ0KDQoJ
cmV0dXJuIHdpdGhpbihhZGRyLCBtb2QsIE1PRF9URVhUKSB8fCB3aXRoaW4oYWRkciwgbW9kLCBN
T0RfREFUQSkgfHwNCgkgICAgICAgd2l0aGluKGFkZHIsIG1vZCwgTU9EX1JPREFUQSkgfHwgd2l0
aGluKGFkZHIsIG1vZCwgDQpNT0RfUk9fQUZURVJfSU5JVCk7DQoNCg0KPiANCj4+ICsNCj4+ICAg
c3RhdGljIGlubGluZSBib29sIHdpdGhpbl9tb2R1bGVfY29yZSh1bnNpZ25lZCBsb25nIGFkZHIs
DQo+PiAgIAkJCQkgICAgICBjb25zdCBzdHJ1Y3QgbW9kdWxlICptb2QpDQo+PiAgIHsNCj4+IC0j
aWZkZWYgQ09ORklHX0FSQ0hfV0FOVFNfTU9EVUxFU19EQVRBX0lOX1ZNQUxMT0MNCj4+IC0JaWYg
KCh1bnNpZ25lZCBsb25nKW1vZC0+ZGF0YV9sYXlvdXQuYmFzZSA8PSBhZGRyICYmDQo+PiAtCSAg
ICBhZGRyIDwgKHVuc2lnbmVkIGxvbmcpbW9kLT5kYXRhX2xheW91dC5iYXNlICsgbW9kLT5kYXRh
X2xheW91dC5zaXplKQ0KPj4gLQkJcmV0dXJuIHRydWU7DQo+PiAtI2VuZGlmDQo+PiAtCXJldHVy
biAodW5zaWduZWQgbG9uZyltb2QtPmNvcmVfbGF5b3V0LmJhc2UgPD0gYWRkciAmJg0KPj4gLQkg
ICAgICAgYWRkciA8ICh1bnNpZ25lZCBsb25nKW1vZC0+Y29yZV9sYXlvdXQuYmFzZSArIG1vZC0+
Y29yZV9sYXlvdXQuc2l6ZTsNCj4+ICsJcmV0dXJuIHdpdGhpbl9tb2R1bGVfbWVtX3R5cGUoYWRk
ciwgbW9kLCBNT0RfVEVYVCkgfHwNCj4+ICsJCXdpdGhpbl9tb2R1bGVfbWVtX3R5cGUoYWRkciwg
bW9kLCBNT0RfREFUQSkgfHwNCj4+ICsJCXdpdGhpbl9tb2R1bGVfbWVtX3R5cGUoYWRkciwgbW9k
LCBNT0RfUk9EQVRBKSB8fA0KPj4gKwkJd2l0aGluX21vZHVsZV9tZW1fdHlwZShhZGRyLCBtb2Qs
IE1PRF9ST19BRlRFUl9JTklUKTsNCj4+ICAgfQ0KPiANCj4gd2l0aGluX21vZHVsZV9tZW1fdHlw
ZXMoYWRkciwgbW9kLCBNT0RfVEVYVCwgTU9EX1JPX0FGVEVSX0lOSVQpOw0KPiANCj4+ICAgc3Rh
dGljIGlubGluZSBib29sIHdpdGhpbl9tb2R1bGVfaW5pdCh1bnNpZ25lZCBsb25nIGFkZHIsDQo+
PiAgIAkJCQkgICAgICBjb25zdCBzdHJ1Y3QgbW9kdWxlICptb2QpDQo+PiAgIHsNCj4+IC0JcmV0
dXJuICh1bnNpZ25lZCBsb25nKW1vZC0+aW5pdF9sYXlvdXQuYmFzZSA8PSBhZGRyICYmDQo+PiAt
CSAgICAgICBhZGRyIDwgKHVuc2lnbmVkIGxvbmcpbW9kLT5pbml0X2xheW91dC5iYXNlICsgbW9k
LT5pbml0X2xheW91dC5zaXplOw0KPj4gKwlyZXR1cm4gd2l0aGluX21vZHVsZV9tZW1fdHlwZShh
ZGRyLCBtb2QsIE1PRF9JTklUX1RFWFQpIHx8DQo+PiArCQl3aXRoaW5fbW9kdWxlX21lbV90eXBl
KGFkZHIsIG1vZCwgTU9EX0lOSVRfREFUQSkgfHwNCj4+ICsJCXdpdGhpbl9tb2R1bGVfbWVtX3R5
cGUoYWRkciwgbW9kLCBNT0RfSU5JVF9ST0RBVEEpOw0KPj4gICB9DQo+IA0KPiB3aXRoaW5fbW9k
dWxlX21lbV90eXBlcyhhZGRyLCBtb2QsIE1PRF9JTklUX1RFWFQsIE1PRF9JTklUX1JPREFUQSk7
DQoNCkNocmlzdG9waGUNCg==
