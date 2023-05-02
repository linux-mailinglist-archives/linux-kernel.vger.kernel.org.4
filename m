Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51E56F46A4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjEBPFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjEBPFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:05:42 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF52E2D55;
        Tue,  2 May 2023 08:05:28 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342DWk1F001491;
        Tue, 2 May 2023 11:05:20 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3qatj8bxmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 11:05:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tj947HS6kcmu5BweTxgHxO5+7c3c+FUod8bOBS5qLbcbeZbHvpx14SN0+ZrvNOkq4A3NPsZ/XimmwdNkOQ2nHY4xicIR8dHEetC9A9li0KrRjTb03VUAXCaYl5Q/e1AcgtMbktTB9odntnmobl17hXbzCd7C25POFrEKfMZP3swBx4ncn2NEfNemF78CpVJZsYNZ1IEmProKMcgLqt2Rp6a7C9hWWVjeCxXQ5WCO/ZUsk1ln9aYj82CwjBf6/sstXHVWiQ2d8tAuvzixS6YBmhR56iUO0AJhIGke+YuHnURWqiyFIAKTgs7xDkoMa6fwd+pmXCRdJe7P7JEpM6TUqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OpYeatC80jh9WAk3NJPHXgnt5Ul+ihyyIjGcuQ4URs=;
 b=ccskcA4CzFJVDplsymnRNgpq8e7KMZ7DBFEmWFMXpctV1RuIoEIdOiBtcpvJjd6OwLOGlD0jC2w+nJxQ5yHK9MhiXWOPJCBR1HKVL7bQy1trsIU8u5u9iBbdRLrlYw/AgOtg8l3MYsfUgrd1C++HkJ76sGqoaKkMJpyGgWy2Kdq1xreTOenH6x5iPSONvwdyF/u69NbI56zs6XaBBylAoxaPG+ihi73BZmwpJ4lCvhCqdvzCZiJAR+x2wX2UXbQFno2xk6dHqwNQ0APhCii+ZRzQGhUaV9sD/G1OV/S2/CwLCfOyLJvKdPdQUDQn/tn4e1jbjauzlPUQnaH2LHpsLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OpYeatC80jh9WAk3NJPHXgnt5Ul+ihyyIjGcuQ4URs=;
 b=HXWyWikY4slSi6yADguwIh6BwR2ce2lbnmDHo08CY2FQ6lH6YWbVHiSZuATzZPnoQ1VboPqViAtd8r35Qq8kMevk4FdSY2Vtz7Tk7kT1JqT/on7cnHCeC6WW5Wy+V6G9HdKxqht4R8pEtRKfqf/Vt9WJWh1l+5ZdSl7LQlIEsag=
