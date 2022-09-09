Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201A95B362D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiIILSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIILR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:17:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA9B9C526;
        Fri,  9 Sep 2022 04:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hk458XDP1rqUMxHv2xXNDimp9W6aVb3kQDBiwM+R1VBZXZGikzjCreODS3YqmVXyZ/Y5s2iQjBqv5mu68uGjzZfvObfnbKXHh6TJhGtnwl8dLTac/qWs/GI72brK0Q5Y1/KipMdS5YgJPAzOKza/YPHlzyQHVSZxsFU9QXtbHcE0tfYceJ7RnPM44h0HhgRlhhCPhkdrssc6NYPoXuazkPAdLHWN4/DjjWaibmt3Ll3tlF069t2OJ1W/ioJAvuilXE0mdKxQKHz3Dqt3AfhHC4SLilbdXPuKMg51L+fbSwau95vy0mmL+UE3HMtAtgtsoLUbj/C9ePsLvf5GmfbSvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJ7gEdnSWnpXs+waiJiw9cvJXLRFdFuK2REpiy85WUQ=;
 b=EcWXhv8/0RmlurvHERGQiZp4GuWKAedx6JGlMGbCl5LDhdNeN4itYT+W2RpZF0ALIVC/5V9M2FjWimKR8Rw6dXOLcf0zv2OWSWXMnZdZFJ9/PumpixgU+wk19UA8xBHfzEmeXiluTr/9DFLz4IrIgrtbh3hZaene6hpHnBxtqolm/4joVpAniVD6yfBgtblYE2jo++LcIOcMkYfcNUhldvw29XPLdPIzKF/gFVac3W4UV3uZ6FbP2PBj0qh7kV27SKlrqoqgQP2f8zwViyPIEDA8MJb2HgwqLWBp58HxZFAwY8WFI1McEZiyyaz/UJUOdzi/zcZ5rA/HopiRAjjkMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ7gEdnSWnpXs+waiJiw9cvJXLRFdFuK2REpiy85WUQ=;
 b=cAMOgAqnLi+PuHOvmvMNKEe0HPrY9Kz8VlFujmTYJD4qQpxU8xPjBQ8isdt7xmuIb17+70+Dah0odVOF5Ft7sPloGz5mv5/ocJO65AR2Sffca3K5wKKUeCQpfAygjQZ4ruXD+UJFXa8JQ276IuBuLpgyXJHJBw9nWS8vMeU1K2cQqT/qgW/ara+8GnGgz0XFe+HhTRXL94DNtWn4nGyMHv1Upebd8uCdLAQUHVw73ZfLMTNFRSrFObfMLID726xgLdseU+KjebMTIWsetcDI6HDlANMmB0nFG1KojFh7mT6AB2/28BMcumETul2Puf2JviluVu1INZH1eEVlJGGOsA==
Received: from DM5PR12MB1628.namprd12.prod.outlook.com (2603:10b6:4:7::13) by
 SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.18; Fri, 9 Sep 2022 11:17:57 +0000
Received: from DM5PR12MB1628.namprd12.prod.outlook.com
 ([fe80::a454:b4a3:1f88:2df8]) by DM5PR12MB1628.namprd12.prod.outlook.com
 ([fe80::a454:b4a3:1f88:2df8%4]) with mapi id 15.20.5612.014; Fri, 9 Sep 2022
 11:17:56 +0000
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
Subject: RE: [PATCH 1/3] dt-bindings: pwm: tegra: Add compatible string for
 Tegra234
Thread-Topic: [PATCH 1/3] dt-bindings: pwm: tegra: Add compatible string for
 Tegra234
Thread-Index: AQHYwoKzkCImIQLrzkK18TAID36csq3Vc86AgAGB1PA=
Date:   Fri, 9 Sep 2022 11:17:56 +0000
Message-ID: <DM5PR12MB16283364646CBD853C89B425AD439@DM5PR12MB1628.namprd12.prod.outlook.com>
References: <20220907062545.30203-1-spatra@nvidia.com>
 <75d5e29e-7418-3b8f-f549-6a69fd479852@linaro.org>
