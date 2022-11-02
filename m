Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1135F616AC8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiKBRa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKBRa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:30:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF292228C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+37H6C3QeuBAoHfAYFwdvQ1K1+mITgQzHZT/XbeOJ2tS8xNy4/O06SGLHjpvriQytzjlDIVVE1Sco1HWn/liEfmEBnmUkTleXr3Wc0RU8cpv3np00X9qsKqI0Ux1bsm74S1DkkPkECVTafEp7st+iSpna8TmiHv/2KKxjd8Nm1j88OcUdvHvEqlmQA1cdxd2dgqbYTOq6MP51dnMxA6IucwUZDU+JPAJwuMhuGe6vACiUKI/TlriY68NUTi+ctoWhVvwGg610vF47XecucEpif6eZMfj7ngovvuhsrAsf1qcrBOLv82a/ZvK2SyTFxBuqR96sag8J8H5fGgeyCyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vrb6pXGDness/DfWjyRDcaTXdJT79uXvMI+1yV7hSes=;
 b=CijZArdsP4XOq9fHc9C/fUiZG0xRlE5vi9zfxu9AC7ZXUbC6HMdQkP/8lXdcOgJqRU0AdB8hGnJoDuXnvPj5sFkZurSDf959VsO4zooTt6UkJE3fQsFZ+k+r2SYCsL5xxlv4b+wYKEftpToMhyLoTYytt0x5nRIWGuK2NuKOjVcF4mVuqoSKalch2UInOw/2LaZsCd7SvAbk9Pv2tYhwo+1wxbWmVvvelgNFjgVmVyXzDDLfkd91Zqp8mMUTyBKIs3m9irCBPJg4QYhdBg7jABNtgeduxyh+Z3rVmcA1WDTf/FHfZSRdyC9gJ2D8Qb0/KwkPlkpTU3g+asFMJk4LQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vrb6pXGDness/DfWjyRDcaTXdJT79uXvMI+1yV7hSes=;
 b=HxoP67lua+aGUI9vDPQY1SNLFq89xilw4Dcte8AHkAg/mAh+NkNH65p007vgu+KhMezFuY1UuV1YO/lSytgDMePa8VMKLlzk9ZJC8q8yVR1LDxj0syO3pCvmylpdtZLPiRPNnzhust/26oLglEZNHfe+HZ5E8Lx9fAd2LRDDDq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 17:30:20 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00%2]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 17:30:19 +0000
