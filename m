Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462236B23A6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCIMHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjCIMHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:07:35 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D273DE7EFD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 04:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678363652; x=1709899652;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iR0uJUlQMMU/tyyh+5U7hyWqrlZWKr8Lmzl4Ac+NJgk=;
  b=MQsiRe2Ma3L0SmKAOJ0PxocDRAegitjYKW9JYaW3ebAU/oQ1pQnYExY8
   4wuhl/e8ZqpM+iHIG7fw+SwewN5JNwVHV1gERT8KOcKOPgEhhpxoTVWD3
   OSJRCdcSejTMSb1qtkftWqYV5Fb3NV6ZaY7Q8SkKBb2en2+pCsPbhxwRE
   aSyk+HHynj7SuSu6ZG2MdchvNkEghMjz6mDqxhrKyobQ7KJqH3mm6L9HI
   2SZBwYSLpSkyceYILMC48+4PVrRPijmp/K/VAfxHIlD0Z/UExLAfDLipC
   v4CSJONXN43WecC7b7bvqYqrOzXoUcbuXFYjvfHo9yTYfhDm/3xY4bk0j
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673938800"; 
   d="scan'208";a="141145134"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2023 05:07:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Mar 2023 05:07:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Mar 2023 05:07:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaWJ2CISTunv8LdVDhX9ZPgbKVRAcS3fN8iwbORiAOGnGz1vUv74gPojXOH0Swj7/ZOrzoZXUDU+L6ov4SlYCFzzPZgeLF3IqX1LE6IfOk0AwGJ5suXgWY2eFEaFEmY2j8k92hMkZq4FGjqM8sB+WG0Wkq29FpKrJeCpM8OIu/x3tjuKWBtldk7zdZ+koTCM8IaNa94A8HHNx9lbFg0XlyQNQOznhc21HNJwq6ERNCdlxC+3G9/Pl5/OGCSNDrhxxJiX6HzcgwCCVJKXwPKCagLbC8PD2wxya32n8Z/9n+adLJIaoAlmELRIwl9EafdxE9wR+tRjWEAt1OUT2zadHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iR0uJUlQMMU/tyyh+5U7hyWqrlZWKr8Lmzl4Ac+NJgk=;
 b=R68kBTRPMsvambuV+I5W6gZ3wFewYQaDGK8g9uzFxKcW4Gl8nOxPWFgaDbQWS7ckTuxsbFNXwXhwJyVsOR5jJQg/M9uktIr/fRsqPr3UjSI5VBKnoWZleHyxXoxFTen8M5+bliaA3Sk6RYvyQvM+qBhKnPEL+elJbYXYTU4qclHyEs6TNWjDUdxzzDXNwALX/+vT89koXwA5yS5ZuOYrHLLCOqEXzHRaGTUa9CecnNL2/o53D8HHTcPEdB+/n8GVUwtMIFdkKe0UWuyM54VORE6HU7jy5mue5mYvMsL5uXHTZqmsQ5aIGDi+IiZCq6twJ8tND4BUlva61sA0Jp/VDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iR0uJUlQMMU/tyyh+5U7hyWqrlZWKr8Lmzl4Ac+NJgk=;
 b=qrSPhwJbZb6N1BIm/fnWAeLHmDlKP336NUXDGTmM4eFf9Mq9i89ndjqk+DN4FICCuKvVPnzJ7DlR8eZGgFoSRDL+uXxGCWUQYOWa0vByDxAI06Jwgx3fL7VaE4S2OzbfVOgDxp4V6ScvXCCS5pa7izk7tqq7M8CKBNNK1WqpLPc=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 MN6PR11MB8147.namprd11.prod.outlook.com (2603:10b6:208:46f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Thu, 9 Mar
 2023 12:07:25 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::3b71:50e4:3319:f0af]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::3b71:50e4:3319:f0af%7]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 12:07:25 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <yang.lee@linux.alibaba.com>
CC:     <Christian.Gromm@microchip.com>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] staging: most: dim2: Use
 devm_platform_get_and_ioremap_resource()
Thread-Topic: [PATCH -next] staging: most: dim2: Use
 devm_platform_get_and_ioremap_resource()
