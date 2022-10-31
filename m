Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30A16132AD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJaJYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJaJYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:24:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0803ADEB2;
        Mon, 31 Oct 2022 02:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667208272; x=1698744272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4aKpJlUy2Wc5vz8x5tfA2YOzLZxTaUYlEkZBLQoZajY=;
  b=M0pwNfOf4la6ybnOHvd7ibJuEQN6tXBEZhm1KBNIzKsVv//KlA5OigeR
   4H3f3i7eCUg43Z3oChAmc7OShOxxZe50v4IhBWXfJjUJ+g1XqJ1hNXQ2K
   HkLr6NjHnM7sSJeq/FI5aMb1dWeFDWizfzyaXsuhyKn7yGekcKClofCb0
   9E2W8spo1FBIZkUcSUu9E/6DATY94oiSDZO0cofiu2hXOlA7/ac37uPZs
   Wmum5DthvM9iDzDnszTOOxmZ68MPz3DrG0pkv3Urnv+jwe2I6aMEFQveJ
   bpLMoaT8FztxgmsN9AqA9zfidsz712SqSoyxbtXj3GQfbeBcxuKJhmqLr
   g==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="197710080"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Oct 2022 02:24:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 31 Oct 2022 02:24:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 31 Oct 2022 02:24:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IknHk+e6V3nw0b2nB8U/soCc5EMJLf+7XGsxRT2NyYA4O+uOxppH8yOE+h47kwxFGAgnFV9Jyx+h9/Daqul6AKDVDU84ucNvIYJ8p0LUT8+O+mEq0lZD3/LDuRsjhYGb2t5+nKSbufePTGPnI+TADAVVAI+yFfRgKqEgZDKYnqw0XCGF/Tf8EaKIQvqrH4h69CZysIZ3VItHM6HX/mylG9RoFLO+znC3erJ8YGQIXYpBV3gzqoB8ENzoitD+3a0Dm+shvIEZHGqernOT+CY/ZEKbe4m/ozat+8FQKy0mjmbTLTmRUvO6O511lpI9Ee5JKgqPLB1EI80rA6jhBy0cSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aKpJlUy2Wc5vz8x5tfA2YOzLZxTaUYlEkZBLQoZajY=;
 b=dTN8wCHEUTJId+Un9nyMtrOuHC26JirvABG/JG1wk5Q7jytZoLyyd/g07a2f+yrfTBL8PVd0HpA0+AuO+C9nQMi8Jj7IeIvv/NiPT+mU9Y+LcTL/K2HmsoIDTPlbQ4QXwHeNr2XOids96Fv9nhGiMUAtD3/gMUXhZAeRaRlYj0ug0T0WnhzLXHLlNBvWA51ikrWKub9QrV3WRyXRFb3WCTUJerdfwfmzNVabtBhDRklkWlKqDCwRg3y4bP555vyuRbFPQ4gtsO17kLjsseZqFpHu1R58LlDJY8Z3d+IM/NNHShm0/oUKvy5nw08J/ZCsEhW9ecM2VraT1zA+ok/5YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aKpJlUy2Wc5vz8x5tfA2YOzLZxTaUYlEkZBLQoZajY=;
 b=AA/WEBDJYYjbxpn18/pANSyZbzQCIgp8tmzp3+JyHTBAnLW5RUi9syq+CPpBB5739X8CI8qzCWpD7adleq+997hQonkJIkBjtDtjrZvQT+39OlcJushaZBRgTl1EfXI3B6Bwhdi1PjOrFXzhM58GoBmD8cIz7e+qUQb3ossaFSo=
Received: from PH0PR11MB5096.namprd11.prod.outlook.com (2603:10b6:510:3c::5)
 by DM4PR11MB7399.namprd11.prod.outlook.com (2603:10b6:8:101::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 31 Oct
 2022 09:24:25 +0000
Received: from PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::1cfb:5030:3f7c:7add]) by PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::1cfb:5030:3f7c:7add%7]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 09:24:25 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <andy.shevchenko@gmail.com>, <Kumaravel.Thiagarajan@microchip.com>
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
Thread-Index: AQHY1V1ECgbqKV8AiUiKZBGdoHOFW638aLWAgCwAOWA=
Date:   Mon, 31 Oct 2022 09:24:25 +0000
Message-ID: <PH0PR11MB509629C9B80D4331AAF0E5AC9B379@PH0PR11MB5096.namprd11.prod.outlook.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
 <20221001061507.3508603-2-kumaravel.thiagarajan@microchip.com>
 <CAHp75VfoWii5Eo4n=-JcqE4VZMRoq77jjdTMGfwBF+vzKBXPog@mail.gmail.com>
