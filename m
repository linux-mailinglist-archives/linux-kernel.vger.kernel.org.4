Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAB16FBF2B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbjEIGTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjEIGTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:19:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654C846B9;
        Mon,  8 May 2023 23:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683613174; x=1715149174;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YO1cAQFt845qhWbtfy9aH1s4ZmD29DVWO8F8wQmDbRs=;
  b=EaOhWhxsruyneA768M2erSElnnEPLsMqJ0Rh3AeWM9CYLyEO5HhKIb45
   Y3jvEaYDTPS9UsJzoWnBrQ6d79hUuGmHLlqprxzozx08ogmblFWUqm0w3
   ZpdMI7854s26qcyPrra2K806PWbBiMd+SOylMmZu+e8xBsEGpORI7jBBW
   YcCAFvUBopNcQ6OQlfEzV4e4K/zUtEcq1dzLJaVFirN88XTqZstIc4HVF
   FOKvb2X76W/LL8rRp0U0idSHSbCsyq6ZDFJmu3cx983fRAaxHlzkxGefJ
   lKIJsWSdy9iAe02TVS9htmPDUoXFoQtVnA8Hpir3VoES/wFL4oSeRD35+
   g==;
X-IronPort-AV: E=Sophos;i="5.99,261,1677567600"; 
   d="scan'208";a="212515098"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 May 2023 23:19:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 8 May 2023 23:19:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 8 May 2023 23:19:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzQiPd8tN88J9O8uv1TQu2Xl5p3425G0gICnOfhb0khgRIr/SNW5o+v7iffUuhZh3nZy9/XeCNpBS1adjoBawKkk6t1iDZRwjvM8BhlxMJhVLkTZ0+bZxlfNvHySOfNC/6D5if69kxtJLccgKa+IOItUzKJd5v3fAQwCvehmEdfvQO/Z9nfw3fTWWBIgiVPxaaaKhr43Y7tJPV6rHaIh3BcGbQCxMMOG5aKTCReVUKFRys0vyQRZ0bSGpUv271J3TWPxmexBonT1+8TEmSTHIl7liBjntZt3wFPzaHEG3VonP6qtz2QqZ2TXtpfPvVrmvktt42Q/8oQNaDHbltufkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YO1cAQFt845qhWbtfy9aH1s4ZmD29DVWO8F8wQmDbRs=;
 b=Q/cf+CKh+z0WV2x8/JR8Cs4kJVMPzyohMB8fhFrIkkVuR3y8LzNTGM8yJGdMwWpapJ11dQIxNpe2GjSB1xL17br5EYchp3TJMmYeABMHmqAaCNXgn6Mlbxt9QfAnoTeEX0tRkU/jM6gHgzXBtw02lSQHP8IdHMsqMllBNi6WLEpdUQpX2IzOtl6HPv+LUArEGoccCOFE4UGfGUpx+3ePxwhdDxDhDPEUl2XIMNxZaOsAMBYVpda7c7spH8dDu8A00hK1ABrhUHSFsdkiYgSyM+tC4Ta/iFYnR5rjgXqvyAIG5yo2KiLEeR3U2LVllxdoFy9Al6moOdfQHnH9EfVR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO1cAQFt845qhWbtfy9aH1s4ZmD29DVWO8F8wQmDbRs=;
 b=HkZfVnM+hUT3ohp1oldo0skW796u0v5N77BZVr1+CiYzzIIU2yeaemKv/pncxM35YQHIAQEYk0hjhp7xlpgdOrIyC+eiMIzxkRpypJUfZKwMUHjr2ZV1gZFEAaA/QXYNhyn4mAAQU/NT74Ao5UIStj7TaM78u++n8z03qMPoojo=
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by CO6PR11MB5651.namprd11.prod.outlook.com (2603:10b6:5:356::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 06:19:29 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::c13:dcee:8af:bbfb]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::c13:dcee:8af:bbfb%5]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 06:19:29 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>
CC:     <mailhol.vincent@wanadoo.fr>, <linux-can@vger.kernel.org>,
        <marex@denx.de>, <linux-kernel@vger.kernel.org>
Subject: RE: RE: [PATCH] can: length: add definitions for frame lengths in
 bits
