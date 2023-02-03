Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0B1689851
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjBCMLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjBCMLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:11:05 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030E19E9DF;
        Fri,  3 Feb 2023 04:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675426225; x=1706962225;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=u3WIVkog6cgss/wuAM17yCI/a83aktffWyR8XRxJRls=;
  b=liiXR6ieBktSrb+fQVZKmTmHgQLgwtXK7FLC+9FWJME8utPozi0n0Gf7
   Q8sEjAGjwtDG/3B3OGc6iABbanQ/2C8wKVoI+1RXOwxF0IzjMkSBKYAVm
   x8v6lOgzbD8LdZSf2um04cwDD0QsvX/GYxcqIe+M8ovhRSuc4OHPDVFoR
   uqo1NvKEQwRBUtenq3G4y8j+yq15LFtj3X730qHeoV6VqBcl55rhQwSPH
   ve19aWtWCe4RkbiMHqTbQlk3D0kojnNu0qe4byT4N3zHxoDhmv7LN41tJ
   Fz3e21WcGC/Y2OkRSZ6F8j6U1PISJP1C9hund/oXL2UHgK0JUW91y9vAT
   g==;
X-IronPort-AV: E=Sophos;i="5.97,270,1669100400"; 
   d="scan'208";a="135422875"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Feb 2023 05:10:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 05:10:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 05:10:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNFQJNY9/o/LiUQmdaCCDhb8R65j+2OcIX4QdhKRZA5/TRwS24v/pOz1vae4GhF3VYVrLlcMaBKUs6sO/6vXTju3iVbjDNSRSrif1j0COYVrD1GYCy5vuwyFdwzxdO4b4w4UWi2ww7vhv8n3e2FERfe6QK/zZYPDAakSXHlevbd3eEWuw0AgEkbbH3SfPvovJuO9OhXFV868qDeZ6/oy05yOHHPRsWSFwU7IsbDcrXx14Rp5pB0+lW1AfZ9r2slj5Kogh4wNgTZMBMZVzXQGtg6XXBZHJKUPIsDhjBwr7JWLT2bBb5OxgICBWW+LjApihC1dSoo65/IxNO8oEy2Z9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3WIVkog6cgss/wuAM17yCI/a83aktffWyR8XRxJRls=;
 b=PFQwB6j6eRedDVUBj/MYJWvAJdMEhLAG0YkmITCmb9Qmajdtri0doX2Gul5savB0+bvgRt0YlrKbMRAgxjtE6gdg2bKr1OLIV/uiaQWlepXXq3kluGMzMEflZH92UAQG2g8iUNhRhnArZ7dTfJXnELSbUbNDWrDOmlFS3j7AIYS62+EAuMPnXPGhMLk/w3v+9PqavaPpapeflBKk8XVo5koHmIKqBsN1Y4Jk4SNEkIRCzwBXo16kjHN6rRoYyBeJ4luWOJSBP0jUAbL4dRlNlPlFOOY2Y+UcU4vz4Fbe0ktmMxFiYAF9ArNgQ5rMSuHpSTJhaQhxm6HMa2WOitZ/6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3WIVkog6cgss/wuAM17yCI/a83aktffWyR8XRxJRls=;
 b=JzJLBXPfCMbEEoTsvnp1CLIHMHtxtUM5CvDa8CqNSgaC3obyVbVnHnyJoCbvRm8wrixC8VKiRGCf+lrJKWgwnvDK20sGSTDswzcSA1cz5CicBjbBPN45tPz+5hLTdqhH0UK+34MhYqrxrqEUrSglQ9MS0NDJ/gekf4XH0pO5hYs=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by IA1PR11MB6148.namprd11.prod.outlook.com (2603:10b6:208:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 12:10:04 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5%9]) with mapi id 15.20.6064.031; Fri, 3 Feb 2023
 12:10:04 +0000
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
Subject: Re: [PATCH v5 7/8] dt-bindings: arm: at91: Add info on sam9x60
 curiosity
Thread-Topic: [PATCH v5 7/8] dt-bindings: arm: at91: Add info on sam9x60
 curiosity
