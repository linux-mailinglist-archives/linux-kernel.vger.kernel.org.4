Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799327403A3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjF0S4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjF0S4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:56:00 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C001198E;
        Tue, 27 Jun 2023 11:55:55 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RIWAWF021991;
        Tue, 27 Jun 2023 18:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=5ynX//FPlvUSK1Jk5FKM3E62GDzTwN4zvKoA8LIct4A=;
 b=QfyloNNyn9amJ/J+F4V1MshIbmu9Q0SRzs4INjy2UrYz+Q1WPPC5ZOsdkMw2r7KMg2b+
 TzJYDP1pM4f/cR+HLrXVnWP+WmlECZQKsL1yUkpxiAXpSWNsqagt/3u3ppcp4Zv/YHhj
 a5Q0XePU5eHq5xCmSAl5BaklJTgu76UAK0eZZj0d7CK/LywJg8UFldQsGWaErA9zDD42
 LlU0PsVhZj/J0xfkmuoDeT9icSiNJr9rsFbBW39uYXtoc58zpi7jgsUnYC8RoPFas0nU
 PitJDyLx34FkCPBgV24jvM2bwxzps/Jva1KBA9hbaXexQ09M15lkldKUoWM34HwMAOqn mw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3rg0dyawej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 18:55:28 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 8752114786;
        Tue, 27 Jun 2023 18:55:27 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 27 Jun 2023 06:55:09 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 27 Jun 2023 06:55:09 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Tue, 27 Jun 2023 06:55:09 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 27 Jun 2023 18:55:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1sr2tFeAG/utjH7BWYfWREJn+xptsMmJwUMH53IoWY1FE4wLdNqTKdk6o+5ntWzpaLoNwEHx9cmza8+dfSchnTNf/PBT5ruhKiuJUqWB/20bETaTFQLfNnJot5Mq4rrHvIiKX9dJizxEgDpZHiRy/DsWCEIEqK2gPG5TA7sNC4qaz7nk90gy3XhxexhHhf725Wh0UXBrDXX1qO+opzNFK4kON40zuAJJD44GggeWsoRkuTjEDkOGRgrfp542PXAYakceWDKb+dHRXvOh/qf09Q2byNfCbKNEtOhyPKxR925mBd4Gh/WHlqx4Hi4wpxG02Vu3nzZw3QoQekpHsKEyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ynX//FPlvUSK1Jk5FKM3E62GDzTwN4zvKoA8LIct4A=;
 b=iKaTafIbRhP8aYJlsxeSRtZyKFYb+SidbMHvPFgYXPkQ82cI8Ce8kvVt+isQFpHU4smmwxiAzVAQVpUPMK56WS7PjMUQ7OzxmMoaKgFN69M0VNYptmjKSuGANO761K162LSKDTYhzrVyisvBXZtg7tvNE2VXSezjwnmnnNVdeMbobhhJZZBkWgXpUwEkr8GwOWCIYFbnB7cgW1/3Dg+O+nkDDXf1sNs9yxVovWoiRpmch0ya2UIE7qaVby0hmCoVJrkY+AT9Y/JkA3Rf2tLaVDtgovAcj9EoUDJ7pDh+iJt+aeYzZNqfqPQ9j1ZLnYl7PqRgaSS/hHrH8Yrp+S5Hpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 MW4PR84MB1443.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Tue, 27 Jun 2023 18:55:07 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682%7]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 18:55:07 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] gpio: gxp: Add HPE GXP GPIO
Thread-Topic: [PATCH v4 1/5] gpio: gxp: Add HPE GXP GPIO
Thread-Index: AQHZpIhVq9wKn+gl5UKKNmA/guoG66+er70AgAAFJYA=
Date:   Tue, 27 Jun 2023 18:55:07 +0000
Message-ID: <49BFF623-06D0-4689-9057-F3D4BFBA0DEF@hpe.com>
References: <20230621213115.113266-1-nick.hawkins@hpe.com>
 <20230621213115.113266-2-nick.hawkins@hpe.com>
 <CAHp75Vczq+5JCFW+qi4Y7M7+JY3MPe7GAMdjMzOpVukcBybH7A@mail.gmail.com>
