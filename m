Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3285FCB42
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJLTDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJLTDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:03:33 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014482CC97
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:03:32 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CG6osa001164
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:03:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=S8uSN+CK0hYG1w8JW99WZ2GPBygGpQJokwCSXexJGJo=;
 b=mLrda47PeJJunjKxdRuweCnb/ltV2+KNZfe49LF3drJJ8x5rCJp8ck2OS6CiXWkOEjdN
 iAVgiHE9k7zuHgDOBeWN//C3ROKDWjpY1u92IY92cTGcyieOCmGI/PGtLLJGbXiFzvhb
 h/6/3Ir0hLLe4kI7M6cKJwx0+lRIrZnXvULPDfznmSn24WN+pBD+82A6KxIb/fyo1uph
 YADN5WfLcvgLKwHpfeNI/Pii0TTJ9VX4Sw7I10hbtOpabZaDs2kCJDN3+3JzdnHZ3mr3
 /6AUDzLEmZCHEBZNJzW9jAUEDz67as2yD1WyDCmW28cNaUSfoYYYNcZLnEP5hD649Yop iQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k5qdce02m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:03:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrGZB6ds9A3xtJalCHRF3YBfhvINq2zmBv7niUTHsBw3eD0rkp5rRNM7m3S2RMHQLuHOqwk5C9efLM7pwb7HkxPQGWX/mjNv4K96hSpKbv8Mj0rcdY+4V9+ePHRcU+cDZ8BagIe6Ceo6romtiIO3Kr4oHU1S07sdVlKLFt3p15RnzFq05MnfGp0QY7CJs3srFS2YK89A1AxVuo84N7EpjD+XkwdrMKE16sCySBwJizpPxmcV9AadHJK8WZnlHW57a+c15Kc+Lxtxn0w6Ep1vNimaz3hmEjUD282jbu4dc7/fiL4w/Wx00DZxovC2EsWqnPmJG2m5QQge+eGILxXajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8uSN+CK0hYG1w8JW99WZ2GPBygGpQJokwCSXexJGJo=;
 b=FV9O8BAvc6vQRb6PPcRzgMWH1Ac/MMB5eclx1FcUCPQRlqUuss077sss53iP3nlVRFWpNlp8Xm0wg0PkcqjC8/FedCMYVPx8chsFUC49aX/Vzt2o0FkjX2i40WFje4BCTif1iH70sr57fHo5lIUOfKUKVAsrFLjzaYf8wvQLVljjDxbt/ew2GN2h4iyIEdb1AQg776NTZWiWB5hbWndk8ezaWsMSJUvC3v2nHlmjTkl3/aHqMl6P3WPlqtdvg1qVG987QOeRT1dLovBbTz4dxbLWdFw6CpHNLtr9fnE3qpZp5X4ShvYnNqckYLPT68hP3XXY52u9z45+tLEGge1fbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BN8PR15MB3075.namprd15.prod.outlook.com (2603:10b6:408:89::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 19:03:28 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537%6]) with mapi id 15.20.5709.022; Wed, 12 Oct 2022
 19:03:28 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Linux-MM <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Kernel Team <Kernel-team@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Song Liu <song@kernel.org>
