Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E605165BECD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbjACLSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjACLSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:18:20 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B154F015;
        Tue,  3 Jan 2023 03:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1672744699; x=1704280699;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ll9QX6XhScsVijKLnHq7CrvONnGayiS5VTdp8HyaDrM=;
  b=GCEYBL9lYijyjsXDw91zvYP5lKcFgmAFLQbfFApF3Z8qu+cQ7Pk1wWdm
   k4WRyFh1GgyEHZrrPFxe8UbxJRFC9mBUZ16nuznnfN+05ux445PXb9K/B
   3YniZXbTYC8G+dqYCIUubuvcBHlvnPN0ahGDaLi9KMDk+UlfZAXCiV3dW
   zQ1ygQ3Q2JOH2f1OlwCsR0R8CQDrHkdWyFu1is7qPZEe45QwWEL/eHe44
   dNVZk8yHD/GNYvPVD609VtIpF8Pr2kCFdPOqQp0f2dn1HqAeON1MjNgj5
   psxieXEqNIJsvBovvgHLUaz2MITod4Lc7E5PQvPRNa89nsyduuvGwXOCc
   g==;
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="195122814"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jan 2023 04:18:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 04:18:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 04:18:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KG6kV7r7g+0hgDWEZcfhM8DjZYIGePjntkpqkFd2MNS1RxWGDvpO+xw/ZcfU7BIuwosutYP3Lmd8IpvJ4vvNL2uEiIyUHOO6x4XpXemUa3cxJA6JSkl0qn3FFzxTzPxbY14Wul1drAMzBuiy0+y2kXUW0vGE2wbMrtSplFns6Rgh+Uzn8qVgvKUuIN+tZV+O/jksjxf/w37MC/tNHOJ8EQfrOU9yRfCZs58SNPGdmjdnztZBTN/EQdOCQ6c62jCXUnYGikbbNw1S6iaPWQgVVix3dLk5S5z1QOvc+ZSGjxa3y+VOTVXJE8XiABPbTYAiTcG0bs9GRcuVGsxChoWPTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ll9QX6XhScsVijKLnHq7CrvONnGayiS5VTdp8HyaDrM=;
 b=gLFMVS/kLDRu50cFhjL6rCUAmCmDuu1KulzY2jJRt1rZWj6c1kBLnSUoCTwMESEM4BJ9zFn+0eXZ9vQ3ZvUDrPpdMSax5o/jh7U9kgneayTyH6pjxYqqEdKZ2kT+EQCOh17pKYUP1LGS11nWRPJqqTl4keu7gh1R5qyFvFVme8sHh+Furf7FbCUrONxfIObVtpYjFSx2+Al4lK7Nr7VToqaKOJEg5GkOSGooYY5evRydmDYbXVL3GJPMPBHwM8uyU9kCE7jUQXK2b5cJ7N9oENVy4BEUl0uEVhnvmVwOi4tDSWlph6s3g+i2obIeep5f0nSobAB/X2d251HjGiH9HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ll9QX6XhScsVijKLnHq7CrvONnGayiS5VTdp8HyaDrM=;
 b=SHFpV4lqwBJhDdzFVUbEx82ANSZTxBo/BaTEYycx7lrm9/ZjO8Ry57sAqzv3lTJNkiamHFfXdsjX1DcpL9UELchhbzoxrbHt8SELf5ODQSW/xZL3ilnaPC1y4oK+I11jPf2uQS6AAw4NQRVW9ZEdjpvCl0c7ucOJUEU+WaCr/6s=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 11:18:14 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::108f:e428:de3e:8baf]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::108f:e428:de3e:8baf%3]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 11:18:14 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] memory: atmel-sdramc: remove the driver
Thread-Topic: [PATCH 2/3] memory: atmel-sdramc: remove the driver
Thread-Index: AQHZH2USU5Jbncsc40GAAxa0l2jO9g==
Date:   Tue, 3 Jan 2023 11:18:14 +0000
Message-ID: <23389f8e-daf4-67ca-1e3b-c5a6433f3986@microchip.com>
References: <20221208114515.35179-1-claudiu.beznea@microchip.com>
 <20221208114515.35179-3-claudiu.beznea@microchip.com>
 <2f9793fb-8840-fd3c-8af1-42c6c11ed475@microchip.com>
 <9054a7cd-2993-840f-1f4b-7837b43a1800@linaro.org>
