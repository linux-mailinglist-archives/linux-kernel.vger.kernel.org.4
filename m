Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1C96B8519
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCMWqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjCMWpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:45:44 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2051.outbound.protection.outlook.com [40.107.12.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A658D91B7D;
        Mon, 13 Mar 2023 15:45:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpZ2uOhwNU/ZyRpengPyHJUDCiEw13gMHh4sgzRBuFGMjaACNMQ9EmMRxKtm7w+N12DO87fZ+0Ab0ZNnscIGALC/Va0HtFwDjjXsWva61O0VoMBUIZo/4wIDpYkAI/Fy5z3k1+fHJZVISSNp0yQ+q1JiRWh97qiquUi+bI64VTtIfBU+xqdFENzIihIm9RBexew/S7bGYWHHa/Hu32XXxGQjuoUxuHYbvye+a/zmv0KSeHKWtXvdg+b9G3JP1W2Iucomd9NVmu5vfTC+J8wlK4Fn4BPaTkJmBFQ9Un6ZYNA0Odg+8AJOmhaup/gCqiLdeQLoyl8fSaW/mO4mGPHcJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIJ5Esjd0wHdF8rIZI8zYwWJo2tfOLlSZveUsI0El2E=;
 b=dgw0X38qkw1I6I6qtENtMkNJ49jx65c0PgcKo21jqCGlLX8ifKOSM0bPOF2vtpw8jGGJHdMx4uZqkn+rD7hUML6eqIsqW1dfwFcKvnLk09yuzan7pnL7EQsircq72E8WizA3QwHGDUWp/xzILCOIO/SJCdJVwZmZhG1MVW5+yRia9xrXsfdde+1N+18rB1OG238Qp1tenromtEWcv990EPiBTQIF6YxJB16lUMCvf6AK7CBkOtcyp1+6AGra0KAwnf4BKPbSTcYHIBbfxgNeXWuRLUPtL8bOlJK/jITSrGr+Yh5YSImd3QcgS6sBlvcUZIjXpW1OUPT+WJ/cPvYFLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIJ5Esjd0wHdF8rIZI8zYwWJo2tfOLlSZveUsI0El2E=;
 b=OKtLe+gjKlQV/iD40r9PD+nkFPQXACkiknRm1p1I9Siuicth4iL44rC1auzd+HN5E/+A4A6RLO8/TEy0REvvwhBQHyb63kbvD9iD03cg0aJzu4MawoHMpUkCj5NliGKSxMgaCLAl273sTX0E9t4yLROU4lRq7/2bui2RqUQWf2dtm78x0ytL6Tb9fJfy3SBVD9mVR7h/xwW0ofHLs/eYUkQoNeNx7eUGm/WGj4YIByuFBTrPxXB9Plx5eFZ3swKGzM7RfODfnOx13JEPHGq5EjeDpxkxHGAOv1H9wBQoK5Vk9gVyo8XagrjiWUP1sJCie6qjVV81DmAOvZJG91Wg/A==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2488.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Mon, 13 Mar
 2023 22:43:47 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a%9]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 22:43:46 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH] gpio: mxc: use dynamic allocation of base
Thread-Topic: [PATCH] gpio: mxc: use dynamic allocation of base
Thread-Index: AQHZUICFeg9VbWjE5ESPicyCUz0/ga75WYkA
Date:   Mon, 13 Mar 2023 22:43:46 +0000
Message-ID: <dad21ef9-a0ba-dbe0-cc4d-3127417e43b6@csgroup.eu>
References: <20230226205319.1013332-1-dario.binacchi@amarulasolutions.com>
 <CAMRc=MdoMPROUVeu3m9Jx+-5deRMC9jm+zbGBQ=OdHaLApmJ-g@mail.gmail.com>
 <CACRpkdYV3mHNYvBg1nf+12Q2XZH_g4iTrA2YB1SVQ=ROriRRgg@mail.gmail.com>
