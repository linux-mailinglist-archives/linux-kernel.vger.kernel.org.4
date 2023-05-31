Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE6071893D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjEaSSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEaSSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:18:14 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4002112F;
        Wed, 31 May 2023 11:18:08 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VE7JYl017051;
        Wed, 31 May 2023 18:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=WCUHh6bQCpvhpuDXWe5YchsWDcxgTNxY2iglOEYnSiQ=;
 b=Fcc7yC69rFe7NyYnzlLn2RJXBvsn0BeLl6sL2tSLUOt6SbsjA/AdqgkDMLNKAhwYZHVS
 kuNHjhxIwvYAbAQzPFrAdJ292lq7QkuIT1lzuvMRGsdZ+dpp2EattRqzc5YsQxg3Gkgs
 gmKLpD3bFkQnJ0ufr18Fp/yIKxMqtQv19vCGytYgV46vF3SNPeTRwzK4qsTtC3x0jgmO
 2VtTLFytdDiCNDC91se7922M1PsztiMvFur1VqA3k2pH3egMRkxlkeQXpMn6IfmgVub0
 Eezkx0jipSHlUFDod5xvcs+RhFDYlogGbmmaZDnSeNzxndcgDUWUaUa+0ReuqzHcexBg Mw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3qx7qdt2fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 18:17:33 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 108BE80018F;
        Wed, 31 May 2023 18:17:33 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 31 May 2023 06:17:32 -1200
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 31 May 2023 06:17:32 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 31 May 2023 06:17:32 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 31 May 2023 18:17:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFeoyb1QrM0zTHycBdolbnGDR767hpVf1m/evIA4Ab/ytxAyanBgs4RKf0bmFAAmnZAlDp/OapMHArXK8wu0+/ldgxh85lquhmS5z0KDa9AbGM1+x/LMX4YJaScGRW3lLOWPchCubWktnvkGNZPTw9o3T3jvLupILir5BvD9TALUb41RW+tu2C59p/OcgecY8Gko4Zc9Q7XL01wT7xETxfm1RqEnmOz5MpJNCgtAw4Fp2o0VXPlxqy7gyZX62MYDr2igzeHfdMHzM+upH8h1YD/6sSssLqORlFUjtMEzu2k5Dn82xPZ5Mvf9KW9htZcZXLnkeYphoGc6wJc9ZY3CEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCUHh6bQCpvhpuDXWe5YchsWDcxgTNxY2iglOEYnSiQ=;
 b=aWtBT7Vsoi83OQvmnPQ7nCGAmXX9WYB9XscCdDJ/UUS8Lanqgbfm42Cp8cjcIqA3+n/WCQKE1FFUAdRPmmRAfQouHtUCEN+9JAZX4WzZIe0i6ddrXTMIrYAVe+EG4DSuoy2guyZGV7wZplu3Xb1o7FPLRkmaVk37A6UwTCZH5TkOFAVPZJFnj4+Fs3YT7T2OEqOv6Jy6hTux0QKffnr6aUbrm8Aw75c2hWIdY3bkyo2qX4dm9mOl/4fcBNPzukfkFX2fzjZG7FjDPoxiFVeKo8bBbbqf/2LCbc2nBeJ1Fpin3Sy1gVrgvfN/T34BPmqosMh7yDnZ3MHC/SWTWaLb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 MW4PR84MB1417.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a4::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Wed, 31 May 2023 18:17:30 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682%5]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 18:17:30 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: RE: [PATCH v2 4/5] hwmon: (gxp_fan_ctrl) Provide fan info via gpio
Thread-Topic: [PATCH v2 4/5] hwmon: (gxp_fan_ctrl) Provide fan info via gpio
Thread-Index: AQHZk9PWKQUBcQjeO0mLSJz9z8PkXK90ljUAgAAVFxA=
Date:   Wed, 31 May 2023 18:17:29 +0000
Message-ID: <DM4PR84MB19274F575858CBCB2FA5C23E88489@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230531151918.105223-1-nick.hawkins@hpe.com>
 <20230531151918.105223-5-nick.hawkins@hpe.com>
 <07b2a2f7-5ddc-0f10-6b1f-184dc21fa580@roeck-us.net>
