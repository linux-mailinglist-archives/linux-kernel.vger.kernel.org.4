Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9C35BAC8D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiIPLhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiIPLhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:37:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37DAAB4CF;
        Fri, 16 Sep 2022 04:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663328264; x=1694864264;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PMZeos59INea3QXxfusTsj39pNzU6GcATXd6xqIGruY=;
  b=KKoc24F21MiCnym7b57aT11CkWlgwatL8/TKiU63gfN6n93u1y/3kHtM
   XLulNvN2Jo+Hc+eAifTZsQuyqH4IHFCfEMQoMG4ErSuIMyvh4TgYD8mlk
   X/YMAVg9uaZTonElCpkYzEESiKgbGykFIiYdrKiWNvOKnrmD1Vkc5TRZD
   5z9O4gwNJa4SKQoBI4cxjvbJt1nwmwFMDs3IOsrLRk5i9UnuoHBlKyagm
   7iTo1iksASGbwy1aqWrgO6KX/A2iMNn0S/m4VgEwHR4bgxfQSp9LOyjSV
   8R2OSKO80sqXST7YeEg7hAkc4SuK9qM+Gegq7FCvkLt78iAG9towA11J7
   g==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="114002777"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2022 04:37:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 16 Sep 2022 04:37:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 16 Sep 2022 04:37:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5Ri99giy4JpNMZu/DlJ05mUroFgIVQHHliuzh8+xrfHL1ipwpYdqXT4tyBhOEwpMiHdsiB83RDbcgZDTpoaIX5QZfJP8PGfj2yl9Qfum1md+VLwqc63syrRkiaWlopY4eqxoMwTHCcvy0MuT+5Pb0u4+/j2EAPbCf51vXLbhbyPcGVvxeo32tHfEk7c8Y8BUc3OFdM2up1PH5A9I/+tl0EYTHijosJEjGbsKPfzF/O9O+rKcW06Px6xEAMDj3ir6u6dcbH61EZliZYlH82AD6d+8iyMQh3is5u921YLN2B1XJPaXcFMrwjy2sdnk+/cc+stbfPPzjGbTsk9XpQGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMZeos59INea3QXxfusTsj39pNzU6GcATXd6xqIGruY=;
 b=JO4/QRMBVh1j/DP1oFQ3kBPXI94uJnBMX9NqCsMOKvsII5lmgVzK8UST80iINb6ubAs3AJ4PgzN82Rp5dB0lW7xqd0AZq7H/fg6TsX6IzzFyUFt3hYogdGH6QEc4zpEh2pxEf1PnR7esxXyYFJZZAlTvSOhWmtBdyK2xfWqq6iCxchAs79o9JPCz+NXxRyJ/xsA6xQDhJT8a508Lr1JBlKddVfWHnCsFikfqWxSyRc1xVkEkqByPCbBEQbxLW6r7z47hqTSyghSu/VQrFLlxRqohWE8hD3ewtOCnU71hQBLITQlK2nXcnWuPxq+5n1uYTnGzRjEDATDt0A8BcSfEZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMZeos59INea3QXxfusTsj39pNzU6GcATXd6xqIGruY=;
 b=eYb693b8ny55bRpiyP/bb78QbEHQMOWyiXi4n2vijaovrkxY92J3c4VRNAhdXzoC91ImMoo6fRukLCukMT5F277bSZjr0p08UOF0GUx4PG/9ysag4/5BddU+S95DHVsS5uLfHd5t9Odlfb2aphaVS7GJEF+vosOcdW34ynJKjCk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MW4PR11MB6958.namprd11.prod.outlook.com (2603:10b6:303:229::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 11:37:38 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5632.017; Fri, 16 Sep 2022
 11:37:38 +0000
From:   <Conor.Dooley@microchip.com>
To:     <michael@walle.cc>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <dmitry.torokhov@gmail.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: fix OOB access in quirk callbacks
Thread-Topic: [PATCH] gpiolib: fix OOB access in quirk callbacks
Thread-Index: AQHYyb0QnDOgVMrUl0m/YPY3AQeoKK3h7eIA
Date:   Fri, 16 Sep 2022 11:37:38 +0000
Message-ID: <960a9d86-7814-3b2f-d5a0-9bc2b316d12b@microchip.com>
References: <20220916110118.446132-1-michael@walle.cc>
In-Reply-To: <20220916110118.446132-1-michael@walle.cc>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|MW4PR11MB6958:EE_
x-ms-office365-filtering-correlation-id: b439237b-4544-4f2d-68c3-08da97d7dbab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5t0b72VNLV913Yt5rcvCJf54vTT11DJKrVBuZlabQ2NY3Ni9+LBWFEFuTPn1IbyD79ap8Snse09TeXg/9DlWclHJ4mvvCwwj6lt6NgVdBggFMYD/gMCyls0EKSnBInVzhYGJ/JClOR1Us7AAbJyUFzNmNpHE4AVAYm8hp2a7vSbNFWJLEI9UlS9FNlJ0tuQqhCj2ThSHcByB5ZYnd5FPQ8Xfx/iNZainsEAwB9Qf1w2jGvd3QU/wgyXY55q+d0PcL39pMaT8HFQmsvMEW2DvMc8itJzHWdXf/oKddC4vOCtxf3EnRUMP3iWLyIl9ksw41fwVFypEcYL9ZJH4QRaTxy6yZGizR+rjrUve7miOuGnrRvZMVy60jD4qJ5/WnE0Yw6ptgzbXWYsmnBbYXvymYKoXdJJKn6YaPDhsw9QfFT7O6wyGcz7xgQ4Luub3XVUxaTAHjFBaV8kQX/yAp2zVepK8QnvwH4BLIHpBOG3ofzGDowAtKWDRhNtnHsMNKEGMiQUoB3fbHqlNhgjaHqS8/4lmnfNWQ8OarKtXaDxOwnsdighhSFYRHGoX+H/YXZnfNlv+0VTUvjWeCjgQcNQa8+ZODeob9qlspJMMjzbF3LSxxFvxLJcAFlKhQzUoCHBUhydjQUKChiKtDx9ACDqaaGm7WiBw2RVVCcO5a+uv99ib3JOA7EhWLqFrTQXUx2dHzsfpm8j/0pQwP6PiyQK8TOg6eDCJ6ymU5PFUR/Z/v+DoExzKrrXj5lUc3LM9gKaD1AhVBvCT/67vPKi4PTBQ40BGHcb3gx/dwSdXv9stGZzRbdQOCO4H4V+xGfReZ2//nLbvAzTm60qDf6q0VxWGFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199015)(110136005)(6512007)(26005)(8936002)(6506007)(45080400002)(2616005)(66556008)(66446008)(186003)(66476007)(38100700002)(64756008)(91956017)(8676002)(5660300002)(4326008)(122000001)(41300700001)(31696002)(36756003)(86362001)(66946007)(71200400001)(76116006)(53546011)(54906003)(2906002)(31686004)(38070700005)(316002)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3pwdTJLRkpJcHNXbnJ1WXlYdEx0OUhId0FwRXRIUHZpT0twZnRvbkg5WHI5?=
 =?utf-8?B?K1REQ1h2SlVUdWVJQTBQVHViRHZvc3p0bkFxeHhiQlBvT0dxbHMxWkRoL3dz?=
 =?utf-8?B?c1BGd09NRUFlWGFNMWlCL1pBSllsa1Z5c05RY01vQ3VlQnVPQUhFbmFoaHVB?=
 =?utf-8?B?TFZXNUY5S0grUGVQcmNPYzVwbjNkSGdWd1FGNHlQU0Q1blNldXdaVjlIUXFk?=
 =?utf-8?B?WUVyaGhRYlo4NkZ5RkdFaUJkcEF4YW85Tkl6dmY0aFZCTHdaWngrcVkreENZ?=
 =?utf-8?B?OW5jU1c4YzZEMlJrVWFuMUVsNElPNnFzVTdGNk9BZEZTQjBRMC9oeWpld0NP?=
 =?utf-8?B?T2RFM2lGUXE1b1RJd3gvcmVRNmVtZERVNXBqMjJFcDZGMm8wdGpKcDU1MFFB?=
 =?utf-8?B?WjN5R25DZnNaU01yaWNMcnRyeWdWZjBnazh6RFF1ZkM2U0ZESVpEY0pSSmd1?=
 =?utf-8?B?aW1UVlh5STd4Zmh2VzA3a1dIWnRaR3VWd1pVVW8zM0JqZUEwN3VxcndZcVB0?=
 =?utf-8?B?cUNvbjVUS2N0MHBiVDVVdXNnUmM5TjdoMEdHbjhXcG0ySFB6YTU5aUVNM3ZO?=
 =?utf-8?B?M1J6clFrNG9jK2E1cHoxZFZmQXlwMUdiRDN3WDNwKzFOZzdJWWJVWHhvWFlz?=
 =?utf-8?B?bnFhWkthK1p6elFLcitHb0dBQU1lYmdvNnhxYVZHMVdJbHNGZVBUQjdXTWdo?=
 =?utf-8?B?QklvQ0hrYTUwTlRhUmNwR3REVFgzc1piZU9RbWdHWW5VUVNaNzQ4NkluVkJj?=
 =?utf-8?B?M0FEYTZSRGtXVjFkeDJJcUYzbEFDTXpGZEhGT1g5UEdOV2VPSThqM0VvS1Za?=
 =?utf-8?B?cVAwdHBUeUEwdFY0OWRVMTFLK1hDWXV1L0huNzl0OGdVV1paWXE0STJGR08w?=
 =?utf-8?B?UXFFRndNMTRVRWtIcEgyNGJ3bmFWM2I4aXFVU294aXMyajJHcUwya28xRldJ?=
 =?utf-8?B?cXNTcFB6RkpUc3JhUjlsYk5MZE5vZHlkem1WZGdRcENvUk5XOXY5V2s0aWNz?=
 =?utf-8?B?cHJKWThoZXBlMlYzc3N0Ymlqamphc09TNDk5a3RGUC94Z1hIYkRXMWgrMUpz?=
 =?utf-8?B?bEhOaS8xalJJY1Rta2h3bmY3bnZmUHdFSGZxTzR0Sy9QajlZRWYrOFhUTFRE?=
 =?utf-8?B?ZnVSOURXL0c1LzIzdE5BQmFMZWJ2cHd0RG5lRHpDRnFyMmZBUVV6Ym0rdmdO?=
 =?utf-8?B?cFV5NTZiejh5dmhDN0RTaEtvT0JlMDdOOXo5aVhXc2NRZmpyNWJwejVvRDRB?=
 =?utf-8?B?WDZua3ZjNWR4b0Z4RVZMZzE3ZFRkSjd0Q0dobWlEbVZUWlZMa29KSjZ6cldo?=
 =?utf-8?B?NWN3UTB1dGw2cnFVb0lqQnAxZElSNHR3Z3VWejBmbURnM040VS9BSytEa2lv?=
 =?utf-8?B?TEE1eEZROXpCWm1VS09CR3BPaWdyNCtTendidzFXbVdaMnlmcENFQm5XUkgx?=
 =?utf-8?B?WXFCTHFJYXNEbjNCc3dmNkhCeS9sR3BrWEREN0FtU0YwcWNiSlMrWjB3Znd1?=
 =?utf-8?B?RGhaL1hHODZ0NmxodGppSmZ5SlozcHhWOFBWbC9IM21KVlVrc3UyRGN1bVdl?=
 =?utf-8?B?OVVlbTFFYnM1c0FzZVk5ZkhiMmJLUmhLWmZvWTVubGtMdytGR1k0RDlzRGlQ?=
 =?utf-8?B?cTh2STM4L3hWLzFlSTRlV3cwenZSRXR1eEloWUd4SnY0Ris2R0dlWUlvTkhu?=
 =?utf-8?B?czF5YTZ4MDg2aFV3eGUyTE5JQmoxL0JSUURSc3U3Qy9SZGR1NjArWUFtQUpE?=
 =?utf-8?B?NEMyNWJXQWQydy80dTRYQ3FiMWwvSDZoc0w3ZXMzTGRyTFUvYzdKcGF3VkZR?=
 =?utf-8?B?ZTBFdERpckNhN01objFHV2pueE9FM0tMYkhURVY5Smh0TjhOYjhNNzh0U3Bm?=
 =?utf-8?B?QU0zYnlXTHg0Z0o0a0I4b25icGJvcGUza3ZENGVGajZQcmxUUGlBRkNVRnNv?=
 =?utf-8?B?ZUpjQWdUOHZLOTZCbmdhdDhTTFVRZVZUTlUvRGZhYlMvdUF3NGFEWFNlNk5n?=
 =?utf-8?B?aENQS0tWNnQ3S2svRHpiOHpqdDlOdFo5N2J5S1ZoNzQyZm1aYWZBRlc4ZFVu?=
 =?utf-8?B?cXgwTS85elVJN2QxQkkzczM0QmhBN0IyMHAyN012ZlRBNWV4NkRsQTMrK0Ux?=
 =?utf-8?Q?FtZRj0FvVWMuGLNG/9pSSw4Hf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFEE16965425F242B68BB4CE263C4600@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b439237b-4544-4f2d-68c3-08da97d7dbab
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 11:37:38.5396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yynhbm1HKXcgPI2bX27AQambSQ3jOlCXx9mk1/81/rT3tIT6eW5M/JGdTxMrbFz5PAgXMvQ0FlRt2U2RXJGHG2/AEgX2G1ZlcSsrcA7neyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6958
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMDkvMjAyMiAxMjowMSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBDb21taXQgYTJiNWUyMDdjYWRlICgiZ3Bpb2xp
YjogcmV3b3JrIHF1aXJrIGhhbmRsaW5nIGluIG9mX2ZpbmRfZ3BpbygpIikNCj4gaW50cm9kdWNl
ZCBhbiBhcnJheSBvZiBxdWlyayBmdW5jdGlvbnMgd2hpY2ggZ2V0IGl0ZXJhdGVkIG92ZXIuIEJ1
dCBhDQo+IHNlbnRpbmFsIHZhbHVlIGlzIG1pc3NpbmcuIEFkZCBpdC4NCj4gDQo+IEZpeGVzOiBh
MmI1ZTIwN2NhZGUgKCJncGlvbGliOiByZXdvcmsgcXVpcmsgaGFuZGxpbmcgaW4gb2ZfZmluZF9n
cGlvKCkiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNj
Pg0KDQpUZXN0ZWQtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+
DQoNCj4gLS0tDQo+IEZXSVcgaGVyZSBpcyB0aGUga2VybmVsIG9vcHMgYmFja3RyYWNlOg0KPiBb
ICAgIDQuMTA4NzA2XSBJbnRlcm5hbCBlcnJvcjogU1AvUEMgYWxpZ25tZW50IGV4Y2VwdGlvbjog
OGEwMDAwMDAgWyMxXSBTTVANCj4gWyAgICA0LjExNTQ3MF0gTW9kdWxlcyBsaW5rZWQgaW46DQo+
IFsgICAgNC4xMTg1NDldIENQVTogMSBQSUQ6IDEgQ29tbTogc3dhcHBlci8wIE5vdCB0YWludGVk
IDYuMC4wLXJjNS1uZXh0LTIwMjIwOTE2LTAwMDkxLWc2Y2FlMGZjYmQ1ZTcgIzE4MjENCj4gWyAg
ICA0LjEyODAzM10gSGFyZHdhcmUgbmFtZTogS29udHJvbiBLQm94IEEtMjMwLUxTIChEVCkNCj4g
WyAgICA0LjEzMzEyN10gcHN0YXRlOiA2MDAwMDAwNSAoblpDdiBkYWlmIC1QQU4gLVVBTyAtVENP
IC1ESVQgLVNTQlMgQlRZUEU9LS0pDQo+IFsgICAgNC4xNDAxNTRdIHBjIDogMHg2MTcyMmQ2ZjY5
NzA2Nw0KPiBbICAgIDQuMTQzNDk1XSBsciA6IG9mX2ZpbmRfZ3BpbysweDEzOC8weDE3NA0KPiBb
ICAgIDQuMTQ3NTQ2XSBzcCA6IGZmZmY4MDAwMGEyNGI2ODANCj4gWyAgICA0LjE1MDg4NF0geDI5
OiBmZmZmODAwMDBhMjRiNjgwIHgyODogMDAwMDAwMDAwMDAwMDAwMCB4Mjc6IGZmZmY4MDAwMDk5
NjA0NGMNCj4gWyAgICA0LjE1ODA5MF0geDI2OiAwMDAwMDAwMDAwMDAwMDAxIHgyNTogZmZmZjgw
MDAwOTcwZjU4OCB4MjQ6IGZmZmY4MDAwMDkyOTc5NjgNCj4gWyAgICA0LjE2NTI5NV0geDIzOiBm
ZmZmODAwMDBhMjRiNzcwIHgyMjogMDAwMDAwMDAwMDAwMDAwMCB4MjE6IGZmZmYwMDIwMDA5YTcw
MTANCj4gWyAgICA0LjE3MjUwMF0geDIwOiBmZmZmODAwMDA5Nzc1MmY4IHgxOTogZmZmZmZmZmZm
ZmZmZmZmZSB4MTg6IDAwMDAwMDAwMDAwMDAwMDANCj4gWyAgICA0LjE3OTcwM10geDE3OiBmZmZm
ODAwMDA4NWZiOWQwIHgxNjogZmZmZjgwMDAwODVmYjI2NCB4MTU6IGZmZmY4MDAwMDg1Zjk2YWMN
Cj4gWyAgICA0LjE4NjkwN10geDE0OiAwMDAwMDAwMDAwMDAwMDAwIHgxMzogZmZmZjgwMDAwODg0
YjNlOCB4MTI6IGZmZmY4MDAwMDg4NGFiMDQNCj4gWyAgICA0LjE5NDExMV0geDExOiBmZmZmODAw
MDA4ODRhYTU0IHgxMDogMDAwMDAwMDAwMDAyNTA4MCB4OSA6IGZmZmY4MDAwMDg1ZmNlNzgNCj4g
WyAgICA0LjIwMTMxNl0geDggOiAwMTAxMDEwMTAxMDEwMTAxIHg3IDogZmZmZjgwMDAwOTc1MDI2
OCB4NiA6IDA1MWY1MjE0NTk0OTFiNTcNCj4gWyAgICA0LjIwODUyMF0geDUgOiA1NzFiNDk1OTE0
NTIxZjA1IHg0IDogNmU2MTcyMmQ2ZjY5NzA2NyB4MyA6IGZmZmY4MDAwMGEyNGI2ZDQNCj4gWyAg
ICA0LjIxNTcyNF0geDIgOiAwMDAwMDAwMDAwMDAwMDAwIHgxIDogZmZmZjgwMDAwOTc3NTJmOCB4
MCA6IGZmZmYwMDIwN2Y3ZTRiMjANCj4gWyAgICA0LjIyMjkyOF0gQ2FsbCB0cmFjZToNCj4gWyAg
ICA0LjIyNTM4OV0gIDB4NjE3MjJkNmY2OTcwNjcNCj4gWyAgICA0LjIyODM3N10gIGdwaW9kX2dl
dF9pbmRleCsweDEyYy8weDQ0MA0KPiBbICAgIDQuMjMyMzM0XSAgZGV2bV9ncGlvZF9nZXRfaW5k
ZXgrMHgzNC8weGYwDQo+IFsgICAgNC4yMzY1NTNdICBkZXZtX2dwaW9kX2dldF9vcHRpb25hbCsw
eDIwLzB4NDANCj4gWyAgICA0LjI0MTAzNl0gIHVhcnRfZ2V0X3JzNDg1X21vZGUrMHgxMDQvMHgx
ODANCj4gWyAgICA0LjI0NTM0NV0gIHNlcmlhbDgyNTBfcmVnaXN0ZXJfODI1MF9wb3J0KzB4MTk4
LzB4NDg0DQo+IFsgICAgNC4yNTA1MzJdICBvZl9wbGF0Zm9ybV9zZXJpYWxfcHJvYmUrMHgzNTgv
MHg2NDANCj4gWyAgICA0LjI1NTI3OV0gIHBsYXRmb3JtX3Byb2JlKzB4NzAvMHhlMA0KPiBbICAg
IDQuMjU4OTczXSAgcmVhbGx5X3Byb2JlKzB4YzQvMHgyZTQNCj4gWyAgICA0LjI2MjU3N10gIF9f
ZHJpdmVyX3Byb2JlX2RldmljZSsweDgwLzB4ZWMNCj4gWyAgICA0LjI2Njg4Ml0gIGRyaXZlcl9w
cm9iZV9kZXZpY2UrMHg0NC8weDE1MA0KPiBbICAgIDQuMjcxMTAwXSAgX19kcml2ZXJfYXR0YWNo
KzB4ODgvMHgxYTANCj4gWyAgICA0LjI3NDk2N10gIGJ1c19mb3JfZWFjaF9kZXYrMHg3OC8weGRj
DQo+IFsgICAgNC4yNzg4MzNdICBkcml2ZXJfYXR0YWNoKzB4MmMvMHg0MA0KPiBbICAgIDQuMjgy
NDM3XSAgYnVzX2FkZF9kcml2ZXIrMHgxNWMvMHgyMTANCj4gWyAgICA0LjI4NjMwM10gIGRyaXZl
cl9yZWdpc3RlcisweDgwLzB4MTNjDQo+IFsgICAgNC4yOTAxNzBdICBfX3BsYXRmb3JtX2RyaXZl
cl9yZWdpc3RlcisweDMwLzB4M2MNCj4gWyAgICA0LjI5NDkxNV0gIG9mX3BsYXRmb3JtX3Nlcmlh
bF9kcml2ZXJfaW5pdCsweDI0LzB4MzANCj4gWyAgICA0LjMwMDAxM10gIGRvX29uZV9pbml0Y2Fs
bCsweDRjLzB4MjQwDQo+IFsgICAgNC4zMDM4ODJdICBrZXJuZWxfaW5pdF9mcmVlYWJsZSsweDI5
Yy8weDMwYw0KPiBbICAgIDQuMzA4Mjc2XSAga2VybmVsX2luaXQrMHgyYy8weDE0MA0KPiBbICAg
IDQuMzExNzkzXSAgcmV0X2Zyb21fZm9yaysweDEwLzB4MjANCj4gWyAgICA0LjMxNTQwMV0gQ29k
ZTogYmFkIFBDIHZhbHVlDQo+IA0KPiAgIGRyaXZlcnMvZ3Bpby9ncGlvbGliLW9mLmMgfCAxICsN
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwaW8vZ3Bpb2xpYi1vZi5jIGIvZHJpdmVycy9ncGlvL2dwaW9saWItb2YuYw0KPiBp
bmRleCA5NWJlNWYwZDI2MjMuLjBlNGUxMjkxNjA0ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cGlvL2dwaW9saWItb2YuYw0KPiArKysgYi9kcml2ZXJzL2dwaW8vZ3Bpb2xpYi1vZi5jDQo+IEBA
IC00OTgsNiArNDk4LDcgQEAgc3RhdGljIGNvbnN0IG9mX2ZpbmRfZ3Bpb19xdWlyayBvZl9maW5k
X2dwaW9fcXVpcmtzW10gPSB7DQo+ICAgICAgICAgIG9mX2ZpbmRfcmVndWxhdG9yX2dwaW8sDQo+
ICAgICAgICAgIG9mX2ZpbmRfYXJpem9uYV9ncGlvLA0KPiAgICAgICAgICBvZl9maW5kX3VzYl9n
cGlvLA0KPiArICAgICAgIE5VTEwNCj4gICB9Ow0KPiANCj4gICBzdHJ1Y3QgZ3Bpb19kZXNjICpv
Zl9maW5kX2dwaW8oc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFyICpjb25faWQsDQo+IC0t
DQo+IDIuMzAuMg0KPiANCg0K
