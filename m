Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC616838A5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjAaV3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjAaV3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:29:12 -0500
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1021EB6D;
        Tue, 31 Jan 2023 13:29:10 -0800 (PST)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VJB8Mx030390;
        Tue, 31 Jan 2023 16:28:48 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ncxbfnkre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 16:28:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeGKflE3MznPtPpRPUko58rOfu64n7b8hStPxd+FW2Jn+VjJfLyxz7SBLlgZo++5I8iwo76RBWIdwsDPmAC4AyvNSW3NKsEphEzK9xzUDIYS5gihD9MJQuJWBZNT1ECMOohUWMHur5OT5XsDM8i8h6X3ihwxbsXwGDUP32IacMZWYoq7MQLf4rWZt3DevuVa/ij3lVFdZ+GgnsFyN9B53EvLz56Dz4oFrLCa0mksuphsfHZcXy6NxJvm4V700HK+0Cr/bImyxAlaKBN0Uz1oMjgKnYl543aekcv1sjZJPk+K/la5uXQ9B+eh9QxmU5emHf5ZMf5xOKB78GewPL9YZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtHOG3nCVBS2Cauq4stWzvZew7f06ZABuSFo7x/M4S8=;
 b=OGwitajq8OLMKNeHfX8+QwrVE4yFR+qhfiIoCpljGuruQIPHcDyxNHNihUcdoRXJnjjpUk7Xn+zUMqOmsA4vFLlWl/PrKfx7A2VUTVQ2AuZ0gO7f35PPfPdoUWSxCH8pq7gKpU6wG4m/kAPLC5RVeRrt99T/JNpdpkKJx+gvkSH3xSnRUweywY3bgmCQphReCVFCZeyYoPXvtSTGoqKkVntdXyp5K62cM9J6JBM9w1WX/44G3TUZH9V5kAAHVzWL/KWat3ijBZoyaZR7fM+wVPEww5mPL7Jd4JRZ4l7XWcPKa2U9VgKNWPS6M9NyqD+QEOWiJ3ta5v4vLxXOztIAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtHOG3nCVBS2Cauq4stWzvZew7f06ZABuSFo7x/M4S8=;
 b=7nUxAGNZWo8wh/MYofKV5h7oL+TyEfHQ3phY07/dPES+BzfbArNJ73XQioUsuctfcJ3jMa266PC5ZVVp6lSaMcNt/BO7KIOhK5oEW28cKe+xq/ZT4OhkMdBYVFiCtSLKjC+efnd84DObVZWNjMipU50hOr8l7gyj9VLdWm4zwaA=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by DM6PR03MB5353.namprd03.prod.outlook.com (2603:10b6:5:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 21:28:46 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::e23e:3ad3:46ba:be2f]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::e23e:3ad3:46ba:be2f%7]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 21:28:45 +0000
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
Thread-Index: AQHZKwfBz6jjhX+QnE+qf5JlMAgoI66j1hOAgBSmw4CAAFOfAIAASoJQ
Date:   Tue, 31 Jan 2023 21:28:45 +0000
Message-ID: <MN2PR03MB5168884376CEE35E73739A95E7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-3-okan.sahin@analog.com>
 <c4433cba-ce35-e5d3-f04b-ba8f9f501732@linaro.org>
 <MN2PR03MB51685B56D49CBB590BBE6B7EE7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
 <04ac07ef-ee4b-abb8-9fb2-114e3a646a2f@linaro.org>
