Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEA373DE5C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjFZMBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjFZMBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:01:37 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D69E1B7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:01:36 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QAPrZt002220;
        Mon, 26 Jun 2023 08:01:20 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3rdwd4ubw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 08:01:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCsLrcoCH0Ppgm2gfoGGjYnj14JrYFHQyYD0/OFsQ7jXfLEiDwlcXzs//4pch3Pnb4E5+IVsu6J9jv/kUrxZ94Bnu58YzfYpzHzvwMbgQeCECJpz5rvY6XyC7uGunyD/xuWadS76UGblcC4T1gD3BiLQQI6ws/PZwKti6WfPNrWTWNxiZ+VVOr2LlcCCmwvoUNz9j1m4Q6lMwefAyttJreNBnRrawn/RpkoChxW3BhqF9rpBBfhvKkX9WF7HfXeR+Wb/+UoNFAsISlB0j3nGdtFIDbGOCvZNt2Ui2Lxi2f+Q1tdGoxX2SdPqj/mBjsRO9HYtlrxITBoQOQGrX+5rCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dahnOScMTM4laLjWaaUh2JT+UkUKmbiCUSvCAPSm11o=;
 b=iqOFM8B503+A8gXiL3YvFYuiRZIFGGNL8zfvY+EglTnnXTsmTcU1wjsXB7WKmrx7tYlFzNxjgDVPzfouRtP2blKFx9QPBS/fLdvo31WdiejisQkFD7KBX0rFIfBwEEocI8Z5Y4CVhIktxdutHnk/NGXkElBT1Jkuee/Sp3zXec89YyTdr2MAJn9yPUxlo+pib3GoMJ60tyOl2l4Z8OgeDN5uw5iTyqJVvMnU5KElTwXGGBbZ7M+Q8VmuV4IIACNQXfgWDBX4Y2QPkTsmfayLpCE29IiuSFTbVqNjxipVOxniBen5kM1cNq2RYDMcmExg2wRNu7G2pgpX990/be09pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dahnOScMTM4laLjWaaUh2JT+UkUKmbiCUSvCAPSm11o=;
 b=DpXpYarF1NsxJEfJJskfhJk36AwLTnNX3iBqhxlruzKceB8gqEM7D/X3pE5pNv5vSf8iZukKqyz4wzGyBatNtzeGH6xcQD7q604yeiJ3ei6UxWD/1zerHChHxhwkNiulaZTqyGa8bIZIhQ3kGfKpWq5E5uJcJN/W34ulTg/O/kI=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by BY5PR03MB5169.namprd03.prod.outlook.com (2603:10b6:a03:219::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 12:01:16 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::692c:1462:426b:5a9c]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::692c:1462:426b:5a9c%3]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 12:01:16 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Julien Panis <jpanis@baylibre.com>, Lee Jones <lee@kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH] mfd: Switch two more drivers back to use struct
 i2c_driver::probe
Thread-Topic: [PATCH] mfd: Switch two more drivers back to use struct
 i2c_driver::probe
