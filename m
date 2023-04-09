Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586596DC0BE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 18:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDIQto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 12:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjDIQtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 12:49:21 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37BC40C5;
        Sun,  9 Apr 2023 09:49:07 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 339FoWfd010927;
        Sun, 9 Apr 2023 12:48:39 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3pu567mku3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Apr 2023 12:48:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShIIy+bDHb729kicMk4+OpuKSfFNpRUNg/TmSAw4Y7GGzkBIrZWF0lsiZ5R4OK6wVDQnJogR15vq/tietvkm6bmBxcPHRD1RJPtl/chml668w7vIc4eKPAc8rCpW8V45PLsa3bXRkPbJ2tjBAe+UUD/TYLz0EcBEZ4et9eivB8WOZY6IaskyDquAJeOxQs5GdTgy64gPk5eXlGiX8OV3Ke1vP0YXkKT38Yv4X7klzJz1XR5p0IvB6OTCTUaxfZlycPZdxgEZb82hFL2yZ4TUkxyOlJiCjIBU5VJk4UXCT4BgeGeupxeuUXzy0jjQiKbG8Tb09HRwGgTZLWFZvBhLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbT9wsY07K5xgToP3LKJKXOEYpXEbkzfX4O51xUU88U=;
 b=ds4CYfly/G3AR7CPuwcBspakj55PgMM0nprQr+QVOONFP3BKyHrdL042QqyLmhxUfMeVxGMydpsgsaGv0D8ZzOTNYDM5JBKsCvb2pvpIzsRlMecQkTyhOOysSkKBo4mkF/2vsL3qori0+serarGm5ITmHXEmeKbSOoQWrMA4HuMgOsYORQAOlJaw5Nh8paoYHROJ1TtQIJGQR8xBpGSAJtqNBQ9e/r0St+JmAfZfh2hTnONdMU0fbE15SUAARy2k/jpggTjEAXPEByYTHxVi++NA41YFtBT1QOl8Wf8mNgbFI2h/pf+O94FPgiIUIO4XW4sfkggeSyKKwCqydUDFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbT9wsY07K5xgToP3LKJKXOEYpXEbkzfX4O51xUU88U=;
 b=P+qkYXCsHsO23UolagBLj7gUJ9HNzRrxXQuzE54tPqUTv6rjEPF1E9+cRspfaccm2zbp85DdxgMwPNqsIbHZ2py0RUtWWVr058V+BsVWls9FDlxVTkL9B+3St0eeV2ZgzjQNZHRq/MEuieh10ETS+1JBRZsjp6vZFhna75vPfdE=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by SA1PR03MB7099.namprd03.prod.outlook.com (2603:10b6:806:330::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Sun, 9 Apr
 2023 16:48:36 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::8f99:7745:fa5d:3dea]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::8f99:7745:fa5d:3dea%4]) with mapi id 15.20.6277.038; Sun, 9 Apr 2023
 16:48:36 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v6 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Thread-Topic: [PATCH v6 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Thread-Index: AQHZUOiqG6ZyiGxaUE6S5aTx5qv2Ta78K/mAgAAAKICAE8FVcIACCFqAgAdrk0CAAGi0AIACx3qAgABUvwCABnhK0A==
Date:   Sun, 9 Apr 2023 16:48:35 +0000
Message-ID: <MN2PR03MB51681CCFD911F63CE32E914AE7949@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20230307112835.81886-1-okan.sahin@analog.com>
 <20230307112835.81886-6-okan.sahin@analog.com>
 <20230315175223.GI9667@google.com> <20230315175257.GJ9667@google.com>
 <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230329143615.GS2673958@google.com>
 <MN2PR03MB51685B1F84AA679FB604E738E7929@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230403140950.GF548901@google.com> <ZC0zA1bVsrg0XEld@smile.fi.intel.com>
 <20230405133938.GD8371@google.com>
In-Reply-To: <20230405133938.GD8371@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYjJ0aGJpNXpZV2hwYmx4aGNIQmtZWFJoWEhKdllXMXBibWRjTURsa09E?=
 =?utf-8?B?UTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdKaE1qbGxNelZpWEcx?=
 =?utf-8?B?elozTmNiWE5uTFRWa05UVXpZMlZtTFdRMlpqWXRNVEZsWkMxaVpXTTFMVEEw?=
 =?utf-8?B?TjJKallqVmhZekEwT0Z4aGJXVXRkR1Z6ZEZ3MVpEVTFNMk5tTVMxa05tWTJM?=
 =?utf-8?B?VEV4WldRdFltVmpOUzB3TkRkaVkySTFZV013TkRoaWIyUjVMblI0ZENJZ2Mz?=
 =?utf-8?B?bzlJak13TmpRaUlIUTlJakV6TXpJMU5UTXlOVEUwTkRZNU56ZzVOeUlnYUQw?=
 =?utf-8?B?aU5ETkpWMjlWWWxsV1UxRkxOVEpKYWtKUUszUXZTVFZuZWpkTlBTSWdhV1E5?=
 =?utf-8?B?SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJRVUZGVWtoVk1WSlRV?=
 =?utf-8?B?bFZHVGtOblZVRkJSVzlEUVVGQmNIcExNR1pCTW5aYVFWZDVWVVJQYkhWSk9U?=
 =?utf-8?B?UkRZa3BSVFRaWE5Hb3paMGxFUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|SA1PR03MB7099:EE_
x-ms-office365-filtering-correlation-id: 7a8ac759-b540-4d1f-71f3-08db391a4307
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8vF6e2ChE0nPzwiPLaJjXE4/yT2XUQq0q0NYAXECgm9xCJowDGZd0omXY6k0ydyKK/fVwTYk3/bjRl5/UWIwwcIKhHkhm7TIj2WLkAhU3DJPGXDKAAodX51V+azW4wooSlqVcwVzIgGWeu2LrQVouLNNcSJXIzdQnjmP1mjVP0nn8dpoZIUCvCOlk4zD2qyp43enst2H+53MgX46exInitZidAL5WBXy9VVFOnbZX5M1283+LwUmb9On9x5wEnWRmx270rCCD4WF659atvIbRLyTIoBxDaUsSlWj/d3rUjTAy9R/5qdKErbbqE3raG80dn+ucbLeI3Mus+kO/XaMASWIimQ6LHC2KXFFHRabBOgq/hDmClj6Ywfd4iDpZcVGw5JYnDZQd837Ek9ZCmnKiUEOnHnCKqxTEp5040Cswhmt/3F5uj/BAviEXZXl+S5KZNKAXJI13ywEn8P5qGz8bf2PatshVGkD6X7PYEUMV9xO7RigckrEk0//NonscslSuGcvO310/avl2D5NlyfFBwz7OZrRxYpZmbLcbK++DJLkUWDmaTnX2LQc17Glvm9RuOxId38mQZclIiZTKOGA5Rt7uWwSmaAJrrP01DhWocDL3D4hl58dJDmLLS7/EQ0C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(346002)(39850400004)(376002)(451199021)(478600001)(7696005)(71200400001)(54906003)(110136005)(316002)(9686003)(6506007)(26005)(186003)(2906002)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(41300700001)(8936002)(5660300002)(7416002)(52536014)(38070700005)(122000001)(38100700002)(86362001)(55016003)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXg2WFdpUWlDNElJK3BEMURXUWtITlo3U29kS05rSlZibkhyZzJNeERvaGRZ?=
 =?utf-8?B?NTlKcmhSR1Z5dzRNVHNUNE4yWUJpQ0FScUY1NlUxSm1xZUw3OXJqL0NJenpI?=
 =?utf-8?B?NXVPRVhOcUxYUUxpWnJrQVBOTEhrRzBxRWEzV0o4RCtKMXlmK3hvbmNvMVZw?=
 =?utf-8?B?dVFIK0tkRHd0Zm91N3Yxb29teWtHcUtzcnhjaWczQWJOaUd2THh6L2UwTlZG?=
 =?utf-8?B?MG5GaERpMWlnSDVkTEFCT2c3anpoaHFJWGVuUGwzc3E1bENwV1JOb1VDd3cy?=
 =?utf-8?B?aVNLdmY2VFQzSTZyZnE2bU9HaGJaR3VqdkFsKzBJYmZZbzBwdUkxVDZHQi9w?=
 =?utf-8?B?WFpYckdORU5mMFhQaWVONVVPcU5uWHRTNnRYTzg2enRyWXFrQ0p6cmY3WEdk?=
 =?utf-8?B?WkF1VHY4M3hqVHNqbjcvWFhBcnlNVzhHSlZKL0VGMUhkRjB0akxxZXZ6cnhh?=
 =?utf-8?B?T2kyaVJNbTVDclZHc0VsdWZObGZrRDFkMm5CajY5cHprb1hWMEtIbGV0eEVa?=
 =?utf-8?B?U0xUaHRTOXJrVURSNDYzVkIxam9CaXFCQ05nQXdBZkk0K2xyWkgwbW9jb0Q4?=
 =?utf-8?B?ZmNlSzloay83U1N2V3o5VnYycmNaLzVUbjdtdVBjZVlFaW1Fd2dFOE85cTJu?=
 =?utf-8?B?aEs1NkVUcHFFMThyMWd5L3RiRXQ4WlFQNVlzTEVUcUs4V3hWdUFCWFVrcW5j?=
 =?utf-8?B?Q2p4d0lMZWFGQW1tRHhtL1ZqV3J2S3R6NFpSdGtweDlkc2hTT1hIN0tGU1FF?=
 =?utf-8?B?MWkxRW1lczRiNklmVWdsK055K2pqUVJYT2ZENzhlZmlwTWFrZ3hjNUxyL3NU?=
 =?utf-8?B?L1ZQaDBDVHRNM2FzM3o4dzFoR3k4c0txbktnOHVwNEpZZDdSdzJiUWFad2JG?=
 =?utf-8?B?NlRHdEYzbUtRaTlSaTgzWnZrdU94K2JZdFgwNTltTVhqQkh6cjY5Mk9DQ1Vw?=
 =?utf-8?B?ZzAycnZrNitzTlRxWG5IeEg5U0xmYy9SQVZrWG1SUm9DV2dkTzdaRWM1L3dJ?=
 =?utf-8?B?emk0QXorVmZJS2hzYXhTaGtNRTZrYUZURnkrQzkrY3BsQkVESzJ5a0FzMHlV?=
 =?utf-8?B?c2ZRTWNNT2wySTA5WFZnMDF2WEw5WTJ0b0srK1lVNHYzaTJzSEIrWmhJOG80?=
 =?utf-8?B?UTMvMjBzc2RBY3Fyb2cwNWNjcmVzd1RNWUpFMTAzZkNQOG9ZZS9BcTVscnV2?=
 =?utf-8?B?VXlqZldGd29qa2drSDJrK1pCUHBXWGxoMGVBUHRPdmU3ci9WbWVEa0pNTXMx?=
 =?utf-8?B?L3N0R3JiTlo1NkNxQXJrM3NwVEYxM2xBUlh1RnNnb1ZRcHN3dEJEUm1SU3dP?=
 =?utf-8?B?N0tXZWY3WEFUbXRPT2pQSkQ4NVdrRlc5WkNCSFZwR1FTMVNRUlBrMEo1bm0v?=
 =?utf-8?B?cXRUS1pVSG1NSW1wQ2xvOGFEUm9ZVnMyOXJzZTBuUlE5RlJUZjVXNUw3cW0y?=
 =?utf-8?B?QUd4eWRnZ3BsbVFHVjZzS2E4bVRCcW4rMVdmWUxvN0cxUWhJTUVLRGtlSHE1?=
 =?utf-8?B?TW5ZU0xUWkNQaXZyTWhlQWg5eUFrbXNaVThjM2lPNG5MVmx5TTc4UHY1aUZU?=
 =?utf-8?B?MUw4bVZkRkNVeFhKUG83WVlnanROZnFtR0FOZG00Rld2ZDQ1ZWdreWZoUEQ4?=
 =?utf-8?B?Q1dHWUsvM2Z5cW84OW1DSGxKajR0VmVnWktnSzRiR2RIekl1TC96eVVYTTZR?=
 =?utf-8?B?cWVKWXV1MWs4bHZ0OHpuaElIYjNYMVk2OVN0V2xQcExHRW52dmJ1elR2YXNC?=
 =?utf-8?B?SlhVVElZSlZTaG5zb0tWQk5JeEdjYW1FejVsd3hvc1RlZ3IxbUVNczlmL3J4?=
 =?utf-8?B?dlIyaVVscThOYU5lRzlyY2NzQzBYM21vaFNHS1VJN2N2VU43aVgvV0VYNmNn?=
 =?utf-8?B?MG5Vc0M5cnJ1L2JDOVV5N2VkV1VQVmM3Nmt4Wjg2ZlY5bEdHbnNKUGgvWjdS?=
 =?utf-8?B?aWlBUUFQazhYejFtYUp6aFhYMGNzTlAzK0wvUkVOL2J1RkI2ampnWFRLUXhJ?=
 =?utf-8?B?ZVRCVi9ic2E0UnpUQnFVbTFnWk5iNXNyc1BTbmJGa3JhWkh3UjM0UmxiakdN?=
 =?utf-8?B?c2RETVFGN2syNkhEVTdPL0RuQjdIczkwNDdlVFhSN2l6Q2ZWYWxqcmtnSXQy?=
 =?utf-8?Q?m/Ls5gqyK1lF2/iBle0uYxXMD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8ac759-b540-4d1f-71f3-08db391a4307
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2023 16:48:35.9200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PuJ8aGoxdryNoJriGHsrIgkfoiLqLNekqTZeL8XMhM0u/4+dXXBK9wFUbWzeC/JAp0KJObsUXJU9byyw840qJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7099
X-Proofpoint-GUID: GHUBFrRQ0XXp3SGmv3pZVidJ9vPUyruP
X-Proofpoint-ORIG-GUID: GHUBFrRQ0XXp3SGmv3pZVidJ9vPUyruP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-09_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=995 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304090153
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIFdlZCwgMDUgQXByIDIwMjMsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4NCj4+IE9uIE1v
biwgQXByIDAzLCAyMDIzIGF0IDAzOjA5OjUwUE0gKzAxMDAsIExlZSBKb25lcyB3cm90ZToNCj4+
ID4gT24gTW9uLCAwMyBBcHIgMjAyMywgU2FoaW4sIE9rYW4gd3JvdGU6DQo+Pg0KPj4gLi4uDQo+
Pg0KPj4NCj4+ID4gPiBJbiBmYWN0LCBvbmUgb2YgdGhlIG1haW50YWluZXJzIHN1Z2dlc3RlZCBh
c3NpZ25pbmcgY2hpcF9pbmZvIHRvIGRhdGENCj4+ID4gPiBpbnN0ZWFkIG9mIGVudW1lcmF0aW9u
LiBUaGVuIEkgYWRkZWQgY2hpcF9pbmZvIGFuZCBwdXQgZGV2aWNlcyBpbnRvDQo+PiA+ID4gc3Vi
LXN0cnVjdHVyZSBhYm92ZS4gSSB3aWxsIHJlcGxhY2UgY2hpcF9pbmZvIHdpdGggaWQgc3RydWN0
dXJlIGluIG1heDc3NTQxDQo+PiA+ID4gZGV2aWNlIHN0cnVjdHVyZSwgcmlnaHQ/IEkgd2lsbCB1
c2UgZW51bWVyYXRpb24gZm9yIGRhdGEgYXMgSSB3aWxsIGFzc2lnbg0KPj4gPiA+IGl0IHRvIGlk
LCBhbmQgZGlzdGluZ3Vpc2ggZGlmZmVyZW50IGRldmljZXMuDQo+PiA+DQo+PiA+IFllcywgdGhh
dCdzIGNvcnJlY3QuICBQbGVhc2UgcmVtb3ZlIGNoaXBfaW5mbyBhbHRvZ2V0aGVyLg0KPj4NCj4+
IFRoZW4gaXQgd2lsbCBwcm92b2tlIGNhc3RpbmcgaW4gdGhlIE9GIElEIHRhYmxlIHdoaWNoIEkg
YmVsaWV2ZSBpcyBub3Qgd2hhdA0KPj4gd2Ugd2FudC4gSSB3b3VsZCBhZ3JlZSBvbiB5b3VyIGZp
cnN0IHN1Z2dlc3Rpb24gdG8gaGF2ZSBhIHBsYWluIG51bWJlciBpbiBJwrJDDQo+PiBJRCB0YWJs
ZSwgYnV0IEknbSBhZ2FpbnN0IGl0IGluIE9GIGFuZC9vciBBQ1BJIElEIHRhYmxlLg0KPg0KPkFu
ZCBJJ20gYWdhaW5zdCBwYXNzaW5nIE1GRCBpbmZvcm1hdGlvbiB0aHJvdWdoIHRoZSBPRi9BQ1BJ
IEFQSXMuDQo+DQo+WW91IGNhbiBwdXQgdGhyb3VnaCByYXcgcGxhdGZvcm0gZGF0YSBvciBhIGRl
dmljZSBkZXNjcmlwdG9yLg0KPg0KPlJlZjogZ2l0IGdyZXAgLUE1ICJzdHJ1Y3Qgb2ZfZGV2aWNl
X2lkLip7IiAtLSBkcml2ZXJzL21mZA0KPg0KPi0tDQo+TGVlIEpvbmVzIFvmnY7nkLzmlq9dDQoN
CkhpIExlZSwNCg0KUmlnaHQgbm93LCBhcyB5b3Ugc3VnZ2VzdGVkIEkgcmV3cm90ZSBjb2RlIGxp
a2UgYmVsb3cNCkZvciBvZl9kZXZpY2VfaWQsDQoJLiBkYXRhID0gKHZvaWQgKilNQVg3NzU0MCwN
CgkuZGF0YSA9ICh2b2lkICopTUFYNzc1NDEsDQpGb3IgaTJjX2RldmljZV9pZCwNCgkuZGF0YSAg
PSBNQVg3NzU0MCwNCgkuZGF0YSA9IE1BWDc3NTQxDQpJIGFsc28gcmV3cm90ZSBvdGhlciBwYXJ0
IGFzIGNoaXBfaW5mbyBpcyBleGNsdWRlZC4gSSB3YW50IHRvIGJlIHN1cmUgYmVmb3JlDQpzZW5k
aW5nIG5ldyBwYXRjaC4NCg0KRG9lcyBpdCBzZWVtIGNvcnJlY3Q/DQoNClJlZ2FyZHMsDQpPa2Fu
IFNhaGluDQo=
