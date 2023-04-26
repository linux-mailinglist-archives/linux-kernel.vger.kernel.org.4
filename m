Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCFC6EF36D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 13:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240476AbjDZL21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 07:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240422AbjDZL2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 07:28:25 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D324C30CA;
        Wed, 26 Apr 2023 04:28:23 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QAV9cO016858;
        Wed, 26 Apr 2023 07:28:12 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3q4c797ad2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 07:28:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REwChcl8wHfzVNks7P+AH3VktD3g9cVxvHlfoscl95AsbTCXOMYj/HTskuNkJMIhMBszZeF4Gez6eiFdu7RMR5Mr2pwaFmwXNn7OLNRNotjq7dNTTXQbO3tfDaCRd1lALKytg8kFPV/BZyboXCIZowpscTL/q8FGJeiiAQSt9lGIhWLKtO7sD5qUXqJHtzI1oxLZYOT4CcTwEktoHxXKcmHuSBClfNBYJpE9sVGkmktVIUAYxo0/pTXDhFMeWkAHk0a1PfqYSqo7Z1mFOLETWcDwfNs9b7uTORdwHPgi8yyEGl7o3FrynIrxietUfBMYi2x/mtQRijrUYXrVVjbNHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hAHc09qvwenCCreVxUXDz0KJEO1bOMMXbWkKkUD37k=;
 b=keZMuzhcTfuiIkKk/6VFDRiPd5saAvjenYGGELvXMT2bluEEZkTniVvuUQnap6f1Z1sswozNIuM1VhKxQYV6ao15lRC3VuNMgB/Lo6S+qWxB7RfQQWsDvpu5fdwIFeu9yZWa7dUOLzMVu1icAEzcUlBDPXwCdF5My6JS2TMUognQZVKd6h/HiwaP0m8eCgrTRE61eyMIn88BTRpVVA1ROEoRkp6ARjz++FRkR6Qp+FXM0g+k/1CKbFOh3sV5qrx1t1mGt3OSFSWJRVlqqzzINHtzYpiWQTDy+gQKH1oGSkBOMoLGEt+tGAgxuhZSX6Doax946jrsPZsFNIJIT3+WXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hAHc09qvwenCCreVxUXDz0KJEO1bOMMXbWkKkUD37k=;
 b=AoSaEiFg9Hv7GPU9SrDp9PSZcjXV5tDn8f6gKss8uqRyWvtSJTiicI0Jr87VBR2mbmEkC9qQqt4wscniBNnueOhLNlCG4XhO2XA0Jg4sbXFTPKwWCYbUF8zWS63M3XepJguMMU3GsSnZldn55Z1V3MH7bE4J9LKg5sHYal6b93w=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by SA2PR03MB5834.namprd03.prod.outlook.com (2603:10b6:806:f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 11:28:10 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::8f99:7745:fa5d:3dea]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::8f99:7745:fa5d:3dea%4]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 11:28:10 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Michael Walle <michael@walle.cc>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] gpio: ds4520: Add ADI DS4520 Regulator Support
Thread-Topic: [PATCH v1 2/2] gpio: ds4520: Add ADI DS4520 Regulator Support
Thread-Index: AQHZYKxFzu/viFi84UyZMktWpJEoz68UqJ8AgAaZoUCAAX9AgIAACimAgAMiPoCAAFCPgIACysWAgAMsY4CAFH9pMIABEksAgAHWFgA=
Date:   Wed, 26 Apr 2023 11:28:10 +0000
Message-ID: <MN2PR03MB5168689A20C8D6C67F119BB7E7659@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20230327130010.8342-1-okan.sahin@analog.com>
 <20230327130010.8342-3-okan.sahin@analog.com>
 <CACRpkda5G5b+At5s1WFudpQBQ6LDQxhE3fZj7eBhkZ=thvnQhg@mail.gmail.com>
 <MN2PR03MB51682210CADA6E33FB99052CE7939@MN2PR03MB5168.namprd03.prod.outlook.com>
 <CACRpkdZJA0DyzgLxm9HFeHO03rqNUff=avuV=VrGuJkkOg6wNQ@mail.gmail.com>
 <25e1fda4b6df2d10444d7eca3cd0e387@walle.cc>
 <CACRpkdYKEid8-0-7sBECNgSyW3kMRCsv3DeBVUzxo4z6p+Grnw@mail.gmail.com>
 <ZDBivYlwJ6zgaFTg@surfacebook>
 <MN2PR03MB516879DCD6600827AEE2BDC9E7949@MN2PR03MB5168.namprd03.prod.outlook.com>
 <a3ca3e705b5b8668cd511fc15681c75f@walle.cc>
 <MN2PR03MB5168D7940E322DFC0A1A3148E7679@MN2PR03MB5168.namprd03.prod.outlook.com>
 <1ff70a97dfbcaddd69029001ce99bb69@walle.cc>
