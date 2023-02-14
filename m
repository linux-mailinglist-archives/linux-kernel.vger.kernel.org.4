Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687BB69621B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjBNLNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjBNLNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:13:16 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1302252A6;
        Tue, 14 Feb 2023 03:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676373162; x=1707909162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=comEnA6p4txc7ruGlD3EDDWaf+lT28iTTj7ByG70Xbk=;
  b=YsXDD3WwGnORDnLatFmA3xK+YRdncZn15M0Bonddp1/rJndnFePzK8yQ
   Ksbu5H3FMaluJa9Kw1q+9vbECBjP4TG4FqGmtx/oD44NqwcjNuWvwafs1
   E5UYgvEDF/dmHZMpqX2aA6E6xOxbFD4m/+LkvnzjrfW/Nm4pZ0TTesvzh
   /Uaft/h/6qqP5jrARblwOIFJVFGuUDqpV5+cHfjUO02Muk1VWYxi5xYaJ
   iFTeQvqNd+iY5PzU9LSlhZ9Gb9mAxzg/3MH+2lsiAVf5DBaS2Arww7fkI
   Vv0cveqyRTOy+fe1Dh2UW2EfLFSEaxfjuOWFcakpEyA7v0dD3t6kOwqgl
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,296,1669100400"; 
   d="scan'208";a="137082280"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2023 04:05:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 04:05:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 14 Feb 2023 04:05:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZCkouLxU2eupSn8TJ8+OR8muH2HiS9aDHC+Jhb/co6LvAM6CPGDRaJF6ljRpj9gzzju8fzM3L6+D6BTD2NWb/gzIk+bqHhALRskL87CRu2QR24NJ8Q0nr7CT2jW9uVC+34I7k0XnHfXepqmTFIZ6M+B68h3d/1tM8aOX4/AgSQd92lkav2j9Gxrxu5NFM3U6R3dZO0y4A0enK3laOkBxro4+uInjt8SCLCpEjUPp8PFQQPFET8Ox6e3kO7wXfGWnSioKWTaEer4DxjJ6mIMhSjqAkaK4TKMGhKr/kjvkDAX66mUsLhV0/CO0DP2qIYdcrHAYpUjslf2epCL9Ck0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=comEnA6p4txc7ruGlD3EDDWaf+lT28iTTj7ByG70Xbk=;
 b=B8uSCzVbrWMKpCAuM9CofgcKLJS9bEAwtFWIT1qBm9nqP0+XIebM2PyuM95HN4y+yxQZEnZykeqAH0EjLPl2fxUbxNt8M/3dLQ66IUwDVZjBKXVh690BMZgNrOHAON8XxSKT3MnRR/OCdLo5VU1ZWeWv8huqGatFNsGPcRNA9Sog4DUEOtVZBRjF34N8XjSY6zSpDZOXb+j0uVNOAV0fXc4S2CFAfE+rbyAvi0oLWOuwycHrd4L132Kekr96B4CojllDMAo7uuxQGjGjVFlFN3mrh2z9pl/TtzHtfnsIU0U0Dw9vpSresB04/UW+Qk0dwGoqyLLMl3S1hc+hCAOlag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=comEnA6p4txc7ruGlD3EDDWaf+lT28iTTj7ByG70Xbk=;
 b=c/v0l3Jrqoi/xd1BUS/OZpHnyohXDay3Rj6Wz+jMFSLFylSWgpUKn90suAeja9ITSGz6xuLC9KBkW5aMBtcmNOCRwDQzR82gpdqx8Cq7vzCRsVAIPqrd+kRhAqYcANE7ppoAxBHWEYDMrjqKiod0WA+XoGXNklwSIcOGYZ0N5+k=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SN7PR11MB7637.namprd11.prod.outlook.com (2603:10b6:806:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 11:05:52 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6086.026; Tue, 14 Feb 2023
 11:05:52 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <andriy.shevchenko@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Ludovic.Desroches@microchip.com>, <linus.walleij@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 3/5] pinctrl: at91: Use of_device_get_match_data()
