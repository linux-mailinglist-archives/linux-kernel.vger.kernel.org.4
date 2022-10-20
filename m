Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CCF605A74
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiJTJCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiJTJB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:01:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC57197FBF;
        Thu, 20 Oct 2022 02:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666256501; x=1697792501;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ClG+Q4Fk5DsmtyyWJvMgs2LkzwYSgM4lKc5h4I3Yktg=;
  b=DbNL4iMqJRed/Wc3G8Vb+gcebAJ2GjIRxT+KN/bEwQrILud2iJvCjTYP
   RTuJxNnZWo5X7A38B4Nn5OfcRcumq1NnQ/mWDkiZBPaiXwVBm2I/UejHF
   eBq3//Op2jpOmF2yU8sBQB52NEvdIo6lIeFgySrPTnlXfBC6qZxD7qeFa
   8RpWysv+gmTeFixHRu3kIILZM2gEhwp6ysLQlNZsbbgsWUGxIhT4YABHe
   lh8p+J6hP8RZRP43YssRZMNEd8iJGvY/no9/GkPJbnZZ8m5N/sg1b1+m+
   vReztwYiHnLhtMiTzZo15eI8xLHtDXa49yVUsCXJlRzzQOo9dQtxO8m0j
   A==;
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="183102983"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Oct 2022 02:01:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 20 Oct 2022 02:01:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 20 Oct 2022 02:01:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjGPYar38TmWHhbMyQsppphrFu9kKMWlARxPlQbxlvarhslTHPP8uG2way01qepsoIN1dj4mrxG+mV8yyN/Woi8Uvm0OwcEa/Jd5BqwNvhSXdu1Y9nBvy5vF8MZsf58ZfvfHF4USpHGpY+4dONqBJzqj0n3dvE5ZKZzDCPgMgpvQXgMuu2AY7UdyK7UvEH/IsHxCMs3t2v0TEkNwzYdt8Yu2/TT+ussFkhWYeT98deUetwOs6wLZ9EtCHoyuF14ZjKjXKAFLX1Yj00R97MVS8imCuMrqNOTZOEpsweWs4LF/nAKpkqjlkAhjMUELplM96PNp4HSXoR8d+VblTLrbSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClG+Q4Fk5DsmtyyWJvMgs2LkzwYSgM4lKc5h4I3Yktg=;
 b=Q2cMGFhtPMs97aeJF9LQyuZu8aKFMsmciuOrrTeTxh2KEuctx57CPKyDhwVhpPEebiimsiNDZy8RnD/RmCIcuVVgOntJ//D0hth7u5czJsfLrMTRFxM0S6N9/8TO+YVssuubtLfgaaHahhVyhidkbM9CZTItqoaPrPUPV9c5pdQvF3Yco7Tz1Ph+rQPckWMUg4oTF3EMPWtFGh4mL9zWA6w9Ogvt0V/+qV6ZoYfz5GTP3/0WIqUzn/HZYV9v5eUIi9qgbMp9aSFiEGOZ/M5GggV9YHM1A15k2X0GwAAbLmh9QT1caxttmKxrBEfzEtJYdcSamAtzE44vGVoLgoFbUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClG+Q4Fk5DsmtyyWJvMgs2LkzwYSgM4lKc5h4I3Yktg=;
 b=D8WJv2m5b5u9VIKlRZ9H2QwoV2Hn97QwJdMM/BwW9rr7UYOAijztnQgced4HN2yMKjAMKFICVTpAkf/QJMipRB/Vy785fZ1nDiPvXvTrciUWLtarJpjRdoaGGGuaAXJDDJg4iNPYMCFjmeqy36QoL16513CwXK6yv1sjeLpZjAE=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM4PR11MB5550.namprd11.prod.outlook.com (2603:10b6:5:38b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 09:01:29 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 09:01:29 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <ilpo.jarvinen@linux.intel.com>, <linux-serial@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <richard.genoud@gmail.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 11/44] serial: atmel: Use uart_xmit_advance()
Thread-Topic: [PATCH 11/44] serial: atmel: Use uart_xmit_advance()
Thread-Index: AQHY5GKKP3OxmxYVP0OWNftzWTcHSQ==
Date:   Thu, 20 Oct 2022 09:01:29 +0000
Message-ID: <8a47af92-98eb-b2cf-c022-1a1987ff8449@microchip.com>
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
 <20221019091151.6692-12-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20221019091151.6692-12-ilpo.jarvinen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|DM4PR11MB5550:EE_
