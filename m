Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2BC72A6DF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 01:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjFIXxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 19:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjFIXxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 19:53:07 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370D435B0;
        Fri,  9 Jun 2023 16:53:06 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359KZt5o021915;
        Fri, 9 Jun 2023 19:52:23 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3r2ax6x29t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 19:52:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=golTE8Wmc5eLUNaqix1YNjZzGebePncatNH+fFnosxTdgzjyPZd6P4ncxfYtqfsBOGLgR9djh65+cgknrZxBAZS8NRP0IBTtHRadrrt5jDJ1ge05tzwTZAvDEV+NwlHFwqRxcx6Aa7gRY7aq8Jpg+dQvmsIHxo8TXuCiyBOGI+vZ3wy1/AxKvnp4Disad2UK1Nl55Y/w4VAnoy+EcmARazN2rWg6MzGZ9bzbsGXZ/HB64U06IxV+hg7AdibiBXXYhpTdh0aPq4ImYqUghsvV2L4etFMG2qHRE56pDe4nXtTxLQygxp9bLgnwgl+F+EFChmRtAKH5wlj6pMJjkTBQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdhQuVJhDZrc1LZbHwJUZgCFlq3wxCuKuuwWVuQKDV4=;
 b=lSnrGA8UIsA1gDiBgJUianD3AYPeRKBYRorS3e6kAHwgenwrCSlwxuGgxwyit9yuLP5DcTUrRw+woYxBmCgV3vD3KIu0jVnVOZMdMTNJVCNfmWrQWMF4pq0zVV+LZ9R0FvJnWHKmmQ/4cbg3qNabwnktc8HQxhqhh0udpEE9i2vLcS60MH7u/yF6YOGte5jhSJHwh2PDjVG5h8IHefJfBKg3ZN3I7caY3g5rEqTuOpUblkX8aOmKchwI2nmOwXf66/KWCvSdC4lY6i4CaD093xbs0O2qPq+IGD7J+ltmqK1dL9HisjC0vNuFvO7pXTLfUypwBZYbu+0AY1QKWnsbEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdhQuVJhDZrc1LZbHwJUZgCFlq3wxCuKuuwWVuQKDV4=;
 b=oKVpovSS8A7D5iDrJ0vQwiO9z8KCosAn10Rph/GxOqMTbJmT4GuYC5CGC/cm6NeSoIlUYP/ItHwGxam6C0WddOrrR+mhor6qdf7Inr7Jxm5BydyzNwa1MagBWV6VR/W+nQVKpqzLC1rXyV5amri4oZPwsE/v8Sz+Z5ImDWs3mE4=
