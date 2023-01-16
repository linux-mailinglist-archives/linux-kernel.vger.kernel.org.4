Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359A666BAEF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjAPJxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjAPJw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:52:28 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C48F18B24;
        Mon, 16 Jan 2023 01:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673862731; x=1705398731;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=wWdCxwe7BocJf2RzLd7miNa4I4WQnc2U+8cOOOV8F+s=;
  b=ZcnOcCBani/mmdz4SsiYXgmDQFKfHUWnD26y1W62PtNyE1fwwIF/R1ej
   kOI8sZ6j5jla5R5D3CgClD6kVb6RAUvnEJ9zcCXkX19SztAwSyygNLF8f
   6d0o6gUpaCtz2a9/1J1Us/6CT84VL5HINcXuvJ/VCjKr5kMrxltzJ0oYA
   16sdoHuxlrRONQzWm6KTE3UnQMEhzpq4uHkZlqN+BgL8uqfgT0siuPR64
   6iFtbKW5+9UAVuCILAgIdvTjcDHxkhbmVjzqlCpIAfFSWIJa4b+Ouv061
   /nCUK+4LNF0Z8RAqGcroTKWbcY1H6L3hkAGIzW3g+Z1J6jB6SUuQi8yl8
   A==;
X-IronPort-AV: E=Sophos;i="5.97,220,1669100400"; 
   d="scan'208";a="195941822"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jan 2023 02:52:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 16 Jan 2023 02:52:09 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 16 Jan 2023 02:52:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLWziGEkYIQjl07tXMxHS3GRq2QA4UlvZ5Frx4CtbCppmgOYyUAjQqGyvjILjLMw6FkYxjBQb+uQb2Chc5oBBEijVWBETx5e4+57W4bSgbikWb/zL1ovxXm+69W7olxw+vjfqR41mxWlDpMC592ukO8YIzz0aNForn4SqJiPC/5S9gHc8XVujwshKZA9M8/bGe9tinlJwkifcxSgIQOJM9so9IOe7Cx224/0iraovLx2pYTzEGCCSAcnemzuTTSVMu1Dpcp5P6kRjqXBSlNqaF8b4dgeuaQnog3xb2HyiKtUehqdcv6L1hBIchKe7g4TvTP/o0gwbb8sO5AQyWx+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWdCxwe7BocJf2RzLd7miNa4I4WQnc2U+8cOOOV8F+s=;
 b=mPRudQC0czrrzSf2taJTMZ61OznCGsnhul/bFzTmgN8fw0jcPsWzAbPxJLbjOd/QV5r1ys3xIrB9nmyXI+mZtJ4VQHmDHaGrOaqmqFYyS6M+iw7IhT9SKzyk8Ngw53R939ADUSRbfUJuliiFCG9auVK7wp2SHsYm3h6s8eXLhIPeixRGS+LcdF1pm90o+i/EujLqKhTNFrNYHThDE7wacYhtpCvH93ZFvpXLp743Dy0t3X/CnxUxBp5h3q/Mz0+TpgHdai+uPRGo0QRpfOxy8Q/Bm1YIDp5EJpdet1esLMuRem4azkQldj+waQ2bWtROhFr14SyD1GaX3x56w3f/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWdCxwe7BocJf2RzLd7miNa4I4WQnc2U+8cOOOV8F+s=;
 b=QxkjHck3jncl+t5W+UTC54hvuwUS3yVvp76U4IlC6kbBdCORuuhetlsf1LRudXbkTmelsKZOVwWPax0bdvDW7KJH+tE7x/cVwaLS4Gfe42OUQf10y0an6d32hWbWdJalf7OWSMm4s/Hmaxji8NUOj0PgLiaC2E/aTDI2WNF0L1A=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 09:52:06 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::2177:8dce:88bf:bec5%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 09:52:05 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Durai.ManickamKR@microchip.com>, <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Manikandan.M@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Dharma.B@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
        <Balakrishnan.S@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <krzysztof.kozlowski@linaro.org>,
        <alexandre.belloni@bootlin.com>, <davem@davemloft.net>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <Horatiu.Vultur@microchip.com>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <michael@walle.cc>, <Jerry.Ray@microchip.com>
Subject: Re: [PATCH v4 1/8] ARM: dts: at91: sam9x60: Fix the label numbering
 for the flexcom functions
Thread-Topic: [PATCH v4 1/8] ARM: dts: at91: sam9x60: Fix the label numbering
 for the flexcom functions