Received: from MN2PR03MB5197.namprd03.prod.outlook.com (2603:10b6:208:1f0::18)
 by PH0PR03MB6559.namprd03.prod.outlook.com (2603:10b6:510:b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 15:05:18 +0000
Received: from MN2PR03MB5197.namprd03.prod.outlook.com
 ([fe80::c8df:77bc:8e3c:f92b]) by MN2PR03MB5197.namprd03.prod.outlook.com
 ([fe80::c8df:77bc:8e3c:f92b%5]) with mapi id 15.20.6363.020; Tue, 2 May 2023
 15:05:18 +0000
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
Subject: RE: [PATCH v2 5/8] dt-bindings: power: supply: max77658: Add ADI
 MAX77658 Battery
Thread-Topic: [PATCH v2 5/8] dt-bindings: power: supply: max77658: Add ADI
 MAX77658 Battery
Thread-Index: AQHZXINPA5Z0YHRJuk2oYLjOoq53Ia8GeBmAgD+WG0CAALi+AIAAigTg
Date:   Tue, 2 May 2023 15:05:18 +0000
Message-ID: <MN2PR03MB5197EB4B34DC82C62EF5A3798B6F9@MN2PR03MB5197.namprd03.prod.outlook.com>
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
 <20230322055628.4441-6-Zeynep.Arslanbenzer@analog.com>
 <afeecd42-ecda-4d92-bbb5-6dcff84fca7d@linaro.org>
 <MN2PR03MB5197BC6AEE58EFE098AF08358B6E9@MN2PR03MB5197.namprd03.prod.outlook.com>
 <1f520e8a-7785-f4dc-2f9b-d6afd1e3f671@linaro.org>
In-Reply-To: <1f520e8a-7785-f4dc-2f9b-d6afd1e3f671@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jZW1WNWJtVndMbUZ5YzJ4aGJtSmxibnBsY2x4aGNIQmtZWFJoWEhKdllX?=
 =?utf-8?B?MXBibWRjTURsa09EUTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdK?=
 =?utf-8?B?aE1qbGxNelZpWEcxelozTmNiWE5uTFdKbE0yUmtZVEptTFdVNFptRXRNVEZs?=
 =?utf-8?B?WkMxaVpqUmtMVEEwTjJKallqVmhZekU1WTF4aGJXVXRkR1Z6ZEZ4aVpUTmta?=
 =?utf-8?B?R0V6TVMxbE9HWmhMVEV4WldRdFltWTBaQzB3TkRkaVkySTFZV014T1dOaWIy?=
 =?utf-8?B?UjVMblI0ZENJZ2MzbzlJakkzTmpRaUlIUTlJakV6TXpJM05URXpOVEUxT1Rn?=
 =?utf-8?B?d09UVTJNeUlnYUQwaWNVRktNbEJMTUdkVVMyNUlSaTlzTlRWQ1FWcHlTWFI2?=
 =?utf-8?B?YTBJNFBTSWdhV1E5SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJR?=
 =?utf-8?B?VUZGVWtoVk1WSlRVbFZHVGtOblZVRkJSVzlEUVVGQlluUndaVUZDTXpOYVFW?=
 =?utf-8?B?cHlNMlpxVlRadlJrSkliWFprSzA1VWNXZFZSV05FUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: MN2PR03MB5197:EE_|PH0PR03MB6559:EE_
x-ms-office365-filtering-correlation-id: 24b41a0b-5824-4cf5-ea4e-08db4b1ea46a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kAKbDN/DFm/8GDtKhku9XKniNy4Y6szSzDPyh8CnZswu22OnTPgP0yWTLYkC4n8emI20LZqCD10GerjQ7P0mPkFqJ90hYcZENpMzYak9w7IDVZOvF7sypnKGpyCZJARjXFfvow3Hz/RbaNnqDOI76gzeLyW2Qa0HIsqAiQJP6bocNXyZm0wJyYVy2t0ncZcavPyT1FVbgQHDs8n7DJ4JwYbeR4dajtwJ/v3tRPEAQF4aVcxykyqbgZN/9sBUT2gA0M1vK8440MdXMXXDKmPL1QlaO1GS41mkP8jya3FweN9AiVnF54Asguz/MKYizzO9RnD+uWoS4gXrJopRqM8fj6hbdRZQhuAEdujvAi8BkUmy+ldHy/+tttB48P8Ths8sBxZWqk6091108IjWgLaFfYzAgGfnvmHdGr9pLY1NG0RaB8Xh4JRSDUQMHxxQGb6FKeoe2TPUnDsoOgyMlsvfJ3KGpbPaISKDv/45wAcXfz1ycBP0h5TWh/3pAcgmI5eb2bl2TRCS0A2/LYWAA/Vl59uMdByWprhAxjGBYzj19IngBBYDnzR6YYbEUiDaIh7z3e59of6+lLzlBpdXWAfuqCe38WHwjhowaBcW1paiFP+dPYyN2Sq/NYUR1PbZ5vp8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5197.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199021)(6506007)(9686003)(26005)(186003)(122000001)(38070700005)(38100700002)(83380400001)(8676002)(8936002)(5660300002)(7416002)(52536014)(41300700001)(2906002)(33656002)(55016003)(86362001)(54906003)(478600001)(71200400001)(7696005)(316002)(76116006)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGJqakx0MFRpbGk0MXJ4SmIyemtwVG9MMXJMWFYyZDlHenVJWVlqRUJXdE1w?=
 =?utf-8?B?NEE1QzJTTW14cVhPbVlYdkVsa3VvL2dGZEo1T1FmbEZOUHpHT1ZScHMrWTFk?=
 =?utf-8?B?MVN4bEJnOStaZ3RzS2dmR2JSUnBzaHYrZ1NHU0dUaGtkOS9Kd0RNVVNEczl5?=
 =?utf-8?B?OExaTVhiZ1R5anlZaVEybXZKQkNOcW1LU2p3QlFKMWdFZkxiMDdpd0JCK3pw?=
 =?utf-8?B?bldDOGRFL05UVnBmSTlJN0dVVzM1NEI4M2dTZ2lZUENhTVQzN0pEaytNdWNB?=
 =?utf-8?B?enhrbUdWa2MrV3FEU1B6WTFMWVcvTFkyRlNLNFNndzdwY0drT1NpV0pTeG50?=
 =?utf-8?B?eDB2Zm5ISlRyRUpnWWpmOEwrRzlvU1lKdU1yVUIwd1Z6N1ZIRlB4aFVqaFVI?=
 =?utf-8?B?bmEweXZXMldjNjFyRlZ4VDdWaUFRa2t3SGoreWRleDhRa3BlQjE0bGxSZlZZ?=
 =?utf-8?B?K3J1T3dsVUlpelAvNjF3cU1sNTlacGhZcU55ZFBXNzdRYklxb2lYSWlxNmxl?=
 =?utf-8?B?V1hVY3ZDaFpHUHUzNXNMQjUxaTBNZkZWZEp6dWNjT1VxY2poeEcxU3B1dWRq?=
 =?utf-8?B?MitSTHVTOUxrN2NaRTRwTGVhbTRxZy9nUUNPSk1FcldJZjN2Nm80eUl0SjBS?=
 =?utf-8?B?dHVXbnFJSk5ZbWhGbU05cjAwQngzOUpjeGRIM0ZlNEpIWEdvUHBtNTFuM0JY?=
 =?utf-8?B?REpja1Yra29lUDdxbFUrK2t5V3V5TDhVYW8rMmRONm83MCtzSmlrVEp2Qnhk?=
 =?utf-8?B?YnVTMXVjbHJab0RGalRQZm8xOFdoU1BJcHZBU1VzNUdtRGNtdSsxOTVVQVh6?=
 =?utf-8?B?MkdUOWxyenh3R2JxZzNnK3ZOU0tCd0F0SG1UMUh1OWxjTWhkeXdIVlQ0eGJO?=
 =?utf-8?B?Y245Y05PeU5CeUZnZ2hqNllCOU9FNVVKcTkzMkxmM3cvenowWk5vNHFmTlVM?=
 =?utf-8?B?UDJDZExQVHN3czk4Y2tpYUIyNGs2ZG1HSE9zNDd5TFlkTUxKUEMzTXkwWjl2?=
 =?utf-8?B?V2R1ZUk1SE5YSUVueHptMVVETDVNRyt5NldWSFkzOGs2Ym1rWk9vL1Jtd2oy?=
 =?utf-8?B?bHRkdzZxU2VibllaR0szb3JVTll1cTBHVjFDaXgxQld5MEtTMWo0R0czaFlX?=
 =?utf-8?B?SnZqWnE1bWJFKzJtREN1ekVuS05BM3dJazFBdzJYaWV5QS9GQ0FlSkpvbDU4?=
 =?utf-8?B?MFZGZC9jNGFsWW8rdXhyQndSUk5ReFU0cloyUlQxdWZCUTVnVTRtSzl3WWFW?=
 =?utf-8?B?VW9mUWJvN25vdkREeERlNmZUUnR4UEQ4UUkzL0ZhdmczNE9oZ2VzTTVDa2JG?=
 =?utf-8?B?K2JDV1Zhb0JrYVk0Z01lSU1KY3BmQ3RzdnZwdDJ4MjRoWFBvYXJaQmNVVFhw?=
 =?utf-8?B?MHNFaFhQUG04WHp5MkZhT054dVE4VHZOK1QxTkxlUkI5RW1tNUcrMkxQbzVE?=
 =?utf-8?B?M0tQdkFEd1pLTDBLV0wvcUk0Y3R4RDR3QnVtT05jWDdmZnoxbUlFQUtOTUQx?=
 =?utf-8?B?T2l6QVdDb0VzSzVVMXk5bnkwQVQwL1pVMmw4ZmN3T0crTGRBUFVSTEl2Rndj?=
 =?utf-8?B?WUVDM3lsbzlKQ3lNaEtKNmFKbENXWTVkSURCQ3hpejQrVUtQYUtsczN1QmdI?=
 =?utf-8?B?UGNFMWsyRy9JMkI3azlNOEY5bTdVaDVobnNyVWY4Szh5SnY0UkMrcDlkeUha?=
 =?utf-8?B?U2lnL2FPbXRPbWttd24xUVc5REp3Y1RNcWNmYktqcmxySllVQXlkcE1aYUxJ?=
 =?utf-8?B?WjdFR0JUd2hTcEdEMGNEYUJ0aFovTTFQNE1HOERNd1dIWGk0Y0k5aHdWK3dB?=
 =?utf-8?B?YTE5eXVkdWdzSkt2R1U3L0JWV3V0N2R0NGdVeXkvUTFPU2NNSE5lYlkyeVEv?=
 =?utf-8?B?cEI1OVB4bG1rRnAraTZPNWVGK2o1bm5Sb0dOR0x4bXY5SjZqK3J6TVV3Wmpy?=
 =?utf-8?B?NXdKTDZkeXFZM1JwY1VWaGVLNjZPeU5BbHlqdFhZZDZJNThUd3ZKZEZyVTBo?=
 =?utf-8?B?RUZpMEF5OW4zTUozeFA3d3E1MEFudXFnOUE3VGx4b2doeVQ0eVFsWTNYNnNz?=
 =?utf-8?B?SmZGdVFGSWlEQlRTbEpNYStiSDhRSWNZMkg2UnBVWE9OV1lrb0krcXJTNFF4?=
 =?utf-8?B?bUhQTjJVRktCdThwR04wUHU4RTVUckxwejJqQ0FsVEdsUk5vOVVWVGtZS2hN?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5197.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b41a0b-5824-4cf5-ea4e-08db4b1ea46a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 15:05:18.2311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8UA877Jipdy5COc3xEJraNQsfrmXUEG5cMcRsmLO9w5AqIFIP1DPZhCBR4ObphVPoR8O8FuAZc1nehkO5sLgjD8mFtZoa65eDyZL/14fZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6559
