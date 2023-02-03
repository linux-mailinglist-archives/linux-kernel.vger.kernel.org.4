Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519B3689845
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjBCMIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjBCMIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:08:32 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3348E27984;
        Fri,  3 Feb 2023 04:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675426110; x=1706962110;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=2SkVTUKhg68Xyes1Eia1VvhXowRKMJhagRUF2+QDphs=;
  b=L/hdpk9u36yEWFeS8wFYzfJbldA/oaMHQN64ENJ41cafyUTdot6Z9J3U
   vl8eJDNtkmWTcWvQ8n6LroFOpxrR6Wo5nz+91P2aqyMDRFQilL6NiVUYn
   KoYzD2duyPj+CvRXp3/JbizEYgXPyiLFBkOWX08NRvHTkQwIbH/vMwFAO
   UX86lJ6cMTFo4dMNeQMwHYtT4w/cBtZNRgqXctpUW5soeYAJSKGbFkkSU
   UuJu8apacbz0sgAZHWp5Sh3ynLQBXDmiIryB2uLczaelIcYwMr3gsnAPQ
   QUU5oJdHk4yOLtgdA72CwFvO4ndW470DiKncgNIyFpN/EpdjIXOQvv39D
   A==;
X-IronPort-AV: E=Sophos;i="5.97,270,1669100400"; 
   d="scan'208";a="135422699"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Feb 2023 05:08:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 05:08:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 05:08:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yj/6YXhBhoro7FYART9zqTvY2xwEZFoLKGDMGTO6keiwd1FCyNo+gArp1QaLOpUX3gB6huXHdpJeO0WhmKflMEFnRd7/jLArMGbJdmrbQeQ3Qlexv7CHs0SeazYOVRDGIefPlPADK//ZrSa+QPUgNu1xN8h0Jakvmc6ps94SD2dgpIKnrIahAxmcV55REF4JaDxZ66OvE5RkPOCZ95Ntcll64tB1Do2W9no65KO4vJjcLdcozhpznfOK9osPtUcgVdc03oPKbHyiUYe8gZNzwZkLRqRvsFOM9ZhHVwYhCRBISh6Jlmd401pVdPo9wGJ1MI0GySMMr7jxxabrHTzSYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SkVTUKhg68Xyes1Eia1VvhXowRKMJhagRUF2+QDphs=;
 b=YaaewoTzPir7GNB0qGLdxzAQxDRB1+BZO0h8QXjqvaf/DXH+jkK+SYESYpHi4JHbbb5owI9GpFSmfwMazWWAoGNtx9tUCfeKyB8tL31yECzDjm+oNMIR3q8PpP632duK3+gxMry8j/UXsNKRrhgXYrY3uw7Q6l6TA2bRRPgcdVjCAALYTpEcea6WNCgBZmn7o+OkomtChICMSmkGC3x7t3mTl9PLLOxo6qI98TpRUESKFtx25cn6bQCOU5xt7SMonzbbZgr2+Mc9Utv4PO32Lxmt3KwzFfQlBuabqaUwiXbMdaceWn4IZmwT44TVG0C0IkOBsEDMOS7Elwf/gBcWog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SkVTUKhg68Xyes1Eia1VvhXowRKMJhagRUF2+QDphs=;
 b=U6e8C2dhMnz22tGOhIMLeacCzja/waiHh4rHCnaaiBybFXQi/9z28/lnV9w/+5lb28DKhkMzj2hn1JyVPgbWhxmeqjhl9TGNbbb1EiM4NA6lnXaLS1lw685Yg736lcw3Ue+bBOXYpS/mxYTjR6sbVmuqAtpKNtOLCB/6lJI+HCU=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by IA1PR11MB6148.namprd11.prod.outlook.com (2603:10b6:208:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 12:08:27 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5%9]) with mapi id 15.20.6064.031; Fri, 3 Feb 2023
 12:08:27 +0000
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
Subject: Re: [PATCH v5 4/8] ARM: dts: at91: sam9x60: Specify the FIFO size for
 the Flexcom UART
