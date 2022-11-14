Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA962628A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbiKNULR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbiKNULP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:11:15 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33BD1A809;
        Mon, 14 Nov 2022 12:11:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZvhVt84fJ8JpPozrFBoBhBrlCrwOFSg22p1ckm1E1GYPNk5eY5W295NHGsgdtnvjDrEM7VwI3/Y16c8XK+jnpslNEq8mjJzvkJLzM9iQ/yvjffXNkXER8UhvSLtCQ1dlWmseFzu/Rfmw/HO1zN/Db9zhW90+NqfqqJcqmL6lwcK2UB6u9ZwPGxUCTCBX31qMPZUHmD2KTwIq7H0tmclwzYkfIRm+JiAAPDNo5PvPADosSLoi+vwRjTs3/hI6cXucQptfLp/Rg33dQ6uAmSw6oCA3I5JP4+FQviIVxlVOa3r3+xMx5payluHmxqg330i3gx6TDwKCZsgQUWCBdSSZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jl4mCvG+2InjAj6nCLS9rvt/yVu6j61xkHX1wJKAX40=;
 b=YtfRz9Q/JZAMHPzPJtrNpEZ6v7aoY4+gHd1a3wqfGM+kUr46d2NdDtKkVbM/9Wv6gdLSjUmiiUe6iuTuUB/vVi7IYVRCibu30X+5OtpsBGG/YgRKvGQO2DpnzoGTppYpchsZtsS4hmVBYF0G/B6eSeXPMN/ylMGciHyKleLcLRUkDajWRcnOrwrWcIWlu8BVqc2R4bqQahYetJXfFkKkLVzMVb0YOc6btMOFdtCdqFOnUmBn/CE5IeY+2QiO96PrwsT0fBlrD0bgPRIdTmKLH+sPHZK68XqJR+46t5p+s5OonMJ7DJ9UpZHmRadyolHI/ZKqZ/25MKzOGEi9K8+DDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jl4mCvG+2InjAj6nCLS9rvt/yVu6j61xkHX1wJKAX40=;
 b=rxJWJSAIS5G6IFTI3uZ3btcRALSVO0iAmWuasR6tl+HdRpDVMj28eMeZ3dQzDC1RCLypktjR/j3/6ZzEsKXYvRDWcAzHdrsuq3aJm9GHS9ZKXUcDxA8WVndmK7v1x4NUBaR0+dPER6K78bEXdlor4ZVPTaR118zNU/uepVThPi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW5PR12MB5623.namprd12.prod.outlook.com (2603:10b6:303:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 20:11:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657%4]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 20:11:08 +0000
