Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFF3726578
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241484AbjFGQIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbjFGQIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:08:01 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA92F199D;
        Wed,  7 Jun 2023 09:07:56 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357BoB4H031239;
        Wed, 7 Jun 2023 16:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=ssqXep2eWDkJdvomPsqsdsCTbWGAvQdhm942BnBEJ0Y=;
 b=MV4f/62AcLCwjRUdaq+u+9rKazV1S/XRkUV75ZdIsdCjKa9E8+Vc+3FzHxnJeRtyppIQ
 F3DoufO3lUBYSmyIzLjyvyNXTK+2/sS79y8KR11ASWLwNWsR+aBt8eK+1JqpgMI00Es3
 FxW2F77q6eWwYLVQ7KiiE3ze1jxA39khHFTul1Vo6VGsZzHjT6dIPRGSew28FUoZk63k
 nTTHlb2IDGZ/K7eDs+Je9IPT5+Pnkn0e+9Ft1fjzFDgAbI+rlnK0Iuzxo5brxIYnrXFc
 BOUoZBAMvj7xg1GI4eTOsbyQKWQ0XzvHbuwLdCl1h48E4iHmJEAkyNeqlPMWT/tlaRsa MQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3r2k0gnpbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 16:07:35 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 320EB80022D;
        Wed,  7 Jun 2023 16:07:34 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 04:07:34 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 04:07:33 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 7 Jun 2023 04:07:33 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 04:07:33 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlmRKRDaQMI7J6nAsZQ1gpXsRLYXcJwXHyA7ePlmT5C33jAFFGrEYwOfi4/8ukF3wUC8wABWIDZzLZE/t4IYhvzbkxd+2N1AJDmAxDXlYVSl9grN6U7ZlUYGsUxu2sznM0LmpScmcAvOnfjfQUkj6J42jKJVYl6UtN33L42YY7+o+xBS77JbUEioGuqVQu34Vv8poK2+z+4yrz5vfA0tnXEUK7UhG8j6deXebKvsPNWEZ+p8cctC+0g9cSGalwrVJkz0OYY756uuvg1xqhe+aMUp1CEQfPuKfoG+rDAHugiQbfT7dWe3s1kHV8oHQvhTaLVQ5ohXsdmQlNyLvYSH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssqXep2eWDkJdvomPsqsdsCTbWGAvQdhm942BnBEJ0Y=;
 b=AJD7/H5pnh+h77q/ocSGbrSQp18HRZe+AyQ548oLRlHdkeVmd53FcBwieXSBhOLYNbidcwHmqh46QJoSTo2GZS3Hld8SP9SGf0CJ4QkvAMrT20W23H2FJjhLZkbLs81yjJsCm5En5Q7xBSZT/1rz2SApsbEwv8fjPc2rgDcOomom4JuI6XdQ8H7Qqr+tex3HCPi4RSYbWqZnbZubUKLZUsbOG+W3IVQID4LhKx+UALrsdQUKKMG3Nm36ia9LG4mBckQceXzijG5wDW3WdHYC8ZcCY3BLh4bThYaHYGDJJK1zMPBKeF0KKYvLDWGAx9qkyUq1bZXkMFybh6DWOjHaOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 SJ0PR84MB1578.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 7 Jun
 2023 16:07:31 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682%6]) with mapi id 15.20.6455.037; Wed, 7 Jun 2023
 16:07:31 +0000
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
Subject: Re: [PATCH v3 2/5] gpio: gxp: Add HPE GXP GPIO
Thread-Topic: [PATCH v3 2/5] gpio: gxp: Add HPE GXP GPIO
Thread-Index: AQHZmBjF4JEt/zYBEESMQ0szz/IlCK99gJKAgABZOsCAAG30gIAA6I8A
Date:   Wed, 7 Jun 2023 16:07:31 +0000
Message-ID: <81CFCEE8-5276-475A-A2AB-A814DEDA04B2@hpe.com>
References: <20230606014234.29491-1-nick.hawkins@hpe.com>
 <20230606014234.29491-3-nick.hawkins@hpe.com> <ZH76x6E9cbfrJHeu@surfacebook>
 <DM4PR84MB19278E9DD0BF34C570F714708852A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <CAHp75Vcc9hh6MYPSCJa1vniU=rC4Y+j9pCS4Np-b-Pyh5eUwNg@mail.gmail.com>
