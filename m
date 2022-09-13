Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2EB5B7508
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbiIMPex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiIMPcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:32:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20614.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4BC7F11B;
        Tue, 13 Sep 2022 07:40:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOvMAXIcWHFiLaViWZR+AQ0kvvgh/2jWqLhEUpKh7/ieq9Zoyq9UH/53ZSWtQTT+sdCYpKB7nRmGC8zuHeAQW6gANPNNNud83bP+W72QIsNGog3Dmhimw8v6K+IJUD387Yr230D5dvl2FnUlHjnl9vDIzZfVHK/LH8lXsS7S5a0L1LDVVyQmAzJIP1JZmzvQFgHgIqux3qrfFnG0qthQaRdCD9ApYXhSHVGUyCBAQjLTKePRoeJ7IeU/+rz492zsyTrBqN2PSkDxPYRfCRXtVC7o0GsJREE25+xC7Wlbbgjprn9icZ5hQBM2x5aLn+hGRLIrwY4Vd7Mxxjb/KJxiiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iML1pjv76+N+4MJBXxyRQhNziZPfio8FHY6mXctpsCQ=;
 b=SkCnviXH/zqTWN0UWp0KtfqdJ14YdppCG9CkLpwNEZABX42uhACrwPtyq8WWSbgb1Z1gJRzbpkm7afeL0LyJnIs7X0LLZTgRPvXa1h3Cpn4r3nKqmPyFb/wIKrbt+ZJO7LKN6u0e8ev4T+Xdl0A+7an0t+8w8e25XQm7F26LIo6C6Qh96ZkgeB31ToZ5nEiDgmWwbUMYekxnktvmQbt5aH96L3NusnZFJarOUo/fNE6QtgO2F8C3qrJCVENHkPLiWujmi/cD34Npj11vZ5CNTYFM13tT8W4C1tPnM6IoWVmD36ULonQFhL+M9Vv+/m5+69QdlUO9rIAotA4qEXMuSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iML1pjv76+N+4MJBXxyRQhNziZPfio8FHY6mXctpsCQ=;
 b=XhTuZI/E+G6AZ+ZaJlwG0d+q4KKI/G0BbllaD7lDqcHIkCeyxj4w1wni5DjuaSqZaeGFhxvxHUx34zF/nLodIyqlphv4IDMKv3jQ9VuUZVRlVrpHrv5OGJWT23oCdAaHpj5E0LC3DLrjNr8tZN28RtmiCRQ4Wj5ZGztlJYyHzscV+8p3eL0dm/Zr09u57xpb+b3KLI8wsXS95v3knkI3PQFP5IlUPWI6JNUN6wl4GjMTpM/EYkXKX8kapMaiCSM0Vvqp5MFrFgapmtHf23dWmXSOzFVaFZ8nybcaqeSvaT1SgEgH8NTa1F+6DPSh8nKwwEAVOiOP4VDI35c0KBJ9rQ==
