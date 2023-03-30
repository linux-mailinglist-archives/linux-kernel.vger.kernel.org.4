Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449CE6CFAC0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 07:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjC3FaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 01:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC3FaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 01:30:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75A8558D;
        Wed, 29 Mar 2023 22:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680154201; x=1711690201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T9mObGQZxdqFdFMfnRXp5ysj98+eWYPsnz43P9XdsG4=;
  b=KWXBN6I2e+6KqS7WldZ4UR1TgUt/Of1cz11fY5cECInilgKMdtXdLbKL
   LGNXuAvqQcGXZh1RsAkyn35dKV+TUa+iXpUZvkaYQ774dT/G2hsV9AAmE
   355FtGTRwy1rFWE7phdLbqWMcmonNgkYAlusI2NRTAxzHxPIUAhcywdNS
   W6pxkvSreKqQBsSTM+DUJFh01Lkkrx6FiRQoOaTwqkTHQI83neapX0hRO
   RfDSfsPSSwQ9xHreNVUtj0OHw6VULAxateajmRHT3GJbjn8ZQIIpcn1T2
   sHrMEO3rCZbvU3tMpLr8PZR1FileLwxugw+zYFD8fvoUpC6cTNNcFgOj1
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673938800"; 
   d="scan'208";a="206972966"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2023 22:30:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 22:30:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 22:30:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eE9PxCJMscj7Q21YKrKEkjnzIkO0WQhNOYv3QpnUU+Qy3T1bCpwQFvX+1CZx0wX+/k2QMtZrqbr/pbP1c8EVCOJNj5ufepupQjjg6D1MZPiz1uZwzItTtrV0/eAJPDStMgKkVUy/QScy4T7QKm6g59BmI3BuAjrFW9YWMathY+35dK5mq1nzpmN4lDnIli/n0yOOnwqS3xaCSsMXIzqfu+cWsCo47erNN/nU23yl/33XbMglnwJSHtd+pzzXWIos7VMEioUDTxpdp2273xCfzDhGTZn13dxgLu8JpOpt657Za6R9H38F2h/mfFpwJsUXhYg3ysnzwAweyHuc20IF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9mObGQZxdqFdFMfnRXp5ysj98+eWYPsnz43P9XdsG4=;
 b=gFejeUg5iW7S/5+lw1zVy+CB4a5KYXbfFOgLQ14mwddmzWZYsaVG6lafSoTnJU7YakHLtd2GJ3LJyBj2nEqleVYeVwMJtdTOjnboaZDO/8dUmYrNa6TgjVuduXTz7wbFruIx9TwT9mBzbArOclvyz/VCaq1DUF8S91xFPLI2hMLezbukToDSYG01WPrkxfo3gnFTxcJgdwr/QIgOLWQ6UEw6X4HXBdmIwGPvup9FF4fN7Az33iNnRTnY61LOBFkPlid/avaj0TV0t8K8VntlvnAAtRW+NqSfdaUwHPt6iPsSvePVLjlwebUrb3rq95RKE+bFNUTbVYJh5HK7Tocvng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9mObGQZxdqFdFMfnRXp5ysj98+eWYPsnz43P9XdsG4=;
 b=fcnBNJyJABPKY76FWUGvx3w/gG+hV3yCYhQ14o413sJPIh3sJeHnNexc3Xd3Xz9jqGWPrLQUIOBe2pmwxTa4vFB8JB0dSRq3ZUiP3VqcbPVoJD7nS0HaKColmPrn26xM4G/mvirLqdp3xaEqLl5vQ591d1/I35nzA2x8gMwE4UA=
