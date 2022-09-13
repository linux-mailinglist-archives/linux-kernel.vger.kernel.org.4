Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5605B7A02
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiIMSru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiIMSrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:47:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA15832F8;
        Tue, 13 Sep 2022 11:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663093671; x=1694629671;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=6qNVEuAeZ82vNrhQ9gIZkmyQ2zzctX6gk+kjGqNW97Q=;
  b=fim6ZwWJGYsxxtdmLL8g1Vkyd0FaG5AVQMVsPyl7m/oP4/z7scznXRRL
   UheNKzgCT/UdLgzPI6RiwyNZuDlVBmymK48H6LCSDMB3cUR6u+FbKGzQ4
   p/WA9xnKeZXAP0jQS2bSB/G9BsBNQbl4JUvazluFaXHm3BscpA4hyMDHs
   TNBWvtsJYzTc847GRCFyiOjdR+qKPkLnWxHIblpzdWm0pFYFaI+2u9uBQ
   3K/5c5rjzfQVfYryqwz8dm5zXOCEGMEGw5kbD8XkSxM48j32/40KVOegA
   VNVI8yyAZLMLZq8bo242+YXCwNhp6D0eCPH7zS0pSlaKN9oIq1mQiI00b
   A==;
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="176975458"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2022 11:27:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 13 Sep 2022 11:27:47 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 13 Sep 2022 11:27:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0X+uUvns0JBLKGg2jyz99y8wul026vqNjDPAIIghG4zVuFYignO09apTh6V1HcTLtfNhEE1xj7i9JF8e2+rMYwByd771mRl6P0D7WiDfPU81Kupsad2HQfVkKo6IHrZgIf6lFhR4QjSl0VCO7VUPwdyHWY90jVu5A60WXnzZy2ON1OXa+516br3a+8IB2Ol8OJDWzhcxpxyKyXYU85I+HoCi+mDvcNondK0CEjZZIlNDk/qgJXP0kV206LrTWaDvcnKFL5pRo0FJ2/AM37GAVrQB2vcUATTh3oTTLM9BqlqnR7XBUhqmIVeq+AUOqphr8oy4ToliIf8eU51TAosYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qNVEuAeZ82vNrhQ9gIZkmyQ2zzctX6gk+kjGqNW97Q=;
 b=gLJAo2qEsMCiOdPMN9oFq3Yqp4AMQQPhtDE5y6YKnzCT6Wji19nm0sYjDWAwtk7LP9gPxcu2lY4NaZz9pAA7UAVMXlIX7VN/iF8nMcAMa93qrE79Emh4lkTD/EIDv1X+F8TKDMTA1Qie6r41dTPXjcc+cw6nbU7XGoG7hI4tXPy/2KSUpoj1O9w8GSzXyRAidXyWqNjKZfoMyIAI6TUDLgkc9j7hO3u8Jz7DiBiyHgdA7Oa/EG/vONP9Dkijg59Ya29muZZg0CG4tniE45oAv66aca9Dl4G/fYyDLiHEm0K/VAIoF5mzxpbdAZn9MyHv4c/d3HylGLGs/cFyMar+gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qNVEuAeZ82vNrhQ9gIZkmyQ2zzctX6gk+kjGqNW97Q=;
 b=PfpNKgqt81X5vkZ8pMXxf9Oh0U6mT+aScARJkyX8ItTajmGAt3w3Rqvc2ZCm5pYbAabIYOFTWZbi47cZkzPHoI71uUfXOTC3qlTB4slyu9/yTpW9txCpG7UBoOae0jNWvo7Qsa4jMakVR6fNTevbZWMdndNoLxsHwNRtjxaayDI=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by MW4PR11MB5936.namprd11.prod.outlook.com (2603:10b6:303:16b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 18:27:42 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 18:27:41 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <bagasdotme@gmail.com>, <linux-kernel@vger.kernel.org>,
        <sudipm.mukherjee@gmail.com>, <arnd@arndb.de>,
        <linux-gpio@vger.kernel.org>, <linux-next@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: RE: [PATCH char-misc-next] misc: microchip: pci1xxxx: use
 DEFINE_SIMPLE_DEV_PM_OPS() in place of the SIMPLE_DEV_PM_OPS() in pci1xxxx's
 gpio driver
Thread-Topic: [PATCH char-misc-next] misc: microchip: pci1xxxx: use
 DEFINE_SIMPLE_DEV_PM_OPS() in place of the SIMPLE_DEV_PM_OPS() in pci1xxxx's
 gpio driver
Thread-Index: AQHYx3cSrZWs5EQIsUK6bl0sIi5laq3do4GQ
Date:   Tue, 13 Sep 2022 18:27:41 +0000
Message-ID: <BN8PR11MB3668C9D5BD38AECBE160D013E9479@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20220912113634.167820-1-kumaravel.thiagarajan@microchip.com>
 <d34d9264-1f0b-d465-bc1d-75f8c736a35b@gmail.com>
In-Reply-To: <d34d9264-1f0b-d465-bc1d-75f8c736a35b@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|MW4PR11MB5936:EE_
x-ms-office365-filtering-correlation-id: 43bf4394-e87c-4cfb-7561-08da95b5a52f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qYb25ruweW0RW/JAzojTADqTMgg8pyS+fiGGm+onuSDG5SuC+19fKsXCceeAubWrPAiPZT0n1fotWu4m1sOq/IMl5lnKzz9Gs1vRso6vdplQCHc9tRQOv/+KVn9Nap6M1V7VnrH1YNZCLI+mS1jlf5lbHsd8Sdn04363V65p9WSVxYIfeLIqxk1WrA8HxU3h3S6Ieyntib5p/HpOxrl32JgfzIW4TTjhqkAUcnw8L1feEsgSk3NpfBTNIHjD4qGYN5SEgaNAKjE2IQtXn9fFlgqSGdXsodjXABBG3WcNO3wb3bb0lCUFzNM6B91Czc/3GpgqMHSDoPa7p4kii81TSKZ61q2YApCik2CM4HwVvMMOYNXC2rcClphD5umTOt8822pXrWdX6PPDyVm4tbTjyKMmUd46KRS0V61OXoAcEx3UynWMUDv5JBmPDtsB8wdb4KJcyqIwUf4k87hUgqZ02ArBOwKYRFNUmCFhxz1d4uwG+GZxB5nN5vdi7GGHmqDnnHaW/8FzbpILTwopJPVdV73UAHj8LU9Iuy+Tej2t5GwYbbH1vU14KHW2BsJ4yPf4ycs4wc9YBm8+S0yRxUEPaypth4sTHjws9yB/h747+Rcref8jPw6MjbcXN6K6NTY3rjor8M8fghwJWgCwRudwg0DAyJpuKaVUoZl98FNyWyvRsKXl9xhDExitbGhDXDpXbBheXBgybscjAMhYmtpdoEKORMM94mrVDX3c0YXDbdqLLjxMCh5lbhgkeBLqCTmkHFOjxE64XSqhiWgOZXrnUTEexs1L7BI4htTb5aua+J2sjjsThxYmsgwSH6PlR06rNes6WoQuSRBSBc3nDQ4b7T6H+b7CJpu2GOzbsuArT54=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(7696005)(6506007)(8676002)(186003)(66476007)(64756008)(66556008)(86362001)(38070700005)(76116006)(66446008)(66946007)(55016003)(26005)(122000001)(2906002)(478600001)(316002)(52536014)(41300700001)(33656002)(53546011)(5660300002)(71200400001)(8936002)(110136005)(83380400001)(9686003)(38100700002)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHg4L1Y1MFZFaXVkUFlQNjZxTnI3V0h5bFFmeVJVVUI0djZmazlOcGsyTGRw?=
 =?utf-8?B?aUlVQmw2ZnRXRnhBYktmNm90V25aRWFCYWxka0Z6ZkdmcXFwV1hDQWxyZnNG?=
 =?utf-8?B?NUdrVG9TK1NZbU0zWXdEL0NlZFBNOUcrWTlOaFlNcjBCTVNweVMrQW5BS0g2?=
 =?utf-8?B?em9nN01lL0M4cGhwa0ttakh6ZmNjaFJnSWV1Yk0wL0RIZkdCYlNic3hidW9W?=
 =?utf-8?B?SkZjU25icldKSHZ6c0RWMExBSHNDWUlKTjFvd2ZPZU1reUxpa0VVSG5xN2xO?=
 =?utf-8?B?NklkaU9wNFIzT216dkVmelpTRHpINmZyeXVNK0xoLzNZUVJQcWR1NW55eVY4?=
 =?utf-8?B?bGVYejlLQVl3UHZUUnhWcGxFQ3FSMDJrK0xvZU1yYk9IWDNHL0Q0Nkxna1F6?=
 =?utf-8?B?Qk5ONGQxK1BPZkZXcUgzQ0trYU5sRG9HWjFPSTBoUEg3aFR4U2NVanQxQ244?=
 =?utf-8?B?RmlUSmJwWVZIdGpxZmM4V2FCczN5bVNkRFhzZXM4Z1hwTCtSQUd1S3RLa3hD?=
 =?utf-8?B?NThPejdEeldKMCs2QlNjRVYvYVFPR044bkR5akU0SE9KdjAzQWdQODU3cEpT?=
 =?utf-8?B?L2VWMVZDVHRCUWppYkRpb3FRMmczSVJtZTVIMnFjYUtiUnBKZzBhMitCM1Rn?=
 =?utf-8?B?RC82QW8rMmNwMXVBNDU1TjNwWTdhaDI4MHNWUUsxd0gvYTYyTDNUSXgvOU9Z?=
 =?utf-8?B?aDdvOXY1Qk5MNlhETmFmYk14VmgxYW1rSkppc3FzU0cyOFpNdkNPNFAyQ1B3?=
 =?utf-8?B?UUVmSWJxL3RCQmNsS1hSN3JvcnhBSXBjSzNzemJPcDFlQjI3MEhpSHByQ0xO?=
 =?utf-8?B?OFNSWTRuUkZ3dllnMWJ1ajFYRFJyQk1iK1lMRk9tZlJ2T0xNbEJiMDVlZFBM?=
 =?utf-8?B?Q3lTTHc4SjZubVc0MDNRNWFCTVM3MXNiK3A4VDc1MHZKdFR5M0RwQmo3aDds?=
 =?utf-8?B?TFdKeWdrSmd6ZEFTUERGajc5Mko5N1lzeDBJQmZzNEZqWm9iRWpqaVlzejZp?=
 =?utf-8?B?SzdYdUdWNXYyTGJ5eHkxdkVOMTFFeFgwczA3R0s1eitTT2poMjBMQjJ0c05j?=
 =?utf-8?B?cGlHMCtwS3VYSDZGdFp3NmhkQ2QzQ1FFay9aZFY1YW55blpXR2llSU0zRXNM?=
 =?utf-8?B?Nk43UnlXMWZFeGlSOGJ5bUhZc3c2Q2ZiQUZxUU1iSTZnNXBUakFuU1EvYjBo?=
 =?utf-8?B?MXdJVXVIbWhyVmNhdUFzaU1jUmZ1T3FpSFBjT1dlb2w1Y0cyWTJXYmpsRGtM?=
 =?utf-8?B?NDNBa2I1SnZDR2M3UVVOd0RDc1ZYMFZLRnhoZnpZdDRDTCtDekllQXZ0OStv?=
 =?utf-8?B?bVFVdld0VmQ3S2dHbG9ONW9SRTFuU2l2SWM2UC9RWDNudWE4ZFhXVEUxUlpz?=
 =?utf-8?B?MDd6MXYrWmZIZnNKeGZENUtScUlmNGtoZlFUY2JqNzRVT1pzaW1FK2gzaUU5?=
 =?utf-8?B?NWxFVXdlNkxZcGFJVWE4Yis1R3p0NXB4bnBHMUZjYTNQM2hyYmxEUFpKNUpw?=
 =?utf-8?B?Tk13WnZ4VElEWWtkdjRndFlYSmpSYWIrWXlpYmkrVnp6UVhBMTF4dHU5VE4x?=
 =?utf-8?B?WFJhdWxELzBlNFcvbS9DcWQ0RVQ1V2p1Lzl3eHBhZ3d0T2p1dThJNlpzbk5K?=
 =?utf-8?B?a2I1dW40OUcvWmcreEVUN2JFNFR2ZzRDTlBvZUxDRzJpbW1scjM3d3RTTUN4?=
 =?utf-8?B?WGxGTjhtaXRCQWN1NnptOUFHb2oyOWJGdTI1RCtXdjgycmpKanZGNG9FNWhJ?=
 =?utf-8?B?M0w2SUk2cGJFQzUzV2RYem53R3R3VWY5bU5OV24rYWNZN3RPRjFSV2Y4dnR5?=
 =?utf-8?B?Zm9MQzI4dFdzdWE2SXdSSnFMak9nanUydGhjejRDZU9GdXh5SDdobkNDTzlI?=
 =?utf-8?B?M0ZXMVhpcXBhRTZHTldOYkRTZEhSMW5BeWw0MVR2aFhIWkxya2c3eVM5L3J0?=
 =?utf-8?B?YldhS25sY1NWbUhOQnJYeE1XdzJhNExKeDUrYU02U0JYeUtxTWFsOERmWU1U?=
 =?utf-8?B?aU83c3hxbThJRkd3cld1ZjRGZzRlUk1OVnJYb3h3SUIvRm5XWlhTaG83d2FR?=
 =?utf-8?B?eGJMYnlOQzVHdVRocHA1ZzRHMkxTRmF1Q0doWS9zSjFBTG5iOVJ4dmtTdlpr?=
 =?utf-8?B?WjZXU280N2I0NnJZNU13Q25tS3dEbEZzT3dVQTdWaiszWm9tNlFOcnhEQUlv?=
 =?utf-8?Q?RTXkqdtR3FBOwHABbwARj5w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bf4394-e87c-4cfb-7561-08da95b5a52f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 18:27:41.8847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tIu6KwhTC0ueWV4ZcswKwVHny/2woF856S+MW/BN/aqeHR3GmzRMoYh8qVrTdibIc4E98ZExkKptGr93njn/xXSMwr2pAHsAZkyr4ZSEGs4vPcnpzcHueD+A1NyBt4vb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5936
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCYWdhcyBTYW5qYXlhIDxiYWdh
c2RvdG1lQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDEzLCAyMDIyIDc6
MTUgUE0NCj4gVG86IEt1bWFyYXZlbCBUaGlhZ2FyYWphbiAtIEkyMTQxNw0KPiA8S3VtYXJhdmVs
LlRoaWFnYXJhamFuQG1pY3JvY2hpcC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Ow0KPiBzdWRpcG0ubXVraGVyamVlQGdtYWlsLmNvbTsgYXJuZEBhcm5kYi5kZTsgbGludXgtDQo+
IGdwaW9Admdlci5rZXJuZWwub3JnOyBsaW51eC1uZXh0QHZnZXIua2VybmVsLm9yZzsNCj4gZ3Jl
Z2toQGxpbnV4Zm91bmRhdGlvbi5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBjaGFyLW1pc2Mt
bmV4dF0gbWlzYzogbWljcm9jaGlwOiBwY2kxeHh4eDogdXNlDQo+IERFRklORV9TSU1QTEVfREVW
X1BNX09QUygpIGluIHBsYWNlIG9mIHRoZSBTSU1QTEVfREVWX1BNX09QUygpIGluDQo+IHBjaTF4
eHh4J3MgZ3BpbyBkcml2ZXINCj4gDQo+IE9uIDkvMTIvMjIgMTg6MzYsIEt1bWFyYXZlbCBUaGlh
Z2FyYWphbiB3cm90ZToNCj4gPiBidWlsZCBlcnJvcnMgbGlzdGVkIGJlbG93IGFuZCByZXBvcnRl
ZCBmb3IgdGhlIGJ1aWxkcyBvZiByaXNjdiwgczM5MCwNCj4gPiBjc2t5LCBhbHBoYSBhbmQgbG9v
bmdhcmNoIGFsbG1vZGNvbmZpZyBhcmUgZml4ZWQgaW4gdGhpcyBwYXRjaC4NCj4gPg0KPiA+IGRy
aXZlcnMvbWlzYy9tY2hwX3BjaTF4eHh4L21jaHBfcGNpMXh4eHhfZ3Bpby5jOjMxMToxMjogZXJy
b3I6DQo+ICdwY2kxeHh4eF9ncGlvX3Jlc3VtZScgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XZXJy
b3I9dW51c2VkLWZ1bmN0aW9uXQ0KPiA+ICAgMzExIHwgc3RhdGljIGludCBwY2kxeHh4eF9ncGlv
X3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gICAgICAgfCAgICAgICAgICAgIF5+fn5+
fn5+fn5+fn5+fn5+fn5+DQo+ID4gZHJpdmVycy9taXNjL21jaHBfcGNpMXh4eHgvbWNocF9wY2kx
eHh4eF9ncGlvLmM6Mjk1OjEyOiBlcnJvcjoNCj4gJ3BjaTF4eHh4X2dwaW9fc3VzcGVuZCcgZGVm
aW5lZCBidXQgbm90IHVzZWQgWy1XZXJyb3I9dW51c2VkLWZ1bmN0aW9uXQ0KPiA+ICAgMjk1IHwg
c3RhdGljIGludCBwY2kxeHh4eF9ncGlvX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+
ICAgICAgIHwgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gPg0KPiANCj4gV2hh
dCBhYm91dCB0aGlzIGRlc2NyaXB0aW9uPzoNCj4gDQo+ICJTdWRpcCByZXBvcnRlZCB1bnVzZWQg
ZnVuY3Rpb24gZXJyb3JzIG9uIHJpc2N2LCBzMzkwLCBja3N5LCBhbHBoYSwgYW5kDQo+IGxvb25n
YXJjaCAoYWxsbW9kY29uZmlnKToNCj4gPHBjaTF4eHh4X2dwaW9fKiBlcnJvcnM+Li4uDQo+IA0K
PiBGaXggdGhlc2UgZXJyb3JzIGJ5IHVzaW5nIERFRklORV9TSU1QTEVfREVWX1BNX09QUy4iDQpJ
dCBsb29rcyBnb29kIGV2ZW4gdGhvdWdoIGl0IGRvZXMgbm90IGluY2x1ZGUgYWxsIHRoZSBkZXRh
aWxzLg0KQnV0IGlzIG5vdCBob3cgbXVjaCBvZiBkZXRhaWwgZ29vZCBlbm91Z2ggc3ViamVjdGl2
ZT8NCkkgdGhvdWdodCBzb21lIG1pZ2h0IGJlIGxvb2tpbmcgZm9yIG1vcmUgaW5mb3JtYXRpb24g
YW5kIGNob3NlIHRoaXMgd2F5Lg0KRG8geW91IHRoaW5rIEkgbmVlZCB0byBjaGFuZ2UgdGhpcz8g
UGxlYXNlIGxldCBtZSBrbm93Lg0KPiANCj4gPiBGaXhlczogNGVjN2FjOTBmZjM5ICgibWlzYzog
bWljcm9jaGlwOiBwY2kxeHh4eDogQWRkIHBvd2VyIG1hbmFnZW1lbnQNCj4gPiBmdW5jdGlvbnMg
LSBzdXNwZW5kICYgcmVzdW1lIGhhbmRsZXJzLiIpDQo+ID4gUmVwb3J0ZWQtYnk6IFN1ZGlwIE11
a2hlcmplZSA8c3VkaXBtLm11a2hlcmplZUBnbWFpbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
S3VtYXJhdmVsIFRoaWFnYXJhamFuDQo+ID4gPGt1bWFyYXZlbC50aGlhZ2FyYWphbkBtaWNyb2No
aXAuY29tPg0KPiA+IC0tLQ0KLg0KLg0KDQpUaGFuayBZb3UuDQoNClJlZ2FyZHMsDQpLdW1hcmF2
ZWwNCg==
