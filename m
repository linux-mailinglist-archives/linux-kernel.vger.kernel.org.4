Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19EE72D9A5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbjFMGJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjFMGJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:09:06 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00449A0;
        Mon, 12 Jun 2023 23:09:04 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D49FRi021802;
        Tue, 13 Jun 2023 02:08:20 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3r4jxbe7ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 02:08:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiD5S5z8+cncjholVXQxD2WGeJb7R5nYmzPxRAedBFpHmPpgzZlxr3Jz5expy7UJe1/WWcLHeG6pHJUg/TO3FjNdmigdcG7obyFf6i+tF71xC0JOXNOLNIiCygR15pt/Pi+xU9kQk5Fp9FoVZEAKKmWSPPdit3cBV2ZB0t5xYX3+60pTpOVa8d5rzhaNGPrA8/hGFKeoWU4fJGbcN7uqb8sqsGNG3LS9KaX/bHENk6RvIsGJO0zngikBA89b1xJImcKUlRniUH1W3+lzJOdt1ZSM8/XbDE+YA743sZXRy8sZCdTRmF9ARJRN+iq+QQKsSzKybc5r6vYh41MIF0Gx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmfnp++IbuLpc2d5nOqZ5cb3MBJRtN3MyRKM/eXlF2g=;
 b=IOJqLI0fHkcJYHiL1feVVWEHU8j0XkqvkS+DaGSmd3iBST435R0RS5BLIjT3VMyhtb7GjjiwcNk5mH4RTYV2URnZhFch6IYifOwna4zJD5/DbhkYd2hajIDluIP7y2K2MlVkbootMzshZBsaAK2dUpY+IV8XMV/k3BNh5Vw2YrQHOsLjOQfVRlSMnpwZRFPUKOAaabU6B1yJLBejERSPrwOALqgJSm5dfWRnxm+8eWfiEuhjWWvU08k+NJlyD4qEh+LfgO4/W/9UeRTcGTIvNv3NE+729CxQG5pOvM53sS5Gwa9TgqS0V20e4LswmJa4Ff5Qtnnlk3Bu5x/SHtJ9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmfnp++IbuLpc2d5nOqZ5cb3MBJRtN3MyRKM/eXlF2g=;
 b=JZw/qMnKKT4OYS7YajrLOaZRQpi4x7MY4hRMYakpqTl7p+HF1qGEP0H5ZuKzZNF1evG4m6o3M1NZi8e+JeSGPSHwQPJnCFnkgUTH3lLD0yHsIOAtNx7mosqnZjReGKwIjjjgEMLOTzel8K7U2BWOgJV6E/CPfscKWjFBMUKuRkc=
