Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEE87000F2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 08:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbjELG5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 02:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239562AbjELG5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 02:57:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59534218;
        Thu, 11 May 2023 23:57:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gh4YcltTUxB1IpC7HtJcrzH8FZ1gmM0UIDod5BdIEl7xY01o6z3K6Q1gurkSwI+skB/lzaQFhoevUUOP29ujMlE/2ckzGMhqFVvnOmatROhe2MVTgRbz0Evs6XStMIAcItqL8xiEJursB7y4LkPvs/qCkb3b07XTj1DZAl+ury9TWpsANmXIHopsbWIU2KyA2FDx4itzT9IceplUQeN1g7sJIIBC+6BPlO31xu6gNM4ReOhYc0YDvB1+21D2zVZ9T4xkAOG6UouhV2+k4i4s5UGT085wX3tjsv8mhw/XY3fQoHaTMmQcCJhlOdMGV/hXFqLV3qV5ygw5Enw72RqKfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5ypyduPKOGkOjtLaYHX1iAGyTl2+cTfORy33/EUREk=;
 b=eYhJA4wHkMqBBuoAA/AGRUlpJOO75rGR7kL2+VAEYJtxdu7KKHwG6pxCE7he+GnWoPmlgeaHDMyPWtq3S59v8SC5rDLggu1LTp6/Ah/2Sl8XvHzYAIyz+84KhVopunl3Ecq5Uqf4fmCW7H7PdkAqXcGKWJO3rlL28MaAaxgt0hbWk4oamCS14zCmIM75UMUyK5nL+A89aWvaeG4h8cyiO0RFVAfWSwFjkLdbgKQjoji4XAqylgR862NDqcpQk2homiI8xjUVslUZY7xp+/kBRTPHMFuFg9mw2KQyLWFqm7stW/mNs8vHw1T7d4gq17OK3m2peJEf5VRLNMfgUIbkRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5ypyduPKOGkOjtLaYHX1iAGyTl2+cTfORy33/EUREk=;
 b=PPe6s9ylBsA25nymY/y81xW5JhXpj7T8u7v1RDG8fF/yVSgyCEkuM0IgylUJJLb29T2v6cyZ/FFEbI3tGAaSYjHdGNQhcqCvhfze45Bpf8Pc20ne+5CPUio5e5Z7luTQPVYPFlYzPB+obJkMVFc+hjxFA8HNGH6otqKNgHYIv3M=
Received: from MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 by SJ0PR12MB5502.namprd12.prod.outlook.com (2603:10b6:a03:300::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Fri, 12 May
 2023 06:57:36 +0000
Received: from MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::f333:66cf:19cb:f513]) by MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::f333:66cf:19cb:f513%6]) with mapi id 15.20.6387.021; Fri, 12 May 2023
 06:57:36 +0000
From:   "Mehta, Piyush" <piyush.mehta@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH V2] dt-bindings: usb: dwc3: Add interrupt-names property
 support for wakeup interrupt
Thread-Topic: [PATCH V2] dt-bindings: usb: dwc3: Add interrupt-names property
 support for wakeup interrupt
Thread-Index: AQHZg9l/fl1CedOsd0uDlHg9soDxAa9Uz+0AgAAPc0A=
Date:   Fri, 12 May 2023 06:57:36 +0000
Message-ID: <MN2PR12MB4333A304BF5D7B97836BACE388759@MN2PR12MB4333.namprd12.prod.outlook.com>
References: <20230511072154.2030703-1-piyush.mehta@amd.com>
 <ca8b31f5-ce4e-d7b1-d077-3684862083bf@linaro.org>