Subject: Re: [RFC v2 0/4] vmalloc_exec for modules and BPF programs
Thread-Topic: [RFC v2 0/4] vmalloc_exec for modules and BPF programs
Thread-Index: AQHY2qb9UHFHCXXpukKxiSq7OlxGX64LJVCA
Date:   Wed, 12 Oct 2022 19:03:28 +0000
Message-ID: <C7D06958-F806-4F73-9825-22B373E6B479@fb.com>
References: <20221007234315.2877365-1-song@kernel.org>
In-Reply-To: <20221007234315.2877365-1-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|BN8PR15MB3075:EE_
x-ms-office365-filtering-correlation-id: 19babc02-8f59-4bad-502d-08daac84725f
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: elaNoFZuztlgDtLi7m/7pckq9OSuqhJ/6FVsCgjB/Ma1o1D6qN4wygtJw+rJ1jrf8zmBLvZ4vAS7lcBDcSyV1hziGLgYvEwms89Snj/Y7FSRN0DHEqzwR/Dgzehugr1bluPJNDG8sFov0eQ/TDWl9kJtUxmD84wMLGyqjs9771CE3dA3kQQuaAStUjQs9bMLG6cSSruaLdp/jt4g6NDj0ScbqM1iCh8S5MlrJ+jxZLwYoHL18iKPUhg716WumMtAPU2mKXLj5uagoBOGM7m1yHlnAZyQSVToKH3c8OpYUB35/E+wFb3/2nJqfobzyL0xOo1BRm+HVmOBFStS8L1QakzBOA8K0nRJvvIkqcx1Pw7BaA4VtaHJED2V7rul3QeA8zkfRYUtRsuIWkdneb7PAEoWQ+rxkAH1BYmHXCAP1DnazZgCixvEOsoBh6BjNqDa5/098dxFOs8zS0gKsbybKBuM7txKaraVpgssc2iipgRRegbsnG+tSo5jdyNDNTO7HzLAOr5Zqpze7fLSm+dVsg+zJq1/Ub/YTaTthpH6o6tXTL9YGa18tYxUrQZ/ajK+huCxUUOQsQrUHT6mOYZryTe5oFe5f5Pra+8oplUJlIm55wgS1FFpHMJsW5wq7z+18FbOSoDHJ2fBLf6xWw5lIs4O189vbHTKiu4ZznH4PM/PHpMLjo4M9aBDp3KtxnWzEOPlerfnkRPQ1HJwmrpDu300nWnwn1KIa/AZOKRAVycGA9GdpFnkWmVeNNN4XNEFBKk7qOs+lpI1pimp7sjknTHWeCX3kR1cBu3/QdU/BKM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199015)(6512007)(53546011)(6506007)(6486002)(966005)(38100700002)(478600001)(38070700005)(83380400001)(71200400001)(36756003)(186003)(2906002)(41300700001)(4326008)(64756008)(54906003)(8676002)(9686003)(6916009)(76116006)(66946007)(5660300002)(91956017)(122000001)(66446008)(316002)(7416002)(66476007)(66556008)(8936002)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7glwAvk/7K+ECh5pKmZidQBwnbijIhfzxYI8cFyETMX6pSOvM5pHxOfugTzZ?=
 =?us-ascii?Q?PZWS8FxUGXQM+paGgCMrovCIIwAvtBFQk/B0EtQejhqfkUrtzFqHX65tLAqT?=
 =?us-ascii?Q?HBA/AaviIcHeAIUZgMaTmzlg3UKd5J4cyQpkx06F74EQHKQah7xgn8OPPmZ1?=
 =?us-ascii?Q?4eCw2Ndlm/hddyTpLrALnEQOqHSg8ZLBf6ald+a1bmy+J0V3TNKHqqIURFtK?=
 =?us-ascii?Q?DHVtUNsuEPo3QPoudtnqkr8S1/5YVEoSeRiGI3rFZatZDBVe51oWxY4V7Gi4?=
 =?us-ascii?Q?T2ZP5/OcwNoyfsW25s839FwonGsTq3khsfagGwpOrSkdOx8l2FMDzpmYT/TX?=
 =?us-ascii?Q?ixdTEHE+y5VEtsgqbfzfNBopwAYH1z2B5w4l6OR1m3P0FO35F/EhN/lxwcLu?=
 =?us-ascii?Q?JJQbSP+oFEKUEqHTt2mhoQY2ZJlXE2UJJDN2lRTYq+CYEwAU+RLRA+o/LrHZ?=
 =?us-ascii?Q?lqbN+npnfzi9etyUJM6YWzspeXGbvoyzUlIAlEES4IKGeEojLV2H9n2UcfJu?=
 =?us-ascii?Q?sDEBtttBV+uuaQ3HF64RPylRKYX8hkwcfMioVTttvsIo1ZQfgxMiPIG7Z9cS?=
 =?us-ascii?Q?RRYV7RWgQ0/Qrblmk+av9HCs4G3qYjMB4NRc/G1FKyftAoqOwzofogsiMzIz?=
 =?us-ascii?Q?MdRDVbKn2S4J6sZ3ryQ8tRTBz8t5kst4s8BJi2vagyrcLN2xaCZHo/+ngwX2?=
 =?us-ascii?Q?w75qkdbk7dPDYUG5FwrGvHP9JQKgZZyW/goYOerLyaz4AxI7yMSRn0lVsL9u?=
 =?us-ascii?Q?7NvjhJIJj5P0CwWo43ux7791KWIAo/Eod7k+4/urIjdI4kgfIf++/11UWXhv?=
 =?us-ascii?Q?VJcepGSh8sw/cU5LqW4NwZ/EeEIMlnjFHlDmg31N+ZVyn02Tv7cmeuwQyg9c?=
 =?us-ascii?Q?ybGsc2Y6lPdkAnxOZp3gSvtmQ+5F/5ZWSndJ5EAwXJhT9IACXCz6ObqfTuh7?=
 =?us-ascii?Q?0/pKk7iTcbJAQwSbuh4ZoyRp0zw70zcW2JVRZpTVfsfkOX7vZN0B1zGdZgbY?=
 =?us-ascii?Q?WRDXbAVxiqmRz/olcM63oc+erESISkqM+JWC2WO9iBtfK/T/yVKKfuv8WVqm?=
 =?us-ascii?Q?gin9h5OR9CVso7U0HDawnrfG0uBnnKddpAUFcl8f8CTV3/Igep1jriCUSeGs?=
 =?us-ascii?Q?vFntbq6TYkbR+gU/2+wOi0LGQQKeNCX12DggYvczE2vYD5mLYifpt/kXPonu?=
 =?us-ascii?Q?GLGu+JssdDWLdbTGdI3LwALFNG0Uk7lgmBGQJvsaC44CY8qhlGs9gsScsRlL?=
 =?us-ascii?Q?RnvrMKu2ymSXDpA9A+I5Tn1XHktU05nLlrCI1Ah0/cwmFjV7Bsc0DwY1Yxkm?=
 =?us-ascii?Q?weFqA8pbuzaZCnFnXoAv+h6BNU2VrPlk4DoAiz5CKol2M/4NSBVFdZpBFA59?=
 =?us-ascii?Q?YBwsU2IFzOA8zlnV/t2LtBDp8zFmO1HJhIw94ZRDyZlNBdkRsvalS4QqBekf?=
 =?us-ascii?Q?mAEtZSkHJHmDF86htuyWgQpMuPcu6HCJsMSyCFyxzbKGvkjossiwPj+RWmgk?=
 =?us-ascii?Q?kSJvnB57oikPvg5aN2KULEZ+r+iD3AnMcQj7Xki+BmhwBQ71bQxn0CODc9Y9?=
 =?us-ascii?Q?zRtj1m6d5HmZkTrvcWJpc3bg+typOed8BD+/VO6J/5siU3hgwW4XLYNwb+NX?=
 =?us-ascii?Q?ROpxezkAf6PC4iu9rajiQslisudYM5i8sA5Q6tcNbKDa?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9C488785E488684480CEC36D3531335D@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19babc02-8f59-4bad-502d-08daac84725f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 19:03:28.0543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9ODRE408C9gTmi92D9/cfvOmEYfuXBlrAF4/Shuz25NbuPdWbcpASDJA0xLUxpqr+KJwxhe/MhKTt4lI+aFaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3075
X-Proofpoint-GUID: SgSi2JcgtYVPFbnC08oF9JH3ZfclSyNN
X-Proofpoint-ORIG-GUID: SgSi2JcgtYVPFbnC08oF9JH3ZfclSyNN
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_09,2022-10-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

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

Could you please share your comments on this version? Is this the 
right direction to move this work?

Thanks,
Song

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

