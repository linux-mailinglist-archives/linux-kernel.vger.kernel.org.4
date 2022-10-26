Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898FC60DC72
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiJZHr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiJZHrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:47:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A007DF47;
        Wed, 26 Oct 2022 00:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666770474; x=1698306474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=n2rLy2OUipMmxJKCdjXHDb/GaNHoaHgXsNxK0JWoahA=;
  b=Kx+6J3sbp7lLhv6IN4GJU+nhU+mRllH69xZwCw4OIKp77g1M+JkCOte6
   CtxLqjfDjjIqdkj7dOxXPp56PwQJ0RDVDsrmC7MSEbrChfjrSHzpwxTb/
   0OPgQsL00rAJeZtioijooEdJdPjwix2SF5oomQlEqKaLQqytCqEFqCnEo
   yF/sKsBE9NKE4dlW3JkPw5NS/hUxSSwH9LTWxUlVybAM8pAdyQvSRAZzK
   ll1I/iwY+IpijviNL8o/LjX2mPeU/WIpzTVjYQMkU2uBT73C107o1Oxsh
   iEBwd/dCafh0GzQgKACflh7WjYPYzcZYcCkdnbqKqaw0hepB+btFfTIcy
   g==;
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="180559950"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Oct 2022 00:47:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 26 Oct 2022 00:47:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 26 Oct 2022 00:47:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu7lmU3FWRuOnAcv4Y4KEgqXTN2Eyl3f/0SB6qi+KxqN7K2O85PWVlvuLOXYBzLwJrR6RH3r14co8trR95F48/2rMOgJ8+7kdsca0U9+4Ch6VS5R9u7g05mBj8HBH/Y21txTYXoUmlZm23JlsVRfb8osWhV988fOu3vO/vEZxJkGzAS0vQuFREMcwWowzlKAcsgLH+gA9MH0ikybQDIfss7KhKPU6fF1//SFCrHxOYOBB0Z8duer0ISIUuZ/cDwDLqCTxIMqmYdz5nlZ+MkBIkAJQ7i6M0uUKFKsVRSqQ+NIbl1X6KJBlQL1OpXDMwBWtxVc2VQcSMxvZtew5vDwGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2rLy2OUipMmxJKCdjXHDb/GaNHoaHgXsNxK0JWoahA=;
 b=BXHI5JnsXibzCO+bud7VeeRLCIQXmBppRA9ltXfe4GFekVe9wxMUxeYWiNcgizdElh1aI4jznIKIBBQOhlTcCDRCI8pgdWkzoaQS3AwOK5Kf+wh9H/N0Zd1O6BEMyotfMrl9V62+ZwB56RHMo6BkVgk+gluYAK0TZlVAkdo67G/DeuwWABdQmXOKoy1A1/o0etxkgIodLPbmTFDv70f+IfLr8ZiNL0eKJajLx6o7ruQ/Wm3TSNyd6aqqvtIokT5T6b3gPlttNErqxB5dItfrMGL0lflGLzC2Z1mjY7KbNvR4M8vCB146Nfp9hVBtCZCjp2qD8vdIcXkU7Ko5rLBLKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2rLy2OUipMmxJKCdjXHDb/GaNHoaHgXsNxK0JWoahA=;
 b=C/tTuDAs+mndDytrx5CF66eoxUdUdO7BxDF+rPYxHze9Bfc+Qa2MJnYKD3nRujRTEw2gCD+BpBYD2xvb9d58LCzo4psN4hxGTBPpvi57QHpZK4ArP4C7ugYhvUnZtP3z9/CcUaKH7hxYZcQoGS+TErAO7a1WxyEQzmll7idNndQ=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 07:47:50 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 07:47:50 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Horatiu.Vultur@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH] ARM: dts: lan966x: Enable sgpio on pcb8291
