Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A9E6F8356
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjEEMzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjEEMzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:55:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956DD160AC;
        Fri,  5 May 2023 05:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683291314; x=1714827314;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cs02AJ1e1ozAZsRboWt2w7/CZdX5G5K3f6tDMmEClSo=;
  b=c0tFPB1nw7FhuUamopMKJzXd+fTsW/2iWYPUtDpQVIXBUl+2bfOz7ACg
   A/saqCHdbW3Ke68uRck+ZRLzGP6J+H5KPizMhmv0G1VY0DPVJwMpIDkSJ
   iTl4vdgPgkWGM5TaJJqc06vp5Z7OEY9AiZpVYpREvBZOb1XX37gi4xtDz
   vmti9swYtM927kFxQT1kOGz6LRum+zwQSbxWpWMlbjvQYP4CRlDrQdMso
   +c5wLGFV7CCcdATnxeyWw93d0jbf6++H2JKl/iDpvpuiVsNJ4npTf1pWr
   T6tOgHuqa4jSuwttxtg1m+fRd19nv2ZBdN3hGC7VGl2A8wjc/aoa2v4iI
   g==;
X-IronPort-AV: E=Sophos;i="5.99,252,1677567600"; 
   d="scan'208";a="209832457"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2023 05:55:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 5 May 2023 05:55:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 5 May 2023 05:55:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhgjCNN5nkoQBIPnaTBxzQQMvVMRcsq2ITjVhQZAzVnhhRlanvN0vCC22UnWo7j1df1+dKSwt27xFC9mdzOe99A+6Hh93gad7q3Zgs9Vvn2CEveHdkiIhSjksVnZrDDNs+fjpWLOBa01RQZMvJWHHi+BNIWS9QpZWvBlEoXwRDDwn5gHqy46/6ruJLsQXIST/AnDPKG24S1xGDRJs3xK8u5brFtL3RinxdPr1DBwfM/NKHhV2RmHgEggoccaWrEUyqK7ggvRjFnD9KFYCiLBZ6+PptiqnA836HKuFGP/PKsHTOKOAr+C72ODjx2do1g+wAJqe3rXCXBZLop+RK+13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cs02AJ1e1ozAZsRboWt2w7/CZdX5G5K3f6tDMmEClSo=;
 b=R9RgfGYZSQINZlLCntH/junEt/4Z53I4J4ptVJ00qvmpl1QTvKAejXwfpIbIVok6h7w2nlnNy+o/cB67aoEEMHl9xk6eI1GaTxqOEXvF/Hr7lvMjn/S9eZBKr2IRCLC3fFODO2MUPlwxXf0aSR5XCjXiZmQrtFssnAA71Isrx1Pr8gOF4AoQNvOIpsDenPzHuyFMqKNQarM4GlX8EO3y69i/24PXwGvL4zqAaJWYPz+Iao4Ynt+2lfq9iOjorbgsd/6IeKSh7UMhzs8wA9Lh/mAMm7evKxUA1Nsta22ThaCjhqTBalhD1wNR21Qxe9mZqo6Tbo2j6sQ5nvsNZ5QvTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cs02AJ1e1ozAZsRboWt2w7/CZdX5G5K3f6tDMmEClSo=;
 b=Aap+gOutyakp491unHwMNR518Al7bEJDRZ2yjJF5Fix0pJQkFfXEbm4iihVJNUpalwC1AeJtl0EN5JjTGe/n6Luq0qqAxm9N9aWTjJiuM8Q3IJwzvufxrt0iDir6ThqBe9v0006VNvbUEcj5AsxoMsVP9MXSXqahoqVCrOP6+Pg=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by SN7PR11MB8262.namprd11.prod.outlook.com (2603:10b6:806:26e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 12:55:06 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%2]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 12:55:06 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh@kernel.org>, <soc@kernel.org>, <ansuelsmth@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux@armlinux.org.uk>,
        <masahiroy@kernel.org>, <afaerber@suse.de>, <mani@kernel.org>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <festevam@gmail.com>, <atenart@kernel.org>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <linus.walleij@linaro.org>, <sudeep.holla@arm.com>,
        <joel@jms.id.au>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <lars.persson@axis.com>,
        <sbranden@broadcom.com>, <f.fainelli@gmail.com>,
        <andre.przywara@arm.com>, <baruch@tkos.co.il>,
        <xuwei5@hisilicon.com>, <verdun@hpe.com>, <nick.hawkins@hpe.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <vz@mleia.com>, <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <lkundrak@v3.sk>, <matthias.bgg@gmail.com>, <peda@axentia.se>,
        <yuenn@google.com>, <benjaminfair@google.com>,
        <j.neuschaefer@gmx.net>, <thierry.reding@gmail.com>,
        <andersson@kernel.org>, <geert+renesas@glider.be>,
        <heiko@sntech.de>, <daniel@thingy.jp>, <romain.perier@gmail.com>,
        <hayashi.kunihiko@socionext.com>, <mhiramat@kernel.org>,
        <vireshk@kernel.org>, <shiraz.linux.kernel@gmail.com>,
        <patrice.chotard@foss.st.com>, <marex@denx.de>,
        <qinjian@cqplus1.com>, <jszhang@kernel.org>, <tony@atomide.com>,
        <paul.barker@sancloud.com>, <brgl@bgdev.pl>, <nm@ti.com>,
        <ssantosh@kernel.org>, <eballetbo@gmail.com>,
        <javier@dowhile0.org>, <michal.simek@xilinx.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@axis.com>