In-Reply-To: <9054a7cd-2993-840f-1f4b-7837b43a1800@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|BN0PR11MB5709:EE_
x-ms-office365-filtering-correlation-id: 0e796513-f0c7-43f0-8de7-08daed7c34b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B3iT72j8Zxma42kv+AEuLn7f1W4NAOQX+/EEM2PzkNhxCJX3DoveK+pp5hMDJoun/3xteyQ8nTYL9yNmAHtpnEPW2oZWqSsV0VGDSSO1xxoQn6zXb00ZEi37+vJEtuNsRkwPYQU+4QwvwO3fthgZDPEgtGobWLwgxKvryJUhO6k4RHbvCbqLsx0c/Y9hCvMV3qPb3I7RgVn1hnlyYgZWL+rI0wqfhk/GMZPJASJW0iiJgzA6nwzqO7u+oEj8M05rZcVQ0sxzdwocM5BO8OCTvFLKzGvtUE8FhFOIq6D46TUPgKbqyTPV9tH1XXRYLXNer0y2RkWpah2XZT+1VByzXxCv5mRi6xkqkrvYenltj0yzyinxPEqeCm6uoONkX18z8VvUxaXvVUCZSgKRdo7DV86wMqSB2axUzvsKRUBHH8l/3TDCNFn7cDB8ZrSYlhh5l9gLd+lmnJYIdV86LDV0bCHia2Gc9/CDbHrhhENHjtgQlVdU1r/IPkM4LdLRjdkpqT/o3889h5WOy0r/GGr1vlxuPs61I/bqDvkJ2uKVbvsVRLVwGujl9Ih65g7LYFHnTif1McC4j72mFvA7yyFd47HC/IzHNWCDwN1/4feOGu/8FuX8dGHoehqozVAHYXsdiVcfxDa4rU97zdpB1C1YNnu6uIzDn6NW2rnqvr2gHZJgMorHpyZdEtvAn3GKrdB3U0Z24X+euQvYVhh/e8XY818HcVCds8by0iO0uRccqjzaf5pvunozAkojSxbJsFxqnoONXOvRxXg+aTR5QuwhZxRHCq2OEjTlvmW4eDrAkGs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199015)(83380400001)(6512007)(26005)(53546011)(6506007)(31696002)(38070700005)(86362001)(36756003)(38100700002)(122000001)(2616005)(186003)(478600001)(41300700001)(8676002)(4326008)(2906002)(5660300002)(8936002)(6486002)(66556008)(71200400001)(31686004)(66946007)(76116006)(66476007)(54906003)(316002)(91956017)(66446008)(64756008)(110136005)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmRHTmhGMmFSaTBIVWxNTGVXL1ZaT25qMWtwV3ZhMWc2Y1dPKzBjNE9oWmY0?=
 =?utf-8?B?SXlWTTBFOEZ2ZGxrN3FtU2txTzV5S3dIVGN1ZkdXS2lzTmdUbWJoMEVEYXpN?=
 =?utf-8?B?ZGNCYUVVMDU2WW0yQjJPSDI2VkFwRVp4Y0R0Qk9EdERoUWZNMTFtdTV6V0Q4?=
 =?utf-8?B?TmlENWQrN2o1V0ZlSmlmMXBINTNQUGFEYkNmYUh6ZzlPSlFTNXJXQ3lyRmlO?=
 =?utf-8?B?eDZTUE55NVZtZjF0ejZNZWExays1MG5iVGsvL21rTVlUV01oUEQwU0FNUzBa?=
 =?utf-8?B?WTM0a0JZS0FieTYxQmhEZUVVTitDSXF5T3poK2d2WFE5TWlHNVlrdHBUajR0?=
 =?utf-8?B?WXRvaWpvOFFLTkVIbldWbW9hdkQzd1BVTnFQN25lcHF1dUt3MTNiWWtFSSt0?=
 =?utf-8?B?ays4RFJ1TEY0RlJRMDFhMW5OM0Y5WjFYN1RVaE02YytHYkcyWFNUT1hoMHFC?=
 =?utf-8?B?ZXpiWEJodnpDRzZ0WXRVRHkwMi9vYmN3b3dsbjdOaDU4eVVmQ0hrbjhDeFVJ?=
 =?utf-8?B?dGhlN0w3WG5ZSkJhYUQ3SmtRRlRsOTNuWlNzdEVFTGVPK0NLVm9md05oY3gy?=
 =?utf-8?B?OVRnU3ZtbzhYY3NJelZDYWpWSUVCZ2tLOUNpU3RUSDRjbkx6V2QrcXBhWS94?=
 =?utf-8?B?cDQwUHY1U1hrT1lOOFZYNytBSUZWZXFDV2RCYUo0S2N2eXRFSmgxTFFRZjR3?=
 =?utf-8?B?eFczMFBQbFhqK3ZLUDdIUFFueWxZdkt2SG1jVG40L2lDNU4xMGU0YmRPNzlS?=
 =?utf-8?B?RTdZL0grWCs3ckpVME1HUGNOaXRJTVJxRFdZTzhGWFBwcnNha0RZVThqRnI0?=
 =?utf-8?B?Nkp3OVh6Und2dGtxTkpqei92N0tCdWhWTXRjQ0Jvb0RrVnhpNGFNa0lRcUZn?=
 =?utf-8?B?V2V1eVpxZHZsK3ltdXY3N011YUNjMTZta1hWQnZaclMwc0dZTko1emVFeEZs?=
 =?utf-8?B?cDlJWWJQT1FvSktmSWJCL1Zqb0tjeVVreURsQXhSQnZtc0ZSMFJ0TGNZUGZJ?=
 =?utf-8?B?WDNDZjlNL3Q1Q3BteE0zRThaRitpQTFTc0FSRktkSjhhWXIxK2JlUWJkQnlS?=
 =?utf-8?B?eTBCY0pUSTZ2VWhZTVBzb05JRFgwUk1LdEFiNndMejM0djRCUEtVWGdzYzIr?=
 =?utf-8?B?T1I0SEEzR1pBcVlsTWdvYVQ5Q0JselBmQXJGSHlwbWZPZG9CVjZMQkZRYTY3?=
 =?utf-8?B?cGhWTzZVMHFTS2Q4WFp5Q3lneHVMMUR5TlBVYTc1N3dFd0VNaWpPK3p3QnZC?=
 =?utf-8?B?SHplNWxnZGF0SkY5ckI0aDA1TUZVRUgzZDhpMHMwcmNkeW5vQjN0ZlpaNGJI?=
 =?utf-8?B?UmxCTWxBYy9VZ3BCLzdkSEU3NlFwRTlUNE52Qi9uU2VQVTY4TTB0TG5jcENs?=
 =?utf-8?B?OFNEcDVsaCt1bUFabDZtQ2k1TkxLYlowdWZqYUFvQ245YmJ5eVlvRC9wdUdi?=
 =?utf-8?B?L1FqNVhtVmVZREVmUzdjaXN6QmlhM0RLeW84d3JvVGxPKzhoZk9iWUVHMmc0?=
 =?utf-8?B?a0U5VGlCOEoybXBBRHdzdXZ1Ni9ZV2k0Nk4rd05FTWRwZzZvYVBlWEUzQ3Fj?=
 =?utf-8?B?OUlqQklzOUo1SE1HM2d2V3BzaXNYTjd6MnRaRHI2QUl6QkY3WkQ4RjhGT0dB?=
 =?utf-8?B?WVpvRUhKREdEQWRsbTJhRmJ2bzdvdUIyQWkyQXNQM1REdGVHRVpiOWxjcXdN?=
 =?utf-8?B?Rm1nTG5kbmorTG9KU0lxKzlmMFp3RHozcEFiQ040UHhQQ0NOWTRpZTFIQ2Vp?=
 =?utf-8?B?K1EzNnltM3JlNzZ6bWFyTCtRemNLSk5iM2JWMm0vb2NZTVZEUi9PR3FLaW1N?=
 =?utf-8?B?cVgzRFg0UEE2bUtVSUpzc3V6dHZkL0U2NVlralJTVFdwSE1rYnJTL0NtVEhs?=
 =?utf-8?B?dTFoS0FrODdYbGdyanV3T2pUeDFHY0FWMW9ONzlLb240N2N6bjkwancxRmlH?=
 =?utf-8?B?RmptRjZpQVRFSFhRb1l2L2xNUWtEQ1FDdjVvRG9WWnVHK3dId2RNL0FNWDdJ?=
 =?utf-8?B?S1RwWmRSY2dPOW9JTk5TcmkySldZdFVDc0NabFJaaTBBdU95UFp4TWx0SDFt?=
 =?utf-8?B?VjI5QWxpU0FyTmxobHdsaEUrTFA5dzJrSGdlZjlHSlpaS21kSjg3NEN3WWVB?=
 =?utf-8?B?R2FFbFczNi9KcU5qZ3FwUHQ5OWJkcDFkajNoWlo4MU9WNFBBTUFRdFNGNGJh?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E783FAFE337A9B4E9FF5D4B4492F3116@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e796513-f0c7-43f0-8de7-08daed7c34b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 11:18:14.1787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /u1bymvUvblh+aJC5o8Wf9OTPNXSNJj2CqTvQNlvW7nWPiAZDcM/r0pBQr1SVUtzleLSt15iOo5ujSGmRaxgR6YFJSr/2R1pBrGv6lgriVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5709
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDEuMjAyMyAxMjowNiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAwMy8wMS8yMDIzIDExOjAwLCBD
bGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gSGksIEtyenlzenRvZiwNCj4+
DQo+PiBPbiAwOC4xMi4yMDIyIDEzOjQ1LCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+PiBEcml2
ZXIgZG9lcyBvbmx5IGNsb2NrIHJlcXVlc3QgKyBlbmFibGUgZm9yIEREUiBjbG9ja3MuIEREUiBj
bG9ja3MgYXJlDQo+Pj4gZW5hYmxlZCBieSBib290bG9hZGVyIGFuZCBuZWVkIHRvIHN0YXkgdGhh
dCB3YXkgaW4gTGludXguIFRvIGF2b2lkIGhhdmluZw0KPj4+IHRoZXNlIGNsb2NrcyBkaXNhYmxl
ZCBieSBjbG9jayBzdWJzeXN0ZW0gaW4gY2FzZSB0aGVyZSBhcmUgbm8gTGludXgNCj4+PiBjb25z
dW1lcnMgZm9yIHRoZW0gdGhlIGNsb2NrcyB3ZXJlIG1hcmtlZCBhcyBjcml0aWNhbCBpbiBjbG9j
ayBkcml2ZXJzLg0KPj4+IFdpdGggdGhpcywgdGhlcmUgaXMgbm8gbmVlZCB0byBoYXZlIGEgc2Vw
YXJhdGUgZHJpdmVyIHRoYXQgb25seSBkb2VzDQo+Pj4gY2xvY2sgcmVxdWVzdCArIGVuYWJsZS4N
Cj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBt
aWNyb2NoaXAuY29tPg0KPj4NCj4+IEFzIHRoaXMgcGF0Y2ggZGVwZW5kcyBvbiBwYXRjaCAxLzMg
ZnJvbSB0aGlzIHNlcmllcywgY2FuIEkgaGF2ZSB5b3VyIGFjaw0KPj4gZm9yIGl0IHRvIHRha2Ug
aXQgdGhvdWdoIGNsb2NrIHRyZWU/DQo+IA0KPiBVaCwgd2h5IGRvZXMgaXQgZGVwZW5kPyBJIHVu
ZGVyc3Rvb2QgdGhlIGNoYW5nc2V0IGlzIGJpc2VjdGFibGUgYW5kDQo+IHJlbW92YWwgb2YgdW5u
ZWVkZWQgZHJpdmVyIHdpbGwgaGFwcGVuIGxhdGVyLiBPdGhlcndpc2UgaXQgaXMgbm90DQo+IGJp
c2VjdGFibGUuLi4NCg0KQVQ5MSBkZXZpY2VzIHdpbGwgZmFpbCB0byBib290IGlmIHRoaXMgcGF0
Y2ggaXMgYXBwbGllZCBhbmQgMS8zIGlzIG5vdA0KdGhlcmUuIFRoaXMgaXMgYmVjYXVzZSBjbG9j
ayBmcmFtZXdvcmsgd2lsbCBkaXNhYmxlIEREUiBjbG9ja3MgYmVjYXVzZQ0KdGhlcmUgd2lsbCBi
ZSBubyBjb25zdW1lciBmb3IgdGhlbS4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0
b2YNCj4gDQoNCg==
