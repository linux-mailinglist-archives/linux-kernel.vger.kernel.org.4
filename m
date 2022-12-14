Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B121D64CCA1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbiLNOrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238525AbiLNOrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:47:47 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00106261;
        Wed, 14 Dec 2022 06:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671029265; x=1702565265;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MWlauJblWbc7Qijo7WybDdMPPpDz3BCJHLmOMcNeuzI=;
  b=c7ED5tXVcDqIRCBlY0yFApmsUTGv0RsewgXKvNv0LazWSLeWwO74NlaU
   szJxuFnEmTztkHvgb5OAY3m5oeSMXdy3sBf0cU0/yLWggTR6lwzy0CioX
   VNRMHl3V/RISMwaSFECs0KHUukCAR/PxR1xf0TD+UsEH7rv9EJYepv2My
   GzHSX8VEWTtHwvBbw8dgdqT0qvLLmgEaMlMJavOYlVFj79aq/hrBKk0dY
   q2y+G6BLZW88bF3irGCD73GrmboMaG7GXcOjdfylsUL8wy/Nw+/8jMijU
   oy1DtOeQbtyEdF2jWan3JazBLKynqiH37iDdHb1W7vKvp7W9VLLxDYutv
   w==;
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="203998206"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Dec 2022 07:47:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 14 Dec 2022 07:47:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 14 Dec 2022 07:47:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCtRLhuG6EoBkOG/wds4I2osQordWa3xU/j2mWab5Qx5dZn9b0whceMW6y8KAamKXPdGHYGY9bc2Qptn0M0z2R+QnpWfGsyQ7+hUe0b8aj0G5/iTpBDnjaCis/pFkqWjQgKDAJ4VC0pD7YkYmRlV42J9VK4ItuOhUpogdrKmRlq2Gzysy0Fg7iaKqZIIWBUt8DPudzXECFrzPVLhVNy4dYudICz1jGlZ11NnrMIqo5UmKtpjkUkoxi88EGqoaxIvmoH/cX4gv85awsv9rugAGK6ugGYQKcR3uXmfhCrFn46lM5ND35LacfT6jOGm51gqG0YijxxAxI8oksZ2b1D6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWlauJblWbc7Qijo7WybDdMPPpDz3BCJHLmOMcNeuzI=;
 b=CSfWexUGLyogovh6ckRghx5ir/RCxLwUsVYDL6aJkclBdZ0rufDOMPU/7V8yllNECidI+fUATA5J23kAU7HI+dQcKHhM1HKxkGBLIIvqE2nd6Wa5A1m87nEieTluz0esjZ6fTD/Ho8XTQ+lraisCdGXjf5EmqF2S1lllnted1+vYiPlZJe4Mw/HRKN4LONNx1WFx7114cgaSoFUTOYxYlE8ox5zvT37qZgc7Jxx3N6jgTVI5opsSYQEeqyJbLl5iD/kI3KrsuH7h3JelfS5R9CaU1b86kfJnGHb0J4jd9ClbRBDfU7HZII6ixP8YOvhWKJHTLJmIa42MG6qpXyDyBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWlauJblWbc7Qijo7WybDdMPPpDz3BCJHLmOMcNeuzI=;
 b=tPADkzv1zFqCmWDEWr1KUUUstN8DIhsgwnFR3sMMSkS6JzP8U/8/QHozZhkifqyrBc+m/9pEt/hp4yoCyu8o9Ydd+Lf/EQgs8xIB/6oEIvcqmvQFfGjAebhkh+Pl690o/Ht2seeSS6n2R2bf9FpJ1oy6RhOL1jIwWhvNxBCZYTQ=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SA1PR11MB5898.namprd11.prod.outlook.com (2603:10b6:806:229::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 14 Dec
 2022 14:47:42 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15%10]) with mapi id 15.20.5924.011; Wed, 14 Dec
 2022 14:47:42 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Eugen.Hristev@microchip.com>, <Nicolas.Ferre@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jacopo@jmondi.org>, <hverkuil@xs4all.nl>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>
Subject: Re: [PATCH v10 3/5] ARM: dts: at91: sama7g5: add nodes for video
 capture
Thread-Topic: [PATCH v10 3/5] ARM: dts: at91: sama7g5: add nodes for video
 capture
