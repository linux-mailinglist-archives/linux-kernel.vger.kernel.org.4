Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085C57317E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344535AbjFOLvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344939AbjFOLu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:50:28 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9474EE8;
        Thu, 15 Jun 2023 04:46:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbQKrV4bcIIXjN8hqh8UexwAAdXcXdgcoNIPKUtD59l1ZZyhfMbU2O7H6U5ZVgLj+A4PwT2f0YVdMd0FjgLKRMbG+UbAu8kM1CoYvNOkHGqsi96UeCIiB81ssiErIdnCf8sjiP5Y2gliD+8TfEKQmB1luXVwXFFCUmng5HtnEhJmI6EmiitderGe3cb1kcAGA5l/+fx+tDKnWHH8gA2DBRp38Qj9TvCrB08BpYdhcrTnNFnsFl8P0qsJkpZi0qK8oSvdc88DVX+zraaFBQAVGCTi9Rg+kB4pVkMMEONTqfwBj1qDOVpBHyCOVH4JNhCjvlzLUNK7Sq+9wlWTfr/u6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7ZLuC+Ml45AWesubicfetqTk6CYqHbfIelBkk8qX7s=;
 b=Jt6sADo8MfJNH7/+hi7tSYPS17Erz7QAWW5fLJlo6KlJBL91GUWFrmn/gE+t8eWLfmqlIWIsI5GMU0CgyKC/9hv1B78X7LBBXbRO/diiYAinDvc+djvBtNX3zoVt97kgbmW0xFs/ToNi3KpVO+q4vGzbCDiPddmgqpqulgaC5ePwSoC9/uV5UfAjhoM/WwivW9PE5E5MS5NGu6ByKU8GrOePJdKQtt7l4rfHotbW6YJejvFwKGNDpJE3ySEbVnACVqOWt3rFWw9jz6X0TgQuWSI6ml10v4iVvvLfqT09+KKSUdg9Y0vJq2B//z558TmauHmzQrO8pfAyAtFAPHWp6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7ZLuC+Ml45AWesubicfetqTk6CYqHbfIelBkk8qX7s=;
 b=HMjIwy3vaAG0N5cztZSIHdI5fp5T9zDvlNhvtQknMyTNpdk/Y8GiLIffwJLnUHwrjvgk03pmIMurY6PKwQIoy2rD96MMeaNfG7B365omVf/xYo62UKcr2qgcxwx+bl6L7dblRsVWZg2EH2cSfTP96hTXcv5lPnV0lHgtTBaYGBQ=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by AM7PR04MB7109.eurprd04.prod.outlook.com (2603:10a6:20b:117::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 11:45:07 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::eb27:f73a:5829:ae0e]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::eb27:f73a:5829:ae0e%4]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 11:45:07 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Victoria Milhoan <vicki.milhoan@freescale.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Vipul Kumar <vipul_kumar@mentor.com>
