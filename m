Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BB8668E73
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbjAMG4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240190AbjAMGy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:54:58 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018B86F964;
        Thu, 12 Jan 2023 22:40:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuEZD5G5SqGtMQzvK7tXyWRJK8f05OED1WuTrHsABHmShHMbQKiiHSMbNRkESIh9h2cUqKBq2bWNXPTlVz/pwAEuHPaLG++or/dsi8R8Qeq9v7ISurqfrMiY0pT6MQ9U+tGB51OE9tyL0irJ7pc1PnfWKOmWVAKZAO3mZyWCvEgQ+FNDaQf2Z6Ai4K4pwx7+yVGIYtqjAePT1odzHNgNf+WKnKdKLJl9uxhceKs2Ap5MHFH3eYWIqiDqNnnRS7JSOwxeVE47PSZWOC2cweIL6nZSgAAgVlMbV81ECAzCn8fUBk7EnFhGDkng73W1rKyGbzvglPpDxq906dTjLFyjtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tl8Qarz7pjoWT9sRG820pws/ttbMYmYUkaLKrEsH/ec=;
 b=lrVqFRwewYb4tsxcEGmJjHsAXisBfqLU4r1jMMgGhlp+6CIxoo9ZhE4OT8fS5FSFE8a7j1Awct+tkcO0+DtDEvsGDb7Wohl29Emkgt1AEKUPpN7dctKQhciTu4BDDYe4E74f1icFsTorjXT1L42MvrO8xU9Hv+WiF3HMndAXwpg2Hok1jncwHhuPI/fzB9JGYUfgFOPnTUzHwXaO6le/5OvP+xlrtQesyspwmtpQ0Za7BdcFJofl6pm7R591eiJGvLv4PzUPH4IuHRlnsUZJHTg5epGlJhcxTS3FDeFG6YbZm9BUq2eU5LzfglcB69Z+vIQCK+dUxagZAnt3rahdRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tl8Qarz7pjoWT9sRG820pws/ttbMYmYUkaLKrEsH/ec=;
 b=oe/dR6LfGFZwbIb3cbRyIEBAhTykdQY1fnGDJ9tV2C7R+d7VEFbgK0dTuTNF85bqg8xUUX6W1rrNRTky3N8a/Mf5FAorxMh4QSLs4q69/7+in4/HRj4wmgMZTgyUgAqjT1Qz9tWrYHDCQ72Q0hmvXEXGugTfwrdwa6jY5wXeVAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 06:40:01 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 06:40:00 +0000
Message-ID: <d6bfe70c-fde9-2412-967d-2aa90ba6f61b@amd.com>
Date:   Fri, 13 Jan 2023 12:09:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 6/6] Documentation: amd_pstate: Update amd_pstate
 status sysfs for guided
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, Perry.Yuan@amd.com,
        Ananth Narayan <ananth.narayan@amd.com>, gautham.shenoy@amd.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        santosh.shukla@amd.com
