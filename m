Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A459D68983E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjBCMHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjBCMHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:07:34 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7993953EC;
        Fri,  3 Feb 2023 04:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675426050; x=1706962050;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=EbjPNWDQa3rx6u+TW6PSFearyeUI2Iddm2dw8O25CVI=;
  b=M8E6f7YivlM/tE1FXw2MwSWaorg4LMAIIB6cxoNpqAVZisuCKYqZUTl3
   oYpOcIl+kk5Lk+fnsf/BY8fZwcJRBZDrMOIkqb33eo1xTQEjSOPrScYmN
   v0rw+Hi07UByV6U13v6wQFa4Pxn/TnMmKS0t7MLI9TkPugasPvAWreAPp
   v5vqRZzcVhWytzK3sLBXFP7XY3G/LXyqfGfYSyIPp+CJ4iRYCKU1t37fa
   593iFW0gVS9MRgxDYvwXsLiDZwdP122ui12pq4z0yRMZ3bI0rcDps1CyT
   q1+c4yYPukqvlCwnfIDqAZCZjjBGPTjd4nwOPPT1nPdxIbOc4+d3D6/QB
   w==;
X-IronPort-AV: E=Sophos;i="5.97,270,1669100400"; 
   d="scan'208";a="135422423"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Feb 2023 05:07:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 05:07:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 05:07:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feqVq/399Xx6Wo++zyTpl0AeicbDtMbNLIBAz1a1iM7zmAIhmVqv0hGotBqcLf6YX+BPgQt5LqfiSnPUeq0b7LofI5+w+hJR+BEGA35XoZ8vmsFcYFxkNfZB46kFLPU/VZOMbMLQ2Mfwv/v/PzQF2AUjGZucISVo0XMPDSaPIeFiZz4GEiG9Q1EK/JNoItg7TEGuhH1TTwm0OSOW5wh0rlAH+qHBJrZ/hKLxqxgHRA4u4a501+5WtfP2tLodeck+vtAG2iy7G6FvfrKpPvdr7+JuFynfUu3ypxsmqEtXJ+4HElkDnx3qgkC1pSAC718vFyda5BzjKK9IJgppAqZjBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbjPNWDQa3rx6u+TW6PSFearyeUI2Iddm2dw8O25CVI=;
 b=LBXixAWWsSqY1drZPewQoeBlwTanMWoEySIRFfys79qTAu/YE28fa+8YhUUxj0tuMN9cAfKlh+mwKCZPxuXvRfaY3OgDkooupVlODuB7RKbqnmEDrOH2dFL7Yepw70a2vBVjRBZgn8k8Bha5xhbcUoTTw9uaap0uzBuWqPdUGzCqYxRGAN7EuMm33WNByEFBmpniShDMGWL1vWkcC03in/BKttqU0G0nuoweH2XLgVa+U39KSrg5g/GegfgqhxESr2VMzrZN+TQEvCr0ITlS9zZNLVJ9xDRQnk5YUMFHRpyNvfggQ5/bULockF20DlY5DsQfBsKKwboy7AHn/tWa5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbjPNWDQa3rx6u+TW6PSFearyeUI2Iddm2dw8O25CVI=;
 b=BQGIXX3/TswNeRT2agDFaulUw4uSB5dBFoSfTOVIqkVgbJq/Gx5EMkb1p4UGGQ+KjFLfeTjxCs/91LooUM5/2+BkukYObIYJb8W4QGstPbNmDhgheR0ui+bEgQGwzh3Jn8d2+/KkYUCCOm9cycURjYKojKSogKTzfl9cdhHjvfI=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by IA1PR11MB6148.namprd11.prod.outlook.com (2603:10b6:208:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 12:07:15 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5%9]) with mapi id 15.20.6064.031; Fri, 3 Feb 2023
 12:07:15 +0000
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
Subject: Re: [PATCH v5 1/8] ARM: dts: at91: sam9x60: Fix the label numbering
 for the flexcom functions
Thread-Topic: [PATCH v5 1/8] ARM: dts: at91: sam9x60: Fix the label numbering
 for the flexcom functions
Thread-Index: AQHZN8gO09S75lbVZkW2onrSdAhppA==
Date:   Fri, 3 Feb 2023 12:07:15 +0000
Message-ID: <1f1bf1d1-ec12-c41f-604d-2c47ac6668aa@microchip.com>
References: <20230203034833.451461-1-durai.manickamkr@microchip.com>
 <20230203034833.451461-2-durai.manickamkr@microchip.com>
