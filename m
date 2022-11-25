Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC75638B99
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiKYNwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKYNw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:52:28 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923A03D909;
        Fri, 25 Nov 2022 05:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669384344; x=1700920344;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk+rT4W/F8lm5HD027aOBWIYzeYRNrDQaGusNjhNMGU=;
  b=sz+vKXv5euaZFavItM/dA+oQ2EFyS5jimfGzbu0sLSpwgj/qs20OdIom
   5w02jNCta7ELaZNprCpAMXVO67bxIN88OD5j49pmXzkA291o1zx5K/0on
   t/K9QVYK4wjwlaxtH/HgT0J4sdrsiPTnOgoiec/YSsHKyzMGy+pKwlBKd
   kH5FVKL2JXNGIcljozMobyqC3sIFDNF2PtrhKnk9+NPj5ZLg1Q0UnpySF
   vHj/Kgx9h3KqmwzpN+cd9KJRMOd/PEk3WELDcqG2L0We9fERRkFGaZ6ZW
   gsf+tn46p0vlrBUTpe11BVy9239M65ScD0PVpNGE5fvteiLZvk4jaxZVB
   g==;
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="188668188"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2022 06:52:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 25 Nov 2022 06:52:23 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 25 Nov 2022 06:52:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLmSBjSlfk0w6Ya2EQR7cx6Blmt+9DJZfn1iZBjDsZ1v2L6zQ1fA+kzgKj4vL3s4EmMpbNFpjEuwCPxeLrWqTJWoRJgKw7XkBzzAp20QVc/nyaM0MEU4a87qHhTUy3SZGo/Xgc5K8MUQDycRGbkR350y/j+0MZrMyHl8wwDLJJ60BvPfQ00GA1AcSgzr2F/zRH+vTl77ODiJhDn9UpG8fMNqH9VyosgsTTEpI16zgdl2nWFLMZUv6mD/WTEis17AnvHnIobcO3hN/OD/QMG83XinU5uL1uSUp7Sfq4RVQeZcj3aG0J8JifI51y7pLh6q7xYKibzHpneQU/lfdBnx/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk+rT4W/F8lm5HD027aOBWIYzeYRNrDQaGusNjhNMGU=;
 b=gTjRPfR4IPSM37XKwSh5d8myAeeZ/T3hase137jO3dkqkZIIsB/dw/tTaEOpKZiXbOn5utBjCkEZfhSnPx7RJA5IkTbaz+26BvynLIjdC+0wD/yLS9o2+6oIj7agsfVzi5qUKK/+8TNW31dW9mVmxO9zkAuOVkpa0Re80r2pxazuy7CRZU69EULE24X82n//JY1HAO4bpXOfqDYjotO8h0oetywdILuAPqXwG8y/LSSyrxj0G6YEcIgfG4xtAultHiHOPyacpe/fCOs4KRyUzkO9xGAnSYC0IiazsfFBhWINazQFejCbtJtTuvS53lYrvK/Q5vRpXK1xa8YasQcSPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk+rT4W/F8lm5HD027aOBWIYzeYRNrDQaGusNjhNMGU=;
 b=W7l8g/GyXD3yC0gfM5m4woLf+2zJm3V3oC2oXAkdIOrViEPW5llDDU2bzsBbwxD2OT7gNbIJ0PpaiqzbON6I56+nOFGkOIcgVZnpMzyCsEnjG4df6pBdsYdj3VJhm2VOu+rh2++b+RH/8QfwHHGSbBQ/GLJ7HsXm61M03Elswr8=
Received: from BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14)
 by DM4PR11MB7256.namprd11.prod.outlook.com (2603:10b6:8:10c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Fri, 25 Nov
 2022 13:52:21 +0000
Received: from BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::97da:d0be:a66e:eb43]) by BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::97da:d0be:a66e:eb43%6]) with mapi id 15.20.5857.018; Fri, 25 Nov 2022
 13:52:21 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <Claudiu.Beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] ARM: configs: sama5/7: switch to new MICROCHIP_ISC
 driver
