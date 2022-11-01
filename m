Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D961615126
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiKARzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiKARzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:55:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798AA1CB1C;
        Tue,  1 Nov 2022 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667325284; x=1698861284;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A0UQKDfuo+jUmnYDd8bMMpsGBYn12aO5l8t4+Kyma44=;
  b=GHT4qXXrIR9mjVKc9Qc0EsWJbs/KWBEsqgSVj78/b7RlhxpNHyT+90ym
   cQR037kzkJI9UaAfQZe0Cu3Tlr6wsXK/iU84ZdGv137eiKFIBcwhx3JhD
   CgpparaeF/iOMtLO5ogfuljLR8QumMMeIHcY/TUFw8B9FB767KODiXkBa
   NsqEq3pXIlZhJIn/uu3eWEM5lR5xFAr2oGXSUBxvF/HIns0oseFkaJbAE
   CJTzvSQ/vgqpJe1NVZ5qjFEJcmEQRRvShOWaSdBOQKr5ufKvK18HfVMkV
   F69ESzlEhNgSyarTUnzSOU9HJLtmreTZbd2HVa1dY9ssCBJ6AbD2Poxp9
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="121326549"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Nov 2022 10:54:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 1 Nov 2022 10:54:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 1 Nov 2022 10:54:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIyahCInKcoShwV7vaa1dFWhJxe+Ukoy7RvviYRuuO2txA+LjqYT9j7RI0IzYOmc6uXJylTz7MerX2nDW4Y33cTxlUitYET3x8ijTrvecBzoKOCs63mXIKdayO54v1Zn8ev+RWL7YZQJYORWFfRtLXh5V79GBdbVMKP4NwIU+vj1uVImx0wTsLiw9gNHLGYw0BsrU2aKtP02AaE9UPHv1FWE4ihCCUXeSYCXLrNACdbzGp3foGDRYnz3SVaX/GLQ/aGJdaRbYgGfpecScWHsILD2wXguaihc2JGwrrMtJV5PjabLrxIB8gwN7TwMxJnwc8TLWbAGjJsKzF4gW41/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0UQKDfuo+jUmnYDd8bMMpsGBYn12aO5l8t4+Kyma44=;
 b=PTjg3XM0ehXia5ZoOi3WokNWaMHX3AlrluzlDQVLvw09jkucI0R7edknNnPGERoPPJbq7wb8xxMxlpZMYOFqK5lr7r2mZVQt6llO4qUJ//CFLiRtPtllvOKjSN8F79sNbid5KlS+345utgbJDpXta6e8XCzVak1bZRUsdLj/oGo5uYxevoWIbd7ODmLTdc4P2IwkemmoOOS+5vmAqkldTaqvX+WH0RICpf7b/HckycFIhWBEYBB5JjzSfXbIyejtglxEjW1HT0xNJ8zAQpMB4OCihCpLAB0rtWoP9OjGQErmHni1SS753xB4jqei5gZ6Ovod+6IwmTHD4amAHaLdqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0UQKDfuo+jUmnYDd8bMMpsGBYn12aO5l8t4+Kyma44=;
 b=Jq2c0b1zhPz7k0wKHTNUVXmsMhoHIWlbpR3Xww0VUrtfBHGR4DvPQILZxMm0OdqOaRbqlghAtSsCQ1MDmrI83iV33qa2HLPdQFVNwJoZS+fD8Z6FSx0C6Sjdp2NSTyI2VIWOK4paq34cdS/WvrvlyykPw9KnlE4u34Xqw+W7Oxg=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by BN9PR11MB5449.namprd11.prod.outlook.com (2603:10b6:408:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 17:54:36 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::7a86:8d3a:9e52:13ca]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::7a86:8d3a:9e52:13ca%4]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 17:54:36 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <andy.shevchenko@gmail.com>, <Tharunkumar.Pasumarthi@microchip.com>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <u.kleine-koenig@pengutronix.de>,
        <johan@kernel.org>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <macro@orcam.me.uk>,
        <geert+renesas@glider.be>, <jk@ozlabs.org>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v2 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver for
 quad-uart support.