In-Reply-To: <CACRpkdYV3mHNYvBg1nf+12Q2XZH_g4iTrA2YB1SVQ=ROriRRgg@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2488:EE_
x-ms-office365-filtering-correlation-id: 8be9ce71-0c20-4987-dcfd-08db24146839
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qai4l4GrtVJJTT8H22de7g++t6kAz2LqizX8U5eJFHfvqCLPiOBuFgcSMkvBC12vvPL9Yn0D+eT4Ysq8PL1fK7QXJ5CuChaUZ77tpv2F8thNFonmBKW/9N1gU4NU4q7BoOA70MgkOF2Qmk0re/dkaj+MuKePzobXRqFVcJanxarAmwMP5ywammginwhnzH/4Vif730jQ4qxmGpp347vQ8mLzvcqeOQrHlng5XWP00acspRQQrv65rTdElu2M7KN6xYanU+k3CK+o+cTogmtv5eWaJdDhmyND0sXVphzlK7JkG305lfUuKgagrGtigPbQ67LTznAfysRBPRoD2nWAUOS8mIhb8k3NgughuZYC7LaPFtuvvSXtbydxiJjU2YlFziyRpsOew/dacEwFHezXbCEqaNiXpB9EmGuqNKiwCJJlpoRd/GDK3jpsvgg7TrtDP8P2fddP0ntxU5W5IozQ8jU8xm3yxUMnayFgpAp0+eHimxz3xZ9CNwdmoJ7b3xbZV8O3rNYh3ly9cQ0N7+kYCnVR8otqvLlUtkE0QdVIjUBCDUE2y9wHdcMlfL1cWY5F0wlpwEhdwaAnZNFmeSScOarBpucC8HcxuQD5sqcwTQkcLD6B2DoT4sZQnzYWa1JsKlyijzsn7J+nTFWr0CmeN98ze70VpPOd1iB/4+9CT3elq2nSaEL2FF4WfkYVB7kxNN37bHMIjm3l/yuJ8fmRGQd0g67SvDJqigWZLUO7RU8YTbIdIbe+ENrd/uHmTWkcEAZsv7tvcOhSDx54eyhnaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199018)(36756003)(86362001)(31696002)(186003)(41300700001)(6512007)(4326008)(53546011)(6506007)(26005)(5660300002)(2616005)(8936002)(316002)(71200400001)(110136005)(478600001)(54906003)(76116006)(8676002)(91956017)(66946007)(64756008)(66556008)(66476007)(6486002)(122000001)(38100700002)(38070700005)(2906002)(83380400001)(44832011)(66574015)(66446008)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFZlSjNITElNajBsNmhKbnR6QURGVWU5RnV1RHRPbWE5TkY5Wk0xQmdTOUhl?=
 =?utf-8?B?Q255UG9IczZJU2VSQUJvME9hdmMvVzcxSjNEenBWelNGQUtIM1FhNmJSMU04?=
 =?utf-8?B?T083eTE1Rmh3NHoyNkZQZjFyUXg4enZlZ0QybVpobmUwaWtLaFYyQy8wS1VQ?=
 =?utf-8?B?MVdseW1aSG1jNElmbTRzbUNEeU43K08yYnJXUkhXQ0xqRkZVenFxRnZOQ0E2?=
 =?utf-8?B?N1dxWXc1TUhFWWw0RGdRbXNaSy9NZ0hNZGZLemVXNjJlM1JDUEFpTnlGL05J?=
 =?utf-8?B?K0tuTnd4NkczazU3d1NzQXZZQ0pEb2FMeTQzUnJzeFM1UUtWQlM1SnZ1cEd6?=
 =?utf-8?B?cFg5Z2ZvS2hUN2pCK0lJb2VOZE9nOFJjeTg5Sko5OTNuUGczblhJckJjUklQ?=
 =?utf-8?B?WWFicFpabkQvQXE4Rjc0bnBQWDF0RXpSWmg2Q3FiUmpoZjkwVmU4azRKR01D?=
 =?utf-8?B?d2NuS202cUJjUzdVcnhGTDFycGJVZVVxNDE3Sm50dWdmSjkySk1EUWNKNWtP?=
 =?utf-8?B?a1IvbkpWSEhuTndYWDhMWTRzcmsvYnFKcXc5RFh0aVAxMm41cDJBK0FXeCtS?=
 =?utf-8?B?N2hmQnk4UE54KzVnUklrMjFtbDBJRlJ1dDlPYnJGL3V0clhIdW1wMldOTmRU?=
 =?utf-8?B?YU00S1Q2WjdwREpoS2hMRmkwQjMzR0p4YklzbHJzT3lrZGZEelljYVd3OW9r?=
 =?utf-8?B?NVFCR212TDFJVnpxci9iTzZNdnljZUNWRlZsMlZSSGhJdnhNNjBqT2NoVk9h?=
 =?utf-8?B?YzJGamxFTVN1OVp0L0hqUytteGxZQ29LV0Z0Z0JsR09wS0NFbHkrRC9aVjVl?=
 =?utf-8?B?VmI2a013ZCt4eWlYRFZwNlgwN0pab2JtRnlXVTRXSCs1TlpaNHlPVEh2bDA5?=
 =?utf-8?B?TmJFelJ0cHVsMGpVcXAyYUs3dnNpR1Flc1FzRDJjOG1MY1hRVlZTTW1maHFr?=
 =?utf-8?B?M2RITUQ5cHkrVG45NWhLWFB0VmRNSDlqRndMWEJMeUdmMS9CUGd6a3Zxa0JP?=
 =?utf-8?B?ckdTSjN4Z2NxdTJacVp2TDdjTjV1UXFwWkRIZGIzVFlvMmxyK1lnWWxRSEJE?=
 =?utf-8?B?MDFQYkZ4b0V6QnAzdWovZEZyYTVEUTEwQUtrKzBFeS9GZ0RscjdiNS9rTnlE?=
 =?utf-8?B?SGI2SURXVzNJdXRLMXhhR1M4NGFrQnBHYmQ5TEk4QlhXK05zblNFbnFLNk5Q?=
 =?utf-8?B?b3VDNFFpMjdtbFZ6ZnRTQVVGZVpPZVM0d2VxdkRnemRDK3pOdEhmdngrbkxM?=
 =?utf-8?B?YjdhR2RyVWhURCswUm52bmFjV0hqbFY0QXZ5WXFqVzVMOE1TUThjUVo4a3VK?=
 =?utf-8?B?WEJWRDZWVkJ4QmZtREgxN1VhS2MyOXNwOGlMNWEvbUh4RG16VDRDVmJmK2FG?=
 =?utf-8?B?NWYvOWxpNDZWenVodjgxcXRpWjhjOUVWZ2xkMzUwVXhtaDZiSjlobVRjODgy?=
 =?utf-8?B?QjZqcnh6RC9FWjJPaE0rU3RCRzRvTWhvMUZTZUV0bk1nNnZzMkxhd1U4cWZE?=
 =?utf-8?B?MjFuV0ZVWHp6S1pzTVZZSyttbGNrNFhtTE1YVzVFYUpibUlFaVZ1MThKWmVR?=
 =?utf-8?B?bkZGOVByZU9mVzdoblBaVGpReGlmc0EyK2JnT09iOWViNndRMUVvdG9FVmpX?=
 =?utf-8?B?Y0hsNU5rM1VHaWJvNktUUzVvU3UxM0lYNENHMFRSRHR2Z0RRQmJkUzU5MXdo?=
 =?utf-8?B?REN2U0lYQ042SDFaNkE4QTZqd0plQjZieFJ1ZHNNV1U2b3RtcEU2T3Arekti?=
 =?utf-8?B?M2hYTHRZdm1vVVo5MHdYTkplbzJvYVZzMXlQbTdqaFVtckxPL0N1QU1jYUox?=
 =?utf-8?B?WkcxeTVRYXZUSVhhSmljS2w0Nm9TNTg2OGtTVVNxaDVsamVHSnVaV2MwenJ6?=
 =?utf-8?B?ZlBpL0FpamVRNWErZzNxOG1COW9NSkRtVGtPTUI0NjlzdUxUL2c0a2NEZlln?=
 =?utf-8?B?RGFCQU0va2xERUx1ckRnSVQvVlJHejJiekpkbmhLakFIZU42QzBxWVkwQ2l5?=
 =?utf-8?B?OUx3aUkvSytoTkFuamE5N1lBQlBIbm16RmJEVjZNRGttY3paejVmTGxrdW8v?=
 =?utf-8?B?azBrZGNDdys1SStTMXZySUF5b1RSTjBmcVNHZnZ1SUQ5cGV4NlgzU0ZFZThV?=
 =?utf-8?B?Z0dRbjljeTVmbGd4VHZDOERGL1B3bHdybXRPSU5MajlwemhhOUxMQUkzaUQ0?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <307D01B8F1D0D349AA229C40BB803BB6@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be9ce71-0c20-4987-dcfd-08db24146839
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 22:43:46.9312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lOwAG90yowzRhcuZGWeRAoz4cTXLb1Tqq5vubQKZ583IjibCMK3X1hRolMbmSh1o48CIHbshVosnuBaayaBFXCZsAZlP1dy8f6RxUArB5uA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2488
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA3LzAzLzIwMjMgw6AgMDA6MDcsIExpbnVzIFdhbGxlaWogYSDDqWNyaXTCoDoNCj4g
T24gTW9uLCBNYXIgNiwgMjAyMyBhdCAxMTowM+KAr0FNIEJhcnRvc3ogR29sYXN6ZXdza2kgPGJy
Z2xAYmdkZXYucGw+IHdyb3RlOg0KPj4gT24gU3VuLCBGZWIgMjYsIDIwMjMgYXQgOTo1M+KAr1BN
IERhcmlvIEJpbmFjY2hpDQo+PiA8ZGFyaW8uYmluYWNjaGlAYW1hcnVsYXNvbHV0aW9ucy5jb20+
IHdyb3RlOg0KPj4+DQo+Pj4gU2luY2UgY29tbWl0IDUwMmRmNzliODYwNTYzZDcgKCJncGlvbGli
OiBXYXJuIG9uIGRyaXZlcnMgc3RpbGwgdXNpbmcgc3RhdGljDQo+Pj4gZ3Bpb2Jhc2UgYWxsb2Nh
dGlvbiIpLCBvbmUgb3IgbW9yZSB3YXJuaW5ncyBhcmUgcHJpbnRlZCBkdXJpbmcgYm9vdCBvbg0K
Pj4+IHN5c3RlbXMgd2hlcmUgc3RhdGljIGFsbG9jYXRpb24gb2YgR1BJTyBiYXNlIGlzIHVzZWQ6
DQo+Pj4NCj4+PiBbICAgIDEuNjExNDgwXSBncGlvIGdwaW9jaGlwMDogU3RhdGljIGFsbG9jYXRp
b24gb2YgR1BJTyBiYXNlIGlzIGRlcHJlY2F0ZWQsIHVzZSBkeW5hbWljIGFsbG9jYXRpb24uDQo+
Pj4gWyAgICAxLjYyMjg5M10gZ3BpbyBncGlvY2hpcDE6IFN0YXRpYyBhbGxvY2F0aW9uIG9mIEdQ
SU8gYmFzZSBpcyBkZXByZWNhdGVkLCB1c2UgZHluYW1pYyBhbGxvY2F0aW9uLg0KPj4+IFsgICAg
MS42MzMyNzJdIGdwaW8gZ3Bpb2NoaXAyOiBTdGF0aWMgYWxsb2NhdGlvbiBvZiBHUElPIGJhc2Ug
aXMgZGVwcmVjYXRlZCwgdXNlIGR5bmFtaWMgYWxsb2NhdGlvbi4NCj4+PiBbICAgIDEuNjQzMzg4
XSBncGlvIGdwaW9jaGlwMzogU3RhdGljIGFsbG9jYXRpb24gb2YgR1BJTyBiYXNlIGlzIGRlcHJl
Y2F0ZWQsIHVzZSBkeW5hbWljIGFsbG9jYXRpb24uDQo+Pj4gWyAgICAxLjY1MzQ3NF0gZ3BpbyBn
cGlvY2hpcDQ6IFN0YXRpYyBhbGxvY2F0aW9uIG9mIEdQSU8gYmFzZSBpcyBkZXByZWNhdGVkLCB1
c2UgZHluYW1pYyBhbGxvY2F0aW9uLg0KPiAoLi4uKQ0KPj4gTGludXMsDQo+Pg0KPj4gSSdtIGFm
cmFpZCB3ZSdsbCBuZWVkIHRvIGRvIHNvbWV0aGluZyBhYm91dCB0aGlzIHdhcm5pbmcsIGJlY2F1
c2UNCj4+IHdlJ3JlIGdldHRpbmcgdGhlIHNhbWUgcGF0Y2ggZm9yIGxpa2UgNHRoIHRpbWUgYWxy
ZWFkeS4uLg0KPiANCj4gT0sgd2hhdCBhYm91dCByZXZlcnRpbmcNCj4gY29tbWl0IDUwMmRmNzli
ODYwNTYzZDc5MTQzYmU3YTE0NTNjMmIzMjI0Y2Q4MzYNCj4gImdwaW9saWI6IFdhcm4gb24gZHJp
dmVycyBzdGlsbCB1c2luZyBzdGF0aWMgZ3Bpb2Jhc2UgYWxsb2NhdGlvbiINCj4gDQo+IFVudGls
IHdlIGhhdmUgbGVzcyBkcml2ZXJzIHdpdGggc3RhdGljIGFsbG9jYXRpb25zPw0KPiANCj4gSW4g
YSB3YXkgaXQgaXMgZ29vZCB0aGF0IGl0IGlzIGZpeGVkLCBidXQgaXQncyBub3QgZ29vZCBpZiB5
b3UgZ2V0DQo+IHNub3dlZCB1bmRlciBieSBwYXRjaGVzIGFuZCBkaXNjdXNzaW9ucyBhYm91dCB0
aGlzLg0KPiANCg0KV2VsbCwgSSBoYXZlIG5vIHN0cm9uZyBvcGluaW9uIGFib3V0IHRoYXQsIGFz
IGZhciBhcyBJIHJlbWVtYmVyIHRoYXQncyANCm1vcmUgZGlzY3Vzc2lvbiB3aXRoIEFybmQgdGhh
dCBtYWRlIG1lIHRoaW5rIGl0IHdhcyB0aGUgd2F5IHRvIGdvLg0KDQpUaGUgRG9jdW1lbnRhdGlv
biBoYXMgYmVlbiBzYXlpbmcgc2luY2UgMjAxNSB0aGF0IHRoZSBzeXNmcyBBQkkgaXMgDQpvYnNv
bGV0ZWQgYW5kIHdpbGwgYmUgcmVtb3ZlZCBhZnRlciAyMDIwLiBTbyBhcmUgc3RhdGljIGFsbG9j
YXRpb25zIA0KcmVxdWlyZWQgYXQgYWxsIHN0aWxsID8NCg0KQnkgdGhlIHdheSwgdGhlcmUgYXJl
IHNldmVyYWwgb3RoZXIgcGxhY2VzIGluIHRoZSBrZXJuZWwgdGhhdCBoYXZlIGhhZCANCnN1Y2gg
d2FybmluZ3MgZm9yIHllYXJzIHdpdGhvdXQgbWFraW5nIGFueSBwcm9ibGVtLCBhdCBsZWFzdCB0
aGF0IA0KcmVtaW5kcyBwZW9wbGUgdGhhdCBzb21ldGhpbmcgbmVlZHMgdG8gYmUgZG9uZS4NCg0K
Q2hyaXN0b3BoZQ0K