Subject: Re: [PATCH 4/4] ARM: dts: Move .dts files to vendor sub-directories
Thread-Topic: [PATCH 4/4] ARM: dts: Move .dts files to vendor sub-directories
Thread-Index: AQHZf1DPFDS4drebjUOeEfhV+Wz8sg==
Date:   Fri, 5 May 2023 12:55:06 +0000
Message-ID: <057b72f7-b729-d618-4037-a43726b89d5c@microchip.com>
References: <20230504-arm-dts-mv-v1-0-2c8e51a2b6c4@kernel.org>
 <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
In-Reply-To: <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|SN7PR11MB8262:EE_
x-ms-office365-filtering-correlation-id: 64378271-0eb9-49a8-82a1-08db4d67f34a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sX06ndjqBRVrcsTZjGQgi3e/r9MgeiSnk2DhVv+T/9b29wstZj2UIqr8pGlZPpVD0bl0H3KCe5Crdp0WSt3sZVuGVZnjJL0YK27/XWhNPkvFUWsTmfM7dn0X0ZB2QwUlrV6pUmfBHqOsawhQUi3YH0Ogf0ViLsX7Py3hq4Uo14LewZwQ7UMj22F8vOnvPjRhgsMq66COjCYhFt83dQV0p22yda5IiOM4YGvk7r5z9EZHebT6E/yRHVtJoo+6M/5TgX6mIWg1QGcbXNc1qIKQrpZhHc3aKGa4NvoRddEvN1FHON6vzi6AZ5Yzk6OGWgSCEJTH6n7jdFzwCrfesx3F8CuUB6u13JNhG1icUgPaqNPNYShF3Fl8PRXA9KTgyf9gn35xELduZQ38bQgbs5af9wEl0wbfZHXAIY88/JYs/ySjVjSbTnt+jrTcMXLhOBL2ErxcFmFfw+X35TY8kZNdDsNc5VGlgaVH3/KumnFAT5gdkRtp1eSob+8+onEu6oq4Hjh+Uuq2L2shUvTAV0KFLcypAW5tJq0yJchveREjY1zKOFahLGN8lOEO2qmmr9DoPQZfBhoj1BUMCYoAl4qNsRq38ytpf3zA0JZX1qx3GaL8afaNT1Lb2hbEJ2orlybysTPYBO/N8C3d/nzesfn8DP8jKRX30ijVFFnTncM4wPRnDotijGwFxYTflUobekVl94Q5Z2sbwVdWIX2MhI+HdtnvJCcDg30IqlIBauckggE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(54906003)(110136005)(7406005)(7416002)(83380400001)(5660300002)(31686004)(7366002)(2616005)(6506007)(122000001)(921005)(38100700002)(6512007)(53546011)(26005)(8676002)(8936002)(186003)(2906002)(38070700005)(86362001)(6486002)(41300700001)(71200400001)(31696002)(316002)(66446008)(66476007)(66946007)(1191002)(4326008)(64756008)(76116006)(66556008)(91956017)(478600001)(36756003)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFBPN1VBNVFqazA2QzBITTRkUUFObEtkZlBsREc4YVZHMWFjdGVFS0g2b09K?=
 =?utf-8?B?ZTR4cmRJWkZhcmdrcEx0MitUc1FiVjJTTDJycStzVzBZVG5iM3FQTmE5UDd5?=
 =?utf-8?B?T0NlQWJXcGxsMnFSWTNJcXRwVTV1S0ZQZ2VnZVNpb01RcjNXNC9CeEJzWFUz?=
 =?utf-8?B?UXF4enI0VUFkeDVramJEbFg4bkxnQ2FnK1l3SjlRNS9CZGN3c2FaZEhHanVD?=
 =?utf-8?B?VlBoSktvc2tEeHBGRHVINkdGVVUvM0YrS04zcmhPdDA4aWxmMERPMFFmUGpy?=
 =?utf-8?B?NUcyT0pwOXlMamxPTWlhb1pXUDdxRnppZUo2cml6dFNsencwMDN4SWYwN1I5?=
 =?utf-8?B?aFJ5dkFvUlFRT1V6VnhFUGJ0U1pHK2tSZC9ramM5cDNadUdySmU4WEptTEhB?=
 =?utf-8?B?QVliRnVaMmN6SkdPZnRHblRkcXpTUkdtREcwZlEwN3d3bnMzU0Q2ejgxbVlp?=
 =?utf-8?B?ZmFaODNjNkhtL3NqaHFsd2xuMnR5alkzQWwvSHN1NDFJMFJLd1pzakxGNkFX?=
 =?utf-8?B?Z3NWRTJ3TzBHMHRLL1BJaklMTXRCNG1Gemk3SkprMVEzSzFRZS81NWUxTHNq?=
 =?utf-8?B?dHpxcm9hSFFuZVZ1Y295a0YzTCtlSVl0SjVqeVY4VHRJVHVnNE5PTEdMeUN4?=
 =?utf-8?B?LzFsUjZVTmZLZW82TTltSHBsMm9xN08rQjdQdEM0Ny9USERJZVpNeXBoT1JP?=
 =?utf-8?B?RUVOL1E4SDVwWUF1bU5lTWxHQWpyOGhyTXdPK29HY2EzaHJzVVQwR0s3amxF?=
 =?utf-8?B?VU5JQ3VBSmhWaC9zRjI0ZGNkM3gyVGcyYnNtTDVBUDJPRGhtTGprL3o1VVFN?=
 =?utf-8?B?S0FYaWJiVVhHOFpkUHNFOWhDMSs4WnBpTlhwWTNkZlhYWWNTUmdudndlUFQz?=
 =?utf-8?B?bTdrYS9iOW1nRzVjN3Z6UldlYURsamRYcmxyL0hFR0IrYm1QSzNiL2J5aHBr?=
 =?utf-8?B?OG1IUStqNmxkbzJ4a25WbHZ2Uml6N2czTkxjY3NNSG5yU2Jrd3EvQm9wVmRI?=
 =?utf-8?B?NUlubHFQRmsvNVhQNHBrNkI4YkFDMlJCY3EwTGlhWmpGSGs5OFJHdnNsRTcy?=
 =?utf-8?B?VGNXK1o0ejVjcFBwUDJ6MTg5ejlHTEpyVlVzMkZCM3hteXFEMk4vTUJwdkZa?=
 =?utf-8?B?a2VIUloxT05mSnEzUTVNWnM0bGFtU29kVEpMcklib29HQnErQ0RtaDdBSmtv?=
 =?utf-8?B?eWhqbXRDVlo5ZU1qcGY5UmxnRFhrWHJhV3pDY0MrNXp5aVBKNTFRYWZKdmNY?=
 =?utf-8?B?RTh5bGdua1prV1Y2VDFzVHlTVU0waXYvVTV4WnMzTk1JZnB4enZmbGhWWHBn?=
 =?utf-8?B?djV1OFJHOTlGWFZzL2tMSnNQVVZyb29hMzY2V3pMdGRxTmhYeVNpNDArWTNi?=
 =?utf-8?B?YjVTSUR4dXg1OGlQMUVBZWdRd3p2L3Nsdm5uTDJQYStlbDhISGdmeUhLY1Fo?=
 =?utf-8?B?cEE3U0tQdXFOaXEwR24ydmQrOVNsdDdRRzZlclEzQ0x1dlJPMlJJVUNBK3FJ?=
 =?utf-8?B?Z29WdWE5Q1I5K01iOHVzNU1aS0EvS1VzU1BreWVDRjZUZG5JRVR5eFRxTlRR?=
 =?utf-8?B?a2J5VHd4Rmo2SW4wdk5lNFhROHlFelZTRXRGenR4MlFCT1hPZVNORUppMUV1?=
 =?utf-8?B?VnN4MzlRYWI0RW5BTzhzWXovVFBha21PQ2hNUWdXTTNSZGpmdjBOam95UlFC?=
 =?utf-8?B?dGF5aitnT3JJWlpBbE9NdTJYL3VvT1dkNXBHa2tGN0NOazJlSTR1Q0krTjJC?=
 =?utf-8?B?MHhoUDVLbUZIR2ZBMFBHVkJEYUxMQklveWdEU1hJM3FEOTNJVDNJYS90OEJK?=
 =?utf-8?B?UXZsVVlJdzgxMC9iaU0yTWprN2hwNWUzY0RPbjk4cVFYOEYwdUc5d3hOa3Jm?=
 =?utf-8?B?L0lQSGZHenAremI2UWNvdlJXNkFZbURFbERVNzNjcGprVHhHVUt3VGxCYUU1?=
 =?utf-8?B?b3VwcUlSQjRPclBNczhGekZscjBjenRJN3cvVElVcUkwQk9WZEVoVmpVYVpT?=
 =?utf-8?B?bVJWaFJ2UEhIbWp2QUZqOSsrOXhoN1NkYTJiTHJFc3VLeXJtVkh0bFNPYUo0?=
 =?utf-8?B?WFhvYkpXTWhtU2U1WlhUbi9nTEhpUlZCVk1iVkFhSGk1Lzd1WG96YlJhRGc5?=
 =?utf-8?Q?WBWbpbfEocPbtPgdV1ofncBAf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A216CFCF84F1C84EAB0167AA23477C7C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64378271-0eb9-49a8-82a1-08db4d67f34a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 12:55:06.1452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VORj333QQugTC4OzSD9U73LX95p2KOVPcZj8USZs79iyoNUFpwMh6Wx+7Rcr4GLaEAVQyLQaLJ+yt96VSqmeqNDAfJdHH/YGIxF/qyx8W7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8262
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUuMDUuMjAyMyAwNjoyOSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+DQo+IFRoZSBhcm0gZHRz
IGRpcmVjdG9yeSBoYXMgZ3Jvd24gdG8gMTU1MyBib2FyZHMgd2hpY2ggbWFrZXMgaXQgYSBiaXQN
Cj4gdW53aWVsZHkgdG8gbWFpbnRhaW4gYW5kIHVzZS4gUGFzdCBhdHRlbXB0cyBzdGFsbGVkIG91
dCBkdWUgdG8gcGxhbnMgdG8NCj4gbW92ZSAuZHRzIGZpbGVzIG91dCBvZiB0aGUga2VybmVsIHRy
ZWUuIERvaW5nIHRoYXQgaXMgbm8gbG9uZ2VyIHBsYW5uZWQNCj4gKGFueSB0aW1lIHNvb24gYXQg
bGVhc3QpLCBzbyBsZXQncyBnbyBhaGVhZCBhbmQgZ3JvdXAgLmR0cyBmaWxlcyBieQ0KPiB2ZW5k
b3JzLiBUaGlzIG1vdmUgYWxpZ25zIGFybSB3aXRoIGFybTY0IC5kdHMgZmlsZSBzdHJ1Y3R1cmUu
DQo+DQo+IERvaW5nIHRoaXMgZW5hYmxlcyBidWlsZGluZyBzdWJzZXRzIG9mIGR0cyBmaWxlcyBi
eSB2ZW5kb3IgZWFzaWx5DQo+IHdpdGhvdXQgY2hhbmdpbmcga2VybmVsIGNvbmZpZ3M6DQo+DQo+
IG1ha2UgYWxseWVzY29uZmlnDQo+IG1ha2UgYXJjaC9hcm0vYm9vdC9kdHMvdGkvDQo+DQo+IFRo
ZXJlJ3Mgbm8gY2hhbmdlIHRvIGR0YnNfaW5zdGFsbCBhcyB0aGUgZmxhdCBzdHJ1Y3R1cmUgaXMg
bWFpbnRhaW5lZCBvbg0KPiBpbnN0YWxsLg0KPg0KPiBUaGUgbmFtaW5nIG9mIHZlbmRvciBkaXJl
Y3RvcmllcyBpcyByb3VnaGx5IGluIHRoaXMgb3JkZXIgb2YgcHJlZmVyZW5jZToNCj4gLSBNYXRj
aGluZyBvcmlnaW5hbCBhbmQgY3VycmVudCBTb0MgdmVuZG9yIHByZWZpeC9uYW1lIChlLmcuIHRp
LCBxY29tKQ0KPiAtIEN1cnJlbnQgdmVuZG9yIHByZWZpeC9uYW1lIGlmIHN0aWxsIGFjdGl2ZWx5
IHNvbGQgKFNvQ3Mgd2hpY2ggaGF2ZQ0KPiAgIGJlZW4gYXF1aXJlZCkgKGUuZy4gbnhwL2lteCkN
Cj4gLSBFeGlzdGluZyBwbGF0Zm9ybSBuYW1lIGZvciBvbGRlciBwbGF0Zm9ybXMgbm90IHNvbGQv
bWFpbnRhaW5lZCBieSBhbnkNCj4gICBjb21wYW55IChlLmcuIGdlbWluaSwgbnNwaXJlKQ0KPg0K
PiBUaGUgd2hvbGUgbW92ZSB3YXMgc2NyaXB0ZWQgd2l0aCB0aGUgZXhjZXB0aW9uIG9mIE1BSU5U
QUlORVJTLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3Jn
Pg0KPiAtLS0NCj4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDE4MSArLS0NCg0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvbWljcm9jaGlwL01ha2Vm
aWxlICAgICAgICAgICAgICAgfCAgIDgyICsNCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3sgPT4gbWlj
cm9jaGlwfS9ha3MtY2R1LmR0cyAgICAgIHwgICAgMA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMveyA9
PiBtaWNyb2NoaXB9L2FuaW1lb19pcC5kdHMgICAgfCAgICAwDQo+ICBhcmNoL2FybS9ib290L2R0
cy97ID0+IG1pY3JvY2hpcH0vYXQ5MS1hcmlhZzI1LmR0cyB8ICAgIDANCj4gIC4uLi9ib290L2R0
cy97ID0+IG1pY3JvY2hpcH0vYXQ5MS1hcmlldHRhZzI1LmR0cyAgIHwgICAgMA0KPiAgYXJjaC9h
cm0vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9L2F0OTEtY29zaW5vLmR0c2kgfCAgICAwDQo+ICAu
Li4vZHRzL3sgPT4gbWljcm9jaGlwfS9hdDkxLWNvc2lub19tZWdhMjU2MC5kdHMgICB8ICAgIDAN
Cj4gIC4uLi9ib290L2R0cy97ID0+IG1pY3JvY2hpcH0vYXQ5MS1kdmtfc29tNjAuZHRzICAgIHwg
ICAgMA0KPiAgLi4uL2R0cy97ID0+IG1pY3JvY2hpcH0vYXQ5MS1kdmtfc3U2MF9zb21jLmR0c2kg
ICAgfCAgICAwDQo+ICAuLi4veyA9PiBtaWNyb2NoaXB9L2F0OTEtZHZrX3N1NjBfc29tY19sY20u
ZHRzaSAgICB8ICAgIDANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS9hdDkx
LWZveGcyMC5kdHMgIHwgICAgMA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9
L2F0OTEtZ2F0d2ljay5kdHMgfCAgICAwDQo+ICBhcmNoL2FybS9ib290L2R0cy97ID0+IG1pY3Jv
Y2hpcH0vYXQ5MS1raXpib3guZHRzICB8ICAgIDANCj4gIC4uLi9ib290L2R0cy97ID0+IG1pY3Jv
Y2hpcH0vYXQ5MS1raXpib3gyLTIuZHRzICAgIHwgICAgMA0KPiAgLi4uL2R0cy97ID0+IG1pY3Jv
Y2hpcH0vYXQ5MS1raXpib3gyLWNvbW1vbi5kdHNpICAgfCAgICAwDQo+ICAuLi4vYm9vdC9kdHMv
eyA9PiBtaWNyb2NoaXB9L2F0OTEta2l6Ym94My1ocy5kdHMgICB8ICAgIDANCj4gIC4uLi9kdHMv
eyA9PiBtaWNyb2NoaXB9L2F0OTEta2l6Ym94M19jb21tb24uZHRzaSAgIHwgICAgMA0KPiAgLi4u
L2R0cy97ID0+IG1pY3JvY2hpcH0vYXQ5MS1raXpib3htaW5pLWJhc2UuZHRzICAgfCAgICAwDQo+
ICAuLi4veyA9PiBtaWNyb2NoaXB9L2F0OTEta2l6Ym94bWluaS1jb21tb24uZHRzaSAgICB8ICAg
IDANCj4gIC4uLi9kdHMveyA9PiBtaWNyb2NoaXB9L2F0OTEta2l6Ym94bWluaS1tYi5kdHMgICAg
IHwgICAgMA0KPiAgLi4uL2R0cy97ID0+IG1pY3JvY2hpcH0vYXQ5MS1raXpib3htaW5pLXJkLmR0
cyAgICAgfCAgICAwDQo+ICBhcmNoL2FybS9ib290L2R0cy97ID0+IG1pY3JvY2hpcH0vYXQ5MS1s
aW5lYS5kdHNpICB8ICAgIDANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS9h
dDkxLWxtdTUwMDAuZHRzIHwgICAgMA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMveyA9PiBtaWNyb2No
aXB9L2F0OTEtbmF0dGUuZHRzaSAgfCAgICAwDQo+ICAuLi4vZHRzL3sgPT4gbWljcm9jaGlwfS9h
dDkxLW5hdHRpcy0yLW5hdHRlLTIuZHRzICB8ICAgIDANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3sg
PT4gbWljcm9jaGlwfS9hdDkxLXE1eHI1LmR0cyAgIHwgICAgMA0KPiAgLi4uL2Jvb3QvZHRzL3sg
PT4gbWljcm9jaGlwfS9hdDkxLXFpbF9hOTI2MC5kdHMgICAgfCAgICAwDQo+ICAuLi4vYm9vdC9k
dHMveyA9PiBtaWNyb2NoaXB9L2F0OTEtc2FtOV9sOTI2MC5kdHMgICB8ICAgIDANCj4gIC4uLi9k
dHMveyA9PiBtaWNyb2NoaXB9L2F0OTEtc2FtOXg2MF9jdXJpb3NpdHkuZHRzIHwgICAgMA0KPiAg
Li4uL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS9hdDkxLXNhbTl4NjBlay5kdHMgICAgfCAgICAw
DQo+ICAuLi4vZHRzL3sgPT4gbWljcm9jaGlwfS9hdDkxLXNhbWE1ZDI3X3NvbTEuZHRzaSAgICB8
ICAgIDANCj4gIC4uLi9kdHMveyA9PiBtaWNyb2NoaXB9L2F0OTEtc2FtYTVkMjdfc29tMV9lay5k
dHMgIHwgICAgMA0KPiAgLi4uL2R0cy97ID0+IG1pY3JvY2hpcH0vYXQ5MS1zYW1hNWQyN193bHNv
bTEuZHRzaSAgfCAgICAwDQo+ICAuLi4veyA9PiBtaWNyb2NoaXB9L2F0OTEtc2FtYTVkMjdfd2xz
b20xX2VrLmR0cyAgICB8ICAgIDANCj4gIC4uLi9ib290L2R0cy97ID0+IG1pY3JvY2hpcH0vYXQ5
MS1zYW1hNWQyX2ljcC5kdHMgIHwgICAgMA0KPiAgLi4uL2R0cy97ID0+IG1pY3JvY2hpcH0vYXQ5
MS1zYW1hNWQyX3B0Y19lay5kdHMgICAgfCAgICAwDQo+ICAuLi4vZHRzL3sgPT4gbWljcm9jaGlw
fS9hdDkxLXNhbWE1ZDJfeHBsYWluZWQuZHRzICB8ICAgIDANCj4gIC4uLi9ib290L2R0cy97ID0+
IG1pY3JvY2hpcH0vYXQ5MS1zYW1hNWQzX2Vkcy5kdHMgIHwgICAgMA0KPiAgLi4uL3sgPT4gbWlj
cm9jaGlwfS9hdDkxLXNhbWE1ZDNfa3N6OTQ3N19ldmIuZHRzICAgfCAgICAwDQo+ICAuLi4vZHRz
L3sgPT4gbWljcm9jaGlwfS9hdDkxLXNhbWE1ZDNfeHBsYWluZWQuZHRzICB8ICAgIDANCj4gIC4u
Li9kdHMveyA9PiBtaWNyb2NoaXB9L2F0OTEtc2FtYTVkNF9tYTVkNC5kdHNpICAgIHwgICAgMA0K
PiAgLi4uL2R0cy97ID0+IG1pY3JvY2hpcH0vYXQ5MS1zYW1hNWQ0X21hNWQ0ZXZrLmR0cyAgfCAg
ICAwDQo+ICAuLi4vZHRzL3sgPT4gbWljcm9jaGlwfS9hdDkxLXNhbWE1ZDRfeHBsYWluZWQuZHRz
ICB8ICAgIDANCj4gIC4uLi9ib290L2R0cy97ID0+IG1pY3JvY2hpcH0vYXQ5MS1zYW1hNWQ0ZWsu
ZHRzICAgIHwgICAgMA0KPiAgLi4uL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS9hdDkxLXNhbWE3
ZzVlay5kdHMgICAgfCAgICAwDQo+ICAuLi4vYXJtL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS9h
dDkxLXNtYXJ0a2l6LmR0cyB8ICAgIDANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3sgPT4gbWljcm9j
aGlwfS9hdDkxLXNvbTYwLmR0c2kgIHwgICAgMA0KPiAgLi4uL2FybS9ib290L2R0cy97ID0+IG1p
Y3JvY2hpcH0vYXQ5MS10c2U4NTAtMy5kdHMgfCAgICAwDQo+ICBhcmNoL2FybS9ib290L2R0cy97
ID0+IG1pY3JvY2hpcH0vYXQ5MS12aW5jby5kdHMgICB8ICAgIDANCj4gIGFyY2gvYXJtL2Jvb3Qv
ZHRzL3sgPT4gbWljcm9jaGlwfS9hdDkxLXdiNDVuLmR0cyAgIHwgICAgMA0KPiAgYXJjaC9hcm0v
Ym9vdC9kdHMveyA9PiBtaWNyb2NoaXB9L2F0OTEtd2I0NW4uZHRzaSAgfCAgICAwDQo+ICBhcmNo
L2FybS9ib290L2R0cy97ID0+IG1pY3JvY2hpcH0vYXQ5MS13YjUwbi5kdHMgICB8ICAgIDANCj4g
IGFyY2gvYXJtL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS9hdDkxLXdiNTBuLmR0c2kgIHwgICAg
MA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9L2F0OTFybTkyMDAuZHRzaSAg
fCAgICAwDQo+ICAuLi4vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9L2F0OTFybTkyMDBfcHFmcC5k
dHNpICB8ICAgIDANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS9hdDkxcm05
MjAwZWsuZHRzIHwgICAgMA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9L2F0
OTFzYW05MjYwLmR0c2kgfCAgICAwDQo+ICAuLi4vYXJtL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlw
fS9hdDkxc2FtOTI2MGVrLmR0cyB8ICAgIDANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3sgPT4gbWlj
cm9jaGlwfS9hdDkxc2FtOTI2MS5kdHNpIHwgICAgMA0KPiAgLi4uL2FybS9ib290L2R0cy97ID0+
IG1pY3JvY2hpcH0vYXQ5MXNhbTkyNjFlay5kdHMgfCAgICAwDQo+ICBhcmNoL2FybS9ib290L2R0
cy97ID0+IG1pY3JvY2hpcH0vYXQ5MXNhbTkyNjMuZHRzaSB8ICAgIDANCj4gIC4uLi9hcm0vYm9v
dC9kdHMveyA9PiBtaWNyb2NoaXB9L2F0OTFzYW05MjYzZWsuZHRzIHwgICAgMA0KPiAgYXJjaC9h
cm0vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9L2F0OTFzYW05ZzE1LmR0c2kgfCAgICAwDQo+ICAu
Li4vYXJtL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS9hdDkxc2FtOWcxNWVrLmR0cyB8ICAgIDAN
Cj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS9hdDkxc2FtOWcyMC5kdHNpIHwg
ICAgMA0KPiAgLi4uL2FybS9ib290L2R0cy97ID0+IG1pY3JvY2hpcH0vYXQ5MXNhbTlnMjBlay5k
dHMgfCAgICAwDQo+ICAuLi4vZHRzL3sgPT4gbWljcm9jaGlwfS9hdDkxc2FtOWcyMGVrXzJtbWMu
ZHRzICAgICB8ICAgIDANCj4gIC4uLi9kdHMveyA9PiBtaWNyb2NoaXB9L2F0OTFzYW05ZzIwZWtf
Y29tbW9uLmR0c2kgIHwgICAgMA0KPiAgLi4uL2F0OTFzYW05ZzI1LWdhcmRlbmEtc21hcnQtZ2F0
ZXdheS5kdHMgICAgICAgICAgfCAgICAwDQo+ICBhcmNoL2FybS9ib290L2R0cy97ID0+IG1pY3Jv
Y2hpcH0vYXQ5MXNhbTlnMjUuZHRzaSB8ICAgIDANCj4gIC4uLi9hcm0vYm9vdC9kdHMveyA9PiBt
aWNyb2NoaXB9L2F0OTFzYW05ZzI1ZWsuZHRzIHwgICAgMA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMv
eyA9PiBtaWNyb2NoaXB9L2F0OTFzYW05ZzM1LmR0c2kgfCAgICAwDQo+ICAuLi4vYXJtL2Jvb3Qv
ZHRzL3sgPT4gbWljcm9jaGlwfS9hdDkxc2FtOWczNWVrLmR0cyB8ICAgIDANCj4gIGFyY2gvYXJt
L2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS9hdDkxc2FtOWc0NS5kdHNpIHwgICAgMA0KPiAgLi4u
L2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS9hdDkxc2FtOW0xMGc0NWVrLmR0cyAgfCAgICAwDQo+
ICBhcmNoL2FybS9ib290L2R0cy97ID0+IG1pY3JvY2hpcH0vYXQ5MXNhbTluMTIuZHRzaSB8ICAg
IDANCj4gIC4uLi9hcm0vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9L2F0OTFzYW05bjEyZWsuZHRz
IHwgICAgMA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9L2F0OTFzYW05cmwu
ZHRzaSAgfCAgICAwDQo+ICBhcmNoL2FybS9ib290L2R0cy97ID0+IG1pY3JvY2hpcH0vYXQ5MXNh
bTlybGVrLmR0cyB8ICAgIDANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS9h
dDkxc2FtOXgyNS5kdHNpIHwgICAgMA0KPiAgLi4uL2FybS9ib290L2R0cy97ID0+IG1pY3JvY2hp
cH0vYXQ5MXNhbTl4MjVlay5kdHMgfCAgICAwDQo+ICBhcmNoL2FybS9ib290L2R0cy97ID0+IG1p
Y3JvY2hpcH0vYXQ5MXNhbTl4MzUuZHRzaSB8ICAgIDANCj4gIC4uLi9hcm0vYm9vdC9kdHMveyA9
PiBtaWNyb2NoaXB9L2F0OTFzYW05eDM1ZWsuZHRzIHwgICAgMA0KPiAgYXJjaC9hcm0vYm9vdC9k
dHMveyA9PiBtaWNyb2NoaXB9L2F0OTFzYW05eDUuZHRzaSAgfCAgICAwDQo+ICAuLi4vYm9vdC9k
dHMveyA9PiBtaWNyb2NoaXB9L2F0OTFzYW05eDVfY2FuLmR0c2kgICB8ICAgIDANCj4gIC4uLi9i
b290L2R0cy97ID0+IG1pY3JvY2hpcH0vYXQ5MXNhbTl4NV9pc2kuZHRzaSAgIHwgICAgMA0KPiAg
Li4uL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS9hdDkxc2FtOXg1X2xjZC5kdHNpICAgfCAgICAw
DQo+ICAuLi4vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9L2F0OTFzYW05eDVfbWFjYjAuZHRzaSB8
ICAgIDANCj4gIC4uLi9ib290L2R0cy97ID0+IG1pY3JvY2hpcH0vYXQ5MXNhbTl4NV9tYWNiMS5k
dHNpIHwgICAgMA0KPiAgLi4uL2R0cy97ID0+IG1pY3JvY2hpcH0vYXQ5MXNhbTl4NV91c2FydDMu
ZHRzaSAgICAgfCAgICAwDQo+ICAuLi4vYXJtL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS9hdDkx
c2FtOXg1Y20uZHRzaSB8ICAgIDANCj4gIC4uLi9hcm0vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9
L2F0OTFzYW05eDVkbS5kdHNpIHwgICAgMA0KPiAgLi4uL2FybS9ib290L2R0cy97ID0+IG1pY3Jv
Y2hpcH0vYXQ5MXNhbTl4NWVrLmR0c2kgfCAgICAwDQo+ICBhcmNoL2FybS9ib290L2R0cy97ID0+
IG1pY3JvY2hpcH0vYXQ5MXNhbTl4ZS5kdHNpICB8ICAgIDANCj4gIGFyY2gvYXJtL2Jvb3QvZHRz
L3sgPT4gbWljcm9jaGlwfS9ldGhlcm51dDUuZHRzICAgIHwgICAgMA0KPiAgYXJjaC9hcm0vYm9v
dC9kdHMveyA9PiBtaWNyb2NoaXB9L2V2ay1wcm8zLmR0cyAgICAgfCAgICAwDQo+ICBhcmNoL2Fy
bS9ib290L2R0cy97ID0+IG1pY3JvY2hpcH0vZ2U4NjMtcHJvMy5kdHNpICB8ICAgIDANCj4gIC4u
Li9sYW45NjZ4LWtvbnRyb24ta3N3aXRjaC1kMTAtbW10LTZnLTJncy5kdHMgICAgIHwgICAgMA0K
PiAgLi4uL2xhbjk2Nngta29udHJvbi1rc3dpdGNoLWQxMC1tbXQtOGcuZHRzICAgICAgICAgfCAg
ICAwDQo+ICAuLi4vbGFuOTY2eC1rb250cm9uLWtzd2l0Y2gtZDEwLW1tdC5kdHNpICAgICAgICAg
ICB8ICAgIDANCj4gIC4uLi9ib290L2R0cy97ID0+IG1pY3JvY2hpcH0vbGFuOTY2eC1wY2I4Mjkw
LmR0cyAgIHwgICAgMA0KPiAgLi4uL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS9sYW45NjZ4LXBj
YjgyOTEuZHRzICAgfCAgICAwDQo+ICAuLi4vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9L2xhbjk2
NngtcGNiODMwOS5kdHMgICB8ICAgIDANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3sgPT4gbWljcm9j
aGlwfS9sYW45NjZ4LmR0c2kgICAgIHwgICAgMA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMveyA9PiBt
aWNyb2NoaXB9L21wYTE2MDAuZHRzICAgICAgfCAgICAwDQo+ICBhcmNoL2FybS9ib290L2R0cy97
ID0+IG1pY3JvY2hpcH0vcG05ZzQ1LmR0cyAgICAgICB8ICAgIDANCj4gIGFyY2gvYXJtL2Jvb3Qv
ZHRzL3sgPT4gbWljcm9jaGlwfS9zYW05eDYwLmR0c2kgICAgIHwgICAgMA0KPiAgLi4uL2FybS9i
b290L2R0cy97ID0+IG1pY3JvY2hpcH0vc2FtYTVkMi1waW5mdW5jLmggfCAgICAwDQo+ICBhcmNo
L2FybS9ib290L2R0cy97ID0+IG1pY3JvY2hpcH0vc2FtYTVkMi5kdHNpICAgICB8ICAgIDANCj4g
IGFyY2gvYXJtL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS9zYW1hNWQyOS5kdHNpICAgIHwgICAg
MA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9L3NhbWE1ZDMuZHRzaSAgICAg
fCAgICAwDQo+ICBhcmNoL2FybS9ib290L2R0cy97ID0+IG1pY3JvY2hpcH0vc2FtYTVkMzEuZHRz
aSAgICB8ICAgIDANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS9zYW1hNWQz
MWVrLmR0cyAgIHwgICAgMA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9L3Nh
bWE1ZDMzLmR0c2kgICAgfCAgICAwDQo+ICBhcmNoL2FybS9ib290L2R0cy97ID0+IG1pY3JvY2hp
cH0vc2FtYTVkMzNlay5kdHMgICB8ICAgIDANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3sgPT4gbWlj
cm9jaGlwfS9zYW1hNWQzNC5kdHNpICAgIHwgICAgMA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMveyA9
PiBtaWNyb2NoaXB9L3NhbWE1ZDM0ZWsuZHRzICAgfCAgICAwDQo+ICBhcmNoL2FybS9ib290L2R0
cy97ID0+IG1pY3JvY2hpcH0vc2FtYTVkMzUuZHRzaSAgICB8ICAgIDANCj4gIGFyY2gvYXJtL2Jv
b3QvZHRzL3sgPT4gbWljcm9jaGlwfS9zYW1hNWQzNWVrLmR0cyAgIHwgICAgMA0KPiAgYXJjaC9h
cm0vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9L3NhbWE1ZDM2LmR0c2kgICAgfCAgICAwDQo+ICBh
cmNoL2FybS9ib290L2R0cy97ID0+IG1pY3JvY2hpcH0vc2FtYTVkMzZlay5kdHMgICB8ICAgIDAN
Cj4gIC4uLi9ib290L2R0cy97ID0+IG1pY3JvY2hpcH0vc2FtYTVkMzZla19jbXAuZHRzICAgIHwg
ICAgMA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9L3NhbWE1ZDNfY2FuLmR0
c2kgfCAgICAwDQo+ICAuLi4vYXJtL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS9zYW1hNWQzX2Vt
YWMuZHRzaSB8ICAgIDANCj4gIC4uLi9hcm0vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9L3NhbWE1
ZDNfZ21hYy5kdHNpIHwgICAgMA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9
L3NhbWE1ZDNfbGNkLmR0c2kgfCAgICAwDQo+ICAuLi4vYXJtL2Jvb3QvZHRzL3sgPT4gbWljcm9j
aGlwfS9zYW1hNWQzX21jaTIuZHRzaSB8ICAgIDANCj4gIC4uLi9hcm0vYm9vdC9kdHMveyA9PiBt
aWNyb2NoaXB9L3NhbWE1ZDNfdGNiMS5kdHNpIHwgICAgMA0KPiAgLi4uL2FybS9ib290L2R0cy97
ID0+IG1pY3JvY2hpcH0vc2FtYTVkM191YXJ0LmR0c2kgfCAgICAwDQo+ICBhcmNoL2FybS9ib290
L2R0cy97ID0+IG1pY3JvY2hpcH0vc2FtYTVkM3hjbS5kdHNpICB8ICAgIDANCj4gIC4uLi9ib290
L2R0cy97ID0+IG1pY3JvY2hpcH0vc2FtYTVkM3hjbV9jbXAuZHRzaSAgIHwgICAgMA0KPiAgYXJj
aC9hcm0vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9L3NhbWE1ZDN4ZG0uZHRzaSAgfCAgICAwDQo+
ICBhcmNoL2FybS9ib290L2R0cy97ID0+IG1pY3JvY2hpcH0vc2FtYTVkM3htYi5kdHNpICB8ICAg
IDANCj4gIC4uLi9ib290L2R0cy97ID0+IG1pY3JvY2hpcH0vc2FtYTVkM3htYl9jbXAuZHRzaSAg
IHwgICAgMA0KPiAgLi4uL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS9zYW1hNWQzeG1iX2VtYWMu
ZHRzaSAgfCAgICAwDQo+ICAuLi4vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9L3NhbWE1ZDN4bWJf
Z21hYy5kdHNpICB8ICAgIDANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS9z
YW1hNWQ0LmR0c2kgICAgIHwgICAgMA0KPiAgLi4uL2FybS9ib290L2R0cy97ID0+IG1pY3JvY2hp
cH0vc2FtYTdnNS1waW5mdW5jLmggfCAgICAwDQo+ICBhcmNoL2FybS9ib290L2R0cy97ID0+IG1p
Y3JvY2hpcH0vc2FtYTdnNS5kdHNpICAgICB8ICAgIDANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3sg
PT4gbWljcm9jaGlwfS90bnlfYTkyNjAuZHRzICAgIHwgICAgMA0KPiAgLi4uL2Jvb3QvZHRzL3sg
PT4gbWljcm9jaGlwfS90bnlfYTkyNjBfY29tbW9uLmR0c2kgfCAgICAwDQo+ICBhcmNoL2FybS9i
b290L2R0cy97ID0+IG1pY3JvY2hpcH0vdG55X2E5MjYzLmR0cyAgICB8ICAgIDANCj4gIGFyY2gv
YXJtL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS90bnlfYTlnMjAuZHRzICAgIHwgICAgMA0KPiAg
YXJjaC9hcm0vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9L3VzYl9hOTI2MC5kdHMgICAgfCAgICAw
DQo+ICAuLi4vYm9vdC9kdHMveyA9PiBtaWNyb2NoaXB9L3VzYl9hOTI2MF9jb21tb24uZHRzaSB8
ICAgIDANCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3sgPT4gbWljcm9jaGlwfS91c2JfYTkyNjMuZHRz
ICAgIHwgICAgMA0KPiAgLi4uL2R0cy97ID0+IG1pY3JvY2hpcH0vdXNiX2E5ZzIwLWRhYi1tbXgu
ZHRzaSAgICAgfCAgICAwDQo+ICBhcmNoL2FybS9ib290L2R0cy97ID0+IG1pY3JvY2hpcH0vdXNi
X2E5ZzIwLmR0cyAgICB8ICAgIDANCj4gIC4uLi9ib290L2R0cy97ID0+IG1pY3JvY2hpcH0vdXNi
X2E5ZzIwX2NvbW1vbi5kdHNpIHwgICAgMA0KPiAgLi4uL2FybS9ib290L2R0cy97ID0+IG1pY3Jv
Y2hpcH0vdXNiX2E5ZzIwX2xwdy5kdHMgfCAgICAwDQoNClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJl
em5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCg0KDQo=
