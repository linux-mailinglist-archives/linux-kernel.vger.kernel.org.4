Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBED45BA7E8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiIPIPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIPIO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:14:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7E424949;
        Fri, 16 Sep 2022 01:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663316095; x=1694852095;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NKGB1kKFhtM1KYNvc1rl3QLI3DQfw9fYq2NcMfpKPeA=;
  b=dPC8xqOVRhWFnsk0uovFfRwF7ZOzdId3stkHvIKMysBe4rnUnDz7+OgN
   zbQ1QIzkYVtlxVbTf9W+pgjJmw5NbdCSL2QjH+U3HKbAO16bJ6CERh6in
   RyrNvaXgKJ/UbQDmefNxUzPFHMjoZoerhi57vSGqhJuMsW8qgaT4sJ54Q
   nimGhefP2gYrCIU8J/ikAsVDuTXT8MMrAGCg0rzJIk0u+TNOA6CwZKz6Q
   hfirtDjUhCGioqBNKMxaHhryo5leu0dTNLAyKO5o5JwIUDDX8BfCWfnqT
   JuxfdlyNG2MWWiIl5aFaqW6Iwt6+CbpVUXI49noWM+Uw/CXmcZv17wAdh
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="113979023"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2022 01:14:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 16 Sep 2022 01:14:54 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 16 Sep 2022 01:14:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZTqgEuUM7d2Fx0jDnzKIBLZql/YI0Qw/nScx63SxMRMitfiKaR5/lRC2sYCjZiEU5zk8ideiaN+J6ZfgdD9JJeW1nu7xN4fYC8+QZGaqNeKQSj8HA+1/BG51I9xeE4RnL66LIdS7XqIDmdECD6NWPloJcAm6nMlb0sx5iF59tNokAT8mnNNwa/wYP0OjTV0Si/F8LROfRg2/huVhUl+8Wo0FOxnS9g+ENnWTqkvk5K5B9MJKjMQpLMi/6igC58AFLSJWK0JGAdakcvVHWpvTnabIt7GY9z8/gQLI5LbIuMhYcT2XljchbpssiABjtAFSWiJYB0ZWeP8UNSR5C2P1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKGB1kKFhtM1KYNvc1rl3QLI3DQfw9fYq2NcMfpKPeA=;
 b=a2KDZHDKMIPYUgT4a2yKHu91DLAK+af4iFSpwo0NH6XvGWgTcLwBx+zfHEyT9SjRLp1hH4ZocG7jwcB/LKS5mZmDgr4GO3sjpqcbwVfkcKXyYQ8F/rD+GzhCwJ0NdXL0cnLiS2bRWZQoWbnQ90VMJbhA3jLL3ye0x79ic0v+C+NBAs9Cu7oDOSY12CnmvFNEXW7IgRgW3ESLHIMQ/M7TXrDIsZ3kxL2fHhdamxngGkEvcSlKFyzXrhKVqYnqquopOWFu25vtf+xo9fhdwDzFId+0flQUUpuK4Bml+ZiH+OYnbLMSS7Du6WqhTvR5rerV02DdmQkGIEaPHTVGLieA4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKGB1kKFhtM1KYNvc1rl3QLI3DQfw9fYq2NcMfpKPeA=;
 b=HbQ4tT1eSWlVud+8nDszrjGOc57qiwbXDQrEBbgQhsVEid5PpldWsOsrsfY075UCWoffSrW6Xikig80oRVC52q9yqPp059TkDdDc6O8BQ3mh0k0G8BtMzDLT8Cp8w9Y+wLRsBaKwxQdMgzQQnlM8EZ002R4uh4ynrgy7owVkpk0=
Received: from CY4PR11MB1960.namprd11.prod.outlook.com (2603:10b6:903:11d::21)
 by BL1PR11MB6052.namprd11.prod.outlook.com (2603:10b6:208:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 08:14:49 +0000
Received: from CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::25b7:6f88:f38c:a675]) by CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::25b7:6f88:f38c:a675%4]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 08:14:49 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Sergiu.Moga@microchip.com>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Tudor.Ambarus@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v3 02/14] ARM: dts: at91: sam9x60ek: Add DBGU compatibles
 to uart1
Thread-Topic: [PATCH v3 02/14] ARM: dts: at91: sam9x60ek: Add DBGU compatibles
 to uart1
