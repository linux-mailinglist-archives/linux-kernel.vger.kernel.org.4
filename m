Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C7F60C06F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiJYBGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJYBGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:06:04 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46D716E2B9;
        Mon, 24 Oct 2022 17:12:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z68+qA0Ner6dlH4kSJaJ2fwAuIv/yxlkcH189L4OiSrEBzxlp5EQJmhy68hwEkfCljLDH/BOIE2cc+QY989Ux0XacHPngEJboOfm3ORFZd7Y0XvX2soUxohOlMP7sKbUu5MlhaD7SXZFUXWZuGQy9bHP2wuamlfehWeRwc+fF1EiRei6GhOTnHLJIy4nKHLVVIYusWhLHCvsV+YrJjEqrTR8Mx3/j7OAfqcHuEM4ZLN55Rml0fREM8kDVFduoPvj6sPWxASnWa7eNd6Ts/l12/OmySs1mpJ/bwZIe2DJ4fyLKSgxUYoFN5Y/sZ6xPpU9TIfUPiwjpR/MUcJGsBPtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsAEuR9yXWi8V/95WaDIbvTtrgW6/6ONPNtNJ9oWf8E=;
 b=HkPnvBvjsZXt78dATfXvICuq4FWmPGSuT76Cv0mmAuovfESIXL/bC6jUWfYSZkCGHmUXjr05CtrUdv4uaN3A7xIdbH1zKNrRFlEhcMcTgcn3p684w/dKUKHz/UNvxHRFt9fw/H/VyOnjDTspQWT5R4AbuGaN37gHVEy+RH8Gm5YI2ORSxwHiwXIKszQqVXYTQ1AGyqLga3aUK0Auy7/vzW9py1DEdC7DlDOWbSEY0KADvSuT/5cZS26ZqZZBG/qMJK3KLPlCPwS4iL3mSztNLsqaT+DoItUu33Exgb1C4qTsfP/SMg9nHsKwDeSqajXwKlKnvd3Wl+fCG+MeC/DtDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsAEuR9yXWi8V/95WaDIbvTtrgW6/6ONPNtNJ9oWf8E=;
 b=V3CSo7ZVjrZXRNRsW9ldmBT30dTgKH4X2UkEG7Z1dtE3fh7PNnTVszsgss9hh6vWf4izwHiunNjETcjxNjHVNU7dX3Qr+Z8dMoFh0rIrTQ5FBcBtjcanQ1jOc+9KhrlPy6B57Q44Q4CHscFq8zP5qfIVcFTVtyebjgfRttsRKhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Tue, 25 Oct
 2022 00:12:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c%3]) with mapi id 15.20.5746.026; Tue, 25 Oct 2022
 00:12:37 +0000
