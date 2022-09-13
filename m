Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F56C5B6885
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiIMHSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiIMHSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:18:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1CC58B7E;
        Tue, 13 Sep 2022 00:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663053506; x=1694589506;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UrUQHmc80yR2oaPX7r9jTlgkw//7qYpV1wtqJlTtVSE=;
  b=fadWw+ZtyOXctGHD+Cxo3jw1c48sKljmgGADRl+RqViC8qPPXX9Oxv+4
   X8rpQuxMXag0OOOEWKdqZZp5yIPbYgeXogBPboi+pPfcXypwUj1hOKrJH
   Hbh+qR2Egyr4pqR3mk60/xl2xqgJtvIKltBk9hmsDEEN5QUdXtoruj4wG
   A4LMs0DszllDtrr6BQl0o9F5QOZPyExEr+p2nMZjlfbxlU1LRBlhVSWcw
   pzkPn15eMFxJ80jkcnm+GmI58VwcFl0JyFUfgTyp8ZInsEh9mUvARMhsV
   LeKtYju6YTS5TIC2BKlGLn4X4bpF8OGZiFBHavb3BBlfhPrpbWQpkeBs1
   w==;
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="180141376"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2022 00:18:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 13 Sep 2022 00:18:24 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 13 Sep 2022 00:18:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUpkF6vN9o8IauBZ9Pt8GyNhhPZY2duyDcXbJhQUPDDN2fhIDDfakQb1ozmBWibl/5jnvITnud41rwEaRmPb9jyS14Pd5tuK7u06BVl9aI1g2qJcg5vMZa+GWPvuXS5Ycy5Ou2XLTHIp1rP8eBjRdECmOVEcn7ZgAa+LImml0uYeNLBaatDETmBSASvOQaawiOAjw+9E39SEmG3arzlx6mRPET7KnsuZPynZT1rqls1waKkw5E3pPt0CNwO2cL4B5QVVpYgqmb+kfPyfYh+YwhmAPxwNzmJttmXcESmFsSM0GQnHGuwsMJ5cFz67eXNU1Wi72MDVXsfxL0Rij/yQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrUQHmc80yR2oaPX7r9jTlgkw//7qYpV1wtqJlTtVSE=;
 b=Tg0U+A53zohFjqZNGGC8aZed9c3jW+VRAfZG1Uzv7eX+mvoaGZHd9oNJkbQFh7382RfkCTMBA76KZek7zCbUMpTAmMZhjv6qJjaXIa0qhILh7aLiKfUukXdW3w8kdeFw/djgYnx8UeZat4cLdeypjrchUgXS89VZXyd1wuegCBB3m9VTD0MXMHqgcbms5atJK3bY11+hvwFuWE8ZKVlduYtCDg40Qj0wLIXUZJgdoUFKpUmz2cv+FYpehW/Ff2N9fdu1u4BXNiGlPK2gu39vLuZk/qTFCDOWWT8MnvmmdJ0kHYvnlIhxowPLRlVUjEAe4Lnkcf8HTIaa/oQGzMfBqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrUQHmc80yR2oaPX7r9jTlgkw//7qYpV1wtqJlTtVSE=;
 b=NnDPDU+n4idvJTIG8KACmhjdee5jh5il0y4k8sqcCHXO620RVrBHwTQoXlryyUbvKx9OUQGDk/W67wORdLjiM8JODDQ1//rAM8NBYlxeMM4oa5g22xFNBcDgnDkG/tzT85WIOV5PDkXwHZVGn5llGsjBMERcs7TSktIEdWzkbqs=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by CO6PR11MB5649.namprd11.prod.outlook.com (2603:10b6:5:35b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Tue, 13 Sep
 2022 07:18:22 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%11]) with mapi id 15.20.5612.022; Tue, 13 Sep
 2022 07:18:22 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Horatiu.Vultur@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <michael@walle.cc>
Subject: Re: [PATCH] ARM: dts: lan966x: Fix the interrupt number for internal
 PHYs
