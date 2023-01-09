Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E72F662445
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjAILfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbjAILfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:35:07 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D1218B2B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:35:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GK5hnmKpU9WGyScuRcitndI1FgSxR5RYlYzGwHv3CHbiskbAc46UoekaqpIa8274Z9ox1kcj/s9r7Ramwg6tLVMEHbvhDxCdzN04fBvZZw5RgkAOUGGNu3N3GoDFVwYfDD5MINcyrCjwXk9T0NTxkxK7K36OkMdyoCNFaMHiXI0YJoBAodl8YlmNWiichRL8iE/6nggAWvr2Xj1nuFw4ISRv+AlpH0gO7NXisGnk3IFtBPkhmE6xp5Stn5VyF+8XCAT6zUzr149qt1BKd8HykNthPOnKqc/3sPVytn9sQIXy7mzpn6w3meUsc5nP/l8pEukTSr12hMpVK7p85cQ5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8+gDLeY0K5YNXMPu8kBGXDCrFNa9Tad47Fj+XJWmZM=;
 b=ErFk72Z8BDqMFlP2XqOqf4f0GgKkZXR/+bZp2dLvnWVJM401jEjH/equStXgyjAI1lbg2gH3XNZsNzgT8anVpqTxcQ1/y6iQkL6grNMNcUsC4RlUQb4PtFTDIGbBCV/lj0jW1X/EPQSjU3Ck2ZYT3d2Tg7fhOxde6A2ggjN72mxNXw4SYwG+vhtyvmtej5RgJJyQEEK708si7+8pFH6Odpa9sY3PQuQowYN48mJI9N6OZB/TkznF7526Eu0oHpb93+EqfjGy7wvXzbMS9ZusSgCsiWIlX1vhIj+vpAS5igykiGVQjwha9Q31LP3CRPN/i+x7PayBah+uHYp3zn9UhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8+gDLeY0K5YNXMPu8kBGXDCrFNa9Tad47Fj+XJWmZM=;
 b=3lkoX7vH4f/Q8zZdt3KX21QQESFP9ks2bDNmD/sIcbXNjXHqZgfGyyjEB4Lya+vVysXGwbZN7rZwbWGG9AkFHooyuAkPuERxXP1xuMrP3RZygOBfiUcyCnqUnZSwnQSyQZ9ckgMFGCz464kfXzlT7E9lBHp9uCuLQ0JvD+j6FGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 11:35:03 +0000
