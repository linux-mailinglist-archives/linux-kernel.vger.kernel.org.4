Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449CC72BA39
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjFLIVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjFLIVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:21:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541A11709;
        Mon, 12 Jun 2023 01:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686558071; x=1718094071;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=iLMOqfV250QYYRz+W4Oxik6ft2LWXR1OIzCm/UW1vgo=;
  b=hbqV2jMlOE1IKuWZVczEHeAAgIK6KSN/sz7E061ogDF8/v7J/piGhVAV
   zxRhwO+BUjV7SpiurYx+v3urKYPZ7jKoUEid0Atwo2JBNiEXcOveGZLqv
   geGAXsjA5OONBhvePYPWVtMcVpSnmYVuJH9EEaGLmcwV7m6ns+E6jZSeD
   9HhL7KEwBBXAJMkwcGSWreeDxeCI0XWo5/Fe/piR8qNDNFvWFlnt20fmS
   4lApnEsUGqs/S+RkM3i7EoTL2m5ycT1mdMOyzwjGMaXI5nqOrAIIMmje5
   guQ7MA6t4yMQUMhGRaCLSlCNJsyD4RGAoekTTSTSWFc0pl7jsly29phSv
   g==;
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="229599488"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jun 2023 01:21:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 12 Jun 2023 01:21:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 12 Jun 2023 01:21:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqmZPdXqVxRYlfx/sqQnvU4NPloLAdZp/8KEGythW2qiqT5f8kvPj/Fb9kQDar3GL3kg3DZTYI+fZW1SkdYm2M5rL2xGfIx+/2ZRzpph3hr2JFZWc2LBKTFHqvyuIh1CM/WfYLlDlnYPOo8Em48Zq3zue71o283WFw+fWjHxTwtNRK3XMb6IfwIQYFllFUjKSykJQlcjLIcQ/oeYukE/R+6AahxPlLPVmShGaJHzxsm4PrCIUwz5OI7FGfzDkev1pXVnqwW/K7DUNLhZoud/M5Le+BoKuFVfflTASWNow3LDUsuMLsC3OApnIfIlf70zW0ECYJ+xFnajBm7wMNjCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLMOqfV250QYYRz+W4Oxik6ft2LWXR1OIzCm/UW1vgo=;
 b=AyJXR0qo+dRPUHXqJ6NkRSZvojZbnqfNZl7MJuvu4bFjqn5xJvKCY177NWl2w613Q4QAnU+VxdFwIk34RXsMWhC2RlgbahzCk7xZZw8vWNQvFfH0vxDpex2KyY1EbQy5CYklgvaGWnHSbgSXcNUD12fdWjqf6IFk4x0FVQIxbJs628I83Vv5g4ma/1gCj7s5MKxmKnSGQ1o8GVYHUa/AQNpT/BuoYvEybv4wJViMhJR5aHeJSl91PtaVJB0pICiTGZ1zN7oOz8La9ulSWL4eONLwVWOuxOGyzj7zQJWQJnOFhKZWn0SwLRXyQl/5dGvtNfRlpTnpjj2evVkgNOxhXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLMOqfV250QYYRz+W4Oxik6ft2LWXR1OIzCm/UW1vgo=;
 b=ZgwRLzD2Zv8ykdkv/Oc0d1NHgjXQ17TZE1W48MS9ZWOvQ/lKf6+iVtMZC7Cke9gQJkiYdRbGbP24a6YLF4K5mbLCVy5EKm6yLjnLtnE205NxXvsT1K2VicUxUzUGusxQfZMfpW3KqBgzXyQVxCPMQU5gP8mKQ65p1W/L8T/GTFE=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by PH7PR11MB6953.namprd11.prod.outlook.com (2603:10b6:510:204::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 08:21:08 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6433.024; Mon, 12 Jun 2023
 08:21:08 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <anson.huang@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: drop unneeded quotes
Thread-Topic: [PATCH] dt-bindings: pwm: drop unneeded quotes
Thread-Index: AQHZnQbWtebeWOoQKki5P1BO1mEbKA==
Date:   Mon, 12 Jun 2023 08:21:07 +0000
Message-ID: <2d6fb44b-2595-7529-89cb-1a77f1d18353@microchip.com>
References: <20230609140709.64655-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230609140709.64655-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|PH7PR11MB6953:EE_
x-ms-office365-filtering-correlation-id: 7194e48d-b458-4ae7-f55a-08db6b1df908
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WrJKJRqK7R9UlP5eqmW+CMXdYoSs6DqhpR0N1pBRv7seygQM9ZCeW2FWY0/PcDSadMhjhy1J036pzm2djTcQ0jPKdweta0Cc7wNRzPRie8hSTPKcP0UAbCTp9iRTBA9Jw362sVafb/7Ni2exIz3lcmTXtxXc2ffiFCmZHEd57Qf76oSbm0ftyEMZyg1T/wbtX3Q0mFxiGltufDW8T8A8xf2y2LG0WXoeP6y/nEY7f1QpHTYjoHnjCGtlO9ckTNC595GWNMH2EEWGHIk7mEJrAHJp2WDEYP2bs/aS7mW6NBLg8prvaTVjUabNqTRffO4W9nlpwNteWZ2DVb7Dzv9BjcSSWVZDCjorNjH9GZ5MBQjv5TZlwqNzHdQ+jvNnNl4/pokG5m13/aZHFTjbV9hYnltm3BcABJtmT7thrhtTPvk3JyVNlpVyC0gVCfa6PtC0jRcldhpG41cXzpW90bSz8lDQg/2KomL6iFGlFHNbo6/2sNpNYhbkwbT7DGpqszGayHb29H2fAjKPja9rIa7WdkOuH+DbezwIZnDYRnBTMhwcxu1/MNQx3t/KVZXUNO6melZfcCXRk3BxbOnIj0hZniswyYpGBsaFMP1XIgNoJbQYRg+HLkBpd8/oSM4xpL4YhI4lSZT+OzK9xQ59ZnkddTCYH3C7BN9ZNPB3TzYMbxU4crxIJIG1Uo//76L7RfLv6cHsON4BAPGrSL47Aoqr5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199021)(31686004)(66476007)(66946007)(66556008)(316002)(64756008)(76116006)(71200400001)(91956017)(66446008)(110136005)(478600001)(38070700005)(36756003)(86362001)(31696002)(6506007)(26005)(53546011)(6512007)(83380400001)(186003)(41300700001)(2906002)(5660300002)(8676002)(7416002)(8936002)(6486002)(921005)(122000001)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3N0YW5UWjF6VkxOR3hLTENaNUxmNHZKa25ZOXo0YVBYMGNmL0NHQ3Vjcm5D?=
 =?utf-8?B?RTRhbkdLVUw3NGxoTG00RE10NzVqUzY5RUJWVlpHOGl1R3RNUVBqams0N3ZP?=
 =?utf-8?B?dHRNall0UDQxbTlhdzZOdE95V0VaajBmYTdWOFpTRndDMzR2Y3lKODk0Yy9q?=
 =?utf-8?B?dHF5SE1pYjd6bS9aZnpjN3kxbEVRRXp2UXdxaUUzQm9pdzA5ZW53UVEvR2g2?=
 =?utf-8?B?T2pSSnI4N3czRTdNTEZDeVovNU9KTU4reWhlRnNTOTlOdDZVbGRGOU9GdTZx?=
 =?utf-8?B?SWpENWhraEZsMytENC9KQzlJUFhnckhqYmZFK2Q1KzVjMUVLWWlJYS9YV005?=
 =?utf-8?B?WkR1SklEZlBCUWtMcWpnY1FWWEZVcnoyQlQyUUpDV3BLdG1zeVhaQVo1bGt4?=
 =?utf-8?B?dTB5M1RkdE83YjVCY3lhYjl6eHBpd3RITnhvcEVGOUFRUy9GT2xJRlo4Qms4?=
 =?utf-8?B?UVU5QnlyMVdkSWZzNWxOL3lsUmcrM280NlMrWk1tK2dzVVJWZzVoUHlmY0ZL?=
 =?utf-8?B?VE5vakUrV01tczRwNlNrNDdDRzV3b0xYaFZJNHV2czY0SWViaEZaUFNrVVA5?=
 =?utf-8?B?c2lCK3RabEtwU00wKzNxdW10ckV5UC9YTFduS04vV2dBYVRQNjBWV3cveEli?=
 =?utf-8?B?bStKSDBBTmhxbzVlcGd4YmpXcVUwVlJkbEMwNVJaczI2T2Q3KzBDUTZwNlVo?=
 =?utf-8?B?UVRNSjlMcHhVbVhCT2FseG1DejJYYmV5ZmE5dlBRSU1xc1o2RGdURGZzRXFo?=
 =?utf-8?B?TFJhR1I5YXZhNmFPQnprcFlTdWt4cWFwTlNrZVplZVk3UXZKaEVzMDljL00r?=
 =?utf-8?B?M1ZLMjdTWTFPbWdGMnhNUkI0SmphMWVrcWttQ3g0cy9xS1MzQ1lkb3lNZTBs?=
 =?utf-8?B?YjZveWQ4cnBGMnE3ZTB5SXk0anpEWGI4cEV2aUxmNXJjdGRaUDl4SjdnVFQx?=
 =?utf-8?B?Rk0zMjN1N2dRd1VLTlhKV2ZGMjRNRGZxUElMY2w2YkF4RVFUYStySE5jRXNi?=
 =?utf-8?B?NTc5c2R5VjRQOUtJT0tXSXRpaGdOVjE2N1k1TWpYbzRhb0c4akM0ZmttL1Ft?=
 =?utf-8?B?ckIwcXYyVXNhTzkvT2w4L2N1UkRhajdtbXMwVHNwcWY4OCtveHBvYjVvam1V?=
 =?utf-8?B?aEpiWmNXSlRHMHQvZUdHcFNhNlg4TFU5aUVJRUliMFg1QkhxNm1FT0Zwc1o4?=
 =?utf-8?B?QUdYNjNUZUhyY2ExY0FKODRacXl4WEJ6NFcycklacS9xL25qK3lPcjVoOGtr?=
 =?utf-8?B?aWZOWmE5QUt5R3N1QW80VmZxY0VwTGtHVG4razFRUGFPbG9PbHhvN1h3aCt0?=
 =?utf-8?B?dE9FWmZpOVlwTkNIaTZFMjIrZ0x3cFJNNUNBVDhtdTU5M3pVMjhZNW43UGJp?=
 =?utf-8?B?MFQ5cFFnc0JmMUwyZnFqSGNvMzFRK2pWd3pwcGtvZUVEYmNEZkxOV2tCU3Qx?=
 =?utf-8?B?ZWE1QXFoMXpFWGNpeGp6R0l2cVZFdEVBaGNNa2lFTDVENzZ5MkF2Q2loUnVa?=
 =?utf-8?B?RTJFRWdsSnZoK1o3TTZhSUFHSlBYNjlQWFNlTFFXdlFMdnA2QjU3eHpOUGda?=
 =?utf-8?B?STcyYUR2dVJpeE1oazQwWU1hb0tOYWJNcjh2NUZIT1FwRUx1TmNtdjczK3lx?=
 =?utf-8?B?SE5lVUkxZ0J4bmkvK09mbFIzVWdXUEtuMDhxUWlNbUp0dDZoeUM3Y01sRFBv?=
 =?utf-8?B?dDZVRnN4ZVMyNDlSNjhxMHErNk5YSk9aeU9TNTlGRDlaZlpScU8xem9KQXRM?=
 =?utf-8?B?dElvbVIrZWNpeVI5SUxyR1c0Qkl5T2ZINkFKVFpucXltajZrZG41OEVYTHNs?=
 =?utf-8?B?MnZ6VlI5ekpxRzZpdHAxTXRLMnJiaWQ3SXFTQk1VQ1R3TXZ4cGJNWWhsaldC?=
 =?utf-8?B?WVlFbVIxS3RPTnlkemhra2g1ZW9SdVpOTGxFYXdzQ20yTklJRTNmRXZVS2FW?=
 =?utf-8?B?WXlEL3U5ejVSU05jWDJNeHVIU0psNkNlUEx3aFhEYVUzZ3FQWXBDR0tpaXYw?=
 =?utf-8?B?RTFPNktTdmxxYUlsM1BSNEp4VnJWU1B0aEF3d0VteGZobzhYbGh0MjJnS0RH?=
 =?utf-8?B?VWNJODQ3M01ScXo5eFk4UWhpTDM0OXFWbU4wdUYyUVF0eUtwRDlmcW1OVjRX?=
 =?utf-8?Q?c8rv3W6jhezmR34Gqbgl8CjqC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70E58B6BB37AF84683AF35266ACAD4AA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7194e48d-b458-4ae7-f55a-08db6b1df908
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 08:21:07.9179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ywGUX//sNVBjL0rk4Y8jqa1Yj20p07RJ6iiBF8dkDN/DYEpBwntQsS2RVyYEOVYu7zQdBjOO7yzZcoshzUcKQ4yxSjuDVYsO4JHz3blT5ig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6953
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkuMDYuMjAyMyAxNzowNywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBDbGVhbnVwIGJpbmRpbmdzIGRyb3Bw
aW5nIHVubmVlZGVkIHF1b3Rlcy4gT25jZSBhbGwgdGhlc2UgYXJlIGZpeGVkLA0KPiBjaGVja2lu
ZyBmb3IgdGhpcyBjYW4gYmUgZW5hYmxlZCBpbiB5YW1sbGludC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4N
ClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNv
bT4NCg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vYXRt
ZWwsYXQ5MXNhbS1wd20ueWFtbCB8IDIgKy0NCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9wd20vbXhzLXB3bS55YW1sICAgICAgICAgICB8IDIgKy0NCj4gIDIgZmlsZXMgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vYXRtZWwsYXQ5MXNhbS1wd20u
eWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vYXRtZWwsYXQ5MXNh
bS1wd20ueWFtbA0KPiBpbmRleCBhYjQ1ZGY4MDM0NWQuLmQ4NDI2OGI1OTc4NCAxMDA2NDQNCj4g
LS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9hdG1lbCxhdDkxc2Ft
LXB3bS55YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20v
YXRtZWwsYXQ5MXNhbS1wd20ueWFtbA0KPiBAQCAtMTEsNyArMTEsNyBAQCBtYWludGFpbmVyczoN
Cj4gICAgLSBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4g
DQo+ICBhbGxPZjoNCj4gLSAgLSAkcmVmOiAicHdtLnlhbWwjIg0KPiArICAtICRyZWY6IHB3bS55
YW1sIw0KPiANCj4gIHByb3BlcnRpZXM6DQo+ICAgIGNvbXBhdGlibGU6DQo+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL214cy1wd20ueWFtbCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vbXhzLXB3bS55YW1sDQo+IGluZGV4
IGEzNGNiYzEzZjY5MS4uNmZmYmVkMjA0YzI1IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcHdtL214cy1wd20ueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL214cy1wd20ueWFtbA0KPiBAQCAtMjUsNyArMjUs
NyBAQCBwcm9wZXJ0aWVzOg0KPiAgICAgIGNvbnN0OiAzDQo+IA0KPiAgICBmc2wscHdtLW51bWJl
cjoNCj4gLSAgICAkcmVmOiAnL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMy
Jw0KPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0K
PiAgICAgIGRlc2NyaXB0aW9uOiB1MzIgdmFsdWUgcmVwcmVzZW50aW5nIHRoZSBudW1iZXIgb2Yg
UFdNIGRldmljZXMNCj4gDQo+ICByZXF1aXJlZDoNCj4gLS0NCj4gMi4zNC4xDQo+IA0KDQo=
