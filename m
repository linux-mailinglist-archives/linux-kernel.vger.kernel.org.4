Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372BF5B8214
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiINHhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiINHhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:37:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EDC6F578;
        Wed, 14 Sep 2022 00:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663141050; x=1694677050;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=tZKWjYEL4fMnSVXOBe07BMhkhcsFsMQCKisDg0EEWFQ=;
  b=IHRSKdD42qMSxQHf7s3Etj6jDvPML5G7dtixLvScg/aG8HIniQh8tZW6
   8jo+bp9ZK4J24uS/kvfUOex+je1/y81rSq/z83VTrq22ycCDihUilqWym
   Ex1ra0aKnQXiLOySejf3sHIj/IvylgXHEmAlPakS8LfKvInNWC8ubMzpX
   Jj9HVYBCuU9nNSkpBchorzyzqUTaMPec+g61fg9UzRPkB8KJUO8qW3iQD
   Zscsxr5GJp77+KxPjI5oz28lX5k/n/cjCyc284vkb4NCtQuUZK5IkmyRk
   AyIeBKnTnLdsufxoPvI4STHcrx6QYeLOp6smQIKzQ+rYd503uM748TPi5
   w==;
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="173781588"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2022 00:37:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 14 Sep 2022 00:37:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 14 Sep 2022 00:37:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTqbW7rvZQLdZKxhgBU6gI/sMRX2WYFTvV3EtAttL5LAF80/gOoSAYF+QkEPe6qI5r99GneGGK1YazU62r2VF+DubN5oID7ybn8fTMFBXQai6EqQsdo1ndDEUkX7VHrf/g2bAujzuTs2c4M6z2zMs6UHC6ylwF+066EHW4BfMLctQKQmyCRl+LZZV0H/iXsj0TxL0d3wX+tvqMZSqj+2qk798FSQj7pBxqEkZ7K43f54zMQp46VF8sReANWI+knCdcPKSNaRAQRquIpDCPkJBCKyo+XB3+oO81rh5eoEOwwT2IXvJc2gY4qhWhXngPyYDZZ39hxOLnUm60X47gHl6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZKWjYEL4fMnSVXOBe07BMhkhcsFsMQCKisDg0EEWFQ=;
 b=TyH9fIs2TJtOme1WnRJl+CA9rPXTgRF/Geu3hs0ui8SCehMu3jxIhjW02Q2XIPywryI1rSz0c05tgHWWdpv1sAEYmiVbfHw0JPVowina4gF3BiMioSoVwr8Vb18Rd6cNoQzWYTo1T0BBWu3+9gkvROTxElxGqdrRF7Jc9d66OqGRgSV9wzAOHSljLMDsRksxsIdoI1NxVKDw5HR0FT73V+MxIuW0ZxsdkUtaR0PuFbtCUKTPSVhRc8cwI71uALxYlt222HAisggclNYELpWUH/LkqVWVCec3E91r4M0lS3Zq6qSbmGsosu3ThlXCLtA2Bpl1FtdFKYfdly1z3MPSzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZKWjYEL4fMnSVXOBe07BMhkhcsFsMQCKisDg0EEWFQ=;
 b=GV0+QqKpOcQOfhTeYQIkRK3wmMfB4ZTKXHJr+SiUcWycmRUB4IXftDaLgRKEZoO0NuiACZxh4+SJGHn6mIf6lp2dd/O7r07WKdEMYzHy4QbIOcnBoHLLaLa/XJYI8MgkvpGAwnezGmSVWE2fQMFN1Hz1pGR1ktRVpJpl4LK4K6U=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN9PR11MB5305.namprd11.prod.outlook.com (2603:10b6:408:136::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 07:37:25 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%11]) with mapi id 15.20.5612.022; Wed, 14 Sep
 2022 07:37:25 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <Jerry.Ray@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [linux][PATCH v9 2/2] dts: arm: at91: Add SAMA5D3-EDS Board
Thread-Topic: [linux][PATCH v9 2/2] dts: arm: at91: Add SAMA5D3-EDS Board
Thread-Index: AQHYxztHC+vfWmKhVkOZg1ztY5Z9hA==
Date:   Wed, 14 Sep 2022 07:37:25 +0000
Message-ID: <612f0719-2d9a-e005-b9d5-9042661199ed@microchip.com>
References: <20220909163022.13022-1-jerry.ray@microchip.com>
 <20220909163022.13022-2-jerry.ray@microchip.com>
 <eeca0eef-e73e-847f-de54-1511dddff842@microchip.com>
 <4e0487de-971c-7bb8-bdd6-7013a48ee4a6@linaro.org>
