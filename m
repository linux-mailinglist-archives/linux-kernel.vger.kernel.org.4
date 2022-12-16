Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846E564E8BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 10:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiLPJkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 04:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLPJkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 04:40:06 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEC23F06B;
        Fri, 16 Dec 2022 01:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671183606; x=1702719606;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=TEJgitX/Ew8PNrhrrr+Ch3GmvKBphPa9fBqb0djvd9c=;
  b=xhK1DvkZmWgUed1uM5l253BuzulsFGtP3kNlidUjIeZkmF1vBNp2WPc+
   zLO39dQ7oqqM2+TVAPdSHCvI/FssIQGJIjllOMaCNDjBQTqzjmtbexiOK
   7kaxYqcjsi3qC3PR36FsNR6Y4Q7xobZmvT8ZhXpQJBA8WmDJwksA0Q5mn
   Gp0n2Sej+ByfJ3kiwq4iQkKwqHL1JBREexKlLqrGDI8/8b1O7OBLhy8DA
   AU6GTH/iR44sIeO9raUpQPMMBNISegyhm3DW8+kdvAZawUsxD2XbdNdHA
   CRK8gSDKeh4HS5bkcShKGncutRlVctxPg67u+d5NAHyrHIMdn2RycBl/u
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="193351368"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2022 02:40:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 02:40:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 02:40:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAgglL0j+16CP8rEC0cSWrw0EEn7HtbRAe8GiK4JZR9dZuP8ckco58yqWWgXbebeI5n4H4drqnxtaprZMvuNHpQ/hGjR0g0EWp1OIWEDSKnfD7mv9M3NSv4UapF5VS2iCKn8T7Uec9xdDWQe82H5NFYRyP1huKL3EwEy3AyfoY5wG8VDI1hovbtpz86GM+AMGJpH1ewd9XAB/hWQs9zGnOj2MvWXRb9xJ6/TQ80b0inT7kzL7jbok0Wnm+KNeMrn5XeumAFXk2M09x2zanUH3F5znNz37loc2o05yzMewyNOySFyi8Ky/EsRWhSDlNGIzBTTtJkXq3Jkmyyi4if5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEJgitX/Ew8PNrhrrr+Ch3GmvKBphPa9fBqb0djvd9c=;
 b=HVubXQwQcUlB6XoMwevK22OKWqhFcVcOxz/BXysC/Z7PswJqNSMcnrUUT2uFSCPddRlGZevuzT7O1NEtpBRTpzFEbIJH34fvxUXX1QBnXAHo/U2dZpt7W+F4CO0v5CkAZWeHcSRTLZScu6qAS8Nekl3wBsPmqtARhn4q1ajyop0HeQYpyWcHXaaGPNy8KDcH+s/A01IbiFORKKgtJgjULv8Tp4tzp4926/wm7oSq8ieO8J64VgDMntOV2j6eyJp605MmLXf+rTzmwKNEXNAD+tYw6jyPRPUZTPEQzQ1IEgZB6UaL2efg7V1LvK8xTCnK3gF6ETW1fffqpWMuOJLZYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEJgitX/Ew8PNrhrrr+Ch3GmvKBphPa9fBqb0djvd9c=;
 b=M5CF0z8wpbKuvgiZ0DzxjR8CTTS3m+xl9YbAh4WackdYW5Ke+MCE0+0M6F7IsRxGoDLqi919iPbRF7gLkjp+1/nSxZyUKXkositQVKLPJUciCLySUsF8UhMN1vvRL8IS6EWjsCEv+Qtmutotfq6RPdvKvFF1ijZOuGIa4z+3hTU=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by MN0PR11MB6280.namprd11.prod.outlook.com (2603:10b6:208:3c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 09:40:03 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::108f:e428:de3e:8baf]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::108f:e428:de3e:8baf%3]) with mapi id 15.20.5924.015; Fri, 16 Dec 2022
 09:40:03 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Durai.ManickamKR@microchip.com>, <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Manikandan.M@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Dharma.B@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <krzysztof.kozlowski@linaro.org>,
        <alexandre.belloni@bootlin.com>, <davem@davemloft.net>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <Horatiu.Vultur@microchip.com>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <michael@walle.cc>, <Jerry.Ray@microchip.com>
