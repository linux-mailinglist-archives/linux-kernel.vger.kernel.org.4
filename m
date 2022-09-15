Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03265BA2F4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiIOWow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIOWoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:44:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84C41CFDB;
        Thu, 15 Sep 2022 15:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663281880; x=1694817880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8VBEnP5uviota3xYKxJoZToE5RFDC3SyIoWTWFyVVh0=;
  b=ftTiNd0mEoSFJnMs2jHZeUOscY5SSV63ZPMm7dsihTrBS5IrR2+wWVAu
   JVki2MaVJM4hE0tyg+mQngq4P7iN8Q63YU5EbSyVyJyvGxJ+AJkXYGrEl
   jl/C9CA9Cc/Z8seIRHBoeAFnwXCvS+I6oGJUJONRKIWTumqh03B9f//TL
   CMQ46yczAfeACPozM9idAJ5Z7LHW0LfuswK9E54cOLxCt+FjO6sG0wqaM
   qxdbhYwvVWblnzyshw35Aj4Dw2/PaX9XpvSEj6zogmSFWi6M4zg49Xmlm
   /Y+iPqSBlHF+aiOkktSt5x3RR68tYoe76gFt0brNjnOtYcZf3NesT2muD
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="191074835"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 15:44:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 15:44:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 15 Sep 2022 15:44:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8WAeORODidA5sMcmEaRuA4+y1QTKc634EoJT5sCQHYSSg5E6uC3qCNzAUfLfC5ZdYM5Uy7WZxI98/AcShrc2kCaU+FGw08jNGh/95h3So9BgQJmNbQRb0qytcGT/EMj+rZUgbKdCt2rNzI/LLwrGJL1laPO+sVxxL5G7TxsaHqUYxeFdvQXcUedbYsc1TNM0Oz8ZlBgrdZpVTWItSaYT0uLczvoIvjsYb0NzkHGa0YMAeQ5mh6rNOf7idEkKbLofxrk57tMI3vY5jm4e2BGTRSWt1DHoET08em7pgpESqcCrP2l50/z85IUmPtgTcSmm5fTwoBDshHs0iXJbp69ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VBEnP5uviota3xYKxJoZToE5RFDC3SyIoWTWFyVVh0=;
 b=as462rnYM7H7tVxDuEahT7QuEEMfV4jHhBk6pNU0oGdY6VZPBFxpBv/moQ21oJxl1N26eKaGlhq+YvR45OvTDmF8R5SQv5bY39pbTDcTglUeyBTREuOhrtMs+Ag8xYnscCmhI2wygRYUjIo78RxBNjPqLmYJ24bFO2HhqkS2ARtlomUW/OCtdQsytN1n3gW/lg+G9a+wwmbSPQSDgsxWWaXUURtFLmWWKnXw3TKM5QWMXYRxmVjK5bHrSqOCRAfUo6gcNTW/TXULm+9UKTNMa5Xoo7kSC98Lg9wKyjUd5gVgR9HsLTMBIdwHUY+vTt7L2TasMkEfYbodPWrH7WhhlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VBEnP5uviota3xYKxJoZToE5RFDC3SyIoWTWFyVVh0=;
 b=UNx50jwTtIyNmxoky8jVJE2Y6AN+jdQLnkQfXIvvUAGiSUVbGc0MkVu1YLc3ZbHqfpNx8PV4Bvi8hCK3QNygIk9iwJPbWfvCUzNNCi25F0bDASDG2plBUzhAwSEv4exRHffTAVZjDgaPVACCfuskAD0AUcT3bEBO52/Epfg8AuU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SN7PR11MB6994.namprd11.prod.outlook.com (2603:10b6:806:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 22:44:34 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 22:44:33 +0000
From:   <Conor.Dooley@microchip.com>
To:     <prabhakar.csengg@gmail.com>
CC:     <geert+renesas@glider.be>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <heiko@sntech.de>,
        <atishp@rivosinc.com>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 08/10] riscv: dts: renesas: Add minimal DTS for Renesas
 RZ/Five SMARC EVK
Thread-Topic: [PATCH v3 08/10] riscv: dts: renesas: Add minimal DTS for
 Renesas RZ/Five SMARC EVK
