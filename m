Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5C46388D9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiKYLfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiKYLfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:35:05 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214DB1BE8A;
        Fri, 25 Nov 2022 03:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669376105; x=1700912105;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LGjpOFPzJ2A7suaUxkzKL6ayi16BDIcqMUI7RYIuw5c=;
  b=uo5cFYOlnLXjtVJcMchkC0/GwYYRfDfxho6gJQYOBfFvgV5jbEBhRvEl
   gGSn2yWywkHFAQ5j9FxD/FxfarR9UH3Gb3JiWZ17z65F7AAMdUnKeF0PP
   PgLuD7KlJ8jjAw5FG7dEWCxHFDzYojz9hbvbBTrTQ9tBy/S58kSLN0S6l
   5+i1twPnzMITpfdta01BLS1PM8B+4bfQY5EQosZM5jkXYaT4xx5BCXI9b
   y8mXJaWvcMT0fVw+NDFd7BJUhjurEl5PSApYudbcg5AgoaZ86GqQVdftk
   Lp9e7QLiLURHWKufYfmr4Q4gKzXIx8b+Uul6LR62EudDWtr6OfI9odRoK
   w==;
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="125087066"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2022 04:35:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 25 Nov 2022 04:35:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 25 Nov 2022 04:35:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/wji8xosvgxGY8WLP56P918RtAP50Qogx2s2e0/Fg/QGoXjXa6n/87I20EJA8XPUtdjE0GqUzJvoq56KIygIODCGuq/MdicwxVaRnUSjH4c3mvwdQxLUs8fG66tehuHmBD5Q6Vresp/uzxLSIw6jsxbHDgMZ/zWA/vlQl0tcUQ7XBib+ohYKjIdx6JH/rS1DKdBC/7JcpyE+tae+I40DP8sra23VU1zSV5sv8ZX7wZIljp2dSiHYqTzvZM7mUwANCH0todfMpOUsLH+yDeeoT9UpxHxo4+dJwEcbIxOZkJeRXqAOFkN++aJbFGAKYHzJSjqWLprZ186ttX50D1ZQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGjpOFPzJ2A7suaUxkzKL6ayi16BDIcqMUI7RYIuw5c=;
 b=f8W+imgfJJCOlEehRCxDMNdwfs3j24peVdBMNkHflXa/S1vQgE1dwTh4YXUHzGXPZbye6Q4C+VH20Ty9gibDxfzJWSAS9oDHL1lCxciBH68byDNBwh5G6GxbReZZSGueljK1KgqSQBp4VHnI1qjWMWITulAPMi6ZJU2AQmBJ951Ye5YHgyMG4ozg+Hk4GDs1SqJLu6viECRLqWDhkM4smmVt7YJpmJXsF+6M5iol4ote16uVT0kp5arKTW7IwZ42JSAsY24YcgpUf6PqsOOzbUPMRuf7/PABjL0WfJnr2Y46xpe7EK7a8WQANmryOXytmqsZT0GHnU7wy1ruKhGqrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGjpOFPzJ2A7suaUxkzKL6ayi16BDIcqMUI7RYIuw5c=;
 b=hy5iRUfiZQzyCp4BGtnaBZtK9ugpuaIIHEWHC4ESgePtR6l8CePtayrNC9pRHU74q2FFoG70C8TKlCsEEYDjKuKhOS/uuFyEdobIZ5F9WwMJ8x8e9shqnhi+8lRn+YiLDq4ipmcC2g26UiGnYfTmLRGzBF269vaMW+0kUMD/Cto=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by CO6PR11MB5650.namprd11.prod.outlook.com (2603:10b6:5:35a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 11:35:02 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15%10]) with mapi id 15.20.5857.017; Fri, 25 Nov
 2022 11:35:02 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Eugen.Hristev@microchip.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: at91: sama7g5ek: align power rails for sdmmc0/1
Thread-Topic: [PATCH] ARM: dts: at91: sama7g5ek: align power rails for
 sdmmc0/1
