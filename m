Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D976860F1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjBAHrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjBAHrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:47:41 -0500
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B915CFC8;
        Tue, 31 Jan 2023 23:47:32 -0800 (PST)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3114FUYd030385;
        Wed, 1 Feb 2023 02:47:01 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ncxbfr5r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 02:47:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bF3HqKgP7G87HimlqHphlcxgHOOYYUnZK3ImSleP8DNtPbHQSuLXXpxoSJMhn0QGPtEx+vtOx3mu51Jc4qv4lLVQaJfenuiJAQxdnnz5hsBxf/v0haOoBvxSguCPaavNBGWm+XUhSvDy6boZJgdYY52AluPMo7iR1RtTLhyHeMPpaOYlj2UUz93+0iNHwzAvsyRRyMuiLIb+0WtCm725Nfz1dhJeyxC4qrefu+iVqCnAFo/Q4jKKtTXW+YuisUySw+6AwT6Iu5pwJA8hURhbYtSMyxtoEjPpmBOk3s0NcQPZhKc+Gxssf2FoDFyx+lyojk5M2P6AMQevpWTCa611MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pBapx3L8M1BlUyhW99U8il5B4yzNV+ODwP38Rwn2WU=;
 b=Z2R9N3+Mey/hFskfskFxx899VguWxKDBs3w8Ke3rZ5T2b1uIMI13V1xPEPeGuqI2j0aDLzNkho1EGh51g1r+ERmyQ81FiauwbjYOf9nGMGp1zhpWaUa/7GvxFigS0/cMkTntatapwrG4yhI1svje0X9hSIfcJnvjgUlFjgpbPKZMIN8xODXLNllqbCQmnB7oVHuuFMUzTPjTBJ8iHUPPD3tKgW45hsBITb8Mo1cKaQwT8so2ylFtNKCM5x1xML30+/a2M3RqpxBCTBAHB7mm7Ow7G70auavf7OH6KL+JhdOJUlCibR6zZrUBGIup/kgkaXEO2l8MS2yQS1E3pKNDuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pBapx3L8M1BlUyhW99U8il5B4yzNV+ODwP38Rwn2WU=;
 b=vU9h857KbsTdxloJH6hohAdTT6lww1eDx70PCH36xFRfOrhmtl523uffInN4Gqg7ib6gT+1hQQgwb0Xs2r+vlsNMC+C1IiyemIifTsVm5eoLa1maZCLa6r0VZ5DLfIFL5+FAXaURVpiQ39bEZ0yrZySjy+WEWABMg5wOliHx5MI=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by SJ0PR03MB6488.namprd03.prod.outlook.com (2603:10b6:a03:397::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Wed, 1 Feb
 2023 07:46:59 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::e23e:3ad3:46ba:be2f]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::e23e:3ad3:46ba:be2f%7]) with mapi id 15.20.6064.022; Wed, 1 Feb 2023
 07:46:59 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v3 2/5] dt-bindings: mfd: Add ADI MAX77541/MAX77540
Thread-Topic: [PATCH v3 2/5] dt-bindings: mfd: Add ADI MAX77541/MAX77540
Thread-Index: AQHZKwfBz6jjhX+QnE+qf5JlMAgoI66j1hOAgBSmw4CAAFOfAIAASoJQgACrtQCAAAOSQA==
Date:   Wed, 1 Feb 2023 07:46:59 +0000
Message-ID: <MN2PR03MB5168CACCB1367E84DECEFC62E7D19@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-3-okan.sahin@analog.com>
 <c4433cba-ce35-e5d3-f04b-ba8f9f501732@linaro.org>
 <MN2PR03MB51685B56D49CBB590BBE6B7EE7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
 <04ac07ef-ee4b-abb8-9fb2-114e3a646a2f@linaro.org>
 <MN2PR03MB5168884376CEE35E73739A95E7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
 <f67f81fd-c770-45b2-9c5e-7ea53e956db9@linaro.org>
