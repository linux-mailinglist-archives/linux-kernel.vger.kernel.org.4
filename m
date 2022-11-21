Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C33632789
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiKUPNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiKUPML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:12:11 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEB2CD969
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669043175; x=1700579175;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hlPz0Q5hQVVfm5sJG/lJGKSRrOFQzj7JlNWbl/xH404=;
  b=dqDyI+t85Cw3muhos+TBeWl+tRPFi1CMBUwgX7iydmlPdLxc1G/sPZvA
   lgYb6t9DtXu7LC8ts6oMjhddCOHWMAtH4xW481UyHHJhpQZ5V+ZTnqki3
   enckmuozSmapxFfw0wrNttXlF89f96uyaoiwhtU7Mx5naXg/DAm+XH1Ok
   2cFgY85VLQl4eEneWFgjUPuz1AlxWXcKhORk4BhlN1ds+1qTgCI2dyQ/z
   KEEMGpSDjlSurKU25Eh9YbDbwWofmp6XWb1X/adwC86DnearoCHAn2i7Y
   Ms0ByevnkzgbntQJDwNBAtPJ02IjI1WFnGqC2jkQR2HGFAR2i8q46VwvT
   g==;
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="200719999"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Nov 2022 08:06:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 21 Nov 2022 08:06:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 21 Nov 2022 08:06:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRXIhH08NZAB0NWDUc3XrsnO9w3/SajElPfxIFF+GuQukr+sCybFZXgY7gJ8gaR9KzrWCwKyjfv7FLIP+ReU6zSrow9Lw/hkpiZECpkXy5RND1XCKYFvGZsawuhyknlAROhLHrzOBjjoPKK/OVNRe/CocYF++t4RGz0kOWn/pyHgUVB4YNnZNFbZZgBLIXwGEq/IJoHF6HvjfKt5nKVd5xJTh1OOf7Zxq3SIE0qFW2vO1yBbKBtL1sm8f2cx1jxPl3+JE0ixmeW40cA+e3Y0PZC5wJ9Sm2EZjuheH0kL52MMTwjDmPdq26LbMpc9RKoxTDsxGiFLlFeUWVLINhJpVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlPz0Q5hQVVfm5sJG/lJGKSRrOFQzj7JlNWbl/xH404=;
 b=KvKMANfQOWJ+OQuNQ1aIzeItZsDcCzhU1wAz6Swud7rTEQ+6hcEDS6pmOu/SmXQxJCMSJajHUNqD6u5OxSo1KFLq/rfoBqqgKStkuasaoWXMIGjc9QhK2lxBfm0ZWcTqzaPDPHs4JNInprbCJDGn6HstLWQll0M5XiCFf95agNzzOORyAArZtPO+OS9ukMYZB4TycPemB4ZNK49TlcvXmyRcP3JVac6/nubN7M57m95TfMyuHzEhDXVQPUYIiHONRf+duaj7EYtgjrqYWJqndrM/iKHOkhqreDdJ73BDoBQr48niaZVwAu8tdML0VEla+YhnwhfCgVtGxaocfB7Mkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlPz0Q5hQVVfm5sJG/lJGKSRrOFQzj7JlNWbl/xH404=;
 b=XEvJIOdGzGyjqObAxzZl3urZywiZ05jUF5f1i4Lq6sThQmp5by9N5URBN6migY46oyzEKQJmLz4zHgWE/kHjtfDNBjQ3XOWRK1UYxk8ASRpNQM34STNRlSQ8bnVM25JyCTuJuSMGrXkqIYDN8ezBpPUDPB0H0pnk/xvgJ75/7qA=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 SA0PR11MB4718.namprd11.prod.outlook.com (2603:10b6:806:98::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Mon, 21 Nov 2022 15:06:12 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::626d:ef37:c13f:1c4b]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::626d:ef37:c13f:1c4b%5]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 15:06:12 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <tomas.winkler@intel.com>, <pratyush@kernel.org>,
        <michael@walle.cc>, <linux-mtd@lists.infradead.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <alexander.usyskin@intel.com>
