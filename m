Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9049E5F7464
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 08:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiJGGyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJGGx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:53:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD276C949
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 23:53:53 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296NpBki026941
        for <linux-kernel@vger.kernel.org>; Thu, 6 Oct 2022 23:53:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=tOaxDP5T1qrviMdF2YDKSJrhL9d9bG/6iBpl6RzVA1U=;
 b=X2hObsqlyKWc64nCxSkO+7a6KNyJvMITnoZDKEJ0wnJ9+33mhxfeApuXezCobr5KEdid
 up1siTb7HpSutuCPGpeX4GAstSQVkHNBvDjugeN5UJALupXYsqR6AeBWwLjX6L4j6Fxr
 OFkqfuR3W60aib23vbNEugBPk3/utcMK0qA= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k2807t586-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 23:53:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTH5fs54ZETVoT+cFn0mnbkzfL+T455Q3cPWTXrhx1jevSLGRvCz6nZjiJRRbUzYp3iGObgUnEsiiv8nqbi8OcQ4RPwSatQ5pUfoCE3D2ehNUTRMZr7MjXz/hh6HDT0x/G0suk3axDm0WFGkal8i8ECJzmR03ufOowumHUgBO4C66eDO8uhx8GFwIagvdM0Tz4UWRoFWUbygOnUqSv5liqHpNeAPxrKBPV0d4iZq/X5yuUVQ4hyX50LwoBRE5M+C2lQonIvA4beGXH4TCFpuRAezBmnj0GjDD+pTykEoKJ4CX8qJ03GQ7Zra4sjxigCuGFCWLqzd8iYyJZgiMDr/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOaxDP5T1qrviMdF2YDKSJrhL9d9bG/6iBpl6RzVA1U=;
 b=ZMx2vQcjEcZJ+ODDuEBHMQfKDC6pFyL75y2K1m456W6zIhzP7I8R9R3pfObt0alshaP2ng4CjCMNVj/urTzXX0OCz41REz1ccjHjBG+uqCeCKD1ZuXvDqOqhi9WkMzlgh1hycvmbGbeoLScc/w45EkmxdtAUN4UBs6j04L1tlnDchK+86ZB7NU/TI4eyylivcPZnB58hBpqwoR9oBgOWfq2Rs7CmtUZhEb/kh7LwWGoLpBRBNSOACdHwOCmVCBVM0A0Yw0A+nisKtjl3XT80+hinGCK6tq4ys/kZL7Dhn1zcIN4ha0Y3MICgrphIqe79RPxWFleGAWcexitBw9hhcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW3PR15MB3803.namprd15.prod.outlook.com (2603:10b6:303:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 7 Oct
 2022 06:53:49 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537%7]) with mapi id 15.20.5676.028; Fri, 7 Oct 2022
 06:53:49 +0000
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
Subject: Re: [RFC 4/5] vmalloc_exec: share a huge page with kernel text
Thread-Topic: [RFC 4/5] vmalloc_exec: share a huge page with kernel text
Thread-Index: AQHYs1V7xDsy5JGhgEqjLpcV4uJ0bq4CVGwAgAB4A4A=
Date:   Fri, 7 Oct 2022 06:53:49 +0000
Message-ID: <EC88843A-CA78-428C-A125-A3CDA01D657F@fb.com>
References: <20220818224218.2399791-1-song@kernel.org>
 <20220818224218.2399791-5-song@kernel.org>
 <Yz9oUDY6nj4V9z/O@bombadil.infradead.org>
