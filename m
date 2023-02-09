Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F26468FBE4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 01:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjBIAQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 19:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBIAQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 19:16:51 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DE612075;
        Wed,  8 Feb 2023 16:16:50 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 318JV2NY009603;
        Wed, 8 Feb 2023 16:16:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=iBrHQAKUNQARYT+J9mr0heOV2/eGYHROPOU9Mq7ytLg=;
 b=j+x5RE92iG3J9p/4HiEEnkF8S3ZA25GDMrg+tnz0J7xatyXJJLzhe/PqeBb0N1x9PFut
 yYdarv9oSrt+LGHH/irgZyVXzlWb0JQt/ynkOqakPIUP9zVvqlRqnmB8FEsl86vBtygL
 gaxGnQNqNaZOy5KLituEHmH4f+x2Hq/hbzBGcuMM86+bjDsThxlm5+ICA3g8DtqfUmYk
 FyDKUMBkHa/6Ol2ZqpJd+3rxeRGYfh2+UCSIiFDoGVx4Q9XzQZC7Kk1lXK+CpeFwgEQb
 ADGwLzaq2WECms8u9KHbQj5U0mek/2do6mWt2bC9AyOg67xWOqZgzk2520FCqMX3m6iE tg== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by m0089730.ppops.net (PPS) with ESMTPS id 3nm8st65bt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 16:16:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBdIomAsqvzotJXbVCulUYz8moW1LGA0MboEewabHGPlUMWQdf0LEHF/nZmUvIOo995IkGGmhmmBD8gO/Ft0BIr0TMIvX3y8hSQE46dc0Sbjpv4Bu2klj1Cxw5BfrDgka5Cu5qIkWxG011fhjiTIxxyKUcFa/1tvzrLzq2QTxG9tcoTRGSESy6nxhSuBr2MI1d/LkVmlzwiMTGJUOiKcMmEtScDoYMfNCTjERSVzE77PmFftrbX81deB7YmZPJCwEYfLueKalxsijNT9jhzpFb7sJIOJHZ6tzoMC8zVixjRdjIH4dJrRl78NPTHTJewVXpffYAAdKvFtXAsVXmVc+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBrHQAKUNQARYT+J9mr0heOV2/eGYHROPOU9Mq7ytLg=;
 b=m9Wj8AYjH8midriaRslIRNX5teJJpfAv8YBGuPZYj8faUsc3eUnQylq2eQXto0K70wISsjRZ4CO/IOW7K4KUuq/h0mAddFLaa5Xe9DmZgxo6+inmQ8yQzRFfCwprZDaK7O9vmm5gTlzj8zW3JBB1J8BYGTxucWdHQYwWayJg+JX26AtRCDwyTGULtXImF6jDSjd2VYSHkQ4TLjEVRcpP2Bm3XNMxqDxBQbCXXnHNxnFbrcTRQ9U9CKIGhj9TQCHl0eA8pPY4Mog2wujXdInPQZ4xfpo6eu7RGF5+d2mJOm/XJdGr2zpCsCNBmAPm9+/A64NuQ7rEHAIgqjuSuSgAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB3750.namprd15.prod.outlook.com (2603:10b6:5:2bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Thu, 9 Feb
 2023 00:16:46 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8%5]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 00:16:46 +0000
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
Thread-Index: AQHZOosWgrFk94mbpUiAn23Fr3awBK7FVgEAgABscoA=
Date:   Thu, 9 Feb 2023 00:16:46 +0000
Message-ID: <70DCC6C0-53E2-4C18-B147-B2F600C66E54@fb.com>
References: <20230207002802.2514802-1-song@kernel.org>
 <b40ec330-8c9e-0265-19b9-d82b516c95c1@csgroup.eu>