Thread-Topic: RE: [PATCH] can: length: add definitions for frame lengths in
 bits
Thread-Index: AQHZgPxeZaBnd1NvTEynohb4vwVjlK9QCmFwgABA9wCAAS8YwA==
Date:   Tue, 9 May 2023 06:19:28 +0000
Message-ID: <BL3PR11MB648455424B202C28F3352E7FFB769@BL3PR11MB6484.namprd11.prod.outlook.com>
References: <20230507155506.3179711-1-mailhol.vincent@wanadoo.fr>
 <BL3PR11MB64842FA5ECB64DD2C6C9FA76FB719@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230508-paralysis-disarm-fecee3f8a625-mkl@pengutronix.de>
In-Reply-To: <20230508-paralysis-disarm-fecee3f8a625-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|CO6PR11MB5651:EE_
x-ms-office365-filtering-correlation-id: dabf2787-8dce-4b66-4b4c-08db5055586d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P2Y8WjF11E5MNR7Gat5URsBJ4GxSwkm1av3TI3MeVzUN6qCc9SKBawUpBjfG7F0VaEWa8Oqas3tFHs9Mh0OLIYeo+sFMxOvpHmObG3zb4aB5q736B+S5+LTLCOCrTxADk76NZyjkwLK/WE8l6qflJR9m+G8K1CUMO9iKBXLQGzt5PkRdOA+4ethuRQGLn3qQvfiHIHW81/neA2Vjst9YND8u1uHzTtxCr1Iz0YvvHhgOJhzpGajlEg9v31XcfX7cw/wi2bYFyZAbYPTNt3iVitcQgRkmq/mthLNwalBvCG4k6nbRovJ1+L21kP9YaoMe2AJGlbOpCGsdIPdtj9VvgH9I5ItDfRDq8nGUMhv9EnYqJAmsEUFGbkvnxL43pkIrEvn3uQmPFAhNJjm3AnLASgicwJS8z3rs3gCZuT1iGA+dsmSoApm2SQV6Zfn2ta5fH/rsHE/5EtgL/ufePaDp3UpGadZPWOD36+TS8aJbb/4gLNPa7lFeu81vT+pHgvt77riz7K4JVvVkkstxRz4YELsBczecKF+nyPfrwR/Y/PvKrAAA/IEENGcTMvg89iI9nMB5qIrVLBKzEOo4op4wJHc8enwwe1OADFMrXdNmvA0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199021)(966005)(86362001)(54906003)(38070700005)(316002)(7696005)(66476007)(41300700001)(64756008)(71200400001)(66446008)(76116006)(66946007)(6916009)(66556008)(4326008)(52536014)(5660300002)(8936002)(8676002)(478600001)(9686003)(53546011)(26005)(38100700002)(6506007)(186003)(2906002)(33656002)(122000001)(83380400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmxpTWp0amsrZzNGSzlFbk9EUmx1UUhXTTlJeklmTUxUZEJMUGJ5cGxPcWFi?=
 =?utf-8?B?bktSVU05SVR1Y0NhS0FUemlqQ2NvbVBoaFppbm1tR09vaEg2em1nNlRLeVZt?=
 =?utf-8?B?WGNKNThnN3N5d3d2NFJVR2ozenBVWG9ac2U4aWZNQUdUWkdGcnlFUlA4UTJF?=
 =?utf-8?B?YTdWSHUwa3haaW5ucEliZjdRZVRDdnZDRStXSGRDa2tPOUw1Y0EwMldTM1pF?=
 =?utf-8?B?TS9MTnczU2hSaFNjMnpnSEFZYjR3bTFFOVI5aDd4azFDVHVqampESCtkeUlV?=
 =?utf-8?B?Tk9LRlFPaVhTTHQ5RzFkaWV1M2U3b0VtOVVmczlvdElKUDRldUVzRlE3TFpi?=
 =?utf-8?B?Y3lOc0xuUWwzZVZtc0JDVGRQRGJ0cEhnaTJGbURuWjUyTzhPVjNKY09HTmU5?=
 =?utf-8?B?MFhQQytvcDY4SXNnM2tSNU9idWV1NFp1OE55S0N1MVhGVXljdTNiQ3pYemZY?=
 =?utf-8?B?NmkxaEd5UWVJVHVySVM5Rmx2MUxWemUwRVNNL2pRaGpWcEZtRVhGeXRBSzhu?=
 =?utf-8?B?RElQeC9JbXM2bWhtZk1KbURFMGZKZFRXSHh5SGJrU0h2OGN3TFdqUDU0YW1P?=
 =?utf-8?B?OVE2eHpkcFgxRm5GaHl3MEE3czkxV082NDN6cmtudi9vT0pyQ250dEp1ZGJG?=
 =?utf-8?B?M3loWmQvU3JwQ2lHeUl4SDlPZ2pBbzVaZW5CL1JqRnhlcW1RY2V2a2JMcitZ?=
 =?utf-8?B?S29kcy8yNTJLdUdFMlR3dVp4V2dwM05idEpFZmdVNlZNN211T2hsdDU5UGFy?=
 =?utf-8?B?dTZWZEFZSXUzeGtuNm5LMklBUzlIeW5iK3A3dGxqZGRGUndWM2c1SU5JQW1D?=
 =?utf-8?B?U1VNQytPMFpTYkFHUnlNMFR2b0w0clhSUWU1VEIwR1JUTERmRkd4ckExYXBV?=
 =?utf-8?B?TzAyaUQ0S2VMVjFON21kUHBtQ3pCaGRkR01XbjZkUHhWdGhTSzZtc2JpdXkz?=
 =?utf-8?B?c21VeDhtNTR4MmxOL1EzNEwvdWNlNDB3UEswTE1PWi84U1U3NmtURDVKTCsz?=
 =?utf-8?B?OEtCT2VrWmxEM0hFcjJDWmpXcERpTUNKakVkVDBUdml3ZEdhSkNWcmQ4L0pO?=
 =?utf-8?B?MGZqeHdBVXQ0Qlc0Z21OZFcxUWt5RVlPOFp4NGRyUDhLVGJnTERQQ242WTNJ?=
 =?utf-8?B?TXN4b3VhSVdPc2dlVmcrZ2FzWitKenhBODJBWmFxMWQrczJSMFBtdTM3NENN?=
 =?utf-8?B?UDlGSGN2cEhtL3YxSGJoYXFJSnBBRkZyTmE1VWx4M3lvUXFIKzVaQ0hHUUE1?=
 =?utf-8?B?eVJmcmNORG1mQ05kWFpmOWFOUWQ0TFZRQnVMa09BSkY0NzVBNjFOSUJBRDls?=
 =?utf-8?B?eXVBL0dKMDdWM2dlRTczWklxaHI3OEdLZzV3UjRzckZzNm1QaFhTSUEwRjN1?=
 =?utf-8?B?bC82WWdyait3VVU0ejd1T2tpWkxYbFpUL3lJSW96U0dzLzRBY3hETHF6Ynh6?=
 =?utf-8?B?cjhJT09Mb0xRWWc2bmw4OExIV01IaGozc0YzaUN2M0t0b3pFcHJ2UmZTVWZj?=
 =?utf-8?B?cTJKSlV1MUZwUnZ1S2FTYzB1M1RlbHdYMmcvcDdudTl0MHBzMmRveVVNOG81?=
 =?utf-8?B?bnhzY2hhYUtRcjkrYS9LTXdvNlY5NWlZU0kyeDBVbWJ5RUg0NmJYemJaTU5S?=
 =?utf-8?B?MStRRk5Id29nNC8zTEo5NlRPZnVLei84UDdtckpRQVJGQ0RRNFJzK2JBYytH?=
 =?utf-8?B?ZUwva2hzUFRnSjhnTlU2dkVKcWtPSmlISHJoM2NaT3JIUThROUw3WTZIQWcz?=
 =?utf-8?B?K3dsd1JSVXhyYm1OWE1zczVhM3lhRnA4UHBzcFZ5L2R1ZjA3YTZsbk5KTW8w?=
 =?utf-8?B?OXpnQW5HOVQ1THoxV09rWWJ4SnB3SHFHT0hVOGFmYmtTMGhCZGVDN2pEbFFp?=
 =?utf-8?B?bS85cDZqNm5lMGdnN01ldFUrcGM0U0hrS010SmZ1LzhYVkxadDBJeHk5Y0JP?=
 =?utf-8?B?OW1JL0hicGVlek1INXpEUzczQjRNaEYwRS9YZlVLaUNKVTFicXFla3k0OFFT?=
 =?utf-8?B?dmo3T21Gd3dSaDlFOXdJeGNHWmFuSFg0bjdZMit5Y2pVak4xMWNHc0I4d1FG?=
 =?utf-8?B?bkdIbnFlVmhBVDNyaURmM240R0tWbE5JMmRmMWd6by9VaTEzWlBQbFA5SFZt?=
 =?utf-8?Q?7ki1drbGlhgSUKenfDrPPGbFq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dabf2787-8dce-4b66-4b4c-08db5055586d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 06:19:28.8640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZPEXtMJBVx9T2p8GysFjOzuWYLK8iBl5q1mBuQ23JqTqvl+Mavc77Not3cUck2OksQCCZtRN7ldNmm5NhtyH5ufK5KKpCruH2DP4QeslTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5651
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,URI_DOTEDU autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAwOC4wNS4yMDIzIDA4OjU0OjE4LCBUaG9tYXMuS29wcEBtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPiA+IEkgd2FzIHdvcmtpbmcgb24gdGhlIHNhbWUgdGhpbmcgb24gRnJpZGF5IGJ1dCBkaWRu
J3QgZ2V0IGFyb3VuZCB0bw0KPiA+IHNlbmRpbmcgaXQgb2ZmLCBzbyBoZXJlIGFyZSBhIGNvdXBs
ZSB0aG91Z2h0cyBJIGhhZCB3aGVuIHdvcmtpbmcgb24NCj4gPiB0aGUgZGVmaW5lcyBpbiBsZW5n
dGguaA0KPiA+DQo+ID4gVGhlIGRlZmluaXRpb25zIGZvciBJRlMgaW4gaGVyZSBhcmUgY2FsbGVk
IGludGVybWlzc2lvbiBpbiB0aGUNCj4gPiBzdGFuZGFyZA0KPiANCj4gQUNLLCBhbmQgSU1GIHNl
ZW1zIHRvIGJlIGEgY29tbW9uIGFiYnJldmlhdGlvbi4NCj4gDQo+ID4gYW5kIEknZCBhcmd1ZSB0
aGV5IHNob3VsZG4ndCBiZSBwYXJ0IG9mIHRoZSBmcmFtZSBhdCBhbGwuDQo+IA0KPiBUaGUgZGlh
Z3JhbSBpbiBodHRwczovL3d3dy5jYW4tY2lhLm9yZy9jYW4ta25vd2xlZGdlL2Nhbi9jYW4tZmQv
DQo+IHN1Z2dlc3RzIHRoYXQgSU1GIGlzIHBhcnQgb2YgdGhlIGZyYW1lLg0KDQpJJ2QgZGlzYWdy
ZWUgYXMgdGhlIElTTyBzcGVjaWZpY2FsbHkgc2F5cyBpdCdzIG5vdCBwYXJ0IG9mIHRoZSBmcmFt
ZS4gVGhlIGRpYWdyYW0gb24gcGFnZSBQREYgcGFnZSAyMSBvZiB0aGUgMi4wIHNwZWM6IGh0dHA6
Ly9lc2QuY3MudWNyLmVkdS93ZWJyZXMvY2FuMjAucGRmIGlzIGFsc28gaW4gdGhlIElTTyBhbmQg
c2hvd3MgdGhlIEludGVybWlzc2lvbiBvdXRzaWRlIHRoZSBmcmFtZS4gQWxzbyB0aGUgd29yZCBJ
TlRFUmZyYW1lIHNwYWNlIHN1Z2dlc3RzIGl0IHNob3VsZG4ndCBiZSBwYXJ0IG9mIHRoZSBmcmFt
ZSBhbmQgbGFzdGx5IHRoZSBkZWZpbml0aW9uIGlzIHVzZWQgZm9yIGEpIGRldGVybWluaW5nIGhv
dyBtYW55IGJpdHMvYnl0ZXMgYXJlIG5lZWRlZCB0byBzdG9yZSBmcmFtZXMgd2hpY2ggZG9lc24n
dCBuZWVkIHRoZSBpbnRlcm1pc3Npb24gYml0cyBhbmQgYikgdGltaW5nLCBidXQgZm9yIHRob3Nl
IHB1cnBvc2UgdGhlIGZyYW1lIGhhcyBlbmRlZCBhbHJlYWR5IGFuZCBpZiB0aGUgdGltaW5nIG9m
IHNldmVyYWwgZnJhbWVzIGlzIG5lZWRlZCwgY29tcGxldGUgIGludGVyZnJhbWUgc3BhY2VzIG5l
ZWQgdG8gYmUgYWRkZWQuDQoNCj4gPiBUbw0KPiA+IHF1b3RlIHRoZSBJU086ICJERnMgYW5kIFJG
cyBzaGFsbCBiZSBzZXBhcmF0ZWQgZnJvbSBwcmVjZWRpbmcgZnJhbWVzLA0KPiA+IHdoYXRldmVy
IGZyYW1lIHR5cGUgdGhleSBhcmUgKERGLCBSRiwgRUYsIE9GKSwgYnkgYSB0aW1lIHBlcmlvZCBj
YWxsZWQNCj4gPiBpbnRlci1mcmFtZSBzcGFjZS4iDQo+ID4NCj4gPiBTbywgbXkgc3VnZ2VzdGlv
biB3b3VsZCBiZSB0byBwdWxsIG91dCB0aGUgMyBiaXQgSUZTIGRlZmluaXRpb24gdGhhdCdzDQo+
ID4gY3VycmVudGx5IGluIGFuZCBpbnRyb2R1Y2UgMTEgYml0IEJ1cyBpZGxlIGFuZCBpZiBuZWNl
c3NhcnkgMyBiaXQNCj4gPiBJbnRlcm1pc3Npb24gc2VwYXJhdGVseS4NCj4gPg0KPiA+IGluZGV4
IDY5OTUwOTJiNzc0ZWMuLjYyZTkyYzE1NTMzNzYgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9s
aW51eC9jYW4vbGVuZ3RoLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2Nhbi9sZW5ndGguaA0K
PiA+IEBAIC02LDYgKzYsMjYgQEANCj4gPiAgI2lmbmRlZiBfQ0FOX0xFTkdUSF9IDQo+ID4gICNk
ZWZpbmUgX0NBTl9MRU5HVEhfSA0KPiA+DQo+ID4gKy8qDQo+ID4gKyAqIEZpcnN0IHBhcnQgb2Yg
dGhlIEludGVyIEZyYW1lIFNwYWNlDQo+ID4gKyAqLw0KPiA+ICsjZGVmaW5lIENBTl9JTlRFUk1J
U1NJT05fQklUUyAzDQo+ID4gKw0KPiA+ICsvKg0KPiA+ICsgKiBOdW1iZXIgb2YgY29uc2VjdXRp
dmUgcmVjZXNzaXZlIGJpdHMgb24gdGhlIGJ1cyBmb3IgaW50ZWdyYXRpb24gZXRjLg0KPiA+ICsg
Ki8NCj4gPiArI2RlZmluZSBDQU5fSURMRV9DT05ESVRJT05fQklUUyAxMQ0KPiA+ICsNCj4gPg0K
PiA+IFRoZSBmaWVsZCBjdXJyZW50bHkgY2FsbGVkIFN0dWZmIGJpdCBjb3VudCAoU0JDKSBpcyBh
bHNvIG5vdCBjb3JyZWN0DQo+ID4gSSdkIHNheS4gSSdtIG5vdCBzdXJlIGFib3V0IHRoZSBoaXN0
b3J5IGJ1dCBnaXZlbiB0aGF0IHRoaXMgaXMNCj4gPiBkZXBlbmRlbnQgb24gdGhlIERMQyBJIHRo
aW5rIHdoYXQncyBtZWFudCBpcyB0aGUgbnVtYmVyIG9mIEZpeGVkIFN0dWZmDQo+ID4gYml0cyAo
RlNCKSAuIFRoZSBJU08gZG9lcyBub3QgZGVmaW5lIGEgdGVybSBmb3IgdGhlIFN0dWZmIGJpdCBD
b3VudA0KPiA+IGJ1dCB0aGUgQ2lBIGRpZCBkZWZpbmUvZG9jdW1lbnQgaXQgdGhpcyB3YXkuIFdo
YXQncyBtZWFudCB0aG91Z2ggaXMNCj4gPiBub3QgdGhlIG51bWJlciBvZiBmaXhlZCBzdHVmZiBi
aXRzIChGU0IpIHdoaWNoIHRoZSBjb21tZW50IGltcGxpZXMNCj4gPiBoZXJlIGJ1dCB0aGUgbW9k
dWxvIDggMyBiaXQgZ3JheS1jb2RlIGZvbGxvd2VkIGJ5IHRoZSBwYXJpdHkgYml0LiBTbw0KPiA+
IGZvciB0aGUgRkQgZnJhbWUgZGVmaW5pdGlvbnMgSSdkIHByb3Bvc2Ugc29tZXRoaW5nIGxpa2Ug
dGhpczogUmVuYW1pbmcNCj4gPiB0aGUgY3VycmVudCBTQkMgdG8gRlNCIGFuZCBhZGRpbmcgdGhl
IFNCQy4NCj4gDQo+ID4gICAqIENSQyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAu
Li4xNjogMTcgMjAuLi42NDoyMQ0KPiA+ICAgKiBDUkMgZGVsaW1pdGVyIChDRCkgICAgICAgICAg
ICAgICAgICAxDQo+ID4gKyAqIEZpeGVkIFN0dWZmIGJpdHMgKEZTQikgICAgICAgICAgICAgIDAu
Li4xNjogNiAyMC4uLjY0OjcNCj4gDQo+IEFzIGZhciBhcyBJIHVuZGVyc3RhbmQNCj4gaHR0cHM6
Ly9pZWVleHBsb3JlLmllZWUub3JnL3N0YW1wL3N0YW1wLmpzcD90cD0mYXJudW1iZXI9ODMzODA0
NyB0aGUNCj4gRlNCDQo+IGlzIDUgb3IgNi4NCkkgZG9uJ3Qga25vdyB3aGVyZSB0aGUgcGFwZXIg
Z290IGl0cyBudW1iZXJzIGZyb20gYnV0IGl0IGFsc28gc2VlbXMgdG8gYmUgbWlzc2luZyB0aGUg
U0JDIGZpZWxkIGNvbXBsZXRlbHk/IFRoZSBJU08gc2F5czogIiBUaGVyZSBzaGFsbCBiZSBhIGZp
eGVkIHN0dWZmIGJpdCBiZWZvcmUgdGhlIGZpcnN0IGJpdCBvZiB0aGUgc3R1ZmYgY291bnRbLi4u
XSIgIiBBIGZ1cnRoZXIgZml4ZWQgc3R1ZmYgYml0IHNoYWxsIGJlIGluc2VydGVkIGFmdGVyIGVh
Y2ggZm91cnRoIGJpdCBvZiB0aGUgQ1JDIGZpZWxkIiBOb3QgdGhhdCB0aGUgQ1JDIGZpZWxkIGlu
IEZEIGZyYW1lcyBhbHNvIGNvbnRhaW5zIHRoZSBTQkMgc28gdGhhdCBhZGRzIGZpeGVkIHN0dWZm
IGJpdHMuDQpBIGdvb2QgdmlzdWFsIHJlcHJlc2VudGF0aW9uIG9mIHRoZSBGU0JzIGlzIG9uIHRo
ZSBmaXJzdCBwYWdlIHlvdSBwcm92aWRlZCBhcyBhIHNvdXJjZTogaHR0cHM6Ly93d3cuY2FuLWNp
YS5vcmcvY2FuLWtub3dsZWRnZS9jYW4vY2FuLWZkLyBhbGwgdGhlIHdheSBvbiB0aGUgYm90dG9t
LiANCg0KDQpCZXN0IFJlZ2FyZHMsDQpUaG9tYXMgDQo=