In-Reply-To: <f67f81fd-c770-45b2-9c5e-7ea53e956db9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYjJ0aGJpNXpZV2hwYmx4aGNIQmtZWFJoWEhKdllXMXBibWRjTURsa09E?=
 =?utf-8?B?UTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdKaE1qbGxNelZpWEcx?=
 =?utf-8?B?elozTmNiWE5uTFRrNU5XRTFaR1kwTFdFeU1EUXRNVEZsWkMxaVpUazJMVFU0?=
 =?utf-8?B?Tm1NeU5XUXpZek5sTkZ4aGJXVXRkR1Z6ZEZ3NU9UVmhOV1JtTmkxaE1qQTBM?=
 =?utf-8?B?VEV4WldRdFltVTVOaTAxT0Raak1qVmtNMk16WlRSaWIyUjVMblI0ZENJZ2Mz?=
 =?utf-8?B?bzlJakkyT0RNaUlIUTlJakV6TXpFNU56RXhNakUyTkRrM01qVTBPU0lnYUQw?=
 =?utf-8?B?aVJWaEVUMDQ1YzFSQ1NIVTNaR3hRUjBaWVdsRnFiVXAzWW5OTlBTSWdhV1E5?=
 =?utf-8?B?SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJRVUZGVWtoVk1WSlRV?=
 =?utf-8?B?bFZHVGtOblZVRkJSVzlEUVVGQlJtVk1UbUpGVkdKYVFWTjVWelZsVWtRMGRG?=
 =?utf-8?B?WXJURXBpYkRWRlVHa3hXRFJFUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVWhCUVVGQlJHRkJVVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVVkJRVkZCUWtGQlFVRlNjekZuUmxGQlFVRkJRVUZCUVVGQlFVRkJR?=
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
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|SJ0PR03MB6488:EE_
x-ms-office365-filtering-correlation-id: c128f2db-2513-4a46-dc91-08db04287fb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JeJn4xTBlDhd4/lbI7uSvbetnRhebXh7uuEVnHxB+24NVtw/r4ZCN4p1eyyNpXkWYIp5GjyUOTKK2iM6LZGE8gS+SF2XUOB59jMQu4B/KGFwS0utp68ftwzYKPPYmaEvTwHcUbn5oL98uz3tCAyF20LmwT5Gtoac5pQkFhKeqJG6aZcu2QHsOjFkWLWv83KM4KeU4rAD8blzQZJMSf1ntATx9VkoTqkdWkZV3EGcPIOAVsHDYdw9SvY30uVZ9ZGa53/bGNMqlfG5+Qn21ms2eP7kUYk9Lhltd8DJv9sJmN6rkDXFr2JJjvP0HOiFjvoL73i3DKto/Z8M4GEylNAvm4UAZdnGD/PywkmlcqZ2iuYqGJ4OkFpgAypXrs8MtjmuUA6/BxFtG0tUY2HsiTXn1ifzY6IL14WagaPKABHlEfk8angMtXeeO/X3pXOKpDow6s/4HaLD95rLIFV6T47lg7hXUgApJdnz7oFSx9FjzRfjHKV3f9qjRpxUZMcIlVgZpgZeReXxMaP78GgGXrFY5RgZAi4AY1L4b/xFW1nQiG43f6oZrD/KjauTU3N/0D6MqWvdPZzPuW4X/NdNertsC5YvQRm1nXr0q5WhdUbDyfUw8+xtkbvrnQWFMCrSrTnxpH2EFxMGFsIJS8oM6Alm5XcVMfYy8RS94opepASDHkclVs6hXomg689WjsW6T8Ihrm6k6LFByRQVJSewsU9iHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199018)(2906002)(7416002)(38100700002)(55016003)(5660300002)(26005)(186003)(122000001)(9686003)(7696005)(66946007)(8676002)(83380400001)(76116006)(4326008)(316002)(41300700001)(52536014)(33656002)(6506007)(8936002)(66476007)(54906003)(6916009)(66556008)(64756008)(66446008)(53546011)(38070700005)(478600001)(71200400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDRGbWYrU2x0MnYvS2JlVm85VG5IcExxekdHTkNKVW5NcFVXY1FRa0QrV0NK?=
 =?utf-8?B?azhhWDl6UVJhYmk3WW1vV0NZMjAwSWgwc0lrajU1K0dOYVYwMTZsSkYzRDlo?=
 =?utf-8?B?L3c3b1p6YXBOQVp1aWF0M256NU81RFJVYlB1OC9lWWdyYURrcXBUQzlUUkc4?=
 =?utf-8?B?d29lZWozakF1bjY4Z3ZpWkhpQmZHY3ZwS3I3Q1ZNT3lJVlFDNXQ4YXFjTTYy?=
 =?utf-8?B?YTlkNlg3WjNyclMwTTJZU3QrNml2N2VzR0VadzNjVTVtWndJdGJJOUk0eWcw?=
 =?utf-8?B?RDRwdEJiQk9vamlRaEFPdnNmOTNKanA3U0xOYnlWOEJKbVdKM3ZWUENLZHVO?=
 =?utf-8?B?SHQvcFdjc3RvYVBhdkhpa3lSQ2JHN1l2OTd6S0tvRmlhMUhjMUs3NE0vc0xk?=
 =?utf-8?B?M2dJRlh5TENOL0F5cllsMTV5cWN3NHAyUzhiVGVYN2QzR0VXaHgySHgzdFZW?=
 =?utf-8?B?WGlheFYwWW1aaVR0eGw2cDhHRzJZVXAyNWNqeDNjQnRpUFgvV1NGWERwVGFw?=
 =?utf-8?B?bHRLaG1XV0JRV3FwRnc3Z09LYTFCa0NVQXJ4SVRUQlhmMXVxVVJEdzh0VlBX?=
 =?utf-8?B?WTU0YnVWNDdjaDE4NVJPVjNoRlpUejRIY0FSUHYzN0JSYXJrdmRjSHRudUFv?=
 =?utf-8?B?WW9jbndkc2hQMXlISGM3UUJzd2YyUEUzREN5cU82Nzcrc1Zic2hZMWU3QTdB?=
 =?utf-8?B?ZWZ2UXNIMTVEWUdzREdsbFRsVXFFcHNuU2VLV1dEak4yc0x5MWoxejVIdmhx?=
 =?utf-8?B?YjByaTRHOEhScm9lbWdraWI2dnZBQnY5d0FIbUU5UVNwc21Cak8zTnI4djFS?=
 =?utf-8?B?cCtxdDhqdDF3M2xzd2JSSVRac01VUklkSEhRYTZVTE13NEtpaXp2Zi9ENHN3?=
 =?utf-8?B?QThtdll4c3BCMS9scWdMTXhvM2tkOCtQaVJnWDdKQUZEVG1oUnR2MWtHQlVl?=
 =?utf-8?B?dUdaNzdsN2VDa0JnOEt3QVNxMlhVM1U0Z3hzS3VzWjAwR1lFWi93bmNhQy9y?=
 =?utf-8?B?M3M4ZitqeHR3MkkvSytlRmFIKzAzZHFtcGdZYjc5NEFQeVRPMlF3ckplS2F0?=
 =?utf-8?B?Z0tNQ2V0Rno2Z2VDL09NbzhEdCs0MTBlYVA3SmQ0V3dEdEtoOXdMUE9rQS8z?=
 =?utf-8?B?SFNubUU2ckVSd2ozTzQxQ1JFbllQKytwVE9QZ0RMTlV1ak1ROW9pdkxUdXQz?=
 =?utf-8?B?czlvM3pYcWI4eU5EMFFGQ3JFN0hiZE1RNHI5QlMvZ2x2UzBiKzhsYWl2NHVo?=
 =?utf-8?B?Y2M1SzlLbzhEUW9mRnNXSXZwRlFXYzg2QlI4d0FDa2NlNzJ2UWZ4RjloZUhE?=
 =?utf-8?B?eUhLRGVGZzVRWDlyS2tHWTNQSmpzbnlwYzhMNkQzcTJraTl5OXJNcVlBMDli?=
 =?utf-8?B?UW1FclBFT3ZNT2RScEJGSFpHUjRkZnNOMWFjZ1pHU0UvVVZQTUJ1Z0piMTNW?=
 =?utf-8?B?Z08vRXJSNlYrTGxIR3doZVFiK3dTcTNadUg3eFcrd2lkaTltcVFVMkRtQ1dD?=
 =?utf-8?B?YnMzYzNjWk0zWG0zckV2emxTNzlsM0JvWGJmVTVIdnJWYStoOTFYalVoVTNO?=
 =?utf-8?B?RlgrbEJaWnNCVUg0MnQzQkxFODZ6NU4zMlBJVjRCSU1Ea0x4WmUyZ3FXdW91?=
 =?utf-8?B?SDR6OHdWMi8yV0ppRGp5Y1ZKUm5KQk4wajFrMFp4SVlhaGVGK1F4VW5WNFZM?=
 =?utf-8?B?LzFVVFpEbzRJZVNaeHJsNW0yMFpiZ3F2MEtWSUpWMURJS0dRR1cxSlp4Qitp?=
 =?utf-8?B?V2FqK1BZaFQ0TE1vNkNHajRIblhCOHM4VkphTktjbm9IcEZoVGh4TzhwQ1RT?=
 =?utf-8?B?SGlKMGpNTUs1Vmd4YWNGcTFHdXljalV2MTNuTzJlc1pCdDMyLzk2K0VITkU2?=
 =?utf-8?B?YjBnenJIZWtBQ3VhcVB3RGk3bEpHVE5wN2xFdVk1YnFLSW5wVm5XOGlXNkpV?=
 =?utf-8?B?eXZXRDBoVm9jdDh5V0ZNRVZFREhZWFArT2RDbWcyTllSc2xoTks4OGsrbi96?=
 =?utf-8?B?TGpwK0RSWWRZMXE0NTBqMjM4dzFreDAveTZRS2oxOGcxK3hwWnJaMnptQkww?=
 =?utf-8?B?dU5jL1dQL0dQMGRKRU5MSStGMHpQL1JJMlJJdkJOM1d1YmdaTFFENVVNVW1y?=
 =?utf-8?Q?3oGdRgWxuRcEwrnC4tPVzci+Z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c128f2db-2513-4a46-dc91-08db04287fb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 07:46:59.0794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bY67b6kQRRPzMcUikGZltYRDTkZXLklPLOo/vWR19rQ+48eSG1fwNaRQHitsgMyNzXGcxgg7N+4iaPHQGkuYCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6488
X-Proofpoint-ORIG-GUID: kXDbzhqen7KlupnN2om1G3eCynM_EBMA
X-Proofpoint-GUID: kXDbzhqen7KlupnN2om1G3eCynM_EBMA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_03,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=687 bulkscore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010067
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gT24gV2VkLCAxIEZlYiAyMDIzIDEwOjI2IEFNDQo+PiBLcnp5c3p0b2YgS296bG93c2tpIDxr
cnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+IHdyb3RlOg0KDQo+T24gMzEvMDEvMjAyMyAy
MjoyOCwgU2FoaW4sIE9rYW4gd3JvdGU6DQo+PiBPbiBUdWUsIDMxIEphbiAyMDIzIDc6NDQgUE0N
Cj4+IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4g
d3JvdGU6DQo+Pg0KPj4+IE9uIDMxLzAxLzIwMjMgMTM6MDIsIFNhaGluLCBPa2FuIHdyb3RlOg0K
Pj4+Pj4+ICsgIHJlZ3VsYXRvcnM6DQo+Pj4+Pj4gKyAgICAkcmVmOiAvc2NoZW1hcy9yZWd1bGF0
b3IvYWRpLG1heDc3NTQxLXJlZ3VsYXRvci55YW1sIw0KPj4+Pj4NCj4+Pj4+IE5vIGltcHJvdmVt
ZW50cyByZWdhcmRpbmcgYmlzZWN0YWJpbGl0eSAtIHRoaXMgcGF0Y2ggZmFpbHMuIElmIHlvdQ0K
Pj4+Pj4gdGVzdGVkIHRoaXMgcGF0Y2gsIHlvdSB3b3VsZCBzZWUgaXQuDQo+Pj4+Pg0KPj4+Pj4g
SW5zdGVhZCBvZiBpZ25vcmluZyBjb21tZW50cywgZWl0aGVyIGltcGxlbWVudCB0aGVtIG9yIGFz
ayBmb3INCj5jbGFyaWZpY2F0aW9uLg0KPj4+Pj4NCj4+Pj4+DQo+Pj4+IFNvcnJ5IGZvciBtaXN1
bmRlcnN0YW5kaW5nLCBJIGNoZWNrZWQgcGF0Y2hzZXQgYXMgYSB3aG9sZSBub3Qgb25lIGJ5DQo+
Pj4+IG9uZSB0aGlzIGlzDQo+Pj4gd2h5IEkgZGlkIG5vdCBnZXQgZmFpbHVyZSBhZnRlciAibWFr
ZSBkdF9iaW5kaW5nX2NoZWNrICIgLiBSaWdodCBub3csDQo+Pj4gSSB1bmRlcnN0YW5kIHdoeSB5
b3UgYXJlIHNheWluZyB0aGlzIHBhdGNoIGZhaWxzLCBidXQgd2hhdCBpcyB5b3VyDQo+Pj4gc3Vn
Z2VzdGlvbj8gIHdoYXQgaXMgdGhlIGNvcnJlY3Qgb3JkZXIgZm9yIHRoaXMgcGF0Y2hzZXQ/IEkg
c2VudCBhZGksbWF4Nzc1NDEtDQo+cmVndWxhdG9yLnlhbWwgaW4gcGF0aCA0LzUuDQo+Pj4gSW4g
dGhlIGxpZ2h0IG9mIGRpc2N1c3Npb24sIHNob3VsZCBJIHJlbW92ZSBhbGwgdGhlIHBhcnRzIHJl
bGF0ZWQgdG8NCj4+PiByZWd1bGF0b3IgaW4gcGF0Y2ggMi81LCB0aGVuIGFkZCBhZGksbWF4Nzc1
NDEtcmVndWxhdG9yLnlhbWwgYW5kDQo+Pj4gdXBkYXRlIGFkaSxtYXg3NzU0MS55YW1sIGluIHBh
dGNoIDQvNT8gb3Igc2hvdWxkIEkgYWRkIG5ldyBwYXRjaCB0bw0KPj4+IHVwZGF0ZSBhZGksbWF4
Nzc1NDEueWFtbD8NCj4+Pg0KPj4+IFJlZ3VsYXRvciBiaW5kaW5nIHBhdGNoIHNob3VsZCBiZSBm
aXJzdCBpbiB0aGUgc2VyaWVzIChiaW5kaW5ncyBhcmUNCj4+PiBiZWZvcmUgdXNhZ2UpLCB0aGVu
IHRoZSBNRkQgYmluZGluZyBzaG91bGQgY29tZS4gWW91ciBjb3ZlciBsZXR0ZXINCj4+PiBzaG91
bGQgY2xlYXJseSBhdCB0aGUgdG9wIG1lbnRpb24gdGhlIGRlcGVuZGVuY3kuIFlvdSBjYW4gYWxz
bw0KPj4+IG1lbnRpb24gZGVwZW5kZW5jeSBpbiBNRkQgcGF0Y2ggYWZ0ZXIgLS0gLSwgYmVjYXVz
ZSBtYW55IG9mIHVzIGRvIG5vdCByZWFsbHkNCj5yZWFkIGNvdmVyIGxldHRlcnMuLi4NCj4+Pg0K
Pj4+DQo+Pj4gQmVzdCByZWdhcmRzLA0KPj4+IEtyenlzenRvZg0KPj4gSGkgS3J6eXN6dG9mLA0K
Pj4NCj4+IFRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjay4gSSB0cmllZCB0byBleHBsYWluIGlu
IGNvdmVyIGxldHRlcg0KPj4gLkhvd2V2ZXIsIEkgdW5kZXJzdGFuZCB0aGF0IGl0IHdhcyBub3Qg
Y2xlYXIgZW5vdWdoLiBJIGRvIG5vdCB3YW50IHRvIHRha2UgeW91cg0KPnRpbWUsIGJ1dCBsZXQg
bWUgYXNrIG9uZSB0aGluZyB0byB1bmRlcnN0YW5kIHRoZSBjYXNlIGNvbXBsZXRlbHkuIFJpZ2h0
IG5vdywgbXkNCj5vcmRlciBpcyBsaWtlIGJlbG93IFtjb3ZlciBsZXR0ZXJdLT5bbWZkIGRyaXZl
cl0tPlttZmQgYmluZGluZ10tPltyZWd1bGF0b3IgZHJpdmVyXS0NCj4+W3JlZ3VsYXRvciBiaW5k
aW5nXS0+W2FkY10uDQo+PiBTaG91bGQgSSBjb21wbGV0ZWx5IGNoYW5nZSB0aGUgb3JkZXJpbmcg
IGUuZy4gc3RhcnRpbmcgd2l0aCByZWd1bGF0b3IgZW5kaW5nDQo+d2l0aCBtZmQgb3IgaXMgaXQg
c3VmZmljaWVudCB0byBqdXN0IGdldCB0aGUgcmVndWxhdG9yIGJpbmRpbmcganVzdCBiZWZvcmUg
dGhlIG1mZA0KPmJpbmRpbmdzPw0KPg0KPiJiaW5kaW5ncyBhcmUgYmVmb3JlIHVzYWdlIiAtIHdo
YXQncyB1bmNsZWFyPw0KPg0KPkhvdyBjYW4geW91IHVzZSBiaW5kaW5nIGJlZm9yZSBkZWZpbmlu
ZyBpdD8NCj4NCj5CZXN0IHJlZ2FyZHMsDQo+S3J6eXN6dG9mDQoNCkhpIEtyeXN6dG9mLA0KDQpJ
dCBpcyBjcnlzdGFsIGNsZWFyIHRoYXQgImJpbmRpbmdzIGFyZSBiZWZvcmUgdXNhZ2UiLCBidXQg
d2hhdCBJIHdhbnQgdG8ga25vdyBpcyB3aGF0IGlzIHRoZSBjb3JyZWN0IG9yZGVyIG9mIHBhdGNo
c2V0IGZvciBtZmQgZGV2aWNlPyBNYXg3NzU0MSBpcyBtdWx0aS1mdW5jdGlvbmFsIGRldmljZS4g
SXQgaGFzIGJvdGggYWRjIGFuZCByZWd1bGF0b3Igc3ViZGV2aWNlcy4gSSB0aG91Z2h0IEkgbmVl
ZCB0byBwdXQgbWZkIGRyaXZlciBmaXJzdCwgeWV0IGl0IGxvb2tzIHdyb25nIHRvIG1lIHJpZ2h0
IG5vdz8gDQoNClJlZ2FyZHMsDQpPa2FuDQo=
