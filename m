Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E794E6D76A4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbjDEIRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237124AbjDEIRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:17:08 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63979E4D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:17:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJGigL0sEvj36LK9PSS6PHeud36vSfDr67Dp8UbWcPVgHGoQdFXUavHs+6QEujNicLOLzKq42cMdFlsbYlHDbOECEKoLQZQWMSXek27khIRXwxcuiwWaul0IRru7x7vzPKXzIN3Yolbej+u1DyS8FHXQ14AFHq/3TE4DEyWdxGS4qMb34OR5mRWIAiRAryBBcRpsJ6yI0uctYY76u78+7s/O/q7NMwRno+X5RivtQdCiu3pwzqzdCGF+6Zm4Fld9aUDoDq06nLoPYsgqucu7Ymt0reOvm+/dK1jw2p9c6X0SjHIbhCYmNXbkFjh6yBwQs/131FqfQTs0oaMpl0dEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsF1vhsn5QBx3lzTJjx0kxfYnjLq2qLynAVw7pGC/vk=;
 b=VfBwYLDeygjBEISHFe06ZAUDYeWK4WZai5teYK5j60JbBneNZv7zn4o0JYrEgyr/Xwm4pqqmQJ3qklK3j0bUh2OSovbxOYtK/06rI23nGrfQDKqNKa47g7LyMLdGuyHjhaYzWrflqhDVHwmIgpbnAPQcjqi2lfeqUfKj6QaMPntzXlNxp7RkSBbikC4yuJIKL0sArt4mxZScGrZBjinmUut3OQg4OlXzXUascje/44ZDkQ+jDMqTlxB81swlBP5gbD0YQ9DTCYJCk0mP9+8DAzr9fgriylSWxLBJMp2ZD8M1JaPE0JlleSBXpriYQ4RnFgheqXr7LlZ/j7+tMOtJ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsF1vhsn5QBx3lzTJjx0kxfYnjLq2qLynAVw7pGC/vk=;
 b=j1vcf6bmzW7BkfU/kFw6pH7ODKdmXLvErJi+HDc501L35M7SNhCEc0VJKYE8pgXS/nCaYzMi4Bom9SkSobZn+mbJvMMXOKi+QpuX8owSGAAGcc6QXEEnf5MduRo1yt5z4Npt90UHZVpuf5Lm6xfClejk0Jkitwx5S+MdOkrJJV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Wed, 5 Apr 2023 08:17:04 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::de58:ace6:16ba:96eb]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::de58:ace6:16ba:96eb%3]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 08:17:04 +0000
Message-ID: <7f07f8ea-cc26-7655-00de-4ab21bc4b0e7@amd.com>
Date:   Wed, 5 Apr 2023 13:46:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: nikunj@amd.com
Subject: Re: [PATCH v2 09/11] x86/kvmclock: Use Secure TSC as clock if
 available
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com, michael.roth@amd.com,
        ketanch@iitk.ac.in
References: <20230326144701.3039598-1-nikunj@amd.com>
 <20230326144701.3039598-10-nikunj@amd.com>
 <b288afd7-b596-24b5-a00b-358bbe609085@amd.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <b288afd7-b596-24b5-a00b-358bbe609085@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0197.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::6) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|DM6PR12MB4515:EE_
