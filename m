Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8522970B414
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjEVE2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjEVE2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:28:21 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1E2CF;
        Sun, 21 May 2023 21:28:20 -0700 (PDT)
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M2NPj2003815;
        Sun, 21 May 2023 21:28:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=EnoLrNHvfrHERh04j9ThjsUX3dVXlmpqR0k6RYN5HCE=;
 b=CJYjBg6V5nvJxD0xOB5d9TR7clagd1VZ9tufOEI0sjihP8D2xxUN0U+JaQQ5R5d2aNPE
 JOTI/1PJFiDnxrD7Zb2AQgZKR0VW10VMdqolko5wIBm6pz7c1K7FMqwgBNiegj77nHnF
 WAjokkaAZ+Luq/7pt4qPoMV56fm0XJGBvJFg5FUyPpEpI0fyfG0NoNJ6UfY65Idqj4Qv
 XB2J2sZwRKGj8hNir3V+8Vhs2eXrZfx6Lvfvpg8B5RcS+GH5gIG1OmRF1YlFoZ5hEZEf
 ApS831D9uelbmHLYOR+MgrNwWKJp9wT5Bzk9p7jOcbGcdQ4+qc8b+rNZlBzzXYpbm8Wu oA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qpwrva90q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 21:28:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7HHRAfQOWiI4ZebwbAui6He/p2bnsKzt1hKhRUJYgfWM7byh9riSmR9YvnAKymZ9ZLXZTtdPKFIjnLGxJXN4pD+CWtq/3TVFNUtR7R+y8EKijWM1ZwrfQTfdnUDjwOdAQjz6QLAYgmmbbl3b9wAyi+T8sKH4jxXJss/GpvWKx8bzje3az2bNXxHwuzOq5VNFi8DRmsHQu7WoDMxQfjWSUqlziBQ9vDHoT855aPcLqgO4lVyBsapi1lVRj/1/WRieftK6TP0hIF7Zcgy6U508BrUUrIQpuqWoYfHsWlOOiNbmwj0fYMUjLX9pGY6aOYwO7zznIcjf5dJI+B7UVB9Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnoLrNHvfrHERh04j9ThjsUX3dVXlmpqR0k6RYN5HCE=;
 b=XIVhWPRjYeZobaXa2fpkwKUQrHa3SnuOozoV3FLM+YPn9EmU4324knY9cKtDX/TywG+sn4/pLtsViiR5Mq3hPh10wWmsxe9znZlISKPqUrSWoBqEXM+LsNGe9m0Mji9Ax4wYNLLyiwq3fpKwL7Mh6xmJwc+q6GBNiJoFevSNDqtpoSQoyirNmTdVvRKGO+TQioMxpbjUtKsPxJ6SQirJTwwRrwdaD89sBaG+dXwec7Yhi/w4WPep0kko/239glQc5lF52c+D7MvEW3rpgk7y0cTbCNSMK+WAgiakrkPrbhdUl/tcBro++QB+W/b923BWjdBNvh0bCejPr33UMxselA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnoLrNHvfrHERh04j9ThjsUX3dVXlmpqR0k6RYN5HCE=;
 b=dFqR4OM4I4M8rbxY8n7EwX4yTnl9IAtwv1RXH2iy6fwE+/kYnDi2AaI8ZVpBoX5flKbZAZ5s+8VUUQwBqvYoViOY6r2jc9XN6LXwqKwqE51JsjZr1FNCV/CNlyamMHKfj3/xYSdGs2Eq0ZwAOSugWrdVcihvl5PhP3NXYh5IjPbBxsJGkP40MvwG+BZlP5KX/HTydAhSCByL+AIZ73tKGo0ZEY/sFLhfSCiP+4JMt++md+ChQTc5j32jh9EZF58hhlyCTa4Dag41UOJE/s5ohsyhuIeCinyfpqP/qv0jAJ0RW/sUp8QsaIanILy4gO/aNlCwYCgeFdksOauy+eLhmw==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by BN0PR02MB8205.namprd02.prod.outlook.com (2603:10b6:408:150::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 04:28:15 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 04:28:15 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     Paul Moore <paul@paul-moore.com>
CC:     "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] audit: check if audit_queue is full after
  prepare_to_wait_exclusive()
Thread-Topic: [PATCH v2 4/5] audit: check if audit_queue is full after
  prepare_to_wait_exclusive()
Thread-Index: AQHZipQk7YvZMNPEnU6IJQQqrmDgbq9ltnCA
Date:   Mon, 22 May 2023 04:28:14 +0000
Message-ID: <368B6D67-26A0-4A05-B404-395C5990A9A2@nutanix.com>
References: <20230511052116.19452-5-eiichi.tsukata@nutanix.com>
 <1b4c3d51624547d0bda6dae93c5ae407.paul@paul-moore.com>
In-Reply-To: <1b4c3d51624547d0bda6dae93c5ae407.paul@paul-moore.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8041:EE_|BN0PR02MB8205:EE_
x-ms-office365-filtering-correlation-id: 006cc5af-8334-43b1-57b1-08db5a7cf5cc
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dflZ7oNRSzp2Dz80qkmlcNKqT+UIk1w63kq0p4fa89du1ZUxGxXe11vz7dM5vOv57yHnPz3d0g/er9RarLlX5DT4qYsEMGWJIgD2d4DSN2Dtsq4NhuhmvQZIFGHQx1t4dUnQ4iju4EIOP4oIeIqIQtt5ZSPRiiAAkr3Ib9qJ6IGTBLWu/NNSQRBUcrAjB6BYw1NTbhKWQ+0IzrpZNQiGtVT3uPMd5/bCckLK5bMIUtIzFK5RPiRD7dame2F+wq49UzE97tY1mhkuWKy5w3Im9/r9ta+IY3wDg5kAfyOwDN5M0AEPwhq4tOjnc2Pc/OoZHx06iFtw4+RGaMKBVV6Prb3TE+0Txgl1Mtf+N3mGnpKLXoJ28pND2v52CGp4UhKG2JpMoTXTEO/sBZLsy/wk8+qFNO0xdOZ27AuijHhoFIwW+mtLHPGzK9yKNpnv+YcEkfipt5YD2h+499DINfRhznAkoq08soOaHCzGXvdj0Pqh08xSPnOcmJbGQBbHB+9rRnMq8de1TRyhsreg43Bk5sz38VXP0/u7V4t1d5o5ofAZOXSZvfV60rSEyMzecQt26xk7LBxpbJ2du5KHnIS7TNnQoo4W+uHdQMeBodoXJSoGNezw/PrSEAahqXuSJ1dbiNhNAwJQWWXKWBQWgbcVIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(8676002)(8936002)(44832011)(5660300002)(83380400001)(53546011)(186003)(6512007)(6506007)(26005)(2616005)(86362001)(122000001)(38100700002)(38070700005)(41300700001)(71200400001)(6486002)(478600001)(33656002)(4326008)(6916009)(64756008)(66446008)(76116006)(36756003)(66946007)(66556008)(66476007)(316002)(54906003)(91956017)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFFEcnBUUEMvZlR4RHVWTEdKL0VXVXVlQjg5bHBEZlNPQ1dlWkJjTWJVUzFK?=
 =?utf-8?B?OUZ6ZGRoaVZROGUvRkVHQ1dBdnhmUk44WGpjZ2tUcjVhWis2bE9mT1lGOUY3?=
 =?utf-8?B?UzNZQlJyVHErR2lrVnpDU3lqTXRSV2MvL2M1TXVrNGk3Y3VKenFOM3hna0Rq?=
 =?utf-8?B?UWxNTVJqWDJzSnRnZEhBNGpxN3Q2WE9WYlNLdEFBUS9tVzF5MVc3bWFzOTZw?=
 =?utf-8?B?alVpTTlvK2VtTlRaQURZRUI2VDJ1VU5ZYUdoTTRRZE5UejZUUi95OTMzeENt?=
 =?utf-8?B?Ynd4Zzh2blF1a3VnalNFM1hCMm02eEZSZWlvVEZ6MGZPMkswTDYvNGFuS1BE?=
 =?utf-8?B?c1NXekZ1R2dQd3R4bWZ4V1laQ1N0YWE2T1lpTUFFV0hLT2VuUUtsaEVCVTNI?=
 =?utf-8?B?eFJ4dFRrMTBiSGdMYWpPcVdsNnhJSnp2aTRYRGY2YW1VQ3pKSGtIc0o3VUtK?=
 =?utf-8?B?aG1wM1UxdzRXUkdCaHlYZmcwOUNaMUhHOUh3eGpheXM0MGM5SG9vajVobTJK?=
 =?utf-8?B?b3hncDMwRUxuUTRJZGRrMEEwMlFMQ2RPVnhUZzdaYjlDOUFNNitKSW0yYTJo?=
 =?utf-8?B?RjdYSnR0ZSsyb0JoYWxRVE1KbkwrMUdDUGsrUlIvQzF1STlSSU15bTUzd1RL?=
 =?utf-8?B?aWx0VXQyeUdpUjlvWVdEbG5wbk1paEU4TVVUUndMUUEwWThVM2tldnc3Rit6?=
 =?utf-8?B?cWFWNitBQU8vVTl0U3drOWd5d2pJSGtiSEdVSGZZcm9NeXJXdTNxcWNITTNV?=
 =?utf-8?B?SWlMOStLeWVjZlpOWVBLWHBvK2xqeStwR3JZS2FoR2lSdGxNVEN1S0M3VVo1?=
 =?utf-8?B?N1c2Tk5VTzNTV1g4aU5UNHF4OWZ4czBQZWgzL2l5bkJJMWxRL2R0dU9kTEpN?=
 =?utf-8?B?eUFZSkIwTUVFUmR2b2lNOXUrU2Y5UjRYUTc2WFhNbUlhN3RQODYxQ3pGUTI2?=
 =?utf-8?B?bFRJZjZ1YmtieHp4eGpmcWpndzA4Q1k2Q1NPa1lZUmZMVzBTMVZ1UlN3bnBR?=
 =?utf-8?B?NW90Z2tzQXpvaWxRQ0NqM2ZJUWx5UTNNck44dE1jaXlMVnpwTzdJS1ArYWc5?=
 =?utf-8?B?QVBrcTBGWnY5MG9RanBRYWw0QzRIVWJLcE51VXVwZDhGYlplUzVXb1FHWE5p?=
 =?utf-8?B?Sm9nQUFqbk90TW81T2szS2x4TFRwUGd4b043MW5LaVNMOUpkSG9sS00zUGVl?=
 =?utf-8?B?L3ZPbUM1R29DS1ZUUm9QS3pTREoydHFOSjA3QmE4RXlOTjB4MGlpaTFETFdK?=
 =?utf-8?B?YVVMY2QvWEtaMUlYM3hvbHhsUVRhcTduWmMwYWtod2NZZnNXSnFBcDcyZEVw?=
 =?utf-8?B?RlFYZzRDOUNuRjVSUE15NVQwYnIrSVEyVGZzUW5LbXhFSSt2QWw3RkV1TS9F?=
 =?utf-8?B?YnArVmF2WEltSDZzMGUxeWM5bTBkcnhvamlvdnRDZnJnaUJpaGw5SExlV0lG?=
 =?utf-8?B?WFlZeG81SUpIa3drRmFVc053MmR5YnMzdkZqcEY1UkZRV0gxK1ltdGNtTnN2?=
 =?utf-8?B?UFhtdkFpRzh5OHNoMzF5QTdQLzd2WU5QU1Jkd3lUblFwV0RaYzBUU1RHYjVu?=
 =?utf-8?B?bkZDcC9aallSa0Fsa2R1Yk5uS0ZPdDdldVVLeDg3MWRGSG0yUGkzQ2dSbjN1?=
 =?utf-8?B?ZHVBMDFObnhFQUwraldjR0ZEQVFUYzF0UVJpbnYyd29xa2NrTEhzYWUvbUV3?=
 =?utf-8?B?MlN6VmhmVkdWd3Bob3BPNEdEOERTaktSWXNlWW96YitJaWNQcDhGUXhRdEUz?=
 =?utf-8?B?U3F2dkswb0JPVDJYSFVkS1QveU00QlIwVjgvei9jV0dHSzdFbXRQUlJKaUNM?=
 =?utf-8?B?NGFhOG9ETkozNmNhN1dGelVBYmlCdUhaM3NDenNDYWlUUWFVOVJzZkpIbDhZ?=
 =?utf-8?B?WWJ2dzFVdnhuSytkVkJXYTJqOElkTzF4ODRpOWJreEVlOFZYQ1crdU5HNjdV?=
 =?utf-8?B?N3J2TlZXYU1keTFVNzAyT0ZnOE95cVIvWFlrMXNRVXRkUmVOczZqbVorU2kz?=
 =?utf-8?B?bHhVZUdhb2g1YTY0RW9BT1grZkh1dmxmbmc1NUVXeWFldUdZbFZ4aHBYV1Q5?=
 =?utf-8?B?QlI4RkJtRWczYkpSSUsrTit5eHNYMG9KUlpaYVhvSmgyODFteFZWZkhZR0da?=
 =?utf-8?B?NVhVQkpML01md0dKSEtCMlZwd1F3V0wvMWhUaFBjNWtmOXYydXZBQnJ1WERC?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D39D3B37B4DD04CA1D37371E280862C@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006cc5af-8334-43b1-57b1-08db5a7cf5cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 04:28:14.8811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LIDgR1jtDDlI/7m6JYTc883vR1cHVOsOGWaSYktIW5KaoaBPuGqctPcV50J36C21geu9yF/8sH/9zzaP7wCWHuK78EhuYVsqza8RQML+d1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8205
X-Proofpoint-ORIG-GUID: U13z0irfqVAPPbuvJQtGD_StpC75Yvji
X-Proofpoint-GUID: U13z0irfqVAPPbuvJQtGD_StpC75Yvji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWF5IDIwLCAyMDIzLCBhdCA1OjU0LCBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9v
cmUuY29tPiB3cm90ZToNCj4gDQo+IE9uIE1heSAxMSwgMjAyMyBFaWljaGkgVHN1a2F0YSA8ZWlp
Y2hpLnRzdWthdGFAbnV0YW5peC5jb20+IHdyb3RlOg0KPj4gDQo+PiBDb21taXQgN2ZmYjhlMzE3
YmFlICgiYXVkaXQ6IHdlIGRvbid0IG5lZWQgdG8NCj4+IF9fc2V0X2N1cnJlbnRfc3RhdGUoVEFT
S19SVU5OSU5HKSIpIGFjY2lkZW50YWxseSBtb3ZlZCBxdWV1ZSBmdWxsIGNoZWNrDQo+PiBiZWZv
cmUgYWRkX3dhaXRfcXVldWVfZXhjbHVzaXZlKCkgd2hpY2ggaW50cm9kdWNlZCB0aGUgZm9sbG93
aW5nIHJhY2U6DQo+PiANCj4+ICAgIENQVTEgICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUy
DQo+PiAgPT09PT09PT0gICAgICAgICAgICAgICAgICAgICAgID09PT09PT09DQo+PiAgKGluIGF1
ZGl0X2xvZ19zdGFydCgpKSAgICAgICAgIChpbiBrYXVkaXRkX3RocmVhZCgpKQ0KPj4gDQo+PiAg
QGF1ZGl0X3F1ZXVlIGlzIGZ1bGwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
d2FrZV91cCgmYXVkaXRfYmFja2xvZ193YWl0KQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB3YWl0X2V2ZW50X2ZyZWV6YWJsZSgpDQo+PiAgYWRkX3dhaXRfcXVldWVfZXhjbHVz
aXZlKCkNCj4+ICAuLi4NCj4+ICBzY2hlZHVsZV90aW1lb3V0KCkNCj4+IA0KPj4gT25jZSB0aGlz
IGhhcHBlbnMsIGJvdGggYXVkaXRfbG9nX3N0YXJ0KCkgYW5kIGthdWRpdGRfdGhyZWFkKCkgY2Fu
IGNhdXNlDQo+PiBkZWFkbG9jayBmb3IgdXAgdG8gYmFja2xvZ193YWl0X3RpbWUgd2FpdGluZyBm
b3IgZWFjaCBvdGhlci4gVG8gcHJldmVudA0KPj4gdGhlIHJhY2UsIHRoaXMgcGF0Y2ggYWRkcyBA
YXVkaXRfcXVldWUgZnVsbCBjaGVjayBhZnRlcg0KPj4gcHJlcGFyZV90b193YWl0X2V4Y2x1c2l2
ZSgpIGFuZCBjYWxsIHNjaGVkdWxlX3RpbWVvdXQoKSBvbmx5IGlmIHRoZQ0KPj4gcXVldWUgaXMg
ZnVsbC4NCj4+IA0KPj4gRml4ZXM6IDdmZmI4ZTMxN2JhZSAoImF1ZGl0OiB3ZSBkb24ndCBuZWVk
IHRvIF9fc2V0X2N1cnJlbnRfc3RhdGUoVEFTS19SVU5OSU5HKSIpDQo+PiBTaWduZWQtb2ZmLWJ5
OiBFaWljaGkgVHN1a2F0YSA8ZWlpY2hpLnRzdWthdGFAbnV0YW5peC5jb20+DQo+PiAtLS0NCj4+
IGtlcm5lbC9hdWRpdC5jIHwgMTIgKysrKysrKysrKy0tDQo+PiAxIGZpbGUgY2hhbmdlZCwgMTAg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IEkgZGlzY3Vzc2VkIG15IGNvbmNl
cm5zIHdpdGggdGhpcyBwYXRjaCBpbiB0aGUgbGFzdCBwYXRjaHNldCwgYW5kIEkNCj4gYmVsaWV2
ZSB0aGV5IHN0aWxsIGFwcGx5IGhlcmUuDQo+IA0KDQpQbGVhc2UgcmVmZXIgdG8gdGhlIGltcGxl
bWVudGF0aW9uIG9mIF9fX3dhaXRfZXZlbnQoKS4NCkl0IGNoZWNrcyB0aGUgY29uZGl0aW9uICph
ZnRlciogcHJlcGFyZV90b193YWl0X2V2ZW50KCkuDQoNCkFub3RoZXIgc2ltaWxhciBleGFtcGxl
IGluIHRoZSBrZXJuZWwgY29kZSBpcyB1bml4X3dhaXRfZm9yX3BlZXIoKS4NCkl0IGNoZWNrcyB1
bml4X3JlY3ZxX2Z1bGwoKSBhZnRlciBwcmVwYXJlX3RvX3dhaXRfZXhjbHVzaXZlKCkuDQoNCkni
gJltIGFzc3VtaW5nIHRoaXMgaXMgYSBsb2dpY2FsIGJ1ZyBuZWVkcyB0byBiZSBmaXhlZC4NCg0K
RWlpY2hpDQoNCg0K
