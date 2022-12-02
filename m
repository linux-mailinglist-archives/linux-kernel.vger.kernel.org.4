Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E93B640C8F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiLBRsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiLBRss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:48:48 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447F9BFCCA;
        Fri,  2 Dec 2022 09:48:47 -0800 (PST)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2HboUJ012242;
        Fri, 2 Dec 2022 17:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=vGMBMO8WsBx6Nhnm+xryyv8HK8oQF94V12dvFO40xbU=;
 b=nNHRAu1+/vvYjbhFWR4Qn8n4YUhdxPAEM6s8pZ/zNrpp1jVc+7QKUSnhZHwr/2LA+qyS
 caY4a408lqgObno8RjnAJwKj7i8bV22pzlMsHh1BKCd/odGeQUorWPkPtyKmHK3PQxae
 bmMnl3nWZi+bYHQG8MXND5BMy8cywEFU4bfO6vHk2m2ExI+Jji2Zu7i8jZfC8z2mJLCK
 a79882oEZ3t9roQY9d83ywfkOKtjmb3rNW/1t/376TrYA5cGOT1InQm+bCEQ+iwHV3H/
 KEUcydGBJkJXo4MTXLmSvpO2HHtPX/dNulZvN1JDQT/OarI3BVHwMSSsU8cHaYa8Ijdu sw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3m7nj4r8e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 17:48:42 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id E08818066F4;
        Fri,  2 Dec 2022 17:48:41 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 2 Dec 2022 05:48:41 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 2 Dec 2022 05:48:41 -1200
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 2 Dec 2022 17:48:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G22+baUe6VUkL/AhYtkU55Jrfr1cnqyKLd5A7vkS3ANX51U+L7GUuszqgpHsZunBPRLu3aVJbe0LQ8B5AAUUb8bblD3fqsBFVCWGC5Qytwn6e5xy7EbdBkVGIhTjWlDr8QBWDTz0m6EtMOzBGT7kuRg8QG3Ws2w9jOXk9uHGpbg/OWG+oSjrLVYAvyChPE1OuU5nFrA4MNeWlOoGZXy9fUEG5MMgyPYQEJRxJDSBUBXXl7fRXJAYoAKUwl5H8r+cWzdj4Ty2b/T4UmOjGrmIWChG3lgjTpxjxkMqr6ZYejXEhZWcM90SApk0BRPGd1cg06SS2/kn6tTukBgKikaZRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGMBMO8WsBx6Nhnm+xryyv8HK8oQF94V12dvFO40xbU=;
 b=lZobabkST6AcZKnvPSao05DztdZ5b3tRNyDoL4OEGbbCnlfzWc4TmFUz1zdO7eyD0nNKgH1XO8Wd2O/2X/VB6yeugyWm6YEWl8xFKvJnEACTXt4xnOg7vUMDBHnwnICKfyYXz4arUveJ3c5sdlYxxYskHMjVqO5s2QgDUI5cx3RXC1EIYtGWDHfL1BIGJytmX41Goe8S0cTSNBfXIQfclJwO9Yxee1nvkvLqleJsPbHBnv4oZg0rPfnnuN8/rOZnClmcTXxiXe9i29pbW7Ksl3368BvXQTn0UP0y3lgDJRsaHdzF6neckL4rXlcPMd/AtnbZIHuHkiJhSkVWxY6X6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:153::10)
 by PH0PR84MB1527.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 17:48:39 +0000
