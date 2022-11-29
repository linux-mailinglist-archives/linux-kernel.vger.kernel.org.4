Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075D963C4F6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbiK2QRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiK2QRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:17:47 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290B5DEBF;
        Tue, 29 Nov 2022 08:17:46 -0800 (PST)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATFwaBG010049;
        Tue, 29 Nov 2022 16:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=QunDWt+oYjs98+7hDElF6ttEhQzCkAA1UQEGHi8II90=;
 b=aeQd6iBA0FxhwUBhh+V7Y82j2WbVXJ213DZc/ZDXSHtqNlPpeLqWzGJjVK7X84yEuB3T
 SNmtKpmZEOXiw4TnZLNccgkrzhLaVTeBA0K/06SZhl6BsXDa1jjfwhiWd9yPehqk+W00
 B4hNx6GlijW9Jh3RYWSku4Wbr1lQORHrdLZsMcs1VosET7OKyLEwpetn5lkGRsv8UInV
 AJB9IJCpy68udjXMSyYL4+VoCdH+uQcxFd/E7OZbgnMYBbuO8sPvycplrjZBRuusfy/s
 wrYZqD9D1+uc0S9B5xBN8b9R9nN2mtkn6vKFZHax4ULib9+35jN9nFhePVfawjAim2w8 Yg== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3m5n6qr6mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 16:17:14 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 515CC81A50D;
        Tue, 29 Nov 2022 16:16:29 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 29 Nov 2022 04:16:17 -1200
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 29 Nov 2022 04:16:08 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 29 Nov 2022 04:16:08 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 29 Nov 2022 16:16:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkZbzswqUHH9iAWPAvZE8crswpsrPtTD04C99mf6hCRFAC9EyV6lnbo+630AguLr84S2awXzvGaq+Zxfov7FM8obReZJHGMqRg7mxsKcbJ048RHRWkEMkmZoSk8h0la5h8Y9fZe5zoVOlvodHqUB/54eh4OJIIfur41vI42kp9ZXlUUMc6j8A2G+2dhv9J+05FgkgzXQvyg2C2qcXa+0Nb4dJhCsOiomiQ1+CQoPxVzipdCoWN7XX5TLhlVCEJwVthTL+z0M3Lu11mKEeuhA569fhogDTDwZbbkKSY0HJRzKwHPxBLx62JOkx4XO06LzElnp95OF2xJgdZvAPFk19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QunDWt+oYjs98+7hDElF6ttEhQzCkAA1UQEGHi8II90=;
 b=kzNlcQ8H4EPRoKPGM07jvsRuFfj+/3wchGE7RsZGuFbf5+3VoOlOVWJUPh87wvnp1HqYz5vNo/BkRpJ4sOOa5ratzWeHx363FB65tEZi2Gt4JDJbvGKQKQDdX5thx4iNpzQi3sX8XUx7hD+InVbk3EhhD1eIMkpvlKlXYuQFsuKsqJ3gGJVPL5qxa5rD2DGoF6uaa0nyA0Rai3Gte837P/QGTLQtvT7nJ7HcroKxaC05p2siNUDriok4ERh+11o16TTOnTxUw6UC7/BYO4D4SmtFlhKJSrSUIHOstsXGdvemPCrVxknSI390iAKT9BnpSY2oVzTD5FvQYT6xW8ZO5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 SJ0PR84MB1577.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:381::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Tue, 29 Nov 2022 16:15:59 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d24f:1a2:7006:17f9]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d24f:1a2:7006:17f9%8]) with mapi id 15.20.5857.020; Tue, 29 Nov 2022
 16:15:57 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/6] ABI: sysfs-class-hwmon: add a description for
 fanY_fault
Thread-Topic: [PATCH v2 2/6] ABI: sysfs-class-hwmon: add a description for
 fanY_fault
