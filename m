Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC7E682A67
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjAaKXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjAaKXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:23:50 -0500
Received: from mx0a-00209e01.pphosted.com (mx0a-00209e01.pphosted.com [148.163.148.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37DD38B6E;
        Tue, 31 Jan 2023 02:23:48 -0800 (PST)
Received: from pps.filterd (m0115755.ppops.net [127.0.0.1])
        by mx0a-00209e01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V4Fs4t021709;
        Tue, 31 Jan 2023 05:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pod1119;
 bh=N5YyEMJDDzKyub+XABS7G0iVe9YKsdMkJqwtkciQPoo=;
 b=yJaudFx0Rtkx8V2AqYinp25CqoVtv9Le7+e1jyBFrGXmdPGziMXAq2lyaV4rvx9EyYwm
 /fQ6fsCgsC/cK4WZZHqDjfgiFb6e7gYgY4nUHlCPKfTlRnkvDl+nd346/zTIWwRdWy9f
 eV48MRa7UT8cfWiXQ6uu5xzNy9z1BhLtU3Th417L19HF/iUK6i3Ak+xMhTaAhOmzqsfP
 hI7SXKwxbzDxODKlEw8FkS/AOYBTKklHI1VvTtolapyewqMXMwupPzNsHGhJi7X9unEo
 bf4IQn2mOe8/aRORHI9d6uwJ+fqq+zwrCDVFDf+wgs7X+lJxnT5sGvTqH020bVQ86uYo Zg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0a-00209e01.pphosted.com (PPS) with ESMTPS id 3ncx7wkpfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 05:23:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWsxbxQvHCLN3ox9q3NSfXviff2nbNSJ2JAtCR99sWvVUn2MBN150nv0NbPyHAEOOaipE0QXsoqbDrKBsf5114NqWX/zkRWkqXpEh5r4tX4193qG0NBGGV7uIY3APQlF+tTk9Oo/n+wZQRFMxfHNRnJX0mvmk/p3hlltoLHhAca5pouzncjhy11Yt2mMzVxIS634ihNZUn/JusLRBHg6sO1s2sndu7o0TzzhWoR6GIFHkMBW0mLpXGv8IlCY+eTZysaQF4K9sTO5kSQMpiShV1mfKDjE3CCgDOVsTcKSc8UdsQF8kKMqezTbYKn5teqR6hmnbwChKOqm8BVinr10aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5YyEMJDDzKyub+XABS7G0iVe9YKsdMkJqwtkciQPoo=;
 b=Nj7ilWH3LpurfBdJgba+vY8o8vrRz4fjjwRlN3cCI79aNdRm16U5yFyd4eGZVsipl9EguRRyno3XWJIc0URLpzA5ugwjUcKWUweIOes9fXX3mFvDfkTNqT4RcEBXMZhCeXuNSsTIw6uge3uw5+HA8IGj0WucwMqwSndr7ygJT75iP4wxnHEZSqwt1SJ4+Bpty+LB1zDDvYuqFKipaxF/kTxVtSDk4uDG4rzppZtCmzSPa/6XPP95PnpESRNeQUOHyP6yF/chx3F16JnjTgZF+g2C6yPoE5qaybl9kwWd6rmJ934yiZKu/foprBz9GO0xKJsdRnTtdhBnqR5dJ+/jzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from MW5PR15MB5218.namprd15.prod.outlook.com (2603:10b6:303:19e::18)
 by MW3PR15MB3834.namprd15.prod.outlook.com (2603:10b6:303:4e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 10:23:37 +0000
Received: from MW5PR15MB5218.namprd15.prod.outlook.com
 ([fe80::e141:b605:48c7:bcf6]) by MW5PR15MB5218.namprd15.prod.outlook.com
 ([fe80::e141:b605:48c7:bcf6%3]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 10:23:37 +0000
From:   "Leonard, Niall" <Niall.Leonard@ncr.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] gpio: mmio: Use new flag BGPIOF_NO_INPUT
Thread-Topic: [PATCH 3/3] gpio: mmio: Use new flag BGPIOF_NO_INPUT
Thread-Index: AQHZMW99yymXJNAzW0ms2HrnxqMEi661kwkAgALGPwA=
Date:   Tue, 31 Jan 2023 10:23:37 +0000
Message-ID: <494ca890-098d-1ba8-321b-b6378546835d@ncr.com>
References: <20230126-gpio-mmio-fix-v1-0-8a20ce0e8275@ncr.com>
 <20230126-gpio-mmio-fix-v1-3-8a20ce0e8275@ncr.com>
 <3c5b6ae1-387f-143c-691f-92b96fe78270@linaro.org>
In-Reply-To: <3c5b6ae1-387f-143c-691f-92b96fe78270@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR15MB5218:EE_|MW3PR15MB3834:EE_
x-ms-office365-filtering-correlation-id: 8c2e36b7-4519-4df2-9579-08db03753710
x-from-ncr-tenant: Processed
x-pp-secret: m9yph.359rsj96jnp6w-uuxnb8thy.9r62ir35fve
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TXFItBleVNGQuQhkjRzwB6Uaj4DClP1WapwVsj2F8R7zHeVH1upPnQyJ4afs8zdzjbiyaIZ2yjBsd8lpZqLcN1x30/THDRMfLa1+JB8/Wh+FM+3fbniF/r7eaQCb8+mFNKVSHUcpxDhK7nkopdcVGYfVEDZZP5azmu2biyB1aq8bgr+0TPSS3KTd5Mti529cN9833cq7hBcxXS3PMlkpAgKrbIHOXpPVYp8gGvcDF/AJZbTQgdV6DlguRkXVmw4nBDS267+8BZ2H7w1LeZLjTd/R5K6VMX31P0uo32VxL3Stpz3dtT8TYEqnnv8fiD/s6Nl0lY0nGapndy3D4Ni4U72sEfK73d6BuY/taWxzVCZrmgOxFc8OkB4alZ4IVLzJv6169KjAGdR1BcOVqXF/49IH7ca9xd2Dak8O6sQYP87bjhHSiZzJs9pgBY1ujBDh5djU33f2owg+2zR7cjA7s05tRb1LJM5xaLTb25spP5DHZaAyrLNf6p94YID2XDvrq8Y5PCPsYa4E5qWGR+fEFzR4hUuEUS7WQt+WKDLVGDEf94izKHjE/sUiSqNFdZh1xdoMiOAy2WFH7/7nV3wrvcNHI1ZEDwNJbqLHGS+/NppU3O3LK8ihON1UnXvv9bXMEfeciGNEYob3IyjS2De0pv9QSrbu8BnhPA36CH/jKqfW6UmFF7Cjc5mCXzJNpMbwZTBNdhJRrCPK5xZt17SPcviekO9mavjP9L1BTlXvHK+xC1BoVuxFlbT1re6rMgYS0mtVL+bp8uKb/HTbGHhqww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR15MB5218.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199018)(31686004)(2906002)(5660300002)(38070700005)(86362001)(82960400001)(83380400001)(8936002)(31696002)(41300700001)(36756003)(478600001)(71200400001)(26005)(6512007)(186003)(6506007)(53546011)(6486002)(110136005)(54906003)(2616005)(4326008)(66476007)(66446008)(76116006)(8676002)(66946007)(66556008)(316002)(91956017)(38100700002)(64756008)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wnc1M0ZoQ2NMajNncnpsU010d0Y0U2hrY2NDTkwwcXNrdmFEa0Z4NHBkcStz?=
 =?utf-8?B?bTRmcVVYTTVpYm5wVXJWb3YzczNXd01CNEY0cVdJaHlQTHhRTURjQlNnZDhq?=
 =?utf-8?B?ak5WTjRhQ1NmTGphYVBnRU9NYWdZaVFTbEZBM0pWV3FwZVB2TjlEL0phcUZK?=
 =?utf-8?B?cFhFK2U4YzZuaCtiSnpWeWN2akFrd1VXUlhCbEJ2TmgwTDRZbzNXVDR6SnYy?=
 =?utf-8?B?SEQyNjhLTTVReGg2SlNkVytGV29zbW9sUVFydGtOaWQ4cU5GYU1UdndUS0dS?=
 =?utf-8?B?UVJnNHRVMktkY1JMZmplMjNZdUs5dWpLSkwzaElVUWhuRE9IeitzdU9LSVdo?=
 =?utf-8?B?TU04c2lyNGtDMkNTaWZjQVBHbldKSnQ0UjlJM2FBNmVkMW1aaG9RNjFwc2xH?=
 =?utf-8?B?L1hiMTJ6NE1ZKytmdSs3U1JRTzNZMlA1UkJ5clpRNkc3N1BVNWpCTUdmZk9H?=
 =?utf-8?B?ZVdkbHliZk1YSjhyYXlhVTJ6bVJHMU5LQ0FQRDNaL0dUU1VVNlVWTjhmNzdY?=
 =?utf-8?B?RkNyTVdvdGg2WnpSWE12RWtxdFFqRFhNRElOOTdtQ0xaS1VWRmJHRm52YVM3?=
 =?utf-8?B?a2JIWW5mTUtPVVFYRDF1dGlJc3Awa1dxaW1oeGVTR2FBTjFXYjNQM3Uwc3ZU?=
 =?utf-8?B?Zk5IRzlnOHBBbGlaVk04TW9WTkY1a0pZM0krY0hkTWxTc2dhRk84cVNTOFc1?=
 =?utf-8?B?WkRnV2V4N0pVRjNkbDFoRk1rNjJGMWtBZVJIWGdEbHlnMU9QL1NCT2FYcEZ0?=
 =?utf-8?B?K25HbEJ0YUtuemtINGVkWlR2WGx3Z05GWitLWUFHS01nYTZBZTNQUkpxRjhX?=
 =?utf-8?B?M09ub1Zsc1hVNnk2aXhDckJ2MWtrRVdnOWtQaGJ3OTlRUzNmdUNWTCtBQVZm?=
 =?utf-8?B?NDdyN0Z1ZmlmQzd2ZGFFL2s3K3hpQTZNdjg3NGdzdTRvZnRGQ2RpdTVmTjFs?=
 =?utf-8?B?L1RQUERRVjRaRlBKVEY2N25XQlU5MldyaDZCWXlPcURtWVdSVEJvUCt2RW9I?=
 =?utf-8?B?OGMvbXJ5OFl1MllCbFljRVZaSTJiNU1FWnVub2dxWFZ0ZUF6NDYzNXFJeGMx?=
 =?utf-8?B?NXpEdGhvUnRmeUhHOXNMRVFBK2NnbkpCTUhENW9lZnovK1dXdGVqTkx3cmI0?=
 =?utf-8?B?bGFNSGZUa0lQaGVVVGZTTnFqZFc0Qm84b0pNZjhKMFlmQ3ZKdnBXVzdBYjVT?=
 =?utf-8?B?d2JhQkFZT0dYTnhoWEFLaE5jQWR4ajdnVmhVYkU4RjFDNVdQNTFOSExSbU9o?=
 =?utf-8?B?ZVRnVDNZd1lTMVN3bXlLUWdkeHZyVXhWd0E5TkFPVTJBRGpVYVl5V3hFc3Uz?=
 =?utf-8?B?VWJ1M2xqVHJRWUhGdEtoaDNzNzM3UENpTmlnczFDTXcyQ0NxUTJFcmFlN25N?=
 =?utf-8?B?WFVLL0cyQ0o0YnhNSmRTaEZFZlorNEtkUm9jYzJlUUVoOXIxcE9wUXc4VWlN?=
 =?utf-8?B?dXkwRnNUL3A1VlJkZXMwamY3OVloZWR5Mm5YdmJtNmprZSt5WUV3M0dhbHdo?=
 =?utf-8?B?WlBSUk43dExLa0NpTVZVa1BMTjFjWnh1c2kwQ1IyY2JFMWlLWU5QdksvQm0x?=
 =?utf-8?B?QmwxRldSL0xsL2E5cGJpblBFMHgzN3dIN29Qc0htMWJrN2FGWTdGNzU5eU01?=
 =?utf-8?B?bDNwNTBtRGFnRFNaRC9jQnhSSy9idlRnOWhYK001akdSTVp3MVVBN256MHRD?=
 =?utf-8?B?RkUxekFIeDI2a1VHdURYM2pUdHlMQ2RLYW5TOFlNcUd2U2NUcHRyQTgxem5G?=
 =?utf-8?B?YU9Gdk1EbXZiVmxSTzZld0pCNDVlQmJSNjcyUEdTejFwM2VGdU90WHYyV0Zs?=
 =?utf-8?B?dXBqRHdoM2RkcmhaQThUa1lTN0RURWU1anprdlBpVjI3UWZkMzZqSGMzeHZn?=
 =?utf-8?B?TXE4Wk1wd2N5ZHI3WFZBTHgrYnRmLzVqQm90N0ZhSG1Wa09mdFJpb2xoT1ps?=
 =?utf-8?B?SXMxSjAwL3JhRjZMdmJLckt3dkROZjFBYndOOWx3NFIzTGVJRUdQREtDMGQx?=
 =?utf-8?B?bEVNczVLQnVQQ1k2M1lHT09yRGVteFl0MVQvc3hFS0twTU83OVV5NkQxQzZv?=
 =?utf-8?B?UGtxMExzQTRVZ3VMYzljcDVDK1JRRTFhTFU1UFFUK3liK3FIWk9RVndEVkE2?=
 =?utf-8?Q?Ap1M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F56C076FF2203A4FAA1A2F8B117725CD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xb/K1ZFXYV9Wk/K2GYt9HkhsV/+gROug7t7HI5+pn49i2wyXyMTtMkcfZ99fj5ls5vQCfyuTiak0BWoeEuA2dFM6RlJ4wCogXn2o7pQqix4Fsmg37jMfGiGOE3tIAhaM8vUWhHlF5UWPb0WR3CwUIuYoGiWp5snh6xW6rT1/spLyPn18f/GecIALGJcRLuwr8nMRuQBZO/UXbfAjAwHrwquPrwamPZpEbondY6GZIz5Pk3TrF1C3UJi6clC8bMHGTFiETiDz7aTxrwjZN2DITK3K+zxEmH7bTtnrHrEfddHG8wC0obeV2oa6yOwj4pZqj0HXvYw8eCyi2xHp5ii6X7AeMTC13aQBST2Ld+kxSTx64mkweqCcD5yqElbvGKViNRbGwPAJN2cPLLH2ObpOd/PW+ZCeLMcPKCucOWGcvVK+BZiZWogBvWGtTLQo/KUveAQWUqnzsH34VItS4T/5mJ8Y8qS/4ZrzLopP1x175anEGETkQIqaKe3808zU1Pm1VsvkuLbjVEUPsB9XXYImL5fAXC1dO4XMJe+b/DMb86Doi6e2yQ9x5Dd0LFG/5hibdn/N9IO2pwQPUnAUSOmPINdO7iW3RjTWbCV8lxgmqinHQuwm4CoUywRUHbYjafyp6vBngRTAAlCFh91VWmgBhK7yXT+Q3iMMAdEIPSQRcZHfkTOZpoC61QUS88QtJHIwZ6zYC33OFXJm6RCu8Za7woRxYunbR/1lmJSjKJ6HFnrvlTzSbnVNEuY9u6vlERA14AheLf/oWp+DZIb5WKqmH2aw3KBpQSQpGI04qnOtSWPmf80sdanYjUK7Qk1VRBHsYk5PGr2QD9KeU7c9HVCMiAkV6COwImuEhv1g+JkoCfA=
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR15MB5218.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2e36b7-4519-4df2-9579-08db03753710
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 10:23:37.2635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EkvlmwhOPr404Zws0TmmAvTM1hfKca/zriHauxT1080FlxZ3X/jGqD25ZW8EF2YMR7x+Avz1pmZv1026eKgCng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3834
X-Proofpoint-GUID: ho4G3AYcb0PRFECeEJxyF6u19_m8SlDr
X-Proofpoint-ORIG-GUID: ho4G3AYcb0PRFECeEJxyF6u19_m8SlDr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_04,2023-01-31_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkvMDEvMjAyMyAxNjowMSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gKkV4dGVy
bmFsIE1lc3NhZ2UqIC0gVXNlIGNhdXRpb24gYmVmb3JlIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNo
bWVudHMNCj4gDQo+IE9uIDI2LzAxLzIwMjMgMTE6MTcsIE5pYWxsIExlb25hcmQgdmlhIEI0IFN1
Ym1pc3Npb24gRW5kcG9pbnQgd3JvdGU6DQo+PiBGcm9tOiBOaWFsbCBMZW9uYXJkIDxubDI1MDA2
MEBuY3IuY29tPg0KPj4NCj4+IFVzZSB0aGUgZXhpc3Rpbmcgc2hhZG93IGRhdGEgcmVnaXN0ZXIg
J2JncGlvX2RhdGEnIHRvIGFsbG93DQo+PiB0aGUgbGFzdCB3cml0dGVuIHZhbHVlIHRvIGJlIHJl
dHVybmVkIGJ5IHRoZSByZWFkIG9wZXJhdGlvbg0KPj4gd2hlbiBCR1BJT0ZfTk9fSU5QVVQgZmxh
ZyBpcyBzZXQuDQo+Pg0KPiANCj4gKC4uLikNCj4gDQo+PiAgIAlpZiAoZ2MtPnNldCA9PSBiZ3Bp
b19zZXRfc2V0ICYmDQo+PiAgIAkJCSEoZmxhZ3MgJiBCR1BJT0ZfVU5SRUFEQUJMRV9SRUdfU0VU
KSkNCj4+ICAgCQlnYy0+YmdwaW9fZGF0YSA9IGdjLT5yZWFkX3JlZyhnYy0+cmVnX3NldCk7DQo+
PiBAQCAtNzExLDYgKzcyMyw5IEBAIHN0YXRpYyBzdHJ1Y3QgYmdwaW9fcGRhdGEgKmJncGlvX3Bh
cnNlX2R0KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+PiAgIAlpZiAob2ZfcHJvcGVy
dHlfcmVhZF9ib29sKHBkZXYtPmRldi5vZl9ub2RlLCAibm8tb3V0cHV0IikpDQo+PiAgIAkJKmZs
YWdzIHw9IEJHUElPRl9OT19PVVRQVVQ7DQo+PiAgIA0KPj4gKwlpZiAob2ZfcHJvcGVydHlfcmVh
ZF9ib29sKHBkZXYtPmRldi5vZl9ub2RlLCAibm8taW5wdXQiKSkNCj4gDQo+IEFzIHBvaW50ZWQs
IHRoaXMgYnJpbmdzIHVuZG9jdW1lbnRlZCBwcm9wZXJ0eSB0byB0d28gb3RoZXIgYmluZGluZ3Mu
DQo+IFRoaXMgbmVlZHMgdG8gYmUgZml4ZWQuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlz
enRvZg0KPiANClRoYW5rcyBmb3IgcmV2aWV3aW5nLg0KSSB3aWxsIHVwZGF0ZSB0aGUgb3RoZXIg
MiBiaW5kaW5ncyBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpSZWdhcmRzLA0KTmlhbGwgTGVvbmFy
ZA0K
