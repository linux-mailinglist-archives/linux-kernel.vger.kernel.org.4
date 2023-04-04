Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B576D5D9C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjDDKgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjDDKgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:36:19 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3AE1BD6;
        Tue,  4 Apr 2023 03:36:17 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3347hYX5013927;
        Tue, 4 Apr 2023 06:35:56 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ppecd5w7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 06:35:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8ExNxXppiS9WVa5F1bft85Sr0oRxU8QX+82caCe73vG50wf3ev5NSRVWrkELiwfAr0HYAdfZd/KP6ZvLkIa5EtcrguMpvUmRA9vfiJSmkpBbTWV7PrqfsCQbA/XtVD5NgWQD2VWRpJL9/a9CStrJi+eNe6YixUxjUKXaHMkbrumenDArh+SmYWdmum5d5bqahx56nrFg/Z7gYotZ0CF/KkQrLX2aZUZseIaWrCumEU01j/Q65Sp/tpzVpUTh6SCVoDwP6AOFR+Ad7bTRkPRM35E9ymnyBFA9e4vGoN3pY8Pj9eAzbj7GZyqebPTER5vLKPLLzouof65CSCbblp8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwCn8qZ+ME39Mm16nPB59fiEIQ11QekS9nsO+/RePWY=;
 b=fHB5eLWR+PNVc4AQCRfI2qEepxLu1eHR1PgXhvHZUftEb6JQ5GOkONHHgZVS4mDwaT/MNtGHDnlbAKmyATpYfT92Icw3kG55jpiuVO1DP1CyD1D8hQmF2qF42+n2X2I2EvtOqe+CGB4WOqCMwmoe2l8o8jRJMJrsipGNG0l06B+A8z9JjBKmkgOMtygMGluNM/OJkHrY8jHgDgRvRABuLgB8jPDto4nj6C4jLwNqq2/9lNon1bwGjUIBkUtPKXbiA2+KFH4D/b9BllIeOSolciRtvZwayiy31LUCCPXn3jZA/bZuoAF7gH+ds/fxANP0qlYqqo+gF9VlQ8mQRxpusA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwCn8qZ+ME39Mm16nPB59fiEIQ11QekS9nsO+/RePWY=;
 b=zhb2Da844b9OkHXErYHXIUDuxuT2D8XJnEEZhAZc+aNV0h3Nq2vq4q3njkdLVFezfANvK1kXTFcTCAGC1ATYt6uIEA+j+y8V7L//xg60ohVpxKzjlhHVF3rvNuEP8jAu2j75LwpN+Nxi5DmjJuBtBVywbgcqxxKpz/H2qvP5/fw=