Thread-Index: AQHZA32+teHxcxeSMEuXtU0ZSrv+C65VP/GAgABwNYA=
Date:   Tue, 29 Nov 2022 16:15:57 +0000
Message-ID: <0A5DF9D5-B8C2-44A4-924A-B8957EC8A2A7@hpe.com>
References: <20221128230219.39537-1-nick.hawkins@hpe.com>
 <20221128230219.39537-3-nick.hawkins@hpe.com>
 <46cecf77-e989-40d9-3e08-fd970ad12a79@roeck-us.net>
In-Reply-To: <46cecf77-e989-40d9-3e08-fd970ad12a79@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.67.22111300
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|SJ0PR84MB1577:EE_
x-ms-office365-filtering-correlation-id: c38487e7-2d52-4124-7690-08dad224ff97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dufFuX8hNKHNZU1nWlPcWHrQ7nqssVB4hmx1+PF35S0990rHwnQAD2mNHg25gLdWQ+u8Z99xgCoeu9piQFe47mVKm50CHGnn6ucyXgBYLM5jwkBDr4QCdJsT7L+EUF6zZsDNFc0GXIo5PD4Tvxt2PTntkRhp8yuKcvyNJA1293+JuLRTOWdHOB40LEcyhquhXHVYRJqOVWgImS33afzfPlaW16Ww/pcsXRr9pH6AlCyufP5fy6V0c5k1MhlfKbbB+tse0dJTLg4lsE81MmqL71nhh/Rehcqoe/PLkZAXVX/GFD0ysZklKhGXdg2XYv9kIyR6rlfsTYfSalIA3LT1fO10Z2QbsMXrNTyX+A8kWh+u5+o4oTIdNyiQWN0z4+CvfoMnulemshW1XqkfKWMYQp+5l0TKCu0GJar5L4QHzl9Wk92mF/nhL9UBS7VvRXft4OtVsGJmrvzb7lRVOhxPXVbPzQ8Ld4LLLWQWZbGJY+Y7hg6kPyfO9jKrP18NpulSU4IQyi5NZUTE8duEXzo7pBKSF9LON/NRwh+zFf0DwZdJBPQvKM0RmXsm0PjB+63AXN0YvImOmTFE+NNYnMfP8GjDauM4kb77auoRRooECD9Vt5OC55u1z6KwFYgZVx2BgOII1mKZJZzkpyfYsDQk+fdZ53OvbcRgOtgijO/Ir6qeGOtL0JBgsP4ayca2KzUktJpsvNQx1Q0UftG9/NAeLCgQ+X2U2Ju0yG9/CMrNw0Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199015)(6916009)(83380400001)(86362001)(71200400001)(6486002)(6506007)(478600001)(36756003)(6512007)(76116006)(2616005)(316002)(8936002)(41300700001)(54906003)(5660300002)(4744005)(7416002)(82960400001)(91956017)(33656002)(186003)(38070700005)(38100700002)(2906002)(66476007)(64756008)(66946007)(8676002)(66446008)(66556008)(4326008)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHdGVFpIbktvcEpoNUdjb2tYbFRiZ2F3bHVWK3hnTzNaUjJYYnkyd25PZjdS?=
 =?utf-8?B?ZCtyaEVmOVVKZ1ZyeXNqR1g2MUJkWUp0b1IrYUFlMjhZZGg1dG1sTzV4UkRQ?=
 =?utf-8?B?cWFicmt0ZDgxcjRsUmYvZVZuWlZmUEhVMkVxNHhKZ2FpdDh3czRET2JpRXpF?=
 =?utf-8?B?SEdvSGRJajZjbHRrL2lZMVliRkdrWmZpbmk4bm5WRGwyck9uNUUxNzQ3aCtC?=
 =?utf-8?B?OXhKaTNrSkg4RlFGanlDcjNnR282YTJvelBVWnRDU0UwbG5jNVlvajYzamd4?=
 =?utf-8?B?aExlWEE3L1grSWpJS1J6YWFMeW1hOWtWLy9jWnlxUnJXTEluQ2F4bVV2Q1d2?=
 =?utf-8?B?Kzl5cHBKUTBHNlVWa3l4MEo3TTJNVUcwVURnQ05JQmhpMlJta3FFeG9NdVRS?=
 =?utf-8?B?akZCMFJYTTVhWTVJQ3RQNzR4Q3EvcVcwb3l6ZlVLYXlha3E2YUovMC9NVGRk?=
 =?utf-8?B?MS85T2U1eURiK1FHaGl6SEpHc1Q5VHVRdzlRTndPdThkOVFnUERUbUJ0akgz?=
 =?utf-8?B?YWpYZGxKVWNucHZzaDQ4R1RldFpnSmlOTzU5dEVudnV6eE84bytyRWJpVW4v?=
 =?utf-8?B?dHBrK0tMZzRwY2NHVzZ3a3dmSFV1a1d6OG96aG00T1AxUUNHZ3VkSXZEeUxi?=
 =?utf-8?B?YXVIRm1nMWdSZnhZZ1hPK21XOTFkeFQzQW5MeTVqRGY5U0tNK1o4blBTWW1v?=
 =?utf-8?B?YjRETU92QWhja2tTNE9CSnZaOHYwNVdzdndJcllMRnNpcmxqanpwOUx2aU12?=
 =?utf-8?B?OHRxN2YzT0toNmY2WjRVcXMyTUNkV0ZQSEQxdExkQWFsNGowL1B0czhVQ2Nq?=
 =?utf-8?B?WU9obnd5Y1hTZ1pId3o5TS94V3loV0MwMXlQN1IySHFoWExsRU9FUDJqZ3dU?=
 =?utf-8?B?TUtCMlFaSXRGZm8yZkZ1RFpSVW9nR3pEUnZlekR0QnZLemp4UDhDKzBNM05K?=
 =?utf-8?B?SVIrTGllc0syZ0dqQTJaUDhtNFlFUFBpSUZzVTNJVWVJTFNZVk9iZ3ZpS0Vw?=
 =?utf-8?B?TUE2WUFmVzdVeFl2RktibkpUK0gvMHd4K1JkdERTaVdhNEl3NDlJWXRwS0Uz?=
 =?utf-8?B?SFlCb3IxSTdRTE05TUpwK3M1Y2kwSXlrcmVCUUsxVlhJWHY1R1M1U1Uycmsr?=
 =?utf-8?B?THNoZlp1YS9VNzNhQjhPMDNOOUtzZi9keHJmemtUbHMyU3hyZnU1TzlzSmxw?=
 =?utf-8?B?aDRKVFZvMmRDQ3MrNEFkYWwvTTlJZWJtQkkwVkVpZDlKR3MxUkN1VXcvdkI2?=
 =?utf-8?B?cm1SRjZ2emdTdlpGcFBTeXVjaW4vKzVyNC9mQzk0S2Y3cWEwd0VhQW1JNlBS?=
 =?utf-8?B?WXc1elFlOUJ1c2hPamdBTGpNaklzbmFDQkExR3VWRTZuRDNQcjVwZzI5aWR1?=
 =?utf-8?B?Q2EzUkprT0FMNlorc1JqUTh5VXJyNzN4MXk1NFpmTVAzcjdoZ2R4ZklJSzZN?=
 =?utf-8?B?V1JyUVJyalhud09OcHVtMU9NVW9wQWtRRHoxV1BEZktUK05PY2ZQMnUxOU1j?=
 =?utf-8?B?RWNNVWdpNDJhSzFCODk2UjgvNkxqenhrcVQ5QVg3MzZJQ3dTNkR5emIwczFy?=
 =?utf-8?B?YTBrd2FzMjJQQStNWEc2WGpkemRIMW41WStrWFU1ZWNYL0hCRjJpS2ZGNFlM?=
 =?utf-8?B?YWgwWDZGSnhtN3BOYmxkWWthUTJ2djdsSlFuVWRFZ3A2QnR1NDFuK0Rac2dt?=
 =?utf-8?B?enVoVkR3R2NEK0MyNXJYdlpwZGlBbTQwRENvMm1KcEdUOVlPbFdudmNPR091?=
 =?utf-8?B?ZVNOb1IwNUZyb0lLT0thQVFlTnB2c3JGR3BvNk1WcnVFTFVMcUV0c2dtVzlF?=
 =?utf-8?B?MFBMNXpUdEZSY3BaWktNU2F6MTYybE5nQlUwcEtvTE5zcWx2elRQWjhqQXR4?=
 =?utf-8?B?bjltMUd0M1hlMVRnZ0FySEVNeDl6RGpIM3JIU2FrL3BYVXRadzl1M0krZDNi?=
 =?utf-8?B?T0s1UHUvem1RY0cvLzIwellpQXE4NEVWTEpLZjhqSmsxencrZVdZSHhuY0V1?=
 =?utf-8?B?cHZ4SERtQW9UYXlqeVo5VS9iUE1xMTZFNW1kZEhyT2ZQc2llOXU4cHlSWFhj?=
 =?utf-8?B?TVZaclErdTF5Sk9jWVpqcGJzd0ZlKzdIRmUrM3hVQytDWnZhZDM4ajFrTlFB?=
 =?utf-8?B?V25GNmFpNlRhdzBCeDRHWExLd3hyaTl4QUtRdTNJS0lsSjFrMTdpNkJkWlR1?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B730FAC0F391B4479FF83891AFD67E19@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c38487e7-2d52-4124-7690-08dad224ff97
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:15:57.4805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D59txiGCvxJgTfyAfj7IXGDP+ceM81K2a1nnZeR0L0/PshX6fv5bPIpmHpGvcJXnOX4p2z6/NXJon1F4hrxJew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1577
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: UZbNpbEaeqk1S-b4RjZ0pn6NOGjuO1hF
X-Proofpoint-ORIG-GUID: UZbNpbEaeqk1S-b4RjZ0pn6NOGjuO1hF
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_10,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=746 impostorscore=0 spamscore=0 adultscore=0
 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290090
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGlzIGNoYW5nZSBpcyByZWFsbHkgY29tcGxldGVseSB1bnJlbGF0ZWQgdG8gYSBDUExEIG9y
IHNwZWNpZmljIFNvQy4NCj4gVGhlIGNvbW1pdCBkZXNjcmlwdGlvbiBpcyBqdXN0IGNvbmZ1c2lu
Zy4gSXQgc2hvdWxkIHNpbXBseSBzdGF0ZSB0aGF0DQo+IGl0IGRvY3VtZW50cyB0aGUgZXhpc3Rp
bmcgZmFuWF9mYXVsdCBhdHRyaWJ1dGUuDQoNClVuZGVyc3Rvb2QuIEp1c3QgdG8gY29uZmlybSBz
aG91bGQgSSBjaGFuZ2UgZmFuWV9mYXVsdCB0byBmYW5YX2ZhdWx0DQppbiBkb2N1bWVudGF0aW9u
IGFzIHdlbGwgYXMgdGhlIHBhdGNoIGRlc2NyaXB0aW9uPyBGb3IgaW5zdGFuY2U6DQovc3lzL2Ns
YXNzL2h3bW9uL2h3bW9uWC9mYW5YX2ZhdWx0DQoNCkl0IHNlZW1zIHRoYXQgdGhlIGRvY3VtZW50
YXRpb24gYXJvdW5kIGl0IHVzZXMgZmFuWV8gZm9ybWF0Lg0KDQpUaGFua3MsDQoNCi1OaWNrIEhh
d2tpbnMNCg0K