Thread-Index: AQHZAMH0m/Yt/YtVlUahw6kdSkGjSQ==
Date:   Fri, 25 Nov 2022 11:35:01 +0000
Message-ID: <6c638ac2-3855-04ec-1f83-43b81b5aeb22@microchip.com>
References: <20221124154610.246790-1-eugen.hristev@microchip.com>
In-Reply-To: <20221124154610.246790-1-eugen.hristev@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|CO6PR11MB5650:EE_
x-ms-office365-filtering-correlation-id: b06cbd95-d48a-4d36-0f21-08daced91748
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RimhXT4mNc4VVR4x7MNIkvUT5kWLwJrprhKwDd0B6NpaD6135rmugzriu4CdbnW1+z3mm2OLRKcK9CRGW9OZ0gnLjd2nuiPp5ChOgo1KR9gT7s+zJ3XS3XUGKH7KuyyrBGP+5zp+q6va8bWtIecNQNfrdPaHLl9yAaP3jl8A0SPVgcHfUa2xNvC2gugOvzy9Qj6MpR9/pEsMjgcttuyZCkogzFXIihvP+8ClAUzb7bo70Y3e7LiHvwmX+JxLq0zDwav8vNwmXGaqT8My1rKRpjPuFqT8FvJ9DDkHq80gC1X1qMNZTjE/WCwdYzl/b87MWjeUyVy4OuAvS/+dGfkoit/b0dIJe4tATXKymWFFWk1asX4S4vw8MtfQ3OmiesYzQuozQxzOkAYNsJqbxS4eJIgwP0WRc+kWw04mVEKANG2nKgGg0aFEzMbFjRb03Y7STXx8BaHpFN9x0dTnoiv8qFWuJgbgsA4VJ5nw0czXzi37TkzqtVcCXAdCfLR7//kslAsykc3J3TFWJuBkRXYB4knRldiVxgfFIkawsSYXGdaj5HbUARc1ze+vFBuhTKXFxSBye6OXE8eKafXrCOhGQW/Q0jghoYSO6FXGkOVQWTZYPs+2ZgwchQwyu30fEcHLElwXlFnlVC5LU4ton8cdvSmpEwfQbHvu5jlAwju9LT8Qc5wR8W0WgS0CvHUs36ozeTBOVrsyQHJthhwp1R9+/qi63jhPYcYZO/zj9J/UAwwH70S1F7nizjGSCwtxrEszYi15Lr0ttN5AnPzNZuJI1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199015)(122000001)(31686004)(8936002)(38100700002)(31696002)(5660300002)(76116006)(64756008)(8676002)(66446008)(66476007)(6486002)(54906003)(316002)(110136005)(2906002)(91956017)(36756003)(86362001)(83380400001)(4326008)(66946007)(66556008)(186003)(2616005)(6506007)(38070700005)(53546011)(6512007)(41300700001)(478600001)(26005)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUMyUnkycE9idnZSZ0xUajVUYitlM3VNYU4rc0M3ZUdYVlJxa3FPem1uZmlI?=
 =?utf-8?B?bXhpOVpvSGJZK0NPVVloRzB0ZTFBbC82c1JYb3A0ZlpBQ3lla3VQcWtlM1Zt?=
 =?utf-8?B?NStNVW5UeGl1d21YbndtaE1QN3dNVEFMM3hOZzdwaWFwc1J6a1hMcERNRURt?=
 =?utf-8?B?NnVabXFTNWFTOWovcHlWSXg5dUpRbEt3SE52cDJEOWtqbGNoaTlYQi92SU5V?=
 =?utf-8?B?VGh6VmZuRVZkVzEyMkhJNUw2ZmgrVzMzZ1YvYWJZOFZna295NklWWHlveEIy?=
 =?utf-8?B?TlpUNG1aTHh0R2FJbHptM3E5REdPclltQytZcHI2R0JleTlMd0FabWdYU1pB?=
 =?utf-8?B?cVViYzZFWXM0Wk5sSUFaMm0rbktpODdoQUhBT3VCa1dMZ2xGeDNtNmpKb0xH?=
 =?utf-8?B?eXlscUVvU1RWUTcxWWoyRU9zZFl6d0FyRFp4clgrR3BmcCtjL1B2aGozeVl2?=
 =?utf-8?B?UjdJbGR6R2c0WXVocUdyK0I1MGJVeGlhbThUcDNqcVhZb3o5bnpaQ1hJZjVQ?=
 =?utf-8?B?clJZWDh6R3Vla251WmhXbmFuU24xMWM1ZFNvZTRxbEQyNkNhTHcwdWNWanEy?=
 =?utf-8?B?akoyVXlxdDJyWnNjRGZjcWhEaDBOTjJXelFSWEZ2bUNERWJ2VW16dU5iNncw?=
 =?utf-8?B?MkhiRGFqbFZtZlRWVTRaQlVHZFR6SmRmUkI3emdibDlySU0vVUdGNG1WNFd2?=
 =?utf-8?B?NDZ0OSswRXdMbVI0ekpsTE1OVTczNWJSMDVzckFKM3BkVnVLR1Z1b3EvaDM1?=
 =?utf-8?B?R1hzVTlDTS8xcWJhTzdNWGhRZFYzVlhYaDFFZVBMS1NBQTJlYmRKYTJDQTlu?=
 =?utf-8?B?Uk40ZnZndFdTZU9NQUNHWUgwby9wajNUWjRiOXFzdFFWMTVwQTF4eUduQnk1?=
 =?utf-8?B?d3ZnZEhGYTN1NERSS3A2Mi83OGs5N29FWXdPbzVMZEVFYTk2VGpXelJPVUxo?=
 =?utf-8?B?MjRMd1VoMEFzMk5qSVAzQTNBbERaSFV1YW9NcHNTblZMMEtudjFqMEpNOXMx?=
 =?utf-8?B?MHZBVi9FOExnS3lpOEVtTDhOZ3FEMFRvb0dvdE5RakZyb2hCTWRENktPblhL?=
 =?utf-8?B?SjRrNFV3UkwvZlhXYVVCckM0KzUxTEhsRWlhNWhJeVhaOGJiNEdZZ2ZQejNy?=
 =?utf-8?B?Z2dOcXNrSE05UEk1VSt5MmRwKzY4WSswRkhaV0cvU1YxaG5UdGo3VDZzbkxT?=
 =?utf-8?B?RjBoeDFNZGpNSGd1UlhoY0JIRWJtS2taUGRKQVhqd0F5MlZlMitXRGoveDlP?=
 =?utf-8?B?NXV1dEczNXlnMVN0L3ovbUIydXFab0c0eFlVYy8xUWRvT1V1L3hEbG1WUXJB?=
 =?utf-8?B?WkpmWVk5TEtWVzBGUnZoVzl1QzRGajRnM1AyNWRtcDVUczM2VVNQZ3lPT2xv?=
 =?utf-8?B?bmI5WEJBWk45ODV1SmNycUV0RUhwQ25SbGUzV3BVY3ZaakVsQlVNbVVnejl6?=
 =?utf-8?B?N0R2YjE1UkJUNHI0ejBodjFqNWhscjV5Y1Rmb20xemNtRHIwMjRjSWtiOGNs?=
 =?utf-8?B?TnhocytVWHdlSWRRekNsREFMWjR4dnU3anBrUmxQUWJOVHJ3RGhwbzI3NFBj?=
 =?utf-8?B?NzB6eDlSK29JNTJwa0gxb1dTQTVPa0kwNjY2NGVzeEtZWVRucnJLOEF3MGtz?=
 =?utf-8?B?Z09BKzlnay9aYlhOZXFyei9wNDZwZGtPbHNweVprekJiNWNLWGdsUkpQZmhT?=
 =?utf-8?B?VHRST2xvZDdyREFVTDZxN0VUajZIeWJhVFB2b1dqeUMyQnI0Wk9oL3RwaXBu?=
 =?utf-8?B?SkxnOXdWa3FhL0w0eitwMHhqVlRJQVI2UG9vdld4QnlUR3FkM2ZJMGt6aHpa?=
 =?utf-8?B?U2hDZXVhb3BRaGYrMWlnODFLNjMwVFdKeVpUVytzdnhJR0xpSFVVa2RjTzZX?=
 =?utf-8?B?U2FuTFJONWhaVmdGR0ZMMDZCSVM1emxBVSt4eldqUTJRaWwrTmRrcmVJbnVq?=
 =?utf-8?B?UnV0SjFxcmxtSmtPTHdQV2ZGRzNWdHNINkR1ZU05RFRTOXRJckE1MW8xVmFG?=
 =?utf-8?B?bitwQVpnRXMyV05kcXpvK1laNGhEWjhjZFRsSUUyamJkU3MwTG9taGEyaGI5?=
 =?utf-8?B?MG5sYzAxN3lSNkNuTW03bkJFWUgxck5xN21nVHYrclZVMk5ZYnYxQjdGUWpS?=
 =?utf-8?B?UkxuTUJjaitZbEZJeEhlYmxMZnN1eFFyRTFkUWx6aHdFRWtJaEVVeDRpWHd1?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2223B57B02B3914C8FD314280BB684FB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06cbd95-d48a-4d36-0f21-08daced91748
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 11:35:01.9857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8luaQQ+ZhE4H67MlrdQtlHyxxBEDPpSyI4wB8BqEFB6iLoOoD6SccC8fEiiAqIFBtnhvuMzGNY/1ygi/QWNMzxo5a6TUoLYQKqDweQx42w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5650
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQuMTEuMjAyMiAxNzo0NiwgRXVnZW4gSHJpc3RldiB3cm90ZToNCj4gT24gdGhpcyBib2Fy
ZCBTRE1NQzAgaGFzIGEgMS44IHNpZ25hbGVkIGVNTUMgZGV2aWNlIHBvd2VyZWQgYXQNCj4gMy4z
IFYgLg0KPiBIZW5jZSwgY29ycmVjdGx5IGRlc2NyaWJlIHRoZSBjb25uZWN0ZWQgcmFpbHMgZnJv
bSB0aGUgUE1JQy4NCj4gDQo+IFNETU1DMSBpcyBjb25uZWN0ZWQgdG8gYSB2b2x0YWdlIHN3aXRj
aCB0aGF0IGNhbiBjaGFuZ2UgZnJvbQ0KPiAzLjNWIHRvIDEuOFYgYnkgYSBoYXJkd2FyZSBjb250
cm9sbGVkIHBpbi4NCj4gSG93ZXZlciBTRE1NQzEgYXQgdGhlIG1vbWVudCB3b3JrcyBvbmx5IDMu
M1YgbW9kZSAoZGVmYXVsdCBzcGVlZCwNCj4gbm8gVUhTLUkgbW9kZXMpLCB0aHVzIGNvbm5lY3Qg
dGhlIHNpZ25hbGluZyB0byB0aGUgMy4zViByYWlsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRXVn
ZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KDQpBcHBsaWVkIHRvIGF0
OTEtZHQgKGFmdGVyIHJlc2hhcGVkIGEgYml0IHRoZSBjb21taXQgbWVzc2FnZSksIHRoYW5rcyEN
Cg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTdnNWVrLmR0cyB8IDUgKysr
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE3ZzVlay5kdHMgYi9h
cmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE3ZzVlay5kdHMNCj4gaW5kZXggM2IyNWM2Nzc5NWRk
Li5hYTVjYzBlOThiYmEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2Ft
YTdnNWVrLmR0cw0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE3ZzVlay5kdHMN
Cj4gQEAgLTc2NCw4ICs3NjQsOSBAQCAmcnR0IHsNCj4gICZzZG1tYzAgew0KPiAgCWJ1cy13aWR0
aCA9IDw4PjsNCj4gIAlub24tcmVtb3ZhYmxlOw0KPiAtCW5vLTEtOC12Ow0KPiAgCXNkaGNpLWNh
cHMtbWFzayA9IDwweDAgMHgwMDIwMDAwMD47DQo+ICsJdm1tYy1zdXBwbHkgPSA8JnZkZF8zdjM+
Ow0KPiArCXZxbW1jLXN1cHBseSA9IDwmdmxkbzE+Ow0KPiAgCXBpbmN0cmwtbmFtZXMgPSAiZGVm
YXVsdCI7DQo+ICAJcGluY3RybC0wID0gPCZwaW5jdHJsX3NkbW1jMF9kZWZhdWx0PjsNCj4gIAlz
dGF0dXMgPSAib2theSI7DQo+IEBAIC03NzUsNiArNzc2LDggQEAgJnNkbW1jMSB7DQo+ICAJYnVz
LXdpZHRoID0gPDQ+Ow0KPiAgCW5vLTEtOC12Ow0KPiAgCXNkaGNpLWNhcHMtbWFzayA9IDwweDAg
MHgwMDIwMDAwMD47DQo+ICsJdm1tYy1zdXBwbHkgPSA8JnZkZF8zdjM+Ow0KPiArCXZxbW1jLXN1
cHBseSA9IDwmdmRkXzN2Mz47DQo+ICAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gIAlw
aW5jdHJsLTAgPSA8JnBpbmN0cmxfc2RtbWMxX2RlZmF1bHQ+Ow0KPiAgCXN0YXR1cyA9ICJva2F5
IjsNCg0K