In-Reply-To: <04ac07ef-ee4b-abb8-9fb2-114e3a646a2f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYjJ0aGJpNXpZV2hwYmx4aGNIQmtZWFJoWEhKdllXMXBibWRjTURsa09E?=
 =?utf-8?B?UTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdKaE1qbGxNelZpWEcx?=
 =?utf-8?B?elozTmNiWE5uTFROaE1tWTFPRFUyTFdFeFlXVXRNVEZsWkMxaVpUazJMVFU0?=
 =?utf-8?B?Tm1NeU5XUXpZek5sTkZ4aGJXVXRkR1Z6ZEZ3ellUSm1OVGcxT0MxaE1XRmxM?=
 =?utf-8?B?VEV4WldRdFltVTVOaTAxT0Raak1qVmtNMk16WlRSaWIyUjVMblI0ZENJZ2Mz?=
 =?utf-8?B?bzlJakU1T0RjaUlIUTlJakV6TXpFNU5qYzBNVEl3TVRRek5EQXhOU0lnYUQw?=
 =?utf-8?B?aVlrNTZMMmREYjNkQmIzRm5jV2x6ZFhOWGVFWTBUbXc1VDNSWlBTSWdhV1E5?=
 =?utf-8?B?SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJRVUZGVWtoVk1WSlRV?=
 =?utf-8?B?bFZHVGtOblZVRkJSVzlEUVVGRFprWlpNemgxYWxoYVFWVnBUaTloVldSa2JG?=
 =?utf-8?B?TTNVMGt6T1hCU01USldUSE5FUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|DM6PR03MB5353:EE_
