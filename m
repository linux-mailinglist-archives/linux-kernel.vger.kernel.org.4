Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4299D6D5339
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbjDCVPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjDCVP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:15:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884B4E42
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 14:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mn2SOJ2xwVcOf8GwmLlP5YBH72YmyF/lzNp2favhAhTYZED/6OwbzWNqqhFALvMupAiMr/zockibZfFlIaPyjsOQi/AAuqLWIEh5tbv7HeDe32uboKcrUioyXDPgk2hdYaVgknwW9LshYdMC2nvluqHV8bW3DYzEBZ8gZQhrZmRQaasrkOSYsxqDiyocYA4y7xaE+xYRDiccF/r/u8jRzQTxasv2hvJNbWAg6fIz64aUmS3X36DmBu1zz1EdgpP80qw6bNSC0J70hssuo96hsfWaTur8mU7UartY6siI/HiSnZef8xpH6LhyPWvghbR1Wxz6gzr/5TwdDSWppwijcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgbXAA/sjJoWJW60FV4vQVUd1nym2G8kuELJmrfc2YQ=;
 b=UEomDQBJZJmEu+cFz0XGprEefwJoPRCiRINsY1zwV/mMOEJ65Rp0tde2FaoB7+91YI18eBT233mkrIhs9x/YZoJNf1UNYwNUAfITFhC1ZEinLq6dutduABxWaaWfDpto2M4JiVz7zEEDsjKrxB8mLQBtgddLFoKchT1LC7lCs67Hg7z0T+uUdjn43kXuHwPzh2zGXSBDElx9sgX49TtuKBPvIixyb1yY3NoI33SRqhaDWSZROau8n++gSK+RmCcWSYNUCQ7QfghUS//rnTquJiw5SPtMZF3bhlG8m4c7tBNlcvi53dUeoOa28lDNLvFvAOFVup5I8TspXh8jXCbdiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgbXAA/sjJoWJW60FV4vQVUd1nym2G8kuELJmrfc2YQ=;
 b=WGjRs5hX9i8yllySsx5GUnvHFDz+5gvNzdwt0EvykGs/Rc6bzzYhFRwjfLCI1ZdxJMpCEHYm6Cz0bo/DDsAkTa2DwZtWM4CvXuv8Uuj9Te63ytZ0NGrlkZResGkiyuG3k5q06pJjEZ5DAI20BO/eTdVxkj6tLgpSfC6NHuLI6mk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CH3PR12MB8933.namprd12.prod.outlook.com (2603:10b6:610:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 21:15:24 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60%5]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 21:15:24 +0000
Message-ID: <f22f87e5-cf7c-a5aa-5ce6-e4c9c88d5fea@amd.com>
Date:   Mon, 3 Apr 2023 16:15:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 07/11] x86/sev: Change TSC MSR behavior for Secure TSC
 enabled guests
Content-Language: en-US
To:     Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com, michael.roth@amd.com,
        ketanch@iitk.ac.in
