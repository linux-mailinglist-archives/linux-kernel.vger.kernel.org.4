Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476926F7C1F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 06:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjEEE47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 00:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEEE4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 00:56:54 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2115.outbound.protection.outlook.com [40.107.135.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D8FA243;
        Thu,  4 May 2023 21:56:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeoE/zbPv9cub8/Gam8LUSfxHfi9iN23uk9NGL2LQENXPxPhaXA4gzHTWa4scYUzRMHuLBypueV1Qgi688V8WYxPOzaiG2Dnv550PhGnYxtEGiIOt71spKSTwLl9UEJV6VsWAMLe3BWkeLV3EnfmQXEP4nYm9hIF3U4LaQMF2JirpiGdEUamUhvrby/+GiP4Yc5wT7pJFvJ8n4ZGjEVmckY9tsUxVQmu3QR3B8vgQcxrniPkUxRU1uwgh4tfMho7AHasZ7ld4yPYATs2rvWbE0j1Er8mBDPZx3xg48/ODDNvntX6GIi6GoB6B8CGCGL01VULWr4QEyDkw8em2PwP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6raseYUKx5Bj7FmmTAZx7ukzx5sD0QX7GqhFxL5by3g=;
 b=eMkKzHnXvJgoCRClRuwCGB8P9qZWVWQ9T1UWGXON/Kh+OmoiacKoIiJXWftWnsdFczt7xWs03UWSYpscFX9egOebBC8uHxFg8Zh1HeTN02zUqU95zuAEknY4LXbwn18FY5IDv3kHWbNIUE3XxqIJTDVUWnqh6ln/0ISJJN70Cd08hc1ziCeZqeoe7soatnUuuxdailtogK9CU84jwD+Ny2Hv647pqPuG/PvdIyT1alG5FBAPhSAZ5JqEPJjO8ABySL1g81XQjSEsSOgFPwbkNZwV/t7BXQ12rjxPMcDbBgwTmQbI1VHQSPRRWIruh5wWODng68QTER+1kRMG9Y6/ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6raseYUKx5Bj7FmmTAZx7ukzx5sD0QX7GqhFxL5by3g=;
 b=vRu9QcxZRzlmqL2sSyYJ5oZU9CveOQC1MBEAsANFgipfNxbWHXIuvRHqJQ2quIINNJLz0jD7YNbPvm1wvG3KwiI1P4ld9ydGe6714EPM6tYt9wjCimzTKeYZCANR3a0poit8ZZHvqLe0wXLacsW+zV/2fKkohO34HzvuhTc8wKg=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR0P281MB1706.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 04:56:47 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4218:fb63:61ae:c42a]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4218:fb63:61ae:c42a%5]) with mapi id 15.20.6363.021; Fri, 5 May 2023
 04:56:47 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/5] iio: light: ROHM BU27008 color sensor
Thread-Topic: [PATCH v4 4/5] iio: light: ROHM BU27008 color sensor
Thread-Index: AQHZfaS0iJPNAf+vLkmCHM5dPvyXnK9KL5sAgADxFwA=
Date:   Fri, 5 May 2023 04:56:47 +0000
Message-ID: <c63c5271-3973-3bd4-c683-ab9ab64b67e4@fi.rohmeurope.com>
References: <cover.1683105758.git.mazziesaccount@gmail.com>
 <6d1e37f95dd039d9c96a992b1855fd193bdded40.1683105758.git.mazziesaccount@gmail.com>
 <ZFPCUJ81aw/GkJgT@smile.fi.intel.com>
