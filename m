Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0875B8805
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiINMRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiINMRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:17:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9174A80024;
        Wed, 14 Sep 2022 05:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663157860; x=1694693860;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UsE+4OSOyWX5r2v0/Ar7HNnfrnCDRyeKAkfLtRerkzA=;
  b=12ERWHf2nBMh551CsORR3vd7UH5dCKfp+EJB5h8SPtgM2r0sacuAfJBR
   zH3JjMB+eRTcPqjC8hm5PCRzunG37zvpXIrfDxuwmFnTruQRVXVqhJj/B
   iMJB7YRjpiuxwYYIwbq3V/wBOFGQ7O501XPSMnGa0dfQzqcAIqoKVOzvw
   oWBoYiG3IRMLLmHanZj2/V/+8r1OAxX14sEtLJfXqDlcdu83rrnVWW57U
   Hk5tystLpWmWxPHbJ25zIWddUanNtJq4+AbHo47ZUoJJ13A0cGMlS0wo9
   t3sjKpL4wbJseHn+GOjtLvqVvd8fKLxsZNGM1Nl7EXjGiTgVxVWI47kdG
   g==;
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="180347216"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2022 05:17:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 14 Sep 2022 05:17:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:17:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2zmwUrub4q7/YHdeRE1E7Ku4Z/ORhxG0vcXkPU7VFiryTGVKREAFCRBtJJrPEt3lKSDiIWnow7HWgizvN4niNu4lTy0tFAA+lJ6LLYUywDo4dCpRaWTW3rUN4BDJQtCufIJlvmmqNv+ZbjuhEhl49iZhW7pZolb/AyjtQdpOeI1kEwL9QCo6kQ3fQQsj6XuTys96My/fkLWcOHAcOWPuWJq4GbBg18vep6zAIkP+OCiJ656G1Tbjo1yg6HXD/v67kxljUt0NvLAyjMf57i3iMOnhHPJ3Fy2+DElc+KeBvshteB/POKlHwwzs3pA/LrLVOacdDO+rC735ZJ4fEf/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsE+4OSOyWX5r2v0/Ar7HNnfrnCDRyeKAkfLtRerkzA=;
 b=ZIfRBXnL+uM9gn/NbTKdHhBslB4IW8goQa5Qw4FLpIbpvsNrjs9pA9a9UAc5TsgmS3tvm2WjBHCUXVyUDxp20yF3wNENyet22t2nlJITsOdt1drXRI3s4NQrEAIzq0PjmKrvEJOg2zhG6RCRbTzU10MLui5nFiBjLlclTSG85ihuP2HgKhR13ijXQqZgHSvcLufM0GLp1sQ4gYN3rM9nOa/tFjH5J0dGlJ+ZdmydhGwNJdbTU1vjGMiCYeaREPXps339Ucgsh7i1cK6joH1YPwvm9i+x5wyhIjPVup9/+S9MCkGSxMMYEnZ5FwK6swsq6qqyaDkRaHzQL3O+B+QODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsE+4OSOyWX5r2v0/Ar7HNnfrnCDRyeKAkfLtRerkzA=;
 b=k69xx3ikKv6R6Zkb5VRiR8aIpttD285Cpgx8orVnduMRkRy0K3vcrrdf9zlSUozQggn17LZTcbzyMmv5eoCvAYSWzFAoD/oWdxpXChAw1ljAm5QVqIWQIkp8Udm9+KIHY5uuEiMqRrcNqr0XpT6/i9f/D5bQlPf7tTYy4C/N/5U=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by SJ0PR11MB4880.namprd11.prod.outlook.com (2603:10b6:a03:2af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Wed, 14 Sep
 2022 12:17:26 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::e8ff:82ac:b76d:c61c]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::e8ff:82ac:b76d:c61c%4]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 12:17:26 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <ilpo.jarvinen@linux.intel.com>
CC:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Tudor.Ambarus@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v3 12/14] tty: serial: atmel: Only divide Clock Divisor if
 the IP is USART
Thread-Topic: [PATCH v3 12/14] tty: serial: atmel: Only divide Clock Divisor
 if the IP is USART