Received: from DM5PR12MB1628.namprd12.prod.outlook.com (2603:10b6:4:7::13) by
 CH0PR12MB5043.namprd12.prod.outlook.com (2603:10b6:610:e2::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.14; Tue, 13 Sep 2022 14:37:36 +0000
Received: from DM5PR12MB1628.namprd12.prod.outlook.com
 ([fe80::a454:b4a3:1f88:2df8]) by DM5PR12MB1628.namprd12.prod.outlook.com
 ([fe80::a454:b4a3:1f88:2df8%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 14:37:36 +0000
From:   Sandipan Patra <spatra@nvidia.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bibek Basu <bbasu@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: RE: [PATCH] dt-bindings: pwm: tegra: Document Tegra234 pwm binding
Thread-Topic: [PATCH] dt-bindings: pwm: tegra: Document Tegra234 pwm binding
Thread-Index: AQHYxGRAKudgDBkxikOy2Mf6sroe7q3XTI8AgAYSEaA=
Date:   Tue, 13 Sep 2022 14:37:36 +0000
Message-ID: <DM5PR12MB162858E3B9A10525C0DD6339AD479@DM5PR12MB1628.namprd12.prod.outlook.com>
References: <20220909155258.17908-1-spatra@nvidia.com>
 <7585e56e-0983-de27-7c1b-9ec30898d4bd@linaro.org>
In-Reply-To: <7585e56e-0983-de27-7c1b-9ec30898d4bd@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1628:EE_|CH0PR12MB5043:EE_
x-ms-office365-filtering-correlation-id: 6c50e8f3-ab2e-4451-5e15-08da95958075
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kPDwEI8kdK5uB+dLQBMInyzIpeD4c14MmhNf1nqmp4ekQg9+cqbSxKRst59Z/5WDbcpwb2rkuN3+ULhQIIblHAOOkUHopbJkgEXd5VorKDg/yR78eVIoDPxhpG4VkjC94OShDTIeKVGIh01Yl+lztXyUjJoVRQr4uMMHUfVZVrpUAoJW7m2UXk2R05OFt4islsFvC+9X6p39Clzrm930sP0JaBZIdsxqucJ8moug3naR76qiooUD9CNVMkEKqrS4W+oHFd4ZXFZdHgOcVVqO3m2R34b2vZtw7BideOwEq2j7jC8fycYaxQoUO/d8bho3xJgMCLTFOSLsAEOcQ7vMU5MSwAOxIBDgrqq08bgqYFWytO+c9E8Fl1DtY2kmB5egIQNElVzNUfUA7EIEaEv0nMzgc+YIoFCaA49/tZRYPC6A7yc9Bu5of1eSsvA/LX0nMamA7aUe7GO08+Xvh2lICPSDgQdQa6wpVpwrJpifkHmbGqeAP7XlPVCy5q1NKZgx2fZEL+7xop5X0Vyhzp3oqUw5/Hp5mpyGIy/vwlrMEVokDhOAIIJiYmjp6J4DB3njd6xqdFo0TVQYZAgL/VlqcrmreyvxCGKIJhKKf0FPnUffUMYUS9GarvdCWxitsBlxyqXyzN6HlM3H0rw70rOxGhBWrBGNrNvGgTdHpkLBexxzBjGCRMQREVVxOxYKhWND920MJ1SHF/BpVtb+wKUzEfVVSlLF7sgfHZ5yiiGlJ5bsdCfVcVEiPp6wpjzPKnPI7HJUnKs1WyIwWREVSdCYjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1628.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199015)(4326008)(122000001)(5660300002)(52536014)(8936002)(8676002)(76116006)(66446008)(107886003)(64756008)(2906002)(66946007)(316002)(55016003)(9686003)(41300700001)(86362001)(38100700002)(33656002)(54906003)(71200400001)(66556008)(6506007)(66476007)(53546011)(186003)(110136005)(83380400001)(478600001)(26005)(7696005)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlRTb0hoUUNUNktpZFEzNmt5dkZSYitpSDN5dVQvOFFCcnNrTjcwb290QVZ0?=
 =?utf-8?B?ZEN5MzJlbk1RcEU4TGl6aHVsRjlIV2plQWlDNkI5cVVKZHRvUEhtWFcrdUx3?=
 =?utf-8?B?eUU5U21BeWpaN3VXMjc2Q2NFV0k0cmwyQUdRN1ZmUjZ4emFjc0dDOWIxUWZ6?=
 =?utf-8?B?NVlmTzlqYWIwVTEzUld4ZkNCWm8zMSsxcVprRFE3Nlg0a2R6UTR3NUFBeFRp?=
 =?utf-8?B?bXRyeERwQzQ2Y1BXVnhRMnJqcVFWMXJXU2dReDFjWEdHa3Q0eXlVZnlEajEz?=
 =?utf-8?B?clkvS3ZsaVE0QllKUUNpRllRVWNkUUNjMTg1bGdjVDRSbUFuSWhvdUxjTFRu?=
 =?utf-8?B?OE9kZkFWT3BNSTBYYUhObFlVQlMyeWhmdzVLMDgvSnNNVUx0ZjdXMXhVN1Er?=
 =?utf-8?B?ZmZ4dGYwNlh4a3k1dGRXcHF0ck1qUWJYK09zK3V5YklZL3dvMEJYNHpjMW5x?=
 =?utf-8?B?VDVFUm56MlNNL00xQ0pqOUlsWnZrUEpTU3pzZExaQmxvVjcrSms4cU9WNXVK?=
 =?utf-8?B?ckVPK2RSUXFLVWVza3g0TkhvZUcreGF1ZEVuM3ZjMURnK051ODJMUVV1ekNh?=
 =?utf-8?B?a3U4cTVFM0p5a0tsQ1puQWtaZXpUTDB3bjNOUmxDeXBXc0RoOVhSVG9kSTBO?=
 =?utf-8?B?RFkrOWxsNVBTcGJLOExmT2NRNVNIblk2SFVMUkhwbTZiUTFNZDR0cUdGd3Vu?=
 =?utf-8?B?RjJoS1dudFh4T1NoYURLcE5tZ2c4ZnZYczVIMUNpcWlCbXFRN2ZBeHBLd3pL?=
 =?utf-8?B?QTF2cWpKU0p4dHRIRGgyZitwOHc5cFVwMUpOUDI0VHBxbWd0VU90ZjA3WDV6?=
 =?utf-8?B?ajNMdXgzVTJXaEZ2d0FDODFqcTFDakx3SHIrZkt1RWF4bmM4cGEzYlRkTnZT?=
 =?utf-8?B?K2s3QUx1T2dta0lzbituUkJhaEFIWHptT3dwN1luMzVKK3R5ejYwdHVIaXRt?=
 =?utf-8?B?QUhEVWg2Vnd6NXpXaS9pL0JKWUZkSkhmWFFPOXJsbjhFRjNqM0QyelRNT3My?=
 =?utf-8?B?Y3BSeUFlaytOV0tkS3NSRFRIRnBCVnJxOTQ1WWx4Q1FrR2daU3ZYWTdhYStE?=
 =?utf-8?B?WWdCR2NvTUFyVGdTQjFzWHJ3VXdHeUJva3JVa25vS1JMZVRleFp6aXZxNnNE?=
 =?utf-8?B?Z2h6UlpvNGZKc2hzK2pObno0Rk1PNE5EYlp3UUtiMUdud2gwK2cxdDcxYXhX?=
 =?utf-8?B?WWFTcGpYUGkrSEpzVVJhY3I4UnlRbUR3Z0dxTFBGY2pHNm5XSGpnUzZnRkQv?=
 =?utf-8?B?MmZhc3hYcUcyQmJUOHFqQnUwL0k4QUgyVGJ1N1Y5YUVUc1VqU1BmeDVEdzdh?=
 =?utf-8?B?L29rWWticTQzNVVtaGE2bDVTVlhraU1hS2gxd2lnOC9Oa3FxM00wS244eVNS?=
 =?utf-8?B?bTJ6dXI1N0h2S3pyeFBiVldmNEhZTFJFbk9sZnI1UXlqWXZFVG93dzZ0SEhB?=
 =?utf-8?B?MTB3RE1Jdjc3eXN4MDlVelFhSzFjY2dmam1vaEo4VDQ5ZnphUUtlT1BMMkJR?=
 =?utf-8?B?ZlAzWkFwa2VQM1ZIMzlmSFZCQkNlTXoydGFhQ1pyTnlRV24yQnQ3WklUNk9Q?=
 =?utf-8?B?ZWRhTkNDcE5oeFN0ZisyNHFsbjBrNzFqWXYrTHRmZWxuMXYyQURsNk83YkpZ?=
 =?utf-8?B?YS9OMXA4ZWR5d1ZqYjhrRFlqcURHS1d6U0ZldnpYcEZpK0dIZ0lUZHdJekZs?=
 =?utf-8?B?dFdRVUZkK21sa0g4Zy9oazF4SmlkaWk2cTVDYy9xU0tVaDJuY29ZVVlERVVN?=
 =?utf-8?B?dWYydFBFTm1pek9JNTZJcDBmRWdKZStzUXZFT0QyUWlJVXA1enluOENVbVBu?=
 =?utf-8?B?M2xhN3NHbTVMOEhYSjhkM2hjNWdQQWdiYUJiUGpONDRKcS9FVjRuVXdiTDk5?=
 =?utf-8?B?cEcreWhndlBWM25PZmV3amU0bGhPV1pqdFpsdnArcWlRbmtialZ5N08vRTNo?=
 =?utf-8?B?UFpSb0FJaXJKMXZUbURGTU5oVitLazY1SEk2Q1F2QWNMSzZKYjg2aDFIMElP?=
 =?utf-8?B?ODJPUmhHQmE1cFVXM3VDOVhVMnJPcllJY1VlR3c0cjF1YTdHUEsvcnNpQjBo?=
 =?utf-8?B?NHJpcmN3ZHl6dm5uWkF6MWtNc28reFFla3BWSnRjWXJ0QkJXbUNjL3JGWDdk?=
 =?utf-8?Q?v/zk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1628.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c50e8f3-ab2e-4451-5e15-08da95958075
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 14:37:36.3875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6eIlvHkf170FqD1HV6B7lwxVK5gOK0kal9oaGcfuuQqKnYDYSsNJxTyP2HcUcKbBKAQLD3ftw5G28rq1mGiIpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5043
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIFNl
cHRlbWJlciA5LCAyMDIyIDEwOjA5IFBNDQo+IFRvOiBTYW5kaXBhbiBQYXRyYSA8c3BhdHJhQG52
aWRpYS5jb20+OyB0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb207DQo+IEpvbmF0aGFuIEh1bnRlciA8
am9uYXRoYW5oQG52aWRpYS5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5r
b3psb3dza2krZHRAbGluYXJvLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LQ0KPiB0ZWdyYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gQ2M6IEJpYmVrIEJhc3UgPGJiYXN1QG52aWRpYS5jb20+OyBLcmlzaG5hIFlhcmxhZ2FkZGEN
Cj4gPGt5YXJsYWdhZGRhQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGR0LWJp
bmRpbmdzOiBwd206IHRlZ3JhOiBEb2N1bWVudCBUZWdyYTIzNCBwd20NCj4gYmluZGluZw0KPiAN
Cj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVu
dHMNCj4gDQo+IA0KPiBPbiAwOS8wOS8yMDIyIDE3OjUyLCBTYW5kaXBhbiBQYXRyYSB3cm90ZToN
Cj4gPiBUaGUgUFdNIGNvbnRyb2xsZXIgYmxvY2tzIGFyZSBpZGVudGljYWwgdG8gb25lcyBmb3Vu
ZCBvbiB0aGUNCj4gPiBUZWdyYTE5NCBTb0MuIE5vIGRyaXZlciBjaGFuZ2VzIGFyZSByZXF1aXJl
ZCBhbmQgY29tcGF0aWJsZSBzdHJpbmcNCj4gPiAibnZpZGlhLHRlZ3JhMTk0LXB3bSIgd2lsbCBi
ZSB1c2VkIGFzIGEgZmFsbGJhY2suDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTYW5kaXBhbiBQ
YXRyYSA8c3BhdHJhQG52aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gVjQ6IE1lbnRpb24gZmFsbGJh
Y2sgY29tcGF0aWJsZQ0KPiANCj4gVGhlIHBhdGNoIGlzIG5vdCB0aXRsZWQgdjQuDQoNClRoaXMg
d2FzIG15IG1pc3Rha2UuIFdpbGwgdXBkYXRlIGluIG5leHQgcGF0Y2guDQo+IA0KPiA+DQo+ID4g
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vbnZpZGlhLHRlZ3JhMjAtcHdt
LnR4dCB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcHdtL252aWRpYSx0ZWdyYTIwLXB3bS50eHQNCj4gPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vbnZpZGlhLHRlZ3JhMjAtcHdtLnR4dA0KPiA+IGlu
ZGV4IDc0YzQxZTM0YzNiNi4uMzMxYzFlNjZlOGZhIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vbnZpZGlhLHRlZ3JhMjAtcHdtLnR4dA0KPiA+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vbnZpZGlhLHRlZ3Jh
MjAtcHdtLnR4dA0KPiA+IEBAIC05LDcgKzksNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+
ICAgIC0gIm52aWRpYSx0ZWdyYTEzMi1wd20iLCAibnZpZGlhLHRlZ3JhMjAtcHdtIjogZm9yIFRl
Z3JhMTMyDQo+ID4gICAgLSAibnZpZGlhLHRlZ3JhMjEwLXB3bSIsICJudmlkaWEsdGVncmEyMC1w
d20iOiBmb3IgVGVncmEyMTANCj4gPiAgICAtICJudmlkaWEsdGVncmExODYtcHdtIjogZm9yIFRl
Z3JhMTg2DQo+ID4gLSAgLSAibnZpZGlhLHRlZ3JhMTk0LXB3bSI6IGZvciBUZWdyYTE5NA0KPiA+
ICsgIC0gIm52aWRpYSx0ZWdyYTE5NC1wd20iOiBmb3IgVGVncmExOTQsIFRlZ3JhMjM0DQo+IA0K
PiBObyBkaWZmZXJlbmNlcyBoZXJlLiBZb3Ugc2VudCBzb21ldGhpbmcgb2xkLi4uDQoNCk15IHVu
ZGVyc3RhbmRpbmcgd2FzIG5vdCBhbGlnbmVkLiBXaWxsIHVwZGF0ZSB0aGUgZml4IHdpdGggbmV3
IHBhdGNoLg0KDQpUaGFua3MgJiBSZWdhcmRzLA0KU2FuZGlwYW4NCg0KPiANCj4gQmVzdCByZWdh
cmRzLA0KPiBLcnp5c3p0b2YNCg==
