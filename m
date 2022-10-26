Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEC960DF42
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiJZLEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiJZLDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:03:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FE1BC7AF;
        Wed, 26 Oct 2022 04:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666782225; x=1698318225;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7YcjdrSfne/HBWj+/inJp+FmpSLhaCoJGoncS1HGz8A=;
  b=QZ421D5GIyLNpSsh6lXerpivM6OakqBKk46SdKo5JDysm+9TfwN3fxrx
   lfcwiujEc4pEXJH1EXrIN/hwipwT531eqHRFy9UoUyGBoLaxwco6bhKi8
   EktABTETi3O3qjCgOVH+1iIMZQB+oskGcs7H+srNN1d/FjcCj1O9TlZ1Y
   O4XLzIE6kIjSV0Xhp7rORIyDb5/AczgYungW8ksmeyzbzc0sD3IGgdPNN
   8ktpfWPttVhvXkOfxvKmTZlJg4bGLPUJx4NbfOhcoQkxBp12lOXTo7Rlv
   VJ+aeqmfdVnoakgzenXL7yg0hrcojN9aWXstDZ5CJe3ztigIqZ+6zK4bc
   w==;
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="180578800"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Oct 2022 04:03:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 26 Oct 2022 04:03:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 26 Oct 2022 04:03:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrLAFdWKHV37qvmm5gsatq4Y2NlrLysgAp1xc58LrrC3f8joz3EQaqGKyAi/iXcyxKZoXoYFOZmDODvfp3ulMwXsOQdzNnBNYBdPI/oxolVTcMKSXiPFGlAQs4AEnng06Y7/B3OoftfhPLWVA8fH7pmPae6zNnp5hsNUgPy9CaM1Rzjl2YG1aiiYHy/9v/cxzxMz2XrEsD6mury2swAU6b9lR0RIeToONv1lLIWtXlQGpXKIDZaJ3XqbnEr3g4fLLj4F3fOUIJK+hsoEyaj0vcdNidk56S/fCETzzZv1xRNnrMWtTV59O3U+9yYNdLb6hXWAg7Z7DKsv2LFcwwPIzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YcjdrSfne/HBWj+/inJp+FmpSLhaCoJGoncS1HGz8A=;
 b=VwCfcQBADpnLHRQpaYct5huCL4/rnIRYIcpGDBn5Ut2TKrMM/f17VRYrVO8g2/LwvCihSmqDg6RP0FHhtn2IckdcIjdvMuzDnCFnXSjLDbNRPmPCXMk4BgIEDDPxq512ZVZw7MUKQ1Jfh62clKKS2JY5z4hF68H+Y9uC3HQXzhTFYa3DDP410/5I7RczZyMnHBFRVxEEBoKcM3+wEetampIf0bnHE+xC/qPPCRUsAryTbXEmo6DyMZJOINr8woMqxWck5/O9FF0KBX+OOK5pn9ZRiC4S4T+0C4QIFr4k2LLp5Iv9KKyX6dIYzlxZJyA6CNy7PkI/1xZdHoiy4fCRxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YcjdrSfne/HBWj+/inJp+FmpSLhaCoJGoncS1HGz8A=;
 b=gjyA2b20hLwNtrfnD5y1CEQvT0As19fZqn0Ykwlto2bm9OiRGKvPvXyCrD9cXQHYeBVUYvASsFGNBNHSxs5GLjdAedyPgIfvc6nryit+ndt2Qqh2C0t3Ggo64kxAuYoXo12yB6nlefTI62oyYnltg6C1eEfJ9E0Woap/1Aj8k/M=
Received: from PH0PR11MB5096.namprd11.prod.outlook.com (2603:10b6:510:3c::5)
 by SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 11:03:30 +0000