Subject: RE: [PATCH] crypto: caam - adjust RNG timing to support more devices
Thread-Topic: [PATCH] crypto: caam - adjust RNG timing to support more devices
Thread-Index: AQHZnQeduE1vqIKSYk+mI4eL3NOt7a+Lw5Ow
Date:   Thu, 15 Jun 2023 11:45:07 +0000
Message-ID: <AM0PR04MB60047C920624933DF21C186DE75BA@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230612082615.1255357-1-meenakshi.aggarwal@nxp.com>
In-Reply-To: <20230612082615.1255357-1-meenakshi.aggarwal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|AM7PR04MB7109:EE_
x-ms-office365-filtering-correlation-id: ae47607b-9a8e-487f-14d1-08db6d95f7c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wncbV11pKgjpY2nkc1rlFIvmKgjGfqJxPkgNPuDAS4VV2G/jysahdr+HtBRY4zEKVATvDsiswXTIb8jRGMhvHmV4H81o5IxOWzrgY3EeOPG8HCTwetLP2NSskAx9oXGp/H8ib8lSevZPrskfOI8E1/l9pdEdWr3x/3f0oZ4JxC+iMlxRFV5AvGIbdt7F6uvw1mXRzDbKXJjEKjDpr/TPQD0NXN99b412IpdjEuQbPCUpi3tQ9GZcwxYIi1989/UQslZGxYz05UnROZ0HcB2CfPfuW/C8swfrzzZzodgKhu9j65vUcxVc0xF5CTEZ1CZUvM6MIKtG7f4mF/ri0tfTPTJ6oTr76/gnPJv5ShiWBckoXC/j7qdxC4ofSkKUxXgNOBhGebicKQivPg/ifRkTvxX5C+dMRTrJDZn92l7JCaTOaLK+a5z2Hla1LueiOyiC6un898B8itfCbsU67XhqLcniOSrqAXFP9/gjnuK92m8ZlewTzbJZMlJZVO2AZpLwLXMw+reN8UsF5aMPtOgS34PZe9Z1z4HzE4/PSS/r9AopWPGPXrBI31/uFruW++Q+99r69ll14ga3gV2T+1sYEt3mtpc59Tx8xlh1FHZfLDo7xwDn0fFkQXTBbwHWEyQG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199021)(186003)(55016003)(7696005)(71200400001)(478600001)(52536014)(9686003)(26005)(53546011)(6506007)(55236004)(8676002)(41300700001)(8936002)(76116006)(316002)(5660300002)(4326008)(66446008)(66946007)(110136005)(64756008)(44832011)(54906003)(33656002)(38070700005)(66556008)(66476007)(122000001)(86362001)(2906002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE85L3UxdXFRNEFGQXQ1YllETng3eVBLdmJmbTJieG5zcEtucWFINkZZeHVw?=
 =?utf-8?B?L3hCalJudWxGd1RDYlNqZCs4S1JpQ2ZQbW9UaGM2ODFtVkdISWU5L2laSVE5?=
 =?utf-8?B?N0IrbmJ3WjlYMnN6NW9kREYzTjZmenE3TkZJcnROYjRSbUJkcC9lTm51Q3Nw?=
 =?utf-8?B?N281WS8yNnlPWE1IMy9rdjl4QVlKcEpWTTVDYkVwT3FPbHg0azB6Sk5XWC9k?=
 =?utf-8?B?cXBwVWVReUNOM0R0VzlOSDRya2Rtbm1RYXpxN1hFRGZOMkRiTnRUSno3clRq?=
 =?utf-8?B?WDVHWWQ1SFUybm9IWlFyckovSWNqdXhrRHVRZnNRSlk3Vm9iYVQ4WUp2dlhk?=
 =?utf-8?B?RDdUYnJMbmpQYXlucTNZWWdNZHMxeGlpOVU4WmhPKzl3cGdyZDhlNThuVUU4?=
 =?utf-8?B?S3RITCtIQXFrZzdMOGNnT0NYVXBHamVvSnpqWTUvV2oyR25nZlVCa2k0Y0RY?=
 =?utf-8?B?b1FkRGxnQy9yYndub1dSZWRqS3ZIWWx5M0pGcWM3QjlEdjNlVXJWemkvRHBq?=
 =?utf-8?B?SnVteUw3ZmhBeFFlTmVCK0VHTFY4LzZmMUJRUnpTa1gyMzZ0b2QyeUVMazJ4?=
 =?utf-8?B?Z29iTUJ5RjBWUDVndGcyTFcvSzBVeVpvd1N3bVVvNnhGZDVlVWFONGkwSUtI?=
 =?utf-8?B?T1R6a2J5TmZoUkNLN0RoVTg5RllLd2RNT2ZHSVptZFhBTGNMV2ZvRDRrYXZh?=
 =?utf-8?B?UHBkSk9SMFJCT2JiWlpJK3lkK3JIMk03cDFuUUtuWU1wczJ0Q0c4UFRaRndh?=
 =?utf-8?B?Zi8xOUFXVU5lVXVVVzNWWjZ6UnV3a01DOW1qbm9DMy9UMVIvWU1tYzdhakpk?=
 =?utf-8?B?TnhyY3V5UGtmVmdWS0NUcUl3TURIb1REcldvd2NrQkRlZnZPd293UkdUUG9Q?=
 =?utf-8?B?ZnRiangrdHJFSGhvR0hqOEVtbkkyUXVoYlF0WFByNEdPakEwUExmWmduTEpy?=
 =?utf-8?B?dHZhckZ2OTVRUHJXQnpZVHFmbVB1dXg5ZTFqK0huR2Vqblo3QlYwK2Y3b1FE?=
 =?utf-8?B?emlCRXFxdHQ4b0hUdlBMa0FLQkNTVFBXSkk0Mndnc3kvSS9xRW81cWx2cWFq?=
 =?utf-8?B?U2UwQWtFQmpScTRXNFlyZ3RRUldJU3g2cEV5QTdEblp4V1ArRE5uSDQ1Um9L?=
 =?utf-8?B?OGtZa2tuQll0ZjdvL1lPcVZMNWJFdHZ3SFdEaGVTNUxVQ3Z5cDA5Nmtkd3Vw?=
 =?utf-8?B?MkZmczlpTWlURk1zTEJJM2NSR0ZVc2pXRGo1cmF2QjNFWm1aOCs2aG5ELzhM?=
 =?utf-8?B?a3dsZFpkSkpDeEJURCt4cTlWYmp6YlBTeHB0aGpTM0YwTGM5UytQUVo0bnJW?=
 =?utf-8?B?bHcrM2FUNTFuc1ltTDdLOFhDVXNZdDNWYWZQOFFpeHhUZU00SlVDd0IwY2Jo?=
 =?utf-8?B?dWxjYWp2YXB6bEpybHlqT1p4Qk4vNGtpdWJMb2FyQXVsV2h0Z1cxTk9YY2VV?=
 =?utf-8?B?eXlPR2svbzZZb3NqVGQ1RHhHTWNmRGVCZGozWDAydHphak5sR0ZnQ1paVndN?=
 =?utf-8?B?MFQyQXczdUZSWHloWEozVWlFQ0E5NmNTenY0Kzd6V2FsR1hoQmM2MEJReDNm?=
 =?utf-8?B?bVZhUlIrT29UUXdkU1YxTjhNbEpITTVBYmZJTXNSdmFvcndJRlIvY1V0M2pZ?=
 =?utf-8?B?ZTcrMVdFRzF1dDRCaE9LQmJqNmRVWGhGeVlpMzNMaTVTWUlUZjRJa0p2bjJR?=
 =?utf-8?B?ZlRwdXZQQU0rZHQyeTduUy9rUHN3bEFRSS8xR3ZCb1prd3R3c3hHck03NHhw?=
 =?utf-8?B?ZHdtVlFSN3NWZFJRYTQxaDI3U3VibWpMYzFOUWFrZVo0TjArNjg1UGNkQUpC?=
 =?utf-8?B?QlMyUU1SVGREU00venZEdFlKVU5JN2tUNHFKL1UzUndLL2tPbWpOSFFkQ3hJ?=
 =?utf-8?B?TVNIam5LSjB1bXcyYVk5QnZhOVJJOGczU2h6N2V2a0p1TE9LQUIySFhwRGlj?=
 =?utf-8?B?aGZEaHN0ZG9GdmExZGk4aVNWQzY4WXlpTDA3UVRDWWZtRjNPZUE5UG9RbEU1?=
 =?utf-8?B?T1dGQUhBeG5DQmtnUEhXMk5RMllvMGY0SmpkYzE2d1gzVWJud1NSRDlHcDMv?=
 =?utf-8?B?eHlsN1VtWnRZelJ6RkVja3QxZW5VMVl1Z25hZ2VXMlBwUmg2VE5UVkZjaGdR?=
 =?utf-8?Q?OqHDhIGFGeKd80oPKy0ztZDcE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae47607b-9a8e-487f-14d1-08db6d95f7c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 11:45:07.7575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zy3RjqjFuo4NqGMZgVOkCKRuviwz1u/v/OGsAqVazaUPgnR2GyBoCT+1s7EgPUpSS1CHhnoEfwvD2z7lhrPjZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7109
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IEdhdXJhdiBKYWluIDxnYXVyYXYuamFpbkBueHAuY29tPg0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1lZW5ha3NoaSBBZ2dhcndhbCA8bWVlbmFr
c2hpLmFnZ2Fyd2FsQG54cC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSnVuZSAxMiwgMjAyMyAxOjU2
IFBNDQo+IFRvOiBIb3JpYSBHZWFudGEgPGhvcmlhLmdlYW50YUBueHAuY29tPjsgVmFydW4gU2V0
aGkgPFYuU2V0aGlAbnhwLmNvbT47DQo+IFBhbmthaiBHdXB0YSA8cGFua2FqLmd1cHRhQG54cC5j
b20+OyBHYXVyYXYgSmFpbiA8Z2F1cmF2LmphaW5AbnhwLmNvbT47DQo+IGhlcmJlcnRAZ29uZG9y
LmFwYW5hLm9yZy5hdTsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgbGludXgtDQo+IGNyeXB0b0B2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFZpY3Rvcmlh
IE1pbGhvYW4gPHZpY2tpLm1pbGhvYW5AZnJlZXNjYWxlLmNvbT47IERhbiBEb3VnbGFzcw0KPiA8
ZGFuLmRvdWdsYXNzQG54cC5jb20+OyBWaXB1bCBLdW1hciA8dmlwdWxfa3VtYXJAbWVudG9yLmNv
bT4NCj4gU3ViamVjdDogW1BBVENIXSBjcnlwdG86IGNhYW0gLSBhZGp1c3QgUk5HIHRpbWluZyB0
byBzdXBwb3J0IG1vcmUgZGV2aWNlcw0KPiANCj4gRnJvbTogVmljdG9yaWEgTWlsaG9hbiA8dmlj
a2kubWlsaG9hbkBmcmVlc2NhbGUuY29tPg0KPiANCj4gQWRqdXN0IFJORyB0aW1pbmcgcGFyYW1l
dGVycyB0byBzdXBwb3J0IG1vcmUgaS5NWDYgZGV2aWNlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFZpY3RvcmlhIE1pbGhvYW4gPHZpY2tpLm1pbGhvYW5AZnJlZXNjYWxlLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogRGFuIERvdWdsYXNzIDxkYW4uZG91Z2xhc3NAbnhwLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogVmlwdWwgS3VtYXIgPHZpcHVsX2t1bWFyQG1lbnRvci5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IEhvcmlhIEdlYW50xIMgPGhvcmlhLmdlYW50YUBueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvY3J5cHRvL2NhYW0vY3RybC5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3J5
cHRvL2NhYW0vY3RybC5jIGIvZHJpdmVycy9jcnlwdG8vY2FhbS9jdHJsLmMgaW5kZXgNCj4gNWZl
ZDNjZjM1NGMwLi42MmRkMDY5OTQyZTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY3J5cHRvL2Nh
YW0vY3RybC5jDQo+ICsrKyBiL2RyaXZlcnMvY3J5cHRvL2NhYW0vY3RybC5jDQo+IEBAIC0zODMs
OCArMzgzLDggQEAgc3RhdGljIHZvaWQga2lja190cm5nKHN0cnVjdCBkZXZpY2UgKmRldiwgaW50
IGVudF9kZWxheSkNCj4gIAl3cl9yZWczMigmcjR0c3QtPnJ0c2RjdGwsIHZhbCk7DQo+ICAJLyog
bWluLiBmcmVxLiBjb3VudCwgZXF1YWwgdG8gMS80IG9mIHRoZSBlbnRyb3B5IHNhbXBsZSBsZW5n
dGggKi8NCj4gIAl3cl9yZWczMigmcjR0c3QtPnJ0ZnJxbWluLCBlbnRfZGVsYXkgPj4gMik7DQo+
IC0JLyogZGlzYWJsZSBtYXhpbXVtIGZyZXF1ZW5jeSBjb3VudCAqLw0KPiAtCXdyX3JlZzMyKCZy
NHRzdC0+cnRmcnFtYXgsIFJURlJRTUFYX0RJU0FCTEUpOw0KPiArCS8qIG1heC4gZnJlcS4gY291
bnQsIGVxdWFsIHRvIDE2IHRpbWVzIHRoZSBlbnRyb3B5IHNhbXBsZSBsZW5ndGggKi8NCj4gKwl3
cl9yZWczMigmcjR0c3QtPnJ0ZnJxbWF4LCBlbnRfZGVsYXkgPDwgNCk7DQo+ICAJLyogcmVhZCB0
aGUgY29udHJvbCByZWdpc3RlciAqLw0KPiAgCXZhbCA9IHJkX3JlZzMyKCZyNHRzdC0+cnRtY3Rs
KTsNCj4gIHN0YXJ0X3JuZzoNCj4gLS0NCj4gMi4yNS4xDQoNCg==