In-Reply-To: <07b2a2f7-5ddc-0f10-6b1f-184dc21fa580@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|MW4PR84MB1417:EE_
x-ms-office365-filtering-correlation-id: 50809032-29ee-4ac3-0207-08db62034bca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MfckyVRsitqW8JW76clpS9661ytbSZHUY9K1WLQJfDUAtYqKhexM4EI5yzUKitJ9vJxWaZqyLGUfLWpT2J+nZuiEHUt4yI7moiAnWBVq++4p7SM1D+rQG7j+B9zSsYYyBG1vWpixG3ZjUsDFi8/hzy6XrOoN0wnrhK0qQx9NT5mAZF8eeT937Qj+FecRsxqYy4f98zQGESrMcbbgh0o4R5d/UhzHkIZ57fToRWJfqPqxwlKi/JTPejW+Mm/ei00ku/MJCKFCV2EGTsBzya9cpFk0zpRWYK49bfxQUcrXoK/cXLt2sHBm5F/pk17NEPXuzTa4ppeskMGN/SQQeTZumcM71ECfIbmM5k+TtbzI/32w0EuF5/HPnnfkqco38Dh1sLTbPz4swJktPzs4h9VsvEN3ocmRzag+G9pqFE66Dj3im4kpvGDM8bQ600fQ2H4GMLGZcopxLHD52ysoGkT4M0FI7hvvgcRZ5mRrp2lja06Ff2MtrjuY9CrSXhlq7zNHetmnqqaq6oXlbN5rWoT75u8qKceC0YRdj+A1oKN8TuqV2m/maqtGlfpaevrOuIP71ZPUFTy+XFk3uWG/L8Ezr4itJlpEUoDfFVlDzxm6G5I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199021)(33656002)(86362001)(66446008)(4326008)(478600001)(54906003)(38070700005)(316002)(66476007)(45080400002)(966005)(64756008)(66946007)(66556008)(76116006)(6916009)(7696005)(55016003)(71200400001)(5660300002)(8936002)(41300700001)(8676002)(7416002)(2906002)(38100700002)(82960400001)(122000001)(52536014)(26005)(6506007)(55236004)(9686003)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGExWkRwMjh4Y01ockVFelpUcWd4Um5vTGMxUTBnWTZ3NFpldWtuYTlGQjZ4?=
 =?utf-8?B?NDlJRTZaNVRxUzdSUWdBUDVpQ0ZUMnpOdlgxbVovMVFQdXEzVnBONHlmM3Fi?=
 =?utf-8?B?RjQ5NDU4NktVeFZNRXlEWjQ1eWg3MFphdEt0VlhRUkNMZWtXQU9hV0lJWWJ2?=
 =?utf-8?B?RklGb01ISkJIbElVdFBCVHcxRVJicWhPTVJqQzY3SjZJcHJCS2ZCVUcwN21T?=
 =?utf-8?B?VkswMkNhQlFuVzc2OGJXcGZRWDFseWQyMEJwbzhjRzhJYjhkSjV0TTlGSWls?=
 =?utf-8?B?dUt3bmMrU1Z2MDdYSzB4bDE5R0Z6amRNWk9UL3VQMFZCRExSUEpvSXpmZGUv?=
 =?utf-8?B?RkdFL01OVERmbnlHMHFXZnFPbUx5VTJvRG9RQmxiNGNMWnM5NWFqSUgzWVhU?=
 =?utf-8?B?djIwVEpuRFBBeU9WMnVHQ0VsNnM5eHEyVnprRDQ5UWhEcDBCZUlLV0hocWZE?=
 =?utf-8?B?TW5xMG1rbFFXbHY1bk9aM2w5SEhKbWYyMUEzOStkc2Z4WGZTbWk4d0ZYMnJB?=
 =?utf-8?B?NWhsaUNONDhnM2psbjNFRjg3SWo1SnhmVXR0ZTFTOVB5dkhvTGpuYnlmZWZ6?=
 =?utf-8?B?VlgrbVdjQ2NkTndqTlhGck16MytneC9KQmxEZ3V5ajFQY0NQUVllQ09SZWRX?=
 =?utf-8?B?bUZpVk80WFFvMkJ0OUVGMkZpYVU4ZnJVN3F1blk0b3Y5Z21rL2JKUlF3SzBq?=
 =?utf-8?B?czN6VmtpdzNCS0VDT2l3bTNtY0tKVDdSY1RCRHI1V2trczZ5eUloN2RiOUJL?=
 =?utf-8?B?YmxhUXpwYk9OMThrdmZaSGJ4RnBCRGZaN3pKNHRCZXBvei9jMVpQL2s5VXJz?=
 =?utf-8?B?dGRBek9EYUcvK2ViMG5mNUFaSnJlZFlVS1Q2MTZLZ3V4ZXI0TlJnODFDU0hk?=
 =?utf-8?B?WlJqVnFhaUJYdGpZVmFLSm0yQWI5Sk9EZ1JOU1dSNEFKaU1aRVBnTFp1S0lC?=
 =?utf-8?B?c0twSzl3R0VqVXlqeFIxQzY1c0VCdGw1a3pxeHFkQ1k5YkNsTEV5NUFhaVAz?=
 =?utf-8?B?UnB0Vk9CTndOemRoZVJsK3EyN2liUXVsdEtEM0lMckR5WEEwSjJ2cHMvbzZ5?=
 =?utf-8?B?U0pGR1Y4SXhiNndKMFhWVUNlK053aU1UdTlCYW1XeTFORjdLcGUwV0g1U2hV?=
 =?utf-8?B?V2gyQk40amIzK25ZSnJGaGZjRCtZV0VldVh6Y1lkS2ZOMTd2aUYvcnBhdGU3?=
 =?utf-8?B?VzBJbHk3cldvMjJURmdiaUZrTzVCSmM1cWRjN3gzWGMrNzlxM0pnMHJpbzZN?=
 =?utf-8?B?YndhSWJXWjVnMHQzcmJhZFdxcHV4bFlUMUh6ZmVQKzlqYXk1NlB6LzZFUDlL?=
 =?utf-8?B?N3RFQ0tYdEJIRGxiWFowcEhNTWhsR0JrS0pObzVZeHJ6eHBMdXBRdEgrcHdj?=
 =?utf-8?B?Z3o4aG91L2pncGFMeFJEakVIbHlyblRVM0hGelFHaTJhbjFpdTdvNnFTRS9I?=
 =?utf-8?B?M3VjL1FqZ2FOY0tDeGk2VE9Odm92ZnlKR2hoa1lxRWl1bXVZS3BDYkw2UG84?=
 =?utf-8?B?SURIUGs0M3hjeFYzbFc3N0J2b0JqSUh0OVpaZGJMYzF5SkdaK1E4RzRXeG8w?=
 =?utf-8?B?WVFHalNzeHBCdzN5b1dUOWJJQVhjalFLa3dWZXBBVTVZWUFENEpjUVZnazVz?=
 =?utf-8?B?R2xRaHZzR0hNOXl4MHJORzhlL3JjZXFCbzZEalBxZ1hEQzR2T1dzL1pMT1pR?=
 =?utf-8?B?TDk0cDNtaEptRXVnUDdvZjdDRFNvQTh0aWxJemlnWTdPdThNNmxYcTRteWE2?=
 =?utf-8?B?M3hXQXJqNkpyNHNWckdYTHpYME8yL2pIdEVBTGFGMTFrZ1JuaXhrb2J2UDU0?=
 =?utf-8?B?Y3FVdVR0N2l6WFpMRjYzZ040d1lueUNEZDhpeDZsSUtUWVJwMkl0d2FPVHhT?=
 =?utf-8?B?N3V4dDkyeTYvbEZLcWI0NGpmUWt2T3BudkMxbHlmNkM2dFk1alBnR3VoNkdo?=
 =?utf-8?B?S215SnZTMkVCczRQV1FkY2F1Smd0RG91S0ZBcVRqOUVETmVEeFA4azRzR3Yw?=
 =?utf-8?B?b1RGQy9GSWFOTjY2M0x1VzdVNWQxWjZCY1Nkb2xLVlNLYU5kMTJDTUEzanJi?=
 =?utf-8?B?NGE5aG1RUlVCa3VLUFJIckdFYWJ0QnVERzM4SEI5a3A5Q2Q4Z2Z5SGtNZ0VX?=
 =?utf-8?Q?UaF6X7/ZPrP59la8pMMWfJjFV?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 50809032-29ee-4ac3-0207-08db62034bca
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 18:17:29.8444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tvPb3HScRkxnP32qUO9Ox8ZKgAIaMMegow6Ccls1r9GFyHja520sGY3sEtIfsfD5+eo2zAYAB7jRLxWea86Pqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1417
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: MBJSG0jYa4Wfrvq0VLhnjoE09zq_aCOb
X-Proofpoint-GUID: MBJSG0jYa4Wfrvq0VLhnjoE09zq_aCOb
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_13,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=849 bulkscore=0
 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310153
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGlzIGlzIG5vdCBhY2NlcHRhYmxlLiBJdCBpcyB3YXkgdG9vIGdlbmVyaWMgZm9yIGEgZ2xv
YmFsIHZhcmlhYmxlLCBhbmQgaXQNCj4gZG9lcyBub3QgdXNlIHRoZSBncGlvIEFQSS4gQmVzaWRl
cywgdGhlIHZhcmlhYmxlcyB3b3VsZCBoYXZlIHRvIGJlIGRlY2xhcmVkDQo+IGluIGFuIGluY2x1
ZGUgZmlsZSBhc3NvY2lhdGVkIHdpdGggdGhlIGNvZGUgaW50cm9kdWNpbmcgdGhlbS4NCg0KPiBJ
ZiB5b3Ugd2FudCB0byB1c2UgZ3BpbyBwaW5zIGluIHRoZSBod21vbiBkcml2ZXIsIHVzZSB0aGUg
Z3BpbyBBUEkNCj4gKFtkZXZtX11ncGlvZF9nZXQoKSBhbmQgYXNzb2NpYXRlZCBmdW5jdGlvbnMp
LiBUaGVyZSBhcmUgbG90cyBvZiBleGFtcGxlcw0KPiBpbiB0aGUga2VybmVsIHNob3dpbmcgaG93
IHRvIGRvIHRoYXQuDQoNCkhpIEd1ZW50ZXIsDQoNClRoYW5rIHlvdSBmb3IgdGhlIGZlZWRiYWNr
LiBJIGRpZCB0cnkgYW5kIGNyZWF0ZSBhIGRyaXZlciBmb3IgYm90aCB0aGUgZmFuDQphbmQgdGhl
IHBzdSBidXQgSSBoYWQgYW4gaXNzdWUgd2hlcmUgdGhlIGhvc3QgYW5kIGxpbnV4IGRyaXZlciBi
b3RoDQpuZWVkIHRvIG1vbml0b3IgYW5kIGFjY2VzcyBpdC4NCg0KSSBtYWRlIGEgYnJpZWYgcXVl
cnkgYWJvdXQgaXQgaGVyZSB0byB0aGUgbWFpbGluZyBsaXN0Lg0KKEFwb2xvZ2llcyBpZiB0aGlz
IGlzIHRoZSBpbmNvcnJlY3Qgd2F5IHRvIHNoYXJlIGEgbGluaykNCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC9ETTRQUjg0TUIxOTI3NDgxN0MyRDhBNzUxRTMyMThGNDg4ODc1OUBETTRQUjg0
TUIxOTI3Lk5BTVBSRDg0LlBST0QuT1VUTE9PSy5DT00vDQoNCkkgYW0gb3BlbiBmb3IgdHJ5aW5n
IGEgZGlmZmVyZW50IGFwcHJvYWNoLCBJIGFtIGp1c3Qgbm90IHN1cmUgd2hhdCBpcw0KdGhlIGNv
cnJlY3Qgd2F5IHRvIHByb2NlZWQuDQoNCklzIHRoZXJlIGEgd2F5IGZvciB0aGUgZHJpdmVyIHRv
IHRlbXBvcmFyaWx5IHRha2UgdGhlIEdQSU8gYXdheSBmcm9tIHRoZQ0KSG9zdCBhbmQgcmV0dXJu
IGl0PyBUaGUgaG9zdCBpcyB3YW50aW5nIHRvIGhvbGQgdGhlIEdQSU8gYWxsIHRoZSB0aW1lIHRv
DQptb25pdG9yIGZvciBjaGFuZ2UuDQoNCkFub3RoZXIgdGhvdWdodCBJIGhhZCB3YXMgcGVyaGFw
cyBoYXZpbmcgc29tZSBkdXBsaWNhdGUgSS9PcyB3aGVyZQ0KdGhlcmUgaXMgb25lIGZvciB0aGUg
aG9zdCBjb25zdW1wdGlvbiBhbmQgdGhlIG90aGVyIGZvciBsaW51eCBrZXJuZWwNCmRyaXZlciBj
b25zdW1wdGlvbi4NCg0KVGhhbmsgeW91IGZvciB0aGUgYXNzaXN0YW5jZSwNCg0KLU5pY2sgSGF3
a2lucw0K