Received: from MN0PR11MB6232.namprd11.prod.outlook.com (2603:10b6:208:3c3::7)
 by DM4PR11MB8160.namprd11.prod.outlook.com (2603:10b6:8:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 05:29:58 +0000
Received: from MN0PR11MB6232.namprd11.prod.outlook.com
 ([fe80::5939:1be9:fdb0:d5c]) by MN0PR11MB6232.namprd11.prod.outlook.com
 ([fe80::5939:1be9:fdb0:d5c%6]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 05:29:58 +0000
From:   <VaibhaavRam.TL@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <arnd@arndb.de>,
        <Tharunkumar.Pasumarthi@microchip.com>
Subject: Re: [PATCH v8 char-misc-next 4/5] misc: microchip: pci1xxxx: Load
 auxiliary driver for OTP/EEPROM auxiliary device
Thread-Topic: [PATCH v8 char-misc-next 4/5] misc: microchip: pci1xxxx: Load
 auxiliary driver for OTP/EEPROM auxiliary device
Thread-Index: AQHZYYNttMRXjBeS0EOeAwjrVAxypK8RiB2AgAFGRgA=
Date:   Thu, 30 Mar 2023 05:29:58 +0000
Message-ID: <06f47b3f10ab08a6a93ffd7996b7f042845193e3.camel@microchip.com>
References: <20230328144008.4113-1-vaibhaavram.tl@microchip.com>
         <20230328144008.4113-5-vaibhaavram.tl@microchip.com>
         <ZCQMtUAWAeCDmXlK@kroah.com>
In-Reply-To: <ZCQMtUAWAeCDmXlK@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6232:EE_|DM4PR11MB8160:EE_
x-ms-office365-filtering-correlation-id: eb8c36a3-9359-411e-c2d3-08db30dfcd59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B08PQEe7eJVqEt0Yq2KKGTKgSq7rOZKYmPzKFYzxlAco4H1QeM+QfHWEluVDelXL48S3kk9Pnok9fNq+rNf4cNKjUcwMPLNfgvX86ZjlSqx5suc9iEAGUX0QIlPmoxCtAjbDWnZYLcA+Cf3YZXDg9DoSlIRTRjKzP1yEndQS3MrLI3w1GJOIjUiTJWwtVH9QRLHVaxWF9ydZaEGPIUvB+dp1HVtvzpSt03otYfVVFt/5n/M0XctsT+VMmm6/Z10NB16cfSM0tH8Dhiyu2eaQImw9FaoVFanPFJDTP2lIWlEfocP1SbqYNoOCZdm+QJAXN9im4NcJRVCqgrY+G3XEfVgzNYbSdQkGao/13Y3uCGplREdDPyauQri+TzkLyG68xUSPDdO6VWzLrJpvZKkI4n/Gijbm+Bdv+vaQLGwE7kOcqw2mGhrlKCskDipSjrI3a5oGdUSqeuUtaRR8BcBPmq/erhV46dSUAMjkHNphFCYYrXfc4DD+JZe7DSNeOPo76OAZz502QkMSYTv4Rv3IY89/pPcYIMr9KP9saRjxU4s9s9WU7L/tPKnxbhDWKtAAlmnpZbOabJS2Alp/YVvw7wXJKNQix1rGiGBmrOEyUmiy7PC4aaJg7+UVqkO8Zo0nU1hM4i7P5O3LG8YMxb07WQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6232.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199021)(4744005)(2906002)(41300700001)(2616005)(83380400001)(316002)(66556008)(71200400001)(8936002)(6486002)(36756003)(66446008)(8676002)(54906003)(66476007)(4326008)(6916009)(64756008)(91956017)(66946007)(478600001)(76116006)(86362001)(107886003)(122000001)(6512007)(6506007)(5660300002)(26005)(186003)(38100700002)(38070700005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3h0ZVFQZE9GNVZYbHBZdi9pd2VFQUhtbzhleEdWNFM2b1hpaFBLaElYdEhj?=
 =?utf-8?B?SDV4U0w0S3QyUE9oWDFLWFlnMkZqVHBOVkVXOG5BWEgza0JlaEJHSkE3RUd2?=
 =?utf-8?B?ZUhuaDVyQVQyZVNyaTFQQUhBaUUvMkZ2RFdGVHhHWU5jTFI0di91YnlOWjZ3?=
 =?utf-8?B?TW83eTdiK3FsTTdjWmVSR2ZlS09aQ1ZmWnhqMEVmamhMY2w0dkxGMmNxSFVo?=
 =?utf-8?B?b0RKWEFEekh1Q1F5U1NKUkZZVnlnYlI1Uzkzd0owZVdRZzJuUWV0VVMyZm5Z?=
 =?utf-8?B?VG9HM1hScGI2Q29LVHI3Q3N1d2RwajRXMi8wK3BCYnNVcjl5UHNCM1E4Qkhw?=
 =?utf-8?B?cE5ITGVtOFdrOXBVc0tCYXBvVUhaOUN1Q3BGTTFkTGFkRndxY2hOcFpwU05r?=
 =?utf-8?B?KzZ4Uk0zeEtxUXI5bjRiYUg3cTRhZGY0blhOVTJoaFZ1elE3MytRdzg2aHBJ?=
 =?utf-8?B?dy9QZ0JMSUZ5UTJVaUQvODNhakEzcHRwcjYzNVVySmw1T1A1OTcvSjZxVnVP?=
 =?utf-8?B?MnUvSDZiNG9FYU43bEhKaUQvWWNlUEZUTzJWTlRMZGNFWlBMckxTb0t4bVZE?=
 =?utf-8?B?NitNemZRWG9NTkNxSU80TnVXbHNjREh5RXZpanpocmpjQUlVajJtc0NGM0VS?=
 =?utf-8?B?bnRzTFBsOHJzNUt2eFVxbEE5alhGeGxyQjdPR3krOHFRREhLaUk3eGxRYjds?=
 =?utf-8?B?NEl5bXlrYjlaYlBNaGtqNUhQVUxOdlFBWmd1RHNwZmxsUUdhRDdFUGV2SEFj?=
 =?utf-8?B?RURZR1dHa29PS2ZQREg0YWpvbVZkL2tZbTdTTDdpSGtObkZxaVNQRmd3ODB6?=
 =?utf-8?B?U2VqNzdjSFFYWGJYdWRGTW00eWRtTWVEa1piQWM1bm5RSS9xTCtZbU5nZWxH?=
 =?utf-8?B?U0RqQjdBOGxCMkpubU5PQXg3QTVpS3g1Vk13Mk1ha0VSV0w5SlpzMEc1bjdP?=
 =?utf-8?B?WFFTVGtFUE5xckpEOG0rR29GV1VMRGlTcTVqSGc4KzRqNk9JZWFIeWlLQnBR?=
 =?utf-8?B?cDRFWjRyMTlhNXM2cDEybGo5b1c2UE16TnhwWGJ3ZmFlRG04eCtEbjhWNkhG?=
 =?utf-8?B?MHFEWUl6SjFtY1ZJUUh1cWVaLzUrOHNveVRxK2ZER0VoTmw3VE9XTE9QeTZK?=
 =?utf-8?B?VDY3V0Fpd3lyd1RXQUM1bStvN2JSZ3M3U1h3YnJWZ3NWbzdUL3VhbVQwYU5m?=
 =?utf-8?B?b09lTVFiMVpzQkRVcHQxVkhpeEdyT05BTWpQUVRldWxoZlN4aXpmdE9ON2t6?=
 =?utf-8?B?SGc5Sys1Zkd3Z3F6NjA2YlNUMVIzcVQ1ZUlmeVp0WHQzNjJSdHFmR0dmMFRY?=
 =?utf-8?B?aUJ4bzNQbEx4bnh1Z3JSazRHQWw1YmNHU0RJKzBCZXUvTHBhRkZ4cjE2Rmg5?=
 =?utf-8?B?dk9RYWVpWTFsTExhZGQ1dTFURnNSeW1CYXh3YmVXamIydmlXNzNndWRNTWZU?=
 =?utf-8?B?bDJKMm43SkpSdjZEVW5ZR1F2TWpvOTB4QnljU1pDTTFLK0R2TTRXbXRXQ3Rh?=
 =?utf-8?B?VnNKNXNoa1FkeEpGSTIwY0ticXVOa1NLTWNqZlFwRnZIeE9Gb0FqWm1udVhT?=
 =?utf-8?B?ODJkMFREdllSNDVZV2FKSlRYNWwvNFVNZWZ0VWUzSVpodkZ1czFnVEdzb1Ra?=
 =?utf-8?B?UTNrZlRwZkFjbnBXSE4vL0pNcXVPQ3RpMFBsdUhNZ0NVb3p5N2Nxd1hDcXZk?=
 =?utf-8?B?QXNycDhhREdTTmN5VFBBNVRyb29mcE9rQXVBTFQxQ1JPcWtFNld4L0lBekdZ?=
 =?utf-8?B?alI2NjB3aXhKbjB0djYwRzRiWjcrakdQQUVZdXQvenFweVdQU01Mc2ZTc2x0?=
 =?utf-8?B?RTBDY0FNaktrUW5samdocytnMVRKekd4aHZIbjR3enRNSTdpWExURU5xOEph?=
 =?utf-8?B?RE55RnJMbXJ1TlVFdUFkM2lPTjRSS1VvK1FIMGtYYUFJK1pBckFhUDlNM3hr?=
 =?utf-8?B?bWN4VmJzNjZYVUZCR3k1bkd4K2FaZFFINU4xaGJyVHM3Z1VhT0lHelNPb0Rw?=
 =?utf-8?B?OXJOdU4xemdaWWlaOFZRenYvbVJhS1lmamJnUlk1bWxXQXhmcFo0OTlQQjdq?=
 =?utf-8?B?enAydUt2NlVsWWFWdUNWdmZYdk5QWHAzS0l2U3RKMXFoTjR6U3orOE9CZ0N3?=
 =?utf-8?B?T0JBVEN5SnFQY0lEZ2gxMDl0ZXBxQjQzU2NvbHJ1VkxSRDYvS0hPRkJlYVYx?=
 =?utf-8?Q?I2vKiwIgAPlwp5qWnSwjCwc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22C8C8783B8B3440887FA0D81759825D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6232.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8c36a3-9359-411e-c2d3-08db30dfcd59
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 05:29:58.3650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1FeZY8ODMPkCI0dPFSP9CLPu8fFyYO0eP0Wy1A3JqXIhd9rOQBSIC9s5HV1nZ+81m7qmuiiXVzUG5LWZ6J8V5kdOe2lK5Q9+g4vsGJJ3KnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8160
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTI5IGF0IDEyOjAyICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFR1ZSwgTWFyIDI4LCAy
MDIzIGF0IDA4OjEwOjA3UE0gKzA1MzAsIFZhaWJoYWF2IFJhbSBULkwgd3JvdGU6DQo+ID4gRnJv
bTogS3VtYXJhdmVsIFRoaWFnYXJhamFuIDxrdW1hcmF2ZWwudGhpYWdhcmFqYW5AbWljcm9jaGlw
LmNvbT4NCj4gPiANCj4gPiBUaGlzIHBhdGNoIGNvbnRhaW5zIGRyaXZlciB0byBwZXJmb3JtIGlv
cmVtYXAgZm9yIHRoZSBPVFAvRUVQUk9NDQo+ID4gYXV4aWxpYXJ5IGRldmljZS4NCj4gDQo+IFdo
YXQgZG9lcyB0aGlzIG1lYW4/wqAgV2hhdCB3aWxsIGl0IGRvP8KgIFdoeSBpcyB0aGlzIG5lZWRl
ZD8NCkluIFBDSTFYWFhYLCBzYW1lIFBDSWUgZnVuY3Rpb24gaXMgdXNlZCBmb3IgZ3BpbyBoYW5k
bGluZyBhcyB3ZWxsIGFzDQp0aGUgT1RQL0VFUFJPTSBwcm9ncmFtbWluZy4NCg0KSGVuY2UsIHdl
IGFyZSBsb2FkaW5nIGF1eGlsaWFyeSBidXMgZHJpdmVyIGZvciB0aGUgUENJZSBmdW5jdGlvbiBh
bmQNCnNwYXduaW5nIHR3byBzZXBhcmF0ZSBhdXhpbGlhcnkgZGV2aWNlcyBmb3IgZWFjaCBwdXJw
b3NlLg0KDQpBdXhpbGlhcnkgZGV2aWNlIGZvciBPVFAvRUVQUk9NIGluY2x1ZGVzIE9UUCBhbmQg
RUVQUk9NIGFzIHNlcGFyYXRlIGJpbg0KYXR0cmlidXRlcyBpbiBpdHMgZGV2aWNlJ3MgYXR0cmli
dXRlX2dyb3VwIGFuZCBtYXBzIHRoZW0gaW50byBzeXNmcy4NCg0KQnV0IHRoZXNlIGJpbiBhdHRy
aWJ1dGVzIGNhbiBiZSBhY2Nlc3NlZCBvbmx5IHdoZW4gdGhlIG1lbW9yeSByZXNvdXJjZQ0Kb2Yg
dGhlIGF1eGlsaWFyeSBkZXZpY2UgaXMgbWFwcGVkIGludG8gdGhlIHZpcnR1YWwgc3BhY2Ugb2Yg
dGhlIGtlcm5lbA0Kd2hpY2ggaXMgZG9uZSBieSB0aGlzIGF1eGlsaWFyeSBkZXZpY2UgZHJpdmVy
Lg0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg0K
