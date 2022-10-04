Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1408C5F413A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJDK7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJDK7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:59:14 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C1C57237
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 03:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lm7UEi5AOV0xNu1d1eHUbkgN2p5sYUsNZ5D3hGf+138eQ8vKeARfJBu8OWygoOP1QDU7Qrdkf0Cjvt0yXJvSxUj/FYI/eJXvI3QqiYvMR1H7GEiJdkHpDmwDdc2YsWV2pYnEyu+4kehp2v1y+1h/tMGyPWl8jW3g/2sT1Em+D0xnewInRDzGRnCDQ+zyhos7XSx4EyJzsa4/whBAuD1YyZPR86boH+q9QRn7TtDn+eqQDXYfkqKInOBUgQ7x0lMA+to9pHGnWX092rZmzk+UZzFO1yGqHfWeK8d1pV6vPQM8eM0Ma8w6XvRqUahTpbCleJJ/JiHyORFWRq0mgMmeZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5U+h09P+uAMkkShW0Lxk3PudcKWH0c//pqKniczqKU=;
 b=DBH8DRnENdJzsyPn4wHG3aZumvTX8KiSjiDnD3C0hbBvB4+e9xfEScxBJR5pfjeTT6frQQH/clFO8K5DZhWVqHhQ1GfP0jBUKo4LDMB/2EfBDGoZxPtr8bSuaqZeDi2y1xw1TjHcHdIAy7WOK+PZBsqFeUCN9sNiby+TGLTvollQoDtV3asJSeGnlHk3jueuYJbyoi5prPYABYdtbXqaLbinW28LD9lfWf5DKx8xZYEPYaySWoZ5yOGmFR5brCKnwTUWAunZyb71VUoiIw+ORqHFajfmkLl/xQDhkSh6YobnPoUjQmoMSFklnh1QSLbIFTfYLG4XjbFy1D71Iz6vsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5U+h09P+uAMkkShW0Lxk3PudcKWH0c//pqKniczqKU=;
 b=Nn7wtYSkMxsgiQ3YwwxnU7kXI29rE6XnUmj5NjIsgtv0LpaFWjlRT067d5HSHAn1keLPYT3WdY+OKNRul9ZMosNQa2AowCdL0MzPvP0UWjmxUqg3L40UQHvC/JR3ifVyO6shqB95zYDILwRrD5ZtRVQqN9dOdgDviqo5o3llQSbk/JLovMYkd7eYx5X55BEFzxE0Cx3gf7mUAmth9nMfnfFAp80cGRnFeIBuTMJjHd83SxgOtYkbpHAsmnBFvLbqJBfUv3Nuj0beacncgPGEX6sXLjC2CJ4Xt4N3QywFvCio6vAtr5TdZLOljHUxZxnBQ9xL2hZToVXM6qgCIDTE4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by GV1PR04MB9215.eurprd04.prod.outlook.com (2603:10a6:150:2a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Tue, 4 Oct
 2022 10:58:59 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a%7]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 10:58:59 +0000