In-Reply-To: <75d5e29e-7418-3b8f-f549-6a69fd479852@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1628:EE_|SA0PR12MB4576:EE_
x-ms-office365-filtering-correlation-id: 0abf15b1-5ec3-43ae-a4e2-08da9254f244
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SmGCMVRhp3hHEy3LVUbmsEYQJfHgUT1dJmQUQ97YJxf4cRwgAx8DTRZYABGS1B54uyUOXU7RaXm0hBdq3baDSRetnApNXam4DfVI/eWlvHMYq/EmAjCD2uiV8ilfRD9iYpUEAUzAUoPrc2C3nDzL5c2LPfzOD7Ci5kQsc7OS4lFQ01eiKlW2bl7wyDKuRkw91h1YTOnzO1SaE5iXhZ9GZFnHjnVcy53sNmdoDWh5iwcru+9CxWpdod9o81PQe2ECaPW/1kmpIBpGHemUNrk0V9c+eY14QXu23kNhSKxlfDqLeNkMJXPy/r4+zXy/9qYztRXsNyE2QQDNYrYuiNWjpmwzw8eaxMpVYUswGIRCUWfp2QOOckBYOcaFd0hmRnAbp14dssfTSyr3Nyqft68lgYlv3ApjGnboV5iJkmo1eWuOqE6tAalrWYUZ9uJ7zTda0Z2s5uRopFzO8KkYEQ2UIHgEiKSsqrA5iGvoOnZIuBn3VQGsVCw5yYyAoJ6wQeE16hUAhQtWbQBUKovH9JcRx3+MCc4PwD/3e1EEGrwfx/yTHz51qVdSKN/aGFn0S2nMVfJUUBZBTL6VoaZcrZiCDnWvNXGcOMdtTNwwOb8zvy3qAdSd7BOyPmWGCNi1xlQEkemDtKUtdgru3hW/WWXr6m7sB3iOoPBxLiF7cCwnkY8uBaZJ0LErWwKlzYy8U9pER/GQCKq//RFMvprYiwJUK1jiweJR05/by6CPSqMQg8f+aflbCgZMZ6fmxLJvrdVP+ssIOMXlniRiWY2mVf4bVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1628.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(54906003)(478600001)(9686003)(316002)(26005)(107886003)(41300700001)(110136005)(33656002)(86362001)(186003)(71200400001)(83380400001)(64756008)(66556008)(66946007)(76116006)(2906002)(8936002)(5660300002)(52536014)(55016003)(8676002)(4326008)(66446008)(66476007)(53546011)(7696005)(6506007)(122000001)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U05QdFFOZlJ3Z2xXREM1eXE0V2ppc0xLR0h6RkpTZXBPVFp6aFFldERPeTFH?=
 =?utf-8?B?YkZZaEZhbFVDZVpkN2N2bHdTM0M5WXRmVXdQUXJlcVJtM25UcWhVaG1MMFhZ?=
 =?utf-8?B?cm9GVjluWUVteTB4MWluSUpDSTJ0bzN0TXk1a3FJVXBDaDVpS2d0cUEyQnRI?=
 =?utf-8?B?Y0pNb1paYUpoeUtVZ0lGdXRWRW1KV0RXZTZDNVNxdzM3M0F4TC9BRVJlbHRG?=
 =?utf-8?B?YjlpRlUvTU9aT3pJRU9Za0pxMWlEQ04yMmxwQ3p2a0ZMbm9Vb24wbStaakFK?=
 =?utf-8?B?cHloMVc3bDVVRUJaMkl6VGpmRTJFbURVZHlNZlV6ZjhnL3NrWE0rNDltQSs1?=
 =?utf-8?B?aUJsSERZc2RtR1hOSGNUdXQ1RFhCK2FIQkRiVkJIUFUyMk1SeHp5b1VGMVdX?=
 =?utf-8?B?dGd1OE9TOFdRRHc0WllRMTJZQ2ZaT096UGZpOXlzcEJYYlRjbmhPNWQvZHpp?=
 =?utf-8?B?Zmd1MUZWYzJveGZ1V05pYndyQnlUS1JKMnRqMEh2Y2xLYTY5WUhJb2s0MHdX?=
 =?utf-8?B?Y212UGZmUXZ4aWdGWnRxNGM0czcvenZGVVR2RkcvSkN4bDMwOEkrY0MzdUww?=
 =?utf-8?B?K3dhWDBPcjVocldmTW5LRUNxS081OWFUUTVSNUU2U3RPaGljd0lkMG1GSDlZ?=
 =?utf-8?B?UjFDL2JlL2VHYUd0SnZicTBGY2J5eUNJdkRzSWlNdkJScVJCZ0RIa1IzU0l4?=
 =?utf-8?B?Um5HUk5Rc0pNYmVjUlNUbWtGMThVblEzOXoycHR5Q3ZmNWVHbm51UElzT09X?=
 =?utf-8?B?NVU0RTVQdXVSRVhLK2dKd2VpZEphbGNjTkFWek9GN0N6RGtIU3FBTDNEa1V2?=
 =?utf-8?B?K0s4eExaV0JLeVB5OFJwT21EMmdJM0NDZXQvbFRPWjR1TURQdlVrRkZzYVRZ?=
 =?utf-8?B?c0srWXNJY0ZrQ3hzcFhRazhGeDNHK1pNamFrRWxPcVlsSlJQd1VVOWZEbGZJ?=
 =?utf-8?B?OU1kVlFhWFBQcTllbE9lWEE0Ri9TWWw4bG9IbmNqLzZuVGY3S0RGNFd0WHN3?=
 =?utf-8?B?bFE1RkxWdys0WnJVRlpaK2RGWEV3UUowaVlJdi93SzhINzJDM01uSkx6SVJG?=
 =?utf-8?B?eWNtTk9FT1ZjQUhIcldrMkZkWEV0cnN2SGdVSnpaK2E4NEltdXY3ZE9RZjJa?=
 =?utf-8?B?cHF2N0l1ZDhtcTVFdkZEU3VnWXVtd3Vxc3BxMERTZHcyNXRtTVJGakxEaFc0?=
 =?utf-8?B?S3hBa2JoN0xCbWxNM1QzOWxYTDk3SG4yWXdmUm94VU91YnROTktNd0RKYnhk?=
 =?utf-8?B?dVNvemVZS0tDV3hzcEE5WDhrTmN1UmkybmxXbEZmMnRCVEFxNTNGbGtYZ2cw?=
 =?utf-8?B?OUorVE5GQ1lPQkhTUVhLcnJXWXc0RG83bUtKNE9NZmwrL1pSWVRaV1hNcllq?=
 =?utf-8?B?ZjhiQkx3ankrcVpQMUlCUFM3V3FzTTRsNTIxZk1ubk9wNFJGQmQrRGVRMW1v?=
 =?utf-8?B?TEhLMEY2TXM1dm50Nnh2bDRucVdNTTNUbXplZnVnL3pnQXVqKzNpL1hzNGpJ?=
 =?utf-8?B?Z09GcmhEcmJ1TDFQRFhpMzlaUFlXQjBvWVVqS3RaK25oNDgxQm82QUwvV0Fo?=
 =?utf-8?B?VmpZWkNkaVVpenZDeG1QZGVUdmc3L0xjWW5SOWkrUUtDUG96QlZ1RGV2L0o4?=
 =?utf-8?B?bVBTNzdPNTl0RGNkSm8vZU5WYkl1ai9CZkswT1RpVzAwRnZKaTNSQjRSQWQw?=
 =?utf-8?B?N2hVbEVXUm5ER29FaERvUE5lK0lVLzIvSWFHN1lzQ1pNVjd3ZHhYS2dHMzhD?=
 =?utf-8?B?RHhLbVRBWDFhbjlVeHpYakVLWGxpL1U2ODJ0K2cyTVV4cjNGcm5QaERyS1Jn?=
 =?utf-8?B?UEVhOWNoRnFlblQ5LzFRK1VEWlN2UUh1VDVOaGE0RTVDcTRVMjdpOUlMNlJO?=
 =?utf-8?B?VytGL1Z2Y1VkWEk2V2cyMDZHeHE4VlpQVFBZVFIxdnlxYm1MbkxGUEhyUEZM?=
 =?utf-8?B?Y1hWa2twRXJHTlQvdzBWQml2a1crcEN3cDMycTNNa1FQWXpKT3Zoellhd2tT?=
 =?utf-8?B?WTJ4a25SZVYwQzJWT3MrNnRNLzNzVzh3WmtDLzF4ZTFyNzFOWWZYY1VlVm00?=
 =?utf-8?B?NUdXSCtLelViU3NvcUZDUE5wcXVUQUJXKzhFRFN2NDZucVBIQUQzclBZTVFT?=
 =?utf-8?Q?iHjo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1628.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abf15b1-5ec3-43ae-a4e2-08da9254f244
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 11:17:56.5683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H7JTw/udnMttmdHrbpn2jCcc30fQz7xFFomfFbVChNCIunVwyhidXt/EtQuQ1xAWlvF3MU5/LVdxFjNxod1daA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4576
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIFNl
cHRlbWJlciA4LCAyMDIyIDU6NDQgUE0NCj4gVG86IFNhbmRpcGFuIFBhdHJhIDxzcGF0cmFAbnZp
ZGlhLmNvbT47IHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbTsNCj4gSm9uYXRoYW4gSHVudGVyIDxq
b25hdGhhbmhAbnZpZGlhLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtv
emxvd3NraStkdEBsaW5hcm8ub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgt
DQo+IHRlZ3JhQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiBDYzogQmliZWsgQmFzdSA8YmJhc3VAbnZpZGlhLmNvbT47IEtyaXNobmEgWWFybGFnYWRkYQ0K
PiA8a3lhcmxhZ2FkZGFAbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGR0
LWJpbmRpbmdzOiBwd206IHRlZ3JhOiBBZGQgY29tcGF0aWJsZSBzdHJpbmcgZm9yDQo+IFRlZ3Jh
MjM0DQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBh
dHRhY2htZW50cw0KPiANCj4gDQo+IE9uIDA3LzA5LzIwMjIgMDg6MjUsIFNhbmRpcGFuIFBhdHJh
IHdyb3RlOg0KPiA+IFRlZ3JhMjM0IGhhcyA4IGRpZmZlcmVudCBQV00gY29udHJvbGxlcnMgYW5k
IGVhY2ggY29udHJvbGxlciBoYXMgb25seQ0KPiA+IG9uZSBvdXRwdXQuIEFkZCBhIGRldmljZSB0
cmVlIGNvbXBhdGlibGUgc3RyaW5nIGZvciBUZWdyYTIzNC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFNhbmRpcGFuIFBhdHJhIDxzcGF0cmFAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9udmlkaWEsdGVncmEyMC1wd20udHh0
IHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9wd20vbnZpZGlhLHRlZ3JhMjAtcHdtLnR4dA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9udmlkaWEsdGVncmEyMC1wd20udHh0DQo+ID4gaW5kZXgg
NzRjNDFlMzRjM2I2Li4zMzFjMWU2NmU4ZmEgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9udmlkaWEsdGVncmEyMC1wd20udHh0DQo+ID4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9udmlkaWEsdGVncmEyMC1w
d20udHh0DQo+ID4gQEAgLTksNyArOSw3IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gICAg
LSAibnZpZGlhLHRlZ3JhMTMyLXB3bSIsICJudmlkaWEsdGVncmEyMC1wd20iOiBmb3IgVGVncmEx
MzINCj4gPiAgICAtICJudmlkaWEsdGVncmEyMTAtcHdtIiwgIm52aWRpYSx0ZWdyYTIwLXB3bSI6
IGZvciBUZWdyYTIxMA0KPiA+ICAgIC0gIm52aWRpYSx0ZWdyYTE4Ni1wd20iOiBmb3IgVGVncmEx
ODYNCj4gPiAtICAtICJudmlkaWEsdGVncmExOTQtcHdtIjogZm9yIFRlZ3JhMTk0DQo+ID4gKyAg
LSAibnZpZGlhLHRlZ3JhMTk0LXB3bSI6IGZvciBUZWdyYTE5NCwgVGVncmEyMzQNCj4gDQo+IFRo
ZSBjb21taXQgbXNnIHN1Z2dlc3QgaXQgaXMgZGlmZmVyZW50LiBBcmUgeW91IHN1cmUgdGhleSBh
cmUgZXhhY3RseSB0aGUNCj4gc2FtZT8gSWYgbm90IHRoZSBzYW1lLCBidXQgY29tcGF0aWJsZSwg
eW91IHNob3VsZCB1c2UgZmFsbGJhY2suDQoNClRlZ3JhMTk0IGFuZCBUZWdyYTIzNCBhcmUgMiBk
aWZmZXJlbnQgY2hpcHMgdXNpbmcgZXhhY3RseSBzYW1lIHB3bSBtb2R1bGUgYW5kIGR0IG5vZGUu
DQpUaGlzIGNoYW5nZSBpcyB0byBjb252ZXkgdGhhdCBzYW1lIGNvbXBhdGlibGUgaXMgdXNlZCBm
b3IgVGVncmEyMzQgYXMgd2VsbC4NCg0KVGhhbmtzICYgUmVnYXJkcywNClNhbmRpcGFuDQo+IA0K
PiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
