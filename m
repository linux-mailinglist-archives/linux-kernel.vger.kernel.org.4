Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6BC5FA7B1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJJWdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJJWdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:33:21 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1F3688B3;
        Mon, 10 Oct 2022 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665441198; x=1696977198;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8eev/QXglZwCUAvbQb3sZy7wLoX1oYppll1nb2Cqed8=;
  b=QWKW6GB4RIQhnlmbrcRswRCND/h9zE3WFdr9zLIxRGqu+QIZyGizOybc
   wvjJRQXo53sxonhjCvPKfBpEz++xDyhYK3LCH8POiMdUwhbJHVkcXuzPd
   Lo5d7cAqS1XsQHQVH8BYv+aNEgzMY0cQctHQMl+R84KtYDN9buKEwejbJ
   0C/As1fZCYwHisrPfKcMYWl1eGPok+wptXWTw3hGZ4kG8Sio38IBOOf9w
   x1t1up/nA9ME0UFiW7yP/VIn2r81xmEIUDhriT/R70/aDDgDe4C8yTDjG
   sZdkll0CbfQ3WZoY3oMEHyZU4FRe7yoYWHQvab7OYcyVOyMH+BddwcOmH
   A==;
X-IronPort-AV: E=Sophos;i="5.95,173,1661788800"; 
   d="scan'208";a="325541410"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2022 06:33:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hwzx/QAmQx+Cu7C3S7BhSnyFmlgpZuNXyzzgdUDYVlrRe3ggKRSnhypUGWyev+7ILBsZvcPF3h1147wT29icNRhelN6EBEVLzn2fiUCKMNf0rbvGML1nZXlrog3O0Q6z4TKIULbVEBBr5OF7jbxVFUUMwDApvVWmwoxHXqLOsp0TgUn4gepayFyeadAgGl5e9DETuSJPpY+kwtRZ7Oqiq7VEvxXhRFzPjrIfvVhPpcOX2Cd/TqRJ0I3Fov9DVPsODOW6VAYQBEzf9JDGiG3nBVvvQxU5cfP6eyWEMzREeUxvICypH4Le8JEFF+NjRGavY6paqkeZ68LHjtg2qRpMEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eev/QXglZwCUAvbQb3sZy7wLoX1oYppll1nb2Cqed8=;
 b=BqJ7wkxzaPQCbdM14WbrOifuYWCk5Ig3+VaQruTHP0UQAnr0swpB/w9+ByT2iaHWvznRLVQgVxitzU9iWFXExi6mHRG8QgTri+Fn/W4Dmq9C5omJVHt7xeJgwhKCDy1fwrcG4bxXf1KGrXv2j+mgmsh8OQ2vfF+DvXCkGvO1HqodpQv3+ZWzILu/Sb8Hfgs1FQvWIXBg3+jvXyTAUVodlRIDJ8SNjl3YmBU2Ep4M6gMBQ09SxOwNzSha+J5pp0bkQPd8r97Pz/FQDtdOmSlFFuDUs8fyJIzdeYxhQO5PifFJauaCSPQ5oDhkY0HQ3YfWPw8BE7lEDLcjZLZa6tzrOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eev/QXglZwCUAvbQb3sZy7wLoX1oYppll1nb2Cqed8=;
 b=ZieouX8Eq+KBxoWV1zOXTS/WlNW/8dXM+O1vdG5b3ByrLtSy64Uu5qLEZVTszq268xEnxVafdP0g2FQ1jmJdmFwBfd38wTBxFLYxfkaKQMdhcyUhuD4jfyJ3lPthivtT8Card4isQ8qvbzZLtfBfGa056zlueSa7dwvC7LNdXwk=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by BY5PR04MB6312.namprd04.prod.outlook.com (2603:10b6:a03:1e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 10 Oct
 2022 22:33:11 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::6a9d:858b:63f9:92a0]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::6a9d:858b:63f9:92a0%5]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 22:33:10 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-actions@lists.infradead.org" 
        <linux-actions@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        "soc@kernel.org" <soc@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 12/36] pinctrl: k210: Add missed header(s)
