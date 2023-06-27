Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475B873F392
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 06:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjF0ElV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 00:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjF0Ekx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:40:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4DD1BDF;
        Mon, 26 Jun 2023 21:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687840702; x=1719376702;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=9TtTIp2fm24jd+nu6gFby368Q/hLAz2g5+K2dHHQfaY=;
  b=T+dz/RyxqWQoWesWgUDOSMQdev2mGfyho0uaF9LBB7JtZ1M0rE9+5iwX
   LOeQhP7BZnQFjBAVHYJ23XXPM4s5UJ0OPB0sQaoEGQwHiI8v2yGT8LN/Q
   8vs0rLfMKKN5VrYLIGsbYr0wNJsqgxXnFi5hvK9DUclon+n9k5EcBFPN9
   mXbdbDRIEtKQ476VaeqvitBncrkQ1nHfdTzfJU93L3wV+IvRsny/C8HHI
   jexrHd1Z090Ev1GXSq1SAI6vFDVoRfJUDFePlGLZJxZHL0agziQXrnu55
   JM2Y0jgHk+hKi7cb7A4AtenUhuXRX1LRMrhs+DIZJ3p7ZFNAdvEu/l4rN
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="222074208"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2023 21:37:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 26 Jun 2023 21:37:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 26 Jun 2023 21:37:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSbMAknZM1dWzuwpX/8ny6wIfUdVd2uGZOVupdjZoM/w9n0rAoRuhIAUtTFFOdQzgSYGALJWtdHKbH+iQM7fxwTc4c0kWdS0WFY0yaiVK/mwYiXLslzQT9kgpm8RVWWSmLmLRuF0oYN5z9iq1aJRhgzMTVQkC7FyizsurMEmjtgiZvw95p58yeE7nJDwQjqgQDRGNvobeEaoCcAWwRpJ1Cfhz7zKtavT++KM5U7ZWvR8Zoj625eXu+vY22j+AYkEAAx+MtJPAAYZqo/Q27vxX7XraYypHn/xIzd7bG+FgOyjbmhlRse6JO93982xvN26Cx7B/8MUPQ1RWczUEP6qZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TtTIp2fm24jd+nu6gFby368Q/hLAz2g5+K2dHHQfaY=;
 b=H82b9b1G1qxZ+UzegE0fTAiyqowDTMU6JZesrFDC1iUPEs/jVTJBtdx7DC6qaeunqA1d1IpQHkrmHPzpkcxLo7TE+LIhev1l5qYYXE7o32lso7NC+7FIcSDwcwCALAd0n7NfYhKSfED1IlzJ0DXyB8+7tjY3n199KNi6UDUgv8eNL9KizjmpeY8WQko1gyKHbZ5EP+SkYQ4YMzF0fSR3PWwRkVefSnPfJPUJ32L3p27wN3Ulmh+UkphfYVJT13KUshsRc+KbpRqt12oBGAQ+rLS/3IavoCJyUuZCRN40BRTSWYtQMpqf5Xub4bA6Yt/Rl9HYufkczGNj3SUkDWoA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TtTIp2fm24jd+nu6gFby368Q/hLAz2g5+K2dHHQfaY=;
 b=uV7T705DW1nTEE4bLvWj6rFAeTeG8ilPpkVHfAg+Q8SD/Exe2Y026c08KgPwhTV0Vczy0Zin8B8WlApo7UVnk3DSCx0pa9gpB6pwh3KK7OUldFsMaLP5/f/w4m/fJsHaR6x8fVFlZftGXMrfgmX/O5mqxXL3kmDSP5zt8oglVQQ=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by DM4PR11MB7397.namprd11.prod.outlook.com (2603:10b6:8:103::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 04:37:14 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6500.031; Tue, 27 Jun 2023
 04:37:13 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <maso.huang@mediatek.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <trevor.wu@mediatek.com>,
        <jiaxin.yu@mediatek.com>, <renzhijie2@huawei.com>,
        <allen-kh.cheng@mediatek.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 2/7] ASoC: mediatek: mt7986: support audio clock
 control
Thread-Topic: [PATCH v2 2/7] ASoC: mediatek: mt7986: support audio clock
 control
