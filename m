Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484E67079F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 07:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjERFzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 01:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjERFzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 01:55:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DD010F5;
        Wed, 17 May 2023 22:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684389302; x=1715925302;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tGSd2ndveozlp7aMyHG4OefEV8fScTkBhyYxa4n0A5g=;
  b=wBi/cFHFQ9TrtHfOm38FNgx7fHyFhtK8yvyO17ScYrBo6+/oEd/f+le7
   tqIAYWCCVsDitfx66TYA9BbJj9ffQS9hTtDN+k4XHZXKG5/aLSeyvB9Ae
   scgE2s1z2adUyHN89JpUm7oEirco6g3zE5rZcX6QeR5p+F7a/3XkGna82
   2scjPkm9PZCCbx7ZfoY9oyqTDikUgP/n4a2mZIBTkqfXLwzGTSQfx+cY8
   YHs6FhrpRa9BLllNIOjy64fhguXsEtgamMxbKczDWmp8B/6yrBIxL1b/w
   G+XqTv4Fr3nu1AmZ4nxwhB7K7s8OUz5P9rduL6+pepKJHRQ7jg1M2ryqb
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,284,1677567600"; 
   d="scan'208";a="225873652"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 22:55:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 22:55:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 17 May 2023 22:55:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fln34WFPs81EV1p1fhOyBNrHKyoyFRjaJ8Plwmm9Kg7sPid5HvxPOFcwouwqS/o48s6NjLNEq+FnOu0PHdQhqQDYazDx9ZY0FEeC+qYy5pCGQ2CSHv/JpONRw+FqNb7sVYY3r6BHpeiD1n3bC9JRWE7GNTGX39A2c5PgDVWSQVrPBvyIndVju+rgkI2J0yd+OVN7Fs7yDEoYfZhxVsW8XXwgTUjK18mI8YBqqRisERb6ou/CZtvnPTD1ewtK3Mp61hH5lEo0pKBXG+D4qqhsStVDtBwAdj7KHvypG4DWUgFoEVcjD2P1ylxOp8Mv+2DBEQZZZfAfCMVz+HTWjBymnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGSd2ndveozlp7aMyHG4OefEV8fScTkBhyYxa4n0A5g=;
 b=DnE1gNSg/gJbrYZ+tr4h+FTD37QfzElFOmLJouYVHKghDK4T+uBmDEv+eki2QCJRhbYjXmEG055tBuoXQiQ/SVupVSvUMy5R8nFBS/uCb2qFGtWpZWGjwE7XmGLiztnOO4MYLdP7mZYynfApTys3aB5GEeQc98BJI9lu84dwROsmlTYa3xkTVyW7EZg/V/z0Kaxw7cGSLzIQ/avExpzjYWCJDzCJbD7oTXbMiODb4recqoLVtxY4rbttmFCpN5OJU/YtylPeNq2Yoce5EO2e1Pa72U3MflmlZz5Bww7VfbKakWM13Tyjzxnbnx8lGhipUd9Ks2o1qj//caELbv7vFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGSd2ndveozlp7aMyHG4OefEV8fScTkBhyYxa4n0A5g=;
 b=rJNvMzj8A6icHm4muQfaxTtCePl5E1Ot4Ut5RufMGLWmmwlXM01+unZB8jeg1wG8Rge6xXvhUR5A3ZUZHGMjmFGPM0eaPOEobDQEatju/E70yzOP1qWDvJV9zSkN3DbSRjcZBHEUJGfiI+qVrrlT8HYQuWeon1XWlATaBrf/MeI=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by MW4PR11MB7029.namprd11.prod.outlook.com (2603:10b6:303:22e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 05:54:59 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 05:54:58 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Ryan.Wanner@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linus.walleij@linaro.org>, <Ludovic.Desroches@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 1/3] pinctrl: at91-pio4: Enable Push-Pull configuration
