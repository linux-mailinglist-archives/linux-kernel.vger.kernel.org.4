Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA013607075
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJUGur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiJUGuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:50:39 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11013013.outbound.protection.outlook.com [52.101.64.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDBD72FCC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:50:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AagnXRNfZjXEk2d2eTz4R2uMYfu/rneTJSZ6e7vO158aPAhWydTaoZyEENOOOHXD2NW13JqwuRDH1v1E9UhoLRyJCvCBwVRI3xCSGYMOgE5VW55Ri5Qeio/nwwMDcFFQbwvHzP4O2ZrjfNCLnfR7Hb25K/GRZgXfpE0LDWKiYIyiF5bQ3fhKhJZ5DjGfTrYYxDKq7eVI8qXBXer+5F5b8VZN2xZapcSroVKiECCQ+mv02vQi4lb3104zsZpUsaJd8fc3KfYH5xL4HUBljfp3/+LCTrktYQfu/bNwvt+9MYEZGrgRwxvD1R+D88aMa+5EpBmS+8oXQyFo9t3rulq9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeBwxetGg819yzhPcsQucQg9dF47EGyIU5jzipyQHkE=;
 b=E2iWdzqgnSRRbExK1rRBC4xAw8JsNCrUYNAIiambr+TBl42Z0L71USr62EcLDZS6UjGjhrqrCv9KD3r2f2OcbLMWjQPo4BffHcweGUh9363+BCV3n9kV7pRxMTyRAxXg+WHOMZHbZ3xSaJ0to5x/CPTcb4/9mUjlEbBYslufsGGF0CKPPPOKQugLIf8cojMLM7CTziF7R0jRGn6N2YW+TdPkCScx/DB3Ir2OCWeIrG5YvETmbWsndpzBD14r6JcPZz5XjEudRRZp9X7sCXyZWkRBcGxjswy9tNJXP0fXZgLAmgNVx9z7E8GXM0AMDzBfyjMz7Ydi1kJrsSloMORt7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeBwxetGg819yzhPcsQucQg9dF47EGyIU5jzipyQHkE=;
 b=j7FeEWV9QIgH43jKxHd396d7I/2dGMl6WExcXaERI0a0bZNz0cx7wcjvrDCHqjeG/O3jUUT2e7l5yU/8w8cf6IjnZ616HvF7v8WaXT8+tk6ImXNPxihdrjphfIBdL45cxQI7vbL9VG2YSb9LxllsZU4CaSl+9kTVDCDidjURvUY=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BN7PR05MB4195.namprd05.prod.outlook.com (2603:10b6:406:90::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.14; Fri, 21 Oct
 2022 06:50:33 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6%7]) with mapi id 15.20.5723.028; Fri, 21 Oct 2022
 06:50:33 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
CC:     Pv-drivers <Pv-drivers@vmware.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "kernel@openvz.org" <kernel@openvz.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 6/8] drivers: vmware: balloon - report inflated
 memory
Thread-Topic: [RFC PATCH v5 6/8] drivers: vmware: balloon - report inflated
 memory
Thread-Index: AQHY46Ei2elIbCkDckOp2+Pbz7tY8K4Ya5CA
Date:   Fri, 21 Oct 2022 06:50:33 +0000
Message-ID: <39FA848F-290D-4110-B27C-8822377E6AA5@vmware.com>
References: <20221019095620.124909-1-alexander.atanasov@virtuozzo.com>
 <20221019095620.124909-7-alexander.atanasov@virtuozzo.com>