In-Reply-To: <b40ec330-8c9e-0265-19b9-d82b516c95c1@csgroup.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DM6PR15MB3750:EE_
x-ms-office365-filtering-correlation-id: 48a48297-eb53-463a-97fd-08db0a32ee2d
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VK3zHUOAaPYrLBPDlFIBZIlG4C7A5UBcsjwuZ1860voVz7cBuGccHYV3ffsAgM0Ye/dmIXSXyZupkbB8RGwkIHdSWQnEa6AH/QUzHVhJBAtXB9fkwoRZUVd9BRjmO93zXtaMq3GTRqBeOPlksaWVqeTh2YNPyX3cnRD0FK/4pkV/9cV2U8xUsKoxqHM94k0NyTfGYfn90mY1T5eJA4ytytkBduSPn1f+gBBztM4MHL6PZ5Bsoxt8zyI4/VmkeP4gJiH0XnxrFX7KzYNrlfp6qaGpvULjLQickGr99l0piCyTCB+S0X26BSqKV8XXL9yYM+kz1e6KausUu1u0zcbzikkdvcpalmibj4hLyETHO3jVju3dGxeY7xVj5k9O7zEtYbbixgzC/kt0ZWdN/myKkf2nMf3DyvGPsVv1V5VJB1Yz3P/42vcxIeavk68Lf9G+M9tL9f/hkkWcx6kecEzwI8dY+7sGI6FauafSHfQMuyY+EA9/L8HsHW7qlpTMMJzC1+hGknAytdOeV91WvBwzp0lqmxQXagYU4Dch0LUhlDsshDeCPBZ+pIvbgh0hiAJ7JTGX111MnJxaslAAZJhqQl1xz0XCKI20Ct16ZQgJ/BRUYDsc1Esbyx7qiveE3X8SdocKxF1oRuMXGU9T9wk1p78zlVhbm/1ZmJOLselsIE++nLBaJxe9BmA7APn3EXK58cOD3H9s29UnDAntwQNXAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199018)(5660300002)(36756003)(2906002)(83380400001)(38100700002)(38070700005)(76116006)(8676002)(122000001)(4326008)(66946007)(54906003)(6916009)(91956017)(66476007)(8936002)(64756008)(66556008)(41300700001)(186003)(66446008)(6512007)(33656002)(9686003)(71200400001)(6506007)(53546011)(316002)(478600001)(86362001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a0IUJ3oKHsOdeyGrdjpICREo4bms3GPopRtqvBJfhdnrvii6GEZI82ZsV94P?=
 =?us-ascii?Q?RxSAPuQfoHvWWBu39TM7tgj75E8bJu8RChNmOEGhWvz6zNRTm7Ei6jGcKuWw?=
 =?us-ascii?Q?i/95rY4lR8ibFUSlofA0QaWB1YghAayQAwOC86ukkawijfa74XC/fkf2Gwl4?=
 =?us-ascii?Q?2y6rsZTVC2f52MoFf2xJhtXznAt2jzyqs0lhY+84DaR6Yu21cTyo9g8mkCh9?=
 =?us-ascii?Q?vKQqtegZcYBlsnBuUEY4j16miNrlJIpj+Sn1b4b8F5m4lXmvsyHn/wCqzQps?=
 =?us-ascii?Q?PGRPNFjg9GDB8gygmYKeoAZbPPiNUckboVkYgaCIVOphIMhKY0o0615Pw7q3?=
 =?us-ascii?Q?gzTfLt6B9fT9/AeGH/eQOM2gT+29O6CYzVjrntuhmgjG2ILucOy129hUYrMr?=
 =?us-ascii?Q?3/BfA28JdgfXs4PdegEoF+Z+f9fRrp5uKPAKxZ4s3oWQkfjZ09bFAixxFsbc?=
 =?us-ascii?Q?SpYgvgDI24NbgaFJSxU4xFQWgD+50ZuRJ+ArpaTpXXP8qtt8GJn4GT/3CpZM?=
 =?us-ascii?Q?xRA3exOjIBjUt41L6sc2mSjFk6DVeXk7szCgswkwbBEJhsaN7aFWP6rUAa4G?=
 =?us-ascii?Q?SVWQaz6CYUyUicksg2kubd81Vaw4YDWYsfS/a+qLSI1M9sWmE7ArrAR+CeI8?=
 =?us-ascii?Q?5zMdRip77/XOHePFFYzrEgvlwi9zipTG/1ZEMcJ+hk5fafnteoRQJ7Ex4cWB?=
 =?us-ascii?Q?ugIgHZLUDtVPNL+mxqgIizCSLCaC7P5zIfoBRPquTfgXk8d2/H1Qj/GZYKF4?=
 =?us-ascii?Q?q0xGCgp+n21vLR/HOhR2yf0s47C18x7D4fGNU52FPJv6A5l3nBSDjpSacVEd?=
 =?us-ascii?Q?FekFXRWG9Jl4H0ZXaOHVXVpweaTW3A+DCsQSlZS8B42w4t3I5/psEqL/hE2s?=
 =?us-ascii?Q?iq0y39n/P4vRzoxTuvUEa4zs1cuJ59mFG7StlE3YxKE6iRC3TNowvedggi4f?=
 =?us-ascii?Q?WgKPcO9EYd2YE3VkwMf9ZzBmsDGpuX8V6JrdPCOW2gpfst7BwdUC7Rrb2QEO?=
 =?us-ascii?Q?XJVq4ib+I4PCB3ZWbCFj8FNnFz5yjZz5i5uUKDRWhp1qPvnfhR2rQzsGyAxI?=
 =?us-ascii?Q?0iaIO8NRzqYyJ14+3qPIGQGYZi6LmNtrnhtny6eSTNVofGiAGOTnk1HxlIq4?=
 =?us-ascii?Q?6/nn6i6hpCOT4+bOs+lps7XvKKYikI7CG4ScKDBm3fqL2xudjoIeFNuqePQb?=
 =?us-ascii?Q?GA3xeL4gPghNiAyWcC4P2zgbg9Rd+aGLPfNZe0GcaSxGok4BzL1ekvH1AMO8?=
 =?us-ascii?Q?zFflg9qe3WU0BK2ETrfHUlzlBBxw+z6qHOdc6mNT9EOBCMnuQQKlWFdPp79h?=
 =?us-ascii?Q?5Lr/I6VghWiK18BgxsupFddBuGYydvsnCWKLRZo6VJzpkTnp/RC2TJKABrh4?=
 =?us-ascii?Q?nRPsJCT1isknFx3GtZSKsj7enofPUVL0zr3+Ay7CpENsesHCBwuzeGIe5x23?=
 =?us-ascii?Q?F3MS0wXP18bLXNdeS6kZVIyjL25RWYXcoEDHJSZ8XTj3kO1Luc7A+USiXYRU?=
 =?us-ascii?Q?jyK7CKLn3GCmxbdnuRmILYoFpptMkdmolII5LNDuCJl1o/slH5QI8dhGserb?=
 =?us-ascii?Q?CMdVJmWJzJyJPG2ItgzaFpvwA/b2zPZ6e+BXqhGfxvNExiepCqVBNKkNe0W9?=
 =?us-ascii?Q?/IeMUb2uep9M2cLGviVGNlhY7e14N/j8b7VwXCaaCSIN?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E55961A65FE9F478901CB17298339A3@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a48297-eb53-463a-97fd-08db0a32ee2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 00:16:46.3040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TZGp9AngZuZh1dznm7KDYFzkvyGtAPBV/sFzoVU0n/iI8bfGzaCrULL7YL7u18iS6Ne3uA+/V4htuCHtRwXTsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3750
X-Proofpoint-GUID: bXzVL_WUv-YJAK4LQ1kbaIdHIEnIKqz5
X-Proofpoint-ORIG-GUID: bXzVL_WUv-YJAK4LQ1kbaIdHIEnIKqz5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_10,2023-02-08_02,2022-06-22_01
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

>>  {
>>   unsigned long min = (unsigned long)base;
>>   unsigned long max = min + size;
>> 
>> +#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> 
> A #ifdef shouldn't be required. You can use IS_ENABLED() instead:
> 
> 
> 
>> + if (mod_mem_type_is_core_data(type)) {
> 
> if (IS_ENABLED(CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC) &&
>    mod_mem_type_is_core_data(type))
> 
>> + if (min < tree->data_addr_min)
>> + tree->data_addr_min = min;
>> + if (max > tree->data_addr_max)
>> + tree->data_addr_max = max;
>> + return;
>> + }
>> +#endif

To use IS_ENABLED() here, we also need to keep data_addr_[min|max] 
around. Do we really want them? 

Btw, we will think about all these details again with the type aware 
module_alloc(). 

[...]

>> 
>> +
>> +static void free_mod_mem(struct module *mod)
>> +{
>> + /* free the memory in the right order to avoid use-after-free */
> 
> Instead of 'right order', explain what the right order is.
> As far as I understand it is only to free MOD_DATA last. Everything else 
> doesn't matter.

I rewrote the function as:

static void free_mod_mem(struct module *mod)
{
        for_each_mod_mem_type(type) {
                struct module_memory *mod_mem = &mod->mem[type];

                /* free MOD_DATA at the end, as it hosts mod */
                if (type == MOD_DATA)
                        continue;

                /* Free lock-classes; relies on the preceding sync_rcu(). */
                lockdep_free_key_range(mod_mem->base, mod_mem->size);
                if (mod_mem->size)
                        module_memory_free(mod_mem->base, type);
        }

        /* free MOD_DATA at the end, as it hosts mod */
        lockdep_free_key_range(mod->mem[MOD_DATA].base, mod->mem[MOD_DATA].size);
        module_memory_free(mod->mem[MOD_DATA].base, MOD_DATA);
}

Does this look good?

Thanks,
Song

[...]