References: <20230113052141.2874296-1-wyes.karny@amd.com>
 <20230113052141.2874296-7-wyes.karny@amd.com>
 <7e4d2d86-ea95-6d4b-1279-18407787306b@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <7e4d2d86-ea95-6d4b-1279-18407787306b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::14) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|MN0PR12MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: e137b7a5-69d6-4412-bfc8-08daf530fe4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5BR1g1Q+Q0VNNyWykS+hc58bgO6kpsXaEOe0beuiJ9PYcyAthvZs7/TwOImVzkY8bNwC0I2eObpycovr/lvzN3AjXPCCPdbPohxX6fziz2K+DLau5fJVB4f7rupmXy1W9DFGF33VfYgtj8oABg2B7C9VSFKp6OPmJs91fyJAVfvwUtOgrtwReJwIH3jp/4fRBin8MaEu0aGTdxikMe3jUM3Ul9fGxZEGMJaohuMnhuuFnH7V+lMYsp8OpfT3agXi+zcE5Q53RWYsapOmQeZauisSW70y/xrxzqTNox1sCMlhJ970SodPnlL8GsJmGcxJI6l/wKxldXxGjJXVdZsRNBpoxedsXLyM9gWVHIHTTGIbJ1MF85+TQEq0pfcaLl4QZFd279mfWIzkTOpmX6ipUDq9GjhMYeusxlJUrFqB3ZUVAIdi1NCLJBpNTkmlG+vnV9+czbwwft04p8aPOSGNVtCF1Xk1Vr2Hyn5L5HIHe42X0n2IgmLdWukSYnaAzH0Ql1DxtbNYJFPjDKzX+Kriil+1aXdyDm78z6Y1U33sEETJbzIlwfugzLycoNT0OImA9r2lQ/7Jb/+dep2VlVPHWv878WxOKd1Thuk+241LtcpcPxRF+WenxPiynXdjlzB/I9Z5TsqhpgDptjhIWBVeWfESc0dUozFGAkKyj/3GXuodRmM4Lm9hC5Bt0aq35xxt0d2N6zf0w/P1r+WRdK7UXwfWYtyOnULFJMRqUpikd+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199015)(8676002)(83380400001)(2906002)(8936002)(31696002)(38100700002)(4326008)(44832011)(5660300002)(66946007)(66476007)(110136005)(6486002)(186003)(53546011)(6666004)(6506007)(26005)(2616005)(6512007)(41300700001)(6636002)(66556008)(478600001)(316002)(86362001)(15650500001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amc1d0dYL3Vhdk9QRjdqaWtSeXhibmdkV0d5d0Z4OVNxdHpJbUtKTzlONURz?=
 =?utf-8?B?NWpRdzIrNStVWWpOMDRveTNESFNsdzMwd01LWXF3enl3bmIrR3Q2MjlHS1Aw?=
 =?utf-8?B?SksyclRxTEVkMWFQMmtKZW80cGpYRXJBdjlTejhZSkpwY0pxelJ5RThEeGdJ?=
 =?utf-8?B?WFEyOVpCSWJOWFBMRDAzc2NGaEVVT3RiMSthZ2ltcjNkYVVyTU5QelEwU1do?=
 =?utf-8?B?UkFkUU9malFVdDkrdkw1TmJ3MkdqbXpNcHJHOUpmRUJlR1Q2dXdKMi9XL2pN?=
 =?utf-8?B?YmZ4LzlYai9XNmJzTVRUREI0ZzBBbTJjVWRQOFVFTVYveCtmdldWL2lBWVBx?=
 =?utf-8?B?RXVkbjFlQ2RrU1FxYUI2UXJmcmQ5SXdMejdDOUxnVmZyN3NaOXFnMmwrbnhH?=
 =?utf-8?B?SjhURmsyTkpZRUpHeGNDaGcxRlQ4RUdjM25RaWo4ck5UQWhrdVduNWVpWnBn?=
 =?utf-8?B?eTBZN3M4SXRYUlNEcDhLeXdtYmZQd1BVQjF1RXE1R2ZZRnFqU0FJRjZ1RXFK?=
 =?utf-8?B?dDg4VUVERThSSGNTOHhqNCtDMXZLN1VzazFUVlhkV3BpR0oybXpnR2w0bTRx?=
 =?utf-8?B?U2ZXRzgrNXVWYUFZUEFnb1RydFFwQVlVTFNRN05iS0Q3alVlbnlFb3dzejJm?=
 =?utf-8?B?YkF2YjJuTFVDN0VJaW50N1d0SEZId1Q1Q0tvamdqbTFWbXpPYTRMT2NZbnVy?=
 =?utf-8?B?NTQ2aG5VTnpnM0tFQ1JqalVoZ1VKb0U2VFc1UWpNbjh2dncwcGM4cFpVZm91?=
 =?utf-8?B?cWl2MXpLU3NUSEcrVm5kTXBITm9FQzhXd05KbmJqMmZ1L0dhb1Z4dGNCZWR6?=
 =?utf-8?B?VmRKU1FJYW90WlVNZVphemJ3NVdaL1hhb2NTaXBEZ05KM09wQXpKOUFXRGZa?=
 =?utf-8?B?azV6cnNlTE52ckRZMy9LK0w3VHRWVENzK0dvL1QxQVEvZzlnLzVYREd3dEgx?=
 =?utf-8?B?TTdIZXE4QzhHb3R4ZXlLcVhteGF3bUViZmltQmZOVER1enZ0WUhZZEtmMTkv?=
 =?utf-8?B?dHh0dmY3Rm5pMGpDeXhCalRZeU5oNGl2SWd6ajg1Qmw2eVNDWTdGT1BCQ2Mw?=
 =?utf-8?B?VWNySGxPdldKczJxbEd4RmVJbWw1RDY4OVp0Ky9POWtMdldkMmpWaHMrVmNu?=
 =?utf-8?B?dUZFTEhNV1pwNmN6aHhiL3JNQmNPWFI5TnFtK3g3U3V1MzJiRGw0ejRPZEYr?=
 =?utf-8?B?NTFZaUs1N21wYlQ1c0FhcHVwY3pHdEVKMXplelNqSTBYUnFYWGV5cTVzRjZX?=
 =?utf-8?B?YUFwckZUdTg4VnAvWFlWejA0OC9vR095YWg5RGZib29JbjRYdUVvL0ZPYllx?=
 =?utf-8?B?L21UTUNNaTkzTFRLTXJlTDJFRnpJbGRZYzdzSGRqSDA4YjNkNGJJOUJvaTY4?=
 =?utf-8?B?UEtTL2hrR0l2QnhSZTZsNloyeTByWGVINHVEV0V3MHhmQW9VR2xtMUtOZUFh?=
 =?utf-8?B?WlJJOEVCT1QzeDFkZzR3TDhxN0RwWGYySHRjSHE0alRWdkFiZHkwem9sVU1N?=
 =?utf-8?B?bUUvN0xYbkxQdmJ6QVhHYkI0Rm81K2x3bHo3YnpodnBXdlZSYmNjcDVMeVNs?=
 =?utf-8?B?MTZpUGlHdFppb0N4WHpleHlSSFhkYjlNeW5TWmY3dVhSc0IrN2NtNm94OXdB?=
 =?utf-8?B?SVZZaUpsZjdCc1Y4NmJEczFjOVVpd3lzM0JjaEh0ekU0VE90U1FFRkpOSG1y?=
 =?utf-8?B?c1AwZkZFaXBZK1NhUURWMW5yeW9yUkw5cHk2RGwvWWpIZGVGKzNwcDhDcEF1?=
 =?utf-8?B?TElQTlJxYkE5NWljQTlWUlVjSThabEYyalFCSzRLRlZaU0JraWJ1dGlQeEVJ?=
 =?utf-8?B?eTNneHVGV2x5SGMwNWNqRkt0QTJjaHBBUTQrbFdCMzhHV2VSdFd1b2VvWm5k?=
 =?utf-8?B?cWtTaHQvcTl5NjFzMk45TzRLTE9CTStYTGNHOUJvZExvM2p1bm56VWI1Vm04?=
 =?utf-8?B?UU5LVWFLYldpakJNNU83amJ5ekdNaWFSUnNVSTV6RjZ3N1N5amRsUU9FWkVi?=
 =?utf-8?B?bnBvTW16QllVQTBVQ3lycER4L25RSWhSSUpYUGI3VzU4Njd6ZUtacWVUZ1Vm?=
 =?utf-8?B?OW1VeGpTR3VRSWFyRVBJd1BCL1lqVXpBKzFkdEMyT1ZiSVRiSi8rL1ZyQlpM?=
 =?utf-8?Q?nWWqQiwIv7GowhbBniCGCYl4+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e137b7a5-69d6-4412-bfc8-08daf530fe4f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 06:40:00.4127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXTwqMR3DKsI1j24940w6tjhKYislj8DSRfml6AnGNud8BM2iDQFWjRFXnqJiHqJhAWwKUgmBGkB5UVJF619WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/2023 11:20 AM, Mario Limonciello wrote:
> On 1/12/23 23:21, Wyes Karny wrote:
>> Update amd_pstate status sysfs for guided mode.
>>
>> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
>> ---
>>   Documentation/admin-guide/pm/amd-pstate.rst | 29 ++++++++++++++++-----
>>   1 file changed, 22 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
>> index 55396981266a..92fa22e45a2b 100644
>> --- a/Documentation/admin-guide/pm/amd-pstate.rst
>> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
>> @@ -303,13 +303,16 @@ efficiency frequency management method on AMD processors.
>>   AMD Pstate Driver Operation Modes
>>   =================================
>>   -``amd_pstate`` CPPC has two operation modes: CPPC Autonomous(active) mode and
>> -CPPC non-autonomous(passive) mode.
>> -active mode and passive mode can be chosen by different kernel parameters.
>> -When in Autonomous mode, CPPC ignores requests done in the Desired Performance
>> -Target register and takes into account only the values set to the Minimum requested
>> -performance, Maximum requested performance, and Energy Performance Preference
>> -registers. When Autonomous is disabled, it only considers the Desired Performance Target.
>> +``amd_pstate`` CPPC has 3 operation modes: autonomous (active) mode, guided
>> +autonomous (guided) mode and non-autonomous (passive) mode.
>> +Active/passive/guided mode can be chosen by different kernel parameters. In
>> +autonomous mode, platform ignores the desired performance level request and
>> +takes into account only the values set to the Minimum requested performance,
>> +Maximum requested performance and Energy Performance Preference registers. In
>> +non-autonomous mode, platform gets desired performance level from OS directly
>> +through Desired Performance Register. In guided-autonomous mode, platform sets
>> +operating performance level autonomously according to the current workload and
>> +within the limits set by OS through min and max performance registers.
> 
> Your intro and explanation go in different orders.  Also this reads very dense.  Maybe it would make sense to put some whitespace between each mode?

Yes, will try to make this easy to read.

> 
>>     Active Mode
>>   ------------
>> @@ -338,6 +341,15 @@ to the Performance Reduction Tolerance register. Above the nominal performance l
>>   processor must provide at least nominal performance requested and go higher if current
>>   operating conditions allow.
>>   +Guided Mode
>> +-----------
>> +
>> +``amd_pstate=guided``
>> +
>> +If ``amd_pstate=guided`` is passed to kernel command line option then this mode
>> +is activated.  In this mode, driver requests minimum and maximum performance
>> +level and the platform autonomously selects a performance level in this range
>> +and appropriate to the current workload.
>>     User Space Interface in ``sysfs``
>>   =================================
>> @@ -358,6 +370,9 @@ control its functionality at the system level.  They are located in the
>>       "passive"
>>           The driver is functional and in the ``passive mode``
>>   +        "guided"
>> +                The driver is functional and in the ``guided mode``
>> +
>>       "disable"
>>           The driver is unregistered and not functional now.
>>   
> 

-- 
Thanks & Regards,
Wyes
