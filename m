Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4521A5F46F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiJDPuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiJDPuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:50:50 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70081.outbound.protection.outlook.com [40.107.7.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA5414D34
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 08:50:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVSYCirkyubzwkrXD56H8Knlr3ivNVnGmXnnOgvaPXKxEOL/cCDRXdIlN8pTMdoI7orfvAvg59Jvhf6reiYwypGW+FstJ2VsKBn9LyEUr7ThuaWr+NPoScibdBVJVZEztrPoBcaid8D9o2aTvnKgbs+9cHAnm2MztXoNCG///818dk6XMegL090e2uINhCOHx60TEiKHDqhmQ4d6rnwmAQh5tYGmW2STMiJKaCqUXphvW8KW+cIv5aDQ2+Cy3DfJiCYpp/45rIVljWKhokHRv4lMWu5zk6z/4qwmo5ub20JCFkdJu48Hf6tKhAl7WAtLAM3aiyHpmL24NUsJilZQ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcaHuErX/8Kpvan/3rJElGiQjGhjgRW18NtgU3kxAdU=;
 b=ActI+yBDM5aSyVz/y7tINBafs/TxEwEedImjje/OvSNZmSYeStzyXwDkg7M8+yLDPB6p/ugsWHNw5RzOFKpBDwZmZNzl+STh+5yGGpfHoxWMXNr2LjGv21HOIkKLCr80NEwPWVRUUazQU547HCdD3S9yz+O4bpbjQoFMeA2EoUUfsTF3j8ivsIbuoJZr9GoPX2J0zheU24dh7Pzp/62uShArwXblZTusUJmpThHxNHDWX0epCVVbelenn0YZ3JSgTYeNOtNXajp11CtwgSOtdHfqRu7pugJH7lj6DDYqaYqMxB2c23VsPk7YTkPbBg+5mq5PE2nm7p0t3cs/L5MsBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcaHuErX/8Kpvan/3rJElGiQjGhjgRW18NtgU3kxAdU=;
 b=Yb+UqJSWqXsJeqxeqB6+e1d5GIxwPZRw5dHiymZw/kNGbDVuh9/LZsMw/7FKrTfQ5vz234yciK5iqPazrQLDZrJpDhQAbRta9L7qUjra5/9ERX6BuA+0YT5KAeFlP9iYwa6iDf/pAeutkTfsVM0xH4k2aCE8OWhYgGpQVn6YZA9z6jGv2RcOuHB47ClMReHBoyzTQZKx+uCgcEyWJpq5Q4JDVkTy593OkDlCqqSN2fNFA92ZKptSqZq+G5MYtendi1XViXTBQE9vyB3C01CtXwbbD3P1dW7+PDDVdEbPL9eq0eTVtFVn5iRglLnfiMZ7p55nPK4e3t7Ry8oBoKBwyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by AM7PR04MB7125.eurprd04.prod.outlook.com (2603:10a6:20b:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Tue, 4 Oct
 2022 15:50:46 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a%7]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 15:50:46 +0000
Message-ID: <7a453c41-37ca-6fdf-90e6-333c35fe9489@suse.com>
Date:   Tue, 4 Oct 2022 17:50:44 +0200
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
 <a070485a-1eed-420c-552f-16688e89d65f@suse.com>
 <e5d0e772-ec9e-049a-da85-960c14520f8c@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <e5d0e772-ec9e-049a-da85-960c14520f8c@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::16) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|AM7PR04MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 907fcfaf-531a-4496-20f7-08daa6203385
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0gmhZKA01N8xHF1NSI9ICbQcO1BJcW4TLL8O3b49m7EdZ4Is6de9ZP2GggtEzI/di0ybvO5CNcg1+VWylOGkce3KZMiA1RYytckLoiTGW5PMqYSEO4pLYrvCmm9VWOMP7B3v1Us72cQ1sHxRfpWDervyXZVtBFgMP3wwnJiS2Y/lqiu9GUAtINc0AQ2u48FNfD+KcsCWbDnUvURea29z23RFbWvzf9p2p/3JmEMFxdFb2hrC71RyT9GFdfx6vcEYqJZ/RBvSgBu5DG7+HHSjAWa3CFlPQiqKWK2sZgn8d7WwpcGNZj0iG//zJzgFMSKgVPUQQu6GPm9z1kt0sk/uXzRU7qMeFzWQU2jywUVIZFY/FufEv5RAWs5OWJKignrU4E5FJ6GWCyFPEPMy7fw8M79rcgNZ52/kh8gjqdIOIRrGXDA5EH+WVaY4DdQ0J1EKTinxEv4EVs126HzXXaCbaZ5aDw93n5E7rNyFR1meEwq/5QX+NSQX5CJlZORW75AR2QUDGHYWAYijRKls2QmVdS9tm2PEh4PyJDoWU2nyG1vewdpkHUXPP298mHk1/tYAdwdyaf1CWBuOfp7sCKO5Mb1f/DVvzJfnqby/YwzI7rzYHKMFZePI6klyOhfPT7baDs9DZzydkQqPZXSChO8bBlaYpbycJA3oOngkrVp02F9C7GlEpT3ath6ScI+8xnAZnONE7h/4YM+jmm3gLXKaVt28VNAyz5vswnJy2zu2p6y9L0XiEy2o/wNnYbDi+m1yfI1yiJ0+UuhCEbWcPqDTqXaAmqcUC0ce4yHPENqw6B8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(366004)(396003)(346002)(376002)(136003)(451199015)(86362001)(36756003)(31696002)(478600001)(38100700002)(2906002)(6636002)(4744005)(41300700001)(5660300002)(8676002)(4326008)(37006003)(54906003)(66946007)(8936002)(316002)(6862004)(66476007)(6506007)(83380400001)(2616005)(66556008)(53546011)(6512007)(26005)(186003)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFE0YzRDNEMxTEJlOUc0aFEwZkFFUWo2WUlPTnRWKzNHNjljaTRuWEIzdWtY?=
 =?utf-8?B?cEJrZ0l5VFZVZkxJVGJxeUNXK0dxVGF2REN4KzkzQUJyY01RWEdPL0lYcHNJ?=
 =?utf-8?B?cVdTaGIzdnJmaUw2dk5zbm1YWGorbC9iT0pEV2p4cFJzeFBPWXgvQThoVW5l?=
 =?utf-8?B?bW9TcEc2U21vTXJlYm4zWTVjTWRQSFVMYmlraGtDMGxsejZMNTdYME5sOGZM?=
 =?utf-8?B?K1dPT2lZNGZZMW1MbnFzRVZlOXZZYThjNkY3bXhhdmZDQ0hHczVVZXJRQzAy?=
 =?utf-8?B?eDk1MmEzbFBUV2hEU1JkaEF3NmhNU0o2eTM1bGJrVTdzKzRvRERJaXVSMUpI?=
 =?utf-8?B?UzlMSEZlYmtEa05DOC9SS0x5M3pNdUZadEJGVkFsUmxFUW5qbWtKaVBiRjBF?=
 =?utf-8?B?RklDWWp1R1N3QUdjTWMxKzNDNnZmcDRPOEhrbWpmQlgzYXh2cDRnZzFCRUtB?=
 =?utf-8?B?Wkh2NGxRTVRnMW8ySkY2WkZ3b2thd1N6d0hmOWQ3MVh5bkZWejdEMy8wYXpS?=
 =?utf-8?B?YzZrcEM2NmFac1ZxbHdCMlU2a28rQ0FZMTNVR1B3YWtxRkVpdW84Vzg4UWZF?=
 =?utf-8?B?V2ZmSDBWQ2VuR0NpSnZ2UEsvbDIzb05NdUtLaUZYbWNRN2NsNTk0akFJSXF1?=
 =?utf-8?B?ME1SanZyb3dhVitKRy9WRWdkSHlxd2RERE5rTm9JTURRMFd4WXRSU2UxZSt2?=
 =?utf-8?B?UENCekRBN0ZhN1Q4WHVMMFg1TDhEQTRZU2xTVjh1WWhLNUpBcVVsV1NuZmdl?=
 =?utf-8?B?NzByVU9uTS9aNjM4R3lJVUhZYlBKV0g1dEYyeHJJYXBaU0ExOVVWZmg3eFdZ?=
 =?utf-8?B?Z1Y0LzVXc3JmQ2kxSFF0K1piUDd2dVRPR1JacjZLeU8xenVFZzdVV0paaUpn?=
 =?utf-8?B?NmRXeGJHRWxKaVUxdDg2UHVKdTdObEwxckpuWnIrU3dpOTJ3UlZRUVF1Qy9E?=
 =?utf-8?B?RU92bTdjaFlWbGQ2SEdVQVRqeDFRMWhhVFZzM0hTZGhkank1enN3cE1yand5?=
 =?utf-8?B?UEFjMDFwR1lwNGg3SVEzejFiOGJabUUxOXlSZnhJSWdjZ1V0R1dIaUs3ZEVH?=
 =?utf-8?B?L2w0UDkwUE13ZW4vdlE1d1JGbU9XWVdFbUtoakFLOUFUUTdHTitDcUExSlBM?=
 =?utf-8?B?OGFacStyOEhoMGFjUnJiM3VnaFlUYXlCMWt5Y1NqZ1RRK2xOSGVsUUJjQXg0?=
 =?utf-8?B?L3lsbzkvekI2a2xiNFhtb0xOR1F4OC83UTh5cFh3aGVCWjd1YUtIVmxIWXBI?=
 =?utf-8?B?Vkp6dFVmWW5xSll2bmNlS2JNakhPTTk2YkFwcHFYTmxmYm1KazRMZEljd0FI?=
 =?utf-8?B?ejl1ZTFHMEwvVEZpUWEweUZCRkFjTHErUzNDSDliWWpmaW1qNjdLdE9ITDQv?=
 =?utf-8?B?T2dkOGtxYmQzLy84OG5NUTNnTjg5MFY2eFJNa2FlMngrYWhyeUR1YmZLQjVR?=
 =?utf-8?B?b1lPSEJHRlRCTTdmRkJSQWdNRDI0ZlpraUF4ajZzRGVSOS8wbFplUDA3ZGNs?=
 =?utf-8?B?Rk1TOUE5L0tFaWdpVVo4c2drK2wvQklMaVFkd0h5K3NVcFdCc3VCQnN6cCtX?=
 =?utf-8?B?bEhmb2w2TU1PdC82ZlFsLzNjL3dKT3BrS1loU3NUaDZaUDduYUZxWUFJdGhT?=
 =?utf-8?B?Q3gyaXQ0bFlTd1BaWnlZa2F1R2xHS2Zld0FVRzdqQkY3dG5lVzlNV2hFc0Vi?=
 =?utf-8?B?WTdNWHNuSXFyWFhvZkQzNjRpQWZEM1lneUR1cWRsMHEremVTQ2VaamVFdTVX?=
 =?utf-8?B?T3Jzdnd4aW4xTTB3RURNTnlPZitjcERLS1JaTzlIbG5LcXBJK3Fmc203aVNW?=
 =?utf-8?B?MThnRlJJckQ4ZDYxa20wTkc1OHExU2JzV2NSZmM3cXpXd2hjUnZacmF4Ym1M?=
 =?utf-8?B?VjY2R0JXc1BadmVtd0dYcWdMYjFRU2p5MFVGQWRnT2JrR2pYYWd2MFZmbjlz?=
 =?utf-8?B?aGh1RTU3VUFEYVFOemxVb3BjSnZwWEVMeUkzTWkvQ1FOaWc4ZG0rSEY2TG9K?=
 =?utf-8?B?OEFSWFluK3VpcW5OeXY2NUxpZUpxbWFLRG5ibDg3KzNpaDQyM25rYXhjNURM?=
 =?utf-8?B?bWNiSGp4aE9PY3lLK1NsK0RXc0FCL0pHeFk2WC9rN3JkcmFXeWJ6RjhaTmZw?=
 =?utf-8?Q?wMXaJSfBFwi11ZMlqlswy/zlk?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907fcfaf-531a-4496-20f7-08daa6203385
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 15:50:46.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5PUKfyXsI4hmrn+dzhs/LqJLhbZD7HN8ySFIA7AF4wjfjDm4eN918pDsHHZ1g0uIIlw+YcfFYLbiTRowpzmOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7125
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.10.2022 17:22, Juergen Gross wrote:
> On 04.10.22 12:58, Jan Beulich wrote:
>> On 04.10.2022 10:43, Juergen Gross wrote:
>>> Today pmu_msr_read() and pmu_msr_write() fall back to the safe variants
>>> of read/write MSR in case the MSR access isn't emulated via Xen. Allow
>>> the caller to select the potentially faulting variant by passing NULL
>>> for the error pointer.
>>>
>>> Restructure the code to make it more readable.
>>>
>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>
>> I think the title (and to some degree also the description) is misleading:
>> The property we care about here isn't whether an MSR access would raise
>> #GP (we can't control that), but whether that #GP would be recovered from.
> 
> Would you be fine with adding "fatal" or "visible"?

That would help, but "allow" also is a little odd when it comes to
(likely) crashing the system.

Jan
