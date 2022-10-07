Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0C95F7455
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 08:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJGGrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJGGq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:46:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAD41176E4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 23:46:52 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296NpEVs010640
        for <linux-kernel@vger.kernel.org>; Thu, 6 Oct 2022 23:46:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=s+oteeFylaX6hdkR+09jlECBODKtiznSrd18oBuf8b8=;
 b=FDgaI1H9NHP76kmzS7qOREdOhpScoUQS6hDMLoDn3WKogPPbib5ptXVwaOwCyiRewujg
 Y4pVnUTVnVs8T/tAOVHpy/TlNiywkwI2NPqHuhTYfyob81RSj2HLplMt9oT+/44yvKhU
 RgzEF+DnabbU6e2B+LESkUrJW7ew2EU03xE= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k1mng1g8n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 23:46:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ir16g6S67wkh6llB190L3brQ1POYAI7iWMkRHucj3+XPuw1LNaYynWSTeYNQcT2giVM3CTCk97eGwn4TseLLXr1N7YISjGkS36d06Tvugk1LyFtghHkAe7rXS7fYxDxyYt6/ourvgAVzOUG2sQPYXyvBiMDv7Ke6FvJPMMXC+HfOECkHaaZmCRoXtNUir2l8QvX/zHbMYVReM2QhqezkKaBVv2+iB/+yr9InKrCwK6XviI8M0rqOcTYgAMrzOStfNDcm8qCnzb+DL0p9432gQ7TfRWRwhmsaFCbrWPL/unsMA4PJ0GM3JDW4gtu4cOfjz1SexdPr3X6NZfvTyc+olQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+oteeFylaX6hdkR+09jlECBODKtiznSrd18oBuf8b8=;
 b=MPwW+iOtei0RUc1QUJlLlUemzLDF24getefKpnanq2EZ1NBiTzjNYJ+2OnYj2Kxwuqmfno1/19h9KTRH6uhYbj8iApfjQ74k4/rVm075/clY8qtVu/3HTZtwT2N5a7CZ09FlzpSoI9Mo69QVNDN8cJpF6/04tmKf/ML97iUqyhswfHt1/aT/f2ekE6oO8DZ+2pDsSeBztqXF4YEP1/lfSBFlrrdXMUq7ns/4gph5D5qynTNBsKqOZNd4nnARijnLz28qrhLXiXo6IRtFVOkG981fx/qpH4SiU9i9/6tiYVRqXKXaOLXi3UUx9PxWGTftT4psTK20uuru3h6/yFGVEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB3020.namprd15.prod.outlook.com (2603:10b6:5:140::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Fri, 7 Oct
 2022 06:46:49 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537%7]) with mapi id 15.20.5676.028; Fri, 7 Oct 2022
 06:46:49 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Song Liu <song@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hch@lst.de" <hch@lst.de>, Kernel Team <Kernel-team@fb.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Subject: Re: [RFC 3/5] modules, x86: use vmalloc_exec for module core
Thread-Topic: [RFC 3/5] modules, x86: use vmalloc_exec for module core
Thread-Index: AQHYs1V2zJdM19sU5USbQ1Rz1fxRya4CUs0AgAB3rQA=
Date:   Fri, 7 Oct 2022 06:46:49 +0000
Message-ID: <2063847A-42D6-4A26-992F-0DD32A5E1F05@fb.com>
References: <20220818224218.2399791-1-song@kernel.org>
 <20220818224218.2399791-4-song@kernel.org>
 <Yz9m9N9qG2OOdyPy@bombadil.infradead.org>
