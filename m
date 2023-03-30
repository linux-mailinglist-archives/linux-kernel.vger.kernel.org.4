Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D824B6D121A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjC3W1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjC3W1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:27:38 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CB1D327;
        Thu, 30 Mar 2023 15:27:34 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ULQBtT029958;
        Thu, 30 Mar 2023 18:26:48 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3pneuk9agn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 18:26:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVOVhxgz2JvK6Fx6bkkKZxfuCPc/BgtfeyNWHvmHdCAN2bGjYp7bLEH8rz1UAj3mDVO0KObECk32ARk3Ked6CFQPdDBGiFX7JP0BM5baBYIlDgOaK+X9JybB9BDRbpAL7H3N+fIaqNbM/JnwtG0GgDYczwFekCR3DrpFDQv9+/bzKTDZMKeihEREyq4zLxPr4l8trUhTJaBRJcQQCX+3dWtRZC3e4XsfjZGZ/D8WM0dXKbCuC9XzYCWU3ULvPYIejPYbSQRQtRqAmtaEssLFkXEqlim1MRxo/KRLc7VEj4Hu/GIvH6Zo42LLzIIXWTuqZnM/rLJSfyqVdWDOwVTA0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+q0qNXtfx/4gtp0Fsn0PiereuOAtLMhImcMF3WBUK0=;
 b=ms/crJANjQWwOQmJfk2sB+n5NqIcvTwMGYbCiZl5vYWaZnri21izBAT4MSq/7UdeIHi2EtDowrUXzsd3B3HwP918t06zNogMBpiUaOSErZSQXmkPowSn+r9CBqSD1IUcca9kbB/9eVOoRMdlxKlKYnOF1qtLgPtAZGZC9AM1b7gNCMdiHEzWkYO7X42YD0AY9mQmEeJ6DocgGlovZ8X/f4T+OqSeESzi8fZomCiyDFOQzNzN8KGVzyPsOgmGPaPbMcTrpE7DiWcgG8DS/3z9G1p9jvKmjO3wEiaoqN5N0T/rXvlC3qtofG5IyPeOiFfngwJmFYOtg3h/RHUfJPzISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+q0qNXtfx/4gtp0Fsn0PiereuOAtLMhImcMF3WBUK0=;
 b=sIUhyTDAciyZ8r6dK76rsSj+qJBsrxIYI/jL2IjBiuePmOTaimMZerJw7lYh34VNfI+SeEZ2WJY1rxZ094h5QxiePJF8RbhNG2hOXJVIN0P5uFZIFjVvwzjkOA4ZPFoi972wKuUotPxLc9tKqJ1ZpJkZHYYIQqkuEKC9Y6DiFWU=
