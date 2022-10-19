Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52C2604635
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiJSNBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiJSNAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:00:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DE29AC28
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666183418; x=1697719418;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=du9UDdwrXXr1YE0tQegPHyHCBuiDQbobtfIWKP9z598=;
  b=jYJXENXPmXINA99zrkZoHOYtn8ql81fL+AXO81Ic2iuU/zfswpkCh3Oa
   L0A1u1bAC0qr8Peztiaix/6kguoHkVS+x2f9SWo5zHqDT+fYYgNz2lMV+
   sQowcmmTjVv4PG4PBzeAjXWKzbteqSBPwvz34gmNAnNv9ZEqP+ScPIIRC
   1MDhjYnAsnoU2Dqn2Y2F1WdxxzmHaYKLS4f+SBZ0w+wSasC+S4fQFvZeI
   ddvHhB5af1UZCDZErkgcjFp4qxBtYKWjawHoby7dyYGlwbMMyLHDXTwK2
   P4bi2uKY4NCTmeQMwqEBojvS7enwbMQPnbdsgoNb/R9l0ixobkfOm9gaB
   A==;
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="182933124"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Oct 2022 05:35:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 19 Oct 2022 05:35:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 19 Oct 2022 05:35:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cbt1j7LEOsKnBNn6jatdJ/jFMc3UHcIlJ5fUi4hWacAOuKBh82C8RsE522+oqtQvidGhmoGzyJTXTUQPGAjn2u6T8XGe3zN5oiDAN01ak7j0RzbzZ7ctfpulkvMkKr30hlNRDm/k21cFB1091UQi7pNg3BQH6DZ0eqGuDLfHRnTprONqQHAy9wAKqi3v3/UgJ9ZRxfrevYYKOMsihy37cVPkIRvdqmQoEqTd3B+/mhRne49qaMTuqPxLCtlXk/qnh+hhVLuXK1H4t56HkA4QMiRKx76ZjIWPzq6a/2YQQG+9A5IS0jSDLnRrWz2jLy2Km+w++oN7zL31KFg3uQv+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=du9UDdwrXXr1YE0tQegPHyHCBuiDQbobtfIWKP9z598=;
 b=PSRMED7VhPOI7SJLPCgYG8T4kaXmom4W0CDwH1uhtDwvPYt9K3gtgTH1pxK0J4bNGl0FGpTbSAXyYc5KViwdV7K1eA5m+aTteijBtXePADfW0cw/CP3tBWcUUkxRe690cSFE6Y/PK4vtjmxlpbM8smk8UG/4Gv7s6sSaZgRBU/15WYcoj3Y6P5QYTQJ35ZhdKPkqGX15L4wslz4Oe+2jhgf8aWUmQeLLxDibvPeDkQ3HMwaS2tmKU3qa4h6oQeQY2a539HL9IXTismMEOhMmLz5/yyRgBZYEO1QmUD3m+t3jhkvvgAaPBnfdHz/YRQlNLg+yMg8MGVzz9UQQ4UDvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=du9UDdwrXXr1YE0tQegPHyHCBuiDQbobtfIWKP9z598=;
 b=P7PqhiM46w0vdL/7PAWJWqr8Ph/NnMs6NsvaVRVTc1s7o0gJ7Bnzuyjum7RvKwZTvy5U7dj6rz4SrbypgNMT6b48+hoT3GymRDKn6sc+xTr6RxCGEjBQPjwCmryTAHup+jGJbFpT8p/0CcEPbaGaZFYRGNCpwN/htd7ReSuRT08=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 12:35:43 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::1304:e061:45a4:23e1]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::1304:e061:45a4:23e1%5]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 12:35:37 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heiko@sntech.de>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <apatel@ventanamicro.com>
CC:     <atishp@atishpatra.org>, <anup@brainfault.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <ajones@ventanamicro.com>, <lkp@intel.com>
Subject: Re: [PATCH v3 1/4] RISC-V: Fix compilation without RISCV_ISA_ZICBOM
Thread-Topic: [PATCH v3 1/4] RISC-V: Fix compilation without RISCV_ISA_ZICBOM
Thread-Index: AQHY47S/3UtRjYha3E2B2m30lp7pmK4VpdQAgAABRoA=
Date:   Wed, 19 Oct 2022 12:35:37 +0000
Message-ID: <2045deec-09a5-c696-dee1-f2c7457fbb18@microchip.com>
References: <20221019121622.179024-1-apatel@ventanamicro.com>
 <20221019121622.179024-2-apatel@ventanamicro.com> <5869751.lOV4Wx5bFT@phil>
