Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DAE6E5DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjDRJmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjDRJmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:42:03 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0887DA1;
        Tue, 18 Apr 2023 02:42:01 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I7TZkC032360;
        Tue, 18 Apr 2023 05:41:57 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3pynpb7heb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 05:41:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4nKsmRzC2Ae6h5GlLOvH3hJGVGXe2JP2mcjiMYbhcISUJPvBv0IGJug6aQvDQ2fZ9IefXp8ZZ+i8kVRRwd0fe4UC2AFjCIMCFWjBeWmRyPzISxTD1CUOnDz23maecIpeUZHi/cQ07HMtZ0K5kE1gVIlJJzXIsexC0QzIm2mG16CL1xzzl7gm9TodcoCecpCe0eh9Tpz7vqhN1wMxfLi1YtlozP7d4ZFVkGXZCFeOVj5AFkxjBDH2gAcxuxXrCbbKoanv6qjKuKWc0a8tz11PxZliHD6mZGUK6IylShMCToZ+j5kI6zevEL9cq+o75PwkrsFIE6CA1pm1JGNZnuv5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLg7+CvquRp3Kht2yzy3rwDBZRPR9dkA0cuAuK3X0+8=;
 b=RTp4P7LubzhQOqWPlO/kBr6Jo00UC3czTxbWD4XNi0uEP6c7pfZOuuRmRD40puvwLkSS7ZZg+/kzyKgh/wLtkKS701JBIo9tmaFfp2EoKWFSpMcNmPl7VKXRVvOjJ71nUYWOK7n9/YwseK17oapnIuXhE/RfD5Bat8guW2FajRqQ4e8Udw5lFULW3j0aAqmcB+ppVur8PSfI5o8bRTeMN04rqYUc4vDjbuYwVAi/4tygITeqWrXt5nLpENeVGdwCAeI0nrydBNiJsuIchh/r8dnggeKumrQwPkGDTACIwzO4H0ezm+YzDq43weVVxhSYJmaQDqgWqVhs13z2bhMmng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLg7+CvquRp3Kht2yzy3rwDBZRPR9dkA0cuAuK3X0+8=;
 b=OR5hJUid7LFevxHGUZHTtzq7tKCryVF2jJ+YoGPE1ZuPbjxWKpblLm6tpHyQDCUp9fIrePB3GhA/S3k13gARb5yjHMVTEckTwTHLPowLNxVldlJRxPY+D8oQJRPIu3pZordbpXGneOzVDlYnhd5NHvt8o5aT3vJ0APKW6wT9xkQ=