Thread-Topic: [PATCH] ARM: dts: lan966x: Fix the interrupt number for internal
 PHYs
Thread-Index: AQHYx0EBJ0DJGsvQEkGW/nakyWOGHA==
Date:   Tue, 13 Sep 2022 07:18:22 +0000
Message-ID: <51e33996-3ff8-69cd-392d-9d5d6298fe31@microchip.com>
References: <20220912192629.461452-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220912192629.461452-1-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|CO6PR11MB5649:EE_
x-ms-office365-filtering-correlation-id: 2930986a-157b-4c6c-1446-08da95582433
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ZjAMa517S6ipNjOZO2MSHg6QkCRHk7CVP43xKX78NHMVYoM4xUOvWzi8ER+JnMKlHfBmGaxv/hbdxA2nVlsLPE4kM5niCFj2y+aacezL0Q9H4cO/r11Dll89wnoYkpUEB1PwNLgIGad0U2XxL/vw9w0b6QiNSJ4Nuh8lAWGEFa8dZecOTtx0PHjFaLxoPcZsg83RrnlYaY8E88kYFgSnNLZm7goihqa/a//UzzGRo6ZNEnGAkQ4/zzFFws5i1EnFKPjieOwGWycZr1Drf7CqF5VZBSBKtVXr33eDoP9tiauE1r+FbBWkWZfU/z/JeUraWO0nPVVFR/3cplo+RfjeUoA6BKsCkEdTcHHZSqja6bMpq2nWNvcEvq8A6Kuoai4urBLCqoXNGbCxFyDjQNSw+tHNeSM/YSWoHl4ovIgeA85HjnHu0Sm1Aq71i0ZrHVCtQ0atjh2YWu7WvBHv2nU+gDckpqXiKS0vrLWrb517O0WtnF1tW1r8KB7X8h4T7I7MSUF8mK8dMkSULj1rdoB3c6dheUdccyyDWn15Efip2RupHj4vSNeu1GvVlW7nF7XnLULH1Fa084hAvnhqzT6ir4kheBhs/ubjFCqaJHCKsbkU9povMRtpaJo7N9Ue/AZBj6jYUPOHT1N5zaP1ULAOHF+U3z7QzpIS4i1Q6u9eyx2pNw+i4hygmsF79G3xISvQSzhIlYpaZVVY7ih2WilKOP7bW26E7+VPwRpI0S5HJ2aL49NsuhWSb9xG5XgaaNVvlLltSRqBbRqbTijgDaR7SWehtjgPLNLc327alaML5NyaTDcGcmGcRdZQ2VH7uxVz924SC38W9M7rV0EEqbfFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199015)(122000001)(66556008)(8936002)(64756008)(31686004)(8676002)(2906002)(2616005)(66946007)(86362001)(76116006)(4326008)(478600001)(71200400001)(38100700002)(186003)(36756003)(41300700001)(66476007)(6512007)(83380400001)(53546011)(6506007)(4744005)(6486002)(91956017)(110136005)(38070700005)(54906003)(31696002)(316002)(66446008)(26005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0xkdGJqcWNVMzVhRk9oZVh1SmhYSXR3Q3BLK0dOYU1VRHhmTEVTVEt5bmpO?=
 =?utf-8?B?cFVCZ0JjRDdtVlhIRk14a2Q1KzBTTVNSbFlid25YZXVuZDhEUkVCTkdickNB?=
 =?utf-8?B?cVJlMlUyUnpUTFdnRTVhK3g1Mk9uOElkb2dpTmQvdGhMYUhLd1NUOHBIc3dM?=
 =?utf-8?B?SGJXRUxQYmJZcTlSMm9aMXF4SlNZd3JGcXEwV0J0d0MwWkZuYUVMY0I2UzA1?=
 =?utf-8?B?cGM1SGNTR1c0Rjh6emxYRTkxc2hvd1Ntend2YzBialo0U3BTOEsxM1RRSUs4?=
 =?utf-8?B?LzY4V2Q5aDlsRlJaMTJqblRnK2Y3UUZneVEzY3ROWlNnT2NiQXlsZlQxdXhG?=
 =?utf-8?B?QmRnYisrNW9lckhQN1BtcWlYa2doUTBOcDM0eHhUTWhxQldXS2hNUVB1TG1C?=
 =?utf-8?B?bUwydnZkUTRKZFpScTJ0Sk5RNllBNVhZbWVPS0JRMmxlWjk0WkRsZnFqVlRi?=
 =?utf-8?B?TnlrVm1qZE9jaGtPK05hTDhKWC9iOFB2NDJmc3BoNUxWUXRqMlUrMUJuWXAz?=
 =?utf-8?B?MnVrT2ZRd3VRNDlmeW5VeFNDNm5DK05IS2dBOXFVd0FZZTMxbWUvOFpZeWxh?=
 =?utf-8?B?VjBFb3B2VjBSYTAxWmhHdGNwSEhHaURQZ0dlYWp0bHFKZmwvQnRSYS9yNjVL?=
 =?utf-8?B?UWY4bUhEbjF5MnBCNUdSQ1Q2SnZSeDRtYmFZYmlIYXhOM0ZVK095MW9VRjNn?=
 =?utf-8?B?MnYyMHpWclVWYXpkb1M5VHRnL2htRllKdWJzS3NQWGgxQUFXNkk0YmdKY0dm?=
 =?utf-8?B?cmk2UnZpMmx3cHFVY24zQ2VMRysxdzYzVkw5c0lWRFhCeklvV3dnUFFqTVhn?=
 =?utf-8?B?Z1hPeGtTdzE4UklUY0lJWlhWbFprUFlWelNRQXJSbktVNjV4Z1hZWlNIeUln?=
 =?utf-8?B?dDQxUEF3cHhveVVaa2tpQS9LZVUyVUVoYkZGUHpBUWFLTmQ5LytpYVpRekFw?=
 =?utf-8?B?eVFpL2xXRG5XeWJkMUkrdHF0MXIvNUFZWXFXYnIxcUkzNWM4aEhuSkF3Y0ho?=
 =?utf-8?B?U0hiWGlvamJrZnJWelJ2MjZFUXNoTTNzbklNYTF2RDhzdStZamdCRGE2REZB?=
 =?utf-8?B?RWp0dktnU0lxdURRbnJka0NlUElVOFJsaFZRdGkxRjlnVDgrclNxVmhTTlVO?=
 =?utf-8?B?aGRKc0NlYVpOd2UrK0Z3dXNNRVZpdGwxVlJTdCtGdlF4SmY4citWcmVDU3dE?=
 =?utf-8?B?Q1RKTVV5OGY3Vk1nWmlYY2tqb2pMaEExMHJQc2gxcEZ0U1hUOGRWQkw5OG1x?=
 =?utf-8?B?SjhheEJDT0hkK1lWZTV0SUppNXMzZWhXcEhHNis5UHdyVFJ3OENLTDBTOEcy?=
 =?utf-8?B?NU52Wm5rWGJhdkEvUDBwM0hsVnNOUFp6ZWJvVjc4YXVQM1ptNm1DRm4wR3BG?=
 =?utf-8?B?NVpuSWNEc2dRVE9yTktzQzhLS3NyOUhWODQ5MXJuT3hoN0VGQXdUS3gxdHNF?=
 =?utf-8?B?TDdKUVZFcUlYTE9iaDhPSXJHWUdua2NPU3J6Q3ZsNS9UbEpFb2tTWm5Nb2lv?=
 =?utf-8?B?am8vV1BLV0Z1WU91TWZYZ2xBOWJmMUw4VVcxR0V6ZXJPMEh0WlZDd08zbnVt?=
 =?utf-8?B?aE5oYlpDTFdnOUdwUWRJemttNitDOTZiL3VZTHNwcDlyVXFkR3haOXZFTFJy?=
 =?utf-8?B?TExhWUdDS3NvTTZuT3VGU0kwRmh2aVpJdWV5dlVqMWNFWGZjWU9waE51MXpB?=
 =?utf-8?B?SVlWMkc2SGY4U2xrUkhhdExZSVQ5d3JyTTVnYWlUZFVLQW9WemtIK1cvbWg4?=
 =?utf-8?B?ay9hUGZBUE9EdDc5MzBvVEJoc3RhUURXQUtsRmJQMXA0SE1NVVM2L1FLTURz?=
 =?utf-8?B?R2ltN0tVNllWRTh5azRkeFdUV3d3YS91Nmtna3hoWDBoTjJkVVAveXQ0VkhR?=
 =?utf-8?B?NjZEZ3drVGx1NG0zbUVpZUJiT1F4Zjh2ODM0b29wSnVIVERHMUFYbUNoU0pB?=
 =?utf-8?B?SWxndllyRzdnU0JEWDBua3Bqc1dLVDZzOHIvREd3WUQzQUNsUm55TnhZU1Js?=
 =?utf-8?B?L09xc044RStYL1ZYcUpTOFVpU0pEamhEc2o0YnlZRkVQWGtBWVFDeHZVVW9r?=
 =?utf-8?B?R1djNDVNcnFFV0lUeTh2Y2hodTNidGxvU01mMXgzaTZ6S2dyRkY2cGNHQzRK?=
 =?utf-8?B?cis5ZG5raUFodGoxUGdIZmRSVTNxRFFaL3pyV1Q0OEpoU3Z0UnRlTWp1aWVr?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05DDB91F37E6544DB96A67FDA4CA6A94@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2930986a-157b-4c6c-1446-08da95582433
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 07:18:22.2865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VimBJ6m5ESIgapKHTaYnWJaOlxHn1gGfGa4Jhoqipc+INTlZlQWKBjAC07yQs9UY2yyMBptREgmMq5JTIgs2/b3V3Q11HEVJu1BFtF97FWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5649
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIuMDkuMjAyMiAyMjoyNiwgSG9yYXRpdSBWdWx0dXIgd3JvdGU6DQo+IEFjY29yZGluZyB0
byB0aGUgZGF0YXNoZWV0IHRoZSBpbnRlcnJ1cHRzIGZvciBpbnRlcm5hbCBQSFlzIGFyZQ0KPiA4
MCBhbmQgODEuDQo+IA0KPiBGaXhlczogNmFkNjllMDdkZWY2N2MgKCJBUk06IGR0czogbGFuOTY2
eDogYWRkIE1JSU0gbm9kZXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBIb3JhdGl1IFZ1bHR1ciA8aG9y
YXRpdS52dWx0dXJAbWljcm9jaGlwLmNvbT4NCg0KQXBwbGllZCB0byBhdDkxLWZpeGVzLCB0aGFu
a3MhDQoNCj4gLS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2kgfCA0ICsrLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+IGluZGV4IGJjYjEzMGEyNDcxZC4uMjM2NjVhMDQyOTkw
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2kNCj4gKysrIGIv
YXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+IEBAIC01NDcsMTMgKzU0NywxMyBAQCBt
ZGlvMTogbWRpb0BlMjAwNDEzYyB7DQo+ICANCj4gIAkJCXBoeTA6IGV0aGVybmV0LXBoeUAxIHsN
Cj4gIAkJCQlyZWcgPSA8MT47DQo+IC0JCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDgxIElSUV9U
WVBFX0xFVkVMX0hJR0g+Ow0KPiArCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA4MCBJUlFfVFlQ
RV9MRVZFTF9ISUdIPjsNCj4gIAkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiAgCQkJfTsNCj4g
IA0KPiAgCQkJcGh5MTogZXRoZXJuZXQtcGh5QDIgew0KPiAgCQkJCXJlZyA9IDwyPjsNCj4gLQkJ
CQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgODIgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ICsJCQkJ
aW50ZXJydXB0cyA9IDxHSUNfU1BJIDgxIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiAgCQkJCXN0
YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICAJCQl9Ow0KPiAgCQl9Ow0KDQo=
