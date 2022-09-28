Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCF15EE0A0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiI1PgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiI1Pf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:35:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9EBA02C2;
        Wed, 28 Sep 2022 08:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664379354; x=1695915354;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MgX4sHuQA70sJOOPDbH/a+F8V6Rz2dms31iHGcTbs/o=;
  b=Y4R0bK37+gvVAdTEZRi1Nl1p+PhKU9oHjBTJueacR39pp50N432tGkSG
   QVSjDpq4EaqkFLAn1qNfHhgjTXplp4RYjqqpSRZlSu3t19oYJ5X/GiaVR
   uROKVf0+dkeCg95lbJ5Jewrx8RVIQ+JsBV/47PYHJxO5ngY+csSFmET5s
   zTxbmZkHS6zYj+dETerPzYEnEuucde5wwcCEr7IbOa5zb6EF2j4NWVgHS
   fqzBqvWQEkI4UQObsmar3WHLBM46fh2Nj7tA4Vvuwd9rUu8VxeZKk60tv
   mLAk7pUaHhoFIrKqAEHaHb97YzK9yE0l+JD077aehasJcgfP11jJSIBnT
   w==;
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="179351145"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Sep 2022 08:35:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 28 Sep 2022 08:35:53 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 28 Sep 2022 08:35:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BS0Od5GOR/nYZXZaSPl9okzsBQkdZLTrPGvnW7GVpcEj9SDvtmP0SmRWOYgcfr6s48TCgavRKTaaDUe4OoY6YT/FN3Twi5Y8MAv4JXtFOpALu6CfPM8eONr/twgw19AtxHB3QVxo0igYpJWgE7/+ccE6oOmsYq1ppRIpXdgDBCy0/klqo5xM/mtsMcLmD5FD9P9Uzp8Z9D/8saYe9M84qBhPIZHE2v71c3F7rERGRAilgmjyG9kUnB2MkO68q/G7+nIEZqUA54VXUl3msUD7PNZa+5cTeouROyrsXnyJ45mRcAZ/LR2zRwJNfN47VHrhd9Qq1UkWzWwsmtbRenUetA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgX4sHuQA70sJOOPDbH/a+F8V6Rz2dms31iHGcTbs/o=;
 b=oe3jR+/HD8ODJzzdGgesc8GtQRWKXwYO2+8qF/0DdOgH116N0Rn4gqu/0/Wnb/XzxBI3Ex2jXcxYQIRucrXVeklh12m0k3rmtl1yqaVvQTEq6tBOt19p22YnvKHZzqU2cFP7KMMsMYrTGbuufWQHMitA+8hO56ryyjoPnUlXS3bYwjyoQPNpX3sqEIUt+RBLejE4oOAfOKoMc+QbwEG8SqdLDX7eeuV0IhvbQgeqCj4WiMVQSZEG8pPvipW5pOC42/g/Bg0ASI+SHThikIOUip6DKWIjEZCyuSv4ZtwOpyVr5JNV1rKKCwEfQoXcbeSjScbXaYk/Dq4Vqz3OANB78w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgX4sHuQA70sJOOPDbH/a+F8V6Rz2dms31iHGcTbs/o=;
 b=tuC71ZuqLZxhV8OjJaOBjKmsmpmrW0Ic7s/djlxkYm8GzCeRG6hM4LM2rJ4vyp5a0HVlfp8wPE7ImidEI5sxztYwwCKtEp0UVyg+0r76kRao4vhS262Uy93Oby8b+5aMoQnw+eo7AOREua84UuHtN1Cgy7A57vQZG9AQ7tCjlcA=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by BN9PR11MB5497.namprd11.prod.outlook.com (2603:10b6:408:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 15:35:48 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::5d0a:7887:8de:b815]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::5d0a:7887:8de:b815%7]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 15:35:48 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <lee@kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <radu_nicolae.pirea@upb.ro>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 1/9] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI
 child node ref binding