Thread-Index: AQHZKZAwgjTzdlIBO0OShrzfv92JpA==
Date:   Mon, 16 Jan 2023 09:52:05 +0000
Message-ID: <9f433fb3-dade-9544-b1b8-8fee4b60bf66@microchip.com>
References: <20230112110208.97946-1-durai.manickamkr@microchip.com>
 <20230112110208.97946-2-durai.manickamkr@microchip.com>
In-Reply-To: <20230112110208.97946-2-durai.manickamkr@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|PH0PR11MB5808:EE_
x-ms-office365-filtering-correlation-id: 3d69edf3-2f9f-4e91-f5f0-08daf7a75363
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5yRc1huEJxdQNreGm0Q4SpyBfhOkFJfboL/EIaFETUiBZLadG/W8Notvv/YZVuL/hBN0TJMBLFp2AcCPXRKrOJ+dOLh6+DMJtCvMekZ50+R1UkHEyXvDjZ1COoPY3/rUelDxrpB2I3FDBpj97J0WZfsBbIFYEPQGJpEchrnlmanvc9/VyC2ixWz1HB/bza7ZX9y0P3WzJ73vhYgI0KWdO3P5N95WlHrYu4S886X0OHONqRP0RfAVwZAQxQxMxfj2DH9j/XTX/fPgeVgJsffJ83ua/oAMqXgMWo7vPeayS+T7Qfn8E8gp5B4CDIsWAKdNPK5UP1+oktwWI7zO0Kuuz8dtiqx7Iebrw63pBnfCtl8f5+d1+mZHs1rZdYgcZfhOPLTfR0+TC4l/bsgPemiyA94OLXD1jrRaMV1KSvqvI5YCBvFswtHUD+8C9ZdpZsPs7pTKOFcbB6qRm7SulxDsp0qARb01kSs7aFXR1rPlOzid8dq2hFTloWkTKSnJvikD6becom4tAjgjcUB3i8Ymco5BvldUdJw1O1uKBdjbTy3hWW/Kgb+vBNREJ1NZeuX2aro7zAiw1PpRwbnOrgBdWSLmq8eBNXKt8NlA2I9fHsOGPUYRjNph/OHM+GkG/jFGevjeJ0FdqhWFun+h22w6UhYypS+BksQZHF22y5poYPJZ2iWBxjiZ/l5gET4/fOIigEhEi+SZcX2LZbDf8oRNvL4H9eh/wNxo/9DgOHARfL1lUllQjN6m0V5UWNvfLizMbFUWTYGuoN2b3QGqPvQ7Gg8fqBM+jZc+b88hkuH0UVs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199015)(36756003)(53546011)(86362001)(6512007)(186003)(26005)(8676002)(64756008)(91956017)(66556008)(41300700001)(76116006)(2616005)(66476007)(66446008)(66946007)(316002)(71200400001)(6506007)(110136005)(31696002)(478600001)(6636002)(7416002)(122000001)(6486002)(38100700002)(38070700005)(921005)(2906002)(83380400001)(5660300002)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZitoNEZEYzZ4MWFTandqaEVsNmk5Q3RlM0FTZE00ckZXRkxvZFJwOFJMZkVQ?=
 =?utf-8?B?M24rWnNHZnNleHdFZjdEdlZCSmNEUW9NOVIzRFVsQXdKNUt5bC9aKzhRS24r?=
 =?utf-8?B?NWs1cFBWbUcrL3hUOXg5VjBrSzhCNlA5NFZXb0Rmc2lwUU5ZM2tEU2pVWnVk?=
 =?utf-8?B?N1VidUpBdkJhVko1SmNBQkxiZzNUcU94WVNIOFpGcys0OXRyYnRVMnR0M0V5?=
 =?utf-8?B?VWp5ano4Rm52OGllbHBBbGNTL09NV09Zd05jOHFMbVdsYk5pNHFGZUZGWnB5?=
 =?utf-8?B?VUltUkxqVElCUncwdktCV1R5aDZjaTR5cTBGczRhYUtSYmVHc2VQTG95NFM0?=
 =?utf-8?B?NEJ6RnVVdmU0SDQ1NXRTaDM4NjN0NkZITEY0UmxHVUFWVkt2MXFKQnppbDAw?=
 =?utf-8?B?WkZKVHVaSi9LL1B2aEN6RjVQMDdCblJvZjZkdVAwU2VrQ05zOUtqTExYc2Ni?=
 =?utf-8?B?aUJYQ3BWM1F0QTkxUCtVaTZWZlNKY1QvcS9SZFpMMGM1Q0tLNzQ3Qk5DS29C?=
 =?utf-8?B?OFNraGFoSUNmaTFvR3MzaVRKeEtJMFhIeXdwY2J3S3JLK3hjZWc2MXJpWlFT?=
 =?utf-8?B?MzBBOFRLUnVnYy9DQ2dyM3JxN3dHd3g3NVZxWE9nVVdRNDBNM2JVeTRZK1Yw?=
 =?utf-8?B?MVl1RnJkRDR6SW9KaTlzcE1hTk5lcVpVcXdTK0gyVld3Y1l3TmdLZzVXVUZx?=
 =?utf-8?B?SmZkMXpmcnRReXp2OFZPVzBudFIwb3NLaHZ6MTRlKzBtcTFaNC9PdnZ1WHJR?=
 =?utf-8?B?OXBJWnhLb2dCSkppN0lyUkhKZkd6bUkwL01nUTJZb29uUWEvR3A2ZUF3MCto?=
 =?utf-8?B?ZENkakRJN21PTTBEYTNRRmJ2TExqMmZSZzZXVnBtZDQ1dmp6SHYxTU01OEdW?=
 =?utf-8?B?RGJCTlBDUkh4NHk0ZUxuaFphTk9DbUJWOWt1QXowTStWMGhITGppRHpNSDhE?=
 =?utf-8?B?blBRUC82NUljdzJhdUluVjY5WE1SQ3R3WlJYN2VLVytVaE1zWnJYczE1Uy9H?=
 =?utf-8?B?UXFhWWhFajVGUlJ0S0lVMzBSS3hZSEc4SVRsOWQ4dC85bEtmMGNBMTRIQnly?=
 =?utf-8?B?cCttbFdBcjBuaGxIaUZsaUIxWUJuRklTOEZaRTNnbmYzVXpERWtHcGlkM2FM?=
 =?utf-8?B?ZlplUVlIVTkra2xxMzVDU2dSN05TUFoyYjlJcnc3VS9iSXFRaUFJWHlKc1dk?=
 =?utf-8?B?bmxxbitJYjRIa1FrR3hVMTdHU1M2eDJSbWMzVUhvZGRrelBLNUhkR25NYlBh?=
 =?utf-8?B?NXpUTGdKMGJvK1d6WHZHb1ZWTktyUVVtWGRRNjJ0RmNIT3pZMk1SSnFpNzZH?=
 =?utf-8?B?VWJscGFrejNOajVISnF2YWRnUmFHTXQvTkpQY3g4bWlYa3lDYzE3QW9xN1d1?=
 =?utf-8?B?cHJOZVYyNHFuemNsS2YvL2FwakJzM0FOeEZ4YktVWGFiUUkvaWNzekc1QWtH?=
 =?utf-8?B?b3RsQTdCbWE4Vnl6ZmdCVDhpcHJXVkxQQklzT1d1Z080bjUxM1V3dDN1YlZW?=
 =?utf-8?B?OWlINGVoSVJVcGREZUdaVU5XcG5mU3hPcVlodjNBTnFRa013akFUTVlkaFZi?=
 =?utf-8?B?VVJwVXpVQkJKa0szb3AzOEdwRlBuWTF3Zys3aUg0Znc4MU54eldZY1crc2dX?=
 =?utf-8?B?WEhHZHdUbTBtdCtRRC9keEZaUUIyUzVkSk5zaUJVTkVjUmFoenZSYVVnY3hH?=
 =?utf-8?B?SW9XODJZdlN3a3hvYVFpNmFnd1VqOXByRzRrTk82YVcwdlg2c1gwU0k3K2Zw?=
 =?utf-8?B?SjRtcEVnQnlNdlAxRUE3ZW82Mit5MlNod1NDczJEdUhxVzRZdXpwMGxCN1VU?=
 =?utf-8?B?MGc2OGhOM1h0UG1DMDFVaTYrSXorR1NnTWQwVy8xdkNjdXUvNXBxTEszYVJQ?=
 =?utf-8?B?aHh0YW1teXhBaWFoOE0vSy9GaXFoUkFENUticHFQMGVMK2JKR2I3NWVlc3I3?=
 =?utf-8?B?MEZDa3VoR2E3YUpZMlhuN0kvY0oweVRLWmJsZVJHdmxOd3k1VlIyNnEvL3g1?=
 =?utf-8?B?YVRhTUlKbDBsWE1RUzBIelI1c0tETVg5OE0rcFUwMWNPU1MwbDRqREQ3bzVD?=
 =?utf-8?B?QnJEU090ZGVjQTBvMG13Q3BXOHN5UmQ3ZDV5MDA2SFRtNWszNXE1NVhFWGpv?=
 =?utf-8?B?WUpaT2FNemJMbG44NmJkQnBmUU1wZTNKeUl5dTUyeTM4UWNWYkVRbDJkajBj?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C74D9F10CE96524B97FEB9B7F32AE2AF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d69edf3-2f9f-4e91-f5f0-08daf7a75363
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 09:52:05.6536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qakW7y9GV5kSTkfZvWWEGvOsuDKQmGEpagLCu6XHEXDEWNCAEshDZizamGlZyDdiO7/OGhQTCSjH6mB0cJ9YK9tIQwDDge5noTilf3P8/1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5808
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIuMDEuMjAyMyAxMzowMiwgRHVyYWkgTWFuaWNrYW0gS1Igd3JvdGU6DQo+IEZyb206IE1h
bmlrYW5kYW4gTXVyYWxpZGhhcmFuIDxtYW5pa2FuZGFuLm1AbWljcm9jaGlwLmNvbT4NCj4gDQo+
IEZpeGVkIHRoZSBsYWJlbCBudW1iZXJpbmcgb2YgdGhlIGZsZXhjb20gZnVuY3Rpb25zIHNvIHRo
YXQgYWxsDQo+IDEzIGZsZXhjb20gZnVuY3Rpb25zIG9mIHNhbTl4NjAgYXJlIGluIHRoZSBmb2xs
b3dpbmcgb3JkZXIgd2hlbiB0aGUgbWlzc2luZw0KPiBmbGV4Y29tIGZ1bmN0aW9ucyBhcmUgYWRk
ZWQ6DQo+IA0KPiBmbHgwOiB1YXJ0MCwgc3BpMCwgaTJjMA0KPiBmbHgxOiB1YXJ0MSwgc3BpMSwg
aTJjMQ0KPiBmbHgyOiB1YXJ0Miwgc3BpMiwgaTJjMg0KPiBmbHgzOiB1YXJ0Mywgc3BpMywgaTJj
Mw0KPiBmbHg0OiB1YXJ0NCwgc3BpNCwgaTJjNA0KPiBmbHg1OiB1YXJ0NSwgc3BpNSwgaTJjNQ0K
PiBmbHg2OiB1YXJ0NiwgaTJjNg0KPiBmbHg3OiB1YXJ0NywgaTJjNw0KPiBmbHg4OiB1YXJ0OCwg
aTJjOA0KPiBmbHg5OiB1YXJ0OSwgaTJjOQ0KPiBmbHgxMDogdWFydDEwLCBpMmMxMA0KPiBmbHgx
MTogdWFydDExLCBpMmMxMQ0KPiBmbHgxMjogdWFydDEyLCBpMmMxMg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTWFuaWthbmRhbiBNdXJhbGlkaGFyYW4gPG1hbmlrYW5kYW4ubUBtaWNyb2NoaXAuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBEdXJhaSBNYW5pY2thbSBLUiA8ZHVyYWkubWFuaWNrYW1rckBt
aWNyb2NoaXAuY29tPg0KDQpTYW1lIGhlcmUgd2l0aCByZWdhcmRzIHRvIEZyb20gYW5kIDFzdCBT
b0IuIFBsZWFzZSBjaGVjayBteSBjb21tZW50cyBvbg0KcGF0Y2ggMi4NCg0KPiAtLS0NCj4gIGFy
Y2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtOXg2MGVrLmR0cyB8IDEyICsrKysrKy0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMgYi9hcmNoL2Fy
bS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMNCj4gaW5kZXggZDkyOWMxYmE1Nzg5Li5jZjVk
Nzg2NTMxZjIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtOXg2MGVr
LmR0cw0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMNCj4gQEAg
LTE2LDggKzE2LDggQEAgLyB7DQo+ICANCj4gIAlhbGlhc2VzIHsNCj4gIAkJaTJjMCA9ICZpMmMw
Ow0KPiAtCQlpMmMxID0gJmkyYzE7DQo+IC0JCXNlcmlhbDEgPSAmdWFydDE7DQo+ICsJCWkyYzEg
PSAmaTJjNjsNCj4gKwkJc2VyaWFsMSA9ICZ1YXJ0NTsNCj4gIAl9Ow0KPiAgDQo+ICAJY2hvc2Vu
IHsNCj4gQEAgLTIzNCw3ICsyMzQsNyBAQCAmZmx4NCB7DQo+ICAJYXRtZWwsZmxleGNvbS1tb2Rl
ID0gPEFUTUVMX0ZMRVhDT01fTU9ERV9TUEk+Ow0KPiAgCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+
ICANCj4gLQlzcGkwOiBzcGlANDAwIHsNCj4gKwlzcGk0OiBzcGlANDAwIHsNCj4gIAkJY29tcGF0
aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC1zcGkiLCAiYXRtZWwsYXQ5MXJtOTIwMC1zcGkiOw0K
PiAgCQlyZWcgPSA8MHg0MDAgMHgyMDA+Ow0KPiAgCQlpbnRlcnJ1cHRzID0gPDEzIElSUV9UWVBF
X0xFVkVMX0hJR0ggNz47DQo+IEBAIC0yNTMsNyArMjUzLDcgQEAgJmZseDUgew0KPiAgCWF0bWVs
LGZsZXhjb20tbW9kZSA9IDxBVE1FTF9GTEVYQ09NX01PREVfVVNBUlQ+Ow0KPiAgCXN0YXR1cyA9
ICJva2F5IjsNCj4gIA0KPiAtCXVhcnQxOiBzZXJpYWxAMjAwIHsNCj4gKwl1YXJ0NTogc2VyaWFs
QDIwMCB7DQo+ICAJCWNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNhbTl4NjAtZGJndSIsICJtaWNy
b2NoaXAsc2FtOXg2MC11c2FydCIsICJhdG1lbCxhdDkxc2FtOTI2MC1kYmd1IiwgImF0bWVsLGF0
OTFzYW05MjYwLXVzYXJ0IjsNCj4gIAkJcmVnID0gPDB4MjAwIDB4MjAwPjsNCj4gIAkJYXRtZWws
dXNhcnQtbW9kZSA9IDxBVDkxX1VTQVJUX01PREVfU0VSSUFMPjsNCj4gQEAgLTI3OSw3ICsyNzks
NyBAQCAmZmx4NiB7DQo+ICAJYXRtZWwsZmxleGNvbS1tb2RlID0gPEFUTUVMX0ZMRVhDT01fTU9E
RV9UV0k+Ow0KPiAgCXN0YXR1cyA9ICJva2F5IjsNCj4gIA0KPiAtCWkyYzE6IGkyY0A2MDAgew0K
PiArCWkyYzY6IGkyY0A2MDAgew0KPiAgCQljb21wYXRpYmxlID0gIm1pY3JvY2hpcCxzYW05eDYw
LWkyYyI7DQo+ICAJCXJlZyA9IDwweDYwMCAweDIwMD47DQo+ICAJCWludGVycnVwdHMgPSA8OSBJ
UlFfVFlQRV9MRVZFTF9ISUdIIDc+Ow0KPiBAQCAtNDM5LDcgKzQzOSw3IEBAIEFUOTFfUElPQSAx
MyBBVDkxX1BFUklQSF9BIEFUOTFfUElOQ1RSTF9OT05FDQo+ICAJCQkJIEFUOTFfUElPQSAxNCBB
VDkxX1BFUklQSF9BIEFUOTFfUElOQ1RSTF9OT05FPjsNCj4gIAkJfTsNCj4gIA0KPiAtCQlwaW5j
dHJsX2ZseDVfZGVmYXVsdDogZmx4X3VhcnQgew0KPiArCQlwaW5jdHJsX2ZseDVfZGVmYXVsdDog
Zmx4NV91YXJ0IHsNCj4gIAkJCWF0bWVsLHBpbnMgPQ0KPiAgCQkJCTxBVDkxX1BJT0EgNyBBVDkx
X1BFUklQSF9DIEFUOTFfUElOQ1RSTF9OT05FDQo+ICAJCQkJIEFUOTFfUElPQSA4IEFUOTFfUEVS
SVBIX0IgQVQ5MV9QSU5DVFJMX05PTkUNCg0K
