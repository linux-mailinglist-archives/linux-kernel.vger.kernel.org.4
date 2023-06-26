Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E8173D72E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 07:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjFZFcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 01:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjFZFcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 01:32:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8F7116;
        Sun, 25 Jun 2023 22:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687757553; x=1719293553;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i+Z0930QMYx1AIfFCLnYb1Q4Vz//+myiMyG9zKckmD8=;
  b=SmfITqfXRWHaQo5Yp+FrJHk3cV+ZSRaxOri5b/VN3aLKHoA6txjSSMsu
   xt+tLqKJKkR7F/tDYvWDAotxZBJdvQ8wxZf+mrploXMseFPvBiCYos8dd
   MatNjwSS/Jwf2GBkzSwRZ3O2e832mK/l5SQ7XASrF6x082hLSE+xLmUSm
   vvnM4qKc369xFTud30+gn4cQLlzBMX9PfMWc+PJkaHPk7u+f6fRJulNWa
   njdXUiTt5gsnDe3sXp/OWuodnJloTaOzcpysMSYAt/PqHrz0M3q/xCl9N
   MOw3gyXopB+tcHziFgeE70DJL7DU4V5IM5tVsdIEcOUKw0Wb/EIlCEOdd
   g==;
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="158579855"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jun 2023 22:32:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 25 Jun 2023 22:32:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Sun, 25 Jun 2023 22:32:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PopAZcjYJMD5Eclp4kLiL3bzNb+xs5NR4epFqFryFvmALbyUNooxOgo3Aq0FJw5ocIL2EzzEu8KDTDKKaNXDrsj3SpBvhDw1OPDFLXoQ3TJ35pIshNBJO3lgcUYOGj7dwVPnZilKtaIul5WPXwkR/FwiGL3VC0b9hQ5PXOcLBp8y0zTtDyuVxRhridfwDQLcn3J4ZAVlTal9/hZ74DyjNxc1HOziRiyrTa1GRBn7SG8qkROxX163rtibvXUehAqdGxGn8CzJPj9yqIxRMwv3UJX+U9Q14DehZlFQHyBHinEZutN2kP5tBRBQRE90qGAuwSgRm9P6w1NBTBlkYlrDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+Z0930QMYx1AIfFCLnYb1Q4Vz//+myiMyG9zKckmD8=;
 b=BPD1XE5ywt7Y08Aa4pfGZ++ca7b7kovBom3guwWarJBK6IGUeBbncDv0X57tlJTJ+R8cWkM24y8wjAaQjEVul23cOBVarf4CCHQocZ1vZzuAfI2LMGYulqKLK8BBDTzPGCA/4GE+Af9IgaOQejrD1JeZzSBOJHYwayz9xkBLhvfOeVBLTlhO2DBq2KVhx53lLS9v5RRbnacpFMOTioZGmzjVUxz/uWnm/bIV17z9W2KeL3a55nCDScL5LNO+ZGwFbnCX3dL6niTla5yScV700kCG06B9hlrxR0w3RGiVNuoI71fSQWCZ5ZGUrHqErew5eBLLJ1SwyPx9NXEeKRT07A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+Z0930QMYx1AIfFCLnYb1Q4Vz//+myiMyG9zKckmD8=;
 b=XGx6uTWTK8m8jINhGcYMiB0VgNeoCFbCIY+G3owVf/ln/h5URJiBorMOznCoHeZQ3cacmdnaewhhncaAiYWzHKyjnuA8fvatHuzO00ssJRnY/M8cfTRTDNtBcbdDXAXVYcgRFoY1BSXVwDnONBLC7inX4iIJLSX0QZneJyqGrn0=