Thread-Index: AQHZUYhr9MfKAr7v+0euHJqth2OwIq7yXEsA
Date:   Thu, 9 Mar 2023 12:07:25 +0000
Message-ID: <97c60193-4462-1a09-c3e6-235c57a844fd@microchip.com>
References: <20230308063653.92879-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230308063653.92879-1-yang.lee@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|MN6PR11MB8147:EE_
x-ms-office365-filtering-correlation-id: 17684451-4127-43d0-add4-08db2096d8d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3h+/NvdkwJkAvgF/3gf7FO9Ak7xH+Vksl3JE6i+RpAY/oEOxQP6LWGIJ0H5Z4alyZXnyO9jE/pseoCV6HXnldJwjJELAl0fesYhHrP+UqXEjZMhP0cXSbJj7o1hlA6zPLz9fSwaJAMzB1ZPOy95UFrQXX4F9eBEo5N78PrQzoKqdnyR/8fv2NOg5olprWFEhpMyHgobse2AuT/IiZjmqQpPTyf+HrB+y/EiXn/8dN/Tf0BJkVeGVyNncZpROsOdQXe9o1LtTk5sSd5KH0Rl5JY2S+lObw2+ruVMtLHB/1M+A06mc3v6xwzUjYtkMgbmTspMBrewQW1xIoaFtg/30AskgAb6MmRBJVXF1N8q+8x2qJYkIDXfI6eoetyP6yb9DTFs/+UiJfByZX0hSIU3H1Fhe8R9YNOco+aGIIS+C6KjTGLiKiwiFnurplmhXuWxNUWLJFEW2w+X+TeEQdlc6QijeBRqOYPB5AJV1qOzJg4UvAnjpwLqdV6ht0BFEnpJIebHanOtHAfcPAw9DQFUeuZCt4QR00YZp6TmVuhzwZzyHPtRzu1PWhr0/4GSzbieeQdhNy/bZbEJX+o8BZVrwEfAdZAjZJ+RBa2uL6Otr7mG/hYw+BPXF9ruefP2TChQPb1Au9AwO6zU0sng6tMar36l0hbZrgTL/r6eAdhzy/NoUx02x+kPJUrNeZPG38wv/h+MQL07VD3l/SkkwkhpAHu2EioNRp3PzIRGUJxKTtMmWl7G0xg33leob4SkayTtDbEmAtJU06kBdU8Fu23mVlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199018)(4326008)(91956017)(122000001)(66446008)(38100700002)(66946007)(66476007)(6916009)(66556008)(64756008)(8676002)(76116006)(54906003)(41300700001)(316002)(8936002)(31686004)(38070700005)(86362001)(478600001)(5660300002)(83380400001)(26005)(2906002)(6512007)(186003)(36756003)(6506007)(71200400001)(6486002)(31696002)(2616005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1hOT2hKQ1ZTSG1UNmJoUG1kWFZVdUdNa2s0QmRWdFM4ZW1SeSsxUmY0VWlI?=
 =?utf-8?B?U2VkTkRYZ0M1R25kL0toK0g4UEpkTXhWMFBzVFNkbE5vamVxMnpDME83YXA4?=
 =?utf-8?B?bC92dXF0c3c5R09iYmgzTTVITVBKWXNUK21HNnlwWUp2Z1YxeU92dzZhb2RF?=
 =?utf-8?B?S3VLaGVUeVBpME1vTFREOW11d2R6ZlZZNXdqRktjU2QxRk9wN01YNlZ2bWU5?=
 =?utf-8?B?YnNYWDZwU1JaaTNEeVpvQ0lQa2NlZFltMnNQeFpXamJYeS9kLzZyRTcwUmd0?=
 =?utf-8?B?WmRuT2FRMUUzQlJLdGY1dW5hNFltVTQ1NG5ncWN5dGlXNHhYSFQwQUZjaVpV?=
 =?utf-8?B?M2dIb2ZLc3lGbHRUWXR5QlRzdzVyRDhjOUNKVHhESk1TVUFvV2FIdGtEbXlY?=
 =?utf-8?B?OE5WdnVmMUQySmZWQ1g0SGx1NkRpaUlacUw0dE9hRlBVdGpTWnkra0NCcTBQ?=
 =?utf-8?B?cDl2cG9NMTJrT1RObzJwSDk1a2pXc2p0QmZFY3ZvRi9VV2dxdmxuQ2hyYTR3?=
 =?utf-8?B?S055NXhrTGgwY2xiaUE3WmZvdExqTCtvOStJWU5vMVZ5Q3FmNkhFUTJMS3lW?=
 =?utf-8?B?dGkzYm5TZ0MyZU40TDdNNnBWL3RrNHFxZDF1RzBvL0F2cXBMc3JHaERCVk1r?=
 =?utf-8?B?OVkxZlRqL2tBNURGYVlvYUU0UmtHNU51eFR3ZitFZWV0OWNLaXdsSDRFTlRq?=
 =?utf-8?B?SStvNVFtSGQ4eEs3d2d2S0VCc3R0QzRoWjY2M0NXc1NQbkx5aHc5aWZPdUdu?=
 =?utf-8?B?b3VVMVhSN3lZYmJZaDNzS1hZRlhIVW9iSDhYSHFVTFpDUjNsMWhOSnJweDFt?=
 =?utf-8?B?QzJpWGhqUWQ2U1FLaHV2ZFVHbFNnYWlJZ0xqRWtiVG10U09seUFraEQxZVJ0?=
 =?utf-8?B?K1ZESFRXaHNaeGNkbFpTMnhUb2NjSlZYQi9GaHU3TzUwRzI2L1ZIZkxQdUt0?=
 =?utf-8?B?REhZQWFhZmtYaVNDMGFieitQd0YvWnRmTnZJOUhranRjcEFRMXZ1QmpwZU43?=
 =?utf-8?B?dVdhYVg0S2FwMEVHSmRiZUMrSlZ2dkwzV0RyNEFoUzJkSzZlVitBWmRoc3VB?=
 =?utf-8?B?amZVQ2xzQ2VNeC9QK045aU1XS2g2RHlnOTdpYnRIUVk0RzA2RktHeVo0YTQz?=
 =?utf-8?B?MXdiWjZ1WEk3djdlQmJ6SUE1RkV2UzB1b0J4dlkyb1pCQVNSd3N6aVFIZFR2?=
 =?utf-8?B?R0xQUWpWVVlVcjV4SU4zSFM4Vi9PUFE3bm1ZemJHQUNvNlhxOFcrbWJKMGt1?=
 =?utf-8?B?cGdOc3B2bjQwcWZ5UnU3aWorY1ppcWkwS0VLQmd2dklTaHpzSEVqWU9JMHVL?=
 =?utf-8?B?MStiaGdLNWxzSG1TWGxyZk1qa3JDSVU4a3pFbkpoZnd2a2ZrOXk1djE0RmNz?=
 =?utf-8?B?OENDYzBldUY5bGpGTGV3ajVNVmg2dXR1TUg4cUFkOG1Kck5WSDJQM2VFWDZ2?=
 =?utf-8?B?MUhFNitxNUIvQkhFZjlxVEtuQUY3V2NxMEhmSWFLQStPY3V0Uy9yQ2pzZjgr?=
 =?utf-8?B?aERzMG54dno2VCtsRDRZcGtEUjFla050bUxRZTRhTlBBR0Zac0JKUGRUaHR6?=
 =?utf-8?B?S3hUSzVzNHJOVTEzVmgyelVXdWE0ZWNYTGRxVlNBVFNjcFc3VytiZGtOTVZ5?=
 =?utf-8?B?Skw0ZUE4dncvVDI5SVdvRkZlVTRxMlZVejJuZnQ1b002Sk51MENESk1pVStW?=
 =?utf-8?B?NXFxd2ovVEtWYnhLaUZlc0pHUUNGQ3dSWXVFNktpek5jY0E5aGgreDZaaTNj?=
 =?utf-8?B?Qnd4L21aRHJ5c0krOXpSUGtJa1NoNW13ZFVJNnMrMTl6ajlYQ2hCTTllRWFv?=
 =?utf-8?B?Z3ZzSTBHMis0U3FjV2wvYnFaNGR2cXhRVmlJKytMUnlsT1ZwYXJFZ0x0WGZK?=
 =?utf-8?B?eHdGRC9OVmMreWdld0I0SEpvTFhjemJ3SEtuYXl0QTErT0lXUlhYVE1wd2xT?=
 =?utf-8?B?WlI0RjRCWU5VeHI5a1JUQ25EeitmTFYvQXFPcmczb1pWQVVTQnA3KzVXbEp5?=
 =?utf-8?B?MUZnUGtNNnorSlRud0l1eG9SaFk5YkJ1WHJORXl2b3JuMThvTWxSZzlSZE1T?=
 =?utf-8?B?aGhBbktLNzQwRndjbUFTcFV3Ukd6dTRCWk4rODRYeGNvbm5EeWExRnVOQTNJ?=
 =?utf-8?B?cnhzMmNTVEJnQXJUTjFVZnJSRlFtK1R6SjZJdHd2cXkzc0dCS0Jxakl3RlVK?=
 =?utf-8?Q?hbj1qzpKEcqfnTj6AOXlNxQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <074C6E3BC2702C4DB354884DAF39331E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17684451-4127-43d0-add4-08db2096d8d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 12:07:25.7694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OzFyhzFPZy6JOYrGqaqy7qjB778Og+8ZDexM4jgS2m6o931pLQw7sLiiPWTkHn5D6nGakWgmvt480DWJaFKI6NMm5Yj1cOwHpdVpbGyDZWao79U9ij0me+fuU7/F7luB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8147
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDMvMjMgMTI6MDYgcG0sIFlhbmcgTGkgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQWNjb3JkaW5nIHRvIGNvbW1pdCA4OTBjYzM5YTg3OTkg
KCJkcml2ZXJzOiBwcm92aWRlDQo+IGRldm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291
cmNlKCkiKSwgY29udmVydA0KPiBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UoKSwgZGV2bV9pb3JlbWFw
X3Jlc291cmNlKCkgdG8gYSBzaW5nbGUNCj4gY2FsbCB0byBkZXZtX3BsYXRmb3JtX2dldF9hbmRf
aW9yZW1hcF9yZXNvdXJjZSgpLCBhcyB0aGlzIGlzIGV4YWN0bHkNCj4gd2hhdCB0aGlzIGZ1bmN0
aW9uIGRvZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIExpIDx5YW5nLmxlZUBsaW51eC5h
bGliYWJhLmNvbT4NCkFja2VkLWJ5OiBQYXJ0aGliYW4gVmVlcmFzb29yYW4gPHBhcnRoaWJhbi52
ZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL3N0YWdpbmcvbW9z
dC9kaW0yL2RpbTIuYyB8IDMgKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9tb3N0
L2RpbTIvZGltMi5jIGIvZHJpdmVycy9zdGFnaW5nL21vc3QvZGltMi9kaW0yLmMNCj4gaW5kZXgg
N2E1ZjgwZTYzN2EwLi5iOGJkMDFjYTFmMTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3RhZ2lu
Zy9tb3N0L2RpbTIvZGltMi5jDQo+ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9tb3N0L2RpbTIvZGlt
Mi5jDQo+IEBAIC03NzUsOCArNzc1LDcgQEAgc3RhdGljIGludCBkaW0yX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgICAgICAgICAgICAgICAgZ290byBlcnJfZnJlZV9k
ZXY7DQo+ICAgICAgICAgIH0NCj4gDQo+IC0gICAgICAgcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291
cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gLSAgICAgICBkZXYtPmlvX2Jhc2UgPSBk
ZXZtX2lvcmVtYXBfcmVzb3VyY2UoJnBkZXYtPmRldiwgcmVzKTsNCj4gKyAgICAgICBkZXYtPmlv
X2Jhc2UgPSBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwLCAm
cmVzKTsNCj4gICAgICAgICAgaWYgKElTX0VSUihkZXYtPmlvX2Jhc2UpKSB7DQo+ICAgICAgICAg
ICAgICAgICAgcmV0ID0gUFRSX0VSUihkZXYtPmlvX2Jhc2UpOw0KPiAgICAgICAgICAgICAgICAg
IGdvdG8gZXJyX2ZyZWVfZGV2Ow0KPiAtLQ0KPiAyLjIwLjEuNy5nMTUzMTQ0Yw0KPiANCg0K