Received: from CY4PR03MB2488.namprd03.prod.outlook.com (2603:10b6:903:39::12)
 by SJ0PR03MB5952.namprd03.prod.outlook.com (2603:10b6:a03:2d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 10:35:54 +0000
Received: from CY4PR03MB2488.namprd03.prod.outlook.com
 ([fe80::3ebb:ede8:1ce9:2528]) by CY4PR03MB2488.namprd03.prod.outlook.com
 ([fe80::3ebb:ede8:1ce9:2528%6]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 10:35:54 +0000
From:   "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Subject: RE: [PATCH v5 2/2] dt-bindings: rtc: add max313xx RTCs
Thread-Topic: [PATCH v5 2/2] dt-bindings: rtc: add max313xx RTCs
Thread-Index: AQHZZkM1/0NcmmhHVE+7c9BLHmZIxK8arcoAgAAOpACAACNY0IAADnQAgAAGjDA=
Date:   Tue, 4 Apr 2023 10:35:53 +0000
Message-ID: <CY4PR03MB24883E0406C2A16E566DB39196939@CY4PR03MB2488.namprd03.prod.outlook.com>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
 <20230403154342.3108-3-Ibrahim.Tilki@analog.com>
 <dd6f0842-519f-1bc9-f7f5-459863dc3dcd@linaro.org>
 <202304040710049c9cc01a@mail.local>
 <CY4PR03MB2488DFC99C23ADE16FF40E2F96939@CY4PR03MB2488.namprd03.prod.outlook.com>
 <1efdb870-cac2-f6ed-72b5-d0550dbb5257@linaro.org>
In-Reply-To: <1efdb870-cac2-f6ed-72b5-d0550dbb5257@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYVdKeVlXaHBiUzUwYVd4cmFWeGhjSEJrWVhSaFhISnZZVzFwYm1kY01E?=
 =?utf-8?B?bGtPRFE1WWpZdE16SmtNeTAwWVRRd0xUZzFaV1V0Tm1JNE5HSmhNamxsTXpW?=
 =?utf-8?B?aVhHMXpaM05jYlhObkxUYzNOakkyTnpBd0xXUXlaRFF0TVRGbFpDMDRaVGd3?=
 =?utf-8?B?TFRkallqSTNaRGN5TXpGaFlseGhiV1V0ZEdWemRGdzNOell5Tmpjd01TMWtN?=
 =?utf-8?B?bVEwTFRFeFpXUXRPR1U0TUMwM1kySXlOMlEzTWpNeFlXSmliMlI1TG5SNGRD?=
 =?utf-8?B?SWdjM285SWpFME56QWlJSFE5SWpFek16STFNRGM0TVRVeE5UVTVNRGN5TmlJ?=
 =?utf-8?B?Z2FEMGljVTlxTTNZeE1XRjVjRzl1VnpreWVXTnNSakJSWjNaTWVEQnZQU0ln?=
 =?utf-8?B?YVdROUlpSWdZbXc5SWpBaUlHSnZQU0l4SWlCamFUMGlZMEZCUVVGRlVraFZN?=
 =?utf-8?B?VkpUVWxWR1RrTm5WVUZCUlc5RFFVRkNSM0pGWXpZMFYySmFRV0ZoTURCb0sy?=
 =?utf-8?B?aFZXRlJVY0hKVVUwZzJSbEprVGsxRVFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVoQlFVRkJSR0ZCVVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVVZCUVZGQlFrRkJRVUZSWkdsck5WRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGS05FRkJRVUpvUVVkUlFXRlJRbVpCU0UxQldsRkNha0ZJVlVGalow?=
 =?utf-8?B?SnNRVVk0UVdOQlFubEJSemhCWVdkQ2JFRkhUVUZrUVVKNlFVWTRRVnBuUW1o?=
 =?utf-8?B?QlIzZEJZM2RDYkVGR09FRmFaMEoyUVVoTlFXRlJRakJCUjJ0QlpHZENiRUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZuUVVGQlFVRkJibWRCUVVGSFJVRmFRVUp3UVVZNFFXTjNRbXhC?=
 =?utf-8?B?UjAxQlpGRkNlVUZIVlVGWWQwSjNRVWhKUVdKM1FuRkJSMVZCV1hkQ01FRklU?=
 =?utf-8?B?VUZZZDBJd1FVZHJRVnBSUW5sQlJFVkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVZGQlFVRkJRVUZCUVVGRFFVRkJRVUZCUTJWQlFVRkJXVkZDYTBGSGEw?=
 =?utf-8?B?RllkMEo2UVVkVlFWbDNRakZCU0VsQldsRkNaa0ZJUVVGalowSjJRVWR2UVZw?=
 =?utf-8?B?UlFtcEJTRkZCWTNkQ1prRklVVUZoVVVKc1FVaEpRVTFuUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVSkJRVUZCUVVGQlFVRkJTVUZCUVVGQlFVRTlQU0l2?=
 =?utf-8?Q?PjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB2488:EE_|SJ0PR03MB5952:EE_
x-ms-office365-filtering-correlation-id: f1283843-9a5d-4ea5-5a9c-08db34f85e22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kNFIg8PU75PtKI7B7ey6jj9uzGJarhsCfKKZyLKGRxubb778F5YZz8ONFdgF2nPBuzflb9dTBSkNVMZ208zyxY2umYUl4g7YKdvgux8+DsCv0hwvw9eO0cnJJqYbUfM5Fp5zvOLUtGM1annPVPml6kustCvNvhQUUj85DNgj+O3ppVyYaas4hyc82hZ6cc3TXLkNoSr34sBh56Im805TNIsxQi0YUQapgS3/jYdt2WmvEoc3Wo/ONBCQEUj5FLvj90+AH3BJOwPsDQwMEKTQwMGibcHiDQoXHe18O+pSvWfRaGhpcPKN7lpWZ/NWZxCL8Thj9KnyQVdU5Dbn0MdbdUySzDCC2dGzO8G1FgP6jeasv/L3ZceWxMyPLiqEwZpfzpTFQKb/vts1lygNf0TaLXo6hKGWApQPEidUpY9xR1TmJbMinz+uovoUzos9r7IOYLDkG7lJJvPJ0uQ5JbOow7XGGcQwMOKCodNmUcNv+Tb9zExJlfgKff8DoDYwHYoyCHy04cjzA9bG+ir2b0FlP2/4dnAFLVYerahFqb0tdBlrstDTGqwG6DWRThCIARY/hnlaGTPc+hfVyYytQRE/xS0McwfZsHB7v53a/GNs9U9X2Rynbv6L+NPujbSz21l3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2488.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199021)(86362001)(38070700005)(2906002)(33656002)(55016003)(7696005)(71200400001)(107886003)(83380400001)(186003)(6506007)(9686003)(26005)(76116006)(8676002)(66556008)(66476007)(64756008)(66446008)(66946007)(122000001)(4326008)(316002)(5660300002)(7416002)(38100700002)(41300700001)(478600001)(54906003)(8936002)(110136005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGR5ampGK0cyVTVGU0ZCVEhLeTIyMGVmWkVjYmR3ZW03T0lrTkxubTk1V1BK?=
 =?utf-8?B?Y2VFdGpaZm5QbXdFaHRXNTkzZ2huU1VDV2VIREhIb1dZdnY2bDdTRUxZK2VZ?=
 =?utf-8?B?a0RUM1lsZ3JsL3FXUE1uYnJ1SVRQS3hTR2NoZ1VBZHF0NjRUM2t3SnpESWpN?=
 =?utf-8?B?N3VPNC9UdHF5QTlaS0hFays3Yzl1RFY3VnR4TjJRVjVLZkszbnNudWpYYWJq?=
 =?utf-8?B?SnF0OG9MQVZPV2VXOEhvL3J4MVkwWGRHTlhKOStrbFBkTmc4NFlyZU1FQnNV?=
 =?utf-8?B?bjNpcWxSZG4vVTYvRDFQL0IwU2sxcXBWczdJMm5GUHJOeXNpOWFvdGRIUkdG?=
 =?utf-8?B?WnRrQkZtSjZON1VybjZWN2dHaXU4YlgxbDgvczdDWGJyMnVIekNiLzlpYVRw?=
 =?utf-8?B?TWtvbVhEaTJLamhENjJpSmpkSUc3UVRqbVhVU3I0OWhSNmlKNy9wNTN6TWRp?=
 =?utf-8?B?ZU8xMDUyYktZNnBjQ2R3L0tTMW5yZEdZZWoyOHR3eUFGMnJzYTV0dWFHQXJ4?=
 =?utf-8?B?b3RkWXhqREVjYjZXK3doVEV5bmxESDdYTUYvaUZjQVZGeHdjVjJ1c24vVm56?=
 =?utf-8?B?TkorWFFzcWJnYnMxdlpicHBhbjdZd0M1WURod3JrTzV6K3pXdDh5Y0F5TEVJ?=
 =?utf-8?B?RGZNTWpaMFNxdGtGMVBpVjc4S2pZZ3BDQ0xobis2cDBNTEtjbUYvRUdRVXcz?=
 =?utf-8?B?bU1kNXRyK3hlOVlyUEgyekFEM2o2QVkyNkpzMWJ2N0ttVjB5R0p2Zlp0Wkgr?=
 =?utf-8?B?bXQ5OFFtZ3pTMG8ycGp6aC9zWFkxdDNOUWEzaDYyczNPZE01cVdta0cwNFA3?=
 =?utf-8?B?OE1ZcWRHYW5HL0xzeE9MQ2FHdkE4Mmc4THRiSkE2SFRDeTJYbzZYbU0zN2xL?=
 =?utf-8?B?NzZpVTBrdEx3ZDRYYUpJUWVYWktINjA4dnFLSFZqUHEyOEZPUFdzZlphaE91?=
 =?utf-8?B?RHlCcGFaYXhpL1dDdzNyUWp6WlhQdVZZUldYOHNiQmNYZjlLU3paaDJBUGts?=
 =?utf-8?B?d3VHcTkyVVczTlpjSXBBcU5KYVk2cnpGWHJKMXVzRTllUmpJRHRGaVA0QUlU?=
 =?utf-8?B?R1NyVldJcDZDSUdlZDRyVnk3a3dDNmhYQXBkQmdidWw0Q20wUjNJbHk3MXFy?=
 =?utf-8?B?N2Z0REVmQSs1VFJVd3ZWL1ZSSkRvNlI0a1ZPMlo2TC95aFFqcU93R0hxOVZH?=
 =?utf-8?B?WnNFQ1ZFek9BU0hKSmJpZmZyeUNUdWpLbVB3Wm4wNzljVFB4TGt5WHhyWUlQ?=
 =?utf-8?B?YkVmWVd5blBhbVBiaTEzY1czV3RjVkhpYVgyUms3TXhhUEkrMGZrZmNDdEYr?=
 =?utf-8?B?MUNYSk10QmRZdnliMWF6SW5RVy9ZMjdtOE9CUUtBN2M0ZkF6WFEwZUNTTC9k?=
 =?utf-8?B?ZXZJZmdRdGc2SEdlUDJpT0ZWTDAvR3dyMGUxN0JDRDBWR0p0L3FaczlTcm5G?=
 =?utf-8?B?OVJYUTE4c01yd3Z0UDBEcE5OMUFwNG1UUnV5THN6WWRidnpkY0ZxVVZ0VDVJ?=
 =?utf-8?B?MXRiMGJtSlZvMk16NVhMdFZTa2NnTUpJa3duYTM4Y25VOXFEanVMNnlLeWlN?=
 =?utf-8?B?MG4vU2FHNlZvTW1IY3kyVDkvQ0NPVGZMd2xXdFk5elZGdEtVS1dVaW1EakhH?=
 =?utf-8?B?Y21iUkkvT2hsUlEvY0VKWDJZeUE3TSszNkdUbHNiN2ExN3Z5ZXNBTlgwN3ND?=
 =?utf-8?B?MVVWUDk2cFljUWJEeERxV1o5N0hoajYyTWZBRVc1b2RBOVhjSFBvVmtuTXZu?=
 =?utf-8?B?VUU1TE91ZFFweU9MVzUxUUtJaTQ0M2tKVi9ER2gwa05TVGRTMG4rajFuT0R1?=
 =?utf-8?B?aERXc0ZKZ0s2R216MitZdWtSQlYwdHZRODF3S3R3R2pTZVZSampwVXZTYWdt?=
 =?utf-8?B?Tm9TQnRCd3M0d1g1czVGN2JDTDR1SVlMaVIzSXNzR2JlUGplVW01dWJNQWZw?=
 =?utf-8?B?c3lDL3ZVSmErUVAvU09iQTBSQzhzNkpqbTNmL2d4TXRqL3A3MVZrYUgrNFkx?=
 =?utf-8?B?cG5kMXVpalkydk5VZFppcHRhVkNGaUpNTzBIa0FOSDVqdEtBbnk2SDZZY1Nj?=
 =?utf-8?B?cUdXK0xnaTBsdXRoOVN2MTBBeVMwREdjVEt1VU1CWnduTk9UdlFmS2tDMldh?=
 =?utf-8?Q?LvRlGnm93aEzrJej3pR6sOeqt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2488.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1283843-9a5d-4ea5-5a9c-08db34f85e22
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 10:35:53.8654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YdPVoua15/kxiOXNcvgBiXz+eNRb0b6VG7GWaDrSWUNWR4yj2yJpKVK4P66JVTWJn1QjAO6PC0UmsQsG8PudJOg3DtxaeNChYfzKWxiNxWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5952
X-Proofpoint-ORIG-GUID: iI0UZe6EUXYTlCJcvS6KSWJayTcjJ_dx
X-Proofpoint-GUID: iI0UZe6EUXYTlCJcvS6KSWJayTcjJ_dx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_03,2023-04-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0
 clxscore=1015 mlxscore=0 phishscore=0 mlxlogscore=766 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040098
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+Pj4gKyAgYXV4LXZvbHRhZ2UtY2hhcmdlYWJsZToNCj4+Pj4+ICsgICAgZW51bTogWzAsIDEs
IDJdDQo+Pj4+PiArICAgIGRlc2NyaXB0aW9uOiB8DQo+Pj4+PiArICAgICAgRW5hYmxlcyB0cmlj
a2xlIGNoYXJnZXIuDQo+Pj4+PiArICAgICAgMDogQ2hhcmdlciBpcyBkaXNhYmxlZCAoZGVmYXVs
dCkNCj4+Pj4+ICsgICAgICAxOiBDaGFyZ2VyIGlzIGVuYWJsZWQNCj4+Pj4+ICsgICAgICAyOiBD
aGFyZ2VyIGlzIGVuYWJsZWQgd2l0aCBhIGRpb2RlDQo+Pj4+DQo+Pj4+IDIgaXMgbm90IGFuIGFs
bG93ZWQgdmFsdWUuIEkgYXNrZWQgdG8gZHJvcCB0aGlzIHByb3BlcnR5LiBJdCBpcyBjb21pbmcN
Cj4+Pj4gZnJvbSBydGMueWFtbC4gSSBhbHNvIGRvIG5vdCB1bmRlcnN0YW5kICJ3aXRoIGEgZGlv
ZGUiLiBTbyBvdGhlcndpc2UgaXQNCj4+Pj4gaXMgY2hhcmdpbmcgd2l0aCwgSSBkb24ndCBrbm93
LCBGRVQ/DQo+Pj4NCj4+PiBObywgd2hhdCBpcyBub3QgZXhwbGFpbmVkIGhlcmUgKGFuZCBtYXli
ZSBub3QgdW5zdGVyc3Rvb2QgYnkgdGhlDQo+Pj4gc3VibWl0dGVyKSBpcyB0aGF0IHRoZSBSVEMg
aGFzIGFuIGV4dHJhIGRpb2RlIHNvLCBjaGFyZ2luZyB3aWxsIGFsd2F5cw0KPj4+IGVuYWJsZSBh
IGRpb2RlLCBzZWxlY3QgYSByZXNpc3RvciBhbmQgdGhlbiBoYXZlIG9yIG5vdCBhbiBleHRyYSBk
aW9kZS4NCj4+PiBGaWd1cmUyIG9mIHRoZSBNQVgzMTMyOSBkYXRhc2hlZXQgaXMgZ3JlYXQuDQo+
Pj4NCj4+IA0KPj4gVGhhdCBpcyBleGFjdGx5IHdoeSBJIGhhZCAiYWRpLHRyaWNrbGUtZGlvZGUt
ZW5hYmxlIiBwcm9wZXJ0eSBpbiBwcmV2aW91cyBwYXRjaC4NCj4+IFNvIGlmIEkgY2FuJ3QgaGF2
ZSAiYWRpLHRyaWNrbGUtZGlvZGUtZW5hYmxlIiBhbmQgY2FuJ3QgYWRkIGFuIGFkZGl0aW9uYWwg
dmFsdWUNCj4+IHRvICJhdXgtdm9sdGFnZS1jaGFyZ2VhYmxlIiwgSSBhbSBub3Qgc3VyZSBob3cg
dG8gYWRkIHN1cHBvcnQgZm9yIHRoZSBleHRyYQ0KPj4gZGlvZGUgYXQgdGhpcyBwb2ludC4NCj4N
Cj4gQXNrIHRoZSBwZXJzb24gd2hvIGFza2VkIHlvdSB0byByZW1vdmUgYWRpLHRyaWNrbGUtZGlv
ZGUtZW5hYmxlLi4uDQoNClRoYXQgd2FzIHRoZSBwdXJwb3NlLg0KDQo+IEFueXdheSBldmVuIGlm
IHlvdSBkZWNpZGVkIHRvIGdvIHdpdGggc3VjaCBhZHZpc2UsIHRoZSBzb2x1dGlvbiBpcyBub3QN
Cj4gdG8gY3JlYXRlIGJpbmRpbmcgd2hpY2ggZmFpbHMuDQoNCkkgZGlkbid0IHNlZSB0aGF0IGl0
IHdvdWxkIGZhaWwsIHNob3VsZCBoYXZlIGNoZWNrZWQgdGhlIGJpbmRpbmcgd2l0aCB1c2luZw0K
dGhlIHByb3BlcnR5IGluIGV4YW1wbGVzLiBJJ20gc29ycnkgYWJvdXQgdGhhdC4NCg0KQmVzdCBy
ZWdhcmRzLA0KSWJyYWhpbQ0K