In-Reply-To: <20221019095620.124909-7-alexander.atanasov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|BN7PR05MB4195:EE_
x-ms-office365-filtering-correlation-id: fc36f9bc-1258-4c3e-b93a-08dab3308cf4
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wj91aMQud56DACBcmSrT9xysLHcBArCXgtE8bLHjEdDTg5HKnTEEKb1olFnERHXHSMWdRQS7BqxzcwYAFw30ywnu5DXtXSMNOSG357N7VdDy6tVE6Vj8+7QxN3iQaHGkzEUbb4Yon13065NrxlgkeJoTp3WZBMddKXmbyNhlWDv8ColOpy1IUwIlpm/k/JTXfPHR8Zn4ykdpTSWiG1+VI4ARPuzFEngVHVvuEV/cGICcXn1/ljBU4fW6aNfBjiPLIGGMuDMbq2GpnBb/e0i//OT7wRjNGomrhpQAM0QzoVsbYCxi1nQqocexrdsEEW27+y0NFUw1a0Y5Oi6yCnL0iliuQdFQH+Qc3daklHOMNhvmSkAqkWFZnoCIuhXpSlQzVcPpd4SZVwLKSpXXW6Zi2sNiEBotbKcbgcqWIATVSdAW4Ywk6fBBeW4rkoQSnxZVW5bpKzWg1pJS1S/6R7DbpQJ2IRE05cWwupoqkAyPym4uVWoYZp//3EJeAVc2oE3p4X2FCv3N3yy/g0ysMqCHxb0JzQP8mAYsNtkWYxXDCyZtY2JB0VosKc6cSOh+tL6e3cw9+kFVqPMnbgz7ZU16fJz+a0G3xCpgBwoDKoNI7kW5vDco6MfBxpXNP4SXOV6OiU/n+SHl9/eXaJ41XQkrlriRgY4DRrk1MI7GDg+d4iAHCRjbiR6RB8v2Pu/yi6siOQqsRS8J5E/fyp4kHEGOz7PnbK2z4ZevbD+KJWKow5+O40+uNGBSlQwJFQrveYJJ/8O8mTJX09EGxCbQqYikGsW1wKp/Z3qZVFED7CfcNCi7Yx68UxH9LPEauzVWaP2wrxkltjDeXR6f4GR7duvv1SjNs+get/fwOsYukTTna5Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199015)(86362001)(8936002)(36756003)(316002)(2906002)(38100700002)(71200400001)(122000001)(33656002)(6506007)(6486002)(64756008)(66946007)(66446008)(38070700005)(66476007)(6916009)(41300700001)(26005)(76116006)(91956017)(4326008)(66556008)(2616005)(53546011)(83380400001)(8676002)(186003)(478600001)(54906003)(6512007)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1VYNWoxdkFRWjl4aVduV2RTWUZoNUhSSmpFTmNxNTJvL2x4Qm9aRGNyWGJv?=
 =?utf-8?B?NEtOOG1CZHcxZmJuSzl6UEhWdUJzQkl1UWUxcElWbHRTc0p3SlF2SjJud2Ux?=
 =?utf-8?B?eko4aitxazVjTzRoYjlxK2dqdU5NVi9aQ1dIYjVxbXBHYTJIVXlaN1V3bnRs?=
 =?utf-8?B?V0QzUmZmTDhpbVBkUjRUTFVFaGhPS2tRSHBDUGN2MTFjRTNQdzVIWjQ3aWd0?=
 =?utf-8?B?aFFreE1ONkxYbzBQVXppL0xMdzZSZ2RIQTR6YnJPRVBCTFhKU2RUU0g0cUc1?=
 =?utf-8?B?UlZySllnOWxOT1NWQTFTcEk0UHF3WllZakxXTUxxNzFML1UwNTUrS3AyUmVF?=
 =?utf-8?B?K0oreU9UZ2wzaUJrUzBKVzBHeU9VSGpmWGFveEZQelRaVmlDL2pBUW1OMkhL?=
 =?utf-8?B?Q3lSc2hPaUc1bjJXSHhrVEI1Q3NtVjNzM3l1S3ZUZzlNb1JHSFF4d1JMS2ZU?=
 =?utf-8?B?VHlYemtjaTlTSFI5RldGamV4U0k5QWZkU3VYMlE0WTRJeSt2ZDd4Tk9xanJL?=
 =?utf-8?B?cnRLQTNzVWxjTmZaRlJaZVo2OGxTVyt6RytRL3k5Q0EzZWtSZGFqTXRZMWxv?=
 =?utf-8?B?ZFh3YmYxd2J1T21UZWJNRWo4dnRpZDI5T05oTVJVYThvMU5WNE1IeFRZbTlX?=
 =?utf-8?B?OW81bWxZRmR5UUZhYk1ibHZVb2MybEF2N3o1MWY2UmczREFlcmh4Q1NQYWlh?=
 =?utf-8?B?VVdxaDRmN2kwR2dqYjRHNVhxbS9OK29rSjBxOFh1ZTJab3VmN2RHK1VoU1A2?=
 =?utf-8?B?cGczR1JaU1lreWMwVnM1WWFpODJRUGdXN3NuTXlydlhETXg2ZjlBbkgxZVV6?=
 =?utf-8?B?NU9iOVlLemxlQzUzRTl0MkwrQVB2K0NmaHlsOTFZWEZ6SXlLTHNjRVk0V2VV?=
 =?utf-8?B?VW41dk8yY0JHR2NWa0RmNnoyL2RXRkd3Z3Y5Mk1XNXk0RTc4Z2xtN0o5VXpD?=
 =?utf-8?B?M2ZZQS9ENi9VVTEyUWJ1THRMR2ExZ2tmSXhaWHJjQ256OFF5c1VDZDdTMWMy?=
 =?utf-8?B?TXI3ekFUT3B2blgyVU1qOVRIbTVpbFIyNURzZjQzSjVoQTRtOTArM24xV0FS?=
 =?utf-8?B?dHFvb2Q1aXB4R0Uxbkg1aURpc2gwcm9sKzNVOWZuNlBYRnlEZk1VaE53ZjAw?=
 =?utf-8?B?bEJYOGQ1SlE1OGROUUxjRnRMOGtiV2prMzE2UitObzMyRWNMRlkxUHpjaEpW?=
 =?utf-8?B?MmluZlppZUtYdDRwWjNUYWphV3o0V1d3LzNubEZOeGVmeS9SYTdreGVVRWEw?=
 =?utf-8?B?L01SWHQxU3NwMWRvckNVTTV6aFVnNE9iMTdsbndVdk9xbjlybzZidjRrV2gw?=
 =?utf-8?B?Zy9YQU5STXovWEU1YlJ0ZU0wUlVObURBZG15OTZPVG1uREREZXVQb1U3eXNR?=
 =?utf-8?B?YnpGTEgrV21uYVEyYUljUDRONDk5YkdRSnBEemRQaWNKc2FFTThvUm9wSE55?=
 =?utf-8?B?TXBlQ0pRQitTbEJPSERlQndwTFkxblVvOWxJcjlhN21tVHhHdEw0S2NOeGJO?=
 =?utf-8?B?b2ZLVDhycWJUV3h3M2ZtNklQclZ3ZHBSQ3AvZDRlVVNOVE5Zc2VFM0hobnFo?=
 =?utf-8?B?dGY3NjZVdHZ1cUpsS0xOUnZwSVZ2UU03emQ1NFUrc2JRRTg4U0RLSlEvdktT?=
 =?utf-8?B?RnBWLzhWU2VZUjBCV2FQbzV5c3IxSFFsZ3lpeGV1T0tjNzdoalhNVlprejkw?=
 =?utf-8?B?TGJNSGJYc296TVBxKzM1KzVIaDB1TUNJdmZwYnhFdEdzY0ttZzlCWHVwVUxZ?=
 =?utf-8?B?TDM1UU16SEVDMkJod3QrcGQzOUpmQitNVDlwNlc0Y2M2WVFyN3ZMWjE2YVhV?=
 =?utf-8?B?dHZzOFVkZE5DZzNPbXNSM0pMcmlnWkduNWdZa0hHSHhic054Snd3YzlKbUJw?=
 =?utf-8?B?MlVTTXlHa2VOK3VtTS8zTk9qUiswWjc5cGlqWlA1dVRTTjJCSUpJNzA5TkFO?=
 =?utf-8?B?UUQ2eWhENzZaaVhXbUI3aXBXejRRNHEvTm1YZWsvVytaeDdUajlUN0tEZjFa?=
 =?utf-8?B?R2g5U2hIOENQQ2lzcWRMSVhaQ0dua1VMK1BSQ1NuUlo2Zzh6Mm5MY3hXM2t5?=
 =?utf-8?B?d2JwbTBFNi91V2tidU1pV1ZNcnpNR1VTbGFCSVd3WjhKb3FWZ2d5c09DdXNl?=
 =?utf-8?Q?2mvXnxeT+QYEuH3EpJYO5Xno8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4AB2BF46B21454BBF08D9C65A8039DA@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc36f9bc-1258-4c3e-b93a-08dab3308cf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 06:50:33.0840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYfuXTWHJhxojQ4wzlt2EOtUD2cikzFeXNqKGToAmZ1f88L8NFzu+XITeET1Z0RdOmUW+59Gwzi2LQLxwEj3YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4195
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gT2N0IDE5LCAyMDIyLCBhdCAxMjo1NiBQTSwgQWxleGFuZGVyIEF0YW5hc292IDxhbGV4YW5k
ZXIuYXRhbmFzb3ZAdmlydHVvenpvLmNvbT4gd3JvdGU6DQoNCj4gVXBkYXRlIHRoZSBpbmZsYXRl
ZCBtZW1vcnkgaW4gdGhlIG1tIGNvcmUgb24gY2hhbmdlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
QWxleGFuZGVyIEF0YW5hc292IDxhbGV4YW5kZXIuYXRhbmFzb3ZAdmlydHVvenpvLmNvbT4NCj4g
LS0tDQo+IGRyaXZlcnMvbWlzYy92bXdfYmFsbG9vbi5jIHwgMSArDQo+IDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy92bXdfYmFs
bG9vbi5jIGIvZHJpdmVycy9taXNjL3Ztd19iYWxsb29uLmMNCj4gaW5kZXggOTFkNGQyYTI4NWM1
Li4zYmZkODQ1ODk4ZjUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWlzYy92bXdfYmFsbG9vbi5j
DQo+ICsrKyBiL2RyaXZlcnMvbWlzYy92bXdfYmFsbG9vbi5jDQo+IEBAIC0xNTA3LDYgKzE1MDcs
NyBAQCBzdGF0aWMgdm9pZCB2bWJhbGxvb25fd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmsp
DQo+IAlxdWV1ZV9kZWxheWVkX3dvcmsoc3lzdGVtX2ZyZWV6YWJsZV93cSwNCj4gCQkJICAgZHdv
cmssIHJvdW5kX2ppZmZpZXNfcmVsYXRpdmUoSFopKTsNCj4gDQo+ICsJYmFsbG9vbl9zZXRfaW5m
bGF0ZWRfZnJlZShhdG9taWM2NF9yZWFkKCZiLT5zaXplKSA8PCAyKTsNCj4gfQ0KDQpJIGRvbuKA
mXQgbGlrZSBpdCBpbiBnZW5lcmFsIChJIHRoaW5rIHRoYXQgc29tZXRoaW5nIGxpa2UgdGhhdCBz
aG91bGQgZ28gaW50bw0Kc29tZSBjb21tb24gaW5mcmEpLg0KDQpCdXQgbW9yZSBjb25jcmV0ZWx5
IHRoZXJlIGFyZSBhdCBsZWFzdCAyIHByb2JsZW1zIGhlcmUuIEZpcnN0LCBxdWV1ZWluZyB0aGUN
Cndvcmsgc2hvdWxkIGNvbWUgbGFzdC4gU2Vjb25kLCB0aGVyZSBhcmUgb3RoZXIgcGxhY2VzIHRo
YXQgY2hhbmdlIHRoZQ0KYmFsbG9vbiBzaXplIChlLmcuLCB2bWJhbGxvb25fcmVzZXQoKSksIHdo
aWNoIGFyZSBub3QgaGFuZGxlZCBieSB0aGlzIHBhdGNoLg0KDQpJZiB5b3UgYWRkZWQgY2FsbHMg
dG8gYmFsbG9vbl9zZXRfaW5mbGF0ZWRfZnJlZSgpIGZyb20gdGhlc2UgcGxhY2VzLCB5b3UgY2Fu
DQpnZXQgcmFjZXMgd2hpbGUgY2FsbGluZyBiYWxsb29uX3NldF9pbmZsYXRlZF9mcmVlKCkgYW5k
IHRoZSBsYXN0IHZhbHVlIHRoYXQNCndvdWxkIGJlIGxhdGNoZWQgd291bGQgYmUgdGhlIHdyb25n
IG9uZS4gSSBkb27igJl0IHNlZSBhbnl0aGluZyBpbiB0aGUgbG9naWMNCm9yIGNvbW1lbnRzIHRo
YXQgY2xhcmlmeSBob3cgc29tZXRoaW5nIGxpa2UgdGhhdCBzaG91bGQgYmUgcmVzb2x2ZWQuDQoN
Cg==