X-MS-Office365-Filtering-Correlation-Id: 79529779-6a30-4072-c21f-08db35ae22ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8PyAfSwMvqi0uXOTUrnuZzNJ4jwPOAXmHU+SR9cuFi0H8jlN66tg2+6v+lsr3ssmlQYliVZERIYShZpCJziR17pApL7ji7vGK7JLumn8/XTZVoGF0Tf5pmSn2Gfla5L/RUAcvJrmtBDUtdxxlOY/uIq22I0huRMShx569iHDzxAsbiypLQW7IPEk+nPl9CEMYsj9+GkQ6QgzLuwSo4L/Gp2eu696i8jm/oOFKvk8y6dpw54tPLoumOR8YqQVg0nGG7iBAph/i1/pqyNGJm4TCDZYG/LhJGu2yhA3l3AbKBu/qhWqE5mp2zikncP3i79s1H6YLxMn1Ev7JUcNDqtlLS3H7sq/pS0/A0/WTv4OQlGqCAZ9+JumygYOXmPFtKy712vun5Ab1uBpzOeq08j0tmPJT25CSX+DyyopNFKuHl5p2f/SyCk3WI20xJ5mgFUag0JP39Nz/iGgCFoek4w6Rmi4b02bLXan0ggTg1zalfmUepbCuwfiVQjlPZZcCkkMzZGWqWETETKzYqwEn0GmgQM8rxC/0va5etqU1EnHD0LnrN59Pu+Nd6Fi//m/KEsZjojN8Jb7CitvC6oj3/xu/kcbIQwcqLoAlKwRRuEhFLX0/msCrk9ZB1lvxMiRBkink9OUbK5xo9Dxl8occsYLuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(6486002)(5660300002)(478600001)(38100700002)(36756003)(4326008)(66476007)(66556008)(8676002)(31696002)(66946007)(316002)(41300700001)(8936002)(4744005)(2616005)(186003)(3450700001)(31686004)(6512007)(6506007)(53546011)(26005)(6666004)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckVUV3JHUkpYNEJuQ1VVWVRwQ0lOOGtNTTRqQTZHb25JYjMwM2NVbU15OWZk?=
 =?utf-8?B?TlhjdEY4dG12eHZRaFZvZGhEc05JNHBQUkJuSjZPRjhDeE90WHdtdCtSSkt4?=
 =?utf-8?B?dmZ6cnpPZWs3MFMrSWdrMVpFTHJvSlI1cmlxMFZWSlhBMVh1U3hDV251dHVo?=
 =?utf-8?B?TXNWc2V1MUJSRHhkWDExVlBvWHF4Q1h2QVZPR0RhUHhNOXBSU1p4bzZTeFk5?=
 =?utf-8?B?aVI2M25mUHd5cGkxbGkvZ0pOdmcxQ2JNaGloeCtYa0U5dWtVd3BnL1VBRUgy?=
 =?utf-8?B?NUVyc1loMHVIejdDbVpncVdzeTlCV2hyMFp1Yk95UmtDWENsK3dPeFBkRENi?=
 =?utf-8?B?V2VTMldhZXlNMFNlNFFpZEU3VFFXR1ArVGdqTm1NK283aWxleTRPUi9PR2p3?=
 =?utf-8?B?d0pRZVVGTmEzVk9reDlrWVBOUHNhUWVFK3JkYjJpeDA4cVhZVmZmWUFmcFdj?=
 =?utf-8?B?MlB3TEZUWG9LYXJyNGZTdUt6R0JTdStrcGZmdUhFTXBqMEY0Skl1djZJbFFW?=
 =?utf-8?B?VFpDRUtTOUwvSkRTZTM1RHlpbXBGaFRlOUNFQVZkbE1wdEZCaHF6SXU0blFi?=
 =?utf-8?B?QkxVMDJJSThjZUpOVkVjRzVUQ0pocHRvMkNoei9zQWdZM1FqSG9HM2NzS1ND?=
 =?utf-8?B?d2tDYjFzWTIvWXkxWkhNcGxDVExpcThvVEpuL2x0aFd4cW9VamZOU3ZpT3Fh?=
 =?utf-8?B?YnIwSUlkb1QxK3JBVnZqNXN5dDVZQURqLzhVaDFuVDA0cW1sWlc5Tm5JUHh4?=
 =?utf-8?B?aVZvaUQxWFNiR3pSbWlPZmF6WUhVMUhHNXJvWGtIeDAzaElQZmEyejlqVk5z?=
 =?utf-8?B?MVNocG4xOGx4OWNPUk9IbXdIZ24xNHdJcDhjd0xIUGZaemFoQ2UwbkQ5NnF5?=
 =?utf-8?B?MVZDSDI0WkNVYWJxbjIycWMrMDZDTCt2ZEhhOTdlbmFmZG9VNERwZHdNT3Ba?=
 =?utf-8?B?aG9tZ29rTEUrNEd2M3FMdlp4ZG53ZzhjOU9KZTBnZnV4WUZMbVRVcmRtODR6?=
 =?utf-8?B?NHpPbjJ3bEQxdjloa0VxWlJKU3BxYlFxd2U0cTNIUFl0YmtWbUdGQWJEcVAz?=
 =?utf-8?B?RHBsY0R6MnFiSU9nWFZDdkE5d3EzcUp0L0V4SHc2a2dsdWJsRWlzWUgxd1h5?=
 =?utf-8?B?YitmcWIxckp1U2RJNjhVNTNDUHpWRUdVNndQQ1ZGSTUyb1lZUzBSSUFvNVJ3?=
 =?utf-8?B?dXNlTUxhakluT3VTSDcwY1RqNmJzbThWMUljdkJIU3U2M0pzYjR2L0NyR3ZM?=
 =?utf-8?B?Y3pxY0M5eWpXc1BKMVN6d3I1eWNZNlgwdXFGYklZekJsWEJKbkE2djlaS3Ar?=
 =?utf-8?B?RDVSM0FCTFMvR2EyNTVkdVRMamtsM21BR3hnWUYrcmF1dHFCUEZjdU9vZG9H?=
 =?utf-8?B?YnNiTHQvdktRdW5WaWRsYlNnalRiYTFOSHNodmk4UmN2N056V05wNndQL2pV?=
 =?utf-8?B?Q3N2RG9FeWFuRGdzNkF6MlNDa0htSmxqWkhEZW1JaFZLVXZsem16VWZHekdB?=
 =?utf-8?B?dFUyQkZFSCtLeHlSZml3Z0N0TzRCdnNHTmpCZTRVQlBxUWFQTFhzVmtIb0p2?=
 =?utf-8?B?THJEZGQxM05TZ2RnR2owWVFZYk50MUlWaEJyVVBVRVhBeFpUUUF3YTE0OWhJ?=
 =?utf-8?B?NjBpQks3bTUvSUdZZnV5VjdyWm9uU1RMOFRSdEd4OE01Y3VEUHdyS0tzcStk?=
 =?utf-8?B?LzIxVzVlcUlEbDVhVy95dlpjSVRoMHFWYk9EbExvNm8vRkpmVG82MnAzenZv?=
 =?utf-8?B?Wm1YOTB1dW54VjREa0dVZmZ1WjVNcFFrdFNrQ0JnQkZ1bWpDKzlLQ2xtTUFy?=
 =?utf-8?B?OS9QOWlOdzF2cnVVRjdNNk1ZTkltM09ZdE5vTHQ1cnJ5TncrRXlMQUxmMlV5?=
 =?utf-8?B?eUxseEx6RkhnRzU0eWN6UXBHOFJVMy9remtIY1B0dEdRbFFIMmlpZlFVdEJa?=
 =?utf-8?B?UnhZUGhYNWtEdjlXZE1rSlhmU2ljS2pVUTZUR3hua2hrSlhVYWdaN1VFYks4?=
 =?utf-8?B?WnNUMVN3M1Rsc3NDUWVlbnhFVUl6S2xFU0NCdXhuNXIwUEZxMzlsaEtubHRM?=
 =?utf-8?B?VXVaMHEvVVNycDYzNHExNVZSVGdzYUh5d0tBNzM0b1RrQTZTRnNXeWVCeG1q?=
 =?utf-8?Q?glF3x9w3ZdAs1DV3zQF7UVFtH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79529779-6a30-4072-c21f-08db35ae22ff
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 08:17:03.5617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqaCfxhUNfRzqrfwNSUOgXQA0W1MothjRnz6RlVtyfgQv9mP1fneMnUFX0WRhpXZ8jz8c9VOFn5wy+FEwX2Vhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/2023 3:15 AM, Tom Lendacky wrote:
> On 3/26/23 09:46, Nikunj A Dadhania wrote:
>> For AMD SNP guests having Secure TSC enabled, use Secure TSC based
>> clocksource instead of kvmclock.
> 
> This patch only results in skipping the initialization of KVM clock, it doesn't cause Secure TSC to be used as the clocksource.
> 

Will update the commit message and reorder with 10/11. After making TSC reliable and skipping kvmclock, secure tsc is used as clocksource.

Regards
Nikunj