Subject: Re: [PATCH] mtd: spi-nor: macronix: Add support for mx77l51250f
Thread-Topic: [PATCH] mtd: spi-nor: macronix: Add support for mx77l51250f
Thread-Index: AQHY/brLyrs62aNvt0aSmsrEsRAssA==
Date:   Mon, 21 Nov 2022 15:06:12 +0000
Message-ID: <97a3b023-b9bc-c34d-45a4-ddd56f47bd76@microchip.com>
References: <20221023060407.1139129-1-tomas.winkler@intel.com>
In-Reply-To: <20221023060407.1139129-1-tomas.winkler@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6479:EE_|SA0PR11MB4718:EE_
x-ms-office365-filtering-correlation-id: 176dcbc6-6b74-45a4-04fe-08dacbd1ed92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WaGCbTT71pSqWjjo5Wx2vYaymBVuoO50k7Q4GMLNG8McT8ojUhSXWN+zoodnDlhpS7Oe0UKBNmJINfXg9JaotFx/oO5E88AKAOSU9mJwx76P1nylI7d2uhyEdbWkUa7MQRycBFQPE4/Mf6GTFs4dPOckTsqqSdN7iIEqPPvPqHhLishJGz9fNCK/cW+Abq3xywLSmYWevC215wKWjm3+63kKlOe9rFYA78GkeXYB8IgGXZ00OVJNkU0exmHBY/Q4lkFafTYTt5sYi0BRcLSAgrS96vQmM6lsqqMxBe0aTDJqrp/NXDvrXoUcErOJ0fL0MlAwmOy66uMaK+J1saqGmXr0Zsm2kf4t0xalABgUQdz1dwhh5nBDBtto8vh8+mPtXLTEITctN9v9LMLEn+E2OjZBVK7kuC75Rtw0QCDajFWz5BRZzUu00NdmrGZlZzzbg1wU8PJelxasicVhaZeNpTqUDeZ33DoZykOXFD4jyfhlGLnaLI8NgkH9tZOmBk5F7wMH4eNKgOkIMSC4S52ROobi7gAd9AeEbApMQHudhI9VoxHKMhx5gS53UZvvplhyrov7KkhseQuYPlKekf+XTPHEorhjqBkB0YrzNFc4HzqsKEUy9qVv/auVQEP3sCGUAWrjIXOyxGssXxydm3iixqIjBTlPEmITmeepwMrVGrOts1T1V9Wnms+6MIjwZTaBUpudrYZkn65XBOv0rc/4Dtn50TNkry3RYQlBsOYQGrBpjxYMC7V93VhIKihe/RH3aHioBzVF2ehOAOSnmtH/aZb04W+Pl+XoeF2ESHvUbEC/kXEEZfrSlMahG/HdRZCc3Gsc/nnzx4sI6zSD2zLmnZKr8UqtotaytktqatkhAEM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199015)(122000001)(38100700002)(86362001)(38070700005)(31696002)(6506007)(53546011)(316002)(66446008)(5660300002)(186003)(2616005)(8676002)(6512007)(26005)(4326008)(91956017)(64756008)(966005)(76116006)(110136005)(66476007)(54906003)(478600001)(66946007)(6486002)(71200400001)(83380400001)(66556008)(2906002)(8936002)(41300700001)(31686004)(36756003)(43740500002)(45980500001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGdhcEFXUWxJcUhSZ0hYNWlMUnlnbFc5cEhsL21GRThkY3ZCYk1meFA3MjlW?=
 =?utf-8?B?dWlTZmdVRjROR2RPVnZvMDB4TzNoNjZDb09mbHJRYzBvM2ZEbE1IZ2hvU1hi?=
 =?utf-8?B?dGpoNHRIbENrUkoydmRWZDcxUDFRdkluSzI0RHdpaS9McG5XcURNRVFESnl1?=
 =?utf-8?B?TEFoUWFQeE1BTU1EeGM3aHA4TFk5ZkRNRngzVC9TQVJwdUM3ZDB1dUIzdDZ1?=
 =?utf-8?B?QkwzZW1maVJra2xLanJ3TzdhTEZ3TE1YWEs0VTRISzZrNHNyVWJzeGc1bit6?=
 =?utf-8?B?MWNmaTVjQ29zUzZRajBRVEZoMDBoeW81aG83V3ZJZlhna1Q3ZWU4bi9JdVB1?=
 =?utf-8?B?MGNHNVZOdXZBYllsWUV5V2IwZWpjZWJrbDc3cFpCay9GZ01ZOGd4c3pyRHJS?=
 =?utf-8?B?RytOUnROTEl1L0diSkdXaCtyRC9CSnd1Ry9PVVp1ekhORHVoVktla1VucGhK?=
 =?utf-8?B?QmF1dnNkTE9GY2Q2Y2J0bHI4N2VCbjNKR1F2TTVjUDgvbWI2Nlh2S2JNUTVW?=
 =?utf-8?B?MStjc3hxbkk5WjJhZjhBa0ZlVGNIcW5KRFJsVzE0Y01UcThwaWx4V2xHRGFH?=
 =?utf-8?B?emFoenVYV3RieHZoZzJmTy9KamFTU3ZIenZzZ29BMVBnZWIzK2VhVndobnpF?=
 =?utf-8?B?RHFXTGNJTk5vNmdmckh3VVl3NnJ1QnF0dVFlanJ5TUVaNWNHMVBnaE9MSHVT?=
 =?utf-8?B?NHI1SFVTdXFxZWdYM1dyZkx3L2NTejk2TzV3amd4d20ySVR1TkRET3B4TjVt?=
 =?utf-8?B?V1B1YmxVYkFsbE5UanVSYVJJTnFTbXJLN1NPTS90TDVxUW1oSERTS0cya2x4?=
 =?utf-8?B?OVVsQlU5L0l0cy9pOS8vcVJ2NStxc2haNE9UUVhEbExLbWV2Z1FZWGRaUU9U?=
 =?utf-8?B?T1hsbWVyT2dlVjAzRE1abVM5OHBIc1JvOEswK3IzYmx0VEFVek1GRWRjVzBD?=
 =?utf-8?B?U3B1b2ppNndmUDcvOGhqU0NTK0lHb3lpQWpScW9oSjVBNlQ1d0tweXpkdEZR?=
 =?utf-8?B?WlFYOUZhSFpjYWFsZGFCRmR2Rk81RVU3cXZmRVZ1YTF4WHpjdXcwNkRmSFNN?=
 =?utf-8?B?ZmhEN0R6V0dxcVo1bS8rejNicGRPVkMzZFlEbVpwQzJ1NWh0eUdqTmllTXFk?=
 =?utf-8?B?emx5Y3lPYlQ5YjN1LzJ4eTJldDhCczJkVEQyUkNKNmszVFdrU09qSjJLdW5n?=
 =?utf-8?B?QzltOG5WV2hrSHIra1ZCeTlvTUJRRm5CVjVHNzR1SEtOdllIN3RxYkJVc2xy?=
 =?utf-8?B?REorUHpPbE9iYkg1NUZMTW9PNWZGMkl3dWZQNkl3VElGc0pHSWdLQzN0K1l6?=
 =?utf-8?B?dG9DUk90L0JuOE0zc293M2RxRjZ6Zno2UVJBNENZTHg0ZkZwUjhWQ2lEUCt1?=
 =?utf-8?B?dlVCeXpPWDEyeU9NZWxPU3VjbUtxd1c1K0M2NWlpQ2YrVHRDQ0Y1aFFTc2pN?=
 =?utf-8?B?VnZiaHhpTmVQdEwrQ2JWNThLNUtzUHNzcEVPQUFjVUNxMXlndFl5N1A3Tlg2?=
 =?utf-8?B?ME9zSUJ4dWpQMG5iMVVLZzd1dWRYWU5qczRUNGZIWk43QjlYb3JxeklZYTRw?=
 =?utf-8?B?enRzNnJIK2syOGpRWkFnYTQ2WVRBa0pnc1pNWklzaEdsbWRJQk53eFZEZ3Vz?=
 =?utf-8?B?YVFPb095TmpNZlpsd3dVUlgwNG5vUVhkMFRBZTkveThSZE1RQmNGaVVNUmpD?=
 =?utf-8?B?aDRiMFRoU3hxZ0JYN0MyQXk2cmE4bTQ0Q2JxM1hYdmtpemxYWnYzUXIrayt0?=
 =?utf-8?B?SXU3aHhBbUtnYnJqYVVWallKV1RHeHlDc24rOGFJSi81NzlzS05vMndBeG4r?=
 =?utf-8?B?QzN2UGppbVBFTy9iNnFPbDA4S2did0hKcTFtcmEvZWRWdVR0cUs4dDB0ajBq?=
 =?utf-8?B?ampab3lWdFhLYjhDcHJVaTNXVVJ5Z1Zuc055VHRyd1ZoKzQvUWVrZktyMHJo?=
 =?utf-8?B?SUN1NjlKeFMvSE9JSFpKbkh2bW5sOURoSjVaNEhuMTVicU9nTURXcnZLU3M2?=
 =?utf-8?B?ZnIwUVRCbXJIekdNcGUrL2c3WXl3aTBqVXNsbGpCSUlDaVlJQTh0OFNvTWtH?=
 =?utf-8?B?RXh2NHB2RDdHd1JUc2I4SU0xK3FVdUdKai9nYUpwbEx2ZlNGdWJNSDZIZks3?=
 =?utf-8?B?cWgxbWpxUGxTZnV0N2hkYWJNNHdibUdpZEtQajhUTSt0RllYWXZiTlpjMDEv?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5255F966FAE74B4F80A81D95805384F8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176dcbc6-6b74-45a4-04fe-08dacbd1ed92
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 15:06:12.0250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDWqW2HLKwTiV3tn59njDiKeMAsrgJ1RIbtjnwefk7HkBKlcUF8P1FT0L96sfxrCuVR0/6FuL6JknKCZrqMNOivMB1g1QFms1AEHxkwvq8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4718
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMjMvMjIgMDk6MDQsIFRvbWFzIFdpbmtsZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQWRkIHN1cHBvcnQgZm9yIG14NzdsNTEyNTBmIHNw
aS1ub3IgY2hpcHMuDQo+IA0KPiBEYXRhc2hlZXQ6IGh0dHBzOi8vd3d3Lm1hY3Jvbml4LmNvbS9M
aXN0cy9EYXRhc2hlZXQvQXR0YWNobWVudHMvODc2MC9NWDc3TDEyODUwRiwlMjAzViwlMjAxMjhN
YiwlMjB2MS4yLnBkZg0KPiANCj4gQ2M6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWlj
cm9jaGlwLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVG9tYXMgV2lua2xlciA8dG9tYXMud2lua2xl
ckBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9tYWNyb25peC5jIHwg
MyArKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL21hY3Jvbml4LmMgYi9kcml2ZXJzL210ZC9zcGktbm9y
L21hY3Jvbml4LmMNCj4gaW5kZXggZDgxYTRjYjI4MTJiLi5lYzdhYmI2NGUyYmMgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWFjcm9uaXguYw0KPiArKysgYi9kcml2ZXJzL210
ZC9zcGktbm9yL21hY3Jvbml4LmMNCj4gQEAgLTEwMCw2ICsxMDAsOSBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IGZsYXNoX2luZm8gbWFjcm9uaXhfbm9yX3BhcnRzW10gPSB7DQo+ICAgICAgICAgeyAi
bXg2NnUyZzQ1ZyIsICBJTkZPKDB4YzIyNTNjLCAwLCA2NCAqIDEwMjQsIDQwOTYpDQo+ICAgICAg
ICAgICAgICAgICBOT19TRkRQX0ZMQUdTKFNFQ1RfNEsgfCBTUElfTk9SX0RVQUxfUkVBRCB8IFNQ
SV9OT1JfUVVBRF9SRUFEKQ0KPiAgICAgICAgICAgICAgICAgRklYVVBfRkxBR1MoU1BJX05PUl80
Ql9PUENPREVTKSB9LA0KPiArICAgICAgIHsgIm14NzdsNTEyNTBmIiwgSU5GTygweGMyNzUxYSwg
MCwgNjQgKiAxMDI0LCA0MDk2KQ0KPiArICAgICAgICAgICAgICAgTk9fU0ZEUF9GTEFHUyhTRUNU
XzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9SX1FVQURfUkVBRCkNCj4gKyAgICAgICAg
ICAgICAgIEZJWFVQX0ZMQUdTKFNQSV9OT1JfNEJfT1BDT0RFUykgfSwNCj4gIH07DQo+IA0KDQpI
aSENCg0KRG9lcyB0aGlzIGZsYXNoIHN1cHBvcnQgU0ZEUD8gSWYgeWVzLCB5b3Ugc2hvdWxkIHVz
ZSBQQVJTRV9TRkRQIGluc3RlYWQuDQoNCkFsc286DQpXaGVuIHN1Ym1pdHRpbmcgZmxhc2ggdXBk
YXRlcyBvciBuZXcgZmxhc2ggYWRkaXRpb25zLCB3ZSByZXF1aXJlIGNvbnRyaWJ1dG9ycw0KdG8g
ZG8gYSBsaXR0bGUgdGVzdCB1c2luZyBtdGQtdXRpbHMgYW5kIHRvIGR1bXAgdGhlIFNQSSBOT1Ig
c3lzZnMgZW50cmllcy4NCldvdWxkIHlvdSBwbGVhc2UgZG8gdGhhdD8NCg0KSGVyZSdzIHRoZSBz
aW1wbGUgdGVzdDoNCg0KUnVuIHRoZSB0ZXN0X3FzcGkuc2ggc2NyaXB0OiANCiMhL2Jpbi9zaCAN
Cg0KZGQgaWY9L2Rldi91cmFuZG9tIG9mPS4vcXNwaV90ZXN0IGJzPTFNIGNvdW50PTYgDQptdGRf
ZGVidWcgd3JpdGUgL2Rldi9tdGQ1IDAgNjI5MTQ1NiBxc3BpX3Rlc3QgDQptdGRfZGVidWcgZXJh
c2UgL2Rldi9tdGQ1IDAgNjI5MTQ1NiANCm10ZF9kZWJ1ZyByZWFkIC9kZXYvbXRkNSAwIDYyOTE0
NTYgcXNwaV9yZWFkIA0KaGV4ZHVtcCBxc3BpX3JlYWQgDQptdGRfZGVidWcgd3JpdGUgL2Rldi9t
dGQ1IDAgNjI5MTQ1NiBxc3BpX3Rlc3QgDQptdGRfZGVidWcgcmVhZCAvZGV2L210ZDUgMCA2Mjkx
NDU2IHFzcGlfcmVhZCANCnNoYTFzdW0gcXNwaV90ZXN0IHFzcGlfcmVhZCANCg0KVGhlIHR3byBT
SEEtMSBzdW1zIG11c3QgYmUgdGhlIHNhbWUgdG8gcGFzcyB0aGlzIHRlc3QuIA0KDQpIZXJlJ3Mg
YW4gZXhhbXBsZSBvbiBob3cgdG8gZHVtcHMgdGhlIHN5c2ZzIGVudHJpZXM6DQp6eW5xPiBjYXQg
L3N5cy9idXMvc3BpL2RldmljZXMvc3BpMC4wL3NwaS1ub3IvcGFydG5hbWUNCnMyNWhsMDJndA0K
enlucT4gY2F0IC9zeXMvYnVzL3NwaS9kZXZpY2VzL3NwaTAuMC9zcGktbm9yL2plZGVjX2lkDQoz
NDJhMWMwZjAwOTANCnp5bnE+IGNhdCAvc3lzL2J1cy9zcGkvZGV2aWNlcy9zcGkwLjAvc3BpLW5v
ci9tYW51ZmFjdHVyZXINCnNwYW5zaW9uDQp6eW5xPiB4eGQgLXAgL3N5cy9idXMvc3BpL2Rldmlj
ZXMvc3BpMC4wL3NwaS1ub3Ivc2ZkcA0KNTM0NjQ0NTAwODAxMDRmZjAwMDgwMTE0MDAwMTAwZmY4
NDAwMDEwMjUwMDEwMGZmODEwMDAxMThlMDAxDQowMGZmODcwMDAxMWM1ODAxMDBmZjg4MDAwMTA2
YzgwMTAwZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmYNCmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZm
ZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZg0KZmZmZmZmZmZmZmZmZmZmZmZm
ZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmDQpmZmZmZmZmZmZmZmZm
ZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmYNCmZmZmZmZmZm
ZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZg0KZmZm
ZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZm
DQpmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZm
ZmZmZmYNCmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZTcyMGZhZmZmZmZmZmY3ZjQ4
ZWIwODZiMDBmZg0KODhiYmZlZmZmZmZmZmZmZjAwZmZmZmZmNDhlYjBjMjAwMGZmMDBmZjEyZDgy
M2ZhZmY4YjgyZTdmZmVjDQplYzAzMWM2MDhhODU3YTc1Zjc2NjgwNWM4Y2Q2ZGRmZmY5MzhjMGEx
MDAwMDAwMDAwMDAwYmMwMDAwMDANCjAwMDBmN2Y1ZmZmZjdiOTIwZmZlMjFmZmZmZGMwMDAwODAw
MDAwMDAwMDAwYzBmZmMzZmJjOGZmZTNmYg0KMDA2NTAwOTAwNjY1MDBiMTAwNjUwMDk2MDA2NTAw
OTU3MTY1MDNkMDcxNjUwM2QwMDAwMDAwMDBiMDJlDQowMDAwODhhNDg5YWE3MTY1MDM5NjcxNjUw
Mzk2MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDANCjAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDcxNjUwNWQ1NzE2NQ0KMDVkNTAwMDBhMDE1MDAw
MDgwMDgwMDAwMDAwODAwMDA4MDEwMDAwMDAwMTAwMDAwODAxODAwMDAwMDE4DQpmYzY1ZmYwODA0
MDA4MDAwZmM2NWZmMDQwMjAwODAwMGZjNjVmZjA4MDQwMDgwMDhmZDY1ZmYwNDAyMDANCjgwMDhm
ZTAyMDJmZmYxZmYwMTAwZjhmZjAxMDBmOGZmZmIwZmZlMDkwMmZmZjhmZmZiMGZmOGZmMDEwMA0K
ZjFmZjAxMDBmZTAxMDRmZmYxZmYwMTAwZjhmZjAxMDBmOGZmZjcwZmY4ZmYwMTAwZjFmZjAxMDBm
ZjBhDQowMGZmZjhmZmZmMGYNCnp5bnE+IG1kNXN1bSAvc3lzL2J1cy9zcGkvZGV2aWNlcy9zcGkw
LjAvc3BpLW5vci9zZmRwDQo4NmFlZjI1NGJjZmRmNzYzYmRiOTJlNGMzMTY2NzI0MiAgL3N5cy9i
dXMvc3BpL2RldmljZXMvc3BpMC4wL3NwaS1ub3Ivc2ZkcA0KDQpUaGFua3MhDQoNCi0tIA0KQ2hl
ZXJzLA0KdGENCg0K
