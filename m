Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CF261FD93
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiKGSaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbiKGSaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:30:00 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4631AF06;
        Mon,  7 Nov 2022 10:29:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoYwG2vYe4OlgkLSzZU8L7vlYiFJ3UWUt1tYg88GiKRTb06Q/3wthomEd2UBwf2GDTd4IXXT9+nxAfoIyxc878gUCkEnQE0biFqt7K0Y38TCIydgnLb/FWs2e3udgj2ZFaiEquh/xq7O5z+VD6vsw9FdU9y7401q9K4NUSyw6jGy5UUMsht2xbKIqTB1pikJ/kyRLoYMF3Jts+PenTaXz6RrfD0GOtP8Kj5AjjUjo2GbHEaqGlqKJwAIXqtmf2d7lbSW7zFC2F7PU5XLA8QkfhTxE8RJwtNwnS/xLtMPL+5lJ+huSVTi95/reSgKi7hZlrr6d98SFoqBZmgl97zhrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guZHMs5Pe89HHPipvtk1XfA2yj+MjoC1T8xeZwu9udY=;
 b=Y9QDU7hWELPPOIPYYn5JvJUBoO0SKYL+jIiyA6G+vX/yrGmtiu2Cl7uDlnsNm0ZC1zBAq768Br+mowjXcf34/weZVAZSVKyWE2piUrVZGjYnI12E08JXWBnvNLXnm/irZonMdvngcB2WgPmrMEnGAiAzi8lnQG52Q/czlvIf6ZnKELvm3XxBPdNVfSD0532Nyq68LMIrU9nQ9YVdN8g0p35hCmur6YtAY3OHouGZ5WAs+0By1o/FEdnKTZ+5rQ16atAvK7N8I+hrudDnTht1Eaexqdp2EhPTCZHKlNBskhNgYNmrQ36xSzS33YX8p/TwXMRT1ceZwLK4mR2fwt8PgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guZHMs5Pe89HHPipvtk1XfA2yj+MjoC1T8xeZwu9udY=;
 b=Qr1a9dZ/p5Fk6Drr1LT7IGDxD0LMU5l4ui9gQ3y0SH7NxoY3ZconSf8bJeY5wK6HTVQFTFdM0yAG7m+LkVcHN62obk1yY/oGjSsBkE1qqJwc18DEYo2kbFfgJAy+31dKHJXJsOFsbri8D2WVHPu5vT8fWyN7l/0a2E5PUYtOX6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Mon, 7 Nov
 2022 18:29:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 18:29:53 +0000