In-Reply-To: <CAHp75Vcc9hh6MYPSCJa1vniU=rC4Y+j9pCS4Np-b-Pyh5eUwNg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.73.23052700
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|SJ0PR84MB1578:EE_
x-ms-office365-filtering-correlation-id: e6a6ca15-319f-4992-8ca5-08db67714c73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wNQccykz9NbP0W01wFMkIdjqDOyr2aaM6FpB+e90/fZWUBw7GTfuI6Aw5wtZS5TgEFPIBRsy2+QY8DSi/ipsCbBtgy9bHjKuEbQpfLRWyR9Rncb5U9L7Apu+bjukT7vJaiLti0icZYounMjtOX+nqSHrd1Ggv0903QhVxIBzcKDAV+S8Wbcy6jZuLm3qoh6vjdUP9jXN5l2DtuCEaCHAmkD4d7Y7WMKdDlSG2ciwJx4+gre2WTzJotzbszA19XppHoxnZvgW9FiXxHpRyHniaccur8xpurt9sWp7NtkqVmGOA+YiqJJCMWEuQ8tL8x76i6hc7D3zJpYNTLZH/cgIY1mRQUmjks27iKGBBKgUeElmSP+crdIZ7eOSifsOG1OjLaglxEkezcVzYs38wc+TdMCGLgqD0TUIiAROo2PTr7DZnJr7q1UvuS4ysv0JHlYle6uBt3nZEqOJnvoXNHUj3sToqDlTPipuZOiXRTZMk+qgQfNMXiOhVOLOEwE4YDtAeqJmfquhnqcI7qea8zI5rOG2P/tNCSNucBB1oDZxAtz0bE80SuD0y6esjUwayCSTlw3WqNVycAwpdX1DA2PwDvfUOc1UbLVMrrFLqWIqgxHtBSYxrRYl6XrTIxJXtjJe/6EKa3Op0xiG3MpeBNsQ1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(36756003)(33656002)(41300700001)(186003)(6512007)(6506007)(5660300002)(83380400001)(2616005)(8676002)(8936002)(54906003)(478600001)(76116006)(91956017)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(316002)(71200400001)(966005)(6486002)(122000001)(82960400001)(38100700002)(2906002)(38070700005)(86362001)(6916009)(7416002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzBLano1cHpGTWlMZ2kxMDlPN3F2aVFXdEx5QmhKMWYwaXB0TGhmRVphRkEz?=
 =?utf-8?B?cUlPUHY5TENaMHhhRlh1ZWEyNEZSYjRsVkgwd3lQdnlEVzFIVlJNVVRmWlhj?=
 =?utf-8?B?V0dFOUEreU1sZXVoQm9jNkRGV3hVdVY1VTY4WkpLL1ZQSnFCci9nUjlBUGU1?=
 =?utf-8?B?MVRnWENBT3dvczBrNmlSVXB5anZPOHg2WEVxcmNEdkdKRnpNYTFHOUpXVWRP?=
 =?utf-8?B?RUxYdVNCRFM0cUtOZmdMSnFUaEpqaHA2UE9YN01rVlRWWnh4c1JQeERPUEhi?=
 =?utf-8?B?cG1HV3o2UjFpaktRRUZGb2lpc21wbXgzdHdleE5ycE83Y0crVFhLY0tyTk1n?=
 =?utf-8?B?Y0YvMUVCa2g3ZFJIZU9DTHRocXNVRytLYXZpdGdtK2JnUWVlMGhUWDZoTEVq?=
 =?utf-8?B?MUt1UVBuVFpMZjgrd2N1TzRiZGNFNHNsdlVuTk1RTU9KNnJaaXZaenppWlMw?=
 =?utf-8?B?cE1XSmxMdXBlUTdsSFB5ZkllSEREQW50TzhjVE5USk5OTHErODNCQzlJVjA3?=
 =?utf-8?B?M0xHQXlTcUZqN1lNdFJXZGQzbUVEakJnRDVFTFl2eksrQ1FPajB0QlJzay9E?=
 =?utf-8?B?S0FjU1hmRVk1aGZ2L0pIeXc1ZDhyZWwyN2hHUTNDMW5tL0kyNU9YcDRLaFdZ?=
 =?utf-8?B?VXp3WDdGSFFIVVhsNkU2bGMwRHFiS3pOUVpmN20rdWI2MTNqMEl3YjMrb1di?=
 =?utf-8?B?K1NnQ2hpNXBSQUw5ZHR3UzZVQ0daaWdXU3JkRFU3RVVPc25aYmZKUDNIalN4?=
 =?utf-8?B?aHhuN3BIdE9TN1RLNHpOZ1ZTNVFBOFUwS2t2eXhwemNyZERZSTJZWTdrVDUy?=
 =?utf-8?B?RkJrVXBPL2tHN3B0ZkpUOCtFWExwT3lTQXc2TlFMOERKNjRHY3Nqa2JNQjZu?=
 =?utf-8?B?R2xmeFB1S2hrTE40K1FUWXNNRklvVHIyQkdPd3lQVGphcjZTd3ArRU5xTWNK?=
 =?utf-8?B?SDk0a0VCMG8xemF0bmQwd2ZIUnNWVUU4UGZqd2d4anJVSnpnZTc4Y0FLMU0x?=
 =?utf-8?B?WGg4WU10czNqSTJQb3Z1ZnMyMDVBaEZuNi8xd2hGV2V6dTREenZtWHR4Q1hP?=
 =?utf-8?B?MVZPVzF2dFQyeEp6RUplb0J1RnRlTFJhQlJNR1dDWHlZdE1YVThKaEd2QkZV?=
 =?utf-8?B?dVRXU3dEVFE2VS9SbE5BR3NRUEU4WjBScVdZRVpCS0xGWU5jb2xrTzdnbDBp?=
 =?utf-8?B?cm1VU2lUdzVwS3F6L0QrdkZ0WG9iWW5iMFdGdlI2b216c2JuZ2ljakp5VjlS?=
 =?utf-8?B?WGVRWlZ3RlBSV3lvRmFLZXA0MG5WMmJnL1dKL3c0a1NIODVVMVhBcmhWaFZq?=
 =?utf-8?B?NlhrbDVUakFnU2JDOE93a2hhZEJGRmR5LzV0NmgzanErRldxb2lhZ1QwL0hG?=
 =?utf-8?B?TWQzUlRXY0NtUG5oZ3pYdzZjbkhVY0Nub0NxNCszWDJVNkgxTjQ5TEQ4MmZ1?=
 =?utf-8?B?WHJ5enBsb084VmpEMlBuVW5yLzFLQzNkUmpJMno0d1ZKNzFHR3RGazBIQm5s?=
 =?utf-8?B?U2loRDBTU0xBVlRESmxaMkkwcWNUQTdOTDhtZGZ4WjM2TTRoMmNZdFFQTFFj?=
 =?utf-8?B?eUJzQW01U1ZZWjgwM0gxZmF3VXAwT092Y2ZzbU9rOE9uUkVmVmk3VUNPRlVH?=
 =?utf-8?B?Yi8zUHFVNis1VEw4SFQ5R2ZCNjA2VWFSVWtpK2tBeGFEcWQ3RTR2RVNzUnpp?=
 =?utf-8?B?RmNWZTc0YVZiNWo0c0VGeUIrN3dudGt2bllEUXFvTE1LaEJlRGQ4cXI5UU1i?=
 =?utf-8?B?V2FYNlJvemNmbGRJS0xyMmlqR2p2UCtMeFR4MXphZ29lTC9WeThMbkJTbzhI?=
 =?utf-8?B?Vjd2cU1QVUljN3hWVlNsa0hTVSsxaDZ2elQ2c2lJaU9hZ1BwdHFIT2UyMHRT?=
 =?utf-8?B?ZlBKNElUVTJkQ3EzNXN2bXpGTXdCVlphZGQxd3BqcHEzUkQ0RzJKRytPaFRZ?=
 =?utf-8?B?RERrWXlpckNWM2xlNjgrUkZqMGFUWkwrUnRLbVg2aklaTUhGVE5RdHpraHlS?=
 =?utf-8?B?QTZCNmhxYlExd2Rid2ZjVHA2eExNMVl5a1JnNU9aZXlJOVdwOG5pa2JydjJS?=
 =?utf-8?B?Nmc5ZEMveHJhcGtXYmNCMDQrNTE3dnFXOGh4a2NUM0tqVllOaDhPNGhJQjNM?=
 =?utf-8?B?Q2Z6OXQrRjg2NmdIL3JuOXc2NG9lalRFODQwa3ZMWE41aDUvQXIxRTFKd3RS?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C057D02CC68A6459AAC5A6C6521084B@NAMPRD84.PROD.OUTLOOK.COM>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a6ca15-319f-4992-8ca5-08db67714c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 16:07:31.4476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gkV3XY0xLH4BkFq4tPIBI/caROsS+sb39Iyf+eKtOeQIZK2Qlm2GgGYhHZWerleaDwUevTpmMcyhTY0OmZ1TTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1578
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: WppCYM1N6j3KMuwr-La7XWLhuP4FJ8OI
X-Proofpoint-GUID: WppCYM1N6j3KMuwr-La7XWLhuP4FJ8OI
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070137
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

PiA+ID4gV2h5IGFyZSB5b3Ugbm90IHVzaW5nIGdwaW8tcmVnbWFwPw0KPiA+DQo+ID4gSXMgdGhl
cmUgYXJlIGdvb2QgZXhhbXBsZSBvciBwcmV2aW91cyBjb21taXQgeW91IHdvdWxkIHJlY29tbWVu
ZA0KPiA+IGxvb2tpbmcgYXQgdGhhdCBzaG93cyBob3cgdG8gY29udmVydCBmcm9tIHJlZ21hcCB0
byBncGlvLXJlZ21hcD8NCj4gPiBMYXRlciBpbiB0aGUgY29kZSBJIGFtIHVzaW5nIHJlZ21hcF9y
ZWFkIGFuZCByZWdtYXBfdXBkYXRlX2JpdHMNCj4gPiB3aXRoIGxhcmdlIGRpZmZlcmVuY2VzIGlu
IG9mZnNldCByZWdpc3RlcnMsIGFuZCBub3Qgc28gbXVjaCBhDQo+ID4gY29udGlndW91cyBibG9j
ay4NCg0KDQo+IEkgZG9uJ3Qga25vdyBob3cgZ29vZCB0aGVzZSBhcmUsIGJ1dCB0aGF0J3Mgd2hh
dCB3ZSBoYXZlIGN1cnJlbnRseSBhcw0KPiBtb3N0IHByb21pbmVudCB1c2Ugb2YgZ3Bpby1yZWdt
YXANCg0KDQo+IDEpIChvbmdvaW5nKSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1ncGlv
LzIwMjMwNjA2MDkyMTA3Ljc2NDYyMS02LWppYXdlbnd1QHRydXN0bmV0aWMuY29tIDxtYWlsdG86
MjAyMzA2MDYwOTIxMDcuNzY0NjIxLTYtamlhd2Vud3VAdHJ1c3RuZXRpYy5jb20+Lw0KPiAyKSAo
aW4gdGhlIHJlcG8pDQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjQtcmM0
L3NvdXJjZS9kcml2ZXJzL2dwaW8vZ3Bpby1pODI1NS5jIDxodHRwczovL2VsaXhpci5ib290bGlu
LmNvbS9saW51eC92Ni40LXJjNC9zb3VyY2UvZHJpdmVycy9ncGlvL2dwaW8taTgyNTUuYz4NCj4g
MykgKGluIHRoZSByZXBvKQ0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni40
LXJjNC9zb3VyY2UvZHJpdmVycy9ncGlvL2dwaW8tMTA0LWlkaS00OC5jIDxodHRwczovL2VsaXhp
ci5ib290bGluLmNvbS9saW51eC92Ni40LXJjNC9zb3VyY2UvZHJpdmVycy9ncGlvL2dwaW8tMTA0
LWlkaS00OC5jPg0KDQoNCj4gMikgJiAzKSB3ZXJlIGNvbnZlcnRlZCwgc28geW91IG1heSBzZWUg
YnkgZXhlY3V0aW5nIHJlc3BlY3RpdmUgYGdpdA0KPiBsb2cgLXAgLS0gZHJpdmVycy9ncGlvLy4u
LmAuDQoNCkdyZWV0aW5ncyBBbmR5LA0KDQpUaGFuayB5b3UgZm9yIHRob3NlIGxpbmtzLCBJIGhh
dmUgb2JzZXJ2ZWQgdGhlIGdwaW9fcmVnbWFwIGNvZGUNCnRoZXkgaGF2ZSBpbXBsZW1lbnRlZCBp
biB0aGF0IGNhc2UuIEl0IGFwcGVhcnMgdGhhdCB0aGUgcmVnbWFwDQpjb2RlIGlzIG9wZW5pbmcg
dGhlIGVudGlyZSByYW5nZSBvZiBtZW1vcnkgdG8gYmUgcmVhZC4gRm9yIG15DQpwYXJ0aWN1bGFy
IHB1cnBvc2UgSSBhbSBub3Qgd2FudGluZyB0byBleHBvc2UgYWxsIHRoZSAwLTB4ZmYgYnl0ZQ0K
cmFuZ2Ugb2YgdGhlIEdQSU9zLiBJbiBteSBjYXNlIGlzIGl0IHN0aWxsIG5lY2Vzc2FyeSB0byB1
c2UgdGhlDQpncGlvX3JlZ21hcCBjb2RlPw0KDQpJZiBncGlvX3JlZ21hcCBpcyByZXF1aXJlZCwg
aG93IGRvIEkgY3JlYXRlIGEgZGlyZWN0IGNvcnJlbGF0aW9uDQpiZXR3ZWVuIGEgc3BlY2lmaWMg
Z3Bpby1saW5lIGFuZCBhIHJlZ2lzdGVyIG9mZnNldD8gRm9yIGV4YW1wbGUsIGluDQpncGlvLWd4
cC1wbC5jLiBHcGlvLWxpbmUgYXQgb2Zmc2V0IDAgKElPUExFRCkgaXMgYXQgcmVnaXN0ZXIgMHgw
NC4gVGhlDQpncGlvLWxpbmUgYXQgb2Zmc2V0IDggKEZBTl9JTlNUKSBpcyBhdCByZWdpc3RlciAw
eDI3LiANCg0KQWRkaXRpb25hbGx5LCBpcyBpdCByZXF1aXJlZCB0byByZW1vdmUgZ3Bpb19jaGlw
IGlmIGdwaW9fcmVnbWFwIGlzDQp1c2VkPw0KDQpUaGFuayB5b3UgZm9yIHRoZSBhc3Npc3RhbmNl
LA0KDQotTmljayBIYXdraW5zDQoNCg==
