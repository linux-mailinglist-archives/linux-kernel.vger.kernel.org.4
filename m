Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6191A63E1CC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiK3UXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiK3UWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:22:41 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708CEDF;
        Wed, 30 Nov 2022 12:21:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFS5bYGoaUfI3J18Zz4juOOL0p/jY0uq9ShQZuvAcXQgXKsORzE6QoM+cSPZmlCTyx7e74gXoP1UZk0xLxKRA3vEVnYlqER63zrJCXCNxI8nt3Zd9iF7e+tSrosjyXvpHn2OVLJGi+IITBRsE9AxosWvQ7VvdRL9C/ctwbN+pirV9gN3ubNqGEA36BnG0LVXE2mj4XgLZ7sE0Z2wub7z3oWKGk1zsnefpdydHDLIQ43JE2hqGFZyE94aYOxiaOBWHcSDpOwyUzda4CheYDEUmm3/Aa2jGA15aWMvdHMveDf96znkUfF7HVdg1kPaTJQhExA5Aw0HtKdKRkbyxp7d5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+8yQpp/15187et8ZalSLQdRLjmahK+MxKnHDjatUd4=;
 b=GuZvzq5jw5h3cuVQvLtvT/cmF+MRnck+R413FFC8eGRVM2LTrG2DpVsVP0XEXexuHfU8otDPRcbKu+n0Y5b/goDzbeb6TUzvLEJ9QVujIbrnuBD2bYvFloD79C8AnD15f1ZNvm1eLG4WY7NzUgopCEnn4TmEXvle4AwhMgst8422Ucu+O2bu/ouWO60pV6o62/rRXkkWNC2fW3pcgPobtJQJ4gDD99ICS3G9QBjLmM//mGA2FR+nz4kowU44Jxt8YkrwM/N2VYQBciopGqc01yra7KssS4IWCPmlenEPLtqrneVfYZ7xSgIO6IR44gN+D7hUG2+/SezlCxG5XO4F3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+8yQpp/15187et8ZalSLQdRLjmahK+MxKnHDjatUd4=;
 b=sDcDMbUGpZ5cawWaT2chcr3E/O9CE98w4sXKnMs4r/M3OsHhY6VrXKmpavwNsS1UMEMObXltbwnJiXLJuc78atl+wojIPxaRwg5wUKrWAYLXl1I49Ld8dRLGJuQEyohgKdALySTIHJNztZFP4wogMgoPHiZxD8Ldgqk1T31IyU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3270.namprd12.prod.outlook.com (2603:10b6:a03:137::31)
 by BY5PR12MB4998.namprd12.prod.outlook.com (2603:10b6:a03:1d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 20:21:02 +0000
Received: from BYAPR12MB3270.namprd12.prod.outlook.com
 ([fe80::b770:9062:384e:6908]) by BYAPR12MB3270.namprd12.prod.outlook.com
 ([fe80::b770:9062:384e:6908%6]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 20:21:02 +0000
Message-ID: <34cda496-a942-8f66-c968-cf9f06a58efc@amd.com>
Date:   Wed, 30 Nov 2022 14:20:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 0/3] ACPI, APEI, EINJ: Add new CXL Error Types
To:     Jay Lu <jaylu102@amd.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
        jarkko@kernel.org, xueshuai@linux.alibaba.com
Cc:     yazen.ghannam@amd.com, linux-acpi@vger.kernel.org
References: <20220729153550.181209-1-jaylu102@amd.com>
Content-Language: en-US
In-Reply-To: <20220729153550.181209-1-jaylu102@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:610:b3::8) To BYAPR12MB3270.namprd12.prod.outlook.com
 (2603:10b6:a03:137::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3270:EE_|BY5PR12MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: ed89093f-3329-4564-94f3-08dad3106696
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yeLH53wN5W+7RkHouEd9fFb3d0ctbU0gd8wIzf4KoB66ESrSm3TkfMaiQfRsc6tpTVTXkpIc0TMnz5BGxdkr8xOnE4vdVONYj8QZSCwrbXF2rqnjYkzJnr3l0F7Bw9GDpl/fgkurLzqif8CNhsMZmRJryvmrXGILXPugOE01WijvLDnRnjWdABhf984jAG1oOq/bj2nXC+qplkxYzDqzj7iZ/yInTL3dnhZpT7MFN03b8bGuoepzs31DI770ExghHE30SsFeKS2ChDhfr8s/aJYZXz/JCMbECrYYohxcJaGRT0/iei0kuYQaN32guEoP6eZVGsBLG9obHIQeY+ZWXDQByL4E1ODtG+EtagFfk7mtTIwx+EjgZvgEhFTpBLs5eUM4CAItF/6Lbx0eMF8L2zEPqAyemWYrFj1rguqWZIxMgzVsvXVDJhZAkbiFMw424ROrggIS337Dqn9xglsaLNXZRfmkMvgw0yaTGakiazn1wocB7KWkOqYJoYdpjSIMBgmLBIedqYd6qdnDkx/gU4xyZK1m3w7/cHbkoY8DbdRXlQAlzRw/sMshpqaiQKwF9bY6stEcP1crqywgBujHCFMm4NgFvt3/4XjUc4si6FHgqOVSdVodomtWcDMcT1qXjHQtlAIKlMYBnGa7q24ENc+W6yqw2ZKhSvOtC6DQNs7PBWre3dW+nsjxImMZadbNL9kIaMb0HBSMluXs+MtBMAgWHTxfQDnajdVBcqtTb0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3270.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199015)(41300700001)(7416002)(5660300002)(8936002)(4326008)(66476007)(8676002)(66556008)(4744005)(31686004)(86362001)(316002)(66946007)(36756003)(478600001)(2906002)(6512007)(53546011)(921005)(31696002)(6506007)(186003)(6486002)(2616005)(83380400001)(38100700002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M09ScnhBRWc1N040VWdmZU5QdG5XODl6bDRpeHBwVWJrWXd0Y3FFSEtzNWRT?=
 =?utf-8?B?SUJjUVhRcnE4THdDaC9OQ0twY1hyY2JtcXYveHozaUtsaSszR1BIdDRRU1cv?=
 =?utf-8?B?cnJHVTU1UUEzT0NoUWVmWHI5NDZXVXp3VmNzNk9QZExPMVYwN1l6RnZpWDJD?=
 =?utf-8?B?cU5yYWk2U0tQM1RvZ08xcGR2bGhWNlB0Nm8zbzZVRmNMR2VSQnJvVmtEcWVW?=
 =?utf-8?B?amczb1JnQVI3ekhZN0l4VTl5bVFkVWxQM1dRWEVjNEZ4aVRTWk16TGtlbHNH?=
 =?utf-8?B?cmJoa3VlRFd5b1FheVdJeVc2WGVFVm9JWEF1Sm4yUjFLR3NjbVhlSVFoaXk4?=
 =?utf-8?B?OHYrWEJnbmdOWWVzZG9Oem5TYThmNTVoTm1wejVUMHoyU2dUUDJnSDhSZncz?=
 =?utf-8?B?UkdjZ0VaYkpwUVRQeFh3WHVGZlRjblgyOElGK1hVaGpZM2h6V3hZY1RuMUpw?=
 =?utf-8?B?WDVWQVhjNVFHdGtPb2NlUERMejlQdGRXVnhpSGcwemJWR2NxSFF4TjFqc1JE?=
 =?utf-8?B?L2JyazNKZVVlNlIzRUVqQnV3OFNaMlZ4ZlErOHdHQ0JRTDJVWGlLVW15aExL?=
 =?utf-8?B?cnZuV2I0eFMvYnNWcEtaRUxzdVNPL2RCQllBbkJQZVNyQ0VyQ2g0RkxDdG04?=
 =?utf-8?B?OXZMOTg0aUYxMVI4YWs5UzI3cmVSY2crano0dHZDbGhGdG9OblZEYjhINHZt?=
 =?utf-8?B?ZU1NTTd0VUFPTHBFSmpNUTFBaXMyNkhmdlZZakNsUmhjNUFYcG5rWjZZY3Jo?=
 =?utf-8?B?bFdYZ1pYVXAyQTR3L2MrLzlXWnpHMDFBNGI0M3BlelJTTjdLQkIwdnVDY0Vp?=
 =?utf-8?B?K2tCTkpGaFFLNzhwTDYxQ3pMREJjVml3b01SL3Z1UnZFOHJYOEZqUm9ldEEy?=
 =?utf-8?B?Mmg1WENHWHR4Qm9tbjFDMy8yQ25jOEdLc1VNanRHZmhZWGRiMDF0WS9ZNXJo?=
 =?utf-8?B?UitXOXBBWGNsZFZIZExERWxHMERFeDYvMk01TSs3SHNoSW54MitlVldkeXJB?=
 =?utf-8?B?M1RYN2dCK0FrU0pybkhncTFpREdPR0tta3NmeXh0dWNrY09Yam1wSTVweTBx?=
 =?utf-8?B?a25QYm1Jak5rckJId1llTWtxRllPRGFHZE51S0JNWHVILytlTGJyTEV3Z0sz?=
 =?utf-8?B?YW0rdjN2VVdNL1hZemNrV3FJWGFidnErTFdHMmhmTy9Yelh6VzJ2RlpxRUVY?=
 =?utf-8?B?eS8wZWkvRWY4QXJySUxRZW81U2F6OXlqY2V3ems2N2syanhmQWIxNTYyeDJI?=
 =?utf-8?B?WmVZWjVLMGYyaVFIQ0VnTytFVjBTUHJsUVgycUFBY1R0cGd6aFp4bnhhSU9m?=
 =?utf-8?B?Sk13NDhqeFczWjJMcWxtZ01iMUx2UVhBeGRTYWp2MjFzbHEremdFMzFOTkhJ?=
 =?utf-8?B?NmEwN3dPWi9USDN4K0J1SjkrREJUdFpJNnBsREFTR2tkK25XZk5VMVdFam9N?=
 =?utf-8?B?WHNMUXB4TXBCek80b2s0Rm5wRFlHK2RucFJRL240SlVMT3hVSG1iMENRUkVp?=
 =?utf-8?B?OHlITW1Yb25aak42YmhDR29GTkRPT21OQ1lkTTNXUDBkekplbTIwV05CcUts?=
 =?utf-8?B?U1E0WHorQVRHREZpMlIvWkJZQjhudi9QSkN3WWpIYkJEem1VVjlOYU1GUTcr?=
 =?utf-8?B?a2EyWGp4V2ZsS215VW9MekJaK1c1ZHB2QUpHckRTdkhPbnRkRE4zTHhTSHAw?=
 =?utf-8?B?Q1ZyNVQ1MjV2SEI2WWZWS2laeDZuemw0eUUwZDJMMy9EaXN4Z2NlWVRZQzJS?=
 =?utf-8?B?NGMrTWtVY2hwVnplNGcyVFNPbzByazNxUEE0aGNDdVk2cjgrYW1Ca1V0OEQ0?=
 =?utf-8?B?ZU5UTUtrU1NCeTNCK1k5ZkdCdHJTQkcyTVBNNzF3UlZZUVlPR0lYOWhXb3hm?=
 =?utf-8?B?Y0hXUUU5ZG5hN0ZGczdySFh4b1UydmZFUDhzQkhRTjJadytod2ZyNlA0TFVh?=
 =?utf-8?B?bGVVSXVQU1NsOGhnQ2s5MGZHc2JFbjAxWkppa1p2aXkvakczUFdIdjBLVk1G?=
 =?utf-8?B?RHY0bmZ5NkJwWmxGRERQYlkwY0s2bDNkY2MrN3BjOTdVU3RuSVBtaGc3Vzdx?=
 =?utf-8?B?ZkxHS0hiYit1cno1TnRteSt0UmRQWTU5c3VCVzBpSmV3RTgycFFzK0o0d2FM?=
 =?utf-8?B?UUhmMzJPNGtCd1RyWi9sSVh5eWlGQ1FDMmRYc09iRklDZTkvb09jQjMrVFox?=
 =?utf-8?Q?fSI6uTUUmV11SdahD0azG3aW77YLNjyt9jDRtt8fSSrT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed89093f-3329-4564-94f3-08dad3106696
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3270.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 20:21:02.2147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wtkbtEQZ3JraNEB7hmVVU3bbh8b1wRDlPCkEUHt0Ldse7SekxEPC5RFPrPPSJNTB+Tu/htB+DplB1clbIVQPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4998
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Jay's internship at AMD ended a couple of months ago and I was asked to 
pick this up for her. I made the suggested changes and also have a EINJ 
patch given to me by Yazen that has to do with this one so I'll be 
adding that in as well. I'm still waiting for a machine to test with, 
but I expect to send out v2 later this week. Thanks

On 7/29/22 10:35 AM, Jay Lu wrote:
> Fix formatting errors alerted by checkpatch.pl, including missing
> lines and indentations to clean up for following patches.
>   
> Create an array to store error type descriptions for maintainability.
>
> Add new CXL error types so that they are advertised.
>
> Jay Lu (3):
>    ACPI, APEI, EINJ: Fix Formatting Errors
>    ACPI, APEI, EINJ: Refactor available_error_type_show
>    ACPI, APEI, EINJ: Add support for new CXL error types
>
>   drivers/acpi/apei/einj.c | 62 ++++++++++++++++++++--------------------
>   1 file changed, 31 insertions(+), 31 deletions(-)
>
