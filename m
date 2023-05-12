Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC1F700C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242018AbjELQJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjELQJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:09:48 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B325DC1;
        Fri, 12 May 2023 09:09:46 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CEN2WH012288;
        Fri, 12 May 2023 16:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=BUEP2ar+6B3un3HrdyCuutVUfIcg+MnnggODTsgspIE=;
 b=e4chHjucnvm/3ZvUxBz5OeEccBfx8wMKmlY/J8cOgRuGqoA/7mYbSBYIbN3Sae75NiJA
 CooomANUoRa+0yIAzYF1rWeYgSM7MOUo5JSKAyyfU/EiRnnRuR8CslATVQCRuilUhTm0
 TuVE6UuDHvdB7lkAYBOHSZu9AXd86+6OrkUSY7S2pWODtvMk2CVFkjwZBA27HFjMMhGO
 H95W9fYx1Awj1NILLD/i3KC9jNTvc5ZwfJIETvJdL5fgcETKQyu9nX2XDbQKrMp9ikWd
 jwFZWBbReCWFgyXoIUqDVUVYUv3RTLMHT3oJMvSMrtf7mvXFJuF60NDfn4XYORaNThJs Fg== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3qhcjmweax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 16:08:37 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id C63E180021F;
        Fri, 12 May 2023 16:08:35 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 12 May 2023 04:08:35 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 12 May 2023 04:08:34 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Fri, 12 May 2023 04:08:34 -1200
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 12 May 2023 04:08:34 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrpEsR4YKizPf9rFE2lJ3hEXX4HXXvv1cNqbocw69f9+HpST6neYNnTt1WO0/LFlGrtFpTZW/lcCorobUdVsGnhIFxGgCdCFrkRsGU1s8vZq+pgx38H7zEVrBbkiZRbd92H4M/U8xucB/1gqoXBzKK+Dvq7tolDhRCGPUedrApu7GYq9G3jbOMAFw8ed39Cp8kNn8ZCJZFJuBmt9684U2eQcvfTPbZ0Wt7epNUv/A276UJhsVoG8axpcpuUTa8WlmM/JNGwZuXlO1Yjz7QEv68CSr81EiNRECSXdBr6702lOS/XfLWFR0apOcUVslADBpZhhxM6dzigbWAvMotLs1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUEP2ar+6B3un3HrdyCuutVUfIcg+MnnggODTsgspIE=;
 b=QZ+ToGq5FCrbybdakOHDqNk6hD4cBgOHSk+zzOStIOFUNUoJZqXqiBW2QDNALuUzuyp5gfVKJgWEB2yn/XbU2sWYeenuEpMJJxPZ4bCMD+lToTpyCsIDKKu6PA1JaFftxTuq7WUoq2/EoSO6zn+OjgAbosId+r7lHjGcvWtl6f0VjzBqf+KtCXz6SqTVW9L/qYBHUTjNt6YKD0/inA/Cor6j72ndBBr0sholXxs21B76sC0ArVx1lyRiCgCao3tKv9G6dBYBo0lrXD1sLF5LfsAxQg2qzf8awTAiQbZAonPO9VwBFR+yINaFEy40unRRi3DiiSHfSSfFsMb029gv/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 MW4PR84MB1780.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Fri, 12 May
 2023 16:08:32 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682%6]) with mapi id 15.20.6387.024; Fri, 12 May 2023
 16:08:32 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1 1/9] gpio: gxp: Add HPE GXP GPIO
Thread-Topic: [PATCH v1 1/9] gpio: gxp: Add HPE GXP GPIO
Thread-Index: AQHZcgrpODxMvy9ha06K9TX/iHoHda8xT0MAgA36FZCAAX5fgIAWJ2/w
Date:   Fri, 12 May 2023 16:08:32 +0000
Message-ID: <DM4PR84MB19274817C2D8A751E3218F4888759@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
 <20230418152824.110823-2-nick.hawkins@hpe.com>
 <c27e07d2-8eb1-16a8-4619-280967fc0de9@roeck-us.net>
 <DM4PR84MB1927C9D3C5CC5B001713CE57886A9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <b0bbd842-2262-8979-d8f8-ec611310c44f@roeck-us.net>