Received: from PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::9689:f094:d23a:ad9e]) by PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::9689:f094:d23a:ad9e%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 11:03:30 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <andy.shevchenko@gmail.com>, <Kumaravel.Thiagarajan@microchip.com>
CC:     <linux-serial@vger.kernel.org>, <etremblay@distech-controls.com>,
        <gregkh@linuxfoundation.org>, <ilpo.jarvinen@linux.intel.com>,
        <wander@redhat.com>, <u.kleine-koenig@pengutronix.de>,
        <jk@ozlabs.org>, <macro@orcam.me.uk>, <jirislaby@kernel.org>,
        <johan@kernel.org>, <phil.edworthy@renesas.com>,
        <geert+renesas@glider.be>, <linux-kernel@vger.kernel.org>,
        <lukas@wunner.de>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v2 tty-next 3/3] 8250: microchip: pci1xxxx: Add power
 management functions to quad-uart driver.
Thread-Topic: [PATCH v2 tty-next 3/3] 8250: microchip: pci1xxxx: Add power
 management functions to quad-uart driver.
Thread-Index: AQHY1V02yYultS77nEiXC6E78nq8Dq38ac+AgCRBIwA=
Date:   Wed, 26 Oct 2022 11:03:30 +0000
Message-ID: <acf4939aaf7ff31d1df3c8d0f38a2f718791e894.camel@microchip.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
         <20221001061507.3508603-4-kumaravel.thiagarajan@microchip.com>
         <CAHp75VdEJvG=BQvS2KVNY8BnjfHyOCO6ww0S4_gxVZNuhXaURg@mail.gmail.com>
