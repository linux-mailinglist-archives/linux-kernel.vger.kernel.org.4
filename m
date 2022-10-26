Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40E360DC5F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiJZHmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJZHmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:42:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2607A10FE2;
        Wed, 26 Oct 2022 00:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666770156; x=1698306156;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+6pRUfyktjuCrR9VPFcZzWse0mRGptJ9eyy7OqDBoX0=;
  b=dIBHPV6x39elv72xfpB/Vn/TiOjCvCi++UaOphlBzoYK5aIZjBsINqe7
   3XXutIO18z0ZSQDbs8r1jRq1ej9r+d6mDq2RISskoRkhNl8yB9v3ssaDl
   XWJS7bHEQatSbQ/fj+erWn9BnLQ+37ThS+CxytRqNGgpT2Y3NH2bPW44A
   tms2n9ws2hxeR1IWsBP22TlKBIg7XB12oPboCHtN7NANKYcBm9klpOj0C
   QsLMRVV8hgFi/I6CUa+SDqLGSZLDEg2l24DPheFxikRJDG4wvvsZ1NlYb
   jSMCTUyt6r28fHBG9EJun82BE4rI0CUsS7qeEbuD1K0RKyxkvSesYbLir
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="186325840"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Oct 2022 00:42:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 26 Oct 2022 00:42:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 26 Oct 2022 00:42:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLjTsJJyMY0g8WqSArIAh7oELwdlBuwzbMT1O5KLZZNCeYCS9uq5B8r+CQmtl2KM8vYPTAfY+gKrPY2O3Q1gcQQZbx0MvHbRgGEARcfsKw7LRvPtEJi2NhReGYsYYmzQd+S7eSMG5G0QjJf+W2KLztdB1XfSEn3Vx/2oTcjvOrkIkSm9lO2SgY/s/QnTJO632dgaXAiayYzW9w3P0zDPinC0FpaC+Dzgg3zgv1nPjhojIASfocLTpRXf0u3UJpIFGLzRfPgYBqNs9KIcnHmPmpYS21HG4sHGEgHTQDKgyE8I5YkuJRjGwaGf7JzzLhoUMNuy2RdEIdqMTB+HvXsrSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6pRUfyktjuCrR9VPFcZzWse0mRGptJ9eyy7OqDBoX0=;
 b=RuyHHsMh/FSD9IsYUcG7uxQ0M8J36hSChjSdtsc1mW/SLgUwrp+2KGmrITq8xG1Zu552bM+uuA/fmfs6VsR4IHpY+P0ZdL+V5bclEmbihAUvqw8nRdjswRaYcfaAhybQaeiVUhXKL9MIYfnHCypGmWOJorwD/2M2n7AzPd9ntmeiy8os2sr6t9MusfJWiTjaHrgs4czAe/v+6GnFSOF2KKKW2eRwbhusDdRlRNChJH6hLluT2QQrbBFO4JqtLMKGzzR7L6cKZlQHvJbSZ8VAOhnoQXiUFKBa399SOouux5mjUe1260VJQlpeklh4hH/Ha4kS1SWc/9hmE0DGnHjfXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6pRUfyktjuCrR9VPFcZzWse0mRGptJ9eyy7OqDBoX0=;
 b=Z9hAQe8flovNeJoa9JkGLnsEyf1MxAsHT0ibpJu61cAnxOq4JMFcAB3f3zmmmMe7Cj1uxO87ka3IQg77mo3/jHmxmWXWsgVj0vrbFBjtmlOptJKkC2qMnle9cdzQQ1yzUaMbiV5p1Fnu+Jl//iLqnP62+WirVz8p5+yc6aGgB40=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SJ0PR11MB6574.namprd11.prod.outlook.com (2603:10b6:a03:44e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 07:42:30 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 07:42:30 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Horatiu.Vultur@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH] ARM: dts: lan966x: Add otp support