Thread-Topic: [PATCH] ARM: dts: lan966x: Enable sgpio on pcb8291
Thread-Index: AQHY6Q8/2TEXgnN93UeLwvb+/907Ug==
Date:   Wed, 26 Oct 2022 07:47:50 +0000
Message-ID: <fb12f594-5d71-dc35-c37e-b357e51b6b3c@microchip.com>
References: <20221019075154.2555054-1-horatiu.vultur@microchip.com>
In-Reply-To: <20221019075154.2555054-1-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|PH0PR11MB5160:EE_
x-ms-office365-filtering-correlation-id: a5f6999a-4949-40a4-4022-08dab72661db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qLD5MWoBw0cFYnEWcwEV7Q2/8pNF4mXmEkxKZH3wAha+I+8OjPKrCBSUEm36BT451tehLbCUD53aAFg4tz6Vkj63Qyxrovj71Rti5VdsTFILTEn0zBoajNeZyvyx6fXNYNDxrkHnIX0oguFQVuJW14nPAQK5YiTrzeZgBEbhvEODdJ4neSZJjASySQ5Zefacbi6abIapCEpZyT2Mrj/gOeVjIwNG9+SqoZvy0NB77YHP1py/FDXOBx3oRMgQNwFeubd69ykrlCffO4kPbyrq+Ana2vNg6EQGbM7enQeTwLb1ctjFkmwhbLqaRbDAak8SufF2A/H4kDMuwJQXR+ELhv8hWH1s9xLBTLWcnRN6z8XP1ZX2mNJI8a8CkijjSNdPQQiX19o74GTSDL+/41hJIqNhlQDqCvS2mimE6GzQpsbBo5plOaOR2DXeQPLcjIFgPs6d2xmfhxom8iNpg4V4MzVidfLLcRkZReWBKZpTxG7qpFKSOhx+TsTMXnpBRste2tRz/pX6AVF9k37wrh6CrR78jEeG+nJmyYh7XlLD4Qo8NW//5OMqj/fWACgNc4mOxQ15G676SFtzwtaxbbQ4r8ZjQcjwJnTNis4y7sMomBciAeSTKAtqVOjdOvJ15SXWEL7pSh9EcOAzpvYjBcRmPsaBJ2EiP1USC1kfRhU1vQXMycuHLzBeuH41D38YSpP7jRQWjvFiOx6lat8W/RNBBF+EV30ZrYM8+9nnGBbE/9pSAAfNP4ZrMMrbI7lgWUYEdsnd/+94gPIE5uY7wfhc3xIzk8A9XUmEYUtllqf461GtGT+BIdvAUQygmizU/p8yBLQT7Cu/09G/K4YDrri5SQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(6486002)(38100700002)(122000001)(71200400001)(478600001)(6512007)(38070700005)(107886003)(110136005)(31696002)(54906003)(36756003)(91956017)(76116006)(66446008)(86362001)(4326008)(8676002)(41300700001)(316002)(31686004)(83380400001)(53546011)(186003)(2906002)(2616005)(64756008)(66946007)(8936002)(5660300002)(66476007)(26005)(66556008)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkdrQVRJR0tPTGlKZkdkN0poUjdvNiszNlNPOVRxVDdiS2s3Y2tNd29wb3NP?=
 =?utf-8?B?QVZVWjd2Nm45ZWVMNkp4KytCbGZLTHJ2alYzVGg1SWZ0L2FvOWZndHJ1ekZ0?=
 =?utf-8?B?V0tzU2xpYUd1TGR2TEVNZExFaFBRK3dCYlFhNklHRW5uVDdCbmJZNy9aNzNr?=
 =?utf-8?B?RWRFSC9rTTFkNW9lUzBHdUdCckd0ekhQNmlZeUVvUzlHcGtVSXdBeG9ROEN5?=
 =?utf-8?B?bVJEWGUzenFpUXJ1VS9CdkppK05ubVExWW83QUczN1d0bFhscUdnaUNveWlr?=
 =?utf-8?B?d0k5VGZ1b3pLUTNqNzlwYWdVZzNoTG1aTndvVHRucjRXK0xWa0pHNGk3VFBF?=
 =?utf-8?B?THl6eEhlSzVZT1RxMjdoTFBYaklrWExjZjBOSC9iSVZGU1V0THBvK3BhcExk?=
 =?utf-8?B?dlh6VE9SRGdNWTRJajh3VUh0OHNFNEtXQnhLRFh4ZGhHYVZqQkhTMmZ6Ukto?=
 =?utf-8?B?UVRlWDhSNFc1ZmlLcnJ0aFpvbGFsaHhMSG9SUkhCQ3lxdnFualp6djFSamxy?=
 =?utf-8?B?V0VSYUdjZU5RTyt5bFNpc1hITGRkMU1janZRM3FTaWNnOVJUbTcrVzlGcWhX?=
 =?utf-8?B?MHpZZzRGakhOZDJRTThQM2gwVENQbWpZTUtQcFUxQjFoZGt4S2EwOVNubW1q?=
 =?utf-8?B?RG1hWW5UZ29mK2ZGUHdYRVBqNWliaDFySGpoREd1VjRWaDZUUEQ0WUJNQTVp?=
 =?utf-8?B?K2RvOXJ3Q2Q2cHAzYkcrRStpZkdpREN0QVdGOWJGb1hwU0R4NGc2MnhiSE9B?=
 =?utf-8?B?UENtTkdxNFhJN2VPR2F4N1pYZUs0NXRQaENyL1IwOTFNa0VvUkJ6SHFXL3BW?=
 =?utf-8?B?OHM3dStGNDhEdHFjenFZRm1ab1JsenRUaHBrT3RnRWIvanJjNy9INlh5a3hG?=
 =?utf-8?B?cWVrM0FBWWhIYjVZQnNhWWk0eUs4alllV01QQW1YTW1MSHlnd0J0MmxqK2NX?=
 =?utf-8?B?NWp4cmIrYUlpSFNwOTBONWRGR2RtamNKOW5uRHQyRjBsVERFY3UxSTh4bEh1?=
 =?utf-8?B?VjJUSGVYcWcrcnN6cWdjeDJqRExpdEFDK3FrZlRUOGJrYzl1V1BHRzIwSWs1?=
 =?utf-8?B?WTBOUE02OU5vQW5YRmRtNVhYdnorWHl3RlFjZmhad2liRWpsK2JkNCtwMXlv?=
 =?utf-8?B?VU4vN0M5YnEvb2YrVGVwTDVPSVUvUU9kNGdiaXNtdVBEekpselBqM20vUXBY?=
 =?utf-8?B?OXczQUF0QVVOYUN2WEtkUndUdWJNWGNCUTRNODdIOW93UDhONWpoVVBzWnJ6?=
 =?utf-8?B?NGIrNy9IQ1RWWHluUzNEQ2FIVytTaGR5aXU5a2JNV0RtTUU0RkF4TlFiZWVv?=
 =?utf-8?B?aDZwemFKMXlNVzJidGFXOTNnNzVsUXYvQyt0bGZrQkw5QTBXNVNQN2kvRUJa?=
 =?utf-8?B?bmVaS0FkM1g5dmFiRGdNNGN3TmVqZDZxb2F2VUtxdkhlaWRueGkwbVpGM3ZQ?=
 =?utf-8?B?TjVmK29tbGdhdWxKRTJibkExMXNBNDJpVnpWbUFBQ2g0NWltVmZ6a3FTRUhK?=
 =?utf-8?B?NTFhU1NCQUMrbTU3M0NBZUhrTTUwVGczSEIremZWZFd0ZlpWOWhlSVgvSWZT?=
 =?utf-8?B?SSthZk5aYkZCYmljeUc2MGJZTEZrRGp1c2x2TXZJTERtM3IvWWdMQTJLcDJF?=
 =?utf-8?B?ZFJtTWk4NnduMzZSeDJXNTRaU2I3TkVtbHRRRVVodmpXTG52ZmpXanp0TFZM?=
 =?utf-8?B?MmhRZi9ydTJWYWJoOFlLbkpLdG41WmhZVzdlWXduWFdiNnhudVpndnp2Q05S?=
 =?utf-8?B?RFpYYzh4dW5ZcU5YL3YxUnE5Z214U1FET1FhWE95RlZzaTFVazNWQ3hpTUs2?=
 =?utf-8?B?a21YKzlDa3dkNmcwZkF1NklUa0hkNG5sZGxVQkJlQTJQUGlybVJ1NS9JeDFN?=
 =?utf-8?B?bWJEeVc1Lzk5VWhIZnFzaTM2UWpoSDhQZFBtMHcxbUZrQS9qYUF4Nk1qTDVq?=
 =?utf-8?B?UzY5QkNCYjBQTWM3OU1OYkFYaXoyWVpyUFBsWnJMUlNqM094WndtVUYxRldN?=
 =?utf-8?B?OGJPMkFvTEhWUnJrZW05VnBnZ1hRNTU2alN6bmp4eWxrR01SbDlFRmRtYmhJ?=
 =?utf-8?B?ejFtMkdRMzJ0Undjd3MrbTlLS0FBMFNJRklQSlBLNDZpTDkwYjFsYjdCOEdz?=
 =?utf-8?B?ZFJWM0FXNmhKM1czY3JrMlhaZWgvRCtEbTZQN1oyRlE5NC9Wby9GUzdhbkNC?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D9998BDF90FA247B1B35EB339101733@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f6999a-4949-40a4-4022-08dab72661db
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 07:47:50.4432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wKkefj6SOkzqIKEOMqkmXDgLrdxhUONOKJhpXz4vKVXFleKswY6w80akT+LgOEKrfLZ1HaKU0B/CbRfyJ3sQy5zUq1mdnZXGIRPsEQYCKe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5160
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhvcmF0aXUsDQoNCk9uIDE5LjEwLjIwMjIgMTA6NTEsIEhvcmF0aXUgVnVsdHVyIHdyb3Rl
Og0KPiBFbmFibGUgc2dwaW8gbm9kZSBvbiBwY2I4MjkxIGFzIHRoaXMgaXMgbmVlZGVkIHRvIGJl
IGFibGUgdG8gY29udHJvbA0KPiB0aGUgTEVEcyBvbiB0aGlzIGJvYXJkLiBPdGhlcndpc2UgdGhl
IExFRHMgc3VwcG9ydCBvbiB0aGUgYm9hcmQgd2lsbA0KPiBub3QgYmUgYXZhaWxhYmxlLg0KDQpE
byB3ZSBuZWVkIGEgZml4ZXMgdGFnIGZvciB0aGlzPw0KDQo+IE9uIHRoZSBvdGhlciBib2FyZCBw
Y2I4MzA5IHRoZSBzZ3BpbyBpcyBhbHJlYWR5IGVuYWJsZWQgYmVjYXVzZSBpdA0KPiBuZWVkZWQg
dG8gYWNjZXNzIHRoZSBTRlAgcG9ydHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIb3JhdGl1IFZ1
bHR1ciA8aG9yYXRpdS52dWx0dXJAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2FybS9i
b290L2R0cy9sYW45NjZ4LXBjYjgyOTEuZHRzIHwgMjAgKysrKysrKysrKysrKysrKysrKysNCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1wY2I4MjkxLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xh
bjk2NngtcGNiODI5MS5kdHMNCj4gaW5kZXggZjRmMDU0Y2RmMmE4Ny4uM2EzZDc2YWY4NjEyMiAx
MDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1wY2I4MjkxLmR0cw0KPiAr
KysgYi9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgyOTEuZHRzDQo+IEBAIC02OSw2ICs2
OSwxMiBAQCBjYW4wX2JfcGluczogIGNhbjAtYi1waW5zIHsNCj4gIAkJcGlucyA9ICJHUElPXzM1
IiwgIkdQSU9fMzYiOw0KPiAgCQlmdW5jdGlvbiA9ICJjYW4wX2IiOw0KPiAgCX07DQo+ICsNCj4g
KwlzZ3Bpb19hX3BpbnM6IHNncGlvLWEtcGlucyB7DQo+ICsJCS8qIFNDSywgRDAsIEQxLCBMRCAq
Lw0KPiArCQlwaW5zID0gIkdQSU9fMzIiLCAiR1BJT18zMyIsICJHUElPXzM0IiwgIkdQSU9fMzUi
Ow0KPiArCQlmdW5jdGlvbiA9ICJzZ3Bpb19hIjsNCj4gKwl9Ow0KPiAgfTsNCj4gIA0KPiAgJmNh
bjAgew0KPiBAQCAtMTE4LDYgKzEyNCwyMCBAQCAmc2VyZGVzIHsNCj4gIAlzdGF0dXMgPSAib2th
eSI7DQo+ICB9Ow0KPiAgDQo+ICsmc2dwaW8gew0KPiArCXBpbmN0cmwtMCA9IDwmc2dwaW9fYV9w
aW5zPjsNCj4gKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiArCW1pY3JvY2hpcCxzZ3Bp
by1wb3J0LXJhbmdlcyA9IDwwIDM+LCA8OCAxMT47DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiAr
DQo+ICsJZ3Bpb0AwIHsNCj4gKwkJbmdwaW9zID0gPDY0PjsNCj4gKwl9Ow0KPiArCWdwaW9AMSB7
DQo+ICsJCW5ncGlvcyA9IDw2ND47DQo+ICsJfTsNCj4gK307DQo+ICsNCj4gICZzd2l0Y2ggew0K
PiAgCXN0YXR1cyA9ICJva2F5IjsNCj4gIH07DQoNCg==
