Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C18F5FC176
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 09:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiJLHxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 03:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJLHxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 03:53:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C30AE218;
        Wed, 12 Oct 2022 00:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665561178; x=1697097178;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AzjU9KmDXhXksh2509IqnUA3Ir7AdNEhmUgJGAgdidA=;
  b=mvY0744cCY07inN8YWs2H90ijKTWnvrMLxVXBguliFsp+WUkspy8kHrQ
   Kv0pDIGjg6nTCVU1gycE9cPLMArlXdfuIpbY9WdwIZcGXbryWNwNA3oX/
   aAK4LGTSpfwxfg8mdl5+oGvwMVmpG9+MoT5QAv/9fnsKugLZZE3Xwkdfo
   0dGTiy8QutrH9b4nzC72Fbixq+OfTgOnWqn45VfKu469DzwIiIuXBCk4j
   Is7v0sBix/h9nz8VVjO3RLHDYqlZ5ihgmdeyhFY5ECnufhwE6SNsJhUKf
   Vkp26o5a8x0XOUW2AU5FT+ybp9w97QQ5opsd9YIJkyR/tplsb5lSOc/Sq
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,178,1661842800"; 
   d="scan'208";a="194999131"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Oct 2022 00:52:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 12 Oct 2022 00:52:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 12 Oct 2022 00:52:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKI3kkjREsRd54Z+DOwIjD9/lsu52uhkXsgldb1L/T/abBkW9LNbGU31vCzRvy0lifqDFfOQwYlWOpgVQYnsC7MuMsO4Zl4+BWB6ro3hAJFQpmPtr/AVMhbBv6NXb5o+FWILQQdqMB5SoEwhS65HwHjv8Wg3Av6Rh5jM1s+yt8f+BZ9AbCLwXpR68rzlBIkKCOQkGJBIA4cG32ro6E2Rz7+j1CJoWtl0NidDun3iDlZrFXB4vzRy0/gBGeX5mmWCji4LDoJCZeEznSqYsiE+7/AuFp5O2IGr/H59wT2HOgAPpRV7RtOtOkIgvp9nA7h+1RQzD5mqtY3MzTVPKS4Hmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzjU9KmDXhXksh2509IqnUA3Ir7AdNEhmUgJGAgdidA=;
 b=BY3X8ZTu2sBztgaa+rj4IcR9WeASWZeLCfD7AIkxtdYLcd1vZYMWs1DqLt5fbSPEN4brvKvjVBVsrU9tw5ydf8fHE3gXntuUK7jRBGbmEXRjw282Gs3wZ6if4T1+z8MeYMc3VRQlO5zquaUGjN1SEmCtRWjOpPojXavMtzuvrimCeUS4mkLeDlAs+CTee6KA8j4VG4ULZgqNceN5YIm4857xGU91kqKQnra0s+8Hp1q0zqVBwFSk44GiMiyRpA9xzokaX0i2DvixIzt20qSBoOieMw661dFg4SFjRluT9vrtIcNtuBHjpF9GTv7bvaHSnr4dHy2bUYJ6aycNrdj1gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzjU9KmDXhXksh2509IqnUA3Ir7AdNEhmUgJGAgdidA=;
 b=gLqxiD6/CgHEN9Ue05WsOIs6R46h37i/cy5rml1GhNHLEU90bYPuTCgjPSVPsbD+gyLzGZbdkBw6/k7L7abwhA0p6doq2d81Lxai2C2ghjUiD1EDAl5ZAkjHKQxDd2DnvMnylB4TOe02s8V/B7eEYn9DRq8Mw2lXQwsT4BcvTgg=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by MW4PR11MB6714.namprd11.prod.outlook.com (2603:10b6:303:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 07:52:50 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 07:52:49 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <andriy.shevchenko@linux.intel.com>, <maz@kernel.org>,
        <brgl@bgdev.pl>, <warthog618@gmail.com>, <mchehab@kernel.org>,
        <billy_tsai@aspeedtech.com>, <tglx@linutronix.de>,
        <linus.walleij@linaro.org>, <mika.westerberg@linux.intel.com>,
        <angelogioacchino.delregno@collabora.com>, <wenst@chromium.org>,
        <samuel@sholland.org>, <Horatiu.Vultur@microchip.com>,
        <rafal@milecki.pl>, <bjorn.andersson@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <geert+renesas@glider.be>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <phil.edworthy@renesas.com>, <krzysztof.kozlowski@linaro.org>,
        <fabien.dessenne@foss.st.com>, <pshete@nvidia.com>,
        <Basavaraj.Natikar@amd.com>, <linux-gpio@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-actions@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-mediatek@lists.infradead.org>, <linux-mips@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-omap@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <patrice.chotard@foss.st.com>, <afaerber@suse.de>,
        <mani@kernel.org>, <andrew@aj.id.au>, <joel@jms.id.au>,
        <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <ckeepax@opensource.cirrus.com>, <rf@opensource.cirrus.com>,
        <aisheng.dong@nxp.com>, <festevam@gmail.com>,
        <shawnguo@kernel.org>, <ping.bai@nxp.com>, <kernel@pengutronix.de>,
        <s.hauer@pengutronix.de>, <linux-imx@nxp.com>, <andy@kernel.org>,
        <sean.wang@kernel.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <avifishman70@gmail.com>, <tmaimon77@gmail.com>,
        <tali.perry1@gmail.com>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <wens@csie.org>, <paul@crapouillou.net>, <damien.lemoal@wdc.com>,
        <tony@atomide.com>, <haojian.zhuang@linaro.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <michal.simek@xilinx.com>, <agross@kernel.org>,
        <konrad.dybcio@somainline.org>, <tomasz.figa@gmail.com>,
        <s.nawrocki@samsung.com>, <alim.akhtar@samsung.com>,
        <vireshk@kernel.org>, <shiraz.linux.kernel@gmail.com>,
        <soc@kernel.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
        <kernel@esmil.dk>, <hayashi.kunihiko@socionext.com>,
        <mhiramat@kernel.org>
Subject: Re: [PATCH v2 06/36] pinctrl: at91: Add missed header(s)
Thread-Topic: [PATCH v2 06/36] pinctrl: at91: Add missed header(s)
Thread-Index: AQHY3g+flaTivOOpdE+KrgNE+MhlgQ==
Date:   Wed, 12 Oct 2022 07:52:49 +0000
Message-ID: <6846a969-028c-f499-2e15-4ae2536edaa9@microchip.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-7-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221010201453.77401-7-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|MW4PR11MB6714:EE_
x-ms-office365-filtering-correlation-id: 0096441e-575c-4faa-b178-08daac26c26f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Psq3jYbE9zIVIdlFRHC4I4HX3YabrDUKmSPxb5L/MKz7lizqH7E/NDftxwJebenZxet+BOFGb5k/FOl2xJ7CSClirxiwmRXd7EOi0VVIo01dTdESHetKqUew0dVD78uSR5ZsubEiliEfB5HBhgsFjbWnHvJa6XY6uMdAW7rrq4c8XSWvgP/zDp+9fUsMnIffnZuxAiTDdFTNGglSb1uQfZttL/3guCK25EV+xz8SEzv1/Vl+bov/7x6Of/O4X1PeB0oXkAWxVqHN+SKcblbBwgqQTiOYUVFEJwOpsjFEnc8fKMlntD6ujnG460uu8MXP2qEgj3DzyHS2dVxIsjkXtT5MflzWf7JbEwe/yjiP90jrA9MNqZZUOSrg0e1nqvMLA+VP/PWQ+10E6VH363bV6xmB+ftN3cVpje9xNPHYpkeK9pzGGHfHKhEI18NJOcczqevbN3lQanTfeoz7malHIGQE2tCJh3MZMUilrXLpp3w0Qdwf3/EiYutTNt1JLqAblxWaquq1bOAbZcet0cp91/ac+I4/RTTRdhsjRtIG4cAy7opfVPPXG4gmE9CnaIApxi6iBsYFc6VoM4UJ8uXWXiZ0eKSVjtvZuAeCena4C2bRUPWKzXwo5B0U7UG0BmPpHmvkQPYVf7CU5xCqFfAkk08UDU27NNk058VWUqk1WLmpEMm0uKtFA88lCv05o8Jm/xyy/hUmzUt4Am5qw+2EttqupUOwvVLeZRLXt86YQSV36C5wVhXXKgqk9GCnTRXHjqX+xzI1/orberFTVSZsDOWdyygKY+eV+4TXW4uHN6F+Pm5GOkboFYKEuBizrsxUoBYZv/LGGgL99GAJRStv5LPu936V8guF3ERwpTY7TkM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(31696002)(122000001)(38070700005)(921005)(38100700002)(31686004)(36756003)(86362001)(186003)(2906002)(5660300002)(83380400001)(7366002)(7416002)(7336002)(7406005)(6512007)(66556008)(2616005)(26005)(53546011)(6506007)(64756008)(66446008)(66476007)(4326008)(8676002)(66946007)(91956017)(76116006)(110136005)(71200400001)(41300700001)(316002)(8936002)(6486002)(478600001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkJyS0NIblR2TzV3UDZiTEhHWUxCZlJJWE0zZlhkeVM5K0Y2NkdQTnp4ZjBS?=
 =?utf-8?B?K3VqTVh1N21KV3hVRzFubUNTVitBbUlmTHowdGN4cHorWHpyZzNVcitwV0tW?=
 =?utf-8?B?OXlwTFFubDhwSWF0QWx3VE84R2NBWFYvdVJDTEJlQVMxNmdLV2VKZ1BhZjdN?=
 =?utf-8?B?N0NvM3FRSnYyMExhbU5SUVBsTzdhZmwwYUFwMTFiVnkyRFhxLzV6S0dkb1do?=
 =?utf-8?B?MnBCb2N5WUpIMW4rY0lnbmZnUzU2QmFhWDB3Mk1UZVRNMjhZaXQwbGFZS1Zm?=
 =?utf-8?B?aHZadEliMVhGTUR3RGQ3RkJmbGtOTzhoVnZFeGF5c2gxK3FzbE01RVJpZ1Nx?=
 =?utf-8?B?TzgyNlZYT3llM1ZINktuL0dUQmdPWnI3UnFNTFRHY0N4S3JESENrYjdtUWQ2?=
 =?utf-8?B?aFY2MmdQMG1IVUFTdEZYeW1jRTZNSHdNWjByNnl5U3dhd2Jnc3V5YldPZFo5?=
 =?utf-8?B?UGJmUW5XdFo5VTZnUnFGYkErbFprRldQcU1jemtUd1lQYVBqRC9waFpMMkZY?=
 =?utf-8?B?VjQ0YmtPUndZZG5HdElIck9TcVJBcHpCQ1dzTTdQNnJkR2R6NTQ0NnlUNW9W?=
 =?utf-8?B?MkZ4bFRsZThZR1VYUC85KzJrSVpGNnJ3MmtFVmZXd2hGTUw0TXdzODZSelE2?=
 =?utf-8?B?ekdsRkc0MndhQ2FFN0tFdHgxcWtnRHFRdDcvNEg3SS9QV3kvWkdrTkwraEwx?=
 =?utf-8?B?bE1SOEhoM3VsaUViL0p2U0dTdXBOYllGUjg1OFYxK2wreU5iUzdOaFNyVm1Q?=
 =?utf-8?B?VS9LT1pQOHVxOXFlRFBmSGxaVnIrNUdmL2JHZkZzNFZOM1EzaGp6VVYzeHJa?=
 =?utf-8?B?NkJBZEVLMldVaHo1TFo3MC85WVQvY3FWZVppRDZFT21zWGpCOFJ0aVJ0cjgy?=
 =?utf-8?B?c3FwTlNGYkF2bndocnhldk8xMnUybFhlTDgxUStwc0ZHOGZlanVYMzN3UXNt?=
 =?utf-8?B?aDhFS2VsL2RWNlJxYUNQQ2tPR1NJT2ZaUGxFeWNlOTI3UWgzT0hValpIU1Bv?=
 =?utf-8?B?VTVrOEZRTzkzT3BuTUhqd2duWW4rU1B0dWRWeUI1RGQ5Ky9aNHRIWXpUd055?=
 =?utf-8?B?K1F2VkpOdlpBNlBPR1A1NjNyK0lGRE92WVQxNFNaS1Jka2l5RjhLQ0NVSXZ0?=
 =?utf-8?B?QUtXdDlCazNoMVMzMVNrWXl1bkdIZURlLzhtalhTeHZMdXorWWtSY0d5dC91?=
 =?utf-8?B?OUFlQlpWaDlxZnZWNDloWi9NV3lzTHNPbEV4WXhoUHNQSEFsODZvbm5aQzdY?=
 =?utf-8?B?KzZWOGVzc0tsNjdKV1dFT09OeitHRHJOeTg3VUNmYVhWWnN3M251RTVreUdi?=
 =?utf-8?B?WnR4MnFQd0hSWUJFK1NyOUhsQUVJZUxxLzFKSEJOUFZwNGJyUzRRanJ5Wk1p?=
 =?utf-8?B?WnArdmMvSklNV0JkMStvSkdjY3JlT0xTSjU5ZWh5WWszajdrVlFPT1pSZG5W?=
 =?utf-8?B?RkVmeGk5d1RLZHF4OU5RaHA0WjlFei9acm9lYVR5ZVJ0b1VMT1BvcWd6dml3?=
 =?utf-8?B?SnBLMG94WTUrYkF4blBTejZMT2lWWnBsM0VvVG13azJIblo1MDFHTG9selFy?=
 =?utf-8?B?RkJtUHlMQi90UGIxRjZUTGQrQWsvTEtuTE1SWGdLdGM1RDZjc1dvc01nNmdt?=
 =?utf-8?B?dXFUdXJMVTJuaEsxNFJybUk4OGFVWkM0VlFQSjgvb2ovWWgzcmVwcG50Z3pZ?=
 =?utf-8?B?b1lMOWlNWUZNZWtRaWlqWm94aEc3a2hPRlNoMTN0ajU1VXdLYlpHeTlSazZ2?=
 =?utf-8?B?OSt5Z1c3cms3TXFCWXZ4K2hKWUpBTk1IbUJmeWZqUXRVN1RyeDhVY3FLd1lB?=
 =?utf-8?B?REcvai9oR2dyblF6MHlIajZaaHlnTXI1Q2liL1Q4ei96OWo0T3ErSEo0cW5V?=
 =?utf-8?B?NXBLeVdZTFVkWTVWaFJJQUpRdHZFYmhCMlhzTlBmejFYeGxKWWt3YXF4U2or?=
 =?utf-8?B?Sk9adDN6UGhwSkRFZGtWZWxQQnEwMUJuOFlCOXJ6STFQYTZoT2RDVEZ5MmZK?=
 =?utf-8?B?RldTTGdFZ2NOcUdCdzBrNzYzSDhLaEV1Yml1VlE3N1UrSjFQNXMxU0pENXdC?=
 =?utf-8?B?Zkt2WEtsSDJqUXBpZjlZSytkWWNDREY1djhwKy9hYVlpcGl2d3J1MTVJU3ZL?=
 =?utf-8?B?cUxYMUlyZXk1K0E5cHRJQWUxTTlybjV3czNna3ZoN0V2YjF1Yk9HMUh1c2cv?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1AC15B49B13DD44ACE746A45676DA23@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0096441e-575c-4faa-b178-08daac26c26f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 07:52:49.7024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/TxfIJr6OUcJE1EXWFHdnYwoSvzu309puMA5S5qo5eCM75kYON+7LKtvk8pK3o/4jci3yqkm7mB8IyFRLznXE2ZKvL+DczuerTRJYg1A+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6714
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAuMTAuMjAyMiAyMzoxNCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IERvIG5vdCBpbXBseSB0aGF0IHNvbWUgb2Yg
dGhlIGdlbmVyaWMgaGVhZGVycyBtYXkgYmUgYWx3YXlzIGluY2x1ZGVkLg0KPiBJbnN0ZWFkLCBp
bmNsdWRlIGV4cGxpY2l0bHkgd2hhdCB3ZSBhcmUgZGlyZWN0IHVzZXIgb2YuDQo+IA0KPiBXaGls
ZSBhdCBpdCwgc29ydCBoZWFkZXJzIGFscGhhYmV0aWNhbGx5Lg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQoN
ClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNv
bT4NCg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5MS1waW80LmMgfCAx
MCArKysrKysrLS0tDQo+ICBkcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLmMgICAgICB8IDE2
ICsrKysrKysrKy0tLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwg
MTAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL3BpbmN0
cmwtYXQ5MS1waW80LmMgYi9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLXBpbzQuYw0KPiBp
bmRleCA4MmI5MjFmZDYzMGQuLmUzOGM2ODNhYmEwOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9w
aW5jdHJsL3BpbmN0cmwtYXQ5MS1waW80LmMNCj4gKysrIGIvZHJpdmVycy9waW5jdHJsL3BpbmN0
cmwtYXQ5MS1waW80LmMNCj4gQEAgLTcsMTggKzcsMjIgQEANCj4gICAqLw0KPiANCj4gICNpbmNs
dWRlIDxkdC1iaW5kaW5ncy9waW5jdHJsL2F0OTEuaD4NCj4gKw0KPiAgI2luY2x1ZGUgPGxpbnV4
L2Nsay5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2dwaW8vZHJpdmVyLmg+DQo+ICsjaW5jbHVkZSA8
bGludXgvaW5pdC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPg0KPiAgI2luY2x1
ZGUgPGxpbnV4L2lvLmg+DQo+IC0jaW5jbHVkZSA8bGludXgvaW5pdC5oPg0KPiAgI2luY2x1ZGUg
PGxpbnV4L29mLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+IC0j
aW5jbHVkZSA8bGludXgvcGluY3RybC9waW5jb25mLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvc2Vx
X2ZpbGUuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ICsNCj4gICNpbmNsdWRlIDxs
aW51eC9waW5jdHJsL3BpbmNvbmYtZ2VuZXJpYy5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3BpbmN0
cmwvcGluY29uZi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BpbmN0cmwvcGluY3RybC5oPg0KPiAg
I2luY2x1ZGUgPGxpbnV4L3BpbmN0cmwvcGlubXV4Lmg+DQo+IC0jaW5jbHVkZSA8bGludXgvc2xh
Yi5oPg0KPiArDQo+ICAjaW5jbHVkZSAiY29yZS5oIg0KPiAgI2luY2x1ZGUgInBpbmNvbmYuaCIN
Cj4gICNpbmNsdWRlICJwaW5jdHJsLXV0aWxzLmgiDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bp
bmN0cmwvcGluY3RybC1hdDkxLmMgYi9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLmMNCj4g
aW5kZXggODFkYmZmYWI2MjFmLi4xZTE4MTNkN2M1NTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
cGluY3RybC9waW5jdHJsLWF0OTEuYw0KPiArKysgYi9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC1h
dDkxLmMNCj4gQEAgLTcsMjIgKzcsMjQgQEANCj4gDQo+ICAjaW5jbHVkZSA8bGludXgvY2xrLmg+
DQo+ICAjaW5jbHVkZSA8bGludXgvZXJyLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvZ3Bpby9kcml2
ZXIuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvaW50
ZXJydXB0Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvaW8uaD4NCj4gICNpbmNsdWRlIDxsaW51eC9v
Zi5oPg0KPiAtI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L29mX2FkZHJlc3MuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gICNpbmNs
dWRlIDxsaW51eC9vZl9pcnEuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9wbS5oPg0KPiArI2luY2x1
ZGUgPGxpbnV4L3NlcV9maWxlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiAtI2lu
Y2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPg0KPiAtI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQo+IC0j
aW5jbHVkZSA8bGludXgvZ3Bpby9kcml2ZXIuaD4NCj4gKw0KPiArLyogU2luY2Ugd2UgcmVxdWVz
dCBHUElPcyBmcm9tIG91cnNlbGYgKi8NCj4gKyNpbmNsdWRlIDxsaW51eC9waW5jdHJsL2NvbnN1
bWVyLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcGluY3RybC9tYWNoaW5lLmg+DQo+ICAjaW5jbHVk
ZSA8bGludXgvcGluY3RybC9waW5jb25mLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcGluY3RybC9w
aW5jdHJsLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcGluY3RybC9waW5tdXguaD4NCj4gLS8qIFNp
bmNlIHdlIHJlcXVlc3QgR1BJT3MgZnJvbSBvdXJzZWxmICovDQo+IC0jaW5jbHVkZSA8bGludXgv
cGluY3RybC9jb25zdW1lci5oPg0KPiAtI2luY2x1ZGUgPGxpbnV4L3BtLmg+DQo+IA0KPiAgI2lu
Y2x1ZGUgInBpbmN0cmwtYXQ5MS5oIg0KPiAgI2luY2x1ZGUgImNvcmUuaCINCj4gLS0NCj4gMi4z
NS4xDQo+IA0KDQo=