In-Reply-To: <4e0487de-971c-7bb8-bdd6-7013a48ee4a6@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|BN9PR11MB5305:EE_
x-ms-office365-filtering-correlation-id: 7b642ce7-999c-4d35-eacc-08da9623f817
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mxR/IX5NCmZcb2GrcqflCpgQA15cyIhP/4urgk1IF5sjQtXSLQ5Lj9dkOVUyQvlJyrabbeOT5NxRm7MBnWdPVeKEO9pU/lZUGGEeh1NYlIE5FwUlsNiUiw+3/hP/oA+oT5Vn1t16mip8VFq/KH7derXvmqm+ACwsHDejYvsLumpQJwU+bt53JlqAlZH4XghUintOAsvRh6qeHu1jpnbdjddTVs1bdrxC33dcsPVaZ/sZ5htL3XPFAvrQPuGh/JsNCjUFiMoZwuf6PGd+BaQhenC1YK0ueazF3o130rRWMf5Gbl7m2L/uvuNzNCA+AHhhpOdKeE+82CJ4taJcG6OYRIcv4BMJ6sRKOySbIu8n7/cJm403vK2sTFoYHW40z/fZRIDjK6DeeLw8utRxdCIrMYkr5RwY5Y+2s3YSGldeXmM74ZNEsqWCuJi7bL0dn9jlCVcdqKHhmO5MQ5J09EK8B2iLY1htBeq+KbXcfILksjjGwpZuV9JafSSPcDxJLzUJHkHcLyZG77x6r5oKCulVuxW3PHiJrf6JKrNQH8b9OQXfUNZR+QZVTdsKeXeVLY4n4IEyBJn0fM6lGDlVxruarubmQgpOAC8pE+BulrZBPWw9jD7ThzJ+gvsrBEvRCEj6vNxZDE7p5PZDNmxZzMJ4tfS/9lnDB5cvpEOP+yeJiOvzxH27G6TNjDgerPdNy7rPAaVM5wHgzBXdWlKl/yZs/cHPGFARIL1Fvuq3Aqck5b3ynP6UregdZ5n3eg07QjmIq+K7PO8kTZr9Lgfw8FLv3ey1RnLpQ7pLwXdPSw6LHU3dAwwYLTw1fi4ZrkQdgwPOhVg7n++n8j1K3IkEAxzeqePYRXqL02QxQHOJHwFKU+A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199015)(41300700001)(478600001)(2616005)(31686004)(36756003)(38100700002)(6512007)(966005)(91956017)(66946007)(66446008)(6506007)(26005)(316002)(38070700005)(6486002)(66556008)(71200400001)(53546011)(186003)(110136005)(8676002)(64756008)(122000001)(2906002)(5660300002)(8936002)(76116006)(86362001)(66476007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTgyek1CRDlZMzBzY1JJc0k3QjdWUXZoeDdkdjdlRDVJdGlnM1dnZEhhVVYx?=
 =?utf-8?B?STcxemk0ZHVJYUlEUmsrM0V2UnZPS1BwVW1WOGd0M296Znl4SDExUHRRWUlC?=
 =?utf-8?B?YmtRd2pnMVBmUlFVY2VtTDZubUpMSEZST1NyejhMWWpmb3lHdEN5SFlENmlH?=
 =?utf-8?B?WUdhRmp1WXpEOERqTHBpSk42MFBGVlArVy9yVmQzcS9tbytVTnBWQzhIZ3Za?=
 =?utf-8?B?cjRwNDM3c3hWTlo3aVJ5MjRCTUdQYVpLck93VWFxbVo4dkVoYnBsaldscXBa?=
 =?utf-8?B?TXVldCt4bXdjVXlLbWdTYm4wVkI2dVlZWTdmdE1pdGdsSHE3d1kwYS9Ba1Bq?=
 =?utf-8?B?Tm00Rm9jNktRZm5FM04wT3RaMnRPNGk2d1k1aStuZ0xENkM1SkwxaFd4ZGtX?=
 =?utf-8?B?Q2g3WmhNVkdLWU10UDluUmgwL1VCMWl1SXpydVpWK293VzBZRFVrNjlSU0U2?=
 =?utf-8?B?MHc1aENpZmxRQ25oQXVPSVdGbUtPUUR0RWtzUFRVWi9tQ3JvZVk4bTZVQXBC?=
 =?utf-8?B?eGZyUU1yQktUNHE1SnNRRUtRWk94N2hhYVIrNTRsaUxPVnNTeFBtTjF5eUI1?=
 =?utf-8?B?MXNXUUZEcVYwVEhueXFjUUVpUytSa2hLRWMxK3dZQ0tWYllPdFNIdmJ3bUY3?=
 =?utf-8?B?ZXQ5V0JGQTVWK0RkMzBSKzRBU0Q4eTFmUHIzRWN4Zncvc1dGUm9VcU1xcU5S?=
 =?utf-8?B?THE5bW5MQUtiQlFXbVZ2NVZJYWxzcVFoL0VJZXZRRkQvYm5kTGcyZzdWNHp3?=
 =?utf-8?B?OG5mOVg2eGNkY3c5dC9kY3IzelR5L3ZXMk9meTRkNHFsV2tERUs2allydENz?=
 =?utf-8?B?Nmd0RzBwSy91N1FEWkdZWlhCNTdZMER0cC90YUFXdmVMTlVDNWZGcG9Qc3ds?=
 =?utf-8?B?VTJrdU9vREJrZ1cxYVlzMy8zeG1aZGZRblYrV2lkR0lqbW1wUTRZZWN1UmRw?=
 =?utf-8?B?T20wZ1o4QlBnUDVsbC9ZY3ozcnNnMW5ucTRMMFdIQVlDUDJNRlpPSVVwNEow?=
 =?utf-8?B?bTMvRFErS2ZxalAxZncwRTJydGgzNnc3Y0ZMdW5paXFGQXAwY0pCMys2UTRh?=
 =?utf-8?B?cmEyVDlpbEUyZFk4VWlHeUxuRzQ1RFNoRUZGc3hScTZqU25mZk9ZUUtjZGht?=
 =?utf-8?B?QS81VHlwNU9DUmx6cTBKN2JNaDFraUVGSzFWQjl2NWlqVmV4Z2dodURwVzJQ?=
 =?utf-8?B?UjNUVDNIQXRzekFrLzVJOHNaaGhuNTJOTG11MDNyWE1MTnNVbEc1bXFyZkhE?=
 =?utf-8?B?VnMySXJrR2lRSTdhZEZTa2FNcjFGL2p5RElnRU9zOCtCQjl2S2tPSG1BZFlO?=
 =?utf-8?B?KzJNYmhkaGZ2ZUt3bzVlQ25Ka1phWXpubkZtaXRSa1VVOEQ4OHBQL05jeVcr?=
 =?utf-8?B?dTlqeXdvcER6U1IwN3ZhWDNkazJVN3NMUmJETHptaXA4K0NreENzYjVieDFo?=
 =?utf-8?B?SHVCVUUxWlp4L0w4UER3eG1tREVBQi9WaDRiUm8reHBLSy9xSTVQTzBnYlpx?=
 =?utf-8?B?TG1ESjZMV1FHOWMrOERqMzBjSm42OXdxV0tkTEtuVHNMWDd6MFZUQzBRblZ3?=
 =?utf-8?B?blhuMlE4dS9VQ2UyK3Q3cW1UM0tSSjJWdjB3TVhJQU00SjltTzdvS1lPRm8v?=
 =?utf-8?B?OHF4ektMVk9HRzBIaVhGcXQ2NGFadW1RaUlWLzNLTjh0enorS0s3WmQxcXBK?=
 =?utf-8?B?MEpmWk1ETE8zZ2JRN1dTbWtaZ2ZjN29VWnZmK1lBaHFDVDltcFZsWkUvZS95?=
 =?utf-8?B?QkkyQWFDUEFjakdGUkNjMkpNbkdTUlUxWmQySmp3anRCNVhXaU9QSEw2dnRQ?=
 =?utf-8?B?YnNRSmJyUHhTOUJ1SHVSenl2WVZvT1NjMWpJNENNWFY4RGJCY3JzUmRJVEo4?=
 =?utf-8?B?TzFhNlVEVDdVNWQ1SE5Ua2ZhcWEycGdTNU4rRTczNlhUOHFJL0Jpb0x4S1Bl?=
 =?utf-8?B?aVJvdXN6eWVxZG9DWEZzWFdVZzdGamhORm9BNC91TEZlQWx1Z01JdE0yZ2Zo?=
 =?utf-8?B?SkhBcjlYYW5wK2Nra2x2THdxV085QVNVRzQ2RGJTR1FsMnNseE05ZXdNY1hq?=
 =?utf-8?B?d0ZjTVlkYjhCcW02d1BSdlhSclZncHlkN2JZMmgzaGNmZXFQTVhqRFAyQ3A0?=
 =?utf-8?B?ZHJBRWdOU2MydXhmN3RiakFNUHhBd3hiSG5tN203MnlzbnRJU0d5b21GOTFE?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F40A7B73DF9237408D30BF98266C3B1C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b642ce7-999c-4d35-eacc-08da9623f817
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 07:37:25.6372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GvYi7GMxM7nts1VsZ+OhI0YraUk5toUVB8hKlDwFjGSVuUg4w3HgYzhXig9e9298aTRUvLysjjVzzq+4mHu3rfApY445UNs6IyKWN2v9DWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5305
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMuMDkuMjAyMiAxNjo1NiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxMy8wOS8yMDIyIDA4OjM3LCBD
bGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMDkuMDkuMjAyMiAxOToz
MCwgSmVycnkgUmF5IHdyb3RlOg0KPj4+IFRoZSBTQU1BNUQzLUVEUyBib2FyZCBpcyBhbiBFdGhl
cm5ldCBEZXZlbG9wbWVudCBQbGF0Zm9ybSBhbGxvd2luZyBmb3INCj4+PiBldmFsdWF0aW5nIG1h
bnkgTWljcm9jaGlwIGV0aGVybmV0IHN3aXRjaCBhbmQgUEhZIHByb2R1Y3RzLiAgVmFyaW91cw0K
Pj4+IGRhdWdodGVyIGNhcmRzIGNhbiBjb25uZWN0IHZpYSBhbiBSR01JSSBjb25uZWN0b3Igb3Ig
YW4gUk1JSSBjb25uZWN0b3IuDQo+Pj4NCj4+PiBUaGUgRURTIGJvYXJkIGlzIG5vdCBpbnRlbmRl
ZCBmb3Igc3RhbmQtYWxvbmUgdXNlIGFuZCBoYXMgbm8gZXRoZXJuZXQNCj4+PiBjYXBhYmlsaXRp
ZXMgd2hlbiBubyBkYXVnaHRlciBib2FyZCBpcyBjb25uZWN0ZWQuICBBcyBzdWNoLCB0aGlzIGRl
dmljZQ0KPj4+IHRyZWUgaXMgaW50ZW5kZWQgdG8gYmUgdXNlZCB3aXRoIGEgRFQgb3ZlcmxheSBk
ZWZpbmluZyB0aGUgYWRkLW9uIGJvYXJkLg0KPj4+IFRvIGJldHRlciBlbnN1cmUgY29uc2lzdGVu
Y3ksIHNvbWUgaXRlbXMgYXJlIGRlZmluZWQgaGVyZSBhcyBhIGZvcm0gb2YNCj4+PiBkb2N1bWVu
dGF0aW9uIHNvIHRoYXQgYWxsIGFkZC1vbiBvdmVybGF5cyB3aWxsIHVzZSB0aGUgc2FtZSB0ZXJt
cy4NCj4+Pg0KPj4+IExpbms6IGh0dHBzOi8vd3d3Lm1pY3JvY2hpcC5jb20vZW4tdXMvZGV2ZWxv
cG1lbnQtdG9vbC9TQU1BNUQzLUVUSEVSTkVULURFVkVMT1BNRU5ULVNZU1RFTQ0KPj4+IFNpZ25l
ZC1vZmYtYnk6IEplcnJ5IFJheSA8amVycnkucmF5QG1pY3JvY2hpcC5jb20+DQo+Pj4gLS0tDQo+
Pj4gdjgtPnY5Og0KPj4+ICAtIENoYW5nZWQgbm9kZSBuYW1lIGZyb20gZ3BpbyB0byBncGlvLWlu
cHV0cw0KPj4NCj4+IFdoeSBub3QgZ3Bpby1rZXlzIGFzIGFsbCBvdGhlciBEVFNlcyBhcmUgZG9p
bmc/IEFueXdheSwgSSBjYW4gY2hhbmdlIGl0DQo+PiB3aGlsZSBhcHBseWluZy4NCj4gDQo+ICsx
IGV2ZW4gaWYgdGhlc2UgYXJlIG5vdCBwaHlzaWNhbCBrZXlzLiBJZiB3ZSBldmVyIHJ1biBzZWQg
cGF0dGVybiwgaXQNCj4gd291bGQgbWFrZSBsaWZlIGVhc2llci4uLiA6KQ0KDQpzL2dwaW8taW5w
dXRzL2dwaW8ta2V5cyBhbmQgYXBwbGllZCB0byBhdDkxLWR0LCB0aGFua3MhDQoNCj4gDQo+IA0K
PiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
