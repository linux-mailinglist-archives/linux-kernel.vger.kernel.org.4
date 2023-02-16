Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13291699078
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjBPJt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjBPJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:49:57 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10123CA36;
        Thu, 16 Feb 2023 01:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676540994; x=1708076994;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LD5pOZ8zrtLtrThLnY2vkCm0/8AT40b2SEYod/J90NA=;
  b=TJFAqWjkzgzgTMPVLbrJdWyaCz/r29u1/00nGSC24Birw0LUGYCXj/uO
   6hHCMFS1cYcBImEr2SGSlsnd3GRr/+seNLwiZRhDVfttXEizxw6WyRDTH
   ZJ14unnTGq1/wSlOQWsZu0JQmG2/y0zEuNQOF9fCVT5kCUtNQN9vlD6HK
   ZDL6pLpGc7YBxeZDZbQhsiOy+eUrbiEjNRoy49WC23lelvDu8bGZ7jWwO
   0F4oOVAlmcrWAxjqY2nbHQsnvzc2jIUQ9cIsPlv72R9fNTp60l7kSyxB4
   XeC6GrouPRZ1pgc3It5JflJYADJNkKg41725t9PZfcgkkI8mJJ0y3Bb92
   A==;
X-IronPort-AV: E=Sophos;i="5.97,302,1669100400"; 
   d="scan'208";a="197261785"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Feb 2023 02:49:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 02:49:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 16 Feb 2023 02:49:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5CLwo4dyCuY0+Wix7ZPiVeulT6C308YBPT8SOSA6Uiy9gr7BElqMLcDIQkd+RZ3mY86XbOoJJHC6KGStGWVJSSFfYqX8vfTigXrEdZP8HLJ4PleLtXO4r6PQqq5VuvBi2U0WBybCVOc+48busemXwFGnYVYtG80UO0EeeW5GGv0d3WvtIRwCqWRuNSDW/vxMQkNehrNhpu59szhakHH+4cANYE6Dk5y4Pr9y33eyOC4339DFX3hd+yzODND7n3DC0Jgb8BkSKcDxRpC/Ql8UtyQlf9r5JZD72QqiqS1xw7/twtft4tGtsR+se4CNK1gMrHol2ffwqsLaNtd5GKSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LD5pOZ8zrtLtrThLnY2vkCm0/8AT40b2SEYod/J90NA=;
 b=imWmbOgpDwF5kg6clsejEVrW2aEegOQo4/wv1g9jP6L2rRvAKCXqp8NMmg4crIwDigIV3iZ/bDWhawKolCnv3zJ2EWmUHbk5fR1zLob/9ajsJa2/blOQtsyGtTcP2bpO/nM1spKu+jDXQPzeAsUa1QaN6orrcOlxxolqHfOQzk2bSNwQuvbfSfbEgcEDrkm8baAqpnGcdsejcx8mFfC8fm9Ty+l1jAg71WSNCVJgxc6j0YXTIBfxzm8IguGQHsv3T5y7tJ/j05bC4vz2HMh2oEmv4RbJ6ghb/Na2wGOgGmhYi2nJDisQqhIRVKhLbEDV+6wNYa1GOhQsujiypgWwJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LD5pOZ8zrtLtrThLnY2vkCm0/8AT40b2SEYod/J90NA=;
 b=hETSkjzbmdRonKwiJ1JjXNL0jNe3ylxSBYUZj30JShuzt1FvYaCuww9rJrBM+1WtREFPEaOdAWH7BJhHKjjmIr8by3F7rhrkTuodKm51Y7MXkNHupG8Rs+8KR5YB8+PUkT6CCBXA/xt5FBCLjTX+QruGRxZd8u4pDAGhmsiykls=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SA1PR11MB6918.namprd11.prod.outlook.com (2603:10b6:806:2bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 09:49:50 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6086.027; Thu, 16 Feb 2023
 09:49:49 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <broonie@kernel.org>, <lars@metafoo.de>
CC:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] ASoC: soc-generic-dmaengine-pcm: add option to start
 DMA after DAI
Thread-Topic: [PATCH 1/3] ASoC: soc-generic-dmaengine-pcm: add option to start
 DMA after DAI
Thread-Index: AQHZQewBkfhSprHzBEKV2UgPta6WAg==
Date:   Thu, 16 Feb 2023 09:49:49 +0000
Message-ID: <4b109846-2019-219a-262e-46f5bb504c99@microchip.com>
References: <20230214161435.1088246-1-claudiu.beznea@microchip.com>
 <20230214161435.1088246-2-claudiu.beznea@microchip.com>
 <b065e2bb-1f11-067a-b085-45d47626927e@metafoo.de>
 <Y+v8bbr4cNSOA1SF@sirena.org.uk>