In-Reply-To: <5869751.lOV4Wx5bFT@phil>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|PH8PR11MB7024:EE_
x-ms-office365-filtering-correlation-id: 620c3aed-d8a8-422a-151b-08dab1ce6cae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X7egvodF06ruF4siYLGca/imZF5dNAM31G8lpTSRPaSB6NuPBisrMsprH0eQkfezyivN+Ay0BS8NkRfDYzSV31Moq+Pku7cOpt4AP1WQ6OUi0XgY4cxrW45hWVvlniYMBwlkQ2YqsTvBz3Ql/sS48KeKB0t/g2vIJ2FLzFKOm9sAU6s1PN46W8/AWjHyZg63UcW47/vipl7sbdutkxRKaGC92B/SP2AuqH3MNYnNQTjZc6utKz1YZ5J1GqJaDtLzAecqCN6BUGAs0x0OPIIH6AQtXSOrw9WbjxyZcBzhNDZJ9n+2oOju1e2PfV+K2aZEfGSxImlhwfVhmvLuTJzQ3cfqTfxHz/Dcn+3wZ5wMMZy0+mo74Zl8brfqjmRq+MGpc7SEElOZqaGzlZJgeDTjdjuLhNbj/jYeIZAtHNoETsGCDRXTm2L5iHkRDAFJYdIoVdruP3cvUft0CoXNCssRCL6BgFgjSpNXek++Lfd/8kMGfyg1I3OZLLH11vlhfwK+YwwoINoceF8N5ijNsp6pgL9ya0zq2BciHbtgyTghld5uWBaNc0XN2Vm0UBBmDRw80dBtRlM6qCMEbbyLXGw+vCGG8oGuMT8mVLFyqW9aeeujcy3XLtwFMzJEdmlAevZYS/qZCqzyrmGSwoUeY9Adf91Oln9qkTGkYIqnz5dLUWYZVPemmeYqU2CIfG+7zXC+W4E+xtI6cvZ37IuWyhfNrNgAEFlQ6mtpNLG1jB2Ddq7aB8mVlowsbq2plWfbeTrxGl8nr+UJz4SFpTliZ/05s4HYAjLCIYWW12fsb33TFUpwDYK419X3RkdTPruXozb2E2LZIgvdXpjAet8HhXEOM6U+uL6Z9hYjwePtgpgWYe0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(26005)(41300700001)(6512007)(66946007)(38070700005)(478600001)(2616005)(186003)(36756003)(2906002)(6506007)(7416002)(8936002)(4326008)(5660300002)(31696002)(86362001)(53546011)(38100700002)(91956017)(110136005)(316002)(54906003)(122000001)(66446008)(966005)(71200400001)(6486002)(8676002)(64756008)(66476007)(83380400001)(66556008)(76116006)(31686004)(66899015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVd5b3RXbldpYnNiNjhDajhWc0VDc203Z3Y5ODRpdlJselp4RlpuMnZJQnQ4?=
 =?utf-8?B?Rjc2d3JzajdDV3JycDl4YXlCL09xaStiSVpNSGlCZ2dTUDlvNG5HTkRoenVw?=
 =?utf-8?B?NHVRSk5Ua0F1ZlhmRG9wVTFreWFXVnVCMlMySWN5UEZEZDFNU2NXNmpKamQx?=
 =?utf-8?B?dzh5a29XK3liQmpwbFNkY0FSTGg4MTRkZUg0NTQ2RG1iWGdNODJtTnNGRzV5?=
 =?utf-8?B?ZkNMbzNqQlVsb1VncWNEV3JzUlBLWVpyNlZTMElvdFNwd0JsQVQ3SHllTEIy?=
 =?utf-8?B?R0IzczlIRXdQd2k0NTErakxDakhuYjQ5NHZEWnJtWit5bS9rNlVUYlQzTlNp?=
 =?utf-8?B?V2VrU3VNQzJoNUE1RE9uQ3NaUmwwYTNaR3Nta1NMTDBYdzZWRjVkZENLUTlO?=
 =?utf-8?B?WTBuTjdvU3Q3a2FIc2hYeFpmNXJvakYyWGhnYVkvVUREcTdJV3Vsc0krYVl1?=
 =?utf-8?B?T0NPZWU4cHJXZlRTaSs1dVFQalNvaVhDZmZLWTBuREZDeWEzbng3REFKTHBY?=
 =?utf-8?B?UHQzczhacytTSW9oVi9DY3FEQy8yNmEwOXVrS0NleS80YU1PMW9ocE5jQ3Zm?=
 =?utf-8?B?TlVNVjV5R0pIbVVOQmphWHVzaVlTdXN0a2k4ZkJkWHB4QzhQVXRSYjVjcksr?=
 =?utf-8?B?Vjkwc3J2emE1d3dXdWcrNFJzckhmWkFYbXJXbi9jcFNiWlFlVTJzT1ZJVnBJ?=
 =?utf-8?B?WWRXYTZHL3lDcDY0Wm1UU3F0VUIrMitaVG00cmhtcUF1WjdzQWVMbHl5SUNx?=
 =?utf-8?B?QXA2emsxc1dMQWNyMzBBeTZ4MmZnc0hqVWhJSExBbkt0UlNRbkpRdm1TeUR3?=
 =?utf-8?B?M2dHSkpzOGVzUEtvakt1bVpTK0swTkdsSHRMTUpsY2Y3SnV4WVQzZ1dMWUF5?=
 =?utf-8?B?Yi9haEhIMm1uOXR0ZllaMHNubGtmWkN6VlIrM3NER3g2bjNDTFhmdTBoRWJk?=
 =?utf-8?B?SDhhUDN4ODhRZnQ3NmJDK0pqN2lDSzB3NFhHaXc3Y1NweVFHTGFyUzJGdisr?=
 =?utf-8?B?N2YreTVweks5a2dOYVNQenh0VGNlQS9TcmNTY2duY1ljd3dZaWZ6QkR4STh5?=
 =?utf-8?B?WmlDMm9IazF1NnVHQ0crclNRQTdsaHBDNHVIdGpuTVFhZDIwRm5zd3E3SEp2?=
 =?utf-8?B?L21KdmordDJKb0JuWjV4eEQwT2E5c0VVOXRRWWxpYzV4b3ZYYmxJNjdRa2E5?=
 =?utf-8?B?TVhBMExwUWRWUDJScVdEcnQxR2htc283ZFYxOGMySk1kc1pPVCtRMWp3aDlC?=
 =?utf-8?B?bW5NVWs2Z0RhRklNa1hGR1E5WjJ6akFpQlhwYWpubStMYmRwK3JDWWgwZzdE?=
 =?utf-8?B?ZkN2OXI2dUpNMUg1SGV5dnJsSzM4NUJTMTlJME1VdnFBVWhhMWRCanB5eGpi?=
 =?utf-8?B?Sm0zQ1BYbU5iOE9HSWlYUklUSEJEakFscXRIV2pKeCtLR3BKdFB2d244OUls?=
 =?utf-8?B?ZzV2NmVKZkQyb1paSjYzUjhvblBmdjk1cVN2R2J0c0JSelV6WU5kM0gySHli?=
 =?utf-8?B?U3R1SFVycnFSMTVYSTlGMVo4WUVwelNGNlJHRHNteitna21iQVU3SjBBVkJv?=
 =?utf-8?B?azhscnpLelZZSHkwNmFTaFpBK3ZNWHg0aGRtQ2h6UUZGSWRZemNoZlhUVU0r?=
 =?utf-8?B?ajFLRkxLRFRmSmRhZjlQRHVlVmE3OUMvL3JMZk5KYTI5a1dLcnE1VU1kRFBi?=
 =?utf-8?B?eXNOSUgyV0F1c2VhR2tEdE1jNjNMUUMzUWt5UTJ6RGdZcGtNUXdrRkszb1pv?=
 =?utf-8?B?c3h6WjdtMVdidU4zWU9QNlhhTDVseFhrMkpWTE82MTBXTkVhbDBxaWhlR0JY?=
 =?utf-8?B?eDZTMDVuZTU1cDFDRVlIU1lWK2dMN0NRd0t3aWhDaUg1cEhpTUlac0Z0SjFL?=
 =?utf-8?B?SVlDQ09oVGt2S20xWlp6T1BrV3ljOWwxbS9jSE8vdGtodHJ6SDgrVnh6Uk5a?=
 =?utf-8?B?R2lVTnR4akFtM015azRKRVBBRXE3SlV5Z1ExT1dSWjJtZk0zT1h4S25Hc0E4?=
 =?utf-8?B?TzlBZjVRZ0czT0FYWXI5cHJtMHFJaVdVVkoxRWRGK1crQ2VjclN1ZDNON09h?=
 =?utf-8?B?MmcyN0wyR09ya1drbzZ5WkFzMnFzTkY5elpJWmFEdnNKMFgrc0F2d0NRbXFj?=
 =?utf-8?Q?nSGHDCeWoB0zMH7SPxsEAiXU5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39C2FE60D2692141BE4A3159F4F61714@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620c3aed-d8a8-422a-151b-08dab1ce6cae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 12:35:37.0761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfYfFkLpOchKhUd4Vrt4A5xNjfy+5XJUWMdRlpnTLIFj3JSFu/lvBYJpwgVOCTrd/SaCrcvcDZL1gvsFkFPSMTXlrk29s8IA0xM5yyTCfds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7024
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkvMTAvMjAyMiAxMzozMCwgSGVpa28gU3R1ZWJuZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgQW51cCwNCj4gDQo+IEFtIE1pdHR3b2No
LCAxOS4gT2t0b2JlciAyMDIyLCAxNDoxNjoxOSBDRVNUIHNjaHJpZWIgQW51cCBQYXRlbDoNCj4+
IEZyb206IEFuZHJldyBKb25lcyA8YWpvbmVzQHZlbnRhbmFtaWNyby5jb20+DQo+Pg0KPj4gcmlz
Y3ZfY2JvbV9ibG9ja19zaXplIGFuZCByaXNjdl9pbml0X2Nib21fYmxvY2tzaXplKCkgc2hvdWxk
IGFsd2F5cw0KPj4gYmUgYXZhaWxhYmxlIGFuZCByaXNjdl9pbml0X2Nib21fYmxvY2tzaXplKCkg
c2hvdWxkIGFsd2F5cyBiZQ0KPj4gaW52b2tlZCwgZXZlbiB3aGVuIGNvbXBpbGluZyB3aXRob3V0
IFJJU0NWX0lTQV9aSUNCT00gZW5hYmxlZC4gVGhpcw0KPj4gaXMgYmVjYXVzZSBkaXNhYmxpbmcg
UklTQ1ZfSVNBX1pJQ0JPTSBtZWFucyAiZG9uJ3QgdXNlIHppY2JvbQ0KPj4gaW5zdHJ1Y3Rpb25z
IGluIHRoZSBrZXJuZWwiIG5vdCAicHJldGVuZCB0aGVyZSBpc24ndCB6aWNib20sIGV2ZW4NCj4+
IHdoZW4gdGhlcmUgaXMiLiBXaGVuIHppY2JvbSBpcyBhdmFpbGFibGUsIHdoZXRoZXIgdGhlIGtl
cm5lbCBlbmFibGVzDQo+PiBpdHMgdXNlIHdpdGggUklTQ1ZfSVNBX1pJQ0JPTSBvciBub3QsIEtW
TSB3aWxsIG9mZmVyIGl0IHRvIGd1ZXN0cy4NCj4+IEVuc3VyZSB3ZSBjYW4gYnVpbGQgS1ZNIGFu
ZCB0aGF0IHRoZSBibG9jayBzaXplIGlzIGluaXRpYWxpemVkIGV2ZW4NCj4+IHdoZW4gY29tcGls
aW5nIHdpdGhvdXQgUklTQ1ZfSVNBX1pJQ0JPTS4NCj4gDQo+IGVpdGhlciBJJ20gd2F5IHZlcnkg
bG93IG9uIGNvZmZlZSBvciBzb21ldGhpbmcgaXMgc3RyYW5nZSBoZXJlIDotKSAuDQo+IA0KPiBJ
IGNhbiBmdWxseSBncmFzcCB0aGUgbmVlZCB0byBpbml0IHRoZSBjYm9tIGJsb2Nrc2l6ZSBmb3Ig
Z3Vlc3RzLCBldmVuIHdoZW4NCj4gdGhlIG1haW4ga2VybmVsIGlzbid0IHVzaW5nIGl0LCBidXQg
YmVsb3cgaW4gdGhlIHBhdGNoIGl0c2VsZiBpdCBpcyBzdGlsbDoNCj4gDQo+ICsjaWZkZWYgQ09O
RklHX1JJU0NWX0lTQV9aSUNCT00NCj4gK3ZvaWQgcmlzY3ZfaW5pdF9jYm9tX2Jsb2Nrc2l6ZSh2
b2lkKQ0KPiArew0KPiBbLi4uXQ0KPiANCj4gc28gdGhlIGluaXRfY2JvbV9ibG9ja3NpemUgZnVu
Y3Rpb24gaXMgc3RpbGwgaW5zaWRlIGEgUklTQ1ZfSVNBX1pJQ0JPTQ0KPiBpZmRlZj8NCg0KRldJ
VzoNCkRyZXcncyBwYXRjaCwgb3IgYXQgbGVhc3QgdGhlIHZlcnNpb24gb2YgaXQgdGhhdCBJIGhh
dmUgYmVlbiB1c2luZy9kaWQNCmEgcmV2aWV3IG9mLCBkb2VzIG5vdCBoYXZlIGluaXRfY2JvbV9i
bG9ja3NpemUoKSBpbnNpZGUgc3VjaCBhICNpZmRlZi4NCg0KPiANCj4gDQo+IEhlaWtvDQo+IA0K
PiANCj4+DQo+PiBGaXhlczogOGY3ZTAwMWUwMzI1ICgiUklTQy1WOiBDbGVhbiB1cCB0aGUgWmlj
Ym9tIGJsb2NrIHNpemUgcHJvYmluZyIpDQo+PiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9i
b3QgPGxrcEBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgSm9uZXMgPGFqb25l
c0B2ZW50YW5hbWljcm8uY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogQW51cCBQYXRlbCA8YXBhdGVs
QHZlbnRhbmFtaWNyby5jb20+DQo+PiBSZXZpZXdlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5k
b29sZXlAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICBhcmNoL3Jpc2N2L21tL2NhY2hlZmx1
c2guYyAgICAgIHwgNDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIGFy
Y2gvcmlzY3YvbW0vZG1hLW5vbmNvaGVyZW50LmMgfCA0MSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCA0MSBk
ZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9tbS9jYWNoZWZsdXNo
LmMgYi9hcmNoL3Jpc2N2L21tL2NhY2hlZmx1c2guYw0KPj4gaW5kZXggNmNiN2Q5NmFkOWM3Li5m
MzE4YjI1NTM2MTIgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3Jpc2N2L21tL2NhY2hlZmx1c2guYw0K
Pj4gKysrIGIvYXJjaC9yaXNjdi9tbS9jYWNoZWZsdXNoLmMNCj4+IEBAIC0zLDYgKzMsOCBAQA0K
Pj4gICAgKiBDb3B5cmlnaHQgKEMpIDIwMTcgU2lGaXZlDQo+PiAgICAqLw0KPj4NCj4+ICsjaW5j
bHVkZSA8bGludXgvb2YuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQo+PiAg
ICNpbmNsdWRlIDxhc20vY2FjaGVmbHVzaC5oPg0KPj4NCj4+ICAgI2lmZGVmIENPTkZJR19TTVAN
Cj4+IEBAIC04NiwzICs4OCw0MiBAQCB2b2lkIGZsdXNoX2ljYWNoZV9wdGUocHRlX3QgcHRlKQ0K
Pj4gICAgICAgICAgICAgICAgZmx1c2hfaWNhY2hlX2FsbCgpOw0KPj4gICB9DQo+PiAgICNlbmRp
ZiAvKiBDT05GSUdfTU1VICovDQo+PiArDQo+PiArdW5zaWduZWQgaW50IHJpc2N2X2Nib21fYmxv
Y2tfc2l6ZTsNCj4+ICtFWFBPUlRfU1lNQk9MX0dQTChyaXNjdl9jYm9tX2Jsb2NrX3NpemUpOw0K
Pj4gKw0KPj4gKyNpZmRlZiBDT05GSUdfUklTQ1ZfSVNBX1pJQ0JPTQ0KPj4gK3ZvaWQgcmlzY3Zf
aW5pdF9jYm9tX2Jsb2Nrc2l6ZSh2b2lkKQ0KPj4gK3sNCj4+ICsgICAgIHN0cnVjdCBkZXZpY2Vf
bm9kZSAqbm9kZTsNCj4+ICsgICAgIHVuc2lnbmVkIGxvbmcgY2JvbV9oYXJ0aWQ7DQo+PiArICAg
ICB1MzIgdmFsLCBwcm9iZWRfYmxvY2tfc2l6ZTsNCj4+ICsgICAgIGludCByZXQ7DQo+PiArDQo+
PiArICAgICBwcm9iZWRfYmxvY2tfc2l6ZSA9IDA7DQo+PiArICAgICBmb3JfZWFjaF9vZl9jcHVf
bm9kZShub2RlKSB7DQo+PiArICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgaGFydGlkOw0KPj4g
Kw0KPj4gKyAgICAgICAgICAgICByZXQgPSByaXNjdl9vZl9wcm9jZXNzb3JfaGFydGlkKG5vZGUs
ICZoYXJ0aWQpOw0KPj4gKyAgICAgICAgICAgICBpZiAocmV0KQ0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgIGNvbnRpbnVlOw0KPj4gKw0KPj4gKyAgICAgICAgICAgICAvKiBzZXQgYmxvY2stc2l6
ZSBmb3IgY2JvbSBleHRlbnNpb24gaWYgYXZhaWxhYmxlICovDQo+PiArICAgICAgICAgICAgIHJl
dCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5vZGUsICJyaXNjdixjYm9tLWJsb2NrLXNpemUiLCAm
dmFsKTsNCj4+ICsgICAgICAgICAgICAgaWYgKHJldCkNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICBjb250aW51ZTsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgaWYgKCFwcm9iZWRfYmxvY2tfc2l6
ZSkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgIHByb2JlZF9ibG9ja19zaXplID0gdmFsOw0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgIGNib21faGFydGlkID0gaGFydGlkOw0KPj4gKyAgICAg
ICAgICAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGlmIChwcm9iZWRfYmxv
Y2tfc2l6ZSAhPSB2YWwpDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcl93YXJu
KCJjYm9tLWJsb2NrLXNpemUgbWlzbWF0Y2hlZCBiZXR3ZWVuIGhhcnRzICVsdSBhbmQgJWx1XG4i
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjYm9tX2hhcnRpZCwg
aGFydGlkKTsNCj4+ICsgICAgICAgICAgICAgfQ0KPj4gKyAgICAgfQ0KPj4gKw0KPj4gKyAgICAg
aWYgKHByb2JlZF9ibG9ja19zaXplKQ0KPj4gKyAgICAgICAgICAgICByaXNjdl9jYm9tX2Jsb2Nr
X3NpemUgPSBwcm9iZWRfYmxvY2tfc2l6ZTsNCj4+ICt9DQo+PiArI2VuZGlmDQo+PiBkaWZmIC0t
Z2l0IGEvYXJjaC9yaXNjdi9tbS9kbWEtbm9uY29oZXJlbnQuYyBiL2FyY2gvcmlzY3YvbW0vZG1h
LW5vbmNvaGVyZW50LmMNCj4+IGluZGV4IGIwYWRkOTgzNTMwYS4uZDkxOWVmYWI2ZWJhIDEwMDY0
NA0KPj4gLS0tIGEvYXJjaC9yaXNjdi9tbS9kbWEtbm9uY29oZXJlbnQuYw0KPj4gKysrIGIvYXJj
aC9yaXNjdi9tbS9kbWEtbm9uY29oZXJlbnQuYw0KPj4gQEAgLTgsMTMgKzgsOCBAQA0KPj4gICAj
aW5jbHVkZSA8bGludXgvZG1hLWRpcmVjdC5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvZG1hLW1h
cC1vcHMuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L21tLmg+DQo+PiAtI2luY2x1ZGUgPGxpbnV4
L29mLmg+DQo+PiAtI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPj4gICAjaW5jbHVkZSA8
YXNtL2NhY2hlZmx1c2guaD4NCj4+DQo+PiAtdW5zaWduZWQgaW50IHJpc2N2X2Nib21fYmxvY2tf
c2l6ZTsNCj4+IC1FWFBPUlRfU1lNQk9MX0dQTChyaXNjdl9jYm9tX2Jsb2NrX3NpemUpOw0KPj4g
LQ0KPj4gICBzdGF0aWMgYm9vbCBub25jb2hlcmVudF9zdXBwb3J0ZWQ7DQo+Pg0KPj4gICB2b2lk
IGFyY2hfc3luY19kbWFfZm9yX2RldmljZShwaHlzX2FkZHJfdCBwYWRkciwgc2l6ZV90IHNpemUs
DQo+PiBAQCAtNzcsNDIgKzcyLDYgQEAgdm9pZCBhcmNoX3NldHVwX2RtYV9vcHMoc3RydWN0IGRl
dmljZSAqZGV2LCB1NjQgZG1hX2Jhc2UsIHU2NCBzaXplLA0KPj4gICAgICAgIGRldi0+ZG1hX2Nv
aGVyZW50ID0gY29oZXJlbnQ7DQo+PiAgIH0NCj4+DQo+PiAtI2lmZGVmIENPTkZJR19SSVNDVl9J
U0FfWklDQk9NDQo+PiAtdm9pZCByaXNjdl9pbml0X2Nib21fYmxvY2tzaXplKHZvaWQpDQo+PiAt
ew0KPj4gLSAgICAgc3RydWN0IGRldmljZV9ub2RlICpub2RlOw0KPj4gLSAgICAgdW5zaWduZWQg
bG9uZyBjYm9tX2hhcnRpZDsNCj4+IC0gICAgIHUzMiB2YWwsIHByb2JlZF9ibG9ja19zaXplOw0K
Pj4gLSAgICAgaW50IHJldDsNCj4+IC0NCj4+IC0gICAgIHByb2JlZF9ibG9ja19zaXplID0gMDsN
Cj4+IC0gICAgIGZvcl9lYWNoX29mX2NwdV9ub2RlKG5vZGUpIHsNCj4+IC0gICAgICAgICAgICAg
dW5zaWduZWQgbG9uZyBoYXJ0aWQ7DQo+PiAtDQo+PiAtICAgICAgICAgICAgIHJldCA9IHJpc2N2
X29mX3Byb2Nlc3Nvcl9oYXJ0aWQobm9kZSwgJmhhcnRpZCk7DQo+PiAtICAgICAgICAgICAgIGlm
IChyZXQpDQo+PiAtICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+PiAtDQo+PiAtICAg
ICAgICAgICAgIC8qIHNldCBibG9jay1zaXplIGZvciBjYm9tIGV4dGVuc2lvbiBpZiBhdmFpbGFi
bGUgKi8NCj4+IC0gICAgICAgICAgICAgcmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91MzIobm9kZSwg
InJpc2N2LGNib20tYmxvY2stc2l6ZSIsICZ2YWwpOw0KPj4gLSAgICAgICAgICAgICBpZiAocmV0
KQ0KPj4gLSAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4gLQ0KPj4gLSAgICAgICAg
ICAgICBpZiAoIXByb2JlZF9ibG9ja19zaXplKSB7DQo+PiAtICAgICAgICAgICAgICAgICAgICAg
cHJvYmVkX2Jsb2NrX3NpemUgPSB2YWw7DQo+PiAtICAgICAgICAgICAgICAgICAgICAgY2JvbV9o
YXJ0aWQgPSBoYXJ0aWQ7DQo+PiAtICAgICAgICAgICAgIH0gZWxzZSB7DQo+PiAtICAgICAgICAg
ICAgICAgICAgICAgaWYgKHByb2JlZF9ibG9ja19zaXplICE9IHZhbCkNCj4+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHByX3dhcm4oImNib20tYmxvY2stc2l6ZSBtaXNtYXRjaGVkIGJl
dHdlZW4gaGFydHMgJWx1IGFuZCAlbHVcbiIsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNib21faGFydGlkLCBoYXJ0aWQpOw0KPj4gLSAgICAgICAgICAgICB9DQo+
PiAtICAgICB9DQo+PiAtDQo+PiAtICAgICBpZiAocHJvYmVkX2Jsb2NrX3NpemUpDQo+PiAtICAg
ICAgICAgICAgIHJpc2N2X2Nib21fYmxvY2tfc2l6ZSA9IHByb2JlZF9ibG9ja19zaXplOw0KPj4g
LX0NCj4+IC0jZW5kaWYNCj4+IC0NCj4+ICAgdm9pZCByaXNjdl9ub25jb2hlcmVudF9zdXBwb3J0
ZWQodm9pZCkNCj4+ICAgew0KPj4gICAgICAgIFdBUk4oIXJpc2N2X2Nib21fYmxvY2tfc2l6ZSwN
Cj4+DQo+IA0KPiANCj4gDQo+IA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NCj4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQo+IGxpbnV4LXJp
c2N2QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1yaXNjdg0KDQo=
