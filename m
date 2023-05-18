Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5732E7079B8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 07:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjERFkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 01:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjERFkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 01:40:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722AE273C;
        Wed, 17 May 2023 22:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684388410; x=1715924410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TqTEpCWhNlyUvaXBb+Rnpd9foTksOS044EeU9FQSrjw=;
  b=I98uwsHFxl20tf0QIwl2KQo6AkO6Le7sIAv5siBK+nP1ADSxN1XtUjb7
   I59Fw16k02bnlTnceTr0l5wCtuxS31jR7jjBnYd2j24dufHYfCBxnbhyQ
   unn+Av4QDShC41CNcq8ZOO2crSVcIM2cfYbGvWeea6YmyvXpWr9YMaJDX
   nS6bDRGLKpOCKq/4fqp1/SpUo2qpf/7mP6x478bucZHaUceXON3LwGaDI
   Tr4s1vItMEo/UVRhG2OxMLqeC50JgnwCZipHjj6SVdYGuaz4Xx2upwJQW
   2jrg5psk8lZaLbhvD0hrzYpeGZRjZAhzYip46St3UZLc7wAI/TJGPu3zS
   w==;
X-IronPort-AV: E=Sophos;i="5.99,284,1677567600"; 
   d="scan'208";a="216033529"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 22:40:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 22:40:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 17 May 2023 22:40:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOz/ctZaB8yJ/SYrR/dMiy9gNjRyaX+f07/jO0Cfxo99vFRv06PjAvKLwyJSejhjAS4fmMKPBorDkPBsuVy92mgDFbXurumiq2VUtNXSJ7lopgt2WpB714+d/FhLlP7EwtSEpvAY89xw2ZbuBIegdnBtp4iTikSL+N+dqZljfDck8eWq8js43FDWt7q8zYsAqHVG0LyZyD6P7v9f0SeOiBMJjyVUeykUIKO730+5n4SbpUinPrLrr9QjfBRfM3h5WdOeKk2bXXFyJd14ORy0H8J5kUkKW/8frPm1mbMwUCxxjjycvC3kP2LLOyGz/us3Uxin6BS4pQE2TIs8jJ9Svw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqTEpCWhNlyUvaXBb+Rnpd9foTksOS044EeU9FQSrjw=;
 b=Pfhc7P4MZcArg11yGrewj/lZnVXysjjEe+lplk1KNl9pE8M3/L5rerrk7niR8ixM+YJUWQNYNiR0iJmvuZH5TTFvfvCUuoD6XSA6Ry4WMlCCXzBeASny1S/u/oWt2O/pqBYCQPmaoZ8KDZybbrXeen+6rmV8BMKvuSal/nHx3g7geJYTADPdwybUUvI2Bov6Nf4A2HxhjliSnY+E1o+5NDgv5QcnzhvQaocLQeM3R3cUhDOkdMx5kAoB+879CVvnK6DxbPhchzx/+M3DizZhNx7mPvLE4geqHct8vv+SEyx6vdueeK134AUmbfYvwV2bIyHm+esuFWezFsMxpho4ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqTEpCWhNlyUvaXBb+Rnpd9foTksOS044EeU9FQSrjw=;
 b=o25vYWf4KBfiEu9hc6kqa1VanfD9v7m/WnL/ZkHHlrl88B+SYNiUPCTbFM3bHugDIKdLHATnl5Mgg/vrHicV6gHEnmDxGftsgnryYtUr0qBLjnxydnjSnXMci766ktSuR3DA+Fyjnh/zR/4wqPc510cBX7S87QyPDLFn0Bg1jmM=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by BY1PR11MB8054.namprd11.prod.outlook.com (2603:10b6:a03:52f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 05:40:01 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 05:40:01 +0000
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
Thread-Index: AQHZiUsv0c7YVchK7UeIf2o6Dg8HNg==
Date:   Thu, 18 May 2023 05:40:01 +0000
Message-ID: <c85c1f09-64c3-c8d4-7e8f-985665d1622e@microchip.com>
References: <cover.1684313910.git.Ryan.Wanner@microchip.com>
 <d898c31277f6bce6f7d830edf4332ff605498c7b.1684313910.git.Ryan.Wanner@microchip.com>
In-Reply-To: <d898c31277f6bce6f7d830edf4332ff605498c7b.1684313910.git.Ryan.Wanner@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|BY1PR11MB8054:EE_
x-ms-office365-filtering-correlation-id: 169d91e5-4465-4290-181d-08db576252e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lhz6PKUn9ruiIHnuC5xpKOLQLzruy8CSnB/pURpJmBsTFjJBZLSxM5WqHWkgBK8OQxJdYJ3c+IO1oBRFilwk6ADzgQgSDX6bGIaEVGQcg18qtZ8XJN+pKophf5Vw8jO48Yzlym80yQQNfcdQG/tsi/5QIcyqUU+MqA/TYIoDjTuM76NtftEQsIHs+Jzm2BCeDpp8M+joX0sYLvnx40D6yh6hDBUBRq9WqeYxnQF+1MmKaKwWv+DfvLh9ZZpeYxy9Nss/KD2xIgakDrO4xzxuaemcsf+YZ5Tf3tCBH92daZnlk+Gslp9D5ujEkzsL0PkPwOPYCl4d4hW6yKaQyBOG0Cs0nJDEQ/8SMqg7oaMnSqVg+BqOIOvIGzpJd4c8gSnHHqP33gbDDWZLsGy1JpDTYaJ09kjeBsF4jAdj3RN9ukacaVV+Mex7ncKLOXdSuGpPpcdaLGdOo/yE+4zglAT2AE+0zNvL65NCeXOZ/fMF+FgvyYnbV/RX1/i8ZtfFumBRNUlOxMTN13H3yOqjCigJm1dLA/ZH9RnOBHGkbEjqCK0L6wV6oLJ0KRq5PlSaLwv4hkdeTi1wA1tgRru3Lxwi4JgIdhZWUQ5QDKPESJAXuXS8O0jEAjbq0KmU53NzoKhJfXKSODw2+F4YyImG30O763JgxVl/RRiDSoBvnJDmwXyxfs4KdT+6Z2Z43B9+LyXY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(316002)(6636002)(4326008)(36756003)(2906002)(31686004)(8676002)(5660300002)(8936002)(478600001)(41300700001)(64756008)(76116006)(91956017)(66946007)(66556008)(86362001)(110136005)(66446008)(6486002)(71200400001)(26005)(6506007)(6512007)(83380400001)(53546011)(54906003)(186003)(31696002)(38070700005)(122000001)(38100700002)(2616005)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTZmNVNkYUlGWEorVTRjcTZZV1MyRXU0UTZOL3RzL1FJN2NhR2tDVjVxY0kz?=
 =?utf-8?B?VmgxTlJzZFFpSXFHNm53UGxWZnIycGkyTVRaRitxdHE5WVp1QWgvdUxIWVp4?=
 =?utf-8?B?RXAvSHEvSkFQaGpFQTlKUmJhWVVhZ0FrVytpYitTUG1kaUd5WHZuTUdxTEZQ?=
 =?utf-8?B?L01YTTZRMFBYdVNETFhCdCs5aWdpdmoraXpvWXkzeThGcTN1dWNjNTJ3ZEVC?=
 =?utf-8?B?ZDdzRGpRczRRc1F0c2VOZ3hGSThDQjRYZWZVaHlsVmc3eG5YN1JZcytaQWlE?=
 =?utf-8?B?bG5jL3hUUmtWTThFU0V2enUzQ0JsZWFjQlZpcm9tQmFRT2MrZHY3RjFxbXN6?=
 =?utf-8?B?aldDTENnRitGZ1VxTzRBamhheS9FbFhRaEgzSmR0dkRPS2NGak13Q20vMGJ6?=
 =?utf-8?B?L2hXYjZlaTNmOWxlNnRuTyt2VWU5VHM1dUlvZjUvcnVsQnYwRDdYbDhmM1Y5?=
 =?utf-8?B?aSt6aWIydlhMbm1xaGxzZXYzVURublFOYjVidFVRTkYxZTdPR0FBMXc5aStz?=
 =?utf-8?B?V2J1bVU2QlJJbnllN2IwTWZhbENwdFVLQTlwNGhDUEV6c1NBSUlXcUJjWllU?=
 =?utf-8?B?TjRXdWd0S3J1ZlQ4NzVxa1VaRmJ4bVZzUUJKTUpjcEhDRXBTeHdhVWJzQ29v?=
 =?utf-8?B?bjAwT2NnbzRNSm5uSFhuUHR0SFhVNS9najJETkd3MUdMa0hWREpsMERlbXBU?=
 =?utf-8?B?eEd1azFzRzFROEVCSG4rREQyRDN1dmsyYVRQTG9iT09HRGlGNktzOVZXN0Rp?=
 =?utf-8?B?em12Sys4ZGNxbXBPdzZpM0tld3d1RmdVVFdqdk1qYXoxcC9EVjBXbXIyZm9P?=
 =?utf-8?B?VDJpazdZZzRueGdNTkFGL04xRmVsSjVHVHVmMXlNL2FlUDIxMkpGZndNNnNN?=
 =?utf-8?B?R1g4aTVCdXg1Nlp2MVp5ODVQUnJCN2JBUzBFeVpoaUhEYWppYUVscTlNTWUx?=
 =?utf-8?B?Q1ordnVkakJkN0ZpT01Ud2ZiRzRLL1hITElWSU1VWC9DU081LzVWS3lrZ1pM?=
 =?utf-8?B?Nm5CT21vd05UaHpoWndlSGlxUCt5UTZyUzhRZ0pEZk1pcXhhWlFiSDZNNys1?=
 =?utf-8?B?b3V2Q1JMd0x2eTlxZVlpcG9LQU5zZmViRGw3cjhJQllNa1NCUXNvTjJHcm5q?=
 =?utf-8?B?TEFxSFBEWlpqTlN5dzhKZTd5Z3ZVZERFcnROM1hEVERPbjBwVzJ6THgyTzkz?=
 =?utf-8?B?a0srbkNHTVZ2NnltREp6QmYvcGwzdThoNUN5VG1ZdFVKcDZQVlV0K3NLVzVX?=
 =?utf-8?B?WVg5L2lLZWZtbWVWS3FOOC8zNFFOdk9hSmhWK2tDRGxLT1BJTGNxMG5yVlRT?=
 =?utf-8?B?RWVocGlXQ3l6OGN4V250cklFTU9hUHp6VHlzZzJOWW1VYUlmanhnRDBuQVhT?=
 =?utf-8?B?SjR0Mm1qQUx6ekc4L0ZFK2crblFQL3JYbUtJcUlmL3dmOWNkTUFTL2JGU090?=
 =?utf-8?B?a1dVcDFVNURHNWRsemx6bnVxL0gxNzlib0NNUUNEdEpValBnRGtNQXgvZUw1?=
 =?utf-8?B?amV4VFJYQzdISVJjTnp2dVg0bS9penRtRE5YRlBYZnJQWEowb29ibWRlcy96?=
 =?utf-8?B?dnBmVTlyUmNQNncxd2psVGdqNHVVdWx0YzR2ZzF4dmZYYWxabjB3cDUwYjZ0?=
 =?utf-8?B?N1oxbUJWLytHMnNGVElwMWd6OGJUSCtVdk1yMG1hWlRhdkJENnhUUXdaMkNs?=
 =?utf-8?B?a0doSyt6N21XcDhCMFJ0RHduV3NtMjlhWXZ3Qm1KYzcyZ0xzUHRIb08rei8x?=
 =?utf-8?B?NmpHVGFMbmhFZElzaUNDbDJRUEo4cHJYOURXK1pEZVlLUDR6Qkt2c1RadTBV?=
 =?utf-8?B?SkhLTWdYYis3OXNmUkN6SDZ6enFxOUh4SGNYbHVRcmI5dmluM3Z1WWlFcm85?=
 =?utf-8?B?MzhIN3NsVis4clhGSGFEdTRYZUNXeDlMbzh4YUtrQk4yOGZ0Q1ozdnlFblgz?=
 =?utf-8?B?cWZoVjBldWJ1c29TT0VRZkxqM25HYUNyK1cvK0k4Mldod0pHNGNPZ25PWWZH?=
 =?utf-8?B?MkRidXd1NjZwcFlJU01iMC8rRE1DZzVhWm1ycXN2NWtZMzhnSURVazlkSXVw?=
 =?utf-8?B?blYzTTZ2Qm15TmtqMTM2QkVFTkdFclZZdW1yL2J1Q0hpb3Y1SG53QzJtdlYv?=
 =?utf-8?Q?7H9MgS9BW27fSqriGYhiXdbkL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E579DB80CDC50B439FCCBF4C02152F79@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169d91e5-4465-4290-181d-08db576252e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 05:40:01.1847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AfvT+wnuenEBjUd9BZLRNAQAF7qQXJzM1sesiwgFVAHwlAbb9y+44W+2BTmSRw0oEVKcyrCb2E08qOgacaory0CTfuqtyjn8e+Q4DXTWDYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8054
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcuMDUuMjAyMyAxNDo1NCwgUnlhbi5XYW5uZXJAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4g
RnJvbTogUnlhbiBXYW5uZXIgPFJ5YW4uV2FubmVyQG1pY3JvY2hpcC5jb20+DQo+IA0KPiBFbmFi
bGUgcHVzaC1wdWxsIGNvbmZpZ3VyYXRpb24uIFJlbW92ZSBpbnRlZ2VyIHZhbHVlIGFyZ3VtZW50
IGZyb20NCj4gb3Blbi1kcmFpbiBjb25maWd1cmF0aW9uIGFzIGl0IGlzIGRpc2NhcmRlZCB3aGVu
IHBpbmNvbmYgZnVuY3Rpb24gaXMNCj4gY2FsbGVkIGZyb20gZ3Bpb2xpYi4NCg0KQUZBSUNUIGl0
IGlzIHN0aWxsIHRha2VuIGludG8gYWNjb3VudCB3aGVuIHBhc3NlZCB0b3VnaCBkcml2ZS1vcGVu
LWRyYWluIERUDQpwcm9wZXJ0eSBidXQgYXQgdGhlIG1vbWVudCB0aGVyZSBhcmUgbm8gZGV2aWNl
IHRyZWVzIHVzaW5nIHRoaXMgcHJvcGVydHkuDQoNCj4gQWRkIHB1c2gtcHVsbCBkbyBkZWJ1ZyBh
bmQgZ2V0IGZ1bmN0aW9ucy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gV2FubmVyIDxSeWFu
Lldhbm5lckBtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvcGluY3RybC9waW5jdHJs
LWF0OTEtcGlvNC5jIHwgMTUgKysrKysrKysrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BpbmN0cmwvcGluY3RybC1hdDkxLXBpbzQuYyBiL2RyaXZlcnMvcGluY3RybC9waW5jdHJsLWF0
OTEtcGlvNC5jDQo+IGluZGV4IDJmZTQwYWNiNmEzZS4uM2MzOWQ2MmJiYzNjIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLXBpbzQuYw0KPiArKysgYi9kcml2ZXJz
L3BpbmN0cmwvcGluY3RybC1hdDkxLXBpbzQuYw0KPiBAQCAtNzYyLDYgKzc2MiwxMSBAQCBzdGF0
aWMgaW50IGF0bWVsX2NvbmZfcGluX2NvbmZpZ19ncm91cF9nZXQoc3RydWN0IHBpbmN0cmxfZGV2
ICpwY3RsZGV2LA0KPiAgCQkJcmV0dXJuIC1FSU5WQUw7DQo+ICAJCWFyZyA9IDE7DQo+ICAJCWJy
ZWFrOw0KPiArCWNhc2UgUElOX0NPTkZJR19EUklWRV9QVVNIX1BVTEw6DQo+ICsJCWlmIChyZXMg
JiBBVE1FTF9QSU9fT1BEX01BU0spDQo+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwkJYXJnID0g
MTsNCj4gKwkJYnJlYWs7DQo+ICAJY2FzZSBQSU5fQ09ORklHX0lOUFVUX1NDSE1JVFRfRU5BQkxF
Og0KPiAgCQlpZiAoIShyZXMgJiBBVE1FTF9QSU9fU0NITUlUVF9NQVNLKSkNCj4gIAkJCXJldHVy
biAtRUlOVkFMOw0KPiBAQCAtODI3LDEwICs4MzIsMTAgQEAgc3RhdGljIGludCBhdG1lbF9jb25m
X3Bpbl9jb25maWdfZ3JvdXBfc2V0KHN0cnVjdCBwaW5jdHJsX2RldiAqcGN0bGRldiwNCj4gIAkJ
CWNvbmYgJj0gKH5BVE1FTF9QSU9fUFVFTl9NQVNLKTsNCj4gIAkJCWJyZWFrOw0KPiAgCQljYXNl
IFBJTl9DT05GSUdfRFJJVkVfT1BFTl9EUkFJTjoNCj4gLQkJCWlmIChhcmcgPT0gMCkNCj4gLQkJ
CQljb25mICY9ICh+QVRNRUxfUElPX09QRF9NQVNLKTsNCj4gLQkJCWVsc2UNCj4gLQkJCQljb25m
IHw9IEFUTUVMX1BJT19PUERfTUFTSzsNCj4gKwkJCWNvbmYgfD0gQVRNRUxfUElPX09QRF9NQVNL
Ow0KPiArCQkJYnJlYWs7DQo+ICsJCWNhc2UgUElOX0NPTkZJR19EUklWRV9QVVNIX1BVTEw6DQo+
ICsJCQljb25mICY9ICh+QVRNRUxfUElPX09QRF9NQVNLKTsNCj4gIAkJCWJyZWFrOw0KPiAgCQlj
YXNlIFBJTl9DT05GSUdfSU5QVVRfU0NITUlUVF9FTkFCTEU6DQo+ICAJCQlpZiAoYXJnID09IDAp
DQo+IEBAIC05NDgsNiArOTUzLDggQEAgc3RhdGljIHZvaWQgYXRtZWxfY29uZl9waW5fY29uZmln
X2RiZ19zaG93KHN0cnVjdCBwaW5jdHJsX2RldiAqcGN0bGRldiwNCj4gIAkJc2VxX3ByaW50Zihz
LCAiJXMgIiwgImRlYm91bmNlIik7DQo+ICAJaWYgKGNvbmYgJiBBVE1FTF9QSU9fT1BEX01BU0sp
DQo+ICAJCXNlcV9wcmludGYocywgIiVzICIsICJvcGVuLWRyYWluIik7DQo+ICsJaWYgKCEoY29u
ZiAmIEFUTUVMX1BJT19PUERfTUFTSykpDQoNCmVsc2Ugd291bGQgZml0IGJldHRlciBoZXJlLg0K
DQo+ICsJCXNlcV9wcmludGYocywgIiVzICIsICJwdXNoLXB1bGwiKTsNCj4gIAlpZiAoY29uZiAm
IEFUTUVMX1BJT19TQ0hNSVRUX01BU0spDQo+ICAJCXNlcV9wcmludGYocywgIiVzICIsICJzY2ht
aXR0Iik7DQo+ICAJaWYgKGF0bWVsX3Bpb2N0cmwtPnNsZXdfcmF0ZV9zdXBwb3J0ICYmIChjb25m
ICYgQVRNRUxfUElPX1NSX01BU0spKQ0KDQo=