Thread-Index: AQHZD8sFgKOKAjdaEUWNhaEIa0xf7Q==
Date:   Wed, 14 Dec 2022 14:47:42 +0000
Message-ID: <146462fb-6afd-1b88-ed7b-fc9b8b76477b@microchip.com>
References: <20220503095127.48710-1-eugen.hristev@microchip.com>
 <20220503095127.48710-4-eugen.hristev@microchip.com>
 <323a98c7-85f1-a21c-d655-7b510481adc0@microchip.com>
In-Reply-To: <323a98c7-85f1-a21c-d655-7b510481adc0@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SA1PR11MB5898:EE_
x-ms-office365-filtering-correlation-id: 3e92f7df-d5b5-4d52-f336-08dadde2279f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AbuvU7IN7exShXtEroxnNb1jmXPpfBJfFqiCI6YLA3ARHSLr8M7NlfKCgV5eVevwKTnfhXUJWIE5hYgu2+YxL+X/WQxidQeblxo8lAhsTNWjU3ael1MM6xka9HiaaxZnuI/6BhMG/7wsq7Tp9avlA3fmcKw4/0/wtjZh2ue8z0rQ2PHqlRACb3u3PLhhEkZggZDGLluejmK3Tk3/VQ+mkdu4eOzo4ZaocJbXgTHju0Ja0JKf9fkYUdPAnQ0dAKiD7g/s4O6lBjinumw6A7LPAytdmI99jIfHH+hpzIz6O9E5b1vBqT/kwxZjQpQktiFbYhDseeUGOfSTnVKwf4Qy7a9xr2VHj0rDTNmvTz7rXzh+1tkwSSSYvqpH9SL2jpTkrvHSHyZvswTqamqbNxywEqt9HCvMiDFwmifsZv6Zg25/pZqM4HI41pd7fX7p9BjEdyGctPwop8nL4PkQyVt8qgqOlOPOzzyA2344MOqJi5/evFGsTbpRxR1mqmgPu0M0FMAFC0kADv1saiTCEphukE7HDwpMVPmM0BJObRYnSwYX+PZ+l/K1S5SiabyOnC8Uxp4d32naCJtNOL4ncY8i55LmUNIAMnZQWdBYk2Xsz/T1vdzNl/SGCvlGc8OLLsmOFs/+CGdxuMM75jdjWKE8dA4GxO1rkX/P/EvkKzK5CBkdS63l7S6nQHwUUGievYuZdof7aIa6cQJWdhfo+dazV80YfDyuIWfmU5ypRVmqbN5spVLoM3/I8ZeRg1VNB/mWHWW61QfUk9jEWco/s8ZvuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199015)(71200400001)(41300700001)(86362001)(76116006)(31696002)(66946007)(66556008)(66476007)(66446008)(6512007)(8676002)(64756008)(91956017)(186003)(26005)(4326008)(2616005)(478600001)(6486002)(53546011)(54906003)(6506007)(6636002)(110136005)(316002)(122000001)(38070700005)(38100700002)(5660300002)(8936002)(83380400001)(2906002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VS8wOUVkUWhpVG54WDREb0gwQjFZN2hiajZuWkNFckEwRk5CWkpUdXM5WWdl?=
 =?utf-8?B?VWRYdmkzWFJiTm0xN0VRT0I3bnNxWnZNZWhTbFl3WFlPVjRsVFZCK2dZcFNp?=
 =?utf-8?B?UEZIRU9jTklmZVFuUE5sRzROenpsTTFtOTVvbXF1WlZiZks1aHJCWitnN3Vy?=
 =?utf-8?B?WDVTWmY4WVZxMkpFamp4K2FSZzM0VTN1ZkdveGpIZkxmckhucm9JeDJya0hC?=
 =?utf-8?B?dWoyWms1YmQ2SXA4Vng4ajZYOGRXTkRMSXFxdDdKMC9aMnFQZ0daVUpjQ2RC?=
 =?utf-8?B?VnhEcTN2VXhIWnllb2cybS9PdS9SUHlDbm9VdisrWkQ1Nk05MnFGTzc3Vis0?=
 =?utf-8?B?bXQzams2L3EzZW8yZCtQSG4wakNCUGp3N1RTY0psMlhCeiszQmJkc2Z6UE9T?=
 =?utf-8?B?RzJabXZmL2hDUHpSdXZZQnZTK3hzV2lZUlUwT2xuRFB4THk0SUlFRnNkRlVZ?=
 =?utf-8?B?cUdXcE52N3Z3MEg1Rnk3TThxSGFldzM2cGFwZmZFRGg5RUcyNEI2MGM2NFRo?=
 =?utf-8?B?MG9wdmtvVFdRdU5iSnNuK1hKRm5vN0NxRy9HSXdUQitYbUdkeUp6R2lCRXZG?=
 =?utf-8?B?SkRubnowWlA0aUpuRWJDRkE1QVEvemUrSEVOQW5RTXA5SURjL3VPQkMybzVO?=
 =?utf-8?B?YlVMQjk1R2xDcEVOT2tWSmlDa0Q2OWlNbWpjVW91Um5RVEVBUytYTk5kUkFu?=
 =?utf-8?B?MUJxa0xsUitkbmwrNyt1VjIwNW1EWDNOdEp0OTJCd3RxbnRJQVJTdTNQZlVk?=
 =?utf-8?B?RG8zTnVkeDhtNmtYWHBLdnpEZjRaRVdlZ2ZWQ2lHNUt6MjdxQzBnVHZ6aVhu?=
 =?utf-8?B?bzdYcWZnSE8xNVI2b3B4d0hUNURtLzdyREdJUHo3N0NTUG4vYTF1c01TK01y?=
 =?utf-8?B?N2t6cW5VNGJDK2RTZFBSblNhMkR5bDQzTnowU2NsR3lRNzYwRGJLTTdGZU1V?=
 =?utf-8?B?ZFZLdDVEd21SYXlzZkgxQm9pSUMzYUdycFlXczRkV0hlaWgyUFZwVlQ1SCt6?=
 =?utf-8?B?ZVJqcmxUYnZhNmhWck5CZ3lKNXNWTGVDeDJWMW8zSGhEZTdydU5VVmpWWjZ0?=
 =?utf-8?B?MnRtTGtIOEc1VHRQclRCNlZXZ2gveXRYQ3dKUlBWcFY3SGlwNC9CdEJXcFRX?=
 =?utf-8?B?dGJGMUw1TmVhZFl3VmlSaFJQWmZjTytEa25SUGNqNnZwdStjMHJ1L0hpWU5w?=
 =?utf-8?B?QTFPZDVXU1dialpLc3dMOW9zOUd5VjVBaU1HL294Sk9iczF0Szl1NXA1WkIx?=
 =?utf-8?B?R09pTFBzWFBGRXlTclliY3loTWdOaWk1cXFSUjNwRTVoY2lsRThXVExhSktx?=
 =?utf-8?B?YVBab2RWbXNBbWZxVkVEK2VLQzJHV3RCRzZOOTNaRGdhd01yMFY4cFNSMi9a?=
 =?utf-8?B?ZUV4K3lENGMxVHRqcHFndnJ3Wk5GQ2RiMW1uRTQvUys0Z2tVMmRMRzEyVlQ1?=
 =?utf-8?B?NGs4ZVZsdWIxOVFJejQxbm90MVUzT1phNVJ1UzdIQUtNWmRkMnN3aFlzcHB1?=
 =?utf-8?B?Q3dWZXlQSjhCWFN0ck14b3R1dXhlc05RbnlHV2w2bFYxWk96cmhxYU5ybzR1?=
 =?utf-8?B?VGpHeTNKM0JkaGE2Uk1lMUFzeFpxS3dPM1BZTmpGa2s0WjJha3dXd2QvT0JZ?=
 =?utf-8?B?YlFrcmZZMXdoL1dUNWJjL3oxNHlJWWFDOFBrbUpJME1rRm9MNzNOdDZ5OS93?=
 =?utf-8?B?aXZHUlJZVTBPTkprdk0rUzJYL1YyMFlocVNXeXpLcUphL3VzQ3pxS1o4cW1t?=
 =?utf-8?B?S2FXTGpMMGxEU08rU0JRK2toNGMwRS80WThSZzVOOUtVa09uL3QzWFNpek1n?=
 =?utf-8?B?ekdvSkhwNWxKR1F2L1o4T2o2R1lWVmdqWDRsbHJiZ2RhOGJRZzBCQm5MZTRs?=
 =?utf-8?B?ZlV1c1hqY3JTN0lNWmJNMkhQcDBBQU9HVXZYdzcvTm9kU2hmN214aU5XekE3?=
 =?utf-8?B?N3dhOTk1S1ZXTzMvZE5lNXFhcEo4ekYyK2d6UW1vZ1hxVmhBMlV5eFNFRE8v?=
 =?utf-8?B?L1h6ZXRnY2dQNXRwNERHMzFMZGNPdFExbTFLcW5nVkkxNSttRHZ5OFlVR1Za?=
 =?utf-8?B?Sml3QU5Ub21RYnJCWTFIZ2JtT3Vzb29vU01URkFPaEYzaGpmT250OHovNWNs?=
 =?utf-8?B?cUQwUVRpUDROUlhuWTNaSjd6LzU2SGlQdysxVVplaWhoVUxPL3RlTUxnOGR2?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70945910E0A7F74A90395CD71A9A8FBF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e92f7df-d5b5-4d52-f336-08dadde2279f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 14:47:42.3331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iq/zRsvep9YBcT2zp21K/ONO43R1yScBY8CNEIjY/kAWrb4JD/2x5dJBPaY5BJgZTQ4RU+Y1cYEW203coZcq7nOEJtfu1glwNmJ5Au0BgPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5898
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQuMTIuMjAyMiAxNDo1NSwgRXVnZW4gSHJpc3RldiAtIE0xODI4MiB3cm90ZToNCj4gT24g
NS8zLzIyIDEyOjUxLCBFdWdlbiBIcmlzdGV2IHdyb3RlOg0KPj4gQWRkIG5vZGUgZm9yIHRoZSBY
SVNDIChlWHRlbmRlZCBJbWFnZSBTZW5zb3IgQ29udHJvbGxlcikgYW5kIENTSTJEQw0KPj4gKGNz
aTIgZGVtdXggY29udHJvbGxlcikuDQo+PiBUaGVzZSBub2RlcyByZXByZXNlbnQgdGhlIHRvcCBs
ZXZlbCBvZiB0aGUgdmlkZW8gY2FwdHVyZSBoYXJkd2FyZSBwaXBlbGluZQ0KPj4gYW5kIGFyZSBk
aXJlY3RseSBjb25uZWN0ZWQgaW4gaGFyZHdhcmUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogRXVn
ZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiBDaGFu
Z2VzIGluIHYxMDoNCj4+IC0gbm9kZXMgZGlzYWJsZWQgYnkgZGVmYXVsdA0KPj4NCj4+ICAgYXJj
aC9hcm0vYm9vdC9kdHMvc2FtYTdnNS5kdHNpIHwgNTEgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9zYW1hN2c1LmR0c2kgYi9hcmNoL2FybS9i
b290L2R0cy9zYW1hN2c1LmR0c2kNCj4+IGluZGV4IDRkZWNkM2E5MWE3Ni4uZmU5YzZkZjk4MTli
IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTdnNS5kdHNpDQo+PiArKysg
Yi9hcmNoL2FybS9ib290L2R0cy9zYW1hN2c1LmR0c2kNCj4+IEBAIC00NTQsNiArNDU0LDU3IEBA
IHNkbW1jMjogbW1jQGUxMjBjMDAwIHsNCj4+ICAgCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4+
ICAgCQl9Ow0KPj4gICANCj4+ICsJCWNzaTJkYzogY3NpMmRjQGUxNDA0MDAwIHsNCj4+ICsJCQlj
b21wYXRpYmxlID0gIm1pY3JvY2hpcCxzYW1hN2c1LWNzaTJkYyI7DQo+PiArCQkJcmVnID0gPDB4
ZTE0MDQwMDAgMHg1MDA+Ow0KPj4gKwkJCWNsb2NrcyA9IDwmcG1jIFBNQ19UWVBFX1BFUklQSEVS
QUwgMzQ+LCA8Jnhpc2M+Ow0KPj4gKwkJCWNsb2NrLW5hbWVzID0gInBjbGsiLCAic2NjayI7DQo+
PiArCQkJYXNzaWduZWQtY2xvY2tzID0gPCZ4aXNjPjsNCj4+ICsJCQlhc3NpZ25lZC1jbG9jay1y
YXRlcyA9IDwyNjYwMDAwMDA+Ow0KPj4gKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+PiArDQo+
PiArCQkJcG9ydHMgew0KPj4gKwkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+ICsJCQkJI3Np
emUtY2VsbHMgPSA8MD47DQo+PiArCQkJCXBvcnRAMCB7DQo+PiArCQkJCQlyZWcgPSA8MD47DQo+
PiArCQkJCQljc2kyZGNfaW46IGVuZHBvaW50IHsNCj4+ICsJCQkJCX07DQo+PiArCQkJCX07DQo+
PiArDQo+PiArCQkJCXBvcnRAMSB7DQo+PiArCQkJCQlyZWcgPSA8MT47DQo+PiArCQkJCQljc2ky
ZGNfb3V0OiBlbmRwb2ludCB7DQo+PiArCQkJCQkJYnVzLXdpZHRoID0gPDE0PjsNCj4+ICsJCQkJ
CQloc3luYy1hY3RpdmUgPSA8MT47DQo+PiArCQkJCQkJdnN5bmMtYWN0aXZlID0gPDE+Ow0KPj4g
KwkJCQkJCXJlbW90ZS1lbmRwb2ludCA9IDwmeGlzY19pbj47DQo+PiArCQkJCQl9Ow0KPj4gKwkJ
CQl9Ow0KPj4gKwkJCX07DQo+PiArCQl9Ow0KPj4gKw0KPj4gKwkJeGlzYzogeGlzY0BlMTQwODAw
MCB7DQo+PiArCQkJY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtYTdnNS1pc2MiOw0KPj4gKwkJ
CXJlZyA9IDwweGUxNDA4MDAwIDB4MjAwMD47DQo+PiArCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJ
IDU2IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPj4gKwkJCWNsb2NrcyA9IDwmcG1jIFBNQ19UWVBF
X1BFUklQSEVSQUwgNTY+Ow0KPj4gKwkJCWNsb2NrLW5hbWVzID0gImhjbG9jayI7DQo+PiArCQkJ
I2Nsb2NrLWNlbGxzID0gPDA+Ow0KPj4gKwkJCWNsb2NrLW91dHB1dC1uYW1lcyA9ICJpc2MtbWNr
IjsNCj4+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPj4gKw0KPj4gKwkJCXBvcnQgew0KPj4g
KwkJCQl4aXNjX2luOiBlbmRwb2ludCB7DQo+PiArCQkJCQlidXMtdHlwZSA9IDw1PjsgLyogUGFy
YWxsZWwgKi8NCj4+ICsJCQkJCWJ1cy13aWR0aCA9IDwxND47DQo+PiArCQkJCQloc3luYy1hY3Rp
dmUgPSA8MT47DQo+PiArCQkJCQl2c3luYy1hY3RpdmUgPSA8MT47DQo+PiArCQkJCQlyZW1vdGUt
ZW5kcG9pbnQgPSA8JmNzaTJkY19vdXQ+Ow0KPj4gKwkJCQl9Ow0KPj4gKwkJCX07DQo+PiArCQl9
Ow0KPj4gKw0KPj4gICAJCXB3bTogcHdtQGUxNjA0MDAwIHsNCj4+ICAgCQkJY29tcGF0aWJsZSA9
ICJtaWNyb2NoaXAsc2FtYTdnNS1wd20iLCAiYXRtZWwsc2FtYTVkMi1wd20iOw0KPj4gICAJCQly
ZWcgPSA8MHhlMTYwNDAwMCAweDQwMDA+Ow0KPiANCj4gSGVsbG8gQ2xhdWRpdSwgTmljb2xhcywN
Cg0KSGksIEV1Z2VuLA0KDQo+IA0KPiBUaGlzIHBhdGNoIGlzIHJlYWR5IHRvIGdvIG5vdyAsIGFz
IHRoZSBtZWRpYSBjb250cm9sbGVyIHN1cHBvcnQgZm9yIFhJU0MgDQo+IGRyaXZlciBpcyBpbiB0
cmVlLg0KPiANCj4gTGV0IG1lIGtub3cgaWYgeW91IG5lZWQgdGhpcyB0byBiZSByZXNlbnQuDQoN
Ck5vIG5lZWQuIEknbGwgdGFrZSB0aGlzIG9uZSBmb3IgdGhlIG5leHQgUFIuDQoNClRoYW5rIHlv
dSwNCkNsYXVkaXUgQmV6bmVhDQoNCj4gDQo+IFRoYW5rcywNCj4gRXVnZW4NCj4gDQoNCg==