References: <20230326144701.3039598-1-nikunj@amd.com>
 <20230326144701.3039598-8-nikunj@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230326144701.3039598-8-nikunj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0009.namprd14.prod.outlook.com
 (2603:10b6:610:60::19) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CH3PR12MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: dd378a39-6681-449f-2d10-08db34888a60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jMzRLXFuD/nRSGEEpFzSkeMSvB7Gj9WHs0fGbG6LXI9jZo+h9HPJ0jrZN3DDvW1CgSm3L/+vRckdMeA7bANfbu1EE71IAXPLaK0EGsRGeS0BVBLO43DbCSvAO2pJ/PP1vwVqyXHknPSBGJrvctZkp2ILW59VbM+ywD6AjblgxoUsUCm6Qz56CIaEQo0knYcuCUo8RixoXAjhlEbpvitN5O+m3gUEG3+6BK4zSH5nmJJWhffqCZWgfGnLy8bGvmobirWhmlrvEHGhLA7x/SCAUGFtszaaVONb6BcTBxn4SoXtq7RaaTHvUhIqqd4VWk8gCZnZzCOAEAVlfcj/yxKd67Sa9eTlO1ldq761GLJz36fctaPomD1TPWGxsSbf0HC+pENbbHPcEi3fz3KaWsNBcHS26vgFbnInpPi6TLsfQCRPCHydgcRrkbp8/gSReFJtnf9aXPgy0yArEjRc+WdiJtWjWpEBOj+7GiHH4gyTSMIics9qecGvXvDGiE4mgW8V7yaWKbTGUjDKBZ3i3fbh/75EFkpFikssY3K6FmHarQuibKpV3QfwbrosuDfWHintLka4Q/XpzhOZ/6TVHa1zUIlKNwvZEudznT7WeDkiTw9YVhxt6NF//czVFoBbISYkMCWbjo0vylzzujcHfyl+oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199021)(41300700001)(8676002)(66556008)(66476007)(66946007)(316002)(478600001)(4326008)(8936002)(5660300002)(38100700002)(53546011)(6486002)(186003)(83380400001)(2616005)(6506007)(26005)(6512007)(86362001)(31696002)(36756003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU1weHVOYnRzUytweGg0aXdYTXFqa2cxd0J0ZVFOWTM0TnZTVU5ET1VIMi9Y?=
 =?utf-8?B?UDhVT2NHNVpJTXVUQjhMaDlPeE1lL1l1R2Nsb3V1aEl2czBiQUIxQ2d4SEZy?=
 =?utf-8?B?MSt5TEt5WUtuVFR0Si93cmdLWkt0cVUxMndXejA0TDMwOHNzTlhHN3kwWTR6?=
 =?utf-8?B?MkV1UVRTMURxamRHS2ZRQnVXY1NFeVZTWUhJT2ozdlMzQVJVRVk2T242eDJ1?=
 =?utf-8?B?MnRGcVdsd3AzYXQ0aUszbG15cGVld24xejFhTHhRcjQ2NXVGU0ZqR1o3VStv?=
 =?utf-8?B?dGdaY2VacjNZNnFyRXVmMXRJSjFHNzRGOGQ1am1nNStOeCs2SUttK0dlUEJW?=
 =?utf-8?B?N3kvZStsWThYVFBRVHdON3dBQkZzY3ozVnZ0N1EwbHcxUFNZdlcrdk1rZVBH?=
 =?utf-8?B?bWI3a2FWbHBvL0FYcWFZcnlaRFdrZkpsVzZLTy94aUxCYUs4Rnd1NytiRXlE?=
 =?utf-8?B?dlByTzRHSDMwcFhWcjJqd2JXaExYc3kvR3hwQlRNbGtTTy9jOGp0Mm0xMFln?=
 =?utf-8?B?dW1lNHlMU3hWL01zVUg3UkdTeWF1S2xUYmdmZUFnNDhkQUlGVjBhSEZKNjBz?=
 =?utf-8?B?MmlKZkJTOEttVW1IVUR3N3FDSVpwNGVlc1hvZXpIWnBKNlVPOTVncnU1OWg2?=
 =?utf-8?B?WHlBNkw0SVRjaUJQNEpFWTBmSEVENVMvUE53SWdYaDBGTWF4Z3pvT1JqNHVY?=
 =?utf-8?B?ZTU5c3VGeHhYejJTZit4ZHZEUlZYTXFYQzBnMUx4bGxrUXFCTHJlOW5zMlNW?=
 =?utf-8?B?UzBydDRyaEtlOS92eW1CZ0dRUUFjbjBhZVFNRXJNMFRsb0FlUWVmMG5qajJF?=
 =?utf-8?B?UmZoYVE0Zy9iZ1lFcnF0aFU5YTBEWko3TTJ1bUVUMkFKeE5waXozK1FNSEFT?=
 =?utf-8?B?aVZKY0licjdUQllucFJURnJlQ3hsc2ZmcGgwOTVhN2NWV1BjMTg3cW5MUzVT?=
 =?utf-8?B?K0FJcGxmVlF5OFB4bFpWUHJmc0RESDBIeDQ0YUQwUEJOam1LZTMySHUwSFkx?=
 =?utf-8?B?MGFSREJ6bUhadWtXQ3JYbHk3OGlFTzZsbTVUbHNLL0Fva1VNTmg2WVJvNTVQ?=
 =?utf-8?B?aWR0WTNzQk1EV3piZWRsa1F6Myt5SG1FQU4ybDAyWFA0bUpBWlNhMDV6alh3?=
 =?utf-8?B?bHU3NTJlOUlneTRuWGJhUVphYWdWUW9ENlZ2VWp2TG5RYTdEQmZsYW1ZdnZ5?=
 =?utf-8?B?VXJ3QVZkYnJPaFdRVG1QNFhZa05lbWs3UGprL09oSlordG1ibFEvc2plcGJK?=
 =?utf-8?B?M1Bsa0krRndrblg5WDc1YWI5SVZ4eFlrYmswYWF3bEo0UkM1aFNXbjhqSURL?=
 =?utf-8?B?a2NYN2hDbTVQNkNJUWpCTytFUU5SeDVaRW9tbmlVSmt1T1Mzd0NQdnljQmVv?=
 =?utf-8?B?R1ZMOE9iMkgyK3pLZ1kzSi96bkVwaGpGRW90SkZUUFcwM3dXWXdVZldpbEc5?=
 =?utf-8?B?WFJ6UmJFRWRLeTdxWUNHeERzRCtEenIydnRuOFJLS2FlR2VVU0M5UXpjOWxO?=
 =?utf-8?B?TDRPUkc3YVR1eWl3eVRNeUt3S2VaTHlKU0JaSnFFckExTTYyWGN4TFhGblpw?=
 =?utf-8?B?WGlHUzB0STQwTG5RV0NhV2xsS2ZmbVlnU1ZENEwwWWt5Zk1BRFlKVHR2K0VJ?=
 =?utf-8?B?YjUrdEJsYkN6WmNaYUxMSDFDeklZL0lwRzVVV2g2WElKczN0V1E3REhmTmw4?=
 =?utf-8?B?STN1YWttU3hBakpIQm9IYkxjVHd2cVpEUkxpbEp1cHlWUG0vTnFDNjhpeTFT?=
 =?utf-8?B?aS9jZk51dmVnbUZESjY3bEo0Q2FCMkZaazNXU3UrNk5RbVFMSXQ3YUFPVDcx?=
 =?utf-8?B?c2E4UnJ2ZUtOL1IvWkt3d21UZU1hdXNuUm1OOGNuYW9QVjFobVRUYXVuYUtR?=
 =?utf-8?B?RFlDOWNUbUZ2TlphejAzak5rRlc5L3Ftd2tOS0dua0llVzROVjZub1ZYTEN1?=
 =?utf-8?B?cGZpNWUzcjdFeXpsb1pvYnFSTlpFZjFVenpUMVRheXNOVHlhSFd3RmhIMmlL?=
 =?utf-8?B?VlJ4U09TZkVXcGV6SDBjZm5SdktVbHN2VXFuMzdHOXN2bXZSaW8yY0xndFFs?=
 =?utf-8?B?Sm1XSktzbFpUSngwTUsrMzZzMHNObEpPRk01ejRCWmVHemtVVHoyZ05Xa3Zq?=
 =?utf-8?Q?OXfVKgTSNzUWpqMO3Z/qQq9wd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd378a39-6681-449f-2d10-08db34888a60
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 21:15:24.6222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQvCWj8FxpY9VykV/ThfVybmpWinKPKNKv80Po/4XPd4oyKYZ0X8eqMNIbDaKIgXfxDVY5R7qZCGj6iE1xtqkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8933
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/23 09:46, Nikunj A Dadhania wrote:
> Secure TSC enabled guests should not write MSR_IA32_TSC(10H) register
> as the subsequent TSC value reads are undefined. MSR_IA32_TSC related
> accesses should not exit to the hypervisor for such guests.
> 
> Accesses to MSR_IA32_TSC needs special handling in the #VC handler for
> the guests with Secure TSC enabled. Writes to MSR_IA32_TSC should be
> ignored, and reads of MSR_IA32_TSC should return the result of the
> RDTSC instruction.
> 
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   arch/x86/kernel/sev.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index c5ca97aab8c1..3750e545d688 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -1642,6 +1642,30 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
>   	/* Is it a WRMSR? */
>   	exit_info_1 = (ctxt->insn.opcode.bytes[1] == 0x30) ? 1 : 0;
>   
> +	/*
> +	 * TSC related accesses should not exit to the hypervisor when a
> +	 * guest is executing with SecureTSC enabled, so special handling
> +	 * is required for accesses of MSR_IA32_TSC:
> +	 *
> +	 * Writes: Writing to MSR_IA32_TSC can cause subsequent reads
> +	 *         of the TSC to return undefined values, so ignore all
> +	 *         writes.
> +	 * Reads:  Reads of MSR_IA32_TSC should return the current TSC
> +	 *         value, use the value returned by RDTSC.
> +	 */
> +	if (regs->cx == MSR_IA32_TSC && (sev_status & MSR_AMD64_SNP_SECURE_TSC)) {
> +		u64 tsc;
> +
> +		if (exit_info_1)
> +			return ES_OK;
> +
> +		tsc = rdtsc();
> +		regs->ax = UINT_MAX & tsc;
> +		regs->dx = UINT_MAX & (tsc >> 32);
> +
> +		return ES_OK;
> +	}
> +
>   	ghcb_set_rcx(ghcb, regs->cx);
>   	if (exit_info_1) {
>   		ghcb_set_rax(ghcb, regs->ax);