Message-ID: <e61a5623-ec36-593a-3121-744d33dcb30e@amd.com>
Date:   Mon, 14 Nov 2022 14:11:06 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] platform/x86: hp-wmi: Ignore Smart Experience App event
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, hdegoede@redhat.com,
        markgross@kernel.org, Jorge Lopez <jorge.lopez2@hp.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221114073842.205392-1-kai.heng.feng@canonical.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221114073842.205392-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:610:75::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW5PR12MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: 15349371-9d66-418f-799a-08dac67c5e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v6MfgfZvgIIrDpij83CZYoYZBqopc3NpOC2x4hxfRLtP2WtP0d5/WKcatOJqtKBGVQp8Hh3VFELriiIFW7WSw3t6U4snM/r9mW4Iw1e4rhohCsLlt9pwyAhULED0i3iYi2S8kwxspWSZ5nrsMyYNDPFET7vJELVtSDnMoso2K+r7UuhHD3A+kXltiofQkBC1OFXiNpTH6Ww6vr6iB4wZEithw4inl873rUDuCrBm3+5ICv0kGbx8LgGgOanWvK3EZazghwUsNchzzKfCuCB3p3DdZ4c3TqOrJ0ClxGHgxxBO80bIBY3rUJH0MnG7hk8Q4flB0g7UJa1XnDnDz+L+daByuD75Eip1T+5xaGqq9vrefEvkUw9grYi/YZbiQMh1RW4mxUrAS6Gr3ECM2ZoeNrMoDX13gPWVq8IccXsXR34FAiS3QU1zB9OTiw5vp/iCIdat1ny8YUh5krnZtFoRFAmbX6W7ATkaW9qQphY0HGgKdLbScfBZjEe51XCxq5zksD++F+5OYxRi0CREQWkFTj4ivKeSHpF01HCBM6gpAzNKy4leFR3EM4glWeo/f1Jge+seEUXHVWbDU8J+3D8unFkroGIelBd3Afo+Cq2u6BfcvCU21nc8ThiqV7wg0nzwu3Tw6kkjgQ/+y7QDcKR7ooumVX78SmwkmFjWTElPkA2bwh5VK/vHP6TPG8bo6cYIPXw441NSSaLPJWUzN0j8OBjb02g6zSD9cnceNEAh4Pgbmp3useM77y/xtmA/xGSbe2j0roRXKnU88kBUHYQEQNOs8W/tuNl6XoEIcnIltvA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199015)(2616005)(186003)(2906002)(8936002)(38100700002)(6486002)(478600001)(26005)(6512007)(6506007)(66556008)(66476007)(5660300002)(8676002)(53546011)(4326008)(66946007)(41300700001)(110136005)(316002)(31686004)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3NjNndwMjhHS0kvY1BsdXNOZjhTcG9LUGdkdy92bVE1bS9jQlN4Y1hPN08x?=
 =?utf-8?B?aTFhT2t3MWVuSmxKMWc0Q281ZDIyVlluRGdCNHdRU1k1VlFmTGw5cWVid3Fz?=
 =?utf-8?B?blowbDRGMWc4Wm51bVpoVmN5dXFFRncxTTNjYTYybjVDNW5oZWEvbSsvOUEz?=
 =?utf-8?B?TFpkWmxuV3dhYk9OWm1lM2hUcmFELzc4MjJIdnI3TnczZStCSTVacTZxa3U0?=
 =?utf-8?B?eVMzcVhYOUhFMndTOE0wdHBKa2pld21LTzlBMEk0ckhyNkFKT1hydFZkeldq?=
 =?utf-8?B?SHdNcW84ZjNoMko5a1p0NUtEOXpndnI4dmJLZWVUWWZxRjNRQ2t6cmtCYitV?=
 =?utf-8?B?ZElOa3g2UGxYWWVZR0J3UWRHcTE1aEl4dzFJUXVzZVZCbFNiTkhFdm1zbTNJ?=
 =?utf-8?B?RCthSC9pc3h3blJOUTNlWUdWVFYwR3JHYmt6WDJXVmxwUHlCUVpjVmFJaG50?=
 =?utf-8?B?N2lyUDJzSC9LaGtUN2JNNkFiakFBVzQrRGN6RnJnRDJUTkdrM2hBVVZjOUo1?=
 =?utf-8?B?Yy9ibXpkUk04WEtQOE5RVHVqWWxWV0VUNWt4VElLd281TVhJZXFyK0JIWlF1?=
 =?utf-8?B?ZzVtUzdreFhtNHhwbXM3T0hpK3dLZWdpTENJZGtZWHlJV3R3WGlFYzJEWVBH?=
 =?utf-8?B?aU1DNVRSaUVqazEvMXU3emlZdklac3VyNmVwa2psbWpaSVlIQWp3ZUVlc25U?=
 =?utf-8?B?d1M1a2g1YnRad3pSTWVEQXB3bFI4TGczdyt0YjVQRWVWejZoZEdMaW42K3pB?=
 =?utf-8?B?YXFqd3krb210cHZkMWVySjRNNU9ybzc5ZXQ4elJCVGFWVTJUN1RGblRMODBH?=
 =?utf-8?B?Qjk5N0F4WnE2ZVlCc2tYTTcwSGdhejk4TldWNkpGT3ltSDZJb0ErbC9CSFJ2?=
 =?utf-8?B?bGFwQy9HTU03bG1OV2h4RVRRVFUvbkpvZXR2Z2N6K29sUVE2QXVZa3poSHdX?=
 =?utf-8?B?TUdtL20xblhFZzEycHJVb3hLUmtodUEwN1BYMklTckdQUlppUFNrUGs4emdi?=
 =?utf-8?B?RW5nU3BwSzhTMzJ6eDNhcTkvMXBpSC9wdXV0L3BtcW1IbGhJVEEyV3ZTQkp5?=
 =?utf-8?B?QWQ0bDloUVRDVG1EVjhBaXhKQ3UrVE0zbDd0T0d6N1RncUJFVThmcmhqWVl3?=
 =?utf-8?B?aXJsMFllTC93OWpaUXhScGtjRG9QSEpJcHQyS2JQRjQwck92NVpscXNpL3p0?=
 =?utf-8?B?aWt1ekFMd0VBYjlXVW9oVXBVWUVGU1ZKRitQY2dUM0JJQjJVeEVqbHhXVGtx?=
 =?utf-8?B?YUFBM1RveDlkMk1qR3Z6ZXF0RTFOY0swU3YwV2hnU2dPaU12V3lZU0Y0T3pl?=
 =?utf-8?B?RkF0c205T1YrbXpEL0VKcVVOazd4SzcydHdySTRFSVhiSHBsVEYwWmp1Qnpk?=
 =?utf-8?B?Wi9mbmZmdlE4YjErdnNMTmZIOUlpOEU5MTZEc0dDd3Iwa3FqUFBIOTZ6amhO?=
 =?utf-8?B?U1JUbHNLdE5mamtyMEdZUkhEY2pmd2ZDbnRWTzdSK1pFWXdpbmlIMytZelUz?=
 =?utf-8?B?am9wS2NhT05vdmE3UFhNdlMraU0xZ3o5cmJqTWZpK2dRMmNORXBVSEo5VE5J?=
 =?utf-8?B?QTdrZ2xoL1QwYU02Z1AwN1hqRkZ5NGpQMmhHM2p1dzRJa2xiUjNSU0UxeTN6?=
 =?utf-8?B?WG5nV0puc2JOSEd6UDY2UkZUcGQ2d1pTUUQyMmhTa0hjOTFMcVp0ZzQ0MHd6?=
 =?utf-8?B?N1NLR1pGQ0RWSFRJZXZJMTUwTlRLdkwrZ0Z3bldtZjkrNVNOQW1qK1dOUUdm?=
 =?utf-8?B?cjY0cC9YVDV1Y2lENStDa0lka1dxNjVHOXdmZmR0RkZiNzlINjZpSHBlcXdI?=
 =?utf-8?B?OTI5WDhLWmJjKzZtYUhBd2NFNHphUUFkckRpV2NPU2ZZckNXR1M5bFdjbDZu?=
 =?utf-8?B?YktBYzFxcnZxdktYKzlFRmZCallhb2YrSlRCOVJFYlJWcWJNS0pVWFBENTUy?=
 =?utf-8?B?MWRUTXdpcmxPY1FlRlhuNTZJazJ4K2pmT1pwc1FGUU1LS2QxejcwWVJyV3BG?=
 =?utf-8?B?VjhCem92VTlDTlNsczVDaWZjWnBQTUpyM1ZGSmNsZStVMzd6Tlh0cENIWks0?=
 =?utf-8?B?cXM3Q3cwQ0sycTV1RjExeE5WK3VaUDhGTlpJKzRPNWRMTTIzZlNaWjE0blN4?=
 =?utf-8?Q?yUXwEmRUDzGJ8Py7g/dkW86kT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15349371-9d66-418f-799a-08dac67c5e25
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 20:11:08.5344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 823+quCKPBqDzU3MyWbTB2jE2DPivHlwP7dfiCAgG50TNbgSwDBezEguQZue/r6UDCQyBPi+hp0qK7qIDZxq4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5623
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Jorge Lopez @ HP

