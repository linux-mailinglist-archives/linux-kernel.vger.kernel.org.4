Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFA066CE30
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjAPSBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjAPSAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:00:38 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBA930EB8;
        Mon, 16 Jan 2023 09:43:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPyEMnMBdPvQPHib3Slrkh3OoP61y6bZLB90K6q9CG5YgsdTopx1oUoRXQawQa3B+/Iv4KgdrQKh15lRiUXw5c/Wi8Mj8zJUFi64unSfeIl95K8cK58FORc1gGBO1mTi9IdBzAh0LD5vXsfr7PuzSml3KzJgPe2Xl3xJGB+EAoVHO2T2L5O+HC0q0FZdX0GJGm4/wbLzBV8xHbZ06rFD1kS+rgcsWHsPLjYE/2819ey0Zrpuecm+Qpvgn8Ap6bcah4JFfwxdq663Q8KsfsaBWAdJpIYtL1i7HHvDSr1qCGPfg1/OVpIRAmiAqQqRlEawKKB1nrL/nUswMqgrl9oEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YC5bs14iov5hgZ6/CQmOu7FlKVST0SQcSfzF9rTVjJY=;
 b=iK0lB+2NCbyh1QhZOdtpbNtMIpHdMCHj9jmfTLQIC7hzGqqvsNUnrA6zPbVKn1veZ53r5Iq9hEAM7nqalWk9WD4Kpb2EhUvMKTaVFWEzlTepXhHPYm4AHXzn93oalb24NXaOoqEXnjvSN9IS8BVN2qJg8MssTNiHsuc2dhEOun121WYzTEz7DMNO83I6uS9LmdY/m5vG4AV9ccEWeb+nuSfch0Sk+dGGRxu6ovhhXODufRfFHTzHLVIAa4FgtBGhz5c5xymYP7udeweS3GdR7a7hwNBxoNNRZT6HmnxWN8FP0Il2rnGGvoka/928GWbqFFAOA9Zu98bfiM5iteYxOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YC5bs14iov5hgZ6/CQmOu7FlKVST0SQcSfzF9rTVjJY=;
 b=dR+NWKv0MrHtC7JQurUDsdWX0fBTE/6kNmZzqsZFMzrRNpdXosqsbmjnFnVS7pDdRsg2UccxBWb8Kdo1N4MD8Ul+nFmqzK2OYi0dKWzZet1x3Cw4f/h24pE+wVdqgcsZGYnUIpp4KH9fZW7/eTEfRfGwofkHoAR5BgGmzIRzmUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by DM6PR12MB4531.namprd12.prod.outlook.com (2603:10b6:5:2a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.22; Mon, 16 Jan
 2023 17:43:30 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3ddf:d47:b37a:5a7a]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3ddf:d47:b37a:5a7a%3]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 17:43:30 +0000
Message-ID: <980d9c9c-3dbf-3ebd-28a1-5b3b4b58e93e@amd.com>
Date:   Mon, 16 Jan 2023 09:43:28 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0)
 Gecko/20100101 Thunderbird/109.0
Subject: Re: [PATCH] dt-bindings: sram: Tightly Coupled Memory (TCM) bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tanmay Shah <tanmay.shah@amd.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20230113073045.4008853-1-tanmay.shah@amd.com>
 <6f43e320-b533-e5fb-3886-1b6ccc7f9548@linaro.org>
 <b79f7e0a-8048-d0e1-ad0b-d15d72288fde@amd.com>
 <9f4994de-e468-43ea-f8db-d4a37ebc30e0@linaro.org>
