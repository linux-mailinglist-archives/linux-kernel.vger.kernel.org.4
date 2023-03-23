Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0142E6C6FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjCWRwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCWRwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:52:06 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982283251C;
        Thu, 23 Mar 2023 10:52:00 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NF49ns031470;
        Thu, 23 Mar 2023 13:51:04 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3pfx3ss792-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 13:51:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdnrQM9iqQVpKNfLFhpyZhcdnfzj3VzphD0wgDvz6Q2dWgUxdJ24CJUzu6GQuVULA34a+DJfJ8AWG0PX2D2vHUFeHDX/lv3m/Iw8DBMtEfWWKgw19mgxJB9blyGnWe5adWVgECcBQnEDPf/3wWRR9x/uO2z9J94DZtHuOAIXRZ/7OWUL6Chsq1v82fgmuLI8mhhJlHXleQ+/dpiooW5avjyIpgQXQVhgsH1A9X/XyMGhnW26+MOKiaPxD3zAKx1nzIxOgbIz1ERt6V5S4wz3LDI8Q7rVo7HvCUjhQkUyVShWmHeQWYvxkXmLPVR8Dxsfggo68l0KdZ7vPzfrN4b5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dSw3LEQOYAbj3Xtg1g6bMXrfT41wysKKLimxMmLx7g=;
 b=no3XzrtF1StGQb5IPBfo5iBhwdGPidhQp1+SccuGjITIX0TVsNno74GpI/f1vBgI8zXarc9yXWm2+Ocu4RDKRPQBmcVrOyFDYNiClXsuWI8nB7bBn1onc1ZQfa6ep+MVEpFSTzb3qQRds97ty/atQ7QVjGquoIquJcPnDyj8dRxyryuY9b15kN0zVpaV7bm2PKbqlh31QwLllhSkbrOhBr83yLdwzxVuxAVyjp19IWVVEYD9zKtDXYwTy2FZi0sNe+19MX9dXF6Q8wKU74E8uOl9JzApvgF0XfcY7RMNZGGPDt9x7se2eLBEKUdbrkwn3zb5ZdYS6FbO+UTNH+x8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dSw3LEQOYAbj3Xtg1g6bMXrfT41wysKKLimxMmLx7g=;
 b=2pufru8QhgB2wBq2j15t6DxZLvUh7y9dArd3SAlvTvQTDiJh+Z/gdULWRGb3dy8qtS9dpq3joKES8zt8A+VojA+wu67rsbCLuVdkovrfnZSvJPuf108B29A2sF5U3+atX7YgIeFVfeM/m8ibvVbSsNgN7KOchKTvDVP3PRSHzWQ=
