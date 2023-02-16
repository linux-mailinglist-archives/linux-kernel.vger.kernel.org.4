Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B69E6991F4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjBPKm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjBPKmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:42:18 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D69056480;
        Thu, 16 Feb 2023 02:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676544115; x=1708080115;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kdMCCOULMatugT0TgbaWvDXw8oq07+6WLrQ3Fd8zs8U=;
  b=KbUyLXJ1km3/av+NrvkoZaE7iHHlu5Jv17HeFXQUw6VqxGA7e5TaGF/a
   43Limu0qz166kw+oySu5sidG991sOaGY7k9n6h82UNsijQLW7qeD6kEFK
   oIyGF+SLuZgN1Ii+33f80a8XTwN5dH8ZGrUE89j1bJq3XPolk3psQci2a
   oVOoDT+kE74jSFdn/WrjDmtK16Ekxt4CuXQO9BZFMX4sf8nyNBfe6TngS
   YLeytIPr7NX8LCSvvAVuOJm1f40NYIYTvZr6SqGL/GhPawb+Cgo4izx9y
   aP89f1JGa6205KExJUCLmIpJ4kRuhUVo1PUCc+P3IJM8sdqQuvD9AFQIR
   g==;
X-IronPort-AV: E=Sophos;i="5.97,302,1669100400"; 
   d="scan'208";a="200877739"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Feb 2023 03:41:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 03:41:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 16 Feb 2023 03:41:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwY+TyPyj7ORVCYGLatxt0mY2fCsrPy3o8GNbBKY1DZzFwqL2JK/5zW4c8t2DEkCae9kTDMwuYQ9XzRaozn2F0a3aASU9z2Ox2PZv6czhBAkj3q5jfvlJg0lbehWu53NTbDTaJdJK8Gmxzb/2h2nIPplbkNhjFH7bDv5nf/ME2aSV7aJ0o9oxhciq2By4SNgizp09Kt4LETJ4rFrILlvjU+iN+49G1LYHNqwi06XKFXcCeZ7Ea+YHoVATWOrcFdXAYwJ7Babb99u+k7PTh2g7heksu7UdY0BWWfCOE2j7900eB++lSuJF3NC0KoIE5b0CIQAPnTLZQGXNO7heFH2VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdMCCOULMatugT0TgbaWvDXw8oq07+6WLrQ3Fd8zs8U=;
 b=cUrMRwt723igQZ9nFYUDKcm6YqJ6MVpiGkOyA/p4Wr/r8nG0KJ/72ocESR/qJHiEBJYevt8xlMo6sJS+nVplrnq5m21syu+dYshe8QD0oFDeqRWQ2EgQdysQsbI8qV7uh33Kz+PrzUX8KPrCMxtx57XHuKzFxyq4pUtmwy8NTZNxqGW+c1XWCXbx363KTNJdDBdRz/kwnop8KIPDpwQaZSTWja2gvg/tJzgnLpRrhND7qcRALwj+ZK29sG/TAo0jbzlD0oOP9IhV3aNfQv5gQ0+8AzULNTk4PXC4sO+YXiuIUOj3fwIQYuPyfdOEs33loXMhHcgSuE82aOEuJZ8/qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdMCCOULMatugT0TgbaWvDXw8oq07+6WLrQ3Fd8zs8U=;
 b=MrdTW9IY1qnRU6t+d0yr4/havO9A0hVJMdtbJH9Bs7h1c3gMlknqrLFl7lAf6btbOCjpHQs28T07FDvcXDCedivJ8XewsyJN7z/6LTv9mMCrqpfLfj5A6GnV5RxAS6U5pZ7oS6cF8/3segBZ7Ntan9ULmMn3yG2+5cifwECOHXU=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN9PR11MB5481.namprd11.prod.outlook.com (2603:10b6:408:102::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 10:41:20 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6086.027; Thu, 16 Feb 2023
 10:41:20 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <perex@perex.cz>, <tiwai@suse.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: sama7g5-pdmc: add
 microchip,startup-delay-us binding
Thread-Topic: [PATCH 2/3] ASoC: dt-bindings: sama7g5-pdmc: add
 microchip,startup-delay-us binding
Thread-Index: AQHZQfM04FxaA6iPFk+Tnu1ByTX/cQ==
Date:   Thu, 16 Feb 2023 10:41:20 +0000
Message-ID: <8a2132f6-9745-5ef2-724e-14e76fc456f0@microchip.com>
References: <20230214161435.1088246-1-claudiu.beznea@microchip.com>
 <20230214161435.1088246-3-claudiu.beznea@microchip.com>
 <485d74fe-bfb5-c55e-724f-304476624abd@linaro.org>
 <954cdf90-c41a-4e21-31e0-88a0baf26065@microchip.com>
 <fd2f372f-4a1c-72c0-574d-1d5ef99dbdbc@linaro.org>
In-Reply-To: <fd2f372f-4a1c-72c0-574d-1d5ef99dbdbc@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|BN9PR11MB5481:EE_
x-ms-office365-filtering-correlation-id: 076206f3-e184-499d-634b-08db100a5729
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m+0CY7OR7o5D9V7vj0Ft8M0lXjqUw2rVFjDhgG50xe8sXNTmoz9wVfadhdYmal9D99D2URjpV54yzz4a8VH+JCHlMa/z2Im8Qp028HbtCw1yD+ltif5t/m2+aSICC9lZD7bQBfsOKIMIuPKiXFcRa2gFro8ovOcNSM8Oiwhb5OJTngrmGyX3XkguxNBHhFlu4rANZiJZ01bOnNBrFTnnHR6HsjELkWY2gQy6ChlM5x13TAZkJggTylCRsa53VVk9kq+bda36t15EDHl9Ibh57UM6GxLo+cJ8qqUPIXMjKgQkpItgkcw+9/Uhnegiv4ytAPq2xhKKJ0P+o/JkLnCbuQZ9YbxHaD7DvAeFvFW3laRCFj4iXmj9YMV7SSwa9eMK7l/4Wi4SUVPTFVd8fC1G/0dnmDyGoh2Zs3RGya49ZfV7u6X8HxVLBynWEjHrfOchItkN5P79cVjJTCJDlPaI75iHmJ8aE5/siAqaIma7KGp/f/KCirs5EwUP9X3BwOyYJCI35WhcBwY4PM4yo+EECiwhQ3rdy0g8X+tceHbeW+zWBFusuke4WwQVjWf/Ko/RGyeGhK5S0fuJ+xEjP+Gee8f1aCLR7EwAJVdelRn/BaHuzSEBjcHAFAVYdSGxPLyajXSg9yk789XIhvETeVkKHlClNrX8i2DKMYVD/q5TdS+FV/TJGeKNOE8Y41JviK0exENG5LuFMmN55EZCef9/pts42UO6AQV9c6m51W0cXUXVasw/q55lAu/gnbCga6lw9bo9KC94mrDDkgBA8xQQhvgjfKfxW5mxa1ICRbwefZA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199018)(38100700002)(122000001)(36756003)(86362001)(921005)(31696002)(38070700005)(8936002)(5660300002)(2906002)(7416002)(53546011)(6506007)(6512007)(186003)(91956017)(2616005)(316002)(76116006)(26005)(66946007)(4326008)(66556008)(8676002)(66476007)(66446008)(64756008)(71200400001)(6486002)(110136005)(54906003)(478600001)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2tzMy9QQkErd3RqZ3QxWWVSeFZIREFXY0Fzd3d6U2NFQ3RQdHlWVXMrQW5p?=
 =?utf-8?B?WG9xK1hjUXd1Sk4remlpOWZHTGdJZEZURERsendUZHRUY3QxVE1WTEVISjVF?=
 =?utf-8?B?RDZVWHBSaDZRQjU2Q1lmYmhHSDlkdGZZNXcveWltYTY4elR6N1J6ZC9xRjQ1?=
 =?utf-8?B?VmNkVzFzWWhvQmNkaExTaTlOYjFYWTMxcEVneUs2b0tDa2lFVis4VkF2cnBo?=
 =?utf-8?B?RTlDam12REQvM2dLUlZwWHZqTkVYNjVUYlhrb2Yxb3FkVGIyM0dJcVpKVkM1?=
 =?utf-8?B?YXVYaE10M0pHSkI5OVY5VzlZS0FhdG9nK1o1cVVvWnA4QUFwaHZtZlhXTU5w?=
 =?utf-8?B?eTV1cTJ2SkdkdlgyUytuQlZ4ejRneGZtRnlzTGk2RXJTSXpwVkZuVlBnenVa?=
 =?utf-8?B?N0xtM3RsWVZicGtPVzJIVGNEUndJOVlmaDJoQ3FncGVrMWhwczh4NkJPRVV0?=
 =?utf-8?B?YmY5TmFIeWp4aFZaaU5PQzlkeGY4cDNxT0pHbWtTMG1FSXN0MlN5L0hDRTZr?=
 =?utf-8?B?WFFOZVhBOEZveWpWQTJkQ2dMcFB4S29UQnhkV25zdXZ5V1Y4TTdQbmxQSmVI?=
 =?utf-8?B?VXRrOFRIUlBOWmJNdXUxdXR2Y2tXcStkS0pUZitHRFNpUklzdXo4RFhGSGZX?=
 =?utf-8?B?Z21YaTlaT2tQR2VvTlQ4OHZjaDJ6QlV0YTVzelNhcEVtMzQ4NXJRVy9IYTNB?=
 =?utf-8?B?NU93Mmp6ZkdJUlJkMDkrYlM5SVl2N05tT2t2Z3pDMGM5ZEdSTHBSQWM5VjU4?=
 =?utf-8?B?RFFWNUZhamtMTFpvV0hkamFzZU5FcWlzcTBEd3VXZm82ejArUFl5SmszdmFt?=
 =?utf-8?B?cVY2bUpoK1BRdTJNaW5lUW94Q0tuTzYzU0Z1RlVXOVlVQXg0SkhMdGZpQUxC?=
 =?utf-8?B?YmU2dk9CaW43TmpvdzJISFBnVlRabW5yVmFOQ29vdVp5TWR4NVlWYVNMeDdH?=
 =?utf-8?B?dFhCTFovVEdSWjFvOWczQjJKU0p6S2dIM0tOc2NtV1ZpRmFnb3duNnJ1LzRl?=
 =?utf-8?B?bUU0dmdaVzc2d0ZCT1VCNndTK29JNHEzTkFSbytIaFcwMldFU1ZQcjhaUFhN?=
 =?utf-8?B?eFdSUmNQaTd0WmNvd3Z4YzhzNHRSbkZrclBEK3orcHZSMmRDWk5kUVN5TE10?=
 =?utf-8?B?M1V1WG9CV3lzU0FvTFo5REFLYTY5Qlo0MCtEMGlVditwdkhTbldON0tkNzJq?=
 =?utf-8?B?cjNtcVBvSHQ3ejQza2N2b3J4VmN4cm5FZ2FDN0h4eVRJWVRGc3hadXhHTGdM?=
 =?utf-8?B?WUF5NzhmYjk4Wks1NUFYcDhVUkJSU25jY2R5TUM1WjBVKzkwMlJkbTlOaW5B?=
 =?utf-8?B?dUV4ditObXpCTmt0Zy9tSlAwM2R0QWIzVHVLcVJmaW5WbDFqdy8wZXdHUWk2?=
 =?utf-8?B?TjFySXUwellDakJNME1IUGZXTy8zRzM5cmhnNkpOUDRLNGN0UUY3Mm9DVTBt?=
 =?utf-8?B?VUgvc1pSc1F0emZnSlh4cm5lcGJiajZXSEJmcis3ek0vTzV3TUVwaUZCTTZ5?=
 =?utf-8?B?QSt4NnN4OStWL0RzR3laUXliRVhMY0F6YklFWDYyY1N4b0JvWWZVdUxVNUxB?=
 =?utf-8?B?Vi9pajdtVlNuamMxdkZNVTBWb1hWbk1pMEFjamFNZ2dCZnlFN1ZRNk5kK29j?=
 =?utf-8?B?c0Y4WjRzQTRkNEU3ZkFGM3dPTHgzb2VhNXgvN3JNejJ5clJ2MVEwNzB3SG4y?=
 =?utf-8?B?Ukpzcmx2UkprYWxJSkFXb29oamZoVytRNDFOS2h3UzBZanMwaHVMV1gzVm9U?=
 =?utf-8?B?YmUwSkNVWEx6QVh3MWo1QWRKZWZFOGtSM29idHVjOFI1Q3B6OVg5QTk5M2NS?=
 =?utf-8?B?ejBlZnpQUVloalNmalo0dWxBZ0dmY2IzQklpVzlESWVybnM3eWpKTTc2QWpw?=
 =?utf-8?B?ZWV1a3JRdmxLNCtTYXpmaGxSSk1keTdMYVVSNVJseWhicjBmQ3RlVFFwYVIy?=
 =?utf-8?B?alN6SkRNVjhZeGlvSzJWcC96NnA1SEFWRWk0cnVwRU92a29OVkV2WDNuY2ZU?=
 =?utf-8?B?ais1V2o2OWVGNGJtcGQwcGluR1FmR0VrMk9ib09CcEVPd2tBemFBNko2ZUhq?=
 =?utf-8?B?RVhSam12OHZzZVpuTmd0V1lIUXg2eEY0dmpqckVDa0lHdmZMNlZ3REs5WXlO?=
 =?utf-8?B?UUZMQjRUUGY4S2hscTFsYTB2S0U3STJZZ01Nb2hwOUhUVENHalJkVGFBOHZ4?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CBF9F64257EAE4E84FDF72C2208706B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076206f3-e184-499d-634b-08db100a5729
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 10:41:20.0948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xrpi3WmBsny13HQeQjrDi7Ogb7QQ2X1J/KF0oLJqlj2BOUSfBNe3mw91/qCqcLz/RWUtwj+okA3p5n7ibkTAk4rnUzjN2+vElU1GetcvDyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5481
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYuMDIuMjAyMyAxMjoxOCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxNi8wMi8yMDIzIDExOjE1LCBD
bGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMTYuMDIuMjAyMyAxMjow
NCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250
ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IE9uIDE0LzAyLzIwMjMgMTc6MTQsIENsYXVkaXUgQmV6bmVh
IHdyb3RlOg0KPj4+PiBBZGQgbWljcm9jaGlwLHN0YXJ0dXAtZGVsYXktdXMgYmluZGluZyB0byBs
ZXQgUERNQyB1c2VycyB0byBzcGVjaWZ5DQo+Pj4+IHN0YXJ0dXAgZGVsYXkuDQo+Pj4+DQo+Pj4+
IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAu
Y29tPg0KPj4+PiAtLS0NCj4+Pj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL21pY3Jv
Y2hpcCxzYW1hN2c1LXBkbWMueWFtbCAgIHwgNiArKysrKysNCj4+Pj4gIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9taWNyb2NoaXAsc2FtYTdnNS1wZG1jLnlhbWwgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWljcm9jaGlwLHNhbWE3ZzUt
cGRtYy55YW1sDQo+Pj4+IGluZGV4IGM0Y2YxZTVhYjg0Yi4uOWI0MDI2ODUzN2NiIDEwMDY0NA0K
Pj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWljcm9j
aGlwLHNhbWE3ZzUtcGRtYy55YW1sDQo+Pj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zb3VuZC9taWNyb2NoaXAsc2FtYTdnNS1wZG1jLnlhbWwNCj4+Pj4gQEAgLTY3
LDYgKzY3LDEyIEBAIHByb3BlcnRpZXM6DQo+Pj4+ICAgICAgbWF4SXRlbXM6IDQNCj4+Pj4gICAg
ICB1bmlxdWVJdGVtczogdHJ1ZQ0KPj4+Pg0KPj4+PiArICBtaWNyb2NoaXAsc3RhcnR1cC1kZWxh
eS11czoNCj4+Pj4gKyAgICBkZXNjcmlwdGlvbjogfA0KPj4+PiArICAgICAgU3BlY2lmaWVzIHRo
ZSBkZWxheSBpbiBtaWNyb3NlY29uZHMgdGhhdCBuZWVkcyB0byBiZSBhcHBsaWVkIGFmdGVyDQo+
Pj4+ICsgICAgICBlbmFibGluZyB0aGUgUERNQyBtaWNyb3Bob25lcyB0byBhdm9pZCB1bndhbnRl
ZCBub2lzZSBkdWUgdG8gbWljcm9waG9uZXMNCj4+Pj4gKyAgICAgIG5vdCBiZWluZyByZWFkeS4N
Cj4+Pg0KPj4+IElzIHRoaXMgc29tZSBoYXJkd2FyZSBkZWxheT8gT3IgT1M/IElmIE9TLCB3aHkg
TGludXggc3BlY2lmaWMgZGVsYXkgaXMNCj4+PiBwdXQgaW50byBEVD8NCj4+DQo+PiBJdCdzIHRo
ZSBkZWxheSB1c2VkIGluIHNvZnR3YXJlIHdvcmthcm91bmQgdGhhdCBJUCBuZWVkcyB0byBmaWx0
ZXIgbm9pc2VzLg0KPiANCj4gVGhlbiB0aGlzIHNvdW5kcyBsaWtlIE9TPyBMaW51eCByZWxhdGVk
IHByb3BlcnRpZXMgdXN1YWxseSBkbyBub3QgYmVsb25nDQo+IHRvIERULg0KPiANCj4+IFRoZSBJ
UCBpcyBub3QgZnVsbHkgZmVhdHVyZWQgdG8gZG8gdGhpcyBraW5kIG9mIGZpbHRlcmluZyBvbiBp
dHMgb3duIHRodXMNCj4+IHRoaXMgc29mdHdhcmUgd29ya2Fyb3VuZC4gVGhpcyBkZWxheSBtYXkg
ZGVwZW5kIG9uIHVzZWQgbWljcm9waG9uZXMgdGh1cw0KPj4gZm9yIGRpZmZlcmVudCBraW5kIG9m
IHNldHVwcyAoUERNQyArIGRpZmZlcmVudCBtaWNyb3Bob25lcykgSSBpbnRyb2R1Y2VkDQo+PiB0
aGlzIGluIERULg0KPiANCj4gSSB1bmRlcnN0YW5kIHlvdXIgZHJpdmVyIG5lZWRzIGRlbGF5IGFu
ZCBJIGFtIG5vdCBxdWVzdGlvbmluZyB0aGlzLiBJIGFtDQo+IHF1ZXN0aW9uaW5nIHdoeSB0aGlz
IGlzIHN1aXRhYmxlIGZvciBEVD8NCg0KQmVjYXVzZSB0aGF0IGRlbGF5IG1heSBkZXBlbmQgb24g
dGhlIG1pY3JvcGhvbmVzIHRoYXQgYXJlIHVzZWQgd2l0aCBQRE1DLg0KRGlmZmVyZW50IGJvYXJk
cyBtYXkgY29tZSB3aXRoIGRpZmZlcmVudCBtaWNyb3Bob25lcywgdGh1cyB0aGUgZGVmYXVsdA0K
ZGVsYXkgbWF5IG5vdCBmaXQgdG8gZnVsbHkgZmlsdGVyIHRoZSBub2lzZS4gRHVlIHRvIHRoaXMg
SSBjaG9zZSB0byBhZGQgaXQNCmluIERULg0KDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBL
cnp5c3p0b2YNCj4gDQoNCg==
