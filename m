Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BFA6A4605
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjB0PZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjB0PZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:25:24 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C9E22DF8;
        Mon, 27 Feb 2023 07:25:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJGtJOLnMTvmKElNDNar+Dh85lhsfoNNB3Yvw70eHtdeGeehz8+QiEFPx6VvcPjWgnNly6NTkAVKkcHqxZsjeGLBLSUbus6TmZh9OX8iVbP5ZEct16dZViHqkg2N0oFR2775GMh1e8ug4oMnBj3/EJ0B6/zFLI7TSrZjcCjWf8p52AF7Y22I+ChDrl5/PW/b9JsS5rXELv+KHOLcjA7KYGsVnE7N+PHxhFoBhrmuPFAjMHM1GRZjEhCmSEnI7DPIJths+vs6a0ItZ9oHqRt+JbslKNwOQEzXnA/gO/rjq0OPvVi3RNMWq6AMWa/xrvTK+5PC6m/TH8xt7PazZEfc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Qo+/Q9PQ39vMpjNLIFc3W0pSdC5uKgfWhdHA1Wto7w=;
 b=kjcMM/FAz2Eot7u8/WWtGJIfxo+WGvnzyOfYCyfcldEhOrLnhJi8Lknf0y5xAsxrw6nRQhEexL1iGM9WX29iov8l9A70k2C1AgX2VC6jKcOsFagI9/njcLGJXvZzoQZSaLkI6KPSnyCccvXYn67JLbciU++qLX6Ukuc+I5XJIqkj6L4A9toNd3fR+yavJG61bdmFtyoRn4De+K+qL107xeQefcvoIR0m1O7+0WSEFmHlcwARWvFpx5TO+qQO/WK8idi2q9MoeyR8mx93pmNUtRoP28Tp2cDDM3bm/ZvGRwosOs6seKrl7tHmbp3IbZTJZWpO6y8sPSKdB+cNaJsQIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Qo+/Q9PQ39vMpjNLIFc3W0pSdC5uKgfWhdHA1Wto7w=;
 b=jzgmzCsHRKHgFUmVRMJqBbEQiDMp2A2XuzYh4wQA9SV1SRF+gJWuygqkAL/BIAqYK3D0zpOWQUYIZWsUbeMRm9ySu7O8BYNnUkDANTZBrrfPTtO2Dvj3y+llbSy00FXnqThQ3z5VNYPcI7u7YKIiuXib4+2/yDnCT2KS9VrsXu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by SN7PR12MB8104.namprd12.prod.outlook.com (2603:10b6:806:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Mon, 27 Feb
 2023 15:25:14 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3ddf:d47:b37a:5a7a]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3ddf:d47:b37a:5a7a%5]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 15:25:14 +0000
Message-ID: <c89715cc-2c45-d921-9837-b0a59469d233@amd.com>
Date:   Mon, 27 Feb 2023 09:25:10 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:110.0)
 Gecko/20100101 Thunderbird/110.0
Subject: Re: [PATCH v3 1/3] drivers: mailbox: zynqmp: handle multiple child
 nodes
To:     Michal Simek <michal.simek@amd.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Cc:     andersson@kernel.org, jaswinder.singh@linaro.org,
        ben.levinsky@amd.com, shubhrajyoti.datta@amd.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20230213211825.3507034-1-tanmay.shah@amd.com>
 <20230213211825.3507034-2-tanmay.shah@amd.com> <20230222173448.GA909075@p14s>
 <b11cd9f2-3759-1df2-ea00-50c574668c28@amd.com>
 <130e75d3-034e-67a2-0c27-0599a996b20f@amd.com>
 <e2ef52ba-7633-3958-4b40-e047a7bba820@amd.com>