In-Reply-To: <20230203034833.451461-2-durai.manickamkr@microchip.com>
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
x-ms-office365-filtering-correlation-id: 5a12edd9-5913-4f8f-3cb4-08db05df3085
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DLGZSMilBnsWnRxmfNqdlxEa3EtolVf6XOT27fG2cKUuPBCnSVX7+q/F5agD+l6qGmh3JF8JPGRugvjTDfWTY6Az/UTpF9Mr12EwajE6Mcq1GjAEbKRSIYkdy5SVzuBYisRtiaKV/mFymFPDt3zjtF5dp2aZ4bSCUoqEw0S9bLuRcDPs/ZlgMEDz2+VRc8dBGX+oCN+Yxeb04zGvIhS0Bi5CXtJ8B/49X/4SNU96B29eNjMBHsWq6LNVECGHAe/l6HNO3B9yJcbFXoSpo1YSTCAtllCrZcf2ZMaJPSrInn983asAcm/q8Ay8MdE6G3aWgtcJwjIzHRZetkynC8f1CjRNfeFwXfayuhwIgSSPdDA+p1VajaAB0YmCR+OFsFVR2mUraZCA1/RrU6Ux/mulZjxUkx9sHQd7G03URmYyxFiwtvsGaVtpZxSRHl6GrCTfMaIVAczQT0yCxCFwv43zWrwAF/n2DR8rMrEMvlWD3/LltKH2I1SfR4Z1PjhlQ/0guMgQXDxthWxmZz90fcJlK0Id3oxUexDQ/DMkid33nK8+BeXjTH0C8a6aQD5D5jRbbOIYxgR/BWdOIRbeK4NDFx3wZih4202+si8H6FpSjlSq4ucY0UBtkBlQ4rsLSMlDu5lSlwKiUz4uHlr5GnCKYJNdAtAsQy/JjvoxHiVr2qKWJFYRZIz2TG1gR3iJvDOKBJplPN43pAbq4B4FSbUmJHhbcYJeXUFEVAzrvUGbFQ04gffK49xNBOKeBqiFhjQfzXzEIEZE+RQAQfWAYLn1km9kN2SRFsFtqfMpwVGyok4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(66946007)(76116006)(8676002)(6506007)(6636002)(6486002)(478600001)(26005)(110136005)(53546011)(6512007)(36756003)(316002)(186003)(5660300002)(86362001)(7416002)(2906002)(91956017)(41300700001)(66556008)(31696002)(66476007)(8936002)(64756008)(71200400001)(66446008)(2616005)(83380400001)(38070700005)(122000001)(921005)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czN5NWY5elY4T0x3M1RwSFg2UzlCTUpSbUJHTm5MMWFkdEd0Q2Q4dmVESzZC?=
 =?utf-8?B?YUhSdHdYSTJtQldVN0dsU0VxclNzdHVxQm41YkNmaHp3QjZxck1UczFGTkdl?=
 =?utf-8?B?NmVTV3lSVmtFbXRGZEFJc0c5N281TjNlajYrSUl0bTJiekszVHFSeW1qUFJI?=
 =?utf-8?B?N3ExNDM0dkd4NjlIaTMwRE45UWZ2Vk9MYnpVa0NtSHZxSUFXRmJjU29ZNWtu?=
 =?utf-8?B?UGZBMnIzM3E0YTJ5QytYb2x2MmZLQmxlcjNtenptbkJDTkJqd1E5enFsWnZr?=
 =?utf-8?B?VEo0aU8ydm8rNUI1aU1iSms5Y0g0dFcrZ0tRNXV1QjdmbHRyMWMzMDJZeGhm?=
 =?utf-8?B?OCs1ZGpJMUVkaVVRckFSSlV0M2xFcm1BUFVYbC8xQ2FuN3FmOGt4ODVScXl1?=
 =?utf-8?B?elNNaHZCeEl1V1FDdXZvMHJ1SW9DUFpHTzJETnpCc2w2akNSV1o3RmJZUFJz?=
 =?utf-8?B?Y0l4bzkxSHY3YWJxRUhydHYyOHFKZ0Q0emRJRmRQcExobDJpem9Fc2tzaXYv?=
 =?utf-8?B?RHhmK1NVYVpGL1BBbzZXbW9sd2hJaXM2bFhRWHFwM0N0YWhJTVJYZHhwQU9x?=
 =?utf-8?B?WE1NWkpwTXlNQmg4ek1TZHJaZEZVT2hsR1AvVFNha2lOMlZRbVpRNzRJcTVV?=
 =?utf-8?B?MGduWTB6WFdPNnVYU3lwbC9ub0J6dzhtdzgvWnJFaDlEUzdGWGtvNWVwLzhQ?=
 =?utf-8?B?cDZ1OGRzdEVLdGpoMlJuak1VaHFFaCtlWWNMWWJUQ0loenBFNUF0ZER6OWJK?=
 =?utf-8?B?WHNudHN4QXBlT2oza3B3VktyVUxDM2pqMlg3NmhBOGZlT3NDM3VGUEJyWmha?=
 =?utf-8?B?bWdKeWNRTDEzMkJQb2J3UDI3eDl4TjdpUVdpTWlseVYvYWxmbDFocDBKTTdP?=
 =?utf-8?B?QjZ0RHovQlpYU0l1K3drTmlZMlJGRmQ5NmhrR3RuNkxiZUY3NVpmTzYxaUV1?=
 =?utf-8?B?TXd3SGRJY1hCMVQwV3dLbm5iQlRBbVZBOC9weVdES3o3am5aVm1kS2s5eFNs?=
 =?utf-8?B?bGphWldFUklKMk9yT3VCR2lZVW10OXF5K3BPSUZZYlFkVXJ3N3FmcEFmZmY0?=
 =?utf-8?B?MnlSR3FzYzBtd1NoekZoTEpLRmpxdHErVXErUFZKdFNvbFNhdXlWQzAvbmhN?=
 =?utf-8?B?NWtuaEJ5TVY0b3UrT0lNRVJhdndTNFoxVWNJNnYrWS9BZXNzN04zSVIwN1RO?=
 =?utf-8?B?SW5wTmlhTVlITjJjNVQ2VlBLQXpXRjFybXBBdHM1cFJlcWwxTXVYMEZRYUJT?=
 =?utf-8?B?bkpNV1dmdHU3TU1uNVFRTlJNYmdGQWFpVmJWamQvRHFTa0QyZmxXZkMzSTlk?=
 =?utf-8?B?eW45WWN5bUtITS9XQUZQVEtRODVjMDhzNDh5NFdqUk11WXV1bkl3VDc5U0wv?=
 =?utf-8?B?U1VVUXgrV2pYSTNRS1F2dGthSVpTeXp0OFFzWVcrcnY4bHgzL1gxZWJGR3ll?=
 =?utf-8?B?WVJQODY4V2J2bGdhSGhNNVpQUVUxVkxkakxEcnRuWDlEbkVXZnhHUWVpcjRR?=
 =?utf-8?B?WFo4OVRoVXpNaS82OVhWUWtCWkNPQnNZNGI4NmJKOFNTQkVmK3kvTnlhYTUx?=
 =?utf-8?B?RGRSQ08vNnRsNjhxOEtybGgyZnluWGFkYkNNemtvU0pMYkxxZWFTTGJHVFFN?=
 =?utf-8?B?SE4xcTRQd3NKV0t4MUYzZ28yam16Y3lISWtsc21WYmZ2WmRlR1A2NEFkWnBF?=
 =?utf-8?B?REpGZDlVV282RE1wM3E5aXoyb1dyVnJhSUNjT0ZOYUUwYkRac3hzVVFVVmpq?=
 =?utf-8?B?ZXZMeVRBUUtZa0VnVGVjajFsSkJ0a21ESm4yaFpyOU1qRXUvL25ZUThjQ3VW?=
 =?utf-8?B?T1gxUjl2cnR0L000VHpEekI5TlZYV2trRERwSUdMb0JoSm5LL1BCVkdTUHdE?=
 =?utf-8?B?eEhsblpOb0xITkw0NnFpWHFxOUNpNmFnc1kvb1EyeHRDd0NraU9tZHRXWXFY?=
 =?utf-8?B?RkZJUnpzejJwRFY1dWhVMGtaVGM1ZGFZVVhVcjRvejJTdGFzS0VSUnhnQmxC?=
 =?utf-8?B?OU9HaWovMHladWRnMFBjejBpWjEwMEpNSUVBNFJNMzF5MG1PTUpNdlcvODFD?=
 =?utf-8?B?Y0pXK1hMbkoyc0k1b2NKamIyM1dHcmt5MmpMbENQWVlGN3BiTkhnNlpBZG04?=
 =?utf-8?B?TGxVMHJsL0YyQld1RjUwRk10Mm1NcXMycVQ0RE8wSHY1bHV0azZURXV3ZG5T?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50A487D100EEAE4199DD1A479E64B5C3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a12edd9-5913-4f8f-3cb4-08db05df3085
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 12:07:15.2628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jKCbzrzkO8Kv/8hqBnRpd8d3+vXUoAdcCzNQ08+fLk9zof2LTeX+RGJBEiD09g9r3UP9HUN1O3mmf+myKFc47a5rLxfzx1Y8a/5RYahOBwo=
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

