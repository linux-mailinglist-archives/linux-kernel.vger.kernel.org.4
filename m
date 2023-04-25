Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD016EEA2E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 00:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbjDYWDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 18:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjDYWDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 18:03:44 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECBDDE;
        Tue, 25 Apr 2023 15:03:43 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PI2fBe006265;
        Tue, 25 Apr 2023 18:03:33 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3q4cg7wgjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 18:03:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gr+rlxFueD+5K/y1PaPtSoo+hDIYDk2YmOih/KUSlpAlg3FMNz0fgoka6jIsNYlxV+QJ41IfXHe8y2n1p2Wm9XOlBRCxy5gdd3W/490dAUbO6zQO9JAMC2irMwY/Do3JrsZhYlYeXQaa/ZProlOCOyLrK+GDw16r8MHj1PhbVW2yOBLeZB1ugubE9wT2zDZRtcVbNamrIYwnP8XiWLogcXcay9AJ3qu0uWIIJUHdpJvEiojA0zGr/a4xCL+fwT5tOpYzgvMBYWmYBZiYJgnwgQV+84WALrWz9ZOAGJ18iQrpGBQKqxcCt69Gxyqp4eCIcLRQaF3WWdQgbBZQNbUYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEPT3Q4AcvH8yF/0CwRfDdTbQJA8PDCeT/mOh1FQwRE=;
 b=Bac0p0WRl5dL5qLYfagKQQs7rw6k8xc+1DvEDKHl3dA+ndri+DFiA29OXdkS8+I7nA7nj595Zhsvs8g6PWOyQbLUMmED6WsXFQK7b/JSvfIwoI0ahj80SQ7CJr9ubUH7Ro35V+oReTq2kZAmseaH88dgsC6an988173duWWEz/2eBhCn3T0u/x5uW8yRMw5s6POCJpDWCRXQNNWjwrlm8NSiXrmL1TTLZXmkfT1RDPkFBqNbz3biotWq3QuFDD/LHecglABSCK8WvKVE5+weP3w9B5fjueuK7qrNMtGRwyg9VhcfOUhgGxZrLXG9K/+yeyw3TWL3dRDiu+eJsCcbfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEPT3Q4AcvH8yF/0CwRfDdTbQJA8PDCeT/mOh1FQwRE=;
 b=9kI04BtRtPOplYj7xgx/UH3lI9NtzUyL8aAyAJniloxHR7wiNuycufoQ/JBRE44rXuBkPzxHZZqbYbhQjuD3tXWApNsPjJ6orbAfAkJ3M6RwFVhVvQxxvhB9xkXLCoVtIZJXdiawW1T0zfISBdtRy4Yu/2m0TDLB9P8HpCCNTyE=