Message-ID: <a070485a-1eed-420c-552f-16688e89d65f@suse.com>
Date:   Tue, 4 Oct 2022 12:58:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/3] xen/pv: allow pmu msr accesses to cause GP
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20221004084335.2838-1-jgross@suse.com>
 <20221004084335.2838-2-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20221004084335.2838-2-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0358.eurprd06.prod.outlook.com
 (2603:10a6:20b:466::20) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|GV1PR04MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: 4885cf63-47f4-4698-ad58-08daa5f77076
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24bvkOy2hU/EttfkxavwMpzv71uvGQjC9AcPF2u5BeWeG55JKtKr728v9bYb9h0tw9lGRWXfEtJmYCYJKqKc3c5YU2Ql0h6xzmpsHzL5x0kefWr0/SLd3LoMtmOPi/B3hA2TKy20oNnU+CDLM6AMl2V8AtJP/VbYgpCblpxPIiSvjuXsKnqA+8/+XMEBugS19tCbUoxuruAhLYRzT4C8u5FTyoVsG74q0TudPQ8FiWhQQlbkH6vwZ/v3Ggrxkr5Ek6wMDNoj6c3twX8vef4qCyhyeL5A80+4kBYr837ZZjZnZ6aXjJKDhLInBqI5oi54sXCYyKnEcC5c98GwuFmdyY4fWH2JDdowUTTuJh8Mz05BiYyT0Rua6VcAbnAz/75NcgFg+nkC//NBtQSFvQfRhjfSy+/TMNlqKLUb28AiPGnn6hfaZCSAVxKK3UPn+zY6FnWu4kcK/8fTEWljiSKV9fVGQ1ZE2ZA1m/4yx0YXkRURsL/vE+zecqqd4Y9wORiL6ne8NZyTD9C4WP70wgo5llCvfqbMaAgpfV2trhy21sh2ipWGAKHXjjY5nECU4F9QPHyq4Wqcc7fleKH9VI5h8m3scJradgUZpyuAAyw04+KIRK43lrUJZ9qmq1ewBZPQ3jqnqebmywE5n0/ACQJVNUhEpHH8Ur4ZfuDXHRc5p8YgjfgEvfJ9FqPsUBNQVbY9fmnnA/TiHKzBAuwhnJwfXbYSnkj0gDOK3YYnln1R7pkk0Yr0EcEeLNYfAoMUd1wtNi1km+REpFzuhJbJYuBZaq10VZ3V+/VwkMkqtAdcZxk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199015)(2616005)(6486002)(478600001)(5660300002)(31686004)(66556008)(6512007)(4326008)(26005)(6506007)(2906002)(8936002)(86362001)(37006003)(54906003)(316002)(41300700001)(38100700002)(6862004)(8676002)(31696002)(186003)(66946007)(66476007)(6636002)(53546011)(83380400001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QndGUGFnWjl0MUFEK1F4MGlSRXBGQm1QTXNsdmtieWhmRnoyQXhpY1BzK2Iw?=
 =?utf-8?B?ZXZHZjBldStzTFlEbzlraGpudzNXeWxlQi9iZ09YQ2JwWkwvWVpoSUZWVkxP?=
 =?utf-8?B?MDljZ1pFMXVjalJVVnBONks5TDFiMk1EVktuSUk0QjZCNUZRQjJGY0phZlVl?=
 =?utf-8?B?d0p6YWlqV2hzMVZsVUc3VEpPREZETFB1ckcrVmIyVkM0SU5PMEpwRlJIQVlD?=
 =?utf-8?B?VXU3bjNpNytReXdDYXZGSXN6RmgrQm4vdXJhb0Rleng1QlU5YWNHa3NxSHk2?=
 =?utf-8?B?RkRGWUI4QVNjb2dsRWdqVUNPOExLekUrUkJWMEJPOVpwWXdGYmRSTzZoZkh2?=
 =?utf-8?B?UUlVL2lqL3lBRW5oa0ltelhJd3lCeEJPZXl0eCtibllPZmhUeXM5RE1mOCtS?=
 =?utf-8?B?RkMwT0RBMWd4ZW1lcnpJUEN4Mzd1SzFRNm9LK1RNV3RaQU1DM0VneVBMQXVn?=
 =?utf-8?B?SWplb2hDd3NwSGZjZEU3NHNieXRQMEtqZ2RWekJrMndxNXozNWtoV0MxUm1p?=
 =?utf-8?B?eXNhVktLVUw2K2dZbGMyMkd5emFQdzRHNFVwZmpLcDNyd2trblBPUFJEL0Vz?=
 =?utf-8?B?Y2FHZlkxZHQ0R1ZYRW9GbnYwTHZBeDFQaHNvbUM3Mjh3c1A3SkNZNTJDY3ls?=
 =?utf-8?B?UmNWYlJsRjFqODE3MnhIWEwweGJnZWczNDJqNVd1ZytySWZ6R1RGNFZ2bXZv?=
 =?utf-8?B?NVQrd0pDdmxNdFQvYTRYMTNMVTVYTWlrVmozVkNZQVN1ejlsU1RCS0pETlI2?=
 =?utf-8?B?MHBCM2hMajlhZHBZVHJkaWZ1ZGJXZjM3UzQzbURpNTRIaVVIbEpISzQrRGFL?=
 =?utf-8?B?THgxRmtFTUxvdkt2Tkd1OWtZNmwxM2loc1FSNXN0TWVucW84VklvaVk3VjZ0?=
 =?utf-8?B?MWd0cDRtUUhYNFdSMW5TR2d6K2xEMVpCZXdnY1FxcDhTMUxvVmFnNVB1QVl2?=
 =?utf-8?B?MVBlYUYyTG9nbjd0UFRmd2llVGc3UlZZRWJ6cW8yK2tSeEluREJwM21aeGJO?=
 =?utf-8?B?ZUtqQUUyZERGanNmcWw3LzN4bVU0V0ErZytHZFR1dmJxMUc3M0YrQXdpMkR3?=
 =?utf-8?B?TVp1a29wb01TM3R2RFpYeENjZ0RSbkdqTmM5S005MzBCVGZmTS9ycmhwUXcx?=
 =?utf-8?B?TEk2eDZLeDdidUViY3JJM09vUm1uOXNFZDZEZVIrWHp1TndTNnB5US8zYnlr?=
 =?utf-8?B?UjZPeUtNT3U2aXdNRjFQNWtHWkdsZnNCK0thUUFFbXluZ2ZGTnN2ZVJMbS9x?=
 =?utf-8?B?bjIzMTBFNnp2MFJ0MmFhdWYrNENKcVkrV0Y5dnZSRTMzbmZIYTIvN2VyVWlx?=
 =?utf-8?B?Mkp3WEZjNVNwQ1M2THF5OEg0amU2Y2JKYms2bHRmZzhhVGNJWW83bTJ2cFRI?=
 =?utf-8?B?MlVhZ1VYa1lZa2M5dURDdWxNWmZVZDY0b0dKVFY3bnZjcWVDUHlUbVBzVHBD?=
 =?utf-8?B?dXljTWlnSVcyVWNBOW5QTlorT3p2aFFuMHJYdElJMU1yMStoWkdZYVdvdnJL?=
 =?utf-8?B?VVlSM1dwenBoTmhIOFltMk1WN0pGT1lwRGZ6clJtRlpIdkdMaFdtOW5TL1Bm?=
 =?utf-8?B?NEtJVzFwYkg4U0RRTDdnd0dqWDdjVk5JYmoxbHl6M1JGNStLK0g1blRUVjZh?=
 =?utf-8?B?UkdNaXJVdzYybDlUVzhlYStqRWZpOWJHOVFJK01QSHhIR05UcjRlTDNkYkdu?=
 =?utf-8?B?WmZyN1NlMTdhbzJzcDgzNXRBZEdJbDkxOWg0c1FRbEhZTkRxc2F1b3JUdEJM?=
 =?utf-8?B?S0ZtcEphWlo1MldsSmJCTTVsV2drRDVndWlCb3hxamd0VjBxdXBabjBjWnRQ?=
 =?utf-8?B?SkEwdjdqMlFndS9lYzV0ajJFQ2hpbmVjVjBDeUFKZmJxUlRvcENhUDIzZ2tK?=
 =?utf-8?B?YnRRR2lVbks1ek5leVRxR2JWelhyaXdkYXRvNXNwdHpKT3FCNjhVdXpuc0VX?=
 =?utf-8?B?c3RDRS9pU0VMSjVrVlkycy9meXh6RjFpOU4yTUR2dWhnUi8rdjlhTkFsbXh3?=
 =?utf-8?B?VStwamtpK3F4YXdPWXg4RkYwMFlDZitEaXlRVGtScHJSdmRIQlpqZ04yUzhV?=
 =?utf-8?B?NU5Xbm1JYnhOeUZSTjV5dURuSjAxLzlIbG5MVk93ZitKSlcyU0ViSjdEWWlE?=
 =?utf-8?Q?WzLaIyIUzLEkTLsNVHMPQpLid?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4885cf63-47f4-4698-ad58-08daa5f77076
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 10:58:59.0396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lbh+tVIqEXwygOZg5jVKm8Pl7MY4jE3naKFvrCWQwK6IgBgRiFnowf1OvLU22KS4pq2IuJ1e6ezYD83Yv+nog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9215
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.10.2022 10:43, Juergen Gross wrote:
> Today pmu_msr_read() and pmu_msr_write() fall back to the safe variants
> of read/write MSR in case the MSR access isn't emulated via Xen. Allow
> the caller to select the potentially faulting variant by passing NULL
> for the error pointer.
> 
> Restructure the code to make it more readable.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

I think the title (and to some degree also the description) is misleading:
The property we care about here isn't whether an MSR access would raise
#GP (we can't control that), but whether that #GP would be recovered from.

> --- a/arch/x86/xen/pmu.c
> +++ b/arch/x86/xen/pmu.c
> @@ -131,6 +131,9 @@ static inline uint32_t get_fam15h_addr(u32 addr)
>  
>  static inline bool is_amd_pmu_msr(unsigned int msr)
>  {
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> +		return false;

I understand this and ...

> @@ -144,6 +147,9 @@ static int is_intel_pmu_msr(u32 msr_index, int *type, int *index)
>  {
>  	u32 msr_index_pmc;
>  
> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
> +		return false;

... this matches prior behavior, but may I suggest that while moving
these here you at least accompany them by a comment clarifying that
these aren't really correct? We'd come closer if is_amd_pmu_msr()
accepted AMD and Hygon, while is_intel_pmu_msr() may want to accept
Intel and Centaur (but I understand this would be largely orthogonal,
hence the suggestion towards comments). In the hypervisor we kind of
also support Shanghai, but I wonder whether we wouldn't better rip
out that code as unmaintained.

Jan
