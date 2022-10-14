Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B125FEE4F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiJNNBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJNNBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:01:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6071C1149;
        Fri, 14 Oct 2022 06:01:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGq7Z/lNMQarwjhEbyl/TrQ/4f+1DTEmlz8VT6YhsBUWjwWPV8gV49sPxEUG6PNfJ2lprCOttRxqguri6MxdxexN84aECWz9Q72VGL9NkeYeLlZYxB9WQdDGTehvnaIXlad0h6c/17pqOUqkCLtChy+V/+INZzZGTiRVGTeB7ucEvC/Tlgm90gb2wzoG2erQ4EtiHGN2rXQBvnQwC+nRSXckpmyHoAPtaCCNbL6El0P01aXCXxFGATkKFOVHgS327icNi78ZD3SLmgRWCmgEvBirymnDRhjLbYMVFC2pVlIKHtoGqQ78V6whU1bVvvTD+ImRKp58CnlRJvT5xDPcXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUAFtiQ4r1bk4Ly54mF29Y4vlCW6Vm+sW727hMeMvso=;
 b=fRHs9+fT5t4kHZ5BMzoz0LzJ2cM6/OpUHJVP6s5dDIMi3pTiMT7C4QLzeRAoJ7Icd/SAHwrXLwfO0s2ttagCeocjgnmBqvt51TxTTQo/lI85tmNpal9mOzdT6eL+c0CKGIzJzzIRVjeFpXqL19SYe+/ukXH+WtUIcOMRppO6Us7dznaCbVlby3Bi/WZOa2XZ1EC2ynbc/cH+t1X4VZG8rsBxqsZ85n2TzUGToUw5fCGAIe3uUgKrsOxAkX3O/KJQvGwZlclbT/LWEci1mxfFyBoT6l6T2tKA9GavkMiusZrckL0RrcIv31J5+U+GAPdtJywa5wnVdDLaiZk8th21sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUAFtiQ4r1bk4Ly54mF29Y4vlCW6Vm+sW727hMeMvso=;
 b=f1AW0E76wxcKiaQSicNL7bnVdmYFkpFZ8f9Rf6c1siBG68aiEJQzws2nlNvehxNW0E/CBwE0RS2S/hBBxh6SfumdEQOPDyupMPTKJkghshf7nMCjr05ms4aH7s2VdnooE2d8ERJXarbKVEi/TzMH4H4WzXpPSbs5pdh0Gy9lbdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 14 Oct
 2022 13:01:39 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::ea28:b6e6:143c:8649]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::ea28:b6e6:143c:8649%7]) with mapi id 15.20.5676.032; Fri, 14 Oct 2022
 13:01:40 +0000
