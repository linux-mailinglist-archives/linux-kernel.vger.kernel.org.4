Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21E670F168
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbjEXItk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjEXItj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:49:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8AA97
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684918176; x=1716454176;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w87IZqFK/ILQtEA8nLe/KQiC/mXPJJA17nJL1tQG5vc=;
  b=bjCEyJdEJ+Pv6Q8Ltr+MlWYXWviRflNlIlnCdk5Jr6MS01k+iaKssdwp
   0n36MYXfxrQ+yJPKSGGdKCAOvURMpAoO0s3KreblYdDRpE8wx5mbmmfok
   x4OI9K68guCoUBCTlySRI+O8L18RrttvwvL0MpxOrdl3Qct4vCC39LTfi
   kp2UriGaisk46WVkdpdMLioj386zdC0/xreD17VhO5xihy3oXhuNwQAGt
   Ot5GaJmL2HjsixHQIywkVK0nDwP8gMdYCbn/z0XdlpchZENkkNdj0G/h2
   jduqg0eRZOjJDjmpL9e++T5PNNnBb6ezwEpFwKvqooAjV82gthZHqH3pC
   w==;
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="215244596"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 May 2023 01:49:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 24 May 2023 01:49:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 24 May 2023 01:49:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgVCnBV00fBTsTiazr50wmPJ5wRyF3rglsda5hxx07PwgUMLepQx6ZCOwtD7Njw1zqSM4HN7qspbsuakXk6CYvmwFhDFCNjkVAqXn6r93TAW6S/67G+KUGo00vTv1YAjfIvVUkNoc2Xjef27kmqscdhooCV3ui5oqCRGrWEgWuq/aEAv3k0Gok/kLg6bB7juOxA5daYlAahwh/kEUTZiBzkTNuzzb1rKNn7ct6qsRM6P66LHQ6tW5X26S5Ii4bS5AVoDP0TwrbjsDAzrjVtOzkBbLP7h71TcaaKvptEXR18cKhPIniS3SsxwrxEBO6KdfsvZJq2uZcywn2MxHMxTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w87IZqFK/ILQtEA8nLe/KQiC/mXPJJA17nJL1tQG5vc=;
 b=apXA3/xyRHYnnlXBkpTTqbMW4G+EQuw7SsiA5tiMLk+Ylw2tktx8YyFnQi7E2TWmkj3xBdkt5BRQpsVGgab4r6ka0Yy69HHK2z+XNN/zhyZTqH7HJ0DAvqJrkuPCAY/wYP+ZZZNspT+brIPN3gSXys/K6NkQBF7zUBhtRuIPE7Z4i5epjXxmuHf75v342o5fF5vEORILJPyYbzMLmHgO9PXrqD9WPAZTebBQkSB9uEjSYcUHI1Qyi8ysRERCWkL4W5yeZETHFdb9Tw63glzcrStm0WNr8KP/v3Jhdv8SeQ/KpvVWjpPZ8sztAEBCtXsdzHLzgwvKSWXFPkazZLIwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w87IZqFK/ILQtEA8nLe/KQiC/mXPJJA17nJL1tQG5vc=;
 b=suly0Q18Cx3PjL6n/dZynPgoH7B8k3XJe0MnNCOH6k2r2Jus80DQvH91TADejrlxga0STOcNc2wMGRkoWsZB2ty6IGWiovrxi6/jb2ICl/tMLPv8aS16t+yioSCzEkVj3JvQ2ik/SnbgjShrmQQnkr+23xS11zvoPHxt/jN9gW8=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by DM4PR11MB5311.namprd11.prod.outlook.com (2603:10b6:5:392::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 08:49:34 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 08:49:34 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: at91: pm: fix imbalanced reference counter for
 ethernet devices
Thread-Topic: [PATCH] ARM: at91: pm: fix imbalanced reference counter for
 ethernet devices
Thread-Index: AQHZjhypc5oWe5uilUi2uwINcTV9Nw==
Date:   Wed, 24 May 2023 08:49:34 +0000
Message-ID: <2d493c1c-15eb-9895-8310-41155696582b@microchip.com>
References: <20230518062511.2988500-1-claudiu.beznea@microchip.com>
In-Reply-To: <20230518062511.2988500-1-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|DM4PR11MB5311:EE_
x-ms-office365-filtering-correlation-id: bc6d1413-3a8e-425a-41c2-08db5c33cc7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3jBB4OROn1kG0d/aF1ZoadgGf8ibS3vTRVOi0dnzHl0vkEAC8dXZX1sZhk9a1MjGi2wrVBZVM/qJInVLOwd3V1zQWBFEwaXiN+45kb8CC/fxAYDgyVqzUcn+kYmy9B2gj93wxOwpK3y7WO2feLllZqEC5DDNopWxj7RwQl9TNR9Z39xRYCm+SMxPNuRvtsmF1I2vzgRGH2Fnaj0yaDJduU7PcR2rBx0grOpxaJuI2p0jMRIEbD5XcRTk+O6cVbZMZZqTbpan7tvpa+6F/2cm6yp5KI7nprKbB34/+FjIRK/Lbw5yjvEJRHtwjTaeW9S7WRSJfXlk6KtzI3b04YTsIgPCHayayHnXl/mfba9iYxr6o8jy5Adb9hSXMsVxA0BofMotWFMvfhJFvbQELL6gSYPj1Uj3fJaUueS+JhToVt9twbEi1RTQQC9HU/iwbP7x1ev7ecX1X+Bh1nSpigd4y2oRYiEmMLtCojLBtldXp2dkQHZFMeqwEj9GvaMWInpxPRn20s3pWz5KTgQyHmQNmLq9iCD+S3IijDl1l3+G1u/hxizCPfIwntzgNSottpMNi6ckoB0zxIJIo+ZS5S8Fq7e/7M1Uhgz3SyIgHndkDbkmiK4bAb9UE/vq5esM/i+OOjtmewnzi7MarQYAQxnxm0Q5Fexl2ol3LPdH+mAFOvs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199021)(110136005)(54906003)(38070700005)(31686004)(38100700002)(122000001)(76116006)(66946007)(66446008)(91956017)(66556008)(66476007)(478600001)(86362001)(64756008)(31696002)(4326008)(316002)(71200400001)(83380400001)(41300700001)(6486002)(2616005)(36756003)(186003)(2906002)(966005)(53546011)(5660300002)(6512007)(6506007)(26005)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czJ2RktaQUF2OHpoeXRSRFVWTUxKSGE3TDNTNXhjbWxOdEtIdTBWRVU0aDdr?=
 =?utf-8?B?MTYramhObXNack1qQTJBQS9JTFltN2laU1NzcjFQTE0vaFJwQVkxR0duNVBv?=
 =?utf-8?B?bzNzSndUajJVekFMVkJHcFdXMDdCV1dvV0ZSc2NpU3A2clovMmE3RVJoem93?=
 =?utf-8?B?WVV0ajhZTXlPS2RhdWxPVFZzb3BUYkowQzZ0enRHOHVOR0cvazRTYURYd3NC?=
 =?utf-8?B?anFld1IxN2hHR1d6cEk3ZFlBWDRzbnNiU0NNenozTmkrSk9jVEdjNG0vYXNW?=
 =?utf-8?B?N0puMEJuYVcyL2hCb2VVTldUcFhUaGZKTlhLeW51ZGFqVkdwREhDdThJd0xZ?=
 =?utf-8?B?UlRkNDFiREs1QW5IUEV1ZlYwZnZGRWo0YVFBV2x3YlhiT0dmN0VYMUtDdDdN?=
 =?utf-8?B?NlJMSlowMTZqODdvb3QrQldpQjRnVmhXSEZjSkVJZ0J1dzE3UXVVRE5wQ0g2?=
 =?utf-8?B?RGl6QU9kY2VSU2JadzdrVUJ3dTJTOXJaN0QrdHlvVFI4TTF0bnNBWlVaVXVq?=
 =?utf-8?B?aDU0NUR4ZC8yUE5MSnJ6M0JRNFlnYUQ2MGU2cU9IUUtzeXpqdkJjYjVWVjF5?=
 =?utf-8?B?T2NzSzExdFpXdlRkcXA1c0Q4ZkEvUCtLb0RjVGJtWVFRSVNvSThDRHJ2VHp0?=
 =?utf-8?B?UUFCa0xNV2NCOGFsSzVrSjAxQkd1ZStRMFNMZGhBN3BQUGs0RU1aQkp6Nm5O?=
 =?utf-8?B?SDdtZ3JiWUhYZUhiY2VzUWNzaWYxK1hSVkFLY0lVcy9pWWduSVhJRzg5cUN4?=
 =?utf-8?B?TlhEbGNxUkNQNE9xNzVZZEFtMytNUVFUNk1UcW5ZRkY5ZGJzTkFUZi93OXpW?=
 =?utf-8?B?RG9hVnJjVGR0ZEozcGhVeS9qMEh5RGJnWGNpUmRtMVRvT3U3TTk2MU1CK0NR?=
 =?utf-8?B?SjB0WlF4S1JlRkZ3N1kwemRIUFhxSGNlVlZWV2YwUmROL2cxUmpuWk0vcXJH?=
 =?utf-8?B?d0x4dU12T000SXYrbXUvYjc2SjZlOFFLczc1RFRoTWo2aDJDWjNhN0ViN1hU?=
 =?utf-8?B?V2RCM09Rck1FdWlKS09BdGdxZGpTOWE5ZUsvb0Y1Zmt3ZkpBNE9ncEo3QzZM?=
 =?utf-8?B?SHo5VEdTeUREK25TaS9CdjN0cXB1Y3FXYXBGMmk2alk0ME04aW5IaEg4TUxy?=
 =?utf-8?B?T2J1ekZBdkNHWVBFbWNUaktuM2cvalZPVERkT2xDNENXVVc5V0hKdWJSTzc2?=
 =?utf-8?B?Q1orU01nRE9MN0NXTVozeUFEREhOelJQdzc0anB5czhsbUJCK2ZCNzV5K2ww?=
 =?utf-8?B?bkE5dllibVo1V2g3K2JwcnBYYjZIMWNQK2xMZkJ6N3NJSGZKTWxTUkhmcVpU?=
 =?utf-8?B?aS9LZVRJMTFtZ09JNHZiYmVkc24yOE5hYk1NSTBtNnNyYlV3WlM4a2ZqWExz?=
 =?utf-8?B?ZnpTd09XSEhLZndFdDNkSmttSTZpeUtmM3R3dGZ2NGxkSXdBb2E0cnBXS216?=
 =?utf-8?B?WjltU2xRZHZjNUVIRGhaRmRLbUUvaVEvMnJKSkFmQ0ErMzJjZnNZUDRRelFu?=
 =?utf-8?B?ZGNaZVNVT3lYRkQxYzhDdzMrWngxSzREK3l6Z3FtRVpmenVoUjNubkErTkVN?=
 =?utf-8?B?WkNmODRha1BNMjE0TGxKbGx6aTJHc3NrTGJ3SXFqOHg2REg4TkkxNzFXaStL?=
 =?utf-8?B?RmsvY1NYTUM0SkhUWEl6OHg1THBIMytDVVFPcnp3STNvaGhlTzFpUER3QitV?=
 =?utf-8?B?TUFCd241dDJna1paOU5pOEZPVEhvQTY4MGpnY3hIQjNuaU5CMEd6QVBwdExC?=
 =?utf-8?B?TGI1MDYxNHJiMnpCMXpaSllKOE5SeWdwVDNnbThBbmkrbzNMWE1TWTJVeVdj?=
 =?utf-8?B?cEU5aUVIbFY3RHRNd0ZXbmlFNnl0SUZiZHZPWDdzZkNpMXYvalhzV0s0TnNi?=
 =?utf-8?B?WHE4WmRReUhTWkJIUHVsTmFoRWh5TmZGcnJNV1NzcXJ6YXY1WklQTGFIRWFE?=
 =?utf-8?B?ZUFDdm4wSHFQdlU3SEIyQ2lJUzZjZmhvWXZGWk1la0FicjNLRmVGNEhNRDRz?=
 =?utf-8?B?dG9vT2pTREhlSGtEekk3MnNXMEtjaVdFSmxVT1JSSFFNeC92bDVKNzhaQmdv?=
 =?utf-8?B?TUl5b3lPRUxoNkhXdm1jcFhaRzJUU2xybFdFQ1lsektVQUhaWFYxVnArV2dr?=
 =?utf-8?B?L3Jud0RIeFo2S1JYbUJzajhGdTlFSzBtejRncFNoVkEyT0dmTHErWUpWK3Zu?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E824BD403269949B47D91FC98738445@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6d1413-3a8e-425a-41c2-08db5c33cc7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 08:49:34.6307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lc8lQkoYM19duHTJaaT+6G4tigPU4mdUQ1FPTpELV3AFpiY0Lg+qrCmEBx7hYAaadV2LXsGFt5yZLS5teFHGZmtrKopgooP0lkLux7G8Y2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5311
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTguMDUuMjAyMyAwOToyNSwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhlIG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUo
KSBmdW5jdGlvbiBpcyByZXR1cm5pbmcgYSBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+IG9iamVj
dCB3aXRoIHRoZSBlbWJlZGRlZCBzdHJ1Y3QgZGV2aWNlIG1lbWJlcidzIHJlZmVyZW5jZSBjb3Vu
dGVyDQo+IGluY3JlbWVudGVkLiBUaGlzIG5lZWRzIHRvIGJlIGRyb3BwZWQgd2hlbiBkb25lIHdp
dGggdGhlIHBsYXRmb3JtIGRldmljZQ0KPiByZXR1cm5lZCBieSBvZl9maW5kX2RldmljZV9ieV9u
b2RlKCkuDQo+IA0KPiBhdDkxX3BtX2V0aF9xdWlya19pc192YWxpZCgpIGNhbGxzIG9mX2ZpbmRf
ZGV2aWNlX2J5X25vZGUoKSBvbg0KPiBzdXNwZW5kIGFuZCByZXN1bWUgcGF0aC4gT24gc3VzcGVu
ZCBpdCBjYWxscyBvZl9maW5kX2RldmljZV9ieV9ub2RlKCkgYW5kDQo+IG9uIHJlc3VtZSBhbmQg
ZmFpbHVyZSBwYXRocyBpdCBkcm9wcyB0aGUgY291bnRlciBvZg0KPiBzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlOjpkZXYuDQo+IA0KPiBJbiBjYXNlIGV0aGVybmV0IGRldmljZSBtYXkgbm90IHdha2V1
cCB0aGVyZSBpcyBhIHB1dF9kZXZpY2UoKSBvbg0KPiBhdDkxX3BtX2V0aF9xdWlya19pc192YWxp
ZCgpIHdoaWNoIGlzIHdyb25nIGFzIGl0IGNvbGlkZXMgd2l0aA0KPiBwdXRfZGV2aWNlKCkgb24g
cmVzdW1lIHBhdGggbGVhZGluZyB0byB0aGUgcmVmZXJlbmNlIGNvdW50ZXIgb2Ygc3RydWN0DQo+
IGRldmljZSBlbWJlZGRlZCBpbiBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlIHRvIGJlIG1lc3NlZCwg
dGhlIGZvbGxvd2luZw0KPiBzdGFjayB0cmFjZSB0byBiZSBkaXNwbGF5ZWQgKGFmdGVyIDUgY29u
c2VjdXRpdmUgc3VzcGVuZC9yZXN1bWUgY3ljbGVzKQ0KPiBhbmQgdGhlIGV4ZWN1dGlvbiB0byBo
YW5nOg0KPiANCg0KWyAuLi4gXQ0KDQo+IA0KPiBBbG9uZyB3aXRoIHRoaXMgdGhlIGVycm9yIHBh
dGggb2YgYXQ5MV9wbV9jb25maWdfcXVpcmtzKCkgaGFkIGJlZW4gYWxzbw0KPiBhZGFwdGVkIHRv
IGRlY3JlbWVudCBwcm9wZXJ0bHkgdGhlIHJlZmVyZW5jZSBjb3VudGVyIG9mIHN0cnVjdCBkZXZp
Y2UNCj4gZW1iZWRkZWQgaW4gc3RydWN0IHBsYXRmb3JtX2RldmljZS4NCj4gDQo+IEZpeGVzOiBi
N2ZjNzJjNjMzOTkgKCJBUk06IGF0OTE6IHBtOiBhZGQgcXVpcmtzIGZvciBwbSIpDQo+IFNpZ25l
ZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0K
DQpBcHBsaWVkIHRvIGF0OTEtZml4ZXMgKGFmdGVyIHJlbW92aW5nIHVzZWxlc3Mgc3RhY2sgdHJh
Y2VzIGluIGNvbW1pdA0KbWVzc2FnZSksIHRoYW5rcyENCg0KPiAtLS0NCj4gIGFyY2gvYXJtL21h
Y2gtYXQ5MS9wbS5jIHwgMjAgKysrKysrKysrLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA5IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL21hY2gtYXQ5MS9wbS5jIGIvYXJjaC9hcm0vbWFjaC1hdDkxL3BtLmMNCj4gaW5kZXgg
NjBkYzU2ZDhhY2ZiLi40MzdkZDAzNTJmZDQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL21hY2gt
YXQ5MS9wbS5jDQo+ICsrKyBiL2FyY2gvYXJtL21hY2gtYXQ5MS9wbS5jDQo+IEBAIC0zMzQsMTYg
KzMzNCwxNCBAQCBzdGF0aWMgYm9vbCBhdDkxX3BtX2V0aF9xdWlya19pc192YWxpZChzdHJ1Y3Qg
YXQ5MV9wbV9xdWlya19ldGggKmV0aCkNCj4gICAgICAgICAgICAgICAgIHBkZXYgPSBvZl9maW5k
X2RldmljZV9ieV9ub2RlKGV0aC0+bnApOw0KPiAgICAgICAgICAgICAgICAgaWYgKCFwZGV2KQ0K
PiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICsgICAgICAgICAgICAg
ICAvKiBwdXRfZGV2aWNlKGV0aC0+ZGV2KSBpcyBjYWxsZWQgYXQgdGhlIGVuZCBvZiBzdXNwZW5k
LiAqLw0KPiAgICAgICAgICAgICAgICAgZXRoLT5kZXYgPSAmcGRldi0+ZGV2Ow0KPiAgICAgICAg
IH0NCj4gDQo+ICAgICAgICAgLyogTm8gcXVpcmtzIGlmIGRldmljZSBpc24ndCBhIHdha2V1cCBz
b3VyY2UuICovDQo+IC0gICAgICAgaWYgKCFkZXZpY2VfbWF5X3dha2V1cChldGgtPmRldikpIHsN
Cj4gLSAgICAgICAgICAgICAgIHB1dF9kZXZpY2UoZXRoLT5kZXYpOw0KPiArICAgICAgIGlmICgh
ZGV2aWNlX21heV93YWtldXAoZXRoLT5kZXYpKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIGZh
bHNlOw0KPiAtICAgICAgIH0NCj4gDQo+IC0gICAgICAgLyogcHV0X2RldmljZShldGgtPmRldikg
aXMgY2FsbGVkIGF0IHRoZSBlbmQgb2Ygc3VzcGVuZC4gKi8NCj4gICAgICAgICByZXR1cm4gdHJ1
ZTsNCj4gIH0NCj4gDQo+IEBAIC00MzksMTQgKzQzNywxNCBAQCBzdGF0aWMgaW50IGF0OTFfcG1f
Y29uZmlnX3F1aXJrcyhib29sIHN1c3BlbmQpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcHJfZXJyKCJBVDkxOiBQTTogZmFpbGVkIHRvIGVuYWJsZSAlcyBjbG9ja3NcbiIsDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGogPT0gQVQ5MV9QTV9HX0VU
SCA/ICJnZXRoIiA6ICJldGgiKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiAtICAg
ICAgICAgICAgICAgfSBlbHNlIHsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgLyoNCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICogUmVsZWFzZSB0aGUgcmVmZXJlbmNlIHRvIGV0aC0+ZGV2
IHRha2VuIGluDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAqIGF0OTFfcG1fZXRoX3F1aXJr
X2lzX3ZhbGlkKCkuDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAqLw0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICBwdXRfZGV2aWNlKGV0aC0+ZGV2KTsNCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgZXRoLT5kZXYgPSBOVUxMOw0KPiAgICAgICAgICAgICAgICAgfQ0KPiArDQo+ICsgICAg
ICAgICAgICAgICAvKg0KPiArICAgICAgICAgICAgICAgICogUmVsZWFzZSB0aGUgcmVmZXJlbmNl
IHRvIGV0aC0+ZGV2IHRha2VuIGluDQo+ICsgICAgICAgICAgICAgICAgKiBhdDkxX3BtX2V0aF9x
dWlya19pc192YWxpZCgpLg0KPiArICAgICAgICAgICAgICAgICovDQo+ICsgICAgICAgICAgICAg
ICBwdXRfZGV2aWNlKGV0aC0+ZGV2KTsNCj4gKyAgICAgICAgICAgICAgIGV0aC0+ZGV2ID0gTlVM
TDsNCj4gICAgICAgICB9DQo+IA0KPiAgICAgICAgIHJldHVybiByZXQ7DQo+IC0tDQo+IDIuMzQu
MQ0KPiANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fDQo+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwNCg0K