Thread-Topic: [PATCH 1/3] pinctrl: at91-pio4: Enable Push-Pull configuration
Thread-Index: AQHZiU1Gay4Js6/Z5k+xcK86PRuXHQ==
Date:   Thu, 18 May 2023 05:54:58 +0000
Message-ID: <c83ccbc9-bed9-1d2a-e181-02b105336701@microchip.com>
References: <cover.1684313910.git.Ryan.Wanner@microchip.com>
 <d898c31277f6bce6f7d830edf4332ff605498c7b.1684313910.git.Ryan.Wanner@microchip.com>
 <c85c1f09-64c3-c8d4-7e8f-985665d1622e@microchip.com>
In-Reply-To: <c85c1f09-64c3-c8d4-7e8f-985665d1622e@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|MW4PR11MB7029:EE_
x-ms-office365-filtering-correlation-id: c279a4ee-9567-462d-244c-08db576469f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +dUsVHAeJEpH6vaDFF9YzZ1A4lyP/oVkVtob6ll0csTAEfUdCYKQHS/amNjYeRvHWMXBpEeYzuRl3Y1KxNwc9+7oHcclsxa595vD64EjEZHYrx6P1vEWncYEQ7P/WF1Y1ChBqDb76mZTFKNdwcib4ejmSbwZKwY8Cq8pd2IKT3z04rd9MxEUsW2uUiB0taBP4QenccgvgWQRVKIiDhrFZdvq3/wvh71lEKRV9XOcM71SpztEdgupJvb8cePajcByKAAObVjTnxlhjcE5lmeTc7/l1uEwWeCfFijoxhX8JyO45bFvM+T/rPmUbLagUa4KkpnAGe/k+Cs2seXwqUxnYqZk5T45YO8VBJMyDSJFYvfGoPtOKgtu6EK1KYAhkHJ4P9k4kSIRzktTcE5dLMq4j4tBR0eqTxv/mEi5lX3DJEss4mMX5BMVa7sIp8HdywEMnJ5gmHCWg/JVmmosa0VvXMUsYiRjeKNpPkTW2KQBmSXs7N+r6zJmp2GzjAT86fPEpoeGDEzRzuYjLwRnrgyEkLeIdff5VmrsBkqfZxN0khYDx6Rt/RXACQzQLobYendie4D1B9gd9tZZENM7bVTe/VUrXwnhNSEmFwaugH0Ia7hHa+jvAlEXPEXVyvs70V7v9Vtcsm5b0GaRG2ttFOUX9Im2VYN9CGvjVTAYqdZgtUk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(2906002)(91956017)(41300700001)(54906003)(31696002)(86362001)(110136005)(71200400001)(478600001)(76116006)(4326008)(8676002)(64756008)(66946007)(66476007)(66446008)(31686004)(316002)(8936002)(5660300002)(6636002)(66556008)(186003)(966005)(38070700005)(6486002)(6512007)(38100700002)(26005)(6506007)(122000001)(53546011)(83380400001)(2616005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTNvMnV2NFdZd2JuSm4wSTIyVWtaV2RSWENyZjBtRWtwSWR6OWFQb2N0Skdx?=
 =?utf-8?B?Q29odjBlNytzUnVZYVZMS3ZVbEhTUjVaUkZ5a2VyL1ZtU3JacklnZmc2d055?=
 =?utf-8?B?dG1RZmRWdjY4RytIemVyaWFRcE82NVdiSFVNQ1ZxbjU3N05XdlBOejZVeWl2?=
 =?utf-8?B?OGpTMW5iVFZJWjBIcklqa1RYNnBuVEJJSnNyVHVPQVFZZWJVVjB1K0NEalRI?=
 =?utf-8?B?c3BVOXo2Q1NsNmU1RzgxTnYxNlFaNTJ0L09SaE9IZEwrRTh3T1M4YWhWa1hz?=
 =?utf-8?B?Y2VqRWlRaGRMSnhxUnA5dHhSWWd3WER4YlM1SE5pMnV6cm83RzVFQnVISWVh?=
 =?utf-8?B?WmhhWVN1OVFUeW9ua0p0YjZYVmhLT0dqUnltN3JPMnVjQVI2RDRkL3JnWkZ2?=
 =?utf-8?B?T3JvVTB4dnY2RVh0dTlrVHI0MTBoQzFHRlMvdEJZVFVSOFRmU25ucWxyNklw?=
 =?utf-8?B?YjZSOTZ5SDJaVGRiNkFHOTB1b0xhZUZnYk0ybEJ3Y1h3SGd5bzBabUE3YzVQ?=
 =?utf-8?B?VTJ2N0d3T1d6U1hSWEZHbHRnWmY1UDVJUGwvUDNDOU5ib01HUHBlVU9ZNUNt?=
 =?utf-8?B?bHo5ZmMwTm9BajFiRGxkVHI4c3l3MklCUFVqbm5KM1Q1bTZxY3VuaVRhbVIy?=
 =?utf-8?B?Y2tGQm1FVXpFbGNKam50MUhlMWVrSlU2eWxYRDZsQ003SEdkYWhsUHgwUWZG?=
 =?utf-8?B?QmhBbkdNMUprMlpTQkIzVUc1ZDVXR2dOVjBTWWpDS3lpUVRscmhjcVVlbGoz?=
 =?utf-8?B?enhsenRHZjRkWXFPZjZkemxyV2VEZkQ2YjhpQW0vKzRqUEFwOFc2eWNSWjRp?=
 =?utf-8?B?SjhGSnkzandWSitLckJ5ak42YlNkdllBeElINEV4QitxVnpBcmdIME91M3BZ?=
 =?utf-8?B?NE5KbGZmNHhGb2JsQkNIeGdiOC9SM2JoSGczNEZRbHV3REhuYmFFZWU5SjFw?=
 =?utf-8?B?VzUyMWhGeXo3TjdBaUNaUHV4aGhCRmhhOGVOSS9HN2xubStDdENvbHVSRU1i?=
 =?utf-8?B?QjFHVHhEbGVpd3ViRGwwaEYrTlZTNEtkcDN2ZDdRSW5BbnJDeXc4M0lJWE5C?=
 =?utf-8?B?VG8yaG9CclNQRFhtT3oyWXNYNGFzbmJhOHp0blVHcUtqTEZJQkV0TmdtWVdi?=
 =?utf-8?B?RWFVczNsTFcvZ1BUVnlseGl4UkdCOWVPVnNRTk16WGIwN1R1VkpjWHZ3SXFy?=
 =?utf-8?B?S0NwYlUwYzNhUEpBbjJDZ1VPWS9udDZLTVV1dHhiYi81aWs3MElYUUlucFVq?=
 =?utf-8?B?ZHhrZzAxaUF2RW4yaXNTbkJvZ0x3TWFqT0pkZkV2cnBSYXY2REdFTHRtSjNR?=
 =?utf-8?B?UDM5YTVzUkNRMWVUM01WUlNjVENBZk5UbTc3cFJsQU43R1BweTFXMHpHMzBR?=
 =?utf-8?B?THl0cHRZbWNubXN0ekVQZmhsTzZqS3R3R3RoajN0RmsvVjRjT3B3em5NZFZX?=
 =?utf-8?B?SjVqYTcrWFViazhwYURONDVkRmdwTVBqS2pTMHI0TmZRWkNuYThxUkQ1MXE1?=
 =?utf-8?B?YVd5RnVHRTNteDhCYmhvTGdBQkZLQUZtUDVNOHRrWXh0UGx5K3UvbXl2aVhG?=
 =?utf-8?B?NGRvWlhHcloxYkN2Q3ZNbkJLaUJ4QlBYS3JqWlJ4TDd2RGdGR1hRRlpRdVpH?=
 =?utf-8?B?dzBZOHNWeERjZHB5emJmNndTUG1Ici9UNnpEc1JXRWpzSEt0bEdRUHNWZkE2?=
 =?utf-8?B?YWtmMnBnV3dNS2JyTEFyQnhmQ0N4bFNoRWNNb3MzVXRISmthcS9pV0NLblFZ?=
 =?utf-8?B?WDBUUEZ6RGgyWHdPemFuTUN5dzJiYmorcHB0TW9PSHB0R1pQRm1RczZQeGZP?=
 =?utf-8?B?czZablFFdkcrWmNabEQvMGNkK2xXcUpYVzl4V0U5MEZMUi8zZUN5UHZSQUp2?=
 =?utf-8?B?MVBtanhtaEtsWEVNNzdPZ1BKcmtZZnVSdEZCNFB1a1hFcTMvMkZXa3RPd0tZ?=
 =?utf-8?B?K1lyOVdUUTZSQndDNWRldHZKVlNKRmUwdUhhRFE2UjhjOXc2MFhxWEVZd0Rn?=
 =?utf-8?B?WUducXVwbTJIMnc5cnppRUtRVTdkTXN1b2ltQlVVbGZLQ2RWRlRTOXh4bXo1?=
 =?utf-8?B?YWJWbGhra2JkRU5Kc1ZJRUVnKzNaaVUrVEtMTmJyYnkwTm41T05ycnluMGJV?=
 =?utf-8?Q?tsgnZP0HMnYZKAawWzHztyqiD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <932802C8AA84F249BB013E91E9E59D18@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c279a4ee-9567-462d-244c-08db576469f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 05:54:58.8526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWS0uHri0maRVND/pG1kE+ByyZYLNQ3lr97F5jP1LDsEM67I0mgqRPMyplgpRjhVtyynUvUX+mqLYaUM6LrXn7ld+4a2k5zGfXKAnVFC7LA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7029
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTguMDUuMjAyMyAwODo0MCwgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+IE9u
IDE3LjA1LjIwMjMgMTQ6NTQsIFJ5YW4uV2FubmVyQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBG
cm9tOiBSeWFuIFdhbm5lciA8Unlhbi5XYW5uZXJAbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBFbmFi
bGUgcHVzaC1wdWxsIGNvbmZpZ3VyYXRpb24uIFJlbW92ZSBpbnRlZ2VyIHZhbHVlIGFyZ3VtZW50
IGZyb20NCj4+IG9wZW4tZHJhaW4gY29uZmlndXJhdGlvbiBhcyBpdCBpcyBkaXNjYXJkZWQgd2hl
biBwaW5jb25mIGZ1bmN0aW9uIGlzDQo+PiBjYWxsZWQgZnJvbSBncGlvbGliLg0KPiANCj4gQUZB
SUNUIGl0IGlzIHN0aWxsIHRha2VuIGludG8gYWNjb3VudCB3aGVuIHBhc3NlZCB0b3VnaCBkcml2
ZS1vcGVuLWRyYWluIERUDQo+IHByb3BlcnR5IGJ1dCBhdCB0aGUgbW9tZW50IHRoZXJlIGFyZSBu
byBkZXZpY2UgdHJlZXMgdXNpbmcgdGhpcyBwcm9wZXJ0eS4NCg0KYWgsIGlnbm9yZSB0aGlzIGFz
IEkndmUganVzdCBzYXcgeW91ciBxdWVzdGlvbiBhYm91dCB0aGlzIGhlcmU6DQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMTIwMTE3YjYtZmVkYS1lN2FhLTRmMDktYTEyNmEwNzQ3Mzg4QG1p
Y3JvY2hpcC5jb20vDQoNCj4gDQo+PiBBZGQgcHVzaC1wdWxsIGRvIGRlYnVnIGFuZCBnZXQgZnVu
Y3Rpb25zLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gV2FubmVyIDxSeWFuLldhbm5lckBt
aWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5MS1w
aW80LmMgfCAxNSArKysrKysrKysrKy0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5j
dHJsL3BpbmN0cmwtYXQ5MS1waW80LmMgYi9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLXBp
bzQuYw0KPj4gaW5kZXggMmZlNDBhY2I2YTNlLi4zYzM5ZDYyYmJjM2MgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLXBpbzQuYw0KPj4gKysrIGIvZHJpdmVycy9w
aW5jdHJsL3BpbmN0cmwtYXQ5MS1waW80LmMNCj4+IEBAIC03NjIsNiArNzYyLDExIEBAIHN0YXRp
YyBpbnQgYXRtZWxfY29uZl9waW5fY29uZmlnX2dyb3VwX2dldChzdHJ1Y3QgcGluY3RybF9kZXYg
KnBjdGxkZXYsDQo+PiAgCQkJcmV0dXJuIC1FSU5WQUw7DQo+PiAgCQlhcmcgPSAxOw0KPj4gIAkJ
YnJlYWs7DQo+PiArCWNhc2UgUElOX0NPTkZJR19EUklWRV9QVVNIX1BVTEw6DQo+PiArCQlpZiAo
cmVzICYgQVRNRUxfUElPX09QRF9NQVNLKQ0KPj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPj4gKwkJ
YXJnID0gMTsNCj4+ICsJCWJyZWFrOw0KPj4gIAljYXNlIFBJTl9DT05GSUdfSU5QVVRfU0NITUlU
VF9FTkFCTEU6DQo+PiAgCQlpZiAoIShyZXMgJiBBVE1FTF9QSU9fU0NITUlUVF9NQVNLKSkNCj4+
ICAJCQlyZXR1cm4gLUVJTlZBTDsNCj4+IEBAIC04MjcsMTAgKzgzMiwxMCBAQCBzdGF0aWMgaW50
IGF0bWVsX2NvbmZfcGluX2NvbmZpZ19ncm91cF9zZXQoc3RydWN0IHBpbmN0cmxfZGV2ICpwY3Rs
ZGV2LA0KPj4gIAkJCWNvbmYgJj0gKH5BVE1FTF9QSU9fUFVFTl9NQVNLKTsNCj4+ICAJCQlicmVh
azsNCj4+ICAJCWNhc2UgUElOX0NPTkZJR19EUklWRV9PUEVOX0RSQUlOOg0KPj4gLQkJCWlmIChh
cmcgPT0gMCkNCj4+IC0JCQkJY29uZiAmPSAofkFUTUVMX1BJT19PUERfTUFTSyk7DQo+PiAtCQkJ
ZWxzZQ0KPj4gLQkJCQljb25mIHw9IEFUTUVMX1BJT19PUERfTUFTSzsNCj4+ICsJCQljb25mIHw9
IEFUTUVMX1BJT19PUERfTUFTSzsNCj4+ICsJCQlicmVhazsNCj4+ICsJCWNhc2UgUElOX0NPTkZJ
R19EUklWRV9QVVNIX1BVTEw6DQo+PiArCQkJY29uZiAmPSAofkFUTUVMX1BJT19PUERfTUFTSyk7
DQo+PiAgCQkJYnJlYWs7DQo+PiAgCQljYXNlIFBJTl9DT05GSUdfSU5QVVRfU0NITUlUVF9FTkFC
TEU6DQo+PiAgCQkJaWYgKGFyZyA9PSAwKQ0KPj4gQEAgLTk0OCw2ICs5NTMsOCBAQCBzdGF0aWMg
dm9pZCBhdG1lbF9jb25mX3Bpbl9jb25maWdfZGJnX3Nob3coc3RydWN0IHBpbmN0cmxfZGV2ICpw
Y3RsZGV2LA0KPj4gIAkJc2VxX3ByaW50ZihzLCAiJXMgIiwgImRlYm91bmNlIik7DQo+PiAgCWlm
IChjb25mICYgQVRNRUxfUElPX09QRF9NQVNLKQ0KPj4gIAkJc2VxX3ByaW50ZihzLCAiJXMgIiwg
Im9wZW4tZHJhaW4iKTsNCj4+ICsJaWYgKCEoY29uZiAmIEFUTUVMX1BJT19PUERfTUFTSykpDQo+
IA0KPiBlbHNlIHdvdWxkIGZpdCBiZXR0ZXIgaGVyZS4NCj4gDQo+PiArCQlzZXFfcHJpbnRmKHMs
ICIlcyAiLCAicHVzaC1wdWxsIik7DQo+PiAgCWlmIChjb25mICYgQVRNRUxfUElPX1NDSE1JVFRf
TUFTSykNCj4+ICAJCXNlcV9wcmludGYocywgIiVzICIsICJzY2htaXR0Iik7DQo+PiAgCWlmIChh
dG1lbF9waW9jdHJsLT5zbGV3X3JhdGVfc3VwcG9ydCAmJiAoY29uZiAmIEFUTUVMX1BJT19TUl9N
QVNLKSkNCj4gDQoNCg==