Received: from PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1a3c:36d1:e3f9:9cc1]) by PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1a3c:36d1:e3f9:9cc1%2]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 17:48:39 +0000
From:   "Ernst, Justin" <justin.ernst@hpe.com>
To:     "ye.xingchen@zte.com.cn" <ye.xingchen@zte.com.cn>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
CC:     "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: use sysfs_emit() to instead of scnprintf()
Thread-Topic: [PATCH] platform/x86: use sysfs_emit() to instead of scnprintf()
Thread-Index: AQHZBi1RZH674DyHxUGMNB/W/JeuWK5a3slg
Date:   Fri, 2 Dec 2022 17:48:38 +0000
Message-ID: <PH7PR84MB1813085F3E95CC084D5E605B87179@PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM>
References: <202212021705128095546@zte.com.cn>
In-Reply-To: <202212021705128095546@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR84MB1813:EE_|PH0PR84MB1527:EE_
x-ms-office365-filtering-correlation-id: e4345825-e15a-43b5-4268-08dad48d71bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LVsSIAbmEnt9pwCBNvU5EKMBPtU/zMwImr8Pe9B/jg4SlATjilRVkxgBbmwVtVEQG8zdu3CSJWJHBVHqJ+NrfRTOb8YBQ7/rZyjnzDeKcGuLYnNYGBz1Xzk2a4mx6HzP3JGGSrpBLBkiaunNqDi+TdkxIrdPCOMzDzFGkDqxh69Z/Z7ZO9tsypW0DhrZRu+aCiStcLeRbgc2R/2HPYKL0eXa3e8H7DSvvuhjAull6kC4L3hXv5w0A3eGWSFcCPXc9xAR+zjgAJMRorIPrc1jhzyKwKJU5H8VBNFY+diIgUvSJa8uePESa3fSpAYbyNR78IIJ07Q7zsc2/RQj2E2zR/Mh6Jepy2LHfzzFobKWGeS9U5Agx0BZg7WPDxVCHopG7w2X8Uxy9hoCWpA1J/+nFWNTRUeM1uvHaVZkW4TpD1PG4jCV+t5RaFkm/MxUV77yuWQ8nR38NHrqd0mUlMjjzMJF/BOS7BmK7KEwdt7Hz74Q32mNLRd554czfUrvwIckpJnw94d2jZvWUNVxlVGoY7eUsUzn6S0kMULdtxgY5tLpG0LHm8klohR/WlDD67hqah4UjNg+qX9gzeERkl1TXfy0XHdcUHMX8cdsNzxceeJfD50a2OZ7lnKa1aRlafGeRwczTknXX8kdZm5Ya+FTyNl3GZYxHaKayOkQBFBBwe0UYp1BF+zbexT1YzzkL/cLvygH8SjaqzM8uyBrkRBxSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199015)(83380400001)(6506007)(7696005)(2906002)(38070700005)(71200400001)(316002)(66556008)(8676002)(66446008)(33656002)(66476007)(55016003)(64756008)(4326008)(66946007)(76116006)(52536014)(8936002)(110136005)(5660300002)(41300700001)(9686003)(54906003)(86362001)(186003)(26005)(478600001)(122000001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjZnSXYzWHRTVUtuRGdNanBMMGsyU1V2NlJDWGFJV1FNTkVpR2JiZ2xoZzd0?=
 =?utf-8?B?ajkzUitoZTJGS0JVd1VVRGkyRzdzdDRDQldyRGJRUU1mZW9iZGFlU29WcTl1?=
 =?utf-8?B?UjFhU3kzUnFNVlJJa2RQK0E3eFBXa1BCTmZ1dG9KN056OGJ5RUNsOWxZV3Ar?=
 =?utf-8?B?WUQ2a0ppbFd5cU56KzlFUVBFMmpsaXhBbjgzOHphK2ljVDNUUWJlMFVZS0Ra?=
 =?utf-8?B?MEVDR1QrWW0xR1I5NnZCdUpXOGFDeFFYMTMvamkxODR1Qk9WNVdjYVlqUVpS?=
 =?utf-8?B?cTlyQnBMQnp2OU1lalZKUE9vTnlOT29lT0tBUS9saDJqNmNETW5DQTFPVklB?=
 =?utf-8?B?aUExN3ZoWkp6cExlWjdjRGpsUUN5akl2cldKU2kvSmduK2dFNVdDTmZkYWNQ?=
 =?utf-8?B?L3p5NThlRWNhRXlHQVZyNVl4bjlxRkY3YWJHcjdTYUJqdjFveGRyZy92dVpp?=
 =?utf-8?B?Q29EZVJjZ1lOWUpnekVqdEYyL1ZyaExOWUFiWDFwWlZ0K2N0V1VWSmxadnlN?=
 =?utf-8?B?MURjZVljTlNvZVdhM1hCWk4vRTVLZzUxYmVJOG5OcXFWQU9Yb2pPeFFlZ29l?=
 =?utf-8?B?TGplaUxnMmwvZ0Y0VmxhbzlISThKSFJ1WldEYXZOK3hoQ0RYVHI3NGFVWWR3?=
 =?utf-8?B?empKVG5xZVBydFVOWGs0OGU1aWJDNVVubEU2YitMMWo4U0RjNytVNmI0M0ls?=
 =?utf-8?B?d25mdGhNN24raUVhYit5Y2taMmVJemxRcEJqS0VkUElVemVWME1HUUZvbUFS?=
 =?utf-8?B?YnVOYlV0NjZjbUMwZGdtOWNOZFRVM0g3clN3WXFyWDdRdzBPaDV2TGRlYzEz?=
 =?utf-8?B?SGlnMlFiK09Gb2hUZTNTMjhFRW9IR0c1UVZjUmJ2bmVERVIxTDV1OTRiemQ3?=
 =?utf-8?B?Mlp1M1hMaWJnbnBOVTQyekR6LzBobDFoR0lId0hTQnBkcVNRNDdXdC9OWXEz?=
 =?utf-8?B?MDZEdzNXVzdJN1dMY0Y4dVNlT05DR0NQSTlnVGN0cVMyVGFGTm9uS2VTUm5y?=
 =?utf-8?B?WEY1SFprdzFDejl4RHFPRGEyZ1Z0eis0ZzhaTFpvZWJseld4TUwzYXRJVDly?=
 =?utf-8?B?OEM3MEdlOVY3VVRyQXkwVFJzUEpPNTRhTGtvcGtIcTFDbzdRYWJyNUZwaXlq?=
 =?utf-8?B?ZmFlRlphbndTdzlmRTNsNzFZZ1Q5akRGV2ZKT012dlZZUVZZcmg5MFJFRTU1?=
 =?utf-8?B?Mk1ScWhTbjdxVnJHRThjTlV4YnJJb1ZOY25TZFliWGhESUkvRWNZamdDNVpR?=
 =?utf-8?B?a2xwWTZKelloWmRYTm11NVMrampjc3lZS25BckpsU2xtRERoZlM1YWxzRFRF?=
 =?utf-8?B?NDhMeERZMk4rTjgrQ2NxeVRWUEhSbmdtOW53MUlwbzFmd1kyY0FKZHVrMkFD?=
 =?utf-8?B?UzBJZXNUZ1NrVWYxSnBmcFJwYnNRQzNOVHVxM09HSWoyTXY0T053VHdyNmln?=
 =?utf-8?B?clRQRXltSWZOV0h6STBUQUNiMEhTWE5ZQkUvS3RYRWd3dFR5TXRyTnlPaEND?=
 =?utf-8?B?cFkxRTR0UjYwRlhuMXQyTnY3Wk81ditjWnc4SFNGd2diVDdRaTRhNVdBRmJO?=
 =?utf-8?B?M3VzeS9ORk13TkNOOXpMUTJucFdiUk1PbGJIK3ZORi81V2U5NWtJNjNBOStG?=
 =?utf-8?B?WFpReStJZjlIaWZXTHRTZEI0TUtjQ2RULzdpRUhkMGJUdjFmTmM5cGxydzUz?=
 =?utf-8?B?WXNCNHlBL3pycytpd2N1bFRJci83MWJLTDNSM2twcXRiRUlzZGd0V1ZNRU1X?=
 =?utf-8?B?UWQ5T1hWWWliM3BJbE9rMHRmb3RJZytPcWw3bkl4V2p6dndRSnNuc3pkLzFs?=
 =?utf-8?B?MlUwOGE2ZytRVlpTSmRDdGlRcFd1YlFFeTJxM3Vabi9EMGF1NzBiTGR1YVd2?=
 =?utf-8?B?NGJod2M2SkRZRWpGR1ZLbU9NU0k0WEdzNDdBQWprNlJ4VnFpRitBUXdUVmJq?=
 =?utf-8?B?T3ZCckJwNnQ4Z3ZPbU1UMEJ0TkVkajNmaTZvUkxCamp0R1pINnE0dUNVcUR5?=
 =?utf-8?B?YW9aTnB0eW9pbmtPMUczcmsyOXJ4dEF0R0NHR3AvZ3RrdEtuQm5acGNiTnFX?=
 =?utf-8?B?Yk5uSFUybXJieFdha2VrNG10bEo1WWlFNzJVdnJPSVY3YjZlN0JtZWdXQ2lU?=
 =?utf-8?Q?yMIKy9EoSd72Njok36XvUfd4G?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e4345825-e15a-43b5-4268-08dad48d71bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 17:48:38.9362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVN9LCXBIOjvOwDQ5/Rqq3z9uikcbnFTyUrjo2nbeHEcfpA5z01Eea/BG1qCJgQtcX0eXWVyFVUuHYSfMzb2mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1527
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: js2ug17DOWf6y-Z_Bnm3Ha_i1p0c5oXg
X-Proofpoint-GUID: js2ug17DOWf6y-Z_Bnm3Ha_i1p0c5oXg
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_10,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 clxscore=1011 mlxlogscore=881 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212020141
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGb2xsb3cgdGhlIGFkdmljZSBvZiB0aGUgRG9jdW1lbnRhdGlvbi9maWxlc3lzdGVtcy9zeXNm
cy5yc3QgYW5kIHNob3coKQ0KPiBzaG91bGQgb25seSB1c2Ugc3lzZnNfZW1pdCgpIG9yIHN5c2Zz
X2VtaXRfYXQoKSB3aGVuIGZvcm1hdHRpbmcgdGhlDQo+IHZhbHVlIHRvIGJlIHJldHVybmVkIHRv
IHVzZXIgc3BhY2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiB5ZSB4aW5nY2hlbiA8eWUueGluZ2No
ZW5AenRlLmNvbS5jbj4NCg0KVGhhbmsgeW91IGZvciB0aGUgcGF0Y2ggYW5kIGZvciBrZWVwaW5n
IG1lIGluZm9ybWVkLg0KDQpSZXZpZXdlZC1ieTogSnVzdGluIEVybnN0IDxqdXN0aW4uZXJuc3RA
aHBlLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvcGxhdGZvcm0veDg2L3V2X3N5c2ZzLmMgfCAx
NiArKysrKysrKy0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA4
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L3V2
X3N5c2ZzLmMgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni91dl9zeXNmcy5jDQo+IGluZGV4IDYyNWIw
Yjc5ZDE4NS4uNzNmYzM4ZWU3NDMwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4
Ni91dl9zeXNmcy5jDQo+ICsrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L3V2X3N5c2ZzLmMNCj4g
QEAgLTExOSwxMiArMTE5LDEyIEBAIHN0cnVjdCB1dl9odWIgew0KPiANCj4gIHN0YXRpYyBzc2l6
ZV90IGh1Yl9uYW1lX3Nob3coc3RydWN0IHV2X2Jpb3NfaHViX2luZm8gKmh1Yl9pbmZvLCBjaGFy
ICpidWYpDQo+ICB7DQo+IC0JcmV0dXJuIHNjbnByaW50ZihidWYsIFBBR0VfU0laRSwgIiVzXG4i
LCBodWJfaW5mby0+bmFtZSk7DQo+ICsJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJXNcbiIsIGh1
Yl9pbmZvLT5uYW1lKTsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgc3NpemVfdCBodWJfbG9jYXRpb25f
c2hvdyhzdHJ1Y3QgdXZfYmlvc19odWJfaW5mbyAqaHViX2luZm8sIGNoYXIgKmJ1ZikNCj4gIHsN
Cj4gLQlyZXR1cm4gc2NucHJpbnRmKGJ1ZiwgUEFHRV9TSVpFLCAiJXNcbiIsIGh1Yl9pbmZvLT5s
b2NhdGlvbik7DQo+ICsJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJXNcbiIsIGh1Yl9pbmZvLT5s
b2NhdGlvbik7DQo+ICB9DQo+IA0KPiAgc3RhdGljIHNzaXplX3QgaHViX3BhcnRpdGlvbl9zaG93
KHN0cnVjdCB1dl9iaW9zX2h1Yl9pbmZvICpodWJfaW5mbywgY2hhciAqYnVmKQ0KPiBAQCAtNDYw
LDEyICs0NjAsMTIgQEAgc3RydWN0IHV2X3BjaV90b3Bfb2JqIHsNCj4gDQo+ICBzdGF0aWMgc3Np
emVfdCB1dl9wY2lfdHlwZV9zaG93KHN0cnVjdCB1dl9wY2lfdG9wX29iaiAqdG9wX29iaiwgY2hh
ciAqYnVmKQ0KPiAgew0KPiAtCXJldHVybiBzY25wcmludGYoYnVmLCBQQUdFX1NJWkUsICIlc1xu
IiwgdG9wX29iai0+dHlwZSk7DQo+ICsJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJXNcbiIsIHRv
cF9vYmotPnR5cGUpOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyBzc2l6ZV90IHV2X3BjaV9sb2NhdGlv
bl9zaG93KHN0cnVjdCB1dl9wY2lfdG9wX29iaiAqdG9wX29iaiwgY2hhciAqYnVmKQ0KPiAgew0K
PiAtCXJldHVybiBzY25wcmludGYoYnVmLCBQQUdFX1NJWkUsICIlc1xuIiwgdG9wX29iai0+bG9j
YXRpb24pOw0KPiArCXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVzXG4iLCB0b3Bfb2JqLT5sb2Nh
dGlvbik7DQo+ICB9DQo+IA0KPiAgc3RhdGljIHNzaXplX3QgdXZfcGNpX2lpb19zdGFja19zaG93
KHN0cnVjdCB1dl9wY2lfdG9wX29iaiAqdG9wX29iaiwgY2hhciAqYnVmKQ0KPiBAQCAtNDc1LDcg
KzQ3NSw3IEBAIHN0YXRpYyBzc2l6ZV90IHV2X3BjaV9paW9fc3RhY2tfc2hvdyhzdHJ1Y3QgdXZf
cGNpX3RvcF9vYmogKnRvcF9vYmosIGNoYXIgKmJ1ZikNCj4gDQo+ICBzdGF0aWMgc3NpemVfdCB1
dl9wY2lfcHBiX2FkZHJfc2hvdyhzdHJ1Y3QgdXZfcGNpX3RvcF9vYmogKnRvcF9vYmosIGNoYXIg
KmJ1ZikNCj4gIHsNCj4gLQlyZXR1cm4gc2NucHJpbnRmKGJ1ZiwgUEFHRV9TSVpFLCAiJXNcbiIs
IHRvcF9vYmotPnBwYl9hZGRyKTsNCj4gKwlyZXR1cm4gc3lzZnNfZW1pdChidWYsICIlc1xuIiwg
dG9wX29iai0+cHBiX2FkZHIpOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyBzc2l6ZV90IHV2X3BjaV9z
bG90X3Nob3coc3RydWN0IHV2X3BjaV90b3Bfb2JqICp0b3Bfb2JqLCBjaGFyICpidWYpDQo+IEBA
IC03MzcsNyArNzM3LDcgQEAgc3RhdGljIHNzaXplX3QgY29oZXJlbmNlX2lkX3Nob3coc3RydWN0
IGtvYmplY3QgKmtvYmosDQo+ICBzdGF0aWMgc3NpemVfdCB1dl90eXBlX3Nob3coc3RydWN0IGtv
YmplY3QgKmtvYmosDQo+ICAJCQlzdHJ1Y3Qga29ial9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1
ZikNCj4gIHsNCj4gLQlyZXR1cm4gc2NucHJpbnRmKGJ1ZiwgUEFHRV9TSVpFLCAiJXNcbiIsIHV2
X3R5cGVfc3RyaW5nKCkpOw0KPiArCXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVzXG4iLCB1dl90
eXBlX3N0cmluZygpKTsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgc3NpemVfdCB1dl9hcmNodHlwZV9z
aG93KHN0cnVjdCBrb2JqZWN0ICprb2JqLA0KPiBAQCAtNzQ5LDEzICs3NDksMTMgQEAgc3RhdGlj
IHNzaXplX3QgdXZfYXJjaHR5cGVfc2hvdyhzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4gIHN0YXRp
YyBzc2l6ZV90IHV2X2h1Yl90eXBlX3Nob3coc3RydWN0IGtvYmplY3QgKmtvYmosDQo+ICAJCQlz
dHJ1Y3Qga29ial9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikNCj4gIHsNCj4gLQlyZXR1cm4g
c2NucHJpbnRmKGJ1ZiwgUEFHRV9TSVpFLCAiMHgleFxuIiwgdXZfaHViX3R5cGUoKSk7DQo+ICsJ
cmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiMHgleFxuIiwgdXZfaHViX3R5cGUoKSk7DQo+ICB9DQo+
IA0KPiAgc3RhdGljIHNzaXplX3QgdXZfaHVibGVzc19zaG93KHN0cnVjdCBrb2JqZWN0ICprb2Jq
LA0KPiAgCQkJc3RydWN0IGtvYmpfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpDQo+ICB7DQo+
IC0JcmV0dXJuIHNjbnByaW50ZihidWYsIFBBR0VfU0laRSwgIjB4JXhcbiIsIHV2X2dldF9odWJs
ZXNzX3N5c3RlbSgpKTsNCj4gKwlyZXR1cm4gc3lzZnNfZW1pdChidWYsICIweCV4XG4iLCB1dl9n
ZXRfaHVibGVzc19zeXN0ZW0oKSk7DQo+ICB9DQo+IA0KPiAgc3RhdGljIHN0cnVjdCBrb2JqX2F0
dHJpYnV0ZSBwYXJ0aXRpb25faWRfYXR0ciA9DQo+IC0tDQo+IDIuMjUuMQ0K