Content-Language: en-US
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <e2ef52ba-7633-3958-4b40-e047a7bba820@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::31) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|SN7PR12MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: 3273275c-c1cd-4c50-e3aa-08db18d6d2ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tX17OcA70ENt/IWA1AKcqU7J6IFj9IK5yVDKDoxp1iahZpVQTjHfCCW+xtUXrsgrw9QAjUPxUy3cS4zZ4J4p33A7P9ipK7ppNxoleEq7kbtOlLO1j+bUBgp9Dii+Ca/S/iDHCzkr5RZ8BOyQOB/22+Xnv8lQMnkG6jPnXM1JlhT4hRbry1eDFYiVQNinWVy4FeygBY4rHihH0YMAARyf4IVOSWcDhs3VRvWs9/CjeOX4999o/2YcnPF+Tk3k7WbQ9YAhBX99akEK18M2rQiizuJsDmxkNAFh+UC2FrIVxXahpbAOvzyFyRFtnMN0yCErL9V8gztweylCPYoRt1cZRpghkpbUrBPOuYiACZr1CRx+/E7O2nfpfrPK9VTwMYBQ1TDc0B0wWNCZ6sSYpkCOdAMcdCHmu65EsrZ0GYFxtVP1my3HQBMtNLmQnnqzAM8BXulD4jKHVaKTJ8BadDPw8bhJfKV/ISVhYh8SCEpPyqElPSQufWoAOBWe4PyHU1pW9SuqxdmP8zvZLezXndqfPbbq9rcvMmGkgfNd5XxTqYEwgWaXziJElX0u2jpOxg+u2BojyUFcL0uoIb32oLCp1mnoQobLfbS0FlfM2xNreQvqgQv/TpsUitnV1TkF7ViLjrgw5vijYhRn448dmWTeFa3YPa0GKeJBwDohEwufWhhsYxL/O/ZhtI+Ra7VrNWcGwz8Er+Bp/4S51WLKet9h5XPTt9F/5AyQSNdWT0wXsQu/Ra8hf8lbNa10V+nKe1ulXvQceWZsMEnLO3J66W3ueg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199018)(36756003)(31696002)(966005)(478600001)(41300700001)(66556008)(4326008)(8936002)(2616005)(66476007)(110136005)(66946007)(8676002)(6636002)(316002)(5660300002)(2906002)(15650500001)(186003)(83380400001)(6486002)(6666004)(38100700002)(6512007)(6506007)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUJRSkt4eVhmeXF5b1BzNVExMTdldHIrTnBnTUxQdE45K2EyaFIyU2Q1cjA4?=
 =?utf-8?B?UHVtMFV3cXlDT2FNcWw5Y1pyQU9LYjY2ZFNyWXJxNDhNSC9TU0lPSkRLa0Fh?=
 =?utf-8?B?YytJWkVTVEZnZEJEVTBjVEs2cUxLS3BYUWxpU0tzbjJDa2ZKeTNWU1Fvd2Z2?=
 =?utf-8?B?NlpYNFAyT2o2QkpnWk11NFFCa0RhbUJpK1ZHRXBEaXcwVW5HRlBzeXFyMEpl?=
 =?utf-8?B?UGxCWXYxaVZ6Wmd6Tk0yQ2wvU05wMzNMamcyK09peldaWHdtSHpjdmExeldE?=
 =?utf-8?B?VjB0TGlEU3YxM3loOXlsbHRMSlI2blI5U2Qza3hTeHlUMHdFb01yYkdyY3Bh?=
 =?utf-8?B?UUhtWk5PZE5NOC9XblY4NmduVUtNMDQwb0o5RG51cW1XQU1MVFJ1ak1XSkFz?=
 =?utf-8?B?Y1JoeGt0aWozcGxMd252K2V2QkV6Tk9ydHZHdFNOYWhBY0RUV2h2RTJBaGhF?=
 =?utf-8?B?TUdSeEVBU014ZzdMM0hHaXc5Qlo2ZlhWazRhYjJEWmx2UGQvb1Jka0U0K0kr?=
 =?utf-8?B?RjB2RGtCa1h2TVF6cFFzS2FSWnVSQXdYZjFDVDM1RWFjUU53MDdzUTVWWGFy?=
 =?utf-8?B?VHMrb05mWjNxVHczNm5sZllyT0gzQm4xUXArVWVORVZaWSt5NGF0bUtXc29h?=
 =?utf-8?B?Q1pXRUNsR1BxUFEyMXBsalZrWlJCbXNZbjAzcjgxM21IZytxQU1EQjdmbHdz?=
 =?utf-8?B?dzduZzA4VHRYZk9XN0sySVJHeHY0MlQzSDlBZlZYNnVTUTJPTXVWK0paQnhQ?=
 =?utf-8?B?WFdMRU5XWE1VblVaMXJjdVEzTlVZWGFYblY1MXk4WVo4YUFtTndIK0p4dTF5?=
 =?utf-8?B?a29nVFI2VXp5emMwbk1Zc0VwY0FGMmNCV2NSK21zZEpKM0hVKzhFVWRIUzBU?=
 =?utf-8?B?UjNpTnF0ZHhncFVyYW1meUp4ajhOT3F4a1BCNVZkZmhtbE1mRXRnejI2YUJp?=
 =?utf-8?B?eGRsU0oxOUNpRW4vSVNkWFA2L0oyQ1dKWlJPV0N5QllLVnA1REhyMjQzSU9X?=
 =?utf-8?B?cTFYa2g0bjlCRGZLbU1EWVRORm4wem0rQmRxOU14djZBb1JRU24reWYvMVZZ?=
 =?utf-8?B?cGw3VzJJek1lMnpqRWtrVERDVFBvOWVXSHZESXlDd3BiMkVnb1RQK3NaWlVD?=
 =?utf-8?B?SkZpYUJhckl4NTJXU3VVbWdMZXEwR0h0M1g4cnFOUEJYVDMrNnhFRGlHOUs1?=
 =?utf-8?B?TDRHZ0oyUzVSQzBTVDJkQWxiMlpCSE1lSUxGQTU4eXFVMk9Vc2d1R21iTjY5?=
 =?utf-8?B?Mmp2dHBOQ0Z1L1dVK1BqWExUaE5DejAwZ0g5V0FITmZPSmpZNE9uOFAxUjhv?=
 =?utf-8?B?RFlRRC9TemFsVjA5Ti9XRHFOOEE3NXluSGVRazRFMzNtdGxra3FwY0EzUEdU?=
 =?utf-8?B?SW1KT1JWV1JxclhqU3YwcmtoY3YvV1F4MDVSdmZncDVOYXlWQlF4K0ZrUnZX?=
 =?utf-8?B?M2Q2V0NNaGpzYlc2enVWSGN6cDdSeUpaTm5BMC8xV09nVUl1LzFaN09Od3Vl?=
 =?utf-8?B?aTdRNmNoM2wzakNUbWZqc25XcmFLYkQ3QVNKaXpUWjAvNlJkQ2xNK3RPcDhJ?=
 =?utf-8?B?eTM4TXJtYUlna3RTTmlKV25INTV0ZmR6ZjZqUG9BakgzbUxEaXFGSEV4ZzBl?=
 =?utf-8?B?RXBVQ2MwRjhobWY0KytqL3Z0MlgwRGNHR3dkTlo0dWE1Y2VVQzMwd0V0Ukdo?=
 =?utf-8?B?RVdjWG1RODVOR1pHUHVWV2pDRDBLekN4QXkrK3FFVjN0bDg5dUdyT2FoMjUr?=
 =?utf-8?B?bVdxNm15ZjE1Zkd2RG9Rak56VmhYNlBlcGhraFFFcXU1QjZDQXUxTnh4TzE1?=
 =?utf-8?B?YUlGVmRwWGFZV3JtbU1zTWJSQmYrR0Z5d3p6QWJBUXhoRGpOWkdYSFcva1pi?=
 =?utf-8?B?bm95bks2ODRwUVQzdUZhRnhGNmhDRmtWclpMZGFmOWVZNkxyV0Z5a3E2VXVm?=
 =?utf-8?B?am43UHU1ZDU0dGU0WCtqUmtPMTVnWEZ1VUhzMS9vTm5zOVljaC9lN2tBb2lh?=
 =?utf-8?B?eFZMUkZULzFMZzNYY0k4eU83c0FHSUo0emg4RnpBbW9zNlVlVnVESWNOZ0Iy?=
 =?utf-8?B?bXM5Y1c3VkxUZHNuTURHcUNYaVlMRkczb0E5Ym9rOE1KeU9pNkNVNFFkNVFJ?=
 =?utf-8?B?WlFkbXpsb1NEait5RzM0aE11ZlhLVXlCNWcyWlpmeEE0Mlc5QXFlZnlzaXgx?=
 =?utf-8?Q?MzayfXw1Fszu3Xc3/hUUoFS6HoAosyHiqz0C36NLq0UJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3273275c-c1cd-4c50-e3aa-08db18d6d2ae
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 15:25:14.1833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y66m+102Hrs/GIlv8A9rzga71lr+B3ouknWqcF/Yt6+1NF62PX5xbUmsyPvRxFPZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8104
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Michal for this calculation.

