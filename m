Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2467745814
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjGCJJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjGCJI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:08:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1E212C;
        Mon,  3 Jul 2023 02:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688375337; x=1719911337;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bDHmgvwocRYuO5Xt22pVL0jHfunaM168qnAwfhbH0sk=;
  b=tDu+/afLP5IK8mJW6igdEIP/k4pI4tdn66FjStm5M4Yd0TaR0j0J4B9e
   Q9IZ2OPwzujv6ydGyxlguU3AhKw/A9aZpoWAT1mT6tY0ttDwHPwmECJYH
   OPvjnMwBuXXWL3PLDy7WvlQOZe9UvI8Wf2zGp4AHlZbh8Ru0IPiDONGXW
   ckk17pSsHLFbiWndsm5+DqrIVSQ7kjMauuutV3Ym9WXIxk87MpGjapOkw
   xnF0wW/YUxINDZ5V2M1Iza0KHyEunNT49zREEmCSjp3oVAYoSDySsU5AT
   pp4lz4e178yCs66MQVzNSvUufSRANmMLbJNIDQ2LyDMUhfwxNwzU0if0/
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="221026331"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2023 02:08:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Jul 2023 02:08:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Jul 2023 02:08:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLQgVVH2YB4vWEjKNbbjVgf90TOlpI1tGz5pcqWvEVnHNT/CyaHYz43gt+dJjYd+d+ZDDXxFOplfbHtWkG70Fz/S8S/6BVV7B0qxlm9u87BnoVGwlJL5z1SADeuUtmnAyhvjiOJ0PKq2vM0p3YpjFPwtI3ixFMUSGGQ+xKe8TBZAoLnFxDh5ktlC7nOoYSrIwFbRPVaOonQXQ0CgG2PFoCqcIquSrTcdbPrKVo5uYruvOvQFr+kuL+BgKtyVEMqtKMbrAt+2Bauja1ret93kzaBujBCXwohNO8LxFEngHAtaLKsJWfXytyokxzUG9yvs7W6WrC9E7BHHwk1+DA65Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDHmgvwocRYuO5Xt22pVL0jHfunaM168qnAwfhbH0sk=;
 b=nQlSS8uQtOVlT1tKfZzwiHIp3Ez7iX33KhxlE10lNFqOY894+4EZuwl9pRU5G7swRelP8vvItESogvk0Tpo69gwz5onGCsyW42gIs76waMgXhemcRVklvv+S0aR+vrf48jq6htzHtfsGcMRGzrrkIBTcchgk6g2M+HuSPacJI9gwRFkx4swUz1BfzYrz52kKyGpYhCu/5t7+2suBf+TjCry4R0upmMZa5Khl7Tr9Jtp7lM2e0W8hPRhQFvlsAdds3hQ3PfWyyB7Ir1V5Bl/XOIitTr3C+PZM41ZYLQWXYpPXwjJtAiFfeUPTXRCF0C02ekbPcA/l04dIFzCtesvJNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDHmgvwocRYuO5Xt22pVL0jHfunaM168qnAwfhbH0sk=;
 b=aIqwHUHUURN5Kp4zqSC7+csi73Gwdz6iPOak+zUC/Dftp/N8egEZ3j/IvQLWurJZbvLTdgLFABxjHtIPN9sHZuEQtJOVTOFfhZiaYrRLv/k4lZfF9ZRuvkumOOdaScIRHrjON7hltfcvDtvRc60A6Vv/mZWOgZ97BHKIwm7ENVs=