Message-ID: <a00f3302-0b31-ca56-1de1-4b31d591bec7@amd.com>
Date:   Fri, 14 Oct 2022 08:01:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] Documentation: Start Spanish translation and include
 HOWTO
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, ojeda@kernel.org
References: <20221013184816.354278-1-carlos.bilbao@amd.com>
 <871qrbig60.fsf@meer.lwn.net>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <871qrbig60.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:610:b1::12) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: f10229d2-c4c3-41ed-10a0-08daade43c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRTW58yo2w2iC7altxxa4Sv5bADNI4p5nB6LPPTmfXnD5J3q+PVL0qN8Pfoz6XGOB3NWRt6HNUeaNgssigZHg9tcbp7rnx2BiSDkLTdJrDe+g2/QK2ggEf66W0wm2M/3zHtppn8E8PhVCWkyl3dTjN1FLHu9oO7DLEefZDI4Be3zDqesasUlDZdAuJU6iosnu5qbxA3eGREX+XVeoe9ELHJeLadB2OUc6Tg6HJk9qYg4pE2rZRaT/T7Ie5O0OAArUVOsIAaDM8FtlVqLCJT6CeG3KSJN9Ju/dUitkVBHy/qPlYfJ9iI3wK+7uGZvRzYWmXTREePr8Q8nYf8ZvBHyL0hZsO+RYL7d4NyeUnl5wpq1mbVjHOIaI0Sm4htMGhQze1lrfAW8FDCyj1wfpPA5kNZGMJo6hXPTMRmhmyZiNClPw59hgzCcCQ9m3qfGs8llSVJVOmjLpiWnZtEIRqPAb1z3AewYhmOXlH8UzyBAu5LIsHCw/ChzFqPJmW+7QUofElKTGQ+nPtrpGqNBl5xzupxvs4GKezAaaxCqZhVWxBY0DtZDLVnHPB4k3+kAufl2cH3NBWoDrrDCWftpXTyc1OkH3tQXh8OPEgn6RhzFmHJ4yFYoGgDV273Bi6pcD9Mx6hn2sbVWbSPoLARUtvSByAlUWbn4V0/xR6JlLLJ7VY++8PDJi3vDc9fi9yvl0G7Fx9t5s4ByJxJgWZxcPYBwgBgALlynmFDf2bPenihfXvrTcdplNEQDArOgGCaZ0W1qN9hhiuDQN7EFEGebJkJ8TXsBNelbF1dQuZ6lMK1z03g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199015)(36756003)(2906002)(186003)(2616005)(31686004)(5660300002)(6486002)(83380400001)(316002)(478600001)(86362001)(66946007)(53546011)(6506007)(44832011)(8936002)(31696002)(26005)(38100700002)(8676002)(41300700001)(66476007)(4326008)(66556008)(6512007)(6666004)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkx0U3k5K0xoNVNTRVpodXN1SXZEUjB5SGpIaXd5cmt5MmdDT1hmcng0bGt0?=
 =?utf-8?B?ZmVqQ0pUNFREREFVNTBUOE51ZmFiNGJoLzZQMTUydEJDaUNDajZMVzFUY2tP?=
 =?utf-8?B?MHhoRWZQRHViUzQrVjFZRFBqblVmM3FhWjhsNTRxNnFYdGFaSWhONFdnQ2FB?=
 =?utf-8?B?TEdJZGFUNG5ZV1dTUVVZVVp6UGMybDQ5UnVoZk83S3pORFhubXFkSDh6VVY1?=
 =?utf-8?B?VTVUNUc0T0ZtcWk3ZHN6NFQwWEJ5UGg5NVpGSzNaTExTMzlzNlUvakhZUVFn?=
 =?utf-8?B?Yno1QnYxd2ZVaWhMc3hiMzJod3FmaDBac1NOVmJ4UnBlT1hUUHdHS0cxWHUv?=
 =?utf-8?B?bmlPTk1pNlFMTUdhUVE3cmNhRTlvTDNJMGVibGJYbFpkWXVxRC9DR05HcHkw?=
 =?utf-8?B?Z1NoNERtZWVzUDYwRXZicDdjTGFhcmp2Nmc2YkZkcXBkb0NITkFNUTZjOEJN?=
 =?utf-8?B?SGJwWFJhY3ZYNmFnWElwMy9QV1VsM1ltM0pwdm4vR1NqSHZORVJnUDNaTi9N?=
 =?utf-8?B?NkxIYkNOQmpVa25TS0ZYNVBqblhXNXlhQzBzc0xMa1UxSWJVV0VtSTQxUzVM?=
 =?utf-8?B?QnRUeG5nNmJwYVAvbDVDNUVaY045R0RyWHRMcGMveEhDNm1La1pjUUFvYXJ6?=
 =?utf-8?B?ckZMekh6QzRUbllGMEJzWmZac2lVYWc0dUdTOUJETU5XdXppcjNOaDUzYXcw?=
 =?utf-8?B?bHRTY3hEa2lublBseU9MckcxTUVBblJpQnlSbklKZE5wdUwzMEpqRGNCYmxl?=
 =?utf-8?B?RnhoV01JdjF3NVNpdDN5ZFh6NWVQa0lKZWJ1cmJIekpBZlcrTE93K3pVaWZh?=
 =?utf-8?B?VThKNW9NNkRON1ZqYmhrU0hnMzNHOE1iTkFjSWxwVXlZUFlMVTB4aEhtU2dF?=
 =?utf-8?B?QW1uYmlCZEttNUp6dUhwNVBobTdTMEFndjhwVFVsOERaRlJRVzZ6YzdLeHh3?=
 =?utf-8?B?ZVcwNnFHaUhzRmVjak5jOUdPQlJ0R0hQejV2bUFGZlY0ZzFxalVYNjhQcStG?=
 =?utf-8?B?azBQUHBoZmhwdVY2VEg3Q0hZT2hYU1BpSTVnNmJtOEFCcmpJc2FLNW5ucXFV?=
 =?utf-8?B?emxvYnhHSU9NejhQeDZBZnRMcUNzVy9UYWZINzJveWlSWU5LOUxvNFI0Um1F?=
 =?utf-8?B?dDRNMThjNTZoR0lHSjBxejZzWXR2R0kreHRUNXc1RHVIVW4zUnovNFMrbFoy?=
 =?utf-8?B?YXRUZWxQeW9DdVN3bzJVeWZ5U0wxcS9LcllTSXZzR3BQWFBXSjViSHY5VXF1?=
 =?utf-8?B?cEhIa3huSnh2dko0c2JmMDJhZEtWdW1UQWNPa05JTzVacnBtOU0xZnQycXpR?=
 =?utf-8?B?SFc1YzZnUDNYeEd6TVNyOUwzeDlRWDc1SGFwUFNPYnZ3ajNFdUV1bk53T3Fo?=
 =?utf-8?B?Y1ZET3JKWmZ6WW41SHFab0FWYVZjNTM5WVZVa3FoRUZpdTB1RWtGbGw2ZWp2?=
 =?utf-8?B?STZqakpWRENIaVFTWlRRSW94ZjZ1cm84ZHk3Y1N0TXY3N045c3gvb2k4UWd3?=
 =?utf-8?B?bzIwRHhTQXBXeFZhdTIyb3hJcE9qZXFPQzNRV2NoTEh6WXBhSHhZUTNHQkhU?=
 =?utf-8?B?T1FId0FJQnRMZDQxM2oyWG5teHJ2N1BWdUQrUGM0L0N2dThrT0U2SS9pMmln?=
 =?utf-8?B?dGEvZVI5dDhnaGh5dDZVelFwR09wQ0FJL1QyMzVLU0crZ3pEdExYTzBaendw?=
 =?utf-8?B?ZWE0SnBNLzF6Lzg5Rkt4YnVGM2lzSWIxUWdMa2JqYVFMWS9kZWZzNWFnaUxM?=
 =?utf-8?B?RDFvdXEvcU5nTVR1MjlZQkJPc1JtWGtGRFd6ZnM2Z2ZKa0FXYklaZlNQTDRw?=
 =?utf-8?B?eEdDL0Jzc29DN044Q3VjMCtLWnFjbjliaWtLMG9EOHp0N0E1cGRzZjlvc0tN?=
 =?utf-8?B?elFoaU40YlIrUDVZdG5IbEJ0T01ONGRqQlBNTVozWXFtdFdDVStTeFFrNTlX?=
 =?utf-8?B?NzRPeHlVZTV3QTdRUzI4N01MWTZPTVdhWXJkMUUxbWFxMUxWRytHWVY3cXda?=
 =?utf-8?B?Y1NlcDNkM1VRMVd6TVFubDMvdFBkUHF1SzR1di9WckN6S0E0VWFnWExwL2Uv?=
 =?utf-8?B?bUdncnJGWWZFdjBaWCtYbERJZmdCa2J5R2VMMW0vZDBiWTJtSVlwSkNZUElN?=
 =?utf-8?Q?E8WN+sBM4mfmz0b5MJN74Do/8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10229d2-c4c3-41ed-10a0-08daade43c1d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 13:01:40.0607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdqrTKc0pxfqaksuDIH/5CqUIQbZYqf7AWMXYmKy9pZAKT8GGLqnITnCH0ydZP0pAp75d3exBNmwSj8w9NHZyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 16:09, Jonathan Corbet wrote:

