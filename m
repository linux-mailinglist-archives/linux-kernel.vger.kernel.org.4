Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099CD64C783
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 11:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbiLNK5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 05:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbiLNK5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 05:57:25 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE5414038;
        Wed, 14 Dec 2022 02:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671015445; x=1702551445;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2MbVaAFUbGIYxBOKsq10kNrN2tNRgDlmXvK1HW7+eX4=;
  b=lpJEcPkpVOmXfVuUPF2kx/r6TdkY8QAE7mH91bt1jyItbjEG882VV0VJ
   15DlmN9IwPZ2HzeY6kgOkJSjEqb/uK9wlOOc214aWAyV12B8QQeD3CW0T
   ozeYggG2eYNTg9zpEhJXaC/uHbbv3vPa9MSMnV+i6Z6/YIUzuP6JYZxG7
   nRb8nGm486No9lMMGZw4luKKi3Ehy3Qouhv6We8n8Qnr8H93eq1QzL96h
   Jx1yvSR0L/Zg0mNmoj4FLuTcX6c3wTfJGQhyeq9G2i0rgglwtPQWgetUS
   tjUOQUHrQUzWswrbBKsjuaGBZWUu3TE1CW6fKxJbHDwXP9+zSODMmmSgw
   g==;
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="188111751"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Dec 2022 03:57:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 14 Dec 2022 03:57:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Wed, 14 Dec 2022 03:57:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djpH0P7J5HfE/tHru20L6HrDn6LcSjhcnV9xPaUM97r7zgRZq9OodL6kw11qkDgFnmvYTX0/z4n8LuToDNvkW1YQTX0M0mXajrt1QxpGk8qr8oNtu7kotgwjEj+9ryNeYoW6aWqcVvGUNb9ba97zeV/dTnRW5SUsV8JmEtpYHAo3EMfDHp6bBAYQGuw6r9V0IwX1lrvEcU6CpfUoXfG/EGx/3UKClveYlcID61HC6ztY1bFDw6QE2iaKqUmda8TEywm0aFfofjBJ47ECb9PHWXCiiwqynV11pUG3muLYa5TbcWsWs2dzHGDAayUPHG+dnIddAUtrlWwwwkQyZXKM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MbVaAFUbGIYxBOKsq10kNrN2tNRgDlmXvK1HW7+eX4=;
 b=iIWlrIShhAX7VqOMU2rHPU1hBpy+uP7XdawxacHQE+q82qdMUx3Fm0VfM1PTwwonFxXBhHUYCIiN/6DLgQcT1a2haP0UkDpO1rERf0ZLW3E5UdDOa+Gj6w6FZ7vuagXRniVNifGvHWtOG5TFmwOHO0d9I2S3+05SQ2iIaIyf2MKMnyjGXmfmsTP3zBEgs1sCHE5pKH94tjbW35Sf/jwld7i+yhjBijr0nUgMcIvGFMiB7rPBoLQ/NQsWEcM5FzPq8/Eimol+TwseqC8hSRmNXt6tC2Fdlfghk5UMvHrpHGOanKE9sHTx6CHjZgiDX/jsLyLmB3yihpljGYKn7oib7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MbVaAFUbGIYxBOKsq10kNrN2tNRgDlmXvK1HW7+eX4=;
 b=iD0XZunggR0Fu65jAmAorJvPZrTK/CGDlJIcTmSCBO6S1297KV0Wt/68UW7bfc1Rc6/hNwBitD2zZ/tChytcECT4t+F+nhrQjad1WsEeTx1H7iRrReQ2BceyySLEwUQ833+/GIk2iqLEc5s8J6iv7aCUustptXa1YHa+bhy1dDA=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by IA0PR11MB7257.namprd11.prod.outlook.com (2603:10b6:208:43e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 14 Dec
 2022 10:57:18 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::fb4a:4d24:6de1:2084%9]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 10:57:17 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <jirislaby@kernel.org>, <Kumaravel.Thiagarajan@microchip.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-serial@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <ilpo.jarvinen@linux.intel.com>, <macro@orcam.me.uk>,
        <andriy.shevchenko@linux.intel.com>, <cang1@live.co.uk>,
        <colin.i.king@gmail.com>, <phil.edworthy@renesas.com>,
        <biju.das.jz@bp.renesas.com>, <geert+renesas@glider.be>,
        <lukas@wunner.de>, <u.kleine-koenig@pengutronix.de>,
        <wander@redhat.com>, <etremblay@distech-controls.com>,
        <jk@ozlabs.org>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v8 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Thread-Topic: [PATCH v8 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Thread-Index: AQHZDJkj7rnAVfXmX0mY3XTqVMobIK5p4f2AgANW5xA=
Date:   Wed, 14 Dec 2022 10:57:17 +0000
Message-ID: <PH7PR11MB595874053E0688490CB0CCE89BE09@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20221211014730.1233272-1-kumaravel.thiagarajan@microchip.com>
 <20221211014730.1233272-3-kumaravel.thiagarajan@microchip.com>
 <29c707e3-be9f-24fe-107e-591f3b3b3d49@kernel.org>
In-Reply-To: <29c707e3-be9f-24fe-107e-591f3b3b3d49@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|IA0PR11MB7257:EE_
x-ms-office365-filtering-correlation-id: ee4052b5-bf7b-4604-65ce-08daddc1f73a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gXkCH7ExHSej6/5+vg7bsra8kv/C6GQ4yKAnRyhUclURANGC7YmPpQutyQQN2dNMfU3xFNC1LCkhxwc+r8ihstMMbYHhC6YUQiDq2PN3reRocce0iZMDCHmfzyQmKEE1/5EBKwl2mcYwMYYkWDOavcyTy/6NIRJHbkVmAyXLzrsWRcAxTUFowguqoHSl5jz1u4rbIV+BDdTwXEzWqfJFr1+LYERvHV0NMWP6Egu+6Z5JpdNwkV9OKNwt4CI7dE/X5Evov8mkDoMZxOoQ+hv1iU/EXC//xX+stR5+DWNSBBm5vTr3jwuRQfWSOXQuSKZ5q4zG++bLOYS6aNDOck+LxhXfwwQaIEJQrsC6T18sVVRF318X3+u7LgJntIdQ48f2zsn8hFnMP6nKJEpsZrhJjNID4t3FQwEh4RIqjcyXsBL6qbXV+sJo4JDz+3Yx5F12wZ7HyLnrUcYfK+Poa7GUbuPHzjIALp3RPV8xT7I/LDNC1dvPiwY8FBP9pStnDVbFp+Chq564PH8qOyfxmj9wg/zR2TpYWiRoO13RmaOl3q1/mcjXvoayMd8ELkePWMBu3ysRSgxWAmppvlt1lY7eDILbVcvG8f/aylhecbHGFVOZHsq1TCJWtmT1uxddrvhsaOMCdAHdUzB82mvvDpQ7DZ0Mdh8yhWmKEi7CY7FX+8NjPii/3/X7lN+qpgdXHlbRiecCcO8lM0IYlML9/yUlxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199015)(86362001)(478600001)(107886003)(7696005)(38100700002)(9686003)(71200400001)(6506007)(53546011)(26005)(186003)(122000001)(8936002)(2906002)(41300700001)(110136005)(54906003)(52536014)(4744005)(316002)(38070700005)(7416002)(66446008)(64756008)(76116006)(66946007)(66476007)(4326008)(8676002)(66556008)(5660300002)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajE5azZGck01NTBVUGdzNEtkb0xQOXh6VjA1a2lXY2s1TWI2TkVMVzlPVFht?=
 =?utf-8?B?YTMrQ1pLazJFV1NieHZFT3NjZjJxeE1CbGtVV1NLVm1ZU3paaFB6V01KREZv?=
 =?utf-8?B?OTFRb2d1R2N0d1NWUHEvSHFiYlNtMWo1ZjZVVXZpS2hxZTFFTDdQR0FOeG5U?=
 =?utf-8?B?MUpScHhLQnNaWVFzZm5ERnp0UUVGVEo2T25oNkFiTjFGdGZDckxSbEN1V3ZH?=
 =?utf-8?B?NXF5bHYvdTRJQmVLdEU3UmVCbGpNNjRKck5QcWQ1MkZGM3h1TEpGNzBJUzZ1?=
 =?utf-8?B?QVhFUmtnbWdRQXdDNWhCd1NjTzZyY1NLdlpaSDc0R3BlcVI3aEhKTFk5cTh4?=
 =?utf-8?B?UnJOZDNyOVdZNmg1ME9UUEY3L2xySnZXN3J6WkVhTFE1dlpWS2Z5ZlZlV3F4?=
 =?utf-8?B?ZUpFbDY2R2hocFZ0TXRPZXBvUzdHM0xOc2lXY1B2bmhBL3haWnRmRFhhTkNk?=
 =?utf-8?B?endBUkdJRVZoWFZ5TlRJOHdycHIyR29IM3VIeCt6UU83UU4rTmk1M29TZS9G?=
 =?utf-8?B?N2pZRzd2Ukx3QXR5cWwyTWsxRU1aNmVuK2NzOWRhWGJEWDJRUHBEOUtJejhS?=
 =?utf-8?B?SnZCaVFSYW9lTVlqL2RJVTBQaVhWZituaEJ0T3lVSkxldTJ4UktKcFI0cjdJ?=
 =?utf-8?B?TzhvRVJaR0xKREtmRFpDVm9ZSzJxekMrVy9od2FtbHVaQUdHVzB0TndRQmNH?=
 =?utf-8?B?ZHRoNDlaRlhLdnM1amttZXJmdFpMWGNCemYveTJuTno2d0NEenRLSFZTN292?=
 =?utf-8?B?Mm13ZlFtTS9iVWYvblp5WmFIbmpxRG85Mnd4M1A3S2l5MzFkaFU1NXlvbkpr?=
 =?utf-8?B?U3ZLcWd2L2JMVE03MXNYMm5qeFRkaW0yT0xGcXJMUWNHbi9iM09yVjJkQ0tP?=
 =?utf-8?B?ZW9nd0x3TTdFYlFNWVo4T2UvQis5V3c3bXZGc3g5b1p5OWJ6NlNSOFZFZHZG?=
 =?utf-8?B?M0w3dS94c1prcDhvVHAvb3JsL1Fha1c5Q2wzU2lNejF2dkh0RHZyVHpNbk9j?=
 =?utf-8?B?R2JkcWp6WDlIcGtMcXh6clovRG9YNUo0MWttNURucUdZUEp0dmk5ZElpOE5J?=
 =?utf-8?B?cGtodC9PajhIczI4dW5PRzArU2VrM0dRZzJhaWlPbDk1YzlzaTMranRiNVRv?=
 =?utf-8?B?bGkwRjQ3ZndCTnZydk9kbTBrSHVpTFRmb25Yb1dtRk5hNkt5UVAvY3p0RGZY?=
 =?utf-8?B?eGwvWkRROXZJc1JackxNUjJxQ09KTjA2a3EvMDliOE0rbktYOW9oNjQzUzgx?=
 =?utf-8?B?dGxPQzdGYkRaQmFTcElaRmJFNjZybXhFZ0sxL1V5czd0RlJEWklmSFNJd3dY?=
 =?utf-8?B?TldCbDhFNHZTNE9sNHN0Wk5lVit5cWE1QjhZN0crdTM4N3phZTQvMnBoYkR1?=
 =?utf-8?B?RHpGTFpSaEVEeXdUVFh0Um56WGJ4aGhyNmJuWWZyZmZwU3h3K3BYL0xlZGkx?=
 =?utf-8?B?WFovTm5adlJiZFdBU1JHTUZucnQyZVkyOFI3TmlxSU16TXprVDdQY2t3K2px?=
 =?utf-8?B?cC9yMVRsQUw4NEVsQW9wOG8xazREN3QyZldWMzRYQmFnWmREOVlRU3RCQnE3?=
 =?utf-8?B?dG1FUUdxZXNkVXBmWTdXbU1iV2gzNS9DOXZMTXgyOE5zMnBmSDFNUjNFZVZX?=
 =?utf-8?B?RVV6NnpnczJWek9jbGk1WU5qenUvbGtoSVp1UGtYWXNsdjRZT3Nzcno2MFo5?=
 =?utf-8?B?SmZXSGVoRzFMTE5tSUw4cjQ5bDV0SDZtWXhFRGV4Z2tnRU9ISGlvRnBYS2lx?=
 =?utf-8?B?ZnBOTFpzYUtzU0xwbFNRKzY1TldJUDQ1ekVFTGd1L0pLNzZmSTlSNDg1a0lC?=
 =?utf-8?B?QTdHeHpCeGxlc01WNWlxaisyTnY1M2lCZFJqQ1Y5ZDFnQ3drMW5qQUJ4WGFo?=
 =?utf-8?B?eUdSN0RzeU1SSElpbzV6QnlTTW16Q0FBR2lXTCt2WkxjRU0xWUlFUG5aV2pZ?=
 =?utf-8?B?L1dsNlo0NmlsRkhTMXJvQmhDV0Z6MThzN0NDV1U5bUtxek90akVycnhobGNl?=
 =?utf-8?B?SWwvOXo1S2M5bDJsL0sySXhURG5sUUsxNFZNTzNmV1NkYklJbGhXcTEwdkZL?=
 =?utf-8?B?YlhpSEZOdXhoOEhUMy91dm1Fdng3S1ZSWjNVd21laC9ROGtqTUZBdit0M0pO?=
 =?utf-8?B?WTRscllnaCt0ZDlzQUV2MWpmMUVwV2FDYzVaOHF6WmF6Tjd1Qm4rUGV0NG05?=
 =?utf-8?Q?1hbFU2Egz+NARSsHG3FhLdc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4052b5-bf7b-4604-65ce-08daddc1f73a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 10:57:17.1010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HfIOqk7x2+LFfnX6KWH/boDcl3USycjvfBh+IZ++ySdSNGv5kEoQVt3Xaa7/Kaq3JKtw7BO/KogqN9NG5uPu1/Pp1VzEF5oId4NsmzMnqMi/Cgxf/hF1RDAFIjjKbIlp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7257
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKaXJpIFNsYWJ5IDxqaXJpc2xhYnlAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5
LCBEZWNlbWJlciAxMiwgMjAyMiAxOjE1IFBNDQo+IFRvOiBLdW1hcmF2ZWwgVGhpYWdhcmFqYW4g
LSBJMjE0MTcNCj4gPEt1bWFyYXZlbC5UaGlhZ2FyYWphbkBtaWNyb2NoaXAuY29tPjsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IHR0eS1uZXh0
IDIvNF0gc2VyaWFsOiA4MjUwX3BjaTF4eHh4OiBBZGQgZHJpdmVyIGZvcg0KPiBxdWFkLXVhcnQg
c3VwcG9ydA0KPiANCj4gPiArICAgICBzdGF0aWMgaW50IGxvZ2ljYWxfdG9fcGh5c2ljYWxfcG9y
dF9pZHhbXVtNQVhfUE9SVFNdID0gew0KPiANCj4gY29uc3QgdW5zaWduZWQuDQo+IA0KPiA+ICsg
ICAgICAgICAgICAgezAsICAxLCAgMiwgIDN9LC8qIFBDSTEyMDAwIFBDSTExMDEwIFBDSTExMTAx
IFBDSTExNDAwIFBDSTExNDE0ICovDQo+ID4gKyAgICAgICAgICAgICB7MCwgIDEsICAyLCAgM30s
LyogUENJNHAgKi8NCj4gPiArICAgICAgICAgICAgIHswLCAgMSwgIDIsIC0xfSwvKiBQQ0kzcDAx
MiAqLw0KDQpIaSBKaXJpLA0KVGhpcyBhcnJheSBjb250YWlucyBuZWdhdGl2ZSB2YWx1ZXMuIFRo
ZXJlYnksIG5vdCB1c2luZyB1bnNpZ25lZC4gDQoNClRoYW5rcywNClRoYXJ1biBLdW1hciBQDQo=
