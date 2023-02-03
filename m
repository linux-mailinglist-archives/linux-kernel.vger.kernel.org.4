Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCED689842
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjBCMI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjBCMIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:08:25 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F9FEB4C;
        Fri,  3 Feb 2023 04:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675426102; x=1706962102;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=oFNG88giNQFpfezFN9ELsTydr0zA2PnJOZozpQf5aYI=;
  b=U77gHd4/D3xGGScEu3eL+ueaoEr+x1nfK3XZgURgx/fg9GYz3FSGq2Ce
   h215G2OoYhvpNondpiercyNFKdXc8eKmFKjldB4CFlIIbN0mButoQnSyf
   9jinsmF4k6bxDEmrWsgNF1byQsGIFoBgWkOOys0uEYCUNuo2Kn1h5Y0Wh
   XJtAzSGUr36wv4bzjYP42m6ZBSkfR/xAN/edcZjLAFbKtGV13fIHXMoT3
   8bevSh9FISHTPypiYbz5TskfXnIb86S/2hKMuFSXdbjh0EGn9P9oqFCew
   Ar8p/gmisbDvKB+0PJ4Ovux849fIAopYgcOarFvvy74Praxd3V4oHa5oc
   g==;
X-IronPort-AV: E=Sophos;i="5.97,270,1669100400"; 
   d="scan'208";a="195232228"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Feb 2023 05:08:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 05:08:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 05:08:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wtm8ttWZPANNyGXNONUh0AQEM15PiY/Lo0EomMPs7++Fu2wOmIHXCyIOboE9PhDIRjNmpZ5CxcgOWcAQaT10yjdKLHf2mAKW293urWDyCKqQqjJUkhqjTrTXafNXFPkFziWrBwxocIIIJK+3+OSW2AvXS4f/4Ib0am3EKrd/7fWny/B0422Io0GETT9/LYYfpGhWXn5eO989YV2o18k0/0f4yA71fZ0PW8SM+eZHXuNUn9kCvcS/ap5n5xeLlCQT8Sy8KO/lXgTTL1xlARGgj4mkqF+069zZ9mUlG+9YCF4y+39MUruC5+meiBVoXWTGh7zoIORt/J/70Lg0UL48rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFNG88giNQFpfezFN9ELsTydr0zA2PnJOZozpQf5aYI=;
 b=YM0o/ymhTDbFgpl3ZIZc4l6HW/d8/Ljz7JHGAIolYXKrBD4cSGg+OhzMFmMxzI+7Oh7Rz7keHQPoiZOsE27Xo2Yd2HlU3LLIEE84wj8Ig9h9JJsosw0FSaGEJC1dA6I2eK1cXrNFXU23M5SKrNp6B9nBi7kM82jFmwO2w0VEgqqveGmJqqjCHoaesd8+9bH7/40tRwYQN/6tGv5aMGEIYe2dRg5wnyGjt+kUEf3tjm1BlfgTudD9ZTY0XbiOTDB2f3JBIp52Gj3b/fGhwBW+Jnpb/gnXefwuZkjMaOO9y/t9AiTJsNaRCq+nUu9FdGMN5CgCEnjeDbvAMq+QdDc/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFNG88giNQFpfezFN9ELsTydr0zA2PnJOZozpQf5aYI=;
 b=XOuLzRxBNcSsGsDNo8Xz1o1Ns6LSTC9x2NSTSnGCftA0eYaFkCfAOqMQabjXboeFsbJlUt8OeZhQVCOShRtdvCo/REfHQW0hFIe+l00gw3EVisIszybPCNA0WoYdyfU0ML75rXb/FTEQt+f7iZ9CDXrSMEmgeDCNSWMCMn/z5Rk=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by IA1PR11MB6148.namprd11.prod.outlook.com (2603:10b6:208:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 12:08:15 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5%9]) with mapi id 15.20.6064.031; Fri, 3 Feb 2023
 12:08:15 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Durai.ManickamKR@microchip.com>, <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Manikandan.M@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Dharma.B@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
        <Balakrishnan.S@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <krzysztof.kozlowski@linaro.org>,
        <alexandre.belloni@bootlin.com>, <davem@davemloft.net>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <Horatiu.Vultur@microchip.com>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <michael@walle.cc>, <Jerry.Ray@microchip.com>