In-Reply-To: <Y+v8bbr4cNSOA1SF@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SA1PR11MB6918:EE_
x-ms-office365-filtering-correlation-id: e7a13730-d255-444e-32ef-08db10032500
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ykkTTxnq+N1ooAlhUVGg0SlTuy0gBDs8lkX3YhLok+9/kW2QL50ts4y/Fqw5d+J3zyGjqWb4Tg7Pi0w/rk/E0cMiqXS56SYqU6Zv5rc1YjUY3hI3QurH3zAQNjsOjLsOkECcHNHTkl2Yzuo7h6bEWeEclQ5/d76Dm+vApY6xoNU6KO6rSGK1unmxz1abeYjRr/9DNEnOlXma1Dlurqb3r5oZETMeKL5H2uRHKYnV5QHcMXXL4kD+MT9LEGyqlHPaGrRb0Sg+DfaHRWkbZEHD+ObEdsP/1s+nQdzLIxJSk05cCY+JIUfSFaPnMEG0bOwmp++4GsEHNVr3Xqgicu0XzIh6uZUnEKph+FB8ehUSSSsE7EhNsC7KVXBh8R+m2OTLFAO8Pkej6phRahatjNB9VQTB8GgQBrgogTD01oi3Pudl3RUH276zMILg1TpK6l9ilrEVgvfflXPoNsi+BQRst6fWayY2KoBHNFIdX8bV5Df1qpTQXRKdC07SzgZfloALD0IavSNnn8/1rLPPo1JGBO3A0I8/1qLV+2RaBRHgBIIkdBl93nWB3SSK9f7dMf4Kx6BnIuicpf8jFHr/0EJ/UdIymWy3I9m6rcHFUXJLgNWKQRi35A+E5OmC1nVYy/eDOJKRHkaay256XsHz2DmSiSLDyLsTWKrpjMR5VtM2aGzqhglpMKAqxenGIvEgAPaghsZyRv7UzSjFmDlnbWTy8/W8Tnq5bQq1Os8qeYIQ6rmSsDozRljIDHv2XsBvIOZ6hXhC5qWzVvx+b9rlBadeRkNWA3QovZOEUvWz0Gfay3k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199018)(31686004)(36756003)(110136005)(2906002)(54906003)(7416002)(5660300002)(8936002)(66556008)(76116006)(66476007)(66946007)(91956017)(316002)(66446008)(71200400001)(64756008)(8676002)(41300700001)(4326008)(478600001)(6486002)(86362001)(186003)(38070700005)(6512007)(26005)(6506007)(31696002)(53546011)(2616005)(38100700002)(83380400001)(122000001)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VCtGZHhmUzZCWDFiSHhwNjRJcjBHUXljZUhwRjhvQ1dmWngvTnBLVGM3enlX?=
 =?utf-8?B?VDJ4ejV0aldVU1RVZHFGQXdIU21GTUtaS3hRUXRXTngzcXV0OURxRjMrN1VG?=
 =?utf-8?B?Rm15TDdrUytKODluVXptdUNSVXNMQ3IzSGFiQTh1VndXYzZ0Z2JURFl4cW51?=
 =?utf-8?B?Y0Q1TGZIV0FLaUo3NmVaWWFCME1xa0NGSkF5UUFOZHF2YU1rN0ZGUHEzaGhS?=
 =?utf-8?B?aWgyWlVUc1lRVVpaOXQyRXU3b1RuMHlEdjU0MUswVlFSaEhDcXA5b3IvT0hR?=
 =?utf-8?B?a1FRUEFLQ3ZCbVkxakJrd3VzckRlR0Z4bVhWZjF3QWpnZUFFQUU4R3lCcVdo?=
 =?utf-8?B?bGxCSzAwbkpreTFFUlUxdzFzdG9qNGp5ZjExUmpjMzRSRlFJaXJvOEhkVnJW?=
 =?utf-8?B?eDB5T2NmWlluT3kvVldNdXpjUDQ0bllkS2Jma01wb1hMZUNUdGtWdTFac3ZY?=
 =?utf-8?B?TG5tcVR2ZVVweFNmbXVpbitqSmMyYUQ5UFliT0RUN3RSUngrY3dWVS8zRkdo?=
 =?utf-8?B?M1k2UGIxTVVvTTRaYitqNTNJTThYdGRGSHJCNytXTkxEN2JrTHVhaFdLTnk2?=
 =?utf-8?B?VFdhak4vLy8ySzI2YkdVMk95ekZsWGp5a0MwQzZsZ3k2dnQ1VXFhZkxqZ2N1?=
 =?utf-8?B?ZEV1UkM1R2Y1VkQyb2U5dG9uajdtSXEybmJCMmJrOGJrUG9jZGJ5cDlycUYv?=
 =?utf-8?B?OFVPYzZHQnl5UFpOMDkzd3UxbUtCSG44SlIraDloTjcxOTFZeFliSUtkVjhF?=
 =?utf-8?B?cUx4ZGlQM1JYV0RrYTlWei9kbHdldDc5aEMvZjJ3cmZ6dlpqaTlYYk5YMEVC?=
 =?utf-8?B?SFFuNzk0cTBVVXR1bk40U2drSFZ2UFV3Uzg3ZmEvSUdBN1RwYi8vTXJlRzlO?=
 =?utf-8?B?NEVXa2doRjZlU0VCYUJMQVJpK1FOdEtLeEhiY0p1SHpUTTZJRWRpQSsycUlM?=
 =?utf-8?B?a1p5NjZZdDV0RWkzZjZKWG1GY1lPZldSMjFaM3R4RlZyVDh2bzBvcFlaZkpC?=
 =?utf-8?B?dGk0RkVQc1FkU09vSW5ZczNCOGJzcENiN0VDcTFQQ2xlbi9GRW9jcXp2K3ZY?=
 =?utf-8?B?ampMY1FwSG9kVS9VVTY2SGdGaHh0T1BTRkNpd1U2QTBOOGRCakVMMlJPeEth?=
 =?utf-8?B?VTBvWmpwc3YyT1ROdU5yOGVpQW0wc1cyTEY0cTZvNm85RnZ6SGd5Q281cHRB?=
 =?utf-8?B?QytaeG01czk2ckF6T3VubFdpTEp4bE4wT3FRY2tNTlZGQ01VSE40TUJrVU5Q?=
 =?utf-8?B?KzlzKzVSOTRJYWhHUFRRb2QrNEtIaWxpMzdzWFVmb2swOGdaYUo1UGh5TFNW?=
 =?utf-8?B?eTlma2xybnRidUZjU3BSYVZQcWRPRk5JUVliQjJLNDhNUjZTOVpOWnQ4cklx?=
 =?utf-8?B?WThyRmZSS1RWbldTV3AvUzBldjRXdWFrcDZ2VFM2WVRLOStuNlN1bk8vakd1?=
 =?utf-8?B?VC9oK21qSDcvMTVuTjFEYmpZZisxYlM5Rk1FT0FNdk5wSTJRZDBzV1ZBaEUy?=
 =?utf-8?B?OUxST2ZhTnJpVm84enl6ZkUzUE5vR1hwdklqODdYT2dCS3B2QXlOVjRLYXRw?=
 =?utf-8?B?cXM3YnQyZmQ3RzR2dGRPRHN5Nm5NZFVQNytZc29LOHlWM0pSY3kyL0h3RmRs?=
 =?utf-8?B?NFhlMHd0RUhmSVVhaG1henFpMGt6QU5BeUxGY3U1anNBdVNLc2ZQaTBpejVz?=
 =?utf-8?B?TFpLN05lOC8wNGJBaDQ5ZW9Sb3dwc3NUV081OFNqejQ0YlpHUXpob0wzRkdB?=
 =?utf-8?B?ai9TY3B1V1JEUmZVLzlvdzFwNmhUZEx6MGVib1dRTnJCTVk2K2lpdHdpSEFD?=
 =?utf-8?B?YjNQbkg0QzhFYUhiOSttWHNVb1p3NWlrWHdtRWVUT2hBWFJvTS9BTXlXUmkw?=
 =?utf-8?B?NmVEMFJNMndCUFU0YUt2eDJmWUlIOENxZXk3dTBiUGFLZUtia1R6RkRIVVVD?=
 =?utf-8?B?U2d5MVJhb2VMSmdHTUhoa1pGRkQ0Y1JZL2VRMzEvSENQTnRkSlpPQUVsOHU5?=
 =?utf-8?B?RVJaY3lSTnMwLy9BWjlTS1NGMXpJRnNEcFl1OGxGem5GaFAxaWlpNHY4Z1Bu?=
 =?utf-8?B?enJJNmxCVjRoeHFYbDRxc0xTK2hiWlJXTW50eitHaDUyMU5YdDBUVzdpTEVR?=
 =?utf-8?B?RlNFS0R3bTZreEM2VWQreE5zd0dLRkQ0TWNXQW9LOW04WEdEWUcvWmc0V1c5?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAD9C01B7F38B243915C63D6B23DCFCB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a13730-d255-444e-32ef-08db10032500
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 09:49:49.4148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g1eUgHCU7vj2Ee+MooAuKL22hr0o+K126+wzkM7Zg2J34t901h/0+hZuqbeDGVbVjoiKQXSAUze556BWxZNdIMOh+wLl8N0Tz873AV9inXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6918
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQuMDIuMjAyMyAyMzoyNiwgTWFyayBCcm93biB3cm90ZToNCj4gT24gVHVlLCBGZWIgMTQs
IDIwMjMgYXQgMTA6MTQ6MjhBTSAtMDgwMCwgTGFycy1QZXRlciBDbGF1c2VuIHdyb3RlOg0KPj4g
T24gMi8xNC8yMyAwODoxNCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+Pj4gQEAgLTQ1MCw2ICs0
NTAsOCBAQCBpbnQgc25kX2RtYWVuZ2luZV9wY21fcmVnaXN0ZXIoc3RydWN0IGRldmljZSAqZGV2
LA0KPj4+ICAgCWVsc2UNCj4+PiAgIAkJZHJpdmVyID0gJmRtYWVuZ2luZV9wY21fY29tcG9uZW50
Ow0KPj4+ICsJZHJpdmVyLT5zdGFydF9kbWFfbGFzdCA9IGNvbmZpZy0+c3RhcnRfZG1hX2xhc3Q7
DQo+PiBUaGlzIHdpbGwgYnJlYWsgaWYgeW91IGhhdmUgbXVsdGlwbGUgc291bmQgY2FyZHMgaW4g
dGhlIHN5c3RlbS4NCj4+IGRtYWVuZ2luZV9wY21fY29tcG9uZW50IG11c3Qgc3RheSBjb25zdC4N
Cj4gUmlnaHQsIGlmIHdlIG5lZWQgdG8gbW9kaWZ5IGl0IHdlIGVpdGhlciBuZWVkIHRvIHNlbGVj
dCB3aGljaCBvZg0KPiBtdWx0aXBsZSBjb25zdCBzdHJ1Y3RzIHRvIHJlZ2lzdGVyIG9yIHRvIHRh
a2UgYSBjb3B5IGFuZCBtb2RpZnkNCj4gdGhhdC4gIEkndmUgbm90IGxvb2tlZCBhdCB0aGUgYWN0
dWFsIGNoYW5nZXMgeWV0Lg0KDQpPSywgSSB3aWxsIHRyeSB0aGF0IGFuZCByZXR1cm4gd2l0aCBh
IG5ldyBwYXRjaC4NCg0KT24gdGhlIG90aGVyIGhhbmQgZG8geW91IHRoaW5rIHRoZSBvdGhlciBz
b2x1dGlvbiBwcmVzZW50ZWQgaW4gY292ZXIgbGV0dGVyDQp3b3VsZCBiZSBiZXR0ZXI/IEZyb20g
dGhlIGNvdmVyIGxldHRlcjoNCg0KIlRoZSBvdGhlciBzb2x1dGlvbiB0aGF0IHdhcyBpZGVudGlm
aWVkIGZvciB0aGlzIHdhcyB0byBleHRlbmQgdGhlIGFscmVhZHkNCmV4aXN0aW5nIG1lY2hhbmlz
bSBhcm91bmQgc3RydWN0IHNuZF9zb2NfZGFpX2xpbms6OnN0b3BfZG1hX2ZpcnN0LiBUaGUgZG93
bnNpZGUNCm9mIHRoaXMgd2FzIHRoYXQgYSBwb3RlbnRpYWwgc3RydWN0IHNuZF9zb2NfZGFpX2xp
bms6OnN0YXJ0X2RtYV9sYXN0DQp3b3VsZCBoYXZlIHRvIGJlIHBvcHVsYXRlZCBvbiBzb3VuZCBj
YXJkIGRyaXZlciB0aHVzLCBoYWQgdG8gYmUgdGFrZW4NCmludG8gYWNjb3VudCBpbiBhbGwgc291
bmQgY2FyZCBkcml2ZXJzLiBBdCB0aGUgbW9tZW50LCB0aGUgbWNocC1wZG1jIGlzDQp1c2VkIG9u
bHkgd2l0aCBzaW1wbGUtYXVkaW8tY2FyZC4gSW4gY2FzZSBvZiBzaW1wbGUtYXVkaW8tY2FyZCBh
IG5ldyBEVA0KYmluZGluZyB3b3VsZCBoYWQgdG8gYmUgaW50cm9kdWNlZCB0byBzcGVjaWZ5IHRo
aXMgYWN0aW9uIG9uIGRhaS1saW5rDQpkZXNjcmlwdGlvbnMgKGFzIG9mIG15IGludmVzdGlnYXRp
b24pLiINCg0KVGhhbmsgeW91LA0KQ2xhdWRpdQ0K
