Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847A363C63F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiK2ROd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiK2ROb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:14:31 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7268361508;
        Tue, 29 Nov 2022 09:14:30 -0800 (PST)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGPoTK024041;
        Tue, 29 Nov 2022 17:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=Cffa22X0ZfS+6hUKOH60X/ncaRjgmIjhRH8gR6Lw0AQ=;
 b=inEgEWOAr5F6yyEUFGFdhKE7NBfKKJZC94NMnOZvNYA3+R2iP+KuCVnV29cilvQSN7Wq
 i9OBm1d/EGfCvB3hWyAV89jvLmhMF0UdLj+ik63p4UgCf5TmZ6rIOA5gGXeXhLr1Ylm4
 HuVXvgW3oBXgyCGSACDNoqT7B6aOvL9BS7ZBBiYZIn6G8szO0sq66x4y1CK3mGm1hv3Z
 3X2Q5tagZlaX2xNxns6tZTELh6tYTOWKFzs8HDx9EZFyHuy8Ifg/Dix6SGON1WEYic1b
 Bqs9GwCN7D543lbfm+dZpM2UOcNcGm8wJU+fVXfm081nzoW3WdsbgXWyFzjZEcmaPac2 hQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3m5nkgre8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 17:13:59 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 8CFDC801AD3;
        Tue, 29 Nov 2022 17:13:58 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 29 Nov 2022 05:13:58 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 29 Nov 2022 05:13:58 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 29 Nov 2022 05:13:57 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRsMk44xdOHGonyCPNprFoQTa66Vod4H1rR4cpDPRgtVO4EHWLreR1CREi0UVAA2GL0WJRuok7a6b+7f9Orz5aSISIGW1bCBfzM0EjGoDHLFB9Glf2L4ABSHv1ccJyFic3txpTGqH/doNNOauWhh4o+tDmjW6l+Mt7pJOqObCHG9MRjHYrJhBoo7XM5kVaaHLGpoSHUY8FUCDpu/hUYuB5CdeAyQGHb3c5mESrVrXCh6WJtOfKTk4D6yBdWpt2c6qcT5hgeZbq/VYHtVIsHj7Lu8lIH35T0tz4hLg1v2LAfy8+cZpiTQ51kz2JkiUr3KbKOgXGN6FgOlKXmqsP8iHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cffa22X0ZfS+6hUKOH60X/ncaRjgmIjhRH8gR6Lw0AQ=;
 b=Jh4Lafrypw26gKVcQxHCuI9fD9kqAGQvtU6CL9iogHxmaCy+h5/whtda74PWPwKP+C+RWOYrxduEwP3+vYzwjBzslZtOhj8pq7YEwr6E8LqpSDKEAdnPquXPeHp9gmFVe790nTxTXU+keXPN9a9jFwmsyhrXi8at4DUAyuGAMMlkr9FsAW9s06zvv2QCzoT/c6Vc0O1OCSH7GLENpzb7/eM2ICbP65VTpK5sU3hG4fwhr09GmIXz8mS/Bgc5vd41Xqi/rqDMG9YHUOyoangzTZazlZxOwgU2gXu9HRjot68cLJW3gil8sEfNe6fLHj7zGP1J4qfwzCDDWZYujk1n1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 MW5PR84MB1796.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Tue, 29 Nov 2022 17:13:55 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d24f:1a2:7006:17f9]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d24f:1a2:7006:17f9%8]) with mapi id 15.20.5857.020; Tue, 29 Nov 2022
 17:13:55 +0000
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
Subject: Re: [PATCH v2 1/6] hwmon: (gxp-fan-ctrl) Add GXP fan controller
Thread-Topic: [PATCH v2 1/6] hwmon: (gxp-fan-ctrl) Add GXP fan controller
Thread-Index: AQHZA3290RXdzRi+u0GYKuoor1LZ3q5VR9QAgAB4hIA=
Date:   Tue, 29 Nov 2022 17:13:55 +0000
Message-ID: <B3B2AA1C-0AD8-406D-B766-4CB86C39A834@hpe.com>
References: <20221128230219.39537-1-nick.hawkins@hpe.com>
 <20221128230219.39537-2-nick.hawkins@hpe.com>
 <20221129040232.GA1901150@roeck-us.net>
