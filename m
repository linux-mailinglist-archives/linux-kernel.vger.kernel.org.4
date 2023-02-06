Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502CC68CA86
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 00:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjBFX1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 18:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBFX1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 18:27:43 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18E924484;
        Mon,  6 Feb 2023 15:27:39 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316N8dds002401;
        Mon, 6 Feb 2023 15:27:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=mhbu7EJD7HnDo6o+fgNRB48y1kJrwuR4O/XzRwCwIP0=;
 b=mgO/+Q79yIbT3ekYorn0XswaHWrfGnnyW5P/g0woG3ecCpXxqEaW4nOkUk4lE8W+zyTG
 kcffX9SPGyPecwk6uzaZCJh4JOTxgoTkjz6ChcUOJVK1JqojLEiXRS818Jt7nUZYgTYA
 DoTU7N6hOQFBNMSdnUnqZLDBTD8nu33NheVnDXxLZ9IkIXccjvIpFVM4WWeYb73S/aqN
 L42/kif+AWSySJ1HXkSdBNPlAh/AURla3Tc8JewbGM0kwjNYDd7ZHHwJiJkyy+4WMvEF
 zwxoeVm+9US50Kxu41AVBeLm4pT90zCEPWP/zUoXkO6i0/5TnjExJvcN1V/ECRcRu7+F Sg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nkay703cg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 15:27:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RK9ZfSgrAGjJey/p1AKeeCLsoicHoTHdb2BCeOikJs8CwA64grChaKf0QIH4SWbBczBmjojtwozyf1udXm4iBb3X5QF1H2EzePJyqZxatFuOrVPAqZudD1oHE26gDfaOOuo3QrskJ9U8RWvj58L1nDjQbfZmxpYKtw8Z2tN4cUtYXQk5hIkJYvG/AN3i0sAIAHKXZV7d0KYmIJsH4ZOrljYewnV15IJ+XtISyJ838BqYxfFsV3lW6k4dgVzhcw2U5ea+0sQqdejxoOqbU+nWMWplhIy4dvZv3JaEIu6y3qeA4ZktCLMH5CK7D8ErgnPvQ6Sql3KZpD4GgF67QCmKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhbu7EJD7HnDo6o+fgNRB48y1kJrwuR4O/XzRwCwIP0=;
 b=R8fHb+kyXyuqpEnWWjG+ZzsTO4T8so+1UvD1uW51r/dsUtU73RLZ42AeWnRtnTOobbkBInAqOQ2BC9iespJH5v4B7K9cNeihoSSSj9ts+4QSrB4pVjSgUWyH+zsZm6Dg6UOWwWTYbzrri6Zqg/Tt7Hw68nQbNalBVme5y05/fiBVXGVMdOWAUTyyLMQcPxJjFIL9bD5C1ABvQXMKrNYjtqs7exIP6FJSgUO8yHj8kp6I8VAtTXMK6V5m0t9QJ9A6h7F/Ec8Eyrmaz6FzhspsqRBjO6bLXNChHyWZDjoiE5IzgpkdrWqM/D2tOIzeVfXUZLysJkoJYs3Dt/cU4rCLEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB4338.namprd15.prod.outlook.com (2603:10b6:806:1ad::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 23:27:36 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8%4]) with mapi id 15.20.6064.035; Mon, 6 Feb 2023
 23:27:36 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Song Liu <song@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Kernel Team <kernel-team@meta.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v9] module: replace module_layout with module_memory