Thread-Index: AQHZqLEL542/gfVceEKSfNM3JzvzFA==
Date:   Tue, 27 Jun 2023 04:37:13 +0000
Message-ID: <455446f5-818b-8fd0-0308-3e3f9096bbd3@microchip.com>
References: <20230626023501.11120-1-maso.huang@mediatek.com>
 <20230626023501.11120-3-maso.huang@mediatek.com>
In-Reply-To: <20230626023501.11120-3-maso.huang@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|DM4PR11MB7397:EE_
x-ms-office365-filtering-correlation-id: 501ccb00-6f75-421b-d206-08db76c82d95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qVuffYjGVTSjVJwiaX6a2+LDuQGJDrHr/pJqIRp2g1fKr59zCyyBSwBs1o1Lo3Ez2LauF+cv7zUz/dCPUfxd1IUrDziZ/2N6bcYnIVKyveNT52XIZNBN/XBbvpdp8gO0MoRAu3u4tgT/8lGgJvEGNd1+XhLNCsT8vM6mA5+ANADRxAKftcvdtL+cKoYuVPedqwJYb5l7RpUS1i+mbBFBJoVPkxzCl1OrsE64y0zVBr+CqMlkAEJF8r7tUtyHIW57vy2wtQ3NDFR5n8WZFNAZ+3JbHjYT+rUN8ynpj2rLd/5lqXFIviv1pa/hpQ/v9L7AJRZJwyIfarzI3GN8NFSFVIBzItmS78KSHjpYMSX5tTWb9HsfsdLacWf67b0AF6E6tB2KKm3nHAhUp9IzzhZwNflxWndcP5qo+0ZVNGn2SS/sIisgoZKJ/amFLiDwBaYY7DM0xv1IPuTgg5yyPdkgBVq9TS9OvrPThmriGNfHlQUOIVXWnAENkPRi10quZF/Nt+9BHK02ueV1ouOc3nx407JTkmzwM5Le8PSfwmzq8gLuYXpzGeuKfz8nCfJBRgQAzoWhbGuVNIGWoOmOZSuRI1897R9eDKyH7EAPuqb6RwHAfBZtTb1nhGms7nAtq2i2zyUQ/I0E1f+dojOkrj9/BTbGoDe2pY8YQTd0TRRzfr/Th70Tsip4Ki1W99BSu60V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199021)(6512007)(6506007)(26005)(110136005)(91956017)(66476007)(76116006)(66946007)(66446008)(921005)(122000001)(64756008)(66556008)(38100700002)(83380400001)(966005)(6486002)(478600001)(2616005)(71200400001)(2906002)(36756003)(53546011)(316002)(41300700001)(38070700005)(7416002)(5660300002)(8676002)(86362001)(31696002)(8936002)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmlXV1phS3dzTmxZYjAvcmI3MDh6eUVNMmIzZ0JjZzdpUkNtSFJ5N3ExbjVh?=
 =?utf-8?B?S0hHR3lHZytZajNJRmNZd2NDcXJvR1BrVk5zdzVDUjRzWUlZTzRpYWg1eWdE?=
 =?utf-8?B?OUZ6TzhneS9oeG5RQ0dvbWJPVkIvRWNRNldjdWFpVEdLM0tYSjFiUGlLM0pT?=
 =?utf-8?B?Sk9SbUdFakQzTHdiYzBpR2hFU3lmaEFncElZOVlueVVhd1lLR1hNWUhjUUdh?=
 =?utf-8?B?Y2R3RmpkUytROG1KekV4VWNXbEREcDIvVktQNFIyUkZyUFJhek5xblV6Y0dR?=
 =?utf-8?B?QTlvS3JXdmJ2QU1qZzBwR21HblhNeGM0NFo5YVBWV2d1RzlUOHZDaUlTRzJP?=
 =?utf-8?B?ck1iZ2p2T2FSc0wvbjl6SnpZc3diL3hvV0RMcmFVQ3V0WXlFMEdueHk3dEtZ?=
 =?utf-8?B?amRRd294RFViKzZwU0xIMFlMU0ppYWNveFA4TVhuVnZxdnVoaFZzL1pjUm5B?=
 =?utf-8?B?UmlGMk52ei92TVJRM3hrWTd2Y2g4UlFjOEZHaWhiWkVQOEw4TW1nV1BqUk8z?=
 =?utf-8?B?NkJRR2Y4dHhHZTZLVUJnYVBMRmFlVmY3N2dlNllYWEhlZU01cExJOUUrekJj?=
 =?utf-8?B?RHJRb0JoUS9WQlFITUhEMGloRDJXVDVySEhFSmZYQmVCTSttRDJSeEx4bnpP?=
 =?utf-8?B?UTdhZlBSNHFsbDNCZzhVRHZMdXdSeDdvaXd1OTNtQTdqM0tyZ0dCNVdtNHpi?=
 =?utf-8?B?U3pUbVJBcHZUSGJMRE1tNzUweUNzQW5FdTJ0ZXNIVHNqd0VUMERVQmtaUVgx?=
 =?utf-8?B?RzRFNitoS2c2TzIyeE1IZmM4a256blFUWnA5MXVaeHNlQTlCUzhQTE41ZVNG?=
 =?utf-8?B?TzhqMEpUaHJOSkxSYkZuSU1nME9MTGxYeEhLdXdNeXBWK2ZUUys1RXJNaE1m?=
 =?utf-8?B?a1V1R21ETktDSVdjbFl1UWxxQXFaeEdyanpBMUlYQ0J5Tlk3Q1BUNlNxQU5l?=
 =?utf-8?B?UmxPUE10ZWxYeXBpWjNIQWhIM0NmdERGY01TS1VoY0Z6VUEzMmFUL1hxMlQ5?=
 =?utf-8?B?aGpuazM2SHVsL1gxemd0dE1SMC9BQ0tXeC9oMFRVYVdqR2hOVk5VTTZyK09n?=
 =?utf-8?B?T3AxNXMyclJMVjMxcFVjbnBjZmt6bjBHS0RFQ3dkMDVQczRGSVZUMjl4cTZH?=
 =?utf-8?B?Z3VvZkRML1g1cHFqSmxDTVZrU1N3cmV6Wi9aOWhJUHBZOWpZUnQwWWZEOGhX?=
 =?utf-8?B?V2tqdHVhZ291OStUZnZCUDh1OHRNT0RhTkdGMng1UW56emdTK1ZtbGM2NXJE?=
 =?utf-8?B?WFRkZGlXZnduVmQ3NzlJZDMrYnlRU2dCa3d1YWwxanNiL0l6QWJIdzV4U0JZ?=
 =?utf-8?B?MWVDZm53Q2VpZHd0ZERLSm1tVVFONk1PYnhDR0Y5SFhmTkloRTMrbktzRG9k?=
 =?utf-8?B?QVE3c2tETTg4QU5CTUg2RU5UbGh1aHV5enVWdzFBRXFraGhPVXl3c1VRU3BB?=
 =?utf-8?B?cytuZWk4WkY3SnE5KzJQSm12VGRaZit4YzdUcnJPamlhNFA4cVBKUEZUaFUz?=
 =?utf-8?B?ZUlBaWd5RU9NazFJTTR6dzUyd3F6dldIVFZ4VXduQ1RYQXhibkY2bTdwZ2tK?=
 =?utf-8?B?U2g5eE8zdnZweHBlTDlGdXFybkxnamRrWVpzczgvSzdjUncwVStwOThidjFB?=
 =?utf-8?B?dmJZQ3hxY1hUV2tTa0hkWGdNQmk2SmVrTnpzZWpQTExNZGNGcS9mWk5pVEpx?=
 =?utf-8?B?U3FDbzlGT1lITDNua2RrYVJZU1V5L29kT0RHVFVTaUxzZjJSeDhEUC9EY0Uv?=
 =?utf-8?B?azQ1ZHZzQStzaWM3bjFwbXN4VHNaNlZJSTc4QUpuQTI2NlVsQXdmdFlpaWE4?=
 =?utf-8?B?cE9KNnBLUjVvWFY2M3MyblRIaDF2ODRjWFlaVEFlVTJMOEZPSXN1K3R6ZmdN?=
 =?utf-8?B?WWtmdW9DU2lkamxnQW5ndTI3V29JUXdUQzdubDVRTTk0QXBuRk1aY1gzN3Jq?=
 =?utf-8?B?bFpRTUZqNnZIam91VlZFbTd6WFVnd1VjK2FJQzJDZVFIZ05uWjNweGQ0dVdH?=
 =?utf-8?B?S3p4UU9tNUFkVTFaT1pXUDBJZFlZamhOWmJCU0RVcUx0dnJEdUU4YzYwRU1G?=
 =?utf-8?B?N1JVUTJiUTRiVkFUS1NMOTl0aGpvZTJGbkVLWjkxcFYyVC9TV1M0WVlMbC9B?=
 =?utf-8?B?aEFaL1BwbFYxZW9LN2lQTWxtOC9idnBEOEtQTm5PaGdpQVQrejN6SHM1S0x5?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A008C2A979803D4FACF218212AEAAD70@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501ccb00-6f75-421b-d206-08db76c82d95
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 04:37:13.3259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cERPVQYuOUgMHlj44eAOsovjgp2ccq/HFBtXcHhwbGjnph5icvM4NKjM8UqizmNANJcipd4Utd6UILP2dZj2pv+MeoqtyY32rV6C4ve/ERU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7397
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYuMDYuMjAyMyAwNTozNCwgTWFzbyBIdWFuZyB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgYXVkaW8gY2xvY2sgd3JhcHBlciBhbmQgYXVk
aW8gdHVuZXIgY29udHJvbC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hc28gSHVhbmcgPG1hc28u
aHVhbmdAbWVkaWF0ZWsuY29tPg0KDQpSZXZpZXdlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVk
aXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCg0KPiAtLS0NCj4gIHNvdW5kL3NvYy9tZWRpYXRl
ay9tdDc5ODYvbXQ3OTg2LWFmZS1jbGsuYyB8IDc1ICsrKysrKysrKysrKysrKysrKysrKysNCj4g
IHNvdW5kL3NvYy9tZWRpYXRlay9tdDc5ODYvbXQ3OTg2LWFmZS1jbGsuaCB8IDE4ICsrKysrKw0K
PiAgMiBmaWxlcyBjaGFuZ2VkLCA5MyBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgc291bmQvc29jL21lZGlhdGVrL210Nzk4Ni9tdDc5ODYtYWZlLWNsay5jDQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgc291bmQvc29jL21lZGlhdGVrL210Nzk4Ni9tdDc5ODYtYWZlLWNsay5oDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL21lZGlhdGVrL210Nzk4Ni9tdDc5ODYtYWZlLWNs
ay5jIGIvc291bmQvc29jL21lZGlhdGVrL210Nzk4Ni9tdDc5ODYtYWZlLWNsay5jDQo+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uYThiNWZhZTA1NjczDQo+IC0t
LSAvZGV2L251bGwNCj4gKysrIGIvc291bmQvc29jL21lZGlhdGVrL210Nzk4Ni9tdDc5ODYtYWZl
LWNsay5jDQo+IEBAIC0wLDAgKzEsNzUgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wDQo+ICsvKg0KPiArICogbXQ3OTg2LWFmZS1jbGsuYyAgLS0gIE1lZGlhVGVrIDc5
ODYgYWZlIGNsb2NrIGN0cmwNCj4gKyAqDQo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjEgTWVkaWFU
ZWsgSW5jLg0KPiArICogQXV0aG9yOiBWaWMgV3UgPHZpYy53dUBtZWRpYXRlay5jb20+DQo+ICsg
KiAgICAgICAgIE1hc28gSHVhbmcgPG1hc28uaHVhbmdAbWVkaWF0ZWsuY29tPg0KPiArICovDQo+
ICsNCj4gKyNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gKw0KPiArI2luY2x1ZGUgIm10Nzk4Ni1h
ZmUtY29tbW9uLmgiDQo+ICsjaW5jbHVkZSAibXQ3OTg2LWFmZS1jbGsuaCINCj4gKyNpbmNsdWRl
ICJtdDc5ODYtcmVnLmgiDQo+ICsNCj4gK2VudW0gew0KPiArICAgICAgIENLX0lORlJBX0FVRF9C
VVNfQ0sgPSAwLA0KPiArICAgICAgIENLX0lORlJBX0FVRF8yNk1fQ0ssDQo+ICsgICAgICAgQ0tf
SU5GUkFfQVVEX0xfQ0ssDQo+ICsgICAgICAgQ0tfSU5GUkFfQVVEX0FVRF9DSywNCj4gKyAgICAg
ICBDS19JTkZSQV9BVURfRUcyX0NLLA0KPiArICAgICAgIENMS19OVU0NCj4gK307DQo+ICsNCj4g
K3N0YXRpYyBjb25zdCBjaGFyICphdWRfY2xrc1tDTEtfTlVNXSA9IHsNCj4gKyAgICAgICBbQ0tf
SU5GUkFfQVVEX0JVU19DS10gPSAiYXVkX2J1c19jayIsDQo+ICsgICAgICAgW0NLX0lORlJBX0FV
RF8yNk1fQ0tdID0gImF1ZF8yNm1fY2siLA0KPiArICAgICAgIFtDS19JTkZSQV9BVURfTF9DS10g
PSAiYXVkX2xfY2siLA0KPiArICAgICAgIFtDS19JTkZSQV9BVURfQVVEX0NLXSA9ICJhdWRfYXVk
X2NrIiwNCj4gKyAgICAgICBbQ0tfSU5GUkFfQVVEX0VHMl9DS10gPSAiYXVkX2VnMl9jayIsDQo+
ICt9Ow0KPiArDQo+ICtpbnQgbXQ3OTg2X2luaXRfY2xvY2soc3RydWN0IG10a19iYXNlX2FmZSAq
YWZlKQ0KPiArew0KPiArICAgICAgIHN0cnVjdCBtdDc5ODZfYWZlX3ByaXZhdGUgKmFmZV9wcml2
ID0gYWZlLT5wbGF0Zm9ybV9wcml2Ow0KPiArICAgICAgIGludCByZXQsIGk7DQo+ICsNCj4gKyAg
ICAgICBhZmVfcHJpdi0+Y2xrcyA9IGRldm1fa2NhbGxvYyhhZmUtPmRldiwgQ0xLX05VTSwNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoKmFmZV9wcml2LT5jbGtzKSwg
R0ZQX0tFUk5FTCk7DQo+ICsgICAgICAgaWYgKCFhZmVfcHJpdi0+Y2xrcykNCj4gKyAgICAgICAg
ICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiArICAgICAgIGFmZV9wcml2LT5udW1fY2xrcyA9IENM
S19OVU07DQo+ICsNCj4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgYWZlX3ByaXYtPm51bV9jbGtz
OyBpKyspDQo+ICsgICAgICAgICAgICAgICBhZmVfcHJpdi0+Y2xrc1tpXS5pZCA9IGF1ZF9jbGtz
W2ldOw0KPiArDQo+ICsgICAgICAgcmV0ID0gZGV2bV9jbGtfYnVsa19nZXQoYWZlLT5kZXYsIGFm
ZV9wcml2LT5udW1fY2xrcywgYWZlX3ByaXYtPmNsa3MpOw0KPiArICAgICAgIGlmIChyZXQpDQo+
ICsgICAgICAgICAgICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZShhZmUtPmRldiwgcmV0LCAiRmFp
bGVkIHRvIGdldCBjbG9ja3NcbiIpOw0KPiArDQo+ICsgICAgICAgcmV0dXJuIDA7DQo+ICt9DQo+
ICsNCj4gK2ludCBtdDc5ODZfYWZlX2VuYWJsZV9jbG9jayhzdHJ1Y3QgbXRrX2Jhc2VfYWZlICph
ZmUpDQo+ICt7DQo+ICsgICAgICAgc3RydWN0IG10Nzk4Nl9hZmVfcHJpdmF0ZSAqYWZlX3ByaXYg
PSBhZmUtPnBsYXRmb3JtX3ByaXY7DQo+ICsgICAgICAgaW50IHJldDsNCj4gKw0KPiArICAgICAg
IHJldCA9IGNsa19idWxrX3ByZXBhcmVfZW5hYmxlKGFmZV9wcml2LT5udW1fY2xrcywgYWZlX3By
aXYtPmNsa3MpOw0KPiArICAgICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4g
ZGV2X2Vycl9wcm9iZShhZmUtPmRldiwgcmV0LCAiRmFpbGVkIHRvIGVuYWJsZSBjbG9ja3NcbiIp
Ow0KPiArDQo+ICsgICAgICAgcmV0dXJuIDA7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTCht
dDc5ODZfYWZlX2VuYWJsZV9jbG9jayk7DQo+ICsNCj4gK2ludCBtdDc5ODZfYWZlX2Rpc2FibGVf
Y2xvY2soc3RydWN0IG10a19iYXNlX2FmZSAqYWZlKQ0KPiArew0KPiArICAgICAgIHN0cnVjdCBt
dDc5ODZfYWZlX3ByaXZhdGUgKmFmZV9wcml2ID0gYWZlLT5wbGF0Zm9ybV9wcml2Ow0KPiArDQo+
ICsgICAgICAgY2xrX2J1bGtfZGlzYWJsZV91bnByZXBhcmUoYWZlX3ByaXYtPm51bV9jbGtzLCBh
ZmVfcHJpdi0+Y2xrcyk7DQo+ICsNCj4gKyAgICAgICByZXR1cm4gMDsNCj4gK30NCj4gK0VYUE9S
VF9TWU1CT0xfR1BMKG10Nzk4Nl9hZmVfZGlzYWJsZV9jbG9jayk7DQo+IGRpZmYgLS1naXQgYS9z
b3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OTg2L210Nzk4Ni1hZmUtY2xrLmggYi9zb3VuZC9zb2MvbWVk
aWF0ZWsvbXQ3OTg2L210Nzk4Ni1hZmUtY2xrLmgNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
aW5kZXggMDAwMDAwMDAwMDAwLi4yZjE1YjdhNTRiZGMNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysg
Yi9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OTg2L210Nzk4Ni1hZmUtY2xrLmgNCj4gQEAgLTAsMCAr
MSwxOCBAQA0KPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4gKy8q
DQo+ICsgKiBtdDc5ODYtYWZlLWNsay5oICAtLSAgTWVkaWFUZWsgNzk4NiBhZmUgY2xvY2sgY3Ry
bCBkZWZpbml0aW9uDQo+ICsgKg0KPiArICogQ29weXJpZ2h0IChjKSAyMDIxIE1lZGlhVGVrIElu
Yy4NCj4gKyAqIEF1dGhvcjogVmljIFd1IDx2aWMud3VAbWVkaWF0ZWsuY29tPg0KPiArICogICAg
ICAgICBNYXNvIEh1YW5nIDxtYXNvLmh1YW5nQG1lZGlhdGVrLmNvbT4NCj4gKyAqLw0KPiArDQo+
ICsjaWZuZGVmIF9NVDc5ODZfQUZFX0NMS19IXw0KPiArI2RlZmluZSBfTVQ3OTg2X0FGRV9DTEtf
SF8NCj4gKw0KPiArc3RydWN0IG10a19iYXNlX2FmZTsNCj4gKw0KPiAraW50IG10Nzk4Nl9pbml0
X2Nsb2NrKHN0cnVjdCBtdGtfYmFzZV9hZmUgKmFmZSk7DQo+ICtpbnQgbXQ3OTg2X2FmZV9lbmFi
bGVfY2xvY2soc3RydWN0IG10a19iYXNlX2FmZSAqYWZlKTsNCj4gK2ludCBtdDc5ODZfYWZlX2Rp
c2FibGVfY2xvY2soc3RydWN0IG10a19iYXNlX2FmZSAqYWZlKTsNCj4gKyNlbmRpZg0KPiAtLQ0K
PiAyLjE4LjANCj4gDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdA0KPiBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsDQoNCg==