Thread-Topic: [PATCH v2 12/36] pinctrl: k210: Add missed header(s)
Thread-Index: AQHY3OUK7Hzi1e2Cckqbcg8fjZ4z5a4INsGA
Date:   Mon, 10 Oct 2022 22:33:10 +0000
Message-ID: <4630d457-2d3b-6f66-7be5-54c84bdf80b4@wdc.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-13-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221010201453.77401-13-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB7081:EE_|BY5PR04MB6312:EE_
x-ms-office365-filtering-correlation-id: 23ad22ef-265d-47e1-ebfa-08daab0f6963
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S18HGjv2vENFQTifvI+NiIFsYPysXrRJRDXs6uAips6KjuwG/zyaySo2WruT6ueqUiW9uJNUL9t+Z3a6VW0J/6Z2YhkbyrVO/rL0W36M8qzD+XnhpVM/3nDS4ts5IQlnM+qkrz6XptA5bY/mIbjYpl3ALG4AsV+y+eJX74c9rbchYIKpAl9Qi0GsIIdS3ks8i8uc6fdDv7tcpBEIKYx91721gXfa0nohDal9Yd7Q+0AkDv9NP1Wig2++xsgKe9QidHIhMmhM/hWdnjZJEji1E0RPXtJk609l+HUI942sx0Tm63S0ptgNY44vRAnUE7vGZVaGhQuJzrAbRj+EcjYrTOdwWS011LSBxB5csltMP447lJ9gxtdrOVKQsks8xA1p9lpx5s0ob/JLctLovBQrG3PswivX97PxwCrICfbgeljedlYg/Smb1VYpiMAuiw7jDY2sa48fpO4Yg9+fPrnxqn67CSD0LHhzc53rKFLRoIbyZHVAdG9SpyJLx4omsPg13ztK0JiwgaGldqZ6dRTin/ET4T6XqYIZDdq3qDv5XT/5b2ZJBYS3yWdS51CNjwwuRuU9uP9FWAkWk24+L9vqveeh9VBIVWAYfL+fz/vmdF9QSRGChxDeCLqY8pKKH+RMMVuxfGhGMyK/G+KC9Vz5soor7T/kLsB/wXVLlxaZSz/tNdZZzcLXIOw0PDJGVxviqChAiU4HxspMx49uqY4NDHKQFk95IOh3JqcSmbfHwLkBQlfKm6i5/4xMgTShI5E72+ISvfBfVh38WriS5y2R6CXgr+kQZ3J1CrfkdDajd5760XZ+Ao9YN1u9FYQo7QJ0kFnk6QtNImf2ghhX5qW4mSJKKaD9tRHooqUP9QxX9C4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199015)(7416002)(7336002)(7366002)(8936002)(86362001)(26005)(316002)(38070700005)(7406005)(83380400001)(6512007)(82960400001)(54906003)(110136005)(6506007)(36756003)(2906002)(53546011)(921005)(31686004)(31696002)(4326008)(122000001)(186003)(478600001)(91956017)(2616005)(64756008)(76116006)(5660300002)(66476007)(66446008)(66946007)(41300700001)(38100700002)(6486002)(71200400001)(66556008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mjhackd3blZjS1hLQkNFbnEzM0wxOXRMMDB6Z0RJSzNwWGZweng5eXlncUcr?=
 =?utf-8?B?MU85MmRvREJjZGh5dDA3Wkp5THZTdmpKR2liNTFUM3lxWjhTRXZiWU9BRUl5?=
 =?utf-8?B?cmo5SWFlUTVGYkVVOTZIaGlhdFdMamY5SHpzeWVkRG5tQkdabFduNU82K0F0?=
 =?utf-8?B?QmJtS25FNld1VTlZb0UrUUZNVmpaUktrZmFVSjcrbkFlYVViNmZzMU8wV2gw?=
 =?utf-8?B?NU8veWRzelFZVzI2OVZrNXlLNkV0QXpQV0FyWEdsVktHSVlqYlU1UldMZmpL?=
 =?utf-8?B?SVNwM1pUQ0dQNDd4a1pNNnQvNGZzQkhRbzFIVHdZaXFqMG5YT1JRVXk0Zm92?=
 =?utf-8?B?N3pkU203SDE3TURoUEp5RXJ3VDlHamFBU0hsL2twWHA4NVIrZGNLa0R2WXYv?=
 =?utf-8?B?a1hrWmRCQmdrNWxuMUhMZ212cTVIbGxPRmtISmh0WktsVHFGWS9obkFOTTV0?=
 =?utf-8?B?T1BGajNIcXJjQ0tNR3BvUi9LT2l1anZVdjl1VytXMGdsSkQxSkJPdnpsNjdl?=
 =?utf-8?B?Z25UZ2tqTWVCSXBxVFVIM0FjUHZkYXJsN0FqcStvUVRxUHVSVEFUWURqb1Vk?=
 =?utf-8?B?dWlIMUs0c3NwUlBvWUh2OEVkM1FyVmNKaWFXSFNCSWdtSjg5S0gyZC80YzEv?=
 =?utf-8?B?a3htZVhtUFBlRGF3UnhzNmtXR003VnF4dDg2VmVqTTdwT0M0Z0pZTVVVUzlt?=
 =?utf-8?B?eDI5ZGVBUUpaYVRsQjB2M3BMc2ljQXNPZUplSHBOOEpqS3ljNjVWRFhSVTFF?=
 =?utf-8?B?UWlrRUdnYmdWbkcvZ1FhTUlzZHRyN3BiZjUzSlgyT0RacmpQeWZmUGxHRVlO?=
 =?utf-8?B?emdoVUhVa0hGQlp6TXk2OHRnNkdxQzllZ056MW9ZeGpOTzYwN29XSnJnRUpI?=
 =?utf-8?B?RGVvTXBIb1BaM3NLcS9wVkUyVnNlSUxOc0VtdElDVFdROUZkcEVmb24wLzhI?=
 =?utf-8?B?ckkzQ2IrdXFRbU5nQUp6bnJMemI0dXkrRjlNQ3pSeWVtSkRGdzNYM1NOVWxE?=
 =?utf-8?B?Mk5pZFJiQytUL1Q0V1JleS9xUHJKNktqcUFqY1lxT1NscmpvMlJ2QVBVd3NT?=
 =?utf-8?B?MlhqcWE5dVZScTJUWFJMbW1TNVZJTjR4djdsOTYyOW53cW04RFBJMzBBWU5x?=
 =?utf-8?B?MDM1WlBrNkxWb3ZuQkZGcE56TW4vazVzL1NHZEg1MGpJRzRSaXZEQlhlSDF1?=
 =?utf-8?B?NW1jRHU5R3BHUGxMTFRrdEV6M2ZOM20rZ2NURkRrVVR3OGZJeUxPZ092dktu?=
 =?utf-8?B?a0k3bGIzaVJqS2ZTdHFrZWpiaVVua3dkb2thdElvMXNmVVJxdXVhMCsxL2dQ?=
 =?utf-8?B?S0RBdUtQSjhLeU9PMG94WHQ0QW5XMkN4c210S2RDTlVqMWlQb24wd3RkNkVU?=
 =?utf-8?B?SFNQT1IzS2hFNGhRSWpwR2tEbVQ1bUM5QkpOMmZ6NU5XWWVVNDBXNnYxc0Nl?=
 =?utf-8?B?VE16Y1NpMTczV2NYS2FGZlcrdlRkU25lc0t6WCtqdUJTeExpdHNHeGd4NVVQ?=
 =?utf-8?B?T0h4RTRxcDVSbVRVU0FDVTV1QmlhS1JZaDRaTStrdlRaS1c4VGphY3UzU0ZO?=
 =?utf-8?B?aEFxWG9Ia0FiUExXRFpWeHZwMHZjYTRNcnlSYVhtQ091RVZWa0I1SnpTZVI3?=
 =?utf-8?B?RDdZdlA2d21leExOWCtmajhRczQrRThsWFJtY0YybWNsVGRVQTVnVk1KdG04?=
 =?utf-8?B?U05JMHB4L3p6KzhMY3lFd1RxSUNwUVhjK09jc3Rlbkx6Z09CNk40SnhYL0lP?=
 =?utf-8?B?N0gxb3lxdkFZUHlnNjlqcHQwZ3ZoMW4zQlRCdzBRT3hDaXRFbHJCS1VyMGxi?=
 =?utf-8?B?enVJeExnODJjcUFGMzBSMTVJUU01dVBLMVg1UU9FVWdWRzZZNVJGTkdQanRx?=
 =?utf-8?B?aXVLRUUyM1FSbmpYdnVBUVBnQzFLY0wxWnIwVmY1L3RyYldOVkpwdGJYZFFE?=
 =?utf-8?B?VmdWRzNyNzJ2VisxdmFDSHZ5U3YwaHVLUS9PWHEyaUI0RHFTbEdabHJ1anlO?=
 =?utf-8?B?LzJzOHc5eGIyblVkcmtTU05zdjVOK0ZrRWNyREwyYmpObjBUYWdpaml4eXp5?=
 =?utf-8?B?V2MzZGdYa3U4MmE1VzBYQkw3WFV4K2kzT0hqcTFwNFJzZURGVENMYU5vSnpW?=
 =?utf-8?B?bDRXNlRHRGZnZUFNeGVPSmdrVHk0Wm9zbUdrSHhoblN6Nk5sR2dQZDVxUnhp?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5464410C30B55441B314A1F016D008B1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ad22ef-265d-47e1-ebfa-08daab0f6963
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 22:33:10.6737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ie0GIm3nyNBXQT2Hobs/LRmhzHAGJ5yChN1DH/Dp3ZPIsB3m8+qD0cldnpvgNy2XOk7p2xlaavxPk3ctAs8Yww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6312
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMi8xMC8xMSA1OjE1LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IERvIG5vdCBpbXBs
eSB0aGF0IHNvbWUgb2YgdGhlIGdlbmVyaWMgaGVhZGVycyBtYXkgYmUgYWx3YXlzIGluY2x1ZGVk
Lg0KPiBJbnN0ZWFkLCBpbmNsdWRlIGV4cGxpY2l0bHkgd2hhdCB3ZSBhcmUgZGlyZWN0IHVzZXIg
b2YuDQo+IA0KPiBXaGlsZSBhdCBpdCwgc29ydCBoZWFkZXJzIGFscGhhYmV0aWNhbGx5Lg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51
eC5pbnRlbC5jb20+DQoNCkxvb2tzIE9LIHRvIG1lLCBidXQgdGhlIHBhdGNoIHRpdGxlIHNob3Vs
ZCBiZToNCg0KcGluY3RybDogazIxMDogQWRkIG1pc3NpbmcgaGVhZGVyKHMpDQoNClNhbWUgcmVt
YXJrIGZvciB0aGUgZW50aXJlIHNlcmllcy4gWW91IG5lZWQgcy9taXNzZWQvbWlzc2luZyBpbiBh
bGwgcGF0Y2ggdGl0bGVzLg0KDQpXaXRoIHRoYXQgZml4ZWQsDQoNClJldmlld2VkLWJ5OiBEYW1p
ZW4gTGUgTW9hbCA8ZGFtaWVuLmxlbW9hbEBvcGVuc291cmNlLndkYy5jb20+DQoNCj4gLS0tDQo+
ICBkcml2ZXJzL3BpbmN0cmwvcGluY3RybC1rMjEwLmMgfCAxMiArKysrKysrLS0tLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtazIxMC5jIGIvZHJpdmVycy9waW5jdHJs
L3BpbmN0cmwtazIxMC5jDQo+IGluZGV4IGVjYWI2YmY2M2RjNi4uMjg4ZTQ0NDU3ZmVjIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC1rMjEwLmMNCj4gKysrIGIvZHJpdmVy
cy9waW5jdHJsL3BpbmN0cmwtazIxMC5jDQo+IEBAIC0zLDE4ICszLDIwIEBADQo+ICAgKiBDb3B5
cmlnaHQgKEMpIDIwMjAgU2VhbiBBbmRlcnNvbiA8c2VhbmdhMkBnbWFpbC5jb20+DQo+ICAgKiBD
b3B5cmlnaHQgKGMpIDIwMjAgV2VzdGVybiBEaWdpdGFsIENvcnBvcmF0aW9uIG9yIGl0cyBhZmZp
bGlhdGVzLg0KPiAgICovDQo+IC0jaW5jbHVkZSA8bGludXgvaW8uaD4NCj4gLSNpbmNsdWRlIDxs
aW51eC9vZl9kZXZpY2UuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9iaXRmaWVsZC5oPg0KPiAgI2lu
Y2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQo+ICAjaW5jbHVk
ZSA8bGludXgvbWZkL3N5c2Nvbi5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0K
PiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiAtI2luY2x1ZGUgPGxpbnV4
L2JpdGZpZWxkLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcmVnbWFwLmg+DQo+ICsjaW5jbHVkZSA8
bGludXgvc2VxX2ZpbGUuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ICsNCj4gKyNp
bmNsdWRlIDxsaW51eC9waW5jdHJsL3BpbmNvbmYtZ2VuZXJpYy5oPg0KPiArI2luY2x1ZGUgPGxp
bnV4L3BpbmN0cmwvcGluY29uZi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BpbmN0cmwvcGluY3Ry
bC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BpbmN0cmwvcGlubXV4Lmg+DQo+IC0jaW5jbHVkZSA8
bGludXgvcGluY3RybC9waW5jb25mLmg+DQo+IC0jaW5jbHVkZSA8bGludXgvcGluY3RybC9waW5j
b25mLWdlbmVyaWMuaD4NCj4gIA0KPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3BpbmN0cmwvazIx
MC1mcGlvYS5oPg0KPiAgDQoNCi0tIA0KRGFtaWVuIExlIE1vYWwNCldlc3Rlcm4gRGlnaXRhbCBS
ZXNlYXJjaA0KDQo=