Subject: Re: [PATCH v3 4/8] ARM: dts: at91: sam9x60: Specify the FIFO size for
 the Flexcom UART
Thread-Topic: [PATCH v3 4/8] ARM: dts: at91: sam9x60: Specify the FIFO size
 for the Flexcom UART
Thread-Index: AQHZETJf93v2Fr1gp0Ou6+4OHfjwhA==
Date:   Fri, 16 Dec 2022 09:40:02 +0000
Message-ID: <dca2246c-3dbb-684a-6bfc-7e81d2eeeb6c@microchip.com>
References: <20221213120655.672666-1-durai.manickamkr@microchip.com>
 <20221213120655.672666-5-durai.manickamkr@microchip.com>
In-Reply-To: <20221213120655.672666-5-durai.manickamkr@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|MN0PR11MB6280:EE_
x-ms-office365-filtering-correlation-id: 53d1732a-fbcd-4987-4c9b-08dadf4981cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E8o9GkT9evIXy40ULlZJN39K8evzn3odL/DtIsLBO8ulU59v7UTy9cv8Rb/tiOZ/hcqFVn+nV477lhNPyrHzmnbdcGLleGpX4+1cD/E+ZG5QLWhUW0YfFwQRLf35DMucVNR1DRfXo2wkig0X9qw5LNg5zQmDbrnJxzk4WhvSGu6QZFFGNJClw16LefA+TuxGSDKqx7FHyrgH8aHCDCnZ8gTanVeIGnZ4OuiLtj0E5WJonW44PbW7TadGY2dih1KqiHfWUC7oo3IpB/CX+LCpLCpkiR+s/XlwGIY1DrQ3JcIrPntdM+hz3R/uETV34Av2DYicqc8Mv8S8mwMeGYOfLVUYlk/Kt5pBpAy+KZgQUtJzzvVaZuLqp1VyGLLZCXx+6q1EZUJzGJ5gRfTSJLxM52pvXEnxurfpEYL1e9SgqEAnH6jPJ5nb8DpyKO6X2SG3tUrVVfVUS1nqQwaaSEQaEZkdIzrfq03bL1XqRuOOuKiMVCoQUlVjuhEeIKLlzMlRTVRflq2v7dp82IKPBu3C1dEq4Y+shhy/HR8xdsQDecXnBacNp6c3wjz3o6/TA/bYkBzRXL5QxmAgvLsFYkvSGWqZ65bVgg5q/7sxcVy/V+18fU8ELMQkfloSe3A7G0swhuBu4JUhk0nxD8RAgnMHt0g5o2t1/UDaQmXc5ke1JVKdOzG7e87GmuyvICCOH+TXW6Bjcqe+EMC5VvjOGq7OJofcOf83xwW0WaNDQWhhhj26v0ouKIsg3WApcio6TDNv5kbav5nNxnkxRf5qqz1WczlJrb+eabHzM58bxUqY6kA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199015)(64756008)(2616005)(66556008)(66946007)(2906002)(66446008)(76116006)(66476007)(36756003)(41300700001)(7416002)(5660300002)(4744005)(83380400001)(8676002)(8936002)(38070700005)(31696002)(86362001)(921005)(122000001)(316002)(478600001)(38100700002)(6512007)(110136005)(6636002)(26005)(186003)(53546011)(6506007)(6486002)(31686004)(71200400001)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWduMjJrN1A5ZnBIdEJXOTRwNmcwOHQrZWcvUnlvbUlERkd1Um41Zy9ldDd2?=
 =?utf-8?B?OXRnRk1LZ3ZwcXZuZUR6MStUSXd6UGNoODNXT0hLRWtVZmgwM3BoQnNSWWVr?=
 =?utf-8?B?OGVPSFhEbjVvb2RGQnhKK0I3ajFEUW1OQXdMYW5CS3hvdWlXSGpWMjh4MENH?=
 =?utf-8?B?R3FCMkphU1V1U0Z2MXpiVzNlT2xOamR6WkkzMWVrNEFuR3RMNnpBN25NYkw5?=
 =?utf-8?B?ZlNWYWdvKzQ0bWVwSkNFTVlOOE9wZEFwYmxFdk9vZjM5RG5vbHBqdXBNTXZZ?=
 =?utf-8?B?cDloOGtYbVJEQjZ2WHdNUEd6cmtqeUZYWVphbzJReU5pZjcrdXZCUVpmV0xP?=
 =?utf-8?B?L3NtNGcxM01selpKZy9lS1VOTVhZcXhHSlJHcTJJK1J5YW4yYzNEbkJ2enlQ?=
 =?utf-8?B?OVptSEkwSGJOamlPOWkyYnZHMVRxVGVZTnlRTmlKeWNXUEdMSXU1VTM2dHFB?=
 =?utf-8?B?a0sxTDJwN1NXaklXcXZrWm90NWl1T3JjYlJLZ3dpM2cwUllRRk1BWEMrODRp?=
 =?utf-8?B?UzhGc0kvbTNQRGJtVFN2dkxzcERQeFJmenRLcTJaZ29NRmVlaVVmS01Scjg0?=
 =?utf-8?B?SkNFcTN0QjdsemVPRXp5cElDbGZHVjVwaUxVb2tFYW0ySmh5SUo0Y2ZOZmtt?=
 =?utf-8?B?RjlCd1FvZG5iQ3ByWHdyaHZBVlFQc0JtTTRaUTRMcDQ5NDlFRXFuME9FRnYv?=
 =?utf-8?B?Lzd3ZEsxYnlRZThyMlpMckZ2RitvbzdWclVnTkJIekJHa0pYS0pJaUdPcDhC?=
 =?utf-8?B?NDJXZmhzREhSZ0EvTjE4TmlueG1RcHZKR1J2all6ZVluVi9WMkxwRjh0eC9O?=
 =?utf-8?B?YmpQN2hFYnVFTFkzSUxSUkt0RmlicTNtaHByeXF2REVnYUVieEJUaGcyV2c2?=
 =?utf-8?B?YUhPTHhuVUNKV2gyQnRqU2tsM0h3Z08wSjJxZ1U4TFZaUE8vRi91UGtxTEhB?=
 =?utf-8?B?Wjd5bnNyVlJEWm5iSlFGTnJkK0JzZWswSTU5VElqbDZFcmtONmhrUEtQL29U?=
 =?utf-8?B?ZVZGSkF1ZnhOZ1JjQm9UeFB4K3N5clEzRG40cCtQdnVnMXp6QVQyeEQ0K24x?=
 =?utf-8?B?RGp3b211K3dtdnNZMUszNDF6SFJ3aS9Rb3VzRmlzc2c1dFdSTzVub2NMSUJF?=
 =?utf-8?B?WXpHU0FaZzd4bWE1RTRZT2Nna2piOVBsTDI5YnkvemVUVHpSZDNYMWRJU2c4?=
 =?utf-8?B?VWU1WTdRNTloRVA3Wmo5bEZNZmdJb1RNVGtISGNmdTNMSCtIcmszQkk1Vno0?=
 =?utf-8?B?dHBWUmk3NWMwWFAyM3h0Y0xqSXc0MHlKcWZCZVF0UnZ4cDhjeVVJZzZReVlB?=
 =?utf-8?B?b3dRWklSUm8zRUJtbVhCRzFhSzBJOWxKV2hJbFdSRmFCbGJ1ckhVTCtlUE1s?=
 =?utf-8?B?ZGN1YTh0ZkRnVC9qSDdHUnpjRUtnWnNYb1BkMVdVNmZ1S3lvakhKQ000dk82?=
 =?utf-8?B?cGpUYXJlbTdSZ08wQWtSS2Uxek9NdlNNQ0x3VFo5YmdPaXJ3MWswM2l3UElm?=
 =?utf-8?B?L1NIQnN1VTk5MEN4WjJDblVnV2M1SjBqend5TnBKZ1A5bFIzZ0hrRXMxam11?=
 =?utf-8?B?dGtkZ3p6ZmpoS21lZWRHam9Pc2dwR1FEY1Q0T0tjLy9oWmROeDloekdSTU81?=
 =?utf-8?B?cXdGTGtpemR5U2pVcWJuaHl4d0ZJaW1WaUt2OUpHdzRJQW9EREoxa2JUYkZt?=
 =?utf-8?B?SzJnNjRGam1mMW5vYW9acnUweDNhQ0I3UWFNclIxY2FPelJJbFMrQjAxQXRZ?=
 =?utf-8?B?NmM1WXlqUVF4aFVPQWpseHI0dUpvdXMzV0o3TFo2QTQvTFM1WUkzWjA0M0JT?=
 =?utf-8?B?Yk1ST3dPb1Foa1prb2VDUHROUjI4MWZBbXVnYWNDT2ZzS1E2bVE4czBEZVFH?=
 =?utf-8?B?d25VeUdvMXhpVnZpdkcrMDdRc1p1OFVHTjQ3YTE1RDVIK3ZlNWtUbG9BRjdq?=
 =?utf-8?B?MlU4b3JMdU1wRkFKOUVSd29ycC80c01IcUNiR1BwdTdUc1FFMDBEUmFnZHMx?=
 =?utf-8?B?cXhHYmNSS3JVZ0kxWGxyRWRrYlREVXFBQ2M5TXptVHorUjd4QXlscmthUERL?=
 =?utf-8?B?SExhUWNlRy91SGwrdEJ2Yks3ZlU3MVk4Y1VZUWRFTldwVjZ2dE9XKzhkdW5W?=
 =?utf-8?B?SzdkWGZneGZyU3BJRGNyclAzMHdFbmxrTkI1azVIV3lsZnljZVBKZnI3MExN?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86A3855976C76B4BAF733C76FC5C4DC0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d1732a-fbcd-4987-4c9b-08dadf4981cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 09:40:02.9446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TSVw+Da5gTO5NghmnhzwZiXuARgMmvAnRMPSL4iJlS3Nz8D/ndoXZDxULJMl3bBRtG06rAjFvwpA6Brs2DsaX7vZBo55rJbauEp+CzTgU3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6280
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMuMTIuMjAyMiAxNDowNiwgRHVyYWkgTWFuaWNrYW0gS1Igd3JvdGU6DQo+IEZyb206IE1h
bmlrYW5kYW4gTXVyYWxpZGhhcmFuIDxtYW5pa2FuZGFuLm1AbWljcm9jaGlwLmNvbT4NCj4gDQo+
IFRoZSBVQVJUIHN1Ym1vZHVsZSBpbiBGbGV4Y29tIGhhcyAxNi1ieXRlIFRyYW5zbWl0IGFuZCBS
ZWNlaXZlIEZJRk9zLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFuaWthbmRhbiBNdXJhbGlkaGFy
YW4gPG1hbmlrYW5kYW4ubUBtaWNyb2NoaXAuY29tPg0KDQp5b3VyIHNvYiBzaG91bGQgZ28gaGVy
ZS4NCg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRzaSB8IDEgKw0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vYm9vdC9kdHMvc2FtOXg2MC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2FtOXg2MC5kdHNp
DQo+IGluZGV4IDlhNWRjZjhhMmI3NC4uOTRjYmYyYWVjOTE4IDEwMDY0NA0KPiAtLS0gYS9hcmNo
L2FybS9ib290L2R0cy9zYW05eDYwLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvc2Ft
OXg2MC5kdHNpDQo+IEBAIC0yMDgsNiArMjA4LDcgQEAgQVQ5MV9YRE1BQ19EVF9QRVJfSUYoMSkg
fA0KPiAgCQkJCQljbG9jay1uYW1lcyA9ICJ1c2FydCI7DQo+ICAJCQkJCWF0bWVsLHVzZS1kbWEt
cng7DQo+ICAJCQkJCWF0bWVsLHVzZS1kbWEtdHg7DQo+ICsJCQkJCWF0bWVsLGZpZm8tc2l6ZSA9
IDwxNj47DQo+ICAJCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICAJCQkJfTsNCj4gIAkJCX07
DQoNCg==