Thread-Index: AQHYx3zzMhzVjPNTcEWjX8niX8lETq3ew78AgAAVLQA=
Date:   Wed, 14 Sep 2022 12:17:26 +0000
Message-ID: <701a3931-6718-48cf-5e85-03e94c8f2671@microchip.com>
References: <20220913142205.162399-1-sergiu.moga@microchip.com>
 <20220913142205.162399-13-sergiu.moga@microchip.com>
 <13397da3-274f-7180-d185-a4377d251978@linux.intel.com>
In-Reply-To: <13397da3-274f-7180-d185-a4377d251978@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2758:EE_|SJ0PR11MB4880:EE_
x-ms-office365-filtering-correlation-id: 3485532b-fa1e-424c-67f0-08da964b160c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1V1aEG7vQ/EkUvJ1A5b5ZO4RPysieCMKp2fQNmNR1sGDUYXqyCKtF43Q5e2z8Z1JoBGO11fzEV9B6hxjAKSNnJm1QHXojtavUhLyk6clTpyq74IR6WYMje7C9dmJ/bkGA9Tx/+4iD9CyWfNICuu4nVU+vFWXwr+XvN1mZpeaNgiJveb2ae58FmUYwNxQm34tlRSZyoqz3NcdN8F7lUDP2zImkuA5lmxDY7MAmNAeGPZSMrWWCXQS9u9O7HXxHX2tkvNTE1/iz2yael4iCLoDze/u51EH/kZ6KqA6dhwFbU1tahNK8GnwqSKpN3R44RIBRkH8DaV8SIwQdkUHcoCWFc4zK5TV07gM5/0GbImvBYFr5AmicOWVmAy5PWznDfbmwv9ExHD8aBMnVIYFJ/aEmJfXP78q8eFnnZVZ+BuhO7u2n0A33uOFBf8FGcf1YmTBb9ESigywg+UbsmIoWYLTsV2fP40HdYqCuWbTV6CXbws0rMeJ943rMq+85V2akFC1GCBbRU0F3AFBmqITN0OeHxp9OnGhd2qjO+FPsmzgy58PAHcVndqMDCJscMTPg7EBACzyhmg+ekfcgXGMNfxq9HoQzwaEKDNiwbl8FsHvwOMpmDoqBap9lSbAFD6hJdfGRK7DlSnDqR8rjsBvzpBcQSAq/ZhU2fmhAZHznKmc7uzrs4FyhaQELP33je0/wosbruKTSdolVuxKZTaBICWFTxz0nmiErEmT7uc/2kk86TS8PgbRD3PHEiTjeg/x0PHG08TxBJsWxhD9gvzdxNDGhUs8P70Oyj88idl+bwgPpcU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199015)(2906002)(316002)(66446008)(31696002)(6512007)(91956017)(41300700001)(4326008)(64756008)(8936002)(38070700005)(6486002)(2616005)(7416002)(5660300002)(71200400001)(186003)(38100700002)(8676002)(54906003)(6506007)(76116006)(83380400001)(31686004)(122000001)(86362001)(36756003)(66556008)(66946007)(66476007)(26005)(6916009)(478600001)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0o4b01vRHlYUytKM3V2R25PajR1WUVNVFkyZDFJajZGY2tsaUN6MnIzQ0RI?=
 =?utf-8?B?bWpnbnMwWERWa3FPRDhuYUVaVjN3eFBZWS83Q2ZPd2ZmOEs2cmVHRnVLd011?=
 =?utf-8?B?WkxOTkE2d3FNbzZoQzBjTHY2cC96dTlVRi9IcUo3RjRQZU91THFVdjFtL1Bp?=
 =?utf-8?B?VVgzK2FkMC83Y3JSMW5yVkhpNjkzNklQaVM4WGhIeWNzM0QxQXJaMXJvcjV6?=
 =?utf-8?B?SytaMUJqdldCeTNmV25MYlNheGxwSjdPRDVMb2p0RVhmRkRuYjJHdEdDdjZx?=
 =?utf-8?B?OXRMNjlDbXZLZmd4a01sVEhRUHZhd0d4SzhFR0ZwK1E5Ym1JWjkzZ0xpbWNV?=
 =?utf-8?B?VE1yYUgvTmdBbU44R0JtKzBVZTdOTnBCNzNhY2RjOGNoUjg1d1B4QTJNa1hv?=
 =?utf-8?B?NkNqWjZVOHF3ZUJEVGRGaXA4bHM3U0dxVk5jaU9zVk5PT2Z1dWx1RW9GMnFn?=
 =?utf-8?B?Q1FieGdNaVQ1ODM0cU5OVFJBNFFLa3N1VUVIVjFqK2xLVHM5M2RWZm1NNDkz?=
 =?utf-8?B?WW5nNGFQRkpHTXZrMjA2RlhpME1wWHJySC9xOC9aZVROLzBoVzdIVmtHVENM?=
 =?utf-8?B?TERoMHlMN000dGgyWnZHaDltdXJQYnBzbFNpQXhOKzFzbzVYVTFBSXhkMTNl?=
 =?utf-8?B?clJxMkhlQkRhVlQ5TWRrdjEzVE5VenU3RzI2WEtRM1JMdnU2dHl1d2tNK2F2?=
 =?utf-8?B?RVdkSVNPMUNqMkFQWGM3bjI2TFVCUlVCVDJLUzE1UjNPc1pFeU9FVWhqeE1J?=
 =?utf-8?B?YkNxUVBZbnhPZiszUkNQdy9GRXRvOXEyWUlFQlRndFpRZEVBckFDa1BwVnJ2?=
 =?utf-8?B?RCtDRWlTbzZSQXU3K3NXOGc2UE1RLzQxby9JbXFETy83U1lmbU94UFhocnpF?=
 =?utf-8?B?MGpCWjk0Sm92ZXhlMFl4aE9TWHRhNExRU1dUeHQ3aS9ncnhGNzB2VFlpejR1?=
 =?utf-8?B?NzN3Z2tjZlEzR1NnQW9HU3VRVU43ZTBBZE9TWTh6bWE0RENYSGYySGJmT2dj?=
 =?utf-8?B?MC95TXo0dHlaQ2JaTVRpNkp1Tkhpb1lzcVBFc1hQNTgzalI2dG9Od0xlQXNy?=
 =?utf-8?B?YkRPZzRwalVXSHl6MTBJK0R4dVA0LzY3dG10QllQdnFxZ3B6bUhwTWlCOFRv?=
 =?utf-8?B?U3hUdGVuN09NVURmcXhPeWlab2gzVHJtNVo4WnJMUmZqSTBMOEFkSGRKUlBw?=
 =?utf-8?B?TnozaWVoSWtadkNjTE4xZFV2OWJNeitrRUNkbldkVW9rM3lQMm1KeGpRcEl0?=
 =?utf-8?B?S0VaYkhzQnY3U21DWUpkSWM0Y0ZYa0ptcjZJTUxHbkI2SGRocTEvNHpBcFUw?=
 =?utf-8?B?ZDRoUlBHOWUxbTU0NEh1UzhSU1N6S1N4YTFUTG9seDZobDFidWFnK3ZOdnA4?=
 =?utf-8?B?UDl2dUJJZUJZSDhuWXYwbzJiLzNQcGlqclVCcmUrUUZ2WTY2UENGV2RwY2FK?=
 =?utf-8?B?TmtMTHVwVVNIT1dBU2ZmYVhmY0cvVDNHRHduWndRT3gwMytLRk9YeVFpYXFs?=
 =?utf-8?B?MFk3N1RNWEZZalowY1orYlh2QjFkdHlIQlp5bS9DWXRyTnM5WVBhSk9EWnVX?=
 =?utf-8?B?N21vUk8vdk9TbVhmRkR5M2ZwTEFhMXJ1b3YwQmZ0SU5iWWowYkU2bTczRVBt?=
 =?utf-8?B?eEJyamI3VHVvbTczd1M5K09DYmNWWWFnYWZJUmp2L0pGRkx6Q3JsSFJqTlJH?=
 =?utf-8?B?a3hlcWVhT1dXa2NaOUpodGM5cFBRQWJDemdTdHFnNjJJeHBGdWxRdWU5RWNJ?=
 =?utf-8?B?MUhsdFVLSGF6dTlMcnFYSmROZU1NY1QzRVkrYktjU0JsaXdJYkdWR1Q4YkhP?=
 =?utf-8?B?eGZYRDJDSEduVzgrSU5rWmJJYjVxRzRmeEpadVVlTDRSb2dTazFINzI0L2di?=
 =?utf-8?B?d1BzRitFeGtZa1RsSHhMYmFXdGVzUWw3c0VMTEwyZndiejVDWURkWDlTODZN?=
 =?utf-8?B?eklQYXNNUFNoQnEzWTcrc3oxcTJqdmtydjlTZjVyQmhuNitRYlhCVmFBelhx?=
 =?utf-8?B?WngvTHNwZGYveGVBdEsxQlJDZDR1SjZjcXk3RnJHVzl6VlhPWmRld2lDTUNC?=
 =?utf-8?B?ZHNGUWZIVE1LRFY4QWtyK2I0dUNBU3JCVEYraUJHNlNFaldOZHRDVlZNaFFq?=
 =?utf-8?Q?yr3WcP5HIQkQV6lc6H/+BlAg7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CAF8A31D179DF4CAC33BE95960872C8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3485532b-fa1e-424c-67f0-08da964b160c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 12:17:26.2659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xNBjsgYmcI1vAyWmEC3fvHxpn8FUFIWEZdW9qgKYQMHbJAv1LKgBy/+RnXZJyC/EPqeDb9AKqyF8MyMir5UojPZtbw9B2Jv5sZFQuIWsdLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4880
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQuMDkuMjAyMiAxNDowMSwgSWxwbyBKw6RydmluZW4gd3JvdGU6DQo+IE9uIFR1ZSwgMTMg
U2VwIDIwMjIsIFNlcmdpdSBNb2dhIHdyb3RlOg0KPiANCj4+IE1ha2Ugc3VyZSB0aGF0IHRoZSBk
cml2ZXIgb25seSBkaXZpZGVzIHRoZSBjbG9jayBkaXZpc29yIGlmIHRoZQ0KPj4gSVAgaGFuZGxl
ZCBhdCB0aGF0IHBvaW50IGlzIFVTQVJULCBzaW5jZSBVQVJUIElQJ3MgZG8gbm90IHN1cHBvcnQN
Cj4+IGltcGxpY2l0IHBlcmlwaGVyYWwgY2xvY2sgZGl2aXNpb24uIEluc3RlYWQsIGluIHRoZSBj
YXNlIG9mIFVBUlQsDQo+PiBnbyB3aXRoIHRoZSBoaWdoZXN0IHBvc3NpYmxlIGNsb2NrIGRpdmlz
b3IuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogU2VyZ2l1IE1vZ2EgPHNlcmdpdS5tb2dhQG1pY3Jv
Y2hpcC5jb20+DQo+PiAtLS0NCj4+DQo+Pg0KPj4gdjEgLT4gdjI6DQo+PiAtIE5vdGhpbmcsIHRo
aXMgcGF0Y2ggd2FzIG5vdCBoZXJlIGJlZm9yZSBhbmQgaXMgbWFpbmx5IG1lYW50IGFzIGJvdGgg
Y2xlYW51cA0KPj4gYW5kIGFzIGEgd2F5IHRvIGludHJvZHVjZSBhIG5ldyBmaWVsZCBpbnRvIHN0
cnVjdCBhdG1lbF91YXJ0X3BvcnQgdGhhdCB3aWxsIGJlDQo+PiB1c2VkIGJ5IHRoZSBsYXN0IHBh
dGNoIHRvIGRpZmVyZW50aWF0ZSBiZXR3ZWVuIFVTQVJUIGFuZCBVQVJUIHJlZ2FyZGluZyB0aGUN
Cj4+IGxvY2F0aW9uIG9mIHRoZSBCYXVkcmF0ZSBDbG9jayBTb3VyY2UgYml0bWFzay4NCj4+DQo+
Pg0KPj4NCj4+IHYyIC0+IHYzOg0KPj4gLSBVc2UgQVRNRUxfVVNfQ0QgaW5zdGVhZCBvZiA2NTUz
NQ0KPj4gLSBQcmV2aW91c2x5IFtQQVRDSCAxMF0NCj4gDQo+IA0KPj4gQEAgLTIyODMsMTAgKzIy
ODcsMjEgQEAgc3RhdGljIHZvaWQgYXRtZWxfc2V0X3Rlcm1pb3Moc3RydWN0IHVhcnRfcG9ydCAq
cG9ydCwNCj4+ICAgICAgICAgICAgICAgIGNkID0gdWFydF9nZXRfZGl2aXNvcihwb3J0LCBiYXVk
KTsNCj4+ICAgICAgICB9DQo+Pg0KPj4gLSAgICAgaWYgKGNkID4gNjU1MzUpIHsgICAgICAgLyog
QlJHUiBpcyAxNi1iaXQsIHNvIHN3aXRjaCB0byBzbG93ZXIgY2xvY2sgKi8NCj4+ICsgICAgIC8q
DQo+PiArICAgICAgKiBJZiB0aGUgY3VycmVudCB2YWx1ZSBvZiB0aGUgQ2xvY2sgRGl2aXNvciBz
dXJwYXNzZXMgdGhlIDE2IGJpdA0KPj4gKyAgICAgICogQVRNRUxfVVNfQ0QgbWFzayBhbmQgdGhl
IElQIGlzIFVTQVJULCBzd2l0Y2ggdG8gdGhlIFBlcmlwaGVyYWwNCj4+ICsgICAgICAqIENsb2Nr
IGltcGxpY2l0bHkgZGl2aWRlZCBieSA4Lg0KPj4gKyAgICAgICogSWYgdGhlIElQIGlzIFVBUlQg
aG93ZXZlciwga2VlcCB0aGUgaGlnaGVzdCBwb3NzaWJsZSB2YWx1ZSBmb3INCj4+ICsgICAgICAq
IHRoZSBDRCBhbmQgYXZvaWQgbmVlZGxlc3MgZGl2aXNpb24gb2YgQ0QsIHNpbmNlIFVBUlQgSVAn
cyBkbyBub3QNCj4+ICsgICAgICAqIHN1cHBvcnQgaW1wbGljaXQgZGl2aXNpb24gb2YgdGhlIFBl
cmlwaGVyYWwgQ2xvY2suDQo+PiArICAgICAgKi8NCj4+ICsgICAgIGlmIChhdG1lbF9wb3J0LT5p
c191c2FydCAmJiBjZCA+IEFUTUVMX1VTX0NEKSB7DQo+PiAgICAgICAgICAgICAgICBjZCAvPSA4
Ow0KPj4gICAgICAgICAgICAgICAgbW9kZSB8PSBBVE1FTF9VU19VU0NMS1NfTUNLX0RJVjg7DQo+
PiArICAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgICAgICBjZCAmPSBBVE1FTF9VU19DRDsNCj4g
DQo+IE5vdyB0aGF0IEkgcmVhZCB0aGUgYWJvdmUgY29tbWVudCB3aXRoIG1vcmUgdGhvdWdodCwg
d291bGQ6DQo+ICAgICAgICAgICAgICAgICAgY2QgPSBtaW4oY2QsIEFUTUVMX1VTX0NEKTsNCj4g
YmUgbW9yZSBhcHByb3ByaWF0ZSBoZXJlIGlmICJ0aGUgaGlnaGVzdCBwb3NzaWJsZSB2YWx1ZSIg
aXMgc291Z2h0IGZvcj8NCj4gDQo+IA0KPiAtLQ0KPiAgIGkuDQo+IA0KDQoNCg0KWWVzLCB5b3Ug
YXJlIHJpZ2h0LCB0aGF0IHdvdWxkIGFjdHVhbGx5IGJlIHRoZSBjb3JyZWN0IG9wZXJhdGlvbi4g
SSANCnNvbWVob3cgb25seSB0aG91Z2h0IG9mIGZyZXF1ZW5jaWVzIGxvd2VyIHRoYW4gQVRNRUxf
VVNfQ0Qgd2hlbiB3cml0aW5nIA0KdGhhdCBvcGVyYXRpb24sIGFsdGhvdWdoIHRoZSBjb21tZW50
YXJ5IGRvZXMgc2F5IG15IGludGVudGlvbi4gVGhhbmtzIDopLg0KDQoNClJlZ2FyZHMsDQoJU2Vy
Z2l1DQo=