Thread-Topic: [PATCH v2 3/5] pinctrl: at91: Use of_device_get_match_data()
Thread-Index: AQHZQGRNFC775eszsEyT79EAs8TjOw==
Date:   Tue, 14 Feb 2023 11:05:52 +0000
Message-ID: <d45948de-a51b-73a5-27e1-924053105c9f@microchip.com>
References: <20230213154532.32992-1-andriy.shevchenko@linux.intel.com>
 <20230213154532.32992-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230213154532.32992-4-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SN7PR11MB7637:EE_
x-ms-office365-filtering-correlation-id: d8f87e9c-4e96-4f38-2b91-08db0e7b6ffb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KNXGKQiNay5jwTCXp/rNaUT8KK6F6G4gjPqdYsGQl14BNtagN8lgNhijF/cxjmnP0HyS7iIt1MEjsg33XkNAEtLi3zY6f1CB7xL5A7fP2HVW9lSeEPUabqWvB5bx+P7v6cxsiFZNE/BysTWY8jzEfIsF5UYWgl9MMDmt+fq3g8RePy3OhfliTp1TTsyYzglhpctg6b2VsybSb7V8snIrlCV9y7SOZez/XmJkOVGkE6yh0wUdsaRMlq7GGQ2t4S2dRzcOvZVc9hsML6J/aQE9eC0S/oYtfrmUbbQbv8bYo3m+q3eQss4BkpMjYXGGaniECsT79j29JCwzMHeAAYHjquUaD/nMt7D0HhoWlNgxSk8Tsp1ntOnNSO2KFxo77Jr4L4lnPgZAOQz4HEBoGQxLvitWRqU/nWwKtYj5i8Swx1+HmdJwjXgM57ozvzuchJE0KFnZysdfNNY+u04TDX+I5Nx4LEcZEl6OT0e41OLYa3MN77rLcP8rfYNTdbp4W++Efvm2DwVy/xSKBZrx1rSyXcvq0ICK286FbH2Z3Xo4CKrBmiNuZPPZ85Am6Tvuu3yTNm0A7gdOfeBGbHw82zJ0eKFIm6yBOs2ewK4R9n3sWaSdsKdt/b99Wr3zbEn93AMoPKGIsR586KEOlAY5iyjSZMjeFCbs8c1cIG7SUAMGedvmKbQhgEJwwWKYpPDMlMPVUPDxmkVmfdmA/b7GWdCPrfgLRioPJbafBWtBE+d9zlaaqWmOFN7kolzoeJMRCB00gapCzN1ZJCp1dXUKg4dvaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(376002)(396003)(39850400004)(451199018)(2616005)(122000001)(478600001)(6486002)(36756003)(41300700001)(31686004)(6506007)(53546011)(5660300002)(6512007)(26005)(186003)(8936002)(2906002)(66556008)(38100700002)(71200400001)(31696002)(54906003)(316002)(66476007)(110136005)(86362001)(38070700005)(4326008)(83380400001)(8676002)(66946007)(64756008)(66446008)(76116006)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGtXQUZ3R0RVWDc4QUhMdWFiVnIrQnJDVktFdTUxMkREMzV5WmlNYzNRdTB6?=
 =?utf-8?B?L2Z0RlVDcWV0Z1pTT3ZLRFdhdmdMOFY3TEg5elhmdkIwZmZLNXBiQjJCZUlq?=
 =?utf-8?B?bjV2NDRRaUhmaVIwTzhPdXVySTRzNkp4aXZkcXhFd2RKZ0Njc1dvUDd5SU55?=
 =?utf-8?B?R2NadVhiYmpUMHhlTU1Fa2psdTloaUhhRmFzaGk3TTR2eUkvMXkxc0N2UkdD?=
 =?utf-8?B?V3JlL3oyVlAxS0FLa3llRUdIalc5WWtYbDdEQ3JRbG9DclBya3ZZTUlESXN3?=
 =?utf-8?B?R3FTTzY5UHdYamlvQVJFQlRzUW9iK2lQR1R6dmRJeU1yMllYR2hjTy9RQVZm?=
 =?utf-8?B?K2ZJZmdGWFo0Z3JEUjI5NkNQb3FnalNRY0NodDdzVm8vcHRnTmdVb013cldx?=
 =?utf-8?B?SVRVVVNzYnJkYUVlcURoUlpPKy9uc1RqMUQvR3Nra0Z0OEtCb2MyQm0zZFFu?=
 =?utf-8?B?RmFmbkNPRnNiUWRzQjU3eE9vWEtuanFjSmlzV3Y4V2hSaXUzcUhtN0c1UGx6?=
 =?utf-8?B?WUFYYkZ5d09xZzRTcUEySG5vM2pOdzMxZEM1aTRDR1NraVp6b3BzZDY3S0lq?=
 =?utf-8?B?WEJZaDExZ3Y2SE80cXdZb2YrM3I5UjNCRkVsZ21YekJhcmxaQUFwWUZGbWY5?=
 =?utf-8?B?MGIwT2hIMmJ6OW1FdGlxZWZ1N2ZiSGVUYnlyMW9semx3V2ZIcTBHMFh3c0Nm?=
 =?utf-8?B?VzdLbE5lb053ZlltTWNVcTIvNGZtbGtUYWJ6K0o2TklmdlYvZjE3TzBCTUJl?=
 =?utf-8?B?Y0hwWlVBRlBjU1YvV01LUkZsRWQ3WHliTGM2Um4yMkMyTFlONXBuYjhMQzUw?=
 =?utf-8?B?eUllTnV4NjN6V0ROTHpMakxLbHczdXpnNU1XRysxVHNEMjNmWEl1YzFOdHR1?=
 =?utf-8?B?VGNWWXdGRXF3OFFMd2hlWG1IVWYrYUxlY2ZqRDk0T3JZK2ozT1o0cy96T3JZ?=
 =?utf-8?B?OVBxUlRTQ2RxWUlITWRJWVRObnljV3BPMmJGZDlRRCtEcFQrdG02ZDNYNzBu?=
 =?utf-8?B?Nnp0OEZTbVNQN1I0VzNBK2REMk9UMXlDbWdtTU83N29KeWhsRENrcEwwejVT?=
 =?utf-8?B?QnovT21ycVVyYUtwUzEyYnlvMlJhZGI1Mjlkd01NK1VWQ29OY1pEY2RLeTZU?=
 =?utf-8?B?Z0JKVGNEKy9DWitvUXAvOUo3RzBubkJ1eis0YzUwSHE5dVRnZkZCL3hQRVFs?=
 =?utf-8?B?dGV1US9uRnpFcEN4dWFHR2hoWk1paHJxeXNaNXd1ZnB3TW1RYkZMVFVNRVl6?=
 =?utf-8?B?Z1VtamJkY25PdmdpSkRZOUpjSkN0enIyb0YvOGFVaVplVVI1L0tSejZHTW50?=
 =?utf-8?B?ekk2ak5ybnpic1poVkQzdXk4czVOYng0czVLVGZqbUlBMzJ6aVZOS0ZWSlF0?=
 =?utf-8?B?OXJmR3Uyb0Z4UGM1MjFnWmtxT0RxT05pbkxGVW53Nmx2QWcrWjNoUkxuMUEz?=
 =?utf-8?B?bTlaN1FoUldxVWJaR0RPZ3Rla2IzaHE3QnlVVC9vNFp3dnNML1dXTmRqQ1c5?=
 =?utf-8?B?K1U4Q29ZS25WUnA0WXJ6MVNEYk9wYVhpSEtWTUdGRUZqMG5yKzh4dkxDSVRB?=
 =?utf-8?B?SlBOUG1pQVRCcnJUMW42cjdKLzRzcVh4SWZqVXNCMllvUitxanZEZVRhOTRK?=
 =?utf-8?B?bEx6TTNQV0NoVmxGSkIvMkl6dGM2T3FNMUlaTlpJLzNpV0NPajZQS2tIMzVp?=
 =?utf-8?B?UjdYc09TcVBlOTZtUS9aeTdLY0ljNWpMc3lkRWJGV2FveFFIZkk3TjNYdW5j?=
 =?utf-8?B?R3Y3VlB3d1F5bHhyY2VQQTh2RG8rc09ORVUrS1ozbGxDSUJQZkoyQm81aGMz?=
 =?utf-8?B?c0hVUGFaaUpjdlRqR2NwMGovWG41Yk02cjZTM1RTc3ZUcTVkdk9uL3NHMkFr?=
 =?utf-8?B?aUZsRCt0MThRMlNESDQxV2lOZ3RodksvMWRNYlpaVk9PNCt3QlpHRndoTWo2?=
 =?utf-8?B?ZTRmSUljR0toNTRaZEY3VjI3QjRuSDIxWmRXR1BoWnhmcjFlNFdVYmIxT2px?=
 =?utf-8?B?SEN2SE1pYmhBN3p6bS9JT0V2bTA0ZERiNzJjcVVDalkxTUN2endlTUFMOXds?=
 =?utf-8?B?aS9qblhEVkhicjF6OExIMWZJY2VZd1dsc3ZlMzRtb3BoZ0RLMmZRRy9qQ2Rh?=
 =?utf-8?B?ZDVjQjJYZ1VvTU9YbHJmS3hpc2Y1c2RlTUgvZjF3M1lHUnc4bytxSEx1UmxV?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05984F46C36CAD4E8925727C5656C2B5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f87e9c-4e96-4f38-2b91-08db0e7b6ffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 11:05:52.5086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XXUoQ5J6Jed5RM3EPwVTbX7kCmkRPberxwnvBD817bG5Jl76+u0bQZWidax1C8fbUGazCWRHQx8Sv2v4/7Mu7o/rqzjRBjsfkeyqhqB/cVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7637
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMuMDIuMjAyMyAxNzo0NSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFVzZSBvZl9kZXZpY2VfZ2V0X21hdGNoX2Rh
dGEoKSB0byBzaW1wbGlmeSB0aGUgY29kZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZHkgU2hl
dmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1i
eTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQpUZXN0ZWQt
Ynk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQo+IC0t
LQ0KPiAgZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5MS5jIHwgNiArKy0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5MS5jIGIvZHJpdmVycy9waW5jdHJsL3Bp
bmN0cmwtYXQ5MS5jDQo+IGluZGV4IDZkOTAxNWVkOGEzYi4uMDU1YTg4YjJkYWNjIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLmMNCj4gKysrIGIvZHJpdmVycy9w
aW5jdHJsL3BpbmN0cmwtYXQ5MS5jDQo+IEBAIC0xMzA0LDggKzEzMDQsNyBAQCBzdGF0aWMgaW50
IGF0OTFfcGluY3RybF9wcm9iZV9kdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiAg
ICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+IA0KPiAgICAgICAgIGluZm8tPmRldiA9
ICZwZGV2LT5kZXY7DQo+IC0gICAgICAgaW5mby0+b3BzID0gKGNvbnN0IHN0cnVjdCBhdDkxX3Bp
bmN0cmxfbXV4X29wcyAqKQ0KPiAtICAgICAgICAgICAgICAgb2ZfbWF0Y2hfZGV2aWNlKGF0OTFf
cGluY3RybF9vZl9tYXRjaCwgJnBkZXYtPmRldiktPmRhdGE7DQo+ICsgICAgICAgaW5mby0+b3Bz
ID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKGRldik7DQo+ICAgICAgICAgYXQ5MV9waW5jdHJs
X2NoaWxkX2NvdW50KGluZm8sIG5wKTsNCj4gDQo+ICAgICAgICAgLyoNCj4gQEAgLTE4NDQsOCAr
MTg0Myw3IEBAIHN0YXRpYyBpbnQgYXQ5MV9ncGlvX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpDQo+ICAgICAgICAgICAgICAgICBnb3RvIGVycjsNCj4gICAgICAgICB9DQo+IA0K
PiAtICAgICAgIGF0OTFfY2hpcC0+b3BzID0gKGNvbnN0IHN0cnVjdCBhdDkxX3BpbmN0cmxfbXV4
X29wcyAqKQ0KPiAtICAgICAgICAgICAgICAgb2ZfbWF0Y2hfZGV2aWNlKGF0OTFfZ3Bpb19vZl9t
YXRjaCwgJnBkZXYtPmRldiktPmRhdGE7DQo+ICsgICAgICAgYXQ5MV9jaGlwLT5vcHMgPSBvZl9k
ZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCj4gICAgICAgICBhdDkxX2NoaXAtPnBpb2Nfdmly
cSA9IGlycTsNCj4gICAgICAgICBhdDkxX2NoaXAtPnBpb2NfaWR4ID0gYWxpYXNfaWR4Ow0KPiAN
Cj4gLS0NCj4gMi4zOS4xDQo+IA0KDQo=
