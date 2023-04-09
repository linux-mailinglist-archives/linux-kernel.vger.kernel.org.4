Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E929B6DC05A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 16:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjDIOZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 10:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDIOZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 10:25:56 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9807359D;
        Sun,  9 Apr 2023 07:25:54 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3398HJgT011916;
        Sun, 9 Apr 2023 10:25:45 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3pu567m7e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Apr 2023 10:25:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pxp2yvvNX/M01EHtx+/OPH9IkJYVNkLP5AAtLV9yh4H0I+NU0Skwv6o0adJ8qbuLEkPptXi/VaHbg1Y0xwS2ewp9uWw1bzABc3N1T4MS38CT4B/pDYCf04w+2ZxOxOLKVAHawxq+mh/REqDA7geJpMdnScKXf2OQ3cQn1kE42uQvHU4pWpAVWbEVWuWbnfwT6dicR2/jtMZb5w444U/aQPzFqpuvCEcK6XNc6Od9e8/bUu0b6dPrljKc2s31Vh9ftSlN1sfe/+JPH7YX3YVagO/WMSgN1EyT4jhlojc67FR0/fRtFu98UNTSISr3g32ov9zhX+B0AN0mjigS0abwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRwhQkNm1J0jnf1ruphaH63rKla4+LH1DekhXeVytNo=;
 b=mvWGxMSdBI+MG0RyV0BBm+pWuMDKaIkyEIau7yM5lgwAAjhAPlaw04x8buu3Ca28Isf/r3E1p3+VgGHC4tmRgtGHUTY40QOEGs90K8t+x2FvTQ3KvBfE4dYzvgpDYrGrp3AqnBy4HQOAoYiVHL2i0KxVp9SbfetTUechn2UFZ5NCOvubPkHbEqVYJTh84rhV1V4l7REpe131DqyDVU0CUUyLiYh8B8ZthdDOZaDJ97kX89UPEBzMgWs1cgUSbBC4uCsHbXI3bI3NIgdX4G97cYEuNEgdi5wbUS0VjpAzVUczhvkisj08/HMlOG3WtAFEw00dyv6mUDg2ssw8ui7cGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRwhQkNm1J0jnf1ruphaH63rKla4+LH1DekhXeVytNo=;
 b=5uXzdkkYo377tHAUdJ+LGuMZKWOTTz8Tk39yuHffMfx5T40sUCOh2tO5J7rrT6swQipFLVEASig9jE9wMnNN8C0NSAR/IPmDnkBeRWDw2ZetENmX5WkJRzLLFDzCtnZQACXVePHTELLRcdSn1dguu16VKZeJ8S2ee5WHjymUn2w=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by SJ2PR03MB7111.namprd03.prod.outlook.com (2603:10b6:a03:4f4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Sun, 9 Apr
 2023 14:25:42 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::8f99:7745:fa5d:3dea]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::8f99:7745:fa5d:3dea%4]) with mapi id 15.20.6277.038; Sun, 9 Apr 2023
 14:25:41 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Walle <michael@walle.cc>
CC:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] gpio: ds4520: Add ADI DS4520 Regulator Support
Thread-Topic: [PATCH v1 2/2] gpio: ds4520: Add ADI DS4520 Regulator Support
Thread-Index: AQHZYKxFzu/viFi84UyZMktWpJEoz68UqJ8AgAaZoUCAAX9AgIAACimAgAMiPoCAAFCPgIACysWA
Date:   Sun, 9 Apr 2023 14:25:40 +0000
Message-ID: <MN2PR03MB516879DCD6600827AEE2BDC9E7949@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20230327130010.8342-1-okan.sahin@analog.com>
 <20230327130010.8342-3-okan.sahin@analog.com>
 <CACRpkda5G5b+At5s1WFudpQBQ6LDQxhE3fZj7eBhkZ=thvnQhg@mail.gmail.com>
 <MN2PR03MB51682210CADA6E33FB99052CE7939@MN2PR03MB5168.namprd03.prod.outlook.com>
 <CACRpkdZJA0DyzgLxm9HFeHO03rqNUff=avuV=VrGuJkkOg6wNQ@mail.gmail.com>
 <25e1fda4b6df2d10444d7eca3cd0e387@walle.cc>
 <CACRpkdYKEid8-0-7sBECNgSyW3kMRCsv3DeBVUzxo4z6p+Grnw@mail.gmail.com>
 <ZDBivYlwJ6zgaFTg@surfacebook>