In-Reply-To: <20221129040232.GA1901150@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.67.22111300
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|MW5PR84MB1796:EE_
x-ms-office365-filtering-correlation-id: 2d6a005c-5292-4f30-5af1-08dad22d18b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +T5/GPAm+/QQhK3zuokRc+T+4lbT8kHVp4xRWFt2dM/AEFBHVTYg18ZQXaz/yyGd+C7lVJG5qoOeqNABlOaOvfCT1QmMqbejB8UT8C5d/N2Eub2tLn+WYG9iJLzm6EcBUqHa3PjxN74tCpvhLhavFvX8c1+v7AZtfKnLebao46umuptmcw/NezxWVxbyytDU4nk0m2CUSkzwnk+6WBccreRxsJAPwea28d4oxgyeHH6C2AXturMC8bar3gKdzFt0YDt1Ij4oLtqhE8MN6ZmuQueL/s3jIbI/Tv66NQJvLS8KTmlw/LEvXgk3uzlxfHwCw7pN423KPYPpIlNJI9uepLBR/2TdODU5px2GS/Kx2hsXJzATdpv2CnUUG4YFRvtunolVeSmd2tAiaSHEbT9uhVZWOKOoOPNuzLQ+YWUjUVXj/FwijPTKMJHVyq5Nh47Mugsok3nL7SOAjz0BFDz1+L0bJiWM8RA4oeUe9Ayu3s2Prc/UahVHYdN+chzswk2WOY/TeuU5Pf+1NPXIu+074kE15k56lp27fwVudPit0nOtBUDlgsvYyiMaSLa1WVKxfkOtsY3xlwuVzkxLjGIlg8CpC1wIU4vM+YwBrha4JGBoHrOoJra3f3gCszjayPUFB4GJMzVweSsw75C07RZo3cMHqsN35d1hxcR/wjNCRCzLBayqqVtKzIwLEu+pPn8FDZql6+rj7F30AcY0gAlBz/CUDd16xYFDdH26KXF/Lis=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199015)(82960400001)(38070700005)(33656002)(71200400001)(36756003)(54906003)(478600001)(316002)(6486002)(6512007)(6916009)(2616005)(6506007)(86362001)(2906002)(83380400001)(7416002)(8936002)(5660300002)(4744005)(186003)(91956017)(38100700002)(76116006)(8676002)(66946007)(122000001)(41300700001)(66556008)(4326008)(66476007)(64756008)(66446008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkxxUTI3TEJTc3FEOGZka1RjWEZIaXJXUHhDVGxNSS9BMjZOOXhxci9JV2dC?=
 =?utf-8?B?dU1XNkN4bFdFUjBHQUVCTUlUc1MvcngyVkdRcS9ENW5XMUQ3Z1N3STArbHN1?=
 =?utf-8?B?RGhpU2tHUjZ6bWlKZkE3OGt2MnFjWWV1Z2RvQVBRbEQrcFp0WHhnb1VuY25G?=
 =?utf-8?B?b1VOQVpSNjNSSWpteG95c1hRaFdKVGl4RVlYZ203Q2lNeGV0UHMxQVVyWUdN?=
 =?utf-8?B?Z29tamd3MHNDTVRkWGNYdWdHMEhMMm1ZTnJWY1lHUDR3UkxMa0cxdUxrR2p0?=
 =?utf-8?B?cXNNcTFGajNtUkh1aHNpVkt6NE5ibmxWd3BMOVVSV0VzWWphQk1yYlE2cHdT?=
 =?utf-8?B?RDA4MUFGdEVjUGNUNHd5LzRDd3VUMzYxMjYweUFaRVFFakJWdnpwWjNNL2J6?=
 =?utf-8?B?M0d1ejRXb29WOE5Sd3U4Smsrc0FORUFGckZQWDhhdGsvcmFEbmN5RGRmRzhu?=
 =?utf-8?B?T0h1c1pmdVMrd0lMSGRKNlNWOVZlVDJjY3g0dEMyY1BOOUlwNDNZWlpCZ2Vq?=
 =?utf-8?B?VWVZeUwxRi9WZDlCV2FtZVdRcGhOd3JXMXBwYXA3b2FzbHFCN3JsSlROeFpJ?=
 =?utf-8?B?VXc0am82S3loZFRRYW9Ra1FMN0o1TDlLZTZFY1J0YURMcGZPVFNRUUZFRFMr?=
 =?utf-8?B?aStmOUlKL1RzOFJGalRUdDN1L3hUdmlFaHpWSnJZRXpObkNsMm05QzhuTUV5?=
 =?utf-8?B?b3pkRmhrczJsWmxWYTJDT0w2VGFUNGQzeng1M2VpTEdySS9JQ0JQVjVIVVNh?=
 =?utf-8?B?aXdCWXVSRmJkVmoxSy8rNHdjekNIS1o0dFQycVRCdi93OVIxNEVQRGUra0Ns?=
 =?utf-8?B?eXpHWmxvYVcxRDNZUGFsUWZydGUxUURuWHlCMXhQK0FyN3dEbFMza2R1LzRN?=
 =?utf-8?B?Tm9QV3ZuWTJudXdRMmk2OEtIejA4dW42cTFyeDdzRnRDYUxacCtPMzhvWDRN?=
 =?utf-8?B?UXFZNzkxemx2a2N6N1BoZEVMeXBJMEg4a1puajk2ZFVQcUZvQkNLOWM4OW9D?=
 =?utf-8?B?a0t5VkxBbUpXT1dnQnc3eTRjeWlvTUdxL0JlUjAwZHFLTWJiNGhQL0t3V2k1?=
 =?utf-8?B?dTBnQTQzd2R3UWVsSkxFMGc1dVJ5TWdpbTlJTlYyejllM3V5RGRYQ2lFaVlR?=
 =?utf-8?B?NUc0WHJlVWk2dk9LOTJaT2dLTU5CMGRJM1pZYU9QakhnMmNrcEd4L2dtNzQr?=
 =?utf-8?B?VlBuS0hzeDh3V1E2SWpkckNmcnhUbUF4ay80amFDQjE2cWVyZG5JeDFVSFFI?=
 =?utf-8?B?VE5tMkpWTE84Nk9nU3M4SGorK2VnTDBDZUNBSEVxcHlTY0VVY2YwcHhobDlS?=
 =?utf-8?B?TWtpdThUTDlnaWxQNlpSdzJpRTY3a0JORk1DSzk5Wkp0Nnp5Q1FLelNzRUpx?=
 =?utf-8?B?WmVJYWRPQ1pqWkhubWVWS1I5Rkdwck80dklNRmpxeEdHMi81VVo3T3F5QUpE?=
 =?utf-8?B?b0JTNW1wdyttanVWNXJ1Q25GWU10VmZVd2FadG44Mk9rRzE4eFZld0orMWdT?=
 =?utf-8?B?bzhMZEl6aXkvbDRJaVhzT3Z0c1VqeGYrVjBxSFJBdjU2K1YzQXN0NHJJc0hW?=
 =?utf-8?B?R3R5SzZrSW5JK0M3M3dhOVhib2l4Vnd3TGdHd3prZkRpRzBNRDJmanJxeVJT?=
 =?utf-8?B?a0hWbzhGNjJJODQ5cHdYc0VuZ1hhMUlUR1ZDM3VqNXN6RS9CZS9pSGViSTkx?=
 =?utf-8?B?S01kNk9RblBQa0lWcTBzZnJEbXltUG5aaDNPakNnRGthemZham9XenFZdU1B?=
 =?utf-8?B?RzZJQ0dORHdjcnFydGJEK2JVZFkyYW5leU5Ga3RlTVh0MUY4MEJrWXZaUTRh?=
 =?utf-8?B?NVBBaVk4aTZIaEF0d3ZrQU5QYkNhUXY2TlUwbjFxNUxTZVNPQmZPcnVzbE43?=
 =?utf-8?B?L2o1ZTh0UE81Rzd4Mjh0UGExaEVZRndoNFV6K0I5a2FKSkEvMFFMZ2NuQm5l?=
 =?utf-8?B?Q015aFRYY2F1ZDd1MTNjVXdpZHFuYWVpbmhxWE40R1BqUlliZ294b1BBZm1y?=
 =?utf-8?B?cE9QTnpNZmkwVU5ma1hVM0h5dkZiQWY2TEIxenRpUVBiNmtEV3Q5YkpnMVF4?=
 =?utf-8?B?SGY4ejlIRmNkaHRaMkVIWnlVZmp4RVBQa29DME9tTEZpZ2dsVXpHc1VUVEFO?=
 =?utf-8?B?TEg5VXdKcm82czR5alBFRGwyT2dONEhWbllwUkdjblhYYXlFRlhaU3FFak03?=
 =?utf-8?B?UVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40718BACCD0038409284A45BE1DC0812@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6a005c-5292-4f30-5af1-08dad22d18b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 17:13:55.6195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XgnqJtXMfcGa9vAT8yY2VhMVqcm3b+i7kWDAT7WfAd01oO/wWv6PtqW6YA17DkyEkAlutz76STL9nOYxpOY71Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1796
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 2v1pp8c-UqgpH1YrBn6bFKRHE8XBtDax
X-Proofpoint-ORIG-GUID: 2v1pp8c-UqgpH1YrBn6bFKRHE8XBtDax
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 mlxlogscore=783
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290095
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsJCXdyaXRlYih2YWwsIGRydmRhdGEtPmJhc2UgKyBjaGFubmVsKTsNCg0KPiBUaGUgbWl4
ZWQgdXNlIG9mIGRpcmVjdCB3cml0ZXMgYW5kIHJlZ21hcCBpcyBvZGQgYW5kIGNvbmZ1c2luZy4N
Cj4gV2h5IHVzZSByZWdtYXAgZm9yIHBscmVnX21hcCBhbmQgZm9yIGZuMl9tYXAgYnV0IG5vdCBm
b3IgYmFzZSA/DQo+IENhbiB0aGlzIGJlIHVuaWZpZWQgPyBJZiBub3QsIHdoeSA/DQoNCkkgd2ls
bCBzdGlsbCByZXF1aXJlIHRocmVlIHNlcGFyYXRlIGFyZWFzIHRvIGFjY2VzcyB0aGVzZSByZWdp
c3RlcnMgYXMgdGhleQ0KYXJlIHNwYWNlZCBmYXIgYXBhcnQgKD4gMHgyMDAwMDAwMCkuIEkgd2ls
bCBjcmVhdGUgYSBjb21tZW50IHRvDQpleHBsYWluIHRoaXMuIEFzIGZvciBiZWluZyB1bmlmaWVk
IG1ldGhvZHMgSSBiZWxpZXZlIHRoZXkgY2FuIGJlDQphbGwgX19pb21lbSdzIG9yIHJlZ21hcHMu
DQoNClRoYW5rcywNCg0KLU5pY2sgSGF3a2lucw0KDQoNCg==
