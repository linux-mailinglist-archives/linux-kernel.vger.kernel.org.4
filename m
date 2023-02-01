Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17386870EF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 23:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjBAW2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 17:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBAW2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 17:28:07 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA751422B;
        Wed,  1 Feb 2023 14:28:05 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 311J5YxA020160;
        Wed, 1 Feb 2023 14:28:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=m0ENKCazT+jseBpD+LNeCkCrq+EB84y6er3sgyRxkvY=;
 b=LtC+RGOMafYC0GjZtaJ5LO3hHF3HGqv6On3IgzP53zEsP6ZOk80EW3mQw/naHJdWzmDh
 gcNxOzT3a/f5FdR1Rt4rfW5vNg/OvjHGXsUR5RhEwWbM6mJGNzBUPQFP8Ko+F+ZEP1Z2
 0jCN+96GwuHyb5673FY3w84Hczr9M38dpfnBylDQmj1MY4aOomrCA874abE76Rr71zBP
 IEhW6nJHr6x1e1uElsGMx8CrZuAl7ZdEHg0dl0UJfVXK1LDr+t9uXVxCdYctZAF0BQg+
 BsXSHodNr8hj5qRfk8kZCCgikDExiMuCy3QEcC1MEkvG0THjzNFufFVi0M2HbbUqR5v4 jg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by m0001303.ppops.net (PPS) with ESMTPS id 3nfq37mctp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 14:28:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MswHoz/S63wZiHu7nJ1UicyQisKFjo5cznmArvFCvwnXpbCLx3Km+0l6vQrcVCELEZmRJKrg5kK9uYskGV9vbpG3/NuSHKa0A6epY8ONehewDNDgeeQ7dSeZHSJpBNMu+jVwJN4OtibqlCAvo6uxuCYSeBxUpHTNTEuJhZzDuZDtIiOeB+w3ZVTToZc6tyy1UTnW+t7XOx0tXCyPXWr1SQY7bkuxAUoVrJpEYDAKAu+fGYbna75nuaSzgZZAdqOI7md8Z9qJLofGSe8bZk8lVeOeRDo9vCBwqc7bH2NaCNS745RjV3I5fBoss73rmP5MvwBRIWPz6RYmk8vKSHI4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0ENKCazT+jseBpD+LNeCkCrq+EB84y6er3sgyRxkvY=;
 b=EixCNzapGDMgj577EzL6ymYpRhFrfvQemfTIQgN8zllogethIix5aMTDDtz2PYDm8kj24h8X9HIAsHb2B0pjujPqocULJWWkaSlQsv6or5iCe41cyvhzq4O1yIFKpesbnaXHj890hw7hfbWWeNFrV/gNKDy9qmmAFn6I9KbT4Q3BN4YM8cSE9z995M92IUZx6fJ3aiAp6ntaj7/ABSicbkoXL4MDXSvs1yrUiiFph2mMKipPd/l/xbFRVrS6cpvWIgIkzVAF8XXg8cpFKOHLLVhAapXQXXw8BV4cjdTlzhXlZACiPkANXyCOG679GZSPS9wvG9iNF0mGp5Ucud5BVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by IA1PR15MB5490.namprd15.prod.outlook.com (2603:10b6:208:3a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 22:28:01 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8%4]) with mapi id 15.20.6064.022; Wed, 1 Feb 2023
 22:28:01 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Song Liu <song@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Kernel Team <kernel-team@meta.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v7] module: replace module_layout with module_memory
Thread-Topic: [PATCH v7] module: replace module_layout with module_memory
Thread-Index: AQHZNm1FE2ZdhJK2y0iTaXPlD6FODa66micAgAAR1YA=
Date:   Wed, 1 Feb 2023 22:28:01 +0000
Message-ID: <BBCAAD9D-245A-4068-B7C7-01DA4E02261C@fb.com>
References: <20230201184422.2932156-1-song@kernel.org>
 <Y9rYcvPx4MhA+c+u@hirez.programming.kicks-ass.net>