> Carlos Bilbao <carlos.bilbao@amd.com> writes:
>
>> Spanish is the second most spoken language in the world. This patch set
>> starts the process of translating critical kernel documentation into the
>> Spanish language.
>>
>> Carlos Bilbao (2):
>>    Documentation: Start translations to Spanish
>>    Documentation: Add HOWTO Spanish translation into rst based build system
>>
>>   Documentation/translations/index.rst          |   1 +
>>   .../translations/sp_SP/disclaimer-sp.rst      |   6 +
>>   Documentation/translations/sp_SP/howto.rst    | 619 ++++++++++++++++++
>>   Documentation/translations/sp_SP/index.rst    |  80 +++
>>   4 files changed, 706 insertions(+)
>>   create mode 100644 Documentation/translations/sp_SP/disclaimer-sp.rst
>>   create mode 100644 Documentation/translations/sp_SP/howto.rst
>>   create mode 100644 Documentation/translations/sp_SP/index.rst
> I'm happy to see a Spanish translation of the docs, certainly.  I do
> worry, though, that the desire to create translations tends to exceed
> the desire to keep them maintained and current over time. Is it your
> plan to continue to maintain these going forward?  Is anybody else
> planning to help you with this task?
>
> Along those lines, a MAINTAINERS entry for the Spanish translation would
> be a good thing to add.
>
> Thanks,
>
> jon
Absolutely, I’m aware this will require future maintenance, and understand
that is going to mean an effort from my side. I will do it with pleasure. I
just wish I had started earlier.

I’m sending v2 including the pertinent changes in MAINTAINERS. It will also
have minor improvements to make the test robot happy and details found
reviewing the translations again.

I plan to continue translating the rest of files at the pace time permits.

Thanks John,
Carlos