Thread-Topic: [PATCH v5 1/9] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI
 child node ref binding
Thread-Index: AQHYznhuMeoB1iibGk+mXpPSE0ii8q30+hiAgAABDYCAAASFgIAAA1sA
Date:   Wed, 28 Sep 2022 15:35:48 +0000
Message-ID: <1d61596b-876b-2eca-f72d-ed38cc36f1a8@microchip.com>
References: <20220922113347.144383-1-sergiu.moga@microchip.com>
 <20220922113347.144383-2-sergiu.moga@microchip.com>
 <YzRiVwzJYXtat1O5@google.com>
 <7a0c45e2-85fc-b5b0-d1de-a9e06a20bb42@microchip.com>
 <YzRnAy0DrfBilz8d@google.com>
In-Reply-To: <YzRnAy0DrfBilz8d@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2758:EE_|BN9PR11MB5497:EE_
x-ms-office365-filtering-correlation-id: f376833e-4419-439e-d952-08daa1671ddc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x/m1ojexbY5xnMivNOL0TVomtn/s4G3WH6zuOWsGgDCyKeZ3hiELZ2YFOl0HK6jNIIbGWl66zgiELC70QwEYS0qLxUVUXln+51R1hfzIwhEXM6+F6quIx3WJfgOAl4Wg2aBGoq0jYzFEdHl0tyfbcLKY9E1LD+69vBA0aZeLVgKj2V225ko8bDaNNJui68xo4zVJ+n6ozuOnJS6/BM7ZVuvgwIqx0FLKsQpmIUCAbyoSMHFIA5Zd71VZGSYHikphUDXYP8Jrl93K5NXQfp1Eel+DtAl4oMXb4hnflgRmQk09KslzXfqiL0bcZ+0pUYFHDpDZyeTfL6vNJiEwdCsnpobadR5U7NPoLW/cK1DgXk3Nz0wQL+PWTYYKQgMGCtypHswwOMfCTTX41sJv6w66HwAWvqndyPEdRfDG53pMZzDPzhNmrGM5NhUPUtG+XJQN/ZDLVPHD7bfrMW+mCbA9oAzD0TsYk70ggZ5/3xrnGBeZfa2ofQcOwzeO1H1x9wyCQNBJ+7v5F7CoLoRHAHEBdeI6G5yyW1btjNah/HaHQgWxq+SRY4C2IMccrlanx4iiu2o2NnoKjKRPl12xzcepNphDnbQosr9j0gda+zWZ/tYSl9sCE4z8m38loG7ViBliE7Grc61IYkl2pZ7KOsRyU7L80h7zLlPt67PZrzlQzp06gwGaNyQyuST89TFiai7FvE+aYHCbzEG1nQG82hgSDVXsZxP7o53tfeVL2CiYk2+OxKUmf7Fy3rsbp+yKySGSCzXhBoz72/2Z2etrSxqIoX0yTnF//oTm6YFJbPoAYrl/dIqneKJMvC5F8KUBMv1T2031xukVF448cnnqeskTQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199015)(31686004)(2906002)(7416002)(5660300002)(4326008)(64756008)(66446008)(38100700002)(36756003)(316002)(8936002)(66556008)(66476007)(41300700001)(66946007)(76116006)(122000001)(8676002)(6486002)(54906003)(6916009)(38070700005)(71200400001)(91956017)(478600001)(2616005)(86362001)(6506007)(186003)(966005)(53546011)(31696002)(6512007)(26005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azM4U1hxaVRwTjgyQTVoTCtMZUVIOG1XVnpvYm1yS2ZSNnprSmlra2s4cnVl?=
 =?utf-8?B?N0Y3bWs4T3FsNXByNU5oS0N1bStmZjA2Yk5CYklZOWlOSHJFZmFQQ29DVGtJ?=
 =?utf-8?B?WDlzVGlqSS80QTNsMUZUT1dPU0ZSQzZCd3F0cE5nNnphSHB6SW5RSUY4RGQ2?=
 =?utf-8?B?bE9ldGhsd3lzbmZOK25lMU1seURKYURtQmxXbkY0Zk5OdFBscldrSWhKeEEr?=
 =?utf-8?B?SFUyUFZNc3Zwa2V4QVkvR0g0K2lCNnlNaEMzVVlQYk1oUmh3MHkyME5DN0dO?=
 =?utf-8?B?dnV4b2VvT1laeGJqZlFIaW5nYjJlaHFnajVIcTRDTTNqbHJQT1Zrb2tBdzFz?=
 =?utf-8?B?N1daQWcvWnd2cHZCNG9CVC9odGJia2xyaDRWUjNNYlFhY0JFVHhjZzVpekNY?=
 =?utf-8?B?SFFoNXp3eittM1puV0RPdXkvTEF2a25zZkxSOTdaRU1KYmRYWVVkMkp4WGdz?=
 =?utf-8?B?Nk9pd0NmZGUzaWhXdnBQbXlPTGdsSVcyaG9Kb2hINjlJRlM4cHFpTWFMaEFv?=
 =?utf-8?B?Z3RETWFPSHFmSTNuNWhRY2ZiVkRkY3lRbEQxM1F4K1ptbU00Z3RPS1ArMjRW?=
 =?utf-8?B?Q2FubVJDUGtBTEdSeXR2UnhqS3ZvTDd3VldxZkZ4ZElEREhGNnM0K3NhYzdO?=
 =?utf-8?B?UjFzdFIwa3NVT3Y2aUszZEt0VDBZcGhqVjQySTNuSEl2YjB5dy8rTDdKWFdz?=
 =?utf-8?B?ZDFKbURObTB5cFlRUHNIVWF3TEtvc01xK3N1Slh5T2E4R3lTd2VCUzBUV05r?=
 =?utf-8?B?L0R1SFpEakdlc1ArTzZQbGhQM0YrWU1KdDY3WFVlNUNpb2RiaTcwajArQUJJ?=
 =?utf-8?B?eVFCMy9HWEdDUUViUTJQb3RJUFkwR2VUSXo1UGZheXlZUThvYzBYbkRmTWFE?=
 =?utf-8?B?U0ZzYWdJTmVDZHBWQlB4WUFzam8yT0Z4dkJ4dDAvaDlkV3BKNW9mbitzYlJx?=
 =?utf-8?B?TVpVVFdDaCt2WlpXN2t4MUM2VC9Day9JSnZUOEx3aUVIQUJJQis0aFJYRUJF?=
 =?utf-8?B?ZHpHRE1XL0x2aGNwQzlmNU5SYkxESU1kMDd0VjRIay8vQkNZT3gvRTlKMXJF?=
 =?utf-8?B?M0pocmw4TzBBajZKOGhrT0NLc2FyelliL0ZraHRGUjQxS1JEek1Tak5YSHBt?=
 =?utf-8?B?bGxka0ZlcHpJUUoyTXJFK0sxcFR6WEhGN2lWUzNURW03UStUZDdmbHVSMUR0?=
 =?utf-8?B?SFlCN04zdXFHTjZLekVlYXVQQkMzS3cwbkdyV0ZaYjNqbGY0WFExbWxBZlhr?=
 =?utf-8?B?K3lZTEpxdEhQSURTZ2RMaGdRMlJncFNVeFUwNjJKVE8wQnE5eXFXMGZZa1Zx?=
 =?utf-8?B?REI3TDFCT1FaYTlWNm5JdnJ5U0x1VWRtTzhHdjRBTDBKKzIxTWptWE9Xa2VB?=
 =?utf-8?B?Z1NKZmhFdTNFcVQ0QlRJeFQvblN0MW1EdGNzaEh4b2lZcVRLWDNhUmFFYjVM?=
 =?utf-8?B?Vnh0blM1TlM1ZjZkSC9mNEVCWTA4L05mUU5VZDNSM3R1eXB2SWcrTmx4ald5?=
 =?utf-8?B?Q3dNOTNHZlNZWEJBWXptbnVQUzNQOWRMOGZoRG1MaW5OeVZKelppUHFFZUVr?=
 =?utf-8?B?aHYwbXlZeElQRVJ6SHcrVFdEVW56enF3OFRtcE04UkJ2Y2ZFVXpHb3RUUUJD?=
 =?utf-8?B?a1UzcVRPeUdSWE4vc0JOdHdaY1l1TTdsZDhZL3RvaFBISTdGanVKRUdyY0RE?=
 =?utf-8?B?ZkZCTnZRcUZTOXAxNjg5MC8rRGR0WDJPV3I2ZXNITGNGTWhMNWx6Sko2YjlU?=
 =?utf-8?B?YmN4OHFsUC9DdlliNVhmUEdTVHk0RlIyMm9iRVhNaE4yOW9oN01IdnNGK3Uw?=
 =?utf-8?B?enYxVmozMDZxNXVmNEhWTExTMzJLaHgwNTE2N3hWQ0dpV0x2bXNYdEpKclh2?=
 =?utf-8?B?Q0huSzRmaUJzeit4WkhJRjYxeUZRWWgxTFBjN29UL0w0U0txWEl3ZTZRYW54?=
 =?utf-8?B?enRMSFdaT3Q1THZpUmY1SkRoZHZQK3RUTVBaOVRaVnBtL2h5ZGxZQjVqa2x6?=
 =?utf-8?B?Ym5SN2N5MXB4eHZEWk9pWHF5YWZmU29RWmMxd3dxc1FkNTVhMjhxUzVkRkJ5?=
 =?utf-8?B?Rmt0RnRObVBNb0xwMzFSejFVK2FSRjF0ZVM2MTZhYUFERjlhbFhQY1YwYzlz?=
 =?utf-8?Q?+I9ty5VJ3dmB6cjFfP7XypDOd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88449E6A8D00E54ABFE7BB253028DBB6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f376833e-4419-439e-d952-08daa1671ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 15:35:48.0594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I7n71reElSSpp/o5rfRKJYVX8pqBd/psh//SmZDLYEtvyNcEy2M5FRDXPHMGNVSVU19rgE9hF/LgCoMoKMWrd+5VO/juKarPOEjXLTiLKNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5497
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjguMDkuMjAyMiAxODoyMywgTGVlIEpvbmVzIHdyb3RlOg0KPiBPbiBXZWQsIDI4IFNlcCAy
MDIyLCBTZXJnaXUuTW9nYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiANCj4+IE9uIDI4LjA5LjIw
MjIgMTg6MDMsIExlZSBKb25lcyB3cm90ZToNCj4+PiBPbiBUaHUsIDIyIFNlcCAyMDIyLCBTZXJn
aXUgTW9nYSB3cm90ZToNCj4+Pg0KPj4+PiBBbm90aGVyIGZ1bmN0aW9uYWxpdHkgb2YgRkxFWENP
TSBpcyB0aGF0IG9mIFNQSS4gSW4gb3JkZXIgZm9yDQo+Pj4+IHRoZSBwcm9wZXIgdmFsaWRhdGlv
biBvZiB0aGUgU1BJIGNoaWxkcmVuIG5vZGVzIHRocm91Z2ggdGhlIGJpbmRpbmcNCj4+Pj4gdG8g
b2NjdXIsIHRoZSBwcm9wZXIgYmluZGluZyBmb3IgU1BJIG11c3QgYmUgcmVmZXJlbmNlZC4NCj4+
Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogU2VyZ2l1IE1vZ2EgPHNlcmdpdS5tb2dhQG1pY3JvY2hp
cC5jb20+DQo+Pj4+IFJldmlld2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yu
a296bG93c2tpQGxpbmFyby5vcmc+DQo+Pj4+IC0tLQ0KPj4+Pg0KPj4+Pg0KPj4+PiB2MSAtPiB2
MjoNCj4+Pj4gLSB1c2UgZnVsbCBzY2hlbWEgcGF0aHMNCj4+Pj4NCj4+Pj4NCj4+Pj4gdjIgLT4g
djM6DQo+Pj4+IC0gQWRkZWQgUmV2aWV3ZWQtYnkgdGFnLCBwcmV2aW91c2x5IHRoaXMgd2FzIFtQ
QVRDSCAzXQ0KPj4+Pg0KPj4+Pg0KPj4+PiB2MyAtPiB2NDoNCj4+Pj4gLSBOb3RoaW5nLCBwcmV2
aW91c2x5IHRoaXMgd2FzIFtQQVRDSCA1XQ0KPj4+Pg0KPj4+Pg0KPj4+PiB2NCAtPiB2NToNCj4+
Pj4gLSBOb3RoaW5nDQo+Pj4+DQo+Pj4+DQo+Pj4+DQo+Pj4+ICAgIC4uLi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21mZC9hdG1lbCxzYW1hNWQyLWZsZXhjb20ueWFtbCAgICAgICB8IDUgKystLS0NCj4+
Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+
Pg0KPj4+IE5vdCBzdXJlIGhvdyB0aGVzZSBjYW4gYmUgaGFuZGxlZC4NCj4+Pg0KPj4+IEkgZ3Vl
c3MgSSBjYW5ub3QgdGFrZSB0aGVzZSB1bnRpbCB0aGUgb3RoZXIgcGF0Y2hlcyBhcmUgYXBwbGll
ZC4NCj4+Pg0KPj4+IE5COiBUaGUgcGF0Y2ggZG9lc24ndCBhcHBseSBjbGVhbmx5IGFueXdheSwg
c28gd2lsbCBuZWVkIHRvIGJlIHJlYmFzZWQuDQo+Pj4NCj4+DQo+Pg0KPj4gSGVsbG8sDQo+Pg0K
Pj4gVGhlIHNhbWE1ZDItZmxleGNvbSBiaW5kaW5nIHJlbGF0ZWQgcGF0Y2hlcyBhcmUgZGVwZW5k
ZW50IG9uOg0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYXJtLWtlcm5lbC8yMDIy
MDkxNjA3NTc0NC4xODc5NDI4LTEta2F2eWFzcmVlLmtvdGFnaXJpQG1pY3JvY2hpcC5jb20vDQo+
IA0KPiBJIHdvdWxkIGJlIHZlcnkgY2F1dGlvdXMgYWJvdXQgcmVseWluZyBvbiBjb21tZW50cyBt
YWRlIGluIHRoZQ0KPiBjb3Zlci1sZXR0ZXIuICBCZXR0ZXIgdG8gbWFrZSB0aGlzIGEgaGFyZCBy
ZXF1aXJlbWVudCBhbmQgcGxhY2UgdGhlbQ0KPiBpbiB0aGUgc2FtZSBwYXRjaC1zZXQuDQo+IA0K
PiAtLQ0KPiBMZWUgSm9uZXMgW+adjueQvOaWr10NCg0KDQoNClVuZGVyc3Rvb2QsIG15IGFwb2xv
Z2llcywgSSB3aWxsIGtlZXAgdGhpcyBpbiBtaW5kIHRoZSBuZXh0IHRpbWUgdGhpcyANCmhhcHBl
bnMgOikuDQoNCk90aGVyd2lzZSwgYnkgYXBwbHlpbmcgdGhlIHBhdGNoIHNlcmllcyBsaW5rZWQg
YWJvdmUsIG15IHNhbWE1ZDItZmxleGNvbSANCnBhdGNoZXMgc2hvdWxkIGFwcGx5IGNsZWFubHkg
YWZ0ZXJ3YXJkcy4NCg0KVGhhbmtzLA0KCVNlcmdpdQ0K
