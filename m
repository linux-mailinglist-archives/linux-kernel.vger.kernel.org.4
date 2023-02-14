Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248D0696209
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjBNLKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjBNLJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:09:34 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482C928D0E;
        Tue, 14 Feb 2023 03:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676372909; x=1707908909;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YBlhG/PhwEJbfoYwuGVcXbG1V5GOOI+7PS6qz2JGksM=;
  b=Jua8YffzC3N5ao0KG16O0jSZ7rRT94IarqOHYT9Oi6ug8DnwHd4Wk9GE
   OskRDfhObvcIEdoK5m/BZ0OpBib7nZv/MnuUu1KW3X7PKjRQDxSCu1g77
   u9RF9cy8k9Wm9CsGnzfiV7lIHkXWvIC+YZiPDhpLT5SmhbXY4xwJUQdUQ
   QlHftJbaLFqrSqPoQS95DDgBtM1u9pHLETcgbsrS6xF+ikUwS0PyEcSyq
   bucAfR0JK8IbMc7CNV2KAS88jpkBKtqHvth/WJWw/i8X9TWAD3RgT74fC
   Xc+k4uAVvrXVEk3BxzgRi4HJwtYUz9IVwcq7UEImQDAIRw4ncYmZk+WSl
   w==;
X-IronPort-AV: E=Sophos;i="5.97,296,1669100400"; 
   d="scan'208";a="211900697"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2023 04:07:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 04:07:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 14 Feb 2023 04:07:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWbnTtoncrgDROiBD4h9QhYQf6ApT/2ZmW2udWWL9rV5ej26Q580vI+8qnQLvGi2C3GN5gCLzzSmP9KfYVA8G+zK7QD8RnUt2Ih8vaCDyyPMRJaTuAf7hwZQ10JUVC7ZaxieKi5891hsGooH9/+tlY9B56IdjKyq2+L9NeyRUJ3shBEAMhFdOwF1mXz5aPM7vdWPZj48Jz/wZQcc/rByXepZsGfRs/o8Dvke3/QlHpw1KjuIveiUDLbBSGXAJfGEf44SPu78f1vQ50nj9M1/6P+BwjNJHWpD6EjwefyxVV8MG0mBa8rO+LgqwTppT5KF5S9XwdlDv9VQdfRY6FMvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBlhG/PhwEJbfoYwuGVcXbG1V5GOOI+7PS6qz2JGksM=;
 b=Q19p6zHxt6lfmTNIc9KPJphZM1p64PX5v6NMfzH1yF6UvZZlLNg5dUo0zRLs3kfLd0Dmp/JgZDNjKTYM9VcwhkQ+U1QXOw3thX5eKJ8YwHseDgg3FBKd5eNLmKRF6bTtQxuCJJWdg8viogyv9ylM0X2jqa67sZsFnVUghaN7irb6VBPjMbj8emaz8oSgTYc4agfXxYptHmWwIf/70shUdMY4dbwLdo0Z4TonfuQL/Xy8RTasaoamCTbjS+TPjnrShhMOLhpvRPKEcpqeyzks8XTyXVquXbJIB1IibZk+qzs0t/F5X5G1id9g4/fp1ZQ7B5DXPoRzjQKE9BEP6llVJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBlhG/PhwEJbfoYwuGVcXbG1V5GOOI+7PS6qz2JGksM=;
 b=QssHlhcFO5srAjOkRNoMkrjekKy3ncE7M6wiw78oHkoUBVdSzl4iCQP/CHP9AvPcyh0K/Q0tZxuGsTsxx7f20pQE7/dLO+EYiJqqhCgOh5VfEe2GP/06TtMH/6e8PQR8vSBuNmIYJaoLmMPKQvE2q8m3zN6ly6YkocceO4AQ73c=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SN7PR11MB7637.namprd11.prod.outlook.com (2603:10b6:806:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 11:07:30 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6086.026; Tue, 14 Feb 2023
 11:07:29 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <andriy.shevchenko@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Ludovic.Desroches@microchip.com>, <linus.walleij@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 4/5] pinctrl: at91: Use dev_err_probe() instead of
 custom messaging