In-Reply-To: <ZDBivYlwJ6zgaFTg@surfacebook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYjJ0aGJpNXpZV2hwYmx4aGNIQmtZWFJoWEhKdllXMXBibWRjTURsa09E?=
 =?utf-8?B?UTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdKaE1qbGxNelZpWEcx?=
 =?utf-8?B?elozTmNiWE5uTFRZMVpXTTJOVGhrTFdRMlpUSXRNVEZsWkMxaVpXTTFMVEEw?=
 =?utf-8?B?TjJKallqVmhZekEwT0Z4aGJXVXRkR1Z6ZEZ3Mk5XVmpOalU0Wmkxa05tVXlM?=
 =?utf-8?B?VEV4WldRdFltVmpOUzB3TkRkaVkySTFZV013TkRoaWIyUjVMblI0ZENJZ2Mz?=
 =?utf-8?B?bzlJalExT0RRaUlIUTlJakV6TXpJMU5USXpPVE00T1RRek9EazVNU0lnYUQw?=
 =?utf-8?B?aWVXbGFOREJrYTNwMVJYVTBOREYxZFdobUwyd3hVRmRIUW5GQlBTSWdhV1E5?=
 =?utf-8?B?SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJRVUZGVWtoVk1WSlRV?=
 =?utf-8?B?bFZHVGtOblZVRkJSVzlEUVVGQlVGcEZVVzgzTW5KYVFWbFJMMmhpYXpOSUwy?=
 =?utf-8?B?azFhRVFyUm5WVVkyWXJUR3RFUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVWhCUVVGQlJHRkJVVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVVkJRVkZCUWtGQlFVRlJaR2xyTlZGQlFVRkJRVUZCUVVGQlFVRkJR?=
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
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|SJ2PR03MB7111:EE_
x-ms-office365-filtering-correlation-id: 70f9ab51-72f9-4ecd-2e19-08db39064bfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hbo7YpEq6nyRTO31FW/DKPbqCxArLST+9YbFsdIn5Rsq+is/b4UxPLwMNA8+fQEdosKV/8N3fjA49/lsyGI6GK9qMCrWBLD10ygByablrbAL20B3v0k/llno7rOw9+qaGONvsHfg4IQG5TjBcXXjpVfAInQ37kumlkgfJo7I+e7K6wLcxjDy82mrYODdw3MQ0NVJxfMxm3FrVqFCdTIpbfhKKm+ebPnUvWC+QWtAvKCM3wyX5yJkelJ0nmSTuELs1whBHydjtfOfPkQE5uUY12/lQ6wJb5Zxq23ti12qnj07uzi5jGd3bKoMMmXPTL/vWBxprYZ2vC5A64fFvHtk6pz2wkI2qtx5DBzCpg4fdk6Cxue/qnYr3Yi+/6OVvHftFt3QHHnFoR2hjifp33sVhkBSMiGonLqflZ7tnaS0s0jzLhVtQKCEfcrvlhK6SxPUMAGGoSsKhXb1mwQ4wXnScDbEBk8Jwmx6/OQ2L7XNnkKlk3H5gtk+yxZmW7TVGOEgDE1EZsfOcZJ7Y4rDuzG9jLiCE0pWAhkg0UhvAcNKvhIbEa+flr/hLqix49cDEab98kdJUVQ/2GIQv4yLs89afcwrLsoHJ1Vm1VVb5899U5o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(55016003)(8936002)(52536014)(7696005)(966005)(5660300002)(86362001)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(8676002)(4326008)(478600001)(33656002)(38100700002)(38070700005)(316002)(110136005)(122000001)(54906003)(2906002)(53546011)(71200400001)(6506007)(9686003)(26005)(83380400001)(41300700001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlRRQ0dzN1VCczV0cFJNRU92OWxEOW1lNzFCd0toV0ttWGRuSHRTUDlhcmdQ?=
 =?utf-8?B?bXB6U0hld1ZJUTdiNHZCdW1JOFVPRmVqTXFwSHFNOTdtNXp2WklpeXp1ZnpD?=
 =?utf-8?B?L0dSNmxFZnlTZDVmb21oNWJuRWg3aDFMaWs3cTg5WDZ1YVR0OTlreUxncWdL?=
 =?utf-8?B?QVM2N3lVWUh4UG1QMGwwaXMwV2syMzlWOEVlcUd4SDJUQkpYS2xXUTFKQUdT?=
 =?utf-8?B?U0V5NFRLaUVQVHd2MkMraVRhUk44WmQva3Y4Vm80Zy9SUTRUemF4SG5LZUpq?=
 =?utf-8?B?WnVXZThkMXd0d01EREpWTFRIczd5azUwSkRCMk5zYmZRYm1NWk5PREdobC9h?=
 =?utf-8?B?N2ZZM2gzMkE0VWl5QjhtRzdISFQ0OGc1OXpDdXArc3pVTmpzZ3ZHWUJaM01T?=
 =?utf-8?B?elFjOEdnWUk3d1V6OHlWdzBWellFaHY0R3pPRjNPaDhCZm80MGluUzQxVjY3?=
 =?utf-8?B?a1cvK3lwcjJtbnN5YXFHd250SDdZRHp0NDQxUm9XU1pub3pKQVlHeTdXUm8x?=
 =?utf-8?B?R2FSQitqYkRzOUJSeDhUZXBHcWcwVVpVMVUwUXp4NzErM3Z6VXRSRUtXOUM2?=
 =?utf-8?B?eVV1VUJtenFMWDZxVFowVFdET24ySmNEc2VQK1orVGV5MTdnejRRN0hXemVR?=
 =?utf-8?B?dzVuMjZkRFdoRHBvNEhieStESmM1MGUzcDZwOFc0Y3R1bEEwZHA4TlVId1pn?=
 =?utf-8?B?WDBUcUFQZjlTL2xLRFpOS2diZEQ3UGkvbHJBV0NrblZkeDFKeUdUcHlBbWpV?=
 =?utf-8?B?ck9XSjB5RVBCV0h6L0tJNWVhQ3YxdElMOW96RDRrWkZZWjNOSlgrRS9ibFpV?=
 =?utf-8?B?eVpDVlV2TjNyZU1waG0rcmpQMS9SeS9IVTcyVUlGYXQ2MUQrRHFDOWRiN0ts?=
 =?utf-8?B?WHhvb1dhcTJOS0psZG4yVk8xZ3BPd3JDQ2plcGR5dkZHSUlCZldTVklMYjJ1?=
 =?utf-8?B?ZGwxcUNiRmw1SElQazRpNElEaHo5cWRTU3ZmalVwZzBJWVJIdDhVbUdsRlRS?=
 =?utf-8?B?QnBVUUhyYU93RGNZOUtWbHU0NWdQRGp3V09CWHdyajhYYlE4aTZSUjk0UWZY?=
 =?utf-8?B?bHNCQ2lZV3RjQzM4b1RRdVFXblVnaWRhTGxQc0FaREpsYkhyM05GK3AvcHB5?=
 =?utf-8?B?N1M1Zk9kTkZFYlh5bURUYVRiY3p1eWVoUGg1ZDBvTHp1NFJNWjlaVVFtSWQv?=
 =?utf-8?B?bng5UllvbXp4MXdMaEFseG9uTE1zMm5ydGlFWFUrUENXL0NkVEpmUm8wdUhO?=
 =?utf-8?B?RC9nV2s0cENTTU83S0Y0dGQzZDVqbjQvL0k1Ym5zdVZobzBYbVZFL2Q0c05I?=
 =?utf-8?B?VlFHM3hkNlA4UlBxeDc2VEhrQzFxUDNDQkVDaytsTzlwQ0o2MlM5QjNSR2lr?=
 =?utf-8?B?d0d3ZVRrQy94bTNzV0ZsVlJWd1g0NThvcXU2L012aUdITUd5R0h1NkZFc0ZN?=
 =?utf-8?B?RUZhVFo1U3F5emJzTmtIUkgzK1pvVmx4U2JrVFREVEFlbUtTN25mdENyaGRF?=
 =?utf-8?B?VEFqdlJNa05aRnRCUURNVEppR3g5am0yMWlhVHQ1NmJxNEZzaytrMzBnNGpm?=
 =?utf-8?B?K3JGY3FVWERXcHRJT1V3Zjd2NkdBV0o0ZlR0dnBHcE9aa2t4aFQ3Zjdydlow?=
 =?utf-8?B?S0xOR3R3VjZaUkdhMWxCalB6WGNPOG9saXY1SGRZV004UFUramw1bEpIcm5H?=
 =?utf-8?B?NzhrVlNQM1BEb1UxQUNXQ2VXR3ozZXV4YTg5c0JTVmpmYTdtQ2R5ZjRlRGtQ?=
 =?utf-8?B?MTZKdDA5czFpd09IbVFZZVNBZ2o5R2hWUjZrYmIzcFhocEc2cW02cllHUnJw?=
 =?utf-8?B?RVRLYmxLZTFJM1lJRnFRQnQvTDV6L1lGSUJGRHZ1aFQrRUxhSzIyRHNNYWlC?=
 =?utf-8?B?U3ltdEZmRGc1UkZTWGVGK2ZHRzAvRURHTUk5YlBIQkxFSy81QzByR3pwUGVS?=
 =?utf-8?B?WmxkYXRjcllVb2RZQ01sWWJuQlhrRm5FRk12MDJBc3JuanlDWGpaWUw1VldN?=
 =?utf-8?B?MmhQdFROUnZJeXhiS0hVemJSOXNMSVFXMzFtQ1ZyMEZPNHk0dkc1TWF5L3Jo?=
 =?utf-8?B?d2taODBCRTQyU0NXZzdUWkFGVGJEYVVsT0xsNUNPS0dsbXB5NFdaSmpwNnd1?=
 =?utf-8?Q?4uwdUzhcg75XhUCoyOcqI3onu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f9ab51-72f9-4ecd-2e19-08db39064bfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2023 14:25:41.0235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hVsHAWiUzil1N7aapDqlSzk8TlX9I3cSpWokJ8HPZKmfvrv9YnTer44BweaWewze/iAq3d6slpvp8SDhB2cytQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7111
X-Proofpoint-GUID: o7A8XYVlpaLzrcVvLEowP6cE2Je05sel
X-Proofpoint-ORIG-GUID: o7A8XYVlpaLzrcVvLEowP6cE2Je05sel
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-09_09,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=943 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304090130
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyaSwgQXByIDA3LCAyMDIzIGF0IDAzOjQ4OjI1UE0gKzAyMDAsIExpbnVzIFdhbGxlaWoga2ly
am9pdHRpOg0KPj4gT24gV2VkLCBBcHIgNSwgMjAyMyBhdCAzOjU34oCvUE0gTWljaGFlbCBXYWxs
ZSA8bWljaGFlbEB3YWxsZS5jYz4gd3JvdGU6DQo+Pg0KPj4gPiBPVE9IIEknbSBub3Qgc3VyZSB0
aGUgZHJpdmVyIGlzIGRvaW5nIGl0IGNvcnJlY3RseSwgYmVjYXVzZSBpdCBhbHNvDQo+PiA+IHNl
ZW1zIHRvIHN3aXRjaCB0aGUgcHVsbHVwIHJlc2lzdGVycyB0b2dldGhlciB3aXRoIHRoZSBkaXJl
Y3Rpb24uDQo+PiA+IEknbSBub3Qgc3VyZSB0aGF0IGlzIGNvcnJlY3QuIFNvIHRoZXJlIG1pZ2h0
IGJlIGp1c3Qgb25lIHJlZ2lzdGVyDQo+PiA+IGludm9sdmVkIGFmdGVyIGFsbCBhbmQgdGhlIEdQ
SU9fUkVHTUFQIHNob3VsZCB3b3JrIGFnYWluLg0KPj4NCj4+IEknbSBwcmV0dHkgc3VyZSB0aGF0
IHNob3VsZCBiZSBpbiB0aGUgLnNldF9jb25maWcoKSBjYWxsYmFjay4NCj4+DQo+PiA+IEFsc28s
IGFjY29yZGluZyB0byB0aGUgZGF0YXNoZWV0IHRoaXMgaGFzIHNvbWUgbnYgbWVtb3J5ICh0byBz
ZXQgdGhlDQo+PiA+IGluaXRpYWwgc3RhdGUgb2YgdGhlIEdQSU9zIFs/XSkuIFNvIGl0IHNob3Vs
ZCByZWFsbHkgYmUgYQ0KPj4gPiBtdWx0aS1mdW5jdGlvbiBkZXZpY2UuIEknbSBub3Qgc3VyZSBp
ZiB0aGlzIGhhcyB0byBiZSBjb25zaWRlcmVkDQo+PiA+IHJpZ2h0IGZyb20gdGhlIGJlZ2lubmlu
ZyBvciBpZiB0aGUgZGV2aWNlIHN1cHBvcnQgY2FuIHN0YXJ0IHdpdGgNCj4+ID4gR1BJTyBvbmx5
IGFuZCBsYXRlciBiZSB0cmFuc2l0aW9uZWQgdG8gYSBmdWxsIGZlYXR1cmVkIE1GRCAocHJvYmFi
bHkgd2l0aCBudm1lbQ0KPnN1cHBvcnQpLg0KPj4NCj4+IFRoYXQncyBhIGJpdCBvZiBhIHNvZnQg
ZGVmaW5pdGlvbi4NCj4+DQo+PiBJZiB0aGUgY2hpcCBpcyAqb25seSogZG9pbmcgR1BJTyBhbmQg
bnZyYW0gaXQgY2FuIGJlIGEgR1BJTy1vbmx5DQo+PiBkZXZpY2UgSSB0aGluay4NCj4+DQo+PiBU
aGUgcHJlY2VkZW50IGlzIGEgdG9uIG9mIGV0aGVybmV0IGRyaXZlcnMgd2l0aCBudnJhbSBmb3Ig
c3RvcmluZyBlLmcuDQo+PiB0aGUgTUFDIGFkZHJlc3MuIFdlIGRvbid0IG1ha2UgYWxsIG9mIHRo
b3NlIGludG8gTUZEcywgYXMgdGhlIG52cmFtIGlzDQo+PiBjbG9zZWx5IHRpZWQgdG8gdGhlIG9u
ZSBhbmQgb25seSBmdW5jdGlvbiBvZiB0aGUgYmxvY2suDQo+DQo+SSBhZ3JlZSB3aXRoIExpbnVz
LiBUaGlzIHNob3VsZCBiZSBwYXJ0IG9mIHRoZSBhY3R1YWwgKG1haW4pIGRyaXZlciBmb3IgdGhl
IGNoaXAgYXMgbWFueQ0KPmRvIChsaWtlIFVTQiB0byBzZXJpYWwgYWRhcHRlcnMgdGhhdCBoYXZl
IEdQSU8gY2FwYWJpbGl0eSkuDQo+QWxzbyB0aGlzIGNvZGUgbGFja3Mgb2YgcHJvcGVyIGxvY2tp
bmcgYW5kIGhhcyBzdHlsZSBpc3N1ZXMuDQo+DQo+LS0NCj5XaXRoIEJlc3QgUmVnYXJkcywNCj5B
bmR5IFNoZXZjaGVua28NCj4NCg0KSGkgTGludXMsDQoNCkkgdGhpbmsgZ3Bpb19yZWdtYXAgaXMg
bm90IHN1aXRhYmxlIGZvciB0aGlzIGRyaXZlciBhcyBNaWNoYWVsIHN0YXRlZC4gDQpodHRwczov
L3d3dy5hbmFsb2cuY29tL21lZGlhL2VuL3RlY2huaWNhbC1kb2N1bWVudGF0aW9uL2RhdGEtc2hl
ZXRzL2RzNDUyMC5wZGYNClBsZWFzZSBjaGVjayBibG9jayBkaWFncmFtLiBUaGVyZSBhcmUgdHdv
IGlucHV0IHJlZ2lzdGVycyB0aGF0IGNvbnRyb2wgZ3BpbyBzdGF0ZQ0Kc28gZ3Bpb19yZWdtYXAg
ZG9lcyBub3QgbG9vayBvayBmb3IgdGhpcy4gQW0gSSBtaXNzaW5nIHNvbWV0aGluZz8NCg0KSGkg
TWljaGFlbCwNCg0KSSB0ZXN0ZWQgZHJpdmVyIGZvciBib3RoIHdyaXRpbmcgYW5kIHJlYWRpbmcs
IGl0IHNlZW1zIGZpbmUuIEluaXRpYWxseSwgdGhpcyBxdWVzdGlvbg0KY29uZnVzZWQgbWUgdG9v
LCBidXQgYWZ0ZXIgZXhhbWluaW5nIG90aGVyIGRyaXZlcnMgd2l0aCBudm1lbSwgbXkgb3Bpbmlv
biBpcyANCnNhbWUgYXMgYm90aCBMaW51cyBhbmQgQW5keS4gQWxzbywgYXQgdGhpcyBwb2ludCBJ
IGFtIG5vdCBwbGFubmluZyB0byBhZGQNCm52bWVtIHN1cHBvcnQuDQoNCkhpIEFuZHksDQoNCkNv
dWxkIHlvdSBnaXZlIG1vcmUgZGV0YWlsIHJlbGF0ZWQgdG8gbG9ja2luZyBhbmQgc3R5bGUgaXNz
dWVzPw0KDQpSZWdhcmRzLA0KT2thbiBTYWhpbg0K