x-ms-office365-filtering-correlation-id: 4fd50403-3bb7-4c56-8349-08dab279ad7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q+mtGZrtyqPueO7IGWgJ41H8hmab3ayBNCtvC/XS6JNZbwg6gElhNz1meWXP0PWTfUsgl6OvQe/qPyqJdUJDqWrTjccVfFwSFduxrPegXrCPZrSFQyq1t/OOzEc99H/9JJVaW+MLAoZubUF/aK9jv9lC+dq3WaVylyYyD45qnW/sA1o27TFRQ5Hb/TXP/72wn3aZQJgMNhw0eaFJLeLwLMjNuaG4/iqyQkWUcjztbOa2LygoyB8nbNkZsZV8YESxCvCVQR/BiZJuHsQNnHq0NCi7PRPcIFikUz3JmcI+XTVPD7jWiNs/hjvd4gG78xlhSeAEsMKXF3fj9mWXpbrWSqu+O/trO4EC/YPx779KnVvlndpqTjgy5bKarF2mf9DsupCl3SahYBqMJ+BaX2j01ZUA6wznvxfKCOtRY0VD7ABIlDoBDVj426S/va/VDztOY3jjcQZYzbtGVtTNDRUkY4u6O+dbtrRDYFiF0VNFwmKMZoNolVPL/OZUlt2a7HJvj6gC3jioyGUiJM3Xf3sC32qrKBZAY/xH0umRfn/Z4Wfdrsip7Ri/0zOYN/ZT09Yg8jNmlM1blIxzZGo8P688VwKEhbx8dEhLPyzfi5A5KmTpBSy18u7wAumXTLHce3bpmoAMYA7nlAZqadFzELNIevB774hNR9c7O/kP975q6wgYNPmrT43uM4DRl0GO/LcnvICks5kPhHSIfpwlwrSZ3PgUVsxwZlR6ZT1Gs/HlMnflwg99YzIHnMZJDahmKjkjgfhxtf7KgbObQGWe9l6tbc5WpJR/RGOezSBGbARxxIq/xvIk5g8UMhKfsjubastl6A3z53uj+TsDvQrfrYYEmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199015)(478600001)(6486002)(186003)(31686004)(2616005)(71200400001)(2906002)(8936002)(91956017)(53546011)(122000001)(83380400001)(38100700002)(66574015)(36756003)(5660300002)(316002)(8676002)(6506007)(38070700005)(66946007)(66556008)(66476007)(66446008)(64756008)(41300700001)(4326008)(76116006)(31696002)(6512007)(26005)(86362001)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blEwNlFJenpSODhBSk91aktRUE95cGRhTHJDQWE1WElmRFpRdnRwTzFtN3Q2?=
 =?utf-8?B?Rk5MbXBpdmNRSW1wTTQ5dkh6Vk9aczlwRzZCc3l4RDkxcER3ek1FbmtVdC9X?=
 =?utf-8?B?Uk5pSmZIQmVWbnhzYTFpSUduMUVQdHlFK3Y0T1lUOTB0ZU1HUUdhb3c3T1Az?=
 =?utf-8?B?a1hrYUg0Ukk5NnJxME9EaFRhV09OTzFZdk1CczY4QkNxMlJEeEpsN0tGaTI3?=
 =?utf-8?B?cWJvWU1mb2VxcVBjeFlhMm1BMXFtNmdZYVhvV0FINU1NdG41NDI5MUtQVmVE?=
 =?utf-8?B?Zk9mVXVmS3FDcEdiblZZS0phbnFTaFB4T3pnZEtyWDhOMHFSZkdJandRbUkw?=
 =?utf-8?B?cG1oMVduVForWk42dGtCb0RoSmxuaHZCU244bS9lcXNick55b3VCL211L2F2?=
 =?utf-8?B?am84UW5XWndFNFFBbjQvZ2E1K1lHdjg4NVZueTY3Mm9qakdWSllQOTVJT09B?=
 =?utf-8?B?NERXc0xSb1lTVWR1NjhCRGR1YkR4YTBhMko1R2Q3MDZWbkNvN09qQ2VxbEtp?=
 =?utf-8?B?RmpXdmFydHNieVBtL1hMdERNeVJvOGNnNVRpOENiNzhjSGNUdFhrRDRjdnBt?=
 =?utf-8?B?N2NOQWtNS3kzRnRqT2ZpeGcvQWg1dTg5WjFNSVpJRUo5Vk1hSzZFSFh3dE93?=
 =?utf-8?B?UmJJaUlMdklRZDh4WnJ2MGZtbEJ0VVZXSTJmTmFSRlllNTk2dVFoZ2FBQ2sr?=
 =?utf-8?B?bVNSTzdUS204bC9wK1FQUVBpUmltYWV5TXZkZzI5NytPR3h6YU1mb0JHRU42?=
 =?utf-8?B?S00raXd0WHpZaHlMVXRSWWJPbDE1OC9uMUQzNG9uS2s1ayt0a2MzNnJrNEo3?=
 =?utf-8?B?RzBVOS9SSmpFc0JCaSt6dTlqcnNCaGxvdisvVUt3M0FHWnkxdGFZa0NFZzlr?=
 =?utf-8?B?S1lBaUFxRkdVeUE4RGN0djRMdjRjbVp1YXFabER2VDJsZktrcUdOWWdUQXph?=
 =?utf-8?B?RjYyOEZaeWc2S0VqQmlMeGVEUWREbW9ZRmRMWEJEbEMwVUpwd2JiZ3FSKzFC?=
 =?utf-8?B?Sm9qUVhhNmZ4a3VTaTByay9Ba0lYQ21RYVBValB6VS81dm42Qm1nZElGVjRw?=
 =?utf-8?B?VjRsNGlFYkw5dm02aGFDOStmME03WFljU0dTakNyTVo3L05rVnl2MlhCNGFn?=
 =?utf-8?B?em5mM0pUUG1ZTVU2cDl4MHdITXU1WmRFbjNieHl2UkZUTk5OVlJHaWplLzdq?=
 =?utf-8?B?RHlsQ1d4ZXhKdnVBSDFTaVR3ZW52eWZyMThPQjR4ZlY2NWxMSmRLRU50ZjBO?=
 =?utf-8?B?bCtrclZkczA4WXNIMVBpRENQMDNvQU1kcTc3UUdlRFdqRU02MVRjejBsL25r?=
 =?utf-8?B?QUJWcVdINlNCRHdHcUZhMmhLYjdBVjZtVnlkV2JXLy9Bd0xTbStNaTdMNFMx?=
 =?utf-8?B?Q1I4cjN1YjI5eUNHWDFZOGZFdm9zTlMxMzlCcUlQaS9RR0FHRnRMQ1p1Y3hq?=
 =?utf-8?B?WnlvT0xkMW1HeG4vVFhEbXAzMVA0bFhzZWhDL2FCcjhxZVJxZkFTbjF1c1Qx?=
 =?utf-8?B?YXRCdmYya0l0bG1NQ1pZTGwyaHlWaXN0Z3JwU29GSVhJTGhkT3NTVTlBNDBU?=
 =?utf-8?B?bUd2a3pkUmJpNWpBczRPRnpBeVlRNzVwVExMQWtxaDBJaGhGdzNYUm55ZGRD?=
 =?utf-8?B?by9GM0tOK0ZaNVNTKytkWGJ6azF3UGJEK08vamVFSnRYQWhHdnM4M0p2Y1ZL?=
 =?utf-8?B?eFNWSWQ5Y3J1alhWYUIybGVrMGZ4RHU4NmVSYUhDN2l5SStlTFFHYzZ3QlhZ?=
 =?utf-8?B?cExXZVJtMnlHOUJaeHRtWnEvbXlTbkoyTW9QVWpKVmlGT1dkTUg1bE8zbUNz?=
 =?utf-8?B?U3I3di93S21PTExIMm5ISGVaRUF4MmVURTM0SCtwUDkwVmsxcUFjVGJuYVNx?=
 =?utf-8?B?WllKWDEvd0ZmalZkdHFzRHB4MEhPcXhuWFNNU1A2c1RoUkJMUEVxeEowd3RQ?=
 =?utf-8?B?SUkyUEZCYUJ6OU1NM3BBOXNIL1VYQUt2emp3U2ltU3ZuV3hweENFelh5TzhS?=
 =?utf-8?B?SkE4czlwLzhzaFVKUmk1VmpMVjcwaUowaUFidWR3YjkzRTM2QXFLSHdmTmxG?=
 =?utf-8?B?R3lDK3BRa3kxSmY2dEFlcmRmcS9NQmFKeFNvdlNqUGhoVkYxU3krdGwrdVhX?=
 =?utf-8?Q?tWHDsFqu4heXgeKbwLWBs8mIM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B3FC255DC1AC845A1E35C92F90CE7BE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd50403-3bb7-4c56-8349-08dab279ad7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 09:01:29.7061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j5mVChb0FIo35+UOzDiP29Cv6yEvs1KSmuB12w7WGyatohneFkyLrqjft6GSPFcCPUwmGeH2uY3gzdUHy5uBs01nwlfHhSuOFci3ww2OR+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5550
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkuMTAuMjAyMiAxMjoxMSwgSWxwbyBKw6RydmluZW4gd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGFrZSBhZHZhbnRhZ2Ugb2YgdGhlIG5ldyB1
YXJ0X3htaXRfYWR2YW5jZSgpIGhlbHBlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IElscG8gSsOk
cnZpbmVuIDxpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENs
YXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQoNCj4gLS0tDQo+
ICBkcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMgfCAxMSArKy0tLS0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMgYi9kcml2ZXJzL3R0
eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMNCj4gaW5kZXggYmQwN2Y3OWEyZGY5Li40NDg1ZjJkMjZi
NzcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYw0KPiAr
KysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMNCj4gQEAgLTg3NSwxMCArODc1
LDcgQEAgc3RhdGljIHZvaWQgYXRtZWxfY29tcGxldGVfdHhfZG1hKHZvaWQgKmFyZykNCj4gDQo+
ICAgICAgICAgaWYgKGNoYW4pDQo+ICAgICAgICAgICAgICAgICBkbWFlbmdpbmVfdGVybWluYXRl
X2FsbChjaGFuKTsNCj4gLSAgICAgICB4bWl0LT50YWlsICs9IGF0bWVsX3BvcnQtPnR4X2xlbjsN
Cj4gLSAgICAgICB4bWl0LT50YWlsICY9IFVBUlRfWE1JVF9TSVpFIC0gMTsNCj4gLQ0KPiAtICAg
ICAgIHBvcnQtPmljb3VudC50eCArPSBhdG1lbF9wb3J0LT50eF9sZW47DQo+ICsgICAgICAgdWFy
dF94bWl0X2FkdmFuY2UocG9ydCwgYXRtZWxfcG9ydC0+dHhfbGVuKTsNCj4gDQo+ICAgICAgICAg
c3Bpbl9sb2NrX2lycSgmYXRtZWxfcG9ydC0+bG9ja190eCk7DQo+ICAgICAgICAgYXN5bmNfdHhf
YWNrKGF0bWVsX3BvcnQtPmRlc2NfdHgpOw0KPiBAQCAtMTQ3MSwxMSArMTQ2OCw3IEBAIHN0YXRp
YyB2b2lkIGF0bWVsX3R4X3BkYyhzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQ0KPiAgICAgICAgIC8q
IG5vdGhpbmcgbGVmdCB0byB0cmFuc21pdD8gKi8NCj4gICAgICAgICBpZiAoYXRtZWxfdWFydF9y
ZWFkbChwb3J0LCBBVE1FTF9QRENfVENSKSkNCj4gICAgICAgICAgICAgICAgIHJldHVybjsNCj4g
LQ0KPiAtICAgICAgIHhtaXQtPnRhaWwgKz0gcGRjLT5vZnM7DQo+IC0gICAgICAgeG1pdC0+dGFp
bCAmPSBVQVJUX1hNSVRfU0laRSAtIDE7DQo+IC0NCj4gLSAgICAgICBwb3J0LT5pY291bnQudHgg
Kz0gcGRjLT5vZnM7DQo+ICsgICAgICAgdWFydF94bWl0X2FkdmFuY2UocG9ydCwgcGRjLT5vZnMp
Ow0KPiAgICAgICAgIHBkYy0+b2ZzID0gMDsNCj4gDQo+ICAgICAgICAgLyogbW9yZSB0byB0cmFu
c21pdCAtIHNldHVwIG5leHQgdHJhbnNmZXIgKi8NCj4gLS0NCj4gMi4zMC4yDQo+IA0KDQo=