In-Reply-To: <1ff70a97dfbcaddd69029001ce99bb69@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYjJ0aGJpNXpZV2hwYmx4aGNIQmtZWFJoWEhKdllXMXBibWRjTURsa09E?=
 =?utf-8?B?UTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdKaE1qbGxNelZpWEcx?=
 =?utf-8?B?elozTmNiWE5uTFRaaE9HRTJOamxsTFdVME1qVXRNVEZsWkMxaVpXTmtMVFU0?=
 =?utf-8?B?Tm1NeU5XUXpZek5sTkZ4aGJXVXRkR1Z6ZEZ3MllUaGhOalpoTUMxbE5ESTFM?=
 =?utf-8?B?VEV4WldRdFltVmpaQzAxT0Raak1qVmtNMk16WlRSaWIyUjVMblI0ZENJZ2Mz?=
 =?utf-8?B?bzlJamcxTkRJaUlIUTlJakV6TXpJMk9UZ3lNRGc0TURrM01UYzJOU0lnYUQw?=
 =?utf-8?B?aU0wOXBXQzkxVmtoS2FXeGlhekpaVlhsMU9URmtXR2xhUlVaQlBTSWdhV1E5?=
 =?utf-8?B?SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJRVUZGVWtoVk1WSlRV?=
 =?utf-8?B?bFZHVGtOblZVRkJSVzlEUVVGRU1UVXJUWE5OYm1wYVFWUnpjU3R1U1VJemMy?=
 =?utf-8?B?eElUM2x5Tm1OblNHVjVWV05FUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVWhCUVVGQlJHRkJVVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVVkJRVkZCUWtGQlFVRlRha1ZZZUhkQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZLTkVGQlFVSm9RVWRSUVdGUlFtWkJTRTFCV2xGQ2FrRklWVUZqWjBKc1FV?=
 =?utf-8?B?WTRRV05CUW5sQlJ6aEJZV2RDYkVGSFRVRmtRVUo2UVVZNFFWcG5RbWhCUjNk?=
 =?utf-8?B?QlkzZENiRUZHT0VGYVowSjJRVWhOUVdGUlFqQkJSMnRCWkdkQ2JFRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlJVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRm5RVUZCUVVGQmJtZEJRVUZIUlVGYVFVSndRVVk0UVdOM1FteEJSMDFC?=
 =?utf-8?B?WkZGQ2VVRkhWVUZZZDBKM1FVaEpRV0ozUW5GQlIxVkJXWGRDTUVGSVRVRllk?=
 =?utf-8?B?MEl3UVVkclFWcFJRbmxCUkVWQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VkZCUVVGQlFVRkJRVUZEUVVGQlFVRkJRMlZCUVVGQldWRkNhMEZIYTBGWWQw?=
 =?utf-8?B?SjZRVWRWUVZsM1FqRkJTRWxCV2xGQ1prRklRVUZqWjBKMlFVZHZRVnBSUW1w?=
 =?utf-8?B?QlNGRkJZM2RDWmtGSVVVRmhVVUpzUVVoSlFVMW5RVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVKQlFVRkJRVUZCUVVGQlNVRkJRVUZCUVVFOVBTSXZQand2?=
 =?utf-8?Q?bWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|SA2PR03MB5834:EE_