Received: from SJ0PR03MB6681.namprd03.prod.outlook.com (2603:10b6:a03:400::6)
 by CH2PR03MB5287.namprd03.prod.outlook.com (2603:10b6:610:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 17:51:01 +0000
Received: from SJ0PR03MB6681.namprd03.prod.outlook.com
 ([fe80::546:72be:4164:dde7]) by SJ0PR03MB6681.namprd03.prod.outlook.com
 ([fe80::546:72be:4164:dde7%7]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 17:51:01 +0000
From:   "Lee, RyanS" <RyanS.Lee@analog.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?utf-8?B?4oCcUnlhbg==?= <ryan.lee.analog@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "herve.codina@bootlin.com" <herve.codina@bootlin.com>,
        "wangweidong.a@awinic.com" <wangweidong.a@awinic.com>,
        "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
        "ajye_huang@compal.corp-partner.google.com" 
        <ajye_huang@compal.corp-partner.google.com>,
        "shumingf@realtek.com" <shumingf@realtek.com>,
        "povik+lin@cutebit.org" <povik+lin@cutebit.org>,
        "flatmax@flatmax.com" <flatmax@flatmax.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V2 1/2] ASoC: max98363: add soundwire amplifier driver
Thread-Topic: [PATCH V2 1/2] ASoC: max98363: add soundwire amplifier driver
Thread-Index: AQHZU7bTh6oTfV36r0G0vxHx+yvH0q74zcWAgA5ku3A=
Date:   Thu, 23 Mar 2023 17:51:01 +0000
Message-ID: <SJ0PR03MB66812CB6A3AB99B87EE870438A879@SJ0PR03MB6681.namprd03.prod.outlook.com>
References: <20230311011409.210014-1-ryan.lee.analog@gmail.com>
 <6fbd4471-9f72-c87c-3803-90f7224abce0@linux.intel.com>
In-Reply-To: <6fbd4471-9f72-c87c-3803-90f7224abce0@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jY214bFpURXpYR0Z3Y0dSaGRHRmNjbTloYldsdVoxd3dPV1E0TkRsaU5p?=
 =?utf-8?B?MHpNbVF6TFRSaE5EQXRPRFZsWlMwMllqZzBZbUV5T1dVek5XSmNiWE5uYzF4?=
 =?utf-8?B?dGMyY3RORFEyTURVM09XTXRZemxoTXkweE1XVmtMV0poWWpRdE56QXhZV0k0?=
 =?utf-8?B?TURkbFpHSTVYR0Z0WlMxMFpYTjBYRFEwTmpBMU56bGtMV001WVRNdE1URmxa?=
 =?utf-8?B?QzFpWVdJMExUY3dNV0ZpT0RBM1pXUmlPV0p2WkhrdWRIaDBJaUJ6ZWowaU1U?=
 =?utf-8?B?ZzJOaUlnZEQwaU1UTXpNalF3TmpjME5UazJNVFUzTlRZd0lpQm9QU0pZYjFK?=
 =?utf-8?B?alVuZzRWbWRNYnpWdFJrWnRkMEpoZWxkcGJucHhhR005SWlCcFpEMGlJaUJp?=
 =?utf-8?B?YkQwaU1DSWdZbTg5SWpFaUlHTnBQU0pqUVVGQlFVVlNTRlV4VWxOU1ZVWk9R?=
 =?utf-8?B?MmRWUVVGRmIwTkJRVUkwSzA4NFIzTkdNMXBCVWtkeVNsaEVWa3hMT0d0RllY?=
 =?utf-8?B?TnNZMDVWYzNKNVVVUkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlNFRkJRVUZFWVVGUlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UlVGQlVVRkNRVUZCUVZGa2FXczFVVUZCUVVGQlFVRkJRVUZCUVVGQlFVbzBR?=
 =?utf-8?B?VUZCUW1oQlIxRkJZVkZDWmtGSVRVRmFVVUpxUVVoVlFXTm5RbXhCUmpoQlkw?=
 =?utf-8?B?RkNlVUZIT0VGaFowSnNRVWROUVdSQlFucEJSamhCV21kQ2FFRkhkMEZqZDBK?=
 =?utf-8?B?c1FVWTRRVnBuUW5aQlNFMUJZVkZDTUVGSGEwRmtaMEpzUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZGUVVGQlFVRkJRVUZCUVdk?=
 =?utf-8?B?QlFVRkJRVUZ1WjBGQlFVZEZRVnBCUW5CQlJqaEJZM2RDYkVGSFRVRmtVVUo1?=
 =?utf-8?B?UVVkVlFWaDNRbmRCU0VsQlluZENjVUZIVlVGWmQwSXdRVWhOUVZoM1FqQkJS?=
 =?utf-8?B?MnRCV2xGQ2VVRkVSVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlVVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVTkJRVUZCUVVGRFpVRkJRVUZaVVVKclFVZHJRVmgzUW5wQlIx?=
 =?utf-8?B?VkJXWGRDTVVGSVNVRmFVVUptUVVoQlFXTm5RblpCUjI5QldsRkNha0ZJVVVG?=
 =?utf-8?B?amQwSm1RVWhSUVdGUlFteEJTRWxCVFdkQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRa0ZCUVVGQlFVRkJRVUZKUVVGQlFVRkJRVDA5SWk4K1BDOXRaWFJo?=
 =?utf-8?B?UGc9PQ==?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6681:EE_|CH2PR03MB5287:EE_
x-ms-office365-filtering-correlation-id: 1774d93e-63b8-4eb2-b387-08db2bc72a8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V8c3rv7W0vjJ1QM63C4Y7pK1ZOzQaBdoRx41Yz5kknBz4uvyTPXARleVcv+/yKrghjKwvhUTeDQQrIpQ7hJgYfyRBykQfkrVqjm5aZ8wcnZvQ+AaqoXXqY2EtK41bUoCQsSuwxqyuRp4zg0CcYan9FZQWqA7W1+jfceUdSyCqSsQMnX8WyfCeQuc49fNcAlCM7ANEZkZN7ye5KGebg+kMam+IJNV4Q24+lOM7GrkzYxLE2WG8kWl7b5Ca0tubfN5Eh52jP8LC/+r5nwrMMgmEIMwEBWQ+pbBb6JGawjdvErg7uKdzvyiQ8MGS3dYHOrjHutUNfJWiqd56eTVFwUaiWnl3rvKFYb88ALL6WuY6YdQ1LmqVuy7ZQRWDBKywM+t2hzvSO5aqTpqaEC71wOJPAOwV6IPQv8Vdj3qBAbt9QMLJ3D5Vl//I3FZbGtGSyzqeEibjrPn3XRvbHKX7+Ld/P390M4Vr1Go8ohqwD4MNwG0Qmx8yjJgPgXCpZepqrk2aIKgvaNtCHpGEJ2h1Q6oPeF4cFodGIFwGF1FXKLoeecPPxHKglHM4NGDoxZ//jevkahCO68/MSBNkcAGfugQ50y0zOS97lNnpTBsHLKYVah0Pg/kTkI6dXGa1yVqEznbuiJoNhRmsRgSrdCG7F3bya1TP2G1UWSmi4G+L738L1TO6Bz1anmOWpvdoYmHPzB1qXC6G6tTLGeFaLmpJjVK0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6681.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199018)(71200400001)(66446008)(8676002)(66476007)(64756008)(52536014)(66946007)(76116006)(66556008)(110136005)(5660300002)(41300700001)(7416002)(122000001)(53546011)(8936002)(26005)(6506007)(186003)(9686003)(478600001)(83380400001)(33656002)(316002)(7696005)(86362001)(55016003)(921005)(38070700005)(38100700002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGdJZ1ptMEkvaU9GS0JiUUhLOFVpemUrc0NRdTBzN0RjNS9FejVmOVArQnE4?=
 =?utf-8?B?VnlRRSthYWk5Y0ZSeThjRHBXd21zMVVsdlNLOE5ML00zMjNCQXg0Um0vWG5t?=
 =?utf-8?B?TDc3V3NxeVdWR0ZxeEZvdVVPMmU4YU9BUXRFU0c2MEpKaUt2amVobVYySlVz?=
 =?utf-8?B?b0tMRUVreWs4OWJBNlp1aVZ2Ry8yMllRYjM5S09QSSt4c2twbE9QVStLUFFD?=
 =?utf-8?B?ZVBPbCtNNmhXWmVRbUg2VWtraFV5RWF4Vk9XRjlYamkvalNKSndod2xJTmlw?=
 =?utf-8?B?S2J2N3M5bUNJOWtFZGdZbFpIQVdFZ05FaytxSFQ4ZHQyejVNMFRBM1A0bGM1?=
 =?utf-8?B?OW9WcEUyTWdoYU1IU2JmRFI0UGFEVFRvcFRWV3ZvdlA2ZkNmNnRJcXgvcWFJ?=
 =?utf-8?B?TkhQeVR5dVcrbnR3cW5jSndnMkRrc1g1OWtBR0UzYmFoc1FMaGFPMGwrQ2dG?=
 =?utf-8?B?eXZLU2RLOCtKNTYzeW9UMnBSbzVKNzA0bW5Dc1NqZjBVVklGUmljQzN1ajFl?=
 =?utf-8?B?b3BGM2w5UEN3alRmVVVSb0lvbndqdG1hSmRRbXY2Q3pvNSsybDNCT3lqRXBT?=
 =?utf-8?B?alo0UjhDcWNpRkpmTnB0YndzNmtqMW1Lc2xXU1Vpa3crZU54d3k0dWhrRG80?=
 =?utf-8?B?UmdtWGJiTnd5L3hvK0R6U1kzQzJEMStTY01DdFA1VXBlNFVGRHhvUmNYOERT?=
 =?utf-8?B?cHRaUW45WUVHREFwdk4zcXloRUp4Yzc2K2tWcWRaSUt4RUFyY3VwRzh2QWZF?=
 =?utf-8?B?czFoOE5xRmpsVzZtTEhzU1J0OU11VXpGSlBBNnRLaWJ3MG1reFhlTEpQYkNG?=
 =?utf-8?B?NTg1TTVtYWJRNTF3TzlrWFdYSDNEWFA4Nno3MnVXMW5sQVFtREl0NFQyNXhP?=
 =?utf-8?B?L2JtYlp3Z1l1WjVsTG9qb05RRmlVdi9qOFArc2JIeGlucnJ2S1ZVZUNrclU4?=
 =?utf-8?B?VldhS3YwdGMwTE4yemlUaEUyMnVCS2xwRTkzYVpvVVFzcXNQd2xWSWZUcTRa?=
 =?utf-8?B?R2NlMnh0aFg0cThzRUhYQnVyWWFtdFkrdDE4Q3haNUxtU0lUeE1kRTJseSts?=
 =?utf-8?B?QzZnbGtSMXpzTjVNeWlHdTdIb3FGYzhpUmdIa1hxaFAxZzNEejBTMG1Va252?=
 =?utf-8?B?MmJERC9VUmo1a0VDSGJLOERZV0dxQVdkbWg1OUo1eEsxaGlDK2xuNll3Tzd1?=
 =?utf-8?B?dVpKMStsOXBRbXQrSFRwZUdEODdGYWNuZ3NyNGhsREFacXlUSGtuN0E3WTl6?=
 =?utf-8?B?NWllcE5peWtoeXB1azZ5YTNLMnIrdXJTZTU4UHpuckhmVDdRanphbjZuT3Vz?=
 =?utf-8?B?ZExWMFB0WStoUGJwdTZaRFpZeXBkKzR6MlpLNzl1YU1NWUQ4eS9UbjFURkZC?=
 =?utf-8?B?dHNCMlZuN24ybytuRkY5OVhxTjBJME1halp4Y2hmRzVpc280VTNrdGlZRmU3?=
 =?utf-8?B?Y21Wanc5TnFWWG1pY0FEWHRCSFpsUUgxa0V6Q1czODFqQ0U5RkttZGJoSDlU?=
 =?utf-8?B?ME5aYXcwS05GU1RWTGNTUTk5M1V1b0d4NVA5aFdkUzc2WWx5TndCalFtRFJL?=
 =?utf-8?B?WjlvVXBPTGNFM1hCbGVFN3VuTmRJWkh6emcrN1lVSnhsbFliTG5wUFBLZVV0?=
 =?utf-8?B?ZmU0OWg3REY1bkdRQ1I0d0M4VHNLRG5FKzVzcE4wM0trRlpsYmpPWHNkNjZO?=
 =?utf-8?B?Q2RXVzBEcnZna1J1cVRJUnNuQXhHeFRjU3BTNE5CUlBXaUM0YmRHRm5oRkx1?=
 =?utf-8?B?dEFjWmJldEtMNktVcHNSdFZ4RHJhRTlSTlVCNUFvdTRmNnFvOEoyeVhKdWpD?=
 =?utf-8?B?SktiSXNWV08vY0l3ZERqSHRWemdUeCsxVHpRZGRBNkJPeXZ3QVhORnRXNmZq?=
 =?utf-8?B?NXo4WCt0eXJnVjFkUWhiSzBRMHlPWTl4WTROc0dycjUyeUtHbFJicFNDcEVE?=
 =?utf-8?B?TzZjUVNCMU5oT2tKKytHc2tscGx3T0pkQ3VPdnRqWmkweTl1ajdNdWl1MTdD?=
 =?utf-8?B?ZHkvQ1hzVXliSk5kcXpTSkZYR2t2YVF3MWlFQk9vaytHMFM0RDZ0SnlXKzd1?=
 =?utf-8?B?dWNleTNNRzFzRkl1U3ozUjd4bEUrdXBlbkdBYnRnclhtcXNGVVIyZkpPTnVU?=
 =?utf-8?Q?x2ULVRi5SzFFfNyFwqyFO8kim?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1774d93e-63b8-4eb2-b387-08db2bc72a8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 17:51:01.5291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hoKCpl8Z/DhEqLLnM6Xb94W6aq1wEhVyOqamksVXAF38O0Ev6ojTWwh/xFreWova2AOFVVBX4zTlPR58s0Lfkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5287
X-Proofpoint-GUID: UIl6GWf15A1gBCEINLRtpj7493UKPyMB
X-Proofpoint-ORIG-GUID: UIl6GWf15A1gBCEINLRtpj7493UKPyMB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 mlxlogscore=732 mlxscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230130
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaWVycmUtTG91aXMgQm9zc2Fy
dCA8cGllcnJlLWxvdWlzLmJvc3NhcnRAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25kYXks
IE1hcmNoIDEzLCAyMDIzIDc6NDcgQU0NCj4gVG86IOKAnFJ5YW4gPHJ5YW4ubGVlLmFuYWxvZ0Bn
bWFpbC5jb20+OyBsZ2lyZHdvb2RAZ21haWwuY29tOw0KPiBicm9vbmllQGtlcm5lbC5vcmc7IHBl
cmV4QHBlcmV4LmN6OyB0aXdhaUBzdXNlLmNvbTsNCj4ga3J6eXN6dG9mLmtvemxvd3NraUBsaW5h
cm8ub3JnOyByZkBvcGVuc291cmNlLmNpcnJ1cy5jb207DQo+IGNrZWVwYXhAb3BlbnNvdXJjZS5j
aXJydXMuY29tOyBoZXJ2ZS5jb2RpbmFAYm9vdGxpbi5jb207DQo+IHdhbmd3ZWlkb25nLmFAYXdp
bmljLmNvbTsgamFtZXMuc2NodWxtYW5AY2lycnVzLmNvbTsNCj4gYWp5ZV9odWFuZ0Bjb21wYWwu
Y29ycC1wYXJ0bmVyLmdvb2dsZS5jb207IHNodW1pbmdmQHJlYWx0ZWsuY29tOw0KPiBwb3Zpayts
aW5AY3V0ZWJpdC5vcmc7IGZsYXRtYXhAZmxhdG1heC5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgcm9iaCtkdEBrZXJuZWwu
b3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgTGVlLCBSeWFuUyA8UnlhblMuTGVl
QGFuYWxvZy5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMS8yXSBBU29DOiBtYXg5ODM2
MzogYWRkIHNvdW5kd2lyZSBhbXBsaWZpZXIgZHJpdmVyDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0K
PiANCj4gPiArCXJldCA9IHNkd19zdHJlYW1fYWRkX3NsYXZlKG1heDk4MzYzLT5zbGF2ZSwgJnN0
cmVhbV9jb25maWcsDQo+ID4gKwkJCQkgICAmcG9ydF9jb25maWcsIDEsIHN0cmVhbSk7DQo+ID4g
KwlpZiAocmV0KSB7DQo+ID4gKwkJZGV2X2VycihkYWktPmRldiwgIlVuYWJsZSB0byBjb25maWd1
cmUgcG9ydFxuIik7DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlp
ZiAocGFyYW1zX2NoYW5uZWxzKHBhcmFtcykgPiAxNikgew0KPiA+ICsJCWRldl9lcnIoY29tcG9u
ZW50LT5kZXYsICJVbnN1cHBvcnRlZCBjaGFubmVscyAlZFxuIiwNCj4gPiArCQkJcGFyYW1zX2No
YW5uZWxzKHBhcmFtcykpOw0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsJfQ0KPiANCj4g
RG8geW91IGFjdHVhbGx5IHN1cHBvcnQgbW9yZSB0aGFuIDggY2hhbm5lbHM/DQo+IA0KPiBUaGUg
ZGF0YSBwb3J0IERQblByZXBhcmVDdGwgYW5kIERQbl9DaGFubmVsRW4gcmVnaXN0ZXJzIGV4cG9z
ZSA4DQo+IGNoYW5uZWxzIG1heC4gSXQncyBhbHdheXMgcG9zc2libGUgdG8gJ2NoZWF0JyBieSBw
YWNraW5nIHR3byBjaGFubmVscyBpbiB0aGUNCj4gc2FtZSBzYW1wbGUsIGJ1dCB0aGF0IHdvdWxk
IHJlcXVpcmUgY3VzdG9tIHNpZ25hbGluZyBiZXR3ZWVuIG1hbmFnZXIgYW5kDQo+IHBlcmlwaGVy
YWwgdGhhdCBpc24ndCBwcmVzZW50Lg0KPiANCj4gQ291bGQgaXQgYmUgYSBsZWZ0LW92ZXIgZnJv
bSBhIFRETSBpbXBsZW1lbnRhdGlvbj8NCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudC4NCkkgdGhp
bmsgaXQgaXMgYSBsZWZ0LW92ZXIgZnJvbSBhIFRETSBpbXBsZW1lbnRhdGlvbi4NCkkgc2hhbGwg
bW9kaWZ5IHRoZSBjb2RlIHRvIGFjY2VwdCBvbmx5IG1heCBudW1iZXIgb2YgY2hhbm5lbHMgc3Vw
cG9ydGVkIGJ5IHRoZSBhbXAuDQoNCj4gDQo+IFRoZSByZXN0IG9mIHRoZSBwYXRjaCBsb29rcyBm
aW5lLg0K