Message-ID: <55c2794b-a8fc-790d-1529-424ae804185e@amd.com>
Date:   Wed, 2 Nov 2022 12:30:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v5 1/4] ccp: Name -1 return value as SEV_RET_NO_FW_CALL
Content-Language: en-US
To:     Peter Gonda <pgonda@google.com>, dionnaglaze@google.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     jroedel@suse.de, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com
References: <20221102151836.1310509-1-dionnaglaze@google.com>
 <20221102151836.1310509-2-dionnaglaze@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20221102151836.1310509-2-dionnaglaze@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:610:54::26) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|BY5PR12MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: c22e2fef-3e1c-4438-402e-08dabcf7e9dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kb+otcfksN/aVmQL1JNbbeK7B8hlho8lRmm3MX2jOV1vC2tj9BNBNVOoCbobxTzi4T1GeWffruDsca3/ZwFCTu+ZvWGzttrPhtuzrRjNQXA6J+ZJQH12FpjgvkQ3Ukrc13IE4vXTGBGbaf98AuqlykkawED2+lebecsqc+2JNxkCLzoDNLfvOekK3/J8v6Vg+CPqj5zz4Ufym2jNQF5Z/ueMqAc2k582DFfQXg6+MRLU9s0MulZm1YKabl09a8n7xMxkTcwlGB7zPDCXOMaqpXlg8/KXjFiMCMl5B4Q9moKd6p0dzm6ZLhnv2Ma+7D6mKjlXXK9LvxIqsROWeUqpTpgw3CPOX+MuLlD3SeoMvkCBVSDO+vSscOWq5Vw1g+uet7KDMMf2HPADU4aM+YjO3+cHJXUEc6N/YTJu3zgCtoqa1MRkEowRfCBw52p6I/AFYLLaKN3qIZrh+3/aiW9dqR40S1Cpi1zKojec6z2e2eaYBPJxe4rrEuuZM/W+cwkM4dNarH5t3VaSoU+FekgxaK6K4v2HPbwjAYXlx0cEPWL9jnkv3WCW0gOnD7JYsMlrHEEUDu8DU0d0johmhLiLuexd1uaZnOdRIwASHtHRzyXmnMQoVppsMYyN2a+Yz0oYns9HDq9FhQ8TqlK5ifvjKICqkRuF6ntHF/88nrGlASSUitEdoY17JfI3FxShkmgLT/DBJd6fWuBbU4Bl08Jr+/EAtlX1V+dD093oZZ4Y2kxJUzRHgsV34z7Gg2XQ6if8O66hHHykkjnRAcXAYwBcb1bsC0TZBo82JWEIch/x0Mc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199015)(36756003)(41300700001)(316002)(8936002)(83380400001)(66556008)(4326008)(8676002)(478600001)(2906002)(66946007)(66476007)(5660300002)(6512007)(6486002)(26005)(2616005)(31686004)(186003)(31696002)(38100700002)(86362001)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUdzUFA5c2R0SU9jU212ZkZuMG1FVmg1a3YzR1Vsb3J3akZZUk9DK28xZHZa?=
 =?utf-8?B?VVR2VkdFYVR6ZUh5cDVmZDlxeExlYWQxRm9LVFU2cjY3a2E2NTZHb01mSzBI?=
 =?utf-8?B?Y1Q1U3ZrYkJpSHJjamZaM0pFSzl4L3JsNk1nNXUxUklITVhYY1FTa2R1bDBj?=
 =?utf-8?B?WUFsTTRnemhUWXZNcHhOUExZaXFhajZ2N1cvN2dkUVlRL1NiTTJ6VDYraitI?=
 =?utf-8?B?RjFkQm5VdFdJaisyajV1djNxRUh3SUhqcWVkRGJLcThhQ01EM2VJeWx2Z0h3?=
 =?utf-8?B?aERabmpyVVZNcUJOV0hiVGU0V0x6TDhIYXNKWktwMndUYy9Hc0tuVmVjMFFM?=
 =?utf-8?B?SEVKOHFHQXh4UjNFQkY1YXdSMWEvVzFyQkxmNU9IeGIxajdVSktXbU0yUGhr?=
 =?utf-8?B?Qml5cU5Rd0xyZGFsTzJXb1E5dzM0M01paWxKQWZQeEVUSXU4ZUphUUNDWXhs?=
 =?utf-8?B?U2ZJb01IMytYcVhaRjhKalg4N2xXNEpCREUxVTVQUkkzeU1EWTBaS0pFblpP?=
 =?utf-8?B?amgxY3N2R3plNjdMVGM4TmQyV3BmeGtTbURSbFhsYmVSZitBT1JQSmcrU2tU?=
 =?utf-8?B?KzJhNkpiVEx6eStoSHJyckVSYnRwUHhYUU1neFlZMUQ3T0FMR0Nialc0WTBP?=
 =?utf-8?B?WHVTT05oZ3VyTHBETnMxRmZJQThFMFEwdHkveVNSQUlNdVRYeU9sV2RmZHZv?=
 =?utf-8?B?TEI3UEpyUlJaeE5aOGdiSnJhVk9sTGZtQnFVUjNwS1lPMXVxV2puK1pQRkx1?=
 =?utf-8?B?ZnlzOHRCZzV4MlVIOFAvdTFTZ2ZxRDdZQ2VPS2xXZ3ZmZkUyQksrNWlxczJR?=
 =?utf-8?B?djZWTTc5c1RqVUkzWWhvczg3OExWdlJDQzdYblk1Sk5aNDkrM0thTFo3WERl?=
 =?utf-8?B?dVlNSUxrcWVUZ2Q5d0hQYStwWkFPYWJxaTRoKzQ5dE5EMXpYT3BieXBERjNT?=
 =?utf-8?B?RXBuRWdTclBKdzNVVVdIMWR0Z1JiWFZpSHlFMm1ncFB2dnhsTzZueUNkbUZH?=
 =?utf-8?B?QW40NXNka2o2RGp0R1FFUFlweWxyY1VETWYyTzliSktDS0RFZXhSRUl2RWVC?=
 =?utf-8?B?aGltMUhIWXpYcDVxV2FKQkhaVWp4V3dpZzIyTThSbFE0RlZRQTJ3RCt1U1lm?=
 =?utf-8?B?WmpyZ1lzdW5QOFdPY1JHaFE0cmIwdWRDU1JKTUZNVnNuMTRINXZYcGM1S0h4?=
 =?utf-8?B?dmp6QjlSOWpQUjFrMDVabUl0RlJxbTdzUzBBejdhQVF3RjN6SjJaR3pjZDNK?=
 =?utf-8?B?V2l6ZkFBRWpEQmtraUt6V3FPOHhHRFNhR2ZXeHV4QWRSaExyczdMWmhiNjhY?=
 =?utf-8?B?T3I0MkdwQzdjeU4xV2ZSME1sK0J6N3BFa3U3KzNHbWw4cUx4d2R0dDFIWjA1?=
 =?utf-8?B?NGYwTmpmODYzZURsTDcyNEtrL1dhZWNsQ1JiWlhRRXQ5SitobHlkUGZ3dkJw?=
 =?utf-8?B?UmVYRW5QTGF5b216NTZWVHJaVGdzbm8yLzZ3OVRHME1oUzVyM1dkbjFndWh3?=
 =?utf-8?B?QlBoSktSZlZkQnRWc1ZWWFFYVitTay9iWExDNGFFdFo5aThRZlQzMU9ZMHNL?=
 =?utf-8?B?Q1VBSU9DSkRmK0VBcGtiSmgyUFMzRnk2Mk1HaG5mTFRmMjMvb1dnNzJKcXdk?=
 =?utf-8?B?UXlGNlg0cHBUZUtsSmdpVUR0ckNTSkZZaHgzRHBOY242SXBhakJCYUFCWENP?=
 =?utf-8?B?QUpuQXdqRzFuYXJKd1JJZ0dNQ0JscUc3MVR5Z2tCZTMvZ25MZzFlODdIcU1M?=
 =?utf-8?B?K05BZnAyUVhFclEzSEdQMkpheTBPaWw3dFVhUU5CdEZobnBObUlrU0s0SjEv?=
 =?utf-8?B?TkJPM2FnUm9jdnQ1UjVUaVpaSHpCSFg0aU9YbkpSa0ZXeTJjclZhWExGb3pt?=
 =?utf-8?B?dGZUYXlWWW1EMVdRMDVtMC84OXNhT1hha2YvdFcyb00yTUI2U2t5b2U3c2px?=
 =?utf-8?B?RUpKeDg2ZFdCcHhiZXVobnNLN2lqOTZjNnBUNDl0ejl2RmRQSVdrWEFTZEVu?=
 =?utf-8?B?M1dreTVLelk5cUwyRk10K1I2Yjk2SEJSS3liZGI4cnlxTHlTbGx1aXcwVzBI?=
 =?utf-8?B?VEZBbEZmNk9ZRkRZTWZWb3Jwb1VFNWk1NEpDWmZ5eXdVb3VqZU5Ud2hCSml6?=
 =?utf-8?Q?TSg7aGHsqk8HDTXB3HPMHIHOc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22e2fef-3e1c-4438-402e-08dabcf7e9dc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 17:30:19.3909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SZZorUAxJDxTtheqQNou0vXURoNg28Pn9a8b/6d/KcPO0ydqzZ2mjLf9LNdQ0KCMdNMU1eeu8sUcHZAmkMlwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/22 10:43, Peter Gonda wrote:
> From: Dionna Glaze <dionnaglaze@google.com>
> 
> The PSP can return a "firmware error" code of -1 in circumstances where
> the PSP is not actually called. To make this protocol unambiguous, we
> add a constant naming the return value.
> 
> From: Peter Gonda <pgonda@google.com>
> Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Andy Lutomirsky <luto@kernel.org>
> 
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> 
> I think you can modify the author of this commit to be 'Peter Gonda
> <pgonda@google.com>' then include my Signed-off-by.
> 

Since you have to resend for the proper Signed-off-by: chain, the subject 
line should really be: crypto: ccp - Name -1 ...

and you missed copying the other CCP driver maintainer.

It's always good to do a git log on the file(s) you're updating to get an 
idea of the appropriate prefix to use.

Thanks,
Tom

> 
