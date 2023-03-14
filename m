Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E86C6B8F81
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjCNKQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCNKQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:16:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A5260D6C;
        Tue, 14 Mar 2023 03:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678788925; x=1710324925;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ap8zNdzZDpHuoVVCYYnQvNCc8UVW8QUGpcUWV3koVtA=;
  b=yg1wie41VoupI24fRXySnuodea7L6FeDWnAf4CtL8sgRL9qQGLO46ptA
   SMFHl/nK5PB3UBIRqqzzdjzPGr6YKCBTPyzQgh5CZdXOzthrftRNsX2RB
   w7t0iiXC5PhnLXOBucd1rSb5jW2zuhjN5dch+UsYS7RwjPz9PNOsehXdW
   smSpZ1p2BVdUJd/OTdlvCHoW8VfzAPtIzQD3oFXsSmlQU9h0z6ImdE2KO
   aQzyieBhDESPXLD6DdbdGp14FVXTvZJOdNbHynbjh0Fwfux0xrnsanzxU
   MIih/+ze5Zw6qAjcDxQKoMF6+0EXqoYVKdoTvWUt5Vdqp9GGlADL6iDu4
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,259,1673938800"; 
   d="scan'208";a="201521784"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Mar 2023 03:12:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 03:12:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 14 Mar 2023 03:12:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZHIDphUvYtWRTlkAWEi/vHhvvBcScchLS8fmI47dprbcFJ/ebUpbhF7FHn0UZMuCGpFfUEbN+LVbfds5be3aAoW1m8JqHMYtsMHlwq1ObtxShDRA6cujp1dzvKhnPVg13VtkWuAIk5zpaevprmlQZ9sqKxPlFY5o+p94LhfEcERbpReJs0gCF9FJMZvsJaEdi0kTqLrY2D7cMbEE6bwWsNEIaaVn+UwFCDjpj1OBgy8UjqaVLxkhHAvjSTbOPzZnJ3K9IUq4WM/nZX4Fq0SqxrdRAUeuh/0xuJ2rehDo1c1m/DXQlPv8DOaDoQtkblGMmTNtXS8q7lBr6QGWOucpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ap8zNdzZDpHuoVVCYYnQvNCc8UVW8QUGpcUWV3koVtA=;
 b=eYVK4Ys7X6+uZF9Rda8DB/YnaxYSucrYT8InPmbcwafyFg1Q+/zwM5GQUu3Sxfhr+KSXvwk2lPdM51poYgGnf154sfDv6rVKOWbRiHe7xmxX2x22VX8oLwfatg1NVBHc+2r3NLDKJcFAfpfzg0kKDc2bq9g95nNWVwMfIPGxQNh0M2Xf1zKa8pjcExAwCvNPyGKjE2Jx7XI59JpgbzGxPdY8XcKCfej30UQEwPaeTFQNRbPKdwzlGzPfACSGNESxDU5DzSlwyQuq4pQMZEYAF5kpnE6egwxFn7O4Q3dL+OBNgKtoNZJPZ1FarYIpK2iOKdvaZu1dTvG/XYGlO8ZZQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ap8zNdzZDpHuoVVCYYnQvNCc8UVW8QUGpcUWV3koVtA=;
 b=Q9OcMSC1daQ4kgFDM9ghChWckQMvdI3OVGMdYvkg8Ij4RoDerXwu1u2L6cCqRXyjSbFiZR6oxHV0+I1b8MIWgEr0ytJnYB7eOxmVMofEBU/hjakZjKGRYYROk1hDtkxpMgr7wJ62zjbMeDdfDyRKbwD4godSFJ3n0UrfkTXri/4=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by CY8PR11MB7826.namprd11.prod.outlook.com (2603:10b6:930:76::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 10:12:24 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 10:12:23 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <chengziqiu@hust.edu.cn>, <eugen.hristev@collabora.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <dzm91@hust.edu.cn>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iio: adc: at91-sama5d2_adc: remove dead code in
 `at91_adc_probe`
Thread-Topic: [PATCH v3] iio: adc: at91-sama5d2_adc: remove dead code in
 `at91_adc_probe`
Thread-Index: AQHZVl14D4EmmLxY7UGAUdq/s9i03Q==
Date:   Tue, 14 Mar 2023 10:12:23 +0000
Message-ID: <f1afaf48-e884-4902-8cff-41da234df9e9@microchip.com>
References: <20230314070130.60581-1-chengziqiu@hust.edu.cn>
In-Reply-To: <20230314070130.60581-1-chengziqiu@hust.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|CY8PR11MB7826:EE_
x-ms-office365-filtering-correlation-id: 87d3c34f-744f-4744-08e0-08db24749b0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xh4HPIHzgGJO1AuN8Mv4KlKors4m2LoaigpIkSeTApgI6KpUsP4GaXb4066C6fINgPNbMdYeI8KjWwbvh9t3KpHmKVVQrQrb1gCcNnOMraNJnZz2KtzidnS+ORVkmt9OP+7GqvOT5sZhcq5nBwmLTgpW7+oqPSc2VWoS9UNodgVOS62wSz/gUb1bnquxowxkxqrTaye3s82lfLW4OemVdK1r1MklyLQk9tR5LkzKwSJK+qeAZkGQsVapzNip2IbL+RJWYIAj23MvqgnKJZeJiEJ27vIxyWb2sxW2kkvi0irKeYxHLaKmmDexB4uxVOsPyfz68o5i04Z1Mtbm8cFpd+XlJDouVZohhz38870QhJsVUWawp0jTzSX+UzCCrAd9jB33/Zy6OP97+bfGqsg95c7SJJtXzHL8Io43gf/re4sb/xWBKKq3cQjrgDwu719MOBhgXvbFDa6/ChgXYDUsjQuJLZupbUuzsOIO/cMltoiX7B80MpIIz58q0NGEtOxGAkyystUgHez0BL9l7EOKg/u/X/WWjHV+AZ4dNuahmdMX5gpc8t8t7Rn/y71TaRxPZ59uAFc6WFD9SvXxwrFOr6mnQL9GZN4ybxizAQHRSsCkN6b96jyk8ybM9m5KlQUWK4mNG1XTAOtpD2Iv4Swbu0LNWuEYNdHibz0hXxdzWER11ACcgmplDQsxWsCSWyC5D4pu/E18P6eV1v7oZNEd6UlkaIa8Fg5WdYjt5di5cxE8W5eRwM3FqW+AZM90P+usqma+0bpANwwJ45v/VWywYzo3WbQ6w/EIQqkLQOaym4k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199018)(36756003)(54906003)(316002)(110136005)(478600001)(6486002)(5660300002)(2906002)(71200400001)(8936002)(76116006)(66946007)(66556008)(66476007)(66446008)(4326008)(91956017)(64756008)(41300700001)(8676002)(122000001)(38070700005)(86362001)(31696002)(38100700002)(186003)(2616005)(26005)(6512007)(53546011)(6506007)(83380400001)(31686004)(81973001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEV0RUZNMTZhMTZseW9GNkovZzJIbTFzeDFWRWFPYitNZ2ZqajVFckpWQ1Nr?=
 =?utf-8?B?RHMxR3ltd1ZXN2VwVytEVVVhMjJ2TlV3NGQ1ODhXY0dSTmxiK2pHSmJ5cEk5?=
 =?utf-8?B?NEhhQS9aMHlyQ2VNTGVMRXdseEtCN1JJV2ZoVlBSWkVJVHNQNTdzRzAwYzBT?=
 =?utf-8?B?Wk9aWFloVU1ybXpqU0hVT1ZiOW54TFVTT0Q5cGdKWHdobUtTT0pBV1Vnc2Nt?=
 =?utf-8?B?a2JCUkgyVWdsSHorUmJXK3dFQ3RBT2NSdWRlZGwvRmdMWWdrb0E3L3J4R3hq?=
 =?utf-8?B?VVFsRHoyaVNGSHhqbml2U21kdm9wWDUybktTVXZaN252Tmg5aDFEY3JyVmRw?=
 =?utf-8?B?MHY1YXdPMDI5bWVRWVVySHEraFZMSjBlUVdEbmxsTWt3Uk1jM0s2TllQckVX?=
 =?utf-8?B?MklFUWZadVQ3OFN5UkFLcHd5M0NWalNud2RtOHY3RjBxSWNjOUJhbGxqQ040?=
 =?utf-8?B?WmUrM2JpeUdDU01kYVNsUzljRE1IYUdSTzlTbHNPcFc1aVJ5RDJsRDVRVml1?=
 =?utf-8?B?U211VlNtRWpYQ1NmT3QyTUdENTVQaGcxOWpvMFJGeU1RYnExTWhKaUE5NDQx?=
 =?utf-8?B?V1JOU1JENVRaMXc1bEJ2ZThQTDdZVmUwdXpGZ1JXOGtZbVc5aU1rWGQ5b0xO?=
 =?utf-8?B?QVR0dHZRSGpJem4zVjl1OHZpM0lEK2dzamJMTFBFR2E0dnBBZ2dOY2NmL3BC?=
 =?utf-8?B?d2gwSjBrc0JPR29WV0cvOTRKTlFyUFlGMHdveC9NY0VXRk1xT2pud0VqZ3p5?=
 =?utf-8?B?M0ZMRTZjQUpyRTlvZEZmdzYzUDkzVVRrK1A4ay9XeXJFMGlVS1luV2s4L1dl?=
 =?utf-8?B?eEg1M0xaa0RoN0o2KzBhTkgwZjlVdDdoYWY3UWk3THMxT040M3pPWitZMzM1?=
 =?utf-8?B?Ui9iWlkyRXVubXF2akFvVlNubTRRNGozSnloUmU3UUk3c29lUmJPSmRmclpK?=
 =?utf-8?B?ZUhLTG50bEpzaXB5L1RtMnhZVDVBbUZsQVpzSVlrL01EbUF6NnVmMnRjMlYz?=
 =?utf-8?B?Q2ZZZWJac1lnTmNWQlNqQlZ3b2c5bzFNcHlGWjNPODZDeTRBTE5BalV6M3F3?=
 =?utf-8?B?UjNCLzh2K3FyU2RZdXUzNXlnTXNndWN0RUo3M01qTS9sUGxYUGVqcHVmRDg3?=
 =?utf-8?B?SDg3cXVVN1k1allBay9NcjcraG16bStpSXhRUmNsL3pPNVRlUUgzeVZ4U05C?=
 =?utf-8?B?TEhPUkowbGNYK1VRT3VRdjVVVDdWbDZnUEhHMm5GOWZYajlSZDBVRUVNblpw?=
 =?utf-8?B?eTQ0Y29SRWVlTWtpS0o2UjVWeUs5eUlqdjBPb0RkeXVhNDRRZzlCRWUwems3?=
 =?utf-8?B?QTlkZXNQQ3ZPRFF1VGdPTkpMaXpHVTVXQmYyWkJkbE5DbHQ4WmpXUEl4eHVG?=
 =?utf-8?B?a0JDRytWTkxxVlhtTFN0VVo5U3F3NHZoWXg3TEl1ZXZlVUpZeW14ck0yamdj?=
 =?utf-8?B?RGJ6bGVoVHd4VWwvb2tvaEVua0JWNTdpb1htQy9DeklacVNPbHB3TXFPUHo1?=
 =?utf-8?B?NWRreDl0a0RUdTlQUUZ4cGhTK2FSb21UbFNyU1J5eENiN2tvcSt3K2FUNUhI?=
 =?utf-8?B?WlFIaVpwbXBBeFVOMFMyaWhKdnF2L0tWVXNaRGwzNG5zeWZCNDhmMXl6Qzlo?=
 =?utf-8?B?Tm91M0l4UjhZOTR2QVB5OFVCQkVQaWFQNk5RL01idjNGeElGcXFFc1cyUlJL?=
 =?utf-8?B?eXBSQVRobjYvUTF6RjJaK0xmdVJaaktySU55Y0VML2xyZ2Z0dmRQSURFYTZ4?=
 =?utf-8?B?VUdtOVVrc1pxNGtXZFRjblErWTNoUUZ3bW54aWhTRGlSd2RreTJtbUY2MUg0?=
 =?utf-8?B?NUh6RXVydno4MmNqdERYNDZ3TTc3aUs0d2txUUoxaUt0RGtLV2l1YUlUMkdk?=
 =?utf-8?B?d2VyYXMyTE1KaVM5TXJlTnBHMTFKOWkyQ0RHNVdiN3BzRFl6UFhjK09IVjZK?=
 =?utf-8?B?WWk1a0xva3dNdEM4cndJZUt1Q1h3bmdqZUUyOFRUR0oxUmgrbW5maU40UEEr?=
 =?utf-8?B?aVRJclZnbmNDY3JPVkk1RlgxandpNjVWVkdma3l1TXEwRDNyak12bzAwMmlY?=
 =?utf-8?B?NFJ4Qy82TkxQaHZ6L25QcTlMbXNlUmh5am02MmNYT3JtRHh6U2E3L2Y1TWJZ?=
 =?utf-8?B?OTZqSnE3NGh0WXRxNjFNOFFBdlVjRVpCTjBRNWl4UUxJTEhxL2RkUktrbnA0?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B0B1D6CF50DC14B8054109338577268@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d3c34f-744f-4744-08e0-08db24749b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 10:12:23.8742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N9rRMIBBGTfIpFta1MMKZ6dECdeZyCz4W0xdghkOOgkwRlWYIaqpCs7ws3PHkLcYqF0slypXR/Ygqg9Puylm4SAtKxEQ2IRQN/zghsFiZcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7826
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQuMDMuMjAyMyAwOTowMSwgQ2hlbmcgWmlxaXUgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4+RnJvbSB0aGUgY29tbWVudCBvZiBwbGF0Zm9ybV9n
ZXRfaXJxLCBpdCBvbmx5IHJldHVybnMgbm9uLXplcm8gSVJRDQo+IG51bWJlciBhbmQgbmVnYXRp
dmUgZXJyb3IgbnVtYmVyLCBvdGhlciB0aGFuIHplcm8uDQo+IA0KPiBGaXggdGhpcyBieSByZW1v
dmluZyB0aGUgaWYgY29uZGl0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hlbmcgWmlxaXUg
PGNoZW5nemlxaXVAaHVzdC5lZHUuY24+DQo+IFJldmlld2VkLWJ5OiBEb25nbGlhbmcgTXUgPGR6
bTkxQGh1c3QuZWR1LmNuPg0KDQpSZXZpZXdlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUu
YmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCg0KPiAtLS0NCj4gdjItPnYzOiBDaGFuZ2Ugc3ViamVj
dCB0byBtYWtlIGl0IHJlZ3VsYXIuDQo+IHYxLT52MjogQ2hhbmdlIGNvbW1pdCBtZXNzYWdlIGZy
b20gU29CIHRvIFJldmlld2VkLWJ5Lg0KPiAgZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9h
ZGMuYyB8IDYgKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDUgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVk
Ml9hZGMuYyBiL2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMNCj4gaW5kZXggNTBk
MDJlNWZjNmZjLi4xNjgzOTkwOTI1OTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9h
dDkxLXNhbWE1ZDJfYWRjLmMNCj4gKysrIGIvZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9h
ZGMuYw0KPiBAQCAtMjQwMCwxMiArMjQwMCw4IEBAIHN0YXRpYyBpbnQgYXQ5MV9hZGNfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAgICAgICBzdC0+ZG1hX3N0LnBoeXNf
YWRkciA9IHJlcy0+c3RhcnQ7DQo+IA0KPiAgICAgICAgIHN0LT5pcnEgPSBwbGF0Zm9ybV9nZXRf
aXJxKHBkZXYsIDApOw0KPiAtICAgICAgIGlmIChzdC0+aXJxIDw9IDApIHsNCj4gLSAgICAgICAg
ICAgICAgIGlmICghc3QtPmlycSkNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgc3QtPmlycSA9
IC1FTlhJTzsNCj4gLQ0KPiArICAgICAgIGlmIChzdC0+aXJxIDwgMCkNCj4gICAgICAgICAgICAg
ICAgIHJldHVybiBzdC0+aXJxOw0KPiAtICAgICAgIH0NCj4gDQo+ICAgICAgICAgc3QtPnBlcl9j
bGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgImFkY19jbGsiKTsNCj4gICAgICAgICBpZiAo
SVNfRVJSKHN0LT5wZXJfY2xrKSkNCj4gLS0NCj4gMi4zNC4xDQo+IA0KDQo=