Received: from MN2PR03MB5197.namprd03.prod.outlook.com (2603:10b6:208:1f0::18)
 by MN2PR03MB5342.namprd03.prod.outlook.com (2603:10b6:208:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 22:03:24 +0000
Received: from MN2PR03MB5197.namprd03.prod.outlook.com
 ([fe80::c8df:77bc:8e3c:f92b]) by MN2PR03MB5197.namprd03.prod.outlook.com
 ([fe80::c8df:77bc:8e3c:f92b%5]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 22:03:24 +0000
From:   "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
To:     Lee Jones <lee@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v2 8/8] mfd: max77658: Add ADI MAX77643/54/58/59 MFD
 Support
Thread-Topic: [PATCH v2 8/8] mfd: max77658: Add ADI MAX77643/54/58/59 MFD
 Support
Thread-Index: AQHZXINeEVIC3kkykUqcpgTtpflY8a8TThwAgCZDlXCAAMt/AIACYz0Q
Date:   Tue, 25 Apr 2023 22:03:24 +0000
Message-ID: <MN2PR03MB51973EDD4FEDA00200B61C6A8B649@MN2PR03MB5197.namprd03.prod.outlook.com>
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
 <20230322055628.4441-9-Zeynep.Arslanbenzer@analog.com>
 <20230330123136.GF434339@google.com>
 <DM6PR03MB519577728975E086D8EB20F38B669@DM6PR03MB5195.namprd03.prod.outlook.com>
 <20230424085942.GA8035@google.com>
In-Reply-To: <20230424085942.GA8035@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jZW1WNWJtVndMbUZ5YzJ4aGJtSmxibnBsY2x4aGNIQmtZWFJoWEhKdllX?=
 =?utf-8?B?MXBibWRjTURsa09EUTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdK?=
 =?utf-8?B?aE1qbGxNelZpWEcxelozTmNiWE5uTFdaa05UUmxaV0ZtTFdVellqUXRNVEZs?=
 =?utf-8?B?WkMxaVpqUTFMVFpqT1RRMk5tUmpNRGt4T1Z4aGJXVXRkR1Z6ZEZ4bVpEVTBa?=
 =?utf-8?B?V1ZpTVMxbE0ySTBMVEV4WldRdFltWTBOUzAyWXprME5qWmtZekE1TVRsaWIy?=
 =?utf-8?B?UjVMblI0ZENJZ2MzbzlJalU0T1RJaUlIUTlJakV6TXpJMk9UTXpPREF4TWpV?=
 =?utf-8?B?NE1qRTJNeUlnYUQwaWRsaHFkVmxEUm05SU9GRmFNekExWldaeGEyWlRSMmgy?=
 =?utf-8?B?TDFsQlBTSWdhV1E5SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJR?=
 =?utf-8?B?VUZGVWtoVk1WSlRVbFZHVGtOblZVRkJSVzlEUVVGQlZFRmlSeTkzV0daYVFW?=
 =?utf-8?B?VjVha3QwYkM4cmJqUkZWRXROY1RKWUx6Wm1aMUZFUVVGQlFVRkJRVUZCUVVG?=
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
x-ms-traffictypediagnostic: MN2PR03MB5197:EE_|MN2PR03MB5342:EE_
x-ms-office365-filtering-correlation-id: dcc25c49-502d-4867-9768-08db45d8e411
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VBRsP9w+bbVnzjWZOiZ/eCIhA11bYEzjKSjvCq24PJpdMJpog9IgRkzdiOFSxdG+sJCyCB/joIrATXkwDG8+fgwIOijjlnAc1WIwpkGeCdJYQfk7+Abw0TfTiO3tRZ66x7aiNL0BdztbSgNXm64nA36E/nywF5pRm1T90at4YhetZMUuEIQlDLNPAcr/onPamCuCn1/z0Xxw2nKRkBBtQFj1Tlb0F+8y19lI7UtV4Ndi/3CkAHCnUaNeQTwbtMKFvaC1Ej/kznNb11onHygve+7XOiAF1F0vLlGsH5o+QecuP+b6v/W/brjxOZOEJb3i5k0AnQYmc9shquNR/v+aolL+zN8D28ASqSD9v/uv4IzD7MsXCgUdZI9ZFXMd+sw5WteS6t47nyiQxAHWNIuve4kj4kqw+ERf6TnM9otrSNvIAA0VNUbur0KJDvNdL6pY2LBnA6WB7uAjWJZyT3bBR04SHMFZvy3siktxnh366geMl01ArN32U5WQZYyjwekg6p32UmqIdQtMBa0Req/Cs1HUJ6pHe9uuN5iDxUPjaG4i/bt39mVJ9sw20i9Yndw5cJAVCGGR8A/2T3w4yNCJLID6LZ/KSIvtLv22SL4LgC50VWz3DG9tw1vyOfA/iQ6M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5197.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(54906003)(86362001)(186003)(26005)(9686003)(6506007)(55016003)(33656002)(71200400001)(4326008)(6916009)(64756008)(66556008)(316002)(66446008)(66476007)(66946007)(76116006)(2906002)(38100700002)(41300700001)(8676002)(122000001)(38070700005)(7696005)(5660300002)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3p5V2tMQ2dkTVNGNVZpNGttY04ybmhuNkFGN2tXMFdUVUZXQytWYmdhVkVW?=
 =?utf-8?B?SW5pTVpYMWlpczJjMjJwbDFmam5qQ012ME13V05mNHVZa3lheENEcmF0YUlJ?=
 =?utf-8?B?Zi81OHNGM0w4SEllNlEvV3RCR1lwdVBlU0trTzcxanhKS3IrSTE5RkY5UVJj?=
 =?utf-8?B?M1JHNWNuSTVnU2g4ZUxRUTNzR1MwM2RJT3lIYXBOY0xiUTBSQzI5UDFWWkxY?=
 =?utf-8?B?QTFidnAwV2psYVpNdktTSzRsUzM0V3JScG9PQjJtTDZUa1NVS3BXUkpSL1Nu?=
 =?utf-8?B?U0ZYYmdOdmVncDZqVWNJSlUxMzlZVFhTQ0E2enI1cEMvKzhJd2JTb2RIZTlE?=
 =?utf-8?B?ajZZVytoaFhkM0pDRkJPVTZENmFIc0labFdnWThVWUZMNllzMEMyYmppVllX?=
 =?utf-8?B?VzhiMVVZWDVCZWRIak1vVktFOXkzczh4Ky9pYXptTE0vWUNtbjV1YWRpbjFO?=
 =?utf-8?B?UWc2NzBtTGlXQ3NIQld6eVJVbnZwSlVOR2tHRmR4VDR0clRhaWQ0SGIwRytw?=
 =?utf-8?B?aDFaa081L3FFcUw2YlpzMVd3YThCU1JOTUFaSHd6VGNSb2M5d1hPR2xSdHFS?=
 =?utf-8?B?OTNZdXdRcWpGRHAvampBQS82bzhHWW9XK0NiKzZTdWZ5cExtazJDaFk5VEF4?=
 =?utf-8?B?Uk4yK3JmaHFCWXlwRW91MFo1SGFzYzZ3Q0NxdktPNklQT2hWOU5oZWVFNS9Q?=
 =?utf-8?B?M2NqQ0Rjc0ZNMDc3OTZtQUozdmkvdW1NaVk3Y2RQWXZnMEdkTTNha1pwcUp2?=
 =?utf-8?B?Y3QrYUVnZjBYUVI2WXJpdHdvRlNMdlJ3V2dKWUdFb0NyUEQ4djZ6K0ptTzVZ?=
 =?utf-8?B?MittVWFxT05RbHdRZ0IzeTNUTld4dGorYTRvYlZyVW5UdmM2RHNNVzMvdFR3?=
 =?utf-8?B?Mm1qTjJ3KzZBYXRIaVMxblQ5cTQ3amp0Q1hGdlR0bUE3Qms5T2V0N1BDYWRi?=
 =?utf-8?B?Q1kzR1I3R3ArdytaK0owNGw1YlhYNytMdkh1SFFhbTlRRnJjT2NyRkI2UXBs?=
 =?utf-8?B?QUcvanZjZ1JMaUJNb2lsaW4yZjdFUjgwNmFzUzVRaW9YRElHd3B4aFpNWlhM?=
 =?utf-8?B?Zmluc0JHYkFWNFdKT21uclBjOVBmSEs2R2VYa0oybDRpci83TXh0RlRCOWpt?=
 =?utf-8?B?YmxJVVBFTmlNcmsxM2NzNklNaTYxMC9IeDBRNWFTaGI3ZlZ4WGVJT2w0ZXlR?=
 =?utf-8?B?dFFQUCtlZlZwbGI3WE14NjRJVzRrRWx6TXlZODhyOGFkK3M3Zkh6R0pMYkV4?=
 =?utf-8?B?Ynl2U3VCRWFnVk9JWjkzbGpCcUN5M1plZzhKaXM1M01HbEN1R2I3ckFCTUUy?=
 =?utf-8?B?UFJKUzFpajlQREN1WFY5dkVrQnMvRXhBdFgwK20wQ1p2NDlMOHRVSFZxcmhZ?=
 =?utf-8?B?QThBRHpjbnRGbGxpZFRna2R2QlRPbzdMcS92b2hUN1BIRzduWDlvdHZKZFlM?=
 =?utf-8?B?L3QwdjNxTVdkSGgrTHd5bXl5N1RvbGZyUXdhai84bVJ0dVF3WTJDRzltUTg2?=
 =?utf-8?B?bnZRY1RURnBwVVdhRmxWcVFaYUxLbzg4bFhtNUxYQ0UzUmxHZFY3ZlhtVTlq?=
 =?utf-8?B?bHdwdlE2NjU4djlVUE8yaWJFQ3hybzVWRWFiVnUzWmZQczBJOUpsQWxKRVps?=
 =?utf-8?B?NUZBYzFoL2xOUFJQZFQ5TXNqelZST3hIMXc0VTF5RUYrRWtQTUtWNU5XRzB0?=
 =?utf-8?B?MkJDem5BUGJsR2E4MHQ5V3RvZms3S0c3TTFuNlgyZEhBdEROdkQ4SUM3eStI?=
 =?utf-8?B?dDcyQUhvOTMzTDVhZU5SVGVWNUhlaG9NSDZ1T1ZLcUJKRVRzeXBpYjlLTnV4?=
 =?utf-8?B?VzA0WjZFeXA4amE4bmp0dHJrMmk3bGJ5K0tQcDlvTnR3ZXhDS3J5Y0xCdlZn?=
 =?utf-8?B?MHNqUFR1UjlSY3FaY0VFZkZUcVFHck53ejBiUzBFVExodTErKytjU0lyUlg2?=
 =?utf-8?B?MElzUjJyN2JpanE4emtoemYxaGIxNXBWSi94M3J0S251cUhVZ1F3ME9BWmU1?=
 =?utf-8?B?LytkUWFFNVRNb1BIc0RxYTV1SkpxakdyTmxCTmYzcDV6Nk9SNHNqZVVQL0NB?=
 =?utf-8?B?OU9CWDB2WXIzOG9kc1NHUEpZUGtJZXVHam9BRUlYQk5nQTM0QzFxcDdSMlBS?=
 =?utf-8?B?aG9ONFRSMlEvMkdWbXNKNnp0TGpadHhDY3JSSTh1ekNPcGpyZlJubE9KSHJw?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5197.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc25c49-502d-4867-9768-08db45d8e411
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 22:03:24.4549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jvTKlgisYQe/pvN72ZEfhjuCvGHyH1MS6scwF8rZfszaRRjuIBBelFufuSbJj5GbtyHX0C+FxCkP0zqNec7/oYBdIW2RFafBHftx0UbJKwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5342
X-Proofpoint-GUID: jP8rP53CXuxN0dQlDV_QaiceIT5GM1Qm
X-Proofpoint-ORIG-GUID: jP8rP53CXuxN0dQlDV_QaiceIT5GM1Qm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_08,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=740 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304250197
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyNCBBcHIgMjAyMywgTGVlIEpvbmVzIHdyb3RlOg0KPg0KPk9uIFN1biwgMjMgQXBy
IDIwMjMsIEFyc2xhbmJlbnplciwgWmV5bmVwIHdyb3RlOg0KPg0KPj4gT24gVGh1LCAzMCBNYXIg
MjAyMywgTGVlIEpvbmVzIHdyb3RlOg0KPj4gDQo+PiA+T24gV2VkLCAyMiBNYXIgMjAyMywgWmV5
bmVwIEFyc2xhbmJlbnplciB3cm90ZToNCj4+ID4NCj4+ID4+IE1GRCBkcml2ZXIgZm9yIE1BWDc3
NjQzL01BWDc3NjU0L01BWDc3NjU4L01BWDc3NjU5IHRvIGVuYWJsZSBpdHMgDQo+PiA+PiBzdWIN
Cj4+ID4NCj4+ID5QbGVhc2UgZHJvcCBhbGwgcmVmZXJlbmNlcyB0byAnTUZEJy4NCj4+ID4NCj4+
ID5XaGF0IGFyZSB0aGVzZSBkZXZpY2VzLCByZWFsbHk/ICBJIHN1c3BlY3QgdGhleSBhcmUgUE1J
Q3M/DQo+PiA+DQo+PiA+PiBkZXZpY2VzLg0KPj4gPj4NCj4+ID4+IFRoZSBNQVg3NzY0MyBpcyBh
IG11bHRpLWZ1bmN0aW9uIGRldmljZXMuIEl0IGluY2x1ZGVzIHJlZ3VsYXRvci4NCj4+ID4+DQo+
PiA+PiBUaGUgTUFYNzc2NTQgaXMgYSBtdWx0aS1mdW5jdGlvbiBkZXZpY2VzLiBJdCBpbmNsdWRl
cyByZWd1bGF0b3IgYW5kIA0KPj4gPj4gY2hhcmdlci4NCj4+ID4+DQo+PiA+PiBUaGUgTUFYNzc2
NTggaXMgYSBtdWx0aS1mdW5jdGlvbiBkZXZpY2VzLiBJdCBpbmNsdWRlcyByZWd1bGF0b3IsIA0K
Pj4gPj4gY2hhcmdlciBhbmQgYmF0dGVyeS4NCj4+ID4+DQo+PiA+PiBUaGUgTUFYNzc2NTkgaXMg
YSBtdWx0aS1mdW5jdGlvbiBkZXZpY2VzLiBJdCBpbmNsdWRlcyByZWd1bGF0b3IgYW5kIA0KPj4g
Pj4gY2hhcmdlci4NCj4+ID4+DQo+PiA+PiBTaWduZWQtb2ZmLWJ5OiBOdXJldHRpbiBCb2x1Y3Ug
PE51cmV0dGluLkJvbHVjdUBhbmFsb2cuY29tPg0KPj4gPj4gU2lnbmVkLW9mZi1ieTogWmV5bmVw
IEFyc2xhbmJlbnplciA8WmV5bmVwLkFyc2xhbmJlbnplckBhbmFsb2cuY29tPg0KPj4gPj4gLS0t
DQo+PiA+PiAgZHJpdmVycy9tZmQvS2NvbmZpZyAgICAgICAgICB8ICAxNSArKw0KPj4gPj4gIGRy
aXZlcnMvbWZkL01ha2VmaWxlICAgICAgICAgfCAgIDEgKw0KPj4gPj4gIGRyaXZlcnMvbWZkL21h
eDc3NjU4LmMgICAgICAgfCA0NDggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4+ID4+ICBpbmNsdWRlL2xpbnV4L21mZC9tYXg3NzY1OC5oIHwgIDg4ICsrKysrKysNCj4+ID4+
ICA0IGZpbGVzIGNoYW5nZWQsIDU1MiBpbnNlcnRpb25zKCspICBjcmVhdGUgbW9kZSAxMDA2NDQg
DQo+PiA+PiBkcml2ZXJzL21mZC9tYXg3NzY1OC5jICBjcmVhdGUgbW9kZSAxMDA2NDQgDQo+PiA+
PiBpbmNsdWRlL2xpbnV4L21mZC9tYXg3NzY1OC5oDQo+PiA+Pg0KPj4gPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbWZkL0tjb25maWcgYi9kcml2ZXJzL21mZC9LY29uZmlnIGluZGV4DQo+PiA+PiA4
YjkzODU2ZGU0MzIuLjdiNGJlN2ZiODY2MiAxMDA2NDQNCj4+ID4+IC0tLSBhL2RyaXZlcnMvbWZk
L0tjb25maWcNCj4+ID4+ICsrKyBiL2RyaXZlcnMvbWZkL0tjb25maWcNCj4+ID4+IEBAIC04MjEs
NiArODIxLDIxIEBAIGNvbmZpZyBNRkRfTUFYNzc2NTANCj4+ID4+ICAJICB0aGUgZm9sbG93aW5n
IGZ1bmN0aW9uYWxpdGllcyBvZiB0aGUgZGV2aWNlOiBHUElPLCByZWd1bGF0b3IsDQo+PiA+PiAg
CSAgY2hhcmdlciwgTEVELCBvbmtleS4NCj4+ID4+DQo+PiA+PiArY29uZmlnIE1GRF9NQVg3NzY1
OA0KPj4gPj4gKwl0cmlzdGF0ZSAiQW5hbG9nIERldmljZXMgTUFYNzc2NDMvTUFYNzc2NTQvTUFY
Nzc2NTgvTUFYNzc2NTkgUE1JQyBTdXBwb3J0Ig0KPj4gPj4gKwlkZXBlbmRzIG9uIEkyQw0KPj4g
Pj4gKwlkZXBlbmRzIG9uIE9GDQo+PiA+PiArCXNlbGVjdCBNRkRfQ09SRQ0KPj4gPj4gKwlzZWxl
Y3QgUkVHTUFQX0kyQw0KPj4gPj4gKwlzZWxlY3QgUkVHTUFQX0lSUQ0KPj4gPj4gKwloZWxwDQo+
PiA+PiArCSAgU2F5IFkgaGVyZSB0byBhZGQgc3VwcG9ydCBmb3IgQW5hbG9nIERldmljZXMNCj4+
ID4+ICsJICBNQVg3NzY0My9NQVg3NzY1NC9NQVg3NzY1OC9NQVg3NzY1OSBQb3dlciBNYW5hZ2Vt
ZW50IElDLg0KPj4gPg0KPj4gPiJNQVg3NzZ4eCBzZXJpZXMiPw0KPj4gDQo+PiBBcyBJIHJlYWxp
emVkIGxhdGVyLCBtYXg3NzYyMCwgbWF4Nzc2NTAsIG1heDc3Njg2LCBhbmQgbWF4Nzc2OTMgZHJp
dmVycyB3ZXJlIG1lcmdlZCB0byBMaW51eCBiZWZvcmUgb3VyIHBhdGNoLiBUaGV5IGFyZSBhbHNv
IFBNSUMgZGV2aWNlcyBhbmQgb3VyIHBhdGNoIGRvZXMgbm90IGNvdmVyIHRoZW0uIFRoZXJlZm9y
ZSwgSSB0aGluayBpdCB3b3VsZCBub3QgYmUgYXBwcm9wcmlhdGUgdG8gdXNlIE1BWDc3Nnh4Lg0K
Pg0KPlBlcmhhcHMgeW91IGNhbiBjb21lIHVwIHdpdGggc29tZXRoaW5nIGEgbGl0dGxlIG1vcmUg
c2NhbGFibGUgdGhlbi4NCj4NCj5XaGF0IGlmIHlvdSBhZGRlZCBzdXBwb3J0IGZvciBhbm90aGVy
IDEwIGRldmljZXM/DQo+DQpGb3Igbm93LCB3ZSBoYXZlIG5vIHBsYW5zIHRvIGFkZCBhbnkgbmV3
IGRldmljZSBzdXBwb3J0IHRvIHRoaXMgZHJpdmVyLiBXZSBuYW1lZCB0aGUgZHJpdmVyIG1heDc3
NjU4IGJlY2F1c2UgaXQgaGFzIHRoZSBtb3N0IGluY2x1c2l2ZSBmZWF0dXJlIGFtb25nIHRoZSBz
dXBwb3J0ZWQgZGV2aWNlcy4gV2UgY2FuIHNob3J0ZW4gaXQgdG8gTUFYNzc2NDMvNTQvNTgvNTkg
b3IganVzdCB0eXBlIG1heDc3NjU4IGluIEtjb25maWcgYW5kIHNwZWNpZnkgb3RoZXIgc3VwcG9y
dGVkIGRldmljZXMgaW4gdGhlIGRldmljZSB0cmVlLiBXb3VsZCBvbmUgb2YgdGhlc2UgYmUgYSBt
b3JlIHN1aXRhYmxlIHNvbHV0aW9uPw0KDQpCZXN0IHJlZ2FyZHMsDQpaZXluZXANCg==