Thread-Index: AQHYyaRjNGTaRzU0W0qe7nue49AB3A==
Date:   Fri, 16 Sep 2022 08:14:49 +0000
Message-ID: <53e72e5d-47fc-403d-c969-61b267a9ff15@microchip.com>
References: <20220913142205.162399-1-sergiu.moga@microchip.com>
 <20220913142205.162399-3-sergiu.moga@microchip.com>
In-Reply-To: <20220913142205.162399-3-sergiu.moga@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB1960:EE_|BL1PR11MB6052:EE_
x-ms-office365-filtering-correlation-id: 62f6d067-a41c-42d3-2622-08da97bb8637
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AneF4nDue1Gj68H9alehwRtb5gW52F/KuNfgFBYcpofWx5Rv5L/8uiGoaNEeFgLJaWf4V2lzhe0oZF+z7JDWFRNjgBLaOk+V/TDnIGZ9wEy/yDUB0qAzO3V2uykeOl32b+ixe01XC2wZJ/ZYu2y3zZ+FKrXDmqJqFQfWMR1NQ+gYYdsmYoprmTiW+HPhioWhJPQI0v+3aVAm6pH95wOuBdvetNoiu4eFnjZ3Je+QhwSln2xow+L10idS8NGRVaJn2Qy+iWsH441dKO9DJz260IK/A5z+idrQpKAOZzV/rCEatwDrxrLFsqgQinGxYZNgCG+Uf4bdRV35+bF/wPHY7JSXXF1Em5nG9zWd46z0LKtqIOfernw5exEasJ7u50ZyH9OqTDoaxbWP/CnvSzM/TmNwAUWK3vnUP715ZNivyk25osvWAx/vNJ+SdQMbAQ4C3jETR0GdLxN1KKs04uuSpSxUxFQEdE0lW0/6H7qU3VZWlRq4POyZ8sPEO4hJEAUJMXLKUrVpccVM3vlJnfEKApsaHkcj56CPcnsibgBxNkEZaSDpFu6QbTks9TpsKPpMFrhSKb1qurFoX91umlRBt4ZHgESiT72oX7xg4cWpl+AgL9CDVCIWERPB82Jh6x7t59Sw2TbZuW5TstPP1/mOYEkmCLTDngaVQuPukVyYY1BUaCLfpA83GKImX+76brgCS14J5OODzv3ix/f2pqJyOPK9bFbPImQ6j8OlWOU6eVg7GazdziL2AXRsDYO6Mc+Vz8bKv8iKOvLTN/RwI/x/FbJWuYA8eQXDRMEqBZFUck4Dt91x41dz9IC+pXHKBQcDWB/QZYJyW8Gb9UfbGzSOeHG8oLqW/iP9wSI59EHh8jI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1960.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(66476007)(7416002)(71200400001)(66446008)(41300700001)(316002)(66556008)(26005)(122000001)(31686004)(110136005)(66946007)(4326008)(76116006)(91956017)(31696002)(5660300002)(86362001)(8936002)(54906003)(36756003)(8676002)(2906002)(6506007)(478600001)(921005)(186003)(64756008)(38100700002)(2616005)(83380400001)(6636002)(6486002)(38070700005)(6512007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1RoVHg5UjlZeEtXdzB6WFJ0TDZJQW8rVnI3ODFuekJSSlY3OExtR2hOQnVr?=
 =?utf-8?B?QXg1TUhGTHJIOHBkZWVXWHptSmowa1pwU01Bck9DcUZQVkNKMll5cU14WEJY?=
 =?utf-8?B?MitFNVFPVCtxaEhUckhlRzZYVExwQ0hCbVVBS2ViOGdhcmhRaVJwak0wSUVQ?=
 =?utf-8?B?eGZVUERDRDhUazh3dkcyWkdZcE1UeHlzVDhYZER6RU8wMEY3cVNZOHJuTEpI?=
 =?utf-8?B?ZVJQQldGVFQ2VWRWVm41M2F3QnlscU1UdkdLVnFSMlpCamFHQzZuNDBDS1BH?=
 =?utf-8?B?eU9qOUVESHFnSkJrOUFESEhNVWZoNXFFU2hBMHBnS1VKL25TRCtqMmZJWkIz?=
 =?utf-8?B?R3p6VC9TZlJHU3E1TEV5V0JjcFlrOHVRNERhUTBYSStONzNRWTFpbTR1Nk4r?=
 =?utf-8?B?RDMvSXJTbDBmQUpYaHZ6L0QrUTlWekIrcTJLVmJHS0tBT01mcGdmWW1IbTZt?=
 =?utf-8?B?c2xscGhFem9XOW9BYW9wVFZ3QnJSRjFtRUxyZEsyNU1lOHNJQnNtTlFhajg1?=
 =?utf-8?B?NVJFclgwRnhpOU43NWdqZDFlQ2RhNUlLeHZqSXZTbHhqTlZxL1VUeC9tUktY?=
 =?utf-8?B?ZUhLWWsvOU1QR0ZheTBGd3dpak5WSGM1UTB2TGRHRzlYWC82Ny9aNDlBb0dF?=
 =?utf-8?B?RDJoYlAyWng3QWtxcDhxeGtFYVBhc1Z6WHNWbnY5akx3YUFHb2VyTGpBRlI3?=
 =?utf-8?B?MUQ5RER0SzRYSHlNa2s1NDFqSm9uRUdLK1BWNHdLbENqVmVvcDd2OS85QnhY?=
 =?utf-8?B?MUFPWVNHUVV5LzUyUFU0RUFQaUFmYjNKMWNjaC9XeC9tTUFqRzgvZnoxeTNq?=
 =?utf-8?B?YzJTWDdaclZnRmVYdTRlaG03aVNiWHFDV20xRytyM3E0ZzNpN2lsZlRpTWJl?=
 =?utf-8?B?MHhtR3ZSSDUzdXFDS3F4MjM0TEk3RUZWOFJhdmJMeHE4eCtnWUxNSGpGOHpV?=
 =?utf-8?B?MmJFdnJJdStNUFpERHVSUEx2TVdyMVVTWDkyN0pHVlFhU0lUejZKNENNcGdJ?=
 =?utf-8?B?YzcwOVk3cjBxSTlrOGM4SHhERUFXQWJsUmZ2aXRmNjZrWk5LMDMxVW5vVm1o?=
 =?utf-8?B?cUQxbnYxLzVmWUNIbWM0QXdaVEQvMEhjSnpTQ0orYkx2cG5sYTB3bElndlI4?=
 =?utf-8?B?Vi9UU3Z0Y2JjSG9aaFpJaTZ3NXVRdzJFakRXNTlRN1BQUDBmdXc1QlNpMnZH?=
 =?utf-8?B?bnFwSXpHUUlpV3lpVzRpZXA3elNWSmxXQXllRHRDeVYwMU01V3JSeXFkNWo0?=
 =?utf-8?B?QzFUVzA5QWcxTG5CbXJ2WEJWQ01Nd2tobnN5Q20wUkppeklTVDhzbXR1QnRP?=
 =?utf-8?B?YjBTM0x0Z09zUitrUkRBcUJucE5OSjFKeXRrV0MwQU9wbG1mcDJiN0hPN1I1?=
 =?utf-8?B?SmI2Mjhud0RwUE96TlVGa1g1ejJ6UzhXVVc3SmNITnBBeUVZbHJrTU8zRXFk?=
 =?utf-8?B?Z0dkb1lGbVBrNUV2Y3lBWk9FeHRtNElEN3o2OW1WZTV4MndxNk40OHJrMDZK?=
 =?utf-8?B?YTFYclA1ZGhpYmIzSVZOMjBuVndtOWR0L1RCMUtCa0pDUGp5c3VhK0x4cTNq?=
 =?utf-8?B?TG1DeDNhMHNxRVlqZ3M0cXFDQkRpR2pvVGRxazg3Ti9jcURSa1V0K1VnVGpx?=
 =?utf-8?B?d3c2Q3NUTzJxOFJSdEc2Ty90NFpSWStyS3dkZEYrZy9LVTNKZ2w4WndjSi9q?=
 =?utf-8?B?d0lxcnRINS9jM1BqWXV6OGI5Qit0RHZQWWZ4M2JRaTlYY2pLMVRranlieGtG?=
 =?utf-8?B?Z1VKdFAwWlYxOWp3WE0zc056VXJhTGVxSE85ajFDWVlyM2FxcTl2Q2VtVnBU?=
 =?utf-8?B?dW5NcDBhWEhjTGl0UkRWN2pkMGN1RFlCR1VFc0I1UEJMbjl0bnFzalVnUEdt?=
 =?utf-8?B?L3FIekN6RGdDcE00MjlZcVFPWnpQN01GTEVUa0R5SWpCUzNWbHd3MDZyd1N4?=
 =?utf-8?B?NzFiaGI1b1drREMzY0hYY1dEWjBKOVVMcVFqUnZoaUFjYjNoZEUxYkw5Y2FU?=
 =?utf-8?B?U3FjenZnNldrKzM3UWsvcnprRi9JYTdleWhsNUJsVDU2dWJSSVBpNWNRRlpP?=
 =?utf-8?B?ejNTdk14d0Y1b0V1NWRFMFdRazl3N0I2aXNVa1c1MDYrVG1acnFrR1dVUVhu?=
 =?utf-8?B?ZUVEK1NkaDV4UlZDZTVBTFlnT3JzRFNWTkdLQXNKdzE5bkpQcitsUGdvb0hI?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CEA7EAC26FCC44D8F68CEF0C890A8DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1960.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f6d067-a41c-42d3-2622-08da97bb8637
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 08:14:49.2161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pnrPVJgNIxIPfZHLfumcbuaPUUg/IMfwI4pDQQ0KNr7vs44uPOOwJP5OPdjvkfIRGytypRyPdz3nygobmiP6MrKQ+DVLvu/fL5paDhU7gQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6052
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMuMDkuMjAyMiAxNzoyMSwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+IE1haW50YWluIGNvbnNp
c3RlbmN5IGFtb25nIHRoZSBjb21wYXRpYmxlcyBvZiB0aGUgc2VyaWFsIG5vZGVzIG9mDQo+IHNh
bTl4NjBlayBhbmQgaGlnaGxpZ2h0IHRoZSBpbmNyZW1lbnRhbCBjaGFyYWN0ZXJpc3RpYyBvZiBp
dHMgc2VyaWFsDQo+IElQJ3MgYnkgbWFraW5nIHN1cmUgdGhhdCBhbGwgc2VyaWFsIG5vZGVzIGNv
bnRhaW4gYm90aCB0aGUgc2FtOXg2MA0KPiBhbmQgc2FtOTI2MCB1c2FydC9kYmd1IGNvbXBhdGli
bGVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2VyZ2l1IE1vZ2EgPHNlcmdpdS5tb2dhQG1pY3Jv
Y2hpcC5jb20+DQoNCkFwcGxpZWQgdG8gYXQ5MS1kdCwgdGhhbmtzIQ0KDQo+IC0tLQ0KPiANCj4g
DQo+IHYxIC0+IHYyOg0KPiAtIE5vdGhpbmcsIHRoaXMgcGF0Y2ggd2FzIG5vdCBoZXJlIGJlZm9y
ZQ0KPiANCj4gDQo+IHYyIC0+IHYzOg0KPiAtIE5vdGhpbmcsIHByZXZpb3VzbHkgdGhpcyB3YXMg
W1BBVENIIDRdDQo+IA0KPiANCj4gDQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBl
ay5kdHMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBl
ay5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMNCj4gaW5kZXggN2Fk
ZTk5NzllMWM2Li42N2JjZThkNjA5MDggMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRz
L2F0OTEtc2FtOXg2MGVrLmR0cw0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4
NjBlay5kdHMNCj4gQEAgLTI1OCw3ICsyNTgsNyBAQCAmZmx4NSB7DQo+ICAJc3RhdHVzID0gIm9r
YXkiOw0KPiAgDQo+ICAJdWFydDE6IHNlcmlhbEAyMDAgew0KPiAtCQljb21wYXRpYmxlID0gIm1p
Y3JvY2hpcCxzYW05eDYwLXVzYXJ0IiwgImF0bWVsLGF0OTFzYW05MjYwLXVzYXJ0IjsNCj4gKwkJ
Y29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC1kYmd1IiwgIm1pY3JvY2hpcCxzYW05eDYw
LXVzYXJ0IiwgImF0bWVsLGF0OTFzYW05MjYwLWRiZ3UiLCAiYXRtZWwsYXQ5MXNhbTkyNjAtdXNh
cnQiOw0KPiAgCQlyZWcgPSA8MHgyMDAgMHgyMDA+Ow0KPiAgCQlpbnRlcnJ1cHRzID0gPDE0IElS
UV9UWVBFX0xFVkVMX0hJR0ggNz47DQo+ICAJCWRtYXMgPSA8JmRtYTANCg0K