In-Reply-To: <CAHp75VdEJvG=BQvS2KVNY8BnjfHyOCO6ww0S4_gxVZNuhXaURg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5096:EE_|SJ0PR11MB5120:EE_
x-ms-office365-filtering-correlation-id: 98ff5a8a-a590-43ed-bfa8-08dab741b73d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5LibD1EgjY6AB9nQcsKSuCqZP+ZPZdVHOk0fcXtmpUW/Eg6jQ1ZcAmQDQU+AmMrYdte8SKfIzAgnDcHHc6f/bZHQcdWZAJYNU3ItJgrJ1WW+geH6UuVZGtqGeGSfXJbEOuTO2VZ0EDFi82XoN4FSzDJp7wnXCD8+ivGK1BnifNBdEPa2cYjyyjftcTunDgNH3QmSXDXI/SBOwbsND71ltL4pivYPo44pKOHQDiMQ+VVfx3SqbzFMkIF+4+mZAX/Eo12PEVJXNU6zrjMg8Kiy4mKCgFneuwT2TWu7ZDPi8GLlqgDW/KOrzgooRXLVqf+lFjwTv+NNNcaG0GvpegYTUK9KQotuEljBQy4kAmuiBrcsbJCx9RT4S6r63BbOMAOlPP2/9WhZZGxpOwT0P34tjnqITQ11ac6smfAwpKCwpvaWTadEDNoS+2MloToet07dI+356agNjI6szqKVBpJDcU4h1wabl6f1WzBBO4VGLafbJnE6XsmrBcuZ/LTYyt6vHqTHiwWri0osCqH/s1tCb4JNPSvVOB/0VE8xHTFbPoYc1vY8z9MhSNUPbsMf8BfH/UANR7VKQjdlujN4nPhL988H8R25FmRTZHvItjTyTxSUcX3uyW5JNOk9seb5/Z+xNZw4pOkdU/ne+QdGrznMWeyNsR0LjkWMVVwVZaP7A7Y6rjn0AYQEU92bjG9VA1Am90ohHHHANicdemEtIbkzDJ6Ql72biLvvBCXR9IQehWQ7qiQLZojogXwePkTNV0QXanQXpCc2W0kxSVeVwotcKF2PZReAuxz1UiL4g4RLfD0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5096.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199015)(71200400001)(91956017)(66556008)(41300700001)(110136005)(6636002)(64756008)(8676002)(54906003)(6512007)(66446008)(2616005)(66476007)(316002)(36756003)(2906002)(76116006)(66946007)(5660300002)(558084003)(122000001)(38100700002)(4326008)(38070700005)(6486002)(7416002)(478600001)(186003)(107886003)(8936002)(83380400001)(6506007)(26005)(86362001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QitYeFV5UUovWTREMmxYUkZEbXZXR3BUZlpKNVVKSkxNQkZvSUFYdHp2UDNG?=
 =?utf-8?B?TU93alhYRkJEa2wzUGhNR0lYSThhcllhSklwcTRDYkthOS9obFFMdEhBL2V0?=
 =?utf-8?B?NVVFdnl4cFhEMDJxRDdVL1l3MllVM3VYN1Y4N0hvRGFodnl5SXE1RWdER3Fk?=
 =?utf-8?B?RFBZTXRXMndEOVZCQ1V4ekx0NU81K0lacHVKM1Z0c1JsV1UyczBKYitMK3p6?=
 =?utf-8?B?VHZwV284OGVoTU0xbnlhTGJCd0FxdThlbGNpclMxdll3djdwKzg2Sm5RbDBY?=
 =?utf-8?B?NlJDZlBZZzR3eXBHRWEwanBpamlzVzBNZlFrbTZ3VUxFc3p2cGIxd3QrRjJz?=
 =?utf-8?B?V0dIRTJGZE5kSWJpYVVEazJLempOYUZMbnQvdkNZQWl2TkFLeUhycUxpN1Fq?=
 =?utf-8?B?RjNVVlRDSFFUeEJCVmVJT0tFeS9NM0xhWnoxQk5OV1FzUFYrOHFWMlBMcFVm?=
 =?utf-8?B?UjBqVmJWamd0QVk2bERNOThER1J2NFhObDBMbnAvRkc5T2JJdkpDaWJNbzBU?=
 =?utf-8?B?WW5nUDVNdTVNQVpKT0U1RW9aRkJpbE9mWU9pZDUrQUs2UkRHNUpwYUZiUUFF?=
 =?utf-8?B?aHRSSjBRQVlCUVFEbXJhSVd6NkQzOWg4R2RhNWVZVGUreTRvdGRVTCtXU1Rk?=
 =?utf-8?B?RmhPTXBMWkNCOEo1TzlYYkJXL3lTQ2xvVEdpeWVhOE9qYnZHYUZxWlJSRmFq?=
 =?utf-8?B?ZnZlZG1JWTRnT0ZQUkFuMEJCQVZ2L2htQkEycjBVbFVxZDY1ZmNqMW5qZWxR?=
 =?utf-8?B?WjNGNXRuWXZBMjBmYVFaN0h1NU1vVFVEK1AyM29IN0dwaFQ2VDJwb28zK1Fu?=
 =?utf-8?B?WGpPejc3RFNVZFIyaWpOQ085RkNCZzhPTE1ocUdoK1hCSDhLQ0I5QXJiT0NO?=
 =?utf-8?B?WnRPMHNmcm8vTFRha2hGVklXd3I3RWNJZHpES1g4MWNVTVk3UEdoR3ZsQzZU?=
 =?utf-8?B?cDhWbmExa1R0RDI3b0s4N052TEUxM0lrVWYrU1dKdjEzSHMvT3hWL0svbjVS?=
 =?utf-8?B?RTdTMEpaYlRwZ21pZjlXbFpBd3E4Y2VPN2VaMlduRkhKVUNoVWV2WmE2VUkr?=
 =?utf-8?B?UmpYUUFtNk5vU2c2SkJjdGNQMGw3eDllUzd2TDB0UjBaWEtFRlhiRHdKeUNQ?=
 =?utf-8?B?Vi80NkdNNm5aV2s3cXg4OGtCUkd1WFN3WWpyc1NSSlZ5TWpsWnIzZW0xMWpo?=
 =?utf-8?B?UmpzaG5wQXY3VDJFc1NzbXU5UHB6NTE5WEhKbi9tRVVHeFVkTnY4TlZMRDh6?=
 =?utf-8?B?Nk94THhrTytURGVPVXFPbjdmbjhQMTYreHhyNUxqVjdKRnRNOGJXeWdDV1Rn?=
 =?utf-8?B?dm0vamt1Sng4cCtTeHNOVmVLQWtuU25VL2pJbXNCWnE3bm4yb1J2QXNiRjhS?=
 =?utf-8?B?SmwzOWhVVGlHVDQ3RmVISXhiYnY5SFc3aHFpcG1mT05rZlo2RW9iMXFOOVNw?=
 =?utf-8?B?MC9aZjlDTDF3czNNaW9MWWpaOFVKU2tUM3pyVDdTU1RnZzFUNWlOV0RTSXE2?=
 =?utf-8?B?N1RlZlhkNjhrQ2J2djkxOTVWM3FPc05XemNoUWNWd25mOUV3cEJGYXZLeENY?=
 =?utf-8?B?dHFOb1p6enowWDIyY0J3anNhUHZvaTZXa0xpUHZkSFhvck9seHk1NjdaMWpX?=
 =?utf-8?B?MjZ4cTRHcmtZUFdIWVpjZ2tXa3NpelpyWkJYZDQwMDhvOXh3SCtRMEt2MGFG?=
 =?utf-8?B?TXk1VUNYUU5XZWR3WDUzTG5DNmRBaFh4NWMyQ0phTnhjVFlOakZWZzhwSmhE?=
 =?utf-8?B?WE54QUFXRDd4NjJwMUtHRHlxWHFVZG9Jb25JYlBxZCsxakxBdGdLSTR6WTBn?=
 =?utf-8?B?algwVXBHRGdPMCtETzE2K1h1eFM1NWx3NjRBdGYwSHh0TGdlL1JTSVVlY0kz?=
 =?utf-8?B?bW1oZ1hkOHFNU1dGcmw5blkwVTlOL2xjVFEwcWptdmgzQURjZEJGdGFqSWUv?=
 =?utf-8?B?dnNEV2U0cVBPLzRJb1Rvc2szOFJrSXZ6SW45UUN6Y2RVVkhpTkxvdlVUMGVD?=
 =?utf-8?B?VHZrNndXZS9PUSt5UU5YZngxdHlUMHdzWm9nQnd1dnVuMUJnWmIxQUUyNnFW?=
 =?utf-8?B?Y3JtWGlhTlpQM04xcE8wdWhxK0JUajRDZkNBSmhtNXVyaGpoMlNrZ1pjOGxv?=
 =?utf-8?B?dFMyWXhyam5QdFRYVWZYbzJGVi9lYkdZaEhVUDZWNXFyUWc5YXY0TlpLSnBw?=
 =?utf-8?Q?H9kq7KwPoMxam41RMFJz6iSu8JZcx7oYim3hR4vUaxb8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A41BE75BEAC6C24FB7194876F7D9419C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5096.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ff5a8a-a590-43ed-bfa8-08dab741b73d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 11:03:30.1224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guMoi44gNfPzBB9O2OCewrFX548Z7/5lWKnD4PMIoUlszboOyr+KqlmomALnH+bVs3vzz+7uT47bl0iuW+pU1OQ06UHn/3prz8TwqScgiF4RBHSBJovnlJhaTV620Y3g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5120
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDEyOjI2ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91IGtub3cgdGhlDQo+IGNvbnRlbnQgaXMgc2FmZQ0KPiA+ICvCoMKgwqDCoMKg
wqAgcG9ydC0+c3VzcGVuZGVkID09IDANCj4gDQo+IEhvdyBpcyB0aGlzIGNoZWNrIHJhY2UtcHJv
dGVjdGVkPw0KDQpJIHdpbGwgdXNlIG11dGV4X2xvY2sgdG8gaGFuZGxlIHJhY2UgY29uZGl0aW9u
Lg0KDQoNClRoYW5rcywNClRoYXJ1biBLdW1hciBQDQo=