In-Reply-To: <CAHp75Vczq+5JCFW+qi4Y7M7+JY3MPe7GAMdjMzOpVukcBybH7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.74.23061800
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|MW4PR84MB1443:EE_
x-ms-office365-filtering-correlation-id: 82abce11-0bcc-4bf3-2285-08db77400664
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +1UZT+3qEbrVuyvf53DxUGeNoAscSm/O4r5NcZ7ctZdk36IchGfXiHp6rdz5oevGvSvESqDYvzQ/hfWf22WBHIhKJOBOeeLNOBUef3axzaVZH8O4HCBOq23Pvgkf5iuP7UONZHIDDVkmqM5fs9+hjvBb5uQAkyDA9E9brhPEeNk9N2TbBToeEQ23IwH18Dbn2orXY38JaUEWJjHNFQLHdqGR1vGIM0de1+y77z1RsKh/ptWOQXCblmDnTAegzOdik/3eqiE9TJa1u3oagAqzQ76NV1pseTLEHQjy24AgiWQ3g+Y/ylVHu1EKu6QaeRSbMWC2qnScBn3KbrkEcc9YqV6C7yaOX8WAJfJ1AP4XJsFx25/ofJO74O5gd+nUrwfz8J7JoJ3DdBEE7zEQ5kCuK70UjcNHF1I6RhNGGWk/UD7o7IBR35KdpCJXDGntuMcartzFzuC2QeVzYwlK/3kyt5641XlslWzALKABvomxOodQpoe6iWCqV+fAhWg5r+5RLUduG6YNMy7MLPf5TFOkPxwg7KW0uyfyPRXrBsO1OmTsMSMvdLJAIsieTU85uh8gBptAicE1c68p1lrKpNKtr5kYWTm284maZyeYAhCDTOyvHg3IhuWjv47431mv4Dw2uxKKHaseRNHxJLvqIxypmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199021)(2906002)(186003)(71200400001)(6486002)(122000001)(82960400001)(38100700002)(83380400001)(2616005)(66574015)(6506007)(6512007)(86362001)(41300700001)(38070700005)(54906003)(316002)(478600001)(36756003)(66556008)(66446008)(4326008)(66946007)(76116006)(33656002)(64756008)(6916009)(66476007)(7416002)(5660300002)(8676002)(8936002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWNLM3BESERiWTluVDN2Wmd1Qi91T09jRnRxaUQ5SXlyWG05K2xxMTVLblFQ?=
 =?utf-8?B?dmJLNytNdUJXVXA2QkpPWXdlenl3WGJnT0h3NVI0V3ZBcFJFaVdWcHpKQW10?=
 =?utf-8?B?bjAyeUVyWHRjcHRlNER3QlhOUzhiVGdEbG0xeTlKZkt0Sys1MUhYVkJJUmdX?=
 =?utf-8?B?bWc5MlVZdVZFcUpoSXQ2Sko5L3ZSN0krcnpzR1hYVXQ4dkxTYVlCR3BVcVQ5?=
 =?utf-8?B?YjJnOUxBSGJJOWZoQ29HVmdLOXFBc2c0UHE4c2YxeVZaYS96cmd3M0hQNHla?=
 =?utf-8?B?S3YyYy9xY0M1T0pHaE10eVJ3a1ZUNXBaeUgzZ3dmYmpsNDRkdjVJRmJDaXQ4?=
 =?utf-8?B?L1k5eGd5c0cwVjdTa2R0bm9iRkZ6L1pDb3pzWEtoWEF2eXUxdHNtbzRXTzFD?=
 =?utf-8?B?NU5LcG04d0J2SXdiODNkYU90aDJ2a0pBaC9tbHJGRE1YV3RxdkplbHc2aC85?=
 =?utf-8?B?WWt1SzdVQVVHczd2d2dnVEhSVGlqdU5wYVA3c3hycE9TcEtiVDI5d24vbnFp?=
 =?utf-8?B?Rnp4NTVNSHpPeVRjMWE2aE9PSzA5L3JpYXFESlo4VnB3aTJnNS80aktNMk5O?=
 =?utf-8?B?SEM4d1V2MW02eTlTU2JaWHFNTFVrVVpQaDZ1eWFWaUhkdWd2L0FIbFZreFZG?=
 =?utf-8?B?N0p5WVV0VUo1WjBoakhaK0Q2KzRET0NHN0c0Z1lSdURLVVB6RTdBb2NGZE9Z?=
 =?utf-8?B?NStkOWNrdzJjOXFmemxKS2F0VUpoNXp0c1puaG85TUJUeDcxMW1jTnNMUWFL?=
 =?utf-8?B?ZnNxNXVwVDVITXlOTm1uVTFFdUkwaVcxWWRyZkVwR3hrbkxibWhJd2RsWCtx?=
 =?utf-8?B?VW1oSnYrbEJIdCtYMUNrVk1WZDRVT1BDL1AwUWdIaUpVUnArV0hRZkRET2du?=
 =?utf-8?B?SEl3RXZTRE5LYmhvTXRjZnAwc2pvTHp4ckI4QWZVelNqOXJ2MkJXMVNlRzcz?=
 =?utf-8?B?cTJFNHErVFBtT0RsaUt5bis5aWU4REJUS2JsSlJueUJUdUswWVIzbWllcEpT?=
 =?utf-8?B?QjB3U2w0LzFqYXFnaWZTVTNaTVB6SE1wWFlmamxFVkxReUEvZXJ5dVM3czFS?=
 =?utf-8?B?U1U5L1hrVCtTaXFEVElmMXE5dmNzY2VuNXg5WkxlMkY5eEpiekd3d2NqVjdS?=
 =?utf-8?B?aEpSSjVXQVRWVnArMHpvWktOZ0taRUkzanNTcjRVeFA1bzc0akpKRUNYcG9G?=
 =?utf-8?B?TXc2bHV3MlRxWHF4YXQ3YXNSalk1TGdyOGhUcGZHNmtCaUNsdSt5aThkOVFS?=
 =?utf-8?B?aXJIRFA2QktVZEN6dUd4alVLeElNNC9YclBoUDRaVFF1YWlWeHl3bEZ6R0wy?=
 =?utf-8?B?WG81Y3dCck9JdnpmcjRRdHN3cmZNUW5nazlYbSt2aWNtTDc1Y01YTXErdkVP?=
 =?utf-8?B?aEQ2eTVTK1M0ODczYUdaZndTM2FyQU52TWgwNHpLdHlxWnRIa29kK1lUTC9r?=
 =?utf-8?B?ME41NUtLeFdNVm55ODNDaGhIeWlhRklsUUxTbjlUQUo4eVJKQUpFZ29HTzlx?=
 =?utf-8?B?SDlUMWRkb0FlSTNPaHRIbk1lZS81bHhpMFpnWXJLYlh3Z3grUDJRQ2lER3A3?=
 =?utf-8?B?cy9YaEZYcjZpOXVjQTZ5aENOSlpmZnZZNStrYTVPa2pxSERNcXhXY2ZWLzJr?=
 =?utf-8?B?bFdYdE5QUHduRUtySUpQYWZ2WXhBcUxEUTNOa2hXdXViOHJML2RmcmUxdC83?=
 =?utf-8?B?djVHTXhFVWV6cVNXcm5vc1NEa2EwbUM5UVhROUFuK25qekl6RTlicVBmRzVD?=
 =?utf-8?B?Z0pHRjNyeHQvWnpIaWZwRkpzWmFQOHpEZklGY1NnSVJXc0RlV2NCN1RlWGsz?=
 =?utf-8?B?TkFCaFZZTTZtWklrMmxydVZEMExzMjdHbXhVNHpXT1JCTG0vbEN5VmZveTFP?=
 =?utf-8?B?Z0hRUFV2cnhVaWtxNnNKNW5JeEZEbHowNnVSNTI0L1NFNTN6R0J1UnZDWTlv?=
 =?utf-8?B?S0JqMFRNdExJR2hIWGJlNFVSWG1wK3Ewb0gyY1ZqdjZYeUtFVnhmclBlU1JW?=
 =?utf-8?B?WkxESCtrSG1SNEszZkdId2RENVQ5K3ZUN2JLdWRIeVExbU1obUdOM1RQdG5p?=
 =?utf-8?B?TnRRWjMxekJSeWoyZS8rNDFQQm0xakxwQ1ZLdmdqMDlpR1R0MUVMMWdBVU1n?=
 =?utf-8?B?dFZ1TUtscTFnUjkvZ1JWK0tONjB4QmhncU8zZmwyajkyVHR1bmVzT1JmMGw2?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <299F037BC86F4D45974E77B3171B0B1A@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 82abce11-0bcc-4bf3-2285-08db77400664
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 18:55:07.1425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eInSTLX2HfNyEuz9oPQbL+bSyYBPXv8AOa+By0qciFSlnA7cBjCkk9eCY3HEyd4EjudI7Z6qY/FPslZ9enlJOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1443
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 83qZkS4BrQDscXQc3yOzi1a2jv9ZgV5E
X-Proofpoint-GUID: 83qZkS4BrQDscXQc3yOzi1a2jv9ZgV5E
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_12,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270171
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBkZWZpbmluZyAoSSBoYXZlIGEgZMOpasOgIHZ1IG9mIGFscmVhZHkgc2hvd2luZyB5b3UgdHlw
b3MgaW4gdGhlIGNvbW1pdA0KPiBtZXNzYWdlIGFuZCBjb21tZW50cyBhbmQgaXQgbG9va3MgbGlr
ZSB5b3UgaWdub3JlZCBhbGwgb2YgdGhhdC4gSWYgc28sDQo+IHRoZW4gd2h5PykNCg0KQXBvbG9n
aWVzIEFuZHksDQoNCkkgc29tZWhvdyBjb21wbGV0ZWx5IG1pc3NlZCAvIGxvc3QgeW91ciBtZW50
aW9uIG9mIGEgdHlwbyBpbiBib3RoIHRoZQ0KY29tbWl0IGFuZCBjb21tZW50cy4gSSBoYXZlIG5v
IGludGVudGlvbiBvZiBpZ25vcmluZyBpdC4gSSB3aWxsIGNvcnJlY3QNCnRoaXMuIFRoYW5rIHlv
dSBmb3IgdGhlIGlucHV0IHlvdSBoYXZlIHByb3ZpZGVkLiBJIGhhdmUgc2V2ZXJhbA0KcXVlc3Rp
b25zIGFuZCBjb21tZW50cyBiZWxvdy4NCg0KDQo+ID4gKyAqIGFyZSBzcGVjaWZpY2FsbHkgZGVm
aW5lZCBpbiBEVFMgYW5kIG9mZnNldHMgYXJlIHVzZWQgaGVyZS4NCj4gPiArICovDQo+ID4gK2Vu
dW0gZ3hwX2dwaW9fcG4gew0KPiA+ICsgUkVTRVQgPSAxOTIsDQo+ID4gKyBWUEJUTiA9IDIxMCwg
LyogYWthIFBPV0VSX09LICovDQo+ID4gKyBQR09PRCA9IDIxMSwgLyogYWthIFBTX1BXUk9LICov
DQo+ID4gKyBQRVJTVCA9IDIxMiwgLyogYWthIFBDSUVSU1QgKi8NCj4gPiArIFBPU1RfQ09NUExF
VEUgPSAyMTMsDQoNCg0KPiBTbywgdmJ0biBpcyBhIEdQSU8/IFdoeSBkb2VzIGl0IG5lZWQgYSBz
cGVjaWFsIHRyZWF0bWVudD8NCg0KSSB3YXMgc3BlY2lmaWNhbGx5IGdyYWJiaW5nIHRoZSBhcmVh
cyBvZiBtZW1vcnkgdGhhdCBJIG5lZWRlZCBpbnN0ZWFkIG9mDQptYXBwaW5nIHRoZSBlbnRpcmUg
Zm4yIGFyZWEgb2YgbWVtb3J5LiBJIGJlbGlldmUgSSBjYW4gbWFwIHRoZSBlbnRpcmUNCmFyZWEg
aW5zdGVhZC4NCg0KLi4uDQoNCj4gPiArIGNhc2UgNjQgLi4uIDk1Og0KPiA+ICsgcmVnX29mZnNl
dCA9IEdQT0RBVDsNCj4gPiArIHJlZ19tYXNrID0gQklUKG9mZnNldCAtIDY0KTsNCj4gPiArIGJy
ZWFrOw0KPiA+ICsgY2FzZSA5NiAuLi4gMTI3Og0KPiA+ICsgcmVnX29mZnNldCA9IEdQT0RBVCAr
IDB4MDQ7DQo+ID4gKyByZWdfbWFzayA9IEJJVChvZmZzZXQgLSA5Nik7DQo+ID4gKyBicmVhazsN
Cg0KDQo+IC4uLmFuZCBoZXJlIChiZXR3ZWVuIHR3byBncm91cHMgb2YgR1BPKSBpcyAweDQ4LiBM
b29rcyBhIGJpdCB3ZWlyZC4NCj4gRG9lcyB0aGlzIEdQSU8gaGF2ZSBtb3JlIGZ1bmN0aW9ucyB0
aGFuIHNpbXBseSBiZWluZyBhIEdQSU8/IFRvIG1lDQo+IGxvb2tzIGxpa2UgYSBQTUlDLWlzaCBv
bmUuIElzIHRoZXJlIGFueSBkYXRhc2hlZXQgYXZhaWxhYmxlPw0KDQpVbmZvcnR1bmF0ZWx5LCB0
aGVyZSBpcyBubyBwdWJsaWMgZGF0YXNoZWV0IGF2YWlsYWJsZSBjdXJyZW50bHkuIFRoZXJlDQph
cmUgaG93ZXZlciBzb21lIHNwZWNpYWwgZnVuY3Rpb25zIG90aGVycyB0aGFuIGJlaW5nIGEgc2lt
cGxlIEdQSU8uDQpUaGVyZSBhcmUgb3duZXJzaGlwIGJpdHMgYXMgdGhlIHNhbWUgYXJlYSBpcyBh
Y2Nlc3NpYmxlIFZJQSBQQ0kuDQoNCj4gPiArIGNhc2UgUkVTRVQ6DQo+ID4gKyAvKiBTV19SRVNF
VCAqLw0KPiA+ICsgcmVnX29mZnNldCA9IEFTUl9PRlM7DQo+ID4gKyByZWdfbWFzayA9IEJJVCgx
NSk7DQo+ID4gKyBicmVhazsNCg0KPiBEb2VzIGl0IHJlYWxseSBiZWxvbmcgdG8gdGhpcyBkcml2
ZXI/IE1heWJlIGl0IHNob3VsZCBiZSBhbiBNRkQgd2l0aA0KPiBHUElPIGFuZCBzcGVjaWFsIGZ1
bmN0aW9ucyB3aXRoIHZhbGlkX21hc2sgcHJvcGVybHkgYXNzaWduZWQ/DQoNClVubGlrZSB5b3Vy
IHN1Z2dlc3Rpb24gSSBxdW90ZSBkaXJlY3RseSBiZWxvdyBhcmUgeW91IGltcGx5aW5nIHRoYXQN
Ck15IGFjY2Vzc2VzIHRvIHRoZSBDU00gYXJlYSBvZiBtZW1vcnkgY2FuIGJlIGl0cyBvd24gc2Vw
YXJhdGUNCmRyaXZlciB0aGF0IGlzIE1GRCBhbmQgcHJvdmlkZXMgR1BJTyBsaW5lcyB0byByZWFk
Pw0KDQo+IC4uLiANCg0KPiA+ICsgY2FzZSAxOTI6DQo+ID4gKyBpZiAodmFsdWUpIHsNCj4gPiAr
IHJlZ21hcF91cGRhdGVfYml0cyhkcnZkYXRhLT5jc21fbWFwLCBBU1JfT0ZTLA0KPiA+ICsgQklU
KDApLCBCSVQoMCkpOw0KPiA+ICsgcmVnbWFwX3VwZGF0ZV9iaXRzKGRydmRhdGEtPmNzbV9tYXAs
IEFTUl9PRlMsDQo+ID4gKyBCSVQoMTUpLCBCSVQoMTUpKTsNCj4gPiArIH0gZWxzZSB7DQo+ID4g
KyByZWdtYXBfdXBkYXRlX2JpdHMoZHJ2ZGF0YS0+Y3NtX21hcCwgQVNSX09GUywNCj4gPiArIEJJ
VCgxNSksIDApOw0KPiA+ICsgfQ0KPiA+ICsgYnJlYWs7DQoNCg0KPiBBZ2Fpbiwgc2VlbXMgbGlr
ZSBhIHNwZWNpYWwgZnVuY3Rpb24gb2YgR1BJTyB0aGF0IHNob3VsZCBwcm9iYWJseSBoYXZlDQo+
IGFub3RoZXIgZHJpdmVyIHRoYXQgc2hhcmVzIHJlZ21hcCB3aXRoIEdQSU8gYW5kIEdQSU8gbWFy
a3MgdGhpcyBvbmUgaXMNCj4gbm90IHZhbGlkIGZvciB0aGUgR1BJTyBvcGVyYXRpb25zLg0KDQpX
aGF0IGRvIHlvdSBtZWFuIGJ5IEdQSU8gbWFya2luZyB0aGlzIG9uZSBhcyBub3QgdmFsaWQgZm9y
IEdQSU8NCm9wZXJhdGlvbnM/DQoNCi4uLg0KDQo+ID4gK3N0YXRpYyBpbnQgZ3hwX2dwaW9fdnVo
Y19nZXQoc3RydWN0IGdwaW9fY2hpcCAqY2hpcCwgdW5zaWduZWQgaW50IG9mZnNldCkNCj4gPiAr
ew0KPiA+ICsgc3RydWN0IGd4cF9ncGlvX2RydmRhdGEgKmRydmRhdGEgPSBkZXZfZ2V0X2RydmRh
dGEoY2hpcC0+cGFyZW50KTsNCj4gPiArIHVuc2lnbmVkIGludCB2YWw7DQo+ID4gKyBpbnQgcmV0
ID0gMDsNCj4gPiArDQo+ID4gKyBpZiAob2Zmc2V0IDwgOCkgew0KPiA+ICsgcmVnbWFwX3JlYWQo
ZHJ2ZGF0YS0+dnVoYzBfbWFwLCBWVUhDX09GUyArIDQgKiBvZmZzZXQsICZ2YWwpOw0KPiA+ICsg
cmV0ID0gKHZhbCAmIEJJVCgxMykpID8gMSA6IDA7DQo+ID4gKyB9DQo+ID4gKw0KPiA+ICsgcmV0
dXJuIHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgZ3hwX2dwaW9fdnVoY19z
ZXQoc3RydWN0IGdwaW9fY2hpcCAqY2hpcCwgdW5zaWduZWQgaW50IG9mZnNldCwNCj4gPiArIGlu
dCB2YWx1ZSkNCj4gPiArew0KPiA+ICsgLyogQ3VycmVudGx5IHdlIGFyZSBub3Qgc3VwcG9ydGlu
ZyBzZXR0aW5nIG9mIHRoZXNlIHZhbHVlcyB5ZXQgKi8NCj4gPiArIHN3aXRjaCAob2Zmc2V0KSB7
DQo+ID4gKyBkZWZhdWx0Og0KPiA+ICsgYnJlYWs7DQo+ID4gKyB9DQo+ID4gK30NCj4gPiArDQo+
ID4gK3N0YXRpYyBpbnQgZ3hwX2dwaW9fdnVoY19nZXRfZGlyZWN0aW9uKHN0cnVjdCBncGlvX2No
aXAgKmNoaXAsDQo+ID4gKyB1bnNpZ25lZCBpbnQgb2Zmc2V0KQ0KPiA+ICt7DQo+ID4gKyBzd2l0
Y2ggKG9mZnNldCkgew0KPiA+ICsgY2FzZSAwOg0KPiA+ICsgY2FzZSAxOg0KPiA+ICsgY2FzZSAy
Og0KPiA+ICsgcmV0dXJuIEdYUF9HUElPX0RJUl9JTjsNCj4gPiArIGRlZmF1bHQ6DQo+ID4gKyBy
ZXR1cm4gLUVOT1RTVVBQOw0KPiA+ICsgfQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50
IGd4cF9ncGlvX3Z1aGNfZGlyZWN0aW9uX2lucHV0KHN0cnVjdCBncGlvX2NoaXAgKmNoaXAsDQo+
ID4gKyB1bnNpZ25lZCBpbnQgb2Zmc2V0KQ0KPiA+ICt7DQo+ID4gKyBzd2l0Y2ggKG9mZnNldCkg
ew0KPiA+ICsgY2FzZSAwOg0KPiA+ICsgY2FzZSAxOg0KPiA+ICsgY2FzZSAyOg0KPiA+ICsgcmV0
dXJuIDA7DQo+ID4gKyBkZWZhdWx0Og0KPiA+ICsgcmV0dXJuIC1FTk9UU1VQUDsNCj4gPiArIH0N
Cj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBneHBfZ3Bpb192dWhjX2RpcmVjdGlvbl9v
dXRwdXQoc3RydWN0IGdwaW9fY2hpcCAqY2hpcCwNCj4gPiArIHVuc2lnbmVkIGludCBvZmZzZXQs
IGludCB2YWx1ZSkNCj4gPiArew0KPiA+ICsgc3dpdGNoIChvZmZzZXQpIHsNCj4gPiArIGRlZmF1
bHQ6DQo+ID4gKyByZXR1cm4gLUVOT1RTVVBQOw0KPiA+ICsgfQ0KPiA+ICt9DQoNCg0KPiBJJ20g
bm90IHN1cmUgdGhpcyBiZWxvbmdzIHRvIHRoZSBHUElPIGRyaXZlci4NCg0KQnkgdGhpcyBkbyB5
b3UgbWVhbiB0aGF0IGl0IG5lZWRzIHRvIGJlIGluIGEgc2VwYXJhdGUgbm9uIEdQSU8gZHJpdmVy
DQp0aGF0IHNoYXJlcyBhIHJlZ21hcCBhcyBzdWdnZXN0ZWQgYWJvdmU/DQoNCi4uLg0KDQo+IFNv
LCBvdmVyYWxsIGl0IGxvb2tzIHRvIG1lIGxpa2UgYW4gTUZEIGRldmljZSB3aGljaCBzaG91bGQg
YmUgc3BsaXQgdG8NCj4gR1BJTywgR1BJTyB3aXRoIElSUSAoZmgyKSwgc3BlY2lhbCBjYXNlcyBh
bmQgZGVzaWduYXRlZA0KPiBmdW5jdGlvbmFsaXRpZXMgKHNvbWVsaWtlIH41IGRyaXZlcnMgYWxs
IHRvZ2V0aGVyKS4gV2l0aG91dCBoYXZpbmcgYQ0KPiBkYXRhc2hlZXQgaXQncyBoYXJkIHRvIHNh
eS4NCg0KWWVzIHRoYXQgc291bmRzIGxpa2UgYSBnb29kIHBsYW4gdG8gbWUgSSB3aWxsIHNlZSB3
aGF0IEkgY2FuIHdvcmsgdXAuDQpJIG1pZ2h0IGVuZCB1cCByZW1vdmluZyB0aGlscyBmaWxlIGVu
dGlyZWx5IGFuZCBqdXN0IHN0aWNraW5nIHdpdGgNCmdwaW8tZ3hwLXBsLmMgQXMgZm9yIHRoZSBn
cGlvLWd4cC1wbC5jIGFyZSB5b3Ugb2theSB3aXRoIGl0Pw0KDQoNClRoYW5rIHlvdSBmb3IgdGhl
IGFzc2lzdGFuY2UgYW5kIHJldmlldywNCg0KLU5pY2sgSGF3a2lucw0KDQoNCg0K