In-Reply-To: <ZFPCUJ81aw/GkJgT@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FR0P281MB1706:EE_
x-ms-office365-filtering-correlation-id: 6c3f7590-7965-468a-4b45-08db4d252166
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9rIBOG+HsiySfN81NOQ72S41f0yN4RF/9v46cQ8Km83gnf7eHAaELqtg7ydpF/MjSNT+ZAUS2Dmuq1rnaLRCIAfT5kZtiDcURv3f0ORLqn8R0zidmPWrBU49WABI+g2hmuzcAdJs0Ij8cb0/wgGgMXpDYfUJEAu3qhJFGEQ9OuWa8gHXR87BeqeGOxwsHKn+AHv4PhWwouV/GvA9kPNOmD88Ip0sCJrqeSU3ovQgKkFtmfC51AHLPHczOXcdbgUh05M2sBfD/WfqO3APMdeQYmUtA/rkazZAg7ch1azBIHn6sjpAEmaR1OgEvsPXsOHuF1WJ8WtiBV8mr9FsnBJ88AtetWRRpsI51u0HSLK4ZoU00jp0P6KAe7kK1zYmE9MD5u/+QZQwDv2revXljvEKWSZ1rC1+kUq750YSH8R9otYArGcHvaAsM6xUmCF9k5VcvNSv4QjNPZNtzFKl+bvI0TVITBNkHJxpz4izBmhP4MKnIiFM+jZyd5+2VhJaDKiXZ63iduUdu7tXb89cR64syRHqJPuM9TY9+4m0rSxY544PCvXcQJoaQuCEZG19Opji8H8G0ofSyXpsFEj14bAuk+Gph0SJZ8emkR9EZ/3DTW3ZLQVmWr2OW1BL1bHON3MFoX/4HskfAd2sSmHMGXrkaJvvf7dPuWVLaIsrrxyZqiA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39850400004)(366004)(396003)(346002)(451199021)(31696002)(86362001)(6486002)(71200400001)(110136005)(54906003)(316002)(91956017)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(76116006)(478600001)(966005)(41300700001)(8676002)(8936002)(5660300002)(2906002)(7416002)(38070700005)(122000001)(38100700002)(186003)(2616005)(6512007)(6506007)(26005)(53546011)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eERLZ254Q2JzcVR6R2pHQjRhRlc5cmhrTG1SalVtZGhIbXVxbmZsQ24yM2dO?=
 =?utf-8?B?UTk0c3BzRTNtRnE0VXY5UUZPWDYzTElOUW9rZ1YycmZGekdLWjJkbUl3RVNW?=
 =?utf-8?B?bmdkZDBiWjY1OURtVzNienFBT3BpQjZLekFFdGpSbi9VMTlPY0pRc1Rpc2l0?=
 =?utf-8?B?VTJYTEszTU9SeGtkaHFhdDVoTEtLbGJKem5uWDYyQ25QMStHV09JREJoU1JR?=
 =?utf-8?B?U2tYREovS1pkZDcyRys5c3VzWVd6Q0Q5OVlOcHJISHdUeklISi9Ma2Q4RDlE?=
 =?utf-8?B?d1VobE9jYnNGM2gyYzFBL1IybkRSWkkreSsxWTNXTllqd3ZEY1VjN3B5L2NX?=
 =?utf-8?B?cnZBVFVlRGg0bzJCc3JzeE5UcmVUS0dxT2k3Y2w4U1VBU0NjTC9EcUhDQjhB?=
 =?utf-8?B?ZzhPd1ZiNGpBdElXdEREejJNUGpDMFcxUjB4Vjl1dnBYYjQ5WHI1VU5KSWVm?=
 =?utf-8?B?a3pDM25iSEdGRS9JWm9KYnZ4dmVTMmVBN2xYZHNrbVR2U0w1c0ZGZDJKQ2Zl?=
 =?utf-8?B?Ui84Nks3UFBtQnM0bDF1VU1XZS9waEtWOWNRbEJZQ296dUk1Uk92Y3l3OE11?=
 =?utf-8?B?dnR5WEdpa1l1L1FiQldWNUFaSXBQUzUzNHpiQjNJWEpLR1VqR2FnSjFmQzNN?=
 =?utf-8?B?dmFTSFJXNzVzL2NiQnhFcjE5L1psSVZIQnUvQlozNDZoYm5Ea2V2OXgyNjg4?=
 =?utf-8?B?OVMzNjlQc1hDNXpjWTNleWY2K01xWnhBdmVmNUhMSUJnem9BRVczV1BCZUZR?=
 =?utf-8?B?TmRiTldmZHY4KzY5UGhvVnVHRmZRdkJDcjBTMlIvUlNHOUI4bTdSMTYxcmp4?=
 =?utf-8?B?NGNRQXdHQ1VkWERCM2VmL2EzNzdSdTlkMlhJUkFwZG9ET01kQVZ5ZXMrUUJp?=
 =?utf-8?B?WkVKWDVMdmN0WFRNUjFJMEFqRXdlSWlhNGJLVUdMbkJvSXNZckpjbzBRMlJi?=
 =?utf-8?B?WnN0SUxzUnYwNkpQY1JZckhNZmcvVmlUZmJYaVhrck03THdidnlEVmd3UDEx?=
 =?utf-8?B?WGtEbGM4VHRXUE1hS2YrdFV3TDNobC9QMzlOZTkrRWIxRTd1T1VsWlcrRDRs?=
 =?utf-8?B?bjZyUlRrUzBZRnNZYVFsYVY1cERHODRiTmN6SS9UeHJwdXRzRFU2SC9QUVFq?=
 =?utf-8?B?cVJiSjg2b1VVeUxIbjNQMm5IaEliL3hORTRxTFpwUDhRRmRhNERxQ3krVXBs?=
 =?utf-8?B?VXdqVDVMOHlodDJwNjdJbHFJNldMdGtZRlRudDhZMjdaQWZCQStvVlNDUUU4?=
 =?utf-8?B?MVRCME9TNVZkbmd3Tk4vT1g5bTl3d2FFS01LUFA2cVphd0lVem1aaGpZS1k0?=
 =?utf-8?B?ek52OWJMM1lPdGFhV1pzRS9QbUxvM05ueWNGOHVlN3g0ejBpRXc3QnRXNk1U?=
 =?utf-8?B?VzJWYzEyaUhNem50b0VxRE1jQm5pNXQ5OWY5TkJ4aS9MdHN5aGVNRXlya3lo?=
 =?utf-8?B?U3l2bHpRRFVRMW5SM1FxTks4THRVRzdPdGFOYlBzWnJvdTRLUVB4a3M2aU9m?=
 =?utf-8?B?aUJWNWFiYXpCUmpyUUhUa2dhdnFmOVpJRmpROW1tZlcrbXFrTEFKd2NsVUtu?=
 =?utf-8?B?MHg5V01qRlVnSXFibVpWTUcyc1JvN2ZXdmg2TURBWmhxRnRQRHo5MEphN2JK?=
 =?utf-8?B?bHdQcFJiVU9qdGxUZ3IweFc4NHQzOVZHZE9DbVhSc1AweVk2amN5dXdCQWhi?=
 =?utf-8?B?TVFTZG9YbWVJS0lPVGZ3NWdyb0FIaTdVRTJadGxLVEZzVnRhak1xbFJTYlBD?=
 =?utf-8?B?TUg1OUxJaFVYdjFNcGhGQ2psQUNJVGN3TlpWQ05YUyszZWpEVm5pTmZheE9s?=
 =?utf-8?B?ZE9xV05CNXp0S2tZS0t6MHJvMnR1VzlwQ2lOdzVBYXdVa0piTGcycEtkTU1K?=
 =?utf-8?B?K3hYaFpUSWkyamJhcjNNWVJOOEw2d0FYbnFna1hSZkhMa2x5WHVGdWRIV0Fz?=
 =?utf-8?B?VHhDZE9XVDFMS3BXODdKRFhLR0FEKzFKbEVzdC9SWlYzVXgxS0gwaDlqOG12?=
 =?utf-8?B?Rlp5TTZTVlp2TEI3L25uK3Zhc2paTlp6aE1NZjJMYTNudVVlcnBBZGZBT2J1?=
 =?utf-8?B?NVcwWExOSHVXOHU0alFrMmM3cjg2amt5VTNoaFovT1lzeGtHcms2Q2trOXB3?=
 =?utf-8?B?WEJtYWF2RWMwNmxRWEh0c1dkd2hIRUlLOUtBRU11MDQvZnhSS0svTjBXTTRG?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50C12375F18BC94DBED14E9F901A077C@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3f7590-7965-468a-4b45-08db4d252166
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 04:56:47.2017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xwBSizSc5mcX93xeraO8O7qZyS3iEAvW7TeUC3QNPMC4p0SXX00iv2n03RxALpOLKsJGlxUX9N84khLMONQTeIbJSe1+r4ICQzOTy0SNeKVWl9EZxbL9iTrLWs7CDdUH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1706
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS80LzIzIDE3OjMzLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IE9uIFdlZCwgTWF5IDAz
LCAyMDIzIGF0IDEyOjUwOjE0UE0gKzAzMDAsIE1hdHRpIFZhaXR0aW5lbiB3cm90ZToNCj4+IFRo
ZSBST0hNIEJVMjcwMDggaXMgYSBzZW5zb3Igd2l0aCA1IHBob3RvZGlvZGVzIChyZWQsIGdyZWVu
LCBibHVlLCBjbGVhcg0KPj4gYW5kIElSKSB3aXRoIGZvdXIgY29uZmlndXJhYmxlIGNoYW5uZWxz
LiBSZWQgYW5kIGdyZWVuIGJlaW5nIGFsd2F5cw0KPj4gYXZhaWxhYmxlIGFuZCB0d28gb3V0IG9m
IHRoZSByZXN0IHRocmVlIChibHVlLCBjbGVhciwgSVIpIGNhbiBiZQ0KPj4gc2VsZWN0ZWQgdG8g
YmUgc2ltdWx0YW5lb3VzbHkgbWVhc3VyZWQuIFR5cGljYWwgYXBwbGljYXRpb24gaXMgYWRqdXN0
aW5nDQo+PiBMQ0QgYmFja2xpZ2h0IG9mIFRWcywgbW9iaWxlIHBob25lcyBhbmQgdGFibGV0IFBD
cy4NCj4+DQo+PiBBZGQgaW5pdGlhbCBzdXBwb3J0IGZvciB0aGUgUk9ITSBCVTI3MDA4IGNvbG9y
IHNlbnNvci4NCj4+ICAgLSByYXdfcmVhZCgpIG9mIFJHQiBhbmQgY2xlYXIgY2hhbm5lbHMNCj4+
ICAgLSB0cmlnZ2VyZWQgYnVmZmVyIHcvIERSRFkgaW50ZXJydHVwdA0KPiANCj4gLi4uDQo+IA0K
Pj4gK2NvbmZpZyBST0hNX0JVMjcwMDgNCj4+ICsJdHJpc3RhdGUgIlJPSE0gQlUyNzAwOCBjb2xv
ciAoUkdCK0MvSVIpIHNlbnNvciINCj4+ICsJZGVwZW5kcyBvbiBJMkMNCj4+ICsJc2VsZWN0IFJF
R01BUF9JMkMNCj4+ICsJc2VsZWN0IElJT19HVFNfSEVMUEVSDQo+PiArCWhlbHANCj4+ICsJICBF
bmFibGUgc3VwcG9ydCBmb3IgdGhlIFJPSE0gQlUyNzAwOCBjb2xvciBzZW5zb3IuDQo+PiArCSAg
VGhlIFJPSE0gQlUyNzAwOCBpcyBhIHNlbnNvciB3aXRoIDUgcGhvdG9kaW9kZXMgKHJlZCwgZ3Jl
ZW4sDQo+PiArCSAgYmx1ZSwgY2xlYXIgYW5kIElSKSB3aXRoIGZvdXIgY29uZmlndXJhYmxlIGNo
YW5uZWxzLiBSZWQgYW5kDQo+PiArCSAgZ3JlZW4gYmVpbmcgYWx3YXlzIGF2YWlsYWJsZSBhbmQg
dHdvIG91dCBvZiB0aGUgcmVzdCB0aHJlZQ0KPj4gKwkgIChibHVlLCBjbGVhciwgSVIpIGNhbiBi
ZSBzZWxlY3RlZCB0byBiZSBzaW11bHRhbmVvdXNseSBtZWFzdXJlZC4NCj4+ICsJICBUeXBpY2Fs
IGFwcGxpY2F0aW9uIGlzIGFkanVzdGluZyBMQ0QgYmFja2xpZ2h0IG9mIFRWcywNCj4+ICsJICBt
b2JpbGUgcGhvbmVzIGFuZCB0YWJsZXQgUENzLg0KPiANCj4gTW9kdWxlIG5hbWU/DQoNCldlIGhh
dmUgZGlzY3Vzc2VkIHRoaXMgc2V2ZXJhbCB0aW1lcyBhbHJlYWR5Lg0KDQpodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMTBjNDY2M2ItZGQ2NS1hNTQ1LTc4NmQtMTBhZWQ2ZTZlNWU5QGZpLnJv
aG1ldXJvcGUuY29tLw0KDQpNb2R1bGUgbmFtZSBpcyBjb21wbGV0ZWx5IGlycmVsZXZhbnQgd2hl
biBzZWxlY3RpbmcgYSBrZXJuZWwgY29uZmlndXJhdGlvbi4NCg0KPiANCj4gLi4uDQo+IA0KPj4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgcmVnbWFwX3JhbmdlIGJ1MjcwMDhfcmVhZF9vbmx5X3Jhbmdl
c1tdID0gew0KPj4gKwl7DQo+PiArCQkucmFuZ2VfbWluID0gQlUyNzAwOF9SRUdfREFUQTBfTE8s
DQo+PiArCQkucmFuZ2VfbWF4ID0gQlUyNzAwOF9SRUdfREFUQTNfSEksDQo+PiArCX0sIHsNCj4+
ICsJCS5yYW5nZV9taW4gPSBCVTI3MDA4X1JFR19NQU5VRkFDVFVSRVJfSUQsDQo+PiArCQkucmFu
Z2VfbWF4ID0gQlUyNzAwOF9SRUdfTUFOVUZBQ1RVUkVSX0lELA0KPiANCj4+ICsJfQ0KPiANCj4g
KyB0cmFpbGluZyBjb21tYSBmb3IgY29uc2lzdGVuY3k/IA0KDQpUaGFua3MuDQoNCj4+ICt9Ow0K
PiANCj4gLi4uDQo+IA0KPj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgcmVnbWFwX2NvbmZpZyBidTI3
MDA4X3JlZ21hcCA9IHsNCj4+ICsJLnJlZ19iaXRzID0gOCwNCj4+ICsJLnZhbF9iaXRzID0gOCwN
Cj4+ICsJLm1heF9yZWdpc3RlciA9IEJVMjcwMDhfUkVHX01BWCwNCj4+ICsJLmNhY2hlX3R5cGUg
PSBSRUdDQUNIRV9SQlRSRUUsDQo+PiArCS52b2xhdGlsZV90YWJsZSA9ICZidTI3MDA4X3ZvbGF0
aWxlX3JlZ3MsDQo+PiArCS53cl90YWJsZSA9ICZidTI3MDA4X3JvX3JlZ3MsDQo+IA0KPiBEbyB5
b3UgbmVlZCByZWdtYXAgbG9jaz8gSWYgc28sIHdoeSAoc2luY2UgeW91IGhhdmUgbXV0ZXgpPw0K
DQpJIGJlbGlldmUgeW91IGtub3cgdGhhdCByZWdtYXAgdXNlcyBhIGRlZmF1bHQgbG9jayB3aGVu
IG5vIGV4dGVybmFsIGxvY2sgDQppcyBnaXZlbi4gU28sIEkgYXNzdW1lIHlvdSBtZWFuIHRoYXQg
bWF5YmUgd2UgY291bGQgc2V0IA0KJ2Rpc2FibGVfbG9ja2luZycgZm9yIHRoZSByZWdtYXAgaGVy
ZS4NCg0KSXQncyBuaWNlIHRvIGJlIG9jY2FzaW9uYWxseSBwdXNoZWQgdG8gdGhpbmsgIm91dCBv
ZiB0aGUgYm94Ii4gQW5kIHllcywgDQpkaXNhYmxpbmcgcmVnbWFwIGxvY2sgaXMgcmVhbGx5IG91
dCBvZiBteSAibm9ybWFsIGJveCIgOikNCg0KSSBkaWRuJ3QgZ28gdGhyb3VnaCBhbGwgb2YgdGhl
IGNvZGUgeWV0LCBidXQgSSB0aGluayBwcmV0dHkgbXVjaCBhbGwgb2YgDQp0aGUgc2VxdWVuY2Vz
IHdoaWNoIGVuZCB1cCB0byByZWdpc3RlciB3cml0ZXMgYXJlIGluZGVlZCBwcm90ZWN0ZWQgYnkg
DQp0aGUgbXV0ZXguIChXZWxsLCBwcm9iZSBpcyBub3QgYnV0IGl0IGlzIGV4cGVjdGVkIHRvIG9u
bHkgdXBkYXRlIG9uZSBiaXQgDQp3aGlsZSByZXN0IG9mIHRoZSByZWdpc3RlciBzaG91bGQgc3Rh
eSBmaXhlZCkuDQoNCkl0IG1heSBiZSB3ZSBjb3VsZCBsaXZlIHdpdGhvdXQgcmVnbWFwX2xvY2sg
d2hlbiBkcml2ZXIgaXMgaW4gaXQncyANCmN1cnJlbnQgc3RhdGUsIGJ1dCBJIGFtIG5vdCBjb252
aW5jZWQgdGhlIHBlcmZvcm1hbmNlIGltcHJvdmVtZW50IGlzIA0Kd29ydGggdGhlIHJpc2suIEhh
dmluZyByZWdtYXAgdW5wcm90ZWN0ZWQgaXMgbm90IGNvbW1vbiwgYW5kIGl0IGlzIGFsc28gDQpu
b3QgZWFzeSB0byBzcG90IHdoZW4gbWFraW5nIGNoYW5nZXMgdG8gdGhlIGRyaXZlci4gSW4gbXkg
b3BpbmlvbiBpdCBpcyANCmEgYml0IGxpa2UgYXNraW5nIGZvciBhIG5vc2UtYmxlZWQgdW5sZXNz
IHRoZXJlIGlzIHJlYWxseSBoZWF2eSByZWFzb25zIA0KdG8gZHJvcCB0aGUgbG9jay4uLiBJbiB0
aGlzIGNhc2UsIGhhdmluZyB0aGUgcmVnbWFwX2xvY2sgKHdoaWNoIGlzIA0KcHJldHR5IG11Y2gg
bmV2ZXIgbG9ja2VkIGJlY2F1c2Ugd2UgaGF2ZSB0aGUgbXV0ZXggYXMgeW91IHNhaWQpIGlzIA0K
cHJvYmFibHkgbm90IGEgcGVuYWx0eSB0aGF0IG1hdHRlcnMuDQoNCj4gDQo+PiArfTsNCj4gDQo+
IC4uLg0KPiANCj4+ICtzdGF0aWMgaW50IGJ1MjcwMDhfcmVhZF9vbmUoc3RydWN0IGJ1MjcwMDhf
ZGF0YSAqZGF0YSwgc3RydWN0IGlpb19kZXYgKmlkZXYsDQo+PiArCQkJICAgIHN0cnVjdCBpaW9f
Y2hhbl9zcGVjIGNvbnN0ICpjaGFuLCBpbnQgKnZhbCwgaW50ICp2YWwyKQ0KPj4gK3sNCj4+ICsJ
aW50IHJldCwgaW50X3RpbWU7DQo+PiArDQo+PiArCXJldCA9IGJ1MjcwMDhfY2hhbl9jZmcoZGF0
YSwgY2hhbik7DQo+PiArCWlmIChyZXQpDQo+PiArCQlyZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKwly
ZXQgPSBidTI3MDA4X21lYXNfc2V0KGRhdGEsIEJVMjcwMDhfTUVBU19FTik7DQo+PiArCWlmIChy
ZXQpDQo+PiArCQlyZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKwlpbnRfdGltZSA9IGJ1MjcwMDhfZ2V0
X2ludF90aW1lX3VzKGRhdGEpOw0KPj4gKwlpZiAoaW50X3RpbWUgPCAwKQ0KPj4gKwkJaW50X3Rp
bWUgPSBCVTI3MDA4X01FQVNfVElNRV9NQVhfTVM7DQo+PiArCWVsc2UNCj4+ICsJCWludF90aW1l
IC89IFVTRUNfUEVSX01TRUM7DQo+IA0KPiBUaGUgYWJvdmUgZnVuY3Rpb24gcmV0dXJucyBhbiBl
cnJvciBjb2RlIHdoZW4gbmVnYXRpdmUsIHNvIEkgd291bGQgcmF0aGVyIHNlZQ0KPiANCj4gCXJl
dCA9IGJ1MjcwMDhfZ2V0X2ludF90aW1lX3VzKGRhdGEpOw0KPiAJaWYgKHJldCA8IDApDQo+IAkJ
aW50X3RpbWUgPSBCVTI3MDA4X01FQVNfVElNRV9NQVhfTVM7DQo+IAllbHNlDQo+IAkJaW50X3Rp
bWUgPSByZXQgLyBVU0VDX1BFUl9NU0VDOw0KPiANCj4gYXQgbGVhc3QgdGhpcyBleHBsaWNpdGx5
IHNob3dzIHRoZSBzZW1hbnRpY3Mgb2YgdGhlICJuZWdhdGl2ZSIgdGltZS4NCg0KT2suDQoNCj4g
DQo+PiArCW1zbGVlcChpbnRfdGltZSk7DQo+PiArDQo+PiArCXJldCA9IGJ1MjcwMDhfY2hhbl9y
ZWFkX2RhdGEoZGF0YSwgY2hhbi0+YWRkcmVzcywgdmFsKTsNCj4+ICsJaWYgKCFyZXQpDQo+PiAr
CQlyZXQgPSBJSU9fVkFMX0lOVDsNCj4+ICsNCj4+ICsJaWYgKGJ1MjcwMDhfbWVhc19zZXQoZGF0
YSwgQlUyNzAwOF9NRUFTX0RJUykpDQo+PiArCQlkZXZfd2FybihkYXRhLT5kZXYsICJtZWFzdXJl
bWVudCBkaXNhYmxpbmcgZmFpbGVkXG4iKTsNCj4+ICsNCj4+ICsJcmV0dXJuIHJldDsNCj4+ICt9
DQo+IA0KPiAuLi4NCj4gDQo+PiArCXJldCA9IHJlZ21hcF9yZWluaXRfY2FjaGUoZGF0YS0+cmVn
bWFwLCAmYnUyNzAwOF9yZWdtYXApOw0KPj4gKwlpZiAocmV0KSB7DQo+PiArCQlkZXZfZXJyKGRh
dGEtPmRldiwgIkZhaWxlZCB0byByZWluaXQgcmVnIGNhY2hlXG4iKTsNCj4gDQo+PiArCQlyZXR1
cm4gcmV0Ow0KPiANCj4gRHVwIGlzIG5vdCBuZWVkZWQuDQoNClRoYW5rcy4NCg0KPiANCj4+ICsJ
fQ0KPj4gKw0KPj4gKwlyZXR1cm4gcmV0Ow0KPiANCj4gLi4uDQo+IA0KPj4gKwlpZiAoaTJjLT5p
cnEpIHsNCj4gDQo+IEluc3RlYWQgb2YgYSBsb25nIGJvZHksIEkgd291bGQgcmF0aGVyIHNlZSBh
IGNhbGwgdG8NCg0KQ291bGQgbWFrZSBzZW5zZSBpbmRlZWQuIEknbGwgc2VlIGhvdyBpdCB3b3Vs
ZCBsb29rIGxpa2UsIHRoYW5rcy4NCg0KPiANCj4gCQlyZXQgPSAuLi5fc2V0dXBfaXJxKCk7DQo+
IAkJaWYgKHJldCkNCj4gCQkJcmV0dXJuIHJldDsNCj4gDQo+PiArCQlyZXQgPSBkZXZtX2lpb190
cmlnZ2VyZWRfYnVmZmVyX3NldHVwKGRldiwgaWRldiwNCj4+ICsJCQkJCQkgICAgICAmaWlvX3Bv
bGxmdW5jX3N0b3JlX3RpbWUsDQo+PiArCQkJCQkJICAgICAgYnUyNzAwOF90cmlnZ2VyX2hhbmRs
ZXIsDQo+PiArCQkJCQkJICAgICAgJmJ1MjcwMDhfYnVmZmVyX29wcyk7DQo+PiArCQlpZiAocmV0
KQ0KPj4gKwkJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LA0KPj4gKwkJCQkgICAgICJp
aW9fdHJpZ2dlcmVkX2J1ZmZlcl9zZXR1cF9leHQgRkFJTFxuIik7DQo+PiArDQo+PiArCQlpdHJp
ZyA9IGRldm1faWlvX3RyaWdnZXJfYWxsb2MoZGV2LCAiJXNkYXRhLXJkeS1kZXYlZCIsDQo+PiAr
CQkJCQkgICAgICAgaWRldi0+bmFtZSwgaWlvX2RldmljZV9pZChpZGV2KSk7DQo+PiArCQlpZiAo
IWl0cmlnKQ0KPj4gKwkJCXJldHVybiAtRU5PTUVNOw0KPj4gKw0KPj4gKwkJZGF0YS0+dHJpZyA9
IGl0cmlnOw0KPj4gKw0KPj4gKwkJaXRyaWctPm9wcyA9ICZidTI3MDA4X3RyaWdnZXJfb3BzOw0K
Pj4gKwkJaWlvX3RyaWdnZXJfc2V0X2RydmRhdGEoaXRyaWcsIGRhdGEpOw0KPj4gKw0KPj4gKwkJ
bmFtZSA9IGRldm1fa2FzcHJpbnRmKGRldiwgR0ZQX0tFUk5FTCwgIiVzLWJ1MjcwMDgiLA0KPj4g
KwkJCQkgICAgICBkZXZfbmFtZShkZXYpKTsNCj4+ICsNCj4+ICsJCXJldCA9IGRldm1fcmVxdWVz
dF9pcnEoZGV2LCBpMmMtPmlycSwNCj4+ICsJCQkJICAgICAgICZidTI3MDA4X2RhdGFfcmR5X3Bv
bGwsDQo+PiArCQkJCSAgICAgICAwLCBuYW1lLCBpdHJpZyk7DQo+PiArCQlpZiAocmV0KQ0KPj4g
KwkJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LA0KPj4gKwkJCQkJICAgICAiQ291bGQg
bm90IHJlcXVlc3QgSVJRXG4iKTsNCj4+ICsNCj4+ICsJCXJldCA9IGRldm1faWlvX3RyaWdnZXJf
cmVnaXN0ZXIoZGV2LCBpdHJpZyk7DQo+PiArCQlpZiAocmV0KQ0KPj4gKwkJCXJldHVybiBkZXZf
ZXJyX3Byb2JlKGRldiwgcmV0LA0KPj4gKwkJCQkJICAgICAiVHJpZ2dlciByZWdpc3RyYXRpb24g
ZmFpbGVkXG4iKTsNCj4+ICsNCj4+ICsJCS8qIHNldCBkZWZhdWx0IHRyaWdnZXIgKi8NCj4+ICsJ
CWlkZXYtPnRyaWcgPSBpaW9fdHJpZ2dlcl9nZXQoaXRyaWcpOw0KPj4gKwl9IGVsc2Ugew0KPj4g
KwkJZGV2X2luZm8oZGV2LCAiTm8gSVJRLCBidWZmZXJlZCBtb2RlIGRpc2FibGVkXG4iKTsNCj4+
ICsJfQ0KPiANCj4gDQoNCllvdXJzLA0KCS0tIE1hdHRpDQoNCi0tIA0KTWF0dGkgVmFpdHRpbmVu
DQpMaW51eCBrZXJuZWwgZGV2ZWxvcGVyIGF0IFJPSE0gU2VtaWNvbmR1Y3RvcnMNCk91bHUgRmlu
bGFuZA0KDQp+fiBXaGVuIHRoaW5ncyBnbyB1dHRlcmx5IHdyb25nIHZpbSB1c2VycyBjYW4gYWx3
YXlzIHR5cGUgOmhlbHAhIH5+DQoNCg==