Received: from MN2PR03MB5197.namprd03.prod.outlook.com (2603:10b6:208:1f0::18)
 by BN8PR03MB5025.namprd03.prod.outlook.com (2603:10b6:408:dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 09:41:54 +0000
Received: from MN2PR03MB5197.namprd03.prod.outlook.com
 ([fe80::c8df:77bc:8e3c:f92b]) by MN2PR03MB5197.namprd03.prod.outlook.com
 ([fe80::c8df:77bc:8e3c:f92b%5]) with mapi id 15.20.6319.020; Tue, 18 Apr 2023
 09:41:54 +0000
From:   "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: RE: [PATCH 4/6] dt-bindings: power: supply: add MAX77659 charger
 binding
Thread-Topic: [PATCH 4/6] dt-bindings: power: supply: add MAX77659 charger
 binding
Thread-Index: AQHZFHafezZFG2rId0CSeK7xJHHTP6523OgAgLncwxCAAKbXAIAAF02A
Date:   Tue, 18 Apr 2023 09:41:53 +0000
Message-ID: <MN2PR03MB51977056C2DC014B0BC7D40F8B9D9@MN2PR03MB5197.namprd03.prod.outlook.com>
References: <20221220132250.19383-1-Zeynep.Arslanbenzer@analog.com>
 <20221220132250.19383-5-Zeynep.Arslanbenzer@analog.com>
 <5ba4295f-1197-913c-b1eb-a23798c3badf@linaro.org>
 <MN2PR03MB5197E655DE2EAACAEA2316578B9C9@MN2PR03MB5197.namprd03.prod.outlook.com>
 <1e1fb90a-43c0-3b0a-ab7a-8ca3ce8b02ed@linaro.org>
In-Reply-To: <1e1fb90a-43c0-3b0a-ab7a-8ca3ce8b02ed@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jZW1WNWJtVndMbUZ5YzJ4aGJtSmxibnBsY2x4aGNIQmtZWFJoWEhKdllX?=
 =?utf-8?B?MXBibWRjTURsa09EUTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdK?=
 =?utf-8?B?aE1qbGxNelZpWEcxelozTmNiWE5uTFROallUY3daREl6TFdSa1kyUXRNVEZs?=
 =?utf-8?B?WkMxaVpqUXlMVFpqT1RRMk5tUmpNRGt4T1Z4aGJXVXRkR1Z6ZEZ3elkyRTNN?=
 =?utf-8?B?R1F5TlMxa1pHTmtMVEV4WldRdFltWTBNaTAyWXprME5qWmtZekE1TVRsaWIy?=
 =?utf-8?B?UjVMblI0ZENJZ2MzbzlJamt4T1RnaUlIUTlJakV6TXpJMk1qZzBOVEE0TkRR?=
 =?utf-8?B?ME56STVPQ0lnYUQwaVkwMURVRFF6SzBOV2JrcFRZVmxCWVhwTVZXZFRjR3Rt?=
 =?utf-8?B?Y1UwNFBTSWdhV1E5SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJR?=
 =?utf-8?B?VUZGVWtoVk1WSlRVbFZHVGtOblZVRkJSVzlEUVVGQ1EwMW5WQzh5V0VoYVFW?=
 =?utf-8?B?Tm9XRmhRT1ZkUWQxWlBTMFprWXk4eFdTOUNWVFJFUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVWhCUVVGQlJHRkJVVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVVkJRVkZCUWtGQlFVRlRha1ZZZUhkQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZLTkVGQlFVSm9RVWRSUVdGUlFtWkJTRTFCV2xGQ2Fr?=
 =?utf-8?B?RklWVUZqWjBKc1FVWTRRV05CUW5sQlJ6aEJZV2RDYkVGSFRVRmtRVUo2UVVZ?=
 =?utf-8?B?NFFWcG5RbWhCUjNkQlkzZENiRUZHT0VGYVowSjJRVWhOUVdGUlFqQkJSMnRC?=
 =?utf-8?B?WkdkQ2JFRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlJVRkJRVUZCUVVGQlFVRm5RVUZCUVVGQmJtZEJRVUZIUlVGYVFVSndRVVk0?=
 =?utf-8?B?UVdOM1FteEJSMDFCWkZGQ2VVRkhWVUZZZDBKM1FVaEpRV0ozUW5GQlIxVkJX?=
 =?utf-8?B?WGRDTUVGSVRVRllkMEl3UVVkclFWcFJRbmxCUkVWQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVkZCUVVGQlFVRkJRVUZEUVVGQlFVRkJRMlZCUVVGQldW?=
 =?utf-8?B?RkNhMEZIYTBGWWQwSjZRVWRWUVZsM1FqRkJTRWxCV2xGQ1prRklRVUZqWjBK?=
 =?utf-8?B?MlFVZHZRVnBSUW1wQlNGRkJZM2RDWmtGSVVVRmhVVUpzUVVoSlFVMW5RVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVKQlFVRkJRVUZCUVVGQlNVRkJRVUZC?=
 =?utf-8?Q?QUE9PSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB5197:EE_|BN8PR03MB5025:EE_
x-ms-office365-filtering-correlation-id: 008fde58-6332-4d6e-2094-08db3ff124af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5gC0Ilu5dF/3LdBMHOO/I0mfA9nVBxckQawTjg6KAeRtK/nifbjyYFgyQ3pdmHYWF2U8kP7kIG2ZCNce22QByjo26WyinF1rW7Zgmwi1CYSB8Q5tya+uf51TJm0LNwhjt1Yjheh8cxm64Lg31YVg9/tZKavkVBb6b06aDANDC0MZaP6+9tDf4qGvfoY/XtzuHfT2Kt9l3zXZQjhdLI/qRs9ZxG5mHU1b76UpEHYgXcLoOqTb7tyFOcTwkrwiqOYzar1Iu1V9YgMJx4fbkxZZDF/CgykWAu0GPbJ7MPgl3LD9LJox4f3haEVAj84+bieQsdPHyOs/EslEO9NMh3Vk5BwL/e/98mzxvsRws+jib407wGdAdDRu4zfixiKdy7TB+jqxW2wGhQkcq0qpH+4Z+DnSSFnluKuLkO4MSUuQHsXC3Og9m/p+KjG+3JgNLkvc6CvEaF6RfxQ28Upl0MUkSG4xk8wal7DciA106WZBB5ktssbCeqeKtd+NT1Wi8z90bO0Ilk+tc7wUJT/XUGWZYQaANbP3Thlgas+j/+TztC0uFro2GaTwOZpDkycvzimdZwyAoy3i284hW+tUTowbHAvK63J5l0dcaG2YKjEKHf3ClmUR4UKBQakfrHHMDXSBzydLH0Fi9uUM7DyHMujGdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5197.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199021)(9686003)(53546011)(6506007)(122000001)(41300700001)(316002)(186003)(7696005)(33656002)(478600001)(71200400001)(54906003)(966005)(86362001)(66946007)(76116006)(66476007)(66446008)(64756008)(66556008)(55016003)(6916009)(4326008)(7416002)(52536014)(5660300002)(38100700002)(8936002)(8676002)(2906002)(83380400001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTBhK3JWTnlnSGRPL0JhazUvUStIN0NaeWhjeS9HV3lpQkhhc3VhakFIa0hF?=
 =?utf-8?B?dGxYMkxpTTRDWTI0aEVDVFUvZXI2UkNucmNHcTBiV3FVVUtUbDBhTWVwTlhG?=
 =?utf-8?B?SjE0ZUpJT0VlRnMreFlSS2pxT2twQTR2ZGhxSit3RDdBZEV0RVpLRjRORjRF?=
 =?utf-8?B?MDhycklmYkxmN09oWWF4c3JmTU1abE0xencvVGdrR2N6cFlOYWNZT1hhME9K?=
 =?utf-8?B?ZlJwR0pKY091MGxtM3FVRU04NWM1QUJFWVphUmIvbWdRZzI2a2wrMU9Oc1Zn?=
 =?utf-8?B?YkFXOEdxSURhQ3plRE45T056YUpYeGxMZkhveHpIdFlpckhmVnM0aEhlNmtp?=
 =?utf-8?B?dGFTcVJJY1BlMzZoRm1zNnVVSXBIUWZha0ViNUlFNHNPamVIT1R2S3VRZTc2?=
 =?utf-8?B?YkNsL0hNMmExK2lyelN4Y1FXNmJtTEVDeVZmTGhXajBSaGI0TjF5WlpRd2o3?=
 =?utf-8?B?Qzkvd1o4VjUxMFZaQzF4L0hYejJkWmFTNTJnVWZZZXlZRHVRTWhLWE9jQkMy?=
 =?utf-8?B?NDNtckd3cEFTZVlSR1gzdmZkQ2h5SDdhbmRNMEdFOHhlanUzWHNxTUdYTWVt?=
 =?utf-8?B?QVZYSU93NHVDQ3JZem1IQWwxb0FUWkxFdWtRUW05cjhzdnhDenhLcTF3TTBJ?=
 =?utf-8?B?VVFCbkd4aFpJeFM1cS9US01ha1diOGQyZGE1L29Gc1pvMHphU1NicjYyWDNQ?=
 =?utf-8?B?eFNjTys4MW9XY0J1RmVOL0VCcGVpclRVdHNXRW01OEtQMWNCQTNIRVk2R0NT?=
 =?utf-8?B?QXplZlVwSjJubDNSMkVSTm8yREtQakk0K0QxS1JvU0NJQ0pkTlNPVmFoSGps?=
 =?utf-8?B?SnhnaUZZK3ZaQk1PTHNjcnRLRCsxdm5OaTF3ZklYTVZjVHFXT1A3TVh2ZSty?=
 =?utf-8?B?TnJUQW5mR0xZUCtOV3hCQWU3T2lZZDRCUElMUC9xSDNPZGpqa0x1U3VVZlJl?=
 =?utf-8?B?T3l2bDl1VWFJdVd3RFVXcmZkeDRqc3hzNjJkZWdLdzFMcVRLMlE5S050WmRX?=
 =?utf-8?B?WnFzWjFzS0hyekEvK2dCaXdYcU4vdkQ1SFQrM2tBajhJRTZtQnY2bjJhalNw?=
 =?utf-8?B?cm1OTURXVFlIOU1WR0gvTnRtbmY3RDcvMi80SC9CT05WdStDQWpFa3pFNmZ2?=
 =?utf-8?B?Z3JwanpTWWxYRWJ3RU9UaWdtdFlTVW5YemlrbmNDZG1MZTExVGx5UlZ5UWIv?=
 =?utf-8?B?VVIwT1V5RitzQUxJSEFyTkwrSTE1UHVtV2gray9NNVpwSnllc1J0WTZOKytL?=
 =?utf-8?B?VGs1SnpXZjgyN0I4RjZQcW5pa1d0bG80Z0dqY1pKY1ppdW9IY0NIVGpRUXI1?=
 =?utf-8?B?VmMwSmxPdFZHOFJ2NnQxUmc1c3JvZFpUYXpnK1ZHMURSeFRLejlpOEIvdkZ4?=
 =?utf-8?B?aW5jeS9XM1ZYenJ1Z09GMGc4Q2J2bzlLcFZvRFBlWVpBS0d6VkFDK25EQjdh?=
 =?utf-8?B?MzAzNHA3cE9PTGN5djZYSlJvVXY5WWdlM3B5OVIzYitkQWdIa0J5dG1aNXZx?=
 =?utf-8?B?Sm9wTmdCM3YzdTUzdUZBZ0xkcVlHd291aWxOZE9mdzI0cVYxejVvbi9sS2Zw?=
 =?utf-8?B?Y0VKaTdPNGVqM1gwVDZZMDBwcHRCYktUZ0RPS2VXdVJQMXJEelk4WnF4Mm1U?=
 =?utf-8?B?Wm1TbEpLMi92Vm9kblA3RllYbmZnRlRGdHN1ZlNubElmZHBoZExLdy9rNDFT?=
 =?utf-8?B?bkhsVm5uWFZuUDJuTlhHVGxIR1ZaTmx1VXE3bThvTnBpTnNpdExlNXFYUlVx?=
 =?utf-8?B?VStkMThQVzhDaXNjZXNhUW1RL0RaMk8rQW91Sm90ZTFrVU0wc0haN2Y1MjZ3?=
 =?utf-8?B?TEozeUM5Zi9NOHhJT085YnNQemxHMUUvVlRnL2F3VDhpclh4eUFQU29zc01N?=
 =?utf-8?B?SWg1MEo5Yzc5YXJBREQ3dFpyeFR2QWlFNURrU1Y5RW9yODhzODhsOTBIdW44?=
 =?utf-8?B?THNsNVBkSlMvOTF2TGFBQm5XT2xvM2dYQ3VzbkdORXZqNTY5WWQvbnRUM2FC?=
 =?utf-8?B?RmFCblJEeUpjUnEvQWlWUjVtNm16R1J5UkJqdkhDUUE5cjRXaGVTZ21ybHdm?=
 =?utf-8?B?bWlINFR5VDUyRng1MW1UZTV4TDg5NEhsSUYrTEdlMmt6N2RIMTlWK1VoYVJy?=
 =?utf-8?Q?2bz4YujCfMfyravJSF3boFa1q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5197.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008fde58-6332-4d6e-2094-08db3ff124af
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 09:41:53.8177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JZR2WS8/uOOzi65vmOnoCZwYAQWBUupNuOtWwRxLcaWTuL/7FHkbNksmQDBY/Kp4pAp0ZT4KX3E52sUzt9tfb4ZuqXSCOzq/l5EgFUw504k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5025
X-Proofpoint-ORIG-GUID: SBRS77valuqNYUlLGFncc-f2O79n9hdx
X-Proofpoint-GUID: SBRS77valuqNYUlLGFncc-f2O79n9hdx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_05,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180083
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIDE3LzA0LzIwMjMgMjM6NDMsIEFyc2xhbmJlbnplciwgWmV5bmVwIHdyb3RlOg0KPj4+IE9u
IDIwLzEyLzIwMjIgMTQ6MjIsIFpleW5lcCBBcnNsYW5iZW56ZXIgd3JvdGU6DQo+Pj4+IFRoaXMg
cGF0Y2ggYWRkcyBkZXZpY2UgdHJlZSBiaW5kaW5nIGRvY3VtZW50YXRpb24gZm9yIE1BWDc3NjU5
IGNoYXJnZXIuDQo+Pj4NCj4+PiBEbyBub3QgdXNlICJUaGlzIGNvbW1pdC9wYXRjaCIuDQo+Pj4g
aHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xp
bnV4L3Y1LjE3LjEvDQo+Pj4gc291cmNlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5n
LXBhdGNoZXMucnN0Kkw5NV9fOz5JdyEhQTNOaThDDQo+Pj4gUzB5MlkhLUFuSG1JVGhiQjVRODhf
ZEZkdmVFbXNYbHNmZmxSWERhYmY2UlZFNXlTUnVzTXhQMjRORWZBcjhSQ3N1MjZMDQo+Pj4gVHZv
YUlJTXZFRHIyWXhERUNyR2xNd1I4LXl3dm9SNjJyWEIwVyQNCj4+Pg0KPj4+Pg0KPj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBOdXJldHRpbiBCb2x1Y3UgPE51cmV0dGluLkJvbHVjdUBhbmFsb2cuY29tPj4N
Cj4+Pj4gU2lnbmVkLW9mZi1ieTogWmV5bmVwIEFyc2xhbmJlbnplciA8WmV5bmVwLkFyc2xhbmJl
bnplckBhbmFsb2cuY29tPj4NCj4+Pj4gLS0tDQo+Pj4+ICAuLi4vcG93ZXIvc3VwcGx5L2FkaSxt
YXg3NzY1OS1jaGFyZ2VyLnlhbWwgICAgfCA0MiArKysrKysrKysrKysrKysrKysrDQo+Pj4+ICBN
QUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSArDQo+Pj4+
ICAyIGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKykNCj4+Pj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NA0KPj4+PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvc3VwcGx5
L2FkaSxtYXg3NzY1OS1jaGFyZ2VyLg0KPj4+PiB5YQ0KPj4+PiBtbA0KPj4+Pg0KPj4+PiBkaWZm
IC0tZ2l0DQo+Pj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3N1
cHBseS9hZGksbWF4Nzc2NTktY2hhcmdlci4NCj4+Pj4geWFtbA0KPj4+PiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9zdXBwbHkvYWRpLG1heDc3NjU5LWNoYXJnZXIu
DQo+Pj4+IHlhbWwNCj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+Pj4gaW5kZXggMDAwMDAw
MDAwMDAwLi4yNGY4YjVhMmJkODQNCj4+Pj4gLS0tIC9kZXYvbnVsbA0KPj4+PiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvc3VwcGx5L2FkaSxtYXg3NzY1OS1j
aA0KPj4+PiArKysgYXINCj4+Pj4gKysrIGdlci55YW1sDQo+Pj4+IEBAIC0wLDAgKzEsNDIgQEAN
Cj4+Pj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSBPUiBCU0QtMi1D
bGF1c2UgJVlBTUwgMS4yDQo+Pj4+ICstLS0NCj4+Pj4gKyRpZDogDQo+Pj4+ICtodHRwczovL3Vy
bGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvcG93ZXIvc3Vw
DQo+Pj4+ICtwbCANCj4+Pj4gK3kvYWRpLG1heDc3NjU5LWNoYXJnZXIueWFtbCpfXztJdyEhQTNO
aThDUzB5MlkhLUFuSG1JVGhiQjVRODhfZEZkdmUNCj4+Pj4gK0VtIA0KPj4+PiArc1hsc2ZmbFJY
RGFiZjZSVkU1eVNSdXNNeFAyNE5FZkFyOFJDc3UyNkxUdm9hSUlNdkVEcjJZeERFQ3JHbE13Ujgt
eQ0KPj4+PiArd3YNCj4+Pj4gK29SNXJLVVIxMSQNCj4+Pj4gKyRzY2hlbWE6IA0KPj4+PiAraHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVt
YXMvY29yZQ0KPj4+PiArLnkgDQo+Pj4+ICthbWwqX187SXchIUEzTmk4Q1MweTJZIS1BbkhtSVRo
YkI1UTg4X2RGZHZlRW1zWGxzZmZsUlhEYWJmNlJWRTV5U1J1DQo+Pj4+ICtzTSB4UDI0TkVmQXI4
UkNzdTI2TFR2b2FJSU12RURyMll4REVDckdsTXdSOC15d3ZvUnlfeVdXQlMkDQo+Pj4+ICsNCj4+
Pj4gK3RpdGxlOiBCYXR0ZXJ5IGNoYXJnZXIgZm9yIE1BWDc3NjU5IFBNSUMgZnJvbSBBREkuDQo+
Pj4NCj4+PiBEcm9wIGZ1bGwgc3RvcC4NCj4+Pg0KPj4+PiArDQo+Pj4+ICttYWludGFpbmVyczoN
Cj4+Pj4gKyAgLSBOdXJldHRpbiBCb2x1Y3UgPE51cmV0dGluLkJvbHVjdUBhbmFsb2cuY29tPj4N
Cj4+Pj4gKyAgLSBaZXluZXAgQXJzbGFuYmVuemVyIDxaZXluZXAuQXJzbGFuYmVuemVyQGFuYWxv
Zy5jb20+Pg0KPj4+PiArDQo+Pj4+ICtkZXNjcmlwdGlvbjogfA0KPj4+PiArICBUaGlzIG1vZHVs
ZSBpcyBwYXJ0IG9mIHRoZSBNQVg3NzY1OSBNRkQgZGV2aWNlLiBGb3IgbW9yZSBkZXRhaWxzDQo+
Pj4+ICsgIHNlZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2FkaSxtYXg3
NzY1OS55YW1sLg0KPj4+PiArDQo+Pj4+ICsgIFRoZSBjaGFyZ2VyIGlzIHJlcHJlc2VudGVkIGFz
IGEgc3ViLW5vZGUgb2YgdGhlIFBNSUMgbm9kZSBvbiB0aGUgZGV2aWNlIHRyZWUuDQo+Pj4+ICsN
Cj4+Pj4gK3Byb3BlcnRpZXM6DQo+Pj4+ICsgIGNvbXBhdGlibGU6DQo+Pj4+ICsgICAgY29uc3Q6
IGFkaSxtYXg3NzY1OS1jaGFyZ2VyDQo+Pj4+ICsNCj4+Pj4gKyAgcmVnOg0KPj4+PiArICAgIG1h
eEl0ZW1zOiAxDQo+Pj4+ICsNCj4+Pj4gKyAgYWRpLGZhc3QtY2hhcmdlLXRpbWVyOg0KPj4+PiAr
ICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPj4+PiAr
ICAgIGRlc2NyaXB0aW9uOiBGYXN0LWNoYXJnZSBzYWZldHkgdGltZXIgdmFsdWUgKGluIGhvdXJz
KS4NCj4+Pg0KPj4+IE5vLCB1c2Ugc3VmZml4ZXMgZm9yIGNvbW1vbiB1bml0cy4NCj4+IA0KPj4g
SGkgS3J6eXN6dG9mLA0KPj4gDQo+PiBUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3LiBUaGUgcG9z
c2libGUgcmVnaXN0ZXIgdmFsdWVzIG9mIHRoZSBmYXN0IGNoYXJnZSBzYWZldHkgdGltZXIgYXJl
IGRlc2NyaWJlZCBpbiB0aGUgZGF0YXNoZWV0IGFzIGZvbGxvd3MuIEkgd2FzIHVuZGVjaWRlZCBh
Ym91dCB1c2luZyB0aGUgY29tbW9uIHVuaXQsIHNlY29uZCwgYXMgaXQgbWF5IGFmZmVjdCB0aGUg
Y29tcHJlaGVuc2liaWxpdHkgb2YgdGhlIGNvZGUuIE9mIGNvdXJzZSwgSSBjYW4gdXNlIHNlY29u
ZCBhcyB0aGUgY29tbW9uIHVuaXQgaWYgeW91IHRoaW5rIGl0J3MgbW9yZSBhcHByb3ByaWF0ZS4N
Cj4NCj5UaGlzIGlzIHF1aXRlIGNvbW1vbiBwcm9wZXJ0eSwgc28gSSBkbyBub3QgdW5kZXJzdGFu
ZCB3aHkgdGhpcyBvbmUgZHJpdmVyIHNob3VsZCBoYXZlIGl0IHdyaXR0ZW4gZGlmZmVyZW50bHku
IEkgdW5kZXJzdGFuZCB0aGF0IHBhcnNpbmcNCj4wLzEvMi8zIGlzIGVhc2llciBmb3IgdGhlIG1h
Y2hpbmUgdGhhbiAwLzMvNS83IGJ1dCBpdCBpcyBub3QgZWFzaWVyIGZvciBodW1hbnMuDQoNCkkg
cmVmZXJlbmNlZCBwcm9wZXJ0eS11bml0cy55YW1sIGZvciBjb21tb24gdW5pdHMuDQoNCkFzIEkg
dW5kZXJzdG9vZCBob3VycyBhbmQgbWludXRlcyBhcmUgbm90IGNvbW1vbiB1bml0cyBpbiBMaW51
eCBmb3IgdGltZSBzbyBJIGNhbm5vdCB1c2UgdGhlbSBhcyBzdWZmaXhlcy4gVGhlcmVmb3JlLCBJ
IHRob3VnaHQgSSBoYWQgdG8gdXNlICJzZWNvbmRzIiBpbnN0ZWFkIG9mICJob3VycyIgb3IgIm1p
bnV0ZXMiLiBJIGFtIHRvdGFsbHkgZmluZSBpZiBJIGNhbiB1c2UgIiBhZGksZmFzdC1jaGFyZ2Ut
dGltZXItaG91cnMiIGFuZCAiYWRpLHRvcG9mZi10aW1lci1taW51dGVzIi4gDQoNCj4NCj4+IA0K
Pj4gMGIwMCA9IFRpbWVyIGRpc2FibGVkDQo+PiAwYjAxID0gMyBob3Vycw0KPj4gMGIxMCA9IDUg
aG91cnMNCj4+IDBiMTEgPSA3IGhvdXJzDQo+PiANCj4+Pg0KPj4+PiArDQo+Pj4+ICsgIGFkaSxm
YXN0LWNoYXJnZS1taWNyb2FtcDoNCj4+Pj4gKyAgICBkZXNjcmlwdGlvbjogRmFzdC1jaGFyZ2Ug
Y29uc3RhbnQgY3VycmVudCB2YWx1ZS4NCj4+Pg0KPj4+PiArDQo+Pj4+ICsgIGFkaSx0b3BvZmYt
dGltZXI6DQo+Pj4+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMv
dWludDMyDQo+Pj4+ICsgICAgZGVzY3JpcHRpb246IFRvcC1PZmYgdGltZXIgdmFsdWUgKGluIG1p
bnV0ZXMpLg0KPj4+DQo+Pj4gTm8sIHVzZSBzdWZmaXhlcyBmb3IgY29tbW9uIHVuaXRzLg0KPj4g
DQo+PiBTaW1pbGFyIGNhc2U6DQo+PiANCj4+IDBiMDAwID0gMCBtaW51dGVzIA0KPj4gMGIwMDEg
PSA1IG1pbnV0ZXMgDQo+PiAwYjAxMCA9IDEwIG1pbnV0ZXMgDQo+PiAwYjAxMSA9IDE1IG1pbnV0
ZXMgDQo+PiAwYjEwMCA9IDIwIG1pbnV0ZXMgDQo+PiAwYjEwMSA9IDI1IG1pbnV0ZXMgDQo+PiAw
YjExMCA9IDMwIG1pbnV0ZXMgDQo+PiAwYjExMSA9IDM1IG1pbnV0ZXMNCj4NCj5Db21lIG9uLCB0
aGlzIGlzIGVhc3kgdG8gcGFyc2UuIERpdmlkZSBieSA1IGFuZCB3aGVyZSBpcyB0aGUgY29kZQ0K
PmNvbXBsZXhpdHk/DQo+DQo+QmVzdCByZWdhcmRzLA0KPktyenlzenRvZg0KPg0K
