Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FC85BA2B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiIOWZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIOWZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:25:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C191572E;
        Thu, 15 Sep 2022 15:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663280731; x=1694816731;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lFt4z0Q1xiyuX0wjh9LfZXob0WqEnyHxaZbNzMGMKSo=;
  b=i0AKZgZNRG0XnUcGWFc81AXGV8mjfv7E9CeLhGRE0uK+uOs1S/T7lDpg
   lz0cOk5TfPVsGfN5iaa9xhbkH2xd7oHFQHdjuTBrR5CfD9jTF1M/h+P3E
   fYjSQZ9q3XynNLOpciTeIqcihFNZ1UD87eFxlP4HCoeNFDmOFQ6WnCRfq
   sSEHx6GIXWU4sSNi0xBXaobWzprgz3ixajNAEqvSbSV0ACVZHXFIyAfDw
   I9QahqMl66rUzNTiai+N5wKoS9wlchV991aJHUgILmQPRKaZwy6GGakvX
   2UEgxT1sMD34LRgSfwucl2u2rX4dwmjQYGySm9NaORnVN4cdI/j9dH0li
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="174107263"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 15:25:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 15:25:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 15 Sep 2022 15:25:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ki/KEVa6K/mF0y7cbpnQvO56k9teGn3miO20KNKjYCDu/fZTS0Y05kawJfzmw1hG/IGkJXaAJymsZkvjmTNNdOEgJc9Ots4umLiiKD02Ec8UK/n4dtwIq6qFvfyFuRHeuKt8sMl/wUjSByjDPFlIBj0NX8heAVIp2MjNMfu8zrfREsii520GjcM16Gns7YQsqdAPFw7Mt8ISevK5109cUJwz0Dd1AtNpN/tAjxjvnRjQ83ux0ykd9XfcQ5NbUOVN0fO8Hw35pIbz6XIPm37pTd34bfoEpwrnTn5JJlqpIp1J5YNKfpRjpWo3I+YQZJ7SuIKnNn4/ZHlPDXuaqUetSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFt4z0Q1xiyuX0wjh9LfZXob0WqEnyHxaZbNzMGMKSo=;
 b=ai/EGIWM4Av8llggiEB/KeEiSJ8wsmM7sqnXF+N9sAf+b55yaNlW1BixIu0ZdjOEipE6WR2eYjR3n3km5q6hobx+Nsm6KzC3VTLgsNXbJ9XiYcR45Yj0BSfgyjnuc3QVpMVBIOhdVcfn9RqrbyxefNluJzSchmSWvWQYGNI2zjUSIYJIEOZtEzOildFicG+83yRT4TiKSGva6D9WwljAp2J6f2bAhuqy0yAhsfRAEBxsEQ5TeR0PvKeJu2uInUlcN7x3oKfWD//E3Yfx7LM8cksKTv6eWLBYc9KxTaculrObn/2ySsn8i2/B9m8AcSWs08MbNcWw47E8pcOzamZ36A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFt4z0Q1xiyuX0wjh9LfZXob0WqEnyHxaZbNzMGMKSo=;
 b=De5mIHqEApsVsCMacEWtF1CV0wtLaJpoFd+adWwywqS9MH5HS8huj6WhzxRs/A0k1oXKoRjr0C34KkouGb2OP//wb8QkkjGOqg8MiMYrm0rp10j3+kg6NZJPNl5ix9gbiP6b1HMg3DI9xQ6jdKmkQEl3H1XCT4wYwotOfPYCXoY=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 22:25:25 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 22:25:25 +0000
From:   <Conor.Dooley@microchip.com>
To:     <prabhakar.csengg@gmail.com>
CC:     <geert+renesas@glider.be>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <heiko@sntech.de>,
        <atishp@rivosinc.com>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 05/10] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC
 kconfig option
Thread-Topic: [PATCH v3 05/10] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC
 kconfig option
Thread-Index: AQHYyS+BB7don9LvSkGu+r2oTiU5/63g+ZKAgAAWGACAAAIQgA==
Date:   Thu, 15 Sep 2022 22:25:25 +0000
Message-ID: <5815ce38-93f2-f6e4-2529-d6927d41ae16@microchip.com>
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220915181558.354737-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <126c611d-b421-cff9-6384-bc468be7ec73@microchip.com>
 <CA+V-a8sv9sFwGktxqkWohQF2FfxyQm=Z5GVNjPW9i2hKxtNWpg@mail.gmail.com>
