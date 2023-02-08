Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C5F68F9D1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjBHVkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBHVkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:40:08 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021651F486;
        Wed,  8 Feb 2023 13:40:06 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318JV3wY001684;
        Wed, 8 Feb 2023 13:40:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=vNLQyokkS+fBbGoa9cNPSpMWXT2i7eRw6UGrYYMCpyA=;
 b=Yx7e/Nx9sMdyXYL0Bfw/Ba2qnOL5uTZPQFbZJuX4OjfthzsTAakbubXE/g1DEo8tN+1+
 96uqQzukKE2m3Ik3UFrMRCsUCkDj8otN64Ayd8MV2a+pAZ8uRx04wL2+b24YQBmRu74t
 svKr9ZwNoq/WYIP+TA6cGMXqnYgIabAPqHF4Kj35euqMkKpxLw0KmX4rBbG7LBx1QIPH
 dOluLP2F6/NNXVjsy0QMkZqmKw0I4w3QbRA5FBwKt2C3/q6gnbNqC0DTlBsyCNiuYw3Z
 ZIvQRPTYZVbIitjNc6YdKAPHYZ/1UzgXPbNvF/YRDhNEmOtjqbZwkPFh3ZXvFEWsoXUx hg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nm34apsnk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 13:40:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7ZjGn2KQmpf5fVyheYD5VF0hLJWgj3ua5RqSqDzrQGgfnR0Xa/ogyZSBrv9J2AggBeUV9/mTXBz/9oVWQRhUcA1CU8rlKr+8NvqazS6XKw5qVdheu2WZAiCPNgh+zZF1/XQ+yYL5/2wNG/C+gPMTrkZ/QP/4v8wtNouZmU1ElkSBkP3EBdNhvEC4gQBoCNyq1/c36RuPF0Pp2lvDicPpztjpUNV+IWDkvNOANpaO2QXUhebEJxRRZzl78iCntMnBOZQ7f6ZNOmSn1GdATBY5Lda/HIvyRtFyZS+M1tZ7Sa6dUYWKex8Pd82yDWnEhmmBaR6fqFW8Mgbmn0s8RtDQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNLQyokkS+fBbGoa9cNPSpMWXT2i7eRw6UGrYYMCpyA=;
 b=WSokW8WqHzU0koLjVxn5OBA7ZwWn48ONtenhZmEeD6zkxRfNaY7J6D7oF6lBuh0KxPnZ+EVPWSACAVVsV3n+CB62S53OyaaXL4mkvnzwJqgbrc8+gDVlGqPF6rEtxBFIeVIbnbcoKiekSKPxxWQqbaofaYzjhucv/v7mpgBgd2S/NetTGaGsiD6C1HlnuW51vBC6CF6vobnDRj+T4Fmq28AX3mm3mxLAxy8/EZC/LArSUFACx2UUlAWyCkvAq5K6YT+LLo5tfN6quG2kKrKvJ6unOI5403X29wOtVSS3KemmFI4MkNA6tOBJbzQneXNnZLL0REE8jyK4ZonVxWFkSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH0PR15MB4349.namprd15.prod.outlook.com (2603:10b6:510:9a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Wed, 8 Feb
 2023 21:39:54 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8%5]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 21:39:54 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
CC:     Song Liu <song@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, Kernel Team <kernel-team@meta.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v10] module: replace module_layout with module_memory
Thread-Topic: [PATCH v10] module: replace module_layout with module_memory
Thread-Index: AQHZOosWgrFk94mbpUiAn23Fr3awBK7FVgEAgABAnoA=
Date:   Wed, 8 Feb 2023 21:39:54 +0000
Message-ID: <1574471D-D1A6-4720-A57D-626204E8E746@fb.com>
References: <20230207002802.2514802-1-song@kernel.org>
 <b40ec330-8c9e-0265-19b9-d82b516c95c1@csgroup.eu>