In-Reply-To: <ca8b31f5-ce4e-d7b1-d077-3684862083bf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4333:EE_|SJ0PR12MB5502:EE_
x-ms-office365-filtering-correlation-id: 01cabd40-f4ad-4cf9-6a96-08db52b62b20
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qh3+IwmM/NplaSDzrI0Ad/Pag5Gz7Gnsde5auq3eqx80QHeDy4t54ZJl9d6GTrZ18QqhcNgxrg82DAnXHDALrPIVvDknpt1bHpUkcyzniFceLWWuWBRzsbV2SGxmdP9/25Kxl/pXwPn0XpwnfdZqLN8IqMkDbrS4UKPW2D2xEkcUNGcvx6svQtF5cc2j64908GrkaarTLl3DB+Got7NRLaetoCkIo5cghIQJdLK4SG1WaMotF3istad7IR2Bqwq0IJKYMR6Eb0dKfJSQ97XPmxuYORRFNqVfZVtoRzaIJN4Sw4SNBP6j8EzDaGyCYzmxR0jof7RNn1i+BYVZv4uQS422D+qur31YgM+dKO9yfFp9IkYidmsrSlG/YfRlXCUDlX9+SKXIiEALP6m60rYm92qfcsZDUSyP3ANalvJnsRcIqCyaWSuObe7dBegCPo6YS+SRDobyFGsaHdd6F3gcqPvw+/KSOBZT9Mpl6k2A2OsfbwNzAnaSnd2TyRlB1gJ8ElXC5zAxzw6B2r8CpE0klTUQmc1SilcNQmxoxtieetqeTDR2NppwddK+K4XX0T815ZOCxLD0wb23NHC9bvaYt+9BP/e+Zkr+xLlysVXUf8E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(86362001)(33656002)(64756008)(66476007)(110136005)(966005)(54906003)(478600001)(66446008)(316002)(71200400001)(76116006)(66556008)(4326008)(66946007)(7696005)(52536014)(8676002)(55016003)(41300700001)(5660300002)(8936002)(2906002)(38070700005)(38100700002)(7416002)(122000001)(26005)(6506007)(186003)(53546011)(83380400001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGN6dUhWMHdUTG1uSjJrTWI2N1FDaEp5REZsL1U5dUZVOEZGVWhuYm1IaU4y?=
 =?utf-8?B?UXNRZ3hobTZqbG5wR0EzUmJ5UUZISUthTUFVbDZKVDNwTWxoK3Z2eG4zUTNQ?=
 =?utf-8?B?b2p5SDJTT0tyK3A2U3JSdkU0NFZzV2psMVFXZDJSOThuRmJjUGpkRi84azdk?=
 =?utf-8?B?WU43Z2dMYWZEY2NjOXhuQ09RSTQ4OWtDWHNoOWs5RHRta2lKNXNIS1FVTGVL?=
 =?utf-8?B?b2VqNUV2dkpOcXVLQ2Rnc1haUkdwUmxXejU3QjlvanJyWkNuRm44QVhxMEZt?=
 =?utf-8?B?S1JBNlIvK212Rk9WejF0ME9tbmNFK1V6MkVsRHR1OGErcEs5a3ZIZHViU0ht?=
 =?utf-8?B?YXEwWlMya2lZNzhhOGFDc2xWNmVtUjhiVDFNNWlidVFqV2d5VkdUcmFTMmxh?=
 =?utf-8?B?NHBiZC91WExyWWE0b095RmQzMGQ1a2t6YWJnbDhkVE1sL1h2cWF2RE1uclNX?=
 =?utf-8?B?bzQzUGJRZitFSytwblpyclBSaDNEOW5POFhhblhLelF0VDZWQlZQU0JqcnNk?=
 =?utf-8?B?Q3BvMjFGblBIbGpNcDR2YmFLYmpIRlpTSUZIeUVxR20rNTh0OTIxbE9JUTds?=
 =?utf-8?B?ZFFUTVVMZ3pzNmNwUUdvdFE5RVZEVkpUY2VBalNWMTk5cXhOdUI4eEVIU1Uy?=
 =?utf-8?B?YTRBRExrTFhqb1NIY2QrVFFWcUtJUHR5ekxKSTR0b05oSllIODZrVklIbHlk?=
 =?utf-8?B?eUZydTkwM2JuanRhMG94bVpTVENPczhuSmk3T0ZUaTNwWnJGS2ZPcjhROTlW?=
 =?utf-8?B?OXI3YVBZR0pFa2wraVFLVHVqMmFWcUFsQXpGdnZ5OWRGdmh6bXNyazRQUCtF?=
 =?utf-8?B?NjVGK1plSzM0bG5zSXNObi9SUU9XV2syeXpJdU5aV0xnTHU3QitqaUpkRGhL?=
 =?utf-8?B?TlNZdmM1QWk0MlZLNHAxeU1IRXUzRHBpK1NPeUNWWVFIWVBBWVdhQ09udUll?=
 =?utf-8?B?WUgzN1hLdEx2Ynl6QmdBRDJHUlAwU2tEM3VmSVNJV0FYMWpZZktXMEk0ZEFi?=
 =?utf-8?B?SU5oZjlwaXZ3bGZkZGxYUmNTM3BrSXpvSXRuZ2R4ZTVIN3orcTlrcStZZFZW?=
 =?utf-8?B?UnAyek5Lc0ZhMmZvc2d2Uys5bzl6K2t2elBDaWxPSXQ5YlJEWDVtVm15Uzk1?=
 =?utf-8?B?SEFUaSs1SmpyZWVXOU5LRHFyRU5oamhPS3ArdytCenVkS3ZHOG9sQjNKNXQx?=
 =?utf-8?B?amxwTmp1Z2hKS3RvRjNUVGthbjZGS0w3bWlnSHVIQ3Q2MWNzemFFeTVJdlZP?=
 =?utf-8?B?Yk5ZdnI4WHBzcXZ3eis5emJ3d2VYbjNNT1k2Wm5YMzgxYVBTNVpPbGNrLzNq?=
 =?utf-8?B?UTJFMU1XeWZTWE04R1prLytnbTVtbWduOVVOUU56MUhNRyt0OGpCdlZMNmtn?=
 =?utf-8?B?b3REWFhtNEEweGFvWjM3cStPQkRFdnpwd3NoTzZoZGkwRytXMnNEVmVSaWxr?=
 =?utf-8?B?aW9IUkJoYjE4S1BGNnNhaU5SanpvUGt4c0xiN2hLeFRMUEZkaGdDKzJrZ3gz?=
 =?utf-8?B?UzRYeStFRVN0RWJJRGhQZHJpM1UxN0MxYVg4cThLRzRoWjB2TDFqNzZIL29y?=
 =?utf-8?B?eDNiTVlidjdBRWI3Y2pXM0E1bTB5WkV5RHJMYmR0bmdJTm43dVQyQ3lmWEdw?=
 =?utf-8?B?Rmo0blJNR3c1WVdWSmo0V05rVUZnclphdW5XazNyeitITVh0VkI5Y2V3bWM2?=
 =?utf-8?B?YkhrdFgzc2duaEtUM3NoN2tTQ1ZKcVZ1QTBGdjl3Rm9BTjY2SUtOb1p4K2pl?=
 =?utf-8?B?MzRxb05YaTZaSXJ5dHZCVVJBWVI5QW0zTWxvazdPSFF1NUF0RTBIa0NGUFRE?=
 =?utf-8?B?RU40U2I5ZWxwZDl3RkxZeDgzQzBBU3ZOb0YxcUtkV2VtMmEvWjkwQWFWbDlm?=
 =?utf-8?B?MjBncnEzYlNnVUVOYWFMUTdEZ21aQ3pndnNvdUpBUTdIc0d5UTBOblpCZmVq?=
 =?utf-8?B?RW1iTzBXU0txZ1RTaStKU0d6Tm1DWGVwTlJaK2dPeCtzbGJOSGhOT3hVTkZD?=
 =?utf-8?B?YWNiOFJ1a1pBRGkyd0NDZ2V2aDcvbUdRQ0EyTlBBd2M0bWxOWmhYTDF1UnNT?=
 =?utf-8?B?cmw3MGRQNWRjZHQwMWlsYjJZSk84RlBlRHYxYVBEVTgwZHJvMFlYK2tzNDkv?=
 =?utf-8?Q?DzRU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cabd40-f4ad-4cf9-6a96-08db52b62b20
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 06:57:36.3607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPMeNdNXtp6wiIq/QHXiZEPtBwyBm6ZiJ6Hd1lCk4+xKB3Dq57K/Xan0GcyjTpan
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5502
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtv
emxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2Rh
eSwgTWF5IDExLCAyMDIzIDM6MDUgUE0NCj4gVG86IE1laHRhLCBQaXl1c2ggPHBpeXVzaC5tZWh0
YUBhbWQuY29tPjsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7DQo+IHJvYmgrZHRAa2VybmVs
Lm9yZzsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiBjb25vcitkdEBrZXJu
ZWwub3JnOyBiYWxiaUBrZXJuZWwub3JnOyBtaWNoYWwuc2ltZWtAeGlsaW54LmNvbQ0KPiBDYzog
bGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2lt
ZWtAYW1kLmNvbT47IFBhbGFkdWd1LA0KPiBTaXZhIER1cmdhIFByYXNhZCA8c2l2YS5kdXJnYS5w
cmFzYWQucGFsYWR1Z3VAYW1kLmNvbT47IGdpdCAoQU1ELVhpbGlueCkNCj4gPGdpdEBhbWQuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyXSBkdC1iaW5kaW5nczogdXNiOiBkd2MzOiBBZGQg
aW50ZXJydXB0LW5hbWVzIHByb3BlcnR5DQo+IHN1cHBvcnQgZm9yIHdha2V1cCBpbnRlcnJ1cHQN
Cj4gDQo+IE9uIDExLzA1LzIwMjMgMDk6MjEsIFBpeXVzaCBNZWh0YSB3cm90ZToNCj4gPiBUaGUg
aGliZXJuYXRpb24gZmVhdHVyZSBlbmFibGVkIGZvciBYaWxpbnggVmVyc2FsIE5FVCBTb0MgaW4g
RFdDMyBJUC4NCj4gPiBBcyB0aGUgRFdDMyBJUCBzdXBwb3J0cyB0aGUgaGliZXJuYXRpb24gZmVh
dHVyZSwgdG8gaGFuZGxlIHRoZSB3YWtldXANCj4gPiBvciBoaWJlcm5hdGlvbiBpbnRlcnJ1cHQs
IGFkZCBob3N0IG1vZGUgIndha2V1cCIgaW50ZXJydXB0LW5hbWVzDQo+ID4gb3B0aW9uYWwgcHJv
cGVydHkgaW4gdGhlIGJpbmRpbmcgc2NoZW1hIHRvIGNhcHR1cmUgcmVtb3RlLXdha2V1cCBhbmQN
Cj4gPiBjb25uZWN0LyBkaXNjb25uZWN0IGV2ZW50IGluIHRoZSBoaWJlcm5hdGlvbiBzdGF0ZS4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBpeXVzaCBNZWh0YSA8cGl5dXNoLm1laHRhQGFtZC5j
b20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlIGluIFYyOg0KPiA+IC0gIEFkZHJlc3NlZCBST0IgcmV2
aWV3IGNvbW1lbnRzDQo+ID4gIC0gVXBkYXRlZCBuYW1lIG9mIGludGVycnVwdC1uYW1lcyBwcm9w
ZXJ0eSB3aXRoICJ3YWtldXAiDQo+ID4gIC0gTW92ZSBpbnRlcnJ1cHQtbmFtZXMgcHJvcGVydHkg
ZnJvbSBkd2MzLXhpbGlueCBjb3JlIHRvIGR3YzMgY29yZS4NCj4gPg0KPiA+IExpbms6DQo+ID4N
Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBTF9Kc3FLNl83WEQ3K3crRVF2UFBtYm1T
T3BmbzNKRGIweERONFN0DQo+IHUNCj4gPiBIVW0xa2djaHdAbWFpbC5nbWFpbC5jb20vDQo+ID4g
LS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Ivc25wcyxkd2Mz
LnlhbWwgfCAyICsrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3Nu
cHMsZHdjMy55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNi
L3NucHMsZHdjMy55YW1sDQo+ID4gaW5kZXggNTBlZGM0ZGE3ODBlLi5kYjUxMjc2OWJkODAgMTAw
NjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBz
LGR3YzMueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91
c2Ivc25wcyxkd2MzLnlhbWwNCj4gPiBAQCAtNTMsNiArNTMsOCBAQCBwcm9wZXJ0aWVzOg0KPiA+
ICAgICAgICAtIGNvbnN0OiBkd2NfdXNiMw0KPiA+ICAgICAgICAtIGl0ZW1zOg0KPiA+ICAgICAg
ICAgICAgZW51bTogW2hvc3QsIHBlcmlwaGVyYWwsIG90Z10NCj4gPiArICAgICAgLSBpdGVtczoN
Cj4gPiArICAgICAgICAgIGVudW06IFtkd2NfdXNiMywgb3RnLCB3YWtldXBdDQo+IA0KPiBZb3Ug
ZGlkbid0IGFkZCBvbmx5ICJ3YWtldXAiIGJ1dCBhbHNvIGR3Y191c2IzIHdoaWNoIGRvZXMgbm90
IGxvb2sgY29ycmVjdA0KPiBoZXJlIGFzIGl0IGlzIGNvbW1vbiBpbnRlcnJ1cHQuIFRoZSBjaGFu
Z2UgZG9lcyBub3QgbWF0Y2ggY29tbWl0IG1zZyBhbmQgSQ0KPiBkb24ndCBrbm93IHdoYXQgeW91
IGFjdHVhbGx5IHdhbnQgdG8gYWNoaWV2ZS4NCj4NCg0KV2UgaGF2ZSBkZWRpY2F0ZWQgaXJxIGxp
bmUgZm9yIGhpYmVybmF0aW9uIGZlYXR1cmUsICAid2FrZXVwIiBpcnEgbGluZSB0cmlnZ2VycyBo
aWJlcm5hdGlvbiBpbnRlcnJ1cHQgYW5kIHRoZSBzeXN0ZW0gd2FrZXMgdXAuDQpEV0MzIGNvcmUg
c3VwcG9ydHMgdGhlIGhpYmVybmF0aW9uIGZlYXR1cmUsIHdlIGhhdmUgYSBkZWRpY2F0ZWQgY29k
ZSB3aGljaCBpcyB5ZXQgdG8gYmUgdXBzdHJlYW1lZC4NCkFzIHRoZSBoaWJlcm5hdGlvbiBmZWF0
dXJlIHByb3ZpZGVkIGJ5IGR3YzMtY29yZSwgc28gdGhpcyB3aWxsIGJlIHN1cHBvcnRlZCBieSBv
dGhlciBTT0MvdmVuZG9ycy4NCg0KRm9yIHRoaXMsIHdlIG5lZWQgdGhlIGludGVycnVwdC1uYW1l
LyBpbnRlcnJ1cHQgcHJvcGVydHkuIFRvIGVuYWJsZSB0aGUgaGliZXJuYXRpb24gZmVhdHVyZSBm
b3INClhpbGlueCBWZXJzYWwgTkVUIFNvQywgdGhlIGludGVycnVwdC1uYW1lIGVudW0gd291bGQg
YmU6DQotIGVudW0gW2hvc3QsIHBlcmlwaGVyYWwsIG90Zywgd2FrZXVwXQ0KDQpQbGVhc2UgcHJv
dmlkZSB2YWx1YWJsZSBpbnB1dCBmb3IgdGhlIHNhbWUuDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBL
cnp5c3p0b2YNCg0KUmVnYXJkcywNClBpeXVzaCBNZWh0YQ0K
