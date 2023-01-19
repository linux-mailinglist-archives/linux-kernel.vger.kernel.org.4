Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D678673139
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjASFdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjASFdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:33:00 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA6111EB7;
        Wed, 18 Jan 2023 21:32:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQvpbwarbdqoFfgAx2UUd1Vhc/y2Q1Da9wjsBupYRZ0chVYiio18H6xdWAaex0A1i/dr2tn16u0/GsRzWaSQb+EhUiD2Q1xKqhpqHipu0/1Zr+yDY3TXqajIFWk2gs3B8ZWIWrw70iyNpZan2iBx7kM3wx+d1i49B86TME7NtrvU1COG2wkjhXl68AplBtsIbNhZb0Fysn/AzsqruzI3wEABRFMe0P2Jy2yo4Qern3d+LzqdGuH4RNMcQh5WLLCOgexdYvA98CS8UXI3F6v5woxRRdiWXdk8nxLNzBjAB8RdLnx5LgTWlePe+RfPOq/+rX9/zrqqOfkaaj9mrMwk2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ON9ZkixN9ftqaDBKZ5L//gg1SGgjRji6wqucak92aho=;
 b=F8q8bJ+3ctbswbmPXu1MEZgiNWhcUwowkxEfM6rBNR5Z46zzdJg5KjfTjD2ILn3eHa4e3H8nRC+gxAuYVZjzowtoXDRmeloMxGISXNx7Hpqiu6LHXkECFg5EgIJBQVpw1MZaBNmKwnXxcIFfQ5kOaOIYxSlpo3p2WkOe2QEdzY+uhZpWpmfxNwoNyEoVWBjfO4i6mNL88MlIV7ZJZgps+NLSxL/Kmes4ZWyG66Yig8CU7fHjOJyR3X7H1LlZLvUoJbx+4OuNokQXUqPnyAa0BWPDRStyivxE6K2gYMrjJZckOChHopXbdnlmbguRKVkb614jGOSS2lqlfdXXKw4CPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON9ZkixN9ftqaDBKZ5L//gg1SGgjRji6wqucak92aho=;
 b=uk/mfeMPTFFoM58eRFldDevZgE1cAS/4Q0wBICAgbYdE7O8lE06zjiXh5RP762RKJ6beTLmNn4RIqgqMuDTv7r26Dw9COuppkOcLMCcb7e3xWtxEUjGotTpevHwbsxRMiQn2TBX8f5d46UqUNBR6Reoz26xFB4vH1dRjPBCL08o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 05:32:56 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.5986.018; Thu, 19 Jan 2023
 05:32:56 +0000
Message-ID: <dce77829-4ee7-6460-da36-116d165286b1@amd.com>
Date:   Thu, 19 Jan 2023 11:02:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 09/11] Documentation: introduce amd pstate active mode
 kernel command line options
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, ray.huang@amd.com,
        viresh.kumar@linaro.org