In-Reply-To: <b0bbd842-2262-8979-d8f8-ec611310c44f@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|MW4PR84MB1780:EE_
x-ms-office365-filtering-correlation-id: 2ef81a36-d152-40e7-bfe7-08db530321fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3dnIrAsghEVCCCSGXRpeFfcHFM/DRo5P+QysXGmFrH4kByVZ+Y6iIThK26uuaQA0tPb1OqvPxNv+fICGKQhPjgnXDevj0KU/bn9sXWzJblOIq38AVPwI61ljfHXLxoEMBALik1Rc0MFx0tuRjBzVihlK4E5RZ9Em1gfmKgttogVgP7WmT3jJ/Vz8ihzm5f35QojwYCvapXngXvYEae++ybf+l3tSCHT4zaCMjOmEOJKd0Bth1n1QKZwbVQGh24FSGRpku7rCy7uyF6Lzjp3TK+f/b8xdgGLjEnWGaOkLJePN/R911cT+hJOzOJbuaWx7VHLYdu2ydoj3I8H6Cw8NrcGXZILxzHrQDR8JM3jqTc2W4ONMQM6ErXlX5Q9UhZ1txiFdalYNPV3ah+PPWviIRIyQ0/57znimHVdRC2s16CFdn+UQ6LWcUje2b5CnbX/L21RwBRjEQds6yQR2O15OY49qT3CttuY6JbvMcIFAcbtcn2PS/K7eOX2Fb6di+SthUq4ZthcqlKIYn9Vvne7BfNDNyBn3BCEM7P5qRpLM5kkoM+f2z6/HmQLksgqbvOci5shXvrbiFd+QxIDRx09wABxrl6dfbrerfLBGENkWqoNgq+NtaEglwofqdVchvWj5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199021)(186003)(66446008)(66556008)(55016003)(6636002)(26005)(64756008)(4326008)(76116006)(71200400001)(66476007)(66946007)(9686003)(6506007)(2906002)(316002)(41300700001)(5660300002)(7416002)(478600001)(38100700002)(33656002)(54906003)(52536014)(8936002)(8676002)(110136005)(7696005)(82960400001)(86362001)(38070700005)(122000001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkFvQW5jamZINE1ZS29lcGw1OExDMWNmREVoTngyVWphSzMyMGhBWk05MjJJ?=
 =?utf-8?B?TC9UU1F0THdaNTRyY0UzTmhtNldtQ3hYOHc4cHk0WXVDYi9OKzZ6MCtWR1p3?=
 =?utf-8?B?bUlXeUlJekdJcExTdGNVQVdYdjRpcEVaRjRaT3JPNGsrUzFIRUo1WjQ0Y2pi?=
 =?utf-8?B?Mk1pZ205dkVKUWpOYjUyZHVmd2I3bDh2cWNUY2M1THJNelVHZ2ZHOFNnbzBD?=
 =?utf-8?B?TjFZNTJCZVpiOEloNVRPZUhUbUs4UjV6L3hWQk9GaW1JaXhtQ3hTTHVtbnR2?=
 =?utf-8?B?b3QwU051TTAxbmV3SGFwRDU1d2JiMDJyekl1S1BxekFsNHFGTjdWK1RyM004?=
 =?utf-8?B?VUtpKzEvbC9WaWdJbkU1bVliTjFBQ2NGRWtBYmhhblV1U3g2Q25GamhTZzFa?=
 =?utf-8?B?QmpxZm9DK0lXcmtWV0lSQUs2QzFSaEUwMzJ2STBhRXpiRURXb2szSFRVMkc3?=
 =?utf-8?B?dnh5aWJzMmtCMktGZ3V0ekxFcjBBMVJPb3cvZHRLemk2cXhWY2RSSUVGampy?=
 =?utf-8?B?UzdFN25ZZHdPcXpDQnY3SXBlOHQ2OHBSZXFudVE3S1R2cUF5S2lIajJRakQz?=
 =?utf-8?B?Q2F4U25rVmJNMTE2UDVqTXRmUUx0NXRXa2Iza2hyNXhXekVOci83NXB1NEc0?=
 =?utf-8?B?V29QOWpISlF5R2t2QzRXMForaEN4VmZja3dpbVZTcnBhZWVQekxPTnNweGd6?=
 =?utf-8?B?ZmJSaWNxNmpyRytIZzdtMUFDOTZhM2pERmN4ZTZOa3FnVUMvVWNQMXZnMlph?=
 =?utf-8?B?bE8xY1BmKzk5RVUwOUZwbi9sejM2Y3UxbTh5V09YQXBzc2pXeUJsNTJKWXI2?=
 =?utf-8?B?RllrOGNndVJBK3k4KzV0UlVBVFBiVWRFYUl3dU1oOFF5RTQzc3A3cDZRbVYw?=
 =?utf-8?B?ZEIyUFNEdDJ5NjJ0YTdkNlBIMHVFSjFyYkZLMXBta3ovaWdQSjY5QTdRMEla?=
 =?utf-8?B?dXUxZXVQMjVqY09zbi84RVpLSFYyT000MG1UN3UycWN5VW5Ob0ZRU3EyUXg0?=
 =?utf-8?B?MEhTNG1nMzROZC8yL1RGMmpLYVgzd1l0djdDRGt3T0lOSjBPZ1FoMktXR3E3?=
 =?utf-8?B?cWE5cmRabDhOSnJXeDNybWZSOFBEYkZxRmtIUk0zVE02WEE0RU4wVmdVNndo?=
 =?utf-8?B?K2t2TWozaGorejUzWXpMTytCVGRZK0VmRUZOMVNra0txNjZTWGJWMVUzUnR3?=
 =?utf-8?B?dmxsSW5iNjBvTWV6U29lZDh5NGxON0N1S1hCZm5xZmsyYjIwcTJUUjMzcmM5?=
 =?utf-8?B?bGJ4ZUVlMEJ5bitXN2dNdXNadHpBSStyWkFrNjJMSzVFb2tWc0E3N1JrK2hN?=
 =?utf-8?B?RnJ5aUFXTWlmWnRzeEZ0SE1xTW9aZmNtamdsNWdHUDdidzBpZ0tPOCswdHBl?=
 =?utf-8?B?ZkQ5U3pCMzBuTE5FejVPQWpPQ0N6U3BlcFBBZkFoYVQwY09acW55Yk9laHpu?=
 =?utf-8?B?Y2FHS2l0cUFtZTZ0ejY1cUhOME12OWNMMy85SWdhMFpEQSsrcEhKNmN1OHJa?=
 =?utf-8?B?Z1JxNFo3TS95N0U2OFBmb3dFRGhIek9DbVBpckg2Ty9QVkRzMHRiV0x4ekha?=
 =?utf-8?B?Vm8zQjRsWTBqbVp3c2dZQ1RYT0NiWmh5dmkwR1V2NG5hd0xVcUNzSGE4aW9r?=
 =?utf-8?B?d3lQV3dSak1UK3BrVFluTDZVV3JWWGorOGdMTW8ralluZDVEZU5qU1VtVmNG?=
 =?utf-8?B?VDVDV3lHMkFqenNmY3FHK3IvR0NyRHdDaC93dXFrVGREQ0Fnd2s0MldqUEdX?=
 =?utf-8?B?ZGtWamdabVRBSllNTzlUeGIrNEc0TlIvQi9HdjNGbVE4U0ViQ29vNXllOUxy?=
 =?utf-8?B?QmdOMy9laFF6TUxPcks0UkY5Ukx1dHE5NlAzK25KaTE0aGNMWEh5MjFIYzdC?=
 =?utf-8?B?enBFM0NkQ21oMk5IcnBNTm1ZVW5RVVV2dnZlRkVmSm5aRHk3OWVUSTJHVFRq?=
 =?utf-8?B?WHlBSlN6ejBwdU9YbnRUTDFBb0oxTFJGaHJQQjZTaTg5UGlueEl2MXdrWk1o?=
 =?utf-8?B?cGxiOUxETEkzZ2lGUkpQNEpLNU4xaWFrNmg1YnJTTEZvSFRTZjV3ek83VVhj?=
 =?utf-8?B?bmwyR1JlTnRzK0t4K3o1T2h2dDR6MkRxazJRWkRxVk81K2xiWlZaRCtRRDRW?=
 =?utf-8?Q?ormOWjACvlxPihnnzpfyoALp6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef81a36-d152-40e7-bfe7-08db530321fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 16:08:32.3190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a5TqdNgJJ/xBuuB0Xs4j9VQaAxw42svlMKnxFuomMY54OQLTePaqxn++1j71NVs9+4XUQh7xKQ+ngJpjVRuHSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1780
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: cHOXqlouDpPu_IcnMgBq6p5JOcevzgYM
X-Proofpoint-ORIG-GUID: cHOXqlouDpPu_IcnMgBq6p5JOcevzgYM
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 mlxlogscore=945 malwarescore=0 suspectscore=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120133
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTb3JyeSwgSSBkb24ndCB1bmRlcnN0YW5kLiBMb29raW5nIGludG8gdGhlIGNvZGUgYWdhaW4s
IHRoZSBtYWpvciBwcm9ibGVtDQo+IEkgc2VlIGlzIHRoYXQgeW91IHdhbnQgdG8gbW9kZWwgZmFu
IGluc3RhbGwgc3RhdHVzIGFuZCBmYW4gZmF1bHQNCj4gc3RhdHVzIGFzIGdwaW8gcGlucy4gVGhl
IHNhbWUgaXMgdHJ1ZSBmb3IgcHN1IGluZm9ybWF0aW9uIChpbnN0YWxsZWQsDQo+IGFjLCBkYyBm
bGFncykuDQoNCj4gSWYgeW91IHdhbnQgdG8gZG8gdGhpcywgZmluZSwgYnV0IHRoZW4gZ2V0IHRo
ZSBzdGF0dXMgZnJvbSB0aGUgZ3Bpbw0KPiBkcml2ZXIgYW5kIGRvbid0IGV4cG9ydCBhbnl0aGlu
ZyB0byB0aGUgZ3BpbyBkcml2ZXIuIFRoZSBrZXJuZWwgc3VwcG9ydHMNCj4gbWVhbnMgdG8gZG8g
dGhhdCAobG9vayBhdCBncGlvZF9nZXQgYW5kIHNpbWlsYXIgZnVuY3Rpb25zKS4gSXQgbWFrZXMg
dGhlDQo+IGNvZGUgbW9yZSBjb21wbGV4LCBidXQgSSBhc3N1bWUgeW91IGtub3cgd2hhdCB5b3Ug
YXJlIGRvaW5nLg0KDQpHcmVldGluZ3MgR3VlbnRlciBhbmQgQW5keSwNCg0KSSBoYXZlIHB1cnN1
ZWQgdGhpcyBhcHByb2FjaCBhbmQgSSBoYXZlIGZvdW5kIHRoYXQgd2hpbGUgdGhlIFBTVSBhbmQN
CkZBTiBkcml2ZXJzIGNhbiBjb25zdW1lIHRoZSBwcmVzZW5jZSBhbmQgZmFpbCBpbmZvIGZyb20g
dGhlIEdQSU8NCmRyaXZlciwgdGhlIGhvc3QgaXMgdW5hYmxlIHRvIHJlYWQgdGhlIHJlYWQgb25s
eSBHUElPcy4NCkluIE9wZW5CTUMgd2UgaGF2ZSBhIEdQSU8gY29uc3VtZXIgdGhhdCBzaXRzIGFu
ZCB3YWl0cyBmb3INCkdQSU9zIGNoYW5nZXMgdGhlbiB0YWtlcyBhY3Rpb24gb24gaXQuIFRvIHJl
c29sdmUgdGhpcyBpc3N1ZSB3b3VsZA0KaXQgYmUgYWNjZXB0YWJsZSBmb3IgdGhlIEdQSU8gZHJp
dmVyIHRvIHBvbGwgdGhlIHJlbGV2YW50IEdQSU9zIGFuZA0Kc2hhcmUgdGhlIG5lY2Vzc2FyeSBm
YW4gcHJlc2VuY2UvZmFpbHVyZSBhbmQgcHN1IHByZXNlbmNlL2ZhaWx1cmUNCmluZm9ybWF0aW9u
IHZpYSBhIGdsb2JhbCBzaGFyZWQgdmFyaWFibGU/IFRoaXMgd291bGQgYmUgdGhlIGFsdGVybmF0
aXZlDQp0byB0aGUgZHJpdmVycyBjb25zdW1pbmcgR1BJT3MuDQoNClRoYW5rcyB5b3UgZm9yIHlv
dXIgdGltZSBhbmQgYXNzaXN0YW5jZSwNCg0KLU5pY2sgSGF3a2lucw0KDQo=