x-ms-office365-filtering-correlation-id: 0fd7193e-0609-4eec-340b-08db03d2221d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U4Jh9shDnoaSiZlObFcSngJZW/tHFtuXw1FNH/Vo9vX2jLkFtzOPi3+xUMhYZgZ6qru4pES1UYb2R2Hhvt2Ddm80P5ghhL7iy72Cb2sCWuMrbw4c3I/xw/JqN4yk8m1UMM82/8ve+ArJFZI1XrVHmf43wCU9wwD0BOtW28ITA3IHY3D5iWQdJLnMrnIHm3dNhDV+fKf2hH8XA9K4HkmDHsCEmX2sOCRGLGGElNDQ5F8fD5yId6+G/0YJzE1kbN7LZgtOeHK15LV8cmTIVMDU+GNEQ3axbQQ/fKQhytlEX2BZDdW5jwtXLyU3fdAQIc9e+mLRaI0kn8blz7Rb44PE4BrqwzNeeHqwvS+/Lrbhw1BsfXmdh6XZbU1/SKeVpTcGY5m9VcYAJg09iAPBFXogZx3Z2dqPIEmZdTCvK4v/FWrnr9XCXPacD1l5wsNeAIpmMyO4Z/lRCLQYXL+Ba3l4hf+mEEcc3Glc/+M1k2NYelYRm9WJ5R2TZvfzaYvAitLdzF/dJpx1aOwJj7BD7KTyMUdiFyByIH03AZEdcR5CLs7yGUTs9RHMpMbQ95UWxOeU+W41wrr26q3tiR0nHEhzvvLDQGjqj84yzg/+sbop4m+44wU7DQRjx7bOy12z5hSKZ2LUEqXDjwkxUK1ahQMJgvGtgHQ9TANF2ce4eGsm7suD6OJSP3gCD0FELO2uyZm0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199018)(86362001)(38070700005)(66556008)(38100700002)(122000001)(33656002)(54906003)(66476007)(5660300002)(52536014)(316002)(4326008)(64756008)(8676002)(66446008)(66946007)(6916009)(76116006)(8936002)(2906002)(55016003)(41300700001)(83380400001)(478600001)(7416002)(7696005)(26005)(9686003)(186003)(71200400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0d6MFA0T3Z2dzM0SWF0dVd3UCtVbXpZbU9FL0Jib2l1WHNSdmJSMUlHdGI2?=
 =?utf-8?B?NDlyZEZjek9SckZadWE3OHZENitod3FCb2hQM0pkVnBwVDZuVnZadUVqK1FJ?=
 =?utf-8?B?ZDVXa29oN005bDI0LzI0UndZK0dwQzhGNnR2VmpnVGRiUjU0Smd0ODR3czlX?=
 =?utf-8?B?Yi9qRGU5eFdHRTM0ZjBVRjV1L3R1blZTaGVUZExSeUJuN0hmS0ZDRGlIekt1?=
 =?utf-8?B?bDVtTGhhUy9ySTgxaVc2QUxkMW4yVHV5ZW1YRVlJM2FvaFRiK2xaY2Q4d3hF?=
 =?utf-8?B?SEhTWExEZFNEc1IrQ0hsRlQ5ZDh1clVtOUg2TWpVTkp1OEsxdGhrQ00vK2Zz?=
 =?utf-8?B?TlFZQlZIT3pWeHU4WGpyNFFpRE5ma3hVMnlQR0Ztazh1dTRmUzZ2bkpRSzdD?=
 =?utf-8?B?OHRyYjREOVRFMjNvNlJWQlhVejlUNXIrVkNRTlZhUjNKS3FjK04yZFdMdnEr?=
 =?utf-8?B?Nmw3aWJXZkM4aU9YNFlWckE5QXRUVmxEeGhrSWNJY1VtamFUTlFvaSswWkhs?=
 =?utf-8?B?T1F6cnFEZUNHSDNsbHpaSG9PWlBIcTZ2S0Vrdy9jbnc3SUpOaXNKdmptYTVv?=
 =?utf-8?B?UlFDSXRUeHIrc1VnZnJ1bHBodGgvakphSHp5cXFwQ05JWFc3ZmtLVmNleGxl?=
 =?utf-8?B?ZUpDeXdJa1I2R09UT21ucUIvTEl6WkE2VUJ1RmxlSXprdUlBUy94YWE1VDBJ?=
 =?utf-8?B?M0ZxcVBXY3k4TzVqU2g5Yy9UbzdQK25OeDZmdGNDZGp6aGp0REpIZkM2VlVC?=
 =?utf-8?B?cFlqdVM5S0QzTmRKdTZ3SXJCWTZoSjRibGQwd0lYNUN6cUdDOVRKQ2I4TlBW?=
 =?utf-8?B?RnFtVGNuSDlSenhPdTJSN3pZWmVYbFh6TzltQ0l5emU2QlREV2ZZTzhXeEJE?=
 =?utf-8?B?TUNSUTIzbThwOUY3OFhwTUh6TUMyOVQ1Q2pnZktrbUVDcmZybmx1L3NwVE9t?=
 =?utf-8?B?SjFRWnVEWUtsSWdSMmRVN0pLMXhSV0JhSGlrNDZmRUVUdkpOeEZmckNuelU2?=
 =?utf-8?B?U2JpK2dCQ2V6RWJKRWJ3dnZHUlJEZmdaWENvY05PKytLQWlrbGdPQkU2bjlo?=
 =?utf-8?B?Q0J1cVVLWitvM25wVjZkRlJDQ0hEMHEwZEhHZTRZMGZmQU1ESklheFNHUVQz?=
 =?utf-8?B?ME81WTl5em5vL3hKMExuMGhieDFSUTlzcGZ0SGZCYjhUYWV4QkRvSnhZeU44?=
 =?utf-8?B?WnZycEpFNWxPeEFlVFF6M3RsU2ZTMndleU0vV3I2SUREaWxmN2p2SFBDbUhF?=
 =?utf-8?B?WTduc25HNEpYZ2pFV2xzZVErc3BKcWlVc3BlR21RZWF4M3Fvc1FoLzhqZm1n?=
 =?utf-8?B?R0VhSXBUUTFZMG90c3VMQ0ozVlovZ0o5aXp6L21qSHd3clJJTUE4d2dzaGhm?=
 =?utf-8?B?STk2cFdhU1RDMDUrVUZoRVQrYmhqeEFRMHlmQVc1YlVWQWhHMWJYOGwzSHpY?=
 =?utf-8?B?N041SnQ4RkZZcSttRHZLbWtmcTRGa1NVUkxDbStBQ1ZvTlliM3ZaamthcCt0?=
 =?utf-8?B?OXZQVmV1V2FDMVQ1ZTJpZjlyVE1zV0F4cEFmWHJ2cklxNERSSHJiTUhuWVNn?=
 =?utf-8?B?SnFWK3dTbmgxUHZJUHFsUVhGMnhYZnNweFo2QWlML3ZTdDd1RTN4Vmd0QTRF?=
 =?utf-8?B?TnA0Q0JuYjJLTldMN2N2SnhXZGNlM00zUHV0eU9UalA0TTBRZ245cXdNT3lI?=
 =?utf-8?B?alNrNmRxVnd0VStvNG1WeFNxVmlSSUk3cXFrTExmZTZiN3hpejVacm96RnVQ?=
 =?utf-8?B?RlUwZ0ZzakIvb3NjbXloLytYUENFWlJwTFZyb0ZRMVBWeGZHdUU5SnA2OEU5?=
 =?utf-8?B?aGY1T0JBcmFUOUhWUXFKbjdZVDVRMTB4U3AyditRZ0Y1amhSQklkTHBJazZw?=
 =?utf-8?B?R2dnUVRyNlVDR0lBNHFza3hnSU1zVXlCd3YyVUpOUlZrZVd6czljZ1Y4S0JV?=
 =?utf-8?B?MGdtTlkwdjdmOGQ5V2NhU3d5NVFBODVqbEZPWVkzS1hUaGw5eFdQR21QQmFt?=
 =?utf-8?B?NTFtaGE4RVYvWDhNcUtvSjJudlp2YzNHRHpDdFF2RzArS1RQRjMyV0NsUWVN?=
 =?utf-8?B?aXFOVnF4bWEwcVJxOVFJRERqZEZVd1RXQ3lpdkNtZjFnMzFsbDZlMUFUMFM2?=
 =?utf-8?Q?i8ayfJiVGeFitzzz37tyX9ocK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd7193e-0609-4eec-340b-08db03d2221d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 21:28:45.3255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GH0QZvctTfw0q/rFHE6JAhPNj5UWqdOhoe8K3GgSEWdB51N5SGC57XVoR/0ht32IUfgWtJ7Ah4DbtO/jQ7hhPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5353
X-Proofpoint-ORIG-GUID: Yw9XupUFjpwBvKH7FGNK2vNu7tsZLIIq
X-Proofpoint-GUID: Yw9XupUFjpwBvKH7FGNK2vNu7tsZLIIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=577 bulkscore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310186
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAzMSBKYW4gMjAyMyA3OjQ0IFBNDQpLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0
b2Yua296bG93c2tpQGxpbmFyby5vcmc+IHdyb3RlOg0KDQo+T24gMzEvMDEvMjAyMyAxMzowMiwg
U2FoaW4sIE9rYW4gd3JvdGU6DQo+Pj4+ICsgIHJlZ3VsYXRvcnM6DQo+Pj4+ICsgICAgJHJlZjog
L3NjaGVtYXMvcmVndWxhdG9yL2FkaSxtYXg3NzU0MS1yZWd1bGF0b3IueWFtbCMNCj4+Pg0KPj4+
IE5vIGltcHJvdmVtZW50cyByZWdhcmRpbmcgYmlzZWN0YWJpbGl0eSAtIHRoaXMgcGF0Y2ggZmFp
bHMuIElmIHlvdQ0KPj4+IHRlc3RlZCB0aGlzIHBhdGNoLCB5b3Ugd291bGQgc2VlIGl0Lg0KPj4+
DQo+Pj4gSW5zdGVhZCBvZiBpZ25vcmluZyBjb21tZW50cywgZWl0aGVyIGltcGxlbWVudCB0aGVt
IG9yIGFzayBmb3IgY2xhcmlmaWNhdGlvbi4NCj4+Pg0KPj4+DQo+PiBTb3JyeSBmb3IgbWlzdW5k
ZXJzdGFuZGluZywgSSBjaGVja2VkIHBhdGNoc2V0IGFzIGEgd2hvbGUgbm90IG9uZSBieSBvbmUg
dGhpcyBpcw0KPndoeSBJIGRpZCBub3QgZ2V0IGZhaWx1cmUgYWZ0ZXIgIm1ha2UgZHRfYmluZGlu
Z19jaGVjayAiIC4gUmlnaHQgbm93LCBJIHVuZGVyc3RhbmQNCj53aHkgeW91IGFyZSBzYXlpbmcg
dGhpcyBwYXRjaCBmYWlscywgYnV0IHdoYXQgaXMgeW91ciBzdWdnZXN0aW9uPyAgd2hhdCBpcyB0
aGUNCj5jb3JyZWN0IG9yZGVyIGZvciB0aGlzIHBhdGNoc2V0PyBJIHNlbnQgYWRpLG1heDc3NTQx
LXJlZ3VsYXRvci55YW1sIGluIHBhdGggNC81Lg0KPkluIHRoZSBsaWdodCBvZiBkaXNjdXNzaW9u
LCBzaG91bGQgSSByZW1vdmUgYWxsIHRoZSBwYXJ0cyByZWxhdGVkIHRvIHJlZ3VsYXRvciBpbg0K
PnBhdGNoIDIvNSwgdGhlbiBhZGQgYWRpLG1heDc3NTQxLXJlZ3VsYXRvci55YW1sIGFuZCB1cGRh
dGUNCj5hZGksbWF4Nzc1NDEueWFtbCBpbiBwYXRjaCA0LzU/IG9yIHNob3VsZCBJIGFkZCBuZXcg
cGF0Y2ggdG8gdXBkYXRlDQo+YWRpLG1heDc3NTQxLnlhbWw/DQo+DQo+UmVndWxhdG9yIGJpbmRp
bmcgcGF0Y2ggc2hvdWxkIGJlIGZpcnN0IGluIHRoZSBzZXJpZXMgKGJpbmRpbmdzIGFyZSBiZWZv
cmUgdXNhZ2UpLA0KPnRoZW4gdGhlIE1GRCBiaW5kaW5nIHNob3VsZCBjb21lLiBZb3VyIGNvdmVy
IGxldHRlciBzaG91bGQgY2xlYXJseSBhdCB0aGUgdG9wDQo+bWVudGlvbiB0aGUgZGVwZW5kZW5j
eS4gWW91IGNhbiBhbHNvIG1lbnRpb24gZGVwZW5kZW5jeSBpbiBNRkQgcGF0Y2ggYWZ0ZXIgLS0N
Cj4tLCBiZWNhdXNlIG1hbnkgb2YgdXMgZG8gbm90IHJlYWxseSByZWFkIGNvdmVyIGxldHRlcnMu
Li4NCj4NCj4NCj5CZXN0IHJlZ2FyZHMsDQo+S3J6eXN6dG9mDQpIaSBLcnp5c3p0b2YsDQoNClRo
YW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjay4gSSB0cmllZCB0byBleHBsYWluIGluIGNvdmVyIGxl
dHRlciAuSG93ZXZlciwgSSB1bmRlcnN0YW5kIHRoYXQgaXQgd2FzIG5vdCBjbGVhciBlbm91Z2gu
IEkgZG8gbm90IHdhbnQgdG8gdGFrZSB5b3VyIHRpbWUsIGJ1dCBsZXQgbWUgYXNrIG9uZSB0aGlu
ZyB0byB1bmRlcnN0YW5kIHRoZSBjYXNlIGNvbXBsZXRlbHkuIFJpZ2h0IG5vdywgbXkgb3JkZXIg
aXMgbGlrZSBiZWxvdw0KW2NvdmVyIGxldHRlcl0tPlttZmQgZHJpdmVyXS0+W21mZCBiaW5kaW5n
XS0+W3JlZ3VsYXRvciBkcml2ZXJdLT5bcmVndWxhdG9yIGJpbmRpbmddLT5bYWRjXS4gDQpTaG91
bGQgSSBjb21wbGV0ZWx5IGNoYW5nZSB0aGUgb3JkZXJpbmcgIGUuZy4gc3RhcnRpbmcgd2l0aCBy
ZWd1bGF0b3IgZW5kaW5nIHdpdGggbWZkIG9yIGlzIGl0IHN1ZmZpY2llbnQgdG8ganVzdCBnZXQg
dGhlIHJlZ3VsYXRvciBiaW5kaW5nIGp1c3QgYmVmb3JlIHRoZSBtZmQgYmluZGluZ3M/DQoNClJl
Z2FyZHMsDQpPa2FuDQo=