Received: from SJ0PR03MB6681.namprd03.prod.outlook.com (2603:10b6:a03:400::6)
 by SA2PR03MB5833.namprd03.prod.outlook.com (2603:10b6:806:114::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 22:26:45 +0000
Received: from SJ0PR03MB6681.namprd03.prod.outlook.com
 ([fe80::3cfa:c828:4023:5375]) by SJ0PR03MB6681.namprd03.prod.outlook.com
 ([fe80::3cfa:c828:4023:5375%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 22:26:45 +0000
From:   "Lee, RyanS" <RyanS.Lee@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?utf-8?B?4oCcUnlhbg==?= <ryan.lee.analog@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
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
Subject: RE: [PATCH V3 2/2] ASoC: dt-bindings: max98363: add soundwire
 amplifier
Thread-Topic: [PATCH V3 2/2] ASoC: dt-bindings: max98363: add soundwire
 amplifier
Thread-Index: AQHZXbBXNkPITZ3dd0G0i4gdprnniK8JznUAgAoYWhA=
Date:   Thu, 30 Mar 2023 22:26:45 +0000
Message-ID: <SJ0PR03MB66811E9AEB44F1B697725C138A8E9@SJ0PR03MB6681.namprd03.prod.outlook.com>
References: <20230323175256.2606939-1-ryan.lee.analog@gmail.com>
 <20230323175256.2606939-2-ryan.lee.analog@gmail.com>
 <cbfbbfeb-8ce9-3908-9a61-58b7daa4e7d9@linaro.org>
In-Reply-To: <cbfbbfeb-8ce9-3908-9a61-58b7daa4e7d9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jY214bFpURXpYR0Z3Y0dSaGRHRmNjbTloYldsdVoxd3dPV1E0TkRsaU5p?=
 =?utf-8?B?MHpNbVF6TFRSaE5EQXRPRFZsWlMwMllqZzBZbUV5T1dVek5XSmNiWE5uYzF4?=
 =?utf-8?B?dGMyY3RaakkyT1RZeFkyWXRZMlkwT1MweE1XVmtMV0poWWpjdE56QXhZV0k0?=
 =?utf-8?B?TURkbFpHSTVYR0Z0WlMxMFpYTjBYR1l5TmprMk1XUXdMV05tTkRrdE1URmxa?=
 =?utf-8?B?QzFpWVdJM0xUY3dNV0ZpT0RBM1pXUmlPV0p2WkhrdWRIaDBJaUJ6ZWowaU5E?=
 =?utf-8?B?QTVNU0lnZEQwaU1UTXpNalEyT0RnNE1ETTNOREE0T1RNM0lpQm9QU0pZUVM5?=
 =?utf-8?B?bVlrSlJkMjFQTms1NVRYbEJWV3dyV25CTFlWbzNTbGs5SWlCcFpEMGlJaUJp?=
 =?utf-8?B?YkQwaU1DSWdZbTg5SWpFaUlHTnBQU0pqUVVGQlFVVlNTRlV4VWxOU1ZVWk9R?=
 =?utf-8?B?MmRWUVVGRmIwTkJRVU53V1U5WE1GWnRVRnBCWmpOb00zTmtSRlZGTW13dlpV?=
 =?utf-8?B?aGxlREJPVVZSaFZVUkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: SJ0PR03MB6681:EE_|SA2PR03MB5833:EE_
x-ms-office365-filtering-correlation-id: bfeca04e-ff5c-45e4-4713-08db316dd849
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cw+9X59tLwAxz+4IdcoD8hynEV77dd8QZcf8fGpTPQY4bPdAdZSFmJ0Hmns6A2DTL/X+nFleWIT/JG1KZlj5VvZO6UbHpCnjsASkV2dD0Ag9od47Kbsr8U8+vlhpjeGE41NGj20e1kamfl8yxgzxP16L26p1BEEdqyEIbphHYdWOg67f3dhieHCtEpJo2bATH4bUU6JnT/ohrPYn7L7+uLkD0z4+egfKljr23erdM9QiwVclo6/8xy00k5jKDy+rSmFnl2aBhSTdby69TSpcDPycXqd6c1hq1mpOyFmEQehG7jNkXs65zT5SDBd5OzzW4ABHwXe5A0qYwUMHrMGoJkl2twabBpcJMrgL3m47WCV7tLnwGYMRbRBM37pVUbo9u7QyAaSHRk+6vUfsw6ChEIrPvEjWkAVTPIb2LMy7zZ1dY6RjXkleMDd/QNFgereKhtj06C7OW/6GW3jB0qDt5vNMF5oZF6HfTo4PPde5cpgH1tkr1WI75XqGgdVUx3i3v5X7oECcANA8k5k/MbQ2UeU5S5OJnlleYj4GzbZxN1HsfsfCqjcUzSVrStzLSeQWNHQ3q8HbHm6+T5eAoxyiv5ykim72Iuho7F2lXqUg8iK09n4LEdrJD8il4OmwiiXmQ2d24JOXGyPdZlB5aEIHuMa/Q+SwetU973Hsf7I1AKw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6681.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(83380400001)(33656002)(86362001)(38100700002)(921005)(38070700005)(8936002)(5660300002)(122000001)(7416002)(41300700001)(64756008)(66476007)(8676002)(76116006)(66556008)(52536014)(55016003)(66446008)(66946007)(966005)(9686003)(6506007)(53546011)(71200400001)(478600001)(7696005)(2906002)(26005)(186003)(110136005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0wyRkUra3B6OG1QbEduL01QQkw2Q2hKUzk4enFZdk5WQ1lOVEdCblZkMCtu?=
 =?utf-8?B?KzMvUkVVL2R1YXpSSUI1dk5YMjYvK1IyZWoxVk1OTnJqYkVoTEZxR1Jxci9w?=
 =?utf-8?B?Sk5TRTU0ZE4vc0V1a3JoNVU4ZFlDbjk0c1hxL0hwRCsydy8rV09Kb25SWVd4?=
 =?utf-8?B?UTFaZy8zdG5kUDNBaGNqd29CUEo3dWVqNWY3MWR0RFBHVUpIRUhmb3pIYkxT?=
 =?utf-8?B?bnpuMkJHSTZJUDZLOWliUG5PemlQNW1INXhzMFV4NDJsbVZ2Z3JIQ3FVSzMy?=
 =?utf-8?B?MFVWZ2dMUG1IUzBFSkhvRXRQV3MydjNqcml4RUMzdDc2eG5PRFRWZHdZTEUx?=
 =?utf-8?B?S3ZhSGpiMHFtUjk1MER0M0ZNU0Z2ZEd0dC9VbUhtR1lPd2ZvT2J5ak5WKyti?=
 =?utf-8?B?dVZEd2NiVm5yMEVWT000M0c0RkJqb25rallnNTRBemhyQ3VwY0JOc1lQOFBy?=
 =?utf-8?B?UjBFSXVsOHQ0OHRYakxFcnBsdDc4SHpBSGpwaWtiZXovNDhWdndwTC83ZG03?=
 =?utf-8?B?NXJGenRweVRnS1hUdG9VMmo1dHd5YXhzdWprNkxnUWNid2plYVZsMzRyWXVO?=
 =?utf-8?B?TnRlTTdwTVg3Q2J0Q1JMRS94bXY0K3BMRzczK0YwUG5mamJMdDhObFNYQS9D?=
 =?utf-8?B?cFdNdGZlQnl2bDdvd1YyVGIybFdmK1QxWkRSbWtIdDBqM2lDeTNHcEVBN0xZ?=
 =?utf-8?B?eWZyOG93WlZEcDkrNGVLYUw1cncwbUhhM1AvQUxoL0NJMjdlbVE1bHJ0RXI5?=
 =?utf-8?B?NWl1UXo5WnI0TEdraGh6cGd6SCtmWWJKSStIMmhRdm1QWFJSUDZpcUNMc0Q1?=
 =?utf-8?B?V042NStTVkFLUWtBZXZEMkREWFhHaFRKamd1VE9HZHVZb2U4NkJnNDdQMkIr?=
 =?utf-8?B?OHJHSjdrZllXUEpkeEk2MzZtemJ1VXF6UzNUM0FVWVY1QXdISm12cDFzeWRU?=
 =?utf-8?B?TjFCaTNnT0pmSm15Ulgvc29xRnNzQW5BNzZ3azErb1FoaDl2QUd4WlVCREgx?=
 =?utf-8?B?N0twRUttczJhMmJJYTNMSHBsRytjVjhmRXJXRXRoVVVsY0VnWnFVWm9lcmV3?=
 =?utf-8?B?NDF1V1JoVzN5OWc3S3BCQms3QStJMWdFSXA1RkFxUDFiMmYrOVlTZlpGVFA1?=
 =?utf-8?B?NE43OGdVaUFQcW1HaC8zaFlQRDhXaWZndWtaVUZrWWRDbmZ1RExXdklveUMy?=
 =?utf-8?B?bUhoeXQ5R1Vpb1VyTVhwcHNRam5CTW5UbXdWcmFMY2ZsR2w5bTJ0d0NnVVN4?=
 =?utf-8?B?U3IweUpNSUk2Z2dGNDduRUdqak4rcFBXd2RnY3g5SSt1SjNBNnpMVFVET3Fy?=
 =?utf-8?B?QithSzAwanV4cnVHZ0lObDNoamlKU2tnQjA5RXdJWFFCR0l0Zmd1R0xHWnp1?=
 =?utf-8?B?cy9WQXZHV2JLUXpxWm12UHh6NnZKMmd4SWluS3NmOWJoRnhlTm5WSktaZlJj?=
 =?utf-8?B?czVLK21KWU1OSlk3eExhQld5bEN0UDlaZjE4WDRXZmtWbld5c3JDVC9qOTJY?=
 =?utf-8?B?NC9HQ1QzMG5CMkNEYjBYaUFjaGFWV2ZtVXhzb1U2ZGszdmx5UjJXclhEWUNx?=
 =?utf-8?B?VzRHamJqdWlZTEN1TEJPWmwxVkZ3SEt1QVh4Z0ZsTVp6d29KeWcveVRwTjhp?=
 =?utf-8?B?aFVBSWJFVGVGT0Y2SEUrLytrSUYyVFRkWUQ4azl2SDRsWnF0Q3Y3NkZQdzhS?=
 =?utf-8?B?alJaV21GRWhGWDJWQXg1ZGJtc3kzTC9JTVlKYnhmd0tZdjdvWE9vS1hzQ1c4?=
 =?utf-8?B?bFhvNWwxWXRMTkl4ZERGYjR3Z0NhVGpzVm4vYUhhL2NPYTgrckF3UXloRWJ5?=
 =?utf-8?B?azdWRS92NE1ESk8ya1ZZcEhCNFJUazc3cE9QbXM5RXdMRXVzaU1IWUxKVHJn?=
 =?utf-8?B?MnNNK09hb0FFL2FMZUpJZmtGSVM4czhRZkhOeTE4Sm1IV2VRQU9kR0lPYWdh?=
 =?utf-8?B?d1JPS0pjNEJyUUJPcmM0bGFQT2RlYmcwc2hOYUxTeWJSRE1heDdRamU5bHBW?=
 =?utf-8?B?bzh4akN4SEZlclUxKzI3RjJucG1ucDFIR3lxRXlGRE1CSEJEaWRKb3hpRUpy?=
 =?utf-8?B?dXVmcDIyZDFoOUtiTUhkUEF6aFdLU2svUmo1MG5oa1dSbks1djZTeS9pcXFz?=
 =?utf-8?Q?b1h98JlTdZSZvX//nn1pXRsxG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfeca04e-ff5c-45e4-4713-08db316dd849
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 22:26:45.2579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbSXpRDM3JX7pysIV0BRM5uExRcvDgjDPHkZ5U5CL8no9I2cEjqkZQzCj+CaMZC8ULWcTiDBXn3l/Li0APAXnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5833
X-Proofpoint-GUID: 7lNHk5vscrDopV081mA-r3SJ8EJh5XqC
X-Proofpoint-ORIG-GUID: 7lNHk5vscrDopV081mA-r3SJ8EJh5XqC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_13,2023-03-30_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1011 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303300177
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2gg
MjQsIDIwMjMgNDozNyBBTQ0KPiBUbzog4oCcUnlhbiA8cnlhbi5sZWUuYW5hbG9nQGdtYWlsLmNv
bT47IGxnaXJkd29vZEBnbWFpbC5jb207DQo+IGJyb29uaWVAa2VybmVsLm9yZzsgcGVyZXhAcGVy
ZXguY3o7IHRpd2FpQHN1c2UuY29tOw0KPiByZkBvcGVuc291cmNlLmNpcnJ1cy5jb207IGNrZWVw
YXhAb3BlbnNvdXJjZS5jaXJydXMuY29tOyBwaWVycmUtDQo+IGxvdWlzLmJvc3NhcnRAbGludXgu
aW50ZWwuY29tOyBoZXJ2ZS5jb2RpbmFAYm9vdGxpbi5jb207DQo+IHdhbmd3ZWlkb25nLmFAYXdp
bmljLmNvbTsgamFtZXMuc2NodWxtYW5AY2lycnVzLmNvbTsNCj4gYWp5ZV9odWFuZ0Bjb21wYWwu
Y29ycC1wYXJ0bmVyLmdvb2dsZS5jb207IHNodW1pbmdmQHJlYWx0ZWsuY29tOw0KPiBwb3Zpayts
aW5AY3V0ZWJpdC5vcmc7IGZsYXRtYXhAZmxhdG1heC5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgcm9iaCtkdEBrZXJuZWwu
b3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgTGVlLCBSeWFuUyA8UnlhblMuTGVl
QGFuYWxvZy5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMi8yXSBBU29DOiBkdC1iaW5k
aW5nczogbWF4OTgzNjM6IGFkZCBzb3VuZHdpcmUNCj4gYW1wbGlmaWVyDQo+IA0KPiBbRXh0ZXJu
YWxdDQo+IA0KPiBPbiAyMy8wMy8yMDIzIDE4OjUyLCDigJxSeWFuIHdyb3RlOg0KPiA+IEZyb206
IFJ5YW4gTGVlIDxyeWFucy5sZWVAYW5hbG9nLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRk
cyBkdC1iaW5kaW5ncyBpbmZvcm1hdGlvbiBmb3IgQW5hbG9nIERldmljZXMgTUFYOTgzNjMNCj4g
PiBTb3VuZFdpcmUgQW1wbGlmaWVyLg0KPiANCj4gTm8gaW1wcm92ZW1lbnRzIGhlcmUuIFNvIHJl
bWluZGluZzoNCj4gDQo+IERvIG5vdCB1c2UgIlRoaXMgY29tbWl0L3BhdGNoIiwgYnV0IGltcGVy
YXRpdmUgbW9vZC4gU2VlOg0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9l
bGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuMTcuMS9zb3VyYw0KPiBlL0RvY3VtZW50YXRpb24v
cHJvY2Vzcy9zdWJtaXR0aW5nLQ0KPiBwYXRjaGVzLnJzdCpMOTVfXztJdyEhQTNOaThDUzB5Mlkh
NDVyTXh0bjg5b3RsZW41bWpFT0dNWG9QUXduc2wzcDkNCj4gcXR1VEpSOTlRZ0taRE5kRk9vLXVm
SVdFMk9lZWJIZkp5bkdqaG1DNHkyZkZQV3RZYVR3UktqWGhma0UkDQo+IA0KDQpUaGFua3MgZm9y
IHRoZSBjb21tZW50LiBJIHNoYWxsIGZpeCB0aGlzIGFuZCB0aGUgcmVzdC4NCg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogUnlhbiBMZWUgPHJ5YW5zLmxlZUBhbmFsb2cuY29tPg0KPiA+IC0tLQ0K
PiA+IENoYW5nZXMgZnJvbSB2MToNCj4gPiAgIEZpeGVkIGEgc3ludGF4IGVycm9yIGZvciB0aGUg
J2R0X2JpbmRpbmdfY2hlY2snIGJ1aWxkLg0KPiA+ICAgUmVtb3ZlZCB1bm5lY2Vzc2FyeSBwcm9w
ZXJ0aWVzLg0KPiA+ICAgQWRkZWQgZGVzY3JpcHRpb24gYWJvdXQgU291bmRXaXJlIGRldmljZSBJ
RCBvZiBNQVg5ODM2MyBDaGFuZ2VzIGZyb20NCj4gPiB2MjoNCj4gPiAgIFJlbW92ZWQgdGhlIGxl
Z2FjeSBmcm9tIGkyYy9pMnMgZHJpdmVyIGFuZCBhZGRlZCBTb3VuZFdpcmUgZGV2aWNlIElEDQo+
IGluZm8uDQo+ID4gICBBZGRlZCBtaXNzaW5nIGluZm9ybWF0aW9uIGFib3V0IERBSS4NCj4gPg0K
PiA+ICAuLi4vYmluZGluZ3Mvc291bmQvYWRpLG1heDk4MzYzLnlhbWwgICAgICAgICAgfCA2MiAr
KysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCsp
DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zb3VuZC9hZGksbWF4OTgzNjMueWFtbA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9hZGksbWF4OTgzNjMueWFtbA0K
PiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2FkaSxtYXg5ODM2
My55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAu
LjkyMzUyYTIzZTFjYg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvYWRpLG1heDk4MzYzLnlhbWwNCj4gPiBAQCAtMCww
ICsxLDYyIEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkg
T1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDoNCj4gPg0KPiAr
aHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFz
L3NvdW5kL2FkaSxtDQo+ID4NCj4gK2F4OTgzNjMueWFtbCpfXztJdyEhQTNOaThDUzB5MlkhNDVy
TXh0bjg5b3RsZW41bWpFT0dNWG9QUXduc2wzcA0KPiA5cXR1VEoNCj4gPiArUjk5UWdLWkROZEZP
by11ZklXRTJPZWViSGZKeW5HamhtQzR5MmZGUFd0WWFUd1JZYUpOTXJvJA0KPiA+ICskc2NoZW1h
Og0KPiA+ICtodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3Jn
L21ldGEtDQo+IHNjaGVtYXMvY29yZS55DQo+ID4NCj4gK2FtbCpfXztJdyEhQTNOaThDUzB5Mlkh
NDVyTXh0bjg5b3RsZW41bWpFT0dNWG9QUXduc2wzcDlxdHVUSlI5OQ0KPiBRZ0taRE4NCj4gPiAr
ZEZPby11ZklXRTJPZWViSGZKeW5HamhtQzR5MmZGUFd0WWFUd1JUTW4zMjA4JA0KPiA+ICsNCj4g
PiArdGl0bGU6IEFuYWxvZyBEZXZpY2VzIE1BWDk4MzYzIFNvdW5kV2lyZSBBbXBsaWZpZXINCj4g
PiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gUnlhbiBMZWUgPHJ5YW5zLmxlZUBhbmFs
b2cuY29tPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246DQo+ID4gKyAgVGhlIE1BWDk4MzYzIGlz
IGEgU291bmRXaXJlIGlucHV0IENsYXNzIEQgbW9ubyBhbXBsaWZpZXIgdGhhdA0KPiA+ICsgIHN1
cHBvcnRzIE1JUEkgU291bmRXaXJlIHYxLjItY29tcGF0aWJsZSBkaWdpdGFsIGludGVyZmFjZSBm
b3INCj4gPiArICBhdWRpbyBhbmQgY29udHJvbCBkYXRhLg0KPiA+ICsgIFNvdW5kV2lyZSBwZXJp
cGhlcmFsIGRldmljZSBJRCBvZiBNQVg5ODM2MyBpcyAweDNYMDE5RjgzNjMwMA0KPiANCj4gbG93
ZXJjYXNlIGhleA0KPiANCj4gPiArICB3aGVyZSBYIGlzIHRoZSBwZXJpcGhlcmFsIGRldmljZSB1
bmlxdWUgSUQgZGVjb2RlZCBmcm9tIHBpbi4NCj4gPiArICBJdCBzdXBwb3J0cyB1cCB0byAxMCBw
ZXJpcGhlcmFsIGRldmljZXMoMHgwIHRvIDB4OSkuDQo+ID4gKw0KPiA+ICthbGxPZjoNCj4gPiAr
ICAtICRyZWY6IGRhaS1jb21tb24ueWFtbCMNCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4g
KyAgY29tcGF0aWJsZToNCj4gPiArICAgIGNvbnN0OiBzZHczMDE5RjgzNjMwMA0KPiANCj4gbG93
ZXJjYXNlIGhleCAoYWxzbyBpbiBleGFtcGxlKQ0KPiANCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+
ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgJyNzb3VuZC1kYWktY2VsbHMnOg0KPiA+
ICsgICAgY29uc3Q6IDANCj4gPiArDQo+ID4gKyAgc291bmQtbmFtZS1wcmVmaXg6IHRydWUNCj4g
DQo+IERyb3AgdGhpcy4NCj4gDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBh
dGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gIiNzb3VuZC1kYWktY2VsbHMiDQo+ID4gKw0K
PiA+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gDQo+IEluc3RlYWQ6DQo+IHVuZXZh
bHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9m
DQoNCg==