Received: from SJ0PR03MB6681.namprd03.prod.outlook.com (2603:10b6:a03:400::6)
 by MW4PR03MB6491.namprd03.prod.outlook.com (2603:10b6:303:123::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 06:08:14 +0000
Received: from SJ0PR03MB6681.namprd03.prod.outlook.com
 ([fe80::4367:b823:eb11:589]) by SJ0PR03MB6681.namprd03.prod.outlook.com
 ([fe80::4367:b823:eb11:589%4]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 06:08:14 +0000
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
CC:     "venkataprasad.potturu@amd.com" <venkataprasad.potturu@amd.com>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH V2 2/2] ASoC: max98388: add amplifier driver
Thread-Topic: [PATCH V2 2/2] ASoC: max98388: add amplifier driver
Thread-Index: AQHZmyxyssvB8yNuCEaomR1+TdvOvq+DxFwAgAPdwKA=
Date:   Tue, 13 Jun 2023 06:08:14 +0000
Message-ID: <SJ0PR03MB6681F237649A1FF0891ACAFB8A55A@SJ0PR03MB6681.namprd03.prod.outlook.com>
References: <20230609234417.1139839-1-ryan.lee.analog@gmail.com>
 <20230609234417.1139839-2-ryan.lee.analog@gmail.com>
 <87d90ade-644c-a45d-ce50-bdeded755b04@linaro.org>
In-Reply-To: <87d90ade-644c-a45d-ce50-bdeded755b04@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jY214bFpURXpYR0Z3Y0dSaGRHRmNjbTloYldsdVoxd3dPV1E0TkRsaU5p?=
 =?utf-8?B?MHpNbVF6TFRSaE5EQXRPRFZsWlMwMllqZzBZbUV5T1dVek5XSmNiWE5uYzF4?=
 =?utf-8?B?dGMyY3RZV05sTmpRMk5HUXRNRGxpTUMweE1XVmxMV0poWTJRdE56QXhZV0k0?=
 =?utf-8?B?TURkbFpHSTVYR0Z0WlMxMFpYTjBYR0ZqWlRZME5qUmxMVEE1WWpBdE1URmxa?=
 =?utf-8?B?UzFpWVdOa0xUY3dNV0ZpT0RBM1pXUmlPV0p2WkhrdWRIaDBJaUJ6ZWowaU1U?=
 =?utf-8?B?UTJORElpSUhROUlqRXpNek14TVRFd01Ea3lPRFF3T1RNM01DSWdhRDBpT0VK?=
 =?utf-8?B?aFYxQkhRamh3YlZkT1IxcGpUbE5VWjI5T1JFOWhkVUpyUFNJZ2FXUTlJaUln?=
 =?utf-8?B?WW13OUlqQWlJR0p2UFNJeElpQmphVDBpWTBGQlFVRkZVa2hWTVZKVFVsVkdU?=
 =?utf-8?B?a05uVlVGQlJXOURRVUZCWVZBelVuWjJXak5hUVZOTlpWTnRMMGx1UVVoaFNY?=
 =?utf-8?B?ZzFTMkk0YVdOQlpHOUVRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVaEJRVUZCUkdGQlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVWQlFWRkJRa0ZCUVVGU05teFVURUZCUVVGQlFVRkJRVUZCUVVGQlFVRktO?=
 =?utf-8?B?RUZCUVVKb1FVZFJRV0ZSUW1aQlNFMUJXbEZDYWtGSVZVRmpaMEpzUVVZNFFX?=
 =?utf-8?B?TkJRbmxCUnpoQllXZENiRUZIVFVGa1FVSjZRVVk0UVZwblFtaEJSM2RCWTNk?=
 =?utf-8?B?Q2JFRkdPRUZhWjBKMlFVaE5RV0ZSUWpCQlIydEJaR2RDYkVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUlVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?blFVRkJRVUZCYm1kQlFVRkhSVUZhUVVKd1FVWTRRV04zUW14QlIwMUJaRkZD?=
 =?utf-8?B?ZVVGSFZVRllkMEozUVVoSlFXSjNRbkZCUjFWQldYZENNRUZJVFVGWWQwSXdR?=
 =?utf-8?B?VWRyUVZwUlFubEJSRVZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFWRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkRRVUZCUVVGQlEyVkJRVUZCV1ZGQ2EwRkhhMEZZZDBKNlFV?=
 =?utf-8?B?ZFZRVmwzUWpGQlNFbEJXbEZDWmtGSVFVRmpaMEoyUVVkdlFWcFJRbXBCU0ZG?=
 =?utf-8?B?QlkzZENaa0ZJVVVGaFVVSnNRVWhKUVUxblFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUpCUVVGQlFVRkJRVUZCU1VGQlFVRkJRVUU5UFNJdlBqd3ZiV1Yw?=
 =?utf-8?Q?YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6681:EE_|MW4PR03MB6491:EE_
x-ms-office365-filtering-correlation-id: 0cab1a17-bcab-443a-6575-08db6bd492f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jMfqP5Uu2VpE+vEX2vGxAJYaMWTPorEPfJ8N52rEp2HJESR1+T5MpbYufvCDNZ00XVViFZn4m4CcF6cvEhQrhkrkxCRt1mNOk0NQPSJzV90NiXTozKduuGMT2OgEL0L3otyRzbTN098e+CETGW8ZW4XnWQqNzgCvbrBOD4kzXX2JPjr9dGgps3nx0Jm+KmIH9e3lBn1WlOfA4wjyevyioLhx9fAo/CqKwudvzSchARE8DHEJxL/QOQiHJWeyXdf2LFfbXL93rmEyvwUR7T/GZ5LogbPmEh2fhs+5k9tbhkRjbo5N4QRGWDwQKWbkfwfkMrzI8tvU6hWnGp4bdWP2BgEm3sN+6tHiCwMZ5yTaDRYub2yGeXfq54askBhY37WaeEEpEAytssg5+5fIEP8BnHj4t/12jj+TmUgDSqqcLgDGZFbrlGTI8m8CIcr+fC6jm/FvY47ETd6u/ESFpp1Mc/7ZhX/x6SiPcTk3LTKNakFt6xJ7Tzu4o5YX0rOcD/CW2RJLG6wAqPPdZc+WmH2Mv3bpwCzYbSZttkVFb6BUiqNpqZoEmWIDzS/rCoJQ27zhP0fh4wmreB+kVADwhC4XjDYyFpt/AAJlxJttlkYZM2me7qc3ACMoHE4DYQBzz2SR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6681.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199021)(966005)(7696005)(316002)(41300700001)(9686003)(26005)(6506007)(7416002)(186003)(2906002)(38070700005)(86362001)(53546011)(33656002)(122000001)(921005)(55016003)(38100700002)(83380400001)(8676002)(52536014)(5660300002)(8936002)(76116006)(66476007)(66946007)(66556008)(478600001)(54906003)(19627235002)(110136005)(4326008)(71200400001)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azVNV3VSdTM4TXRwT2hMajBJWFFCTXFBcUN0c3NaMUlDTDViNkl3QzRuZW5F?=
 =?utf-8?B?dkwxVnhYUmZCRm5MOFkwZEJTaDRhaUhldllCazNPV1paWnVSYS9wazVnV3pE?=
 =?utf-8?B?MzBuS2c2ZWQzOXJsWDNoakkvK09CYXVFZG91b29PSXRSMnlOQ1hERS9iQUJQ?=
 =?utf-8?B?MWg3alVFTFcxMmRCOHo4R3h3MUo2VnpQNjMvOWdyZW5JeGJJVERtSHM5bHVj?=
 =?utf-8?B?bHE2aHk0UmUzRktIbnhuZXdTbDZWVENBTnBGRGxjT2k1NysxQUJUclhtdXJ5?=
 =?utf-8?B?Lyt2VXh3RTZLZGFpTlNRSTlDTDN4REExL3JpQlU0elFaMGx3Y3Zvb05Gbm02?=
 =?utf-8?B?c0J1MC90cWlMb3JqbWFhQ0lBM0dQa1g3VWpWSlpIYlpBSzg4ZzRCemdBTUJm?=
 =?utf-8?B?SDNJemt3K3U3OUQ5RDgrSkRGcHlmL0RiaUU2ZzQxekdqSVpnRkdodjJoUzl0?=
 =?utf-8?B?N0Q2TTRVdTZTck9kZXc3dDV5L2szRTBjUW1ibC9WVTZpQ3dDMFYwNCtzZzdR?=
 =?utf-8?B?dmRIQXVmcUgzcllxOEs5SGRlc1Ayc0VTQmlkTmVvZWh0ZTlmNzJSZURGVFhZ?=
 =?utf-8?B?dko5U1NWODUzWmNLTWxHc0tTaXdIVzJvV0I3QkR4K3RXcVpWUjlOL2x0d3BY?=
 =?utf-8?B?dkhHc2tnWWNhZzZsUzhDeUl4L0tLRnNYTTdmVmpvb01Mc1NHTFNzemh4UTNk?=
 =?utf-8?B?M0wzd1MzbFgxcDlhdG1JbnpZNk9mWWRJRzA0UnF2SnhSMmdkUzhTTzVHcGln?=
 =?utf-8?B?L1dhTnJzZ0FKQy9HWDRRRTAzSEo5Skh0L3QwbmduSDYyb3NOT01ob1FvS3F4?=
 =?utf-8?B?RUZPbTFHTVJGS3JGK29sRmJBOHQrWHN2ZFg1b2VXS0xST2lBMkJPYVpFZGR1?=
 =?utf-8?B?VDgvY0NwelptQ1ZVYXlnSGFjWEdibCsxZE5INkNVaWQ2UHpYOG9Lclg2cWk5?=
 =?utf-8?B?S2JHekVQbGFjYXlvd3JxWG80YmhwZExMb2NFZUZiMEtKa0RZeVZnYm8vQlJJ?=
 =?utf-8?B?MnJqcU44QmF4bnVGQ3FqbEhpU21JVERKYWtsdVZUQmV3cjIvZGk3bGhQaGE5?=
 =?utf-8?B?ZkUrd0t0Y2VtaEdzNEdJcGJsQkNESCtWQTdSZEpLVzl0SEtuMWZld3AwS0ho?=
 =?utf-8?B?YjBOOFBMZ1BURW5qd2FlMGUrcnhLZ0dWdDNtYklPYi92alJpbTJWWGFTcUla?=
 =?utf-8?B?SCtmN0tBU3lCNTdMcjJIZFBJeFlWYUNMSVYyQTczQitDOUJ1cnVEMWtja202?=
 =?utf-8?B?MnJGc0VnVnRoNWM2NUZPRVBBUEpCYzVJV200bE5CNjRwUWNQSWkzSldZU2JW?=
 =?utf-8?B?d1A1K1M1eU1UQXZmazZqRzFoVDNERkdtRjdzelNTbG1JSjFZOG5RY0JXYy9G?=
 =?utf-8?B?UDRLNVZLaWNNYkZMNk9ndmd6ZTNvRlJqd1N0WUk0TXVMTkFJMmpMbzN6NjJp?=
 =?utf-8?B?VjJHbUdsMG1CSUlCbUs4b1UySGJSMENadW95UGRYdy9nZHcwazM3Z3NWRloy?=
 =?utf-8?B?Qjg0VFVwc1JuQ2QwSkNoK3NhT3hXbVJ5eXVhOVhFTWxVUFNpRC9XdHZDdnpo?=
 =?utf-8?B?MHVyTHVMRzVLT1pwQjY1NWgyN2RMejA1aFJuME05aDRWamQ4c2VyZnVJOHVY?=
 =?utf-8?B?Und5dVYyUlR6NE56SlV0bU9YT3hGdVlqNGU0clM0ZkpGbEt0VUo4QUl3bjZL?=
 =?utf-8?B?a0JhR1VtQnNXODJwM3BnTmpsVEZKVUJ6Z3pOWkhIMU1YMmwwYzlwRGVMRVBj?=
 =?utf-8?B?S1FZVnZCOGhqMW9uVVZRMHNocFVkVzE0R045ZitqczFXNFZDanhhajRyNmdR?=
 =?utf-8?B?OXAxSUM2TWgrOHNmdG9wdG9tOTM5SU5nbEtWTnJ4Q0hSUmZ3SytnRDIrQ01z?=
 =?utf-8?B?VFlzVFRQaklNNEYwSWRYTUhsd1FRVDU3VHNmMjE2VWFuTkdxSGR3UWdBOFJM?=
 =?utf-8?B?Z2xpaURCbVdrekg0Ti9xZzZWU2haR2VHMDRWTXZPMzRsUVZsbXQ1eFg0NnY0?=
 =?utf-8?B?QVY5VlRsYTduUDEyL0RJQkQ5bCtoMXZhZVljUGRac1c5ZVAvZHV3NnhMTDho?=
 =?utf-8?B?RG5CS0VHMkNFQU5VQnlhV2FyUkYrcmdtQWhRRis1ak9jd3hTei96bTYxM0Fs?=
 =?utf-8?Q?9WYY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cab1a17-bcab-443a-6575-08db6bd492f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 06:08:14.5263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aj9JpwAVhbsrO+B8eAimJ/9qXYFJAx0HuUh1GbytpqsDLogH7LD8vr2pPitZRm93010SFntcK3Xah5sCqPGdgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6491