Received: from IA1PR11MB6193.namprd11.prod.outlook.com (2603:10b6:208:3eb::19)
 by MW4PR11MB6983.namprd11.prod.outlook.com (2603:10b6:303:226::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 05:31:59 +0000
Received: from IA1PR11MB6193.namprd11.prod.outlook.com
 ([fe80::fae1:9490:ead6:1009]) by IA1PR11MB6193.namprd11.prod.outlook.com
 ([fe80::fae1:9490:ead6:1009%4]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 05:31:59 +0000
From:   <Manikandan.M@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <conor@kernel.org>,
        <krzysztof.kozlowski@linaro.org>
CC:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <sam@ravnborg.org>, <bbrezillon@kernel.org>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Durai.ManickamKR@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
        <Dharma.B@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Balakrishnan.S@microchip.com>
Subject: Re: [PATCH 1/9] dt-bindings: mfd: Add bindings for SAM9X7 LCD
 controller
Thread-Topic: [PATCH 1/9] dt-bindings: mfd: Add bindings for SAM9X7 LCD
 controller
Thread-Index: AQHZncV3ordx/PO3iU6nscrl1YKhkq+JCwKAgAABLICAAVS0AIACn6iAgAftQoCAB7WzAA==
Date:   Mon, 26 Jun 2023 05:31:59 +0000
Message-ID: <1252fa40-dd8e-73f3-18b7-7010a7f8085e@microchip.com>
References: <20230613070426.467389-1-manikandan.m@microchip.com>
 <20230613070426.467389-2-manikandan.m@microchip.com>
 <a0b059d1-df4d-10ce-fb7c-7acea0a20793@linaro.org>
 <20230613-slider-coherent-d508d67afc91@spud>
 <423eef3c-54f0-5c88-9bc9-82c0198b6da6@microchip.com>
 <3a3f4463-981a-e8d8-8ec4-06f2abfa3b4d@microchip.com>
 <ef09246c-9220-4c71-4ac2-2792d9ca519d@microchip.com>
In-Reply-To: <ef09246c-9220-4c71-4ac2-2792d9ca519d@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6193:EE_|MW4PR11MB6983:EE_
x-ms-office365-filtering-correlation-id: ca8e5b68-a204-4ad4-17db-08db7606a9fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fJRp+bnlgnRxG7hWmRT2d1PA87IwlTaaoavRlY5X2HAsYMlQmJkdQeux3bebMYQaznpJkUdZ5mA6vOMcQ+JRIBb6fQNFLkeerwLyY2ZK26Zxb9CYekGcwIcwMmquuu/5X6/mUz/GmdwVlJ8+nfjrGyEaVxaGB2OV+n7dG23dzIjIc1IBGAP5EUJt3EZttgkGFs2//B1wBkTjEs/9Rj2vVadAADbUhyXJRrqucS0WWtwMl70rgbvlfdWVR0UQjp7jxvnjgt0JOmS2v8TZ3GZ9FSZq5VagFOjvq8ssVEdRXgIB4adlMrUQ9cxvq0zIUj9H9uRsw/GCvfD3e5Fmr5tsGbezfT/NbqNzWAbm1GuaRU0aVKO6qFKV3RdX7WR+nxh09ZS8Bmx7h6e/WoTcUfA56im/KE+zd2ygmNaUVcz8luQG2yA7WCtJhoqvd4gBILpSXwYMjzsYqs9e0QE3RPXfHkvCS/B2cHjQ0/mxppnADi4rG7FOD2bK7aoZcXdH1FqmjIjfaUgapHdOHwIJEpcRsv1HceF8D9y/uSJd+3bLNAbLL7wvOmGL81mjbse3rn5aWlrZ14WuyRENaDlYCh5CfhdvYkNKBv12ndd6Mcyuf5juYM7ufsjrU/qCHCA5PFRULsvat5eP97gPCDy9yEgow4aDhr0YOp1clUgwf6wyLG4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6193.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199021)(966005)(107886003)(478600001)(6486002)(54906003)(71200400001)(2616005)(110136005)(83380400001)(26005)(6506007)(53546011)(186003)(66446008)(2906002)(5660300002)(7416002)(36756003)(38100700002)(122000001)(76116006)(91956017)(4326008)(66946007)(316002)(31696002)(86362001)(8936002)(8676002)(41300700001)(38070700005)(66476007)(64756008)(66556008)(31686004)(6512007)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDZtbVFoaE1YT2NwVXV2cVdyamgrSUc0RWVETWxXSlBxYWtjNVdRR0cxTXBF?=
 =?utf-8?B?QlZNWFk1ekdGVUpGOVk0UHFodk9zK3pWR0JOdjAyeXdNY04wSWhFUjVjNkJK?=
 =?utf-8?B?VkR2VVdmZnZObVMyS3JzNmFBWXVyckF0eXRaMUtZQytaNndBK0dMdSt0VDFB?=
 =?utf-8?B?WkF2cTVNc3NGMHp1UlRXODg2a24yNXlDd3FaWnNCNkgxNzFOV3R2ZXVFdkpW?=
 =?utf-8?B?a3NJNHVFQzBVejBGU1pOdW1obStrZDU5ODdSOGtvc0hNU1Bnak9Gb0c1OTlQ?=
 =?utf-8?B?eDBVSmRZWDFkUW9KbzdvKzQ5WmJjNG9IVGQyRi9YSWFCODd5aEgvRmVIa25U?=
 =?utf-8?B?OEJCbnNFeTJxMnBHaGNOTUFMK0lDR3FYeUtnN2dvckZ2QmVlRUJLSTFMWWVv?=
 =?utf-8?B?Qmo4TW5zMy9jYWxuUGJXQm9CeG1FU3I0VlFaRnJkTUVwQkRBeDBVaGgyMFN5?=
 =?utf-8?B?NHlESWQreGdiT0ZXa3Y5M2NMMEtJTDVKNmZ5OHJXK2QyeVhZMUUzNkIyTElq?=
 =?utf-8?B?WXB3M3FnWjNQblA2Z1U4ZXZaM0o3WjUzYmFiR0dpL2JEV0NtaExSTjVLUHNC?=
 =?utf-8?B?cVNzQ205ZmU2bWJVeFh4WTV0N3NOMTVmTHJlZ25KTDVNZWQ1d1A4SmFjaVFh?=
 =?utf-8?B?TlZsVUlvUGs2TXVsL3BkQ2EzcW9mRnNrRUxjbzFkTFBrQzc4NmhzVHNGYmJR?=
 =?utf-8?B?VnFiVm9xRldYSmFuNHQ5UEZRWWlFVXJyVmJuVjQ3NVBrNHB5bmhSSDl3cVlk?=
 =?utf-8?B?c0hQNVpsdUhIL3VpRERjMGtxSlBJUGhpRlgybmhHQjhERjJ4ZmdSNkk5ZEp5?=
 =?utf-8?B?R0FMUUVqazVCWCs3R3dIZ1dwUjVlNXA0UUJhVm9ySG0rZTVaZ25yMWxGWEJj?=
 =?utf-8?B?b0huZXJ0Qlp5aG1TMjlBMEdGVDhFZXJTZkNTb015WkhLQm1yaTl4SW42bzBj?=
 =?utf-8?B?bkZpbTFKNFJNdHhWdVFzNEpRcUVkOVhra1JoRGFNbHZuNWNJNkoySkovQ3E2?=
 =?utf-8?B?c21XWURiV1RMdEdscjdUci9mWmw5VG42MjZiWUU4L0dxSWxtaFNhT2tnRnBD?=
 =?utf-8?B?UlA0ditzTG4xVGlOdGxyck1kRlcxUG9xUHNwb2dtak8wYW52V2F4VFJROGF0?=
 =?utf-8?B?TGVDWU9oZHpBTFppRitxaHNaOVNKQkpCQWZUY041WGtWd3VWUEN5Smo5QzJi?=
 =?utf-8?B?MVF3MEpFUFZqWGEvVXRrQjdtTysyWHp1ckxyTWlVZmxqak1RZmg3VkVXNWZI?=
 =?utf-8?B?cUVVQWY2ekU3ZzNDTURNVU1QdFdFcjI3eWFiT1pvM29kWmdqdXZsQTdQR0F5?=
 =?utf-8?B?d3E2MFA3bTF1ZG9FLzFiYUNQRENxL2NVNTNVNXQvekF6dUdtK3dab1lZU0VL?=
 =?utf-8?B?UkdkcTlRa00rQzlGdjlhN2tvbStxTEpSU2ExNmxuWG4rbkdUckRneWkxQjNU?=
 =?utf-8?B?SktFaVA2NTM5VlZGditZc2ZOSXlQOEU4c1VPbW92Y2VRWm55SFMzL0VwczUr?=
 =?utf-8?B?aVBmcjFONkM2aElqZldyYktuMjBiQXlEb2tuL052V3NrRFoyT2pEQkJCb05U?=
 =?utf-8?B?K04vcHBPZDRqWFh6dTlybUlpdlN6YWExemlhTTF0NHhuaVZieFpOZnRTbFI4?=
 =?utf-8?B?YUdqZmNkVll4TnhkYXRNd2RpS1RJc1ZuMzc0aGpOZUU2Y3ZuNHQ3STF4Qmw0?=
 =?utf-8?B?aDQvOVJKWm1sVk4vZkpIcjVKK1lqejNmbDVQL2FDV1RnQklvNUQ2Tjl5S0Nn?=
 =?utf-8?B?djVBbkJNRERPTWZCVTI5Wldqek9oK1lWRTJNYUV6azRNMi8zSFc0aklsMUtK?=
 =?utf-8?B?TTdiL1VoaTlmV2ZJQlNPTGJrZFhxRW5ReE1KQXFVVkl1TmdETzJzRjJuQXB0?=
 =?utf-8?B?cXE2eUNHbHNURXEycUV0dkVvZWJlN3dkMkFvUm1zQWhKdGhVaDhPbkRoTUdR?=
 =?utf-8?B?aS9lRmVaT0thUmttS3ZsbUFUV3FUajlRK1hWa29DbVdsQTgvV3gxQmFwaVJQ?=
 =?utf-8?B?L0xCbHJnbnh0QnBCa0ZpNkt6Nk0rcWxnc095dVRDbndTQzd2SDJBZE5wcmVN?=
 =?utf-8?B?dTRpSDlMbWh1b0ltOWZwQTF2S2lnYjlTZVNxTmRRVEI3YVBqeC9hZU5VUUcv?=
 =?utf-8?Q?ShaRB/FZVbQmOJUOcF15whuUm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <571706867A2A7848AB4D3D2A7C094FDD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6193.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8e5b68-a204-4ad4-17db-08db7606a9fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 05:31:59.6586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0VcxScAuylOO2Ymg6iwXuM83buJPTdxDKdeX9ZmVNfF1YwEmMRjmp/awBKrAijGCEw+3FujybCArNdG0ZHW04N2woI8MWeVl6ZumuW/GOIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6983
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjEvMDYvMjMgMTM6MTcsIE5pY29sYXMgRmVycmUgd3JvdGU6DQo+IE9uIDE2LzA2LzIwMjMg
YXQgMDg6NDQsIE1hbmlrYW5kYW4gTSAtIEk2NzEzMSB3cm90ZToNCj4+IE9uIDE0LzA2LzIzIDIw
OjEwLCBOaWNvbGFzIEZlcnJlIHdyb3RlOg0KPj4+IE9uIDEzLzA2LzIwMjMgYXQgMjA6MjEsIENv
bm9yIERvb2xleSB3cm90ZToNCj4+Pj4gT24gVHVlLCBKdW4gMTMsIDIwMjMgYXQgMDg6MTc6MTNQ
TSArMDIwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+Pj4+IE9uIDEzLzA2LzIwMjMg
MDk6MDQsIE1hbmlrYW5kYW4gTXVyYWxpZGhhcmFuIHdyb3RlOg0KPj4+Pj4+IEFkZCBuZXcgY29t
cGF0aWJsZSBzdHJpbmcgZm9yIHRoZSBYTENEIGNvbnRyb2xsZXIgb24gU0FNOVg3IFNvQy4NCj4+
Pj4+Pg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IE1hbmlrYW5kYW4gTXVyYWxpZGhhcmFuPG1hbmlr
YW5kYW4ubUBtaWNyb2NoaXAuY29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+IMKgwqAgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbC1obGNkYy50eHQgfCAxICsNCj4+Pj4+
PiDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPj4+Pj4+DQo+Pj4+Pj4gZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwtaGxj
ZGMudHh0DQo+Pj4+Pj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0
bWVsLWhsY2RjLnR4dA0KPj4+Pj4+IGluZGV4IDVmODg4MGNjNzU3ZS4uN2M3N2I2YmY0YWRiIDEw
MDY0NA0KPj4+Pj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQv
YXRtZWwtaGxjZGMudHh0DQo+Pj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21mZC9hdG1lbC1obGNkYy50eHQNCj4+Pj4+PiBAQCAtOCw2ICs4LDcgQEAgUmVxdWly
ZWQgcHJvcGVydGllczoNCj4+Pj4+PiDCoMKgwqDCoMKgICJhdG1lbCxzYW1hNWQzLWhsY2RjIg0K
Pj4+Pj4+IMKgwqDCoMKgwqAgImF0bWVsLHNhbWE1ZDQtaGxjZGMiDQo+Pj4+Pj4gwqDCoMKgwqDC
oCAibWljcm9jaGlwLHNhbTl4NjAtaGxjZGMiDQo+Pj4+Pj4gK8KgwqAgIm1pY3JvY2hpcCxzYW05
eDcteGxjZGMiDQo+Pj4+PiBHb29nbGUgc2F5cyBzYW05eDcgaXMgYSBzZXJpZXMsIG5vdCBhIFNv
Qy4gUGxlYXNlIGFkZCBjb21wYXRpYmxlcyBmb3INCj4+Pj4+IHNwZWNpZmljIFNvQ3MsIG5vdCBm
b3Igc2VyaWVzLg0KPj4+PiBXZSBoYWQgdGhpcyBvbmUgYSBmZXcgd2Vla3MgYWdvLCBzZWUNCj4+
Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2FkZDVlNDllLTg0MTYtYmE5Zi04MTlhLWRh
OTQ0OTM4YzA1ZkBtaWNyb2NoaXAuY29tLw0KPj4+PiBhbmQgaXRzIHBhcmVudHMuIE91dGNvbWUg
b2YgdGhhdCBzZWVtZWQgdG8gYmUgdGhhdCB1c2luZyAic2FtOXg3IiB3YXMNCj4+Pj4gZmluZS4N
Cj4+Pg0KPj4+IEFuZCBpdCdzIHdoZXJlIGl0IGJlZ2lucyB0byBiZSBmdW5ueSwgYXMgdGhlIExD
RCBpcyBwcmVjaXNlbHkgb25lIGFzcGVjdA0KPj4+IHdoZXJlIHdlIGRpZmZlcmVudGlhdGUgYmV0
d2VlbiBzYW05eDc1LCBzYW05eDcyIGFuZCBzYW05eDcwLi4uDQo+Pj4gU28gcGxlYXNlIE1hbmlr
YW5kYW4gc29ydCB0aGlzIG91dCBpZiBkaWZmZXJlbmNlIGJldHdlZW4gdGhlc2UgY2hpcHMNCj4+
PiB3aWxsIGJlIGJldHRlciBoYW5kbGVkIHdpdGggZGlmZmVyZW50IGNvbXBhdGliaWxpdHkgc3Ry
aW5nLCBpbg0KPj4+IHBhcnRpY3VsYXIgYWJvdXQgLy8sIExWRFMgYW5kIE1JUEktRFNJIHZhcmlh
bnRzIQ0KPj4gWWVzIFN1cmUsIEkgd2lsbCByZXBsYWNlIHRoZSBjb21wYXRpYmxlIGFzIHMvc2Ft
OXg3L3NhbTl4NzUvZyB0byBoYW5kbGUNCj4+IHRoZSBkaWZmZXJlbnQgdmFyaWFudHMgb2Ygc2Ft
OXg3IGJldHRlci4NCj4gDQo+IE1vdmluZyB0byBzYW05eDc1IGlzIHByb2JhYmx5IGdvb2QuIEJ1
dCB3aGF0IGlzIHlvdXIgcGxhbiBmb3IgDQo+IGRpZmZlcmVudGlhdGluZyBwYXJhbGxlbCBhbmQg
TFZEUyAob24gc2FtOXg3MikgYW5kIHByZWNpc2VseSB0aGlzIA0KPiBzYW05eDc1IHZhcmlhbnQg
d2hpY2ggaW4gYWRkaXRpb24gaGFzIE1JUEktRFNJPw0KSW4gc2FtOXg3NSB3aXRoIHN1cHBvcnQg
Zm9yIExWRFMgYW5kIE1JUEksIFBhcmFsbGVsIGludGVyZmFjaW5nIA0KcGVyaXBoZXJhbHMsIHRo
ZSBhZGRpdGlvbnMgcGVyZm9ybWVkIG9uIHRoZSBMQ0QgY29udHJvbGxlciBkcml2ZXIgaXMgdGhl
IA0Kc2FtZS5Db25zaWRlcmluZyB0aGUgTENEQyBJUCB1c2VkIGluIHNhbTl4NzUsIHRoZXJlIGFy
ZSBubyByZWdpc3RlcnMgDQpzZXRzIHRoYXQgbmVlZHMgbW9kaWZpY2F0aW9uIHBlciBjb25uZWN0
aW5nIHBlcmlwaGVyYWwgdmFyaWFudHMsIG9ubHkgDQp0aGUgY2xvY2sgYW5kIERSTV9FTkNPREVS
X01PREVfWFhYIChzZXQgYnkgY29ubmVjdGluZyBwZXJpcGhlcmFsIGRyaXZlcikgDQpkaWZmZXJz
LCB3aGljaCBjYW4gYmUgaGFuZGxlZCBpbiBEVCwgYXRtZWwtbGNkYyBNRkQgZHJpdmVyIGFuZCAN
CnBlcmlwaGVyYWwgZHJpdmVyLg0KDQpJbiBmdXR1cmUsIHNhbTl4NzIgd2l0aCBYTENEIGNvbnRy
b2xsZXIgY2FuIGJlIGRpZmZlcmVudGlhdGVkIHdpdGggDQpzYW05eDcyIGNvbXBhdGlibGUgc3Ry
aW5nIGFuZCB3aXRoIGEgSVAgdmVyc2lvbiBmbGFnKGlzX3hsY2RjX3YyKSBpbiBpdHMgDQpkcml2
ZXIgZGF0YSBpZiBhbiB1cGdyYWRlZCBYTENEIElQIGlzIHVzZWQgd2l0aCBkaWZmZXJlbmNlIGlu
IGJpdHMgb3IgDQpyZWdpc3RlciBzZXQgZXhpc3QgY29tcGFyZWQgdG8gY3VycmVudCBJUC4NCj4g
DQo+IFJlZ2FyZHMsDQo+ICDCoE5pY29sYXMNCj4gDQo+IA0KDQotLSANClRoYW5rcyBhbmQgUmVn
YXJkcywNCk1hbmlrYW5kYW4gTS4NCg0K
