Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD24637D25
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiKXPk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiKXPkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:40:21 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686D01173FE;
        Thu, 24 Nov 2022 07:40:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDyul59dqmHbnLzgBTEKEBknnJqLuBSsEIPkQS235erVMeRDwOF164GxQkfmk0QYuy5owQlIr4aPf+qZY8fv5iRYMx4/S8rXm9cW7bge08SiWaIjL5gmgvJfylGP3lNI3Z81sjYVerctRHDsClB6vA+dMirfN9klqCmre7dvUZ5QR9XFWlYcTWsDAl5Xcd1iUnuKZO8cdCi4T13BOIvuDo4kX1ypJMjH/dhbM+je1p75GkvQ0H69E06306HyHHsyVRMgiWIce8e0OS22tqIKgmlvcryRV57ZHCT0H+fp/BmT5x9BBf7hSdXnTgQeuToxGyt4rR+k/dJJ8ubq6JkYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIF2Ry+x0r+KQCGDvJ88qgh4x0nS4mhggr7nUPVgXYM=;
 b=CRLkm6WjVRIJyPPZCXxvbdyQxVisfo2bygcej7v/Q+dyqzYPnSPlR73sXoHwQgiSrqJ1EbwhP1opVrWVUAjfIeAHYq7os883t2FR3Zepqm4xJlUxzy8otBe9sbdqpd5s+B1/nxaQKJg7H/wQFtZg6XykZGjTww3Muhxe/E9dyF3+XfpQ0ftvJZ1vZUJ8n5AbD2N8kNxvwRzOC+Pu8L7G29T62M/C5iuXp1JC7fLLkBwhkDvXmGUZsZ1sDzulPOJoWUfd9LTJ/hr6ASaV9riiV3ijbBkesbtIL7o+c7L7iYsymWf8Y9E9xWYClKfyoXBrQN2l1vZOSO1i3+YgXYYQMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIF2Ry+x0r+KQCGDvJ88qgh4x0nS4mhggr7nUPVgXYM=;
 b=3KNSFYcP2VpfHKJpS0nhtv08ks7DRBdyGIpY6uJITDsTZWIeaettdmnZ2BmFbgukLQyUseTdM0h4vJXXKwX/tV4+dFwC7ajXKkBr4BgXGBbObVLmuFqGVgzqvdnDbnC5NwH71dm71FLAkD/bibixCact2d9C22oTQRF60VxlCX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 15:40:18 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2%3]) with mapi id 15.20.5857.017; Thu, 24 Nov 2022
 15:40:18 +0000
