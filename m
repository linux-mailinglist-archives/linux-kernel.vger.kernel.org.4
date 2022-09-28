Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135FB5EE1BD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiI1QXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbiI1QWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:22:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36112E6DE9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:22:39 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SA8bhs000802
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:22:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=XUJmyCi0B3H+vL2e0NDxdiHnxd7q0zFClWiHQIU4DGk=;
 b=Zbb8P8DsewPZjPFe6Mu015maHObVAdlGoksqRfFbjX8CIvMn2J2pFEewOz1uHHSyVAEH
 gwtV1TSGv+ZYG4ihihdx1aIWLEQfmHnNf6pxnI8qjliV3GLGf+xayEri34eoeg9KVTYq
 huCOd+opiNqTsiVxnBeaj9RYR2Z9Yp3dBoo= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jvg973kxr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:22:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWp+zIJlhtOsN4wWSjX5zlJefib76KgqXjmqeY/o60y+FltsfZcz7ikdYIMjNfX6Ig1HkVUGabDY3GQI91UdkoIBNz+475K63K46KVsye7XbUJBN/dEUgykPQ8hx7M0kzO+QsHAae+DJFPlbcVEEAK8kgwgXLSAMsP/k2Q6QTgwr/U6gNG9L+0/BhAwednENasI6rRWwS88777NDyh7H5CC2hJxW1/WFOCOnGyGXtMn1nbs/Q38Mqswa1RVVWCrfO5bFJM5hVy9WBsPol1s3IIj1f4KaYgQycdAeIJ6x4miN9A9U2Wt4Dan3GN+AJ1xUvixpRlbn5njCMH8mBwPuVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUJmyCi0B3H+vL2e0NDxdiHnxd7q0zFClWiHQIU4DGk=;
 b=aJ4E075RI9ooUr5F4DVD2Cqb5YcHaV6xVJwzhM1/igu2KQGFYVacBpt/BEi68j1fZoUc5olQo6Mc9VTpLFQofU0Rg68DXt+HkWjPGHdWYVhWBXgSrDjluxlvgpYF0JHODB3nQZduydiyAtJgPP7pV2eCipKVAcIC5E5iWxlu2E2EtqHNe09AOw+//TOZYpLa0bf+yEhTprWvOWubQRGd7Rg9H1WmPLbQmeWngxizhZQMQZHU7MLq3v4dODj0eM1oLxlEPEujP9g7QhPCWrqo+CrbU6HFZBbLUQ4VLdLowsU+C5t487SfXXcUXS5LxkAahpe3XaDNyuIcfe1WBHNJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CY4PR15MB1734.namprd15.prod.outlook.com (2603:10b6:910:19::14)
 by BYAPR15MB3430.namprd15.prod.outlook.com (2603:10b6:a03:107::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 16:22:35 +0000
Received: from CY4PR15MB1734.namprd15.prod.outlook.com
 ([fe80::fc7c:15c:9a61:e445]) by CY4PR15MB1734.namprd15.prod.outlook.com
 ([fe80::fc7c:15c:9a61:e445%12]) with mapi id 15.20.5654.026; Wed, 28 Sep 2022
 16:22:34 +0000
From:   "Alex Zhu (Kernel)" <alexlzhu@fb.com>
To:     David Hildenbrand <david@redhat.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "riel@surriel.com" <riel@surriel.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 0/3] THP Shrinker
Thread-Topic: [PATCH 0/3] THP Shrinker
Thread-Index: AQHY0wWiHnM2ldg5NkO9z8Pn4WWMYa305SCAgAAh24A=
Date:   Wed, 28 Sep 2022 16:22:34 +0000
Message-ID: <73C02F96-49C7-4C1F-AF10-F6A61F1D68A4@fb.com>
References: <cover.1664347167.git.alexlzhu@fb.com>
 <c4462af8-80a5-6cb6-8bfc-0e7ff1da6856@redhat.com>