x-ms-office365-filtering-correlation-id: 3263858d-9bd4-43ee-ba60-08db464950a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 90e6R7o5lKVoIxC72d4yuBR+bODtHQbYajDksFGG5cZUOq0i/T3IZ6NM33SJcbRaFVup2QTcEV8VYBjxOGwHlisGtXVNWtktHTeyfiJcftdTocARt6+d/qiW5yIjLSFykw8q82JUe5WOvZsH6tPRMI6zaxEuGMqo0KSw6BJVgjv+f8Hxt4wmy5W48qFWK3chZH3bQG3Qf9RArBY8swX0vis9khYTUlEWPdzRYUtwvFBshY6evFGGNynLcdMxjzrSIZzkiIcp2dMAT19sHWdmUwqRMBWb1ydvxwuIxAVJJVUcwgIKaPfmcIHSbCfS8OFKe8Dmi4+eTsvS41ps2FkJYusDE3Ht/rp5c+JeDq+9kbtZYLKSTGIHdjOpTeDf7vGedZsI4NmWyIS0cE098DBmDlvcXOZK1sahH1xCEVZndFDRjkBfqimelAMqkccoDibmA2RsO3WyMy5BMYUchNWxyUHL4HTRpMYy3j4EMD2fQ3mlt/O6fI8NgUQvPcMHaqbIxAhIL6kqHVy6eS8/YjO6fUNhkhSs9hGXc8a2mKLZrbtb9UKGXQRLqndM+mJRAlgAiobWl+Uaz/A4BF3L02NNY05MBFg+7MBaCY7VIwm6iVE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199021)(33656002)(86362001)(55016003)(54906003)(478600001)(7696005)(71200400001)(966005)(8936002)(38100700002)(122000001)(8676002)(41300700001)(66476007)(64756008)(66946007)(76116006)(66556008)(66446008)(6916009)(316002)(4326008)(83380400001)(186003)(53546011)(26005)(6506007)(9686003)(2906002)(38070700005)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTcvV3hTM1NFZnFrNHFxaXhOTUxrNEkrOWFHK2UzMGV3dVNLelROb2habzRz?=
 =?utf-8?B?SUwyNFlUMnB4VGhEdjFoT1k4dllUaDVxNUJ1cW1iRHk5aGxtc0dVaERLRTBk?=
 =?utf-8?B?NGhjVC9OS2psblJpZU5KcHE2NGZTMUx4WmJGSVpWSUYxYmovTy9FUTJYK2Zk?=
 =?utf-8?B?MzV5YUcxVjIvdUtNY3hWTFdLWSsybFFJdDRoOXdFT3RlVlRRK0tFU2RMNFBm?=
 =?utf-8?B?bjk2ajB5cW5vY1I5NEJzVjFYQytmS0hrbjFLRVk0eG1jNXY2bGFvZ0k0MUxY?=
 =?utf-8?B?b1hZRmlRU0M5ZzlwRERoeFFjNDFHR3JxQjJzcDBOd01ibEJVbHVxSUFvOTJG?=
 =?utf-8?B?dVlMYk40Y1U5elBrR3M1SUIwaDRyTlk1OTJUaE5WaUJSemN5ZVpOdnVzNXZW?=
 =?utf-8?B?MUtWeElOQlF1OEtmdGpxbm1nQmtERWFKYnNZbWlHMGJxME1HMzN0cU5wZm9o?=
 =?utf-8?B?WFBrRW9DTTZ4WHU0Z2V4bWhMRWhjaThLbDQ4VEFYQlpITTFML3lrTWdQK3FN?=
 =?utf-8?B?Y3JIZmJPdXl1SUFRbHhOaFl5VFlnOXlDU3FDcGtZTlpDMmxaSHV2bWs4a1hM?=
 =?utf-8?B?WXhOU0VpODQzK1h3Z1VNZUJYVFFCeXBTSmx4ZE5iNVlVQUp4SWVoS0lWRE1z?=
 =?utf-8?B?NHZQbHEzSjRQMlpzWEcrVFdVRmdjRHpRejJGRjZ6VTZHcEkxVzhrMVVDWjY4?=
 =?utf-8?B?eU1DWCtJc3d3RGxKTFExVkVYeklUcHJyRjhycUNsZUlnYzV6WWtEd0Z6cGNn?=
 =?utf-8?B?TGxjWkg1ekZFL01GUXl0UzJxU2RNNVRXMjBONDRubndyWXJkY1hSY0VLaUtu?=
 =?utf-8?B?UHVld3U0bmJxZFNCT0xuQ3ZWUHNBaGhTZHZBYjFnNnJMbncrbWhHanRZaUxs?=
 =?utf-8?B?QTAyYWtLS3IwSkhYeTdHZTIrQUltOGludXRic20wY2huZGVnOTdtTVVubnNT?=
 =?utf-8?B?ZHlLM0J5bmZXaVpZcFZHelBGZnpxS25HdFdCanlUNnN2Z0xzaFgrSC9xZ01m?=
 =?utf-8?B?VHdsQ2QyNHNndmpvNHBzdEZMU21ZTkxZNWtMN3RTNXhmUWJYMVlDWUszL3VR?=
 =?utf-8?B?MkY1Sis1eWJiTnJyWk9xdkJCVE51NkhBaFp2VE5EMUtHem5GVVpyUHhMNjdQ?=
 =?utf-8?B?VnNHQXZKeE96aExrdGtHVyt4Q0t3VUtTUUdvdk1GcUVWQXlnWGJWcEdHcld2?=
 =?utf-8?B?MGZnZnZMdVZTZCtqU21LR2tGMzk0dEk4Rlp1bnNESXpoRExRMkUzaUl3Vkcv?=
 =?utf-8?B?UlJoTEdVZ0hubjdwa1EwQnJ1anMvWnlCMEJSc2hyZlpyOWtYK1pOYXRhMG0w?=
 =?utf-8?B?OW9QY3NnZFBuWHpZNDlhZHZTN3M5UHBjWUpyREczenZZNmxJeTR2eXRzVGho?=
 =?utf-8?B?a1BKNi9ZQ1Z4NVdmKzg3SVFCdW5uME1DdVluU3FvTVhQc3lLUVJJWENUODVG?=
 =?utf-8?B?TTZyRThTaDNVNVM4YmlXcFkzdkJUL3U5eEU4ei9sTURBc2pURHQ0M3JLQ3ln?=
 =?utf-8?B?OHRtcHpsUHVFT1NYaUQzQzVIcFpKdzRxUXRHeWJPb0ZzSE82VWZFcXo0cmc3?=
 =?utf-8?B?aTJ2UUEwOW9xeDNyWWFTaUVrekpPZTUxTUhqZXQzRkdzWnozb2NPdkdwLzgx?=
 =?utf-8?B?b1NYT0tSdGdFN2RiUWlxMG9NSHp2SDJiNkpBYmQvZXU3eTdadk1FeUxoaW45?=
 =?utf-8?B?aFVkcUc5UnlDNC9KVlpGcHFDdndFUnpUV0UySG9VbjBFSjcvdDB3d2NSa3lH?=
 =?utf-8?B?REpIN2RiN2YvVTE2MGQ3Z1FqRHRNaTBjTEpQU0kveXo2L1YveXRKTk5YUkQ3?=
 =?utf-8?B?c3FTL0NKSTdCVkhuLzB4Rjk5eFpraU84NWF1cTMvSUhOZlpnSFVHcU5UeGFx?=
 =?utf-8?B?QStFc1Q5S0VaLzRtSy9OWEdORUdWVnZvQ3h4KzBLcEFBMU9ncjV4M0tWcSsx?=
 =?utf-8?B?cjdyakZ1Q2E5VDk3REFGK29Hd28xVWVteWtpbXB3a1FVMlBJVnAyemordmNi?=
 =?utf-8?B?UktTZVpqd2k0ZnQxSitORjF4MzFZSXU5QTdlT3JCMlVUSjlSN09IbHc0NWZY?=
 =?utf-8?B?VTc1aGVNcFpJYmxEUjUrVkl4NDE0RFNqSmlzaGNzSXF2N1VFdFhCQWRWbktt?=
 =?utf-8?Q?tQyoaShT01n51NtZaZGJ0DJNs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3263858d-9bd4-43ee-ba60-08db464950a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 11:28:10.2485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RI6oI3q2g3zwxJ3krTgnRsR53etI2aF9n04SLARXc6Lc1WPHOzK43wiF6ZAjFI23yAbBSchSxEEJyU4g5u4XEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5834