In-Reply-To: <CAHp75VfoWii5Eo4n=-JcqE4VZMRoq77jjdTMGfwBF+vzKBXPog@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5096:EE_|DM4PR11MB7399:EE_
x-ms-office365-filtering-correlation-id: 38869cd1-9d4e-4f7a-e252-08dabb21b3f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kT7E4QmHFUQxOSBjNzHYQ43lbCSsSZe7WfoGF7o1ajECnC/c1IJ+MWlKaAOq2XLLKdkEklPOYIQHOjBXJ44UNFx0+jCBeMEeiebqk4Qo8MAIEYXA+O+JxJhNv+bCeTquGcrb/ClUQJo6jZQGF+BsBqP839tRBDZtoSK+SbbmQrO6JuoCEc6CcdvXEY3JsGKKHpj1GVNVh2wY4Vbrbt/GyDLHRLkLphwvmSklaub0WkvEVTSBPLSpwmJcDGxXphew8dkryMjgvw24+OjHZKS15LJKQCYNHzEpx2JSMcJtfTylV/dDS3iW1jdXXmp9QCcCClqp8uYNUXvxqimMxpiPkEbyJBcEj7PVmj7QGdAtM9cH3CI/V28gLNOsH5us4OyZOJB8bLgg85LI56VfXaxF/QIFy3mbpUznbM97KmVx2PHpcY1+jJ00uI+QLmHgLZb9KLh2LhDkLJ8HQq2g387nQyegUWW3ZU8ko7uhFqzLwHgQ9NYB8SUm+ACCUj772OFtfKCYMHDr4vjygvOhhcfPYVugd+pIs1HmtMXKyjsPN5dTuSMlTRrRFvqd/IzUhR6OWFOfNMQi3M64O9E71mJvSsl8hnbQySd/pl9ADHqI5g7MHnmO4ge5ecfuhc4m0ov0sKkEdtmtj4BC4xY38CQF88p3wQ2v60sZQUvGMHro1pD+Vhak5Fp/HnxUTtghHfCPU3QjI3DI25jTg2C46qMaUNgOHnaxomFnFbvjgXTe8AyTgIVfv5czxyU5X0bL7N/6eiDuuQ3LupfczbLHJAcujfX5QaD506qvfrbt7eMGzoGvpLCcCki4lt+kfgU1pT8MoClXlFxn16hPNddp+q8kNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5096.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199015)(55016003)(478600001)(2906002)(83380400001)(86362001)(33656002)(71200400001)(107886003)(7696005)(76116006)(9686003)(4326008)(8676002)(26005)(316002)(41300700001)(8936002)(5660300002)(6506007)(7416002)(52536014)(54906003)(66556008)(6636002)(38100700002)(186003)(53546011)(66446008)(122000001)(38070700005)(64756008)(66476007)(110136005)(66946007)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTRRd3gwSXJlRGExUUhMMjROWnNLL1ozVGJOVHVyYlZxbXJpSEh0Nzh1Z1hq?=
 =?utf-8?B?RXIvb3NsbTRQZlpwbm5UT1FLeWExZ2Ura08yaFVZZ25IcXo3MksrcGJWODNB?=
 =?utf-8?B?QS9FU1dpeWp5YW41V3kza2NHTVVyMFh5NnBLa0JNWnVRdUg5aHZqaUNINlFQ?=
 =?utf-8?B?ODBKM25KUXUvb3liRTl3QmsvV2dHc21Id1ZWMUV5ZERLRGRkU3NBZWRpYmUx?=
 =?utf-8?B?WFowQU5HYzRtdEdPVTdSelk4L00zbFEvbS9HNUpKaWlnT0lhcnhFUTN4K2pM?=
 =?utf-8?B?OFlJeHJ2RnZIRTIvVkZXSTBEM1crTWluZXMvM0F2MnQzMWZ1b2JlaFNJbEc2?=
 =?utf-8?B?VlorM1E4WXVvckx5ZTZkY1BXM3p3QTNtL1lGYWpON25tKzhNY0UvcS83MzlD?=
 =?utf-8?B?T3dDZ3RDTkt4VkNJSnQweVJzR0NwSUlmVlJTd1liVnAzdG1vaTRqUWd5ckVh?=
 =?utf-8?B?Rmd0cDV4RW9QSXFCNVJuZi9jdW8yRU9PRjhXbTFtL0VXVDFkeGcweFJPdis0?=
 =?utf-8?B?aEtPWU4zU0psRnk5K3RyRkJWQjlUeTlRKzdUQzN2ZU8wa1ZPcVo0TGdvTFZk?=
 =?utf-8?B?QXBlVjZEY0s4b25mU29lL0Q3aHBoL0loZ25XM2xYN1FuMFZpeUtoR2dqVGV3?=
 =?utf-8?B?d1g1REpWcE0rUjZMenEvZU9RaHVrcXZWMjJQTGRLbTMrTC93VmViODRCQi83?=
 =?utf-8?B?djdBLzZzS29YbjVucWErY3ZCcnB2K0pqdU5MUWEvaldYcm0yUTgzcENOcUVs?=
 =?utf-8?B?MlhJSUVwOFZ3OW9FbXpZK1o0ZkkzNElTeXROWWZpN0RWeEZuTEF6aVJmamNm?=
 =?utf-8?B?eHJXSW1yN25wQXM5SXJIUjgvN1g2aDAzL1JsZExLcTJoSkd6bllhUFI0R1V6?=
 =?utf-8?B?cnBTQnN0eVBrcU9oWjE3Q3NCMVdmcGNHdldGclhlZnZ2d0VzRkw5dDFFZ0s3?=
 =?utf-8?B?TkNLN1ViYlU0NkNsa3c2NGs2Vk9UK3FwbXpRR25zRi94cUY0WERJcnp3cWk5?=
 =?utf-8?B?dEFDbUhxeFBESzJMVzYwRkVEYVR3T1RhdG1KNllkeUR2YUJmMmVRNjZIVHJV?=
 =?utf-8?B?S0FYNzJYck9wYVNJSEUwcjVtbjV2TDJHTFlvUnh3QTlWMVBnd09XNnY2TmZU?=
 =?utf-8?B?Qzk5ZktxQzFzSktBYnFGMmU1NC91Wk13a2tTSHlsYTVXQzBlSnI3QlVNaUpz?=
 =?utf-8?B?SWZZU05IY2l2NlF5aG9RbDg4c0l1bXhzUEhjMUFkeHJGOUxFL0R0WG5wNlE2?=
 =?utf-8?B?ZXVyQ1RHSWVpb04wQXVLVjNsdGxlaEpjV0V1YXNMYlFLcjN5ZHZtQ2FzUytZ?=
 =?utf-8?B?aEtBMkJuYURkZXB6Y0VQSHhrUElTL0twNHNocWpuejdDRTN6UnU0U3cycGFS?=
 =?utf-8?B?N1dqMTVsRFc2VGYzd2VRWmE5SXk1UnhOZ2xoeXVRMlJNenAxa1dVbGpPNkpD?=
 =?utf-8?B?Q1V4aTlqR1hId29uc0pYRTh4MDFnVm8vYmEwK1FEMXRiT0NVbnBySWxhTTEv?=
 =?utf-8?B?ZlY4eVVpQW5UYnU1MG5DWmpsY21iZC9YZysrbXNkdXRLT3BESkMrcngyeW9J?=
 =?utf-8?B?R1FESFJNakhIQmpRekx6MXI0Qm9CaWgvcWJDdnRzQlNkY294UUJxMlVELzVo?=
 =?utf-8?B?TGQyamlBK3NGWWcyek9TLzM2ZVB2emJleExrWFErb0I3eThKbDVyRWtvUnhD?=
 =?utf-8?B?M2oxb0hSVjdDZE9IUnF3ZXNzYjViYjNSN1Y3aDZtNStIWExWL2NzSlFXNm9J?=
 =?utf-8?B?dVhETzMwK2tlanZoaCt2cmVJWkVRY2RRZmVLZmVUdmh2Z3FocS9aUnlkMEE1?=
 =?utf-8?B?bjhMS1RoUVQzQlFheHhSLzV5Y3BjYmtrMStndmpwOVI2WU5DUk8xbDBTemtS?=
 =?utf-8?B?R1haV2oxdDdYMmFyUUdseVE4SjlIWnZaakxycUc0enBjdHU5SzZpVlBEbENS?=
 =?utf-8?B?NmlJQVJ0YUtLMXFvcjhTOGNCUWFBcnNoWXUxR3NWREpXeUJmZ05NaWlQajlz?=
 =?utf-8?B?NVVadjVob0Q2L2VkdlpBWW0rcXpFTWV3ZmNWOVRUN3V1VDBBWHVzdVVsZEFs?=
 =?utf-8?B?S1ZZT2tKWXFrYnZaRXRBc1V4N05rQXJXMGZMa0lNR0x1K1UrK24zSTBwT0Ix?=
 =?utf-8?B?Vm9ldWJLdkRqZ1ducitEalVneVpzVWJNZ3FabnJNREhQd095NnV6VFJaTitY?=
 =?utf-8?Q?eeEhDdJtwUHycGAGyH+n+pE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5096.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38869cd1-9d4e-4f7a-e252-08dabb21b3f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 09:24:25.3650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GONNTEdqHoHPd2QfIDB8R8fTUujUEgG751o9s4GQXBj2TEsk3lDX9yoyB8qdaEo8jZAZVGfUB1DhO4OmcGDsE4e1iWOa60p1G9IQzpRRZuFWaKPBAhg0WxzZIPf7ARJP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7399
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFu
ZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAzLCAyMDIy
IDI6NTMgUE0NCj4gVG86IEt1bWFyYXZlbCBUaGlhZ2FyYWphbiAtIEkyMTQxNw0KPiA8S3VtYXJh
dmVsLlRoaWFnYXJhamFuQG1pY3JvY2hpcC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIg
dHR5LW5leHQgMS8zXSA4MjUwOiBtaWNyb2NoaXA6IHBjaTF4eHh4OiBBZGQgZHJpdmVyIGZvcg0K
PiBxdWFkLXVhcnQgc3VwcG9ydC4NCj4gDQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlDQo+IGNvbnRlbnQg
aXMgc2FmZQ0KPiANCj4gPiArICAgICAgIFtQT1JUX01DSFAxNjU1MEFdID0gew0KPiA+ICsgICAg
ICAgICAgICAgICAubmFtZSAgICAgICAgICAgPSAiTUNIUDE2NTUwQSIsDQo+ID4gKyAgICAgICAg
ICAgICAgIC5maWZvX3NpemUgICAgICA9IDI1NiwNCj4gPiArICAgICAgICAgICAgICAgLnR4X2xv
YWRzeiAgICAgID0gMjU2LA0KPiA+ICsgICAgICAgICAgICAgICAuZmNyICAgICAgICAgICAgPSBV
QVJUX0ZDUl9FTkFCTEVfRklGTyB8IFVBUlRfRkNSX1JfVFJJR18wMSwNCj4gPiArICAgICAgICAg
ICAgICAgLnJ4dHJpZ19ieXRlcyAgID0gezIsIDY2LCAxMzAsIDE5NH0sDQo+ID4gKyAgICAgICAg
ICAgICAgIC5mbGFncyAgICAgICAgICA9IFVBUlRfQ0FQX0ZJRk8sDQo+ID4gKyAgICAgICB9LA0K
PiANCj4gQ2FuIHlvdSBhc3NpZ24gdGhpcyBpbiAtPnNldHVwKCkgb3Igc28gaW5zdGVhZCBvZiBh
ZGRpbmcgYSBuZXcgcG9ydCB0eXBlPw0KDQpIaSBBbmR5LA0KSWYgSSB1bmRlcnN0YW5kIGNvcnJl
Y3RseSwgeW91IHN1Z2dlc3QgZG9pbmcgc29tZXRoaW5nIGxpa2UgdGhpcyBpbnNpZGUgcGNpMXh4
eHhfc2V0dXAoKSBBUEk6DQoNCnBjaTF4eHh4X3NldHVwKC4uLCB1YXJ0XzgyNTBfcG9ydCAqcG9y
dCwgLi4pIHsNCi4uDQpwb3J0LT5wb3J0LmZpZm9zaXplID0gMjU2Ow0KcG9ydC0+dHhfbG9hZHN6
ID0gMjU2Ow0KcG9ydC0+Y2FwYWJpbGl0aWVzID0gVUFSVF9GQ1JfRU5BQkxFX0ZJRk8gfCBVQVJU
X0ZDUl9SX1RSSUdfMDE7DQouLg0KfQ0KDQppbnN0ZWFkIG9mIGFkZGluZyBuZXcgcG9ydCB0eXBl
IFBPUlRfTUNIUDE2NTUwQS4gQnV0LCBpZiBJIGRvIHRoaXMsIEkgY2Fubm90IHVzZSBzeXNmcyBp
bnRlcmZhY2UgZm9yIHVwZGF0aW5nIHJ4X3RyaWdfYnl0ZXMgcmlnaHQ/DQpLaW5kbHkgY29ycmVj
dCBtZSBpZiBteSB1bmRlcnN0YW5kaW5nIGlzIHdyb25nLg0KDQpUaGFua3MsDQpUaGFydW4gS3Vt
YXIgUA0K