Received: from MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::6437:4a32:ae0e:65a9]) by MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::6437:4a32:ae0e:65a9%3]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 11:35:03 +0000
Message-ID: <6ebdd688-a1e5-f687-2842-b5005fdd89db@amd.com>
Date:   Mon, 9 Jan 2023 17:00:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] ASoC: amd: ps: Fix uninitialized ret in
 create_acp64_platform_devs()
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     Syed.SabaKareem@amd.com, ndesaulniers@google.com, trix@redhat.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
References: <20230105-wsometimes-uninitialized-pci-ps-c-v2-1-c50321676325@kernel.org>
From:   syed saba kareem <ssabakar@amd.com>
In-Reply-To: <20230105-wsometimes-uninitialized-pci-ps-c-v2-1-c50321676325@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::20) To MN2PR12MB3661.namprd12.prod.outlook.com
 (2603:10b6:208:169::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3661:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: a15dc4c6-3e07-42db-ca92-08daf2358c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7VLbM1TAZPkthj8jsiaOxnimyBIRk0Qt/uL+PIKVXyWOnQV0KbU9pas8f3veOYVWcBWtduf8Ym54l9g+RurwRH9AO3+RxEIl1dYpt7VxnW3NACWS1VrQ2zjMpNJ+AqOzS9xANUD14TpojuD9qoxO/COJFw8D8HTk6dMrOWtvB0uSM9Q4HxaYgSj0AMiRWyMkXtMNGbs+73zNSiQaRyCkDuyJ2+b9weuaBRxyr/cgsokJ1AherKWGco/alvVWmIOJjqm2i+X/4RczRGiCLp7/NkDmGX/Bczt6T/Dk449dQaBRXxidrVqDdYJ5O1Sn7H2JrC95djkZRhyKYE0ULb9w4o4l3pw2IDsNWez1l2JUaUWOWmraQp7IRjLQjITd5M88KQaxmK6HKqIc7qQY/oCOMPvc2k50EncLacYqCjKuJFDRv/VMJM0fSVd7Pg5GCk7tmiEwEWu4W+RL/2PQE0BLEdReAAVUx1bvUdIPboA5HDFf4exk12M0L1FD7alsJ6EIe/P5wYsXbeSc7vsKCMry1nWa0zB4UwqHKRlS5XlssfHoSvdnD080EdTorqxYWGGu2W+cfbT/49rMtj85SeZ6PucPDQVVNjU+bHaOy9CaJHoJD1x8pJMv7ufyNZk7CLm6WUiZGj0GmLEb5jeDCSnKBy7Sok/QC8i7AQ1ZMLww/xbXAxAVSM9Q/x669OCK311s49cO3nMrT6HFVlnJMQvwsU2+R1FzMJPPYK93malQm/6snqacnN9KLU8bmDTO/wbxVQTW5vMJKQ+LALJ+wir+1JZaqiEe0/daFB1Ai8JUt5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199015)(45080400002)(36756003)(2906002)(66946007)(8676002)(66556008)(66476007)(4326008)(316002)(83380400001)(38100700002)(478600001)(6486002)(966005)(26005)(6512007)(186003)(6506007)(2616005)(31696002)(6666004)(53546011)(8936002)(5660300002)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UURMRTJnZUU0U3NDWmF4dHhRbTZZSVhWZWozVkJnVXAzNHNBbEREM0NXR3lm?=
 =?utf-8?B?aHFHVTYvek5jK3hVMG5ZU2lTOGt0amg3SGV3S0xLR3JMajJaLzB5dlZTelFa?=
 =?utf-8?B?YVZLaTc4cXRxS2tCeFRmQzR4Z0Z1WVNlYUpsTkRQUnpkVVVBRklOemdzbDVw?=
 =?utf-8?B?OWdOYVhkVE1VLzdtOFdIWHpraW9zVno0ZmxzbkdZWXduZWFmM3l1dExKT1Ni?=
 =?utf-8?B?MVBNSmM2QzNJZDdtS1lsVHlNa3Z2cndXR2NTNThRUUR1azd0bVNMb2U2SXZB?=
 =?utf-8?B?M0NxUnlQU1FCQk1LSEhaNjdzby94NU1VYTdPdllVK0xaK0d6clFrRitlMnVF?=
 =?utf-8?B?VUVDNUVYTmhmZThtS25mdHdwZHVwemdxb2h0VVc0K2JWUmQ2WktTWDFodFlr?=
 =?utf-8?B?UGxRSW5mazk5S1lBK2FCeFBhRTZEYVZmRGdXZW10TDlNZExYVnVrTHVwY2pp?=
 =?utf-8?B?YkwvV3F5U0FHaytvTnEvUmxhcjhyR2FpZDV1UjlTcmYxaU1IaDIyWlI1TFpw?=
 =?utf-8?B?TjNMQW5pSi9xL0ZZR2lhL3Z2Nk9OVmsyUXFOLzVpRUVaRjc4VDhEQ2pHRU95?=
 =?utf-8?B?a0MxRk1LSTlpeXNEUEhvdkx4YitOdnlQMi96dGl3ZEdvRU01N2RUVXgzNkRk?=
 =?utf-8?B?ZFBEQjU1aWFhSnN3V1VvWnR3dHczdUlMTSsxTmZxaGlOZVorc3FhNUY2OVBT?=
 =?utf-8?B?Ky82c1Z1V05PeEZQcDhQYzBSVGRPSUppTGo4blF4WUg2TGF3Qi91OWRtZDY5?=
 =?utf-8?B?WHNGRzRwVS9mZ3drRVFZaTlkckdqZ2tVMTJvQ2xxNGVnV1VLRTRKaFFJdWNm?=
 =?utf-8?B?c1c1S2JqM0ZINlU3azV4Sm9UdW5rQVhHZE5zaHhxMllxUk1kNUdNSnJ6STJk?=
 =?utf-8?B?Ynd6WXc2OHRGblFBTzQzNTE1MmVFa1pvcnpxZTY2YU85RnczWjZRa2FxQVBs?=
 =?utf-8?B?c1U1R20rQUd6Mm95NXJDZzN4Wm8vMkc1SjhmemRTWjhiUVY2MVloUmJwUjZa?=
 =?utf-8?B?dlVRQS9ENStVSEF0d0xYZVFrT3VHWjNWUnhTeHZxRGxKTXNLQldVNUYvc0s5?=
 =?utf-8?B?VXNMcG1Nc09zZFRuelBielJOeWRTU3RXckwvN3pRUVRTZ2FDeFZ1akZ2ZHo3?=
 =?utf-8?B?di9ZUEhJK083Q0FsZlNVbmt6aTR2cm5lMXhmZEVBblhZMFFBVUIvVmp5TDhS?=
 =?utf-8?B?a3NRelJaMnByWjRYYm1KcEJEZG8wcTc4QjNJY3JZVzZVK05EdDJiVjA1SjVu?=
 =?utf-8?B?RVA3eXJGa1ZKcXVuNUphby9tb1RkbGZ3dVIvQmRQQ1pJeEh1S1RkczgxU3Q5?=
 =?utf-8?B?eURYOFdBWWc2bmlhRURya2JKZ0pJeFR1Vzd2ZWh1ZERqNXIvcEhjOU9xOEhS?=
 =?utf-8?B?dFQ2MjNWOTUwL1I1THFGMVN6cG9HZUlaWGtPQmFwVFprNjNSUzNFR0JGK1Na?=
 =?utf-8?B?ZUtHZW5hbmJ1bHdRN2pDWVZlY0RWNGNYMkh3WERMRzV6RTYrdW8vUnFUMkt0?=
 =?utf-8?B?Z0U1TVlRVmtoV1ZSdUNENzVaOFZLLytBNUFhUmJiMWJjZ3BpME1ObmZjZmNu?=
 =?utf-8?B?VmNrZTBFQnUwbGVTUWE5ZjUxT3JQaVh3RDJzWmQyK3I2SHpDTVd6VWhYS2pt?=
 =?utf-8?B?R1htZEFFYTlMYWxzb1ZjYmxPOFQ5RU1uR1FPN2lGZ2RTTW9CTzdRbURRV1dE?=
 =?utf-8?B?ZlZoZnlmZ1FGK1M5ak1ydlFmUUlpV0JVUjM1RVpVOHBVMEN3UjN0L1l0bmE5?=
 =?utf-8?B?RGd6WVlPc0Y0QmdURjRnYVdaQjFwUWlpR2xVODVBK2dYekVwdlo1UlM5M0dX?=
 =?utf-8?B?NTlTRjNnRlFCVWJuS2hEVjdyTEpVTFhEaEY2SEp6d2hkSWJqNE9sKzJKS1V5?=
 =?utf-8?B?dEg5aCt1ek1SelpEbDRPNUxOUkh3anZ5MUxkdzRaeU85Q3BBKzZQZjBrTmk5?=
 =?utf-8?B?KzlmaG1VUkdpeG1jVTdrRFQzb0tueVdwVWZ5a0haTDRnMUZDY1JqY3F1TzJF?=
 =?utf-8?B?L1hqZEFvQ0ZHckgySDR4THhnVDYzS1dQYjVOVisxd2VrM1lQaGhYSDBHY1hL?=
 =?utf-8?B?VldrV2g5bEZKdTh5UDlUOERJZjEyUUZIRGFzQU1odTl6QnU5NithTjJycWx4?=
 =?utf-8?Q?39vp9yXsNMfwAiMFDbeO8QWwR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15dc4c6-3e07-42db-ca92-08daf2358c8b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 11:35:03.5412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sqIOWis5WFrEZTzN0yRffbX+0I5Qq5rrfuuMlWoKnVuimeT0m+xIG3avlvfOJNLQyrV9235E3yWuRHXWfOBew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/6/23 06:13, Nathan Chancellor wrote:
> Clang warns:
>
>    sound/soc/amd/ps/pci-ps.c:218:2: error: variable 'ret' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
>            default:
>            ^~~~~~~
>    sound/soc/amd/ps/pci-ps.c:239:9: note: uninitialized use occurs here
>            return ret;
>                   ^~~
>    sound/soc/amd/ps/pci-ps.c:190:9: note: initialize the variable 'ret' to silence this warning
>            int ret;
>                   ^
>                    = 0
>    1 error generated.
>
> ret is used uninitialized if 'goto de_init' is taken. As this is not an
> error nor should the ACP be deinitialized, just directly return 0 in
> this case statement, which resolves the warning.
>
> Fixes: 1d325cdaf7a2 ("ASoC: amd: ps: refactor platform device creation logic")
> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FClangBuiltLinux%2Flinux%2Fissues%2F1779&data=05%7C01%7CSyed.SabaKareem%40amd.com%7Cab19d64e997043ee07ae08daef7f10d0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638085626264112039%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=ximBlRFOMQKg0q6Rac19%2FaVNnyNaBUfkHm9Me5NYj2k%3D&reserved=0
> Suggested-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by : Syed Saba Kareem<syed.sabakareem@amd.com>

> ---
> Changes in v2:
> - Instead of setting ret to -ENODEV and going to de_init, just 'return 0' in
>    the default case (Vijendar)
> Link to v1: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F20230105-wsometimes-uninitialized-pci-ps-c-v1-1-4022fd077959%40kernel.org&data=05%7C01%7CSyed.SabaKareem%40amd.com%7Cab19d64e997043ee07ae08daef7f10d0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638085626264112039%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=rjsus%2BLxO7v%2F94R48F8VxQXtkt8QnibZLcCbEFLq%2F1g%3D&reserved=0
> ---
>   sound/soc/amd/ps/pci-ps.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
> index 401cfd0036be..64648b75de6b 100644
> --- a/sound/soc/amd/ps/pci-ps.c
> +++ b/sound/soc/amd/ps/pci-ps.c
> @@ -217,7 +217,7 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
>   		break;
>   	default:
>   		dev_dbg(&pci->dev, "No PDM devices found\n");
> -		goto de_init;
> +		return 0;
>   	}
>   
>   	for (index = 0; index < adata->pdev_count; index++) {
>
> ---
> base-commit: 03178b4f7e2c59ead102e5ab5acb82ce1eaefe46
> change-id: 20230105-wsometimes-uninitialized-pci-ps-c-3b5725c6ed31
>
> Best regards,