X-Proofpoint-GUID: a7N-5emLIVKm_-qV_WxTYvY6vFCoEmyB
X-Proofpoint-ORIG-GUID: a7N-5emLIVKm_-qV_WxTYvY6vFCoEmyB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_03,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130054
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBKdW5l
IDEwLCAyMDIzIDI6MjQgQU0NCj4gVG86IOKAnFJ5YW4gPHJ5YW4ubGVlLmFuYWxvZ0BnbWFpbC5j
b20+OyBsZ2lyZHdvb2RAZ21haWwuY29tOw0KPiBicm9vbmllQGtlcm5lbC5vcmc7IHJvYmgrZHRA
a2VybmVsLm9yZzsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiBwZXJleEBw
ZXJleC5jejsgdGl3YWlAc3VzZS5jb207IHJmQG9wZW5zb3VyY2UuY2lycnVzLmNvbTsgTGVlLCBS
eWFuUw0KPiA8UnlhblMuTGVlQGFuYWxvZy5jb20+OyB3YW5nd2VpZG9uZy5hQGF3aW5pYy5jb207
DQo+IHNodW1pbmdmQHJlYWx0ZWsuY29tOyBoZXJ2ZS5jb2RpbmFAYm9vdGxpbi5jb207DQo+IGNr
ZWVwYXhAb3BlbnNvdXJjZS5jaXJydXMuY29tOyBkb3VnQHNjaG1vcmdhbC5jb207DQo+IGFqeWVf
aHVhbmdAY29tcGFsLmNvcnAtcGFydG5lci5nb29nbGUuY29tOyBraXNlb2suam9AaXJvbmRldmlj
ZS5jb207DQo+IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiB2ZW5rYXRh
cHJhc2FkLnBvdHR1cnVAYW1kLmNvbTsga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMi8yXSBBU29DOiBtYXg5ODM4ODogYWRkIGFtcGxp
ZmllciBkcml2ZXINCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIDEwLzA2LzIwMjMgMDE6NDQs
IOKAnFJ5YW4gd3JvdGU6DQo+ID4gRnJvbTogUnlhbiBMZWUgPHJ5YW5zLmxlZUBhbmFsb2cuY29t
Pg0KPiA+DQo+ID4gQWRkZWQgQW5hbG9nIERldmljZXMgTUFYOTgzODggYW1wbGlmaWVyIGRyaXZl
ci4NCj4gPiBNQVg5ODM4OCBwcm92aWRlcyBhIFBDTSBpbnRlcmZhY2UgZm9yIGF1ZGlvIGRhdGEg
YW5kIGEgc3RhbmRhcmQgSTJDDQo+ID4gaW50ZXJmYWNlIGZvciBjb250cm9sIGRhdGEgY29tbXVu
aWNhdGlvbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gTGVlIDxyeWFucy5sZWVAYW5h
bG9nLmNvbT4NCj4gPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5j
b20+DQo+IA0KPiBUaGVyZSBpcyBub3RoaW5nIHRvIHJlcG9ydCBoZXJlLg0KUHJvYmFibHkgSSBt
aXN1bmRlcnN0b29kIHRoZSBtYWlsIGZyb20gdGhlIGtlcm5lbCB0ZXN0IHJvYm90Lg0KUmVtb3Zp
bmcgdGhlIGxpbmUuDQoNCj4gDQo+ID4gQ2xvc2VzOg0KPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5j
b20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVpbGQtYWxsLzIwMjMNCj4gPiAw
NjA4MjA1NC5qSVU5b0VOZi0NCj4gbGtwQGludGVsLmNvbS9fXzshIUEzTmk4Q1MweTJZITQ2c0hp
QXNtSWlYeFpfUVhJb2Jobw0KPiA+IG1ZOEYxZjdGMnlNWWRfNjVOTkZ3UmxjZ3V0MzMtLVJkRmpW
QWJnNmpLZjdWczhHYVlaN29BJA0KPiANCj4gTm90aGluZyB0byBjbG9zZSBhbmQgYWxzbyBicm9r
ZW4gbGluay4gRml4IHlvdXIgbWFpbGVyLg0KPiANCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGZyb20g
djE6DQo+ID4gICBGaXhlZCBidWlsZCB3YXJuaW5ncy4NCj4gPg0KPiA+ICBzb3VuZC9zb2MvY29k
ZWNzL0tjb25maWcgICAgfCAgIDEwICsNCj4gPiAgc291bmQvc29jL2NvZGVjcy9NYWtlZmlsZSAg
IHwgICAgMiArDQo+ID4gIHNvdW5kL3NvYy9jb2RlY3MvbWF4OTgzODguYyB8IDEwNDINCj4gPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBzb3VuZC9zb2MvY29kZWNz
L21heDk4Mzg4LmggfCAgMjM0ICsrKysrKysrDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMTI4OCBp
bnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvY29kZWNzL21h
eDk4Mzg4LmMgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IHNvdW5kL3NvYy9jb2RlY3MvbWF4OTgz
ODguaA0KPiANCj4gLi4uDQo+IA0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgbWF4OTgzODhfcmVh
ZF9kZXZlaWNlX3Byb3BlcnR5KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiArCQkJCQkgICBzdHJ1
Y3QgbWF4OTgzODhfcHJpdiAqbWF4OTgzODgpIHsNCj4gPiArCWludCB2YWx1ZTsNCj4gPiArDQo+
ID4gKwlpZiAoIWRldmljZV9wcm9wZXJ0eV9yZWFkX3UzMihkZXYsICJhZGksdm1vbi1zbG90LW5v
IiwgJnZhbHVlKSkNCj4gPiArCQltYXg5ODM4OC0+dl9zbG90ID0gdmFsdWUgJiAweEY7DQo+ID4g
KwllbHNlDQo+ID4gKwkJbWF4OTgzODgtPnZfc2xvdCA9IDA7DQo+ID4gKw0KPiA+ICsJaWYgKCFk
ZXZpY2VfcHJvcGVydHlfcmVhZF91MzIoZGV2LCAiYWRpLGltb24tc2xvdC1ubyIsICZ2YWx1ZSkp
DQo+ID4gKwkJbWF4OTgzODgtPmlfc2xvdCA9IHZhbHVlICYgMHhGOw0KPiA+ICsJZWxzZQ0KPiA+
ICsJCW1heDk4Mzg4LT5pX3Nsb3QgPSAxOw0KPiA+ICsNCj4gPiArCWlmIChkZXZpY2VfcHJvcGVy
dHlfcmVhZF9ib29sKGRldiwgImFkaSxpbnRlcmxlYXZlLW1vZGUiKSkNCj4gPiArCQltYXg5ODM4
OC0+aW50ZXJsZWF2ZV9tb2RlID0gdHJ1ZTsNCj4gPiArCWVsc2UNCj4gPiArCQltYXg5ODM4OC0+
aW50ZXJsZWF2ZV9tb2RlID0gZmFsc2U7DQo+ID4gKw0KPiA+ICsJaWYgKGRldi0+b2Zfbm9kZSkg
ew0KPiA+ICsJCW1heDk4Mzg4LT5yZXNldF9ncGlvID0gb2ZfZ2V0X25hbWVkX2dwaW8oZGV2LT5v
Zl9ub2RlLA0KPiA+ICsJCQkJCQkJICJyZXNldC1ncGlvIiwgMCk7DQo+IA0KPiBOb3BlLCB1c2Ug
ZGV2bQ0KT0suDQoNCj4gDQo+ID4gKwkJaWYgKCFncGlvX2lzX3ZhbGlkKG1heDk4Mzg4LT5yZXNl
dF9ncGlvKSkgew0KPiA+ICsJCQlkZXZfZXJyKGRldiwgIkxvb2tpbmcgdXAgJXMgcHJvcGVydHkg
aW4gbm9kZSAlcw0KPiBmYWlsZWQgJWRcbiIsDQo+ID4gKwkJCQkicmVzZXQtZ3BpbyIsIGRldi0+
b2Zfbm9kZS0+ZnVsbF9uYW1lLA0KPiA+ICsJCQkJbWF4OTgzODgtPnJlc2V0X2dwaW8pOw0KPiA+
ICsJCX0gZWxzZSB7DQo+ID4gKwkJCWRldl9kYmcoZGV2LCAicmVzZXQtZ3Bpbz0lZCIsDQo+ID4g
KwkJCQltYXg5ODM4OC0+cmVzZXRfZ3Bpbyk7DQo+ID4gKwkJfQ0KPiA+ICsJfSBlbHNlIHsNCj4g
PiArCQkvKiB0aGlzIG1ha2VzIHJlc2V0X2dwaW8gYXMgaW52YWxpZCAqLw0KPiA+ICsJCW1heDk4
Mzg4LT5yZXNldF9ncGlvID0gLTE7DQo+IA0KPiBXaHk/IFRvIHJlcXVlc3QgaXQgYWdhaW4/IEl0
IGRvZXMgbm90IG1ha2Ugc2Vuc2UuDQoNClRoaXMgd2FzIHRvIG1ha2UgZ3Bpb19pc192YWxpZCgp
ID0gZmFsc2UgaW4gb3JkZXIgdG8gc2tpcCB0aGUgcmVzZXQgR1BJTyBjb250cm9sIGluIGkyY19w
cm9iZSgpLg0KSSBzaGFsbCByZW1vdmUgdGhlc2UgY29kZXMgYW5kIGtlZXAgdGhlIG1pbmltdW0g
Y29uZmlndXJhdGlvbiBpbiBpMmNfcHJvYmUoKSBmdW5jdGlvbi4NCg0KPiANCj4gPiArCX0NCj4g
PiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBtYXg5ODM4OF9pMmNfcHJvYmUoc3RydWN0IGky
Y19jbGllbnQgKmkyYykgew0KPiA+ICsJaW50IHJldCA9IDA7DQo+ID4gKwlpbnQgcmVnID0gMDsN
Cj4gPiArDQo+ID4gKwlzdHJ1Y3QgbWF4OTgzODhfcHJpdiAqbWF4OTgzODggPSBOVUxMOw0KPiA+
ICsNCj4gPiArCW1heDk4Mzg4ID0gZGV2bV9remFsbG9jKCZpMmMtPmRldiwgc2l6ZW9mKCptYXg5
ODM4OCksDQo+IEdGUF9LRVJORUwpOw0KPiA+ICsNCj4gDQo+IERyb3AgYmxhbmsgbGluZS4NCk9L
Lg0KDQo+IA0KPiA+ICsJaWYgKCFtYXg5ODM4OCkgew0KPiA+ICsJCXJldCA9IC1FTk9NRU07DQo+
IA0KPiByZXR1cm4gLUVOT01FTTsNCk9LLg0KDQo+IA0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4g
Kwl9DQo+ID4gKwlpMmNfc2V0X2NsaWVudGRhdGEoaTJjLCBtYXg5ODM4OCk7DQo+ID4gKw0KPiA+
ICsJLyogcmVnbWFwIGluaXRpYWxpemF0aW9uICovDQo+ID4gKwltYXg5ODM4OC0+cmVnbWFwID0g
ZGV2bV9yZWdtYXBfaW5pdF9pMmMoaTJjLA0KPiAmbWF4OTgzODhfcmVnbWFwKTsNCj4gPiArCWlm
IChJU19FUlIobWF4OTgzODgtPnJlZ21hcCkpIHsNCj4gPiArCQlyZXQgPSBQVFJfRVJSKG1heDk4
Mzg4LT5yZWdtYXApOw0KPiA+ICsJCWRldl9lcnIoJmkyYy0+ZGV2LA0KPiA+ICsJCQkiRmFpbGVk
IHRvIGFsbG9jYXRlIHJlZ21hcDogJWRcbiIsIHJldCk7DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4g
DQo+IHJldHVybiBkZXZfZXJyX3Byb2JlDQpPSy4gU2hhbGwgZml4IGl0Lg0KDQo+IA0KPiA+ICsJ
fQ0KPiA+ICsNCj4gPiArCS8qIHZvbHRhZ2UvY3VycmVudCBzbG90ICYgZ3BpbyBjb25maWd1cmF0
aW9uICovDQo+ID4gKwltYXg5ODM4OF9yZWFkX2RldmVpY2VfcHJvcGVydHkoJmkyYy0+ZGV2LCBt
YXg5ODM4OCk7DQo+ID4gKw0KPiA+ICsJLyogUG93ZXIgb24gZGV2aWNlICovDQo+ID4gKwlpZiAo
Z3Bpb19pc192YWxpZChtYXg5ODM4OC0+cmVzZXRfZ3BpbykpIHsNCj4gDQo+IFdoYXQncyB0aGlz
PyBZb3UgcmVxdWVzdCBpdCB0d2ljZT8gTm8uDQpXaWxsIG1vZGlmeSB0aGUgY29kZS4NCg0KPiAN
Cj4gDQo+ID4gKwkJcmV0ID0gZGV2bV9ncGlvX3JlcXVlc3QoJmkyYy0+ZGV2LCBtYXg5ODM4OC0+
cmVzZXRfZ3BpbywNCj4gPiArCQkJCQkiTUFYOTgzODhfUkVTRVQiKTsNCj4gPiArCQlpZiAocmV0
KSB7DQo+ID4gKwkJCWRldl9lcnIoJmkyYy0+ZGV2LCAiJXM6IEZhaWxlZCB0byByZXF1ZXN0IGdw
aW8gJWRcbiIsDQo+ID4gKwkJCQlfX2Z1bmNfXywgbWF4OTgzODgtPnJlc2V0X2dwaW8pOw0KPiAN
Cj4gcmV0dXJuIGRldl9lcnJfcHJvYmUNCk9LDQoNCj4gDQo+ID4gKwkJCXJldHVybiAtRUlOVkFM
Ow0KPiA+ICsJCX0NCj4gPiArCQlncGlvX2RpcmVjdGlvbl9vdXRwdXQobWF4OTgzODgtPnJlc2V0
X2dwaW8sIDApOw0KPiA+ICsJCW1zbGVlcCg1MCk7DQo+ID4gKwkJZ3Bpb19kaXJlY3Rpb25fb3V0
cHV0KG1heDk4Mzg4LT5yZXNldF9ncGlvLCAxKTsNCj4gDQo+IDEgbWVhbnMga2VlcCBpbiByZXNl
dCwgc28gd2h5IGRvIHlvdSBrZWVwIGRldmllYyByZXNldCBhZnRlcndhcmRzPyBXYXMgaXQNCj4g
dGVzdGVkPyBZb3UgcHJvYmFibHkgbWVzc2VkIHVwIHZhbHVlcyB1c2VkIGZvciBHUElPcyBhcyB5
b3Ugc3RhdGVkIGluDQo+IGV4YW1wbGUgdGhhdCBpdCBpcyBhY3RpdmUgbG93Lg0KVGhlIGhhcmR3
YXJlIHJlc2V0IGZ1bmN0aW9uIGlzIGFjdGl2ZSBsb3csIHNvIHRoZSBzdGF0ZSBuZWVkcyB0byBi
ZSBoaWdoIHRvIHJlc3RhcnQgdGhlIGFtcC4NClRoZSBjb2RlIHdhcyBmdW5jdGlvbmFsLCBidXQg
SSBzZWUgcm9vbSBmb3IgaW1wcm92ZW1lbnQuIEkgc2hhbGwgbW9kaWZ5IHRoZSBjb2RlLg0KDQo+
IA0KPiA+ICsJCW1zbGVlcCgyMCk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJLyogUmVhZCBSZXZp
c2lvbiBJRCAqLw0KPiA+ICsJcmV0ID0gcmVnbWFwX3JlYWQobWF4OTgzODgtPnJlZ21hcCwNCj4g
PiArCQkJICBNQVg5ODM4OF9SMjJGRl9SRVZfSUQsICZyZWcpOw0KPiA+ICsJaWYgKHJldCA8IDAp
IHsNCj4gPiArCQlkZXZfZXJyKCZpMmMtPmRldiwNCj4gPiArCQkJIkZhaWxlZCB0byByZWFkOiAw
eCUwMlhcbiIsDQo+IE1BWDk4Mzg4X1IyMkZGX1JFVl9JRCk7DQo+ID4gKwkJcmV0dXJuIHJldDsN
Cj4gDQo+IHJldHVybiBkZXZfZXJyX3Byb2JlDQpPSy4NCg0KPiANCj4gPiArCX0NCj4gPiArCWRl
dl9pbmZvKCZpMmMtPmRldiwgIk1BWDk4Mzg4IHJldmlzaW9uSUQ6IDB4JTAyWFxuIiwgcmVnKTsN
Cj4gPiArDQo+ID4gKwkvKiBjb2RlYyByZWdpc3RyYXRpb24gKi8NCj4gPiArCXJldCA9IGRldm1f
c25kX3NvY19yZWdpc3Rlcl9jb21wb25lbnQoJmkyYy0+ZGV2LA0KPiA+ICsJCQkJCSAgICAgICZz
b2NfY29kZWNfZGV2X21heDk4Mzg4LA0KPiA+ICsJCQkJCSAgICAgIG1heDk4Mzg4X2RhaSwNCj4g
PiArCQkJCQkgICAgICBBUlJBWV9TSVpFKG1heDk4Mzg4X2RhaSkpOw0KPiA+ICsJaWYgKHJldCA8
IDApDQo+ID4gKwkJZGV2X2VycigmaTJjLT5kZXYsICJGYWlsZWQgdG8gcmVnaXN0ZXIgY29kZWM6
ICVkXG4iLCByZXQpOw0KPiA+ICsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+
ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaTJjX2RldmljZV9pZCBtYXg5ODM4OF9pMmNfaWRbXSA9
IHsNCj4gPiArCXsgIm1heDk4Mzg4IiwgMH0sDQo+ID4gKwl7IH0sDQo+ID4gK307DQo+ID4gKw0K
PiA+ICtNT0RVTEVfREVWSUNFX1RBQkxFKGkyYywgbWF4OTgzODhfaTJjX2lkKTsNCj4gPiArDQo+
ID4gKyNpZiBkZWZpbmVkKENPTkZJR19PRikNCj4gDQo+IERyb3ANCk9LIFRoYW5rcy4NCg0KPiAN
Cj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbWF4OTgzODhfb2ZfbWF0Y2hb
XSA9IHsNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAiYWRpLG1heDk4Mzg4IiwgfSwNCj4gPiArCXsg
fQ0KPiA+ICt9Ow0KPiA+ICtNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBtYXg5ODM4OF9vZl9tYXRj
aCk7ICNlbmRpZg0KPiA+ICsNCj4gPiArI2lmZGVmIENPTkZJR19BQ1BJDQo+IA0KPiBEcm9wDQpP
Sy4NCg0KPiANCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBhY3BpX2RldmljZV9pZCBtYXg5ODM4
OF9hY3BpX21hdGNoW10gPSB7DQo+ID4gKwl7ICJBRFM4Mzg4IiwgMCB9LA0KPiA+ICsJe30sDQo+
ID4gK307DQo+ID4gK01PRFVMRV9ERVZJQ0VfVEFCTEUoYWNwaSwgbWF4OTgzODhfYWNwaV9tYXRj
aCk7ICNlbmRpZg0KPiA+ICsNCj4gPiArc3RhdGljIHN0cnVjdCBpMmNfZHJpdmVyIG1heDk4Mzg4
X2kyY19kcml2ZXIgPSB7DQo+ID4gKwkuZHJpdmVyID0gew0KPiA+ICsJCS5uYW1lID0gIm1heDk4
Mzg4IiwNCj4gPiArCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9wdHIobWF4OTgzODhfb2Zf
bWF0Y2gpLA0KPiA+ICsJCS5hY3BpX21hdGNoX3RhYmxlID0gQUNQSV9QVFIobWF4OTgzODhfYWNw
aV9tYXRjaCksDQo+IA0KPiBKdXN0IGRyb3AgYWxsIHdyYXBwZXJzLiBUaGV5IGFyZSB1c2VsZXNz
IGFuZCBvbmx5IGxpbWl0IHlvdXIgZHJpdmVyIChPRiBjYW4gYmUNCj4gdXNlZCBvbiBzb21lIEFD
UEkgcGxhdGZvcm1zKS4NCkkgc2hhbGwgcmVtb3ZlIGFsbCB3cmFwcGVycy4NClRoYW5rcyBmb3Ig
dGhlIHJldmlldy4NCg0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