Subject: Re: [PATCH v5 3/8] ARM: dts: at91: sam9x60: fix spi4 node
Thread-Topic: [PATCH v5 3/8] ARM: dts: at91: sam9x60: fix spi4 node
Thread-Index: AQHZN8gxnOAMjkuuWE2ba1MDkl+0wg==
Date:   Fri, 3 Feb 2023 12:08:15 +0000
Message-ID: <080c156c-c070-aa03-4f43-7578d2d3f484@microchip.com>
References: <20230203034833.451461-1-durai.manickamkr@microchip.com>
 <20230203034833.451461-4-durai.manickamkr@microchip.com>
In-Reply-To: <20230203034833.451461-4-durai.manickamkr@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|IA1PR11MB6148:EE_
x-ms-office365-filtering-correlation-id: 0d17995d-0193-410e-ddc9-08db05df5481
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u3XNTP3x5xox5Vw+qi/RKU/4lESqjLZb1BhnokbZqI9cMcXpw1WDNhuUbzsqSixmbN2KnlLsNfAWrHlf2XquLX9vt37padVzsTsH4DqgPv4FnJx8jkULFbgXDB66tP0OBS0UwgbBcgeBEGrpUJCOrcyZIVtxTR+MlhjBxUitBRKpO1hvNIvhDJirBSh1ulVDZhyeJqj+9fVoMJcpjCbWCAeThabvBFUFD8a6J3n9OGR+yyWKrjis7Xvq4JPcvAmMcA4nE6Xi7xH23DiQSfjyJeYhjQnDcrlD68dmb/p+hh4wpTTYToXyw/uUGFAC1u3hheVet9lAYZhAOe5NfXxJaUPKAcO9EpmGx6FGCNcnL5z+NV8JB5b2tmzwjCEke+M9vFaw1BaVDXb2Ix5jXo7W0daZ/Pzbe4cA/KtJgByFK10WnmcYnBERD9G3daHAZFlJUedYS0WAZoCfTkEDrEdq+9uhZVptTe/iWqrWBkv2YEZuUThtFbArm03MSty+3dlyhpHNUPXUGTMwTZskrPoa/DSLrzuUcWtnhFyiD3SjGa8MJkb0Qugzdz0ig+RkfUvfRFtj3pFZu+35UVnDxa8acABcvLz8+Ibfv1ecF80Ty3HMZkjoqAHVxLk+ggmc8jEsEr32Z1cuMH1BaYnStIFdUnhrLtdffs+QL9tqMz58o8/RPUjTIRALMnb+6Sm7FXxzWKHd0wz3x5BzLnydXubyT9lVBz0srCmDiclyVrX9RlmrDGBGoHASW9vEwZH6zeF03qkx5XWt4co4Z1KjyydTNuypjKk40GMqpb2MzRhu8Ck=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(66946007)(76116006)(8676002)(6506007)(6636002)(6486002)(478600001)(26005)(110136005)(53546011)(6512007)(36756003)(316002)(186003)(5660300002)(86362001)(7416002)(2906002)(91956017)(41300700001)(66556008)(31696002)(66476007)(8936002)(64756008)(71200400001)(66446008)(2616005)(83380400001)(4744005)(38070700005)(122000001)(921005)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlJVWHZGNmhEaE9uU3kzejRab1BtVWloNWc0WkhOT1NPTEM1YzhSM21TS3hO?=
 =?utf-8?B?TFRiUmhzZWY2dUxFcjlEMWFtSVIrZjdBOUkvQjB4U3NtYnVuWHN3OWtsU1dW?=
 =?utf-8?B?a2NuLzNESDlMNkZzVFBrMGxXY1pxQ3gzR1FkT2J2YTNienkvSTJrbWZEVitj?=
 =?utf-8?B?eUV4bCtuRTc5ek1pTjk5WHVNdGpLMXpyM2Y0WEg4NnBpMnRJYUNIUG9JeUJy?=
 =?utf-8?B?Y2JmZVNBbzZiUzY2MVVqeVZDblAwR0tTeHU0Vlk1d1RBeHlNNmpJYlY4S2R4?=
 =?utf-8?B?ckxvdlowRzMrTkFmeVN2RmUxZVFRTk53Yy9YY3dhWnRueWRzV0o0ZEtLUG9H?=
 =?utf-8?B?Q1BhdzNwQlh0WDBlUjlqTFJmV0lVV3pqUmxROEJMMEUrNFZKRXBJQzNRb1l0?=
 =?utf-8?B?LytOL3h6ZG5QWHdKQm82M3FiREFraWFBTmd3T2dDZ3dvMWpEOVlLSldkcjBG?=
 =?utf-8?B?SkoyVVRtOG1lTU1vbzFONzFoSWlkYUhTVEUwNTFGUzR4L0hkblY5MEpkdjVv?=
 =?utf-8?B?dG56aHBBU0tDMGpNN1FocjlTa3hoS014cjQ3YWQ1YnprNlBETzBSQ25RMHhq?=
 =?utf-8?B?NTEyU09QSGxjSGJtZ29hL3FVSjNtL09nY1hYWkd2Vmdoc2JkZmVpTHEzREIr?=
 =?utf-8?B?QjB0dysvMEFUaUdBQUQ0ZjJRV1NjdFdGbXI3TDZTRGpLTHBTWmFNQ0NWdmsz?=
 =?utf-8?B?Tk9TbG1FL00wYXYxVXpyRHJoRVA1Kzd2WEF6MFVXNVVmdlJadUZNMEVwRVBS?=
 =?utf-8?B?TzdCSExrN0ZIRVhHUVlwT05DazhHK3FiUXBiaVp4S3VEQmlxbWc2RG1nWUhn?=
 =?utf-8?B?ZStNOXRCVGhRMlNEWXhNcHN3WFUvSUQxL3N4QmF6SC8zam04NTJVaDRiSXk2?=
 =?utf-8?B?cUViM1JSQ0ZpNHlQd3NuU0lGU2dpbitsam02RUFuY09aeUkySE5VaXRzT3hu?=
 =?utf-8?B?SG5aNmdhZUQ2TmozVnRTMzZ1V0lJclVOalVpbWxVUEkzR3lSejR2VmRSSUkz?=
 =?utf-8?B?Z0RmSFFzK0g5RXVFQlpIT05vZGF1NnlsV2l0alVxZXZ1ckNRR2Z6Ty92M0NI?=
 =?utf-8?B?RnZVS1N1dmhnaXVlaXVhQmh5QlJLOTdxY2VaQllLVVE2ZFljMUxvTXB5anBJ?=
 =?utf-8?B?QWJaN1JpbnVXVzJMLzFabFZiMG5ZVFRGenEzZGYrSFRvQ3RLUkRJbnJOdTJK?=
 =?utf-8?B?d0RHSk9sY1JxUWhTOVIrNmRabnRhNzZVUDhtTFk0ZG4vUFJFWkNqVFM4YmVQ?=
 =?utf-8?B?aDZTVVFSOTB5ZTB3UGd5eG9MM2JKSG94MzlheFBVcXFVVldHNjI0eFJ1Z2ZV?=
 =?utf-8?B?YVUzbEE2czRxWHpDcnoyQjc0ZW5DZDF6dmVaZVFpOEk2a0lFYXdVVHZsWDZJ?=
 =?utf-8?B?eWtwY1pMMW9XZGZnb0J5ZkZSV0FHRU1NNG9DdUNIM1NvclcrMERQcDg4UGQ5?=
 =?utf-8?B?bGE0VTduS3A5cXM0U2FFcnkxZHlJZ0pGQTl0MzZGbThGMGFOOW9xcFljbi83?=
 =?utf-8?B?dmpCbEFxR2xXbFBIV21HbW9BQ3B1eGhoSkZjWnBZLy9nWklhN3U0dVFNYUIz?=
 =?utf-8?B?VUtHeFVsNlZVaHg5Y0RDVEYzQkdYd1J3MWJlOWJXQnhuZjRVcUFKYVJ2QlRq?=
 =?utf-8?B?d1EveEc0TlVmeDJ2N3NFRk1EYVB2QndIVm5MVGJJbHZJeE9qMGg3THQrNjJl?=
 =?utf-8?B?T1Q5QXArK0Z5eFh6WEtZNGV5YnJvRHg5TVh6a2UwcFBDeWpjcW9Ed3FvN2g1?=
 =?utf-8?B?K0RLNHYzSEtCRnlWZzJRalNrRGJJSXJVSEJRTXJSa1BLdWxKdDBEUTVhSFR0?=
 =?utf-8?B?WjNRc0dBRUo5a2Y3VC9lUlI3aWRWNzlqaE83MDNKeEU4a09LeDBHUlpTWlVN?=
 =?utf-8?B?RkIyTi9wbUtybEs0QXNMcTJSMTJTaExvZnlCcllpYXA4bzQvd2g2U0Q4L08z?=
 =?utf-8?B?L2tIQVVJS2luM01wRW5ndDdFR0dNdzlIL1RwcnBpV2w1NmZMRlBhcWpWMnFP?=
 =?utf-8?B?b1QyTm1QT0tFeWJ6WTVhL3lGWG1KY1pWSno2dm9tcTRmOWRSUldaTW1QZk9r?=
 =?utf-8?B?Qm1VZW9nTllwQ254alREMzh4NUhDdGZDSndlTjQyTDlaZ2VTaTlqVmgvUXVK?=
 =?utf-8?B?QThET3pDNFEvY0w3bTBweUx5R0hXSEZMM055eE51Wmh3eXpjVkF4VmJVcmlU?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDF59B6E67B3F2458DBDF3A38D7E2974@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d17995d-0193-410e-ddc9-08db05df5481
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 12:08:15.6075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RV5hC2uhhW7Gr7ukFLKTsfk6D61/XdzaOfQkU4aNkPlgC3PEgUJa8RBqQcSB2TYn4OQ7qYYGIlaICzZCr37Wp2COehkCrJKPBj2mmiCeAvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6148
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDIuMjAyMyAwNTo0OCwgRHVyYWkgTWFuaWNrYW0gS1Igd3JvdGU6DQo+IFRoZSByYW5n
ZXMsICNhZGRyZXNzLWNlbGxzIGFuZCAjc2l6ZS1jZWxscyBwcm9wZXJ0aWVzIGFyZSBub3QgcmVx
dWlyZWQsDQo+IHJlbW92ZSB0aGVtIGZyb20gdGhlIHNwaTQgbm9kZS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IER1cmFpIE1hbmlja2FtIEtSIDxkdXJhaS5tYW5pY2thbWtyQG1pY3JvY2hpcC5jb20+
DQoNClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlw
LmNvbT4NCg0KDQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRz
IHwgMiAtLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzIGIvYXJjaC9hcm0vYm9v
dC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzDQo+IGluZGV4IDRmZjg0NjMzZGQ0My4uNmI2MzkxZDUw
NDFlIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMN
Cj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzDQo+IEBAIC0yMzIs
OCArMjMyLDYgQEAgJmZseDQgew0KPiAgCXNwaTQ6IHNwaUA0MDAgew0KPiAgCQlwaW5jdHJsLW5h
bWVzID0gImRlZmF1bHQiOw0KPiAgCQlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZmx4NF9kZWZhdWx0
PjsNCj4gLQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+IC0JCSNzaXplLWNlbGxzID0gPDA+Ow0K
PiAgCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiAgCX07DQo+ICB9Ow0KDQo=