Thread-Topic: [PATCH] ARM: dts: lan966x: Add otp support
Thread-Index: AQHY6Q6AX0m+slYKd0e360Jbb8D3+A==
Date:   Wed, 26 Oct 2022 07:42:29 +0000
Message-ID: <c108d42d-dae8-0852-d89b-160b70b196dc@microchip.com>
References: <20220916194946.2869510-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220916194946.2869510-1-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SJ0PR11MB6574:EE_
x-ms-office365-filtering-correlation-id: 7fb514d9-7659-40c6-ddc1-08dab725a2cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3g0bf6sz46aMRg0NXyceZViU7P6ieOb9qW9CSXgUEhWGN0lvaBVzQ4VqWAJdxeb8w0FEvyafJcOru3otiQPkc8VjJ0mq7iecOnfmhP9Yg1AeOYYloi3xmHQp6yAaiFJqu6/CEd+B/dulVapKmtHA0gYZvzP/GXzXqQ9TvBTQnWkhh5J/7igWiiZ9X9KSE/OhYSdIJZlGFeMH/hnUz8Yz3VsQBd1DTaRUu1qUtAUG6SvDeSKxU9S4g4DZ8aMBD3Zh/aOrCS/mBsIgwHQDwIXqufAU4veyIIBcSgR/N5WUVu7zbIv3ByLBFbxagEl7VCv0mGSR0nv0feiTPQku0spABcnDuu2tXSXGLeoPsFYkyKdepVGQa33tNejQilzdeCXlwtKqogtPodAOpKKIRvXoRPE7gNL06spHOzFPxWn+UNMfaWd5KGh1FFY1erjU0Ho49NFVB4UVqcEbQCizPlNSBiThurPZRyulIQWhrQyyls5lC4EnWh22mUvC1GpKeXxBDtU37Mb5cSE59ekKTmOf3FYEdZq0arnXTl1ZYf8oxXKRiF26OgO5NaUmNmF5/mgzNafFxK1+5QmVHXK1LcyTSdajMLnqbCr7kGGpl52UvK7r7iIzBaHEPG/v86OYsyV3S7UvmsXqKN4i6U5SNYYcO+3thnJ9hgEkcCq67+IONGovtgF3O2Bx1RtYYSL6M58jR86Ses/wSh/41aagQ3oyHilS94Q03J8dWOAGbCpnEdt53PHzb6OoHjIASuyQ160pa+LbvO8Y+8b6kZSoycjiCprDvsyNa1znpnfKG/UPuw7bOjhCjDVuTGdbqE9QOD3Un2Rh3a7N1Mn0I9NNB0gtRrsQH8kmj5kKFWOTf9viVD9Srjw0qms1Xc+xqtz8doLuCP1rz0MrXr0PU7EFPc5Grg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199015)(71200400001)(6486002)(31686004)(966005)(76116006)(478600001)(31696002)(86362001)(53546011)(64756008)(122000001)(66446008)(66556008)(66476007)(5660300002)(110136005)(54906003)(91956017)(2616005)(186003)(41300700001)(8676002)(316002)(38070700005)(2906002)(26005)(6506007)(8936002)(36756003)(107886003)(38100700002)(66946007)(6512007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGRrYnREVk9jSnZ2N3VTN0cxazRYWkt1RG1GWXcwMEdibXRPak80a1ZKWjlP?=
 =?utf-8?B?c0lOM0JDM21Sd1BMS3pQeXBMMkxZQVY5NDFJVnNNaE5oVk0wdnNDSGo5aWxz?=
 =?utf-8?B?SHN3ZDFLMzQwRHU3OVZlckFGQ09iY1l4K3ZXemxYNjgrYzFlcjc2a3BXTXJK?=
 =?utf-8?B?Y1Z2OUgvdWJYZnV6Ynd1WndBRHFibVpuRCs2aSt2bHhydVRUVU1ZQ2JnT3Vj?=
 =?utf-8?B?d0JOdEtvWW84VEg5Ykw4eHJNQ1BtZVZOYnF2emZEUFJ0OGg5eS8zajVRbzBk?=
 =?utf-8?B?WFIydk9aZmxXb1lhUCt3cm9UbzJjeElmZ2Jjak1LU29NNkxIZGNNbFJ1RHpj?=
 =?utf-8?B?N29lZExvZzFVaCs2YWhPRUR4Q3NGZUZ4VjkvZlNLTjFYR2p1L0dPeU1BMDdj?=
 =?utf-8?B?Q0FwR1daaUN4RFVEaGpPVkpsalcvYjFTWXJuMzRzRFFadGlEajF0bzIxckVa?=
 =?utf-8?B?bU9HVUszN2V4dDRKb3M2bXoyUElYUEppVUlyeDhRcnlJbXpxOGNnK2NJN1NN?=
 =?utf-8?B?MVhBS3hBNmd3OFFVWGZ3dzRZMWMyMytZc0lLRTdINzNjZ0UzMC9RRGZwWE9k?=
 =?utf-8?B?TSthamNEbVBja09BWGZnNmZUVWhJLzk2SmZPb1NNVHQ2N3ZNL0FtMVBPbGlw?=
 =?utf-8?B?Z1N0SVo4NDNxeXFoQlFFaUkrQUZrYzg5MHE5TUNUaUJiUzNaTUQvRHd3U250?=
 =?utf-8?B?cVhoRHM2OHFUUVdaRGpGTGdzTmRSakIyQVU3Uk1VWFdLbGNvaDVEZm96a21G?=
 =?utf-8?B?WUFjTXFubUVTc0txN2FycUdWQVJMaUlvb1FUOElzY2hKQUphbFA0eTF4UU5k?=
 =?utf-8?B?N0dwUnIrendqMW1UMkExRGNuNjdjcnduMDlBcllMN3lPaHU2UkZEaHNrYmNr?=
 =?utf-8?B?T3BRQ055VEN0cFFjcWRhOHZCRGJJbzRXTzgxdnZvamhrZnczL0lOZ0FaaW00?=
 =?utf-8?B?M2lZZmJGaGl1MmVDa2ptdlEzNlRmWlNDbGFvM3RRWjE4QW5POUtTTTVNMitK?=
 =?utf-8?B?N2didmpmWmFvdndTR3c2SUt2azJpUTFmenFIdUJGM0pjaUdnVWtRb3FHbk5o?=
 =?utf-8?B?QUdpNWtQT2d1Z0YvNGRyejlyNTNSUTFBeXBIaGh1RWFlR3F4a2hFNndlT0xN?=
 =?utf-8?B?aHdXZE4xQUdKb0RmSnNpNG1ZNFZjVFh1NjVlbjJya2k0cUtiTFFldHRwYVFI?=
 =?utf-8?B?SEl5L2kxRzZxNEhhTHVmKzFLcW1lNFlHaVJ1aGh6OEhOc3VGNUpZY3hreFBC?=
 =?utf-8?B?TFgrZzFTWkpJNHJyVFBsUHM1UlUyaTZJQjBvd0xHY1NubU5YK2xOV096eTJO?=
 =?utf-8?B?MFNwS2VMUEw2dXJZRVFwU3FkKzd5MUpFVVo3c2hTbldHYzlDWW80aGFPaDc1?=
 =?utf-8?B?bVQ2NU5tUWpodkZsdWo0UktDTUFWS1FFdlBpVWxhOG1lSW1kRDFrb2ErakRV?=
 =?utf-8?B?cDNIdE90L3RCY2EyWk55THVwVHdFa1dEUXFGVmZLeEsxZERLb0U4b25Pb0xH?=
 =?utf-8?B?ZTRMMlpYdVErRnVYUkI0aFNma2FZQ3NPSC93Mm41cHlLY1YwWHE5cmUrOElO?=
 =?utf-8?B?MDJHN0xQZnhpSU9xK2JVdmFtOTBjTS9DaFdSazh3NGtCUzh5UlJCd3Q5bHNL?=
 =?utf-8?B?aTNXZ3hRYnlKdVQ0RkxOY094cERoYTBUc1ZiaFgvNHgxQk8xdExkd3NmVlZl?=
 =?utf-8?B?bzZ2My9DQUhlSHFpb2JBdStkL0tndkVsamV5UFNWcWJBbmNncXN3WlRZL2l6?=
 =?utf-8?B?TjFSSWZEd0g2ZVJYS241NVcybHJqWWt4emlMeklmaysyTGtoRE9aL2JnajNO?=
 =?utf-8?B?R29YQjBHVURFSW9uMTk4M2dxa3JwQTRhTWJtUmdDNGZndG13bG9ndjlyWVJU?=
 =?utf-8?B?NXVsU1lJamtCblpGcU4xcUhORlM2dHpnVXF3V2VNa1Z5V1pYSDBXWmV6YUJD?=
 =?utf-8?B?b1hxQkV5RHZ4dG1rNUFCaEREWU13YTZHN0p2Vkw4V3Y1dk1waVRQQkVCUTJH?=
 =?utf-8?B?cnkrQWVybks3LzR6b056cTd3eEU3RXVFMFU1Y0xHSXRIYTMrTkNNVUhlQXIv?=
 =?utf-8?B?WFQ2cDB0Wnp1aitmS3lvU2tjR1BpOUxiVXl6VjBMTmRiSXJ2OTRCUWhlS1NP?=
 =?utf-8?B?TWxXSWY3Y2YzRjYrOEhYUnduTGpCdUYrMEJ0YUNwWXNFZ01jNEhybkc0Qng0?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79A8419D5A709842A9ECF6A7138BB049@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb514d9-7659-40c6-ddc1-08dab725a2cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 07:42:29.9042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4vH1h090tRNVty9xa+YrkkHguE8uikxxe/9eGx48YTebbnTHHtzWaeM+8jYguwbq9jgVVbmucyVkAKSkxYP4k62CaTiak5qzcqw8qol1D8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6574
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhvcmF0aXUsDQoNCkkgd2lsbCBwb3N0cG9uZSB0aGlzIHVudGlsIFsxXSBvciBbMl0gaXMg
YXBwbGllZC4NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KWzFdDQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMjAyMjA5MjgxOTUxMTIuNjMwMzUxLTEtaG9yYXRpdS52dWx0dXJA
bWljcm9jaGlwLmNvbS8NClsyXQ0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIxMDI1
MDcyMjE3LjM3MTU2MzQtMS1jbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tLw0KDQpPbiAxNi4w
OS4yMDIyIDIyOjQ5LCBIb3JhdGl1IFZ1bHR1ciB3cm90ZToNCj4gQWRkIE9UUCAob25lIHRpbWUg
cHJvZ3JhbW1hYmxlKSBzdXBwb3J0Lg0KPiBUaGUgYm90aCBsYW45NjZ4IFNvY1MgKGxhbjk2NjIg
YW5kIGxhbjk2NjgpIGhhdmUgdGhlIHNhbWUgT1RQIElQLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
SG9yYXRpdSBWdWx0dXIgPGhvcmF0aXUudnVsdHVyQG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAg
YXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpIHwgNSArKysrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRz
L2xhbjk2NnguZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaQ0KPiBpbmRleCAy
MzY2NWEwNDI5OTA2Li43ODRjYWJhMzY5NDg1IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290
L2R0cy9sYW45NjZ4LmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNp
DQo+IEBAIC0xNjMsNiArMTYzLDExIEBAIHBvcnQ3OiBwb3J0QDcgew0KPiAgCQkJfTsNCj4gIAkJ
fTsNCj4gIA0KPiArCQlvdHA6IG90cEBlMDAyMTAwMCB7DQo+ICsJCQljb21wYXRpYmxlID0gIm1p
Y3JvY2hpcCxsYW45NjY4LW90cGMiLCAibWljcm9jaGlwLGxhbjk2NjItb3RwYyI7DQo+ICsJCQly
ZWcgPSA8MHhlMDAyMTAwMCAweDMwMD47DQo+ICsJCX07DQo+ICsNCj4gIAkJZmx4MDogZmxleGNv
bUBlMDA0MDAwMCB7DQo+ICAJCQljb21wYXRpYmxlID0gImF0bWVsLHNhbWE1ZDItZmxleGNvbSI7
DQo+ICAJCQlyZWcgPSA8MHhlMDA0MDAwMCAweDEwMD47DQoNCg==