Received: from SJ0PR03MB6681.namprd03.prod.outlook.com (2603:10b6:a03:400::6)
 by SN4PR03MB6720.namprd03.prod.outlook.com (2603:10b6:806:1ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Fri, 9 Jun
 2023 23:52:20 +0000
Received: from SJ0PR03MB6681.namprd03.prod.outlook.com
 ([fe80::4367:b823:eb11:589]) by SJ0PR03MB6681.namprd03.prod.outlook.com
 ([fe80::4367:b823:eb11:589%4]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 23:52:20 +0000
From:   "Lee, RyanS" <RyanS.Lee@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?utf-8?B?4oCcUnlhbg==?= <ryan.lee.analog@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
        "wangweidong.a@awinic.com" <wangweidong.a@awinic.com>,
        "shumingf@realtek.com" <shumingf@realtek.com>,
        "herve.codina@bootlin.com" <herve.codina@bootlin.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "doug@schmorgal.com" <doug@schmorgal.com>,
        "ajye_huang@compal.corp-partner.google.com" 
        <ajye_huang@compal.corp-partner.google.com>,
        "kiseok.jo@irondevice.com" <kiseok.jo@irondevice.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "venkataprasad.potturu@amd.com" <venkataprasad.potturu@amd.com>
Subject: RE: [PATCH 1/2] ASoC: dt-bindings: max98388: add amplifier driver
Thread-Topic: [PATCH 1/2] ASoC: dt-bindings: max98388: add amplifier driver
Thread-Index: AQHZmcw3pk3+XO2zQEm0tCaGTGX4qq+Afz8AgAKmRRA=
Date:   Fri, 9 Jun 2023 23:52:20 +0000
Message-ID: <SJ0PR03MB668141D0D4E9604E3670C34B8A51A@SJ0PR03MB6681.namprd03.prod.outlook.com>
References: <20230608054230.344014-1-ryan.lee.analog@gmail.com>
 <87b9c96a-09bf-ec5d-85a0-65f59e5c593d@linaro.org>
In-Reply-To: <87b9c96a-09bf-ec5d-85a0-65f59e5c593d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jY214bFpURXpYR0Z3Y0dSaGRHRmNjbTloYldsdVoxd3dPV1E0TkRsaU5p?=
 =?utf-8?B?MHpNbVF6TFRSaE5EQXRPRFZsWlMwMllqZzBZbUV5T1dVek5XSmNiWE5uYzF4?=
 =?utf-8?B?dGMyY3RZV0ZrTjJFeE1HSXRNRGN5TUMweE1XVmxMV0poWTJJdE56QXhZV0k0?=
 =?utf-8?B?TURkbFpHSTVYR0Z0WlMxMFpYTjBYR0ZoWkRkaE1UQmpMVEEzTWpBdE1URmxa?=
 =?utf-8?B?UzFpWVdOaUxUY3dNV0ZpT0RBM1pXUmlPV0p2WkhrdWRIaDBJaUJ6ZWowaU5U?=
 =?utf-8?B?WXlOQ0lnZEQwaU1UTXpNekE0TWpnek16a3pPRGd4TnpZMUlpQm9QU0pUV0RO?=
 =?utf-8?B?T1FVTjBSV1JyTVRaTlJTOTBTMHcwTjA1TmVuZEZjVVU5SWlCcFpEMGlJaUJp?=
 =?utf-8?B?YkQwaU1DSWdZbTg5SWpFaUlHTnBQU0pqUVVGQlFVVlNTRlV4VWxOU1ZVWk9R?=
 =?utf-8?B?MmRWUVVGRmIwTkJRVU5zVG1zNWRFeGFkbHBCV0hSUEswWmFTbmhuVkVGbE1E?=
 =?utf-8?B?YzBWbXR1UjBKTlFVUkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlNFRkJRVUZFWVVGUlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UlVGQlVVRkNRVUZCUVZJMmJGUk1RVUZCUVVGQlFVRkJRVUZCUVVGQlFVbzBR?=
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
x-ms-traffictypediagnostic: SJ0PR03MB6681:EE_|SN4PR03MB6720:EE_
x-ms-office365-filtering-correlation-id: 4160364d-1eae-4356-f047-08db69449098
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UFxw6twFt31bi2GCrkfJKnCvaZUWFbhaj1jmqBugJQPRsya+zUuvAMYZi11hA0KxTrLjnP63xcHW8/IV8EY5dL921P/pODLqHbFM3AjLPqmACyWB+n8GfZxdHHQHd05mnZOzA5iBQ16lmrCj8pyKTQbzAfXMOJge6pRnFiqXMSQTaLgCh0nqwnmrYydsdt/pJk7RtzD6vBauO4VZ9cXhFI8ggmDVbIOp9ANIIzlPf4r4ZaTnYQaVxnoYNyXX1pn80Mx4SPi3JpTjB3X79G8vz8QXmffTGxFk4gLvRYEUETC5xFBZ+10gDBZtgdwhPrb03joPqVx8/qKToYYo7KYd+p5IhtpOTmtoBkhxGsdcAPxopef8GQhA+OwwdHL6SJbGTuTJiBLX0nTM1lUokdQmetT8xN6BKC+//NEtilankcS+gGhGbZ6hIWwT9wWhVQtM6I1eQwvJ4CyAQpRiXbyMGmEMLSkkwn8qjV6RpJx8Skm1MAi5wV1KOW5TEvTR58UqlDpWNmKT9zr16KLHs/tHPZvTISIJxaNHDoPWGqXstKVz3C+NGnPjOLTCaESKaFqGqFhZhLH/aOloXCydyFFu14UXsT7bLj/2jssOiVAAfd7YtuYdybYsdO55myJf2dpFrHeR2Lek/+CwwWTFaLjy+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6681.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(26005)(55016003)(186003)(52536014)(5660300002)(41300700001)(6506007)(9686003)(53546011)(33656002)(7416002)(4326008)(76116006)(66946007)(71200400001)(66446008)(64756008)(7696005)(66556008)(83380400001)(66476007)(478600001)(110136005)(8676002)(8936002)(2906002)(316002)(86362001)(921005)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDNJOW1kUWhUSGVoTUZVVSthUWNJN0Y5Qk5kb1E5MXh4dlZFMERkUWdGNEpJ?=
 =?utf-8?B?OFZOSzJjY1JCRFpoQmpkU3RCK1hsODY0TTlIK0xIZTF1M0dFSVY2K3FMeEJy?=
 =?utf-8?B?NDZLWVAxSHF4R09QTkh1anBoOGJ3WUJxS250emtIRFFZV2FSL1RvQmpLMkgr?=
 =?utf-8?B?cjlwbDRTN1Q2VmxWSHN5Nk5EZmpjMSszRDBRSks3Rk5LaUhKTmFZaDBicklL?=
 =?utf-8?B?aUpQSTRmTEI1cjRPYW15ck9KS21RcytDWStSblpkWmtSdUoyQTU4cHQ5c2t1?=
 =?utf-8?B?MEt1UG9JSXJBMTBkc3JBK1h5dFhlaUVnTkhiQWVwYjZhZzNDc1NLN284M21D?=
 =?utf-8?B?VVZybnR5bStBSHBDR2xKQllrT2FlTC9sRVowRmdVdDVvd2N0UWNzeGVxNk02?=
 =?utf-8?B?ak9uQWJvMGNMWnB1T1dybkt1cml3cXVRZU5hbUhBKzUxWUlzNy9CVUFkZ25v?=
 =?utf-8?B?QXNXNVNOenJva3MraTZTdVg4QzJGZW54UUZQUHAzWnZ3bFFZZGJCNGVOUmpG?=
 =?utf-8?B?ZndraGdvZWNlOEtvSkhvU0R2a0FNSDFpL01KOUdYcmIyMmhoeHdRbUpzZUJq?=
 =?utf-8?B?bzJ2enVqVkpJWkVhQzQwVE1kZnQveHpOQSt2WVhzVUFxcTY0Z091ZXR5Q3gx?=
 =?utf-8?B?NEtQbno1bVZONUlOZ1lEWDRVaXdBb0JmNzQ2VFQ4WGRCOGRGd015UXloSDYx?=
 =?utf-8?B?bHdWbkxzWGZ2eWkvRW91MS9rZGlNNkRJN0RoSXFrMTZXQThJOUpaRXhzT0Vv?=
 =?utf-8?B?MTByS0hUMm53ZlIva0VodVFwdU5NMnNyZnM2czdGTFE3ZStpaHpyb0ovVHN3?=
 =?utf-8?B?N2M3RDJ3UnlIWmw3elFxRDNVUU9UMm5EbU5IZHYwSTZOM21RNFFFU1R6aDZ3?=
 =?utf-8?B?YjJCR1V5RnVJVDAxdG1ybmVzaEIyWHM3aXBLZGVJaUt2TXpCYTlWYlo5ZWNr?=
 =?utf-8?B?TU1MSzR6eXRmaGZONWFwR0xhcENwaGVmUDRZUnowTlA1QjdZd3QwYlNxR0t3?=
 =?utf-8?B?MFJwbGF4TzNURC8xcTNHaEFCcnVsZ3NHVVFQRmNKa1I5NW41R2hRcnU1ZUMz?=
 =?utf-8?B?eUd1bU5FZjZhTnFKaVJpd3dPKzdyMmxCcE1XMlJOWTJwbVBVUGdtR0VNU1Vy?=
 =?utf-8?B?WVpiTDdMbXA3Ky8wRnMzVThBUklGR0Y3UEZDRzBOdktydkFOT1RHUTA3dXdZ?=
 =?utf-8?B?THIrWHAwekpEYUpseFpOQ21TTERWWGU2NUFVeDlMalMvK04ySGFrcXdGcWFp?=
 =?utf-8?B?cklHTFV6ckNEa0JBallyamhKdU4zaFZWR3J1Y1V5OUV1VU1QNlUrN1BjUmlq?=
 =?utf-8?B?OGVIN3k3ekJGU1dScGtTaVNCQThBbjBzam1MOXI4bE1jczlQWWVLSXVaSFZ6?=
 =?utf-8?B?ZVh2T2FGRGY0SlkvUWkza1lJNkU2ZTV1MGEzbjU4UGtjbDRFRGhPSnZNdXBK?=
 =?utf-8?B?elg4R0Y5UGNVVkIzdU5kYWVLNEFwWWZ2V1dkT2VUNmhGMTJTNGFVaVZoVUJY?=
 =?utf-8?B?Q0ExVXZWOW52a0IxeWI3R0I5WWF4UWVpUnFOYzdnVVgvNnFPTWRXanFSSnRp?=
 =?utf-8?B?eGZncTRLZERETjAwRDRlU28yS0FLWE5MZ3JkRTQ3Zk8vRUVaZ29uOU9kemVG?=
 =?utf-8?B?NkNNTFEvazRpbHNOQ2NXQzNKRzdvTjFDK1Nnbm80MlNJMGQ1TGdTQ0lnNnpq?=
 =?utf-8?B?amx0UlJqT0Q2ZU9sYmU3eW5aWVNlYkdUamxJQ0RaeDJWaVZXUEY2RkVlbXNK?=
 =?utf-8?B?a0N0Z3pINE41ZnRQZGk0QldYamFvRVBUcXlETnc2SzU4SzdlY200TVNTeW1S?=
 =?utf-8?B?T3MzdjB5VE1nYlViUXdOUURYb2RQcVkxMTFsQnlyeS9Ma2FsR09PQ1dRRVNu?=
 =?utf-8?B?SnNaMk91Ly90S2pIQkxsZTVoSnlEUEVjUS84dHFxU05hTjFGVW5tbWcyOEtF?=
 =?utf-8?B?aXk2MGNFZURVaWRPVkNjVm8xTTUzRHNSaEFUc1hmZ1FtZ1VkWDB2cWZqSSt5?=
 =?utf-8?B?SkFubzNUOXArQjlHV25SMTBSMFVuYzdYY0tPWlBVcDh5VC8wc2pIWFk2bjhQ?=
 =?utf-8?B?WmZ3RnlTTVV4a3E4N2NwTXZYeEVTZ3d1RDViUHl5M1ZrVlEzSUNON1plSnRP?=
 =?utf-8?Q?GAfduUXiwvSSviwAXA5omhdmF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4160364d-1eae-4356-f047-08db69449098
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 23:52:20.7428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5IHFbmGoVXbUCnQuh9UtcFcFiZGUobmC5flwF2x7al/ygfbjhbrHPrueIa+rd5bt4FhL9Bf4ZhKGkPvOxS+9Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR03MB6720
X-Proofpoint-GUID: N3gt3varaebk4LNJQvvm7ouf6s5mpW8S
X-Proofpoint-ORIG-GUID: N3gt3varaebk4LNJQvvm7ouf6s5mpW8S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_17,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090201
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5l
IDgsIDIwMjMgMTI6MTggQU0NCj4gVG86IOKAnFJ5YW4gPHJ5YW4ubGVlLmFuYWxvZ0BnbWFpbC5j
b20+OyBsZ2lyZHdvb2RAZ21haWwuY29tOw0KPiBicm9vbmllQGtlcm5lbC5vcmc7IHJvYmgrZHRA
a2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBwZXJleEBw
ZXJleC5jejsgdGl3YWlAc3VzZS5jb207DQo+IHJmQG9wZW5zb3VyY2UuY2lycnVzLmNvbTsgTGVl
LCBSeWFuUyA8UnlhblMuTGVlQGFuYWxvZy5jb20+Ow0KPiB3YW5nd2VpZG9uZy5hQGF3aW5pYy5j
b207IHNodW1pbmdmQHJlYWx0ZWsuY29tOw0KPiBoZXJ2ZS5jb2RpbmFAYm9vdGxpbi5jb207IGNr
ZWVwYXhAb3BlbnNvdXJjZS5jaXJydXMuY29tOw0KPiBkb3VnQHNjaG1vcmdhbC5jb207IGFqeWVf
aHVhbmdAY29tcGFsLmNvcnAtcGFydG5lci5nb29nbGUuY29tOw0KPiBraXNlb2suam9AaXJvbmRl
dmljZS5jb207IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsNCj4gZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IHZlbmthdGFw
cmFzYWQucG90dHVydUBhbWQuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBBU29DOiBk
dC1iaW5kaW5nczogbWF4OTgzODg6IGFkZCBhbXBsaWZpZXIgZHJpdmVyDQo+IA0KPiBbRXh0ZXJu
YWxdDQo+IA0KPiBPbiAwOC8wNi8yMDIzIDA3OjQyLCDigJxSeWFuIHdyb3RlOg0KPiA+IEZyb206
IFJ5YW4gTGVlIDxyeWFucy5sZWVAYW5hbG9nLmNvbT4NCj4gPg0KPiA+IEFkZCBkdC1iaW5kaW5n
cyBpbmZvcm1hdGlvbiBmb3IgQW5hbG9nIERldmljZXMgTUFYOTgzODggSTJTIEFtcGxpZmllcg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUnlhbiBMZWUgPHJ5YW5zLmxlZUBhbmFsb2cuY29tPg0K
PiANCj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLiBUaGVyZSBpcyBzb21ldGhpbmcgdG8gZGlz
Y3Vzcy9pbXByb3ZlLg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMuIEkgc2hhbGwgZml4IHRoZSBp
c3N1ZXMgYW5kIHN1Ym1pdCB0aGUgcGF0Y2ggYWdhaW4uDQoNCj4gDQo+ID4gKw0KPiA+ICthbGxP
ZjoNCj4gPiArICAtICRyZWY6IGRhaS1jb21tb24ueWFtbCMNCj4gPiArDQo+ID4gK3Byb3BlcnRp
ZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGVudW06DQo+ID4gKyAgICAgIC0gYWRp
LG1heDk4Mzg4DQo+IA0KPiBCbGFuayBsaW5lDQo+IA0KPiA+ICsgIHJlZzoNCj4gPiArICAgIG1h
eEl0ZW1zOiAxDQo+ID4gKyAgICBkZXNjcmlwdGlvbjogSTJDIGFkZHJlc3Mgb2YgdGhlIGRldmlj
ZS4NCj4gDQo+IERyb3AgZGVzY3JpcHRpb24sIGl0J3Mgb2J2aW91cy4NCj4gDQo+ID4gKw0KPiA+
ICsgICcjc291bmQtZGFpLWNlbGxzJzoNCj4gPiArICAgIGNvbnN0OiAwDQo+ID4gKw0KPiA+ICsg
IGFkaSx2bW9uLXNsb3Qtbm86DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogc2xvdCBudW1iZXIgb2Yg
dGhlIHZvbHRhZ2UgZmVlZGJhY2sgbW9uaXRvcg0KPiA+ICsgICAgJHJlZjogIi9zY2hlbWFzL3R5
cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMiINCj4gDQo+IERyb3AgcXVvdGVzLg0KPiANCj4g
PiArICAgIG1pbmltdW06IDANCj4gPiArICAgIG1heGltdW06IDE1DQo+ID4gKyAgICBkZWZhdWx0
OiAwDQo+ID4gKw0KPiA+ICsgIGFkaSxpbW9uLXNsb3Qtbm86DQo+ID4gKyAgICBkZXNjcmlwdGlv
bjogc2xvdCBudW1iZXIgb2YgdGhlIGN1cnJlbnQgZmVlZGJhY2sgbW9uaXRvcg0KPiA+ICsgICAg
JHJlZjogIi9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMiINCj4gDQo+IERy
b3AgcXVvdGVzLg0KPiANCj4gPiArICAgIG1pbmltdW06IDANCj4gPiArICAgIG1heGltdW06IDE1
DQo+ID4gKyAgICBkZWZhdWx0OiAxDQo+ID4gKw0KPiA+ICsgIGFkaSxpbnRlcmxlYXZlLW1vZGU6
DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgRm9yIGNhc2VzIHdoZXJlIGEgc2lu
Z2xlIGNvbWJpbmVkIGNoYW5uZWwgZm9yIHRoZSBJL1YgZmVlZGJhY2sgZGF0YQ0KPiA+ICsgICAg
ICBpcyBub3Qgc3VmZmljaWVudCwgdGhlIGRldmljZSBjYW4gYWxzbyBiZSBjb25maWd1cmVkIHRv
IHNoYXJlDQo+ID4gKyAgICAgIGEgc2luZ2xlIGRhdGEgb3V0cHV0IGNoYW5uZWwgb24gYWx0ZXJu
YXRpbmcgZnJhbWVzLg0KPiA+ICsgICAgICBJbiB0aGlzIGNvbmZpZ3VyYXRpb24sIHRoZSBjdXJy
ZW50IGFuZCB2b2x0YWdlIGRhdGEgd2lsbCBiZSBmcmFtZQ0KPiA+ICsgICAgICBpbnRlcmxlYXZl
ZCBvbiBhIHNpbmdsZSBvdXRwdXQgY2hhbm5lbC4NCj4gPiArICAgIHR5cGU6IGJvb2xlYW4NCj4g
PiArDQo+ID4gKyAgcmVzZXQtZ3Bpb3M6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4g
PiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSByZWcNCj4gPiArICAt
ICIjc291bmQtZGFpLWNlbGxzIg0KPiANCj4gS2VlcCBjb25zaXN0ZW50IHF1b3RlcyAtIGVpdGhl
ciAnIG9yICINCj4gDQo+ID4gKw0KPiA+ICt1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+
IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