Received: from SJ1PR11MB6084.namprd11.prod.outlook.com (2603:10b6:a03:489::13)
 by CY8PR11MB7266.namprd11.prod.outlook.com (2603:10b6:930:99::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 09:08:55 +0000
Received: from SJ1PR11MB6084.namprd11.prod.outlook.com
 ([fe80::b46a:9f6b:4413:7dd1]) by SJ1PR11MB6084.namprd11.prod.outlook.com
 ([fe80::b46a:9f6b:4413:7dd1%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 09:08:54 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Markus.Elfring@web.de>, <alif.zakuan.yuslaimi@intel.com>,
        <kah.jing.lee@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <catalin.marinas@arm.com>, <conor+dt@kernel.org>,
        <dinguyen@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <will@kernel.org>
Subject: Re: [PATCH v4] arm64: dts: agilex/stratix10: Updated QSPI Flash
 layout for UBIFS
Thread-Topic: [PATCH v4] arm64: dts: agilex/stratix10: Updated QSPI Flash
 layout for UBIFS
Thread-Index: AQHZrYmyZZ/3eUCnZkOsa6+AfNaEk6+nvpYAgAACMAA=
Date:   Mon, 3 Jul 2023 09:08:54 +0000
Message-ID: <a786b6b9-3923-0138-5738-dc20e14aa0f3@microchip.com>
References: <20230703083626.1347969-1-kah.jing.lee@intel.com>
 <59da2f49-706f-0a08-df14-71ad0326da83@web.de>
In-Reply-To: <59da2f49-706f-0a08-df14-71ad0326da83@web.de>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6084:EE_|CY8PR11MB7266:EE_
x-ms-office365-filtering-correlation-id: 434c7200-091d-4c88-d936-08db7ba52011
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SujxJ01i+fnIhYynupHbEWpPvhPOqXza6FdgeeTk5Ud+QhPXFGBuXiuldvKO4I8t8RvrK0wmW+KAQDh/HYfoACcOcDzWbuQUtbn0A9SYoVZmkxNCMI/wmrPo2i/loV32cE4HrQw3L++FkpQw9Aov6oxvbkDa3cKcWu2KZ60qke8ZbvSvMA0SrX9mHPzpW+Ppo1PHxfBWFYqSee85TPPXNMK8rOhmC2cqgmSSJ1e4bm8FUPBzSJZ5tcn4OG+JzmgrRUwIgBBEl7FHQz2MNvcURQyVBQy3K58RY9LWWoTzvnTzv1hiGnhJRjt8ilWlHKuZAak207oHNL2YdD5po/tityTJ6uwnplzsWA2rCl0BhYJIlyF7f7VAxka8934RgbuhmP59vXHAA67tAgQv2F+W1lF8vu8b1Ic5/tMukDIXwxv7P9s9bBjwAD/Lpy7jK6LnNjo7qiju5BXfL9b6+vjgid8GocmzY0YY5583TP5VQXE8sgkVEvWdKNYZk/p7jaxe0VQ9ySKbCBWO7ftOOBy7wUgk2feRra15OQJCoyNSViSCyJVIftReuDgOIVX5yD+9xo7QknEVON4E//ceAOJx+0H2vRqgOll6klAKS5kWf1Q3JUiz9lFIJypm3bFtmMcKz7z8O2dhDlyup2lFbL8KjQvOotAmaDC3oKVld/FADFlfiDvMsfcVTDuTIyXLGLtF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6084.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(6512007)(91956017)(6506007)(53546011)(66556008)(316002)(66446008)(38070700005)(76116006)(64756008)(66476007)(66946007)(38100700002)(122000001)(4326008)(2616005)(83380400001)(186003)(26005)(478600001)(110136005)(54906003)(8936002)(8676002)(31686004)(2906002)(5660300002)(6486002)(71200400001)(31696002)(7416002)(86362001)(4744005)(41300700001)(36756003)(15650500001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUtIeGZ3K1lOR2grTElIQ2NHRDFtZ3RiOWJmcnFEV3NodHlRUDJDQ2JMMGts?=
 =?utf-8?B?aWUrMUxHenZpY2JUZG9Gd01UU1VubVVrQUxQM3ZFM2JPc09Hc1dBNUozUnlL?=
 =?utf-8?B?ZmxSNmdXcU85V2NnNkh0QWZKZjBVR1dxSkV6Zjk2NkdNVy9yY2dnUmlDZDZy?=
 =?utf-8?B?ZUtrdG9kQ3B5cnk3a2Y2bUVVMFdUMmV3R0F5SGlxcFExOEJBY0NDbWEzRTNE?=
 =?utf-8?B?ZU5sMkNCcVl0UEIvSkFacWlRZDNDMll2cUkzS0xjNVVKd2hQaVkwRS8vVjNJ?=
 =?utf-8?B?N2hFSUVaQndhY3ZPc2J5QkNEQ3NSUWlrK0FiZGprV1NLSndMc2pKSmdTWWJo?=
 =?utf-8?B?RW9yaWhlVHhJb2lVSDFwSFJIUUYwRThYbTN2QmpqTFFXYVVwMUYvME9walI0?=
 =?utf-8?B?TitJQ0FzMzN2bEg3TlZUekdHYUNLTmhGdFJ4VlpZcU1SV3V6bmd4TXI4QTFx?=
 =?utf-8?B?UVVPejZ1dWJ0WEV5OHVzUlp6eUEwaFFSWllLellLNko2WFY2NnJzMklBcXhH?=
 =?utf-8?B?a3NmOHBCZ0FFRlV4b0VYTnVlbGRVcHlKT3BqVGVPdkRwOW1MR2ZUWnRkTm1J?=
 =?utf-8?B?bWtJSThkeExYWjB0N29SOXp1elJWbWVybkJ5UUdadzJqOTRsQjFqN2RjcTNR?=
 =?utf-8?B?d3lxNjE5UkZmS3htNVI4emMrdFlQbFpYWE9vc09CeWJRalEreEszWmxwd1Vu?=
 =?utf-8?B?K0haMEVpVEcxUkJjSGlYeU5NRHVXVjNHa2NaYmZWaVdqcG9idWxBdEVNdXpY?=
 =?utf-8?B?cUtIVU9FL3hCR3IzcDZPMFkwZ3dwYnovOXBLeXBzWFVTMVhaVTJBa29VSWFu?=
 =?utf-8?B?bTEwVVNOVTY5LzBxYnNkakJyR3libHNRTmdFTCszc3Jtd1BoNk1KeUlPRzN5?=
 =?utf-8?B?RHEwTis0MGZKUzVpTHFzQnA5a2lmY0dxemhjS1dVd3pqbUNoVEt0NXdZVWNL?=
 =?utf-8?B?aUZhRngzSjFRdHRXNktyN2RZbWpZSHI4TEUxUUVMRE1CVlBCSWFwOGlVVjZi?=
 =?utf-8?B?M0R3QnpQN3dhaWYxa2JqdlpEN1J6TnNhTlBzeTJPa2lmOFNjbDZESXVYZHlH?=
 =?utf-8?B?S3ppdXcwd01TMTBUUURmR0pzYUdvOWxSMzk4bVA3d3RZZFEvTUhkV1A0Vllx?=
 =?utf-8?B?RzlQTHpUdGJDcVozdGYwNUUzOTl5WUdrT0ZUUmpKc1RFUWx0K0taNGY0MGZ1?=
 =?utf-8?B?bndIRFpZN0dWSWhtd3FRd3EwVWMrcngvTVdTbDUvMEdTL1hyS1RtbDZpc01J?=
 =?utf-8?B?QndEMDQ1eHZpUTdadHg5MVd5N1lWcU5oNmRzOHU2a2txMWFXMTU1MDJYNVNG?=
 =?utf-8?B?UlJLZWhDNTlHVlg4ZGlUS0hwWU1tOGlYMjI0OHlCREFaU3NzQ09zTTFoYTVR?=
 =?utf-8?B?eWx5OEM2OEdwUWpTbkd6NUZQQ2lNenZRZ2FpSEFPUDRlZzlocDRVWk1aVXFP?=
 =?utf-8?B?UXk0VG1neWdCS0JzcG83R3NlaXViaElGT0Q1M0VjWG9TU2UyY0dGbjBzVHZs?=
 =?utf-8?B?V21YZU4wY1RrbWEyaVNGRGNVQ2hqNVNuc1ZYWXdxZ3pnRnFoTDJUY3lONkw0?=
 =?utf-8?B?QlBWcVJYTVU4a3RTbHNOdGx4clZsVSsyTTZXZFlLNFVtRjZmRmdWZzA1dDV4?=
 =?utf-8?B?ZHdrTE9VODc0RER1RTA1YkVPM1QwZmt0djNmaU8vT3BvS3FkTFpmbTdTN3hX?=
 =?utf-8?B?dDNibFVkc09jM0lSRzI3N05LYWp5bllrT3duTzVBZDlnWEVCOGU3Nk1XdmtF?=
 =?utf-8?B?b3JBTlBYajJGNmlvR0FCSTUzUXlsbTJSbENUZ2xKVGJHeGJkYWJ4WFRabDI1?=
 =?utf-8?B?Skp3UFM2VDRXVnNMYWJwdi9EL052R1BHZVMvdHNDbDZNS3dlaUh2NWh2dnhy?=
 =?utf-8?B?dXYvVGF2RytsaklUS3VXVVlJTlA1akxiVWFHZmJOSzJXNTBOMExqNTAzSm1M?=
 =?utf-8?B?L0NmYzI3TkF1SGJQdWhvWTc1Rkx2cWpHdVV5V0ZGakhNVm1aVWRzMnRRRktt?=
 =?utf-8?B?RzJVclhBKzZJWldxWkF6S2ZqdTZkMmJnUXRhSE12MCtyMEx5VmdPeDNqSGZ1?=
 =?utf-8?B?NVdsWXZVVnQzT1BtQWp0Y0lhc2ZTcjBNMjBkMXNWbWpqT2NybkVlVjVMYnVM?=
 =?utf-8?Q?E2w6JP81H5JIQ22o5ZhXEsYBj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A002C0F5358BB40AC91DCA3F0B6E2C3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6084.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434c7200-091d-4c88-d936-08db7ba52011
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 09:08:54.0787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M5m3OTj62p5Ht4+ywINbUmd7VLYW5o76uecbJO+0jKcR+4j0n6yyK+yRyUwnZG3bP3RVQC20yIfvpHLGVXTOnQc/eFdu6Ydizw/gcakcnTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7266
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMvMDcvMjAyMyAxMDowMCwgTWFya3VzIEVsZnJpbmcgd3JvdGU6DQoNCj4g4oCmDQo+PiAt
LS0NCj4+IFY0LT5WMzogRHJvcCBjb3ZlciBsZXR0ZXIgJiByZW1vdmUgdW5uZWNlc3NhcnkgbWFy
a2VyIGxpbmUNCj4+IFYzLT5WMjogVXBkYXRlIGNvbW1pdCBtZXNzYWdlcw0KPiDigKYNCj4gDQo+
ICogRG8geW91IGZpbmQgdGhlIGFycm93IG5vdGF0aW9uIGhlbHBmdWwgZm9yIHRoZSB2ZXJzaW9u
IGlkZW50aWZpY2F0aW9uPw0KPiANCj4gKiBIb3cgZG8geW91IHRoaW5rIGFib3V0IHRvIGF2b2lk
IGR1cGxpY2F0ZSBkYXRhIGluIHRoZSB2ZXJzaW9uIGhpc3Rvcnk/DQo+IA0KPiAqIFdvdWxkIGFu
IG90aGVyIGxpc3Rpbmcgc3R5bGUgYmVjb21lIG5pY2VyIGZvciB0aGUg4oCccGF0Y2ggY2hhbmdl
bG9n4oCdPw0KDQpUaGlzIGlzIGEgY29tcGxldGUgd2FzdGUgb2YgY29udHJpYnV0b3IgdGltZS4g
UGxlYXNlIHN0b3AuDQo=