Message-ID: <af881ad1-1b40-a22e-08ca-44d75a48b90c@amd.com>
Date:   Thu, 24 Nov 2022 09:40:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] kernel-docs: New maintainer and Spanish translation
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, ojeda@kernel.org, lstoakes@gmail.com
References: <20221118170942.2588412-1-carlos.bilbao@amd.com>
 <87wn7o9g9s.fsf@meer.lwn.net> <093907af-2e4e-d232-1eb0-7331ff2b9320@amd.com>
 <87a64h8wu6.fsf@meer.lwn.net>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87a64h8wu6.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0302.namprd03.prod.outlook.com
 (2603:10b6:610:118::24) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b05b533-a0b6-456b-f7d4-08dace323030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHd7mgTVKlq00SzGEI/cBS6B7xeoZjIZPX4SLUGGy18uUmQyLyBB6O8Wd0gmplPeYSN+QimMbHQrSS49PGWepWThbl62Nh7L5huh+o2h7RMG6JYHrsy8JCSwOm2YaJ37ITwH6x2wUux4ygH8YzVQCjIrPWcEElOeUy0PuOqtlK5uF7WY8G1yM35olbrtG+j6+TPRcecnNPi/ehZ9Ch8GlOcu839OHOHpeV2ivY/M0l31ZQe+BNuJFhqmJhIDFcQCbFCEoY+XWWUqfeD79ZRxCHBGGcSAXLBve7T4WJjcC6P60R2As2CyskYpYH72CLO9ZLJpHg+El5Bd7BLUJhFv51VW0jkehK1tZA5uCy+LZZWvFZrcwKhj9txT8FGo+rFEzGUdlZ8fwWPoiqYFN08zLAYvHJx5izbyeUphflj2XFTp/blbUt9UYX62aeX7PRC/DsO0ecX03AcD2x6PyG6AZhFTMyJjnQxljWZGi2em013onD0ShamKGgKaZV3ypyuZNbyXMP1WFxSDl96f5vORygQGcafB2eL8Hr6Qh0el8YlhTEkPzvEBq9UhAsKQXCtdpLoip/+DR/5SI9zuU9nt+kJFBO0qwY8KAJkrNio2W2ZjRMADbDXsWmxTcizAhG7BJhY892eG4MFI5gVzMZM3qflTlBD1heMwkq7W6+weDXEbe1KHrM4swSjVoYmIodHTUpDAFTUH++zN3BX9XKmeSlUjN5i08GLq+UQwJCToF1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199015)(31696002)(86362001)(66946007)(38100700002)(66556008)(4326008)(41300700001)(8676002)(66476007)(316002)(2906002)(44832011)(5660300002)(8936002)(4744005)(6486002)(478600001)(2616005)(186003)(6666004)(6506007)(53546011)(6512007)(26005)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTFOeEVvZzlHMWxQVVFCUkROdXV3OTI5SnNGUTBRcFdxRU1SdHcxQkF1SCtL?=
 =?utf-8?B?NUhGRWdweUZ1QnFZUzZXQ09pUE9ocVEyKzkzL1N1NWU5VFU5Y2YrSUU0VGQ1?=
 =?utf-8?B?N3NLOVMrNkdHOGlJcEt2ZEwwdGlvTk04M1BPSU5ieWxQVVJRVTV3Rit3R2V1?=
 =?utf-8?B?VzFOSk03RHV0ZDhGeXVGOEZNYXo4dU1GT0VpamwzMUFRL0hRODZJUk1JdkZs?=
 =?utf-8?B?ZnRUU05TZC9rV0pXVlljaVZyYkUzL1VKU21TMGlkRFhBeDJtZFkrWVJMcWVD?=
 =?utf-8?B?dGQ4Y3dHaGtkVGk3TVBBOW9wVkNBaFFQYXZGQVY2eGpXek9hclo5YW9wODFY?=
 =?utf-8?B?QXVqd0NmdEc4M0Ryc1lqdGl6NG9YV0U0bUhKTkZlaVZvcUkwQnZwYjh1V1dP?=
 =?utf-8?B?andYbmxZR3ZndG9zcXh1Q2N4Q2VUc2tXLzlVdHFEZ3VYR1hzNHJVL2FPWERz?=
 =?utf-8?B?S3lRb0Rpb2JPOW5OSDNDWEwyUGlGcmJJK0ZPbnhMTWduc2dPeVpkUU9IajNR?=
 =?utf-8?B?U0J4ZmVjQ0RlZFM5cURtS0l4eVNUUkI5dkVQZCt2UDUxVDNtWkhmVHVYSFpZ?=
 =?utf-8?B?eDJnYmtjMytqZWRhdDlOZlZzMncvMG1XZlY2QyswUldQdW1GRjNYRXlKRzY4?=
 =?utf-8?B?SXhHRVQvTFNlVnNKM1Byc1ZhWUdTR1U1ZThsRjc2S0thQ25hT0g2aDV2cGpy?=
 =?utf-8?B?ZU5vYzNjQis2T3B6Y20vYmNodlhBRTBYalBmc3ltYnI5QlM5RFdEZmFHTTZR?=
 =?utf-8?B?a081VENXL3FwRCswZVRaOE5RNW9RTE9HTzk0b0JFMzg3QmdQbHk3c3Y3SWlP?=
 =?utf-8?B?K3JVdWFsTXBJRk9iVVB0THA0VzZKb2NmY2llZDRtcmZLQTRucmlRM2p2dVdZ?=
 =?utf-8?B?MnNrZnQ4WmUwam5qR3JtVzBFUnpERzZwZDlJOXhmbTFvMXNJZGwrZzlJb2o1?=
 =?utf-8?B?RDhFQTZYOVJPWGVhdm5xSXpIc09KNEZVMFVyU0VjaHBmUXE5Y2VTRklEOWtv?=
 =?utf-8?B?U2hmSzY3OTNFS0NZWGFoaUVEZlBHTnJNSVdPUElPakxNMDN0WmQyKzQ3eGlD?=
 =?utf-8?B?YkNEWHlNU2Q0dDlMQzhlc01KTVlMek5RMFJYSG1PTVF3NENBczJPcjYyZEsy?=
 =?utf-8?B?QTNCVmlOcHAwU3N0WFVOd3VJcEZtZExDT3Vrd0t1MnB4MTJady9CbFY4OFRi?=
 =?utf-8?B?UHE4N2ZWcTl6WXJrTC9ONjBmMktzUDNWY2UwNUlGdXVTNUovTDFrQ2JScmpj?=
 =?utf-8?B?N0Y2VndtM1MrakUyVWh3dTdnNnRJbDJxaksrcW5PVXBYRmhHRlRWMTc5TU02?=
 =?utf-8?B?TFNVdTJRdjhBYmZJUk9rR0hrV2tvcHhoZGV6bnB0dlFsTHhxck1hd0FOZzVV?=
 =?utf-8?B?VW1yZGgzSHNoYzZ2bEcyTlY0QUpFbVBoVTB3NGJEZ2lzL3pQQUdnK1JiUWIw?=
 =?utf-8?B?b2JtblpzRDdGQ3Q2WlBQK0pGM0pyejV5Rkx1L2J1TXc2dmtlMzRxS2RGbFIw?=
 =?utf-8?B?MUw2N0RyblVxaytuQTdTaVhSeUVXLzNadGpobTZIR0hvd21IbEErcE8wR1Jj?=
 =?utf-8?B?K2t2emtjVFduUHFsVHU5UTBzbmFGRXZxZkVRS0FhQTVSSGhFU1BTdndzN0RT?=
 =?utf-8?B?OHlIdGNDZW1VTVpFREFIYWZVaVNRSHZIOGR2aGNBL2ZpbVVFU2hkSUl5Tk5y?=
 =?utf-8?B?YUI1WGREaURuNHRGY0lNWDhOTlpYTGZncUovSm9YdTFwWVNEYzdwaXZRbndr?=
 =?utf-8?B?WWVEckNnMXl2TjRmVmYrdW1YVUR1WU5KRUs3TEpkS1BrdExNNzdSUk01ZWoz?=
 =?utf-8?B?VlJkaG1ybmx0YkZFb0FsWTJhcGxoMGZCOHBoTGZEVFdqbTI5czlaMCttejhK?=
 =?utf-8?B?QUVtcnNRNUI5Q0NaNkJObE1BS0hlMndIM0FIQkRRbkQ3TWNKMzhjR3RQQTdV?=
 =?utf-8?B?UGgydnEyZzV2aFRWMUdBQUh6aTUvRE1oeVZzVlJsSUEvc2c0NHlKTVdHcnlz?=
 =?utf-8?B?NW9SMVBOdDVmdm1FRW53SWtZNjRHWVNkY0pFWU1mTnhhVzZmcnJxVlRQNjNP?=
 =?utf-8?B?ZXR3R1RiVENQbkVmLzZUWVhKUUFiMlhNZzcvM2FCdHlPTGQ4dkpwdzBqeExn?=
 =?utf-8?Q?VsoVRUUavkg49DZ22uCtvTFj7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b05b533-a0b6-456b-f7d4-08dace323030
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 15:40:18.1048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xw9r5FZaLBcIRHMGLNk3tVTb0gU0DVcZRPthyTrL8+qTal82k7uly9FMqat9/Z5TLA4jDrfBNLzIWQbTlcjmMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 10:22, Jonathan Corbet wrote:

> Carlos Bilbao <carlos.bilbao@amd.com> writes:
>
>> I don't know if that would have any success. Worst-case scenario, we end up
>> with an equally outdated list of resources in a few years. But maybe it's
>> worth a try?
> I'm certainly not opposed to trying! :)


I'm starting a new patch set with this, and translating coding-style.rst,
after fixing the organization of sp_SP/.


>
> Thanks,
>
> jon


Thanks,

Carlos