In-Reply-To: <c4462af8-80a5-6cb6-8bfc-0e7ff1da6856@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR15MB1734:EE_|BYAPR15MB3430:EE_
x-ms-office365-filtering-correlation-id: 62360618-bfe1-4cee-16a9-08daa16da6d3
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NgLsJnYB/m+V2Yvl1rX9d59GByjbUhKT1CKTBEQe/VogVWDFBm3xlVbuBCzm348TnlkcLlDE5jIMTOrMIB+lznYg9IgukL7h0cMeA/xpSHflQqE0RXvoxcK4l05PkaW6UebI94uXr6LyKfwXox8ajijnH6xoGRPuogJLHolUVAERKHTFXPHb/coIGOL0Fn6FOVR07nM9UB5vttFhRj4xu9iY2HTRipA8PGSSsIEPERUaOaafHf7BzUHz2UBUqxYcHgtMTj2za25G6MiPHc2CEW0jXz3smrO201UUCw5Qh95uXTKuUltjXquCZmu/DyvbHHoF3FOplOYd64LMk+qwZLicNrv1imObjZZpKYrdsLCKdwLCMPhzfmM5hELCrLcLJ/wruwwvYoT9xMS53N0A8qKoHb0NZ3ToihYawmXiUNfQAO/XwSD3lrrsm8VEomYX2BzE/dFEV3j1gs76RacG1MJRKL/3Zm8BKLLWGRDJp9tLpxcUlLyyZwP/T4n0vVj5kVdKVW9/wP5AypC/gUs23Zg3/1/Art4DluecywHUjzS24Vce8UZRDrV+KSSh+Hz1OoobtewNzONdVIrLQ/Z1EwHxpWip0QUEnPscuYAZemWNVyT8uKbQUDCDP6fEPZVgtL/d7YK6iDna7MFaf1hxmHyZO6qGww3R9iXJCOjK/CbQI31EG/NUOFRBWe8FzeXShBguPTqNuLiem1jg/FW56yIbJ8iH+x8ho77jE+WMXOHPzmDdOY2zjvw4dad0O4YGpphEf78c4KPGW759fK4Ri2MBnpJ+iUXShQW0PdsYUno=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR15MB1734.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199015)(36756003)(41300700001)(186003)(6512007)(2906002)(6506007)(8936002)(2616005)(122000001)(38100700002)(5660300002)(38070700005)(6916009)(83380400001)(86362001)(33656002)(54906003)(6486002)(71200400001)(478600001)(4326008)(316002)(8676002)(66446008)(76116006)(66556008)(64756008)(66476007)(91956017)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KYqxgSEZKY+ITuoS2uqORK4VmhkXjojfcJs6yO99aDXz9Xk2iQ8ueE4In9l+?=
 =?us-ascii?Q?eWwyQFPa335Q9TVGSJ9Q7q6H5mFoJpIol9rTubgkrum4kgIrwqc1FdUZ8NN4?=
 =?us-ascii?Q?o6aHgxwVrenN8USTnWLzM6OrRSMxWdRpJoHgQTlcoW7wgJt/AHZFs5ULYJis?=
 =?us-ascii?Q?vU3zfh5etza79A/NoRuGLVe01AosomhNHLXl1ylsxbJ7+q+R1IAuxO9Xdoxu?=
 =?us-ascii?Q?JlzIarEz98YslcOvRFXFigWiU65nP9kjxe5c8X9q2uL2Zd6buGqjAp1Xbp4B?=
 =?us-ascii?Q?buomHeV6c+0ciM+KUF4GpruAhwEkn45RP28lV5qhwOeMWZEzprrKeV3504Ul?=
 =?us-ascii?Q?Cxz6PYtZmHnkYHR10CCB2G3yS5JNFIu7mOYoEBBX3NW0j5J8Ag1O4kSQiZm9?=
 =?us-ascii?Q?5ASWmj+OwO8XU0zMQAyiqmtXZSKZUKwvoS1wsSZfElp3371R1K39z1kjkf6O?=
 =?us-ascii?Q?CTbnN9gTI60/d4mmpR9yd/OZrujRb2kR2NlvJCc24VGtWk4vIZ4KKIsHdH0X?=
 =?us-ascii?Q?V9LLABxgD9+fHeVcMF8Hjc6xaHW9yNNoQFGvA3Yll+7VBiMQUdPASr64Fgvd?=
 =?us-ascii?Q?EFwvwZdRQMEvOtX443bKKX/Rak8rLFweENkiq8DxR8pSSFL5sXupimxlih32?=
 =?us-ascii?Q?AYsmpAv8lc7GRUJeF5A5+SZdB2Whk5DJD8c8Ir5jBT7UbZXV9Rh/78kyo3vB?=
 =?us-ascii?Q?HOK7YAxpLw1VMuYW1Hh/T0Nx7f+d4ZA6jxxmknKvNR3pb8bxl9ybS3iQEAg8?=
 =?us-ascii?Q?UJEzj/Ou7NjfDRIc7JRe5KHaKbp5E1ncA1dMFKsUsFyuznxtgRX+RXpMIuE7?=
 =?us-ascii?Q?hVq2VpwT8wjMJw9FoC5FSY39dakmpw8oEEjI788yXT8le/FTBB/t0VuCnW1B?=
 =?us-ascii?Q?27YYxgSQZyvK420RmNaxyHrrU4RnvdjjXxrxVxHN3+TIkZhJ+sUik8rdimwm?=
 =?us-ascii?Q?t4qHG05s9ZRv4a4hySPMvgohKn5mmxKdCGK2+bb+QQ42ttMXDPNLaPJb1RDL?=
 =?us-ascii?Q?6iBt5nhe1TbmLObJt3i4i8UN+vZbwTzhD4LmTDYR4hzhf1FwfVYvn486l7qY?=
 =?us-ascii?Q?eFSEwVnbjmwrlxQXSsKlwevcwn7Y/AKYZw3nxe9O5/gI1tPZrmLfaUk0st1V?=
 =?us-ascii?Q?cS9pZqd1GO8txX4iFkP11rrpTHfA/wlrR//JIg+VVg5WP9W20v2MqDo8kO6M?=
 =?us-ascii?Q?Nu/t4gF5XDre/QVXlc8WgRH/8FY22DxyexyJ41y9ud3JyquWXAxlKEy6ze85?=
 =?us-ascii?Q?S8j+r+EYhZZwcRAQrbdzS4rwCfDHICjZlgtMQma+DEDNR9F6sbGtR7AKwREu?=
 =?us-ascii?Q?jsqPbjhU1Si4TW+kc8BdWQxidUl7oyrJZDCxUGCvrMG+QJyehcsekqsnuj/4?=
 =?us-ascii?Q?GGWkuIOnraiGujbTwM9fRwRWxtazGh8FuKNHorJ4sBRSpptLSxhaR+AR/Jd3?=
 =?us-ascii?Q?/O5IQul9UMernV8h/83jJ/LdeVyGigX0JPTgjh70EfQqOmnQRqtwGVnWQODR?=
 =?us-ascii?Q?OUFQod9CMUSj1cfXCP0VaXBuHEw9C9MZlpXWstFvreZiwqlPKIui/az6YVN0?=
 =?us-ascii?Q?p3Sw7t9a9DmBTkhd6LjVb75KgmaaWf9efrCUsn7aYF7it+LcShP6mFcDbFn5?=
 =?us-ascii?Q?UI3h/luUlY24srVW98rVhBQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F94155F438281F409E5BAEE71169560A@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR15MB1734.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62360618-bfe1-4cee-16a9-08daa16da6d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 16:22:34.8549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ijjixC0bEqff9kYqplGacedvUkifzWM51/1lH8G9PHJbl2d4212F1wUd7VxMjLxn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3430
X-Proofpoint-GUID: i4W5bj3yOKBhNd5WIywyArZSM4PY4r5t
X-Proofpoint-ORIG-GUID: i4W5bj3yOKBhNd5WIywyArZSM4PY4r5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_07,2022-09-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about that. The diff to the RFC:

-Remove all THPs that are not in the top utilization bucket. This is what we have found to perform the best in production testing, we have found that there are an almost trivial number of THPs in the middle range of buckets that account for most of the memory waste. 

-Added check for THP utilization prior to split_huge_page for the THP Shrinker. This is to account for THPs that move to the top bucket, but were underutilized at the time they were added to the list_lru. 

-Refactored out the code to obtain the thp_utilization_bucket, as that now has to be used in multiple places.

-Multiply the shrink_count and scan_count by HPAGE_PMD_NR. This is because a THP is 512 pages, and should count as 512 objects in reclaim. This way reclaim is triggered at a more appropriate frequency than in the RFC. 

-Added support to map to the read only zero page when splitting a THP registered with userfaultfd. Also added a self test to verify that this is working. 

-Only trigger the unmap_clean/zap in split_huge_page on anonymous THPs. We cannot zap zero pages for file THPs.

Thanks,
Alex