Message-ID: <392fb511-5d16-167d-77ab-dfaa43dca4cb@amd.com>
Date:   Mon, 7 Nov 2022 12:29:50 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 3/8] cpufreq: amd-pstate: change driver to be built-in
 type
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org, wyes.karny@amd.com
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
 <20221107175705.2207842-4-Perry.Yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221107175705.2207842-4-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:610:20::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 26dbb52a-1c0b-4544-73c6-08dac0ee104b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09hwbM54n5NYElgBeDHUC1A+oWo7qJizm44MMnHUpzlxUuHGlswRmP/RBY9p8QgM5rL0DTz7SaAht3k7qIxFBmfeM4/tZZaEIEH+5Rj7G+zUWMCGIF+FUXv/Jdp649ESV/H+/y/ZEBjE2XnFp2uyX3R0aqMqdKHlrQORiUxSVvm4BY8q7dg7ZqcchKrOac5TFvNwPNpn/TyWjlnyZRr4FR9X11UwCsqY176LPQSB+EtaO+zms5RJ/Z3Jr/OXR8bi3uezHkAJ8xJMN+ksCaQ6KxjqjEaAS3WqPW82fYIFFxefWMFes4fYWQjenht4fMKKrjq/5Z4Wtzmu8DjwAMc6u77DCLWVmmKOwaC4zxwx8J5txZREYYR2HmnHDmqjjROG5TcuUfzbGF6xtpQnMaUobhope2DmlXkmxV0VBHLspEdiQSJMHSbi63dKugxtDxR8zQiBqXBmnpVWR9jnPFnWTjFAv4vGODARKxDGZsldLplOjjxqM9JkF81j+LE9FuVqOf8u++9vLIdtJMmVAiXeEV68zclTjhKsmnpjazJizEMig6fuory+lahoOApryVT8H5QanO7hDSHfCwoem32cQVuRa/i7J1nNaNdawCEJdEQpB/14Okkf7Fafocseui4zTDIt4N3JalsNlnHIhfyt0Eq6ZLWuLejq4e++5JLfEegbIIYXhG1rlSQ57gVYdlqTMwbODYgwWu17yXo9VDUw5dxME7kxT435unk21bq1jfVuz9SeH4JCWwDdvIMR3m69WQ0X9wlJHykbm6gI0EKmAJ6R8cPA5WMIagRiL/yi048=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199015)(36756003)(31686004)(2616005)(38100700002)(6506007)(86362001)(8936002)(31696002)(83380400001)(5660300002)(186003)(6512007)(6636002)(478600001)(6486002)(53546011)(26005)(4326008)(316002)(41300700001)(66946007)(66476007)(66556008)(2906002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkJXOXBQRDBpMWhpNHB1NzRtRTFzeGo1ZkhhdmNQdlplZzhUT1lWVkNpN1pE?=
 =?utf-8?B?S0cwZWdOL0dzSXVPK3g3N2dyU0FwMTZaamxYRlF5MHdRS0hwQTBRblk2T3lj?=
 =?utf-8?B?RDdsMy9tUkVwRUxic2duK1dJUjdMNUNrTW5tdzFQZGNZbTkzUFhySkR1RUM0?=
 =?utf-8?B?eGVnbE1sTUFZUVFISUY1UDF1cjIrMmJnbkZsb2QvYVNFSGY5NDhQcCtPTWVO?=
 =?utf-8?B?dURKMVhTR2g1TENuTXdWZVJGMW54eWhnZURhdXVGb1haaGVZajU1bmMrblRJ?=
 =?utf-8?B?eXA1WGZmVzE2YW1kRVphdksrcmtka2FCQVpXd2k2OGJQNDVLeENybUlVWjll?=
 =?utf-8?B?cEZGUU1DSnJ5MHhMWldIUk1wY1lET3c5RFJ2cVFweVhGUmF4N2F3THVyN0JO?=
 =?utf-8?B?enduTFJOSkNiejI2ZENLTHVVWFoyK0RUVm1HcXdWbFhCYUJsQytqMzBKSjk4?=
 =?utf-8?B?MTV6SWVYSm1PZjl1WUI1enpwSkZBNk5qM25nWXMrNkwzVjFsWDJOcjIvbXZG?=
 =?utf-8?B?dDdWS2UyL0g5N2pMOVZyd0xIVU94bFlnNGNjRkJQTGZGNGtIRHNTYUtWd3pM?=
 =?utf-8?B?MTJRaUplQmdaRDNycGNMQlF3R2JMMGdCVWY4U0hUSVl3UzJKNTlrTXlwbGNv?=
 =?utf-8?B?S0kwMlJCeUIyTUJkMVN6NW4wRm1NVFpia2szRzE5a2NDTjh5UkltcEIwRUhk?=
 =?utf-8?B?N1c2QWM0L3hjQWpTcFUyZEl4azkzaGo2UzZKYUNUdXpVQXJxNmdyODJMM05I?=
 =?utf-8?B?ak1MR1BwTDIvQ1pVZ09yNlpKRjdEUHRjQUtLcks5TmhhRzJiMnByQ0xzZFVB?=
 =?utf-8?B?M3VPU3ZQN2dJdkpnU1ZoWWw1NEpQYnQ0UERmVEJaeU0yUlZCUnY4bERqa0dy?=
 =?utf-8?B?MjZzQ1p3VjhpRnE2N3pWV3R4dEh3bUZGWER1aVBteTlJWEd6cGExNzBHbTN3?=
 =?utf-8?B?ODUxUVRJaWNKQUptTTdlQ2RBNStsdTBMT0lCblJJQlF6NFBpZTNidVFWa0FX?=
 =?utf-8?B?NlhHOHlZWFMya09jc3ZNaFN5b2x3QWFCczR0ZkFTQyt4eEVDYkExYnhaWUpk?=
 =?utf-8?B?SVQzZkpQd1Z5V2hJUjZmdzNKbDZ3a2VvM3dXclJRT2MzOUdNQlRiNFB6Y3Rs?=
 =?utf-8?B?NHFEZGNRNXdPQTBzalppaEZwY3F2YjJ1UnNuWE1PVENlVWtCREpySjNFUlVj?=
 =?utf-8?B?WklnMWIzRjU1V0gwZ09EQ3ljS05CYVhBQXRWdDFEVDNoNEgrR0thdUVUbnRv?=
 =?utf-8?B?TFYzR29jbDBKU2phWlJqYk1SWDIwTEc5d1Z6Vnh4bDRoWldyZng3Q1VvcGZP?=
 =?utf-8?B?Ty8zTGtoczBJSVBnb0Y0RzhLem9PUGE1KzEwbDZiRy9BM0llTmc4RWh0SDQ2?=
 =?utf-8?B?ZkoyQngxYjM1ZWhueHFDMmlvY2VScnNrSHRjS1JUUlhDeTlVNWhuY2E0SGRy?=
 =?utf-8?B?NDBzcWdKcUxDOVZxQTBIRk9SQ1BaQnNHZDRWRmJwMWVtdENyWU93ZityM0o4?=
 =?utf-8?B?cERzSVgxWkVEcnYvakVxVU0xaEJjQ0lLamFScnVEczZMYmtvdWRHRzhHd0Qx?=
 =?utf-8?B?KzlCR0x6YXdNdVFXMjJLNklvbDZNR1NTQ1dtb3JiYktGWDBwa25WaFhvdU1l?=
 =?utf-8?B?WndnM2lySTRzM0lxTmVwM0UvV1gycGZ4c3V3dkZGcHVLS24rNFZKNkJreTdu?=
 =?utf-8?B?OGdiVGxxVXVIb0s3OXNBdUNoeGFaUmtIN0t2bFJDZ3g3dHlEbm1wU2FIRVZn?=
 =?utf-8?B?MG52VE1jZ2xvTFpCR3JHbkkwMkN0TWhUcmhWNFJPMHlzTllkWVhzd1UzNnk3?=
 =?utf-8?B?QUFFVjZYWFhZN0liK1l6L3NLQy8zaWpFcHQwR0w1a2JraktaOFFEWklSS3gw?=
 =?utf-8?B?MlYyRFNvM3FtZDZTczZocFpwYmxUQmpHSSsxOVZGbnhYbVdkdVJ1MHhibTEr?=
 =?utf-8?B?OS9uT0Jtc05odUFLaXlQN0pDSHo2WkpEU25RSGYweXRybjZhUWpHK29wVmdx?=
 =?utf-8?B?Sm0zeWpDUkJVd1VCa1JFL0VjQTg3Vk1KbUhkZXk3WUQwMjVKRFF5YkxYVHox?=
 =?utf-8?B?R3I5SXZkeXp6Uzc2b0o5dlROcXV6a00wbCtDdVFmVTJvTUNta0RpUTBsL0RN?=
 =?utf-8?Q?1I0sweqT1jXd0Y1zi5VzdNldz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26dbb52a-1c0b-4544-73c6-08dac0ee104b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 18:29:53.5882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJqgkPn8nV0ENXeCtXtUvK0tE6OmQD8fIy0R16HuSGeVkt8b6+gHAoSsBdoc9yFOQcrDW7RK6hMe4kW8dMy3Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ wyes.karny@amd.com

You should sync with Wyes Karny on this patch, I think he had some 
different ideas that you guys should fold together for v4 of this 
series.  I'll leave some direct comments on your implementation below.

Also, include him in on CC for your v4.

On 11/7/2022 11:57, Perry Yuan wrote:
> Change the `amd-pstate` driver as the built-in type which can help to
> load the driver before the acpi_cpufreq driver as the default pstate
> driver for the AMD processors.
> 
> for the processors do not have the dedicated MSR functions, add
> `amd-pstate=legacy_cppc` to grub which enable shared memmory interface
> to communicate with cppc_acpi module to control pstate hints.

1) s/memmory/memory/
2) Although many users will use GRUB to configure their kernel command 
line you should not assume it in the commit message.

> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)

You need to document the new early parameter support in 
kernel-parameters.txt, and should also put it in amd-pstate.rst.

> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ace7d50cf2ac..14906431dc15 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -59,10 +59,7 @@
>    * we disable it by default to go acpi-cpufreq on these processors and add a
>    * module parameter to be able to enable it manually for debugging.
>    */
> -static bool shared_mem = false;
> -module_param(shared_mem, bool, 0444);
> -MODULE_PARM_DESC(shared_mem,
> -		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
> +static bool shared_mem __read_mostly;
>   
>   static struct cpufreq_driver amd_pstate_driver;
>   
> @@ -653,16 +650,22 @@ static int __init amd_pstate_init(void)
>   
>   	return ret;
>   }
> +device_initcall(amd_pstate_init);
>   
> -static void __exit amd_pstate_exit(void)
> +static int __init amd_pstate_param(char *str)
>   {
> -	cpufreq_unregister_driver(&amd_pstate_driver);
> +	if (!str)
> +		return -EINVAL;
>   
> -	amd_pstate_enable(false);
> -}
> +	/* enable shared memory type CPPC ,if you processor has no MSR, you have to add this
> +	 * to your grub to make cppc driver loaded successfully.

Don't reference GRUB here, it should be referenced from the kernel 
command line.

> +	 */
> +	if (!strcmp(str, "legacy_cppc"))
> +		shared_mem = true;
Sync with Wyes about this.  He had some different strings and flow in 
mind which I think would be more preferable.

>   
> -module_init(amd_pstate_init);
> -module_exit(amd_pstate_exit);
> +	return 0;
> +}
> +early_param("amd-pstate", amd_pstate_param);
>   
>   MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>   MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");

