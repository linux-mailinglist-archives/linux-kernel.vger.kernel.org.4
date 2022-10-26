Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A3F60DF51
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiJZLMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbiJZLMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:12:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9973E31218;
        Wed, 26 Oct 2022 04:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666782759; x=1698318759;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QdbdofheawQDzrH0+IcNfPAhZenqwUqlTXlLqGG4tSE=;
  b=udMaRPtBH75Jq/e1Qrx6LW/Xv7H7811T18lzlD903QKDeeMWybcWS2QN
   nI42e3befrT37PvrfdukYUICvqG5M/EmG8SWY/+pxvy1b6Yo6xS1X7CsH
   A230WN0gu4ZeTUx/pDsIpH0ylpNbZS7hIWS9cM2jIvnBQf4D4VKCu7P8u
   d5ZDRBtqOMu3uru5LTVOZERqRHUygnEcThPv0X9KKOW7KyAlRrx/F289G
   M+6JOVO7gRyoA3t/66OW4xHUN8uGWSlmAVTo7mBaU31xqqtUuoY2dd3q7
   iLwY2m6uxb7s+yIlMV1BhtXyCDZzYAGh9pq9AEP1YwwrmmGPBz2msk/UB
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="120419923"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Oct 2022 04:12:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 26 Oct 2022 04:12:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 26 Oct 2022 04:12:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3L+9slwcbVVNm2N8orbw0tZ1Y8casyFS964CcI4Zd+eZhzStM/XT/i04TpQoUNAxEO0rhfmPpfpmzmi6QmClPYsFWJhArf0+kqaZo2GNCvECGM8b/EzWeWBv8O4NzvpfaNYFO3Eqmrz6kXCee9UixCm9A/tOcMBKJcxNZpRAgLoUqMJKYk3m/6NlH7oRtxEs75oMFYSxKLWYGr7gxu4GzQgAbFvi2luV6OXhtxwTqvS0b1Kzl5opJbGRiXVmp6QHLPuvB1AU52tkRcqww8CfxOmOVQwlry30kmVF7ZLEUO81Xz4baSgKthecjkj9QtHSj0Ry5MTjL+pLa/8YFKi0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdbdofheawQDzrH0+IcNfPAhZenqwUqlTXlLqGG4tSE=;
 b=A+R20le2/BzoT08MwVwrpE3Js0LtePq8U9SXLxCkLHF93cV/1XHKL8iR4Zjl1+irJLOUIUNKHOKdOWZhabou1skRGZgVEa/SFV0OsOT9if6PLzLdP8x7V3MOnIH6tkXTy280KOlpGJBQS4sRESTXmimS86e4YLC7N58rKYdS68kw8/hqxYOt/F/esbgO36KAIOAGnpRfPHLEj3VTEXNc91ue8puvJ8J2q13yKUU6eY/Lj37P0idFVzP5a+FbVJtVHvqMl2/V+r2kVu7vOjCLhZecRfBdulY8Cx22pvwf6svd3lYeJrEIRX3qHP7hxeaBgJG2JU60dUgbPnZCXvNIJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdbdofheawQDzrH0+IcNfPAhZenqwUqlTXlLqGG4tSE=;
 b=X1Mylafz4fkWYcJVYk0rNk+vQXYrRfW/GiVQ4n53RllCuxLP90bA3z6hOLS0l22SWOoHbSd8VHsK1OiV1rJQcw8zipoog7/XMdDFxI5Eq14rV0rfcDOJtKlbhynwY+Eir0JEGJnDBHD9kksZjCTZauodLFV6t3Lxi6izDFB2JtM=
Received: from PH0PR11MB5096.namprd11.prod.outlook.com (2603:10b6:510:3c::5)
 by DS0PR11MB6349.namprd11.prod.outlook.com (2603:10b6:8:ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 11:12:27 +0000
Received: from PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::9689:f094:d23a:ad9e]) by PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::9689:f094:d23a:ad9e%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 11:12:27 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <jk@ozlabs.org>, <christophe.jaillet@wanadoo.fr>,
        <Kumaravel.Thiagarajan@microchip.com>,
        <gregkh@linuxfoundation.org>, <ilpo.jarvinen@linux.intel.com>,
        <wander@redhat.com>, <u.kleine-koenig@pengutronix.de>,
        <etremblay@distech-controls.com>, <macro@orcam.me.uk>,
        <jirislaby@kernel.org>, <johan@kernel.org>,
        <andy.shevchenko@gmail.com>, <geert+renesas@glider.be>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v2 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver for
 quad-uart support.
