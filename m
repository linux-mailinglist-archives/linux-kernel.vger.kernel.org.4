Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8005B66BB09
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjAPJ4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAPJ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:56:22 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741BE14EA9;
        Mon, 16 Jan 2023 01:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673862973; x=1705398973;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=3eGrkmugC2rKQhTDFO3gzMXXnuX7SfLm/UGpT7mqrWU=;
  b=vAZhy04Yqbotn8I/Anc9sz6RWElv1Gx63IqApu7W3sBu+4hgvj5C+I41
   ZqW8T6zGB32+41xXsmhMXol1Q7HQy7bw1ioRQPBlzOPKxcbGBVj4GUSa0
   mJ5iDCzBuvsuYC1SpQ9h6yNjVx0fmqYCdkLReSF5CSMSwLgml1IcpXmAC
   TiIc+BW/6z9Mv3HMFlnFHh6s5LDqKuBmP6A3ZVUPaYsXoq/2WEzbszAJs
   2uEkBDbY/A6v5qhKUwBT+s9kWR3SULxHqGMOL8QEai50fhR8hKFzD+9gc
   rANu4SmTieoPZQJd2HEJ5JAFVZLDjHDxK/NayYWwnF0MTt4wgUkxltcmn
   w==;
X-IronPort-AV: E=Sophos;i="5.97,220,1669100400"; 
   d="scan'208";a="196805931"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jan 2023 02:56:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 16 Jan 2023 02:56:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 16 Jan 2023 02:56:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ai+AygvbSSC3zqrW4X9Hqv7nOjc2DqJulYPB4vNX07TyZJ1iwncgtianluwa0qmCkk7FIdX0B8w9OUdfcEQ4H8Gz/RuSdSpP/BXTpdNjdW3Cu+lD80JCfVrz/rdkz4pSIdhIG8d0u9HX6WAvMcdAlna5IOYhHYVOatA2zuNMy74xc6PB+bVWMd7ELMaaxqFY+g+d8hooqSxDleckgggSG8NF8pbT1mKhPLCirUldhBX/MKHSeHQPEc9y/whObyju22kIO5KjaGlUvWMTrf/M9NZvk02C8/DdKXAnuJwi0ZH4fL9ztBoKKQlT52kYAd0M9ZHQJnKXD4fyqAMqyehmcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eGrkmugC2rKQhTDFO3gzMXXnuX7SfLm/UGpT7mqrWU=;
 b=IWGMj2tbrOzDQrmjDi1vMwS+fBLmsJoS/QL8I06op7/Vk/HxcZO66EShAUg4vilS7CWm5sXndIaNOS8j/Ij9n3z7y1GpI+XJvs+KoMxu8oagfL6PIsUDF4fMFqMi3dnsyc6ea7iF5iD5sczHVPuN1UoZbTkSnEJGqozLi2u+zHxr94XvxiQIbb8Rb18SlRaOBVSkyB6y0Wo8bxr8N6glPWUsAX+pyjId2FEy/jvuewzyx3L9aa0cTRnbUaJJ2rlph57CCem1pIPPv1WKziLt4wcV2rK2Wf+gbMD6X0nUFP97z/Eg780FJbvAONkcBRvoVkoxTdvmlVh4XygPdEaK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eGrkmugC2rKQhTDFO3gzMXXnuX7SfLm/UGpT7mqrWU=;
 b=iH8Sf/1Yg0Oyrx7ms34+Oj63qnsZmHuGxkj4mpuQsQxR94PgMdzp2ORbr5w96q3flQeCoKtNVS8ugJV3LilodYP2c8TnKJkLqOglP9ENOAJdiG3o3hXv3dArxNt9TDOLMc3HEPwE8E3hkl5AttuX9ThzvX3tcmxLpPocWRLpqiQ=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 09:56:10 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 09:56:10 +0000
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
Subject: Re: [PATCH v4 5/8] ARM: dts: at91: sam9x60: Add DMA bindings for the
 flexcom nodes
