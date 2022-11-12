Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E76B626656
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 03:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbiKLCGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 21:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiKLCGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 21:06:47 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2080.outbound.protection.outlook.com [40.107.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25D7B7B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 18:06:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HG/l4wl7Nz0LJb/eWq12uMgRlU2u5hwrMDNcyITQVg5aeq5uJz2/Q2OuoSwpJugHzwkkJ/L3yJ1T6T7DvbIOIgDXRQbQIW/H+OhDIHKNscD3+oQU0X0mooHCobfYZiEXClkfJ4a6XUige1GCL0sWD5Vj9TjJVwejSi56wsYmD0LySGueUMOMe27mlcST+f950XkvQPY5VrwphMgm3XNXGzQ6K2mtfzxhdl59A4eGaVsmxwzoqoTfm/UuQJykToYWJHW1hIcoa0QnkYF5jjRklakUvIVkDPCOB+98v47YWBt+iK2+gekdZ2VCDoFU035jKOahzMgv35alyCzwgWFfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1OFaUNEOvVBzHkLZjIDR0G6ZfkFn4aTlKboOOtSv1w=;
 b=EceybIyGf+xPmtTUxswC7n9URJAYrehvje+y1QjgHXuYvCZIU6nPrKj40VH5TRYNk0/5dNAasPkB5mOE2ZzF5Nto5VtTBvLw8AMnNyUKqrjFC3SQGCTvpJLCLayt+kS2qaN7dmWckts8Jt9Kd0dLgujhJGPycVh8JC/pdepiwJJC6KK1ggObY+4lAJoYb/z1xRHzZY8oo9WiE2rUUa5Cl6pyiiWDOuv0Qkj8M+9utI2OQgCKF7LYi7y2Ix20/hwpHEKrXlcUULSRrTZ3QN2iSjHvEnAbQh/YEoJLmyXew9Be8VUqTNzNPVx0FAsXL4FZQAGbRkAiNz3NQebGUqGdNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1OFaUNEOvVBzHkLZjIDR0G6ZfkFn4aTlKboOOtSv1w=;
 b=XYdefkouKlCR4w0D2StyW6NDIsLLX3QX9ghLpyfmTAApBrH+0ukN1RKRWr4Wu7OLWgxdgq5M8rDNqo5XVdlGi2LLPXTc1zWlm9MtAMkrdOEG6cjw7dVBwLOmIM1gvj18j5bWB6HdAK4XVWlFOKBl/+uHFD/Cb4LdaWSfjpilZSlJ+u1vbrRgvsxewNTnZDWDSrvel9J/KNoBggjO+rDDSnsUX9h307k42WONfqgvHS6Ar7E7562IPXmnbKh3a8buG2OBJ4+Iixqk0Qr73+YgXkNSgVFm2dD8RIKL1D3VGDDn59cg++wIoO9zQC4Y6FWWGQO9sNhSRd4vp7Hsp2dMYA==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by TYUPR06MB5926.apcprd06.prod.outlook.com (2603:1096:400:359::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Sat, 12 Nov
 2022 02:06:43 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::3fde:75ae:e50a:7b24]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::3fde:75ae:e50a:7b24%7]) with mapi id 15.20.5813.014; Sat, 12 Nov 2022
 02:06:43 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] genirq: Remove unused parameter force of
 irq_set_affinity_deactivated()
Thread-Topic: [PATCH] genirq: Remove unused parameter force of
 irq_set_affinity_deactivated()
Thread-Index: AQHY2jgqFSz49XCrkkSldkduhwXlY646PVgAgAB9VEA=
Date:   Sat, 12 Nov 2022 02:06:43 +0000
Message-ID: <TY2PR06MB34244F5E7353682050F6B90785039@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20221007103236.599-1-angus.chen@jaguarmicro.com>
 <87cz9tcqg5.ffs@tglx>
