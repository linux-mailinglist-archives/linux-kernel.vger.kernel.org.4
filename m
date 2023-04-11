Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279326DDE66
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDKOrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjDKOrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:47:06 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2045.outbound.protection.outlook.com [40.107.247.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EF6199C;
        Tue, 11 Apr 2023 07:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6Rxk9CPsbQqp1FCsZ8hPvAoN7vqNb0MYGAPZUs8rGPBeoPT/OIAl6cRbIuvB62tXY3Q5Vkr/AL3Aq25kQRx+qvO6siAop6d5esLluuqueeulQvlnDtYZS43q5lEU0LhAFHmnslbycYEFhUMgZxQj46h0KDlKUzGktt3Xq0tJOskEvTnBowUwhREe9OcPmLxUdcNh70ZMkgW2Wmk3EAP80YYQ9dqL+2NshkAlWlDJfnX1KpKBsjGS+FzCDkMAQtZSsLvDXl5fYJ0z6BsaG+ZFF7G44HCZvamK07Vi4JNLodSgEvfio+G2MGQsrgYkeJY1tEZzKi1TEAWRW8cIiV12Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8JP8R3/gZAgauwlYWn+T8pdGKliJa2KhO6T7sDEoyA=;
 b=CxWAdaZDaqXrb6PZxs5o5FvRWuKR/K9+HSwWmA+wRg/7ezlc7UIRauKRXcTT55Ce1h8x9qZe1dnsZE0d5Ja0oUhEydn3/+4URlES0uZt6tcXVvsgCGEpRDFGfVRYGC/xW72IOJn5rETa2NbPdXgv+zt9fo5WSP0h1WnvEyh4fdQ/Lgc2wyP2MNt9yq2TfAG/zYl89pkWRnS8ehBzpYeVhimvRGPaZB2Ww1YWeAaZdaIlZVk6Zm2eHIOW2sun4YKz7XrZmwJOhO6EzZHoMkkFgSyPXjs2W60Hx7Gw1hRTQwOvO4FIekvfEcPE9dprG67toSo5ttXHzU/BcM0T+XLlKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xsightlabs.com; dmarc=pass action=none
 header.from=xsightlabs.com; dkim=pass header.d=xsightlabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xsightlabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8JP8R3/gZAgauwlYWn+T8pdGKliJa2KhO6T7sDEoyA=;
 b=hoK1LVlgBoEu7T+1Tbf0Rykd66VlNunpRyumbU93UHtoK/kRIx2hVfVlSCoEfVpCYkW4+kHy2EPWr2p5NGqjFE28eliBiZs8aZaBxfOvykqki8g+3hYoK9c8cqVDA5TsZF3hM5Qj27Lp6SFWR80895I1Vom4165US0Rh8sEf8bE=
Received: from AS8P193MB2335.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:446::5)
 by PR3P193MB0877.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 14:47:01 +0000