Thread-Index: AQHZqA9hF8vYgTgxhUO72/YaomNtEK+c+uDA
Date:   Mon, 26 Jun 2023 12:01:16 +0000
Message-ID: <MN2PR03MB516846A1A4FD31515D98FA4BE726A@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20230626091941.557733-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230626091941.557733-1-u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYjJ0aGJpNXpZV2hwYmx4aGNIQmtZWFJoWEhKdllXMXBibWRjTURsa09E?=
 =?utf-8?B?UTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdKaE1qbGxNelZpWEcx?=
 =?utf-8?B?elozTmNiWE5uTFRJMU5XRTBNakEyTFRFME1Ua3RNVEZsWlMxaVpXWTBMVEEw?=
 =?utf-8?B?TjJKallqVmhZekEwT0Z4aGJXVXRkR1Z6ZEZ3eU5UVmhOREl3T0MweE5ERTVM?=
 =?utf-8?B?VEV4WldVdFltVm1OQzB3TkRkaVkySTFZV013TkRoaWIyUjVMblI0ZENJZ2Mz?=
 =?utf-8?B?bzlJak00TWpBaUlIUTlJakV6TXpNeU1qVTBORGN6T0RZd01EWTNOU0lnYUQw?=
 =?utf-8?B?aU1IcFhRa2x5ZWpkSWJXSjNVRk40UlVzeFdrcEtjM3BCU21JNFBTSWdhV1E5?=
 =?utf-8?B?SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJRVUZGVWtoVk1WSlRV?=
 =?utf-8?B?bFZHVGtOblZVRkJSVzlEUVVGRWFrSnlURzVLWVdwYVFWTnFWVGxCVkdSVFQz?=
 =?utf-8?B?bEVTMDVVTUVKT01VazNTVTFFUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVWhCUVVGQlJHRkJVVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVVkJRVkZCUWtGQlFVRjJaR2hyZUdkQlFVRkJRVUZCUVVGQlFVRkJR?=
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
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|BY5PR03MB5169:EE_
x-ms-office365-filtering-correlation-id: 6571df3a-cdeb-4182-e470-08db763d0bbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CsilN4mvj02ibGBl/s7Vqt6CL1i/mQy5LVyCVGXkLDL0yZnlDwTh3jxRtdB+ICGdh/safqUc4BNRg9zKBRYHrt88AfHHlay8LyavYlozwCiJFSB+8IzWX0498+GzT77ExlJY9qXw0qnCpwdUBANqDLqclEFaZviJcVGXecSEpgFWfNS0ZKK7Jjc2sAdGsriqoVUaV1uHnyaKn/sK997b3nzKwih6w5sTFdZup377PDjMAyowx6Ao36tbEjT9Si0dbd4NRbdWw4XrMybp9BrvgzUh2dRCglJOZRUSybvcZBm/QNqHwuT9508Wuk4pd3mUMEDIHL7tygPGQ6yODSh6PBeM7G4HDm8Bp1yHmjCc2Fo+gA/GkjnfDNnaU5BJmtdHZmhhP6zFlwpJvzJUrbr09HVp2V1+fXhr7n1q5PeOCe87abVNgwYCF93/fl7K9lxJR+rR76TKhAcBlX8tPGdL/UKfSVUns/PS0oG+SviE24gLUAjBX+7+T3318BFEeqwEMLgdjAkGfv4+xj+rXjSvpRmg+fg6CKXBk2KL1+cxXT+H6rh3OTBoaNWCECFIIZ+8TOvIGPVcTdVmdCWJl7nmvbN9io6mxVUqSg+c0xH+z1kXJmzuVh9uZ7MBUh1S9aaD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(366004)(39850400004)(451199021)(41300700001)(8676002)(8936002)(316002)(52536014)(64756008)(7696005)(66476007)(66574015)(66946007)(4326008)(66556008)(66446008)(76116006)(478600001)(86362001)(33656002)(71200400001)(110136005)(54906003)(9686003)(26005)(6506007)(186003)(83380400001)(55016003)(5660300002)(2906002)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXEvUGs2NUp4L3NhQ1Bxdzd4Sk81NEg0UnBXRk94YTB4SURaVmp6MU1oSVhz?=
 =?utf-8?B?Y2piTEIxbHgrY2JNTndiaS9jVFQ3eVAxMmw5WVRrZnl6NkttcFo1cXp3eURT?=
 =?utf-8?B?Qkowb3dKY2RVRWRSdE9mMzFEKzcrSVN3aGc2bmFmVDJzd3hsTjM4MlltOFFt?=
 =?utf-8?B?VXRkL0VyYlB2VGpSN29sWDJzKzBENVBLTWkybnJXK051VGN5dTNYa3RKR1pl?=
 =?utf-8?B?MHpEUnJ6NGlvUVBGSzFZa1gxTEU5c0ZYZTUwVUtYQmMwK1dZb1JjSXhmRVla?=
 =?utf-8?B?VC9vWWViSjdLdjNkdUlFVjJzOC9EVGVJODA2Um5CNldwZmZtalJvTDF2ZGFw?=
 =?utf-8?B?RzRYWWdSTjliNEFyU1ByV3ZZMHhlcGRaSlk1N0FDMDJGM2YzeW5IeW1vNkU1?=
 =?utf-8?B?cnA4aDVTMmxvV3BSNEY5VytEdHltbzBHSFlUaCtYOFA3eEMycFNpcmxZbUxn?=
 =?utf-8?B?ektKdW8yT0RtTzdSUk1QWWFOUjhyRHkyVVNHRnAvMitvbEVQTmpzSE10SDFs?=
 =?utf-8?B?eG5sUVhrRWY2djBqZGRuZ1QwV2FTUEVmM1hJVFNsdTU2TjErQlkzdWxQZ0J6?=
 =?utf-8?B?aXlkejJaVHFFZ242TUhET0M4TGZrQjV6d3c3amVQRXRpUmJlYitoRjlHT0xD?=
 =?utf-8?B?bnpGNVRLMTJxQkNvajdKYUFxcXB1N2RtamtkcFN2S1pGRnJMVUVSRGc1czZ2?=
 =?utf-8?B?dHJtdW9xelg5UXRWVEFhMmhGd2MxLzZOc25QUGZEU0Y4SFhScWpLRHNHVHg1?=
 =?utf-8?B?dEVURUFFMWt1UkpsMHNuMmhsc2t2YkdVc2tHUTdXNWM2K1dGdWJEaGFTV1Jl?=
 =?utf-8?B?TWFFL2tLYTV4VFR3WGJNK0E4blBlanM5WFROaXY3ajE5MzhkQmxuWjRsZUtG?=
 =?utf-8?B?Ym9jeFJadkNlYVgwcVdzNUVlQS9WcUZLK0FYRER3WkduVFdZVSt0bk1saHBs?=
 =?utf-8?B?ZC8wbmhpa1BUMER4UzNjWlpGYk1ESVlzaHo5UVFzU3hrUHlpZUFoU0VON1Bz?=
 =?utf-8?B?OWhWWERqWTBnc0RJS3hKRkxPUC9RVnpDYnMyYkVtYnNOalp5aUtRalBoOUoz?=
 =?utf-8?B?dDBRWXI2a041QkVIREtHNDNmUGpCNlJ5M1Z6UGI0c3d3NjZPWEhkeHViVkZG?=
 =?utf-8?B?SzZielBDVVBwWnFQKzArZmQ4c3pVandYcmtUa1JWOGwwT25jRmpMc3NWRmI5?=
 =?utf-8?B?NFNXOE1jVk9DbzVpdG51VlJvVTQ0cGFXRzZWZFl6UmdaSFBLYzZoMDVUM2lk?=
 =?utf-8?B?VGgrZm8zMG84ak9OYzdBZnhsQkk4RWZld01GVnk1UkxrcXRNd3pPTXovSkM0?=
 =?utf-8?B?dXZpelRrYXZOYWFEUXEyRUtuMXdlOGR3MEVZbGYwZ0FLUHphZDE5OXRLZ1ZM?=
 =?utf-8?B?ZEdVeFYyVjNwRzU0Y0lDYW12VCtXYzZRUzE3Q01zL2dBMlNyYmV1NFVqVUhR?=
 =?utf-8?B?Tzg3cFp2VTUvM2UxWHdWZkdDSGNrRWNoaVIycE52VjA0THZtRllYYVFVM2VB?=
 =?utf-8?B?MzdFSjVqVzFRUnBPTFNmK2RHZjQxRlNkbVovd2tHeGpuOWVrYVdUQXhEQkJF?=
 =?utf-8?B?ZFpaenhPOGFWVHhOWVVGRVp0R1oybVd6UmxCRkFJL2dUVk5zQnZzV2JGZzNY?=
 =?utf-8?B?WklJZUFaNEhlTFo1ZFBQOXY4WEZYVUhXWlhpVXVieDAzNlRuNEVuK0RpcVdM?=
 =?utf-8?B?T0p5Ly90YjF5T1EyRFZWRjRmZFd5RHdXbVJFb2JTOFhmMXQ3OVY4NHJDN2J4?=
 =?utf-8?B?QllWVjI2Vk0vMTBuanFTeHYzL05KRnhCWmFMdjlzR3R4VFNUSThVVXFWQlN0?=
 =?utf-8?B?bjQ0KzdiWFRYV0pkVHZmNU5KU1g3dDJXM25sMnR6Z0M2RitVeUZOdXYwNzBP?=
 =?utf-8?B?dDVneFNWTFUwWVBtUlRvc0J0a1hIdGJsbTg2VlBCdHhxN29oMWFvckNoZFYz?=
 =?utf-8?B?Z2NnQzJVMk01QlcrNmRVekpBTkY3SXpqVlYwUG42Z3RZUlRlSllqQ1FvUGdP?=
 =?utf-8?B?RTIxcnhmdzhaWmdxMUU2cnJVVU9KRnRmRnNTclJ5L1hjVkZOdnVFa0VOM2Vk?=
 =?utf-8?B?Y2h2bGMzbTNEdTNYN3F1SnJ6QWdPcUFLSHdEaFdod3NLQmNCSEhTRTRickVU?=
 =?utf-8?Q?UAWyJIr5Ru2qGqnYURx2RARcp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6571df3a-cdeb-4182-e470-08db763d0bbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 12:01:16.4874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QMOlVEW9poNY+vFOUDv0AjlmyFm2lGsCklcAg3t7oBA1H1WiIfUsgSHAjPJUATq8t3bt/rKryr5isl5vKikfdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5169