T24gMDMuMDIuMjAyMyAwNTo0OCwgRHVyYWkgTWFuaWNrYW0gS1Igd3JvdGU6DQo+IEZyb206IE1h
bmlrYW5kYW4gTXVyYWxpZGhhcmFuIDxtYW5pa2FuZGFuLm1AbWljcm9jaGlwLmNvbT4NCj4gDQo+
IEZpeGVkIHRoZSBsYWJlbCBudW1iZXJpbmcgb2YgdGhlIGZsZXhjb20gZnVuY3Rpb25zIHNvIHRo
YXQgYWxsDQo+IDEzIGZsZXhjb20gZnVuY3Rpb25zIG9mIHNhbTl4NjAgYXJlIGluIHRoZSBmb2xs
b3dpbmcgb3JkZXIgd2hlbiB0aGUgbWlzc2luZw0KPiBmbGV4Y29tIGZ1bmN0aW9ucyBhcmUgYWRk
ZWQ6DQo+IA0KPiBmbHgwOiB1YXJ0MCwgc3BpMCwgaTJjMA0KPiBmbHgxOiB1YXJ0MSwgc3BpMSwg
aTJjMQ0KPiBmbHgyOiB1YXJ0Miwgc3BpMiwgaTJjMg0KPiBmbHgzOiB1YXJ0Mywgc3BpMywgaTJj
Mw0KPiBmbHg0OiB1YXJ0NCwgc3BpNCwgaTJjNA0KPiBmbHg1OiB1YXJ0NSwgc3BpNSwgaTJjNQ0K
PiBmbHg2OiB1YXJ0NiwgaTJjNg0KPiBmbHg3OiB1YXJ0NywgaTJjNw0KPiBmbHg4OiB1YXJ0OCwg
aTJjOA0KPiBmbHg5OiB1YXJ0OSwgaTJjOQ0KPiBmbHgxMDogdWFydDEwLCBpMmMxMA0KPiBmbHgx
MTogdWFydDExLCBpMmMxMQ0KPiBmbHgxMjogdWFydDEyLCBpMmMxMg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTWFuaWthbmRhbiBNdXJhbGlkaGFyYW4gPG1hbmlrYW5kYW4ubUBtaWNyb2NoaXAuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBEdXJhaSBNYW5pY2thbSBLUiA8ZHVyYWkubWFuaWNrYW1rckBt
aWNyb2NoaXAuY29tPg0KDQpSZXZpZXdlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6
bmVhQG1pY3JvY2hpcC5jb20+DQoNCg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTEt
c2FtOXg2MGVrLmR0cyB8IDEyICsrKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9i
b290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4
NjBlay5kdHMNCj4gaW5kZXggZDkyOWMxYmE1Nzg5Li5jZjVkNzg2NTMxZjIgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtOXg2MGVrLmR0cw0KPiArKysgYi9hcmNoL2Fy
bS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMNCj4gQEAgLTE2LDggKzE2LDggQEAgLyB7DQo+
ICANCj4gIAlhbGlhc2VzIHsNCj4gIAkJaTJjMCA9ICZpMmMwOw0KPiAtCQlpMmMxID0gJmkyYzE7
DQo+IC0JCXNlcmlhbDEgPSAmdWFydDE7DQo+ICsJCWkyYzEgPSAmaTJjNjsNCj4gKwkJc2VyaWFs
MSA9ICZ1YXJ0NTsNCj4gIAl9Ow0KPiAgDQo+ICAJY2hvc2VuIHsNCj4gQEAgLTIzNCw3ICsyMzQs
NyBAQCAmZmx4NCB7DQo+ICAJYXRtZWwsZmxleGNvbS1tb2RlID0gPEFUTUVMX0ZMRVhDT01fTU9E
RV9TUEk+Ow0KPiAgCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICANCj4gLQlzcGkwOiBzcGlANDAw
IHsNCj4gKwlzcGk0OiBzcGlANDAwIHsNCj4gIAkJY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc2Ft
OXg2MC1zcGkiLCAiYXRtZWwsYXQ5MXJtOTIwMC1zcGkiOw0KPiAgCQlyZWcgPSA8MHg0MDAgMHgy
MDA+Ow0KPiAgCQlpbnRlcnJ1cHRzID0gPDEzIElSUV9UWVBFX0xFVkVMX0hJR0ggNz47DQo+IEBA
IC0yNTMsNyArMjUzLDcgQEAgJmZseDUgew0KPiAgCWF0bWVsLGZsZXhjb20tbW9kZSA9IDxBVE1F
TF9GTEVYQ09NX01PREVfVVNBUlQ+Ow0KPiAgCXN0YXR1cyA9ICJva2F5IjsNCj4gIA0KPiAtCXVh
cnQxOiBzZXJpYWxAMjAwIHsNCj4gKwl1YXJ0NTogc2VyaWFsQDIwMCB7DQo+ICAJCWNvbXBhdGli
bGUgPSAibWljcm9jaGlwLHNhbTl4NjAtZGJndSIsICJtaWNyb2NoaXAsc2FtOXg2MC11c2FydCIs
ICJhdG1lbCxhdDkxc2FtOTI2MC1kYmd1IiwgImF0bWVsLGF0OTFzYW05MjYwLXVzYXJ0IjsNCj4g
IAkJcmVnID0gPDB4MjAwIDB4MjAwPjsNCj4gIAkJYXRtZWwsdXNhcnQtbW9kZSA9IDxBVDkxX1VT
QVJUX01PREVfU0VSSUFMPjsNCj4gQEAgLTI3OSw3ICsyNzksNyBAQCAmZmx4NiB7DQo+ICAJYXRt
ZWwsZmxleGNvbS1tb2RlID0gPEFUTUVMX0ZMRVhDT01fTU9ERV9UV0k+Ow0KPiAgCXN0YXR1cyA9
ICJva2F5IjsNCj4gIA0KPiAtCWkyYzE6IGkyY0A2MDAgew0KPiArCWkyYzY6IGkyY0A2MDAgew0K
PiAgCQljb21wYXRpYmxlID0gIm1pY3JvY2hpcCxzYW05eDYwLWkyYyI7DQo+ICAJCXJlZyA9IDww
eDYwMCAweDIwMD47DQo+ICAJCWludGVycnVwdHMgPSA8OSBJUlFfVFlQRV9MRVZFTF9ISUdIIDc+
Ow0KPiBAQCAtNDM5LDcgKzQzOSw3IEBAIEFUOTFfUElPQSAxMyBBVDkxX1BFUklQSF9BIEFUOTFf
UElOQ1RSTF9OT05FDQo+ICAJCQkJIEFUOTFfUElPQSAxNCBBVDkxX1BFUklQSF9BIEFUOTFfUElO
Q1RSTF9OT05FPjsNCj4gIAkJfTsNCj4gIA0KPiAtCQlwaW5jdHJsX2ZseDVfZGVmYXVsdDogZmx4
X3VhcnQgew0KPiArCQlwaW5jdHJsX2ZseDVfZGVmYXVsdDogZmx4NV91YXJ0IHsNCj4gIAkJCWF0
bWVsLHBpbnMgPQ0KPiAgCQkJCTxBVDkxX1BJT0EgNyBBVDkxX1BFUklQSF9DIEFUOTFfUElOQ1RS
TF9OT05FDQo+ICAJCQkJIEFUOTFfUElPQSA4IEFUOTFfUEVSSVBIX0IgQVQ5MV9QSU5DVFJMX05P
TkUNCg0K