Message-ID: <63718e7b-bc37-af47-011d-9fd0207a6d2c@amd.com>
Date:   Mon, 24 Oct 2022 19:12:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] PM: hibernate: Allow hybrid sleep to work with s2idle
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     kolAflash <kolAflash@kolahilft.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
References: <20221013035017.5098-1-mario.limonciello@amd.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221013035017.5098-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0046.namprd19.prod.outlook.com
 (2603:10b6:208:19b::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 8421b2dd-4737-4f65-71e3-08dab61d9fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IgC/+ilb2XokcYZGsV/ZRYlrcGMoo2siuTVUyfdvL5PIQEgUGL3xhNpbYGR8suHSbYNuwCUNid1g4TaUQK53afwCF4PJdLafRiLHpr3oo2A8j5U0mAOh+jIdnnAd5l5/i+lvaNbjkMhNOY9kN/Cd8Au51QwO7nhMEpSecXuS4QCXtjfk4JOVUnbn0ojThDxaBBbqTzTsPqKJ/40owjfOcR+Qr8yMpz15qIU2M4apu7Reod/KE7kATdPn3E4wYiCztSNfA5KOZZxOsbwt8wIOnPje8vue38ORPIzDWqRr/2sU2QjRUOJ2azFFfnTYicm2JpPxl0yoyG/EfFMSviwNKnr3j07GMtsxj5UTLJ3UYppxQ5x/QqF+r3Bw3tVxSFfObGje1Cqt54tvAkFQr68JpBMD97xcTrvSIU10E2cIIa56iMGh8wVT2sq4ZuIJ8xBTa174mJmYnX9iMkY3Sk3nh1c/wSFsAIWEFTmEWOvTO3ha+DIfvmAT4rmqV1zmH2u9Q0yOaywMeHG+A+j2VgArpp1dj/ua9CJCrUp6QRCxfMtvBMd80Q9cqVOnhY3/dBCSOWqP7cOCw1ylIbXeen0zfyMrXIVb6lnApoaEIYIN3eeFdJ42klRhzk1W1WwLzW/hkBkOA307hvlGsNmGLW/S6tLKVBX6Wd8qi7PaebyqCbFY0iU01VKe1bhwDUyZaOBquQENbTsnygimbbGOOffIItavRdyw38II3+d1vF66rOK03OUZZbN193bKD++gLMTGMgtcJ1Q0R2mBDEP6dKO3htHi7L+RQ7Z9K4m2+AiWO1qIT8Kp9t+zDlH83DfrszoApstuZ8ORFCnnhLS7z7cibw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199015)(86362001)(53546011)(41300700001)(5660300002)(36756003)(6486002)(8936002)(66556008)(6506007)(6916009)(66946007)(54906003)(966005)(66476007)(4326008)(8676002)(316002)(2906002)(38100700002)(478600001)(31696002)(31686004)(83380400001)(6512007)(26005)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXp5S2FYM1JtdXhrRDJvWGFScFVhTnB5NEhVSmJUWU1IdkFFak5vSjNTUDRP?=
 =?utf-8?B?dW9vem1YTEFKMWZoUEx6dzI1UmRBeXRrMjVJUnY4MWFHNkFQZHdsbFJJOXBK?=
 =?utf-8?B?eVg5WnJ5K012QU03bEJOWjBTWDZObDk2UzZzMjcrUWZqam53NWZHVlBxNmR6?=
 =?utf-8?B?dHVpdXhZY1BtbWR1NkRkc0V2MGt0L3E3dGlPbFFNcXJxYiszbnBXblc0U2hC?=
 =?utf-8?B?bTdyVlJGeUkyUlE0WVNPYjNCbGZOOWM1SkhRdkt2MmJENGs0by9OWDhkdFVh?=
 =?utf-8?B?ajVKUE9jWkt4bkVtczhFVmNhc2pZUk9VcGVjM1N1TE1sSDFsZU9XUXJvdGJ1?=
 =?utf-8?B?UnpHemlVSUptNmNGV01YSkJ1MkwvT2JOWG1Fd0NCUDNOaE5CVHN0SVFYd2Vk?=
 =?utf-8?B?K0VjT0YyNUNLUEpwdTVLRmNUWFBoWU9MQVVtZjhBMDRtZkRSSCtyZW1CZ1px?=
 =?utf-8?B?aDkzeUFWTVVSWU9jYWVwVHYwdTF3eThCWEo1T1NseHhoSFhkZVMwNERyWGlE?=
 =?utf-8?B?S3pLOUpIV2djK3VleE9CemNwS1BUbEhXYkd5MzVDRUEraG1lZ3NON3RuWVE1?=
 =?utf-8?B?NkZqcCtuV1JSMzZMSU1RRnhrdktsUVp3RXNtOXpFTkw5cmZHMTBmT24wU2FH?=
 =?utf-8?B?MVZPKzdlY1FyZEpkSnJERldRdlpFaVNETEZFWXJUaUJ4L1Jzb2VtU3NWNWk1?=
 =?utf-8?B?U0RGR29tME9qelBVc2d0VHRNRU80azZHRzFzTUk5ZjBRc2Y0dkdaOVZLeTFp?=
 =?utf-8?B?WjViTTJzMTloSDdId1BCSFpvYjFKRm5iYkhQa1ZjVkVWbytSdkZSNXZSdmx0?=
 =?utf-8?B?K3prS3BrMXNFYVMzWjI4empGQnh2SUtsL3Mxd2JPUitSN21OM2FGOTYxNTF1?=
 =?utf-8?B?Vjh2ZlRvVmdaVG1tUVk5Y0g2UGhPMll1T25RcUw3UDhOcVBuTnlvUmNLcUFo?=
 =?utf-8?B?UW5kby95c05PMkhSYW9LQlVhZytJV3N6bC9BV0VhSU10dm9IL21SN1QzamVl?=
 =?utf-8?B?RVIzV210NHdiMkJmY2dPcm9LSmFlTC9aRkp0YXAyeXRYeCtHcTZHSDZ4Uk9t?=
 =?utf-8?B?MC9NVERWc1pIbm5ldFFTYkNsNm83MGFkSjA1ZmRRWjRKTldNcGxNSWFIMVdr?=
 =?utf-8?B?SVpBeTdzOEhxYlNkSDk1cWtYMHZIL0ZOTDl2MjZMdit6S0RSK2NCcUNjS3pP?=
 =?utf-8?B?YXhKdFhIczVOUE5IYlBzQjlBVVE3cUMva0xHcVhERUxqdDY0S2tkRDZWc2lU?=
 =?utf-8?B?eHV4dXRWRFg1TlRMSEsyUHl3eU15aVJVdkZ2c2hDMGtJaExKbFdhQ09zbHlW?=
 =?utf-8?B?bk1mb1BFQW0xNUh2Qzg4VE9ka1lSQitJM2xKcVovNXlkR01zaTRzTzBMakIy?=
 =?utf-8?B?QVdURVhjanRKTUxlTlV0d28vbWNWWFhYQWlPT1pjVDd5STU3eGtncFdCZm5H?=
 =?utf-8?B?T21mSUtaT1c2cUh0aTJGRWIrSHlCMU1vZUQrRVhuM0hjcEVxSTFrM2JSZSts?=
 =?utf-8?B?VmpMRUlqakdGRjNzRjJ2Z05vaHl2cUNUdkNORk41c1NlbkMrbkpQa3JCbU1w?=
 =?utf-8?B?a3FURTRxUk8wSExIem9QdUZ6ekRPZnltM3JpUkpmbFIweGRzZkt6NW02SDZZ?=
 =?utf-8?B?bGNobmxnTUhjcFdaQkUwV2t5Q1U3akVmYzhMdlJFejNOeTR4RzBocWNHRjhP?=
 =?utf-8?B?UFowbXo1YmpZbEdyN2ZuOGd5WUI5SDRIR1lqMWdsWVRhdExheS91Tk9zS09D?=
 =?utf-8?B?TGlWZW5mSDJrbys4UHVqWXFyUDV4bERjRHErRFRPaUhDU002NWtReVJEVFdW?=
 =?utf-8?B?eEZienh2aisxVWg1bjdKOVZqU05zT1BhN1Mzdk14L0hRRU55L3lVekh1akt1?=
 =?utf-8?B?WHdpVWRTeGRnNE51d0FVZGdlM0VQc0xJWGtQVXN2SCs2NGFVSVRqMHllbkVM?=
 =?utf-8?B?aWtIU2RQTE54K29kdWdpUU5aUmZRVGpSSW0rTThkUGdPczhlYnhBbHBKSUxV?=
 =?utf-8?B?M05NWXYzQ3BRSUJRSUlmSWlTOHltS2l1T3JPYU9jcDFBNllWTnlFekZYSUlt?=
 =?utf-8?B?TjJJQ0ZGbW5zS0lWRXY5Z3hTMEM0elFnZ0w1NUYybE1xMHdEanIxUzRnVEoy?=
 =?utf-8?Q?Fpk/E0PFXIZHswHItl+b7hr+W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8421b2dd-4737-4f65-71e3-08dab61d9fb8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 00:12:37.7724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyzghxGah9Ju2T87jyS+9PgK+CxPSV2BwmV9lT8DgIF1Be80j91jq2HM/1epLEgrneKo9FwX8fnd/yJ9HgXmGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2022 22:50, Mario Limonciello wrote:
> Hybrid sleep is currently hardcoded to only operate with S3 even
> on systems that might not support it.
> 
> Instead of assuming this mode is what the user wants to use, for
> hybrid sleep follow the setting of `mem_sleep_current` which
> will respect mem_sleep_default kernel command line and policy
> decisions made by the presence of the FADT low power idle bit.
> 
> Reported-and-tested-by: kolAflash <kolAflash@kolahilft.de>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216574
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   kernel/power/hibernate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Hi Rafael,

This got sent near the merge window a few weeks ago.  It's a trivial fix 
so I just want to make sure it didn't get misplaced.

Thanks!

> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 89c71fce225dd..537dd3beafc16 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -641,7 +641,7 @@ static void power_down(void)
>   	int error;
>   
>   	if (hibernation_mode == HIBERNATION_SUSPEND) {
> -		error = suspend_devices_and_enter(PM_SUSPEND_MEM);
> +		error = suspend_devices_and_enter(mem_sleep_current);
>   		if (error) {
>   			hibernation_mode = hibernation_ops ?
>   						HIBERNATION_PLATFORM :