Thread-Index: AQHZN8hyIy0sktRa1E+j7yQYSMEMtg==
Date:   Fri, 3 Feb 2023 12:10:04 +0000
Message-ID: <5017db70-e71b-70a5-f9d9-0f772119b69e@microchip.com>
References: <20230203034833.451461-1-durai.manickamkr@microchip.com>
 <20230203034833.451461-8-durai.manickamkr@microchip.com>
In-Reply-To: <20230203034833.451461-8-durai.manickamkr@microchip.com>
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
x-ms-office365-filtering-correlation-id: 90319c17-8ae1-4af8-8e70-08db05df957c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: siGD+7d+g1/7A9923AthOLLnI96drNiU4jdverP18p+W62qEgXnx+qam555Zz6iW4NzR5dkotudw+TdXsJc9bSojxiulLCg3jQnCvYKiVqCGN2tnL44rjr8A6HBlBIKRThhzyHR6FPwQ9um3ZWxwE1yROAwTXq5HRatrd8MXPexXRh1wb4kqFv73p76mbEWKXNTyWRKW6OyjQfvHLEbMhn0GzAwlLjmWhIePcc/Slq5d8OR66/1eoI5mmZeyrn63UwACJqlBxaYWXHrOtVPwYU69EuUt+7zmyqI0ZGvma9Cq3CYiQZwWhVdbzkc9hx5iaw6ZzfjiPKsSLn+QdwssL64V4pGqw7MYspfUVvRN5iLlVONIJrhahdZpLiWqRgZ+qtuNRAPKibEIy4chRAXNNlPX6fUA7AKxh7pNWJFyUcRlaSPz5D0CqieCTMB7QxBZM1TTWR72aYD6eLfs0Bgwled1LU9Bw3JHmsOc0gPWQp2P1lvrouWY9H7EHPjp2R72DlBSdkAMz9TbPQ6CWl3q9JfRRs1SuX2ARu1YqHPPLDnmG+3ZW892yJLWwY1L+ISLWguE4LwHm0/lz50AYkQi3NCZd6AvHrFCrpafJDX7EB4B0dzPkqmu8O3MFST+62gKVgh6+KAtmV7rexNhIvHzIlBQrKgkFP0ce0ZL/SQ7pUcI0PTDSaitkFZuM6mCBD2302/5/cwadA1s9Pl+bAfSl466d4Q0+TdVnTbogM/o7yZcYaDfenkHrIpsCrG8a+lpOVj+PUhw0bKw7Nf2V/mo3ce05EMu115vMxXnz3jksKE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(66946007)(76116006)(8676002)(6506007)(6636002)(6486002)(478600001)(26005)(110136005)(53546011)(6512007)(36756003)(316002)(186003)(5660300002)(86362001)(7416002)(2906002)(91956017)(41300700001)(66556008)(31696002)(66476007)(8936002)(64756008)(71200400001)(66446008)(2616005)(83380400001)(4744005)(38070700005)(122000001)(921005)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2kvK3dKLzIxSTFvZVE3ZHRoYUUzYjRQbnA1VCtYM2tWbzJsZ0dWU0FvaWVm?=
 =?utf-8?B?UGtFQWlYUi9LOWtwT0pId2JsLzBWR1JmOUxUVlFnakFQNWpRL3gybHZYWXhS?=
 =?utf-8?B?U3JWeGRQTFhzWkwxK2srVnZHQSt0bkN1Z3RpOU1jY0dqV1Y0N0xPNW5uanMw?=
 =?utf-8?B?QmpRWjhjUEFOSUZMdFEzTWhwT3dNUjV4MTNzUWpVeGpnK09MaGdsU0pjWmt5?=
 =?utf-8?B?Vm5VOElsS0UreWI0bzB5NzlSV242Wk5iY2x0eHlvSVJBU1NJNjE3RDE4TW1z?=
 =?utf-8?B?QTdWZm1TdmNWbjZ3Nlh3azdBNlZkSkVrQ0NkQWJ1L2hCWDVkYnZHMER6OEox?=
 =?utf-8?B?bUU3dDhoaDdMcUNZLzl0SG1xclFDdVpvMDArUGY1dHl4eHBhbjBNTFJsNWlM?=
 =?utf-8?B?a3UxR2RpeDc3clNKdS9maWlVakFrZFUyOEJBTnNsS2J2T3Q5R2hHMmRrdnR0?=
 =?utf-8?B?bU10ZTNOR20xOTNWS1paN0t4dmpvTEhtbTd3YVZ5TDBZM0dXWitsd0hXK2pK?=
 =?utf-8?B?VFJ0ajYzOFl4ajI4YVM3dTUxSFJWbHpJWXlNUnNVNXcrRnl2cEFhVXdJRnRl?=
 =?utf-8?B?dkxxaHVjM2h0Uldkdlp3K2trNDlYU2RCK1dvK1F1RUpzdmlqSjQrdGQvWDZ5?=
 =?utf-8?B?QXVXWnhOS3ZuaTJnMXNnaHVnVEtrdEJkdDFPcmpvUGNqYU0zM2dpZE9yNGUz?=
 =?utf-8?B?dHJrdmpUSVBEeUhjVDFLK2cybzF3dE95bXVnSWFXUkdMSzRHTDA1M0QwNlRQ?=
 =?utf-8?B?V1c1Q0pNNzNIcnJabjIwVHNSZmx0aytuVkMwZDJDaHFnUEMwMll3WjdSaE1y?=
 =?utf-8?B?Q25ET0VLbVVyRnplNWFURzNLbGozM3M3c0NaL0REMkwzYXhIanN4Z0VvVUlp?=
 =?utf-8?B?elBSVzR4SXpBRnY3bTRnYS8ybnk2UlFHUC9kSjZaSS8wYzNyVEg3NzdTc09Y?=
 =?utf-8?B?WGI5QlpzcEpQTzlWQnJLbFg1eE93clFWRmtpY3ZIYm1ZUEpkbE5aVnp6UGJ3?=
 =?utf-8?B?YzhUV2pjV3RVWlZZNmV6dVh6T0d0bFJWWThtaTR1NlZwVEZ1R1hjR0gweWpJ?=
 =?utf-8?B?ejRWL1hZc29lMVlUT3dxTHg1WTg4bWFyenlKcGtFaVFDa0gyZmV2Y0Q0ekpt?=
 =?utf-8?B?eWN3ajhmUVNLMkJ6czNPOHpIYXBLNENGRVdac2QrK2JmSGxYUzd4SG91UG41?=
 =?utf-8?B?N0NvWmNGdUdSR3JZSjR3dDNPQ3VWNkVkcXRnS1c0OS81ZTI3WkFaNm4yTWx2?=
 =?utf-8?B?U2ZGWlJubjdXbGRXTnAyWmpMWGpxYmp3YkRFWlZCalpyalF4MFpzbzNucU1s?=
 =?utf-8?B?WGVGM3lkdThFMWRRN242OWpoOEFwWFdUSGFVdGMrK0RVYTcwRWg1UWNxYUU1?=
 =?utf-8?B?Ukh4ekphQzRFUTg0UHFmM3E4S1Z4Uk1xN2hqejVKM3VvMEp0N3FkVnB5QVd6?=
 =?utf-8?B?OFQ1MFBQR1c0eFovVlhXckRtWmowRVZsWGpEU2pFU2tEV1FNZ2JpdXo4cyto?=
 =?utf-8?B?NVZBY3NhalZpYk5RZ0dtcHNuWnJscFRRUVJRVm5TakViY0JCSi84VHV4cWd0?=
 =?utf-8?B?QkR1dDM2T3hrbEpUanlLNzJZOVhjMWdFRjZMY2VXVjJsb2RpWTkySTJpd05R?=
 =?utf-8?B?bisxZitXZm9ab2VaU3ZIYTJDR0NockU0emlCOXJmcHQvNytOSW04MlBCajJp?=
 =?utf-8?B?NVBhWEIxa0pQZndlaSt2ZHpNTlliSjRuS05xVlVLZHd0S1l5MDJ1dWJjYjk5?=
 =?utf-8?B?ZkpDbFB6cTBmcUE5R1BpOFdvcFZncXg0TUF6aVdoUnFKUHB3SGRIRHc1cWJs?=
 =?utf-8?B?TTZlRWpielNsc1JqME1Mb2trdDBVWXJOMUFUNE5rN3Q1ZDZEeDRpUTJCRnpJ?=
 =?utf-8?B?UE5XdlZMWXJEWXM1S0h4ZkdDdnRDUUZkVnNlOVc3WjJQdEsvKytiU3ZNK284?=
 =?utf-8?B?TmR2SXRHM3FDM3ZFN1k1aU9IZitqb0xuL1JYYzM2aDdtUkRFZVRkL0JLUVM5?=
 =?utf-8?B?UjlKTjIxZmMyNjhvOG1vMUV2R0lPYW1kSmN5a2FyWnhNazN1MXR4NHpVN2hy?=
 =?utf-8?B?ZWx2MEZFSlBOclhPWGpocHpvdmFKeGtWUURsbGdHb1MxWEo2d0Z3OVdQSURD?=
 =?utf-8?B?VGpvWXE0UkRybm02WGR2a2QzZHFGblRqR09LbUN1bXcrRUk5ODRVSVZaeVdS?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <457FE5DAF056E1469E9A8574351B70F7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90319c17-8ae1-4af8-8e70-08db05df957c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 12:10:04.6714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NWMHV/8Q9G1Ymn6MKugxl6MtMg5HT/CoKJuP4cA8sicEohU/a40kFDTJBHJieEdB1gT2W7LNiJTZnbpgndWtaZZgUbiC3T0A3OOJd1zao8s=
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

