Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC42B5F817E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 02:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJHARS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 20:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiJHARQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 20:17:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCE9BC624
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 17:17:14 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 297Nblgw019859
        for <linux-kernel@vger.kernel.org>; Fri, 7 Oct 2022 17:17:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=ZKw2qVoDR74gWxV9kVGZCh0QLUPqpoyqn9wPUZYhKDU=;
 b=lsi17JxsxLlxXCrdDo6QnvQkRyO24OWfRcrHX/a8bjyixkUKsxx+yfvROkcIneugFpMb
 +pQXWSkvEDxwApUSwPaH53X2PgvRJDIp+yMtlwpKIAWp85U11K/scEIGwz+hNvu5i0Cj
 Kh5oTy4Ff9VhjDcvIyitOn8A3SVxEExjrGI= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by m0001303.ppops.net (PPS) with ESMTPS id 3k244sj52c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 17:17:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdFWwkyPX4sWOxtOg1OxL5GDXi+AjvRZ4I25tSE6OPxLuHqJlc/SFvYUiHxegikwx4N+RKnJtUswPUXdREl7rEXF7LqszRggD4cwMAriLt/IKBAhRDjzu9f85oeJx+VIHoUs/4cXAkHaKeslpi7+AQbqX0HFFvOJnA3r4xO3rpDpFqSdIkUyabM08ggqNOWUAc3aRIgzQNHRUxnV+KU3Mo/etuYwEssvOwzBPET4UhERvxzRM/B9SEB1ee6vGejF1irSsGUkuDZUcuLWWhRNfepYdIFieAITdDhkBOuoXjr2pNz+Zi8FT2e/VV9sccuwlVPg86IOzi1Om9GddSw8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKw2qVoDR74gWxV9kVGZCh0QLUPqpoyqn9wPUZYhKDU=;
 b=E3v8hEojVGGNqgQbj3KCdL2EPsg93xFLlbOvqyu+0eVq5zX51UGctPF27zCw2+s6NDDozhNqHDpAhmxn6lYnS5kNWaecsdf/pUO23aJ0n1fYABX+LpDf+ciaZmE2XvHhkk4cRZlxCo2d/IwN2fw3m8Y74jX1z8NQQo3D51b4E4gADlMF6ik+tHz53I+0w0pIxOfEdGXncpVzFcWeY6bxliDmM2Gjkf789XwHFx0iS1W+gpzTvK/Fd1q803AAWm05n+IaeaZgHzl9+YzsdQQUhEHas2pHfM/6XsK+JToqUEswowTFQlsNeFJbVPuxYP/DSd5EPmeF5FfvewsFPpjFtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM5PR1501MB2056.namprd15.prod.outlook.com (2603:10b6:4:a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sat, 8 Oct
 2022 00:17:10 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537%7]) with mapi id 15.20.5676.028; Sat, 8 Oct 2022
 00:17:10 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Linux-MM <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Kernel Team <Kernel-team@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "urezki@gmail.com" <urezki@gmail.com>
