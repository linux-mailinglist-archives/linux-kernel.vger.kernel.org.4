Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E216C4948
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjCVLea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjCVLe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:34:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DAA1C7F0;
        Wed, 22 Mar 2023 04:34:08 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MBNuVJ007601;
        Wed, 22 Mar 2023 11:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=gCT2U8Pf+k6mkQcmQj01ZwLJoRnpX6iH/O3h8sEL5zE=;
 b=GWUeZbq/nr5UlEkajusKDXTcdpM9jbZp+IWrA9Y27lAgFhKMGXFtd0dIpyMiS/brx9qL
 crrsB7cSPty0zPnM/rXSZE79GGux7i5CGDi0lxFr8LdPn6wFJQsJMngO2MOHsbKHFIc2
 rWpo9jgv8wNvHRrpb/h2xBnRoqC4FH8eti/vmAtx1dOx/e/BYL801lEWQmAg+Y5DhBel
 ffajTSptf4lJDUt92PawO0EyTZWcoENZ4M/0jn2mfy1f4+ojw34rc2fKm1Yc1LN44jSq
 tR/uT/2ofwVgwnS2uEIJbXLSBGc9slxKpe1sQsEOJBDjhJ5wpUD4CpbWdiddoOkRIJ4Z RQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pg0s1g7y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 11:33:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpowMfERzSVGGsT6T7TOiR/+WXFDSDSHcieMRaa9/CIbFf2cnYmC48lfgH9uqbodrQR5dffGuzypL1EiL/VwL9f/aJh1LtStCewKJFS1+KTILh1VclLV+SPiZ6u3+t6l07H8ZUuMjH9DZ5Fs1a8Et9fzjFOVEOJNvRdXXXgExHTinVXVRzK3iNCa0NcmZEEuXTZuPRsrMQ3x62QtiVHdGiNURg58krFgSGfyqCaB2qWnlwqyClJSAQEhwSH4ITykKjk96MbxQwVWYXaskp9UOb2AoqI8SxOIXpA9K2uoKuXeNmHLcQ+Sg32xECkqEoS44nO2j7hWH2Im1BWUgRpKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCT2U8Pf+k6mkQcmQj01ZwLJoRnpX6iH/O3h8sEL5zE=;
 b=AqlfFCLiD8yvNs//3qX1f3hRpw/UrcNt5lKDUmXGEqDw7PbQIxoLwx/Mlx0sOccMRaNfOpvjWPguK2VlizP/ltem6qJlykexgBZx1owCc8seKty1h5rLN9uAR2Hh9WMvt+tLCAI4aunHzTjJ7dFaeP53sThRfAL0AzuTnWL3yBG6BhUNtws0hgQCmuu/jdJCGPqIaVLc914nGQgw4lnvE1/oyWd2whukUphNT6LHJXI6ggfynbz7z5Al1DBYLkRvI7Slz/2yporCchl5+DbPrgoqJYEBkxapHkjCtxcH1KQdU7xmzKH3uqlT6MdyvZyzXrsZElX+fTgWSGdREqpG8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3898.namprd15.prod.outlook.com (2603:10b6:303:43::24)
 by SA0PR15MB3888.namprd15.prod.outlook.com (2603:10b6:806:86::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 11:33:36 +0000
Received: from MW3PR15MB3898.namprd15.prod.outlook.com
 ([fe80::1862:a93e:ee5:60a2]) by MW3PR15MB3898.namprd15.prod.outlook.com
 ([fe80::1862:a93e:ee5:60a2%8]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 11:33:36 +0000
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
Thread-Topic: [EXTERNAL] Re: [PATCH v3 2/5] dt-bindings: trivial-devices: Add
 acbel,fsg032
Thread-Index: AQHZXCivrPfQs2uE1k+sy1bt6hEr+68Ga7UA///sboA=
Date:   Wed, 22 Mar 2023 11:33:36 +0000
Message-ID: <8D76FE9A-1931-4BB3-9047-D186575E62D8@us.ibm.com>
References: <20230321190914.2266216-1-lakshmiy@us.ibm.com>
 <20230321190914.2266216-3-lakshmiy@us.ibm.com>
 <6e4b135b-8cfe-f77c-1fe3-3dc62704f851@linaro.org>
In-Reply-To: <6e4b135b-8cfe-f77c-1fe3-3dc62704f851@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3898:EE_|SA0PR15MB3888:EE_
x-ms-office365-filtering-correlation-id: 3b593ffe-d243-4c78-1fab-08db2ac946ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wBj0F7ywi7YU4txVlVOAjomu9w/ooX5Es4mCfjzLmMDFITu7v5EaWjOLCnk5t4hXZSV4v2CVrZ+yAohutfgAh1jA1B32zPk3cdSB9wdVR/aBAVAs3Y+RWoInl2ZkNiIRMTeQV6TxIJHdRzA6DIRLNlw7TckGXV/PBIpQ99vpYuc4NU8z+ZXo1okeQ7qNMyVC1ImgD5TNRc9dYBsagowVHZ7m/B2VmZXGcf3H0mnkwtBJPuGexK8fZiBC5Uz6voXUGJ1ma9ITw2EQHjbZPS72FxuelECsYaI7TOiMxXDKngRsllt1AektCHcLBMsRmNMOrvY/UBG+NQgjoJ5k2mtUetMkjqzW1lHyiAQM5JUgBFDTkhwBzZvvfTY4torl2MZFkzK8IxvEkexGPyqt30DjrPCl4Bx4nvN8bu9xF6AGZH5J865OybkHJp/GyWBHLx3VITGGDFRQAhjXDIWGM5Nf+7pD0IwTD8PdRri67oh7dRGFhOuMgHD24+WEIQK9BWhYLwsTTS2kkNP/8TidtL01Wt4yz8OoV6RS8KjXI3NRsIBGRwCNlH6oM+uR2kfWbAQLDilMdBKdRjsXTXVZ4pRWgvhHN1BTlAGxvgND2XaPUDNaOMzJlZ7eHMf9cB/P72lKTlO25hm4M9N9MoGtFJBb7e09PRUvvEeSELRBt8syPzSiNjeK7P63yWgKdgoUN12kaIUfvyIwJeQu+lan5n76u34wXP8xpzr0ptnVIMfIS+g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3898.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199018)(8936002)(5660300002)(7416002)(41300700001)(38070700005)(33656002)(86362001)(122000001)(2906002)(4326008)(6486002)(478600001)(38100700002)(83380400001)(2616005)(186003)(71200400001)(6506007)(6512007)(54906003)(53546011)(110136005)(66476007)(316002)(8676002)(91956017)(66556008)(66446008)(76116006)(64756008)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTNkVXlWZ2lkZFVPZEFUN0VkTHVKY2N0WG1jNmMwYlF4Zitiai9xY3dnNHp4?=
 =?utf-8?B?ZjFsUGN6SzgzU0NuaFN2M0tQOENEaFZobk5zS0xacXpnZUY3U25CUGFmUlRX?=
 =?utf-8?B?MXVQUmFYS3RlRnBMZGtOTmVWVFE5aytJcHRGV1MxckhZY2ZCRTN3MTVJdU9I?=
 =?utf-8?B?dEhHZFpITmowQ2pjMzVwcFM4amNaMTFaakxNK0JTTVhRWmU0NktiRFVFQVR4?=
 =?utf-8?B?ME9DWTNxMkhkZzRrdTkvd05pWFYweEJZWEh3bUVEWjdIYWRINi84MTVmOU95?=
 =?utf-8?B?MDVZaFVIUVpNTmtzY3h5ZFB4T0tHSTRYZWRaSXpBT3RUTTR4c1JzTGIrakxN?=
 =?utf-8?B?alRXNnlKRFpuYWdXTzVFYWxIYnZQUHhlamxEOTA2TFV4dHhiRElJUk5WU2Q1?=
 =?utf-8?B?V3dSSzVjY0NBTG0xaUZDVTBmNkpXa1p6UmtzaXJjUzVyOHVPNk9Cd3FUWU82?=
 =?utf-8?B?SWM2S2s3TlpPK1FNV2ZaUFE1WVU1MW56RmIzTklUeWh1bzR6MTVsMFBsSm5t?=
 =?utf-8?B?Zkd3TzdWVTJoeFdQZHRjNVNRdHhaNkR1ak5KWjhjamVPalZZSkIzL2dydUJ1?=
 =?utf-8?B?UEU4QVJWRTBQSko2a3IwVjh0eHA5SFpCMGI3VXVHUUJCV0xGYkpMKzJSNnRv?=
 =?utf-8?B?VkZaZTg3VnNudWw0b1FpV29kS0xaaThRRnlZTWo0dTZKWjJvRE1NOCszTXly?=
 =?utf-8?B?ay9Hc1duS0lYUWtwMGdXSUZiVEs2eTRFTWFZY0FncS9jZUd2T2oyOU5KUEZH?=
 =?utf-8?B?a3VRdlN6cnF1a094eGxCTUN0N1J0VmIvSmxESzRFL0lsZ1NxbEpBTTJPVXFW?=
 =?utf-8?B?T0dENWptN1QwOG90Wmh3NytiaHNVVjJPdFhqZ3oxU1FQTkZrMmJHNUFXWDM5?=
 =?utf-8?B?VzNCeXNtYWdnWTdURlR2RFF2SGZtcW9KYnNiRkIyd1krTm9PSkEvM0RxM2FQ?=
 =?utf-8?B?MXMxYmFDT1pKV0xxa1AyUWx2S3JYdVFacHAvd3BhOWtTMnpjb3RZb1hTVXd1?=
 =?utf-8?B?MHFaTVc4WWlKT2FJSFhPM0NaZ0tWZCtTYnpPMSs2eUlNNk5UZkt0OERyU3d6?=
 =?utf-8?B?MVJUVGovejZZVGgyQ0tnSGZSOE1RdzhUT1E0cVBOSm5rNll6QUFIYllVRkZD?=
 =?utf-8?B?SjZhN2pCK3FmY051akhtOEdzdlJEMlV6SmRoNVBMWllDZFhqWkZ1YlRxbThS?=
 =?utf-8?B?UWNBQWJkSmoyVm5oNURVU2k5N3l4Zzdudk05REtZaGxlT1pxWkRCZnA3OHY0?=
 =?utf-8?B?STFMNGtOcllSVm5ZYlA5anR3ZzE5aDc2SElPNlNFY0hCVmR5OWVvSHE2ZXNr?=
 =?utf-8?B?MkUvbUt0QnBkM3NyS3o4RHRGeHg4a3FLSUgyOTR1L29ROFlyOEZMYXo4ODE1?=
 =?utf-8?B?U2V3QzNPV0NPOVhoTW9ZRVl1cjFoVGZaSzJSQ0xNVjJqcWlONkV1aUprWkl0?=
 =?utf-8?B?UUZXZ0FsQ2N3NTBCajE2V0ZWRCtJaUltcTEwV011VlNWRTBQVDdNaUlSQnRX?=
 =?utf-8?B?VzBxZW1naXJpWFcyR2NuTDArb3J1SkE4bFl3QytwUnlLdjlOTWxQNlgremEr?=
 =?utf-8?B?UDlWQUpjNzE3R01QN0ZpaVp2OUhrMXFTT29mNTBIbkltb2pNM1JMRzRWd3Fh?=
 =?utf-8?B?alhOZXN3ZDdUVjJ2SHZEOTk3Qm1rVkRJU3NobklLbVRzS3FGUm41Qi9rYzU3?=
 =?utf-8?B?bEo3Z1lSd2NLUHROendDUnVPL0tvUkpRcE5jb0xZQWQ4cEpQMUNkcjhyYXRq?=
 =?utf-8?B?aVdKQ2wxbE9VdEJJeEdMZE1VZFpFQ1hadWJ2NFJmNjhJVXpGSXlORGFjTjBt?=
 =?utf-8?B?Y2lkS240czRPWWZqc3ZJY1ZaSCs5M1IySzZENEdzYWJZdkhhNlZEZlFNZFQ4?=
 =?utf-8?B?U1Q5NlZMcEtaRHNVaFh6WGhJL3dZdUN0V3MrL3BzdHZBRkRmTjA1RkQ0NTVW?=
 =?utf-8?B?MExkQ3EzYmxDQ0NDMTU3ZG1tenZ1Q2NiS05aOFdyUFF6UWp0bjhITElFeGlk?=
 =?utf-8?B?TXFDcUhSSXdnbzcweDR6UGpmcUkyMlZQZnFaRVZjRHFxNDZWaWpXQ2xHZjNm?=
 =?utf-8?B?NGRueDFFT1BlMThLYW5CYUxEcjE0U1ZHaHp0a0ZGOUcwRzNvcEE3cXkyM2FX?=
 =?utf-8?B?ZHpNYU9SNkVQbUVTdEgrTWJwNEFVUnNRMFhuMDNoV0h3S1RmS3JvTzJwTTli?=
 =?utf-8?B?cFNKQ2NmU0NSMG53L1dTeS9jYWpyWllvUm5BeWdFUGp0RHVNZWpHb2k0QXVr?=
 =?utf-8?B?ZjdPQkhhWlZOOGdIWnZ0WXc5cGFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEDE9C307C75FB44BA7A9584EBF69CC7@namprd15.prod.outlook.com>
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3898.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b593ffe-d243-4c78-1fab-08db2ac946ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 11:33:36.4844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o07kOSP/daoQLf779VrIG8su0gOt6iA9NomicZeIpVS3WumpcS5Mtyx8HKk0W3fX1jLsHxnKf3forAjSBZ4mEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3888
X-Proofpoint-GUID: 77jzzpL8LWbc9uLj8EJDmtHKVVFOIW5o
X-Proofpoint-ORIG-GUID: 77jzzpL8LWbc9uLj8EJDmtHKVVFOIW5o
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
Subject: RE: [PATCH v3 2/5] dt-bindings: trivial-devices: Add acbel,fsg032
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_08,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 mlxlogscore=888 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220082
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDMvMjIvMjMsIDI6NDMgQU0sICJLcnp5c3p0b2YgS296bG93c2tpIiA8a3J6eXN6
dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnIDxtYWlsdG86a3J6eXN6dG9mLmtvemxvd3NraUBsaW5h
cm8ub3JnPj4gd3JvdGU6DQoNCg0KT24gMjEvMDMvMjAyMyAyMDowOSwgTGFrc2htaSBZYWRsYXBh
dGkgd3JvdGU6DQo+IEFkZCBuZXcgQWNiZWwgRlNHMDMyIHBvd2VyIHN1cHBseSB0byB0cml2aWFs
IGRldmljZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMYWtzaG1pIFlhZGxhcGF0aSA8bGFrc2ht
aXlAdXMuaWJtLmNvbSA8bWFpbHRvOmxha3NobWl5QHVzLmlibS5jb20+Pg0KPiAtLS0NCj4gRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RyaXZpYWwtZGV2aWNlcy55YW1sIHwgMiAr
Kw0KPiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RyaXZpYWwtZGV2aWNlcy55YW1sIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RyaXZpYWwtZGV2aWNlcy55YW1sDQo+
IGluZGV4IDZmNDgyYTI1NGExZC4uNmZiZmE3OWRlMzQzIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdHJpdmlhbC1kZXZpY2VzLnlhbWwNCj4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RyaXZpYWwtZGV2aWNlcy55YW1sDQo+
IEBAIC0zMCw2ICszMCw4IEBAIHByb3BlcnRpZXM6DQo+IGl0ZW1zOg0KPiAtIGVudW06DQo+ICMg
U01CdXMvSTJDIERpZ2l0YWwgVGVtcGVyYXR1cmUgU2Vuc29yIGluIDYtUGluIFNPVCB3aXRoIFNN
QnVzIEFsZXJ0IGFuZCBPdmVyIFRlbXBlcmF0dXJlIFBpbg0KPiArICMgQWNiZWwgZnNnMDMyIHBv
d2VyIHN1cHBseQ0KPiArIC0gYWNiZWwsZnNnMDMyDQoNCg0KTm8sIHN0aWxsIHdyb25nLiBPcGVu
IHRoZSBmaWxlIGFuZCBsb29rIGF0IHRoZSBsaW5lcyB3aGVyZSB5b3UgcHV0IHRoZQ0KY29kZS4g
SXQgc2VlbXMgeW91IGFkZCBpdCBpbiByYW5kb20gcGxhY2VzLg0KDQpJIGFtIG5vdCBzdXJlIHRo
ZSBjb21tZW50cyBhYm92ZSBiZWxvbmdzIHRvIGFkLGFkNzQxND8NCkkgd2lsbCBtb3ZlIHRoZSBj
b21tZW50cy4gVGh4DQoNCg0KQmVzdCByZWdhcmRzLA0KS3J6eXN6dG9mDQoNCg0KDQoNCg0K