In-Reply-To: <b40ec330-8c9e-0265-19b9-d82b516c95c1@csgroup.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH0PR15MB4349:EE_
x-ms-office365-filtering-correlation-id: b084c99e-ca00-4fb0-67cc-08db0a1d043d
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JEQru5TK8hLWqsgsAMAjJgaKDT22gGd5IQ83GsHKQwTd1x/Oaz7gkV26WF/wnrN5tg0ce+ysyaagp8BVEYOhI3gWMjq8qZNaxNdZP+cl5gGLfXhSsj6Q2AQahQpqNIg5gie5EfS/s9PUk/p/qZ01jIR2ybijaktzcvtHFKVgNEjxumfPTVLo7PurTm05ojyIiCCQSg0bGUKlCA/3bKMMesspalK45hLwvewgBfJelif7dcoPW4DaMw5hT2jud61fZl7sDRmno+esRUpf7c6orbvci9uc3xH0jllzMPiAyEMfmR6iDK5wFVtKGe05CbXAuBk1itDPWUZM8G9FKEJ3RghvYnZIOqjtSdL43pUyIDaB5J8WJRTsvV5TMKUQUGnQpA9acO9GP2ZWKqYJzC6xODXB7S9/eXNjT0FC7RiXP4Rqy6UZ5hRAozxo1WfBBM4H3dj8H9sFsqAr466ZKDyJ5+y3DZS714ETipXE4zVI779WBLnoZX53njdAK5HCbD+yIJEmSwxGiplPOSRhEis5T/cAYqfGJs0TkUYoIgioL2ll1hDOrokVRtpmrQQW0p63HP6pRWvvMSP49bC3Fmxqx+SPQo5us+8u+rb5gwdRFmlbPaSOf5DPlAZk4SbM+ezqp7ycqidPt6jLseUOuxoyGJCB3OvXr9UnYax+o6PSO6HiM0JHG4n8F4Lgs34BK0vjEuD17JcQ5flqXUvRvrOwc5W8YH/W/lezzKNWDFxawys=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199018)(54906003)(86362001)(316002)(5660300002)(186003)(9686003)(6512007)(53546011)(71200400001)(36756003)(478600001)(966005)(6506007)(6486002)(33656002)(2906002)(38070700005)(38100700002)(41300700001)(122000001)(66556008)(66946007)(76116006)(66446008)(66476007)(6916009)(8676002)(4326008)(64756008)(91956017)(83380400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ixsvsb6PVTyOev5H44IpihjygFLFKxBpHCRTFtCp1rJmKok6Gkn06HOc0j4a?=
 =?us-ascii?Q?Toftp3hOCUzrutMxeduvGZewbYEOCKlpb7h98U4Jo++xZ2Jn78n7uM4LNVjx?=
 =?us-ascii?Q?l0mP12EC98QzgQUII58oe9mbWrez0pf1AbipjrLy+rY8CWvsjFYLX0EGAj52?=
 =?us-ascii?Q?rjZk6R7eJgwGPNCaPO9zb06NHkE8HP3l+IuXlxS8K6li/lNlEX0CJ932qupW?=
 =?us-ascii?Q?J2xeqPXQL4YU12Y2hphQbdb7y6/T+NqBH2n9SjqHWRzGwcWtZ629XboiYOFp?=
 =?us-ascii?Q?TWpc0GZGTdfVCigjrOjf9NeNS5RDvGCzvfxMpJsv+2GPXrupHtwhxHcTIv+t?=
 =?us-ascii?Q?OSTHu3FS1U4RfZWJfAy1mkICBmzADmkHnQ9h2aaymqOEPsmgE5YlYa4YBdNH?=
 =?us-ascii?Q?rinv1tEmk6iray73IMdq7JBa1MJwsMy5N2eMzyOjQG1NjKxomXCEI5pUSJlX?=
 =?us-ascii?Q?64OTpwrDPR6JkZ4w1sPz/FkxlpMsqezGwzQUJfb6FsbK9IMiWxibRd5fU96P?=
 =?us-ascii?Q?m4WdB7v7qsiaBm5/ozbJlDEk3GjLF2qQ3+85hDZOlkReHTNsOEjPRhXBtb4T?=
 =?us-ascii?Q?NAMRuFW5Xs60KhDRvbIxLlFu3emTdWNN6sj+KqpBBiMSeU5vt5oBBfNsCe9Z?=
 =?us-ascii?Q?d31mqvXd6npNZ44Fek6mM4Z8n0vjuYCPz+MiaEKVEe4Gra8V2NVMN0yHGs3W?=
 =?us-ascii?Q?MES36HTLyLIhAUo8UpJ92XAcTaf3bTU1buWD2lkC8R/ka5xu6ew/dnmqLJrs?=
 =?us-ascii?Q?Its18cBc2Nx1HeCETvoSukXVW117gP14MdOgnA9BehcSvt32j/DkXkCq8x+B?=
 =?us-ascii?Q?VHX3YmsWX9E8iF8mPMvsP6uB1Lv4aQJj5LVakXBTM11XcpvZV+nL7f3OJlkH?=
 =?us-ascii?Q?e9zwylQKdHheA2rpmVvx2yUc2mRzIA/Yzc0bIKHQ2ozmJZdWwwY/08vEPKCc?=
 =?us-ascii?Q?5qXfM3I9rjRelRatzhUWWsS+b+nb9HL94GTmwNoYsUI1BDB7lC+a/BPyV95s?=
 =?us-ascii?Q?W6jHOwhP55qJBJL5+e/curqIkclqVMq5ofl+ElKsCp3iALy57VWaWUBeBrmO?=
 =?us-ascii?Q?7lAZFM3lVluUfqm53fPKYcCODFENwUhrT0BD1BmeWif/q4MDuWgHPdpQqWYO?=
 =?us-ascii?Q?nUF6UEwUEEToulgsd1Nk3PmsOdCESjLpAvbhJ3addgXM1Jd5j/4YR4b5nE1F?=
 =?us-ascii?Q?qFLsw2o6jd1H6g0+vCNuvgpz7U/2uGHDcJ2JtoEJiOGguaiX3MMX4fqt+k+S?=
 =?us-ascii?Q?rTwWgJ+RgY9vSoN5lI6bzsowQaPlMuTAmwqXSVZ4onUZQa8cFYQQhVkwBk/A?=
 =?us-ascii?Q?ubKp4M8F6wVGtoUEBEuqEN9rbLPiMZVi27Mlut0mkYKmwEc3Ji3gqZ8Yz7Ba?=
 =?us-ascii?Q?pFfAaNquxjAgIdmEk3SllWV4BJicyr0FEDUhhs7LxcWn61H4VwdL03M1YEt0?=
 =?us-ascii?Q?EhvCUt6QxiFF1ln8YABk5EHiagHLjpmcj0onEUVYUOOPuVaDqewV2UDpRijm?=
 =?us-ascii?Q?MiAUuuXhXNSMB2u+dOF+C8+Mpr7cYtzGTtYIoRPPwj7G8wtLcuxp6jqpJf4y?=
 =?us-ascii?Q?6s3f9emAGbMcZL1qdrA/5soQylfSIzLB5L+cjF5TVErd2dpXoCj0FfzcAEgM?=
 =?us-ascii?Q?aQPlFrLw+f01a4cNENRsIT6xLMBfeSUiMRMdsbabtiuc?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <08718219D5FF8B4CB9BD406D0A35437C@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b084c99e-ca00-4fb0-67cc-08db0a1d043d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 21:39:54.4363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3+koXKmtM7V9SHR0aPIBwNZ4Tlczr5Q4EEpqQQGZEOfzqt3qoxZfR6wRQhK1P2QyniY990baU4JOCc7cjpLFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4349
X-Proofpoint-ORIG-GUID: Gfdw9gm1DuyasNit-SRuOhGg98urmldm
X-Proofpoint-GUID: Gfdw9gm1DuyasNit-SRuOhGg98urmldm
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 8, 2023, at 9:48 AM, Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

[...]

>> diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
>> index 200270a94558..933451f4494f 100644
>> --- a/arch/arc/kernel/unwind.c
>> +++ b/arch/arc/kernel/unwind.c
>> @@ -369,6 +369,8 @@ void *unwind_add_table(struct module *module, const void *table_start,
>>         unsigned long table_size)
>>  {
>>   struct unwind_table *table;
>> + struct module_memory *mod_mem_core_text;
>> + struct module_memory *mod_mem_init_text;
> 
> This function is small (35 lines) so no need to have so big names for 
> local functions, see 
> https://docs.kernel.org/process/coding-style.html#naming
> 
> struct module_memory *core_text;
> struct module_memory *init_text;

Will fix. 

[...]

>> 
>> 
>>  /*
>> - * Bounds of module text, for speeding up __module_address.
>> + * Bounds of module memory, for speeding up __module_address.
>>   * Protected by module_mutex.
>>   */
>> -static void __mod_update_bounds(void *base, unsigned int size, struct mod_tree_root *tree)
>> +static void __mod_update_bounds(enum mod_mem_type type __maybe_unused, void *base,
>> + unsigned int size, struct mod_tree_root *tree)
>>  {
>>   unsigned long min = (unsigned long)base;
>>   unsigned long max = min + size;
>> 
>> +#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> 
> A #ifdef shouldn't be required. You can use IS_ENABLED() instead:

Will fix. 

> 
> 
> 
>> + if (mod_mem_type_is_core_data(type)) {
> 
> if (IS_ENABLED(CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC) &&
>    mod_mem_type_is_core_data(type))

[...]

>> - switch (m) {
>> - case 0: /* executable */
>> - mod->core_layout.size = strict_align(mod->core_layout.size);
> 
> Where is the strict alignment done now ?

AFAICT, each of these memory regions are allocated separately, 
so they are always page aligned, no? 

> 
>> - mod->core_layout.text_size = mod->core_layout.size;
>> - break;
>> - case 1: /* RO: text and ro-data */
>> - mod->data_layout.size = strict_align(mod->data_layout.size);
>> - mod->data_layout.ro_size = mod->data_layout.size;
>> - break;
>> - case 2: /* RO after init */
>> - mod->data_layout.size = strict_align(mod->data_layout.size);
>> - mod->data_layout.ro_after_init_size = mod->data_layout.size;
>> - break;
>> - case 4: /* whole core */
>> - mod->data_layout.size = strict_align(mod->data_layout.size);
>> - break;
>> - }
>> - }

[...]

> 
>> 
>>   if (shdr->sh_type != SHT_NOBITS)
>>   memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
> 
>> @@ -3060,20 +3091,21 @@ bool is_module_address(unsigned long addr)
>>  struct module *__module_address(unsigned long addr)
>>  {
>>   struct module *mod;
>> - struct mod_tree_root *tree;
>> 
>>   if (addr >= mod_tree.addr_min && addr <= mod_tree.addr_max)
>> - tree = &mod_tree;
>> + goto lookup;
>> +
>>  #ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> 
> Can we try to avoid that #ifdef ?
> I know that means getting data_addr_min and data_addr_max alwyas 
> existing, maybe through an unnamed union or a macro or a static inline 
> helper ?

IIUC, we want __module_address() to be as fast as possible. So #ifdef
is probably the best solution here?

Thanks,
Song

> 
>> - else if (addr >= mod_data_tree.addr_min && addr <= mod_data_tree.addr_max)
>> - tree = &mod_data_tree;
>> + if (addr >= mod_tree.data_addr_min && addr <= mod_tree.data_addr_max)
>> + goto lookup;
>>  #endif
>> - else
>> - return NULL;
>> 
>> + return NULL;
>> +
>> +lookup:
>>   module_assert_mutex_or_preempt();
>> 
>> - mod = mod_find(addr, tree);
>> + mod = mod_find(addr, &mod_tree);
>>   if (mod) {
>>   BUG_ON(!within_module(addr, mod));
>>   if (mod->state == MODULE_STATE_UNFORMED)