Thread-Index: AQHYyS+CXmAo8qhj2U6alOFiZ8SwGK3hCb+AgAAMmwCAAAC4AA==
Date:   Thu, 15 Sep 2022 22:44:33 +0000
Message-ID: <cdd42171-872c-cb6d-e540-240b233b74fc@microchip.com>
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915181558.354737-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ce1bb9c5-c1e3-b6ff-ec8f-c9ae1f0bf3b4@microchip.com>
 <CA+V-a8tWaKPNmNjJY6sX1yyUz1V5S7JXP+Eenxo4jOtu7uXXLQ@mail.gmail.com>
In-Reply-To: <CA+V-a8tWaKPNmNjJY6sX1yyUz1V5S7JXP+Eenxo4jOtu7uXXLQ@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|SN7PR11MB6994:EE_
x-ms-office365-filtering-correlation-id: 2fb04423-93d8-48f2-112d-08da976bdbdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DHV6wwsRc+55eJnVI2EppAZIck/R5ABeIyy1WNaMXOXwo0vMU3wLbKu7s8ULrZzI1i02BMbcJMRkG0C/XAKwr24GVrYRgKcQ7AYRdoLsNv+lfrVijiKvNqd8IiaDZhZgfmfdnaq7Yhdcr5nxYVk/uVZFT0m7fExzunN0PjCq66P9xT3KNmjdNRFA3DOwR8IBo7rGCYdSvDU1TW5zbwWR+BMqvYljAMpOTxvMMaVoXDRt35ACsoN+sYEH+CZ3OMqp+y0VPPGwZQvrTaLJLGg30CwhaUg0qVUMUhTAGJINNqb9OxuV0V4PaQ4ThTFoqB+NxqbuqeaZw5QrqtCCP21Q8ndtNVAjqilsBRvaf5ecUaOTQGpnRqTIdXnihMKWvvGFRO4Z8tlbznIt9cJAklqUCBLkmjF0G+FhG/hKsOGwMh6lGQFfFVE7w0RnW61yjOC0smkBhpt4dLr8zNPVrkdCa+NKHINefp0NTKq2T0rHDErnUmDEsQBorDApMTrxMMMYHja3lG9qo52mcySbS0e32fy34MDuo/n96iHgrq3Lp2uXllFb6tm5JRjlpjlkpqbaU8t6zthX3X7pbJ+e8ds9jOVY0YVQ3Jb6YprrCynbJVKBCSsiDm/ydOhXRoBrFK+ntOk4fLa8Qu9F0cqVc2l7JarRvNtVdb2aUL4E0XOlbI6JJgMB5PUm/3Va421nP2XJBRdMg6DXxLaU4Ib6hiRXfAYWRD1MzXmIkusZ6bouWGhT4RS2wPA/V5uTzimivpCOzMp7Q08+h6w0/7B7/FDZPqIUh78/cZAEysheI2xMW7f6mZRzuibaXV1h02oqTfA3+vQqwrcz/20/qBxfZ1WFIWf7UJChHLlUp0JnRsoLijdZTW/l46+sGm/3AunZsteHbP69yuF+aXKGM0qfxYKBUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199015)(4326008)(6506007)(66476007)(64756008)(8676002)(31696002)(66946007)(26005)(83380400001)(66556008)(186003)(316002)(71200400001)(122000001)(7416002)(76116006)(31686004)(2906002)(478600001)(6486002)(5660300002)(41300700001)(53546011)(38070700005)(66446008)(36756003)(2616005)(966005)(86362001)(91956017)(6916009)(8936002)(38100700002)(6512007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWlSKzNZRUx6Vnc4QW1oRUVZY2doZ1R2Uy9WaCtHU1ZQdVd3eUREOHFWMXdo?=
 =?utf-8?B?WjN4Uk1oc01HZldVZmpYMUV5cU43UGdaV2psU3lkenBEangwRXY2cEhTS0RV?=
 =?utf-8?B?Y1g1QkdsdXlwbmprL3pjK3F0MW0xMmZyQ2ZHV3dOM0VGK24vQnU3TEdTMnZu?=
 =?utf-8?B?Q0x2bENHbGoyMDU2WmJzV2ZxcGErbkVTUDAvcnZ5SDJ3M0E3Y2lIV0pzMklL?=
 =?utf-8?B?eEJjWFZ0Z0VGalpkRGtvOXhDeTVzS3FwbmM4cDlvY0hZcjhCYlFjS09uWUh2?=
 =?utf-8?B?RU9vb1hocHVja1lDeXZnbGVaeDlxUUJ6bU83Q0g3UmpCYlorZWNNam9BL1Zl?=
 =?utf-8?B?RHB2MDhDVm5jOUl2bERqWXc2ZEJMNkpkV0doaEVXWXEweUNYWGdIekZET1Q2?=
 =?utf-8?B?WTVKbU92NnJrL0Fxa0x1OVl2dUUyQm9VLzBuM1VMMGRBZlgxWW9EQkV3RE1u?=
 =?utf-8?B?Q3NzR1Y3RUNsR1l6TG90c04yQlZ5QkVXbzgwZThrZDZLVUpVeGZXY0NWYVRY?=
 =?utf-8?B?aTZzb2o0WE1HVm9VVVBiWkcwWDM4VFRJMG0wUml0bVNwRTYzeGltR0grNXM0?=
 =?utf-8?B?eXZEMVNnd3dEOFB3YzFFQjRlTnk2aDE1c3M0djBEN3JLMEhjbE9iTG1WaTBP?=
 =?utf-8?B?RzBqbGdRQ0tRUFBRQUhYZFlLcnZFQ0JzODVDK1lPWWxLU0oyNmhjUVU4VER4?=
 =?utf-8?B?eGZaRTExTDdRRzZOMEpFRnBLaGRqWnhCK1RYQUplNXBQTlEyWWVKT1BvcGFn?=
 =?utf-8?B?SUUrcm4rYlhTRGhQdWFobm55WkFMM0QvVS96blpLcHpuOS9VNFBBc00xdGdK?=
 =?utf-8?B?S2hkcXpsVktjOUFqYlBudE96VDhsb3BhdUUramg0amlhbHAyWVNSTTFGWlky?=
 =?utf-8?B?aXdZbTdNQzNuMUVLY1hkVHR6MXdMZTVYck1kcVp6eXYrNFlnK2pRYTQyUUdr?=
 =?utf-8?B?S0lEY1VTWW9hOENGd0FUUitKMm1XWlVYODRGemF0TzBleHlRb1hGbmNNUERG?=
 =?utf-8?B?d2huS0xHQlF1UUVPRnFvMW1jTVV3Mm15SGFLMVpWa2x6WUNDYmM4Qk1hZ2l0?=
 =?utf-8?B?Z3Y0b0NBZ2wvKzlaWHczWUY2R2dsWFhyVWFJdFN5L1QvbHdlaU1UVUZQSDk3?=
 =?utf-8?B?OW9TWkR2eGxUREQrTEdBK1dONm9tbC9xUllzRHk3eHh0SjlVL1hVVjNDM1Y4?=
 =?utf-8?B?WGlETlRmaGlwV1BJU3V6NjB6TW9FU0M1R25ybDdRL21DTGt1NU5lR3V4WG1G?=
 =?utf-8?B?NnEweWpDVnhweHlQb1U0UFpad2hNR1NwNjRLWmlYSmFXUFRtUmJZbHJqNDVr?=
 =?utf-8?B?aUlEZW10VEQwV3ErNUtTbTJncEJvN0xuSDZIQXhiSWkyazFSTUZyRFgwVXBW?=
 =?utf-8?B?QjUyT2I1eU9GZlBFSTVMVWZQMSt6K1FHWHBDT2hVOVJnbWppQmFsYUZWbGpV?=
 =?utf-8?B?YTUvOUw0Q2JpeS9DYW9FSXBsZ3N1UVZuZk5vczJQamdsRGlPbVJ5NXROT0dY?=
 =?utf-8?B?MFhmYmQ4ZHdkVExwOThxays3eWh3c05oQnZRUkQ3eS9zUHU1MURrZU8vUkg2?=
 =?utf-8?B?ZWtKSWppeVJ5YmF0cWVVaUFYay84c2pJUU1kS0lodDZHZktuOWsrRjRrb0g0?=
 =?utf-8?B?MmVyS01kVVlVUjdXb3BaTm5pSEUyYzFyM3VSdk9jQmN0R05qclUxQXUwZ2pk?=
 =?utf-8?B?ajk1K3BZOFQ4alNCOFNGdGhrUWlMc0JWRk1HUlZkVzFUKzRmdUZobEQ3MXRV?=
 =?utf-8?B?R2xYeEZjN0Q0TTVycGErVTNpcDZXUHk5OERnZmgvRGNYbWZtR2Zoc29TRU5p?=
 =?utf-8?B?ai9Cd2Z4emJ2NzFjdkpMNGp6Z3Q0WUFRTEtvc05uK01nMnUvY0FLKyt0WE5q?=
 =?utf-8?B?MkF5S1N0dUxVL3d5N09PRnhCVFJnamI2bHZKTVh6WFBEcHUrSmUzSzl2RzFQ?=
 =?utf-8?B?bnhWemwwbVQvR3FEQnpzZk8vbWlIbHBFSXdaZVcvYncwTW44dldmVjUvd3pL?=
 =?utf-8?B?bWxNa1Z5SU1BRnBCMzdFdUs0QmxWbDZBT1B0WERXWXNBY0srT1Z0LzRyTmY1?=
 =?utf-8?B?UkZFcXdndUp6UXJwUkR4eERSR250RmJnQ01hN1lXV094dXBSRXgzWmQvRWFz?=
 =?utf-8?B?bGpWN3pPWmI0TjVOQ0JVVXdBRUR3SUhMQUpXeTNTZUFrVjVPdU9QWTdRdGdR?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0619203CE8739640AF88A5F00DB19547@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb04423-93d8-48f2-112d-08da976bdbdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 22:44:33.2313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJCFcL8nX0oNH2Eumhe4XePtYmijYecbwASO+cbxR3rYHtdk/FRqfmcLTrvQ/Ta5udkvBKoK78lnqYOIcN+9l4SMEe9AIEarKmUuuvAupfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6994
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE1LzA5LzIwMjIgMjM6NDEsIExhZCwgUHJhYmhha2FyIHdyb3RlOg0KPiBIaSBDb25v
ciwNCj4gDQo+IFRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCj4gDQo+IE9uIFRodSwgU2VwIDE1
LCAyMDIyIGF0IDEwOjU2IFBNIDxDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+
Pg0KPj4gT24gMTUvMDkvMjAyMiAxOToxNSwgUHJhYmhha2FyIHdyb3RlOg0KPj4+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gRnJvbTogTGFkIFByYWJoYWthciA8
cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPj4+DQo+Pj4gRW5hYmxl
IHRoZSBtaW5pbWFsIGJsb2NrcyByZXF1aXJlZCBmb3IgYm9vdGluZyB0aGUgUmVuZXNhcyBSWi9G
aXZlDQo+Pj4gU01BUkMgRVZLIHdpdGggaW5pdHJhbWZzLg0KPj4+DQo+Pj4gQmVsb3cgYXJlIHRo
ZSBibG9ja3MgZW5hYmxlZDoNCj4+PiAtIENQRw0KPj4+IC0gQ1BVMA0KPj4+IC0gRERSIChtZW1v
cnkgcmVnaW9ucykNCj4+PiAtIFBJTkNUUkwNCj4+PiAtIFBMSUMNCj4+PiAtIFNDSUYwDQo+Pj4N
Cj4+PiBOb3RlIHdlIGhhdmUgZGVsZXRlZCB0aGUgbm9kZXMgZnJvbSB0aGUgRFQgZm9yIHdoaWNo
IHN1cHBvcnQgbmVlZHMgdG8gYmUNCj4+PiBhZGRlZCBmb3IgUlovRml2ZSBTb0MgYW5kIGFyZSBl
bmFibGVkIGJ5IFJaL0cyVUwgU01BUkMgRVZLIFNvTS9jYXJyaWVyDQo+Pj4gYm9hcmQgRFRTL0ku
DQo+Pg0KPj4gaWRrLCBJIGFtIG5vdCBzdXJlIHdoYXQgdG8gdGhpbmsgb2YgdGhpcyBhcHByb2Fj
aC4NCj4+DQo+PiBXaGF0IGRvIHlvdSBtZWFuIGJ5ICJmb3Igd2hpY2ggc3VwcG9ydCBuZWVkcyB0
byBiZSBhZGRlZCI/IElmIHRoZSBzdXBwb3J0DQo+PiBkb2VzIG5vdCBleGlzdCB5ZXQsIHRoZW4g
aXMgc3VyZWx5IHlvdSBjYW4ganVzdCBhZGQgdGhlIG5vZGVzIGFuZCBpdCB3aWxsDQo+PiBiZSBm
aW5lPw0KPj4NCj4gQXMgcG9pbnRlZCBvdXQgcHJldmlvdXNseSwgSSBhbSByZS11c2luZyB0aGUg
YmVsb3cgZmlsZXMgWzFdIChTb00pIGFuZA0KPiBbMl0gKENhcnJpZXIgYm9hcmQpIGFzIHRoZSBS
Wi9GaXZlIFNNQVJDIEVWSyBpcyBwaW4gY29tcGF0aWJsZS4gU2luY2UNCj4gWzFdIGFuZCBbMl0g
ZW5hYmxlIGFsbW9zdCBhbGwgdGhlIHBlcmlwaGVyYWxzIChzdGF0dXMgPSBva2F5KSAgb24gdGhl
DQo+IFJaL0cyVUwgU01BUkMgRVZLIHdoaWNoIGFyZSBzdXBwb3J0ZWQuIEZvciBleGFtcGxlIFsx
XSBlbmFibGVzIFNESEkwLzENCj4gdGhpcyBoaWdoIHNwZWVkIGJsb2NrIG5lZWRzIERNQSBhbmQg
d2l0aG91dCBjYWNoZSBtYW5hZ2VtZW50IGZpeGVkIG9uDQo+IEFuZGVzIGNvcmUgd2UgY2Fubm90
IGVuYWJsZSB0aGlzIG9uIFJaL0ZpdmUgU29DIHNvIGN1cnJlbnRseSBhDQo+IHBsYWNlaG9sZGVy
IGlzIGFkZGVkIGZvciBpdCBpbiB0aGUgUlovRkl2ZSBTb0MgRFRTSSBhbmQgaXMgZGVsZXRlZCBp
bg0KPiB0aGUgYm9hcmQgRFRTIGZpbGUuDQo+IA0KPiBCZWxvdyBibG9ja3Mgc3VmZmVyIHRoZSBj
YWNoZSBtYW5hZ2VtZW50IGlzc3VlOg0KPiAtIERNQUMNCj4gLSBFVEgNCj4gLSBTREhJDQo+IC0g
VVNCDQo+IA0KPiBSZXN0IG9mIHRoZSBibG9ja3Mgd2lsbCBiZSBncmFkdWFsbHkgZW5hYmxlZCAo
YXMgc29vbiBhcyB0aGlzIGluaXRpYWwNCj4gcGF0Y2hzZXQgaXMgbWVyZ2VkKSBhbG9uZyB3aXRo
IHRoZSBEVCBiaW5kaW5nIGRvYyB1cGRhdGVzLg0KPiANCj4gWzFdIGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yemcydWwtc21hcmMtc29tLmR0c2k/aD12Ni4wLXJj
NQ0KPiBbMl0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
dG9ydmFsZHMvbGludXguZ2l0L3RyZWUvYXJjaC9hcm02NC9ib290L2R0cy9yZW5lc2FzL3J6ZzJ1
bC1zbWFyYy5kdHNpP2g9djYuMC1yYzUNCg0KDQpFeHBsYW5hdGlvbnMgYXJlIHJlYXNvbmFibGUs
IGJ1dCBhZ2FpbiAtIHRoYXQgaW5mb3JtYXRpb24gaXMgaW1wb3J0YW50DQphbmQgcmVhbGx5IG5l
ZWRzIHRvIGJlIGluY2x1ZGVkIGluIHRoZSBjb21taXQgbWVzc2FnZSBldGMuDQoNClRoYW5rcywN
CkNvbm9yLg0KDQo=