Received: from AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 ([fe80::fd74:ebbb:46ac:8a82]) by AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
 ([fe80::fd74:ebbb:46ac:8a82%4]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 14:47:01 +0000
From:   Robbie King <robbiek@xsightlabs.com>
To:     "lihuisong (C)" <lihuisong@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "wanghuiqiang@huawei.com" <wanghuiqiang@huawei.com>,
        "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
        "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
        "tanxiaofei@huawei.com" <tanxiaofei@huawei.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "xiexiuqi@huawei.com" <xiexiuqi@huawei.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "huangdaode@huawei.com" <huangdaode@huawei.com>
Subject: RE: [PATCH v2 0/2] mailbox: pcc: Support platform notification for
 type4 and shared interrupt
Thread-Topic: [PATCH v2 0/2] mailbox: pcc: Support platform notification for
 type4 and shared interrupt
Thread-Index: AQHZVmXrfTRFQyNc3E2WN8mIgww8bK8OkxgAgAAQQYCAFUbqgIACccaw
Date:   Tue, 11 Apr 2023 14:47:01 +0000
Message-ID: <AS8P193MB2335FA58943B305F97D2BACCCA9A9@AS8P193MB2335.EURP193.PROD.OUTLOOK.COM>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230314111135.16520-1-lihuisong@huawei.com>
 <20230327113326.dgrb5ainl6mv7wr5@bogus>
 <570a6f6d-87cb-48ca-3bbc-cd1221bfa88c@huawei.com>
 <7ef4eec4-2cfb-6f66-a9b9-9c130a1b71d8@huawei.com>
In-Reply-To: <7ef4eec4-2cfb-6f66-a9b9-9c130a1b71d8@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bromium-msgid: dfe9e309-f0e0-47f4-b731-0818a78a7ce0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xsightlabs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8P193MB2335:EE_|PR3P193MB0877:EE_
x-ms-office365-filtering-correlation-id: 77784394-05b5-4c90-13d9-08db3a9b9c02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pNF9O1xIwrt6euIxSRTCZB6G+ykFv05MP5eLHYkLljnMupCBagRKwS7huyjKm7Z001uR4fjSres3aY4Z4Bh2DQ7WnwJgkE93HVXPgNFjunsfF30sas5Nh0kw1ZucZKoQqjqDRwO+oL0sCMX1v91rWJ6RRAs97AL/FWePatVqCnAJpkx4HIn7o5erdrw6lyACbaobftd30oGusR7ann3DAe9/klC03eVm1+/e85kNJNEA/jzkB2wJOZqYsfD3BsjmgxMqtV2s4Us0jGJCyh6Az/HZuGmT2bda8IYXyqJk7SWEbrSMKAyv/vGj2infXjaZawBOk+GvnjWGKYpY1PtQntOVd1jrontKCO1CTHfAFzDaalSK6AL1nS6XFqua5OpnQy9iG5b9ahMgFCWYUQzu1Cr0jHruSt4Amdh+d+wgTrNsiF/olOVfXtz+tcVMtkaCqU9zfxKwv37fJylBABlFedRM5UwDcDXkvSBEXWPfShmjaPcU13Sa1MhtABZAk9swiKl/7/M/L+yLmTKeg+jg9mfsIPSCAjHBA8wIM7W4Q82oBK1o7AnCsvIOgh4igdsS880EFqzyaZvxOHf8WnpqjzLbhWJpa/HxcaFsY8IjiH0LldFAWQvaa2xSAybkG3Kc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2335.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(39840400004)(396003)(451199021)(2906002)(54906003)(478600001)(26005)(52536014)(8936002)(38100700002)(38070700005)(122000001)(15650500001)(9686003)(53546011)(6506007)(83380400001)(86362001)(7416002)(5660300002)(186003)(55016003)(66476007)(66556008)(64756008)(76116006)(66946007)(8676002)(4326008)(66446008)(33656002)(7696005)(110136005)(71200400001)(316002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnEvZk1LYXUxR3pJTUJXbW1NZW1mV1FlLzl4TXVmNXNwc2diT3NWSGxaUEtu?=
 =?utf-8?B?UGorcU9nM2padzArd1dSNFhtZjlVZVlqWjdKd0hkSFZjdzFveGlWVjVvWDg2?=
 =?utf-8?B?T1dvZFgwWmFvL0dnZ0cxN3FpdUtibG1JcGE4czhvR3BDamJVVWpRQjc1T1Nk?=
 =?utf-8?B?eUlVcS8wUFdFT0NRRTc4SnNjS1lTV2VMNGFpMU0yOFIrTGQvRG1kdktwVWEv?=
 =?utf-8?B?N2tkYWlYejE1andWWnFWTnF4cndEU2RQMUttSU9NclRJTTcwblRTeTUvcEdk?=
 =?utf-8?B?UktmRTlVMm56ZGlLMElMeHNQa2djUTRGcFQ1L3JGK2s3K09IMWltUkoxRjJ4?=
 =?utf-8?B?SFR2RGpDMC9JOEV1L0lkeTJQOGJmUS83bmdTWVNxR0FaaHhKN3RKUGVOV21C?=
 =?utf-8?B?RUgyTktaQlByZzhTd2VJVlFRVmdGeEFTd0FKc0JJdjZ1czM1M2kxQS8ydzJh?=
 =?utf-8?B?RSs4QTU4RXdNN0tkTVJGMjNoS1lNVVdRZW5XeFRoeGsxMHpZOGU0cER0LzIx?=
 =?utf-8?B?cXBENkd1bEY5MDJhcXMvblZGTmJUclRiRlEwd25ad0FHd1lUL0xVdC83R012?=
 =?utf-8?B?YkJGdy9JVHpwTlYwTDdUMUdydVNTbkxsMmV6L0VaK3NQS2ltS2l0MGlEdXdy?=
 =?utf-8?B?ZjNIWWNENVZZQjZka0ZvQmhTcjVwTXpKUS9TWTNKRjdJSDJRakxmcEViMUJs?=
 =?utf-8?B?SUtacmcrOFRvdW11b0xhNURKOVFySFFXS2FvWHg2ZEtqOUZLYkprVFFoRUd4?=
 =?utf-8?B?bmErd1NyWER0Z3BYWTY1QjE0WXU4Qi9NdUhrOGh4UGp0MEhkK1o5aVJ4aVhz?=
 =?utf-8?B?ZXJKSi9rVmc2SkZmZHg1WHBrUmQyOGVCWGp6LzBLL3hxWlVHc3NsVXNSeG8w?=
 =?utf-8?B?NU1ycFRnb1Z3UGVxS2VTVEZUeTgvaFM4R3dOSnV2azJNM3JHTXUya2IyVE54?=
 =?utf-8?B?c3NEdHBLRjJSNEJJcUxVaUdRL2MyN09jQnMrcHE5d2Q2NWZwbVVVYkw4VndM?=
 =?utf-8?B?MlVFM3RsMit2eHdXNldjem1LczRrc1I3RGhzeVBiSEFmOVorN3Y2Rmlqdm9s?=
 =?utf-8?B?d0cvNUZkMEpxeEU3WlNSMkRUTS9qYWhvRTNLUkxlYWtZRWV3MFJOQWwzWXBx?=
 =?utf-8?B?VkV1L21paEtnSE5SRk5oOEo4Tk50Y1psVmdPSjB4R1dPZklxTDQ0R2x1dWRW?=
 =?utf-8?B?Q2ZCajAyOU1lSFJiaHVqR0krZWM2YW5xM1FkWFZKNTdPSngzVjJLOXMrUWQy?=
 =?utf-8?B?T3VkMEJSMkc1bXpITFJhcy8vTFZzeWdYUzYyL2RhZnF0TnArMnJWRmphT3VQ?=
 =?utf-8?B?TVRpQlFlMWlVemEySC9OdUpyNDMzbUJTVlhVZ0JVSUJrdWFOUG4rWGtzcFpv?=
 =?utf-8?B?MnVVdWFXZ1QzMG5mcG1ydm1YMVJ2MEJ4UmU0OFFKUjNYRUM4VW5waHROa0xn?=
 =?utf-8?B?Z3NRQXRoT0RpeDdSNEFtNm1nWkRqOXdFZnJKVFRiUjVGandLM2NYaEVUdmox?=
 =?utf-8?B?QUVTSjlJcUtIcHhUMTZHYjQ5QzJTc3JXNVFQSVVBcjI4ZjFHVEpZZzVQRGdU?=
 =?utf-8?B?RElEVG5Uais4MzRuV3hKdXB5Yi9rbHNRVGJJSjlzUmJ3ckkyMjE3NUkyN1Ay?=
 =?utf-8?B?QkZ4SVFQUDhLeWpzRDl5c0FvZ1Z4MkJrQ3lXQTZycDZnSWdJR1h4eFFYbjlx?=
 =?utf-8?B?NnVBOWdlamI2T041cHBnTkdiYUFNbE1sb1EwSC9HMGFUbE9Xei9lR2x2Unho?=
 =?utf-8?B?RGpzbXJzVVpRRWYzM2cvSGFPNHNvVkx4Lzh0QlRac0VKemNrS09ZQzRSaXV6?=
 =?utf-8?B?QlpDdzFBNzRTcWZ6dmJ4WlhrWTN5Q2FJaTVYSWt6WHgzWi9FakVmNEc5eTQx?=
 =?utf-8?B?STVJS25MYjhGL2kvYWdNZFJBbXk1YjVzdXJpZm1XS3o2d1dUYmxveElmOXZY?=
 =?utf-8?B?Y0JHUjlJWExySExrdXJIbmFFTTRKR3A3VnZZMmVMRGxuUUVsMjV3NkZETGZz?=
 =?utf-8?B?TXFnd1oxem1mWHFqNzc3anhXcG5pK3VmT01SRXY1TkNZT1NnSkVLekt0TXRO?=
 =?utf-8?B?MHVKUDdMSS9pcWZiNFB5b3d3ZHFOSGFieHJrUDhLWms0cDZaTlcvejROdjk5?=
 =?utf-8?Q?R3wC2WhIBimb8h366EYnrCoWN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xsightlabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2335.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 77784394-05b5-4c90-13d9-08db3a9b9c02
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 14:47:01.4464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 646a3e34-83ea-4273-9177-ab01923abaa9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sd9zWzoozpWsegiCfDIqqaTQ8zueAnNqUsnr6NpVXymNBxvAOh4JSqLczXJnVdPBSGFOvvfjefp25gKdNgtXyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0877
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXBvbG9naWVzLCBtaXNzZWQgZWFybGllciBlbWFpbHMuICBXaWxsIG1ha2UgdGhpcyBhIHByaW9y
aXR5IGZvciB0aGUgd2Vlay4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGxp
aHVpc29uZyAoQykgPGxpaHVpc29uZ0BodWF3ZWkuY29tPiANClNlbnQ6IFN1bmRheSwgQXByaWwg
OSwgMjAyMyA5OjI3IFBNDQpUbzogU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT47
IFJvYmJpZSBLaW5nIDxyb2JiaWVrQHhzaWdodGxhYnMuY29tPg0KQ2M6IGxpbnV4LWFjcGlAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyByYWZhZWxAa2VybmVs
Lm9yZzsgcmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb207IHdhbmdodWlxaWFuZ0BodWF3ZWkuY29t
OyB6aGFuZ3pla3VuMTFAaHVhd2VpLmNvbTsgd2FuZ3hpb25nZmVuZzJAaHVhd2VpLmNvbTsgdGFu
eGlhb2ZlaUBodWF3ZWkuY29tOyBndW9oYW5qdW5AaHVhd2VpLmNvbTsgeGlleGl1cWlAaHVhd2Vp
LmNvbTsgd2FuZ2tlZmVuZy53YW5nQGh1YXdlaS5jb207IGh1YW5nZGFvZGVAaHVhd2VpLmNvbQ0K
U3ViamVjdDogUmU6IFtQQVRDSCB2MiAwLzJdIG1haWxib3g6IHBjYzogU3VwcG9ydCBwbGF0Zm9y
bSBub3RpZmljYXRpb24gZm9yIHR5cGU0IGFuZCBzaGFyZWQgaW50ZXJydXB0DQoNCg0K5ZyoIDIw
MjMvMy8yNyAyMDozMSwgbGlodWlzb25nIChDKSDlhpnpgZM6DQo+DQo+IOWcqCAyMDIzLzMvMjcg
MTk6MzMsIFN1ZGVlcCBIb2xsYSDlhpnpgZM6DQo+PiBPbiBUdWUsIE1hciAxNCwgMjAyMyBhdCAw
NzoxMTozM1BNICswODAwLCBIdWlzb25nIExpIHdyb3RlOg0KPj4+IFBDQyBzdXBwb3J0cyBwcm9j
ZXNzaW5nIHBsYXRmb3JtIG5vdGlmaWNhdGlvbiBmb3Igc2xhdmUgc3Vic3BhY2VzIA0KPj4+IGFu
ZCBzaGFyZWQgaW50ZXJydXB0IGZvciBtdWx0aXBsZSBzdWJzcGFjZXMuDQo+Pj4NCj4+IE90aGVy
IHRoYW4gYSBzdXBlciBtaW5vciBuaXQgaW4gdGhlIHBhdGNoIDEvMiwgdGhpcyBsb29rcyBnb29k
IHRvIG1lLg0KPj4gSXQgd291bGQgYmUgZ29vZCBpZiB3ZSBjYW4gZ2V0IHRlc3RlZC1ieSBmcm9t
IFJvYmJpZSBLaW5nIA0KPj4gPHJvYmJpZWtAeHNpZ2h0bGFicy5jb20+DQo+Pg0KPj4gUmV2aWV3
ZWQtYnk6IFN1ZGVlcCBIb2xsYSA8c3VkZWVwLmhvbGxhQGFybS5jb20+DQo+IFRoYW5rcyBmb3Ig
eW91ciByZXZpZXcu8J+YgQ0KPg0KPiBAUm9iYmllIEtpbmcsIGNhbiB5b3UgZ2l2ZSB1cyBzb21l
IGZlZWRiYWNrPw0KPiBMb29raW5nIGZvcndhcmQgdG8geW91IHJlcGx5Lg0KPg0KPg0KQFJvYmJp
ZSBLaW5nLCBraW5kbHkgcGluZy4NCg==
