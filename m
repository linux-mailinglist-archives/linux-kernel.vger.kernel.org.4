Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2B864A53C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiLLQqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiLLQqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:46:37 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1CC10FC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:46:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1iau3AJ8F01S+LlUjovw2fzKcAy5eehfy71SEie8RV+Pxg8433jWpGMSHlyqv6AxnKdOMuDWLfs3TLOJmVLucedveJEU32PRFDvna/pgrJlUh8qxllEdx9pzN9b5u5j6JM/hCvjc8QqXQUVolo739+jDI5X3UZx9uW8KSXaxuuOGi7jsgEzFs/y6XzV6F0z7R182jVZiuKqNviD8rDyZ7bNXzr/bHFvS/SugO1FMs0j0s1zkgss/AaKdOBOcnqLLVJqiGpPtfWPPl9pLoRJuu2ay8zoJT6Uc8LIbUSppl1So18kZx5tc1nI7Q8zdjZ2EVnbw2q3bgFZKynDPeAZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXcmxDBnFGuVwe8aeoBjo/cLDagYAR7pQ4F6dLNp6Vo=;
 b=cn9cuvfyyLwEx3QREd/cOradxsu/YbjtZzKb2tlgiokKjM6Aw0iCRTTycNjrmii98Nkt26vRkt3mg3yur9JlKmC28SHDKaRBCeqRJJI+jpsUgswjTzptEz28G47lU5uv3zeTVtEkRvGO7ivK4Flg2ON9VWCpY6VwRDOjkWagEMBvUegtucwtLKJfeiBTSmyzmKGUf1gDhF39gnOtbU5pClLGFsEwXWheCrtuK+20R0pnxHAum5NLG/bLcYQBbcOr0ME5rzJfrT3ISk6cCSyi6CKxMR73KX6CoTGUgkGLArOQkW97RAmqn0jCkpOQNHL4hGuLGmbEyWaNxB9le4pbFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXcmxDBnFGuVwe8aeoBjo/cLDagYAR7pQ4F6dLNp6Vo=;
 b=BGEecH2CT8sih1QoU8jkn1q1M/RuyP78POENMneODJeaPVMje2JWX+QR9On4mTQhr3Egwjkra9hlT0B0UGzz7BnTG9F+Ngc7Hu0pmlNkRWipuMhPYzhrVo2knWBJafA0O4D+cF0hEFS/g79T/pRhZZ5F/4oD045Y2SUPjAxvDPDI2xma4KxyDYHvaN3/iA6zIM9jSq/58quFSE2mh5dhii3/IuW6NZnH7xWSUDG9OV7ZBysGVm3fYfzrLSgFzmTdN0IgNyR+Y1wlFqY4WpL66cXkjwrETPU2gvcWEiLwVWjwMYi0eMNGbm8L6k0QSenbAooGSHaMFOzfJOR9YH0W6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by VI1PR04MB6798.eurprd04.prod.outlook.com (2603:10a6:803:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Mon, 12 Dec
 2022 16:46:31 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8%4]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 16:46:31 +0000
Message-ID: <1eb6048b-bf23-78a0-9c3c-54bbd12c3864@suse.com>
Date:   Mon, 12 Dec 2022 17:46:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH linux-next v2] x86/xen/time: prefer tsc as clocksource
 when it is invariant