Subject: Re: [RFC v2 0/4] vmalloc_exec for modules and BPF programs
Thread-Topic: [RFC v2 0/4] vmalloc_exec for modules and BPF programs
Thread-Index: AQHY2qb9UHFHCXXpukKxiSq7OlxGX64DoU2A
Date:   Sat, 8 Oct 2022 00:17:10 +0000
Message-ID: <A65B7D94-4115-425F-B296-10393C864EB0@fb.com>
References: <20221007234315.2877365-1-song@kernel.org>
In-Reply-To: <20221007234315.2877365-1-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DM5PR1501MB2056:EE_
x-ms-office365-filtering-correlation-id: 8256dd18-3e55-4bd5-dbf7-08daa8c2714a
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S9i4a7XBwW6DUTELkQ/7s011gSl/lOTL+sPVIyW3cA6kX/YuNJpzQERTTyUqYmYvR9GJ5H0Zc/yw4kEirkSa+xtNds43jmoGlMYJPQexPtlwN/43n9ytIKDTokYnlN4dFUhthvhOck1C3sJncr0woHAZt+8It0kkCPrd/SSrjIkz9OGo12B++ljk9FVxDfY+6IJH4l5R8eXNRHJr+Hm7RBrw1iADj3odDc0CQJgRQ46K1IwmTNSLnU6TrUEQKFPo8vIs840p0xQyz6WWYAv+3RX4dcddLKT3ubv3y7yQSR+tlv1oZbaLZEy8uprV7FAxIEu377N1feAlaRHIsrAjU1+dAybnFUFRD8qz7bJuRTzUa7rjig2g0J29YVNmFHlBb+8u4JX/OEAkd00lnMe7zhOOJSP5VqEawXR71L7I9hx7xn8hNPQNvVBK3fSDAnmM7zrnXGWC1CXCKJs34MPLHoqA64+1jabaoO+HjpvApGZRQzAisxOmL308Pzy8hMy+bd2dYKVEh5/kriujH55D1fXzwilMw8Ydg5GffrVVnp5XgoVEd9rIP9DOgbBlvtVVWyEkj5MahMey0a5LcxiwsaOdY2Fs/t9hV+fgDJai/rThZzQ3y+D5RSmJoxt9QUiuKRUwWRtv7F+dS++d2L2AHDVjht4Mm2z622ZH8xUFOshuiqAOSZlIk6ykhiK/d9mquK+Vb+d3bq4XSY4lFqILwF+3ZvS5qGQPXGny4rO1sW5xGUhvwq3S1u36AXVsMDOM1+cdPKfQC3o6rGxagBemXhqIUKHqmoCLsCDmTExEbDI7feD4QJoDRfjr+XFMP3UKJEpGn/ekKx0qE1/oYrRQTMmH1C0s18WbW/6hCoPU2t1yDoSDLinCwHeZNvVs1WxP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199015)(66476007)(6916009)(66446008)(66556008)(66946007)(8676002)(64756008)(8936002)(38070700005)(33656002)(83380400001)(91956017)(76116006)(54906003)(4326008)(53546011)(41300700001)(36756003)(122000001)(6506007)(478600001)(966005)(6486002)(38100700002)(86362001)(2616005)(2906002)(7416002)(71200400001)(316002)(6512007)(5660300002)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sxu80l7r1B3I8yAv2o09yjG8Dw9b/iHIUxHRUW61hfA/uC7GBe1i5jM5mNo0?=
 =?us-ascii?Q?DNXvW409o/gJRxDpJDdDyWTDvdWLiTxMZPUY9HdiBBk8l5+x6iBwoH73xLCo?=
 =?us-ascii?Q?FhGDnMN/+aHVqBk1WyL4wxZxSjtp3VX1jiusissC8PAkI54qP+Gu1X4qRXIG?=
 =?us-ascii?Q?wMevLzek41yqxltuLgQWNANT8yg2debzmgCrs7UyrqrrgQhJldgQ9GL4arn9?=
 =?us-ascii?Q?v5RSWgpG9ysbIPhTzYsBeVq06+fqwhVkBrE6hvuq3hyht4vaIT6BsSM9J6Tm?=
 =?us-ascii?Q?z/qerSK1nCEXhu/5IVbjsAgetKK6QwRmfj6t28fyu5DKC3x+RePCdji1RfbN?=
 =?us-ascii?Q?6Fwof6IWDBGoy4NAghNHpMQUlkxFQBlvs8tE+cpm+LQQANbG+cELDiY0OBTA?=
 =?us-ascii?Q?r2bz4sZx2AwHtUdvCrprPmLek5gHA5khfhRnIrxZy5sKM97mtasOUX2nAxkL?=
 =?us-ascii?Q?X+5FwHh6ggB2vY4ZvUxDVW3tylLbo2Id570gxsX2/54ls6ZmCGAD0nTVBx31?=
 =?us-ascii?Q?5ZmCbzOj1UxnQGBnxd09NbcXhyPzpJcInpQgu22H3zZPRTXDFl/fb9LKVWWd?=
 =?us-ascii?Q?c9qaEqip5vwnWwaLVpiZdyCsL/CFX2dfzHvl9irPVETgCKkfkH1j3gKFCiwh?=
 =?us-ascii?Q?14OxTqrEzCn7u4xpjKXxwsFBVD5IP8+WPQN6QkRzdKR+8PSgvTHlIN2QPul8?=
 =?us-ascii?Q?F4E++m5S4MxDn8a8Q6A7RNST6XOlCgn9HKXyLJaK542xNXsJGtxAqF0hwows?=
 =?us-ascii?Q?I819HTXJZ3xD9IxBBGH/wCjAR0y1lMJT92tGSl5QVeetYoKct8bleZOvBFS5?=
 =?us-ascii?Q?Fq4+QkVnVO00hYyveUBT2JbsY+iiIgvePaThlFMOcC6lU/Tk4sHwYNhfo+Ik?=
 =?us-ascii?Q?aTYkcUXH9UchnvjrCV/XwPoADcqHvpQyYI27vdjOGA620dysvX4AsU+dJnkC?=
 =?us-ascii?Q?0GqwZOkXrg12xJZcJYz0prS5aGE0RIsDV7j9HNyphPD7Y8hUG+6UlJa/Zug0?=
 =?us-ascii?Q?R3BhvY7CFThcEKOQU+ne1Pf58uvlVjeaMASdMQKtkRiRnUTg8iWnJ8ReI7fq?=
 =?us-ascii?Q?s0qQFT8ZsSboB/DvVqTzPucb0ZwBbnia77FAxMQ7aMfFMG2oSWqaaJY2/CYL?=
 =?us-ascii?Q?UDto54+v7p/x0KmFSXUQ/NGgujvjmVxaI88Di/ilIFKACN0mhWfDVY7eU08r?=
 =?us-ascii?Q?FC6Q0hA4GgmsSfRvKW2Fpp1jtCjV2WXilYJxCb9+tuX86HHSyEt85y6wViFj?=
 =?us-ascii?Q?UXoPzsaWQrgBEjFK4OLhE5lVYH+IB831YTr2lXR1AJ+tlOEpnbQb2tMSNKIB?=
 =?us-ascii?Q?5I9FEeAVA+k/66yXKNBuVLs4c3B5dt+4A97wxMVhwrcwzerId3VtJSoIl7es?=
 =?us-ascii?Q?En2rK2gnfYZUqXLj3/ZISQWZPqLbKE+X2TMsF4paYkeMkN3rtvBhXeN33Cd2?=
 =?us-ascii?Q?KakQ84hcZP3c0CIgHo/ID8znE4vjCDI/uCUgLHtZoTQqjsp6GxqJKXdUbM8o?=
 =?us-ascii?Q?nhYvhYqDhGGjnliufNAoAXHu9BXPFu5tFSXNQuEGJMSCNFIsDmqoLOWQ2rcf?=
 =?us-ascii?Q?eT8G/mmfeuxYBOUn2u3FjmrdZFJBWX6i/EXFRLBAhmqODZhNIwAheSyvjOvy?=
 =?us-ascii?Q?+3EiC1n6MnSbWMdZA6WEORQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <94DBA13C9ECAD64A83C86A407942E840@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8256dd18-3e55-4bd5-dbf7-08daa8c2714a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2022 00:17:10.3886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhprLaor4MrhgwggpryxhbGW2ceqymO26aXQBkJoKiv8VP4Ugkm/Ry1RIuNM5yhZOIF8mP08C+g5PiVtSu5fZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB2056
