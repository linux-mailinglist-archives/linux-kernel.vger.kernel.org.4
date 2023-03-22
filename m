Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C364C6C49E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCVMGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCVMF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:05:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C999B5A6D8;
        Wed, 22 Mar 2023 05:05:57 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MBsYmZ010947;
        Wed, 22 Mar 2023 12:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=1StMXUwOMMhwu8lv2CcBNYNDBM4crxmcH/K0NzepELc=;
 b=lqTjlPDbCTTb8X988Wa8knPuTCvi0DF4b958GNXZg6NaA4P13W8z8WHVPymMpLXkvO2C
 /KkfQgIujVj2KLEKh29/gX1dSsUanSsfYB57zSN1VHO/OjNnI09970hS1FwqC2Gj9n/E
 9rxmqmYE2hritL/7sMgBwZIcrTMdfeC6CMrtQjsr9urz37/Ytq6My2CvLJoXxwXl/gAh
 MIAezTC3yWTuef5o1q/Piegr4qAy8gdhwbZ/ScY9LjVV97cVaeuCuQEBmbDWF/2eS5SF
 O0HqQ7e7l+F+MtNK96uIqxDYwQPX5sExujRwGXWIjL42HXj2WpN8rylAKpJ2uxPrAX5K QQ== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pg17drabj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 12:05:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gn2NAgo6+uwIJYZoIG5C+bCawOumU3gLnsigwGzu7WfEkODcVOkoTmvH0JYtsxguX5t21IJaMnXgDMo9DclVZCA6kUjaKZAzif6r3jQ9+dhI5fM1tfGmx6fUX/sEDWdpoO03xEpRZ16c9za2c0dVlYWjZKkkHPBOPcdDWKi55uiugAmASkYX8aCTVtABgO3uL3ncoBTmQLe1c/domIkhnQnTlsg5EgA9ir0+j2GJ5EKnKDTBJNumWNFgsyRxjpsIJgPdQ3XtnQJIqkAoCfZ2l8zxESlmyflFVm0VLK6BKPI6k/Fq2QsmIY9QkMZerOce+1JKPZfmuYiYkKioivJfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+PUlM9en0qN3TnY/xqpj6rStwmoZZdm9q1Num1lZqc=;
 b=CZNWdFRvvndPrey0U09pq7diRP1dXjUmBM6idUJtf1YbxUfFid8ZAPGlWFB1zs+ctaqTo3YP7rzhsdXvVqBU/MuZM04LQlk5j7VBl6fPTKtKRQ+XwkEmlkyWN+b/DN1yLzTDiyrcG8Gfjl0BRs8/dhQJMU1xMXJGOiK8nbG0472+grdj5uctyUFXIajBdq2XedmLMLsWsz/B7bsjcC2CnLUTV4Kwtv4s/kvLbXnxo8lSizTdXPwstbPJYFX0CD84g+B9u43mlcdkr6fEF3I1j/VdL1/k9rkpqFqAfDlSParlHbHYT7nqF+4ymYJ9wyXCd24L1mRQB7RUFYuLJ3IN2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3898.namprd15.prod.outlook.com (2603:10b6:303:43::24)
 by SN7PR15MB6190.namprd15.prod.outlook.com (2603:10b6:806:2dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 12:05:30 +0000
Received: from MW3PR15MB3898.namprd15.prod.outlook.com
 ([fe80::1862:a93e:ee5:60a2]) by MW3PR15MB3898.namprd15.prod.outlook.com
 ([fe80::1862:a93e:ee5:60a2%8]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 12:05:30 +0000
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "eajames@linux.ibm.com" <eajames@linux.ibm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v4 1/5] dt-bindings: vendor-prefixes: Add
 prefix for acbel
Thread-Index: AQHZXLP1E0g5PqdLhEW4rAlXYBzJh68GryEA//+w1YA=
Date:   Wed, 22 Mar 2023 12:05:30 +0000
Message-ID: <261D3F69-622D-4167-8721-12CBCF021E89@us.ibm.com>
References: <20230322114623.2278920-1-lakshmiy@us.ibm.com>
 <20230322114623.2278920-2-lakshmiy@us.ibm.com>
 <c750e047-b8df-685e-df0b-5212aaaea0f3@linaro.org>
In-Reply-To: <c750e047-b8df-685e-df0b-5212aaaea0f3@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3898:EE_|SN7PR15MB6190:EE_
x-ms-office365-filtering-correlation-id: 6c0fa189-5f9a-49cf-b430-08db2acdbb57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /wumy2VwzEmRlAYx6KDi11aTj9NFKzuzDNlLWJ4g2qQXV7jwuVDsrhDlyjxAmDyn9QwjPeDpdKG1O+GylxQR+JFdtJJtLQCTrl1VXjcsXID7B3asM37hIxrm9q45UNceS7r9xan0FUXf6HuOo+mG2a/TyvKyRwaZjd/w/5TYvuuwJ7RwVuDHVogDsmh55WSGW0wgHmrVZo3vm1YQToFFfy3ovtReETX2sHxA2Qy7/cJeHfreG/D7d6W+MLng9Xpo6sLEDwS6OcvJKxJAJf2rhpdKSsJ3KtNkTbryiu34+bRlD+a+v+2cmpavM9gVPLsAr4RAOv5u+9tkA4HFVHNggjRa6KT4sqpsLvzQ97Njny1jev/oE1GirwgXuMhaJnDqtiXbpEHuT5R/Mt7b1RUKtW9DQqCWUd2mWlZHnYf43MnwtpfuNpRGnVW66AXlFIRMvz4RFiK2vHkRz6BFF/qWpZMS6EKfXmLAyUB8PWikUN1aPwYggW8vfuhoDZiY6koMSp4NBP3eqB9SXGQrtF3P8WGcgOx3Vp/nX5oStYU0YPBCcBDCRBBdvPLmpVsgxVI3tdf38J7E002HEENAqXAiPSiNmbLE8s5TE7vHoo9L+Cj+Nf79MdTyZucxxvOhsAYAo1TtuWiD9zFn7+cG+Fu0xDMzJU8XfX0tTtDWZ20sQ48hgv5HGXw7Q2KUqyHTdtaHIBqHdUXpnCLZFhfWkXJyxndpzMyGL5yVpn0s9BX3ys8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3898.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199018)(8676002)(5660300002)(4326008)(66446008)(64756008)(76116006)(66556008)(66476007)(91956017)(66946007)(7416002)(8936002)(41300700001)(186003)(54906003)(83380400001)(316002)(478600001)(110136005)(2906002)(6486002)(53546011)(71200400001)(966005)(6512007)(6506007)(33656002)(38070700005)(2616005)(38100700002)(122000001)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFcyMzhjbjdaSHdNRkRjNHJtd1VOWXAxSE9XNFhRL3kyV3FXNTlIRURpdFFa?=
 =?utf-8?B?R2V3b1o3L0ZxL1B0c3R5NEdFcU4zSVhvaC91VENRbWR2Z2NMYTFMMmdqdHBl?=
 =?utf-8?B?aWM1M1l0b2t6cVFEM1hNY3BRVEFrRlJSbUsrRGVXcGUwUTMrRWVuaFpKdzF4?=
 =?utf-8?B?L251VWFkTHdyeUEvdWZzUjB3ZDdrSSs2Y1dmMTZOck15Ym1xN0dOQURsQkxX?=
 =?utf-8?B?aytlM2xtWVplVUhDd09IR3lLYTJ3ZnMrNGROQnpWTGMwcm1OQ243dTRBMytl?=
 =?utf-8?B?WDZNV1Z6bkxxTHZ2L0xrQWloTUZUY1pObjJNSnR5TDVXb0JhMGV3VFFHMnhu?=
 =?utf-8?B?VHF6dklxZmtXcVRYVzZySmRPUkkxTWNPN1I5MmdWc2lRUXFVODVwbUF0RE5E?=
 =?utf-8?B?YnRBdWRIMGR2WUF1WGV1SHR4cUZwUEFNR21ZZmJwaG1BTE1ZRHBSVCt6bVlx?=
 =?utf-8?B?WVMvRWVFUXZuZm9tbFA3VUl0eEtDbWRBZm53bmR4L1VzZnI2cXhlU3R2MjdQ?=
 =?utf-8?B?NHBRQXZHNzFaTXlJQXNYRWNtWkMrUkhQdVRQR3JzbTR2V0pxYVdlOTZ2S0VV?=
 =?utf-8?B?d1h5UnZUMDMwNFhDQWRGSWlGSkFRVnN6bnB1WFZQZnVHb3JOcnd3bUNEQU5a?=
 =?utf-8?B?Y3VYeWNwdlQ4K1dsTTdyaEZoNmRMUDJZYTN2V3RqbWNtQnpmd0JCTWcvSVI5?=
 =?utf-8?B?VVNRVS80aG44NGM2WnlEVDV1eWthaUwwRGFaeGR0SmJadTF1Y0ErbVNscVhl?=
 =?utf-8?B?WG1HN1NSYWd2VSsxQmJHdDh3MlYwODN4Y1dMenpTV0J3YmttMW9wdmxlUGQr?=
 =?utf-8?B?TEkyZnd6bnRUNlM3OHZDSEJQb2NaejNGcDZkTExKY1pqQml4RUJnczdVeE5H?=
 =?utf-8?B?QWJCSURRYmNVYjVZZEhSYlh4NC9QUnlrVUcrUUV3bWpvVFRvbjQ3L0dpalY4?=
 =?utf-8?B?cG5aa3NZeUpYSlliQ003THlMdTlmM2ZJSm1pcmorK1daR2tJUXRsRXdndDVh?=
 =?utf-8?B?eEpWQUFwdFNVRVJab2dRbVQxeEVDdlF6Uk5TNVNQa09JZ0pSQTFJT0tSQ2ps?=
 =?utf-8?B?WWIwODBzL0c1RUJGL1JMNXdxZGNTQWFHdGVjS0M5VjVWWTkzT0NOcFZsVGpF?=
 =?utf-8?B?ckJVeFU0cVMyUXp1VytPNm4zKytVWVlNazdnaEcyNDkyemJJMUVQSkNVZU5p?=
 =?utf-8?B?alh0U2pZTnc2VEhnVnZjYmIrMTJYVGNjdWZCdEpnazV3RjhObGRQUzZLYlp6?=
 =?utf-8?B?WTFNTzhIZW0va1BXUEllVmdWRnhQVDNIakJlK2R1a0RIbzU1L1h6OGcyTGdy?=
 =?utf-8?B?cWo0dVk3OFRPRXV5YVR4ZXVOMFMwdlpWT0QwVHVCc3N5RlQvYlEzVUxkTkov?=
 =?utf-8?B?ckE4REdVR1k4TU9SUThMRFF2MzY0UlliNnl1RmFMYjZtNnJsczB2dGxQS1Vn?=
 =?utf-8?B?RzZtOHVGazVWZXRiZ1NCSzZhNDlydmxXeWFiSXBtOXBkV1hCclVpdlVpcENn?=
 =?utf-8?B?cDNDVHFIZ0pIWk96clJyeHM0N3lqTm5HeDl1WHhBWTkwUUQ4RzE3aVBoREVI?=
 =?utf-8?B?VFJMbmRHZHRqQXFkbCtLYmluZ3pzVVIxQ1pnZW14ZisyaW9rbjFYZFVBRlZ3?=
 =?utf-8?B?N2JqUjV1c01KZlptVnp4VVg1aDlhamZncXQwbTJHSndyM2JqelZhcGNoMW4y?=
 =?utf-8?B?bzgyZFNPem94c2tWN25GTlZ6S0l5aExBUEpnalYrMXR2VmMwM09zS1JZWnlu?=
 =?utf-8?B?TzhZWXdYMXdKSG1aNFhWb1lFWWRaNkF3bjYyVGZFVytuNnRCVGtqUFd6V0hn?=
 =?utf-8?B?bUYyaks5R2s2WnhjVTlMMEZ2clJCQkNZc1NzRlg5d1FaWFI1UFJhVm9ydXV5?=
 =?utf-8?B?VDVNbkFhdHBhTWozZkgvbU9Xa0JHYUlOMUFPekhWNmxHZmxTRGVPUjVIVHhY?=
 =?utf-8?B?cnMwZU5QUUlqcW55aS9TU3E0Q0lDemtWejFRVmFKZTR0cWdyaTRIa1hmaklN?=
 =?utf-8?B?MkI3NXRCM3NJellsTE1sVmJBSHpySjhxQ1FiYWJRazZGUEhzWndaWHVqKzFs?=
 =?utf-8?B?ZXVpUW1jbVVsOTlIZSs0c2JiVU1XRXdJQmdWK056elBFUnJabi9HcjFOL00x?=
 =?utf-8?B?QitoZVJTVmdSc2pvcFhNKzhnVU96NDh5ZUJHNm5jSFpia2oxQW42czM1UzJn?=
 =?utf-8?B?WDhyV2w1Vml4Z1M1MzNmcmNmdnNtMkdIMXIyYnUrc0Jack1oSGhlRE9Pa0VT?=
 =?utf-8?B?L1NCblVJY0hjS28xYTZZU0xXUUFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93516C11B116844781C7A3072DA172F6@namprd15.prod.outlook.com>
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3898.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0fa189-5f9a-49cf-b430-08db2acdbb57
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 12:05:30.2494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KIbfZ/nQnBm6h7RYA9pHWaBb77pYRyYi75CAeG5P1XA4X2ryGqn0Hwo9cJUuHJzlaBAYsaNog9v3FvoUTRxGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB6190
X-Proofpoint-ORIG-GUID: vdNtx1dYlBU6Bq_goT8o0L4paPR2dpjq
X-Proofpoint-GUID: vdNtx1dYlBU6Bq_goT8o0L4paPR2dpjq
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
Subject: RE: [PATCH v4 1/5] dt-bindings: vendor-prefixes: Add prefix for acbel
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_08,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=795 phishscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220087
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDMvMjIvMjMsIDY6NDggQU0sICJLcnp5c3p0b2YgS296bG93c2tpIiA8a3J6eXN6
dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnIDxtYWlsdG86a3J6eXN6dG9mLmtvemxvd3NraUBsaW5h
cm8ub3JnPj4gd3JvdGU6DQoNCg0KT24gMjIvMDMvMjAyMyAxMjo0NiwgTGFrc2htaSBZYWRsYXBh
dGkgd3JvdGU6DQo+IEFkZCBhIHZlbmRvciBwcmVmaXggZW50cnkgZm9yIGFjYmVsIChodHRwczov
L3d3dy5hY2JlbC5jb20gPGh0dHBzOi8vd3d3LmFjYmVsLmNvbT4gKQ0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTGFrc2htaSBZYWRsYXBhdGkgPGxha3NobWl5QHVzLmlibS5jb20gPG1haWx0bzpsYWtz
aG1peUB1cy5pYm0uY29tPj4NCj4gLS0tDQoNCg0KVGhpcyBpcyBhIGZyaWVuZGx5IHJlbWluZGVy
IGR1cmluZyB0aGUgcmV2aWV3IHByb2Nlc3MuDQoNCkl0IGxvb2tzIGxpa2UgeW91IHJlY2VpdmVk
IGEgdGFnIGFuZCBmb3Jnb3QgdG8gYWRkIGl0Lg0KDQoNCklmIHlvdSBkbyBub3Qga25vdyB0aGUg
cHJvY2VzcywgaGVyZSBpcyBhIHNob3J0IGV4cGxhbmF0aW9uOg0KUGxlYXNlIGFkZCBBY2tlZC1i
eS9SZXZpZXdlZC1ieS9UZXN0ZWQtYnkgdGFncyB3aGVuIHBvc3RpbmcgbmV3DQp2ZXJzaW9ucy4g
SG93ZXZlciwgdGhlcmUncyBubyBuZWVkIHRvIHJlcG9zdCBwYXRjaGVzICpvbmx5KiB0byBhZGQg
dGhlDQp0YWdzLiBUaGUgdXBzdHJlYW0gbWFpbnRhaW5lciB3aWxsIGRvIHRoYXQgZm9yIGFja3Mg
cmVjZWl2ZWQgb24gdGhlDQp2ZXJzaW9uIHRoZXkgYXBwbHkuDQoNCg0KaHR0cHM6Ly9lbGl4aXIu
Ym9vdGxpbi5jb20vbGludXgvdjUuMTcvc291cmNlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJt
aXR0aW5nLXBhdGNoZXMucnN0I0w1NDAgPGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4
L3Y1LjE3L3NvdXJjZS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJz
dCNMNTQwPiANCg0KDQpJZiBhIHRhZyB3YXMgbm90IGFkZGVkIG9uIHB1cnBvc2UsIHBsZWFzZSBz
dGF0ZSB3aHkgYW5kIHdoYXQgY2hhbmdlZC4NCg0Kc29ycnkgYWJvdXQgbWlzc2luZyB0aGUgdGFn
cywgdGhpcyBpcyBteSBmaXJzdCBjb2RlIGRyb3AsIG5ldyB0byB0aGlzIHByb2Nlc3MuIFRoeA0K
DQoNCkJlc3QgcmVnYXJkcywNCktyenlzenRvZg0KDQoNCg0KDQoNCg==