On 11/14/2022 01:38, Kai-Heng Feng wrote:
> Sometimes hp-wmi driver complains on system resume:
> [ 483.116451] hp_wmi: Unknown event_id - 33 - 0x0
> 
> According to HP it's a feature called "HP Smart Experience App" and it's
> safe to be ignored.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   drivers/platform/x86/hp-wmi.c | 3 +++
>   1 file changed, 3 insertions(+)
> 

Jorge,

Can you please review KH's submission?

Also to avoid playing wack-a-mole, can you cross reference your internal 
specs against any other missing event IDs and send follow up patches if 
anything else is missing?

Thanks,

> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
> index 12449038bed12..0a99058be8130 100644
> --- a/drivers/platform/x86/hp-wmi.c
> +++ b/drivers/platform/x86/hp-wmi.c
> @@ -90,6 +90,7 @@ enum hp_wmi_event_ids {
>   	HPWMI_PEAKSHIFT_PERIOD		= 0x0F,
>   	HPWMI_BATTERY_CHARGE_PERIOD	= 0x10,
>   	HPWMI_SANITIZATION_MODE		= 0x17,
> +	HPWMI_SMART_EXPERIENCE_APP	= 0x21,
>   };
>   
>   /*
> @@ -859,6 +860,8 @@ static void hp_wmi_notify(u32 value, void *context)
>   		break;
>   	case HPWMI_SANITIZATION_MODE:
>   		break;
> +	case HPWMI_SMART_EXPERIENCE_APP:
> +		break;
>   	default:
>   		pr_info("Unknown event_id - %d - 0x%x\n", event_id, event_data);
>   		break;