T24gMDMuMDIuMjAyMyAwNTo0OCwgRHVyYWkgTWFuaWNrYW0gS1Igd3JvdGU6DQo+IEFkZGluZyB0
aGUgc2FtOXg2MCBjdXJpb3NpdHkgYm9hcmQgZnJvbSBNaWNyb2NoaXAgaW50byB0aGUgYXRtZWwg
QVQ5MSBib2FyZA0KPiBkZXNjcmlwdGlvbiB5YW1sIGZpbGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBEdXJhaSBNYW5pY2thbSBLUiA8ZHVyYWkubWFuaWNrYW1rckBtaWNyb2NoaXAuY29tPg0KDQoN
ClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNv
bT4NCg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXRt
ZWwtYXQ5MS55YW1sIHwgNiArKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1hdDkxLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLWF0OTEueWFtbA0KPiBpbmRleCAyMjI0YjE4ODAxYTEu
LmRmYjhmZDA4OTE5NyAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2FybS9hdG1lbC1hdDkxLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9hdG1lbC1hdDkxLnlhbWwNCj4gQEAgLTkxLDkgKzkxLDExIEBAIHBy
b3BlcnRpZXM6DQo+ICAgICAgICAgICAgLSBjb25zdDogYXRtZWwsc2FtYTVkMg0KPiAgICAgICAg
ICAgIC0gY29uc3Q6IGF0bWVsLHNhbWE1DQo+ICANCj4gLSAgICAgIC0gZGVzY3JpcHRpb246IFNB
TTlYNjAtRUsgYm9hcmQNCj4gKyAgICAgIC0gZGVzY3JpcHRpb246IE1pY3JvY2hpcCBTQU05WDYw
IEV2YWx1YXRpb24gQm9hcmRzDQo+ICAgICAgICAgIGl0ZW1zOg0KPiAtICAgICAgICAgIC0gY29u
c3Q6IG1pY3JvY2hpcCxzYW05eDYwZWsNCj4gKyAgICAgICAgICAtIGVudW06DQo+ICsgICAgICAg
ICAgICAgIC0gbWljcm9jaGlwLHNhbTl4NjBlaw0KPiArICAgICAgICAgICAgICAtIG1pY3JvY2hp
cCxzYW05eDYwLWN1cmlvc2l0eQ0KPiAgICAgICAgICAgIC0gY29uc3Q6IG1pY3JvY2hpcCxzYW05
eDYwDQo+ICAgICAgICAgICAgLSBjb25zdDogYXRtZWwsYXQ5MXNhbTkNCj4gIA0KDQo=