X-Proofpoint-GUID: 3ycLaB7ySTe2POXPqMLaJpblo0oIMqPJ
X-Proofpoint-ORIG-GUID: 3ycLaB7ySTe2POXPqMLaJpblo0oIMqPJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_09,2023-06-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=712 clxscore=1011 phishscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260107
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PlNlbnQ6IE1vbmRheSwgSnVuZSAyNiwgMjAyMyAxMjoyMCBQTQ0KPlRvOiBKdWxpZW4gUGFuaXMg
PGpwYW5pc0BiYXlsaWJyZS5jb20+OyBTYWhpbiwgT2thbiA8T2thbi5TYWhpbkBhbmFsb2cuY29t
PjsgTGVlDQo+Sm9uZXMgPGxlZUBrZXJuZWwub3JnPg0KPkNjOiBBbmR5IFNoZXZjaGVua28gPGFu
ZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT47IGxpbnV4LQ0KPmtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZQ0KPlN1YmplY3Q6IFtQQVRDSF0gbWZkOiBT
d2l0Y2ggdHdvIG1vcmUgZHJpdmVycyBiYWNrIHRvIHVzZSBzdHJ1Y3QgaTJjX2RyaXZlcjo6cHJv
YmUNCj4NCj5bRXh0ZXJuYWxdDQo+DQo+c3RydWN0IGkyY19kcml2ZXI6OnByb2JlX25ldyBpcyBh
Ym91dCB0byBnbyBhd2F5LiBTd2l0Y2ggdGhlIGRyaXZlciB0bw0KPnVzZSB0aGUgcHJvYmUgY2Fs
bGJhY2sgd2l0aCB0aGUgc2FtZSBwcm90b3R5cGUuDQo+DQo+U2lnbmVkLW9mZi1ieTogVXdlIEts
ZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4tLS0NCj4gZHJp
dmVycy9tZmQvbWF4Nzc1NDEuYyAgICB8IDIgKy0NCj4gZHJpdmVycy9tZmQvdHBzNjU5NC1pMmMu
YyB8IDIgKy0NCj4gMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+DQo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL21heDc3NTQxLmMgYi9kcml2ZXJzL21m
ZC9tYXg3NzU0MS5jDQo+aW5kZXggNGEzYmFkMzQ5M2IzLi5lMTQ3ZTk0OWMyYjMgMTAwNjQ0DQo+
LS0tIGEvZHJpdmVycy9tZmQvbWF4Nzc1NDEuYw0KPisrKyBiL2RyaXZlcnMvbWZkL21heDc3NTQx
LmMNCj5AQCAtMjE0LDcgKzIxNCw3IEBAIHN0YXRpYyBzdHJ1Y3QgaTJjX2RyaXZlciBtYXg3NzU0
MV9kcml2ZXIgPSB7DQo+IAkJLm5hbWUgPSAibWF4Nzc1NDEiLA0KPiAJCS5vZl9tYXRjaF90YWJs
ZSA9IG1heDc3NTQxX29mX2lkLA0KPiAJfSwNCj4tCS5wcm9iZV9uZXcgPSBtYXg3NzU0MV9wcm9i
ZSwNCj4rCS5wcm9iZSA9IG1heDc3NTQxX3Byb2JlLA0KPiAJLmlkX3RhYmxlID0gbWF4Nzc1NDFf
aWQsDQo+IH07DQo+IG1vZHVsZV9pMmNfZHJpdmVyKG1heDc3NTQxX2RyaXZlcik7DQo+ZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbWZkL3RwczY1OTQtaTJjLmMgYi9kcml2ZXJzL21mZC90cHM2NTk0LWky
Yy5jDQo+aW5kZXggNTBhM2NkMDNiM2IwLi44OTljODhjMGZlNzcgMTAwNjQ0DQo+LS0tIGEvZHJp
dmVycy9tZmQvdHBzNjU5NC1pMmMuYw0KPisrKyBiL2RyaXZlcnMvbWZkL3RwczY1OTQtaTJjLmMN
Cj5AQCAtMjM1LDcgKzIzNSw3IEBAIHN0YXRpYyBzdHJ1Y3QgaTJjX2RyaXZlciB0cHM2NTk0X2ky
Y19kcml2ZXIgPSB7DQo+IAkJLm5hbWUgPSAidHBzNjU5NCIsDQo+IAkJLm9mX21hdGNoX3RhYmxl
ID0gdHBzNjU5NF9pMmNfb2ZfbWF0Y2hfdGFibGUsDQo+IAl9LA0KPi0JLnByb2JlX25ldyA9IHRw
czY1OTRfaTJjX3Byb2JlLA0KPisJLnByb2JlID0gdHBzNjU5NF9pMmNfcHJvYmUsDQo+IH07DQo+
IG1vZHVsZV9pMmNfZHJpdmVyKHRwczY1OTRfaTJjX2RyaXZlcik7DQo+DQo+DQo+YmFzZS1jb21t
aXQ6IGUwY2JjMjAyMzg4YWY0NTRlYjc3MTA0M2IyMGRiNmRmZTY4MTk5ZWMNCj4tLQ0KPjIuMzku
Mg0KDQpIaSBMZWUsDQoNClNob3VsZCBJIHVwZGF0ZSB0aGUgY29kZSB0aGVuIHJlc2VuZCBwYXRj
aCBhZ2Fpbj8gT3Igc2hvdWxkIEkgc2VuZCBhbm90aGVyIHBhdGNoIGFmdGVyIG1lcmdlIGlzIGNv
bXBsZXRlZD8NCg0KUmVnYXJkcywNCk9rYW4gU2FoaW4NCg==