Content-Language: en-US
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <9f4994de-e468-43ea-f8db-d4a37ebc30e0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::15) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|DM6PR12MB4531:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0c9890-ece7-4cdd-461b-08daf7e92e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NzCiqpxWMgmjVmk2xdbMHgnlARPllQuHbuh8kwRxnLewyQyQZUHjSWzV3Lua3+G6h4q9zT8GUKAv83uAN/tUgIrPOdtKprJ/ez0vq/8GY3cNtOQwpuv5TSOAJjVdYr3QAUBCvDegsq6JolaUuaXVYoFOeqHTIOOsotc6SVncjQ+Ln3aBgossnakdu/AupeALb1+rBPD9XcFz2AvHfp9w7QQCeVb6g/mFbDoi/aMn32y/xIN07z3MYJ3QoxngedTb14tt4WtsASUFIX+iMkX/mGbkX0/vzmZ3+dFQYFxEyvPxVIroZuNjA0yC9l4Jyd1pCq4XvjGx4Ri3BaptMh/vuGJwtdYF2Penml31C5T0nNLfJU9NGXb3HPed/3G5DXnC7EpwKwR5snpKhuHE/waCoJou63UjxL1zxAI+kMpsJ5vtmPfkkbgyVotzYVvI10F3CxXaD34PQtK9iqsGG+7dOmqSoRj6FJ2sHRM6jOe5IoE9812o7jR8GZE7CJ5/+t66eW2pa7vzYlL6Q7msm6oli1kYC3zMrHDoGH8Y8Kuomx5tqKqKWTCyCxDiurk1V5/3V7rOyh9RW/na7BqUPDDjVwg2+uqBMAWLXsi0ngNNHB4iT2zOVWMztjPj2JxIOB429ZEjIVGIhjLJ6MqTBNNUgkKYKWY3oFTacWB5kdnNn8DDD2JcWKJF6hEDdKB63Iv7yBclL4JTBHj6ol+oMXQ5c/yJKp0DqEUlnoRUZD9zd0A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199015)(478600001)(36756003)(4326008)(8676002)(66476007)(66556008)(66946007)(41300700001)(110136005)(316002)(6486002)(38100700002)(6512007)(53546011)(2616005)(6506007)(31696002)(5660300002)(186003)(31686004)(83380400001)(2906002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkNweUhvMytzODMvNmcrV2tkK2RpTCsxQkNEVnFmT25jL2Rib0xHcVRQUjU1?=
 =?utf-8?B?QWVDcEE1dlJLQkY1S2pCUUljNXQydk84SG5CaTRMclpTTFhaOFBXN3ZtRU44?=
 =?utf-8?B?UTNNd3I1L0RsbkRHRDRFZ1RybzIzVmdtZVMzRTNKK0lIcTJ5NWxCQ0d0V0FC?=
 =?utf-8?B?SHZkL0Y2T1FFRTEvL3Ayc05tc2E1OFA4RVRSVVdOS0RlaU1wNU5qemg5V2Uz?=
 =?utf-8?B?QTZiNk1TMklEUlR0MjRvVWpmeDhERTF1cFBIUjdKbVloM1ZQcXBKakdFYjBu?=
 =?utf-8?B?d3V5bmFabTc5RDdZSldmZEtVSEtoVms2ak9EM3NmZnpvcGgwdkUvbjA5dFF6?=
 =?utf-8?B?T0kvcmJXWjhlc0pVd0t5dG5nS01uNExFUzZtREQrRnEyL3ozTlpMRmZQQTFK?=
 =?utf-8?B?cWVNVi81cTJmRkJ4ZGE4Tzk2ZU1pc1M5ZUpEQXZSUXJsemN1VkZoajdINVFr?=
 =?utf-8?B?aUk3TS9UWWYzQ2xKYUszY0FhbWNYM01tSjJqUkY3NE9YVjVLaWtVTC93OWNO?=
 =?utf-8?B?RXIvbDRObmxaTXBtT0FOU0pnNUJES0E2YkwvUStxc1djcmpSb2FISVh2TDFt?=
 =?utf-8?B?R1ZvaTVzQVNlcS9tZ3hNazVReTRMUTltM0hPVDFPOHlDdUJha1hJSWJuSW94?=
 =?utf-8?B?dGx6Y3dCL0M2dVpzdS9NbU1zaHFBMHV2elZOMGo0R09ZK0V4dXFGRVFNSTdl?=
 =?utf-8?B?ZGQrTHdnQUcvMHFyK0N6VzV5M2oyVXNsa0VOK3lxeUs3SWd2UnB1b0Frd3JB?=
 =?utf-8?B?Mis2QTIrWU1ac2RiUE1VS2tJdW04cW92SS9SWGxGazVtK1hPb0JaWlFVVWhj?=
 =?utf-8?B?WEdMTGJyUXhqaDVRbE8rVEJ6QXpOQ1Boc0ZQVFVvbmRhTWgwMVRlV1lLNWNJ?=
 =?utf-8?B?ek5yOXl1VFpDRkxjYnVtWGhVNFhzVVpZZWJtdk0vOHExWjZITUZjWWhkdTlq?=
 =?utf-8?B?blE4Z3VSQmQ1NjhyQ3ltVzgxR0I3QWlySUsvNW1GRDUzNkhvRk1wbi9Va3RZ?=
 =?utf-8?B?YnZHL1U1NVp2UmdVN1IwYnVlQTBXaytITlcrVVR4bmYzdEQ5clRzb3lLeTBh?=
 =?utf-8?B?cmhZS2VtK1hXSU5GSDkvNTFDd3VDWGZCTVlLMUtTak5Za1FuUzhoRDROSTBP?=
 =?utf-8?B?dE10WnFlSmxMOStFUzRFbnpwKzlSSGkzNkxMakZ6a1BocUJJcllhVGpDdllL?=
 =?utf-8?B?K2doNURKWXM0bDUwZGhRUXYxSnhqcVNPSVNaREVQc2pML2I2Mlg0UzdhajRK?=
 =?utf-8?B?dlNucjVMTWo4c2YzQnFhMVJZREkxUEpNeWduWjdnN25tUjhWcFU3a2ljWlhx?=
 =?utf-8?B?THQyUDJFdlEvS2xVVmY3VElPVnhwWkN0SjRGQ25rZVl6MmNyYmN2aE15dkZO?=
 =?utf-8?B?OURJcmdyaHoxVnRFbzNya0xWMFptQVFDc2Z4QlduZWxMbWo3WkVuTzJGU2hh?=
 =?utf-8?B?N1Rac25KSzBCckVKeXJzeDF1eTIvZFpVRXhSbXh1bC9Xait3UFdrbGxwS2Vy?=
 =?utf-8?B?dnhDUG8rbWdaNWl3MGJPN295YTFVZ1lIS1A4WnUrV29vS2Q5cFZBeDhjcVZ4?=
 =?utf-8?B?RlRQYWtpUG53dGhYR0hETFByQ1F0dmN0YmFQUWswY0hIbVRrOW15amI0V012?=
 =?utf-8?B?eFdHRmsrVkx1UlhUdVZKVTdINUxwd0ZtZEFNZ1pCd0FubUtkQjQ1N2h4aHY1?=
 =?utf-8?B?eGFFeU5nVHF5MWRsSE9RdnJpTHlJaWZ5dFMrWko4Znc4T3JST2JQa0tRZTF0?=
 =?utf-8?B?eDBOR0J2VTArRnpkWEJkYTg1dTN2VlJvbG9sa0JTUHl2dkcweEc5MEJ6SnNF?=
 =?utf-8?B?Ty9NNWoxRUY1bXlua0ptQytHWHdVSWpTUjVFUTBMT0lldkhhdjl1MjVoUVBa?=
 =?utf-8?B?SXpzTGRnK2NHVXBCNnhhU3FIV1gzWHZ3Q3F4RVlHL1pJZStCaTlFb1FMWVRB?=
 =?utf-8?B?L3RVU0pjSUpJRXNlLzh6ZjUyR09ZYTNiekZrQkVkdUh4dkhiMU5SYWpsTklB?=
 =?utf-8?B?U09MbG56Z3FaZUJXdUdacGwwYVlmZlV3UWNGNmpheDQ2K1ZBVTRvQVdKNEly?=
 =?utf-8?B?OHVEcjFoR1BSMjAyaURhLzMraTdzYW9FQzVrTzF3UnE5NHJ5cWYwNmpWQS95?=
 =?utf-8?B?Y0tNRXl6TmhtcG1UQXVndEt4MGplU2F6UCtWcjFSWjZobTlKTkJraExubDEz?=
 =?utf-8?Q?RFvooKMV4zrjkW2PiKKEJBtXk3AlmI0enx7R3Oc9N+05?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0c9890-ece7-4cdd-461b-08daf7e92e3d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 17:43:30.3117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgzMfMFRoYI4V22Vo3NoXo3HuR9tAuXLYn6VOINKYo2Een8WT76mzNomBSmE2dj3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4531
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/15/23 6:38 AM, Krzysztof Kozlowski wrote:
> On 13/01/2023 19:08, Tanmay Shah wrote:
>> On 1/12/23 11:52 PM, Krzysztof Kozlowski wrote:
>>> On 13/01/2023 08:30, Tanmay Shah wrote:
>>>> This patch introduces bindings for TCM memory address space on AMD-xilinx
>>>> platforms. As of now TCM addresses are hardcoded in xilinx remoteproc
>>>> driver. This bindings will help in defining TCM in device-tree and
>>>> make it's access platform agnostic and data-driven from the driver.
>>>>
>>> Subject: drop second/last, redundant "bindings". The "dt-bindings"
>>> prefix is already stating that these are bindings.
>> Ack.
>>
>>
>>> Where is driver or DTS? Are you now adding a dead binding without users?
>>
>> TCM is used by drivers/remoteproc/xlnx_r5_remoteproc.c driver. Howerver,
>> we have hardcode addresses in TCM as bindings are not available yet.
> I don't see usage of these compatibles there. You also did not supply
> DTS here. Please provide users of bindings within the same patchset.


ACK. I will supply dts as well.

However, Is it ok if I convert this patch to RFC patch, and once 
bindings are fixed I will send actual patch with driver support.

If bindings design is not correct then I might have to change 
corresponding driver design lot.


>
>
> Best regards,
> Krzysztof
>