X-Proofpoint-ORIG-GUID: udRtNVPhRmHgVZSP4PZoaJGEu6XyTXkm
X-Proofpoint-GUID: udRtNVPhRmHgVZSP4PZoaJGEu6XyTXkm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_04,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304260102
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkFtIDIwMjMtMDQtMjQgMTc6MzksIHNjaHJpZWIgU2FoaW4sIE9rYW46DQo+Pj4gQW0gMjAyMy0w
NC0wOSAxNjoyNSwgc2NocmllYiBTYWhpbiwgT2thbjoNCj4+Pj4+IEZyaSwgQXByIDA3LCAyMDIz
IGF0IDAzOjQ4OjI1UE0gKzAyMDAsIExpbnVzIFdhbGxlaWoga2lyam9pdHRpOg0KPj4+Pj4+IE9u
IFdlZCwgQXByIDUsIDIwMjMgYXQgMzo1N+KAr1BNIE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2Fs
bGUuY2M+DQo+Pj4+Pj4gd3JvdGU6DQo+Pj4+Pj4NCj4+Pj4+PiA+IE9UT0ggSSdtIG5vdCBzdXJl
IHRoZSBkcml2ZXIgaXMgZG9pbmcgaXQgY29ycmVjdGx5LCBiZWNhdXNlIGl0IGFsc28NCj4+Pj4+
PiA+IHNlZW1zIHRvIHN3aXRjaCB0aGUgcHVsbHVwIHJlc2lzdGVycyB0b2dldGhlciB3aXRoIHRo
ZSBkaXJlY3Rpb24uDQo+Pj4+Pj4gPiBJJ20gbm90IHN1cmUgdGhhdCBpcyBjb3JyZWN0LiBTbyB0
aGVyZSBtaWdodCBiZSBqdXN0IG9uZSByZWdpc3Rlcg0KPj4+Pj4+ID4gaW52b2x2ZWQgYWZ0ZXIg
YWxsIGFuZCB0aGUgR1BJT19SRUdNQVAgc2hvdWxkIHdvcmsgYWdhaW4uDQo+Pj4+Pj4NCj4+Pj4+
PiBJJ20gcHJldHR5IHN1cmUgdGhhdCBzaG91bGQgYmUgaW4gdGhlIC5zZXRfY29uZmlnKCkgY2Fs
bGJhY2suDQo+Pj4+Pj4NCj4+Pj4+PiA+IEFsc28sIGFjY29yZGluZyB0byB0aGUgZGF0YXNoZWV0
IHRoaXMgaGFzIHNvbWUgbnYgbWVtb3J5ICh0byBzZXQgdGhlDQo+Pj4+Pj4gPiBpbml0aWFsIHN0
YXRlIG9mIHRoZSBHUElPcyBbP10pLiBTbyBpdCBzaG91bGQgcmVhbGx5IGJlIGENCj4+Pj4+PiA+
IG11bHRpLWZ1bmN0aW9uIGRldmljZS4gSSdtIG5vdCBzdXJlIGlmIHRoaXMgaGFzIHRvIGJlIGNv
bnNpZGVyZWQNCj4+Pj4+PiA+IHJpZ2h0IGZyb20gdGhlIGJlZ2lubmluZyBvciBpZiB0aGUgZGV2
aWNlIHN1cHBvcnQgY2FuIHN0YXJ0IHdpdGgNCj4+Pj4+PiA+IEdQSU8gb25seSBhbmQgbGF0ZXIg
YmUgdHJhbnNpdGlvbmVkIHRvIGEgZnVsbCBmZWF0dXJlZCBNRkQgKHByb2JhYmx5IHdpdGgNCj4+
PiBudm1lbQ0KPj4+Pj4gc3VwcG9ydCkuDQo+Pj4+Pj4NCj4+Pj4+PiBUaGF0J3MgYSBiaXQgb2Yg
YSBzb2Z0IGRlZmluaXRpb24uDQo+Pj4+Pj4NCj4+Pj4+PiBJZiB0aGUgY2hpcCBpcyAqb25seSog
ZG9pbmcgR1BJTyBhbmQgbnZyYW0gaXQgY2FuIGJlIGEgR1BJTy1vbmx5DQo+Pj4+Pj4gZGV2aWNl
IEkgdGhpbmsuDQo+Pj4+Pj4NCj4+Pj4+PiBUaGUgcHJlY2VkZW50IGlzIGEgdG9uIG9mIGV0aGVy
bmV0IGRyaXZlcnMgd2l0aCBudnJhbSBmb3Igc3RvcmluZw0KPj4+Pj4+IGUuZy4NCj4+Pj4+PiB0
aGUgTUFDIGFkZHJlc3MuIFdlIGRvbid0IG1ha2UgYWxsIG9mIHRob3NlIGludG8gTUZEcywgYXMg
dGhlIG52cmFtDQo+Pj4+Pj4gaXMNCj4+Pj4+PiBjbG9zZWx5IHRpZWQgdG8gdGhlIG9uZSBhbmQg
b25seSBmdW5jdGlvbiBvZiB0aGUgYmxvY2suDQo+Pj4+Pg0KPj4+Pj4gSSBhZ3JlZSB3aXRoIExp
bnVzLiBUaGlzIHNob3VsZCBiZSBwYXJ0IG9mIHRoZSBhY3R1YWwgKG1haW4pIGRyaXZlcg0KPj4+
Pj4gZm9yIHRoZSBjaGlwIGFzIG1hbnkNCj4+Pj4+IGRvIChsaWtlIFVTQiB0byBzZXJpYWwgYWRh
cHRlcnMgdGhhdCBoYXZlIEdQSU8gY2FwYWJpbGl0eSkuDQo+Pj4NCj4+PiBZb3UgbWVhbiB0aGUg
Z3BpbyBkcml2ZXIgaXMgY2FsbGluZyBudm1lbV9yZWdpc3RlcigpPyBZZWFoIEkgYWdyZWUsDQo+
Pj4gdGhhdA0KPj4+IHNob3VsZCB3b3JrLg0KPj4+DQo+Pj4+IEkgdGhpbmsgZ3Bpb19yZWdtYXAg
aXMgbm90IHN1aXRhYmxlIGZvciB0aGlzIGRyaXZlciBhcyBNaWNoYWVsDQo+Pj4+IHN0YXRlZC4N
Cj4+Pj4gaHR0cHM6Ly93d3cuYW5hbG9nLmNvbS9tZWRpYS9lbi90ZWNobmljYWwtZG9jdW1lbnRh
dGlvbi9kYXRhLQ0KPj4+IHNoZWV0cy9kczQ1MjAucGRmDQo+Pj4+IFBsZWFzZSBjaGVjayBibG9j
ayBkaWFncmFtLiBUaGVyZSBhcmUgdHdvIGlucHV0IHJlZ2lzdGVycyB0aGF0DQo+Pj4+IGNvbnRy
b2wNCj4+Pj4gZ3BpbyBzdGF0ZQ0KPj4+PiBzbyBncGlvX3JlZ21hcCBkb2VzIG5vdCBsb29rIG9r
IGZvciB0aGlzLiBBbSBJIG1pc3Npbmcgc29tZXRoaW5nPw0KPj4+DQo+Pj4gWW91IG1lYW4gRjgv
Rjk/IFRoYXQgd2lsbCB3b3JrIGFzIHRoZXkgYXJlIGZvciBkaWZmZXJlbnQgR1BJT3MuIFdoYXQN
Cj4+PiBkb2Vzbid0IHdvcmsgd2l0aCBncGlvLXJlZ21hcCBpcyB3aGVuIHlvdSBuZWVkIHRvIG1v
ZGlmeSB0d28gZGlmZmVyZW50DQo+Pj4gcmVnaXN0ZXJzIGZvciBvbmUgR1BJTy4gSGF2ZSBhIGxv
b2sgYXQgZ3Bpb19yZWdtYXBfZ2V0KCkgYW5kDQo+Pj4gZ3Bpb19yZWdtYXBfc2V0KCkuIElmIHRo
ZSBkZWZhdWx0IGdwaW9fcmVnbWFwX3NpbXBsZV94bGF0ZSgpIGRvZXNuJ3QNCj4+PiB3b3JrDQo+
Pj4geW91IGNhbiB1c2UgeW91ciBvd24gLnhsYXRlKCkgb3AuDQo+Pj4NCj4+DQo+PiBBY3R1YWxs
eSwgSSBjaGVja2VkIHRoZSBmdW5jdGlvbnMgdGhhdCB5b3Ugc3VnZ2VzdGVkLCBidXQgYXMgZmFy
IGFzIEkNCj4+IHVuZGVyc3RhbmQNCj4+IHRoZXkgbWlnaHQgd29yayBpZiB0aGVyZSB3b3VsZCBi
ZSBvbmUgYml0IHRvIHNldCBkaXJlY3Rpb24gb3IgdmFsdWUuDQo+PiBIb3dldmVyLA0KPj4gdGhp
cyBpcyBub3QgdGhlIGNhc2UgZm9yIGRzNDUyMC4gSW4gb3RoZXIgd29yZHMsIGlmIEkgd2FudCB0
byBzZXQgdGhlDQo+PiBncGlvIGRpcmVjdGlvbg0KPj4gYXMgb3V0cHV0LCBJIG5lZWQgdG8gc2V0
IGEgY29ycmVzcG9uZGluZyBiaXQgZm9yIGJvdGggRjAgYW5kIEYxDQo+PiByZWdpc3RlcnMuDQo+
DQo+SSBjYW4ndCBmb2xsb3cuIEYwL0YxIGlzIGZvciB0aGUgcHVsbC11cC4gVGhhdCB3YXMgYWN0
dWFsbHkgbXkgaW5pdGlhbA0KPnF1ZXN0aW9uIGFuZCBMaW51cyBzYWlkLCB0aGF0IHNob3VsZCBw
cm9iYWJseSBiZSBkb25lIGluIGEgc2VwZXJhdGUNCj4uc2V0X2NvbmZpZyBvcGVyYXRpb24gbm90
IHRvZ2V0aGVyIHdpdGggYSBkaXJlY3Rpb24gY2hhbmdlLg0KDQpJIHRoaW5rIEkgdW5kZXJzdGFu
ZCB3aGF0IHlvdSBhcmUgdHJ5aW5nIHRvIHNheSBzbyBmYXIuIEkgZGlkIG5vdCBoYXZlIHRvbyBt
dWNoDQpleHBlcmllbmNlIHJlbGF0ZWQgdG8gZ3Bpby4gSSB3aWxsIHNldCBwdWxsX3VwIHJlZ2lz
dGVyIGluIC5zZXRfY29uZmlnDQpIb3dldmVyLCBJIGRpZCBub3QgdW5kZXJzdGFuZCB3aGVyZSBp
dHMgcGFyYW1ldGVycyBjb21lIGZyb20uDQpzZXRfY29uZmlnKHN0cnVjdCBncGlvX2NoaXAgKmNo
aXAsIHVuc2lnbmVkIGludCBvZmZzZXQsDQoJICAgICAgdW5zaWduZWQgbG9uZyBjb25maWcpDQpJ
dCBtaWdodCBiZSB0cml2aWFsIHF1ZXN0aW9uLCBidXQgV2hlcmUgZG9lcyBjb25maWcgY29tZSBm
cm9tPw0KDQpBdCB0aGUgZW5kLCBJIHNob3VsZCByZXdyaXRlIHRoZSBjb2RlIHVzaW5nIHJlZ21h
cF9ncGlvLCByaWdodD8gU28gaWYgSSByZXdyaXRlIA0KY29kZSB1c2luZyByZWdtYXBfZ3Bpbywg
aG93IGNhbiBJIHJlcGxhY2Ugc2V0X2NvbmZpZyguLi4pPw0KDQo+DQo+PiBJbiB0aGUgZG9jdW1l
bnQsIHlvdSBjYW4gc2VlIGJsb2NrIGRpYWdyYW0uIEkgZG8gbm90IGtub3cgd2h5LCBidXQNCj4+
IGRlc2lnbiBpcw0KPj4gbm90IHN0YW5kYXJkIHRoYXTigJlzIHdoeSBJIHRoaW5rIEkgY2FuIG5v
dCB1c2UgZ3Bpby1yZWdtYXAuDQo+Pg0KPj4+PiBBbHNvLCBhdCB0aGlzIHBvaW50IEkgYW0gbm90
IHBsYW5uaW5nIHRvIGFkZCBudm1lbSBzdXBwb3J0Lg0KPj4+DQo+Pj4gVGhhdCBpcyBhIHBpdHks
IGJlY2F1c2UgdGhhdCBpcyB0aGUgd2hvbGUgdXNlIGNhc2UgZm9yIHRoaXMgZ3Bpbw0KPj4+IGV4
cGFuZGVyLA0KPj4+IG5vPyAiUHJvZ3JhbW1hYmxlIFJlcGxhY2VtZW50IGZvciBNZWNoYW5pY2Fs
IEp1bXBlcnMgYW5kIFN3aXRjaGVzIg0KPj4NCj4+IEkgY2FuIHNldCAiU0VFIiBiaXQgYXMgIjAi
IGluIHRoZSBDb25maWd1cmF0aW9uIFJlZ2lzdGVyIHRvIHdyaXRlDQo+PiBFRVBST00gc28gaXQg
bWlnaHQgc29sdmUNCj4+IGlzc3VlLg0KPg0KPklmIHlvdSBkbyB0aGF0IHVuY29uZGl0aW9uYWxs
eSwgdGhhdCBtaWdodCB3ZWFyIG91dCB0aGUgRUVQUk9NLA0KPnRob3VnaC4NCj4NCj4tbWljaGFl
bA0KDQpIaSBNaWNoYWVsLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgc3VwcG9ydC4NCg0KUmVnYXJk
cywNCk9rYW4gU2FoaW4NCg==