I will send separate patch after some more analysis to accommodate this 
implementation of accessing message buffers from ipi-id.

However, for this series this isn't required. For this series, I will 
just split this patch into three different patches. I hope it's okay.

Thanks,

Tanmay

On 2/24/23 2:37 AM, Michal Simek wrote:
>
>
> On 2/23/23 15:47, Tanmay Shah wrote:
>>
>> On 2/23/23 1:40 AM, Michal Simek wrote:
>>>
>>>
>>> On 2/22/23 18:34, Mathieu Poirier wrote:
>>>> On Mon, Feb 13, 2023 at 01:18:24PM -0800, Tanmay Shah wrote:
>>>>> As of now only one child node is handled by zynqmp-ipi
>>>>> mailbox driver. Upon introducing remoteproc r5 core mailbox
>>>>> nodes, found few enhancements in Xilinx zynqmp mailbox driver
>>>>> as following:
>>>>>
>>>>> - fix mailbox child node counts
>>>>>    If child mailbox node status is disabled it causes
>>>>>    crash in interrupt handler. Fix this by assigning
>>>>>    only available child node during driver probe.
>>>>>
>>>>> - fix typo in IPI documentation %s/12/32/
>>>>>    Xilinx IPI message buffers allows 32-byte data transfer.
>>>>>    Fix documentation that says 12 bytes
>>>>>
>>>>> - fix bug in zynqmp-ipi isr handling
>>>>>    Multiple IPI channels are mapped to same interrupt handler.
>>>>>    Current isr implementation handles only one channel per isr.
>>>>>    Fix this behavior by checking isr status bit of all child
>>>>>    mailbox nodes.
>>>>>
>>>>> Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
>>>>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>>>>> ---
>>>>>
>>>>> Changelog:
>>>>>    - This is first version of this change, however posting as part 
>>>>> of the series
>>>>>      that has version v3.
>>>>>
>>>>> v2: 
>>>>> https://lore.kernel.org/all/20230126213154.1707300-1-tanmay.shah@amd.com/
>>>>>
>>>>>   drivers/mailbox/zynqmp-ipi-mailbox.c       | 8 ++++----
>>>>>   include/linux/mailbox/zynqmp-ipi-message.h | 2 +-
>>>>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c 
>>>>> b/drivers/mailbox/zynqmp-ipi-mailbox.c
>>>>> index 12e004ff1a14..b1498f6f06e1 100644
>>>>> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
>>>>> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
>>>>> @@ -152,7 +152,7 @@ static irqreturn_t zynqmp_ipi_interrupt(int 
>>>>> irq, void *data)
>>>>>       struct zynqmp_ipi_message *msg;
>>>>>       u64 arg0, arg3;
>>>>>       struct arm_smccc_res res;
>>>>> -    int ret, i;
>>>>> +    int ret, i, status = IRQ_NONE;
>>>>>         (void)irq;
>>>>>       arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
>>>>> @@ -170,11 +170,11 @@ static irqreturn_t zynqmp_ipi_interrupt(int 
>>>>> irq, void *data)
>>>>>                   memcpy_fromio(msg->data, mchan->req_buf,
>>>>>                             msg->len);
>>>>>                   mbox_chan_received_data(chan, (void *)msg);
>>>>> -                return IRQ_HANDLED;
>>>>> +                status = IRQ_HANDLED;
>>>>>               }
>>>>>           }
>>>>>       }
>>>>> -    return IRQ_NONE;
>>>>> +    return status;
>>>>>   }
>>>>>     /**
>>>>> @@ -634,7 +634,7 @@ static int zynqmp_ipi_probe(struct 
>>>>> platform_device *pdev)
>>>>>       struct zynqmp_ipi_mbox *mbox;
>>>>>       int num_mboxes, ret = -EINVAL;
>>>>>   -    num_mboxes = of_get_child_count(np);
>>>>> +    num_mboxes = of_get_available_child_count(np);
>>>>>       pdata = devm_kzalloc(dev, sizeof(*pdata) + (num_mboxes * 
>>>>> sizeof(*mbox)),
>>>>>                    GFP_KERNEL);
>>>>>       if (!pdata)
>>>>> diff --git a/include/linux/mailbox/zynqmp-ipi-message.h 
>>>>> b/include/linux/mailbox/zynqmp-ipi-message.h
>>>>> index 35ce84c8ca02..31d8046d945e 100644
>>>>> --- a/include/linux/mailbox/zynqmp-ipi-message.h
>>>>> +++ b/include/linux/mailbox/zynqmp-ipi-message.h
>>>>> @@ -9,7 +9,7 @@
>>>>>    * @data: message payload
>>>>>    *
>>>>>    * This is the structure for data used in mbox_send_message
>>>>> - * the maximum length of data buffer is fixed to 12 bytes.
>>>>> + * the maximum length of data buffer is fixed to 32 bytes.
>>>>>    * Client is supposed to be aware of this.
>>>>
>>>> I agree that this should be split in 3 patches but the fixes are so 
>>>> small that
>>>> it is hardly required.  I'll leave it up to Michal to decide.
>>>
>>> Generic guidance is saying that you should split that patches. I 
>>> personally prefer to have one patch per change. It is useful for 
>>> bisecting and faster for reviewing.
>>> I would expect that this patch should go via mailbox tree and the 
>>> rest via remoteproc tree. That's why maintainer should say what it 
>>> is preferred way.
>>>
>>
>> Thanks Michal for reviews. I will split the patch in three different 
>> patches.
>>
>>
>>> In connection mailbox. I recently had some time to look at this 
>>> driver and I didn't really get why there are registers listed. 
>>> Because all that addresses can be calculated based on soc compatible 
>>> string and by xlnx,ipi-id for both sides.
>>
>>
>> Yes the IPI configuration register addresses are retrieved from TF-A 
>> in zynqmp-ipi-driver using xlnx,ipi-id property.
>>
>> Other than that there are message buffers provided in hardware for 
>> IPI communication. We list those message buffer addresses
>>
>> using reg addresses and they are expected in dts. As per bindings we 
>> do not map message buffers to IPI ID.
>>
>> I am not sure which register listing you are referring to ?
>
> Based on
> https://docs.xilinx.com/r/en-US/am011-versal-acap-trm/Message-Buffer
>
> xlnx,ipi-id = 2 (versal case) APU
> pmu1 has xlnx,ipi-id = 1; PMC
>
> Base on versal is 0xFF3F0000
>
> Local buffers for sending from 2 -> 1
> Buffer 2 starts at offset 0x400
>
> Order in destination is PSM, PMC, IPI0... where you have request 32B 
> and response 32B too.
>
> It means 2->1 - target is PMC
> that means 0x40 for request 0x60 for response.
>
> When this is put together
>
> 0xff3f0000 + 0x400 + 0x40 = ff3f0440 - local request
> 0xff3f0000 + 0x400 + 0x60 = ff3f0460 - local response
>
> For the way back from 1->2
> Buffer one starts at 0x200
> I want to send it to APU which we use channel 2 for.
> Channel 2 start at ID * 0x40 = 0x80 is for request
> 0x80 + 32 = 0xa0 for response
>
> It means 2->1 - target is APU at ID 2
> 0xff3f0000 + 0x200 + 0x80 = ff3f0280 - remote request
> 0xff3f0000 + 0x200 + 0xa0 = ff3f02a0 - remote response
>
> Based on this you see that reg/reg names property are pretty much 
> useless and should be removed from dt binding document because simply 
> base and source ipi-id and destination ipi-id will tell you which 
> addresses should be used.
>
> As far as I know ZynqMP is using the same logic. The only difference 
> is really just different base address for buffers.
>
> That's why I think the DT node should be just like this and all addresses
>
> Versal
>         versal_ipi {
>                 compatible = "xlnx,versal-ipi-mailbox";
>                 interrupt-parent = <&gic>;
>                 interrupts = <0 30 4>;
>                 xlnx,ipi-id = <2>;
>
>                 ipi_mailbox_pmu1: mailbox {
>                         #mbox-cells = <1>;
>                         xlnx,ipi-id = <1>;
>                 };
>         };
>
> Where different compatible string will ensure that base address is 
> assigned based on SOC.
>
> Thanks,
> Michal