X-Proofpoint-GUID: 3WQAoUNqclpTYSe11nXbZqNOUS5QG-hg
X-Proofpoint-ORIG-GUID: 3WQAoUNqclpTYSe11nXbZqNOUS5QG-hg
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+ Luis.
> On Oct 7, 2022, at 4:43 PM, Song Liu <song@kernel.org> wrote:
> 
> Changes RFC v1 => RFC v2:
> 1. Major rewrite of the logic of vmalloc_exec and vfree_exec. They now
>   work fine with BPF programs (patch 1, 2, 4). But module side (patch 3)
>   still need some work.
> 
> This set is a prototype that allows dynamic kernel text (modules, bpf
> programs, various trampolines, etc.) to share huge pages. The idea is
> similar to Peter's suggestion in [1]. Please refer to each patch for
> more detais.
> 
> The ultimate goal is to only host kernel text in 2MB pages (for x86_64).
> 
> Please share your comments on this.
> 
> Thanks!
> 
> [1] https://lore.kernel.org/bpf/Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net/
> [2] RFC v1: https://lore.kernel.org/linux-mm/20220818224218.2399791-3-song@kernel.org/T/
> 
> Song Liu (4):
>  vmalloc: introduce vmalloc_exec and vfree_exec
>  bpf: use vmalloc_exec
>  modules, x86: use vmalloc_exec for module core
>  vmalloc_exec: share a huge page with kernel text
> 
> arch/x86/Kconfig              |   1 +
> arch/x86/kernel/alternative.c |  30 +++-
> arch/x86/kernel/module.c      |   1 +
> arch/x86/mm/init_64.c         |   3 +-
> include/linux/vmalloc.h       |   2 +
> kernel/bpf/core.c             | 155 ++----------------
> kernel/module/main.c          |  23 +--
> kernel/module/strict_rwx.c    |   3 -
> kernel/trace/ftrace.c         |   3 +-
> mm/nommu.c                    |   7 +
> mm/vmalloc.c                  | 296 ++++++++++++++++++++++++++++++++++
> 11 files changed, 358 insertions(+), 166 deletions(-)
> 
> --
> 2.30.2