Content-Language: en-US
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20221208163650.GA3225@templeofstupid.com>
 <1e6c1b08-d573-fba9-61fd-d40a74427d46@oracle.com>
 <20221212155730.GA1973@templeofstupid.com>
 <20221212160524.GB1973@templeofstupid.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20221212160524.GB1973@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::8) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|VI1PR04MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: f2694101-7397-4e03-59d2-08dadc606bc9
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTyy7whPcpty+nrSYvJQ0g9pz/5MZU9mlAp8tvBTGWs2cPh098fc/oVdGWx3OFvB3e1gVodKBLlL3RkKpMkNRMw7qFfglgiP3wh/QBihBCiFLSJeRoBJ9KS3drTk7xtq8/DeGLgbqEwtPwDRv7DyNdCO9f1ZJS1npD6qjD16dZqSGktKCgBDcy9gv/aiaLjQEnzOs/6d+ToYZcPAl/vlhew2Wize1d7Dn2hdt4MCsOU89FjV4yFDlpQlZDuBET77WeLwj+GDmR5CGFLL3GkAgfihKb3mPhIqlv1JDFp99QTK6O+o3zKuBJr/9h6Gd//7Yb7cuKAen+IxOpolkjFYVf5AfoNnGwUup29teVbO0lsvfj/+lklExkDQ3u7QhDGzF8l6aakpQdl2Xre8eVmUWAX9q6RSH+kS82+tZfgTI9b1FDrM4+lb6LboAu9TisG5PRoNw2Sivk/bYzYFCRQJ/tpD0+H43iA6y5cgv1REcnaMLS4UR+q1C6cMkVQTo/p3cL1ijVltrmIc8JUNuvPbxFWwnwPUk+D0PyPq3AWDAfwcoBeExEztMd0CbrIodCxqYWUG4gBOQB2Act7y+2tFI/LRcwOMCnZhTJxl3ouuQNZiPIhWhvAs9CFN8QkVVetEsSvcIpViv8osytU38PZYCla06s7ga2rKPo3bvzt8xHsq9wOzQFO5Zy5IPNRPqCzWxWj/Z3ZvKBvxLl2BeU0BVfLyud+K56dQQmSbMO2fOZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(396003)(39850400004)(346002)(136003)(451199015)(86362001)(31696002)(54906003)(83380400001)(26005)(6506007)(6916009)(6512007)(53546011)(186003)(6486002)(2616005)(478600001)(41300700001)(2906002)(7416002)(5660300002)(8936002)(38100700002)(66946007)(4326008)(8676002)(31686004)(66476007)(66556008)(316002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWlMMlk0NjI3enRmQ2VIY3ozTFR3eXpRV2w0NWw5WVBtZk9MQlFaOTU5dmlz?=
 =?utf-8?B?VlVlZEVUWC9FSDIwNS9YVDRLSkl2SmNyV3FJWWd0cTFUcEpWZmhGRWswcGps?=
 =?utf-8?B?YXZWZDJVMGt2elJSSnNkamZ6VWUydXNWcytQYXp4VHNmRERoTnpjRUxEU0Qw?=
 =?utf-8?B?MUtEa0dUTDBzNWl6cnRSckUwY2taamJCNVozOFRab3VEVlgvZzFFNWtvaVB6?=
 =?utf-8?B?cXlMeGx2SHFYTG82bktZcE9EQVYzb1V6S3RrTmpnUWs1Rmh1bUdKakhCUk5F?=
 =?utf-8?B?VS9uN1liRzlRbHMvaGdMZ01jcFlQZG5tRUwxbDJwdDg5UjZDSkozZWI3K2NE?=
 =?utf-8?B?Q2tLUkhhUjF2M2dZSUFQSjdKUVQxV2cvSzM2eDhEb0l4NHhncGxZeFhibGtH?=
 =?utf-8?B?WnJJeTE1UU54R0h2OU5lcXBBV3VWLy9hekFFbDZJL2VzemJBNlBQSUVBQ1hC?=
 =?utf-8?B?OUJzZStvVE1rZ3NzR0Q3aUVqalZaZUZhTUhOdkFxb2YxWUdDWklKWVdjOUQ5?=
 =?utf-8?B?YXdQcWdnQTZhdDBnRXJWSVRjNlVIcjdFMUNhU1Erb21uMGQvTGZHMjVGN1lD?=
 =?utf-8?B?d3R2SUQ5dWRic1VRMGlUZEltRVpjWXJBWFZvcFR6N3pZcGlraHVQd0w1K0N6?=
 =?utf-8?B?N3cyU1lOZHdYK2p4YVp2bFVuMUtKZS9kMkNPKzk0MWV3MDFTSmZGNmk0TmRK?=
 =?utf-8?B?Q0JpNFdBUDBLUHNRd256aU5COXZkMW9CRVBnMnVvUi9iRC9PTWFpdHp6ZHNk?=
 =?utf-8?B?UmZKWVZCVERCa25BZHJhTkR0MDh6R3dNZnptS3Y4YmV2bThRY1RrVmRKNE83?=
 =?utf-8?B?YTNyT1NjQ1NYWUJBazI0ZlRYa1MrdThmM28xd3N6YzVtVnZzQm14NG1ya1Z4?=
 =?utf-8?B?Uk5ZcGVGOWJUNnU1VUR1aktuQlBvREVsMW9UUDJpbGR2dkNOUjdTSEZNc2JX?=
 =?utf-8?B?eHBOd3pjTmo2T2NJQ0thYW1oU3RIYnBXejlNTXhJajdXL3pZOEptQ0VRdzg1?=
 =?utf-8?B?MzdCNFVIMG9uWkR4eDF1NHNPTDA5aHJsOHhNQjh3bmxwdndkcFRXN2k1Q2RW?=
 =?utf-8?B?dnlSR3c1UDFUQTlEcHU5YlFtVlhybXhtMWV6emNZWHpGS093dWNzQ2dhU3dB?=
 =?utf-8?B?emJIYk82c3pOUTJSb29rVjlNVERhNVk5QkFsVk9LcDhzNHZjbmRMVDlWWmU5?=
 =?utf-8?B?b1p0cWR4Rk9zWi9qRjcrOHJ4aEw2Kys3MjN2M09ySVhSNWYvTVhyZWFQWDVQ?=
 =?utf-8?B?T0F2dmlOdE9rM3QybGlvVm5vZmU3ZEhiNlgwaUNPWlliNjFkVmw2cCs4Z295?=
 =?utf-8?B?NGZqbjZUMGxVM0JQWnZGbWR1MjlKWWxRYWVrclpkaU1MdUU1Y2FEYW93amIz?=
 =?utf-8?B?VDNGUUdLU0huY3pnWWtoNzlJL0prQ2FkcjAybXRrM2hRNndWNjVrWUFFYm9k?=
 =?utf-8?B?T1Aza1NNcGR1MnhLNjJVK3RmajIwYzFXSGlORVFnWXJJOFlzTzV1NVdyckUx?=
 =?utf-8?B?aUFwRm1IRXg1VFpGUXEwM3pCTEFtU0xGSVZ4NDB5L2UwQnBoUnpBRjBUK0VH?=
 =?utf-8?B?My83cGJsSmM3THdsMFVqaS9BZnVwQ2JIakdBdThBa0lBN210dGNLRE0wQnJv?=
 =?utf-8?B?eEQvaUdsU1pqQmVHMUVZcUl1YWF0bktqZ2tiM0NFWmZNZU5WRUJvUHpDTmFa?=
 =?utf-8?B?ODRNMmlCSDg5bWtDM3paVndjSG85RmlzSHZnL1NpbjN6ZlZTRU80V0Q0ajNE?=
 =?utf-8?B?RENmQTRVWjJZWmtUTVIyWnlWeHdQWkxjMGNpbmREekdzOWN1dThsc2FldzBq?=
 =?utf-8?B?V2VEOUZRSDVQdjhORnJUclRrQlp1ajNSNUhDemZpYWRDZHhLeCtQakNKbjFR?=
 =?utf-8?B?NEhORHprMVJlMGUvRm5nSkEwRjdxcEhUbEhidEg5ZzRNdHJaRDZDVjNaZFNY?=
 =?utf-8?B?YnQ2bkhnSXoxTzZRRFVSajNmb3VteG9qYXE4K2Z1VktKaitLeC9hcW9WYmNk?=
 =?utf-8?B?dEtXTzNmZW9aVk9sMWxxdFVFZWphZVlTclNwVnNwdjhzWS9DeFlWV1A5YVpV?=
 =?utf-8?B?RjF4T2N3a3crZlFsN0tCUzZDNTBWMjE3K21PMDJiRVZvOHQrUkJnejMrekhL?=
 =?utf-8?Q?hvopEQM4DL6M0ARYfnZVhWvVn?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2694101-7397-4e03-59d2-08dadc606bc9
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 16:46:31.0769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EKwO1MJAXn/FvzmtOINtW5CN1Hwabtw8Gyhp1B69ydXTROCqcG91d+F3HjPl3PCj0O6eqjy+WqKzQ5h1wxOUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6798
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.12.2022 17:05, Krister Johansen wrote:
> Kvm elects to use tsc instead of kvm-clock when it can detect that the
> TSC is invariant.
> 
> (As of commit 7539b174aef4 ("x86: kvmguest: use TSC clocksource if
> invariant TSC is exposed")).
> 
> Notable cloud vendors[1] and performance engineers[2] recommend that Xen
> users preferentially select tsc over xen-clocksource due the performance
> penalty incurred by the latter.  These articles are persuasive and
> tailored to specific use cases.  In order to understand the tradeoffs
> around this choice more fully, this author had to reference the
> documented[3] complexities around the Xen configuration, as well as the
> kernel's clocksource selection algorithm.  Many users may not attempt
> this to correctly configure the right clock source in their guest.
> 
> The approach taken in the kvm-clock module spares users this confusion,
> where possible.
> 
> Both the Intel SDM[4] and the Xen tsc documentation explain that marking
> a tsc as invariant means that it should be considered stable by the OS
> and is elibile to be used as a wall clock source.  The Xen documentation
> further clarifies that this is only reliable on HVM and PVH because PV
> cannot intercept a cpuid instruction.

Without meaning to express a view on the argumentation as a whole, this
PV aspect is suspicious. Unless you open-code a use of the CPUID insn
in the kernel, all uses of CPUID are going to be processed by Xen by
virtue of the respective pvops hook. Documentation says what it says
for environments where this might not be the case.

> @@ -474,15 +475,55 @@ static void xen_setup_vsyscall_time_info(void)
>  	xen_clocksource.vdso_clock_mode = VDSO_CLOCKMODE_PVCLOCK;
>  }
>  
> +/*
> + * Check if it is possible to safely use the tsc as a clocksource.  This is only
> + * true if the domain is HVM or PVH, the hypervisor notifies the guest that its
> + * tsc is invariant, and the tsc instruction is not going to be emulated.
> + */
> +static int __init xen_tsc_safe_clocksource(void)
> +{
> +	u32 eax, ebx, ecx, edx;
> +
> +	if (!(xen_hvm_domain() || xen_pvh_domain()))
> +		return 0;
> +
> +	if (!(boot_cpu_has(X86_FEATURE_CONSTANT_TSC)))
> +		return 0;
> +
> +	if (!(boot_cpu_has(X86_FEATURE_NONSTOP_TSC)))
> +		return 0;
> +
> +	if (check_tsc_unstable())
> +		return 0;
> +
> +	cpuid(xen_cpuid_base() + 3, &eax, &ebx, &ecx, &edx);

Xen leaf 3 has sub-leaves, so I think you need to set ecx to zero before
this call.

Jan