Thread-Topic: [PATCH v2 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver
 for quad-uart support.
Thread-Index: AQHY1V1ECgbqKV8AiUiKZBGdoHOFW639FD4AgCOZNQA=
Date:   Wed, 26 Oct 2022 11:12:27 +0000
Message-ID: <c9c19aebb2bf28bad7e98c4d8365ea81ec58bc08.camel@microchip.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
         <20221001061507.3508603-2-kumaravel.thiagarajan@microchip.com>
         <676c5723-a9b7-9f28-fbb4-27a5c6f6145b@wanadoo.fr>
In-Reply-To: <676c5723-a9b7-9f28-fbb4-27a5c6f6145b@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5096:EE_|DS0PR11MB6349:EE_
x-ms-office365-filtering-correlation-id: e8522b10-ddaf-46b1-09db-08dab742f795
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SFhG5T1slEsZ54YevZwFwd7nLdlEFLwXicjBz7pBAZmAGZuYkpJvd+pQa4oXytIiAyHkwhKZkZGSSWIAnJ+7Y1jpIev38qO64TCwiV/1Uc4AjnfvNiEcb71xlOqqz8S8f6Iozn/rwN3Z/u2Q8FZcnSDChI/qov48EC2Z+6/wOKOclyizM3Jk/R3W4MamQRepyHjFB4VSA7QJUvy+56LGVPX3ixH5WmyMUYRfPFvhoGhJZpFUo3oZUYrcmiTzn5m0/LSgGdlDzHwhkmQvjoGbv2fBnumjZc+8iz6r/JEpnhKns9XC+l7eCXL/YICZaLw1Xi7mkjCqGGydgGtt5aIVkiDBYrJyYNMwnrFpVHRbBP17nsdYm1TkuL4DCOzs8Xn7t6uvS+D66JvgfM5ewCefyqT+ZRHXG3DIBAnt9dN8qQj+a5qh+9EJ5qMifI7lWi69IlUos8SfjN/8+eewdxCbO4PCinoMzTE3xXnVqDIAc7nxYuRIzdTXTrb8HTwkgvKweZoi+Ov0u7D/rPhSgRMtF1nHsrKmkWwEEOsgaMNPfwoAgJSmrw7GFe9bwr4UpCdOI0TfEOrS0dLYM8VO/px+4LBgQ0zpyIeX1LNO33pzNnio0YJwwNwLEd2+kwCzaTAaEtIjxyz/uv/O0slN1qeLgDj0XGuYO+ja92bdMx8+qjy1HS9eFh1xuceNgO9igQ02nJwVU7hzZKNGJXs9cF4EXP4v6+k+fsy1BXREIvOB7N6e8lEnLtzcQIP4e1KeF06ZjZfp/35EhXUiblxHZ7lqYdUlriUB1VAEMhmx/azzULPfrQPWlFnNJE3K4MUtmydQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5096.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199015)(6512007)(2616005)(26005)(107886003)(478600001)(91956017)(66446008)(186003)(6506007)(2906002)(66556008)(4744005)(64756008)(110136005)(66476007)(54906003)(66946007)(316002)(8936002)(76116006)(7416002)(5660300002)(8676002)(71200400001)(4326008)(41300700001)(6486002)(36756003)(86362001)(38100700002)(921005)(122000001)(38070700005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXVYamY2eHNlQi9CaFIwanZnbmJ0aWJiZUJUcGExbUtQYUd1REVFQUhGWDB6?=
 =?utf-8?B?dUNVczNQQnRpL3NTUjN1UHlxSXp5b3RpY3lCQ0wwemUrb3M2cFZ1RjY2UGd3?=
 =?utf-8?B?amZ5TDF3OTZFTFZhZWk5VXgyVkR6UWpIdm8yVkJodlR5MnJCc0VXUk9FdW5B?=
 =?utf-8?B?NjhFVTZZS1FxdmtyYkI4OVVNREg4TVI4Z3JZYXFhNGN5ZHlybUNtN2JYbG9j?=
 =?utf-8?B?YnBRZ2tSalRRNEpUNGtIbVZIYmhKUStHdEhJODQvd3hMZEsrMFFHM251eWxC?=
 =?utf-8?B?aWRaUGwvbG1WcmhadDlhbTNqbElyYm9YcDJ6UlR2cUxvQUc2cnQzcU1GaUJ3?=
 =?utf-8?B?VElDRWhQdTRLSGRoUU00dlFncUZoQU8vd3RhTVh0TStHMnZ2eVFST1BtOUlF?=
 =?utf-8?B?QzBQWmFNTHY2SzZ0T3JsTUtXZ3RPTjBPdUpmTVhjS2dualdYakpvYUVWVUZM?=
 =?utf-8?B?aXRUZVd2S0hBalJLRVJ3SDcxNEtVZVZIa014dGkrbm1iZ2RsdS9Za3ZyOUda?=
 =?utf-8?B?NnhMQ0ovSGU5WFZUeDdVdGViRytkdHdMa2xOd1pnbUlkSlljZ1RRK0haZFRD?=
 =?utf-8?B?MVAwcFlWemRVeEh0UUl5VkZ2Y1RlMU5jdUJBZkJhVlpMdXR2cUVkZjVLejNF?=
 =?utf-8?B?cUltOW5ZcjBSZGdQa0dqMUMwRjVUVDVvU0NiSHlYc2xDMmt4U2p0TlJmUjB3?=
 =?utf-8?B?ZGE3cWoxbUdhaXFWclFHZEcxOG1sbXlyVnppanVWdjRROWVzVXIrM0prbkRn?=
 =?utf-8?B?VGRqVW1Eb3U2OTZsd3FRWCtCL0Mra1BTUTgyNWdaOGRyYXd3NUovSUVXYysy?=
 =?utf-8?B?OG8xRE5Ja3o5cFNaTzVZQzVlcGszQngvcHpxMnY3ZmEzaUxVdUJqVWhUa045?=
 =?utf-8?B?WEYrTTBMampzaHZqR1ZEbEhQODBHeFJCTU5JMTh0c3F0ZnFTZU1KRCtlNkdu?=
 =?utf-8?B?ODJxc25oSU85MGh6d28wVTZOeFNHZjZJS1FLdFIwTHBZT2cwZjJKMUNhOThQ?=
 =?utf-8?B?Q3JJUmlwakp3eW9SSWhpY2tqTGdBUFZObHg3OEtDYSt4ejJYbUwzbWtVSWN6?=
 =?utf-8?B?NnEyd0FjMjRybGZ6Tml3NlhZSzRvTmJKMjBubHRDY3BXemZiclU4YStzY0Qr?=
 =?utf-8?B?UVRrV2I0RmQ0UERRNi9WU3hZUmJGRUpuRVZsckFkVVUybCt3Q1FWNE1zbjZ1?=
 =?utf-8?B?azRPSFVTc1hoQ216MVB5cGljU2V0eUhIQ1FsbVVZUjJSUGFyY2d5S3llK3U4?=
 =?utf-8?B?ejNFZDRDa1JoTXRJM0ZMaktVeEZxcGZwUEhEWm5iNXYxUEp2bjRFakhjckVq?=
 =?utf-8?B?KzJnd2RRN3RnaUUrT2hMdWFvTGlGdXdTd0U1ODNHRFVmUnJzYUVJcnFlMUZ2?=
 =?utf-8?B?NUR6VkpZcnNQam1NSng3VlVVeXZvUzl0R3hnZVFsWGRkUkIxdk83T2RMNUhC?=
 =?utf-8?B?MlVWaDJ2ZFJqVUdQbnZQOEY2YzBaRFd3MlFzSmFUdStWVTZXTFdWZUl1a1pk?=
 =?utf-8?B?VzJQdHZkN2pveWRWQjVTM3dkc2dNSktvOEN0L3BsWGk3K1orSS9QU05pMS8z?=
 =?utf-8?B?Y242YjdNQjRiQy9SRHpjTit0K1VKS3Nibjd1SVBzWUttK3cyRVlUVDFKQVMr?=
 =?utf-8?B?ZzhFbFVDc1dJSWNVMy8vblpZKzNXZjgxb3dacG5sZkpHSEN2Z2grYUZ5ZVFV?=
 =?utf-8?B?a3VJUFN4RnphRlVsaThtdEh0TFIxTlJnUklJWERqdmdpbEZKaWlOR0Uva3lp?=
 =?utf-8?B?YllHbjVPeXQwaTJsbzlSa1VXWTdmS3lxMHVmWDRNNlEzdEMzY0pnUHB2bzVh?=
 =?utf-8?B?cTdDRlN4ZmtnOVNOWnB6d1hoZkxaWTZWWklmQkxZT2U5T3Uyc3NDYTF0MXhB?=
 =?utf-8?B?aktTSVpNZHRFQ1AraHJqZVcxelRrNlVIazlrcjk2Q0NZaG5mc2I3NVRhME41?=
 =?utf-8?B?cnVSZncweEVNbHNLNG1FbXNlSlRYWkJxUVBDaHM4SUJyME95cVhUM0xUd0tw?=
 =?utf-8?B?bzdRdkVCK3F4R2dDQWtxOVNTUzVzc3lvS1FIVXVDNGVZL0Q5ZGZ6dDF1blVP?=
 =?utf-8?B?M3NYa244ellvMnAxbWkvY1o1b1grZngzK2VwQk12TldJRmdtM0RHemRUQ1BY?=
 =?utf-8?B?VThMUDhEUXZ0WXVQYVNiN0g0cEkrZnRVTnM4eG13UU1pQTljZWNXcnFWcll1?=
 =?utf-8?Q?8tXtno0pi9XXEiulQGW7YimQulH+IepygW0QO56GvdAe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE1DEA3C261DB741996AC31B681EADA6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5096.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8522b10-ddaf-46b1-09db-08dab742f795
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 11:12:27.5498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rTQQMya7eBs5hi3ftExcGeWzWUTiBph03yE8XjznGMBuuPZE3Lt1H5D3dc4K6yOg40LdQJnPvdvLGSZ1LQhJpf3mjUrXNlnb6+HmwqBMWjTBZmrNE+mFhrViBt48Ps1Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6349
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDIxOjM2ICswMjAwLCBDaHJpc3RvcGhlIEpBSUxMRVQgd3Jv
dGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91IGtub3cgdGhlDQo+IGNvbnRlbnQgaXMgc2FmZQ0KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJpdi0+
bGluZVtpXSA9IHNlcmlhbDgyNTBfcmVnaXN0ZXJfODI1MF9wb3J0KCZ1YXJ0KTsNCj4gDQo+IElu
IGNhc2Ugb2YgZXJyb3IsIHRoaXMgc2hvdWxkIGJlIHVuZG9uZSBpbiBhbiBlcnJvciBoYW5kbGlu
ZyBwYXRoIGluIHRoZQ0KPiBwcm9iZSwgYXMgZG9uZSBpbiB0aGUgcmVtb3ZlKCkgZnVuY3Rpb24g
YmVsb3cuDQo+IA0KPiBJZiB3ZSBicmVhaywgd2Ugc3RpbGwgY29udGludWUgYW5kIHJldHVybiBz
dWNjZXNzLiBCdXQgdGhlIGxhc3QNCj4gcHJpdi0+bGluZVtpXSBhcmUgc3RpbGwgMC4gSXMgaXQg
YW4gaXNzdWUgd2hlbiBwY2kxeHh4eF9zZXJpYWxfcmVtb3ZlKCkNCj4gaXMgY2FsbGVkPw0KDQpU
aGlzIHdpbGwgbm90IGNhdXNlIGEgcHJvYmxlbSBpbiBwY2kxeHh4eF9zZXJpYWxfcmVtb3ZlIGFz
IHRoaXMgY29uZGl0aW9uICdwcml2LQ0KPmxpbmVbaV0gPj0gMCcgd2lsbCBiZSBjaGVja2VkIGZv
ciBlYWNoIG9mIHRoZSBwb3J0cyBiZWZvcmUgY2FsbGluZw0Kc2VyaWFsODI1MF91bnJlZ2lzdGVy
X3BvcnQgQVBJLg0KDQoNClRoYW5rcywNClRoYXJ1biBLdW1hciBQDQo=