Thread-Topic: [PATCH v9] module: replace module_layout with module_memory
Thread-Index: AQHZOBjM9Um86gAGJEyMnpzD+3mYlq7CeI0AgAAcZIA=
Date:   Mon, 6 Feb 2023 23:27:36 +0000
Message-ID: <09C6F0A2-5AE5-4D8D-87DE-BFEC2C642A49@fb.com>
References: <20230203214500.745276-1-song@kernel.org> <87cz6mxyb7.ffs@tglx>
In-Reply-To: <87cz6mxyb7.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA1PR15MB4338:EE_
x-ms-office365-filtering-correlation-id: 390ea087-c496-47ba-6dff-08db0899bafe
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VeNsKQsdVXkLAZ3uchW/TUpFZb4QP1hXWDCRbOn7vF/9GZa4jAMjjixwRooqQuxFL2lGhk6IGvZHs8t+ltAEHKDMWaEPOe+btV5yv8nSAG7c1XOhjWFtfqM/zk9F6PUjzkH0i/dRn3aCdrww4F2aWa/sscYRsv6MlfQdyLq4SwcTANeEK+YDAuFAeec1hTQOBo3aeyzsMYkhawYsjfLlkummp4MN23Q34LMJwGssy5a91PnsgKQCxmrf1p4p+q5Ir47OFj+2FUxWpNf9ieHsywKlWbKLEqPki/XPlCYOh1WdMvgx+L1iIUnxihl76zc5duCs7kiXikVxGDFYrJ0bZLc7NSAwClzNQIxs97mSf071Bee1tE3DHE2sUrpz6WbrL2N2NQLeyzpXf5DVtbL4QT9hvSXiUTyDfVbKYR2kOHwMKE2M4eg82BpC1J83mbi2WTCYZqKQzAe1YjC+keSIPwTcFp4zZe/WciQgcA8wqugoG2hKvIz94ueAEsO1Oe0g93vSowx9xNcez7TNPtGksO5Xp1PQ7Xy7Nt8m0O7TuQPc2tPqpprVyo8xPl0dQAKI/t0vLU5QNP/IuFp82kTGL5PRhhEuXx6yIXkbZrPWEKsT02nDGApBYBR9DlvdbxVrGaoPeUwNOAJsDKuMtZRbAs0GtiD2G/OU5deZv5Q528auL88xIyw9ti7rC2tMh8SJa01eV87NnUW6/GOI0xLfgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199018)(54906003)(8936002)(316002)(71200400001)(86362001)(186003)(122000001)(478600001)(6486002)(33656002)(6506007)(53546011)(38100700002)(38070700005)(9686003)(6512007)(5660300002)(36756003)(2906002)(91956017)(83380400001)(66899018)(41300700001)(8676002)(66446008)(64756008)(6916009)(76116006)(66476007)(66556008)(66946007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ueDxwttg/d2EjmgPZ8hYm6xhxaEfEAcLr3KLuEJtt1IXA98iYAZjW7Hi8ZOl?=
 =?us-ascii?Q?95rbQiOrQjNpS47tEm4j1btSFkRghKKUCVuTIXCisEgC9zQlIGrH9fOyfsF6?=
 =?us-ascii?Q?fi1U+7bETT4e+YQshBS2oZwlrC3OGrYBDGrLEiloHZJTlj72Rgmq4ip5yqaL?=
 =?us-ascii?Q?dLhm1UDWlclaMB4lNDCA53Qj9dyzxj2JNmgDfLov3bJ7ckLy/BqQCckURra3?=
 =?us-ascii?Q?hxgUUK0gYyI8DvHsKEa4p8VU6qIHnu3VIhZNw543kFK1Y4yO1ZEOc477bUh1?=
 =?us-ascii?Q?ceEJ6luJqwri3tn3ybbfX4zGpjOVO9KHUC2Nyfa1lBKVmtgcu/ac7HIPDNIM?=
 =?us-ascii?Q?HNP4/gbjt9UAMbARFCWsyqlj8Q1nwI0icHxLjE6BwYN1n6GJEsoKcPFYXUVH?=
 =?us-ascii?Q?iUgGZsZ73e0RVVxFGxsvhlp3sCUAEW4EMkxkJzEARgmwgCDDnj+P/+8EpvNb?=
 =?us-ascii?Q?bZPHdCAd5XVNfazKY21IGC92KXf+eLeuuuf9VFolcedn1euMmZ3e0RrLdxII?=
 =?us-ascii?Q?57/o5YAvJMaUwRLAKY3RAo7opvfyX8RtSkB8V68o8JEs/a7qPOVtQI8ovarA?=
 =?us-ascii?Q?tUkmuOhvuJm8KbCNsyQaIFh5dThCkjkH2ODPbi2RxHTw5zFioRT4bVmq+Ted?=
 =?us-ascii?Q?wnnGrghfiI7jCDc76UGMtjzClYFEQu8o2wv8PrmHt+/3Rwcgzc7o6/GVARyu?=
 =?us-ascii?Q?QskD1R8kJur873uilnURWZiRci450qhzQzQvLZkSPvYBNCPWvkaK9vYQ7HfP?=
 =?us-ascii?Q?vAZZxdaRQgRujJyAeq6ejo23918p4s/QqxxyrUPGclU+VRhGvQHe3t+DmSz2?=
 =?us-ascii?Q?JZ2krAOnuQ6YK6YbeCm1zkcB/hLqoKOjwKcn/LXyhq2hZYaBUcz5aW482Wzx?=
 =?us-ascii?Q?OSvZBEOxzWmJfs+/4oxlW4CiOaG4Wo+pSFWeU4rNTiiwMzuUkCHxgaHoAtAd?=
 =?us-ascii?Q?T2XbN9mFdbVnCtKw3wOTiHO3FtoZdt3IJfEaMc2+9F6JTvFsBHZjats5faCp?=
 =?us-ascii?Q?YN4bbOP3dAMhUGUEp8mESVJTfNt1b5aUrMYY2uP26u9rV5iUQjFTjWVo5dMs?=
 =?us-ascii?Q?uvDROp2/Bluy4GUGX8Cnd/TbqbmbcI+CoCq99vy23fubEohxgRnhrUCWA+E/?=
 =?us-ascii?Q?VX/ohEEMzCIdNP752FwAtvCgGtXzh7usP61cTA2yN4ZagZf1YKG2Sbng0i3g?=
 =?us-ascii?Q?RwUhJUEEb/iHPWEo6v5PWtMNiukDKNGiq4uefyLs0DFD9NTbNYoxCdqAKjcV?=
 =?us-ascii?Q?jHpkbAOdsTsFlHbfLWWGwPL2ffdK4V9lACbPU27uFcz3YJOWr5ciupS6mdyK?=
 =?us-ascii?Q?0z8H1XFD/q4eqHurtieCNnw899lrXU0Oq+ZgBPqPSucBurLm4mSq3SEsi8pt?=
 =?us-ascii?Q?R4as0OouDP3NMkqhdLq28Ywu8ZJmisyHVD5ofnTStikzn0RpaHjtRiWBCo0w?=
 =?us-ascii?Q?DE/3gQ8KzAugfFSG1tAZ6Rd0D2wOKO2fDlpOfmw1Sz+QbrM16e+5rmErmEXM?=
 =?us-ascii?Q?mtB8YlPk5REN4dZbnjG/Ku3Rz5Jpeq4ASIu8Dc2tPjzCRmPLpqcVTUBc7yTv?=
 =?us-ascii?Q?RMRo5DeNOe3N345ZzxxjJwP1XMblPWFX+tlOYpTSN2luuaeMa/7gyOYUCOIY?=
 =?us-ascii?Q?gaC/OYWG1UrY0dDwqQdiySVzxd+9dPSYUN5dgHbCeBrz?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8E12BADFEBDF547AE6911E70978D293@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390ea087-c496-47ba-6dff-08db0899bafe
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 23:27:36.3155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CPbta0iy7BWXN0CMTekqjy7D6y5ZeMQJGMdQkTKOqKvysOaJ5BlFgTTjUMoiMVAv1b4MxHfWVN4tVgf/IjCUKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4338
X-Proofpoint-ORIG-GUID: EHwukFP3tkTgXOWGOSzBgKmg88HQ6knv
X-Proofpoint-GUID: EHwukFP3tkTgXOWGOSzBgKmg88HQ6knv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 6, 2023, at 1:45 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
[...]
>> @@ -67,7 +67,7 @@ static bool plt_entries_equal(const struct plt_entry *a,
>> 
>> static bool in_init(const struct module *mod, void *loc)
>> {
>> - return (u64)loc - (u64)mod->init_layout.base < mod->init_layout.size;
>> + return within_module_init((unsigned long)loc, mod);
>> }
> 
> Wouldn't it make sense to get rid of these indirections in arm[64]
> completely ?

Yeah, we can remove them. 

> 
>> struct mod_kallsyms {
>> @@ -418,12 +448,8 @@ struct module {
>> /* Startup function. */
>> int (*init)(void);
>> 
>> - /* Core layout: rbtree is accessed frequently, so keep together. */
>> - struct module_layout core_layout __module_layout_align;
>> - struct module_layout init_layout;
>> -#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
>> - struct module_layout data_layout;
>> -#endif
>> + /* rbtree is accessed frequently, so keep together. */
> 
> I'm confused about the rbtree comment here.

Let me remove it in v10. 

> 
>> + struct module_memory mem[MOD_MEM_NUM_TYPES] __module_memory_align;

[...]

>> +static void free_mod_mem(struct module *mod)
>> +{
>> + /* free the memory in the right order to avoid use-after-free */
> 
> How do we end up with a UAF when the ordering is different?

IIUC, we need remove MOD_DATA at last, which hosts "mod".

> 
>> + static enum mod_mem_type mod_mem_free_order[MOD_MEM_NUM_TYPES] = {
>> + /* first free init sections */
>> + MOD_INIT_TEXT,
>> + MOD_INIT_DATA,
>> + MOD_INIT_RODATA,
>> +
>> + /* then core sections, except rw data */
>> + MOD_TEXT,
>> + MOD_RODATA,
>> + MOD_RO_AFTER_INIT,
>> +
>> + /* last, rw data */
>> + MOD_DATA,
>> + };
> 
> That's fragile when we ever add a new section type.
> 
> static const enum mod_mem_type mod_mem_free_order[] = {
>               ....
>        };
> 
>        BUILD_BUG_ON(ARRAY_SIZE(mod_mem_free_order) != MOD_MEM_NUM_TYPES);
> 
> Hmm?

Will add this in v10. 

> 
>> 
>> static bool module_init_layout_section(const char *sname)
>> @@ -1428,6 +1506,20 @@ static void layout_sections(struct module *mod, struct load_info *info)
>> { SHF_WRITE | SHF_ALLOC, ARCH_SHF_SMALL },
>> { ARCH_SHF_SMALL | SHF_ALLOC, 0 }
>> };
>> + static int core_m_to_mem_type[] = {
> 
> const?
> 
>> + MOD_TEXT,
>> + MOD_RODATA,
>> + MOD_RO_AFTER_INIT,
>> + MOD_DATA,
>> + MOD_INVALID,
> 
> What's the point of this MOD_INVALID here?
> 
>> + };
>> + static int init_m_to_mem_type[] = {
>> + MOD_INIT_TEXT,
>> + MOD_INIT_RODATA,
>> + MOD_INVALID,
>> + MOD_INIT_DATA,
>> + MOD_INVALID,
>> + };
>> unsigned int m, i;
>> 
>> for (i = 0; i < info->hdr->e_shnum; i++)
>> @@ -1435,41 +1527,30 @@ static void layout_sections(struct module *mod, struct load_info *info)
>> 
>> pr_debug("Core section allocation order:\n");
>> for (m = 0; m < ARRAY_SIZE(masks); ++m) {
>> + enum mod_mem_type type = core_m_to_mem_type[m];
> 
> Oh. This deals with ARRAY_SIZE(masks) being larger than the
> *_to_mem_type[] ones. A comment on the *to_mem_type arrays would be
> appreciated.

Will add this in v10. 

Thanks,
Song

[...]