Thread-Topic: [PATCH v4 5/8] ARM: dts: at91: sam9x60: Add DMA bindings for the
 flexcom nodes
Thread-Index: AQHZKZDCIjDWRZXIuki2niX1Seboug==
Date:   Mon, 16 Jan 2023 09:56:09 +0000
Message-ID: <62154915-69b1-d8ee-db2a-b70a313946a7@microchip.com>
References: <20230112110208.97946-1-durai.manickamkr@microchip.com>
 <20230112110208.97946-6-durai.manickamkr@microchip.com>
In-Reply-To: <20230112110208.97946-6-durai.manickamkr@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|PH0PR11MB5808:EE_
x-ms-office365-filtering-correlation-id: dd6f2762-a44c-407d-e23d-08daf7a7e500
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wObg3n0Cc84RV3dMGO/YRiSAg11wnw+dHQL2rzHUI18LeBwWna+0Zw0xOaxDqlicyDBw63CV5C/V5xRbNbT+wHqi4l7H4NK/iAyFgSAMCCjg6NimZak77G2WjriTM+/EVw48AnJwo76UTgH0ewGcAvxoOa6V5EtDeEcruqPk+DoJrhncDgMvibyMqTdF7gAXwO+Eb364PMnSLp3VsqHRwU5FvVLeHj0rBKgml3XfZV7jGPGpW62L6xtKImj3/+M//ATZWQ8Qui2V1GZ/Xyu/GnFkY8kPX93HqlIXgclhcraeq1TX5qIP1DoOZpUu9MpGXi/fQFxJGsLf/9asIRFW39NZtM5k7zGvQjpj5aUzkbHY7g1+uxm+ZMjDMcd2Foql7oQylvm8CmVEIibFHSDf/cxlUlM0cTlOfzZeHq0S0993qQvOVWU0A0vtigVw1uS0DFre/kvxXR8nzRtLqEpgLStsGST1DGWXw4ot9yYnE6302LNXIb6KVZRsfi2yeFNXMMZuuv/Yps7g8lJIJWECwsQSebsfRfkGXSy6j+/7z1WVEK7rw0LHXkKD6Kmcsha8EY+JuKXuSLFU2VOg/caU23SabWiTXJRRn8qpIvBITPv7Kxfa6Ge3DYZtO/l2ZPOTL8cAoZ4jiPLMqoKz88IAmAo9+hMvP8ALoyw5p8l6GzVfr1U5NM8uzF5ODPgyOO+XF3Ni9wfEoYuh0NqdaEGuCP6X4nl6BWEZQdJHljfKnICNYH7/hvVRV9PNkV9lznRs4am/97INbf/JXCRQb3yarS+KAKi3P9/oC4JOGMAXV3c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199015)(36756003)(53546011)(86362001)(6512007)(186003)(26005)(8676002)(64756008)(91956017)(66556008)(41300700001)(76116006)(2616005)(66476007)(66446008)(66946007)(316002)(71200400001)(6506007)(110136005)(31696002)(478600001)(6636002)(7416002)(122000001)(6486002)(38100700002)(38070700005)(921005)(2906002)(83380400001)(5660300002)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2htMFlOWlNtVnBiV1VjM0djcjdUOFY2RnVQS0hRS2JKNkRhMTBwYkVNS2sx?=
 =?utf-8?B?c3BsSDloUHNKaE02cWw4QXdoYm83akZuOUZXWlR6U3hXVEFsQUpkMTRRTGZI?=
 =?utf-8?B?eXZ4aU5XMVFMZ1ExYzZ0NHNmTnB5K2poRThGanFtclBYc3h6Z1hkbmFrbGRP?=
 =?utf-8?B?L0dkWjFLN1Azd1lKRGxxaGFzVHRadWhFd1FaS1FNRHp6ZmpFR2tVbWIwTG5p?=
 =?utf-8?B?MVFRdlBNTmZ3dHZFeGtzS3Jsd1pWVGhwQUVqVFJKazRZSlFSd2ZJL0pnWGhX?=
 =?utf-8?B?UXlham02VnhWdks4V08rZ3hTVGFxVEtwNjBWeUlUOXdmdDFDRW5xMmlqRmxz?=
 =?utf-8?B?UkdmMzJLU2Y1TmdTWTZhc3ZDM0dEdENwTFUvaGlITW81clpNaFV6VXA3VGJJ?=
 =?utf-8?B?dzl6N0IrQUVGcDlyaHBqRGZab3BOKzQrUUZYTWFiRWRZVStUYmMyOGFZTVd3?=
 =?utf-8?B?dHlCL1hXTVBPOVhWMmllbW9FaTJ3dUhQY2VuUnUwNW5UN2pSbTJ1Wlc5aW1C?=
 =?utf-8?B?OFJZL3o0VWo4WTV0T0I2TFpjc3AzcVpPNXFzTnpSbGZTYzNJNG8xZGk4cTM0?=
 =?utf-8?B?b25qcUZ5M3BYTnZyTGRaRWw2Wm5XN1pWSTBBM2VjVDVRR1REanZJeEZhNEpa?=
 =?utf-8?B?eEJNU3hHZndKeVA2UldDeGg4bXlGMmtZYW4wcUFybFl6S1BiNGttNDBLWHdT?=
 =?utf-8?B?ajU5T3R6YkQwaXR4RlA0QkZ4elNZQ2h0RWZsTUQ4WnlwWEgrU0lMbXA1TzIr?=
 =?utf-8?B?ejlNVlUxWDBmZmtZZ2hvZE9aWEVkcWgyYi9Pam42T3JQcmxEdHFHR2w3VVVk?=
 =?utf-8?B?Wi9DdXQ1ZWswSXVDTkRJalhIU1ZzTHhSRTBHMkJrSStXbTlMeFV3eC9pQmZ3?=
 =?utf-8?B?QWVIaDVVajZkM3FjVzYyaWw5WE1uNFQrQ2ZKVkc1c0tFTUpINXRRdWlsOUhx?=
 =?utf-8?B?VWlhaEVjQitrNzdvYnRJeG9Pb3U0bk94UWUzaDZ5Z1dCSXNSTnlHWldlemFU?=
 =?utf-8?B?OEd1dGg4aTlHZCtXbkRuNWlMNHFoamlieW14KzhUN2EzWmh0M1QyOW9kUFlK?=
 =?utf-8?B?aFhzVURSKy9XOHFCczAwY2JRUk4yaE14dGxXK04rWnNWa2MvSjNrK3g4OXpL?=
 =?utf-8?B?d3YrRTZTdXhadFdOYjZUa3p6ditGdk1HN1kxZTliQjFqTDRxNGFIMTlLRC9w?=
 =?utf-8?B?SU1QdWN4NHlpOHdmQTBsUzBEeTBJYitmRm1SVm1CNU1rZXdqVXFwd3FvUXI1?=
 =?utf-8?B?V1U2di9wNDJDUGo4aXd2VjBvV1lvajFvSmZYbnpheGxhSnc2aTBKbnZhb1pT?=
 =?utf-8?B?aHk4bVpVN0oxR0JETzRFWlJiZ2lxdHNlZzAvcUY2bDlQREhDWXV2OXlXeS9m?=
 =?utf-8?B?YWV0NjZnM3UyUWNxVGdkUm5WNSt2bXhDUU8zWjRUelBmRWpySUYxUGUreVY2?=
 =?utf-8?B?Ylc0OVZDUDd6bXBFUjVPRGNBMjRCelptL0pjeWsvWGRyOXdLR1JSbUZOWXBn?=
 =?utf-8?B?cHgvOGtjVG1xSG1qTmptYW9IYWhXREZrVXQ0K1pvbzJqbG5DdHVlZzNKY2Nj?=
 =?utf-8?B?UjMzdmJNSG9jQWZOc3lGY3BrS0w3amlJSUZLb25rWHBXRWNKUFBnbnhyR2Vm?=
 =?utf-8?B?eTFjekE5QjZLNWZlQmlpdC9HN0NzV2ppQnh3M1RRZEwwaFBYVjl2c0g1SmVX?=
 =?utf-8?B?eXJjMnhNNzFYSEIzWGdHMzRZSzJDbUt1Q3lYNy9WK0kwaThRK1lzbVAyenVG?=
 =?utf-8?B?c25mdDdsUGpDTXIyN29Fb3RYbmN1YnlFdWFDVDRESTF4VTlNV3FZbFVSdUJp?=
 =?utf-8?B?T2hKVUZHYXBqZFJpNXZEUTF1cGp1U1dJRkkvYlhMRktUMXdVczZSWFpLbUJi?=
 =?utf-8?B?ZjRJQzIwUWIrMGNBM1FyTVorTVFaWVlYblVwRWkwSjdNWm1PSkxpSmE5Q21W?=
 =?utf-8?B?RkhwTXpKTnlVWXltOHNHZWx6ams5dFoxMHl6NGNDN3kwYm5GWXNLbmpHUmYy?=
 =?utf-8?B?c3hhdlZQOEU5a0o5NFQwNDYzbWRDT0FBY2s0NjFwd25oSHB3RWRrbVhxQ1JZ?=
 =?utf-8?B?RTErQXRYOFFYQ0RUTHBoMVg2cHlmR2VPbEVPVjdjVVd3SkwvNzNtTTRtcHpE?=
 =?utf-8?B?VDF2MEtjWHV3S1ZrNVVpMkxxK3UvQUpwODUvRWxMUkFXNXNyandRa21iL05i?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75FC819ACA166D49B65960A023336FA8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6f2762-a44c-407d-e23d-08daf7a7e500
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 09:56:09.9517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: isTzNYaCu9B6PJbfxjTiU5cnpt3nggvA4OPonLFywsCcO0n8J5R2L/LeJb8f0CtcqDglj+50A+dNwdel7IUX7fF2yBm89LLn6I0ArhioCS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5808
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIuMDEuMjAyMyAxMzowMiwgRHVyYWkgTWFuaWNrYW0gS1Igd3JvdGU6DQo+IEZyb206IE1h
bmlrYW5kYW4gTXVyYWxpZGhhcmFuIDxtYW5pa2FuZGFuLm1AbWljcm9jaGlwLmNvbT4NCj4gDQo+
IEFkZCBkbWEgYmluZGluZ3MgZm9yIGZsZXhjb20gbm9kZXMgaW4gdGhlIHNvYyBkdHNpIGZpbGUu
IFVzZXJzIHRob3NlIHdobw0KPiBkb24ndCB3aXNoIHRvIHVzZSB0aGUgRE1BIGZ1bmN0aW9uIGZv
ciB0aGVpciBmbGV4Y29tIGZ1bmN0aW9ucyBjYW4NCj4gb3ZlcndyaXRlIHRoZSBkbWEgYmluZGlu
Z3MgaW4gdGhlIGJvYXJkIGRldmljZSB0cmVlIGZpbGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBN
YW5pa2FuZGFuIE11cmFsaWRoYXJhbiA8bWFuaWthbmRhbi5tQG1pY3JvY2hpcC5jb20+DQo+IFtk
dXJhaS5tYW5pY2thbWtyQG1pY3JvY2hpcC5jb206IGZpeGVkIGNvZGUgaW5kZW50YXRpb24gYW5k
IHVwZGF0ZWQgY29tbWl0IGxvZ10NCj4gU2lnbmVkLW9mZi1ieTogRHVyYWkgTWFuaWNrYW0gS1Ig
PGR1cmFpLm1hbmlja2Fta3JAbWljcm9jaGlwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUg
QmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQoNCj4gLS0tDQo+ICBhcmNo
L2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMgfCAgMyArKysNCj4gIGFyY2gvYXJtL2Jv
b3QvZHRzL3NhbTl4NjAuZHRzaSAgICAgICB8IDI3ICsrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzIGIvYXJjaC9hcm0vYm9vdC9k
dHMvYXQ5MS1zYW05eDYwZWsuZHRzDQo+IGluZGV4IDZiNjM5MWQ1MDQxZS4uMTgwZTRiMWFhMmY2
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMNCj4g
KysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzDQo+IEBAIC0yMDksNiAr
MjA5LDcgQEAgJmZseDAgew0KPiAgCWkyYzA6IGkyY0A2MDAgew0KPiAgCQkjYWRkcmVzcy1jZWxs
cyA9IDwxPjsNCj4gIAkJI3NpemUtY2VsbHMgPSA8MD47DQo+ICsJCWRtYXMgPSA8MD4sIDwwPjsN
Cj4gIAkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gIAkJcGluY3RybC0wID0gPCZwaW5j
dHJsX2ZseDBfZGVmYXVsdD47DQo+ICAJCWkyYy1hbmFsb2ctZmlsdGVyOw0KPiBAQCAtMjMwLDYg
KzIzMSw3IEBAICZmbHg0IHsNCj4gIAlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiAgDQo+ICAJc3Bp
NDogc3BpQDQwMCB7DQo+ICsJCWRtYXMgPSA8MD4sIDwwPjsNCj4gIAkJcGluY3RybC1uYW1lcyA9
ICJkZWZhdWx0IjsNCj4gIAkJcGluY3RybC0wID0gPCZwaW5jdHJsX2ZseDRfZGVmYXVsdD47DQo+
ICAJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+IEBAIC0yNTQsNiArMjU2LDcgQEAgJmZseDYgew0K
PiAgCWkyYzY6IGkyY0A2MDAgew0KPiAgCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gIAkJI3Np
emUtY2VsbHMgPSA8MD47DQo+ICsJCWRtYXMgPSA8MD4sIDwwPjsNCj4gIAkJcGluY3RybC1uYW1l
cyA9ICJkZWZhdWx0IjsNCj4gIAkJcGluY3RybC0wID0gPCZwaW5jdHJsX2ZseDZfZGVmYXVsdD47
DQo+ICAJCWkyYy1hbmFsb2ctZmlsdGVyOw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9k
dHMvc2FtOXg2MC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtOXg2MC5kdHNpDQo+IGluZGV4
IGZiZGRlM2FiMTA4Ni4uOGY0NDg1NGRkOGZhIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290
L2R0cy9zYW05eDYwLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtOXg2MC5kdHNp
DQo+IEBAIC0xNzcsNiArMTc3LDE1IEBAIHNwaTQ6IHNwaUA0MDAgew0KPiAgCQkJCQlpbnRlcnJ1
cHRzID0gPDEzIElSUV9UWVBFX0xFVkVMX0hJR0ggNz47DQo+ICAJCQkJCWNsb2NrcyA9IDwmcG1j
IFBNQ19UWVBFX1BFUklQSEVSQUwgMTM+Ow0KPiAgCQkJCQljbG9jay1uYW1lcyA9ICJzcGlfY2xr
IjsNCj4gKwkJCQkJZG1hcyA9IDwmZG1hMA0KPiArCQkJCQkJKEFUOTFfWERNQUNfRFRfTUVNX0lG
KDApIHwNCj4gKwkJCQkJCSBBVDkxX1hETUFDX0RUX1BFUl9JRigxKSB8DQo+ICsJCQkJCQkgQVQ5
MV9YRE1BQ19EVF9QRVJJRCg4KSk+LA0KPiArCQkJCQkJPCZkbWEwDQo+ICsJCQkJCQkoQVQ5MV9Y
RE1BQ19EVF9NRU1fSUYoMCkgfA0KPiArCQkJCQkJIEFUOTFfWERNQUNfRFRfUEVSX0lGKDEpIHwN
Cj4gKwkJCQkJCSBBVDkxX1hETUFDX0RUX1BFUklEKDkpKT47DQo+ICsJCQkJCWRtYS1uYW1lcyA9
ICJ0eCIsICJyeCI7DQo+ICAJCQkJCWF0bWVsLGZpZm8tc2l6ZSA9IDwxNj47DQo+ICAJCQkJCXN0
YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICAJCQkJfTsNCj4gQEAgLTQxNyw2ICs0MjYsMTUgQEAgaTJj
NjogaTJjQDYwMCB7DQo+ICAJCQkJCXJlZyA9IDwweDYwMCAweDIwMD47DQo+ICAJCQkJCWludGVy
cnVwdHMgPSA8OSBJUlFfVFlQRV9MRVZFTF9ISUdIIDc+Ow0KPiAgCQkJCQljbG9ja3MgPSA8JnBt
YyBQTUNfVFlQRV9QRVJJUEhFUkFMIDk+Ow0KPiArCQkJCQlkbWFzID0gPCZkbWEwDQo+ICsJCQkJ
CQkoQVQ5MV9YRE1BQ19EVF9NRU1fSUYoMCkgfA0KPiArCQkJCQkJIEFUOTFfWERNQUNfRFRfUEVS
X0lGKDEpIHwNCj4gKwkJCQkJCSBBVDkxX1hETUFDX0RUX1BFUklEKDEyKSk+LA0KPiArCQkJCQkJ
PCZkbWEwDQo+ICsJCQkJCQkoQVQ5MV9YRE1BQ19EVF9NRU1fSUYoMCkgfA0KPiArCQkJCQkJIEFU
OTFfWERNQUNfRFRfUEVSX0lGKDEpIHwNCj4gKwkJCQkJCSBBVDkxX1hETUFDX0RUX1BFUklEKDEz
KSk+Ow0KPiArCQkJCQlkbWEtbmFtZXMgPSAidHgiLCAicngiOw0KPiAgCQkJCQlhdG1lbCxmaWZv
LXNpemUgPSA8MTY+Ow0KPiAgCQkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiAgCQkJCX07DQo+
IEBAIC00NTYsNiArNDc0LDE1IEBAIGkyYzA6IGkyY0A2MDAgew0KPiAgCQkJCQlyZWcgPSA8MHg2
MDAgMHgyMDA+Ow0KPiAgCQkJCQlpbnRlcnJ1cHRzID0gPDUgSVJRX1RZUEVfTEVWRUxfSElHSCA3
PjsNCj4gIAkJCQkJY2xvY2tzID0gPCZwbWMgUE1DX1RZUEVfUEVSSVBIRVJBTCA1PjsNCj4gKwkJ
CQkJZG1hcyA9IDwmZG1hMA0KPiArCQkJCQkJKEFUOTFfWERNQUNfRFRfTUVNX0lGKDApIHwNCj4g
KwkJCQkJCSBBVDkxX1hETUFDX0RUX1BFUl9JRigxKSB8DQo+ICsJCQkJCQkgQVQ5MV9YRE1BQ19E
VF9QRVJJRCgwKSk+LA0KPiArCQkJCQkJPCZkbWEwDQo+ICsJCQkJCQkoQVQ5MV9YRE1BQ19EVF9N
RU1fSUYoMCkgfA0KPiArCQkJCQkJIEFUOTFfWERNQUNfRFRfUEVSX0lGKDEpIHwNCj4gKwkJCQkJ
CSBBVDkxX1hETUFDX0RUX1BFUklEKDEpKT47DQo+ICsJCQkJCWRtYS1uYW1lcyA9ICJ0eCIsICJy
eCI7DQo+ICAJCQkJCWF0bWVsLGZpZm8tc2l6ZSA9IDwxNj47DQo+ICAJCQkJCXN0YXR1cyA9ICJk
aXNhYmxlZCI7DQo+ICAJCQkJfTsNCg0K