Thread-Topic: [PATCH v5 4/8] ARM: dts: at91: sam9x60: Specify the FIFO size
 for the Flexcom UART
Thread-Index: AQHZN8g47lyDqpzDa0ike/n/oQrW2g==
Date:   Fri, 3 Feb 2023 12:08:26 +0000
Message-ID: <f993f65d-310e-d984-a23e-2e02b1e612c8@microchip.com>
References: <20230203034833.451461-1-durai.manickamkr@microchip.com>
 <20230203034833.451461-5-durai.manickamkr@microchip.com>
In-Reply-To: <20230203034833.451461-5-durai.manickamkr@microchip.com>
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
x-ms-office365-filtering-correlation-id: 0a5e5010-f898-46c2-8123-08db05df5b36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nldWSH+e2Y2ooSEk0dI6EWXzpfGZModhBU5OIBQ1XZQSy5QRvATa7rZ4NzulrCsNu99dXX4P8jXZfoh3tMx+XUeBLOLZZ1ItvK+xC2s7JrCCymjP0aOc/2af1iuz2zbRRLChWmcuYLShPhrd5XHEHXwtLf4u/N7KBhpYz/9tx4c6MoDGECH3awBh02wcPWF3i+8UDVpZF0XoJy8HOujn4lovSbNqUc5TkaFAvl7Gfe9LFHffJnEsA4yZFMaRiERGQ8mrXWtJKfaucUsttnsPhcwyzzWDGavcr+sf5+Sz0nodk6i5j8y3gSyQAMAbnXK64WNaisVqSxQiGBbbubkgnASGpJxVqTPnp8tBgLPtYjGTBkp0vIMkLcelxEtKRVQlBcWRALVG8dvSHIYF/DT5CH+3htlXq3nJulNJ8suXMxeKGt+DdxFVo7Fj5D5irS2T2YM88F97LzxAS/0dJ0YEgyMbwc4EdMwnh+n0h0bTTndFUdtba9/hk7sTa44oLwGJCqXwshbMqLRJlA+XZFo2o5mbpXBrAzgK6lGP2zaTEV/vj19JJX/PO+uVRCrMYRCtVMxuRHC81K9Mzi7GT83NgvhwHGhnSNMtlI2xryKGR+0i2m4JpjcN+P3BR5LaACluPCpaf8D52y3QYbX95mxkjo2mPd5HfLkD1dH/PNUB25XLJMwQ0NXyibgoAUdRi5WPu7w3Gx0oZcJiZ13QE3exLnGFg4bXyxEP2BwUiRXlLo9vcSEsNd7Sqa4Ys9+9V94L2eEhqLv+UpPhKfnaopDkSJEKuzGljDVZByHUeFWoKdc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(66946007)(76116006)(8676002)(6506007)(6636002)(6486002)(478600001)(26005)(110136005)(53546011)(6512007)(36756003)(316002)(186003)(5660300002)(86362001)(7416002)(2906002)(91956017)(41300700001)(66556008)(31696002)(66476007)(8936002)(64756008)(71200400001)(66446008)(2616005)(83380400001)(4744005)(38070700005)(122000001)(921005)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXRKQWxHS0o1VUw3cWc0enF5T2diMG4xdVA2bHNRbExpcFExZFplZmtYTFdO?=
 =?utf-8?B?enpGKzdKZXRNZmpvZ2Y5NDhCcWFyU0Y1VGZjSm9jNWxlR2dvaXZFZEdsQ05K?=
 =?utf-8?B?QkE2N1JIbmpUNGZMT2o1eXkrdFhnKzNQaWhRVmRtaVZxZ1VTdTEzMFlJQmRV?=
 =?utf-8?B?YXBYSlA1UVhIcU5aM3IwWWhaSHhTVG1Mei92eFh5OE5IMmNWRnl6ZHNUUVFu?=
 =?utf-8?B?YXFIMG1KNkRUSkt4dVhBeXo3Tm1pUnZhaXVYZ3BaUGtsQ2RaQmwyNTZMV0VP?=
 =?utf-8?B?alZUSXlyeS90amhDb3pVakZ6cG0rdmgycjNGdWNvNS9USTNxTkFDa1hrRHVj?=
 =?utf-8?B?eEF4b0FTazV6enVadnRGZGhxeEhSaGJSSUhNTEpMcDdRcUkwUlRkYnYzR0ZG?=
 =?utf-8?B?TERRWXhqS05VNm4zemJPYzBjSUFzY0hSS2MrOG43YzJEREtqeGtOWmphRmZ0?=
 =?utf-8?B?WlVMM016Q25GdmVOaDBRSG1QVGg5aFBwODIwbTE4Zmw1VW04aVNFeGsrQXBY?=
 =?utf-8?B?VXpaVWM4S21ieEVvc21mTEE4UEdJbTd5aGdWdUJNTHJSOGM0RnNnQVNUSlVB?=
 =?utf-8?B?a21MZ3MycVBCcldHUitYTE1pSW5oSUhZdVVHc1MvWHdFelJablZqRXhQZ0NB?=
 =?utf-8?B?UkpvSnpySE9aOTdFSFh2V2VGVGFyNWF0OS95RTE2aDcvQ0JMY2JxZktkZ3Fx?=
 =?utf-8?B?azBBWlFrL3Y5bjNBOS83MXRJc09qZngyaW5BNWIvZDIvRkJuRmlucmVERm5B?=
 =?utf-8?B?eHdRbjRJMVlkTEs3RHNnMXUzb1J2TGJlbEhxaUNyci82NkZuMC9sNlowMnda?=
 =?utf-8?B?dnhLSG84VWNFK0RIa2x0MXFaSiswSDN0OWxJUmNBOWl2YmJSNW1hTEJwclpR?=
 =?utf-8?B?SGsyMmhxcjk1OGhOMTl6RWFCaWgzOTVMemR1dzhjN1IyR2hDOGpzRXBjeDAw?=
 =?utf-8?B?dnRkL0Z6cy8wZmdRZlhCMUtvQyt4TkVwVWQ2NTk1ZU5VLzhMU2xNVjYvU3Rh?=
 =?utf-8?B?R0RvSkk4bWVqZFgwSW91NWx0dEdUY3F2N2hTeU1oRjJHM0VQMGhhZGxXNFQv?=
 =?utf-8?B?UjVBaGVhcUlHcU5haHBQNXF5TVRSaVorTTY1RnZMSldhK3M3U2MxTzZtZVda?=
 =?utf-8?B?VlViVXFaQUZ3UGxZVCs0bU41TEJYZW5YeUdRMmx0NjI4NkJQRUhVWjRGc0wv?=
 =?utf-8?B?M1hEMnpXQVNUa20xM2dIaXpxTjIrcGZHUlY2UEtlM0NZY1JqMGpnV3k5SG5D?=
 =?utf-8?B?bEdvdFZTMmwxVEFzaU9GSStDL0dwR2Yyc09NbVA3WXp1bmo4cW1LRXpWSjlH?=
 =?utf-8?B?MW9PM0FwMmZCUGM2VnRFWExEMnJ4TXo0RUpJTEJVaWg0TFhnL1c0Znl4WVdv?=
 =?utf-8?B?azBPVC82c1BMK0Q4TXJPQm9TMlR3ZjVEZjRTaGlQQ1B4N0duajFjQ3BFUGNS?=
 =?utf-8?B?NHV6RDFIZWgrb01iYXNHYVI1UTg3Y29ZeXdOYlZqVXpwSXpXZ1BxVFFJTFNB?=
 =?utf-8?B?eFdhUGpoSzBZZitGenE2czMybzJ1WS9JOFhPeHc4SDdIWkI3N3FwTENOODln?=
 =?utf-8?B?U2pUY0RpMGY2UzVpOUxZN2NmSHRHdG9hZitHNFp4azRlVUtpUU84M0VUU3hC?=
 =?utf-8?B?N3B5TXVSamJUd3dxK2JkTzdjeG4rMzhTQWZiTlNzYU9Fc1FVMjFSNGZPR1do?=
 =?utf-8?B?NkRBVUlCTHEvcHZGVmdlVmNEOCtjU0xCKzdGWHJvNkM3M2JzcHVnN0FQVE9B?=
 =?utf-8?B?RjFkYTZWTUlJUGxRalRlcEZZaEVNVElVSHMwMGtkemNtMDZWK0haSWczamZF?=
 =?utf-8?B?K2RTWjhibm0vZS83SU1jUWpoWS95N0xQbWF4UytZeGlteHVKT2xDYWRrNWEr?=
 =?utf-8?B?OTE3cXB4dFVJNFRhekxMbTJKTTBHMEVzMEZkb3RrQ0l0VkhsUnhZckJSYmpj?=
 =?utf-8?B?dXZhVWlVYVBaNU9VNDNEeUZBM3BQUldzMk9DbmFsQjdsa3FIK1MvYzYrelV3?=
 =?utf-8?B?dVBNZU9GZlp5dldROEl2OFBSazlnY2UvR2FpRjRsaUNQOU9SS0ZwZVR0YzlD?=
 =?utf-8?B?Z2E5aEd4RzJVTXhXVVdiQnhnRVZVZ1JZR0lNUmVtd0VWYVI0a3hKWTVNZGlI?=
 =?utf-8?B?UW1Cd0o2emVhaGlSaWZYd3c3ZjlMSnZuY2ErWGhxWGZ0TUhyZWtzTGpyZGlZ?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <071122BFD036AD4FAFF97CFFA461348A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5e5010-f898-46c2-8123-08db05df5b36
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 12:08:26.8732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vrE1B32t+0l0DbxVkKX4ju+vPnHR0QFQA80RzKo5imNnBCGfE/e1zB2KINh/UMsqml5TpWmjE2m2rHEtYOwnqfQbNwEkIHPevn5UFcT0GPA=
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
IFRoZSBVQVJUIHN1Ym1vZHVsZSBpbiBGbGV4Y29tIGhhcyAxNi1ieXRlIFRyYW5zbWl0IGFuZCBS
ZWNlaXZlIEZJRk9zLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFuaWthbmRhbiBNdXJhbGlkaGFy
YW4gPG1hbmlrYW5kYW4ubUBtaWNyb2NoaXAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBEdXJhaSBN
YW5pY2thbSBLUiA8ZHVyYWkubWFuaWNrYW1rckBtaWNyb2NoaXAuY29tPg0KDQpSZXZpZXdlZC1i
eTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCg0KPiAt
LS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRzaSB8IDEgKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9k
dHMvc2FtOXg2MC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtOXg2MC5kdHNpDQo+IGluZGV4
IGVlNmNjNDMyOWFlNC4uMWU0MDFhOTE5ZjU2IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290
L2R0cy9zYW05eDYwLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtOXg2MC5kdHNp
DQo+IEBAIC0yMDksNiArMjA5LDcgQEAgQVQ5MV9YRE1BQ19EVF9QRVJfSUYoMSkgfA0KPiAgCQkJ
CQljbG9jay1uYW1lcyA9ICJ1c2FydCI7DQo+ICAJCQkJCWF0bWVsLHVzZS1kbWEtcng7DQo+ICAJ
CQkJCWF0bWVsLHVzZS1kbWEtdHg7DQo+ICsJCQkJCWF0bWVsLGZpZm8tc2l6ZSA9IDwxNj47DQo+
ICAJCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICAJCQkJfTsNCj4gIAkJCX07DQoNCg==