X-Proofpoint-GUID: oiy_x3YKi2IxpocPXC203pNn79NlCHbv
X-Proofpoint-ORIG-GUID: oiy_x3YKi2IxpocPXC203pNn79NlCHbv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=793
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020128
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyIE1heSAyMDIzLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPk9uIDAxLzA1
LzIwMjMgMjI6MjAsIEFyc2xhbmJlbnplciwgWmV5bmVwIHdyb3RlOg0KPg0KPj4+IFlvdSBhbHJl
YWR5IHNhaWQgaXQgYWJvdmUuDQo+Pj4NCj4+Pj4gKyAgICAgIGluIGJhdHRlcnkueWFtbCwgd2l0
aCB0aGUgZm9sbG93aW5nIHByb3BlcnRpZXMgYmVpbmcgcmVxdWlyZWQ6DQo+Pj4+ICsgICAgICAt
IGFsZXJ0LWNlbHNpdXMNCj4+Pj4gKw0KPj4+PiArcmVxdWlyZWQ6DQo+Pj4+ICsgIC0gY29tcGF0
aWJsZQ0KPj4+DQo+Pj4gV2h5IHJlZyBhbmQgbW9uaXRvcmVkLWJhdHRlciBhcmUgbm90IHJlcXVp
cmVkPw0KPj4+DQo+PiBJZiBubyBtb25pdG9yZWQtYmF0dGVyeSBpbmZvcm1hdGlvbiBpcyBzdXBw
bGllZCwgd2Ugc2V0IGRlZmF1bHQgdmFsdWVzIGZvciBhbGVydC1jZWxzaXVzLg0KPg0KPlNvIHRo
ZSBkZXZpY2UgY2FuIG9wZXJhdGUgd2l0aG91dCBiYXR0ZXJ5PyBJbnRlcmVzdGluZy4uLiBhcmUg
eW91IHN1cmUsIHlvdSBjYW4gcGh5c2ljYWxseSByZW1vdmUgYmF0dGVyeSBhbmQgZGV2aWNlIHdp
bGwgd29yaz8NCj4NCg0KSSBtZWFuIGlmIGJhdHRlcnkgaW5mbyBpcyBub3Qgc3VwcGxpZWQsIHdl
IHVzZSBkZWZhdWx0IHZhbHVlcy4NCg0KcmV0ID0gcG93ZXJfc3VwcGx5X2dldF9iYXR0ZXJ5X2lu
Zm8oZmctPmJhdHRlcnksICZpbmZvKTsNCmlmIChyZXQpIHsNCiAgICBkZXZfZXJyKGZnLT5kZXYs
ICJVbmFibGUgdG8gZ2V0IGJhdHRlcnkgaW5mb1xuIik7DQogICAgZmctPnRlbXBfYWxlcnRfbWlu
ID0gaW5mby0+dGVtcF9hbGVydF9taW47DQogICAgZmctPnRlbXBfYWxlcnRfbWF4ID0gaW5mby0+
dGVtcF9hbGVydF9tYXg7DQp9IGVsc2Ugew0KICAgIGZnLT50ZW1wX2FsZXJ0X21pbiA9IC0xMjg7
DQogICAgZmctPnRlbXBfYWxlcnRfbWF4ID0gMTI3Ow0KfQ0KDQoNCj4+IFRoZSByZWcgcHJvcGVy
dHkgaXMgdGhlIEkyQyBhZGRyZXNzIG9mIHRoZSBkZXZpY2UgYW5kIGl0IGlzIHBhcnQgb2YgdGhl
IHBhcmVudCBzY2hlbWEuIFRoZXJlZm9yZSwgYm90aCBhcmUgbm90IHJlcXVpcmVkIGluIHRoaXMg
ZmlsZS4NCj4NCj5XaGF0IGRvZXMgaXQgbWVhbiAiaW4gcGFyZW50IHNjaGVtYSI/IFlvdSBoYXZl
IHJlZyBoZXJlLCBzbyBob3cgcGFyZW50IHNjaGVtYSBpcyByZWxhdGVkIHRvIHRoaXM/DQoNCkl0
IGlzIG15IG1pc3Rha2UsIEkgd2lsbCByZW1vdmUgcmVnIGZyb20gaGVyZS4NCg0KQmVzdCByZWdh
cmRzLA0KWmV5bmVwDQo=