In-Reply-To: <87cz9tcqg5.ffs@tglx>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|TYUPR06MB5926:EE_
x-ms-office365-filtering-correlation-id: 3401c8e3-b6b2-4330-727f-08dac4528b5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cn77CsnKBzmFW42xk0NU3P10/54fAD+BfByUgdkXHXtRpPm3thHPckNu37lk5ypUx1AlJOaTu/PdUi6aam0c1PFdMI2/kuvLmNG44CP5OodO78SdfBcsgT1vodJo2a2bkd1oKSB4t1kNZ9syc5VKaoEbk2jrIA0nZPTp9suwEbeuVpBREwqEgO0wUM4E/i3PBAexIgTrlLGG9nydOeWrdKXnEr68EAVvZ2JUSAGE3Rc4mTGmmDi2vo7bE67CoAOoS0KuV3xiOmcSTCIv6E5VGSjO3mFMaujWO4kUD63+AI1VuYO3a3OhSV9kDwOLgTzIqcHNBTPwQuHiP9tj/ytsNYq3RRBe1aynWi7UKVW8pMIqKfwTI3a3bCDmQL/iqzQ2fezTPugJPRWs2MyQ4ExFPhB4dFpJ3uIbjHM9y4MGk9hBPan2qQThKw7B/qPhep1YbP7wKtA5Bs24j/qdsDLPJOkm6ec7DPy09TT1SpThrUI9Sp3CpxY4hC0scCCBCq7fvXoB2JFYW00884tsx2QDkRG5fYiPn3kEpeiVJ1FxxcwdrcQRZGTdjlZgITICrNnArYJvw+p5kLyLQ+e0WRWvvSIbwoVDS9SLDlDtjR9YSgLNjeNE16MN6xrTDvXID7hdirdxEUHfHU/GskOQOY4I9hVkx1cijJPTWETGwMYxXyvxkzd3+dMhBZ8oNrHDWFhZZzgx/p5rKgPosHCXp/B6DGz7xtpd9d+O/HPVdAUYqDuOWzcfumvPYNGrjB6F6aNbbkj9fUhXXn+dsJD9H+6/fg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(366004)(136003)(39840400004)(451199015)(52536014)(38070700005)(86362001)(71200400001)(55016003)(83380400001)(9686003)(38100700002)(2906002)(33656002)(41300700001)(6506007)(26005)(122000001)(53546011)(7696005)(8676002)(4744005)(186003)(64756008)(44832011)(66446008)(66556008)(66476007)(478600001)(4326008)(66946007)(6916009)(5660300002)(8936002)(76116006)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjZiWHhPNUNKckVZRTcwL0t4SnNjT0pJRVo4Zy96eEM0K1RVRVptTnFSM1Fu?=
 =?utf-8?B?YWVmd2F0VGpwSGF5TFNmR21NdlI4YU5MNzFKTktzNTRpanpsazBTaGRHdjlv?=
 =?utf-8?B?bWZhRnRmcXgzcEF1cklPRE5PNC9FdVpDbldiQkZLMHg0UHhOMTN2SkpNMFBE?=
 =?utf-8?B?NzBVWnk5RXZWOHAzWFU2WnkyN3Nzam95akg4US92VGpYVzgzVGdLd0lLZ1p5?=
 =?utf-8?B?M2lqaFBBVTJCTm4zR3hNTFpSZHN1eFc0YytENWlYOVZZK2czWU5TRUVoMmNV?=
 =?utf-8?B?cDBYUC9OdGZlazhuMk9nL3dkWElyMFUrMG5GNStjZ0dLNkE5ZGVGT0RHRWs3?=
 =?utf-8?B?aTFSL0dwUGdHUmdSMWRHTkpFTWhJekdLT01CUzlyZDRJbmpDelRTY0orZTkx?=
 =?utf-8?B?NzNTa0tYcTdQT21Jd2FJWStsekRVWmFUV0M3eCtuQXpzaGZ3aS9aSllMZnFy?=
 =?utf-8?B?dTRCZXFoY3VkTmp2YWlpbU5sZUluRGVNRkVRNk53UlZhN0ZyZkEvd2Z4M0lG?=
 =?utf-8?B?Y0RUaTgyNThlWW9ROE5uMFJ4dHhUdFEvNEo2S0czSHUzUVRDODdBYmN0dWtx?=
 =?utf-8?B?WW0vaVJnOHFrTndKbldFaGJINlZERHpBVHhCSnExaG5rSi9HUXJVR1FYRVh0?=
 =?utf-8?B?b25zQzJHbU1sYWRtbUNLQ1J0QUxCNkpKVFhjelFxa0RCSWQ2N21xUGdCdWhK?=
 =?utf-8?B?SGx3RW5DbUcrcGp0WEovTTQyWUxjMnR1WkxlNFVSRDl5MlJuUHRobUdqQ09G?=
 =?utf-8?B?Mjkrd1QyNlI5YVRMaFZDZ09WZ3lqT052Z2NNRlE1R2xxMDlENVFRc2dWY2hU?=
 =?utf-8?B?OHlERS9CdjZSVFVqYk4yNUlHV0Ixd0VSemZHOTlPYmlnMnhCVU5pWWFINUZN?=
 =?utf-8?B?cS8xQUpMbjNjb0MwT3dEMDU0LzRPVFVNd0JsNy9uZzJFQTgvcFZKYjNCTEpy?=
 =?utf-8?B?a2VBaThMbWR3eUJHZ0lJMEl6VngrS0ZKRG9mSW9laFQ5aGdJN2tqdmlTcEFS?=
 =?utf-8?B?Q3RRTjJZOGh2RW1uUER2YUpDTFQ3bGxIa0l3UElLcmQrd1dwZlI1OHY2Ylk2?=
 =?utf-8?B?eUpVUnBUay84dHZsNWNkNlI5bmdQL1Y5QnBteE5iZXVTMlFXbDRsenBKMnZy?=
 =?utf-8?B?ZXVrUDRHNzFiRUtNQ3ZKTFNreDEvc0hIOStzY1Vsblh0cUFRR1JzaEVUNXdx?=
 =?utf-8?B?Q2xmS0RGTWJaYXVSVVRic3IwL09HdC9ZWFdtc0pwRzNKUGlYR0VXcmROTXMv?=
 =?utf-8?B?OFNKcTFINkZTbTNXOEpXRXF1MnJTVEVMUG5pd1dJSGdLcmMveUZkSUVmUURx?=
 =?utf-8?B?OFZleldiZXBPa09pTkhhRzFUL1drQVNPVU84bFlycjhQUDBSaHFoaTFVN1hR?=
 =?utf-8?B?S1pLVTVHcVQva0JRYTVNWHNTVmlYcldmOUplMFBncUdxa1N2Z3BoNmoxQWZo?=
 =?utf-8?B?d25PU1Z4anhJcEpSTWRuY2U2NEcrR3UyU1VRSWZEVTlmUkVwbVR4NmRHc25D?=
 =?utf-8?B?QnpSKytGZE82eC9nSmEyaGFIb3VwVmplLzZNTlVtN2FOVGNFL3E1N2VQeDZF?=
 =?utf-8?B?cUtCbnU1OTBuY1FlZGlEY25NMXN0djlabHpLMFUxVi96bmxCbzdONzhSeHBN?=
 =?utf-8?B?Umx2Ty9ZZVFSRjZlUk9jWExmcTZ4NkRrd1dBc1l5RWtIalVmNFBHUWZLN0ZX?=
 =?utf-8?B?UkM2L013cEJteVVvNDlYWUJOSlZPQ3RUWG5JbWIxdHluQkxWUVFmRHBQODd4?=
 =?utf-8?B?V2xYZVJ6USt6TzVBU3luZjRjZzJlejZaZ0RFdkp4c3FySE1Nc0t0Y3FzdVhE?=
 =?utf-8?B?Z3Ftb2dHYnpoYnE5UlJjYnhMem9pYjNZQ1ROK3REalY5Z3hKZk9VY0V4Znhn?=
 =?utf-8?B?bzEzN3VJeXczdGx5NDdyajV1anN0TC9oK3ZNMllwZElNODFXNm1MdStSZkkv?=
 =?utf-8?B?dm1VNDVlM05RODNtRytXcGxxRmc4a3VHWEs2OEJJaEczYVFLMlhJQjM2V2lm?=
 =?utf-8?B?Q0RSN0o3VGRISXFCME1WSVRTM0duRWdwNGYzanB1M3FFbkJ5dytUNlpMM1o0?=
 =?utf-8?B?aWZoeHVnaElLK0JhU2hHREVEaWpkcHVhblBDUzUwMUNvMjVscCtGdG5NRUJF?=
 =?utf-8?B?Q05sN292ckErdThSSjVCNGVsamN0L2M4UzVoMm11Q0ZJN3E2d0cranJiUE4z?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3401c8e3-b6b2-4330-727f-08dac4528b5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2022 02:06:43.0709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SwF1N4XpznCGxuxagHG3i/v9Sb4G0wLXYctm7ApNShH2Q7ab3iRtdb640Tz3D8uKbSyp8hoxISvyrVL7GWIYYhWI9HDA2+rfqE8CkcYIEV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5926
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgdGdseC4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMg
R2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2VudDogU2F0dXJkYXksIE5vdmVtYmVy
IDEyLCAyMDIyIDI6MTEgQU0NCj4gVG86IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWlj
cm8uY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQW5ndXMgQ2hlbiA8
YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGdlbmly
cTogUmVtb3ZlIHVudXNlZCBwYXJhbWV0ZXIgZm9yY2Ugb2YNCj4gaXJxX3NldF9hZmZpbml0eV9k
ZWFjdGl2YXRlZCgpDQo+IA0KPiBPbiBGcmksIE9jdCAwNyAyMDIyIGF0IDE4OjMyLCBBbmd1cyBD
aGVuIHdyb3RlOg0KPiA+IFRoZSBmb3JjZSBwYXJhbWV0ZXIgaW4gaXJxX3NldF9hZmZpbml0eV9k
ZWFjdGl2YXRlZCgpIGlzIG5vdCB1c2VkLA0KPiA+IGdldCByaWQgb2YgaXQuDQo+IA0KPiBDb3Jy
ZWN0Lg0KPiANCj4gPiBGaXhlczogYmFlZGI4N2QxYjUzICgiZ2VuaXJxL2FmZmluaXR5OiBIYW5k
bGUgYWZmaW5pdHkgc2V0dGluZyBvbg0KPiA+IGluYWN0aXZlIGludGVycnVwdHMgY29ycmVjdGx5
IikNCj4gDQo+IFdoYXQgZG9lcyB0aGlzIGZpeD8gQW4gdW51c2VkIGFyZ3VtZW50IGlzIG5laXRo
ZXIgYSBidWcgbm9yIGENCj4gcHJvYmxlbS4gUmVtb3ZpbmcgaXQgaXMgYSBjbGVhbnVwIG5vdGhp
bmcgZWxzZS4NCj4gDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQpJIGFsbW9zdCBmb3JnZXQg
dGhpcyBwYXRjaCBiZWNhdXNlIGl0IGp1c3QgYSBjbGVhbnVwLg0KSSB0aG91Z2h0IG1heWJlIGl0
IGlzIHRvbyBzaW1wbGUgdG8gc3VibWl0LA0Kc28gaXQgYmUgaWdub3JlZCBieSBtYWludGFpbmVy
Lg0KQ2FuIEkgc2VuZCBhIHYyIHRvIG1vZGlmeSB0aGUgZ2l0IGxvZyA/DQpUaGFua3MuDQo+IFRo
YW5rcywNCj4gDQo+ICAgICAgICAgdGdseA0K