Thread-Topic: [PATCH v2 4/5] pinctrl: at91: Use dev_err_probe() instead of
 custom messaging
Thread-Index: AQHZQGSHYs43TQ0kEU60ud27l9lK4g==
Date:   Tue, 14 Feb 2023 11:07:29 +0000
Message-ID: <33e2515b-1d37-aa90-835f-fffbb4296779@microchip.com>
References: <20230213154532.32992-1-andriy.shevchenko@linux.intel.com>
 <20230213154532.32992-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230213154532.32992-5-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SN7PR11MB7637:EE_
x-ms-office365-filtering-correlation-id: 8e936768-389a-4b4a-8452-08db0e7ba9f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /g6pr37GjLqSyT3aQi0cskQIKwxBIN42On9MkpqiwotPNIEctC3kZVrZU+uXrOQwRMyMeH0xedh9p2UObGf95RQaYmddGCxNTOARctUGcXL0LgMBIMIX6sARS6xuAuiwlcxbNL6UUKNlBmnZTmVQ/43BIC9Sb1f+h8kF0PpnoSms2mGQkil0ULhjFd0IBakswtq5EkNq7ZAeODXlM0DB8SBZ6kJGBFzCrZKKABiF7FoWi9t2r4KKF9d0HkTPFm1Gg7HI0/G6D3jn0dOFkStKJFFSaUBlAXkfqduFzv7NwixGecbs/2ll2cKlz6K1xvUeVTJJLkGdtRfKsFTe28auGgzTZ84zJdy3pzr7GlCkfd8H58xUPu9GDXWpQyuN5OJM8edjq1M+uCtPa+X4b61zVqwRHQTGKE/IXgu1+hbkX5CQ17nxp0eLVDgvxbHUvWjW1U1Jev49Xu6sDwen678U35P7GeE/2SpnOSABBckQKLcq8ljxCDtoF5uF8yFvJ11PT1YxMKsEQOI3oUPBxx9P8c6VThViArirIt6AIrIxiWBaSAVu4RhkcOkBvSdFbfv8pjUUguv+bZhROWjmB6zy+vbaq4JkpdTHqe6ciT1QSLfHdkGy6SZjq7dQxhXZT7UadvBZO4cv9YdgHnJh5AI3uI+nbh0EvCgZ65vDCqLnnjO/2rBQHZ2eG0Gbs2oPOAhIDlNsaYTfSMceWODAewgR/rSrmUM7NeZaQD85Rhpg/qEOsTqzDJ93lwojVCwqtnZNUtakdjBHJiKuzl+DRgrgLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(376002)(396003)(39850400004)(451199018)(2616005)(122000001)(478600001)(6486002)(36756003)(41300700001)(31686004)(6506007)(53546011)(5660300002)(6512007)(26005)(186003)(8936002)(2906002)(66556008)(38100700002)(71200400001)(31696002)(54906003)(316002)(66476007)(110136005)(86362001)(38070700005)(4326008)(83380400001)(8676002)(66946007)(64756008)(66446008)(76116006)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUN6ZUgvMDVGVVNqQWhmM0RKVW0zZjhTYWIzdi8zSkl3eXUyOWdDZjN1WVhz?=
 =?utf-8?B?Z1MvUWNwM0RnNWJTUFFtL21DNEEyQTlPN2U2SE5kTzFDMGtlbHB3elNseVJO?=
 =?utf-8?B?NXhjbXVSbEZFS3dCOHN4TTdMZUlnYjNLRUVuamhvcWthbjRBelcxbVhEU2JM?=
 =?utf-8?B?a1dob0w3WUZCcWFvbzBzYnZYUVd6Zm1OaXV1Rmw3NkZSdm5FK3FVTVZXQTl0?=
 =?utf-8?B?MzFPUk5PakNyMlByOXRRTzV5dUFoRlo3clB2dHM1NzlWV25Vc0VPb2IvOG8y?=
 =?utf-8?B?S2lGbURmR3JmSWY5VjIyTEx1Y1oydlhmSHN0UE5LNDBBaFl1VVRPWjQrcDMw?=
 =?utf-8?B?L2N2RnNrcUVONG8xY3lCK1N2WjQxM3FRbHBUUUJnT1dCaTNNVjFBc0lOVkZB?=
 =?utf-8?B?TmZVdHlFa1l0LzhKbi9Jc3FjdGU3UG93S0htT3p5SDhtTmpVQW9JcnpkeHpO?=
 =?utf-8?B?WWpiV0hQSWI1UVd6S0dBOTRmZHJJNFhPdkpBWm1IK1ljazhqaEpjTisvL2R5?=
 =?utf-8?B?bDdNZS9XbGNBeEN2L0VrRzR6cE5MS3NFd1haaStzbE1tRXBKTi9UenFJUzVJ?=
 =?utf-8?B?OURUSURsckQ2R2Z4L3lFZVB6bG9SUzVTWE5vSisrbVNhMlE1dmJYV0h3YjZs?=
 =?utf-8?B?S3FITThTVmZSczg1OXFoNUxtb0k4em5jMWo3cXBCcmJ6T1UxT2pBL0JMNU1J?=
 =?utf-8?B?T2hOdXJLR012djZya3JTcFZEMmw4SDFJdkFjSDVVVHhRcmxNOHBLb2JhT3k1?=
 =?utf-8?B?RWx2SUtLR2hoOGVnR3BwTVJRNGRUamJLWjhkVk85NHVWbUhueHN5bmF6N1Br?=
 =?utf-8?B?UmNkWEQ1Z0x3cVVJbFFmRjdhbzQxRzY4VTd6NlNndlIzUEhSbjlGZThyaWVm?=
 =?utf-8?B?U2xtYTF4WDJnTFFpWTZWMlY3T1Q5WDByUnMyNVMzcUVGSVBnbk14QjRvVXFE?=
 =?utf-8?B?RXNPUEYrOFVoRXI0Qi9wY2x4b3VrbWpEYjRrMXYxM0tWeksxT1FMb2UzaDJt?=
 =?utf-8?B?dnVPM2s0RUo2TzFPRWVXTmpEdGxaTlpPU3hjRTIrSHJVaWdNSUtOWCs4bm02?=
 =?utf-8?B?d1RoMlBhcEtzVGRRdlc5SWk3VzN5MFdVeEk4bVBGWnI0ajFJeGJSOHVmMkJY?=
 =?utf-8?B?TjlRYjhFZFZ2Kzg5K3kwRzNjRzFUSzFWUlNMRFJrdDdRRUpsR1lXenpWS0hx?=
 =?utf-8?B?NjVxWnpZYnNUczNOY0lpUXlQTEczdkcvMWxseEFJVk01eXpqdndhd0FkeWN5?=
 =?utf-8?B?OEM0Y0YyY3lVOVpsVmpKNUdpaHFhbXhmdzI0SCtPTUNBYTFkWWVvNkdGbTZC?=
 =?utf-8?B?N0YvQ3ZWeWJ6cUN2TjVLWVR3ajB6bjdEM2M3Y3c1N2MxcWVseFNUamREMUhG?=
 =?utf-8?B?TWNxS2hIMW9sSGNuR2NReUV2SXJnbUZYd0RsZnBsRFhuOGNKSDc1cUpDMlZp?=
 =?utf-8?B?bExiY0VzYnRSMXdQeUY2Q0kzQ1owdjJvbC85eFJHaGhuTFlBcDlNZE11Mytk?=
 =?utf-8?B?RDByU3k3TXZJOU5jZjBhUmRZa3llYUdXd0NpaFlhKzM1Sjg0SVNPZ2p2NTcr?=
 =?utf-8?B?Z29KdmVyZWhzWitnbmFMQ3BNcHhsNXVSVjJDVkZEdzRxZnpsM0U3aUJDK1J5?=
 =?utf-8?B?M0dkb0NzTlpxZGxNa3dlRVhZNzh1V0lINlk5UVFIUHVPWHFxNUhYTTVpTDY4?=
 =?utf-8?B?ZW5wT1lqdm5BSkpENGhxVVJEZnZvQll2WlRDR0pCMUhlWmxyK2g1QU5tOVNx?=
 =?utf-8?B?NS9vNzRocWlyNCs5SkI3N1FDcHcrZk5UZ1NvRU1vZkc2VStZVExFZEM0Ym5r?=
 =?utf-8?B?OFA3Y0hvd0RXMGlEMFRsU1ZlZmpmZXY1QUNpSURDOWgrME1lMDNUT3JpTzlN?=
 =?utf-8?B?MlNRMFhwRHdhemlaMWxlTVdmREh5OXA4VUc5RjVPbUdZaXArMW53RWYwL1BH?=
 =?utf-8?B?MW0vT0o3SisrOEhIQzRMYzBIZVdJdUhVV3BlMXJXS01uOGJ1TE1VYVNDVi9D?=
 =?utf-8?B?REdHcU5Dci9XaU5QNks4eWZLZVhBN3hzQ0lHMks4aURGU1FQM0VQNHJQTllN?=
 =?utf-8?B?eE9OTDlLT3RPMWNucEplRllnMGV1VGEzalZPL0RVdzJBWHNqR0hsZ0NVd1JR?=
 =?utf-8?B?ZTF3NXByYVNTbFI4Qk8zcEZYV04wTUNsdE4vdFZoNVBZZFE4Y2tVeVhqazlZ?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46603FF706D58E4B8649FD03AA8B02B0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e936768-389a-4b4a-8452-08db0e7ba9f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 11:07:29.7844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DMtu9fyz2ldx8C/sDPUUv2+rgRjI+3VC9tpflOwHMP0wKQK5TP/+7l++5pCPCT84m9I38Bzu1wMCyan4pzejg+GtP/6thb4Yb7cosKyI/SM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7637
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMuMDIuMjAyMyAxNzo0NSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSBjdXN0b20gbWVzc2FnZSBoYXMgbm8g
dmFsdWUgZXhjZXB0IHByaW50aW5nIHRoZSBlcnJvciBjb2RlLA0KPiB0aGUgc2FtZSBkb2VzIGRl
dl9lcnJfcHJvYmUoKS4gTGV0J3MgdXNlIHRoZSBsYXR0ZXIgZm9yIHRoZSBzYWtlDQo+IG9mIHVu
aWZpY2F0aW9uLg0KPiANCj4gTm90ZSB0aGF0IHNvbWUgQVBJcyBhbHJlYWR5IGhhdmUgbWVzc2Fn
aW5nIGluIHRoZW0gYW5kIHNvbWUgc2ltcGx5DQo+IGRvIG5vdCByZXF1aXJlIHRoZSBjdXJyZW50
IG5vaXNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hl
dmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQoNClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8
Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NClRlc3RlZC1ieTogQ2xhdWRpdSBCZXpuZWEg
PGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL3BpbmN0
cmwvcGluY3RybC1hdDkxLmMgfCA2NCArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgNDMgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5MS5jIGIvZHJpdmVy
cy9waW5jdHJsL3BpbmN0cmwtYXQ5MS5jDQo+IGluZGV4IDA1NWE4OGIyZGFjYy4uMDhmODg0MDNh
ZmZiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLmMNCj4gKysr
IGIvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5MS5jDQo+IEBAIC0xMjk0LDEwICsxMjk0LDEx
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGF0OTFfcGluY3RybF9vZl9tYXRj
aFtdID0gew0KPiAgc3RhdGljIGludCBhdDkxX3BpbmN0cmxfcHJvYmVfZHQoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IGF0OTFfcGluY3RybCAqaW5mbykNCj4gIHsNCj4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlICpk
ZXYgPSAmcGRldi0+ZGV2Ow0KPiAgICAgICAgIGludCByZXQgPSAwOw0KPiAgICAgICAgIGludCBp
LCBqLCBuZ3Bpb19jaGlwc19lbmFibGVkID0gMDsNCj4gICAgICAgICB1aW50MzJfdCAqdG1wOw0K
PiAtICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCj4g
KyAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2RlOw0KPiAgICAgICAg
IHN0cnVjdCBkZXZpY2Vfbm9kZSAqY2hpbGQ7DQo+IA0KPiAgICAgICAgIGlmICghbnApDQo+IEBA
IC0xMzYwLDkgKzEzNjEsOCBAQCBzdGF0aWMgaW50IGF0OTFfcGluY3RybF9wcm9iZV9kdChzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBjb250
aW51ZTsNCj4gICAgICAgICAgICAgICAgIHJldCA9IGF0OTFfcGluY3RybF9wYXJzZV9mdW5jdGlv
bnMoY2hpbGQsIGluZm8sIGkrKyk7DQo+ICAgICAgICAgICAgICAgICBpZiAocmV0KSB7DQo+IC0g
ICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byBwYXJz
ZSBmdW5jdGlvblxuIik7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIG9mX25vZGVfcHV0KGNo
aWxkKTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJmYWlsZWQgdG8g
cGFyc2UgZnVuY3Rpb25cbiIpOw0KPiAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgIH0NCj4g
DQo+IEBAIC0xNDE1LDExICsxNDE1LDggQEAgc3RhdGljIGludCBhdDkxX3BpbmN0cmxfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAgICAgICBwbGF0Zm9ybV9zZXRfZHJ2
ZGF0YShwZGV2LCBpbmZvKTsNCj4gICAgICAgICBpbmZvLT5wY3RsID0gZGV2bV9waW5jdHJsX3Jl
Z2lzdGVyKCZwZGV2LT5kZXYsICZhdDkxX3BpbmN0cmxfZGVzYywNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluZm8pOw0KPiAtDQo+IC0gICAgICAgaWYgKElT
X0VSUihpbmZvLT5wY3RsKSkgew0KPiAtICAgICAgICAgICAgICAgZGV2X2VycigmcGRldi0+ZGV2
LCAiY291bGQgbm90IHJlZ2lzdGVyIEFUOTEgcGluY3RybCBkcml2ZXJcbiIpOw0KPiAtICAgICAg
ICAgICAgICAgcmV0dXJuIFBUUl9FUlIoaW5mby0+cGN0bCk7DQo+IC0gICAgICAgfQ0KPiArICAg
ICAgIGlmIChJU19FUlIoaW5mby0+cGN0bCkpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZGV2
X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoaW5mby0+cGN0bCksICJjb3VsZCBub3QgcmVnaXN0ZXIg
QVQ5MSBwaW5jdHJsIGRyaXZlclxuIik7DQo+IA0KPiAgICAgICAgIC8qIFdlIHdpbGwgaGFuZGxl
IGEgcmFuZ2Ugb2YgR1BJTyBwaW5zICovDQo+ICAgICAgICAgZm9yIChpID0gMDsgaSA8IGdwaW9f
YmFua3M7IGkrKykNCj4gQEAgLTE4MjAsMzkgKzE4MTcsMjggQEAgc3RhdGljIGludCBhdDkxX2dw
aW9fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAgICAgICBjaGFyICoq
bmFtZXM7DQo+IA0KPiAgICAgICAgIEJVR19PTihhbGlhc19pZHggPj0gQVJSQVlfU0laRShncGlv
X2NoaXBzKSk7DQo+IC0gICAgICAgaWYgKGdwaW9fY2hpcHNbYWxpYXNfaWR4XSkgew0KPiAtICAg
ICAgICAgICAgICAgcmV0ID0gLUVCVVNZOw0KPiAtICAgICAgICAgICAgICAgZ290byBlcnI7DQo+
IC0gICAgICAgfQ0KPiArICAgICAgIGlmIChncGlvX2NoaXBzW2FsaWFzX2lkeF0pDQo+ICsgICAg
ICAgICAgICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIC1FQlVTWSwgIiVkIHNsb3QgaXMg
b2NjdXBpZWQuXG4iLCBhbGlhc19pZHgpOw0KPiANCj4gICAgICAgICBpcnEgPSBwbGF0Zm9ybV9n
ZXRfaXJxKHBkZXYsIDApOw0KPiAtICAgICAgIGlmIChpcnEgPCAwKSB7DQo+IC0gICAgICAgICAg
ICAgICByZXQgPSBpcnE7DQo+IC0gICAgICAgICAgICAgICBnb3RvIGVycjsNCj4gLSAgICAgICB9
DQo+ICsgICAgICAgaWYgKGlycSA8IDApDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gaXJxOw0K
PiANCj4gICAgICAgICBhdDkxX2NoaXAgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9m
KCphdDkxX2NoaXApLCBHRlBfS0VSTkVMKTsNCj4gLSAgICAgICBpZiAoIWF0OTFfY2hpcCkgew0K
PiAtICAgICAgICAgICAgICAgcmV0ID0gLUVOT01FTTsNCj4gLSAgICAgICAgICAgICAgIGdvdG8g
ZXJyOw0KPiAtICAgICAgIH0NCj4gKyAgICAgICBpZiAoIWF0OTFfY2hpcCkNCj4gKyAgICAgICAg
ICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiANCj4gICAgICAgICBhdDkxX2NoaXAtPnJlZ2Jhc2Ug
PSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQo+IC0gICAgICAgaWYg
KElTX0VSUihhdDkxX2NoaXAtPnJlZ2Jhc2UpKSB7DQo+IC0gICAgICAgICAgICAgICByZXQgPSBQ
VFJfRVJSKGF0OTFfY2hpcC0+cmVnYmFzZSk7DQo+IC0gICAgICAgICAgICAgICBnb3RvIGVycjsN
Cj4gLSAgICAgICB9DQo+ICsgICAgICAgaWYgKElTX0VSUihhdDkxX2NoaXAtPnJlZ2Jhc2UpKQ0K
PiArICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoYXQ5MV9jaGlwLT5yZWdiYXNlKTsNCj4g
DQo+ICAgICAgICAgYXQ5MV9jaGlwLT5vcHMgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2
KTsNCj4gICAgICAgICBhdDkxX2NoaXAtPnBpb2NfdmlycSA9IGlycTsNCj4gICAgICAgICBhdDkx
X2NoaXAtPnBpb2NfaWR4ID0gYWxpYXNfaWR4Ow0KPiANCj4gICAgICAgICBhdDkxX2NoaXAtPmNs
b2NrID0gZGV2bV9jbGtfZ2V0X2VuYWJsZWQoJnBkZXYtPmRldiwgTlVMTCk7DQo+IC0gICAgICAg
aWYgKElTX0VSUihhdDkxX2NoaXAtPmNsb2NrKSkgew0KPiAtICAgICAgICAgICAgICAgZGV2X2Vy
cigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIGdldCBjbG9jaywgaWdub3JpbmcuXG4iKTsNCj4gLSAg
ICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIoYXQ5MV9jaGlwLT5jbG9jayk7DQo+IC0gICAgICAg
ICAgICAgICBnb3RvIGVycjsNCj4gLSAgICAgICB9DQo+ICsgICAgICAgaWYgKElTX0VSUihhdDkx
X2NoaXAtPmNsb2NrKSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKGRl
diwgUFRSX0VSUihhdDkxX2NoaXAtPmNsb2NrKSwgImZhaWxlZCB0byBnZXQgY2xvY2ssIGlnbm9y
aW5nLlxuIik7DQo+IA0KPiAgICAgICAgIGF0OTFfY2hpcC0+Y2hpcCA9IGF0OTFfZ3Bpb190ZW1w
bGF0ZTsNCj4gICAgICAgICBhdDkxX2NoaXAtPmlkID0gYWxpYXNfaWR4Ow0KPiBAQCAtMTg2NSwx
NyArMTg1MSwxNSBAQCBzdGF0aWMgaW50IGF0OTFfZ3Bpb19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiANCj4gICAgICAgICBpZiAoIW9mX3Byb3BlcnR5X3JlYWRfdTMyKG5w
LCAiI2dwaW8tbGluZXMiLCAmbmdwaW8pKSB7DQo+ICAgICAgICAgICAgICAgICBpZiAobmdwaW8g
Pj0gTUFYX05CX0dQSU9fUEVSX0JBTkspDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHByX2Vy
cigiYXQ5MV9ncGlvLiVkLCBncGlvLW5iID49ICVkIGZhaWxiYWNrIHRvICVkXG4iLA0KPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYWxpYXNfaWR4LCBNQVhfTkJfR1BJT19QRVJfQkFO
SywgTUFYX05CX0dQSU9fUEVSX0JBTkspOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBkZXZf
ZXJyKGRldiwgImF0OTFfZ3Bpby4lZCwgZ3Bpby1uYiA+PSAlZCBmYWlsYmFjayB0byAlZFxuIiwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbGlhc19pZHgsIE1BWF9OQl9HUElP
X1BFUl9CQU5LLCBNQVhfTkJfR1BJT19QRVJfQkFOSyk7DQo+ICAgICAgICAgICAgICAgICBlbHNl
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGNoaXAtPm5ncGlvID0gbmdwaW87DQo+ICAgICAg
ICAgfQ0KPiANCj4gICAgICAgICBuYW1lcyA9IGRldm1fa2FzcHJpbnRmX3N0cmFycmF5KGRldiwg
InBpbyIsIGNoaXAtPm5ncGlvKTsNCj4gLSAgICAgICBpZiAoIW5hbWVzKSB7DQo+IC0gICAgICAg
ICAgICAgICByZXQgPSAtRU5PTUVNOw0KPiAtICAgICAgICAgICAgICAgZ290byBlcnI7DQo+IC0g
ICAgICAgfQ0KPiArICAgICAgIGlmICghbmFtZXMpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4g
LUVOT01FTTsNCj4gDQo+ICAgICAgICAgZm9yIChpID0gMDsgaSA8IGNoaXAtPm5ncGlvOyBpKysp
DQo+ICAgICAgICAgICAgICAgICBzdHJyZXBsYWNlKG5hbWVzW2ldLCAnLScsIGFsaWFzX2lkeCAr
ICdBJyk7DQo+IEBAIC0xODkyLDExICsxODc2LDExIEBAIHN0YXRpYyBpbnQgYXQ5MV9ncGlvX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+IA0KPiAgICAgICAgIHJldCA9IGF0
OTFfZ3Bpb19vZl9pcnFfc2V0dXAocGRldiwgYXQ5MV9jaGlwKTsNCj4gICAgICAgICBpZiAocmV0
KQ0KPiAtICAgICAgICAgICAgICAgZ290byBncGlvY2hpcF9hZGRfZXJyOw0KPiArICAgICAgICAg
ICAgICAgcmV0dXJuIHJldDsNCj4gDQo+ICAgICAgICAgcmV0ID0gZ3Bpb2NoaXBfYWRkX2RhdGEo
Y2hpcCwgYXQ5MV9jaGlwKTsNCj4gICAgICAgICBpZiAocmV0KQ0KPiAtICAgICAgICAgICAgICAg
Z290byBncGlvY2hpcF9hZGRfZXJyOw0KPiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4g
DQo+ICAgICAgICAgZ3Bpb19jaGlwc1thbGlhc19pZHhdID0gYXQ5MV9jaGlwOw0KPiAgICAgICAg
IHBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGF0OTFfY2hpcCk7DQo+IEBAIC0xOTA1LDEyICsx
ODg5LDYgQEAgc3RhdGljIGludCBhdDkxX2dwaW9fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCj4gICAgICAgICBkZXZfaW5mbygmcGRldi0+ZGV2LCAiYXQgYWRkcmVzcyAlcFxu
IiwgYXQ5MV9jaGlwLT5yZWdiYXNlKTsNCj4gDQo+ICAgICAgICAgcmV0dXJuIDA7DQo+IC0NCj4g
LWdwaW9jaGlwX2FkZF9lcnI6DQo+IC1lcnI6DQo+IC0gICAgICAgZGV2X2VycigmcGRldi0+ZGV2
LCAiRmFpbHVyZSAlaSBmb3IgR1BJTyAlaVxuIiwgcmV0LCBhbGlhc19pZHgpOw0KPiAtDQo+IC0g
ICAgICAgcmV0dXJuIHJldDsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGRldl9w
bV9vcHMgYXQ5MV9ncGlvX3BtX29wcyA9IHsNCj4gLS0NCj4gMi4zOS4xDQo+IA0KDQo=