Thread-Topic: [PATCH v2 1/2] ARM: configs: sama5/7: switch to new
 MICROCHIP_ISC driver
Thread-Index: AQHZAM7Lsa5d3ya6PUi8JI1LXD3jKa5Pp0GAgAABaIA=
Date:   Fri, 25 Nov 2022 13:52:21 +0000
Message-ID: <5c93892b-4d04-3b55-72ec-36d3519d543b@microchip.com>
References: <20221125130646.454084-1-eugen.hristev@microchip.com>
 <aa27b328-5167-408c-7731-080aa3a4ebb5@microchip.com>
In-Reply-To: <aa27b328-5167-408c-7731-080aa3a4ebb5@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5384:EE_|DM4PR11MB7256:EE_
x-ms-office365-filtering-correlation-id: 5d40feac-2e92-42cb-c0c3-08daceec4682
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f8LPYgYLypqaddevbnJtp2kwrLDq1SXB1w+pwL/JGuGbb9QmqB9Jd/X3gvwXFfezykm/Cfy9GJWLx+odKZ+RTpAzwOC1w1/zCzHV2H3kpNWgnpD/JbcZHCWJIixCZUrt5ow4aODeR8XwssVrpRB7+h6rQPtFHvdUVSgC/5z9Iayi8/O9GOL7Mo7OBd2FaH/wVPLtOqF3FUf/JJSL9JpaLXU7Pt7uIo0po2PKhDYXlB8ae5TzjceUG7VAifywWkhqFmHktXEpci4Vsj1vqmNLaUV2Kq+XAXRAE3Dr31KMUh0t7aqTpUdvweassdCwY+obgxhOx3r+7lah49p8isrF2kPOFQkezZvSSNzZdp2ggcfFMGxvhq0KSH6wWKVDggM8etNkVdv0LckYoWNqaAdiU8hBUq48FZFhYsKxP6DAT22rGZ6XWVI19KqrZg668SgWbrkAq4WnzXNxeqO0uEmEt7FzD8jyurHyApFWyhRl0FrxA3BPF/WJ8jJOfuu8DaBA0GVqiGiA4oHGidW9wqL8Opv6T9H6l2PGUp9/9W230mxJslVOv/3KGDhA/OqXh0U3P6QgIWG1gkd3y/qmIB0PtWozL9eeYvEqMsjbouLMMxw9mlArzCeUlcet+sSIMOWpTSqjGQr2duUuKg1X10bDf2H8GsxZS0jGNHoUj3SpvOQm4QWJRMyRV0Itov5/BYjhp+nlAJKKOEmo96dVy1kX6JsbD/Bf8oVSGWlcP89bVC05yYoS+qptb4Q3EAqCa/E6uwnA8Z8nTguGueBd55LksQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199015)(66446008)(66476007)(76116006)(66556008)(66946007)(91956017)(64756008)(6862004)(36756003)(8936002)(41300700001)(8676002)(4326008)(5660300002)(86362001)(31696002)(71200400001)(6506007)(122000001)(53546011)(26005)(6512007)(83380400001)(2616005)(186003)(54906003)(37006003)(38100700002)(38070700005)(316002)(6636002)(6486002)(478600001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czV3djZibXRSTmJpd0Q5U3RnTytSK3ArUVJhRTkxU2QzWUFUYVAxSXVEREU0?=
 =?utf-8?B?VUFuSWlrT0RBeFlsSk5FZDErMDRabVloRXRxNUlvRjYxZ2I5Sm92cEF6OWxT?=
 =?utf-8?B?YTBoVTdhbzN1YnhtK2pGV3JLeklpTmUxbitRZmlPU1BnSmg1L3JIaE1ycU5k?=
 =?utf-8?B?TkFkU2Y3SU1iakFnUTIrTkRQZjVnNkhXUkFSekdCWEtLOXpRMFB3UWV0Qytu?=
 =?utf-8?B?MmtONlUxK05CK3NreTlaclJzUlkxWTZhNVFJcE10QXVDMjFEdGRLZElBMnU0?=
 =?utf-8?B?Q1JQNHc5OTlZVE9jZEgvVTFqUFFxRkJkZkl1M0x4dkYyckgzOWx4UGNQQnhZ?=
 =?utf-8?B?Z1dPQUl3T09JUTZvWjc4V1lrZEpmY2xDK0JLMG9ZTjlVdS9aTUQ5dFFBY0h6?=
 =?utf-8?B?YjNrUW4yOGFGTGZ5dEV5blhrTjgrRWtNMHo5NTBRS1QzQ0k5NXdadFF3Uitp?=
 =?utf-8?B?ZUg0ZWFVMUlKK0JndDVnLy9QK2JMTS85c2htSE55ZnQxeFpKYktKMExZbEFu?=
 =?utf-8?B?aUFwaERvUDRmWkNkYVhqbU1QSERhY096cU1Nc1BjZXR3NFZoNytZSXlRTWhP?=
 =?utf-8?B?QVZhVTVpNG9ZbkR1UXNlU2dpMVZadXFnZEhIaCszdmhFaUkzQlhMbjhXYWUx?=
 =?utf-8?B?eVRKSmFqdU56R2FTN3EreVp3bXNSVDVKSmtqRlpHWDlmc3VpWDA1Q0l4Q0Vq?=
 =?utf-8?B?N2VUNWNhVStpczFPRGRwNnRsVCtvWVI3UlZtWkJwSzh5WUpUZloyZ3kzZ2kz?=
 =?utf-8?B?eFZNVEFCcXgyZEEybElld29OVjNjZ3JTK0NLYzR4Q1ZSZ2Zid0ZFQzNZd1Na?=
 =?utf-8?B?N2FjTGp1NytvQjNMUUdkWHQxV01nUlhCKzRJSDlzL3BDVi9sUzJybjAzSVZn?=
 =?utf-8?B?QVhhN05Obkp2Vi9wVmlJMDcwNjhEL01RUFFqancyNlMvRFN5Zm53VWFrVnhQ?=
 =?utf-8?B?bnByeHBWU3Nad0VwODZGMURMejRyVTkyamJ4Tjc1cWNCUTNCOC9PTUNiR3Z2?=
 =?utf-8?B?amZ4SEZqbUxVakNOeHp5RzBBQ052Tm42eXN0dm5LbGQzdm0zYU81MURtQkFy?=
 =?utf-8?B?S0pZZEhVTkhxSnlTMzI2ZTRaOU1KaWlKVmpqOGJuS3FsbTdmeldkYnlYeXRl?=
 =?utf-8?B?TnNScFozS0lvT1hIVytGNjEzR0lyWHZEc2hXaHlUZkdrWUN0TXpwQWdJcHR1?=
 =?utf-8?B?RXA0OUZuU0JQOHo2YSszYmhBaWt3cXZBdnAzdHhZR2xyZkIwT01DSTJhVFg4?=
 =?utf-8?B?aUxMOVdKU09ObnVIM1BZeEV3Z04rWElybVorSU9YREI1cDVaOEdXS2JDR3g5?=
 =?utf-8?B?VkZZSGdvcmZpSjB5UU5XR1Z1SHJ6UGllb3o5UllrOE9uaFZhOFdsQndGWVM2?=
 =?utf-8?B?Z2NnTXExTXJWSHYvbElZejZRUitWWUVKUlhKM1cwOHpIOUQwdmRXVUt3VTFR?=
 =?utf-8?B?UkNuY2x3T3d0MEdSNGdmRzVPYksrVWJHRzJFVDhhV01uck5nYWMvQ3U3T2Fy?=
 =?utf-8?B?WmxuZHl1MVBlbmRuTmNvcHk3WFNlL2hVOWh5amVUYnJRZVJQZFVtci93WUg1?=
 =?utf-8?B?d2lzdjUzSnUxZDQ1UjZCSzNOQXBHRGJiTFRvQXV1QjBSNC9BcmdrbnBON1A1?=
 =?utf-8?B?N1djWUxEQUpyYU4xWVRnNitGbllycTEvVmNyYXY1dTR6STFkU25mMmd2VExS?=
 =?utf-8?B?aE1wQ0tjM3A5b3V5elJ0TVlpU2Rtcy9FbFhKQ1pCWEc2aThHaVNrWitEbnRS?=
 =?utf-8?B?ZTBTNVJwOXlaQXpqQ3hBa211eHU3VnZqNnVDcWI0WXlMODFldTdjb0lZcHlu?=
 =?utf-8?B?c3BadkFJZHNRZnpFaE53Y0Z2bHZlWHNMMzJrVXBTWDRJWnpwOGZiWEJXZjZJ?=
 =?utf-8?B?QXUrZUV2RHlMdThZNDhFcUZZL2cvSjVZSlBNc1N0ZXVnL0pENEJ4RkdGajlj?=
 =?utf-8?B?M0hyZGtxNFEwYWcyYTZLcm5obGJuN2RSRnN4cUI3aXN5aSs1MnlGR1lVbHpQ?=
 =?utf-8?B?S2YwU09haWMyYk5QdDgwdXYzMWd5VjNiVWJGc3dJTHhKTkE4YnFITzR0WHBs?=
 =?utf-8?B?MG41bFNVRDg0TmpZNWlwY2o2VjNFcmpXRUEzbU5yYURYREZIQ2hYdGExZVh5?=
 =?utf-8?Q?Qu6X/Dsuq4tSXYyVL6mFWr1M/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A4AE5F14CE0C34583B5D1FE9D4A7D8D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d40feac-2e92-42cb-c0c3-08daceec4682
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 13:52:21.6611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pIWQbPCU6L3ONiMwKLmAGME2no0Ud1Fi+qh5ac1ZgDgfEvZ3kF6DP3hqb1o0HANBEkHmK/IfzsTnjyHV6g+pI8El3cLbcUGOj3/gtWW9BqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7256
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjUvMjIgMTU6NDcsIENsYXVkaXUgQmV6bmVhIC0gTTE4MDYzIHdyb3RlOg0KPiBPbiAy
NS4xMS4yMDIyIDE1OjA2LCBFdWdlbiBIcmlzdGV2IHdyb3RlOg0KPj4gVGhlIEFUTUVMX0lTQyBh
bmQgQVRNRUxfWElTQyBoYXZlIGJlZW4gZGVwcmVjYXRlZCBhbmQgbW92ZWQgdG8gc3RhZ2luZy4N
Cj4+IFVzZSB0aGUgbmV3IE1JQ1JPQ0hJUF9JU0MvTUlDUk9DSElQX1hJU0Mgc3ltYm9scyB3aGlj
aCBhcmUgdGhlDQo+PiByZXBsYWNlbWVudCBkcml2ZXJzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCj4gDQo+IEFwcGxp
ZWQgdG8gYXQ5MS1kZWZjb25maWcgKGFmdGVyIHJlLXdvcmtlZCBhIGJpdCB0byBrZWVwIGVudHJp
ZXMNCj4gYWxwaGFiZXRpY2FsbHkgc29ydGVkKSwgdGhhbmtzIQ0KDQpJIGFkZGVkIHRoZW0gaW4g
dGhlIG9yZGVyIGdpdmVuIGJ5IG1ha2Ugc2F2ZWRlZmNvbmZpZy4gSXQncyBub3QgDQphbHBoYWJl
dGljYWwgcmF0aGVyIGdpdmVuIGJ5IHRoZSBvcmRlciBpbiB0aGUgbWVudWNvbmZpZyBpdCBhcHBl
YXJzLg0KV2hlbiBtb3ZpbmcgZnJvbSBtZWRpYS9wbGF0Zm9ybS9hdG1lbCB0byBtZWRpYS9wbGF0
Zm9ybS9taWNyb2NoaXAgdGhlIA0Kb3JkZXIgaW4gdGhlIGRlZmNvbmZpZyBjaGFuZ2VkLg0KSWYg
eW91IHJlb3JkZXJlZCB0aGVtLCBub3cgdGhlcmUgd2lsbCBiZSBkaWZmZXJlbmNlcyB2cyBtYWtl
IHNhdmVkZWZjb25maWcuDQoNCkV1Z2VuDQo+IA0KPj4gLS0tDQo+PiBjaGFuZ2VzIGluIHYyOg0K
Pj4gLSBzcGxpdCB0aGUgbXVsdGkgdjcgaW50byBzZXBhcmF0ZSBwYXRjaA0KPj4NCj4+ICAgYXJj
aC9hcm0vY29uZmlncy9zYW1hNV9kZWZjb25maWcgfCAyICstDQo+PiAgIGFyY2gvYXJtL2NvbmZp
Z3Mvc2FtYTdfZGVmY29uZmlnIHwgMiArLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vY29u
Zmlncy9zYW1hNV9kZWZjb25maWcgYi9hcmNoL2FybS9jb25maWdzL3NhbWE1X2RlZmNvbmZpZw0K
Pj4gaW5kZXggODc3YmJlN2I3NzdlLi5mODlmZDRlMGQxMGEgMTAwNjQ0DQo+PiAtLS0gYS9hcmNo
L2FybS9jb25maWdzL3NhbWE1X2RlZmNvbmZpZw0KPj4gKysrIGIvYXJjaC9hcm0vY29uZmlncy9z
YW1hNV9kZWZjb25maWcNCj4+IEBAIC0xNTAsOCArMTUwLDggQEAgQ09ORklHX01FRElBX1BMQVRG
T1JNX1NVUFBPUlQ9eQ0KPj4gICBDT05GSUdfTUVESUFfVVNCX1NVUFBPUlQ9eQ0KPj4gICBDT05G
SUdfVVNCX1ZJREVPX0NMQVNTPW0NCj4+ICAgQ09ORklHX1Y0TF9QTEFURk9STV9EUklWRVJTPXkN
Cj4+IC1DT05GSUdfVklERU9fQVRNRUxfSVNDPXkNCj4+ICAgQ09ORklHX1ZJREVPX0FUTUVMX0lT
ST15DQo+PiArQ09ORklHX1ZJREVPX01JQ1JPQ0hJUF9JU0M9eQ0KPj4gICBDT05GSUdfVklERU9f
TVQ5VjAzMj1tDQo+PiAgIENPTkZJR19WSURFT19PVjI2NDA9bQ0KPj4gICBDT05GSUdfVklERU9f
T1Y1NjQwPW0NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9jb25maWdzL3NhbWE3X2RlZmNvbmZp
ZyBiL2FyY2gvYXJtL2NvbmZpZ3Mvc2FtYTdfZGVmY29uZmlnDQo+PiBpbmRleCA4ZjI4YzlkNDQz
ZjAuLmNjNDJjZWE3N2YzOCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtL2NvbmZpZ3Mvc2FtYTdf
ZGVmY29uZmlnDQo+PiArKysgYi9hcmNoL2FybS9jb25maWdzL3NhbWE3X2RlZmNvbmZpZw0KPj4g
QEAgLTE0MCw3ICsxNDAsNyBAQCBDT05GSUdfTUVESUFfU1VQUE9SVF9GSUxURVI9eQ0KPj4gICBD
T05GSUdfTUVESUFfQ0FNRVJBX1NVUFBPUlQ9eQ0KPj4gICBDT05GSUdfTUVESUFfUExBVEZPUk1f
U1VQUE9SVD15DQo+PiAgIENPTkZJR19WNExfUExBVEZPUk1fRFJJVkVSUz15DQo+PiAtQ09ORklH
X1ZJREVPX0FUTUVMX1hJU0M9eQ0KPj4gK0NPTkZJR19WSURFT19NSUNST0NISVBfWElTQz15DQo+
PiAgIENPTkZJR19WSURFT19NSUNST0NISVBfQ1NJMkRDPXkNCj4+ICAgQ09ORklHX1ZJREVPX0lN
WDIxOT1tDQo+PiAgIENPTkZJR19WSURFT19JTVgyNzQ9bQ0KPiANCg0K