In-Reply-To: <Yz9m9N9qG2OOdyPy@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DM6PR15MB3020:EE_
x-ms-office365-filtering-correlation-id: c4cb2da9-296b-4c87-4a4e-08daa82fb5ce
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l9gyKbiVVkrDgAyrIiMQu3/STFN2vFAyVnwb0z1OLuoSvxirhajuM5Fe0Jt+CUmwfEIZxQIF1FwkTJZvGa7RifwV+VnLmGsGRgODJiPDYnxdqSDlez85x2I17RSPHIBYXmA6h5WlAEvRbN+bfsjr7g325M843SKaS8vOZHhCAJNp5zIQwlVA4ubhv8JQQn7ODUrIRUTRoCGelbTqAIkfL50oMtbpYc5IH3fBwxuj/9sZRlE71y0TXHok7pg/P7WrhTnnwQL8d3Fjr54AsRz1jhLQdlfw/M42K9n+xLGn6dZKoku0RmSYM99ezzgHDu1fKcisOxNeX6UAsyUgCbJX3JBc31u7l73ludWXgAZYarCKwZQeqqdMjd54W4PDlBBpwodR5iL4Ta+250f5XPGoaFTCVbYyhRyERZ29BbnXwj3WqCZ3dRoO9Z3Vpo7Tj3fmkbIDMZi/4gL7HAWSJo0RrtNYLJ6uKZBsXqZsuDQCjbvzs9ze4L/4pXaa2r4Vp/0MGNtVldMtTl2iqxeZObTOMVr8jc48ltF6tgPLO01gBz9pMayu3pvdkUGeuczaifRj0JFhPASMzQDmRVh4LtcMjRdHupZFdFLgkeYYIhjCh7wVuwjzaJBqJofnmSH2SNfzfu0XRerr5JTphBLwR35OeKeEmoqSq6OXJ8oMndmJPvSZWG7G5W2KyiGVtDbnCAlw/aCn9Z/2CpW7N6ExAgg3fBLY8JQoqhWIod9Wj/wu4+m5YAw2oPIyxZoWUxo59NNu8axm6QMbFDaFkR2Z6ZDffdZ/8c2UjAl7q0AW54iXcNc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199015)(86362001)(6486002)(186003)(316002)(54906003)(71200400001)(478600001)(6916009)(2906002)(4326008)(66446008)(66556008)(66946007)(76116006)(64756008)(66476007)(8676002)(41300700001)(91956017)(53546011)(6506007)(5660300002)(6512007)(8936002)(38100700002)(4744005)(83380400001)(122000001)(36756003)(38070700005)(33656002)(2616005)(7416002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jN0+mEkxACYadB6MXiro4zeJyjrdmvs4WSRs288Epjngo41bEYPO2DN6U7dz?=
 =?us-ascii?Q?iDeL9p6wCngy/CnetjQPmOKzTAjA7tCA99w1gCHI3Q7sSrWLCWSAVbKjBa/l?=
 =?us-ascii?Q?BXdnhYWKhT+jNZx26h1bPHAp9LCQ04vGLLKStkVjjFOnhm+/r6Am3mZEyG/t?=
 =?us-ascii?Q?ywqgYqrDqxMcxYsAMI1xfvZF1ufuTH/ALPop9Wr/1ZW9E0o7YZbx5y7HmrD0?=
 =?us-ascii?Q?ckF/gcv1IgTpzuOcyb268NLIzo++R9LTvY66O/zarJ8iwvfFHia05zWCTCnC?=
 =?us-ascii?Q?5gYZr0nFlhyEqQnuJwUUOyYvB3DUJfpi9yRxSiufSxC+stTN1I/a4bC2/PTL?=
 =?us-ascii?Q?kfO9WkrVFPMc9TFIv3IgqHwXlQyqRLsAiXpvoZbum5e6+Xd/aXDtdv6Gci+3?=
 =?us-ascii?Q?Yy6/zowLgtxopIV9Y6mXUrOqFKhpDeDPvFLKYKlX/0E9kpVIusCG7xPqEzk9?=
 =?us-ascii?Q?UEqW+37pu3El2jndPrj1haJXQEJqAe/sdffhsyRumxwv2cTZxBeUB9csNyei?=
 =?us-ascii?Q?y8luDTgN9RbcTRPMYTngJBi9YY4REoql/8wFWLd7hwC3XbAAv0gVPGBHL9yz?=
 =?us-ascii?Q?5CGQtHi9Iz1UG13pBQ1qPXEUmKRwY/xXcRj63nUqKnyulgjbhvdE6kAZD3q+?=
 =?us-ascii?Q?l8qUHlDI90fm64q6o02mlq6K8FmGWYG7XpWz2SY20+71RW+Lng+ZpS7NaU7n?=
 =?us-ascii?Q?dDs1ksL0a+60ZCgL0e7EHlf+XOP4H98Gc2MklWQ+Hfzx8Lev6Q+Rgr24FbKx?=
 =?us-ascii?Q?zV07IzsF5ncZzsqbPBPzitP6WHXPrj4vy+aEGfRdoKqU61YgZuji9Hxrp4qr?=
 =?us-ascii?Q?eB/I2NrHiVffxgx8FwTYLjhz2ArfSRSrCfSscRnvlp7hw9JTgxQtzkDflyaz?=
 =?us-ascii?Q?7ufdizoatQkhCEeqPoqbkg+Js9jClDf45ud3/889/YGz5dRN3Qfb3k4dnVqD?=
 =?us-ascii?Q?xJAxDwOnwfwOU4j0cIleTK0q/DOpc2Hj07pdVXfXPCuQwS8wKIUqumr546ps?=
 =?us-ascii?Q?6CsNTW6ZME+gls8tzAxpQkWDA+xH+Fv+4KrJ0gVi1+VfOIfJngixf7JyLvkV?=
 =?us-ascii?Q?BLwd8tLArWqZxp1dLj86UQ3rDXBF8/XLhkAEd8Pcgn8VbJxVMLpNlQBPhLHG?=
 =?us-ascii?Q?NHsXzy7Aoh1UXUB1vfC8DveR0MpvM+ysVrWJSTCL+eJJCZ0QH4aAbPDOnA2u?=
 =?us-ascii?Q?nkwHGEEX7IIEzaIUzCq2DIlQ/bs4cUe1sNHN2GFqwaoarQFkv5Knzsqyqnxc?=
 =?us-ascii?Q?QgOddGr4YrWRtrfhZ5TuNHAHHtHEhjb7aclMSrX5lCLbOcGjoHN3ce8QYaIE?=
 =?us-ascii?Q?ix55/DsgYoMzd0FKqAfmqo0ry2GX6c3kA7Fe2Gtuc0OmsMOk9MzxdxUl8Bkr?=
 =?us-ascii?Q?C44YeNRx6paCyqZU/OB+KDE/QQKISCs12D6lumYxFypVcOT4lD8t8e8Q1tE/?=
 =?us-ascii?Q?cw63wwOVmmG1FpNQBmof83qgOTRpW+/+vgn8JlfFZNrll73QRCn8QKMOV7Dt?=
 =?us-ascii?Q?P0pbHPPOI5mQVl+lduiB7f5S5AiTwtRz9mH6EYof3kksLvZ1bob1QtspO1Sd?=
 =?us-ascii?Q?RnRdD+cFI0Xs77rR3GCLT87CaCQhXWCYFMA30W57sgDlR8zApb7Emit9jwVB?=
 =?us-ascii?Q?kOFf+1LkP5vnC8RodTjQGpM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CCA2A0D7D1A72147A523CBB87BFE32A7@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cb2da9-296b-4c87-4a4e-08daa82fb5ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 06:46:49.2846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lOuRDqX3xTGyiv4syv7VviME/kb9LVSMSq0ieTGAGjacRpX2Ys6TlJWlCsmytGqekMjDRlWayrTCQmKeUnVyKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3020
X-Proofpoint-ORIG-GUID: cUXqzBuTmgrmomYLFCjZBH7ABmdviaGX
X-Proofpoint-GUID: cUXqzBuTmgrmomYLFCjZBH7ABmdviaGX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-06_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 6, 2022, at 4:38 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> On Thu, Aug 18, 2022 at 03:42:16PM -0700, Song Liu wrote:
>> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
>> index 100446ffdc1d..570af623e28f 100644
>> --- a/arch/x86/kernel/module.c
>> +++ b/arch/x86/kernel/module.c
>> @@ -229,6 +229,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
>> 	bool early = me->state == MODULE_STATE_UNFORMED;
>> 	void *(*write)(void *, const void *, size_t) = memcpy;
>> 
>> +	early = false;
>> 	if (!early) {
>> 		write = text_poke;
>> 		mutex_lock(&text_mutex);
> 
> As per 88fc078a7a8f6 ("x86/module: Use text_poke() for late
> relocations") I'm curious why we have to take the live patching
> path now all the time?

Since vmalloc_exec returns read-only memory, we need text_poke()
for any operation to it. 

Does this answer your question?

Song