References: <20230118075210.447418-1-perry.yuan@amd.com>
 <20230118075210.447418-10-perry.yuan@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <20230118075210.447418-10-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::29) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: f8bd0820-204c-4ff6-329a-08daf9de9e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bBBlz8ycXHS3R5wJLgxziHlrcqJPCEOxBYQMYMNKamwPN/YuuTCP+b/cFHeO+ty1PYqz2bpJ/7KMCXKqM+ceCjCVF/Kwjvuuk85cRirKXk9F6iujS+uzxtJqhcmJXoDd5i94LG2UZCm2AqL8xOctt6i+9SMOn1773hsW7+5vinfQ6PJhYzl+0++pFLRUNQ2+T2iCT31q5NfMwpKnsDyLQafYwKiSpOUiYVnOrEVXY3Il7w7tmgQA2ydSg8KWxgruymYNgOhojHTMYNrgbBy2paiWd28OybZtJMgM/pcrLTMkHSoCKTjJ1z4gb0CAvmoae/rinr3su5NtGRly1bXUD+Ft5TVqicEtaQn4SHiaF7nS5RMoanCZREdsqvZQgkUKHAI3UevslEk+FhyjfJC58QSm0NPsT6TvIoA1eVA4zbjzE0n0CDpJuyi2oUk5xK5LQGZxowNSaigbdDHtOFU7FdLcjRyjMJn7RgsjTw0xlQoZGDqqB/GipmgITusu3eWPymrJDuFdh6eM/UNUsq+kQAj5hPPlrcjkHtXCuhB0FhKGfLpHWlj2TUofhiclfSvJhhh8IJ7rHCvr7RdIwglApj1yA4u7RKKPCj4RnYjs1yKPzvKoRokreiw9ATjuFUrPrl4FN0Oo/w+Vg5fLw/zHDpkHVLbnM1KI2wb7t6C/8XM+TMI9vITizEH99KDnH9CKjGtcw74lmKGwyHR/qqQdKbUbw1OaVDYMTrBdmxu1dpQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(31686004)(36756003)(86362001)(44832011)(66476007)(2906002)(66946007)(66556008)(8936002)(5660300002)(6862004)(31696002)(38100700002)(316002)(6666004)(37006003)(6636002)(53546011)(6486002)(6506007)(478600001)(8676002)(4326008)(41300700001)(186003)(83380400001)(26005)(6512007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFRoN2VXNVFzeEZWUTE3TUJQTnZvOGVwQUtqWUJHb1lobGdSMVNaLzRxb0t6?=
 =?utf-8?B?MmNyS09KUGNERlA2aUtHTDJ3cVVjcG1talV6SU9aY21pRFp1eFNUV0ZBbkRy?=
 =?utf-8?B?bURNWXpsb0tmYm1qUXNaVDE2ZklKVE4yQzFGWm5ITkR1cVFoTEFlcHZiNUJr?=
 =?utf-8?B?WU9IalJtcllyQTdJb1JvQm5wR0gvTG5VTlBsU2NaM1I0ZGdGTk9wYm1rcmJE?=
 =?utf-8?B?bk1YQTlud3cvdlljd2N6M1FuZU1UUVRBY01YYm5Qd3JySnhTWUVDM0xDVzJw?=
 =?utf-8?B?eHZVYU9qRGFWTzA2dDZDcFhHTzdJTDFsNmNjTGVNUlBhU3FralMxRHhNUDdN?=
 =?utf-8?B?VEdKT2NCczRqRHpkQjY4RGZUSm9IOTJjS2hCbmxlSVpOYzh5cm04R04wd1dN?=
 =?utf-8?B?c0tVM0hwQU5yT0l3dHgxdzBxWDNBOVA1bWZndVJvSE8zaTNXNUtOUkx4M1dh?=
 =?utf-8?B?UjRvVHNDbVM1TnFIS1NzcSsrVUhqY1F1NEdQbCtwVUNuZTJ5eHJFNTc0OE16?=
 =?utf-8?B?dmc2MTA3Y2tPcXJTZmpsZ0Q4V2hNbjlTY01BT3VzQ0IrdGJ3dXlMM0VDaVR1?=
 =?utf-8?B?T2FEeWJsZDJ4YnBOTFhoVXRMNVo4cC81R3YwMGZzL09jazRjVEYvRDhTem1p?=
 =?utf-8?B?akI1SzNFRng1SVBCay9ieVVwZ3h0NldLcVJXY0RQZ1FqMTFmM2R5aGJkOG9O?=
 =?utf-8?B?c0JqZGYzOGx5UDNEeW9XK0UvcndpakMyb2hvajMyNEVGVGhqZUliei92dHN4?=
 =?utf-8?B?dDBGcjdrNGhjaHk4d3BhYUZDaWtmZ0dneTBxRTBwSFQwR1NtMlVIcnpyV3VB?=
 =?utf-8?B?SGs0Z3VTOXlpbC9rUkxXdGJZYk1xRzUzWGsrZTBDZ3RXeFdmQndtaWxuY2lN?=
 =?utf-8?B?dmo5LzJhbmxzZCthK0RnOStBOFJRWEVLVkZmOFIzQ1VyNVZCWm5wNCtYQjVl?=
 =?utf-8?B?bTd3QnZ0dkdDaU5QaFBMcWdmUzU3NEh1djVCVXc5Qyt1TVFsRU1mcFhMUmRN?=
 =?utf-8?B?c0Rtdll0ZmVvdWRzZGx0N2JxVy9lNVY1Wjd6UldTU0FpYytmVjNWMEhDaVY1?=
 =?utf-8?B?S1dxU3Y4MklYUFlxZXM0M0lpOElaWlNqRFZiSG5zcTY3ZjZGWTY4NC91a3g1?=
 =?utf-8?B?dm9wYXBDR0xTdUxuNDhRMHN1R3lJcUFCLzVRZUNLUnFZL2V0VTh3eC9tcllF?=
 =?utf-8?B?MnhLZEVGRGkrYkwrZWtQMTJBSzh2OXd1YktYc0hsNXpTRGZNVGtyRE9yWktT?=
 =?utf-8?B?SWJCbVV5dFBiTTRrRlRMdElJaExpUE02Nml0TksxdDMvZTZzeWhDT0x4Ly9t?=
 =?utf-8?B?Z3prK0xuSmphTHQrZmltOUVMdHFOUEphYkJPQnFDZ1pid2hZRzFSRjNmVlM2?=
 =?utf-8?B?cXZ2WUdwanhPRVkwSWpMV3dETm11SXIwbnYwd21DRWVtNnByeHZ4ZGlMeC9N?=
 =?utf-8?B?ci90K0s1YStvTXlvU0JraG1UV1Qxa2lNWkhWYmM0UHJVMys0ZVo3U0ZKS0pC?=
 =?utf-8?B?WUhNcVdzb1N3U3lsdCttUThjSnVlb0I1UkUrdlM2a1NBZlEzVU9LL3U1SWc3?=
 =?utf-8?B?N2hDQS8wb250Lzc0aG1TYWI2bVA1Q0Z3RFp3SVl4ZmFoTGxTazBhVDRMUm91?=
 =?utf-8?B?Q2kwTi83TEtiQ3lzbWN1cFdCZXYzaWxEekJFenNJNHFBWUxKRDgxOVNGYmx1?=
 =?utf-8?B?ZWQ4SWlxcjIyS0Z5dW1YdTMraStUWlZvOGx1WWdNMmNPRnFtZm56U3lSMXM1?=
 =?utf-8?B?Tm1WQUoyQXA4eFM2OStWbHJNeGdqVHVXWUtKT1hBTW1DRkZqUnRyaW5ycUx0?=
 =?utf-8?B?dzVJNDJYNVhuUWVZSlpRa0V5L2Z4ampWQkVvY3lENUlscTdIamlrdDhDdHAr?=
 =?utf-8?B?bncxSWpLZkVxcTdBdWpMS1N1RDg2QWdXT0JCNlR3YitqMDBtQlljV1pkdjh0?=
 =?utf-8?B?ZHVRZ3QvSXhBbjJuYk1EcDREaUNwMHUvTzdIK0dnSnVNYUlWbmRGczhzVlRH?=
 =?utf-8?B?NnlMYW9vZThJVVI0eXB1TDBiRG1vQk9FUnp1dy91OEFnY0tYOUV1VG1GR0M5?=
 =?utf-8?B?a0JwZk1PZFZoUENQRzBkZE1HeXExU2RXTnVueFQvcEFUU3NmT0gwSE5GS00w?=
 =?utf-8?Q?CCzFVr6+2oogRnxqvdmBJqwoF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bd0820-204c-4ff6-329a-08daf9de9e5b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 05:32:56.5554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5va06YIYC5HrTg8OnMcz/oKjBn8OoOG8e/FCZLr/Qrq/tEzLhjNVUngeBkWBWGucZqhd/FMpeKHq0jZR7ljq6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/2023 1:22 PM, Perry Yuan wrote:
> AMD Pstate driver support another firmware based autonomous mode
> with "amd_pstate=active" added to the kernel command line.
> In autonomous mode SMU firmware decides frequencies at runtime
> based on workload utilization, usage in other IPs, infrastructure
> limits such as power, thermals and so on.
> 
> Acked-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Wyes Karny <wyes.karny@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6cfa6e3996cf..e3618dfdb36a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7020,3 +7020,10 @@
>  			  management firmware translates the requests into actual
>  			  hardware states (core frequency, data fabric and memory
>  			  clocks etc.)
> +			active
> +			  Use amd_pstate_epp driver instance as the scaling driver,
> +			  driver provides a hint to the hardware if software wants
> +			  to bias toward performance (0x0) or energy efficiency (0xff)
> +			  to the CPPC firmware. then CPPC power algorithm will
> +			  calculate the runtime workload and adjust the realtime cores
> +			  frequency.

-- 
Thanks & Regards,
Wyes