In-Reply-To: <Y9rYcvPx4MhA+c+u@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|IA1PR15MB5490:EE_
x-ms-office365-filtering-correlation-id: cd03d6e1-3d71-47fa-7a74-08db04a39465
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eoaAylgtcO1lDbdq9r1S2SV3TEfvJZw8FPHlSCuH658Eam6LZcjLg2YbynJTmpog00TrupFk9RYjFTIVvTyG2r4l+5lEbqIog6aohy09Al+bGcKXmzhiSzRZ4sqt0DLabo2hFuJ47VKCUcy2kBPqrCMVOjlPF6oNPzTlNaBgRaUr+tIKW2E1DOeSMHY4Q/U/G9g/AqrCr0rODcTGTjM04phTh8Lam5Hz0hhls6MbbhMCh/gJLoooe9+7hA/3mK4fc0XkfkVQN2gR0jdanfFf5kQN/IZT4UWuiykcJs+0HMHWWlj4qM1Q/SRUq4fiXWcplGPrOS3lstlc1rnwAR8aAi1M24ruAaOkUdugd56mRY45XTSiQ8DimtPale4QSH1h/Xr4bPQyG7fpOHqHu4roEafOLReWSNqn1PcuaqwGBi9bQBd9eOeb7gPfZXUndq2w/+h10vywby38OO2j4/dlu9jpgl4LKbukXch87f5iTqJfw62Q9UK7NtWhYAcW2lcUXzTUp8qPWOVULK0OerIbH9xBQ4/EIrENWf5Y63Qo0A2peX1KDoefA4NEGzVWyvVKDLCvF5k6dw3v26dV0VJg4kyu56EZCAA+20q9l7ri2gNTqizFy9tqIMYl4gyiEHl7XldLNOPQcebZxUZOjP1Kl4PlcFyvc7vw8+yGzfC0b007Faga0ye2wlQZ3M8Ru2J9yepFDwsrbE0+55h8a1iGJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199018)(36756003)(38070700005)(33656002)(8676002)(6486002)(83380400001)(66556008)(64756008)(54906003)(6916009)(8936002)(76116006)(316002)(6506007)(66946007)(66446008)(4326008)(66476007)(41300700001)(53546011)(478600001)(9686003)(186003)(71200400001)(91956017)(86362001)(6512007)(38100700002)(5660300002)(2906002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?790JIULRrvuthA6SDWSd6dJ3XPYzy680Lljj4pS1pBhOPUQdCergoOYLxsSA?=
 =?us-ascii?Q?1fGkrVk2zFQSbTRHBpBHuGotSTj41IsBqJWEiJ7gpikPawJL/Xp4+EE+P7N5?=
 =?us-ascii?Q?yzBQJy2YjQiCqSJVPNrHS9RPNFb5gxN4X/a3+g5bF9K+zz8jibOhMvtxLs8G?=
 =?us-ascii?Q?godyVmxLX+1VBG1ZqRKfDvrrwvtq2axxlqR3JU8VuNoH0w2TNxws7TSosBwt?=
 =?us-ascii?Q?Ak+6jV2oHb9XssjFBM+8TzmEn02VmQLwSKDkP4f7U4UxA+InlhCW0o3wzepK?=
 =?us-ascii?Q?Cyw4LCKk3xWNXHjPS/jRVCQj5VZD1kOpUKSRMjxJOe3uO4E0+zjgpryg4zcc?=
 =?us-ascii?Q?+6PdDGb4fSVBg0h51KB+oBl9+n4L89Gj0qHvYvIDAwWYFdB5+Efca+GaJVIi?=
 =?us-ascii?Q?fPbzTM1t+9va5FscrVVLs+9rE49rAMF8kP6mvTM2XRv4pOQY7gXA+0Ak0NvP?=
 =?us-ascii?Q?LrmW4ve+NfdED5pDEJvEL9nz3nYrOV/rluJrfMSMglCVUETiYprOrnUljybp?=
 =?us-ascii?Q?9b4UD5WfasE7b59xgXAMLLvVeeVk98Xpru0bUllNcY5YwaMr4gMO/swc0Ayn?=
 =?us-ascii?Q?m8A4eCtjlQ2bzwXFl35+iN6F6wjyr1eDOnDulcLqfFtvF2oYGCUaLdV4wKjY?=
 =?us-ascii?Q?vc9FMQ2fasVipPsMXf2xRuUDKUfzlRuMELEKP2WUo/rJX+0tvYCU6+8OjMh+?=
 =?us-ascii?Q?TdYGUXmW+NwvDjTMk/APTZ9ePOr/Q8zsSd0tKTsq+mjxf99od+XIG+B/1nXw?=
 =?us-ascii?Q?3XrTDaOMQ+gD3XattwmDmNUy/PBjShvNiyhDmmbvw1KFqZkQPKVxzjwuuKLo?=
 =?us-ascii?Q?3dBl+l/fbKXun7qm3LY1NhNfOzr0y/lRVrvGGXEaWOVNLyAbsUsDSw6+4M8m?=
 =?us-ascii?Q?z26Hq6sy7ua2xW+YO/2taqnFFxQUmssRlrN+Cv4/T0BEvs+S+vA9uch1liT/?=
 =?us-ascii?Q?wWDTkOvlUO2c15BGhGjAcEPIGAzPuXOtD7QNv05eAbSiuQM1mjeLxRImMN17?=
 =?us-ascii?Q?Zx9KiBIpkXYYQ59MSgnOcdHEXomb+Lz34c2/B9lObkUqmKOtU9d+U4tU7EGL?=
 =?us-ascii?Q?eGU4jBF+fU+Zz191GRSqhwQZdRrJkmZ/cJa/ZCjbP+XjuoK+dT76kAdjksIx?=
 =?us-ascii?Q?+Q5JNqajkmou9prZONgTsCQXKZ7l6araZYpcKzHFB8r9T0ku0Bkq4h+iz9Sx?=
 =?us-ascii?Q?z5CCjZEFCn458/2uynvvJTfxFumMRjQTzj5bUhfvs+mamTi7y7Jstoq6ibcY?=
 =?us-ascii?Q?9xE/5wfSSY7IoZzlrXV3Rnw6qX4M1UNkDriJ4HymEPHzWEtKxArYtAhdvzFd?=
 =?us-ascii?Q?lbAdo5oCR/9PXTXwqlPGApkRZvG9BM9knt1n0Am07cbr4VKkLLQze0LtFO8S?=
 =?us-ascii?Q?zf8f47u3Z0Xgjo6ffoyHhoORaQ6Hjp/jhUasJBPpQ4opfiFEWT8myvmBHMgG?=
 =?us-ascii?Q?bpqKf/nSYIHp8phHPh62Gr3lkHZtdnVc3w+MJDtlmRkAF826s+DXAsbvADFz?=
 =?us-ascii?Q?RSqpvhnI+Q7cwB5XRnWHOwdESuUWXVMu3SnTB+JybQRL4+6PG3F0q9jNc0vN?=
 =?us-ascii?Q?R6GpjT8FooSLQ4WtCAMttHdhQCAOVHY9PHSnZM3A1rMxGcCWF3qk56QKUTpM?=
 =?us-ascii?Q?qmzO2iYs16o+fXwu1wduRCdCBLp2Bhvx/ljn8E3DpFP5?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C01A47D8EC90B41B3D7DED8A0E93C1B@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd03d6e1-3d71-47fa-7a74-08db04a39465
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 22:28:01.8603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: il03Z9kXh29ZRX2OavxaeNZAmqNnui3n889r6bd7O+a7nvkKykIZrbzbQWqDpNypmYgBjBFP7bussfbCzJ0DoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5490
X-Proofpoint-GUID: 0D_YUblXRWxaF6mDH_e2vTHJdOMfgq8t
X-Proofpoint-ORIG-GUID: 0D_YUblXRWxaF6mDH_e2vTHJdOMfgq8t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 1, 2023, at 1:24 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Wed, Feb 01, 2023 at 10:44:22AM -0800, Song Liu wrote:
> 
>> static ssize_t show_datasize(struct module_attribute *mattr,
>>     struct module_kobject *mk, char *buffer)
>> {
>> - return sprintf(buffer, "%u\n", mk->mod->data_layout.size);
>> + unsigned int size = 0;
>> +
>> + for_class_mod_mem_type(type, core) {
>> + if (type == MOD_TEXT)
>> + continue;
> 
> isn't this the same as:
> 
> for_class_mod_mem_type(type, core_data)
> 
> ?

Great catch!

> 
>> + size += mk->mod->mem[type].size;
>> + }
>> + return sprintf(buffer, "%u\n", size);
>> }
> 
> 
>> - lockdep_free_key_range(mod->data_layout.base, mod->data_layout.size);
>> + for_class_mod_mem_type(type, core) {
>> + lockdep_free_key_range(mod->mem[type].base,
>> +       mod->mem[type].size);
>> + }
> 
> Why the core_data to core change? Specifically the difference seems to
> be you now include text. Now, we shouldn't be having lockdep keys in
> text, so it's harmless, still a bit weird.

Will fix!

Thanks,
Song