In-Reply-To: <CA+V-a8sv9sFwGktxqkWohQF2FfxyQm=Z5GVNjPW9i2hKxtNWpg@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|DS0PR11MB6541:EE_
x-ms-office365-filtering-correlation-id: 88b6ac44-6b82-48fe-4be1-08da97692fda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zPT9y1fY/+7LxE/08ACh0fDFsFL0ju+MdJlgAarCxOUpIZoiMWGmA6JB7DIfn5B7Kq+JDJF9lDlaJEiJ+j8v5vw8X/5qUtwAXOe97qfoHMYFdsoiIORYbCPgP7S8d5wnNC1Nyv2YfKUva9UtiI3leRnjSrKqWA9GZ3BUpIi+j/jo125UIVthIxFbPEYi9HB97KkRQ9fQbQatbABIbwrLJ7VSNr95kqdigMRU5Xt6jnLrA71CAkacp4kfzQHhCe83xnPiIM/TKCcJKCUutBxelCLhgRlc2Spnt/r3CpeyAyyCEvuS+hfV01XUxBH9t6syiwYezK9cccN90Sk7bXStqGVC+ayMNyUqPpfH/pMJq4Me2q8ObrJIobA+dl1hzhIXDpyjkghd7zO+qlQYUhbNdMfoRsir1ts0WCw2rdnRLeQAFgcFHCd08uqEOBGO//PHPfpdhslzEO9YMRuELmq9dDkUSrE71TLBi/lZjy0HD5XgZSUVPM4VmLl5R39WlJTiaijKmIV1zVX7kzQ1hbowZBrBEXjkXD6LPlAeQQiamzNLQcf3wx4h3SMYwZsP5amPaBltp7rIFsWKu0JTmmK94knfodLlrkN2b2TYaJPKx5S0x0wI0q9KIR9nZUQVaQS5LhhB6p/muKLCfxCwt9Y2vzDBdAp7eywhowxx9cjgYhSbUERZHHOJsSvXCl5+mWwT6bUcmlg0C42CD31HoZIuueJ7k2SQXyGJKLg2osmO+Wx0ESyNOQv64BPWvVLwC5iQusgYLlVj3bDLTF+VCpnq3nF/pia5ieoCYEoc9IN50kICsGeGevJrB9o+YrTmXf8Wjq7Ir/mDbl5Nf60LdiBDKYkXTjzkBdgeWyqLcTOGMi1+G8g8UUB5atrwdAoqvzjx66OW82E6LkH1/7k+8e8MPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(478600001)(31696002)(36756003)(4326008)(31686004)(66556008)(316002)(41300700001)(5660300002)(86362001)(38100700002)(76116006)(71200400001)(2616005)(66946007)(66476007)(2906002)(6506007)(122000001)(6486002)(91956017)(8936002)(6512007)(64756008)(7416002)(8676002)(66446008)(38070700005)(186003)(53546011)(54906003)(26005)(966005)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTJFbW5TdFYrblZoUDlJZ0pYTGZHNUZWVWFZa2pCaUlkM05KZWcyeVZqSi9z?=
 =?utf-8?B?Y3RBSzRZYVpscTltQllUSXlSd3VIU3U0UHdLWTJCTEs2WnNPZENuN0wwUXM3?=
 =?utf-8?B?VFcwS1lvcjdrVXBrZjNmWDZ4Z1lGdnlFdVo1eFIvMGViVEd1VGNEdVBZM0g4?=
 =?utf-8?B?Ump0RDY1Z3l3RFgzRGFtN0l0eUVHc1I0QVpKdFQzWkNFNXlDMEYvbkpkY3pZ?=
 =?utf-8?B?a1ZJN3ExYi9RVU1jdTdKayt0MVJLR25xVjdhTlRpZHlFNmZaVXZnSTVwMVRF?=
 =?utf-8?B?VXRIQ2VuOElRUC9OYW5vMm54MHRBK3dhVWxoekpUUG0xN1FYUHBCamRITkZT?=
 =?utf-8?B?Z1N5M1JEeEFReVhtdnFtTHlyTmhFZUFjM3dZcDJ3eG9kRmNmUVY2WkJGNGwx?=
 =?utf-8?B?dU5SR3YveVd4cGpCNXpUbmZDUTRJeGFvL1ZSUTN3cklDZXdsektLN0xId2hF?=
 =?utf-8?B?cnIzTHFEVlN1WEs5Y1JTV3dIN05zMFl5dE9yUjNnNDUxN21pN25obkZSZjJk?=
 =?utf-8?B?K0d5dkZCWFB1ZUgyM0tZRys2ZE1Xcm9aSGNHWTJKQnlOMmFhdllRRnk3bjZi?=
 =?utf-8?B?YlI1aXQ5WmtOU1VxcXRhbFBITFdQcm1WZjJiM2hFdDdJT0l0Vkc0aFJFNVVI?=
 =?utf-8?B?OGZDMTQvdC9Cc2l0NUIveG9qc2lVUlNYQm1Xb3ZHZy81dlRoQWI2NjEvMUhM?=
 =?utf-8?B?ZEZKclNYZVQ3RUZnK0dhZ0h5MUM4MDlTc3BkKzdkd3AyTmVLNjdzYVd0VC95?=
 =?utf-8?B?bnc3dHYrNDhaVTUvZlplaEZuQVltUllJRk5tUnNCeDdkNEJNMVM5ZzZQT2Zu?=
 =?utf-8?B?SHk3NkszL2hSNkUyNEw2dDFEYWhGV2NreUVtc21OeCt5MWRkekRYSDN1QnBu?=
 =?utf-8?B?TTZCREtrTmlGby9KclhtbzJ5VFkwcG8xZ0ZtYng4R1lWRUdTeHJiL01hZS80?=
 =?utf-8?B?U2ordHAwYm5QQ1NqVUUzajNMcHBpTjlaSGJOMk9uT2pSRDJsVG1PbXJIcERz?=
 =?utf-8?B?ZVhJSTlHcnUxa2VIcmQ0WktNcFhtQVdNQ3lKNnhXWVRYMXJWSWFGNE9uN29p?=
 =?utf-8?B?aHAyajhvVGxxZG10RWFZNHBJWGhJcnl1Z3hsVlVWYW9qU1pvbHBDc1MxbGNF?=
 =?utf-8?B?cXFRZStZMGFxNGJ2elZqWDcxQUhINHF4Z1lJS29xa2ZUTnNtNmFuRUwrbXFM?=
 =?utf-8?B?MFM5TG52WW1VK0RFWlpkLzBwYWNoTlRob0grajFIV0hTZm5rOFVSMHNHSzZF?=
 =?utf-8?B?S1h1dWFBZWV1NDdBaENTRE9sbVRVeVVDV2V4blczSmQvMTFid3ZscXZNNWhO?=
 =?utf-8?B?SWdkdlhVQkdYTEdIWk16NFBiY1kvL3ZGOEJ5enNDTzlhTVJwelBDNHpxTEhK?=
 =?utf-8?B?b1FaMVBsZzk3RE9QV1N0MFlibUpXR1J6QTNPSDVjSEFnVEJ2NzZ5YXFqNUQ4?=
 =?utf-8?B?NFdkb2NTVXVYQ1pUbkZrSUtCR1FVSG9GSzFIUmRKQmM2OVVubllRNXB2anJC?=
 =?utf-8?B?WmU3cGlLME51NGtlbS9HbThTYTRXZHpmaCtrM29FZUhQVmVlR0xicTZoOE1B?=
 =?utf-8?B?V29CaTBtakE1ZGU5dmFhNTFqUHp1blZGQXk4UmN3YmJ0K0g1YVlXNHU5VHZQ?=
 =?utf-8?B?cStIcm5Qai8xUDYwTStncGNwWU4xMnNJY3BEeGhwZkxrb2JteWxrZExndHN3?=
 =?utf-8?B?c25rVENjS2FlUzRldHBSS2t0dHkyaUxLTmRYV0V5Vkc3dERhUFB6MmFRaHNU?=
 =?utf-8?B?M2VzR1ppa0VZeU5JNjhINEp0cklnanhjMVZvQ3hZQ2V2bE83aFNIcjl2bXpv?=
 =?utf-8?B?NDMxM0hiQWxrTUoyTmxBM29lSTlGU3NYbk5LaUNReExlOWxBM1BsV1NtRWFp?=
 =?utf-8?B?dk5LdDRMMDdQZW42a3Rwa3ZNQ05qbTdDWFBwakJZaG5OeXAyM05CSnBWRUdH?=
 =?utf-8?B?c1pDOWRkVks4KzVVUTZEaXJsejdoTnk4Z1pYdElub25oMXU2c1dXck5IdUFP?=
 =?utf-8?B?SzBuclJ1TWVIMlNiQlZWRjVybi9JdUI5MVd5NWRnempuODFPTDZMRGE4V0xt?=
 =?utf-8?B?MzBHVGZYcHB2Vm1vVlpCV0kyTTgxRnE4RG1qMzJCbStYMXhEL2oyVGlDRUh6?=
 =?utf-8?B?aHJsU2NRTFpLZHpYeVp6RG5oWmtKT0JEemc5Ni9rRitMYk1HdjRZOWV6dmwv?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F6ECA28F19B7A42A849EF38D478B7F1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b6ac44-6b82-48fe-4be1-08da97692fda
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 22:25:25.6229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qePXKdeWbF79Gzw6fQ+8HjYxJHytf9F0Wvh1TTXPQVGqh/gsf+M76mRLj3fjWQiOmjq4gMevfVvylPPAke4r7HgemY2tDOuHrhHSiAJCGQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6541
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE1LzA5LzIwMjIgMjM6MTgsIExhZCwgUHJhYmhha2FyIHdyb3RlOg0KPiBIaSBDb25v
ciwNCj4gDQo+IFRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCj4gDQo+IE9uIFRodSwgU2VwIDE1
LCAyMDIyIGF0IDk6NTkgUE0gPENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4+
DQo+PiBPbiAxNS8wOS8yMDIyIDE5OjE1LCBQcmFiaGFrYXIgd3JvdGU6DQo+Pj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4NCj4+PiBGcm9tOiBMYWQgUHJhYmhha2FyIDxw
cmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+Pj4NCj4+PiBJbnRyb2R1
Y2UgU09DX1JFTkVTQVNfUlpGSVZFIGNvbmZpZyBvcHRpb24gdG8gZW5hYmxlIFJlbmVzYXMgUlov
Rml2ZQ0KPj4+IChSOUEwN0cwNDMpIFNvQywgYWxvbmcgc2lkZSBhbHNvIGFkZCBBUkNIX1JFTkVT
QVMgY29uZmlnIG9wdGlvbiBhcyBtb3N0DQo+Pj4gb2YgdGhlIFJlbmVzYXMgZHJpdmVycyBkZXBl
bmQgb24gdGhpcyBjb25maWcgb3B0aW9uLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTGFkIFBy
YWJoYWthciA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPj4+IFJl
dmlld2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0K
Pj4+IC0tLQ0KPj4+IHYyLT52Mw0KPj4+ICogSW5jbHVkZWQgUkIgdGFnIGZyb20gR2VlcnQNCj4+
Pg0KPj4+IHYxLT52Mg0KPj4+ICogTm8gQ2hhbmdlDQo+Pj4gLS0tDQo+Pj4gIGFyY2gvcmlzY3Yv
S2NvbmZpZy5zb2NzIHwgMTQgKysrKysrKysrKysrKysNCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDE0
IGluc2VydGlvbnMoKykNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L0tjb25maWcu
c29jcyBiL2FyY2gvcmlzY3YvS2NvbmZpZy5zb2NzDQo+Pj4gaW5kZXggNjk3NzRiYjM2MmQ2Li45
MWI3ZjM4Yjc3YTggMTAwNjQ0DQo+Pj4gLS0tIGEvYXJjaC9yaXNjdi9LY29uZmlnLnNvY3MNCj4+
PiArKysgYi9hcmNoL3Jpc2N2L0tjb25maWcuc29jcw0KPj4+IEBAIC04MCw0ICs4MCwxOCBAQCBj
b25maWcgU09DX0NBTkFBTl9LMjEwX0RUQl9TT1VSQ0UNCj4+Pg0KPj4+ICBlbmRpZiAjIFNPQ19D
QU5BQU4NCj4+Pg0KPj4+ICtjb25maWcgQVJDSF9SRU5FU0FTDQo+Pj4gKyAgICAgICBib29sDQo+
Pj4gKyAgICAgICBzZWxlY3QgR1BJT0xJQg0KPj4+ICsgICAgICAgc2VsZWN0IFBJTkNUUkwNCj4+
PiArICAgICAgIHNlbGVjdCBTT0NfQlVTDQo+Pg0KPj4gRG8geW91IHJlYWxseSBuZWVkIHRvIHNl
bGVjdCBTT0NfQlVTPw0KPj4gTm9vbmUgZWxzZSBkb2VzIG9uIFJJU0MtViwgaGVuY2UgbXkgY3Vy
aW9zaXR5Lg0KPj4NCj4gWWVzIHdlIGRvIG5lZWQgU09DX0JVUyBkdWUgdG8gc29jX2RldmljZV9y
ZWdpc3RlcigpIGNhbGwgaW4gWzBdLg0KPiBEaWdnaW5nIGZ1cnRoZXIgSSByZWFsaXplZCB3ZSBj
YW4gZHJvcCB0aGUgYWJvdmUgU09DX0JVUyBhcw0KPiBTT0NfUkVORVNBUyBpcyBzZWxlY3Rpbmcg
U09DX0JVUyBbMV0NCj4gDQo+IFswXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL3NvYy9yZW5lc2Fz
L3JlbmVzYXMtc29jLmM/aD12Ni4wLXJjNSNuNDg3DQo+IFsxXSBodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2
ZXJzL3NvYy9yZW5lc2FzL0tjb25maWc/aD12Ni4wLXJjNSNuNQ0KPiANCj4+PiArDQo+Pj4gK2Nv
bmZpZyBTT0NfUkVORVNBU19SWkZJVkUNCj4+PiArICAgICAgIGJvb2wgIlJlbmVzYXMgUlovRml2
ZSBTb0MiDQo+Pj4gKyAgICAgICBzZWxlY3QgQVJDSF9SOUEwN0cwNDMNCj4+PiArICAgICAgIHNl
bGVjdCBBUkNIX1JFTkVTQVMNCj4+PiArICAgICAgIHNlbGVjdCBSRVNFVF9DT05UUk9MTEVSDQo+
Pj4gKyAgICAgICBoZWxwDQo+Pj4gKyAgICAgICAgIFRoaXMgZW5hYmxlcyBzdXBwb3J0IGZvciBS
ZW5lc2FzIFJaL0ZpdmUgU29DLg0KPj4NCj4+IDp0aGlua2luZzogaXNuJ3QgdGhpcyBwcmV0dHkg
bXVjaCB3aGF0IHdlIGRlY2lkZWQgbm90IHRvIGRvPw0KPj4gQW5kIGluc3RlYWQgeW91IHdvdWxk
IHJlZGVmaW5lIEFSQ0hfUkVORVNBUyBpbiB0aGlzIGZpbGUgYW5kDQo+PiBub3QgdXNlIFNPQ19S
RU5FU0FTKiBhdCBhbGw/IFdpbGwgc2F2ZSBtZSBoYXZpbmcgdG8gcHVyZ2UgdGhlDQo+PiB0aGUg
U09DIHN5bWJvbCB3aGVuIEkgZG8gdGhlIGNvbnZlcnNpb24uDQo+Pg0KPiBJIHdhcyB1bmRlciB0
aGUgaW1wcmVzc2lvbiB3ZSBkaWRuJ3QgY29tZSB0byBhIGNvbmNsdXNpb24gc28ga2VwdCB0aGUN
Cg0KTWlnaHQndmUgYmVlbiBhIGdvb2QgaWRlYSBpZiBJIGRpZCBhIHN1bW1hcnkgYXMgSSBmaW5p
c2hlZC4uDQpJIGd1ZXNzIEknbGwgcG9zdCBvbmUgdG8gdGhlIGxpc3QgdG9tb3Jyb3cgaWYgSSBy
ZW1lbWJlci4NCg0KPiBwYXRjaCBhcyBpcy4gSSdsbCBqdXN0IG1ha2UgQVJDSF9SRU5FU0FTIHZp
c2libGUgYXMgR2VlcnQgc3VnZ2VzdGVkDQo+IHNvbWV0aGluZyBsaWtlIGJlbG93Og0KPiANCj4g
ICAgICAgICBjb25maWcgQVJDSF9SRU5FU0FTDQo+ICAgICAgICAgICAgIGJvb2wgIlJlbmVzYXMg
UklTQy1WIFNvQ3MiDQo+ICAgICAgICAgICAgIHNlbGVjdCBHUElPTElCDQo+ICAgICAgICAgICAg
IHNlbGVjdCBQSU5DVFJMDQo+ICAgICAgICAgICAgIHNlbGVjdCBSRVNFVF9DT05UUk9MTEVSDQo+
IA0KPiANCj4gQ2hlZXJzLA0KPiBQcmFiaGFrYXINCg==