In-Reply-To: <Yz9oUDY6nj4V9z/O@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MW3PR15MB3803:EE_
x-ms-office365-filtering-correlation-id: 582ea499-8a5f-4c24-6abf-08daa830b07a
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0FfZgqMRPsMHiFD9afsTJz0PYXtwaHUokdtJVi5TyB7iKQT4rdLNt+aqStWeO/Up1f6l8JVLF+Pji/Y2j/MWOAJsuiID/oEJa/F9aihI8H4QTd79seDy/rImWKQQ+GoLHd30V/K48L+VLYvKxJrvbtaOb4PFxCDzGvsZzV208JZjZLC2mURqV6y2TDxwXr78LgmjwDn9SGGhPyqzHWwCjVaG79aOdi1RFEA7wjXYIG7SHlCaxXm6+dHuVgYNS9V8aIZa8tXQMn4rZqpvVj+y/XqMLMb/33YiYnJNfntbG1ibQLUZaEEC2Bl1SElYnzHdT2y+3m81YKIk8FPEbM4ff0K3GN38WpYolfVndvGWaSYqBjZwILRwNl3ETEwI3bGaqG4rod3ml6H93G4RApYcF7ct3naQ7xeVFmTTjJxKFM19OZWJGEf237I+7XmBTCIgSkvVMcJYKDXVz/dM8i6B0aNTp+T5wlrRoCPHVvaLMSjfPR+bvbAH3+cvG0AKvDXS9mgVKLO50U6ElR6P+FiCNHKZozyHTBc0YCGFTADpd01e217cHvd3PUD247BAMz2qQRPbpQmv3evoboe7i4j+anqTa+ODSjd14WXb+DVM6NvObBXL77VFi2+sEag+ZS9jE1tCmX58z/vQ2Rx967UhWWwDyZpeskPVTxzS4KPZhIS0HpMgMQKhLRjEpXE4PHoaYvDFxUBTFJNyTchSjNDO71kDcyO1TTpmSq29w6R+Yzn/tXJwUmJjMuGHNUbJGkWNrPUKvpWug6ovTlmnVrc0pSLc8e9yVt0d9d7iIBhT7eoUZiefimfq+RTEpAziG7C88mg5aG87xA+O8x3yoTQvoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199015)(8936002)(8676002)(5660300002)(2906002)(36756003)(7416002)(33656002)(41300700001)(4326008)(91956017)(54906003)(64756008)(86362001)(66476007)(66446008)(66556008)(76116006)(316002)(66946007)(6916009)(71200400001)(6486002)(478600001)(38070700005)(6506007)(6512007)(53546011)(122000001)(186003)(2616005)(38100700002)(83380400001)(14583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zxIhjDG6CS4HiJyDnTG5SW3Cng9HWjgRGbNehPYBtsx/JdPZuSmwUx1doI1P?=
 =?us-ascii?Q?DgoiSIAXK/ovheOipZu1QsVYnsEak1jvg6ahr495cKga+GVynW+KjORGpIAk?=
 =?us-ascii?Q?jphQjDR85ATzUHVq/6QN99Lv5tUGw7XkYbEAFvKi+n7DdAEJED1tcqLCdBgr?=
 =?us-ascii?Q?rd6GjR5EUAcbmf1i2O/NALuWDeTJ7RSoCwEeEAcy/qmeygSKL6ss80yB3uwJ?=
 =?us-ascii?Q?cdF9KAdON8WOByybszaDa49tZGAZEZe2rzEX1KxRSjIC6UTqwRra0loLUMcV?=
 =?us-ascii?Q?TXf6RgomOLdltIMhICL881h11yB5hscWNtgbzwZ/mS7Bog7s8aXVJtv9xuHr?=
 =?us-ascii?Q?cR96zuQtDSLnPFWx5uF/a5PlmQA5UskkV+tZB8f6TzqxyKZ2h6kUgoKW/p6X?=
 =?us-ascii?Q?Q3UK9P7/ID2ns9hROQy2RMusk0TqUTYhmHm3zTUDwGKxF99A0DJ0k6YpIaH5?=
 =?us-ascii?Q?krtdcnEKRjkl0YsI+P0iEzPPXJz/3eyThirUVkKxf5yhZLjmzg8jeJo0iEmb?=
 =?us-ascii?Q?3ezisydgnJurSBPwtxXRbEK55LSLy4eD3UaJDOW7tjKgkTJZF9ZYhnLYLrZP?=
 =?us-ascii?Q?QVWUp9JJvPNoJw9MF0LHq3/A2U5Z+LTPKu4Fjsbp2OOyGTAMiT99tr6c+McB?=
 =?us-ascii?Q?M7KGgxh0J9Z9kO03aGtaYXjSEaso7HwRUnBQJwUuvrUUWGjoOCStlhFrsDQ5?=
 =?us-ascii?Q?ggCCELm5d//jzBE7Un4Wb1Y5HsfHkBKIOeMP/vB4OHzsVGk4rmK38aaxW0jH?=
 =?us-ascii?Q?MRo7m+a3zbM1kheI5LK4D0RmpKQ1EGbvQWk4E9KH4ufPxgZviHMhnu81QjH7?=
 =?us-ascii?Q?HNnonkBRGwowPXwc8zrbk60+KB9crZB5JKjslM4ovFmLIAgyXIg5lH+FoYSH?=
 =?us-ascii?Q?xTeUARO85hRTODUMMIF2DX4hPrv1KJz57Q6heCXR8nBFQnjJJpw18JZWzTZW?=
 =?us-ascii?Q?sWoY9Fxq0AWPW2PuDwgCLUfMoCAi4oDA86kGmy0oOKavbsZtcRri0+3lZ7HZ?=
 =?us-ascii?Q?SH+5m2PRQv4ZxIb2OLxnwHH6v8s9iZcFwWvhmohbonDJzsAZekOJp9/lEr4f?=
 =?us-ascii?Q?bJ2zWutNA1NcOR/psCCApJtyX5l5KnmRmBlywCdew2a//IZWv45AqXcsDN++?=
 =?us-ascii?Q?fOLKVvOM7O6c7HOQsgl9YTxZS+MJKpXKmURDitRrPoQBSQD3x3nhMIwdTsx7?=
 =?us-ascii?Q?YBep4QQzAguaIJmIesh6oWMeaKbjkwKwK0mPVPi3iY09OnlCdkwWH6rlKUzR?=
 =?us-ascii?Q?c9AcMu9deni09pyRiuzu9Tobx/bWF9hNL9klgCfKo04E49XVcm2NfKHzMyLx?=
 =?us-ascii?Q?ZnIZZ52ByRDYFgVym/ptzcoyHk63I33J5PtdaUq/3UV60tUcc/VE4B3QSr15?=
 =?us-ascii?Q?uNep2/8Lp3gkEiahHo9LaAi3OfGtLn72WMWMWh9qKJ5v5XHW3GWU+xsG/o5I?=
 =?us-ascii?Q?sstt2mgj1nmiNZelOuJ3LSAICIU6hkDrSRUNXkVW/ItxmxuhZQwclukZGzSY?=
 =?us-ascii?Q?t19dz15frXW+y1JGRbCaUBjZoC7agCEUwhY2F5vkfG/4QujBODAJQ31BtOda?=
 =?us-ascii?Q?0RwtXvs08pnsB0QOyItJq0723WaaNqt+T1XgbNrTu+kGPCeTaGKO6LwLa3WU?=
 =?us-ascii?Q?5xPO3nALiLaXBOsVVODl9wg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D271A133F890BA4995ED17594161BCA1@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 582ea499-8a5f-4c24-6abf-08daa830b07a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 06:53:49.8744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QifyNvId8bLzWYqE6whmOKhdOPZPz/u5BmGjfpUsj5Z+rDH7H0iMdvwoog3Oa/pBTDiPPnT5Dob+f+y54BhaJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3803
X-Proofpoint-ORIG-GUID: ImLoDX1OwG17SYhXPwCmSdcnOt37hid3
X-Proofpoint-GUID: ImLoDX1OwG17SYhXPwCmSdcnOt37hid3
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



> On Oct 6, 2022, at 4:44 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> On Thu, Aug 18, 2022 at 03:42:17PM -0700, Song Liu wrote:
>> On x86 kernel, we allocate 2MB pages for kernel text up to
>> round_down(_etext, 2MB). Therefore, some of the kernel text is still
>> on 4kB pages. With vmalloc_exec, we can allocate 2MB pages up to
>> round_up(_etext, 2MB), and use the rest of the page for modules and
>> BPF programs.
>> 
>> Here is an example:
>> 
>> [root@eth50-1 ~]# grep _etext /proc/kallsyms
>> ffffffff82202a08 T _etext
>> 
>> [root@eth50-1 ~]# grep bpf_prog_ /proc/kallsyms  | tail -n 3
>> ffffffff8220f920 t bpf_prog_cc61a5364ac11d93_handle__sched_wakeup       [bpf]
>> ffffffff8220fa28 t bpf_prog_cc61a5364ac11d93_handle__sched_wakeup_new   [bpf]
>> ffffffff8220fad4 t bpf_prog_3bf73fa16f5e3d92_handle__sched_switch       [bpf]
>> 
>> [root@eth50-1 ~]#  grep 0xffffffff82200000 /sys/kernel/debug/page_tables/kernel
>> 0xffffffff82200000-0xffffffff82400000     2M     ro   PSE         x  pmd
>> 
>> [root@eth50-1 ~]# grep xfs_flush_inodes /proc/kallsyms
>> ffffffff822ba910 t xfs_flush_inodes_worker      [xfs]
>> ffffffff822bc580 t xfs_flush_inodes     [xfs]
>> 
>> ffffffff82200000-ffffffff82400000 is a 2MB page, serving kernel text, xfs
>> module, and bpf programs.
> 
> This is pretty rad. I'm not sure how you were able to squeeze xfs and
> *more* into one 2 MiB huge page though at least on debian 5.17.0-1-amd64
> xfs is 3.6847 MiB. How big is your XFS module?

In my build, xfs.ko is 50MB before strip, and 3.1MB after strip. But the
text section is about 1.3MB, so it fits in one 2MB page. 

> 
> I don't grok mm stuff, but I'd like to understand why we gain the ability
> of re-use the same 2 MiB page with this patch, from the code I really
> can't tail. Any pointers?

I don't quite follow the question here. In this case, we allocate one more
2MB page, so that some static kernel text can use it, and shall it with 
dynamic kernel text. Does this answer your questions?

I am working on a newer version of this. I am planning to resend when it 
is stable for BPF programs. For modules, I think we will need more 
discussion about the interface with arch code. 

Thanks,
Song

> 
> But, I'm still concerned about the free'ing case in terms of
> fragmentation for contigous memory, when free huage pages are available.
> 
>  Luis
> 
>> ---
>> arch/x86/mm/init_64.c |  3 ++-
>> mm/vmalloc.c          | 27 +++++++++++++++++++++++++++
>> 2 files changed, 29 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>> index 39c5246964a9..d27d0af5beb5 100644
>> --- a/arch/x86/mm/init_64.c
>> +++ b/arch/x86/mm/init_64.c
>> @@ -1367,12 +1367,13 @@ int __init deferred_page_init_max_threads(const struct cpumask *node_cpumask)
>> 
>> int kernel_set_to_readonly;
>> 
>> +#define PMD_ALIGN(x)	(((unsigned long)(x) + (PMD_SIZE - 1)) & PMD_MASK)
>> void mark_rodata_ro(void)
>> {
>> 	unsigned long start = PFN_ALIGN(_text);
>> 	unsigned long rodata_start = PFN_ALIGN(__start_rodata);
>> 	unsigned long end = (unsigned long)__end_rodata_hpage_align;
>> -	unsigned long text_end = PFN_ALIGN(_etext);
>> +	unsigned long text_end = PMD_ALIGN(_etext);
>> 	unsigned long rodata_end = PFN_ALIGN(__end_rodata);
>> 	unsigned long all_end;
>> 
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 472287e71bf1..5f3b5df9313f 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -72,6 +72,11 @@ early_param("nohugevmalloc", set_nohugevmalloc);
>> static const bool vmap_allow_huge = false;
>> #endif	/* CONFIG_HAVE_ARCH_HUGE_VMALLOC */
>> 
>> +#define PMD_ALIGN(x)	(((unsigned long)(x) + (PMD_SIZE - 1)) & PMD_MASK)
>> +
>> +static struct vm_struct text_tail_vm;
>> +static struct vmap_area text_tail_va;
>> +
>> bool is_vmalloc_addr(const void *x)
>> {
>> 	unsigned long addr = (unsigned long)kasan_reset_tag(x);
>> @@ -634,6 +639,8 @@ int is_vmalloc_or_module_addr(const void *x)
>> 	unsigned long addr = (unsigned long)kasan_reset_tag(x);
>> 	if (addr >= MODULES_VADDR && addr < MODULES_END)
>> 		return 1;
>> +	if (addr >= text_tail_va.va_start && addr < text_tail_va.va_end)
>> +		return 1;
>> #endif
>> 	return is_vmalloc_addr(x);
>> }
>> @@ -2371,6 +2378,25 @@ static void vmap_init_free_space(void)
>> 	}
>> }
>> 
>> +static void register_text_tail_vm(void)
>> +{
>> +	unsigned long start = PFN_ALIGN(_etext);
>> +	unsigned long end = PMD_ALIGN(_etext);
>> +	struct vmap_area *va;
>> +
>> +	va = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
>> +	if (WARN_ON_ONCE(!va))
>> +		return;
>> +	text_tail_vm.addr = (void *)start;
>> +	text_tail_vm.size = end - start;
>> +	text_tail_vm.flags = VM_KERNEL_EXEC;
>> +	text_tail_va.va_start = start;
>> +	text_tail_va.va_end = end;
>> +	text_tail_va.vm = &text_tail_vm;
>> +	memcpy(va, &text_tail_va, sizeof(*va));
>> +	insert_vmap_area(va, &free_text_area_root, &free_text_area_list);
>> +}
>> +
>> void __init vmalloc_init(void)
>> {
>> 	struct vmap_area *va;
>> @@ -2381,6 +2407,7 @@ void __init vmalloc_init(void)
>> 	 * Create the cache for vmap_area objects.
>> 	 */
>> 	vmap_area_cachep = KMEM_CACHE(vmap_area, SLAB_PANIC);
>> +	register_text_tail_vm();
>> 
>> 	for_each_possible_cpu(i) {
>> 		struct vmap_block_queue *vbq;
>> -- 
>> 2.30.2
>> 