Thread-Topic: [PATCH v2 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver
 for quad-uart support.
Thread-Index: AQHY1V1Eyoyo00S86kajlcGzY3FsyK38aLWAgCwBsoCAAFduAIABmeAAgAADigCAACf10A==
Date:   Tue, 1 Nov 2022 17:54:36 +0000
Message-ID: <BN8PR11MB3668DA36E2589CF5EE2A6EA9E9369@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
 <20221001061507.3508603-2-kumaravel.thiagarajan@microchip.com>
 <CAHp75VfoWii5Eo4n=-JcqE4VZMRoq77jjdTMGfwBF+vzKBXPog@mail.gmail.com>
 <PH0PR11MB509629C9B80D4331AAF0E5AC9B379@PH0PR11MB5096.namprd11.prod.outlook.com>
 <CAHp75Vf5sBJiNQckCxDGCzFWBYnVs4BhP9+m77_6guZYC+Cybg@mail.gmail.com>
 <PH0PR11MB509684CE1142854777FAD9979B369@PH0PR11MB5096.namprd11.prod.outlook.com>
 <CAHp75Vf4DdDX_=9XZsocKg3k+SyCyYZ1i=9DoFxic4rOe9x2hA@mail.gmail.com>
In-Reply-To: <CAHp75Vf4DdDX_=9XZsocKg3k+SyCyYZ1i=9DoFxic4rOe9x2hA@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|BN9PR11MB5449:EE_
x-ms-office365-filtering-correlation-id: fc7178fe-2791-4b33-ef17-08dabc322416
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WuvdWAnuWUab9Ng/OGcNVJa01k3ilW2lra9ejjkQ6v1UDoScH8HNOge+Jufqw1ZPlT/7BR8oqQxlSY5Xlgh30jLqZZ6T8m9YIzk9BZnAk1DH2gBRJ5MKXCC7GQSD3Bg7b2Ns1jkYIi9lVLQWzrCzh53bo2NZ55KzkPRXAbEuRSFzq9gnt0TPnRpkdoc5DT7wd1B284V5xrCr8HB6X/jEdQ4lTh6IK1wxDsP5jSvN0tUwL3IKfhgz3KMhVGK6T8q+/7vg1+0oZECNQ0ukWq+asAEzaW4l59uHpvD6Ybvzn+UBUs5osZWq59kY/Qn03TqHAIKVNg/UTy8+L9uAmn4QBrRu1AQOTCodCm1sc2IFr44HscEN6FV0Krv9gqm1TBj5wx/ajr9ppEFjnSvwxt+saPdkao6bAhZ8HDRa82hDPl3XmIspow4o20/u1uEzM9lTCNbm6THMEI2va0hkgBFvYwamuuEO4LVyI2oKV/2KnLeaVr2oDlxWP8rEOFKXtB+Z1yfaSu8KKTVvj+m+Ps6BVKFdNwBX1yvYNKm3CGJc34yijWsNgzD040AWRc76QtRmMlKEgkNlqRofAlU7Ueu2lTW3Ny8ju7ox4HTdCT5hHn2EjFHZ2LwgOs6oX0JxQXZpimfe6m88osBlKL/qntbT/44OHu506U4BwVZDVAtorOXACXFIBUHgVvFBb9ZPuO+Iw2YAIQMGvJjRmd7QmnpqdaTbtrA9GTiTiPXwVjWCUn0FpwTCEt6NwKB6G/7cLOhZWv8b0vd/haM7qpPpiqYJ9sfh+xn9EQt4RnILtcIpaGlz7BIKiYTGvnLaW2UtclSanAsl54Y2AElyIpbDU2WWxeynMQeeTD8y3iS0fIAF6Jo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199015)(55016003)(186003)(41300700001)(71200400001)(54906003)(122000001)(110136005)(6636002)(316002)(83380400001)(66556008)(76116006)(66446008)(64756008)(8676002)(66476007)(66946007)(4326008)(8936002)(52536014)(38070700005)(7416002)(107886003)(7696005)(6506007)(5660300002)(33656002)(2906002)(53546011)(38100700002)(86362001)(478600001)(26005)(9686003)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SW4rbzhoK1pORW9kYjdxNVJtaUJlcTVGMGtoTXdiQS9ra3BRQ1UxdkxmTnR3?=
 =?utf-8?B?czF4dHpHY2IySHdpRGN1Wk5aMS9WRmNUVmdUSWxzcnFZOU14R1RGQy8wS0FY?=
 =?utf-8?B?ckp2enhzemo4WDF6OUk2aEhTb0w1VDV5bk96UUFZbHVPZzZrRWVmam5Ucisv?=
 =?utf-8?B?aXoyZlhLeUpJNGJnaWNIaVk2QUxIQmJnb3VEQnBPUSs4bVNXQ2tjWkloa3c5?=
 =?utf-8?B?VjQwRFluWVZWOVRMaGtaZ2xLeGh6T1hpUjM0cWJKM2E1QmRydklkby9tQWo1?=
 =?utf-8?B?c3h4TjF5Vk1ndmtUakFrQUgzbms3SWc0QjhFRUtVbi9DdlFZU2J0NVU1T2lF?=
 =?utf-8?B?R0JoS00vWUgxZDBUdU81bVBsWlZYSUV1L3R3akc0eTUxZG43KytDZ2tQVlRl?=
 =?utf-8?B?K09wUFp1aWVPOHk5ZTdaMWtrVjFjQXhxZXJGVFpyNmJEVDV5cG9BMTc5NVdT?=
 =?utf-8?B?SUVKdUFzcXh1N2VJMWhDTVcwd1oyZ0JVRzdKQWh5aHRDSEJMbGYxT1ovVVVJ?=
 =?utf-8?B?Qy9JSlZyMHZpVWxoVHY0emRpckJMbTlOY2FmNkZweHl4MGJLL0xHT2xycytH?=
 =?utf-8?B?YUgvTEpBTEZ1YTU2Q0ZxUVkvaktQd1pSc3d1RFFwU1NMRHBVUVpmME9pVHRJ?=
 =?utf-8?B?dDYzaHdEMUlWNlRWcHUweEhqazkrUnNxdTB6RWFKRFpZRFRGVXR2c2FaRFhx?=
 =?utf-8?B?dzBiaElBVlVQbVlWZjFwV0dTY3JMaFdPSExyVGlpek4wTnlXa0dablBRZzhi?=
 =?utf-8?B?STFHRjMwelovKzR2N0h2YTlhbUZuVVdzMDVjK0M5QWE2SVBkdXpGK3BaRUE1?=
 =?utf-8?B?V01CWTloQ21iTGlqK3NNUXZMNnRPdWdnbjNCY09RRHJhQVBMSElKZHZlQlFp?=
 =?utf-8?B?QVp0RGp4NHpLaktBYlhQMGZDS3MvSHBlSjY5M2JrMzFPRzVFanp0Z2w2TXda?=
 =?utf-8?B?NHBFMHpZc21kZ1RmTGk5ZlQ3cUVxZTZBb091dk9lRkxhb1BQSk80SmdwMTRo?=
 =?utf-8?B?WWJkWE9zRUdQN3hVR2tsclljaXZFNmEvejBuVEp4TjE2YUhJMFkxMTE1cEdQ?=
 =?utf-8?B?Tm5GcTZHM1Q0U1E2ZHVUd1BYci9Ubk8rSThrY2VBYnZzeEMzZjE1TituM1l0?=
 =?utf-8?B?SUptYmZOUkxyZ2YxSENtWWtUYjl1ZDlYZWdoVVY4a2ppZXJnMVBucmFINzJy?=
 =?utf-8?B?TmZpbHJjcGhKVndDSkQrekJ2MkdONnl3YnpxUVpCSDhDUGtkV3Q1dVUzbURn?=
 =?utf-8?B?NmlOejB0Z1FEUGw1M0lPSndxdTBadmtPcStpSGxSS3RKMnpYUlFFRjBXMEs3?=
 =?utf-8?B?Y1l5T0Y1UzhiS3kvY2dtb1pKSEhSSDNMS3RrdmFyNVhVS3BFSU5VUHlOS2xn?=
 =?utf-8?B?aDVpWFBRdWx1VGRqaWxqWVJ2UGYrZDJ0MDBJd0NPcjNBc29hWW94MmFUZ3Ji?=
 =?utf-8?B?SktlcnVFcUNVc3FzWS9lakZ2alpZSkszZGpXaGpNeWZaMXpJeFhGRkUvYkg1?=
 =?utf-8?B?dnlzSWd5djA4dFFJMElibk5rak1JOXV6UWJmd1Ftb2htRU14OFpFalQ1VzFo?=
 =?utf-8?B?TW5hTlpMYTBKNmJIWjgzOXNJNld6SHRIM0FhK09kQzgyNEMyTmN2Uks5VTFD?=
 =?utf-8?B?NDZYalErWWN3NFZOREI2ODVrOEo1ZVBEVGYzNW15M0p0ci8zTCtyNUlDdmZh?=
 =?utf-8?B?aEFQd1NmRFZObGVGWkFKcWdXT3BUNDl6VjVhcWhVNFR4alg2aHVZQm14NjZq?=
 =?utf-8?B?UUp0K2pydVBWTHBlbDJySVZJa3Q3QVRSU0ZyM3BrRnZld2RMSjhKMXBXM0tx?=
 =?utf-8?B?OFZFb2haNHJ3UWVMdWFFbHM2M2N3eE1ubkh0WmpqZXdGVzhSWSs0aHJzbDE3?=
 =?utf-8?B?ZWFkYmJENWMzT2hxQWs2MkpBcGJ1Z0JVNnc4R1FmdkV5K215eXhzRnNkR2xo?=
 =?utf-8?B?djl4WFBKUUFwdXVuTlF3cTRlaE5ScUFSVHpMcWVuUDJoZUFNVGpOQVMrUDdG?=
 =?utf-8?B?UkxMbkxQVU9HQ05RQTdNSkhRREk3MkRSaUtEWFhLc3k3d3VXbU52QXUrUHM1?=
 =?utf-8?B?SVRsYmhRS3crZXVJaFJsdGJTSUdpSjNSOVFtam9ISW5CYU0rdVpXUU1vWGtp?=
 =?utf-8?B?RVZvZ0dFL3F5TjM1bUlnRjhlU3d5QWsyY2VWUWxyMEdFMVFHa3JLOHl5K3gr?=
 =?utf-8?Q?KhHy2IvZOvgG4en9MtELdzg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7178fe-2791-4b33-ef17-08dabc322416
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 17:54:36.5903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HvmYRhoidVl/iH9h7O5uUoj00k4VhW/4l66Eet+ULew/Hh886CqG6G2kY7X6lv6wcqVcIXAf1W+Q7m2jCeEdlN+Q96EuLi5n+A4eN9XoAr8MRH0uCSODMT8zjCuqq85J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5449
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFu
ZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDEsIDIw
MjIgODo0NyBQTQ0KPiBUbzogVGhhcnVua3VtYXIgUGFzdW1hcnRoaSAtIEk2NzgyMQ0KPiA8VGhh
cnVua3VtYXIuUGFzdW1hcnRoaUBtaWNyb2NoaXAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYyIHR0eS1uZXh0IDEvM10gODI1MDogbWljcm9jaGlwOiBwY2kxeHh4eDogQWRkIGRyaXZlciBm
b3INCj4gcXVhZC11YXJ0IHN1cHBvcnQuDQo+ICANCj4gT24gVHVlLCBOb3YgMSwgMjAyMiBhdCA1
OjA0IFBNIDxUaGFydW5rdW1hci5QYXN1bWFydGhpQG1pY3JvY2hpcC5jb20+DQo+IHdyb3RlOg0K
PiA+ID4gRnJvbTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0K
PiA+ID4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDMxLCAyMDIyIDg6MDcgUE0NCj4gDQo+IC4uLg0K
PiANCj4gPiA+ID4gQnV0LCBpZiBJIGRvIHRoaXMsIEkgY2Fubm90IHVzZSBzeXNmcyBpbnRlcmZh
Y2UgZm9yIHVwZGF0aW5nIHJ4X3RyaWdfYnl0ZXMNCj4gcmlnaHQ/DQo+ID4gPg0KPiA+ID4gTWF5
YmUsIEkgZG9uJ3QgcmVtZW1iZXIgYnkgaGVhcnQgdGhhdCBwYXJ0IG9mIHRoZSBjb2RlLiBCdXQg
d2h5IGRvDQo+ID4gPiB5b3UgbmVlZCB0aGF0IEFCSSBpbiB0aGUgZmlyc3QgcGxhY2U/DQo+ID4N
Cj4gPiBCeSB1c2luZyB0aGUgc3lzZnMgaW50ZXJmYWNlLCBvdXIgZHJpdmVyIHdpbGwgYmUgYWJs
ZSB0byB1cGRhdGUgdGhlIHRyaWdnZXINCj4gbGV2ZWwgZm9yIHRoZSByZWNlaXZlciBmaWZvIGlu
dGVycnVwdCBhdCBydW50aW1lLg0KPiANCj4gVGhpcyBkb2Vzbid0IGFuc3dlciBteSBxdWVzdGlv
bi4gV2hhdCBpcyB0aGlzIG5lZWRlZCBmb3I/DQpJIHRoaW5rIHRoaXMgd2lsbCBiZSB1c2VmdWwg
Zm9yIG91ciBjdXN0b21lcnMgaW4gdHVuaW5nIHRoZSB0cmlnZ2VyIGxldmVsIGJhc2VkIG9uIHRo
ZWlyIGFwcGxpY2F0aW9uLg0KVGhpcyBpcyBhIFVBUlQgYmFzZWQgb24gcHJvZ3JhbW1lZCBJL08g
YW5kIGF0IGhpZ2hlciBzcGVlZHMgc29tZXRpbWVzIHdoZXJlIHRoZXJlIGNhbiBiZQ0KY29udGlu
dW91cyBzdHJlYW0gb2YgZGF0YSBmb3IgYSBsb25nIHRpbWUsIHdlIG1heSBuZWVkIHRvIHNldCB0
aGUgdHJpZ2dlciB0byB0aGUgbG93ZXIgc2lkZSB0byBkZXRlY3QNCmVhcmx5IGFuZCBhdm9pZCBv
dmVyZmxvdy4NCk9uIHRoZSBvdGhlciBoYW5kLCBpbiBzb21lIGFwcGxpY2F0aW9ucyB3aGVyZSB0
aGUgY29udGludW91cyBzdHJlYW0gb2YgZGF0YSBpcyBub3QgdmVyeSBsb25nIGFuZA0Kbm8gcmlz
ayBvZiBvdmVyZmxvdywgc2V0IGl0IHRvIGhpZ2hlciBzaWRlIHRvIGF2b2lkIGZyZXF1ZW50IGlu
dGVycnVwdHMuLg0KV2UganVzdCB3YW50IHRvIGtlZXAgdGhpcyBvcHRpb24gb3BlbiBpbiB0aGUg
ZHJpdmVyIGZvciBkaWZmZXJlbnQgY3VzdG9tZXJzIHdobyB3b3VsZCB3YW50IHRvIHR1bmUNCnRo
aXMgYmFzZWQgb24gdGhlaXIgYXBwbGljYXRpb24uDQpQbGVhc2UgbGV0IHVzIGtub3cgaWYgdGhl
cmUgYXJlIGZ1cnRoZXIgcXVlc3Rpb25zIG9yIGFueSBpc3N1ZXMgaW4gdGhpcyBhcHByb2FjaC4N
Cg0KVGhhbmsgWW91Lg0KDQpSZWdhcmRzLA0KS3VtYXINCg==
